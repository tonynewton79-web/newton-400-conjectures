import Mathlib

/-!
Case 006 Appendix U: exact finite angular cone and discrete cut algebra.

The Appendix's equivalence of weighted infinite-dimensional dual tests
and bounded weak angular stress is proved using Hahn--Banach in the
research manuscript. It is NOT formalized here. These Lean theorems
are exact rational and finite-dimensional supporting checks only.
-/
namespace Newton400.Case006AngularWeakDuality

private def kappa : ℚ := 15971 / 122900
private def radialCapacity : ℚ := kappa / 2
private def axialCapacity : ℚ := kappa / 8

theorem radial_capacity_exact :
    radialCapacity = (15971 : ℚ) / 245800 := by
  norm_num [radialCapacity, kappa]

theorem axial_capacity_exact :
    axialCapacity = (15971 : ℚ) / 983200 := by
  norm_num [axialCapacity, kappa]

/-- The capacity of the cut isolating one grid corner. -/
theorem singleton_cut_capacity :
    radialCapacity + axialCapacity = (5 : ℚ) * kappa / 8 := by
  norm_num [radialCapacity, axialCapacity, kappa]

/-- The manufactured radial dipole passes axial slice sums but fails
    the singleton cut when its charge is kappa. -/
theorem radial_cut_strict_obstruction :
    radialCapacity + axialCapacity < kappa := by
  norm_num [radialCapacity, axialCapacity, kappa]

theorem radial_cut_gap :
    kappa - (radialCapacity + axialCapacity) = (3 : ℚ) * kappa / 8 := by
  norm_num [radialCapacity, axialCapacity, kappa]

theorem axial_slice_zero (q : ℚ) : q + (-q) = 0 := by
  ring

/-- A radial flow of kappa/4 fits the allowed radial edge capacity. -/
theorem feasible_radial_flow :
    kappa / 4 ≤ radialCapacity := by
  norm_num [radialCapacity, kappa]

/-- The angular-only seven-ray coefficient norm is jointly
    max(2|C|,8|B|), with A=D=0. -/
theorem angular_joint_norm (B C : ℝ) :
    max (max (|2*C|) (|-2*C|))
        (max (|8*B|) (|-8*B|)) =
      max (2*|C|) (8*|B|) := by
  simp [abs_mul, abs_neg, max_self]

/-- At radial cone saturation C=k rho/2, the two ±2C−4D
    inequalities force D=0, an exact meridional rigidity gate. -/
theorem radial_saturation_forces_D
    (C D k rho : ℝ)
    (hsat : 2*C = k*rho)
    (hp : |2*C-4*D| ≤ k*rho)
    (hm : |-2*C-4*D| ≤ k*rho) : D = 0 := by
  rcases abs_le.mp hp with ⟨hpl,hpu⟩
  rcases abs_le.mp hm with ⟨hml,hmu⟩
  linarith

end Newton400.Case006AngularWeakDuality
