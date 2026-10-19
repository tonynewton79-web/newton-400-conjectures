#!/usr/bin/env python3
"""Independent exact-rational audit of the augmented H8 operator symbol.

Only tests finite polynomial identities: NO compact support, Green estimates,
energy solution or Navier--Stokes global blow-up statement is certified.
"""
from fractions import Fraction as F
from itertools import product

def matrix(x,y,z):
    return ((z,F(0),y,-x,x),
            (F(0),z,x,F(0),y),
            (x,y,F(0),z,z))

def determinant_3(G):
    return (G[0][0]*(G[1][1]*G[2][2]-G[1][2]*G[2][1])
          - G[0][1]*(G[1][0]*G[2][2]-G[1][2]*G[2][0])
          + G[0][2]*(G[1][0]*G[2][1]-G[1][1]*G[2][0]))

def audit(x,y,z,a,b,c):
    M=matrix(x,y,z)
    v=(a,b,c)
    symbol=tuple(sum((M[i][j]*v[i] for i in range(3)),F(0))
                 for j in range(5))
    e=sum((w*w for w in symbol),F(0))
    q=x*x+y*y+z*z
    v2=a*a+b*b+c*c
    sos=(F(4,5)*((y*a+x*b)**2+(y*c+z*b)**2+(z*a-x*c)**2)
         +F(1,5)*(3*(x*a+z*c)+2*y*b)**2)
    assert e-q*v2/5==sos
    assert e >= q*v2/5
    G=tuple(tuple(sum((M[i][k]*M[j][k] for k in range(5)),F(0))
                        for j in range(3)) for i in range(3))
    assert G==((2*x*x+y*y+z*z,2*x*y,x*z),
               (2*x*y,x*x+y*y+z*z,2*y*z),
               (x*z,2*y*z,x*x+y*y+2*z*z))
    det=determinant_3(G)
    assert 16*det==q*(7*q*q+(3*y*y-5*(x*x+z*z))**2)
    assert 16*det>=7*q*q*q
    if q>0: assert det>0
    return e,q*v2/5

values=[F(-2),F(-1),F(0),F(1,2),F(1),F(3,2),F(2)]
count=0
for xyz in product(values,repeat=3):
    for v in ((F(0),F(1),F(0)),(F(1),F(0),F(1)),
              (F(1,3),F(-2,5),F(7,4)),xyz):
        audit(*xyz,*v)
        count+=1
# The coefficient 1/5 is sharp over reals. Rational witnesses approach it.
x,y=F(49),F(60)
energy,bound=audit(x,y,F(0),x,-y,F(0))
ratio=energy/((x*x+y*y)**2)
assert F(1,5)<ratio<F(1,5)+F(1,10_000_000)
print(f"PASS: {count} exact-rational symbol/SOS/determinant controls")
print(f"Near-sharp rational witness x={x}, y={y}: ratio={ratio}")
print("Not claimed: compact H8 solution or PDE theorem.")
