# Appendix K. Quantitative conditioning of the H8 quadratic-moment Jacobian

Tony Newton — continuation of *Carrier-Independent Structured Stress Route from an Exact Unforced Navier–Stokes Core*, [doi:10.5281/zenodo.23475142](https://doi.org/10.5281/zenodo.23475142). This is the living manuscript text corresponding to the two-page typeset Appendix K added after Appendix J. The original 78 PDF pages remain unmodified.

## Motivation

Appendix J proves a conditional rank defect for a fully half-turn-equivariant source family in a common fixed H8 stress frame. A usable source-native test must quantify both how a weakly broken symmetry affects the determinant and how accurately nine actual moment integrals must be computed before their invertibility is certified.

The manuscript still does not fix the physical shell profiles or transported frames. The following theorems are general finite-dimensional facts **conditionally applicable** when the rows of the actual source-native Jacobian satisfy their hypotheses; they do not assign new values to that matrix.

## K.1. A sharp rowwise determinant theorem

**Theorem.** Let `J` be a real 3×3 matrix and `eps,M >= 0`. If `|J_1j|,|J_2j| <= eps` and `|J_3j| <= M` for every column `j`, then

```text
|det J| <= 4 M eps².
```

The factor 4 is **optimal**.

**Proof.** For positive eps and M, divide the first two rows by eps and the third by M. The determinant is separately affine in every matrix entry. Thus the largest absolute determinant on the box `[-1,1]^9` occurs at a sign matrix (repeated one-dimensional endpoint extremization). Subtract its first row from the other two rows; those rows are even, so its determinant is divisible by 4. Hadamard's inequality gives `|det| <= 3^(3/2) < 8`, hence the absolute determinant is at most 4. The sign matrix `[[1,1,1],[1,-1,1],[1,1,-1]]` has determinant exactly 4. The zero-scale cases follow by continuity.

The more explicit `eps`-factorization for a Jacobian with first two rows scaled by eps is

```text
det [[eps a,eps b,eps c],
     [eps d,eps e,eps f],
     [g,h,i]]
   = eps² (a e i + b f g + c d h - c e g - b d i - a f h).
```

If `J` is invertible and its first row has entries bounded by eps>0, then

```text
||J^(-1)||₂ >= 1/(sqrt(3) eps).
```

Indeed `sigma_min(J)=sigma_min(Jᵀ) <= ||Jᵀ e₁||₂ <= sqrt(3) eps`. Thus two small odd-moment rows force a quadratic determinant penalty, and even one small row forces poor inverse conditioning.

This theorem concerns the **shared fixed-frame** half-turn parity decomposition. The original H8 cone is tilted and rotates among patches; numerical row bounds for its transported source-native Jacobian have not yet been obtained.

## K.2. A rational interval certificate for a future Jacobian

**Proposition.** Suppose a future profile calculation yields a reference matrix `B` with `|B_ij| <= L`, and rigorous componentwise error intervals `|J_ij-B_ij| <= delta`, where `L,delta >= 0`. Then

```text
|det J-det B| <= 18 L² delta + 18 L delta² + 6 delta³.
```

Consequently the strict lower test

```text
|det B| > 18 L² delta + 18 L delta² + 6 delta³
```

certifies `det J != 0`.

**Proof.** The determinant consists of six signed products. Expand each product of three terms `B_ij+E_ij`; the seven nonconstant terms are bounded by `3L²delta+3Ldelta²+delta³`. Apply the triangle inequality to all six permutations.

**Exact arithmetic example (not an H8 source result).** For
```text
B=[[3,1,0],[1,2,0],[0,0,1]], L=3, delta=1/100
```
one has `det B=5`, and the bound evaluates to exactly
```text
812703/500000 = 1.625406 < 5.
```
Hence every matrix within that exact entrywise interval is invertible. This example shows how a **genuine computed source-native Jacobian** could later be certified; this B was **not** obtained from the Navier–Stokes shell construction.

## K.3. Connection to the main paper

Appendix J establishes, for a fixed frame and the source `s_alpha=g_alpha-div(rho_alpha Rstar)`, the derivative

```text
J_ij = ∫ (∂_alpha_j g_alpha)|0 · q_i + (1217/1229)∫ f_i (∂_alpha_j rho_alpha)|0,
(f1,f2,f3)=(y,x,-2z).
```

Moving frames, pressure choices and additional source terms must be differentiated separately. To apply either determinant theorem, first freeze admissible source-native profiles `Phi_theta,Phi,Xi` and the transported cone geometry, compute all nine moment derivatives with rigorous intervals, and verify lower moments, the slice-torque cancellation and production/support/graph constraints. A nonzero determinant would establish only local moment controllability. The compact weighted inversion with the coefficient budget `15971/122900` would remain to prove.

## K.4. Reproducibility and Lean boundary

[Independent exact checker](../attack008/verify_conditioning.py) audits all 512 sign matrices (maximum 4), 4,096 rational quadratic-suppression samples, 4,096 rational interval-perturbation samples and the illustrative rational matrix. [Lean algebraic fragment](../../../NewtonConjectures/Case006JacobianConditioning.lean) formalizes the determinant scaling identities, parity-block formula, nonzero-factors implication, sign witness and rational interval comparison. **The universal box inequality is not yet Lean-formalized**, and neither the PDE source moment formula nor source-native invertibility has an end-to-end Lean proof. New GitHub Actions must complete successfully before the algebraic Lean fragment is called kernel-verified.
