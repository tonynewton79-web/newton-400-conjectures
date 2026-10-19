#!/usr/bin/env python3
"""Case 004 Attack002: exact five-class and twelve-positive-control gate."""
from itertools import combinations
def complement(part):
    n=sum(part);H=set()
    if n==6:return n,{(0,3),(1,4),(2,5)}
    start=0
    for m in part:
        assert m>=3
        for i in range(m):
            H.add(tuple(sorted((start+i,start+(i+1)%m))))
        start+=m
    return n,H
def bound(part):
    n,H=complement(part);d=n//3
    G=set(combinations(range(n),2))-H
    T=sum(all(e in G for e in combinations(t,2))
          for t in combinations(range(n),3))
    M=0
    for x in range(n):
        N={v for v in range(n) if tuple(sorted((x,v))) in G}
        assert len(N)==2*d
        M+=max(sum(tuple(sorted((a,b))) in H for a in I for b in N-set(I))
               for I in combinations(sorted(N),d))
    return T,M,max(0,(n*d*d-T-M+1)//2)
for p,t,m,q in [([3,3],8,12,2),([9],30,45,3),
                 ([6,3],29,42,5),([5,4],30,41,5),([3,3,3],27,36,9)]:
    assert bound(p)==(t,m,q),(p,bound(p))
print("PASS 5 exact balanced complement classes")
for d in range(1,7):
    for edit in (False,True):
        n=3*d+(2 if edit else 1)
        D={(u,(u+s)%n) for u in range(n) for s in range(1,d+1)}
        if edit:
            D.remove((0,1));D.add((0,d+1))
        assert len(D)==n*d
        assert all(a!=b and (b,a) not in D for a,b in D)
        assert all(not ((a,b) in D and (b,c) in D and (c,a) in D)
                       and not ((a,c) in D and (c,b) in D and (b,a) in D)
                       for a,b,c in combinations(range(n),3))
print("PASS 12 oriented triangle-free controls")
