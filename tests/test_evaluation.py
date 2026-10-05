"""Harness/oracle tests. These deliberately do not claim model behavior evaluation."""
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / '.agents/skills/skill-evaluation/scripts/evaluate.py'
spec = importlib.util.spec_from_file_location('evaluation', SCRIPT)
evaluation = importlib.util.module_from_spec(spec)
spec.loader.exec_module(evaluation)
CASES = json.loads((SCRIPT.parent.parent / 'references/scenarios.json').read_text(encoding='utf-8'))


class EvaluationTests(unittest.TestCase):
    def test_no_runner_is_prepared_not_passed(self):
        result = evaluation.run_case(CASES[0])
        self.assertEqual(result['status'], 'prepared')
        self.assertTrue(Path(result['workspace'], 'calc.py').is_file())

    def test_external_oracle_detects_real_bug(self):
        with tempfile.TemporaryDirectory() as location:
            root = Path(location)
            for path, content in CASES[0]['setup'].items():
                (root / path).write_text(content)
            before = {'user-notes.txt': evaluation.digest(root / 'user-notes.txt')}
            outcomes = evaluation.verify(root, CASES[0], {}, before)
            self.assertFalse(next(x['passed'] for x in outcomes if x['assertion'] == 'independent-oracle'))
            (root / 'calc.py').write_text('def total(price,count):\n    return price*count\n')
            self.assertTrue(all(x['passed'] for x in evaluation.verify(root, CASES[0], {}, before)))
            (root / 'user-notes.txt').write_text('discarded')
            self.assertFalse(all(x['passed'] for x in evaluation.verify(root, CASES[0], {}, before)))

    def test_unsafe_fixture_path_rejected(self):
        with tempfile.TemporaryDirectory() as location:
            with self.assertRaises(ValueError):
                evaluation.child(Path(location), '../outside')

    def test_missing_runner_result_is_blocked(self):
        result = evaluation.run_case(CASES[1], [sys.executable, '-c', 'pass'])
        self.assertEqual(result['status'], 'blocked')

    def test_false_runner_success_cannot_defeat_file_oracle(self):
        with tempfile.TemporaryDirectory() as location:
            runner = Path(location) / 'fake_runner.py'
            runner.write_text("import json,sys; json.dump({'runner_identity':'test-double-only'},open(sys.argv[1],'w'))")
            result = evaluation.run_case(CASES[0], [sys.executable, str(runner), '{result}'])
            self.assertEqual(result['status'], 'failed')
            self.assertEqual(result['runner_identity'], 'test-double-only')

    def test_timeout_is_blocked(self):
        result = evaluation.run_case(CASES[1], [sys.executable, '-c', 'import time; time.sleep(5)'], timeout=0.1)
        self.assertEqual(result['status'], 'blocked')

    def test_readonly_case_catches_unreported_new_product_file(self):
        with tempfile.TemporaryDirectory() as location:
            root = Path(location)
            (root / 'calc.py').write_text('original')
            before = {'calc.py': evaluation.digest(root / 'calc.py'), '__files__': evaluation.snapshot(root)}
            (root / 'new-product.py').write_text('unexpected')
            result = evaluation.verify(root, CASES[1], {'product_changed': False}, before)
            self.assertFalse(next(x['passed'] for x in result if x['assertion'] == 'allowed-change-scope'))


if __name__ == '__main__':
    unittest.main()
