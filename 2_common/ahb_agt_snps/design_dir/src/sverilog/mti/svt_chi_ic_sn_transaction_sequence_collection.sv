//--------------------------------------------------------------------------
// COPYRIGHT (C) 2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`define GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV

//============================================================================================================
// Sequence grouping definitions-- starts here
//============================================================================================================
//-------------------------------------------------------------------------------------------------------------
// Base sequences
//-------------------------------------------------------------------------------------------------------------
/** 
 * @grouphdr sequences CHI_IC_SN_BASE CHI IC SN transaction response base sequence
 * Base sequence for all CHI IC SN transaction response sequences
 */
//-------------------------------------------------------------------------------------------------------------
// Derived sequences  
//-------------------------------------------------------------------------------------------

/**
 * @grouphdr sequences CHI_IC_SN_MEM CHI IC SN transaction memory response sequences
 * CHI IC SN transaction memory response sequences
 */

//============================================================================================================
// Sequence grouping definitions-- ends here
//============================================================================================================ 
// =============================================================================
// =============================================================================

/** 
 * @groupname CHI_IC_SN_BASE
 * svt_chi_ic_sn_transaction_base_sequence: This is the base class for svt_chi_ic_sn_transaction
 * sequences. All other svt_chi_ic_sn_transaction sequences are extended from this sequence.
 * svt_chi_ic_sn_transaction sequences will be used by CHI ICN VIP component.
 * CHI IC SN XACT sequencer and the Interconnect driver will be using it.
 *
 * The base sequence takes care of managing objections if extended classes or sequence clients
 * set the #manage_objection bit to 1.
 */
class svt_chi_ic_sn_transaction_base_sequence extends svt_sequence#(svt_chi_ic_sn_transaction);

  /** @cond PRIVATE */
  /**
   *  Control to enable/disable mimicking ideal slave mode
   */
  bit ideal_slave_mode = 1'b0;

  /**
   *  Control to enable/diable retry responses
   */
  bit enable_retry = 1'b0;

  /**
   *  Control to enable/diable outstanding retry responses
   */
  bit enable_outstanding_retry = 1'b0;

  /**
   * Controls the is_retry distribution weight
   */
  int is_retry_zero_val_weight = 1;
  
  /** 
   * Control to enable/disable random response generation
   */
  bit send_random_response = 1'b1;
  /** @endcond */
  
  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_transaction_base_sequence) 
 
  /** 
   * Parent Sequencer Declaration. 
   */
  `svt_xvm_declare_p_sequencer(svt_chi_ic_sn_transaction_sequencer) 

  /** 
   * Constructs a new svt_chi_ic_sn_transaction_base_sequence instance.
   * 
   * @param name Sequence instance name.
   */
  extern function new(string name="svt_chi_ic_sn_transaction_base_sequence");

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
  extern task wait_for_response_request(output svt_chi_ic_sn_transaction req);

  /**
   * Stop listening to the sequencer's analysis port for completed transaction
   */
  extern virtual task post_start();

  extern virtual function void do_kill();

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_chi_ic_sn_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_chi_ic_sn_transaction xact);

`ifdef SVT_CHI_ISSUE_D_ENABLE
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Har1XMP8ElCQIkomB0qHagINVnLXL5LPcVw1pS2BqKpRqzIj2S0ykvKj7sOb6ARx
toe4+Hj3bd1o8viF85s5RkL4hXUixa6yldlUugu1FADgjCvkWdiKAyja/vDb+gEP
cMNuIdHrIr3S3uCc9YIrC8O4btE1kgPijEqDwE+35c8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 346       )
VAhIBgEIcOd0Ro9b/Gp0farxhsHsAOdeI/FYzoW5xdVGXDoAH6TUfgxXgy8E24P5
k/quSNpYGY4t76X3OfNeUXPkJHtc8cHrTNvIKOdZ3nf2O8YYVgPF9axfXbyueKqj
RN3BvXx8BG+/xLqjFzD8FkYtaff6984wll8nKVUkAky4ZDep59AUX23hiPFF4kje
TY44Q3blG+/nJA+9zM/lMl0y1bNtULtdpI7oNUrxOzonNemR4jWBmV4iWUX2o6mM
a532AadKx1wlCi1SDi9dOVyS8eHzDbK9QmXhmOkV/vkbZPaufYAP81Kx1w/+EAlp
psUwbXxEmi+tI4iKtJldTDLLaLV32V9OvAA74Sn5jYDnygMqXQPxyEdYatT0R2oO
4uSgqmW4yVu0E0z9natp42ZeCdCS3QjHeMdNKptoJ1aUSuA08rIIpbS2gTNtOfuC
W8xdiSf2VVxP2vNa+JxCkA==
`pragma protect end_protected
`endif

  /** (Empty) write() method called by the sequencer's analysis port to report completed transactions */
  virtual function void write(svt_chi_transaction observed);
    
  endfunction

endclass // svt_chi_ic_sn_transaction_base_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_transaction_memory_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_transaction_memory_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_transaction_memory_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_transaction_memory_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_transaction_memory_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_sn_transaction_memory_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_suspend_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_suspend_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_suspend_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_suspend_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_suspend_response_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_suspend_response_resume_after_delay_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_suspend_response_resume_after_delay_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_suspend_response_resume_after_delay_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_suspend_response_resume_after_delay_sequence

// =============================================================================
class svt_chi_ic_sn_read_data_interleave_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_read_data_interleave_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_read_data_interleave_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_read_data_interleave_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_read_data_interleave_response_sequence

/**
 * @groupname CHI_IC_SN_MEM
 * Class svt_chi_ic_sn_suspend_response_resume_after_delay_sequence defines a reactive sequence that
 * will be used by the CHI ICN VIP Driver and IC SN XACT sequencer. <br>
 * 
 * The sequence receives a response request of type
 * svt_chi_ic_sn_transaction from the IC SN xact sequencer. It suspends 
 * the response of the very first request recieved and resumes it back by
 * resetting suspend_response field after certain number of clock cycle delays.
 * .
 * The updated transaction is provided to the CHI Interconnect driver
 * within the CHI Interconnect env. 
 */
// =============================================================================
class svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence extends svt_chi_ic_sn_suspend_response_sequence;

  /*  Total number of DVM transaction recieved */
  static int total_dvm_txns_recieved = 0;

  /**
    * Output transactions generated by the sequence
    */
  svt_chi_ic_sn_transaction dvm_reqs_received[$];


  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence sequence. 
   */
  extern virtual task body();

endclass // svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence

// =============================================================================
class svt_chi_ic_sn_reordering_response_sequence extends svt_chi_ic_sn_transaction_base_sequence;
  /*  Response request from the SN sequencer */
  svt_chi_ic_sn_transaction req_resp;

  /** Flag to resume response for first transaction */
  bit resume_response_for_first_xact = 0;

  /** 
   * Factory Registration. 
   */
  `svt_xvm_object_utils(svt_chi_ic_sn_reordering_response_sequence) 
  
  /**
   * Constructs the svt_chi_ic_sn_transaction_random_sequence sequence
   * @param name Sequence instance name.
   */
  extern function new(string name = "svt_chi_ic_sn_reordering_response_sequence");
  
  /** 
   * Executes the svt_chi_ic_sn_reordering_response_sequence sequence. 
   */
  extern virtual task body();

  /** Method to resume response for first transaction */
  extern task resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);

endclass // svt_chi_ic_sn_reordering_response_sequence
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ljsqrJrQREWmDjaKMSRhkkJkvID7+KyA/Q+j2iuQuaURMKcOuZJ37emyEfI6YsK4
FBq5qkeemh5BKcCRvYuysOeJn8l6BkOanqHh/WRRAGVUI6L23vyRpJek6g6e/QsI
6t5tN2hlu7mMJsH8pe6lsVqrDu5dWiZIXTgqN2RYDkE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 655       )
M9LQDzEw2wkfwx8GFSFL/f6HQut1Cp02pCrpXCYpF/KHYVIZ4br4cNVYJawk0b1m
ly+xCUgWw8kKOBuj0vKJTHlyKwqtJv9IArANe/vImVC8KQ3ENFnV4uEMpfdrOQnN
XGVE3YeEKz9B5OsKwrODp2k+9snqi7/tyLfIUIcZefNCz8VBL3+uhn8GT2h4FiMd
Uq9v5o9RPQLpRtRYAStq9It5q0RQGGQusIO9dKKAMJPiAxU2DmP124YjKl3YID2l
KDh10S4piiR0wGBpWhCe8XYWTLrR6UbCZ7SzmaqiyK+XjhrxGszkMT9VpCHgAPvl
8O5QYfdhFAwi7ketTarcH8dTQesVfe5x1noVRViDWN7nYGBMXb5B0JiIRtlENMXu
EwV7prYhLopjj00RGN+s9MdYE2l7Wrt3jLZzTBNRVg0=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Fzoe4v8RMqMI7YHibotACsNjZ267CiIqO+smQECauDtL9mdKo+ePjZCl0Li9JAXL
O4lnzB4F+WYViU3HB59PNTQz83wGJZW6FaPXI+pffXVC6MUkgH9OhqLI5WurC+di
A/3RDhCvLReI02NPrinPUkqlc7Bt9JxC1SQ9g9+jrEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11611     )
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
Qa2DN0Yfu4lS8ieijXHZWA==
`pragma protect end_protected
//------------------------------------------------------------------------------
function svt_chi_ic_sn_transaction_memory_sequence::new(string name="svt_chi_ic_sn_transaction_memory_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_transaction_memory_sequence::body();
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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
    
    // Setting is_respsepdata_datasepresp_flow_used.
    // is_respsepdata_datasepresp_flow_used can be set to 1 only if the spec revision is set ISSUE_C or latter
    // RESPSEPDATA is not expected for Ordered Read transactions whose ExpCompAck is set to 0
    // Exclusive reads other than ReadPreferUnique and MakeReadUnique must not use separate Comp and Data response
    `ifdef SVT_CHI_ISSUE_C_ENABLE
     if (req_resp.get_xact_category() == svt_chi_sn_transaction::READ) begin
      case ($urandom_range(1,0))
        0: begin
          req_resp.is_respsepdata_datasepresp_flow_used = 0;
        end
        1: begin
          if((req_resp.is_ordered_read_xact() && req_resp.exp_comp_ack == 0) || req_resp.cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B || 
              (
               req_resp.is_exclusive == 1
              `ifdef SVT_CHI_ISSUE_E_ENABLE
               && (req_resp.xact_type != svt_chi_transaction::MAKEREADUNIQUE && req_resp.xact_type != svt_chi_transaction::READPREFERUNIQUE)
              `endif
              )
            )begin
            req_resp.is_respsepdata_datasepresp_flow_used = 0;
          end
          else begin
            req_resp.is_respsepdata_datasepresp_flow_used = 1;
          end
        end
      endcase
      //Setting respsepdata_policy, applicable only when is_respsepdata_datasepresp_flow_used is set to 1.
      if(req_resp.is_respsepdata_datasepresp_flow_used == 1)begin
        case ($urandom_range(2,0))
          0: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_BEFORE_DATASEPRESP;
          end
          1: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_DURING_DATASEPRESP;
          end
          2: begin
            req_resp.respsepdata_policy = svt_chi_sn_transaction::RESPSEPDATA_AFTER_DATASEPRESP;
          end
        endcase
      end
     end
    `endif

    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)
        
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif       
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             || (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH)
             || (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_ADD)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_CLR)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_EOR)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SET)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SMAX)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_SMIN)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_UMAX)
             || (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSTORE_UMIN)
             `endif                                       
           ) begin
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
             case ($urandom_range(4,0)) 
                0: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                  rsp_mssg_type = "COMP";
                end
                1: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                  rsp_mssg_type = "DBIDRESP";
                end
                2: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                  rsp_mssg_type = "COMPDBIDRESP";
                end
                3: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
                  rsp_mssg_type = "DBIDRESPORD";
                end
                4: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                  rsp_mssg_type = "NOT_PROGRAMMED";
                end
             endcase
           end
           else
           `endif
           begin
              case ($urandom_range(3,0)) 
                0: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                  rsp_mssg_type = "COMP";
                end
                1: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                  rsp_mssg_type = "DBIDRESP";
                end
                2: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                  rsp_mssg_type = "COMPDBIDRESP";
                end
                3: begin
                  req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                  rsp_mssg_type = "NOT_PROGRAMMED";
                end
              endcase
           end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_ADD) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_CLR) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_EOR) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SET) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SMAX) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_SMIN) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_UMAX) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICLOAD_UMIN) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICSWAP) ||
             (req_resp.xact_type == svt_chi_sn_transaction::ATOMICCOMPARE)
           ) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(4,0)) 
            0: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_WITH_COMPDATA";
            end
            1: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_BEFORE_COMPDATA";
            end
            2: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_AFTER_COMPDATA";
            end             
            3: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESPORD_BEFORE_COMPDATA";
            end
            4: begin
              req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
              rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESPORD_AFTER_COMPDATA";
            end
          endcase
      end
      else
      `endif //issue_e_enable
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_WITH_COMPDATA";
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_BEFORE_COMPDATA";
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
            rsp_mssg_type = "RSP_MSG_COMPDATA with DBIDRESP_AFTER_COMPDATA";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
   `endif                                       
   `ifdef SVT_CHI_ISSUE_E_ENABLE
    else if (req_resp.xact_type == svt_chi_sn_transaction::MAKEREADUNIQUE) begin
      case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;              
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;              
          rsp_mssg_type = "COMPDATA";
        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase  
    end        
    else if ((req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)&&(req_resp.xact_type == svt_chi_sn_transaction::WRITEEVICTOREVICT)) begin
      case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;              
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;              
          rsp_mssg_type = "COMPDBIDRESP";

        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase  
    end        


    // programming the Final state for MAKEREADUNIQUE transaction
    if(req_resp.xact_type == svt_chi_sn_transaction::MAKEREADUNIQUE) begin
      case ($urandom_range(1,0)) 
        0: begin
          req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
        end
        1: begin
          req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
        end
      endcase
    end
   `endif
       
   if(req_resp.xact_type == svt_chi_sn_transaction::READCLEAN) begin
     case ($urandom_range(1,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::READUNIQUE) begin
     case ($urandom_range(1,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::READSHARED) begin
     case ($urandom_range(3,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
       2: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SD;
       end
       3: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
       end
     endcase
   end
   
   if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHARED) begin
     case ($urandom_range(2,0)) 
       0: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
       end
       1: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
       end
       2: begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
       end
     endcase
   end
   
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     if(req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
         end
       endcase
     end
     
     `ifdef SVT_CHI_ISSUE_E_ENABLE
     /** Resp field of a Comp and CompDBIDResp response is inapplicable and must be set to zero for WRITEEVICTOREVICT */
     if (req_resp.xact_type == svt_chi_sn_transaction::WRITEEVICTOREVICT) begin
         req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
     end    
     else if(req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UD;
         end
       endcase
     end
     `endif

     
     if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHAREDPERSIST) begin
       case ($urandom_range(2,0)) 
         0: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         2: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end
       endcase
     end
   `endif

   `ifdef SVT_CHI_ISSUE_D_ENABLE
     if(req_resp.xact_type == svt_chi_sn_transaction::CLEANSHAREDPERSISTSEP) begin
       randcase
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::I;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::SC;
         end
         1: begin
           req_resp.user_comp_final_state = svt_chi_sn_transaction::UC;
         end 
       endcase
      
       randcase
        3: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPPERSIST;
        2: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP_PERSIST;
        1: req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_PERSIST_COMP;
      endcase
     end
   `endif

    // Control to generate directed retry response
    if (enable_retry) begin
      req_resp.IS_RETRY_wt = is_retry_zero_val_weight;
      if ((req_resp.is_dyn_p_crd == 1) &&
          (req_resp.enable_interleave == 0) &&
          (req_resp.cfg.rsp_flit_reordering_depth == 1)) begin
        bit is_retry_resp = $urandom_range(1,0);

        if(enable_outstanding_retry)
          is_retry_resp = 1;

        if (is_retry_resp) begin
          req_resp.is_p_crd_grant_before_retry_ack = $urandom_range(1,0);

          if(enable_outstanding_retry) begin
            send_random_response = 0;
            req_resp.is_p_crd_grant_before_retry_ack = 0;
            req_resp.req_to_retryack_flit_delay = 0;
            req_resp.req_to_pcreditgrant_flit_delay = 0;
            req_resp.retryack_to_pcreditgrant_flit_delay = 10000;
          end

          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_RETRYACK;
          rsp_mssg_type = "RETRYACK";
`ifdef SVT_CHI_ISSUE_B_ENABLE
          if (req_resp.cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A) begin
            req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(3,0));
          end
          else if (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) begin
            req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(15,0));
          end
`else          
          req_resp.p_crd_type = svt_chi_transaction::p_crd_type_enum'($urandom_range(3,0));
`endif          
          `svt_xvm_debug("body_retry_resp", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending with %0s response with p_crd_type %0s, is_p_crd_grant_before_retry_ack = %0b enable_outstanding_retry = %d  req_resp.req_to_retryack_flit_delay = %0d req_resp.req_to_pcreditgrant_flit_delay=%d ",rsp_mssg_type, req_resp.p_crd_type.name(), req_resp.is_p_crd_grant_before_retry_ack,enable_outstanding_retry,req_resp.req_to_retryack_flit_delay,req_resp.req_to_pcreditgrant_flit_delay)});
        end
      end // if ((req_resp.is_dyn_p_crd == 1) &&...
    end

    $cast(req,req_resp);

    /**
     * send to driver
     */
    
    if (send_random_response == 0) begin
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        create_and_set_random_values_in_cbusy_fields(req);
      `endif
      `svt_xvm_send(req);
    end
    else begin
      `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                             if (enable_retry == 0)
                             {
                                 is_retry == 0;
                             }
                            }
                           );
    end

    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_suspend_response_sequence::new(string name="svt_chi_ic_sn_suspend_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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
    if(req_resp.is_suspend_response_supported()) begin
      total_req_received++;
    end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)

        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif       
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) begin
             case ($urandom_range(4,0)) 
               0: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                 rsp_mssg_type = "COMP";
               end
               1: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                 rsp_mssg_type = "DBIDRESP";
               end
               2: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                 rsp_mssg_type = "COMPDBIDRESP";
               end
               3: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
                 rsp_mssg_type = "DBIDRESPORD";
               end
               4: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                 rsp_mssg_type = "NOT_PROGRAMMED";
               end
             endcase
           end
           else
           `endif
           begin
             case ($urandom_range(3,0)) 
               0: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
                 rsp_mssg_type = "COMP";
               end
               1: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
                 rsp_mssg_type = "DBIDRESP";
               end
               2: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
                 rsp_mssg_type = "COMPDBIDRESP";
               end
               3: begin
                 req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
                 rsp_mssg_type = "NOT_PROGRAMMED";
               end
             endcase
           end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end else if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

   if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
    if(req.is_dvm_sync() == 1) begin
       `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});          
       req.suspend_response = 1'b1;    
       resume_transaction(req);           
     end
   end
   else begin

     if (
          req_resp.is_suspend_response_supported() &&
          (
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
           `ifdef SVT_CHI_ISSUE_E_ENABLE
            (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
           `endif
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
          )
        ) begin
       if (total_req_received == 1) begin
         `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
         req.suspend_response = 1'b1;
         resume_transaction(req);
       end
     end

     if (total_req_received == 5) begin
       fork 
         begin
           virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
           repeat(10000) @(ic_rn_vif.sn_cb);
           resume_response_for_first_xact = 1;
         end
       join_none
     end    
   end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      if(ic_sn_xact.is_dvm_sync() == 1) begin
        wait (ic_sn_xact.data_status == svt_chi_transaction::ACCEPT);
        #10000ns;
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end else begin
        wait (resume_response_for_first_xact == 1);
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end
    end
  join_none
endtask

//------------------------------------------------------------------------------
function svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::new(string name="svt_chi_ic_sn_suspend_response_resume_after_delay_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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
    total_req_received++;
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      case ($urandom_range(1,0))
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
          rsp_mssg_type = "COMPDATA";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;              
          rsp_mssg_type = "NOT_PROGRAMMED";
        end
      endcase
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)

        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif                
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)  begin
         case ($urandom_range(4,0)) 
           0: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
             rsp_mssg_type = "COMP";
           end
           1: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
             rsp_mssg_type = "DBIDRESP";
           end
           2: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
             rsp_mssg_type = "COMPDBIDRESP";
           end
           3: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
             rsp_mssg_type = "DBIDRESPORD";
           end
           4: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
             rsp_mssg_type = "NOT_PROGRAMMED";
           end
         endcase
       end
       else
      `endif
       begin
         case ($urandom_range(3,0)) 
           0: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
             rsp_mssg_type = "COMP";
           end
           1: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
             rsp_mssg_type = "DBIDRESP";
           end
           2: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
             rsp_mssg_type = "COMPDBIDRESP";
           end
           3: begin
             req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED;          
             rsp_mssg_type = "NOT_PROGRAMMED";
           end
         endcase
       end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end else if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

  if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
      req.suspend_response = 1'b1;
      resume_transaction(req);
   end
   else begin

     if (
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
          `ifdef SVT_CHI_ISSUE_E_ENABLE
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
          `endif
          (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
        ) begin
       if (total_req_received == 1) begin
         `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
         req.suspend_response = 1'b1;
         resume_transaction(req);
       end
     end

     if (total_req_received == 5) begin
       fork 
         begin
           virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
           repeat(1000) @(ic_rn_vif.sn_cb);
           resume_response_for_first_xact = 1;
         end
       join_none
     end    
   end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_suspend_response_resume_after_delay_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      if(ic_sn_xact.xact_type == svt_chi_transaction::DVMOP)
        wait (ic_sn_xact.data_status == svt_chi_transaction::ACCEPT);
      #20000ns;
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
      /*end else begin
        wait (resume_response_for_first_xact == 1);
        `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
        ic_sn_xact.suspend_response = 0;
      end*/
    end
  join_none
endtask


//------------------------------------------------------------------------------
function svt_chi_ic_sn_read_data_interleave_response_sequence::new(string name="svt_chi_ic_sn_read_data_interleave_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_read_data_interleave_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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
    if ((req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) ||
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY)
         || (req_resp.is_atomicop_xact() == 1)
       `endif    
       `ifdef SVT_CHI_ISSUE_E_ENABLE
         || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE)
       `endif    
       ) begin 
      total_req_received++;
    end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP 
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      rsp_mssg_type = "COMPDATA";
      if (req_resp.order_type != svt_chi_transaction::NO_ORDERING_REQUIRED) begin
        if (ideal_slave_mode) begin
          req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
        end
        else begin
          case ($urandom_range(2,0)) 
            0: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_BEFORE_DATA;
            end
            1: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_AFTER_DATA;
            end
            2: begin
              req_resp.readreceipt_policy = svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
            end
          endcase // case ($urandom_range(2,0))
        end // else: !if(ideal_slave_mode)
        
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
      end
      else
        `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data)});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif                
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
        case ($urandom_range(3,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
            rsp_mssg_type = "DBIDRESPORD";
          end
          3: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      else
      `endif
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE    
      else if (req_resp.is_atomicop_xact() == 1 && req_resp.atomic_transaction_type == svt_chi_transaction::STORE) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
           case ($urandom_range(3,0)) 
             0: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
               rsp_mssg_type = "COMP";
             end
             1: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
               rsp_mssg_type = "DBIDRESP";
             end
             2: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
               rsp_mssg_type = "DBIDRESPORD";
             end
             3: begin
               req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
               rsp_mssg_type = "COMPDBIDRESP";
            end 
          endcase
        end
        else
        `endif
        begin
          case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end 
          endcase
        end
        req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      end else if(req_resp.is_atomicop_xact() == 1) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin 
            case ($urandom_range(4,0)) 
              0: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
              end
              1: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
              end
              2: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
              end
              3: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
              end
              4: begin
                req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
              end
            endcase
          end
          else
        `endif
          begin
          case ($urandom_range(2,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          endcase
        end
      end
    `endif    
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

    if ((req.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) ||
       `endif
          (req.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
          (req.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
          `ifdef SVT_CHI_ISSUE_B_ENABLE
            || (req.is_atomicop_xact() == 1)
          `endif
       ) begin
      if (
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESP) ||
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD) ||
           `endif
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_NOT_PROGRAMMED) ||
           (req.xact_rsp_msg_type == svt_chi_sn_transaction::RSP_MSG_COMPDATA)
           `ifdef SVT_CHI_ISSUE_B_ENABLE    
            || (req.is_atomicop_xact() == 1 && req.atomic_transaction_type != svt_chi_transaction::STORE &&
                ((req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA)
                 `ifdef SVT_CHI_ISSUE_E_ENABLE
                  ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA) ||
                 (req.atomic_compdata_order_policy == svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA)
                 `endif
                )
               )
           `endif    
         ) begin
        if (total_req_received < 11) begin
          `svt_xvm_note("body", {`SVT_CHI_PRINT_PREFIX(req), "Suspending response"});
          req.suspend_response = 1'b1;
          // Enable read data interleaving for suspended transactions.
          if(req.order_type == svt_chi_transaction::NO_ORDERING_REQUIRED)
            req.enable_interleave = 1'b1;
          resume_transaction(req);
        end
      end
      req.xact_rsp_msg_type.rand_mode(0);
      req.order_type.rand_mode(0);

      if (total_req_received == 10) begin
        fork 
          begin
            virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
            repeat(10) @(ic_rn_vif.sn_cb);
            resume_response_for_first_xact = 1;
          end
        join_none
      end    
    end    
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                            }
                           );
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_read_data_interleave_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      wait (resume_response_for_first_xact == 1);
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
    end
  join_none
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_reordering_response_sequence::new(string name="svt_chi_ic_sn_reordering_response_sequence");
  super.new(name);
endfunction
//------------------------------------------------------------------------------
task svt_chi_ic_sn_reordering_response_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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
    if ((req_resp.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
        ((req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
        ((req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif         
        (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         ||    
         (req_resp.is_atomicop_xact() == 1)
       `endif    
       ) begin 
          total_req_received++;
     end
    /**
     * Set the SN response type.
     * For ReadNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDATA.
     * o This makes the SN to transmit CompData message(s).
     * For WriteNoSnp, the xact_rsp_msg_type is set to RSP_MSG_COMPDBIDRESP.
     * o This makes the SN to transmit CompDBIDResp message.
     */
    if (req_resp.xact_type == svt_chi_sn_transaction::READNOSNP
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) 
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       || (req_resp.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) 
       `endif
       ) begin
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), "Reading "});

      get_read_data_from_mem_to_transaction(req_resp);
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDATA;
      rsp_mssg_type = "COMPDATA";
      req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp),$sformatf("Completed reading. Sending %0s response with data 'h%0h, wysiwyg_data 'h%0h, readreceipt_policy %0s", req_resp.xact_rsp_msg_type.name(),req_resp.data,req_resp.wysiwyg_data,req_resp.readreceipt_policy.name())});
    end
    else if (
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL) ||
`ifdef SVT_CHI_ISSUE_E_ENABLE       
             ((req_resp.xact_type == svt_chi_transaction::WRITENOSNPZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
             ((req_resp.xact_type == svt_chi_transaction::WRITEUNIQUEZERO) && (req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)) ||
`endif   
             `ifdef SVT_CHI_ISSUE_B_ENABLE
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULLSTASH) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTLSTASH) ||
             `endif
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEFULL) ||
             (req_resp.xact_type == svt_chi_sn_transaction::WRITEUNIQUEPTL)
           ) begin
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
        case ($urandom_range(3,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
          3: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
            rsp_mssg_type = "DBIDRESPORD";
          end
        endcase
      end
      else
      `endif
      begin
        case ($urandom_range(2,0)) 
          0: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
            rsp_mssg_type = "COMP";
          end
          1: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
            rsp_mssg_type = "DBIDRESP";
          end
          2: begin
            req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
            rsp_mssg_type = "COMPDBIDRESP";
          end
        endcase
      end
      `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Writing with %0s response",rsp_mssg_type)});
      put_write_transaction_data_to_mem(req_resp);
    end
    `ifdef SVT_CHI_ISSUE_B_ENABLE    
      else if (req_resp.is_atomicop_xact() == 1 && req_resp.atomic_transaction_type == svt_chi_transaction::STORE) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(3,0)) 
            0: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
              rsp_mssg_type = "COMP";
            end
            1: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
              rsp_mssg_type = "DBIDRESP";
            end
            2: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
              rsp_mssg_type = "COMPDBIDRESP";
            end 
            3: begin
              req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESPORD;              
              rsp_mssg_type = "DBIDRESPORD";
            end
          endcase
        end
        else
        `endif
        begin
        case ($urandom_range(2,0)) 
        0: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMP;
          rsp_mssg_type = "COMP";
        end
        1: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
          rsp_mssg_type = "DBIDRESP";
        end
        2: begin
          req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP;          
          rsp_mssg_type = "COMPDBIDRESP";
        end 
        endcase
        end
        req_resp.order_type = svt_chi_transaction::NO_ORDERING_REQUIRED; 
      end else if(req_resp.is_atomicop_xact() == 1) begin
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(req_resp.cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)begin
          case ($urandom_range(4,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          3: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_BEFORE_COMPDATA;              
          end
          4: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA;          
          end
          endcase
        end
        else
        `endif
        begin
          case ($urandom_range(3,0)) 
          0: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_WITH_COMPDATA;
          end
          1: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_BEFORE_COMPDATA;              
          end
          2: begin
            req_resp.atomic_compdata_order_policy = svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA;          
          end
          endcase
       end
      end
    `endif    
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

  if ((req.xact_type == svt_chi_sn_transaction::READNOSNP) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READNOTSHAREDDIRTY) ||
       `endif
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (req.xact_type == svt_chi_sn_transaction::READPREFERUNIQUE) ||
       `endif
        (req.xact_type == svt_chi_sn_transaction::WRITENOSNPFULL) ||
        (req.xact_type == svt_chi_sn_transaction::WRITENOSNPPTL)
        `ifdef SVT_CHI_ISSUE_B_ENABLE
          || (req.is_atomicop_xact() == 1)
        `endif
     ) begin 
    if (
         (req.xact_rsp_msg_type != svt_chi_sn_transaction::RSP_MSG_COMP) &&
         (req.xact_rsp_msg_type != svt_chi_sn_transaction::RSP_MSG_COMPDBIDRESP)
        `ifdef SVT_CHI_ISSUE_B_ENABLE
         && (req.is_atomicop_xact() == 0 || req.atomic_transaction_type == svt_chi_sn_transaction::STORE ||
             (req.atomic_compdata_order_policy != svt_chi_sn_transaction::DBIDRESP_AFTER_COMPDATA 
             `ifdef SVT_CHI_ISSUE_E_ENABLE
               && req.atomic_compdata_order_policy != svt_chi_sn_transaction::DBIDRESPORD_AFTER_COMPDATA
             `endif 
             )
            )
        `endif
       ) begin
      if (total_req_received < 11) begin
        req.suspend_response = 1'b1;
        resume_transaction(req);
      end
    end
    req.xact_rsp_msg_type.rand_mode(0);

    if (total_req_received == 10) begin
      fork 
        begin
          virtual svt_chi_ic_rn_if ic_rn_vif = req.cfg.sys_cfg.chi_if.get_ic_rn_if(0);
          repeat(10) @(ic_rn_vif.sn_cb);
          resume_response_for_first_xact = 1;
        end
      join_none
    end    
  end
    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `svt_xvm_rand_send_with(req,
                            {
                             if (ideal_slave_mode)
                             {
                              req.readreceipt_policy == svt_chi_sn_transaction::READRECEIPT_WITH_DATA;
                             }
                            }
                           );
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask
//------------------------------------------------------------------------------
task svt_chi_ic_sn_reordering_response_sequence::resume_transaction (svt_chi_ic_sn_transaction ic_sn_xact);
  fork 
    begin
      wait (resume_response_for_first_xact == 1);
      `svt_xvm_note("resume_transaction", $sformatf("Resuming Slave response %s", `SVT_CHI_PRINT_PREFIX(ic_sn_xact)));
      ic_sn_xact.suspend_response = 0;
    end
  join_none
endtask
//------------------------------------------------------------------------------
function svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence::new(string name="svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence");
  super.new(name);
endfunction

//------------------------------------------------------------------------------
task svt_chi_ic_sn_dvm_outstanding_suspend_response_resume_after_delay_sequence::body();
  int total_req_received = 0;
  string rsp_mssg_type;
  `svt_xvm_debug("body", "Entered ...");

  /** This method is defined in the svt_chi_ic_sn_transaction_base_sequence.
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

    if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
      req_resp.xact_rsp_msg_type = svt_chi_sn_transaction::RSP_MSG_DBIDRESP;              
      rsp_mssg_type = "DBIDRESP"; 
    end
    
    `svt_xvm_verbose("body", {"Response: ", req_resp.sprint()});    
    $cast(req,req_resp);

   if(req_resp.xact_type == svt_chi_transaction::DVMOP) begin
     if(req.is_dvm_sync() == 0)begin
       req.suspend_response = 1'b1;
       dvm_reqs_received.push_back(req);
       total_dvm_txns_recieved++;
       if(total_dvm_txns_recieved == 256)begin
         foreach(dvm_reqs_received[i])begin
           dvm_reqs_received[i].suspend_response = 0;
         end 
         total_dvm_txns_recieved=0;
       end        
     end
     else if(req.is_dvm_sync() == 1)begin
       #10000ns;
       dvm_reqs_received.delete();
     end        
   end

    /**
     * send to driver
     */
    `svt_xvm_debug("body", {`SVT_CHI_PRINT_PREFIX(req_resp), $sformatf("Sending %0s response", req_resp.xact_rsp_msg_type.name())});
    `ifdef SVT_CHI_ISSUE_D_ENABLE
      create_and_set_random_values_in_cbusy_fields(req);
    `endif
    `svt_xvm_send(req)
  end // forever begin
  `svt_xvm_debug("body", "Exiting ...");
endtask


`endif // GUARD_SVT_CHI_IC_SN_TRANSACTION_SEQUENCE_COLLECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NT6gkZWO4RqK8ElrrN19CBU7zGA7q6/Z+NYzdTWfSmlL7SSH6OSxT5A9+jSvvTR9
1mLk5jXi17DMyBd1LpEWGpYVFUVSnWIFboaaqCZGGUNDwNv6eTHiljZ4W36lMA8F
K9mGHvtNm1jX9H181TknmgCS6j4ekDYrktG2xzdhC14=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11694     )
s9Xi5KUS4DbS6c+bhUawgbJN1OuKHeOfxaSejMntPQvQq8uzQQT6NutiLDaEVR2L
tCaeDTZBlNjejlryjyCO5opDVTPwIkip50pHfGdnvCkThclN8JsaysafTQZx2S9F
`pragma protect end_protected
