# Case 001 — Stage 9 universal parity comparison certificate

**Successful workflow:** https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39140710038

- Pinned Lean 4.24.0 and mathlib: 7,363 build jobs successfully completed.
- Axiom audit: 180 project declarations; only `propext`, `Classical.choice`, and `Quot.sound`.
- No `sorry` or `admit` accepted.
- Source: `NewtonConjectures/HarmonicComparison.lean`.

For every m≥7, the kernel proves

`(4 H_m+3)/m < 2-(22/105)^2`.

For every m≥8, the kernel proves

`4(2 H_(m−1)+1/m+3/2)/(2m−1) < 2-(11/28)^2`.

The proof explicitly certifies the harmonic-number recursion, both strict monotonicity steps, and exact first-case values `468/245` and `1907/1050`. It also certifies the exact rational increment inequality for the even sequence.

**Boundary:** These compare the gravity spectral-spread *upper bounds* to rational cosine *lower candidates*. The complete adjacency second-smallest eigenvalue formula, cosine estimates as Lean theorems and the exact finite complementary cases are still missing from the end-to-end Lean chain. Thus the full Graffiti theorem remains candidate, not full Lean certified or externally validated.
