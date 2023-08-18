`ifndef IF_AXI__SV
`define IF_AXI__SV

`timescale 1ns/1ns

interface if_axi(input logic aclk,input logic aresetn);
    localparam dma_width = `DMA_WIDTH ;
    localparam b = 4  ;
    logic                       arvalid ; //input 
    logic                       arready ; //output
    logic [ 5  :0]              arid    ; //input 
    logic [31  :0]              araddr  ; //input 
    logic [b-1 :0]              arlen   ; //input 
    logic [ 2  :0]              arsize  ; //input 
    logic [ 1  :0]              arburst ; //input 
    logic                       arlock  ; //input 
    logic [ 3  :0]              arcache ; //input 
    logic [ 2  :0]              arprot  ; //input 
    logic [ 3  :0]              arqos   ; //input 
    logic                       awvalid ; //input 
    logic                       awready ; //output
    logic [ 5  :0]              awid    ; //input 
    logic [31  :0]              awaddr  ; //input 
    logic [b-1 :0]              awlen   ; //input 
    logic [ 2  :0]              awsize  ; //input 
    logic [ 1  :0]              awburst ; //input 
    logic                       awlock  ; //input 
    logic [ 3  :0]              awcache ; //input 
    logic [ 2  :0]              awprot  ; //input 
    logic [ 3  :0]              awqos   ; //input 
    logic                       wvalid  ; //input 
    logic                       wready  ; //output
    logic [dma_width-1 :0]      wdata   ; //input 
    logic [(dma_width/8)-1:0]   wstrb   ; //input 
    logic                       wlast   ; //input 
    logic                       rvalid  ; //output
    logic                       rready  ; //input 
    logic [ 5  :0]              rid     ; //output
    logic [dma_width-1 :0]      rdata   ; //output
    logic [ 1  :0]              rresp   ; //output
    logic                       rlast   ; //output
    logic                       bvalid  ; //output
    logic                       bready  ; //input 
    logic [ 5:0]                bid     ; //output
    logic [ 1:0]                bresp   ; //output  
    logic                       clk     ;
    logic                       rst_n   ;
   
   assign clk   = aclk    ;
   assign rst_n = aresetn ;

   clocking slave_r_ck @(posedge aclk);
      input  arvalid,arid,araddr,arlen,arsize,arburst,arlock,arcache,arprot,arqos;
      input  rready;
      output arready;
      output rvalid,rid,rdata,rresp,rlast;

      sequence at_posedge; // FIXME todo review
         1;
      endsequence : at_posedge
   endclocking: slave_r_ck

   clocking slave_w_ck @(posedge aclk);
       input  awvalid,awid,awaddr,awlen,awsize ,awburst,awlock ,awcache,awprot ,awqos;
       input  wvalid ,wdata  ,wstrb  ,wlast  ;
       input  bready;
       output awready;
       output wready;
       output bvalid,bid,bresp;

      sequence at_posedge_; // FIXME todo review
         1;
      endsequence : at_posedge_
   endclocking: slave_w_ck

   modport slave_r(clocking slave_r_ck);
   modport slave_w(clocking slave_w_ck);

endinterface: if_axi

`endif
