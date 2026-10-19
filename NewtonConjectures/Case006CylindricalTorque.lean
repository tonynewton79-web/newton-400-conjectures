import Mathlib

/-!
Case 006, Appendix O: cylindrical frame and exact torque algebra.

The original cone centre of Proposition 9.22 is written in the
moving cylindrical basis (e_r,e_theta,e_z), not one globally fixed
Cartesian frame. These statements are exact algebraic lemmas used
in its cylindrical source-torque audit.

The analytic basis-connection formula, compact radial integrations,
original shell-profile class, and weighted H8 inverse are NOT
formalized by this file.
-/

namespace Newton400.Case006CylindricalTorque

/-- The r²-weighted connection term is an exact radial derivative. -/
theorem radial_torque_identity
    (r rho drho dzrho br bt bz : ℝ) :
    r^2 * (br*bt*drho + bt*bz*dzrho) +
       2*r*br*bt*rho =
      br*bt*(r^2*drho + 2*r*rho) +
       bt*bz*r^2*dzrho := by
  ring

/-- Original Proposition 9.22 yields b_r b_z = -4443/9832. -/
theorem centre_radial_axial_product :
    ((2 : ℚ) - 1225 * ((91 : ℚ) / 200)) / 1229 =
      -(4443 : ℚ) / 9832 := by
  norm_num

/-- Any nonzero positive envelope moment produces a strict dipole
    when both azimuthal and axial components are negative. -/
theorem nonzero_baseline_torque
    (bt bz I : ℝ) (hbt : bt < 0) (hbz : bz < 0)
    (hI : 0 < I) : 0 < bt*bz*I := by
  exact mul_pos (mul_pos_of_neg_of_neg hbt hbz) hI

/-- Covariance of transverse moving-frame components under a
    quarter turn, at the polynomial coefficient level. -/
theorem cylindrical_quarter_turn_x
    (br bt x y : ℝ) :
    -(br*(-x) + bt*y) = br*x-bt*y := by
  ring

theorem cylindrical_quarter_turn_y
    (br bt x y : ℝ) :
    br*y+bt*x = -(-br*y-bt*x) := by
  ring

/-- The meridional baseline moment density is rotation-invariant. -/
theorem meridional_moment_density
    (br bt bz r z : ℝ) :
    z*(br^2+bt^2-2*bz^2)+br*bz*r =
      (br^2+bt^2-2*bz^2)*z+r*br*bz := by
  ring

end Newton400.Case006CylindricalTorque
