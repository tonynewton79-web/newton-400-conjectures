# Appendix O. Cylindrical transport and the torque carried by the seven-ray centre

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, original manuscript [DOI 10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). The edited two-page Appendix O is also typeset in the cumulative **88-page main-paper PDF**, preserving the previous 86 pages identically.

## Source interpretation and the new theorem

Appendix N demonstrated a non-covariance obstruction for a *single fixed Cartesian* tilted tensor. Equations (258)–(265) of the actual source instead specify the cone's eigenvector in the **moving physical cylindrical basis**. From those equations,

```text
b*(theta)=br e_r(theta)+btheta e_theta(theta)+bz e_z,
(br,btheta,bz)=(35 sqrt(91/200)+sqrt2, -21/2,
                -35 sqrt(91/200)+sqrt2)/sqrt1229,
br*bz = -4443/9832,
btheta*bz=(147sqrt182-84sqrt2)/9832 > 0.
```

Thus, for a compact axisymmetric envelope rho(r,z) supported away from the axis,

```text
K=rho(r,z)[b*(theta) tensor b*(theta)-I/3]
```

is exactly SO(2), and hence C4, **tensor-equivariant**: K(SX)=S K(X) S^T. This settles C4 covariance for the *actual local source-native cone centre*; it does not determine globally transported patch tensors.

**Theorem (full cylindrical connection divergence).**
The divergence of K in physical cylindrical coordinates is exactly

```text
divK_r=(br²-1/3) rho_r +(br²-btheta²)rho/r +br*bz rho_z,
divK_theta=br*btheta(rho_r+2rho/r)+btheta*bz rho_z,
divK_z=br*bz(rho_r+rho/r)+(bz²-1/3)rho_z.
```

All 1/r and 2/r terms come from cylindrical-basis derivatives. Given any compact axisymmetric *unprojected* prepared source g, set s=g-divK and

```text
m_g(z)=int_0^infty r² g_theta(r,z)dr,
R2(z)=int_0^infty r² rho(r,z)dr.
```

Then

```text
m_s(z)=m_g(z)-btheta*bz R2'(z).
```

**Proof.** Cartesian differentiation, followed by expressing the vector in the moving cylindrical basis, produces the displayed divergence. Multiplying its theta component by r² yields

```text
r² (divK)_theta = br*btheta d_r(r²rho)
                    + btheta*bz r² d_z rho.
```

The radial derivative vanishes under integration by compact support, giving the slice formula.

**Corollary (exact necessary torque-active compensation).** If rho≥0 is smooth, compact, and nonzero, then R2 is nonzero and compactly supported. Since btheta*bz>0 for the actual cone centre, R2' is not identically zero. An identically slice-torque-neutral g therefore cannot make s exactly slice-torque-neutral. To achieve exact full-source neutrality, g must satisfy

```text
m_g(z)=btheta*bz R2'(z).
```

Original equation (249) requires a *scale-sharp smallness* bound, which is weaker than exact neutrality and requires its own quantitative check. This theorem does not show that the admissible torque-active shaper actually achieves the indicated profile; equation (251) remains the source-native actuator constraint.

## Correct meridional and torque-dipole baseline moments

For E=(xz,yz,-z²), F=(-yz,xz,0), G=(0,0,x²+y²), the three baseline stress contributions are

```text
A_K=int rho [ z(1-3 bz²)+r br bz]dX,
B_K=btheta*bz int r rho dX =2pi*btheta*bz int R2(z)dz,
C_K=2 br bz int r rho dX.
```

So B_K is strictly positive for every nontrivial nonnegative compact rho, even when the baseline has **zero integrated total torque**. The correct full-source moment is B_s=B_g+B_K. This supersedes Appendix N's *Cartesian fixed-seed* formulas **only for the actual moving cylindrical centre**, not under that earlier special model's hypotheses.

## Source-native toroidal/poloidal shapers and limits

Original Proposition 9.12, equations (193)–(194), defines axisymmetric toroidal and poloidal perturbations. With smooth compact profiles A(r,z), H(r,z), a representative form is

```text
U_T = r A(r,z) e_theta,
U_P = -r H_z(r,z)e_r + (2H+r H_r)e_z,
Psi=r²H.
```

Both are divergence-free and continuously rotation-equivariant on the shell. Applied to the assumed axisymmetric first-shell background, the **complete** Navier–Stokes quadratic interaction is also rotation-equivariant, including the generally nonzero toroidal–poloidal cross terms. A suitably axisymmetric pressure primitive retains the covariance, although its compact localization is a separate problem.

Thus the *explicit local shell shaper class* and the *actual cylindrical cone centre* satisfy C4 covariance. The source paper does **not** fix all subsequent nonaxisymmetric corrections, global patch maps, cutoff families, or compact pressure gauges. No exact C4 certificate for the final full prepared H8 source, no cone-weighted compact inverse and no global unforced Navier–Stokes singularity follows.

**Verification:** [exact symbolic/rational source-centre and torque checker](../attack012/verify_cylindrical_frame.py) verifies the frame, full Cartesian divergence, three integral moment densities, generic smooth toroidal/poloidal solenoidality and covariance, nonzero nonlinear interaction covariance, and an exact positive compact polynomial bump diagnostic. [Lean algebraic fragment](../../../NewtonConjectures/Case006CylindricalTorque.lean) covers only polynomial identities, not analytic integration or the complete PDE. The GitHub Actions kernel audit is a separate pending gate.

**Next physical test:** choose the actual normalized envelope profile rho and complete g, compute R2'(z) and m_g(z) with exact/interval control, test the residual m_s against (249), and instantiate any needed torque-active actuator from (251). Then audit the full global source patch maps, pressure, and seven-ray positivity on overlaps.
