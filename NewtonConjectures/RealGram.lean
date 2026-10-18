import Mathlib
import NewtonConjectures.SpectralPSD

/-!
# Case 001 — real Gram-positivity bridge

Constructs the cyclic Gram decomposition over the REAL scalar field.
The rational shifted-matrix identity is already kernel-certified in
FullGram.lean. We first certify PSD directly over ℝ, preserving the
actual piecewise coefficients. The matrix-cast/eigenvalue relation is
a subsequent proof obligation.
-/

namespace Newton400.Case001

noncomputable def realCyclicIncidence (n j : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  (cyclicIncidence n j).map (fun q : ℚ => (q : ℝ))

noncomputable def realWeightedCycleGram (n : ℕ) [NeZero n] :
    Matrix (ZMod n) (ZMod n) ℝ :=
  ( ((fun _ _ : ZMod n => (1 : ℝ) / ((n / 2 : ℕ) : ℝ)) :
      Matrix (ZMod n) (ZMod n) ℝ) +
    ∑ j ∈ Finset.Ico 2 (n / 2 + 1),
      ((cyclicGramWeight (n / 2) j : ℚ) : ℝ) •
        (realCyclicIncidence n j * Matrix.transpose (realCyclicIncidence n j)) )

theorem real_cyclic_weight_nonneg (m j : ℕ)
    (hm : 2 ≤ m) (hjlo : 2 ≤ j) (hjhi : j ≤ m) :
    (0 : ℝ) ≤ (cyclicGramWeight m j : ℝ) := by
  exact_mod_cast (cyclic_gram_weight_nonneg m j hm hjlo hjhi)

theorem real_constant_cycle_psd (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    Matrix.PosSemidef
      ((fun _ _ : ZMod n => (1 : ℝ) / ((n / 2 : ℕ) : ℝ)) :
        Matrix (ZMod n) (ZMod n) ℝ) := by
  classical
  let ones : ZMod n → ℝ := fun _ => 1
  have hbase : (Matrix.vecMulVec ones (star ones)).PosSemidef :=
    Matrix.posSemidef_vecMulVec_self_star ones
  have hc : (0 : ℝ) ≤ 1 / ((n / 2 : ℕ) : ℝ) := by positivity
  have h := hbase.smul hc
  have heq :
      ((fun _ _ : ZMod n => (1 : ℝ) / ((n / 2 : ℕ) : ℝ)) :
        Matrix (ZMod n) (ZMod n) ℝ) =
      (1 / ((n / 2 : ℕ) : ℝ)) • Matrix.vecMulVec ones (star ones) := by
    ext u v
    simp [ones, Matrix.vecMulVec, Matrix.smul_apply, smul_eq_mul]
  rw [heq]
  exact h

theorem real_cyclic_incidence_psd (n j : ℕ) [NeZero n] :
    (realCyclicIncidence n j * Matrix.transpose (realCyclicIncidence n j)).PosSemidef := by
  classical
  have h := Matrix.posSemidef_self_mul_conjTranspose (realCyclicIncidence n j)
  convert h using 1

theorem real_weighted_cycle_gram_psd (n : ℕ) [NeZero n] (hn : 4 ≤ n) :
    (realWeightedCycleGram n).PosSemidef := by
  classical
  have hm : 2 ≤ n / 2 := by omega
  let term : ℕ → Matrix (ZMod n) (ZMod n) ℝ := fun j =>
    ((cyclicGramWeight (n / 2) j : ℚ) : ℝ) •
      (realCyclicIncidence n j * Matrix.transpose (realCyclicIncidence n j))
  have hterm (j : ℕ) (hj : j ∈ Finset.Ico 2 (n / 2 + 1)) :
      (term j).PosSemidef := by
    have hlo : 2 ≤ j := (Finset.mem_Ico.mp hj).1
    have hhi : j ≤ n / 2 := by
      have h := (Finset.mem_Ico.mp hj).2
      omega
    exact (real_cyclic_incidence_psd n j).smul
      (real_cyclic_weight_nonneg (n / 2) j hm hlo hhi)
  have hsum_aux :
      ∀ s : Finset ℕ, s ⊆ Finset.Ico 2 (n / 2 + 1) →
      (∑ j ∈ s, term j).PosSemidef := by
    intro s
    induction s using Finset.induction_on with
    | empty =>
        intro _
        simpa using (Matrix.PosSemidef.zero :
          (0 : Matrix (ZMod n) (ZMod n) ℝ).PosSemidef)
    | @insert j s hj ih =>
        intro hs
        rw [Finset.sum_insert hj]
        have hjrange : j ∈ Finset.Ico 2 (n / 2 + 1) := hs (by simp)
        have hsrange : s ⊆ Finset.Ico 2 (n / 2 + 1) := by
          intro k hk
          exact hs (by simp [hk])
        exact (hterm j hjrange).add (ih hsrange)
  have hsum := hsum_aux _ (Finset.Subset.rfl)
  have hconst := real_constant_cycle_psd n hn
  have htotal := hconst.add hsum
  convert htotal using 1
  ext u v
  simp only [realWeightedCycleGram, Matrix.add_apply, Matrix.sum_apply,
    Matrix.smul_apply, smul_eq_mul]

end Newton400.Case001
