# Case 005 — Erdős–Straus shifted-factor and congruence tests

**Research target:** For primes \(p\equiv1\pmod{24}\), find López Type A or B
parameters \(d,r>0\) with \(dr\le\sqrt p\). This strengthened bound remains
**unproved for all such primes**, as does the Erdős–Straus conjecture itself.
López's wider Type C is examined separately below.

## Exact algebra and factor-pair filters

For positive parameters, López's 2024 paper [arXiv:2404.01508](https://arxiv.org/abs/2404.01508)
defines the Type A and Type B congruences. The basic Type B identity is

\[
p=4duv-u-v\quad\Longleftrightarrow\quad
4dp+1=(4du-1)(4dv-1).
\]

If \(q\mid 4dp+1\) and \(q\equiv-1\pmod{4d}\), the complementary factor
also has residue \(-1\pmod{4d}\). Choosing the smaller factor
\(q\le\sqrt{4dp+1}\) gives \(dr=(q+1)/4\).
For \(d=1,2,3\), this is at most \(\sqrt p\) for \(p\ge5\).
For \(d=6\), the bound **must be checked separately**.

Type A uses \(q=4dr-1\mid p+4d\). If \(p\equiv1\pmod{4d}\),
then the complementary factor also lies in the class \(-1\pmod{4d}\),
and we may choose \(q\le\sqrt{p+4d}\). The corresponding
\(r=(q+1)/(4d)\) satisfies \(dr=(q+1)/4\le\sqrt p\)
for \(p\ge73\), \(d\in\{1,2,3,6\}\).
Writing \(t=(p+4d)/q\) and \(u=rt-1\), one obtains the actual unit
fractions with denominators \(du,\ drp,\ durp\).

The \(d=1\) Type B shifted-factor criterion was also publicly described
in [this August 2026 research note](https://github.com/chasebryan/centl/blob/main/research/erdos-straus/FOUR-P-PLUS-ONE-FILTER.md).
It is not claimed here as a novel discovery. The present combined
screening method likewise requires a careful priority review.

### A density-one corollary (classical analytic input)

**Claim, proved from classical prime distribution results:** Among primes
\(p\equiv1\pmod{24}\), relative density one admit the Type A solution with
\(d=1\), \(r\le\sqrt p\).

Indeed, if a prime \(q\equiv3\pmod4\) divides \(p+4\), the complementary
factor has the same residue because \(p+4\equiv1\pmod4\).
The smaller factor \(a\equiv3\pmod4\) is at most \(\sqrt{p+4}\);
writing \(a=4r-1\) provides the Type A congruence and the bound.

For any **fixed finite** set \(Q\) of primes \(q\equiv3\pmod4\), \(q>3\),
the prime number theorem for arithmetic progressions and the Chinese
remainder theorem give limiting proportion
\(\prod_{q\in Q}(1-1/(q-1))\) of primes \(p\equiv1\pmod{24}\)
that avoid all classes \(p\equiv-4\pmod q\).
The sum \(\sum_{q\equiv3\ (4)}1/q\) diverges, so these finite
products tend to zero as \(Q\) expands.
The exceptional primes consequently have relative upper density zero.
This is not an effective uniform bound for every prime, and this
analytic argument is **not** presently Lean formalized.

## Exact finite regression

Run `python3 cases/005/verify.py`. It enumerates every prime
\(p\equiv1\pmod{24}\) through 500,000 and checks the
\(d\in\{1,2,3,6\}\) symmetric factor filters, insisting on
\(dr\le\lfloor\sqrt p\rfloor\) and verifying each unit-fraction identity
with Python's exact `Fraction` arithmetic.

* 5,137 primes considered; 5,078 covered; 59 not covered by these four
  filters. The unrestricted search verifies all 59 have square-root-bounded
  witnesses; thus **all 5,137 sample primes are covered**.
* The largest true minimal product across all 5,137 primes is
  \(dr=170\), at \(p=83{,}449\), Type A \((d,r)=(17,10)\).
* Separate \(d\)-counts (overlapping): \(d=1\): 3,902;
  \(d=2\): 4,299; \(d=3\): 2,623; \(d=6\): 1,471.
* For \(p=68{,}821\equiv13\pmod{24}\), the least product is
  \(dr=319\) with \(d=11,r=29\), Type B; 319 exceeds
  \(\lfloor\sqrt{68821}\rfloor=262\).
* For \(p=1{,}135{,}844{,}089\equiv1\pmod{24}\), the least product
  is \(dr=7{,}138\), Type A, with \(d=86,r=83\) and
  \(p+4d=(4dr-1)\cdot39783\).

The minimality tests exhaust every smaller integer product and every
factor orientation, independently for each sampled prime. They are *finite
computation*, not a proof for arbitrary primes.



## Type C: the additional López construction

López's Type C, distinct from the two congruences of Conjecture 1,
allows \(4dr-1\mid p+4d^2\). An exact polynomial identity is
\[
r(p+4d^2)-(d+rp)=d(4dr-1).
\]
Thus, with \(v=(d+rp)/(4dr-1)\in\mathbf N\),
\[
4drv=d+rp+v,\qquad
\frac4p=\frac1{rvp}+\frac1{dv}+\frac1{drp}.
\]
These are genuine, positive three-term decompositions whenever
the divisor condition holds.

The earlier two-type square-root counterexample at \(p=68821\)
no longer obstructs a *three-type* version: the minimum Type A/B
product is 319, but Type C has \(d=11,r=19,dr=209\), and
\(209\le\lfloor\sqrt{68821}\rfloor=262\). This does not
settle the three-type conjecture for every prime.

The independently ordered search over *all three* types finds a
much smaller product on some difficult primes. For
\(p=1\,135\,844\,089\), Type A/B first appears at \(dr=7138\),
but Type C first appears at \(d=2,r=7,dr=14\);
\(v=144\,561\,975\). This is a previously defined construction,
not a claimed new universal formula. For the 5,137 hard primes
below 500,000, the largest minimum product falls from 170
(A/B only) to **92** (A/B/C), attained at \(p=255049\) with
\(d=2,r=46\), Type C. With ties resolved in ordered search as
A, B, C, the first-witness types are A: 3112, B: 1864,
C: 161. All first witnesses and the Type C rational identities
are checked in `cases/005/type_c.py`.

## A rigorous obstruction to uniformly bounded López parameters

For any \(K\ge1\), put
\[
L_K=\operatorname{lcm}_{1\le k\le K}(4k-1).
\]
There are infinitely many primes \(p\equiv1\pmod{24L_K}\), by
Dirichlet's theorem. For any \(d,r\ge1\) with \(dr\le K\), write
\(m=4dr-1\). Since \(m\mid L_K\), we have \(p\equiv1\pmod m\).
Type B would require \(m\mid r+1\), contradicting \(0<r+1<m\).
Type A would require \(m\mid4d+1\). If \(r\ge2\), then
\(0<4d+1<m\); if \(r=1\), then \(4d+1=m+2\), so \(m\mid2\),
contradicting \(m\ge3\). Type C would require \(m\mid4d^2+1=(2d)^2+1\), which is
impossible because \(m\equiv3\pmod4\) has a prime factor
\(\ell\equiv3\pmod4\), and \(-1\) is not a quadratic residue
modulo such a prime. Hence none of López's three types has
\(dr\le K\) on this infinite prime progression.

The conclusion is **unboundedness of the least López product across
hard primes**, not failure of the moving square-root upper bound.
This is a standard CRT/Dirichlet-type observation in substance, and
novelty is *not* asserted. It also shows that a universal proof cannot
use a uniform finite parameter cutoff.

The supplementary `cases/005/obstruction.py` replays ten concrete
prime examples, \(K=1,\ldots,10\). The elementary Type A/B local modular theorem is in
`NewtonConjectures/ErdosStrausObstruction.lean`. The full all-K existence
of primes beyond any threshold that exclude both Type A and Type B is
kernel-verified, including the mathlib Dirichlet theorem, in
`NewtonConjectures/ErdosStrausInfinite.lean`.
The Type C extension uses a classical quadratic-nonresidue fact and
is not yet formalized in Lean.

Related contemporary context is Dahan, *Sieve dimension and search
depth for the Erdős–Straus conjecture*,
[arXiv:2608.24035](https://arxiv.org/abs/2608.24035)
(2026). His analysis supplies much deeper search-depth and
finite-shift obstruction results than the elementary argument here.

## Remaining proof problem

We would need a *moving-scale* theorem that guarantees a Type A, B or C
divisor of the indicated form for every hard prime before the
product exceeds \(\sqrt p\). Neither the fixed-\(d\) density-one sieve
nor the unboundedness obstruction supplies such a pointwise theorem.

## Lean and open obligations

`NewtonConjectures/ErdosStraus.lean` contains the unconditional
polynomial factorization, conditional Type A/B/C rational identities,
exact numerical witness statements and squared square-root estimates.
`NewtonConjectures/ErdosStrausObstruction.lean` and
`NewtonConjectures/ErdosStrausInfinite.lean` certify the all-K Type A/B
CRT/Dirichlet obstruction. The pinned Lean 4/mathlib CI of
19 October 2026 passed on GitHub Actions run 39254679999. A dedicated GitHub Actions
workflow compiles the file in the existing pinned Lean 4/mathlib
workspace and independently runs `verify.py`.

**Not proved:** universal López-parameter existence; the square-root
bound for all primes \(1\bmod24\); a Lean theorem about prime
distribution; a kernel proof of the full minimality searches; the Type C nonresidue
obstruction in Lean; and
originality of the elementary factorization and density corollary.

See also Xu,
[Congruence Classes of Supporting the Erdős–Straus Conjecture II:
Wild Solutions](https://arxiv.org/abs/2609.29250) (September 2026).
