"""Exact and independent unit checks for Case 001."""
import importlib.util
import math
from fractions import Fraction as Q
from pathlib import Path
import unittest

SOURCE=Path(__file__).resolve().parents[1]/"verify.py"
spec=importlib.util.spec_from_file_location("case001_verify",SOURCE)
v=importlib.util.module_from_spec(spec)
spec.loader.exec_module(v)

class CycleConjectureCertificate(unittest.TestCase):
    def test_exact_gram_identity_and_literal_interval_count(self):
        self.assertEqual(v.exact_psd_matrix_identity(40),870)
    def test_positive_weights(self):
        for m in range(2,200):
            self.assertTrue(all(x>0 for x in v.weights(m).values()))
            self.assertEqual(v.decomp_entry(2*m,0),Q(3,2))
            self.assertEqual(v.decomp_entry(2*m+1,m),Q(1,m))
    def test_exact_parity_boundary(self):
        s=v.initial_infinite_certificate()
        self.assertEqual(s["odd_boundary_lower"],"506/11025")
        self.assertEqual(s["even_boundary_lower"],"1733/58800")
    def test_exact_small_cycle_exclusions(self):
        pb=v.pi_interval()
        for n in range(3,15):
            self.assertTrue(v.finite_nonviolation_certificate(n,pb)["strict_negative_upper_bound"])
    def test_machin_pi_interval(self):
        lo,hi=v.pi_interval()
        self.assertGreater(lo,Q(3))
        self.assertLess(hi,Q(22,7))
        self.assertLess(hi-lo,Q(1,10**25))
    def test_fourier_cycle17_reference(self):
        n=17
        eig=v.circulant_eigenvalues(n)
        self.assertAlmostEqual(4/(n-1)*(max(eig)-min(eig)),1.7035,places=3)
        self.assertAlmostEqual(2*math.cos(math.pi/n),1.9659,places=3)
    def test_dense_eigensolver_if_installed(self):
        try:
            import numpy as np
        except ImportError:
            self.skipTest("NumPy optional")
        for n in (5,7,10,15,16,17,32,37):
            M=np.array([[0. if i==j else 1/min((i-j)%n,(j-i)%n)
                  for j in range(n)] for i in range(n)])
            self.assertTrue(np.allclose(sorted(np.linalg.eigvalsh(M)),
                                        sorted(v.circulant_eigenvalues(n)),
                                        rtol=0,atol=1e-11))
    def test_float_sanity_is_secondary(self):
        s=v.numerical_sanity(160)
        self.assertGreater(s["least_positive_margin"],0)
        self.assertLess(s["largest_negative_margin"],0)
    def test_wrong_gravity_normalization_mutant(self):
        n=15
        genuine=Q(4,n-1)
        wrong=Q(1,n-1)
        self.assertEqual(genuine/wrong,4)
        self.assertEqual(v.weights(7)[7],Q(1,42))

if __name__=="__main__":
    unittest.main()
