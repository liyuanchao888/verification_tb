`ifndef MEM_IF__SV
`define MEM_IF__SV

`timescale 1ns/1ns

interface mem_if(input logic aclk,input logic aresetn);
//    localparam mem_width = `MEM_WIDTH ;
    logic                       ddr3_reset_n_w; //input 
    logic                       ddr3_ck_p_w   ; //output
    logic                       ddr3_ck_n_w   ; //input 
    logic                       ddr3_cke_w    ; //input 
    logic                       ddr3_cs_n_w   ; //input 
    logic                       ddr3_ras_n_w  ; //input 
    logic                       ddr3_cas_n_w  ; //input 
    logic                       ddr3_we_n_w   ; //input 
    wire  [ 1  :0]              ddr3_dm_w     ; //input 
    logic [ 2  :0]              ddr3_ba_w     ; //input 
    logic [ 13 :0]              ddr3_addr_w   ; //input 
    logic                       ddr3_odt_w    ; //input 
    wire [ 1  :0]              ddr3_dqs_p_w  ; //output
    wire [ 1  :0]              ddr3_dqs_n_w  ; //input 
    wire [15  :0]              ddr3_dq_w     ; //input 


endinterface: mem_if

`endif
