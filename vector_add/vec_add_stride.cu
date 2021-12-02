#include<stdio.h>

__global__ void add_vec(float * a, float * b, float * res, int size)
{
    // The thread's unique number 
    int idx = threadIdx.x;
    int stride = blockDim.x;

    printf("Thread: %i Size %i Stride %i\n", idx, size, stride);

    for(int i = idx; i < size; i += stride) {
        res[i] = a[i] + b[i];
    }
    // printf("Stop\n");
}

int main(void) {

    // int N = 1<<20;
    // int * N;
    // cudaMallocManaged(&N, sizeof(int));
    int N = 20;

    float *a, *b, *result;

    // Manual mem allocation:
    // float *a, *dev_a;
    // a = (float*) malloc(sizeof(float) * N);
    // cudaMalloc((void**)&dev_a, sizeof(float) * N);

    // Allocate Unified Memory – accessible from CPU or GPU
    cudaMallocManaged(&a, N * sizeof(float));
    cudaMallocManaged(&b, N * sizeof(float));
    cudaMallocManaged(&result, N * sizeof(float));

    for(int i = 0; i < N; ++i) {
        a[i] = 10.0;
        b[i] = (float) i;
    }

    add_vec<<<1, N/2>>>(a, b, result, N);

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
