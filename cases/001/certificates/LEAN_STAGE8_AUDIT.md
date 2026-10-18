# Stage 8: Real spectral certification — independently replayable

- GitHub Actions run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39139083900
- Lean version: 4.24.0; pinned mathlib through lake-manifest.json.
- Build output: `Built NewtonConjectures.RealSpectral`, `Build completed successfully (7362 jobs).`
- Axiom audit: `axiom-audit: audited 142 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].` 
- `axiom-audit completed successfully`. Proof placeholder check passed.

## Kernel-accepted mathematical claims

For all n≥4 with vertices ZMod n:

- Real weighted cyclic-interval Gram matrix is positive semidefinite.
- It equals the rational full Gram identity mapped entrywise into ℝ.
- The real shifted reciprocal-distance matrix equals that real weighted Gram matrix.
- Thus `Matrix.PosSemidef (realShiftedReciprocalCycle n)`.
- Its real matrix spectrum is contained in the set of nonnegative real numbers:
  `spectrum ℝ (realShiftedReciprocalCycle n) ⊆ {x : ℝ | 0 ≤ x}`.

## Outstanding proof boundaries

The bound on *unshifted* eigenvalues (λ≥−3/2) is the elementary shift implication but has not been stated as a separate compiled Lean theorem. The final Graffiti 197 counterexample criterion for all n≥15 and the exact finite converse are **NOT yet fully Lean-certified**; independent historical priority and specialist proof review are still pending. Do not count a first refutation of an already refuted conjecture.
