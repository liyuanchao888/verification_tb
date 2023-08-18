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

module tb_top(cr_top_interface top_if);

    initial begin
//        `uvm_info (get_type_name(), $sformatf(" top start =%0d",dma_width), UVM_NONE);
//        uvm_config_db#(virtual if_apb)::set(uvm_root::get(), "*.m_env.m_agt_apb", "m_vif_apb", m_vif_apb);
        uvm_config_db#(virtual axi_reset_if.axi_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", top_if.axi_reset_if.axi_reset_modport);
        uvm_config_db#(svt_axi_vif)::set(uvm_root::get(), "uvm_test_top.env.axi_system_env", "vif", top_if.axi_if);

        run_test();//uvm_testcase=c_simple_test_rw.sv
    end

//	`include "cr_top_sub_connect.svh"

endmodule:tb_top

`endif//TB_TOP__SV
