#!/usr/bin/env python3
"""Exact Case006 Appendix J source-moment Jacobian and C2 reflection audit.

Governing equations: sym(grad q_i)=f_i diag(1,-2,1);
Rstar:T=1217/1229; first variation of the unprojected compact
Navier-Stokes residual minus div(rho Rstar).
The true unforced shell profiles are NOT specified by this test.
"""
import sympy as s
from fractions import Fraction as F
from itertools import product
x,y,z,t=s.symbols('x y z t', real=True)
R=s.diag(-1,-1,1); T=s.diag(1,-2,1)
q=[s.Matrix([x*y,-(x*x+2*y*y+z*z)/2,y*z]),
   s.Matrix([(x*x+2*y*y-z*z)/2,-2*x*y,x*z]),
   s.Matrix([-2*x*z,4*y*z,x*x-2*y*y-z*z])]
f=s.Matrix([y,x,-2*z])
Q0=s.Matrix([[s.Rational(317,43),s.Rational(35,86),0],
             [s.Rational(35,86),s.Rational(47,172),0],
             [0,0,s.Rational(1,4)]])
Rstar=s.Rational(172,1229)*(Q0-s.trace(Q0)/3*s.eye(3))
assert s.trace(Rstar*T)==s.Rational(1217,1229)
assert R*Rstar*R==Rstar
print("PASS: exact centre coefficient 1217/1229 and Rstar half-turn invariance")
for i in range(3):
    G=q[i].jacobian([x,y,z])
    assert s.simplify((G+G.T)/2)==f[i]*T
    lap=s.Matrix([sum(s.diff(q[i][a],v,2) for v in [x,y,z]) for a in range(3)])
    assert lap==(s.Matrix([0,-4,0]),s.Matrix([2,0,0]),s.Matrix([0,0,-4]))[i]
    rotate=R*q[i].subs({x:-x,y:-y},simultaneous=True)
    assert rotate==(-1 if i<2 else 1)*q[i]
print("PASS: exact symmetric gradient, Laplacian, three C2 parities")
u=s.Matrix(s.symbols('u1 u2 u3',real=True))
v=s.Matrix(s.symbols('v1 v2 v3',real=True))
w=s.Matrix(s.symbols('w1 w2 w3',real=True))
rho,drho=s.symbols('rho drho',real=True)
for i in range(3):
    source=t*w.dot(q[i])-f[i]*((u+t*v).dot(T*(u+t*v))-u.dot(T*u))\
           +s.Rational(1217,1229)*f[i]*t*drho
    first=s.expand(s.diff(source,t).subs(t,0))
    expected=w.dot(q[i])-2*f[i]*u.dot(T*v)+s.Rational(1217,1229)*f[i]*drho
    assert s.expand(first-expected)==0
    assert s.expand(source-t*expected+t*t*f[i]*v.dot(T*v))==0
print("PASS: three exact moment-Jacobian first variations with quadratic remainders")
assert F(172,1229)*(F(317,43)-2*F(47,172)+F(1,4))==F(1217,1229)
vals=[F(-2),F(-1,3),F(0),F(2,5)]
count=0
for a,b,c,d,e,g,h,k in product(vals,repeat=8):
    U=(a,b,c); V=(d,e,g)
    E=lambda Z: Z[0]**2-2*Z[1]**2+Z[2]**2
    lhs=E(tuple(U[j]+h*V[j] for j in range(3)))-E(U)
    rhs=2*h*(a*d-2*b*e+c*g)+h*h*E(V)
    assert lhs==rhs
    count+=1
    if count==4096:break
assert count==4096
print("PASS: 4096 independent exact rational polarization cases")
print("UNRESOLVED: actual shell profiles, admissible moment Jacobian, determinant and compact H8 inverse")
