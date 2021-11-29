#include<stdio.h>
extern "C" {
    #include "hello.h"
}

__global__ void helloWorld(float f)
{
    // The thread's unique number 
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    printf("Hello block: %i threadN: %i threadIdx: %i, f=%f\n",
           blockIdx.x, threadIdx.x, idx, f);
}

int hello_f_CUDA(void) {

    helloWorld<<<2, 10>>>(1.2345f);
    cudaDeviceReset();

    return  0;
}

int main(void) {

    helloWorld<<<2, 10>>>(1.2345f);
    cudaDeviceReset();

    return  0;
}
