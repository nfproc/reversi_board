-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_addrbound is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    return_r : OUT STD_LOGIC_VECTOR (20 downto 0);
    rows : IN STD_LOGIC_VECTOR (15 downto 0);
    cols : IN STD_LOGIC_VECTOR (15 downto 0) );
end;


architecture behav of reversi_accel_addrbound is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv21_0 : STD_LOGIC_VECTOR (20 downto 0) := "000000000000000000000";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv26_5 : STD_LOGIC_VECTOR (25 downto 0) := "00000000000000000000000101";
    constant ap_const_lv26_3 : STD_LOGIC_VECTOR (25 downto 0) := "00000000000000000000000011";
    constant ap_const_lv26_1F : STD_LOGIC_VECTOR (25 downto 0) := "00000000000000000000011111";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_19 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011001";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal return_r_preg : STD_LOGIC_VECTOR (20 downto 0) := "000000000000000000000";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal shl_ln1524_fu_49_p0 : STD_LOGIC_VECTOR (25 downto 0);
    signal grp_fu_82_p2 : STD_LOGIC_VECTOR (25 downto 0);
    signal shl_ln1524_1_fu_54_p0 : STD_LOGIC_VECTOR (25 downto 0);
    signal shl_ln1524_fu_49_p2 : STD_LOGIC_VECTOR (25 downto 0);
    signal shl_ln1524_1_fu_54_p2 : STD_LOGIC_VECTOR (25 downto 0);
    signal ret_fu_59_p2 : STD_LOGIC_VECTOR (25 downto 0);
    signal add_ln573_fu_65_p2 : STD_LOGIC_VECTOR (25 downto 0);
    signal grp_fu_82_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_82_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_82_ce : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal grp_fu_82_p00 : STD_LOGIC_VECTOR (25 downto 0);
    signal grp_fu_82_p10 : STD_LOGIC_VECTOR (25 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_mul_mul_16ns_16ns_26_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (25 downto 0) );
    end component;



begin
    mul_mul_16ns_16ns_26_4_1_U15 : component reversi_accel_mul_mul_16ns_16ns_26_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 26)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_82_p0,
        din1 => grp_fu_82_p1,
        ce => grp_fu_82_ce,
        dout => grp_fu_82_p2);





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
                elsif ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    return_r_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                return_r_preg <= ap_const_lv21_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
                    return_r_preg <= add_ln573_fu_65_p2(25 downto 5);
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    add_ln573_fu_65_p2 <= std_logic_vector(unsigned(ret_fu_59_p2) + unsigned(ap_const_lv26_1F));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;
    ap_ST_fsm_state4_blk <= ap_const_logic_0;

    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_82_ce_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1)))) then 
            grp_fu_82_ce <= ap_const_logic_0;
        else 
            grp_fu_82_ce <= ap_const_logic_1;
        end if; 
    end process;

    grp_fu_82_p0 <= grp_fu_82_p00(16 - 1 downto 0);
    grp_fu_82_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(cols),26));
    grp_fu_82_p1 <= grp_fu_82_p10(16 - 1 downto 0);
    grp_fu_82_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(rows),26));
    ret_fu_59_p2 <= std_logic_vector(unsigned(shl_ln1524_fu_49_p2) - unsigned(shl_ln1524_1_fu_54_p2));

    return_r_assign_proc : process(return_r_preg, ap_CS_fsm_state4, add_ln573_fu_65_p2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            return_r <= add_ln573_fu_65_p2(25 downto 5);
        else 
            return_r <= return_r_preg;
        end if; 
    end process;

    shl_ln1524_1_fu_54_p0 <= grp_fu_82_p2;
    shl_ln1524_1_fu_54_p2 <= std_logic_vector(shift_left(unsigned(shl_ln1524_1_fu_54_p0),to_integer(unsigned('0' & ap_const_lv26_3(26-1 downto 0)))));
    shl_ln1524_fu_49_p0 <= grp_fu_82_p2;
    shl_ln1524_fu_49_p2 <= std_logic_vector(shift_left(unsigned(shl_ln1524_fu_49_p0),to_integer(unsigned('0' & ap_const_lv26_5(26-1 downto 0)))));
end behav;
