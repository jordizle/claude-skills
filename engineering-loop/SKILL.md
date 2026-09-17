---
name: engineering-loop
description: Default workflow for substantive engineering work. Routes between direct implementation, pstack poteto-mode, grill-with-docs, and pstack thermo-nuclear-code-quality-review based on whether the work requires investigation, consequential decisions, execution, or strict structural review.
---

# Engineering Loop

You are the coordinator for substantive engineering work.

Your job is not to impose process.

Your job is to determine the smallest appropriate workflow, execute it, and adapt when evidence changes what is known.

The fundamental loop is:

`understand → decide if necessary → implement → verify correctness → review structure when warranted → feed evidence back`

Use:

* **direct implementation** when no additional workflow adds useful value,
* the installed pstack **`poteto-mode`** skill for disciplined investigation, implementation, and verification,
* **`grill-with-docs`** for unresolved domain language and consequential decisions,
* the installed pstack **`thermo-nuclear-code-quality-review`** skill for strict structural and maintainability review after substantial implementation.

When this document says to use Poteto or thermo-nuclear, invoke the corresponding installed pstack skill rather than approximating its behaviour yourself.

When this document says to use `grill-with-docs`, invoke the installed `grill-with-docs` skill rather than reproducing its interrogation process yourself.

## Model-invocable specialist skills

`grill-with-docs` is intentionally available for model invocation so this orchestrator can invoke it when the routing conditions in this skill require it.

Its availability is **not** permission to invoke it opportunistically.

Do not invoke `grill-with-docs` merely because:

* it is available,
* a task is substantial,
* architecture is mentioned,
* an ADR exists,
* implementation requires engineering judgment,
* or additional questioning might theoretically improve the result.

Invoke it only when the routing conditions defined below indicate that a consequential decision or ambiguity genuinely needs resolution.

The same principle applies to other specialist skills.

**Availability does not determine routing. This engineering loop determines routing.**

Do not make the user choose between workflows.

Once invoked, own the workflow through completion unless a decision genuinely requires user input.

---

# 1. Hydrate

Before substantial work, establish enough repository context to classify the task correctly.

Inspect relevant:

* implementation,
* tests,
* `CONTEXT.md`,
* ADRs.

Scale investigation to the task.

Do not perform exhaustive repository archaeology when a few targeted reads establish the necessary context.

Distinguish:

## Documented intent

What domain documentation and ADRs say should be true.

## Current implementation

What the repository currently implements.

## Observed behaviour

What tests, reproduction, runtime evidence, or other direct evidence show actually happens.

Do not conflate them.

Documentation does not prove implementation.

Implementation does not necessarily prove intended architecture.

Tests and runtime behaviour may expose discrepancies in either.

---

# 2. Discover relevant ADRs

Treat ADRs as a searchable decision history, not an ordered migration log.

Do not read every ADR by default.

Do not replay ADRs sequentially merely because they are numbered.

ADR numbering provides stable identity and chronology. It does not imply that every task must consume the complete architectural history.

## Discovery process

First identify:

1. the subsystem affected by the task,
2. relevant domain concepts,
3. architectural boundaries being touched,
4. technologies or infrastructure involved,
5. known decisions referenced by surrounding code or documentation.

Then discover potentially relevant ADRs using, in preference order:

1. `docs/adr/README.md` or another ADR index if present,
2. ADR metadata,
3. ADR filenames and titles,
4. repository search,
5. references from relevant code or documentation.

Read the ADRs relevant to the task.

Optimise for:

`task → affected concepts/boundaries → relevant ADRs → current decisions`

not:

`task → ADR-0001 → ADR-0002 → ... → latest ADR`

---

# 3. ADR index

If `docs/adr/README.md` exists as the repository's ADR index, treat it as a discovery mechanism rather than architectural authority.

The individual ADRs are the source of truth for their decisions, rationale, and status.

Use the index to identify potentially relevant ADRs efficiently.

Where repository convention supports it, the index should expose useful discovery information such as:

* ADR identifier,
* title,
* status,
* architectural area or domain.

Do not require an ADR index to exist before proceeding.

If no ADR index exists, do not create one automatically unless:

* the user explicitly requests one,
* repository conventions require one,
* or creating one is part of requested ADR infrastructure work.

## Index maintenance

If an ADR index exists, keep it consistent with the ADRs.

Whenever this workflow causes an ADR to be:

* created,
* accepted,
* superseded,
* replaced,
* renamed,
* deleted according to repository policy,
* or otherwise changed in a way represented by the index,

ensure the corresponding index entry is updated before the work is complete.

Prefer `grill-with-docs` to update the index when it creates or changes the architectural decision.

The workflow that produces or changes an ADR should normally update its corresponding index entry in the same unit of work.

`engineering-loop` remains responsible for verifying that the index and relevant ADRs are consistent before declaring the overall work complete.

Do not rebuild or rewrite unrelated portions of the index.

Do not modify the index merely because implementation changed when no ADR metadata or indexed decision changed.

If the index disagrees with an ADR:

1. treat the individual ADR as authoritative,
2. determine whether the disagreement is simple index drift,
3. correct the index when it is drift,
4. surface the discrepancy if it indicates a deeper architectural or historical ambiguity.

The index is a projection of the ADR collection.

It is not an independent source of architectural truth.

---

# 4. Interpret ADR status

ADR status is semantically significant.

Never treat all ADRs as simultaneously active constraints.

## Accepted

`status: accepted`

means the decision is part of the currently adopted architecture.

Treat relevant accepted ADRs as architectural constraints.

Do not silently contradict them.

## Proposed

`status: proposed`

means the decision represents intended architecture that has not yet been fully validated against implementation.

Do not assume a proposed ADR describes the current system.

When implementing a proposed ADR, continually test its assumptions against repository and runtime evidence.

A proposed ADR may be highly relevant to work intended to realise that decision while being only future intent for unrelated work.

## Superseded

`status: superseded`

means the ADR is historical context and no longer represents the current architectural decision.

Do not treat a superseded ADR as a current constraint.

When a supersession reference exists, follow it to the replacement decision.

Read superseded predecessors only when their rationale or historical context is necessary to understand the current decision.

Do not consume the entire supersession chain unless that history materially matters to the task.

## Unknown or missing status

If a relevant ADR has no clear status, do not invent one.

Use repository conventions and surrounding evidence to determine whether its authority is clear.

If authority remains ambiguous and materially affects the work, surface the ambiguity.

---

# 5. Route

Choose the smallest workflow capable of completing the task safely.

Routing is based on the nature of the work, not on which skills happen to be available.

## Direct

Work directly when the change is small, obvious, local, and easily verified.

Examples:

* typo,
* straightforward configuration change,
* obvious one-line fix,
* small mechanical edit.

**Do not invoke Poteto or `grill-with-docs` when direct implementation is clearly sufficient.**

Likewise, do not invoke thermo-nuclear review when structural risk is obviously negligible.

Do not add process merely because `/engineering-loop` was invoked.

The purpose of this skill is to choose the smallest appropriate workflow, including no additional workflow at all.

## Poteto

Invoke the installed pstack `poteto-mode` skill when the problem is sufficiently defined but requires meaningful engineering work.

Do not merely imitate Poteto's expected behaviour. Load and follow the actual installed skill.

Typical cases:

* bugs requiring investigation,
* well-defined features,
* refactors,
* performance work,
* implementation of an existing design,
* work spanning multiple files or components.

The fact that a task is architecturally significant does not automatically require grilling if the relevant decision has already been made and documented.

## Grill

Invoke `grill-with-docs` when implementation should not proceed until a consequential ambiguity or decision is resolved.

Typical triggers:

* important domain terminology is genuinely ambiguous,
* desired behaviour has multiple consequential interpretations,
* multiple credible architectures have materially different consequences and no applicable decision already resolves the trade-off,
* the work introduces a consequential decision worthy of an ADR,
* requested behaviour conflicts with an accepted ADR,
* implementation evidence challenges an existing architectural decision.

Task size alone is not a reason to grill.

The existence of relevant ADRs alone is not a reason to grill.

If an accepted ADR already resolves the architectural question, consume that decision and proceed with Poteto.

## Grill then Poteto

For substantial features with genuinely unresolved design:

`grill-with-docs → pstack poteto-mode`

Once the necessary decisions are resolved, continue automatically into Poteto when implementation is part of the user's request.

Do not require the user to invoke Poteto separately.

If `grill-with-docs` requires user input to resolve a genuine product or architectural decision, obtain that input before continuing.

---

# 6. Decision layer

When grilling is required, invoke the actual installed `grill-with-docs` skill.

Do not approximate or reproduce its questioning workflow yourself.

It may produce or update:

* requirements,
* canonical domain terminology,
* `CONTEXT.md`,
* ADRs.

## ADR creation

Create ADRs sparingly.

An ADR should represent a consequential decision that is:

* meaningfully expensive to reverse,
* non-obvious without historical context,
* and the result of a genuine trade-off.

Ordinary implementation choices stay in code.

Do not create an ADR merely because:

* a task is large,
* several files changed,
* a new class or module was introduced,
* a library was used in an unsurprising way,
* implementation required engineering judgment.

## New decisions

When an architectural decision has been made but the implementation has not yet been verified against it, use:

`status: proposed`

A proposed ADR means:

> This is intended architecture. It does not claim that the repository already implements it.

When `grill-with-docs` creates or changes an ADR and an ADR index exists, update the corresponding index entry as part of the same decision work.

Once sufficient decisions are resolved, return to execution.

---

# 7. Execution layer

Invoke the installed pstack `poteto-mode` skill for substantial implementation.

Poteto owns its own execution playbook.

Do not duplicate or replace that playbook here.

Make available to Poteto:

* relevant domain context,
* relevant accepted ADR constraints,
* relevant proposed ADRs the work intends to realise,
* constraints established by preceding decision work.

Do not burden Poteto with unrelated ADR history.

Treat documented constraints as intended architecture while still testing their assumptions against the real repository.

When Poteto delegates or chooses supporting pstack skills, allow its own playbook to govern that behaviour unless doing so conflicts with an explicit constraint established by this engineering loop.

---

# 8. Evidence can change the route

The initial route is not permanent.

Implementation may reveal new information.

## Implementation discovery

If evidence only changes how the agreed design should be implemented:

`Poteto → adapt → verify → continue`

Do not grill.

Do not create an ADR.

## Consequential ambiguity

If implementation exposes a domain or product question that materially changes expected behaviour:

`Poteto → pause affected branch → grill-with-docs → resume Poteto`

## Architectural contradiction

If implementation evidence challenges an accepted ADR or agreed architecture:

`Poteto → pause affected branch → surface evidence → grill-with-docs → update decision → resume Poteto`

Report:

1. the documented decision,
2. the conflicting evidence,
3. why they conflict,
4. the consequences or alternatives.

Do not silently:

* violate the ADR,
* reinterpret it,
* work around it,
* or rewrite architectural history.

Only the affected decision branch needs to stop.

Independent work may continue when safe.

## Proposed ADR contradicted by implementation

A contradiction with a proposed ADR is evidence about intended architecture, not automatically a defect in the implementation.

When implementation evidence shows that a proposed architecture is impractical, incomplete, or based on a false assumption:

`Poteto → surface evidence → grill-with-docs → reconsider proposal`

Do not distort the implementation merely to make it conform to a proposal that has not yet been validated.

If reconsideration changes the ADR and an ADR index exists, update the corresponding index entry.

---

# 9. Documentation follows decisions

Do not generate documentation merely because implementation occurred.

Update `CONTEXT.md` when canonical domain language changes.

Update or create an ADR when a consequential architectural decision changes.

When an ADR changes and an ADR index exists, keep the index consistent with that change.

Prefer the workflow responsible for the decision change to update both together.

Do not use ADRs as implementation logs.

Do not put implementation detail into domain context.

Do not rewrite accepted ADRs to make history appear cleaner.

When an accepted decision changes materially, preserve its historical record and supersede it.

---

# 10. Verify correctness

Before structural quality review, establish that the implementation is correct.

Verify:

* requested behaviour,
* relevant regression coverage,
* relevant tests,
* integration behaviour where applicable,
* applicable invariants.

Do not use structural review as a substitute for correctness verification.

A beautifully structured implementation that does not satisfy the requested behaviour is not complete.

---

# 11. Verify documentation against reality

After correctness is established, verify both directions.

## Intent → implementation

Check that the resulting implementation respects:

* canonical domain terminology,
* applicable accepted ADRs,
* proposed ADRs the work intended to realise.

Do not compare the implementation against unrelated ADRs merely because they exist.

## Implementation → intent

Check whether evidence revealed:

* obsolete terminology,
* changed domain concepts,
* architectural decisions that changed,
* accepted ADRs that should be superseded,
* proposed ADRs that have now been realised,
* proposed ADRs whose assumptions proved incorrect.

Do not manufacture documentation changes if nothing meaningful changed.

## ADR → index

When relevant ADRs changed and an ADR index exists, verify:

* the ADR is represented correctly,
* its title is current,
* its status is current,
* supersession relationships represented by the index are current,
* any indexed area or domain remains accurate.

Do not audit unrelated index entries unless evidence suggests broader drift.

The individual ADR remains authoritative if a discrepancy is found.

---

# 12. Structural quality gate

After substantial implementation has passed correctness verification, determine whether the change warrants a strict maintainability review.

Invoke the installed pstack `thermo-nuclear-code-quality-review` skill when the change:

* introduces or materially changes abstractions,
* adds significant branching or state management,
* changes architectural or module boundaries,
* substantially grows an existing file or component,
* introduces multiple cooperating components,
* performs a large refactor,
* adds substantial cross-cutting behaviour,
* or otherwise carries meaningful maintainability risk.

Do not merely imitate the thermo-nuclear rubric. Invoke and follow the actual installed skill.

Do not invoke thermo-nuclear for small, obvious, local changes.

Task size alone is not sufficient reason to invoke it.

The question is whether the implementation carries enough **structural risk** that an adversarial maintainability review is likely to produce useful evidence.

Thermo-nuclear review happens **after correctness verification**, not instead of it.

Treat its findings as review evidence.

Do not treat them as automatically correct instructions.

The reviewer is a critic, not the architectural authority.

---

# 13. Handle quality-review findings

Classify findings before changing code.

## Local structural finding

Examples:

* unnecessary abstraction,
* duplicated branching,
* avoidable indirection,
* poor responsibility boundaries,
* excessive file growth,
* tangled control flow,
* unnecessary state,
* code that can be substantially simplified without changing architecture.

Route the finding back through Poteto:

`thermo-nuclear → poteto-mode → improve → tests → verify`

Poteto owns the resulting implementation change.

Do not invoke `grill-with-docs` for an ordinary structural improvement.

## Architectural finding

If a thermo-nuclear recommendation would:

* contradict an accepted ADR,
* materially alter an architectural boundary,
* change the domain model,
* invalidate canonical domain language,
* or reverse a previously agreed consequential trade-off,

do not implement it automatically.

Route through the decision layer:

`thermo-nuclear → architectural concern → grill-with-docs → decision → poteto-mode`

The quality reviewer does not have authority to silently override architectural decisions.

If the resulting decision changes an ADR and an ADR index exists, update the corresponding index entry.

## Finding conflicts with a proposed ADR

If thermo-nuclear challenges architecture described by a proposed ADR, treat the finding as evidence to consider before accepting that ADR.

Route consequential disagreements through `grill-with-docs`.

Do not promote the ADR to accepted until the conflict is resolved.

## Rejected finding

Reject a recommendation when repository evidence shows that the apparent complexity is necessary for:

* required behaviour,
* an accepted architectural constraint,
* performance,
* compatibility,
* security,
* operational requirements,
* or another demonstrated constraint.

Do not modify working code merely to satisfy the reviewer.

When a rejected finding is significant, record the reasoning in the completion report.

---

# 14. Re-review

After meaningful structural changes prompted by thermo-nuclear:

1. run relevant tests,
2. re-verify requested behaviour,
3. re-check relevant documentation and ADR constraints,
4. verify relevant ADR index entries when ADRs changed,
5. invoke thermo-nuclear again when the resulting changes were themselves structurally substantial.

Do not loop indefinitely over subjective improvements.

Stop when:

* no high-value structural issue remains,
* remaining findings are cosmetic or preference-based,
* remaining complexity is justified by demonstrated constraints,
* or further simplification would violate established behaviour or architecture.

Optimise for materially better code, not reviewer satisfaction.

---

# 15. ADR lifecycle

ADRs are append-oriented decision history.

They are not database migrations.

Numbering provides stable identity and chronology, not execution order.

## Proposed → accepted

A proposed ADR can become accepted when:

* the decision has deliberately been adopted,
* the relevant implementation exists or has otherwise been validated,
* verification demonstrates that reality conforms to the decision.

Do not accept an ADR merely because implementation started.

When this work fully realises and verifies a proposed ADR, promote it as part of completion.

If an ADR index exists, update its status in the same unit of work.

## Accepted → superseded

When an accepted architectural decision materially changes:

* preserve the historical ADR,
* record the replacement decision,
* mark the previous ADR superseded according to repository convention.

Where supported by repository convention, make the relationship explicit:

`old ADR → superseded by → new ADR`

and:

`new ADR → supersedes → old ADR`

If an ADR index exists, update both affected entries and their statuses or relationships as represented by the index.

Do not rewrite history.

A thermo-nuclear finding alone does not supersede an ADR.

It may provide evidence that triggers reconsideration through `grill-with-docs`.

## Reading historical ADRs

Historical ADRs are available when rationale matters.

They are not mandatory context for every task.

Prefer the smallest set of current relevant decisions needed to work safely.

Expand into historical decisions only when doing so helps answer questions such as:

* Why does this boundary exist?
* Why was an obvious alternative rejected?
* Has this architecture already been tried?
* What constraints caused the current decision?
* Is a proposed change repeating a previously rejected approach?

---

# 16. Completion

Before declaring substantive work complete, verify the following.

## Correctness

* requested behaviour works,
* appropriate regression coverage exists,
* relevant tests pass.

## Intent

* domain terminology remains coherent,
* applicable accepted ADRs are respected,
* proposed ADRs touched by the work accurately describe reality.

## ADR lifecycle

For ADRs materially involved in the work:

* proposed decisions that were fully realised and verified have been considered for acceptance,
* contradicted proposals have not been falsely accepted,
* replaced accepted decisions have been superseded rather than rewritten.

Do not inspect or update unrelated ADRs merely to satisfy completion.

## ADR index consistency

When an ADR index exists and relevant ADRs changed:

* corresponding index entries exist,
* indexed titles and statuses match the ADRs,
* relevant supersession information is consistent,
* indexed areas or domains remain accurate where represented.

The individual ADRs remain authoritative.

Correct simple index drift before completion.

Surface deeper ambiguity rather than guessing.

## Structural quality

When the change carried meaningful maintainability risk:

* thermo-nuclear review was considered,
* high-value findings were addressed or consciously rejected,
* resulting structural changes were re-verified.

## Consistency

* documentation/code contradictions are resolved or explicitly reported,
* architectural concerns discovered during implementation or review have gone through the decision layer where necessary.

Report what was verified and any unresolved discrepancy.

---

# 17. Routing examples

## Tiny change

`engineering-loop → direct edit → verify`

No Poteto.

No grill.

No thermo-nuclear.

Do not read unrelated ADRs.

## Straightforward bug

`engineering-loop → relevant context/ADR discovery → poteto-mode → reproduce → investigate → fix → regression test → verify`

Stop when the fix has negligible structural impact.

## Bug requiring substantial restructuring

`engineering-loop → relevant ADR discovery → poteto-mode → fix → verify → thermo-nuclear → poteto-mode if needed → final verify`

## Well-defined feature

`engineering-loop → relevant context/ADR discovery → poteto-mode → implement → verify → thermo-nuclear if warranted → final verify`

## Ambiguous feature

`engineering-loop → relevant context/ADR discovery → grill-with-docs → proposed ADR/context + index update → poteto-mode → implement → verify → thermo-nuclear if warranted → final verify → accept ADR + index update`

## Implement a proposed ADR

`engineering-loop → proposed ADR + relevant current decisions → poteto-mode → test assumptions → implement → verify → thermo-nuclear if warranted → accept ADR + update index`

## Proposed ADR proves incorrect

`engineering-loop → poteto-mode → contradictory evidence → grill-with-docs → amend/reject/supersede proposal + update index → poteto-mode → verify`

## Large refactor

`engineering-loop → relevant accepted ADRs → poteto-mode → refactor → verify → thermo-nuclear → poteto-mode → re-verify`

## Architecture conflict

`engineering-loop → poteto-mode → contradiction → grill-with-docs → new decision + ADR/index update → poteto-mode → verify → thermo-nuclear if warranted`

## Quality review challenges architecture

`engineering-loop → poteto-mode → verify → thermo-nuclear → architectural concern → grill-with-docs → decision + ADR/index changes → poteto-mode → verify → re-review if warranted`

## Pure architecture discussion

`engineering-loop → relevant ADR discovery → grill-with-docs → update ADR/index if needed`

Stop after decision work if implementation was not requested.

---

# 18. Authority model

## CONTEXT.md

Owns canonical domain language and shared domain concepts.

## Individual ADRs

Own consequential architectural decisions, rationale, and decision history.

Accepted ADRs constrain current architecture.

Proposed ADRs describe intended architecture.

Superseded ADRs preserve history.

Individual ADRs are authoritative over the ADR index.

## ADR index

Owns efficient discovery.

It is a projection of the ADR collection, not an independent architectural authority.

## Code

Owns current implementation.

## Tests and runtime evidence

Provide evidence of observable behaviour and invariants.

## grill-with-docs

Owns:

* consequential decisions,
* domain clarification,
* architectural trade-offs,
* ADR creation and reconsideration,
* corresponding ADR index maintenance when it changes decisions.

It is intentionally model-invocable so `engineering-loop` can delegate decision work to it.

Its availability does not determine when it should be used.

## pstack poteto-mode

Owns:

* engineering investigation,
* implementation,
* decomposition,
* testing,
* integration,
* correctness verification.

Invoke the installed skill rather than reproducing its playbook here.

## pstack thermo-nuclear-code-quality-review

Owns:

* adversarial structural criticism,
* maintainability analysis,
* simplification opportunities,
* identification of structural risk.

It advises.

It does not unilaterally change architecture.

Invoke the installed skill rather than reproducing its rubric here.

## engineering-loop

Owns:

* routing,
* context hydration,
* relevant ADR discovery,
* transitions between workflows,
* deciding when additional process adds value,
* ensuring evidence flows back to the appropriate layer,
* verifying ADR/index consistency,
* determining when the requested work is complete.

---

# 19. Governing principles

Use the least process that preserves engineering quality.

**Do not invoke Poteto or `grill-with-docs` when direct implementation is clearly sufficient.**

Do not invoke thermo-nuclear when structural risk is negligible.

**A skill being model-invocable means it is available to this orchestrator. It does not mean it should be invoked automatically.**

When Poteto, `grill-with-docs`, or thermo-nuclear is required, invoke the actual installed skill rather than approximating it.

Read the smallest useful set of ADRs.

Do not read ADRs sequentially merely because they are numbered.

Prefer current relevant decisions over irrelevant architectural history.

Follow historical decisions when their rationale matters.

Individual ADRs are authoritative.

The ADR index exists for discovery and must reflect the ADRs, not compete with them.

The workflow that changes an architectural decision should normally update its ADR and index entry together.

`engineering-loop` verifies that this happened before completion.

Documentation records intent.

Code records implementation.

Tests and runtime evidence establish behaviour.

Poteto turns decisions into verified implementation.

Thermo-nuclear challenges the structural quality of that implementation.

Implementation and review test architectural decisions against reality.

When reality challenges intent, make the disagreement explicit and return to decision-making rather than hiding it in code.

Correctness comes before structural elegance.

Structural review should improve the codebase, not create an endless pursuit of subjective perfection.
