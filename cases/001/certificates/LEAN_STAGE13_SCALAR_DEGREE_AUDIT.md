# Case 001 Stage 13 — scalar distance-shell degree certificate

Date: 18 October 2026.

## Trusted Lean 4 / mathlib results
[Successful run 39157366365](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39157366365)

- `Build completed successfully (7373 jobs).`
- `axiom-audit: audited 268 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- Axiom audit successful, with no nonstandard axioms.
- The actual cyclic distance-shell graphs admit explicit translation bijections preserving each shell's finite number of neighbors.
- Weighted shell degree is independent of the chosen vertex.
- The actual degree matrix is a scalar matrix: `cycleWeightedDegreeMatrix n = cycleWeightedShellCount n 0 • 1`.
- With the Stage 12 weighted Laplacian theorem, `s_n I - R_n` is positive semidefinite for all n≥4.

## Separate exact rational finite stress test
- [Independent script](../verify_row_sum.py): 4≤n≤160.
- 685,875 shell-cardinality comparisons and 12,874 row-sum equalities passed using only exact integer and Fraction arithmetic.
- Verified digest: `dfb385c5e1a5eb5a5762c11e239e8da8ab6951711d2f407912fd76224f5ce47a`.
- [JSON certificate](ROW_SUM_EXACT_4_TO_160.json).

## Important scientific HOLD
The finite audit does not make the parity harmonic formulas a universally compiled Lean theorem. The remaining spectral-ordering, explicit row-sum evaluation, real gravity span extraction and C3–C14 converse remain outstanding. This is not a complete Lean proof of the sharp Graffiti cycle theorem. Original Graffiti 197 was already refuted by Roucairol and Cazenave. External novelty and specialist review remain pending.
