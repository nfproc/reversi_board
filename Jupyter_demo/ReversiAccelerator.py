## Hardware-accelerated Reversi Board Detection on PYNQ Platform
## 2024.06.27 Naoki F., AIT
## New BSD License is applied. See LICENSE.txt for more details.

from pynq import Overlay
from pynq import allocate
from pynq import PL
from pynq.buffer import PynqBuffer
from PIL import Image
import numpy as np

# Accelerator and buffers in need
########################################################################
class ReversiAccelerator:
    def __init__(self, bitfile_name):
        PL.reset()              # make sure overlay cache is not used
        self.pl = Overlay(bitfile_name)
        self.accel = self.pl.reversi_accel_0
        self.rho   = allocate(shape=(32,), dtype=np.float32)
        self.theta = allocate(shape=(32,), dtype=np.float32)
        self.accel.write(0x1c, self.rho.device_address)   # rho_out
        self.accel.write(0x28, self.theta.device_address) # theta_out
        self.last_height = self.last_width = 0
        self.image = None
        
    def start(self, image):
        colored = (len(image.shape) == 3)
        copy = not isinstance(image, PynqBuffer)
        left = top = 0

        # Check the size of image and extract center if too large
        if colored:
            height, width, channel = image.shape
        else:
            height, width = image.shape
            channel = 1
        if width > 1024:
            left = (width - 1024) // 2
            width = 1024
        if height > 1024:
            top = (height - 1024) // 2
            height = 1024

        # Allocate buffers if needed
        if copy and (width != self.last_width or height != self.last_height):
            if self.image is not None:
                self.image.freebuffer()
            if colored:
                self.image = allocate(shape=(height, width, 3), dtype=np.uint8, cacheable=1)
            else:
                self.image = allocate(shape=(height, width), dtype=np.uint8, cacheable=1)
            self.last_width  = width
            self.last_height = height

        # Copy to buffer if image is not PynqBuffer
        if copy:
            self.image[:] = image[top : (top + height), left : (left + width)]
            stride = width
            addr = self.image.device_address
        else:
            stride = image.shape[1]
            addr = image.device_address + top * stride * channel

        # Launch the accelerator
        self.accel.write(0x44, stride)  # stride
        self.accel.write(0x3c, width)   # width
        self.accel.write(0x34, height)  # height
        self.rho[:] = self.theta[:] = np.zeros(32)
        self.accel.write(0x10, addr)
        self.accel.write(0x00, 1)       # ap_start
        while (self.accel.read(0x00) & 0x02) == 0x00: # ap_done
            pass
        last_rho = last_theta = 0.0
        lines = []
        for i in range(32):
            if self.rho[i] == last_rho and self.theta[i] == last_theta:
                break
            lines.append([(self.rho[i], self.theta[i])])
            last_rho = self.rho[i]
            last_theta = self.theta[i]
        return lines
        
########################################################################