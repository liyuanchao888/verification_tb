`ifndef GUARD_SVT_AXI_SLAVE_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AXI_SLAVE_SEQUENCE_COLLECTION_SV

typedef class `SVT_AXI_SLAVE_TRANSACTION_TYPE;
typedef class svt_axi_slave_agent;
`ifdef SVT_AXI_INCLUDE_IC_SLAVE_AGENT
typedef class svt_axi_ic_slave_agent;
`endif
// =============================================================================
/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other slave sequences
 * in the collection extend from this base sequence.
 *
 * Execution phase: run_phase
 * Sequencer: Slave agent sequencer
 */
class svt_axi_slave_base_sequence extends svt_sequence #(`SVT_AXI_SLAVE_TRANSACTION_TYPE);
  
   /** Port Configuration handle set by pre_body. */
   svt_axi_port_configuration cfg;

   /** Field for updating slave memory in request order. This can be
    * configured by the user. Default value is 0. When set to 1, 
    * updates slave memory in request order. 
    */
   int update_memory_in_request_order = 0;

   `svt_xvm_object_utils_begin(svt_axi_slave_base_sequence)
    `svt_xvm_field_int(update_memory_in_request_order, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  /** A handle to the slave memory instantiated in the agent. */
  svt_mem axi_slave_mem;

  /** Constructor of base sequence */
  extern function new(string name="svt_axi_slave_base_sequence");

  /** This task called before executing the body of sequence */
  extern virtual task pre_body();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_axi_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_axi_transaction xact);

  /** Dummy method. Kept for backward compatibility */
  extern virtual function void instantiate_axi_slave_mem();

  /** Task for setting update_mem_in_req_order field */
  extern virtual task set_update_mem_in_req_order_field(svt_axi_transaction xact);

endclass: svt_axi_slave_base_sequence


/**
 * This sequence generates random responses to response requests. This sequence
 * gets the slave response sequence item from slave sequencer, randomizes the
 * response, and provides the randomized response to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_response_sequence extends svt_axi_slave_base_sequence;
  
  function new(string name="svt_axi_slave_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);

      `svt_xvm_rand_send(req)
    end
  endtask: body

endclass: svt_axi_slave_response_sequence

// =============================================================================
/**
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_memory_sequence extends svt_axi_slave_base_sequence;
  
  /** A reference to the slave agent where this sequence is running */
  `_SVT_AXI_INTNL_SLV_AGNT slave_agent;

  /** Okay response weight. */
  int unsigned OKAY_wt = 100;

  /** ExOkay response weight. */
  int unsigned EXOKAY_wt = 10;

  /** Slverr response weight. */
  int unsigned SLVERR_wt = 0;

  /** Decerr response weight. */
  int unsigned DECERR_wt = 1;

  /** Customize the sequence for performance measurements */
  int unsigned enable_perf_mode = 0;  

  /** svt_configuration handle */
  svt_configuration get_cfg;

  /** Variable to delay bresp */
  int bvalid_delay = -1;

  function new(string name="svt_axi_slave_memory_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils_begin(svt_axi_slave_memory_sequence)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(EXOKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SLVERR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(DECERR_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task body();
    `SVT_XVM(object) my_parent;
    integer status;
    bit status_OKAY_wt;
    bit status_EXOKAY_wt;
    bit status_SLVERR_wt;
    bit status_DECERR_wt;
    bit status_perf_mode;
    bit status_update_memory_in_request_order;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
      `svt_xvm_fatal("svt_axi_slave_base_sequence-new","Internal Error - Expected parent to be of type svt_axi_slave_agent, but it is not");
    end

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    /** Refernce axi_slave_mem to slave agent's memori. */
    instantiate_axi_slave_mem();

    /** Get the user response weigths. */
`ifdef SVT_UVM_TECHNOLOGY
    status_OKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_EXOKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "EXOKAY_wt", EXOKAY_wt);
    status_SLVERR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SLVERR_wt", SLVERR_wt);
    status_DECERR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "DECERR_wt", DECERR_wt);
    status_update_memory_in_request_order = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "update_memory_in_request_order", update_memory_in_request_order);
    status_perf_mode = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "enable_perf_mode", enable_perf_mode);
`else
    status_OKAY_wt = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_EXOKAY_wt = m_sequencer.get_config_int({get_type_name(), ".EXOKAY_wt"}, EXOKAY_wt);
    status_SLVERR_wt = m_sequencer.get_config_int({get_type_name(), ".SLVERR_wt"}, SLVERR_wt);
    status_DECERR_wt = m_sequencer.get_config_int({get_type_name(), ".DECERR_wt"}, DECERR_wt);
    status_update_memory_in_request_order = m_sequencer.get_config_int({get_type_name(), ".update_memory_in_request_order"}, update_memory_in_request_order);
    status_perf_mode = m_sequencer.get_config_int({get_type_name(), ".enable_perf_mode"},  enable_perf_mode);
`endif
    `svt_xvm_debug("body", $sformatf("OKAY_wt is 'd%0d as a result of %0s.", OKAY_wt, status_OKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("EXOKAY_wt is 'd%0d as a result of %0s.", EXOKAY_wt, status_EXOKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("SLVERR_wt is 'd%0d as a result of %0s.", SLVERR_wt, status_SLVERR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("DECERR_wt is 'd%0d as a result of %0s.", DECERR_wt, status_DECERR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("update_memory_in_request_order is 'd%0d as a result of %0s.", update_memory_in_request_order, status_update_memory_in_request_order ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("enable_perf_mode is 'd%0d as a result of %0s.", enable_perf_mode, status_perf_mode ? "the config DB" : "the default value"));
    `svt_xvm_debug("body","Executing sequence svt_axi_slave_memory_sequence");

    /** Getting axi_port_configuration */ 
    p_sequencer.get_cfg(get_cfg);
    if(!($cast(cfg, get_cfg)))
      `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_axi_port_configuration");

    // Issue an error message if update_memory_in_request_order is set for
    // AXI3 and write data interleaving enabled
    if (update_memory_in_request_order && (cfg.axi_interface_type == svt_axi_port_configuration::AXI3) && (cfg.write_data_interleave_depth > 1)) begin
      `svt_xvm_error("svt_axi_slave_memory_sequence","Updating memory in request order is not supported for AXI3 and write data interleaving enabled");
    end

    forever begin
      bit is_slv_err = 0;
      bit is_slv_decerr = 0;
      bit is_addr_rcvd = 0;

      /** Gets the request from monitor. */
      p_sequencer.response_request_port.peek(req);
      post_response_request_port_get(req);
      `svt_amba_debug("svt_axi_slave_memory_sequence", $sformatf("received slave request %s ADDR_STATUS(%s)", `SVT_AXI_PRINT_PREFIX1(req), req.addr_status.name()));
      if ((req.addr_status == svt_axi_transaction::ACTIVE) || (req.addr_status == svt_axi_transaction::INITIAL)) 
           process_pre_response_xact_randomize(req); 
   
      // slave response request object is sent to sequencer after driver calls add_to_slave_active()
      // however, receive_read_addr() and receive_write_addr() are called within this task as non-blockinf process
      // hence it is possible that sequencer may receive response request when address status is not set yet
      // either because of internal process scheduling or axready hasn't been asserted yet
      // if ((req.addr_status == svt_axi_transaction::ACTIVE) || (req.addr_status == svt_axi_transaction::ACCEPT)) 
        is_addr_rcvd = 1;
      if (is_addr_rcvd &&
          !req.port_cfg.is_slave_addr_in_range(req.get_min_byte_address(req.addr),{(!req.is_secure())})
         )
        is_slv_decerr = 1;
      if (is_addr_rcvd && !req.port_cfg.is_slave_addr_in_range(req.get_max_byte_address(req.addr), {(!req.is_secure())}))
        is_slv_decerr = 1;
      if (is_slv_decerr) begin
       `svt_xvm_debug("body", {`SVT_AXI_PRINT_PREFIX1(req), "Driving DECERR response as the given address does not fall in the configured address map of this slave"});
`ifdef SVT_AXI_SLAVE_DRIVE_X_IF_MEMDATA_X
       if (req.transmitted_channel == svt_axi_transaction::READ) begin
         req.read_data_contains_x = new[req.data.size()];
         foreach (req.read_data_contains_x[i])
           req.read_data_contains_x[i] = 1;
       end
`endif
     end

     /*
      if(cfg.exclusive_access_enable == 1 && cfg.exclusive_monitor_enable == 1 && req.atomic_type == svt_axi_transaction::EXCLUSIVE) begin 
        `svt_xvm_debug("svt_axi_slave_memory_sequence", "Bypassing the Randomization if atomic type is exclusive and exclusive_access_enable bit is 1 and exclusive_monitor_enable == 1");
        status = 1;
      end else 
      */
        randomize_slave_xact(req,is_slv_decerr,enable_perf_mode);

      process_post_response_request_xact_randomize(req); 

      if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");

      if ((cfg.num_fifo_mem) && (req.burst_type == svt_axi_transaction::FIXED)) begin
        // Issue SLVERR if no FIFO found at given address for FIXED burst
        if (slave_agent.get_fifo_index(req.get_tagged_addr()) == -1) begin
          is_slv_err = 1;
          req.bresp = svt_axi_transaction::SLVERR;
          foreach(req.rresp[index])
            req.rresp[index] = svt_axi_transaction::SLVERR; 
        end
      end
      /** For write transaction, put the write data to memory.*/
      if(
          !is_slv_err &&
          (req.transmitted_channel == svt_axi_transaction::WRITE
`ifdef SVT_ACE5_ENABLE
          && req.xact_type != svt_axi_transaction::ATOMIC
`endif) //||
        )begin
        // If update_memory_in_request_order is set then call 
        // set_update_mem_in_req_order_field(req) task for updating
        // update_mem_in_req_order transaction attribute. Updating memory 
        // for this condition will be taken care in 
        // put_write_transaction_data_to_mem() task in
        // svt_axi_slave_agent
        if (update_memory_in_request_order) 
          set_update_mem_in_req_order_field(req);
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (
          !is_slv_err &&
          (req.transmitted_channel == svt_axi_transaction::READ) //|| 
      ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
`ifdef SVT_ACE5_ENABLE
      else if(
               !is_slv_err &&
               (req.xact_type == svt_axi_transaction::ATOMIC)
             )begin
        // If update_memory_in_request_order is set then call 
        // set_update_mem_in_req_order_field(req) task for updating
        // update_mem_in_req_order transaction attribute. Updating memory 
        // for this condition will be taken care in 
        // put_write_transaction_data_to_mem() task in
        // svt_axi_slave_agent
        if (update_memory_in_request_order) 
          set_update_mem_in_req_order_field(req);
        slave_agent.get_read_data_from_mem_to_transaction(req);
        req.perform_atomic_xact_operation(req);
        slave_agent.put_write_transaction_data_to_mem(req);
      end
`endif
      `svt_xvm_send(req)
    end
  endtask: body

  /**
    * This method randomizes the slave transaction
    */
  virtual task randomize_slave_xact(`SVT_AXI_SLAVE_TRANSACTION_TYPE slave_xact, bit is_slv_decerr, bit enable_perf_mode = 0);
    integer status;
    status = req.randomize with {
      if(!(cfg.exclusive_access_enable == 1 && cfg.exclusive_monitor_enable == 1 && atomic_type == svt_axi_transaction::EXCLUSIVE)) {
        this.bresp dist {svt_axi_transaction::OKAY:=OKAY_wt,
                      svt_axi_transaction::EXOKAY:=EXOKAY_wt,
                      svt_axi_transaction::SLVERR:=SLVERR_wt,
                      svt_axi_transaction::DECERR:=DECERR_wt};
       
        foreach (this.rresp[index]) {
          rresp[index] dist {svt_axi_transaction::OKAY:=OKAY_wt,
                               svt_axi_transaction::EXOKAY:=EXOKAY_wt,
                               svt_axi_transaction::SLVERR:=SLVERR_wt,
                               svt_axi_transaction::DECERR:=DECERR_wt};
        }
      }
      // In performance mode, program all delays to 0
      if (enable_perf_mode) {
        addr_ready_delay == 0;
          foreach(wready_delay[idx])
            wready_delay[idx] == 0;
          bvalid_delay == 0;
          foreach(rvalid_delay[idx])
            rvalid_delay[idx] == 0;
      }
      if (is_slv_decerr) {
        foreach(this.rresp[index])
          this.rresp[index] == svt_axi_slave_transaction::DECERR;
        this.bresp == svt_axi_slave_transaction::DECERR;
      } else {
        foreach(this.rresp[index])
          this.rresp[index] != svt_axi_slave_transaction::DECERR;
        this.bresp != svt_axi_slave_transaction::DECERR;
      }

    };
  endtask

  /** 
   * This method is used for programming the slave responses
   * For example:
   *  #- suspends the response of a transaction is in process
   *  #- modify the response of write transactions from slave side
   *  #- program bvalid delay of write transactions from slave side
   */
  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
  endtask: process_post_response_request_xact_randomize

 /** 
   * This method is used for suspending the address and data phase signals from the slave
   * For example:
   *  #- suspends the awready of a transaction is in process
   */
  virtual task process_pre_response_xact_randomize (`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
  endtask: process_pre_response_xact_randomize


  /** To check first address fired by master and received by slave are same */
  virtual task post_response_request_port_get(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
  endtask: post_response_request_port_get

endclass: svt_axi_slave_memory_sequence
// =============================================================================

/**
 * This sequence is used by the VIP to map traffic profile properties to AXI
 * transaction properties. Traffic profile attributes are modelled as properties of
 * this sequence. These are mapped to transaction level properties in the body of
 * the sequence. Users could potentially use this sequence even if 
 * traffic profiles are not used if the attributes of this sequence map to
 * the requirements of modelling the response parameters of slaves in their system
 */
class svt_axi_slave_traffic_profile_sequence extends svt_axi_slave_memory_sequence;
  
  /** The rate at which the slave processes data */
  int rate = `SVT_AXI_MAX_SLAVE_TRAFFIC_PROFILE_RATE;

  /** The granularity at which the slave processes data */
  int xact_size = `SVT_AXI_MAX_SLAVE_TRAFFIC_PROFILE_XACT_SIZE;

  /** Minimum value of read address valid to ready delay */
  int axi_arr_min = 0;

  /** Maximum value of read address valid to ready delay */
  int axi_arr_max = 0;

  /** Minimum value of read address handshake to first data valid delay */
  int axi_r1v_min = 1;

  /** Maximum value of read address handshake to first data valid delay */
  int axi_r1v_max = 1;

  /** Minimum value of write address valid to ready delay */
  int axi_awr_min = 0;

  /** Maximum value of write address valid to ready delay */
  int axi_awr_max = 0;

  /** Minimum value of last write data handshake to write response delay */
  int axi_bv_min = 1;

  /** Maximum value of last write data handshake to write response delay */
  int axi_bv_max = 1;

  /** Read data handshake to next beat valid delay */
  int axi_rbv = 1;

  /** Write data valid to same beat ready delay */
  int axi_wbr = 0;

  function new(string name="svt_axi_slave_traffic_profile_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_traffic_profile_sequence)

  virtual task body();
    super.body();
  endtask

  virtual task randomize_slave_xact(`SVT_AXI_SLAVE_TRANSACTION_TYPE slave_xact, bit is_slv_decerr,bit enable_perf_mode = 0);
    int first_resp_delay;
    bit status;
    if ((slave_xact.addr_status != svt_axi_transaction::INITIAL) &&
        (rate != 0)) begin
      int xact_bytes_aligned_to_xact_size;
      int xact_bytes = slave_xact.get_burst_length() <<  (slave_xact.burst_size);
      xact_bytes_aligned_to_xact_size = xact_size;
      // Since the granularity of processing data is xact_size, the total bytes
      // to be processed is a multiple of xact_size as set in the sequence attribute
      while (xact_bytes_aligned_to_xact_size < xact_bytes)
        xact_bytes_aligned_to_xact_size += xact_size;

      if (xact_bytes_aligned_to_xact_size > rate) begin
        if (xact_bytes_aligned_to_xact_size % rate)
          first_resp_delay = xact_bytes_aligned_to_xact_size/rate + 1;
        else
          first_resp_delay = xact_bytes_aligned_to_xact_size/rate;
      end
      else
        first_resp_delay = 1;

      if (slave_xact.transmitted_channel == svt_axi_transaction::WRITE) begin
        if (first_resp_delay > `SVT_AXI_MAX_WRITE_RESP_DELAY)
          first_resp_delay = `SVT_AXI_MAX_WRITE_RESP_DELAY;
      end
      else begin
        if (first_resp_delay > `SVT_AXI_MAX_RVALID_DELAY)
          first_resp_delay = `SVT_AXI_MAX_RVALID_DELAY;
      end
    end
    status = slave_xact.randomize with {
      this.bresp dist {svt_axi_transaction::OKAY:=OKAY_wt,
                      svt_axi_transaction::EXOKAY:=EXOKAY_wt,
                      svt_axi_transaction::SLVERR:=SLVERR_wt,
                      svt_axi_transaction::DECERR:=DECERR_wt};
       
      foreach (this.rresp[index]) {
        rresp[index] dist {svt_axi_transaction::OKAY:=OKAY_wt,
                               svt_axi_transaction::EXOKAY:=EXOKAY_wt,
                               svt_axi_transaction::SLVERR:=SLVERR_wt,
                               svt_axi_transaction::DECERR:=DECERR_wt};
      }
      if (is_slv_decerr) {
        foreach(this.rresp[index])
          this.rresp[index] == svt_axi_slave_transaction::DECERR;
        this.bresp == svt_axi_slave_transaction::DECERR;
      } else {
        foreach(this.rresp[index])
          this.rresp[index] != svt_axi_slave_transaction::DECERR;
        this.bresp != svt_axi_slave_transaction::DECERR;
      }
      if (slave_xact.addr_status != svt_axi_transaction::INITIAL) {
        
       if (`SVT_AXI_COHERENT_READ || (xact_type == READ)) {
         addr_ready_delay inside {[axi_arr_min:axi_arr_max]};
         foreach (rvalid_delay[i]) {
           // Use random values only if rate that is set is 0
           if (rate == 0)
             (i == 0)->rvalid_delay[i] inside {[axi_r1v_min:axi_r1v_max]};
           else
             (i == 0)->rvalid_delay[i] == first_resp_delay; 
           (i != 0)->rvalid_delay[i] == axi_rbv;
         }
       } else {
         addr_ready_delay inside {[axi_awr_min:axi_awr_max]};
         foreach (wready_delay[i])
           wready_delay[i] == axi_wbr;
         // Use random values only if rate that is set is 0
         if (rate == 0)
           bvalid_delay inside {[axi_bv_min:axi_bv_max]};
         else
           bvalid_delay == first_resp_delay;
       }
      }
    };
  endtask
endclass

// =============================================================================
/**
 * This sequence is used for the exclusive transactions.  It gets the slave
 * response sequence item from slave sequencer.  F?or exclusive access
 * transactions, response is not randomized as the response is pre-computed by
 * the slave, based on exclusive access monitors. If the pre-computed response
 * is modified, the response may not comply with exclusive access rules.  For
 * read transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. For normal transactions,
 * randomized response provided to the slave driver.  This sequence runs
 * forever, and so is not registered with the slave sequence library.
 */

class svt_axi_slave_exclusive_sequence extends svt_axi_slave_base_sequence;
 
  /** A reference to the slave agent where this sequence is running */
  `_SVT_AXI_INTNL_SLV_AGNT slave_agent;

  function new(string name="svt_axi_slave_write_response_sequence");
    super.new(name);
  endfunction
 
  `svt_xvm_object_utils(svt_axi_slave_exclusive_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)
 
  virtual task body();
    
    `SVT_XVM(object) my_parent;
    integer status;
    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
      `svt_xvm_fatal("svt_axi_slave_base_sequence-new","Internal Error - Expected parent to be of type svt_axi_slave_agent, but it is not");
    end
  
    //Will fork-off get_response(rsp) in a forever loop
    sink_responses();

    /** Refernce axi_slave_mem to slave agent's memory. */
    instantiate_axi_slave_mem();

    forever begin
      
      // Response sent in the same clock when wlast is  asserted
      p_sequencer.response_request_port.peek(req);


      if(cfg.exclusive_access_enable == 1 && cfg.exclusive_monitor_enable == 1 && req.atomic_type == svt_axi_transaction::EXCLUSIVE) begin 
        `svt_xvm_debug("svt_axi_slave_exclusive_sequence", $sformatf("Bypassing the Randomization if atomic type is exclusive and exclusive_access_enable bit is 1 and exclusive_monitor_enable bit is 1, port_kind=%s   %s", cfg.axi_port_kind.name(), `SVT_AXI_PRINT_PREFIX1(req)));
      end 
      begin
        // Randomize the response only if atomic type is non exclusive
        status = req.randomize with {
          if(!(cfg.exclusive_access_enable == 1 && cfg.exclusive_monitor_enable == 1 && atomic_type == svt_axi_transaction::EXCLUSIVE)) {
             foreach(rresp[i]) {
               rresp[i] == svt_axi_transaction :: OKAY;
             }
             bresp == svt_axi_transaction :: OKAY;
          }
        };
        if(!status)
          `svt_xvm_fatal("body", "Randomization of slave response failed");
      end  
      
      `svt_xvm_debug("svt_axi_slave_exclusive_sequence", $sformatf("Updated response for normal transaction cfg.exclusive_access_enable=%0d  cfg.exclusive_monitor_enable=%0d req.atomic_type=%s - %s", cfg.exclusive_access_enable,  cfg.exclusive_monitor_enable, req.atomic_type, `SVT_AXI_PRINT_PREFIX1(req)));

      /** For write transaction, put the write data to memory.*/
      if(
          (req.xact_type == svt_axi_transaction::WRITE) ||
          (
            (req.xact_type == svt_axi_transaction::COHERENT) &&
            (req.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP)
          ) 
        )begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if(
          (req.xact_type == svt_axi_transaction::READ) || 
          (
            (req.xact_type == svt_axi_transaction::COHERENT) &&
            (req.coherent_xact_type == svt_axi_transaction::READNOSNOOP)
          ) 
      ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      
      `svt_xvm_send(req)

    end

  endtask: body

endclass : svt_axi_slave_exclusive_sequence

// =============================================================================
/**
 * This sequence asserts slave response.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave responds as OKAY response for first write transaction and SLVERR
 * response for second write transaction.  The sequence uses the built-in slave memory.
 * For write transactions, it writes the data into slave memory. The programmed response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */

class svt_axi_slave_okay_slverr_resp_sequence extends svt_axi_slave_memory_sequence;
 
  /** Local variable */
  int xact_no;

  /** Class Constructor */
  function new(string name="svt_axi_slave_okay_slverr_resp_sequence");
    super.new(name);
  endfunction
 
  `svt_xvm_object_utils(svt_axi_slave_okay_slverr_resp_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)
  
  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Program the slave respones when address status is active */
    if(xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT)  begin
      xact_no++;
      
      /** Slave responds with OKAY response for first transaction and SLVERR
       *  response for second transaction.
       */
      if(xact_no%2)  begin
        xact_req.bresp = svt_axi_transaction::OKAY;
      end
      else  begin
        xact_req.bresp = svt_axi_transaction::SLVERR;
      end
 
      `svt_xvm_debug("svt_axi_slave_okay_slverr_resp_sequence ", "Updated response for transaction");
    end
  endtask: process_post_response_request_xact_randomize
endclass : svt_axi_slave_okay_slverr_resp_sequence 

// =============================================================================
/**
 * This sequence gets the slave response sequence item from slave sequencer.
 * User can modify these responses.  The sequence uses the built-in slave memory. 
 * For write transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_programmed_response_sequence extends svt_axi_slave_memory_sequence;
  
  /** Class Constructor */
  function new(string name="svt_axi_slave_programmed_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_programmed_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    `svt_xvm_debug("process_post_response_request_xact_randomize_method",$sformatf("Slave_bvalid_delay ='d%d ", bvalid_delay)); 
    if(bvalid_delay != -1) begin
      /** Program the bavalid_delay */
      xact_req.reference_event_for_bvalid_delay = svt_axi_transaction::LAST_DATA_HANDSHAKE;
      xact_req.bvalid_delay = bvalid_delay;
        
      `svt_xvm_debug("process_post_response_request_xact_randomize_method",$sformatf("Slave_bresp  = 'd%d", xact_req.bresp));  
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_programmed_response_sequence


// =============================================================================
/**
 * This sequence generates read interleaved data with interleave size of each
 * block equal to one by default. User can modify the interleave block size by
 * setting #interleave_block_size.
 *  
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_read_data_fixed_interleave_block_sequence extends svt_axi_slave_base_sequence;

  /** 
   * Interleave block size, the block size must be less then or equal to
   * #svt_axi_transaction::burst_length. 
   */
  int unsigned interleave_block_size = 1;

  /** Class Constructor */
  function new(string name="svt_axi_slave_read_data_fixed_interleave_block_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_read_data_fixed_interleave_block_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task body();
    bit status;

    //fork off a thread to pull the responses out of response queue
    sink_responses();

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "interleave_block_size", interleave_block_size);
`else
    status = m_sequencer.get_config_int({get_type_name(), ".interleave_block_size"}, interleave_block_size);
`endif
    `svt_xvm_debug("body", $sformatf("interleave_block_size is 'd%0d as a result of %0s.", interleave_block_size, status ? "the config DB" : "the default value"));
   
    forever begin
      p_sequencer.response_request_port.peek(req);

      `svt_xvm_rand_send_with(req,
         {
            this.interleave_pattern == svt_axi_transaction::RANDOM_BLOCK;
            // Equal blocks of interleave_block_size
            foreach(this.random_interleave_array[i])
              random_interleave_array[i] == interleave_block_size;             
         })

    end
  endtask: body

endclass: svt_axi_slave_read_data_fixed_interleave_block_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction ,resumes it after  
 * after read transactions reaches the slave. 
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_memory_suspend_response_sequence extends svt_axi_slave_memory_sequence;
  
  /** Event triggered when actual Write Address transaction initiated.
   *  i.e it will only be triggered when Address status is ACTIVE or ACCEPT. Will
   *  not trigger early for data channel initiated transaction (when data 
   *  reaches slave before address)
   */
  event wr_addr_reached;   

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_memory_suspend_response_sequence");
    super.new(name);
  endfunction
 
  `svt_xvm_object_utils(svt_axi_slave_memory_suspend_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Write transaction */
    if((xact_req.transmitted_channel == svt_axi_transaction::WRITE) && 
      (xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT))begin 
      `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address = 'h%h,",xact_req.addr));
      /** Trigger an event to communicate with virtual sequence */
      -> wr_addr_reached; 
      xact_req.suspend_response = 1;
      suspended_req = xact_req;
    end
    /** Check the received transactions and not suspends the response of Read transaction */  
    if((xact_req.transmitted_channel == svt_axi_transaction::READ) && 
      (xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT))begin 

      suspended_req.suspend_response = 0;
      `svt_xvm_debug("body",$sformatf("Resuming suspended response of transaction with addr='h%h",suspended_req.addr));
    end 
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_memory_suspend_response_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction and resumes it, 
 * after sending the response of immediate read transaction.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_suspend_write_response_sequence extends svt_axi_slave_memory_sequence; 
  
  /** event to communicate with virtual sequence */
  event resume_write_resp;

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_suspend_write_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_suspend_write_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Write transaction */
    if(xact_req.transmitted_channel == svt_axi_transaction::WRITE)begin 
      xact_req.suspend_response = 1;
      `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address = 'h%h,",xact_req.addr));
      suspended_req = xact_req;
      fork
        begin
          /** To resume the suspended response of Write transaction */
          @(resume_write_resp);
          suspended_req.suspend_response = 0;    
          `svt_xvm_debug("body",$sformatf("EVENT resume_write_resp is triggered,Resuming suspended response of transaction with addr='h%h",suspended_req.addr));
        end
      join_none
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_suspend_write_response_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction and resumes it, 
 * after sending the response of immediate read transaction.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_suspend_read_response_sequence extends svt_axi_slave_memory_sequence; 
  
  /** event to communicate with virtual sequence */
  event resume_read_resp;

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_suspend_read_response_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_suspend_read_response_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Read transaction */
    if(xact_req.transmitted_channel == svt_axi_transaction::READ)begin 
      `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address = 'h%h,",xact_req.addr));
      xact_req.suspend_response = 1;
      suspended_req = xact_req;
      fork
        begin
          /** To resume the suspended response of Read transaction */
          @(resume_read_resp);
          suspended_req.suspend_response = 0;    
          `svt_xvm_debug("body",$sformatf("EVENT resume_read_resp is triggered,Resuming suspended response of transaction with addr='h%h",suspended_req.addr));
        end
      join_none
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_suspend_read_response_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction and resumes it, 
 * after sending the response of immediate read transaction.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_suspend_read_response_on_address_sequence extends svt_axi_slave_memory_sequence; 
  
  /** event to communicate with virtual sequence */
  event resume_read_resp;

  /** variable to suspend the response */
  longint address_to_suspend;

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_suspend_read_response_on_address_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_suspend_read_response_on_address_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Read transaction based on address */
    if(xact_req.transmitted_channel == svt_axi_transaction::READ)begin 
      //if(xact_req.addr==address_to_suspend && (xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT))begin
      if(xact_req.addr==address_to_suspend)begin
        xact_req.suspend_response = 1;
        suspended_req = xact_req;
        `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address_to_suspend = 'h%h,suspended_req.suspend_response = 'd%d",xact_req.addr,suspended_req.suspend_response));
        fork
          begin
            /** To resume the suspended response of Read transaction */
            @(resume_read_resp);
              begin
                suspended_req.suspend_response = 0;    
                `svt_xvm_debug("body",$sformatf("EVENT resume_read_resp is triggered,Resuming suspended response of transaction with addr='h%h",address_to_suspend));
              end
          end
        join_none
      end  
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_suspend_read_response_on_address_sequence

// =============================================================================
/**
 * This sequence suspends the response of write transaction and resumes it, 
 * after sending the response of immediate read transaction.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_suspend_write_response_on_address_sequence extends svt_axi_slave_memory_sequence; 
  
  /** event to communicate with virtual sequence */
  event resume_write_resp;

  /** variable to suspend the response */
  longint address_to_suspend;

  /** Handle to hold suspended req*/
  `SVT_AXI_SLAVE_TRANSACTION_TYPE suspended_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_suspend_write_response_on_address_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_suspend_write_response_on_address_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and suspends the response of Write transaction based on address */
    if(xact_req.transmitted_channel == svt_axi_transaction::WRITE)begin 
      if(xact_req.addr==address_to_suspend && (xact_req.addr_status == svt_axi_transaction::ACTIVE || xact_req.addr_status == svt_axi_transaction::ACCEPT))begin
        xact_req.suspend_response = 1;
        suspended_req = xact_req;
        `svt_xvm_debug("body",$sformatf("Suspending the response of transaction with address_to_suspend = 'h%h,suspended_req.suspend_response = 'd%d",xact_req.addr,suspended_req.suspend_response));
        fork
          begin
            /** To resume the suspended response of Write transaction */  
            @(resume_write_resp);
              begin
                suspended_req.suspend_response = 0;    
                `svt_xvm_debug("body",$sformatf("EVENT resume_write_resp is triggered,Resuming suspended response of transaction with addr='h%h",address_to_suspend));
              end
          end
        join_none
      end  
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_suspend_write_response_on_address_sequence

// =============================================================================
/**
 * This sequence trigger event(xact_request_received_event) when transaction 
 * request is received to communicate the other block.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_get_xact_request_sequence extends svt_axi_slave_memory_sequence; 
  
  /** event to communicate with virtual sequence */
  event xact_request_received_event;

  /** Handle of slave request transaction */
  `SVT_AXI_SLAVE_TRANSACTION_TYPE slave_req;

  /** Class Constructor */
  function new(string name="svt_axi_slave_get_xact_request_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_get_xact_request_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task post_response_request_port_get(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Assign local handle for the xact_req */
    slave_req = xact_req;

    /** Trigger this event to communicate the other block that the transaction request is received */
    ->xact_request_received_event;

  endtask: post_response_request_port_get
endclass: svt_axi_slave_get_xact_request_sequence

// =============================================================================
/**
 * This sequence responds out-of-order and issues OKAY response for multiple write
 * transactions from master M0 and SLVERR response for multiple write transactions from
 * master M1.
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights.  The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_slave_diff_write_resp_for_diff_masters_sequence extends svt_axi_slave_memory_sequence; 
  
  /** Variables to the Queues */ 
  int addr_index_m0[$],addr_index_m1[$] ;
  int same_addr_index_m0[$],same_addr_index_m1[$] ;
  int data_transfer_index_m0[$],data_transfer_index_m1[$] ;
  int burst_length_count_m0[$],burst_length_count_m1[$] ;
  
  /** Variables to capture the write transactions address */
  bit[`SVT_AXI_MAX_ADDR_WIDTH - 1:0] num_addr_m0[int], num_addr_m1[int];
  
  /** Variables to capture the write transactions data transfers */
  bit [(`SVT_AXI_MAX_DATA_WIDTH +`SVT_AXI_MAX_ADDR_WIDTH) - 1:0] num_data_transfer_m0[$], num_data_transfer_m1[$];
  
  /** Local Variables */
  bit [(`SVT_AXI_MAX_DATA_WIDTH + `SVT_AXI_MAX_ADDR_WIDTH) - 1:0] temp_transfer_data;

  /** Class Constructor */
  function new(string name="svt_axi_slave_diff_write_resp_for_diff_masters_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_axi_slave_diff_write_resp_for_diff_masters_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)

  virtual task process_post_response_request_xact_randomize(`SVT_AXI_SLAVE_TRANSACTION_TYPE xact_req);
    /** Check the received transactions and modify the response for Write Transactions */
    if(xact_req.transmitted_channel == svt_axi_transaction::WRITE && 
      (xact_req.addr_status == svt_axi_transaction::ACTIVE ||
       xact_req.addr_status == svt_axi_transaction::ACCEPT) ) begin

      /** Mapping Write transaction addresses from multiple masters into different array */
      this.addr_index_m0 = this.num_addr_m0.find_index with (item==xact_req.addr);
      this.addr_index_m1 = this.num_addr_m1.find_index with (item==xact_req.addr);

      /** 
       * Issues OKAY or SLVERR response to respective master,when both masters have same 
       * write address location.
       */
      if(this.addr_index_m0.size() > 0 && this.addr_index_m1.size() > 0) begin
        same_addr_index_m0.push_back(addr_index_m0.pop_front());
        same_addr_index_m1.push_back(addr_index_m1.pop_front());
        fork 
          begin
            /** Wait until data status is accept */
            wait(xact_req.data_status == svt_axi_transaction::ACCEPT);    
            foreach(xact_req.data[i]) begin
              temp_transfer_data = {xact_req.addr,xact_req.data[i]};  
              this.data_transfer_index_m0 = this.num_data_transfer_m0.find_index with (item == temp_transfer_data);
              this.data_transfer_index_m1 = this.num_data_transfer_m1.find_index with (item == temp_transfer_data);
              if(data_transfer_index_m0.size() > 0) begin
                burst_length_count_m0.push_back(data_transfer_index_m0.pop_front());
              end
              if(data_transfer_index_m1.size() > 0) begin
                burst_length_count_m1.push_back(data_transfer_index_m1.pop_front());
              end
            end
            if(burst_length_count_m0.size() == xact_req.burst_length) begin
              xact_req.bresp = svt_axi_transaction::OKAY;
              burst_length_count_m0.delete();
              num_addr_m0.delete(same_addr_index_m0.pop_front());
            end
            else if(burst_length_count_m1.size() == xact_req.burst_length) begin
              xact_req.bresp = svt_axi_transaction::SLVERR;  
              burst_length_count_m1.delete();
              num_addr_m1.delete(same_addr_index_m1.pop_front());
            end
            else begin
              xact_req.bresp = svt_axi_transaction::SLVERR;
              `svt_xvm_debug("body",$sformatf("Mismatch in actual transaction and IC transaction data:: burst_length_m0= 'd0%d,burst_length_m1= 'd0%d, burst_length= 'd0%d",burst_length_count_m0.size(), burst_length_count_m1.size(), xact_req.burst_length ));
              end
          end
        join_none
      end
      /** Issues OKAY response for Selected master M0 */
      else if(this.addr_index_m0.size() > 0 ) begin
        xact_req.bresp = svt_axi_transaction::OKAY;  
        num_addr_m0.delete(addr_index_m0.pop_front());
      end
      /** Issues SLVERR response for Selected master M1 */
      else if(this.addr_index_m1.size() > 0 ) begin
        xact_req.bresp = svt_axi_transaction::SLVERR;  
        num_addr_m1.delete(addr_index_m1.pop_front());
      end       
    end
  endtask: process_post_response_request_xact_randomize
endclass: svt_axi_slave_diff_write_resp_for_diff_masters_sequence

`ifdef SVT_UVM_TECHNOLOGY
// =============================================================================
/**
 * This sequence is used as Reactive seuqnce which translates slave transactions into
 * corresponding AMBA-PV extended TLM Generic Payload Transactions and forwards it via
 * the resp_socket socket for fulfillment by an AMBA-PV Slave.
 * The response returned by the socket is then sent back to the driver.
 *
 * Automatically configured as the run_phase default sequence for every instance of
 * the svt_axi_slave_sequencer if the use_pv_socket property in the port configuration is TRUE
 */

class svt_axi_slave_tlm_response_sequence extends svt_axi_slave_base_sequence;
  /** Port Configuration handle set by pre_body. */
  svt_axi_port_configuration cfg;

  /** A reference to the slave agent where this sequence is running */
  `_SVT_AXI_INTNL_SLV_AGNT agent;
  
  extern function new(string name="svt_axi_slave_tlm_response_sequence");
  `svt_xvm_declare_p_sequencer(svt_axi_slave_sequencer)
  `svt_xvm_object_utils(svt_axi_slave_tlm_response_sequence)
  extern task pre_body();
  extern virtual task body();
  extern virtual task process_read_request(`SVT_AXI_SLAVE_TRANSACTION_TYPE req,
                                           uvm_tlm_generic_payload   gp,
                                           svt_amba_pv_extension     pv);

  extern virtual task process_write_request(uvm_tlm_generic_payload   gp,
                                           `SVT_AXI_SLAVE_TRANSACTION_TYPE req,
					   svt_amba_pv_extension     pv);

endclass :svt_axi_slave_tlm_response_sequence

//--------------------------------------------------------------------------------------
function svt_axi_slave_tlm_response_sequence::new(string name="svt_axi_slave_tlm_response_sequence");
  super.new(name);
endfunction

//--------------------------------------------------------------------------------------
task svt_axi_slave_tlm_response_sequence::pre_body();
  svt_configuration get_cfg;
    p_sequencer.get_cfg(get_cfg);
    if(!($cast(cfg, get_cfg)))
      `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_axi_port_configuration");
  endtask

//--------------------------------------------------------------------------------------
task svt_axi_slave_tlm_response_sequence::body();
  uvm_tlm_generic_payload gp;
  svt_amba_pv_extension   pv;
  `SVT_AXI_SLAVE_TRANSACTION_TYPE req;
  bit status;

  `svt_xvm_debug("body", "Entering sequence...");
  
  if (p_sequencer == null) begin
    `svt_fatal("body", "The svt_axi_slave_tlm_response_sequence was not started on a sequencer");
    return;
  end

  if (!$cast(agent, p_sequencer.get_parent()) || agent == null) begin
    `svt_fatal("body", "The svt_axi_slave_tlm_response_sequence was started on a sequencer that is not a child of a svt_axi_slave_agent slave_agent");
    return;
  end

  forever begin
    // Get the response request from the slave sequencer. The response request is provided to the slave sequencer by the slave port monitor, through TLM port. 
    p_sequencer.response_request_port.peek(req);

    gp = uvm_tlm_generic_payload::type_id::create("gp", p_sequencer);
    pv = new({gp.get_full_name(), ".pv"});
    void'(gp.set_extension(pv));
    
    if (req.transmitted_channel == svt_axi_transaction::WRITE) begin
      process_write_request(gp, req, pv);
      `svt_xvm_send(req)
    end
    else begin
      process_read_request(req, gp, pv);
      `svt_xvm_send(req)
    end
  end

  `svt_xvm_debug("body", "Exiting sequence...");
endtask
//--------------------------------------------------------------------------------------
task svt_axi_slave_tlm_response_sequence::process_read_request(`SVT_AXI_SLAVE_TRANSACTION_TYPE req,
                                                               uvm_tlm_generic_payload   gp,
                                                               svt_amba_pv_extension     pv);
  uvm_tlm_time delay = new("del",1e-12);
  bit status;
  int n_bytes;
  int bytes_in_first_transfer;
  int bytes_in_transfer;
  byte unsigned data_buffer[];
`ifdef SVT_MEM_LOGIC_DATA 
  logic [7:0] data_buffer_tmp[];
  typedef logic [7:0]  logic_[];
`endif
  bit[`SVT_AXI_MAX_DATA_WIDTH-1:0] unpacked_data[];
  bit [`SVT_AXI_MAX_ADDR_WIDTH -1:0] aligned_addr = (req.addr >> req.burst_size) << req.burst_size;

  `svt_xvm_debug("process_read_request", "Entering sequence...");
  
  /*if (req.addr != aligned_addr) begin
    bytes_in_first_transfer = bytes_in_transfer - (req.addr - aligned_addr);
  end
  else begin
    bytes_in_first_transfer = bytes_in_transfer;
  end */
  
  `protected
?6DV0F(^)L?):CBESDg,<+9IgSb+9ZP)TC<6VeSR?6[=O_J<dC?d6)_-3d;,N(><
We7dC^NT54@a7f-_Z<QPT9SLY-WM,&>9_5_,]07ZL:Xg;.IY2;5[15BReg?L)M0E
M?_RO3:4KcaRM:FG)Q/bDGSL1$
`endprotected

  bytes_in_first_transfer = bytes_in_transfer;
  n_bytes = (req.burst_length-1) * bytes_in_transfer + bytes_in_first_transfer;
  
  req.rvalid_delay = new [req.burst_length];
  req.wready_delay = new [req.burst_length];
  req.random_interleave_array = new [req.burst_length];
  foreach (req.random_interleave_array[index]) 
    req.random_interleave_array[index] = req.burst_length;

  if(cfg.use_pv_socket) begin
    req.suspend_response = 1;
    fork 
      begin
        svt_axi_transaction::resp_type_enum resp;
        data_buffer = new[n_bytes];
        gp.set_address(req.addr);
        gp.set_data_length( n_bytes );
        gp.set_response_status(UVM_TLM_INCOMPLETE_RESPONSE);
        gp.set_streaming_width(n_bytes);
        gp.set_read();
        gp.set_data(data_buffer);
	if (pv != null) begin
	  pv.set_size(req.get_burst_size());
	  pv.set_length(req.get_burst_length());
          pv.set_burst(svt_amba_pv::burst_t'(req.get_burst_type()));
        end    
        void'(gp.set_extension(pv));
        agent.resp_socket.b_transport( gp, delay );
        gp.get_data(data_buffer);
        for ( int k=0; k  < data_buffer.size() ; k++)
        `svt_xvm_debug("process_read_request",$sformatf("read data received on Slave is data_buffer['d%d]='h%h for addre ='h%0h ", k, data_buffer[k],req.addr));
        req.data = new[req.burst_length];
        for ( int k=0; k  < req.data.size() ; k++)
        `svt_xvm_debug("process_read_request",$sformatf("read data received on Slave is 'd%d is 'h%h", k, req.data[k]));
`ifdef SVT_MEM_LOGIC_DATA 
        data_buffer_tmp = logic_'(data_buffer);
        req.unpack_byte_stream_to_data(data_buffer_tmp,unpacked_data);
`else
        req.unpack_byte_stream_to_data(data_buffer,unpacked_data);
`endif
        foreach (req.data[i]) begin
          req.data[i] = unpacked_data[i];
        end

	case (gp.get_response_status)
	  UVM_TLM_INCOMPLETE_RESPONSE,UVM_TLM_OK_RESPONSE:
	    resp = svt_axi_transaction::OKAY;
          UVM_TLM_ADDRESS_ERROR_RESPONSE:
	    resp = svt_axi_transaction::DECERR;
        endcase
	
        req.suspend_response = 0;
      end
    join_none
  end 
  `svt_xvm_debug("process_read_request", "Exiting sequence...");
endtask

//--------------------------------------------------------------------------------------
task svt_axi_slave_tlm_response_sequence::process_write_request(uvm_tlm_generic_payload   gp,
                                                                `SVT_AXI_SLAVE_TRANSACTION_TYPE req,
								svt_amba_pv_extension     pv);
  uvm_tlm_time delay = new("del",1e-12);
  byte unsigned  temp_byte_en[];
  byte unsigned data_buffer[];
`ifdef SVT_MEM_LOGIC_DATA 
  typedef byte unsigned byte_unsigned[];
  logic[7:0] data_buffer_tmp[];
`endif
  int n_bytes;
  int bytes_in_first_transfer;
  int bytes_in_transfer;
  bit _packed_wstrb[];

  `svt_xvm_debug("process_write_request", "Entering sequence...");

  req.rvalid_delay = new [req.burst_length];
  req.wready_delay = new [req.burst_length];
  req.random_interleave_array = new [req.burst_length];
  foreach (req.random_interleave_array[index]) 
    req.random_interleave_array[index] = req.burst_length;

  if(cfg.use_pv_socket) begin
    req.suspend_response = 1;
    fork
      begin
        svt_axi_transaction::resp_type_enum resp;
        wait( req.data_status == svt_axi_transaction::ACCEPT );
        //-----------------------------------------------
       `ifdef SVT_MEM_LOGIC_DATA 
        req.pack_data_to_byte_stream(req.data,data_buffer_tmp); // Takes care of all burst_type, burst_size etc.
        data_buffer = byte_unsigned'(data_buffer_tmp);
        `else
        req.pack_data_to_byte_stream(req.data,data_buffer); // Takes care of all burst_type, burst_size etc.
        `endif

        req.pack_wstrb_to_byte_stream(req.wstrb,_packed_wstrb); // Takes care of all burst_type, burst_size etc.
        //n_bytes = data_buffer.size();
        `protected
\28>:b^AL8L3SX1]]B?;QF4JGJQe;50]>:+0->&FWRX;[EaS<@M9&)=LGTVbJg5.
5S5QJ+@IU2TK7&KP=UB[aY6)VY&N69A?KYXGfZ(IC3OYY1@Y/FRE;dc9e13W8E0f
FW/eUZ1][RDW@/A&MTZ14&H>fKR,K4\B=$
`endprotected

        bytes_in_first_transfer = bytes_in_transfer;
        n_bytes = (req.burst_length-1) * bytes_in_transfer + bytes_in_first_transfer;
        temp_byte_en = new[n_bytes];
        for (int i = 0; i < _packed_wstrb.size(); i++) begin
          if (_packed_wstrb[i] == 1'b1)
            temp_byte_en[i] = 8'hFF;
          else
            temp_byte_en[i] = 8'h00;
        end
        //-----------------------------------------------                     
        gp.set_write();
        gp.set_data_length( n_bytes );
        gp.set_byte_enable_length(n_bytes);
        gp.set_response_status(UVM_TLM_INCOMPLETE_RESPONSE);
        if (req.burst_type != svt_axi_transaction::FIXED)
          gp.set_streaming_width(n_bytes);
        else
          gp.set_streaming_width(1);
        gp.set_byte_enable (temp_byte_en);
        gp.set_address(req.addr);
        for ( int k=0; k  < req.data.size() ; k++)
        `svt_xvm_debug("process_write_request",$sformatf("write data received on Slave is req.data['d%0d]= 'h%h data_buffer['d%0d] ='h%h for addr='h%0h ", k, req.data[k],k,data_buffer[k],req.addr));
        gp.set_data(data_buffer);

        delay.set_abstime(0,1.0e-12);
        if (pv != null) begin
	  pv.set_size(req.get_burst_size());
	  pv.set_length(req.get_burst_length());
          pv.set_burst(svt_amba_pv::burst_t'(req.get_burst_type()));
        end  
	void'(gp.set_extension(pv));
        agent.resp_socket.b_transport( gp, delay );

	case (gp.get_response_status)
	  UVM_TLM_INCOMPLETE_RESPONSE,UVM_TLM_OK_RESPONSE:
	    resp = svt_axi_transaction::OKAY;
          UVM_TLM_ADDRESS_ERROR_RESPONSE:
	    resp = svt_axi_transaction::DECERR;
        endcase
	
        req.suspend_response = 0;
      end
    join_none
  end
  `svt_xvm_debug("process_write_request", "Exiting sequence...");
endtask
`endif

class svt_axi_slave_random_snoop_sequence extends svt_sequence #(svt_axi_ic_snoop_transaction);

  /** Port Configuration handle set by pre_body. */
  svt_axi_port_configuration cfg;

  /** Parameter that controls the number of transactions that will be generated */
   rand int unsigned sequence_length = 10;

  `svt_xvm_object_utils(svt_axi_slave_random_snoop_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_snoop_sequencer)

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
 

  function new(string name="svt_axi_ic_snoop_base_sequence");
`protected
dI0@P0,Q.c\#KDJa_a3B0?&F<NW&T(M?NL:,RF88JLOGV74QID8b/)gN4b#ZJ<7[
)L8P/d9<+7c)e/(S2=FEcM2OOEUTFN(&IHf_T4I\NL\GB$
`endprotected

    //Set the response depth to -1, to accept infinite number of responses
    this.set_response_queue_depth(-1);
  endfunction

  task pre_body();
    svt_configuration get_cfg;
    p_sequencer.get_cfg(get_cfg);
    if(!($cast(cfg, get_cfg)))
      `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_axi_port_configuration");
  endtask


  virtual task body();
    bit status;

    `svt_xvm_debug("body", "Entered ...")

`ifdef SVT_UVM_TECHNOLOGY
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
`elsif SVT_OVM_TECHNOLOGY
     void'(m_sequencer.get_config_int({get_type_name(), ".sequence_length"},  sequence_length));
`endif

    `svt_xvm_note("body", $sformatf("sequence_length is 'd%0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"));

    for(int i = 0; i < sequence_length; i++) begin
      `svt_xvm_do(req)
    end

    `svt_xvm_note("body", "Exiting...")
  endtask: body


endclass: svt_axi_slave_random_snoop_sequence

/** @cond PRIVATE */
/**
 * This sequence generates random snoop requests. This sequence
 * gets the snoop object from the interconnect, randomizes it 
 * and provides the randomized transaction to the slave port of the interconnect.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_axi_ic_snoop_base_sequence extends svt_sequence #(svt_axi_ic_snoop_transaction);

  /** Port Configuration handle set by pre_body. */
  svt_axi_port_configuration cfg;

  `svt_xvm_object_utils(svt_axi_ic_snoop_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_axi_slave_snoop_sequencer)

  function new(string name="svt_axi_ic_snoop_base_sequence");
`protected
H4F15/T;OT)?94^P<DBA]ATPM:\3A?\2OdU)cV(8,IT2-<(,8QWQ.)^+70:DIGT1
d<O5-aJO&PaT2\4#0_WDCCAWA)VKg-G?QNWfM,HNDN32B$
`endprotected

    //Set the response depth to -1, to accept infinite number of responses
    this.set_response_queue_depth(-1);
  endfunction

  task pre_body();
    svt_configuration get_cfg;
    p_sequencer.get_cfg(get_cfg);
    if(!($cast(cfg, get_cfg)))
      `svt_xvm_fatal("pre_body","Configuration retrieved through p_sequencer is not of type svt_axi_port_configuration");
  endtask

  virtual task body();
`protected
6aW)->FfWc@E9DfELSF6YVHX.MPBXY09A\6J:9U5+A\N4[5]:LF//)bScgM1S4;Q
-2Eb+_ASD0=fW8?c=#IfV6/WZ]1EAISKTHC#CU(.MeWF?1Zc=Yb@VJM^[\/5L_O5
[OSgd5<4U7H=b9f?ce1MG@NPZH)55YcE[7=2-H4ZJT#aO-d/#CfPYNbM<CRbJZ=U
b8]J41SUeO5=,$
`endprotected

  endtask: body

endclass: svt_axi_ic_snoop_base_sequence
/** @endcond */

// =============================================================================
/**
Utility methods definition of svt_axi_slave_sequence_collection  class
*/


`protected
Z>5;M\RS7FeMN0U:Q=-.?HB13fGOGT(Hb?g.NI4@22FR5?I9KZ112)4(&QJ-;V)F
9=dSQAZX=5.;3EL&:_)O;_0MB]<:#8&PLa89AQ5&G2T&8f+6#<MB8X26:Re&MU8c
7g:E2a.5^3^CF,W_4R\KcH/78^ZC2>1eB=:Y=B[_VMb6K@;a0IB(K+\E9PR,Q&7M
c>XH41#L4gW)]<1c1d]X>.A[63:UYI7M[)g9712_4O#,78B&RXD53Ng,6@VT(-FW
40IKeSc8E_O/&)3@IWL@X,>d=3JQFJ&6<$
`endprotected


//vcs_vip_protect

`protected
Vg:SLZ<d[C/c),J0(DT8cR-UcI_Y]]6f<^_G\bMHGAT>IJ48-6D70(bSg=>>EM(D
\>5@=fY#XZc16A,Ab(5?U)F[eH0-+NA#/TW_/KKZaQ5)?f(<U-;=cg((HGM2XC_/
SVL,WN^dF(GfID20Z+75eS]U6g5AC6OW:;XA(a?<G>(,>:ONQB.dSL1c^A8O7<9b
_KG,(O\&b7QSfWQW3I[=8bPA)B=Y35U.=RgXU_^WXOL?H49G30RC6f>]QN/Y.DBJ
T-Uf(/<Yf.5]BY(ea?2P6ZIYV[1c+Q3[W-c\bVKO3LL55#5M><AA3?VESab:J2G\
C&FWdU.E88:N9AP))_O9+39=/0^7&ba@F3WaVU3YOcMB03N5G3W6.Xf#UB#8:DE)
,_^4HDd1UM1@F-Y/B<]H)?&Z79:WBQ:ZVA9UM&D>+GB#7D_GDG&;C=IcQJSD/LY9
1D_U2M/e\Xc88Y_cFR\6MbH:YFC;D#F7NKb+39J_U=\Y,8Ee^QUO[(b]WP8Oc8/H
#H+;@UGT[DN-ga;H##DgVCP]E?J(gA<Jg<_:3O_W]S3&@fEFL+^\a1E4gF]c0g.U
U-0f>eC&+NQg_G<GgbVXZ##@(X_,5f^-9V6F=?9635+e1cJX<23YbY1Ea?E4NeK7
?.b6f^.2YQaBIL56QT&/[f:#f9A5@D1SDE-Y3B\ZSI&@OgF=>P;I(5JafW]_SbFV
e#aU+^J3+O^JQ1K[UM.TRX@OaJ4ZD\.aA-PR.[>3O4^K#7GPLYcC9&E6H)HMU-LD
W#Mec7ZY=Y#;[@Wc0<V#EM+^S2Xb,#827QN^U),DDO(#+:00+9YV>KOJ-N/5&<18
=O@=T.;23BZW1DP39E.d2K/&\HU04BXOJM_0[Y[P,MNJHKUbL)+-HcP.:/+g1Q4W
C/f74eM;\H,R:5:TBA@&35dd?)(26QEgC))<DQC#_IZ-ZJb(]ZJD/T]@aVa0b/B(
1]6acY1f1U>#_Fc<R?FAM8CWX_2<8HEPVd&C[d++;WB\(RbDL#_Q9,@45.3D(M?L
K+=46NI_KH=,G6]LU=ITVI]Ae2cR(D0EE]/CFZ8<2YF9KdS4---1QKO1b9f3Gf6?
6CXBcP7DT\XF68G,Q3cT7e=U766WH(<cZQUE5#IIK9bcMH#P(N1MC^&7DVV4[^_6
;YRDIfH(X&@F6bZ@cCF[CgV/-,E^Y(J2]5,Pe5U(YW7K1UI\GB8=P@gE\MeVUW=;
-ZUPM4/K&O[],GTP8b-SR9.X?;I8B21ZTPR0W?[+e-?P2.O>IH0e8JN(^BCXI,JM
,^T6LAfeEfe(Ia)gA)HW^[,?(YHM1@ONWLPg_@48.[+>fA,5IAV/:dPYGSZcU6@D
g<;;YV9XXa[URW:(HJT:=d<U#&Z5U-a1He;6YK/HSRP9I[eG/PLEWgK\(Re+;N?e
49[1IQ6McfO->=1US(3NT2C_b(Ge)cU3R@FJeBJECN/N+/FD_;G/I&2Rg0Z4BGL-
THX9S??8Hb-</3McS@#HGUUJ:8#a;H8Z<9D429b>AX<bCEUG:H5WR]]ReYPGSH)(
#M<-5:e,OFSJ:3MZU/V&U9VE#D>]23&O:H_BKK,L@KUE;d79C9=-dLWI[?QBP9.[
=dd:S_YKNbUW]+ORE#F@TY;Qb4/]deP:/GcK::R+A=&<N1[OJ)45HQSFT+F&U&OP
E;dJ&.V>-U>WC-J/)LA\2XdREA,+c4#<E_]TTXJ[TQgF4aE3TK8G^#SJMa)WU^(&
;U?OB46XX>HFO6;gOP2MW0\O\ANTE2KB9;[DW<09F9ANcOSE]Dc)W6M.29#-DR4:
B(-]AZXT_1JHKH[&92I&71I3KDJeN+)9)E2_OVTHL:HP2M_fNNSXCa\gc7f-aYeC
&9HW=)O(/cZ4VdbMD)64b)D63+JC\ZLb4BdV9WPaY=dX6:P:P(.X6VgM\_&8g\MK
(g)3c0#G;LbSYX,IQgb\B,2GXI,X+)3:Q8/=B>:RP[=8Qe,WMXCPH?,/W#ND0YOA
FBQV/X@D1;[#Lf0P_7;2E;4GgWLDBZOKaRI:TYFe0TTPUE9?5/eIBX76X=-Y1CS]
ceF_HLbJ:O1B[c^<@GFRLb,,;_PS.KQX3dZB6?#&:7Q?I1Bg>6&LF;+J+I@(:DR&
2&0W<&,?YG(MJ-6dW_R#O]5)3bR)EE481/J+[If,KIV1Q?A5\IW7)Ac9@NV>W&/F
bLZaZTE=R(91a2Q8L_9<b:V3f?:_YAAM+BcFT.^DXeL5_6H^C4+G_1/D&><-cGg]
,I1d?c8&MW(/KaC/d2J/MNF.[ZR0+7MKDSKEYE@c^J[\>KW)FXK@Z5:;UW&=#8UV
644\:0.4KPQC8\:WQ-&K@6.1.5:@.O-WM4^IF@AW7SdgRL0B1167/-4)X@<D5e\+
T=;8cWPMF8.b0WW<(@#4cR<5a>E4gMTG?CS?\b.52FX_R:RXB4R1E#C[;LH2)>7e
--B5ZOUKGBBV,Pb7P/LNOVVMa6S++X,&1H2PB&WP+3HJK,YJ@;5LQ0NHPNJ=<CH5
\UAE_&:=UPgD8<YKS3HMa?bJMKL)<9]>V7HAbDA]]=S[+FH/,GLX:DXJL4YCUD:I
K=4SdN>,Rbd9/V,gZXLT]X=#1NV[>J>RBddb;@K4=V1]SAAGA__B]8TN]@MN-O/O
&[J[OZ2+0@b/A\bb64I5:+JPd.c4;+XH3Q6cCWSLdQ)aJfdd2fK4-:aaH^NF&--I
A)_Z#Od3R]TAK6;7QefW<A<^7Y?BVKUfUIA<)HUP)gK:1b3)>1G341O0B5D=O-W7
WDHSZ+XG9E8d..[XCR9M=.;20[#eET^IH+.gd.eJeJ7V>?Zc3GGY6D:fE#R9P^fa
]&Ef:a(=/#e?HWZL+DXSD>3CbJc.#aMG2=>9,4G?VU)M\#6d1);D(MCFH+e7Y^L/
@,0b5D/&>I]SJNTOac&S&Hb#M3^YE)/&WD4SZg:/J/@4>YV,eFW-.eJ/>J0B^/Z[
B@[^8PQ]_[U2FAKTJHbAcYVZ@=)MU526\P[2BY]+4L-@>f7<a]POLP+-c89<E-d1
^SRgL8;>?cT0+R5\3G([OCHOIG/RX]V)=F3E9c,E5=_?TAcdX=&/9Z^077ILT/<g
Je+?]c5/B&\O/,ZE<QG58ZQ7Q(@8aS_4(6Z,a>bcPEW+45K0UMF3>GWG<#-E(;gd
b+833G/U@>:2:g[K=FJ/-E:EcbGPf,F9Xf0a<5MM7#Z663V-GdU.^b;W5c@)e78,
;4:.&_B3QF^afG>d68]T/-SUIbV/<)3]YN,MIb:LE&IgO:[g7-C[1=K??GLGO)AG
9_-M]YM>d0<Ag+eWgZ-5-?+8aMH8?)M]W<V<K(4Z5K:0HL+];\_cZEeM;GPg9.=X
#VcB)07Y0cfI_IcDNLNU(3N>Naf-<&,HfMY>&8WDI>cO,5_&Z^#L:\e-]AffKB>b
ReT-[^a@4+,9Z9^\#,MBA]9:2-VJ(AY12d1RZJ?F<#J0;ZT/\/SZPIG(TgUOC8@,
AQ#e/<JY9E]adKC.[@FGV+\G^,G27\O;FV9QEVSF#C4(T@4(<_010PS,(JS=JIg+
RFf_4a4\/fB8gec7(B)2Of2:?^[K^CEO\WbGTGVCM]E(f4=Y@OgKI(5:U70O/](0
=,RZLJ,S1OB854I36SI2,^+EfbNO()3EJS37TfLd=Oc[#6Gddf?+=I<Z&JbIQcZC
bGcB90SVHZR\S,9S+:?4^>.\]B]-IV4<)>7#]UGA><\-ECT8OT^&DZ#[TTEKRG&8
HF6G2db5+A4?bVa7\d4WT:/B2/M_J67,M5.878D=8TXM+&@A^9.,.OZ]8^<[3/71
F4f\0ILP582e0O4c>(^_1OY+>bCO-Bb&@W.24_HXLgR1b>PIP\[b+Y7KOU8PRfEE
;ed<(O6EBUWb8_Q41\\4+E9)V.dCLV4Fd:WN/UXY=/JJ4?)gb&fRZ8,KQW[cc(]P
4B>]e.J;,XMA>-=M?-SI;]fCdGP9QKAcAb1@EVDUIaf?cD[Y>-->SeJKT63P]GJ,
>Za>&=FQ?J9G-:GWVgL#ePeKYG0A\9SN1-ReS@Y\6=X^QgJ2QU/Yd5+2M]602]<e
,\e>=Q4<g(3(?_F=RL;CN5^).R-J?Rc+c;^8EO62=(O.Jfe8T-^+Y3AUY-&AZVa@
,<4>+9(045d8Z6W=d7A?Z:fZYGV9f7;F.5acVHDSS90)W.IP2V;&=Lbe7T/0)6N^
bY9gVS0QPL6gA,eb/6KU;7XKgJ(Db_#dPORMbXFK.D1=PFKC3=eLNR[E)Q:2X<OS
_,,L3?TVQ)^DJf>&9gf^58DMa9T58;7TW2gbPU<gJ\FHN=5F5BWZEY<PMa;XLUWL
D3f>J.7HFV5V;8ScXVT.1FD8QRRD[)QLGR_^<BSZ?DIeTYgMLOX=F^Q^BA]LL0>5
9X8(P^RW]>-(=:K):T6;J(Y:.GKL85<L+>FO=G8<ED>)_M?2USM@Z#d;\C.LKU,T
E<Ee.cZG?>VbXFUB_/G=A6GWLE/9ATeL,YbeTD#BL_;A?O,Y/P6>;cX5#=PTd.S\
^T[35PD5[cd_b7TTD4AJc.J8DUg133@-HVDG9L+]<fQ&L,QKJ3DX;a1O43[eQ1\,
b5Sg\ZZ\E_-TaXY.6T\eY[Z@<A;N6&UNKfZ9egb9B\3DK:M,];U#6GM0DQS1PW>O
BWN+3LM=>Bb5;D)J-JQT&0a[XIbcJT,IQLd(Rc\^,_4#^].)6G#K\0=PM6EQS;3V
F^(4K09a.EG87b4E5OgYJ2IFbERa1+^D9NT6/eD39&B\XN+(ANJ#eM_6abGE;-JI
+g#A^T6/4HW>VQ9EHIF&fIL.DZBQP@1-#;TJb&RDc7XB.,\;:68a.=?+<bJFf?:T
f+Kg-5c<2e>>O(X#(;L2(4Q4;;#c_e\_:$
`endprotected


`endif // GUARD_SVT_AXI_SLAVE_SEQUENCE_COLLECTION_SV

