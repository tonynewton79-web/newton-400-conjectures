import Mathlib

/-!
# Poisson-cap gate: exact algebra and uniform score inequality

This is a PARTIAL Lean formalization of the working note
"A Uniform Poisson-Cap Counterexample to a Proposed Schwarz--Pick
Inequality in the Unit Ball" (Tony Newton, 18 October 2026).

Theorems here certify (1) the rational cap threshold, (2) a strict
pointwise score inequality for all real N >= 3 (hence all n >= 3),
and (3) the real-algebra conclusion from a positive Poisson mass
and an integrated strict derivative inequality.

Important: this file DOES NOT YET formalize the Euclidean Poisson kernel,
harmonicity, differentiation under its boundary integral, or the
integration step that establishes the derivative hypothesis.
Therefore compiling this file is NOT a Lean proof of the entire
all-dimensional harmonic counterexample.
-/

namespace Newton400.PoissonCap

/-- At dimension three, the rational score threshold is 49/50. -/
theorem threshold_at_three :
    (49 / 50 : ℚ) = ((13 * 3 + 10 : ℚ) / (14 * 3 + 8)) := by
  norm_num

/-- On the rational cap, the score fraction strictly exceeds 16/9. -/
theorem cap_fraction_gt (t : ℝ)
    (ht : (49 / 50 : ℝ) < t) (ht1 : t ≤ 1) :
    (16 / 9 : ℝ) < (t - 1 / 2) / (5 / 4 - t) := by
  have hden : (0 : ℝ) < 5 / 4 - t := by linarith
  apply (lt_div_iff₀ hden).2
  nlinarith

/-- The pointwise logarithmic-derivative score exceeds N uniformly,
    for all real N >= 3, hence for every integer dimension n >= 3. -/
theorem cap_score_gt (N t : ℝ)
    (hN : 3 ≤ N) (ht : (49 / 50 : ℝ) < t) (ht1 : t ≤ 1) :
    N < -1 + (3 * N / 4) * ((t - 1 / 2) / (5 / 4 - t)) := by
  have hfrac := cap_fraction_gt t ht ht1
  have hNpos : (0 : ℝ) < (3 / 4 : ℝ) * N := by
    have h : (0 : ℝ) < N := by linarith
    positivity
  have hmul := mul_lt_mul_of_pos_left hfrac hNpos
  nlinarith

/-- Integer-dimension interface to the uniform cap-score inequality. -/
theorem all_dimensions_cap_score (n : ℕ) (hn : 3 ≤ n)
    (t : ℝ) (ht : (49 / 50 : ℝ) < t) (ht1 : t ≤ 1) :
    (n : ℝ) <
      -1 + (3 * (n : ℝ) / 4) *
        ((t - 1 / 2) / (5 / 4 - t)) := by
  apply cap_score_gt (n : ℝ) t
  · exact_mod_cast hn
  · exact ht
  · exact ht1

/-- Strict violation follows from an integrated derivative estimate
    D * dp > N * p with 0 < p < 1, D > 0, N > 0.

    In the intended application, p is the positive Poisson-cap
    mass at a, D = 1-|a|^2, dp is its axial derivative,
    and u = 1 - 2p. The analytic assertion D*dp > N*p is
    intentionally a hypothesis, not an axiom or a proved fact. -/
theorem strict_violation_from_derivative
    (N D p dp : ℝ)
    (hN : 0 < N) (hD : 0 < D)
    (hp0 : 0 < p) (hp1 : p < 1)
    (hderiv : N * p < D * dp) :
    (N / 2) * (1 - (1 - 2 * p) ^ 2) <
      D * |(-2 : ℝ) * dp| := by
  have habs : (2 : ℝ) * dp ≤ |(-2 : ℝ) * dp| := by
    simpa only [neg_mul, abs_neg] using (le_abs_self ((2 : ℝ) * dp))
  have hbound : D * ((2 : ℝ) * dp) ≤ D * |(-2 : ℝ) * dp| :=
    mul_le_mul_of_nonneg_left habs (le_of_lt hD)
  have hpositive : 0 < N * p * p := by positivity
  have halgebra :
      (N / 2) * (1 - (1 - 2 * p) ^ 2) =
        2 * N * p - 2 * N * p * p := by ring
  rw [halgebra]
  nlinarith

/-- The exact same conclusion at the designated radius r=1/2,
    where D = 3/4, in every integer dimension n >= 3. -/
theorem cap_failure_algebra (n : ℕ) (hn : 3 ≤ n)
    (p dp : ℝ) (hp0 : 0 < p) (hp1 : p < 1)
    (hderiv : (n : ℝ) * p < (3 / 4 : ℝ) * dp) :
    ((n : ℝ) / 2) * (1 - (1 - 2 * p) ^ 2) <
      (3 / 4 : ℝ) * |(-2 : ℝ) * dp| := by
  apply strict_violation_from_derivative (n : ℝ) (3 / 4 : ℝ) p dp
  · have : 0 < n := by omega
    exact_mod_cast this
  · norm_num
  · exact hp0
  · exact hp1
  · exact hderiv

end Newton400.PoissonCap
