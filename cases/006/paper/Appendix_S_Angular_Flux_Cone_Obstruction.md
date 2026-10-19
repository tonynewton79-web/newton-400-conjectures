# Appendix S. A weighted angular-flux obstruction for the H8 cone correction

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* ([original manuscript](https://doi.org/10.5281/zenodo.23475142)). This source accompanies the independently typeset two-page Appendix S on pages 95–96 of the **96-page cumulative paper**, with previous pages 1–94 preserved text-identically.

## Why a further necessary condition matters

Appendix R constructs explicit normalized curved-shell torque controls and a conditional two-by-two inverse bound. What it cannot certify without frozen source coefficients is the *weighted pointwise* seven-ray correction norm in original equations (269)–(273). The physical stress cone has an exact coefficient floor that provides a sharp **one-dimensional necessary condition** before any candidate weighted inverse is attempted.

Work in a full cylindrical chart away from the symmetry axis, with smooth compact source `g`, smooth nonnegative compact envelope `rho`, and compact symmetric correction `H`; all fields and pressure are 2π-periodic in the angular coordinate. No axial SO(2) symmetry is needed: take angular means. Assume the cone representation (269) is expressed in the physical (r,theta,z) chart, with `H_theta_z=B`, and the moving cylindrical centre `K=rho(b(theta) tensor b(theta)−I/3)` from source Proposition 9.22.

The source fixes exact constants
```text
beta=btheta*bz=(147 sqrt(182)−84 sqrt(2))/9832
    =0.189620065353516...,
kappa=15971/122900=0.129951179820992...,
mu=kappa/8=15971/983200=0.016243897477624... .
```
The seven-ray coefficient list (270) includes `delta c6=8B`, hence cone inequality (272) `C(H)<=kappa rho` requires pointwise `|H_theta_z|<=mu rho`.

Define angular means <v> = (1/2π)∫v dtheta and axial moment functions, where z_- is below all supports:
```text
R2(z) = ∫_0^infty r² <rho(r,theta,z)> dr,
m_g(z)=∫_0^infty r² <g_theta(r,theta,z)> dr,
M_g(z)=∫_{z_-}^z m_g(s) ds.
```

## Theorem: an exact cumulative cone-flux band

If the projected equation `P div H=P(g−div K)` is satisfied and the cylindrical pressure is single-valued and 2π periodic, then at **every height**
```text
|M_g(z) − beta*R2(z)| <= mu*R2(z).
```
Thus whenever R2>0, necessarily
```text
beta−mu <= M_g/R2 <= beta+mu,
0.173376167875892... <= M_g/R2 <= 0.205863962831140... .
```

**Proof.** The angular component of a symmetric tensor divergence in the full cylindrical chart is
```text
(div H)_theta = r^(-2) ∂r(r² H_rtheta)+ ∂z H_ztheta
                + r^(-1)∂theta H_thetatheta .
```
The angular derivative integrates to zero over 2π, and so does the angular component r^(-1)∂theta p of any periodic pressure gradient. Multiplying by r² and integrating radially removes the compact radial boundary term. The cone baseline has `K_theta_z=beta rho`, whose integrated radial-divergence contribution also cancels. Therefore
```text
d/dz J_H(z) = m_g(z) − beta R2'(z),
J_H(z)=∫r²<H_theta_z>dr = M_g(z)−beta R2(z)
```
because both sides vanish below support. The cone coefficient gives `|J_H|<=mu R2`. The estimate is **sharp at the level of this scalar angular sector**, since with A=C=D=0, the coefficient norm itself equals `8|B|`. Neither sufficiency for the remaining tensor equations nor compact support with the required pressure follows.

**Corollary (torque-neutral prepared sources are excluded in this sector).** For nontrivial nonnegative rho and m_g identically zero, M_g=0, so the inequality would force beta<=mu, contrary to the exact constants. In fact
```text
M_g/R2 >= beta−mu, so at least 1−mu/beta
=0.914334501217790... (91.43345%) of the baseline cumulative
angular flux must be compensated by the prepared source.
```
The strict comparison is exact: sqrt(182)>13 and sqrt(2)<3/2 imply beta>1785/9832>mu. This is a scoped obstruction under the full-chart, cone-orientation and compactness assumptions; it is **not** a claim that the actual complete prepared g is torque-neutral.

## An explicit normalized smooth envelope for screening

Freeze a time slice q=1−t>0, D=1/2−h, eta=z*q^(-D), R=r*q^(-1/2), and the source curved-shell coordinate `s=chi(eta)*Lambda_c*R²/2`. Let `beta_w` denote Appendix R's normalized C∞ flat radial bump, with centre s0=241/40 and halfwidth 1/100. Pick smooth nonnegative compact F supported inside the permitted eta interval with chi>chi_c. The **diagnostic**, not physically validated, stress envelope
```text
rho_ex(r,z)=q^(-3/2)*(chi(eta)*Lambda_c/R)*
             beta_(1/100)(s−s0)*F(eta)
```
satisfies the exact normalized moment identity `R2_ex(z)=F(eta)` by source change of variables. For this explicit profile, every candidate full source must obey
```text
(beta−mu) F(eta) <= M_g(z) <= (beta+mu)F(eta).
```
This selects a *radially normalized test envelope*, not a proof that the physical affine virial normalization or kinetic covariance is satisfied.

## Exact source-native viscous actuator gate, not just a pairing rank

Original equation (251) reads `m_T(z)=q^(−h)*L_delta[A](eta)`, with
```text
L_delta[A]=(BA)'−gamma MA−delta(MA)'',
B=D*eta*M+N, delta=nu*epsilon²>0.
```
If `m_g=m_bg+m_T`, with compact A vanishing below eta_-, then the complete source cumulative torque is exactly
```text
M_g(z)=M_bg(z)+q^(D−h)[B A−delta(M A)'−gamma∫_{eta_-}^eta M A dxi].
```
Substitute this complete expression into the pointwise cone band above. This supplies a new test for the actual controls, **in addition to** the two global adjoint conditions of Appendices P–R. The slice estimate (249) also requires the derivative of that mismatch to be scale-small. Exact first-order/second-order compatibility alone does not imply the cone band, particularly near the flat envelope boundary.

Equivalently, for every compact smooth axial test field phi,
```text
|∫ phi(z)[m_g(z)−beta R2'(z)]dz|
   <= mu∫|phi'(z)|R2(z)dz.
```
If R2 is flat at its axial boundary but M_g−beta R2 has a nonzero finite-order boundary Taylor coefficient there, the weighted pointwise estimate is impossible. These scalar tests do not solve the other three tensor components.

## Verification and outstanding proof

[Independent exact arithmetic and 70-digit flat-bump replay](../attack016/verify_flux_obstruction.py) checks both source constants, strict reserve comparison, cylindrical angular moment identity, explicit envelope substitution and the complete viscous primitive. [Lean finite algebra](../../../NewtonConjectures/Case006AngularFlux.lean) proves the rational cone margin, sharp scalar coefficient inequality, flux-band consequence and conditional torque-neutral obstruction. The actual angular integration and PDE have **not** been formalized in Lean; compiler/axiom CI is pending. The original source still has unfrozen chi, G, complete prepared source, global patch stress, pressure and the weighted compact inverse. The complete conditions (249), (272), (273) remain **unverified**; no global Navier–Stokes singularity is claimed.
