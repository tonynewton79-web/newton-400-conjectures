#!/usr/bin/env python3
"""Exact SO(2) angular projection of tilted H8 quadratic adjoint tests."""
import sympy as s
from fractions import Fraction as F
x,y,z,r,c,t=s.symbols('x y z r c t',real=True)
a,b=s.symbols('a b',real=True)
R=s.Matrix([[1,0,0],[0,c,-t],[0,t,c]])
Y=R.T*s.Matrix([x,y,z])
Q=[s.Matrix([Y[0]*Y[1],-(Y[0]**2+2*Y[1]**2+Y[2]**2)/2,Y[1]*Y[2]]),
s.Matrix([(Y[0]**2+2*Y[1]**2-Y[2]**2)/2,-2*Y[0]*Y[1],Y[0]*Y[2]]),
s.Matrix([-2*Y[0]*Y[2],4*Y[1]*Y[2],Y[0]**2-2*Y[1]**2-Y[2]**2])]
T=s.Matrix([[t*(3*t*t-1)/2,0,-t*(5-3*t*t)/4],
[0,-3*c*t,0],[c*(1-3*t*t),0,-c*(1+3*t*t)/2]])
def avg(p):
    o=0
    for (i,j,k),coef in s.Poly(s.expand(p),a,b,z).terms():
        if i%2 or j%2:continue
        m,n=i//2,j//2
        val=s.factorial(2*m)*s.factorial(2*n)/(4**(m+n)*s.factorial(m)*s.factorial(n)*s.factorial(m+n))
        o+=coef*val*z**k
    return s.expand(o)
for i,q in enumerate(Q):
    p=R*q
    p=[s.expand(v.subs({x:r*a,y:r*b},simultaneous=True)) for v in p]
    measured=s.Matrix([avg(a*p[0]+b*p[1]),avg(-b*p[0]+a*p[1]),avg(p[2])])
    expected=s.Matrix([T[i,0]*r*z,T[i,1]*r*z,-T[i,0]*z*z+T[i,2]*r*r])
    assert all(s.rem(s.expand(v-w),c*c+t*t-1,c)==0 for v,w in zip(measured,expected))
    print('PASS angular average q'+str(i+1))
assert s.factor(T.det()+s.Rational(9,2)*c*c*t*t*(1-3*t*t))==0
assert s.factor(s.det(T.extract([0,2],[0,2]))-s.Rational(3,2)*c*t*(1-3*t*t))==0
k,Z=s.symbols('k Z')
assert s.simplify(T*s.Matrix([2*k*Z/(1-3*t*t),0,0])+k*Z*s.Matrix([t,0,-2*c]))==s.zeros(3,1)
F=s.Matrix([Y[1],Y[0],-2*Y[2]])
assert [avg(f.subs({x:r*a,y:r*b},simultaneous=True)) for f in F]==[t*z,0,-2*c*z]
print('PASS determinant, meridional minor, and axisymmetric envelope')
for tt,cc in [(F(3,5),F(4,5)),(F(5,13),F(12,13)),(F(0),F(1)),(F(1),F(0))]:
    assert tt*tt+cc*cc==1
    v=T.subs({t:s.Rational(tt.numerator,tt.denominator),c:s.Rational(cc.numerator,cc.denominator)})
    assert v.det()==-s.Rational(9,2)*cc*cc*tt*tt*(1-3*tt*tt)
print('PASS four exact rational physical tilt samples')
print('Proved in text: q2 moment=-6*pi*c*t*integral(z*m(z),dz)')
print('OPEN: actual H8 g, rho, transported frame, and weighted compact inverse')
