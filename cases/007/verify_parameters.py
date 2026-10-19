#!/usr/bin/env python3
"""Case 007 exact rational interval comparisons. No float decisions."""
from fractions import Fraction as F
from math import isqrt
class I:
    def __init__(self,l,h=None):
        self.l=F(l); self.h=F(self.l if h is None else h)
        assert self.l<=self.h
    @staticmethod
    def c(x):return x if isinstance(x,I) else I(x)
    def __add__(self,x):
        x=I.c(x);return I(self.l+x.l,self.h+x.h)
    __radd__=__add__
    def __neg__(self):return I(-self.h,-self.l)
    def __sub__(self,x):return self+-I.c(x)
    def __rsub__(self,x):return I.c(x)+-self
    def __mul__(self,x):
        x=I.c(x);a=[self.l*x.l,self.l*x.h,self.h*x.l,self.h*x.h]
        return I(min(a),max(a))
    __rmul__=__mul__
    def __truediv__(self,x):
        x=I.c(x);assert x.l>0 or x.h<0
        return self*I(1/x.h,1/x.l)
    def __rtruediv__(self,x):return I.c(x)/self
    def sq(self):
        if self.l>=0:return I(self.l**2,self.h**2)
        if self.h<=0:return I(self.h**2,self.l**2)
        return I(0,max(self.l**2,self.h**2))
def root(s,M=10**12):
    q=isqrt(s*M*M)
    return I(F(q,M),F(q+1,M))
def sun(d,k,M=10**12):
    a=root(5,M);b=root(d*d+4,M);c=root(d*d+1,M)
    return (k*a+k*b+(d-k)*c)*(k/a+k/b+(d-k)/c)
def U(n,d):
    a=root(5);c=root(d*d+1)
    A=(d-2)/(1-a/c);Cn=(1+a)*n-(3+a);z=n-2+a/c
    return (Cn+A*z).sq()/(4*a*A)
def endpoint():
    d=5;k=3;a=root(5);b=root(d*d+4);c=root(d*d+1)
    beta=1/c-1/b;q8=1/a-1/root(8);q10=1/a-1/root(10)
    W=root((k+1)**2+1);K=a*W+(k-1)/(2*d*q10);v=1-2*beta/q8
    S=d*c+k*(a+b-c);R=d/c+k*(1/a+1/b-1/c)
    return v*S-K*R
def main():
    count=0;least=None
    for n in range(17,100):
        k=(n-2)//3;d0=n-k-1;target=sun(d0,k)
        for d in range(3,n//2+1):
            margin=target.l-U(n,d).h
            assert margin>0,(n,d)
            count+=1
            if least is None or margin<least[0]:least=(margin,n,d)
    assert count==2220 and least[1:]==(18,9)
    print('DEGREE_PAIRS',count,'least',least[1:],'certified_gap_gt',least[0])
    count=0
    for k in range(1,5):
        for d in range(k+2,2*k+4):
            delta=sun(d-1,k+1,1000).h-sun(d,k,1000).l
            assert delta<0,(k,d)
            count+=1
    assert count==18
    print('FINITE_DIFFERENCES',count,'passed')
    assert endpoint().l>1
    print('STRUCTURAL_ENDPOINT',endpoint().l,'> 1')
if __name__=='__main__':main()
