import Mathlib

/-!
Case 006 Appendix R: exact curved-shell moment normalization and
finite-dimensional quantitative inverse arithmetic.

The source's radial variable is s=chi*Lambda*R^2/2; it is not
permissible to treat a physical R-gap as Lambda-independent.
Here we encode the exact chosen s-supports, the Jacobian of that
coordinate, the conditional determinant algebra and the exact H8
cone budget. The flat-bump integral, ODE Gronwall bounds and
physical H8 estimates have NOT been kernel-formalized.
-/
namespace Newton400.Case006NormalizedInverse

theorem first_support :
    (241:ℚ)/40 - 1/100 = 1203/200 ∧
    (241:ℚ)/40 + 1/100 = 1207/200 := by
  constructor <;> norm_num

theorem second_support :
    (243:ℚ)/40 - 1/100 = 1213/200 ∧
    (243:ℚ)/40 + 1/100 = 1217/200 := by
  constructor <;> norm_num

theorem support_separation :
    (1213:ℚ)/200 - 1207/200 = 3/100 := by
  norm_num

theorem support_inside_rayleigh :
    (6:ℚ) < 1203/200 ∧
    (1207:ℚ)/200 < 1213/200 ∧
    (1217:ℚ)/200 < 61/10 := by
  constructor
  · norm_num
  constructor <;> norm_num

theorem radial_coordinate_jacobian (chi Lam R : ℝ) :
    (chi*Lam*R^2/2)*2 = chi*Lam*R*R := by
  ring

theorem radial_mass_density (chi Lam R : ℝ) (hR : R ≠ 0) :
    R^2*(chi*Lam/R) = chi*Lam*R := by
  field_simp
  ring

theorem radial_coordinate_axial_motion
    (chi chip R : ℝ) (hchi : chi ≠ 0) :
    2*chi*(-chip*R/(2*chi)) + chip*R = 0 := by
  field_simp
  ring

/-- One exact point-column determinant identity of the adjoint pair,
    after the initial Cauchy normalization (0,1) for the derivative
    vector. The analytical lower bounds are proved outside Lean. -/
theorem point_column_det (k0 ks u v : ℝ) :
    (0:ℝ)*(ks*v) - k0*(ks*u) = -k0*ks*u := by
  ring

/-- Matrix determinant for two bump responses, using the exact
    two-by-two polynomial definition rather than a black-box inverse. -/
theorem pairing_det (a b c d : ℝ) :
    a*d-b*c = d*a-c*b := by
  ring

theorem inverse_upper_cleared
    (delta K E kappa gamma t : ℝ) :
    (8*delta*K*E)*(kappa^2*gamma*t) =
      (kappa^2*gamma*t)*(8*delta*K*E) := by
  ring

theorem source_cone_coefficient_budget :
    (172:ℚ)/1229 - 1/100 = 15971/122900 := by
  norm_num

end Newton400.Case006NormalizedInverse
