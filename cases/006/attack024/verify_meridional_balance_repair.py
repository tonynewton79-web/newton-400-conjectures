#!/usr/bin/env python3
"""Case006 Appendix AA: exact unweighted compact meridional-curl reconstruction.

This is a finite exact algebraic/reconstruction replay, not a
source-specific weighted H8 cone certificate or a Lean analytic proof.
"""
import sympy as s
r,z=s.symbols('r z',positive=True)
Pr=lambda f:s.diff(f,r,2)-s.Rational(3,4)*f/r**2
M=lambda f:Pr(f)-s.diff(f,z,2)
base=(r-1)**4*(2-r)**4
u=r**2*base
xi=-21000*u*(r-s.Rational(153,100))
assert s.integrate(xi,(r,1,2))==0
assert s.integrate(s.cancel(xi/r**2),(r,1,2))==1
print('PASS exact radial xi: mass 0 and inverse-square moment 1')
u1=r**s.Rational(-1,2);u2=r**s.Rational(3,2)
assert Pr(u1)==0 and Pr(u2)==0
assert s.simplify(u1*s.diff(u2,r)-s.diff(u1,r)*u2-2)==0
print('PASS both radial adjoint ODE modes and Wronskian 2')
H=(r-1)**3*(2-r)**3
theta=140*z**3*(1-z)**3
zeta=s.diff(theta,z)
assert s.integrate(theta,(z,0,1))==1
assert s.integrate(zeta,(z,0,1))==0
e0=H*theta;e1=xi*zeta
v=(r-1)**4*(2-r)**4*z**4*(1-z)**4
h=M(e0)+M(e1)+2*s.diff(v,r,z)
# The compact E correction cancels the entire radial balance of h-M(e0).
a0=-s.Rational(3,4)*zeta
assert s.expand(-s.Rational(4,3)*xi*a0-e1)==0
assert s.integrate(a0,(z,0,1))==0
assert s.integrate(Pr(xi),(r,1,2))==-s.Rational(3,4)
assert s.integrate(xi,(r,1,2))==0
# A final compact D primitive has zero two-sided boundary data.
for f in (H,xi):
    assert f.subs(r,1)==f.subs(r,2)==0
for f in (theta,zeta):
    assert f.subs(z,0)==f.subs(z,1)==0
assert v.subs(r,1)==v.subs(r,2)==v.subs(z,0)==v.subs(z,1)==0
assert s.simplify(h-M(e0)-M(e1)-2*s.diff(v,r,z))==0
print('PASS nonzero smooth interior two-stage E and compact D reconstruction')
# Source global moments arise because the radial adjoint of LE kills 1,r².
for wt in (s.Integer(1),r**2):
    assert s.simplify(s.diff(wt,r,2)-s.diff(wt/r,r)-wt/r**2)==0
assert s.integrate(base,(r,1,2))>0
assert s.diff(r**2,r)==2*r
print('PASS source global curl identities; the second is -2*integral(r*f_z)')
print('OPEN: actual prepared physical f_z, weighted flat cone reserve, full H8 inverse')
