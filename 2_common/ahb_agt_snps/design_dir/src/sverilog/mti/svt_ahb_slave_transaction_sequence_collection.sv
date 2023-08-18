
`ifndef GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
typedef class svt_ahb_slave_agent;

/**
 * This sequence raises/drops objections in the pre/post_body so that root
 * sequences raise objections but subsequences do not. All other svt_ahb_slave sequences
 * in the collection extend from this base sequence.
 */
class svt_ahb_slave_transaction_base_sequence extends svt_sequence#(svt_ahb_slave_transaction);

  /* Port configuration obtained from the sequencer */
  svt_ahb_slave_configuration cfg;

  `svt_xvm_object_utils(svt_ahb_slave_transaction_base_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  /** Constructor */
  extern function new(string name="svt_ahb_slave_transaction_base_sequence");

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_ahb_slave_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_ahb_slave_transaction xact);

  /** 
   * Routes messages through the parent sequencer and raises an objection and gets
   * the sequencer configuration. 
   */
  extern virtual task body();


endclass: svt_ahb_slave_transaction_base_sequence

// -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ww1q7mObeowQKJ66RvWnbJqPeDGjL0FRC2U61I2+ygCZsEkgNv4ip/LIvm0kGDYB
MDMem9F0I2B3WaBJZ2nlikTAEm0d6l0BI5rF2K6o2nXdcos8G242LP1RGthlj5tH
kxDeF4H8blbOab3R8JUEuEuLsQGhvUi160cv1vjJJDY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2038      )
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
`pragma protect end_protected

/**
 * Abstract:
 * Class ahb_slave_memory_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction 
 * from slave sequencer. The sequence class then randomizes the response with
 * OKAY response and provides it to the slave driver within the slave agent. 
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 *
 * Execution phase: main_phase
 * Sequencer: Slave agent sequencer
 */
class ahb_slave_memory_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction req_resp;

  /** Zero wait cycles weight */
  int unsigned ZERO_WAIT_CYCLES_wt = 100;
  
  /** Median wait cycles weight */
  int unsigned MEDIAN_WAIT_CYCLES_wt = 0;
  
  /** Max wait cycles weight */
  int unsigned MAX_WAIT_CYCLES_wt = 0;

  /** XVM Object Utility macro */
  `svt_xvm_object_utils_begin(ahb_slave_memory_response_sequence)
    `svt_xvm_field_int(ZERO_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MEDIAN_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MAX_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  /** Class Constructor */
  function new(string name="ahb_slave_memory_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    integer status;
    svt_configuration get_cfg;

    // bits if set decides the num_wait_cycles distribution
    bit status_ZERO_WAIT_CYCLES_wt;
    bit status_MEDIAN_WAIT_CYCLES_wt;
    bit status_MAX_WAIT_CYCLES_wt;

    `svt_xvm_note("body", "Entered ...");

`ifdef SVT_UVM_TECHNOLOGY
    status_ZERO_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ZERO_WAIT_CYCLES_wt", ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MEDIAN_WAIT_CYCLES_wt", MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MAX_WAIT_CYCLES_wt", MAX_WAIT_CYCLES_wt);
`else
    status_ZERO_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".ZERO_WAIT_CYCLES_wt"}, ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MEDIAN_WAIT_CYCLES_wt"}, MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MAX_WAIT_CYCLES_wt"}, MAX_WAIT_CYCLES_wt);
`endif

   `svt_xvm_debug("body", $sformatf("ZERO_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", ZERO_WAIT_CYCLES_wt, status_ZERO_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
   `svt_xvm_debug("body", $sformatf("MEDIAN_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MEDIAN_WAIT_CYCLES_wt, status_MEDIAN_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
   `svt_xvm_debug("body", $sformatf("MAX_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MAX_WAIT_CYCLES_wt, status_MAX_WAIT_CYCLES_wt ? "the config DB" : "the default value"));

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `svt_xvm_fatal("body", "Unable to $cast the configuration to a svt_ahb_port_configuration class");
    end

    forever begin
      /**
       * Get the response request from the slave sequencer. The response request is
       * provided to the slave sequencer by the slave port monitor, through
       * TLM port.
       */
      p_sequencer.response_request_port.peek(req_resp);

      /**
       * Randomize the response and delays
       */
      status=req_resp.randomize with {
        num_wait_cycles  dist {0:=ZERO_WAIT_CYCLES_wt,[1:5]:=MEDIAN_WAIT_CYCLES_wt,[6:16]:=MAX_WAIT_CYCLES_wt};
        response_type == svt_ahb_slave_transaction::OKAY;
       };
       if(!status)
        `svt_xvm_fatal("body","Unable to randomize a response");

      /**
       * If write transaction, write data into slave built-in memory, else get
       * data from slave built-in memory
       */
      if(req_resp.xact_type == svt_ahb_slave_transaction::WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end
      else begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);

      /**
       * send to driver
       */
      `svt_xvm_send(req)

    end

    `svt_xvm_note("body", "Exiting...");
  endtask: body

endclass: ahb_slave_memory_response_sequence

/**
 * Abstract:
 * class svt_ahb_slave_controlled_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction
 * from slave sequencer. The sequence class then randomizes the response with 
 * constraints and provides it to the slave driver within the slave agent.
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 */
class svt_ahb_slave_controlled_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Beat number value **/
  int unsigned beat_no_val = 0;

  /** Okay response weight. */
  int unsigned OKAY_wt = 25;

  /** ExOkay response weight. */
  int unsigned ERROR_wt = 25;

  /** Slverr response weight. */
  int unsigned SPLIT_wt = 25;

  /** Decerr response weight. */
  int unsigned RETRY_wt = 25;


  function new(string name="svt_ahb_slave_controlled_response_sequence");
    super.new(name);
  endfunction

  /** UVM Object Utility macro */
  `svt_xvm_object_utils_begin(svt_ahb_slave_controlled_response_sequence)
    `svt_xvm_field_int(beat_no_val, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
   `SVT_XVM(object) my_parent;
    integer status;
    bit status_beat;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
     `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    /** fork off a thread to pull the responses out of response queue **/
    sink_responses();
    
    /** Gets the user provided beatno val wts. */
`ifdef SVT_UVM_TECHNOLOGY
    status_beat     = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "beat_no_val",beat_no_val );
    status_OKAY_wt  = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
`else
    status_beat     = m_sequencer.get_config_int({get_type_name(), ".beat_no_val"}, beat_no_val);
    status_OKAY_wt  = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
`endif
    `svt_xvm_note("body", $sformatf("beat_no_val is 'd%0d as a result of %0s.", beat_no_val, status_beat ? "the config DB" : "randomization"));
    `svt_xvm_note("body", $sformatf("OKAY_wt  is 'd%0d as a result of %0s.", OKAY_wt,  status_OKAY_wt  ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));

    forever begin
      p_sequencer.response_request_port.peek(req);
      
     status = req.randomize with {
		  //Inserting ERROR during the first beat
		  if(burst_type == svt_ahb_transaction::SINGLE){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR during the any user defined beat
		  else if((burst_type == svt_ahb_transaction::INCR4) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR during the any user defined beat
		  else if((burst_type == svt_ahb_transaction::INCR8) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::INCR16) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP4) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP8) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  //Inserting ERROR in the any user defined of transaction  
		  else if((burst_type == svt_ahb_transaction::WRAP16) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }
		  else if((burst_type == svt_ahb_transaction::INCR) && (current_data_beat_num == beat_no_val)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_wait_cycles == 0;
		  }else
		  	response_type == svt_ahb_transaction::OKAY;
     };
     if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_controlled_response_sequence

/**
 * Abstract:
 * class svt_ahb_slave_controlled_split_response_sequence defines a sequence class that
 * provides slave response to the Slave agent present in the System agent. 
 * The sequence receives a response object of type svt_ahb_slave_transaction
 * from slave sequencer. The sequence class then randomizes the response with 
 * constraints and provides it to the slave driver within the slave agent.
 * The sequence also instantiates the slave built-in memory, and writes 
 * into or reads from the slave memory.
 */
class svt_ahb_slave_controlled_split_response_sequence extends svt_ahb_slave_transaction_base_sequence;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Okay response weight. */
  int unsigned OKAY_wt = 25;

  /** Error response weight. */
  int unsigned ERROR_wt = 25;

  /** Split response weight. */
  int unsigned SPLIT_wt = 25;

  /** Retry response weight. */
  int unsigned RETRY_wt = 25;
  
  /** Number of cycles before the slave asserts HSPILT signal*/
  int unsigned seq_num_split_cycles = 0;

  function new(string name="svt_ahb_slave_controlled_split_response_sequence");
    super.new(name);
  endfunction

  /** UVM Object Utility macro */
  `svt_xvm_object_utils_begin(svt_ahb_slave_controlled_split_response_sequence)
    `svt_xvm_field_int(seq_num_split_cycles, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
   `SVT_XVM(object) my_parent;
    integer status;
    bit status_num_split_cycles;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
     `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    /** fork off a thread to pull the responses out of response queue **/
    sink_responses();
    
    /** Gets the user provided beatno val wts. */
`ifdef SVT_UVM_TECHNOLOGY
    status_OKAY_wt  = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
    status_num_split_cycles = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "seq_num_split_cycles", seq_num_split_cycles);
`else
    status_OKAY_wt  = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
    status_num_split_cycles = m_sequencer.get_config_int({get_type_name(), ".seq_num_split_cycles"}, seq_num_split_cycles);
`endif
    `svt_xvm_note("body", $sformatf("OKAY_wt  is 'd%0d as a result of %0s.", OKAY_wt,  status_OKAY_wt  ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));
    `svt_xvm_note("body", $sformatf("seq_num_split_cycles is 'd%0d as a result of %0s.", seq_num_split_cycles, status_num_split_cycles ? "the config DB" : "the default value"));

    forever begin
      p_sequencer.response_request_port.peek(req);
      
     status = req.randomize with {
		  //Inserting ERROR during the first beat
		  if(burst_type == svt_ahb_transaction::SINGLE){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the third beat
		  else if((burst_type == svt_ahb_transaction::INCR4) && (current_data_beat_num == 2)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the seventh beat
		  else if((burst_type == svt_ahb_transaction::INCR8) && (current_data_beat_num == 6)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the fifteenth beat
		  else if((burst_type == svt_ahb_transaction::INCR16) && (current_data_beat_num == 14)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the third beat
		  else if((burst_type == svt_ahb_transaction::WRAP4) && (current_data_beat_num == 2)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the seventh beat
		  else if((burst_type == svt_ahb_transaction::WRAP8) && (current_data_beat_num == 6)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  //Inserting ERROR during the fifteenth beat
		  else if((burst_type == svt_ahb_transaction::WRAP16) && (current_data_beat_num == 14)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
		  else if((burst_type == svt_ahb_transaction::INCR) && (current_data_beat_num == 3)){
        response_type dist {svt_ahb_transaction::OKAY :=OKAY_wt,
                            svt_ahb_transaction::ERROR:=ERROR_wt,
                            svt_ahb_transaction::SPLIT:=SPLIT_wt,
                            svt_ahb_transaction::RETRY:=RETRY_wt};
			  num_split_cycles == local::seq_num_split_cycles;
		  }
      else {
		  	response_type == svt_ahb_transaction::OKAY;
			  num_split_cycles == 0;
      }
     };
     if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_controlled_split_response_sequence

// =============================================================================
/** 
 *  This sequence generates random svt_ahb_slave transactions.
 */
class svt_ahb_slave_transaction_random_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_random_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_random_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);

      `svt_xvm_rand_send(req)
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_random_sequence

// =============================================================================
/** 
 *  This sequence generates distributed random svt_ahb_slave transactions.
 */
class svt_ahb_slave_transaction_distributed_random_sequence extends svt_ahb_slave_transaction_base_sequence;

  svt_ahb_slave_transaction req_resp;

  /** Okay response weight. */
  int unsigned OKAY_wt = 50;

  /** ERROR response weight. */
  int unsigned ERROR_wt = 50;

  /** Zero wait cycles weight */
  int unsigned ZERO_WAIT_CYCLES_wt = 30;
  
  /** Zero wait cycles weight */
  int unsigned MEDIAN_WAIT_CYCLES_wt = 15;
  
  /** Zero wait cycles weight */
  int unsigned MAX_WAIT_CYCLES_wt = 10;

  function new(string name="svt_ahb_slave_transaction_distributed_random_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils_begin(svt_ahb_slave_transaction_distributed_random_sequence)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ZERO_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MEDIAN_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(MAX_WAIT_CYCLES_wt, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end
  
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //`SVT_XVM(object) my_parent;
    integer status;
    
    svt_configuration get_cfg;
	  
    //Declare status variables
	  bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_ZERO_WAIT_CYCLES_wt;
    bit status_MEDIAN_WAIT_CYCLES_wt;
    bit status_MAX_WAIT_CYCLES_wt;
    
    `svt_xvm_note("body", "Entered ...");

    //fork off a thread to pull the responses out of response queue
    sink_responses();

/** Get the user response weigths. */
`ifdef SVT_UVM_TECHNOLOGY
    status_OKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_ZERO_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ZERO_WAIT_CYCLES_wt", ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MEDIAN_WAIT_CYCLES_wt", MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "MAX_WAIT_CYCLES_wt", MAX_WAIT_CYCLES_wt);
`else
    status_OKAY_wt = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_ZERO_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".ZERO_WAIT_CYCLES_wt"}, ZERO_WAIT_CYCLES_wt);
    status_MEDIAN_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MEDIAN_WAIT_CYCLES_wt"}, MEDIAN_WAIT_CYCLES_wt);
    status_MAX_WAIT_CYCLES_wt = m_sequencer.get_config_int({get_type_name(), ".MAX_WAIT_CYCLES_wt"}, MAX_WAIT_CYCLES_wt);
`endif
    `svt_xvm_debug("body", $sformatf("OKAY_wt is 'd%0d as a result of %0s.", OKAY_wt, status_OKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ZERO_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", ZERO_WAIT_CYCLES_wt, status_ZERO_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("MEDIAN_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MEDIAN_WAIT_CYCLES_wt, status_MEDIAN_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("MAX_WAIT_CYCLES_wt is 'd%0d as a result of %0s.", MAX_WAIT_CYCLES_wt, status_MAX_WAIT_CYCLES_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body","Executing sequence svt_ahb_slave_transaction_distributed_random_sequence")

    forever begin
      p_sequencer.response_request_port.peek(req_resp);
      
      status = req_resp.randomize with {
        response_type    dist {svt_ahb_transaction::OKAY:=OKAY_wt,svt_ahb_transaction::ERROR:=ERROR_wt};
	      num_wait_cycles  dist {0:=ZERO_WAIT_CYCLES_wt,[1:5]:=MEDIAN_WAIT_CYCLES_wt,[6:16]:=MAX_WAIT_CYCLES_wt};
	    };
     
      if(!status)
        `svt_xvm_fatal("body", "Randomization of slave response failed");
    
      if(req_resp.xact_type == svt_ahb_slave_transaction::WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end
      else if(req_resp.xact_type == svt_ahb_slave_transaction::READ)begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
    
      $cast(req,req_resp);
      
      /**
       * send to driver
       */
      `svt_xvm_send(req)
    
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_distributed_random_sequence

// =============================================================================
/** 
 *  This sequence generates OKAY responses.
 */
class svt_ahb_slave_transaction_okay_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_okay_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_okay_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::OKAY;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_okay_sequence

// =============================================================================
/** 
 *  This sequence generates ERROR responses.
 */
class svt_ahb_slave_transaction_error_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_error_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_error_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::ERROR;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_error_sequence

// =============================================================================
/** 
 *  This sequence generates SPLIT responses.
 */
class svt_ahb_slave_transaction_split_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_split_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_split_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::SPLIT;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_split_sequence

// =============================================================================
/** 
 *  This sequence generates RETRY responses.
 */
class svt_ahb_slave_transaction_retry_sequence extends svt_ahb_slave_transaction_base_sequence;

  function new(string name="svt_ahb_slave_transaction_retry_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils(svt_ahb_slave_transaction_retry_sequence)
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    forever begin
      p_sequencer.response_request_port.peek(req);
      
      `svt_xvm_rand_send_with(req, {response_type == svt_ahb_transaction::RETRY;})
    end
  endtask: body

  virtual function bit is_applicable(svt_configuration cfg);
    return 1;
  endfunction : is_applicable
endclass: svt_ahb_slave_transaction_retry_sequence

// =============================================================================
/**
 * This sequence gets the slave response sequence item from slave sequencer.
 * The slave response is then randomized based on certain weights. User can
 * modify these weights such that the sum of all the weights is 100.
 * Also the sequence provides additional level of control interms of maximum
 * number of non-OKAY responses to be allowed on per full AHB transaction.
 * The sequence uses the built-in slave memory. For read
 * transactions, it reads the data from the slave memory. For write
 * transactions, it writes the data into slave memory. The randomized response
 * is then provided to the slave driver.
 * 
 * This sequence runs forever, and so is not registered with the slave sequence
 * library.
 */
class svt_ahb_slave_transaction_memory_sequence extends svt_ahb_slave_transaction_base_sequence;
  
  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent slave_agent;

  /** Controls the number of wait cycles: zero or a random value */
  bit zero_num_wait_cycles = 0;
  
  /** OKAY response weight. */
  int unsigned OKAY_wt = 100;

  /** ERROR response weight. */
  int unsigned ERROR_wt = 0;

  /** SPLIT response weight. */
  int unsigned SPLIT_wt = 0;

  /** RETRY response weight. */
  int unsigned RETRY_wt = 0;

  /** 
   * This variable controls the maximum number of times a SPLIT 
   * responses that can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on SPLIT_wt set.
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * .
   */
  int allowed_split_count_per_xact = -1;
  /** 
   * This variable controls the maximum number of times a RETRY 
   * responses that can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on RETRY_wt set.
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * .
   */
  int allowed_retry_count_per_xact = -1;
  
  /** 
   * This variable controls the maximum number of times an ERROR 
   * response can be generated for a given complete AHB transaction
   * (cumulative of all beats including rebuilds)
   * - Value of -1 indicates that the counters are disabled, 
   *   that is, response type purely depends on ERROR_wt set
   * - Value of >=0 indicates that the counter expires after
   *   reaching this value.
   * - The counter for error response with value of > 1 really
   *   matters only when the error response policy is set to 
   *   CONTINUE_ON_ERROR.
   * .
   */
  int allowed_error_count_per_xact = -1;

  /** @cond PRIVATE */
  /** READ ONLY: Used to track observed non-OKAY response counts */
  protected int observed_split_count_for_current_xact = 0;
  protected int observed_retry_count_for_current_xact = 0;
  protected int observed_error_count_for_current_xact = 0;
  protected bit new_xact = 0;
  
  /** READ ONLY: Used to track the rebuilds */
  protected svt_ahb_transaction::response_type_enum prev_resp = svt_ahb_transaction::OKAY;
  /** @endcond */
  
  function new(string name="svt_ahb_slave_transaction_memory_sequence");
    super.new(name);
  endfunction

  `svt_xvm_object_utils_begin(svt_ahb_slave_transaction_memory_sequence)
    `svt_xvm_field_int(OKAY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(ERROR_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(SPLIT_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(RETRY_wt, `SVT_XVM_ALL_ON)
    `svt_xvm_field_int(zero_num_wait_cycles, `SVT_XVM_ALL_ON)
  `svt_xvm_object_utils_end

  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  virtual task body();
    `SVT_XVM(object) my_parent;
    integer status;
    bit status_zero_num_wait_cycles;
    bit status_OKAY_wt;
    bit status_ERROR_wt;
    bit status_SPLIT_wt;
    bit status_RETRY_wt;
    bit status_allowed_split_count_per_xact;
    bit status_allowed_retry_count_per_xact;
    bit status_allowed_error_count_per_xact;

    int local_OKAY_wt, local_ERROR_wt, local_SPLIT_wt, local_RETRY_wt;

    my_parent = p_sequencer.get_parent();
    if (!($cast(slave_agent,my_parent))) begin
      `svt_xvm_fatal("svt_ahb_slave_transaction_base_sequence-new","Internal Error - Expected parent to be of type svt_ahb_slave_agent, but it is not");
    end

    //fork off a thread to pull the responses out of response queue
    sink_responses();

    /** Get the user response weigths. */
`ifdef SVT_UVM_TECHNOLOGY
    status_zero_num_wait_cycles = uvm_config_db#(bit)::get(m_sequencer, get_type_name(), "zero_num_wait_cycles", zero_num_wait_cycles);
    status_OKAY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "OKAY_wt", OKAY_wt);
    status_ERROR_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "ERROR_wt", ERROR_wt);
    status_SPLIT_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "SPLIT_wt", SPLIT_wt);
    status_RETRY_wt = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "RETRY_wt", RETRY_wt);
    status_allowed_split_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_split_count_per_xact", allowed_split_count_per_xact);
    status_allowed_retry_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_retry_count_per_xact", allowed_retry_count_per_xact);
    status_allowed_error_count_per_xact = uvm_config_db#(int unsigned)::get(m_sequencer, get_type_name(), "allowed_error_count_per_xact", allowed_error_count_per_xact);

`else
    status_zero_num_wait_cycles = m_sequencer.get_config_int({get_type_name(), ".zero_num_wait_cycles"}, zero_num_wait_cycles);
    status_OKAY_wt = m_sequencer.get_config_int({get_type_name(), ".OKAY_wt"}, OKAY_wt);
    status_ERROR_wt = m_sequencer.get_config_int({get_type_name(), ".ERROR_wt"}, ERROR_wt);
    status_SPLIT_wt = m_sequencer.get_config_int({get_type_name(), ".SPLIT_wt"}, SPLIT_wt);
    status_RETRY_wt = m_sequencer.get_config_int({get_type_name(), ".RETRY_wt"}, RETRY_wt);
    status_allowed_split_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_split_count_per_xact"}, allowed_split_count_per_xact);
    status_allowed_retry_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_retry_count_per_xact"}, allowed_retry_count_per_xact);
    status_allowed_error_count_per_xact = m_sequencer.get_config_int({get_type_name(), ".allowed_error_count_per_xact"}, allowed_error_count_per_xact);
`endif // !`ifdef SVT_UVM_TECHNOLOGY
    
    `svt_xvm_debug("body", $sformatf("zero_num_wait_cycles is 'b%0b as a result of %0s.", zero_num_wait_cycles, status_zero_num_wait_cycles ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("OKAY_wt is 'd%0d as a result of %0s.", OKAY_wt, status_OKAY_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("ERROR_wt is 'd%0d as a result of %0s.", ERROR_wt, status_ERROR_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("SPLIT_wt is 'd%0d as a result of %0s.", SPLIT_wt, status_SPLIT_wt ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("RETRY_wt is 'd%0d as a result of %0s.", RETRY_wt, status_RETRY_wt ? "the config DB" : "the default value"));

    `svt_xvm_debug("body", $sformatf("allowed_split_count_per_xact is 'd%0d as a result of %0s.", allowed_split_count_per_xact, status_allowed_split_count_per_xact ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("allowed_retry_count_per_xact is 'd%0d as a result of %0s.", allowed_retry_count_per_xact, status_allowed_retry_count_per_xact ? "the config DB" : "the default value"));
    `svt_xvm_debug("body", $sformatf("allowed_error_count_per_xact is 'd%0d as a result of %0s.", allowed_error_count_per_xact, status_allowed_error_count_per_xact ? "the config DB" : "the default value"));

    
    `svt_xvm_debug("body","Executing sequence svt_ahb_slave_transaction_memory_sequence");

    forever begin
      // Initialize local wts with orignal wts
      local_OKAY_wt= OKAY_wt;
      local_ERROR_wt = ERROR_wt;
      local_SPLIT_wt = SPLIT_wt;
      local_RETRY_wt = RETRY_wt;
      
      /** Gets the request from monitor. */
      p_sequencer.response_request_port.peek(req);

      // Reset observed counts for non-OKAY response types to zero
      if(req.trans_type == svt_ahb_transaction::NSEQ) begin
        new_xact = 1;
        if ((allowed_retry_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::RETRY)) observed_retry_count_for_current_xact = 0;
        if ((allowed_split_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::SPLIT)) observed_split_count_for_current_xact = 0;
        if ((allowed_error_count_per_xact >= 0) && (prev_resp != svt_ahb_transaction::ERROR)) observed_error_count_for_current_xact = 0;
      end
      else begin
        new_xact = 0;
      end 

      if ((req.burst_type == svt_ahb_transaction::WRAP4) ||
          (req.burst_type == svt_ahb_transaction::WRAP8) ||
          (req.burst_type == svt_ahb_transaction::WRAP16)) begin
        local_SPLIT_wt = 0;
        local_RETRY_wt = 0;
        `svt_xvm_debug("body", "Updating SPLIT_wt to 0, RETRY_wt to 0 as rebuilds with burst_type of wrap is not supported.");
      end
      else begin
        // Setup the final wts for non-OKAY response types based on allowed onon-OKAY response count per xact
        if ((allowed_split_count_per_xact >= 0) && (observed_split_count_for_current_xact >= allowed_split_count_per_xact)) begin
          `svt_xvm_debug("body", $sformatf("Updating SPLIT_wt to 0 as observed_split_count_for_current_xact 'd%0d is greater than or equal to allowed_split_count_per_xact 'd%0d.", observed_split_count_for_current_xact, allowed_split_count_per_xact));
          local_SPLIT_wt = 0;
        end
        if ((allowed_retry_count_per_xact >= 0) && (observed_retry_count_for_current_xact >= allowed_retry_count_per_xact)) begin
          `svt_xvm_debug("body", $sformatf("Updating RETRY_wt to 0 as observed_retry_count_for_current_xact 'd%0d is greater than or equal to allowed_retry_count_per_xact 'd%0d.", observed_retry_count_for_current_xact, allowed_retry_count_per_xact));
          local_RETRY_wt = 0;
        end
      end // else: !if((req.burst_type == svt_ahb_transaction::WRAP4) ||...
      
      if ((allowed_error_count_per_xact >= 0) && (observed_error_count_for_current_xact >= allowed_error_count_per_xact)) begin
        `svt_xvm_debug("body", $sformatf("Updating ERROR_wt to 0 as observed_error_count_for_current_xact 'd%0d is greater than or equal to allowed_error_count_per_xact 'd%0d.", observed_error_count_for_current_xact, allowed_error_count_per_xact));
        local_ERROR_wt = 0;
      end

      // Now setup final wt for OKAY response based on non-OKAY response wts
      local_OKAY_wt = (100 - local_SPLIT_wt - local_RETRY_wt - local_ERROR_wt);
      
      `svt_xvm_debug("body", $sformatf("Weights to be used for randomizing response type: OKAY_wt: 'd%0d. ERROR_wt: 'd%0d. RETRY_wt: 'd%0d. SPLIT_wt: 'd%0d", local_OKAY_wt, local_ERROR_wt, local_RETRY_wt, local_SPLIT_wt)); 
      
      status = req.randomize with {
        response_type dist {svt_ahb_transaction::OKAY:=local_OKAY_wt,
                            svt_ahb_transaction::ERROR:=local_ERROR_wt,
                            svt_ahb_transaction::SPLIT:=local_SPLIT_wt,
                            svt_ahb_transaction::RETRY:=local_RETRY_wt};
			    if (zero_num_wait_cycles) { 
			      num_wait_cycles == 0;
                            }
			    else {
			      num_wait_cycles inside {[0:16]};
			    }
      };

      process_post_response_request_xact_randomize(req);

      if(!status) begin
        `svt_xvm_fatal("body", "Randomization of slave response failed");
      end
      else begin 
        prev_resp = req.response_type;
        
        if ((allowed_split_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::SPLIT)) begin
          observed_split_count_for_current_xact++;
        end
        else if ((allowed_retry_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::RETRY)) begin
          observed_retry_count_for_current_xact++;
        end
        else if ((allowed_error_count_per_xact >= 0) && (req.response_type == svt_ahb_transaction::ERROR)) begin
          observed_error_count_for_current_xact++;
        end
      end

      /** For write transaction, put the write data to memory.*/
      if (req.xact_type == svt_ahb_slave_transaction::WRITE) begin
        slave_agent.put_write_transaction_data_to_mem(req);
      end
      /** For Read transaction, get the read data from memory.*/
      else if (req.xact_type == svt_ahb_slave_transaction::READ) begin
        slave_agent.get_read_data_from_mem_to_transaction(req);
      end
      `svt_xvm_send(req)
    end
  endtask: body

  /** 
   * This method is used for programming the slave responses
   * For example:
   *  #- suspends the response of a transaction in process
   */
  virtual task process_post_response_request_xact_randomize(svt_ahb_slave_transaction xact_req);
  endtask: process_post_response_request_xact_randomize

endclass: svt_ahb_slave_transaction_memory_sequence
`ifdef SVT_UVM_TECHNOLOGY
// =============================================================================
/**
 * This sequence is used as Reactive seuqnce which translates slave transactions into
 * corresponding AMBA-PV extended TLM Generic Payload Transactions and forwards it via
 * the resp_socket socket for fulfillment by an AMBA-PV Slave.
 * The response returned by the socket is then sent back to the driver.
 *
 * Automatically configured as the run_phase default sequence for every instance of
 * the svt_ahb_slave_sequencer if the use_pv_socket property in the port configuration is TRUE
 */

class svt_ahb_slave_tlm_response_sequence extends svt_ahb_slave_transaction_base_sequence;
  /* Port configuration obtained from the sequencer */
  svt_ahb_slave_configuration cfg;

  /** A reference to the slave agent where this sequence is running */
  svt_ahb_slave_agent agent;
  extern function new(string name="svt_ahb_slave_tlm_response_sequence");
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)
  `svt_xvm_object_utils(svt_ahb_slave_tlm_response_sequence)

  extern task pre_body();
  extern virtual task body();
  
  extern virtual task process_read_request(svt_ahb_slave_transaction req,
                                           uvm_tlm_generic_payload   gp,
                                           svt_amba_pv_extension     pv);

  extern virtual task process_write_request(uvm_tlm_generic_payload   gp,
                                           svt_ahb_slave_transaction req);
endclass:svt_ahb_slave_tlm_response_sequence
//--------------------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BNKMGY2q4uKto+Rphg1gr5BabHL8XFq5rW0A/mLAwS5jLdHbZg/HOV0OSFE4Yot2
lBUZy1NJdM+7NGo+HSociOn1ihI6ZluNgYVSsW9skZ+2JlLCdJK9UkIEIDr905jh
O3gmS5SJ2q2TYd8en6WlQ3IM4EB3O9smg/oFU9S+TFM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7843      )
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
`pragma protect end_protected
`endif

// =============================================================================

/**
  AHB VIP provides a pre-defined sequence library
  svt_ahb_slave_transaction_sequence_library, which can hold the AHB
  sequences. The library by default has no registered sequences. You are
  expected to call
  svt_ahb_slave_transaction_sequence_library::populate_library() method to
  populate the sequence library with svt_ahb_slave sequences provided with the VIP. The
  system configuration is provided to the populate_library() method as an
  argument. Based on the configuration, appropriate sequences are added to
  the sequence library.  You can then load the sequence library in the sequencer
  within the svt_ahb_slave agent.

  The user can also add user-defined sequences to this sequence library using
  appropriate UVM methods.
 */
class svt_ahb_slave_transaction_sequence_library extends svt_sequence_library#(svt_ahb_slave_transaction);
  `svt_xvm_object_utils(svt_ahb_slave_transaction_sequence_library)

  //Required to allow new_item() to have access to the parent sequencer
  `svt_xvm_declare_p_sequencer(svt_ahb_slave_sequencer)

  //Removes all registered sequences from this library
  extern function void remove_all_sequences();

  /**
    Populates the library with all sequences as defined in this class

    @param cfg User is expected to pass a port configuration to this argument.
    Based on the port configuration, this method adds the appropriate sequences
    from the svt_ahb_slave sequence collection to the svt_ahb_slave sequence library.
    */
  extern function int unsigned populate_library(svt_configuration cfg);

  extern function new (string name="svt_ahb_slave_transaction_sequence_library");
endclass

//-----------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bBKSEgVH+wJJskmxZNfcBxFTzG2bPwsgOW/p6DODkj7Lo+pGfFsKS+F69BD7aqZB
uQQii/mzt17CAHTHimEatSzu6ogHeJa4ko5QZ7VHFchooKr4rQEjbychQRs+sUnh
yw5ntRbbvJtcNL19zyBwfZwxUKzuZrcErIjjiQPByJk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9182      )
WqmP4aeAz9BKwSu69lDgiCFgBzAziZ7R0+CQ+YahXWSKAi3jkik3LJimhRg8nVKr
0+xXKeMHUa8TFKbRhlKtqT6Bh8Qz50AzMR4q2yfG5YedrhgL9ZSqIOam4TN+Gbek
3C/CHocXkvavUlMyikq2fFwfS88Zhr47m5yp2CNZBkUu5CYZtl3610ZDHOZFbHj9
YJ+HcFCDoAG2lzo0tK6H+2TozONiCMKvCuTC0UO83p2Hja3HmvDhv4iyKmnv6mSE
Q4RzXYB2vu9UiJnFh0mVf8MadZnaMkqhg6mLOJT/N6GubJgrrPD93GiyYkHuEOtZ
Lq7yWWlcxxwHkQ/jzrh3rcYdQsZTa6DlRe3gimyOa4hVm2HDDSGVNfeWQE4c/ukC
IB6Jx/5IZX93mMkATWi/3ox5aPQ+ogIBxTdFXDz8RUcCxefO4VYb5S++70EOG9ST
OIMBgAaQJFTpGVNi3VIgi3eGjPnyBpMHGGQ8PQ38X8Mptk04JR6UxGxUXSMYKSS9
NQqUTjhN3IAnnk7FKeGQ3cUwXqncfOhcFZ5ma5IVIaUPCfKYxTI5GXCw87+fvXCe
lBcT+prADIc4kyuN+AVxONjAy9fdsJenubefwnDT0+cGQ77Zl5DpviB+oYR5VXZR
y0vgplGNZTRmS/q7ykcdieDE+daIf1KLpaD9Uo0OW8wq5src+uJRb2dRNVyFgRR8
4bGOyOJ6INz8P0CsDsU0FD0f2/SdRKnGmi/YCKPf6vMyebm23W2NJ9NvPRAxhNCh
pSKrrHOSKFHX2eDRFc0qY1sgdpbWu9uJ2IR445BUziHNM/tToV9tg08mGG0zYnir
AIohdKdmhcUi/1+/dGLu6zjJwkJYZCtun8BPhu4AqyfVVrBYh+C7HlAa+X4DkSeA
E7ChqBMmurvnqaBWvug3tjQkScXBgnoV61zuxjYQMt9tXZq4lxI4+3dzRPPzBbRt
v+//zcds1Q8QJ9+iBjB4RaGEEJBmtCeRqZaFJIRZKGq49QkejDX2ACZWTyQJTvLe
pDR5Fqr0/KAKc/kZXYhGnnESxfPveApTnje5IqbgxzuOwyPcnLm/VJpXmp7xv/JH
Kpe/RrB8JyEMU6GCXKtn5HPtkMDLeizL/TvLS0h6CLkK9DSL50kqT+K4COvAOe4+
ZArcMJ2R5IOylFDAMEAFsz0eH6QsdrKI7dqbNCcsKDZHrv81ELvHnniVEpGZ9wWk
+SWmYCXpj17eSD/jPzJkrzS1DXA+p8e+lQZdcdLfelPTwpviqzjHOoNB3giyO5Xj
Jr6VsZsrl8G7bUThVyqvca9cZ0cwo6p4/gkhDrLs1rowmmmp/rovCJe0LHzcnp1j
0dwKxRYiaobiqn179fE2Ti4y9RUKGZHFcwAWAUFEasiPIXEqLpnxtfOlwc25DdmC
4t0plPJF5yQK9xSLs11Uqux6Qw4lXLxSeFd6j+ir9mRuEuKC/e4U9Fqf8kfz2smW
VQHLoXFDvxdXm5JIQ2nd/lSRcb9jOk8ig7B8LvSzY5KVCTD+Wp5zomBtqnAT18qT
MZ9Ll9EDzdqHVTEXqEGU8N9+ioK9OW686v/oQfncX4djK3eCcZ7KlOxsGVc4uajs
RDyUtik/ZxYYbDl106s0tRLs6tExCI90W9RMUBL67UCFyr/ULvU0XUslpv39CmKM
i50hmMwT6/ZwQKWNH3PfHI2osG/zAKQwyvU+spVx54YB5UzSArjIY26+OGGChKBE
WQFmSiSa0X/jbSjDQglJeDUpsiFwvnvbkVUeIr49a4oLR+qvQjbL9fnHEU6GlTeK
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Od++lltqu8DXT2EYW14PURWxa3szoP9dmI34BnRIH5UBaoThWU5neIELXzsJIWZ+
WS1bMiQgNoQ9vDdpcFZRqADPypIJBSe/jIl8MgbPmiQxG4PCVG073XLvXfNTVapW
RCIfOGig+kHg7NKypq1GbX5QDs0VAXMAEK2VHFjIL1E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9265      )
udge1Bmh6qAcjJO7suSw3wV+aYsVaJr9ZQPUzvs2hZDF8jcCeD2uc9cs5L+Cw8C7
BRigfJ4GWGe4Ju5mUwkP/FywYVCkRA2g7p3kqaX1JzOt+nQCni+jy7U5mq/9I6ur
`pragma protect end_protected
