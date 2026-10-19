#!/usr/bin/env python3
"""Exact source-form mixed radial moment pairing audit for Appendix Q.

Definitions are from original source (250)–(251).
Physical G, M, N and cone budgets remain unfrozen.
"""
import sympy as s
import mpmath as mp
eta=s.symbols('eta',real=True)
delta,gamma,D=s.symbols('delta gamma D',nonzero=True)
M0,M1,g0,g1=s.symbols('M0 M1 g0 g1',cls=s.Function)
phi,A=s.symbols('phi A',cls=s.Function)
m0,m1=M0(eta),M1(eta)
G0,G1=g0(eta),g1(eta)
p,a=phi(eta),A(eta)
B0=m0*(D*eta+G0); B1=m1*(D*eta+G1)
L1=s.diff(B1*a,eta)-gamma*m1*a-delta*s.diff(m1*a,eta,2)
ref=delta*p.diff(eta,2)+(D*eta+G0)*p.diff(eta)+gamma*p
adj1=-B1*p.diff(eta)-gamma*m1*p-delta*m1*p.diff(eta,2)
assert s.simplify(adj1+m1*(G1-G0)*p.diff(eta)+m1*ref)==0
print('PASS exact mixed-profile source/adjoint cancellation')

p1,p2,v1,v2,b=s.symbols('p1 p2 v1 v2 b')
wprime=s.expand(v1*(-b*v2-gamma*p2)/delta-(-b*v1-gamma*p1)/delta*v2)
assert s.simplify(wprime-gamma/delta*(p1*v2-v1*p2))==0
print('PASS derivative Wronskian identity Wprime=(gamma/delta)W')

R=s.symbols('R',real=True)
bands=[(s.Rational(1),s.Rational(6,5)),(s.Rational(9,5),s.Rational(2))]
means=[]
for left,right in bands:
    w=R**2*(R-left)**4*(right-R)**4
    moment=s.integrate(w,(R,left,right))
    mean=s.factor(s.integrate(w*(1-R),(R,left,right))/moment)
    assert moment>0
    means.append(mean)
assert means[0]-means[1]==s.Rational(440509,551115)>s.Rational(3,5)
print('PASS exact separated radial means for diagnostic G=1-R:',means)

mp.mp.dps=65
diff=mp.mpf(-4)/5
bounds=[(mp.mpf(1)/5,mp.mpf(2)/5),(mp.mpf(3)/5,mp.mpf(4)/5)]
def bump(t,left,right):
    if not left<t<right: return mp.mpf(0)
    return mp.exp(-mp.mpf('0.0005')/((t-left)*(right-t)))
C=[]
for rate in (-1,-100):
    row=[]
    for left,right in bounds:
        integral=mp.quad(lambda t: mp.exp(rate*t)*bump(t,left,right),[left,(left+right)/2,right])
        row.append(-diff*rate*integral)
    C.append(row)
det=C[0][0]*C[1][1]-C[0][1]*C[1][0]
assert abs(det)>mp.mpf('1e-12')
print('PASS illustrative nonzero smooth 2x2 moment determinant',mp.nstr(det,22))
assert s.simplify((-m1*(G1-G0)*p.diff(eta)).subs({G1:G0}))==0
print('PASS same-profile compact controls have zero reference-adjoint pairing')
print('OPEN actual normalized profiles, coefficient budget (272), torque bound (249), H8 inverse')
