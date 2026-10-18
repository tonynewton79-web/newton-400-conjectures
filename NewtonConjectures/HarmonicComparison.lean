import Mathlib
import NewtonConjectures.RealSpectral

/-!
# Final comparison gate: exact rational harmonic bounds
All arguments are universally quantified. These monotonicity statements
are separate from cycle adjacency spectral ordering.
-/
namespace Newton400.Case001

def cycleHarmonic (m : ℕ) : ℚ :=
  ∑ k ∈ Finset.range m, (1 : ℚ) / ((k + 1 : ℕ) : ℚ)

theorem cycleHarmonic_succ (m : ℕ) :
    cycleHarmonic (m + 1) =
      cycleHarmonic m + (1 : ℚ) / ((m + 1 : ℕ) : ℚ) := by
  simp [cycleHarmonic, Finset.sum_range_succ]

theorem cycleHarmonic_ge_one (m : ℕ) (hm : 1 ≤ m) :
    (1 : ℚ) ≤ cycleHarmonic m := by
  induction m, hm using Nat.le_induction with
  | base =>
      norm_num [cycleHarmonic, Finset.sum_range_succ]
  | succ m hm ih =>
      rw [cycleHarmonic_succ]
      have hpos : (0 : ℚ) ≤ 1 / ((m + 1 : ℕ) : ℚ) := by positivity
      linarith

private theorem odd_upper_abstract (m : ℕ) (hm : 1 ≤ m)
    (T : ℚ) (hT : 7 ≤ T) :
    (T + 4 / (((m : ℚ) + 1))) / (((m : ℚ) + 1)) <
      T / (m : ℚ) := by
  have hm0 : (0 : ℚ) < (m : ℚ) := by
    exact_mod_cast (show 0 < m by omega)
  have hm1 : (0 : ℚ) < (m : ℚ) + 1 := by linarith
  have hbig : 4 * (m : ℚ) < T * ((m : ℚ) + 1) := by
    have haux : 0 ≤ (T-7) * ((m : ℚ)+1) :=
      mul_nonneg (by linarith) (by linarith)
    nlinarith
  have hfrac : 4 * (m : ℚ) / ((m : ℚ) + 1) < T :=
    (div_lt_iff₀ hm1).mpr hbig
  apply (div_lt_div_iff₀ hm1 hm0).mpr
  calc
    (T + 4 / ((m : ℚ) + 1)) * (m : ℚ) =
      T * (m : ℚ) + 4 * (m : ℚ) / ((m : ℚ) + 1) := by ring
    _ < T * ((m : ℚ) + 1) := by nlinarith

def oddCycleUpper (m : ℕ) : ℚ :=
  (4 * cycleHarmonic m + 3) / (m : ℚ)

theorem oddCycleUpper_step (m : ℕ) (hm : 7 ≤ m) :
    oddCycleUpper (m + 1) < oddCycleUpper m := by
  have hH : (1 : ℚ) ≤ cycleHarmonic m :=
    cycleHarmonic_ge_one m (by omega)
  have hT : (7 : ℚ) ≤ 4 * cycleHarmonic m + 3 := by linarith
  have h := odd_upper_abstract m (by omega)
    (4 * cycleHarmonic m + 3) hT
  convert h using 1 <;>
    simp [oddCycleUpper, cycleHarmonic_succ, Nat.cast_add, Nat.cast_one] <;>
    ring

theorem even_delta_lt_four (m : ℕ) (hm : 2 ≤ m) :
    (2 * (m : ℚ) - 1) *
      (1 / (m : ℚ) + 1 / ((m : ℚ) + 1)) < 4 := by
  have hm0 : (0 : ℚ) < (m : ℚ) := by
    exact_mod_cast (show 0 < m by omega)
  have hm1 : (0 : ℚ) < (m : ℚ) + 1 := by linarith
  have hden : (0 : ℚ) < (m : ℚ) * ((m : ℚ) + 1) :=
    mul_pos hm0 hm1
  have heq :
      (2 * (m : ℚ) - 1) *
        (1 / (m : ℚ) + 1 / ((m : ℚ) + 1)) =
      ((2 * (m : ℚ) - 1) * (2 * (m : ℚ) + 1)) /
        ((m : ℚ) * ((m : ℚ) + 1)) := by
    field_simp
    ring
  rw [heq]
  apply (div_lt_iff₀ hden).mpr
  nlinarith

def evenCycleS (m : ℕ) : ℚ :=
  2 * cycleHarmonic (m - 1) + 1 / (m : ℚ) + 3 / 2

def evenCycleUpper (m : ℕ) : ℚ :=
  4 * evenCycleS m / (2 * (m : ℚ) - 1)

theorem evenCycleS_succ (m : ℕ) (hm : 2 ≤ m) :
    evenCycleS (m + 1) =
      evenCycleS m + 1 / (m : ℚ) + 1 / ((m : ℚ) + 1) := by
  have hprev : (m - 1) + 1 = m := by omega
  have hnext : (m + 1) - 1 = m := by omega
  have hH : cycleHarmonic m =
      cycleHarmonic (m - 1) + 1 / (m : ℚ) := by
    simpa [hprev] using cycleHarmonic_succ (m - 1)
  unfold evenCycleS
  rw [hnext, hH]
  push_cast
  ring

private theorem even_upper_abstract (m : ℕ) (hm : 2 ≤ m)
    (S : ℚ) (hS : (7 : ℚ) / 2 ≤ S) :
    4 * (S + 1 / (m : ℚ) + 1 / ((m : ℚ) + 1)) /
        (2 * (m : ℚ) + 1) <
      4 * S / (2 * (m : ℚ) - 1) := by
  have hm0 : (0 : ℚ) < (m : ℚ) := by
    exact_mod_cast (show 0 < m by omega)
  have hdenlo : (0 : ℚ) < 2 * (m : ℚ) - 1 := by
    have : (2 : ℚ) ≤ (m : ℚ) := by exact_mod_cast hm
    linarith
  have hdenhi : (0 : ℚ) < 2 * (m : ℚ) + 1 := by linarith
  have hdelta := even_delta_lt_four m hm
  have hkey : (2 * (m : ℚ) - 1) *
    (1 / (m : ℚ) + 1 / ((m : ℚ) + 1)) < 2 * S := by
    linarith
  apply (div_lt_div_iff₀ hdenhi hdenlo).mpr
  nlinarith [hkey]

theorem evenCycleUpper_step (m : ℕ) (hm : 8 ≤ m) :
    evenCycleUpper (m + 1) < evenCycleUpper m := by
  have hH : (1 : ℚ) ≤ cycleHarmonic (m - 1) :=
    cycleHarmonic_ge_one (m - 1) (by omega)
  have hm0 : (0 : ℚ) < (m : ℚ) := by
    exact_mod_cast (show 0 < m by omega)
  have hS : (7 : ℚ) / 2 ≤ evenCycleS m := by
    unfold evenCycleS
    have hpos : (0 : ℚ) ≤ 1 / (m : ℚ) := by positivity
    linarith
  have h := even_upper_abstract m (by omega) (evenCycleS m) hS
  convert h using 1 <;>
    simp [evenCycleUpper, evenCycleS_succ m (by omega),
      Nat.cast_add, Nat.cast_one] <;> ring

/-- Global odd upper bound, certified from the first odd case m=7. -/
theorem oddCycleUpper_le_base (m : ℕ) (hm : 7 ≤ m) :
    oddCycleUpper m ≤ oddCycleUpper 7 := by
  induction m, hm using Nat.le_induction with
  | base => exact le_rfl
  | succ m hm ih =>
      exact (le_of_lt (oddCycleUpper_step m hm)).trans ih

/-- Global even upper bound, certified from the first even case m=8. -/
theorem evenCycleUpper_le_base (m : ℕ) (hm : 8 ≤ m) :
    evenCycleUpper m ≤ evenCycleUpper 8 := by
  induction m, hm using Nat.le_induction with
  | base => exact le_rfl
  | succ m hm ih =>
      exact (le_of_lt (evenCycleUpper_step m hm)).trans ih

theorem oddCycleUpper_base_exact :
    oddCycleUpper 7 = (468 : ℚ) / 245 := by
  norm_num [oddCycleUpper, cycleHarmonic, Finset.sum_range_succ]

theorem evenCycleUpper_base_exact :
    evenCycleUpper 8 = (1907 : ℚ) / 1050 := by
  norm_num [evenCycleUpper, evenCycleS, cycleHarmonic, Finset.sum_range_succ]

theorem oddCycleUpper_lt_boundary (m : ℕ) (hm : 7 ≤ m) :
    oddCycleUpper m < (2 : ℚ) - ((22 : ℚ) / 105)^2 := by
  have hle := oddCycleUpper_le_base m hm
  rw [oddCycleUpper_base_exact] at hle
  have hmargin := odd_boundary_positive
  linarith

theorem evenCycleUpper_lt_boundary (m : ℕ) (hm : 8 ≤ m) :
    evenCycleUpper m < (2 : ℚ) - ((11 : ℚ) / 28)^2 := by
  have hle := evenCycleUpper_le_base m hm
  rw [evenCycleUpper_base_exact] at hle
  have hmargin := even_boundary_positive
  linarith

end Newton400.Case001
