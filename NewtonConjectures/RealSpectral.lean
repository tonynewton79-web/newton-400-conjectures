import Mathlib
import NewtonConjectures.RealGram

/-!
# Stage 8b: make the real Gram matrix identify with the exact real
reciprocal-distance matrix. This bridge is checked in the kernel, not
inferred solely from a separate rational PosSemidef certificate.
-/
namespace Newton400.Case001

noncomputable def realShiftedReciprocalCycle (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  (shiftedReciprocalCycle n).map (fun q : ℚ => (q : ℝ))

theorem real_gram_eq_cast_rational_gram (n : ℕ) [NeZero n] :
    realWeightedCycleGram n =
      (weightedCycleGram n).map (fun q : ℚ => (q : ℝ)) := by
  classical
  ext u v
  simp [realWeightedCycleGram, weightedCycleGram,
    realCyclicIncidence, Matrix.map_apply, Matrix.mul_apply,
    Matrix.transpose_apply, Finset.mul_sum, Finset.sum_mul]

theorem real_shifted_reciprocal_eq_gram (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    realShiftedReciprocalCycle n = realWeightedCycleGram n := by
  unfold realShiftedReciprocalCycle
  rw [cyclic_shifted_reciprocal_eq_gram n hn]
  exact (real_gram_eq_cast_rational_gram n).symm

theorem real_shifted_reciprocal_psd (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    (realShiftedReciprocalCycle n).PosSemidef := by
  rw [real_shifted_reciprocal_eq_gram n hn]
  exact real_weighted_cycle_gram_psd n hn

/-- A direct real spectral consequence. Every real spectral value of
the shifted reciprocal-distance cycle matrix is nonnegative. -/
theorem real_shifted_reciprocal_spectrum_nonneg (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    spectrum ℝ (realShiftedReciprocalCycle n) ⊆
      {e : ℝ | 0 ≤ e} := by
  exact (Matrix.posSemidef_iff_isHermitian_and_spectrum_nonneg.mp
    (real_shifted_reciprocal_psd n hn)).2


end Newton400.Case001
