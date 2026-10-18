# Case 001 — Stage 15 exact harmonic row-sum kernel audit

- Pinned Lean run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39160177061
- Build: `Built NewtonConjectures.ShellHarmonic`, `Build completed successfully (7376 jobs).`
- Axiom audit: 301 project declarations accepted under `propext`, `Classical.choice`, `Quot.sound`.
- No proof placeholders or unauthorized axioms.

## Fully verified in kernel

- For n≥4 and 1≤d≤floor(n/2), distance-d neighbors of zero are exactly the residues d,n−d.
- Their cardinality is exactly 1 when 2d=n, otherwise exactly 2.
- For odd cycle n=2m+1 (m≥2), the actual shell scalar s_n is 2 H_m.
- For even cycle n=2m (m≥2), the actual shell scalar s_n is 2 H_(m−1)+1/m.
- These are unconditional all-index exact proofs and include the conversion from rational H_m to real matrix scalar.

## Remaining end-to-end Lean gates

- Extract the spectrum interval/sup-inf span for the actual graph gravity matrix from the two certified PSD bounds.
- Identify the ordered second-smallest eigenvalue of the actual adjacency matrix, including parity and multiplicity.
- Formally certify C3 to C14 and assemble unconditional sharp iff theorem.
- External mathematical originality/specialist review.

Do not classify the full Graffiti 197 cycle theorem as Lean-certified or externally accepted.
