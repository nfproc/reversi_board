// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_entry_proc19 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rho_out,
        rho_out_c_din,
        rho_out_c_num_data_valid,
        rho_out_c_fifo_cap,
        rho_out_c_full_n,
        rho_out_c_write,
        theta_out,
        theta_out_c_din,
        theta_out_c_num_data_valid,
        theta_out_c_fifo_cap,
        theta_out_c_full_n,
        theta_out_c_write
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [63:0] rho_out;
output  [63:0] rho_out_c_din;
input  [4:0] rho_out_c_num_data_valid;
input  [4:0] rho_out_c_fifo_cap;
input   rho_out_c_full_n;
output   rho_out_c_write;
input  [63:0] theta_out;
output  [63:0] theta_out_c_din;
input  [4:0] theta_out_c_num_data_valid;
input  [4:0] theta_out_c_fifo_cap;
input   theta_out_c_full_n;
output   theta_out_c_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rho_out_c_write;
reg theta_out_c_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    rho_out_c_blk_n;
reg    theta_out_c_blk_n;
reg    ap_block_state1;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
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
        end else if ((~((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
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
    if ((~((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rho_out_c_blk_n = rho_out_c_full_n;
    end else begin
        rho_out_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rho_out_c_write = 1'b1;
    end else begin
        rho_out_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        theta_out_c_blk_n = theta_out_c_full_n;
    end else begin
        theta_out_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        theta_out_c_write = 1'b1;
    end else begin
        theta_out_c_write = 1'b0;
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
    ap_block_state1 = ((ap_start == 1'b0) | (theta_out_c_full_n == 1'b0) | (rho_out_c_full_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign rho_out_c_din = rho_out;

assign theta_out_c_din = theta_out;

endmodule //reversi_accel_entry_proc19
