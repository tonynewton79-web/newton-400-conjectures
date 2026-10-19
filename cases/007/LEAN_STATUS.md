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
