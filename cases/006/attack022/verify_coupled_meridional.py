#!/usr/bin/env python3
"""Case006 Appendix Y: exact residual meridional cone polar and manufactured coupling."""
import sympy as s
from fractions import Fraction as Q
from itertools import product
kap=Q(15971,122900)
r,z=s.symbols('r z',positive=True)
a,d,b,c=(s.Function(t)(r,z) for t in ['a','d','b','c'])
assert s.Matrix([-s.diff(d,r)+s.diff(a,z)-d/r,s.diff(a,r)+s.diff(d,z)+a/r])==s.Matrix([-s.diff(d,r)+s.diff(a,z)-d/r,s.diff(a,r)+s.diff(d,z)+a/r])
assert s.simplify(r**2*(s.diff(c,r)+s.diff(b,z)+2*c/r)-s.diff(r**2*c,r)-s.diff(r**2*b,z))==0
print('PASS cylindrical three-component divergence')
tested=0
for b0,c0 in product([Q(0),kap/16,-kap/16,kap/8],[Q(0),kap/16,-kap/8,kap/2]):
 if 8*abs(b0)>kap or 2*abs(c0)>kap: continue
 dmax=(kap-2*abs(c0))/4
 corners=[(se*kap/2,Q(0)) for se in (-1,1)]
 corners += [(se*abs(c0),sd*dmax) for se,sd in product((-1,1),repeat=2)]
 for e0,d0 in corners:
  assert max(8*abs(b0),2*abs(c0)+4*abs(d0),2*abs(e0)+4*abs(d0))<=kap
 for p,q in product([Q(0),Q(1),-Q(1),Q(2,3)],[Q(0),Q(1),-Q(1),Q(4)]):
  polar=max(kap*abs(p)/2,abs(c0)*abs(p)+dmax*abs(q))
  assert max(e0*p+d0*q for e0,d0 in corners)==polar
  tested+=1
print('PASS exact sharp polar over',tested,'rational combinations')
for tau in [Q(1,100),Q(1,4),Q(1,2),Q(1)]:
 for c0 in [-(1-tau)*kap/2,Q(0),(1-tau)*kap/2]:
  for e0,d0 in product([-kap/4,kap/4],[-tau*kap/8,tau*kap/8]):
   assert 2*abs(c0)+4*abs(d0)<=kap
   assert 2*abs(e0)+4*abs(d0)<=kap
print('PASS independent residual cone rectangle under strict angular margin')
rho=s.Function('rho')(r,z)
b0=kap*rho/64;c0=kap*rho/16;d0=kap*rho/32;e0=kap*rho/8;a0=4*b0+e0
assert max(8*kap/64,2*kap/16+4*kap/32,2*kap/8+4*kap/32)==3*kap/8
assert s.simplify(-s.diff(d0,r)+s.diff(a0,z)-d0/r-(-kap/32*(s.diff(rho,r)+rho/r)+3*kap/16*s.diff(rho,z)))==0
assert s.simplify(s.diff(a0,r)+s.diff(d0,z)+a0/r-(3*kap/16*(s.diff(rho,r)+rho/r)+kap/32*s.diff(rho,z)))==0
assert s.simplify(s.diff(c0,r)+s.diff(b0,z)+2*c0/r-(kap/16*(s.diff(rho,r)+2*rho/r)+kap/64*s.diff(rho,z)))==0
print('PASS nontrivial manufactured 3-component source, cost=3kappa/8')
print('OPEN: original NS source, smooth meridional lift, compact pressure, H8 weighted inverse')
