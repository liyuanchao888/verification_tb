//===============================================================
//Copyright (c):  
//  Create by: ycli 
//      Email: 
//       Date: 2023/7/25
//   Filename: tb_top.sv
//Description: testbench initial and enter in test_top
//    Version: v1.0
//Last Change: 2023/7/25
//===============================================================
                                                                 
`ifndef TB_TOP__SV
`define TB_TOP__SV
import uvm_pkg::*;
module tb_top(cr_top_interface top_if);

    initial begin
//        `uvm_info (get_type_name(), $sformatf(" top start =%0d",dma_width), UVM_NONE);
//        uvm_config_db#(virtual if_apb)::set(uvm_root::get(), "*.m_env.m_agt_apb", "m_vif_apb", m_vif_apb);
        uvm_config_db # (virtual ahb_interface) :: set(null,"*","ahb_vif",top_if.AHB_INF);
		uvm_config_db # (virtual apb_interface) :: set(null,"*","apb_vif",top_if.APB_INF);

        run_test();//uvm_testcase=c_simple_test_rw.sv
    end

//	`include "cr_top_sub_connect.svh"

endmodule:tb_top

`endif//TB_TOP__SV
