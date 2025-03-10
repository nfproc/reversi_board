// Reversi Board Detection for Vitis Vision
// 2024-06-2x Naoki F., AIT
// New BSD license is applied. See LICENSE.txt for more details.

//#include "/tools/Xilinx/Vivado/2021.1/include/gmp.h"
#include <stdio.h>
#include <unistd.h>
#include <ap_int.h>
#include <vector>
#include <opencv2/opencv.hpp>
#include <opencv2/core/fast_math.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/imgcodecs/imgcodecs.hpp>
#include "reversi_accel.hpp"
#include "hough_software.hpp"

typedef ap_uint<PTRWIDTH> inimg_t;

// prototype of reversi_accel (reversi_accel.cpp)
void reversi_accel_soft(cv::Mat &image, float *rho_out, float *theta_out, int height, int width, int stride);
void reversi_accel(inimg_t *data_in, float *rho_out, float *theta_out, int height, int width, int stride);

////////////////////////////////////////////////////////////////////////
// Utility Functions
////////////////////////////////////////////////////////////////////////

// convert output of HoughLines into pair of arrays
void lines_to_rhos_thetas(std::vector<cv::Vec2f> &lines, float *rho_out, float *theta_out) {
    float last_rho = 0.0, last_theta = 0.0;
    for (int i = 0; i < LINESMAX; i++) {
        if (i < (int) lines.size()) {
            last_rho = lines[i][0];
            last_theta = lines[i][1];
        }
        rho_out[i] = last_rho;
        theta_out[i] = last_theta;
    }
}

// equivalent to getLineFromRhoTheta of the Python version
void get_line_from_rho_theta(float rho, float theta, cv::Point &pt1, cv::Point &pt2, int height, int width) {
    double a = cos(theta);
    double b = sin(theta);
    double x0 = a * rho + width / 2;
    double y0 = b * rho + height / 2;
    pt1.x = cvRound(x0 + 1000 * (-b));
    pt1.y = cvRound(y0 + 1000 * (a));
    pt2.x = cvRound(x0 - 1000 * (-b));
    pt2.y = cvRound(y0 - 1000 * (a));
}

// basically equivalent to drawHoughLines of the Python version
void draw_hough_lines(cv::Mat &image, float *rho_out, float *theta_out) {
    float last_rho = 0.0, last_theta = 0.0;
    cv::Point pt1, pt2;
    for (int i = 0; i < LINESMAX; i++) {
        if (last_rho == rho_out[i] && last_theta == theta_out[i]) {
            break;
        }
        last_rho = rho_out[i];
        last_theta = theta_out[i];
        get_line_from_rho_theta(last_rho, last_theta, pt1, pt2, image.rows, image.cols);
        cv::line(image, pt1, pt2, cv::Scalar(0, 0, 255), 2);
    }
}

// print out the rho-theta pairs
void print_hough_lines(float *rho_out, float *theta_out) {
    float last_rho = 0.0, last_theta = 0.0;
    for (int i = 0; i < LINESMAX; i++) {
        if (last_rho == rho_out[i] && last_theta == theta_out[i]) {
            break;
        }
        last_rho = rho_out[i];
        last_theta = theta_out[i];
        printf("[%3d] rho: %7.1f, theta: %7.4f\n", (int) i, last_rho, last_theta);
    }
}

// draw Hough lines on the input image and output
void output_image(const char *filename, cv::Mat &in_img, float *rho_out, float *theta_out) {
    cv::Mat out_img = in_img.clone();
    draw_hough_lines(out_img, rho_out, theta_out);
    print_hough_lines(rho_out, theta_out);
    cv::imwrite(filename, out_img);
}

////////////////////////////////////////////////////////////////////////
// Key Functions
////////////////////////////////////////////////////////////////////////

// basically equivalent to my_detectBoard of the Python version
void my_detect_board(cv::Mat &image, float *rho_out, float *theta_out, int is_hard) {
    if (! is_hard) {
        reversi_accel_soft(image, rho_out, theta_out, image.rows, image.cols, image.cols);
    } else {
        inimg_t *p = (inimg_t *) image.data;
        reversi_accel(p, rho_out, theta_out, image.rows, image.cols, image.cols);
    }
}

// software version of accelerator, for comparison
void reversi_accel_soft(cv::Mat &image, float *rho_out, float *theta_out, int height, int width, int stride) {
    cv::Mat crop, hsv, green, edge, tmp;
    cv::Mat kernel7x7, kernel3x3;
    kernel7x7 = getStructuringElement(cv::MORPH_RECT, cv::Size(7, 7), cv::Point(3, 3));
    kernel3x3 = getStructuringElement(cv::MORPH_RECT, cv::Size(3, 3), cv::Point(1, 1));

    if (stride != -1 && width != stride) {
        int left = (stride - width) / 2;
        crop = image(cv::Rect(left, 0, width, height));
    } else {
        crop = image;
    }

    // detect green region
    cv::GaussianBlur(crop, tmp, cv::Size(3, 3), 1);
    cv::cvtColor(tmp, hsv, cv::COLOR_BGR2HSV);
    cv::inRange(hsv, cv::Scalar(45, 89, 30), cv::Scalar(90, 255, 255), green);
    cv::inRange(hsv, cv::Scalar(45, 64, 89), cv::Scalar(90, 255, 255), tmp);
    cv::bitwise_or(green, tmp, green);
    cv::dilate(green, green, kernel7x7);
    cv::erode(green, green, kernel7x7);

    // detect edge of green region
    cv::Laplacian(green, edge, CV_16S);
    cv::convertScaleAbs(edge, edge);
    cv::dilate(edge, edge, kernel3x3);
    std::vector<cv::Vec2f> lines;
    xiHoughLinesstandard(edge, lines, 3.0, 3.0 * CV_PI / 180, 500, 32, 180, 0);
    lines_to_rhos_thetas(lines, rho_out, theta_out);
}

// the main routine of testbench
int main(int argc, char *argv[]) {
    cv::Mat in_img;
    float rhos[LINESMAX], thetas[LINESMAX];
    for (int i = 0; i < LINESMAX; i++) {
        rhos[i] = thetas[i] = 0.0;
    }
    
    chdir("../../../../");

    // check input
    if (argc != 2) {
        fprintf(stderr, "Usage: ./reversi_accel_tb <input_image>\n");
        return 1;
    }
    in_img = cv::imread(argv[1], 1);
    if (! in_img.data) {
        fprintf(stderr, "!! can't load image. stop.\n");
        return 1;
    }

    // software version
    printf("## executed by software\n");
    my_detect_board(in_img, rhos, thetas, 0);
    output_image("output_cv.png", in_img, rhos, thetas);
    rhos[0] = thetas[0] = 0.0;

    // hardware version
    printf("\n## executed by hardware\n");
    my_detect_board(in_img, rhos, thetas, 1);
    output_image("output_hls.png", in_img, rhos, thetas);
    
    return 0;
}

