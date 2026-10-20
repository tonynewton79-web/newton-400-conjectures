# Appendix AB. Radial and logarithmic duals for the weighted H8 cone

Continuation of Tony Newton's *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. This two-page paper appendix is incorporated into the cumulative **114-page** manuscript; the preceding 112 pages are text-identical. A fully typeset editable LaTeX version accompanies the author release.

## Why the unweighted compact inverse is not enough

Appendix AA supplies smooth compact solutions of the meridional curl equation for exactly two global compatibility moments, but offers no estimate relative to the positive, infinitely flat H8 cone envelope. This note obtains an exact additional necessary bound from the source-side axial force and the angular stress already constructed. It also gives counterexamples where all earlier global moments vanish but the weighted cone fails.

Let the physical axisymmetric annular chart be `Omega=(a,b)x(c,d)`, `0<a<b`, and put `kappa=15971/122900`. From the original seven-ray coefficient norm (270)–(272), for `E=A−4B`,

```text
|E|+2|D| <= (kappa/2)*rho.
LE E = E_rr−E_zz+E_r/r−E/r²,
LD D = 2D_rz+D_z/r,
g = LE E+LD D.
```

The formal adjoints with respect to `dr dz` are
`LE*phi=phi_rr−phi_zz−phi_r/r`,
`LD*phi=2phi_rz−phi_z/r`.

## Theorem 1: sharp global logarithmic dual

For any `r0>0`, the radial function `phi(r)=r² log(r/r0)/2` satisfies `LE*phi=1`, `LD*phi=0`. Hence every compact smooth cone-admissible correction satisfies

```text
|∫_Omega (r²/2) log(r/r0)*g| <= (kappa/2) ∫_Omega rho.
```

Proof: exact compact Green integration gives `∫phi g=∫E`; the pointwise cone bounds |E|. Equality forces E to have constant sign with |E|=kappa*rho/2 and D=0 wherever rho>0; this is sharp in the model below.

For the genuine physical source notation from Appendix AA,
`g=∂r f_z−∂z f_r−4LE B`, integration by parts yields

```text
∫phi g = −∫r[log(r/r0)+1/2]f_z−4∫B.
```

Under the unweighted compact-source axial-force condition `∫r f_z=0`, this becomes the **reference-radius-independent** necessary inequality

```text
|∫r log(r/r0)f_z + 4∫B| <= (15971/245800)*∫rho.
```

The original paper states its zero-force preparation conditionally on suitable normalization of the final source; the final actual `f_m,B,rho,chi,G` are not frozen, so this is a new gate to evaluate rather than a passed physical test. Compact pressure gradients do not change the axial moments.

## Theorem 2: stronger radial-by-radial axial-force gate

Write `Fz(r)=∫_c^d f_z(r,z)dz`, `Bbar(r)=∫ B(r,z)dz`, `R(r)=∫rho(r,z)dz`. The meridional axial equation modulo compact pressure is

```text
f_z=A_r + A/r + D_z + p_z .
```

Integrating in z gives `(r Abar)'=r Fz` and compact radial boundary data `Abar(a)=0`; therefore

```text
Ebar(r)=∫ E(r,z)dz=(1/r)*∫_a^r s Fz(s)ds−4 Bbar(r).
```

The exact seven-ray cone consequently requires, **for every a<r<b**,

```text
|(1/r)∫_a^r s Fz(s)ds−4 Bbar(r)|
    <= (15971/245800)*R(r).
```

This test is invariant under adding compact pressure gradients and remains meaningful where the envelope is infinitely flat. Zero net force ensures only that `∫_a^b rFz=0`, not the local pointwise capacity. Integrating the radial identity yields the logarithmic global test; therefore the radial family is strictly stronger.

## Two smooth manufactured counterexamples and exact thresholds

Choose **any** nonzero smooth compact nonnegative annular envelope rho, including an infinitely flat envelope. With B=C=D=0, let `E0=lambda*rho` and prescribe

```text
f_r = lambda*rho_z,
f_z = lambda*(rho_r+rho/r),
g = lambda*LE rho.
```

This source has zero net axial force and both Appendix AA global curl moments vanish exactly; it has an unweighted smooth compact reconstruction. Nevertheless the logarithmic test forces `|lambda|<=kappa/2` for ANY cone-admissible reconstruction. At `lambda=kappa` it **FAILS by factor 2**; at `lambda=kappa/4`, the explicit E0,D=0 correction **PASSES with half the cone capacity**, and at `lambda=kappa/2` it saturates and forces D=0.

To distinguish the local test from the global one, take `Omega=(1,2)x(0,1)` and a separable smooth flat envelope `rho=p(r−1)q(z)` with symmetric positive-inside flat factors. Replace constant lambda with `lambda(r)=2*kappa*(r−3/2)`, define E0=lambda(r)rho and f=(∂zE0,∂rE0+E0/r). Then `∫r f_z=0` and both global curl moments vanish. Symmetry gives `∫E0=0`, so the logarithmic test passes **exactly at zero**. But at `r=15/8`, `|lambda(r)|=3*kappa/4>kappa/2` while `R(r)>0`. The exact radial marginal `Ebar=lambda(r)R(r)` is fixed for all compact corrections, so no alternative meridional D or compact pressure can satisfy the weighted cone. This is a model diagnostic, **not** the actual H8 prepared source.

## Scope and verification

Independent exact symbolic and rational tests prove both formal Green identities, the radial primitive identity, the manufactured source curl and axial-force cancellation, the three sharp rational amplitude cases, and the zero-global-but-radial-FAIL example. A separate 65-digit test evaluates the logarithmic source identity on a genuinely infinitely flat radial weight.

[Exact checker](../attack025/verify_log_weighted_dual.py). [Lean finite algebra](../../../NewtonConjectures/Case006RadialConeDual.lean) covers only constants, pointwise cones and polynomial radial jets; neither the integrated theorems nor the original H8 PDE are end-to-end formalized. The complete prepared physical source has not been evaluated. General compact-support underdetermined elliptic methods are prior art: see E. Delay, *Comm. Partial Differential Equations* **37** (2012), 1689–1716, [DOI 10.1080/03605302.2012.711794](https://doi.org/10.1080/03605302.2012.711794). The specialized fixed-coefficient radial test is an incremental research finding, not a universal inverse or any Navier–Stokes singularity theorem.

**Next H8 gate:** freeze the actual axisymmetric meridional f_z, angular lift B, and envelope rho in one transported physical chart, and interval-certify the full radial-by-radial inequality, especially where rho is flat. A source failing at any radius is excluded from the desired positive seven-ray coefficient representation. Passing is necessary but not sufficient; remaining dual directions, smooth weighted compact inversion, full pressure/patch support and nonaxisymmetric Fourier modes remain open.
