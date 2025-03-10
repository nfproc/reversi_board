// Reversi Board Detection for Vitis Vision
// 2022-12-27 Naoki F., AIT
// New BSD license is applied. See LICENSE.txt for more details.

// #include "/tools/Xilinx/Vivado/2021.1/include/gmp.h"
#include "hls_stream.h"
#include "ap_int.h"
#include "common/xf_common.hpp"
#include "common/xf_utility.hpp"
#include "imgproc/xf_houghlines.hpp"
#include "reversi_accel.hpp"

static constexpr int __NUM_PIXEL = HEIGHT * WIDTH;
static constexpr int __NUM_LINES = LINESMAX;

void reversi_accel(ap_uint<PTRWIDTH> *data_in, float *rho_out, float *theta_out, int height, int width) {
    #pragma HLS INTERFACE m_axi     port=data_in   offset=slave bundle=data  depth=__NUM_PIXEL
    #pragma HLS INTERFACE m_axi     port=rho_out   offset=slave bundle=rho   depth=__NUM_LINES
    #pragma HLS INTERFACE m_axi     port=theta_out offset=slave bundle=theta depth=__NUM_LINES
    #pragma HLS INTERFACE s_axilite port=data_in
    #pragma HLS INTERFACE s_axilite port=rho_out
    #pragma HLS INTERFACE s_axilite port=theta_out
    #pragma HLS INTERFACE s_axilite port=height
    #pragma HLS INTERFACE s_axilite port=width
    #pragma HLS INTERFACE s_axilite port=return

    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> in_mat(height, width);

    #pragma HLS DATAFLOW
    xf::cv::Array2xfMat<PTRWIDTH, XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(data_in, in_mat);
    xf::cv::HoughLines<RHOSTEP, THETASTEP, LINESMAX, DIAGVAL, 0, 180, XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(
        in_mat, rho_out, theta_out, THRESHOLD, LINESMAX);
}