// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        mat_lap_data337_dout,
        mat_lap_data337_num_data_valid,
        mat_lap_data337_fifo_cap,
        mat_lap_data337_empty_n,
        mat_lap_data337_read,
        mat_dil_b_data338_din,
        mat_dil_b_data338_num_data_valid,
        mat_dil_b_data338_fifo_cap,
        mat_dil_b_data338_full_n,
        mat_dil_b_data338_write,
        add_ln1834,
        p_read,
        p_read2,
        p_read6,
        p_read8,
        buf_V_16_address0,
        buf_V_16_ce0,
        buf_V_16_q0,
        buf_V_16_address1,
        buf_V_16_ce1,
        buf_V_16_we1,
        buf_V_16_d1,
        buf_V_address0,
        buf_V_ce0,
        buf_V_q0,
        buf_V_address1,
        buf_V_ce1,
        buf_V_we1,
        buf_V_d1,
        buf_V_15_address0,
        buf_V_15_ce0,
        buf_V_15_q0,
        buf_V_15_address1,
        buf_V_15_ce1,
        buf_V_15_we1,
        buf_V_15_d1,
        img_width,
        empty_62,
        empty_63,
        empty,
        p_cast,
        cmp_i_i131_i
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
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
input  [13:0] add_ln1834;
input  [0:0] p_read;
input  [0:0] p_read2;
input  [0:0] p_read6;
input  [0:0] p_read8;
output  [9:0] buf_V_16_address0;
output   buf_V_16_ce0;
input  [7:0] buf_V_16_q0;
output  [9:0] buf_V_16_address1;
output   buf_V_16_ce1;
output   buf_V_16_we1;
output  [7:0] buf_V_16_d1;
output  [9:0] buf_V_address0;
output   buf_V_ce0;
input  [7:0] buf_V_q0;
output  [9:0] buf_V_address1;
output   buf_V_ce1;
output   buf_V_we1;
output  [7:0] buf_V_d1;
output  [9:0] buf_V_15_address0;
output   buf_V_15_ce0;
input  [7:0] buf_V_15_q0;
output  [9:0] buf_V_15_address1;
output   buf_V_15_ce1;
output   buf_V_15_we1;
output  [7:0] buf_V_15_d1;
input  [15:0] img_width;
input  [12:0] empty_62;
input  [12:0] empty_63;
input  [12:0] empty;
input  [1:0] p_cast;
input  [0:0] cmp_i_i131_i;

reg ap_idle;
reg mat_lap_data337_read;
reg mat_dil_b_data338_write;
reg buf_V_16_ce0;
reg buf_V_16_ce1;
reg buf_V_16_we1;
reg[7:0] buf_V_16_d1;
reg buf_V_ce0;
reg buf_V_ce1;
reg buf_V_we1;
reg[7:0] buf_V_d1;
reg buf_V_15_ce0;
reg buf_V_15_ce1;
reg buf_V_15_we1;
reg[7:0] buf_V_15_d1;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] icmp_ln1073_reg_700;
reg   [0:0] icmp_ln1073_59_reg_704;
wire   [0:0] cmp_i_i131_i_read_reg_651;
reg    ap_predicate_op69_read_state2;
reg    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
reg   [0:0] icmp_ln1077_reg_723;
reg   [0:0] icmp_ln1077_reg_723_pp0_iter6_reg;
reg    ap_block_state8_pp0_stage0_iter7;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln1073_fu_357_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    mat_lap_data337_blk_n;
wire    ap_block_pp0_stage0;
reg    mat_dil_b_data338_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [1:0] p_cast_read_reg_655;
wire   [0:0] p_read_1_reg_674;
wire   [0:0] p_read_2_reg_679;
wire   [0:0] p_read_3_reg_684;
reg   [12:0] col_V_7_reg_694;
reg   [0:0] icmp_ln1073_reg_700_pp0_iter1_reg;
reg   [0:0] icmp_ln1073_reg_700_pp0_iter2_reg;
reg   [0:0] icmp_ln1073_reg_700_pp0_iter3_reg;
reg   [0:0] icmp_ln1073_reg_700_pp0_iter4_reg;
reg   [0:0] icmp_ln1073_reg_700_pp0_iter5_reg;
wire   [0:0] icmp_ln1073_59_fu_369_p2;
reg   [0:0] icmp_ln1073_59_reg_704_pp0_iter1_reg;
reg   [0:0] icmp_ln1073_59_reg_704_pp0_iter2_reg;
reg   [9:0] buf_V_16_addr_reg_708;
reg   [9:0] buf_V_addr_reg_713;
reg   [9:0] buf_V_15_addr_reg_718;
wire   [0:0] icmp_ln1077_fu_386_p2;
reg   [0:0] icmp_ln1077_reg_723_pp0_iter2_reg;
reg   [0:0] icmp_ln1077_reg_723_pp0_iter3_reg;
reg   [0:0] icmp_ln1077_reg_723_pp0_iter4_reg;
reg   [0:0] icmp_ln1077_reg_723_pp0_iter5_reg;
wire   [7:0] buf_cop_V_fu_391_p5;
wire   [7:0] buf_cop_V_18_fu_402_p5;
wire   [7:0] buf_cop_V_19_fu_413_p5;
wire   [7:0] src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299_ap_return;
reg   [7:0] src_buf_temp_copy_extract_V_0_32_reg_742;
reg   [7:0] src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter5_reg;
reg   [7:0] src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter6_reg;
wire   [7:0] max_V_243_fu_465_p3;
reg   [7:0] max_V_243_reg_749;
wire   [7:0] src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_return;
reg   [7:0] src_buf_temp_copy_extract_V_0_31_reg_755;
wire   [7:0] max_V_245_fu_506_p3;
reg   [7:0] max_V_245_reg_760;
wire   [0:0] icmp_ln1081_51_fu_514_p2;
reg   [0:0] icmp_ln1081_51_reg_765;
wire   [7:0] max_V_248_fu_568_p3;
reg   [7:0] max_V_248_reg_770;
reg    ap_condition_exit_pp0_iter6_stage0;
wire    src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_ready;
wire   [7:0] src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_return;
wire    src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299_ap_ready;
wire    src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_ready;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_260;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_260;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_260;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_260;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_260;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_20_reg_271;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_20_reg_271;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_20_reg_271;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_20_reg_271;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_20_reg_271;
wire   [7:0] ap_phi_reg_pp0_iter0_buf_cop_V_35_0_reg_282;
reg   [7:0] ap_phi_reg_pp0_iter1_buf_cop_V_35_0_reg_282;
reg   [7:0] ap_phi_reg_pp0_iter2_buf_cop_V_35_0_reg_282;
reg   [7:0] ap_phi_reg_pp0_iter3_buf_cop_V_35_0_reg_282;
reg   [7:0] ap_phi_reg_pp0_iter4_buf_cop_V_35_0_reg_282;
reg   [7:0] ap_phi_reg_pp0_iter5_buf_cop_V_35_0_reg_282;
wire   [63:0] conv_i97_i_fu_380_p1;
reg   [12:0] col_V_fu_96;
wire   [12:0] col_V_8_fu_363_p2;
wire    ap_loop_init;
reg   [12:0] ap_sig_allocacmp_col_V_7;
reg   [7:0] src_buf_temp_med_apply_V_154_fu_100;
reg   [7:0] ret_fu_104;
reg   [7:0] ret_127_fu_108;
reg   [7:0] ret_128_fu_112;
reg   [7:0] ret_129_fu_116;
reg   [7:0] ret_130_fu_120;
reg    ap_block_pp0_stage0_01001;
wire   [13:0] zext_ln1073_8_fu_353_p1;
wire   [15:0] zext_ln1073_fu_349_p1;
wire   [7:0] max_V_fu_430_p3;
wire   [0:0] icmp_ln1081_fu_437_p2;
wire   [7:0] max_V_242_fu_443_p3;
wire   [0:0] icmp_ln1081_48_fu_451_p2;
wire   [7:0] select_ln56_fu_457_p3;
wire   [0:0] icmp_ln1081_49_fu_488_p2;
wire   [7:0] max_V_244_fu_493_p3;
wire   [0:0] icmp_ln1081_50_fu_500_p2;
wire   [7:0] max_V_246_fu_536_p3;
wire   [0:0] icmp_ln1081_52_fu_541_p2;
wire   [7:0] select_ln56_4_fu_547_p3;
wire   [7:0] max_V_247_fu_555_p3;
wire   [0:0] icmp_ln1081_53_fu_562_p2;
wire   [0:0] icmp_ln1081_54_fu_585_p2;
wire   [7:0] select_ln56_6_fu_589_p3;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg    ap_loop_exit_ready_pp0_iter4_reg;
reg    ap_loop_exit_ready_pp0_iter5_reg;
reg    ap_loop_exit_ready_pp0_iter6_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
reg    ap_condition_339;
reg    ap_condition_650;
reg    ap_condition_654;
reg    ap_condition_657;
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
#0 ap_enable_reg_pp0_iter7 = 1'b0;
#0 ap_done_reg = 1'b0;
end

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293(
    .ap_ready(src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_260),
    .ap_return(src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_return)
);

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299(
    .ap_ready(src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter4_buf_cop_V_20_reg_271),
    .ap_return(src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299_ap_return)
);

reversi_accel_xfExtractPixels_1_1_0_s src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305(
    .ap_ready(src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_ready),
    .p_read1(ap_phi_reg_pp0_iter5_buf_cop_V_35_0_reg_282),
    .ap_return(src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_return)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U360(
    .din0(buf_V_q0),
    .din1(buf_V_15_q0),
    .din2(buf_V_16_q0),
    .din3(empty_62),
    .dout(buf_cop_V_fu_391_p5)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U361(
    .din0(buf_V_q0),
    .din1(buf_V_15_q0),
    .din2(buf_V_16_q0),
    .din3(empty_63),
    .dout(buf_cop_V_18_fu_402_p5)
);

reversi_accel_mux_313_8_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 13 ),
    .dout_WIDTH( 8 ))
mux_313_8_1_1_U362(
    .din0(buf_V_q0),
    .din1(buf_V_15_q0),
    .din2(buf_V_16_q0),
    .din3(empty),
    .dout(buf_cop_V_19_fu_413_p5)
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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter6_reg == 1'b1))) begin
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
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
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
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter6_stage0)) begin
            ap_enable_reg_pp0_iter7 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_339)) begin
        if (((icmp_ln1073_fu_357_p2 == 1'd1) & (icmp_ln1073_59_fu_369_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_260 <= 8'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_260 <= ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_260;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_339)) begin
        if (((icmp_ln1073_fu_357_p2 == 1'd1) & (icmp_ln1073_59_fu_369_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_20_reg_271 <= 8'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_20_reg_271 <= ap_phi_reg_pp0_iter0_buf_cop_V_20_reg_271;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_339)) begin
        if (((icmp_ln1073_fu_357_p2 == 1'd1) & (icmp_ln1073_59_fu_369_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_35_0_reg_282 <= 8'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_buf_cop_V_35_0_reg_282 <= ap_phi_reg_pp0_iter0_buf_cop_V_35_0_reg_282;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_59_reg_704_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_700_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_260 <= buf_cop_V_fu_391_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_0_reg_260 <= ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_260;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_59_reg_704_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_700_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_20_reg_271 <= buf_cop_V_19_fu_413_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_20_reg_271 <= ap_phi_reg_pp0_iter3_buf_cop_V_20_reg_271;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        if (((icmp_ln1073_59_reg_704_pp0_iter2_reg == 1'd1) & (icmp_ln1073_reg_700_pp0_iter2_reg == 1'd1))) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_35_0_reg_282 <= buf_cop_V_18_fu_402_p5;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter4_buf_cop_V_35_0_reg_282 <= ap_phi_reg_pp0_iter3_buf_cop_V_35_0_reg_282;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln1073_fu_357_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            col_V_fu_96 <= col_V_8_fu_363_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            col_V_fu_96 <= 13'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_127_fu_108 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter6 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter5_reg == 1'd1))) begin
            ret_127_fu_108 <= ret_130_fu_120;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_128_fu_112 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter3_reg == 1'd1))) begin
            ret_128_fu_112 <= src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_return;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_129_fu_116 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter5 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter4_reg == 1'd1))) begin
            ret_129_fu_116 <= src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_return;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_130_fu_120 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter6 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter5_reg == 1'd1))) begin
            ret_130_fu_120 <= src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter5_reg;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ret_fu_104 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter5 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter4_reg == 1'd1))) begin
            ret_fu_104 <= ret_129_fu_116;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            src_buf_temp_med_apply_V_154_fu_100 <= 8'd0;
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter3_reg == 1'd1))) begin
            src_buf_temp_med_apply_V_154_fu_100 <= ret_128_fu_112;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        col_V_7_reg_694 <= ap_sig_allocacmp_col_V_7;
        icmp_ln1073_59_reg_704_pp0_iter1_reg <= icmp_ln1073_59_reg_704;
        icmp_ln1073_reg_700 <= icmp_ln1073_fu_357_p2;
        icmp_ln1073_reg_700_pp0_iter1_reg <= icmp_ln1073_reg_700;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
        ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
        ap_loop_exit_ready_pp0_iter6_reg <= ap_loop_exit_ready_pp0_iter5_reg;
        icmp_ln1073_59_reg_704_pp0_iter2_reg <= icmp_ln1073_59_reg_704_pp0_iter1_reg;
        icmp_ln1073_reg_700_pp0_iter2_reg <= icmp_ln1073_reg_700_pp0_iter1_reg;
        icmp_ln1073_reg_700_pp0_iter3_reg <= icmp_ln1073_reg_700_pp0_iter2_reg;
        icmp_ln1073_reg_700_pp0_iter4_reg <= icmp_ln1073_reg_700_pp0_iter3_reg;
        icmp_ln1073_reg_700_pp0_iter5_reg <= icmp_ln1073_reg_700_pp0_iter4_reg;
        icmp_ln1077_reg_723_pp0_iter2_reg <= icmp_ln1077_reg_723;
        icmp_ln1077_reg_723_pp0_iter3_reg <= icmp_ln1077_reg_723_pp0_iter2_reg;
        icmp_ln1077_reg_723_pp0_iter4_reg <= icmp_ln1077_reg_723_pp0_iter3_reg;
        icmp_ln1077_reg_723_pp0_iter5_reg <= icmp_ln1077_reg_723_pp0_iter4_reg;
        icmp_ln1077_reg_723_pp0_iter6_reg <= icmp_ln1077_reg_723_pp0_iter5_reg;
        src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter5_reg <= src_buf_temp_copy_extract_V_0_32_reg_742;
        src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter6_reg <= src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter5_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_260 <= ap_phi_reg_pp0_iter1_buf_cop_V_0_reg_260;
        ap_phi_reg_pp0_iter2_buf_cop_V_20_reg_271 <= ap_phi_reg_pp0_iter1_buf_cop_V_20_reg_271;
        ap_phi_reg_pp0_iter2_buf_cop_V_35_0_reg_282 <= ap_phi_reg_pp0_iter1_buf_cop_V_35_0_reg_282;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_phi_reg_pp0_iter3_buf_cop_V_0_reg_260 <= ap_phi_reg_pp0_iter2_buf_cop_V_0_reg_260;
        ap_phi_reg_pp0_iter3_buf_cop_V_20_reg_271 <= ap_phi_reg_pp0_iter2_buf_cop_V_20_reg_271;
        ap_phi_reg_pp0_iter3_buf_cop_V_35_0_reg_282 <= ap_phi_reg_pp0_iter2_buf_cop_V_35_0_reg_282;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1))) begin
        ap_phi_reg_pp0_iter5_buf_cop_V_35_0_reg_282 <= ap_phi_reg_pp0_iter4_buf_cop_V_35_0_reg_282;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        buf_V_15_addr_reg_718 <= conv_i97_i_fu_380_p1;
        buf_V_16_addr_reg_708 <= conv_i97_i_fu_380_p1;
        buf_V_addr_reg_713 <= conv_i97_i_fu_380_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1073_fu_357_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1073_59_reg_704 <= icmp_ln1073_59_fu_369_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_700 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1077_reg_723 <= icmp_ln1077_fu_386_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_700_pp0_iter4_reg == 1'd1))) begin
        icmp_ln1081_51_reg_765 <= icmp_ln1081_51_fu_514_p2;
        max_V_245_reg_760 <= max_V_245_fu_506_p3;
        src_buf_temp_copy_extract_V_0_31_reg_755 <= src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_return;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_700_pp0_iter3_reg == 1'd1))) begin
        max_V_243_reg_749 <= max_V_243_fu_465_p3;
        src_buf_temp_copy_extract_V_0_32_reg_742 <= src_buf_temp_copy_extract_V_0_32_xfExtractPixels_1_1_0_s_fu_299_ap_return;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1073_reg_700_pp0_iter5_reg == 1'd1))) begin
        max_V_248_reg_770 <= max_V_248_fu_568_p3;
    end
end

always @ (*) begin
    if (((icmp_ln1073_fu_357_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter6 == 1'b1) & (icmp_ln1073_reg_700_pp0_iter5_reg == 1'd0))) begin
        ap_condition_exit_pp0_iter6_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter6_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter6_reg == 1'b1))) begin
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
    if (((ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
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
        ap_sig_allocacmp_col_V_7 = 13'd0;
    end else begin
        ap_sig_allocacmp_col_V_7 = col_V_fu_96;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_15_ce0 = 1'b1;
    end else begin
        buf_V_15_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_15_ce1 = 1'b1;
    end else begin
        buf_V_15_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_650)) begin
        if ((cmp_i_i131_i == 1'd1)) begin
            buf_V_15_d1 = mat_lap_data337_dout;
        end else if ((cmp_i_i131_i_read_reg_651 == 1'd0)) begin
            buf_V_15_d1 = 8'd0;
        end else begin
            buf_V_15_d1 = 'bx;
        end
    end else begin
        buf_V_15_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_15_we1 = 1'b1;
    end else begin
        buf_V_15_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        buf_V_16_ce0 = 1'b1;
    end else begin
        buf_V_16_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((~(p_cast_read_reg_655 == 2'd0) & ~(p_cast_read_reg_655 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(p_cast_read_reg_655 == 2'd0) & ~(p_cast_read_reg_655 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_16_ce1 = 1'b1;
    end else begin
        buf_V_16_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_654)) begin
        if ((cmp_i_i131_i == 1'd1)) begin
            buf_V_16_d1 = mat_lap_data337_dout;
        end else if ((cmp_i_i131_i_read_reg_651 == 1'd0)) begin
            buf_V_16_d1 = 8'd0;
        end else begin
            buf_V_16_d1 = 'bx;
        end
    end else begin
        buf_V_16_d1 = 'bx;
    end
end

always @ (*) begin
    if (((~(p_cast_read_reg_655 == 2'd0) & ~(p_cast_read_reg_655 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(p_cast_read_reg_655 == 2'd0) & ~(p_cast_read_reg_655 == 2'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_16_we1 = 1'b1;
    end else begin
        buf_V_16_we1 = 1'b0;
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
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_ce1 = 1'b1;
    end else begin
        buf_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_657)) begin
        if ((cmp_i_i131_i == 1'd1)) begin
            buf_V_d1 = mat_lap_data337_dout;
        end else if ((cmp_i_i131_i_read_reg_651 == 1'd0)) begin
            buf_V_d1 = 8'd0;
        end else begin
            buf_V_d1 = 'bx;
        end
    end else begin
        buf_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (cmp_i_i131_i_read_reg_651 == 1'd0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf_V_we1 = 1'b1;
    end else begin
        buf_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (ap_enable_reg_pp0_iter7 == 1'b1))) begin
        mat_dil_b_data338_blk_n = mat_dil_b_data338_full_n;
    end else begin
        mat_dil_b_data338_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (ap_enable_reg_pp0_iter7 == 1'b1))) begin
        mat_dil_b_data338_write = 1'b1;
    end else begin
        mat_dil_b_data338_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_predicate_op69_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        mat_lap_data337_blk_n = mat_lap_data337_empty_n;
    end else begin
        mat_lap_data337_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_predicate_op69_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        mat_lap_data337_read = 1'b1;
    end else begin
        mat_lap_data337_read = 1'b0;
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
    ap_block_pp0_stage0_01001 = (((icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (mat_dil_b_data338_full_n == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1)) | ((ap_predicate_op69_read_state2 == 1'b1) & (mat_lap_data337_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (mat_dil_b_data338_full_n == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1)) | ((ap_predicate_op69_read_state2 == 1'b1) & (mat_lap_data337_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (mat_dil_b_data338_full_n == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1)) | ((ap_predicate_op69_read_state2 == 1'b1) & (mat_lap_data337_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((ap_predicate_op69_read_state2 == 1'b1) & (mat_lap_data337_empty_n == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state8_pp0_stage0_iter7 = ((icmp_ln1077_reg_723_pp0_iter6_reg == 1'd0) & (mat_dil_b_data338_full_n == 1'b0));
end

always @ (*) begin
    ap_condition_339 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_650 = ((1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_654 = (~(p_cast_read_reg_655 == 2'd0) & ~(p_cast_read_reg_655 == 2'd1) & (1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_657 = ((1'b0 == ap_block_pp0_stage0) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (p_cast_read_reg_655 == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign ap_phi_reg_pp0_iter0_buf_cop_V_0_reg_260 = 'bx;

assign ap_phi_reg_pp0_iter0_buf_cop_V_20_reg_271 = 'bx;

assign ap_phi_reg_pp0_iter0_buf_cop_V_35_0_reg_282 = 'bx;

always @ (*) begin
    ap_predicate_op69_read_state2 = ((cmp_i_i131_i == 1'd1) & (icmp_ln1073_59_reg_704 == 1'd1) & (icmp_ln1073_reg_700 == 1'd1));
end

assign buf_V_15_address0 = buf_V_15_addr_reg_718;

assign buf_V_15_address1 = conv_i97_i_fu_380_p1;

assign buf_V_16_address0 = buf_V_16_addr_reg_708;

assign buf_V_16_address1 = conv_i97_i_fu_380_p1;

assign buf_V_address0 = buf_V_addr_reg_713;

assign buf_V_address1 = conv_i97_i_fu_380_p1;

assign cmp_i_i131_i_read_reg_651 = cmp_i_i131_i;

assign col_V_8_fu_363_p2 = (ap_sig_allocacmp_col_V_7 + 13'd1);

assign conv_i97_i_fu_380_p1 = col_V_7_reg_694;

assign icmp_ln1073_59_fu_369_p2 = ((zext_ln1073_fu_349_p1 < img_width) ? 1'b1 : 1'b0);

assign icmp_ln1073_fu_357_p2 = ((zext_ln1073_8_fu_353_p1 < add_ln1834) ? 1'b1 : 1'b0);

assign icmp_ln1077_fu_386_p2 = ((col_V_7_reg_694 == 13'd0) ? 1'b1 : 1'b0);

assign icmp_ln1081_48_fu_451_p2 = ((max_V_242_fu_443_p3 < src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_return) ? 1'b1 : 1'b0);

assign icmp_ln1081_49_fu_488_p2 = ((max_V_243_reg_749 < ret_fu_104) ? 1'b1 : 1'b0);

assign icmp_ln1081_50_fu_500_p2 = ((max_V_244_fu_493_p3 < ret_129_fu_116) ? 1'b1 : 1'b0);

assign icmp_ln1081_51_fu_514_p2 = ((max_V_245_fu_506_p3 < src_buf_temp_copy_extract_V_0_31_xfExtractPixels_1_1_0_s_fu_305_ap_return) ? 1'b1 : 1'b0);

assign icmp_ln1081_52_fu_541_p2 = ((max_V_246_fu_536_p3 < ret_127_fu_108) ? 1'b1 : 1'b0);

assign icmp_ln1081_53_fu_562_p2 = ((max_V_247_fu_555_p3 < ret_130_fu_120) ? 1'b1 : 1'b0);

assign icmp_ln1081_54_fu_585_p2 = ((max_V_248_reg_770 < src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter6_reg) ? 1'b1 : 1'b0);

assign icmp_ln1081_fu_437_p2 = ((max_V_fu_430_p3 < ret_128_fu_112) ? 1'b1 : 1'b0);

assign mat_dil_b_data338_din = ((p_read8[0:0] == 1'b1) ? select_ln56_6_fu_589_p3 : max_V_248_reg_770);

assign max_V_242_fu_443_p3 = ((icmp_ln1081_fu_437_p2[0:0] == 1'b1) ? ret_128_fu_112 : max_V_fu_430_p3);

assign max_V_243_fu_465_p3 = ((p_read2[0:0] == 1'b1) ? select_ln56_fu_457_p3 : max_V_242_fu_443_p3);

assign max_V_244_fu_493_p3 = ((icmp_ln1081_49_fu_488_p2[0:0] == 1'b1) ? ret_fu_104 : max_V_243_reg_749);

assign max_V_245_fu_506_p3 = ((icmp_ln1081_50_fu_500_p2[0:0] == 1'b1) ? ret_129_fu_116 : max_V_244_fu_493_p3);

assign max_V_246_fu_536_p3 = ((icmp_ln1081_51_reg_765[0:0] == 1'b1) ? src_buf_temp_copy_extract_V_0_31_reg_755 : max_V_245_reg_760);

assign max_V_247_fu_555_p3 = ((p_read6[0:0] == 1'b1) ? select_ln56_4_fu_547_p3 : max_V_246_fu_536_p3);

assign max_V_248_fu_568_p3 = ((icmp_ln1081_53_fu_562_p2[0:0] == 1'b1) ? ret_130_fu_120 : max_V_247_fu_555_p3);

assign max_V_fu_430_p3 = ((p_read[0:0] == 1'b1) ? src_buf_temp_med_apply_V_154_fu_100 : 8'd0);

assign p_cast_read_reg_655 = p_cast;

assign p_read_1_reg_674 = p_read8;

assign p_read_2_reg_679 = p_read6;

assign p_read_3_reg_684 = p_read2;

assign select_ln56_4_fu_547_p3 = ((icmp_ln1081_52_fu_541_p2[0:0] == 1'b1) ? ret_127_fu_108 : max_V_246_fu_536_p3);

assign select_ln56_6_fu_589_p3 = ((icmp_ln1081_54_fu_585_p2[0:0] == 1'b1) ? src_buf_temp_copy_extract_V_0_32_reg_742_pp0_iter6_reg : max_V_248_reg_770);

assign select_ln56_fu_457_p3 = ((icmp_ln1081_48_fu_451_p2[0:0] == 1'b1) ? src_buf_temp_copy_extract_V_0_xfExtractPixels_1_1_0_s_fu_293_ap_return : max_V_242_fu_443_p3);

assign zext_ln1073_8_fu_353_p1 = ap_sig_allocacmp_col_V_7;

assign zext_ln1073_fu_349_p1 = ap_sig_allocacmp_col_V_7;

endmodule //reversi_accel_xfdilate_1024_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop
