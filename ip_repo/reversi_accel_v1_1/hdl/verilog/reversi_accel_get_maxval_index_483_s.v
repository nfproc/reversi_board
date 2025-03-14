// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_get_maxval_index_483_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        input_array_address0,
        input_array_ce0,
        input_array_q0,
        p_read1,
        ap_return_0,
        ap_return_1
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [8:0] input_array_address0;
output   input_array_ce0;
input  [11:0] input_array_q0;
input  [11:0] p_read1;
output  [11:0] ap_return_0;
output  [11:0] ap_return_1;

reg ap_idle;
reg input_array_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln1073_fu_101_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg   [0:0] write_flag3_0_reg_77;
wire    ap_block_pp0_stage0_11001;
reg   [8:0] r_V_6_reg_220;
reg   [8:0] r_V_6_reg_220_pp0_iter1_reg;
reg   [0:0] icmp_ln1073_reg_225;
reg   [0:0] icmp_ln1073_reg_225_pp0_iter1_reg;
reg   [11:0] local_max_V_62_reg_234;
wire   [0:0] or_ln526_fu_137_p2;
reg   [0:0] ap_phi_mux_write_flag3_0_phi_fu_80_p4;
wire    ap_loop_init;
wire    ap_block_pp0_stage0;
wire   [63:0] zext_ln587_fu_113_p1;
reg   [11:0] local_max_V_fu_46;
wire   [11:0] local_max_V_61_fu_151_p3;
reg   [11:0] ap_sig_allocacmp_local_max_V_load;
reg   [8:0] r_V_fu_50;
wire   [8:0] r_V_7_fu_107_p2;
reg   [8:0] ap_sig_allocacmp_r_V_6;
reg   [11:0] max_index_02_fu_54;
wire   [11:0] select_ln526_fu_143_p3;
reg   [11:0] ap_sig_allocacmp_max_index_02_load;
wire   [0:0] icmp_ln1081_fu_129_p2;
wire   [11:0] zext_ln232_fu_134_p1;
wire   [11:0] select_ln534_fu_174_p3;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_done_reg = 1'b0;
end

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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            local_max_V_fu_46 <= 12'd0;
        end else if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
            local_max_V_fu_46 <= local_max_V_61_fu_151_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln1073_fu_101_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            r_V_fu_50 <= r_V_7_fu_107_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            r_V_fu_50 <= 9'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        write_flag3_0_reg_77 <= or_ln526_fu_137_p2;
    end else if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        write_flag3_0_reg_77 <= 1'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        icmp_ln1073_reg_225 <= icmp_ln1073_fu_101_p2;
        icmp_ln1073_reg_225_pp0_iter1_reg <= icmp_ln1073_reg_225;
        r_V_6_reg_220 <= ap_sig_allocacmp_r_V_6;
        r_V_6_reg_220_pp0_iter1_reg <= r_V_6_reg_220;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1073_reg_225 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        local_max_V_62_reg_234 <= input_array_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        max_index_02_fu_54 <= select_ln526_fu_143_p3;
    end
end

always @ (*) begin
    if (((icmp_ln1073_fu_101_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_phi_mux_write_flag3_0_phi_fu_80_p4 = or_ln526_fu_137_p2;
    end else begin
        ap_phi_mux_write_flag3_0_phi_fu_80_p4 = write_flag3_0_reg_77;
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
    if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_local_max_V_load = local_max_V_61_fu_151_p3;
    end else begin
        ap_sig_allocacmp_local_max_V_load = local_max_V_fu_46;
    end
end

always @ (*) begin
    if (((icmp_ln1073_reg_225_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_sig_allocacmp_max_index_02_load = select_ln526_fu_143_p3;
    end else begin
        ap_sig_allocacmp_max_index_02_load = max_index_02_fu_54;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_r_V_6 = 9'd0;
    end else begin
        ap_sig_allocacmp_r_V_6 = r_V_fu_50;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        input_array_ce0 = 1'b1;
    end else begin
        input_array_ce0 = 1'b0;
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

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign ap_return_0 = ap_sig_allocacmp_local_max_V_load;

assign ap_return_1 = select_ln534_fu_174_p3;

assign icmp_ln1073_fu_101_p2 = ((ap_sig_allocacmp_r_V_6 == 9'd483) ? 1'b1 : 1'b0);

assign icmp_ln1081_fu_129_p2 = ((local_max_V_fu_46 < local_max_V_62_reg_234) ? 1'b1 : 1'b0);

assign input_array_address0 = zext_ln587_fu_113_p1;

assign local_max_V_61_fu_151_p3 = ((icmp_ln1081_fu_129_p2[0:0] == 1'b1) ? local_max_V_62_reg_234 : local_max_V_fu_46);

assign or_ln526_fu_137_p2 = (write_flag3_0_reg_77 | icmp_ln1081_fu_129_p2);

assign r_V_7_fu_107_p2 = (ap_sig_allocacmp_r_V_6 + 9'd1);

assign select_ln526_fu_143_p3 = ((icmp_ln1081_fu_129_p2[0:0] == 1'b1) ? zext_ln232_fu_134_p1 : max_index_02_fu_54);

assign select_ln534_fu_174_p3 = ((ap_phi_mux_write_flag3_0_phi_fu_80_p4[0:0] == 1'b1) ? ap_sig_allocacmp_max_index_02_load : p_read1);

assign zext_ln232_fu_134_p1 = r_V_6_reg_220_pp0_iter1_reg;

assign zext_ln587_fu_113_p1 = ap_sig_allocacmp_r_V_6;

endmodule //reversi_accel_get_maxval_index_483_s
