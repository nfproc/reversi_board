// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_Axi2Mat_Block_split4_proc (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        start_out,
        start_write,
        stride,
        cols,
        rows,
        rows_c_din,
        rows_c_full_n,
        rows_c_write,
        cols_c_din,
        cols_c_full_n,
        cols_c_write,
        stride_c_din,
        stride_c_full_n,
        stride_c_write,
        ap_return_0,
        ap_return_1
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   start_out;
output   start_write;
input  [31:0] stride;
input  [31:0] cols;
input  [31:0] rows;
output  [31:0] rows_c_din;
input   rows_c_full_n;
output   rows_c_write;
output  [31:0] cols_c_din;
input   cols_c_full_n;
output   cols_c_write;
output  [31:0] stride_c_din;
input   stride_c_full_n;
output   stride_c_write;
output  [15:0] ap_return_0;
output  [15:0] ap_return_1;

reg ap_done;
reg ap_idle;
reg start_write;
reg rows_c_write;
reg cols_c_write;
reg stride_c_write;
reg[15:0] ap_return_0;
reg[15:0] ap_return_1;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
reg    rows_c_blk_n;
reg    cols_c_blk_n;
reg    stride_c_blk_n;
reg    ap_block_state1;
wire   [0:0] icmp_ln1093_fu_76_p2;
wire   [15:0] trunc_ln1093_fu_82_p1;
wire   [15:0] trunc_ln1093_1_fu_86_p1;
wire   [15:0] cols_tmp_fu_90_p3;
wire   [15:0] empty_fu_98_p1;
reg   [15:0] ap_return_0_preg;
reg   [15:0] ap_return_1_preg;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_return_0_preg = 16'd0;
#0 ap_return_1_preg = 16'd0;
end

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
        end else if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_0_preg <= 16'd0;
    end else begin
        if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_return_0_preg <= cols_tmp_fu_90_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_1_preg <= 16'd0;
    end else begin
        if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_return_1_preg <= empty_fu_98_p1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((real_start == 1'b1) & (internal_ap_ready == 1'b0))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_return_0 = cols_tmp_fu_90_p3;
    end else begin
        ap_return_0 = ap_return_0_preg;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_return_1 = empty_fu_98_p1;
    end else begin
        ap_return_1 = ap_return_1_preg;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cols_c_blk_n = cols_c_full_n;
    end else begin
        cols_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cols_c_write = 1'b1;
    end else begin
        cols_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_full_n == 1'b0) & (start_once_reg == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_c_blk_n = rows_c_full_n;
    end else begin
        rows_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_c_write = 1'b1;
    end else begin
        rows_c_write = 1'b0;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (start_once_reg == 1'b0))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        stride_c_blk_n = stride_c_full_n;
    end else begin
        stride_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        stride_c_write = 1'b1;
    end else begin
        stride_c_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_state1 = ((real_start == 1'b0) | (stride_c_full_n == 1'b0) | (cols_c_full_n == 1'b0) | (rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign ap_ready = internal_ap_ready;

assign cols_c_din = cols;

assign cols_tmp_fu_90_p3 = ((icmp_ln1093_fu_76_p2[0:0] == 1'b1) ? trunc_ln1093_fu_82_p1 : trunc_ln1093_1_fu_86_p1);

assign empty_fu_98_p1 = rows[15:0];

assign icmp_ln1093_fu_76_p2 = ((stride == 32'd4294967295) ? 1'b1 : 1'b0);

assign rows_c_din = rows;

assign start_out = real_start;

assign stride_c_din = stride;

assign trunc_ln1093_1_fu_86_p1 = stride[15:0];

assign trunc_ln1093_fu_82_p1 = cols[15:0];

endmodule //reversi_accel_Axi2Mat_Block_split4_proc
