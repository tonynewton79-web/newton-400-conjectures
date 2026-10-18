import Mathlib
import NewtonConjectures.CyclicZMod

namespace Newton400.Case001

/-- Incidence matrix of cyclic intervals: row u records all arc vertices k
with displacement (k-u).val < j, over the finite cyclic group ZMod n. -/
noncomputable def cyclicIncidence (n j : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℚ :=
  fun u k => if (k-u).val < j then 1 else 0

/-- Full cyclic Gram entry identity for every pair of vertices u,v.
Nat subtraction implements max(j - cyclicDistance, 0). -/
theorem cyclic_incidence_gram_entry (n j : ℕ) [NeZero n]
    (u v : ZMod n) (hj : 2*j ≤ n) :
    (cyclicIncidence n j * (cyclicIncidence n j)ᵀ) u v =
      ((j - cyclicDistance n u v : ℕ) : ℚ) := by
  classical
  have hpoint (t : ZMod n) :
      (if (t-u).val < j then (1:ℚ) else 0) *
        (if (t-v).val < j then (1:ℚ) else 0) =
      (if (t-u).val < j ∧ (t-v).val < j then (1:ℚ) else 0) := by
    by_cases hu : (t-u).val < j
    · by_cases hv : (t-v).val < j
      · simp [hu, hv]
      · simp [hu, hv]
    · simp [hu]
  calc
    (cyclicIncidence n j * (cyclicIncidence n j)ᵀ) u v =
        ∑ t : ZMod n,
          (if (t-u).val < j then (1:ℚ) else 0) *
          (if (t-v).val < j then (1:ℚ) else 0) := by
            simp [Matrix.mul_apply, cyclicIncidence, Matrix.transpose_apply]
    _ = ∑ t : ZMod n,
          (if (t-u).val < j ∧ (t-v).val < j then (1:ℚ) else 0) := by
            apply Finset.sum_congr rfl
            intro t _
            exact hpoint t
    _ = (cyclicArcOverlap n j u v : ℚ) := by
          simp only [cyclicArcOverlap]
          rw [← Finset.sum_filter]
          simp
    _ = ((j-cyclicDistance n u v : ℕ) : ℚ) := by
          rw [cyclic_arc_overlap_distance n j u v hj]

end Newton400.Case001
