import Mathlib

/-!
Case 006 Appendix AB. Only finite algebraic support for the sharp radial cone tests.
The cylindrical PDE, integrations, log differentiation, source support,
and smooth weighted inverse are NOT end-to-end Lean formalized.
-/
namespace Newton400.Case006RadialConeDual

private def kappa : ℚ := 15971 / 122900

theorem sharp_radial_capacity :
    kappa / 2 = (15971 : ℚ) / 245800 := by
  norm_num [kappa]

theorem logarithmic_adjoint_jet (r ell : ℝ) (hr : r ≠ 0) :
    (ell + 3/2) - (r*ell + r/2)/r = 1 := by
  field_simp
  ring

theorem axial_source_primitive_jet (r A Ar : ℝ) (hr : r ≠ 0) :
    r*(Ar + A/r) = r*Ar + A := by
  field_simp
  ring

theorem reference_radius_cancellation (moment axial c : ℝ)
    (haxial : axial = 0) :
    moment - c*axial = moment := by
  rw [haxial]
  ring

theorem radial_marginal_cone_bound
    (E D cap : ℝ) (h : |E| + 2*|D| ≤ cap) :
    |E| ≤ cap := by
  nlinarith [abs_nonneg D]

theorem varying_source_at_test_radius :
    2 * kappa * ((15:ℚ)/8 - 3/2) = 3*kappa/4 := by
  norm_num [kappa]

theorem varying_source_violates_cone :
    kappa/2 < 3*kappa/4 := by
  norm_num [kappa]

theorem manufactured_safe_example :
    2*(kappa/4) = kappa/2 ∧ kappa/2 < kappa := by
  constructor <;> norm_num [kappa]

theorem manufactured_fail_example :
    (2:ℚ)*kappa = 2*kappa ∧ kappa/2 < kappa := by
  constructor <;> norm_num [kappa]

theorem saturation_forces_zero_D (D M : ℝ)
    (h : M + 2*|D| ≤ M) : D = 0 := by
  have hz : |D| = 0 := by
    nlinarith [abs_nonneg D]
  exact abs_eq_zero.mp hz

end Newton400.Case006RadialConeDual
