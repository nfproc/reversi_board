// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_Axi2AxiStream_Pipeline_VITIS_LOOP_1021_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        m_axi_data_AWVALID,
        m_axi_data_AWREADY,
        m_axi_data_AWADDR,
        m_axi_data_AWID,
        m_axi_data_AWLEN,
        m_axi_data_AWSIZE,
        m_axi_data_AWBURST,
        m_axi_data_AWLOCK,
        m_axi_data_AWCACHE,
        m_axi_data_AWPROT,
        m_axi_data_AWQOS,
        m_axi_data_AWREGION,
        m_axi_data_AWUSER,
        m_axi_data_WVALID,
        m_axi_data_WREADY,
        m_axi_data_WDATA,
        m_axi_data_WSTRB,
        m_axi_data_WLAST,
        m_axi_data_WID,
        m_axi_data_WUSER,
        m_axi_data_ARVALID,
        m_axi_data_ARREADY,
        m_axi_data_ARADDR,
        m_axi_data_ARID,
        m_axi_data_ARLEN,
        m_axi_data_ARSIZE,
        m_axi_data_ARBURST,
        m_axi_data_ARLOCK,
        m_axi_data_ARCACHE,
        m_axi_data_ARPROT,
        m_axi_data_ARQOS,
        m_axi_data_ARREGION,
        m_axi_data_ARUSER,
        m_axi_data_RVALID,
        m_axi_data_RREADY,
        m_axi_data_RDATA,
        m_axi_data_RLAST,
        m_axi_data_RID,
        m_axi_data_RFIFONUM,
        m_axi_data_RUSER,
        m_axi_data_RRESP,
        m_axi_data_BVALID,
        m_axi_data_BREADY,
        m_axi_data_BRESP,
        m_axi_data_BID,
        m_axi_data_BUSER,
        ldata_din,
        ldata_num_data_valid,
        ldata_fifo_cap,
        ldata_full_n,
        ldata_write,
        sext_ln1021,
        cols_addrbound
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   m_axi_data_AWVALID;
input   m_axi_data_AWREADY;
output  [63:0] m_axi_data_AWADDR;
output  [0:0] m_axi_data_AWID;
output  [31:0] m_axi_data_AWLEN;
output  [2:0] m_axi_data_AWSIZE;
output  [1:0] m_axi_data_AWBURST;
output  [1:0] m_axi_data_AWLOCK;
output  [3:0] m_axi_data_AWCACHE;
output  [2:0] m_axi_data_AWPROT;
output  [3:0] m_axi_data_AWQOS;
output  [3:0] m_axi_data_AWREGION;
output  [0:0] m_axi_data_AWUSER;
output   m_axi_data_WVALID;
input   m_axi_data_WREADY;
output  [31:0] m_axi_data_WDATA;
output  [3:0] m_axi_data_WSTRB;
output   m_axi_data_WLAST;
output  [0:0] m_axi_data_WID;
output  [0:0] m_axi_data_WUSER;
output   m_axi_data_ARVALID;
input   m_axi_data_ARREADY;
output  [63:0] m_axi_data_ARADDR;
output  [0:0] m_axi_data_ARID;
output  [31:0] m_axi_data_ARLEN;
output  [2:0] m_axi_data_ARSIZE;
output  [1:0] m_axi_data_ARBURST;
output  [1:0] m_axi_data_ARLOCK;
output  [3:0] m_axi_data_ARCACHE;
output  [2:0] m_axi_data_ARPROT;
output  [3:0] m_axi_data_ARQOS;
output  [3:0] m_axi_data_ARREGION;
output  [0:0] m_axi_data_ARUSER;
input   m_axi_data_RVALID;
output   m_axi_data_RREADY;
input  [31:0] m_axi_data_RDATA;
input   m_axi_data_RLAST;
input  [0:0] m_axi_data_RID;
input  [8:0] m_axi_data_RFIFONUM;
input  [0:0] m_axi_data_RUSER;
input  [1:0] m_axi_data_RRESP;
input   m_axi_data_BVALID;
output   m_axi_data_BREADY;
input  [1:0] m_axi_data_BRESP;
input  [0:0] m_axi_data_BID;
input  [0:0] m_axi_data_BUSER;
output  [31:0] ldata_din;
input  [1:0] ldata_num_data_valid;
input  [1:0] ldata_fifo_cap;
input   ldata_full_n;
output   ldata_write;
input  [61:0] sext_ln1021;
input  [20:0] cols_addrbound;

reg ap_idle;
reg m_axi_data_RREADY;
reg ldata_write;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] icmp_ln1021_reg_131;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln1021_fu_96_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    data_blk_n_R;
wire    ap_block_pp0_stage0;
reg    ldata_blk_n;
reg    ap_block_pp0_stage0_11001;
reg   [31:0] data_addr_read_reg_135;
reg    ap_condition_exit_pp0_iter1_stage0;
reg   [20:0] c_V_fu_56;
wire   [20:0] c_V_2_fu_102_p2;
wire    ap_loop_init;
reg   [20:0] ap_sig_allocacmp_c_V_1;
reg    ap_block_pp0_stage0_01001;
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
        end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter1_stage0)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        if (((ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln1021_fu_96_p2 == 1'd0))) begin
            c_V_fu_56 <= c_V_2_fu_102_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            c_V_fu_56 <= 21'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        icmp_ln1021_reg_131 <= icmp_ln1021_fu_96_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1021_reg_131 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        data_addr_read_reg_135 <= m_axi_data_RDATA;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln1021_fu_96_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1021_reg_131 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
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
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_sig_allocacmp_c_V_1 = 21'd0;
    end else begin
        ap_sig_allocacmp_c_V_1 = c_V_fu_56;
    end
end

always @ (*) begin
    if (((icmp_ln1021_reg_131 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        data_blk_n_R = m_axi_data_RVALID;
    end else begin
        data_blk_n_R = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        ldata_blk_n = ldata_full_n;
    end else begin
        ldata_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ldata_write = 1'b1;
    end else begin
        ldata_write = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1021_reg_131 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        m_axi_data_RREADY = 1'b1;
    end else begin
        m_axi_data_RREADY = 1'b0;
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
    ap_block_pp0_stage0_01001 = (((ldata_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((icmp_ln1021_reg_131 == 1'd0) & (m_axi_data_RVALID == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ldata_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((icmp_ln1021_reg_131 == 1'd0) & (m_axi_data_RVALID == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ldata_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((icmp_ln1021_reg_131 == 1'd0) & (m_axi_data_RVALID == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((icmp_ln1021_reg_131 == 1'd0) & (m_axi_data_RVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (ldata_full_n == 1'b0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign c_V_2_fu_102_p2 = (ap_sig_allocacmp_c_V_1 + 21'd1);

assign icmp_ln1021_fu_96_p2 = ((ap_sig_allocacmp_c_V_1 == cols_addrbound) ? 1'b1 : 1'b0);

assign ldata_din = data_addr_read_reg_135;

assign m_axi_data_ARADDR = 64'd0;

assign m_axi_data_ARBURST = 2'd0;

assign m_axi_data_ARCACHE = 4'd0;

assign m_axi_data_ARID = 1'd0;

assign m_axi_data_ARLEN = 32'd0;

assign m_axi_data_ARLOCK = 2'd0;

assign m_axi_data_ARPROT = 3'd0;

assign m_axi_data_ARQOS = 4'd0;

assign m_axi_data_ARREGION = 4'd0;

assign m_axi_data_ARSIZE = 3'd0;

assign m_axi_data_ARUSER = 1'd0;

assign m_axi_data_ARVALID = 1'b0;

assign m_axi_data_AWADDR = 64'd0;

assign m_axi_data_AWBURST = 2'd0;

assign m_axi_data_AWCACHE = 4'd0;

assign m_axi_data_AWID = 1'd0;

assign m_axi_data_AWLEN = 32'd0;

assign m_axi_data_AWLOCK = 2'd0;

assign m_axi_data_AWPROT = 3'd0;

assign m_axi_data_AWQOS = 4'd0;

assign m_axi_data_AWREGION = 4'd0;

assign m_axi_data_AWSIZE = 3'd0;

assign m_axi_data_AWUSER = 1'd0;

assign m_axi_data_AWVALID = 1'b0;

assign m_axi_data_BREADY = 1'b0;

assign m_axi_data_WDATA = 32'd0;

assign m_axi_data_WID = 1'd0;

assign m_axi_data_WLAST = 1'b0;

assign m_axi_data_WSTRB = 4'd0;

assign m_axi_data_WUSER = 1'd0;

assign m_axi_data_WVALID = 1'b0;

endmodule //reversi_accel_Axi2AxiStream_Pipeline_VITIS_LOOP_1021_1
