import Mathlib
import NewtonConjectures.FullGram

/-!
# Case 001: positive semidefiniteness of the exact cyclic Gram matrix

The full all-entry rational equality is proved in FullGram.lean.
This module tests the downstream claim that the resulting rational
matrix has nonnegative quadratic form for all vectors.
-/
namespace Newton400.Case001

theorem cyclic_gram_weight_nonneg (m j : ℕ)
    (hm : 2 ≤ m) (hjlo : 2 ≤ j) (hjhi : j ≤ m) :
    0 ≤ cyclicGramWeight m j := by
  by_cases h : j = m
  · subst j
    simp only [cyclicGramWeight, if_pos rfl]
    have hpos : (1 : ℚ) < (m : ℚ) := by
      exact_mod_cast (show 1 < m by omega)
    positivity
  · simp only [cyclicGramWeight, if_neg h]
    have hpos : (1 : ℚ) < (j : ℚ) := by
      exact_mod_cast (show 1 < j by omega)
    positivity

/-- The matrix 1/m · J as a rank-one nonnegative Gram matrix. -/
theorem constant_cycle_matrix_psd (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    (fun _ _ : ZMod n => (1 : ℚ) / ((n / 2 : ℕ) : ℚ)).PosSemidef := by
  classical
  let oneVec : ZMod n → ℚ := fun _ => 1
  have hbase : (Matrix.vecMulVec oneVec (star oneVec)).PosSemidef :=
    Matrix.posSemidef_vecMulVec_self_star oneVec
  have hm : (0 : ℚ) ≤ 1 / ((n / 2 : ℕ) : ℚ) := by positivity
  have hs := hbase.smul hm
  convert hs using 1
  ext u v
  simp [oneVec, Matrix.vecMulVec, Matrix.smul_apply, smul_eq_mul]

/-- A cyclic incidence matrix times its transpose is PSD over ℚ. -/
theorem cyclic_incidence_psd (n j : ℕ) [NeZero n] :
    (cyclicIncidence n j * Matrix.transpose (cyclicIncidence n j)).PosSemidef := by
  classical
  have h := Matrix.posSemidef_self_mul_conjTranspose (cyclicIncidence n j)
  convert h using 1
  ext u v
  simp [Matrix.mul_apply, Matrix.conjTranspose_apply, Matrix.transpose_apply]

/-- The exact positive-semidefinite matrix that appears on the right side
of the fully certified reciprocal-cycle matrix identity. -/
theorem weighted_cycle_gram_psd (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    (weightedCycleGram n).PosSemidef := by
  classical
  have hm : 2 ≤ n / 2 := by omega
  have hsum :
      (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
        cyclicGramWeight (n / 2) j •
          (cyclicIncidence n j *
            Matrix.transpose (cyclicIncidence n j))).PosSemidef := by
    apply Matrix.posSemidef_sum
    intro j hj
    have hleft : 2 ≤ j := (Finset.mem_Ico.mp hj).1
    have hright : j ≤ n / 2 := by
      have h := (Finset.mem_Ico.mp hj).2
      omega
    exact (cyclic_incidence_psd n j).smul
      (cyclic_gram_weight_nonneg (n / 2) j hm hleft hright)
  have hconst := constant_cycle_matrix_psd n hn
  have hfull := hconst.add hsum
  convert hfull using 1
  ext u v
  simp [weightedCycleGram, Matrix.add_apply,
    Matrix.smul_apply, Finset.sum_apply, smul_eq_mul]
  ring

/-- Positive semidefiniteness of the shifted reciprocal-distance matrix,
an immediate theorem-level consequence of the fully formal matrix equality. -/
theorem shifted_reciprocal_cycle_psd (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    (shiftedReciprocalCycle n).PosSemidef := by
  rw [cyclic_shifted_reciprocal_eq_gram n hn]
  exact weighted_cycle_gram_psd n hn

end Newton400.Case001
