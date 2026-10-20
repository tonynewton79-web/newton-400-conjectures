# Appendix AA. Compact meridional curl reconstruction and the axial-force moment

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The two-page typeset mathematical proof is included in the **112-page cumulative manuscript**, with the first 110 pages unchanged. The exact original-source restriction and the absence of a weighted cone estimate are essential.

Appendix Z produced a smooth compact meridional lift for a residual curl obeying a radial and an axial slice-balance identity at every slice. Those are sufficient, but not necessary if both meridional correction coefficients are permitted to vary. This appendix characterizes the full **unweighted** compact range of the axisymmetric meridional curl operator and identifies the global physical source condition that remains.

## Exact compact-range theorem

In a physical annular rectangle `Omega=(a,b)×(c,d)` with `0<a<b`, define
```text
LE E = E_rr−E_zz+E_r/r−E/r²,
LD D = 2D_rz+D_z/r.
```
Set `e=sqrt(r) E`, `v=sqrt(r) D`, `h=sqrt(r)g`. Then
```text
sqrt(r)(LE E+LD D) =
  (∂rr−∂zz−3/(4r²)) e +2 ∂rz v
  = P e+2v_rz.
```

**Theorem.** Every smooth compact `g` admits **smooth compact** `E,D` satisfying `LE E+LD D=g` **if and only if**
```text
∫_Omega g dr dz = 0,     ∫_Omega r² g dr dz = 0.
```

**Necessity.** The two radial functions `u_-=r^-1/2`, `u_+=r^3/2` span the homogeneous kernel of `d²/dr²−3/(4r²)`. Multiply the half-density equation by either `u` and integrate the compact data in `r,z`. Both derivative and potential terms vanish under integration by parts. Since `u_- h=g` and `u_+ h=r²g`, the two moments must be zero.

**Constructive sufficiency.** Define `T(r)=∫_c^d h(r,z)dz`. The two conditions are `∫u_±T=0`. With Wronskian 2, the explicit initial-value solution
```text
H(r)=1/2 [r^(3/2) ∫_a^r s^(-1/2)T(s)ds
          −r^(-1/2) ∫_a^r s^(3/2)T(s)ds]
```
is compact at both radial ends and satisfies `H''−3H/(4r²)=T`. Choose `theta∈C_c∞(c,d)` with `∫theta=1`, set `e0(r,z)=H(r)theta(z)` and `h0=h−P e0`. Then `∫h0 dz=0` at every r. Set `a0(z)=∫h0 dr`; its axial integral is zero. Choose a compact smooth radial shape `xi` with
```text
∫ xi dr=0,      ∫ xi/r² dr=1.
```
Such a shape exists from the normalized difference of two separated unit-mass bumps, since `r^-2` is nonconstant. Set `e1=−(4/3)xi(r)a0(z)`. It has zero axial integral and exact radial `∫P e1 dr=a0(z)`. Thus `h1=h0−P e1` has **both** radial and axial slice integrals zero, and
```text
v(r,z)=1/2 ∫_a^r∫_c^z h1(s,t)dt ds
```
is smooth and compact, with `2v_rz=h1`. The explicit `E=(e0+e1)/sqrt(r)`, `D=v/sqrt(r)` finish the proof. No weighted pointwise estimate is asserted.

## Source-side consequence: net axial force

For a compact meridional forcing `f_m=(f_r,f_z)` and fixed compact angular field `B=H_theta,z`, the actual pressure-free residual curl is
```text
g=∂r f_z−∂z f_r−4LE B.
```
The formal radial adjoint of LE annihilates both weights 1 and r² after all compact boundary integrations. Therefore
```text
∫ g dr dz =0 automatically,
∫ r²g dr dz = −2∫ r f_z dr dz.
```
The second condition is precisely **zero total physical axial forcing**, apart from the customary 2pi angular factor. A compact scalar pressure gradient does not change it. Thus the exact meridional curl equation admits a smooth compact solution modulo a smooth compact pressure **if and only if** `∫ r f_z=0`, under the axisymmetric compact chart hypotheses. The curl-free residual is integrated to a compact pressure on the simply connected chart.

**No actual physical source result is claimed:** the main source manuscript does not freeze the final complete `f_m`, `B`, `rho`, `chi` and `G`. This theorem supplies the precise source moment to calculate when those data become available. Whether the moment vanishes for the original H8 preparation remains **unknown**.

## Exact rational test and the nonnegotiable weighted gate

On `1<r<2`, define
```text
u=r²(r−1)^4(2−r)^4,
xi=−21000*u*(r−153/100).
```
Exact integration gives `∫xi=0`, `∫xi/r²=1`. Set `theta(z)=140z³(1−z)³`, `zeta=theta'`, and build nonzero `e=u*theta+xi*zeta` with an independent nonzero double-primitive input `v`. The two-stage algorithm recovers `e0=u theta`, `e1=xi zeta`, `v` exactly, and both global curl moments vanish. An independent smooth positive source has nonzero moments and correctly fails the necessary gate. The polynomial test checks the differential identities in the interior; the mathematical theorem uses genuine smooth compact input data.

The shape `xi` has a potentially costly moment normalization; neither it nor the radial Green function controls `|A−4B|+2|D|` relative to a **flat** rho. So this is a precise solution of the **unweighted compact** meridional curl and pressure compatibility problem, NOT the weighted cone `C(H)≤15971*rho/122900` or H8 compact inverse. The issue of compact solutions and compatibility moments for underdetermined elliptic PDE has established antecedents (e.g. [Erwann Delay, *Comm. Partial Differential Equations* 37 (2012), 1689–1716](https://doi.org/10.1080/03605302.2012.711794)); this special cylindrical construction is not claimed to be a general discovery of the method.

[Exact independent algebraic replay](../attack024/verify_meridional_balance_repair.py) covers the two adjoint modes, rational radial normalizer, the two-stage E repair, compact D construction, moment obstructions and finite source axial-force identity. [Lean finite fragment](../../../NewtonConjectures/Case006MeridionalMomentRepair.lean) covers jet/rational identities only, **not** the analytic integral theorem or the full H8.

**Next proof obligation:** establish `∫r f_z=0` from the ACTUAL complete prepared source and find a weight-controlled version of this construction, or exhibit a weighted dual obstruction. The strict angular dual/relative-growth hypotheses, global nonaxisymmetric modes, slice (249), cone (272), compact weighted inverse (273), and unforced Navier–Stokes singularity are OPEN.
