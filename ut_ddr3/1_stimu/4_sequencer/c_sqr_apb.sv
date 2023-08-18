`ifndef C_SQR_APB__SV
`define C_SQR_APB__SV

class c_sqr_apb extends uvm_sequencer #(c_trans_apb);
    `uvm_component_utils(c_sqr_apb)

    function new (string name = "c_sqr_apb", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass: c_sqr_apb
`endif //C_APB_SQR__SV
