#!/usr/bin/env python3
"""Case 002 Attack 004: exact arithmetic audit, pure Python 3 standard library.
The classical Tartakowsky local-global theorem is external, not numerically tested.
"""
import itertools, json
from pathlib import Path

A=((8,5,4,4,3),(5,10,6,5,4),(4,6,10,6,4),(4,5,6,10,5),(3,4,4,5,8))
K=((2,0,2),(2,1,1),(1,0,0),(0,1,0),(0,0,1))
P=((27,10,19),(10,5,7),(19,7,15))

def det(a):
    n=len(a)
    return sum((-1)**sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))*
        __import__('math').prod(a[i][p[i]] for i in range(n))
        for p in itertools.permutations(range(n)))

def q(y):
    total=sum(y[i]*A[i][j]*y[j] for i in range(5) for j in range(5))
    assert total%2==0
    return total//2

def q3(z):return sum(z[i]*P[i][j]*z[j] for i in range(3) for j in range(3))
def grad(y):return [sum(A[i][j]*y[j] for j in range(5)) for i in range(5)]
def grad3(z):return [2*sum(P[i][j]*z[j] for j in range(3)) for i in range(3)]

def verify():
    assert det(A)==10368 and det(P)==57
    for i in range(3):
        for j in range(3):
            assert sum(K[k][i]*A[k][l]*K[l][j] for k in range(5) for l in range(5))==6*P[i][j]
    e=[tuple(int(i==j) for i in range(5)) for j in range(5)]
    for idx,residue in [(3,1),(4,0)]:
        assert q(e[idx])%2==residue and any(c%2 for c in grad(e[idx]))
    for idx,residue in [(0,1),(1,2)]:
        assert q(e[idx])%3==residue and any(c%3 for c in grad(e[idx]))
    zchoices=((1,0,0),(1,1,0),(0,1,0))
    for residue,z in enumerate(zchoices):
        assert q3(z)%3==residue and any(c%3 for c in grad3(z))
    tested=0
    for y in itertools.product(range(-2,3),repeat=5):
        x=(*y,-sum(y))
        D=(5*sum(v*v for v in x)+2*sum(x[i]*x[(i+1)%6] for i in range(6)))//2
        assert q(y)==D
        assert 2*D==3*sum(v*v for v in x)+sum((x[i]+x[(i+1)%6])**2 for i in range(6))
        for t in (2,4,9):
            g=tuple(t+v for v in x)
            if min(g)>=1:
                m=sum(g)
                numer=14*m*m-5*sum(v*v for v in g)-2*sum(g[i]*g[(i+1)%6] for i in range(6))-39*m+72
                assert numer%2==0
                assert numer//2==231*t*t-117*t+36-D
        tested+=1
    for z in itertools.product(range(-3,4),repeat=3):
        y=tuple(sum(K[i][j]*z[j] for j in range(3)) for i in range(5))
        assert q(y)==3*q3(z)
    result={"status":"PASS_LOCAL_ARITHMETIC_NOT_EXTERNAL_THEOREM",
            "hessian_det":10368,"gram_det":324,"auxiliary_det":57,
            "integer_vector_tests":tested,"p2_residues":[0,1],
            "p3_unit_residues":[1,2],"p3_divided_form_residues":[0,1,2],
            "conclusion":"cofinite, non-effective, conditional only on classical Tartakowsky theorem"}
    out=Path(__file__).parent/"certificates"/"attack004.json"
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(result,sort_keys=True,indent=2)+"\n")
    print(json.dumps(result,sort_keys=True,indent=2))
if __name__=="__main__":verify()
