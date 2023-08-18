`ifndef IF_SIF__SV
`define IF_SIF__SV
`timescale 1ns/1ns

interface if_sif(input logic clk,input logic rst_n);
   localparam dma_width = `DMA_WIDTH;
   logic                 up_rdy; //output
   logic                 up_vld; //input
   logic [dma_width-1:0] up_dat; //input

   logic                 dn_rdy; //input
   logic                 dn_vld; //output
   logic [dma_width-1:0] dn_dat; //output

   clocking up_stream_ck @(posedge clk);
      input  up_vld,up_dat;
      output up_rdy;

      sequence at_posedge;
         1;
      endsequence : at_posedge
   endclocking: up_stream_ck

   clocking dn_stream_ck @(posedge clk);
      input   dn_rdy;
      output  dn_vld,dn_dat;

      sequence at_posedge;
         1;
      endsequence : at_posedge
   endclocking: dn_stream_ck


   modport up_stream(clocking up_stream_ck);
   modport dn_stream(clocking dn_stream_ck);

endinterface: if_sif

`endif
