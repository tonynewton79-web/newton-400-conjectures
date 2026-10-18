# Paper 003 / Attack 003 — four-cut ten-state theorem and nine order-44 snarks

Research release dated 19 October 2026. Author: Tony Newton, Newton Astro Labs.

## Evidential status

- **Exact elementary theorem:** 1,725 parity-compatible four-edge-cut 6-matching label assignments, forming exactly 10 orbits under relabelling of the six matchings. Class counts 1+3+3+3. The graph-specific *extendible* cut-state sets are not proved nonempty by parity alone.
- **Exact positive certificate:** 9 independently sourced, pairwise nonisomorphic 44-vertex oddness-four snarks; 18 independently constructed Fulkerson six-matching covers, all checked edge-by-edge and vertex-by-vertex by a standard-library-only verifier. The published full order-44 classification contains 31, not 9.
- **Cyclic edge-cut audit:** 80 cyclic four-edge cuts across nine graphs, with all ten orbits represented among the MILP-selected witnesses. The all-four-crossing orbit occurs on four cuts. Solver-specific orbit frequencies are not graph invariants.
- **Conjecture status:** Berge–Fulkerson remains open. Novelty and precedence of the ten-state transfer viewpoint have not been externally established.

## Source provenance

Input `source.s6` is exactly `resources/graphs/snarks/oddness4/oddness4_44.s6` from:
https://github.com/Duchyna1/ba-graph-rp
(accessed October 2026). Contains **9** sparse6 records. Original source SHA-256:
`b96e8bb9e29137f754bc646da2f11061049b2a93cb48cc5b0db78e76c54fcf5f`.

Original census: Goedgebeur, Máčajová, Škoviera, *The smallest nontrivial snarks of oddness 4*, Discrete Applied Mathematics 277 (2020), 139–162; DOI 10.1016/j.dam.2019.09.020.

## Reproduction

1. Requires Python 3.10+ with `networkx`, `numpy`, `scipy` for constructing covers, and a C++17 compiler for exhaustive cut enumeration.
2. `python audit_nine_snarks.py` recomputes both MILP and direct-pair-CSP covers, verifies girth and oddness, and writes `nine_44vertex_dual_certificates.json`.
3. `python independent_verify.py` uses only the Python standard library to check every cover, original-input hash, ten orbit classes and the stored cut signature report. It also executes a deliberately corrupted-cover rejection.
4. `g++ -O3 -std=c++17 cut_scan.cpp -o cut_scan; ./cut_scan cut_inputs.txt` independently enumerates all cyclic four-edge cuts and checks the 0/2/4 incidence parity.
5. `g++ -O3 -std=c++17 cut_signatures.cpp -o cut_signatures; ./cut_signatures cut_inputs.txt` regenerates `cut_signatures_raw.txt` from the frozen cut input file.
6. `pdflatex -halt-on-error Paper_003_Attack003_Ten_State_Four_Cuts.tex` twice compiles the paper PDF.

The independent verifier accepts output only if all 18 six-match covers are exact. Optimizer objective values and floating-point tolerance alone are never trusted as proof. The two construction solvers are algorithmically distinct. For the full 31-graph census or potential new infinite-class theorems, further work is needed.

## Key certifying fingerprints

- JSON `nine_44vertex_dual_certificates.json` SHA-256: `cf3b7682b5ed922bc70ff39abf6a274e9dc5bd9b4c895b7db37038d998b0cd6a`.
- `source.s6` SHA-256: `b96e8bb9e29137f754bc646da2f11061049b2a93cb48cc5b0db78e76c54fcf5f`.
- See `SHA256SUMS` for every packaged file, including PDF, TeX and all code.