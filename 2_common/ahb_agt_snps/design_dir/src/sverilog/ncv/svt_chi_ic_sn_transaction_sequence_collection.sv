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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+NtXoy3mhB87F5n+viCJNeNhIHiY/e4gbFfKjIzYiNopAeJrXhSwIeZU9GNMwdBQ
+9u6V8lreGEjd3w2lcYGadjYq3kPT+3nzopfN1PS07W5CIeE5YteM1n6r/nc5pRW
9XUggeL2t36ZzdYQF9pXAc+RAV6tWb9+KXQCakynLVkh5+TvErvfxg==
//pragma protect end_key_block
//pragma protect digest_block
1idoUrAPEGfw51a+ILLsDFSgGCg=
//pragma protect end_digest_block
//pragma protect data_block
KxzOzdVZZBiXemXAD85dMFqalvQ/xg4gCS66VPwhRuv/cFgdrCzHSZiy8iNQobgR
93Fn6Btl3khv3zaX5nxJB22+Lo/luq96J4tZcfZ7nwETmNKJY0IdET3Nn5Y0Vk1L
1W8eHrxCuIolKJayf3ap2jg+kMC6Ha1JTuLjIlqKLn+5ru8QSpSC38/sj7BSSvgn
lyV3BFKErLbyq3oPsKvlcN1NJQPwXOSUAs01dntFkhFayr+Pvs0ozIk1iUFPvu2z
ujs6ASBglGEfronESZJMCahYs7/ZOpC7pjKlm8Ot00WmUub/558BqX17nVlN7CDr
lIJDnDUFKozVMT003vJv2x7mjo3KRY5EmnCpLfsdsBfkzDat9ud2UP6QOjf1VR34
nEK8zO+DyKTtihuI4SeUOVjDKGrMPq+N8oUTKRzFSsk8bhBL/h1OqNH+6jTT7iAm
AGBnmqw4F+TSHRWsI7ZDMWnC1j5aYES/0WNvN3EMcImYvuM4AFEVYDsIOy5U8XMs
mIkH0Vj+PcbgRk0FFpdD6A3upoXT5EpHN+3JDuYPNzrgJLAV1IkfAAv2IoYGiCGx
OS0iozX2jUzyY2KNfZ5Wo+jQjKNxHjPzlqajMCARaCJS4BkYo5rd3h0p6062937e
effGARGrJZTp0u84z+WslYVCy7e8M+x3smn2r2HIKUo=
//pragma protect end_data_block
//pragma protect digest_block
qYI4gTMuZJBppoX2L/Tclb3OCgk=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AnY9j5RiB0RxAhhnvpsxnY1HqKkFFF55ocuDoYN+OQrN4t7VubpwmuA+ETCxMmFM
uWPPrgf67NzyEKuFjFyVOB1TRoxFSIm/n5F+ZOUs/HvY6JjnnwySw2BVC62zXgkp
rRgx4NiQxiFaebjkm38MG1GmZ2N45RqHvP698pU3dQVWf/kfxbsMsA==
//pragma protect end_key_block
//pragma protect digest_block
PSZOQ8CDI+s/jQElkLckaznYsac=
//pragma protect end_digest_block
//pragma protect data_block
I4C5P6Tq6GSE+xtanuLxmxrOIO/knpisZ4x5xJB4Ra1jR0Eh6uUrTqWQsbXBcqh5
Ddnj28EO0w0Y/ke2xS5ZPqUo35DXSdnousSGCsSPQEt66HE5p6CG59d+bZMVErm+
nZrEUWHC6PBcOWHY3cSeFxhCGiGL/HtcEbzICt6maP+FFaKK4EDkOkQFj0BAcrkZ
wxHNy1VKqIPqiZDwM1rA3Tto/1GiyfU3qdnS33KQ0XmxSdGEt26o9Si5V3/pFJWb
PDxDu3wb6kk919ES4P5K/VJHZOsN8mpXmWg5N2joXV2yxMb161NJab3jYZM8ZVAz
bLh+jPKK4bHkJHVD+5dIvcxLXdcN43mmmFJ4fnd6tJIFgl0/b9dg/H3QeeQxkVLr
zo7DQb9OemokvupgvV4gTs26RsDFd2i60yoI4Q/0niJFBuFb0ZVhDvz0mvMDW6lY
b8LCULCxF1RoHmmn5EyG2tE5+1OcDqyy+VkuIi2ycabD8QHyrbwiE1RqECXFm3r1
4bheTTOFHO20mQJDkXE/GOavgb+c9K7zxwgHZk3bmYpbRhpvIS8+/djAlGNof65I
6QzU1mvr01OJuCr17zdoykS7Y2ECOLoP3LbptOw6PKGFgRNJaeYCJFI1nv762HLS

//pragma protect end_data_block
//pragma protect digest_block
P2RV55vvWcwwZrigt5uVYdV0CKg=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Po5XG3j32qfSabqNkGrfbeJVdHRT1CtxHZVntD+PzkGFAT20lPvCrK4QcoFkRUdT
W8rrqfQfasAIf8pHZCDexDJfiA0KTBqH5UQegO3p2IgYVQbzK+ckgVtHrU/n90l4
7jNVEXsZQVKsl1I4mk46+lr08Q+GHq/1UcA8lotAipZ6dDTuaXYp+Q==
//pragma protect end_key_block
//pragma protect digest_block
rXYeN34ab4Ef60oDmsZZLs9R+nU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
VJfoqvRlDSCOIVTffB9ySezNHA8=
//pragma protect end_digest_block
//pragma protect end_protected
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
