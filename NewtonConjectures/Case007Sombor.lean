import Mathlib

/-!
# Case 007 — Sombor and modified Sombor product on trees

This file contains introductory algebraic lemmas used by the proposed
extremal-tree manuscript. It does NOT formalize the global graph theorem.
-/

namespace Newton400.Case007

/-- Sombor sum for an eclipsed sun: d hub-incident edges with k substitutions. -/
def sunS (a B C : ℝ) (d k : ℕ) : ℝ :=
  (d : ℝ) * C + (k : ℝ) * (a + B - C)

/-- Modified Sombor sum for the same three edge types. -/
def sunR (a B C : ℝ) (d k : ℕ) : ℝ :=
  (d : ℝ) / C + (k : ℝ) * (1 / a + 1 / B - 1 / C)

/-- The hub-edge and subdivision-edge weights regroup algebraically. -/
theorem sunS_expansion (a B C : ℝ) (d k : ℕ) :
    sunS a B C d k =
      (k : ℝ) * a + (k : ℝ) * B + ((d : ℝ) - (k : ℝ)) * C := by
  unfold sunS
  ring

/-- Corresponding regrouping for the reciprocal Sombor weights. -/
theorem sunR_expansion (a B C : ℝ) (d k : ℕ) :
    sunR a B C d k =
      (k : ℝ) / a + (k : ℝ) / B + ((d : ℝ) - (k : ℝ)) / C := by
  unfold sunR
  ring

/-- A two-weight instance of the exact dispersion identity. -/
theorem two_weight_dispersion (x y : ℝ) (hx : x ≠ 0) (hy : y ≠ 0) :
    (x + y) * (1 / x + 1 / y) = 2 + x / y + y / x := by
  field_simp
  ring

/-- The strict rational bounds 20/9 < sqrt 5 < 9/4 begin with these squared comparisons. -/
theorem sqrt_five_rational_squares :
    ((20 : ℚ) / 9) ^ 2 < 5 ∧ (5 : ℚ) < ((9 : ℚ) / 4) ^ 2 := by
  norm_num

/-- An eclipsed sun has d+k+1 vertices, where k arms are subdivided. -/
theorem eclipsed_sun_vertex_budget (d k : ℕ) (hk : k ≤ d) :
    (d - k) + k + k + 1 = d + k + 1 := by
  omega

/-- Every candidate subdivision count is admissible for n at least five. -/
theorem candidate_admissible (n : ℕ) (hn : 5 ≤ n) :
    (n - 2) / 3 ≤ n - (n - 2) / 3 - 1 := by
  omega

end Newton400.Case007
