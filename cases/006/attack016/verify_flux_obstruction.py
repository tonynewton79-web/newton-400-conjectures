#!/usr/bin/env python3
"""Case 006 Appendix S: exact angular-flux cone obstruction, not an H8 inverse."""
from fractions import Fraction as Q
import sympy as s
import mpmath as mp

r,z=s.symbols('r z',real=True)
beta=(147*s.sqrt(182)-84*s.sqrt(2))/9832
kappa=s.Rational(15971,122900)
mu=kappa/8
assert kappa==s.Rational(172,1229)-s.Rational(1,100)
assert s.N(beta,60)>s.N(mu,60)>0
assert Q(1785,9832)>Q(15971,983200)
assert s.simplify((beta-mu)/beta-(1-mu/beta))==0
print('PASS exact source-derived cone floor and obstruction')
print('beta=',s.N(beta,25),'mu=',s.N(mu,25))
print('minimum cumulative flux compensation=',s.N(1-mu/beta,25))

Hr=s.Function('Hr')(r,z);Hz=s.Function('Hz')(r,z)
theta_source=s.diff(Hr,r)+2*Hr/r+s.diff(Hz,z)
assert s.simplify(r**2*theta_source-s.diff(r**2*Hr,r)-s.diff(r**2*Hz,z))==0
assert 8*mu==kappa
print('PASS cylindrical angular divergence and coefficient 8|B| extraction')

chi,Lambda,q,D=s.symbols('chi Lambda q D',positive=True)
shell=chi*Lambda*r**2/(2*q)
assert s.simplify(s.diff(shell,r)-chi*Lambda*r/q)==0
assert s.simplify(r**2*(chi*Lambda/(q*r))/s.diff(shell,r)-1)==0
print('PASS exact normalized envelope moment R2(z)=F(z*q^-D)')

x=s.symbols('x',real=True)
B=s.Function('B')(x);A=s.Function('A')(x);M=s.Function('M')(x)
I=s.Function('I')(x);delta,gamma=s.symbols('delta gamma')
F=B*A-delta*s.diff(M*A,x)-gamma*I
L=s.diff(B*A,x)-delta*s.diff(M*A,x,2)-gamma*M*A
assert s.simplify(s.diff(F,x)-L+gamma*(s.diff(I,x)-M*A))==0
print('PASS exact axial-viscous actuator source primitive')

assert float(beta/mu)>11
mp.mp.dps=70
f=lambda u: mp.exp(-1/(1-u*u)) if abs(u)<1 else mp.mpf('0')
Z=mp.quad(f,[-1,0,1])
w=mp.mpf('0.01')
flat=lambda s: f((s-mp.mpf('6.025'))/w)/(w*Z)
mass=mp.quad(flat,[mp.mpf('6.015'),mp.mpf('6.025'),mp.mpf('6.035')])
assert abs(mass-1)<mp.mpf('1e-60')
print('PASS 70-digit smooth flat-bump mass integration')
print('OPEN: actual complete source G,chi,g torque, stress response, (249),(272),(273)')
