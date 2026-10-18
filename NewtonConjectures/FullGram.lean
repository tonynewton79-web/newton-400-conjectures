import Mathlib
import NewtonConjectures.CyclicGram
import NewtonConjectures.GramDiagonal
import NewtonConjectures.OffDiagonal

/-!
# Case 001: complete all-entry rational cyclic Gram decomposition

This module combines the kernel-verified diagonal, off-diagonal
coefficient identity, and actual cyclic incidence Gram matrices.
It proves a genuine equality of rational matrices for every n ≥ 4.
The real spectral eigenvalue bound is a separate downstream theorem.
-/
namespace Newton400.Case001

/-- Reciprocal-distance matrix shifted by 3/2 on its diagonal. -/
noncomputable def shiftedReciprocalCycle (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℚ :=
  fun u v =>
    if u = v then (3 : ℚ) / 2
    else (1 : ℚ) / (cyclicDistance n u v : ℚ)

/-- Precisely the weighted cyclic-interval Gram decomposition. -/
noncomputable def weightedCycleGram (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℚ :=
  fun u v =>
    (1 : ℚ) / ((n / 2 : ℕ) : ℚ) +
      ∑ j ∈ Finset.Ico 2 (n / 2 + 1),
        cyclicGramWeight (n / 2) j *
          (cyclicIncidence n j *
            Matrix.transpose (cyclicIncidence n j)) u v

theorem cyclic_distance_positive_of_ne (n : ℕ) [NeZero n]
    (u v : ZMod n) (huv : u ≠ v) :
    1 ≤ cyclicDistance n u v := by
  have hval : (v - u).val < n := ZMod.val_lt (v - u)
  have hnonzero : (v - u).val ≠ 0 := by
    intro hz
    have hcast : ((v-u).val : ZMod n) = 0 := by simp [hz]
    have hzero : v - u = 0 := by
      simpa only [ZMod.natCast_zmod_val] using hcast
    exact huv (sub_eq_zero.mp hzero).symm
  unfold cyclicDistance
  omega

theorem cyclic_distance_le_half (n : ℕ) [NeZero n]
    (u v : ZMod n) :
    cyclicDistance n u v ≤ n / 2 := by
  have hval : (v - u).val < n := ZMod.val_lt (v - u)
  unfold cyclicDistance
  by_cases h : 2 * (v-u).val ≤ n
  · rw [Nat.min_eq_left (by omega)]
    omega
  · rw [Nat.min_eq_right (by omega)]
    omega

/-- The entire cyclic Gram identity, all vertices, both parity branches. -/
theorem cyclic_shifted_reciprocal_eq_gram (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    shiftedReciprocalCycle n = weightedCycleGram n := by
  classical
  have hm : 2 ≤ n / 2 := by omega
  ext u v
  unfold shiftedReciprocalCycle weightedCycleGram
  by_cases huv : u = v
  · subst v
    simp only [if_pos rfl]
    exact (actual_cyclic_gram_diagonal n hn u).symm
  · simp only [if_neg huv]
    have hd : 1 ≤ cyclicDistance n u v :=
      cyclic_distance_positive_of_ne n u v huv
    have hdm : cyclicDistance n u v ≤ n / 2 :=
      cyclic_distance_le_half n u v
    have hsum :
        (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
          cyclicGramWeight (n / 2) j *
            (cyclicIncidence n j *
              Matrix.transpose (cyclicIncidence n j)) u v) =
        (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
          cyclicGramWeight (n / 2) j *
            ((j - cyclicDistance n u v : ℕ) : ℚ)) := by
      apply Finset.sum_congr rfl
      intro j hj
      have hjle : 2 * j ≤ n := by
        have hbound := (Finset.mem_Ico.mp hj).2
        omega
      rw [cyclic_incidence_gram_entry n j u v hjle]
    rw [hsum]
    exact (weighted_offdiagonal_identity
      (cyclicDistance n u v) (n / 2) hd hdm hm).symm

end Newton400.Case001
