# Case 005 — Erdős–Straus shifted-factor and congruence tests

**Research target:** For primes \(p\equiv1\pmod{24}\), find López Type A or B
parameters \(d,r>0\) with \(dr\le\sqrt p\). This strengthened bound remains
**unproved for all such primes**, as does the Erdős–Straus conjecture itself.

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

Run \`python3 cases/005/verify.py\`. It enumerates every prime
\(p\equiv1\pmod{24}\) through 500,000 and checks the
\(d\in\{1,2,3,6\}\) symmetric factor filters, insisting on
\(dr\le\lfloor\sqrt p\rfloor\) and verifying each unit-fraction identity
with Python's exact \`Fraction\` arithmetic.

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

## Lean and open obligations

\`NewtonConjectures/ErdosStraus.lean\` contains the unconditional
polynomial factorization, conditional Type A and B rational identities,
and exact numerical witness statements. A dedicated GitHub Actions
workflow compiles the file in the existing pinned Lean 4/mathlib
workspace and independently runs \`verify.py\`.

**Not proved:** universal López-parameter existence; the square-root
bound for all primes \(1\bmod24\); a Lean theorem about prime
distribution; a kernel proof of the full minimality searches; and
originality of the elementary factorization and density corollary.

See also Xu,
[Congruence Classes of Supporting the Erdős–Straus Conjecture II:
Wild Solutions](https://arxiv.org/abs/2609.29250) (September 2026).
