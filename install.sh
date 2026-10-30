#!/usr/bin/env bash
# install.sh — copy this kit into a workspace so Codex picks it up.
#
# Usage:
#   ./install.sh [TARGET_DIR]          # default TARGET_DIR = current directory
#   ./install.sh [TARGET_DIR] --user   # also install skills to ~/.agents/skills
#
# What it does:
#   1. AGENTS.md -> TARGET_DIR/AGENTS.md
#      (our rules live between begin/end markers; existing content outside them is kept,
#       and re-running replaces only the block between the markers)
#   2. skills/*  -> TARGET_DIR/.agents/skills/   (Codex repo-scope skill location)
#   3. --user    -> also ~/.agents/skills/       (fallback if /skills does not list them)

# Stop on the first error, on unset variables, and on failures inside pipes.
set -euo pipefail

# ---------- Parse arguments ----------
TARGET_DIR="."
INSTALL_USER=false

# Loop over every argument: "--user" is a flag, anything else is the target folder.
for arg in "$@"; do
    if [ "$arg" = "--user" ]; then
        INSTALL_USER=true
    else
        TARGET_DIR="$arg"
    fi
done

# Folder where this script lives (= the cloned kit), so it works from any cwd.
KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# Refuse to install the kit into itself (would duplicate files inside the kit repo).
if [ "$KIT_DIR" = "$TARGET_DIR" ]; then
    echo "TARGET_DIR is the kit itself. Run from your workspace, e.g.:"
    echo "  /tmp/codex-kit/install.sh ."
    exit 1
fi

# ---------- 1. AGENTS.md ----------
BEGIN_MARK="<!-- codex-kit:begin -->"
END_MARK="<!-- codex-kit:end -->"
TARGET_AGENTS="$TARGET_DIR/AGENTS.md"
ACTION="created"

if [ -f "$TARGET_AGENTS" ]; then
    ACTION="appended to existing"
    if grep -qF "$BEGIN_MARK" "$TARGET_AGENTS"; then
        # Old kit block found: delete only the lines between (and including) the markers.
        # awk prints every line except while "skip" is on.
        awk -v b="$BEGIN_MARK" -v e="$END_MARK" '
            $0 == b { skip = 1 }
            !skip   { print }
            $0 == e { skip = 0 }
        ' "$TARGET_AGENTS" > "$TARGET_AGENTS.tmp"
        mv "$TARGET_AGENTS.tmp" "$TARGET_AGENTS"
        ACTION="updated"
    fi
    # Add one blank separator line only if the file does not already end with a blank line.
    if [ -s "$TARGET_AGENTS" ] && [ -n "$(tail -n 1 "$TARGET_AGENTS")" ]; then
        echo "" >> "$TARGET_AGENTS"
    fi
fi

# Append the fresh kit block, wrapped in markers so it can be replaced next time.
{ echo "$BEGIN_MARK"; cat "$KIT_DIR/AGENTS.md"; echo "$END_MARK"; } >> "$TARGET_AGENTS"
echo "[ok] AGENTS.md: $ACTION (codex-kit block)"

# ---------- 2. Skills (repo scope) ----------
mkdir -p "$TARGET_DIR/.agents/skills"
# Copy each skill folder (intake, submit-check, ...) one by one.
for skill_path in "$KIT_DIR"/skills/*/; do
    skill_name="$(basename "$skill_path")"
    rm -rf "$TARGET_DIR/.agents/skills/$skill_name"   # replace old copy if re-run
    cp -R "$skill_path" "$TARGET_DIR/.agents/skills/$skill_name"
    echo "[ok] skill: .agents/skills/$skill_name"
done

# ---------- 3. Skills (user scope, optional) ----------
if [ "$INSTALL_USER" = true ]; then
    mkdir -p "$HOME/.agents/skills"
    for skill_path in "$KIT_DIR"/skills/*/; do
        skill_name="$(basename "$skill_path")"
        rm -rf "$HOME/.agents/skills/$skill_name"
        cp -R "$skill_path" "$HOME/.agents/skills/$skill_name"
        echo "[ok] user skill: ~/.agents/skills/$skill_name"
    done
fi

# ---------- Next steps ----------
echo ""
echo "Done. Next steps in $TARGET_DIR:"
echo "  git add AGENTS.md .agents && git commit -m 'chore: add working agreement (codex-kit)'"
echo "  codex   # then /skills to confirm intake and submit-check"
echo "If skills do not show up, re-run with --user."
