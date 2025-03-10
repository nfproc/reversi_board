   
    parameter PROC_NUM = 25;
    parameter ST_IDLE = 3'b000;
    parameter ST_FILTER_FAKE = 3'b001;
    parameter ST_DL_DETECTED = 3'b010;
    parameter ST_DL_REPORT = 3'b100;
   

    reg find_df_deadlock = 0;
    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    integer i;
    integer fp;

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end
    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        NS_fsm = CS_fsm;
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt == 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if (dl_detect_reg != dl_done_reg) begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    always @ (CS_fsm or dl_detect_reg or dl_done_reg) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_detect_reg[i] & ~dl_done_reg[i] & ~(|origin)) begin
                    origin = 'b1 << i;
                end
            end
        end
        else begin
            origin = 'b0;
        end
    end
    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [992:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "reversi_accel_reversi_accel.entry_proc40_U0";
                end
                1 : begin
                    proc_path = "reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0";
                end
                2 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0";
                end
                3 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0";
                end
                4 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0";
                end
                5 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0";
                end
                6 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0";
                end
                7 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0";
                end
                8 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0";
                end
                9 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_pxl_width_U0";
                end
                10 : begin
                    proc_path = "reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0";
                end
                11 : begin
                    proc_path = "reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0";
                end
                12 : begin
                    proc_path = "reversi_accel_reversi_accel.bgr2hsv_9_1024_1024_1_U0";
                end
                13 : begin
                    proc_path = "reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0";
                end
                14 : begin
                    proc_path = "reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_37_U0";
                end
                15 : begin
                    proc_path = "reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_U0";
                end
                16 : begin
                    proc_path = "reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0";
                end
                17 : begin
                    proc_path = "reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_7_7_1_1_U0";
                end
                18 : begin
                    proc_path = "reversi_accel_reversi_accel.erode_0_0_1024_1024_0_7_7_1_1_U0";
                end
                19 : begin
                    proc_path = "reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0";
                end
                20 : begin
                    proc_path = "reversi_accel_reversi_accel.dilate_0_0_1024_1024_2_3_3_1_1_U0";
                end
                21 : begin
                    proc_path = "reversi_accel_reversi_accel.erode_0_0_1024_1024_2_3_3_1_1_U0";
                end
                22 : begin
                    proc_path = "reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0";
                end
                23 : begin
                    proc_path = "reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_3_3_1_1_U0";
                end
                24 : begin
                    proc_path = "reversi_accel_reversi_accel.HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [992:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [992:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [992:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    1: begin
                        if (ap_sync_entry_proc40_U0_ap_ready & entry_proc40_U0.ap_idle & ~ap_sync_Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                        end
                    end
                    2: begin
                        if (ap_sync_entry_proc40_U0_ap_ready & entry_proc40_U0.ap_idle & ~ap_sync_Array2xfMat_32_9_1024_1024_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    2: begin
                        if (~Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0.stride_c_blk_n) begin
                            if (~stride_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.stride_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~stride_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.stride_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (ap_sync_Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0_ap_ready & Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0.ap_idle & ~ap_sync_Array2xfMat_32_9_1024_1024_1_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                        end
                    end
                    0: begin
                        if (ap_sync_Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0_ap_ready & Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0.ap_idle & ~ap_sync_entry_proc40_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.entry_proc40_U0'");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    1: begin
                        if (~add_ln22_loc_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.ap_idle & ~add_ln22_loc_channel_U.if_write) begin
                            if (~add_ln22_loc_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.add_ln22_loc_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.add_ln22_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~add_ln22_loc_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.add_ln22_loc_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.add_ln22_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_in_rows_c36_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.ap_idle & ~mat_in_rows_c36_channel_U.if_write) begin
                            if (~mat_in_rows_c36_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_rows_c36_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c36_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_rows_c36_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_rows_c36_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c36_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_in_cols_c37_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.ap_idle & ~mat_in_cols_c37_channel_U.if_write) begin
                            if (~mat_in_cols_c37_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_cols_c37_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c37_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_cols_c37_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_cols_c37_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c37_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.stride_blk_n) begin
                            if (~stride_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.stride_c_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~stride_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.stride_c_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (ap_sync_Array2xfMat_32_9_1024_1024_1_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.ap_idle & ~ap_sync_Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                        end
                    end
                    11: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72.mat_in_4228_blk_n) begin
                            if (~mat_in_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_data_U' written by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_data_U' read by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.mat_in_rows_c_blk_n) begin
                            if (~mat_in_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_rows_c_U' written by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_rows_c_U' read by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.mat_in_cols_c_blk_n) begin
                            if (~mat_in_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_cols_c_U' written by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_cols_c_U' read by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U.if_full_n & Array2xfMat_32_9_1024_1024_1_U0.ap_start & ~Array2xfMat_32_9_1024_1024_1_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'reversi_accel_reversi_accel.start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U' read by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0',");
                        end
                    end
                    0: begin
                        if (ap_sync_Array2xfMat_32_9_1024_1024_1_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.ap_idle & ~ap_sync_entry_proc40_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.entry_proc40_U0'");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    4: begin
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_entry_proc_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                        end
                    end
                    7: begin
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_entry_proc_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    10: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.rows_c_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.cols_c_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.stride_c_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_entry_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0'");
                        end
                    end
                    7: begin
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2AxiStream_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                        end
                    end
                    8: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U.if_full_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.ap_start & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0',");
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    6: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_full_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0.ap_done & ap_done_reg_1 & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_read) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_cast_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_tmp_loc_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    5: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.addrbound_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.p_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                7 : begin
                    case(index2)
                    3: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.din_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2AxiStream_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_entry_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.entry_proc_U0'");
                        end
                    end
                    10: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0.grp_Axi2AxiStream_Pipeline_MMIterInLoop1_fu_62.ldata1_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split46_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.axibound_V_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2AxiStream_U0_ap_ready & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ap_sync_Axi2Mat_Block_split4_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                        end
                    end
                    endcase
                end
                8 : begin
                    case(index2)
                    7: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72.ldata1_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.rows_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.cols_bound_per_npc_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.stride_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.start_for_AxiStream2Mat_U0_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0',");
                        end
                    end
                    endcase
                end
                9 : begin
                    case(index2)
                    10: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_pxl_width_U0.ap_done & ap_done_reg_4 & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_read) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                10 : begin
                    case(index2)
                    7: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.grp_AxiStream2MatStream_2_Pipeline_MMIterInLoopRow_fu_72.ldata1_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2AxiStream_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.ldata_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.rows_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.cols_bound_per_npc_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.stride_blk_n) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.Axi2Mat_Block_split4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.stride_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n & Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.AxiStream2MatStream_2_U0.ap_idle & ~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_write) begin
                            if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_pxl_width_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0.grp_Axi2Mat_fu_92.AxiStream2Mat_U0.last_blk_width_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                11 : begin
                    case(index2)
                    2: begin
                        if (~GaussianBlur_3_0_9_1024_1024_1_U0.p_src_rows_blk_n) begin
                            if (~mat_in_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_rows_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_rows_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~GaussianBlur_3_0_9_1024_1024_1_U0.p_src_cols_blk_n) begin
                            if (~mat_in_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_cols_c_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_cols_c_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~GaussianBlur_3_0_9_1024_1024_1_U0.grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81.grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_Pipeline_Col_Loop_fu_174.mat_in_4228_blk_n) begin
                            if (~mat_in_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_in_data_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_in_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_in_data_U' read by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_in_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U.if_empty_n & GaussianBlur_3_0_9_1024_1024_1_U0.ap_idle & ~start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'reversi_accel_reversi_accel.start_for_GaussianBlur_3_0_9_1024_1024_1_U0_U' written by process 'reversi_accel_reversi_accel.Array2xfMat_32_9_1024_1024_1_U0',");
                        end
                    end
                    12: begin
                        if (~GaussianBlur_3_0_9_1024_1024_1_U0.grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_s_fu_81.grp_xfGaussianFilter3x3_9_1024_1024_3_15_1_9_1024_Pipeline_Col_Loop_fu_174.mat_blur_4229_blk_n) begin
                            if (~mat_blur_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_blur_data_U' written by process 'reversi_accel_reversi_accel.bgr2hsv_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_blur_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_blur_data_U' read by process 'reversi_accel_reversi_accel.bgr2hsv_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                12 : begin
                    case(index2)
                    1: begin
                        if (~mat_blur_rows_channel_U.if_empty_n & bgr2hsv_9_1024_1024_1_U0.ap_idle & ~mat_blur_rows_channel_U.if_write) begin
                            if (~mat_blur_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_blur_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_blur_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_blur_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_blur_cols_channel_U.if_empty_n & bgr2hsv_9_1024_1024_1_U0.ap_idle & ~mat_blur_cols_channel_U.if_write) begin
                            if (~mat_blur_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_blur_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_blur_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_blur_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin
                        if (~bgr2hsv_9_1024_1024_1_U0.mat_blur_4229_blk_n) begin
                            if (~mat_blur_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_blur_data_U' written by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_blur_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_blur_data_U' read by process 'reversi_accel_reversi_accel.GaussianBlur_3_0_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_blur_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (~bgr2hsv_9_1024_1024_1_U0.mat_hsv_4230_blk_n) begin
                            if (~mat_hsv_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                13 : begin
                    case(index2)
                    1: begin
                        if (~mat_hsv_rows_channel_U.if_empty_n & duplicateMat_9_1024_1024_1_U0.ap_idle & ~mat_hsv_rows_channel_U.if_write) begin
                            if (~mat_hsv_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_hsv_cols_channel_U.if_empty_n & duplicateMat_9_1024_1024_1_U0.ap_idle & ~mat_hsv_cols_channel_U.if_write) begin
                            if (~mat_hsv_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin
                        if (~duplicateMat_9_1024_1024_1_U0.grp_duplicateMat_9_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_hsv_4230_blk_n) begin
                            if (~mat_hsv_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv_data_U' written by process 'reversi_accel_reversi_accel.bgr2hsv_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv_data_U' read by process 'reversi_accel_reversi_accel.bgr2hsv_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    14: begin
                        if (~duplicateMat_9_1024_1024_1_U0.grp_duplicateMat_9_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_hsv1_4231_blk_n) begin
                            if (~mat_hsv1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv1_data_U' written by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv1_data_U' read by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (~duplicateMat_9_1024_1024_1_U0.grp_duplicateMat_9_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_hsv2_4232_blk_n) begin
                            if (~mat_hsv2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv2_data_U' written by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv2_data_U' read by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                14 : begin
                    case(index2)
                    1: begin
                        if (~mat_hsv1_rows_channel_U.if_empty_n & inRange_9_0_1024_1024_1_37_U0.ap_idle & ~mat_hsv1_rows_channel_U.if_write) begin
                            if (~mat_hsv1_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv1_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv1_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv1_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_hsv1_cols_channel_U.if_empty_n & inRange_9_0_1024_1024_1_37_U0.ap_idle & ~mat_hsv1_cols_channel_U.if_write) begin
                            if (~mat_hsv1_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv1_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv1_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv1_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (~inRange_9_0_1024_1024_1_37_U0.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_s_fu_34.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_Pipeline_colLoop_fu_107.mat_hsv1_4231_blk_n) begin
                            if (~mat_hsv1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv1_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv1_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (~inRange_9_0_1024_1024_1_37_U0.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_s_fu_34.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_Pipeline_colLoop_fu_107.mat_green1_4233_blk_n) begin
                            if (~mat_green1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green1_data_U' written by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green1_data_U' read by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                15 : begin
                    case(index2)
                    1: begin
                        if (~mat_hsv2_rows_channel_U.if_empty_n & inRange_9_0_1024_1024_1_U0.ap_idle & ~mat_hsv2_rows_channel_U.if_write) begin
                            if (~mat_hsv2_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv2_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv2_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv2_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_hsv2_cols_channel_U.if_empty_n & inRange_9_0_1024_1024_1_U0.ap_idle & ~mat_hsv2_cols_channel_U.if_write) begin
                            if (~mat_hsv2_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv2_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv2_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv2_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin
                        if (~inRange_9_0_1024_1024_1_U0.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_s_fu_34.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_Pipeline_colLoop_fu_107.mat_hsv1_4231_blk_n) begin
                            if (~mat_hsv2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_hsv2_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_hsv2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_hsv2_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_9_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_hsv2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (~inRange_9_0_1024_1024_1_U0.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_s_fu_34.grp_xFinRangeKernel_9_0_1024_1024_15_0_1_9_1_1024_Pipeline_colLoop_fu_107.mat_green1_4233_blk_n) begin
                            if (~mat_green2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green2_data_U' written by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green2_data_U' read by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                16 : begin
                    case(index2)
                    1: begin
                        if (~mat_green1_rows_channel_U.if_empty_n & bitwise_or_0_1024_1024_1_U0.ap_idle & ~mat_green1_rows_channel_U.if_write) begin
                            if (~mat_green1_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green1_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green1_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green1_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_green1_cols_channel_U.if_empty_n & bitwise_or_0_1024_1024_1_U0.ap_idle & ~mat_green1_cols_channel_U.if_write) begin
                            if (~mat_green1_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green1_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green1_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green1_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    14: begin
                        if (~bitwise_or_0_1024_1024_1_U0.grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_green1_4233_blk_n) begin
                            if (~mat_green1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green1_data_U' written by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green1_data_U' read by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_37_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin
                        if (~bitwise_or_0_1024_1024_1_U0.grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_green2_4234_blk_n) begin
                            if (~mat_green2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green2_data_U' written by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green2_data_U' read by process 'reversi_accel_reversi_accel.inRange_9_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~bitwise_or_0_1024_1024_1_U0.grp_bitwise_or_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_green_4235_blk_n) begin
                            if (~mat_green_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                17 : begin
                    case(index2)
                    1: begin
                        if (~mat_green_rows_channel_U.if_empty_n & dilate_0_0_1024_1024_0_7_7_1_1_U0.ap_idle & ~mat_green_rows_channel_U.if_write) begin
                            if (~mat_green_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_green_cols_channel_U.if_empty_n & dilate_0_0_1024_1024_0_7_7_1_1_U0.ap_idle & ~mat_green_cols_channel_U.if_write) begin
                            if (~mat_green_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin
                        if (~dilate_0_0_1024_1024_0_7_7_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1027_7_7_s_fu_32.grp_xfdilate_1024_1024_1_0_1_0_1027_7_7_Pipeline_VITIS_LOOP_274_2_fu_193.mat_green_4235_blk_n) begin
                            if (~mat_green_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_green_data_U' written by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_green_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_green_data_U' read by process 'reversi_accel_reversi_accel.bitwise_or_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_green_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~dilate_0_0_1024_1024_0_7_7_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1027_7_7_s_fu_32.grp_xfdilate_1024_1024_1_0_1_0_1027_7_7_Pipeline_Col_Loop_fu_213.mat_dil_a_4236_blk_n) begin
                            if (~mat_dil_a_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_a_data_U' written by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_a_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_a_data_U' read by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                18 : begin
                    case(index2)
                    1: begin
                        if (~mat_dil_a_rows_channel_U.if_empty_n & erode_0_0_1024_1024_0_7_7_1_1_U0.ap_idle & ~mat_dil_a_rows_channel_U.if_write) begin
                            if (~mat_dil_a_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_a_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_a_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_a_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_dil_a_cols_channel_U.if_empty_n & erode_0_0_1024_1024_0_7_7_1_1_U0.ap_idle & ~mat_dil_a_cols_channel_U.if_write) begin
                            if (~mat_dil_a_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_a_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_a_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_a_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin
                        if (~erode_0_0_1024_1024_0_7_7_1_1_U0.grp_xferode_1024_1024_1_0_1_0_1027_7_7_s_fu_32.grp_xferode_1024_1024_1_0_1_0_1027_7_7_Pipeline_Col_Loop_fu_213.mat_dil_a_4236_blk_n) begin
                            if (~mat_dil_a_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_a_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_a_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_a_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~erode_0_0_1024_1024_0_7_7_1_1_U0.grp_xferode_1024_1024_1_0_1_0_1027_7_7_s_fu_32.grp_xferode_1024_1024_1_0_1_0_1027_7_7_Pipeline_Col_Loop_fu_213.mat_ero_4237_blk_n) begin
                            if (~mat_ero_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                19 : begin
                    case(index2)
                    1: begin
                        if (~mat_ero_rows_channel_U.if_empty_n & duplicateMat_0_1024_1024_1_U0.ap_idle & ~mat_ero_rows_channel_U.if_write) begin
                            if (~mat_ero_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_ero_cols_channel_U.if_empty_n & duplicateMat_0_1024_1024_1_U0.ap_idle & ~mat_ero_cols_channel_U.if_write) begin
                            if (~mat_ero_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin
                        if (~duplicateMat_0_1024_1024_1_U0.grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_ero_4237_blk_n) begin
                            if (~mat_ero_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero_data_U' written by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero_data_U' read by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_0_7_7_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    20: begin
                        if (~duplicateMat_0_1024_1024_1_U0.grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_ero1_4238_blk_n) begin
                            if (~mat_ero1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero1_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero1_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    21: begin
                        if (~duplicateMat_0_1024_1024_1_U0.grp_duplicateMat_0_1024_1024_1_Pipeline_Col_Loop_fu_54.mat_ero2_4239_blk_n) begin
                            if (~mat_ero2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero2_data_U' written by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero2_data_U' read by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                20 : begin
                    case(index2)
                    1: begin
                        if (~mat_ero1_rows_channel_U.if_empty_n & dilate_0_0_1024_1024_2_3_3_1_1_U0.ap_idle & ~mat_ero1_rows_channel_U.if_write) begin
                            if (~mat_ero1_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero1_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero1_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero1_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_ero1_cols_channel_U.if_empty_n & dilate_0_0_1024_1024_2_3_3_1_1_U0.ap_idle & ~mat_ero1_cols_channel_U.if_write) begin
                            if (~mat_ero1_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero1_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero1_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero1_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~dilate_0_0_1024_1024_2_3_3_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_s_fu_34.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_Pipeline_VITIS_LOOP_274_2_fu_155.mat_lap_4242_blk_n) begin
                            if (~mat_ero1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero1_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero1_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    22: begin
                        if (~dilate_0_0_1024_1024_2_3_3_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_s_fu_34.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_Pipeline_Col_Loop_fu_169.mat_dil_b_4243_blk_n) begin
                            if (~mat_lap1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap1_data_U' written by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap1_data_U' read by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                21 : begin
                    case(index2)
                    1: begin
                        if (~mat_ero2_rows_channel_U.if_empty_n & erode_0_0_1024_1024_2_3_3_1_1_U0.ap_idle & ~mat_ero2_rows_channel_U.if_write) begin
                            if (~mat_ero2_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero2_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero2_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero2_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_ero2_cols_channel_U.if_empty_n & erode_0_0_1024_1024_2_3_3_1_1_U0.ap_idle & ~mat_ero2_cols_channel_U.if_write) begin
                            if (~mat_ero2_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero2_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero2_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero2_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin
                        if (~erode_0_0_1024_1024_2_3_3_1_1_U0.grp_xferode_1024_1024_1_0_1_0_1025_3_3_s_fu_32.grp_xferode_1024_1024_1_0_1_0_1025_3_3_Pipeline_Col_Loop_fu_135.mat_ero2_4239_blk_n) begin
                            if (~mat_ero2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_ero2_data_U' written by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_ero2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_ero2_data_U' read by process 'reversi_accel_reversi_accel.duplicateMat_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_ero2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    22: begin
                        if (~erode_0_0_1024_1024_2_3_3_1_1_U0.grp_xferode_1024_1024_1_0_1_0_1025_3_3_s_fu_32.grp_xferode_1024_1024_1_0_1_0_1025_3_3_Pipeline_Col_Loop_fu_135.mat_lap2_4241_blk_n) begin
                            if (~mat_lap2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap2_data_U' written by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap2_data_U' read by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                22 : begin
                    case(index2)
                    1: begin
                        if (~mat_lap1_rows_channel_U.if_empty_n & bitwise_xor_0_1024_1024_1_U0.ap_idle & ~mat_lap1_rows_channel_U.if_write) begin
                            if (~mat_lap1_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap1_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap1_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap1_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_lap1_cols_channel_U.if_empty_n & bitwise_xor_0_1024_1024_1_U0.ap_idle & ~mat_lap1_cols_channel_U.if_write) begin
                            if (~mat_lap1_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap1_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap1_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap1_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    20: begin
                        if (~bitwise_xor_0_1024_1024_1_U0.grp_bitwise_xor_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_lap1_4240_blk_n) begin
                            if (~mat_lap1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap1_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap1_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    21: begin
                        if (~bitwise_xor_0_1024_1024_1_U0.grp_bitwise_xor_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_lap2_4241_blk_n) begin
                            if (~mat_lap2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap2_data_U' written by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap2_data_U' read by process 'reversi_accel_reversi_accel.erode_0_0_1024_1024_2_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    23: begin
                        if (~bitwise_xor_0_1024_1024_1_U0.grp_bitwise_xor_0_1024_1024_1_Pipeline_colLoop_fu_54.mat_lap_4242_blk_n) begin
                            if (~mat_lap_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                23 : begin
                    case(index2)
                    1: begin
                        if (~mat_lap_rows_channel_U.if_empty_n & dilate_0_0_1024_1024_0_3_3_1_1_U0.ap_idle & ~mat_lap_rows_channel_U.if_write) begin
                            if (~mat_lap_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_lap_cols_channel_U.if_empty_n & dilate_0_0_1024_1024_0_3_3_1_1_U0.ap_idle & ~mat_lap_cols_channel_U.if_write) begin
                            if (~mat_lap_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    22: begin
                        if (~dilate_0_0_1024_1024_0_3_3_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_s_fu_34.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_Pipeline_VITIS_LOOP_274_2_fu_155.mat_lap_4242_blk_n) begin
                            if (~mat_lap_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_lap_data_U' written by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_lap_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_lap_data_U' read by process 'reversi_accel_reversi_accel.bitwise_xor_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_lap_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    24: begin
                        if (~dilate_0_0_1024_1024_0_3_3_1_1_U0.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_s_fu_34.grp_xfdilate_1024_1024_1_0_1_0_1025_3_3_Pipeline_Col_Loop_fu_169.mat_dil_b_4243_blk_n) begin
                            if (~mat_dil_b_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_b_data_U' written by process 'reversi_accel_reversi_accel.HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_b_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_b_data_U' read by process 'reversi_accel_reversi_accel.HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                24 : begin
                    case(index2)
                    1: begin
                        if (~mat_dil_b_rows_channel_U.if_empty_n & HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0.ap_idle & ~mat_dil_b_rows_channel_U.if_write) begin
                            if (~mat_dil_b_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_b_rows_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_b_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_b_rows_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~mat_dil_b_cols_channel_U.if_empty_n & HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0.ap_idle & ~mat_dil_b_cols_channel_U.if_write) begin
                            if (~mat_dil_b_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_b_cols_channel_U' written by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_b_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_b_cols_channel_U' read by process 'reversi_accel_reversi_accel.Block_ZN2xf2cv3MatILi9ELi1024ELi1024ELi1ELi2EEC2Eii_exit4_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    23: begin
                        if (~HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0.grp_xfHoughLines_0_1024_1024_0_1_1_6u_3u_32_483_0_180_s_fu_64.grp_xfVoting_0_1024_1024_0_1_1_6u_3u_60_483_0_s_fu_322.grp_xfVoting_0_1024_1024_0_1_1_6u_3u_60_483_0_Pipeline_LOOPJ_fu_4720.mat_dil_b_4243_blk_n) begin
                            if (~mat_dil_b_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.mat_dil_b_data_U' written by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~mat_dil_b_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.mat_dil_b_data_U' read by process 'reversi_accel_reversi_accel.dilate_0_0_1024_1024_0_3_3_1_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.mat_dil_b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (~rho_out_c_channel_U.if_empty_n & HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0.ap_idle & ~rho_out_c_channel_U.if_write) begin
                            if (~rho_out_c_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.rho_out_c_channel_U' written by process 'reversi_accel_reversi_accel.entry_proc40_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.rho_out_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~rho_out_c_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.rho_out_c_channel_U' read by process 'reversi_accel_reversi_accel.entry_proc40_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.rho_out_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~theta_out_c_channel_U.if_empty_n & HoughLines_3u_6u_32_483_0_180_0_1024_1024_1_U0.ap_idle & ~theta_out_c_channel_U.if_write) begin
                            if (~theta_out_c_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'reversi_accel_reversi_accel.theta_out_c_channel_U' written by process 'reversi_accel_reversi_accel.entry_proc40_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.theta_out_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~theta_out_c_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'reversi_accel_reversi_accel.theta_out_c_channel_U' read by process 'reversi_accel_reversi_accel.entry_proc40_U0'");
                                $fdisplay(fp, "Dependence_Channel_path reversi_accel_reversi_accel.theta_out_c_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        find_df_deadlock = 1;
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
