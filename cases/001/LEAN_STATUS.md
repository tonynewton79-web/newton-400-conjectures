# Case 001 — Lean 4/mathlib proof ledger

## Verified in actual Lean kernel

**PASS** on GitHub Actions run https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39126628151

- Lean 4.24.0, pinned mathlib and committed `lake-manifest.json`.
- `lake build` succeeded; the axiom audit accepted 31 declarations under the usual foundation allowlist `propext`, `Classical.choice`, `Quot.sound`.
- No `sorry` or `admit` placeholders in the compiled project.

### Stage 1 (NewtonConjectures.lean)
- Exact positive rational initial margins for odd C15 and even C16.
- Reciprocal second-difference algebra; positivity of interior weights.
- General finite weighted Gram-form nonnegativity.

### Stage 2 (NewtonConjectures/CycleKernel.lean)
- Universal finite second-difference telescoping identity for every `f : ℕ → ℚ` and all `d ≤ k`.
- Universal terminal-boundary tent decomposition for every `f : ℕ → ℚ` and `d ≤ m`.
- **Exact reciprocal kernel** for all `1 ≤ d < m`:
  ```
  1/d = 1/m
      + ∑ (j-d)·2/((j-1)j(j+1)), for d+1 ≤ j < m
      + (m-d)/(m(m-1)).
  ```
  This is precisely the off-diagonal coefficient identity underlying the paper's Gram expansion, with a separate terminal coefficient.

## Not yet verified in Lean

1. Cyclic-interval intersection counting: `(B_j B_jᵀ)₍uv₎ = max(j - distance(u,v), 0)` for `j ≤ ⌊n/2⌋`.
2. The full **matrix equality**, including the diagonal row of `R_n + (3/2)I`.
3. Consequent specific cycle spectral lower bound and cycle adjacency eigenvalue ordering.
4. Both all-m harmonic inequalities and monotonicity steps in the paper.
5. Exact formal finite converse for `C₃,…,C₁₄`.
6. Independent mathematical/novelty and priority review.

**Case 001 remains PARTIAL_FORMAL_CERTIFICATION.**
A verified proof component is not a Lean-certified full theorem.
