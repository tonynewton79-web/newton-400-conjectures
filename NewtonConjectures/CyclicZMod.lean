import Mathlib
import NewtonConjectures.CyclicIntersection

namespace Newton400.Case001

theorem zmod_val_sub_natCast (n d : ℕ) [NeZero n]
    (t : ZMod n) (hd : d < n) :
    (t - (d : ZMod n)).val = (t.val + n - d) % n := by
  have hdval : (d : ZMod n).val = d := ZMod.val_natCast_of_lt hd
  by_cases h : d ≤ t.val
  · have hsub : (t - (d : ZMod n)).val = t.val - d := by
      apply ZMod.val_sub
      simpa [hdval] using h
    rw [hsub]
    have ht : t.val + n - d = n + (t.val - d) := by omega
    rw [ht]
    simp [Nat.mod_eq_of_lt (ZMod.val_lt t)]
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
        rwa [ZMod.val_natCast_of_lt hkn]
      · exact ZMod.val_natCast_of_lt hkn
  rw [hcount]
  exact canonical_cyclic_overlap_eq n j d (NeZero.pos n) hj hd

def cyclicArcOverlap (n j : ℕ) (u v : ZMod n) : ℕ :=
  (Finset.univ.filter (fun t : ZMod n =>
    (t-u).val < j ∧ (t-v).val < j)).card

theorem cyclic_arc_overlap_oriented (n j : ℕ) [NeZero n]
    (u v : ZMod n) (hj : 2*j ≤ n)
    (hd : 2*(v-u).val ≤ n) :
    cyclicArcOverlap n j u v = j-(v-u).val := by
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
      exact sub_right_cancel h
    · intro t ht
      refine ⟨t+u, ?_, ?_⟩
      · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at ht ⊢
        have hsub1 : (t+u)-u=t := by abel
        have hsub2 : (t+u)-v=t-(v-u) := by abel
        simpa [hsub1,hsub2] using ht
      · abel
  rw [hr]
  exact canonical_zmod_overlap n j (v-u).val hj hd

end Newton400.Case001
