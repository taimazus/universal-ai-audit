# Behavioral evaluation contract

Run `scripts/evaluate.py` with Python 3.10+ relative to this installed skill. Default mode prepares isolated fixtures and explicitly marks them `prepared`; it makes no model calls. The repository's deterministic tests exercise state, oracles and harness failure behavior, not an LLM. To evaluate a real agent configure an explicitly authorized runner; do not substitute mock output and call it model evidence.

Runner configuration is a JSON argv array containing separate tokens `{workspace}`, `{request}`, `{result}`. The executable receives a project workspace, request JSON (`id`, `skill`, `request`) and an external result-file path. It must make the installed skill available to the agent, execute the actual request, and write a JSON object with `runner_identity` (actual agent/model identity) and case-specific result fields. Preserve false, blocked and unfinished outcomes. Do not send expected assertions/oracles to the evaluated model. The harness evaluates actual files, preserved artifacts, required outcome fields and an external packaged oracle. It does not trust an agent's self-rated quality score.

```text
python <installed-skill>/scripts/evaluate.py --output <new-report.json>
python <installed-skill>/scripts/evaluate.py --runner-config <authorized-runner.json> --output <new-report.json>
```

`references/scenarios.json` includes a known root-cause repair, read-only review, user-change preservation, confirmed-answer reuse, stale-answer clarification, blocked-check honesty and scope isolation. Add scenarios for specific skills/environments as needed; these fixtures do not cover every new specialist skill. The helper's process tests provide separate interruption, collision and state-recovery evidence.

Case status: `prepared` (not executed), `passed`, `failed`, or `blocked`. Exit 0 means preparation succeeded or every configured-runner case passed; always inspect `mode` and individual statuses. Exit 1 is a nonpassing real-runner suite; exit 2 is configuration/report failure. Reports and temporary fixtures are retained for inspection. A timeout or missing result is blocked, never passed. Existing reports are not overwritten.

Temporary directories isolate fixture data but are not an OS security sandbox: a runner must be trusted and authorized. Do not execute unknown downloaded runners, incur unrequested API costs or attach private repositories/secrets. `runner_identity` is a declared identifier, not cryptographic attestation. Manually review artifacts and unexpected side effects; result fields alone are not proof that an agent asked the right question. Raw runner logs are not persisted automatically; runner-written results also need redaction.
