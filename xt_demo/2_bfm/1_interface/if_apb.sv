`ifndef IF_APB__SV
`define IF_APB__SV

`timescale 1ns/1ns

interface if_apb(input logic pclk,input logic rst_n);
   logic [11 :0] paddr  ;
   logic         pwrite ;
   logic         psel   ;
   logic         penable;
   logic         pready ;
   logic [31 :0] prdata ;
   logic [31 :0] pwdata ;
   logic         clk    ;
   logic         pslverr;
   logic [2  :0] pprot  ;
   logic [3  :0] pstrb  ;

   assign clk = pclk ;
   clocking mck @(posedge pclk);
      output paddr, pwrite, psel, penable, pwdata;
      input  prdata;

      sequence at_posedge;
         1;
      endsequence : at_posedge
   endclocking: mck

   clocking sck @(posedge pclk);
      input  paddr, pwrite, psel, penable, pwdata;
      output prdata;

      sequence at_posedge_; // FIXME todo review 
         1;
      endsequence : at_posedge_
   endclocking: sck

   clocking pck @(posedge pclk);
      input paddr, pwrite, psel, penable,  prdata, pwdata;
   endclocking: pck

   modport master(clocking mck);
   modport slave(clocking sck);
   modport passive(clocking pck);

endinterface: if_apb

`endif
