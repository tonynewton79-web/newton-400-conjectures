import Mathlib

/-!
Case 006 Appendix W: exact finite algebra from the flat-boundary model.
Log-concavity, the Hardy integral bound, adaptive mollification and
the H8 PDE are proved in the manuscript, NOT Lean-formalized here.
-/
namespace Newton400.Case006FlatBoundaryAdaptive

private def kappa : ℚ := 15971 / 122900
private def radialCap : ℚ := kappa / 2
private def axialCap : ℚ := kappa / 8

theorem cone_capacities :
    radialCap = (15971 : ℚ) / 245800 ∧
    axialCap = (15971 : ℚ) / 983200 := by
  constructor <;> norm_num [radialCap, axialCap, kappa]

theorem radial_Hardy_budget (L Lr w q : ℝ)
    (hq : q ≤ (L*Lr/2)*w) :
    2*q ≤ (L*Lr)*w := by
  nlinarith

theorem antisymmetric_source (lam x : ℝ) :
    lam*((1-x)-(1/2:ℝ)) = -(lam*(x-(1/2:ℝ))) := by
  ring

theorem strict_rational_boundary_example :
    2*(kappa/4) = kappa/2 ∧ kappa/2 < kappa := by
  constructor <;> norm_num [kappa]

theorem reserve_algebra (sigma R : ℝ)
    (hR : R ≤ (1-sigma/2)/(1-sigma))
    (h : 0 < 1-sigma) :
    (1-sigma)*R ≤ 1-sigma/2 := by
  exact (le_div_iff₀ h).mp hR

theorem derivative_commutator_jet
    (f mollified hgradient eps A : ℝ) :
    mollified - (hgradient/eps)*A =
      mollified - hgradient*(A/eps) := by
  ring

end Newton400.Case006FlatBoundaryAdaptive
