#!/usr/bin/env python3
"""Pure exact rational audit; does not establish compact anti-divergence H8."""
from fractions import Fraction as Q
from itertools import product
t = Q(1, 4)
v = [(Q(1),Q(0),Q(0)),(Q(1),t,Q(0)),(Q(1),-t,Q(0)),
     (Q(1),Q(0),t),(Q(1),Q(0),-t),(Q(1),t,t),(Q(1),t,-t)]
w = [Q(1),Q(1),Q(59,43),Q(1),Q(1),Q(1),Q(1)]
cov = [[sum((w[k]*v[k][i]*v[k][j] for k in range(7)), Q(0))
        for j in range(3)] for i in range(3)]
assert cov == [[Q(317,43),Q(35,86),Q(0)],
               [Q(35,86),Q(47,172),Q(0)],
               [Q(0),Q(0),Q(1,4)]]
trace = sum(cov[i][i] for i in range(3))
assert trace == Q(679,86)
u=(35,2,0)
assert sum(x*x for x in u) == 1229
for i,j in product(range(3), repeat=2):
    d=Q(int(i==j))
    assert Q(172,1229)*(cov[i][j]-trace*d/3) == Q(u[i]*u[j],1229)-d/3
coeff=[Q(172,1229),Q(172,1229),Q(236,1229)] + [Q(172,1229)]*4
assert min(coeff) == Q(172,1229)
assert Q(4443,9832)-Q(9,20)==Q(93,49160)>0
budget=Q(172,1229)-Q(1,100)
assert budget==Q(15971,122900)
count=0
for rho in [Q(0),Q(1,3),Q(1),Q(13,5)]:
    for A,B,C,D in product([Q(-1,1000),Q(0),Q(1,1000)],repeat=4):
        corrections=[-Q(3,2)*D,2*C-4*D,-2*C-4*D,
                     2*A-8*B+4*D,-2*A+8*B+4*D,8*B,-8*B]
        count+=1
        if all(abs(x)<=budget*rho for x in corrections):
            assert all(coeff[a]*rho+corrections[a]>=rho/100 for a in range(7))
print("PASS: rational covariance, trace-free identity, strict margin, floor, budget and",count,"perturbation cases")
print("OPEN: the H8 compact weighted anti-divergence estimate")
