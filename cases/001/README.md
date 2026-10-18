# Case 001 — Cycle gravity spectra and Graffiti 197

**Research target:** Roucairol–Cazenave's infinite-cycle conjecture, associated with Graffiti Conjecture 197 (see [arXiv:2409.18626](https://arxiv.org/abs/2409.18626)).

**Candidate strengthening:** For every simple cycle C_n with n >= 15, the negative of the second-smallest adjacency eigenvalue strictly exceeds the numerical spectral spread of its gravity matrix. Every C_n with 3 <= n <= 14 satisfies the original inequality (sharp threshold).

**Key result:** An explicit positive-semidefinite cyclic-interval Gram decomposition establishes lambda_min(R_n) >= -3/2 uniformly; exact rational boundary inequalities cover the two parity classes. The finite complement uses rigorous Machin-pi and Taylor-cosine rational enclosures.

## Reproduction

From repository root:

    python cases/001/verify.py --max-n 160
    python -m unittest discover -s cases/001/tests -v

All proof-critical finite tests use exact rational arithmetic, not floating-point acceptance thresholds. Optional dense diagonalization needs NumPy. The numerical Fourier check is supplemental and does not prove the infinite statement.

**Status:** Candidate theorem, self-contained analytic argument and passing local exact checks; independent originality audit, outside mathematical review and Lean compilation not completed.

Graffiti 197 itself was **already refuted** by Roucairol and Cazenave. No first-refutation claim is made here. See [STATUS.md](STATUS.md) and [paper/main.tex](paper/main.tex).
