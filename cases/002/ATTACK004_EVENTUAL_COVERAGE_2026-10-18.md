# Paper 002 — Attack 004: eventual cycle-count coverage (18 October 2026)

**Research status: CANDIDATE_COFINITE_PROOF — arithmetic checks exact, dependent on classical Tartakowsky local-global theorem; independent specialist assessment still pending.**

## Theorem

There exists N_* such that every integer N>=N_* equals the number of (unoriented) simple cycles of a finite **three-connected simple graph**. The graph can be a wheel with three pairwise-crossing rim chords. This is **not** a proof of the exact list of exceptions conjectured by McCulloch, McKay, Salahshoori, and Zaslavsky (2026), Section 6(a). It provides no effective numeric value for N_*.

## Exact graph polynomial (proved by chord-diagram quadraticity and six independent integer cycle-count anchors)

Let six consecutive positive rim gap lengths be g=(g_1,...,g_6), m=sum g_i, and add rim chords between opposite terminals (1,4),(2,5),(3,6) to W_m. Then

    T(g) = [14m^2 - 5 sum_i g_i^2 - 2 sum_i g_i*g_(i+1) - 39m + 72]/2

(indices cyclic). Every graph is simple and three-connected. Six exact anchor counts are 150,212,283,287,288,288; a separate direct cycle-enumeration program matched all 924 cases with 6<=m<=12. See Attack 003 for certificate and proof.

Put g_i=t+x_i with x_i integers and sum_i x_i=0. Then

    T(g) = C(t) - Q(x),    C(t)=231t^2-117t+36,
    Q(x) = [5 sum_i x_i^2 + 2 sum_i x_i*x_(i+1)]/2.

Here Q is integer-valued on the root lattice sum x_i=0, and

    Q(x) = (3/2) sum_i x_i^2 + (1/2) sum_i (x_i+x_(i+1))^2
         >= (3/2) sum_i x_i^2.

Eliminate x_6=-sum_{j=1}^5 y_j, defining an integer-valued positive definite quadratic form q(y) in five independent integer variables. Its Hessian A is

    [8  5  4  4  3]
    [5 10  6  5  4]
    [4  6 10  6  4]
    [4  5  6 10  5]
    [3  4  4  5  8]

with determinant 10,368=2^7*3^4, and Gram determinant det(A/2)=324.

## Local representation audit

For every prime p and every n in the p-adic integers Z_p, q(y)=n is solvable over Z_p.

* p>=5: A is nonsingular modulo p; a nondegenerate quadratic form in dimension five over F_p contains a hyperbolic plane. Every residue is represented nonsingularly and Hensel lifts.
* p=2: q(e_4)=5 and q(e_5)=4 give residues 1 and 0, respectively; A e_4 and A e_5 each have odd entries, so both classes Hensel lift.
* p=3, n a unit: q(e_1)=4 gives residue 1; q(e_2)=5 gives residue 2, both with gradients nonzero modulo 3.
* p=3, n divisible by 3: let

      K = [2 0 2; 2 1 1; 1 0 0; 0 1 0; 0 0 1]
      P = [27 10 19; 10 5 7; 19 7 15].

  Exact integer multiplication gives A K=0 (mod 3) and q(Kz)=3 q_3(z), where q_3(z)=z^T P z. Vectors z=(1,0,0),(1,1,0),(0,1,0) yield q_3 residues 0,1,2 respectively, and each gradient 2Pz is nonzero modulo 3. Hence q_3 represents every element of Z_3 by Hensel and q represents all of 3Z_3.

The five-variable positive definite integral form q is therefore locally universal. **Tartakowsky's theorem (1929)** (quoted for example by Hsia–Kitaoka–Kneser 1978 or Hanke 2004) gives a *fixed but unspecified* D_0 such that q represents every integer D>=D_0.

## Overlapping interval proof

For t positive let M_t=floor(3(t-1)^2/2). Whenever D_0<=D<=M_t, the norm inequality implies |x_i|<=sqrt(2D/3)<=t-1, so all g_i=t+x_i are positive. Thus the triple-crossing wheel realizes **every** integer in

    I_t = [C(t)-M_t, C(t)-D_0].

Now C(t+1)-C(t)=462t+114, while M_(t+1)=floor(3t^2/2). Consequently

    M_(t+1) >= 462t+113+D_0

for all sufficiently large t, making I_t and I_(t+1) overlap or adjacent. Their upper endpoints diverge to infinity. Hence their union contains every integer from some N_* onward. The theorem follows.

## Reproducibility and limits

* The [previous finite exact ledger](ATTACK003_THREE_CHORD_2026-10-18.md) certifies 416,889 consecutive values, [1897,418785], with a separately reproducible witness digest.
* The updated four-page manuscript, editable LaTeX, exact arithmetic verifier, and JSON certificate are available as artifacts of the October 18 conversation.
* This argument uses Tartakowsky's established theorem; it is a rigorous proof programme with individually checkable finite computations, **not** a novelty certificate and not a complete resolution of the precise exceptional list.
* Prior-art review and independent proof review are outstanding. In particular, D_0 and N_* remain non-effective.

References: McCulloch–McKay–Salahshoori–Zaslavsky, *The Cycle Counts of Graphs*, Graphs and Combinatorics 42, article 53 (2026), https://doi.org/10.1007/s00373-026-03047-3 ; Hsia–Kitaoka–Kneser, *Representations of positive definite quadratic forms*, J. Reine Angew. Math. 301 (1978), 132–141, https://doi.org/10.1515/crll.1978.301.132 ; Jonathan Hanke, *Some Recent Results about (Ternary) Quadratic Forms*, 2004, https://web.math.princeton.edu/~jonhanke/Web-02/Ternary-QF-Survey/Ternary-QF-Survey.pdf.
