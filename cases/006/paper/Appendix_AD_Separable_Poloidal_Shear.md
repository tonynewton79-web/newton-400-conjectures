# Appendix AD. Separable poloidal shapers and the axial shear of a frozen stress model

Research continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The two-page typeset appendix is included on pages **117–118** of the **118-page cumulative manuscript**, preserving all prior 116 pages.

## Question and original source

The original Proposition 9.12, Eq. (194), proposes a compact divergence-free poloidal shell field
[
Psi=KPhi(r/ell)Xi(z/c),qquad
P_r=-KPhiXi'/(rc),quad P_z=KPhi'Xi/(rell),
quad K=A_zell^2U .
]
Remark 9.23 leaves the final transition profiles and the complete prepared structured stress (R_{mathrm{str}}) unfrozen. Appendix AC makes the sign and magnitude of its integrated physical (rz) shear a necessary test for a compact cone correction. This note calculates the **direct poloidal kinetic contribution** to that shear, exactly. It does not identify the quadratic kinetic tensor with the original full prepared (R_{mathrm{str}}), which includes exact-core interactions, transports, pressure, and global stress inversion.

## Theorem: exact single-profile cancellation and two-profile wedge

For every separable compact smooth poloidal field of the exact original form, and for every radius away from the axis,
[
int_{mathbb R}P_r(r,z)P_z(r,z),dz=0.
]
The proof is the compact boundary identity (int XiXi'=[Xi^2/2]_{-infty}^{infty}=0). The original toroidal shaper has no (rz) quadratic component, including products with the poloidal field.

If two streamfunctions (Psi_j=K_jPhi_j(r/ell)Xi_j(z/c)) are superposed, with (P=P_1+P_2), then the integrated quadratic shear is **exactly**
[
T_{m kin}(r)=int (Potimes P)_{rz},dz
=-rac{K_1K_2}{r^2ell}
(Phi_1Phi_2'-Phi_2Phi_1')
intXi_1'(zeta)Xi_2(zeta)dzeta.
]
Thus it vanishes for proportional radial profiles or proportional axial profiles. Nonzero shear requires **simultaneous radial Wronskian and antisymmetric axial overlap**. This is an exact constraint on the source's shaper ansatz, **not** a no-go for the complete stress or its interactions with the background.

## Fully specified smooth flat diagnostic

Let (b(s)=Z^{-1}exp[-1/(1-s^2)]) on (|s|<1), zero outside, (Z=int_{-1}^1exp[-1/(1-t^2)]dt), (I_2=int b^2>0). Put (x=r/ell-2), (zeta=z/c), and
[
Phi_1=b(x),quad Phi_2=(1+mu x)b(x),quad
Xi_1=b(zeta),quad Xi_2=(1+lambdazeta)b(zeta).
]
For (|mu|,|lambda|<1), all four are **nonnegative, (C^infty), compact, flat, and normalized to unit dimensionless integral**. The exact overlaps are
[
Phi_1Phi_2'-Phi_2Phi_1'=mu b(x)^2,quad
intXi_1'Xi_2=-lambda I_2/2.
]
With (mu=1/2,lambda=-1/2,K_1,K_2>0),
[
T_{m kin}(r)=-rac{K_1K_2I_2}{8r^2ell}b(x)^2<0
]
throughout the interior support (ell<r<3ell).

The **DIAGNOSTIC**, not physically validated, envelope
[
ho_{m diag}(r,z)=ho_0 r^{-2}b(x)^2b(zeta)^2,quad
ho_0=rac{1229}{4443}rac{K_1K_2}{cell}
]
has (R_{m diag}(r)=intho_{m diag}dz=ho_0cr^{-2}b(x)^2I_2). For **every interior radius**, without any numerical approximations,
[
oxed{rac{T_{m kin}}{R_{m diag}}
=-rac{4443}{9832}=alpha,qquad
|T_{m kin}-alpha R_{m diag}|=0 .}
]
So this manufactured compact stress/gauge pair **passes the single-component source-only necessary interval of Appendix AC at all radii**, with maximal scalar reserve, whereas a single separable raw quadratic stress with (T_{m kin}=0) would fail it for any positive envelope since (|alpha|>kappa=15971/122900). Neither finding checks the other six cone coefficients.

To close the DIAGNOSTIC raw source, set (mathsf T^{m diag}=Potimes P), (p_0=0). This tensor and envelope are smooth and flat at the full annular radial and axial boundaries. Their (q(r)) and inner boundary traces in Appendix AC vanish. Axisymmetry gives exact covariance under the four physical quarter-turn rotations (S_k(x,y,z)=(R_{kpi/2}(x,y),z)). **These are NOT the actual four compact localized physical H8 patch maps**: nontrivial cutoff/gluing and nonlinear overlap terms remain unconstructed and unchecked. The chosen radial support also has not been proved to belong to the source's admissible strong-Rayleigh transition patch.

## Background interference and next physical gate

The base velocity can contribute shear even with one shaper. If (u) is axisymmetric and solenoidal, let (I(r)=int u_r(r,z)Xi(z/c)dz). Exact integration by parts gives
[
int(u_rP_z+u_zP_r)dz
=rac K r left[rac{Phi'}{ell}I-Phileft(I'+rac I right)ight].
]
This formula identifies **the real exact-core background data** required before asserting a physical full-source value. The source does not freeze these profiles, nonlinear residuals or the complete (R_{mathrm{str}}), so no physical (T(r)/R(r)) has been certified.

[Independent exact symbolic and 70-digit checker](../attack027/verify_separable_shear.py) confirms the Wronskian, axial antisymmetric overlap, negative sign, exact rational all-radii ratio, source-only pass/fail contrast, and quarter-turn maps. An independently integrated 70-digit calculation of the **original velocity products** at five radii reproduces the derived shear. [Finite Lean algebra](../../../NewtonConjectures/Case006SeparableShear.lean) checks only rational and algebraic parts, not the integral/NS proof.

**Next source-native requirement:** freeze the actual core background (u), final exact transition shapers, four localized transports and overlaps, kinetic envelope normalization, and full pressure/stress representative. Only then can the *actual* H8 source-only interval or the fixed-angular correction cone bound be interval-certified. The full compact weighted H8 inverse, physical (249)/(272)/(273), nonaxisymmetric tensor equations and unforced finite-energy Navier–Stokes singularity remain OPEN.
