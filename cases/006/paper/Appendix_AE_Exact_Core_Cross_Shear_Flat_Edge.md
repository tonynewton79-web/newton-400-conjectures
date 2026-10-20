# Appendix AE. Exact-core leading shear and a flat-edge constraint on the H8 preparation

*Continuation of Tony Newton, **Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core**. Complete polished two-page LaTeX in the 120-page cumulative paper, pages 119–120; the preceding 118 pages remain text-identical.*

## Why the distinction matters

Appendix AC reduces the weighted cone problem to the axially integrated physical `rz` component of the **complete** prepared stress. Appendix AD computes the quadratic poloidal-shaper term, but the interaction with the singular exact core was still missing. Original (199)–(200) supplies a **leading axis profile**, not all off-axis coefficients; original (209) contains further radial corrections, and Remark 9.23 leaves the globally localized full stress and shapers unfrozen.

Write `q=1-t`, `A=1/2+h`, `D=1/2-h`, `eta=z*q^-D`, `ell=sqrt(q)`, `c=q^D`. The exact source's leading axial profile is `Ustar(eta)=4*eta+j0`. Its regular-axis incompressible affine continuation is
```text
ur0=-2r/q, uz0=q^-A(4eta+j0)=4z/q+j0*q^-A, utheta0=0.
```
This comparison field solves the unforced Navier–Stokes equations exactly (all viscosities), with `p0=−r²/q²−10z²/q²−(A+4)j0*q^(-A-1)z`; it has infinite energy and must NOT be substituted for the complete first-shell core. The full source paper does **not** provide frozen numerical data controlling its deviation on the H8 patch.

## Theorem 1. Exact leading-core mixed shear and a compact-support sign change

For the original separable poloidal shaper (194),
```text
Psi=K*Phi(r/ell)*Xi(z/c), K=Az*ell²U,
Pr=-K*Phi*Xi'/(r*c), Pz=K*Phi'*Xi/(r*ell),
mXi=∫Xi(zeta) dzeta,
```
the axial quadratic cross stress has the exact formula
```text
T0(r)=∫(ur0 Pz+uz0 Pr)dz
=−2*K*c*mXi/q*[Phi'/ell − 2*Phi/r]
=−2*K*c*mXi/q*r²*d_r(Phi/r²).
```
Here Phi' is the dimensionless derivative. If `KmXi≠0` and Phi is nonzero, nonnegative and compactly supported away from r=0, the function `Phi/r²` vanishes at both radial endpoints and is positive somewhere; its derivative, and therefore T0, must have **both signs**. Thus this isolated leading-core cross term cannot by itself provide a stress flux confined to the entirely negative physical cone-centre window in Appendix AC across its whole support.

For the *actual* smooth solenoidal axisymmetric exact-core field `uc`, define `delta u=uc-u0`,
```text
deltaI(r)=∫delta ur(r,z)*Xi(z/c)dz,
deltaJ(r)=∫delta uz(r,z)*Xi'(z/c)dz.
```
Then **without any asymptotic approximation**
```text
T_uc,P = T0 + Rc,
Rc=K/r*[Phi'/ell*deltaI−Phi/c*deltaJ],
deltaJ/c=deltaI'(r)+deltaI(r)/r.
```
In particular,
```text
|Rc|≤|K|/r[(|Phi'|/ell)*c*||Xi||_L1*||delta ur||_inf
               +|Phi|*||Xi'||_L1*||delta uz||_inf].
```
This is the explicit, missing full-exact-core coefficient estimate, rather than an assumed error bar.

## Theorem 2. Rigorous flat-edge obstruction for a quadratic envelope

Let Phi be smooth, nonzero and positive inside a compact annular interval (a,b), tending to zero at its endpoints, with `KmXi≠0`. Suppose an envelope radial mass `R(r)>0` obeys `R(r)≤M*Phi(r/ell)^2`. Then **no finite constant C** can satisfy `|T0|≤C*R` throughout (a,b).

Proof: put `v(r)=Phi(r/ell)/r²>0`. The exact T0 formula and the bound would imply `|v'|≤C'v²`; consequently `|(1/v)'|≤C'`. But 1/v diverges at a finite endpoint, an impossibility. It follows that if a purported full flux decomposes as `Tstr=T0+Trest` with `|Trest|≤C0 R`, it cannot meet `|Tstr−alpha R|≤kappa R` everywhere, for `alpha=−4443/9832`, `kappa=15971/122900`.

This is a **conditional no-go for an isolated first-order cross term with a quadratic-envelope assumption**. The actual prepared tensor may contain additional first-order shear/cutoff contributions that cancel it or an envelope with different boundary decay; this does not prove failure of the original full H8 source.

## Lemma. Place the diagnostic radial shaper inside the strong-Rayleigh radial shell

Original (206) uses `s=chi(eta)*Lambda_c*r²/(2q)∈[6,6.1]`. For axial support with `0<chiMin≤chi(eta)≤chiMax` and **chiMax/chiMin<61/60**, the common radial interval
```text
6/chiMin < Lambda_c*r²/(2q) < (61/10)/chiMax
```
is nonempty and lies in the strong-Rayleigh window for every axial point in that support. Original Proposition 9.20 provides a strictly positive chi on a suitable small axial neighborhood; continuity permits the ratio to be as close to 1 as required. This does NOT by itself certify the original transition collar, kinetic/virial envelope normalization, complete nonlinear patch gluing or cone.

## Reproducibility and remaining physical work

[Independent exact SymPy and 75-digit checker](../attack028/verify_exact_core_cross_shear.py) verifies incompressibility, the comparison field's exact unforced NS equations, the mixed-shear formula, source perturbation term, exact shell-support ratio, the sign-changing and flat-edge numerical model, and **independently integrates the original urPz+uzPr product** at four radii. The [Lean candidate](../../../NewtonConjectures/Case006LeadingCoreShear.lean) encodes finite radial/Wronskian/shell geometry only; its build and the PDE/integral analytic theorem require separate verification.

The actual complete core expansion, pressure/structured inverse, admissible shapers, four localized C4 cutoffs and overlaps, and real normalized rho are **not frozen**. No physically quantitative full-source T/R pass or fail is claimed. Gates (249), (272), the weighted compact inverse (273), and an unforced finite-energy Navier–Stokes singularity remain open. The next attack must certify the error Rc against the true core coefficient series and the complete stress remainder, including flat-edge cancellation.
