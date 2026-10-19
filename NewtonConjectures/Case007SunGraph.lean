import Mathlib

/-!
The finite eclipsed-sun graph and its three disjoint edge classes.
The edge-index sums below are exact sums over the constructed labels.
Identifying labels with `SimpleGraph.edgeFinset` and proving the
actual endpoint degrees are separately tracked formalization obligations.
-/

namespace Newton400.Case007

/-- A hub, d-k short-arm leaves, k long-arm intermediate vertices,
and k terminal leaves. -/
abbrev SunVertex (d k : ℕ) := Fin 1 ⊕ ((Fin (d - k) ⊕ Fin k) ⊕ Fin k)

/-- Three edge families: short hub, long hub, and terminal. -/
abbrev SunEdgeLabel (d k : ℕ) := (Fin (d - k) ⊕ Fin k) ⊕ Fin k

def sunHub (d k : ℕ) : SunVertex d k := Sum.inl 0

def sunShort {d k : ℕ} (i : Fin (d - k)) : SunVertex d k :=
  Sum.inr (Sum.inl (Sum.inl i))

def sunLong {d k : ℕ} (j : Fin k) : SunVertex d k :=
  Sum.inr (Sum.inl (Sum.inr j))

def sunTip {d k : ℕ} (j : Fin k) : SunVertex d k :=
  Sum.inr (Sum.inr j)

/-- Source endpoint of each oriented edge label. -/
def sunSource {d k : ℕ} : SunEdgeLabel d k → SunVertex d k
  | Sum.inl (Sum.inl _) => sunHub d k
  | Sum.inl (Sum.inr _) => sunHub d k
  | Sum.inr j => sunLong j

/-- Target endpoint; the orientation has no graph-theoretic significance. -/
def sunTarget {d k : ℕ} : SunEdgeLabel d k → SunVertex d k
  | Sum.inl (Sum.inl i) => sunShort i
  | Sum.inl (Sum.inr j) => sunLong j
  | Sum.inr j => sunTip j

theorem sunSource_ne_sunTarget {d k : ℕ} (e : SunEdgeLabel d k) :
    sunSource e ≠ sunTarget e := by
  cases e with
  | inl e =>
      cases e with
      | inl i => simp [sunSource, sunTarget, sunHub, sunShort]
      | inr j => simp [sunSource, sunTarget, sunHub, sunLong]
  | inr j => simp [sunSource, sunTarget, sunLong, sunTip]

/-- Adjacency induced by the three classes of undirected edges. -/
def sunAdjacent (d k : ℕ) (v w : SunVertex d k) : Prop :=
  ∃ e : SunEdgeLabel d k,
    (v = sunSource e ∧ w = sunTarget e) ∨
    (v = sunTarget e ∧ w = sunSource e)

/-- A genuine finite simple graph, not merely a scalar formula. -/
def sunGraph (d k : ℕ) : SimpleGraph (SunVertex d k) where
  Adj := sunAdjacent d k
  symm := by
    intro v w h
    rcases h with ⟨e, h | h⟩
    · exact ⟨e, Or.inr ⟨h.2, h.1⟩⟩
    · exact ⟨e, Or.inl ⟨h.2, h.1⟩⟩
  loopless := by
    intro v h
    rcases h with ⟨e, h | h⟩
    · exact (sunSource_ne_sunTarget e) (h.1.symm.trans h.2)
    · exact (sunSource_ne_sunTarget e) (h.2.symm.trans h.1)

/-- Exact vertex count of the constructed finite graph. -/
theorem sunVertex_count (d k : ℕ) (hk : k ≤ d) :
    Fintype.card (SunVertex d k) = d + k + 1 := by
  simp [SunVertex, Fintype.card_sum]
  omega

/-- Count of labels: d-k short edges, k long root edges and k tips. -/
theorem sunEdgeLabel_count (d k : ℕ) (hk : k ≤ d) :
    Fintype.card (SunEdgeLabel d k) = d + k := by
  simp [SunEdgeLabel, Fintype.card_sum]
  omega

theorem sunAdj_short {d k : ℕ} (i : Fin (d - k)) :
    (sunGraph d k).Adj (sunHub d k) (sunShort i) := by
  exact ⟨Sum.inl (Sum.inl i), Or.inl ⟨rfl, rfl⟩⟩

theorem sunAdj_long {d k : ℕ} (j : Fin k) :
    (sunGraph d k).Adj (sunHub d k) (sunLong j) := by
  exact ⟨Sum.inl (Sum.inr j), Or.inl ⟨rfl, rfl⟩⟩

theorem sunAdj_tip {d k : ℕ} (j : Fin k) :
    (sunGraph d k).Adj (sunLong j) (sunTip j) := by
  exact ⟨Sum.inr j, Or.inl ⟨rfl, rfl⟩⟩

/-- Exhaustion of all edge labels by the three mutually disjoint constructors. -/
theorem sunEdgeLabel_cases {d k : ℕ} (e : SunEdgeLabel d k) :
    (∃ i : Fin (d-k), e = Sum.inl (Sum.inl i)) ∨
    (∃ j : Fin k, e = Sum.inl (Sum.inr j)) ∨
    (∃ j : Fin k, e = Sum.inr j) := by
  cases e with
  | inl e =>
      cases e with
      | inl i => exact Or.inl ⟨i, rfl⟩
      | inr j => exact Or.inr (Or.inl ⟨j, rfl⟩)
  | inr j => exact Or.inr (Or.inr ⟨j, rfl⟩)

/-- Edge weights assigned from the three degree-pair types.
Proving equality with actual `sunGraph.degree` is the next formal gate. -/
def sunEdgeWeight (d k : ℕ) : SunEdgeLabel d k → ℝ
  | Sum.inl (Sum.inl _) => Real.sqrt ((d : ℝ)^2 + 1)
  | Sum.inl (Sum.inr _) => Real.sqrt ((d : ℝ)^2 + 4)
  | Sum.inr _ => Real.sqrt 5

def sunLabelS (d k : ℕ) : ℝ :=
  ∑ e : SunEdgeLabel d k, sunEdgeWeight d k e

def sunLabelR (d k : ℕ) : ℝ :=
  ∑ e : SunEdgeLabel d k, (sunEdgeWeight d k e)⁻¹

/-- Sum over exactly d-k, k and k members of the three edge families. -/
theorem sunLabelS_three_types (d k : ℕ) :
    sunLabelS d k =
      ((d-k : ℕ) : ℝ) * Real.sqrt ((d : ℝ)^2 + 1) +
      (k : ℝ) * Real.sqrt ((d : ℝ)^2 + 4) +
      (k : ℝ) * Real.sqrt 5 := by
  simp [sunLabelS, SunEdgeLabel, sunEdgeWeight, Fintype.sum_sum_type, mul_comm]

theorem sunLabelR_three_types (d k : ℕ) :
    sunLabelR d k =
      ((d-k : ℕ) : ℝ) * (Real.sqrt ((d : ℝ)^2 + 1))⁻¹ +
      (k : ℝ) * (Real.sqrt ((d : ℝ)^2 + 4))⁻¹ +
      (k : ℝ) * (Real.sqrt 5)⁻¹ := by
  simp [sunLabelR, SunEdgeLabel, sunEdgeWeight, Fintype.sum_sum_type, mul_comm]

end Newton400.Case007
