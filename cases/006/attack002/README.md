# Case 006 — Attack 002: a sharp sum-of-squares identity for the H8 symbol

The manuscript's remaining H8 equation is a compact *weighted* anti-divergence problem, not an algebraic matrix problem. We isolate a prerequisite: does the four-field trace-free stress operator, augmented by the pressure gauge, have characteristic directions that prohibit a uniform Fourier inverse?

Let
```text
H(A,B,C,D) = [-D C A; C 0 B; A B D].
```
At spatial covector `xi=(x,y,z)`, the operator `div H + grad p` has columns indexed by `A,B,C,D,p` and symbol
```text
M(x,y,z) = [ z  0  y -x  x
             0  z  x  0  y
             x  y  0  z  z ].
```
For any real test polarization `v=(a,b,c)`, **the exact identity** is
```text
||M^T v||² - (1/5)|xi|²|v|²
 = (4/5)[(ya+xb)²+(yc+zb)²+(za-xc)²]
   +(1/5)[3(xa+zc)+2yb]².
```
The right side is a sum of squares. Therefore the augmented symbol has **uniform lower singular-value bound**

```text
||M^T v||² >= (1/5)|xi|²|v|².
```

The constant 1/5 is **sharp over real covectors/polarizations**: take `xi=(sqrt(2),sqrt(3),0)` and `v=(sqrt(2),-sqrt(3),0)`, for which equality holds. A rational approximation is `xi=(49,60,0)` and `v=(49,-60,0)`, with ratio within 1e-7 of 1/5.

The 3x3 Gram determinant factors exactly:
```text
16 det(M M^T)
= |xi|² [7 |xi|⁴ + (3y²-5(x²+z²))²]
>= 7 |xi|⁶.
```
Hence no nonzero Fourier direction is characteristic for the **pressure-augmented operator**. This provides a global noncompact Fourier inverse with explicit symbol conditioning (the usual |xi|^{-1} order); a compact, weighted, fixed-profile inverse is NOT constructed here.

The [Lean 4 theorem](../../../NewtonConjectures/Case006H8Symbol.lean) formalizes the exact sum-of-squares equality and the uniform energy inequality. The [standard-library Fraction verifier](verify_symbol.py) independently checks the symbol, covariance Gram, and determinant identity on exact rational controls. A Lean build/axiom audit must pass before kernel verification is claimed.

## Open gate
Equation (273) still requires a *compactly supported* H with source-matched moments, graph bounds, and weighted pointwise coefficient budget `15971/122900 rho`. Symbol coercivity does not imply any of those. The source shell profiles are not specified numerically in the manuscript; the next attack must freeze them and test the *weighted* inverse or prove a dual obstruction. This remains Issue #25.
