"""Check generation drift, preservation and refusal of unexpected resources."""
import importlib.util
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('adapters', ROOT / 'tools/generate_adapters.py')
adapters = importlib.util.module_from_spec(spec)
spec.loader.exec_module(adapters)


class AdapterTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='adapter-tests-')
        self.root = Path(self.temp.name)
        shutil.copytree(ROOT / '.agents/skills', self.root / '.agents/skills', ignore=shutil.ignore_patterns('__pycache__', '*.pyc'))
        (self.root / 'core').mkdir()
        for name in ['skill-contract.md', 'stack-profiles.md']:
            shutil.copy2(ROOT / 'core' / name, self.root / 'core' / name)
        for name in ['AGENTS.md', 'CLAUDE.md', 'GEMINI.md']:
            shutil.copy2(ROOT / name, self.root / name)

    def tearDown(self):
        self.temp.cleanup()

    def test_generation_is_stable_and_drift_check_is_readonly(self):
        with patch.object(adapters, 'ROOT', self.root):
            self.assertEqual(adapters.main([]), 0)
            before = {p: p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
            self.assertEqual(adapters.main(['--check']), 0)
            self.assertEqual(adapters.main([]), 0)
            self.assertEqual(before, {p: p.read_bytes() for p in self.root.rglob('*') if p.is_file()})
            script = self.root / '.antigravity/skills/project-context/scripts/task_state.py'
            script.write_text('drift')
            self.assertEqual(adapters.main(['--check']), 1)
            self.assertEqual(script.read_text(), 'drift')
            self.assertEqual(adapters.main([]), 0)
            self.assertEqual(script.read_bytes(), (self.root / '.agents/skills/project-context/scripts/task_state.py').read_bytes())

    def test_user_specialist_content_survives_contract_generation(self):
        source = self.root / '.agents/skills/feature-delivery/SKILL.md'
        source.write_text(source.read_text(encoding='utf-8') + '\nUser-specific workflow note.\n', encoding='utf-8')
        with patch.object(adapters, 'ROOT', self.root):
            self.assertEqual(adapters.main([]), 0)
        self.assertIn('User-specific workflow note.', source.read_text(encoding='utf-8'))
        self.assertIn('User-specific workflow note.', (self.root / '.antigravity/skills/feature-delivery/SKILL.md').read_text(encoding='utf-8'))

    def test_unexpected_adapter_files_are_not_deleted(self):
        extra = self.root / '.antigravity/skills/old-skill/unique.md'
        extra.parent.mkdir(parents=True)
        extra.write_text('unique')
        with patch.object(adapters, 'ROOT', self.root):
            self.assertEqual(adapters.main([]), 1)
        self.assertEqual(extra.read_text(), 'unique')

    def test_ambiguous_contract_markers_fail(self):
        with self.assertRaises(ValueError):
            adapters.rendered('No markers', 'contract')

    def test_linked_output_parent_cannot_escape_repository(self):
        outside = self.root / 'outside'
        outside.mkdir()
        link = self.root / '.antigravity'
        try:
            link.symlink_to(outside, target_is_directory=True)
        except OSError:
            self.skipTest('Symlink creation not permitted')
        with patch.object(adapters, 'ROOT', self.root):
            self.assertEqual(adapters.main([]), 1)
        self.assertEqual(list(outside.iterdir()), [])


if __name__ == '__main__':
    unittest.main()
