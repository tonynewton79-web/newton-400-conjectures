"""Finite checks of the small shifted-prime-factor screen.

This file does NOT verify Siegel-Walfisz, Mertens or an asymptotic theorem.
It checks the exact rational CRT Euler product against finite observed counts.
"""
from fractions import Fraction
from verify import primes_to

LIMIT = 500_000
CHECKPOINTS = ((7, 4284), (19, 3643), (43, 3273), (97, 2987),
               (199, 2788), (499, 2671))


def main():
    hard = [p for p in primes_to(LIMIT) if p % 24 == 1]
    assert len(hard) == 5137
    good_q = [q for q in primes_to(499) if q > 3 and q % 4 == 3]
    for cutoff, expected_missed in CHECKPOINTS:
        qs = [q for q in good_q if q <= cutoff]
        missed = sum(all((p + 4) % q for q in qs) for p in hard)
        density = Fraction(1)
        for q in qs:
            density *= Fraction(q - 2, q - 1)
        assert missed == expected_missed
        print("q <=", cutoff, "primes missed:", missed, "of", len(hard),
              "CRT density:", density)
    print("PASS: finite shifted-factor counts; no analytic proof asserted")


if __name__ == "__main__":
    main()
