#include "utils.h"
#include "reference_calc.cpp"

#define BLOCK_SIZE_MAX 512
#define GRID_SIZE_MAX 512
#define NUMBER_OF_ELEMS_PER_THREAD 16

__global__
void histogramKernel(const unsigned int* const d_In, unsigned int* const d_Out, int numVals, unsigned int valsOffset, unsigned int numBins) {
    extern __shared__ unsigned int s_histogramKernel_Out[];
    int threadsPerBlock = blockDim.x * blockDim.y;
    int threadsPerGrid = threadsPerBlock * gridDim.x * gridDim.y;
    int blockId = blockIdx.x + (blockIdx.y * gridDim.x);
    int threadId = threadIdx.x + (threadIdx.y * blockDim.x);
    for (int i = 0; i < (numBins / threadsPerBlock); i++) {
        int _index =
        i * threadsPerBlock + threadId;
        if (_index < numBins) {
            s_histogramKernel_Out[_index] =0;
        }
    }
    __syncthreads();
    int myId = (blockId * threadsPerBlock) + threadId;
    for (int _step = 0; _step < NUMBER_OF_ELEMS_PER_THREAD; _step++) {
        int _myTrueId =
        myId + _step * threadsPerGrid;
        if ( (_myTrueId + valsOffset) >= numVals ) {
            break;
        }
        else {
            unsigned int _in =
            d_In[_myTrueId];
            atomicAdd(&(s_histogramKernel_Out[_in]), 1);
        }
    }
    __syncthreads();
    for (int i = 0; i < (numBins / threadsPerBlock); i++) {
        int _index = i * threadsPerBlock + threadId;
        if (_index < numBins) {
            atomicAdd(&(d_Out[_index]), s_histogramKernel_Out[_index]);
        }
    }
}

void computeHistogram(const unsigned int* const d_In, unsigned int* const d_Out, const unsigned int numBins, const unsigned int numElems) {
    unsigned int _numElemsProcessed = 0;
    dim3 _block(BLOCK_SIZE_MAX);
    while (_numElemsProcessed < numElems) {
        int numElemGroupsLeft =
        (numElems - _numElemsProcessed - 1) / NUMBER_OF_ELEMS_PER_THREAD + 1;
        int _gridSize = (numElemGroupsLeft - 1) / BLOCK_SIZE_MAX + 1;
        _gridSize = _gridSize < GRID_SIZE_MAX ? _gridSize : GRID_SIZE_MAX;
        dim3 _grid(_gridSize);
        histogramKernel<<<_grid, _block, (numBins * sizeof(unsigned int))>>> (&d_In[_numElemsProcessed],d_Out,numElems,_numElemsProcessed,numBins);
        _numElemsProcessed +=_gridSize * BLOCK_SIZE_MAX * NUMBER_OF_ELEMS_PER_THREAD;
}
cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
}