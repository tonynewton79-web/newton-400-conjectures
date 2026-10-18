# Stage 7: formally certified PSD cyclic reciprocal-distance matrix

Kernel build: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39134282319

- Built `NewtonConjectures.SpectralPSD`.
- `Build completed successfully (7360 jobs).`
- `axiom-audit: audited 125 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully`

Lean statements in `NewtonConjectures/SpectralPSD.lean` establish:
1. Nonnegative exact rational cyclic Gram coefficients.
2. Positive semidefiniteness of the constant rank-one component.
3. Positive semidefiniteness of each actual cyclic interval Gram product.
4. Positive semidefiniteness of their finite weighted sum.
5. PosSemidef of the actual shifted reciprocal-distance matrix for every n≥4.

No Lean eigenvalue extraction, adjacency spectrum or all-n Graffiti inequality is claimed. The source paper is a candidate theorem needing specialist review and an originality/priority audit.
