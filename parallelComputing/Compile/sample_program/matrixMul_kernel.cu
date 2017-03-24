
#ifndef _MATRIXMUL_KERNEL_H_
#define _MATRIXMUL_KERNEL_H_
 
#include <stdio.h>
 
// Thread block size
#define BLOCK_SIZE 16
#define TILE_SIZE  16
 
#define WA 64     // Matrix A width
#define HA 64     // Matrix A height
#define WB 64     // Matrix B width
#define HB WA     // Matrix B height
#define WC WB     // Matrix C width
#define HC HA     // Matrix C height
 
// CUDA Kernel
__global__ void
matrixMul( float* C, float* A, float* B, int wA, int wB)
{
 
   // 1. 2D Thread ID
   int tx = blockIdx.x * TILE_SIZE + threadIdx.x;
   int ty = blockIdx.y * TILE_SIZE + threadIdx.y;
 
   // value stores the element that is 
   // computed by the thread
   float value = 0;
   for (int i = 0; i < wA; ++i)
   {
      float elementA = A[ty * wA + i];
      float elementB = B[i * wB + tx];
      value += elementA * elementB;
   }
 
   // Write the matrix to device memory each 
   // thread writes one element
   C[ty * wA + tx] = value;
}
 
#endif // #ifndef _MATRIXMUL_KERNEL_H_

