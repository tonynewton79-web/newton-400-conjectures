# Case 006 — Carrier-independent structured stress from an unforced Navier–Stokes core

**Source:** Tony Newton, [Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core](https://doi.org/10.5281/zenodo.23475142), Zenodo record 23475142, 19 October 2026.

This is **Case 006**, deliberately isolated from other Navier–Stokes work and from Cases 001–004. It is a research/formal-verification case, **not a conjecture solved or a Millennium-problem claim**.

## What the machine-checkable certificate says

[Lean source](../../NewtonConjectures/Case006Stress.lean) proves finite exact statements from Proposition 9.22 and equations (262)–(272):

1. At aperture t=1/4, seven explicitly defined rank-one rational rays with weights (1,1,59/43,1,1,1,1) yield every entry of the 3×3 covariance Q0 in equation (263).
2. The trace is 679/86 and its normalized trace-free part is exactly u⊗u/1229 − I/3 for u=(35,2,0), the rational form of (265).
3. The axial-efficiency margin is exactly 4443/9832−9/20=93/49160 > 0.
4. The normalized seven-ray weights have a coefficient floor of at least 172/1229.
5. The coefficient budget is exactly 172/1229−1/100=15971/122900.
6. **Conditional theorem:** if all four-field coefficient perturbations satisfy the *assumed* H8 bound, the resulting coefficients remain at least rho/100.
7. Separate elementary balanced-slot, two-color partition and cutoff identities.

[Independent standard-library Fraction arithmetic audit](verify_exact.py) checks the finite certificates independently of Lean.

## Nonformalized / open mathematical gates

- Theorem 2.2's normally convergent exact local unforced singular-core construction.
- The PDE/function-space localization, transverse anti-divergence, full moving-frame and time-assembly estimates.
- Crucially, **H8**, the compact support and weighted anti-divergence estimate (273) with coefficient bound 15971/122900, for a *fully specified* profile family.
- The global finite-energy singular Navier–Stokes solution and logical relationship to the Clay problem.

**A successful Lean CI run is a real kernel check of the listed finite theorems only.** It is not a kernel check of the 65-page paper, nor a solution of the unforced Navier–Stokes problem.

## Reproducibility

As of 19 October 2026, the [actual Lean CI run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39260218045) compiled the Case 006 source and audited 341 declarations under NewtonConjectures with only propext, Classical.choice, and Quot.sound. The proof-placeholder scan passed. The [independent exact rational CI run](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39260223557) also passed. The open compact weighted H8 gate is tracked in [Issue #25](https://github.com/tonynewton79-web/newton-400-conjectures/issues/25).\n\nThe repository pins Lean v4.24.0 and mathlib v4.24.0. The existing [Lean workflow](../../.github/workflows/lean.yml) builds the combined project, executes an axiom audit, and rejects proof placeholders. Case 006 is imported into the library entry point. Run `lake exe cache get && lake build` or inspect the associated GitHub Actions results.

The document’s Appendix F describes a wider companion algebraic kernel; this case begins with an independently written, narrower set of algebraic proofs and makes no claim to have imported or verified the original unpublished companion file.

## Attack 002 — augmented-symbol coercivity (kernel check pending)

[Attack 002 mathematical report](attack002/README.md) · [Lean source](../../NewtonConjectures/Case006H8Symbol.lean) · [independent exact-rational replay](attack002/verify_symbol.py).

The pressure-augmented four-field operator has an exact sum-of-squares factorization giving the **sharp** uniform Fourier symbol estimate `||M(xi)^T v||² >= |xi|²|v|²/5`. The Gram determinant also has an exact positive factorization. These facts remove a characteristic-direction obstruction to a noncompact Fourier inverse. They do **not** produce a compact, weighted H8 correction, prove its coefficient budget or resolve finite-energy Navier--Stokes breakdown. The new Lean source must pass CI and axiom audit before its theorem is called kernel-verified.

### Cumulative manuscript continuation

The living [Appendix G: exact H8 symbol, Fourier right inverse and dual necessary inequality](paper/Appendix_G_H8_Symbol_and_Dual.md) records every substantive proof from the present continuation. The original 65-page source remains available at [Zenodo 23475142](https://doi.org/10.5281/zenodo.23475142); the generated 69-page combined PDF and the editable typeset Appendix G source are sent separately as author research artifacts. GitHub stores the text-mathematical continuation, exact test scripts, and the individual Lean proof fragments.

The new [pressure-free symbol analysis](../../NewtonConjectures/Case006Ungauged.lean) proves the exact Gram determinant `(x²+z²)²(x²+y²+z²)`; the ungauged operator has characteristic directions on the nonzero y-axis. The pressure-augmented operator has the sharp uniform lower bound `||M(xi)^T v||² >= |xi|²|v|²/5`. A noncompact periodic Fourier right inverse follows, but **not** the compact weighted H8 estimate.

[Exact-rational validation of the pressure-free determinant and 5x3 Fourier pseudoinverse](attack004/verify_operator.py): 343 rational frequency tests, 342 invertible modes. Together with Attack 002's exact SOS and Attack 003's polar proof, this supplies a structural and numerical baseline. The latest Lean kernel status should be read from the associated GitHub Actions run. The H8 compact inversion with frozen source-native profiles remains open under [Issue #25](https://github.com/tonynewton79-web/newton-400-conjectures/issues/25).

### Appendix H — quadratic compact-support moment obstruction

The cumulative [Appendix H](paper/Appendix_H_Quadratic_Moments.md) establishes three explicit divergence-free quadratic adjoint-null vector polynomials for the restricted four-field tensor H(A,B,C,D). They yield three **additional necessary quadratic source moments** for any compactly supported four-field correction modulo compact pressure. The smooth source `s=(0, ∂_x² η, 0)` with a nonzero-integral compact bump η has every force and affine first moment zero but fails the first quadratic moment, so those lower-order conditions alone are not sufficient for arbitrary compact source inversion. This is **not** a counterexample to the source-native residual, whose quadratic moments remain unknown.

[Lean polynomial identities](../../NewtonConjectures/Case006QuadraticMoments.lean) and [symbolic independent test](attack005/verify_quadratic.py). Lean kernel build and axiom audit on the new branch remain separate release obligations; the full compact PDE argument is not Lean-formalized.

### Appendix I — complete smooth finite-type H8 adjoint kernel

[Appendix I, complete mathematical proof](paper/Appendix_I_Complete_Adjoint_Kernel.md) now classifies **every smooth local adjoint-null vector field** of the four-field operator with pressure. The kernel is exactly 10-dimensional: 3 translations, 3 infinitesimal rotations, one anisotropic dilation and the 3 quadratic fields of Appendix H. There are no higher-degree or nonpolynomial smooth local solutions. The proof uses the Saint-Venant compatibility equation `sym ∇q=f diag(1,-2,1)`; its six independent constraints force `Hess f=0`.

[Exact polynomial/rank audit](attack006/verify_finite_type.py) verifies all 10 generators, a 6×6 compatibility determinant −8, and degree-0–5 polynomial nullities 3,4,3,0,0,0 (30×30 degree-3 matrix of full rank). [Lean algebraic fragment](../../NewtonConjectures/Case006FiniteType.lean) addresses the six-variable elimination, but the full differentiable finite-type classification remains **not end-to-end Lean-formalized**.

The cumulative author-facing PDF now contains **75 pages** (original 65 + Appendices G 4, H 3, I 3); the original 72 cumulative pages have been preserved unchanged. This is a complete *adjoint-null moment classification*, not a compact H8 existence theorem or a Navier–Stokes resolution. The actual source-native residual and admissible moment Jacobian still require a fixed profile.
