import Mathlib
import NewtonConjectures.TwoModeAdjacency

/-!
# Stage 17 continuation candidate: spectral multiplicity and the actual matrix

The proof uses a common eigenvalue for two independent real vectors.
No full Fourier spectrum or numerical ordering is needed.
-/
namespace Newton400.Case001

theorem penultimate_of_independent_modes
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] {N : ℕ}
    (T : E →ₗ[ℝ] E) (hT : T.IsSymmetric)
    (hn : Module.finrank ℝ E = N) (hN : 2 ≤ N)
    (t : ℝ) (x y : E) (hx : T x = t • x) (hy : T y = t • y)
    (hind : ∀ a b : ℝ, a • x + b • y = 0 → a = 0 ∧ b = 0) :
    hT.eigenvalues hn ⟨N-2, by omega⟩ ≤ t := by
  classical
  let p : Fin N := ⟨N-2, by omega⟩
  let l : Fin N := ⟨N-1, by omega⟩
  let B := hT.eigenvectorBasis hn
  change hT.eigenvalues hn p ≤ t
  by_contra! h
  have hc (w : E) (hw : T w = t • w) (i : Fin N) (hi : i ≠ l) :
      B.repr w i = 0 := by
    have hil : i.val ≠ N-1 := by
      intro he
      apply hi
      exact Fin.ext he
    have hip : i ≤ p := by
      change i.val ≤ N-2
      have := i.isLt
      omega
    have hbig := h.trans_le (hT.eigenvalues_antitone hn hip)
    have he := hT.eigenvectorBasis_apply_self_apply hn w i
    rw [hw, map_smul] at he
    change t * B.repr w i = hT.eigenvalues hn i * B.repr w i at he
    have hz : (hT.eigenvalues hn i - t) * B.repr w i = 0 := by
      rw [sub_mul, ← he, sub_self]
    exact (mul_eq_zero.mp hz).resolve_left (sub_ne_zero.mpr (ne_of_gt hbig))
  let a : ℝ := B.repr y l
  let b : ℝ := -(B.repr x l)
  have hz : a • x + b • y = 0 := by
    apply B.repr.injective
    rw [map_add, map_smul, map_smul, map_zero]
    ext i
    change a * B.repr x i + b * B.repr y i = 0
    by_cases hi : i = l
    · subst i
      dsimp [a, b]
      ring
    · rw [hc x hx i hi, hc y hy i hi]
      ring
  have hb := (hind a b hz).2
  have hxl : B.repr x l = 0 := neg_eq_zero.mp hb
  have hx0 : x = 0 := by
    apply B.repr.injective
    rw [map_zero]
    ext i
    change B.repr x i = 0
    by_cases hi : i = l
    · simpa [hi] using hxl
    · exact hc x hx i hi
  have hbad := (hind 1 0 (by simp [hx0])).1
  norm_num at hbad

theorem cycle_adjacency_neighbor_action
    (n : ℕ) [NeZero n] (hn : 3 ≤ n)
    (f : ZMod n → ℝ) (u : ZMod n) :
    ((cycleAdjacencyMatrix n) *ᵥ f) u = f (u+1) + f (u-1) := by
  classical
  have h2 : (2 : ZMod n) ≠ 0 := by
    intro h
    have hv := congrArg ZMod.val h
    have hval : (2 : ZMod n).val = 2 := by
      change ((2 : ℕ) : ZMod n).val = 2
      simp [ZMod.val_natCast, Nat.mod_eq_of_lt (show 2 < n by omega)]
    rw [hval] at hv
    simp at hv
  have hsep : u+1 ≠ u-1 := by
    intro h
    apply h2
    calc
      (2 : ZMod n) = (u+1)-(u-1) := by ring
      _ = 0 := sub_eq_zero.mpr h
  have hm (j : ZMod n) :
      cycleAdjacencyMatrix n u j =
      (if j = u+1 then (1 : ℝ) else 0) + (if j = u-1 then 1 else 0) := by
    have hh : u = j+1 ↔ j = u-1 := by
      constructor <;> intro h
      · calc j = (j+1)-1 := by ring
             _ = u-1 := by rw [← h]
      · calc u = (u-1)+1 := by ring
             _ = j+1 := by rw [← h]
    unfold cycleAdjacencyMatrix
    rw [hh]
    by_cases ha : j = u+1
    · have hb : j ≠ u-1 := fun h => hsep (ha.symm.trans h)
      simp [ha, hb]
    · by_cases hb : j = u-1 <;> simp [ha, hb]
  simp [Matrix.mulVec, dotProduct, hm, add_mul, Finset.sum_add_distrib]

theorem cycle_char_int_exp (n : ℕ) [NeZero n] (k : ℤ) :
    ZMod.stdAddChar (k : ZMod n) =
    Complex.exp (((2 * Real.pi * (k : ℝ) / (n : ℝ) : ℝ) : ℂ) * Complex.I) := by
  rw [ZMod.stdAddChar_coe]
  congr 1
  push_cast
  ring

theorem actual_second_le_fourier
    (n k : ℕ) [NeZero n] (hn : 3 ≤ n)
    (hk : 0 < k) (hk2 : 2*k < n) :
    actualSecondSmallestAdjacency n hn ≤
      2 * Real.cos (2 * Real.pi * (k : ℝ) / (n : ℝ)) := by
  classical
  let θ : ℝ := 2 * Real.pi * (k : ℝ) / (n : ℝ)
  let z : ZMod n := k
  let t : ℝ := 2 * Real.cos θ
  have hθpos : 0 < θ := by dsimp [θ]; positivity
  have hnR : (0 : ℝ) < (n : ℝ) := by positivity
  have hkR : (2 : ℝ)*(k : ℝ) < (n : ℝ) := by exact_mod_cast hk2
  have hθlt : θ < Real.pi := by
    dsimp [θ]
    apply (div_lt_iff₀ hnR).2
    nlinarith [mul_lt_mul_of_pos_left hkR Real.pi_pos]
  have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθpos hθlt
  have hplus : ZMod.stdAddChar z = Complex.exp ((θ : ℂ) * Complex.I) := by
    simpa [z, θ] using cycle_char_int_exp n (k : ℤ)
  have hminus : ZMod.stdAddChar (-z) = Complex.exp (((-θ : ℝ) : ℂ)*Complex.I) := by
    have h := cycle_char_int_exp n (-(k : ℤ))
    convert h using 2 <;> simp [z, θ] <;> ring
  have hval : ZMod.stdAddChar z + ZMod.stdAddChar (-z) = (t : ℂ) := by
    rw [hplus, hminus]
    apply Complex.ext <;> simp [t, Real.cos_neg, Real.sin_neg] <;> ring
  let f : ZMod n → ℝ := fun u => (cycleFourierMode n z u).re
  let g : ZMod n → ℝ := fun u => (cycleFourierMode n z u).im
  have hf : cycleAdjacencyMatrix n *ᵥ f = t • f := by
    funext u
    rw [cycle_adjacency_neighbor_action n hn f u]
    have h := congrArg Complex.re (cycle_fourier_mode_neighbor_sum n z u)
    rw [hval] at h
    simpa [f, Complex.add_re, Complex.mul_re] using h
  have hg : cycleAdjacencyMatrix n *ᵥ g = t • g := by
    funext u
    rw [cycle_adjacency_neighbor_action n hn g u]
    have h := congrArg Complex.im (cycle_fourier_mode_neighbor_sum n z u)
    rw [hval] at h
    simpa [g, Complex.add_im, Complex.mul_im] using h
  let x : EuclideanSpace ℝ (ZMod n) := WithLp.toLp 2 f
  let y : EuclideanSpace ℝ (ZMod n) := WithLp.toLp 2 g
  let T := Matrix.toEuclideanLin (cycleAdjacencyMatrix n)
  have hT : T.IsSymmetric := Matrix.isHermitian_iff_isSymmetric.1 (cycleAdjacency_isHermitian n)
  have hx : T x = t • x := by
    change WithLp.toLp 2 (cycleAdjacencyMatrix n *ᵥ f) = t • WithLp.toLp 2 f
    rw [hf]
    rfl
  have hy : T y = t • y := by
    change WithLp.toLp 2 (cycleAdjacencyMatrix n *ᵥ g) = t • WithLp.toLp 2 g
    rw [hg]
    rfl
  have hind (a b : ℝ) (h : a • x + b • y = 0) : a = 0 ∧ b = 0 := by
    have h0 := congrArg (fun w : EuclideanSpace ℝ (ZMod n) => w 0) h
    change a * f 0 + b * g 0 = 0 at h0
    have ha : a = 0 := by simpa [f, g, cycleFourierMode] using h0
    have h1 := congrArg (fun w : EuclideanSpace ℝ (ZMod n) => w 1) h
    change a * f 1 + b * g 1 = 0 at h1
    have hh : b * Real.sin θ = 0 := by
      simpa [f, g, cycleFourierMode, ha, hplus] using h1
    exact ⟨ha, (mul_eq_zero.mp hh).resolve_right (ne_of_gt hsin)⟩
  have hN : 2 ≤ Fintype.card (ZMod n) := by rw [ZMod.card]; omega
  have hh := penultimate_of_independent_modes T hT
    (finrank_euclideanSpace : Module.finrank ℝ (EuclideanSpace ℝ (ZMod n)) =
      Fintype.card (ZMod n)) hN t x y hx hy hind
  change (cycleAdjacency_isHermitian n).eigenvalues₀
    ⟨Fintype.card (ZMod n)-2, by omega⟩ ≤ t at hh
  unfold actualSecondSmallestAdjacency
  have he : (⟨n-2, by simpa only [ZMod.card] using (show n-2<n by omega)⟩ :
      Fin (Fintype.card (ZMod n))) = ⟨Fintype.card (ZMod n)-2, by omega⟩ := by
    apply Fin.ext
    simp [ZMod.card]
  rw [he]
  exact hh

theorem cycle_adjacency_candidate_le_actual
    (n : ℕ) [NeZero n] (hn : 15 ≤ n) :
    adjacencyCosineCandidate n ≤ -actualSecondSmallestAdjacency n (by omega) := by
  by_cases hp : n % 2 = 0
  · let m := n / 2
    have hm : 8 ≤ m := by omega
    have hnm : n = 2*m := by omega
    have h := actual_second_le_fourier n (m-1) (by omega) (by omega) (by omega)
    have hmR : (m : ℝ) ≠ 0 := by positivity
    have he : 2 * Real.pi * ((m-1 : ℕ) : ℝ) / (n : ℝ) =
        Real.pi - Real.pi / (m : ℝ) := by
      rw [hnm, Nat.cast_sub (by omega)]
      push_cast
      field_simp
      <;> ring
    rw [he, Real.cos_pi_sub] at h
    simp only [adjacencyCosineCandidate, if_pos hp]
    change 2 * Real.cos (Real.pi / (m : ℝ)) ≤ _
    linarith
  · let m := n / 2
    have hm : 7 ≤ m := by omega
    have hnm : n = 2*m+1 := by omega
    have h := actual_second_le_fourier n m (by omega) (by omega) (by omega)
    have he : 2 * Real.pi * (m : ℝ) / (n : ℝ) = Real.pi - Real.pi / (n : ℝ) := by
      have hnR : (n : ℝ) ≠ 0 := by positivity
      have hrel : (n : ℝ) = 2*(m : ℝ)+1 := by exact_mod_cast hnm
      field_simp
      nlinarith
    rw [he, Real.cos_pi_sub] at h
    simp only [adjacencyCosineCandidate, if_neg hp]
    change 2 * Real.cos (Real.pi / ((2*m+1 : ℕ) : ℝ)) ≤ _
    rw [← hnm]
    linarith

theorem full_graffiti_infinite_family (n : ℕ) [NeZero n] (hn : 15 ≤ n) :
    actualCycleGravitySpan n < -actualSecondSmallestAdjacency n (by omega) :=
  graffiti_strict_of_adjacency_lower n hn (cycle_adjacency_candidate_le_actual n hn)

end Newton400.Case001
