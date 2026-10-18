import Mathlib
import NewtonConjectures.CyclicGram

/-!
# Case 001: diagonal normalization for the cyclic Gram decomposition

We certify the rational finite-sum identity that makes the shifted
reciprocal-distance matrix have diagonal 3/2. This is universally quantified
over every integer m >= 2.
-/

namespace Newton400.Case001

/-- The aggregate of the nonterminal contributions j*w_j. -/
def diagonalInteriorSum (m : ℕ) : ℚ :=
  ∑ j ∈ Finset.Ico 2 m,
    (2 : ℚ) / (((j : ℚ) - 1) * ((j : ℚ) + 1))

/-- Exact diagonal normalization: 1/m plus the rank-one and weighted
cyclic Gram diagonal contributions equals 3/2 for all m >= 2. -/
theorem diagonal_normalization (m : ℕ) (hm : 2 ≤ m) :
    (1 : ℚ) / (m : ℚ) + diagonalInteriorSum m +
      (1 : ℚ) / ((m : ℚ) - 1) = (3 : ℚ) / 2 := by
  induction m, hm using Nat.le_induction with
  | base =>
      norm_num [diagonalInteriorSum]
  | succ m hm ih =>
      have hrec : diagonalInteriorSum (m + 1) =
          diagonalInteriorSum m +
            (2 : ℚ) / (((m : ℚ) - 1) * ((m : ℚ) + 1)) := by
        unfold diagonalInteriorSum
        rw [Finset.sum_Ico_succ_top (by omega)]
      have hm1 : (m : ℚ) - 1 ≠ 0 := by
        exact sub_ne_zero.mpr (by exact_mod_cast (show m ≠ 1 by omega))
      have hm0 : (m : ℚ) ≠ 0 := by
        exact_mod_cast (show m ≠ 0 by omega)
      have hmp : (m : ℚ) + 1 ≠ 0 := by
        positivity
      calc
        (1 : ℚ) / ((m + 1 : ℕ) : ℚ) + diagonalInteriorSum (m + 1) +
            (1 : ℚ) / (((m + 1 : ℕ) : ℚ) - 1)
            = (1 : ℚ) / (m : ℚ) + diagonalInteriorSum m +
                (1 : ℚ) / ((m : ℚ) - 1) := by
                  rw [hrec]
                  push_cast
                  have hcast : (m : ℚ) + 1 - 1 = (m : ℚ) := by ring
                  rw [hcast]
                  field_simp [hm0, hm1, hmp]
                  ring
        _ = (3 : ℚ) / 2 := ih

/-- Exactly the piecewise weights used in the cyclic Gram certificate. -/
def cyclicGramWeight (m j : ℕ) : ℚ :=
  if j = m then
    (1 : ℚ) / ((m : ℚ) * ((m : ℚ) - 1))
  else
    (2 : ℚ) / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1))

/-- The actual piecewise Gram coefficients have the correct weighted
diagonal sum, for every m ≥ 2. -/
theorem gram_weight_diagonal_sum (m : ℕ) (hm : 2 ≤ m) :
    (1 : ℚ) / (m : ℚ) +
        (∑ j ∈ Finset.Ico 2 (m + 1), (j : ℚ) * cyclicGramWeight m j) =
      (3 : ℚ) / 2 := by
  have hint :
      (∑ j ∈ Finset.Ico 2 m, (j : ℚ) * cyclicGramWeight m j) =
        diagonalInteriorSum m := by
    unfold diagonalInteriorSum
    apply Finset.sum_congr rfl
    intro j hj
    have hj2 : 2 ≤ j := (Finset.mem_Ico.mp hj).1
    have hjlt : j < m := (Finset.mem_Ico.mp hj).2
    have hjne : j ≠ m := by omega
    simp only [cyclicGramWeight, if_neg hjne]
    have hzero : (j : ℚ) ≠ 0 := by
      exact_mod_cast (show j ≠ 0 by omega)
    have hminus : (j : ℚ) - 1 ≠ 0 := by
      have hgt : (1 : ℚ) < (j : ℚ) := by
        exact_mod_cast (show 1 < j by omega)
      linarith
    have hplus : (j : ℚ) + 1 ≠ 0 := by positivity
    field_simp [hzero, hminus, hplus]
    ring
  have hterm :
      (m : ℚ) * cyclicGramWeight m m =
        (1 : ℚ) / ((m : ℚ) - 1) := by
    simp only [cyclicGramWeight, if_pos rfl]
    have hzero : (m : ℚ) ≠ 0 := by
      exact_mod_cast (show m ≠ 0 by omega)
    have hminus : (m : ℚ) - 1 ≠ 0 := by
      have hgt : (1 : ℚ) < (m : ℚ) := by
        exact_mod_cast (show 1 < m by omega)
      linarith
    field_simp [hzero, hminus]
    ring
  calc
    (1 : ℚ) / (m : ℚ) +
        (∑ j ∈ Finset.Ico 2 (m + 1), (j : ℚ) * cyclicGramWeight m j) =
      (1 : ℚ) / (m : ℚ) + diagonalInteriorSum m +
        (1 : ℚ) / ((m : ℚ) - 1) := by
          rw [Finset.sum_Ico_succ_top (by omega), hint, hterm]
          ring
    _ = (3 : ℚ) / 2 := diagonal_normalization m hm

/-- The weighted *actual matrix entries* have diagonal 3/2. -/
theorem actual_cyclic_gram_diagonal (n : ℕ) [NeZero n]
    (hn : 4 ≤ n) (u : ZMod n) :
    (1 : ℚ) / ((n / 2 : ℕ) : ℚ) +
      (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
        cyclicGramWeight (n / 2) j *
          (cyclicIncidence n j *
            Matrix.transpose (cyclicIncidence n j)) u u) =
      (3 : ℚ) / 2 := by
  have hm : 2 ≤ n / 2 := by omega
  have hsingle (j : ℕ) (hj : j ∈ Finset.Ico 2 (n / 2 + 1)) :
      (cyclicIncidence n j * Matrix.transpose (cyclicIncidence n j)) u u =
        (j : ℚ) := by
    have hjle : 2 * j ≤ n := by
      have hjlt := (Finset.mem_Ico.mp hj).2
      omega
    rw [cyclic_incidence_gram_entry n j u u hjle]
    simp [cyclicDistance]
  calc
    (1 : ℚ) / ((n / 2 : ℕ) : ℚ) +
      (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
        cyclicGramWeight (n / 2) j *
          (cyclicIncidence n j *
            Matrix.transpose (cyclicIncidence n j)) u u) =
      (1 : ℚ) / ((n / 2 : ℕ) : ℚ) +
      (∑ j ∈ Finset.Ico 2 (n / 2 + 1),
        (j : ℚ) * cyclicGramWeight (n / 2) j) := by
          congr 1
          apply Finset.sum_congr rfl
          intro j hj
          rw [hsingle j hj]
          ring
    _ = (3 : ℚ) / 2 := gram_weight_diagonal_sum (n / 2) hm

end Newton400.Case001
