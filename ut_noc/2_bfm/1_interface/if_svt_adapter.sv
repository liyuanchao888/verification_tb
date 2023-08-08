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

genvar m_i ;
genvar s_j ;

generate

for(m_i=0; m_i <TbNumMasters; m_i++) begin
    assign  master[m_i].aw_id       = axi_if.master_if[m_i].awid     ;
    assign  master[m_i].aw_addr     = axi_if.master_if[m_i].awaddr   ;
    assign  master[m_i].aw_len      = axi_if.master_if[m_i].awlen    ;
    assign  master[m_i].aw_size     = axi_if.master_if[m_i].awsize   ;
    assign  master[m_i].aw_burst    = axi_if.master_if[m_i].awburst  ;
    assign  master[m_i].aw_lock     = axi_if.master_if[m_i].awlock   ;
    assign  master[m_i].aw_cache    = axi_if.master_if[m_i].awcache  ;
    assign  master[m_i].aw_prot     = axi_if.master_if[m_i].awprot   ;
    assign  master[m_i].aw_qos      = axi_if.master_if[m_i].awqos    ;
    assign  master[m_i].aw_region   = axi_if.master_if[m_i].awregion ;
    assign  master[m_i].aw_atop     = axi_if.master_if[m_i].awatop   ;
    assign  master[m_i].aw_user     = axi_if.master_if[m_i].awuser   ;
    assign  master[m_i].aw_valid    = axi_if.master_if[m_i].awvalid  ;

	assign  axi_if.master_if[m_i].awready = master[m_i].aw_ready     ;

    assign  master[m_i].w_data      = axi_if.master_if[m_i].wdata    ;
    assign  master[m_i].w_strb      = axi_if.master_if[m_i].wstrb    ;
    assign  master[m_i].w_last      = axi_if.master_if[m_i].wlast    ;
    assign  master[m_i].w_user      = axi_if.master_if[m_i].wuser    ;
    assign  master[m_i].w_valid     = axi_if.master_if[m_i].wvalid   ;
    assign  axi_if.master_if[m_i].wready = master[m_i].w_ready       ;

    assign  axi_if.master_if[m_i].bid    = master[m_i].b_id          ;
    assign  axi_if.master_if[m_i].bresp  = master[m_i].b_resp        ;
    assign  axi_if.master_if[m_i].buser  = master[m_i].b_user        ;
    assign  axi_if.master_if[m_i].bvalid = master[m_i].b_valid       ;
    assign  master[m_i].b_ready     = axi_if.master_if[m_i].bready   ;
	
    assign  master[m_i].ar_id       = axi_if.master_if[m_i].arid     ;
    assign  master[m_i].ar_addr     = axi_if.master_if[m_i].araddr   ;
    assign  master[m_i].ar_len      = axi_if.master_if[m_i].arlen    ;
    assign  master[m_i].ar_size     = axi_if.master_if[m_i].arsize   ;
    assign  master[m_i].ar_burst    = axi_if.master_if[m_i].arburst  ;
    assign  master[m_i].ar_lock     = axi_if.master_if[m_i].arlock   ;
    assign  master[m_i].ar_cache    = axi_if.master_if[m_i].arcache  ;
    assign  master[m_i].ar_prot     = axi_if.master_if[m_i].arprot   ;
    assign  master[m_i].ar_qos      = axi_if.master_if[m_i].arqos    ;
    assign  master[m_i].ar_region   = axi_if.master_if[m_i].arregion ;
    assign  master[m_i].ar_user     = axi_if.master_if[m_i].aruser   ;
    assign  master[m_i].ar_valid    = axi_if.master_if[m_i].arvalid  ;

	assign  axi_if.master_if[m_i].arready = master[m_i].ar_ready     ;

    assign  axi_if.master_if[m_i].rid    =  master[m_i].r_id           ;
    assign  axi_if.master_if[m_i].rdata  =  master[m_i].r_data         ;
    assign  axi_if.master_if[m_i].rresp  =  master[m_i].r_resp         ;
    assign  axi_if.master_if[m_i].rlast  =  master[m_i].r_last         ;
    assign  axi_if.master_if[m_i].ruser  =  master[m_i].r_user         ;
    assign  axi_if.master_if[m_i].rvalid =  master[m_i].r_valid        ;
    assign  master[m_i].r_ready    = axi_if.master_if[m_i].rready      ;

end

for(s_j=0; s_j<TbNumSlaves;s_j++) begin

    //aw-channel
    assign  axi_if.slave_if[s_j].awid       = slave[s_j].aw_id     ;
    assign  axi_if.slave_if[s_j].awaddr     = slave[s_j].aw_addr   ;
    assign  axi_if.slave_if[s_j].awlen      = slave[s_j].aw_len    ;
    assign  axi_if.slave_if[s_j].awsize     = slave[s_j].aw_size   ;
    assign  axi_if.slave_if[s_j].awburst    = slave[s_j].aw_burst  ;
    assign  axi_if.slave_if[s_j].awlock     = slave[s_j].aw_lock   ;
    assign  axi_if.slave_if[s_j].awcache    = slave[s_j].aw_cache  ;
    assign  axi_if.slave_if[s_j].awprot     = slave[s_j].aw_prot   ;
    assign  axi_if.slave_if[s_j].awqos      = slave[s_j].aw_qos    ;
    assign  axi_if.slave_if[s_j].awregion   = slave[s_j].aw_region ;
    assign  axi_if.slave_if[s_j].awatop     = slave[s_j].aw_atop   ;
    assign  axi_if.slave_if[s_j].awuser     = slave[s_j].aw_user   ;
    assign  axi_if.slave_if[s_j].awvalid    = slave[s_j].aw_valid  ;

	assign  slave[s_j].aw_ready = axi_if.slave_if[s_j].awready     ;

	//w-channel
    assign  axi_if.slave_if[s_j].wid        = slave[s_j].aw_id     ; //ycli add for axi4 to axi3, use awid to wid
    assign  axi_if.slave_if[s_j].wdata      = slave[s_j].w_data    ;
    assign  axi_if.slave_if[s_j].wstrb      = slave[s_j].w_strb    ;
    assign  axi_if.slave_if[s_j].wlast      = slave[s_j].w_last    ;
    assign  axi_if.slave_if[s_j].wuser      = slave[s_j].w_user    ;
    assign  axi_if.slave_if[s_j].wvalid     = slave[s_j].w_valid   ;
    assign  slave[s_j].w_ready = axi_if.slave_if[s_j].wready       ;

    //respond-channel
    assign  slave[s_j].b_id    = axi_if.slave_if[s_j].bid          ;
    assign  slave[s_j].b_resp  = axi_if.slave_if[s_j].bresp        ;
    assign  slave[s_j].b_user  = axi_if.slave_if[s_j].buser        ;
    assign  slave[s_j].b_valid = axi_if.slave_if[s_j].bvalid       ;
    assign  axi_if.slave_if[s_j].bready     = slave[s_j].b_ready   ;
	
    //ar-channel
    assign  axi_if.slave_if[s_j].arid       = slave[s_j].ar_id     ;
    assign  axi_if.slave_if[s_j].araddr     = slave[s_j].ar_addr   ;
    assign  axi_if.slave_if[s_j].arlen      = slave[s_j].ar_len    ;
    assign  axi_if.slave_if[s_j].arsize     = slave[s_j].ar_size   ;
    assign  axi_if.slave_if[s_j].arburst    = slave[s_j].ar_burst  ;
    assign  axi_if.slave_if[s_j].arlock     = slave[s_j].ar_lock   ;
    assign  axi_if.slave_if[s_j].arcache    = slave[s_j].ar_cache  ;
    assign  axi_if.slave_if[s_j].arprot     = slave[s_j].ar_prot   ;
    assign  axi_if.slave_if[s_j].arqos      = slave[s_j].ar_qos    ;
    assign  axi_if.slave_if[s_j].arregion   = slave[s_j].ar_region ;
    assign  axi_if.slave_if[s_j].aruser     = slave[s_j].ar_user   ;
    assign  axi_if.slave_if[s_j].arvalid    = slave[s_j].ar_valid  ;

	assign  slave[s_j].ar_ready = axi_if.slave_if[s_j].arready     ;

    //r-channel
    assign  slave[s_j].r_id    =  axi_if.slave_if[s_j].rid           ;
    assign  slave[s_j].r_data  =  axi_if.slave_if[s_j].rdata         ;
    assign  slave[s_j].r_resp  =  axi_if.slave_if[s_j].rresp         ;
    assign  slave[s_j].r_last  =  axi_if.slave_if[s_j].rlast         ;
    assign  slave[s_j].r_user  =  axi_if.slave_if[s_j].ruser         ;
    assign  slave[s_j].r_valid =  axi_if.slave_if[s_j].rvalid        ;
    assign  axi_if.slave_if[s_j].rready    = slave[s_j].r_ready      ;


end

endgenerate
//  modport Master (
//    output aw_id, aw_addr, aw_len, aw_size, aw_burst, aw_lock, aw_cache, aw_prot, aw_qos, aw_region, aw_atop, aw_user, aw_valid, input aw_ready,
//    output w_data, w_strb, w_last, w_user, w_valid, input w_ready,
//    input b_id, b_resp, b_user, b_valid, output b_ready,
//    output ar_id, ar_addr, ar_len, ar_size, ar_burst, ar_lock, ar_cache, ar_prot, ar_qos, ar_region, ar_user, ar_valid, input ar_ready,
//    input r_id, r_data, r_resp, r_last, r_user, r_valid, output r_ready
//  );
//
//  modport Slave (
//    input aw_id, aw_addr, aw_len, aw_size, aw_burst, aw_lock, aw_cache, aw_prot, aw_qos, aw_region, aw_atop, aw_user, aw_valid, output aw_ready,
//    input w_data, w_strb, w_last, w_user, w_valid, output w_ready,
//    output b_id, b_resp, b_user, b_valid, input b_ready,
//    input ar_id, ar_addr, ar_len, ar_size, ar_burst, ar_lock, ar_cache, ar_prot, ar_qos, ar_region, ar_user, ar_valid, output ar_ready,
//    output r_id, r_data, r_resp, r_last, r_user, r_valid, input r_ready
//  );

`endif
