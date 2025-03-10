// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module reversi_accel_Axi2Mat (
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
        m_axi_data_RUSER,
        m_axi_data_RRESP,
        m_axi_data_BVALID,
        m_axi_data_BREADY,
        m_axi_data_BRESP,
        m_axi_data_BID,
        m_axi_data_BUSER,
        din,
        mat_in_4228_din,
        mat_in_4228_full_n,
        mat_in_4228_write,
        rows,
        cols,
        stride,
        ap_clk,
        ap_rst,
        din_ap_vld,
        ap_start,
        stride_ap_vld,
        cols_ap_vld,
        rows_ap_vld,
        ap_done,
        ap_ready,
        ap_idle,
        ap_continue
);


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
input  [0:0] m_axi_data_RUSER;
input  [1:0] m_axi_data_RRESP;
input   m_axi_data_BVALID;
output   m_axi_data_BREADY;
input  [1:0] m_axi_data_BRESP;
input  [0:0] m_axi_data_BID;
input  [0:0] m_axi_data_BUSER;
input  [63:0] din;
output  [23:0] mat_in_4228_din;
input   mat_in_4228_full_n;
output   mat_in_4228_write;
input  [31:0] rows;
input  [31:0] cols;
input  [31:0] stride;
input   ap_clk;
input   ap_rst;
input   din_ap_vld;
input   ap_start;
input   stride_ap_vld;
input   cols_ap_vld;
input   rows_ap_vld;
output   ap_done;
output   ap_ready;
output   ap_idle;
input   ap_continue;

wire    entry_proc_U0_ap_start;
wire    entry_proc_U0_ap_done;
wire    entry_proc_U0_ap_continue;
wire    entry_proc_U0_ap_idle;
wire    entry_proc_U0_ap_ready;
wire   [63:0] entry_proc_U0_ap_return;
wire    din_c_channel_full_n;
wire    Axi2Mat_Block_split4_proc_U0_ap_start;
wire    Axi2Mat_Block_split4_proc_U0_ap_done;
wire    Axi2Mat_Block_split4_proc_U0_ap_continue;
wire    Axi2Mat_Block_split4_proc_U0_ap_idle;
wire    Axi2Mat_Block_split4_proc_U0_ap_ready;
wire    Axi2Mat_Block_split4_proc_U0_start_out;
wire    Axi2Mat_Block_split4_proc_U0_start_write;
wire   [31:0] Axi2Mat_Block_split4_proc_U0_rows_c_din;
wire    Axi2Mat_Block_split4_proc_U0_rows_c_write;
wire   [31:0] Axi2Mat_Block_split4_proc_U0_cols_c_din;
wire    Axi2Mat_Block_split4_proc_U0_cols_c_write;
wire   [31:0] Axi2Mat_Block_split4_proc_U0_stride_c_din;
wire    Axi2Mat_Block_split4_proc_U0_stride_c_write;
wire   [15:0] Axi2Mat_Block_split4_proc_U0_ap_return_0;
wire   [15:0] Axi2Mat_Block_split4_proc_U0_ap_return_1;
wire    ap_channel_done_rows_cast_loc_channel;
wire    rows_cast_loc_channel_full_n;
reg    ap_sync_reg_channel_write_rows_cast_loc_channel;
wire    ap_sync_channel_write_rows_cast_loc_channel;
wire    ap_channel_done_cols_tmp_loc_channel;
wire    cols_tmp_loc_channel_full_n;
reg    ap_sync_reg_channel_write_cols_tmp_loc_channel;
wire    ap_sync_channel_write_cols_tmp_loc_channel;
wire    addrbound_U0_ap_start;
wire    addrbound_U0_ap_done;
wire    addrbound_U0_ap_continue;
wire    addrbound_U0_ap_idle;
wire    addrbound_U0_ap_ready;
wire   [20:0] addrbound_U0_return_r;
wire    p_channel_full_n;
wire    Axi2Mat_Block_split46_proc_U0_ap_start;
wire    Axi2Mat_Block_split46_proc_U0_ap_done;
wire    Axi2Mat_Block_split46_proc_U0_ap_continue;
wire    Axi2Mat_Block_split46_proc_U0_ap_idle;
wire    Axi2Mat_Block_split46_proc_U0_ap_ready;
wire   [20:0] Axi2Mat_Block_split46_proc_U0_ap_return;
wire    axibound_V_full_n;
wire    Axi2AxiStream_U0_ap_start;
wire    Axi2AxiStream_U0_ap_done;
wire    Axi2AxiStream_U0_ap_continue;
wire    Axi2AxiStream_U0_ap_idle;
wire    Axi2AxiStream_U0_ap_ready;
wire    Axi2AxiStream_U0_m_axi_data_AWVALID;
wire   [63:0] Axi2AxiStream_U0_m_axi_data_AWADDR;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_AWID;
wire   [31:0] Axi2AxiStream_U0_m_axi_data_AWLEN;
wire   [2:0] Axi2AxiStream_U0_m_axi_data_AWSIZE;
wire   [1:0] Axi2AxiStream_U0_m_axi_data_AWBURST;
wire   [1:0] Axi2AxiStream_U0_m_axi_data_AWLOCK;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_AWCACHE;
wire   [2:0] Axi2AxiStream_U0_m_axi_data_AWPROT;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_AWQOS;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_AWREGION;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_AWUSER;
wire    Axi2AxiStream_U0_m_axi_data_WVALID;
wire   [31:0] Axi2AxiStream_U0_m_axi_data_WDATA;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_WSTRB;
wire    Axi2AxiStream_U0_m_axi_data_WLAST;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_WID;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_WUSER;
wire    Axi2AxiStream_U0_m_axi_data_ARVALID;
wire   [63:0] Axi2AxiStream_U0_m_axi_data_ARADDR;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_ARID;
wire   [31:0] Axi2AxiStream_U0_m_axi_data_ARLEN;
wire   [2:0] Axi2AxiStream_U0_m_axi_data_ARSIZE;
wire   [1:0] Axi2AxiStream_U0_m_axi_data_ARBURST;
wire   [1:0] Axi2AxiStream_U0_m_axi_data_ARLOCK;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_ARCACHE;
wire   [2:0] Axi2AxiStream_U0_m_axi_data_ARPROT;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_ARQOS;
wire   [3:0] Axi2AxiStream_U0_m_axi_data_ARREGION;
wire   [0:0] Axi2AxiStream_U0_m_axi_data_ARUSER;
wire    Axi2AxiStream_U0_m_axi_data_RREADY;
wire    Axi2AxiStream_U0_m_axi_data_BREADY;
wire   [31:0] Axi2AxiStream_U0_ldata1_din;
wire    Axi2AxiStream_U0_ldata1_write;
wire    AxiStream2Mat_U0_ldata1_read;
wire   [23:0] AxiStream2Mat_U0_mat_in_4228_din;
wire    AxiStream2Mat_U0_mat_in_4228_write;
wire    AxiStream2Mat_U0_rows_read;
wire    AxiStream2Mat_U0_cols_read;
wire    AxiStream2Mat_U0_stride_read;
wire    AxiStream2Mat_U0_ap_start;
wire    AxiStream2Mat_U0_ap_done;
wire    AxiStream2Mat_U0_ap_ready;
wire    AxiStream2Mat_U0_ap_idle;
wire    AxiStream2Mat_U0_ap_continue;
wire   [63:0] din_c_channel_dout;
wire    din_c_channel_empty_n;
wire    rows_c_full_n;
wire   [31:0] rows_c_dout;
wire    rows_c_empty_n;
wire    cols_c_full_n;
wire   [31:0] cols_c_dout;
wire    cols_c_empty_n;
wire    stride_c_full_n;
wire   [31:0] stride_c_dout;
wire    stride_c_empty_n;
wire   [15:0] cols_tmp_loc_channel_dout;
wire    cols_tmp_loc_channel_empty_n;
wire   [15:0] rows_cast_loc_channel_dout;
wire    rows_cast_loc_channel_empty_n;
wire   [20:0] p_channel_dout;
wire    p_channel_empty_n;
wire   [20:0] axibound_V_dout;
wire    axibound_V_empty_n;
wire    ldata_full_n;
wire   [31:0] ldata_dout;
wire    ldata_empty_n;
wire    ap_sync_ready;
reg    ap_sync_reg_entry_proc_U0_ap_ready;
wire    ap_sync_entry_proc_U0_ap_ready;
reg    ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready;
wire    ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready;
reg    ap_sync_reg_Axi2AxiStream_U0_ap_ready;
wire    ap_sync_Axi2AxiStream_U0_ap_ready;
wire   [0:0] start_for_AxiStream2Mat_U0_din;
wire    start_for_AxiStream2Mat_U0_full_n;
wire   [0:0] start_for_AxiStream2Mat_U0_dout;
wire    start_for_AxiStream2Mat_U0_empty_n;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_channel_write_rows_cast_loc_channel = 1'b0;
#0 ap_sync_reg_channel_write_cols_tmp_loc_channel = 1'b0;
#0 ap_sync_reg_entry_proc_U0_ap_ready = 1'b0;
#0 ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready = 1'b0;
#0 ap_sync_reg_Axi2AxiStream_U0_ap_ready = 1'b0;
end

reversi_accel_entry_proc entry_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(entry_proc_U0_ap_start),
    .ap_done(entry_proc_U0_ap_done),
    .ap_continue(entry_proc_U0_ap_continue),
    .ap_idle(entry_proc_U0_ap_idle),
    .ap_ready(entry_proc_U0_ap_ready),
    .din(din),
    .ap_return(entry_proc_U0_ap_return)
);

reversi_accel_Axi2Mat_Block_split4_proc Axi2Mat_Block_split4_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2Mat_Block_split4_proc_U0_ap_start),
    .start_full_n(start_for_AxiStream2Mat_U0_full_n),
    .ap_done(Axi2Mat_Block_split4_proc_U0_ap_done),
    .ap_continue(Axi2Mat_Block_split4_proc_U0_ap_continue),
    .ap_idle(Axi2Mat_Block_split4_proc_U0_ap_idle),
    .ap_ready(Axi2Mat_Block_split4_proc_U0_ap_ready),
    .start_out(Axi2Mat_Block_split4_proc_U0_start_out),
    .start_write(Axi2Mat_Block_split4_proc_U0_start_write),
    .stride(stride),
    .cols(cols),
    .rows(rows),
    .rows_c_din(Axi2Mat_Block_split4_proc_U0_rows_c_din),
    .rows_c_full_n(rows_c_full_n),
    .rows_c_write(Axi2Mat_Block_split4_proc_U0_rows_c_write),
    .cols_c_din(Axi2Mat_Block_split4_proc_U0_cols_c_din),
    .cols_c_full_n(cols_c_full_n),
    .cols_c_write(Axi2Mat_Block_split4_proc_U0_cols_c_write),
    .stride_c_din(Axi2Mat_Block_split4_proc_U0_stride_c_din),
    .stride_c_full_n(stride_c_full_n),
    .stride_c_write(Axi2Mat_Block_split4_proc_U0_stride_c_write),
    .ap_return_0(Axi2Mat_Block_split4_proc_U0_ap_return_0),
    .ap_return_1(Axi2Mat_Block_split4_proc_U0_ap_return_1)
);

reversi_accel_addrbound addrbound_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(addrbound_U0_ap_start),
    .ap_done(addrbound_U0_ap_done),
    .ap_continue(addrbound_U0_ap_continue),
    .ap_idle(addrbound_U0_ap_idle),
    .ap_ready(addrbound_U0_ap_ready),
    .return_r(addrbound_U0_return_r),
    .rows(rows_cast_loc_channel_dout),
    .cols(cols_tmp_loc_channel_dout)
);

reversi_accel_Axi2Mat_Block_split46_proc Axi2Mat_Block_split46_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2Mat_Block_split46_proc_U0_ap_start),
    .ap_done(Axi2Mat_Block_split46_proc_U0_ap_done),
    .ap_continue(Axi2Mat_Block_split46_proc_U0_ap_continue),
    .ap_idle(Axi2Mat_Block_split46_proc_U0_ap_idle),
    .ap_ready(Axi2Mat_Block_split46_proc_U0_ap_ready),
    .axibound_V_1(p_channel_dout),
    .ap_return(Axi2Mat_Block_split46_proc_U0_ap_return)
);

reversi_accel_Axi2AxiStream Axi2AxiStream_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(Axi2AxiStream_U0_ap_start),
    .ap_done(Axi2AxiStream_U0_ap_done),
    .ap_continue(Axi2AxiStream_U0_ap_continue),
    .ap_idle(Axi2AxiStream_U0_ap_idle),
    .ap_ready(Axi2AxiStream_U0_ap_ready),
    .m_axi_data_AWVALID(Axi2AxiStream_U0_m_axi_data_AWVALID),
    .m_axi_data_AWREADY(1'b0),
    .m_axi_data_AWADDR(Axi2AxiStream_U0_m_axi_data_AWADDR),
    .m_axi_data_AWID(Axi2AxiStream_U0_m_axi_data_AWID),
    .m_axi_data_AWLEN(Axi2AxiStream_U0_m_axi_data_AWLEN),
    .m_axi_data_AWSIZE(Axi2AxiStream_U0_m_axi_data_AWSIZE),
    .m_axi_data_AWBURST(Axi2AxiStream_U0_m_axi_data_AWBURST),
    .m_axi_data_AWLOCK(Axi2AxiStream_U0_m_axi_data_AWLOCK),
    .m_axi_data_AWCACHE(Axi2AxiStream_U0_m_axi_data_AWCACHE),
    .m_axi_data_AWPROT(Axi2AxiStream_U0_m_axi_data_AWPROT),
    .m_axi_data_AWQOS(Axi2AxiStream_U0_m_axi_data_AWQOS),
    .m_axi_data_AWREGION(Axi2AxiStream_U0_m_axi_data_AWREGION),
    .m_axi_data_AWUSER(Axi2AxiStream_U0_m_axi_data_AWUSER),
    .m_axi_data_WVALID(Axi2AxiStream_U0_m_axi_data_WVALID),
    .m_axi_data_WREADY(1'b0),
    .m_axi_data_WDATA(Axi2AxiStream_U0_m_axi_data_WDATA),
    .m_axi_data_WSTRB(Axi2AxiStream_U0_m_axi_data_WSTRB),
    .m_axi_data_WLAST(Axi2AxiStream_U0_m_axi_data_WLAST),
    .m_axi_data_WID(Axi2AxiStream_U0_m_axi_data_WID),
    .m_axi_data_WUSER(Axi2AxiStream_U0_m_axi_data_WUSER),
    .m_axi_data_ARVALID(Axi2AxiStream_U0_m_axi_data_ARVALID),
    .m_axi_data_ARREADY(m_axi_data_ARREADY),
    .m_axi_data_ARADDR(Axi2AxiStream_U0_m_axi_data_ARADDR),
    .m_axi_data_ARID(Axi2AxiStream_U0_m_axi_data_ARID),
    .m_axi_data_ARLEN(Axi2AxiStream_U0_m_axi_data_ARLEN),
    .m_axi_data_ARSIZE(Axi2AxiStream_U0_m_axi_data_ARSIZE),
    .m_axi_data_ARBURST(Axi2AxiStream_U0_m_axi_data_ARBURST),
    .m_axi_data_ARLOCK(Axi2AxiStream_U0_m_axi_data_ARLOCK),
    .m_axi_data_ARCACHE(Axi2AxiStream_U0_m_axi_data_ARCACHE),
    .m_axi_data_ARPROT(Axi2AxiStream_U0_m_axi_data_ARPROT),
    .m_axi_data_ARQOS(Axi2AxiStream_U0_m_axi_data_ARQOS),
    .m_axi_data_ARREGION(Axi2AxiStream_U0_m_axi_data_ARREGION),
    .m_axi_data_ARUSER(Axi2AxiStream_U0_m_axi_data_ARUSER),
    .m_axi_data_RVALID(m_axi_data_RVALID),
    .m_axi_data_RREADY(Axi2AxiStream_U0_m_axi_data_RREADY),
    .m_axi_data_RDATA(m_axi_data_RDATA),
    .m_axi_data_RLAST(m_axi_data_RLAST),
    .m_axi_data_RID(m_axi_data_RID),
    .m_axi_data_RUSER(m_axi_data_RUSER),
    .m_axi_data_RRESP(m_axi_data_RRESP),
    .m_axi_data_BVALID(1'b0),
    .m_axi_data_BREADY(Axi2AxiStream_U0_m_axi_data_BREADY),
    .m_axi_data_BRESP(2'd0),
    .m_axi_data_BID(1'd0),
    .m_axi_data_BUSER(1'd0),
    .p_read(din_c_channel_dout),
    .ldata1_din(Axi2AxiStream_U0_ldata1_din),
    .ldata1_full_n(ldata_full_n),
    .ldata1_write(Axi2AxiStream_U0_ldata1_write),
    .p_read1(axibound_V_dout)
);

reversi_accel_AxiStream2Mat AxiStream2Mat_U0(
    .ldata1_dout(ldata_dout),
    .ldata1_empty_n(ldata_empty_n),
    .ldata1_read(AxiStream2Mat_U0_ldata1_read),
    .mat_in_4228_din(AxiStream2Mat_U0_mat_in_4228_din),
    .mat_in_4228_full_n(mat_in_4228_full_n),
    .mat_in_4228_write(AxiStream2Mat_U0_mat_in_4228_write),
    .rows_dout(rows_c_dout),
    .rows_empty_n(rows_c_empty_n),
    .rows_read(AxiStream2Mat_U0_rows_read),
    .cols_dout(cols_c_dout),
    .cols_empty_n(cols_c_empty_n),
    .cols_read(AxiStream2Mat_U0_cols_read),
    .stride_dout(stride_c_dout),
    .stride_empty_n(stride_c_empty_n),
    .stride_read(AxiStream2Mat_U0_stride_read),
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(AxiStream2Mat_U0_ap_start),
    .ap_done(AxiStream2Mat_U0_ap_done),
    .ap_ready(AxiStream2Mat_U0_ap_ready),
    .ap_idle(AxiStream2Mat_U0_ap_idle),
    .ap_continue(AxiStream2Mat_U0_ap_continue)
);

reversi_accel_fifo_w64_d4_S din_c_channel_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(entry_proc_U0_ap_return),
    .if_full_n(din_c_channel_full_n),
    .if_write(entry_proc_U0_ap_done),
    .if_dout(din_c_channel_dout),
    .if_empty_n(din_c_channel_empty_n),
    .if_read(Axi2AxiStream_U0_ap_ready)
);

reversi_accel_fifo_w32_d5_S rows_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split4_proc_U0_rows_c_din),
    .if_full_n(rows_c_full_n),
    .if_write(Axi2Mat_Block_split4_proc_U0_rows_c_write),
    .if_dout(rows_c_dout),
    .if_empty_n(rows_c_empty_n),
    .if_read(AxiStream2Mat_U0_rows_read)
);

reversi_accel_fifo_w32_d5_S cols_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split4_proc_U0_cols_c_din),
    .if_full_n(cols_c_full_n),
    .if_write(Axi2Mat_Block_split4_proc_U0_cols_c_write),
    .if_dout(cols_c_dout),
    .if_empty_n(cols_c_empty_n),
    .if_read(AxiStream2Mat_U0_cols_read)
);

reversi_accel_fifo_w32_d5_S stride_c_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split4_proc_U0_stride_c_din),
    .if_full_n(stride_c_full_n),
    .if_write(Axi2Mat_Block_split4_proc_U0_stride_c_write),
    .if_dout(stride_c_dout),
    .if_empty_n(stride_c_empty_n),
    .if_read(AxiStream2Mat_U0_stride_read)
);

reversi_accel_fifo_w16_d2_S cols_tmp_loc_channel_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split4_proc_U0_ap_return_0),
    .if_full_n(cols_tmp_loc_channel_full_n),
    .if_write(ap_channel_done_cols_tmp_loc_channel),
    .if_dout(cols_tmp_loc_channel_dout),
    .if_empty_n(cols_tmp_loc_channel_empty_n),
    .if_read(addrbound_U0_ap_ready)
);

reversi_accel_fifo_w16_d2_S rows_cast_loc_channel_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split4_proc_U0_ap_return_1),
    .if_full_n(rows_cast_loc_channel_full_n),
    .if_write(ap_channel_done_rows_cast_loc_channel),
    .if_dout(rows_cast_loc_channel_dout),
    .if_empty_n(rows_cast_loc_channel_empty_n),
    .if_read(addrbound_U0_ap_ready)
);

reversi_accel_fifo_w21_d2_S p_channel_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(addrbound_U0_return_r),
    .if_full_n(p_channel_full_n),
    .if_write(addrbound_U0_ap_done),
    .if_dout(p_channel_dout),
    .if_empty_n(p_channel_empty_n),
    .if_read(Axi2Mat_Block_split46_proc_U0_ap_ready)
);

reversi_accel_fifo_w21_d2_S axibound_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2Mat_Block_split46_proc_U0_ap_return),
    .if_full_n(axibound_V_full_n),
    .if_write(Axi2Mat_Block_split46_proc_U0_ap_done),
    .if_dout(axibound_V_dout),
    .if_empty_n(axibound_V_empty_n),
    .if_read(Axi2AxiStream_U0_ap_ready)
);

reversi_accel_fifo_w32_d2_S ldata_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(Axi2AxiStream_U0_ldata1_din),
    .if_full_n(ldata_full_n),
    .if_write(Axi2AxiStream_U0_ldata1_write),
    .if_dout(ldata_dout),
    .if_empty_n(ldata_empty_n),
    .if_read(AxiStream2Mat_U0_ldata1_read)
);

reversi_accel_start_for_AxiStream2Mat_U0 start_for_AxiStream2Mat_U0_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_AxiStream2Mat_U0_din),
    .if_full_n(start_for_AxiStream2Mat_U0_full_n),
    .if_write(Axi2Mat_Block_split4_proc_U0_start_write),
    .if_dout(start_for_AxiStream2Mat_U0_dout),
    .if_empty_n(start_for_AxiStream2Mat_U0_empty_n),
    .if_read(AxiStream2Mat_U0_ap_ready)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_Axi2AxiStream_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_Axi2AxiStream_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_Axi2AxiStream_U0_ap_ready <= ap_sync_Axi2AxiStream_U0_ap_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready <= ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_channel_write_cols_tmp_loc_channel <= 1'b0;
    end else begin
        if (((Axi2Mat_Block_split4_proc_U0_ap_done & Axi2Mat_Block_split4_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_cols_tmp_loc_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_cols_tmp_loc_channel <= ap_sync_channel_write_cols_tmp_loc_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_channel_write_rows_cast_loc_channel <= 1'b0;
    end else begin
        if (((Axi2Mat_Block_split4_proc_U0_ap_done & Axi2Mat_Block_split4_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_rows_cast_loc_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_rows_cast_loc_channel <= ap_sync_channel_write_rows_cast_loc_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_sync_reg_entry_proc_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_entry_proc_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_entry_proc_U0_ap_ready <= ap_sync_entry_proc_U0_ap_ready;
        end
    end
end

assign Axi2AxiStream_U0_ap_continue = 1'b1;

assign Axi2AxiStream_U0_ap_start = ((ap_sync_reg_Axi2AxiStream_U0_ap_ready ^ 1'b1) & din_c_channel_empty_n & axibound_V_empty_n & ap_start);

assign Axi2Mat_Block_split46_proc_U0_ap_continue = axibound_V_full_n;

assign Axi2Mat_Block_split46_proc_U0_ap_start = p_channel_empty_n;

assign Axi2Mat_Block_split4_proc_U0_ap_continue = (ap_sync_channel_write_rows_cast_loc_channel & ap_sync_channel_write_cols_tmp_loc_channel);

assign Axi2Mat_Block_split4_proc_U0_ap_start = ((ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready ^ 1'b1) & ap_start);

assign AxiStream2Mat_U0_ap_continue = ap_continue;

assign AxiStream2Mat_U0_ap_start = start_for_AxiStream2Mat_U0_empty_n;

assign addrbound_U0_ap_continue = p_channel_full_n;

assign addrbound_U0_ap_start = (rows_cast_loc_channel_empty_n & cols_tmp_loc_channel_empty_n);

assign ap_channel_done_cols_tmp_loc_channel = ((ap_sync_reg_channel_write_cols_tmp_loc_channel ^ 1'b1) & Axi2Mat_Block_split4_proc_U0_ap_done);

assign ap_channel_done_rows_cast_loc_channel = ((ap_sync_reg_channel_write_rows_cast_loc_channel ^ 1'b1) & Axi2Mat_Block_split4_proc_U0_ap_done);

assign ap_done = AxiStream2Mat_U0_ap_done;

assign ap_idle = ((axibound_V_empty_n ^ 1'b1) & (p_channel_empty_n ^ 1'b1) & (rows_cast_loc_channel_empty_n ^ 1'b1) & (cols_tmp_loc_channel_empty_n ^ 1'b1) & (din_c_channel_empty_n ^ 1'b1) & entry_proc_U0_ap_idle & addrbound_U0_ap_idle & AxiStream2Mat_U0_ap_idle & Axi2Mat_Block_split4_proc_U0_ap_idle & Axi2Mat_Block_split46_proc_U0_ap_idle & Axi2AxiStream_U0_ap_idle);

assign ap_ready = ap_sync_ready;

assign ap_sync_Axi2AxiStream_U0_ap_ready = (ap_sync_reg_Axi2AxiStream_U0_ap_ready | Axi2AxiStream_U0_ap_ready);

assign ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready = (ap_sync_reg_Axi2Mat_Block_split4_proc_U0_ap_ready | Axi2Mat_Block_split4_proc_U0_ap_ready);

assign ap_sync_channel_write_cols_tmp_loc_channel = ((cols_tmp_loc_channel_full_n & ap_channel_done_cols_tmp_loc_channel) | ap_sync_reg_channel_write_cols_tmp_loc_channel);

assign ap_sync_channel_write_rows_cast_loc_channel = ((rows_cast_loc_channel_full_n & ap_channel_done_rows_cast_loc_channel) | ap_sync_reg_channel_write_rows_cast_loc_channel);

assign ap_sync_entry_proc_U0_ap_ready = (entry_proc_U0_ap_ready | ap_sync_reg_entry_proc_U0_ap_ready);

assign ap_sync_ready = (ap_sync_entry_proc_U0_ap_ready & ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready & ap_sync_Axi2AxiStream_U0_ap_ready);

assign entry_proc_U0_ap_continue = din_c_channel_full_n;

assign entry_proc_U0_ap_start = ((ap_sync_reg_entry_proc_U0_ap_ready ^ 1'b1) & ap_start);

assign m_axi_data_ARADDR = Axi2AxiStream_U0_m_axi_data_ARADDR;

assign m_axi_data_ARBURST = Axi2AxiStream_U0_m_axi_data_ARBURST;

assign m_axi_data_ARCACHE = Axi2AxiStream_U0_m_axi_data_ARCACHE;

assign m_axi_data_ARID = Axi2AxiStream_U0_m_axi_data_ARID;

assign m_axi_data_ARLEN = Axi2AxiStream_U0_m_axi_data_ARLEN;

assign m_axi_data_ARLOCK = Axi2AxiStream_U0_m_axi_data_ARLOCK;

assign m_axi_data_ARPROT = Axi2AxiStream_U0_m_axi_data_ARPROT;

assign m_axi_data_ARQOS = Axi2AxiStream_U0_m_axi_data_ARQOS;

assign m_axi_data_ARREGION = Axi2AxiStream_U0_m_axi_data_ARREGION;

assign m_axi_data_ARSIZE = Axi2AxiStream_U0_m_axi_data_ARSIZE;

assign m_axi_data_ARUSER = Axi2AxiStream_U0_m_axi_data_ARUSER;

assign m_axi_data_ARVALID = Axi2AxiStream_U0_m_axi_data_ARVALID;

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

assign m_axi_data_RREADY = Axi2AxiStream_U0_m_axi_data_RREADY;

assign m_axi_data_WDATA = 32'd0;

assign m_axi_data_WID = 1'd0;

assign m_axi_data_WLAST = 1'b0;

assign m_axi_data_WSTRB = 4'd0;

assign m_axi_data_WUSER = 1'd0;

assign m_axi_data_WVALID = 1'b0;

assign mat_in_4228_din = AxiStream2Mat_U0_mat_in_4228_din;

assign mat_in_4228_write = AxiStream2Mat_U0_mat_in_4228_write;

assign start_for_AxiStream2Mat_U0_din = 1'b1;

endmodule //reversi_accel_Axi2Mat
