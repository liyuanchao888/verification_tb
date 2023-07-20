`ifndef C_SQR_AXI__SV
`define C_SQR_AXI__SV

class c_sqr_axi extends uvm_sequencer #(c_trans_axi);
    `uvm_component_utils(c_sqr_axi)

    function new (string name = "c_sqr_axi", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass: c_sqr_axi
`endif //C_SQR_AXI__SV
