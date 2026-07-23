#!/bin/sh
# squash-merge-policy: wire the pre-push hook.
#
# Assumes the default layout: the hook was materialized at .githooks/pre-push
# in the target repo. If installation adapted to a different hook convention
# (husky, lefthook, an existing hooks dir), skip this script and perform the
# equivalent wiring in that convention instead.
#
# Idempotent. Run from the target repo's root.
set -e

chmod +x .githooks/pre-push
git config core.hooksPath .githooks

echo "core.hooksPath -> .githooks; pre-push hook active for this clone."
echo "Note: this config is per-clone. Wire it into the repo's bootstrap"
echo "(npm prepare, make setup, README) so collaborators get it too."
