#!/usr/bin/env python3
"""Exact polynomial replay for Appendix I: finite-type H8 adjoint kernel."""
import sympy as s
from itertools import product
x,y,z=s.symbols('x y z')
X=(x,y,z)
T=s.diag(1,-2,1)
q1=s.Matrix([x*y,-(x*x+2*y*y+z*z)/2,y*z])
q2=s.Matrix([(x*x+2*y*y-z*z)/2,-2*x*y,x*z])
q3=s.Matrix([-2*x*z,4*y*z,x*x-2*y*y-z*z])
basis=[s.eye(3)[:,j] for j in range(3)]
basis += [s.Matrix([0,z,-y]),s.Matrix([-z,0,x]),
          s.Matrix([y,-x,0]),s.Matrix([x,-2*y,z]),q1,q2,q3]
assert len(basis)==10
for q in basis:
    grad=q.jacobian(X)
    f=s.diff(q[0],x)
    assert all(s.expand((grad+grad.T)[i,j]/2 - T[i,j]*f)==0
               for i,j in product(range(3),repeat=2))
print('PASS 10 explicit adjoint-null polynomial fields')
h=s.symbols('hxx hyy hzz hxy hxz hyz')
H=s.Matrix([[h[0],h[3],h[4]],[h[3],h[1],h[5]],[h[4],h[5],h[2]]])
compat=[]
for i,j,k,l in product(range(3),repeat=4):
    compat.append(T[j,l]*H[i,k]+T[i,k]*H[j,l]-T[j,k]*H[i,l]-T[i,l]*H[j,k])
independent=[2*h[0]-h[1],-h[5],-h[0]-h[2],-2*h[4],-h[3],-h[1]+2*h[2]]
assert all(any(s.expand(e-a)==0 or s.expand(e+a)==0 for e in compat)
           for a in independent)
M,_=s.linear_eq_to_matrix(independent,h)
assert M.rank()==6 and M.det()==-8
print('PASS 6x6 exact compatibility determinant -8')
nullities=[]
for d in range(6):
    mons=[x**i*y**j*z**(d-i-j)
          for i in range(d+1) for j in range(d+1-i)]
    cs=s.symbols('c0:'+str(3*len(mons)))
    u,v,w=[sum(cs[component*len(mons)+n]*mon
                 for n,mon in enumerate(mons))
           for component in range(3)]
    if d==0:
        mat=s.zeros(0,len(cs))
    else:
        expressions=[s.diff(u,y)+s.diff(v,x),
                     s.diff(u,z)+s.diff(w,x),
                     s.diff(v,z)+s.diff(w,y),
                     s.diff(u,x)-s.diff(w,z),
                     s.diff(u,x)+s.diff(v,y)+s.diff(w,z)]
        targets=[x**i*y**j*z**(d-1-i-j)
                 for i in range(d) for j in range(d-i)]
        rows=[s.Poly(e,x,y,z).coeff_monomial(m)
              for e in expressions for m in targets]
        mat=s.linear_eq_to_matrix(rows,cs)[0]
    nullities.append(mat.cols-mat.rank())
    if d==3:
        assert mat.shape==(30,30) and mat.det()==5159780352
assert nullities == [3,4,3,0,0,0],nullities
print('PASS homogeneous nullities degrees 0..5:',nullities)
print('PASS 30x30 cubic matrix invertible')
print('OPEN: source-native profile and compact weighted H8 inversion')
