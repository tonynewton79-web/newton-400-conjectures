import Mathlib
import NewtonConjectures.GravitySpectralSpan

/-!
# Stage 17 candidate: use two Fourier modes instead of sorting all eigenvalues.

This module isolates the two-index ordering step, the characters' independence
certificate and the weaker adjacency interface sufficient for the infinite
family theorem. The remaining link is the spectral multiplicity of these
modes in the ordered real adjacency eigenvalues.
-/
namespace Newton400.Case001

theorem penultimate_le_of_two_indices {N : ℕ} (hN : 2 ≤ N)
    (f : Fin N → ℝ) (hf : Antitone f) (b : ℝ)
    (i j : Fin N) (hij : i ≠ j) (hi : f i ≤ b) (hj : f j ≤ b) :
    f ⟨N - 2, by omega⟩ ≤ b := by
  let t : Fin N := ⟨N - 2, by omega⟩
  change f t ≤ b
  by_cases hit : i ≤ t
  · exact (hf hit).trans hi
  · by_cases hjt : j ≤ t
    · exact (hf hjt).trans hj
    · exfalso
      apply hij
      apply Fin.ext
      have h1 : t.val < i.val := lt_of_not_ge hit
      have h2 : t.val < j.val := lt_of_not_ge hjt
      have h3 := i.isLt
      have h4 := j.isLt
      have ht : t.val = N - 2 := rfl
      omega

noncomputable def cycleFourierMode (n : ℕ) [NeZero n]
    (k : ZMod n) : ZMod n → ℂ :=
  fun u => ZMod.stdAddChar (k * u)

theorem cycle_fourier_mode_shift_add (n : ℕ) [NeZero n]
    (k u : ZMod n) :
    cycleFourierMode n k (u + 1) =
      cycleFourierMode n k u * ZMod.stdAddChar k := by
  simp [cycleFourierMode, mul_add, AddChar.map_add_eq_mul]

theorem cycle_fourier_mode_shift_sub (n : ℕ) [NeZero n]
    (k u : ZMod n) :
    cycleFourierMode n k (u - 1) =
      cycleFourierMode n k u * ZMod.stdAddChar (-k) := by
  rw [sub_eq_add_neg]
  simp [cycleFourierMode, mul_add, AddChar.map_add_eq_mul]

theorem cycle_fourier_mode_neighbor_sum (n : ℕ) [NeZero n]
    (k u : ZMod n) :
    cycleFourierMode n k (u + 1) + cycleFourierMode n k (u - 1) =
      (ZMod.stdAddChar k + ZMod.stdAddChar (-k)) *
        cycleFourierMode n k u := by
  rw [cycle_fourier_mode_shift_add, cycle_fourier_mode_shift_sub]
  ring

/-- The two opposite characters are independent whenever k differs from -k.
This gives two independent complex eigenvectors once the matrix neighbor
action is identified. -/
theorem opposite_fourier_modes_coeff_zero (n : ℕ) [NeZero n]
    (k : ZMod n) (hk : k ≠ -k) (a b : ℂ)
    (h : ∀ u : ZMod n, a * cycleFourierMode n k u +
      b * cycleFourierMode n (-k) u = 0) : a = 0 ∧ b = 0 := by
  have h0 : a + b = 0 := by
    simpa [cycleFourierMode] using h 0
  have h1 : a * ZMod.stdAddChar k + b * ZMod.stdAddChar (-k) = 0 := by
    simpa [cycleFourierMode] using h 1
  have hn : ZMod.stdAddChar k - ZMod.stdAddChar (-k) ≠ 0 :=
    sub_ne_zero.mpr (fun he => hk (ZMod.injective_stdAddChar he))
  have hh : a * (ZMod.stdAddChar k - ZMod.stdAddChar (-k)) = 0 := by
    calc
      _ = (a * ZMod.stdAddChar k + b * ZMod.stdAddChar (-k)) -
          (a + b) * ZMod.stdAddChar (-k) := by ring
      _ = 0 := by rw [h0, h1]; ring
  have ha : a = 0 := (mul_eq_zero.mp hh).resolve_right hn
  exact ⟨ha, by simpa [ha] using h0⟩

/-- The infinite theorem needs only one-sided adjacency control, not an
equality with the complete ordered cycle spectrum. -/
theorem graffiti_strict_of_adjacency_lower (n : ℕ) [NeZero n]
    (hn : 15 ≤ n)
    (ha : adjacencyCosineCandidate n ≤ -actualSecondSmallestAdjacency n (by omega)) :
    actualCycleGravitySpan n < -actualSecondSmallestAdjacency n (by omega) :=
  lt_of_lt_of_le
    (lt_of_le_of_lt (actual_gravity_span_le_parity_cap n (by omega))
      (cycle_all_sizes_analytic_strict n hn)) ha

end Newton400.Case001
