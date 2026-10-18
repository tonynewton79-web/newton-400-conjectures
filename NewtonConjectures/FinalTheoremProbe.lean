import Mathlib
import NewtonConjectures.AdjacencyDefinition

/-!
# Case 001: attempted FINAL GRAPH THEOREM interface (not axiomatically closed)

Unlike the earlier analytic surrogate, these definitions name the
actual real cycle adjacency and gravity matrices. The second-smallest
eigenvalue is taken from mathlib's ORDERED Hermitian eigenvalues₀
including multiplicity. The gravity span uses actual real spectral
supremum and infimum.

The closing theorem below is CONDITIONAL on exactly two unproved
graph-spectral interfaces. It tests correct end-to-end types and
reuses the unconditional Lean-certified all-size analytic inequality.
Passing this file alone MUST NOT be reported as a complete formal
proof of Graffiti 197 or of the sharp threshold.
-/

namespace Newton400.Case001

noncomputable def actualCycleReciprocal (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  fun u v =>
    if u = v then 0 else 1 / (cyclicDistance n u v : ℝ)

/-- Degree 2 at every vertex: Newton's specific published gravity
normalization is 4/((n-1)*distance), with zero diagonal. -/
noncomputable def actualCycleGravity (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  fun u v =>
    (4 : ℝ) / ((n - 1 : ℕ) : ℝ) * actualCycleReciprocal n u v

/-- Actual numerical span, not the number of distinct eigenvalues. -/
noncomputable def actualCycleGravitySpan (n : ℕ) [NeZero n] : ℝ :=
  sSup (spectrum ℝ (actualCycleGravity n)) -
    sInf (spectrum ℝ (actualCycleGravity n))

theorem cycleAdjacency_isHermitian (n : ℕ) [NeZero n] :
    (cycleAdjacencyMatrix n).IsHermitian := by
  apply Matrix.IsHermitian.ext
  intro u v
  simpa only [star_trivial] using
    (cycleAdjacencyMatrix_entry_symmetric n v u)

/-- The ordered second-smallest eigenvalue (counting multiplicities).
mathlib's eigenvalues₀ are ANTITONE, hence the index n-2. -/
noncomputable def actualSecondSmallestAdjacency (n : ℕ)
    [NeZero n] (hn : 3 ≤ n) : ℝ :=
  (cycleAdjacency_isHermitian n).eigenvalues₀
    ⟨n - 2, by
      have h : n - 2 < n := by omega
      simpa only [ZMod.card] using h⟩

/-- The exact proposed all-infinite-family theorem, assuming the
two remaining graph-spectral bridges, both written in terms of
ACTUAL matrices and the ordered adjacency eigenvalue. -/
theorem full_graffiti_strict_of_spectral_interfaces
    (n : ℕ) [NeZero n] (hn : 15 ≤ n)
    (hadj : -actualSecondSmallestAdjacency n (by omega) =
      adjacencyCosineCandidate n)
    (hgravity : actualCycleGravitySpan n ≤ gravityParityCap n) :
    actualCycleGravitySpan n <
      -actualSecondSmallestAdjacency n (by omega) := by
  rw [hadj]
  exact lt_of_le_of_lt hgravity (cycle_all_sizes_analytic_strict n hn)

/-
The unconditional target is exactly the proposition below; IT HAS
NO KERNEL PROOF IN THIS FILE and is intentionally NOT declared as a
theorem, without introducing any unsupported assumptions:
  ∀ (n : ℕ) [NeZero n], 15 ≤ n →
    actualCycleGravitySpan n <
      -actualSecondSmallestAdjacency n (by omega).
The finite converse for n=3,...,14 is a separate target.
-/

end Newton400.Case001
