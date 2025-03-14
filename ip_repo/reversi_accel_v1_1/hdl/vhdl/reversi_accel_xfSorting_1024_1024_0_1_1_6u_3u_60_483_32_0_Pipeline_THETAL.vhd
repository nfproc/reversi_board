-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_xfSorting_1024_1024_0_1_1_6u_3u_60_483_32_0_Pipeline_THETAL is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    maxrho_V : IN STD_LOGIC_VECTOR (11 downto 0);
    maxangle_V : IN STD_LOGIC_VECTOR (9 downto 0);
    local_max_V : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_1 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_2 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_3 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_4 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_5 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_6 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_7 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_8 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_9 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_10 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_11 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_12 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_13 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_14 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_15 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_16 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_17 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_18 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_19 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_20 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_21 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_22 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_23 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_24 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_25 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_26 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_27 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_28 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_29 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_30 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_31 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_32 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_33 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_34 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_35 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_36 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_37 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_38 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_39 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_40 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_41 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_42 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_43 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_44 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_45 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_46 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_47 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_48 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_49 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_50 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_51 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_52 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_53 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_54 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_55 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_56 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_57 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_58 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_V_59 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_1 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_2 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_3 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_4 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_5 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_6 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_7 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_8 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_9 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_10 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_11 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_12 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_13 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_14 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_15 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_16 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_17 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_18 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_19 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_20 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_21 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_22 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_23 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_24 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_25 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_26 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_27 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_28 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_29 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_30 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_31 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_32 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_33 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_34 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_35 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_36 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_37 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_38 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_39 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_40 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_41 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_42 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_43 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_44 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_45 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_46 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_47 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_48 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_49 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_50 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_51 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_52 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_53 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_54 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_55 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_56 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_57 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_58 : IN STD_LOGIC_VECTOR (11 downto 0);
    local_max_rho_V_59 : IN STD_LOGIC_VECTOR (11 downto 0);
    maxrho_V_4_out : OUT STD_LOGIC_VECTOR (11 downto 0);
    maxrho_V_4_out_ap_vld : OUT STD_LOGIC;
    maxangle_V_1_out : OUT STD_LOGIC_VECTOR (9 downto 0);
    maxangle_V_1_out_ap_vld : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_xfSorting_1024_1024_0_1_1_6u_3u_60_483_32_0_Pipeline_THETAL is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv12_0 : STD_LOGIC_VECTOR (11 downto 0) := "000000000000";
    constant ap_const_lv6_0 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
    constant ap_const_lv6_3C : STD_LOGIC_VECTOR (5 downto 0) := "111100";
    constant ap_const_lv6_1 : STD_LOGIC_VECTOR (5 downto 0) := "000001";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal icmp_ln1073_fu_1069_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal n_V_reg_1430 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal maxfinal_V_1_fu_1081_p62 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxfinal_V_1_reg_1438 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxrho_V_2_fu_1207_p62 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxrho_V_2_reg_1444 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxangle_V_1_fu_284 : STD_LOGIC_VECTOR (9 downto 0);
    signal maxangle_V_5_fu_1355_p3 : STD_LOGIC_VECTOR (9 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_loop_init : STD_LOGIC;
    signal maxrho_V_1_fu_288 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxrho_V_3_fu_1363_p3 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxfinal_V_fu_292 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxfinal_V_2_fu_1370_p3 : STD_LOGIC_VECTOR (11 downto 0);
    signal maxangle_V_2_fu_296 : STD_LOGIC_VECTOR (5 downto 0);
    signal add_ln886_fu_1075_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_sig_allocacmp_n_V : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal icmp_ln1081_fu_1347_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln609_fu_1352_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_mux_606_12_1_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        din3_WIDTH : INTEGER;
        din4_WIDTH : INTEGER;
        din5_WIDTH : INTEGER;
        din6_WIDTH : INTEGER;
        din7_WIDTH : INTEGER;
        din8_WIDTH : INTEGER;
        din9_WIDTH : INTEGER;
        din10_WIDTH : INTEGER;
        din11_WIDTH : INTEGER;
        din12_WIDTH : INTEGER;
        din13_WIDTH : INTEGER;
        din14_WIDTH : INTEGER;
        din15_WIDTH : INTEGER;
        din16_WIDTH : INTEGER;
        din17_WIDTH : INTEGER;
        din18_WIDTH : INTEGER;
        din19_WIDTH : INTEGER;
        din20_WIDTH : INTEGER;
        din21_WIDTH : INTEGER;
        din22_WIDTH : INTEGER;
        din23_WIDTH : INTEGER;
        din24_WIDTH : INTEGER;
        din25_WIDTH : INTEGER;
        din26_WIDTH : INTEGER;
        din27_WIDTH : INTEGER;
        din28_WIDTH : INTEGER;
        din29_WIDTH : INTEGER;
        din30_WIDTH : INTEGER;
        din31_WIDTH : INTEGER;
        din32_WIDTH : INTEGER;
        din33_WIDTH : INTEGER;
        din34_WIDTH : INTEGER;
        din35_WIDTH : INTEGER;
        din36_WIDTH : INTEGER;
        din37_WIDTH : INTEGER;
        din38_WIDTH : INTEGER;
        din39_WIDTH : INTEGER;
        din40_WIDTH : INTEGER;
        din41_WIDTH : INTEGER;
        din42_WIDTH : INTEGER;
        din43_WIDTH : INTEGER;
        din44_WIDTH : INTEGER;
        din45_WIDTH : INTEGER;
        din46_WIDTH : INTEGER;
        din47_WIDTH : INTEGER;
        din48_WIDTH : INTEGER;
        din49_WIDTH : INTEGER;
        din50_WIDTH : INTEGER;
        din51_WIDTH : INTEGER;
        din52_WIDTH : INTEGER;
        din53_WIDTH : INTEGER;
        din54_WIDTH : INTEGER;
        din55_WIDTH : INTEGER;
        din56_WIDTH : INTEGER;
        din57_WIDTH : INTEGER;
        din58_WIDTH : INTEGER;
        din59_WIDTH : INTEGER;
        din60_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (11 downto 0);
        din1 : IN STD_LOGIC_VECTOR (11 downto 0);
        din2 : IN STD_LOGIC_VECTOR (11 downto 0);
        din3 : IN STD_LOGIC_VECTOR (11 downto 0);
        din4 : IN STD_LOGIC_VECTOR (11 downto 0);
        din5 : IN STD_LOGIC_VECTOR (11 downto 0);
        din6 : IN STD_LOGIC_VECTOR (11 downto 0);
        din7 : IN STD_LOGIC_VECTOR (11 downto 0);
        din8 : IN STD_LOGIC_VECTOR (11 downto 0);
        din9 : IN STD_LOGIC_VECTOR (11 downto 0);
        din10 : IN STD_LOGIC_VECTOR (11 downto 0);
        din11 : IN STD_LOGIC_VECTOR (11 downto 0);
        din12 : IN STD_LOGIC_VECTOR (11 downto 0);
        din13 : IN STD_LOGIC_VECTOR (11 downto 0);
        din14 : IN STD_LOGIC_VECTOR (11 downto 0);
        din15 : IN STD_LOGIC_VECTOR (11 downto 0);
        din16 : IN STD_LOGIC_VECTOR (11 downto 0);
        din17 : IN STD_LOGIC_VECTOR (11 downto 0);
        din18 : IN STD_LOGIC_VECTOR (11 downto 0);
        din19 : IN STD_LOGIC_VECTOR (11 downto 0);
        din20 : IN STD_LOGIC_VECTOR (11 downto 0);
        din21 : IN STD_LOGIC_VECTOR (11 downto 0);
        din22 : IN STD_LOGIC_VECTOR (11 downto 0);
        din23 : IN STD_LOGIC_VECTOR (11 downto 0);
        din24 : IN STD_LOGIC_VECTOR (11 downto 0);
        din25 : IN STD_LOGIC_VECTOR (11 downto 0);
        din26 : IN STD_LOGIC_VECTOR (11 downto 0);
        din27 : IN STD_LOGIC_VECTOR (11 downto 0);
        din28 : IN STD_LOGIC_VECTOR (11 downto 0);
        din29 : IN STD_LOGIC_VECTOR (11 downto 0);
        din30 : IN STD_LOGIC_VECTOR (11 downto 0);
        din31 : IN STD_LOGIC_VECTOR (11 downto 0);
        din32 : IN STD_LOGIC_VECTOR (11 downto 0);
        din33 : IN STD_LOGIC_VECTOR (11 downto 0);
        din34 : IN STD_LOGIC_VECTOR (11 downto 0);
        din35 : IN STD_LOGIC_VECTOR (11 downto 0);
        din36 : IN STD_LOGIC_VECTOR (11 downto 0);
        din37 : IN STD_LOGIC_VECTOR (11 downto 0);
        din38 : IN STD_LOGIC_VECTOR (11 downto 0);
        din39 : IN STD_LOGIC_VECTOR (11 downto 0);
        din40 : IN STD_LOGIC_VECTOR (11 downto 0);
        din41 : IN STD_LOGIC_VECTOR (11 downto 0);
        din42 : IN STD_LOGIC_VECTOR (11 downto 0);
        din43 : IN STD_LOGIC_VECTOR (11 downto 0);
        din44 : IN STD_LOGIC_VECTOR (11 downto 0);
        din45 : IN STD_LOGIC_VECTOR (11 downto 0);
        din46 : IN STD_LOGIC_VECTOR (11 downto 0);
        din47 : IN STD_LOGIC_VECTOR (11 downto 0);
        din48 : IN STD_LOGIC_VECTOR (11 downto 0);
        din49 : IN STD_LOGIC_VECTOR (11 downto 0);
        din50 : IN STD_LOGIC_VECTOR (11 downto 0);
        din51 : IN STD_LOGIC_VECTOR (11 downto 0);
        din52 : IN STD_LOGIC_VECTOR (11 downto 0);
        din53 : IN STD_LOGIC_VECTOR (11 downto 0);
        din54 : IN STD_LOGIC_VECTOR (11 downto 0);
        din55 : IN STD_LOGIC_VECTOR (11 downto 0);
        din56 : IN STD_LOGIC_VECTOR (11 downto 0);
        din57 : IN STD_LOGIC_VECTOR (11 downto 0);
        din58 : IN STD_LOGIC_VECTOR (11 downto 0);
        din59 : IN STD_LOGIC_VECTOR (11 downto 0);
        din60 : IN STD_LOGIC_VECTOR (5 downto 0);
        dout : OUT STD_LOGIC_VECTOR (11 downto 0) );
    end component;


    component reversi_accel_flow_control_loop_pipe_sequential_init IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC );
    end component;



begin
    mux_606_12_1_1_U1486 : component reversi_accel_mux_606_12_1_1
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 12,
        din1_WIDTH => 12,
        din2_WIDTH => 12,
        din3_WIDTH => 12,
        din4_WIDTH => 12,
        din5_WIDTH => 12,
        din6_WIDTH => 12,
        din7_WIDTH => 12,
        din8_WIDTH => 12,
        din9_WIDTH => 12,
        din10_WIDTH => 12,
        din11_WIDTH => 12,
        din12_WIDTH => 12,
        din13_WIDTH => 12,
        din14_WIDTH => 12,
        din15_WIDTH => 12,
        din16_WIDTH => 12,
        din17_WIDTH => 12,
        din18_WIDTH => 12,
        din19_WIDTH => 12,
        din20_WIDTH => 12,
        din21_WIDTH => 12,
        din22_WIDTH => 12,
        din23_WIDTH => 12,
        din24_WIDTH => 12,
        din25_WIDTH => 12,
        din26_WIDTH => 12,
        din27_WIDTH => 12,
        din28_WIDTH => 12,
        din29_WIDTH => 12,
        din30_WIDTH => 12,
        din31_WIDTH => 12,
        din32_WIDTH => 12,
        din33_WIDTH => 12,
        din34_WIDTH => 12,
        din35_WIDTH => 12,
        din36_WIDTH => 12,
        din37_WIDTH => 12,
        din38_WIDTH => 12,
        din39_WIDTH => 12,
        din40_WIDTH => 12,
        din41_WIDTH => 12,
        din42_WIDTH => 12,
        din43_WIDTH => 12,
        din44_WIDTH => 12,
        din45_WIDTH => 12,
        din46_WIDTH => 12,
        din47_WIDTH => 12,
        din48_WIDTH => 12,
        din49_WIDTH => 12,
        din50_WIDTH => 12,
        din51_WIDTH => 12,
        din52_WIDTH => 12,
        din53_WIDTH => 12,
        din54_WIDTH => 12,
        din55_WIDTH => 12,
        din56_WIDTH => 12,
        din57_WIDTH => 12,
        din58_WIDTH => 12,
        din59_WIDTH => 12,
        din60_WIDTH => 6,
        dout_WIDTH => 12)
    port map (
        din0 => local_max_V,
        din1 => local_max_V_1,
        din2 => local_max_V_2,
        din3 => local_max_V_3,
        din4 => local_max_V_4,
        din5 => local_max_V_5,
        din6 => local_max_V_6,
        din7 => local_max_V_7,
        din8 => local_max_V_8,
        din9 => local_max_V_9,
        din10 => local_max_V_10,
        din11 => local_max_V_11,
        din12 => local_max_V_12,
        din13 => local_max_V_13,
        din14 => local_max_V_14,
        din15 => local_max_V_15,
        din16 => local_max_V_16,
        din17 => local_max_V_17,
        din18 => local_max_V_18,
        din19 => local_max_V_19,
        din20 => local_max_V_20,
        din21 => local_max_V_21,
        din22 => local_max_V_22,
        din23 => local_max_V_23,
        din24 => local_max_V_24,
        din25 => local_max_V_25,
        din26 => local_max_V_26,
        din27 => local_max_V_27,
        din28 => local_max_V_28,
        din29 => local_max_V_29,
        din30 => local_max_V_30,
        din31 => local_max_V_31,
        din32 => local_max_V_32,
        din33 => local_max_V_33,
        din34 => local_max_V_34,
        din35 => local_max_V_35,
        din36 => local_max_V_36,
        din37 => local_max_V_37,
        din38 => local_max_V_38,
        din39 => local_max_V_39,
        din40 => local_max_V_40,
        din41 => local_max_V_41,
        din42 => local_max_V_42,
        din43 => local_max_V_43,
        din44 => local_max_V_44,
        din45 => local_max_V_45,
        din46 => local_max_V_46,
        din47 => local_max_V_47,
        din48 => local_max_V_48,
        din49 => local_max_V_49,
        din50 => local_max_V_50,
        din51 => local_max_V_51,
        din52 => local_max_V_52,
        din53 => local_max_V_53,
        din54 => local_max_V_54,
        din55 => local_max_V_55,
        din56 => local_max_V_56,
        din57 => local_max_V_57,
        din58 => local_max_V_58,
        din59 => local_max_V_59,
        din60 => ap_sig_allocacmp_n_V,
        dout => maxfinal_V_1_fu_1081_p62);

    mux_606_12_1_1_U1487 : component reversi_accel_mux_606_12_1_1
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 12,
        din1_WIDTH => 12,
        din2_WIDTH => 12,
        din3_WIDTH => 12,
        din4_WIDTH => 12,
        din5_WIDTH => 12,
        din6_WIDTH => 12,
        din7_WIDTH => 12,
        din8_WIDTH => 12,
        din9_WIDTH => 12,
        din10_WIDTH => 12,
        din11_WIDTH => 12,
        din12_WIDTH => 12,
        din13_WIDTH => 12,
        din14_WIDTH => 12,
        din15_WIDTH => 12,
        din16_WIDTH => 12,
        din17_WIDTH => 12,
        din18_WIDTH => 12,
        din19_WIDTH => 12,
        din20_WIDTH => 12,
        din21_WIDTH => 12,
        din22_WIDTH => 12,
        din23_WIDTH => 12,
        din24_WIDTH => 12,
        din25_WIDTH => 12,
        din26_WIDTH => 12,
        din27_WIDTH => 12,
        din28_WIDTH => 12,
        din29_WIDTH => 12,
        din30_WIDTH => 12,
        din31_WIDTH => 12,
        din32_WIDTH => 12,
        din33_WIDTH => 12,
        din34_WIDTH => 12,
        din35_WIDTH => 12,
        din36_WIDTH => 12,
        din37_WIDTH => 12,
        din38_WIDTH => 12,
        din39_WIDTH => 12,
        din40_WIDTH => 12,
        din41_WIDTH => 12,
        din42_WIDTH => 12,
        din43_WIDTH => 12,
        din44_WIDTH => 12,
        din45_WIDTH => 12,
        din46_WIDTH => 12,
        din47_WIDTH => 12,
        din48_WIDTH => 12,
        din49_WIDTH => 12,
        din50_WIDTH => 12,
        din51_WIDTH => 12,
        din52_WIDTH => 12,
        din53_WIDTH => 12,
        din54_WIDTH => 12,
        din55_WIDTH => 12,
        din56_WIDTH => 12,
        din57_WIDTH => 12,
        din58_WIDTH => 12,
        din59_WIDTH => 12,
        din60_WIDTH => 6,
        dout_WIDTH => 12)
    port map (
        din0 => local_max_rho_V,
        din1 => local_max_rho_V_1,
        din2 => local_max_rho_V_2,
        din3 => local_max_rho_V_3,
        din4 => local_max_rho_V_4,
        din5 => local_max_rho_V_5,
        din6 => local_max_rho_V_6,
        din7 => local_max_rho_V_7,
        din8 => local_max_rho_V_8,
        din9 => local_max_rho_V_9,
        din10 => local_max_rho_V_10,
        din11 => local_max_rho_V_11,
        din12 => local_max_rho_V_12,
        din13 => local_max_rho_V_13,
        din14 => local_max_rho_V_14,
        din15 => local_max_rho_V_15,
        din16 => local_max_rho_V_16,
        din17 => local_max_rho_V_17,
        din18 => local_max_rho_V_18,
        din19 => local_max_rho_V_19,
        din20 => local_max_rho_V_20,
        din21 => local_max_rho_V_21,
        din22 => local_max_rho_V_22,
        din23 => local_max_rho_V_23,
        din24 => local_max_rho_V_24,
        din25 => local_max_rho_V_25,
        din26 => local_max_rho_V_26,
        din27 => local_max_rho_V_27,
        din28 => local_max_rho_V_28,
        din29 => local_max_rho_V_29,
        din30 => local_max_rho_V_30,
        din31 => local_max_rho_V_31,
        din32 => local_max_rho_V_32,
        din33 => local_max_rho_V_33,
        din34 => local_max_rho_V_34,
        din35 => local_max_rho_V_35,
        din36 => local_max_rho_V_36,
        din37 => local_max_rho_V_37,
        din38 => local_max_rho_V_38,
        din39 => local_max_rho_V_39,
        din40 => local_max_rho_V_40,
        din41 => local_max_rho_V_41,
        din42 => local_max_rho_V_42,
        din43 => local_max_rho_V_43,
        din44 => local_max_rho_V_44,
        din45 => local_max_rho_V_45,
        din46 => local_max_rho_V_46,
        din47 => local_max_rho_V_47,
        din48 => local_max_rho_V_48,
        din49 => local_max_rho_V_49,
        din50 => local_max_rho_V_50,
        din51 => local_max_rho_V_51,
        din52 => local_max_rho_V_52,
        din53 => local_max_rho_V_53,
        din54 => local_max_rho_V_54,
        din55 => local_max_rho_V_55,
        din56 => local_max_rho_V_56,
        din57 => local_max_rho_V_57,
        din58 => local_max_rho_V_58,
        din59 => local_max_rho_V_59,
        din60 => ap_sig_allocacmp_n_V,
        dout => maxrho_V_2_fu_1207_p62);

    flow_control_loop_pipe_sequential_init_U : component reversi_accel_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage0,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage0)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start_int;
                end if; 
            end if;
        end if;
    end process;


    maxangle_V_1_fu_284_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if ((ap_loop_init = ap_const_logic_1)) then 
                    maxangle_V_1_fu_284 <= maxangle_V;
                elsif ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then 
                    maxangle_V_1_fu_284 <= maxangle_V_5_fu_1355_p3;
                end if;
            end if; 
        end if;
    end process;

    maxangle_V_2_fu_296_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln1073_fu_1069_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    maxangle_V_2_fu_296 <= add_ln886_fu_1075_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    maxangle_V_2_fu_296 <= ap_const_lv6_0;
                end if;
            end if; 
        end if;
    end process;

    maxfinal_V_fu_292_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if ((ap_loop_init = ap_const_logic_1)) then 
                    maxfinal_V_fu_292 <= ap_const_lv12_0;
                elsif ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then 
                    maxfinal_V_fu_292 <= maxfinal_V_2_fu_1370_p3;
                end if;
            end if; 
        end if;
    end process;

    maxrho_V_1_fu_288_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if ((ap_loop_init = ap_const_logic_1)) then 
                    maxrho_V_1_fu_288 <= maxrho_V;
                elsif ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then 
                    maxrho_V_1_fu_288 <= maxrho_V_3_fu_1363_p3;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1073_fu_1069_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                maxfinal_V_1_reg_1438 <= maxfinal_V_1_fu_1081_p62;
                maxrho_V_2_reg_1444 <= maxrho_V_2_fu_1207_p62;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                n_V_reg_1430 <= ap_sig_allocacmp_n_V;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    add_ln886_fu_1075_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_n_V) + unsigned(ap_const_lv6_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_exit_pp0_iter0_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, icmp_ln1073_fu_1069_p2)
    begin
        if (((icmp_ln1073_fu_1069_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_subdone, ap_loop_exit_ready, ap_done_reg)
    begin
        if (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start_int;

    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_start_int = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage0;

    ap_ready_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_n_V_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_loop_init, maxangle_V_2_fu_296)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_n_V <= ap_const_lv6_0;
        else 
            ap_sig_allocacmp_n_V <= maxangle_V_2_fu_296;
        end if; 
    end process;

    icmp_ln1073_fu_1069_p2 <= "1" when (ap_sig_allocacmp_n_V = ap_const_lv6_3C) else "0";
    icmp_ln1081_fu_1347_p2 <= "1" when (unsigned(maxfinal_V_fu_292) < unsigned(maxfinal_V_1_reg_1438)) else "0";
    maxangle_V_1_out <= maxangle_V_1_fu_284;

    maxangle_V_1_out_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, icmp_ln1073_fu_1069_p2, ap_block_pp0_stage0_11001)
    begin
        if (((icmp_ln1073_fu_1069_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            maxangle_V_1_out_ap_vld <= ap_const_logic_1;
        else 
            maxangle_V_1_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    maxangle_V_5_fu_1355_p3 <= 
        zext_ln609_fu_1352_p1 when (icmp_ln1081_fu_1347_p2(0) = '1') else 
        maxangle_V_1_fu_284;
    maxfinal_V_2_fu_1370_p3 <= 
        maxfinal_V_1_reg_1438 when (icmp_ln1081_fu_1347_p2(0) = '1') else 
        maxfinal_V_fu_292;
    maxrho_V_3_fu_1363_p3 <= 
        maxrho_V_2_reg_1444 when (icmp_ln1081_fu_1347_p2(0) = '1') else 
        maxrho_V_1_fu_288;
    maxrho_V_4_out <= maxrho_V_1_fu_288;

    maxrho_V_4_out_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, icmp_ln1073_fu_1069_p2, ap_block_pp0_stage0_11001)
    begin
        if (((icmp_ln1073_fu_1069_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            maxrho_V_4_out_ap_vld <= ap_const_logic_1;
        else 
            maxrho_V_4_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    zext_ln609_fu_1352_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(n_V_reg_1430),10));
end behav;
