import Mathlib
import NewtonConjectures.ScalarGravityUpper
import NewtonConjectures.ShellHarmonic

/-!
# Case 001 Stage 16 candidate: actual real gravity spectral span

Translate and reflect real spectral values using the algebraic definition
of spectrum. The bounds are for the original graph matrix, not a
surrogate eigenvalue list. This file is submitted for kernel validation.
-/
namespace Newton400.Case001

section General
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem spectral_value_lower_of_shift_psd
    (A : Matrix ι ι ℝ) (a x : ℝ)
    (ha : (A + a • (1 : Matrix ι ι ℝ)).PosSemidef)
    (hx : x ∈ spectrum ℝ A) : -a ≤ x := by
  have hshift : x + a ∈ spectrum ℝ (A + a • (1 : Matrix ι ι ℝ)) := by
    rw [spectrum.mem_iff] at hx ⊢
    simp only [Algebra.algebraMap_eq_smul_one, add_smul] at hx ⊢
    have heq : (x • (1 : Matrix ι ι ℝ) + a • 1) -
        (A + a • 1) = x • 1 - A := by abel
    rw [heq]
    exact hx
  have hnon := (Matrix.posSemidef_iff_isHermitian_and_spectrum_nonneg.mp ha).2 hshift
  change 0 ≤ x + a at hnon
  linarith

theorem spectral_value_upper_of_reflected_psd
    (A : Matrix ι ι ℝ) (b x : ℝ)
    (hb : (b • (1 : Matrix ι ι ℝ) - A).PosSemidef)
    (hx : x ∈ spectrum ℝ A) : x ≤ b := by
  have hreflect : b - x ∈ spectrum ℝ (b • (1 : Matrix ι ι ℝ) - A) := by
    rw [spectrum.mem_iff] at hx ⊢
    simp only [Algebra.algebraMap_eq_smul_one, sub_smul] at hx ⊢
    have heq : (b • (1 : Matrix ι ι ℝ) - x • 1) -
        (b • 1 - A) = -(x • 1 - A) := by abel
    rw [heq, IsUnit.neg_iff]
    exact hx
  have hnon := (Matrix.posSemidef_iff_isHermitian_and_spectrum_nonneg.mp hb).2 hreflect
  change 0 ≤ b - x at hnon
  linarith

theorem spectral_span_of_two_sided_psd [Nonempty ι]
    (A : Matrix ι ι ℝ) (hA : A.IsHermitian) (a b : ℝ)
    (ha : (A + a • (1 : Matrix ι ι ℝ)).PosSemidef)
    (hb : (b • (1 : Matrix ι ι ℝ) - A).PosSemidef) :
    sSup (spectrum ℝ A) - sInf (spectrum ℝ A) ≤ b + a := by
  classical
  let i : ι := Classical.choice (inferInstance : Nonempty ι)
  have hnon : (spectrum ℝ A).Nonempty :=
    ⟨hA.eigenvalues i, hA.eigenvalues_mem_spectrum_real i⟩
  have hlo : -a ≤ sInf (spectrum ℝ A) :=
    le_csInf hnon (fun x hx => spectral_value_lower_of_shift_psd A a x ha hx)
  have hhi : sSup (spectrum ℝ A) ≤ b :=
    csSup_le hnon (fun x hx => spectral_value_upper_of_reflected_psd A b x hb hx)
  linarith
end General

theorem actual_cycle_gravity_isHermitian (n : ℕ) [NeZero n] :
    (actualCycleGravity n).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro u v
  simp [actualCycleGravity, actualCycleReciprocal, star_trivial,
    cyclicDistance_symm, eq_comm]

theorem actual_gravity_span_bound (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    actualCycleGravitySpan n ≤
      (4 / ((n - 1 : ℕ) : ℝ)) * (cycleWeightedShellCount n 0 + 3 / 2) := by
  have hfactor : (0 : ℝ) ≤ 4 / ((n - 1 : ℕ) : ℝ) := by positivity
  have hlo := (actual_reciprocal_diagonal_shift_psd n hn).smul hfactor
  rw [smul_add, smul_smul, ← actual_gravity_is_scaled_reciprocal n] at hlo
  have hhi := actual_gravity_scalar_upper_psd n hn
  rw [smul_smul] at hhi
  have h := spectral_span_of_two_sided_psd
    (actualCycleGravity n) (actual_cycle_gravity_isHermitian n)
    ((4 / ((n - 1 : ℕ) : ℝ)) * (3 / 2))
    ((4 / ((n - 1 : ℕ) : ℝ)) * cycleWeightedShellCount n 0) hlo hhi
  unfold actualCycleGravitySpan
  rw [mul_add]
  exact h

theorem actual_gravity_span_le_parity_cap (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    actualCycleGravitySpan n ≤ gravityParityCap n := by
  by_cases hp : n % 2 = 0
  · have he : ∃ m : ℕ, n = 2 * m := ⟨n / 2, by omega⟩
    obtain ⟨m, rfl⟩ := he
    have hm : 2 ≤ m := by omega
    have hd : (2 * m) / 2 = m := by omega
    have hc : ((2 * m - 1 : ℕ) : ℝ) = 2 * (m : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega)]
      push_cast
      ring
    have hh := actual_gravity_span_bound (2 * m) hn
    rw [even_cycle_shell_scalar_harmonic m hm, hc] at hh
    rw [gravityParityCap, if_pos hp, hd]
    unfold evenCycleUpper evenCycleS
    push_cast
    convert hh using 1 <;> ring
  · have ho : ∃ m : ℕ, n = 2 * m + 1 := ⟨n / 2, by omega⟩
    obtain ⟨m, rfl⟩ := ho
    have hm : 2 ≤ m := by omega
    have hd : (2 * m + 1) / 2 = m := by omega
    have hc : ((2 * m + 1 - 1 : ℕ) : ℝ) = 2 * (m : ℝ) := by
      have he : 2 * m + 1 - 1 = 2 * m := by omega
      rw [he]
      push_cast
      ring
    have hh := actual_gravity_span_bound (2 * m + 1) hn
    rw [odd_cycle_shell_scalar_harmonic m hm, hc] at hh
    rw [gravityParityCap, if_neg hp, hd]
    unfold oddCycleUpper
    push_cast
    convert hh using 1 <;> ring

/-- After this bridge only the adjacency eigenvalue interface is needed
for the infinite-family part; the finite converse is independent. -/
theorem graffiti_strict_of_adjacency_interface (n : ℕ) [NeZero n]
    (hn : 15 ≤ n)
    (hadj : -actualSecondSmallestAdjacency n (by omega) = adjacencyCosineCandidate n) :
    actualCycleGravitySpan n < -actualSecondSmallestAdjacency n (by omega) := by
  exact full_graffiti_strict_of_spectral_interfaces n hn hadj
    (actual_gravity_span_le_parity_cap n (by omega))

end Newton400.Case001
