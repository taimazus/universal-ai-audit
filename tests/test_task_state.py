"""Exercise state invariants using real SQLite, processes and filesystem changes."""
import importlib.util
import json
import os
from pathlib import Path
import shutil
import sqlite3
import subprocess
import sys
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / '.agents/skills/project-context/scripts/task_state.py'
spec = importlib.util.spec_from_file_location('task_state', SCRIPT)
state = importlib.util.module_from_spec(spec)
spec.loader.exec_module(state)


def task(**changes):
    result = dict(goal='Repair fixture', scope='local fixture', status='active', acceptance=['negative case'],
                  decisions=[], changed_paths=[], checks=[], blockers=[], next_action='Run regression')
    result.update(changes)
    return result


def answer(**changes):
    result = dict(question='Which locale?', answer='fa', status='confirmed', source='user reply Q-1',
                  conditions={'environment': 'local'}, watch_paths=['config.txt'])
    result.update(changes)
    return result


class StateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='state-tests-')
        self.root = Path(self.temp.name)
        self.store = state.Store(self.root, create=True)

    def tearDown(self):
        self.store.close()
        self.temp.cleanup()

    def test_resume_and_revision_history(self):
        self.assertEqual(self.store.put('task', 'project', 'fix', task(), 0), 1)
        self.store.close()
        self.store = state.Store(self.root)
        self.assertEqual(self.store.get('task', 'project', 'fix')['data']['next_action'], 'Run regression')
        self.store.put('task', 'project', 'fix', task(status='complete', next_action=''), 1)
        self.assertEqual([x['data']['status'] for x in self.store.history('task', 'project', 'fix')], ['active', 'complete'])

    def test_conflict_preserves_winner_and_history(self):
        self.store.put('task', 'project', 'fix', task(), 0)
        with self.assertRaises(state.StateError):
            self.store.put('task', 'project', 'fix', task(goal='Overwritten'), 0)
        self.assertEqual(self.store.get('task', 'project', 'fix')['data']['goal'], 'Repair fixture')
        self.assertEqual(len(self.store.history('task', 'project', 'fix')), 1)

    def test_answer_reused_across_sessions_then_invalidated_by_file(self):
        (self.root / 'config.txt').write_text('old')
        self.store.put('answer', 'project', 'locale', answer(), 0)
        self.store.close()
        self.store = state.Store(self.root)
        self.assertEqual(self.store.lookup('project', 'locale', {'environment': 'local'})['answer'], 'fa')
        (self.root / 'config.txt').write_text('new')
        self.assertEqual(self.store.lookup('project', 'locale', {'environment': 'local'})['status'], 'stale')

    def test_missing_watch_file_creation_and_changed_conditions(self):
        self.store.put('answer', 'project', 'locale', answer(), 0)
        self.assertEqual(self.store.lookup('project', 'locale', {'environment': 'cloud'})['status'], 'stale')
        (self.root / 'config.txt').write_text('created')
        self.assertEqual(self.store.lookup('project', 'locale', {'environment': 'local'})['status'], 'stale')

    def test_assumption_and_task_scope_do_not_leak(self):
        self.store.put('answer', 'task-one', 'locale', answer(status='assumed'), 0)
        self.assertEqual(self.store.lookup('task-one', 'locale', {'environment': 'local'})['status'], 'assumed')
        self.assertEqual(self.store.lookup('task-two', 'locale', {'environment': 'local'})['status'], 'missing')
        self.assertEqual(self.store.lookup('project', 'locale', {'environment': 'local'})['status'], 'missing')

    def test_copied_store_rejected(self):
        other = self.root / 'other'
        (other / '.ai-work').mkdir(parents=True)
        shutil.copy2(self.store.path, other / '.ai-work/state.sqlite3')
        with self.assertRaises(state.StateError):
            state.Store(other)

    def test_future_version_preserved(self):
        self.store.db.execute("UPDATE metadata SET value='999' WHERE key='version'")
        self.store.db.commit()
        with self.assertRaises(state.StateError):
            state.Store(self.root, create=True)
        self.assertEqual(self.store.db.execute("SELECT value FROM metadata WHERE key='version'").fetchone()[0], '999')

    def test_invalid_and_secret_records_do_not_write(self):
        for data in [task(status='invented'), task(extra='field'), task(checks=[{'command': 'test', 'status': 'passed'}]),
                     task(decisions=['Bearer dummy-credential']), task(goal='sk-01234567890123456789')]:
            with self.subTest(data_keys=list(data)):
                with self.assertRaises(state.StateError):
                    self.store.put('task', 'project', 'fix', data, 0)
        self.assertIsNone(self.store.get('task', 'project', 'fix'))

    def test_false_completion_rejected(self):
        for data in [task(status='complete', blockers=['missing runner']),
                     task(status='complete', checks=[dict(command='test', status='blocked', summary='Unavailable')]),
                     task(status='complete', findings=[dict(id='F-1', status='unresolved', evidence='repro')])]:
            with self.assertRaises(state.StateError):
                self.store.put('task', 'project', 'fix', data, 0)

    def test_traversal_and_absolute_watch_paths_rejected(self):
        for path in ['../outside', str(self.root / 'config.txt')]:
            with self.assertRaises(state.StateError):
                self.store.put('answer', 'project', 'locale', answer(watch_paths=[path]), 0)

    def test_symlink_escape_rejected(self):
        link = self.root / 'linked'
        try:
            link.symlink_to(self.root.parent, target_is_directory=True)
        except OSError:
            self.skipTest('Symlink creation not permitted in this environment')
        with self.assertRaises(state.StateError):
            self.store.put('answer', 'project', 'locale', answer(watch_paths=['linked/data']), 0)

    def test_missing_read_does_not_initialize(self):
        empty = self.root / 'empty'
        empty.mkdir()
        run = subprocess.run([sys.executable, str(SCRIPT), '--root', str(empty), 'show', '--id', 'fix'], capture_output=True)
        self.assertEqual(run.returncode, 2)
        self.assertFalse((empty / '.ai-work').exists())

    def test_interrupted_transaction_rolls_back(self):
        self.store.put('task', 'project', 'fix', task(), 0)
        code = "import sqlite3,os,sys; c=sqlite3.connect(sys.argv[1]); c.execute('BEGIN IMMEDIATE'); c.execute('DELETE FROM records'); os._exit(19)"
        run = subprocess.run([sys.executable, '-c', code, str(self.store.path)])
        self.assertEqual(run.returncode, 19)
        self.assertIsNotNone(self.store.get('task', 'project', 'fix'))
        self.assertEqual(len(self.store.history('task', 'project', 'fix')), 1)

    def test_competing_processes_have_one_winner(self):
        data = self.root / 'task.json'
        data.write_text(json.dumps(task()), encoding='utf-8')
        args = [sys.executable, str(SCRIPT), '--root', str(self.root), 'checkpoint', '--id', 'fix', '--input', str(data), '--expect-revision', '0']
        workers = [subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE) for _ in range(2)]
        for worker in workers:
            worker.communicate(timeout=10)
        self.assertEqual(sorted(w.returncode for w in workers), [0, 2])
        self.assertEqual(len(self.store.history('task', 'project', 'fix')), 1)

    def test_busy_database_fails_without_partial_record(self):
        other = sqlite3.connect(self.store.path)
        try:
            other.execute('BEGIN IMMEDIATE')
            with self.assertRaises(sqlite3.OperationalError):
                self.store.put('task', 'project', 'fix', task(), 0)
        finally:
            other.rollback()
            other.close()
        self.assertIsNone(self.store.get('task', 'project', 'fix'))

    def test_invalid_saved_payload_is_not_reused(self):
        self.store.put('task', 'project', 'fix', task(), 0)
        self.store.db.execute("UPDATE records SET payload='{}' WHERE id='fix'")
        self.store.db.commit()
        with self.assertRaises(state.StateError):
            self.store.get('task', 'project', 'fix')

    def test_invalid_conditions_rejected(self):
        self.store.put('answer', 'project', 'locale', answer(), 0)
        with self.assertRaises(state.StateError):
            self.store.lookup('project', 'locale', [])

    def test_init_does_not_adopt_unrecognized_existing_database(self):
        other = self.root / 'other'
        (other / '.ai-work').mkdir(parents=True)
        path = other / '.ai-work/state.sqlite3'
        connection = sqlite3.connect(path)
        connection.execute('CREATE TABLE user_data (value TEXT)')
        connection.execute("INSERT INTO user_data VALUES ('unique')")
        connection.commit()
        connection.close()
        with self.assertRaises(state.StateError):
            state.Store(other, create=True)
        connection = sqlite3.connect(path)
        try:
            self.assertEqual(connection.execute('SELECT value FROM user_data').fetchone()[0], 'unique')
            self.assertEqual(connection.execute("SELECT COUNT(*) FROM sqlite_master WHERE name='metadata'").fetchone()[0], 0)
        finally:
            connection.close()

    def test_unicode_state_can_be_read_on_ascii_console(self):
        self.store.put('task', 'project', 'unicode', task(goal='بررسی پروژه', next_action='ادامه'), 0)
        env = os.environ.copy()
        env['PYTHONIOENCODING'] = 'ascii'
        result = subprocess.run([sys.executable, str(SCRIPT), '--root', str(self.root), 'show', '--id', 'unicode'],
                                capture_output=True, env=env)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(result.stdout)['data']['goal'], 'بررسی پروژه')

    def test_review_completion_preserves_open_findings_and_optional_blocked_checks(self):
        finding = dict(id='F-1', status='open', evidence='Observed failure', severity='MEDIUM',
                       evidence_class='proven-defect', location='calc.py:2', trigger_impact='wrong total', verification='oracle fails')
        data = task(status='complete', mode='review', next_action='', findings=[finding],
                    checks=[dict(command='private-staging-check', status='blocked', summary='No staging access', required=False)])
        self.store.put('task', 'project', 'audit', data, 0)
        saved = self.store.get('task', 'project', 'audit')['data']
        self.assertEqual(saved['findings'][0]['status'], 'open')
        self.assertEqual(saved['checks'][0]['status'], 'blocked')
        with self.assertRaises(state.StateError):
            self.store.put('task', 'project', 'repair', dict(data, mode='implementation'), 0)

    def test_invalid_input_encoding_fails_cleanly_without_mutation(self):
        payload = self.root / 'invalid.json'
        payload.write_bytes(b'\xff')
        result = subprocess.run([sys.executable, str(SCRIPT), '--root', str(self.root), 'checkpoint', '--id', 'bad',
                                 '--input', str(payload), '--expect-revision', '0'], capture_output=True)
        self.assertEqual(result.returncode, 2)
        self.assertNotIn(b'Traceback', result.stderr)
        self.assertIsNone(self.store.get('task', 'project', 'bad'))


if __name__ == '__main__':
    unittest.main()
