import Mathlib
/-! Case006 Appendix AD: finite algebra only; flat integrals and H8 not Lean-formalized. -/
namespace Newton400.Case006SeparableShear
private def alpha : ℚ := -(4443 / 9832)
private def kappa : ℚ := 15971 / 122900
theorem radial_wronskian (b db mu x : ℝ) :
 b*(mu*b+(1+mu*x)*db)-(1+mu*x)*b*db=mu*b^2 := by ring
theorem symmetric_tilt_normalization (mu m0 m1 : ℝ)
 (hm0 : m0=1) (hm1 : m1=0) : m0+mu*m1=1 := by
 rw [hm0,hm1]; ring
theorem pair_tilt_sign : ((1:ℚ)/2)*(-1/2)/2=-1/8 := by norm_num
theorem frozen_diagnostic_shear (v : ℝ) :
 -(v/8)=(-(4443:ℝ)/9832)*((1229:ℝ)/4443*v) := by ring
theorem physical_shear_center_inside_cone :
 alpha-kappa<alpha ∧ alpha<alpha+kappa := by
 constructor <;> norm_num [alpha,kappa]
theorem single_profile_misses_source_cone : kappa< -alpha := by
 norm_num [alpha,kappa]
theorem compact_source_zero_defect (T R : ℝ)
 (h : T=(-(4443:ℝ)/9832)*R) :
 T-(-(4443:ℝ)/9832)*R=0 := by rw [h]; ring
end Newton400.Case006SeparableShear
