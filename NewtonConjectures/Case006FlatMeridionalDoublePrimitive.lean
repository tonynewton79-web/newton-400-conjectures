import Mathlib

/-!
Case006 Appendix Z. Finite algebraic subclaims for the restricted
flat-boundary meridional double-primitive theorem.

The analytic integration, Hardy estimates, compact support, pressure,
and H8 PDE are NOT end-to-end Lean-formalized here.
-/
namespace Newton400.Case006FlatMeridional

private def kappa : ℚ := 15971 / 122900

theorem curl_scalar_jet
    (Arr Azz Ar A Drz Dz r : ℝ) (hr : r ≠ 0) :
    Arr - Azz + 2*Drz + Ar/r - A/(r*r) + Dz/r =
      (Arr - Azz + Ar/r - A/(r*r)) + (2*Drz + Dz/r) := by
  ring

theorem angular_meridional_shift (E B : ℝ) :
    (E + 4*B) - 4*B = E := by
  ring

theorem radial_factorization_jet
    (r Dz Drz : ℝ) (hr : r ≠ 0) :
    r*(2*Drz + Dz/r) = 2*r*Drz + Dz := by
  field_simp
  ring

theorem manufactured_pressure_radial_jet
    (r Dr D : ℝ) (hr : r ≠ 0) :
    (-Dr-D/r)+(-Dr) = -2*Dr-D/r := by
  ring

theorem manufactured_pressure_axial_jet (Dz : ℝ) :
    Dz + (-Dz) = 0 := by
  ring

theorem strict_joint_cone_budget
    (k tau B C D : ℝ)
    (hk : 0 ≤ k) (ht0 : 0 ≤ tau) (ht1 : tau ≤ 1)
    (hB : 8*|B| ≤ (1-tau)*k)
    (hC : 2*|C| ≤ (1-tau)*k)
    (hD : |D| ≤ tau*k/8) :
    8*|B| ≤ (1-tau/2)*k ∧
    2*|C|+4*|D| ≤ (1-tau/2)*k ∧
    4*|D| ≤ (1-tau/2)*k := by
  have htpos : 0 ≤ tau*k := mul_nonneg ht0 hk
  have hrem : 0 ≤ (1-tau)*k :=
    mul_nonneg (sub_nonneg.mpr ht1) hk
  constructor
  · nlinarith
  constructor <;> nlinarith

theorem rational_example_strength :
    (0:ℚ) < kappa/32 ∧ 8*(kappa/32) < kappa := by
  constructor <;> norm_num [kappa]

theorem radial_cone_coefficient_exact :
    kappa/8 = (15971:ℚ)/983200 := by
  norm_num [kappa]

end Newton400.Case006FlatMeridional
