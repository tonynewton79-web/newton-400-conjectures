# Appendix M. Fourfold symmetry suffices for quadratic adjoint moments

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [Zenodo DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). The complete two-page typeset Appendix M appears on pages 83–84 of the cumulative manuscript. The original 82 pages are preserved without edits.

## Motivation and an exact representation theorem

Appendix L projected tilted quadratic adjoint fields against an SO(2)-axisymmetric source. The localization in the underlying construction uses fourfold C4 symmetry instead. We establish that **SO(2) is not needed for the quadratic moment projection**, even though it remains a stronger condition for the full underlying PDE source. The frame still has to be fixed in one common physical chart.

Let R_phi be axial rotation about physical z, acting on *vector* polynomials by

```text
(U_phi q)(X) = R_phi^T q(R_phi X).
P4 q = (1/4) sum_{k=0}^3 U_{k*pi/2} q.
Pinf q = (1/2pi) integral_0^{2pi} U_phi q dphi.
```

**Theorem.** For every vector polynomial q: R³→R³ of total degree at most 2,

```text
P4 q = Pinf q.
```

Their image is precisely the eight-dimensional space

```text
qbar = (alpha*x+beta*y+gamma*x*z+delta*y*z,
        -beta*x+alpha*y-delta*x*z+gamma*y*z,
        e0+e1*z+e2*z²+e3*(x²+y²)).
```

**Proof.** Expand each component of q in the ten monomials 1,x,y,z,x²,xy,xz,y²,yz,z², with coefficient vectors u,v,w. Direct fourfold averaging gives

```text
alpha=(u_x+v_y)/2, beta=(u_y-v_x)/2,
gamma=(u_xz+v_yz)/2, delta=(u_yz-v_xz)/2,
e0=w_0, e1=w_z, e2=w_z², e3=(w_x²+w_y²)/2.
```

Each field in the displayed normal form is equivariant under all axial rotations. Therefore Pinf(P4 q)=P4 q. Any SO(2)-equivariant field is automatically C4-equivariant, giving P4(Pinf q)=Pinf q. The averages commute, so the equality follows. The eight coefficients are independent. In contrast, q=(x²−y²,−2xy,0) is C3-equivariant but not SO(2)-equivariant, demonstrating that threefold symmetry cannot replace C4 for general quadratic vector fields.

## Consequence for fixed tilted H8 sources

Keep the fixed frame R=R_x(c,t), c²+t²=1, with cone-centre tensor Rstar^R and rotated quadratic adjoint fields q_i^R. As in Appendix L define

```text
E=(xz,yz,-z²), F=(-yz,xz,0), G=(0,0,x²+y²),
A=integral g·E, B=integral g·F, C=integral g·G,
Z=integral z*rho, kappa=1217/1229.
```

Suppose the **complete** compact unprojected source g is equivariant under the physical quarter-turn and rho is a quarter-turn invariant scalar, with support in the common physical chart. Define s=g−div(rho Rstar^R). Applying the theorem to q_i^R recovers **the exact same three moment transfer as Appendix L**:

```text
( integral s·q1^R )   ( t(3t²−1)/2      0  −t(5−3t²)/4 ) ( A )     ( t   )
( integral s·q2^R ) = ( 0              −3ct       0    ) ( B ) + kappa Z ( 0   ).
( integral s·q3^R )   ( c(1−3t²)       0  −c(1+3t²)/2 ) ( C )     (−2c  )
```

The baseline follows because Rstar:diag(1,−2,1)=kappa, and the C4 average of the linear scalar adjoint strains f_i(R^T X) equals (tz,0,−2cz).

For ct(1−3t²)≠0, all three quadratic moments vanish if and only if

```text
B=0,   C=0,   (1−3t²)A=2*kappa*Z.
```

Only C4 symmetry of g and rho is used. With the angularly averaged source torque

```text
m0(z) = (1/2pi) integral_phi integral_r r² g_theta(r,phi,z) dr dphi,
```

one has B=2pi integral z*m0(z) dz and integral g·q2^R=−6pi*c*t integral z*m0(z) dz. Exact averaged slice-torque neutrality of the *complete* source kills the second moment; neutrality of a selected shaper does not establish neutrality of the entire source. The source may have nonzero Fourier harmonics of angular order 4,8,... without altering these quadratic moment identities.

## Quantitative error when C4 covariance fails

If the source and envelope are only approximately C4-equivariant, let g4=P4 g (vector action) and rho4=P4 rho (scalar action), with supports inside the ball |X|≤L. Define s4=g4−div(rho4 Rstar^R). The explicit adjoint fields and strains satisfy |q_i^R(X)|≤3|X|² and |f_i(R^T X)|≤2|X|, so for each i=1,2,3:

```text
|integral (s−s4)·q_i^R|
 <= 3L² ||g−g4||_L1 + 2*kappa*L ||rho−rho4||_L1.
```

This gives a rigorous symmetry-leakage bound on the quadratic moments. A small right-hand side does not establish exact cancellation.

The result sharpens Appendix L's symmetry caveat **only at the degree-two moment level**. It does not certify full source C4 equivariance after moving-frame transport and patch gluing, source-native moment response rank, slice-torque neutrality, compact weighted H8 inversion or finite-energy unforced Navier–Stokes blow-up. Those remain the outstanding analytic gates.

### Reproduction and formal scope

The independent exact [30-coefficient checker](../attack010/verify_c4.py) verifies the universal normal form, two exact rank-eight invariant subspaces, all three tilted H8 projections and the C3 counterexample. The [Lean algebraic candidate](../../../NewtonConjectures/Case006C4Quadratic.lean) formalizes the 30-coefficient fourfold polynomial projection identities and the normal form's quarter-turn covariance. It does **not** formalize the Lie-group averaging integral or the PDE corollary. The candidate remains unverified until the GitHub Lean build and axiom audit succeed.
