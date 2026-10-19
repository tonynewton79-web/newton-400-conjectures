#!/usr/bin/env python3
"""Exact rational tests for the sharp local polar of the H8 coefficient budget.

No Navier--Stokes PDE inversion or compact-support theorem is asserted.
"""
from fractions import Fraction as Q
from itertools import product

def coeff(A,B,C,D):
    return (-Q(3,2)*D,2*C-4*D,-2*C-4*D,
            2*A-8*B+4*D,-2*A+8*B+4*D,8*B,-8*B)

def norm7(A,B,C,D):
    return max(map(abs,coeff(A,B,C,D)))

def norm3(A,B,C,D):
    return max(8*abs(B),2*abs(C)+4*abs(D),
               2*abs(A-4*B)+4*abs(D))

def sign(x):
    return Q(1) if x>=0 else Q(-1)

def polar(P,Q_,R,S):
    return abs(4*P+Q_)/8+max((abs(P)+abs(R))/2,abs(S)/4)

def attainable(P,Q_,R,S,k):
    # A vertex optimizing the four-field correction at exactly the given load.
    B=k*sign(4*P+Q_)/8
    if abs(S)>=2*(abs(P)+abs(R)):
        D=k*sign(S)/4
        E=C=Q(0)
    else:
        D=Q(0)
        E=k*sign(P)/2
        C=k*sign(R)/2
    A=E+4*B
    assert norm7(A,B,C,D)<=k
    L=A*P+B*Q_+C*R+D*S
    assert L == k*polar(P,Q_,R,S), (P,Q_,R,S,L,polar(P,Q_,R,S))
    return (A,B,C,D)

vals=[Q(-2),Q(-1),Q(0),Q(1,3),Q(1),Q(2)]
coeff_count=0
for A,B,C,D in product(vals,repeat=4):
    assert norm7(A,B,C,D)==norm3(A,B,C,D)
    coeff_count+=1
load_count=0
for P,Q_,R,S in product([Q(-3),Q(-1),Q(0),Q(1,2),Q(2)],repeat=4):
    attainable(P,Q_,R,S,Q(3,5))
    load_count+=1
print(f"PASS: {coeff_count} exact seven-to-three norm tests and "
      f"{load_count} sharp dual attainments")
print("OPEN: specific profile selection, weighted compact inverse, and H8.")
