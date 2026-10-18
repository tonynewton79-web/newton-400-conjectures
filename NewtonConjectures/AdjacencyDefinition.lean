import Mathlib
import NewtonConjectures.AllCycleAnalytic

/-!
# Original cycle adjacency matrix: explicit graph-side formal interface

This module supplies the actual real adjacency matrix on ZMod n.
Its symmetry is verified in Lean. The ordered eigenvalue theorem
is a separate outstanding mathematical formalization target.
-/
namespace Newton400.Case001

noncomputable def cycleAdjacencyMatrix (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  fun u v =>
    if v = u + 1 ∨ u = v + 1 then 1 else 0

theorem cycleAdjacencyMatrix_transpose (n : ℕ) [NeZero n] :
    Matrix.transpose (cycleAdjacencyMatrix n) =
      cycleAdjacencyMatrix n := by
  ext u v
  simp only [Matrix.transpose_apply, cycleAdjacencyMatrix, or_comm]

theorem cycleAdjacencyMatrix_entry_symmetric (n : ℕ) [NeZero n]
    (u v : ZMod n) :
    cycleAdjacencyMatrix n u v = cycleAdjacencyMatrix n v u := by
  simpa only [Matrix.transpose_apply] using
    congrArg (fun (A : Matrix (ZMod n) (ZMod n) ℝ) => A v u)
      (cycleAdjacencyMatrix_transpose n)

theorem cycleAdjacencyMatrix_entry_nonneg (n : ℕ) [NeZero n]
    (u v : ZMod n) :
    0 ≤ cycleAdjacencyMatrix n u v := by
  unfold cycleAdjacencyMatrix
  split_ifs <;> norm_num

end Newton400.Case001
