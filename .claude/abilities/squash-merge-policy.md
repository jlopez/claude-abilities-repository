---
id: squash-merge-policy
source: jlopez/claude-abilities-repository
baseline: 1.0.0
mode: faithful
adopted: 2026-07-23
config:
  enforce_hook: true
artifacts:
  - path: CLAUDE.md
    section: "## Merging to main"
    hash: sha256:f62ce1aa76cd70aa23f3283b170bbc513596ca3005d8e1be38818d18f2b1ea2d
    description: judgment half — PR-only merges, curated squash messages, docs updated in the same PR
  - path: .githooks/pre-push
    hash: sha256:d7c07bb658b0cc567dee0ff87c67fef0058d4bcb16e4f3cd56a6c612994486fa
    description: constraint half — rejects pushes that put merge commits on main
---

## 2026-07-23 — Adopted at 1.0.0

Adopted in **faithful** mode with `enforce_hook: true` — both the ability's
declared defaults. The adoption ran **non-interactively** (it was the
end-to-end test of the plugin's `/abilities:adopt` implementation, roadmap
item 4), so defaults were taken as the spec provides; the human gate is the
adoption PR itself. There is a pleasing circularity here: this repo *hosts*
`squash-merge-policy` and now adopts it, resolving the bootstrap deviation
from its seeding (the initial commit went straight to `main` because there
was no `main` to branch from).

Decisions:

- `CLAUDE.md` did not exist; created it with a two-line preamble identifying
  the repo (agents landing here get orientation) plus the adapted section.
- Section adaptations: dropped the "make CI pass" clause (this repo has no
  CI); the docs-update step names this repo's actual docs — the README
  ability table and the `changelog` of any touched ability — instead of
  generic wording; appended a sentence pointing at the hook and its per-clone
  activation. Substance (PR-only, squash-only, novel curated message, docs in
  the same PR, linear never-rewritten `main`) is unchanged from the canonical
  asset.
- The hook is the canonical `assets/pre-push` **verbatim** (the default
  `protected="main"` already matches), materialized at the default layout
  `.githooks/pre-push` and wired by the ability's `setup.sh`
  (`core.hooksPath` → `.githooks`). That config is per-clone; this repo has
  no scripted bootstrap (no package manager, no Makefile), so per the
  ability's fallback a **Contributing** section was added to the README with
  the one-time activation command. The README line is wiring, not a tracked
  artifact — if it goes stale, this note is the trace.
- **Host-side suggestion (suggest, don't do): deferred.** At adoption the
  GitHub repo still allows merge commits and rebase merges
  (`mergeCommitAllowed: true`, `rebaseMergeAllowed: true`). The ability's
  suggested `gh repo edit --enable-merge-commit=false
  --enable-rebase-merge=false --enable-squash-merge` was surfaced in the
  adoption PR for the repo admin to run; it was not executed because
  host-side actions require an explicit yes, which a non-interactive run
  cannot obtain.

## 2026-07-23 — Host-side suggestion executed

The merge-settings change deferred at adoption was run by the repo admin
(`gh repo edit --enable-merge-commit=false --enable-rebase-merge=false
--enable-squash-merge`); verified state is `allow_merge_commit: false`,
`allow_rebase_merge: false`, `allow_squash_merge: true`. The no-merge-commits
constraint is now enforced server-side (covering the PR-merge path the
pre-push hook cannot see) as well as locally by the hook. The adoption
entry's "deferred" bullet above is history — this entry supersedes it.
