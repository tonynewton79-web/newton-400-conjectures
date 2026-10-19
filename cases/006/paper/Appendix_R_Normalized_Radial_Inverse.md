# Appendix R. Explicit normalized curved-shell profiles and an inverse-pairing estimate

Continuation of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core* ([source manuscript](https://doi.org/10.5281/zenodo.23475142)). The complete revised two-page Appendix R has been typeset and appended to the cumulative 94-page author PDF, with all previous 92 pages preserved. This note supplies an explicit radial shaper **formula** in terms of the source's `chi(eta)`, plus a conditional inverse bound; it is **not** a final numerical H8 release.

## Actual source geometry, source-native shaper normalization, and quantitative correction

The source's Eqs. (199), (202), and (257) define the narrow strong-Rayleigh shell by
```
s = Y_tilde = chi(eta) Lambda_c R^2/2,    6 <= s <= 6.1,
0 < chi_c <= chi(eta) <= 1,   -G_R >= gstar Lambda_c^(-1/2).
```
On a compact axial interval inside that patch, write `Lambda=Lambda_c`. Let `beta(u)=exp[-1/(1-u²)]/Z` for |u|<1, extended by zero otherwise, with `Z=∫_{-1}^1exp[-1/(1-v²)]dv`. Let `beta_w(u)=beta(u/w)/w` and choose **exact rational** centres and support halfwidth
```
s0=241/40=6.025, s1=243/40=6.075, w_s=1/100.
support s0: [1203/200, 1207/200] = [6.015,6.035],
support s1: [1213/200, 1217/200] = [6.065,6.085].
```
Choose **explicit normalized smooth nonnegative radial shapers**
```
tau_j(R,eta) = chi(eta)*Lambda/R *
                beta_{w_s}(chi(eta)*Lambda*R²/2 - s_j).
```
Multiply by an axial cutoff equal to one on the target interior interval and zero before chi loses its lower bound. Both shapers are supported away from R=0, so they are smooth and compact. Exactly, `ds=chi Lambda R dR`, and source Eq. (250) gives `M_j=∫R²tau_j dR=1` where the axial cutoff is one.

The source guarantees strict radial shear but its R separation is **not** fixed as Lambda grows. At each eta,
```
R(s,eta)=sqrt(2s/(chi(eta)*Lambda)),
Delta R >= sqrt(2/Lambda)*(sqrt(1213/200)-sqrt(1207/200)).
```
Consequently with `g_j=N_j/M_j`,
```
g0-g1 >= kappa_Lambda := gstar*dstar/Lambda,
dstar=sqrt(2)*(sqrt(1213/200)-sqrt(1207/200))
     =0.008624400245557853... .
```
This revises the informal impression in Appendix Q that the source provides a Lambda-independent radial support gap. The actual *curved-shell* weighted average gap is only **guaranteed order Lambda^-1**, not Lambda^-1/2. At fixed Lambda it remains strictly positive, so Appendix Q's qualitative rank theorem survives, but its coefficient-size cost is not uniform in Lambda.

A second exact amplitude cost follows solely from nonnegative unit normalization:
```
||tau_j(·,eta)||_∞ >= 3/(R_+³-R_-³)
=3*(chi(eta)*Lambda/2)^(3/2)/
      [(s_j+w_s)^(3/2)-(s_j-w_s)^(3/2)] .
```
For chi>=chi_c>0 this grows at least as Lambda^(3/2). This is *not* a contradiction: Lambda is an intentionally large but fixed parameter in the source. It is a warning that normalization must be propagated to the physical torque and stress budgets.

## Theorem: concrete quantitative sufficient inverse bound

On a compact interior axial interval `J`, let the exact reference adjoints solve
```
delta phi'' + b(eta) phi' + gamma phi=0,
b(eta)=D eta + g0(eta), delta=nu epsilon²>0,
gamma=3/2-2h>0.
```
At an interior point `eta0`, normalize the two fundamental solutions by `(phi1,phi1')(eta0)=(1,0)`, `(phi2,phi2')(eta0)=(0,1)`. Put `k=g0-g1`. Take two unit-mass compact nonnegative axial bumps centred at `eta0` and `eta0+t`, supported within radii `w_a` of those points, with `2w_a<t` and full support in J.

Suppose on `J0=[eta0-w_a,eta0+t+w_a]` that
```
|b|<=B,    kappa_Lambda<=k<=K,    |k'|<=T.
L=max(1+B/delta,gamma/delta), E=exp(L(t+w_a)),
P=sqrt(2) K E, H=sqrt(2) E(T+K L), e=w_a H.
```
The following are **explicit sufficient tests**:
```
L exp(Lt)*(B*t/2+gamma*t²/6) <= gamma/2,
2*e*P+e² <= kappa_Lambda²*gamma*t/(4delta).
```
If they hold, the exact mixed-profile pairing matrix
`C_ij=∫phi_i L1[A_j]deta` satisfies
```
|det C| >= kappa_Lambda²*gamma*t/(4delta),
||C^-1||_∞ <= 8delta*K*E/(kappa_Lambda²*gamma*t).
```
For a compact target f, the correction coefficients `alpha=C^-1(∫phi_i f)_i` obey
```
||alpha||_∞ <= [8delta*K*E*E_f/(kappa_Lambda²*gamma*t)] ||f||_1,
E_f=max_i sup_{support f}|phi_i|.
```
The result is rigorous even though `B,K,T,E_f` have not been numerically frozen. Its proof, including Gronwall's ODE bound, the sharp point-column determinant with one initially vanishing derivative, and a finite-width perturbation estimate, appears in the typeset Appendix R. The source's axial derivative must be computed at **fixed s**, giving `partial_eta G(R(s,eta),eta)=G_eta-(chi'/2chi)R G_R`; in particular `T<=2 sup|G_eta-(chi'/2chi)RG_R|`.

## Checks and H8 boundary

The [independent replay](../attack015/verify_normalized_inverse.py) checks all four rational support endpoints, both source-normalization Jacobians, the exact radial square-root gap, the Lambda^(3/2) sup-amplitude lower bound and the determinant/inverse theorem's *sufficient inequalities on a clearly diagnostic box*. It also rechecks the algebraic differentiated-Wronskian identity. The numerical illustration does **not** give interval bounds for the actual source's `G,chi`.

The [Lean algebraic source](../../../NewtonConjectures/Case006NormalizedInverse.lean) tests the rational endpoints, substitution Jacobian, axial-coordinate derivative and exact 15971/122900 cone reserve. The exponential ODE estimate, flat-bump integrals, source PDE and H8 are outside this Lean fragment and its GitHub CI must complete successfully.

Source Eq. (249) concerns the **entire dimensional slice torque**, `|m(z)|≲epsilon*ell³ Fstar`; the localized scalar repair does not certify the remaining cutoff, pressure and source terms. Eq. (272) is the pointwise coefficient-weighted constraint `C(H)<=15971/122900 rho`, which requires the **actual compact stress response** of the corrected source and control of the flat envelope boundary. The present matrix bound controls only scalar coefficients and grows at worst with the explicit `Lambda²/(gstar²)` factor before incorporating bounds on K. Thus **neither (249) nor (272) passes with the presently specified source data**, and the compact weighted inverse (273) remains open.

**Next physical attack:** extract explicit `chi,G,nu,epsilon` values, enclose `B,K,T,E_f` and the target f on one actual permitted patch; optimize `t,w_a` subject to the two determinant tests, then estimate the corresponding radial/shaper derivatives, complete slice residual, and actual stress coefficient budget. This is the genuine next gate—not another test of abstract rank alone.
