# Stack-specific execution notes

Read only the section matching the detected stack; actual repository versions, conventions and tests govern. These notes do not select or install a framework. Version-specific external claims require current primary documentation.

## React / browser frontend

Trace component state, props, effects and cleanup, async cancellation, stale responses, stable keys and accessible semantics. Check real navigation, loading/error/empty states and hydration only if relevant. Use the existing runner; test observable DOM/interaction rather than internal hooks. Measure renders and browser timings before optimization. Preserve focus and RTL/locale behavior across routing and updates.

## Python

Discover interpreter/environment and dependency lock conventions. Trace mutable defaults, resource/context-manager cleanup, exception boundaries and sync/async cancellation where relevant. Use actual event-loop semantics and existing pytest/unittest fixtures. Benchmark with representative data and controlled setup; do not hide import/environment failures with broad exception handlers.

## .NET

Discover target frameworks and project/package configuration. Trace dependency-injection lifetimes, disposal, async cancellation propagation, shared mutable state and transaction boundaries. Use actual existing test frameworks and database provider behavior; an in-memory provider alone does not establish relational transaction semantics. Preserve public serialization/error contracts during upgrades.

## Relational databases

Discover engine/version, migration tool, schema and query plans. Check ownership/tenant filters, constraints, transaction isolation, lock ordering, retries and duplicate-operation semantics. Benchmark representative cardinalities with actual plans. Exercise migrations on temporary old/new schemas, backfill and interrupted execution; verify restoration of data, not just rollback command exit status.
