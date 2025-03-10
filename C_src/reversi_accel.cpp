// Reversi Board Detection for Vitis Vision
// 2024-06-2x Naoki F., AIT
// New BSD license is applied. See LICENSE.txt for more details.

// #include "/tools/Xilinx/Vivado/2021.1/include/gmp.h"
#include "hls_stream.h"
#include "ap_int.h"
#include "common/xf_common.hpp"
#include "common/xf_utility.hpp"
#include "core/xf_arithm.hpp"
#include "imgproc/xf_bgr2hsv.hpp"
#include "imgproc/xf_gaussian_filter.hpp"
#include "imgproc/xf_duplicateimage.hpp"
#include "imgproc/xf_inrange.hpp"
#include "imgproc/xf_dilation.hpp"
#include "imgproc/xf_erosion.hpp"
#include "imgproc/xf_houghlines.hpp"
#include "reversi_accel.hpp"

static constexpr int __NUM_PIXEL = HEIGHT * WIDTH;
static constexpr int __NUM_LINES = LINESMAX;

void reversi_accel(ap_uint<PTRWIDTH> *data_in, float *rho_out, float *theta_out, int height, int width, int stride) {
    #pragma HLS INTERFACE m_axi     port=data_in   offset=slave bundle=data  depth=__NUM_PIXEL
    #pragma HLS INTERFACE m_axi     port=rho_out   offset=slave bundle=rho   depth=__NUM_LINES
    #pragma HLS INTERFACE m_axi     port=theta_out offset=slave bundle=theta depth=__NUM_LINES
    #pragma HLS INTERFACE s_axilite port=data_in
    #pragma HLS INTERFACE s_axilite port=rho_out
    #pragma HLS INTERFACE s_axilite port=theta_out
    #pragma HLS INTERFACE s_axilite port=height
    #pragma HLS INTERFACE s_axilite port=width
    #pragma HLS INTERFACE s_axilite port=stride
    #pragma HLS INTERFACE s_axilite port=return

    unsigned char lower_thresh1[3] = {45, 89, 30};
    unsigned char lower_thresh2[3] = {45, 64, 89};
    unsigned char upper_thresh[3]  = {90, 255, 255};
    unsigned char rect7x7[49] = {
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1};
    unsigned char rect3x3[9] = {
        1, 1, 1,
        1, 1, 1,
        1, 1, 1};
    unsigned char cross3x3[9] = {
        0, 1, 0,
        1, 1, 1,
        0, 1, 0};

    xf::cv::Mat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1> mat_in(height, width);
    xf::cv::Mat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1> mat_blur(height, width);
    xf::cv::Mat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1> mat_hsv(height, width);
    xf::cv::Mat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1> mat_hsv1(height, width);
    xf::cv::Mat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1> mat_hsv2(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_green1(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_green2(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_green(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_dil_a(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_ero(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_ero1(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_ero2(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_lap1(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_lap2(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_lap(height, width);
    xf::cv::Mat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1> mat_dil_b(height, width);

    if (stride != -1) {
        int left = (stride - width) / 2;
        data_in += left;
    }

    #pragma HLS DATAFLOW
    xf::cv::Array2xfMat<PTRWIDTH, XF_8UC3, HEIGHT, WIDTH, XF_NPPC1>(data_in, mat_in, stride);
    xf::cv::GaussianBlur<XF_FILTER_3X3, XF_BORDER_CONSTANT, XF_8UC3, HEIGHT, WIDTH, XF_NPPC1>(
        mat_in, mat_blur, 1.0f);
    xf::cv::bgr2hsv<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1>(mat_blur, mat_hsv);
    xf::cv::duplicateMat<XF_8UC3, HEIGHT, WIDTH, XF_NPPC1>(mat_hsv, mat_hsv1, mat_hsv2);
    xf::cv::inRange<XF_8UC3, XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(
        mat_hsv1, lower_thresh1, upper_thresh, mat_green1);
    xf::cv::inRange<XF_8UC3, XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(
        mat_hsv2, lower_thresh2, upper_thresh, mat_green2);
    xf::cv::bitwise_or<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(mat_green1, mat_green2, mat_green);
    xf::cv::dilate<XF_BORDER_CONSTANT, XF_8UC1, HEIGHT, WIDTH, XF_SHAPE_RECT, 7, 7, 1, XF_NPPC1>(
        mat_green, mat_dil_a, rect7x7);
    xf::cv::erode<XF_BORDER_CONSTANT, XF_8UC1, HEIGHT, WIDTH, XF_SHAPE_RECT, 7, 7, 1, XF_NPPC1>(
        mat_dil_a, mat_ero, rect7x7);

    // instead of cv::Laplacian and cv::convertScaleAbs, we use cv::dilate ^ cv::erode
    xf::cv::duplicateMat<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(mat_ero, mat_ero1, mat_ero2);
    xf::cv::dilate<XF_BORDER_CONSTANT, XF_8UC1, HEIGHT, WIDTH, XF_SHAPE_CROSS, 3, 3, 1, XF_NPPC1>(
        mat_ero1, mat_lap1, cross3x3);
    xf::cv::erode<XF_BORDER_CONSTANT, XF_8UC1, HEIGHT, WIDTH, XF_SHAPE_CROSS, 3, 3, 1, XF_NPPC1>(
        mat_ero2, mat_lap2, cross3x3);
    xf::cv::bitwise_xor<XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(mat_lap1, mat_lap2, mat_lap);

    xf::cv::dilate<XF_BORDER_CONSTANT, XF_8UC1, HEIGHT, WIDTH, XF_SHAPE_RECT, 3, 3, 1, XF_NPPC1>(
        mat_lap, mat_dil_b, rect3x3);

    xf::cv::HoughLines<RHOSTEP, THETASTEP, LINESMAX, DIAGVAL, 0, 180, XF_8UC1, HEIGHT, WIDTH, XF_NPPC1>(
        mat_dil_b, rho_out, theta_out, THRESHOLD, LINESMAX);
}