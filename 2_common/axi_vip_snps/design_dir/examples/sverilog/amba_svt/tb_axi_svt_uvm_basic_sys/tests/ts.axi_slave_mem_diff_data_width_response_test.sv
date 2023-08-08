
/**
 * Abstract:
 * This file creates test 'axi_slave_mem_diff_data_width_response_test', which is extended from the
 * base test class.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
    - Configure the slave_agents data_width as 64
    - Configure the slave_memory data_width as 256
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the axi_master_wr_rd_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  - Configure the Master Sequence length to 20
 *  - Configure axi_slave_mem_diff_data_width_response_sequence
 *    for the run phase of the Slave Sequencer.
 * @testdescription 
 *    This testcase verifies that write_byte method followed by read_byte
 *    method based on the data width of memory.
 * @end_testdescription
 * .
 */
`include "axi_slave_mem_diff_data_width_response_sequence.sv"

`ifndef GUARD_AXI_SLAVE_MEM_DIFF_DATA_WIDTH_RESPONSE_TEST_SV
`define GUARD_AXI_SLAVE_MEM_DIFF_DATA_WIDTH_RESPONSE_TEST_SV

class axi_slave_mem_diff_data_width_response_test extends axi_base_test;

  svt_mem slave_mem_l;

  /** UVM Component Utility macro */
  `uvm_component_utils (axi_slave_mem_diff_data_width_response_test)

  /** Class Constructor */
  function new (string name="axi_slave_mem_diff_data_width_response_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);
    
    cfg.slave_cfg[0].data_width =64;
    cfg.master_cfg[0].data_width =64;

    slave_mem_l = new("slave_mem_l",                // Memory name
                      "AMBA3",                      // Suite name
                      256,                           // data_width
                      0,                            // Address region
                      0,                            // Lower address bound to memory 
                      64'hffff_ffff_ffff_ffff);     // Upper address bound to memory
      
    svt_config_object_db#(svt_mem)::set(this,  "env.axi_system_env.slave*",  "axi_slave_mem",  slave_mem_l);

    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.sequencer.main_phase", "default_sequence", axi_null_virtual_sequence::type_id::get());

    /** Apply the master sequence to the master sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.master*.sequencer.main_phase", "default_sequence", axi_master_wr_rd_sequence::type_id::get());

    /** Set the sequence 'length' to generate 20 transactions with random constraints */
    uvm_config_db#(int unsigned)::set(this, "env.axi_system_env.master*.sequencer.axi_master_wr_rd_sequence", "sequence_length", 20);

    /**Apply the axi_slave_mem_diff_data_width_response_sequence to Slave sequencer*/
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence", axi_slave_mem_diff_data_width_response_sequence::type_id::get());

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

endclass:axi_slave_mem_diff_data_width_response_test

`endif // GUARD_AXI_SLAVE_MEM_DIFF_DATA_WIDTH_RESPONSE_TEST_SV
