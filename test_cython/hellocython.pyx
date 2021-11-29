# import matplotlib.pyplot as plt
# cimport numpy as np
# import numpy as np
import time
begin = time.time()

# Bring in information about externally defined function.

cdef extern from "hello.h":
    int hello_f_CUDA()
            
def hello_f_wrap():
    hello_f_CUDA()
