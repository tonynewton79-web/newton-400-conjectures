import Mathlib

/-!
Case 006 Appendix AA. Finite algebra supporting the explicit
unweighted compact meridional curl reconstruction.

The smooth compact Green solution, integration by parts,
double-primitive support and pressure reconstruction are NOT
end-to-end proved in Lean here.
-/
namespace Newton400.Case006MeridionalMomentRepair

/-- The two operators combine into the pressure-free meridional curl jet. -/
theorem curl_operator_split
    (Err Ezz Er E Drz Dz r : ℝ) :
    (Err-Ezz+Er/r-E/r^2)+(2*Drz+Dz/r) =
    Err-Ezz+2*Drz+Er/r-E/r^2+Dz/r := by
  ring

/-- Exact nontrivial radial normalization constants from the
polynomial support diagnostic in Appendix AA. -/
theorem radial_normalization_values :
    (153:ℚ)/100-3/2=3/100 ∧
    (-21000:ℚ)*(-1/21000)=1 := by
  constructor <;> norm_num

/-- The rank-one correction eliminates a radial moment in the
half-density equation, once the integrals of xi are (0,1).
This lemma checks the finite algebra only. -/
theorem rank_one_radial_repair
    (a M0 M2 aZZ : ℝ)
    (hm0 : M0 = 0) (hm2 : M2 = 1) :
    (-(3/4:ℝ)*(-4/3*a)*M2) -
      (-(4/3:ℝ)*aZZ*M0) = a := by
  rw [hm0,hm2]
  ring

/-- The recovered double primitive contributes 2v_{rz}. -/
theorem double_primitive_jet (h : ℝ) :
    2*(h/2)=h := by ring

/-- Compact axial-force reduction after radial integration by parts:
the weight derivative of r^2 is 2r. -/
theorem axial_force_weight_jet (r fz : ℝ) :
    -(2*r)*fz = -2*(r*fz) := by ring

/-- The two formal radial adjoint coefficient cancellations for
weights 1 and r^2, encoded after differentiation. -/
theorem adjoint_constant_weight_jet (r : ℝ) (hr : r ≠ 0) :
    (1/r^2)-(1/r^2)=0 := by ring

theorem adjoint_quadratic_weight_jet (r : ℝ) :
    2-1-1= (0:ℝ) := by norm_num

/-- A cone estimate is NOT supplied by the compact reconstruction.
The following is only the exact rational reserve. -/
theorem cone_reserve :
    (172:ℚ)/1229-1/100=15971/122900 := by
  norm_num

end Newton400.Case006MeridionalMomentRepair
