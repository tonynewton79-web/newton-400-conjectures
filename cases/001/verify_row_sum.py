#!/usr/bin/env python3
"""Independent exact finite audit of cycle reciprocal-distance shell row sums.

All arithmetic uses Python integers and fractions.Fraction. A finite
verification supports but DOES NOT formally prove the all-n lemma.
"""
from fractions import Fraction
import hashlib
import json

rows = []
shell_checks = 0
sum_checks = 0
for n in range(4, 161):
    m = n // 2
    expected_row_sum = 2 * sum(
        (Fraction(1, k) for k in range(1, m + (n % 2))),
        Fraction(0))
    if n % 2 == 0:
        expected_row_sum += Fraction(1, m)
    for u in range(n):
        histogram = [0] * (m + 1)
        actual_row_sum = Fraction(0)
        for v in range(n):
            if v == u:
                continue
            d = min((v-u) % n, (u-v) % n)
            assert 1 <= d <= m
            histogram[d] += 1
            actual_row_sum += Fraction(1, d)
        for d in range(1, m + 1):
            cardinality = 1 if n % 2 == 0 and d == m else 2
            assert histogram[d] == cardinality, (n, u, d)
            shell_checks += 1
        assert actual_row_sum == expected_row_sum, (n, u)
        sum_checks += 1
    rows.append((n, expected_row_sum.numerator, expected_row_sum.denominator))
assert len(rows) == 157
report = dict(
    status="PASS_EXACT_FINITE_AUDIT_NOT_UNIVERSAL_LEAN_PROOF",
    n_range=[4, 160],
    shell_cardinality_checks=shell_checks,
    row_sum_checks=sum_checks,
    distinct_cycle_orders=len(rows),
    rows_sha256=hashlib.sha256(
        json.dumps(rows, separators=(',', ':')).encode()).hexdigest(),
    pending_lean="universal shell-cardinality formula and adjacency eigenvalue ordering"
)
print(json.dumps(report, indent=2))
