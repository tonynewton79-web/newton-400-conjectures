#!/usr/bin/env python3
"""Exact source-native cylindrical frame and slice-torque audit, Appendix O."""
import sympy as s
x,y,z=s.symbols("x y z",real=True)
r=s.sqrt(x*x+y*y)
br,bt,bz=s.symbols("br bt bz",real=True)
R=s.symbols("R",positive=True)
turn=s.Matrix([[0,-1,0],[1,0,0],[0,0,1]])
er=s.Matrix([x/r,y/r,0]);et=s.Matrix([-y/r,x/r,0]);ez=s.Matrix([0,0,1])
v=br*er+bt*et+bz*ez
rho=s.Function("rho")(r,z)
K=rho*(v*v.T-s.eye(3)/3)
rotate=lambda F:turn*F.subs({x:y,y:-x},simultaneous=True)*turn.T
assert (rotate(K)-K).applyfunc(lambda t:s.simplify(s.expand(t)))==s.zeros(3)
print("PASS: moving cylindrical centre is C4 covariant")
D=s.Matrix([sum(s.diff(K[i,j],var) for j,var in enumerate((x,y,z))) for i in range(3)])
got=D.subs({x:R,y:0}).applyfunc(s.simplify)
h=s.Function("rho")(R,z)
expected=s.Matrix([
 (br**2-s.Rational(1,3))*s.diff(h,R)+(br**2-bt**2)*h/R+br*bz*s.diff(h,z),
 br*bt*(s.diff(h,R)+2*h/R)+bt*bz*s.diff(h,z),
 br*bz*(s.diff(h,R)+h/R)+(bz**2-s.Rational(1,3))*s.diff(h,z)])
assert (got-expected).applyfunc(s.simplify)==s.zeros(3,1)
print("PASS: exact Cartesian derivation of full cylindrical tensor divergence")
frame=s.Matrix([35*s.sqrt(s.Rational(91,200))+s.sqrt(2),-s.Rational(21,2),
 -35*s.sqrt(s.Rational(91,200))+s.sqrt(2)])/s.sqrt(1229)
assert s.simplify(frame.dot(frame))==1
assert s.simplify(frame[0]*frame[2]+s.Rational(4443,9832))==0
assert s.simplify(frame[1]*frame[2]-(147*s.sqrt(182)-84*s.sqrt(2))/9832)==0
assert float(frame[1]*frame[2])>0
print("PASS: original exact local b* and positive azimuthal-axial coupling")
f=s.Function("f")(R,z)
identity=R**2*(br*bt*(s.diff(f,R)+2*f/R)+bt*bz*s.diff(f,z))
assert s.simplify(identity-br*bt*s.diff(R**2*f,R)-bt*bz*R**2*s.diff(f,z))==0
E=s.Matrix([x*z,y*z,-z*z]);F=s.Matrix([-y*z,x*z,0]);G=s.Matrix([0,0,x*x+y*y])
for q,target in [(E,z*(br**2+bt**2-2*bz**2)+r*br*bz),
                 (F,r*bt*bz),(G,2*r*br*bz)]:
 grad=q.jacobian([x,y,z])
 contraction=sum(K[i,j]*grad[i,j] for i in range(3) for j in range(3))
 assert s.simplify(contraction-rho*target)==0
print("PASS: slice boundary term and all three moving baseline moment densities")
A=s.Function("A")(r,z);H=s.Function("H")(r,z)
Hr=s.Subs(s.Derivative(s.Function("H")(R,z),R),R,r)
U=s.Matrix([-y*A-x*s.diff(H,z),x*A-y*s.diff(H,z),2*H+r*Hr])
assert s.simplify(sum(s.diff(U[i],q) for i,q in enumerate((x,y,z))))==0
assert (turn*U.subs({x:y,y:-x},simultaneous=True)-U).applyfunc(s.simplify)==s.zeros(3,1)
print("PASS: every toroidal-poloidal source-native smooth shaper is solenoidal and C4 equivariant")
r2=x*x+y*y;aa=r2*z+2*z*z;hh=r2*z*z+r2*r2*z
V=s.Matrix([-y*aa-x*s.diff(hh,z),x*aa-y*s.diff(hh,z),
            2*hh+2*r2*(z*z+2*r2*z)])
T=s.Matrix([-y*aa,x*aa,0]);P=V-T
def div(T):return s.Matrix([sum(s.diff(T[i,j],q) for j,q in enumerate((x,y,z))) for i in range(3)])
def turnv(q):return (turn*q.subs({x:y,y:-x},simultaneous=True)).applyfunc(s.expand)
C=div(T*P.T+P*T.T)
assert C!=s.zeros(3,1)
assert (turnv(C)-C).applyfunc(s.expand)==s.zeros(3,1)
assert (turnv(div(V*V.T))-div(V*V.T)).applyfunc(s.expand)==s.zeros(3,1)
print("PASS: complete nonlinear cross term is NONZERO and still C4 equivariant")
rr,zz=s.symbols("rr zz")
B=(rr-1)**4*(2-rr)**4*(1-zz**2)**4
M=s.integrate(rr**2*B,(rr,1,2))
I=s.integrate(M,(zz,-1,1))
assert I>0 and s.simplify(s.integrate(zz*s.diff(M,zz),(zz,-1,1))+I)==0
assert s.integrate(s.diff(M,zz),(zz,-1,1))==0
print("PASS: compact C3 polynomial bump surrogate, exact weighted moment",I)
print("OPEN: complete transported patched H8 source, compact pressure and weighted inverse")
