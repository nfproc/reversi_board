// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_duplicateMat_0_1024_1024_1_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_read,
        p_read1,
        mat_ero_4237_dout,
        mat_ero_4237_empty_n,
        mat_ero_4237_read,
        mat_ero1_4238_din,
        mat_ero1_4238_full_n,
        mat_ero1_4238_write,
        mat_ero2_4239_din,
        mat_ero2_4239_full_n,
        mat_ero2_4239_write
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_state2 = 3'd2;
parameter    ap_ST_fsm_state3 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] p_read;
input  [31:0] p_read1;
input  [7:0] mat_ero_4237_dout;
input   mat_ero_4237_empty_n;
output   mat_ero_4237_read;
output  [7:0] mat_ero1_4238_din;
input   mat_ero1_4238_full_n;
output   mat_ero1_4238_write;
output  [7:0] mat_ero2_4239_din;
input   mat_ero2_4239_full_n;
output   mat_ero2_4239_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg mat_ero_4237_read;
reg mat_ero1_4238_write;
reg mat_ero2_4239_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [15:0] img_height_fu_65_p1;
reg   [15:0] img_height_reg_108;
wire   [15:0] img_width_fu_69_p1;
reg   [15:0] img_width_reg_113;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_done;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_idle;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_ready;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero_4237_read;
wire   [7:0] grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_din;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_write;
wire   [7:0] grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_din;
wire    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_write;
reg    grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln1057_fu_85_p2;
wire    ap_CS_fsm_state3;
reg   [12:0] row_V_fu_38;
wire   [12:0] row_V_15_fu_90_p2;
reg    ap_block_state1;
wire   [15:0] zext_ln1057_fu_81_p1;
reg   [2:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
reg    ap_ST_fsm_state3_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 3'd1;
#0 grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg = 1'b0;
end

reversi_accel_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start),
    .ap_done(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_done),
    .ap_idle(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_idle),
    .ap_ready(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_ready),
    .mat_ero_4237_dout(mat_ero_4237_dout),
    .mat_ero_4237_empty_n(mat_ero_4237_empty_n),
    .mat_ero_4237_read(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero_4237_read),
    .mat_ero1_4238_din(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_din),
    .mat_ero1_4238_full_n(mat_ero1_4238_full_n),
    .mat_ero1_4238_write(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_write),
    .mat_ero2_4239_din(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_din),
    .mat_ero2_4239_full_n(mat_ero2_4239_full_n),
    .mat_ero2_4239_write(grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_write),
    .img_width(img_width_reg_113)
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
        end else if (((icmp_ln1057_fu_85_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg <= 1'b0;
    end else begin
        if (((icmp_ln1057_fu_85_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
            grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg <= 1'b1;
        end else if ((grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_ready == 1'b1)) begin
            grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        row_V_fu_38 <= 13'd0;
    end else if (((icmp_ln1057_fu_85_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        row_V_fu_38 <= row_V_15_fu_90_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        img_height_reg_108 <= img_height_fu_65_p1;
        img_width_reg_113 <= img_width_fu_69_p1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

always @ (*) begin
    if ((grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_done == 1'b0)) begin
        ap_ST_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_fsm_state3_blk = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1057_fu_85_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
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
    if (((icmp_ln1057_fu_85_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        mat_ero1_4238_write = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_write;
    end else begin
        mat_ero1_4238_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        mat_ero2_4239_write = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_write;
    end else begin
        mat_ero2_4239_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        mat_ero_4237_read = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero_4237_read;
    end else begin
        mat_ero_4237_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((icmp_ln1057_fu_85_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_ap_start_reg;

assign icmp_ln1057_fu_85_p2 = ((zext_ln1057_fu_81_p1 < img_height_reg_108) ? 1'b1 : 1'b0);

assign img_height_fu_65_p1 = p_read[15:0];

assign img_width_fu_69_p1 = p_read1[15:0];

assign mat_ero1_4238_din = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero1_4238_din;

assign mat_ero2_4239_din = grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54_mat_ero2_4239_din;

assign row_V_15_fu_90_p2 = (row_V_fu_38 + 13'd1);

assign zext_ln1057_fu_81_p1 = row_V_fu_38;

endmodule //reversi_accel_duplicateMat_0_1024_1024_1_s
