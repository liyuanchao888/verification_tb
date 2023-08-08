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

//  assign axi_if.master_if[1].aresetn = rst_n;
//  assign axi_if.slave_if[1].aresetn = rst_n;
  

  /** TB Interface instance to provide access to the reset signal */
  axi_reset_if axi_reset_if();
  assign axi_reset_if.clk = clk;


  // -------------------------------
  // AXI Interfaces
  // -------------------------------
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( TbAxiAddrWidth      ),
    .AXI_DATA_WIDTH ( TbAxiDataWidth      ),
    .AXI_ID_WIDTH   ( TbAxiIdWidthMasters ),
    .AXI_USER_WIDTH ( TbAxiUserWidth      )
  ) master [TbNumMasters-1:0] ();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( TbAxiAddrWidth     ),
    .AXI_DATA_WIDTH ( TbAxiDataWidth     ),
    .AXI_ID_WIDTH   ( TbAxiIdWidthSlaves ),
    .AXI_USER_WIDTH ( TbAxiUserWidth     )
  ) slave [TbNumSlaves-1:0] ();

//	ahb_interface  AHB_INF (clk);
//  apb_interface  APB_INF (clk);

`include "../../2_bfm/1_interface/if_svt_adapter.sv"


//    assign  master[0].aw_id       = axi_if.master_if[0].awid     ;
endinterface:cr_top_interface

`endif //CR_TOP_INTERFACE__SV
