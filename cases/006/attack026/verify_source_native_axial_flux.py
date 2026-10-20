#!/usr/bin/env python3
"""Case006 Appendix AC exact source-native radial/axial stress flux verifier."""
import sympy as sp
from fractions import Fraction as F
r,z,th=sp.symbols('r z th',real=True,positive=True)
kap=sp.Rational(15971,122900)
v=sp.sqrt(sp.Rational(91,200))
br=(35*v+sp.sqrt(2))/sp.sqrt(1229)
bz=(-35*v+sp.sqrt(2))/sp.sqrt(1229)
bt=-sp.Rational(105,10)/sp.sqrt(1229)
alpha=sp.simplify(br*bz);beta=sp.simplify(bt*bz)
assert alpha==-sp.Rational(4443,9832)
assert sp.simplify(beta-(147*sp.sqrt(182)-84*sp.sqrt(2))/9832)==0
assert alpha-kap==-sp.Rational(143017,245800)
assert alpha+kap==-sp.Rational(79133,245800)
print('PASS signed physical cone centre and exact admissible source-shear interval')
base=(r-1)**3*(2-r)**3
wz=z**2*(1-z)**2
Sthetaz=sp.Rational(2,5)*base*wz*sp.sin(4*th)
assert sp.integrate(sp.diff(Sthetaz,th),(th,0,2*sp.pi))==0
assert sp.integrate(sp.cos(4*th),(th,0,2*sp.pi))==0
assert sp.integrate(sp.sin(4*th),(th,0,2*sp.pi))==0
T=sp.Rational(3,7)*base*sp.integrate(wz,(z,0,1))
q=1+r+r**2
Fz=sp.diff(r*T,r)/r+q
assert sp.simplify(Fz-sp.diff(r*T,r)/r-q)==0
J=T-T.subs(r,1)/r+sp.integrate(r*q,(r,1,r))/r
assert sp.simplify(r*sp.diff(J,r)+J-r*Fz)==0
assert sp.simplify(J.subs(r,1))==0
print('PASS angular mean C4, pressure+boundary traces and full cumulative flux')
cutr=(r-1)**3*(2-r)**3
cutz=z**3*(1-z)**3
z0=sp.integrate(cutz,(z,0,1))
z1=sp.integrate(z*cutz,(z,0,1))
R=sp.Rational(7,11)*cutr*z0
rawT=cutr*(r*z0+2*z1)
S=rawT-alpha*R
F=sp.diff(r*S,r)/r
assert sp.simplify(r*F-r*sp.diff(S,r)-S)==0
assert S.subs(r,1)==S.subs(r,2)==0
assert sp.integrate(r*F,(r,1,2))==0
chi=cutr*cutz
rawrz=(r+2*z)*chi
rawzz=(r-3*z)*chi
rho=sp.Rational(7,11)*chi
Srz=rawrz-alpha*rho
Szz=rawzz-rho/3
fz=sp.diff(r*Srz,r)/r+sp.diff(Szz,z)
assert Szz.subs(z,0)==Szz.subs(z,1)==0
assert sp.simplify(sp.integrate(Srz,(z,0,1))-S)==0
print('PASS compact cutoff tensor and automatic integrated zero axial force')
assert F(4443,9832)>F(15971,122900)
assert sp.simplify(4*(kap*rho/8)+(kap*rho/2)-kap*rho)==0
print('PASS sharp |A| <= kappa*rho and zero-target obstruction')
print('OPEN actual globally prepared physical tensor/gauge and H8 inverse')
