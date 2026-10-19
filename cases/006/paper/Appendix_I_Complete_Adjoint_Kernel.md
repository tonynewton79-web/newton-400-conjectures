# Appendix I. Complete smooth adjoint kernel of the four-field H8 operator

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* ([Zenodo DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142)). This is the source corresponding to the typeset three-page Appendix I appended to the cumulative 75-page manuscript.

## Why this classification matters

Appendix H found three quadratic adjoint-null vector fields and therefore three additional necessary compact-source moment conditions. One must still ask whether higher-degree or nonpolynomial smooth adjoint-null fields generate further moments. The following theorem settles that *kernel classification* for the fixed constant-coefficient restricted four-field operator. It does not settle solvability of the compact weighted equation.

## Theorem — the kernel is exactly ten-dimensional

For
```text
H(A,B,C,D) = [-D C A; C 0 B; A B D],
L(H,p) = div H + grad p,
```
write `q=(u,v,w)`. Its formal adjoint annihilates all four coefficient fields and pressure exactly when
```text
u_y+v_x=0, u_z+w_x=0, v_z+w_y=0,
u_x=w_z, u_x+v_y+w_z=0.
```
Set `f=u_x` and `T=diag(1,-2,1)`. The system is equivalent to
```text
sym(∇q) = f T .
```

**Theorem.** On every connected open subset of R³, every C³ solution has the unique form
```text
q(r) = b + W r + t T r + α q1(r)+β q2(r)+γ q3(r),
```
with `b ∈ R³`, `W` any skew-symmetric 3×3 matrix, and `t,α,β,γ∈R`, where
```text
q1=(xy,-(x²+2y²+z²)/2,yz),
q2=((x²+2y²-z²)/2,-2xy,xz),
q3=(-2xz,4yz,x²-2y²-z²).
```
Consequently the smooth formal-adjoint kernel has **dimension 10**, decomposed as 3 translations, 3 infinitesimal rotations, 1 anisotropic linear dilation and 3 quadratic modes. No other smooth solutions (including nonpolynomial functions) occur.

### Complete proof

The symmetric gradient `E=sym ∇q` satisfies Saint-Venant compatibility:
```text
∂ik Ejl+∂jl Eik−∂il Ejk−∂jk Eil = 0.
```
Substituting `E=f diag(1,-2,1)` gives six independent equations,
```text
2 f_xx − f_yy = 0,       f_yz=0,
f_xx + f_zz = 0,        f_xz=0,
f_xy = 0,               f_yy − 2 f_zz=0.
```
The first and last give `f_xx=f_zz`; together with the third this implies `f_xx=f_zz=f_yy=0`. The other three eliminate all mixed second derivatives, so `D²f=0` and `f=t+βx+αy−2γz` is affine on a connected domain.

Direct differentiation of the three displayed quadratic fields gives first-component x-derivatives `y,x,−2z`, and each field satisfies the adjoint equations. Subtracting `tTr+αq1+βq2+γq3` from any solution therefore leaves a field `h` with `sym ∇h=0`. The standard Euclidean infinitesimal-rigidity identity, obtained by commuting its second derivatives, implies `D²h=0`, so `h=b+Wr` with `Wᵀ=−W`. Conversely, all ten terms satisfy the original first-order equations. Comparing derivatives establishes uniqueness.

### Compact moment consequence

When `H,p` and `s=div H+grad p` are smooth and compactly supported in one Euclidean chart, integration by parts against each adjoint basis field gives **ten necessary scalar moment conditions**: three force, three torque, one anisotropic affine, and the three quadratic conditions of Appendix H. Since the theorem classifies every smooth local adjoint-null field, there are no *additional smooth adjoint-null moment test fields* for this operator. This is **not a sufficiency theorem** for compact range, and it does not certify the weighted pointwise budget of H8.

### Independent exact replay

The [exact SymPy checker](../attack006/verify_finite_type.py) independently verifies the ten explicit solutions, computes the 6×6 compatibility rank and determinant `−8`, and forms homogeneous polynomial coefficient matrices in degrees 0–5. Their nullities are `3,4,3,0,0,0`. The 30×30 degree-three coefficient matrix is nonsingular; in the stated monomial order its determinant is `5159780352`.

The [Lean algebraic fragment](../../../NewtonConjectures/Case006FiniteType.lean) formally eliminates the six Hessian unknowns given the six compatibility relations. The differentiable PDE-to-compatibility step and complete smooth classification are **not** yet end-to-end formalized in Lean; check GitHub Actions before claiming even the fragment is kernel-verified.

## Mathematical boundary and next step

The profile data needed to compute the actual source-native quadratic moment vector and its admissible 3×3 actuator Jacobian are not sufficiently specified in the original manuscript. The next legitimate test is to fix one normalized family, compute those moments (including support and pressure localization), then certify the Jacobian and the sharp pointwise dual inequality. Nothing here implies a compact weighted H8 inverse or an unforced Navier–Stokes blow-up theorem.
