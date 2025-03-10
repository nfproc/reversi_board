// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_addrbound (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        return_r,
        rows,
        cols
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [20:0] return_r;
input  [15:0] rows;
input  [15:0] cols;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[20:0] return_r;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_block_state1;
reg   [20:0] return_r_preg;
wire    ap_CS_fsm_state4;
wire   [25:0] shl_ln1524_fu_49_p0;
wire  signed [25:0] grp_fu_82_p2;
wire   [25:0] shl_ln1524_1_fu_54_p0;
wire   [25:0] shl_ln1524_fu_49_p2;
wire   [25:0] shl_ln1524_1_fu_54_p2;
wire   [25:0] ret_fu_59_p2;
wire   [25:0] add_ln573_fu_65_p2;
wire   [15:0] grp_fu_82_p0;
wire   [15:0] grp_fu_82_p1;
reg    grp_fu_82_ce;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire   [25:0] grp_fu_82_p00;
wire   [25:0] grp_fu_82_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 return_r_preg = 21'd0;
end

reversi_accel_mul_mul_16ns_16ns_26_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 16 ),
    .dout_WIDTH( 26 ))
mul_mul_16ns_16ns_26_4_1_U15(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_82_p0),
    .din1(grp_fu_82_p1),
    .ce(grp_fu_82_ce),
    .dout(grp_fu_82_p2)
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
        end else if ((1'b1 == ap_CS_fsm_state4)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        return_r_preg <= 21'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state4)) begin
            return_r_preg <= {{add_ln573_fu_65_p2[25:5]}};
        end
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

assign ap_ST_fsm_state3_blk = 1'b0;

assign ap_ST_fsm_state4_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
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
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1)))) begin
        grp_fu_82_ce = 1'b0;
    end else begin
        grp_fu_82_ce = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        return_r = {{add_ln573_fu_65_p2[25:5]}};
    end else begin
        return_r = return_r_preg;
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
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln573_fu_65_p2 = (ret_fu_59_p2 + 26'd31);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_fu_82_p0 = grp_fu_82_p00;

assign grp_fu_82_p00 = cols;

assign grp_fu_82_p1 = grp_fu_82_p10;

assign grp_fu_82_p10 = rows;

assign ret_fu_59_p2 = (shl_ln1524_fu_49_p2 - shl_ln1524_1_fu_54_p2);

assign shl_ln1524_1_fu_54_p0 = grp_fu_82_p2;

assign shl_ln1524_1_fu_54_p2 = shl_ln1524_1_fu_54_p0 << 26'd3;

assign shl_ln1524_fu_49_p0 = grp_fu_82_p2;

assign shl_ln1524_fu_49_p2 = shl_ln1524_fu_49_p0 << 26'd5;

endmodule //reversi_accel_addrbound
