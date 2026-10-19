import Mathlib

/-!
Case 006: exact two-scale determinant suppression near half-turn symmetry.

This file certifies finite-dimensional algebra from Appendix K.
The sharp universal real determinant box bound is proved in the paper,
not formally verified by this file. No Navier–Stokes source family is
constructed and no H8 inversion is proved.
-/
namespace Newton400.Case006Conditioning

def det3 (a b c d e f g h i : ℝ) : ℝ :=
  a*e*i + b*f*g + c*d*h - c*e*g - b*d*i - a*f*h

theorem determinant_quadratic_suppression
    (eps a b c d e f g h i : ℝ) :
    det3 (eps*a) (eps*b) (eps*c)
         (eps*d) (eps*e) (eps*f) g h i =
      eps^2 * det3 a b c d e f g h i := by
  unfold det3
  ring

theorem determinant_two_scale
    (eps m a b c d e f g h i : ℝ) :
    det3 (eps*a) (eps*b) (eps*c)
         (eps*d) (eps*e) (eps*f)
         (m*g) (m*h) (m*i) =
      eps^2 * m * det3 a b c d e f g h i := by
  unfold det3
  ring

theorem parity_block_determinant (a b c d e : ℝ) :
    det3 a b 0 c d 0 0 0 e = e*(a*d-b*c) := by
  unfold det3
  ring

theorem nonzero_of_two_scale
    (eps m a b c d e f g h i : ℝ)
    (heps : eps ≠ 0) (hm : m ≠ 0)
    (hdet : det3 a b c d e f g h i ≠ 0) :
    det3 (eps*a) (eps*b) (eps*c)
         (eps*d) (eps*e) (eps*f)
         (m*g) (m*h) (m*i) ≠ 0 := by
  rw [determinant_two_scale]
  exact mul_ne_zero (mul_ne_zero (pow_ne_zero 2 heps) hm) hdet

theorem sharp_sign_vertex :
    det3 1 1 1 1 (-1) 1 1 1 (-1) = 4 := by
  norm_num [det3]

theorem rational_interval_witness :
    (18:ℚ)*9/100 + (18:ℚ)*3/10000 + 6/1000000 < 5 := by
  norm_num

end Newton400.Case006Conditioning
