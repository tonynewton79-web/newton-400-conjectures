import Mathlib
import NewtonConjectures.PoissonCapGate

/-!
# The concrete axial Poisson kernel

This file starts the remaining analytic-to-concrete step. It uses the
one-variable axial specialization of the n-dimensional ball's Euclidean
Poisson kernel. The normalized spherical measure and harmonicity of the
full vector-valued Poisson extension remain separate pending gates.
-/

namespace Newton400.PoissonCap

noncomputable def axialPoissonKernel (n : ℕ) (r t : ℝ) : ℝ :=
  (1 - r ^ 2) * (1 + r ^ 2 - 2 * r * t) ^ (-(n : ℝ) / 2)

/-- The axial kernel is strictly positive at the evaluation radius. -/
theorem axial_kernel_half_positive (n : ℕ) (t : ℝ) (ht : t ≤ 1) :
    0 < axialPoissonKernel n (1 / 2) t := by
  have hden : (0 : ℝ) < 5 / 4 - t := by linarith
  have heq : (1 : ℝ) + (1 / 2 : ℝ) ^ 2 -
      2 * (1 / 2 : ℝ) * t = 5 / 4 - t := by ring
  change 0 < (1 - (1 / 2 : ℝ) ^ 2) *
    (((1 : ℝ) + (1 / 2 : ℝ) ^ 2 - 2 * (1 / 2 : ℝ) * t) ^ (-(n : ℝ) / 2))
  rw [heq]
  exact mul_pos (by norm_num) (Real.rpow_pos_of_pos hden _)

/-- The exact one-dimensional axial squared-distance derivative at r=1/2. -/
theorem axial_denominator_hasDerivAt (t : ℝ) :
    HasDerivAt (fun r : ℝ => 1 + r ^ 2 - 2 * r * t) (1 - 2 * t) (1 / 2) := by
  convert ((hasDerivAt_const (1 / 2 : ℝ) (1 : ℝ)).add
    ((hasDerivAt_id (1 / 2 : ℝ)).pow 2)).sub
    (((hasDerivAt_id (1 / 2 : ℝ)).const_mul 2).mul_const t) using 1 <;> norm_num [id] <;> ring

/-- The exact axial Poisson derivative follows from the power rule.
    This is the actual parameter derivative, not an abstract hypothesis. -/
theorem axial_kernel_hasDerivAt (n : ℕ) (t : ℝ) (ht : t ≤ 1) :
    HasDerivAt (fun r : ℝ => axialPoissonKernel n r t)
      (-(5 / 4 - t) ^ (-(n : ℝ) / 2) +
        (3 / 4 : ℝ) * ((1 - 2 * t) * (-(n : ℝ) / 2) *
          (5 / 4 - t) ^ (-(n : ℝ) / 2 - 1))) (1 / 2) := by
  have hden : (0 : ℝ) < 5 / 4 - t := by linarith
  have hb : (1 : ℝ) + (1 / 2 : ℝ) ^ 2 -
      2 * (1 / 2 : ℝ) * t = 5 / 4 - t := by ring
  have hnum : HasDerivAt (fun r : ℝ => 1 - r ^ 2) (-1) (1 / 2) := by
    convert (hasDerivAt_const (1 / 2 : ℝ) (1 : ℝ)).sub
      ((hasDerivAt_id (1 / 2 : ℝ)).pow 2) using 1 <;> norm_num [id] <;> ring
  have hbase := axial_denominator_hasDerivAt t
  have hpow := hbase.rpow_const
    (p := -(n : ℝ) / 2) (Or.inl (by rw [hb]; exact ne_of_gt hden))
  have hprod := hnum.mul hpow
  convert hprod using 1 <;> simp [axialPoissonKernel, hb] <;> ring

/-- The exact identity linking the derivative of the true axial kernel
    to the strictly positive cap-score multiplier, for every n. -/
theorem axial_kernel_score_identity (n : ℕ) (t : ℝ) (ht : t ≤ 1) :
    (3 / 4 : ℝ) * deriv (fun r : ℝ => axialPoissonKernel n r t) (1 / 2) =
      axialPoissonKernel n (1 / 2) t *
        (-1 + (3 * (n : ℝ) / 4) *
          ((t - 1 / 2) / (5 / 4 - t))) := by
  have hBpos : (0 : ℝ) < 5 / 4 - t := by linarith
  have hBne : (5 / 4 : ℝ) - t ≠ 0 := ne_of_gt hBpos
  have hpoint : axialPoissonKernel n (1 / 2) t =
      (3 / 4 : ℝ) * (5 / 4 - t) ^ (-(n : ℝ) / 2) := by
    unfold axialPoissonKernel
    have hb : (1 : ℝ) + (1 / 2 : ℝ) ^ 2 -
        2 * (1 / 2 : ℝ) * t = 5 / 4 - t := by ring
    rw [hb]
    norm_num
  have hpow :
      (5 / 4 - t) ^ (-(n : ℝ) / 2 - 1) =
        (5 / 4 - t) ^ (-(n : ℝ) / 2) / (5 / 4 - t) := by
    rw [Real.rpow_sub hBpos]
    simp
  rw [(axial_kernel_hasDerivAt n t ht).deriv, hpoint, hpow]
  field_simp
  ring


/-- The genuine axial Poisson derivative strictly dominates n times the
    actual kernel throughout the chosen cap, uniformly in all n >= 3. -/
theorem axial_poisson_strict_derivative
    (n : ℕ) (hn : 3 ≤ n) (t : ℝ)
    (ht : (49 / 50 : ℝ) < t) (ht1 : t ≤ 1) :
    (n : ℝ) * axialPoissonKernel n (1 / 2) t <
      (3 / 4 : ℝ) *
        deriv (fun r : ℝ => axialPoissonKernel n r t) (1 / 2) := by
  rw [axial_kernel_score_identity n t ht1]
  have hscore := all_dimensions_cap_score n hn t ht ht1
  have hkernel := axial_kernel_half_positive n t ht1
  have hstrict := mul_lt_mul_of_pos_left hscore hkernel
  simpa only [mul_comm] using hstrict


end Newton400.PoissonCap
