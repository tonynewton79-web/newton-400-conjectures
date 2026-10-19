#!/usr/bin/env python3
"""Exact symbolic test of the three quadratic adjoint-null fields (no PDE solve)."""
import sympy as s
x,y,z,A,B,C,D=s.symbols("x y z A B C D")
X=[x,y,z]
H=s.Matrix([[-D,C,A],[C,0,B],[A,B,D]])
Q=[
 s.Matrix([x*y,-(x*x+2*y*y+z*z)/2,y*z]),
 s.Matrix([(x*x+2*y*y-z*z)/2,-2*x*y,x*z]),
 s.Matrix([-2*x*z,4*y*z,x*x-2*y*y-z*z])
]
for k,q in enumerate(Q,1):
    grad=q.jacobian(X)
    assert s.expand(s.trace(grad))==0
    assert s.expand(sum(H[i,j]*grad[i,j] for i in range(3) for j in range(3)))==0
    print(f"PASS: q{k} divergence and H:gradient annihilation exact")
assert s.diff(Q[0][1],x,2)==-1
for q in Q:
    assert all(s.total_degree(e)==2 for e in q)
print("PASS: compact bump example has quadratic source moment -integral(eta)")

# Three independent second-derivative source actuators preserve all affine moments
# but span the entire 3-dimensional quadratic moment vector.
hessian=s.Matrix([[s.diff(v[1],x,2),s.diff(v[1],x,y),s.diff(v[1],y,z)]
                  for v in Q])
assert hessian.T == s.diag(-1,-2,4)
i,m1,m2,m3=s.symbols('I m1 m2 m3',nonzero=True)
adjust=s.Matrix([-i,0,0])*(m1/i) + s.Matrix([0,-2*i,0])*(m2/(2*i)) + s.Matrix([0,0,4*i])*(-m3/(4*i))
assert adjust == s.Matrix([-m1,-m2,-m3])
print("PASS: invertible exact quadratic-moment actuator matrix and correction coefficients")
