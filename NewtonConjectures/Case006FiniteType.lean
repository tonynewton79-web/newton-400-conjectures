import Mathlib

/-!
# Case 006: algebraic finite-type Hessian compatibility

The H8 pressure-augmented formal adjoint imposes that the symmetric
gradient of a vector field q equals f * diag(1,-2,1).
Commutation of derivatives gives six Hessian relations. This module
formalizes the exact algebraic elimination of their six components.

The passage from the smooth adjoint PDE to these relations, the
analytic conclusion that q is quadratic, and completeness of the
ten-dimensional kernel have a mathematical proof in Appendix I but
are **not** end-to-end formalized in Lean by this file.
-/

namespace Newton400.Case006FiniteType

/-- The six Saint-Venant compatibility relations admit only the
zero Hessian. This is the algebraic finite-type step. -/
theorem hessian_zero_of_six_compatibilities
    (hxx hyy hzz hxy hxz hyz : ℝ)
    (h1 : 2 * hxx - hyy = 0)
    (h2 : -hyz = 0)
    (h3 : -hxx - hzz = 0)
    (h4 : -2 * hxz = 0)
    (h5 : -hxy = 0)
    (h6 : -hyy + 2 * hzz = 0) :
    hxx = 0 ∧ hyy = 0 ∧ hzz = 0 ∧
    hxy = 0 ∧ hxz = 0 ∧ hyz = 0 := by
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  · linarith

/-- The anisotropic diagonal strain has zero trace. -/
theorem anisotropic_trace_zero (f : ℝ) :
    f + (-2 * f) + f = 0 := by
  ring

end Newton400.Case006FiniteType
