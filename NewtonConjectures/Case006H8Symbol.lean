import Mathlib

/-!
# Case 006: exact H8 symbol coercivity

This file analyses the **augmented** principal symbol (four trace-free
stress fields A,B,C,D plus the pressure gauge p) associated with equation
(269) and the projected-divergence equation (273) in
Tony Newton, *Carrier-Independent Structured Stress Route from an Exact
Unforced Navier--Stokes Core*, DOI 10.5281/zenodo.23475142.

At covector (x,y,z) the divergence-plus-pressure symbol is the 3 by 5
matrix with rows
  (z, 0, y, -x, x)
  (0, z, x,  0, y)
  (x, y, 0,  z, z).
Its transpose acts on (a,b,c) by the five components in symbolEnergy.

The main identity is a uniform sharp 1/5 sum-of-squares frame bound.
It verifies a constant-coefficient Fourier-symbol property only, NOT
the compactly supported weighted anti-divergence H8 bound, the
variable-coefficient estimates, or the Navier--Stokes theorem.
-/

namespace Newton400.Case006H8

/-- Squared Euclidean norm of the transpose of the 3x5
    stress-divergence/pressure-gauge symbol at (x,y,z). -/
def symbolEnergy (x y z a b c : ℝ) : ℝ :=
  (z*a+x*c)^2 + (z*b+y*c)^2 + (y*a+x*b)^2 +
  (-x*a+z*c)^2 + (x*a+y*b+z*c)^2

/-- The exact quantitative factorization of the symbol energy.
    Every term on the right is an explicit nonnegative square. -/
theorem symbol_energy_exact_sos (x y z a b c : ℝ) :
    symbolEnergy x y z a b c -
        ((x^2+y^2+z^2)*(a^2+b^2+c^2))/5 =
      (4/5 : ℝ) * ((y*a+x*b)^2 + (y*c+z*b)^2 +
                     (z*a-x*c)^2) +
      (1/5 : ℝ) * (3*(x*a+z*c)+2*y*b)^2 := by
  unfold symbolEnergy
  ring

/-- A universal coercivity estimate for the five-component augmented
    H8 symbol, with the optimal constant 1/5. -/
theorem symbol_energy_lower_bound (x y z a b c : ℝ) :
    ((x^2+y^2+z^2)*(a^2+b^2+c^2))/5 ≤
      symbolEnergy x y z a b c := by
  have h := symbol_energy_exact_sos x y z a b c
  have hpos : 0 ≤
      (4/5 : ℝ) * ((y*a+x*b)^2 + (y*c+z*b)^2 +
                     (z*a-x*c)^2) +
      (1/5 : ℝ) * (3*(x*a+z*c)+2*y*b)^2 := by
    positivity
  linarith

/-- Explicit polynomial for the determinant of the Gram matrix MMᵀ
    of the 3x5 augmented symbol, using its simplified 3x3 entries. -/
def gramDetPolynomial (x y z : ℝ) : ℝ :=
  let X := x^2
  let Y := y^2
  let Z := z^2
  (X+Y+Z) * (2*(X+Z)^2 - Y*(X+Z) + Y^2)

/-- Exact sum-of-squares factorization of the determinant polynomial. -/
theorem gram_det_polynomial_exact_sos (x y z : ℝ) :
    16 * gramDetPolynomial x y z =
      (x^2+y^2+z^2) *
       (7*(x^2+y^2+z^2)^2 +
        (3*y^2 - 5*(x^2+z^2))^2) := by
  unfold gramDetPolynomial
  ring

/-- The determinant polynomial has an explicit degree-six lower bound. -/
theorem gram_det_polynomial_lower (x y z : ℝ) :
    (7/16 : ℝ) * (x^2+y^2+z^2)^3 ≤
      gramDetPolynomial x y z := by
  have h := gram_det_polynomial_exact_sos x y z
  have hs : 0 ≤ x^2+y^2+z^2 := by positivity
  have hp : 0 ≤ (3*y^2-5*(x^2+z^2))^2 := sq_nonneg _
  have hprod := mul_nonneg hs hp
  nlinarith [hprod]

end Newton400.Case006H8
