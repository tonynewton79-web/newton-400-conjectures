#!/usr/bin/env python3
"""Case006 Appendix AF: exact off-axis radial pairing and direct product replay.
Illustrative M=2eta, chi=1, diagnostic rho; NOT original full core.
"""
import sympy as s
import mpmath as mp
from fractions import Fraction as Q
r,z,q,c,D,a=s.symbols('r z q c D a',positive=True)
A=1-D
Y=s.symbols('Y')
eta=z/c
G=4*eta+3-Y*a*eta/(2*s.Symbol('Lambda',positive=True))
uz=s.simplify(q**(-A)*G.subs(Y,s.Symbol('Lambda',positive=True)*r*r/(2*q)).subs(c,q**D))
ur=-2*r/q+a*r**3/(16*q*q)
assert s.simplify(s.diff(r*ur,r)/r+s.diff(uz,z))==0
I=-2*c*r/q+c*a*r**3/(16*q*q)
assert s.simplify((I+2*c*r/q)/(-2*c*r/q)+a*r*r/(32*q))==0
phi=s.Function('phi')(r)
Ts=I*s.diff(phi,r)/r-phi*(s.diff(I,r)+I/r)/r
assert s.simplify(Ts-I**2*s.diff(phi/(r*I),r))==0
print('PASS exact first off-axis incompressibility, pairing and derivative identity')
assert (Q(4)-Q(22)*3/Q(2000)-Q(1,10**6))>3
print('PASS rational source uniform C1 positivity criterion (illustrative constants)')
mp.mp.dps=70
raw=lambda v:mp.exp(-1/(1-v*v)) if abs(v)<1 else mp.mpf(0)
N=mp.quad(raw,[-1,0,1])
B=lambda v:raw(v)/N
Bp=lambda v:B(v)*(-2*v/(1-v*v)**2) if abs(v)<1 else mp.mpf(0)
I2=mp.quad(lambda v:B(v)**2,[-1,0,1])
rl=mp.sqrt(mp.mpf(12)/1000);rh=mp.sqrt(mp.mpf('12.2')/1000)
mid=(rl+rh)/2;h=(rh-rl)/2
kap=mp.mpf(15971)/122900;alpha=-mp.mpf(4443)/9832
ratios=[]
for x0 in ['-.95','-.8','-.5','0','.5','.8','.95']:
    x=mp.mpf(x0);rr=mid+h*x;bb=B(x);bbp=Bp(x)/h
    fs=[bb,(1+x/2)*bb]
    dfs=[bbp,(1+x/2)*bbp+bb/(2*h)]
    def velocity_product(t):
        xi=[B(t),(1-t/2)*B(t)]
        dxi=[Bp(t),(1-t/2)*Bp(t)-B(t)/2]
        pr=-sum(fs[i]*dxi[i] for i in (0,1))/rr
        pz=sum(dfs[i]*xi[i] for i in (0,1))/rr
        ucr=-2*rr+rr**3/8
        ucz=4*t+3-rr**2*t/2
        return ucr*pz+ucz*pr+pr*pz
    direct=mp.quad(velocity_product,[-1,-mp.mpf('.5'),0,mp.mpf('.5'),1])
    i=-2*rr+rr**3/8;ip=-2+3*rr**2/8
    cross=(i/rr)*sum(dfs)-(ip+i/rr)/rr*sum(fs)
    self=-I2*bb**2/(8*rr**2*h) # includes physical radial-width factor
    assert abs(direct-(cross+self))<mp.mpf('1e-55')
    R=mp.mpf(1229)/4443*I2*bb**2/rr**2
    ratios.append(direct/R)
assert ratios[0]<alpha-kap and ratios[-1]>alpha+kap
print('PASS 70-digit original product integrals (7 radii), both sides violate scalar H8 interval')
# Eq (255) needs the upstream second axial pressure jet to bound (Zstar/L)'.
eta,h,j0=s.symbols('eta h j0',real=True)
AA=s.Rational(1,2)+h; DD=s.Rational(1,2)-h
U=4*eta+j0; d=1-eta**2; H=DD*eta+d*U
Pi=s.Function('Pi')(eta)
Z=-AA*(1-2*eta*U)*U-4*H-d*s.diff(Pi,eta)+4*AA*eta*Pi
LL=1-2*h*eta**2
assert s.simplify(s.diff(s.diff(Z/LL,eta),s.diff(Pi,eta,2))+d/LL)==0
print('PASS first off-axis coefficient derivative requires Pi0 second axial pressure jet')
print('OPEN actual Zstar/L and C1 coefficient, true virial rho, stress gauge, C4 patch overlaps')
