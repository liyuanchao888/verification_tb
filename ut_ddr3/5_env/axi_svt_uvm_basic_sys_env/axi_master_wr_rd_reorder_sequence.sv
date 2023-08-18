
/**
 * Abstract:
 * axi_master_wr_rd_reorder_sequence is used by test to provide initiator scenario
 * information to the Master agent present in the System agent.  This class
 * defines a sequence in which AXI WRITE sequence and READ sequence
 * is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_AXI_MASTER_WR_RD_REORDER_SEQUENCE_SV
`define GUARD_AXI_MASTER_WR_RD_REORDER_SEQUENCE_SV

class axi_master_wr_rd_reorder_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_wr_rd_reorder_sequence)

  svt_axi_master_transaction write_tran[$],read_tran[$];

  /** Class Constructor */
  function new(string name="axi_master_wr_rd_reorder_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    fork
    forever begin
      get_response(rsp);
    end
    join_none
    
    for (int i = 0;i < sequence_length;i++) begin
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER 
        `uvm_do_with(write_tran[i], 
        { 
          xact_type == svt_axi_transaction::WRITE;
          if (i == 0) {
            id == 0;
          }
          else {
            id == 1;
          }  
          addr_valid_delay == 0; 
          data_before_addr == 0;
          burst_type   == svt_axi_transaction::INCR;
          bready_delay == 0;
          foreach(wvalid_delay[ix]) {
            wvalid_delay[ix] == 0;
          }
        })
      `else 
        `uvm_do(write_tran[i],,, 
        { 
          xact_type == svt_axi_transaction::WRITE;
          if (i == 0) {
            id == 0;
          }
          else {
            id == 1;
          }  
          addr_valid_delay == 0; 
          data_before_addr == 0;
          burst_type   == svt_axi_transaction::INCR;
          bready_delay == 0;
          foreach(wvalid_delay[ix]) {
            wvalid_delay[ix] == 0;
          }
        })
      `endif
    end 
    for (int i = 0;i <sequence_length;i++) begin 
      write_tran[i].wait_for_transaction_end();
    end  
    
    for (int x = 0;x < sequence_length;x++) begin 
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER 
        `uvm_do_with(read_tran[x], 
        { 
          xact_type == svt_axi_transaction::READ;
          if (x == 0) {
            id == 10;
          }
          else {
            id == 20;
          } 
          addr_valid_delay == 0; 
          data_before_addr == 0;
          foreach(rready_delay[i]) {
            rready_delay[i] == 0;
          }  
        })
      `else 
        `uvm_do(read_tran[x],,, 
        { 
          xact_type == svt_axi_transaction::READ;
          if (x == 0) {
            id == 10;
          }
          else {
            id == 20;
          } 
          addr_valid_delay == 0; 
          data_before_addr == 0;
          foreach(rready_delay[i]) {
            rready_delay[i] == 0;
          }  
        })
      `endif
    end
    for (int x = 0;x <sequence_length;x++) begin 
      read_tran[x].wait_for_transaction_end();
    end  

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_master_wr_rd_reorder_sequence

`endif // GUARD_AXI_MASTER_WR_RD_REORDER_SEQUENCE_SV
