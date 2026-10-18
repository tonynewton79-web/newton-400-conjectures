import Mathlib
import NewtonConjectures.ShellCardinality
import NewtonConjectures.HarmonicComparison

/-!
# Stage 15b — exact finite harmonic-sum normalization
Bridge the shell's 1..m range to the existing certified H_m definition,
which uses the length-m list of reciprocals at indices k+1.
-/
namespace Newton400.Case001

theorem cycle_harmonic_Icc_rational (m : ℕ) :
    (∑ d ∈ Finset.Icc 1 m, (1 : ℚ) / (d : ℚ)) =
      cycleHarmonic m := by
  induction m with
  | zero =>
      simp [cycleHarmonic]
  | succ m ih =>
      have hsum :
          (∑ d ∈ Finset.Icc 1 (m + 1), (1 : ℚ) / (d : ℚ)) =
            (∑ d ∈ Finset.Icc 1 m, (1 : ℚ) / (d : ℚ)) +
              (1 : ℚ) / ((m + 1 : ℕ) : ℚ) := by
        rw [Finset.sum_Icc_succ_top (by omega)]
      rw [hsum, ih, cycleHarmonic_succ]

theorem cycle_harmonic_Icc_real (m : ℕ) :
    (∑ d ∈ Finset.Icc 1 m, (1 : ℝ) / (d : ℝ)) =
      (cycleHarmonic m : ℝ) := by
  have h := congrArg (fun q : ℚ => (q : ℝ))
    (cycle_harmonic_Icc_rational m)
  simpa only [Rat.cast_sum, Rat.cast_div, Rat.cast_one, Rat.cast_natCast] using h

/-- The exact ALL-ODD-CYCLES harmonic shell scalar, now with no
cardinality assumptions: shell counts are fully kernel-certified. -/
theorem odd_cycle_shell_scalar_harmonic
    (m : ℕ) [NeZero (2 * m + 1)] (hm : 2 ≤ m) :
    cycleWeightedShellCount (2 * m + 1) 0 =
      2 * (cycleHarmonic m : ℝ) := by
  rw [odd_cycle_weighted_shell_sum m hm]
  calc
    (∑ d ∈ Finset.Icc 1 m, (2 : ℝ) / (d : ℝ)) =
        2 * (∑ d ∈ Finset.Icc 1 m, (1 : ℝ) / (d : ℝ)) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro d hd
      ring
    _ = 2 * (cycleHarmonic m : ℝ) := by
      rw [cycle_harmonic_Icc_real m]

/-- The exact ALL-EVEN-CYCLES harmonic shell scalar, including the
unique antipodal contribution 1/m rather than 2/m. -/
theorem even_cycle_shell_scalar_harmonic
    (m : ℕ) [NeZero (2 * m)] (hm : 2 ≤ m) :
    cycleWeightedShellCount (2 * m) 0 =
      2 * (cycleHarmonic (m - 1) : ℝ) + 1 / (m : ℝ) := by
  rw [even_cycle_weighted_shell_sum m hm]
  have hp : (m - 1) + 1 = m := by omega
  have hsplit :
      (∑ d ∈ Finset.Icc 1 m,
        if d = m then (1 : ℝ) / (d : ℝ) else 2 / (d : ℝ)) =
        (∑ d ∈ Finset.Icc 1 (m - 1), (2 : ℝ) / (d : ℝ)) +
          (1 : ℝ) / (m : ℝ) := by
    conv_lhs => rw [← hp]
    rw [Finset.sum_Icc_succ_top (by omega)]
    simp only [hp, if_pos rfl]
    congr 1
    apply Finset.sum_congr rfl
    intro d hd
    have hne : d ≠ m := by
      have hi : d ≤ m - 1 := (Finset.mem_Icc.mp hd).2
      omega
    simp [hne]
  rw [hsplit]
  congr 1
  calc
    (∑ d ∈ Finset.Icc 1 (m - 1), (2 : ℝ) / (d : ℝ)) =
        2 * (∑ d ∈ Finset.Icc 1 (m - 1), (1 : ℝ) / (d : ℝ)) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro d hd
      ring
    _ = 2 * (cycleHarmonic (m - 1) : ℝ) := by
      rw [cycle_harmonic_Icc_real (m - 1)]

end Newton400.Case001
