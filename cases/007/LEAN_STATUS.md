# Case 007: Lean formalization status

The complete Sombor-product extremal-tree theorem is **NOT Lean-certified**.

The first Lean source formalizes elementary scalar identities for the three edge types, an algebraic two-edge dispersion identity, and exact rational inequalities used in the paper. No assumption that every tree is an eclipsed sun is introduced.

Formalization milestones:
1. [ ] GitHub Actions has compiled the initial Case007Sombor.lean and Case007SunGraph.lean sources without placeholders (current workflow runs queued).
2. [ ] Encode finite simple tree, endpoint degree, Sombor weight and inverse weight.
3. [ ] Construct eclipsed sun and prove edge-type partition in the actual graph.
4. [ ] Formalize degree potential and all analytic inequalities.
5. [ ] Formalize strict defect comparison and equality case.
6. [ ] Verify bounded finite rational certificates using Lean reflection or generated proofs.
7. [ ] Prove and compile the unrestricted n>=5 extremal theorem in the Lean kernel.

Run: lake exe cache get; lake build NewtonConjectures.Case007Sombor; lake build.

The manuscript's computational assertions must be independently reproducible and never described as complete kernel proof.

### 19 October 2026: genuine finite graph model added

[New source](../../NewtonConjectures/Case007SunGraph.lean) defines `SunVertex`, `SunEdgeLabel`, source and target maps, `sunAdjacent` and an actual `SimpleGraph`. It includes the three edge-label classes, three adjacency witnesses, the combinatorial vertex/label counts and explicit finite Sombor/reciprocal sums over labels. **Lean kernel compilation is not yet confirmed** and none of this proves the global conjecture. The edge labels have not yet been related by a proved bijection to `SimpleGraph.edgeFinset`, and graph-degree formulas remain to be proved before claiming a graph-index theorem.

An independently executable finite graph test has passed 3,320 cases (`1≤d≤80,0≤k≤d`), including degree patterns and exact squared edge weights. Numerical testing is not a substitute for the universal Lean lemmas.

### Next test: actual edge bijection (19 October 2026)

[Case007EdgeBridge.lean](../../NewtonConjectures/Case007EdgeBridge.lean) now states and supplies proof terms for the exact bijection between the disjoint edge-label type and the **actual undirected edge set** of `sunGraph`. Its components are a depth-increasing orientation, target-map injectivity, symmetric-pair injectivity, edge-set surjectivity, and the resulting graph edge-count theorem. The module is imported in the root Lean build and the case-specific CI.

**No Lean kernel verification has yet been observed for these statements.** CI is pending, and the file may require compilation corrections.

An independent, implementation-distinct [Python edge-bijection checker](verify_edge_bijection.py) passed **7,404 exact finite instances** (all `1≤d≤120`, `0≤k≤d`, plus 24 large-degree boundary/stress instances at `d=151,257,503,1000`). It verifies injectivity, surjectivity, endpoint-depth orientation, connectivity, degrees, and the squared-weight multiset. The exact arithmetic / finite certificate program also passed locally.

**Next proof target:** derive the four true `sunGraph.degree` values (hub `d`, short leaf `1`, long intermediate `2`, tip leaf `1`) from the edge bijection, then identify `sunLabelS`/`sunLabelR` with actual graph-index sums. After these, advance to the dominant-degree and defect-comparison lemmas.


### Vertex-degree and true-index bridge (19 October 2026)

The new source [`Case007Degrees.lean`](../../NewtonConjectures/Case007Degrees.lean) explicitly targets the actual `sunGraph d k : SimpleGraph _`, rather than a surrogate graph or preassigned degrees. It introduces:
- `sunHub_adj_iff`, `sunShort_adj_iff`, `sunLong_adj_iff`, and `sunTip_adj_iff`, classifying each neighborhood.
- `sunGraph_degree_hub`, `sunGraph_degree_short`, `sunGraph_degree_long`, and `sunGraph_degree_tip`, with intended degrees `d,1,2,1`.
- The degree-defined undirected-edge weight `sunGraphWeight` and its per-label equality with the earlier square-root weight.
- `sunActualS` and `sunActualR`, which sum over **the real graph's `edgeSet`** rather than assumed labels.
- `sunActualS_eq_sunLabelS` / `sunActualR_eq_sunLabelR` via the prior bijection.
- `sunActualS_eq_paper` / `sunActualR_eq_paper`, matching the displayed formulas (3) and (4) of the research article.

This is a complete *proposed Lean proof source* for the specific four-degree and three-edge-sum milestone. It has been imported into `NewtonConjectures.lean`, and both normal and case-specific CI builds have been triggered. **The GitHub jobs remained queued at the last inspection, with no verified Lean kernel pass; no claim of completed formal proof should be made until the specific commit actually builds cleanly.** Axiom/no-placeholder audits have likewise not returned results.

Only after those checks should this milestone be marked kernel-verified. The dominant-degree estimate, strict defect comparison, optimization, and unrestricted theorem are not addressed by this module.
