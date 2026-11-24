# testING

Private test fixture for [ciDGET](https://github.com/SABERBIRD/ciDGET).
Every branch puts GitHub Actions into a known state so the widget can be checked against it.

Two workflows (`CI`, `Lint`) run `.ci/run.sh`, which reads its mode from `.ci/scenario`.

| Branch | Scenario | Expected widget colour |
|---|---|---|
| `main` | CI pass, Lint pass | green |
| `green` | CI pass, Lint pass | green |
| `red` | CI fail, Lint pass | red (CI run shown) |
| `mixed` | CI pass, Lint fail | red (Lint run shown) |
| `running` | CI slow (~15 min), Lint pass | yellow while running, then green. Re-run CI to see yellow again |
| `cancelled` | CI cancels itself, Lint pass | grey (cancelled never counts as success) |
| `flaky` | CI fails on attempt 1, passes on re-run | red; after "Re-run failed jobs" → green |
| `no-ci` | workflows ignore this branch | `○` grey (no CI), near the bottom of the list |
| `new-commit` | green commit, then a newer `[skip ci]` commit | grey: the latest commit has no CI (old green must not leak) |
| `feature/a-very-long-branch-name-to-test-truncation-in-narrow-widgets` | pass | green, name truncated with `…` |
