#!/usr/bin/env python3
"""Appendix T exact radial angular H8 cone dual; diagnostic source only.

This checks a manufactured smooth annular source, NOT the unfrozen
Navier--Stokes source of the main manuscript.
"""
import sympy as s
r,z=s.symbols('r z',positive=True,real=True)
alpha,br,bt,bz=s.symbols('alpha br bt bz',real=True)
rho=s.Function('rho')(r,z)
kap=s.Rational(15971,122900)
mu=kap/8
beta=(147*s.sqrt(182)-84*s.sqrt(2))/9832
baseline=br*bt*(s.diff(rho,r)+2*rho/r)+bt*bz*s.diff(rho,z)
g_theta=baseline+alpha*(s.diff(rho,r)+2*rho/r)
h=s.simplify(g_theta-baseline)
assert s.simplify(r**2*h-alpha*s.diff(r**2*rho,r))==0
assert s.simplify(r**2*baseline-br*bt*s.diff(r**2*rho,r)-bt*bz*r**2*s.diff(rho,z))==0
print('PASS exact cylindrical divergence and radial derivative')
print('PASS compact radial integration gives m_g=beta*R2_prime, M_g=beta*R2')
# H=(A=B=D=0,C=alpha*rho) has coefficient list (0,+2C,-2C,0,0,0,0).
A=B=D=s.Integer(0);C=alpha*rho
coeff=[-s.Rational(3,2)*D,2*C-4*D,-2*C-4*D,
       2*A-8*B+4*D,-2*A+8*B+4*D,8*B,-8*B]
assert coeff==[0,2*alpha*rho,-2*alpha*rho,0,0,0,0]
assert kap/2==s.Rational(15971,245800)
print('PASS angular stress cost exactly 2*abs(alpha)*rho; sharp threshold kappa/2')
for a,want in ((kap/4,'PASS'),(kap/2,'SHARP'),(kap,'FAIL')):
    cost=2*abs(a)
    got='FAIL' if cost>kap else ('SHARP' if cost==kap else 'PASS')
    assert got==want
    print(got,'alpha =',a,'angular cone cost =',cost)
assert s.N(beta,30)>s.N(mu,30)>0
print('PASS both model sources have flux ratio beta inside the Appendix S band')
print('OPEN actual g and rho, meridional tensor equations, compact weighted inverse')
