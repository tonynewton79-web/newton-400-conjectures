import Mathlib
import NewtonConjectures.DistanceShellAdjacency

/-!
# Exact matrix identity for the weighted distance-shell Laplacian

The actual unshifted reciprocal-distance matrix is the weighted
distance-shell adjacency sum. We now link the *same* weighted
distance-shell graph Laplacian to a weighted degree diagonal minus
the actual reciprocal-distance matrix.

A separate theorem must still show that this degree diagonal is
the constant common row sum needed in the upper spectrum bound.
-/
namespace Newton400.Case001

noncomputable def cycleDistanceShellAdjMatrix (n d : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ := by
  classical
  exact (cycleDistanceShell n d).adjMatrix ℝ

noncomputable def cycleWeightedDegreeMatrix (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ := by
  classical
  exact ∑ d ∈ Finset.Icc 1 (n/2),
    (1 / (d : ℝ)) • SimpleGraph.degMatrix ℝ (cycleDistanceShell n d)

theorem cycle_weighted_shell_matrix_eq_adjacency_sum (n : ℕ)
    [NeZero n] :
    cycleWeightedShellAdjacency n =
      ∑ d ∈ Finset.Icc 1 (n/2),
        (1 / (d : ℝ)) •
          cycleDistanceShellAdjMatrix n d := by
  classical
  ext u v
  simp [cycleWeightedShellAdjacency, Matrix.sum_apply,
    Matrix.smul_apply, cycleDistanceShellAdjMatrix,
    SimpleGraph.adjMatrix_apply, smul_eq_mul]

theorem cycle_weighted_lap_eq_degree_sub_reciprocal (n : ℕ)
    [NeZero n] (hn : 4 ≤ n) :
    cycleWeightedDistanceLaplacian n =
      cycleWeightedDegreeMatrix n - actualCycleReciprocal n := by
  classical
  rw [← cycle_weighted_shell_adjacency_eq_reciprocal n hn,
    cycle_weighted_shell_matrix_eq_adjacency_sum]
  unfold cycleWeightedDistanceLaplacian weightedGraphLaplacian
  unfold cycleWeightedDegreeMatrix
  simp_rw [SimpleGraph.lapMatrix, smul_sub]
  rw [Finset.sum_sub_distrib]
  simp [cycleDistanceShellAdjMatrix]

end Newton400.Case001
