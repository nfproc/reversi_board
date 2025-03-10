// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module reversi_accel_xfHoughLines_0_1024_1024_0_1_2_1_6u_3u_32_483_0_180_s_accum_V_60_RAM_T2P_BRAMbck (address0, ce0, d0, we0,  reset,clk);

parameter DataWidth = 1;
parameter AddressWidth = 9;
parameter AddressRange = 484;

input[AddressWidth-1:0] address0;
input ce0;
input[DataWidth-1:0] d0;
input we0;
input reset;
input clk;

(* ram_style = "block" *)reg [DataWidth-1:0] ram[0:AddressRange-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        if (we0) 
            ram[address0] <= d0; 
    end
end


endmodule

