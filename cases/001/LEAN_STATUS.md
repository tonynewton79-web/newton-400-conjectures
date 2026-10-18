# Lean 4 / mathlib verification status

A real Lean 4/mathlib project is provided at repository root,
with a GitHub Actions kernel-compilation workflow.

File: `NewtonConjectures.lean`.

The intended formal statements are:

- Exact rational positivity margins at cycle sizes 15 and 16.
- The rational reciprocal second-difference identity.
- Positivity of the nonterminal interval Gram coefficients.
- Abstract positive-semidefiniteness of nonnegative weighted Gram sums.
- Stability of that positivity when adding a nonnegative rank-one term.

**The full infinite-family cycle theorem is not formalized here.**
The combinatorial matrix-identity proof, actual cycle adjacency eigenvalue
order and multiplicities, harmonic monotonicity, and finite rational
converse C3..C14 remain to be transported into the Lean kernel.

A successfully compiled fragment is therefore **PARTIAL_FORMAL_CERTIFICATION**,
not `FULL_LEAN_CERTIFIED`. No proof status should change until a
GitHub Actions run succeeds. Do not treat text containing Lean syntax as
a compiled proof.
