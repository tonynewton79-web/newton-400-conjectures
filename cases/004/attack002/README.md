# Paper 004 — Attack 002, Complement-Cut Certificates

**Status:** EXACT_ELEMENTARY_IDENTITY_AND_FINITE_BALANCED_GATES_PASS; CH K=3 GENERAL OPEN; novelty unestablished.

## The exact theorem

For any finite oriented graph D with underlying undirected graph G, complement H, vertex in/out-neighbourhoods I_v/O_v of cardinalities b_v/a_v, undirected triangle count t(G), and directed 3-cycle count c3(D), double-counting directed 2-paths gives the exact identity:

    sum_v a_v*b_v = t(G) + 2*c3(D) + sum_v edges_H(I_v,O_v).

Let M_v be the exact max-cut edge count of H induced on N_G(v), over all partitions of sizes b_v and a_v. Hence:

    c3(D) >= max(0, ceil((sum a_v*b_v - t(G) - sum M_v)/2)).

The bound is determined by G and prescribed in/outdegrees, before choosing any orientation.

## Exact classification

For a d-in/d-out oriented graph on n=3d vertices the complementary underlying graph is (d-1)-regular. For d=2, H is a three-edge matching on six vertices: bound 2 directed triangles. For d=3, H is 2-regular on nine vertices and is a cycle union of one of 9, 6+3, 5+4, or 3+3+3. Their respective directed-triangle lower bounds are 3, 5, 5 and 9. All counts are exact integers. This is a restricted quantitative result; the original r=2,3 short-cycle cases were proved decades ago.

## Tests

- `python verify_complement_cuts.py`: proof identity, five graph-structure classes, 12 triangle-free sharp cyclic / irregular-indegree controls, and one directed-cycle negative case.
- `python independent_check.py`: separately implemented adjacency-bitset maxcut enumeration and construction of all twelve triangle-free controls; checks all released small-class numbers without importing the first verifier.
- `attack002_certificate.json`: exact machine-readable results and final SHA256 (recorded in SHA256SUMS.txt).
- Separate non-exhaustive exploratory experiment: 200 independently seeded (d-1)-regular complement graphs for each d=4 (n=12) and d=5 (n=15); every sampled case gave a positive cut deficit. No universal or exhaustive claim is made for d>=4.

The baseline Attack 001 prime-cyclic result is known via Hamidoune. Attack 002 does not lower the Hladky–Kral'–Norin published unrestricted sufficient threshold of 0.3465n. The cut bound's novelty and relations to prior structural inequalities remain for specialist review.

## Next gate

Use the complement-cut deficiency as a sound pruning rule over genuinely irregular in-degree sequences at n=3d, then exact SAT with independently replayable UNSAT proof logs for every graph surviving the filter. Never turn sample rejection or a solver timeout into an infinite theorem.