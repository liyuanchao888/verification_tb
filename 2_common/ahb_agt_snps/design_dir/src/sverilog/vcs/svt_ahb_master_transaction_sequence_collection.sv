
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
`protected
4>PQ)&bb#TKdbVNM^4XN/8_C_=/@Y7J2@)GK83Y/-dJ+[aZf7M/57)EHcDR8++b.
3[#eWWZ;dTS(bQ/Y8Y\Q5;b?)&\0\OWQDP>?:Bbe@KC7/:-1.HX,LP5CD>^ga.(@
8HgSfF>85-J8W;>,I+-(eX+O\8+?7#ca6TP0GLc&efB<J^@4>2PU455A&U-A>.]M
S,D.@-F;g;LcY3+Z2]=U@XWWTdX2PIV>X_(fY(e2cG;ZHWUD-fM_D<P-,DF]1c;#
#)U#=f3TP(<?e49>_CLebb=cO?O370+HGbL7S/^?7KLcBc:_a+\@D]S6\5G-M/U.
gG:CQI\/3H8EII?,#YR+fJ.US\+d6[4U:UaNV\BC,(O([95C&D-S&f9+Q@-STc<&
CI.DD[GB4>0O5#bFf0_3bX1:\AS(O@45[-dZUW-HNBYOeYL9O=\A#G1JL4MZ+/]/
I<L4/f3#bgR4ESa\8<I/WMF0fYJ.\L(\8RE>&446^JFSKNZ32YHXL?0.)EfVTYXN
O7&67COAGg\NBG8#?5270[AK+4O&Z:PT6KURO;S?NL:<X+JP/F\NPKMZ(HY[#0WM
;P2[,g_CdZ)HLKe8W]]aS>OW9EK]M22fH?SL92VIFIFG?gY-TA=5I<4NH3#fSg;U
VTQa(:_[)_09GU]aKS,,Ja]&4PIK9\Db#>/>:gRC\]=;e@#I1WcB24\^AI-V<5,&
G:C7SbYA(^2cg(-2TJPKA+[MESZKABEV(]F/]AMbE<-g2C65d.(:]>CAB[S3BB-2
5E\[e/@I&A4N]UL>&eG+2H-Q&<=Je/G4Q/[F7RJ(185UVOc>BW+?38f<aIc&Y=Le
5J:=ggA-NUP[-&@,CD/[4fTN7N^,Z;,^Y[M#ZMO8gZ1N]Of3P>C93?gP6&QW&6a5
+bPV\CI5f\cSV5#6S[fEW6O=HU;]AL_cMcLLU;gQ>UDd)JfX><MQ)#N2-K3aQ;L^
C^3;PT(7&Y@-/TXN2O/5)RMNK6UJFLR1(TZJ:T-b=;WYdO;403EgEIDV@A)>:UL]
RNMPOO3BcXA@dMP49K4gf=_@&X\>YUPAIdHM+E.46ZRLeELWCWdDYRRJ,1=5,J=b
LHDP?.,H2^+6bZ2G;3+?^:T<a?SN):_]/@NVQID+:-9[(V4@)]0)V0+,W:N11)92
0LTHHA(GX-S?I;bUNO6&F8X\bP#d2?T8UVc+F64cD0a)bWF#54_+DVV;1L:a<1_J
U=QX?I09AFWJ;3_/V5C3D^&;QTWZ/E+ZfW5F0]IdH^a9UF0?E_SLL&3#H<:XB5?>
WWgM<,_-97FRb&U450fY8dXZ.O0K,7(6\PW/<Z4=2VQ7aS<c[Q87L&D1)QN((UE?
G0<JYNLW0Z.8D7QT-6GQB6S8[TBUUg(F4ddOTT/b=<1YFaI:=34P[/8)NA5<bUY>
9&Se\_G/4eaVC0E)2>@?7?_-7@^>#Kg9@eIDe/<e>GOT91/+J:?g.>g7@A]UdLHM
U1(9IK9gTN4?09@=A0CE<BLF]18dL>69d5cO><O3Q03XAg,K&b[8GBb(=a-KBC@9
=/a;3I80=U0WZ)_WgW8]Z[fWEDR]dLE7]?I]2Cc^O)gLEUgg5Lb_Bf[@_I(_Web,
7.Y(O\4>]^GY;f:4aK/#b&6M1;&A4LHeN98cf-U-G8D3aY?6=WGVJ.gK4HLO5?_#
8Z)S_Od#TLG7W-;g)BIM3-Z4B\\.Jce0ZXLcR<eE;51;#KSPX&JW(I+d[SdOd?Q)
L\>3BG;[<.9NTFW32.f;9,Vaa,=d]/5)[P0TM((;<M[RBAZRY6]J973Td:UK5?@H
:&/>.@XT/887RNR4=VGOf7\;e]Q[F]dWfR]:d\f>-?4Eb<QIfJ<B90U5_G>XbQ4b
PPg)-Nc]S3KB(C^XY>PR^:M<OU+L:#(fc.G?QQ;d&G1?HD8Q#(N6:(9E[_)18@WW
IR/(G/U@EILTEHG<&@N^DVCe,f@>X[Haa0<SWAE#PA-gS=EV>/KG3>;9,fS(.VLg
OAWFJE:;6BU=MYKdf/9OWF.AQH6=/^-BY2.I:]I8Ed^,.0S6bVOW7B3EP>,J\TXS
(c.\+>Z]0(#b.^9,1XbD\KM7V^b0N;fNWgFe_JcfI>0XO)8De^fWZK0:>W=VCCP-
X0#3-f\P.\#fgJX[E<a</B35gEcBN=K-Tf&>_13KG&I?359@)C+(OaSMfWBC,KC[
)/P)b+0-FD4cOV8^cGfQPc8HUM2bdXV&,MN?+cFN.)_9:6@I.MNIO.D.TY@gAb/d
KgR9.SP;M>9a7Wf#4^#1N:1^&f=&W(7Le&-+(/I.0OWM4:#&Y[K]UVBc#F/eG-&a
BT_^9@(V^\Y27[8d(X[c;>W_-8CFR[-&FSP]9f;D=2:A?:Wc1^c7^K)AG.EG<fA5
^D8ENb?:KYCPJHD,K=1&&]V@FJEf3?OJW<PCc)<eC#8Ac,1IFQdHb8.OVD[Mb/UQ
<R:S(;5<YN4L06F-/aK51LC_affgc_PC69gEIJ\[NJX;2c.2)Me.<&g)JS+=OOd0
LIBFF=gJ+WBLND2RWGJ3M76O>)]U]Hf(.I3YVdSQEVbN6-eD#T1LSYY;6OEdW;MP
1QK(/<K,?2OO?Z=U<C7-E.3c8&#B[T>0KW8WAdR9K59Q]bYcP8GYCX6#^O^cM6BF
UE7\4(+:&5;>GLgPMW@gEfNf-(M/fJf6eZ^\#,:=#1?WC4B[HP,ZYRR9F\-0ZMNM
Na9^R>+G&ALOM>ED=8<IPc2+G7&=X3W:a>G>@=)RS2LBbKT&4?Z@@#1Ue?O4d;6B
X/63:>;N7IaZ4O,O)C(VO6RJQ<^RW8<B3=BZH</H.c2(AVAQQ=UE-#L6WAB@.R;&
g\T?.QdbHY;]EI\6ITf=,+-UY=E^X1;A].c-Jc.?3C-P3Q6YBJOBG8D6-RU4eK[d
YJY:e7HKH-FSf5_F0>8.5COY+,J+GSM@_0Y,_c)^[Y1U]1T[#490W9)L:O29#6@.
U9dNK9e3H4^@[Q1Ic=G,Y1+P/d=3KQL./K1LCO8c,Q=Gg,GY8[cUP(f5V>6B;AJ^
W.>bA)<:2EfX,Y(9O>+M7+>YJ-3?gN3BA30-A[f@C].T[f4#E/Ha_I_9VfFDE4ga
;JZ>SCHO#4AIXeC=gBa&936FVK^F+/d_#g>T6&V[)6VdcMc\C(OJ;-WMee)8+?2&
9J2[T@2RX7M3R7AH:Z>g>V_YcKF_A=DR3[#0I^b6+;F7<OL8N(23TE.--37B:)>-
c@;>K@0]f?KP:=:^f6>Z8>I0J:,,5=PC)[a17H.1,7,8.f\_bf1J0gAFbfeRP-<G
1[B1CN\3/7=d2MZ1_A?.X,SGF.A?QG+YN[8.BNLd(K&Ec1W^@T6X0f)H<1:##+NS
K,_;629fG_Z+7CO&dKN;0YWN^^Udd:</JL=--M)J+W:TgUCZ8&eH.IEbR.G;S<=,
f;0fDSEGaR)(0d5IX2U[#QWN6$
`endprotected


`endif // GUARD_SVT_AHB_MASTER_TRANSACTION_SEQUENCE_COLLECTION_SV
