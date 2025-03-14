// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_xferode_1024_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        mat_ero2_data334_dout,
        mat_ero2_data334_num_data_valid,
        mat_ero2_data334_fifo_cap,
        mat_ero2_data334_empty_n,
        mat_ero2_data334_read,
        mat_lap2_data336_din,
        mat_lap2_data336_num_data_valid,
        mat_lap2_data336_fifo_cap,
        mat_lap2_data336_full_n,
        mat_lap2_data336_write,
        add_ln1834,
        buf_V_8_address0,
        buf_V_8_ce0,
        buf_V_8_q0,
        buf_V_8_address1,
        buf_V_8_ce1,
        buf_V_8_we1,
        buf_V_8_d1,
        buf_V_address0,
        buf_V_ce0,
        buf_V_q0,
        buf_V_address1,
        buf_V_ce1,
        buf_V_we1,
        buf_V_d1,
        buf_V_7_address0,
        buf_V_7_ce0,
        buf_V_7_q0,
        buf_V_7_address1,
        buf_V_7_ce1,
        buf_V_7_we1,
        buf_V_7_d1,
        img_width,
        empty_54,
        empty_55,
        empty,
        p_cast,
        cmp_i_i142_i
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] mat_ero2_data334_dout;
input  [1:0] mat_ero2_data334_num_data_valid;
input  [1:0] mat_ero2_data334_fifo_cap;
input   mat_ero2_data334_empty_n;
output   mat_ero2_data334_read;
output  [7:0] mat_lap2_data336_din;
input  [1:0] mat_lap2_data336_num_data_valid;
input  [1:0] mat_lap2_data336_fifo_cap;
input   mat_lap2_data336_full_n;
output   mat_lap2_data336_write;
input  [13:0] add_ln1834;
output  [9:0] buf_V_8_address0;
output   buf_V_8_ce0;
input  [7:0] buf_V_8_q0;
output  [9:0] buf_V_8_address1;
output   buf_V_8_ce1;
output   buf_V_8_we1;
output  [7:0] buf_V_8_d1;
output  [9:0] buf_V_address0;
output   buf_V_ce0;
input  [7:0] buf_V_q0;
output  [9:0] buf_V_address1;
output   buf_V_ce1;
output   buf_V_we1;
output  [7:0] buf_V_d1;
output  [9:0] buf_V_7_address0;
output   buf_V_7_ce0;
input  [7:0] buf_V_7_q0;
output  [9:0] buf_V_7_address1;
output   buf_V_7_ce1;
output   buf_V_7_we1;
output  [7:0] buf_V_7_d1;
input  [15:0] img_width;
input  [12:0] empty_54;
input  [12:0] empty_55;
input  [12:0] empty;
input  [1:0] p_cast;
input  [0:0] cmp_i_i142_i;

reg ap_idle;
reg mat_ero2_data334_read;
reg mat_lap2_data336_write;
reg buf_V_8_ce0;
reg buf_V_8_ce1;
reg buf_V_8_we1;
reg[7:0] buf_V_8_d1;
reg buf_V_ce0;
reg buf_V_ce1;
reg buf_V_we1;
reg[7:0] buf_V_d1;
reg buf_V_7_ce0;
reg buf_V_7_ce1;
reg buf_V_7_we1;
reg[7:0] buf_V_7_d1;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] icmp_ln1073_reg_520;
reg   [0:0] icmp_ln1073_51_reg_524;
wire   [0:0] cmp_i_i142_i_read_reg_491;
reg    ap_predicate_op60_read_state2;
reg    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
reg   [0:0] icmp_ln1077_reg_543;
reg   [0:0] icmp_ln1077_reg_543_pp0_iter5_reg;
reg    ap_block_state7_pp0_stage0_iter6;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln1073_fu_307_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    mat_ero2_data334_blk_n;
wire    ap_block_pp0_stage0;
reg    mat_lap2_data336_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [1:0] p_cast_read_reg_495;
reg   [12:0] col_V_3_reg_514;
reg   [0:0] icmp_ln1073_reg_520_pp0_iter1_reg;
reg   [0:0] icmp_ln1073_reg_520_pp0_iter2_reg;
reg   [0:0] icmp_ln1073_reg_520_pp0_iter3_reg;
wire   [0:0] icmp_ln1073_51_fu_319_p2;
reg   [0:0] icmp_ln1073_51_reg_524_pp0_iter1_reg;
reg   [0:0] icmp_ln1073_51_reg_524_pp0_iter2_reg;
reg   [9:0] buf_V_8_addr_reg_528;
reg   [9:0] buf_V_addr_reg_533;
reg   [9:0] buf_V_7_addr_reg_538;
wire   [0:0] icmp_ln1077_fu_336_p2;
reg   [0:0] icmp_ln1077_reg_543_pp0_iter2_reg;
reg   [0:0] icmp_ln1077_reg_543_pp0_iter3_reg;
reg   [0:0] icmp_ln1077_reg_543_pp0_iter4_reg;
wire   [7:0] buf_cop_V_fu_341_p5;
wire   [7:0] buf_cop_V_8_fu_352_p5;
wire   [7:0] buf_cop_V_9_fu_363_p5;
reg   [7:0] ret_62_load_reg_562;
wire   [7:0] src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_return;
reg   [7:0] src_buf_temp_copy_extract_V_0_15_reg_568;
wire   [7:0] max_V_140_fu_406_p3;
reg   [7:0] max_V_140_reg_574;
wire   [7:0] max_V_143_fu_449_p3;
reg   [7:0] max_V_143_reg_580;
reg    ap_condition_exit_pp0_iter4_stage0;
wire    src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253_ap_ready;
wire   [7:0] src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253_ap_return;
wire    src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_ready;
wire    src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265_ap_ready;
wire   [7:0] src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265_ap_return;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_15_0_reg_220;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_15_0_reg_220;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_15_0_reg_220;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_15_0_reg_220;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_15_0_reg_220;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_231;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_231;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_231;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_231;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_231;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_10_reg_242;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_10_reg_242;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_10_reg_242;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_10_reg_242;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_10_reg_242;
wire   [63:0] conv_i99_i_fu_330_p1;
reg   [12:0] col_V_fu_88;
wire   [12:0] col_V_4_fu_313_p2;
wire    ap_loop_init;
reg   [12:0] ap_sig_allocacmp_col_V_3;
reg   [7:0] max_V_fu_92;
reg   [7:0] ret_fu_96;
reg   [7:0] ret_62_fu_100;
reg   [7:0] ret_63_fu_104;
reg    ap_block_pp0_stage0_01001;
wire   [13:0] zext_ln1073_3_fu_303_p1;
wire   [15:0] zext_ln1073_fu_299_p1;
wire   [0:0] icmp_ln1073_52_fu_386_p2;
wire   [7:0] max_V_139_fu_392_p3;
wire   [0:0] icmp_ln1073_53_fu_400_p2;
wire   [0:0] icmp_ln1073_54_fu_434_p2;
wire   [7:0] max_V_141_fu_438_p3;
wire   [0:0] icmp_ln1073_55_fu_444_p2;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg    ap_loop_exit_ready_pp0_iter4_reg;
reg    ap_loop_exit_ready_pp0_iter5_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
reg    ap_condition_273;
reg    ap_condition_501;
reg    ap_condition_505;
reg    ap_condition_508;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_done_reg = 1'b0;
end

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253(
    .ap_ready(src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_231),
    .ap_return(src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253_ap_return)
);

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259(
    .ap_ready(src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter4_buf_cop_V_15_0_reg_220),
    .ap_return(src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_return)
);

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265(
    .ap_ready(src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter4_buf_cop_V_10_reg_242),
    .ap_return(src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265_ap_return)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U400(
    .din0(buf_V_q0),
    .din1(buf_V_7_q0),
    .din2(buf_V_8_q0),
    .din3(empty_54),
    .dout(buf_cop_V_fu_341_p5)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U401(
    .din0(buf_V_q0),
    .din1(buf_V_7_q0),
    .din2(buf_V_8_q0),
    .din3(empty_55),
    .dout(buf_cop_V_8_fu_352_p5)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U402(
    .din0(buf_V_q0),
    .din1(buf_V_7_q0),
    .din2(buf_V_8_q0),
    .din3(empty),
    .dout(buf_cop_V_9_fu_363_p5)
);

reversi_accel_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter5_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter4_stage0)) begin
            ap_enable_reg_pp0_iter5 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_273)) begin
        if (((icmp_ln1073_fu_307_p2 == 1'd1) & (icmp_ln1073_51_fu_319_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_231 <= 8'd255;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_231 <= ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_231;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_273)) begin
        if (((icmp_ln1073_fu_307_p2 == 1'd1) & (icmp_ln1073_51_fu_319_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_10_reg_242 <= 8'd255;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_10_reg_242 <= ap_phi_reg_pp0_iter0_buf_cop_V_10_reg_242;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_273)) begin
        if (((icmp_ln1073_fu_307_p2 == 1'd1) & (icmp_ln1073_51_fu_319_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_15_0_reg_220 <= 8'd255;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_15_0_reg_220 <= ap_phi_reg_pp0_iter0_buf_cop_V_15_0_reg_220;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_51_reg_524_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_520_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_231 <= buf_cop_V_fu_341_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_231 <= ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_231;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_51_reg_524_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_520_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_10_reg_242 <= buf_cop_V_9_fu_363_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_10_reg_242 <= ap_phi_reg_pp0_iter3_buf_cop_V_10_reg_242;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_51_reg_524_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_520_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_15_0_reg_220 <= buf_cop_V_8_fu_352_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_15_0_reg_220 <= ap_phi_reg_pp0_iter3_buf_cop_V_15_0_reg_220;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln1073_fu_307_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            col_V_fu_88 <= col_V_4_fu_313_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            col_V_fu_88 <= 13'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            max_V_fu_92 <= 8'd255;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd1))) begin
            max_V_fu_92 <= src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_253_ap_return;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_62_fu_100 <= 8'd255;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd1))) begin
            ret_62_fu_100 <= src_buf_temp_copy_extract_V_0_16_xfExtractPixels_1_1_0_s_fu_265_ap_return;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_63_fu_104 <= 8'd255;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd1))) begin
            ret_63_fu_104 <= src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_return;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_fu_96 <= 8'd255;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd1))) begin
            ret_fu_96 <= ret_63_fu_104;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        col_V_3_reg_514 <= ap_sig_allocacmp_col_V_3;
        icmp_ln1073_51_reg_524_pp0_iter1_reg <= icmp_ln1073_51_reg_524;
        icmp_ln1073_reg_520 <= icmp_ln1073_fu_307_p2;
        icmp_ln1073_reg_520_pp0_iter1_reg <= icmp_ln1073_reg_520;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
        ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
        icmp_ln1073_51_reg_524_pp0_iter2_reg <= icmp_ln1073_51_reg_524_pp0_iter1_reg;
        icmp_ln1073_reg_520_pp0_iter2_reg <= icmp_ln1073_reg_520_pp0_iter1_reg;
        icmp_ln1073_reg_520_pp0_iter3_reg <= icmp_ln1073_reg_520_pp0_iter2_reg;
        icmp_ln1077_reg_543_pp0_iter2_reg <= icmp_ln1077_reg_543;
        icmp_ln1077_reg_543_pp0_iter3_reg <= icmp_ln1077_reg_543_pp0_iter2_reg;
        icmp_ln1077_reg_543_pp0_iter4_reg <= icmp_ln1077_reg_543_pp0_iter3_reg;
        icmp_ln1077_reg_543_pp0_iter5_reg <= icmp_ln1077_reg_543_pp0_iter4_reg;
        max_V_143_reg_580 <= max_V_143_fu_449_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_231 <= ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_231;
        ap_phi_reg_pp0_iter2_buf_cop_V_10_reg_242 <= ap_phi_reg_pp0_iter1_buf_cop_V_10_reg_242;
        ap_phi_reg_pp0_iter2_buf_cop_V_15_0_reg_220 <= ap_phi_reg_pp0_iter1_buf_cop_V_15_0_reg_220;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_231 <= ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_231;
        ap_phi_reg_pp0_iter3_buf_cop_V_10_reg_242 <= ap_phi_reg_pp0_iter2_buf_cop_V_10_reg_242;
        ap_phi_reg_pp0_iter3_buf_cop_V_15_0_reg_220 <= ap_phi_reg_pp0_iter2_buf_cop_V_15_0_reg_220;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        buf_V_7_addr_reg_538 <= conv_i99_i_fu_330_p1;
        buf_V_8_addr_reg_528 <= conv_i99_i_fu_330_p1;
        buf_V_addr_reg_533 <= conv_i99_i_fu_330_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1073_fu_307_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1073_51_reg_524 <= icmp_ln1073_51_fu_319_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_520 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1077_reg_543 <= icmp_ln1077_fu_336_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd1))) begin
        max_V_140_reg_574 <= max_V_140_fu_406_p3;
        ret_62_load_reg_562 <= ret_62_fu_100;
        src_buf_temp_copy_extract_V_0_15_reg_568 <= src_buf_temp_copy_extract_V_0_15_xfExtractPixels_1_1_0_s_fu_259_ap_return;
    end
end

always @ (*) begin
    if (((icmp_ln1073_fu_307_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_520_pp0_iter3_reg == 1'd0))) begin
        ap_condition_exit_pp0_iter4_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter4_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter5_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_col_V_3 = 13'd0;
    end else begin
        ap_sig_allocacmp_col_V_3 = col_V_fu_88;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_7_ce0 = 1'b1;
    end else begin
        buf_V_7_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd1)))) begin
        buf_V_7_ce1 = 1'b1;
    end else begin
        buf_V_7_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_501)) begin
        if ((cmp_i_i142_i == 1'd1)) begin
            buf_V_7_d1 = mat_ero2_data334_dout;
        end else if ((cmp_i_i142_i_read_reg_491 == 1'd0)) begin
            buf_V_7_d1 = 8'd255;
        end else begin
            buf_V_7_d1 = 'bx;
        end
    end else begin
        buf_V_7_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd1)))) begin
        buf_V_7_we1 = 1'b1;
    end else begin
        buf_V_7_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_8_ce0 = 1'b1;
    end else begin
        buf_V_8_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((~(p_cast_read_reg_495 == 2'd0) & ~(p_cast_read_reg_495 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(p_cast_read_reg_495 == 2'd0) & ~(p_cast_read_reg_495 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_8_ce1 = 1'b1;
    end else begin
        buf_V_8_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_505)) begin
        if ((cmp_i_i142_i == 1'd1)) begin
            buf_V_8_d1 = mat_ero2_data334_dout;
        end else if ((cmp_i_i142_i_read_reg_491 == 1'd0)) begin
            buf_V_8_d1 = 8'd255;
        end else begin
            buf_V_8_d1 = 'bx;
        end
    end else begin
        buf_V_8_d1 = 'bx;
    end
end

always @ (*) begin
    if (((~(p_cast_read_reg_495 == 2'd0) & ~(p_cast_read_reg_495 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(p_cast_read_reg_495 == 2'd0) & ~(p_cast_read_reg_495 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_8_we1 = 1'b1;
    end else begin
        buf_V_8_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_ce0 = 1'b1;
    end else begin
        buf_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd0)))) begin
        buf_V_ce1 = 1'b1;
    end else begin
        buf_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_508)) begin
        if ((cmp_i_i142_i == 1'd1)) begin
            buf_V_d1 = mat_ero2_data334_dout;
        end else if ((cmp_i_i142_i_read_reg_491 == 1'd0)) begin
            buf_V_d1 = 8'd255;
        end else begin
            buf_V_d1 = 'bx;
        end
    end else begin
        buf_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i142_i_read_reg_491 == 1'd0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd0)))) begin
        buf_V_we1 = 1'b1;
    end else begin
        buf_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_predicate_op60_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        mat_ero2_data334_blk_n = mat_ero2_data334_empty_n;
    end else begin
        mat_ero2_data334_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_predicate_op60_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        mat_ero2_data334_read = 1'b1;
    end else begin
        mat_ero2_data334_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (ap_enable_reg_pp0_iter6 == 1'b1))) begin
        mat_lap2_data336_blk_n = mat_lap2_data336_full_n;
    end else begin
        mat_lap2_data336_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (ap_enable_reg_pp0_iter6 == 1'b1))) begin
        mat_lap2_data336_write = 1'b1;
    end else begin
        mat_lap2_data336_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (mat_lap2_data336_full_n == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b1)) | ((ap_predicate_op60_read_state2 == 1'b1) & (mat_ero2_data334_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (mat_lap2_data336_full_n == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b1)) | ((ap_predicate_op60_read_state2 == 1'b1) & (mat_ero2_data334_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (mat_lap2_data336_full_n == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b1)) | ((ap_predicate_op60_read_state2 == 1'b1) & (mat_ero2_data334_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((ap_predicate_op60_read_state2 == 1'b1) & (mat_ero2_data334_empty_n == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state7_pp0_stage0_iter6 = ((icmp_ln1077_reg_543_pp0_iter5_reg == 1'd0) & (mat_lap2_data336_full_n == 1'b0));
end

always @ (*) begin
    ap_condition_273 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_501 = ((1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd1));
end

always @ (*) begin
    ap_condition_505 = (~(p_cast_read_reg_495 == 2'd0) & ~(p_cast_read_reg_495 == 2'd1) & (1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_508 = ((1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (p_cast_read_reg_495 == 2'd0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_231 = 'bx;

assign ap_phi_reg_pp0_iter0_buf_cop_V_10_reg_242 = 'bx;

assign ap_phi_reg_pp0_iter0_buf_cop_V_15_0_reg_220 = 'bx;

always @ (*) begin
    ap_predicate_op60_read_state2 = ((cmp_i_i142_i == 1'd1) & (icmp_ln1073_51_reg_524 == 1'd1) & (icmp_ln1073_reg_520 == 1'd1));
end

assign buf_V_7_address0 = buf_V_7_addr_reg_538;

assign buf_V_7_address1 = conv_i99_i_fu_330_p1;

assign buf_V_8_address0 = buf_V_8_addr_reg_528;

assign buf_V_8_address1 = conv_i99_i_fu_330_p1;

assign buf_V_address0 = buf_V_addr_reg_533;

assign buf_V_address1 = conv_i99_i_fu_330_p1;

assign cmp_i_i142_i_read_reg_491 = cmp_i_i142_i;

assign col_V_4_fu_313_p2 = (ap_sig_allocacmp_col_V_3 + 13'd1);

assign conv_i99_i_fu_330_p1 = col_V_3_reg_514;

assign icmp_ln1073_51_fu_319_p2 = ((zext_ln1073_fu_299_p1 < img_width) ? 1'b1 : 1'b0);

assign icmp_ln1073_52_fu_386_p2 = ((max_V_fu_92 > ret_fu_96) ? 1'b1 : 1'b0);

assign icmp_ln1073_53_fu_400_p2 = ((max_V_139_fu_392_p3 > ret_63_fu_104) ? 1'b1 : 1'b0);

assign icmp_ln1073_54_fu_434_p2 = ((max_V_140_reg_574 > src_buf_temp_copy_extract_V_0_15_reg_568) ? 1'b1 : 1'b0);

assign icmp_ln1073_55_fu_444_p2 = ((max_V_141_fu_438_p3 > ret_62_load_reg_562) ? 1'b1 : 1'b0);

assign icmp_ln1073_fu_307_p2 = ((zext_ln1073_3_fu_303_p1 < add_ln1834) ? 1'b1 : 1'b0);

assign icmp_ln1077_fu_336_p2 = ((col_V_3_reg_514 == 13'd0) ? 1'b1 : 1'b0);

assign mat_lap2_data336_din = max_V_143_reg_580;

assign max_V_139_fu_392_p3 = ((icmp_ln1073_52_fu_386_p2[0:0] == 1'b1) ? ret_fu_96 : max_V_fu_92);

assign max_V_140_fu_406_p3 = ((icmp_ln1073_53_fu_400_p2[0:0] == 1'b1) ? ret_63_fu_104 : max_V_139_fu_392_p3);

assign max_V_141_fu_438_p3 = ((icmp_ln1073_54_fu_434_p2[0:0] == 1'b1) ? src_buf_temp_copy_extract_V_0_15_reg_568 : max_V_140_reg_574);

assign max_V_143_fu_449_p3 = ((icmp_ln1073_55_fu_444_p2[0:0] == 1'b1) ? ret_62_load_reg_562 : max_V_141_fu_438_p3);

assign p_cast_read_reg_495 = p_cast;

assign zext_ln1073_3_fu_303_p1 = ap_sig_allocacmp_col_V_3;

assign zext_ln1073_fu_299_p1 = ap_sig_allocacmp_col_V_3;

endmodule //reversi_accel_xferode_1024_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop
