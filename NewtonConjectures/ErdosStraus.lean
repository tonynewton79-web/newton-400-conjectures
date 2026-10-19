import Mathlib

/-!
# Erdős–Straus: exact López Type A / Type B algebra

The statements below are conditional algebraic results.  No theorem here asserts
the universal existence of López parameters, nor that the square-root search
always succeeds for primes congruent to one modulo 24.

Verification status is established by successful GitHub Actions compilation,
not merely by uploading this source.
-/

namespace Newton400.ErdosStraus

/-- Algebraic factorization underlying López Type B. -/
theorem typeB_factorization
    (p d u v : ℤ) (h : p = 4 * d * u * v - u - v) :
    4 * d * p + 1 = (4 * d * u - 1) * (4 * d * v - 1) := by
  rw [h]
  ring

/-- Conversely, a factor pair of the required form produces the Type B numerator. -/
theorem typeB_from_factorization
    (p d u v : ℤ)
    (h : 4 * d * p + 1 = (4 * d * u - 1) * (4 * d * v - 1))
    (hd : d ≠ 0) :
    p = 4 * d * u * v - u - v := by
  have hdiff : 4 * d * (p - (4 * d * u * v - u - v)) = 0 := by
    nlinarith [h]
  exact sub_eq_zero.mp (mul_eq_zero.mp hdiff |>.resolve_left (by omega))

/-- The rational identity associated with the López Type B numerator. -/
theorem typeB_fraction (p d u v : ℚ)
    (hp : p ≠ 0) (hd : d ≠ 0) (hu : u ≠ 0) (hv : v ≠ 0)
    (h : 4 * d * u * v = p + u + v) :
    4 / p = 1 / (d * u * v) + 1 / (d * u * p) + 1 / (d * v * p) := by
  field_simp
  nlinarith [h]

/-- The López Type A numerator follows from the original congruence. -/
theorem typeA_parameter_identity (p d r t : ℤ)
    (h : p + 4 * d = (4 * d * r - 1) * t) :
    (4 * d * r - 1) * (r * t - 1) = 1 + r * p := by
  calc
    (4 * d * r - 1) * (r * t - 1) =
        r * (p + 4 * d) - (4 * d * r - 1) := by rw [h]; ring
    _ = 1 + r * p := by ring

/-- The rational identity associated with López Type A. -/
theorem typeA_fraction (p d r u : ℚ)
    (hp : p ≠ 0) (hd : d ≠ 0) (hr : r ≠ 0) (hu : u ≠ 0)
    (h : (4 * d * r - 1) * u = 1 + r * p) :
    4 / p = 1 / (d * u) + 1 / (d * r * p) +
      1 / (d * u * r * p) := by
  field_simp
  nlinarith [h]


/-- For d <= 3, a Type B factor q at or below sqrt(4dp+1)
    gives dr = (q+1)/4 at or below sqrt(p), expressed without radicals. -/
theorem typeB_small_factor_square_bound (p d q : ℝ)
    (hp : 4 ≤ p) (hd : d ≤ 3) (hq : 0 ≤ q)
    (hsmall : q ^ 2 ≤ 4 * d * p + 1) :
    (q + 1) ^ 2 ≤ 16 * p := by
  have hp0 : 0 ≤ p := by linarith
  have hmul : d * p ≤ 3 * p := mul_le_mul_of_nonneg_right hd hp0
  have hq2 : q ^ 2 ≤ 12 * p + 1 := by nlinarith [hmul]
  have hquad : 0 ≤ p * (p - 4) := mul_nonneg (by linarith) (by linarith)
  have hqlinear : q ≤ 2 * p - 1 := by
    by_contra hn
    have hstrict : 2 * p - 1 < q := lt_of_not_ge hn
    have hgap : 0 < (q - (2 * p - 1)) * (q + (2 * p - 1)) :=
      mul_pos (by linarith) (by linarith)
    nlinarith [hgap, hquad, hq2]
  nlinarith [hq2, hqlinear]

/-- For d <= 6 and p >= 7, a Type A small factor similarly guarantees
    the squared square-root estimate. -/
theorem typeA_small_factor_square_bound (p d q : ℝ)
    (hp : 7 ≤ p) (hd : d ≤ 6) (hq : 0 ≤ q)
    (hsmall : q ^ 2 ≤ p + 4 * d) :
    (q + 1) ^ 2 ≤ 16 * p := by
  have hd4 : 4 * d ≤ 24 := by linarith
  have hq2 : q ^ 2 ≤ p + 24 := by linarith
  have hquad : 0 ≤ (p - 7) * (p + 4) :=
    mul_nonneg (by linarith) (by linarith)
  have hqlinear : q ≤ p - 1 := by
    by_contra hn
    have hstrict : p - 1 < q := lt_of_not_ge hn
    have hgap : 0 < (q - (p - 1)) * (q + (p - 1)) :=
      mul_pos (by linarith) (by linarith)
    nlinarith [hgap, hquad, hq2]
  nlinarith [hq2, hqlinear]


/-- Transfer between the shifted Type C divisor and its fraction numerator. -/
theorem typeC_shift_identity (p d r : ℤ) :
    r * (p + 4 * d * d) - (d + r * p) =
      d * (4 * d * r - 1) := by
  ring

/-- Exact rational identity for López's additional Type C construction. -/
theorem typeC_fraction (p d r v : ℚ)
    (hp : p ≠ 0) (hd : d ≠ 0) (hr : r ≠ 0) (hv : v ≠ 0)
    (h : (4 * d * r - 1) * v = d + r * p) :
    4 / p = 1 / (r * v * p) + 1 / (d * v) +
      1 / (d * r * p) := by
  field_simp
  nlinarith [h]

/-- A Type C witness substantially shorter than the known Type A/B
    minimum for the selected difficult prime. -/
theorem typeC_hard_witness :
    (4 * 2 * 7 - 1 : ℤ) * 144561975 =
      2 + 7 * 1135844089 := by
  norm_num

theorem typeC_hard_fraction :
    (4 : ℚ) / 1135844089 =
      1 / 1149399053585410425 +
      1 / 289123950 +
      1 / 15901817246 := by
  norm_num

/-- The exact Type B integer witness from the finite search. -/
theorem witness_68821 :
    (68821 : ℤ) = 4 * 11 * 29 * 54 - 29 - 54 := by
  norm_num

theorem witness_68821_product :
    (262 : ℕ) < 11 * 29 := by
  norm_num

/-- A verified integer Type A witness for a larger hard prime. -/
theorem witness_1135844089 :
    (1135844089 : ℤ) + 4 * 86 = (4 * 86 * 83 - 1) * 39783 := by
  norm_num

/-- Independently check the three integer denominators. -/
theorem fraction_68821 :
    (4 : ℚ) / 68821 =
      1 / 17226 + 1 / 21953899 + 1 / 40879674 := by
  norm_num

end Newton400.ErdosStraus
