#!/usr/bin/env python3
"""Paper 001: self-contained exact rational verification, Python 3 stdlib only.
Usage: python3 Paper001_exact_certificate.py [optional json output path]
All acceptance decisions are Fraction comparisons; decimals are display only.
"""
from fractions import Fraction as Q
from math import factorial
import json, sys, hashlib

def atan_bracket(inv, terms=22):
    def part(k):
        return sum((Q(-1 if j%2 else 1, (2*j+1)*inv**(2*j+1)) for j in range(k)),Q(0))
    a,b=part(terms),part(terms+1)
    return min(a,b),max(a,b)

a,b=atan_bracket(5)
c,d=atan_bracket(239)
PI_LO,PI_HI = 16*a-4*d,16*b-4*c
assert Q(3) < PI_LO < PI_HI < Q(22,7)

def cos_bracket_of_fraction(turn_fraction):
    """Bounds cos(2*pi*t), t in [0,1/2]; no floating arithmetic."""
    assert 0 <= turn_fraction <= Q(1,2)
    if turn_fraction == 0:
        return Q(1), Q(1)
    if turn_fraction == Q(1,2):
        return Q(-1), Q(-1)
    xlo=2*PI_LO*turn_fraction
    xhi=2*PI_HI*turn_fraction
    def poly(x):
        return sum((Q((-1)**j, factorial(2*j))*x**(2*j) for j in range(11)),Q(0))
    # Taylor theorem with derivative <=1 bounds remainder after degree 20.
    err=xhi**21/factorial(21)
    # cos is decreasing on [0,pi].
    return poly(xhi)-err, poly(xlo)+err

def mode_bracket(n,k,d):
    t = (k*d)%n
    t = min(t,n-t)
    return cos_bracket_of_fraction(Q(t,n))

def row_sum(n):
    m=n//2
    return (sum((Q(2,d) for d in range(1,m+1)),Q(0)) if n%2
            else sum((Q(2,d) for d in range(1,m)),Q(1,m)))

def floorQ(x):return x.numerator//x.denominator
def ceilQ(x):return -floorQ(-x)

def finite_row(n):
    m=n//2
    k=m
    s=row_sum(n)
    eta_upper=Q(0)
    for d in range(1,m+1):
        _, hi=mode_bracket(n,k,d)
        eta_upper += Q(1 if n%2==0 and d==m else 2,d)*hi
    # Adjacency second-smallest: odd 2*cos(pi/n), even 2*cos(2*pi/n).
    _, adj_hi=cos_bracket_of_fraction(Q(1,2*n) if n%2 else Q(1,n))
    adj_upper=2*adj_hi
    spread_lower=Q(4,n-1)*(s-eta_upper)
    gap_lower=spread_lower-adj_upper
    assert gap_lower>0,(n,float(gap_lower))
    base=10**6
    return {'n':n,'mode':k,
            'spread_lower_1e6':floorQ(spread_lower*base),
            'adjacency_upper_1e6':ceilQ(adj_upper*base),
            'strict_rational_gap':f'{gap_lower.numerator}/{gap_lower.denominator}'}

def gram_checks():
    total=0
    for n in range(4,35):
        m=n//2
        for p in (1,2,3):
            f=lambda d: Q(1,d**p)
            c=2*f(1)-f(2)
            w={j:(f(j-1)-2*f(j)+f(j+1) if j<m else f(m-1)-f(m)) for j in range(2,m+1)}
            assert all(v>=0 for v in w.values())
            for u in range(n):
                for v in range(n):
                    dist=min((v-u)%n,(u-v)%n)
                    # Cyclic intersection identity for j<=n/2:
                    entry=f(m)+sum((w[j]*max(j-dist,0) for j in w),Q(0))
                    goal=c if u==v else f(dist)
                    assert entry==goal,(n,p,u,v,entry,goal)
                    total+=1
    return total

if __name__=='__main__':
    rows=[finite_row(n) for n in range(3,15)]
    count=gram_checks()
    for r in rows:
        print('C%-2d  gravity spread > %9.6f; adjacency < %9.6f; certified margin >= %.6f' %
              (r['n'],r['spread_lower_1e6']/1e6,r['adjacency_upper_1e6']/1e6,(r['spread_lower_1e6']-r['adjacency_upper_1e6'])/1e6))
    print('PASS: all 12 strict complementary inequalities with rational enclosures.')
    print(f'PASS: {count} exact matrix-entry evaluations, n=4..34 and p=1,2,3.')
    if len(sys.argv)>1:
        certificate={
            'method':'Machin arctan alternating rational enclosures; cosine Taylor degree 20 with |R|<=x^21/21!, monotonic cosine on [0,pi]',
            'pi_lower':str(PI_LO),'pi_upper':str(PI_HI),
            'rational_acceptance':'The exact gap is positive in every row; rounded integer millionths are display-only enclosures',
            'finite':rows,'gram_matrix_entries':count,
            'code_sha256':hashlib.sha256(open(__file__,'rb').read()).hexdigest()}
        with open(sys.argv[1],'w') as g:json.dump(certificate,g,indent=2)
        print('Wrote',sys.argv[1])
