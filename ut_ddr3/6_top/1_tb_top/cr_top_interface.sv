//===============================================================
//Copyright (c): Corerain Technology Co.,Ltd. ALL rights reserved. 
//                                                                 
//  Create by:
//      Email:
//       Date:
//   Filename:
//Description:
//    Version:
//Last Change:
//                                                                 
//===============================================================
                                                                 
`ifndef CR_TOP_INTERFACE__SV
`define CR_TOP_INTERFACE__SV

interface cr_top_interface(input logic clk,input logic rst_n);

  svt_axi_if axi_if();
  assign axi_if.common_aclk = clk;
  assign axi_if.master_if[0].aresetn = rst_n;
  assign axi_if.slave_if[0].aresetn = rst_n;
  
  axi_reset_if axi_reset_if();
  assign axi_reset_if.clk = clk;

  mem_if   m_mem_if();


  `include "../../2_bfm/1_interface/if_svt_adapter.sv"



endinterface:cr_top_interface

`endif //CR_TOP_INTERFACE__SV
