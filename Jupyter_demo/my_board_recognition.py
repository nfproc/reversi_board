## Hardware-accelerated Reversi Board Detection on PYNQ Platform
## 2024.06.27 Naoki F., AIT
## New BSD License is applied. See LICENSE.txt for more details.

import os
import cv2
import numpy as np
import board_recognition as br
from time import perf_counter

# returns two points on the line determined by rho and theta
########################################################################
def getLineFromRhoTheta(rho, theta, origin_x, origin_y):
    a = np.cos(theta)
    b = np.sin(theta)
    x0 = a*rho + origin_x
    y0 = b*rho + origin_y
    x1 = int(x0 + 1000*(-b))
    y1 = int(y0 + 1000*(a))
    x2 = int(x0 - 1000*(-b))
    y2 = int(y0 - 1000*(a))
    return np.array([[x1, y1], [x2, y2]], dtype=np.float32)

# draw lines obtained by Hough transform (for debug)
########################################################################
def drawHoughLines(image, line_groups, origin_x, origin_y):
    # from OpenCV-Python tutorial
    # https://docs.opencv.org/3.4.18/d6/d10/tutorial_py_houghlines.html
    colors = [(0, 0, 255), (255, 0, 0), (192, 192, 0), (0, 192, 192)]
    for i in range(len(line_groups)):
        for line in line_groups[i]:
            rho, theta = line
            linepos = getLineFromRhoTheta(rho, theta, origin_x, origin_y)
            p0 = (int(linepos[0][0]), int(linepos[0][1]))
            p1 = (int(linepos[1][0]), int(linepos[1][1]))
            cv2.line(image, p0, p1, colors[i], 2)
            # x0 = np.cos(theta) * rho
            # y0 = np.sin(theta) * rho
            # if x0 < 50:
            #     y0 -= (50 - x0) / np.tan(theta)
            #     x0 = 50
            # if y0 < 50:
            #     x0 -= (50 - y0) * np.tan(theta)
            #     y0 = 50
            # txt = "%.1f, %.2f" % (rho, theta)
            # cv2.putText(image, txt, (int(x0), int(y0)), cv2.FONT_HERSHEY_SIMPLEX, 1, colors[i])
    return image

# update the average of theta and correct to be 0 <= theta <= pi
# (used in clusterLinesByTheta)
########################################################################
def updateThetaAverage(avg, l, theta):
    if (avg > np.pi * 3 / 4 and theta < np.pi / 4):
        avg = (avg * l + theta + np.pi) / (l + 1)
        if avg > np.pi:
            avg -= np.pi
    elif (avg < np.pi / 4 and theta > np.pi * 3 / 4):
        avg = (avg * l + theta - np.pi) / (l + 1)
        if avg < 0:
            avg += np.pi
    else:
        avg = (avg * l + theta) / (l + 1)
    return avg

# get the absolute difference of theta (used in clusterLinesByTheta)
####################################
def getAbsDiffTheta(t1, t2):
    # Θの差の絶対値を求める
    return abs(((t1 - t2 + np.pi * 3 / 2) % np.pi) - np.pi / 2)

# group lines with similar values of theta
####################################
def clusterLinesByTheta(lines):
    results = []
    theta_avgs = []
    for line in lines:
        rho, theta = line[0]
        group = len(theta_avgs)
        for i in range(len(theta_avgs)):
            if (getAbsDiffTheta(theta, theta_avgs[i]) < np.pi / 8): # 22.5 degree
                group = i
        if group == len(theta_avgs):
            results.append([])
            theta_avgs.append(0.0)
        theta_avgs[group] = updateThetaAverage(theta_avgs[group], len(results[group]), theta)
        results[group].append(line[0])

    # correction near theta = 0 (where sign of rho might not match)
    for i in range(len(results)):
        for j in range(len(results[i])):
            rho, theta = results[i][j]
            if abs(theta - theta_avgs[i]) > np.pi / 8:
                rho = -rho
                theta = theta + np.pi if theta < theta_avgs[i] else theta - np.pi
                results[i][j] = [rho, theta]
    return results, theta_avgs
    
# Find candidates of four sides of green region
########################################################################
def checkLineGroups(line_groups, thetas):
    results = []
    for i in range(len(line_groups)):
        for j in range(i + 1, len(line_groups)):
            if (len(line_groups[i]) > 1 and len(line_groups[j]) > 1 and
                getAbsDiffTheta(thetas[i], thetas[j]) > np.pi / 3):
                results.append(line_groups[i])
                results.append(line_groups[j])
    return results

# Find maximum and minimum values of rho (or their difference)
# Used in findRepresentativeLines to sort the groups of lines
########################################################################
def getMaxDistance(lines, maxmin=False):
    rhos = [line[0] for line in lines]
    if maxmin:
        return max(rhos), min(rhos)
    else:
        return max(rhos) - min(rhos)

# Find four lines that is the most likely to be four sides of green region
####################################
def findRepresentativeLines(line_groups):

    # Fail if failed in the previous steps
    if len(line_groups) < 2:
        return None

    # Extract a group with the largest difference between the maximum and the minimum of rho
    # Fail if the difference is too small
    line_groups = max(zip(line_groups[0::2], line_groups[1::2]),
        key=lambda x: getMaxDistance(x[0]) + getMaxDistance(x[1]))

    if getMaxDistance(line_groups[0]) < 200 or getMaxDistance(line_groups[1]) < 200:
        return None

    # Find two lines near the maximum and the minimum of rho, respectively
    result = [[] for i in range(2)]
    for i in range(2):
        rho_max, rho_min = getMaxDistance(line_groups[i], maxmin=True)
        smalls = []
        larges = []
        for line in line_groups[i]:
            if rho_max - line[0] < line[0] - rho_min:
                larges.append(line)
            else:
                smalls.append(line)
        if len(larges) == 0 or len(smalls) == 0:
            return None
        best_lines = max([(a, b) for a in larges for b in smalls],
            key=lambda x: (x[0][0] - x[1][0]) - getAbsDiffTheta(x[0][1], x[1][1]) * 200)
        result[i].append(best_lines[0])
        result[i].append(best_lines[1])
    return result

# Find corners of quadrangle from sides
########################################################################
def findVertices(line_groups, origin_x, origin_y):

    # Fail if failed at findRepresentativeLines
    if line_groups is None or len(line_groups) != 2:
        return False, None
    if len(line_groups[0]) != 2 or len(line_groups[0]) != 2:
        return False, None

    # Find corners
    lines = []
    for line_group in line_groups:
        for line in line_group:
            lines.append(getLineFromRhoTheta(line[0], line[1], origin_x, origin_y))
    vtx = []
    for i in range(4):
        vtx.append(br.intersection(lines[i // 2], lines[2 + (i % 2)]))

    # Sort corners (same as the original code)
    vtx.sort(key=lambda pt: pt[1])
    if vtx[0][0] > vtx[1][0]:
        vtx = [vtx[1], vtx[0], vtx[2], vtx[3]]
    if vtx[2][0] < vtx[3][0]:
        vtx = [vtx[0], vtx[1], vtx[3], vtx[2]]
    
    result = br.Result()
    result.vertex = vtx
    return True, result

# function corresponding to RealBoardRecognizer.detectBoard
########################################################################
def my_detectBoard(image, hint=None, debug=None, accel=None, version=1):
    height, width, _ = image.shape
    origin_x = width // 2  if accel is not None else 0
    origin_y = height // 2 if accel is not None else 0

    if version == 1: # Hough-only
        # Extract green region
        hsv = cv2.cvtColor(cv2.GaussianBlur(image, (3, 3), 1), cv2.COLOR_BGR2HSV)
        green = cv2.inRange(hsv, 
            np.array([45, int(256*0.35), int(256*0.12)]), 
            np.array([90, 255, 255]))
        green = cv2.bitwise_or(green, 
                    cv2.inRange(hsv, 
                        np.array([45, int(256*0.25), int(256*0.35)]), 
                        np.array([90, 255, 255])))
        green = cv2.dilate(green, np.ones((7, 7), dtype=np.uint8))
        green = cv2.erode(green, np.ones((7, 7), dtype=np.uint8))

        # Detect edge of green region (Laplacian filter)
        filter1 = np.array([[0, 1, 0], [1, -4, 1], [0, 1, 0]])
        filter2 = np.array([[0, -1, 0], [-1, 4, -1], [0, -1, 0]])
        edge = cv2.bitwise_or(
            cv2.filter2D(green, -1, filter1),
            cv2.filter2D(green, -1, filter2))
        edge = cv2.dilate(edge, np.ones((3, 3), dtype=np.uint8))
    else: # full
        edge = image

    # Hough transform and postprocessing
    if accel is None:
        lines = cv2.HoughLines(edge, 3, 3 * np.pi / 180, 500)
    else:
        lines = accel.start(edge)
    line_groups, thetas = clusterLinesByTheta(lines)
    line_groups = checkLineGroups(line_groups, thetas)
    if debug is not None and line_groups is not None:
        cv2.imwrite(debug, drawHoughLines(image, line_groups, origin_x, origin_y))
    line_groups = findRepresentativeLines(line_groups)

    # return the corners
    return findVertices(line_groups, origin_x, origin_y)
    
########################################################################
if __name__ == "__main__":
    os.system("mkdir -p test")
    os.system("rm -rf test/*")
    for i in range(100):
        readfile  = "images/image%03d.jpg" % (i + 1)
        writefile = "test/image%03d.jpg" % (i + 1)
        my_detectBoard(cv2.imread(readfile), debug=writefile)
        
########################################################################