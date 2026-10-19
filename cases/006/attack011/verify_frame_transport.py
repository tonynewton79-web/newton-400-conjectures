#!/usr/bin/env python3
"""Appendix N: exact tensor-transport and source-moment audit.
No claim about the paper's unfrozen profiles or the weighted H8 inverse.
"""
import sympy as s
from fractions import Fraction
x,y,z,a,c=s.symbols('x y z a c',real=True)
X=s.Matrix([x,y,z]);S=s.Matrix([[0,-1,0],[1,0,0],[0,0,1]])
b=s.Matrix([a,0,c]);Q=b*b.T-(a*a+c*c)*s.eye(3)/3
D=s.expand(S*Q*S.T-Q)
assert D==s.Matrix([[-a*a,0,-a*c],[0,a*a,a*c],[-a*c,a*c,0]])
assert s.factor(s.trace(D.T*D)-2*a*a*(a*a+2*c*c))==0
rho=x*x+y*y
F=D*s.Matrix([s.diff(rho,u) for u in (x,y,z)])
curl=s.Matrix([s.diff(F[2],y)-s.diff(F[1],z),s.diff(F[0],z)-s.diff(F[2],x),s.diff(F[1],x)-s.diff(F[0],y)])
assert curl==s.Matrix([2*a*c,2*a*c,0])
print('PASS frame mismatch and non-gradient curl witness')
seed=s.Matrix([x+2*y*z,y+x*z,z+3*x*y])
Kseed=s.Matrix([[x*x,y*z,x*z],[y*z,y*y,x+y],[x*z,x+y,z*z]])
vars=(x,y,z)
def act(k,V,kind):
 A=S**k;Y=A.T*X
 v=V.subs(dict(zip(vars,Y)),simultaneous=True)
 return (A*v if kind=='v' else A*v*A.T).applyfunc(s.expand)
def div(K):
 return s.Matrix([sum(s.diff(K[i,j],vars[j]) for j in range(3)) for i in range(3)])
g=sum([act(k,seed,'v') for k in range(4)],s.zeros(3,1))
K=sum([act(k,Kseed,'t') for k in range(4)],s.zeros(3,3))
assert act(1,g,'v')==g
assert act(1,K,'t')==K
assert act(1,div(K),'v')==div(K)
assert act(1,g-div(K),'v')==g-div(K)
assert (act(1,div(g*g.T),'v')-div(g*g.T)).applyfunc(s.expand)==s.zeros(3,1)
print('PASS orbit gluing, divergence, complete nonlinear cross-term covariance')
E=s.Matrix([x*z,y*z,-z*z])
T=s.Matrix([-y*z,x*z,0])
G=s.Matrix([0,0,x*x+y*y])
for q,formula in [(E,z*(a*a-2*c*c)+a*c*x),(T,-a*c*y),(G,2*a*c*x)]:
 assert s.expand(s.trace(Q.T*q.jacobian(vars))-formula)==0
print('PASS three transported-baseline quadratic moment densities')
for aa,cc in [(Fraction(3,5),Fraction(4,5)),(Fraction(5,13),Fraction(12,13)),(Fraction(0),Fraction(1))]:
 assert aa*aa+cc*cc==1
 sub={a:s.Rational(aa.numerator,aa.denominator),c:s.Rational(cc.numerator,cc.denominator)}
 assert s.trace(D.T*D).subs(sub)==2*sub[a]**2*(sub[a]**2+2*sub[c]**2)
print('PASS three independent rational tilted-frame defect samples')
print('OPEN: actual frame/patch profiles, compact pressure and H8 weighted inverse')
