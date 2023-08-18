
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tHPUJcaVWhWNkehQ5wfOUtZlrZcDd/ZAgMNMd1tSMxBhJRJhxb4opNpPx++XvMkC
1r27ArDi5uMG9iamtBNFdZCsGwK0qhBtQknRtJAVZ6ToLgm9FUYpL4JsbXhGta+O
Czd5QI/aUet8Exo9oyVc8u6uK5m+eLPfUFDoQ1dzicC3o7eatYDK5A==
//pragma protect end_key_block
//pragma protect digest_block
+QAYqpRbnReMDLDyuXGmbJL99pg=
//pragma protect end_digest_block
//pragma protect data_block
xe7O1DR7qnDeB/AOpk93xt4tWKGWm/H9HhYNJ1lKrUc6cvX0LMRH4rRV7ER/tVrw
iKr7f2RG5UmvQkN3qI7xS9B28M/Qjk/shkOVBGFMDESjz/o7de6UMzKC8qyFc0Wu
ACjFVV7N0FerTKAEJQWIaLbl0MlPmpU/b6XxzJEPBIkP+Y2ID80a64d2136IUP2N
wxJaKdKioEnL+7U8WbmIRhHdvW+coqYrMYOZCzfmmw01X83bCSF5Sc28D34MSPfx
HLDr+2I8Fe4HrDWKD6/jezlgAQr8F/ZTlp6WBz10jQ9plF16us9hRvTJiaQAE/TQ
z6Jbwn1mtIxqvSfUDtrgk5gXazT1dXz8TKAL9vJ2kL6OBgezhcNBhhOb6pk347OA
MaBOZ9HhyH+v5sQxiYkCZ3SLgQKdbSsLITuXijcvdOKEpf3NsmOgzI8iTjgQTqNe
s6Y61/n/6XQqGodwW0tPgi/aR0WZabgE8sk/umxwXfto58AYcTJoIz9ZyekAKN12
cHWH79LvAMQExL2dxXq+1PQKrLit7UKvuq24fnIMUZfCPuAWQuFFx4eGkFBrw2uu
yQzhZ+vYLrv6wUGt4rsNfNOvILzhxpE/jb/lFIgm5NMvJnnM/kSeitoUE8EIujU2
iw9LKfS4v/nUTovltpemaiYVnpfgb8XytE8OZRVrSawsgcZLqVplN4rlvVEGku5F
43IivB0XNWcO8bvtLE8T9WyaiKeQtyJhK0p4MhWLACX+xPja17JdK4vDGHABZmEK
WP9qfSJG455eGKbuou5AkeTSFYVef6bOFoix8y3WMb14bVi/40mQyYsKlwbZJkZM
kmD2uLAh0ZjhIZ4RVHcQZmHLzpctmuWXn/70RVNbZnxDOoCsKsLmk246XRj0erIO
EnCL7Bx3gyAZnymVfZbZ/TFg0N3/hnMiKjWp7G+jY+FJ4gWQA+cOG4g6D0FJO7xx
OprXxaTPQfNgQ4tvhhll/JLDC/UXNvCTJs3nbE3R79t8PDM2pgIkZUrFNioU8fOS
dvkDJA6o6RcDMgqlDrkw66A9YUP7m+pDQFeH1JGWzRqZp21cFpzXUK3VIygPvwvf
MA/EEBdIlIkmc0TOU9WPLgOLjW2DJYHuN25Boujrd5Gt3q1AfODkgG8p13GHWAHT
1DMDVu+LfLeycZBzsmCiEc+s7J2w+8IhHrvcd/wE9QiknhiZfXl+0/vK0l+HGVFU
b0/6HQ1TARybezCMr/U0Wmz33zP6RffgK1GwKdYQNvvTMn+UwbpoL/NMXpRiiqxY
ywYIXNLeYlKj4QP0HiJ6XVUAmabwFMySKQLYkY5d7Z6xLz+/mdD+xj0wbeATgfjW
7+j2YmgaIEbAW3/GfOapNg5+PDDgMQCY0E0Msh/TZwSfuiB4nLKaLAcHpGJWtW+w
ymMGGRbtLr8uMiYXgI2Nu6Oh4sX40XOWzm6YBTQvazUclKYlgpbXl6oWF0Bx418X
RNl03i+4CwK9A4bjqNzpjOjfFDtMMLDc24h1NMXmkFBcu88e/s/NY4xT9YQQbxm2
k9fsgdDwjFRwAxWOR9L0Qzxb8BIEJSveTrmYAdn8mamHpV6beTqeqW1Z/BD0HOJe
mNRizsG9hNLG/7Yt7t7MZ2L3fp7Y9Jn11mhDgwfIs3qno8CeUe7WKikiEYT70hdk
D7ZBlMggSXCiashRaF88KczhCWMptNNB+nxkemyv9Nz+H4pXBmYm5YwFL9PvyOyL
/+DnveNcbnWB33PB/ZZPd20WchkbyMQwmmaX+6RrFwd/7+V8F9L2PqvwGKjqvq5y
S4Yadpe6/h3OQ4RF3I8xclJ2U2g37yDlecQdyP1C7cuPUT1ZbsxEHpbNOwcYMzws
1QTDKw+MwZxvHiM/ioTDI48AmIh7I7p8SOHub2n85RofDax2t/LhcPu7v6AVmUS9
prVqFC4R3CPKeZ1inmiMvyP+RdkK+zCYecdDE1Fqo0FXtt0KQDMVGpbfPoKCcTT5
1f3Y+5PLzW2uu4eO+EfrgR6KJnA6CRopxDP/12KFG8m/9ICwAV8IYcH0IaBwvB9f
LZsDmKydv1QEONC/Qj04PmM2Ds61sLrz4R7LTNI9sm6JU31YGRuljGDYaUizd4tE
WD1282MokUNm+TUnxk4jqBxTicm3+amB2IE2kaqF68WvWbw38SZO8ax5v44l4U8N
3u+/yb1Qu+RfonxawH6OL9oIGbjXGP8cCUm27BNttDaKh+E+Gk+e7wWjkTa1cmqD
dY68PyzNLW4LOPM2kpdy1GiQsSpClbBuwIU8j7fHypJul20/M0Ma+oN98crx5+/a
gHjtJIbiNECKM51ZdCUibLRLlpmB+PPIkmSZweJNccs+yBIjVvNADAaZE3fhOCdY
kcJ7PgGkjlnSOpLmAgZpQxrL0JOoW5DK7lMYkKVHqXQFVzgWykm66sPXv/Ochf9c
bQxhovYsUpRP7QVcZ4Vs71s0I+QxNjaaw387OP1RLqH7ANBkZ9oTcOQuH17gwKpc
7ewUjmlgR75t0ZzhRlVtQfhe5Y8RUboO7hXxZRXLE0+yKuzbTBzhNh0rnH6ZPw3n
1xOqiEb2CGgNxl1cLoinE/BaSiP+sX4HUffy9qIgqkfFR6TuRMSxTOAIgpbIctxj
WaTHDzc4XjqP0JMA8QA4ZxelNWAZLj/MdY0KRInInmUElB80Qe1SYCzOFLdfz5a/
0K1ae2Aw9hT9vArW+OdM/PAt0s8EG3LiipARg8ioDZ3tWU0ECnmGwSnxJggzcZ0C
zGK/juYQM7blfyyJ8PI3qrLIsWTMeHydbLN/Jc1vG7ksg+KrC49FT6e+CahtBdXk
bg3L1q8eswMlgjHfeXfsWPAm/huLeMG9nCnGZTAZO4J1myREfM8Ljp4Em5qW6ixS
NcU4TXomxoUmMrTrTDzQ4BOE5PXDE3yXyzDeFPFbvPIhE/yGPby+YC/fYnmZnMZq

//pragma protect end_data_block
//pragma protect digest_block
fGGA4L/t5RaaA7KaveuiJ7gP32s=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7tX7OpiYgCU/AjQzor8SM9FkV2E37KuewGtXhBmxtLkoXDCsN5QXvIcuwGSUvVL4
PFyjMvmj8sAFQRRByxS1A/6OdtpPqi9L1BXAIp/GWPJbw1Ms+40DtonnNN39VOk+
ihJvqKZG35uiO1vAJpWjDqq3avO3pYPB2WQvimp7TXh3wuupl9y5zA==
//pragma protect end_key_block
//pragma protect digest_block
MeQ80jb2o+DbTISCVfltgyqWpeg=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
IS6bquSJ2wP4/sJGRmbEy28eim8=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kUWmo8C3EQD/VuZOC34RCEpFImu6Mlvb1RxXeY1r1uWnZ9g0VR7d9buvii2MIhPl
HiR/aekkjmtlFogSXPE5V5Kl8RT05AQ1drHq/fvfcTpticFD42Rnydc59sx6FAsh
eWsqbxOcwpxaXxyKqsqTT/88wLt4atvW7zi8ASu8AWB4+6/DbdMtvA==
//pragma protect end_key_block
//pragma protect digest_block
RaSdr6fIyYZ/YO2lnPiBsxzyF0k=
//pragma protect end_digest_block
//pragma protect data_block
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
iAHovQauu+Rgxc+VKxv6QA==
//pragma protect end_data_block
//pragma protect digest_block
uYqx859MDhIEJ0UrVweN+0YGjTA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_TRANSACTION_SEQUENCE_COLLECTION_SV
