import Mathlib
import NewtonConjectures.ScalarGravityUpper

/-!
# Stage 15a: exact cycle-distance fibres in canonical residues

For any n>=4 and 1<=d<=floor(n/2), the cycle vertices at
distance d from zero are exactly the two residues d and n-d.
For an even cycle's antipodal shell these residues coincide.
This lemma is an essential all-n bridge to harmonic row-sum
evaluation, not itself the completed count theorem.
-/
namespace Newton400.Case001

theorem cyclic_distance_zero_iff_residue
    (n d : ℕ) [NeZero n] (hn : 4 ≤ n)
    (hd : 1 ≤ d) (hdm : d ≤ n / 2)
    (v : ZMod n) :
    cyclicDistance n 0 v = d ↔
      v.val = d ∨ v.val = n - d := by
  have hv : v.val < n := ZMod.val_lt v
  have hdn : d < n := by omega
  unfold cyclicDistance
  simp only [sub_zero]
  omega

theorem cyclic_distance_zero_fibre_element
    (n d : ℕ) [NeZero n] (hn : 4 ≤ n)
    (hd : 1 ≤ d) (hdm : d ≤ n / 2)
    (v : ZMod n) (hv : cyclicDistance n 0 v = d) :
    v = (d : ZMod n) ∨ v = ((n - d : ℕ) : ZMod n) := by
  have hres := (cyclic_distance_zero_iff_residue n d hn hd hdm v).mp hv
  rcases hres with h | h
  · left
    calc
      v = ((v.val : ℕ) : ZMod n) := (ZMod.natCast_zmod_val v).symm
      _ = (d : ZMod n) := by rw [h]
  · right
    calc
      v = ((v.val : ℕ) : ZMod n) := (ZMod.natCast_zmod_val v).symm
      _ = ((n - d : ℕ) : ZMod n) := by rw [h]

end Newton400.Case001
