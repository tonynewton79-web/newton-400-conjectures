import Mathlib
import NewtonConjectures.CyclicGram
import NewtonConjectures.CyclicZMod
import NewtonConjectures.CyclicIntersection
import NewtonConjectures.CycleKernel

/-!
# Newton 400+ / Case 001 — partial formal proof

This file proves the two exact boundary rational certificates, the positive
reciprocal second-difference formula, and the abstract weighted Gram-form
nonnegativity underlying the spectral argument.

It DOES NOT prove the full graph-theoretic cycle theorem, and we must never
report a passing compilation of this file as a formalization of that theorem.
-/

namespace Newton400.Case001

/-- Exact lower margin in the first odd case C₁₅. -/
theorem odd_boundary_exact :
    (2 : ℚ) - ((22 : ℚ) / 105) ^ 2 - (468 : ℚ) / 245 =
      (506 : ℚ) / 11025 := by
  norm_num

/-- Exact lower margin in the first even case C₁₆. -/
theorem even_boundary_exact :
    (2 : ℚ) - ((11 : ℚ) / 28) ^ 2 - (1907 : ℚ) / 1050 =
      (1733 : ℚ) / 58800 := by
  norm_num

theorem odd_boundary_positive :
    (0 : ℚ) < (2 : ℚ) - ((22 : ℚ) / 105) ^ 2 - (468 : ℚ) / 245 := by
  rw [odd_boundary_exact]
  norm_num

theorem even_boundary_positive :
    (0 : ℚ) < (2 : ℚ) - ((11 : ℚ) / 28) ^ 2 - (1907 : ℚ) / 1050 := by
  rw [even_boundary_exact]
  norm_num

/-- The reciprocal-distance kernel has positive discrete second differences. -/
theorem reciprocal_second_difference (x : ℚ) (hx : 1 < x) :
    1 / (x - 1) - 2 / x + 1 / (x + 1) =
      2 / ((x - 1) * x * (x + 1)) := by
  have hsub : x - 1 ≠ 0 := by linarith
  have hzero : x ≠ 0 := by linarith
  have hplus : x + 1 ≠ 0 := by linarith
  field_simp
  ring

/-- Each interior cyclic-interval Gram coefficient is strictly positive. -/
theorem interval_weight_positive (j : ℕ) (hj : 2 ≤ j) :
    (0 : ℚ) <
      (2 : ℚ) / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1)) := by
  have h : (1 : ℚ) < (j : ℚ) := by
    exact_mod_cast (show 1 < j by omega)
  have hsub : (0 : ℚ) < (j : ℚ) - 1 := by linarith
  positivity

/-- The quadratic form of any nonnegative weighted sum of finite Gram
    matrices is nonnegative. This is the algebraic PSD step in Case 001. -/
theorem weighted_gram_form_nonnegative {n m : ℕ}
    (w : Fin m → ℝ) (B : Fin m → Fin n → Fin n → ℝ)
    (x : Fin n → ℝ) (hw : ∀ j, 0 ≤ w j) :
    0 ≤ ∑ j : Fin m, w j *
        (∑ k : Fin n, (∑ i : Fin n, B j i k * x i) ^ 2) := by
  apply Finset.sum_nonneg
  intro j _
  apply mul_nonneg (hw j)
  apply Finset.sum_nonneg
  intro k _
  exact sq_nonneg _

/-- The rank-one constant-matrix term can be added to the weighted Gram
    form without sacrificing positivity. -/
theorem shifted_gram_form_nonnegative {n m : ℕ}
    (c : ℝ) (hc : 0 ≤ c)
    (w : Fin m → ℝ) (B : Fin m → Fin n → Fin n → ℝ)
    (x : Fin n → ℝ) (hw : ∀ j, 0 ≤ w j) :
    0 ≤ c * (∑ i : Fin n, x i) ^ 2 +
      ∑ j : Fin m, w j *
        (∑ k : Fin n, (∑ i : Fin n, B j i k * x i) ^ 2) := by
  exact add_nonneg (mul_nonneg hc (sq_nonneg _))
    (weighted_gram_form_nonnegative w B x hw)

end Newton400.Case001
