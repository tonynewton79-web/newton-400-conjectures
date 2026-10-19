#!/usr/bin/env python3
"""Exact graph checks of E_{d,k} for finite samples.
|V| = d+k+1, |E| = d+k; squared Sombor edge weights are
d²+1 repeated d-k, d²+4 repeated k, 5 repeated k.
This test is not a proof for all d,k and not a Lean kernel certificate.
"""
from collections import Counter
import argparse
import networkx as nx

def build(d,k):
    assert d>=1 and 0<=k<=d
    g=nx.Graph()
    h=('hub',0)
    g.add_node(h)
    for i in range(d-k):g.add_edge(h,('short',i))
    for i in range(k):
        g.add_edge(h,('long',i))
        g.add_edge(('long',i),('tip',i))
    return g

def check(d,k):
    g=build(d,k)
    assert g.number_of_nodes()==d+k+1
    assert g.number_of_edges()==d+k
    assert nx.is_tree(g)
    assert g.degree(('hub',0))==d
    for i in range(d-k):assert g.degree(('short',i))==1
    for i in range(k):
        assert g.degree(('long',i))==2
        assert g.degree(('tip',i))==1
    actual=Counter(g.degree(u)**2+g.degree(v)**2 for u,v in g.edges())
    expected=Counter()
    expected[d*d+1]+=d-k
    expected[d*d+4]+=k
    expected[5]+=k
    assert actual==expected,(d,k,actual,expected)

if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('--max-degree',type=int,default=80)
    dmax=p.parse_args().max_degree
    total=0
    for d in range(1,dmax+1):
        for k in range(d+1):
            check(d,k)
            total+=1
    print('PASS actual E_{d,k} graphs:',total)
