# Actual adjacency model — kernel audit

- Run: https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39146480928
- `Built NewtonConjectures.AdjacencyDefinition`.
- `Build completed successfully (7366 jobs)`.
- `axiom-audit: audited 204 declaration(s) under 'NewtonConjectures'; all within the allowlist [propext, Classical.choice, Quot.sound]`.
- Source: `NewtonConjectures/AdjacencyDefinition.lean`.

**Passed**: actual n-cycle adjacency-matrix definition over `ZMod n`; symmetry via transpose and entries; entrywise nonnegativity.

**Not proven**: its ordered second-smallest eigenvalue, multiplicity, eigenvalue relation with the cosine candidate, finite complement C3..C14, or full final Graffiti inequality.
