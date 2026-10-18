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
