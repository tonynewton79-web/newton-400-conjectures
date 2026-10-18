import Mathlib
import NewtonConjectures.DistanceShellDegreeRotation

/-!
# Stage 13b — actual scalar shell-degree matrix gate

The scalar is the exact weighted shell-neighbor count at zero.
The next mathematical gate is to evaluate that scalar uniformly
as the parity-dependent harmonic expression.
-/
namespace Newton400.Case001

theorem cycle_weighted_degree_matrix_scalar (n : ℕ) [NeZero n] :
    cycleWeightedDegreeMatrix n =
      (cycleWeightedShellCount n 0) •
        (1 : Matrix (ZMod n) (ZMod n) ℝ) := by
  classical
  ext u v
  by_cases huv : u = v
  · subst v
    have hcount := cycle_weighted_shell_count_constant n u
    have hentry :
        cycleWeightedDegreeMatrix n u u =
          cycleWeightedShellCount n u := by
      simp [cycleWeightedDegreeMatrix, cycleWeightedShellCount,
        SimpleGraph.degMatrix, Matrix.sum_apply,
        Matrix.smul_apply, Matrix.diagonal_apply,
        cycleShellNeighborCount, cycleShellFiniteDegree,
        SimpleGraph.degree, SimpleGraph.neighborFinset_eq_filter,
        smul_eq_mul]
    simpa [Matrix.smul_apply, Matrix.one_apply] using
      (hentry.trans hcount)
  · simp [cycleWeightedDegreeMatrix,
      SimpleGraph.degMatrix, Matrix.sum_apply,
      Matrix.smul_apply, Matrix.diagonal_apply,
      Matrix.one_apply, huv]

end Newton400.Case001
