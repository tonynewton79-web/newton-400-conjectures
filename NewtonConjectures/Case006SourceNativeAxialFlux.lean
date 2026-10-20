import Mathlib

/-!
Case006 Appendix AC: finite algebraic source-native H8 axial stress
flux checks. Does NOT formalize angular integration, pressure traces,
transported chart geometry, or the full Navier--Stokes PDE.
-/
namespace Newton400.Case006SourceNativeAxialFlux

private def alpha : ℚ := -(4443 / 9832)
private def kappa : ℚ := 15971 / 122900
private def alphaR : ℝ := -(4443 / 9832)

theorem physical_shear_negative :
    alpha = -(4443 : ℚ)/9832 := by
  norm_num [alpha]

theorem exact_source_interval_left :
    alpha-kappa = -(143017 : ℚ)/245800 := by
  norm_num [alpha,kappa]

theorem exact_source_interval_right :
    alpha+kappa = -(79133 : ℚ)/245800 := by
  norm_num [alpha,kappa]

theorem physical_shear_exceeds_budget : kappa < -alpha := by
  norm_num [alpha,kappa]

theorem cylindrical_radial_divergence_jet
    (r s ds q : ℝ) (hr : r ≠ 0) :
    r*(ds+s/r+q) = r*ds+s+r*q := by
  field_simp
  ring

theorem primitive_boundary_accounting
    (T R a r T0 R0 H : ℝ) :
    T-alphaR*R-(a/r)*(T0-alphaR*R0)+H =
    T-alphaR*R+(H-(a/r)*(T0-alphaR*R0)) := by
  ring

theorem sharp_aligned_capacity (k : ℝ) :
    4*(k/8)+k/2=k := by ring

theorem cone_to_axial_capacity
    (B E k : ℝ)
    (hB : 8*|B| ≤ k) (hE : 2*|E| ≤ k) :
    |4*B+E| ≤ k := by
  have htri : |4*B+E| ≤ |4*B|+|E| := abs_add_le _ _
  have hm : |4*B|=4*|B| := by
    rw [abs_mul, abs_of_nonneg (show (0:ℝ) ≤ 4 by norm_num)]
  rw [hm] at htri
  linarith

theorem compact_source_shear (T R : ℝ) :
    T-alphaR*R = T+(4443:ℝ)/9832*R := by
  norm_num [alphaR]

end Newton400.Case006SourceNativeAxialFlux
