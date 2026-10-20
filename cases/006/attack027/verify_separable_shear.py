#!/usr/bin/env python3
"""Exact original Eq(194) poloidal shear: DIAGNOSTIC only, not physical H8 source."""
import sympy as s, mpmath as mp
x,z,r,ell,c,K1,K2,mu,lam=s.symbols('x z r ell c K1 K2 mu lam',real=True,nonzero=True)
b=s.Function('b'); bx=b(x); bz=b(z); I2=s.Symbol('I2',positive=True)
p1=bx;p2=(1+mu*x)*bx; q1=bz;q2=(1+lam*z)*bz
Wr=s.simplify(p1*s.diff(p2,x)-p2*s.diff(p1,x))
assert s.simplify(Wr-mu*bx**2)==0
Omega=-lam*I2/2  # compact integration by parts
T=s.simplify(-K1*K2*Wr*Omega/(r*r*ell))
assert s.simplify(T-mu*lam*K1*K2*bx**2*I2/(2*r*r*ell))==0
kap=s.Rational(15971,122900);alpha=-s.Rational(4443,9832)
T0=s.simplify(T.subs({mu:s.Rational(1,2),lam:-s.Rational(1,2)}))
R0=s.Rational(1229,4443)*K1*K2*bx**2*I2/(ell*r*r)
assert s.simplify(T0/R0-alpha)==0
assert -alpha>kap
print('PASS exact Wronskian, antisymmetric axial overlap, center ratio and single-profile no-go')
mp.mp.dps=70
raw=lambda t:mp.exp(-1/(1-t*t)) if abs(t)<1 else mp.mpf(0)
Z=mp.quad(raw,[-1,0,1])
B=lambda t:raw(t)/Z
Bp=lambda t:B(t)*(-2*t/(1-t*t)**2) if abs(t)<1 else mp.mpf(0)
I2n=mp.quad(lambda t:B(t)**2,[-1,0,1])
assert abs(mp.quad(B,[-1,0,1])-1)<mp.mpf('1e-65')
for rr in ('1.25','1.75','2','2.5','2.75'):
    rr=mp.mpf(rr); xx=rr-2
    ph1=B(xx);ph2=(1+xx/2)*B(xx)
    dph1=Bp(xx);dph2=B(xx)/2+(1+xx/2)*Bp(xx)
    def original(z):
        q1=B(z);q2=(1-z/2)*B(z)
        dq1=Bp(z);dq2=-B(z)/2+(1-z/2)*Bp(z)
        Pr=-(ph1*dq1+ph2*dq2)/rr
        Pz=(dph1*q1+dph2*q2)/rr
        return Pr*Pz
    direct=mp.quad(original,[-1,-mp.mpf('.5'),0,mp.mpf('.5'),1])
    derived=-I2n*B(xx)**2/(8*rr**2)
    assert abs(direct-derived)<mp.mpf('1e-65')
    R=mp.mpf(1229)/4443*I2n*B(xx)**2/rr**2
    assert abs(direct/R+mp.mpf(4443)/9832)<mp.mpf('1e-65')
print('PASS independent 70-digit original velocity-product integrals at 5 radii')
print('OPEN: full physical Rstr, core and patch-overlap source; H8 weighted cone')
