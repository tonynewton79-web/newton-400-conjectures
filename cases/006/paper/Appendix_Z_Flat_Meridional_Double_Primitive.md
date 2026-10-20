# Appendix Z. Smooth flat-boundary meridional lifting for doubly balanced curl sources

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The complete original, typeset Appendix Z is incorporated on pages **109–110** of the cumulative **110-page PDF**; all 108 prior pages are text-identical. Editable LaTeX and independent replay accompany the release.

## 1. Exact pressure-curl reduction of the meridional system

In a physical axisymmetric cylindrical annulus, the trace-free four-field stress and its precise coefficient norm are

```text
H=[[-D,C,A],[C,0,B],[A,B,D]]
κ=15971/122900, k=κρ,
N(H)=max{8|B|, 2|C|+4|D|, 2|A−4B|+4|D|}.
```

Put E=A−4B, and for meridional vector f_m=(f_r,f_z), take the planar curl C(f_m)=∂r f_z−∂z f_r. The exact cylindrical divergence gives

```text
(divH)_r = −D_r + A_z −D/r,
(divH)_z = A_r +D_z +A/r.
L_E E = E_rr−E_zz+E_r/r−E/r²,
L_D D = 2D_rz+D_z/r.
g = ∂r f_z−∂z f_r−4 L_E B.
L_E E + L_D D = g.                   (Z.1)
```

If the compact smooth prescribed f_m and stress satisfy (Z.1), then their difference has zero curl and hence equals a pressure gradient on the simply connected chart. When all terms extend smoothly by zero outside the **closed** annular rectangle, the pressure can be normalized to vanish on its connected exterior, giving a smooth compact representative. This is stronger than Appendix Y's unrestricted distributional-pressure formulation.

The exact half-density conjugation reveals the underdetermined elliptic scalar principal symbol:

```text
L_E(r^(-1/2)e)=r^(-1/2)[e_rr−e_zz−3e/(4r²)]
L_D(r^(-1/2)d)=2r^(-1/2)d_rz.
```

The principal row symbol `(ξ_z²−ξ_r², −2ξ_rξ_z)` has Euclidean norm `|ξ|²` at every real ξ≠0. This observation does not itself provide a compact-support right inverse.

## 2. New smooth, compact, flat-boundary meridional theorem (restricted class)

Let Ω=(r−,r+)×(z−,z+), r−>0. Choose a separable smooth nonnegative flat envelope

```text
w(r,z)=r²ρ(r,z)=p0(r)q0(z),
```

where p0,q0 are each symmetric about the interval midpoint, monotone toward their midpoint, strictly positive inside, and infinitely flat at the boundary. The standard example is `p(x)=exp[−x^(−2)−(1−x)^(−2)]` on (0,1), extended smoothly by zero.

For a prescribed smooth compact meridional f_m and fixed smooth angular correction B,C, assume its **pressure-free residual curl** is

```text
g(r,z)=r^(−1/2)p0(r)q0(z)F(r,z),  |F|≤L,
∫_(r−)^(r+)p0(s)F(s,z)ds=0 for every z,
∫_(z−)^(z+)q0(t)F(r,t)dt=0 for every r.
```

These are **two additional slice balances**, specific to this D-only construction, not consequences of the general meridional dual criterion.

**Theorem.** Set E=0, A=4B, and

```text
D(r,z) = (1/(2√r)) ∫_(r−)^r∫_(z−)^z√s*g(s,t)dt ds.     (Z.2)
```

Then D extends by zero to a globally C∞ compact function, solves `L_D D=g` exactly, and therefore produces a smooth compact pressure-adjusted meridional solution. For `Lr=r+−r−`, `Lz=z+−z−`,

```text
|D| ≤ L Lr Lz w/(8√r) ≤ L Lr Lz r+^(3/2) ρ/8.         (Z.3)
```

This follows from two successive weighted Hardy primitive bounds for symmetric unimodal p0,q0 and the two balances. If angular fields satisfy `8|B|,2|C|≤(1−τ)κρ`, `0<τ≤1`, and `L Lr Lz r+^(3/2)≤τκ`, then

```text
N(H) ≤ (1−τ/2)κρ                                     (Z.4)
```

including at every infinitely flat support boundary. No positive minimum for ρ is required.

**Proof outline.** The factorization `L_D D=(2/√r)∂r(√r D_z)` proves (Z.2) exactly. The radial cancellation gives an endpoint-vanishing primitive and the pointwise bound `|(∫p0F)|≤(L Lr/2)p0(r)q0(z)`; its axial primitive inherits zero axial integral, providing an additional `Lz/2` factor. Both primitives vanish to all orders at the flat boundary. The meridional curl residual vanishes, so the compact pressure exists. Finally 4|D|≤τκρ/2 and the angular slack imply (Z.4).

## 3. Explicit nonzero smooth meridional source and compact pressure

Take (r,z)∈(1,2)×(0,1), the flat symmetric p on (0,1), and

```text
p0(r)=p(r−1), q0(z)=p(z),
F(r,z)=λ(r−3/2)(z−1/2), λ>0.
```

The two balances hold by symmetry, and D in (Z.2) is nonzero, smooth, compact, and flat. With B=C=0, an explicit prescribed compact meridional source and pressure are

```text
f_m=(-2D_r−D/r,0),    pressure=−D.
```

The exact curl is `L_D D=g`; the original cylindrical meridional equation holds pointwise. For `λ·2√2≤τκ` the cone remains strictly feasible. Adding any independently smooth angular fields B,C within the required reserve and taking A=4B gives the corresponding **manufactured coupled axisymmetric three-component** source, again with compact pressure −D. It is NOT the prepared source of the original unforced Navier–Stokes paper.

[Independent SymPy / exact rational / 70-digit replay](../attack023/verify_meridional_flat_lift.py) passes the full curl and streamfunction reduction, half-density factorization, smooth compact source/pressure, two balance identities, rational cone margin and nonzero smooth flat-envelope quadratures. [Lean finite algebra](../../../NewtonConjectures/Case006FlatMeridionalDoublePrimitive.lean) formalizes only finite jet/cone/pressure arithmetic, not the integration or PDE theorem.

**Remaining gap.** The actual complete g,ρ,χ,G, its pressure-free curl's two balance identities, all dual inequalities and source-normalization data remain unfrozen. General meridional data not of this special form, nonaxisymmetric modes, global gluing, slice (249), physical cone (272), full compact weighted H8 inverse (273), and any unforced Navier–Stokes singularity remain OPEN. The next targeted analysis is whether the genuine physical meridional curl admits these two slice balances, or a controlled E-correction removing their defects.
