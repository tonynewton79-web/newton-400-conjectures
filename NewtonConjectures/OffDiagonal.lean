import Mathlib
import NewtonConjectures.CycleKernel
import NewtonConjectures.GramDiagonal

namespace Newton400.Case001

/-- The complete off-diagonal coefficient identity, using the very same
piecewise weights as the formal cyclic Gram matrices. The natural
subtraction exactly represents max(j-d,0). -/
theorem weighted_offdiagonal_identity (d m : ℕ)
    (hd : 1 ≤ d) (hdm : d ≤ m) (hm : 2 ≤ m) :
    (1 : ℚ) / (m : ℚ) +
      (∑ j ∈ Finset.Ico 2 (m + 1),
        cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) =
      (1 : ℚ) / (d : ℚ) := by
  by_cases heq : d = m
  · subst d
    have hzero : (∑ j ∈ Finset.Ico 2 (m + 1),
        cyclicGramWeight m j * (((j - m : ℕ) : ℚ))) = 0 := by
      apply Finset.sum_eq_zero
      intro j hj
      have hjle : j ≤ m := by
        have h := (Finset.mem_Ico.mp hj).2
        omega
      simp [Nat.sub_eq_zero_of_le hjle]
    rw [hzero, add_zero]
  · have hlt : d < m := by omega
    have hsplit :
        (∑ j ∈ Finset.Ico 2 (m + 1),
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) =
        (∑ j ∈ Finset.Ico 2 (d + 1),
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) +
        (∑ j ∈ Finset.Ico (d + 1) (m + 1),
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) := by
      exact (Finset.sum_Ico_consecutive
        (fun j => cyclicGramWeight m j * (((j - d : ℕ) : ℚ)))
        (by omega : 2 ≤ d + 1)
        (by omega : d + 1 ≤ m + 1)).symm
    have hfirst :
        (∑ j ∈ Finset.Ico 2 (d + 1),
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) = 0 := by
      apply Finset.sum_eq_zero
      intro j hj
      have hle : j ≤ d := by
        have h := (Finset.mem_Ico.mp hj).2
        omega
      simp [Nat.sub_eq_zero_of_le hle]
    have hend : cyclicGramWeight m m =
        (1 : ℚ) / (((m : ℚ) - 1) * (m : ℚ)) := by
      simp [cyclicGramWeight]
      ring
    have hinter :
        (∑ j ∈ Finset.Ico (d + 1) m,
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) =
        (∑ j ∈ Finset.Ico (d + 1) m,
          ((j : ℚ) - (d : ℚ)) *
            (2 / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1)))) := by
      apply Finset.sum_congr rfl
      intro j hj
      have hle : d + 1 ≤ j := (Finset.mem_Ico.mp hj).1
      have hltj : j < m := (Finset.mem_Ico.mp hj).2
      have hsub : ((j - d : ℕ) : ℚ) = (j : ℚ) - (d : ℚ) := by
        exact Nat.cast_sub (by omega : d ≤ j)
      rw [hsub]
      have hjne : j ≠ m := by omega
      simp only [cyclicGramWeight, if_neg hjne]
      ring
    have htermcast : ((m - d : ℕ) : ℚ) = (m : ℚ) - (d : ℚ) := by
      exact Nat.cast_sub (by omega : d ≤ m)
    calc
      (1 : ℚ) / (m : ℚ) +
        (∑ j ∈ Finset.Ico 2 (m + 1),
          cyclicGramWeight m j * (((j - d : ℕ) : ℚ))) =
        (1 : ℚ) / (m : ℚ) +
        (∑ j ∈ Finset.Ico (d + 1) m,
          ((j : ℚ) - (d : ℚ)) *
            (2 / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1)))) +
        ((m : ℚ) - (d : ℚ)) *
          (1 / (((m : ℚ) - 1) * (m : ℚ))) := by
            rw [hsplit, hfirst, zero_add,
              Finset.sum_Ico_succ_top (by omega), hinter, hend, htermcast]
            ring
      _ = (1 : ℚ) / (d : ℚ) := by
            exact (reciprocal_tent_identity d m hd hlt).symm

end Newton400.Case001
