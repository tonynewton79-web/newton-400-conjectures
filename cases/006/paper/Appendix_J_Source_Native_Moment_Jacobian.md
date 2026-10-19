# Appendix J. The source-native quadratic-moment Jacobian and a conditional symmetry rank obstruction

Tony Newton — continuation of *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). Typeset in the author's four-page Appendix J, appended after Appendix I in the cumulative 79-page manuscript.

The previous results classify the ten-dimensional smooth adjoint kernel of the restricted four-field H8 operator and identify the three additional quadratic moments. The genuine remaining problem is whether *admissible variations of the source-native shell preparation* can remove those three moments without damaging force, torque, affine moments, slice-torque cancellation, support, production, or the weighted seven-ray cone. The manuscript fixes no actual normalized smooth profiles beyond classes of allowed shapers (notably equations (193)–(194), (250)–(252), (269)–(273)). Accordingly we derive the exact Jacobian, without inventing its numerical entries.

## J.1. Exact stress-centre coupling

In a fixed orthonormal chart, let

```
H(A,B,C,D)=[-D C A;C 0 B;A B D],  T=diag(1,-2,1).
```

The three quadratic fields from Appendix H are

```
q1=(xy,-(x²+2y²+z²)/2,yz)
q2=((x²+2y²-z²)/2,-2xy,xz)
q3=(-2xz,4yz,x²-2y²-z²).
```

They satisfy `sym grad qi = fi T`, with `(f1,f2,f3)=(y,x,-2z)`. Proposition 9.22 of the source gives

```
Q0=[317/43 35/86 0;35/86 47/172 0;0 0 1/4],
Rstar=(172/1229)(Q0 - trace(Q0)*I/3).
```

Since `trace(T)=0`, exact rational arithmetic yields the coefficient

```
Rstar:T = (172/1229)(317/43 - 2*47/172 + 1/4) = 1217/1229.
```

This is an *exact fixed-frame coefficient*, not a guessed numerical profile constant.

## J.2. The genuine Jacobian formula under stated source assumptions

Assume a divergence-free smooth velocity family `U_alpha` and a compact flat-envelope family `rho_alpha` with variations supported in the same fixed chart. Consider the following **explicit source model**:

```
s_alpha = ∂t U_alpha + div(U_alpha ⊗ U_alpha)
          - nu Δ U_alpha - div(rho_alpha Rstar).
```

The source actually prepared in H8 is denoted `g`; if it includes further correction terms, they must be included in the variation separately. Write

```
Vj = (∂/∂alpha_j) U_alpha at alpha=0,
rj = (∂/∂alpha_j) rho_alpha at alpha=0,
Jij = (∂/∂alpha_j) ∫(s_alpha-s_0)·qi at alpha=0.
```

**Theorem (exact first variation).** Provided the perturbations are compactly supported and divergence-free, and differentiation may be interchanged with integration,

```
Jij = d/dt ∫ Vj·qi
      -2∫ fi [U1 Vj,1 - 2 U2 Vj,2 + U3 Vj,3]
      +(1217/1229)∫ fi rj.
```

There is no explicit viscous term. Indeed, integrating twice gives `∫ ΔVj·qi=∫ Vj·Δqi`; the Laplacians of q1,q2,q3 are constant `(0,-4,0),(2,0,0),(0,0,-4)`, and a compactly supported divergence-free vector field has zero componentwise integral. For convection, `sym grad qi=fiT` yields the factor 2. The envelope contribution is the exact rational contraction from J.1. All integrals here are of **compact source differences**, not generally integrable background fields.

For the more general unprojected compact H8 source `s_alpha=g_alpha-div(rho_alpha Rstar)`, the unquestionably applicable identity is

```
Jij = ∫ (∂g_alpha/∂alpha_j)|0 · qi
      +(1217/1229)∫ fi rj.
```

It is this version that must be evaluated if `g_alpha` is not literally the preceding Navier–Stokes residual. A varying frame `Rstar_alpha`, pressure convention or source-support chart entails additional derivatives, which cannot be omitted.

## J.3. Conditional half-turn rank obstruction

Fix `S=diag(-1,-1,1)` acting in the **same chart and fixed stress frame**. The three adjoint fields have exact parities

```
S q1(Sx) = -q1(x),
S q2(Sx) = -q2(x),
S q3(Sx) =  q3(x),
```

and `S Rstar S = Rstar`. If every compact source `s_alpha` in the parameter family is even/equivariant, `s_alpha(Sx)=S s_alpha(x)`, on an S-invariant support, its q1 and q2 moments vanish identically. Thus the first two Jacobian rows are zero and

```
rank(J) <= 1,   det(J)=0.
```

In an S-even background, the pattern with two **odd** perturbations and one **even** perturbation is

```
J = [a b 0; c d 0; 0 0 e],   det J = e(ad-bc).
```

Hence two independent odd channels and a nonzero even channel are necessary *within this shared-frame symmetry design*. This is a structural actuator selection rule, not evidence that the original paper's actual tilted, rotated H8 frame has this same symmetry.

**Frame limitation.** The unforced-core physical quarter-turn acts about its axis. The cone basis in equations (258)–(260) is tilted and carried between patches. One cannot apply the fixed-frame half-turn rank theorem to the physical construction until the transformed source, pressure and envelope fields have been written in a common chart. In particular no singularity of the *actual* moment Jacobian has been proved.

## J.4. Open source-native evaluation

The source manuscript provides axisymmetric toroidal and poloidal shapers (193)–(194) and the exact toroidal slice-torque operator (250)–(252), including the neutrality condition `M(eta)=N(eta)=0`. It intentionally leaves `Phi_theta, Phi, Xi` as arbitrary smooth normalized supported profiles and does not fix three source-native admissible variations with all other H8 properties. The previous artificial second-derivative correction lemma cannot substitute for such actual variations.

The next proof task is to freeze physically admissible variations, compute every term of the exact Jacobian including any missing derivative of the prepared `g_alpha` and the rotated frame, certify all ten adjoint moment conditions, and obtain a **rigorous nonzero lower bound for |det J|**. Even then, the compact weighted bound `C(H) <= (15971/122900)rho` and the global unforced finite-energy Navier–Stokes completion remain open.

**Exact checks:** [Python symbolic/rational replay](../attack007/verify_source_jacobian.py) verifies the stress contraction, 3 symmetric gradients, 3 Laplacians, 3 half-turn parities, and the 3 polynomial first-variation identities; 4,096 independent rational polarization cases pass. [Lean candidate file](../../../NewtonConjectures/Case006SourceJacobian.lean) formalizes the rational centre contraction and finite polynomial polarization, but not the integration-by-parts PDE theorem. New Lean kernel compilation is required before claiming formal certification.
