# Appendix Q. Mixed-profile adjoint control for the exact viscous torque equation

Tony Newton, continuation of *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* ([original DOI](https://doi.org/10.5281/zenodo.23475142)). The full edited two-page Appendix Q is contained in the 92-page cumulative author manuscript (the previous 90 pages are retained). The source of the derivation is the original equations (250), (251), and strict radial-shear Proposition 9.20, **not** the constant-coefficient proxy of Appendix P.

## The actual source-defined moments

On an interior axial interval I in the source's strong-Rayleigh subpatch, let two smooth nonnegative radial shapers tau_0 and tau_1 have

```text
M_j(eta)=int R² tau_j(R,eta)dR >0,
N_j(eta)=int R² G(R,eta) tau_j(R,eta)dR,
g_j(eta)=N_j(eta)/M_j(eta),  j=0,1.
```

These are the original source's definitions. The manuscript does **not** fix the final normalized shapers or numerical functions M,N, so a numerical physical Jacobian is presently unavailable. Strict radial shear `G_R<=-sigma<0` (Proposition 9.20 supplies sigma=g0*Lambda_c^(-1/2) in its specified rectangle) ensures `g_0-g_1 >= sigma*DeltaR` whenever nonnegative radial shaper supports lie in bands separated by a positive radial gap DeltaR. Axial cutoffs may be chosen equal to one on I and compact in the larger transition region.

Put `D=1/2-h`, `gamma=3/2-2h>0`, `delta=nu epsilon²>0`. For j=0,1 the full exact viscous operator is

```text
L_j A=((D eta M_j+N_j)A)' - gamma M_j A - delta (M_j A)''.
```

Let phi_1,phi_2 be independent solutions of the reference (j=0) adjoint ODE,

```text
delta phi''+(D eta+g_0)phi'+gamma phi=0.
```

**Theorem (exact mixed-profile torque pairing).** For every compact smooth axial amplitude A and each reference adjoint phi,

```text
int phi L_1[A] d eta = - int A M_1 (g_1-g_0) phi' d eta.
```

Proof: integrate both derivatives of L_1 by parts. Its adjoint density is `-M_1[(D eta+g_1)phi'+gamma phi+delta phi'']`; subtract the reference adjoint equation. In particular **all compact controls using the SAME radial profile as the reference have zero reference-adjoint pairings**. Simply varying their axial amplitudes cannot correct the compactness incompatibility.

**Theorem (two actual source-form pairing columns exist conditionally).** On a subinterval where g_1-g_0 is bounded away from zero, there exist two nonnegative smooth compact amplitudes A_1,A_2 with disjoint axial supports such that

```text
C_ij=int phi_i L_1[A_j], i,j=1,2;   det C != 0.
```

Only a single *alternative* radial profile is needed, used at two axial locations. Proof: If W=phi_1 phi_2'−phi_1' phi_2 is the reference adjoint Wronskian, second-order ODE uniqueness guarantees W never vanishes. Differentiating and using the exact ODE gives

```text
phi_1' phi_2''−phi_1'' phi_2' = (gamma/delta) W != 0.
```

The response vector `v(eta)=-M_1(g_1-g_0)(phi_1',phi_2')` therefore has `det(v,v')=M_1²(g_1-g_0)²(gamma/delta)W !=0`. Two nearby evaluations are linearly independent; two sufficiently narrow nonnegative unit-mass bump amplitudes around those points retain a nonsingular integrated 2x2 pairing matrix.

**Corollary (exact local finite-rank Fredholm repair).** For any prescribed smooth compact normalized torque forcing f supported in I, choose two such bumps and solve `C alpha=(int phi_1 f,int phi_2 f)`. The adjusted forcing `f−alpha_1 L_1[A_1]−alpha_2 L_1[A_2]` annihilates both reference adjoints. Appendix P's exact compact-range theorem therefore gives a compact reference amplitude A_0 with

```text
L_0 A_0 + alpha_1 L_1 A_1 + alpha_2 L_1 A_2 = f.
```

This is a **conditional local source-form controllability theorem**: G must satisfy the stated shear gap, the two nonnegative radial profiles must be supported inside the permitted patch, the frozen axial equation and its background G must remain unchanged, and the prescribed f must have the required compact support. It is not a proof that the resulting controls preserve full Navier–Stokes source admissibility and weighted cone positivity.

## Robust determinant test for later fixed profiles

Let `v(eta)=-M_1(g_1-g_0)(phi_1',phi_2')`, and take unit-mass nonnegative bump controls of support radius at most w around eta_1 and eta_2. With `e=w sup_I ||v'||_2`, columns of C differ from the point columns `v(eta_j)` by at most e. If `V=[v(eta_1),v(eta_2)]`, the explicit perturbation bound is

```text
|det C-det V| <= e (||v(eta_1)||_2+||v(eta_2)||_2)+e².
```

Hence a strict determinant separation produces a rigorous interval-certifiable certificate for any subsequently frozen source-native profile. This is a method, not a completed numerical H8 bound.

The strict shear gap is only O(Lambda_c^(-1/2)) in the source subpatch, and the two controls may need very close axial supports. Their coefficients alpha may be large. **Unproved:** actual frozen M,N and f; finite cone margin under the controls, the scale-sharp slice torque estimate (249), preservation of kinetic covariance and graph support, compact pressure and weighted H8 inverse (273). No unforced Navier–Stokes singularity is established.

**Reproducibility.** [Exact symbolic and high-precision checker](../attack014/verify_mixed_profile_controls.py) establishes the mixed-profile adjoint identity, derivative Wronskian, rational strict-shear illustrative radial moments, and an illustrative smooth two-bump pairing matrix. The illustrative shear G=1−R is **not** the manuscript's frozen G. [Lean algebraic source](../../../NewtonConjectures/Case006MixedProfileControls.lean) covers only pointwise polynomial implications, Wronskian elimination and 2x2 determinant algebra. The smooth ODE, compact support, source integrals and PDE bounds are not end-to-end Lean formalized. The Lean build must pass CI before kernel verification may be claimed.
