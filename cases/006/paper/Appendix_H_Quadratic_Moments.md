# Appendix H. Quadratic adjoint moments for compact four-field stresses

*Continuation of* Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* ([doi:10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142)). This addition follows the exact symbol and dual analysis of Appendix G in the cumulative Case 006 manuscript.

## H.1. Three additional divergence-free adjoint-null fields

Let
```
H(A,B,C,D)=[-D C A; C 0 B; A B D],    L(H,p)=div H+grad p.
```
The following three quadratic vector polynomials are divergence-free:

```
q1=(xy,-(x²+2y²+z²)/2,yz)
q2=((x²+2y²-z²)/2,-2xy,xz)
q3=(-2xz,4yz,x²-2y²-z²).
```

Their gradients, with rows corresponding to vector components, are

```
∇q1=[y x 0; -x -2y -z; 0 z y]
∇q2=[x 2y -z; -2y -2x 0; z 0 x]
∇q3=[-2z 0 -2x; 0 4z 4y; 2x -4y -2z].
```

Each gradient has trace zero and is annihilated in Frobenius pairing by the full restricted four-field H: for every real A,B,C,D and point (x,y,z),

```
H:∇qj = 0,  div qj = 0,  j=1,2,3.
```

These are direct polynomial identities, not numerical conjectures. They are reproduced by [exact symbolic checker](../attack005/verify_quadratic.py) and recorded in [Lean source](../../../NewtonConjectures/Case006QuadraticMoments.lean), whose build still requires an actual passing GitHub kernel log.

## H.2. New necessary moments

**Theorem (quadratic moment obstruction).** Suppose H has the displayed form and H,p are smooth compactly supported fields on R³. Then any source s=div H+grad p must satisfy

```
∫ s·q1 = ∫ s·q2 = ∫ s·q3 = 0.
```

**Proof.** Integration by parts on R³ gives `∫s·qj=-∫H:∇qj-∫p div qj=0`. Compact support justifies the absence of boundary terms.

In the local periodic Leray formulation, this remains applicable when s and H have support in a common injective torus chart with connected complement. If `P_Leray div H=P_Leray s`, then `div H-s` is a gradient compactly supported in the chart; its periodic scalar potential is constant outside the chart and can be normalized to vanish there. Lifting to R³ produces the compact-pressure formulation. The support/pressure hypotheses are necessary: a nonperiodized quadratic test field cannot be paired naively with an arbitrary nonlocal Leray-projected source.

## H.3. Explicit smooth compact counterexample to sufficiency of lower moments

Choose any smooth compact bump η with nonzero total integral. Define `s=(0,∂x²η,0)`. For every affine scalar polynomial l, `∫(∂x²η)l = ∫η (∂x²l)=0`. Therefore each component of s has zero total force and every first moment is zero; in particular all usual torque and trace-free affine moment conditions vanish.

But

```
∫s·q1 = ∫(∂x²η)[-(x²+2y²+z²)/2]
       = - ∫η !=0.
```

Thus there cannot exist compactly supported H and p with s=div H+grad p in the restricted four-field ansatz, despite complete cancellation of the lower-order moments.

This is a genuine counterexample to the **sufficiency of zeroth and first moments for arbitrary compact sources in the restricted H8 ansatz**. It is NOT a counterexample to the particular source-native H8 residual, whose quadratic moments have not been calculated.

## H.4. Implication for the unresolved H8 estimate

For a proposed frozen profile, form the *unprojected compact source after baseline subtraction*, and before attempting the weighted right inverse check the three new quadratic pairings, the previous lower-order moments, and the sharp dual inequality of Appendix G. A failure of any required quadratic moment is an exact no-go for that particular compact restricted ansatz (subject to the stated chart/pressure conditions). A pass leaves the compact weighted construction still open.

The original paper's H8 estimate `C(H) <= (15971/122900)rho` is not established by this result; the analytic, fixed-profile inverse and full Navier–Stokes implication remain unproved.
