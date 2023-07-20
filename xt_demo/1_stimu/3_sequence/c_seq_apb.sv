`ifndef C_SEQ_APB__SV
`define C_SEQ_APB__SV

class c_seq_apb extends uvm_reg_sequence ;
    `uvm_object_utils(c_seq_apb)
     c_reg_model m_reg_model;
     c_cpu_op    m_cpu_op   ;
    function new(string name="c_seq_apb");
        super.new(name);
        m_reg_model=new();
        m_cpu_op=new("m_cpu_op",,m_reg_model);
    endfunction: new

    virtual task body;
        c_trans_apb     m_trans_apb;
        repeat(1) begin
            if(m_cpu_op.m_reg_model == null) begin
                `uvm_info(get_name(),$sformatf(" [error]apb reg sequence reg_model null\n"),UVM_MEDIUM);
                return;
            end
            m_trans_apb = c_trans_apb::type_id::create("m_trans_apb");
            assert(m_trans_apb.randomize());
            m_cpu_op.inital_cpu(); //config register
        end
    endtask: body

endclass: c_seq_apb
`endif //C_APB_TRANS_SEQ__SV
