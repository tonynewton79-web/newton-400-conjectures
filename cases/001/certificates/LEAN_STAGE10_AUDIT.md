# Case 001 — Stage 10 formalization audit

## Kernel certificate

- [Universal all-size analytic theorem run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39146022640): `Built NewtonConjectures.AllCycleAnalytic`; `Build completed successfully (7365 jobs)`; axiom audit 197 declarations, only the foundational allowlist `propext`, `Classical.choice`, `Quot.sound`.
- [Cosine inequality run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39145776112): 7364 jobs, 189 audited declarations, passed.
- The workflow rejects `sorry` and `admit`.

## Exact kernel-checked statements

`oddCycleUpper_lt_actual_cosine`: for all m≥7,
`(oddCycleUpper m : ℝ) < 2 * cos(π/(2m+1))`.

`evenCycleUpper_lt_actual_cosine`: for all m≥8,
`(evenCycleUpper m : ℝ) < 2 * cos(π/m)`.

`cycle_all_sizes_analytic_strict`: for all natural n≥15,
`gravityParityCap n < adjacencyCosineCandidate n`.
The two functions select the corresponding expressions by parity; the latter is **not** a kernel-certified identification with the actual graph eigenvalue.

## Mandatory HOLD: graph-theoretic theorem not fully compiled

- Adjacency graph matrix / ordered second-smallest eigenvalue (with multiplicity): missing formal identification.
- Actual gravity numerical spectral spread ≤ certified harmonic bound: missing formal link.
- Finite cycle n=3..14 complement: exact independent rational verifier passes but no Lean proof.
- Full single strict graph inequality: missing Lean theorem.
- Specialist novelty and external proof review: pending.

**Classification:** PARTIAL_FORMAL_CERTIFICATION_WITH_GLOBAL_ANALYTIC_GATE_PASS. The full Graffiti 197 cycle classification should not be described as fully Lean compiled.
