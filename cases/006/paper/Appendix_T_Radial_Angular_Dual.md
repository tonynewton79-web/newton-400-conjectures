# Appendix T. A radial angular-stress obstruction beyond cumulative torque

Tony Newton, continuation of *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The fully typeset two-page Appendix T is appended as pages 97–98 of the **98-page** cumulative author PDF, preserving all prior 96 pages exactly.

## The problem

Appendix S derives an exact necessary axial flux band for a potential compact H8 correction, \(|M_g(z)-\beta R_2(z)|\le\kappa R_2(z)/8\), with source-derived constants
\(\beta=(147\sqrt{182}-84\sqrt2)/9832\) and \(\kappa=15971/122900\).
The final normalized source \(g\) and envelope \(\rho\) remain unfrozen in the source manuscript (Remark 9.23), so there is **no genuinely computed physical ratio \(M_g/R_2\)**. We can nonetheless establish that this axial band is far from sufficient, even for the angular tensor equation alone.

## The radial angular-dual theorem

In an annular cylindrical chart, with complete \(2\pi\) angular periodicity, compact support, a single-valued periodic pressure and the trace-free four-field correction from original Eqs. (269)–(273), put \(h_\theta=(g-\nabla\cdot K)_\theta\), \(K=\rho R_*\), and let brackets denote the angular average.

Original Eq. (270) has coefficient changes \(2C-4D\), \(-2C-4D\) and \(\pm8B\). Their common bound \(\mathcal C(H)\le\kappa\rho\) implies **both** \(|H_{r\theta}|=|C|\le\kappa\rho/2\) and \(|H_{\theta z}|=|B|\le\kappa\rho/8\). The angular cylindrical divergence, after multiplying by \(r^2\) and averaging, is
```text
r² <h_theta> = ∂r (r² <H_rtheta>) + ∂z (r² <H_thetaz>).
```
Consequently **for every compact smooth axial-radial test psi**,
```text
|∬ psi r²<h_theta> dr dz|
<= ∬ r²<rho> [ (kappa/2)|∂r psi| + (kappa/8)|∂z psi| ] dr dz.
```
Proof: angular pressure derivative averages to zero; integrate the divergence identity by parts, use compact boundary support and the two precise coefficient bounds. Axial-only tests are consequences of Appendix S, but radially dependent tests impose genuinely new restrictions.

## Exact manufactured source passing the flux band but failing the radial test

Let \(\rho(r,z)=u(r)v(z)\) be any nonzero smooth nonnegative compact envelope in an annular shell. Keep the **actual moving cylindrical** cone centre and define the smooth compact, axisymmetric, divergence-free azimuthal vector source
```text
g = g_theta(r,z) e_theta,
g_theta = (div K)_theta + alpha (∂r rho + 2rho/r).
```
This \(g\) is a **manufactured mathematical diagnostic source, not the constructed Navier–Stokes prepared source**. From the exact source-centre connection formula of Appendix O,
```text
r² g_theta = (b_r b_theta+alpha) ∂r(r² rho)
                    + beta r² ∂z rho.
```
Radial integration removes the derivative, giving \(m_g(z)=\beta R_2'(z)\), \(M_g(z)=\beta R_2(z)\). Thus its ratio is **exactly** \(M_g/R_2=\beta\) throughout the nonzero envelope region, the centre of Appendix S's permitted band, **for every alpha**.

The angular residual is \(r²h_\theta=\alpha\partial_r(r²\rho)\). Choose a smooth compact test \(\psi(r,z)=\psi_r(r)\psi_z(z)\) with \(\psi_r'=1\) on the radial support of \(\rho\) and \(\psi_z=1\) on its axial support. Then \(\partial_z\psi=0\) wherever \(\rho\ne0\). The dual bound becomes
```text
|alpha| ∫∫ r²rho <= (kappa/2) ∫∫ r²rho.
```
Since the positive integral is nonzero, **every compact H satisfying the complete cone norm and angular equation must have**
```text
|alpha| <= kappa/2 = 15971/245800.
```
This is **sharp for the angular equation alone**: take the four-field stress with \(C=H_{r\theta}=\alpha\rho\) and \(A=B=D=0\). Its angular divergence matches the constructed source exactly and its seven coefficient changes are \((0,2\alpha\rho,-2\alpha\rho,0,0,0,0)\), so \(\mathcal C(H)=2|\alpha|\rho\).

In particular \(\alpha=\kappa\) fails the cone by a factor 2 although the cumulative flux ratio passes **with equality at its centre**; \(\alpha=\kappa/4\) passes the angular-sector test at half of the available reserve. **Passing is not full H8 inversion**: the other three projected meridional tensor equations have not been solved.

## Research implication and verification

For a source-native candidate, numerical or interval evaluation must include (a) the pointwise cumulative ratio band, **and** (b) the radial--axial dual tests above, followed by the other three tensor components, exact source torque actuator Eq. (251), slice bound (249), weighted cone (272), and compact inverse (273). The original source does not freeze sufficient physical profiles to perform (a) or (b) numerically for its final construction; reporting a physical PASS would invent input.

[Independent exact SymPy verifier](../attack017/verify_angular_dual.py) checks the cylindrical source identity, equality in the flux test, the seven-ray coefficient norm and exact PASS/SHARP/FAIL values. [Lean finite algebra](../../../NewtonConjectures/Case006RadialAngularDual.lean) proves the sharp two-coefficient radial bound, pure-sector norm and rational thresholds. The cylindrical integration and actual PDE remain outside Lean. The 98-page PDF and original 96 pages are verified by page-text comparison. This research finding is a sharp necessary angular-sector test, not a solution of the H8 compact weighted inversion or an unforced Navier–Stokes singularity theorem.
