# Appendix U. Exact weak duality for the angular H8 cone equation

Research continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The typeset 2-page Appendix U is included as pages **99–100** in the cumulative main manuscript; all first 98 pages are preserved text-identically.

## The mathematical question

The original H8 source manuscript leaves the final complete prepared Navier–Stokes source g, its envelope rho, and chi/G profiles unfrozen. Consequently **no actual physical Mg/R2 has been computed** and no pointwise H8 cone verdict is possible from those inputs. Appendix S proves an axial cumulative torque necessary band, and Appendix T gives a stronger radial–axial virtual-work inequality. Here we prove that the entire family of Appendix T dual tests is **exactly sufficient** for bounded weak *angular-sector* solvability, using standard functional analysis. We also identify a new rigidity at angular-cone saturation.

## Theorem (sharp angular-sector weak equivalence)

Let Omega be a bounded annular rectangle in the (r,z)-plane, with r bounded away from zero, and let smooth compactly supported axisymmetric `h_theta` and nonnegative `rho` be given. Put
```text
kappa=15971/122900, a=kappa/2, b=kappa/8,
f=r² h_theta, w=r² rho.
```
Then the following are equivalent:

1. There exist measurable essentially bounded `C=H_rtheta` and `B=H_thetaz`, supported in `supp rho`, such that in distributions
```text
partial_r (r² C) + partial_z(r² B) = f,
|C| <= (kappa/2)rho, |B| <= (kappa/8)rho.
```
2. For **every** compact smooth scalar test function `psi(r,z)`,
```text
|∬ f psi dr dz|
<= ∬r²rho [ (kappa/2)|partial_r psi|
          +(kappa/8)|partial_z psi| ]dr dz.
```

Under (1), choosing the four-field H8 correction `A=D=0` gives **the exact joint seven-ray coefficient cost**
```text
C(H)=max(2|C|,8|B|) <= kappa rho,
```
so the separate component constraints cause no hidden angular-sector compatibility issue.

**Proof.** Necessity is compact integration by parts. For sufficiency, define `T(psi)=(a*w*psi_r,b*w*psi_z)` into the Banach space `X=L1(Omega)⊕_1L1(Omega)`. The dual inequality makes `ell(T psi)=-∫f psi` a well-defined linear functional with norm <=1 on `T(Cc∞)`. Hahn–Banach extends it to X with norm <=1; the standard `L1–L∞` duality represents it by `(u,v)∈L∞⊕_∞L∞` with |u|,|v|<=1. Define `V_r=aw u`, `V_z=bw v`; their distributional divergence equals f. Because w has compact support and r>0, `C=V_r/r²`, `B=V_z/r²` are bounded and compactly supported. This proves sufficiency without asserting smoothness. The criterion also implies ∫f=0 and that f vanishes on every open region where rho vanishes.

**Prior art/status.** Hahn–Banach and L1–L∞ duality are standard established results. The contribution here is their exact sharp-capacity specialization to the **actual H8 seven-ray angular sector** and an explicit verification protocol. There is no claim of novelty for general weighted divergence duality.

For **nonaxisymmetric** source fields, the same theorem applies to the angularly averaged equation; it does **not** solve nonzero angular Fourier modes.

## Exact rational 2×2 grid screening

A four-node radial–axial grid has radial edge capacity `a=kappa/2` and axial edge capacity `b=kappa/8`. Place a source `+q` at the lower inner vertex, `-q` at the lower outer vertex, and zero at the other two. All axial slice source sums equal zero for every q. But the cut isolating the positive corner has capacity `a+b=5kappa/8`. At q=kappa the exact violated cut margin is `3kappa/8>0`: a radial dual obstruction that every axial-only test misses.

At q=kappa/4 the one radial edge carries q within its `a=kappa/2` capacity, giving an **explicit primal feasible flow**. Exhaustive rational checks verify all 15 nonempty vertex-subset cut inequalities for this example. Max-flow/min-cut is standard; this finite graph is a screening analogy, **not** a rigorously convergent discretization of the full Navier–Stokes PDE.

## Endpoint rigidity in the original H8 four-field cone

For Appendix T's smooth manufactured source `f=alpha*partial_r(r²rho)`, the angular correction `C=alpha rho`, `B=0` is smooth and compact, and exists within the sharp cone budget exactly when `|alpha|<=kappa/2`. At *positive saturation* `alpha=kappa/2`, every angular correction satisfying the cone must obey `C=(kappa/2)rho` almost everywhere on `{rho>0}`, since a radial test with `psi_r=1,psi_z=0` on the support saturates the nonnegative integral of `(kappa/2)rho-C`. The **original full four-field** coefficient inequalities `|2C-4D|,|-2C-4D|<=kappa rho` then force `D=0` on that region. Thus saturating the angular budget removes one meridional degree of freedom, a further obstacle to fitting remaining tensor equations.

## What is and is not established

Appendix U **solves the angular equation only in the compactly supported bounded measurable (distributional) category**, conditional on all dual tests. It does not upgrade to smooth weighted stress, certify a cone margin strictly inside kappa, solve the remaining three meridional tensor equations, provide compact pressure/patch gluing, or establish slice (249), cone (272) for the genuine full source, or weighted inverse (273). The full H8 compact inverse and unforced Navier–Stokes singularity remain open.

[Exact independent checker](../attack018/verify_angular_weak_duality.py) replays all exact rational capacities/cuts, model flows, manufactured divergence identities and sharp cone thresholds. [Lean finite algebra](../../../NewtonConjectures/Case006AngularWeakDuality.lean) checks only rational cut/capacity, joint angular norm and algebraic saturation rigidity. **The Hahn–Banach analytic theorem is not Lean formalized**, and new GitHub Actions kernel CI must complete before these finite algebraic fragments are called Lean-certified.
