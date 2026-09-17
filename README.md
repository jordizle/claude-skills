# claude-skills

My [Claude Code](https://claude.com/claude-code) skills, kept here so they install the same way on every machine.

The centrepiece is **[`engineering-loop`](engineering-loop/SKILL.md)**: a router for substantive engineering work. It picks the smallest workflow that will do the job — direct edit, disciplined implementation, a design interrogation, or a strict structural review — and adapts when evidence changes what's known.

| Skill | What it does |
| --- | --- |
| [`engineering-loop`](engineering-loop/SKILL.md) | Routes engineering work between direct implementation, `poteto-mode`, `grill-with-docs`, and `thermo-nuclear-code-quality-review`. Owns ADR discovery, status interpretation, and completion checks. |

The repo also carries [`grill-with-docs`](grill-with-docs/SKILL.md), [`grilling`](grilling/SKILL.md), and [`domain-modeling`](domain-modeling/SKILL.md), because `engineering-loop` routes into them by name — install them together or the routing breaks.

## How it routes

The loop is always the same shape:

```
understand → decide if necessary → implement → verify correctness → review structure when warranted → feed evidence back
```

What changes is how much of it a task earns. `engineering-loop` picks the smallest workflow that completes the task safely — including no extra workflow at all — and re-routes mid-flight when implementation turns up evidence the initial route didn't account for.

These are the worked examples it routes by:

- **Tiny change** — a typo, a config tweak, an obvious one-liner. No grilling, no review, no ADR reading.
  `engineering-loop → direct edit → verify`

- **Straightforward bug** — stops as soon as the fix lands, when structural impact is negligible.
  `engineering-loop → relevant context/ADR discovery → poteto-mode → reproduce → investigate → fix → regression test → verify`

- **Bug requiring substantial restructuring** — the fix is big enough to earn an adversarial read.
  `engineering-loop → relevant ADR discovery → poteto-mode → fix → verify → thermo-nuclear → poteto-mode if needed → final verify`

- **Well-defined feature** — the design is already settled, so it goes straight to building.
  `engineering-loop → relevant context/ADR discovery → poteto-mode → implement → verify → thermo-nuclear if warranted → final verify`

- **Ambiguous feature** — the only case where grilling comes first, and the ADR is accepted only once reality matches it.
  `engineering-loop → relevant context/ADR discovery → grill-with-docs → proposed ADR/context + index update → poteto-mode → implement → verify → thermo-nuclear if warranted → final verify → accept ADR + index update`

- **Implement a proposed ADR** — treats the proposal as intent to be tested, not as fact.
  `engineering-loop → proposed ADR + relevant current decisions → poteto-mode → test assumptions → implement → verify → thermo-nuclear if warranted → accept ADR + update index`

- **Proposed ADR proves incorrect** — the implementation isn't bent to fit a proposal that doesn't survive contact.
  `engineering-loop → poteto-mode → contradictory evidence → grill-with-docs → amend/reject/supersede proposal + update index → poteto-mode → verify`

- **Large refactor** — structural review is assumed, not optional.
  `engineering-loop → relevant accepted ADRs → poteto-mode → refactor → verify → thermo-nuclear → poteto-mode → re-verify`

- **Architecture conflict** — an accepted decision is never silently worked around; the disagreement goes back to the decision layer.
  `engineering-loop → poteto-mode → contradiction → grill-with-docs → new decision + ADR/index update → poteto-mode → verify`

- **Quality review challenges architecture** — the reviewer is a critic, not the architectural authority.
  `engineering-loop → poteto-mode → verify → thermo-nuclear → architectural concern → grill-with-docs → decision + ADR/index changes → poteto-mode → verify → re-review if warranted`

- **Pure architecture discussion** — stops after the decision work when no implementation was asked for.
  `engineering-loop → relevant ADR discovery → grill-with-docs → update ADR/index if needed`

Two rules do most of the work here. A skill being available is never a reason to invoke it — task size alone doesn't earn a grilling, and the mere existence of ADRs doesn't either. And correctness is verified before structure is reviewed: a beautifully structured implementation that does the wrong thing isn't finished.

The routes above are reproduced from [`engineering-loop/SKILL.md`](engineering-loop/SKILL.md) §17, which documents the full routing rules, ADR lifecycle, and authority model, and stays the source of truth.

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
