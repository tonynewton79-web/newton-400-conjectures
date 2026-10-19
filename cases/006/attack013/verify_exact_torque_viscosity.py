#!/usr/bin/env python3
"""Exact replay of source Eq. (251), including axial-viscous second derivative.
The constant-coefficient toy model is diagnostic, not the true H8 profile.
"""
import sympy as s
eta=s.symbols('eta',real=True)
delta,gamma=s.symbols('delta gamma',positive=True)
M=s.Function('M')(eta);B=s.Function('B')(eta)
A=s.Function('A')(eta);phi=s.Function('phi')(eta)
L=s.diff(B*A,eta)-gamma*M*A-delta*s.diff(M*A,eta,2)
adj=-B*s.diff(phi,eta)-gamma*M*phi-delta*M*s.diff(phi,eta,2)
p=s.Poly(s.expand(L.doit()),s.Derivative(A,eta,2),s.Derivative(A,eta),A)
assert s.simplify(p.coeff_monomial(s.Derivative(A,eta,2))+delta*M)==0
assert s.simplify(p.coeff_monomial(s.Derivative(A,eta))-B+2*delta*M.diff(eta))==0
assert s.simplify(p.coeff_monomial(A)-B.diff(eta)+gamma*M+delta*M.diff(eta,2))==0
assert s.simplify(adj-(-B*phi.diff(eta)-gamma*M*phi-delta*M*phi.diff(eta,2)))==0
print('PASS: source exact operator, jet and formal adjoint')
# In the manuscript range h=1/12: gamma=4/3, M=1, B=101/75, delta=1/75.
d=s.Rational(1,75);b=s.Rational(101,75);g=s.Rational(4,3)
def op(f):return s.expand(b*s.diff(f,eta)-g*f-d*s.diff(f,eta,2))
def opadj(f):return s.expand(-b*s.diff(f,eta)-g*f-d*s.diff(f,eta,2))
lam=s.symbols('lam')
assert s.factor(d*lam**2+b*lam+g)==(lam+1)*(lam+100)/75
p1,p2=s.exp(-eta),s.exp(-100*eta)
assert s.simplify(opadj(p1))==0 and s.simplify(opadj(p2))==0
assert s.simplify(p1*s.diff(p2,eta)-s.diff(p1,eta)*p2+99*s.exp(-101*eta))==0
print('PASS: two exact exponential adjoint modes and nonzero Wronskian')
R=eta**5*(1-eta)**5;f=s.diff(R,eta)
assert s.integrate(f,(eta,0,1))==0
assert s.integrate(R,(eta,0,1))==s.Rational(1,2772)
for lam in (-1,-100):
    assert s.simplify(s.integrate(s.diff(s.exp(lam*eta)*R,eta),(eta,0,1)))==0
assert s.simplify(s.integrate(op(R),(eta,0,1))+g*s.integrate(R,(eta,0,1)))==0
print('PASS: derivative-only compact source violates both positive dual moments')
src=op(R)
assert s.simplify(s.integrate(src*p1,(eta,0,1)))==0
assert s.simplify(s.integrate(src*p2,(eta,0,1)))==0
assert s.simplify(s.diff(p2/p1,eta)+99*s.exp(-99*eta))==0
print('PASS: both moments cancel for a genuine compact amplitude, and two separated source tests are independent')
print('H8 remains open: admissible M,N, full background source, pointwise cone bound not frozen')
