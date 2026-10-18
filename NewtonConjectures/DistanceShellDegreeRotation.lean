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

theorem distance_shell_degree_translate (n d : ℕ) [NeZero n]
    (u a : ZMod n) :
    (cycleDistanceShell n d).degree (u + a) =
      (cycleDistanceShell n d).degree u := by
  classical
  change ((cycleDistanceShell n d).neighborFinset (u + a)).card =
      ((cycleDistanceShell n d).neighborFinset u).card
  apply Finset.card_bij (fun w _ => w - a)
  · intro w hw
    simp only [SimpleGraph.mem_neighborFinset] at hw ⊢
    have h := (distance_shell_adj_add_right n d u (w-a) a).mpr
    have hw' : (cycleDistanceShell n d).Adj (u + a) ((w - a) + a) := by
      apply h
      simpa only [sub_add_cancel] using hw
    simpa only [sub_add_cancel] using
      (distance_shell_adj_add_right n d u (w-a) a).mp hw'
  · intro w hw z hz heq
    exact sub_right_cancel heq
  · intro z hz
    refine ⟨z + a, ?_, ?_⟩
    · simp only [SimpleGraph.mem_neighborFinset] at hz ⊢
      exact (distance_shell_adj_add_right n d u z a).mpr hz
    · simp

end Newton400.Case001
