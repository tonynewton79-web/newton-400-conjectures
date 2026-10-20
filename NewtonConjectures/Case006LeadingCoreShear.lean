import Mathlib

/-!
Case 006 Appendix AE.  Finite algebra supporting the exact-core leading
comparison and single-shaper flat-boundary cross shear.  The unforced
Navier--Stokes PDE, compact integrals and full H8 are NOT Lean formalized.
The affine comparison field is NOT the complete off-axis exact core.
-/
namespace Newton400.Case006LeadingCoreShear

private def kappa : ℚ := 15971 / 122900
private def alpha : ℚ := -(4443 / 9832)

theorem affine_axis_incompressibility (r q : ℝ) (hq : q ≠ 0)
    (hr : r ≠ 0) :
    (-2 / q) + (-2 * r / q) / r = -4 / q := by
  field_simp
  ring

theorem cross_shear_jet (K c m q r phi dphi : ℝ)
    (hq : q ≠ 0) (hr : r ≠ 0) :
    (K / r) * (dphi * (-2 * r * c * m / q) -
      phi * ((-2 * c * m / q) + (-2 * r * c * m / q) / r)) =
       -2 * K * c * m / q * (dphi - 2 * phi / r) := by
  field_simp
  ring

theorem radial_quotient_jet (r phi dphi : ℝ) (hr : r ≠ 0) :
    r^2 * (dphi / r^2 - 2 * phi / r^3) = dphi - 2 * phi / r := by
  field_simp
  ring

theorem centre_plus_reserve_negative : alpha + kappa < 0 := by
  norm_num [alpha,kappa]

theorem centre_minus_reserve_negative : alpha - kappa < 0 := by
  norm_num [alpha,kappa]

theorem centre_exceeds_scalar_reserve : kappa < -alpha := by
  norm_num [alpha,kappa]

theorem shell_ratio_jet (chiMin chiMax : ℝ) :
    61 * chiMin - 60 * chiMax =
      10 * ((61 : ℝ) / 10 * chiMin - 6 * chiMax) := by ring

end Newton400.Case006LeadingCoreShear
