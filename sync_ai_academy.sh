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
    # AI Academy has no Slurm — drop batch scripts and rewrite READMEs
    # to invoke the executable directly instead of sbatch.
    find "$target" -name 'submit.sh' -delete

    makefile="$target/Makefile"
    if [[ -f "$makefile" ]]; then
        sed -i 's|OFFLOAD_ARCH ?= gfx90a|OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201|g' "$makefile"
    fi

    readme="$target/README.md"
    if [[ -f "$readme" && -f "$makefile" ]]; then
        exe=$(grep -m1 '^[a-z_]*:' "$makefile" | cut -d: -f1)
        if [[ -n "$exe" ]]; then
            sed -i "s|sbatch submit.sh|./$exe|g" "$readme"
        fi
    fi
    count=$((count + 1))
done < "$MANIFEST"

echo "Synced $count entries into $DEST"
