#!/usr/bin/env python3
"""Attack 003 reproducible boundary-state and nine-sample CSP audit.
Requires networkx to parse sparse6; uses no MILP or floating arithmetic.
The full separate dual-solver matching certificates are in the release packet.
"""
import collections, hashlib, itertools
from pathlib import Path
import networkx as nx

ROOT=Path(__file__).resolve().parent
SHA="b96e8bb9e29137f754bc646da2f11061049b2a93cb48cc5b0db78e76c54fcf5f"
PAIRS=tuple((1<<i)|(1<<j) for i in range(6) for j in range(i+1,6))

def ten_classes():
    counts=collections.Counter()
    for labels in itertools.product(PAIRS,repeat=4):
        members=tuple(sorted(sum(1<<j for j,x in enumerate(labels) if x&(1<<i))
                             for i in range(6)))
        if all(x.bit_count()%2==0 for x in members):
            counts[members]+=1
    assert len(counts)==10 and sum(counts.values())==1725
    assert collections.Counter(sum(mask==15 for mask in sig) for sig in counts)=={0:6,1:3,2:1}
    return counts

def solve(edges,max_nodes=500000):
    n=max(v for edge in edges for v in edge)+1
    adj=[[] for _ in range(n)]
    for i,(u,v) in enumerate(edges): adj[u].append(i);adj[v].append(i)
    assert all(len(x)==3 for x in adj)
    color=[0]*len(edges)
    for ei,v in zip(sorted(adj[0]),(3,12,48)):color[ei]=v
    count=0
    def valid(v):
        used=0
        for ei in adj[v]:
            a=color[ei]
            if used&a:return False
            used|=a
        return True
    def rec():
        nonlocal count
        count+=1
        if count>max_nodes:raise RuntimeError("search-node limit; not a refutation")
        choices=[]
        for v in range(n):
            if not valid(v):return False
            unknown=[e for e in adj[v] if color[e]==0]
            if not unknown:continue
            assigned=len(adj[v])-len(unknown)
            if assigned==0:continue
            remainder=63
            for e in adj[v]:remainder ^=color[e]
            if len(unknown)==1:
                attempts=[(remainder,)] if remainder.bit_count()==2 else []
            else:
                attempts=[(a,remainder^a) for a in PAIRS
                          if (a&remainder)==a and (remainder^a).bit_count()==2]
            admissible=[]
            for variant in attempts:
                for e,x in zip(unknown,variant):color[e]=x
                if all(valid(w) for e in unknown for w in edges[e]):
                    admissible.append(variant)
                for e in unknown:color[e]=0
            if not admissible:return False
            choices.append((len(admissible),-assigned,v,unknown,admissible))
        if not choices:return all(color)
        _,_,v,unknown,attempts=min(choices)
        for option in attempts:
            for e,x in zip(unknown,option):color[e]=x
            if rec():return True
            for e in unknown:color[e]=0
        return False
    assert rec(), "No positive witness found; not an UNSAT certificate"
    for v in range(n):
        mask=0
        for e in adj[v]:
            assert color[e].bit_count()==2
            assert not(mask&color[e])
            mask|=color[e]
        assert mask==63
    for i in range(6):
        pairs=[edges[e] for e,c in enumerate(color) if c&(1<<i)]
        assert len(pairs)==n//2
        incident=collections.Counter(v for uv in pairs for v in uv)
        assert len(incident)==n and set(incident.values())=={1}
    return count

def main():
    counts=ten_classes()
    raw=(ROOT/"source.s6").read_bytes()
    assert hashlib.sha256(raw).hexdigest()==SHA
    graphs=[nx.from_sparse6_bytes(line) for line in raw.splitlines()]
    assert len(graphs)==9
    for i,g in enumerate(graphs,1):
        assert len(g)==44 and g.number_of_edges()==66
        assert nx.is_connected(g) and nx.girth(g)==5
        assert all(d==3 for _,d in g.degree()) and not list(nx.bridges(g))
        edges=sorted(tuple(sorted(e)) for e in g.edges())
        steps=solve(edges)
        print(f"GRAPH {i}/9: PASS 44 vertices, 66 edges, CSP nodes {steps}",flush=True)
    print(f"PASS 9/9 graphs; {sum(counts.values())} even assignments, {len(counts)} label orbits")

if __name__=="__main__":main()
