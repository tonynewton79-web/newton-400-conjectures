import Mathlib

/-!
# Elementary modular obstruction for fixed López products

These lemmas prove that a prime p which is one modulo each
4k-1, 1 ≤ k ≤ K, admits no Type A/B congruence with dr ≤ K.
Dirichlet's theorem then gives infinitely many such primes for every K.

We formalize the elementary modular step here. Dirichlet's theorem and
the construction of the global least common multiple are not asserted
as Lean-kernel-verified by this module.
-/

namespace Newton400.ErdosStraus

theorem add_remainder_of_one (p a m : ℕ)
    (hm : 1 < m) (hp : p % m = 1) :
    (p + a) % m = (1 + a) % m := by
  have h1 : 1 % m = 1 := Nat.mod_eq_of_lt hm
  simp [Nat.add_mod, hp, h1]

theorem no_typeB_from_unit_remainder (p m r : ℕ)
    (hm : 1 < m) (hp : p % m = 1) (hr : 1 + r < m) :
    (p + r) % m ≠ 0 := by
  rw [add_remainder_of_one p r m hm hp, Nat.mod_eq_of_lt hr]
  omega

theorem no_typeA_from_unit_remainder (p m d : ℕ)
    (hm : 3 ≤ m) (hp : p % m = 1)
    (hshape : 1 + 4 * d < m ∨ 1 + 4 * d = m + 2) :
    (p + 4 * d) % m ≠ 0 := by
  have hm1 : 1 < m := by omega
  rw [add_remainder_of_one p (4 * d) m hm1 hp]
  rcases hshape with hsmall | hlarge
  · rw [Nat.mod_eq_of_lt hsmall]
    omega
  · rw [hlarge]
    have h2 : 2 < m := by omega
    have h2mod : (m + 2) % m = 2 := by
      simp [Nat.add_mod, Nat.mod_eq_of_lt h2]
    rw [h2mod]
    omega

/-- Purely arithmetic shape inequalities for m = 4dr-1. -/
theorem lopez_modulus_shape (d r : ℕ) (hd : 0 < d) (hr : 0 < r) :
    let m := 4 * d * r - 1
    3 ≤ m ∧ 1 + r < m ∧
      (1 + 4 * d < m ∨ 1 + 4 * d = m + 2) := by
  dsimp
  have hd1 : 1 ≤ d := hd
  have hr1 : 1 ≤ r := hr
  have hlo : 4 * r ≤ 4 * d * r := by
    nlinarith [Nat.mul_le_mul_right r hd1]
  by_cases hcase : r = 1
  · subst r
    constructor
    · omega
    constructor
    · omega
    · right
      omega
  · have hr2 : 2 ≤ r := by omega
    have hmid : 8 * d ≤ 4 * d * r := by
      nlinarith [Nat.mul_le_mul_left (4 * d) hr2]
    constructor
    · omega
    constructor
    · omega
    · left
      omega

theorem lopez_both_excluded_at_one (p d r : ℕ)
    (hd : 0 < d) (hr : 0 < r)
    (hp : p % (4 * d * r - 1) = 1) :
    (p + r) % (4 * d * r - 1) ≠ 0 ∧
      (p + 4 * d) % (4 * d * r - 1) ≠ 0 := by
  obtain ⟨hm, hrlt, halt⟩ := lopez_modulus_shape d r hd hr
  constructor
  · exact no_typeB_from_unit_remainder p _ r (by omega) hp hrlt
  · exact no_typeA_from_unit_remainder p _ d hm hp halt

end Newton400.ErdosStraus
