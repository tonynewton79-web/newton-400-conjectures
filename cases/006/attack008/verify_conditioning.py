#!/usr/bin/env python3
"""Case 006 Appendix K: exact rational determinant conditioning tests.

No actual source-native Navier–Stokes shell Jacobian is supplied.
"""
from fractions import Fraction as F
from itertools import product
from random import Random

def det(M):
    a,b,c=M[0];d,e,f=M[1];g,h,i=M[2]
    return a*e*i+b*f*g+c*d*h-c*e*g-b*d*i-a*f*h

vals=[]
for bits in product((-1,1),repeat=9):
    vals.append(abs(det([bits[j*3:j*3+3] for j in range(3)])))
assert max(vals)==4
assert det([[1,1,1],[1,-1,1],[1,1,-1]])==4
print('PASS 512 sign vertices, sharp determinant box constant 4')

rng=Random(190206)
A=[F(j,6) for j in range(-6,7)]
for _ in range(4096):
    eps=F(rng.randrange(0,9),8)
    scale=F(rng.randrange(0,9),5)
    a,b,c,d,e,f,g,h,i=[rng.choice(A) for k in range(9)]
    B=[[eps*a,eps*b,eps*c],[eps*d,eps*e,eps*f],[scale*g,scale*h,scale*i]]
    coefficient=a*e*i+b*f*g+c*d*h-c*e*g-b*d*i-a*f*h
    assert det(B)==eps*eps*scale*coefficient
    assert abs(coefficient)<=4
    assert abs(det(B))<=4*eps*eps*scale
print('PASS 4096 exact rational quadratic-suppression tests')

def bound(L,delta):
    return 18*L*L*delta+18*L*delta*delta+6*delta**3

for _ in range(4096):
    B=[[rng.choice(A) for k in range(3)] for j in range(3)]
    E=[[rng.choice(A)/100 for k in range(3)] for j in range(3)]
    L=max(abs(x) for row in B for x in row)
    err=max(abs(x) for row in E for x in row)
    J=[[B[j][k]+E[j][k] for k in range(3)] for j in range(3)]
    assert abs(det(J)-det(B))<=bound(L,err)
print('PASS 4096 exact rational determinant-interval tests')

B=[[F(3),F(1),F(0)],[F(1),F(2),F(0)],[F(0),F(0),F(1)]]
assert det(B)==5
b=bound(F(3),F(1,100))
assert b==F(812703,500000) and b<5
print('PASS illustrative interval: det B=5; error <=',b)
print('OPEN: genuine source-native Jacobian and compact weighted H8 inverse')
