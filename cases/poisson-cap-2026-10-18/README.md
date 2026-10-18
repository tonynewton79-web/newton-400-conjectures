# Poisson-cap inequality — Lean 4 verification lane

Target: Question 1 of Khalfallah–Mateljevic–Purtic, *Results in Mathematics* **77** (2022), 167, DOI: https://doi.org/10.1007/s00025-022-01686-5.

Proposed inequality (claimed for every ordinary real harmonic u : B^n -> (-1,1), n >= 3):

    |grad u(x)| <= (n/2) * (1-u(x)^2)/(1-|x|^2).

**Working-note counterexample**: Poisson extension of the cap
E = {xi on S^{n-1} : xi_n > 49/50}, evaluated at a=e_n/2.

## Current formal gates

Source: [PoissonCapGate.lean](../../NewtonConjectures/PoissonCapGate.lean)

- `threshold_at_three`: rational 49/50 threshold at dimension 3.
- `cap_fraction_gt`: exact strict cap fraction > 16/9.
- `cap_score_gt`, `all_dimensions_cap_score`: score > n for each n >= 3 and every cap height > 49/50.
- `strict_violation_from_derivative`: *conditional* real-algebra implication from a strictly positive mass and the integrated derivative inequality.
- `cap_failure_algebra`: specialization to D=3/4 for integer n.
- `positive_measure_cap_average` in `PoissonCapIntegral.lean`: strictly positive continuous integral over an arbitrary nonzero measure with positive weights, under explicit integrability hypotheses. **Certified by the Lean kernel**.
- `parameter_integral_derivative_cap` in `PoissonCapDifferentiation.lean`: invokes mathlib's dominated differentiation theorem for a parameter integral and combines it with the strict integral gate. The concrete integrand identities and domination are **explicit assumptions**. Do not confuse this interface with proof of the concrete Poisson function.

**Not yet in Lean**:

1. formalization of the normalized Euclidean Poisson kernel on the sphere and its positivity / mass 1;
2. its harmonicity and differentiation under the integral;
3. identify the strict general integral theorem with the normalized spherical Poisson measure and its actual cap integrand (the strict abstract integration step is already proved);
4. actual construction of the bounded harmonic u_n and the full refutation quantified over all n;
5. prior-art/novelty verification, which cannot be performed by Lean.

The `hderiv` premise of the algebraic theorem is the outstanding concrete analytic bridge. A general dominated-derivative bridge is now separately formalized: its remaining work is to derive the hypotheses from the explicit Poisson kernel. Its appearance as an explicit theorem hypothesis is deliberate. A green GitHub Actions check for this lane proves **only** the stated algebraic lemmas.

## Run

Using this repository's locked Lean/mathlib setup:

```bash
lake exe cache get
lake env lean NewtonConjectures/PoissonCapGate.lean
```

The root `NewtonConjectures.lean` imports this file so the existing GitHub Actions `lean.yml` builds it with the other modules.

**Scientific status**: partial Lean formalization; full Poisson harmonic-function theorem still awaiting certification. No `sorry`, `admit` or custom axiom is needed for these gates. External mathematical priority remains unestablished.


## Concrete kernel gates still required

For `r` near `1/2`, `t = ξ_n`, and `n ≥ 3`, define
`K_n(r,t) = (1-r^2) * (1+r^2-2*r*t)^(-n/2)`.
At `r=1/2`, the kernel should satisfy
`K_n(1/2,t) = (3/4)*(5/4-t)^(-n/2)`, and
`(3/4)*∂_r K_n(1/2,t) = K_n(1/2,t) * S_n(t)`
with `S_n(t) = -1+(3*n/4)*(t-1/2)/(5/4-t)`.
These identities have NOT yet been proven in Lean.

To apply `parameter_integral_derivative_cap` to the actual sphere:
1. Choose `α` to be the cap subtype and `μ` to be restricted normalized spherical measure. Prove it has nonzero total mass.
2. Set `F(r,ξ)=K_n(r,ξ_n)` and `G(r,ξ)=∂_r K_n(r,ξ_n)`, and prove the explicit derivative identity and measurability.
3. On `2/5 ≤ r ≤ 3/5`, `-1 ≤ t ≤ 1`, show
   `1+r^2-2*r*t ≥ (1-r)^2 ≥ 4/25`; obtain an integrable constant derivative majorant. Then discharge the dominated differentiation theorem's hypotheses.
4. Supply the full-sphere mass identity `∫ P(x,ξ)dσ(ξ)=1`, cap and complement positive measure, and ordinary Euclidean harmonicity of the Poisson integral.
5. Only then claim the full quantified harmonic counterexample is kernel-certified.
