#!/usr/bin/env python3
"""Exact Eq. (255) pressure-jet dependence of M'=(Z*/L)'.
No complete physical Pi0, Pi0', Pi0'' values assumed.
"""
import sympy as s
eta,A,D,h,j0,P0,P1,P2=s.symbols('eta A D h j0 P0 P1 P2',real=True)
U=4*eta+j0; d=1-eta**2; H=D*eta+d*U; L=1-2*h*eta**2
Z=-A*(1-2*eta*U)*U-4*H-d*P1+4*A*eta*P0
Zp=s.diff(Z,eta)+s.diff(Z,P0)*P1+s.diff(Z,P1)*P2
Mprime=s.factor((L*Zp-s.diff(L,eta)*Z)/L**2)
assert s.simplify(s.diff(Mprime,P2)+d/L)==0
assert s.simplify(s.diff(Mprime,P0)-4*A*(1+2*h*eta**2)/L**2)==0
assert s.simplify(s.diff(Mprime,P1)+2*eta*(4*A*eta**2*h-2*A+2*h-1)/L**2)==0
print('PASS Eq255 pressure sensitivity dMprime/dPi0second=-(1-eta^2)/(1-2h*eta^2)')
print('PASS exact Pi0 and Pi0first sensitivities; full physical pressure jet remains unfrozen')
