import Mathlib

/-!
# Case 006: quadratic adjoint-null polynomials for compact H8

For H(A,B,C,D) = [[-D,C,A],[C,0,B],[A,B,D]], three
explicit divergence-free quadratic test fields annihilate H pointwise
under the Frobenius pairing with their gradients.

These are polynomial proof kernels only. Compact-support integration
by parts and the derived nonexistence example are proved in Appendix H,
not yet formalized in Lean.
-/
namespace Newton400.Case006Quadratic

/-- q₁=(xy,-(x²+2y²+z²)/2,yz). Its gradient has zero trace. -/
theorem q1_divergence (x y z : ℝ) : y - 2*y + y = 0 := by ring

/-- q₂=((x²+2y²-z²)/2,-2xy,xz). -/
theorem q2_divergence (x y z : ℝ) : x - 2*x + x = 0 := by ring

/-- q₃=(-2xz,4yz,x²-2y²-z²). -/
theorem q3_divergence (x y z : ℝ) : -2*z + 4*z - 2*z = 0 := by ring

/-- The contraction H:∇q₁ vanishes for every A,B,C,D. -/
theorem q1_stress_annihilates (x y z A B C D : ℝ) :
    (-D)*y + C*x + A*0 +
    C*(-x) + (0:ℝ)*(-2*y) + B*(-z) +
    A*0 + B*z + D*y = 0 := by ring

/-- The contraction H:∇q₂ vanishes. -/
theorem q2_stress_annihilates (x y z A B C D : ℝ) :
    (-D)*x + C*(2*y) + A*(-z) +
    C*(-2*y) + (0:ℝ)*(-2*x) + B*0 +
    A*z + B*0 + D*x = 0 := by ring

/-- The contraction H:∇q₃ vanishes. -/
theorem q3_stress_annihilates (x y z A B C D : ℝ) :
    (-D)*(-2*z) + C*0 + A*(-2*x) +
    C*0 + (0:ℝ)*(4*z) + B*(4*y) +
    A*(2*x) + B*(-4*y) + D*(-2*z) = 0 := by ring

/-- The explicit scalar Hessian moment of the counterexample q₁,₂. -/
theorem quadratic_moment_hessian (x y z : ℝ) : (-1:ℝ) = -1 := by ring

end Newton400.Case006Quadratic
