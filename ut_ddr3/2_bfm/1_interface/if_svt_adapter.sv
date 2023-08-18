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
                                                                 
`ifndef IF_SVT_ADAPTER__SV
`define IF_SVT_ADAPTER__SV

//genvar m_i ;
parameter int unsigned m_i         = 32'd0;
genvar s_j ;
parameter int unsigned TbNumSlaves         = 32'd0;

//generate
//for(s_j=0; s_j<TbNumSlaves;s_j++) begin
//
//    //aw-channel
//    assign  axi_if.slave_if[s_j].awid       = axi_if.master_if[m_i].awid     ;
//    assign  axi_if.slave_if[s_j].awaddr     = axi_if.master_if[m_i].awaddr   ;
//    assign  axi_if.slave_if[s_j].awlen      = axi_if.master_if[m_i].awlen    ;
//    assign  axi_if.slave_if[s_j].awsize     = axi_if.master_if[m_i].awsize   ;
//    assign  axi_if.slave_if[s_j].awburst    = axi_if.master_if[m_i].awburst  ;
//    assign  axi_if.slave_if[s_j].awlock     = axi_if.master_if[m_i].awlock   ;
//    assign  axi_if.slave_if[s_j].awcache    = axi_if.master_if[m_i].awcache  ;
//    assign  axi_if.slave_if[s_j].awprot     = axi_if.master_if[m_i].awprot   ;
//    assign  axi_if.slave_if[s_j].awqos      = axi_if.master_if[m_i].awqos    ;
//    assign  axi_if.slave_if[s_j].awregion   = axi_if.master_if[m_i].awregion ;
//    assign  axi_if.slave_if[s_j].awatop     = axi_if.master_if[m_i].awatop   ;
//    assign  axi_if.slave_if[s_j].awuser     = axi_if.master_if[m_i].awuser   ;
//    assign  axi_if.slave_if[s_j].awvalid    = axi_if.master_if[m_i].awvalid  ;
//
////	assign  slave[s_j].aw_ready = axi_if.slave_if[s_j].awready     ;
//
//	//w-channel
//    assign  axi_if.slave_if[s_j].wid        = axi_if.master_if[m_i].awid     ; //ycli add for axi4 to axi3, use awid to wid
//    assign  axi_if.slave_if[s_j].wdata      = axi_if.master_if[m_i].wdata    ;
//    assign  axi_if.slave_if[s_j].wstrb      = axi_if.master_if[m_i].wstrb    ;
//    assign  axi_if.slave_if[s_j].wlast      = axi_if.master_if[m_i].wlast    ;
//    assign  axi_if.slave_if[s_j].wuser      = axi_if.master_if[m_i].wuser    ;
//    assign  axi_if.slave_if[s_j].wvalid     = axi_if.master_if[m_i].wvalid   ;
////    assign  slave[s_j].w_ready = axi_if.slave_if[s_j].wready       ;
//
//    //respond-channel
////    assign  slave[s_j].b_id    = axi_if.slave_if[s_j].bid          ;
////    assign  slave[s_j].b_resp  = axi_if.slave_if[s_j].bresp        ;
////    assign  slave[s_j].b_user  = axi_if.slave_if[s_j].buser        ;
////    assign  slave[s_j].b_valid = axi_if.slave_if[s_j].bvalid       ;
//    assign  axi_if.slave_if[s_j].bready     = axi_if.master_if[m_i].bready   ;
//	
//    //ar-channel
//    assign  axi_if.slave_if[s_j].arid       = axi_if.master_if[m_i].arid     ;
//    assign  axi_if.slave_if[s_j].araddr     = axi_if.master_if[m_i].araddr   ;
//    assign  axi_if.slave_if[s_j].arlen      = axi_if.master_if[m_i].arlen    ;
//    assign  axi_if.slave_if[s_j].arsize     = axi_if.master_if[m_i].arsize   ;
//    assign  axi_if.slave_if[s_j].arburst    = axi_if.master_if[m_i].arburst  ;
//    assign  axi_if.slave_if[s_j].arlock     = axi_if.master_if[m_i].arlock   ;
//    assign  axi_if.slave_if[s_j].arcache    = axi_if.master_if[m_i].arcache  ;
//    assign  axi_if.slave_if[s_j].arprot     = axi_if.master_if[m_i].arprot   ;
//    assign  axi_if.slave_if[s_j].arqos      = axi_if.master_if[m_i].arqos    ;
//    assign  axi_if.slave_if[s_j].arregion   = axi_if.master_if[m_i].arregion ;
//    assign  axi_if.slave_if[s_j].aruser     = axi_if.master_if[m_i].aruser   ;
//    assign  axi_if.slave_if[s_j].arvalid    = axi_if.master_if[m_i].arvalid  ;
//
////	assign  slave[s_j].ar_ready = axi_if.slave_if[s_j].arready     ;
//
//    //r-channel
////    assign  slave[s_j].r_id    =  axi_if.slave_if[s_j].rid           ;
////    assign  slave[s_j].r_data  =  axi_if.slave_if[s_j].rdata         ;
////    assign  slave[s_j].r_resp  =  axi_if.slave_if[s_j].rresp         ;
////    assign  slave[s_j].r_last  =  axi_if.slave_if[s_j].rlast         ;
////    assign  slave[s_j].r_user  =  axi_if.slave_if[s_j].ruser         ;
////    assign  slave[s_j].r_valid =  axi_if.slave_if[s_j].rvalid        ;
//    assign  axi_if.slave_if[s_j].rready    = axi_if.master_if[m_i].rready        ;
//
//
//end
//
//endgenerate


`endif
