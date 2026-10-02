# Contributing to Universal AI Enterprise Audit Pack

Thank you for helping improve the project.

## Ways to contribute

- Report reproducible installer or adapter bugs.
- Improve audit rules while keeping them evidence-first and language-neutral where possible.
- Add or update integrations for AI coding agents.
- Improve Windows, Linux, macOS, WSL, English, or Persian documentation.
- Add tests and fixtures for supported ecosystems.

## Before opening a pull request

1. Create a focused branch from the current `main` branch.
2. Keep changes small enough to review and explain the behavior change.
3. Do not weaken evidence requirements or introduce claims that cannot be verified from source/runtime evidence.
4. Preserve existing user instruction files unless an adapter explicitly owns the generated file.
5. Run the available installer checks and dry runs on your platform.
6. Update documentation and `CHANGELOG.md` when user-visible behavior changes.

## Pull requests

Describe the problem, the proposed behavior, the affected agents/platforms, and how you verified the change. Include reproduction steps for bug fixes.

## Adapter changes

Agent conventions change over time. When changing paths or formats for a third-party agent, link to its current official documentation in the pull request and avoid claiming support beyond what has been verified.

## Security

Do not publish sensitive vulnerability details in a public issue. Follow `SECURITY.md` for security reports.

## Code of collaboration

Be specific, technical, and respectful. Critique code and behavior rather than contributors.

Maintainer: [Taimazus](https://github.com/taimazus)
