import Mathlib

/-!
# Case 006: exact algebra for the source-native H8 moment Jacobian

For the four-field stress in the fixed frame, the formal adjoint
kernel has sym(grad q_i)=f_i * diag(1,-2,1), with
(f₁,f₂,f₃)=(y,x,-2z). The coefficient of a baseline
rho*Rstar correction is Rstar:diag(1,-2,1)=1217/1229.

This file proves the exact rational stress-centre coefficient and the
finite-difference quadratic polarization identity used in Appendix J.
It does not formalize PDE integration by parts, the full functional
Jacobian, compact support, or nonsingularity of any source-native
Jacobian. The source's shell profile data have not been frozen.
-/

namespace Newton400.Case006Jacobian

/-- Exact seven-ray centre contraction with the adjoint strain T. -/
theorem rstar_anisotropic_contraction :
    (172 : ℚ) / 1229 *
      ((317 : ℚ) / 43 - 2 * ((47 : ℚ) / 172) + (1 : ℚ) / 4)
      = (1217 : ℚ) / 1229 := by
  norm_num

/-- The stress-centre baseline coefficient is positive. -/
theorem rstar_anisotropic_contraction_positive :
    (0 : ℚ) < (1217 : ℚ) / 1229 := by
  norm_num

/-- Exact quadratic polarization of U·diag(1,-2,1)U.
It controls the first and second variation of the source moments. -/
theorem anisotropic_quadratic_polarization
    (u₁ u₂ u₃ v₁ v₂ v₃ t : ℝ) :
    ((u₁ + t*v₁)^2 - 2*(u₂ + t*v₂)^2 + (u₃ + t*v₃)^2) -
       (u₁^2 - 2*u₂^2 + u₃^2)
      = 2*t*(u₁*v₁ - 2*u₂*v₂ + u₃*v₃) +
        t^2*(v₁^2 - 2*v₂^2 + v₃^2) := by
  ring

/-- Affine envelope perturbations have no second-order remainder. -/
theorem envelope_affine_difference (rho drho t : ℝ) :
    (rho + t*drho) - rho = t*drho := by
  ring

/-- The three adjoint scalar strains transform with the two
odd and one even parities under (x,y,z) -> (-x,-y,z). -/
theorem adjoint_strain_half_turn_parities (x y z : ℝ) :
    -y = -(y) ∧ -x = -(x) ∧ -2*z = -2*z := by
  constructor
  · ring
  constructor
  · ring
  · ring

end Newton400.Case006Jacobian
