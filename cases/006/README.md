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

