-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_duplicateMat_16_1024_1024_1_2_2_2_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_read1 : IN STD_LOGIC_VECTOR (31 downto 0);
    mat_hsv_data325_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    mat_hsv_data325_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv_data325_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv_data325_empty_n : IN STD_LOGIC;
    mat_hsv_data325_read : OUT STD_LOGIC;
    mat_hsv1_data326_din : OUT STD_LOGIC_VECTOR (23 downto 0);
    mat_hsv1_data326_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv1_data326_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv1_data326_full_n : IN STD_LOGIC;
    mat_hsv1_data326_write : OUT STD_LOGIC;
    mat_hsv2_data327_din : OUT STD_LOGIC_VECTOR (23 downto 0);
    mat_hsv2_data327_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv2_data327_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    mat_hsv2_data327_full_n : IN STD_LOGIC;
    mat_hsv2_data327_write : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_duplicateMat_16_1024_1024_1_2_2_2_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv13_0 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000000";
    constant ap_const_lv13_1 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal img_height_fu_67_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal img_height_reg_110 : STD_LOGIC_VECTOR (15 downto 0);
    signal img_width_fu_71_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal img_width_reg_115 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_idle : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_ready : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv_data325_read : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_din : STD_LOGIC_VECTOR (23 downto 0);
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_write : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_din : STD_LOGIC_VECTOR (23 downto 0);
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_write : STD_LOGIC;
    signal grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal icmp_ln1073_fu_87_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal row_V_fu_40 : STD_LOGIC_VECTOR (12 downto 0);
    signal row_V_13_fu_92_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal zext_ln1073_fu_83_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        mat_hsv_data325_dout : IN STD_LOGIC_VECTOR (23 downto 0);
        mat_hsv_data325_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv_data325_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv_data325_empty_n : IN STD_LOGIC;
        mat_hsv_data325_read : OUT STD_LOGIC;
        mat_hsv1_data326_din : OUT STD_LOGIC_VECTOR (23 downto 0);
        mat_hsv1_data326_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv1_data326_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv1_data326_full_n : IN STD_LOGIC;
        mat_hsv1_data326_write : OUT STD_LOGIC;
        mat_hsv2_data327_din : OUT STD_LOGIC_VECTOR (23 downto 0);
        mat_hsv2_data327_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv2_data327_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        mat_hsv2_data327_full_n : IN STD_LOGIC;
        mat_hsv2_data327_write : OUT STD_LOGIC;
        img_width : IN STD_LOGIC_VECTOR (15 downto 0) );
    end component;



begin
    grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56 : component reversi_accel_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start,
        ap_done => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done,
        ap_idle => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_idle,
        ap_ready => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_ready,
        mat_hsv_data325_dout => mat_hsv_data325_dout,
        mat_hsv_data325_num_data_valid => ap_const_lv2_0,
        mat_hsv_data325_fifo_cap => ap_const_lv2_0,
        mat_hsv_data325_empty_n => mat_hsv_data325_empty_n,
        mat_hsv_data325_read => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv_data325_read,
        mat_hsv1_data326_din => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_din,
        mat_hsv1_data326_num_data_valid => ap_const_lv2_0,
        mat_hsv1_data326_fifo_cap => ap_const_lv2_0,
        mat_hsv1_data326_full_n => mat_hsv1_data326_full_n,
        mat_hsv1_data326_write => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_write,
        mat_hsv2_data327_din => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_din,
        mat_hsv2_data327_num_data_valid => ap_const_lv2_0,
        mat_hsv2_data327_fifo_cap => ap_const_lv2_0,
        mat_hsv2_data327_full_n => mat_hsv2_data327_full_n,
        mat_hsv2_data327_write => grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_write,
        img_width => img_width_reg_115);





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
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((icmp_ln1073_fu_87_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg <= ap_const_logic_0;
            else
                if (((icmp_ln1073_fu_87_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_ready = ap_const_logic_1)) then 
                    grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    row_V_fu_40_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                row_V_fu_40 <= ap_const_lv13_0;
            elsif (((icmp_ln1073_fu_87_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                row_V_fu_40 <= row_V_13_fu_92_p2;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                img_height_reg_110 <= img_height_fu_67_p1;
                img_width_reg_115 <= img_width_fu_71_p1;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done, ap_CS_fsm_state2, icmp_ln1073_fu_87_p2, ap_CS_fsm_state3)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln1073_fu_87_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state3 => 
                if (((grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when others =>  
                ap_NS_fsm <= "XXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;

    ap_ST_fsm_state3_blk_assign_proc : process(grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done)
    begin
        if ((grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state3_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state3_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state2, icmp_ln1073_fu_87_p2)
    begin
        if (((icmp_ln1073_fu_87_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state2, icmp_ln1073_fu_87_p2)
    begin
        if (((icmp_ln1073_fu_87_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_ap_start_reg;
    icmp_ln1073_fu_87_p2 <= "1" when (unsigned(zext_ln1073_fu_83_p1) < unsigned(img_height_reg_110)) else "0";
    img_height_fu_67_p1 <= p_read(16 - 1 downto 0);
    img_width_fu_71_p1 <= p_read1(16 - 1 downto 0);
    mat_hsv1_data326_din <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_din;

    mat_hsv1_data326_write_assign_proc : process(grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_write, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_hsv1_data326_write <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv1_data326_write;
        else 
            mat_hsv1_data326_write <= ap_const_logic_0;
        end if; 
    end process;

    mat_hsv2_data327_din <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_din;

    mat_hsv2_data327_write_assign_proc : process(grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_write, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_hsv2_data327_write <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv2_data327_write;
        else 
            mat_hsv2_data327_write <= ap_const_logic_0;
        end if; 
    end process;


    mat_hsv_data325_read_assign_proc : process(grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv_data325_read, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_hsv_data325_read <= grp_duplicateMat_16_1024_1024_1_2_2_2_Pipeline_Col_Loop_fu_56_mat_hsv_data325_read;
        else 
            mat_hsv_data325_read <= ap_const_logic_0;
        end if; 
    end process;

    row_V_13_fu_92_p2 <= std_logic_vector(unsigned(row_V_fu_40) + unsigned(ap_const_lv13_1));
    zext_ln1073_fu_83_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(row_V_fu_40),16));
end behav;
