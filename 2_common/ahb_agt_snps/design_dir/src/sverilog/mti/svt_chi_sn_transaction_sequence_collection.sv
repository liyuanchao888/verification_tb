//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_SN_BASE CHI SN transaction response base sequence
 * Base sequence for all CHI SN transaction response sequences
 */
/** 
 * @grouphdr sequences CHI_SN_NULL CHI SN transaction null sequence
 * Null sequence for SN transaction
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_SN_MEM CHI SN transaction memory response sequences
 * CHI SN transaction memory response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_SN_BASE
 * svt_chi_sn_transaction_base_sequence: This is the base class for svt_chi_sn_transaction
 * sequences. All other svt_chi_sn_transaction sequences are extended from this sequence.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_sn_transaction_base_sequence extends svt_sequence#(svt_chi_sn_transaction);

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_sn_transaction_sequencer) 

  /**
   * SN Agent virtual sequencer
   */
  svt_chi_sn_virtual_sequencer sn_virt_seqr;

  /**
   * CHI shared status object for this agent
   */
  svt_chi_status shared_status;

  /**
   * SN agent Memory
   */
  svt_chi_memory chi_sn_mem;
  
  /** 
   * Constructs a new svt_chi_sn_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_sn_transaction_base_sequence");

  /**
   * Obtains the virtual sequencer from the configuration database and sets up
   * the shared resources obtained from it.
   */
  extern function void get_sn_virt_seqr();

  /** Used to sink the responses from the response queue */
  extern virtual task sink_responses();
  
  /**
   * Listen to the sequencer's analysis port for completed transaction
   */
  extern virtual task pre_start();

  /** Empty body method */
  virtual task body();
  endtask

  /**
   * Wait for a response request
   */
  extern task wait_for_response_request(output svt_chi_sn_transaction req);

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_chi_sn_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_chi_sn_transaction xact);
  
  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_transaction observed);
    
  endfunction

endclass // svt_chi_sn_transaction_base_sequence

/**
 * @groupname CHI_SN_MEM
 * Class svt_chi_sn_transaction_memory_sequence defines a reactive sequence that
 * a testbench may use to make use of CHI memory within the CHI SN agent. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_sn_transaction from the SN sequencer. It then:
 * - updates the response fields
 * - In case of WriteNoSnp*, updates the SN memory with data in the transaction
 * - IN case of ReadNoSnp, updates the data in the transaction with the data in SN memory
 * .
 * The updated transaction is provided to the SN protocol layer driver
 * within the SN agent. 
 * IN case of WriteNoSnp*, the data is updated into the memory only when the transaction
 * is complete successfully without any errors.
 */
// =============================================================================
class svt_chi_sn_transaction_memory_sequence extends svt_chi_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /* Port configuration obtained from the sequencer */
  svt_chi_node_configuration cfg;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_memory_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_memory_sequence");
  
  /** 
   * Executes the svt_chi_sn_transaction_memory_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_sn_transaction_memory_sequence

// =============================================================================
/**@cond PRIVATE */
/**
 * Class chi_sn_ram_response_sequence defines a reactive sequence that
 * a testbench may use to make a CHI SN agent behave like a RAM.
 * 
 * The sequence receives a response request of type
 * svt_chi_sn_transaction from the SN sequencer. It then
 * updates the response fields and provides it to the SN protocol layer driver
 * within the SN agent. 
 */

class chi_sn_ram_response_sequence extends svt_chi_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /* Port configuration obtained from the sequencer */
  svt_chi_node_configuration cfg;

  /** UVM Object Utility macro */
  `uvm_object_utils(chi_sn_ram_response_sequence)
  
  /** Class Constructor */
  function new(string name="chi_sn_ram_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    svt_configuration get_cfg;
    
    `uvm_info("body", "Entered ...", UVM_HIGH)

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_port_configuration class");
    end

    /** 
     * This method is defined in the svt_chi_sn_transaction_base_sequence.
     * It obtains the virtual sequencer sn_virt_seqr of type svt_chi_sn_virtual_sequencer 
     * from the configuration database and sets up the shared resources obtained from it: the response_request_port, shared_status, chi_sn_mem.
     * 
     **/ 
    get_sn_virt_seqr();

    /** This method is defined in the svt_chi_sn_transaction_base_sequence.
     * Used to sink the responses from the response queue.
     **/
    sink_responses();

    forever begin
      /**
       * Get the response request from the SN sequencer. The response request is
       * provided to the SN sequencer by the SN protocol layer monitor, through
       * TLM port.
       */
      wait_for_response_request(req_resp);
      `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

      /**
       * Set the SN response type.
       * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
       * o This makes the SN to transmit CompData message(s).
       * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
       * o This makes the SN to transmit CompDBIDResp message.
       */
      if (
          req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
          `ifdef SVT_CHI_ISSUE_C_ENABLE
            || req_resp.xact_type == svt_chi_sn_transaction::READNOSNPSEP
          `endif
         ) begin
        int unsigned size = 1 << req_resp.data_size;
        int unsigned align = req_resp.addr[5:0];
        req_resp.data = chi_sn_mem.read({req_resp.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00});
        `svt_xvm_debug("body", $sformatf("Read line at 0x%h: %h",
                                         {req_resp.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, req_resp.data));
        req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      end
      else if ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
               (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)) begin
        // Can only respond with "go ahead".
        // The write data will be provided by the monitor once the full transaction
        // has completed.
        req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;
      end

      `svt_xvm_debug("body", {"Response: ", req_resp.sprint()});

      $cast(req,req_resp);

      /**
       * send to driver
       */
      `uvm_info("body", $sformatf("Sending %0s response to transaction %0s", req_resp.xact_rsp_msg_type.name(), `SVT_CHI_PRINT_PREFIX(req_resp)), UVM_MEDIUM);
      `uvm_send(req)

    end

    `uvm_info("body", "Exiting...", UVM_HIGH)
  endtask: body

  // Process WRITE data
  virtual function void write(svt_chi_transaction observed);
    if ((observed.xact_type == svt_chi_transaction::WRITENOSNPFULL) ||
        (observed.xact_type == svt_chi_transaction::WRITENOSNPPTL)) begin
      // Memory is 64-byte per address
      int unsigned size = 1 << observed.data_size;
      int unsigned align = observed.addr[5:0];
      void'(chi_sn_mem.write({observed.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, observed.data, observed.byte_enable));
      `svt_xvm_debug("body", $sformatf("Wrote line at 0x%h with %h (mask:%h)",
                                       {observed.addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6], 6'h00}, observed.data,
                                       observed.byte_enable));
    end
  endfunction

endclass: chi_sn_ram_response_sequence


// =============================================================================
/** 
 * svt_chi_sn_transaction_random_sequence
 *
 * This sequence creates a random svt_chi_sn_transaction request.
 */
class svt_chi_sn_transaction_random_sequence extends svt_chi_sn_transaction_base_sequence; 
  
  /*  Response request from the SN sequencer */
  svt_chi_sn_transaction req_resp;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_random_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_random_sequence");
  
  /** 
   * Executes the svt_chi_sn_transaction_random_sequence sequence. 
   */
  extern virtual task body();

endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RFzgFKrSCsanPxVrK5xY+z0sr4v4ktIzSrFsWg9e3HaliJH1m4cLYRjUfkjE8shO
BNfiWpbo2La9vKlWDLaGNhok+32Qge9ntIBfPoMGZzDyscFZB6q9r5sku5OQEyNn
VQPWXFsJyXMUhptUClYYGuyclrqo1fF9f7+UOKw12zI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 303       )
iWln49mTUVhQ7pwJ+Rjf4jJYihW4WSk3q2Ap9LoY1nNPbxtuS8ddmrfAZXoqyGjB
B1XueEIHsnU6EHfDUwJdUq5V2Gfa665QdCFG5kc8o/xc0wG4NELnZbRpzkOuaWCi
96lUn+ODppGgzlwxQKkbbLHJRtzl5pEt8tFUeGeKSi3oGQPEyIorKYiyxYNFw59P
6GqgLx9qdTqE01bO82PwUHHzOAk84te8wUHbj5oh4a5Ac+Hp0Sk3c9pC5UXou+g2
PKkkB0HAN53X6BIdA+UV9IqgLJfqMOitYR/4wyhVEcMdXCeFBDphQ2ChtC05qGya
tGkZP2bS//L5nR0OmLqxsOaXetFTHy3BDCXnbXcoSEdg8wdBrN25yLl0WlEjPvkq
2Pagd4v+CUdmV0hQytgR2A==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Tp4cnIsvaLDIYiTiREg91pIPp/89f1wV5YVAz4fkJY/+JxNG7BBPt4jar2IirR1P
7Q9dXeJr5JhpibFIK74SRzC8dhHsQRRUoNXgFAHpxHYjCKVpK0DILRGHQzc+bBql
NnVgc1JDmTUk/9RthZr4weOaLeblSlXzuqJrj9PwDtA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3718      )
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
3PfAbPZxVXOXkQTeYvz4YQ==
`pragma protect end_protected 

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_memory_sequence::new(string name="svt_chi_sn_transaction_memory_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_memory_sequence::body();
  svt_configuration get_cfg;
  bit rand_resp_gen;
  `svt_xvm_debug("body", "Entered ...");

    p_sequencer.get_cfg(get_cfg);
    if (!$cast(cfg, get_cfg)) begin
      `uvm_fatal("body", "Unable to $cast the configuration to a svt_chi_port_configuration class");
    end

  /** 
   * This method is defined in the svt_chi_sn_transaction_base_sequence.
   * It obtains the virtual sequencer sn_virt_seqr of type svt_chi_sn_virtual_sequencer 
   * from the configuration database and sets up the shared resources obtained from it: the response_request_port, shared_status, chi_sn_mem.
   * 
   **/ 
  get_sn_virt_seqr();

  /** This method is defined in the svt_chi_sn_transaction_base_sequence.
   * Used to sink the responses from the response queue.
   **/
  sink_responses();  

  forever begin

    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);

    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Received response request"});
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (
        req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
        `ifdef SVT_CHI_ISSUE_C_ENABLE
          || req_resp.xact_type == svt_chi_sn_transaction::READNOSNPSEP
        `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      `ifdef SVT_CHI_ISSUE_B_ENABLE
        rand_resp_gen = $urandom_range(1,0);
        if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.data_source_enable == 1) begin
          req_resp.data_source = rand_resp_gen ? svt_chi_transaction::PREFETCHTGT_WAS_USEFUL:svt_chi_transaction::PREFETCHTGT_WAS_NOT_USEFUL;
        end
      `endif

      get_read_data_from_mem_to_transaction(req_resp);
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        req_resp.data_cbusy = new[req_resp.compute_num_dat_flits()];      
        foreach(req_resp.data_cbusy[i])
           req_resp.data_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
        if(req_resp.order_type != svt_chi_sn_transaction::NO_ORDERING_REQUIRED)begin
          req_resp.response_cbusy = new[1] (req_resp.response_cbusy);
          req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
        end
      `endif
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;      
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending RSP_MSG_COMPDATA with data 'h%0h, wysiwyg_data 'h%0h", req_resp.data,req_resp.wysiwyg_data)});


    end
    else if ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             `ifdef SVT_CHI_ISSUE_E_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) || 
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)) begin

      /* -----\/----- EXCLUDED -----\/-----
      if ($test$plusargs("gen_slv_data_err")) begin
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});             
         req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;
        req_resp.response_resp_err_status = svt_chi_transaction::DATA_ERROR;
        req_resp.suspend_response = 1;
      end
      else if ($test$plusargs("gen_slv_non_data_err")) begin 
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});     
        req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;       
        req_resp.response_resp_err_status = svt_chi_transaction::NON_DATA_ERROR;     
        req_resp.suspend_response = 1;   
      end
      else 
       -----/\----- EXCLUDED -----/\----- */
      begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.do_dwt)begin
          `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_DBIDRESP "});     
          req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_DBIDRESP;
          req_resp.response_cbusy = new[2];      
          req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
          req_resp.response_cbusy[1] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
        end else
        `endif
        begin
          `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Writing with the response RSP_MSG_COMPDBIDRESP "});     
          req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;
          `ifdef SVT_CHI_ISSUE_D_ENABLE
            req_resp.response_cbusy = new[1];      
            req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
          `endif
        end
      end
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    else if(req_resp.xact_type == svt_chi_transaction::CLEANINVALID || req_resp.xact_type == svt_chi_transaction::CLEANSHARED 
            || req_resp.xact_type == svt_chi_transaction::MAKEINVALID || req_resp.xact_type == svt_chi_transaction::CLEANSHAREDPERSIST)begin
      req_resp.xact_rsp_msg_type =  svt_chi_sn_transaction::RSP_MSG_COMP;
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        req_resp.response_cbusy = new[1];      
        req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);      
      `endif //issue_d_enable
    end
    `endif//issue_b_enable
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    else if(req_resp.xact_type == svt_chi_transaction::CLEANSHAREDPERSISTSEP)begin
      case($urandom_range(2,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPPERSIST;
            if(req_resp.src_id == req_resp.return_nid) begin
              req_resp.response_cbusy = new[1];
              req_resp.response_cbusy[0] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
            end
            else begin
              req_resp.response_cbusy = new[2];
              foreach(req_resp.response_cbusy[i])
                req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
            end
          end
        1: begin
           req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP_PERSIST;
            req_resp.response_cbusy = new[2];
            foreach(req_resp.response_cbusy[i])
              req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
          end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_PERSIST_COMP;
           req_resp.response_cbusy = new[2];
           foreach(req_resp.response_cbusy[i])
             req_resp.response_cbusy[i] = $urandom_range(`SVT_CHI_MAX_CBUSY_VALUE,0);
         end
        default: `svt_error ("body", "Error occurred while Randomizing response. Value of $urandom_range is greater than 2");
      endcase
    end
    `endif //issue_d_enable

    /* -----\/----- EXCLUDED -----\/-----
    fork
      begin
        if ((req_resp.suspend_response == 1) &&
    (
     ($test$plusargs("gen_slv_non_data_err")) ||
     ($test$plusargs("gen_slv_data_err"))
    )
           ) begin
          wait (req_resp.data_status == svt_chi_transaction::ACCEPT);
          req_resp.suspend_response = 0;
        end
      end
    join_none
     -----/\----- EXCLUDED -----/\----- */
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});

    $cast(req,req_resp);


    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_send(req)

  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_random_sequence::new(string name="svt_chi_sn_transaction_random_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_random_sequence::body();
  /**
   * Remove responses from the response queue
   */
  sink_responses();

  forever begin
    /**
     * Get the response request from the SN sequencer. The response request is
     * provided to the SN sequencer by the SN protocol layer monitor, through
     * TLM port.
     */
    wait_for_response_request(req_resp);
    `svt_xvm_verbose("body", {"Received response request: ", req_resp.sprint()});

    `svt_xvm_rand_send(req_resp)
  end
endtask
// =============================================================================
/** 
 * @groupname CHI_SN_NULL
 * svt_chi_sn_transaction_null_sequence
 *
 * This class creates a null sequence which can be associated with a sequencer but generates no traffic.
 */
class svt_chi_sn_transaction_null_sequence extends svt_chi_sn_transaction_base_sequence;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_sn_transaction_null_sequence) 
  
  /**
   * Constructs the svt_chi_sn_transaction_null_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_sn_transaction_null_sequence");

  /** 
   * Executes svt_chi_sn_transaction_null_sequence sequence. 
   */
  extern virtual task body();

endclass

// =============================================================================

//------------------------------------------------------------------------------
function svt_chi_sn_transaction_null_sequence::new(string name = "svt_chi_sn_transaction_null_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_sn_transaction_null_sequence:: body();
endtask

// =============================================================================

`endif // GUARD_SVT_CHI_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Rtfc0o5+fWSwr0IQ6C8UZqRIt2rf3eZ6/kTVIrLJCKGze9U9g5QsF2mvj5S/9epe
/kPW7pMbi5Iw7CFDXfAO7HJ6kYMO3WCFVpF75wq9sRb8EWRt57+XAg1RY5W3vZXG
VYDLXynp0D7f7ESdueuwXcjGkyguvOjWjgOBjggJiJk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3801      )
uKti2Js2yPZLb712zMjx7QHlbRYW0/ym99H0qa+sWjyCdonBAVDDvCasYmmdfnRr
iijyOhomkFSyiYRMUiT6JHyvtE6H3ZGgdMtVHRb/vq0rjzmANWdeoOmRM2Gnl4wx
`pragma protect end_protected
