`ifndef C_SIMPLE_TEST_RW__SV
`define C_SIMPLE_TEST_RW__SV

class c_simple_test_rw extends uvm_test;
  c_env     m_env;
  c_seq_apb m_seq_apb;
  c_seq_axi m_seq_axi;
  c_seq_sif m_seq_sif;
  c_tb_cfg m_tb_cfg = new();

  `uvm_component_utils(c_simple_test_rw)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_env     = c_env::type_id::create("m_env", this);
    m_seq_apb = c_seq_apb::type_id::create("m_seq_apb", this);
    m_seq_axi = c_seq_axi::type_id::create("m_seq_axi", this);
    m_seq_sif = c_seq_sif::type_id::create("m_seq_sif", this);
    m_tb_cfg.file_re();
  endfunction
 
  task run_phase(uvm_phase phase);
  	 int read = m_tb_cfg.h_array["rctrl_reg"];
  	 int write = m_tb_cfg.h_array["wctrl_reg"];  	 
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("====== testcase run_phase :start ===== \n"), UVM_NONE)
     repeat(1) begin
         fork
             m_env.m_reg_model.print();
             if(m_seq_apb.m_cpu_op == null )
                    `uvm_info(get_type_name(), $sformatf("====== testcase cpu_op is null ===== \n"), UVM_NONE)
             if(m_seq_apb.m_cpu_op.m_reg_model == null )
                    `uvm_info(get_type_name(), $sformatf("====== testcase m_reg_model is null ===== \n"), UVM_NONE)
             if(m_env == null )
                    `uvm_info(get_type_name(), $sformatf("====== testcase m_env is null ===== \n"), UVM_NONE)
             if(m_env.m_reg_model == null )
                    `uvm_info(get_type_name(), $sformatf("====== testcase m_env.m_reg_model is null ===== \n"), UVM_NONE)
                    
             m_seq_apb.m_cpu_op.m_reg_model = m_env.m_reg_model;
             m_seq_apb.start(m_env.m_agt_apb.m_sqr);
             if (read == 1)    //SIF to AXI ###up_stream 
                 m_seq_axi.start(m_env.m_agt_axi.m_sqr);
             if (write == 1)   //AXI to SIF ###dn_stream
                 m_seq_sif.start(m_env.m_agt_sif.m_sqr);

         join
     end
     repeat(10000) begin //delay
         @(posedge m_env.m_agt_axi.m_vif_axi.clk);
     end
    `uvm_info(get_type_name(), $sformatf("****** testcase run_phase :end ****** \n"), UVM_NONE)
    phase.drop_objection(this);
  endtask: run_phase

endclass
`endif //C_SIMPLE_TEST_RW__SV
