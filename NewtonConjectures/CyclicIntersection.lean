import Mathlib

/-!
# Cyclic interval intersections — first canonical form

The finite cyclic interval of length j starting at 0 is the residue range
{0,...,j-1}. The interval starting at d uses modular displacement.
For d and j at most half the cycle, the overlap has exactly j-d elements.

All assertions are universally quantified in n, j, d. No axioms or admits.
-/

namespace Newton400.Case001

/-- Membership in the interval shifted by d, when a residue k is inside
the interval starting at zero, is equivalent to k ≥ d, provided both
interval length and d are at most half the cycle. -/
theorem canonical_cyclic_interval_membership
    (n j d k : ℕ) (hn : 0 < n)
    (hj : 2 * j ≤ n) (hd : 2 * d ≤ n)
    (hk : k < j) :
    (k + n - d) % n < j ↔ d ≤ k := by
  by_cases hdk : d ≤ k
  · have hsub : k + n - d = n + (k - d) := by omega
    have hlt : k - d < n := by omega
    have hmod : (k + n - d) % n = k - d := by
      rw [hsub]
      simp [Nat.add_mod, Nat.mod_eq_of_lt hlt]
    rw [hmod]
    constructor
    · intro _
      exact hdk
    · intro _
      omega
  · have hlt : k + n - d < n := by omega
    have hmod : (k + n - d) % n = k + n - d :=
      Nat.mod_eq_of_lt hlt
    rw [hmod]
    constructor
    · intro h
      omega
    · intro h
      omega

/-- The count of residues within both [0,j) and its cyclic translate
[d,d+j) in a cycle of n elements. -/
def canonicalCyclicOverlap (n j d : ℕ) : ℕ :=
  ((Finset.range j).filter (fun k => (k + n - d) % n < j)).card

/-- Canonical cyclic overlap formula, including the disjoint case d ≥ j
and the even-order antipodal case 2*d = n. -/
theorem canonical_cyclic_overlap_eq (n j d : ℕ)
    (hn : 0 < n) (hj : 2 * j ≤ n) (hd : 2 * d ≤ n) :
    canonicalCyclicOverlap n j d = j - d := by
  unfold canonicalCyclicOverlap
  have hset :
      (Finset.range j).filter (fun k => (k + n - d) % n < j) =
        Finset.Ico d j := by
    ext k
    simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_Ico]
    constructor
    · rintro ⟨hk, h⟩
      exact ⟨(canonical_cyclic_interval_membership n j d k hn hj hd hk).mp h, hk⟩
    · rintro ⟨hdk, hk⟩
      exact ⟨hk, (canonical_cyclic_interval_membership n j d k hn hj hd hk).mpr hdk⟩
  rw [hset]
  simp

end Newton400.Case001
