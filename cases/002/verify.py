#!/usr/bin/env python3
"""Case 002 — independent exact cycle-count and connectivity certificates.

Pure Python, no networkx, floating point, spectral solvers, or random seed.
Each simple undirected cycle is counted exactly twice via two orientations;
its least-numbered vertex is fixed to avoid rotation overcounting.

This checks a construction baseline, NOT the eventual-coverage conjecture.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path

def wheel(m, chord=None):
    assert m >= 3 and (chord is None or 2 <= chord <= m - 2)
    adj = [set() for _ in range(m + 1)]
    def add(u, v):
        assert u != v
        adj[u].add(v); adj[v].add(u)
    for v in range(1, m + 1):
        add(0, v)
        add(v, 1 + v % m)
    if chord is not None:
        add(1, chord + 1)
    return adj

def count_undirected_simple_cycles(adj):
    n = len(adj)
    oriented = 0
    for start in range(n):
        def dfs(v, visited, length):
            total = 0
            for w in adj[v]:
                if w == start and length >= 3:
                    total += 1
                elif w > start and not (visited & (1 << w)):
                    total += dfs(w, visited | (1 << w), length + 1)
            return total
        oriented += dfs(start, 1 << start, 1)
    assert oriented % 2 == 0, "Orientation pairing error"
    return oriented // 2

def connected_after_deletion(adj, removed):
    available = set(range(len(adj))) - set(removed)
    assert available
    root = min(available)
    seen = {root}
    todo = [root]
    while todo:
        u = todo.pop()
        for v in adj[u] & available:
            if v not in seen:
                seen.add(v)
                todo.append(v)
    return seen == available

def three_connected_certificate(adj):
    assert len(adj) >= 4
    return all(connected_after_deletion(adj, gone)
        for gone in itertools.combinations(range(len(adj)), 2))

def expected_wheel(m):
    return m * (m - 1) + 1

def expected_with_chord(m, k):
    assert m >= 4 and 2 <= k <= m - 2
    numerator = 3 * m * m - 5 * m + 8 + 2 * k * (m - k)
    assert numerator % 2 == 0
    return numerator // 2

def verify(max_m=30):
    assert max_m >= 4
    rows = []
    for m in range(3, max_m + 1):
        for k in [None] + list(range(2, m - 1)):
            adj = wheel(m, k)
            observed = count_undirected_simple_cycles(adj)
            expected = expected_wheel(m) if k is None else expected_with_chord(m, k)
            assert observed == expected, (m, k, observed, expected)
            assert three_connected_certificate(adj), (m, k, "not 3-connected")
            rows.append((m, -1 if k is None else k, expected))
    raw = json.dumps(rows, separators=(",", ":"))
    return {"status": "PASS_CONSTRUCTION_BASELINE_NOT_CONJECTURE",
        "target_conjecture_solved": False,
        "max_rim_length": max_m,
        "exact_cycle_count_checks": len(rows),
        "vertex_connectivity_deletion_checks": len(rows),
        "ordered_certificate_rows_sha256": hashlib.sha256(raw.encode()).hexdigest(),
        "wheel_formula": "m*(m-1)+1",
        "one_chord_formula": "(3*m*m-5*m+8+2*k*(m-k))//2"}

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--max-m", type=int, default=30)
    ap.add_argument("--output")
    args = ap.parse_args()
    result = verify(args.max_m)
    print(json.dumps(result, sort_keys=True, indent=2))
    if args.output:
        p = Path(args.output)
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(result, sort_keys=True, indent=2)+"\n")
