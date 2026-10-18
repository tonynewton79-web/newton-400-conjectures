import Mathlib
import NewtonConjectures.DistanceShellScalarDegree

/-!
# Stage 14: two-sided *actual graph* Loewner bounds

This file upgrades the Stage 13 scalar-degree identity to an explicit
PSD upper bound on the actual Graffiti gravity matrix. Together with the
previous lower shifted-gram certificate it gives a two-sided PSD
constraint for all n >= 4, without invoking any unverified Fourier
spectrum identity.

This is a matrix theorem, not yet a theorem about the complete real
numerical spectral spread or the harmonic closed formula.
-/

namespace Newton400.Case001

theorem actual_reciprocal_scalar_upper_psd
    (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    ((cycleWeightedShellCount n 0) •
        (1 : Matrix (ZMod n) (ZMod n) ℝ) -
      actualCycleReciprocal n).PosSemidef := by
  rw [← cycle_weighted_degree_matrix_scalar n]
  exact actual_reciprocal_upper_degree_psd n hn

theorem actual_gravity_scalar_upper_psd
    (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    ((4 / ((n - 1 : ℕ) : ℝ)) •
       ((cycleWeightedShellCount n 0) •
         (1 : Matrix (ZMod n) (ZMod n) ℝ)) -
      actualCycleGravity n).PosSemidef := by
  rw [← cycle_weighted_degree_matrix_scalar n]
  exact actual_gravity_upper_degree_psd n hn

/-- Both the spectral upper and lower matrix inequalities now use
the ACTUAL graph reciprocal-distance matrix and the same n. -/
theorem actual_reciprocal_two_sided_psd
    (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    (actualCycleReciprocal n +
      (3 / 2 : ℝ) •
        (1 : Matrix (ZMod n) (ZMod n) ℝ)).PosSemidef ∧
    ((cycleWeightedShellCount n 0) •
      (1 : Matrix (ZMod n) (ZMod n) ℝ) -
      actualCycleReciprocal n).PosSemidef := by
  exact ⟨actual_reciprocal_diagonal_shift_psd n hn,
    actual_reciprocal_scalar_upper_psd n hn⟩

end Newton400.Case001
