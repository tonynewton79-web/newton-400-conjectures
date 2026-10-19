#!/usr/bin/env python3
"""Independent exact test: eclipsed-sun edge labels biject onto undirected edges.

Checks injectivity, surjectivity, depth orientation, all vertex degrees,
connectedness, and the degree-squared Sombor weights. This is a finite
regression test, not a Lean proof of any universally quantified theorem.
"""
import argparse
from collections import Counter, defaultdict

def verify(d,k):
    assert 0 <= k <= d and d >= 1
    hub = ('h',0)
    short = [('s',i) for i in range(d-k)]
    long = [('m',i) for i in range(k)]
    tips = [('t',i) for i in range(k)]
    vertices = {hub,*short,*long,*tips}
    assert len(vertices) == d+k+1
    labels = ([('short',i,hub,short[i]) for i in range(d-k)]
              + [('long',i,hub,long[i]) for i in range(k)]
              + [('tip',i,long[i],tips[i]) for i in range(k)])
    assert len(labels) == d+k
    edge_to_label={}
    neighbors=defaultdict(set)
    depth={hub:0}
    depth.update({v:1 for v in short+long})
    depth.update({v:2 for v in tips})
    for kind,i,u,v in labels:
        assert u != v and depth[u] < depth[v]
        edge=frozenset((u,v))
        assert len(edge)==2 and edge not in edge_to_label,(d,k,kind,i)
        edge_to_label[edge]=(kind,i)
        neighbors[u].add(v);neighbors[v].add(u)
    actual_edges={frozenset((u,v)) for u in vertices for v in neighbors[u]}
    assert set(edge_to_label)==actual_edges
    assert len(actual_edges)==d+k
    degrees={v:len(neighbors[v]) for v in vertices}
    assert degrees[hub]==d
    assert all(degrees[v]==1 for v in short+tips)
    assert all(degrees[v]==2 for v in long)
    observed=Counter()
    byfamily=Counter()
    for edge,(kind,i) in edge_to_label.items():
        u,v=tuple(edge)
        squared=degrees[u]**2+degrees[v]**2
        observed[squared]+=1
        byfamily[kind]+=1
        assert squared=={'short':d*d+1,'long':d*d+4,'tip':5}[kind]
    assert byfamily==Counter({'short':d-k,'long':k,'tip':k})
    expected=Counter()
    expected[d*d+1]+=d-k
    expected[d*d+4]+=k
    expected[5]+=k
    assert observed==expected
    stack=[hub]
    seen=set()
    while stack:
        v=stack.pop()
        if v not in seen:
            seen.add(v);stack.extend(neighbors[v]-seen)
    assert seen==vertices

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--degree',type=int,default=120)
    args=parser.parse_args()
    count=0
    for d in range(1,args.degree+1):
        for k in range(d+1):
            verify(d,k);count+=1
    for d in (151,257,503,1000):
        for k in set((0,1,d//3,d//2,d-1,d)):
            verify(d,k);count+=1
    print(f'PASS Case007 edge-bijection: {count} instances, including degrees 151,257,503,1000.')
