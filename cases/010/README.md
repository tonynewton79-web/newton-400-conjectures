# Case 010 — degree-weighted spectral extremizers: Lean certificate audit

**Target.** Formalize the mathematical and exact-computational certificates accompanying Tony Newton's cumulative manuscript *Degree-weighted spectral extrema and their counterexamples*. The input audited package is `Independent_Spectral_Certificate_Audit_Package.zip`.

## What the current Lean source actually proves

- Nonnegativity of a monomial and of a finite sparse polynomial with nonnegative coefficients on the nonnegative rational orthant.
- The 2-by-2 strict Sylvester-minor criterion implies a nonnegative quadratic form.
- Three **actual**, small-order, componentwise positive integer Collatz–Wielandt witness inequalities: order-6 unicyclic winner, order-6 unicyclic outsider, and order-20 balanced diamond winner, including exact matrix-vector multiplication.
- A concrete four-vertex integer diamond-envelope numerator inequality for \(n=41\) and allocation \((18,18,1,0)\), evaluated from its defining factors in Lean, rather than accepting a copied decimal margin.

Source: [NewtonConjectures/Case010Spectral.lean](../../NewtonConjectures/Case010Spectral.lean). The [Case 010 workflow](../../.github/workflows/case010-lean.yml) compiles it on pull requests and records kernel checks.

## Unformalized obligations — do NOT claim these are Lean verified

1. Definition and validation of the general core-plus-leaf quotient matrix, its Perron root and the transfer of componentwise inequalities to spectral radius bounds.
2. The **25** four-variable diamond polynomial transformations: construction of each source expression, exact equality to its nonnegative coefficient expansion, and proofs that every coefficient is positive.
3. The 20,203 diamond finite remainder cases as Lean theorems, not external Python-only results.
4. Both K_(2,3) degree-12 polynomial identities and coefficient certificates inside Lean.
5. The 759,273 finite-order matrix inequalities as Lean checkable witnesses or verified computation.
6. The preexisting structural graph reduction, balancing lemmas, and final graph extremal statement.

External independent exact arithmetic reproduced these gates. That is not equivalent to proof-kernel formalization. Full original graph theorem remains `CANDIDATE` in the case registry until every required bridge is compiled and audited.

## Development conventions

- Lean 4.24.0, Mathlib v4.24.0 (root toolchain).
- Isolated branch and draft PR. Main stays unchanged until tests succeed and review.
- No `sorry`, `admit`, or extra axioms.
- A successful CI run only certifies the statements in the compiled Lean source.

## Reproduce

```bash
lake exe cache get
lake env lean NewtonConjectures/Case010Spectral.lean
lake build
```
