import Mathlib

/-!
Case 006 / Appendix N: exact C4 frame transport algebra.
These are finite-dimensional polynomial identities. The analytic gluing,
divergence covariance, localization and weighted H8 inversion are not
end-to-end formalized in this file.
-/
namespace Newton400.Case006FrameTransport

theorem fixed_frame_defect (a c : ℝ) :
    (-a^2)^2 + (a^2)^2 + 4*(a*c)^2 =
      2*a^2*(a^2+2*c^2) := by
  ring

theorem curl_witness_x (a c : ℝ) :
    (2*a*c) - (0:ℝ) = 2*a*c := by
  ring

theorem curl_witness_y (a c : ℝ) :
    (0:ℝ) - (-2*a*c) = 2*a*c := by
  ring

theorem four_cycle (u₀ u₁ u₂ u₃ : ℝ) :
    u₁+u₂+u₃+u₀ = u₀+u₁+u₂+u₃ := by
  ring

theorem meridional_E_seed (a c x z : ℝ) :
    z*((a^2-(a^2+c^2)/3) + (-(a^2+c^2)/3) -
        2*(c^2-(a^2+c^2)/3)) + x*(a*c) =
      z*(a^2-2*c^2)+a*c*x := by
  ring

theorem azimuthal_F_seed (a c x y : ℝ) :
    -y*(a*c)+x*0 = -a*c*y := by
  ring

theorem meridional_G_seed (a c x : ℝ) :
    2*a*c*x = 2*(a*c)*x := by
  ring

theorem four_patch_moment (m : ℝ) :
    m+m+m+m = 4*m := by
  ring

theorem complete_middle_moment (B_g a c Y : ℝ) :
    B_g+4*(-a*c*Y)= B_g-4*a*c*Y := by
  ring

end Newton400.Case006FrameTransport
