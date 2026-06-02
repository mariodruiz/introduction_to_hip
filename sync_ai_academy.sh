#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$REPO_ROOT/ai_academy.manifest"
DEST="$REPO_ROOT/ai_academy"

if [[ ! -f "$MANIFEST" ]]; then
    echo "ERROR: $MANIFEST not found." >&2
    exit 1
fi

# Clean only the generated code dirs so hand-authored notebooks in $DEST survive
rm -rf "$DEST/examples" "$DEST/exercises"
mkdir -p "$DEST"

count=0
while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip blank lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

    src="$REPO_ROOT/$line"
    if [[ ! -e "$src" ]]; then
        echo "WARNING: $line does not exist, skipping." >&2
        continue
    fi

    target="$DEST/$line"
    mkdir -p "$(dirname "$target")"
    cp -a "$src" "$target"
    # AI Academy has no Slurm, and the exercise instructions live in the
    # notebooks, so drop the batch scripts and READMEs from the synced copy.
    find "$target" \( -name 'README.md' -o -name 'submit.sh' \) -delete
    count=$((count + 1))
done < "$MANIFEST"

echo "Synced $count entries into $DEST"
