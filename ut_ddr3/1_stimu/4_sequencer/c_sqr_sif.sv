`ifndef C_SQR_SIF__SV
`define C_SQR_SIF__SV

class c_sqr_sif extends uvm_sequencer #(c_trans_sif);
    `uvm_component_utils(c_sqr_sif)

    function new (string name = "c_sqr_sif", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass: c_sqr_sif
`endif //C_SQR_SIF_SV
