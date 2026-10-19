import Mathlib
import NewtonConjectures.ErdosStrausObstruction

/-!
# Infinite prime families with no bounded Type A/B López product

This module upgrades the local modular exclusion to an infinite-family
theorem, using mathlib's Dirichlet theorem. The modulus 24*(4K+4)!
is deliberately larger than necessary; its factorial simplifies the
divisor bookkeeping.

This theorem rules out a *uniform fixed* bound K. It does NOT rule out
a moving bound dr <= sqrt(p), and does not solve Erdős–Straus.
-/

namespace Newton400.ErdosStraus

theorem exists_prime_no_bounded_AB (K N : ℕ) :
    ∃ p : ℕ, N < p ∧ p.Prime ∧ p % 24 = 1 ∧
      ∀ d r : ℕ, 0 < d → 0 < r → d * r ≤ K →
        (p + r) % (4 * d * r - 1) ≠ 0 ∧
        (p + 4 * d) % (4 * d * r - 1) ≠ 0 := by
  let Q : ℕ := 24 * Nat.factorial (4 * K + 4)
  have hfact : 0 < Nat.factorial (4 * K + 4) := Nat.factorial_pos _
  have hQpos : 0 < Q := by dsimp [Q]; positivity
  have hQ1 : 1 < Q := by dsimp [Q]; omega
  have hQne : Q ≠ 0 := by omega
  letI : NeZero Q := ⟨hQne⟩
  obtain ⟨p, hpgt, hprime, hcong⟩ :=
    Nat.forall_exists_prime_gt_and_modEq N (q := Q) (a := 1) isCoprime_one_left
  have hcongN : p ≡ 1 [MOD Q] :=
    Int.natCast_modEq_iff.mp hcong
  have h24div : 24 ∣ Q := by
    unfold Q
    exact dvd_mul_right 24 _
  have h24modeq : p ≡ 1 [MOD 24] := Nat.ModEq.of_dvd h24div hcongN
  have hp24 : p % 24 = 1 := by
    simpa [Nat.ModEq] using h24modeq
  refine ⟨p, hpgt, hprime, hp24, ?_⟩
  intro d r hd hr hbound
  have hshape := lopez_modulus_shape d r hd hr
  obtain ⟨hm3, _, _⟩ := hshape
  let m : ℕ := 4 * d * r - 1
  have hmpos : 0 < m := by dsimp [m]; omega
  have hmK : m ≤ 4 * K + 4 := by
    dsimp [m]
    have h : 4 * d * r ≤ 4 * K := by
      simpa only [mul_assoc] using Nat.mul_le_mul_left 4 hbound
    omega
  have hfactdiv : m ∣ Nat.factorial (4 * K + 4) :=
    Nat.dvd_factorial hmpos hmK
  have hmdiv : m ∣ Q := by
    rcases hfactdiv with ⟨t, ht⟩
    refine ⟨24 * t, ?_⟩
    dsimp [Q]
    rw [ht]
    ring
  have hmmodeq : p ≡ 1 [MOD m] := Nat.ModEq.of_dvd hmdiv hcongN
  have hmone : 1 < m := by dsimp [m]; omega
  have hpmod : p % m = 1 := by
    simpa [Nat.ModEq, Nat.mod_eq_of_lt hmone] using hmmodeq
  exact lopez_both_excluded_at_one p d r hd hr hpmod

end Newton400.ErdosStraus
