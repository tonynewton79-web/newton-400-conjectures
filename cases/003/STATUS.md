## 19 October 2026 — Attack 004: ten real four-pole splices

- **10/10 full ordered-position cut-state orbits** admitted an exact matching-label-aligned junction of two independently sourced cyclic-cut shores, using a freely chosen four-port bijection and relabelling of the six matchings. These are *positive witness composites*, not a theorem that arbitrary fixed junctions are always compatible.
- **Exact composite graph certificates:** 10 bridgeless cubic graphs on 62, 70 (two cases), or 72 (seven cases) vertices, each equipped with six perfect matchings covering every edge exactly twice.
- **Important difficult state:** all-four-crossings orbit realized by splicing source graph 1 cut [20,40,43,47] with graph 4 cut [2,3,17,30], yielding 62-vertex certificate.
- A **separately written standard-library-only verifier** reconstructs original cut shores, the junction and all six matchings; checks connectedness after deleting every edge, cubicity and twice-incidence; and rejects a tampered matching. PASS.
- **Full ten-witness JSON SHA256** `a2dd3c4d30af8f43726be9db9a4ca7beacce6d526953b51ea8a7c0f27689216e`.
- **Scope limit:** no claim the composite graphs remain snarks, preserve oddness four, or are pairwise nonisomorphic. No proof of the general Berge–Fulkerson conjecture and no established novelty.
- [Attack 004 report and reproducibility manifest](attack004/README.md). Full revised four-page PDF, TeX, scripts and exact JSON certificates remain separate downloadable conversation artifacts; the GitHub checkpoint is documentation rather than the full code/certificate release.

## 19 October 2026 — Attack 003: four-cut ten-orbit theorem and oddness-four pilot

- **Exact elementary theorem:** among the 15^4=50,625 four-boundary pair-label assignments, exactly **1,725** satisfy four-cut matching parity and form **10 distinct S6 orbits**: 6 of type n4=0, 3 of type n4=1 and 1 of type n4=2. An exact four-pole gluing criterion reduces to overlap of extendible labelled boundary-state sets.
- **Hard snark pilot:** 9 distinct 44-vertex, 66-edge, oddness-four, cyclically four-edge-connected snarks were independently sourced from the [BA-Graph nine-sparse6-input sample](attack003/source.s6). The published complete order-44 classification contains **31** graphs, and this sample is explicitly **9/31, not 31/31**.
- **Two algorithmically distinct positive solvers:** all-perfect-matching integer-optimisation and a direct 15-pair-label CSP each found a cover for **all 9 graphs**. A standard-library integer verifier replayed all **18** covers and refused a deliberately corrupted certificate. Every graph has 540–591 perfect matchings and oddness exactly 4.
- **Four-edge cut audit:** exhaustive enumeration found 80 cycle-separating 4-edge cuts, no smaller cyclic cuts, and all 10 parity orbits occurred among the 80 cuts under the first solver's covers. The two-four-crossings orbit occurs on four explicit cuts (graphs 1,4,6,9), falsifying a proposed but unsupported at-most-two-crossings restriction.
- [Reproducibility instructions and exact fingerprints](attack003/README.md), [source sparse6 inputs](attack003/source.s6), and [standalone positive-CSP/orbit verifier](attack003/verify_attack003.py). A dedicated GitHub Actions workflow was added. The scholarly PDF, LaTeX and complete full dual-solver JSON/verification package are separate in-chat artifacts; they have **not** been committed as binary files to GitHub.
- **Claim boundaries:** No general Berge–Fulkerson theorem, no full 31-graph census, no proof of a new infinite family, no established novelty. Next target: derive extendible four-pole state spectra for the six published construction classes and test sound transfer/replacement rules.


## 18 October 2026 — Attack 002 checkpoint

- Complete published nontrivial small-snark catalogue through 22 vertices: **29/29 exact Fulkerson covers**, all found with **two independent solvers** (perfect-matching MILP and pure 15-pair-label CSP).
- Independent integer replay confirms every vertex and edge incidence, and checks non-3-edge-colourability, girth at least 5, cyclic edge connectivity at least 4 and nonisomorphism within orders.
- Three-edge-cut gluing equivalence proved and five joined-graph covers (34, 36, 38, 40, 42 vertices) verified.
- Negative tests: bridged cubic graph refused, deliberately altered matching witness refused.
- All 29 small-snark positive cases lie in documented prior-art territory; the **Berge–Fulkerson conjecture remains open**.
- [Complete Attack 002 results and SHA-256 certificate manifest](ATTACK002_COMPLETE_SMALL_SNARK_CENSUS.md). Updated three-page PDF and full 17-file source/certificate packet remain downloadable conversation artifacts; they are not yet uploaded as repo source files.

# Case 003 — Berge–Fulkerson conjecture: exact matching-cover search

**Project opened:** 18 October 2026. **Status:** OPEN_GENERAL_CONJECTURE; EXACT_INITIAL_POSITIVE_CASES; NO_NOVELTY_CLAIM.

## High-value target

The Berge–Fulkerson conjecture asks whether every finite bridgeless cubic graph admits six perfect matchings in which every edge occurs exactly twice. Source: Fulkerson (1971); a recent source treating the conjecture as open is Luo, Hao, Zhang and Zhou, *Journal of Graph Theory* (14 July 2026), DOI: 10.1002/jgt.70097. See also Magalhães Júnior–Silva, arXiv:2607.29511.

The 2026 cycle-double-cover developments should not be mistaken for a proof of Berge–Fulkerson.

## Mathematical search architecture

Encode each edge e by the pair of matching-label indices {i,j} in {1,...,6} that contain it. At each cubic vertex, its three incident edge labels must form a partition of {1,...,6} into three unordered pairs. A global consistent labeling is exactly a Fulkerson cover. This restates the well-known 6-edge-coloring of the doubled graph 2G; it is a useful finite constraint-programming formulation, **not** an original equivalence claim.

The constraint program is: enumerate perfect matchings M of G; solve integer exact coverage equations

    sum_M 1[e in M] * z_M = 2        for each edge e,
    z_M nonnegative integers,   sum_M z_M = 6.

For exact release, expand selected matchings with multiplicity and independently verify every vertex and every edge.

## Initial independent exact gate (18 October)

- Petersen (10 vertices, 15 edges): exactly six perfect matchings enumerated; using all six covers every edge twice. This is a classical published result (e.g., Combinatorica DOI 10.1007/s00493-023-00078-9, Proposition 2.1).
- Splicing two Petersen graphs across an edge two-sum (20 vertices, 30 edges): a six-matching cover constructed exactly and independently verified.
- Three-Petersen edge-two-sum (30 vertices, 45 edges): another exact six-matching cover; the general gluing lemma follows by aligning the two labels containing each deleted edge. The graph stays cubic and bridgeless.
- Isaacs flower snarks: J5 (20 vertices/30 edges), J7 (28/42), J9 (36/54), J11 (44/66), J13 (52/78). A mixed-integer matching selection algorithm found six perfect matchings for each; an entirely separate, solver-free exact verifier confirmed every edge occurs twice and that each chosen set is a perfect matching. The exhaustive Petersen and smaller flower matching counts are 6, 32, 128, 512 for P,J5,J7,J9 respectively; J11 has 2048 and J13 has 8192 in our graph representation.

These successful cases are **known positive territory**; the conjecture is NOT solved. Published prior results establish covers for many flower and other snark families, including Hao et al. (2009) and more recently larger families of superposition snarks. This gate certifies the engine, not a breakthrough.

## Next decisive research gate

1. Obtain a provenance-audited database of cyclically 4/5/6-edge-connected snarks not already subsumed by known Fulkerson-cover constructions.
2. Test the pair-label CSP with independently compiled perfect-matching enumeration and SAT/ILP engines.
3. For new positive cases, derive general local replacement rules with a proof; for any negative computational candidate, demand an UNSAT certificate that can be replayed by an independent checker.
4. Prior-art audit **before** escalating any result to an original theorem.

This is a higher-risk, higher-impact conjecture than Case 002. Results are evidence-bounded and require specialist review.

**Explicit nonclaims:** no universal Fulkerson cover, no new snark family theorem, no journal novelty evidence, no refutation.
