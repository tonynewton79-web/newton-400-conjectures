import NewtonConjectures.Case007Sombor
import NewtonConjectures.Case007EdgeBridge
import Mathlib

/-!
# Case 007: actual vertex degrees and degree-defined Sombor indices

Every theorem is stated about the concrete `sunGraph d k : SimpleGraph _`.
The hub has degree d, each short leaf degree one, each intermediate vertex
degree two, and each terminal leaf degree one.

The edge-bijection from Case007EdgeBridge transports the graph sums back
to the three canonical edge classes. All claims require actual Lean kernel
compilation and remain unverified until GitHub Actions succeeds.
-/

namespace Newton400.Case007

open Finset

theorem sunHub_adj_iff {d k : ℕ} (w : SunVertex d k) :
    (sunGraph d k).Adj (sunHub d k) w ↔
      ∃ q : Fin (d-k) ⊕ Fin k, w = Sum.inr (Sum.inl q) := by
  constructor
  · rintro ⟨e, h | h⟩
    · cases e with
      | inl e =>
        cases e with
        | inl i =>
          exact ⟨Sum.inl i, h.2⟩
        | inr j =>
          exact ⟨Sum.inr j, h.2⟩
      | inr j =>
        simp [sunHub, sunSource, sunLong] at h
    · cases e with
      | inl e =>
        cases e with
        | inl i => simp [sunHub, sunTarget, sunShort] at h
        | inr j => simp [sunHub, sunTarget, sunLong] at h
      | inr j => simp [sunHub, sunTarget, sunTip] at h
  · rintro ⟨q, rfl⟩
    cases q with
    | inl i =>
      exact sunAdj_short i
    | inr j =>
      exact sunAdj_long j

theorem sunShort_adj_iff {d k : ℕ}
    (i : Fin (d-k)) (w : SunVertex d k) :
    (sunGraph d k).Adj (sunShort i) w ↔ w = sunHub d k := by
  constructor
  · rintro ⟨e, h | h⟩
    · cases e with
      | inl e =>
        cases e with
        | inl j => simp [sunShort, sunSource, sunHub] at h
        | inr j => simp [sunShort, sunSource, sunHub] at h
      | inr j => simp [sunShort, sunSource, sunLong] at h
    · cases e with
      | inl e =>
        cases e with
        | inl j =>
          have hij : i = j := by
            simpa [sunShort, sunTarget] using h.1
          subst j
          exact h.2
        | inr j => simp [sunShort, sunTarget, sunLong] at h
      | inr j => simp [sunShort, sunTarget, sunTip] at h
  · rintro rfl
    exact (sunGraph d k).symm (sunAdj_short i)

theorem sunLong_adj_iff {d k : ℕ}
    (j : Fin k) (w : SunVertex d k) :
    (sunGraph d k).Adj (sunLong j) w ↔
      w = sunHub d k ∨ w = sunTip j := by
  constructor
  · rintro ⟨e, h | h⟩
    · cases e with
      | inl e =>
        cases e with
        | inl i => simp [sunLong, sunSource, sunHub] at h
        | inr i => simp [sunLong, sunSource, sunHub] at h
      | inr i =>
        have hji : j = i := by
          simpa [sunLong, sunSource] using h.1
        subst i
        exact Or.inr h.2
    · cases e with
      | inl e =>
        cases e with
        | inl i => simp [sunLong, sunTarget, sunShort] at h
        | inr i =>
          have hji : j = i := by
            simpa [sunLong, sunTarget] using h.1
          subst i
          exact Or.inl h.2
      | inr i => simp [sunLong, sunTarget, sunTip] at h
  · rintro (rfl | rfl)
    · exact (sunGraph d k).symm (sunAdj_long j)
    · exact sunAdj_tip j

theorem sunTip_adj_iff {d k : ℕ}
    (j : Fin k) (w : SunVertex d k) :
    (sunGraph d k).Adj (sunTip j) w ↔ w = sunLong j := by
  constructor
  · rintro ⟨e, h | h⟩
    · cases e with
      | inl e =>
        cases e with
        | inl i => simp [sunTip, sunSource, sunHub] at h
        | inr i => simp [sunTip, sunSource, sunHub] at h
      | inr i => simp [sunTip, sunSource, sunLong] at h
    · cases e with
      | inl e =>
        cases e with
        | inl i => simp [sunTip, sunTarget, sunShort] at h
        | inr i => simp [sunTip, sunTarget, sunLong] at h
      | inr i =>
        have hji : j = i := by
          simpa [sunTip, sunTarget] using h.1
        subst i
        exact h.2
  · rintro rfl
    exact (sunGraph d k).symm (sunAdj_tip j)

theorem sunGraph_degree_hub (d k : ℕ) (hk : k ≤ d) :
    (sunGraph d k).degree (sunHub d k) = d := by
  classical
  let f : (Fin (d-k) ⊕ Fin k) → SunVertex d k :=
    fun q => Sum.inr (Sum.inl q)
  have hf : Function.Injective f := by
    intro q r h
    exact Sum.inl.inj (Sum.inr.inj h)
  have hs : (sunGraph d k).neighborFinset (sunHub d k) =
      (Finset.univ : Finset (Fin (d-k) ⊕ Fin k)).image f := by
    ext w
    simp only [SimpleGraph.mem_neighborFinset, Finset.mem_image,
      Finset.mem_univ, true_and]
    constructor
    · intro hw
      rcases (sunHub_adj_iff w).mp hw with ⟨q, hq⟩
      exact ⟨q, hq.symm⟩
    · rintro ⟨q, hq⟩
      exact (sunHub_adj_iff w).mpr ⟨q, hq.symm⟩
  rw [SimpleGraph.degree, hs]
  rw [Finset.card_image_of_injective _ hf]
  simp [Fintype.card_sum, Nat.sub_add_cancel hk]

theorem sunGraph_degree_short {d k : ℕ} (i : Fin (d-k)) :
    (sunGraph d k).degree (sunShort i) = 1 := by
  classical
  have hs : (sunGraph d k).neighborFinset (sunShort i) =
      {sunHub d k} := by
    ext w
    simp only [SimpleGraph.mem_neighborFinset, Finset.mem_singleton]
    exact sunShort_adj_iff i w
  rw [SimpleGraph.degree, hs]
  simp

theorem sunGraph_degree_long {d k : ℕ} (j : Fin k) :
    (sunGraph d k).degree (sunLong j) = 2 := by
  classical
  have hs : (sunGraph d k).neighborFinset (sunLong j) =
      {sunHub d k, sunTip j} := by
    ext w
    simp only [SimpleGraph.mem_neighborFinset, Finset.mem_insert,
      Finset.mem_singleton]
    exact sunLong_adj_iff j w
  rw [SimpleGraph.degree, hs]
  have hne : sunHub d k ≠ sunTip j := by
    simp [sunHub, sunTip]
  simp [hne]

theorem sunGraph_degree_tip {d k : ℕ} (j : Fin k) :
    (sunGraph d k).degree (sunTip j) = 1 := by
  classical
  have hs : (sunGraph d k).neighborFinset (sunTip j) =
      {sunLong j} := by
    ext w
    simp only [SimpleGraph.mem_neighborFinset, Finset.mem_singleton]
    exact sunTip_adj_iff j w
  rw [SimpleGraph.degree, hs]
  simp

/-- Degree-defined Sombor edge weight, symmetric in its endpoints. -/
noncomputable def sunGraphWeight (d k : ℕ) :
    Sym2 (SunVertex d k) → ℝ :=
  Sym2.lift ⟨fun u v =>
      Real.sqrt (((sunGraph d k).degree u : ℝ)^2 +
                 ((sunGraph d k).degree v : ℝ)^2),
    by
      intro u v
      congr 1
      exact add_comm _ _⟩

theorem sunGraphWeight_on_label (d k : ℕ) (hk : k ≤ d)
    (e : SunEdgeLabel d k) :
    sunGraphWeight d k (sunUndirectedEdge e) = sunEdgeWeight d k e := by
  cases e with
  | inl e =>
    cases e with
    | inl i =>
      simp [sunGraphWeight, sunUndirectedEdge, sunSource, sunTarget,
        sunEdgeWeight, sunGraph_degree_hub d k hk, sunGraph_degree_short]
    | inr j =>
      norm_num [sunGraphWeight, sunUndirectedEdge, sunSource, sunTarget,
        sunEdgeWeight, sunGraph_degree_hub d k hk, sunGraph_degree_long]
  | inr j =>
    norm_num [sunGraphWeight, sunUndirectedEdge, sunSource, sunTarget,
      sunEdgeWeight, sunGraph_degree_long, sunGraph_degree_tip]

/-- Sombor sum over the real graph edgeSet, rather than assumed labels. -/
noncomputable def sunActualS (d k : ℕ) : ℝ :=
  ∑ e : (sunGraph d k).edgeSet, sunGraphWeight d k e.1

/-- Modified Sombor sum over the same real graph edgeSet. -/
noncomputable def sunActualR (d k : ℕ) : ℝ :=
  ∑ e : (sunGraph d k).edgeSet, (sunGraphWeight d k e.1)⁻¹

theorem sunEdgeEquiv_apply (d k : ℕ) (e : SunEdgeLabel d k) :
    ((sunEdgeEquiv d k e : (sunGraph d k).edgeSet).1) =
      sunUndirectedEdge e := rfl

/-- Actual Sombor index equals the three-class label sum. -/
theorem sunActualS_eq_sunLabelS (d k : ℕ) (hk : k ≤ d) :
    sunActualS d k = sunLabelS d k := by
  classical
  calc
    sunActualS d k =
        ∑ e : SunEdgeLabel d k,
          sunGraphWeight d k ((sunEdgeEquiv d k e).1) := by
            exact (Equiv.sum_comp (sunEdgeEquiv d k)
              (fun edge : (sunGraph d k).edgeSet => sunGraphWeight d k edge.1)).symm
    _ = sunLabelS d k := by
      simp_rw [sunEdgeEquiv_apply, sunGraphWeight_on_label d k hk]
      rfl

/-- Actual modified Sombor index equals the three-class reciprocal sum. -/
theorem sunActualR_eq_sunLabelR (d k : ℕ) (hk : k ≤ d) :
    sunActualR d k = sunLabelR d k := by
  classical
  calc
    sunActualR d k =
        ∑ e : SunEdgeLabel d k,
          (sunGraphWeight d k ((sunEdgeEquiv d k e).1))⁻¹ := by
            exact (Equiv.sum_comp (sunEdgeEquiv d k)
              (fun edge : (sunGraph d k).edgeSet =>
                (sunGraphWeight d k edge.1)⁻¹)).symm
    _ = sunLabelR d k := by
      simp_rw [sunEdgeEquiv_apply, sunGraphWeight_on_label d k hk]
      rfl

/-- Final degree-defined formula for the actual eclipsed-sun graph. -/
theorem sunActualS_three_types (d k : ℕ) (hk : k ≤ d) :
    sunActualS d k =
      ((d-k : ℕ) : ℝ) * Real.sqrt ((d : ℝ)^2 + 1) +
      (k : ℝ) * Real.sqrt ((d : ℝ)^2 + 4) +
      (k : ℝ) * Real.sqrt 5 := by
  rw [sunActualS_eq_sunLabelS d k hk, sunLabelS_three_types]

theorem sunActualR_three_types (d k : ℕ) (hk : k ≤ d) :
    sunActualR d k =
      ((d-k : ℕ) : ℝ) * (Real.sqrt ((d : ℝ)^2 + 1))⁻¹ +
      (k : ℝ) * (Real.sqrt ((d : ℝ)^2 + 4))⁻¹ +
      (k : ℝ) * (Real.sqrt 5)⁻¹ := by
  rw [sunActualR_eq_sunLabelR d k hk, sunLabelR_three_types]

/-- The actual graph's Sombor index is exactly the paper's formula (3). -/
theorem sunActualS_eq_paper (d k : ℕ) (hk : k ≤ d) :
    sunActualS d k =
      sunS (Real.sqrt 5) (Real.sqrt ((d : ℝ)^2 + 4))
        (Real.sqrt ((d : ℝ)^2 + 1)) d k := by
  rw [sunActualS_three_types d k hk, sunS_expansion]
  rw [Nat.cast_sub hk]
  ring

/-- The actual graph's modified Sombor index is exactly formula (4). -/
theorem sunActualR_eq_paper (d k : ℕ) (hk : k ≤ d) :
    sunActualR d k =
      sunR (Real.sqrt 5) (Real.sqrt ((d : ℝ)^2 + 4))
        (Real.sqrt ((d : ℝ)^2 + 1)) d k := by
  rw [sunActualR_three_types d k hk, sunR_expansion]
  rw [Nat.cast_sub hk]
  ring


end Newton400.Case007
