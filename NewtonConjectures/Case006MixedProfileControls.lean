import Mathlib

/-!
Case 006, Appendix Q: algebraic mixed-profile adjoint torque controls.

Actual source moments M_j=∫R²τ_j and N_j=∫R²Gτ_j define
g_j=N_j/M_j. For the full viscous differential operator
L_j A = ((D*eta*M_j+N_j)*A)' - γ M_j A - δ (M_j A)'',
integration by parts gives the cross-profile density:
  L_j* phi = -M_j[(D*eta+g_j) phi' + γ phi + δ phi''].
If phi solves the *reference* j=0 adjoint ODE, the j=1
density reduces to -M_1(g_1-g_0) phi'.

This file certifies polynomial implications and the exact derivative
Wronskian elimination. It does not formalize compact integration,
axial bump existence, PDE source admissibility or H8 cone bounds.
-/
namespace Newton400.Case006MixedProfile

/-- The source-native cross-profile pairing reduction, conditional on
the reference adjoint's algebraic ODE at the given point. -/
theorem mixed_profile_adjoint_density
    (M g0 g1 D eta gamma delta phi dphi ddphi : ℝ)
    (hode : delta*ddphi + (D*eta+g0)*dphi + gamma*phi = 0) :
    -M*((D*eta+g1)*dphi + gamma*phi + delta*ddphi) =
      -M*(g1-g0)*dphi := by
  calc
    _ = -M*(delta*ddphi + (D*eta+g0)*dphi + gamma*phi) -
          M*(g1-g0)*dphi := by ring
    _ = -M*(g1-g0)*dphi := by rw [hode]; ring

/-- The derivative Wronskian is γ times the original Wronskian,
after multiplication by the exact positive viscosity δ. -/
theorem differentiated_wronskian
    (p1 p2 v1 v2 a1 a2 b gamma delta : ℝ)
    (h1 : delta*a1 + b*v1 + gamma*p1 = 0)
    (h2 : delta*a2 + b*v2 + gamma*p2 = 0) :
    delta*(v1*a2-a1*v2) = gamma*(p1*v2-v1*p2) := by
  calc
    _ = v1*(delta*a2+b*v2+gamma*p2) -
        v2*(delta*a1+b*v1+gamma*p1) +
        gamma*(p1*v2-v1*p2) := by ring
    _ = gamma*(p1*v2-v1*p2) := by rw [h1, h2]; ring

/-- Strict reference shear makes the mixed-profile coefficient nonzero. -/
theorem shear_coefficient_ne_zero
    (M gap : ℝ) (hM : M ≠ 0) (hgap : gap ≠ 0) :
    M*gap ≠ 0 := mul_ne_zero hM hgap

/-- Determinant of a two-control matrix written in polynomial form. -/
def pairingDet (a b c d : ℝ) : ℝ := a*d-b*c

/-- The determinant factorizes when both rows are multiplied by the
same scalar radial shear gap; this is the quadratic response penalty. -/
theorem pairing_det_factor (k a b c d : ℝ) :
    pairingDet (k*a) (k*b) (k*c) (k*d) =
      k^2*pairingDet a b c d := by
  unfold pairingDet
  ring

/-- Cramer's numerator is the desired compatibility moment,
a prerequisite for finite-rank correction. -/
theorem cramer_first_numerator (a b c d u v : ℝ) :
    (u*d-b*v)*a + (a*v-u*c)*b =
    u*(a*d-b*c) := by
  ring

theorem cramer_second_numerator (a b c d u v : ℝ) :
    (u*d-b*v)*c + (a*v-u*c)*d =
    v*(a*d-b*c) := by
  ring

end Newton400.Case006MixedProfile
