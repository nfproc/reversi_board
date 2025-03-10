// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/COR)
//        bit 0 - ap_done (Read/COR)
//        bit 1 - ap_ready (Read/COR)
//        others - reserved
// 0x10 : Data signal of data_in
//        bit 31~0 - data_in[31:0] (Read/Write)
// 0x14 : Data signal of data_in
//        bit 31~0 - data_in[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of rho_out
//        bit 31~0 - rho_out[31:0] (Read/Write)
// 0x20 : Data signal of rho_out
//        bit 31~0 - rho_out[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of theta_out
//        bit 31~0 - theta_out[31:0] (Read/Write)
// 0x2c : Data signal of theta_out
//        bit 31~0 - theta_out[63:32] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of height
//        bit 31~0 - height[31:0] (Read/Write)
// 0x38 : reserved
// 0x3c : Data signal of width
//        bit 31~0 - width[31:0] (Read/Write)
// 0x40 : reserved
// 0x44 : Data signal of stride
//        bit 31~0 - stride[31:0] (Read/Write)
// 0x48 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL        0x00
#define XREVERSI_ACCEL_CONTROL_ADDR_GIE            0x04
#define XREVERSI_ACCEL_CONTROL_ADDR_IER            0x08
#define XREVERSI_ACCEL_CONTROL_ADDR_ISR            0x0c
#define XREVERSI_ACCEL_CONTROL_ADDR_DATA_IN_DATA   0x10
#define XREVERSI_ACCEL_CONTROL_BITS_DATA_IN_DATA   64
#define XREVERSI_ACCEL_CONTROL_ADDR_RHO_OUT_DATA   0x1c
#define XREVERSI_ACCEL_CONTROL_BITS_RHO_OUT_DATA   64
#define XREVERSI_ACCEL_CONTROL_ADDR_THETA_OUT_DATA 0x28
#define XREVERSI_ACCEL_CONTROL_BITS_THETA_OUT_DATA 64
#define XREVERSI_ACCEL_CONTROL_ADDR_HEIGHT_DATA    0x34
#define XREVERSI_ACCEL_CONTROL_BITS_HEIGHT_DATA    32
#define XREVERSI_ACCEL_CONTROL_ADDR_WIDTH_DATA     0x3c
#define XREVERSI_ACCEL_CONTROL_BITS_WIDTH_DATA     32
#define XREVERSI_ACCEL_CONTROL_ADDR_STRIDE_DATA    0x44
#define XREVERSI_ACCEL_CONTROL_BITS_STRIDE_DATA    32

