#!/usr/bin/env bash
set -euo pipefail

# Publish a new immutable language-pack release. This repository only holds the
# release pipeline; the workflow fetches the current Clink-iOS source itself.

repo_dir="$(cd "$(dirname "$0")" && pwd)"
cd "$repo_dir"

branch="$(git branch --show-current)"
if [[ -z "$branch" ]]; then
  echo "Cannot publish from a detached HEAD." >&2
  exit 1
fi

git add -A
if ! git diff --cached --quiet; then
  git commit -m "Update language packs"
fi

tag="$(date -u +v%Y.%m.%d.%H%M%S)"
suffix=1
while git rev-parse -q --verify "refs/tags/$tag" >/dev/null; do
  tag="$(date -u +v%Y.%m.%d.%H%M%S).$suffix"
  ((suffix += 1))
done

git tag "$tag"
git push origin "HEAD:refs/heads/$branch" "refs/tags/$tag"

echo "Published $tag"
