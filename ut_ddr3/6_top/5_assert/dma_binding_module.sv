//+++++++++++++++++++++++++++++++++++++++++++++++++
//  Binding File 
//+++++++++++++++++++++++++++++++++++++++++++++++++
`ifndef BINDING_MODULE__SV
`define BINDING_MODULE__SV
module dma_binding_module();
//=================================================
// Bind by Module name : This will bind all instance
// of DUT
//=================================================
// Here RTL : stands for design under test
//      VIP : Assertion file
//   RTL Module Name  VIP module Name   Instance Name
bind dma dma_assertion_ip u_assert_ip (
// .vip port (RTL port)
  .aclk ( aclk ),
  .aresetn ( aresetn ),
  .arvalid ( arvalid ),
  .arready ( arready ),
  .arid (  arid ),
  .araddr ( araddr ),
  .arlen ( arlen ),
  .arsize ( arsize ),
  .arburst ( arburst ),
  .arlock ( arlock ),
  .arcache ( arcache ),
  .arprot ( arprot ),
  .arqos ( arqos ),
  .awvalid ( awvalid ),
  .awready ( awready ),
  .awid (  awid ),
  .awaddr ( awaddr ),
  .awlen ( awlen ),
  .awsize ( awsize ),
  .awburst ( awburst ),
  .awlock ( awlock ),
  .awcache ( awcache ),
  .awprot ( awprot ),
  .awqos ( awqos ),
  .wvalid ( wvalid ),
  .wready ( wready ),
  .wdata ( wdata ),
  .wstrb ( wstrb ),
  .wlast ( wlast ),
  .rvalid ( rvalid ),
  .rready ( rready ),
  .rid (  rid ),
  .rdata ( rdata ),
  .rresp ( rresp ),
  .rlast ( rlast ),
  .bvalid ( bvalid ),
  .bready ( bready ),
  .bid ( bid ),
  .bresp (bresp ),

  .pclk (pclk ),
  .presetn (presetn ),
  .paddr (paddr ),
  .pprot (pprot ),
  .psel (psel ),
  .penable (penable ),
  .pwrite (pwrite ),
  .pwdata (pwdata ),
  .pstrb (pstrb ),
  .pready (pready ),
  .prdata (prdata ),
  .pslverr (pslverr ),
 
  .m2l0_vld (m2l0_vld), //dma0 m2l channel0 is used for input data of conv
  .m2l0_dat (m2l0_dat),
  .m2l0_rdy (m2l0_rdy),

  .m2l1_vld (m2l1_vld), //dma0 m2l channel1 is used for input coef of conv
  .m2l1_dat (m2l1_dat),
  .m2l1_rdy (m2l1_rdy),

  .m2l2_vld (m2l2_vld), //dma0 m2l channel2 is used for bn a of conv
  .m2l2_dat (m2l2_dat),
  .m2l2_rdy (m2l2_rdy),

  .m2l3_vld (m2l3_vld), //dma0 m2l channel3 is used for bn b of conv
  .m2l3_dat (m2l3_dat),
  .m2l3_rdy (m2l3_rdy),

  .m2l4_vld (m2l4_vld), //dma0 m2l channel4 is used for bias of conv
  .m2l4_dat (m2l4_dat),
  .m2l4_rdy (m2l4_rdy),

  .m2l5_vld (m2l5_vld),
  .m2l5_dat (m2l5_dat),
  .m2l5_rdy (m2l5_rdy),

  .m2l6_vld (m2l6_vld),
  .m2l6_dat (m2l6_dat),
  .m2l6_rdy (m2l6_rdy),

  .m2l7_vld (m2l7_vld),
  .m2l7_dat (m2l7_dat),
  .m2l7_rdy (m2l7_rdy),

  // Logic to Memory Interface (SIF destination)
  .l2m0_vld (l2m0_vld), //dma0 l2m channel0 is used for output result of conv
  .l2m0_dat (l2m0_dat),
  .l2m0_rdy (l2m0_rdy),

  .l2m1_vld (l2m1_vld),
  .l2m1_dat (l2m1_dat),
  .l2m1_rdy (l2m1_rdy),

  .l2m2_vld (l2m2_vld),
  .l2m2_dat (l2m2_dat),
  .l2m2_rdy (l2m2_rdy),

  .l2m3_vld (l2m3_vld),
  .l2m3_dat (l2m3_dat),
  .l2m3_rdy (l2m3_rdy),

  .l2m4_vld (l2m4_vld),
  .l2m4_dat (l2m4_dat),
  .l2m4_rdy (l2m4_rdy),

  .l2m5_vld (l2m5_vld),
  .l2m5_dat (l2m5_dat),
  .l2m5_rdy (l2m5_rdy),

  .l2m6_vld (l2m6_vld),
  .l2m6_dat (l2m6_dat),
  .l2m6_rdy (l2m6_rdy),

  .l2m7_vld (l2m7_vld),
  .l2m7_dat (l2m7_dat),
  .l2m7_rdy (l2m7_rdy),

 // .rbusy  ( ), // not in use
 // .wbusy  ( ), // not in use

  .rirq ( rirq ),
  .wirq ( wirq )
);
//=================================================
// Bind by instance name : This will bind only instance
//  names in list
//=================================================
// Here RTL : stands for design under test
//      VIP : Assertion file
//     RTL Module Name Instance Path               VIP module Name Instance Name
//bind bind_assertion :$root.bind_assertion_tb.dut assertion_ip    U_assert_ip (
// .vip port (RTL port)
// .clk_ip   (clk),
// .req_ip   (req),
// .reset_ip (reset),
// .gnt_ip   (gnt)
//);
//=================================================

endmodule
`endif
