# Case 004 — Attack 003: exact critical indegree-variance identity

19 October 2026. Author: Tony Newton, Newton Astro Labs.

## Exact mathematical theorem

Let D be a simple oriented graph, G its underlying graph, and H its complement. Write a_v=outdegree, b_v=indegree, r_v=degree in H. Let c3(D) count directed triangles, t(H) count undirected complement triangles, and S be the sum, over vertices v, of H-edges internal to N+(v) or to N-(v).

GENERAL IDENTITY (arbitrary simple oriented graphs):
  2 c3(D) = sum_v a_v b_v - binom(n,3) + sum_v binom(r_v,2) - 2 t(H) + S.

The proof is a three-vertex type count combined with directed-two-path double counting and does not rely on numerical sampling.

CRITICAL INDEGREE-VARIANCE IDENTITY:
For n=3d, outdegree d everywhere, V=sum_v (b_v-d)^2:
  c3(D) = d + V/4 - t(H) + S/2.

Thus any hypothetical triangle-free critical outregular graph must have t(H)>=d+V/4. We also have V+2S congruent to 0 mod 4. Since 3t(H)<=sum_v binom(r_v,2), a degree-only bound follows:
  c3(D) >= ceil( d - d(d-1)(d-2)/2 + V/12), if positive.

Combining the V>0 branch of this inequality with the complete V=0 n=9 case from Attack 002 gives a self-contained proof that every 3-outregular oriented 9-vertex graph has a directed triangle (an established small-degree result, not claimed new).

INFINITE SHARP RESTRICTED FAMILY: If H is triangle-free then c3(D)>=d. For every d>=1, arcs x->x+s on Z/(3d) for 1<=s<=d have c3(D)=d, no triangles in H, and V=S=0. Exact uniform proof is included in the manuscript.

## Final exact audit

- 8,400 critical outregular graph orientations tested with two independent exact algorithms: unordered triples and bitset closed walks.
- 5,943 irregular-indegree cases; 3,656 complements containing triangles; 7,985 strictly positive variance-only certificates.
- 4,096 exhaustive orientations of K6 minus a 3-edge matching checked, with exactly 38 valid 2-outregular orientations; triangle-count histogram: 2->8, 4->12, 5->16, 8->2.
- 40 sharp cyclic witnesses directly enumerated, d=1..40.
- Six n=3d+1 directed-triangle-free controls ensure the critical-order condition is not silently generalized.

Full paper PDF, LaTeX, main independent verifier, exhaustive n=6 checker, sharpness checker, JSON certificates, SHA-256 manifest and standalone reproducibility ZIP have been created as downloadable conversation artifacts. The complete full-size source is not automatically replicated to this lightweight GitHub checkpoint.

SHA256 certificate: 87b114c885e88e3357d5ccd96ace626fbfa7e55e47d19a24627ecfb3cf1f38a1.
SHA256 manuscript PDF: 49c74c57fb2e935be72e59f3c6e4e5065a5ecba3841a6070278d5da38c6a2d66.

LIMITS: No universal proof of Caccetta-Haggkvist, no improvement of the unrestricted 0.3465n threshold, no substantiated priority/novelty claim, and no Lean-kernel proof. The classical directed-triangle problem remains open. Literature audit and specialist review needed.

Reference target: https://lemon.cs.elte.hu/egres/open/Caccetta-H%C3%A4ggkvist_conjecture.
