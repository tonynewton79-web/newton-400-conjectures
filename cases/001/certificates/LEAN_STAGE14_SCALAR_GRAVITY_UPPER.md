# Case 001 — Stage 14 scalar upper gravity and two-sided Loewner audit

- Actual Lean/mathlib kernel run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39158362887
- `Built NewtonConjectures.ScalarGravityUpper`.
- `Build completed successfully (7374 jobs).`
- `axiom-audit: audited 271 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound]`.
- Proof-placeholder scanner passed.

## Exact theorem statements

For every n≥4, using the original zero-diagonal real Harary/reciprocal-distance matrix R_n, true gravity matrix G_n=(4/(n−1))R_n, and the now-certified shell-count scalar s_n:

- `actual_reciprocal_scalar_upper_psd`: `(s_n I - R_n).PosSemidef`.
- `actual_gravity_scalar_upper_psd`: `((4/(n−1)) (s_n I) - G_n).PosSemidef`.
- `actual_reciprocal_two_sided_psd`: `(R_n + 3/2 I).PosSemidef ∧ (s_n I - R_n).PosSemidef`.

Here s_n is precisely `cycleWeightedShellCount n 0`, not a newly assumed constant.

## Claim boundary

The above are **matrix-order** results. Neither an all-index closed-form harmonic evaluation of s_n nor the gravity spectrum's sSup−sInf bound has yet been kernel-checked. The ordered second-smallest adjacency eigenvalue and C3..C14 finite converse remain unproved in Lean. Thus the complete Graffiti 197 cycle theorem remains a candidate.
