import Mathlib
import NewtonConjectures.DistanceShellLaplacian

/-!
# Exact distance-shell representation of the actual reciprocal-distance matrix

Every nonzero entry 1/d(u,v) is selected exactly once by the shell
at the corresponding cycle distance. This is an all-n theorem, not
an extrapolation from sample matrices.

The diagonal weighted-degree identity required to turn this into an
exact constant-row-sum Laplacian remains a separate formal gate.
-/
namespace Newton400.Case001

noncomputable def cycleWeightedShellAdjacency (n : ℕ)
    [NeZero n] : Matrix (ZMod n) (ZMod n) ℝ := by
  classical
  exact fun u v =>
    ∑ d ∈ Finset.Icc 1 (n / 2),
      (1 / (d : ℝ)) *
        (if (cycleDistanceShell n d).Adj u v then 1 else 0)

theorem cycle_weighted_shell_adjacency_eq_reciprocal (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    cycleWeightedShellAdjacency n = actualCycleReciprocal n := by
  classical
  ext u v
  by_cases huv : u = v
  · subst v
    simp [cycleWeightedShellAdjacency, actualCycleReciprocal,
      cycleDistanceShell]
  · have hd : 1 ≤ cyclicDistance n u v :=
      cyclic_distance_positive_of_ne n u v huv
    have hdm : cyclicDistance n u v ≤ n / 2 :=
      cyclic_distance_le_half n u v
    simp [cycleWeightedShellAdjacency, actualCycleReciprocal,
      cycleDistanceShell, huv, eq_comm, Finset.mem_Icc, hd, hdm]

end Newton400.Case001
