import Mathlib

/-!
# Case 006: rational seven-ray stress certificate

This file verifies finite algebra from Proposition 9.22 and equations
(262)--(272) of Tony Newton, *Carrier-Independent Structured Stress Route from
an Exact Unforced Navier--Stokes Core* (Zenodo 10.5281/zenodo.23475142).

It does not prove the compact anti-divergence H8 estimate, existence of
the proposed singular core, or Navier--Stokes finite-energy breakdown.
-/

namespace Newton400.Case006

private def v1 : Fin 3 → ℚ := ![1, 0, 0]
private def v2 : Fin 3 → ℚ := ![1, 1/4, 0]
private def v3 : Fin 3 → ℚ := ![1, -1/4, 0]
private def v4 : Fin 3 → ℚ := ![1, 0, 1/4]
private def v5 : Fin 3 → ℚ := ![1, 0, -1/4]
private def v6 : Fin 3 → ℚ := ![1, 1/4, 1/4]
private def v7 : Fin 3 → ℚ := ![1, 1/4, -1/4]
private def outer (v : Fin 3 → ℚ) (i j : Fin 3) : ℚ := v i * v j

/-- The weighted sum of seven exact rank-one ray tensors. -/
def covariance (i j : Fin 3) : ℚ :=
    outer v1 i j + outer v2 i j + (59 / 43 : ℚ) * outer v3 i j +
    outer v4 i j + outer v5 i j + outer v6 i j + outer v7 i j

def displayedCovariance : Fin 3 → Fin 3 → ℚ :=
  ![ ![(317:ℚ)/43, 35/86, 0],
     ![35/86, 47/172, 0],
     ![0, 0, 1/4] ]

/-- All nine entries of the 7-ray covariance match (263). -/
theorem sevenRay_covariance_exact (i j : Fin 3) :
    covariance i j = displayedCovariance i j := by
  fin_cases i <;> fin_cases j <;>
    norm_num [covariance, displayedCovariance, outer, v1, v2, v3, v4, v5, v6, v7]

def covarianceTrace : ℚ :=
  covariance 0 0 + covariance 1 1 + covariance 2 2

theorem covariance_trace_exact : covarianceTrace = (679:ℚ)/86 := by
  unfold covarianceTrace
  rw [sevenRay_covariance_exact 0 0, sevenRay_covariance_exact 1 1,
      sevenRay_covariance_exact 2 2]
  change (317:ℚ)/43 + (47:ℚ)/172 + (1:ℚ)/4 = 679/86
  norm_num

private def axis (i : Fin 3) : ℚ := ![35, 2, 0] i
private def delta (i j : Fin 3) : ℚ := if i = j then 1 else 0

/-- Exact rational rank-one identity for the normalized trace-free stress. -/
theorem normalized_tracefree_rank_one (i j : Fin 3) :
    (172/1229 : ℚ) *
      (covariance i j - (covarianceTrace / 3) * delta i j) =
      (axis i * axis j) / 1229 - delta i j / 3 := by
  rw [sevenRay_covariance_exact, covariance_trace_exact]
  fin_cases i <;> fin_cases j <;>
    norm_num [displayedCovariance, axis, delta]

theorem axial_efficiency_margin :
    (4443:ℚ)/9832 - (9:ℚ)/20 = 93/49160 := by
  norm_num

theorem axial_efficiency_strict : (9:ℚ)/20 < 4443/9832 := by
  norm_num

def normalizedCoefficient (a : Fin 7) : ℚ :=
  ![(172:ℚ)/1229, 172/1229, 236/1229, 172/1229,
    172/1229, 172/1229, 172/1229] a

theorem coefficient_positive_floor (a : Fin 7) :
    (172:ℚ)/1229 ≤ normalizedCoefficient a := by
  fin_cases a <;> norm_num [normalizedCoefficient]

/-- The four-field coefficient corrections of equation (270). -/
def coefficientPerturbation (A B C D : ℚ) (a : Fin 7) : ℚ :=
  ![-(3/2:ℚ)*D, 2*C-4*D, -2*C-4*D,
    2*A-8*B+4*D, -2*A+8*B+4*D, 8*B, -8*B] a

theorem coefficient_budget_exact :
    (172:ℚ)/1229 - (1:ℚ)/100 = 15971/122900 := by
  norm_num

/-- If the open H8 coefficient estimate is assumed, the minimum cone floor
    follows. This theorem does NOT establish that PDE estimate. -/
theorem weighted_floor_from_budget
    (rho A B C D : ℚ) (hrho : 0 ≤ rho)
    (hBound : ∀ a : Fin 7,
      |coefficientPerturbation A B C D a| ≤ (15971:ℚ)/122900 * rho) :
    ∀ a : Fin 7, rho/100 ≤
      normalizedCoefficient a * rho + coefficientPerturbation A B C D a := by
  intro a
  have hLow := (abs_le.mp (hBound a)).1
  have hCoeff := mul_le_mul_of_nonneg_right (coefficient_positive_floor a) hrho
  have hId : (172:ℚ)/1229 = (1:ℚ)/100 + (15971:ℚ)/122900 := by
    norm_num
  rw [hId] at hCoeff
  linarith

theorem balanced_slot_incompatibility (gamma : ℝ)
    (hLock : (1/2:ℝ) < gamma) (hCut : gamma < (1/2:ℝ)) : False := by
  linarith

theorem two_color_partition (chi0 chi1 q : ℝ)
    (h : chi0^2 + chi1^2 = 1) :
    chi0^2 * q + chi1^2 * q = q := by
  calc
    chi0^2 * q + chi1^2 * q = (chi0^2 + chi1^2) * q := by ring
    _ = q := by rw [h]; ring

theorem cutoff_particular (chi chip r a : ℝ) :
    -(chip*r + chi*(a*r)) - a*(-chi*r) = -(chip*r) := by
  ring

end Newton400.Case006
