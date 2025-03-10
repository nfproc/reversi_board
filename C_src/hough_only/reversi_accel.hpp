// Reversi Board Detection for Vitis Vision
// 2022-12-27 Naoki F., AIT
// New BSD license is applied. See LICENSE.txt for more details.

// width of input pointer in bit
#define PTRWIDTH 8
// step of rho in pixel
#define RHOSTEP 3
// step of theta in 1/2 degree
#define THETASTEP 6
// maximum lines to detect
#define LINESMAX 32
// diagonal of image in RHOSTEP (1024 x sqrt(2) / RHOSTEP)
#define DIAGVAL 483
// height and width of image
#define HEIGHT 1024
#define WIDTH 1024
// threshold of votes
#define THRESHOLD 500
