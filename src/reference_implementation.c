#include "math.h"
#include "stdint.h"
#include "reference_implementation.h"

#define PI 3.14

void fft_ref(float *input, float *output_re, float *output_im, size_t N)
{
    for(uint32_t k = 0; k < N; k++)
    {
        output_re[k] = 0;
        output_im[k] = 0;
        for(uint32_t n = 0; n < N; n++)
        {
            output_re[k] += input[n] * cos(2*k*PI*n/N);
            output_im[k] += input[n] * sin(2*k*PI*n/N);
        }
    }
}



