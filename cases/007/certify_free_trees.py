#!/usr/bin/env python3
"""Enumerate nonisomorphic trees and compare exact integer product intervals."""
import argparse
from math import isqrt
import networkx as nx
COUNTS={5:3,6:6,7:11,8:23,9:47,10:106,11:235,12:551,13:1301,14:3159,15:7741,16:19320}
M=1<<40
def signature(G):
    deg=dict(G.degree())
    return tuple(sorted((min(deg[u],deg[v]),max(deg[u],deg[v])) for u,v in G.edges()))
def sun(n):
    k=(n-2)//3;d=n-k-1
    G=nx.Graph();G.add_nodes_from(range(n))
    for i in range(1,d+1):G.add_edge(0,i)
    for i in range(k):G.add_edge(i+1,d+i+1)
    return G
def bounds(G):
    deg=dict(G.degree());sl=sh=rl=rh=0
    for u,v in G.edges():
        s=deg[u]**2+deg[v]**2;L=isqrt(s*M*M);H=L+int(L*L!=s*M*M)
        sl+=L;sh+=H;rl+=(M*M)//H;rh+=(M*M+L-1)//L
    return sl*rl,sh*rh
def main():
    p=argparse.ArgumentParser();p.add_argument('--min',type=int,default=5);p.add_argument('--max',type=int,default=16)
    a=p.parse_args();total=0
    for n in range(a.min,a.max+1):
        G=sun(n);ref,_=bounds(G);sig=signature(G);count=equal=0;best=0
        for T in nx.nonisomorphic_trees(n):
            count+=1
            if signature(T)==sig:
                equal+=1;continue
            _,upper=bounds(T)
            assert upper<ref,(n,count,upper,ref)
            best=max(best,upper)
        assert count==COUNTS[n] and equal==1,(n,count,equal)
        total+=count
        print(n,count,'unique',equal,'gap_numerator',ref-best)
    if a.min==5 and a.max==16:assert total==32503
    print('TOTAL_TREES',total)
if __name__=='__main__':main()
