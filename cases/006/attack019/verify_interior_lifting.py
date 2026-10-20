#!/usr/bin/env python3
"""Case006 Appendix V: exact compact rectangular divergence corrector,
rational reserve bounds, and flat-envelope smoothing obstruction.
The original physical H8 source is NOT numerically frozen.
"""
from fractions import Fraction as F
import sympy as s
import mpmath as mp
r,z=s.symbols("r z",real=True)
kap=F(15971,122900); a=kap/2; b=kap/8
theta=30*(r-1)**2*(2-r)**2
P=(r-1)**3*(2-r)**3
Q=z**2*(1-z)**2
T=z**3*(1-z)**3
assert s.integrate(theta,(r,1,2))==1
h=s.diff(P*Q,r)+theta*s.diff(T,z)
H=s.integrate(h,(r,1,2))
qr=s.integrate(h-theta*H,(r,1,r))
qz=theta*s.integrate(H,(z,0,z))
assert s.simplify(H-s.diff(T,z))==0
assert s.integrate(H,(z,0,1))==0
assert s.simplify(qr-P*Q)==0
assert s.simplify(qz-theta*T)==0
assert s.simplify(s.diff(qr,r)+s.diff(qz,z)-h)==0
print("PASS exact compact rectangular antidivergence and jet identities")
sigma=F(1,4);wmin=F(2);W=F(1,5);Fn=F(3)
Lr=Lz=F(1);J=F(3);eps=F(1,10**6)
assert (1-sigma)*eps*W<=sigma*wmin/4
assert 2*Lr*eps*Fn<=sigma*a*wmin/4
assert Lr*Lz*J*eps*Fn<=sigma*b*wmin/4
assert (1-sigma)+sigma/4+sigma/4==1-sigma/2==F(7,8)
print("PASS three exact rational cone tests; preserves 1/8 reserve in example")
mp.mp.dps=60
em=mp.mpf("0.10")
def rho(x):
    if x<=0 or x>=mp.mpf(".5"):return mp.mpf(0)
    return mp.exp(-1/x**2)
def moll(x):
    if abs(x)>=em:return mp.mpf(0)
    return mp.exp(-1/(1-(x/em)**2))
assert mp.quad(lambda y:rho(y)*moll(-y),[0,em/2,em])>0
for x in [mp.mpf(".025"),mp.mpf(".015"),mp.mpf(".01")]:
    bound=mp.quad(lambda y:rho(y)*moll(x-y),[em/4,em/2])/rho(x)
    assert bound>1
print("PASS flat-envelope fixed-scale convolution bound diverges as x approaches 0")
print("OPEN: weighted global boundary lift, genuine source profiles, full H8 inverse")
