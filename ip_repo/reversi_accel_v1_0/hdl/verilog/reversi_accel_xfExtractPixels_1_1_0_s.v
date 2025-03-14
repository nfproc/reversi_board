// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_xfExtractPixels_1_1_0_s (
        ap_ready,
        p_read1,
        ap_return
);


output   ap_ready;
input  [7:0] p_read1;
output  [7:0] ap_return;

assign ap_ready = 1'b1;

assign ap_return = p_read1;

endmodule //reversi_accel_xfExtractPixels_1_1_0_s
