# Case 001 — formal kernel audit evidence

GitHub Actions: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39125127439

The runner reported, verbatim:

- `Build completed successfully (7352 jobs).`
- `axiom-audit: audited 9 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully`.

A linter-style warning about tactical separator spelling did not affect verification; the proof source was subsequently simplified to remove this warning. A separate successful run is required for the revised source.

This audit verifies the *fragment present in NewtonConjectures.lean*,
**not** the full conjecture. The complete theorem remains a Lean proof target.
