# Stage 6 — full rational cyclic Gram matrix identity

Successful kernel build: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39133219628

- `Built NewtonConjectures.FullGram`
- `Build completed successfully (7359 jobs).`
- `axiom-audit: audited 113 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully`

Formal statement `cyclic_shifted_reciprocal_eq_gram`:

For n≥4, define `R_n(u,v)` as reciprocal cycle distance for distinct u,v and zero otherwise, and let `m=n/2`. Then Lean proves the exact rational matrix equality
`R_n+(3/2)I=(1/m)J+Σ_(j=2)^m w_j B_j B_jᵀ`.

The implementation defines the shifted matrix directly (3/2 on diagonal, 1/d off diagonal) and the exact cyclic incidence Gram RHS and proves extensional matrix equality for all vertex pairs.

This is mathematical/proof-critical, but it does not yet assert a formally checked real eigenvalue lower bound or complete cycle counterexample theorem. Actual specialist validation and originality assessment remain open.
