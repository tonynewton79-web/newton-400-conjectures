import Mathlib

/-!
Case 006 / Appendix T. Finite-dimensional algebra of the sharp
radial angular-stress obstruction.

The complete analytic statement uses cylindrical divergence,
integration by parts, nonnegative compact envelopes and periodic
pressure. Those functional-analytic steps are NOT proved in Lean here.
-/
namespace Newton400.Case006RadialAngularDual

private def kappa : ℚ := 15971 / 122900

/-- The two seven-ray coefficients ±2C−4D imply the sharp
pointwise coefficient bound |C| ≤ κρ/2. -/
theorem radial_coefficient_bound
    (C D K rho : ℝ)
    (hp : |2*C-4*D| ≤ K*rho)
    (hm : |-2*C-4*D| ≤ K*rho) :
    |C| ≤ (K/2)*rho := by
  rcases abs_le.mp hp with ⟨hp1,hp2⟩
  rcases abs_le.mp hm with ⟨hm1,hm2⟩
  apply abs_le.mpr
  constructor <;> linarith

/-- In the angular four-field sector A=B=D=0, the only
nonzero coefficient changes are ±2C. -/
theorem radial_sector_exact (C : ℝ) :
    max (|2*C|) (|-2*C|) = 2*|C| := by
  rw [abs_neg, max_self, abs_mul, abs_of_nonneg (show (0:ℝ) ≤ 2 by norm_num)]
  ring

theorem threshold_exact :
    kappa/2 = (15971 : ℚ)/245800 := by
  norm_num [kappa]

theorem manufactured_alpha_failure :
    (2:ℚ)*kappa > kappa := by
  norm_num [kappa]

theorem manufactured_alpha_success :
    (2:ℚ)*(kappa/4) < kappa := by
  norm_num [kappa]

/-- The radial torque perturbation r² alpha (rho_r+2rho/r)
is alpha times the radial derivative of r²rho at the jet level. -/
theorem radial_divergence_jet
    (r rho drho alpha : ℝ)
    (hr : r ≠ 0) :
    r^2*alpha*(drho+2*rho/r)
      = alpha*(r^2*drho+2*r*rho) := by
  field_simp
  ring

end Newton400.Case006RadialAngularDual
