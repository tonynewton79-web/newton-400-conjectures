import Mathlib

/-!
# Case 001: universal finite-difference telescoping

The weighted cyclic-interval Gram expansion of reciprocal distance is
a special case of an exact finite difference formula. This file proves
the finite sum identity for *every* sequence f : ℕ → ℚ and every d ≤ k.

It is a genuine all-index theorem. It is not the full cycle matrix identity:
the combinatorial count of cyclic-interval intersections is a separate goal.
-/

namespace Newton400.Case001

/-- Discrete Green/tent identity: the second difference of an arbitrary
rational-valued sequence telescopes with linearly increasing weights.
The upper boundary term is explicit. -/
theorem discrete_tent_telescope (f : ℕ → ℚ) (d k : ℕ) (hdk : d ≤ k) :
    (∑ j ∈ Finset.Ico (d + 1) (k + 1),
        ((j : ℚ) - (d : ℚ)) * (f (j - 1) - 2 * f j + f (j + 1))) =
      f d - f (k + 1) +
        (((k + 1 : ℕ) : ℚ) - (d : ℚ)) * (f (k + 1) - f k) := by
  induction k, hdk using Nat.le_induction with
  | base =>
      simp
      ring
  | succ k hk ih =>
      rw [Finset.sum_Ico_succ_top (by omega)]
      rw [ih]
      have hsub : k + 1 - 1 = k := by omega
      rw [hsub]
      push_cast
      ring

/-- The exact finite-difference representation when the terminal
coefficient is the first backward difference f(m-1)-f(m). -/
theorem discrete_tent_with_terminal (f : ℕ → ℚ) (d m : ℕ)
    (hd : d ≤ m) :
    f d =
      f m +
      (∑ j ∈ Finset.Ico (d + 1) m,
        ((j : ℚ) - (d : ℚ)) * (f (j - 1) - 2 * f j + f (j + 1))) +
      ((m : ℚ) - (d : ℚ)) * (f (m - 1) - f m) := by
  by_cases hdm : d = m
  · subst m
    simp
  · have hlt : d < m := by omega
    have hpred : m - 1 + 1 = m := by omega
    have hle : d ≤ m - 1 := by omega
    have h := discrete_tent_telescope f d (m - 1) hle
    rw [hpred] at h
    rw [h]
    ring

end Newton400.Case001
