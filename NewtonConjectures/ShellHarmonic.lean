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
  exact_mod_cast cycle_harmonic_Icc_rational m

end Newton400.Case001
