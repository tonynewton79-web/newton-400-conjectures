import Mathlib

/-!
Case 006, Appendix X: exact finite polynomial algebra for a Piola-homotopy
divergence-preserving smoother on a flat H8 angular envelope.

This file verifies the cofactor matrix cancellation and the local
transport Jacobian identity, plus exact rational cone-reserve data.
It does NOT formalize distributional Piola calculus, smoothing,
weighted integrals, or the full H8 / Navier-Stokes theorem.
-/
namespace Newton400.Case006PiolaFlatLifting

/-- Cofactor-type matrix P=(det DF)*DF^{-1} has P*DF=J*I,
for DF=I+u tensor grad(epsilon) in two dimensions. -/
theorem piola_first_diagonal (u v ex ey : ℝ) :
    (1+v*ey)*(1+u*ex) - u*ey*v*ex = 1+u*ex+v*ey := by
  ring

theorem piola_first_offdiagonal (u v ex ey : ℝ) :
    (1+v*ey)*(u*ey) - u*ey*(1+v*ey) = 0 := by
  ring

theorem piola_second_offdiagonal (u v ex ey : ℝ) :
    -(v*ex)*(1+u*ex) + (1+u*ex)*(v*ex) = 0 := by
  ring

theorem piola_second_diagonal (u v ex ey : ℝ) :
    -(v*ex)*(u*ey)+(1+u*ex)*(1+v*ey) =
      1+u*ex+v*ey := by
  ring

/-- The time derivative of J_t f(F_t) coincides with the formal
spatial divergence jet of epsilon*u*f(F_t). These are exactly
polynomial identities; the differential statement is external. -/
theorem transport_homotopy_jet
    (u v ex ey eps t f fx fy : ℝ) :
    (u*ex+v*ey)*f +
      (1+t*(u*ex+v*ey))*eps*(u*fx+v*fy) =
    (u*ex+v*ey)*f +
      eps*(u*fx+v*fy) +
      t*eps*(u*ex+v*ey)*(u*fx+v*fy) := by
  ring

private def kappa : ℚ := 15971/122900
private def radialCapacity : ℚ := kappa/2
private def axialCapacity : ℚ := kappa/8

theorem anisotropic_capacity_ratio :
    radialCapacity = 4*axialCapacity := by
  norm_num [radialCapacity, axialCapacity, kappa]

theorem exact_rational_cone_gate :
    (12469:ℚ)/16128 < 7/8 := by
  norm_num

theorem exact_rational_cone_reserve :
    (1:ℚ) - (1/4)/2 = 7/8 := by
  norm_num

theorem exponential_upper_test :
    (16:ℚ)/1024 < 1 := by
  norm_num

end Newton400.Case006PiolaFlatLifting
