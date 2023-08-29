
`include "axi_base_test.sv"
`include "axi_null_virtual_sequence.sv"
`include "axi_master_wr_rd_reorder_sequence.sv"
`include "axi_slave_reorder_response_sequence.sv"

/**
 * Abstract:
 * This file creates test 'reorder_wr_rd_test', which is extended from the
 * base test class.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the axi_master_wr_rd_reorder_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  - Configure the Master Sequence length to 5
 *  - Configure axi_slave_reorder_response_sequence as the default sequence
 *    for the run phase of the Slave Sequencer
 *  .
 */
class reorder_wr_rd_test extends axi_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils (reorder_wr_rd_test)

  /** Class Constructor */
  function new (string name="reorder_wr_rd_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    cfg.master_cfg[0].reordering_algorithm = svt_axi_port_configuration::RANDOM;
    cfg.slave_cfg[0].reordering_algorithm = svt_axi_port_configuration::PRIORITIZED; 
    /** For WRITE transaction */
    cfg.slave_cfg[0].default_awready = 1;
    cfg.slave_cfg[0].default_wready = 1;
    cfg.slave_cfg[0].write_resp_reordering_depth= 4;
    /** For READ transaction */
    cfg.slave_cfg[0].default_arready = 1;
    cfg.master_cfg[0].default_rready = 1;
    cfg.slave_cfg[0].read_data_interleave_size= 0;
    cfg.slave_cfg[0].read_data_reordering_depth= 4;

    cfg.master_cfg[0].num_outstanding_xact = 2;
    cfg.slave_cfg[0].num_outstanding_xact = 2;

    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.sequencer.main_phase", "default_sequence", axi_null_virtual_sequence::type_id::get());

    /** Apply the master sequence to the master sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.master*.sequencer.main_phase", "default_sequence", axi_master_wr_rd_reorder_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transactions with random constraints */
    uvm_config_db#(int unsigned)::set(this, "env.axi_system_env.master*.sequencer.axi_master_wr_rd_reorder_sequence", "sequence_length", 2);

    /** Apply the Slave reorder response sequence to Slave sequencer
     *
     * This sequence is configured for the run phase since the slave should always
     * respond to recognized requests.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence", axi_slave_reorder_response_sequence::type_id::get());

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

endclass
