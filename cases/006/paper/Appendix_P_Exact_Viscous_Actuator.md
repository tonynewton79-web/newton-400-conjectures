# Appendix P. Exact viscous compatibility of the torque-active shell actuator

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). The fully typeset two-page Appendix P is incorporated into the **90-page** cumulative manuscript (the preceding 88 pages are text-identical). This is a scoped result about the exact torque operator (251), not a compact weighted H8 inversion theorem.

## The question and the exact source equation

Appendix O identifies the torque to compensate the *moving cylindrical* cone baseline. The original source's (251) retains axial viscosity, whereas its approximate actuator ODE (253) discards that term. Put

```text
B(eta)=D eta M(eta)+N(eta),  D=1/2-h,
gamma=3/2-2h>0,  delta=nu*epsilon²>0,
L_delta[A] = (B A)' - gamma M A - delta(M A)''.
```

The source identity is `q^h m_T=L_delta[A]`. If the complete source torque is `m_s=m_base+m_T-b_theta*b_z R2'(z)` as in Appendix O, then exact compensation requires, with `eta=z q^{-D}`,

```text
L_delta[A](eta)=f(eta)
=q^h [ b_theta*b_z R2'(q^D eta)-m_base(q^D eta)].
```

Neither `m_base` nor the final radial profiles `M,N` are frozen in the original manuscript; do not replace them by zero or constants in a claim about the actual source.

## Theorem: the exact compact range has two compatibility constraints

Let `I=[a,b]`, with `M,B` smooth and `inf_I |M|>0`, `delta>0`. Every `A∈C_c^infty((a,b))` satisfying `L_delta[A]=f` obeys

```text
int_I phi_1 f = int_I phi_2 f = 0
```

for any fundamental pair of adjoint solutions of

```text
delta M phi'' + B phi' + gamma M phi = 0.
```

Conversely if `f` is smooth and compact inside I and both pairings vanish, there is a smooth compact `A` solving the equation. The compact range therefore has codimension exactly two on such an interior interval.

**Proof.** The formal adjoint is `L_delta* phi=-B phi'-gamma M phi-delta M phi''`. The exact Green identity

```text
phi L_delta[A]-A L_delta*[phi]
= d/deta { B A phi -delta[phi (M A)'-phi' M A] }
```

gives the two necessary moments when A is compact. Conversely set `y=M A`, solve the regular second-order inhomogeneous initial-value problem

```text
-delta y'' +(B/M*y)' -gamma y = f,  y(a)=y'(a)=0.
```

At b the Green boundary form against two independent adjoint solutions determines (y(b),y'(b)) invertibly. Thus the two vanishing pairings force both terminal values to vanish; since f vanishes near both ends, uniqueness implies compact support for y and then for A.

The paper's first-order approximation (253) at delta=0 has one compatibility condition (254); it does **not** prove compact solvability of the exact delta>0 operator. In the small-viscosity limit the extra adjoint solution can be a fast mode.

## A sign obstruction for a pure compact envelope derivative

If `gamma>0` and `M>0` on I, integration over I of the compact exact equation gives

```text
int_I f = -gamma int_I M A.
```

A target consisting **only** of `f=kappa R'(eta)` with smooth compact nonnegative R has integral zero. Thus a nonzero A of one fixed sign cannot match it. This remains true with or without the viscous term. The real torque target includes the unfrozen background term and could be obtained by a sign-changing actuator; neither is ruled out.

## Exact counterexample to first-order compatibility sufficiency

For an illustrative constant-coefficient interior model (NOT a constructed source-native H8 profile), choose

```text
h=1/12, gamma=4/3, M=1, B=101/75, delta=1/75.
```

The adjoint characteristic polynomial is `(lambda+1)(lambda+100)/75`. The two independent modes `phi1=exp(-eta)`, `phi2=exp(-100eta)` have Wronskian `-99exp(-101eta)`. For **every** smooth nontrivial `R>=0` compact in (0,1) and `f=kappa R'`, kappa>0,

```text
int exp(-eta) f = kappa int exp(-eta) R >0,
int exp(-100eta) f =100 kappa int exp(-100eta) R >0.
```

So zero total torque alone is insufficient to produce a compact amplitude. Two disjoint positive *arbitrary forcing* profiles can span the two compatibility moments since `phi2/phi1=exp(-99eta)` is strictly decreasing. This does **not** prove that two *source-native toroidal actuator variations* are available, nor that the weighted cone budget survives their use.

## Precise next H8 gate

Freeze the physical `M,N,G` and complete `m_base` and compute the exact adjoint Cauchy pair for Eq. (251), including its viscous coefficient. Certify the two pairing columns for actual admissible torque-active actuator controls, compatibility with the envelope derivative and the required **scale-smallness** (249), not necessarily exact neutrality. Then test compact support, moving pressure, full torque/meridional moments and the seven-ray coefficient floor (272). Neither (273) nor any Navier–Stokes singularity theorem follows here.

[Exact SymPy/rational replay](../attack013/verify_exact_torque_viscosity.py) verifies both operator/adjoint identities, two independent exact modes, the positive-envelope derivative obstruction, compact polynomial amplitude compatibility and strict two-column rank for unconstrained separated source shapes. [Lean finite-algebra fragment](../../../NewtonConjectures/Case006ExactViscousActuator.lean) formalizes jet expansion, the formal Green polynomial identity and proxy characteristic factorization. The differentiable ODE and integral proof are not end-to-end formalized in Lean, and the new GitHub kernel build must pass before any kernel-verification claim.
