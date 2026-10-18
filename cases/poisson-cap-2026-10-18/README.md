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

**Not yet in Lean**:

1. formalization of the normalized Euclidean Poisson kernel on the sphere and its positivity / mass 1;
2. its harmonicity and differentiation under the integral;
3. the integral of the pointwise cap score leading to D*dp > n*p;
4. actual construction of the bounded harmonic u_n and the full refutation quantified over all n;
5. prior-art/novelty verification, which cannot be performed by Lean.

The `hderiv` premise of the algebraic theorem is the outstanding analytic bridge. Its appearance as an explicit theorem hypothesis is deliberate. A green GitHub Actions check for this lane proves **only** the stated algebraic lemmas.

## Run

Using this repository's locked Lean/mathlib setup:

```bash
lake exe cache get
lake env lean NewtonConjectures/PoissonCapGate.lean
```

The root `NewtonConjectures.lean` imports this file so the existing GitHub Actions `lean.yml` builds it with the other modules.

**Scientific status**: partial Lean formalization; full Poisson harmonic-function theorem still awaiting certification. No `sorry`, `admit` or custom axiom is needed for these gates. External mathematical priority remains unestablished.
