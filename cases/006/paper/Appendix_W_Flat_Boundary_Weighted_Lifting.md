# Appendix W. Flat-boundary angular lifting and the adaptive-smoothing commutator

*Case 006, cumulative **104-page** research manuscript, Appendix W (pages 103–104); first 102 pages preserved text-identically.* The full original, human-edited, two-page LaTeX/PDF is included in the author research release.

## Motivation and claim boundary

Appendix V proves conditional smooth lifting only on interior rectangles where the angular weight w=r²rho has a strictly positive lower bound. The actual H8 envelope is flat at its outer support boundary. Two exact but **different** advances are possible: a full-boundary smooth angular solution for radially balanced sources in a separable log-concave flat model, and a variable-step mollifier that preserves a cone margin at the flat edge but does not automatically preserve exact divergence. These are restricted angular-sector results, **not** the compact weighted H8 inverse for the still-unfrozen full Navier–Stokes source.

## W.1. Exact global smooth lift for a slice-balanced flat source

Let Omega=(r-,r+)×(z-,z+) be a physical annular rectangle (r->0) and put x=(r-r-)/(r+-r-), y=(z-z-)/(z+-z-). Define

```text
p(x)=exp(-1/x²-1/(1-x)²), 0<x<1, else 0;
q(y)=exp(-1/y²-1/(1-y)²), 0<y<1, else 0;
w(r,z)=p(x)q(y),  rho=w/r².
```

Both factors extend by zero smoothly to the whole plane, with all derivatives flat on the rectangle boundary. The angular flux V=(Vr,Vz) is r²(H_rtheta,H_thetaz); its exact capacities under (270),(272) are |Vr|≤(kappa/2)w and |Vz|≤(kappa/8)w, kappa=15971/122900.

**Theorem (smooth boundary-to-boundary angular lifting, special class).** If f=wF for F smooth on the closed rectangle with |F|≤L and ∫_{r-}^{r+} f(r,z)dr=0 for every z, then

```text
Vr(r,z)=∫_{r-}^r f(s,z)ds, Vz=0
```

extends by zero to a smooth *globally compact* flux with div V=f and

```text
|Vr|≤(L*(r+-r-)/2)w,  max(2|H_rtheta|,8|H_thetaz|)≤L*(r+-r-)*rho.
```

Thus L*(r+-r-)≤(1-sigma)kappa leaves the strict relative cone reserve sigma>0, **without any positive lower bound on rho**. Proof: (log p)'=2/x³−2/(1-x)³, so p increases up to 1/2 and decreases afterward. Integrate the bound |f|≤Lw from the nearer radial boundary; the exact slice cancellation allows integration from the right when x>1/2. The radial primitive and all derivatives vanish to infinite order at the flat edges. The final stress is smooth/compact as a function on the full ambient plane, with support permitted to touch the flat boundary of the model rectangle.

A concrete nonzero balanced example is F=lambda*(x−1/2), which has zero radial mean against symmetric p. Additionally, the source f=alpha*partial_r w has f/w unbounded as x→0,1 but admits the exact smooth compact solution Vr=alpha*w and cone cost 2|alpha|rho; bounded f/w is sufficient but not necessary.

## W.2. Adaptive flat-weight mollification preserving the cone margin

In normalized coordinates X=(x,y)∈(0,1)², set w0=p(x)q(y). For any nonnegative smooth unit-mass mollifier eta supported in the unit disk, define a **variable radius**

```text
epsilon_c(X)=c[x(1-x)y(1-y)]³,    0<c≤1/8;
TcV(X)=∫eta(u) V(X−epsilon_c(X)u) du.
```

**Proposition (pointwise weighted smooth approximation, not divergence preservation).** If |Vr|≤(1−sigma)(kappa/2)w0 and |Vz|≤(1−sigma)(kappa/8)w0, then TcV extends by zero to C_c∞(R²) and

```text
|TcVr|≤(1−sigma)exp(16c)(kappa/2)w0;
|TcVz|≤(1−sigma)exp(16c)(kappa/8)w0.
```

Choosing c≤(1/16)log((1−sigma/2)/(1−sigma)) retains relative reserve sigma/2 at the **entire flat boundary**. Proof: with d(X)=min{x,1−x,y,1−y}, epsilon_c≤c d³ and epsilon_c/d≤c/4. On each sampling disk the log-weight derivative bound is 8/(d−epsilon_c)³, yielding |log(w0(X−epsilon_c u)/w0(X))|≤8c/(1−c/4)³≤16c. Derivatives of TcV are bounded by w0 times inverse polynomial powers of d, so all vanish to infinite order by flat exponential domination. This extends the weighted *regularity* part of Appendix V to the model boundary, **not** its exact divergence result.

**Exact divergence commutator.** For a weak flux satisfying div V=f, in dimension 2,

```text
div(TcV)=Tc f−Ec[V],
Ec[V]=(grad epsilon_c/epsilon_c) ·
        ∫V(X−epsilon_c u)[2eta(u)+u·grad eta(u)]du.
```

The elementary bound is only |Ec[V]|≲w0/d near the boundary; it is smooth and absolutely flat, but not a small multiple of w0. The missing step is a *cone-controlled compact weighted divergence inverse for this commutator*. Hence no global smooth lift from an **arbitrary** bounded weak flux has been established.

## Prior art and verification

Variable-step mollifiers are established in Hintermüller, Papafitsoros and Rautenberg, [*Variable Step Mollifiers and Applications*](https://doi.org/10.1007/s00020-020-02608-2) (2020). Weighted divergence equations have prior work including A. Huber, [*The divergence equation in weighted- and L^{p(.)}-spaces*](https://doi.org/10.1007/s00209-009-0622-8) (2011). We do not claim novelty for those general methods. The result here is a scoped explicit flat-envelope cone calculation and source-class theorem.

[Independent exact replay](../attack020/verify_flat_boundary.py) passes symbolic log-concavity, radial balance, rational cone reserve, quantitative adaptive distortion, the polynomial variable-width commutator identity, and flat exponential extension. [Lean finite algebra](../../../NewtonConjectures/Case006FlatBoundaryAdaptive.lean) encodes only rational cone/reserve and finite pointwise identities: the Hardy integral theorem, analytic variable-width smoothing and H8 PDE are **not formalized in Lean**. The GitHub CI kernel status must pass before any corresponding Lean verification claim.

**Remaining open:** The original physically admissible complete g,rho and full seven-ray transport are still unfrozen. The restricted slice-balanced model is not a frozen source-native example; the general weighted commutator correction, three meridional equations, exact physical slice (249), cone positivity (272), compact weighted inverse (273), and unforced Navier–Stokes singularity remain unresolved.
