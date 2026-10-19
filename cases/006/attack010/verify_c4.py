#!/usr/bin/env python3
"""Exact C4-versus-SO2 moment test for vector polynomials of degree <=2.
Operator: (U_R q)(X) = R^T q(RX). Checks the complete polynomial
space as well as the fixed-tilt H8 quadratics q_i and a C3 counterexample.
The actual full source's C4 covariance is NOT established here.
"""
import sympy as s
x,y,z,c,t=s.symbols('x y z c t',real=True)
X=s.Matrix([x,y,z]); rot=s.Matrix([[0,-1,0],[1,0,0],[0,0,1]])
tilt=s.Matrix([[1,0,0],[0,c,-t],[0,t,c]])
mons=[s.Integer(1),x,y,z,x*x,x*y,x*z,y*y,y*z,z*z]
coeffs=s.symbols('u0:10 v0:10 w0:10')
q=s.Matrix([sum(coeffs[i*10+j]*mons[j] for j in range(10)) for i in range(3)])
def act(M,p):
    P=M*X
    return s.expand(M.T*p.subs({x:P[0],y:P[1],z:P[2]},simultaneous=True))
def cyc4(p):
    out=s.zeros(3,1);M=s.eye(3)
    for k in range(4):
        out+=act(M,p);M=M*rot
    return s.expand(out/4)
def coeff_col(p):
    return s.Matrix([s.Poly(p[i],x,y,z).coeff_monomial(m) for i in range(3) for m in mons])
alpha=(coeffs[1]+coeffs[12])/2
beta=(coeffs[2]-coeffs[11])/2
gamma=(coeffs[6]+coeffs[18])/2
delta=(coeffs[8]-coeffs[16])/2
normal=s.Matrix([alpha*x+beta*y+gamma*x*z+delta*y*z,
                 -beta*x+alpha*y-delta*x*z+gamma*y*z,
                 coeffs[20]+coeffs[23]*z+coeffs[29]*z*z+(coeffs[24]+coeffs[27])*(x*x+y*y)/2])
assert all(s.expand(v)==0 for v in cyc4(q)-normal)
print('PASS universal 30-coefficient C4 polynomial projection normal form')
basis=[s.eye(3)[:,i]*mon for i in range(3) for mon in mons]
proj=s.Matrix.hstack(*[coeff_col(cyc4(b)) for b in basis])
K=s.Matrix([[0,-1,0],[1,0,0],[0,0,0]])
def generator(v): return v.jacobian([x,y,z])*(K*X)-K*v
Lie=s.Matrix.hstack(*[coeff_col(generator(b)) for b in basis])
assert proj.shape==(30,30) and Lie.shape==(30,30)
assert proj*proj==proj
assert Lie*proj==s.zeros(30)
assert proj.rank()==8 and 30-Lie.rank()==8
print('PASS exact projector rank 8; SO2 infinitesimal kernel dimension 8')
ct=s.Matrix([[1,0,0],[0,c,-t],[0,t,c]])
Y=ct.T*X
quad=[s.Matrix([Y[0]*Y[1],-(Y[0]**2+2*Y[1]**2+Y[2]**2)/2,Y[1]*Y[2]]),
      s.Matrix([(Y[0]**2+2*Y[1]**2-Y[2]**2)/2,-2*Y[0]*Y[1],Y[0]*Y[2]]),
      s.Matrix([-2*Y[0]*Y[2],4*Y[1]*Y[2],Y[0]**2-2*Y[1]**2-Y[2]**2])]
E=s.Matrix([x*z,y*z,-z*z]);F=s.Matrix([-y*z,x*z,0]);G=s.Matrix([0,0,x*x+y*y])
T=s.Matrix([[t*(3*t*t-1)/2,0,-t*(5-3*t*t)/4],[0,-3*c*t,0],[c*(1-3*t*t),0,-c*(1+3*t*t)/2]])
for j,Q in enumerate(quad):
    result=cyc4(ct*Q)
    expected=T[j,0]*E+T[j,1]*F+T[j,2]*G
    for term in result-expected:
        assert s.rem(s.expand(term),c*c+t*t-1,c)==0
    print('PASS fixed-tilt H8 q',j+1,'C4 projection equals Appendix L SO2 projection')
assert s.factor(T.det()+s.Rational(9,2)*c*c*t*t*(1-3*t*t))==0
bad=s.Matrix([x*x-y*y,-2*x*y,0])
R3=s.Matrix([[-s.Rational(1,2),-s.sqrt(3)/2,0],
             [s.sqrt(3)/2,-s.Rational(1,2),0],[0,0,1]])
assert s.simplify(act(R3,bad)-bad)==s.zeros(3,1)
assert generator(bad)!=s.zeros(3,1)
print('PASS: quadratic C3-equivariant counterexample to SO2-equivariance')
print('OPEN: complete H8 source C4 covariance and compact weighted inverse')
