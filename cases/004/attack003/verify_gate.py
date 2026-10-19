#!/usr/bin/env python3
"""Lightweight, standalone exact CI replay of Paper004 Attack003.
The full 8400-case dual-algorithm verifier is a separate conversation artifact.
"""
import itertools, random

def verify(n,arcs):
    arcs=set(arcs)
    assert all(a!=b and (b,a) not in arcs for a,b in arcs)
    A=[sum(u==v for u,w in arcs) for v in range(n)]
    B=[sum(w==v for u,w in arcs) for v in range(n)]
    G={tuple(sorted(pair)) for pair in arcs}
    H=set(itertools.combinations(range(n),2))-G
    c3=sum(((a,b) in arcs and (b,c) in arcs and (c,a) in arcs) or
           ((a,c) in arcs and (c,b) in arcs and (b,a) in arcs)
           for a,b,c in itertools.combinations(range(n),3))
    tH=sum(all(e in H for e in itertools.combinations(t,2))
           for t in itertools.combinations(range(n),3))
    S=0
    for v in range(n):
        I={u for u,w in arcs if w==v}
        O={w for u,w in arcs if u==v}
        S+=sum(u in I and w in I or u in O and w in O for u,w in H)
    R=[n-1-A[v]-B[v] for v in range(n)]
    assert 2*c3 == sum(a*b for a,b in zip(A,B))-n*(n-1)*(n-2)//6 + sum(r*(r-1)//2 for r in R)-2*tH+S
    if len(set(A))==1 and n==3*A[0]:
        d=A[0]; V=sum((b-d)**2 for b in B)
        assert 4*c3==4*d+V-4*tH+2*S
        assert (V+2*S)%4==0
        assert 3*tH<=sum(r*(r-1)//2 for r in R)
    return c3,tH,S

rng=random.Random(20261019)
checks=0
for d in range(1,8):
    n=3*d
    arcs={(u,(u+k)%n) for u in range(n) for k in range(1,d+1)}
    assert verify(n,arcs)==(d,0,0)
    checks+=1
    for _ in range(50):
        modified=set(arcs)
        for __ in range(5):
            u,v=rng.choice(sorted(modified))
            avail=[w for w in range(n) if w!=u and (u,w) not in modified and (w,u) not in modified]
            if avail:
                w=rng.choice(avail)
                modified.remove((u,v));modified.add((u,w))
        verify(n,modified)
        checks+=1
print("PASS",checks,"exact graph certificate checks")
