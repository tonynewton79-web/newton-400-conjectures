"""Exact López Type C search alongside the original Type A/B tests.

The three types are classical (López 2024); no universal existence theorem is
assumed. All identities are verified with integer arithmetic and Fractions.
"""
from collections import Counter
from fractions import Fraction
from math import isqrt
from verify import primes_to, first_witness

LIMIT = 500_000


def first_abc(p, stop):
    for k in range(1, stop + 1):
        m = 4 * k - 1
        for d in range(1, isqrt(k) + 1):
            if k % d:
                continue
            for dd in sorted({d, k // d}):
                r = k // dd
                if (p + 4 * dd) % m == 0:
                    return (k, dd, r, "A")
                if (p + r) % m == 0:
                    return (k, dd, r, "B")
                if (p + 4 * dd * dd) % m == 0:
                    return (k, dd, r, "C")
    return None


def verify_c(p, d, r):
    m = 4 * d * r - 1
    assert (p + 4 * d * d) % m == 0
    assert (d + r * p) % m == 0
    v = (d + r * p) // m
    assert v > 0 and 4 * d * r * v == d + r * p + v
    a, b, c = r * v * p, d * v, d * r * p
    assert Fraction(1, a) + Fraction(1, b) + Fraction(1, c) == Fraction(4, p)
    return (a, b, c)


def main():
    hard = [p for p in primes_to(LIMIT) if p % 24 == 1]
    best = []
    for p in hard:
        w = first_abc(p, isqrt(p))
        assert w is not None and w[0] <= isqrt(p)
        if w[3] == "C":
            verify_c(p, w[1], w[2])
        best.append((p, w))
    pmax, wmax = max(best, key=lambda x: x[1][0])
    assert (len(best), pmax, wmax) == (5137, 255049, (92, 2, 46, "C"))
    counts = Counter(w[3] for _, w in best)
    assert counts == {"A": 3112, "B": 1864, "C": 161}
    for p, expected in (
        (2521, (12, 4, 3, "C")),
        (83449, (15, 3, 5, "C")),
        (1135844089, (14, 2, 7, "C")),
    ):
        w = first_abc(p, 7140)
        assert w == expected
        a, b, c = verify_c(p, w[1], w[2])
        original = first_witness(p, 7138)
        assert original is not None and w[0] < original[0]
        print("Type C improvement:", p, "old", original, "new", w,
              "denominators", (a, b, c))
    print("prime sample:", len(best), "max minimal ABC product:", wmax[0],
          "attained at", pmax)
    print("first-witness types:", dict(counts))
    print("PASS: exact Type C identities and entire sample independently enumerated")


if __name__ == "__main__":
    main()
