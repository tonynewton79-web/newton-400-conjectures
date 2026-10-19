import Mathlib

/-!
Case 006 / Appendix M: fourfold symmetry of quadratic vector polynomials.

The action on vector fields is (R • q)(X) = Rᵀ q(R X). We prove
that averaging over the four quarter-turns about the z-axis maps
any degree-≤2 polynomial vector to the eight-parameter general
SO(2)-equivariant polynomial vector field of degree ≤2.

This algebraic result does NOT establish C4 symmetry of the prepared
Navier--Stokes source and does not establish the weighted compact H8
inverse. The integrals and SO(2) PDE action have not been formalized.
-/
namespace Newton400.Case006C4

/-- All 10 scalar monomials of total degree at most two. -/
def quad (a : Fin 10 → ℝ) (x y z : ℝ) : ℝ :=
  a 0 + a 1*x + a 2*y + a 3*z + a 4*x^2 + a 5*x*y +
  a 6*x*z + a 7*y^2 + a 8*y*z + a 9*z^2

/-- x-component of the C4 average of (u,v,w) as a vector field. -/
def projX (u v : Fin 10 → ℝ) (x y z : ℝ) : ℝ :=
  (quad u x y z + quad v (-y) x z -
   quad u (-x) (-y) z - quad v y (-x) z)/4

/-- y-component of the C4 average. -/
def projY (u v : Fin 10 → ℝ) (x y z : ℝ) : ℝ :=
  (quad v x y z - quad u (-y) x z -
   quad v (-x) (-y) z + quad u y (-x) z)/4

/-- z-component of the C4 average. -/
def projZ (w : Fin 10 → ℝ) (x y z : ℝ) : ℝ :=
  (quad w x y z + quad w (-y) x z +
   quad w (-x) (-y) z + quad w y (-x) z)/4

/-- Exact C4-to-SO2 normal-form coefficient identity, first component. -/
theorem projX_normal (u v : Fin 10 → ℝ) (x y z : ℝ) :
    projX u v x y z =
      ((u 1 + v 2)/2)*x + ((u 2 - v 1)/2)*y +
      ((u 6 + v 8)/2)*x*z + ((u 8 - v 6)/2)*y*z := by
  unfold projX quad
  ring

/-- Exact second component: same four coefficients, rotated. -/
theorem projY_normal (u v : Fin 10 → ℝ) (x y z : ℝ) :
    projY u v x y z =
      -((u 2 - v 1)/2)*x + ((u 1 + v 2)/2)*y -
      ((u 8 - v 6)/2)*x*z + ((u 6 + v 8)/2)*y*z := by
  unfold projY quad
  ring

/-- Exact axial component: only z, z² and x²+y² remain. -/
theorem projZ_normal (w : Fin 10 → ℝ) (x y z : ℝ) :
    projZ w x y z =
      w 0 + w 3*z + w 9*z^2 + ((w 4 + w 7)/2)*(x^2+y^2) := by
  unfold projZ quad
  ring

/-- The eight-parameter resulting polynomial is quarter-turn equivariant. -/
def normalX (a b c d x y z : ℝ) : ℝ :=
  a*x + b*y + c*x*z + d*y*z

def normalY (a b c d x y z : ℝ) : ℝ :=
  -b*x + a*y - d*x*z + c*y*z

def normalZ (e f g h x y z : ℝ) : ℝ :=
  e + f*z + g*z^2 + h*(x^2+y^2)

theorem normal_quarter_turn_x (a b c d x y z : ℝ) :
    normalY a b c d (-y) x z = normalX a b c d x y z := by
  unfold normalY normalX
  ring

theorem normal_quarter_turn_y (a b c d x y z : ℝ) :
    -normalX a b c d (-y) x z = normalY a b c d x y z := by
  unfold normalX normalY
  ring

theorem normal_quarter_turn_z (e f g h x y z : ℝ) :
    normalZ e f g h (-y) x z = normalZ e f g h x y z := by
  unfold normalZ
  ring

end Newton400.Case006C4
