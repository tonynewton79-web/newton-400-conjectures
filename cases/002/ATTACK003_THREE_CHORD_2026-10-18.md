# Project 02 — Attack 003: Triple-Crossing Wheels (18 October 2026)

Theorem-level contribution: for a wheel with six successive positive rim-gap lengths \`g=(a,b,c,d,e,f)\`, and three pairwise-crossing added chords joining opposite terminals, the exact number of unoriented simple cycles is

\`\`\`
T(g)=(14*m*m-5*sum(g[i]*g[i])-2*sum(g[i]*g[(i+1)%6])-39*m+72)/2,
m=sum(g).
\`\`\`

**Proof mechanism:** For any fixed rim-chord diagram with all rim vertices connected to a single hub, the count is a total-degree-at-most-two polynomial in gap increments \`g_i-1\`: cycles without the hub depend only on the chord skeleton, while cycles through the hub correspond bijectively to simple paths with at most two endpoint choices in subdivided segments. Six orbit representatives suffice for the symmetric three-chord matching. Exact anchor values are 150, 212, 283, 287, 288, 288 for the positive gap vectors (1,1,1,1,1,1), (2,1,1,1,1,1), (3,1,1,1,1,1), (2,2,1,1,1,1), (2,1,2,1,1,1), (2,1,1,2,1,1). The implied binomial-basis coefficients are 62 for a single increment, 9 for its second difference, 13 for adjacent cross-differences, and 14 for nonadjacent cross-differences.

**Independent verification:** Exhaustive simple-cycle DFS agreed for all 924 six-gap compositions with 6<=m<=12. A separate subset-path DP independently checked the six anchors. A self-contained standard-C++17 exhaustive search (no prior cached data) enumerated 2,705,284,800 four-variable gap combinations with m<=260 and confirmed a complete interval [10120,418785], 408,666 consecutive cycle counts. The earlier two-chord interval [1897,26222] overlaps, giving **every integer in [1897,418785], 416,889 consecutive counts**. Each is realized by a simple 3-connected wheel with at most 261 vertices.

Full 416,889-row reproducibility CSV SHA-256:

\`f2bc5910569d1ac26958c2a7a201d1d4c0828b808ca341088a0a0984bc31b6c8\`

Rebuild from the included [C++ sweep](rebuild_attack003.cpp). The PDF manuscript, CSV and Python validators were generated as separate conversation artifacts and may be added to this repository in later source uploads.

**Status:** CERTIFIED_FORMULA_AND_FINITE_416889_INTERVAL; FULL_COFINITE_CLASSIFICATION_HOLD. No novelty or priority judgment has been made. The 2026 3-connected graph missing-cycle-count conjecture of McCulloch–McKay–Salahshoori–Zaslavsky is not claimed resolved. Next: prove an interval propagation mechanism uniform in rim size or find a provably cofinite graph family.

Reference: https://doi.org/10.1007/s00373-026-03047-3
