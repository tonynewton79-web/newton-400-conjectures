import Mathlib
import NewtonConjectures.CyclicIntersection

namespace Newton400.Case001

noncomputable instance (n : ℕ) [NeZero n] : Fintype (ZMod n) :=
  Fintype.ofEquiv (Fin n) (ZMod.finEquiv n)

theorem zmod_val_sub_natCast (n d : ℕ) [NeZero n]
    (t : ZMod n) (hd : d < n) :
    (t - (d : ZMod n)).val = (t.val + n - d) % n := by
  have hdval : (d : ZMod n).val = d := ZMod.val_natCast_of_lt hd
  by_cases h : d ≤ t.val
  · have hsub : (t - (d : ZMod n)).val = t.val - d := by
      simpa [hdval] using
        (ZMod.val_sub (a := t) (b := (d : ZMod n))
          (by simpa [hdval] using h))
    rw [hsub]
    have ht : t.val + n - d = n + (t.val - d) := by omega
    rw [ht]
    have hbound : t.val < n := ZMod.val_lt t
    calc
      t.val - d = (t.val - d) % n :=
        (Nat.mod_eq_of_lt (by omega : t.val - d < n)).symm
      _ = (n + (t.val - d)) % n := by simp [Nat.add_mod]
  · have hdpos : 0 < d := by omega
    have hneg : (-(d : ZMod n)).val = n - d := by
      rw [ZMod.neg_val', hdval]
      exact Nat.mod_eq_of_lt (by omega)
    rw [sub_eq_add_neg, ZMod.val_add, hneg]
    congr 1
    omega

theorem canonical_zmod_overlap (n j d : ℕ) [NeZero n]
    (hj : 2*j ≤ n) (hd : 2*d ≤ n) :
    (Finset.univ.filter (fun t : ZMod n =>
      t.val < j ∧ (t - (d : ZMod n)).val < j)).card = j - d := by
  letI : Fintype (ZMod n) := Fintype.ofEquiv (Fin n) (ZMod.finEquiv n)
  have hn : 0 < n := NeZero.pos n
  have hdlt : d < n := by omega
  have hcount :
      (Finset.univ.filter (fun t : ZMod n =>
        t.val < j ∧ (t - (d : ZMod n)).val < j)).card =
      canonicalCyclicOverlap n j d := by
    unfold canonicalCyclicOverlap
    apply Finset.card_bij (fun t _ => t.val)
    · intro t ht
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ht
      simp only [Finset.mem_filter, Finset.mem_range]
      exact ⟨ht.1, by simpa [zmod_val_sub_natCast n d t hdlt] using ht.2⟩
    · intro t _ s _ h
      exact ZMod.val_injective n h
    · intro k hk
      simp only [Finset.mem_filter, Finset.mem_range] at hk
      have hkn : k < n := by omega
      refine ⟨(k : ZMod n), ?_, ?_⟩
      · simp only [Finset.mem_filter, Finset.mem_univ, true_and]
        rw [ZMod.val_natCast_of_lt hkn]
        refine ⟨hk.1, ?_⟩
        rw [zmod_val_sub_natCast n d (k : ZMod n) hdlt]
        simpa [ZMod.val_natCast_of_lt hkn] using hk.2
      · exact ZMod.val_natCast_of_lt hkn
  rw [hcount]
  exact canonical_cyclic_overlap_eq n j d (NeZero.pos n) hj hd

noncomputable def cyclicArcOverlap (n j : ℕ) [NeZero n] (u v : ZMod n) : ℕ :=
  (Finset.univ.filter (fun t : ZMod n =>
    (t-u).val < j ∧ (t-v).val < j)).card

theorem cyclic_arc_overlap_oriented (n j : ℕ) [NeZero n]
    (u v : ZMod n) (hj : 2*j ≤ n)
    (hd : 2*(v-u).val ≤ n) :
    cyclicArcOverlap n j u v = j-(v-u).val := by
  letI : Fintype (ZMod n) := Fintype.ofEquiv (Fin n) (ZMod.finEquiv n)
  unfold cyclicArcOverlap
  have hr :
      (Finset.univ.filter (fun t : ZMod n =>
        (t-u).val < j ∧ (t-v).val < j)).card =
      (Finset.univ.filter (fun t : ZMod n =>
        t.val < j ∧ (t-(v-u)).val < j)).card := by
    apply Finset.card_bij (fun t _ => t-u)
    · intro t ht
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ht ⊢
      have hsub : (t-u)-(v-u) = t-v := by abel
      simpa [hsub] using ht
    · intro t _ s _ h
      calc
        t = (t-u)+u := by abel
        _ = (s-u)+u := congrArg (fun z => z+u) h
        _ = s := by abel
    · intro t ht
      refine ⟨t+u, ?_, ?_⟩
      · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ht ⊢
        have hsub1 : (t+u)-u=t := by abel
        have hsub2 : (t+u)-v=t-(v-u) := by abel
        simpa [hsub1,hsub2] using ht
      · abel
  rw [hr]
  simpa only [ZMod.natCast_zmod_val] using
    (canonical_zmod_overlap n j (v-u).val hj hd)


theorem cyclicArcOverlap_symm (n j : ℕ) [NeZero n] (u v : ZMod n) :
    cyclicArcOverlap n j u v = cyclicArcOverlap n j v u := by
  unfold cyclicArcOverlap
  congr 1
  ext t
  simp [and_comm]

/-- The undirected cycle distance, using the two oriented residues. -/
def cyclicDistance (n : ℕ) [NeZero n] (u v : ZMod n) : ℕ :=
  min (v-u).val (n-(v-u).val)

/-- Every pair of vertices, not only those in the preferred orientation:
the intersection size is max(j - cyclic distance, 0). -/
theorem cyclic_arc_overlap_distance (n j : ℕ) [NeZero n]
    (u v : ZMod n) (hj : 2*j ≤ n) :
    cyclicArcOverlap n j u v = j - cyclicDistance n u v := by
  unfold cyclicDistance
  by_cases hd : 2 * (v-u).val ≤ n
  · have hmin : min (v-u).val (n-(v-u).val) = (v-u).val :=
      Nat.min_eq_left (by omega)
    rw [hmin]
    exact cyclic_arc_overlap_oriented n j u v hj hd
  · have hne : v-u ≠ 0 := by
      intro hv
      have hzero : (v-u).val = 0 := by simp [hv]
      omega
    have hrev : (u-v).val = n-(v-u).val := by
      have h : u-v = -(v-u) := by abel
      rw [h, ZMod.neg_val]
      simp [hne]
    have hbound : (v-u).val < n := ZMod.val_lt (v-u)
    have hdrev : 2 * (u-v).val ≤ n := by
      rw [hrev]
      omega
    have hmin : min (v-u).val (n-(v-u).val) = n-(v-u).val :=
      Nat.min_eq_right (by omega)
    calc
      cyclicArcOverlap n j u v = cyclicArcOverlap n j v u :=
        cyclicArcOverlap_symm n j u v
      _ = j - (u-v).val := cyclic_arc_overlap_oriented n j v u hj hdrev
      _ = j - min (v-u).val (n-(v-u).val) := by rw [hmin, hrev]

end Newton400.Case001
