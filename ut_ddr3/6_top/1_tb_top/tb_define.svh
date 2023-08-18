`ifndef TB_MACROS__SVH
`define TB_MACROS__SVH

`define DMA_WIDTH 64
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
/** Include the AXI SVT UVM package */
`include "svt_axi.uvm.pkg"
`include "svt_axi_if.svi" //top-level axi interface
`include "axi_reset_if.svi" //axi interface reest

/** Import UVM Package */
import uvm_pkg::*;
/** Import the SVT UVM Package */
import svt_uvm_pkg::*;
/** Import the AXI VIP */
import svt_axi_uvm_pkg::*;

`endif 
