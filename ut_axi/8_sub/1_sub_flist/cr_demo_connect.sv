//===============================================================
//Copyright (c): ALL rights reserved. 
//                                                                 
//  Create by:
//      Email:
//       Date:
//   Filename:
//Description: parent connect to sub env
//    Version:
//Last Change:
//                                                                 
//===============================================================
                                                                 
`ifndef CR_DEMO_CONNECT__SV
`define CR_DEMO_CONNECT__SV
//assign pcie_tb_if.pcie_dm_init = `PCIE_SUBSYS.pcie0_init;

//initial begin
//    uvm_config_db#(virtual axi_reset_if.axi_reset_modport)::set(uvm_root::get(),"uvm_test_top.top_env.m_pcie_env.axi_env.axi_sequencer_dm[0]","reset_mp",axi_reset_if_dm[0].axi_reset_modport)
//    uvm_config_db#(svt_axi_vif)::set(uvm_root::get(),"uvm_test_top.top_env.m_pcie_env.axi_env.axi_system_env_dm[0]","vif",axi_if_dm[0]);
//end

//initial begin
//    force `PCIE_SUBSYS.U_pipe_wrapper.phy0.pma.ana.lane0.tx.rxdetect.tx_rxdet_m_result = 0 ;
//end

//`ifdef ASSERT_ON
//bind `PCIE_SUBSYS pcie_assert u_pcie_assert(.*);
//`endif

`endif
