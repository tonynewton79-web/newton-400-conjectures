# Case 001 Stage 11 — actual graph theorem interface

- Successful pinned kernel build: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39151152516
- `Built NewtonConjectures.ActualGravityBridge`.
- `Build completed successfully (7368 jobs).`
- `axiom-audit: audited 223 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound].`
- `axiom-audit completed successfully.`
- Proof placeholder check passed.

## New exact theorems

- `cycleAdjacency_isHermitian` and actual ordered eigenvalue representation with multiplicities.
- `actual_reciprocal_add_diagonal_eq_shifted` (zero-diagonal Harary matrix + 3/2 I).
- `actual_reciprocal_diagonal_shift_psd`.
- `actual_gravity_is_scaled_reciprocal` with exact gravity factor 4/(n-1).
- `full_graffiti_strict_of_spectral_interfaces`: conditional final statement using *actual* spectrum span and ordered second-smallest adjacency eigenvalue.

## Not an unconditional theorem

The last theorem is under **two explicit hypotheses**: 
(1) actual second-smallest adjacency eigenvalue = negative closed-form cosine candidate;
(2) actual gravity spectral span is at most the parity harmonic cap.
Neither has been established here. The final finite C3..14 converse is also not kernel-proved.
This stage does NOT certify the full claim, although all statements in the source actually compile without unapproved axioms or proof placeholders.
