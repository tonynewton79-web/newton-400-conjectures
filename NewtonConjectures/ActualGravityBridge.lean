import Mathlib
import NewtonConjectures.FinalTheoremProbe

/-!
# Original unshifted Harary/gravity matrix bridge

Connect the actual graph-defined reciprocal-distance and gravity matrices
to the independently kernel-certified shifted Gram-positive matrix.
The eigenvalue *ordering* and numerical spectral-span theorems remain
separate missing goals.
-/
namespace Newton400.Case001

theorem actual_reciprocal_add_diagonal_eq_shifted (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    actualCycleReciprocal n +
      (3 / 2 : ℝ) • (1 : Matrix (ZMod n) (ZMod n) ℝ) =
      realShiftedReciprocalCycle n := by
  classical
  ext u v
  by_cases h : u = v
  · subst v
    simp [actualCycleReciprocal, realShiftedReciprocalCycle,
      shiftedReciprocalCycle, Matrix.add_apply, Matrix.smul_apply]
  · simp [actualCycleReciprocal, realShiftedReciprocalCycle,
      shiftedReciprocalCycle, Matrix.add_apply,
      Matrix.smul_apply, Matrix.one_apply, h]

theorem actual_reciprocal_diagonal_shift_psd (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    (actualCycleReciprocal n +
      (3 / 2 : ℝ) • (1 : Matrix (ZMod n) (ZMod n) ℝ)).PosSemidef := by
  rw [actual_reciprocal_add_diagonal_eq_shifted n hn]
  exact real_shifted_reciprocal_psd n hn

theorem actual_gravity_is_scaled_reciprocal (n : ℕ) [NeZero n] :
    actualCycleGravity n =
      (4 / ((n - 1 : ℕ) : ℝ)) • actualCycleReciprocal n := by
  ext u v
  simp [actualCycleGravity, Matrix.smul_apply, smul_eq_mul]

end Newton400.Case001
