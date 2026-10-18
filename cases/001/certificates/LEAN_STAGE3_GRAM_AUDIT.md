# Case 001 — Stage 3 formal cyclic Gram certificate

## Verifiable execution

- Successful public [GitHub Actions run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39128814226)
- Lean v4.24.0, pinned mathlib dependencies.
- GitHub runner: `Built NewtonConjectures.CyclicGram`.
- GitHub runner: `Build completed successfully (7356 jobs).`
- GitHub runner: `axiom-audit: audited 74 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- GitHub runner: `axiom-audit completed successfully`.
- No `sorry` / `admit` proof placeholders accepted by CI.

## Exact theorem

`cyclic_incidence_gram_entry` in
[`NewtonConjectures/CyclicGram.lean`](../../NewtonConjectures/CyclicGram.lean):

For all natural `n,j` with `n>0`, `2*j≤n`, and all `u,v : ZMod n`,
a cyclic incidence matrix `B_j` satisfies

```
(B_j * transpose B_j) u v = ((j - cyclicDistance n u v : ℕ) : ℚ).
```

The matrix is defined through actual finite cyclic membership; the right side is
the truncated difference `max(j-d,0)`.

**Claim boundary:** The complete *weighted sum* Gram decomposition and resulting
cycle spectral theorem are not yet in the Lean kernel. Graffiti 197 itself was
previously refuted in the original cited work. Historical priority for this
strengthening still awaits outside audit.
