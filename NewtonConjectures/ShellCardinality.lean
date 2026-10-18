import Mathlib
import NewtonConjectures.ScalarGravityUpper

/-!
# Stage 15a: exact cycle-distance fibres in canonical residues

For any n>=4 and 1<=d<=floor(n/2), the cycle vertices at
distance d from zero are exactly the two residues d and n-d.
For an even cycle's antipodal shell these residues coincide.
This lemma is an essential all-n bridge to harmonic row-sum
evaluation, not itself the completed count theorem.
-/
namespace Newton400.Case001

theorem cyclic_distance_zero_iff_residue
    (n d : ℕ) [NeZero n] (hn : 4 ≤ n)
    (hd : 1 ≤ d) (hdm : d ≤ n / 2)
    (v : ZMod n) :
    cyclicDistance n 0 v = d ↔
      v.val = d ∨ v.val = n - d := by
  have hv : v.val < n := ZMod.val_lt v
  have hdn : d < n := by omega
  unfold cyclicDistance
  simp only [sub_zero]
  omega

theorem cyclic_distance_zero_fibre_element
    (n d : ℕ) [NeZero n] (hn : 4 ≤ n)
    (hd : 1 ≤ d) (hdm : d ≤ n / 2)
    (v : ZMod n) (hv : cyclicDistance n 0 v = d) :
    v = (d : ZMod n) ∨ v = ((n - d : ℕ) : ZMod n) := by
  have hres := (cyclic_distance_zero_iff_residue n d hn hd hdm v).mp hv
  rcases hres with h | h
  · left
    calc
      v = ((v.val : ℕ) : ZMod n) := (ZMod.natCast_zmod_val v).symm
      _ = (d : ZMod n) := by rw [h]
  · right
    calc
      v = ((v.val : ℕ) : ZMod n) := (ZMod.natCast_zmod_val v).symm
      _ = ((n - d : ℕ) : ZMod n) := by rw [h]

theorem cycle_shell_neighbor_count_exact
    (n d : ℕ) [NeZero n] (hn : 4 ≤ n)
    (hd : 1 ≤ d) (hdm : d ≤ n / 2) :
    cycleShellNeighborCount n d 0 =
      (if 2 * d = n then 1 else 2) := by
  classical
  let a : ZMod n := d
  let b : ZMod n := (n - d : ℕ)
  have hda : d < n := by omega
  have hdb : n - d < n := by omega
  have ha : a.val = d := by
    dsimp [a]
    simp [ZMod.val_natCast, Nat.mod_eq_of_lt hda]
  have hb : b.val = n - d := by
    dsimp [b]
    simp [ZMod.val_natCast, Nat.mod_eq_of_lt hdb]
  have hnonzero (v : ZMod n)
      (hv : cyclicDistance n 0 v = d) : (0 : ZMod n) ≠ v := by
    intro hzero
    have hc : cyclicDistance n 0 0 = 0 := by simp [cyclicDistance]
    rw [← hzero] at hv
    omega
  have hf :
      (Finset.univ.filter
        (fun v : ZMod n => (cycleDistanceShell n d).Adj 0 v)) =
        ({a, b} : Finset (ZMod n)) := by
    ext v
    simp only [Finset.mem_filter, Finset.mem_univ, true_and,
      Finset.mem_insert, Finset.mem_singleton]
    change ((0 ≠ v) ∧ cyclicDistance n 0 v = d) ↔
      (v = a ∨ v = b)
    constructor
    · intro hv
      rcases (cyclic_distance_zero_fibre_element n d hn hd hdm v hv.2) with h | h
      · exact Or.inl h
      · exact Or.inr h
    · intro hv
      rcases hv with h | h
      · subst v
        have hc : cyclicDistance n 0 a = d :=
          (cyclic_distance_zero_iff_residue n d hn hd hdm a).mpr (Or.inl ha)
        exact ⟨hnonzero a hc, hc⟩
      · subst v
        have hc : cyclicDistance n 0 b = d :=
          (cyclic_distance_zero_iff_residue n d hn hd hdm b).mpr (Or.inr hb)
        exact ⟨hnonzero b hc, hc⟩
  unfold cycleShellNeighborCount
  rw [hf]
  by_cases h : 2 * d = n
  · have hab : a = b := by
      exact congrArg (fun t : ℕ => (t : ZMod n)) (by omega : d = n - d)
    simp [h, hab]
  · have hab : a ≠ b := by
      intro heq
      have heqval := congrArg ZMod.val heq
      rw [ha, hb] at heqval
      omega
    simp [h, hab]

end Newton400.Case001
