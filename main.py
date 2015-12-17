import numpy as np
from E import E
from odes import odes
from jac import jac
from parms import Ui
from scipy.integrate import ode
# from math import sqrt
# from itertools import chain
from timeit import timeit

L = 5
nmax = 7
dim = nmax+1

tau = 1e-7

f0 = np.array([(i/dim)*(1+1j)/(2*L*dim) for i in range(L*dim)])
f0 = np.array([0.25+0.25j]*(L*dim))

Wi = 3e11
Wf = 1e11
mu = 0.5*Ui(Wi)
xi = np.array([1.] * L)
scale = 1e7

E0 = E(f0, mu, Wi, xi, scale)
print E0

r = ode(odes, jac).set_integrator('zvode', method='bdf', nsteps=10000, max_step=0.1e-3)
r.set_initial_value(f0).set_f_params(mu, xi, Wi, Wf, tau, scale).set_jac_params(mu, xi, Wi, Wf, tau, scale)
t1 = 2*tau

def integ():
    r.integrate(t1)
print timeit(integ, number=1)

# r.integrate(t1)
print r.successful()

ff = r.y
Ef = E(ff, mu, Wi, xi, scale)
print Ef

Q = Ef - E0
print Q

print [repr(fi) for fi in ff]
