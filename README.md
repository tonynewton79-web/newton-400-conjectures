# Newton Astro Labs — 400+ Conjectures

An open, reproducible mathematical research programme targeting **401 independently validated original conjecture resolutions or substantive theorem advances**.

**A repository entry is not an accepted proof.** We distinguish experiments, candidate proofs, reproducible certificates, independently audited results, and externally accepted publications. Only externally reviewed or appropriately independently verified original claims count toward the 401-result target.

## Cases

| Case | Research target | Status |
|---|---|---|
| [001](cases/001/README.md) | Roucairol–Cazenave cycle conjecture associated with Graffiti 197 | Candidate infinite-family strengthening; independent priority review pending |

The original Graffiti 197 assertion was already refuted by Milo Roucairol and Tristan Cazenave. Case 001 does **not** claim the first refutation. It investigates a stronger all-cycles classification.

## Scientific release protocol

DISCOVER → ATTACK → TRY TO DESTROY → CLEAN-ROOM REBUILD → EXACTLY CERTIFY → PRIOR-ART AUDIT → EXTERNAL REVIEW → RELEASE or HOLD.

Each case has a source statement, mathematical proof, exact reproducibility code, adversarial tests, certificates, a bibliographic audit, and a status/limitations record. Lean claims require **actual kernel compilation**; computer tests alone never establish infinite-domain theorems.

## Leadership

Tony Newton — Newton Astro Labs, independent computational research, UK.

See [CLAIM_POLICY.md](CLAIM_POLICY.md), [REGISTRY.json](REGISTRY.json), and the individual case directories.

## Case 001 — full research release

- [Read or download the compiled three-page PDF](cases/001/paper/main.pdf)
- [Inspect the complete LaTeX manuscript](cases/001/paper/main.tex)
- [Run the exact rational verifier](cases/001/verify.py)
- [Inspect the nine unit tests](cases/001/tests/test_case001.py)
- [Inspect the generated verification certificate](cases/001/certificates/verification.json)
- [View the independent-review checklist](https://github.com/tonynewton79-web/newton-400-conjectures/issues/1)
- [Review GitHub Actions test and PDF build results](https://github.com/tonynewton79-web/newton-400-conjectures/actions)

**Review state:** Candidate mathematical strengthening only. Machine test success is documented separately from expert acceptance and originality.

### Verified formal-proof infrastructure

**Real Lean 4/mathlib kernel compilation: PASS for a proof-critical fragment (not the full theorem).** The [Lean source](NewtonConjectures.lean), [resolved dependency lockfile](lake-manifest.json), [formal status ledger](cases/001/LEAN_STATUS.md), and [independent axiom audit report](cases/001/certificates/LEAN_AUDIT.md) are version-controlled. GitHub Actions [completed kernel check and audit](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39125495963).

The full graph-theoretic cycle theorem has **not** been formalized. Do not count Case 001 as a fully Lean-certified theorem or an externally accepted original mathematical result.

**Latest cumulative paper release — Stages 1–5 (18 October 2026):** [Read or download the updated three-page PDF](cases/001/paper/main.pdf). The proof-source, exact tests and Lean status have been integrated into the same living paper. [PDF build passed](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39132470911); [Stage 5 Lean kernel and 100-declaration audit passed](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39131413230). See the [mandatory paper-update protocol](cases/001/PUBLICATION_POLICY.md). Full graph theorem Lean certification and originality audit remain pending.


### Latest Case 001 proof release — Stage 8 (18 October 2026)

- **[Living full research paper — PDF](cases/001/paper/main.pdf)**: four-page revised manuscript containing Stages 1–8, all formally checked identities, exact arithmetic and claim boundaries.
- **[Stage 8 real spectral Lean source](NewtonConjectures/RealSpectral.lean)** and [real Gram PSD source](NewtonConjectures/RealGram.lean).
- **[Lean Stage 8 audit](cases/001/certificates/LEAN_STAGE8_AUDIT.md)**: successful [GitHub Actions kernel and 142-declaration axiom audit](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39139083900).
- **[Updated PDF build](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39139406455)**: four pages, generated and committed to `main`.
- **[Remaining full-theorem Lean gates](https://github.com/tonynewton79-web/newton-400-conjectures/issues/12)** and **[external specialist/priority review](https://github.com/tonynewton79-web/newton-400-conjectures/issues/10)**.

**Scientific count:** exact real shifted reciprocal-distance spectrum positivity is now kernel-verified for all n≥4. The *full* sharp Graffiti 197 cycle theorem is not yet formalized end to end in Lean, nor externally accepted as original. The original Graffiti 197 was already refuted by Roucairol and Cazenave.


### Case 002 — 2026 three-connected graph cycle counts

**[Paper 002: Wheel–Chord Constructions and Cycle Counts (PDF)](cases/002/paper/main.pdf)** · [full LaTeX source](cases/002/paper/main.tex) · [exact independent verifier](cases/002/verify.py) · [certificate](cases/002/certificates/construction.json) · [research status](cases/002/STATUS.md) · [research issue](https://github.com/tonynewton79-web/newton-400-conjectures/issues/14).

The working paper proves the elementary construction formula
`c(W(m;k)) = (3m² - 5m + 8 + 2k(m−k))/2`
for a wheel with one added rim chord; 406 exact finite graph checks and 406 two-vertex-deletion connectivity checks pass. [Independent GitHub publication build](https://github.com/tonynewton79-web/newton-400-conjectures/actions/runs/39143932131) succeeded and archived the two-page paper. This is **not** a resolution of the original 2026 McCulloch–McKay–Salahshoori–Zaslavsky conjecture, nor is novelty of the elementary formula asserted.

**Case 001 remains a separate candidate theorem**: [living PDF](cases/001/paper/main.pdf) and [remaining Lean formalization gates](https://github.com/tonynewton79-web/newton-400-conjectures/issues/12). The project registry continues to count **zero externally accepted original conjecture resolutions**.
