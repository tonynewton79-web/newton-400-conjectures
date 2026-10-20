#!/usr/bin/env python3
"""Exact angular H8 stress-budget screening, dual cuts and manufactured source.

The functional-analytic Hahn--Banach proof is in Appendix U; this script
checks its exact finite graph analog and source coefficients. It does NOT
certify the final unfrozen Navier--Stokes prepared source or analytic inverse.
"""
from fractions import Fraction as F
from itertools import combinations
import sympy as s

kap=F(15971,122900)
a=kap/2;b=kap/8
assert a==F(15971,245800) and b==F(15971,983200)
assert a+b==F(15971,196640)==5*kap/8
print('PASS exact anisotropic seven-ray angular capacities and singleton cut')

V=((0,0),(1,0),(0,1),(1,1))
E=(((0,0),(1,0),a), ((0,1),(1,1),a),
   ((0,0),(0,1),b), ((1,0),(1,1),b))
def cut_deficit(src):
    violations=[];tight=[]
    for n in range(1,1+len(V)):
        for vertices in combinations(V,n):
            cut=set(vertices)
            demand=sum((src.get(v,F(0)) for v in cut),F(0))
            cap=sum((c for u,v,c in E if (u in cut)!=(v in cut)),F(0))
            if abs(demand)>cap:violations.append((vertices,demand,cap))
            if abs(demand)==cap:tight.append((vertices,demand,cap))
    return violations,tight

for q,should_pass in ((kap,False),(kap/4,True),(a,True)):
    src={(0,0):q,(1,0):-q,(0,1):F(0),(1,1):F(0)}
    assert all(src[(0,z)]+src[(1,z)]==0 for z in (0,1))
    fail,tight=cut_deficit(src)
    assert (not fail)==should_pass
    if should_pass:
        assert q<=a
        print('PASS all 15 nonempty exact cuts and explicit radial edge flow q=',q)
    else:
        singleton=next((d,c) for nodes,d,c in fail if set(nodes)=={(0,0)})
        assert singleton==(kap,a+b) and singleton[0]-singleton[1]==3*kap/8
        print('PASS singleton radial-cut violation despite all zero axial slice sums, gap',3*kap/8)

r,z=s.symbols('r z',positive=True)
rho=s.Function('rho')(r,z);alpha=s.symbols('alpha',real=True)
f=alpha*s.diff(r**2*rho,r)
assert s.simplify(f-r**2*alpha*(s.diff(rho,r)+2*rho/r))==0
print('PASS exact manufactured angular source f=alpha d_r(r²rho)')
for aa,expected in ((kap/4,'PASS'),(kap/2,'SHARP'),(kap,'FAIL')):
    coefficients=(F(0),2*aa,-2*aa,F(0),F(0),F(0),F(0))
    cost=max(abs(v) for v in coefficients)
    assert cost==2*aa
    got='PASS' if cost<kap else 'SHARP' if cost==kap else 'FAIL'
    assert got==expected
    print('PASS exact',got,'angular cone cost at alpha',aa)
for C in (F(-3,20),F(0),F(1,100),F(2,5)):
    for B in (F(-1,5),F(0),F(1,100)):
        coeffs=[F(0),2*C,-2*C,-8*B,8*B,8*B,-8*B]
        assert max(map(abs,coeffs))==max(2*abs(C),8*abs(B))
print('PASS exact joint anisotropic angular coefficient norm')
print('OPEN: smooth weak-solution upgrade, original source coefficients, meridional stress, (249), (272)/(273)')
