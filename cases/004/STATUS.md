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
