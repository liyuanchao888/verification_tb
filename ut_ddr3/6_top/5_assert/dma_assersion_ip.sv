//+++++++++++++++++++++++++++++++++++++++++++++++++
//   Assertion Verification IP
//+++++++++++++++++++++++++++++++++++++++++++++++++
`ifndef DMA_ASSERTION_IP__SV
`define DMA_ASSERTION_IP__SV
module dma_assertion_ip
# (
 parameter w = 32,
 parameter b=8
)
(
  input aclk,
  aresetn,
  arvalid,
  arready,
     [31:0]  araddr,
     [b-1:0] arlen,
     [ 2:0]  arsize,
     [ 1:0]  arburst,
     [ 5:0]  arid,
             arlock,
     [ 3:0]  arcache,
     [ 2:0]  arprot,
     [ 3:0]  arqos,
             awvalid,
              awready,
     [ 5:0]  awid,
     [31:0]  awaddr,
     [b-1:0] awlen,
     [ 2:0]  awsize,
     [ 1:0]  awburst,
             awlock,
     [ 3:0]  awcache,
     [ 2:0]  awprot,
     [ 3:0]  awqos,
             wvalid,
              wready,
     [w-1:0] wdata,
     [(w/8)-1:0] wstrb,
             wlast,
              rvalid,
             rready,
      [ 5:0]  rid,
      [w-1:0] rdata,
      [ 1:0]  rresp,
              rlast,
              bvalid,
             bready,
      [ 5:0]  bid,
      [ 1:0]  bresp,

  // Command Interface (APB slave)
              pclk,
              presetn,
      [11:0]  paddr,
      [ 2:0]  pprot,
              psel,
              penable,
              pwrite,
      [31:0]  pwdata,
      [ 3:0]  pstrb,
             pready,
     [31:0]  prdata,
             pslverr,

  // Memory to Logic Interface (SIF source)
             m2l0_vld,
     [w-1:0] m2l0_dat,
              m2l0_rdy,

             m2l1_vld,
     [w-1:0] m2l1_dat,
              m2l1_rdy,

             m2l2_vld,
     [w-1:0] m2l2_dat,
              m2l2_rdy,

             m2l3_vld,
     [w-1:0] m2l3_dat,
              m2l3_rdy,

             m2l4_vld,
     [w-1:0] m2l4_dat,
              m2l4_rdy,

             m2l5_vld,
     [w-1:0] m2l5_dat,
              m2l5_rdy,

             m2l6_vld,
     [w-1:0] m2l6_dat,
              m2l6_rdy,

             m2l7_vld,
     [w-1:0] m2l7_dat,
              m2l7_rdy,

  // Logic to Memory Interface (SIF destination)
              l2m0_vld,
      [w-1:0] l2m0_dat,
             l2m0_rdy,

              l2m1_vld,
      [w-1:0] l2m1_dat,
             l2m1_rdy,

              l2m2_vld,
      [w-1:0] l2m2_dat,
             l2m2_rdy,

              l2m3_vld,
      [w-1:0] l2m3_dat,
             l2m3_rdy,

              l2m4_vld,
      [w-1:0] l2m4_dat,
             l2m4_rdy,

              l2m5_vld,
      [w-1:0] l2m5_dat,
             l2m5_rdy,

              l2m6_vld,
      [w-1:0] l2m6_dat,
             l2m6_rdy,

              l2m7_vld,
      [w-1:0] l2m7_dat,
             l2m7_rdy,

  // IRQ
             rirq,
             wirq
); // dma

//=================================================
// Sequence Layer
//=================================================


//=================================================
// Property Specification Layer
//=================================================
property read_addr;
//  @(posedge aclk) disable iff(!aresetn)
  @(posedge aclk)
    arvalid |-> (!arready);
endproperty

//=================================================
// Assertion Directive Layer
//=================================================
read_addr_assert: assert property (read_addr)
//                  $display("xxxxxxxxxxxxx @%0dns Assertion sucessful", $time);
                  else
                  $display(" @%0dns Assertion Failed", $time);
endmodule				  
`endif
