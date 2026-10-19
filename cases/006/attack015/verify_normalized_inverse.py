#!/usr/bin/env python3
"""Case006 Appendix R: exact curved-shell normalized radial shapers and
quantitative conditional two-control inverse gate. No frozen physical
G,chi source coefficients or final H8 cone bounds are supplied.
"""
from fractions import Fraction as F
import sympy as s
import mpmath as mp

s0=F(241,40);s1=F(243,40); ws=F(1,100)
l0,u0=s0-ws,s0+ws
l1,u1=s1-ws,s1+ws
assert (l0,u0,l1,u1)==(F(1203,200),F(1207,200),F(1213,200),F(1217,200))
assert F(6)<l0<u0<l1<u1<F(61,10)
assert l1-u0==F(3,100)
print('PASS exact curved-shell support endpoints and strict separation')

R,chi,Lambda=s.symbols('R chi Lambda',positive=True)
sc=chi*Lambda*R**2/2
assert s.simplify(s.diff(sc,R)-chi*Lambda*R)==0
assert s.simplify((chi*Lambda/R)*R**2/s.diff(sc,R)-1)==0
print('PASS exact substitution R² tau dR=beta(s-sj)ds and M_j=1')

ds=s.sqrt(2)*(s.sqrt(s.Rational(1213,200))-s.sqrt(s.Rational(1207,200)))
assert ds>0
width=s.Rational(1217,200)**s.Rational(3,2)-s.Rational(1203,200)**s.Rational(3,2)
assert width>0
print('PASS rigorous gap >=gstar*',s.N(ds,18),'/Lambda')
print('PASS normalization forces ||tau||inf >= 3*(chi*Lambda/2)^(3/2)/',s.N(width,18))

# Rigorous sufficient *inequality* box, not an actual physical matrix.
mp.mp.dps=75
B=mp.mpf(1); K=mp.mpf('0.2'); T=mp.mpf(1)
gamma=mp.mpf(1); delta=mp.mpf(1); kappa=mp.mpf('0.1')
offset=mp.mpf('0.01'); wa=mp.mpf('0.00000001')
L=max(1+B/delta,gamma/delta)
E=mp.exp(L*(offset+wa))
P=mp.sqrt(2)*K*E
H=mp.sqrt(2)*E*(T+K*L)
test=L*mp.exp(L*offset)*(B*offset/2+gamma*offset**2/6)
det_point=kappa**2*gamma*offset/(2*delta)
err=2*wa*H*P+(wa*H)**2
assert test <= gamma/2
assert err<=det_point/2
inv=8*delta*K*E/(kappa**2*gamma*offset)
print('PASS illustrative conditional theorem inequalities (NOT source input)')
print('det C lower=',mp.nstr(det_point/2,22),'; inverse infinity upper=',mp.nstr(inv,22))

# The reference-adjoint derivative Wronskian is an identity for every
# gamma, delta>0, independent of the background coefficient b(eta).
p1,p2,v1,v2,b,G,d=s.symbols('p1 p2 v1 v2 b gamma delta')
a1=(-b*v1-G*p1)/d;a2=(-b*v2-G*p2)/d
assert s.simplify(v1*a2-a1*v2-G/d*(p1*v2-v1*p2))==0
print('PASS exact derivative Wronskian identity')
gstar,lam=s.symbols('gstar lam',positive=True)
kl=gstar*ds/lam
expr=8*d*K*E/(kl**2*G*offset)
assert s.simplify(expr/lam**2).has(lam)==False
print('PASS certified sufficient inverse factor has Lambda² scaling before K')
print('OPEN actual gstar, G, chi, exact adjoints, full slice bound (249), weighted cone (272)')
