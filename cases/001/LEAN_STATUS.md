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


## Stage 5: universal off-diagonal weighted sum — KERNEL VERIFIED

[Actual Lean 4/mathlib kernel build](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39131413230): **PASS** (7,358 build jobs). The independent axiom audit accepted **100 declarations**, using only `propext`, `Classical.choice`, and `Quot.sound`. The workflow rejected proof placeholders.

Source: [`NewtonConjectures/OffDiagonal.lean`](../../NewtonConjectures/OffDiagonal.lean).

For **all** `m ≥ 2` and `1 ≤ d ≤ m`, the kernel proves
```
1/m + ∑_{j=2}^{m} cyclicGramWeight(m,j) * max(j-d,0) = 1/d.
```
The proof separates the `d=m` endpoint, the zero lower-range terms,
the interior weighted terms, and the terminal coefficient, then invokes
the previously certified `reciprocal_tent_identity`. Natural subtraction
formalizes `max(j-d,0)` exactly.

Independent Python Fraction replay: **7,259 cases**, all distances for
`m=2..120`, passing without floating-point arithmetic.

This completes the exact off-diagonal scalar-coefficient gate.
**The single all-entry matrix equality is still to be assembled and
kernel-verified as a distinct theorem**. The cycle-specific spectral
lower bound, adjacency eigenvalue ordering, and final counterexample
inequality are not yet formally certified.


## Stage 6: complete all-entry cyclic Gram matrix equality — KERNEL VERIFIED

**Certified GitHub run:** https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39133219628

- Lean 4.24.0 / mathlib: **PASS**, 7,359 build jobs.
- Trusted axiom audit: **PASS**, 113 declarations (only `propext`, `Classical.choice`, `Quot.sound`).
- Proof placeholder test: **PASS**, no `sorry` / `admit`.
- New file: `NewtonConjectures/FullGram.lean`.

The exact kernel-certified theorem `cyclic_shifted_reciprocal_eq_gram` states that for **all** `n≥4`, the rational matrices over `ZMod n` satisfy

```
shiftedReciprocalCycle n = weightedCycleGram n
```

where `shiftedReciprocalCycle` has diagonal 3/2 and off-diagonal reciprocal cycle distance, and `weightedCycleGram` equals the constant 1/m matrix plus the sum of the actual weighted incidence Gram matrices, m=n/2. The proof is one true equality between `Matrix (ZMod n) (ZMod n) ℚ` values, not just separate scalar analogies.

Separate lemma `cyclic_distance_positive_of_ne` proves denominator positivity off-diagonal; `cyclic_distance_le_half` bounds cycle distances by `n/2`. Both parity classes, wraparound and the even antipodal case are included.

**Still pending in Lean:** a real positive-semidefinite operator/spectral corollary and eigenvalue λ_min≥−3/2; the adjacency eigenvalue ordering; both infinite-family harmonic comparisons; and the exact finite converse for C3..C14. External priority and specialist review remain pending. This is not yet a full Lean kernel proof of Graffiti 197's sharp cycle theorem.


## Stage 7 — rational positive semidefinite shifted reciprocal-distance matrix — KERNEL VERIFIED

**Run:** https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39134282319

- `lake build`: **PASS** (7,360 build jobs).
- `axiom-audit`: **PASS** (125 declarations; only `propext`, `Classical.choice`, `Quot.sound`).
- No `sorry` or `admit` proof placeholders accepted.
- Formal module: `NewtonConjectures/SpectralPSD.lean`.

Lean theorem `shifted_reciprocal_cycle_psd` states for every n≥4 that the **actual rational matrix** `shiftedReciprocalCycle n` is `Matrix.PosSemidef`, using the theorem-level equality from Stage 6, positive piecewise coefficients and positive-semidefiniteness of rank-one / incidence Gram matrices. Also certified: `cyclic_gram_weight_nonneg`, `constant_cycle_matrix_psd`, `cyclic_incidence_psd`, and `weighted_cycle_gram_psd`.

This establishes xᵀ(R_n+(3/2)I)x≥0 for all rational vectors x in the appropriate finite dimension. Its extension to the corresponding real symmetric matrix, and the explicit Lean eigenvalue lower bound, require a real-matrix bridge. The ordering/multiplicity of adjacency cycle eigenvalues and uniform analytic comparisons remain to be kernel formalized. **The full Graffiti 197 theorem is NOT yet Lean-certified.**


## Stage 8 — real-matrix identity, PSD and nonnegative spectrum — LEAN KERNEL VERIFIED

**Run:** https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39139083900

- Lean 4.24.0 + pinned mathlib: **PASS**, 7,362 jobs.
- Axiom audit: **PASS**, 142 declarations. Only the foundational allowlist `propext`, `Classical.choice`, `Quot.sound`.
- Proof-placeholder scan: **PASS** (no `sorry`/`admit`).
- Modules: `NewtonConjectures/RealGram.lean` and `NewtonConjectures/RealSpectral.lean`.

Fully quantified theorems for every cycle size n≥4:

1. `real_weighted_cycle_gram_psd`: the actual **real-valued** positive weighted cyclic Gram matrix is PSD.
2. `real_gram_eq_cast_rational_gram`: exact equality with the entrywise rational-to-real cast of the certified Gram matrix.
3. `real_shifted_reciprocal_eq_gram`: this is the real-valued shifted reciprocal-distance cycle matrix.
4. `real_shifted_reciprocal_psd`: the actual shifted matrix is PSD over ℝ.
5. `real_shifted_reciprocal_spectrum_nonneg`: every spectral value of that real shifted matrix is nonnegative. In standard matrix notation, **spec_ℝ(R_n+(3/2)I) ⊆ [0,∞)**.

The spectral statement is kernel-verified; the familiar equivalent bound `λ_min(R_n) ≥ -3/2` follows by an elementary scalar-matrix spectral shift, but its explicit Lean theorem about the *unshifted* eigenvalues has not yet been added.

**Remaining final Lean proof goals:** cycle adjacency eigenvalue ordering and multiplicities, formal odd/even harmonic comparison from n≥15, exact finite converse C3..C14, and end-to-end formulation of the Graffiti violation inequality. The underlying Graffiti 197 conjecture was already refuted by Roucairol and Cazenave. Historical novelty is not independently approved; specialist review pending.

## Stage 9 — full odd/even rational harmonic comparison — KERNEL VERIFIED

- [Successful pinned Lean/mat​hlib run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39140710038): 7,363 build jobs, 180 audited declarations, only propext / Classical.choice / Quot.sound; proof-placeholder scan passed.
- New module: `NewtonConjectures/HarmonicComparison.lean`.
- `oddCycleUpper_step`: q_o(m+1) < q_o(m), for every m≥7.
- `evenCycleUpper_step`: q_e(m+1) < q_e(m), for every m≥8, via an exact rational bound on the even harmonic increment.
- `oddCycleUpper_base_exact`: q_o(7)=468/245, and `evenCycleUpper_base_exact`: q_e(8)=1907/1050.
- `oddCycleUpper_lt_boundary`: q_o(m) < 2-(22/105)^2 for every m≥7.
- `evenCycleUpper_lt_boundary`: q_e(m) < 2-(11/28)^2 for every m≥8.
- All above are fully universal exact rational theorems, not finite sample tests.

**Remaining end-to-end Lean work:** formal adjacency matrix cycle eigenvalues and second-smallest order/multiplicity; rigorous cosine lower bound with π interval and monotonicity; direct spectral-span combination; formal exact n=3..14 exclusion. The rational finite verifier and the analytic manuscript are independent evidence but do not replace these formal obligations. Specialist and priority review remain outstanding.


## Stage 10 — trigonometric inequalities and parity-unified all-size theorem — KERNEL VERIFIED

Successful pinned Lean run [39146022640](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39146022640): **7,365 completed build jobs**, **197 audited project declarations**, only the foundational axiom allowlist `propext`, `Classical.choice`, `Quot.sound`; no `sorry` or `admit` placeholders. The preceding cosine-only [run 39145776112](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39145776112) also passed with 7,364 jobs and 189 audited declarations.

Formal modules:
- `NewtonConjectures/TrigonometricEndgame.lean`: proves both **actual cosine** comparisons from the all-m harmonic inequalities, using `Real.one_sub_sq_div_two_le_cos` and the verified upper bound on π.
- `NewtonConjectures/AllCycleAnalytic.lean`: proves `cycle_all_sizes_analytic_strict`, a **single** theorem `∀ n : ℕ, 15 ≤ n → gravityParityCap n < adjacencyCosineCandidate n`, automatically selecting odd and even branches.

The global analytical comparison no longer depends on floating-point numerical evidence or an unverified trigonometric lemma. It is a genuine fully quantified Lean theorem.

**IMPORTANT: these names denote closed-form numerical expressions, not a complete definition/equality of the paper's graph spectra. This is not yet an end-to-end Lean theorem about the original Graffiti 197 inequality.** In particular, the Lean development still lacks:

1. A formally defined real adjacency matrix of each cycle and a certified theorem identifying the **ordered second-smallest eigenvalue**, with multiplicities, with the appropriate cosine candidate.
2. An end-to-end Lean proof that the actual gravity numerical spectral span is ≤ `gravityParityCap n` (the component reciprocal spectral PSD and analytic row-sum formula are established in the paper, but the full formal linkage to the range has not been kernel-compiled).
3. Kernel certification of the finite complementary (C_3,dots,C_{14}) no-violation cases from their exact rational interval certificates.
4. A final theorem combining these exact spectral notions with the strict all-cycle analytic comparison.

**Status: STAGE10_GLOBAL_ANALYTICAL_THEOREM_CERTIFIED / FULL_GRAFFITI_THEOREM_HOLD.**
Do not claim full formal acceptance or external novelty certification. The initial Graffiti 197 refutation belongs to Roucairol and Cazenave; specialist proof and priority review are still pending.
