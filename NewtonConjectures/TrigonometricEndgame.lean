import Mathlib
import NewtonConjectures.HarmonicComparison

/-!
# Case 001: Trigonometric closure of the rational parity estimates

Direct use of the Mathlib global cosine bound
  1 - x^2/2 ≤ cos x
and the certified upper π bound, without numerical spectral tests.
These are fully quantified mathematical comparison theorems.
The cycle adjacency second-smallest eigenvalue identification is
separate and is NOT assumed or claimed as proved here.
-/
namespace Newton400.Case001

private theorem pi_lt_twenty_two_sevenths :
    Real.pi < (22 : ℝ) / 7 := by
  have h := Real.pi_lt_d4
  norm_num at h ⊢
  linarith

private theorem pi_div_le_of_den_ge
    (d k : ℕ) (hk : 0 < k) (hdk : k ≤ d) :
    Real.pi / (d : ℝ) ≤ Real.pi / (k : ℝ) := by
  have hd : (0 : ℝ) < (d : ℝ) := by exact_mod_cast (show 0 < d by omega)
  have hk' : (0 : ℝ) < (k : ℝ) := by exact_mod_cast hk
  have hdk' : (k : ℝ) ≤ (d : ℝ) := by exact_mod_cast hdk
  exact div_le_div_of_nonneg_left (le_of_lt Real.pi_pos) hk' hdk'

private theorem cosine_lower_at_most
    (x a : ℝ) (hx : 0 ≤ x) (hxa : x ≤ a) (ha : 0 ≤ a) :
    (2 : ℝ) - a^2 ≤ 2 * Real.cos x := by
  have hsq : x^2 ≤ a^2 := by nlinarith [sq_nonneg (a-x)]
  have hcos := Real.one_sub_sq_div_two_le_cos x
  nlinarith

theorem oddCycleUpper_lt_actual_cosine (m : ℕ) (hm : 7 ≤ m) :
    (oddCycleUpper m : ℝ) <
      2 * Real.cos (Real.pi / ((2*m + 1 : ℕ) : ℝ)) := by
  have hden : 15 ≤ 2*m+1 := by omega
  have hang : Real.pi / ((2*m+1 : ℕ) : ℝ) ≤ Real.pi / 15 :=
    pi_div_le_of_den_ge (2*m+1) 15 (by omega) hden
  have hb : Real.pi / 15 < (22 : ℝ)/105 := by
    have hpi := pi_lt_twenty_two_sevenths
    nlinarith
  have hpos : 0 ≤ Real.pi / ((2*m+1 : ℕ) : ℝ) := by positivity
  have hcos := cosine_lower_at_most _ _
    hpos (le_trans hang (le_of_lt hb)) (by norm_num : (0:ℝ) ≤ 22/105)
  have hrat := oddCycleUpper_lt_boundary m hm
  have hcast : (oddCycleUpper m : ℝ) <
      (2:ℝ) - ((22:ℝ)/105)^2 := by exact_mod_cast hrat
  exact lt_of_lt_of_le hcast hcos

theorem evenCycleUpper_lt_actual_cosine (m : ℕ) (hm : 8 ≤ m) :
    (evenCycleUpper m : ℝ) <
      2 * Real.cos (Real.pi / (m : ℝ)) := by
  have hang : Real.pi / (m : ℝ) ≤ Real.pi / 8 :=
    pi_div_le_of_den_ge m 8 (by omega) (by omega)
  have hb : Real.pi / 8 < (11 : ℝ)/28 := by
    have hpi := pi_lt_twenty_two_sevenths
    nlinarith
  have hpos : 0 ≤ Real.pi / (m : ℝ) := by positivity
  have hcos := cosine_lower_at_most _ _
    hpos (le_trans hang (le_of_lt hb)) (by norm_num : (0:ℝ) ≤ 11/28)
  have hrat := evenCycleUpper_lt_boundary m hm
  have hcast : (evenCycleUpper m : ℝ) <
      (2:ℝ) - ((11:ℝ)/28)^2 := by exact_mod_cast hrat
  exact lt_of_lt_of_le hcast hcos

end Newton400.Case001
