# Appendix V. Interior smooth lifting and the flat-envelope obstruction

This is the editable research continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* (original [DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142)). The complete two-page revised LaTeX proof is included with the cumulative **102-page** main-paper PDF; its first 100 pages were programmatically verified unchanged.

## Motivation

Appendix U uses standard Hahn–Banach and L¹–L∞ duality to characterize **bounded measurable weak** solvability of the weighted angular H8 equation. But the final H8 proof needs a **smooth compact** stress with a quantitative seven-ray reserve. It is incorrect to infer this stronger conclusion from weak duality alone, especially where the source envelope vanishes to infinite order.

We prove a constructive smoothing theorem *strictly inside the positive-envelope region*, using an elementary compact rectangular antidivergence, and isolate the exact failure of ordinary fixed-scale mollification near a flat boundary.

## Compact rectangular antidivergence with explicit constants

Let U=(r₋,r₊)×(z₋,z₊), lengths Lr,Lz. Choose a smooth compact radial weight θ≥0, ∫θ=1 and J=||θ||∞. For smooth compact h with ∫∫h=0, set

```text
H(z)=∫_{r₋}^{r₊}h(s,z)ds,
Qr(r,z)=∫_{r₋}^r [h(s,z)−θ(s)H(z)]ds,
Qz(r,z)=θ(r)∫_{z₋}^z H(t)dt.
```

Then (Qr,Qz) are smooth and compactly supported in U, div Q=h **exactly**, and

```text
||Qr||∞≤2 Lr ||h||∞,
||Qz||∞≤Lr Lz J ||h||∞.
```

These follow by direct differentiation, zero global integral and the normalization ∫θ=1. The formula uses no elliptic inverse.

## Theorem: quantitative interior smooth lifting with strict reserve

For the original angular four-field correction, set

```text
κ=15971/122900, a=κ/2, b=κ/8,
w=r²rho, f=r²(g−divK)_theta.
```

Let U be compactly contained in the annular positive-envelope region, with w smooth and w≥w*>0 on its closure. Suppose a bounded measurable weak angular flux V is supported in a compact K⊂⊂U and satisfies

```text
div V=f (distributions),
|Vr|≤(1−σ)a w, |Vz|≤(1−σ)b w, 0<σ<1.
```

Put F=||∇f||∞, W=||∇w||∞ on U. For a nonnegative symmetric smooth mollifier of radius ε with K+B_{2ε}⊂⊂U, the following THREE EXPLICIT TESTS suffice:

```text
(1−σ) ε W ≤ σ w*/4,
2 Lr ε F ≤ σ a w*/4,
Lr Lz J ε F ≤ σ b w*/4.
```

Then there is V♯∈C_c∞(U) with div V♯=f and

```text
|Vr♯|≤(1−σ/2) a w,
|Vz♯|≤(1−σ/2) b w.
```

Dividing by r² gives the smooth compact angular H8 correction C♯=Vr♯/r², B♯=Vz♯/r², with exact **joint** coefficient reserve

```text
max(2|C♯|,8|B♯|)≤(1−σ/2)κrho.
```

**Proof:** mollify V to Vε, whose divergence equals fε=ηε*f. The original strict componentwise reserve and |w*ηε−w|≤εW imply Vε consumes at most (1−3σ/4) of each capacity. Correct the smooth compact zero-mean residual h=f−fε using the explicit rectangular Q above. Since ||h||∞≤εF, the last two tests spend at most σ/4 of either remaining capacity, leaving a strict σ/2 reserve. The sum V♯=Vε+Q has exactly the original divergence, not merely an approximation.

**Essential additional hypothesis:** Hahn–Banach weak duality alone does not ensure the initial weak V is supported inside such an interior positive-envelope rectangle. The resulting estimates deteriorate as w* tends to zero.

## Exact failure of fixed-scale smoothing at a flat boundary

Let rho(x)=e^(−1/x²) for x>0 near 0, extend it by zero for x≤0 and smoothly truncate away from the boundary. For any fixed positive-radius nonnegative standard mollifier ηε,

```text
(ηε*rho)(0)>0 but rho(x)→0 as x→0+,
hence (ηε*rho)(x)/rho(x)→∞.
```

Thus even convolution of an already smooth flux V=θ a rho with a fixed positive reserve can violate every bound |Vε|≤a rho near the flat edge. This is a counterexample to **ordinary fixed-radius smoothing**, NOT an impossibility theorem for all conceivable variable-scale/weighted smooth liftings.

## Verification and open physical gate

The exact [SymPy/Fraction/high-precision checker](../attack019/verify_interior_lifting.py) verifies the rectangular corrector algebra for nontrivial polynomial jets, all three rational sufficient inequalities (illustrative values clearly not from the original H8 source), and the positive flat-boundary convolution obstruction. The [Lean finite-algebra source](../../../NewtonConjectures/Case006InteriorSmoothLifting.lean) checks divergence-residual cancellation, exact reserve accounting, the rational cone constants and illustrative inequalities. It **does not** formalize weak compact support, mollifier integration or the full smooth-lifting theorem.

The theorem gives a *conditional interior* smooth angular lift. It does not establish the required boundary-uniform extension through a flat rho, the three meridional tensor equations, compact pressure and global patch assembly, the source-specific slice gate (249), or the full weighted H8 inverse (273). The final complete prepared source and envelope still have not been frozen. No unforced finite-energy Navier–Stokes singularity has been proved.

**Next mathematical target:** develop a variable-scale weighted regularization and compact correction that works uniformly as w*→0 without sacrificing strict cone reserve; then couple it to the other meridional stress equations. Avoid inferring a global H8 inverse from the present interior result.
