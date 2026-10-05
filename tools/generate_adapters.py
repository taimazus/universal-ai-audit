"""Generate checked-in adapters from .agents skills and canonical shared resources."""
import argparse
import json
import os
from pathlib import Path
import re
import sys
import tempfile
import stat

ROOT = Path(__file__).resolve().parents[1]
ORDER = ['project-context', 'task-orchestrator', 'project-builder', 'feature-delivery',
         'project-docs', 'enterprise-audit', 'security-audit', 'pr-review', 'bug-investigation',
         'test-gap-analysis', 'test-engineering', 'audit-remediation', 'audit-fix-loop',
         'performance-lab', 'migration-upgrade', 'ui-accessibility', 'operations-readiness',
         'project-cleanup', 'release-readiness', 'git-release-sync', 'skill-evaluation']
BEGIN = '<!-- BEGIN SHARED CONTRACT -->'
END = '<!-- END SHARED CONTRACT -->'


def safe_path(root, path):
    if not path.resolve().is_relative_to(root.resolve()):
        raise ValueError('Generated/source path escapes repository')
    current = path
    while current != root:
        if current.is_symlink() or (hasattr(current, 'is_junction') and current.is_junction()):
            raise ValueError('Linked generation paths are unsupported')
        if os.name == 'nt' and current.exists() and current.lstat().st_file_attributes & stat.FILE_ATTRIBUTE_REPARSE_POINT:
            raise ValueError('Reparse generation paths are unsupported')
        current = current.parent


def rendered(text, contract):
    if text.count(BEGIN) != 1 or text.count(END) != 1:
        raise ValueError('Missing or ambiguous shared-contract boundaries')
    start = text.index(BEGIN)
    finish = text.index(END, start) + len(END)
    return text[:start] + BEGIN + '\n' + contract.rstrip() + '\n\n' + END + text[finish:]


def products(root):
    contract = (root / 'core/skill-contract.md').read_text(encoding='utf-8')
    profile = (root / 'core/stack-profiles.md').read_bytes()
    source = root / '.agents/skills'
    names = {p.parent.name for p in source.glob('*/SKILL.md')}
    if names != set(ORDER):
        raise ValueError('Skill catalog and sources disagree')
    output = {}
    output[root / 'core/references/stack-guide.md'] = profile
    manifest = []
    for name in ORDER:
        folder = source / name
        path = folder / 'SKILL.md'
        safe_path(root, path)
        skill = rendered(path.read_text(encoding='utf-8'), contract)
        match = re.search(r'^name: (.+)\ndescription: (.+)$', skill, re.M)
        if not match or match[1] != name:
            raise ValueError('Invalid skill metadata: ' + name)
        manifest.append({'name': name, 'description': match[2]})
        output[path] = skill.encode('utf-8')
        for item in folder.rglob('*'):
            safe_path(root, item)
            if not item.is_file() or '__pycache__' in item.parts or item.suffix == '.pyc':
                continue
            relative = item.relative_to(folder)
            data = skill.encode('utf-8') if relative.as_posix() == 'SKILL.md' else item.read_bytes()
            if relative.as_posix() == 'references/stack-guide.md':
                data = profile
                output[item] = data
            output[root / '.antigravity/skills' / name / relative] = data
        if name == 'enterprise-audit':
            body = skill.split('\n---\n', 1)[1].lstrip('\n')
            output[root / 'core/enterprise-audit.md'] = body.encode('utf-8')
            output[root / '.cursor/rules/enterprise-audit.mdc'] = (
                '---\ndescription: Universal evidence-based enterprise audit\nalwaysApply: false\n---\n\n' + body).encode('utf-8')
            output[root / '.github/instructions/enterprise-audit.instructions.md'] = (
                "---\napplyTo: '**/*'\n---\n\n" + body).encode('utf-8')
    for name in ['AGENTS.md', 'CLAUDE.md', 'GEMINI.md']:
        path = root / name
        output[path] = rendered(path.read_text(encoding='utf-8'), contract).encode('utf-8')
    output[root / 'core/skills.json'] = (json.dumps({'version': 1, 'skills': manifest}, ensure_ascii=False, indent=2) + '\n').encode('utf-8')
    return output


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args(argv)
    try:
        output = products(ROOT)
        for path in output:
            safe_path(ROOT, path)
        different = [path for path, data in output.items() if not path.is_file() or path.read_bytes() != data]
        # Never silently delete obsolete resources from an adapter.
        extras = [p for p in (ROOT / '.antigravity/skills').rglob('*')
                  if p.is_file() and '__pycache__' not in p.parts and p.suffix != '.pyc' and p not in output]
        if extras:
            raise ValueError('Unexpected adapter resources; review manually: ' + ', '.join(str(p.relative_to(ROOT)) for p in extras))
        if args.check and different:
            print('STALE: ' + ', '.join(str(p.relative_to(ROOT)) for p in different), file=sys.stderr)
            return 1
        if not args.check:
            for path in different:
                if path.is_symlink():
                    raise ValueError('Refusing linked output: ' + str(path))
                path.parent.mkdir(parents=True, exist_ok=True)
                descriptor, temporary = tempfile.mkstemp(prefix='.adapter-', dir=path.parent)
                try:
                    with os.fdopen(descriptor, 'wb') as handle:
                        handle.write(output[path])
                        handle.flush()
                        os.fsync(handle.fileno())
                    os.replace(temporary, path)
                finally:
                    if os.path.exists(temporary):
                        os.unlink(temporary)
        print('PASS: generated adapter parity' if args.check else f'Generated {len(different)} files')
        return 0
    except (ValueError, OSError) as exc:
        print(str(exc), file=sys.stderr)
        return 1


if __name__ == '__main__':
    sys.exit(main())
