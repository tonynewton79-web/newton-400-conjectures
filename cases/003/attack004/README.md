# Paper 003 — Attack 004: Ten-orbit four-pole matching transfer

Date: 19 October 2026. Author: Tony Newton, Newton Astro Labs.

The released manuscript extends Attack 003 on 9 sourced oddness-four snarks (order 44) by an independent **constructive four-pole transfer test**. The ten parity-compatible ordered-position S6 orbit types are all shown, by explicit glued graph certificates, to admit at least one compatible junction of two *certified* cyclic-cut shores from different source graphs (the port pairing is chosen to match their labels). **This is not a statement that every arbitrary pair of four-poles with the same parity orbit is gluable, nor that a fixed port pairing always works.**

## New results

- **10/10** ten cut-state orbit representatives produced exact composite bridgeless cubic graph witnesses; orders: **62**, **70** twice, **72** seven times.
- **All six matchings** in every composite cover were reconstructed exactly from the source two-cover certificates, with every edge appearing exactly twice.
- **Every graph** is simple, cubic, connected, and remains connected after deleting any one edge (bridgeless). The largest composite has 72 vertices / 108 edges.
- **Rare four-crossing state** transferred successfully between the original graph 1 cut [20,40,43,47] and graph 4 cut [2,3,17,30], yielding 62 vertices.
- **Independent verifier** (Python standard library) rebuilds every original shore, checks exact port/matching-name permutations, regenerates each composite graph and its matchings, and detects deliberate certificate tampering. All tests PASS.
- **No claim** of new snark isomorphism classes, preserved oddness 4, or full Berge–Fulkerson conjecture proof. No novelty or priority assessment completed.

## Files

- `Paper_003_Attack004_Exact_Four_Pole_Transfer.pdf` — revised scholarly paper (4 pages).
- `Paper_003_Attack004_Exact_Four_Pole_Transfer.tex` — editable TeX with source citations.
- `four_pole_splice.py` — deterministic witness generator (uses NetworkX).
- `independent_splice_verify.py` — exact independent verifier (Python 3 standard library only).
- `ten_orbit_gluing_witnesses.json` — 10 full composite graphs and their 6-match covers; SHA256: `a2dd3c4d30af8f43726be9db9a4ca7beacce6d526953b51ea8a7c0f27689216e`.
- `attack004_certificate.json` — machine-readable final gate.
- `cyclic4_edges.tsv` and `enumerate_cyclic4.cpp` — exact 80-cut reconstruction.
- The original nine graph inputs and 18 positive six-match covers are from Paper 003 Attack 003 and required to regenerate the source-shore cuts.

### Independent replay

With the prior files in sibling directory `Project03_Attack003_2026-10-19`:

```bash
python four_pole_splice.py
python independent_splice_verify.py
```

Original source (nine of the 31 order-44 oddness-four snarks):
https://github.com/Duchyna1/ba-graph-rp/tree/main/resources/graphs/snarks/oddness4

Original classification: Jan Goedgebeur, Edita Máčajová, and Martin Škoviera, *The smallest nontrivial snarks of oddness 4*, Discrete Applied Mathematics 277 (2020) 139–162, DOI: 10.1016/j.dam.2019.09.020.