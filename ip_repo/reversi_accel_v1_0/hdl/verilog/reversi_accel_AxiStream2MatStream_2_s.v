// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_AxiStream2MatStream_2_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        ldata1_dout,
        ldata1_empty_n,
        ldata1_read,
        mat_in_4228_din,
        mat_in_4228_full_n,
        mat_in_4228_write,
        rows_dout,
        rows_empty_n,
        rows_read,
        cols_bound_per_npc_dout,
        cols_bound_per_npc_empty_n,
        cols_bound_per_npc_read,
        last_blk_width,
        stride_dout,
        stride_empty_n,
        stride_read
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
input  [31:0] ldata1_dout;
input   ldata1_empty_n;
output   ldata1_read;
output  [23:0] mat_in_4228_din;
input   mat_in_4228_full_n;
output   mat_in_4228_write;
input  [31:0] rows_dout;
input   rows_empty_n;
output   rows_read;
input  [31:0] cols_bound_per_npc_dout;
input   cols_bound_per_npc_empty_n;
output   cols_bound_per_npc_read;
input  [3:0] last_blk_width;
input  [31:0] stride_dout;
input   stride_empty_n;
output   stride_read;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg ldata1_read;
reg mat_in_4228_write;
reg rows_read;
reg cols_bound_per_npc_read;
reg stride_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    rows_blk_n;
reg    cols_bound_per_npc_blk_n;
reg    stride_blk_n;
reg   [31:0] cols_bound_per_npc_read_reg_162;
reg  signed [31:0] rows_read_reg_168;
wire   [0:0] icmp_ln985_fu_88_p2;
reg   [0:0] icmp_ln985_reg_173;
wire  signed [31:0] stride_bound_per_npc_fu_94_p3;
reg  signed [31:0] stride_bound_per_npc_reg_178;
reg  signed [3:0] last_blk_width_read_reg_184;
wire    ap_CS_fsm_state2;
wire  signed [3:0] strideBased_last_blk_width_fu_114_p3;
reg   [3:0] strideBased_last_blk_width_reg_190;
wire    ap_CS_fsm_state3;
wire   [31:0] grp_fu_102_p2;
reg   [31:0] bound_reg_195;
wire   [31:0] sub_fu_129_p2;
reg   [31:0] sub_reg_200;
wire   [5:0] sub4_fu_135_p2;
reg   [5:0] sub4_reg_205;
wire   [31:0] sub26_fu_142_p2;
reg   [31:0] sub26_reg_210;
wire   [5:0] sub31_fu_148_p2;
reg   [5:0] sub31_reg_215;
wire   [5:0] add_ln1021_fu_155_p2;
reg   [5:0] add_ln1021_reg_220;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_idle;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read;
wire   [23:0] grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din;
wire    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write;
reg    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg;
wire    ap_CS_fsm_state4;
reg    ap_block_state1;
wire  signed [4:0] last_blk_width_cast_cast_cast_cast_cast_fu_107_p1;
wire  signed [4:0] sext_ln983_fu_121_p1;
wire   [5:0] zext_ln983_fu_125_p1;
wire   [5:0] last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg = 1'b0;
end

reversi_accel_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start),
    .ap_done(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done),
    .ap_idle(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_idle),
    .ap_ready(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready),
    .ldata1_dout(ldata1_dout),
    .ldata1_empty_n(ldata1_empty_n),
    .ldata1_read(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read),
    .mat_in_4228_din(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din),
    .mat_in_4228_full_n(mat_in_4228_full_n),
    .mat_in_4228_write(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write),
    .bound(bound_reg_195),
    .sub26(sub26_reg_210),
    .sext_ln1021(sub31_reg_215),
    .cols_bound_per_npc_load(cols_bound_per_npc_read_reg_162),
    .sub(sub_reg_200),
    .strideBased_last_blk_width(strideBased_last_blk_width_reg_190),
    .sub4(sub4_reg_205),
    .add_ln1021(add_ln1021_reg_220)
);

reversi_accel_mul_32s_32s_32_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_2_1_U40(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(rows_read_reg_168),
    .din1(stride_bound_per_npc_reg_178),
    .ce(1'b1),
    .dout(grp_fu_102_p2)
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
        end else if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= 1'b1;
        end else if ((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready == 1'b1)) begin
            grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        add_ln1021_reg_220 <= add_ln1021_fu_155_p2;
        bound_reg_195 <= grp_fu_102_p2;
        strideBased_last_blk_width_reg_190 <= strideBased_last_blk_width_fu_114_p3;
        sub26_reg_210 <= sub26_fu_142_p2;
        sub31_reg_215 <= sub31_fu_148_p2;
        sub4_reg_205 <= sub4_fu_135_p2;
        sub_reg_200 <= sub_fu_129_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        cols_bound_per_npc_read_reg_162 <= cols_bound_per_npc_dout;
        icmp_ln985_reg_173 <= icmp_ln985_fu_88_p2;
        rows_read_reg_168 <= rows_dout;
        stride_bound_per_npc_reg_178 <= stride_bound_per_npc_fu_94_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        last_blk_width_read_reg_184 <= last_blk_width;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
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
    if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cols_bound_per_npc_blk_n = cols_bound_per_npc_empty_n;
    end else begin
        cols_bound_per_npc_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cols_bound_per_npc_read = 1'b1;
    end else begin
        cols_bound_per_npc_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ldata1_read = grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read;
    end else begin
        ldata1_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        mat_in_4228_write = grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write;
    end else begin
        mat_in_4228_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_blk_n = rows_empty_n;
    end else begin
        rows_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        rows_read = 1'b1;
    end else begin
        rows_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        stride_blk_n = stride_empty_n;
    end else begin
        stride_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        stride_read = 1'b1;
    end else begin
        stride_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
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
            if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln1021_fu_155_p2 = (zext_ln983_fu_125_p1 + 6'd31);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (stride_empty_n == 1'b0) | (cols_bound_per_npc_empty_n == 1'b0) | (rows_empty_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start = grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg;

assign icmp_ln985_fu_88_p2 = ((stride_dout == 32'd4294967295) ? 1'b1 : 1'b0);

assign last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1 = $unsigned(last_blk_width_cast_cast_cast_cast_cast_fu_107_p1);

assign last_blk_width_cast_cast_cast_cast_cast_fu_107_p1 = last_blk_width_read_reg_184;

assign mat_in_4228_din = grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din;

assign sext_ln983_fu_121_p1 = strideBased_last_blk_width_fu_114_p3;

assign strideBased_last_blk_width_fu_114_p3 = ((icmp_ln985_reg_173[0:0] == 1'b1) ? last_blk_width_read_reg_184 : 4'd8);

assign stride_bound_per_npc_fu_94_p3 = ((icmp_ln985_fu_88_p2[0:0] == 1'b1) ? cols_bound_per_npc_dout : stride_dout);

assign sub26_fu_142_p2 = ($signed(cols_bound_per_npc_read_reg_162) + $signed(32'd4294967295));

assign sub31_fu_148_p2 = ($signed(last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1) + $signed(6'd63));

assign sub4_fu_135_p2 = ($signed(6'd32) - $signed(zext_ln983_fu_125_p1));

assign sub_fu_129_p2 = ($signed(stride_bound_per_npc_reg_178) + $signed(32'd4294967295));

assign zext_ln983_fu_125_p1 = $unsigned(sext_ln983_fu_121_p1);

endmodule //reversi_accel_AxiStream2MatStream_2_s
