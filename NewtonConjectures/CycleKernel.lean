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


/-- The exact positive-weight tent representation of the reciprocal kernel
for arbitrary integer distances 1 ≤ d < m. This specializes the universal
finite-difference identity to f(j)=1/j and simplifies all coefficients. -/
theorem reciprocal_tent_identity (d m : ℕ) (hd : 1 ≤ d) (hm : d < m) :
    (1 : ℚ) / (d : ℚ) =
      (1 : ℚ) / (m : ℚ) +
      (∑ j ∈ Finset.Ico (d + 1) m,
        ((j : ℚ) - (d : ℚ)) *
          (2 / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1)))) +
      ((m : ℚ) - (d : ℚ)) * (1 / (((m : ℚ) - 1) * (m : ℚ))) := by
  have hbase := discrete_tent_with_terminal
    (fun j : ℕ => (1 : ℚ) / (j : ℚ)) d m (by omega)
  have hsum :
      (∑ j ∈ Finset.Ico (d + 1) m,
        ((j : ℚ) - (d : ℚ)) *
          ((1 : ℚ) / ((j - 1 : ℕ) : ℚ) -
            2 * ((1 : ℚ) / (j : ℚ)) +
            (1 : ℚ) / ((j + 1 : ℕ) : ℚ))) =
      (∑ j ∈ Finset.Ico (d + 1) m,
        ((j : ℚ) - (d : ℚ)) *
          (2 / (((j : ℚ) - 1) * (j : ℚ) * ((j : ℚ) + 1)))) := by
    apply Finset.sum_congr rfl
    intro j hj
    have hjlo : d + 1 ≤ j := (Finset.mem_Ico.mp hj).1
    have hj2 : 2 ≤ j := by omega
    have hsub : ((j - 1 : ℕ) : ℚ) = (j : ℚ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ j)]
      norm_num
    have hplus : ((j + 1 : ℕ) : ℚ) = (j : ℚ) + 1 := by push_cast; ring
    rw [hsub, hplus]
    have hjpos : (1 : ℚ) < (j : ℚ) := by
      exact_mod_cast (show 1 < j by omega)
    have h₁ : (j : ℚ) - 1 ≠ 0 := by linarith
    have h₂ : (j : ℚ) ≠ 0 := by linarith
    have h₃ : (j : ℚ) + 1 ≠ 0 := by linarith
    field_simp
    ring
  have hm2 : 2 ≤ m := by omega
  have hmpos : (1 : ℚ) < (m : ℚ) := by
    exact_mod_cast (show 1 < m by omega)
  have hsub : ((m - 1 : ℕ) : ℚ) = (m : ℚ) - 1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ m)]
    norm_num
  have hend :
      (1 : ℚ) / ((m - 1 : ℕ) : ℚ) - (1 : ℚ) / (m : ℚ) =
        (1 : ℚ) / (((m : ℚ) - 1) * (m : ℚ)) := by
    rw [hsub]
    have h₁ : (m : ℚ) - 1 ≠ 0 := by linarith
    have h₂ : (m : ℚ) ≠ 0 := by linarith
    field_simp
    ring
  rw [hsum, hend] at hbase
  exact hbase

end Newton400.Case001
