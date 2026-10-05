"""Source checks for bilingual skill guides; does not replace visual QA."""
from pathlib import Path
import re

root = Path(__file__).resolve().parents[1]
import json
expected = [item['name'] for item in json.loads((root / 'core/skills.json').read_text(encoding='utf-8'))['skills']]
supplementary = set(expected) - {'enterprise-audit'}
powershell = (root / 'install.ps1').read_text(encoding='utf-8')
shell = (root / 'install.sh').read_text(encoding='utf-8')
ps_catalog = re.search(r'\$SkillNames=@\(([^)]*)\)', powershell)[1]
bash_catalog = re.search(r'skill_names=\(([^)]*)\)', shell)[1]
assert set(re.findall(r"'([^']+)'", ps_catalog)) == supplementary, 'PowerShell catalog drift'
assert set(bash_catalog.split()) == supplementary, 'Bash catalog drift'
ps_choices = re.search(r'\[ValidateSet\(([^)]*)\)\]\s*\[string\[\]\]\$Skills', powershell)[1]
bash_choices = re.search(r'case "\$skill" in\s+(.+?)\) ;;', shell, re.S)[1]
assert set(re.findall(r"'([^']+)'", ps_choices)) == supplementary | {'all', 'none'}, 'PowerShell choice drift'
assert set(bash_choices.strip().split('|')) == supplementary | {'all', 'none'}, 'Bash choice drift'
for filename, language, direction, alignment in [
    ('skills.md', 'fa', 'rtl', 'right'), ('skills.en.md', 'en', 'ltr', 'left'),
    ('combinations.md', 'fa', 'rtl', 'right'), ('combinations.en.md', 'en', 'ltr', 'left'),
    ('prompt-library.fa.md', 'fa', 'rtl', 'right'), ('prompt-library.en.md', 'en', 'ltr', 'left'),
    ('skill-suite-review.fa.md', 'fa', 'rtl', 'right'), ('skill-suite-review.en.md', 'en', 'ltr', 'left'),
    ('skill-tooling.fa.md', 'fa', 'rtl', 'right'), ('skill-tooling.en.md', 'en', 'ltr', 'left')]:
    path = root / 'docs' / filename
    text = path.read_text(encoding='utf-8')
    assert text.startswith(f'<div lang="{language}" dir="{direction}" align="{alignment}">'), filename
    assert text.count('<div ') == text.count('</div>'), filename
    assert len(re.findall(r'^```', text, re.M)) % 2 == 0, filename
    for match in re.finditer(r'^```[^\n]*\n.*?^```', text, re.M | re.S):
        assert text[:match.start()].rstrip().endswith('<div dir="ltr" align="left">'), filename
    for target in re.findall(r'\]\(([^)]+)\)', text):
        if '://' not in target and not target.startswith('#'):
            assert (path.parent / target.split('#')[0]).is_file(), (filename, target)
    if filename.startswith('skills'):
        names = re.findall(r'^## ([a-z][a-z-]+) —', text, re.M)
        assert names == expected, (filename, names)
        assert set(names) == {p.parent.name for p in (root / '.agents/skills').glob('*/SKILL.md')}
for name in expected:
    folder = root / '.agents/skills' / name
    adapter = root / '.antigravity/skills' / name
    for path in folder.rglob('*'):
        if not path.is_file() or '__pycache__' in path.parts or path.suffix == '.pyc':
            continue
        assert path.read_bytes() == (adapter / path.relative_to(folder)).read_bytes(), path
print('PASS: bilingual guides, workflow order, local links, LTR code and complete adapter parity')
