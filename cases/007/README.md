# Case 007 — Sombor product on trees

**Target:** Conjectures 12 and 13 of I. Gutman, I. Redžepović and B. Furtula, *On the product of Sombor and modified Sombor indices*, Open Journal of Discrete Applied Mathematics 6(2) (2023), 1–6. DOI: https://doi.org/10.30538/psrp-odam2023.0083.

**Source:** Tony Newton, *The maximum product of the Sombor and modified Sombor indices of a tree*, revised manuscript (19 October 2026).

For an n-vertex tree T, define the Sombor edge weight w(uv)=sqrt(deg(u)^2+deg(v)^2). The target sharp statement is that (sum w)(sum 1/w) is uniquely maximized by the eclipsed sun ES(n,k), k=floor((n-2)/3), for every n>=5.

## Mathematical content

The candidate manuscript contains:
1. A universal degree-potential bound U(n,d), excluding d<=n/2 for n>=17;
2. A direct two-factor defect comparison for d>n/2, reducing all maximizers to eclipsed suns;
3. Strict finite differences determining k=floor((n-2)/3);
4. Exact rational interval checks for 2,220 degree pairs and 18 residual increments;
5. Independent exact interval comparison on the 32,503 nonisomorphic free trees of orders 5 through 16.

The [full, professionally revised LaTeX manuscript](paper/main.tex) is now version-controlled in this case. The [GitHub PDF build workflow](../../.github/workflows/case007-paper.yml) compiles its two original TikZ figures and produces a PDF artifact; publication of the compiled PDF in the repository remains dependent on completion of that workflow. This case directory also records the formal program; **the full proof has not been compiled or proved in Lean**. The analytic paper is a proposed resolution pending line-by-line external review and novelty confirmation.

## Verification targets

- Lean: elementary sum/reciprocal and three-edge-type algebra;
- Lean: definition of tree, degrees, edge weights and eclipsed-sun constructor;
- Lean: potential bound U(n,d) and d<=n/2 exclusion;
- Lean: dominant-vertex nonroot-edge defect, strict product comparison and equality;
- Lean: arm-count integer finite differences and final extremal theorem;
- Separately: exact rational interval checks and exhaustive unlabeled-tree enumeration.

**Caution:** numerical, rational and C++/Python certificates are different from Lean kernel verification. A successful simple algebra check is not evidence the full graph extremal theorem has been formalized.

[Original 2023 paper](https://pisrt.org/psrpress/j/odam/2023/2/On-the-product-of-Sombor-and-modified-Sombor-indices.pdf) · [Lean source](../../NewtonConjectures/Case007Sombor.lean) · [Lean status](LEAN_STATUS.md) · [case-specific CI](../../.github/workflows/case007.yml).

## Source and reproducibility

- [Full revised LaTeX paper](paper/main.tex)
- [Exact rational degree and finite-difference verifier](verify_parameters.py)
- [Exact integer free-tree enumeration](certify_free_trees.py)
- [Paper build workflow](../../.github/workflows/case007-paper.yml)
- [Case-specific verification workflow](../../.github/workflows/case007.yml)
- [Remaining Lean gates, Issue #27](https://github.com/tonynewton79-web/newton-400-conjectures/issues/27)

## Graph-specific Lean milestone (19 October 2026)

The actual finite simple-graph construction and the three edge-label classes are encoded in [Case007SunGraph.lean](../../NewtonConjectures/Case007SunGraph.lean). The module includes vertex and edge-label counts, adjacency witnesses for each of the three classes, and the Sombor and modified-Sombor weighted sums over those classes. The combined Lean and case-specific GitHub workflows have been triggered, but a successful compilation has not yet been confirmed.

The remaining bridge is to prove that the edge-label map is an equivalence onto the actual `SimpleGraph.edgeFinset`, compute every vertex degree with `sunGraph.degree`, and thereby identify the label-defined sums with graph-defined Sombor invariants. Do not cite the graph module as a complete proof of the target theorem. A separate finite graph checker [verify_graph_construction.py](verify_graph_construction.py) tests 3,320 structures through hub degree 80 using exact squared weights and NetworkX tree checks.

## Next formal step — graph edge bijection

The new [edge-bijection Lean module](../../NewtonConjectures/Case007EdgeBridge.lean) proposes a proof that the three families of labeled edges constitute **all and only** the edges of the actual finite `SimpleGraph`. It also proves at source level the resulting count `|E(E_{d,k})|=d+k`. This module is awaiting Lean CI compilation and is **not claimed kernel-verified**.

The independent [edge-bijection test](verify_edge_bijection.py) passes **7,404** finite parameter cases, including large-degree and boundary cases; see [formal ledger](LEAN_STATUS.md). The next essential Lean theorem computes the graph's *actual vertex degrees* and then identifies the degree-defined Sombor and reciprocal sums with the existing three edge-type formulas.

## Degree-defined indices: next Lean milestone

[Case007Degrees.lean](../../NewtonConjectures/Case007Degrees.lean) now states the four true degree identities for the constructed simple graph and derives the Sombor and modified Sombor indices as sums over its actual undirected edge set. It then identifies those sums with the paper's formulas (3)–(4). See the exact declarations and boundaries in [LEAN_STATUS.md](LEAN_STATUS.md).

**Pending:** real Lean 4/mathlib kernel compilation, axiom audit and any necessary compiler-driven corrections. The module is an unverified proof attempt until its GitHub Actions job succeeds. The paper's full maximum theorem remains separate and unformalized. [Current Lean workflow](https://github.com/tonynewton79-web/newton-400-conjectures/actions).
