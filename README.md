# claude-abilities-repository

An **abilities repository**: the content read by the
[claude-abilities](https://github.com/jlopez/claude-abilities) plugin. An
ability is a named, versioned capability written as instructions to an adopting
agent, which compiles it into a target repository's own native primitives —
`CLAUDE.md` sections, git hooks, scripts — leaving zero runtime coupling to
this system. The format is specified in the plugin repo's
[ability format spec](https://github.com/jlopez/claude-abilities/blob/main/docs/spec/ability-format.md).

One directory per ability:

| id | description |
|---|---|
| [squash-merge-policy](squash-merge-policy/) | PR-only, squash-merge-always default branch with curated commit messages; optionally enforced by a pre-push hook. |

## Contributing

Changes land via PR and are **squash-merged** (see `CLAUDE.md` — this repo
adopts its own `squash-merge-policy` ability). After cloning, run
`git config core.hooksPath .githooks` once to activate the pre-push hook that
enforces it.
