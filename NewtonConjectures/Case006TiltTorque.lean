import Mathlib

/-!
Case 006: exact tilted-frame axisymmetric quadratic-moment transfer.

R_x(c,t) rotates the fixed four-field H8 cone frame relative to the
physical cylindrical symmetry axis. In Appendix L, the SO(2) average
of each rotated quadratic adjoint field is written in the invariant
basis A=(xz,yz,-z²), B=(-yz,xz,0), C=(0,0,x²+y²).
The corresponding coefficient matrix has a factored determinant.

This file formally certifies its FINITE POLYNOMIAL algebra only.
The cylindrical averaging/integration identities, source equivariance,
and actual H8 compact weighted inversion are not Lean formalized.
-/
namespace Newton400.Case006TiltTorque

def a₁ (t : ℝ) : ℝ := t*(3*t^2-1)/2
def c₁ (t : ℝ) : ℝ := -t*(5-3*t^2)/4
def b₂ (c t : ℝ) : ℝ := -3*c*t
def a₃ (c t : ℝ) : ℝ := c*(1-3*t^2)
def c₃ (c t : ℝ) : ℝ := -c*(1+3*t^2)/2

def meridionalDet (c t : ℝ) : ℝ :=
  a₁ t * c₃ c t - c₁ t * a₃ c t

def fullTransferDet (c t : ℝ) : ℝ :=
  b₂ c t * meridionalDet c t

theorem meridional_det_factor (c t : ℝ) :
    meridionalDet c t = (3/2 : ℝ)*c*t*(1-3*t^2) := by
  unfold meridionalDet a₁ c₁ a₃ c₃
  ring

theorem full_transfer_det_factor (c t : ℝ) :
    fullTransferDet c t = -(9/2 : ℝ)*c^2*t^2*(1-3*t^2) := by
  unfold fullTransferDet b₂
  rw [meridional_det_factor]
  ring

/-- The q₂ tilted projection against the axisymmetric azimuthal source
is -3 c t times its axial torque dipole B; B = 2π∫z m(z)dz.
Only this scalar coefficient identity is formalized here. -/
theorem q₂_torque_factor (c t torqueDipole : ℝ) :
    b₂ c t * torqueDipole = -3*c*t*torqueDipole := by
  unfold b₂
  ring

/-- For generic tilt, the two meridional constraints have target
C=0 and (1-3t²)A=2 κ Z. These identities verify the proposed
formal moment solution without division by (1-3t²). -/
theorem envelope_cancellation_first (t κ Z : ℝ) :
    a₁ t * (2*κ*Z) + κ*t*Z*(1-3*t^2) = 0 := by
  unfold a₁
  ring

theorem envelope_cancellation_third (c t κ Z : ℝ) :
    a₃ c t * (2*κ*Z) - 2*κ*c*Z*(1-3*t^2) = 0 := by
  unfold a₃
  ring

/-- A rational, unit-circle, nondegenerate illustrative frame.
Not a source-native H8 profile or the cone aperture. -/
theorem rational_tilt_example :
    (3/5 : ℚ)^2 + (4/5 : ℚ)^2 = 1 := by
  norm_num

theorem rational_transfer_det_example :
    fullTransferDet (4/5) (3/5) = (1296/15625 : ℝ) := by
  rw [full_transfer_det_factor]
  norm_num

end Newton400.Case006TiltTorque
