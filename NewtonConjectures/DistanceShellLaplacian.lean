import Mathlib
import NewtonConjectures.ActualGravityBridge

/-!
# A positive-semidefinite distance-shell Laplacian for cycles

This is a graph-theoretic upper-spectrum certificate, independently
of the shifted reciprocal-distance Gram lower-spectrum certificate.

The weighted sum of genuine graph Laplacians is PSD for every finite
family of simple graphs with nonnegative real coefficients. We also
instantiate it on undirected distance shells of the cycle.

The remaining task is to prove the actual *matrix equality*
between this sum and rowSum * I - the reciprocal-distance matrix.
-/
namespace Newton400.Case001

noncomputable def weightedGraphLaplacian
    {V ι : Type*} [Fintype V] [DecidableEq V]
    (s : Finset ι) (G : ι → SimpleGraph V) (w : ι → ℝ) :
    Matrix V V ℝ := by
  classical
  exact ∑ i ∈ s, w i • SimpleGraph.lapMatrix ℝ (G i)

theorem weighted_graph_laplacian_psd
    {V ι : Type*} [Fintype V] [DecidableEq V]
    (s : Finset ι) (G : ι → SimpleGraph V)
    (w : ι → ℝ) (hw : ∀ i ∈ s, 0 ≤ w i) :
    (weightedGraphLaplacian s G w).PosSemidef := by
  classical
  unfold weightedGraphLaplacian
  have hterm (i : ι) (hi : i ∈ s) :
      (w i • SimpleGraph.lapMatrix ℝ (G i)).PosSemidef :=
    (SimpleGraph.posSemidef_lapMatrix ℝ (G i)).smul (hw i hi)
  have hsum :
      ∀ t : Finset ι, t ⊆ s →
        (∑ i ∈ t, w i • SimpleGraph.lapMatrix ℝ (G i)).PosSemidef := by
    intro t
    induction t using Finset.induction_on with
    | empty =>
        intro _
        simpa using (Matrix.PosSemidef.zero :
          (0 : Matrix V V ℝ).PosSemidef)
    | @insert i t hi ih =>
        intro ht
        rw [Finset.sum_insert hi]
        have his : i ∈ s := ht (by simp)
        have hts : t ⊆ s := by
          intro k hk
          exact ht (by simp [hk])
        exact (hterm i his).add (ih hts)
  exact hsum s (Finset.Subset.rfl)

theorem cyclicDistance_symm (n : ℕ) [NeZero n]
    (u v : ZMod n) :
    cyclicDistance n u v = cyclicDistance n v u := by
  by_cases huv : u = v
  · subst v
    rfl
  · have hne : v - u ≠ 0 := by
      intro hz
      exact huv (sub_eq_zero.mp hz).symm
    have hr : (u - v).val = n - (v - u).val := by
      have hrev : u - v = -(v - u) := by abel
      rw [hrev, ZMod.neg_val]
      simp [hne]
    have hv : (v - u).val < n := ZMod.val_lt (v - u)
    have hd : n - (u - v).val = (v - u).val := by omega
    unfold cyclicDistance
    rw [hr]
    have hfix : n - (n - (v - u).val) = (v - u).val := by omega
    rw [hfix]
    exact Nat.min_comm _ _

def cycleDistanceShell (n d : ℕ) [NeZero n] :
    SimpleGraph (ZMod n) where
  Adj u v := u ≠ v ∧ cyclicDistance n u v = d
  symm := by
    intro u v h
    exact ⟨h.1.symm, (cyclicDistance_symm n v u).trans h.2⟩
  loopless := by
    intro u h
    exact h.1 rfl

noncomputable def cycleWeightedDistanceLaplacian (n : ℕ)
    [NeZero n] : Matrix (ZMod n) (ZMod n) ℝ :=
  weightedGraphLaplacian (Finset.Icc 1 (n/2))
    (cycleDistanceShell n) (fun d => 1 / (d : ℝ))

theorem cycle_weighted_distance_laplacian_psd (n : ℕ)
    [NeZero n] :
    (cycleWeightedDistanceLaplacian n).PosSemidef := by
  classical
  unfold cycleWeightedDistanceLaplacian
  apply weighted_graph_laplacian_psd
  intro d hd
  positivity

end Newton400.Case001
