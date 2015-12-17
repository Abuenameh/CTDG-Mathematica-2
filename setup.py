from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy as np

ext_modules = [Extension('E', ['E.pyx'], include_dirs=[np.get_include()], extra_compile_args=["-Wno-unused-function", "-O0"]),
               Extension('parms', ['parms.pyx'], include_dirs=[np.get_include()], extra_compile_args=["-Wno-unused-function", "-O0"]),
               Extension('odes', ['odes.pyx'], include_dirs=[np.get_include()], extra_compile_args=["-Wno-unused-function", "-O0"]),
               Extension('jac', ['jac.pyx'], include_dirs=[np.get_include()], extra_compile_args=["-Wno-unused-function", "-O0"])]

setup(
    name = 'CTDG ODE',
    include_dirs = [np.get_include()],
    ext_modules = cythonize(ext_modules, nthreads=4),
)