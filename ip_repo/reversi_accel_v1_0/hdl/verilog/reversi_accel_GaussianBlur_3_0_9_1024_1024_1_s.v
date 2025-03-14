// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_GaussianBlur_3_0_9_1024_1024_1_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_src_rows_dout,
        p_src_rows_empty_n,
        p_src_rows_read,
        p_src_cols_dout,
        p_src_cols_empty_n,
        p_src_cols_read,
        mat_in_4228_dout,
        mat_in_4228_empty_n,
        mat_in_4228_read,
        mat_blur_4229_din,
        mat_blur_4229_full_n,
        mat_blur_4229_write
);

parameter    ap_ST_fsm_state1 = 21'd1;
parameter    ap_ST_fsm_state2 = 21'd2;
parameter    ap_ST_fsm_state3 = 21'd4;
parameter    ap_ST_fsm_state4 = 21'd8;
parameter    ap_ST_fsm_state5 = 21'd16;
parameter    ap_ST_fsm_state6 = 21'd32;
parameter    ap_ST_fsm_state7 = 21'd64;
parameter    ap_ST_fsm_state8 = 21'd128;
parameter    ap_ST_fsm_state9 = 21'd256;
parameter    ap_ST_fsm_state10 = 21'd512;
parameter    ap_ST_fsm_state11 = 21'd1024;
parameter    ap_ST_fsm_state12 = 21'd2048;
parameter    ap_ST_fsm_state13 = 21'd4096;
parameter    ap_ST_fsm_state14 = 21'd8192;
parameter    ap_ST_fsm_state15 = 21'd16384;
parameter    ap_ST_fsm_state16 = 21'd32768;
parameter    ap_ST_fsm_state17 = 21'd65536;
parameter    ap_ST_fsm_state18 = 21'd131072;
parameter    ap_ST_fsm_state19 = 21'd262144;
parameter    ap_ST_fsm_state20 = 21'd524288;
parameter    ap_ST_fsm_state21 = 21'd1048576;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] p_src_rows_dout;
input   p_src_rows_empty_n;
output   p_src_rows_read;
input  [31:0] p_src_cols_dout;
input   p_src_cols_empty_n;
output   p_src_cols_read;
input  [23:0] mat_in_4228_dout;
input   mat_in_4228_empty_n;
output   mat_in_4228_read;
output  [23:0] mat_blur_4229_din;
input   mat_blur_4229_full_n;
output   mat_blur_4229_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg p_src_rows_read;
reg p_src_cols_read;
reg mat_in_4228_read;
reg mat_blur_4229_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [20:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    p_src_rows_blk_n;
wire    ap_CS_fsm_state20;
reg    p_src_cols_blk_n;
wire   [31:0] grp_fu_93_p2;
reg   [31:0] sum_reg_142;
wire    ap_CS_fsm_state18;
wire   [15:0] trunc_ln1246_fu_111_p1;
reg   [15:0] trunc_ln1246_reg_153;
wire   [15:0] trunc_ln1246_1_fu_116_p1;
reg   [15:0] trunc_ln1246_1_reg_158;
reg   [1:0] cf_address0;
reg    cf_ce0;
reg    cf_we0;
reg   [31:0] cf_d0;
wire   [31:0] cf_q0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_done;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_idle;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_ready;
wire   [1:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_address0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_ce0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_we0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_d0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_sum_1_out;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_sum_1_out_ap_vld;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din1;
wire   [1:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_opcode;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_ce;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din1;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_ce;
wire  signed [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_din0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_ce;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_done;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_idle;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_ready;
wire   [1:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_address0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_ce0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_we0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_d0;
wire   [7:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_1_07_out;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_1_07_out_ap_vld;
wire   [7:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_0_06_out;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_0_06_out_ap_vld;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din1;
wire   [1:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_opcode;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_ce;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din0;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din1;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_ce;
wire   [31:0] grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_din0;
wire    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_ce;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_idle;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_ready;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_in_4228_read;
wire   [23:0] grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_din;
wire    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_write;
reg    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg;
reg    ap_block_state1_ignore_call10;
wire    ap_CS_fsm_state2;
reg    grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg;
wire    ap_CS_fsm_state19;
reg    grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg;
reg    ap_block_state20_ignore_call18;
wire    ap_CS_fsm_state21;
wire    ap_CS_fsm_state3;
reg    ap_block_state20;
wire   [31:0] grp_fu_163_p2;
reg   [31:0] grp_fu_163_p0;
reg   [31:0] grp_fu_163_p1;
reg   [1:0] grp_fu_163_opcode;
reg    grp_fu_163_ce;
wire   [31:0] grp_fu_167_p2;
reg   [31:0] grp_fu_167_p0;
reg   [31:0] grp_fu_167_p1;
reg    grp_fu_167_ce;
wire   [31:0] grp_fu_171_p1;
reg    grp_fu_171_ce;
wire   [31:0] grp_fu_174_p1;
reg    grp_fu_174_ce;
reg   [20:0] ap_NS_fsm;
reg    ap_block_state1;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ST_fsm_state8_blk;
wire    ap_ST_fsm_state9_blk;
wire    ap_ST_fsm_state10_blk;
wire    ap_ST_fsm_state11_blk;
wire    ap_ST_fsm_state12_blk;
wire    ap_ST_fsm_state13_blk;
wire    ap_ST_fsm_state14_blk;
wire    ap_ST_fsm_state15_blk;
wire    ap_ST_fsm_state16_blk;
wire    ap_ST_fsm_state17_blk;
wire    ap_ST_fsm_state18_blk;
reg    ap_ST_fsm_state19_blk;
reg    ap_ST_fsm_state20_blk;
reg    ap_ST_fsm_state21_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 21'd1;
#0 grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg = 1'b0;
#0 grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg = 1'b0;
#0 grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg = 1'b0;
end

reversi_accel_GaussianBlur_3_0_9_1024_1024_1_s_cf #(
    .DataWidth( 32 ),
    .AddressRange( 3 ),
    .AddressWidth( 2 ))
cf_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(cf_address0),
    .ce0(cf_ce0),
    .we0(cf_we0),
    .d0(cf_d0),
    .q0(cf_q0)
);

reversi_accel_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1 grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start),
    .ap_done(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_done),
    .ap_idle(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_idle),
    .ap_ready(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_ready),
    .cf_address0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_address0),
    .cf_ce0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_ce0),
    .cf_we0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_we0),
    .cf_d0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_d0),
    .sum_1_out(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_sum_1_out),
    .sum_1_out_ap_vld(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_sum_1_out_ap_vld),
    .grp_fu_163_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din0),
    .grp_fu_163_p_din1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din1),
    .grp_fu_163_p_opcode(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_opcode),
    .grp_fu_163_p_dout0(grp_fu_163_p2),
    .grp_fu_163_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_ce),
    .grp_fu_167_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din0),
    .grp_fu_167_p_din1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din1),
    .grp_fu_167_p_dout0(grp_fu_167_p2),
    .grp_fu_167_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_ce),
    .grp_fu_171_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_din0),
    .grp_fu_171_p_dout0(grp_fu_171_p1),
    .grp_fu_171_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_ce)
);

reversi_accel_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2 grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start),
    .ap_done(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_done),
    .ap_idle(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_idle),
    .ap_ready(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_ready),
    .cf_address0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_address0),
    .cf_ce0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_ce0),
    .cf_we0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_we0),
    .cf_d0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_d0),
    .cf_q0(cf_q0),
    .sum(sum_reg_142),
    .weights_1_07_out(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_1_07_out),
    .weights_1_07_out_ap_vld(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_1_07_out_ap_vld),
    .weights_0_06_out(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_0_06_out),
    .weights_0_06_out_ap_vld(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_0_06_out_ap_vld),
    .grp_fu_163_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din0),
    .grp_fu_163_p_din1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din1),
    .grp_fu_163_p_opcode(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_opcode),
    .grp_fu_163_p_dout0(grp_fu_163_p2),
    .grp_fu_163_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_ce),
    .grp_fu_167_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din0),
    .grp_fu_167_p_din1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din1),
    .grp_fu_167_p_dout0(grp_fu_167_p2),
    .grp_fu_167_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_ce),
    .grp_fu_174_p_din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_din0),
    .grp_fu_174_p_dout0(grp_fu_174_p1),
    .grp_fu_174_p_ce(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_ce)
);

reversi_accel_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start),
    .ap_done(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done),
    .ap_idle(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_idle),
    .ap_ready(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_ready),
    .mat_in_4228_dout(mat_in_4228_dout),
    .mat_in_4228_empty_n(mat_in_4228_empty_n),
    .mat_in_4228_read(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_in_4228_read),
    .mat_blur_4229_din(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_din),
    .mat_blur_4229_full_n(mat_blur_4229_full_n),
    .mat_blur_4229_write(grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_write),
    .img_height(trunc_ln1246_reg_153),
    .img_width(trunc_ln1246_1_reg_158),
    .p_read(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_0_06_out),
    .p_read1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_weights_1_07_out)
);

reversi_accel_fdiv_32ns_32ns_32_16_no_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 16 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
fdiv_32ns_32ns_32_16_no_dsp_1_U165(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(32'd1065353216),
    .din1(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_sum_1_out),
    .ce(1'b1),
    .dout(grp_fu_93_p2)
);

reversi_accel_faddfsub_32ns_32ns_32_5_full_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 5 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
faddfsub_32ns_32ns_32_5_full_dsp_1_U166(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_163_p0),
    .din1(grp_fu_163_p1),
    .opcode(grp_fu_163_opcode),
    .ce(grp_fu_163_ce),
    .dout(grp_fu_163_p2)
);

reversi_accel_fmul_32ns_32ns_32_4_max_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
fmul_32ns_32ns_32_4_max_dsp_1_U167(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_167_p0),
    .din1(grp_fu_167_p1),
    .ce(grp_fu_167_ce),
    .dout(grp_fu_167_p2)
);

reversi_accel_sitofp_32s_32_6_no_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 6 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
sitofp_32s_32_6_no_dsp_1_U168(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_din0),
    .ce(grp_fu_171_ce),
    .dout(grp_fu_171_p1)
);

reversi_accel_sitofp_32ns_32_6_no_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 6 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
sitofp_32ns_32_6_no_dsp_1_U169(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_din0),
    .ce(grp_fu_174_ce),
    .dout(grp_fu_174_p1)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state21) & (grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg <= 1'b0;
    end else begin
        if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg <= 1'b1;
        end else if ((grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_ready == 1'b1)) begin
            grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state18)) begin
            grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg <= 1'b1;
        end else if ((grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_ready == 1'b1)) begin
            grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg <= 1'b0;
    end else begin
        if ((~((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0)) & (1'b1 == ap_CS_fsm_state20))) begin
            grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg <= 1'b1;
        end else if ((grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_ready == 1'b1)) begin
            grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state18)) begin
        sum_reg_142 <= grp_fu_93_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        trunc_ln1246_1_reg_158 <= trunc_ln1246_1_fu_116_p1;
        trunc_ln1246_reg_153 <= trunc_ln1246_fu_111_p1;
    end
end

assign ap_ST_fsm_state10_blk = 1'b0;

assign ap_ST_fsm_state11_blk = 1'b0;

assign ap_ST_fsm_state12_blk = 1'b0;

assign ap_ST_fsm_state13_blk = 1'b0;

assign ap_ST_fsm_state14_blk = 1'b0;

assign ap_ST_fsm_state15_blk = 1'b0;

assign ap_ST_fsm_state16_blk = 1'b0;

assign ap_ST_fsm_state17_blk = 1'b0;

assign ap_ST_fsm_state18_blk = 1'b0;

always @ (*) begin
    if ((grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_done == 1'b0)) begin
        ap_ST_fsm_state19_blk = 1'b1;
    end else begin
        ap_ST_fsm_state19_blk = 1'b0;
    end
end

always @ (*) begin
    if (((ap_done_reg == 1'b1) | (ap_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0))) begin
        ap_ST_fsm_state20_blk = 1'b1;
    end else begin
        ap_ST_fsm_state20_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done == 1'b0)) begin
        ap_ST_fsm_state21_blk = 1'b1;
    end else begin
        ap_ST_fsm_state21_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

assign ap_ST_fsm_state3_blk = 1'b0;

assign ap_ST_fsm_state4_blk = 1'b0;

assign ap_ST_fsm_state5_blk = 1'b0;

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

assign ap_ST_fsm_state8_blk = 1'b0;

assign ap_ST_fsm_state9_blk = 1'b0;

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state21) & (grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done == 1'b1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state21) & (grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done == 1'b1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state19)) begin
        cf_address0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_address0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        cf_address0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_address0;
    end else begin
        cf_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state19)) begin
        cf_ce0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_ce0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        cf_ce0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_ce0;
    end else begin
        cf_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state19)) begin
        cf_d0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_d0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        cf_d0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_d0;
    end else begin
        cf_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state19)) begin
        cf_we0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_cf_we0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        cf_we0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_cf_we0;
    end else begin
        cf_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_163_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_ce;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_163_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_ce;
    end else begin
        grp_fu_163_ce = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_163_opcode = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_opcode;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_163_opcode = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_opcode;
    end else begin
        grp_fu_163_opcode = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_163_p0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din0;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_163_p0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din0;
    end else begin
        grp_fu_163_p0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_163_p1 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_163_p_din1;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_163_p1 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_163_p_din1;
    end else begin
        grp_fu_163_p1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_167_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_ce;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_167_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_ce;
    end else begin
        grp_fu_167_ce = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_167_p0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din0;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_167_p0 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din0;
    end else begin
        grp_fu_167_p0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_167_p1 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_167_p_din1;
    end else if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_167_p1 = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_167_p_din1;
    end else begin
        grp_fu_167_p1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) | (1'b1 == ap_CS_fsm_state2))) begin
        grp_fu_171_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_grp_fu_171_p_ce;
    end else begin
        grp_fu_171_ce = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state19))) begin
        grp_fu_174_ce = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_grp_fu_174_p_ce;
    end else begin
        grp_fu_174_ce = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        mat_blur_4229_write = grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_write;
    end else begin
        mat_blur_4229_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        mat_in_4228_read = grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_in_4228_read;
    end else begin
        mat_in_4228_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        p_src_cols_blk_n = p_src_cols_empty_n;
    end else begin
        p_src_cols_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0)) & (1'b1 == ap_CS_fsm_state20))) begin
        p_src_cols_read = 1'b1;
    end else begin
        p_src_cols_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state20)) begin
        p_src_rows_blk_n = p_src_rows_empty_n;
    end else begin
        p_src_rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0)) & (1'b1 == ap_CS_fsm_state20))) begin
        p_src_rows_read = 1'b1;
    end else begin
        p_src_rows_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state13;
        end
        ap_ST_fsm_state13 : begin
            ap_NS_fsm = ap_ST_fsm_state14;
        end
        ap_ST_fsm_state14 : begin
            ap_NS_fsm = ap_ST_fsm_state15;
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state16;
        end
        ap_ST_fsm_state16 : begin
            ap_NS_fsm = ap_ST_fsm_state17;
        end
        ap_ST_fsm_state17 : begin
            ap_NS_fsm = ap_ST_fsm_state18;
        end
        ap_ST_fsm_state18 : begin
            ap_NS_fsm = ap_ST_fsm_state19;
        end
        ap_ST_fsm_state19 : begin
            if (((1'b1 == ap_CS_fsm_state19) & (grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state20;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state19;
            end
        end
        ap_ST_fsm_state20 : begin
            if ((~((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0)) & (1'b1 == ap_CS_fsm_state20))) begin
                ap_NS_fsm = ap_ST_fsm_state21;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state20;
            end
        end
        ap_ST_fsm_state21 : begin
            if (((1'b1 == ap_CS_fsm_state21) & (grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state21;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state18 = ap_CS_fsm[32'd17];

assign ap_CS_fsm_state19 = ap_CS_fsm[32'd18];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state20 = ap_CS_fsm[32'd19];

assign ap_CS_fsm_state21 = ap_CS_fsm[32'd20];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_state1 = ((ap_done_reg == 1'b1) | (ap_start == 1'b0));
end

always @ (*) begin
    ap_block_state1_ignore_call10 = ((ap_done_reg == 1'b1) | (ap_start == 1'b0));
end

always @ (*) begin
    ap_block_state20 = ((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0));
end

always @ (*) begin
    ap_block_state20_ignore_call18 = ((p_src_cols_empty_n == 1'b0) | (p_src_rows_empty_n == 1'b0));
end

assign grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1_fu_66_ap_start_reg;

assign grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start = grp_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_58_2_fu_73_ap_start_reg;

assign grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start = grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_ap_start_reg;

assign mat_blur_4229_din = grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81_mat_blur_4229_din;

assign trunc_ln1246_1_fu_116_p1 = p_src_cols_dout[15:0];

assign trunc_ln1246_fu_111_p1 = p_src_rows_dout[15:0];

endmodule //reversi_accel_GaussianBlur_3_0_9_1024_1024_1_s
