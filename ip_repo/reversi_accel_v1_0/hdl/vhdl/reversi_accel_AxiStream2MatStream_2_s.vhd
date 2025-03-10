-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reversi_accel_AxiStream2MatStream_2_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ldata1_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    ldata1_empty_n : IN STD_LOGIC;
    ldata1_read : OUT STD_LOGIC;
    mat_in_4228_din : OUT STD_LOGIC_VECTOR (23 downto 0);
    mat_in_4228_full_n : IN STD_LOGIC;
    mat_in_4228_write : OUT STD_LOGIC;
    rows_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    rows_empty_n : IN STD_LOGIC;
    rows_read : OUT STD_LOGIC;
    cols_bound_per_npc_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    cols_bound_per_npc_empty_n : IN STD_LOGIC;
    cols_bound_per_npc_read : OUT STD_LOGIC;
    last_blk_width : IN STD_LOGIC_VECTOR (3 downto 0);
    stride_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    stride_empty_n : IN STD_LOGIC;
    stride_read : OUT STD_LOGIC );
end;


architecture behav of reversi_accel_AxiStream2MatStream_2_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";
    constant ap_const_lv4_8 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv6_20 : STD_LOGIC_VECTOR (5 downto 0) := "100000";
    constant ap_const_lv6_3F : STD_LOGIC_VECTOR (5 downto 0) := "111111";
    constant ap_const_lv6_1F : STD_LOGIC_VECTOR (5 downto 0) := "011111";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal rows_blk_n : STD_LOGIC;
    signal cols_bound_per_npc_blk_n : STD_LOGIC;
    signal stride_blk_n : STD_LOGIC;
    signal cols_bound_per_npc_read_reg_162 : STD_LOGIC_VECTOR (31 downto 0);
    signal rows_read_reg_168 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln985_fu_88_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln985_reg_173 : STD_LOGIC_VECTOR (0 downto 0);
    signal stride_bound_per_npc_fu_94_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal stride_bound_per_npc_reg_178 : STD_LOGIC_VECTOR (31 downto 0);
    signal last_blk_width_read_reg_184 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal strideBased_last_blk_width_fu_114_p3 : STD_LOGIC_VECTOR (3 downto 0);
    signal strideBased_last_blk_width_reg_190 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal grp_fu_102_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal bound_reg_195 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub_fu_129_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub_reg_200 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub4_fu_135_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal sub4_reg_205 : STD_LOGIC_VECTOR (5 downto 0);
    signal sub26_fu_142_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub26_reg_210 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub31_fu_148_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal sub31_reg_215 : STD_LOGIC_VECTOR (5 downto 0);
    signal add_ln1021_fu_155_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal add_ln1021_reg_220 : STD_LOGIC_VECTOR (5 downto 0);
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_idle : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din : STD_LOGIC_VECTOR (23 downto 0);
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write : STD_LOGIC;
    signal grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal last_blk_width_cast_cast_cast_cast_cast_fu_107_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal sext_ln983_fu_121_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln983_fu_125_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component reversi_accel_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ldata1_dout : IN STD_LOGIC_VECTOR (31 downto 0);
        ldata1_empty_n : IN STD_LOGIC;
        ldata1_read : OUT STD_LOGIC;
        mat_in_4228_din : OUT STD_LOGIC_VECTOR (23 downto 0);
        mat_in_4228_full_n : IN STD_LOGIC;
        mat_in_4228_write : OUT STD_LOGIC;
        bound : IN STD_LOGIC_VECTOR (31 downto 0);
        sub26 : IN STD_LOGIC_VECTOR (31 downto 0);
        sext_ln1021 : IN STD_LOGIC_VECTOR (5 downto 0);
        cols_bound_per_npc_load : IN STD_LOGIC_VECTOR (31 downto 0);
        sub : IN STD_LOGIC_VECTOR (31 downto 0);
        strideBased_last_blk_width : IN STD_LOGIC_VECTOR (3 downto 0);
        sub4 : IN STD_LOGIC_VECTOR (5 downto 0);
        add_ln1021 : IN STD_LOGIC_VECTOR (5 downto 0) );
    end component;


    component reversi_accel_mul_32s_32s_32_2_1 IS
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



begin
    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72 : component reversi_accel_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start,
        ap_done => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done,
        ap_idle => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_idle,
        ap_ready => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready,
        ldata1_dout => ldata1_dout,
        ldata1_empty_n => ldata1_empty_n,
        ldata1_read => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read,
        mat_in_4228_din => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din,
        mat_in_4228_full_n => mat_in_4228_full_n,
        mat_in_4228_write => grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write,
        bound => bound_reg_195,
        sub26 => sub26_reg_210,
        sext_ln1021 => sub31_reg_215,
        cols_bound_per_npc_load => cols_bound_per_npc_read_reg_162,
        sub => sub_reg_200,
        strideBased_last_blk_width => strideBased_last_blk_width_reg_190,
        sub4 => sub4_reg_205,
        add_ln1021 => add_ln1021_reg_220);

    mul_32s_32s_32_2_1_U40 : component reversi_accel_mul_32s_32s_32_2_1
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => rows_read_reg_168,
        din1 => stride_bound_per_npc_reg_178,
        ce => ap_const_logic_1,
        dout => grp_fu_102_p2);





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
                elsif (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_ready = ap_const_logic_1)) then 
                    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                add_ln1021_reg_220 <= add_ln1021_fu_155_p2;
                bound_reg_195 <= grp_fu_102_p2;
                strideBased_last_blk_width_reg_190 <= strideBased_last_blk_width_fu_114_p3;
                sub26_reg_210 <= sub26_fu_142_p2;
                sub31_reg_215 <= sub31_fu_148_p2;
                sub4_reg_205 <= sub4_fu_135_p2;
                sub_reg_200 <= sub_fu_129_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                cols_bound_per_npc_read_reg_162 <= cols_bound_per_npc_dout;
                icmp_ln985_reg_173 <= icmp_ln985_fu_88_p2;
                rows_read_reg_168 <= rows_dout;
                stride_bound_per_npc_reg_178 <= stride_bound_per_npc_fu_94_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                last_blk_width_read_reg_184 <= last_blk_width;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n, grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done, ap_CS_fsm_state4)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    add_ln1021_fu_155_p2 <= std_logic_vector(unsigned(zext_ln983_fu_125_p1) + unsigned(ap_const_lv6_1F));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n)
    begin
        if (((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done)
    begin
        if ((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done, ap_CS_fsm_state4)
    begin
        if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
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


    ap_ready_assign_proc : process(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done, ap_CS_fsm_state4)
    begin
        if (((grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    cols_bound_per_npc_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, cols_bound_per_npc_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_bound_per_npc_blk_n <= cols_bound_per_npc_empty_n;
        else 
            cols_bound_per_npc_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    cols_bound_per_npc_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            cols_bound_per_npc_read <= ap_const_logic_1;
        else 
            cols_bound_per_npc_read <= ap_const_logic_0;
        end if; 
    end process;

    grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start <= grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ap_start_reg;
    icmp_ln985_fu_88_p2 <= "1" when (stride_dout = ap_const_lv32_FFFFFFFF) else "0";
    last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(last_blk_width_cast_cast_cast_cast_cast_fu_107_p1),6));
        last_blk_width_cast_cast_cast_cast_cast_fu_107_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(last_blk_width_read_reg_184),5));


    ldata1_read_assign_proc : process(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ldata1_read <= grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_ldata1_read;
        else 
            ldata1_read <= ap_const_logic_0;
        end if; 
    end process;

    mat_in_4228_din <= grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_din;

    mat_in_4228_write_assign_proc : process(grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            mat_in_4228_write <= grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72_mat_in_4228_write;
        else 
            mat_in_4228_write <= ap_const_logic_0;
        end if; 
    end process;


    rows_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, rows_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_blk_n <= rows_empty_n;
        else 
            rows_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    rows_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            rows_read <= ap_const_logic_1;
        else 
            rows_read <= ap_const_logic_0;
        end if; 
    end process;

        sext_ln983_fu_121_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(strideBased_last_blk_width_fu_114_p3),5));

    strideBased_last_blk_width_fu_114_p3 <= 
        last_blk_width_read_reg_184 when (icmp_ln985_reg_173(0) = '1') else 
        ap_const_lv4_8;

    stride_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, stride_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            stride_blk_n <= stride_empty_n;
        else 
            stride_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    stride_bound_per_npc_fu_94_p3 <= 
        cols_bound_per_npc_dout when (icmp_ln985_fu_88_p2(0) = '1') else 
        stride_dout;

    stride_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, rows_empty_n, cols_bound_per_npc_empty_n, stride_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (stride_empty_n = ap_const_logic_0) or (cols_bound_per_npc_empty_n = ap_const_logic_0) or (rows_empty_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            stride_read <= ap_const_logic_1;
        else 
            stride_read <= ap_const_logic_0;
        end if; 
    end process;

    sub26_fu_142_p2 <= std_logic_vector(unsigned(cols_bound_per_npc_read_reg_162) + unsigned(ap_const_lv32_FFFFFFFF));
    sub31_fu_148_p2 <= std_logic_vector(unsigned(last_blk_width_cast_cast_cast_cast_cast_cast_fu_110_p1) + unsigned(ap_const_lv6_3F));
    sub4_fu_135_p2 <= std_logic_vector(signed(ap_const_lv6_20) - signed(zext_ln983_fu_125_p1));
    sub_fu_129_p2 <= std_logic_vector(signed(stride_bound_per_npc_reg_178) + signed(ap_const_lv32_FFFFFFFF));
    zext_ln983_fu_125_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sext_ln983_fu_121_p1),6));
end behav;
