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

interface cr_top_interface(input logic clk);

    ahb_interface  AHB_INF (clk);
    apb_interface  APB_INF (clk);

endinterface:cr_top_interface

`endif //CR_TOP_INTERFACE__SV
