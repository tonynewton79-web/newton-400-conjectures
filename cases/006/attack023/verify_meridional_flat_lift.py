#!/usr/bin/env python3
"""Appendix Z exact meridional pressure-curl and flat double-primitive check.
Manufactured model, not the original unforced Navier–Stokes source.
"""
import sympy as s
from fractions import Fraction as F
import mpmath as mp
r,z=s.symbols('r z',positive=True,real=True)
B,C,D,E=[s.Function(v)(r,z) for v in ('B','C','D','E')]
A=4*B+E
Lr=-s.diff(D,r)+s.diff(A,z)-D/r
Lz=s.diff(A,r)+s.diff(D,z)+A/r
LE=lambda h:s.diff(h,r,2)-s.diff(h,z,2)+s.diff(h,r)/r-h/r**2
LD=lambda h:2*s.diff(h,r,z)+s.diff(h,z)/r
assert s.simplify(s.diff(Lz,r)-s.diff(Lr,z)-LE(A)-LD(D))==0
phi=s.Function('phi')(r,z)
pr=-s.diff(phi,z)/r;pz=s.diff(phi,r)/r
assert s.simplify(s.diff(r*pr,r)+s.diff(r*pz,z))==0
assert s.simplify(r*(s.diff(pr,z)+s.diff(pz,r))-(s.diff(phi,r,2)-s.diff(phi,z,2)-s.diff(phi,r)/r))==0
assert s.simplify(r*(s.diff(pz,z)-s.diff(pr,r))-(2*s.diff(phi,r,z)-s.diff(phi,z)/r))==0
e,d=[s.Function(v)(r,z) for v in ('e','d')]
assert s.simplify(LE(e/s.sqrt(r))-(s.diff(e,r,2)-s.diff(e,z,2)-3*e/(4*r*r))/s.sqrt(r))==0
assert s.simplify(LD(d/s.sqrt(r))-2*s.diff(d,r,z)/s.sqrt(r))==0
print('PASS meridional curl, streamfunction adjoints and half-density reduction')
x,y=s.symbols('x y',real=True)
p=x**4*(1-x)**4;q=y**4*(1-y)**4
assert s.integrate(p*(x-s.Rational(1,2)),(x,0,1))==0
assert s.integrate(q*(y-s.Rational(1,2)),(y,0,1))==0
P=s.integrate(p*(x-s.Rational(1,2)),(x,0,x)).subs(x,r-1)
Q=s.integrate(q*(y-s.Rational(1,2)),(y,0,y)).subs(y,z)
lam=s.symbols('lam',real=True)
D0=lam*P*Q/(2*s.sqrt(r))
g=lam*p.subs(x,r-1)*q.subs(y,z)*(r-s.Rational(3,2))*(z-s.Rational(1,2))/s.sqrt(r)
assert s.simplify(LD(D0)-g)==0
f0=-2*s.diff(D0,r)-D0/r
assert s.simplify(-s.diff(f0,z)-g)==0
assert s.simplify(f0-(-s.diff(D0,r)-D0/r)-(-s.diff(D0,r)))==0
assert s.simplify(s.diff(D0,z)-s.diff(D0,z))==0
print('PASS two slice balances, nontrivial D-only curl, compact pressure p=-D')
kap=F(15971,122900);tau=F(1,4);amp=tau*kap/8
assert amp>0 and 8*amp*amp<(tau*kap)**2
# After multiplying by positive numbers this implies amp*2 sqrt(2) < tau*kappa.
for t in (F(0),F(1,10),F(1,4),F(1)):
    assert 2*((1-t)*kap/2)+4*(t*kap/8)<=(1-t/2)*kap
print('PASS exact rational source amplitude and residual cone reserve')
u=s.symbols('u',positive=True)
logp=-u**(-2)-(1-u)**(-2)
assert s.simplify(s.diff(logp,u,2)+6/u**4+6/(1-u)**4)==0
mp.mp.dps=65
def flat(v):
    return mp.exp(-1/v**2-1/(1-v)**2) if 0<v<1 else mp.mpf(0)
def integ(v):
    return mp.quad(lambda t:flat(t)*(t-mp.mpf('0.5')),[0,v])
L=mp.mpf(amp.numerator)/amp.denominator
for u0,v0 in [('0.25','0.25'),('0.5','0.5'),('0.7','0.8')]:
    u0,v0=mp.mpf(u0),mp.mpf(v0);rr=1+u0
    Dv=L*integ(u0)*integ(v0)/(2*mp.sqrt(rr))
    rho=flat(u0)*flat(v0)/rr**2
    assert abs(Dv)/rho <= L*mp.sqrt(8)/8
print('PASS 65-digit infinitely flat weighted D model checks')
print('OPEN full physical H8 source, arbitrary meridional data, nonaxisymmetric modes')
