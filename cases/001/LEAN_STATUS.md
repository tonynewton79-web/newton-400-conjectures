# Case 001 — Lean 4/mathlib verification ledger

## Stage 3: cyclic Gram entries — KERNEL VERIFIED

Authoritative successful run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39128814226

- Lean v4.24.0; mathlib pinned with the repository's dependency lockfile.
- Complete Lean build passed: 7,356 jobs.
- `axiom-audit`: 74 declarations; all within the standard allowed foundation set `propext`, `Classical.choice`, `Quot.sound`.
- No proof placeholders (`sorry` or `admit`) permitted by CI.

The universally quantified matrix result is in
[`NewtonConjectures/CyclicGram.lean`](../../NewtonConjectures/CyclicGram.lean).

For `n>0`, `2*j≤n`, and *every* `u,v : ZMod n`, with
`B_j[u,k]=1` iff `(k-u).val < j`, and `d(u,v)` the least of the two
directed cyclic distances:

```
(B_j * B_jᵀ)[u,v] = (max(j - d(u,v), 0) : ℚ).
```

The Lean source states the right-hand side as `((j - cyclicDistance n u v : ℕ) : ℚ)`.
Natural subtraction is truncated subtraction, so this is exactly
`max(j - d(u,v), 0)`, without an unproved arithmetic conversion.

The proof has three intermediate kernels:

1. [`CyclicIntersection.lean`](../../NewtonConjectures/CyclicIntersection.lean):
   the exact canonical overlap count for any half-cycle-sized arcs,
   including antipodal boundary, wraparound and disjoint cases.
2. [`CyclicZMod.lean`](../../NewtonConjectures/CyclicZMod.lean):
   explicit finite-ring equivalence, translation to arbitrary vertex basepoints,
   and reflection to undirected distance.
3. [`CyclicGram.lean`](../../NewtonConjectures/CyclicGram.lean):
   an actual `Matrix.mul` of a cyclic incidence matrix and its transpose,
   not merely an informal intersection-count interpretation.

## Earlier verified stages

- Exact rational odd/even base case margins for C15 and C16.
- Reciprocal rational second-difference identity and positive coefficients.
- Universal finite-difference telescoping for every `f : ℕ → ℚ`.
- Explicit all-integer reciprocal-distance tent coefficient identity.
- Abstract nonnegative Gram quadratic forms.

## Remaining BEFORE a complete Lean theorem

- [ ] Prove the full matrix equality `R_n + 3/2*I = 1/m*J + ∑ w_j B_j B_jᵀ`:
  assemble these *kernel-verified ingredients*, handle the diagonal sum and
  the endpoint/antipodal conventions.
- [ ] Prove a cycle-specific spectral lower bound from this identity.
- [ ] Formalize ordering/multiplicities of cycle adjacency eigenvalues.
- [ ] Formalize the monotonicity and harmonic-number comparisons for both parities.
- [ ] Formalize the finite converse C3..C14.
- [ ] Independent mathematical literature/priority audit and specialist review.

**Status:** CANDIDATE — PARTIAL_FORMAL_CERTIFICATION.
This file does **not** claim that the complete Graffiti 197 family theorem has been kernel-certified or externally accepted.


## Stage 4: all-cycle weighted Gram diagonal — KERNEL VERIFIED

[Passing GitHub Actions run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39130358760), using Lean 4.24.0/mathlib.

- Full project build: **PASS** (7,357 jobs)
- `axiom-audit`: **PASS** (91 declarations, only `propext`, `Classical.choice`, `Quot.sound`)
- Explicit proof-placeholder scan: **PASS** (no `sorry` or `admit`)
- Source: [`NewtonConjectures/GramDiagonal.lean`](../../NewtonConjectures/GramDiagonal.lean)

For every integer `m ≥ 2`, the kernel proves the exact rational identity

```
1/m + ∑_{j=2}^{m-1} 2/((j−1)(j+1)) + 1/(m−1) = 3/2.
```

The kernel additionally proves that the **actual matrix expressions**
formed with cyclic incidence matrices and the paper's piecewise weights
obey the corresponding diagonal value for every `n ≥ 4` and
every vertex `u : ZMod n`.

This advances the matrix-identity programme but does not prove the full
all-entry weighted identity for `u ≠ v`: the certified reciprocal tent
kernel must still be explicitly assembled into the weighted sum over
all `j = 2, …, ⌊n/2⌋`, including the truncated natural subtraction
and antipodal case. The spectral bound, final graph-theoretic cycle
inequality and finite converse are not yet fully formalized.
