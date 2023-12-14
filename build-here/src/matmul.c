
#include "dataset.h"
#include <stddef.h>

// multiply all elements of an array by a corresponding element of another array
void mul(int N, const data_t x[], const data_t y[], data_t z[])
{
  int i;

  for (i = 0; i < N; i++)
	z[i] = x[i] * y[i];
}

// NxN matrices (multiplication)
void matmul(int N,  const data_t A[], const data_t B[], data_t C[])
{
  int i, j, k;
 
  for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
      data_t sum = 0;
      for (k = 0; k < N; k++)
        sum += A[j*N + k] * B[k*N + i];
      C[i + j*N] = sum;
    }
  }
}
// NxN matrices (addition)
void matadd(int N,  const data_t A[], const data_t B[], data_t C[])
{
  int i, j;

  for (i = 0; i < N; i++) {
	for (j = 0; j < N; j++) {
	C[i + j*N] = A[i + j*N] + B[i + j*N];
	}
  }
}
void main()
{
	// Uncomment the following lines to run the code and call the appropriate function
//	/*
	// Matrix Multiplication
	static data_t results_data[ARRAY_SIZE];
	matmul(DIM_SIZE, input1_data, input2_data, results_data);
//	 */
	/*
	// Matrix Addition
	static data_t results_data[9];
	matadd(DIM_SIZE, input1_data, input2_data, results_data);
	*/

	/*
	// Scalar Multiplication
	static data_t results_data[9];
	mul(ARRAY_SIZE, input1_data, input2_data, results_data);
	*/

}
