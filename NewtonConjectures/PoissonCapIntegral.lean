import NewtonConjectures.PoissonCapGate
import Mathlib

/-!
# Strict positive-measure Poisson-cap integration gate

Unlike the finite sum gate, this theorem genuinely integrates with respect to
an arbitrary measure. Its hypotheses explicitly require the cap coordinate t
to lie in the cap and weights w to be positive, and require two integrability
conditions. The measure must have nonzero total mass.

This does *not* yet identify w as the true spherical Poisson kernel or prove
interchange of differentiation and integration for that concrete kernel.
-/

namespace Newton400.PoissonCap

open MeasureTheory

/-- Genuine strict integral inequality for positive weights supported in the
open spherical-cap coordinate range. Any nonzero measure is allowed. -/
theorem positive_measure_cap_average
    {α : Type*} [MeasurableSpace α]
    (μ : Measure α) (n : ℕ) (hn : 3 ≤ n)
    (w t : α → ℝ)
    (hμ : 0 < μ Set.univ)
    (hw : ∀ x, 0 < w x)
    (ht : ∀ x, (49 / 50 : ℝ) < t x)
    (ht1 : ∀ x, t x ≤ 1)
    (hwint : Integrable w μ)
    (hsint : Integrable
      (fun x => w x * (-1 + (3 * (n : ℝ) / 4) *
        ((t x - 1 / 2) / (5 / 4 - t x)))) μ) :
    (n : ℝ) * (∫ x, w x ∂μ) <
      ∫ x, w x * (-1 + (3 * (n : ℝ) / 4) *
        ((t x - 1 / 2) / (5 / 4 - t x))) ∂μ := by
  let S : α → ℝ := fun x =>
    -1 + (3 * (n : ℝ) / 4) * ((t x - 1 / 2) / (5 / 4 - t x))
  have hpoint (x : α) : (n : ℝ) < S x :=
    all_dimensions_cap_score n hn (t x) (ht x) (ht1 x)
  have hpositive (x : α) : 0 < w x * (S x - (n : ℝ)) :=
    mul_pos (hw x) (sub_pos.mpr (hpoint x))
  have hsi : Integrable (fun x => w x * S x) μ := hsint
  have hfi : Integrable (fun x => w x * (S x - (n : ℝ))) μ := by
    have heq : (fun x => w x * (S x - (n : ℝ))) =
        (fun x => w x * S x - (n : ℝ) * w x) := by
      funext x
      ring
    rw [heq]
    exact hsi.sub (hwint.const_mul _)
  have hsupp : Function.support (fun x => w x * (S x - (n : ℝ))) = Set.univ := by
    ext x
    simp only [Function.mem_support, Set.mem_univ, iff_true]
    exact (hpositive x).ne'
  have hpos : 0 < ∫ x, w x * (S x - (n : ℝ)) ∂μ := by
    apply (integral_pos_iff_support_of_nonneg
      (fun x => le_of_lt (hpositive x)) hfi).2
    rw [hsupp]
    exact hμ
  have heq : (fun x => w x * (S x - (n : ℝ))) =
      (fun x => w x * S x - (n : ℝ) * w x) := by
    funext x
    ring
  rw [heq, integral_sub hsi (hwint.const_mul _), integral_const_mul] at hpos
  change (n : ℝ) * (∫ x, w x ∂μ) < ∫ x, w x * S x ∂μ
  linarith

end Newton400.PoissonCap
