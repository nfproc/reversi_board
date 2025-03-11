Hardware-accelerated Reversi Board Detection on PYNQ Platform
=============================================================

Abstract
--------

This repository contains a reversi board detection circuit and its demo
systems that run on PYNQ-Z1, implemented and evaluated in the following 
paper:

> Naoki Fujieda and Naoya Ito: A case for edge video processing with FPGA
> SoC: reversi board detection using Hough transform, 12th International
> Workshop on Computer Systems and Architectures (CSA-12) held in
> conjunction with CANDAR '24, pp. 50-55 (11/2024).

Implementation and evaluation in the paper were conducted on the following
environment:
- Vitis HLS 2021.1
- Vitis video library 2021.1
- Vivado 2020.2
- PYNQ 2.6

Additionally, the authors confirmed operation on the following environment:
- Vitis HLS 2022.1
- Vitis video library 2024.2
- Vivado 2022.1
- PYNQ 3.0.1

Unfortunately, the systems cannot run properly on PYNQ 2.7. This version of
PYNQ has a bug that freed buffers cannot be reused. This results in running
out of memory.

------------------------------------------------------------------------

Organization of Repository
--------------------------

The hierarchy of the repository is as follows:

- `C_src`: C++ source code of the board detection circuit
  - `hough_only`: a version where only Hough transform is implemented
- `ip_repo`: IP cores for the system, including the high-level synthesized
  circuit
- `Jupyter_demo`: Jupyter Notebook for demonstration
- `Jupyter_eval`: Jupyter Notebook for performance evaluation
- `overlay`: Synthesized hardware overlays
  - `2020_2`: Synthesized by Vivado 2020.2
  - `2022_1`: Synthesized by Vivado 2022.1
- `vivado`: Script and constraint (xdc) file for block design generation

------------------------------------------------------------------------

How to Use
----------

### Preparation
#### OpenCV

To C-simulate a program using Vitis vision library on Vitis HLS, OpenCV
version 4.4.0 is required. This can be installed by the following commands.
Note that it assumes that OpenCV is installed to `vision/opencv-lib` of
the home directory. Replace `USERNAME` with your own username. If `vision`
folder is not created on the home directory, create it.

>     $ cd
>     $ cd vision
>     $ git clone --depth=1 -b 4.4.0 https://github.com/opencv/opencv.git
>     $ cd opencv
>     $ mkdir build; cd build
>     $ cmake -D WITH_IPP=OFF -D CMAKE_INSTALL_PREFIX=/home/USERNAME/vision/opencv-lib ..

Then, the LD_LIBRARY_PATH environmantal variable has to be modified in
order that the library is dynamically loaded on the simulation. The
following command is the case of bash. You can add it to .bashrc.

>     $ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/USERNAME/vision/opencv-lib

#### Vitis Vision library

Download the source code of the Vitis vision library. The following
commands assumes that version 2021.1 of the library is downloaded to
`vision/vitis_vision` of the home directory.

>     $ cd 
>     $ cd vision
>     $ git clone --depth=1 -b 2021.1 --no-checkout https://github.com/Xilinx/Vitis_Libraries.git
>     $ cd Vitis_Libraries
>     $ git sparse-checkout set vision
>     $ cd ..
>     $ mv Vitis_Libraries/vision vitis_vision
>     $ rm -rf Vitis_Libraries

#### Notice on creating projects

The project settings GUI of Vitis HLS 2021.1 or later has a bug regarding
translating absolute paths in CFLAGS to relative paths. It is required to
specify the include and link paths for each file as follows. However, if
we do so with GUI, absolute paths becomes wrong relative paths, which leads
to "no such file" errors.

- Project Settings -> Simulation -> CFLAGS
>     -I/home/USERNAME/vision/vitis_vision/L1/include -I/home/USERNAME/vision/opencv-lib/include/opencv4 -std=c++14 -Wno-unknown-pragmas
- Project Settings -> Simulation -> Linker Flags
>     -L /home/USERNAME/vision/opencv-lib/lib -lopencv_core -lopencv_imgcodecs -lopencv_imgproc
- Project Settings -> Synthesis -> CFLAGS (for .cpp file only)
>     -I/home/USERNAME/vision/vitis_vision/L1/include -std=c++14

There are two possible workarounds:
- Create a project, specify paths using Vitis HLS 2020.2, and then reopen
  that project with 2021.1 or later
- After specifying the paths with GUI, close Vitis HLS and edit `hls.app`
  to correct the paths by hand

### High Level Synthesis

Files in the `C_src` folder are used for high level synthsis. Create a
Vitis HLS project under the `C_src` folder. Add the source files
`reversi_accel.cpp` and `reversi_accel.hpp` as design files. Add
`reversi_accel_tb.cpp` and `hough_software.hpp` as testbench files.
The target function of the high level synthesis is reversi_accel.
Set CFLAGS and Linker Flags as explained above.

If you want to perform high-level synthesis only, just click "C Synthesis"
and "Export HDL." On exporting the IP core, we recommend to set the names
of vendor and library to `AIT` and `DSLab`, respectively. Also, the version
should be 1.0 when using version 2020.2 and 1.1 when using 2022.1.
Otherwise, you will have to modify the tcl file for block design creation.

To perform C simulation, specify the file name of an image of reversi
board. You can use `image080.jpg` as a sample.

After the C Simulation, you will see the following image files:
- output_cv.png: the output image of software (OpenCV)
- output_hls.png: the output image of hardware (algorithm to be high level
  synthesized)

If you wish to synthesize Hough transform only, copy the all files in the
`hough_only` folder to the `C_src` folder. Back up the files to be
overwritten if needed.

### Synthesis of Demonstration System

The demonstration system that includes the controller can be synthesized
with the following steps.

1. Create a Vivado project that targets PYNQ-Z1 (or Z2).
2. Open PROJECT MANAGER > Settings. From the Project Settings > IP >
   Repository tab, add `ip_repo` folder to the IP repositories.
3. Run the script `reversi_recognition_20XX_X.tcl` from Tools > Run Tcl
   Script. Use the script corresponding to the Vivado version. Block
   diagram will automatically created and validated. You can safely ignore
   critical warnings about invalid parameters.
4. From PROJECT MANAGER > Add Sources, add `pynq_hdmi.xdc` as constraint.
5. From the Sources tab, right-click Design Sources > design_1 and select
   Create HDL Wrapper.
6. "Generate Block Design" and "Generate Bitstream." You can safely ignore
   critical warnings about the dvi2rgb IP core.
7. Copy the generated bitstream file (.bit) and hardware hand-off file
   (.hwh) and rename as `reversi_hw.bit` and `reversi_hw.hwh`,
   respectively. If using PYNQ 3.0.1, the xsa file can also be used,
   which can be exported with File > Export > Export Hardware.
   In this case, make sure the "Include bitstream" option is selected.

### Running on real machine

This repository contains two Jupyter Notebooks for demonstation and
performance evaluation. Upload the whole folder to PYNQ, along with the
collected .bit and .hwh files (or .xsa file).

Then, open the .ipynb file in the Jupyter Notebook on PYNQ and run cells
according to the explanation on the notebook.

------------------------------------------------------------------------

Known issues
------------

As we described in the paper, board detection sometimes fails randomly
especially when only Hough transform is high level synthesized. We
thought that it came from a bug of the Vitis library. However, we could not
confirm that the issue was solved, even with version 2024.2 of the library.
We will continue looking for the cause.

Copyright
---------

The C source code in the `C_src` folder, the notebook in the `Jupyter_demo`
and `Jupyter_eval` folders, and Python files **except** `board_recognition.py`
are developed by <a href="https://aitech.ac.jp/~dslab/nf/index.en.html">Naoki FUJIEDA</a>.
Copyright is reserved by the Digital Systems Laboratory, Aichi Institute of
Technology. These files are licensed under the New BSD license.
The code includes contributions by Daikan Harada, Naoya Ito, and Kotaro
Hikosaka. All of these contributors are alumni of the lab.

The `axi_dynclk`，`dvi2rgb`，`rgb2dvi` IP cores and `tmds_v1_0` interface
definition in the `ip_repo` folder is a part of the Digilent Vivado library,
which are redistributed under the MIT license. The library is avaliable at:
> https://github.com/Digilent/vivado-library/

The `overlay` IP core in the `ip_repo` folder is a graphic overlay
controller, which is distributed in another repository. It is also the base
of the demonstrative system. The controller is available at:
> https://github.com/nfproc/HDMI_overlay/

The `hough_software.hpp` in the `C_src` folder is a part of the Vitis vision
library. We extract some of the codes for comparison in C simulation. The
repository of the library is as follows:
> https://github.com/xilinx/Vitis_Libraries/

The `board_recognition.py` file in the `Jupyter_demo` and `Jupyter_eval`
folders is a reversi board recognition program developed by lavox. It is
redistibuted under the MIT license. The program is available at:
> https://github.com/lavox/reversi_recognition
Its documentation (in Japanese) is available at:
> https://qiita.com/tanaka-a/items/fe6b95ae922b684021cc

See the LICENSE.txt file for more information.

Copyright (C) 2024-2025 Digital Systems Laboratory. All rights reserved.
