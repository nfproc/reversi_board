module swap_GB (
    input  [23:0] S_AXIS_TDATA,
    input   [0:0] S_AXIS_TUSER,
    input         S_AXIS_TLAST,
    input         S_AXIS_TVALID,
    output        S_AXIS_TREADY,
    output [23:0] M_AXIS_TDATA,
    output  [0:0] M_AXIS_TUSER,
    output        M_AXIS_TLAST,
    output        M_AXIS_TVALID,
    input         M_AXIS_TREADY);

    assign M_AXIS_TDATA  = {S_AXIS_TDATA[23:16], S_AXIS_TDATA[7:0], S_AXIS_TDATA[15:8]};
    assign M_AXIS_TUSER  = S_AXIS_TUSER;
    assign M_AXIS_TLAST  = S_AXIS_TLAST;
    assign M_AXIS_TVALID = S_AXIS_TVALID;
    assign S_AXIS_TREADY = M_AXIS_TREADY;
    
endmodule