"""Prepare or run real-agent evaluation cases. No default model backend or API calls."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile


def child(root, relative):
    path = root / relative
    if Path(relative).is_absolute() or '..' in Path(relative).parts or not path.resolve().is_relative_to(root.resolve()):
        raise ValueError('Fixture path escapes evaluation workspace')
    return path


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest() if path.is_file() else None


def snapshot(workspace):
    result = {}
    for path in workspace.rglob('*'):
        # Detect directory links before rglob descends into the next iteration.
        child(workspace, str(path.relative_to(workspace)))
        if path.is_symlink() or (hasattr(path, 'is_junction') and path.is_junction()):
            raise ValueError('Linked evaluation artifact is unsupported')
        if path.is_file():
            result[path.relative_to(workspace).as_posix()] = digest(path)
    return result


def verify(workspace, case, result, before):
    outcomes = []
    for name in case.get('preserve', []):
        path = child(workspace, name)
        outcomes.append({'assertion': 'preserve:' + name, 'passed': digest(path) == before[name]})
    for item in case.get('files', []):
        path = child(workspace, item['path'])
        content = path.read_text(encoding='utf-8') if path.is_file() else ''
        passed = path.is_file() and all(v in content for v in item.get('contains', []))
        passed = passed and all(v not in content for v in item.get('excludes', []))
        outcomes.append({'assertion': 'file:' + item['path'], 'passed': passed})
    for field, expected in case.get('result_fields', {}).items():
        outcomes.append({'assertion': 'result:' + field, 'passed': result.get(field) == expected})
    if 'allow_changes' in case:
        after = snapshot(workspace)
        original = before['__files__']
        changed = {p for p in set(original) | set(after) if original.get(p) != after.get(p)}
        unexpected = [p for p in changed if not any(p == allowed or (allowed.endswith('/') and p.startswith(allowed))
                                                   for allowed in case['allow_changes'])]
        outcomes.append({'assertion': 'allowed-change-scope', 'passed': not unexpected})
    if 'questions_min' in case:
        questions = result.get('asked_questions')
        valid = isinstance(questions, list) and len(questions) >= case['questions_min'] and all(isinstance(q, str) and q.strip() for q in questions)
        outcomes.append({'assertion': 'necessary-question-present', 'passed': bool(valid)})
    if 'oracle' in case:
        # The oracle is packaged outside the evaluated workspace, not supplied by the runner.
        run = subprocess.run([sys.executable, '-I', '-c', case['oracle'], str(workspace)], capture_output=True, timeout=20)
        outcomes.append({'assertion': 'independent-oracle', 'passed': run.returncode == 0})
    if not outcomes:
        raise ValueError('Evaluation case needs observable assertions')
    return outcomes


def run_case(case, runner=None, timeout=180):
    workspace = Path(tempfile.mkdtemp(prefix='skill-eval-'))
    for name, content in case['setup'].items():
        path = child(workspace, name)
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding='utf-8')
    before = {name: digest(child(workspace, name)) for name in case.get('preserve', [])}
    if 'allow_changes' in case:
        before['__files__'] = snapshot(workspace)
    # Task and result artifacts live outside the workspace and survive for review.
    artifacts = Path(tempfile.mkdtemp(prefix='skill-eval-artifacts-'))
    request = artifacts / 'request.json'
    output = artifacts / 'result.json'
    request.write_text(json.dumps({'id': case['id'], 'skill': case['skill'], 'request': case['request']}, ensure_ascii=False), encoding='utf-8')
    report = {'id': case['id'], 'workspace': str(workspace), 'artifacts': str(artifacts)}
    if not runner:
        return dict(report, status='prepared', reason='No real-agent runner configured; behavior was not executed')
    replacements = {'{workspace}': str(workspace), '{request}': str(request), '{result}': str(output)}
    argv = [replacements.get(token, token) for token in runner]
    try:
        run = subprocess.run(argv, capture_output=True, timeout=timeout, shell=False)
        # Raw output is deliberately not persisted: it may contain credentials/private data.
        if run.returncode != 0 or not output.is_file():
            return dict(report, status='blocked', reason='Runner failed or did not produce its result artifact')
        result = json.loads(output.read_text(encoding='utf-8'))
        if not isinstance(result, dict) or not isinstance(result.get('runner_identity'), str) or not result['runner_identity'].strip():
            return dict(report, status='blocked', reason='Runner identity missing')
        assertions = verify(workspace, case, result, before)
        return dict(report, status='passed' if all(a['passed'] for a in assertions) else 'failed',
                    runner_identity=result['runner_identity'], assertions=assertions)
    except (OSError, ValueError, subprocess.TimeoutExpired):
        return dict(report, status='blocked', reason='Invalid result, unavailable runner, unsafe artifact or timeout')


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cases', default=str(Path(__file__).resolve().parents[1] / 'references/scenarios.json'))
    parser.add_argument('--runner-config', help='JSON argv array; launching it is an explicit user-authorized runner operation')
    parser.add_argument('--output', required=True, help='New report path; existing reports are preserved')
    parser.add_argument('--timeout', type=int, default=180)
    args = parser.parse_args(argv)
    try:
        destination = Path(args.output)
        if destination.exists() or destination.is_symlink():
            raise ValueError('Report already exists; choose a new path')
        runner = json.loads(Path(args.runner_config).read_text(encoding='utf-8')) if args.runner_config else None
        if runner is not None and (not isinstance(runner, list) or not runner or not all(isinstance(x, str) for x in runner)
                                   or not {'{workspace}', '{request}', '{result}'} <= set(runner)):
            raise ValueError('Runner must be an argv array with workspace/request/result tokens')
        cases = json.loads(Path(args.cases).read_text(encoding='utf-8'))
        reports = [run_case(case, runner, args.timeout) for case in cases]
        report = {'version': 1, 'mode': 'real-runner' if runner else 'prepared-only', 'cases': reports}
        destination.parent.mkdir(parents=True, exist_ok=True)
        with destination.open('x', encoding='utf-8') as handle:
            json.dump(report, handle, ensure_ascii=False, indent=2)
            handle.write('\n')
        print(json.dumps({'mode': report['mode'], 'report': str(destination), 'statuses': [r['status'] for r in reports]}))
        return 0 if not runner or all(r['status'] == 'passed' for r in reports) else 1
    except (OSError, ValueError, KeyError, TypeError):
        print('Evaluation configuration failed; preserve existing reports and inspect input', file=sys.stderr)
        return 2


if __name__ == '__main__':
    sys.exit(main())
