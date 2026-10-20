#!/usr/bin/env python3
"""Case006 Appendix AB exact radial H8 cone obstruction tests.

Manufactured annular examples, NOT the unfrozen original Navier-Stokes source.
"""
import sympy as s
from fractions import Fraction as Q
import mpmath as mp
r,z,r0=s.symbols('r z r0',positive=True)
kappa=s.Rational(15971,122900)
phi=r**2*s.log(r/r0)/2
LE=lambda h:s.diff(h,r,2)-s.diff(h,z,2)+s.diff(h,r)/r-h/r**2
LD=lambda h:2*s.diff(h,r,z)+s.diff(h,z)/r
LEadj=lambda h:s.diff(h,r,2)-s.diff(h,z,2)-s.diff(h,r)/r
LDadj=lambda h:2*s.diff(h,r,z)-s.diff(h,z)/r
assert s.simplify(LEadj(phi)-1)==0 and s.simplify(LDadj(phi))==0
E,D=s.Function('E')(r,z),s.Function('D')(r,z)
jr=phi*s.diff(E,r)-E*s.diff(phi,r)+phi*E/r
jz=-(phi*s.diff(E,z)-E*s.diff(phi,z))
assert s.simplify(phi*LE(E)-E*LEadj(phi)-s.diff(jr,r)-s.diff(jz,z))==0
kr=2*phi*s.diff(D,z)
kz=-2*s.diff(phi,r)*D+phi*D/r
assert s.simplify(phi*LD(D)-D*LDadj(phi)-s.diff(kr,r)-s.diff(kz,z))==0
print('PASS exact cylindrical Green identities and logarithmic adjoint')

lam=s.symbols('lam',real=True)
rho=s.Function('rho')(r,z)
fr=lam*s.diff(rho,z)
fz=lam*(s.diff(rho,r)+rho/r)
assert s.simplify(s.diff(fz,r)-s.diff(fr,z)-lam*LE(rho))==0
assert s.simplify(r*fz-lam*s.diff(r*rho,r))==0
print('PASS manufactured source, compact axial force and original curl')
p=(r-1)**4*(2-r)**4*z**4*(1-z)**4
I=s.integrate(p,(r,1,2),(z,0,1))
assert I==s.Rational(1,396900)
for alpha,status in [(kappa/4,'PASS'),(kappa/2,'SHARP'),(kappa,'FAIL')]:
    assert (2*alpha<kappa if status=='PASS' else
            2*alpha==kappa if status=='SHARP' else 2*alpha>kappa)
    print(status,'log moment',alpha*I,'capacity',kappa*I/2)
variable=2*kappa*(r-s.Rational(3,2))
E0=variable*p
fr0=s.diff(E0,z)
fz0=s.diff(E0,r)+E0/r
g0=LE(E0)
assert s.simplify(s.diff(fz0,r)-s.diff(fr0,z)-g0)==0
assert s.integrate(E0,(r,1,2),(z,0,1))==0
assert s.integrate(g0,(r,1,2),(z,0,1))==0
assert s.integrate(r*r*g0,(r,1,2),(z,0,1))==0
assert abs(variable.subs(r,s.Rational(15,8)))==3*kappa/4 > kappa/2
assert s.integrate(p,(z,0,1)).subs(r,s.Rational(15,8))>0
print('PASS zero global log test but radial marginal FAIL at r=15/8')

mp.mp.dps=65
def flat(x):
    return mp.exp(-1/x**2-1/(1-x)**2) if 0<x<1 else mp.mpf(0)
def flat_der(x):
    return flat(x)*(2/x**3-2/(1-x)**3) if 0<x<1 else mp.mpf(0)
def quad(fun):
    return mp.quad(fun,[0,mp.mpf('.25'),mp.mpf('.5'),mp.mpf('.75'),1])
mass=quad(flat)
for coeff in (mp.mpf('0.1'),mp.mpf('0.3333333333333333333333333333')):
    lsrc=quad(lambda x:(1+x)*mp.log(1+x)*coeff*(flat_der(x)+flat(x)/(1+x)))
    assert abs(lsrc+coeff*mass)<mass*mp.mpf('1e-48')
print('PASS 65-digit genuinely infinitely flat logarithmic source replay')
print('OPEN: actual H8 source g and rho, full (249)/(272)/(273), Lean PDE proof')
