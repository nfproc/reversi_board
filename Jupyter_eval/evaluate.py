## Hardware-accelerated Reversi Board Detection on PYNQ Platform
## 2024.06.27 Naoki F., AIT
## New BSD License is applied. See LICENSE.txt for more details.

from time import perf_counter
import numpy as np
import os
import cv2
import board_recognition as br
import my_board_recognition as mbr

# convert the recognition result to a string
########################################################################
def putresult(result):
    bd = np.zeros((8, 8), dtype=np.int8)
    bd[result.isUnknown == True] = 3
    for d in result.disc:
        bd[d.cell[0], d.cell[1]] = int(d.color) + 1
    outstr = ""
    for y in range(8):
        for x in range(8):
            # 0 (-): empty, 1 (X): black, 2 (O): white, 3 (?): unknown
            outstr += "-XO?"[bd[y, x]]
    return outstr

# returns the number of characters that match
########################################################################
def compareresult(outstr, ansstr):
    result = 0
    for o, a in zip(outstr, ansstr):
        if o == a:
            result += 1
    return result

# Draw the result
# (derived from example.py of lavox/reversi_recognition)
########################################################################
def drawresult(board, result, cell):
    # convert the result to a list (-2: unknown, -1: empty, 0: black, 1: white)
    size = cell * 8
    bd = np.ones((8, 8), dtype=np.int8) * -1
    bd[result.isUnknown == True] = -2
    for d in result.disc:
        # draw stones while updating the list
        if d.color == br.DiscColor.BLACK:
            color = (0, 0, 0)
            line = (255, 255, 255)
        else:
            color = (255, 255, 255)
            line = (0, 0, 0)
        bd[d.cell[0], d.cell[1]] = int(d.color)
        x = int(d.position[1] * size)
        y = int(d.position[0] * size)
        cv2.circle(board, (x, y), 8, line, -1)
        cv2.circle(board, (x, y), 7, color, -1)

    # draw empty and unknown cells
    for j in range(0, 8):
        for i in range(0, 8):
            x = int((i + 0.5) * cell)
            y = int((j + 0.5) * cell)
            if bd[j, i] == -1:
                # empty
                cv2.rectangle(board, (x - 4, y - 4), (x + 4, y + 4), (0, 255, 0), -1)
            elif bd[j, i] == -2:
                # unknown
                cv2.rectangle(board, (x - 4, y - 4), (x + 4, y + 4), (128, 128, 128), -1)
    return board

# Functions for time measurement
########################################################################
def updatetimer(total, oldtime):
    newtime = perf_counter()
    if oldtime is not None:
        total = total + (newtime - oldtime)
    return total, newtime

def starttimer():
    return updatetimer(0.0, None)

# Main function
########################################################################
def eval_main(num_board, answer = None, my_eval = True, accel = None, version = 1):
    if accel is None:
        print("** Accelerator is DISABLED **")
    else:
        print("** Accelerator is ENABLED **")
    os.system("mkdir -p results")
    os.system("rm -rf results/*")
    if answer is not None:
        answer_file = open(answer)

    total_read = total_board = total_disc = total_ext = total_draw = total_write = 0.0
    recognized = found_board = correct_stone = 0
    recognizer = br.RealBoardRecognizer()
    hint = br.Hint()
    hint.mode = br.Mode.PHOTO # photo mode

    for i in range(num_board):
        readfile  = "images/image%03d.jpg" % (i + 1)
        writefile = "results/image%03d.jpg" % (i + 1)
        debugfile = "results/debug%03d.jpg" % (i + 1)
        if answer is not None:
            answer_line = answer_file.readline()

        _, t = starttimer()
        image = cv2.imread(readfile)
        total_read, t = updatetimer(total_read, t)

        if my_eval:
            ret, result = mbr.my_detectBoard(image, hint, accel=accel, version=version)
        else:
            ret, result = recognizer.detectBoard(image, hint)
            
        total_board, t = updatetimer(total_board, t)
        if ret:
            found_board += 1
            ret, result = recognizer.detectDisc(image, hint, result)
            total_disc, t = updatetimer(total_disc, t)

        if ret:
            board = recognizer.extractBoard(image, result.vertex, (320, 320))
            total_ext, t = updatetimer(total_ext, t)
            board = drawresult(board, result, 40)
            total_draw, t = updatetimer(total_draw, t)
            cv2.imwrite(writefile, board)
            total_write, _ = updatetimer(total_write, t)
            recognized += 1
            if answer is None:
                print(putresult(result))
            else:
                correct_stone += compareresult(answer_line, putresult(result))
    
    grand_total = total_read + total_board + total_disc + total_ext + total_draw + total_write
    print("%5d boards (%6.2f%%) were recognized" % (recognized, recognized / num_board * 100))
    if answer is not None:
        print("%5d stones (%6.2f%%) were correct" % (correct_stone, correct_stone / recognized * 100 / 64))
    print("")
    print("Total time : %7.3f s (%8.3f ms/image)" % (grand_total, grand_total / num_board * 1000))
    print("  - Image Read   : %7.3f s (%8.3f ms/image)" % (total_read, total_read / num_board * 1000))
    print("  - Board Detect : %7.3f s (%8.3f ms/image)" % (total_board, total_board / num_board * 1000))
    print("  - Disc Detect  : %7.3f s (%8.3f ms/image)" % (total_disc, total_disc / found_board * 1000))
    print("  - Extraction   : %7.3f s (%8.3f ms/image)" % (total_ext, total_ext / recognized * 1000))
    print("  - Image Draw   : %7.3f s (%8.3f ms/image)" % (total_draw, total_draw / recognized * 1000))
    print("  - Image Write  : %7.3f s (%8.3f ms/image)" % (total_write, total_write / recognized * 1000))

if __name__ == "__main__":
    eval_main(100, "images/answers.txt")