# Appendix X. Exact divergence-preserving smoothing at a flat H8 boundary

This is the complete research continuation underlying the two-page typeset Appendix X, pages **105–106** of the cumulative **106-page** Case 006 paper (the preceding 104 pages are preserved text-identically). The full editable LaTeX and reproducibility packet are included in the author email.

## The problem

Appendix U constructs a bounded measurable angular flux V under the complete family of weighted dual tests. Appendix W proves that variable-radius mollification preserves a strict relative cone reserve at the flat boundary but creates a divergence commutator. The question is whether one can avoid solving a second weighted divergence equation while retaining exactly the original angular source f.

## Exact Piola and transport-homotopy identity

On Omega=(0,1)^2 let V∈L∞ have div V=f in distributions, where f is smooth. Take a nonnegative unit-mass smooth mollifier eta supported in |u|≤1 and a positive smooth spatially dependent radius eps(X) such that F_{t,u}(X)=X+t eps(X)u is a diffeomorphism on the interior for t∈[0,1]. Define
```text
J_{t,u}=1+t u·grad eps,
P_u=(det D F_{1,u})(D F_{1,u})^-1
   =(1+u·grad eps)I-u tensor grad eps.

S_eps V(X)
 = ∫eta(u) P_u(X)V(F_{1,u}(X))du
   - ∫eta(u)∫_0^1 eps(X)u f(F_{t,u}(X))dt du.
```

**Proposition.** The field S_eps V is smooth in the interior and **div(S_eps V)=f exactly**, with no extra commutator correction.

Proof: the classical Piola identity gives div(P_u V∘F_{1,u})=J_{1,u}f∘F_{1,u}. The elementary homotopy identity
```text
d/dt [ J_{t,u}(X) f(F_{t,u}(X)) ]
 = div_X [ eps(X) u f(F_{t,u}(X)) ]
```
is checked by direct differentiation. Integrating t and subtracting cancels the source transported by the Piola term. Every fixed-u term already has divergence f; averaging smooths V.

**Prior art:** Piola calculus is classical, for example Kupferman–Shachar, *A geometric perspective on the Piola identity in Riemannian settings*, Journal of Geometric Mechanics 11 (2019), DOI 10.3934/jgm.2019004. Variable-step mollification also predates this work. The source-preserving composition here is a concrete H8-adapted calculation, not a claim to invent the Piola identity.

## The global flat-weight angular theorem

Use the Appendix W separable flat weight
```text
w(x,y)=p(x)p(y),
p(x)=exp[-x^-2-(1-x)^-2] for 0<x<1, and zero otherwise,
d(X)=min{x,1-x,y,1-y},
varphi(X)=x(1-x)y(1-y).
```

The angular cone capacities are a=kappa/2, b=kappa/8, kappa=15971/122900. Assume a smooth compact source f with support in the closed square has finite **polynomial relative-growth order**
```text
|f(X)| <= Fstar w(X)d(X)^(-m), m∈Z_{>=0}.
```
Assume the **full** Appendix U dual inequality with strict margin sigma:
```text
|∫f psi| <= (1-sigma)∫w[a|psi_x|+b|psi_y|]
for every psi∈C_c∞(Omega),    0<sigma<1.
```

**Theorem.** Set eps_c=c*varphi^(m+3), 0<c≤1/8. If
```text
exp(16c) * [(1-sigma)*(1+5(m+3)c)
  + (Fstar*c)/(8*b*(1-c/4)^m)] <= 1-sigma/2,
```
then the full dual inequality produces a **globally C∞ compactly supported angular flux** Vsharp satisfying div Vsharp=f and
```text
|Vsharp_r| <= (1-sigma/2) a w,
|Vsharp_z| <= (1-sigma/2) b w.
```
The associated angular H8 correction has exact joint four-field coefficient cost ≤(1-sigma/2)kappa*rho, after any necessary physical-chart capacity rescaling. For fixed finite Fstar,m and positive sigma, such a sufficiently small c always exists.

**Proof.** Appendix U's duality first produces a bounded weak flux V with initial margin sigma. The Piola-homotopy identity preserves div exactly. Since eps_c≤c*d^(m+3), eps_c/d≤c/4, the flat weight ratio under every sampling map is ≤exp(16c), and d(F_{t,u})≥(1-c/4)d. The anisotropic row sum of P_u, using a/b=4 and |∂_i eps_c|≤c(m+3)/4, is ≤1+5(m+3)c. The source homotopy costs at most Fstar*c*exp(16c)/[8b(1-c/4)^m] relative to either component capacity. The displayed inequality leaves sigma/2 of the original cone reserve. Differentiating the smooth integral kernel bounds all derivatives of the weak-field term by C_j*w*d^(-N_j); flat exponential decay beats every power and gives smooth zero extension. The homotopy term also extends smoothly since f is globally C∞ and flat on the closed-square boundary.

This yields an **exact smooth lifting theorem for all weak angular sources satisfying these explicit dual and relative-growth hypotheses**, not merely the radially slice-balanced subclass from Appendix W. It still does not cover sources with arbitrarily fast |f|/w growth at the flat boundary.

## Independent exact verification, formal scope and next H8 step

[Source checker](../attack021/verify_piola_flat_lifting.py) verifies, with exact SymPy polynomials, the 2x2 cofactor matrix, pointwise Piola divergence equation, t-homotopy transport identity and the resulting **exact source-preserving divergence for each u**. The rational test sigma=1/4, c=1/1024, m=0, Fstar=kappa/16 gives an upper bound of exactly **12469/16128 < 7/8** for the model cone cost using exp(t)≤1/(1-t). Exponents m=1,2,3,4 pass independently by a looser rational upper bound. This is an illustrative model parameter choice, not an interval enclosure of the original H8 source.

[Lean source](../../../NewtonConjectures/Case006PiolaFlatLifting.lean) proves only the finite polynomial Piola/cofactor, transport-jet and rational reserve identities; the full distributional Piola theorem and smooth flat-boundary analysis are not end-to-end Lean formalized, and compiler CI must pass before kernel verification is claimed.

**Remaining boundary:** The original physical complete prepared source g, rho and curvature profiles have not been frozen; neither the strict all-test dual reserve nor the finite relative-growth exponent for that actual source is certified. This lifts the **angular equation only** for its stated subclass. Coupling to the three meridional stress equations, compact pressure, real slice gate (249), full cone positivity (272), compact weighted H8 inversion (273), and any unforced Navier–Stokes singularity remain unproved.
