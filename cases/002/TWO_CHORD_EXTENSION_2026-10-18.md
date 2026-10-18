# Case 002: Two-chord wheel cycle-count extension (2026-10-18)

Target: Section 6(a) of [McCulloch–McKay–Salahshoori–Zaslavsky (2026)](https://doi.org/10.1007/s00373-026-03047-3), the conjectural missing cycle-count list for three-connected simple graphs.

## Exact theorem

Let the four distinct terminals A,B,C,D partition the rim into positive edge-lengths (a,b,c,d), with m=a+b+c+d and let

    F(x,y,z) = (x+y-1)(y+z-1) - y(y-1)/2.

For crossing chords AC and BD, the number of cycles using both chords is

    B_cross = (2m^2-a^2-b^2-c^2-d^2-7m+12)/2.

For disjoint noncrossing chords AB and CD (a,c>=2), it is

    B_parallel = 1 + F(a,b,c) + F(a,d,c).

Total count, in either case, is

    c(W_m+e+f) = c(W_m+e) + c(W_m+f) - c(W_m) + B,

where c(W_m)=m(m-1)+1 and
c(W_m+chord of rim distance k)=(3m^2-5m+8+2k(m-k))/2.

**Proof:** Partition cycles by chord incidence (inclusion/exclusion). A cycle using both chords and avoiding the hub must use two rim arcs: there are exactly 2 in the crossing case and 1 in the noncrossing case. A cycle through the hub becomes a simple rim-plus-chords path using both chords after deleting the hub and its incident spokes. Its unique middle rim-only segment must be one of the consecutive-terminal arcs whose endpoints belong to different chords. After fixing that arc, both exterior rim tails must be disjoint. If the complementary arc has tail-region lengths (x,y,z), summing tail endpoints yields F(x,y,z). There are four eligible middle arcs in the crossing case and two in the noncrossing case, yielding the formulas. Each cycle has one unique middle segment. W_m is 3-connected and edge addition preserves this property.

## Finite exact certificate (not a conjecture resolution)

For every N in the inclusive interval **1897..26222**, an explicit 3-connected simple wheel-plus-two-chords graph with exactly N cycles has been found, with m<=95. That is **24,326 consecutive** realizations: 16,135 crossing and 8,191 noncrossing witness rows.

The standalone [replay script](replay_two_chord_interval.py), Python 3 standard library only, regenerates coverage_witnesses.csv and verifies digest:

    5aa3a8e3a260661afce548d7060f2231825511c845ff90c959ab1da5135ade6f

Separately, independent brute-force undirected cycle enumeration and vertex-deletion graph tests passed 161 exhaustive two-chord constructions for all m=4..9; the fuller brute-force checker is distributed as a conversation artifact.

## Claim boundaries

- A genuinely finite interval is certified. **No cofinite/infinite coverage theorem has been established.**
- The 2026 graph conjecture's missing-count classification remains open here.
- Priority/novelty has not been independently settled.
- The two-column paper and full certificate CSV were built as conversation artifacts; this text and reproduction script are the committed text files.
- Next target: prove overlapping complete intervals uniformly in m, or derive a third-chord construction with provably gap-filling images.
