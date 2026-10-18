# Case 001 — Lean 4/mathlib status

## Kernel-certified fragment — PASS

GitHub Actions run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39125127439

Lean **v4.24.0**; mathlib dependency **v4.24.0**; actual `lake build` **PASS**;
independent `axiom-audit` **PASS** with 9 project declarations examined
and axioms confined to the standard allowlist `propext, Classical.choice, Quot.sound`.
No `sorry` or `admit` proof placeholders were accepted.

The file `NewtonConjectures.lean` has verified the following:

1. Rational odd initial margin, exactly `506/11025`.
2. Rational even initial margin, exactly `1733/58800`.
3. Positivity of both initial margins.
4. Reciprocal-distance rational second-difference identity.
5. Positivity of interior cyclic-interval Gram weights.
6. Abstract nonnegativity of a nonnegative weighted Gram quadratic form.
7. Abstract nonnegativity after adding a nonnegative rank-one quadratic term.

## NOT proved by Lean

- The **actual cycle-specific** matrix identity `R_n + (3/2)I = (1/m)J + Σ w_j B_j B_jᵀ`.
- The full graph adjacency spectrum and its second-smallest eigenvalue ordering.
- The two harmonic-number monotonicity arguments for all sufficiently large m.
- A full formal finite complement for all cycle sizes 3..14.
- Consequently the final all-n theorem **is not** formally certified.

The proof-critical fragment is **PARTIAL_FORMAL_CERTIFICATION**.
Python rational verification and a LaTeX analytic argument remain separate
layers of evidence. Historical priority and specialist review remain open.
