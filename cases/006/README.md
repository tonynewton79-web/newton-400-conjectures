# Case 006 — Carrier-independent structured stress from an unforced Navier–Stokes core

**Source:** Tony Newton, [Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core](https://doi.org/10.5281/zenodo.23475142), Zenodo record 23475142, 19 October 2026.

This is **Case 006**, deliberately isolated from other Navier–Stokes work and from Cases 001–004. It is a research/formal-verification case, **not a conjecture solved or a Millennium-problem claim**.

## What the machine-checkable certificate says

[Lean source](../../NewtonConjectures/Case006Stress.lean) proves finite exact statements from Proposition 9.22 and equations (262)–(272):

1. At aperture t=1/4, seven explicitly defined rank-one rational rays with weights (1,1,59/43,1,1,1,1) yield every entry of the 3×3 covariance Q0 in equation (263).
2. The trace is 679/86 and its normalized trace-free part is exactly u⊗u/1229 − I/3 for u=(35,2,0), the rational form of (265).
3. The axial-efficiency margin is exactly 4443/9832−9/20=93/49160 > 0.
4. The normalized seven-ray weights have a coefficient floor of at least 172/1229.
5. The coefficient budget is exactly 172/1229−1/100=15971/122900.
6. **Conditional theorem:** if all four-field coefficient perturbations satisfy the *assumed* H8 bound, the resulting coefficients remain at least rho/100.
7. Separate elementary balanced-slot, two-color partition and cutoff identities.

[Independent standard-library Fraction arithmetic audit](verify_exact.py) checks the finite certificates independently of Lean.

## Nonformalized / open mathematical gates

- Theorem 2.2's normally convergent exact local unforced singular-core construction.
- The PDE/function-space localization, transverse anti-divergence, full moving-frame and time-assembly estimates.
- Crucially, **H8**, the compact support and weighted anti-divergence estimate (273) with coefficient bound 15971/122900, for a *fully specified* profile family.
- The global finite-energy singular Navier–Stokes solution and logical relationship to the Clay problem.

**A successful Lean CI run is a real kernel check of the listed finite theorems only.** It is not a kernel check of the 65-page paper, nor a solution of the unforced Navier–Stokes problem.

## Reproducibility

As of 19 October 2026, the [actual Lean CI run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39260218045) compiled the Case 006 source and audited 341 declarations under NewtonConjectures with only propext, Classical.choice, and Quot.sound. The proof-placeholder scan passed. The [independent exact rational CI run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39260223557) also passed. The open compact weighted H8 gate is tracked in [Issue #25](https://github.com/tonynewton79-web/newton-400-conjectures/issues/25).\n\nThe repository pins Lean v4.24.0 and mathlib v4.24.0. The existing [Lean workflow](../../.github/workflows/lean.yml) builds the combined project, executes an axiom audit, and rejects proof placeholders. Case 006 is imported into the library entry point. Run `lake exe cache get && lake build` or inspect the associated GitHub Actions results.

The document’s Appendix F describes a wider companion algebraic kernel; this case begins with an independently written, narrower set of algebraic proofs and makes no claim to have imported or verified the original unpublished companion file.

## Attack 002 — augmented-symbol coercivity (kernel check pending)

[Attack 002 mathematical report](attack002/README.md) · [Lean source](../../NewtonConjectures/Case006H8Symbol.lean) · [independent exact-rational replay](attack002/verify_symbol.py).

The pressure-augmented four-field operator has an exact sum-of-squares factorization giving the **sharp** uniform Fourier symbol estimate `||M(xi)^T v||² >= |xi|²|v|²/5`. The Gram determinant also has an exact positive factorization. These facts remove a characteristic-direction obstruction to a noncompact Fourier inverse. They do **not** produce a compact, weighted H8 correction, prove its coefficient budget or resolve finite-energy Navier--Stokes breakdown. The new Lean source must pass CI and axiom audit before its theorem is called kernel-verified.

### Cumulative manuscript continuation

The living [Appendix G: exact H8 symbol, Fourier right inverse and dual necessary inequality](paper/Appendix_G_H8_Symbol_and_Dual.md) records every substantive proof from the present continuation. The original 65-page source remains available at [Zenodo 23475142](https://doi.org/10.5281/zenodo.23475142); the generated 69-page combined PDF and the editable typeset Appendix G source are sent separately as author research artifacts. GitHub stores the text-mathematical continuation, exact test scripts, and the individual Lean proof fragments.

The new [pressure-free symbol analysis](../../NewtonConjectures/Case006Ungauged.lean) proves the exact Gram determinant `(x²+z²)²(x²+y²+z²)`; the ungauged operator has characteristic directions on the nonzero y-axis. The pressure-augmented operator has the sharp uniform lower bound `||M(xi)^T v||² >= |xi|²|v|²/5`. A noncompact periodic Fourier right inverse follows, but **not** the compact weighted H8 estimate.

[Exact-rational validation of the pressure-free determinant and 5x3 Fourier pseudoinverse](attack004/verify_operator.py): 343 rational frequency tests, 342 invertible modes. Together with Attack 002's exact SOS and Attack 003's polar proof, this supplies a structural and numerical baseline. The latest Lean kernel status should be read from the associated GitHub Actions run. The H8 compact inversion with frozen source-native profiles remains open under [Issue #25](https://github.com/tonynewton79-web/newton-400-conjectures/issues/25).

### Appendix H — quadratic compact-support moment obstruction

The cumulative [Appendix H](paper/Appendix_H_Quadratic_Moments.md) establishes three explicit divergence-free quadratic adjoint-null vector polynomials for the restricted four-field tensor H(A,B,C,D). They yield three **additional necessary quadratic source moments** for any compactly supported four-field correction modulo compact pressure. The smooth source `s=(0, ∂_x² η, 0)` with a nonzero-integral compact bump η has every force and affine first moment zero but fails the first quadratic moment, so those lower-order conditions alone are not sufficient for arbitrary compact source inversion. This is **not** a counterexample to the source-native residual, whose quadratic moments remain unknown.

[Lean polynomial identities](../../NewtonConjectures/Case006QuadraticMoments.lean) and [symbolic independent test](attack005/verify_quadratic.py). Lean kernel build and axiom audit on the new branch remain separate release obligations; the full compact PDE argument is not Lean-formalized.

### Appendix I — complete smooth finite-type H8 adjoint kernel

[Appendix I, complete mathematical proof](paper/Appendix_I_Complete_Adjoint_Kernel.md) now classifies **every smooth local adjoint-null vector field** of the four-field operator with pressure. The kernel is exactly 10-dimensional: 3 translations, 3 infinitesimal rotations, one anisotropic dilation and the 3 quadratic fields of Appendix H. There are no higher-degree or nonpolynomial smooth local solutions. The proof uses the Saint-Venant compatibility equation `sym ∇q=f diag(1,-2,1)`; its six independent constraints force `Hess f=0`.

[Exact polynomial/rank audit](attack006/verify_finite_type.py) verifies all 10 generators, a 6×6 compatibility determinant −8, and degree-0–5 polynomial nullities 3,4,3,0,0,0 (30×30 degree-3 matrix of full rank). [Lean algebraic fragment](../../NewtonConjectures/Case006FiniteType.lean) addresses the six-variable elimination, but the full differentiable finite-type classification remains **not end-to-end Lean-formalized**.

The cumulative author-facing PDF now contains **75 pages** (original 65 + Appendices G 4, H 3, I 3); the original 72 cumulative pages have been preserved unchanged. This is a complete *adjoint-null moment classification*, not a compact H8 existence theorem or a Navier–Stokes resolution. The actual source-native residual and admissible moment Jacobian still require a fixed profile.

### Appendix J — exact source-native moment Jacobian and symmetry caveat

[Appendix J, source-led derivation and proofs](paper/Appendix_J_Source_Native_Moment_Jacobian.md) has been integrated into the cumulative **78-page** author PDF; all previous 75 pages were preserved. In a fixed cone frame, the seven-ray centre has the exact contraction `Rstar:diag(1,-2,1)=1217/1229`. For a compact solenoidal variation `V_j` of the explicitly specified unprojected Navier–Stokes source model and envelope variation `r_j`, the exact Jacobian is

```text
J_ij = d/dt ∫ V_j · q_i - 2∫ f_i (U_1 V_j1 - 2 U_2 V_j2 + U_3 V_j3)
       + (1217/1229)∫ f_i r_j,      (f_1,f_2,f_3)=(y,x,-2z).
```

The viscosity term cancels by compact solenoidal zero mean and constant Laplacians of the quadratic adjoint test fields. If the H8 source `g` contains additional source-native terms, the correct derivative is `∫(∂_α g)·q_i + (1217/1229) ∫ f_i (∂_α rho)`, and all additional terms must be computed from the actual shell construction.

**Conditional no-go:** For a fully *fixed-frame* equivariant source family under the half-turn `diag(-1,-1,1)`, the first two quadratic moments vanish, so the 3×3 Jacobian has rank at most one. Two independent half-turn-odd actuator directions and one even direction would be required for an invertible parity-block Jacobian in that symmetry model. The physical H8 frame is tilted and rotated between patches; no rank obstruction for the *actual* global axisymmetric shell source is claimed.

[Independent exact checker](attack007/verify_source_jacobian.py) verifies all polynomial/strain/parity first-variation identities and 4,096 exact rational polarizations. [New Lean candidate](../../NewtonConjectures/Case006SourceJacobian.lean) proves the coefficient and polynomial polarization only; its kernel build and the full PDE moment formula have not been certified end-to-end. The actual numerical source-native moment Jacobian and its determinant remain **open**, because the paper intentionally leaves shaper profiles `Phi_theta, Phi, Xi` unfrozen (Proposition 9.12). See H8 [Issue #25](https://github.com/tonynewton79-web/newton-400-conjectures/issues/25).


### Appendix K — sharp conditioning near half-turn symmetry

[Appendix K, complete sharp determinant and interval proofs](paper/Appendix_K_Jacobian_Conditioning.md) was added to the cumulative **80-page** PDF. The previous 78-page manuscript is preserved unchanged.

If the first two source-moment Jacobian rows are entrywise bounded by `eps` and the third by `M`, then `|det J|<=4 M eps^2`; the constant **4 is sharp** (proved by multilinearity and a 512-vertex sign-matrix argument). For an invertible Jacobian with first row bounded by `eps>0`, `||J^{-1}||_2>=1/(sqrt(3)eps)`. This quantifies near-symmetry conditioning, rather than assuming the actual tilted-frame source has a particular Jacobian.

If a future genuine source calculation encloses all entries within `delta` of a reference matrix `B` with `|B_ij|<=L`, then `|det J-det B|<=18L^2delta+18Ldelta^2+6delta^3`; a strict determinant margin certifies nonsingularity. The rational example B=[[3,1,0],[1,2,0],[0,0,1]], delta=1/100 is **illustrative only**, not an H8 calculation.

[New Lean algebraic source](../../NewtonConjectures/Case006JacobianConditioning.lean) proves exact two-scale determinant factorizations, the parity block identity, a nonzero implication, and a sharp sign witness; the **universal real inequality and PDE claims are not Lean-formalized**. The independent [exact audit](attack008/verify_conditioning.py) passed all 512 sign vertices and 8,192 seeded rational tests. New GitHub Lean kernel build is queued. The physical source-native Jacobian entries and H8 weighted compact inverse remain open.


### Appendix L — tilted-frame torque and exact two-moment reduction

[Appendix L: exact tilted SO(2) projection and source-moment theorem](paper/Appendix_L_Tilted_Torque_Reduction.md) is part of the cumulative **82-page** author manuscript (original 80 pages unchanged). In a common, fixed H8 cone frame rotated about the physical x-axis by c=cos(theta), t=sin(theta), the three rotated quadratic adjoint fields project onto exactly three divergence-free axisymmetric quadratic fields E=(xz,yz,-z²), F=(-yz,xz,0), G=(0,0,r²). The 3×3 transfer has determinant `-(9/2)c²t²(1-3t²)`, with nondegenerate meridional minor `(3/2)ct(1-3t²)` at generic tilt.

For a compact axisymmetric unprojected source `g`, `B=∫g·F=2π∫z m(z)dz` with `m(z)=∫r²g_theta(r,z)dr`; hence its q2 quadratic moment equals `-6πct∫z m(z)dz`. For `s=g-div(rho Rstar^R)` with axisymmetric rho and fixed tilted cone centre, put `A=∫g·E`, `C=∫g·G`, `Z=∫z rho`, `kappa=1217/1229`. Provided `ct(1-3t²)≠0`, **all three quadratic moments vanish if and only if** `B=C=0` and `(1-3t²)A=2 kappa Z`. If the *complete* source's slice torque is exactly neutral, `B=0` automatically and a **two-dimensional meridional Jacobian** is the appropriate restricted controllability question. This is stronger than a full 3×3 determinant test under precisely these assumptions.

**Boundary:** The actual H8 source is not known to be fully SO(2) axisymmetric in one chart; it uses tilted, transported cones and potentially only C4 patch symmetry. The selected torque-neutral *toroidal shaper* does not prove exact neutrality of the complete source. The source-native 2×2 Jacobian and compact weighted H8 inversion remain unproved.

[New Lean polynomial fragment](../../NewtonConjectures/Case006TiltTorque.lean) encodes the transfer determinant and baseline cancellation, and the [independent exact SO(2) angular projection checker](attack009/verify_tilt_torque.py) passes. The full rotational integral identities and H8 analytic step are not end-to-end Lean formalized; new GitHub Actions kernel CI is pending.


### Appendix M — C4 symmetry closes the quadratic moment-averaging gap

[Appendix M, complete 84-page manuscript continuation source](paper/Appendix_M_C4_Quadratic_Moment_Closure.md) supersedes Appendix L's continuous-symmetry requirement **for quadratic moments only**. For every vector polynomial of degree at most 2, the fourfold-equivariant axial average equals the continuous SO(2) equivariant average exactly. The 30-coefficient projector has rank **8**, equal to the dimension of the SO(2)-invariant space; a separate C3-invariant quadratic provides a sharp order-of-symmetry counterexample.

Consequently, the same tilted-frame transfer and reduced moment equations proved in Appendix L remain **exact** for a complete compact source `g` and envelope `rho` which are C4-equivariant about one physical axis in a fixed common stress frame. The q2 moment is still `-6 pi c t integral z m0(z)`, where `m0` is now the **angularly averaged** slice-torque density. At generic tilt, exact cancellation still reads `B=C=0`, `(1-3t²)A=2*(1217/1229)*Z`.

This does NOT establish complete-source C4 equivariance after patch gluing, moving-frame transport or Leray-pressure correction; nor does it prove exact slice-torque neutrality or the compact weighted H8 bound. An explicit perturbative error for finite-ball support is `3L²||g-P4g||_1 + 2*(1217/1229)*L||rho-P4rho||_1` for each quadratic moment.

The cumulative author-facing PDF is now **84 pages**, all previous 82 pages verified text-identical. [New Lean finite polynomial proof candidate](../../NewtonConjectures/Case006C4Quadratic.lean) and [independent 30-dimensional exact projector test](attack010/verify_c4.py) are included in GitHub Actions; kernel compilation and axiom audit must finish successfully before this Lean fragment is called formally verified.


### Appendix N — transport of the complete C4 source and its tensor baseline

The 86-page cumulative manuscript (all preceding 84 pages text-identical) now includes [Appendix N](paper/Appendix_N_C4_Frame_Transport.md). It proves an exact sufficient covariance mechanism: rotate **vectors, scalar envelopes and symmetric stresses together** as four full cyclic orbit copies, with every cutoff derivative and nonlinear overlap contribution retained. Their full unprojected source s=g−div K is exactly C4-equivariant. A fixed globally Cartesian tilted rank-one cone centre does not share that covariance: for Rstar=bb^T−I/3, ||S Rstar S^T−Rstar||_F²=2(1−b_z^4), and a C4-invariant compact envelope can yield a nonzero Leray-visible curl defect.

**Corrected transported-baseline source moments.** For invariant E=(xz,yz,−z²), F=(−yz,xz,0), G=(0,0,x²+y²), define A_s=∫s·E, B_s=∫s·F, C_s=∫s·G. Under genuine covariance the Appendix L transfer applies to **(A_s,B_s,C_s)**. A fixed-centre scalar baseline term from Appendix M must not be substituted for a transported centre. For four copies of seed rho0(bb^T−I/3) with b=(a,0,c), the stress adds A_K=4∫rho0[z(a²−2c²)+acx], B_K=−4ac∫y rho0, C_K=8ac∫x rho0. **C4 alone does not imply B_K=0**; the complete torque condition is B_s=B_g+B_K=0.

The tensor-aware defect test is |∫(s−P4s)·q_i^R|≤3L²||g−P4g||_1+6L||K−P4K||_{L¹(F)} for support in the radius-L ball. [Independent exact verifier](attack011/verify_frame_transport.py) passed symbolic transport, curl and seed moment identities; [new Lean algebraic fragment](../../NewtonConjectures/Case006FrameTransport.lean) is included in CI. Real source profile transport, pressure compactness, patch overlap cone margin and H8 weighted inversion remain unresolved; the new Lean compiler/axiom audit must pass before any kernel-certification claim.


### Appendix O — the actual moving cylindrical cone and torque balance

The cumulative manuscript is now **88 pages**, with the previous 86 pages unchanged and a two-page [Appendix O](paper/Appendix_O_Cylindrical_Frame_and_Torque.md). The original paper's equations (258)–(265) place the seven-ray centre in a *moving cylindrical (r,theta,z) frame*. That centre is **already continuously rotationally covariant** on an axisymmetric shell: the Appendix N obstruction applies to a fixed Cartesian centre, not to this actual cylindrical representation.

The exact source-native centre has `b_r*b_z = -4443/9832` and `b_theta*b_z = (147*sqrt(182)-84*sqrt(2))/9832 > 0`. For compact axisymmetric rho, define `R2(z)=int_0^infty r² rho(r,z)dr`. The full connection-aware divergence is
```text
(div K)_theta = b_r b_theta (rho_r+2rho/r) + b_theta b_z rho_z
m_{g-divK}(z) = m_g(z) - b_theta b_z R2'(z).
```
Thus if the *complete* source is to be exactly slice-torque-neutral, its prepared torque must be **active**: `m_g(z)=b_theta*b_z*R2'(z)`. A torque-neutral shaper alone does not achieve this for a nontrivial compact nonnegative rho; the scale-smallness gate (249) is separately testable. The exact baseline meridional moments are `A_K=∫rho[z(1-3bz²)+r br bz]`, `B_K=b_theta*b_z∫r rho`, `C_K=2br*bz∫r rho` and must be included in complete-source moments.

Original shapers (193)–(194) yield generic compact toroidal and poloidal fields which are solenoidal and SO2/C4 covariant on the stated axisymmetric shell. Their complete quadratic cross interactions are also covariant and need not vanish. This **settles local shaper-class and local cone-centre covariance**, not the final global patched H8 source, compact pressure or weighted anti-divergence.

[Exact symbolic verifier](attack012/verify_cylindrical_frame.py) and [Lean algebraic source](../../NewtonConjectures/Case006CylindricalTorque.lean) are committed, with a new GitHub Actions test. The local exact replay passed, while the new Lean compiler/axiom result remains pending.


### Appendix P — exact second-order viscous torque actuator and dual compatibility

[Appendix P](paper/Appendix_P_Exact_Viscous_Actuator.md) is now incorporated into the **90-page** cumulative paper (previous 88 pages text-identical). It returns to the **exact source Eq. (251)**, rather than the reduced first-order Eq. (253): for B=D eta M+N, gamma=3/2-2h>0 and delta=nu eps²>0, L_delta[A]=(BA)'−gamma M A−delta(MA)''.

**Exact compact range theorem:** on an interior interval where M remains nonzero and smooth, compact solvability of the second-order equation L_delta[A]=f requires **two** independent adjoint pairings ∫phi_j f=0, where delta M phi''+B phi'+gamma M phi=0. These two conditions are also sufficient for compact smooth A under the stated regularity hypotheses. They are distinct from the **single** compatibility of the delta=0 approximation (254). The exact Green identity and the IVP terminal pairing prove the result; the paper does not assume the viscous term is negligible for exact compactness.

**Source-native sign obstruction:** if gamma>0, M>0 and the required target is only a compact envelope derivative f=kappa R'(eta), the identity ∫f=−gamma∫MA rules out every nonzero one-sign compact actuator A. This is conditional: the physical full source includes other, unfrozen m_base contributions, and a sign-changing A may work.

**Exact illustrative proxy (NOT a frozen physical H8 profile):** h=1/12, gamma=4/3, M=1, B=101/75, delta=1/75 gives independent adjoint modes exp(-eta), exp(-100eta). A nontrivial positive compact envelope derivative has positive pairing against both. A compact test A generates a forcing that satisfies both conditions, establishing sharpness of the source range mechanism. The available unrestricted two-bump source rank is not a source-native admissibility certificate.

[Independent exact checker](attack013/verify_exact_torque_viscosity.py) passes operator/adjoint algebra, both characteristic modes, positivity of the derivative-only obstruction, and the compact test amplitude moments. [Lean algebraic fragment](../../NewtonConjectures/Case006ExactViscousActuator.lean) proves finite jet and polynomial identities only, imported into the root; kernel CI pending. The full ODE/functional-analytic argument has not been end-to-end formalized in Lean.

**Next H8 target:** freeze true M,N, rho and the complete background torque, compute both exact viscous adjoint modes, find two *admissible source-native* pairing columns, then check Eq. (249), cone positivity (272), compact pressure, graph support, and weighted inverse (273).


### Appendix Q — source-native two-control exact-viscous Fredholm repair

[Appendix Q: full two-page mathematical proof](paper/Appendix_Q_Mixed_Profile_Adjoint_Controls.md) is in the cumulative **92-page** author paper, preserving every previous 90 page's extracted text. It returns directly to original source radial moments `M_j=∫R²τ_j dR`, `N_j=∫R²Gτ_j dR` from Eq. (250) and the full viscous operator (251), exploiting original Proposition 9.20's **strict radial shear**.

For two nonnegative supported shapers `τ0,τ1` with separated radial supports, the source's `G_R<=-σ<0` gives `g0-g1 >= σ ΔR>0`, where `gj=Nj/Mj`. Let `φ1,φ2` solve the exact reference adjoint `δ φ''+(Dη+g0)φ'+γφ=0`. The precise cross-profile pairing is
```text
∫ φ_i L_1[A] = −∫ A M_1(g_1−g_0) φ_i'
```
for any compact axial amplitude. All same-reference-profile source changes `L_0[A]` have **zero** reference adjoint moments, but a different radial (G)-average produces nonzero responses. Because `W(φ1',φ2')=(γ/δ)W(φ1,φ2)≠0`, **one alternative radial shaper with two closely separated compact axial bump amplitudes yields an invertible 2×2 reference-adjoint moment matrix.**

Under the stated smoothness, compact-support and reference `M0>0` hypotheses, every compact normalized torque target f supported in the interval has the exact *local source-form* representation `L0 A0 + α1 L1 A1 + α2 L1 A2=f`, with compact amplitudes. The correction coefficients α are fixed by the nonsingular 2×2 pairing matrix; a useful rigorous bump-width determinant-error estimate is also derived.

This is an **analytic existence result conditional on the actual source's strict-shear region**, NOT a frozen numerical physical profile or a complete H8 theorem. The actual normalization of τ and envelope, coefficient size, possible loss of the slice gate (249), seven-ray floor (272), kinetic covariance, compact pressure, patch coupling and full weighted inverse (273) remain unproved.

[Exact symbolic/high-precision verifier](attack014/verify_mixed_profile_controls.py) checks the mixed-profile identity, derivative Wronskian, exact separated-radial illustrative averages, and smooth two-column diagnostic. [Lean algebraic fragment](../../NewtonConjectures/Case006MixedProfileControls.lean) includes the pointwise adjoint reduction, Wronskian algebra and Cramer's numerators. Both source and verifier are imported into GitHub CI; new compiler PASS and axiom audit remain pending.


### Appendix R — explicit normalized curved-shell shapers and conditional quantitative inverse

The cumulative main manuscript is now **94 pages**, with the original first 92 pages preserved text-identically and the two-page [Appendix R](paper/Appendix_R_Normalized_Radial_Inverse.md) appended.

**Source-specific quantitative correction to Appendix Q:** The admissible strong-Rayleigh radial region is **s=chi(eta)Lambda_c R²/2 in [6,6.1]** (source Eqs. 199, 202, 257); its physical R width decreases like Lambda_c^{-1/2}. Choose smooth nonnegative normalized source shapers `tau_j=(chi Lambda_c/R) beta_{0.01}(s-s_j)` with exact `s0=241/40=6.025`, `s1=243/40=6.075`, where beta is the standard unit-mass smooth flat bump. On the interior source axial patch with cutoff 1, `M_j=∫R²tau_j=1` exactly. Their supports are [1203/200,1207/200] and [1213/200,1217/200] in s, entirely inside [6,6.1]. Strict shear `-G_R >= gstar Lambda_c^{-1/2}` therefore gives `g0-g1 >= kappa_Lambda = gstar * sqrt(2)*(sqrt(1213/200)-sqrt(1207/200))/Lambda_c`, with the exact dimensionless coefficient ≈0.00862440024556. The **guaranteed average shear gap is order Lambda_c^{-1}, not Lambda_c^{-1/2}**. Because `M_j=1` on a shrinking radial shell, the shaper peak has a necessary lower bound of order Lambda_c^{3/2}.

**Quantitative conditional exact two-control bound:** Choose the reference adjoint fundamental solutions with initial data (1,0),(0,1) and two normalized axial bump controls centred at eta0 and eta0+t, width w_a. If `|b|<=B`, `kappa_Lambda<=k<=K`, `|k'|<=T`, `delta=nu eps²>0`, `gamma>0`, `L=max(1+B/delta,gamma/delta)`, `E=exp(L(t+w_a))`, `P=sqrt(2)KE`, `H=sqrt(2)E(T+KL)`, and
```text
L exp(Lt) (B*t/2 + gamma*t²/6) <= gamma/2,
2w_a*H*P + (w_a*H)² <= kappa_Lambda²*gamma*t/(4delta),
```
then the source-defined exact viscous matrix obeys
```text
|det C| >= kappa_Lambda²*gamma*t/(4delta),
||C^-1||_infty <= 8delta*K*E/(kappa_Lambda²*gamma*t).
```
A bound on the actual correction alpha follows upon bounding the true source forcing's two adjoint pairings. The proof is an explicit ODE Gronwall + point-column determinant + finite bump-width perturbation argument. The illustrative positive parameter-box replay satisfies both tests, but its B,K,T are NOT values calculated from the physical original G,chi.

The **actual gate remains open**: source-specific numerical B,K,T and physical f, derivative amplification from narrow bumps, the total dimensional torque criterion (249), the weighted local seven-ray correction norm (272), and full compact weighted inversion (273). A nominal factor Lambda_c²/gstar² appears in the sufficient inverse formula before optimizing K; it is a bound, not a proven physical blowup in control cost. [Exact verifier](attack015/verify_normalized_inverse.py) and [Lean algebraic source](../../NewtonConjectures/Case006NormalizedInverse.lean) are in GitHub CI; the new Lean build has not yet been confirmed kernel-passing, and the ODE/integral proof is not formalized in Lean.


### Appendix S — exact angular-mean torque-flux obstruction and 96-page cumulative paper

[Appendix S](paper/Appendix_S_Angular_Flux_Cone_Obstruction.md) is a new two-page addition to the **96-page** manuscript; the original 94 page texts were verified unchanged. It establishes a source-led **necessary**, not sufficient, consequence of the exact H8 coefficient inequality (272).

From the cylindrical cone centre of (265), `beta=b_theta*b_z=(147sqrt182-84sqrt2)/9832 = 0.189620065353516...`. The seven-ray budget is `kappa=15971/122900`, and because (270) includes `delta c6=8B` with physical `H_theta_z=B`, the cone forces `|H_theta_z|<=mu rho`, where `mu=kappa/8=15971/983200=0.016243897477624...`.

For a full cylindrical chart with compact stress and source, complete angular periodicity, and a single-valued periodic pressure, angularly average `R2(z)=∫r²<rho>dr`, `m_g(z)=∫r²<g_theta>dr`, and `M_g(z)=∫_{z_-}^z m_g`. The cylindrical angular divergence equation and compact radial support give the **exact weighted necessary condition**
```text
|M_g(z)−beta R2(z)| <= mu R2(z) for every z.
For R2(z)>0: 0.173376167875892 <= M_g(z)/R2(z)
                                <= 0.205863962831140.
```
Thus a nontrivial nonnegative rho and a completely torque-neutral prepared g cannot coexist with (272) under these stated hypotheses. At least `1−mu/beta=91.43345012%` of the baseline's **cumulative angular flux** must be matched by the prepared source. This scalar angular-sector constant is sharp among the seven coefficient bounds, but does NOT prove existence of the remaining tensor stress or weighted compact H8 inverse.

An explicit smooth compact **diagnostic** envelope `rho_ex=q^-3/2*(chi Lambda_c/R)*beta_0.01(s-241/40)*F(eta)` has `R2_ex=F(eta)` exactly, but the actual original virial constraints and full physical profile are not frozen. The exact viscous source actuator (251) gives the prepared torque primitive
```text
M_g(z)=M_bg(z)+q^(D−h)[BA−delta(MA)'−gamma∫_{eta_-}^eta MA],
```
which must lie within the above pointwise beta±mu band simultaneously with the separate derivative slice estimate (249). A smooth compact axial dual test version is also proved in Appendix S.

[Exact independent verifier](attack016/verify_flux_obstruction.py) passes source constants, cylindrical torque identity, flat-envelope normalization, axial-viscous primitive and strict reserve at 75 digits. [Lean finite algebra](../../NewtonConjectures/Case006AngularFlux.lean) is in the build root/CI; it proves only rational reserve and scalar band implications, not the cylindrical PDE integration. **Full (249), (272), (273) still OPEN.** GitHub Lean kernel status must be checked before calling this new file formally verified.


### Appendix T — a radial cone dual obstruction even with perfectly matched cumulative torque

The cumulative author paper is **98 pages**, including [Appendix T](paper/Appendix_T_Radial_Angular_Dual.md), with all previous 96 page texts verified identical. The actual complete prepared source g and normalized rho are **not frozen** by the original source paper (Remark 9.23), hence **M_g/R2 has not been evaluated for the physical H8 candidate**; reporting a physical interval pass would invent input.

**New exact necessary two-dimensional angular dual:** Eq. (270) has coefficient changes ±2C−4D and ±8B, so any H8 correction obeys |H_rtheta|≤κρ/2 and |H_thetaz|≤κρ/8 with κ=15971/122900. The cylindrical angular divergence and periodic-pressure cancellation then imply for every smooth compact radial–axial test ψ
```text
|∬ ψ r²<g−divK>_theta dr dz|
 <= ∬ r²<rho>[(κ/2)|∂rψ|+(κ/8)|∂zψ|]dr dz.
```
Appendix S captures only a subset (axial-only) of this virtual-work family.

**Sharp insufficiency counterexample to cumulative flux alone:** For any nonzero smooth nonnegative compact axisymmetric annular rho, define the manufactured divergence-free azimuthal source `g_theta=(divK)_theta+alpha*(rho_r+2rho/r)`. Then `m_g=β R2'` and `M_g/R2=β` **identically**, with β=(147sqrt182−84sqrt2)/9832 the exact midpoint of Appendix S's band, for every alpha. Nevertheless the radial dual inequality forces `|alpha|≤κ/2=15971/245800`. This is sharp for the angular equation: with A=B=D=0 and C=alpha*rho, the complete seven-ray coefficient norm is `C(H)=2|alpha|rho`. Thus alpha=κ fails by factor two even though the ratio passes exactly; alpha=κ/4 has a valid compact angular correction using half the reserve. **The source is manufactured, not the actual Navier–Stokes prepared source**, and the meridional projected tensor equations remain open.

[Exact SymPy/rational replay](attack017/verify_angular_dual.py) passes the source divergence, ratio, coefficient cost and PASS/SHARP/FAIL diagnostics; [Lean algebraic fragment](../../NewtonConjectures/Case006RadialAngularDual.lean) is imported and CI triggered, but no end-to-end PDE integration or H8 Lean theorem is claimed. The full global compact weighted inverse (273), slice (249), cone (272) for actual g, and Navier–Stokes singularity remain unproved.

**Next physical requirement:** Freeze a legitimate complete prepared g and rho, compute both the cumulative flux and spatial source residual; enclose the two-dimensional virtual-work functional (or solve for actual radial and axial angular stress) before pursuing meridional component inversion. Without final source functions, only the mathematical diagnostic and conditional tests can be verified.


### Appendix U — complete dual characterization of weak angular H8 corrections (100-page paper)

[Appendix U: exact iff weak angular cone solvability](paper/Appendix_U_Weighted_Angular_Duality.md) extends the cumulative main paper to **100 pages**, preserving the previous 98 pages text-identically. The original source STILL does not freeze a final source-native complete g and envelope rho; no numerical pass of the physical Mg/R2 or radial–axial virtual-work tests is therefore supported.

**New exact bounded-weak angular equivalence:** On a compact full cylindrical annular chart, for smooth axisymmetric angular residual `f=r²(g−divK)_theta` and nonnegative `w=r²rho`, write `kappa=15971/122900, a=kappa/2,b=kappa/8`. The condition `|∬ f psi|≤∬w(a|psi_r|+b|psi_z|)` for ALL compact smooth psi is NECESSARY and SUFFICIENT for existence of bounded measurable compactly supported angular stress `(C,B)=(H_rtheta,H_thetaz)` solving `∂r(r²C)+∂z(r²B)=f` distributionally with `|C|≤a rho,|B|≤b rho`. Choosing `A=D=0` realizes the *joint exact seven-ray coefficient cost* `mathcal C(H)=max(2|C|,8|B|)≤kappa rho`, so there is no further hidden restriction in this weak angular-only setting. The converse uses STANDARD Hahn–Banach and L1–L∞ duality (not asserted to be generally novel). For nonaxisymmetric sources, only the angular MEAN is covered.

**Extra strict boundary:** When a manufactured source `f=alpha ∂r(r²rho)` saturates the bound at `alpha=kappa/2`, every cone-admissible angular correction has `C=(kappa/2)rho` a.e. on `{rho>0}`. The original inequalities `|2C−4D|,|-2C−4D|≤kappa rho` then force **D=0** there, removing a meridional degree of freedom.

**Rational finite cut diagnostic:** A four-node 2×2 grid with radial capacity a, axial b, source +kappa/−kappa at radially adjacent vertices passes ALL axial slice sums but fails the positive-node cut by an EXACT `3kappa/8`. Reducing the source to `kappa/4` gives an explicit feasible radial-edge flow. This is a discrete analogy, NOT a convergent discretization of the original PDE.

[Independent exact 2×2 subset/capacity verifier](attack018/verify_angular_weak_duality.py) PASS, including 15 finite cuts, exact sharp radial sector values, and mixed B/C coefficient norm. [Lean finite rational and saturation algebra](../../NewtonConjectures/Case006AngularWeakDuality.lean) has been committed and imported in the project root/CI; do not claim kernel PASS until workflow completion. The infinite-dimensional theorem, weak-to-smooth upgrade, actual prepared source, compact pressure, three meridional tensor components, slice (249), physical cone (272), weighted H8 inversion (273) and unforced NS singularity remain UNPROVED.

**Next decisive mathematical step:** either freeze an admissible complete g,rho and rigorously certify the ALL-test dual bound (not merely selected axial/radial tests), or prove a quantitative smooth weighted lifting theorem with margin through the flat envelope boundary. Only then is a full four-field H8 inverse plausible.


### Appendix V — a quantitative interior smooth lift, and why the flat boundary still blocks closure

The cumulative author paper is **102 pages**, with two-page [Appendix V](paper/Appendix_V_Interior_Smooth_Weighted_Lifting.md) added. The previous **100 pages were checked text-identical**, all LaTeX cross-references resolve, and the research release ZIP contains the updated paper, editable LaTeX, checker, finite Lean algebra, exact replay, SHA256 checksums and preceding cumulative 100-page research ZIP.

**Constructive compact divergence correction:** For smooth compact zero-mean h on an interior rectangle U, define H(z)=∫h(r,z)dr, choose a nonnegative smooth radial bump θ of mass one, and put Qr=∫_{r-}^r(h−θH), Qz=θ(r)∫_{z-}^zH. Then Q is *smooth compact* and divQ=h exactly, with ||Qr||∞≤2Lr||h||∞ and ||Qz||∞≤LrLz||θ||∞||h||∞.

**Quantitative interior lifting theorem:** Write w=r²ρ, a=κ/2,b=κ/8 and κ=15971/122900. Suppose the weak bounded angular flux V has support in a **compact K strictly inside a rectangle U with w≥w*>0**, has divV=f with smooth f, and satisfies strict pointwise slack |Vr|≤(1−σ)aw, |Vz|≤(1−σ)bw, 0<σ<1. Set F=||∇f||∞,W=||∇w||∞, J=||θ||∞. For a mollifier of radius ε with K+B2ε⊂U, if
```text
(1−σ)εW ≤ σw*/4,
2Lr εF ≤ σ a w*/4,
Lr Lz J εF ≤ σ b w*/4,
```
then mollify V and repair the exact divergence using the explicit compact Q on h=f−fε. The resulting **smooth compact angular stress** has the same source divergence and retains an explicit strict joint seven-ray reserve: max(2|C|,8|B|)≤(1−σ/2)κρ. This is a genuine theorem *inside* the positive-envelope region, but the initial support and strict reserve **do not follow** from Appendix U's Hahn–Banach weak existence theorem.

**Sharp warning near a flat envelope:** If ρ(x)=exp(−1/x²) for x>0 and 0 for x≤0, then for any fixed positive-radius standard mollifier, (ηε*ρ)(0)>0 while ρ(x)→0 as x↓0. Hence the relative convolution ratio diverges, and ordinary fixed-scale smoothing can destroy even a strong cone reserve. This refutes that *regularization method*, not every possible smooth weighted lifting.

[Independent exact verifier](attack019/verify_interior_lifting.py) PASS for a nontrivial symbolic polynomial compact-corrector example, rational reserve checks (illustrative only), and high-precision positive-convolution lower bounds. [Lean finite algebra](../../NewtonConjectures/Case006InteriorSmoothLifting.lean) submitted to the combined build; GitHub Actions kernel status still pending and no integral/PDE theorem is formalized end-to-end. The source-native g,ρ are not frozen. The global flat-boundary extension, meridional tensors, weighted inverse (273), slice (249) and complete cone (272) remain OPEN.


### Appendix W — exact flat-boundary angular lifting for a restricted source class

The main cumulative Case 006 manuscript is **104 pages** and its first 102 pages remain text-identical. [Appendix W](paper/Appendix_W_Flat_Boundary_Weighted_Lifting.md) uses an explicit separable smooth flat envelope `w=r²rho=p(r)q(z)`, with p log-concave, and proves that any radially slice-balanced source `f=wF`, `|F|≤L`, `∫f(r,z)dr=0` at each z, admits an **exact smooth globally compact angular flux** `Vr(r,z)=∫_{r-}^r f(s,z)ds, Vz=0`. Its pointwise coefficient cost is `max(2|H_rtheta|,8|H_thetaz|)≤L Lr rho`. Thus `L Lr≤(1−sigma)*15971/122900` retains strict reserve **up to the flat support boundary**, without needing an interior positive minimum of rho. A derivative-source example `f=alpha ∂r w` has an unbounded ratio `f/w` but an explicit smooth cone-compatible solution `Vr=alpha w`, showing the bounded-source assumption is sufficient, not necessary.

A cubic-distance variable-radius mollifier `epsilon_c=c[x(1−x)y(1−y)]³` preserves a positive **relative** angular cone reserve of general bounded weak fluxes even at this model flat boundary, by the explicit weight distortion `w(X−epsilon_c u)/w(X)≤exp(16c)`. But variable-step convolution **does not commute with divergence**; Appendix W computes the exact defect `E_c[V]=(∇epsilon_c/epsilon_c)·∫V(X−epsilon_c u)[2eta+u·∇eta]du`, whose elementary relative bound is O(1/d) near the flat edge. Constructing a cone-bounded compact weighted antidivergence for this commutator remains open. Prior variable-step mollification (Hintermüller–Papafitsoros–Rautenberg, 2020) and weighted divergence inverses (Huber, 2011) are cited as established related literature.

[Independent exact verifier](attack020/verify_flat_boundary.py) PASS for flat log-concavity, both source and cone examples, adaptive distortion, commutator and flat extension. [Lean finite algebra](../../NewtonConjectures/Case006FlatBoundaryAdaptive.lean) is committed/imported, but **does not formalize the analytic lifting theorem**; kernel CI confirmation pending. This exact restricted angular subclass is **not** the unfrozen complete physical H8 source, nor the general weak-to-smooth H8 theorem. Full meridional stresses, pressure, slice (249), cone (272) for physical g, compact inverse (273) and unforced Navier–Stokes singularity are still open.


### Appendix X — exact divergence-preserving smooth lifting at the model flat boundary (106 pages)

The cumulative Case 006 paper is **106 pages**, with two-page [Appendix X](paper/Appendix_X_Divergence_Preserving_Piola_Lift.md) added and its preceding 104 pages verified text-identical.

**New exact Piola–homotopy operator:** For a bounded weak angular flux `div V=f`, a spatial step `eps>0`, and `F_{t,u}(X)=X+t eps(X)u`, set `J_{t,u}=1+t u·grad eps`, `P_u=J_{1,u}(DF_{1,u})^-1=(1+u·grad eps)I-u⊗grad eps`. The new smoother `S_eps V=∫eta(u)P_u V(F_{1,u})du - ∫eta(u)∫_0^1 eps u f(F_{t,u})dtdu` satisfies **div(S_eps V)=f EXACTLY**, without a separate commutator inversion. This follows from the classical Piola identity and the exact source-homotopy formula `d_t[J_{t,u}f(F_{t,u})]=div_X[eps u f(F_{t,u})]`. Both are symbolically checked using nonconstant polynomial Jacobians and fluxes.

**Quantitative strict flat boundary theorem:** For the Appendix W flat product weight `w=p(x)p(y)`, `p(x)=exp(-x^-2-(1-x)^-2)` on 0<x<1, let `d=min{x,1-x,y,1-y}`, `phi=x(1-x)y(1-y)`, `eps_c=c phi^(m+3)`. Suppose smooth compact f has bounded relative polynomial growth `|f|≤Fstar*w*d^-m`, some finite integer m≥0; and the complete angular dual inequality holds with **strict relative cone reserve sigma>0**. For `c≤1/8`, if
```text
exp(16c)*[(1-sigma)(1+5(m+3)c)
 + Fstar*c/(8b(1-c/4)^m)] ≤ 1-sigma/2,
a=kappa/2, b=kappa/8, kappa=15971/122900,
```
then there is **globally smooth compact angular flux** with the **exact original divergence f** and joint cone cost ≤(1−sigma/2)kappa rho. Existence follows by taking c sufficiently small. This resolves the adaptive commutator problem for the explicitly defined polynomial-relative-source class, not for arbitrary smooth sources without that growth bound.

**Exact tests:** [SymPy/Fraction checker](attack021/verify_piola_flat_lifting.py) passes both Piola and homotopy polynomial identities and a purely rational positive-cone certificate `12469/16128<7/8` at sigma=1/4, c=1/1024, m=0, Fstar=kappa/16, plus checks for m=1..4. [Lean finite algebra](../../NewtonConjectures/Case006PiolaFlatLifting.lean) committed/imported/CI-triggered, but distributional Piola calculus, flat smoothing and H8 remain outside Lean; pending kernel result cannot be called a PASS.

**Unchanged physical gate:** The actual complete NS prepared source and envelope are still unfrozen; strict all-test dual feasibility and finite Fstar,m for that source have not been certified. The three meridional tensor equations, compact pressure, slice (249), complete physical cone (272), weighted inverse (273) and unforced NS singularity remain open.


### Appendix Y — exact coupling of the smooth angular and weak meridional H8 cone (108 pages)

The 108-page cumulative author PDF adds the two-page [Appendix Y](paper/Appendix_Y_Coupled_Meridional_Dual.md), preserving all earlier 106 pages text-identically. Its mathematical result uses the exact original seven-ray norm and is scoped to the axisymmetric physical cylindrical H8 chart.

**Exact residual cone after fixing angular B=H_theta,z and C=H_r,theta.** Let k=(15971/122900)rho and E=A−4B. The remaining fields (E,D) must satisfy |E|+2|D|≤k/2, |D|≤(k−2|C|)/4. The exact sharp support function for meridional gradients (P,S) is
```text
h_C(P,S)=max{k|P|/2, |C||P|+(k−2|C|)|S|/4}.
```
With angular reserve 2|C|≤(1−tau)k and 8|B|≤k, the guaranteed **independent meridional box** |E|≤k/4, |D|≤tau*k/8 stays inside the original full seven-ray cone. For the Appendix X angular margin tau=sigma/2, this means |A−4B|≤k/4 and |D|≤sigma*k/16. This is available margin, not a right inverse.

**Exact conditional weak meridional iff modulo pressure:** For any axisymmetric source f_m on an annular rectangle and every compact smooth meridional test psi satisfying (r psi_r)_r+(r psi_z)_z=0, define Ppsi=(psi_r)_z+(psi_z)_r and Spsi=(psi_z)_z−(psi_r)_r. A bounded measurable compact (E,D) in the above cone and a distributional pressure satisfy the meridional divergence equations **if and only if**
```text
|∫ r [f_m·psi+4 B Ppsi] dr dz| ≤ ∫ r h_C(Ppsi,Spsi) dr dz
```
for ALL such psi. Necessity is the cylindrical weighted integration by parts; sufficiency is standard Hahn–Banach convex polar duality followed by the distributional de Rham lemma. This resolves a **conditional axisymmetric weak** problem only; it does not solve smooth compact meridional lifting, pressure support or nonzero angular Fourier modes.

The [exact SymPy/Fraction replay](attack022/verify_coupled_meridional.py) passes all three cylindrical divergence components, the exact sharp polytope polar on hundreds of rational samples, a uniform strict-margin box, and a manufactured **three-component** source with full cone cost 3k/8. The manufactured source is not the original Navier–Stokes prepared source. [Finite Lean algebra](../../NewtonConjectures/Case006MeridionalCoupling.lean) is committed and imported in the CI build; the functional-analytic theorem is **not** Lean formalized and kernel CI completion remains pending.

The genuine complete g,rho, nonaxisymmetric modes, smooth flat-boundary E,D lifting, compact pressure, slice (249), physical cone (272), weighted H8 inverse (273) and any unforced Navier–Stokes singularity remain OPEN.


### Appendix Z — smooth flat-boundary meridional lift for doubly balanced curl sources (110-page paper)

The cumulative author manuscript is **110 pages**: the two-page [Appendix Z](paper/Appendix_Z_Flat_Meridional_Double_Primitive.md) is appended to the previous **108 pages, whose extracted text is SHA256-identical**.

**Exact meridional pressure-curl reduction:** For the original axisymmetric cylindrical four-field H(A,B,C,D) with E=A−4B, the two meridional equations modulo pressure are equivalent on a simply connected annular rectangle to
```text
L_E(E)+L_D(D) = g,
L_E(E)=E_rr−E_zz+E_r/r−E/r²,
L_D(D)=2D_rz+D_z/r,
g=∂r f_z−∂z f_r−4L_E(B).
```
The half-density conjugation E=r^(−1/2)e,D=r^(−1/2)d yields a scalar underdetermined elliptic row with principal symbol norm |ξ|²; its existence does not imply a compact inverse.

**New constructive global-flat-boundary theorem for a restricted class.** Let w=r²rho=p0(r)q0(z), where p0,q0 are smooth symmetric unimodal positive interior factors, infinitely flat at the edges. If the prescribed *pressure-free meridional curl* equals g=r^(−1/2)w F, |F|≤L, and BOTH weighted slice balances ∫p0(r)F(r,z)dr=0 (all z) and ∫q0(z)F(r,z)dz=0 (all r) hold, then
```text
E=0, A=4B,
D(r,z)=(1/(2√r))∫_(r−)^r∫_(z−)^z√s*g(s,t)dt ds
```
is **smooth compact and solves the pressure-free meridional equation exactly**. The missing pressure is an actual **smooth compact** potential, not just distributional. Two successive unimodal weighted-primitive estimates give
```text
|D|≤ L Lr Lz*r+^(3/2)*rho/8.
```
If the angular B,C have reserve 8|B|,2|C|≤(1−tau)κrho with κ=15971/122900 and the class bound L Lr Lz r+^(3/2)≤tau κ holds, then the **full original cone** remains below (1−tau/2)κrho through the completely flat boundary. This is a genuine restricted meridional smooth lifting result, *not* a general H8 inverse.

**Fully explicit model:** On r∈(1,2), z∈(0,1) with symmetric flat p0(r)=p(r−1),q0(z)=p(z), the nonzero F=λ(r−3/2)(z−1/2) obeys both weighted balances. For the resulting D and B=C=0, f_m=(−2D_r−D/r,0) with **compact pressure −D** satisfies the original meridional equations. It fits the cone for λ2√2≤tau κ. With smooth angular B,C added and A=4B one gets a manufactured coupled three-component source, not an original NS source.

[Independent SymPy/Fraction/70-digit checker](attack023/verify_meridional_flat_lift.py) PASSES the full curl and streamfunction identities, half-density factorization, double-primitive, nontrivial manufactured compact pressure and strictly positive cone reserve. [Lean finite algebra](../../NewtonConjectures/Case006FlatMeridionalDoublePrimitive.lean) is imported and in CI, but integration, flat decay and PDE are not Lean-formalized; compiler verdict pending.

**Still open:** source-native full g,rho,G,chi and balance hypotheses not frozen; general f_m, nonaxisymmetric modes, global gluing, slice bound (249), full weighted H8 inversion (273), and unforced NS blowup remain open. The next real target is to calculate the two weighted balance defects of the actual residual curl and determine whether an E-correction, while retaining cone reserve, can cancel them.


### Appendix AA — exact two-global-moment compact meridional curl reconstruction (112-page paper)

The cumulative main manuscript now has **112 pages**, with [Appendix AA](paper/Appendix_AA_Compact_Meridional_Curl_Reconstruction.md) on pages 111–112 and **all 110 earlier pages preserved text-identically**.

**New exact theorem beyond Appendix Z:** Let g∈C_c∞((a,b)×(c,d)) with 0<a<b. For the actual cylindrical operators
```text
LE E = E_rr−E_zz+E_r/r−E/r²,
LD D = 2D_rz+D_z/r,
```
there exist E,D∈C_c∞ with LE E+LD D=g **if and only if**
```text
∫g drdz=0 and ∫r²g drdz=0.
```
This is an exact **unweighted** compact range characterization, not an estimate in rho. After e=√r E,v=√r D,h=√r g, the radial adjoint kernel of ∂rr−3/(4r²) is span{r^-1/2,r^3/2}. The explicit compact ODE Green solution H for T(r)=∫h dz uses the two moments, and a separable first correction e0=H(r)θ(z) removes the axial-column defect. A second **finite-rank** correction e1=−4/3 ξ(r)a0(z) with ∫ξ dr=0,∫ξ/r² dr=1 removes the radial-row defect while preserving axial balance. The remaining h1 has two zero slice integrals and the compact double primitive v=(1/2)∫r∫z h1 solves it. Hence the two **pointwise** slice-balance restrictions of Appendix Z can be eliminated once E=A−4B is permitted.

**Source-specific simplification:** For compact meridional source f_m=(f_r,f_z) and compact already-chosen angular B, the source curl is g=∂r f_z−∂z f_r−4LE B. Exact integration by parts gives ∫g=0 automatically and
```text
∫r²g dr dz=−2 ∫r f_z dr dz.
```
Thus the sole global obstruction for this **unweighted axisymmetric compact meridional curl and compact pressure** is the physical net axial-force moment ∫r f_z=0 (2π angular factor suppressed). A compact pressure gradient has zero such moment. This condition has NOT been evaluated for the original unfrozen prepared source.

**Exact nontrivial replay:** On 1<r<2, ξ=−21000 r²(r−1)^4(2−r)^4(r−153/100) has exact ∫ξ=0 and ∫ξ/r²=1. A nonzero polynomial source built from e=Hθ+ξθ' and an independent D double primitive is reconstructed exactly; a positive compact g has nonzero global moments and is rejected. [Exact source/checker](attack024/verify_meridional_balance_repair.py) passes. [Lean finite algebra](../../NewtonConjectures/Case006MeridionalMomentRepair.lean) added to root/CI; its kernel compiler verdict remains pending and the integral theorem is not Lean formalized.

**Critical missing H8 estimate:** The compact E and D produced by this method may have large amplitude or extend into locations where the actual rho is infinitely flat. **No bound** |A−4B|+2|D|≤κrho/2 or full cone positivity (272), compact weighted inverse (273), physical source axial-force cancellation, nonaxisymmetric mode or unforced Navier–Stokes singularity has been proved. Relevant compact underdetermined elliptic PDE prior art by Erwann Delay (2012) is cited; no claim of general novelty.

