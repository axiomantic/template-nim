# project_name

## Build Commands

| Task | Command |
|---|---|
| Test | `just test` |
| Lint | `just lint` |
| Format | `just fmt` |
| Docs | `just docs` |
| Build | `just build` |

## Architecture Overview

Single-package src layout. Public API is exposed via `src/project_name.nim`.
Tests live in `tests/` and are discovered by `nimble test`.

## Key Modules

| Module | Purpose | Notes |
|---|---|---|
| `src/project_name.nim` | Module entry / public API | Single-file by default; promote to `src/project_name/` directory if it grows |
| (add per project) | | |

## Conventions

- **Testing:** stdlib `unittest` invoked via `nimble test`. Smoke test in `tests/test1.nim`.
- **Doc comments:** rst-style fields (`:param:`, `:returns:`) for mkdocstrings-nim compatibility.
- **Formatting authority:** `nph` (pinned to v0.7.0 in pre-commit, ci.yml, and CLAUDE.md Setup).
- **Pre-commit guard:** `nph` and `nimble check` on commit. No pre-push stage (Nim has no slow type-check analogue to mypy).

## Gotchas

- **CI tool scoping:** Always scope formatters/checkers to `src tests` (not `.`) —
  `jiro4989/setup-nim-action@v2` vendors a copy of the Nim source tree at `.nim_runtime/`
  containing intentionally malformed test fixtures (e.g. `nimsuggest/tests/tconcept1.nim`)
  that crash nph 0.7.0 with SIGSEGV.

## The justfile is the canonical command surface

`nimble` is an implementation detail. Add new dev workflows as `just` recipes,
not as ad-hoc shell commands in README. (Decision #10.)
