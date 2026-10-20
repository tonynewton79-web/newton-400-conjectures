import Mathlib

/-!
Case 006, Appendix V: finite algebra supporting quantitative INTERIOR
regularization of the bounded weak angular flux. The compact rectangular
antidivergence, mollification and flat-edge analysis are proved in the
manuscript but NOT end-to-end formalized in Lean here.
-/
namespace Newton400.Case006InteriorSmoothLifting

private def kappa : ℚ := 15971 / 122900
private def radialCap : ℚ := kappa / 2
private def axialCap : ℚ := kappa / 8

theorem correction_jet_identity (h beta H qrdiv qzdiv : ℝ)
    (hr : qrdiv = h - beta * H)
    (hz : qzdiv = beta * H) : qrdiv + qzdiv = h := by
  rw [hr, hz]
  ring

theorem reserve_accounting (sigma cap w v q : ℝ)
    (hv : v ≤ (1 - 3 * sigma / 4) * cap * w)
    (hq : q ≤ (sigma / 4) * cap * w) :
    v + q ≤ (1 - sigma / 2) * cap * w := by
  calc
    v + q ≤ (1 - 3 * sigma / 4) * cap * w + (sigma / 4) * cap * w :=
      add_le_add hv hq
    _ = (1 - sigma / 2) * cap * w := by ring

theorem reserved_fraction_example :
    (1 : ℚ) - (1 / 4) / 2 = 7 / 8 := by
  norm_num

theorem cone_budget_rational :
    radialCap = (15971 : ℚ) / 245800 ∧
    axialCap = (15971 : ℚ) / 983200 := by
  constructor <;> norm_num [radialCap, axialCap, kappa]

theorem exact_diagnostic_first_test :
    (1 - (1 / 4 : ℚ)) * (1 / 1000000) * (1 / 5) ≤
      ((1 / 4 : ℚ) * 2) / 4 := by
  norm_num

theorem exact_diagnostic_radial_test :
    (2 : ℚ) * 1 * (1 / 1000000) * 3 ≤
      ((1 / 4 : ℚ) * radialCap * 2) / 4 := by
  norm_num [radialCap, kappa]

theorem exact_diagnostic_axial_test :
    (1 : ℚ) * 1 * 3 * (1 / 1000000) * 3 ≤
      ((1 / 4 : ℚ) * axialCap * 2) / 4 := by
  norm_num [axialCap, kappa]

end Newton400.Case006InteriorSmoothLifting
