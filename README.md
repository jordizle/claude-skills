# claude-skills

My [Claude Code](https://claude.com/claude-code) skills, kept here so they install the same way on every machine.

The centrepiece is **`engineering-loop`**: a router for substantive engineering work. It picks the smallest workflow that will do the job — direct edit, disciplined implementation, a design interrogation, or a strict structural review — and adapts when evidence changes what's known. The other three skills are what it routes into.

| Skill | What it does |
| --- | --- |
| `engineering-loop` | Routes engineering work between direct implementation, `poteto-mode`, `grill-with-docs`, and `thermo-nuclear-code-quality-review`. Owns ADR discovery, status interpretation, and completion checks. |
| `grill-with-docs` | A relentless design interview that writes the docs as it goes. Calls `grilling` and `domain-modeling`. |
| `grilling` | Interrogates a plan or decision as a design tree until the thinking holds up. |
| `domain-modeling` | Builds and sharpens a project's domain model: `CONTEXT.md`, ADRs, canonical terminology. |

## Install

```sh
git clone git@github.com:jordizle/claude-skills.git ~/claude-skills
~/claude-skills/install.sh
```

`install.sh` symlinks each skill folder into `~/.claude/skills`, so `git pull` in this repo updates every machine's skills at once. It replaces existing symlinks and refuses to overwrite a real directory, so re-running it is safe.

Prefer a different location? Set `CLAUDE_SKILLS_DIR` to override the target, or link by hand:

```sh
ln -s ~/claude-skills/engineering-loop ~/.claude/skills/engineering-loop
```

Then run `/doctor` in Claude Code to confirm they loaded.

## External dependency

`engineering-loop` routes into two skills from [pstack](https://github.com/michael-denyer/pstack-claude), which is a separate plugin:

- `pstack:poteto-mode` — investigation, implementation, verification
- `pstack:thermo-nuclear-code-quality-review` — adversarial maintainability review

Install it alongside these:

```
/plugin marketplace add michael-denyer/pstack-claude
/plugin install pstack
```

Without pstack, `engineering-loop` still routes correctly — it just can't hand off to those two skills, and will say so instead of approximating them.

## Layout

Each directory is one skill: a `SKILL.md` with YAML frontmatter (`name`, `description`), plus any bundled reference files it loads on demand. The `agents/openai.yaml` files are metadata for non-Claude runtimes and are ignored by Claude Code.
