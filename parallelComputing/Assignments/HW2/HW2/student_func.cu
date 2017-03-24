
#include "utils.h"

__global__
void gaussian_blur(const unsigned char* const inputChannel,
                   unsigned char* const outputChannel,
                   int numRows, int numCols,
                   const float* const filter, const int filterWidth)
{

  // numRows=313 && numCols=557
    int X=blockIdx.x * blockDim.x + threadIdx.x;
    int Y=blockIdx.y * blockDim.y + threadIdx.y;
    if ( X >= numCols || Y >= numRows ) {
        return;
    }
    int half   = filterWidth / 2;
    float blur   = 0.0f;
    int width  = numCols - 1;
    int height = numRows - 1;
    
    for (int i = -half; i <= half; i++) {
        for (int j = -half; j <= half; j++) {
            int h=min(max(Y+i,0),height);
            int w=min(max(X+j,0),width);
            int idx=h*numCols+w;
            float pixel=static_cast<float>(inputChannel[idx]);
            idx=(i+half)+(filterWidth*(j+half));
            float weight=filter[idx];
            blur+=pixel*weight;
        }
    }
    
    outputChannel[X+numCols*Y] = static_cast<unsigned char>(blur);
}   

//This kernel takes in an image represented as a uchar4 and splits
//it into three images consisting of only one color channel each
__global__
void separateChannels(const uchar4* const inputImageRGBA,
                      int numRows,
                      int numCols,
                      unsigned char* const redChannel,
                      unsigned char* const greenChannel,
                      unsigned char* const blueChannel)
{
    int X=blockIdx.x * blockDim.x + threadIdx.x;
    int Y=blockIdx.y * blockDim.y + threadIdx.y;
    if ( X >= numCols || Y >= numRows ) {
        return;
    }
    uchar4 rgba = inputImageRGBA[X+numCols*Y];
    redChannel[X+numCols*Y]=rgba.x;
    greenChannel[X+numCols*Y]=rgba.y;
    blueChannel[X+numCols*Y]=rgba.z;
}
__global__
void recombineChannels(const unsigned char* const redChannel,
                       const unsigned char* const greenChannel,
                       const unsigned char* const blueChannel,
                       uchar4* const outputImageRGBA,
                       int numRows,
                       int numCols)
{
  const int2 thread_2D_pos = make_int2( blockIdx.x * blockDim.x + threadIdx.x,
                                        blockIdx.y * blockDim.y + threadIdx.y);

  const int thread_1D_pos = thread_2D_pos.y * numCols + thread_2D_pos.x;
  if (thread_2D_pos.x >= numCols || thread_2D_pos.y >= numRows)
    return;

  unsigned char red   = redChannel[thread_1D_pos];
  unsigned char green = greenChannel[thread_1D_pos];
  unsigned char blue  = blueChannel[thread_1D_pos];
  uchar4 outputPixel = make_uchar4(red, green, blue, 255);

  outputImageRGBA[thread_1D_pos] = outputPixel;
}

unsigned char *d_red, *d_green, *d_blue;
float *d_filter;

void allocateMemoryAndCopyToGPU(const size_t numRowsImage, const size_t numColsImage,
                                const float* const h_filter, const size_t filterWidth)
{

  //allocate memory for the three different channels
  //original
  checkCudaErrors(cudaMalloc(&d_red,   sizeof(unsigned char) * numRowsImage * numColsImage));
  checkCudaErrors(cudaMalloc(&d_green, sizeof(unsigned char) * numRowsImage * numColsImage));
  checkCudaErrors(cudaMalloc(&d_blue,  sizeof(unsigned char) * numRowsImage * numColsImage));
  checkCudaErrors(cudaMalloc(&d_filter,  sizeof(float) * static_cast<float>(filterWidth)*static_cast<float>(filterWidth)));
  checkCudaErrors(cudaMemcpy(d_filter, h_filter,sizeof(float) * static_cast<float>(filterWidth)*static_cast<float>(filterWidth), cudaMemcpyHostToDevice));

}

void your_gaussian_blur(const uchar4 * const h_inputImageRGBA, uchar4 * const d_inputImageRGBA,
                        uchar4* const d_outputImageRGBA, const size_t numRows, const size_t numCols,
                        unsigned char *d_redBlurred, 
                        unsigned char *d_greenBlurred, 
                        unsigned char *d_blueBlurred,
                        const int filterWidth)
{

  const dim3 blockSize(9,9,1);
  const dim3 gridSize(62,35,1);
  checkCudaErrors(cudaMemcpy(d_inputImageRGBA, h_inputImageRGBA, sizeof(uchar4) * static_cast<int>(numRows)*static_cast<int>(numCols), cudaMemcpyHostToDevice));
  separateChannels<<<gridSize, blockSize>>>(d_inputImageRGBA,numRows,numCols,d_red,d_green,d_blue);
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());    
  gaussian_blur<<<gridSize, blockSize>>>(d_red,d_redBlurred,numRows,numCols,d_filter,filterWidth);
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
  gaussian_blur<<<gridSize, blockSize>>>(d_green,d_greenBlurred,numRows,numCols,d_filter,filterWidth);
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
  gaussian_blur<<<gridSize, blockSize>>>(d_blue,d_blueBlurred,numRows,numCols,d_filter,filterWidth);
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
  recombineChannels<<<gridSize, blockSize>>>(d_redBlurred,
                                             d_greenBlurred,
                                             d_blueBlurred,
                                             d_outputImageRGBA,
                                             numRows,
                                             numCols);
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());

}
void cleanup() {
  checkCudaErrors(cudaFree(d_red));
  checkCudaErrors(cudaFree(d_green));
  checkCudaErrors(cudaFree(d_blue));
  checkCudaErrors(cudaFree(d_filter));
}
