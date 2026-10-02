#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
T="$(mktemp -d)"
# Retain isolated fixtures for inspection; never touch the real user home.
run(){ bash "$ROOT/install.sh" --project-only --project "$T/project with spaces" --skills none "$@"; }
expect_status(){
  local expected="$1" actual=0; shift
  "$@" >/dev/null 2>&1 || actual=$?
  [[ "$actual" == "$expected" ]] || { echo "Expected $expected, got $actual" >&2; exit 1; }
}
run --dry-run --agents all
[[ ! -e "$T/project with spaces" ]]
run --agents all
for name in AGENTS CLAUDE GEMINI; do
  grep -q 'core/enterprise-audit.md' "$T/project with spaces/$name.md"
done
cmp "$ROOT/core/enterprise-audit.md" "$T/project with spaces/core/enterprise-audit.md"
printf 'original\n' > "$T/project with spaces/core/enterprise-audit.md"
run --agents generic --force
run --agents generic --force
backups=("$T/project with spaces/core/enterprise-audit.md.ai-audit.bak."*)
[[ ${#backups[@]} == 2 ]]
grep -l '^original$' "${backups[@]}" >/dev/null
before="$(find "$T/project with spaces" -type f -exec cksum {} \;)"
run --agents all --force --dry-run
[[ "$before" == "$(find "$T/project with spaces" -type f -exec cksum {} \;)" ]]
expect_status 2 run --agents invalid
expect_status 2 run --agents generic,,claude
expect_status 2 run --agents
expect_status 2 run --project
expect_status 2 run --global-only
mkdir -p "$T/incomplete/core"
cp "$ROOT/install.sh" "$T/incomplete/install.sh"
expect_status 1 bash "$T/incomplete/install.sh" --project-only --project "$T/missing" --force
[[ ! -e "$T/missing" ]]
cp "$ROOT/AGENTS.md" "$T/incomplete/AGENTS.md"
printf ' \n' > "$T/incomplete/core/enterprise-audit.md"
expect_status 1 bash "$T/incomplete/install.sh" --project-only --project "$T/missing"
[[ ! -e "$T/missing" ]]
run --agents all --skills all
for skill in audit-remediation security-audit pr-review test-gap-analysis release-readiness project-docs audit-fix-loop task-orchestrator git-release-sync; do
  cmp "$ROOT/.agents/skills/$skill/SKILL.md" "$T/project with spaces/.agents/skills/$skill/SKILL.md"
  cmp "$ROOT/.agents/skills/$skill/SKILL.md" "$T/project with spaces/core/skills/$skill/SKILL.md"
  grep -q "core/skills/$skill/SKILL.md" "$T/project with spaces/AGENTS.md"
  [[ -f "$T/project with spaces/.cursor/rules/$skill.mdc" ]]
  [[ -f "$T/project with spaces/.github/instructions/$skill.instructions.md" ]]
  [[ -f "$T/project with spaces/.antigravity/skills/$skill/SKILL.md" ]]
done
before="$(find "$T/project with spaces" -type f -exec cksum {} \;)"
run --agents all --skills all
[[ "$before" == "$(find "$T/project with spaces" -type f -exec cksum {} \;)" ]]
bash "$ROOT/install.sh" --project-only --project "$T/selected" --agents codex --skills pr-review
[[ -f "$T/selected/.agents/skills/pr-review/SKILL.md" && ! -e "$T/selected/.agents/skills/security-audit" ]]
bash "$ROOT/install.sh" --project-only --project "$T/docs-only" --agents antigravity --skills project-docs
cmp "$ROOT/.agents/skills/project-docs/SKILL.md" "$T/docs-only/.antigravity/skills/project-docs/SKILL.md"
[[ ! -e "$T/docs-only/core/skills/pr-review" ]]
bash "$ROOT/install.sh" --project-only --project "$T/loop-only" --agents antigravity --skills audit-fix-loop
cmp "$ROOT/.agents/skills/audit-fix-loop/SKILL.md" "$T/loop-only/.antigravity/skills/audit-fix-loop/SKILL.md"
[[ ! -e "$T/loop-only/core/skills/project-docs" ]]
expect_status 2 run --skills invalid
expect_status 2 run --skills none,pr-review
expect_status 2 run --skills
cp "$ROOT/core/enterprise-audit.md" "$T/incomplete/core/enterprise-audit.md"
expect_status 1 bash "$T/incomplete/install.sh" --project-only --project "$T/missing" --skills pr-review
[[ ! -e "$T/missing" ]]
bash "$ROOT/install.sh" --global-only --home "$T/global-home" --dry-run
[[ ! -e "$T/global-home" ]]
bash "$ROOT/install.sh" --global-only --home "$T/global-home"
for dir in .agents/skills .claude/skills .cursor/skills .copilot/skills .gemini/skills .gemini/config/skills .gemini/antigravity-cli/skills .config/opencode/skills .codeium/windsurf/skills .cline/skills .roo/skills; do
  grep -q '^name: enterprise-audit$' "$T/global-home/$dir/enterprise-audit/SKILL.md"
  for skill in audit-remediation security-audit pr-review test-gap-analysis release-readiness project-docs audit-fix-loop task-orchestrator git-release-sync; do
    cmp "$ROOT/.agents/skills/$skill/SKILL.md" "$T/global-home/$dir/$skill/SKILL.md"
  done
done
[[ ! -e "$T/global-home/.claude/CLAUDE.md" ]]
before="$(find "$T/global-home" -type f -exec cksum {} \;)"
bash "$ROOT/install.sh" --global-only --home "$T/global-home"
[[ "$before" == "$(find "$T/global-home" -type f -exec cksum {} \;)" ]]
bash "$ROOT/install.sh" --global-only --home "$T/global-selected" --agents claude --skills pr-review
[[ -f "$T/global-selected/.claude/skills/pr-review/SKILL.md" && ! -e "$T/global-selected/.cursor" ]]
expect_status 2 run --home
echo 'PASS: Bash installer regressions'
