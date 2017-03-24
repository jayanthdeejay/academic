#include "reference_calc.cpp"
#include "utils.h"
#include<stdio.h>
#include<cmath>
__device__ inline int getidx(){
    return threadIdx.x+threadIdx.y*blockDim.x+blockIdx.x*blockDim.x*blockDim.y;};
template <typename T>
__device__ inline int lessEq(const T a, const T b){
    return (int)(a<=b);
};
template <typename T>
__device__ inline int moreEq(const T a, const T b){
    return (int)(a>=b);
};
template <typename S, int (*T) (const S, const S)>
__global__ void bitonic_sort_ (S* const in, S* const in2, const int len, const int inc, const int inr){
    int idx = getidx();
    if (idx >= len) return;
    int updown = 0;
    S up, down;
    S up_, down_;
    int pass=0;
    {
        updown = (idx/inc) % 2;
        up = in[idx];
        up_ = in2[idx];
        if (idx % (inr*2) >= inr) return;
        down = in[idx+inr];
        down_= in2[idx+inr];
        pass = (T(up,down)==updown);
        if (pass)  return;
        else {
            in[idx]=down;
            in2[idx]=down_;
            in[idx+inr]=up;
            in2[idx+inr]=up_;
        }
    }
    return;
}
template <typename S, int (*T) (const S, const S)>
int bitonic_sort (S* const in, S* const in2,
const int len, const dim3& gsize, const dim3& bsize) {
    int cnt =0;
    for (int inc = 2; inc<=len; inc=inc*2) {
        for (int inr = inc/2; inr>=1; inr=inr/2) {
            bitonic_sort_ <S, T> <<<gsize,bsize>>>(in, in2, len, inc, inr);
        }
        cnt++;
    }
    return cnt;
    }
template <typename S>
__global__ void setdummy(const S* const in, S* const out, const S dummy, const int len1, const int len2) {
    int idx=getidx();
    S val;
    if (idx >= len2) return;
    if (idx < len1) val = in[idx];
    else val =dummy;
    out[idx] = val;
    return;
}
template <typename S>
unsigned int pad( const S* const in, S* out, unsigned int len, S dummy) {
    unsigned int exp = (unsigned int)log2((float)len)+1;
    unsigned int acc = (unsigned int)exp2((float)exp);
    printf("padded %d elements to %d\n", len, acc);
    return acc;
}

void your_sort(unsigned int* const d_inputVals, unsigned int* const d_inputPos, unsigned int* const d_outputVals, unsigned int* const d_outputPos, const size_t numElems) {
    unsigned int *d_tmp, *d_tmp2;
    unsigned int acc = pad <unsigned> (d_inputVals, d_tmp, numElems, (unsigned)(-1));
    pad <unsigned> (d_inputPos, d_tmp2, numElems, (unsigned)(-1));
    dim3 bsize2(64,16,1);
    int numGrids=(int)acc/(64*16)+1;
    dim3 gsize2(numGrids,1,1);
    checkCudaErrors(cudaMalloc((void**) &d_tmp, sizeof(unsigned int)*acc));
    checkCudaErrors(cudaMalloc((void**) &d_tmp2, sizeof(unsigned int)*acc));
    setdummy <unsigned int> <<<gsize2, bsize2>>> (d_inputVals, d_tmp,(unsigned int)(-1), numElems, acc);
    setdummy <unsigned int> <<<gsize2, bsize2>>> (d_inputPos, d_tmp2,(unsigned int)(-1), numElems, acc);
    int cnt =0;
    cnt = bitonic_sort<unsigned int, moreEq<unsigned int> > (d_tmp, d_tmp2, (int)acc,  gsize2, bsize2);
    setdummy <unsigned int> <<<gsize2, bsize2>>> (d_tmp,d_outputVals,0, acc, numElems);
    setdummy <unsigned int> <<<gsize2, bsize2>>> (d_tmp2,d_outputPos,0, acc, numElems);
    checkCudaErrors(cudaFree(d_tmp));
    checkCudaErrors(cudaFree(d_tmp2));
    printf("Total length is %d, total iteration finished is %d\n", (int)acc, cnt);
}