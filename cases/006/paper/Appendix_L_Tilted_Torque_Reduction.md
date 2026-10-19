# Appendix L. Tilted-frame quadratic moments and axial slice torque

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, DOI [10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). The typeset Appendix L occupies two pages of the **82-page** cumulative paper (previous 80 pages unchanged).

## The exact projection theorem

Work in a fixed physical Euclidean chart. The compact source `g` and nonnegative baseline envelope `rho` are assumed axisymmetric about the physical z-axis. Rotate the four-field cone frame about physical x by
```
R = [1 0 0;0 c -t;0 t c],    c²+t²=1.
```
Here `t` is physical frame tilt, **not** the seven-ray aperture 1/4. The quadratic adjoint fields `q_i` are as in Appendix H; use the rotated fields `q_i^R(X)=R q_i(R^T X)`. Introduce three axisymmetric divergence-free quadratic test fields
```
E=(xz,yz,-z²)=rz e_r-z² e_z,
F=(-yz,xz,0)=rz e_theta,
G=(0,0,r²)=r² e_z.
```
Average a test vector field over physical axial rotation by `Pq=(1/2π)∫ R_phi^T q(R_phi X)dphi`. A direct exact angular-monomial calculation gives
```
P q1^R = [t(3t²-1)/2] E - [t(5-3t²)/4] G,
P q2^R = -3ct F,
P q3^R = c(1-3t²) E - [c(1+3t²)/2] G.
```
Consequently, with `A=∫g·E`, `B=∫g·F`, `C=∫g·G`,
```
  [∫g·q1^R]   [t(3t²-1)/2       0     -t(5-3t²)/4] [A]
  [∫g·q2^R] = [0                 -3ct   0            ] [B]
  [∫g·q3^R]   [c(1-3t²)          0     -c(1+3t²)/2  ] [C].
```
The exact determinant is `-(9/2)c²t²(1-3t²)`; the meridional two-by-two minor is `(3/2)ct(1-3t²)`. This transfer matrix is generically invertible, except at `ct=0` or `t²=1/3`. **Its invertibility is not a source-native actuator-Jacobian theorem.**

## Exact connection with original equation (248)

For the axisymmetric azimuthal source component `g_theta(r,z)`, let
```
m(z)=∫_0^∞ r² g_theta(r,z)dr .
```
Then `B=2π∫ z m(z)dz` and
```
∫g·q2^R=-6πct∫ z m(z)dz.
```
The exact slice-torque-neutral condition `m(z)≡0` annihilates the second quadratic moment. Zero *integrated* torque `∫m(z)dz=0` alone does not. The strong-Rayleigh paper's (249) is a smallness condition, while (252) is exact neutrality of a selected toroidal shaper, **not automatically the complete source**.

## Cone baseline and reduced moment equations

For the specific unprojected compact H8 source `s=g-div(rho Rstar^R)`, assume `rho` axisymmetric, `Rstar^R=R Rstar R^T` and a **fixed** R, with `kappa=Rstar:diag(1,-2,1)=1217/1229`. Set `Z=∫z rho`. Then integration by parts gives
```
(∫s·q1^R, ∫s·q2^R, ∫s·q3^R)^T =
T(c,t)(A,B,C)^T + kappa Z (t,0,-2c)^T.
```
(The rotated anisotropic baseline divergence need not itself be axisymmetric, but its q2 moment is zero.)

**Reduced source moment theorem.** If `ct(1-3t²)≠0`, all three quadratic moments of s vanish if and only if
```
B=0,       C=0,       (1-3t²)A=2 kappa Z.
```
Therefore if the *complete* compact axisymmetric source has exact slice-torque neutrality, B=0 automatically and the remaining two meridional moments are the appropriate local controllability target. If `Z=0`, those reduce to `A=C=0`.

At exceptional tilt `t²=1/3`, a nonzero Z makes the meridional equations inconsistent. No conclusion about the actual transported, possibly nonaxisymmetric H8 source follows from this specialized fact.

## Physical interpretation and proof boundary

An unrestricted three-by-three moment Jacobian need not be nonsingular **within a source family that preserves exact slice-torque neutrality**, since its q2 moment is then identically zero. Instead one should test two admissible meridional actuator responses for `(C,(1-3t²)A-2kappa Z)`, while verifying the slice-torque constraint separately.

The manuscript's Proposition 9.12 provides axisymmetric toroidal/poloidal shaper *classes*, and (250)–(252) provides exact slice-neutral toroidal profiles, but the complete H8 prepared source, transported local cone frame, pressure representative and patch gluing have not been instantiated. Four-copy C4 symmetry is weaker than SO(2) invariance. **None of the actual source-native moment identities or weighted H8 inversion is yet certified.**

Independent checker: `cases/006/attack009/verify_tilt_torque.py`. New Lean file: `NewtonConjectures/Case006TiltTorque.lean`, which formally proves only the polynomial determinant and cancellation identities, not cylindrical integration or the PDE.
