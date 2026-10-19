"""Finite witnesses for an elementary CRT obstruction to bounded López parameters.

For K >= 1, put L_K = lcm(4k-1, 1 <= k <= K).
If p = 1 (mod 24 L_K), none of López Types A, B or C can have dr <= K.
Dirichlet's theorem provides infinitely many such primes for each K.
The examples verified here are not a computational proof of Dirichlet.
"""
from math import gcd, isqrt


def is_prime(n):
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    return all(n % t for t in range(3, isqrt(n) + 1, 2))


def first_parameter(p, upto):
    for k in range(1, upto + 1):
        m = 4 * k - 1
        for d in range(1, isqrt(k) + 1):
            if k % d:
                continue
            for dd in {d, k // d}:
                r = k // dd
                if (p + 4 * dd) % m == 0:
                    return k, dd, r, "A"
                if (p + r) % m == 0:
                    return k, dd, r, "B"
    return None


EXAMPLES = (
    (1, 72, 73, 2),
    (2, 504, 1009, 3),
    (3, 5544, 16633, 4),
    (4, 27720, 55441, 5),
    (5, 526680, 526681, 12),
    (6, 12113640, 36340921, 10),
    (7, 109022760, 327068281, 30),
    (8, 3379705560, 10139116681, 10),
    (9, 3379705560, 10139116681, 10),
    (10, 43936172280, 131808516841, 20),
)


def main():
    L = 1
    for K, modulus, p, minimum in EXAMPLES:
        k = 4 * K - 1
        L = L * k // gcd(L, k)
        assert modulus == 24 * L
        assert is_prime(p) and p % modulus == 1
        for product in range(1, K + 1):
            m = 4 * product - 1
            assert (p - 1) % m == 0
            for d in range(1, product + 1):
                if product % d:
                    continue
                r = product // d
                assert (p + 4 * d) % m != 0
                assert (p + r) % m != 0
                # Type C: m cannot divide (2d)^2+1 when m=3 mod 4.
                assert (p + 4 * d * d) % m != 0
        assert first_parameter(p, K) is None
        witness = first_parameter(p, minimum)
        assert witness is not None and witness[0] == minimum
        print("K", K, "prime", p, "first product", minimum, "witness", witness)
    print("PASS: all 10 CRT examples exclude Types A, B and C.")


if __name__ == "__main__":
    main()
