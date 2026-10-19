# Appendix G. The four-field H8 operator: symbol estimates and a sharp dual test

*Continuation of* Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [doi:10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). This source accompanies the cumulative PDF, which consists of the original 65-page manuscript followed by the four-page typeset Appendix G. A LaTeX source of the typeset appendix is included in the release sent to the author.

The spatial attachment of Section 9 requires a compact stress with the source's projected divergence, suitable moments and a strict weighted cone margin. The algebraic stress frame admits a sharp quantitative analysis, but the corresponding compact weighted inverse remains to be constructed. The exact symbol and dual results below identify two necessary structural features without presupposing the unresolved inverse.

## G.1. The operator, with and without pressure

For four scalar fields set

```
      [-D C A]
H  =  [ C 0 B],     L(A,B,C,D,p) = div H + grad p.
      [ A B D]
```

For Fourier covector xi=(x,y,z), its principal-symbol matrix (with columns A,B,C,D,p and the common Fourier factor i omitted) is

```
          [z 0 y -x x]
M(xi) =   [0 z x  0 y].
          [x y 0  z z]
```

Write M0 for the first four columns. Direct Gram multiplication and an exact determinant calculation give

```
M0 M0ᵀ = [ x²+y²+z²    xy          0
           xy           x²+z²     yz
           0             yz        x²+y²+z² ],

det(M0 M0ᵀ) = (x²+z²)² (x²+y²+z²).
```

For nonzero xi the **ungauged symbol** has full row rank precisely when (x,z) ≠ (0,0). It is characteristic along the punctured y-axis. This proves that the pressure column is mathematically essential to the uniform rank bound in this restricted four-field ansatz.

## G.2. Sharp augmented-symbol coercivity

**Theorem.** For every real xi=(x,y,z), v=(a,b,c), the exact identity is

```
||M(xi)ᵀv||² − |xi|²|v|²/5
 = (4/5)[(ya+xb)² + (yc+zb)² + (za−xc)²]
   + (1/5)[3(xa+zc)+2yb]².
```

**Proof.** The transpose action equals

```
(za+xc, zb+yc, ya+xb, −xa+zc, xa+yb+zc).
```

Expansion of the five squares and collection of like monomials proves the identity. Each term on the right is nonnegative, so `||M(xi)ᵀ v||² >= |xi|²|v|²/5`. The constant is sharp: take `xi=(sqrt(2),sqrt(3),0)`, `v=(sqrt(2),−sqrt(3),0)`, when all right-hand squares vanish.

**Proposition.** The Gram determinant factors as

```
16 det(M Mᵀ) =
 |xi|²[7|xi|⁴+(3y²−5(x²+z²))²] >= 7|xi|⁶.
```

This follows by expanding `M Mᵀ`, whose entries are
```
[2x²+y²+z²   2xy             xz
 2xy          x²+y²+z²       2yz
 xz           2yz            x²+y²+2z²].
```

For xi nonzero, the matrix `T(xi)=M(xi)ᵀ[M(xi)M(xi)ᵀ]⁻¹` is therefore a right inverse with spectral norm at most `sqrt(5)/|xi|`. If `f` has zero spatial mean on the periodic three-torus, the Fourier prescription `Û(k)=−i T(2πk) f̂(k)`, with `Û(0)=0`, gives an abstract distributional solution of `div H+grad p=f` with `||U||_{H^{s+1}}<=sqrt(10)||f||_{H^s}`. This noncompact periodic right inverse does **not** control compact support or pointwise flat-envelope weights.

## G.3. The coefficient norm

At aperture 1/4 the seven coefficient perturbations from the source's equation (270) are

```
δc=(-3D/2, 2C−4D, −2C−4D, 2A−8B+4D,
     −2A+8B+4D, 8B, −8B).
```

Using the elementary identity `max(|u+v|,|u−v|)=|u|+|v|`, their maximum modulus is *exactly*

```
N(A,B,C,D) = max(8|B|, 2|C|+4|D|, 2|A−4B|+4|D|).
```

The first coefficient is redundant since `3|D|/2 <= 4|D|`. This reduces seven simultaneous inequalities to three without relaxing the cone.

## G.4. A sharp polar and a virtual-work obstruction

**Theorem.** For `k>=0` and any real linear load `(P,Q,R,S)`,

```
sup {AP+BQ+CR+DS : N(A,B,C,D)<=k}
 = k[|4P+Q|/8 + max((|P|+|R|)/2, |S|/4)].
```

**Proof.** Let `E=A−4B`. Then the functional becomes `EP+B(4P+Q)+CR+DS`, while the constraints reduce to `|B|<=k/8` and `|E|,|C| <= k/2−2|D|`. With `d=|D|`, the supremum equals

```
k|4P+Q|/8+(k/2−2d)(|P|+|R|)+d|S|,  0<=d<=k/4.
```

The expression is affine in `d`, and its maximizing endpoint is `d=0` or `d=k/4`. Choosing the signs of all four coefficients appropriately attains the displayed bound.

Let `rho >= 0` be a flat compact envelope and `kappa=15971/122900`. Suppose a compact correction exists with `N(H)<=kappa*rho` and `P_Leray div H=f`. For any smooth divergence-free periodic test field `phi`, define

```
P = ∂₃phi₁+∂₁phi₃,  Q=∂₃phi₂+∂₂phi₃,
R = ∂₂phi₁+∂₁phi₂,  S=∂₃phi₃−∂₁phi₁.
```

Integration by parts and the polar theorem yield the necessary condition

```
|∫ f·phi| <= kappa ∫ rho(x)
 [ |4P+Q|/8 + max((|P|+|R|)/2, |S|/4) ] dx.
```

An exact violation by even one divergence-free test field disproves the proposed compact coefficient budget **for that chosen pair (f,rho)**. Satisfaction of a finite collection of tests does not prove existence.

## G.5. Scope and reproduction

The principal-symbol identities, determinant factorizations and sharp finite-dimensional polar formula are exact. The source-independent Fourier estimate has no compact support. The original manuscript does not fix the localized shell profiles sufficiently to evaluate the H8 constant numerically. The next analytic task is to freeze a profile family, compute its projected residual and moments, evaluate the dual inequality with rigorously bounded integrals, and then either exhibit a dual obstruction or construct a compact weighted inverse. No global finite-energy Navier–Stokes singularity follows from the results above.

The rational symbol and dual tests are in `cases/006/attack002`, `attack003` and `attack004`. Kernel compilation of the Lean sources must be assessed from the recorded Actions build, not inferred from source syntax.
