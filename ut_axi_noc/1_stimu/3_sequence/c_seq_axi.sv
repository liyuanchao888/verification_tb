
`ifndef C_SEQ_AXI__SV
`define C_SEQ_AXI__SV

class c_seq_axi extends uvm_sequence #(c_trans_axi);
    `uvm_object_utils(c_seq_axi)
    
    function new(string name="c_seq_axi");
        super.new(name);
    endfunction: new

    virtual task body;
        c_trans_axi m_trans_axi;

        repeat(1) begin
            m_trans_axi = c_trans_axi::type_id::create("m_trans_axi");
            start_item(m_trans_axi);
            assert(m_trans_axi.randomize());
            finish_item(m_trans_axi);
        end
    endtask: body
endclass: c_seq_axi
`endif //C_AXI_TRANS_SEQ__SV
