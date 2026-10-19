#!/usr/bin/env python3
"""Exact, finite verification for shifted-factor Erdős–Straus tests.

No universal prime-existence claim is implemented or inferred.
"""
from math import isqrt
from fractions import Fraction

LIMIT = 500_000
DS = (1, 2, 3, 6)


def primes_to(n):
    sieve = bytearray(b'\x01') * (n + 1)
    sieve[:2] = b'\x00\x00'
    for k in range(2, isqrt(n) + 1):
        if sieve[k]:
            sieve[k * k::k] = b'\x00' * ((n - k * k) // k + 1)
    return [k for k in range(2, n + 1) if sieve[k]]


def trial_prime(n):
    return n >= 2 and all(n % q for q in range(2, isqrt(n) + 1))


def factor_filter(p, d, mode):
    """Look for a <=sqrt(N) divisor -1 mod 4d; check dr<=sqrt(p)."""
    n = p + 4 * d if mode == 'A' else 4 * d * p + 1
    if mode == 'A' and p % (4 * d) != 1:
        return None
    for q in range(4 * d - 1, isqrt(n) + 1, 4 * d):
        if n % q:
            continue
        r = (q + 1) // (4 * d)
        if d * r > isqrt(p):
            continue
        other = n // q
        if mode == 'A':
            t = other
            u = r * t - 1
            assert u > 0 and 1 + u + r * p == 4 * d * r * u
            a, b, c = d * u, d * r * p, d * u * r * p
        else:
            assert other % (4 * d) == 4 * d - 1
            u = r
            v = (other + 1) // (4 * d)
            assert p + u + v == 4 * d * u * v
            a, b, c = d * u * v, d * u * p, d * v * p
        assert a > 0 and b > 0 and c > 0
        assert Fraction(1, a) + Fraction(1, b) + Fraction(1, c) == Fraction(4, p)
        return d, r, mode, q
    return None


def first_witness(p, stop):
    """Independently scan every smaller product with both divisor orientations."""
    for k in range(1, stop + 1):
        m = 4 * k - 1
        for d in range(1, isqrt(k) + 1):
            if k % d:
                continue
            for d0 in (d, k // d):
                r = k // d0
                if (p + 4 * d0) % m == 0:
                    return k, d0, r, 'A'
                if (p + r) % m == 0:
                    return k, d0, r, 'B'
    return None


def main():
    assert trial_prime(68821)
    assert trial_prime(1135844089)
    assert 68821 % 24 == 13
    assert 1135844089 % 24 == 1
    assert first_witness(68821, 319) == (319, 11, 29, 'B')
    hard = first_witness(1135844089, 7138)
    assert hard == (7138, 86, 83, 'A'), hard
    assert 1135844089 + 4 * 86 == (4 * 86 * 83 - 1) * 39783
    ps = [p for p in primes_to(LIMIT) if p % 24 == 1]
    counts = {d: 0 for d in DS}
    solved = 0
    exceptions = []
    for p in ps:
        filters = {}
        for d in DS:
            for mode in 'AB':
                hit = factor_filter(p, d, mode)
                if hit is not None:
                    filters.setdefault(d, hit)
            if d in filters:
                counts[d] += 1
        if filters:
            solved += 1
        else:
            exceptions.append(p)
    assert (len(ps), solved, len(exceptions)) == (5137, 5078, 59)
    assert counts == {1: 3902, 2: 4299, 3: 2623, 6: 1471}
    # Independently solve the 59 cases missed by the four fixed-d filters,
    # using an exhaustive all-divisor scan with product <= floor(sqrt(p)).
    residual = []
    for p in exceptions:
        w = first_witness(p, isqrt(p))
        assert w is not None, f'Unexpected unresolved prime {p}'
        k, d, r, mode = w
        m = 4 * k - 1
        if mode == 'A':
            t = (p + 4 * d) // m
            u = r * t - 1
            assert 1 + u + r * p == 4 * d * r * u
            a, b, c = d * u, d * r * p, d * u * r * p
        else:
            v = (p + r) // m
            assert p + r + v == 4 * d * r * v
            a, b, c = d * r * v, d * r * p, d * v * p
        assert min(a, b, c) > 0
        assert Fraction(1, a) + Fraction(1, b) + Fraction(1, c) == Fraction(4, p)
        residual.append((p, k, d, r, mode))
    assert max(row[1] for row in residual) == 170
    print('p == 1 (mod 24), p <= 500000:', len(ps))
    print('sqrt-bounded factorizations found:', solved)
    print('single-d coverage:', counts)
    print('first exceptions to this restricted filter:', exceptions[:20])
    print('all 59 residual primes solved by unrestricted sqrt search; max minimal dr:', max(row[1] for row in residual))
    print('minimal dr for 68821:', first_witness(68821, 319))
    print('minimal dr for 1135844089:', hard)
    print('PASS (finite arithmetic only)')


if __name__ == '__main__':
    main()
