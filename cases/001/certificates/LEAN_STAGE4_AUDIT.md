# Case 001 — Stage 4 exact diagonal certification

## Audit

- Run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39130358760
- Lean source: `NewtonConjectures/GramDiagonal.lean`
- Build: `Build completed successfully (7357 jobs).`
- Axiom audit: `axiom-audit: audited 91 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- No `sorry` or `admit` placeholders.
- The linter noted two unused `all_goals ring` commands; these are style-only warnings and do not affect the kernel result.

## What is proved

1. For all m ≥ 2, the exact rational diagonal finite-sum identity.
2. The identical finite-sum formula written with the **actual piecewise Gram coefficients**, including the terminal coefficient.
3. For all n ≥ 4 and u : ZMod n, the **actual weighted incidence Gram matrix diagonal** equals 3/2 after adding 1/⌊n/2⌋.

## What is not proved

The complete matrix equality off the diagonal and the final graph spectral inequality are still separate Lean targets. They must not be inferred solely from this passed build.
