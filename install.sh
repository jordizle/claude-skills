#!/usr/bin/env bash
# Symlink every skill in this repo into ~/.claude/skills.
# Re-running is safe: existing symlinks are replaced, real directories are left alone.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$dest"

for skill in "$src"/*/; do
  name="$(basename "$skill")"
  [ -f "$skill/SKILL.md" ] || continue
  target="$dest/$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "skip  $name (a real directory already exists at $target)"
    continue
  fi
  ln -sfn "${skill%/}" "$target"
  echo "link  $name"
done

echo
echo "Installed to $dest. Run /doctor in Claude Code to confirm the skills loaded."
