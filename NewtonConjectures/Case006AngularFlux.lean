import Mathlib

/-!
Case 006, Appendix S: finite algebra of the angular-flux cone obstruction.
Smooth cylindrical divergence, angular pressure averaging, compact
support and the Navier--Stokes PDE remain in the paper proof.
-/
namespace Newton400.Case006AngularFlux

private def coneKappa : ℚ := 15971 / 122900
private def thetaMargin : ℚ := coneKappa / 8

theorem cone_reserve_exact :
    (172 : ℚ) / 1229 - 1 / 100 = coneKappa := by
  norm_num [coneKappa]

theorem azimuthal_reserve_exact :
    thetaMargin = (15971 : ℚ) / 983200 := by
  norm_num [thetaMargin, coneKappa]

theorem azimuthal_reserve_positive :
    (0 : ℚ) < thetaMargin := by
  norm_num [thetaMargin, coneKappa]

/-- The seven-ray coefficient list contains 8*B and -8*B. -/
theorem theta_stress_pointwise (B kappa rho : ℝ)
    (h : 8 * |B| ≤ kappa * rho) :
    |B| ≤ (kappa / 8) * rho := by
  nlinarith

/-- Scalar cumulative cone flux band: the PDE identity is a hypothesis. -/
theorem primitive_band (mg beta R mu : ℝ)
    (h : |mg - beta * R| ≤ mu * R) :
    (beta - mu) * R ≤ mg ∧ mg ≤ (beta + mu) * R := by
  rcases abs_le.mp h with ⟨hl, hu⟩
  constructor <;> nlinarith

/-- Zero prepared cumulative torque cannot satisfy the band when beta>mu. -/
theorem neutral_prepared_flux_impossible (beta mu R : ℝ)
    (hR : 0 < R) (hbeta : mu < beta) :
    ¬ (|0 - beta * R| ≤ mu * R) := by
  intro h
  have hl := (primitive_band 0 beta R mu h).1
  have hstrict : 0 < (beta - mu) * R :=
    mul_pos (sub_pos.mpr hbeta) hR
  nlinarith

theorem strict_rational_reserve_gap :
    (1785 : ℚ) / 9832 > thetaMargin := by
  norm_num [thetaMargin, coneKappa]

/-- Equality in the angular coefficient extraction, with A=C=D=0. -/
theorem B_only_exact_norm (B : ℝ) :
    max (8 * |B|) (max (8 * |B|) (8 * |B|)) = 8 * |B| := by
  simp

end Newton400.Case006AngularFlux
