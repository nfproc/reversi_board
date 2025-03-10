-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    cf_address0 : OUT STD_LOGIC_VECTOR (1 downto 0);
    cf_ce0 : OUT STD_LOGIC;
    cf_we0 : OUT STD_LOGIC;
    cf_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    sum_1_out : OUT STD_LOGIC_VECTOR (31 downto 0);
    sum_1_out_ap_vld : OUT STD_LOGIC;
    grp_fu_163_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_163_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_163_p_opcode : OUT STD_LOGIC_VECTOR (1 downto 0);
    grp_fu_163_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_163_p_ce : OUT STD_LOGIC;
    grp_fu_167_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_167_p_din1 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_167_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_167_p_ce : OUT STD_LOGIC;
    grp_fu_171_p_din0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_171_p_dout0 : IN STD_LOGIC_VECTOR (31 downto 0);
    grp_fu_171_p_ce : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_GaussianBlur_3_0_9_1024_1024_1_Pipeline_VITIS_LOOP_48_1 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_pp0_stage2 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_pp0_stage3 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_pp0_stage4 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv32_BF000000 : STD_LOGIC_VECTOR (31 downto 0) := "10111111000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter4 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter5 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter6 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage4 : signal is "none";
    signal ap_block_state5_pp0_stage4_iter0 : BOOLEAN;
    signal ap_block_state10_pp0_stage4_iter1 : BOOLEAN;
    signal ap_block_state15_pp0_stage4_iter2 : BOOLEAN;
    signal ap_block_state20_pp0_stage4_iter3 : BOOLEAN;
    signal ap_block_state25_pp0_stage4_iter4 : BOOLEAN;
    signal ap_block_state30_pp0_stage4_iter5 : BOOLEAN;
    signal ap_block_pp0_stage4_subdone : BOOLEAN;
    signal icmp_ln48_reg_159 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage4 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state11_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state16_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_state21_pp0_stage0_iter4 : BOOLEAN;
    signal ap_block_state26_pp0_stage0_iter5 : BOOLEAN;
    signal ap_block_state31_pp0_stage0_iter6 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal i_4_reg_154 : STD_LOGIC_VECTOR (1 downto 0);
    signal i_4_reg_154_pp0_iter1_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal i_4_reg_154_pp0_iter2_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal i_4_reg_154_pp0_iter3_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal i_4_reg_154_pp0_iter4_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal icmp_ln48_fu_96_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln48_reg_159_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln48_reg_159_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln48_reg_159_pp0_iter3_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln48_reg_159_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln49_fu_108_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal add_ln49_reg_163 : STD_LOGIC_VECTOR (1 downto 0);
    signal sext_ln49_fu_119_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_block_state2_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_state7_pp0_stage1_iter1 : BOOLEAN;
    signal ap_block_state12_pp0_stage1_iter2 : BOOLEAN;
    signal ap_block_state17_pp0_stage1_iter3 : BOOLEAN;
    signal ap_block_state22_pp0_stage1_iter4 : BOOLEAN;
    signal ap_block_state27_pp0_stage1_iter5 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal x_reg_173 : STD_LOGIC_VECTOR (31 downto 0);
    signal mul5_i_reg_179 : STD_LOGIC_VECTOR (31 downto 0);
    signal mul6_i_reg_184 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage4_11001 : BOOLEAN;
    signal grp_fu_78_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal t_reg_189 : STD_LOGIC_VECTOR (31 downto 0);
    signal sum_1_reg_200 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter0_reg : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal trunc_ln49_cast_fu_127_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal sum_fu_38 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_sig_allocacmp_sum_load_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal i_fu_42 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_sig_allocacmp_i_4 : STD_LOGIC_VECTOR (1 downto 0);
    signal add_ln48_fu_102_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal grp_fu_70_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_70_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_pp0_stage2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage2 : signal is "none";
    signal ap_block_pp0_stage2 : BOOLEAN;
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter1_reg : STD_LOGIC;
    signal ap_condition_exit_pp0_iter5_stage0 : STD_LOGIC;
    signal ap_idle_pp0_0to4 : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter2_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter3_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter4_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter5_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_idle_pp0_1to6 : STD_LOGIC;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal ap_block_state3_pp0_stage2_iter0 : BOOLEAN;
    signal ap_block_state8_pp0_stage2_iter1 : BOOLEAN;
    signal ap_block_state13_pp0_stage2_iter2 : BOOLEAN;
    signal ap_block_state18_pp0_stage2_iter3 : BOOLEAN;
    signal ap_block_state23_pp0_stage2_iter4 : BOOLEAN;
    signal ap_block_state28_pp0_stage2_iter5 : BOOLEAN;
    signal ap_block_pp0_stage2_subdone : BOOLEAN;
    signal ap_block_state4_pp0_stage3_iter0 : BOOLEAN;
    signal ap_block_state9_pp0_stage3_iter1 : BOOLEAN;
    signal ap_block_state14_pp0_stage3_iter2 : BOOLEAN;
    signal ap_block_state19_pp0_stage3_iter3 : BOOLEAN;
    signal ap_block_state24_pp0_stage3_iter4 : BOOLEAN;
    signal ap_block_state29_pp0_stage3_iter5 : BOOLEAN;
    signal ap_block_pp0_stage3_subdone : BOOLEAN;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_block_pp0_stage0_00001 : BOOLEAN;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_fadd_32ns_32ns_32_5_full_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component reversi_accel_fmul_32ns_32ns_32_4_max_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component reversi_accel_sitofp_32s_32_6_no_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component reversi_accel_fexp_32ns_32ns_32_10_full_dsp_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
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
    fexp_32ns_32ns_32_10_full_dsp_1_U81 : component reversi_accel_fexp_32ns_32ns_32_10_full_dsp_1
    generic map (
        ID => 1,
        NUM_STAGE => 10,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => ap_const_lv32_0,
        din1 => mul6_i_reg_184,
        ce => ap_const_logic_1,
        dout => grp_fu_78_p2);

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
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage4,
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
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter5_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
                    ap_enable_reg_pp0_iter0_reg <= ap_start_int;
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
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage4)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter4_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter4 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter5_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter5 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter6_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter6 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                    ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
                end if; 
            end if;
        end if;
    end process;


    ap_loop_exit_ready_pp0_iter1_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then 
                ap_loop_exit_ready_pp0_iter1_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
            end if; 
        end if;
    end process;

    ap_loop_exit_ready_pp0_iter2_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then 
                ap_loop_exit_ready_pp0_iter2_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
            end if; 
        end if;
    end process;

    ap_loop_exit_ready_pp0_iter3_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then 
                ap_loop_exit_ready_pp0_iter3_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
            end if; 
        end if;
    end process;

    ap_loop_exit_ready_pp0_iter4_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then 
                ap_loop_exit_ready_pp0_iter4_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
            end if; 
        end if;
    end process;

    ap_loop_exit_ready_pp0_iter5_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then 
                ap_loop_exit_ready_pp0_iter5_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
                ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
            end if; 
        end if;
    end process;

    i_fu_42_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (icmp_ln48_fu_96_p2 = ap_const_lv1_0))) then 
                    i_fu_42 <= add_ln48_fu_102_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    i_fu_42 <= ap_const_lv2_0;
                end if;
            end if; 
        end if;
    end process;

    sum_fu_38_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if ((ap_loop_init = ap_const_logic_1)) then 
                    sum_fu_38 <= ap_const_lv32_0;
                elsif ((ap_enable_reg_pp0_iter6 = ap_const_logic_1)) then 
                    sum_fu_38 <= sum_1_reg_200;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln48_fu_96_p2 = ap_const_lv1_0))) then
                add_ln49_reg_163 <= add_ln49_fu_108_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                i_4_reg_154 <= ap_sig_allocacmp_i_4;
                i_4_reg_154_pp0_iter1_reg <= i_4_reg_154;
                i_4_reg_154_pp0_iter2_reg <= i_4_reg_154_pp0_iter1_reg;
                i_4_reg_154_pp0_iter3_reg <= i_4_reg_154_pp0_iter2_reg;
                i_4_reg_154_pp0_iter4_reg <= i_4_reg_154_pp0_iter3_reg;
                icmp_ln48_reg_159 <= icmp_ln48_fu_96_p2;
                icmp_ln48_reg_159_pp0_iter1_reg <= icmp_ln48_reg_159;
                icmp_ln48_reg_159_pp0_iter2_reg <= icmp_ln48_reg_159_pp0_iter1_reg;
                icmp_ln48_reg_159_pp0_iter3_reg <= icmp_ln48_reg_159_pp0_iter2_reg;
                icmp_ln48_reg_159_pp0_iter4_reg <= icmp_ln48_reg_159_pp0_iter3_reg;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                mul5_i_reg_179 <= grp_fu_167_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then
                mul6_i_reg_184 <= grp_fu_167_p_dout0;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage4_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then
                sum_1_reg_200 <= grp_fu_163_p_dout0;
                t_reg_189 <= grp_fu_78_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then
                x_reg_173 <= grp_fu_171_p_dout0;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage4_subdone, ap_block_pp0_stage0_subdone, ap_condition_exit_pp0_iter5_stage0, ap_idle_pp0_0to4, ap_idle_pp0_1to6, ap_block_pp0_stage1_subdone, ap_block_pp0_stage2_subdone, ap_block_pp0_stage3_subdone, ap_start_int)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                if (((ap_idle_pp0_0to4 = ap_const_logic_1) and (ap_const_logic_1 = ap_condition_exit_pp0_iter5_stage0))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((not(((ap_start_int = ap_const_logic_0) and (ap_idle_pp0_1to6 = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_pp0_stage2 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage2_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                end if;
            when ap_ST_fsm_pp0_stage3 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage3_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage4;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                end if;
            when ap_ST_fsm_pp0_stage4 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage4_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage4;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    add_ln48_fu_102_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_i_4) + unsigned(ap_const_lv2_1));
    add_ln49_fu_108_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_i_4) + unsigned(ap_const_lv2_3));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(1);
    ap_CS_fsm_pp0_stage2 <= ap_CS_fsm(2);
    ap_CS_fsm_pp0_stage4 <= ap_CS_fsm(4);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_00001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage4_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state10_pp0_stage4_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state11_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state12_pp0_stage1_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state13_pp0_stage2_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state14_pp0_stage3_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state15_pp0_stage4_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state16_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state17_pp0_stage1_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state18_pp0_stage2_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state19_pp0_stage3_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state20_pp0_stage4_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state21_pp0_stage0_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state22_pp0_stage1_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state23_pp0_stage2_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state24_pp0_stage3_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state25_pp0_stage4_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state26_pp0_stage0_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state27_pp0_stage1_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state28_pp0_stage2_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state29_pp0_stage3_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage1_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state30_pp0_stage4_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state31_pp0_stage0_iter6 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage2_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage3_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage4_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage1_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state8_pp0_stage2_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state9_pp0_stage3_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_exit_pp0_iter0_stage4_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage4_subdone, icmp_ln48_reg_159)
    begin
        if (((icmp_ln48_reg_159 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
            ap_condition_exit_pp0_iter0_stage4 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage4 <= ap_const_logic_0;
        end if; 
    end process;


    ap_condition_exit_pp0_iter5_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter5, icmp_ln48_reg_159_pp0_iter4_reg, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln48_reg_159_pp0_iter4_reg = ap_const_lv1_1))) then 
            ap_condition_exit_pp0_iter5_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter5_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_subdone, ap_done_reg, ap_loop_exit_ready_pp0_iter5_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter5_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_enable_reg_pp0_iter0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0_reg, ap_start_int)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
            ap_enable_reg_pp0_iter0 <= ap_start_int;
        else 
            ap_enable_reg_pp0_iter0 <= ap_enable_reg_pp0_iter0_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_idle_pp0 = ap_const_logic_1) and (ap_start_int = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6)
    begin
        if (((ap_enable_reg_pp0_iter6 = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_0) and (ap_enable_reg_pp0_iter4 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to4_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter4)
    begin
        if (((ap_enable_reg_pp0_iter4 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0_0to4 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to4 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_1to6_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6)
    begin
        if (((ap_enable_reg_pp0_iter6 = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_0) and (ap_enable_reg_pp0_iter4 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0_1to6 <= ap_const_logic_1;
        else 
            ap_idle_pp0_1to6 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage4;

    ap_ready_int_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage4, ap_block_pp0_stage4_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage4_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage4))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_i_4_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_loop_init, i_fu_42)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_i_4 <= ap_const_lv2_0;
        else 
            ap_sig_allocacmp_i_4 <= i_fu_42;
        end if; 
    end process;


    ap_sig_allocacmp_sum_load_1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter6, sum_1_reg_200, ap_block_pp0_stage0, sum_fu_38)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter6 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_sig_allocacmp_sum_load_1 <= sum_1_reg_200;
        else 
            ap_sig_allocacmp_sum_load_1 <= sum_fu_38;
        end if; 
    end process;

    cf_address0 <= trunc_ln49_cast_fu_127_p1(2 - 1 downto 0);

    cf_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter5, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            cf_ce0 <= ap_const_logic_1;
        else 
            cf_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    cf_d0 <= t_reg_189;

    cf_we0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter5, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter5 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            cf_we0 <= ap_const_logic_1;
        else 
            cf_we0 <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_163_p_ce <= ap_const_logic_1;
    grp_fu_163_p_din0 <= ap_sig_allocacmp_sum_load_1;
    grp_fu_163_p_din1 <= t_reg_189;
    grp_fu_163_p_opcode <= ap_const_lv2_0;
    grp_fu_167_p_ce <= ap_const_logic_1;
    grp_fu_167_p_din0 <= grp_fu_70_p0;
    grp_fu_167_p_din1 <= grp_fu_70_p1;
    grp_fu_171_p_ce <= ap_const_logic_1;
    grp_fu_171_p_din0 <= sext_ln49_fu_119_p1;

    grp_fu_70_p0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_CS_fsm_pp0_stage1, x_reg_173, mul5_i_reg_179, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage2, ap_block_pp0_stage1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            grp_fu_70_p0 <= mul5_i_reg_179;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage2) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
            grp_fu_70_p0 <= x_reg_173;
        else 
            grp_fu_70_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    grp_fu_70_p1_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_CS_fsm_pp0_stage1, x_reg_173, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage2, ap_block_pp0_stage1)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            grp_fu_70_p1 <= x_reg_173;
        elsif (((ap_const_boolean_0 = ap_block_pp0_stage2) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
            grp_fu_70_p1 <= ap_const_lv32_BF000000;
        else 
            grp_fu_70_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    icmp_ln48_fu_96_p2 <= "1" when (ap_sig_allocacmp_i_4 = ap_const_lv2_3) else "0";
        sext_ln49_fu_119_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(add_ln49_reg_163),32));

    sum_1_out <= sum_fu_38;

    sum_1_out_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, icmp_ln48_reg_159_pp0_iter4_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln48_reg_159_pp0_iter4_reg = ap_const_lv1_1))) then 
            sum_1_out_ap_vld <= ap_const_logic_1;
        else 
            sum_1_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    trunc_ln49_cast_fu_127_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_4_reg_154_pp0_iter4_reg),64));
end behav;
