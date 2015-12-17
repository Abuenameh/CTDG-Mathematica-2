from __future__ import division
from libc.math cimport sqrt, pow
import numpy as np
cimport numpy as np

#cdef double Wi = 3e11
#cdef double Wf = 1e11
#cdef double tau = 2e-7*1e7

#DTYPE = np.float64
#ctypedef np.float64_t DTYPE_t
#CDTYPE = np.complex128
#ctypedef np.complex128_t CDTYPE_t

cdef double Wt(double t, double Wi, double Wf, double tau):
    if t < tau:
        return Wi + (Wf - Wi) * t / tau
    else:
        return Wf + (Wi - Wf) * (t - tau) / tau

cdef double Wtp(double t, double Wi, double Wf, double tau):
    if t < tau:
        return (Wf - Wi) / tau
    else:
        return (Wi - Wf) / tau

cpdef double Ui(double W):
    return (3.9062500000000004e30*W**2)/((6.250000000000001e21 + W**2)**2)

cdef double Jij(double Wi, double Wj):
    return (1.1e7*Wi*Wj)/(sqrt(6.250000000000001e21 + Wi**2)*sqrt(6.250000000000001e21 + Wj**2))

cdef double U0t(double W):
    return Ui(W)

cdef np.ndarray[DTYPE_t, ndim=1] Ut(np.ndarray[DTYPE_t, ndim=1] W):
    return np.array([Ui(Wi) for Wi in W])

cdef np.ndarray[DTYPE_t, ndim=1] Jt(np.ndarray[DTYPE_t, ndim=1] W):
    cdef int L = len(W)
    return np.array([Jij(W[i], W[i+1]) for i in range(L-1)] + [Jij(W[L-1], W[0])])

cdef double U0tp(double W, double Wp):
    return (-1.5625000000000001e31*W**3*Wp)/((6.250000000000001e21 + W**2)**3) + (7.812500000000001e30*W*Wp)/((6.250000000000001e21 + W**2)**2)

cdef double Jpij(double Wi, double Wj, double Wip, double Wjp):
    return (-1.1e7*Wi**2*Wj*Wip)/((6.250000000000001e21 + Wi**2)**(3/2)*sqrt(6.250000000000001e21 + Wj**2)) + (1.1e7*Wj*Wip)/(sqrt(6.250000000000001e21 + Wi**2)*sqrt(6.250000000000001e21 + Wj**2)) -\
    (1.1e7*Wi*Wj**2*Wjp)/(sqrt(6.250000000000001e21 + Wi**2)*(6.250000000000001e21 + Wj**2)**(3/2)) + (1.1e7*Wi*Wjp)/(sqrt(6.250000000000001e21 + Wi**2)*sqrt(6.250000000000001e21 + Wj**2))

cdef np.ndarray[DTYPE_t, ndim=1] Jtp(np.ndarray[DTYPE_t, ndim=1] W, np.ndarray[DTYPE_t, ndim=1] Wp):
    cdef int L = len(W)
    return np.array([Jpij(W[i], W[i+1], Wp[i], Wp[i+1]) for i in range(L-1)] + [Jpij(W[L-1], W[0], Wp[L-1], Wp[0])])

