# Case 001 cumulative manuscript release protocol

The PDF at `cases/001/paper/main.pdf` is the **single living research paper**, not a static first-stage note. Every newly **accepted** experiment, exact certificate, mathematical lemma, Lean theorem, or correction must result in a new PDF build.

## Mandatory release sequence

1. Run the experiment and retain source/test commands and outputs.
2. Classify each claim: exact finite test, informal mathematical argument, Lean kernel-verified component, full theorem proof, novelty audit, or external review. Do not conflate them.
3. For Lean: require a green pinned-toolchain `lake build`, the axiom audit, and the proof-placeholder scan; record the successful run URL.
4. Append a precise proof/result to `cases/001/paper/formal_progress.tex` (or the appropriate main-paper section), including quantifiers, hypotheses, version, reproducibility and remaining gaps. Update `cases/001/LEAN_STATUS.md` and `REGISTRY.json`.
5. Trigger the GitHub publication build; require successful two-pass LaTeX compilation and updated `cases/001/paper/main.pdf` and `cases/001/certificates/verification.json` committed to `main`.
6. Verify the current PDF was produced from the latest paper source and report the exact verified file/commit. If the build fails, do not call the PDF updated.
7. Never append passing results to only a side note: the living full paper is canonical. Retain prior valid results and corrections, and record changes in the cumulative ledger.
8. Keep Case 001 below full Lean theorem certification until the all-entry matrix, cycle-specific spectral inequality, and finite converse actually compile; external novelty/specialist approval remain separate.

**User requirement:** Every subsequent accepted Case 001 test must update the same paper and regenerate the PDF, not only publish an isolated note or code change.
