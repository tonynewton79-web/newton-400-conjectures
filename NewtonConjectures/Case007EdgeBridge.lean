import NewtonConjectures.Case007SunGraph
import Mathlib

/-!
# Case 007 — Edge-label correspondence for the eclipsed sun

Mathematical target: the three edge-label families are a *bijection* onto
actual undirected edges of the finite simple graph. This is stronger than
mere enumeration of formal edge labels.

The graph-degree identities and the final identification of Sombor indices
with the graph's degree-defined sums remain separate proof obligations.

This module must not be described as kernel-verified until the pinned
Lean/mathlib workflow passes on the exact commit.
-/

namespace Newton400.Case007

/-- Every edge label indexes a distinct non-hub endpoint. -/
theorem sunTarget_as_inr {d k : ℕ} (e : SunEdgeLabel d k) :
    sunTarget e = Sum.inr e := by
  cases e with
  | inl e =>
    cases e with
    | inl i => rfl
    | inr j => rfl
  | inr j => rfl

theorem sunTarget_injective (d k : ℕ) :
    Function.Injective (@sunTarget d k) := by
  intro e f h
  simpa only [sunTarget_as_inr, Sum.inr.injEq] using h

/-- Graph distance from the hub on the explicitly oriented edge families. -/
def sunDepth {d k : ℕ} : SunVertex d k → ℕ
  | Sum.inl _ => 0
  | Sum.inr (Sum.inl _) => 1
  | Sum.inr (Sum.inr _) => 2

/-- All oriented edge labels point to strictly greater depth. -/
theorem sunSource_depth_lt_target {d k : ℕ} (e : SunEdgeLabel d k) :
    sunDepth (sunSource e) < sunDepth (sunTarget e) := by
  cases e with
  | inl e =>
    cases e with
    | inl i =>
      norm_num [sunDepth, sunSource, sunTarget, sunHub, sunShort]
    | inr j =>
      norm_num [sunDepth, sunSource, sunTarget, sunHub, sunLong]
  | inr j =>
    norm_num [sunDepth, sunSource, sunTarget, sunLong, sunTip]

/-- Actual unordered edge corresponding to an oriented label. -/
def sunUndirectedEdge {d k : ℕ} (e : SunEdgeLabel d k) :
    Sym2 (SunVertex d k) := Sym2.mk (sunSource e, sunTarget e)

/-- Every labeled edge belongs to the actual simple graph. -/
theorem sunUndirectedEdge_mem {d k : ℕ} (e : SunEdgeLabel d k) :
    sunUndirectedEdge e ∈ (sunGraph d k).edgeSet := by
  change (sunGraph d k).Adj (sunSource e) (sunTarget e)
  exact ⟨e, Or.inl ⟨rfl, rfl⟩⟩

/-- Distinct labels cannot represent the same unordered edge. -/
theorem sunUndirectedEdge_injective (d k : ℕ) :
    Function.Injective (@sunUndirectedEdge d k) := by
  intro e f h
  change Sym2.mk (sunSource e, sunTarget e) =
    Sym2.mk (sunSource f, sunTarget f) at h
  rcases Sym2.mk_eq_mk_iff.mp h with hpair | hpair
  · exact sunTarget_injective d k (congrArg Prod.snd hpair)
  · have hsrc : sunSource e = sunTarget f := by
      simpa using congrArg Prod.fst hpair
    have htgt : sunTarget e = sunSource f := by
      simpa using congrArg Prod.snd hpair
    have he := sunSource_depth_lt_target e
    have hf := sunSource_depth_lt_target f
    rw [hsrc, htgt] at he
    omega

/-- Every actual undirected edge is represented by one of the three labels. -/
theorem sunUndirectedEdge_surjective (d k : ℕ)
    (p : Sym2 (SunVertex d k)) (hp : p ∈ (sunGraph d k).edgeSet) :
    ∃ e : SunEdgeLabel d k, sunUndirectedEdge e = p := by
  obtain ⟨⟨v, w⟩, rfl⟩ := Sym2.mk_surjective p
  change (sunGraph d k).Adj v w at hp
  rcases hp with ⟨e, he | he⟩
  · rcases he with ⟨rfl, rfl⟩
    exact ⟨e, rfl⟩
  · rcases he with ⟨rfl, rfl⟩
    exact ⟨e, Sym2.eq_swap⟩

/-- Exact equivalence with the edge set of the real `SimpleGraph`. -/
noncomputable def sunEdgeEquiv (d k : ℕ) :
    SunEdgeLabel d k ≃ (sunGraph d k).edgeSet := by
  classical
  let f : SunEdgeLabel d k → (sunGraph d k).edgeSet :=
    fun e => ⟨sunUndirectedEdge e, sunUndirectedEdge_mem e⟩
  apply Equiv.ofBijective f
  constructor
  · intro a b hab
    apply sunUndirectedEdge_injective d k
    exact congrArg Subtype.val hab
  · rintro ⟨p, hp⟩
    rcases sunUndirectedEdge_surjective d k p hp with ⟨e, he⟩
    refine ⟨e, ?_⟩
    apply Subtype.ext
    exact he

/-- Consequently the *actual graph* has d+k edges, not just labels. -/
theorem sunGraph_actual_edge_count (d k : ℕ) (hk : k ≤ d) :
    Fintype.card (sunGraph d k).edgeSet = d + k := by
  classical
  calc
    Fintype.card (sunGraph d k).edgeSet =
        Fintype.card (SunEdgeLabel d k) :=
      Fintype.card_congr (sunEdgeEquiv d k).symm
    _ = d + k := sunEdgeLabel_count d k hk

end Newton400.Case007
