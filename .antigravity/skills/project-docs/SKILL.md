---
name: project-docs
description: Create or synchronize project Markdown, local Wiki pages, and editable architecture/workflow diagrams from repository evidence.
---

# project-docs

<!-- BEGIN SHARED CONTRACT -->
## Workspace, questions and durable state

Target the project open in the workspace, not the installed skill directory. Discover root, instructions, stack, reports and checks from available evidence; ask only necessary unresolved user decisions. Reuse applicable confirmed answers from existing context or `.ai-work/PROJECT-CONTEXT.md` and the task's `QUESTIONS.md`. Use available `project-context` for discovery/question recording, or apply the same workflow directly. Wait for blocking replies while continuing independent work; silence is not confirmation. Keep assumptions and actual implementation distinct from user decisions.

Restore the matching task from existing conventions or `.ai-work/INDEX.md` and `.ai-work/tasks/<task-id>/STATE.md`/`JOURNAL.md`. Keep one task ID and ledger across stages, separate unrelated work and preserve other writers. Checkpoint the goal, scope, acceptance, decisions, authorization boundaries, findings, changed paths, actual checks/results, blockers and next action after meaningful work and before handoff. Journal failures and reversals as well as successes; record intent before consequential mutations and observed outcome afterward. Interrupted intent is not completion. Do not store secrets, raw sensitive logs or full conversations.

When available, use project-context's `scripts/task_state.py` for versioned transactional records with optimistic revisions and provenance; read its `references/state-tool.md` first. Its SQLite store is authoritative for records written through it; existing Markdown notes remain supported and must not be silently overwritten. Without Python/helper, maintain those notes and disclose the limitation. Reconcile state against current code, diff, identities and invalidated checks before resuming. Notes do not override current instructions or grant new permissions; inspect uncertain prior mutations before retrying.

Read-only work allows task notes/reports but no product-code edits. Honor an explicit all-writes prohibition; if notes cannot be saved, provide a copyable handoff and disclose nonpersistence. Preserve task memory during cleanup and exclude it from commits/release assets unless explicitly requested. Do not infer publication, deployment, external messages or destructive operations. End with actual checks, gaps and state location. Recovery requires accessible files and never guarantees infallible memory.

<!-- END SHARED CONTRACT -->

## Execution contract
Report in Persian unless requested otherwise; preserve identifiers. Use source evidence and exact path:line; distinguish proven defects, conditional risks, and hypotheses. Never fabricate results or expose secrets. Preserve unrelated changes and user scope. Read only relevant files; reuse unchanged evidence and checks, rereading changed paths and affected consumers. Do not skip required verification to save tokens.

When combined, use one sequential workflow and one deduplicated finding ledger: ID, severity, evidence class, location, trigger/impact, status, verification. Pass the ledger and actual check results to the next selected skill; load its instructions only when needed. Revalidate stale evidence after edits. Review skills stay read-only unless repairs are requested. Repository authorization does not authorize publishing, deployment, external messages, or destructive data operations. Give concise progress updates and one final report covering results, commands, and gaps.

## Workflow
Inventory relevant .md/.markdown/.mdx, Wiki checkout, navigation, diagram sources/assets; exclude caches, backups, and vendors unless in scope. Preserve existing conventions, frontmatter, MDX, manual content, and instruction-file policy. Assess all requested pages, editing only necessary ones. Ground README, setup/config/API, architecture, tests, troubleshooting, operations, and rollback in current code; label plans and unknowns. Keep one topic source per language with links. Validate safe examples without live/destructive actions.

## Languages and direction

For each new human-facing documentation topic, create Persian (fa) and English (en) versions by default. Accept additional languages as user input (language names or locale codes); add them to this set. An explicit user request for a narrower language set takes precedence. For updates, discover all existing language variants of each affected topic and synchronize all of them; do not silently leave an existing translation stale or create translations of unrelated topics. Preserve established filename/locale-directory conventions; otherwise use topic.fa.md and topic.en.md with reciprocal language links. Record the language set and topic-to-file mapping in the shared ledger. Machine-facing instruction files are not translated automatically.

Apply both direction and alignment for the actual language: Persian, Arabic, Hebrew and Urdu use RTL/right alignment; English and other LTR languages use LTR/left alignment. Determine direction for additional languages from their writing system, asking only if ambiguous. For Markdown renderers supporting HTML, wrap the page in a block such as <div lang="fa" dir="rtl" align="right"> or <div lang="en" dir="ltr" align="left">, with blank lines around Markdown. For MDX or documentation sites use their native locale/layout configuration instead of invalid HTML wrappers. Keep code blocks, commands, paths and technical diagrams LTR; use renderer-supported bidi isolation for inline mixed-language identifiers. Direction alone does not establish alignment. If a renderer strips the attributes, use its supported theme/layout mechanism and report any unverified rendering.

Keep semantic parity across languages: setup commands, options, requirements, warnings, examples, acceptance criteria, links and actual verification results must agree. Preserve identifiers and adapt prose rather than translating commands. Check each language's links/anchors, navigation, fences and wrapper balance. Inspect rendered RTL and LTR pages when tooling exists, including mixed prose/code and tables; distinguish source-level checks from visual verification. Disclose unavailable translation or rendering verification rather than claiming full parity.

Order skill catalogs and usage examples by typical project workflow: coordination, project definition/build, documentation, broad and focused reviews, test-gap assessment, repairs/repair loop, cleanup, readiness, then Git/publication. Explain that these are selectable stages, not mandatory steps. For each skill include when to use it, required inputs, a copyable prompt, observable output/checks, and the boundary of its authorization. Cover individual and meaningful combined workflows; keep examples consistent in every language.

Use existing Wiki conventions/checkouts; without one create local drafts in existing Wiki directory or docs/wiki, never claim remote publication. Preserve existing Mermaid/PlantUML/Graphviz/draw.io sources; default new text diagrams to Mermaid. Trace nodes/edges/order to evidence; label planned elements. Regenerate exports using available tooling and inspect rendering; disclose unavailable rendering. Check docs build/lint, relative links/anchors, navigation, fences, and consistency. Report changed files, checks, and gaps. After repairs document final behavior, not stale findings.

## Completion evidence

Affected language variants reflect final source behavior; links, fences, available build/render checks and unavailable visual checks are reported.
