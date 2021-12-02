#include<stdio.h>

__global__ void add_vec(float * a, float * b, float * res)
{
    // The thread's unique number 
    int idx = threadIdx.x;
    printf("Thread: %i\n", idx);

    res[idx] = a[idx] + b[idx];
}

int main(void) {

    // int N = 1<<20;
    int N = 10;
    float *a, *b, *result;

    // Allocate Unified Memory – accessible from CPU or GPU
    cudaMallocManaged(&a, N * sizeof(float));
    cudaMallocManaged(&b, N * sizeof(float));
    cudaMallocManaged(&result, N * sizeof(float));

    for(int i = 0; i < N; ++i) {
        a[i] = 10.0;
        b[i] = (float) i;
    }

    add_vec<<<1, N>>>(a, b, result);

    // Wait for GPU to finish before accessing on host
    cudaDeviceSynchronize();

    for(int i = 0; i < N; ++i) {
        printf("%.4f\n", result[i]);
    }

    // Free memory
    cudaFree(a);
    cudaFree(b);
    cudaFree(result);

    return  0;
}
