# Case 001 Stage 12 — exact weighted shell matrices and gravity upper Loewner bound

Pinned GitHub Lean 4/mathlib Actions run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39153984478

- `Built NewtonConjectures.DistanceShellLaplacian`
- `Built NewtonConjectures.DistanceShellAdjacency`
- `Built NewtonConjectures.DistanceShellDegreeBridge`
- `Build completed successfully (7371 jobs)`.
- `axiom-audit: audited 250 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound]`.
- `axiom-audit completed successfully`.
- Proof-placeholder scan passed.

## Kernel-certified results

For every cycle n>=4, define shell graph E_d as the simple graph on ZMod n with u~v iff u!=v and cyclicDistance n u v=d.

With weight 1/d, let L_n be their weighted graph Laplacian; D_n the weighted diagonal degree matrix; R_n the actual zero-diagonal reciprocal-distance graph matrix; G_n=4R_n/(n-1) the actual gravity matrix.

Lean checks:
- Cyclic distance is symmetric and E_d is an undirected graph.
- The exact weighted shell adjacency sum is R_n.
- The actual weighted shell Laplacian equals D_n-R_n.
- L_n is positive semidefinite by a finite weighted sum of mathlib-certified graph Laplacians.
- Therefore D_n-R_n is PSD, and (4/(n-1))D_n-G_n is PSD.

## Release boundaries

D_n is not yet kernel proved to equal the explicit row-sum scalar times I. The actual gravity spectral-span bound, exact second-smallest adjacency eigenvalue theorem, and finite complement n=3..14 are not yet a single unconditional Lean theorem. No mathematical novelty or specialist sign-off is claimed for this independent certification layer.
