
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wbGW+LzcMeFQk5yG1RdJatOdDxJ2noD74agv1oDgBmvByPLxcN9tbRSFfXaXxp1S
dNGPWNE+J6gcdjepdZDy/T8gmUhInOtzpwl38hOGoEa9viTP2WQr6lm6vfmjiw8+
yNfYWhgRBgxAtak1guWfJWeeUcqfGYSQosrgJeCPKETVla7eedjxgQ==
//pragma protect end_key_block
//pragma protect digest_block
MoumB/R2QxkAwaQOSqquCD1uV2M=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
bA/uEyhikwGwvRQu5UBilohJwWg=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_TRANSACTION_SEQUENCE_COLLECTION_SV
