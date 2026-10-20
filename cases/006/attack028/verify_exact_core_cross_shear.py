#!/usr/bin/env python3
"""Case006 Appendix AE: exact leading-core shaper cross shear; diagnostic only.

Based on the source's leading U*(eta)=4eta+j0, NOT the complete
exact-core first-shell coefficient hierarchy or the original glued Rstr.
"""
import sympy as s
import mpmath as mp
from fractions import Fraction as Q

r,z,q,h,j0,K,c,ell=s.symbols('r z q h j0 K c ell', positive=True, real=True)
A=s.Rational(1,2)+h; D=s.Rational(1,2)-h
ur=-2*r/q; uz=q**(-A)*(4*z*q**(-D)+j0)
assert s.simplify(s.diff(r*ur,r)/r+s.diff(uz,z))==0
assert s.simplify(s.diff(uz,z)-4/q)==0
x,y,nu=s.symbols('x y nu',real=True)
vv=[-2*x/q,-2*y/q,uz]
p=-(x*x+y*y)/q**2-10*z*z/q**2-(A+4)*j0*q**(-A-1)*z
for i,X in enumerate((x,y,z)):
    conv=sum(vv[k]*s.diff(vv[i],t) for k,t in enumerate((x,y,z)))
    dt=-s.diff(vv[i],q)
    lap=sum(s.diff(vv[i],t,2) for t in (x,y,z))
    assert s.simplify(dt+conv-nu*lap+s.diff(p,X))==0
print('PASS source-leading affine comparison is solenoidal and exact unforced NS for any nu (not finite-energy)')
Phi=s.Function('Phi')(r);m=s.symbols('m',positive=True)
I=-2*r*c*m/q
T=s.expand(K/r*(s.diff(Phi,r)*I-Phi*(s.diff(I,r)+I/r)))
assert s.simplify(T+2*K*c*m/q*(s.diff(Phi,r)-2*Phi/r))==0
assert s.simplify(s.diff(Phi,r)-2*Phi/r-r*r*s.diff(Phi/r**2,r))==0
print('PASS exact cross shear derivative T0=-2Kcm/q*r²*d_r(Phi/r²)')
chiMin,chiMax=s.symbols('chiMin chiMax',positive=True)
expr=s.Rational(61,10)/chiMax-6/chiMin
assert s.simplify(expr-(s.Rational(61,10)*chiMin-6*chiMax)/(chiMin*chiMax))==0
assert Q(1001,1000)<Q(61,60)
alpha=-Q(4443,9832);kap=Q(15971,122900)
assert alpha+kap<0
print('PASS common source strong-Rayleigh radial patch requires chiMax/chiMin<61/60')
mp.mp.dps=75
raw=lambda x: mp.exp(-1/(1-x*x)) if abs(x)<1 else mp.mpf('0')
Z=mp.quad(raw,[-1,0,1])
b=lambda x: raw(x)/Z
bp=lambda x: b(x)*(-2*x/(1-x*x)**2) if abs(x)<1 else mp.mpf('0')
rmid=mp.mpf('1.005');dr=mp.mpf('0.005')
ratio=[]
for t in ('-0.95','-0.9','-0.8','0','0.8','0.9','0.95','0.98'):
    xx=mp.mpf(t);rr=rmid+dr*xx
    ph=b(xx);dph=bp(xx)/dr
    tt=-2*(dph-2*ph/rr)
    assert abs(tt+2*rr**2*(dph/rr**2-2*ph/rr**3))<mp.mpf('1e-66')
    ratio.append(tt/ph**2)
assert ratio[0]<0 and ratio[-1]>0 and ratio[-1]>ratio[6]
print('PASS 75-digit sign change, quadratic-envelope flat-edge mismatch')
for t in ('-0.8','-0.2','0.2','0.8'):
    xx=mp.mpf(t);rr=rmid+dr*xx;ph=b(xx);dph=bp(xx)/dr
    def term(zz):
        Xi=b(zz);XiPrime=bp(zz)
        P_r=-ph*XiPrime/rr;P_z=dph*Xi/rr
        return (-2*rr)*P_z+(4*zz+3)*P_r
    direct=mp.quad(term,[-1,-mp.mpf('0.5'),0,mp.mpf('0.5'),1])
    exact=-2*(dph-2*ph/rr)
    assert abs(direct-exact)<mp.mpf('1e-65')
print('PASS independent 75-digit DIRECT ur*Pz+uz*Pr integral at four radii')
print('OPEN full exact-core coefficients, glued prepared Rstr, physical rho and H8 inversion')
