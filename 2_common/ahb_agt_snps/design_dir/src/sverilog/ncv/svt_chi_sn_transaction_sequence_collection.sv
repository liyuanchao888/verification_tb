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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kGz3PIw42a2qkkCcU8YDqjYL3Kj6dMzQOu57iDFP69YjqxgDu7itX/txkEfOT0Hm
JZSaufkiY9pUhm0O8F9wEUl7cFCXpHG35yu4iVj8v1Adn9amgU3D5c8eNygoJZDm
gIr+fJzGbMwKkVBb8ltThwpxYDSwSt/vAffDREbWmuXmEfbneyu1FQ==
//pragma protect end_key_block
//pragma protect digest_block
d8QWke/X2+1WpzwJ55+dv0UOAJI=
//pragma protect end_digest_block
//pragma protect data_block
w0z8XfA6mb5iin+JUaJ4spyxSFKCQ3e9N/e/KdPb1Y/fZgQeNeJwqNJMhpxzevOQ
6+/qefplOWF5aEsMnpVck01Z5qVc41+oxKpGjPrEu07gr2aOUplV8n9QAhHmm2iD
9qosxdpcI0Bnvmgbk5ENK4YWI/MozNZxxZ97jODIL16MEcCj1UUt8vGtIFdMikI8
SiY2V2xctJ20D7enE2jUn4bCyM6bJ8VxzeR9rU4aaHuDONpVre28H7v6oGREWq8d
nHPStXIr14Ig8e0m6lZURcWxRd6uNs82oEAAm/RzeJ9H3aIan3AgD9Sf0KBpe21F
/MD1uvgE2Q/ozwJFC+SR+N67yCcxgWOpuDPbASqJhIpJ6NVg0BQ/2If3PyOwM65F
2faqxJWlZ6qJnXm8sFxqOV4E3wJEss3x7RNujet2xdQN9qbkRg7h+l7h5Z39kd8P
/q2d4b4KerVmr/n6I5ppeQVo7vRyZQQo8E/V4CT5t1BWB8ohQX1/3vh/gOzV0cCg
bOG7OtFP3+iJaXag8/ZF8esFvEBw0zUWjGECS9V58O9oTEOZdr6SbKcLOpjjGBWE
fEjFAz2t7gITBOnEyL+9A34Dg/yZCs8Q4A5c7p5C2Sspx58pmgEpRg/OVWAY4Ozq

//pragma protect end_data_block
//pragma protect digest_block
lsU62gsNgwdtnPLG/zFu1ponGl8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2C4WC9CYutkKuvJcWZBMAcoCkW5hkN7Y12GlR7um9GBA9Vd9n3lE0/8Zw3OEPoVv
R/nZJChoOmmPspWYzGYr8VZawiKS0BgZKgAMqGOUweU+/m3exnOIjuhez36ZJH2L
zPyfJ3I6CCfVrYtl0b6EkXL4Cn3SKUpZ9pw8dRuohAByaLcagkQjaQ==
//pragma protect end_key_block
//pragma protect digest_block
oX2Tr6K6+K4PMKA7jb6lb74kUx8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
UkqK3eiND3pkfXaZ4eHSILVhyxM=
//pragma protect end_digest_block
//pragma protect end_protected

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
