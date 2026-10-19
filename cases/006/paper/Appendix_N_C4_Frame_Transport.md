# Appendix N. Fourfold frame transport and the complete source

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). The original 84-page cumulative paper has been preserved text-identically, and this two-page appendix is included in the new **86-page** PDF. The editable published version accompanies the author email.

Appendix M proves that C4 averaging suffices for quadratic adjoint moments. That is distinct from checking covariance of the actual source in equation (273) after the tilted seven-ray frame, localization and patch gluing are applied. We now give an exact sufficient construction, a fixed-frame obstruction, and the corrected baseline source moments.

## N.1. A sufficient equivariant four-patch gluing law

Let S=[[0,-1,0],[1,0,0],[0,0,1]]. Its action on compact fields is

```text
U_S rho(X) = rho(S^{-1}X),
U_S g(X) = S g(S^{-1}X),
U_S K(X) = S K(S^{-1}X) S^T.
```

**Theorem.** For arbitrary smooth compact seed fields g0 (vector), rho0 (scalar), and K0 (symmetric tensor), define g=Σ_{k=0}³ U_S^k g0, rho=Σ U_S^k rho0, and K=Σ U_S^k K0. Then U_S g=g, U_S rho=rho and U_S K=K. Orthogonal covariance of tensor divergence gives U_S(div K)=div(U_S K), so the **complete unprojected source** s=g−div K is also exactly C4-equivariant.

**Proof.** Applying U_S to a fourfold sum shifts its summation index cyclically because U_S⁴=identity. The chain rule for an orthogonal constant S establishes divergence covariance. Terms arising when differentiating a transported cutoff belong to the transported seed derivative, and cannot be silently discarded. For a velocity U=Σ U_S^k U0, the nonlinear complete residual contains cross products div(U_j⊗U_k), j≠k. These terms may be nonzero when supports overlap; when included as a whole, they transform equivariantly.

For general patches F_k=chi_k g_k (cyclic k modulo 4), put E_k=F_{k+1}−U_S F_k. Then

```text
U_S(ΣF_k)−ΣF_k = −ΣE_k,   ||U_Sg−g||_1 ≤ Σ||E_k||_1.
```

The same estimate holds for scalar or tensor patches with their respective actions. If D_g=U_Sg−g, D_K=U_SK−K and s=g−divK, then D_s=D_g−divD_K exactly. Covariance of the Leray projection on a rotationally invariant torus does not, by itself, produce a compact pressure gauge.

## N.2. The obstruction to retaining a single fixed tilted centre

Proposition 9.22's rank-one trace-free centre is Rstar=b⊗b−I/3, |b|=1. The physical quarter-turn satisfies b·Sb=b_z². Therefore

```text
||S Rstar S^T−Rstar||_F² = 2(1−b_z⁴).
```

For a genuine tilt b_h≠0 the RHS is strictly positive. A single globally **fixed Cartesian** tilted centre is not C4-invariant.

Rotate horizontal coordinates so b=(a,0,c), a²+c²=1, ac≠0. Then the tensor mismatch is

```text
D=S Rstar S^T−Rstar =
[−a²  0  −ac; 0  a²  ac; −ac  ac  0],
||D||_F²=2a²(a²+2c²).
```

A nonnegative, compact, C4-invariant scalar envelope can be chosen to equal rho=x²+y² on a small ball. There curl(D grad rho)=(2ac,2ac,0)≠0. Hence the fixed-frame defect is not generally pure pressure and can remain Leray-visible. This is *not* a no-go for correctly orbit-transported tensor centres.

## N.3. Corrected quadratic source moments for transported cone centres

The Appendix L/M SO2-invariant quadratic test fields are E=(xz,yz,−z²), F=(−yz,xz,0), G=(0,0,x²+y²). For the C4-invariant **full source** s=g−divK, put A_s=∫s·E, B_s=∫s·F, C_s=∫s·G.

The rotated quadratic H8 adjoint moments obey

```text
(∫s·q1^R,∫s·q2^R,∫s·q3^R)^T
= T(c_theta,t_theta) (A_s,B_s,C_s)^T
```

with the exact transfer matrix T from Appendix L. This is the correct transported-source form of Appendix M. Its fixed-centre scalar correction (1217/1229) Z (t_theta,0,−2 c_theta) does **not** automatically carry over to a spatially rotated stress tensor K.

Integration by parts gives A_s=A_g+A_K, B_s=B_g+B_K, C_s=C_g+C_K, with

```text
A_K=∫ [z(K_xx+K_yy−2K_zz)+xK_xz+yK_yz],
B_K=∫ (−yK_xz+xK_yz),
C_K=2∫ (xK_xz+yK_yz).
```

For four transported copies of a fixed seed K0=rho0(bb^T−I/3) in a seed frame b=(a,0,c),

```text
A_K=4 ∫rho0 [z(a²−2c²)+ac x],
B_K=−4ac ∫y rho0,
C_K=8ac ∫x rho0.
```

These are exact identities because E,F,G are already SO2-equivariant. Crucially, C4 covariance does **not** imply B_K=0. Vanishing of the second quadratic adjoint moment at nonzero test-frame tilt requires cancellation of the **complete** B_s=B_g+B_K, not the prepared source g's torque alone.

## N.4. The tensor-aware symmetry-defect bound

Let P4 be the C4 average with the appropriate vector/tensor actions, and set s4=P4g−div(P4K). On a ball |X|≤L, the rotated quadratic H8 fields satisfy |q_i^R(X)|≤3|X|² and ||grad q_i^R(X)||_F < 6|X|. It follows exactly by integration by parts and the triangle inequality that

```text
|∫(s−s4)·q_i^R|
≤ 3L² ||g−P4g||_1 + 6L ||K−P4K||_{L¹(F)},
i=1,2,3.
```

This tensor-aware error estimate improves on testing only the envelope's scalar symmetry when the cone frame moves.

## Outstanding proof obligations

The original manuscript provides axisymmetric shaper *classes* (193)–(194), a selected torque-neutral toroidal actuator (252), and a tilted local seven-ray frame (258)–(273), but leaves the final normalized compact profiles unspecified. We therefore **cannot currently identify the exact physical patch maps, all cutoff terms and the compact pressure representative**, nor confirm that the manuscript's complete prepared source is the four-copy orbit of the theorem.

The next analytic task is to verify, in the manuscript's actual transported chart, F_{k+1}=U_S F_k for the complete source and stress separately, including nonlinear overlaps; evaluate A_s,B_s,C_s from that **same** full source; and recertify the local seven-ray cone margin wherever rotated patch supports overlap. This note proves neither compact weighted inversion (273) nor an unforced Navier–Stokes singularity.

**Reproducibility:** [exact SymPy/rational replay](../attack011/verify_frame_transport.py) and [Lean algebraic source](../../../NewtonConjectures/Case006FrameTransport.lean). The Lean source addresses selected polynomial identities only, not the full nonlinear PDE or source covariance, and must pass a real compiler/axiom audit before being described as kernel-certified.
