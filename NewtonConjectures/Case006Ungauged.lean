import Mathlib
import NewtonConjectures.Case006H8Symbol

/-!
# Case 006: the ungauged H8 characteristic axis

The exact determinant of the Gram matrix for the four-column
stress-divergence symbol (without pressure) is
  (x^2+z^2)^2 (x^2+y^2+z^2).
Consequently, its rank drops on the nonzero y-axis. Inclusion of the
pressure column is essential for the uniform symbol estimate in
Case006H8Symbol. This proves no compact weighted inverse.
-/

namespace Newton400.Case006Ungauged

/-- Determinant by expansion of the symmetric 3 by 3 Gram matrix
    [[q,xy,0],[xy,s,yz],[0,yz,q]], with
    q=x²+y²+z² and s=x²+z². -/
def gramDet (x y z : ℝ) : ℝ :=
  let q := x^2 + y^2 + z^2
  let s := x^2 + z^2
  q * (s*q - (x*y)^2 - (y*z)^2)

/-- Exact factorization and characterization of the ungauged symbol's
    determinant (the rank interpretation uses usual linear algebra). -/
theorem gram_det_exact (x y z : ℝ) :
    gramDet x y z = (x^2+z^2)^2 * (x^2+y^2+z^2) := by
  unfold gramDet
  ring

/-- The nonzero y-axis is characteristic before introducing pressure. -/
theorem characteristic_y_axis (y : ℝ) : gramDet 0 y 0 = 0 := by
  simp [gramDet]

/-- Away from the y-axis, the ungauged Gram determinant is positive. -/
theorem gram_det_positive_off_axis (x y z : ℝ)
    (h : 0 < x^2 + z^2) : 0 < gramDet x y z := by
  rw [gram_det_exact]
  have hq : 0 < x^2 + y^2 + z^2 := by
    nlinarith [sq_nonneg y]
  exact mul_pos (pow_pos h 2) hq

end Newton400.Case006Ungauged
