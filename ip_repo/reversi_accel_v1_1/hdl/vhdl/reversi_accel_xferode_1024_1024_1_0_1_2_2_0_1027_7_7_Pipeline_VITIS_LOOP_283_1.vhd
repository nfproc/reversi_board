-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_xferode_1024_1024_1_0_1_2_2_0_1027_7_7_Pipeline_VITIS_LOOP_283_1 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    row_ind_V_6_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_6_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_5_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_5_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_4_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_4_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_3_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_3_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_2_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_2_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_1_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_1_out_ap_vld : OUT STD_LOGIC;
    row_ind_V_out : OUT STD_LOGIC_VECTOR (12 downto 0);
    row_ind_V_out_ap_vld : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_xferode_1024_1024_1_0_1_2_2_0_1027_7_7_Pipeline_VITIS_LOOP_283_1 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv3_2 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_const_lv3_3 : STD_LOGIC_VECTOR (2 downto 0) := "011";
    constant ap_const_lv3_4 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv3_5 : STD_LOGIC_VECTOR (2 downto 0) := "101";
    constant ap_const_lv3_7 : STD_LOGIC_VECTOR (2 downto 0) := "111";
    constant ap_const_lv3_6 : STD_LOGIC_VECTOR (2 downto 0) := "110";
    constant ap_const_boolean_1 : BOOLEAN := true;

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal icmp_ln283_fu_137_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal row_ind_V_7_fu_48 : STD_LOGIC_VECTOR (2 downto 0);
    signal init_row_ind_fu_143_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal ap_sig_allocacmp_row_ind_V_9 : STD_LOGIC_VECTOR (2 downto 0);
    signal row_ind_V_9_load_fu_134_p1 : STD_LOGIC_VECTOR (2 downto 0);
    signal row_ind_V_fu_52 : STD_LOGIC_VECTOR (12 downto 0);
    signal zext_ln260_fu_149_p1 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_1_fu_56 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_2_fu_60 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_3_fu_64 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_4_fu_68 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_5_fu_72 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_ind_V_6_fu_76 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

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
                ap_CS_fsm <= ap_ST_fsm_state1;
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
                elsif (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    row_ind_V_7_fu_48_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                if ((icmp_ln283_fu_137_p2 = ap_const_lv1_0)) then 
                    row_ind_V_7_fu_48 <= init_row_ind_fu_143_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    row_ind_V_7_fu_48 <= ap_const_lv3_0;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_1) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_1_fu_56(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_2) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_2_fu_60(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_3) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_3_fu_64(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_4) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_4_fu_68(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_5) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_5_fu_72(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1) and (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_6) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0)) or ((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_7) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0))))) then
                    row_ind_V_6_fu_76(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((row_ind_V_9_load_fu_134_p1 = ap_const_lv3_0) and (icmp_ln283_fu_137_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then
                    row_ind_V_fu_52(2 downto 0) <= zext_ln260_fu_149_p1(2 downto 0);
            end if;
        end if;
    end process;
    row_ind_V_fu_52(12 downto 3) <= "0000000000";
    row_ind_V_1_fu_56(12 downto 3) <= "0000000000";
    row_ind_V_2_fu_60(12 downto 3) <= "0000000000";
    row_ind_V_3_fu_64(12 downto 3) <= "0000000000";
    row_ind_V_4_fu_68(12 downto 3) <= "0000000000";
    row_ind_V_5_fu_72(12 downto 3) <= "0000000000";
    row_ind_V_6_fu_76(12 downto 3) <= "0000000000";

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_CS_fsm_state1, ap_start_int)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start_int)
    begin
        if ((ap_start_int = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start_int)
    begin
                ap_block_state1_pp0_stage0_iter0 <= (ap_start_int = ap_const_logic_0);
    end process;


    ap_condition_exit_pp0_iter0_stage0_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_state1, ap_loop_exit_ready, ap_done_reg, ap_start_int)
    begin
        if (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_CS_fsm_state1, ap_start_int)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage0;

    ap_ready_int_assign_proc : process(ap_CS_fsm_state1, ap_start_int)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_row_ind_V_9_assign_proc : process(ap_CS_fsm_state1, row_ind_V_7_fu_48, ap_loop_init)
    begin
        if (((ap_loop_init = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_sig_allocacmp_row_ind_V_9 <= ap_const_lv3_0;
        else 
            ap_sig_allocacmp_row_ind_V_9 <= row_ind_V_7_fu_48;
        end if; 
    end process;

    icmp_ln283_fu_137_p2 <= "1" when (ap_sig_allocacmp_row_ind_V_9 = ap_const_lv3_7) else "0";
    init_row_ind_fu_143_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_row_ind_V_9) + unsigned(ap_const_lv3_1));
    row_ind_V_1_out <= row_ind_V_1_fu_56;

    row_ind_V_1_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_1_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_1_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_2_out <= row_ind_V_2_fu_60;

    row_ind_V_2_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_2_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_2_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_3_out <= row_ind_V_3_fu_64;

    row_ind_V_3_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_3_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_3_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_4_out <= row_ind_V_4_fu_68;

    row_ind_V_4_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_4_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_4_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_5_out <= row_ind_V_5_fu_72;

    row_ind_V_5_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_5_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_5_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_6_out <= row_ind_V_6_fu_76;

    row_ind_V_6_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_6_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_6_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    row_ind_V_9_load_fu_134_p1 <= ap_sig_allocacmp_row_ind_V_9;
    row_ind_V_out <= row_ind_V_fu_52;

    row_ind_V_out_ap_vld_assign_proc : process(ap_CS_fsm_state1, icmp_ln283_fu_137_p2, ap_start_int)
    begin
        if (((icmp_ln283_fu_137_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start_int = ap_const_logic_1))) then 
            row_ind_V_out_ap_vld <= ap_const_logic_1;
        else 
            row_ind_V_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    zext_ln260_fu_149_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ap_sig_allocacmp_row_ind_V_9),13));
end behav;
