# Case 007: Lean formalization status

The complete Sombor-product extremal-tree theorem is **NOT Lean-certified**.

The first Lean source formalizes elementary scalar identities for the three edge types, an algebraic two-edge dispersion identity, and exact rational inequalities used in the paper. No assumption that every tree is an eclipsed sun is introduced.

Formalization milestones:
1. [ ] GitHub Actions has compiled the initial Case007Sombor.lean source without placeholders.
2. [ ] Encode finite simple tree, endpoint degree, Sombor weight and inverse weight.
3. [ ] Construct eclipsed sun and prove edge-type partition in the actual graph.
4. [ ] Formalize degree potential and all analytic inequalities.
5. [ ] Formalize strict defect comparison and equality case.
6. [ ] Verify bounded finite rational certificates using Lean reflection or generated proofs.
7. [ ] Prove and compile the unrestricted n>=5 extremal theorem in the Lean kernel.

Run: lake exe cache get; lake build NewtonConjectures.Case007Sombor; lake build.

The manuscript's computational assertions must be independently reproducible and never described as complete kernel proof.
