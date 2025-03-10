-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
-- Version: 2022.1
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_Axi2Mat_Block_entry3_proc is
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
end;


architecture behav of reversi_accel_Axi2Mat_Block_entry3_proc is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";
    constant ap_const_lv16_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;

attribute shreg_extract : string;
    signal real_start : STD_LOGIC;
    signal start_once_reg : STD_LOGIC := '0';
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal internal_ap_ready : STD_LOGIC;
    signal rows_c_blk_n : STD_LOGIC;
    signal cols_c_blk_n : STD_LOGIC;
    signal ap_block_state1 : BOOLEAN;
    signal icmp_ln1147_fu_70_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal empty_fu_76_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal rows_burst_fu_80_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal rows_stride_fu_88_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal empty_242_fu_96_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_return_0_preg : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    signal ap_return_1_preg : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal ap_return_2_preg : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;


begin




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
                elsif ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_return_0_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_0_preg <= ap_const_lv16_0;
            else
                if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_return_0_preg <= rows_burst_fu_80_p3;
                end if; 
            end if;
        end if;
    end process;


    ap_return_1_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_1_preg <= ap_const_lv32_0;
            else
                if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_return_1_preg <= rows_stride_fu_88_p3;
                end if; 
            end if;
        end if;
    end process;


    ap_return_2_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_2_preg <= ap_const_lv16_0;
            else
                if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_return_2_preg <= empty_242_fu_96_p1;
                end if; 
            end if;
        end if;
    end process;


    start_once_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                start_once_reg <= ap_const_logic_0;
            else
                if (((real_start = ap_const_logic_1) and (internal_ap_ready = ap_const_logic_0))) then 
                    start_once_reg <= ap_const_logic_1;
                elsif ((internal_ap_ready = ap_const_logic_1)) then 
                    start_once_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (real_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);

    ap_ST_fsm_state1_blk_assign_proc : process(real_start, ap_done_reg, rows_c_full_n, cols_c_full_n)
    begin
        if (((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(real_start, ap_done_reg, rows_c_full_n, cols_c_full_n)
    begin
                ap_block_state1 <= ((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(real_start, ap_CS_fsm_state1)
    begin
        if (((real_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_ready <= internal_ap_ready;

    ap_return_0_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n, rows_burst_fu_80_p3, ap_return_0_preg)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_return_0 <= rows_burst_fu_80_p3;
        else 
            ap_return_0 <= ap_return_0_preg;
        end if; 
    end process;


    ap_return_1_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n, rows_stride_fu_88_p3, ap_return_1_preg)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_return_1 <= rows_stride_fu_88_p3;
        else 
            ap_return_1 <= ap_return_1_preg;
        end if; 
    end process;


    ap_return_2_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n, empty_242_fu_96_p1, ap_return_2_preg)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_return_2 <= empty_242_fu_96_p1;
        else 
            ap_return_2 <= ap_return_2_preg;
        end if; 
    end process;


    cols_c_blk_n_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, cols_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_c_blk_n <= cols_c_full_n;
        else 
            cols_c_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    cols_c_din <= cols;

    cols_c_write_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_c_write <= ap_const_logic_1;
        else 
            cols_c_write <= ap_const_logic_0;
        end if; 
    end process;

    empty_242_fu_96_p1 <= cols(16 - 1 downto 0);
    empty_fu_76_p1 <= rows(16 - 1 downto 0);
    icmp_ln1147_fu_70_p2 <= "1" when (stride = ap_const_lv32_FFFFFFFF) else "0";

    internal_ap_ready_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            internal_ap_ready <= ap_const_logic_1;
        else 
            internal_ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    real_start_assign_proc : process(ap_start, start_full_n, start_once_reg)
    begin
        if (((start_full_n = ap_const_logic_0) and (start_once_reg = ap_const_logic_0))) then 
            real_start <= ap_const_logic_0;
        else 
            real_start <= ap_start;
        end if; 
    end process;

    rows_burst_fu_80_p3 <= 
        empty_fu_76_p1 when (icmp_ln1147_fu_70_p2(0) = '1') else 
        ap_const_lv16_1;

    rows_c_blk_n_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_c_blk_n <= rows_c_full_n;
        else 
            rows_c_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    rows_c_din <= rows;

    rows_c_write_assign_proc : process(real_start, ap_done_reg, ap_CS_fsm_state1, rows_c_full_n, cols_c_full_n)
    begin
        if ((not(((real_start = ap_const_logic_0) or (cols_c_full_n = ap_const_logic_0) or (rows_c_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_c_write <= ap_const_logic_1;
        else 
            rows_c_write <= ap_const_logic_0;
        end if; 
    end process;

    rows_stride_fu_88_p3 <= 
        ap_const_lv32_1 when (icmp_ln1147_fu_70_p2(0) = '1') else 
        rows;
    start_out <= real_start;

    start_write_assign_proc : process(real_start, start_once_reg)
    begin
        if (((real_start = ap_const_logic_1) and (start_once_reg = ap_const_logic_0))) then 
            start_write <= ap_const_logic_1;
        else 
            start_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;
