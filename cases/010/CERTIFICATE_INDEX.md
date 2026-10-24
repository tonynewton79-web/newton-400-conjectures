# Case 010 — exact spectral certificate reproducibility index

The accompanying revised manuscript **Degree-weighted spectral extremizers: counterexamples and complete product-weight classification** includes a full certificate subsection with exact formulas and a proof-dependency diagram.

The complete certificate data and independent replay programs are provided as a separate downloadable archive in the research conversation, **not currently checked into this GitHub repository**. To avoid broken links or unreviewed binaries, this branch records the file digests and theorem obligations without pretending the archive is hosted here.

## Exact release contents and expected checks

| Gate | Expected |
|---|---:|
| Diamond shifted polynomial regions | 25 |
| K_(2,3) two-variable sectors | 2 |
| All serialized positive coefficients | 121252 |
| Finite diamond remainder tuples | 20203 |
| Finite core spectral comparisons n <= 40 | 759273 |
| Rational threshold records | 72 |
| Selected Collatz–Wielandt integer witnesses | 10 |

Raw certificate SHA-256:

```
d78a59b753416e18611c20eb7a54460eb2f0a7649659e73c88206417d25ab9ba  Certificate_Data/coefficient_terms.jsonl.gz
6bab90634aa683fabb89a44bd446df0feb5cbc5bdbe60e9d18a1e77ac9c6dfcb  Certificate_Data/diamond_remainders.jsonl.gz
117ec47642693d416b751c228b4fc96785088b72f48e8122359a154890ec87d3  Certificate_Data/finite_spectral_commitments.json
044b123b1b43a352e39b8bb5e26f7246308674076cf88a5f2a62827d9ed23ff7  Certificate_Data/polynomial_index.json
```

The coefficient archive encodes each exponent vector and exact integer coefficient. One of the 25 diamond polynomials has 4842 nonzero terms; the other 24 have 4843. Both K_(2,3) sector polynomials have 89 terms.

## How to replay after obtaining the certificate archive

```bash
python verify_raw_archive.py
python verify_selected_witnesses.py
python independent_cycle_audit.py --polynomials
python reproducible_certificate_export.py --stage all --out-dir Certificate_Data
sha256sum -c SHA256SUMS.txt
```

No floating-point pass/fail decisions are involved. The full finite replay recomputes all 759273 integer Sylvester/Bareiss comparisons. The rational separator values are inputs, checked against every reduced graph, and the graph-structural reductions are imported from cited published results.

## Lean status

The standalone Python replay **is not a Lean proof**. The Lean file currently proposes foundational coefficient-positivity, 2x2 Sylvester, and selected exact integer witness theorems; the full 25 polynomial identities, 20203 remainders, 759273 matrix comparisons and final graph classification remain outside formal Lean coverage. GitHub Actions must pass before any new fragment is described as kernel-verified.

See [the Case 010 source](../../NewtonConjectures/Case010Spectral.lean) and [draft PR #28](https://github.com/tonynewton79-web/newton-400-conjectures/pull/28).
