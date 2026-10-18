# Case 001 — Proof and priority ledger

**Source:** Milo Roucairol and Tristan Cazenave, Refutation of Spectral Graph Theory Conjectures with Search Algorithms, arXiv:2409.18626, section 5.1.

**Their conjecture:** C_(4r+1) is a counterexample for each integer r >= 4, using the numerical-range convention.

**Our candidate strengthening:** C_n is a counterexample for all n >= 15, in every residue class.

**Gravity convention:** Gr(u,v)=deg(u)deg(v)/[(n-1)dist(u,v)] away from the diagonal. On a cycle Gr=4R/(n-1).

**Analytic proof certificate:** R+(3/2)I=(1/m)J+sum_(j=2)^m w_j B_j B_j^T, where m=floor(n/2), w_j=2/[(j-1)j(j+1)] for j<m, and w_m=1/[m(m-1)]. Strict parity boundary margins: 506/11025 for n=15 and 1733/58800 for n=16, with monotonicity thereafter.

**Finite converse:** All n from 3 through 14 receive strictly negative rational upper bounds on the proposed violation margin.

**Replay:** cases/001/verify.py and cases/001/tests/test_case001.py. Machine checks support finite facts; the paper supplies the general proof.

**Open gates:** Independent specialist review; detailed novelty/priority search; optional Lean formalization. No claim of compiled Lean certification, refereed acceptance or being first to refute Graffiti 197.
