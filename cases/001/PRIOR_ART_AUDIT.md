# Case 001 — independent prior-art and originality audit (provisional)

Date: 2026-10-18. Scope: the proposed sharp classification of Graffiti 197 for cycles, including the positive-semidefinite cyclic interval Gram decomposition.

## Primary source and priority

Milo Roucairol and Tristan Cazenave, *Refutation of Spectral Graph Theory Conjectures with Search Algorithms*, IASE 2025, arXiv:2409.18626; primary PDF:
https://www.lamsade.dauphine.fr/~cazenave/papers/ConjectureRefutationECAI2025.pdf

Section 5.1 explicitly reports C_17 as a Graffiti 197 counterexample, also identifies C_21 and C_25, and conjectures all cycles C_(4r+1), r ≥ 4. The paper **already refutes the original Graffiti 197 statement**; no first-refutation credit belongs to Case 001.

Section 5.2 explicitly warns that Aouchiche–Hansen's other use of "range" refers to the number of distinct values. Our paper consistently uses the *numerical spectral span* λ_max−λ_min, as in Roucairol–Cazenave's C_17 refutation, and the historically specified gravity matrix with off-diagonal degree-product divided by (n−1) times graph distance.

## Related published/scholarly literature examined

- G.-X. Tian, M.-J. Cheng and S.-Y. Cui, *The generalized reciprocal distance matrix of graphs*, arXiv:2204.03787 (2022). Studies Harary/reciprocal distance spectra and graph families; background for our R_n matrix.
- H. Liu and Y. Huang, *The spread of generalized reciprocal distance matrix*, arXiv:2207.05181 (2022). The spectral-spread problem is independently studied. This must be distinguished from novelty of the specific sharp Graffiti 197 cycle threshold.
- S. Fajtlowicz, *On conjectures of Graffiti*, Annals of Discrete Mathematics 38 (1988), 113–118; Graffiti programme and history.
- M. Aouchiche and P. Hansen, *A survey of automated conjectures in spectral graph theory*, Linear Algebra Appl. 432 (2010), 2293–2322. Background, with explicit caution about the "range" convention.

## Search outcome, not a novelty certificate

Targeted queries of the form "Graffiti 197" cycles, C15, Roucairol–Cazenave family proof, reciprocal distance cycles least eigenvalue bound −3/2, and shifted Harary cyclic Gram decomposition recovered the primary C17/C21/C25 source and general related spectral literature but did not yield a source demonstrating this exact **all n ≥15 iff threshold** or the exact shifted Gram decomposition. Search-engine nonretrieval does not establish novelty, and unindexed theses, unpublished papers, and recent independent projects may contain collisions.

## Delimited candidate contribution

1. Prove C_n violates the *numerical-span* Graffiti 197 inequality precisely when n ≥15; earlier authors already refuted the base conjecture.
2. Exhibit the explicit identity R_n+(3/2)I=(1/m)J+Σw_jB_jB_jᵀ and use its PSD implication.
3. Provide exact rational finite certificates for C3..C14.
4. Provide actual Lean 4/mathlib kernel checks, with separate statements for each certified proof layer.

The cyclic-adjacency spectrum itself, elementary harmonic estimates, and generic Gram-matrix PSD facts are prior mathematical knowledge. Do not claim these known techniques as inventions. The specific combination, sharp threshold and complete generalization are the contributions **under assessment**, not established first-publication discoveries.

## Outstanding external judgment

- Independent full mathematical review of the analytic proof and the exact finite converse.
- Comparison with other recent unindexed publications and proof archives.
- Priority discussion with Roucairol and Cazenave and specialists in spectral graph theory.
- Journal/arXiv review and authorship/citation checks.

**Current external status: NO_SPECIALIST_REVIEW_YET; NO_PRIORITY_CERTIFICATE; NO_EXTERNALLY_ACCEPTED_NEW_THEOREM.**

Do not count Case 001 as an externally accepted original resolution in the 401-result target.
