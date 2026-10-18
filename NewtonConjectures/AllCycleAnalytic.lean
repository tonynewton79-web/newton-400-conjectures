import Mathlib
import NewtonConjectures.TrigonometricEndgame

/-!
# One universal all-cycle analytical comparison

This theorem combines the odd/even kernels, with no trigonometric
assumptions. It is NOT by itself the original Graffiti statement:
identification of the adjacency second-smallest eigenvalue, the actual
gravity spread estimate, and the small-cycle converse must still
be formalized separately and then assembled.
-/
namespace Newton400.Case001

/-- Universal harmonic upper estimate, with the correct parity regime. -/
noncomputable def gravityParityCap (n : ℕ) : ℝ :=
  if n % 2 = 0 then (evenCycleUpper (n / 2) : ℝ)
  else (oddCycleUpper (n / 2) : ℝ)

/-- Closed-form cosine associated with the candidate second-smallest
cycle adjacency eigenvalue; the identification itself is pending. -/
noncomputable def adjacencyCosineCandidate (n : ℕ) : ℝ :=
  if n % 2 = 0 then
    2 * Real.cos (Real.pi / ((n / 2 : ℕ) : ℝ))
  else
    2 * Real.cos (Real.pi / ((2 * (n / 2) + 1 : ℕ) : ℝ))

/-- The complete parity-uniform analytical inequality. This is
unconditional and kernel-verifiable for ALL n>=15. -/
theorem cycle_all_sizes_analytic_strict (n : ℕ) (hn : 15 ≤ n) :
    gravityParityCap n < adjacencyCosineCandidate n := by
  by_cases hp : n % 2 = 0
  · have hm : 8 ≤ n / 2 := by omega
    simpa [gravityParityCap, adjacencyCosineCandidate, hp] using
      (evenCycleUpper_lt_actual_cosine (n / 2) hm)
  · have hm : 7 ≤ n / 2 := by omega
    simpa [gravityParityCap, adjacencyCosineCandidate, hp] using
      (oddCycleUpper_lt_actual_cosine (n / 2) hm)

end Newton400.Case001
