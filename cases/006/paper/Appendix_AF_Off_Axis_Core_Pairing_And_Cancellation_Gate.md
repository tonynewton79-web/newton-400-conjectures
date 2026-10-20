# Appendix AF. Off-axis core pairing and the first-derivative cancellation gate

Research continuation of the cumulative **122-page** manuscript *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, Tony Newton. This two-page appendix is placed on pages 121–122, retaining all 120 previous pages unchanged. The edited LaTeX source is included in the independent verification release.

## Original source and exact kinematics

The original equations (199)–(200), (208)–(209) have `q=1-t`, `A+D=1`, `c=q^D`, `eta=z/c`, `Y=Lambda_c*r^2/(2q)` and the normalized core's axial profile `u_z=q^(-A)G(Y,eta)`. Let the core be axisymmetric, incompressible and regular at r=0. Then the **full** core's radial velocity, including all off-axis terms, is determined *exactly* by

```text
u_r(r,z)=−1/(q*r) ∫_0^r s G_eta(Y(s),z/c) ds .
```

For any compact shaper Xi let `I_Xi(r)=∫u_r(r,z)Xi(z/c)dz`. Then `I_Xi=−c/(qr)∫_0^r s ∫Xi(eta)G_eta(Y(s),eta)deta ds`. This is an exact full-core pairing identity and does not require truncation.

Eq. (209) reads `G=4eta+j0−Y*M(eta)/(2Lambda_c)+E`, `M=Zstar/L`, `L=1−2h eta^2`. If the *actual* remainder has uniform `|E_eta|<=C2/Lambda_c^2` across the entire core cylinder `0<=Y<=Yplus`, then

```text
I_Xi=−2*c*r*mXi/q + c*r^3/(16q^2)∫M'(eta)Xi(eta)deta + RI,
|RI| <= c*r/(2q)*(C2/Lambda_c^2)*||Xi||_1.
```

For Xi≥0 with positive mass and `|M'|<=M1`, the explicit inequality `gamma=4−Yplus*M1/(2Lambda_c)−C2/Lambda_c^2>0` forces `I_Xi<=−(c*r*mXi/(2q))*gamma<0`. The source paper does not provide a **numerically frozen** `M1,C2` on the entire radial cylinder, so the positivity criterion is **conditional**, not a proven physical estimate for the finished H8 preparation.

## Full-core mixed shear and positive two-shaper no-go with a quadratic flat envelope

For original poloidal shaper (194) `Psi=K*Phi(r/ell)*Xi(z/c)`, the exact core–shaper cross-shear is

```text
T_{u,P}=(K/r)[I_Xi*Phi'/ell−Phi*(I_Xi'+I_Xi/r)]
       = K*I_Xi^2*d_r[Phi/(r*I_Xi)].
```

Consequently the first-order radial cutoff derivative persists with any exact core whose axial pairing I stays nonzero. For **two positive** amplitudes K_j, two nonnegative axial Xi_j, and radial profiles `Phi_j=a_j(r)b(r)` with a_j positive up to a common flat boundary, if each I_j stays negative and bounded away from zero, their total core-cross term is precisely `C(r)b'(r)+D0(r)b(r)`, with `C=(1/r) sum K_j a_j I_j <0` and bounded D0.

**Conditional theorem.** Suppose the flat radial envelope mass satisfies `0<R(r)<=M*b(r)^2`, and all *other* stress terms including quadratic shaper self/cross shear are O(R). Then the complete flux formed from those terms **cannot** obey the Appendix AC source-only H8 inequality `|T_str−alpha R|<=kappa R` at every radial point, with `alpha=−4443/9832`, `kappa=15971/122900`. Otherwise `|C b'+D0 b|<=C0 b^2` would force `|(log b)'|` bounded near a finite boundary, impossible for a positive b tending to zero there. The assumptions on R and the remainder are indispensable; another **first-derivative-order** cutoff/pressure/overlap contribution could cancel the linear core shear. This is not a physical-source no-go theorem.

The explicitly positive two-shaper diagnostic of Appendix AD has `Phi_1=b(x)`, `Phi_2=(1+x/2)b(x)`, `Xi_1=b(eta)`, `Xi_2=(1−eta/2)b(eta)`. Its quadratic shear is O(b²): the radial Wronskian cancels the common b' term. Thus its earlier shaper-only scalar cone pass is not by itself a mechanism to cancel the first-order core interaction.

## Reproduced diagnostic and exact boundaries

As a **specified mathematical surrogate**, take `q=c=ell=1`, `Lambda_c=1000`, `G=4eta+3−Y*(2eta)/(2Lambda_c)` (that is, M=2eta and zero E). Then `u_r=−2r+r³/8`, `u_z=4z+3−r²z/2`. Position the flat radial bump in `sqrt(12/1000)<r<sqrt(12.2/1000)`, corresponding to **Y in (6,6.1)** for illustrative chi=1, not the original actual chi. Choose K1=K2=1 and Appendix AD's two profiles and diagnostic envelope Rdiag proportional to b².

[Independent exact SymPy and 70-digit velocity-product replay](../attack029/verify_core_pairing_cancellation.py) verifies the off-axis incompressibility, first radial coefficient, logarithmic derivative identity, and original-product integration of `u_r P_z+u_z P_r+P_rP_z` at seven radii. The stress/shear ratio falls below and rises above the entire allowed negative source-only cone window in this surrogate. The independent calculation corrected a radial-width factor in the two-shaper quadratic self-shear during checking; all final direct-product and formula values agree to high precision.

[Finite Lean source](../../../NewtonConjectures/Case006OffAxisPairing.lean) covers only rational/factor/positivity algebra. Uniform actual G_η, flat-edge analytic proof and H8/Navier–Stokes PDE are **not** Lean-formalized. The original physical M(eta), remainder coefficients, kinetic envelope, full structured stress/p0 and four localized C4 maps remain unfrozen. The next essential check is to obtain the true Zstar/L and its eta-derivative from Eq. (255), bound the actual error across the full core cylinder, and calculate the *first-derivative-order* cutoff/gauge/transport stress that could neutralize the core cross term. H8 (249),(272),(273) and any finite-energy unforced singularity remain open.
