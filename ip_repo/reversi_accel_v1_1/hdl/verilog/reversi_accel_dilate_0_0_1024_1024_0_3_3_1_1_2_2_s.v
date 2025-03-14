// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_dilate_0_0_1024_1024_0_3_3_1_1_2_2_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        p_read,
        p_read1,
        mat_lap_data337_dout,
        mat_lap_data337_num_data_valid,
        mat_lap_data337_fifo_cap,
        mat_lap_data337_empty_n,
        mat_lap_data337_read,
        mat_dil_b_data338_din,
        mat_dil_b_data338_num_data_valid,
        mat_dil_b_data338_fifo_cap,
        mat_dil_b_data338_full_n,
        mat_dil_b_data338_write
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] p_read;
input  [31:0] p_read1;
input  [7:0] mat_lap_data337_dout;
input  [1:0] mat_lap_data337_num_data_valid;
input  [1:0] mat_lap_data337_fifo_cap;
input   mat_lap_data337_empty_n;
output   mat_lap_data337_read;
output  [7:0] mat_dil_b_data338_din;
input  [1:0] mat_dil_b_data338_num_data_valid;
input  [1:0] mat_dil_b_data338_fifo_cap;
input   mat_dil_b_data338_full_n;
output   mat_dil_b_data338_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg mat_lap_data337_read;
reg mat_dil_b_data338_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [15:0] imgheight_fu_54_p1;
reg   [15:0] imgheight_reg_64;
wire   [15:0] imgwidth_fu_59_p1;
reg   [15:0] imgwidth_reg_69;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_idle;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_ready;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_lap_data337_read;
wire   [7:0] grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_din;
wire    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_write;
reg    grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg;
reg    ap_block_state1_ignore_call6;
wire    ap_CS_fsm_state2;
reg    ap_block_state1;
reg   [1:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg = 1'b0;
end

reversi_accel_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start),
    .ap_done(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done),
    .ap_idle(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_idle),
    .ap_ready(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_ready),
    .mat_lap_data337_dout(mat_lap_data337_dout),
    .mat_lap_data337_num_data_valid(2'd0),
    .mat_lap_data337_fifo_cap(2'd0),
    .mat_lap_data337_empty_n(mat_lap_data337_empty_n),
    .mat_lap_data337_read(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_lap_data337_read),
    .mat_dil_b_data338_din(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_din),
    .mat_dil_b_data338_num_data_valid(2'd0),
    .mat_dil_b_data338_fifo_cap(2'd0),
    .mat_dil_b_data338_full_n(mat_dil_b_data338_full_n),
    .mat_dil_b_data338_write(grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_write),
    .img_height(imgheight_reg_64),
    .img_width(imgwidth_reg_69),
    .p_read(1'd1),
    .p_read2(1'd1),
    .p_read6(1'd1),
    .p_read8(1'd1)
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
        end else if (((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg <= 1'b0;
    end else begin
        if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg <= 1'b1;
        end else if ((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_ready == 1'b1)) begin
            grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        imgheight_reg_64 <= imgheight_fu_54_p1;
        imgwidth_reg_69 <= imgwidth_fu_59_p1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if (((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
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
    if (((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        mat_dil_b_data338_write = grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_write;
    end else begin
        mat_dil_b_data338_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        mat_lap_data337_read = grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_lap_data337_read;
    end else begin
        mat_lap_data337_read = 1'b0;
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
            if (((grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call6 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start = grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_ap_start_reg;

assign imgheight_fu_54_p1 = p_read[15:0];

assign imgwidth_fu_59_p1 = p_read1[15:0];

assign mat_dil_b_data338_din = grp_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_s_fu_36_mat_dil_b_data338_din;

endmodule //reversi_accel_dilate_0_0_1024_1024_0_3_3_1_1_2_2_s
