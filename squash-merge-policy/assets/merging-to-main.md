## Merging to main

Every change reaches `main` through a PR, and merges follow a fixed process so
the history stays linear and the docs stay current:

1. Branch off `main`, open a PR, and make CI pass.
2. **Before merging, update the repo's docs** — `CLAUDE.md` and whatever else
   describes what the PR changed (structure, conventions, this process
   itself). Keeping docs current is part of merging, not a follow-up: do it in
   the PR so the docs land with the code they describe.
3. **Merge with a squash merge** — `gh pr merge <n> --squash` — always, never a
   merge commit: **no merge bubbles, ever.** Write a *novel* title and body
   describing the change as a whole; omit the refine/debug/troubleshoot churn
   of the branch (that history stays on the PR). One PR becomes one clean,
   self-contained commit on a linear `main`.

`main` is pushed and shared — never rewrite its history.
