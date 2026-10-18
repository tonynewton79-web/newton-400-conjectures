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

/-- For every odd cycle all nonzero distance shells have two vertices.
This is an exact formula for the ACTUAL shell-count weighted scalar. -/
theorem odd_cycle_weighted_shell_sum
    (m : ℕ) [NeZero (2 * m + 1)] (hm : 2 ≤ m) :
    cycleWeightedShellCount (2 * m + 1) 0 =
      ∑ d ∈ Finset.Icc 1 m, (2 : ℝ) / (d : ℝ) := by
  classical
  have hhalf : (2 * m + 1) / 2 = m := by omega
  unfold cycleWeightedShellCount
  rw [hhalf]
  apply Finset.sum_congr rfl
  intro d hd
  have hdlo : 1 ≤ d := (Finset.mem_Icc.mp hd).1
  have hdhi : d ≤ m := (Finset.mem_Icc.mp hd).2
  have hcard := cycle_shell_neighbor_count_exact
    (2 * m + 1) d (by omega) hdlo (by simpa only [hhalf] using hdhi)
  have hnon : 2 * d ≠ 2 * m + 1 := by omega
  simp only [hhalf, if_neg hnon] at hcard
  rw [hcard]
  push_cast
  ring

/-- For even cycles, the unique antipodal shell is counted only once.
All interior nonzero shells still have two vertices. -/
theorem even_cycle_weighted_shell_sum
    (m : ℕ) [NeZero (2 * m)] (hm : 2 ≤ m) :
    cycleWeightedShellCount (2 * m) 0 =
      ∑ d ∈ Finset.Icc 1 m,
        if d = m then (1 : ℝ) / (d : ℝ) else 2 / (d : ℝ) := by
  classical
  have hhalf : (2 * m) / 2 = m := by omega
  unfold cycleWeightedShellCount
  rw [hhalf]
  apply Finset.sum_congr rfl
  intro d hd
  have hdlo : 1 ≤ d := (Finset.mem_Icc.mp hd).1
  have hdhi : d ≤ m := (Finset.mem_Icc.mp hd).2
  have hcard := cycle_shell_neighbor_count_exact
    (2 * m) d (by omega) hdlo (by simpa only [hhalf] using hdhi)
  by_cases h : d = m
  · subst d
    simp only [hhalf, if_pos rfl] at hcard
    rw [hcard]
    simp
  · have hnon : 2 * d ≠ 2 * m := by omega
    simp only [hhalf, if_neg hnon] at hcard
    rw [hcard]
    simp only [if_neg h]
    push_cast
    ring

end Newton400.Case001
