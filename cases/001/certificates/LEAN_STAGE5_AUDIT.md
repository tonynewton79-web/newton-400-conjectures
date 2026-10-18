# Case 001: Stage 5 kernel audit

Run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39131413230

- `Built NewtonConjectures.OffDiagonal`
- `Build completed successfully (7358 jobs).`
- `axiom-audit: audited 100 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully`
- Proof-placeholder scan: passed.

Formal theorem `weighted_offdiagonal_identity` (in `NewtonConjectures/OffDiagonal.lean`)
covers all natural m,d with m≥2 and 1≤d≤m. It uses the actual piecewise
cyclic Gram weights from `GramDiagonal.lean` and exact natural truncated
subtraction. The proof handles the antipodal/terminal endpoint d=m.

Independent exact rational computational replay: 7,259 (m,d) checks for
2≤m≤120 and 1≤d≤m, all passed.

Next gate: one **all-entry actual matrix identity** combining this identity,
`cyclic_incidence_gram_entry`, and `actual_cyclic_gram_diagonal`.
Do not conflate an arithmetic scalar identity with a formally established
matrix equality or spectral theorem.
