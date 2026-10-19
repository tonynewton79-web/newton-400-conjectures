# Case 006 — Attack 003: exact polar inequality for the H8 coefficient budget

The open H8 correction is symmetric and trace-free,

```text
H = [-D C A; C 0 B; A B D].
```

Equation (270) gives its seven raw coefficient perturbations. Their maximum absolute value is **exactly**

```text
N(A,B,C,D) = max(8|B|, 2|C|+4|D|, 2|A-4B|+4|D|).
```

The term `3|D|/2` from the first perturbation is redundant. No approximation or appeal to numerical convex optimization is needed: this identity follows from `max(|u+v|,|u-v|)=|u|+|v|`.

### Exact polar

For a linear functional `L=A P+B Q+C R+D S`, the sharp maximum over `N(A,B,C,D)<=k` (for `k>=0`) is

```text
sup L = k * [ |4P+Q|/8 + max((|P|+|R|)/2, |S|/4) ].
```

*Proof.* Set `E=A-4B`. The unit-budget constraints are `|B|<=k/8`, `|C|+2|D|<=k/2`, and `|E|+2|D|<=k/2`. Fixing `d=|D| in [0,k/4]`, the sharp supremum is

```text
k|4P+Q|/8 + (k/2-2d)(|P|+|R|) + d|S|.
```

This expression is affine in `d`, and its maximum lies at `d=0` or `d=k/4`, proving the formula. Choosing the signs of `E,C,B,D` to match their dual loads gives equality, so the polar is sharp.

### Compact-PDE necessary condition

Let `f = g - P div(rho R*)` be the source in (273) and let `phi` be smooth divergence-free. Define

```text
P = ∂₃ phi₁ + ∂₁ phi₃
Q = ∂₃ phi₂ + ∂₂ phi₃
R = ∂₂ phi₁ + ∂₁ phi₂
S = ∂₃ phi₃ - ∂₁ phi₁.
```

If a compact correction exists satisfying `N(H)<=kappa*rho` pointwise, with `kappa=15971/122900`, then integration by parts forces

```text
|∫ f·phi| <= kappa ∫ rho *
   [ |4P+Q|/8 + max((|P|+|R|)/2, |S|/4) ].
```

This is a **necessary condition**, not an existence theorem. A single smooth divergence-free test field violating it would refute H8 for the chosen source/profile. Evaluating it requires a completely specified source `g` and weight `rho`, which the manuscript does not yet supply.

The [exact Fraction checker](verify_dual.py) verifies the reduction on 1296 rational stress tuples and independently constructs 625 exact rational saturating dual optimizers. The source's finite-dimensional theorem has not yet been Lean-formalized; the principal-symbol SOS from Attack 002 is a separate Lean target.

This provides a concrete next route: freeze one source-native normalized profile, compute its moment-corrected `f` and `rho`, and search divergence-free dual test fields before attempting a positive compact inversion.
