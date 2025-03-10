-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_Axi2Mat is
port (
    m_axi_data_AWVALID : OUT STD_LOGIC;
    m_axi_data_AWREADY : IN STD_LOGIC;
    m_axi_data_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_data_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_data_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_data_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_data_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_WVALID : OUT STD_LOGIC;
    m_axi_data_WREADY : IN STD_LOGIC;
    m_axi_data_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_data_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_WLAST : OUT STD_LOGIC;
    m_axi_data_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_ARVALID : OUT STD_LOGIC;
    m_axi_data_ARREADY : IN STD_LOGIC;
    m_axi_data_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_data_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_data_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_data_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_data_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_data_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_RVALID : IN STD_LOGIC;
    m_axi_data_RREADY : OUT STD_LOGIC;
    m_axi_data_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_data_RLAST : IN STD_LOGIC;
    m_axi_data_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_RFIFONUM : IN STD_LOGIC_VECTOR (8 downto 0);
    m_axi_data_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_BVALID : IN STD_LOGIC;
    m_axi_data_BREADY : OUT STD_LOGIC;
    m_axi_data_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_data_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_data_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    din : IN STD_LOGIC_VECTOR (63 downto 0);
    mat_in_data323_din : OUT STD_LOGIC_VECTOR (23 downto 0);
    mat_in_data323_full_n : IN STD_LOGIC;
    mat_in_data323_write : OUT STD_LOGIC;
    rows : IN STD_LOGIC_VECTOR (31 downto 0);
    cols : IN STD_LOGIC_VECTOR (31 downto 0);
    stride : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    stride_ap_vld : IN STD_LOGIC;
    rows_ap_vld : IN STD_LOGIC;
    cols_ap_vld : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    din_ap_vld : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC );
end;


architecture behav of reversi_accel_Axi2Mat is 
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_boolean_1 : BOOLEAN := true;

attribute shreg_extract : string;
    signal Axi2Mat_Block_entry3_proc_U0_ap_start : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_ap_done : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_ap_continue : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_ap_idle : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_ap_ready : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_start_out : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_start_write : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_rows_c_din : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2Mat_Block_entry3_proc_U0_rows_c_write : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_cols_c_din : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2Mat_Block_entry3_proc_U0_cols_c_write : STD_LOGIC;
    signal Axi2Mat_Block_entry3_proc_U0_ap_return_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal Axi2Mat_Block_entry3_proc_U0_ap_return_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2Mat_Block_entry3_proc_U0_ap_return_2 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_channel_done_cols_cast_loc_channel : STD_LOGIC;
    signal cols_cast_loc_channel_full_n : STD_LOGIC;
    signal ap_sync_reg_channel_write_cols_cast_loc_channel : STD_LOGIC := '0';
    signal ap_sync_channel_write_cols_cast_loc_channel : STD_LOGIC;
    signal ap_channel_done_rows_stride_loc_channel : STD_LOGIC;
    signal rows_stride_loc_channel_full_n : STD_LOGIC;
    signal ap_sync_reg_channel_write_rows_stride_loc_channel : STD_LOGIC := '0';
    signal ap_sync_channel_write_rows_stride_loc_channel : STD_LOGIC;
    signal ap_channel_done_rows_burst_loc_channel : STD_LOGIC;
    signal rows_burst_loc_channel_full_n : STD_LOGIC;
    signal ap_sync_reg_channel_write_rows_burst_loc_channel : STD_LOGIC := '0';
    signal ap_sync_channel_write_rows_burst_loc_channel : STD_LOGIC;
    signal Axi2AxiStream_U0_ap_start : STD_LOGIC;
    signal Axi2AxiStream_U0_ap_done : STD_LOGIC;
    signal Axi2AxiStream_U0_ap_continue : STD_LOGIC;
    signal Axi2AxiStream_U0_ap_idle : STD_LOGIC;
    signal Axi2AxiStream_U0_ap_ready : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_AWVALID : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_WVALID : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_WDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_WSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_WLAST : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARVALID : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal Axi2AxiStream_U0_m_axi_data_RREADY : STD_LOGIC;
    signal Axi2AxiStream_U0_m_axi_data_BREADY : STD_LOGIC;
    signal Axi2AxiStream_U0_ldata_din : STD_LOGIC_VECTOR (31 downto 0);
    signal Axi2AxiStream_U0_ldata_write : STD_LOGIC;
    signal AxiStream2Mat_U0_ldata1_read : STD_LOGIC;
    signal AxiStream2Mat_U0_mat_in_data323_din : STD_LOGIC_VECTOR (23 downto 0);
    signal AxiStream2Mat_U0_mat_in_data323_write : STD_LOGIC;
    signal AxiStream2Mat_U0_rows_read : STD_LOGIC;
    signal AxiStream2Mat_U0_cols_read : STD_LOGIC;
    signal AxiStream2Mat_U0_ap_start : STD_LOGIC;
    signal AxiStream2Mat_U0_ap_done : STD_LOGIC;
    signal AxiStream2Mat_U0_ap_ready : STD_LOGIC;
    signal AxiStream2Mat_U0_ap_idle : STD_LOGIC;
    signal AxiStream2Mat_U0_ap_continue : STD_LOGIC;
    signal rows_c_full_n : STD_LOGIC;
    signal rows_c_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal rows_c_num_data_valid : STD_LOGIC_VECTOR (2 downto 0);
    signal rows_c_fifo_cap : STD_LOGIC_VECTOR (2 downto 0);
    signal rows_c_empty_n : STD_LOGIC;
    signal cols_c_full_n : STD_LOGIC;
    signal cols_c_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal cols_c_num_data_valid : STD_LOGIC_VECTOR (2 downto 0);
    signal cols_c_fifo_cap : STD_LOGIC_VECTOR (2 downto 0);
    signal cols_c_empty_n : STD_LOGIC;
    signal rows_burst_loc_channel_dout : STD_LOGIC_VECTOR (15 downto 0);
    signal rows_burst_loc_channel_num_data_valid : STD_LOGIC_VECTOR (1 downto 0);
    signal rows_burst_loc_channel_fifo_cap : STD_LOGIC_VECTOR (1 downto 0);
    signal rows_burst_loc_channel_empty_n : STD_LOGIC;
    signal rows_stride_loc_channel_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal rows_stride_loc_channel_num_data_valid : STD_LOGIC_VECTOR (1 downto 0);
    signal rows_stride_loc_channel_fifo_cap : STD_LOGIC_VECTOR (1 downto 0);
    signal rows_stride_loc_channel_empty_n : STD_LOGIC;
    signal cols_cast_loc_channel_dout : STD_LOGIC_VECTOR (15 downto 0);
    signal cols_cast_loc_channel_num_data_valid : STD_LOGIC_VECTOR (1 downto 0);
    signal cols_cast_loc_channel_fifo_cap : STD_LOGIC_VECTOR (1 downto 0);
    signal cols_cast_loc_channel_empty_n : STD_LOGIC;
    signal ldata_full_n : STD_LOGIC;
    signal ldata_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal ldata_num_data_valid : STD_LOGIC_VECTOR (1 downto 0);
    signal ldata_fifo_cap : STD_LOGIC_VECTOR (1 downto 0);
    signal ldata_empty_n : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready : STD_LOGIC := '0';
    signal ap_sync_Axi2Mat_Block_entry3_proc_U0_ap_ready : STD_LOGIC;
    signal ap_sync_reg_Axi2AxiStream_U0_ap_ready : STD_LOGIC := '0';
    signal ap_sync_Axi2AxiStream_U0_ap_ready : STD_LOGIC;
    signal start_for_AxiStream2Mat_U0_din : STD_LOGIC_VECTOR (0 downto 0);
    signal start_for_AxiStream2Mat_U0_full_n : STD_LOGIC;
    signal start_for_AxiStream2Mat_U0_dout : STD_LOGIC_VECTOR (0 downto 0);
    signal start_for_AxiStream2Mat_U0_empty_n : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_Axi2Mat_Block_entry3_proc IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        start_full_n : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        start_out : OUT STD_LOGIC;
        start_write : OUT STD_LOGIC;
        stride : IN STD_LOGIC_VECTOR (31 downto 0);
        rows : IN STD_LOGIC_VECTOR (31 downto 0);
        cols : IN STD_LOGIC_VECTOR (31 downto 0);
        rows_c_din : OUT STD_LOGIC_VECTOR (31 downto 0);
        rows_c_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
        rows_c_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
        rows_c_full_n : IN STD_LOGIC;
        rows_c_write : OUT STD_LOGIC;
        cols_c_din : OUT STD_LOGIC_VECTOR (31 downto 0);
        cols_c_num_data_valid : IN STD_LOGIC_VECTOR (2 downto 0);
        cols_c_fifo_cap : IN STD_LOGIC_VECTOR (2 downto 0);
        cols_c_full_n : IN STD_LOGIC;
        cols_c_write : OUT STD_LOGIC;
        ap_return_0 : OUT STD_LOGIC_VECTOR (15 downto 0);
        ap_return_1 : OUT STD_LOGIC_VECTOR (31 downto 0);
        ap_return_2 : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component reversi_accel_Axi2AxiStream IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        m_axi_data_AWVALID : OUT STD_LOGIC;
        m_axi_data_AWREADY : IN STD_LOGIC;
        m_axi_data_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_data_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_data_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_data_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_data_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_WVALID : OUT STD_LOGIC;
        m_axi_data_WREADY : IN STD_LOGIC;
        m_axi_data_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_data_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_WLAST : OUT STD_LOGIC;
        m_axi_data_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_ARVALID : OUT STD_LOGIC;
        m_axi_data_ARREADY : IN STD_LOGIC;
        m_axi_data_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_data_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_data_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_data_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_data_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_data_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_RVALID : IN STD_LOGIC;
        m_axi_data_RREADY : OUT STD_LOGIC;
        m_axi_data_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        m_axi_data_RLAST : IN STD_LOGIC;
        m_axi_data_RID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_RFIFONUM : IN STD_LOGIC_VECTOR (8 downto 0);
        m_axi_data_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_BVALID : IN STD_LOGIC;
        m_axi_data_BREADY : OUT STD_LOGIC;
        m_axi_data_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_data_BID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_data_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        din : IN STD_LOGIC_VECTOR (63 downto 0);
        ldata_din : OUT STD_LOGIC_VECTOR (31 downto 0);
        ldata_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        ldata_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        ldata_full_n : IN STD_LOGIC;
        ldata_write : OUT STD_LOGIC;
        p_read : IN STD_LOGIC_VECTOR (15 downto 0);
        p_read1 : IN STD_LOGIC_VECTOR (31 downto 0);
        p_read2 : IN STD_LOGIC_VECTOR (15 downto 0);
        stride : IN STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component reversi_accel_AxiStream2Mat IS
    port (
        ldata1_dout : IN STD_LOGIC_VECTOR (31 downto 0);
        ldata1_empty_n : IN STD_LOGIC;
        ldata1_read : OUT STD_LOGIC;
        mat_in_data323_din : OUT STD_LOGIC_VECTOR (23 downto 0);
        mat_in_data323_full_n : IN STD_LOGIC;
        mat_in_data323_write : OUT STD_LOGIC;
        rows_dout : IN STD_LOGIC_VECTOR (31 downto 0);
        rows_empty_n : IN STD_LOGIC;
        rows_read : OUT STD_LOGIC;
        cols_dout : IN STD_LOGIC_VECTOR (31 downto 0);
        cols_empty_n : IN STD_LOGIC;
        cols_read : OUT STD_LOGIC;
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;


    component reversi_accel_fifo_w32_d3_S_x IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (31 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (31 downto 0);
        if_num_data_valid : OUT STD_LOGIC_VECTOR (2 downto 0);
        if_fifo_cap : OUT STD_LOGIC_VECTOR (2 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component reversi_accel_fifo_w16_d2_S IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (15 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (15 downto 0);
        if_num_data_valid : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_fifo_cap : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component reversi_accel_fifo_w32_d2_S IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (31 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (31 downto 0);
        if_num_data_valid : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_fifo_cap : OUT STD_LOGIC_VECTOR (1 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component reversi_accel_start_for_AxiStream2Mat_U0 IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (0 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (0 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;



begin
    Axi2Mat_Block_entry3_proc_U0 : component reversi_accel_Axi2Mat_Block_entry3_proc
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => Axi2Mat_Block_entry3_proc_U0_ap_start,
        start_full_n => start_for_AxiStream2Mat_U0_full_n,
        ap_done => Axi2Mat_Block_entry3_proc_U0_ap_done,
        ap_continue => Axi2Mat_Block_entry3_proc_U0_ap_continue,
        ap_idle => Axi2Mat_Block_entry3_proc_U0_ap_idle,
        ap_ready => Axi2Mat_Block_entry3_proc_U0_ap_ready,
        start_out => Axi2Mat_Block_entry3_proc_U0_start_out,
        start_write => Axi2Mat_Block_entry3_proc_U0_start_write,
        stride => stride,
        rows => rows,
        cols => cols,
        rows_c_din => Axi2Mat_Block_entry3_proc_U0_rows_c_din,
        rows_c_num_data_valid => rows_c_num_data_valid,
        rows_c_fifo_cap => rows_c_fifo_cap,
        rows_c_full_n => rows_c_full_n,
        rows_c_write => Axi2Mat_Block_entry3_proc_U0_rows_c_write,
        cols_c_din => Axi2Mat_Block_entry3_proc_U0_cols_c_din,
        cols_c_num_data_valid => cols_c_num_data_valid,
        cols_c_fifo_cap => cols_c_fifo_cap,
        cols_c_full_n => cols_c_full_n,
        cols_c_write => Axi2Mat_Block_entry3_proc_U0_cols_c_write,
        ap_return_0 => Axi2Mat_Block_entry3_proc_U0_ap_return_0,
        ap_return_1 => Axi2Mat_Block_entry3_proc_U0_ap_return_1,
        ap_return_2 => Axi2Mat_Block_entry3_proc_U0_ap_return_2);

    Axi2AxiStream_U0 : component reversi_accel_Axi2AxiStream
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => Axi2AxiStream_U0_ap_start,
        ap_done => Axi2AxiStream_U0_ap_done,
        ap_continue => Axi2AxiStream_U0_ap_continue,
        ap_idle => Axi2AxiStream_U0_ap_idle,
        ap_ready => Axi2AxiStream_U0_ap_ready,
        m_axi_data_AWVALID => Axi2AxiStream_U0_m_axi_data_AWVALID,
        m_axi_data_AWREADY => ap_const_logic_0,
        m_axi_data_AWADDR => Axi2AxiStream_U0_m_axi_data_AWADDR,
        m_axi_data_AWID => Axi2AxiStream_U0_m_axi_data_AWID,
        m_axi_data_AWLEN => Axi2AxiStream_U0_m_axi_data_AWLEN,
        m_axi_data_AWSIZE => Axi2AxiStream_U0_m_axi_data_AWSIZE,
        m_axi_data_AWBURST => Axi2AxiStream_U0_m_axi_data_AWBURST,
        m_axi_data_AWLOCK => Axi2AxiStream_U0_m_axi_data_AWLOCK,
        m_axi_data_AWCACHE => Axi2AxiStream_U0_m_axi_data_AWCACHE,
        m_axi_data_AWPROT => Axi2AxiStream_U0_m_axi_data_AWPROT,
        m_axi_data_AWQOS => Axi2AxiStream_U0_m_axi_data_AWQOS,
        m_axi_data_AWREGION => Axi2AxiStream_U0_m_axi_data_AWREGION,
        m_axi_data_AWUSER => Axi2AxiStream_U0_m_axi_data_AWUSER,
        m_axi_data_WVALID => Axi2AxiStream_U0_m_axi_data_WVALID,
        m_axi_data_WREADY => ap_const_logic_0,
        m_axi_data_WDATA => Axi2AxiStream_U0_m_axi_data_WDATA,
        m_axi_data_WSTRB => Axi2AxiStream_U0_m_axi_data_WSTRB,
        m_axi_data_WLAST => Axi2AxiStream_U0_m_axi_data_WLAST,
        m_axi_data_WID => Axi2AxiStream_U0_m_axi_data_WID,
        m_axi_data_WUSER => Axi2AxiStream_U0_m_axi_data_WUSER,
        m_axi_data_ARVALID => Axi2AxiStream_U0_m_axi_data_ARVALID,
        m_axi_data_ARREADY => m_axi_data_ARREADY,
        m_axi_data_ARADDR => Axi2AxiStream_U0_m_axi_data_ARADDR,
        m_axi_data_ARID => Axi2AxiStream_U0_m_axi_data_ARID,
        m_axi_data_ARLEN => Axi2AxiStream_U0_m_axi_data_ARLEN,
        m_axi_data_ARSIZE => Axi2AxiStream_U0_m_axi_data_ARSIZE,
        m_axi_data_ARBURST => Axi2AxiStream_U0_m_axi_data_ARBURST,
        m_axi_data_ARLOCK => Axi2AxiStream_U0_m_axi_data_ARLOCK,
        m_axi_data_ARCACHE => Axi2AxiStream_U0_m_axi_data_ARCACHE,
        m_axi_data_ARPROT => Axi2AxiStream_U0_m_axi_data_ARPROT,
        m_axi_data_ARQOS => Axi2AxiStream_U0_m_axi_data_ARQOS,
        m_axi_data_ARREGION => Axi2AxiStream_U0_m_axi_data_ARREGION,
        m_axi_data_ARUSER => Axi2AxiStream_U0_m_axi_data_ARUSER,
        m_axi_data_RVALID => m_axi_data_RVALID,
        m_axi_data_RREADY => Axi2AxiStream_U0_m_axi_data_RREADY,
        m_axi_data_RDATA => m_axi_data_RDATA,
        m_axi_data_RLAST => m_axi_data_RLAST,
        m_axi_data_RID => m_axi_data_RID,
        m_axi_data_RFIFONUM => m_axi_data_RFIFONUM,
        m_axi_data_RUSER => m_axi_data_RUSER,
        m_axi_data_RRESP => m_axi_data_RRESP,
        m_axi_data_BVALID => ap_const_logic_0,
        m_axi_data_BREADY => Axi2AxiStream_U0_m_axi_data_BREADY,
        m_axi_data_BRESP => ap_const_lv2_0,
        m_axi_data_BID => ap_const_lv1_0,
        m_axi_data_BUSER => ap_const_lv1_0,
        din => din,
        ldata_din => Axi2AxiStream_U0_ldata_din,
        ldata_num_data_valid => ldata_num_data_valid,
        ldata_fifo_cap => ldata_fifo_cap,
        ldata_full_n => ldata_full_n,
        ldata_write => Axi2AxiStream_U0_ldata_write,
        p_read => rows_burst_loc_channel_dout,
        p_read1 => rows_stride_loc_channel_dout,
        p_read2 => cols_cast_loc_channel_dout,
        stride => stride);

    AxiStream2Mat_U0 : component reversi_accel_AxiStream2Mat
    port map (
        ldata1_dout => ldata_dout,
        ldata1_empty_n => ldata_empty_n,
        ldata1_read => AxiStream2Mat_U0_ldata1_read,
        mat_in_data323_din => AxiStream2Mat_U0_mat_in_data323_din,
        mat_in_data323_full_n => mat_in_data323_full_n,
        mat_in_data323_write => AxiStream2Mat_U0_mat_in_data323_write,
        rows_dout => rows_c_dout,
        rows_empty_n => rows_c_empty_n,
        rows_read => AxiStream2Mat_U0_rows_read,
        cols_dout => cols_c_dout,
        cols_empty_n => cols_c_empty_n,
        cols_read => AxiStream2Mat_U0_cols_read,
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => AxiStream2Mat_U0_ap_start,
        ap_done => AxiStream2Mat_U0_ap_done,
        ap_ready => AxiStream2Mat_U0_ap_ready,
        ap_idle => AxiStream2Mat_U0_ap_idle,
        ap_continue => AxiStream2Mat_U0_ap_continue);

    rows_c_U : component reversi_accel_fifo_w32_d3_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2Mat_Block_entry3_proc_U0_rows_c_din,
        if_full_n => rows_c_full_n,
        if_write => Axi2Mat_Block_entry3_proc_U0_rows_c_write,
        if_dout => rows_c_dout,
        if_num_data_valid => rows_c_num_data_valid,
        if_fifo_cap => rows_c_fifo_cap,
        if_empty_n => rows_c_empty_n,
        if_read => AxiStream2Mat_U0_rows_read);

    cols_c_U : component reversi_accel_fifo_w32_d3_S_x
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2Mat_Block_entry3_proc_U0_cols_c_din,
        if_full_n => cols_c_full_n,
        if_write => Axi2Mat_Block_entry3_proc_U0_cols_c_write,
        if_dout => cols_c_dout,
        if_num_data_valid => cols_c_num_data_valid,
        if_fifo_cap => cols_c_fifo_cap,
        if_empty_n => cols_c_empty_n,
        if_read => AxiStream2Mat_U0_cols_read);

    rows_burst_loc_channel_U : component reversi_accel_fifo_w16_d2_S
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2Mat_Block_entry3_proc_U0_ap_return_0,
        if_full_n => rows_burst_loc_channel_full_n,
        if_write => ap_channel_done_rows_burst_loc_channel,
        if_dout => rows_burst_loc_channel_dout,
        if_num_data_valid => rows_burst_loc_channel_num_data_valid,
        if_fifo_cap => rows_burst_loc_channel_fifo_cap,
        if_empty_n => rows_burst_loc_channel_empty_n,
        if_read => Axi2AxiStream_U0_ap_ready);

    rows_stride_loc_channel_U : component reversi_accel_fifo_w32_d2_S
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2Mat_Block_entry3_proc_U0_ap_return_1,
        if_full_n => rows_stride_loc_channel_full_n,
        if_write => ap_channel_done_rows_stride_loc_channel,
        if_dout => rows_stride_loc_channel_dout,
        if_num_data_valid => rows_stride_loc_channel_num_data_valid,
        if_fifo_cap => rows_stride_loc_channel_fifo_cap,
        if_empty_n => rows_stride_loc_channel_empty_n,
        if_read => Axi2AxiStream_U0_ap_ready);

    cols_cast_loc_channel_U : component reversi_accel_fifo_w16_d2_S
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2Mat_Block_entry3_proc_U0_ap_return_2,
        if_full_n => cols_cast_loc_channel_full_n,
        if_write => ap_channel_done_cols_cast_loc_channel,
        if_dout => cols_cast_loc_channel_dout,
        if_num_data_valid => cols_cast_loc_channel_num_data_valid,
        if_fifo_cap => cols_cast_loc_channel_fifo_cap,
        if_empty_n => cols_cast_loc_channel_empty_n,
        if_read => Axi2AxiStream_U0_ap_ready);

    ldata_U : component reversi_accel_fifo_w32_d2_S
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => Axi2AxiStream_U0_ldata_din,
        if_full_n => ldata_full_n,
        if_write => Axi2AxiStream_U0_ldata_write,
        if_dout => ldata_dout,
        if_num_data_valid => ldata_num_data_valid,
        if_fifo_cap => ldata_fifo_cap,
        if_empty_n => ldata_empty_n,
        if_read => AxiStream2Mat_U0_ldata1_read);

    start_for_AxiStream2Mat_U0_U : component reversi_accel_start_for_AxiStream2Mat_U0
    port map (
        clk => ap_clk,
        reset => ap_rst,
        if_read_ce => ap_const_logic_1,
        if_write_ce => ap_const_logic_1,
        if_din => start_for_AxiStream2Mat_U0_din,
        if_full_n => start_for_AxiStream2Mat_U0_full_n,
        if_write => Axi2Mat_Block_entry3_proc_U0_start_write,
        if_dout => start_for_AxiStream2Mat_U0_dout,
        if_empty_n => start_for_AxiStream2Mat_U0_empty_n,
        if_read => AxiStream2Mat_U0_ap_ready);





    ap_sync_reg_Axi2AxiStream_U0_ap_ready_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_sync_reg_Axi2AxiStream_U0_ap_ready <= ap_const_logic_0;
            else
                if (((ap_sync_ready and ap_start) = ap_const_logic_1)) then 
                    ap_sync_reg_Axi2AxiStream_U0_ap_ready <= ap_const_logic_0;
                else 
                    ap_sync_reg_Axi2AxiStream_U0_ap_ready <= ap_sync_Axi2AxiStream_U0_ap_ready;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready <= ap_const_logic_0;
            else
                if (((ap_sync_ready and ap_start) = ap_const_logic_1)) then 
                    ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready <= ap_const_logic_0;
                else 
                    ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready <= ap_sync_Axi2Mat_Block_entry3_proc_U0_ap_ready;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_channel_write_cols_cast_loc_channel_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_sync_reg_channel_write_cols_cast_loc_channel <= ap_const_logic_0;
            else
                if (((Axi2Mat_Block_entry3_proc_U0_ap_done and Axi2Mat_Block_entry3_proc_U0_ap_continue) = ap_const_logic_1)) then 
                    ap_sync_reg_channel_write_cols_cast_loc_channel <= ap_const_logic_0;
                else 
                    ap_sync_reg_channel_write_cols_cast_loc_channel <= ap_sync_channel_write_cols_cast_loc_channel;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_channel_write_rows_burst_loc_channel_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_sync_reg_channel_write_rows_burst_loc_channel <= ap_const_logic_0;
            else
                if (((Axi2Mat_Block_entry3_proc_U0_ap_done and Axi2Mat_Block_entry3_proc_U0_ap_continue) = ap_const_logic_1)) then 
                    ap_sync_reg_channel_write_rows_burst_loc_channel <= ap_const_logic_0;
                else 
                    ap_sync_reg_channel_write_rows_burst_loc_channel <= ap_sync_channel_write_rows_burst_loc_channel;
                end if; 
            end if;
        end if;
    end process;


    ap_sync_reg_channel_write_rows_stride_loc_channel_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_sync_reg_channel_write_rows_stride_loc_channel <= ap_const_logic_0;
            else
                if (((Axi2Mat_Block_entry3_proc_U0_ap_done and Axi2Mat_Block_entry3_proc_U0_ap_continue) = ap_const_logic_1)) then 
                    ap_sync_reg_channel_write_rows_stride_loc_channel <= ap_const_logic_0;
                else 
                    ap_sync_reg_channel_write_rows_stride_loc_channel <= ap_sync_channel_write_rows_stride_loc_channel;
                end if; 
            end if;
        end if;
    end process;

    Axi2AxiStream_U0_ap_continue <= ap_const_logic_1;
    Axi2AxiStream_U0_ap_start <= (rows_stride_loc_channel_empty_n and rows_burst_loc_channel_empty_n and (ap_sync_reg_Axi2AxiStream_U0_ap_ready xor ap_const_logic_1) and cols_cast_loc_channel_empty_n and ap_start);
    Axi2Mat_Block_entry3_proc_U0_ap_continue <= (ap_sync_channel_write_rows_stride_loc_channel and ap_sync_channel_write_rows_burst_loc_channel and ap_sync_channel_write_cols_cast_loc_channel);
    Axi2Mat_Block_entry3_proc_U0_ap_start <= ((ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready xor ap_const_logic_1) and ap_start);
    AxiStream2Mat_U0_ap_continue <= ap_continue;
    AxiStream2Mat_U0_ap_start <= start_for_AxiStream2Mat_U0_empty_n;
    ap_channel_done_cols_cast_loc_channel <= ((ap_sync_reg_channel_write_cols_cast_loc_channel xor ap_const_logic_1) and Axi2Mat_Block_entry3_proc_U0_ap_done);
    ap_channel_done_rows_burst_loc_channel <= ((ap_sync_reg_channel_write_rows_burst_loc_channel xor ap_const_logic_1) and Axi2Mat_Block_entry3_proc_U0_ap_done);
    ap_channel_done_rows_stride_loc_channel <= ((ap_sync_reg_channel_write_rows_stride_loc_channel xor ap_const_logic_1) and Axi2Mat_Block_entry3_proc_U0_ap_done);
    ap_done <= AxiStream2Mat_U0_ap_done;
    ap_idle <= ((cols_cast_loc_channel_empty_n xor ap_const_logic_1) and (rows_stride_loc_channel_empty_n xor ap_const_logic_1) and (rows_burst_loc_channel_empty_n xor ap_const_logic_1) and AxiStream2Mat_U0_ap_idle and Axi2Mat_Block_entry3_proc_U0_ap_idle and Axi2AxiStream_U0_ap_idle);
    ap_ready <= ap_sync_ready;
    ap_sync_Axi2AxiStream_U0_ap_ready <= (ap_sync_reg_Axi2AxiStream_U0_ap_ready or Axi2AxiStream_U0_ap_ready);
    ap_sync_Axi2Mat_Block_entry3_proc_U0_ap_ready <= (ap_sync_reg_Axi2Mat_Block_entry3_proc_U0_ap_ready or Axi2Mat_Block_entry3_proc_U0_ap_ready);
    ap_sync_channel_write_cols_cast_loc_channel <= ((cols_cast_loc_channel_full_n and ap_channel_done_cols_cast_loc_channel) or ap_sync_reg_channel_write_cols_cast_loc_channel);
    ap_sync_channel_write_rows_burst_loc_channel <= ((rows_burst_loc_channel_full_n and ap_channel_done_rows_burst_loc_channel) or ap_sync_reg_channel_write_rows_burst_loc_channel);
    ap_sync_channel_write_rows_stride_loc_channel <= ((rows_stride_loc_channel_full_n and ap_channel_done_rows_stride_loc_channel) or ap_sync_reg_channel_write_rows_stride_loc_channel);
    ap_sync_ready <= (ap_sync_Axi2Mat_Block_entry3_proc_U0_ap_ready and ap_sync_Axi2AxiStream_U0_ap_ready);
    m_axi_data_ARADDR <= Axi2AxiStream_U0_m_axi_data_ARADDR;
    m_axi_data_ARBURST <= Axi2AxiStream_U0_m_axi_data_ARBURST;
    m_axi_data_ARCACHE <= Axi2AxiStream_U0_m_axi_data_ARCACHE;
    m_axi_data_ARID <= Axi2AxiStream_U0_m_axi_data_ARID;
    m_axi_data_ARLEN <= Axi2AxiStream_U0_m_axi_data_ARLEN;
    m_axi_data_ARLOCK <= Axi2AxiStream_U0_m_axi_data_ARLOCK;
    m_axi_data_ARPROT <= Axi2AxiStream_U0_m_axi_data_ARPROT;
    m_axi_data_ARQOS <= Axi2AxiStream_U0_m_axi_data_ARQOS;
    m_axi_data_ARREGION <= Axi2AxiStream_U0_m_axi_data_ARREGION;
    m_axi_data_ARSIZE <= Axi2AxiStream_U0_m_axi_data_ARSIZE;
    m_axi_data_ARUSER <= Axi2AxiStream_U0_m_axi_data_ARUSER;
    m_axi_data_ARVALID <= Axi2AxiStream_U0_m_axi_data_ARVALID;
    m_axi_data_AWADDR <= ap_const_lv64_0;
    m_axi_data_AWBURST <= ap_const_lv2_0;
    m_axi_data_AWCACHE <= ap_const_lv4_0;
    m_axi_data_AWID <= ap_const_lv1_0;
    m_axi_data_AWLEN <= ap_const_lv32_0;
    m_axi_data_AWLOCK <= ap_const_lv2_0;
    m_axi_data_AWPROT <= ap_const_lv3_0;
    m_axi_data_AWQOS <= ap_const_lv4_0;
    m_axi_data_AWREGION <= ap_const_lv4_0;
    m_axi_data_AWSIZE <= ap_const_lv3_0;
    m_axi_data_AWUSER <= ap_const_lv1_0;
    m_axi_data_AWVALID <= ap_const_logic_0;
    m_axi_data_BREADY <= ap_const_logic_0;
    m_axi_data_RREADY <= Axi2AxiStream_U0_m_axi_data_RREADY;
    m_axi_data_WDATA <= ap_const_lv32_0;
    m_axi_data_WID <= ap_const_lv1_0;
    m_axi_data_WLAST <= ap_const_logic_0;
    m_axi_data_WSTRB <= ap_const_lv4_0;
    m_axi_data_WUSER <= ap_const_lv1_0;
    m_axi_data_WVALID <= ap_const_logic_0;
    mat_in_data323_din <= AxiStream2Mat_U0_mat_in_data323_din;
    mat_in_data323_write <= AxiStream2Mat_U0_mat_in_data323_write;
    start_for_AxiStream2Mat_U0_din <= (0=>ap_const_logic_1, others=>'-');
end behav;
