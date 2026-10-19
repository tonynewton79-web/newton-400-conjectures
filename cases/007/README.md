# Case 007 — Sombor product on trees

**Target:** Conjectures 12 and 13 of I. Gutman, I. Redžepović and B. Furtula, *On the product of Sombor and modified Sombor indices*, Open Journal of Discrete Applied Mathematics 6(2) (2023), 1–6. DOI: https://doi.org/10.30538/psrp-odam2023.0083.

**Source:** Tony Newton, *The maximum product of the Sombor and modified Sombor indices of a tree*, revised manuscript (19 October 2026).

For an n-vertex tree T, define the Sombor edge weight w(uv)=sqrt(deg(u)^2+deg(v)^2). The target sharp statement is that (sum w)(sum 1/w) is uniquely maximized by the eclipsed sun ES(n,k), k=floor((n-2)/3), for every n>=5.

## Mathematical content

The candidate manuscript contains:
1. A universal degree-potential bound U(n,d), excluding d<=n/2 for n>=17;
2. A direct two-factor defect comparison for d>n/2, reducing all maximizers to eclipsed suns;
3. Strict finite differences determining k=floor((n-2)/3);
4. Exact rational interval checks for 2,220 degree pairs and 18 residual increments;
5. Independent exact interval comparison on the 32,503 nonisomorphic free trees of orders 5 through 16.

The accompanying professionally revised PDF and full LaTeX source were produced in this work session. This case directory initially records the formal program; **the full proof has not been compiled or proved in Lean**. The analytic paper is a proposed resolution pending line-by-line external review and novelty confirmation.

## Verification targets

- Lean: elementary sum/reciprocal and three-edge-type algebra;
- Lean: definition of tree, degrees, edge weights and eclipsed-sun constructor;
- Lean: potential bound U(n,d) and d<=n/2 exclusion;
- Lean: dominant-vertex nonroot-edge defect, strict product comparison and equality;
- Lean: arm-count integer finite differences and final extremal theorem;
- Separately: exact rational interval checks and exhaustive unlabeled-tree enumeration.

**Caution:** numerical, rational and C++/Python certificates are different from Lean kernel verification. A successful simple algebra check is not evidence the full graph extremal theorem has been formalized.

[Original 2023 paper](https://pisrt.org/psrpress/j/odam/2023/2/On-the-product-of-Sombor-and-modified-Sombor-indices.pdf) · [Lean source](../../NewtonConjectures/Case007Sombor.lean) · [Lean status](LEAN_STATUS.md) · [case-specific CI](../../.github/workflows/case007.yml).
