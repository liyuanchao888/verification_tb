
/**
 * Abstract:
 * axi_master_directed_sequence is used by test to provide initiator
 * scenario information to the Master agent present in the System Env.
 * This class defines a sequence in which a AXI WRITE followed by a AXI READ
 * sequence is generated by assigning values to the transactions rather than
 * randomization, and then transmitted using `uvm_send.
 *
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_AXI_MASTER_DIRECTED_SEQUENCE_SV
`define GUARD_AXI_MASTER_DIRECTED_SEQUENCE_SV

class axi_master_directed_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_directed_sequence)

  /** Class Constructor */
  function new(string name="axi_master_directed_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    svt_axi_master_transaction write_tran, read_tran;
    svt_configuration get_cfg;
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /** Obtain a handle to the port configuration */
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_axi_port_configuration class");
    end

    for(int i = 0; i < sequence_length; i++) begin

      /** Set up the write transaction */
      `uvm_create(write_tran)
      write_tran.port_cfg     = cfg;
      write_tran.xact_type    = svt_axi_transaction::WRITE;
     // write_tran.addr         = 32'h0000_0100 | ('h100 << i);
      write_tran.addr         = 32'h0000_0100 + ('h1000*i);
      write_tran.burst_type   = svt_axi_transaction::INCR;
      write_tran.burst_size   = svt_axi_transaction::BURST_SIZE_32BIT;
      write_tran.atomic_type  = svt_axi_transaction::NORMAL;
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
      write_tran.burst_length = 1;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
      write_tran.burst_length = 2;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
      write_tran.burst_length = 4;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_4
      write_tran.burst_length = 8;
`else
      write_tran.burst_length = 16;
`endif      
      write_tran.data         = new[write_tran.burst_length];
      write_tran.wstrb        = new[write_tran.burst_length];
      write_tran.data_user    = new[write_tran.burst_length];
      foreach (write_tran.data[i]) begin
        write_tran.data[i] = i;
      end
      foreach(write_tran.wstrb[i]) begin
        write_tran.wstrb[i] = 4'hf;
      end
      write_tran.wvalid_delay = new[write_tran.burst_length];
      foreach (write_tran.wvalid_delay[i]) begin
        write_tran.wvalid_delay[i]=i;
      end

      /** Send the write transaction */
      `uvm_send(write_tran)

      /** Wait for the write transaction to complete */
      get_response(rsp);

      `uvm_info("body", "AXI WRITE transaction completed", UVM_LOW);

      /** Set up the read transaction */
      `uvm_create(read_tran)
      read_tran.port_cfg     = cfg;
      read_tran.xact_type    = svt_axi_transaction::READ;
      //read_tran.addr         = 32'h0000_0100 | ('h100 << i);
      read_tran.addr         = 32'h0000_0100 + ('h1000*i);
      read_tran.burst_type   = svt_axi_transaction::INCR;
      read_tran.burst_size   = svt_axi_transaction::BURST_SIZE_32BIT;
      read_tran.atomic_type  = svt_axi_transaction::NORMAL;
`ifdef SVT_AXI_MAX_BURST_LENGTH_WIDTH_1
      read_tran.burst_length = 1;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_2
      read_tran.burst_length = 2;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_3
      read_tran.burst_length = 4;
`elsif SVT_AXI_MAX_BURST_LENGTH_WIDTH_4
      read_tran.burst_length = 8;
`else
      read_tran.burst_length = 16;
`endif      
      read_tran.rresp        = new[read_tran.burst_length];
      read_tran.data         = new[read_tran.burst_length];
      read_tran.rready_delay = new[read_tran.burst_length];
      read_tran.data_user    = new[read_tran.burst_length];
      foreach (read_tran.rready_delay[i]) begin
        read_tran.rready_delay[i]=i;
      end

      /** Send the read transaction */
      `uvm_send(read_tran)

      /** Wait for the read transaction to complete */
      get_response(rsp);
    
      `uvm_info("body", "AXI READ transaction completed", UVM_LOW);
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_master_directed_sequence

`endif // GUARD_AXI_MASTER_DIRECTED_SEQUENCE_SV
