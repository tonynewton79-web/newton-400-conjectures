# Case 001 — Stage 2 Lean evidence

## Kernel check

[Successful GitHub Actions run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39126628151)

Selected exact runner messages:

- `Built NewtonConjectures.CycleKernel`
- `Build completed successfully (7353 jobs).`
- `axiom-audit: audited 31 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully`

No `sorry`/`admit` placeholders were permitted by the project workflow.

The kernel-accepted statements include `discrete_tent_telescope`,
`discrete_tent_with_terminal`, and `reciprocal_tent_identity`.

Proof scope: algebraic weight identity **only**. The combinatorial cyclic
overlap count, full matrix equality, and spectral graph theorem are not
yet kernel-certified.
