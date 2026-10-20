#!/usr/bin/env python3
"""Case006 Appendix X: Piola-homotopy divergence-preserving flat smoother.
Exact SymPy polynomial identities and rational cone-reserve arithmetic.
This does NOT verify the analytic infinite-dimensional theorem in Lean or
that the original unfrozen Navier–Stokes source satisfies the hypotheses.
"""
import sympy as s
from fractions import Fraction as Q
import math
x,y,u,v,t,c=s.symbols('x y u v t c',real=True)
phi=x*(1-x)*y*(1-y)
eps=c*x*x*y
uv=s.Matrix([u,v]); coords=(x,y)
F=s.Matrix([x+eps*u,y+eps*v])
Ft=s.Matrix([x+t*eps*u,y+t*eps*v])
DF=F.jacobian(coords); J=s.factor(DF.det())
grad=s.Matrix([s.diff(eps,x),s.diff(eps,y)])
P=J*s.eye(2)-uv*grad.T
assert (P*DF-J*s.eye(2)).applyfunc(s.simplify)==s.zeros(2)
V=s.Matrix([x*x+x*y+1,y*y+x*y+x])
f=s.diff(V[0],x)+s.diff(V[1],y)
Vtrans=V.subs({x:F[0],y:F[1]},simultaneous=True)
Pi=(P*Vtrans).applyfunc(s.expand)
assert s.simplify(sum(s.diff(Pi[i],coords[i]) for i in range(2))-J*f.subs({x:F[0],y:F[1]},simultaneous=True))==0
Jt=1+t*grad.dot(uv)
ft=f.subs({x:Ft[0],y:Ft[1]},simultaneous=True)
source_flow=(eps*uv*ft).applyfunc(s.expand)
assert s.simplify(s.diff(Jt*ft,t)-sum(s.diff(source_flow[i],coords[i]) for i in range(2)))==0
H=s.integrate(source_flow,(t,0,1)).applyfunc(s.expand)
smoothed_integrand=(Pi-H).applyfunc(s.expand)
assert s.simplify(sum(s.diff(smoothed_integrand[i],coords[i]) for i in range(2))-f)==0
print('PASS Piola cofactor, exact source homotopy, source-preserving divergence for each u')
kappa=Q(15971,122900); a=kappa/2; b=kappa/8
sigma=Q(1,4); c0=Q(1,1024); Fstar=kappa/16
T=16*c0
assert T<1
rational_upper=((1-sigma)*(1+15*c0)+Fstar*c0/(8*b))/(1-T)
assert rational_upper==Q(12469,16128) and rational_upper < 1-sigma/2
print('PASS exact rational cone reserve upper',rational_upper,'<',1-sigma/2)
for m in (0,1,2,3,4):
    e=c*phi**(m+3)
    assert s.factor(s.diff(e,x)-c*(m+3)*phi**(m+2)*s.diff(phi,x))==0
    rough=((1-sigma)*(1+5*(m+3)*c0)+Fstar*c0*Q(2**m,8)/b)/(1-T)
    assert rough<1-sigma/2
print('PASS polynomial-relative source exponents m=0..4 with strict model reserve')
assert a==Q(15971,245800) and b==Q(15971,983200)
print('OPEN source-specific relative-growth bound, meridional H8 and (249)/(272)/(273)')
