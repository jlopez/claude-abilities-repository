# claude-abilities-repository

An **abilities repository**: one directory per ability, read by the
[claude-abilities](https://github.com/jlopez/claude-abilities) plugin. The
ability format is specified in the plugin repo's
`docs/spec/ability-format.md`.

## Merging to main

Every change reaches `main` through a PR, and merges follow a fixed process so
the history stays linear and the docs stay current:

1. Branch off `main` and open a PR.
2. **Before merging, update the repo's docs** — the README's ability table,
   the `changelog` of any ability the PR touches, and whatever else describes
   what the PR changed. Keeping docs current is part of merging, not a
   follow-up: do it in the PR so the docs land with the content they describe.
3. **Merge with a squash merge** — `gh pr merge <n> --squash` — always, never
   a merge commit: **no merge bubbles, ever.** Write a *novel* title and body
   describing the change as a whole; omit the refine/debug/troubleshoot churn
   of the branch (that history stays on the PR). One PR becomes one clean,
   self-contained commit on a linear `main`.

`main` is pushed and shared — never rewrite its history.

A pre-push hook (`.githooks/pre-push`) enforces the no-merge-commits
constraint; activate it once per clone with
`git config core.hooksPath .githooks`.
