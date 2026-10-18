import Mathlib

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
      have hinv : (m : ℚ) * (m : ℚ)⁻¹ = 1 := mul_inv_cancel₀ hm0
      have hinv3 : (m : ℚ) ^ 3 * (m : ℚ)⁻¹ = (m : ℚ) ^ 2 := by
        calc
          (m : ℚ) ^ 3 * (m : ℚ)⁻¹ =
              (m : ℚ) ^ 2 * ((m : ℚ) * (m : ℚ)⁻¹) := by ring
          _ = (m : ℚ) ^ 2 := by rw [hinv, mul_one]
      calc
        (1 : ℚ) / ((m + 1 : ℕ) : ℚ) + diagonalInteriorSum (m + 1) +
            (1 : ℚ) / (((m + 1 : ℕ) : ℚ) - 1)
            = (1 : ℚ) / (m : ℚ) + diagonalInteriorSum m +
                (1 : ℚ) / ((m : ℚ) - 1) := by
                  rw [hrec]
                  push_cast
                  field_simp [hm0, hm1, hmp]
                  rw [hinv, hinv3]
                  ring
        _ = (3 : ℚ) / 2 := ih

end Newton400.Case001
