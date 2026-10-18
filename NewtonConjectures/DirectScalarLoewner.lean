import Mathlib
import NewtonConjectures.DistanceShellScalarDegree

/-!
# Stage 13c: single-kernel actual scalar Loewner theorems

Combines the already kernel-certified graph Laplacian and scalar
degree-matrix facts into unconditional theorems for the original
reciprocal-distance and gravity matrices (all n≥4).

No parity-specific harmonic evaluation or numerical eigenvalue-spread
conclusion is assumed in these statements.
-/
namespace Newton400.Case001

theorem actual_reciprocal_upper_scalar_psd (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    ((cycleWeightedShellCount n 0) •
      (1 : Matrix (ZMod n) (ZMod n) ℝ) -
      actualCycleReciprocal n).PosSemidef := by
  rw [← cycle_weighted_degree_matrix_scalar n]
  exact actual_reciprocal_upper_degree_psd n hn

theorem actual_gravity_upper_scalar_psd (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    ((4 / ((n - 1 : ℕ) : ℝ)) •
      ((cycleWeightedShellCount n 0) •
        (1 : Matrix (ZMod n) (ZMod n) ℝ)) -
      actualCycleGravity n).PosSemidef := by
  rw [← cycle_weighted_degree_matrix_scalar n]
  exact actual_gravity_upper_degree_psd n hn

end Newton400.Case001
