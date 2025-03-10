// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module reversi_accel_inRange_9_0_1024_1024_1_s_lower_thresh2 (
address0, ce0, q0, reset,clk);

parameter DataWidth = 7;
parameter AddressWidth = 2;
parameter AddressRange = 3;

input[AddressWidth-1:0] address0;
input ce0;
output reg[DataWidth-1:0] q0;
input reset;
input clk;

reg [DataWidth-1:0] ram[0:AddressRange-1];

initial begin
    $readmemh("./reversi_accel_inRange_9_0_1024_1024_1_s_lower_thresh2.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) 
    begin
        q0 <= ram[address0];
    end
end



endmodule

