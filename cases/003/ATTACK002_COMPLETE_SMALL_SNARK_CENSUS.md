# Paper 003 — Attack 002: complete small-snark dual-solver gate

**Research status:** PASS_29_COMPLETE_PUBLISHED_SMALL_SNARK_CENSUS_TWO_INDEPENDENT_SOLVERS_AND_5_THREE_JOINS. **Full Berge–Fulkerson conjecture OPEN; no novelty or priority assertion.**

## What has been checked exactly

The Forbes nontrivial-snark edge catalogue through order 22 contains 29 graphs: Petersen (10 vertices), 2 Blanuša snarks (18), 6 snarks of order 20, and 20 snarks of order 22. The 28 non-Petersen edge lists are transcribed from A. D. Forbes, *Snark Designs*, arXiv:1207.3032v2, Sections 3–5.

Every graph has an integer-verified six-perfect-matching twice-cover, constructed independently by:

1. Enumerating distinct perfect matchings and solving the six-cover incidence integer programme via SciPy/HiGHS; replaying each witness independently with exact integer arithmetic.
2. A separate direct depth-first constraint search assigning one of 15 unordered pairs of 6 matching indices to each edge. The three pairs incident at a vertex must partition all six labels. Symmetry fixes the first star to (01),(23),(45). This backend uses no MILP or matching enumeration; all 29 pass.

An independent graph audit checks cubicity, bridgelessness, connectedness, absence of a three-edge colouring, girth at least 5, absence of cyclic cuts with fewer than four edges, and pairwise nonisomorphism within each order. The complete-census assertion relies on the published catalogues (not a newly generated exhaustive graph list). Historic small-snark positive results are established prior art; see Brinkmann et al., *Generation and properties of snarks*, JCTB 103 (2013), 468–488, DOI 10.1016/j.jctb.2013.05.001.

| Structural stratum | Graphs | Distinct perfect matching count |
|:--|--:|--:|
| Petersen | 1 | 6 |
| Blanuša | 2 | 19–20 |
| Order 20 | 6 | 26–32 |
| Order 22 | 20 | 32–39 |
| **Total** | **29** | — |

## Three-edge cut transfer

Let G1, G2 be cubic with disjoint vertex sets; delete one cubic vertex in each, whose three neighbours are distinct, and join corresponding neighbours in three edges. The joined graph has a Fulkerson cover if and only if both summands have one.

In a six-match cover a 3-edge cut must be met exactly once by each matching: every cut crossing has odd cardinality, and there are six matching incidences in total. Thus covers can be restricted by capping the cut with a vertex. Conversely, the two deleted stars induce 3 disjoint two-element sets of matching indices; permute the labels of one cover to align corresponding edge incidences, then replace the deleted star edges by the join edges. Each match remains perfect, and every edge is covered twice. This cut decomposition is classical and not claimed as an original graph theorem.

Exact 3-joins verified: B11+B12 (34 vertices), B11+S6 (36), B12+L20 (38), S1+L8 (40), L1+L2 (42).

## Negative controls

A cubic graph on 10 vertices with a bridge, obtained from two subdivided K4 graphs, is rejected: its bridge belongs to every perfect matching and therefore cannot be twice-covered by six matchings. A deliberately corrupted Blanuša witness is also rejected by the independent checker.

## SHA-256 certificate manifests

- snark_witnesses_complete29.json: 3f1b4ffcb5aa8f5d8fce7580395d6e0fd914b35dd8805c74be05a2a2b44a0d11
- direct_pair_csp_certificates.json: 5401bf531c2d2eaeb79baf36a2bad86685571687b1f785ed570ab34b81c913ac
- three_join_witnesses.json: 78a000d0624edb81a0c68c8fcc305a1a538e9b544bcf632dd60fe7ed02dde41d

The complete PDF, editable LaTeX, research code, graph inputs, JSON witnesses, and independent verifiers were generated as conversation artifacts; this Markdown checkpoint does **not** constitute a GitHub upload of those source binaries or full code.

## Next high-value gate

Audit and test cyclically high-edge-connected strong snarks (orders 34–40) and the 31 cyclically four-edge-connected, oddness-four snarks on 44 vertices, using both positive solvers and independent certificate replay. Any prospective computational counterexample needs a complete proof of nonexistence, not a timeout. The Berge–Fulkerson conjecture remains open.