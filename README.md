# project_name

PROJECT DESCRIPTION HERE.

## After using this template

1. Rename `project_name.nimble` to `<your_name>.nimble`.
2. Find/replace `project_name` with your real package name in src, tests, README.
3. Update `*.nimble` `description`, `author`, `dependencies`.
4. Replace this README with real content.
5. PR Agent runs automatically via the org-level `OPENROUTER_KEY` secret on `axiomantic`. If you forked into a different namespace, set the secret yourself or remove `.github/workflows/pr-agent.yml`.

## Development

```bash
nimble install -y
nimble test
```

## Operational Notes

### Justfile is the canonical command surface

Use `just test`, `just lint`, `just fmt`, `just docs`, `just build`. These thin-wrap
`nimble` and `nph` and remain stable as toolchain details evolve. Add new dev workflows
as `just` recipes rather than ad-hoc shell commands.

### OPENROUTER_KEY org secret

The pr-agent.yml workflow consumes `secrets.OPENROUTER_KEY`. Verify with:

```bash
gh secret list -o axiomantic | grep OPENROUTER_KEY
```

Without it, pr-agent fails on the first PR with no review output.

### Org Actions permissions

If your org disables Actions by default for new repos, enable Actions and grant write
permission to GITHUB_TOKEN before `template-cleanup.yml` runs (Settings -> Actions ->
General -> Workflow permissions -> "Read and write permissions"). Without this,
template-cleanup cannot push the rename commit and the marker file persists.

### nph version pinning (v0.7.0)

The pre-commit hook, CI install step, and local `just lint` / `just fmt` all assume
the same `nph` version (currently 0.7.0). Bump in all three places together (the
pre-commit hook header, `.github/workflows/ci.yml` install line, and the `Setup`
section of `CLAUDE.md`). Skew causes "format clean locally, fails in CI" footguns.

## License

MIT
