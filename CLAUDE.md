# project_name — Project Instructions

## Project Philosophy

This project follows axiomantic standards: production-quality or nothing,
audit-driven tooling, no shortcuts. Read this file before making changes.

## Build & Test Commands

The justfile is the canonical command surface. Don't memorize `nimble` invocations.

| Task | Command | Notes |
|---|---|---|
| Run tests | `just test` | nimble test |
| Lint | `just lint` | nph --check + nimble check |
| Auto-format | `just fmt` | nph (in-place) |
| Build docs | `just docs` | mkdocs serve with mkdocstrings-nim |
| Build release | `just build` | nimble build -d:release |

## Setup

1. Install Nim 2.2.6+ (use [mise](https://mise.jdx.dev/) or [choosenim](https://github.com/nim-lang/choosenim)).
2. `nimble install --depsOnly -y`
3. `nimble install -y nph@0.7.0`   # MUST match the version pinned in .pre-commit-config.yaml and ci.yml
4. `pip install pre-commit>=3.2.0`  # No native Nim equivalent; system Python or pipx is fine
5. `pre-commit install --install-hooks`

## Key Conventions

- **src layout:** importable code lives under `src/project_name.nim` (single-file) or `src/project_name/` (multi-file).
- **tests:** in `tests/`, run via `nimble test`.
- **Doc comments:** standard Nim `## ` doc comments. Use rst-style fields for params/returns
  (mkdocstrings-nim is configured for `docstring_style: rst`).
- **Formatting authority:** `nph` is the only formatter. Do not hand-format.
- **`nimble check`** must pass with no warnings.

## Forbidden Patterns

- No `untyped`/`varargs[untyped]` shortcuts in public APIs without justification.
- No empty `except` blocks. Catch specific exceptions or rethrow.
- No commented-out code. Delete or fix.
- No bypassing `nph` formatting via `# nimformat: off` without a one-line justification.

## Operational Notes

### OPENROUTER_KEY (org secret) — REQUIRED for pr-agent
The pr-agent.yml workflow consumes `secrets.OPENROUTER_KEY` from the repo or org level.
Verify with `gh secret list -o axiomantic | grep OPENROUTER_KEY` before opening the first PR.
Without it, pr-agent.yml fails on the first PR with no review output.

### Org Actions permissions
If your org disables Actions by default for new repos, enable Actions and grant write
permission to GITHUB_TOKEN before `template-cleanup.yml` runs. Without this, the
rename commit cannot be pushed and the marker file persists.

### `@devel` pin coupling — KNOWN LIVE RISK
`pr-agent.yml` inherits from `axiomantic/.github/.github/workflows/pr-agent.yml@devel`.
Breaking changes upstream propagate immediately. Pin to a SHA in this file if you need stability.

### `nph` version coupling
The pre-commit `nph` hook, the CI `nph --check` step, and the local `just lint`/`just fmt`
all assume the SAME nph version (currently 0.7.0). Bump in all three places together,
or skew will cause "format clean locally, fails in CI" footguns.

### `mkdocstrings-nim` requires `default_handler: nim`
Without `default_handler: nim` in mkdocs.yml, mkdocstrings 1.x routes documentation blocks
to a non-existent `python` handler and the build fails with a confusing
`ModuleNotFoundError: mkdocstrings_handlers.python`. The default mkdocs.yml has it set
correctly — preserve it during edits.

## Glossary

(populate per project)
