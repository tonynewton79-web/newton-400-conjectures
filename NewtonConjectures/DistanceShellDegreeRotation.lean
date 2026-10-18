import Mathlib
import NewtonConjectures.DistanceShellDegreeBridge

/-!
# Case 001: Cyclic-translation symmetry of genuine distance shells

We certify the graph-theoretic translation invariance of the
distance-shell degree. This is a first step toward identifying the
weighted degree matrix with a scalar matrix and extracting the
real gravity spectral bound. No formula for the degree (2 or 1)
is assumed in this module.
-/
namespace Newton400.Case001

theorem cycle_distance_add_right (n : ℕ) [NeZero n]
    (u v a : ZMod n) :
    cyclicDistance n (u + a) (v + a) = cyclicDistance n u v := by
  have h : (v + a) - (u + a) = v - u := by abel
  simp only [cyclicDistance, h]

theorem distance_shell_adj_add_right (n d : ℕ) [NeZero n]
    (u v a : ZMod n) :
    (cycleDistanceShell n d).Adj (u + a) (v + a) ↔
      (cycleDistanceShell n d).Adj u v := by
  change ((u + a ≠ v + a) ∧
        cyclicDistance n (u + a) (v + a) = d) ↔
        (u ≠ v ∧ cyclicDistance n u v = d)
  rw [cycle_distance_add_right]
  constructor
  · intro h
    constructor
    · intro h0
      exact h.1 (congrArg (fun x => x + a) h0)
    · exact h.2
  · intro h
    constructor
    · intro h0
      exact h.1 (add_right_cancel h0)
    · exact h.2

noncomputable def cycleShellNeighborCount (n d : ℕ) [NeZero n]
    (u : ZMod n) : ℕ := by
  classical
  exact (Finset.univ.filter (fun v : ZMod n =>
    (cycleDistanceShell n d).Adj u v)).card

theorem cycle_shell_neighbor_count_translate (n d : ℕ) [NeZero n]
    (u a : ZMod n) :
    cycleShellNeighborCount n d (u+a) = cycleShellNeighborCount n d u := by
  classical
  unfold cycleShellNeighborCount
  apply Finset.card_bij (fun w _ => w - a)
  · intro w hw
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hw ⊢
    have hw' : (cycleDistanceShell n d).Adj (u+a) ((w-a)+a) := by
      simpa only [sub_add_cancel] using hw
    exact (distance_shell_adj_add_right n d u (w-a) a).mp hw'
  · intro w hw z hz heq
    have h := congrArg (fun x => x + a) heq
    simpa only [sub_add_cancel] using h
  · intro z hz
    refine ⟨z + a, ?_, ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hz ⊢
      exact (distance_shell_adj_add_right n d u z a).mpr hz
    · simp

end Newton400.Case001
