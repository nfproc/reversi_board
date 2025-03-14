-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_bitwise_or_0_1024_1024_1_s is
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
    mat_green1_4233_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    mat_green1_4233_empty_n : IN STD_LOGIC;
    mat_green1_4233_read : OUT STD_LOGIC;
    mat_green2_4234_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    mat_green2_4234_empty_n : IN STD_LOGIC;
    mat_green2_4234_read : OUT STD_LOGIC;
    mat_green_4235_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    mat_green_4235_full_n : IN STD_LOGIC;
    mat_green_4235_write : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_bitwise_or_0_1024_1024_1_s is 
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

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal image_width_fu_65_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal image_width_reg_108 : STD_LOGIC_VECTOR (15 downto 0);
    signal image_height_fu_69_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal image_height_reg_113 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_idle : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_ready : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green1_4233_read : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green2_4234_read : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_din : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_write : STD_LOGIC;
    signal grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal icmp_ln1057_fu_85_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal i_V_fu_38 : STD_LOGIC_VECTOR (12 downto 0);
    signal i_V_8_fu_90_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal zext_ln1057_fu_81_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_bitwise_or_0_1024_1024_1_Pipeline_colLoop IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        mat_green1_4233_dout : IN STD_LOGIC_VECTOR (7 downto 0);
        mat_green1_4233_empty_n : IN STD_LOGIC;
        mat_green1_4233_read : OUT STD_LOGIC;
        mat_green2_4234_dout : IN STD_LOGIC_VECTOR (7 downto 0);
        mat_green2_4234_empty_n : IN STD_LOGIC;
        mat_green2_4234_read : OUT STD_LOGIC;
        mat_green_4235_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        mat_green_4235_full_n : IN STD_LOGIC;
        mat_green_4235_write : OUT STD_LOGIC;
        image_width : IN STD_LOGIC_VECTOR (15 downto 0) );
    end component;



begin
    grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54 : component reversi_accel_bitwise_or_0_1024_1024_1_Pipeline_colLoop
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start,
        ap_done => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done,
        ap_idle => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_idle,
        ap_ready => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_ready,
        mat_green1_4233_dout => mat_green1_4233_dout,
        mat_green1_4233_empty_n => mat_green1_4233_empty_n,
        mat_green1_4233_read => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green1_4233_read,
        mat_green2_4234_dout => mat_green2_4234_dout,
        mat_green2_4234_empty_n => mat_green2_4234_empty_n,
        mat_green2_4234_read => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green2_4234_read,
        mat_green_4235_din => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_din,
        mat_green_4235_full_n => mat_green_4235_full_n,
        mat_green_4235_write => grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_write,
        image_width => image_width_reg_108);





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
                elsif (((icmp_ln1057_fu_85_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg <= ap_const_logic_0;
            else
                if (((icmp_ln1057_fu_85_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_ready = ap_const_logic_1)) then 
                    grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_V_fu_38_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_V_fu_38 <= ap_const_lv13_0;
            elsif (((icmp_ln1057_fu_85_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                i_V_fu_38 <= i_V_8_fu_90_p2;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                image_height_reg_113 <= image_height_fu_69_p1;
                image_width_reg_108 <= image_width_fu_65_p1;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done, ap_CS_fsm_state2, icmp_ln1057_fu_85_p2, ap_CS_fsm_state3)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln1057_fu_85_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state3 => 
                if (((grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
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

    ap_ST_fsm_state3_blk_assign_proc : process(grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done)
    begin
        if ((grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state3_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state3_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state2, icmp_ln1057_fu_85_p2)
    begin
        if (((icmp_ln1057_fu_85_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state2, icmp_ln1057_fu_85_p2)
    begin
        if (((icmp_ln1057_fu_85_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start <= grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_ap_start_reg;
    i_V_8_fu_90_p2 <= std_logic_vector(unsigned(i_V_fu_38) + unsigned(ap_const_lv13_1));
    icmp_ln1057_fu_85_p2 <= "1" when (unsigned(zext_ln1057_fu_81_p1) < unsigned(image_height_reg_113)) else "0";
    image_height_fu_69_p1 <= p_read(16 - 1 downto 0);
    image_width_fu_65_p1 <= p_read1(16 - 1 downto 0);

    mat_green1_4233_read_assign_proc : process(grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green1_4233_read, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_green1_4233_read <= grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green1_4233_read;
        else 
            mat_green1_4233_read <= ap_const_logic_0;
        end if; 
    end process;


    mat_green2_4234_read_assign_proc : process(grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green2_4234_read, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_green2_4234_read <= grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green2_4234_read;
        else 
            mat_green2_4234_read <= ap_const_logic_0;
        end if; 
    end process;

    mat_green_4235_din <= grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_din;

    mat_green_4235_write_assign_proc : process(grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_write, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            mat_green_4235_write <= grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54_mat_green_4235_write;
        else 
            mat_green_4235_write <= ap_const_logic_0;
        end if; 
    end process;

    zext_ln1057_fu_81_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_V_fu_38),16));
end behav;
