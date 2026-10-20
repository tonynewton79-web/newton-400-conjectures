import Mathlib

/-!
Case006 Appendix AF: finite polynomial/rational algebra only for the
first off-axis source coefficient and core/shaper cancellation criterion.
The core G_η positivity integral, flat-edge no-go and H8 PDE are NOT
formalized in Lean here.
-/
namespace Newton400.Case006OffAxisPairing

private def alpha : ℚ := -(4443 / 9832)
private def kappa : ℚ := 15971 / 122900

theorem axial_correction_to_radial_jet
    (q c r m : ℝ) (hq : q ≠ 0) :
    (-2*c*r/q+c*m*r^3/(16*q^2))-(-2*c*r/q)
      = c*m*r^3/(16*q^2) := by
  ring

theorem first_relative_pairing (q r m : ℝ) (hq : q ≠ 0) :
    (r^2/(32*q))*m = r^2*m/(32*q) := by
  ring

theorem positive_radial_weight_combination
    (x y i j : ℝ) (hx : 0 < x) (hy : 0 < y)
    (hi : i < 0) (hj : j < 0) :
    x*i + y*j < 0 := by
  have hxi : x*i < 0 := mul_neg_of_pos_of_neg hx hi
  have hyj : y*j < 0 := mul_neg_of_pos_of_neg hy hj
  linarith

theorem core_shear_product_jet
    (I Ip r phi dphi : ℝ) (hr : r ≠ 0) :
    (I/r)*dphi - (Ip+I/r)*phi/r
      = I*dphi/r - Ip*phi/r - I*phi/(r*r) := by
  field_simp
  ring

theorem first_radial_pairing_coefficient
    (Y Lam m : ℝ) (hLam : Lam ≠ 0) :
    Y*m/(16*Lam) = (Y/(16*Lam))*m := by
  ring

theorem h8_scalar_interval_negative :
    alpha + kappa < 0 ∧ alpha - kappa < 0 := by
  constructor <;> norm_num [alpha,kappa]

theorem normalized_first_order_illustration :
    (4:ℚ) - (22*3)/(2*1000) - 1/(1000^2) > 3 := by
  norm_num

theorem quadratic_pair_rational_wedge :
    ((1:ℚ)/2)*((-1:ℚ)/2)/2 = -1/8 := by
  norm_num

end Newton400.Case006OffAxisPairing
