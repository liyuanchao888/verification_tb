
`ifndef C_SEQ_SIF__SV
`define C_SEQ_SIF__SV

class c_seq_sif extends uvm_sequence #(c_trans_sif);
    `uvm_object_utils(c_seq_sif)
    
    function new(string name="c_seq_sif");
        super.new(name);
    endfunction: new

    virtual task body;
        c_trans_sif m_trans_sif;

        repeat(1) begin
            m_trans_sif = c_trans_sif::type_id::create("m_trans_sif");
            start_item(m_trans_sif);
            assert(m_trans_sif.randomize());
            finish_item(m_trans_sif);
        end
    endtask: body
endclass: c_seq_sif
`endif //C_SIF_TRANS_SEQ__SV
