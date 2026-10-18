#!/usr/bin/env python3
"""Exact reproduction of Case 002 two-chord finite coverage (not the full conjecture)."""
import csv, hashlib, json
from pathlib import Path

LO, HI, MAX_M = 1897, 26222, 95
def wheel(m): return m*(m-1)+1
def one(m,k):
    assert 2<=k<=m-2
    return (3*m*m-5*m+8+2*k*(m-k))//2
def F(a,b,c):
    return (a+b-1)*(b+c-1)-b*(b-1)//2
def cross(m,a,b,c,d):
    assert min(a,b,c,d)>=1 and sum((a,b,c,d))==m
    both=(2*m*m-(a*a+b*b+c*c+d*d)-7*m+12)//2
    return one(m,a+b)+one(m,b+c)-wheel(m)+both
def parallel(m,a,b,c,d):
    assert min(a,c)>=2 and min(b,d)>=1 and sum((a,b,c,d))==m
    return one(m,a)+one(m,c)-wheel(m)+1+F(a,b,c)+F(a,d,c)
def main():
    witness={}
    for m in range(4,MAX_M+1):
        for a in range(1,m-2):
            for b in range(1,m-a-1):
                for c in range(1,m-a-b):
                    d=m-a-b-c
                    n=cross(m,a,b,c,d)
                    if LO<=n<=HI and n not in witness:
                        witness[n]=(m,'cross',a,b,c,d)
                    if a>=2 and c>=2:
                        n=parallel(m,a,b,c,d)
                        if LO<=n<=HI and n not in witness:
                            witness[n]=(m,'parallel',a,b,c,d)
    missing=[n for n in range(LO,HI+1) if n not in witness]
    assert not missing, ('unattained',missing[:10])
    out=Path(__file__).resolve().parent/'coverage_witnesses.csv'
    with out.open('w',newline='') as file:
        rows=csv.writer(file,lineterminator='\n')
        rows.writerow(('cycle_count','rim_vertices','configuration','a','b','c','d'))
        for n in range(LO,HI+1):
            rows.writerow((n,*witness[n]))
    digest=hashlib.sha256(out.read_bytes()).hexdigest()
    EXPECTED='5aa3a8e3a260661afce548d7060f2231825511c845ff90c959ab1da5135ade6f'
    assert digest==EXPECTED, ('unexpected witness output',digest)
    print(json.dumps({'status':'PASS_FINITE_INTERVAL_NOT_FULL_CONJECTURE',
      'interval':[LO,HI],'certified_targets':len(witness),
      'csv_sha256':digest},indent=2))
if __name__=='__main__':main()
