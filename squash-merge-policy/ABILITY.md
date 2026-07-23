---
id: squash-merge-policy
name: Squash-merge policy
description: >
  PR-only, squash-merge-always default branch with curated commit messages;
  optionally enforced by a pre-push hook.
version: 1.0.0
mode: faithful
config:
  enforce_hook:
    prompt: Install a pre-push hook that blocks merge commits from reaching the default branch?
    type: boolean
    default: true
artifacts:
  - A "Merging to main" section in CLAUDE.md
  - A pre-push hook rejecting merge commits pushed to the default branch (only if enforce_hook)
changelog:
  - version: 1.0.0
    date: 2026-07-23
    intent: >
      Initial release, extracted from the Scarpa repo's "Merging to main"
      policy — the ability this whole system was built around. The policy
      splits into an enforced constraint (no merge commits on the default
      branch; the pre-push hook) and instructed judgment (novel curated squash
      messages, docs updated in the same PR; the CLAUDE.md section). Scarpa's
      repo-specific steps (its PR preview URL, named CI jobs) were generalized
      into adaptation points.
---

# squash-merge-policy

## What this ability does

Installs a merging discipline for the repository's default branch: every change
reaches it through a PR; that PR updates the repo's docs as part of itself; and
PRs are merged with a **squash merge only**, carrying a novel, curated commit
message — no merge bubbles, a linear history that is never rewritten.

The policy has two natures, installed through different channels:

- **Constraint** (enforceable): no merge commit ever reaches the default
  branch. If `enforce_hook`, this is enforced by a pre-push hook
  (`assets/pre-push`) — 100% reliable, zero cognitive cost.
- **Judgment** (cognitive): write a novel squash message describing the change
  as a whole; keep docs current in the same PR. No hook can do this, so it is
  installed as a `CLAUDE.md` section (`assets/merging-to-main.md`) — in context
  at the moment of merging.

## Installation

1. **`CLAUDE.md` section** (always): add the contents of
   `assets/merging-to-main.md` to the target repo's `CLAUDE.md`, creating the
   file if it doesn't exist. Adapt it per the next section before writing.

2. **Pre-push hook** (only if `enforce_hook`): install the check in
   `assets/pre-push` through the repo's existing hook convention:
   - If the repo already manages hooks (husky, lefthook, pre-commit, or an
     existing `core.hooksPath` directory), add this hook's *logic* there in
     that tool's idiom. If a pre-push hook already exists, merge the check into
     it — never clobber it.
   - Otherwise, materialize the script at `.githooks/pre-push` and run
     `setup.sh` from the repo root to wire it.
   - If the default branch is not `main`, set the `protected=` variable
     accordingly.
   - `core.hooksPath` is per-clone: wire the same configuration into the
     repo's existing bootstrap path (an npm `prepare` script, `make setup`, or
     similar) so collaborators' clones enforce the policy too; failing that,
     add a setup line to the README.

3. **Host-side settings** (optional; suggest, don't do): if the repo is hosted
   on GitHub and the user has admin rights, suggest disallowing merge commits
   at the source — `gh repo edit --enable-merge-commit=false
   --enable-rebase-merge=false --enable-squash-merge`. Do not run this without
   an explicit yes: it changes shared repository settings outside the working
   tree, it isn't captured in the adoption PR, and removing the ability won't
   revert it.

## Adapt to the repo

- Match the target `CLAUDE.md`'s heading style, tone, and section ordering.
- In step 1 of the section text, name the repo's actual CI jobs if it has CI;
  drop the CI clause if it has none.
- If the repo already practices pre-merge steps of its own (a PR preview to
  share, a changelog to update), insert them into the numbered process where
  they belong — the section should read as *this repo's* process, with the
  policy woven in.
- Substitute the default branch's real name throughout (section text and
  hook's `protected=`) if it isn't `main`.
- Hook *wiring* is entirely adaptable to the repo's convention; the check's
  logic is not (see below).

## Keep faithful

These invariants define the ability; every adaptation must preserve them, and
in faithful mode any departure from them is drift:

- Every change reaches the default branch through a PR.
- Docs are updated in the same PR as the change they describe — part of
  merging, not a follow-up.
- Merges are squash merges, always: no merge commit ever lands on the default
  branch.
- The squash message is novel and curated — the change as a whole, not the
  branch's churn.
- The default branch's history is never rewritten.
- If `enforce_hook`: a pre-push-time check rejects any push that would put a
  commit with more than one parent on the protected branch. The wiring may
  vary; the guarantee may not.
