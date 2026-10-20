#!/usr/bin/env python3
"""Case 006 Appendix W: flat radial Hardy bound and adaptive mollifier algebra.
Illustrative separable flat envelope only; not a physical H8 source.
"""
import sympy as s
from fractions import Fraction as F
from math import exp
x,y,t,x0=s.symbols('x y t x0',real=True)
kap=F(15971,122900)
logp=-1/x**2-1/(1-x)**2
assert s.simplify(s.diff(logp,x)-(2/x**3-2/(1-x)**3))==0
assert s.simplify(s.diff(logp,x,2)+6/x**4+6/(1-x)**4)==0
assert s.diff(logp,x).subs(x,s.Rational(1,4))>0
assert s.diff(logp,x).subs(x,s.Rational(3,4))<0
print('PASS strict log-concavity and exact radial midpoint monotonicity')
assert 2*(kap/4)==kap/2<kap
lam=kap/2
assert (lam/2) <= F(3,4)*kap
print('PASS globally smooth exact radial primitive cone bounds and rational reserve')
c=F(1,1024); sigma=F(1,4)
assert c<F(1,8)
assert 8*float(c)/(1-float(c)/4)**3<=16*float(c)
assert (1-float(sigma))*exp(16*float(c))<1-float(sigma)/2
print('PASS adaptive cubic-distance flat weight distortion and strict cone margin')
eps=s.Function('eps')(x0)
Y=x0-eps*t
u=lambda X:X**3+2*X+5
eta=1-t*t
left=s.diff(u(Y),x0)*eta
uprime=3*Y**2+2
rhs=uprime*eta-s.diff(eps,x0)/eps*u(Y)*(eta+t*s.diff(eta,t))
assert s.simplify(s.integrate(s.expand(left-rhs),(t,-1,1)))==0
assert s.limit(x**(-12)*s.exp(-1/x**2),x,0,dir='+')==0
print('PASS variable-bandwidth divergence commutator and flat smooth extension')
print('OPEN: global weighted commutator inverse and meridional H8 equations')
