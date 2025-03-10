## Hardware-accelerated Reversi Board Detection on PYNQ Platform
## 2024.06.27 Naoki F., AIT
## New BSD License is applied. See LICENSE.txt for more details.

import cv2
import numpy as np
import board_recognition as br

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

# draw the result of Hough transform to 'image'
########################################################################
def drawHoughLines(image, lines, origin_x, origin_y, color, scale=1, width=2):
    for line in lines:
        rho, theta = line[0] if hasattr(line[0], '__iter__') else line
        linepos = getLineFromRhoTheta(rho / scale, theta, origin_x, origin_y)
        p0 = (int(linepos[0][0]), int(linepos[0][1]))
        p1 = (int(linepos[1][0]), int(linepos[1][1]))
        cv2.line(image, p0, p1, color, width)
    return image

# draw a frame to 'image'
########################################################################
def drawFrames(image, base_w, base_h, frame_w, frame_h, color):
    top    = (base_h - frame_h) // 2
    left   = (base_w - frame_w) // 2
    bottom = top + frame_h
    right  = left + frame_w
    image[0:top,:] = 0
    image[bottom:base_h,:] = 0
    image[:,0:left] = 0
    image[:,right:base_w] = 0
    cv2.rectangle(image, (left, top), (right, bottom), color, 1)
    return image

# draw a circle (replaces cv2.circle for better look & feel)
########################################################################
def myCircle(image, pos, rad, color, fill):
    for y in range(-rad,rad+1):
        for x in range(-rad,rad+1):
            r2 = x * x + y * y
            if r2 >= rad * rad and r2 <= (rad + 1) * (rad + 1):
                image[pos[1]+y, pos[0]+x] = color
            elif r2 < rad * rad:
                image[pos[1]+y, pos[0]+x] = fill 

# draw a recognized board to 'image'
########################################################################
def drawresult(image, result, base_x, base_y, scale):
    # board
    image[base_y:(base_y + scale * 8), base_x:(base_x + scale * 8)] = 0x88
    for i in range(9):
        cv2.line(image, (base_x, base_y + i * scale), (base_x + 8 * scale, base_y + i * scale), 0x84, 1)
        cv2.line(image, (base_x + i * scale, base_y), (base_x + i * scale, base_y + 8 * scale), 0x84, 1)
    if result is None:
        return image
    
    bd = np.ones((8, 8), dtype=np.int8) * -1
    bd[result.isUnknown == True] = -2
    # stones
    for d in result.disc:
        color = 0x80 if d.color == br.DiscColor.BLACK else 0xff
        line  = 0xff if d.color == br.DiscColor.BLACK else 0x80
        bd[d.cell[0], d.cell[1]] = int(d.color)
        x = int(base_x + scale * d.cell[1] + scale // 2)
        y = int(base_y + scale * d.cell[0] + scale // 2)
        myCircle(image, (x, y), scale // 2 - 2, line, color)

    # empty or unknown cells
    for j in range(0, 8):
        for i in range(0, 8):
            x = int(base_x + scale * i + scale // 2)
            y = int(base_y + scale * j + scale // 2)
            d = scale // 6
            if bd[j, i] == -1:
                cv2.rectangle(image, (x - d, y - d), (x + d, y + d), 0x9c, -1)
            elif bd[j, i] == -2:
                cv2.rectangle(image, (x - d, y - d), (x + d, y + d), 0xb2, -1)
    return image
    
########################################################################