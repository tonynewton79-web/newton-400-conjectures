import Mathlib
/-! Case006 Appendix Y: finite meridional residual cone algebra.
This does not formalize Hahn--Banach, de Rham, PDE or original H8. -/
namespace Newton400.Case006MeridionalCoupling
private def kappa : ℚ := 15971 / 122900
theorem shifted_meridional_variable (E B : ℝ) :
    (E+4*B)-4*B=E := by ring
theorem upper_endpoint_support (k c p s : ℝ) :
    (k/2-2*((k-2*c)/4))*p+((k-2*c)/4)*s =
      c*p+((k-2*c)/4)*s := by ring
theorem saturated_radial_forces_D
    (C D k : ℝ) (hsat : 2*C=k)
    (hplus : |2*C-4*D|≤k)
    (hminus : |-2*C-4*D|≤k) : D=0 := by
  rcases abs_le.mp hplus with ⟨hl1,hu1⟩
  rcases abs_le.mp hminus with ⟨hl2,hu2⟩
  linarith
theorem manufactured_example_rational :
    (8:ℚ)*(kappa/64)=kappa/8 ∧
    2*(kappa/16)+4*(kappa/32)=kappa/4 ∧
    2*(kappa/8)+4*(kappa/32)=3*kappa/8 := by
  constructor
  · norm_num [kappa]
  constructor <;> norm_num [kappa]
theorem manufactured_cone_strict :
    (3:ℚ)*kappa/8<kappa := by norm_num [kappa]
theorem reserved_meridional_box
    (k tau c e d : ℝ)
    (hk : 0≤k) (ht0 : 0≤tau) (ht1 : tau≤1)
    (hc : 2*|c|≤(1-tau)*k)
    (he : |e|≤k/4) (hd : |d|≤tau*k/8) :
    2*|c|+4*|d|≤k ∧ 2*|e|+4*|d|≤k := by
  have htk : tau*k≤k := by
    nlinarith [mul_nonneg (sub_nonneg.mpr ht1) hk]
  have htpos : 0 ≤ tau*k := mul_nonneg ht0 hk
  constructor <;> nlinarith
end Newton400.Case006MeridionalCoupling
