#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1
PROJECT="$PWD"; MODE=both; DRY=0; FORCE=0; AGENTS=all; SKILLS=all; USER_HOME="$HOME"
usage_error(){ printf '%s\n' "$1" >&2; exit 2; }
select_mode(){
  [[ "$MODE" == both || "$MODE" == "$1" ]] || usage_error '--project-only and --global-only are mutually exclusive.'
  MODE="$1"
}
while (($#)); do
  case "$1" in
    --project-only) select_mode project ;;
    --global-only) select_mode global ;;
    --dry-run) DRY=1 ;;
    --force) FORCE=1 ;;
    --project|--agents|--skills|--home)
      option="$1"
      [[ $# -ge 2 && -n "$2" && "$2" != --* ]] || usage_error "Missing value for $option"
      shift
      case "$option" in --project) PROJECT="$1";; --agents) AGENTS="$1";; --skills) SKILLS="$1";; --home) USER_HOME="$1";; esac ;;
    -h|--help)
      echo 'install.sh [--project-only|--global-only] [--dry-run] [--force] [--project PATH] [--agents all,codex,claude,cursor,copilot,gemini,antigravity,opencode,windsurf,cline,roo,generic] [--home PATH]'
      echo '  --skills all|none|audit-remediation,security-audit,pr-review,test-gap-analysis,release-readiness,project-docs,audit-fix-loop,task-orchestrator,git-release-sync (default: all)'
      exit 0 ;;
    *) usage_error "Unknown option: $1" ;;
  esac
  shift
done
skill_names=(audit-remediation security-audit pr-review test-gap-analysis release-readiness project-docs audit-fix-loop task-orchestrator git-release-sync)
[[ "$SKILLS" != ,* && "$SKILLS" != *, && "$SKILLS" != *,,* ]] || usage_error 'Empty skill name.'
IFS=',' read -r -a requested_skills <<< "$SKILLS"
for skill in "${requested_skills[@]}"; do
  case "$skill" in
    all|none|audit-remediation|security-audit|pr-review|test-gap-analysis|release-readiness|project-docs|audit-fix-loop|task-orchestrator|git-release-sync) ;;
    *) usage_error "Invalid skill: $skill" ;;
  esac
done
if [[ ",$SKILLS," == *,none,* ]]; then
  [[ "$SKILLS" == none ]] || usage_error "'none' cannot be combined with other skills."
  selected_skills=()
elif [[ ",$SKILLS," == *,all,* ]]; then
  selected_skills=("${skill_names[@]}")
else
  selected_skills=()
  for skill in "${skill_names[@]}"; do
    [[ ",$SKILLS," != *,$skill,* ]] || selected_skills+=("$skill")
  done
fi
[[ "$AGENTS" != ,* && "$AGENTS" != *, && "$AGENTS" != *,,* ]] || usage_error 'Empty agent name.'
IFS=',' read -r -a selected_agents <<< "$AGENTS"
for agent in "${selected_agents[@]}"; do
  case "$agent" in
    all|generic|codex|claude|cursor|copilot|gemini|antigravity|opencode|windsurf|cline|roo) ;;
    *) usage_error "Invalid agent: $agent" ;;
  esac
done
CORE="$(cat "$ROOT/core/enterprise-audit.md")" || exit 1
AUDIT_SKILL=$'---\nname: enterprise-audit\ndescription: Comprehensive evidence-based repository audit.\n---\n\n'"$CORE"
AGENT="$(cat "$ROOT/AGENTS.md")" || exit 1
[[ "$CORE" =~ [^[:space:]] && "$AGENT" =~ [^[:space:]] ]] || { echo 'Audit source files must not be empty.' >&2; exit 1; }
skill_contents=()
for skill in ${selected_skills[@]+"${selected_skills[@]}"}; do
  content="$(cat "$ROOT/.agents/skills/$skill/SKILL.md")" || exit 1
  [[ "$content" =~ [^[:space:]] ]] || { echo "Empty skill source: $skill" >&2; exit 1; }
  skill_contents+=("$content")
done
FAILED=0; CHANGED=0; SKIPPED=0
has(){ [[ ",$AGENTS," == *,all,* || ",$AGENTS," == *,$1,* ]]; }
write_safe(){
  local path="$1" content="$2" append="${3:-0}" backup
  if [[ -f "$path" ]]; then
    if [[ "$append" == 1 && "$(cat "$path")" == *"$content"* ]]; then
      ((SKIPPED+=1)); return
    fi
    if [[ "$append" != 1 && "$FORCE" != 1 ]]; then
      echo "[SKIP] exists: $path (use --force)"; ((SKIPPED+=1)); return
    fi
  fi
  if [[ "$DRY" == 1 ]]; then echo "[DRY] $path"; ((CHANGED+=1)); return; fi
  mkdir -p "$(dirname "$path")" || { ((FAILED+=1)); return; }
  if [[ -f "$path" ]]; then
    backup="$(mktemp "${path}.ai-audit.bak.XXXXXX")" || { ((FAILED+=1)); return; }
    cp -- "$path" "$backup" || { ((FAILED+=1)); return; }
  fi
  echo "[WRITE] $path"
  if [[ "$append" == 1 && -f "$path" ]]; then
    printf '\n\n%s\n' "$content" >> "$path" || { ((FAILED+=1)); return; }
  else
    printf '%s\n' "$content" > "$path" || { ((FAILED+=1)); return; }
  fi
  ((CHANGED+=1))
}
project_install(){
  local p="$1"
  (has generic || has codex) && write_safe "$p/AGENTS.md" "$AGENT" 1
  has claude && write_safe "$p/CLAUDE.md" "$AGENT" 1
  has gemini && write_safe "$p/GEMINI.md" "$AGENT" 1
  has cursor && write_safe "$p/.cursor/rules/enterprise-audit.mdc" $'---\ndescription: Universal evidence-based enterprise code audit protocol\nalwaysApply: false\n---\n\n'"$CORE"
  has copilot && write_safe "$p/.github/instructions/enterprise-audit.instructions.md" $'---\napplyTo: "**/*"\n---\n\n'"$CORE"
  has antigravity && write_safe "$p/.antigravity/skills/enterprise-audit/SKILL.md" "$AUDIT_SKILL"
  (has codex || has antigravity) && write_safe "$p/.agents/skills/enterprise-audit/SKILL.md" "$AUDIT_SKILL"
  write_safe "$p/core/enterprise-audit.md" "$CORE"
  local agent dir
  for agent in claude cursor copilot gemini opencode windsurf cline roo; do
    has "$agent" || continue
    case "$agent" in claude) dir=.claude/skills;; cursor) dir=.cursor/skills;; copilot) dir=.github/skills;; gemini) dir=.gemini/skills;; opencode) dir=.opencode/skills;; windsurf) dir=.windsurf/skills;; cline) dir=.cline/skills;; roo) dir=.roo/skills;; esac
    write_safe "$p/$dir/enterprise-audit/SKILL.md" "$AUDIT_SKILL"
    for i in ${selected_skills[@]+"${!selected_skills[@]}"}; do
      write_safe "$p/$dir/${selected_skills[$i]}/SKILL.md" "${skill_contents[$i]}"
    done
  done
  local i skill content route
  for i in ${selected_skills[@]+"${!selected_skills[@]}"}; do
    skill="${selected_skills[$i]}"; content="${skill_contents[$i]}"
    write_safe "$p/core/skills/$skill/SKILL.md" "$content"
    route="# Universal Engineering Skill: $skill"$'\n'"When asked to use $skill, read core/skills/$skill/SKILL.md and follow its scoped workflow."
    (has generic || has codex) && write_safe "$p/AGENTS.md" "$route" 1
    has claude && write_safe "$p/CLAUDE.md" "$route" 1
    has gemini && write_safe "$p/GEMINI.md" "$route" 1
    (has codex || has antigravity) && write_safe "$p/.agents/skills/$skill/SKILL.md" "$content"
    has cursor && write_safe "$p/.cursor/rules/$skill.mdc" $'---\ndescription: Use '"$skill"$' for its scoped engineering workflow\nalwaysApply: false\n---\n\n'"$content"
    has copilot && write_safe "$p/.github/instructions/$skill.instructions.md" $'---\napplyTo: "**/*"\n---\n\n'"When asked to use $skill, follow this workflow; otherwise these instructions do not apply."$'\n\n'"$content"
    has antigravity && write_safe "$p/.antigravity/skills/$skill/SKILL.md" "$content"
  done
}
[[ "$MODE" != global ]] && project_install "$PROJECT"
if [[ "$MODE" != project ]]; then
  global_roots=()
  (has generic || has codex) && global_roots+=(.agents/skills)
  has claude && global_roots+=(.claude/skills)
  has cursor && global_roots+=(.cursor/skills)
  has copilot && global_roots+=(.copilot/skills)
  has gemini && global_roots+=(.gemini/skills)
  has antigravity && global_roots+=(.gemini/config/skills .gemini/antigravity-cli/skills)
  has opencode && global_roots+=(.config/opencode/skills)
  has windsurf && global_roots+=(.codeium/windsurf/skills)
  has cline && global_roots+=(.cline/skills)
  has roo && global_roots+=(.roo/skills)
  for dir in ${global_roots[@]+"${global_roots[@]}"}; do
    write_safe "$USER_HOME/$dir/enterprise-audit/SKILL.md" "$AUDIT_SKILL"
    for i in ${selected_skills[@]+"${!selected_skills[@]}"}; do
      write_safe "$USER_HOME/$dir/${selected_skills[$i]}/SKILL.md" "${skill_contents[$i]}"
    done
  done
fi
echo "Changed=$CHANGED Skipped=$SKIPPED Failed=$FAILED"
(( FAILED == 0 ))
