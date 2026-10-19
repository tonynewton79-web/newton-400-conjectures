import Mathlib

/-!
Case 006 Appendix P: exact *algebraic* audit of the axial-viscous torque operator.
The real integral/ODE compact-support solvability theorem is proved in
Appendix P but is NOT an end-to-end Lean theorem in this module.
-/
namespace Newton400.Case006ExactViscousActuator

/-- Exact product expansion in Eq. (251), retaining axial viscosity. -/
theorem actuator_jet_expansion
    (Bp B M Mp Mpp A Ap App gamma delta : ℝ) :
    Bp*A + B*Ap - gamma*M*A -
      delta*(Mpp*A+2*Mp*Ap+M*App) =
    -delta*M*App + (B-2*delta*Mp)*Ap +
      (Bp-gamma*M-delta*Mpp)*A := by
  ring

/-- Formal pointwise Green identity with independent jet symbols.
The derivative and integration operations remain outside Lean. -/
theorem formal_green_jet
    (B Bp M Mp Mpp A Ap App phi phip phipp gamma delta : ℝ) :
    phi*(Bp*A+B*Ap-gamma*M*A-
      delta*(Mpp*A+2*Mp*Ap+M*App)) -
      A*(-B*phip-gamma*M*phi-delta*M*phipp) =
    Bp*A*phi+B*Ap*phi+B*A*phip -
      delta*(phi*(Mpp*A+2*Mp*Ap+M*App)-phipp*M*A) := by
  ring

/-- Small-positive-viscosity proxy consistent with h=1/12. -/
theorem proxy_characteristic_factorization (lam : ℚ) :
    (1/75 : ℚ)*lam^2 + (101/75 : ℚ)*lam + 4/3 =
      (lam+1)*(lam+100)/75 := by
  ring

theorem slow_adjoint_root :
    (1/75 : ℚ)*(-1)^2 + (101/75)*(-1) + 4/3 = 0 := by
  norm_num

theorem fast_adjoint_root :
    (1/75 : ℚ)*(-100)^2 + (101/75)*(-100) + 4/3 = 0 := by
  norm_num

/-- The formal Wronskian for two exponentials with rates -1 and -100. -/
theorem slow_fast_wronskian (u v : ℝ) :
    u*(-100*v)-(-u)*v = -99*u*v := by
  ring

/-- Pure algebra behind the integrated no-one-sign amplitude condition.
The integration-by-parts argument is not formalized in Lean. -/
theorem zero_integrated_mass
    (gamma mass : ℝ) (hgamma : gamma ≠ 0)
    (h : -gamma*mass = 0) : mass = 0 := by
  have hm : gamma*mass=0 := by linarith
  exact (mul_eq_zero.mp hm).resolve_left hgamma

end Newton400.Case006ExactViscousActuator
