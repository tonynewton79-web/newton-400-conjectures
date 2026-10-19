# Paper 004 — Attack 004: Complementary-triangle incidence and codegree bounds

**19 October 2026 · Tony Newton · Newton Astro Labs**

**Status: EXACT_PROVED_RESTRICTED_THEOREM_AND_94_CLASS_FINITE_CERTIFICATE; general Caccetta–Häggkvist remains OPEN; priority unverified.**

## Exact universal balanced incidence theorem

Let D be a loopless oriented graph with 3d vertices and **indegree = outdegree = d** at every vertex. Let H be the complement of its underlying graph; t(H) its number of undirected triangles; c3(D) its number of directed three-cycles; and S the sum over vertices v of complementary edges wholly inside N+(v) or wholly inside N-(v).

The earlier exact identity is c3(D)=d-t(H)+S/2.

**New exact theorem, valid for every d>=3:**

    (d-2) S >= 6 t(H);
    c3(D) >= d + ((5-d)/(d-2))*t(H).

Proof: Every triangle T of H has at least six external vertices adjacent to every T vertex in the underlying oriented graph, as each T vertex has only d-3 other complement neighbours. At each such exterior vertex, two of T's three vertices occupy the same in- or out-neighbourhood, producing an event counted by S. Each event can be charged by at most d-2 H triangles since a complementary edge has at most d-2 common complementary neighbours. Hence at least 6t(H) charges and at most (d-2)S.

**Sharp restricted consequence:** For each d=1,2,3,4,5, every balanced d-in/d-out oriented graph on exactly 3d vertices has >=d directed triangles. A cyclic orientation of Z/(3d) with steps 1..d attains c3=d. These are five degree values, **not** an infinite-range solution to the conjecture. The incidence inequality itself is valid for every d>=3; its coefficient becomes negative starting at d=6.

## New irregular-codegree certificate

For a d-outregular oriented graph with n=3d, let eps_v=indegree(v)-d and V=sum eps_v^2. For complement H set kappa=max_{uv in E(H)} |N_H(u) intersect N_H(v)| and

    W=sum_{H triangles {a,b,c}} max(0,6+eps_a+eps_b+eps_c).

When H contains a triangle, kappa>=1 and

    kappa*S >= W;
    c3(D) >= ceil(d+V/4-t(H)+ceil(W/kappa)/2).

When H is triangle-free, use the earlier sharp variance bound c3>=d+V/4. No claim that the irregular inequality solves the general case.

## Fully specified 12-vertex finite audit

The **85** connected cubic graphs on twelve vertices are a classical enumerated complete set (Meringer 1999); there are exactly **9** disconnected types (5 from 4+8, 3 from 6+6, 1 from 4+4+4). The standalone source generator created 85 connected **pairwise VF2++ nonisomorphic** representatives using triangle/edge subdivisions and degree-preserving 2-switch closure; the known 85 count supplies exhaustiveness.

Each of all **94** cubic complement types has a strictly positive balanced maxcut bound for directed triangles. Their exact classwise lower-bound distribution is:

    bound  4  6  7  8  9 10 11 12 14 16
    count  2  3  4 18 23 22  8 12  1  1

The minimum four is sharp; cyclic steps 1..4 on Z/12 attain four. This classification is a second route, **not a necessary premise**, for the analytic d=4 theorem.

An independent standard-library-only bitset verifier checked all 94 cases; plus 1,440 generated critical-order orientations (1,434 irregular) for d=3..6; the codegree gate improved on the earlier variance-only bound in 1,176 cases, with a maximum improvement of 15. Twenty exact sharp cyclic controls passed. There are 101 complement triangle occurrences with exactly six eligible exterior vertices, and 78 complement edges with codegree d-2=2; these attest the individual combinatorial constants cannot simply be increased/decreased.

## Reproducibility and research scope

The full cumulative **five-page PDF**, its LaTeX source, 85 connected graph6 records, the 94 graph-class JSON with constrained cuts, generation sources, independent exact verifier, machine-readable certificate and SHA-256 manifest are supplied as the conversation artifact **Project004_Attack004_Complete.zip**. This GitHub file is the public mathematical checkpoint; the binary pack has **not** been fully pushed to GitHub.

Manifest SHA-256:
- PDF: `88bcd020a7e5df08abaee125f45ed9cb9b91de58ef35f4f3fb076337efd88945`.
- Cumulative TeX: `6ebf8b1b2c04027ed6270598ae29303e7d371843ad3439709d34b853272e42b9`.
- 85-connected graph6: `8b9ceadb3cc6b4287c41aed4b2e8f5115cb27f9ce1eb59e84ed6aa2e9bbdcfa7`.
- Full 94-type ledger: `822d503bb014d5fa2f47710d92666fb4b65399a2fda2990c17b3fb5b51163e97`.
- Independent Attack004 certificate: `f966b3ee08b31330bed73af64b82a2917c5a8419c23ab658e443eb8e71236120`.

No unrestricted (n/3) proof, no improvement over the published 0.3465n outdegree threshold, no verified originality, and no Lean-kernel compilation. Next attack is the d=6 balanced barrier, using refined edge-codegree-graded charging instead of the coarse maximum d-2.

Literature: Meringer, *Fast Generation of Regular Graphs and Construction of Cages*, J. Graph Theory 30 (1999), 137–146; https://www.mathe2.uni-bayreuth.de/markus/reggraphs.html ; Caccetta and Häggkvist (1977); Hladký–Král'–Norin (2017).
