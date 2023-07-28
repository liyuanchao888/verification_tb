//  Class: axi_write_sqr
`ifndef AXI_WRITE_SQR__SV
`define AXI_WRITE_SQR__SV
class axi_write_sqr  extends uvm_sequencer #(axi_transaction#(D_WIDTH , A_WIDTH ));
    `uvm_component_utils(axi_write_sqr #(axi_transaction#(D_WIDTH , A_WIDTH )));
    
    //  Constructor: new
    function new(string name = "axi_write_sqr",uvm_component parent = null );
        super.new(name);
    endfunction: new

endclass: axi_write_sqr

`endif
