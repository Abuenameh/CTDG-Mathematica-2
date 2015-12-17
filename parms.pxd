import numpy as np
cimport numpy as np

DTYPE = np.float64
ctypedef np.float64_t DTYPE_t
CDTYPE = np.complex128
ctypedef np.complex128_t CDTYPE_t

cdef double Wt(double t, double Wi, double Wf, double tau)

cdef double Wtp(double t, double Wi, double Wf, double tau)

cdef double U0t(double W)

cdef np.ndarray[DTYPE_t, ndim=1] Ut(np.ndarray[DTYPE_t, ndim=1] W)

cdef np.ndarray[DTYPE_t, ndim=1] Jt(np.ndarray[DTYPE_t, ndim=1] W)

cdef double U0tp(double W, double Wp)

cdef np.ndarray[DTYPE_t, ndim=1] Jtp(np.ndarray[DTYPE_t, ndim=1] W, np.ndarray[DTYPE_t, ndim=1] Wp)

cdef double Wt(double t, double Wi, double Wf, double tau)

cdef double Wtp(double t, double Wi, double Wf, double tau)
