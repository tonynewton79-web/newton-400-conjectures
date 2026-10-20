# Appendix AC. Source-native axial stress flux and the H8 cone

This is the author-readable mathematical source for pages **115–116** of the cumulative **116-page** Case 006 manuscript, dated 20 October 2026. The preceding 114 PDF pages were verified identical to the prior release. The complete typeset LaTeX and exact replay are in the release archive.

## Motivation and source audit

Appendix AB gives a strong necessary radius-by-radius inequality for the source's axial force, angular correction and flat envelope. But the actual prepared source is defined in the original Case 006 by the projected structured-stress divergence (242), and (273) asks for a correction after subtracting the seven-ray cone centre. A separate expansion of every C4 cutoff, frame-transport, pressure and nonlinear source term is unnecessary **once a single complete divergence-form representative is chosen**. Its boundary/gauge traces, however, may not be discarded.

Original Proposition 9.22 Eqs. (258), (265), (266) specifies a signed physical cylindrical cone-centre shear:
```text
alpha=(Rstar)_rz=−4443/9832 = −0.4518917819365338…
kappa=15971/122900 = 0.1299511798209927…
```
Equation (266) of the original source provides the absolute value only; the sign follows by multiplying the explicitly specified radial and axial components of bstar=(35 e1+2 e2)/sqrt(1229).

Work on an annular full-angular cylinder `a<r<b, c<z<d`, with smooth representative `Tmath` of the complete structured stress (possibly a globally glued source), nonnegative flat envelope rho, and source representative
```text
f=div S + grad p0,  S=Tmath−rho Rstar.
```
The pressure p0 denotes the gradient ambiguity inherent in specifying only a projected divergence. Define `<...>` as the full 2pi angular mean and
```text
T(r)=∫_c^d<Tmath_rz> dz, R(r)=∫_c^d<rho> dz,
Fz(r)=∫_c^d<f_z> dz,
q(r)=[<S_zz+p0>]_(z=c)^(z=d).
```

## Theorem: exact source-native cumulative force including all boundary defects

The cylindrical divergence identity has the exact full-angular mean
```text
Fz(r)=(1/r) d_r[r(T(r)−alpha R(r))]+q(r).
```
Consequently the cumulative physical axial-force primitive is
```text
J(r)=r^(-1)∫_a^r sFz(s)ds
    =T(r)−alpha R(r)−(a/r)[T(a)−alpha R(a)]
      +(1/r)∫_a^r s q(s)ds.
```
Proof: in the physical cylindrical orthonormal chart `(div S)_z=r^-1∂r(rS_rz)+r^-1∂theta S_theta,z+∂z S_zz`. The angular derivative averages to zero on a full period, while both ∂z Szz and ∂z p0 contribute the displayed axial trace q. Because the cone frame is expressed in physical cylindrical components, `(rho Rstar)_rz=alpha rho`. One radial integration proves the cumulative formula.

Thus **if the selected raw representative is compact with zero relevant axial and radial boundary traces**, then q=0, T(a)=R(a)=0 and
```text
J(r)=T(r)−alpha R(r)=T(r)+(4443/9832)R(r).
```
If the same traces vanish at b, total physical axial force `2pi ∫_a^b rFz dr=0` automatically for this compact raw-divergence representative. This conditional result avoids asserting zero force for an unspecified **periodic or noncompact** structured inverse or a noncompact pressure gauge.

## Exact source-only cone condition

The original full seven-ray coefficient norm is
```text
N(H)=max{8|B|, 2|C|+4|D|, 2|A−4B|+4|D|} ≤ kappa rho.
```
Since `A=4B+(A−4B)`, the sharp component-only inequality is `|A|≤kappa rho`, attained algebraically for `B=kappa rho/8, A−4B=kappa rho/2, C=D=0`. Integration of the correction's axial equation in z, with compact correction and pressure traces, gives `∫<A> dz=J`. Therefore
```text
|J(r)|≤kappa R(r)         at every radius.
```
In the compact-source case, for R(r)>0 the structured shear must satisfy
```text
alpha−kappa ≤ T(r)/R(r) ≤ alpha+kappa,
−143017/245800 ≤ T(r)/R(r) ≤ −79133/245800,
i.e. −0.5818429617575265… ≤ T/R ≤ −0.3219406021155411….
```
**This is a direct, necessary source-native test before selecting angular or meridional corrections.** If the angular correction B is already fixed, Appendix AB's sharper local test remains
```text
|J(r)−4 Bbar(r)| ≤ (kappa/2) R(r),
Bbar(r)=∫_c^d<B> dz.
```
A compact *zero* structured-rz target with positive R fails the source-only necessary inequality since |alpha|>kappa. This diagnostic applies to the stated compact representative, **not** to the unfrozen actual prepared source.

## Critical projection/frame scope

The paper's (242) specifies equality of Leray-projected divergences, not literal equality of compact raw tensors. A representative and its gauge must be selected. A global periodic or noncompact Rstr, pressure with nonvanishing axial traces, radial inner boundary flux, or incomplete transported C4 chart requires the additional terms in the full formula for J. A local patch should not silently be substituted for a full angular cylinder; patch transport/cutoff tensors must be included in the complete glued Tmath, and the physical cylindrical cone coefficients must be reconciled with the transported local frame. **Neither the final `Phi_theta,Phi,Xi` profiles nor the complete pressure/gluing tensors are frozen by Remark 9.23.** There is no source-supported numerical physical ratio T/R to report.

The finite symbolic replay [attack026](../attack026/verify_source_native_axial_flux.py) checks the signed seven-ray centre exactly, rational source-only interval, a genuine C4 angular derivative whose mean vanishes, a manufactured NONZERO axial pressure/boundary trace, the cumulative inner-boundary correction, cutoff product terms, automatic force cancellation for a compact representative and saturation of the finite cone capacity. This verifies the identities, not the unspecified actual H8 construction.

[Lean candidate](../../../NewtonConjectures/Case006SourceNativeAxialFlux.lean) formalizes only finite rational/shear/cone algebra and a radial-product-rule jet; the angular integral, distributional projection, pressure support, global chart and compact PDE are not kernel-formalized. The exact original slice bound (249), full positivity (272), compact weighted inversion (273), and unforced Navier–Stokes singularity remain **open**.

**Next decisive test:** freeze one globally transported physical structured-stress representative Tmath, source pressure gauge p0 and flat envelope rho, interval-enclose all terms in the complete J formula at every radius, and apply the source-only and fixed-B tests before attempting full weighted H8 inversion.
