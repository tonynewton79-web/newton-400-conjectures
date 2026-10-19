#!/usr/bin/env python3
"""Exact-rational 4-field/pressure H8 principal-symbol controls.

Tests are finite polynomial and inverse-matrix checks. They do NOT
establish compact support, profile-dependent bounds or Navier-Stokes blow-up.
"""
from fractions import Fraction as F
from itertools import product

def det3(m):
    return (m[0][0]*(m[1][1]*m[2][2]-m[1][2]*m[2][1])
            - m[0][1]*(m[1][0]*m[2][2]-m[1][2]*m[2][0])
            + m[0][2]*(m[1][0]*m[2][1]-m[1][1]*m[2][0]))

def matrix(x,y,z):
    return ((z,F(0),y,-x,x),(F(0),z,x,F(0),y),(x,y,F(0),z,z))

def gram(m):
    return [[sum((m[i][k]*m[j][k] for k in range(len(m[0]))),F(0))
             for j in range(3)] for i in range(3)]

def inverse3(m):
    det=det3(m)
    assert det!=0
    result=[]
    for i in range(3):
        row=[]
        for j in range(3):
            minor=[[m[a][b] for b in range(3) if b!=i]
                   for a in range(3) if a!=j]
            row.append(((-1)**(i+j))*
                       (minor[0][0]*minor[1][1]-minor[0][1]*minor[1][0])/det)
        result.append(row)
    return result

values=[F(-2),F(-1),F(0),F(1,2),F(1),F(3,2),F(2)]
seen=inverses=0
for x,y,z in product(values,repeat=3):
    M=matrix(x,y,z)
    G=gram(M)
    M0=[row[:4] for row in M]
    q=x*x+y*y+z*z
    s=x*x+z*z
    assert det3(gram(M0))==q*s*s
    assert det3(G)==q*(7*q*q+(3*y*y-5*s)**2)/16
    assert (det3(gram(M0))==0)==(x==0 and z==0)
    if q:
        Gi=inverse3(G)
        T=[[sum((M[i][k]*Gi[i][j] for i in range(3)),F(0))
            for j in range(3)] for k in range(5)]
        for i in range(3):
            for j in range(3):
                assert sum((M[i][k]*T[k][j] for k in range(5)),F(0))==F(int(i==j))
        inverses+=1
    seen+=1
print(f"PASS: {seen} exact determinant controls, {inverses} exact 5x3 Fourier right inverses")
print("The characteristic set of the ungauged symbol is the nonzero y-axis.")
print("OPEN: compact weighted H8 estimate, source profiles, PDE global completion.")
