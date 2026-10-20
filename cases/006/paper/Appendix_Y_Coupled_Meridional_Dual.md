# Appendix Y. Coupled angular–meridional cone duality

This is the scholarly source for the two-page Appendix Y of Tony Newton, *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*. The **108-page cumulative manuscript** preserves the first 106 pages text-identically. The original source's equation (269) is analyzed in the physical cylindrical frame; nothing here freezes the actual Navier–Stokes prepared source or proves full H8.

## Exact residual cone and sharp polar

With H(A,B,C,D)=[[-D,C,A],[C,0,B],[A,B,D]], k=(15971/122900)rho, original (270) gives the exact coefficient norm

`N(H)=max(8|B|, 2|C|+4|D|, 2|A−4B|+4|D|)`.

After fixing admissible angular fields B=H_theta,z and C=H_r,theta, set E=A−4B. The remaining (E,D) form precisely the symmetric convex polytope

`K_C={(E,D): |E|+2|D|≤k/2, |D|≤(k−2|C|)/4}`.

**Proposition (exact sharp polar).** For all meridional test-gradient scalars P,S,

`h_C(P,S)=sup_{K_C}(EP+DS)=max{k|P|/2, |C||P|+(k−2|C|)|S|/4}`.

At fixed d=|D|, choose signs of E,D to match P,S and saturate |E|=k/2−2d. The objective is affine in d∈[0,(k−2|C|)/4]; its two endpoint values give the formula. This is sharp, not merely an upper bound.

**Uniform guaranteed meridional reserve.** If 8|B|≤k and 2|C|≤(1−tau)k with tau∈(0,1], then the entire rectangle |E|≤k/4 and |D|≤tau*k/8 is inside the full seven-ray cone. Appendix X's angular slack tau=sigma/2 therefore leaves |A−4B|≤k/4 and |D|≤sigma*k/16. This is *only an available coefficient allowance*, not a source inverse.

## Axisymmetric meridional weak iff modulo pressure

Let Omega=(r-,r+)×(z-,z+) be a simply connected physical annular-coordinate rectangle with r_->0, and let B,C be a fixed axisymmetric angular lift satisfying its pointwise capacity. For any axisymmetric four-field stress in the cylindrical chart, the exact divergence components are

```text
(div H)_r = −D_r + A_z − D/r,
(div H)_z = A_r + D_z + A/r,
(div H)_theta = C_r + B_z + 2C/r.
```

For every smooth compact meridional test psi=(psi_r,psi_z) with *physical* solenoidality (r psi_r)_r+(r psi_z)_z=0, define P_psi=(psi_r)_z+(psi_z)_r and S_psi=(psi_z)_z−(psi_r)_r.

**Theorem (exact iff in bounded-weak axisymmetric category).** There exist measurable compactly supported E,D satisfying K_C almost everywhere and a distributional pressure p such that the *meridional* source f_m satisfies f_m=(div H(4B+E,B,C,D))_m+grad_m p if and only if **every** such test psi obeys

```text
|∫_Omega r (f_m·psi + 4B P_psi) dr dz|
  ≤ ∫_Omega r h_C(P_psi,S_psi) dr dz.
```

Necessity: integrate against the physically weighted measure r dr dz. Pressure cancels against physical divergence-free tests, while H:grad psi=(4B+E)P_psi+D S_psi; apply the sharp polar. Sufficiency: the all-test bound defines a norm-one linear functional on the range of psi↦(P_psi,S_psi) with the integral support-function seminorm. Standard Hahn–Banach and measurable integral-polar duality represent it by (E,D) in K_C. The residual source annihilates all physically solenoidal meridional test fields and hence is a pressure gradient by the distributional de Rham lemma on the simply connected rectangle. General convex duality and de Rham theory are established prior mathematics, not claimed as new.

This theorem applies **only to the axisymmetric zero-angular-Fourier sector**, allows bounded-measurable stress and distributional pressure, and imposes the entire family of tests. It is *not* a smooth compact weighted meridional H8 inverse and does not control pressure support or angular Fourier modes.

## Reproducibility and physical boundaries

[Exact SymPy/Fraction verifier](../attack022/verify_coupled_meridional.py) passes all three cylindrical divergence components and checks the exact polytope support formula against rational vertices for hundreds of rational cases. The angular-margin rectangular reserve is checked for several rational tau values. A nontrivial smooth manufactured stress with B=k/64, C=k/16, D=k/32, E=k/8 and A=4B+E has exact full norm 3k/8; its three source components are computed as the divergence of that stress. This is a mathematical example, **not the original unforced Navier–Stokes prepared source**.

[Lean finite algebra](../../../NewtonConjectures/Case006MeridionalCoupling.lean) tests the shift, polar endpoints, strict reserve and saturation algebra. It does **not** formalize the Hahn–Banach, de Rham, cylindrical PDE or original H8. Kernel CI is a separate gate.

The actual complete source g, envelope rho and original chi/G profiles remain unfrozen, so the physical all-test criterion has not been verified. The smooth flat-weight lift of E,D, three-dimensional nonaxisymmetric system, compact pressure, slice estimate (249), cone positivity (272), full compact weighted H8 inversion (273) and unforced Navier–Stokes singularity remain **open**.

**Next exact target:** test the full-axisymmetric meridional dual on an explicitly frozen physical source and develop a smooth weight-adapted pressure-aware lifting of E,D without spending the angular cone margin. Nonzero angular Fourier modes require separate equations and estimates.
