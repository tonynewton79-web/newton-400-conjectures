# A quantitative almost-all Type A result

Fix \(X\ge X_0\), put \(Q=\lfloor\log\log X\rfloor\), and let
\[
E(X)=\#\{p\le X:\ p\text{ prime},\ p\equiv1\pmod{24},
\ \text{no Type A López solution with } d=1,\
 1\le r\le(Q+1)/4\}.
\]
Then classical analytic number theory yields
\[
E(X)\ll
\frac{X}{\log X\sqrt{\log\log\log X}}\qquad(X\to\infty).
\]
The implicit constant is ineffective in the usual Siegel–Walfisz
argument. This is an almost-all statement, **not** a universal
solution or a positive-density obstruction to one.

## Proof

Let \(\mathcal Q=\{q\le Q:q\equiv3\pmod4,\ q>3,\ q\text{ prime}\}\)
and \(P=\prod_{q\in\mathcal Q}q\), \(M=24P\).
If any \(q\in\mathcal Q\) divides \(p+4\), take
\(r=(q+1)/4\), \(d=1\). Then \(4dr-1=q\mid p+4d\),
so López's Type A identity produces a solution. Consequently,
the primes counted by \(E(X)\) avoid \(p\equiv-4\pmod q\)
for *all* \(q\in\mathcal Q\).

The Chinese remainder theorem counts
\[
\frac{\varphi(M)}{\varphi(24)}
\prod_{q\in\mathcal Q}\left(1-\frac1{q-1}\right)
\]
reduced residue classes modulo \(M\) simultaneously satisfying
\(p\equiv1\pmod{24}\) and all the avoidances.
The elementary Chebyshev estimate
\(\sum_{q\le Q}\log q=O(Q)\) implies
\(M\le(\log X)^C\) for some fixed \(C\). Apply the
Siegel–Walfisz prime-number theorem uniformly to every one
of these classes, choosing an arbitrary power of \(\log X\)
for the error. Summing the errors over at most \(M\) classes gives
\[
E(X)\le
\frac{\operatorname{Li}(X)}{\varphi(24)}
\prod_{q\in\mathcal Q}\left(1-\frac1{q-1}\right)
+O\bigl(X(\log X)^{-4}\bigr).
\]
By the prime-number theorem and Mertens' theorem in the
progression \(3\pmod4\),
\[
\sum_{q\in\mathcal Q}\frac1{q-1}
=\frac12\log\log Q+O(1),
\qquad
\prod_{q\in\mathcal Q}\left(1-\frac1{q-1}\right)
\asymp(\log Q)^{-1/2}.
\]
Since \(Q=\lfloor\log\log X\rfloor\),
\(\log Q=\log\log\log X+O(1/\log\log X)\).
This proves the asserted upper bound.

In fact, the CRT plus Siegel–Walfisz argument gives
an *asymptotic formula* with the explicit finite Euler product;
the present note only needs its upper bound.

## Interpretation and priority

A full-density subset of hard primes has a Type A witness
with \(d=1\) and \(dr=r=O(\log\log X)\). For primes
\(p\asymp X\) this is much smaller than \(\sqrt p\).
The proof says nothing pointwise about the remaining exceptional
primes, however sparse they may be, and so does not imply
Erdős–Straus or the universal square-root strengthening.

All analytic inputs are classical and cited as such. The result is
not presented as a novel prime-sieve technique; see, for example,
Dahan (2026), arXiv:2608.24035, for a more sophisticated
search-depth sieve analysis for exactly this conjecture. The
Lean v4.24 project formalizes only the algebraic congruences
and local obstruction lemmas, **not** the analytic argument.

### References

* M. A. López (2024), *A Complete Congruence System for the
  Erdős–Straus Conjecture*, arXiv:2404.01508.
* B. Dahan (2026), *Sieve dimension and search depth for the
  Erdős–Straus conjecture, n ≡ 1 (mod 24)*, arXiv:2608.24035.
* K. Kedlaya, *Error bounds for primes in arithmetic progressions*,
  section on the Siegel–Walfisz theorem,
  https://kskedlaya.org/ant/chapter-11.html .
* Standard Chebyshev estimates and Mertens theorem in arithmetic
  progressions, as presented in analytic-number-theory texts.
