#include "reference_calc.cpp"
#include "utils.h"

__global__ void minimum(float * d_out, const float * const d_in, const size_t numItem) {
    extern __shared__ float shared[];
    int myId = threadIdx.x + blockDim.x * blockIdx.x;
    int tid  = threadIdx.x;
    shared[tid] = 0.0f;
    if (myId < numItem)
        shared[tid] = d_in[myId];
    __syncthreads();
    for (unsigned int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared[tid] = min(shared[tid], shared[tid + s]);
        }
        __syncthreads();
    }
    if (tid == 0) {
        d_out[blockIdx.x] = shared[0];
    }
}




__global__ void maximum(float * d_out, const float * const d_in, const size_t numItem) {
    extern __shared__ float shared[];
    int myId = threadIdx.x + blockDim.x * blockIdx.x;
    int tid  = threadIdx.x;
    shared[tid] = 0.0f;
    if (myId < numItem)
        shared[tid] = d_in[myId];
    __syncthreads();
    for (unsigned int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) {
            shared[tid] = max(shared[tid], shared[tid + s]);
        }
        __syncthreads();
    }
    if (tid == 0) {
        d_out[blockIdx.x] = shared[0];
    }
}




__global__ void histogram(unsigned int *d_bin, const float * const d_in, const size_t numBins, const float min_logLum, const float range, const size_t numRows, const size_t numCols) {

    int myId = threadIdx.x + blockDim.x * blockIdx.x;
    if (myId >= (numRows * numCols))
        return;
    float myItem = d_in[myId];
    int myBin = (myItem - min_logLum) / range * numBins;
    atomicAdd(&(d_bin[myBin]), 1);
}




__global__ void scan(unsigned int *d_out, unsigned int *d_sums, const unsigned int * const d_in, const unsigned int numBins, const unsigned int numElems)  {

    extern __shared__ float shared[];
    int myId = blockIdx.x * blockDim.x + threadIdx.x;
    int tid = threadIdx.x;
    int offset = 1;
    if ((2 * myId) < numBins) {
        shared[2 * tid] = d_in[2 * myId];
    }
    else {
        shared[2 * tid] = 0;
    }
    if ((2 * myId + 1) < numBins) {
        shared[2 * tid + 1] = d_in[2 * myId + 1];
    }
    else {
        shared[2 * tid + 1] = 0;
    }
    for (unsigned int d = numElems >> 1; d > 0; d >>= 1) {
        if (tid < d)  {
            int ai = offset * (2 * tid + 1) - 1;
            int bi = offset * (2 * tid + 2) - 1;
            shared[bi] += shared[ai];
        }
        offset *= 2;
        __syncthreads();
    }
    if (tid == 0) {
        d_sums[blockIdx.x] = shared[numElems - 1];
        shared[numElems - 1] = 0;
    }
    for (unsigned int d = 1; d < numElems; d *= 2) {
        offset >>= 1;
        if (tid < d) {
            int ai = offset * (2 * tid + 1) - 1;
            int bi = offset * (2 * tid + 2) - 1;
            float t = shared[ai];
            shared[ai] = shared[bi];
            shared[bi] += t;
        }
        __syncthreads();
    }
    if ((2 * myId) < numBins) {
        d_out[2 * myId] = shared[2 * tid];
    }
    if ((2 * myId + 1) < numBins) {
        d_out[2 * myId + 1] = shared[2 * tid + 1];
    }
}




// This version only works for one single block! The size of the array of items
__global__ void scan2(unsigned int *d_out, const unsigned int * const d_in, const unsigned int numBins, const unsigned int numElems)  {
    extern __shared__ float shared[];
    int tid = threadIdx.x;
    int offset = 1;
    // load two items per thread into shared memory
    if ((2 * tid) < numBins) {
        shared[2 * tid] = d_in[2 * tid];
    }
    else {
        shared[2 * tid] = 0;
    }
    if ((2 * tid + 1) < numBins) {
        shared[2 * tid + 1] = d_in[2 * tid + 1];
    }
    else {
        shared[2 * tid + 1] = 0;
    }
    // Reduce
    for (unsigned int d = numElems >> 1; d > 0; d >>= 1) {
        if (tid < d)  {
            int ai = offset * (2 * tid + 1) - 1;
            int bi = offset * (2 * tid + 2) - 1;
            shared[bi] += shared[ai];
        }
        offset *= 2;
        __syncthreads();
    }
    // clear the last element
    if (tid == 0) {
        shared[numElems - 1] = 0;
    }
    // Down Sweep
    for (unsigned int d = 1; d < numElems; d *= 2) {
        offset >>= 1;
        if (tid < d) {
            int ai = offset * (2 * tid + 1) - 1;
            int bi = offset * (2 * tid + 2) - 1;
            float t = shared[ai];
            shared[ai] = shared[bi];
            shared[bi] += t;
        }
        __syncthreads();
    }
    // write the output to global memory
    if ((2 * tid) < numBins) {
        d_out[2 * tid] = shared[2 * tid];
    }
    if ((2 * tid + 1) < numBins) {
        d_out[2 * tid + 1] = shared[2 * tid + 1];
    }
}




__global__ void add_scan(unsigned int *d_out, const unsigned int * const d_in, const unsigned int numBins) {
    if (blockIdx.x == 0)
        return;
    int myId = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int myOffset = d_in[blockIdx.x];
    if ((2 * myId) < numBins) {
        d_out[2 * myId] += myOffset;
    }
    if ((2 * myId + 1) < numBins) {
        d_out[2 * myId + 1] += myOffset;
    }
}




void your_histogram_and_prefixsum(const float* const d_logLuminance, unsigned int* const d_cdf, float &min_logLum, float &max_logLum, const size_t numRows, const size_t numCols, const size_t numBins) {
    // Initialization
    unsigned int numItem = numRows * numCols;
    dim3 blockSize(256, 1, 1);
    dim3 gridSize(numItem / blockSize.x + 1, 1, 1);
    float * d_min;
    float * d_max;
    unsigned int * d_histogram;
    unsigned int * d_sums;
    unsigned int * d_incr;
    checkCudaErrors(cudaMalloc(&d_min, sizeof(float) * gridSize.x));
    checkCudaErrors(cudaMalloc(&d_max, sizeof(float) * gridSize.x));
    checkCudaErrors(cudaMalloc(&d_histogram, sizeof(unsigned int) * numBins));
    checkCudaErrors(cudaMemset(d_histogram, 0, sizeof(unsigned int) * numBins));
    // Step 1: Reduce (min and max). It could be done in one step only!
    minimum<<<gridSize, blockSize, sizeof(float) * blockSize.x>>>(d_min, d_logLuminance, numItem);
    maximum<<<gridSize, blockSize, sizeof(float) * blockSize.x>>>(d_max, d_logLuminance, numItem);
    numItem = gridSize.x;
    gridSize.x = numItem / blockSize.x + 1;
    while (numItem > 1) {
        minimum<<<gridSize, blockSize, sizeof(float) * blockSize.x>>>(d_min, d_min, numItem);
        maximum<<<gridSize, blockSize, sizeof(float) * blockSize.x>>>(d_max, d_max, numItem);
        numItem = gridSize.x;
        gridSize.x = numItem / blockSize.x + 1;
    }
    // Step 2: Range
    checkCudaErrors(cudaMemcpy(&min_logLum, d_min, sizeof(float), cudaMemcpyDeviceToHost));
    checkCudaErrors(cudaMemcpy(&max_logLum, d_max, sizeof(float), cudaMemcpyDeviceToHost));
    float range = max_logLum - min_logLum;
    // Step 3: Histogram
    gridSize.x = numRows * numCols / blockSize.x + 1;
    histogram<<<gridSize, blockSize>>>(d_histogram, d_logLuminance, numBins, min_logLum, range, numRows, numCols);
    // Step 4: Exclusive scan - Blelloch
    unsigned int numElems = 256;
    blockSize.x = numElems / 2;
    gridSize.x = numBins / numElems;
    if (numBins % numElems != 0)
        gridSize.x++;
    checkCudaErrors(cudaMalloc(&d_sums, sizeof(unsigned int) * gridSize.x));
    checkCudaErrors(cudaMemset(d_sums, 0, sizeof(unsigned int) * gridSize.x));
    // First-level scan to obtain the scanned blocks
    scan<<<gridSize, blockSize, sizeof(float) * numElems>>>(d_cdf, d_sums, d_histogram, numBins, numElems);
    // Second-level scan to obtain the scanned blocks sums
    numElems = gridSize.x;
    // Look for the next power of 2 (32 bits)
    unsigned int nextPow = numElems;
    nextPow--;
    nextPow = (nextPow >> 1) | nextPow;
    nextPow = (nextPow >> 2) | nextPow;
    nextPow = (nextPow >> 4) | nextPow;
    nextPow = (nextPow >> 8) | nextPow;
    nextPow = (nextPow >> 16) | nextPow;
    nextPow++;
    blockSize.x = nextPow / 2;
    gridSize.x = 1;
    checkCudaErrors(cudaMalloc(&d_incr, sizeof(unsigned int) * numElems));
    checkCudaErrors(cudaMemset(d_incr, 0, sizeof(unsigned int) * numElems));
    scan2<<<gridSize, blockSize, sizeof(float) * nextPow>>>(d_incr, d_sums, numElems, nextPow);
    // Add scanned block sum i to all values of scanned block i
    numElems = 256;
    blockSize.x = numElems / 2;
    gridSize.x = numBins / numElems;
    if (numBins % numElems != 0)
        gridSize.x++;
    add_scan<<<gridSize, blockSize>>>(d_cdf, d_incr, numBins);
    // Clean memory
    checkCudaErrors(cudaFree(d_min));
    checkCudaErrors(cudaFree(d_max));
    checkCudaErrors(cudaFree(d_histogram));
    checkCudaErrors(cudaFree(d_sums));
    checkCudaErrors(cudaFree(d_incr));
}
