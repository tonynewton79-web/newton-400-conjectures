## 18 October 2026 — Attack 003 (new verified checkpoint)

- **Now exact-certified:** triple-crossing chord wheel quadratic cycle formula, anchored by six small exact graph counts; 924 independent DFS tests.
- **Finite computer-assisted interval:** every integer from **1,897 through 418,785** attained, **416,889 consecutive counts**, maximum rim vertices 260; reproducible C++ scan over 2,705,284,800 inputs (triple family itself 10,120 through 418,785).
- **Verification digest:** `f2bc5910569d1ac26958c2a7a201d1d4c0828b808ca341088a0a0984bc31b6c8`.
- [Full Attack 003 mathematical certificate](ATTACK003_THREE_CHORD_2026-10-18.md) and [standalone C++ sweep](rebuild_attack003.cpp).
- **Research status:** EXACT_TRIPLE_FORMULA_FINITE_COVERAGE_PASS; UNIFORM_COFINITE_OPEN. Novelty/priority unestablished.

## 18 October 2026 — two-chord extension checkpoint

- **Proved combinatorially:** explicit quadratic crossing/noncrossing two-chord wheel cycle-count formulas. See [theorem and proof summary](TWO_CHORD_EXTENSION_2026-10-18.md).
- **Exact finite construction:** all 24,326 integers from 1,897 to 26,222 are realized by 3-connected simple two-chord wheels with at most 95 rim vertices.
- **Independent exact small-graph audit:** 161 graph-cycle counts and 161 two-vertex-deletion connectivity checks, all passed, for all configurations with rim size 4 through 9.
- **Public reproducibility script:** [replay_two_chord_interval.py](replay_two_chord_interval.py) regenerates each witness and verifies SHA-256 5aa3a8e3a260661afce548d7060f2231825511c845ff90c959ab1da5135ade6f.
- **Status:** EXACT_TWO_CHORD_FORMULAS_AND_FINITE_INTERVAL_PASS; FULL_COFINITE_CLASSIFICATION_HOLD. Novelty/priority not established. The full PDF, TeX and CSV are separate conversation artifacts, not committed binary files here.

# Case 002 — 2026 three-connected graph cycle counts

**Working research target:** McCulloch, McKay, Salahshoori, and Zaslavsky (2026), Section 6(a), conjecture about unattainable simple-cycle counts of 3-connected simple graphs. [Official paper](https://doi.org/10.1007/s00373-026-03047-3).

## Verified constructive baseline

- Wheel graph with m rim vertices: `c(W(m))=m(m-1)+1` for m≥3.
- One non-rim-edge chord v0-vk, 2≤k≤m−2: `c(W(m;k))=(3m²−5m+8+2k(m−k))/2`.
- A combinatorial proof appears in [Paper 002](paper/main.tex), based on counting old simple paths connecting chord endpoints.
- For m=3..30, independent exact Python enumeration and full two-vertex deletion checks give **406 passing instances**; unlike a floating-point cross-check, these are exact integer acceptance tests.
- [Standalone deterministic verifier](verify.py); [CI workflow](../../.github/workflows/case002-paper.yml); certificate saved to `certificates/construction.json` upon verified build.

## Explicit nonclaims

This elementary wheel-chord formula has **not** been established as novel in the published literature; no new exception to the 2026 conjecture has been shown; the complete conjecture has **not** been solved. A finite search through rim length 30 is not an all-graphs proof. The universal formula has an informal mathematical derivation, but not a Lean kernel certification.

**Status:** EXACT_CONSTRUCTION_BASELINE_ONLY; FULL_OPEN_PROBLEM_HOLD.

## Next decisive target

Add two and three rim chords and derive exact incremental path-count certificates; search for a finite collection of construction families whose achievable cycle-count images cover *every integer beyond a threshold*. Prove the missing small exceptions separately, or report a rigorous obstruction, with independent novelty review.
