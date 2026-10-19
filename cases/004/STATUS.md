## Attack 002 — exact complement-cut triangle certificate (19 October 2026)

- **Exact identity, independently reproved:** for an oriented graph D with underlying graph G and simple complement H,
  `sum_v indeg(v)*outdeg(v) = triangles(G) + 2*directed_triangles(D) + sum_v e_H(N-(v),N+(v))`.
- **Orientation-independent necessary gate:** replace each complementary cut count by its maximum over all partitions of `N_G(v)` of prescribed indegree/outdegree sizes. Positive resulting deficit divided by two is a rigorous lower bound on directed triangles.
- **Complete finite graph-type theorem:** on 6 vertices every 2-in/2-out orientation has at least 2 directed triangles; on 9 vertices every 3-in/3-out orientation has at least 3. Every 2-regular complement type of order 9 has been checked exactly: `9:3`, `6+3:5`, `5+4:5`, `3+3+3:9` lower bounds.
- **Two independent integer implementations** agree on all five small-graph-class counts. Twelve sharp triangle-free circulant and irregular-indegree controls, including six degree-irregular perturbations, are correctly given a zero lower bound.
- **Nonexhaustive exploration:** for each of d=4,n=12 and d=5,n=15, 200 fixed-seed random (d-1)-regular complement graphs all have positive deficits. No claim about all complements at either size.
- [Full theorem statement and reproducibility notes](attack002/README.md) and [lightweight exact GitHub CI checker](attack002/verify_gate.py). Full typeset three-page PDF, LaTeX source, main and independent validators, JSON certificate and optional networkx sampling script are supplied as separate conversation artifacts, **not all checked into GitHub**.
- **Research posture:** elementary exact inequality, mathematical correctness supported by double counting and independently checked finite arithmetic. Originality/prior art not established. No unrestricted improvement on the 0.3465n bound, no solution of CH, and no large-order exhaustive claim.

# Case 004 — Caccetta–Häggkvist directed-triangle conjecture

**Opened 19 October 2026. Status: EXACT_RESTRICTED_BASELINE_PASS; GENERAL_CH3_OPEN; NO_NOVELTY_CLAIM.**

## Major open target

For any finite loopless oriented digraph (D) with (n) vertices, prove that minimum outdegree at least (n/3) forces a directed triangle. This is the (k=3) case of Caccetta–Häggkvist (1978). The established unrestricted published sufficient threshold is 0.3465n (Hladký–Král'–Norin, *Combinatorica* 37 (2017), 49–76; <https://doi.org/10.1007/s00493-015-2662-5>). No improved unrestricted threshold is claimed in this case.

## Attack 001 — exact prime-cyclic reconstruction and composite warning

For oriented Cayley digraphs on (mathbb Z_n), a connection set (S) satisfies (Scap(-S)=arnothing). A directed triangle exists exactly when (0in3S).

**Prime order:** A stand-alone proof via Cauchy–Davenport and Vosper shows that if prime (p) and (|S|gelceil p/3ceil), then (0in3S); for (pequiv2pmod3), equality forces (S) to be a symmetric arithmetic progression, contradicting orientation. The sharp triangle-free maximum is (lfloor(p-1)/3floor). **This is a known special case** of Hamidoune's established vertex-transitive result, documented for example in Nathanson, <https://arxiv.org/abs/math/0603469>.

**Exact computation:** All 354,291 oriented cyclic connection sets of orders 3 through 23 were exhaustively tested. For every order, the exact maximal triangle-free degree equals (lfloor(n-1)/3floor). A second bit-parallel checker independently reproduces every maximum, multiplicity, and representative. No random sampling or floating-point arithmetic was used. JSON ledger SHA-256: `ecd575cb74d44f7b6941c884013a9a1451b2a3a4a15846841427566a12e9fb3a`.

**Adversarial composite example:** In (mathbb Z_{12}), (S={1,5}) is oriented and triangle-free, with (2S={2,6,10}), (3S={3,7,11}), and (2S+4=2S). Consequently, a purported extension relying on universal aperiodicity of (2S) fails. This does NOT refute Caccetta–Häggkvist.

## Reproduction

The full two-page PDF, editable TeX, primary Python enumerator, independent checker, JSON ledger and SHA256SUMS are packaged separately as a conversation artifact named `Project004_Attack001_Paper_and_Exact_Certificate.zip`. The GitHub entry is a lightweight checkpoint, not the full source upload. The two standard-library Python programs independently passed in the release environment.

## Next high-value mathematical gate

Leave the established Cayley/vertex-transitive classes. Introduce an exact local out-neighbourhood defect for irregular orientations, test candidate inequalities on directed blow-ups and independently reproducible finite SAT cases, and demand a genuine unrestricted bound improvement before any novelty claim.

**Important:** finite searches and a reconstructed known prime-order theorem do not solve the general conjecture; independent specialist review and priority research remain requirements.
