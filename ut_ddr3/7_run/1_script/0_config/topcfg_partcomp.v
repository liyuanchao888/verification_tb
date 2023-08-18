//===============================================================
//Copyright (c): ALL rights reserved. 
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
                                                                 
`ifndef TOPCFG_PARTCOMP__SV
`define TOPCFG_PARTCOMP__SV
config topcfg_partcomp;

      design test_top;
	  //partition instance uvm_pkg::**
	  partition instance test_top.DUT;
	  partition package uvm_pkg;
	  partition package svt_uvm_pkg;
	  partition package svt_axi_uvm_pkg;
	  partition package svt_apb_uvm_pkg;
	  partition package svt_ahb_uvm_pkg;
	  partition package svt_amba_common_uvm_pkg;

endconfig

`endif
