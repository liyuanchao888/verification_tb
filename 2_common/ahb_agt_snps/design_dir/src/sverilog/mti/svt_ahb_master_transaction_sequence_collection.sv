
`ifndef GUARD_SVT_AHB_MASTER_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AHB_MASTER_TRANSACTION_SEQUENCE_COLLECTION_SV

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other svt_ahb_master sequences
 * in the collection extend from this base sequence.
 */
class svt_ahb_master_transaction_base_sequence extends svt_sequence#(svt_ahb_master_transaction);
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;
  
  /**Port id of a master used fro address retrival */
  int mstr_num;
 
  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_base_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  /* Port configuration obtained from the sequencer */
  svt_ahb_master_configuration cfg;

  /** Parameter that controls the type of transaction that will be generated */
  rand svt_ahb_transaction::xact_type_enum seq_xact_type;
  
  /** Parameter that controls the burst_type of transaction that will be generated */
  rand svt_ahb_transaction::burst_type_enum seq_burst_type;

  /** Parameter that controls lock bit of the transaction */
  rand bit seq_lock = 0;
  
  /** Parameter that controls the num_busy_cycles of the transaction */
  rand int seq_num_busy_cycles;
  
  /** Parameter that controls waiting of transaction to end */
  rand bit seq_wait_for_xact_ended;

  /** Slave number used to constrain it */
  rand int slv_num;

  /** Lower bound used when randomizing an address */  
  bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] lo_addr;

  /** Upper bound used when randoming an address */
  bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] hi_addr;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** Constrain the number of busy cycles to a reasonable value */
  constraint reasonable_seq_num_busy_cycles {
    seq_num_busy_cycles inside {[0:`SVT_AHB_MAX_NUM_BUSY_CYCLES - 1]};
  }

  extern function new(string name="svt_ahb_master_transaction_base_sequence");

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  virtual task body();
    svt_configuration get_cfg;
    `svt_xvm_debug("body", {"Executing ", (is_item() ? "item " : "sequence "), get_name(), " (", get_type_name(), ")"})
    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_ahb_master_configuration class");
    end
    mstr_num=cfg.port_id;
  endtask: body
  
endclass: svt_ahb_master_transaction_base_sequence

// =============================================================================
/**
 * This sequence generates a sequence of write or read transactions with busy cycles 
 * inserted to a value controlled by user for every beat of the burst.
 * For INCR burst type num_incr_beats is controlled by user.
 * All other transaction fields are randomized.The sequence waits for each
 * transaction to complete, before sending the next transaction.
 */
class ahb_transaction_random_write_or_read_sequence extends svt_ahb_master_transaction_base_sequence;

  `svt_xvm_object_utils(ahb_transaction_random_write_or_read_sequence)
  
  function new(string name="ahb_transaction_random_write_or_read_sequence");
    super.new(name);
  endfunction

`ifdef SVT_UVM_TECHNOLOGY
  virtual task pre_start();
    super.pre_start();
    raise_phase_objection();
    `svt_xvm_note("pre_start",$sformatf("Exiting ..."));
  endtask // pre_start
`endif
  
  virtual task body();
    svt_configuration get_cfg;
    bit status;
    super.body();
    `svt_note("body", "Entered ...");

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_note("body", $sformatf("ahb_transaction_random_write_or_read_sequence : sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    /** Randomly select an Address range for selected slave */ 
    if (!cfg.sys_cfg.get_slave_addr_range(mstr_num,slv_num, lo_addr, hi_addr))
      `svt_xvm_warning("body", $sformatf("Unable to obtain a memory range for slave index 'd%0d", slv_num));

    /** Execute the transactions in selected Slave from selected Master. */
    for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do_with(req, { 
        xact_type        == seq_xact_type;
        burst_type       == seq_burst_type;
        lock             == seq_lock;
        foreach (num_busy_cycles[i]) {
          num_busy_cycles[i] == seq_num_busy_cycles;
        }
        addr >= lo_addr;
        addr <= hi_addr;
      })
     
      if(seq_wait_for_xact_ended) begin
        `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(req), "Waiting for Transaction to end"});
        /** Waiting for Transaction to complete */
        `SVT_AHB_WAIT_FOR_XACT_ENDED(req); 
        `svt_xvm_note("body", {`SVT_AHB_PRINT_PREFIX1(req), "Transaction is now ended"});
      end
    end
  endtask: body

endclass: ahb_transaction_random_write_or_read_sequence

// =============================================================================
/** 
 *  This sequence generates random master transactions.
 */
class svt_ahb_master_transaction_random_sequence extends svt_ahb_master_transaction_base_sequence;

  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 10;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_random_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));


    for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass: svt_ahb_master_transaction_random_sequence

// =============================================================================
/**
 * This sequence generates a sequence of write transactions.All other transaction
 * fields are randomized.The sequence waits for each transaction to complete, 
 * before sending the next transaction.
 */
class svt_ahb_master_transaction_write_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_write_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

  for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type == svt_ahb_transaction::WRITE;
      })

      // Wait for transaction to complete.
      get_response(rsp);
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a sequence of read transactions.All other transaction
 * fields are randomized.The sequence waits for each transaction to complete, 
 * before sending the next transaction.
 */
class svt_ahb_master_transaction_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
    { 
         this.xact_type == svt_ahb_transaction::READ;
      })

      // Wait for transaction to complete
      get_response(rsp);
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a single random write transaction.
 */
class svt_ahb_master_transaction_write_xact_sequence extends svt_ahb_master_transaction_base_sequence;
  
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)
  `svt_xvm_object_utils(svt_ahb_master_transaction_write_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AHB_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Data to be written */
  rand bit [`SVT_AHB_MAX_DATA_WIDTH-1 : 0] data;

  function new(string name="svt_ahb_master_transaction_write_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    `svt_xvm_do_with(req, {
      xact_type == svt_ahb_transaction::WRITE;
      addr == local::addr;
`ifndef INCA
      data.size() == 1;
`else
      req.data.size() == 1;
`endif
      data[0] == local::data;
      burst_type == svt_ahb_transaction::SINGLE;
    })
    get_response(rsp);
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a single random read transaction.
 */
class svt_ahb_master_transaction_read_xact_sequence extends svt_ahb_master_transaction_base_sequence;
  
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)
  `svt_xvm_object_utils(svt_ahb_master_transaction_read_xact_sequence)

  /** Address to be written */
  rand bit [`SVT_AHB_MAX_ADDR_WIDTH-1 : 0] addr;

  /** Expected data. This is used to check the return value. */
  bit [`SVT_AHB_MAX_DATA_WIDTH-1 : 0] exp_data;

  /** Enable the check of the expected data. */
  bit check_enable = 1;

  function new(string name="svt_ahb_master_transaction_read_xact_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();
    `svt_xvm_do_with(req, {
      xact_type == svt_ahb_transaction::READ;
      addr == local::addr;
      burst_type == svt_ahb_transaction::SINGLE;
    })
    get_response(rsp);

    // Check the read data
    if (check_enable) begin
      // Check the read data
      if (rsp.data.size() != 1) begin
        `svt_xvm_error("body", $sformatf("Unexpected number of data for read to addr=%x.  Expected 1, recreived %0d", addr, rsp.data.size()));
      end
      else if (rsp.data[0] != exp_data) begin
        `svt_xvm_error("body", $sformatf("Data mismatch for read to addr=%x.  Expected %x, received %x", addr, exp_data, rsp.data[0]));
      end
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a sequence of idle transactions.All other transaction
 * fields are randomized.The sequence waits for each transaction to complete, 
 * before sending the next transaction.
 */
class svt_ahb_master_transaction_idle_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_idle_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_idle_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

    for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
    { 
         this.xact_type == svt_ahb_transaction::IDLE_XACT;
      })

      // Wait for transaction to complete
      get_response(rsp);
    end

  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a sequence of write transactions, followed by a
 * sequence of read transactions. All other transaction fields are randomized.
 * The sequence waits for each transaction to complete, before sending the next
 * transaction.
 */
class svt_ahb_master_transaction_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

  for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type == svt_ahb_transaction::WRITE;
      })

      // Wait for transaction to complete.
      get_response(rsp);
    end

    for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
    { 
         this.xact_type == svt_ahb_transaction::READ;
      })

      // Wait for transaction to complete
      get_response(rsp);
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass
// =============================================================================
/**
 * This sequence generates alternate write and read transaction. All other
 * transaction fields are randomized.  The sequence waits for each transaction
 * to complete, before sending the next transaction.
 */
class svt_ahb_master_transaction_alternate_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_alternate_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_alternate_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

   for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type       == svt_ahb_transaction::WRITE;
      })

      // Wait for transaction to complete.
      get_response(rsp);
      
      `svt_xvm_do_with(req,
    { 
         this.xact_type       == svt_ahb_transaction::READ;
      })

      // Wait for transaction to complete
      get_response(rsp);
    end
  endtask: body
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates alternate write and read transaction including:
 * SINGLE and fixed length Burst types
 * Transfer sizes including BYTE,HALF-WORD,FULL-WORD types
 * The remaining transaction fields are randomized.  The sequence waits for each 
 * transaction to complete, before sending the next transaction.
 */
class svt_ahb_master_transaction_fixed_len_write_read_hsize_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_fixed_len_write_read_hsize_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_fixed_len_write_read_hsize_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

   for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type       == svt_ahb_transaction::WRITE;
       this.burst_type   inside {svt_ahb_transaction::SINGLE,svt_ahb_transaction::INCR4, svt_ahb_transaction::INCR8, svt_ahb_transaction::INCR16,svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16};
         this.burst_size   inside {svt_ahb_transaction::BURST_SIZE_8BIT ,svt_ahb_transaction::BURST_SIZE_16BIT,svt_ahb_transaction::BURST_SIZE_32BIT};
      })

      // Wait for transaction to complete.
      get_response(rsp);
      
      `svt_xvm_do_with(req,
    { 
         this.xact_type       == svt_ahb_transaction::READ;
       this.burst_type   inside {svt_ahb_transaction::SINGLE,svt_ahb_transaction::INCR4, svt_ahb_transaction::INCR8, svt_ahb_transaction::INCR16,svt_ahb_transaction::WRAP4,svt_ahb_transaction::WRAP8,svt_ahb_transaction::WRAP16};
         this.burst_size  inside {svt_ahb_transaction::BURST_SIZE_8BIT ,svt_ahb_transaction::BURST_SIZE_16BIT,svt_ahb_transaction::BURST_SIZE_32BIT};
      })

      // Wait for transaction to complete
      get_response(rsp);
    end
  endtask: body
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates back-to-back write and read transaction with
 * zero idle cycles between transactions.The remaining transaction fields are 
 * randomized.  The sequence does not wait for each transaction to complete, 
 * before sending the next transaction.
 */
class svt_ahb_master_transaction_no_idle_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_no_idle_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_no_idle_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

   for (int i=0; i < sequence_length; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type       == svt_ahb_transaction::WRITE;
         //Reasonable constraint for num_incr_beats
         if(burst_type == svt_ahb_transaction::INCR){
           this.num_incr_beats <= 100;
         }
      })

      `svt_xvm_do_with(req,
    { 
         this.xact_type       == svt_ahb_transaction::READ;
         //Reasonable constraint for num_incr_beats
         if(burst_type == svt_ahb_transaction::INCR){
           this.num_incr_beats <= 100;
         }
      })

    end
  endtask: body
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence performs the following:
 * A LOCKED WRITE transaction
 * A NORMAL READ transaction
 * A NORMAL WRITE transaction
 * A LOCKED READ transaction
 * The remaining transaction fields are randomized.  The sequence waits for each 
 * transaction to complete, before sending the next transaction.
 */
class svt_ahb_master_transaction_locked_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_locked_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_locked_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

   for (int i=0; i < sequence_length; i++) begin

    /** A LOCKED WRITE transaction */
      `svt_xvm_do_with(req,
      { 
         this.xact_type       == svt_ahb_transaction::WRITE;
         this.lock            == 1;
      })

      // Wait for transaction to complete.
      get_response(rsp);
      
    /** A NORMAL READ transaction */
      `svt_xvm_do_with(req,
    { 
         this.xact_type       == svt_ahb_transaction::READ;
         this.lock            == 0;
      })

      // Wait for transaction to complete
      get_response(rsp);

    /** A NORMAL WRITE transaction */
      `svt_xvm_do_with(req,
      { 
         this.xact_type       == svt_ahb_transaction::WRITE;
         this.lock            == 0;
      })

      // Wait for transaction to complete.
      get_response(rsp);
      
    /** A LOCKED READ transaction */
      `svt_xvm_do_with(req,
    { 
         this.xact_type       == svt_ahb_transaction::READ;
         this.lock            == 1;
      })

      // Wait for transaction to complete
      get_response(rsp);    
    end
  endtask: body
  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass

// =============================================================================
/**
 * This sequence generates a sequence of write transactions, followed by a
 * sequence of read transactions with distribution on the following fields:
 * 
 * Number of busy cycles
 * lock or normal transfer
 * length of undefined length incrementing burst
 * 
 * All other transaction fields are randomized.
 * The sequence waits for each transaction to complete, before sending the next
 * transaction.
 */
class svt_ahb_master_transaction_distributed_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;
  
  /** LOCK transfer weight. */
  int unsigned LOCK_wt = 50;
  
  /** NORMAL transfer weight. */
  int unsigned NORMAL_wt = 50;
  
  /** ZERO BUSY cycles weight. */
  int unsigned ZERO_BUSY_CYCLES_wt = 50;
  
  /** MEDIAN BUSY cycles weight. */
  int unsigned MEDIAN_BUSY_CYCLES_wt = 25;
  
  /** MAX BUSY cycles weight. */
  int unsigned MAX_BUSY_CYCLES_wt = 25;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_distributed_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(LOCK_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(NORMAL_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ZERO_BUSY_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MEDIAN_BUSY_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MAX_BUSY_CYCLES_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_distributed_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    bit status_LOCK_wt;
    bit status_NORMAL_wt;
    bit status_ZERO_BUSY_CYCLES_wt;
    bit status_MEDIAN_BUSY_CYCLES_wt;
    bit status_MAX_BUSY_CYCLES_wt;

    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
    status_LOCK_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "LOCK_wt", LOCK_wt);
    status_NORMAL_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "NORMAL_wt", NORMAL_wt);
    status_ZERO_BUSY_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ZERO_BUSY_CYCLES_wt", ZERO_BUSY_CYCLES_wt);
    status_MEDIAN_BUSY_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MEDIAN_BUSY_CYCLES_wt", MEDIAN_BUSY_CYCLES_wt);
    status_MAX_BUSY_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MAX_BUSY_CYCLES_wt", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
    status_LOCK_wt = m_sequencer.get_config_int({get_type_name(), ".LOCK_wt"}, LOCK_wt);
    status_NORMAL_wt = m_sequencer.get_config_int({get_type_name(), ".NORMAL_wt"}, NORMAL_wt);
    status_ZERO_BUSY_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".ZERO_BUSY_CYCLES_wt"}, ZERO_BUSY_CYCLES_wt);
    status_MEDIAN_BUSY_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MEDIAN_BUSY_CYCLES_wt"}, MEDIAN_BUSY_CYCLES_wt);
    status_MAX_BUSY_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MAX_BUSY_CYCLES_wt"}, MAX_BUSY_CYCLES_wt);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("LOCK_wt is 'd%0d as a result of %0s.", LOCK_wt, status_LOCK_wt ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("NORMAL_wt is 'd%0d as a result of %0s.", NORMAL_wt, status_NORMAL_wt ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("ZERO_BUSY_CYCLES_wt is 'd%0d as a result of %0s.", ZERO_BUSY_CYCLES_wt, status_ZERO_BUSY_CYCLES_wt ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("MEDIAN_BUSY_CYCLES_wt is 'd%0d as a result of %0s.", MEDIAN_BUSY_CYCLES_wt, status_MEDIAN_BUSY_CYCLES_wt ? "the config DB" : "randomization"));
    `svt_xvm_debug("body", $sformatf("MAX_BUSY_CYCLES_wt is 'd%0d as a result of %0s.", MAX_BUSY_CYCLES_wt, status_MAX_BUSY_CYCLES_wt ? "the config DB" : "randomization"));

  for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type == svt_ahb_transaction::WRITE;
         this.lock dist {0:=LOCK_wt,1:=NORMAL_wt};
         this.num_busy_cycles.size() dist {0:=ZERO_BUSY_CYCLES_wt,[5:12]:=MEDIAN_BUSY_CYCLES_wt,[15:16]:=MAX_BUSY_CYCLES_wt};
     foreach (this.num_busy_cycles[i]) {
           this.num_busy_cycles[i] ==  (i+1);
         }
      })

      // Wait for transaction to complete.
      get_response(rsp);
    end

    for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
    {
         this.xact_type == svt_ahb_transaction::READ;
         this.lock dist {0:=LOCK_wt,1:=NORMAL_wt};
         this.num_busy_cycles.size() dist {0:=ZERO_BUSY_CYCLES_wt,[5:12]:=MEDIAN_BUSY_CYCLES_wt,[15:16]:=MAX_BUSY_CYCLES_wt};
     foreach (this.num_busy_cycles[i]) {
           this.num_busy_cycles[i] ==  (i+1);
       }
      })

      // Wait for transaction to complete
      get_response(rsp);
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable

endclass
// =============================================================================
/**
 * This sequence generates a sequence of write transactions, followed by a
 * sequence of read transactions with busy cycles inserted for every beat of the 
 * burst. All other transaction fields are randomized.The sequence waits for each
 * transaction to complete, before sending the next transaction.
 */
class svt_ahb_master_transaction_busy_write_read_sequence extends svt_ahb_master_transaction_base_sequence;
  
  /** Number of Transactions in a sequence. */
  rand int unsigned sequence_length = 100;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length == 100;
  }
 
  `svt_xvm_declare_p_sequencer(svt_ahb_master_transaction_sequencer)

  `svt_xvm_object_utils_begin(svt_ahb_master_transaction_busy_write_read_sequence)
    `svt_xvm_field_int(sequence_length, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  function new(string name="svt_ahb_master_transaction_busy_write_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit status;
    super.body();

    /** Gets the user provided sequence_length. */
`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".sequence_length"}, sequence_length);
`endif
    `svt_xvm_debug("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "the config DB" : "randomization"));

  for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
      { 
         this.xact_type == svt_ahb_transaction::WRITE;
    
     //Constraint number of busy cycles based on burst type
     if(burst_type == svt_ahb_transaction::INCR){
          this.num_busy_cycles.size() == num_incr_beats-1;
     }else if((burst_type == svt_ahb_transaction::INCR4) || (burst_type == svt_ahb_transaction::WRAP4)){
          this.num_busy_cycles.size() == 3;
     }else if((burst_type == svt_ahb_transaction::INCR8) || (burst_type == svt_ahb_transaction::WRAP8)){
          this.num_busy_cycles.size() == 7;
       }else if((burst_type == svt_ahb_transaction::INCR16) || (burst_type == svt_ahb_transaction::WRAP16)){
          this.num_busy_cycles.size() == 15;
       }

     foreach (this.num_busy_cycles[i]) {
           this.num_busy_cycles[i] ==  (i+1);
         }

     //Reasonable constraint for num_incr_beats
     if(burst_type == svt_ahb_transaction::INCR){
       this.num_incr_beats dist {[1:5]:=50,[8:12]:=20,[15:16]:=30};
     }
      })

      // Wait for transaction to complete.
      get_response(rsp);
    end

    for (int i=0; i < sequence_length/2; i++) begin
      `svt_xvm_do_with(req,
    { 
         this.xact_type == svt_ahb_transaction::READ;

     //Constraint number of busy cycles based on burst type
     if(burst_type == svt_ahb_transaction::INCR){
          this.num_busy_cycles.size() == this.num_incr_beats-1;
     }else if((burst_type == svt_ahb_transaction::INCR4) || (burst_type == svt_ahb_transaction::WRAP4)){
          this.num_busy_cycles.size() == 3;
     }else if((burst_type == svt_ahb_transaction::INCR8) || (burst_type == svt_ahb_transaction::WRAP8)){
          this.num_busy_cycles.size() == 7;
       }else if((burst_type == svt_ahb_transaction::INCR16) || (burst_type == svt_ahb_transaction::WRAP16)){
          this.num_busy_cycles.size() == 15;
       }
     
     foreach (this.num_busy_cycles[i]) {
           this.num_busy_cycles[i] ==  (i+1);
         }
     //Reasonable constraint for num_incr_beats
     if(burst_type == svt_ahb_transaction::INCR){
       this.num_incr_beats dist {[1:5]:=50,[8:12]:=20,[15:16]:=30};
     }
      })

      // Wait for transaction to complete
      get_response(rsp);
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass


// =============================================================================
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gvunwiIEOVVRbvcjnzXikWGPz00QzLu6PnmJ12sr0JK6YgduclcRDg/u19vAlL3s
9lsPCOeJMq/vROBKngtDuzMulcjnZP/V1bSm+S5xTtDdQQvno9UptO4mBjft1tQO
CG6+uzuAtgdArVGPMc+bcMhqWA/XQYccrZjxxOjoMiY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5286      )
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
YSbCtnwCwNbq6iw8potIhQ==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_TRANSACTION_SEQUENCE_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z+7xylvCQS9oc+Wma3zREwokBTTNbu57kuoDpsARRqLVodGzC2CuD3LpjS/ZL2+0
NU9m2VpFftjSKL6IPuoEg6W58GUc4+x8HrCI2eB8cjIHh2xxyUNqKBpE021oD3QU
o7zCqY9tiuWKKIcKJwq3sQo6JSeI1nvsOzW3T1QxSTw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5369      )
t2LrWSTgq+HDMDGVnF72nKwAPyOX0nZEsptf7UdD1jO4DgtzLkFzLnc4cRcE8M75
ZxfHqCOcPzOWTHV9Lwef3sK8lDnDrHXDCz8LWHTKsq272qDIAWuHEwJqVohLsZTz
`pragma protect end_protected
