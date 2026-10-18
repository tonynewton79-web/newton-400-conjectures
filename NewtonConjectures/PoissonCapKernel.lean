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
    (((hasDerivAt_id (1 / 2 : ℝ)).const_mul 2).mul_const t) using 1 <;> ring

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
      ((hasDerivAt_id (1 / 2 : ℝ)).pow 2) using 1 <;> ring
  have hbase := axial_denominator_hasDerivAt t
  have hpow := hbase.rpow_const
    (p := -(n : ℝ) / 2) (Or.inl (by rw [hb]; exact ne_of_gt hden))
  have hprod := hnum.mul hpow
  convert hprod using 1 <;> simp [axialPoissonKernel, hb] <;> ring

end Newton400.PoissonCap
