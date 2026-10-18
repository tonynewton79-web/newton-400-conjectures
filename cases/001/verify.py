#!/usr/bin/env python3
"""Rational proof checks and independent Fourier replay for Case 001.

No floating-point calculation is used to accept the finite certificates.
The general theorem is proved analytically in paper/main.tex.
"""
from __future__ import annotations
import argparse
from fractions import Fraction as Q
from math import factorial, cos, pi
import json
import hashlib
from pathlib import Path

def harmonic(m: int) -> Q:
    return sum((Q(1,k) for k in range(1,m+1)),Q(0))

def weights(m: int) -> dict[int,Q]:
    assert m >= 2
    w={j: Q(2,(j-1)*j*(j+1)) for j in range(2,m)}
    w[m]=Q(1,m*(m-1))
    return w

def decomp_entry(n: int,d: int) -> Q:
    m=n//2
    assert n>=4 and 0<=d<=m
    return Q(1,m)+sum((w*max(j-d,0) for j,w in weights(m).items()),Q(0))

def intersection(n: int,j: int,d: int) -> int:
    assert 2<=j<=n//2
    a={(-t)%n for t in range(j)}
    b={(d-t)%n for t in range(j)}
    return len(a&b)

def exact_psd_matrix_identity(max_n: int=40) -> int:
    checks=0
    for n in range(4,max_n+1):
        for d in range(n//2+1):
            target=Q(3,2) if d==0 else Q(1,d)
            assert decomp_entry(n,d)==target,(n,d)
            checks+=1
            via_B=Q(1,n//2)+sum(
                (w*intersection(n,j,d) for j,w in weights(n//2).items()),Q(0))
            assert via_B==target,(n,d)
            checks+=1
    return checks

def atan_interval(q: int,terms: int=13) -> tuple[Q,Q]:
    a=Q(1,q)
    s=Q(0)
    lower=upper=None
    for k in range(2*terms+2):
        s+=(-1)**k*a**(2*k+1)/(2*k+1)
        if k==2*terms: upper=s
        if k==2*terms+1: lower=s
    assert lower is not None and upper is not None and 0<lower<upper
    return lower,upper

def pi_interval() -> tuple[Q,Q]:
    a_lo,a_hi=atan_interval(5)
    b_lo,b_hi=atan_interval(239)
    lo,hi=16*a_lo-4*b_hi,16*a_hi-4*b_lo
    assert Q(3)<lo<hi<Q(22,7)
    return lo,hi

def cosine_pi_interval(r: Q,pb: tuple[Q,Q]) -> tuple[Q,Q]:
    assert 0<=r<=1
    pl,ph=pb
    xl,xh=r*pl,r*ph
    def taylor(x: Q) -> Q:
        return sum((Q((-1)**k,factorial(2*k))*x**(2*k) for k in range(13)),Q(0))
    err=Q(22,7)**25/factorial(25)
    return taylor(xh)-err,taylor(xl)+err

def frequency_r(n: int,k: int,pb: tuple[Q,Q]) -> tuple[Q,Q]:
    m=n//2
    low=high=Q(0)
    for d in range(1,(n-1)//2+1):
        t=(k*d)%n
        t=min(t,n-t)
        lo,hi=cosine_pi_interval(Q(2*t,n),pb)
        low+=Q(2,d)*lo
        high+=Q(2,d)*hi
    if n%2==0:
        low+=Q((-1)**k,m)
        high+=Q((-1)**k,m)
    return low,high

def row_sum(n: int) -> Q:
    m=n//2
    return 2*harmonic(m) if n%2 else 2*harmonic(m-1)+Q(1,m)

def finite_nonviolation_certificate(n: int,pb: tuple[Q,Q]) -> dict:
    assert 3<=n<=14
    k=n//2
    r=n if n%2 else n//2
    _,c_hi=cosine_pi_interval(Q(1,r),pb)
    _,e_hi=frequency_r(n,k,pb)
    margin_upper=2*c_hi-Q(4,n-1)*(row_sum(n)-e_hi)
    assert margin_upper<0,(n,float(margin_upper))
    pair=f"{margin_upper.numerator:x}/{margin_upper.denominator:x}"
    return {"n":n,"fourier_mode":k,"strict_negative_upper_bound":True,
            "margin_upper_decimal_display_only":float(margin_upper),
            "exact_fraction_sha256":hashlib.sha256(pair.encode()).hexdigest()}

def initial_infinite_certificate() -> dict:
    h=harmonic(7)
    odd_cap=(4*h+3)/7
    odd_lower=2-Q(22,105)**2
    even_cap=Q(4,15)*(2*h+Q(1,8)+Q(3,2))
    even_lower=2-Q(11,28)**2
    assert (h,odd_cap,odd_lower-odd_cap,even_cap,even_lower-even_cap)==(
        Q(363,140),Q(468,245),Q(506,11025),Q(1907,1050),Q(1733,58800))
    return {"H7":str(h),"odd_boundary_lower":str(odd_lower-odd_cap),
            "even_boundary_lower":str(even_lower-even_cap)}

def circulant_eigenvalues(n: int) -> list[float]:
    m=n//2
    vals=[]
    for k in range(n):
        e=2*sum(cos(2*pi*k*d/n)/d for d in range(1,(n-1)//2+1))
        if n%2==0: e+=(-1)**k/m
        vals.append(e)
    return vals

def numerical_sanity(max_n: int=160) -> dict:
    least_positive=float("inf")
    largest_negative=float("-inf")
    for n in range(3,max_n+1):
        eig=circulant_eigenvalues(n)
        spread=4/(n-1)*(max(eig)-min(eig))
        theta=pi/n if n%2 else 2*pi/n
        margin=2*cos(theta)-spread
        if n>=15:
            assert margin>1e-8,(n,margin)
            least_positive=min(least_positive,margin)
        else:
            assert margin<-1e-8,(n,margin)
            largest_negative=max(largest_negative,margin)
    return {"through_n":max_n,"least_positive_margin":least_positive,
            "largest_negative_margin":largest_negative}

def run(max_n: int=160) -> dict:
    pb=pi_interval()
    small=[finite_nonviolation_certificate(n,pb) for n in range(3,15)]
    return {"case":"001","source":"Roucairol and Cazenave, Graffiti 197",
            "exact_gram_entry_checks":exact_psd_matrix_identity(40),
            "finite_nonviolation_n_3_to_14":small,
            "parity_starting_bounds":initial_infinite_certificate(),
            "supplemental_floating_point_NOT_A_PROOF":numerical_sanity(max_n),
            "status":"PASS_EXACT_FINITE_GATES__CANDIDATE_UNIVERSAL_THEOREM"}

if __name__=="__main__":
    p=argparse.ArgumentParser()
    p.add_argument("--max-n",type=int,default=160)
    p.add_argument("--output",type=Path,default=Path(__file__).resolve().parent/"certificates"/"verification.json")
    args=p.parse_args()
    result=run(args.max_n)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,sort_keys=True,indent=2)+"\n",encoding="utf-8")
    print("PASS | exact Gram entries:",result["exact_gram_entry_checks"],
          "| finite exclusions C_3 to C_14 | Fourier check through C_"+str(args.max_n))
    print("Certificate:",args.output)
