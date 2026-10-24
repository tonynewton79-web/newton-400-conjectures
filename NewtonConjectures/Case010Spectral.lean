import Mathlib

/-!
# Case 010: degree-product spectral certificates

This module formalizes foundational implications used by the external exact
certificate audit: coefficientwise-positive sparse polynomials, the 2x2
Sylvester quadratic-form criterion, and actual small-order integer
Collatz--Wielandt witnesses. The ten-witness Python replay and the
25 four-variable coefficient expansions are NOT yet certified by this module.

No result here asserts the global bicyclic extremal theorem.
-/

namespace Newton400.Case010

/-- A sparse monomial in nonnegative rational variables. -/
def monomial {m : ℕ} (exponent : Fin m → ℕ) (x : Fin m → ℚ) : ℚ :=
  ∏ i : Fin m, x i ^ exponent i

theorem monomial_nonneg {m : ℕ} (e : Fin m → ℕ)
    (x : Fin m → ℚ) (hx : ∀ i, 0 ≤ x i) :
    0 ≤ monomial e x := by
  unfold monomial
  apply Finset.prod_nonneg
  intro i _
  exact pow_nonneg (hx i) _

/-- Nonnegative coefficients certify a sparse polynomial on the nonnegative orthant. -/
theorem sparse_polynomial_nonneg {m : ℕ}
    (support : Finset (Fin m → ℕ))
    (coefficient : (Fin m → ℕ) → ℚ)
    (x : Fin m → ℚ)
    (hc : ∀ e ∈ support, 0 ≤ coefficient e)
    (hx : ∀ i, 0 ≤ x i) :
    0 ≤ ∑ e ∈ support, coefficient e * monomial e x := by
  apply Finset.sum_nonneg
  intro e he
  exact mul_nonneg (hc e he) (monomial_nonneg e x hx)

/-- Strict principal minors imply nonnegative quadratic form in dimension two.
    This is the 2x2 case of the Sylvester certificate used in the audit. -/
theorem two_by_two_sylvester (a b c x y : ℚ)
    (ha : 0 < a) (hdet : 0 < a * c - b * b) :
    0 ≤ a * x ^ 2 + 2 * b * x * y + c * y ^ 2 := by
  let q : ℚ := a * x ^ 2 + 2 * b * x * y + c * y ^ 2
  have hid : a * q = (a * x + b * y) ^ 2 +
      (a * c - b * b) * y ^ 2 := by
    dsimp [q]
    ring
  have hnonneg : 0 ≤ a * q := by
    rw [hid]
    exact add_nonneg (sq_nonneg _) (mul_nonneg (le_of_lt hdet) (sq_nonneg _))
  by_contra hq
  have hqneg : q < 0 := lt_of_not_ge hq
  have hprodneg : a * q < 0 := mul_neg_of_pos_of_neg ha hqneg
  exact (not_lt_of_ge hnonneg) hprodneg

/-- One exact champion witness at order 6: triangle with one leaf per vertex.
    The 6x6 matrix is the INTEGER quotient matrix, not a symmetric quotient. -/
private def unicyclic6WinnerMatrix : Matrix (Fin 6) (Fin 6) ℤ :=
  !![(0 : ℤ), 9, 9, 3, 0, 0;
     9, 0, 9, 0, 3, 0;
     9, 9, 0, 0, 0, 3;
     3, 0, 0, 0, 0, 0;
     0, 3, 0, 0, 0, 0;
     0, 0, 3, 0, 0, 0]

private def unicyclic6WinnerVector : Fin 6 → ℤ :=
  ![1193713, 1193713, 1193713, 193713, 193713, 193713]

private def unicyclic6WinnerImage : Fin 6 → ℤ :=
  ![22067973, 22067973, 22067973, 3581139, 3581139, 3581139]

/-- Actual exact integer matrix-vector multiplication and a strict LOWER
    Collatz--Wielandt separator (zero floating-point dependence). -/
theorem unicyclic6_winner_witness :
    (∀ i : Fin 6, 0 < unicyclic6WinnerVector i) ∧
    (∀ i : Fin 6,
        (∑ j : Fin 6, unicyclic6WinnerMatrix i j * unicyclic6WinnerVector j) =
          unicyclic6WinnerImage i) ∧
    (∀ i : Fin 6,
        18482460076 * unicyclic6WinnerVector i <
          1000000000 * unicyclic6WinnerImage i) := by
  constructor
  · decide
  constructor
  · decide
  · decide

/-- Outsider order-6 triangle with leaf allocation (0,1,2). -/
private def unicyclic6OutsiderMatrix : Matrix (Fin 5) (Fin 5) ℤ :=
  !![(0 : ℤ), 6, 8, 0, 0;
     6, 0, 12, 3, 0;
     8, 12, 0, 0, 8;
     0, 3, 0, 0, 0;
     0, 0, 4, 0, 0]

private def unicyclic6OutsiderVector : Fin 5 → ℤ :=
  ![927780831360853925835585900613043270321,
    1158961079636582979984437741366293270321,
    1273703089110278441606289582119543270321,
    188349614109730213855783008000793270321,
    275888237803677308870833270965543270321]

private def unicyclic6OutsiderImage : Fin 5 → ℤ :=
  ![17143391190701725412756943105154105784494,
    21416170899817655495856339413115158676741,
    23536885508955245637464606269024211568988,
    3476883238909748939953313224098879810963,
    5094812356441113766425158328478173081284]

/-- Exact strict UPPER spectral separator for a nonwinning configuration. -/
theorem unicyclic6_outsider_witness :
    (∀ i : Fin 5, 0 < unicyclic6OutsiderVector i) ∧
    (∀ i : Fin 5,
       (∑ j : Fin 5, unicyclic6OutsiderMatrix i j * unicyclic6OutsiderVector j) =
         unicyclic6OutsiderImage i) ∧
    (∀ i : Fin 5,
       1000000000 * unicyclic6OutsiderImage i <
         18482460076 * unicyclic6OutsiderVector i) := by
  constructor
  · decide
  constructor
  · decide
  · decide

/-- Order 20 diamond winner: eight pendant leaves at each degree-three hub. -/
private def bicyclic20WinnerMatrix : Matrix (Fin 6) (Fin 6) ℤ :=
  !![(0 : ℤ), 121, 22, 22, 88, 0;
     121, 0, 22, 22, 0, 88;
     22, 22, 0, 0, 0, 0;
     22, 22, 0, 0, 0, 0;
     11, 0, 0, 0, 0, 0;
     0, 11, 0, 0, 0, 0]

private def bicyclic20WinnerVector : Fin 6 → ℤ :=
  ![38708575717443721, 38708575717443721,
    12034882968443721, 12034882968443721,
    3008720955443721, 3008720955443721]

private def bicyclic20WinnerImage : Fin 6 → ℤ :=
  ![5478039956501261413, 5478039956501261413,
    1703177331567523724, 1703177331567523724,
    425794332891880931, 425794332891880931]

theorem bicyclic20_winner_witness :
    (∀ i : Fin 6, 0 < bicyclic20WinnerVector i) ∧
    (∀ i : Fin 6,
       (∑ j : Fin 6, bicyclic20WinnerMatrix i j * bicyclic20WinnerVector j) =
         bicyclic20WinnerImage i) ∧
    (∀ i : Fin 6,
       141196050630 * bicyclic20WinnerVector i <
         1000000000 * bicyclic20WinnerImage i) := by
  constructor
  · decide
  constructor
  · decide
  · decide


/-- The exact rank-one diamond envelope factor, without rational division. -/
def diamondEnvelopeFactor (T a d : ℤ) : ℤ :=
  T * T + 4 * (T - 4 * a) * d ^ 2

/-- A cross-multiplied four-vertex diamond separator numerator.
    Positivity is the arithmetic condition used by the external audit. -/
def diamondEnvelopeNumerator (T : ℤ) (a coreDegree : Fin 4 → ℤ) : ℤ :=
  let E : Fin 4 → ℤ :=
    fun i => diamondEnvelopeFactor T (a i) (a i + coreDegree i)
  (∏ i : Fin 4, E i) -
    4 * T * (∑ i : Fin 4,
      (a i + coreDegree i) ^ 2 *
        (∏ j ∈ (Finset.univ.erase i), E j))

/-- Genuine 4-core-vertex integer separator: n=41 diamond, pendant
    allocation (18,18,1,0). This checks the DEFINE-and-evaluate step,
    not the entire all-n coefficient-expansion identity. -/
theorem diamond_n41_one_stray_positive :
    0 < diamondEnvelopeNumerator 1946
       ![(18 : ℤ), 18, 1, 0] ![(3 : ℤ), 3, 2, 2] := by
  decide

end Newton400.Case010
