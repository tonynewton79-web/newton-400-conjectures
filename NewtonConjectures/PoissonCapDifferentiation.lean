import NewtonConjectures.PoissonCapIntegral
import Mathlib.Analysis.Calculus.ParametricIntegral

/-!
# Analytic bridge through mathlib differentiation under the integral

This proves a REAL derivative-under-integral and strict integrated inequality
from explicit domination/differentiability hypotheses for a parameter-dependent
integrand F and derivative G. It is an analytic *interface theorem*; the
hypotheses identifying F and G with the actual Poisson kernel and its
derivative must still be independently proved in Lean.

There are no custom axioms, sorry, or hidden integral-identification steps.
-/

namespace Newton400.PoissonCap

open MeasureTheory Filter

/-- Strict cap inequality for the derivative of a parameter integral,
    provided the pointwise kernel and derivative identities, and the
    dominated-derivative hypotheses, actually hold. -/
theorem parameter_integral_derivative_cap
    {α : Type*} [MeasurableSpace α]
    (μ : Measure α) (n : ℕ) (hn : 3 ≤ n)
    (w t : α → ℝ) (F G : ℝ → α → ℝ)
    (s : Set ℝ) (bound : α → ℝ)
    (hμ : 0 < μ Set.univ)
    (hw : ∀ x, 0 < w x)
    (ht : ∀ x, (49 / 50 : ℝ) < t x)
    (ht1 : ∀ x, t x ≤ 1)
    (hwint : Integrable w μ)
    (hsint : Integrable
      (fun x => w x * (-1 + (3 * (n : ℝ) / 4) *
        ((t x - 1 / 2) / (5 / 4 - t x)))) μ)
    (hF0 : ∀ x, F (1 / 2) x = w x)
    (hG0 : ∀ x, G (1 / 2) x =
      (4 / 3 : ℝ) * w x *
        (-1 + (3 * (n : ℝ) / 4) *
        ((t x - 1 / 2) / (5 / 4 - t x))))
    (hs : s ∈ 𝓝 (1 / 2 : ℝ))
    (hF_meas : ∀ᶠ r in 𝓝 (1 / 2 : ℝ), AEStronglyMeasurable (F r) μ)
    (hF_int : Integrable (F (1 / 2)) μ)
    (hG_meas : AEStronglyMeasurable (G (1 / 2)) μ)
    (h_bound : ∀ᵐ x ∂μ, ∀ r ∈ s, ‖G r x‖ ≤ bound x)
    (h_bound_int : Integrable bound μ)
    (h_diff : ∀ᵐ x ∂μ, ∀ r ∈ s,
      HasDerivAt (fun v => F v x) (G r x) r) :
    (n : ℝ) * (∫ x, F (1 / 2) x ∂μ) <
      (3 / 4 : ℝ) *
        deriv (fun v => ∫ x, F v x ∂μ) (1 / 2) := by
  have hmain := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := F) (F' := G) (bound := bound) hs
    hF_meas hF_int hG_meas h_bound h_bound_int h_diff
  have hderiv :
      deriv (fun v => ∫ x, F v x ∂μ) (1 / 2) =
        ∫ x, G (1 / 2) x ∂μ := hmain.2.deriv
  have hp :
      (∫ x, F (1 / 2) x ∂μ) = ∫ x, w x ∂μ := by
    congr 1
    funext x
    exact hF0 x
  let S : α → ℝ := fun x =>
    -1 + (3 * (n : ℝ) / 4) * ((t x - 1 / 2) / (5 / 4 - t x))
  have hscore :
      (n : ℝ) * (∫ x, w x ∂μ) < ∫ x, w x * S x ∂μ :=
    positive_measure_cap_average μ n hn w t hμ hw ht ht1 hwint hsint
  have hG :
      (∫ x, G (1 / 2) x ∂μ) =
        (4 / 3 : ℝ) * (∫ x, w x * S x ∂μ) := by
    calc
      (∫ x, G (1 / 2) x ∂μ) =
          ∫ x, (4 / 3 : ℝ) * (w x * S x) ∂μ := by
            congr 1
            funext x
            dsimp [S]
            rw [hG0 x]
            ring
      _ = _ := integral_const_mul _ _
  calc
    (n : ℝ) * (∫ x, F (1 / 2) x ∂μ) =
        (n : ℝ) * (∫ x, w x ∂μ) := by rw [hp]
    _ < ∫ x, w x * S x ∂μ := hscore
    _ = (3 / 4 : ℝ) *
          deriv (fun v => ∫ x, F v x ∂μ) (1 / 2) := by
          rw [hderiv, hG]
          ring

end Newton400.PoissonCap
