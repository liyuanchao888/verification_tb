//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class represents CHI SN transaction. It basically contains constraints
 * for fields in base class svt_chi_transaction as applicable to Slave Node.
 */
class svt_chi_sn_transaction extends svt_chi_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  /** This enum declaration is used to indicate the CHI Response Message types that user can provide through SN response sequence or through IC SN response sequence which is applicable in ICN Full-Slave mode. */
  typedef enum {
    RSP_MSG_COMP         , /**<: Completion response message Comp followed by Misc. response message DBIDResp. Applies to WriteNoSnp* transaction. Applicable for SN and ICN in Full slave mode.  Applies to WriteNoSnp*, WriteUnique*, AtomicStore transaction */
    RSP_MSG_COMPDBIDRESP , /**<: Completion response message CompDBIDResp. Applicable for SN and ICN in Full slave mode.  Applies to WriteNoSnp*, WriteUnique*, AtomicStore transaction */
    RSP_MSG_RETRYACK     , /**<: Misc. response messages RetryAck and PcrdGrant. Applicable for SN and ICN in Full slave mode. In case of ICN full slave mode, this is not supported for the cases with: svt_chi_sn_transaction::suspend_response = 1 OR svt_chi_sn_transaction::enable_interleave = 1 OR svt_chi_node_configuration::rsp_flit_reordering_depth > 1 */
    RSP_MSG_DBIDRESP     , /**<: Misc. response message DBIDResp followed by Completion response message Comp. Applies to WriteNoSnp*, WriteUnique*, AtomicStore transaction. Applicable for SN and ICN in Full slave mode. */
    RSP_MSG_COMPDATA     , /**<: Data completion message CompData, DataSepRsp (CHI-C or later: corresonding to ReadNoSnpSep). Applies to ReadNoSnp, ReadnoSnpSep(CHI-C or later) and all AtomicOp(CHI-B or later) transactions other than AtomicStore transactions. Applicable for SN and ICN in Full slave mode. When is_respsepdata_datasepresp_flow_used is set to 1 respsepdata datasepresp will be sent by ICN full slave instead of compdata. */
`ifdef SVT_CHI_ISSUE_E_ENABLE
    RSP_MSG_COMP_DBIDRESP_COMPCMO, /** Completion response messages Comp -> DBIDResp -> CompCMO. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMP_COMPCMO, /** Completion response messages DBIDResp -> Comp -> CompCMO. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMPCMO_COMP, /** Completion response messages DBIDResp -> CompCMO -> Comp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_COMPCMO_DBIDRESP, /** Completion response messages Comp -> CompCMO -> DBIDResp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMP_DBIDRESP, /** Completion response messages CompCMO -> Comp -> DBIDResp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESP_COMP, /** Completion response messages CompCMO -> DBIDResp -> Comp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESPORD_COMPCMO, /** Completion response messages Comp -> DBIDRespOrd -> CompCMO. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMP_COMPCMO, /** Completion response messages DBIDRespOrd -> Comp -> CompCMO. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMPCMO_COMP, /** Completion response messages DBIDRespOrd -> CompCMO -> Comp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_COMPCMO_DBIDRESPORD, /** Completion response messages Comp -> CompCMO -> DBIDRespOrd. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMP_DBIDRESPORD, /** Completion response messages CompCMO -> Comp -> DBIDRespOrd. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESPORD_COMP, /** Completion response messages CompCMO -> DBIDRespOrd -> Comp. Applicable for Combined NCBWrite with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMPDBIDRESP,  /** Completion response messages CompCMO -> CompDBIDResp. Applicable for Combined Write with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPDBIDRESP_COMPCMO,  /** Completion response messages CompDBIDResp -> CompCMO. Applicable for Combined Write with non-persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMP_COMPCMO_PERSIST, /** Completion response messages DBIDResp -> Comp -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMP_PERSIST_COMPCMO, /** Completion response messages DBIDResp -> Comp -> Persist -> CompCMO. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMP_COMPPERSIST, /** Completion response messages DBIDResp -> Comp -> CompPersist . Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMPCMO_COMP_PERSIST, /** Completion response messages DBIDResp -> CompCMO -> Comp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMPCMO_PERSIST_COMP, /** Completion response messages DBIDResp -> CompCMO -> Persist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_COMPPERSIST_COMP, /** Completion response messages DBIDResp -> CompPersist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_PERSIST_COMP_COMPCMO, /** Completion response messages DBIDResp -> Persist -> Comp -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESP_PERSIST_COMPCMO_COMP, /** Completion response messages DBIDResp -> Persist -> CompCMO -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESP_COMPCMO_PERSIST, /** Completion response messages Comp -> DBIDResp -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESP_PERSIST_COMPCMO, /** Completion response messages Comp -> DBIDResp -> Persist -> CompCMO. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESP_COMPPERSIST, /** Completion response messages Comp -> DBIDResp -> CompPersist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_COMPCMO_DBIDRESP_PERSIST, /** Completion response messages Comp -> CompCMO -> DBIDResp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESP_COMP_PERSIST, /** Completion response messages CompCMO -> DBIDResp -> Comp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESP_PERSIST_COMP, /** Completion response messages CompCMO -> DBIDResp -> Persist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMP_DBIDRESP_PERSIST, /** Completion response messages CompCMO -> Comp -> DBIDResp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMP_COMPCMO_PERSIST, /** Completion response messages DBIDRespOrd -> Comp -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMP_PERSIST_COMPCMO, /** Completion response messages DBIDRespOrd -> Comp -> Persist -> CompCMO. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMP_COMPPERSIST, /** Completion response messages DBIDRespOrd -> Comp -> CompPersist . Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMPCMO_COMP_PERSIST, /** Completion response messages DBIDRespOrd -> CompCMO -> Comp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMPCMO_PERSIST_COMP, /** Completion response messages DBIDRespOrd -> CompCMO -> Persist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_COMPPERSIST_COMP, /** Completion response messages DBIDRespOrd -> CompPersist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_PERSIST_COMP_COMPCMO, /** Completion response messages DBIDRespOrd -> Persist -> Comp -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_DBIDRESPORD_PERSIST_COMPCMO_COMP, /** Completion response messages DBIDRespOrd -> Persist -> CompCMO -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESPORD_COMPCMO_PERSIST, /** Completion response messages Comp -> DBIDRespOrd -> CompCMO -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESPORD_PERSIST_COMPCMO, /** Completion response messages Comp -> DBIDRespOrd -> Persist -> CompCMO. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_DBIDRESPORD_COMPPERSIST, /** Completion response messages Comp -> DBIDRespOrd -> CompPersist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_COMPCMO_DBIDRESPORD_PERSIST, /** Completion response messages Comp -> CompCMO -> DBIDRespOrd -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESPORD_COMP_PERSIST, /** Completion response messages CompCMO -> DBIDRespOrd -> Comp -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_DBIDRESPORD_PERSIST_COMP, /** Completion response messages CompCMO -> DBIDRespOrd -> Persist -> Comp. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMP_DBIDRESPORD_PERSIST, /** Completion response messages CompCMO -> Comp -> DBIDRespOrd -> Persist. Applicable for Combined NCBWrite with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPCMO_COMPDBIDRESP_PERSIST, /** Completion response messages CompCMO -> CompDBIDResp -> Persist. Applicable for Combined Write with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPDBIDRESP_COMPCMO_PERSIST, /** Completion response messages CompDBIDResp -> CompCMO -> Persist. Applicable for Combined Write with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPDBIDRESP_PERSIST_COMPCMO, /** Completion response messages CompDBIDResp -> Persist -> CompCMO. Applicable for Combined Write with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPDBIDRESP_COMPPERSIST, /** Completion response messages CompDBIDResp -> CompPersist . Applicable for Combined Write with persistent CMO transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMP_STASHDONE,  /** Applicable for StashOnceSepUnique and StashOnceSepShared transactions. Supported for ICN Full slave mode. */
    RSP_MSG_STASHDONE_COMP,  /** Applicable for StashOnceSepUnique and StashOnceSepShared transactions. Supported for ICN Full slave mode. */
    RSP_MSG_COMPSTASHDONE,  /** Applicable for StashOnceSepUnique and StashOnceSepShared transactions. Supported for ICN Full slave mode. */
`endif //issue_e_enable
`ifdef SVT_CHI_ISSUE_D_ENABLE
    RSP_MSG_COMP_PERSIST, /** Completion response messages Comp -> Persist. Applicable for CleanSharedPersistSep transactions. Supported for SN and ICN full slave mode.   */
    RSP_MSG_PERSIST_COMP, /** Completion response messages Persist -> Comp. Applicable for CleanSharedPersistSep transaction. Supported for SN and ICN full slave mode. */
    RSP_MSG_COMPPERSIST, /** Completion response message CompPersist. Applicable for CleanSharedPersistSep transaction. Supported for SN and ICN full slave mode. */
`endif  //issue_d_enable
`ifdef SVT_CHI_ISSUE_E_ENABLE
    RSP_MSG_DBIDRESPORD, /**<: Misc. response message DBIDRespOrd followed by Completion response message Comp. Applies to WriteNoSnp*, WriteUnique*, Atomic transaction, NonCopyBackWriteCMO. Applicable ICN in Full slave mode. This response is not applicable for DVM transactions. SN should not generate this response*/
`endif //issue_e_enable
    RSP_MSG_NOT_PROGRAMMED /**<: Internally used by the VIP. Not Applicable for SN and ICN Full-Slave mode. */
  } xact_rsp_msg_type_enum;

  /**
   * Defines readreceipt generation policy for RN connected Interconnect node, SN-I node in active mode. It is also supported in ICN Full-Slave mode. <br>
   * 
   */
  typedef enum {
    READRECEIPT_BEFORE_DATA = 0, /**<: COMPDATA DAT flits will be initiated after READRECEIPT RSP flit is complete. */
    READRECEIPT_AFTER_DATA  = 1, /**<: READRECEIPT RSP flit will be initiated after all COMPDATA DAT flits are complete. */
    READRECEIPT_WITH_DATA   = 2  /**<: READRECEIPT RSP flit will be initiated along with COMPDATA DAT flits. */
  } readreceipt_policy_enum;

`ifdef SVT_CHI_ISSUE_C_ENABLE
  /**
   * Defines RespSepData and DataSepResp generation policy for Read requests from ICN Full Slave VIP. <br>
   */
  typedef enum {
    RESPSEPDATA_BEFORE_DATASEPRESP = 0, /**<: DATASEPRESP DAT flits will be initiated after RESPSEPDATA RSP flit is complete. */
    RESPSEPDATA_DURING_DATASEPRESP = 1, /**<: RESPSEPDATA DAT flits will be initiated after first DATASEPRESP flit is complete. */
    RESPSEPDATA_AFTER_DATASEPRESP = 2 /**<: RESPSEPDATA DAT flits will be initiated after all the DATASEPRESP flit is complete. */
  } respsepdata_policy_enum;
`endif

  /**
    *  Enum that controls the order of sending dbidresp and compdata for atomic transactions other than atomic store.
    */
  typedef enum {
    DBIDRESP_WITH_COMPDATA = 0,   /**<: DBIDRSP flit will be initiated along with COMPDATA DAT flits. */
    DBIDRESP_BEFORE_COMPDATA = 1, /**<: DBIDRSP flit will be initiated before COMPDATA DAT flits. */
    DBIDRESP_AFTER_COMPDATA = 2   /**<: DBIDRSP flit will be initiated after all COMPDATA DAT flits are complete. */
    `ifdef SVT_CHI_ISSUE_E_ENABLE   
    ,DBIDRESPORD_BEFORE_COMPDATA = 3, /**<: DBIDRSPORD flit will be initiated before COMPDATA DAT flits. */
    DBIDRESPORD_AFTER_COMPDATA = 4  /**<: DBIDRSPORD flit will be initiated after all COMPDATA DAT flits are complete. */
    `endif //issue_e_enable
  } atomic_compdata_order_policy_enum;

    
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   *  This attribute is used by SN_I protocol driver, RN connected IC VIP nodes, ICN Full slave.
   *  This is applicable in the case where the received READ request requires
   *  a read receipt response message to be transmitted by the driver.
   *  In such a scenario, the driver sets this attribute to 1'b1
   *  after transmitting the read receipt response message.
   */
  bit is_read_receipt_sent;

  /**
   * Weight applied to the is_retry distribution constraint for the case of is_retry==0.
   */
  int IS_RETRY_wt= 1000;
  
  /**
    * - A bit that indicates that the testbench would like to suspend response/data
    *   for a Read/Write/Write with CMO(CHI-E) transaction until this bit is reset. 
    * - This bit is set to 1 by the testbench when it needs to provide data/response
    *   information to the SN driver/ICN Full slave, but the data/response is not yet ready.
    *   The transaction's response/data will not be sent until this bit is set to 0. 
    * - The testbench can set this bit to 0 so that this transaction can be resumed back.
    *   Once the data/response is available, the testbench can populate response fields 
    *   and set this bit to 0, upon which the driver will send the response/data of this transaction. 
    * - Applicable for Active SN-F, ICN Full Slave VIP.  
    * - Refer to VIP documentation for the list of supported transactions for this feature, with 
    *   ICN Full Slave VIP.
    * - Default value: 0
    * - When set to 0, the SN-F driver expects the response information in zero time. 
    * - When set to 1:
    *   - For the ReadNoSnp request transaction:
    *     - The CompData flits will be suspended when svt_chi_sn_transaction::xact_rsp_msg_type 
    *       is programmed as svt_chi_sn_transaction::RSP_MSG_COMPDATA.
    *     .
    *   - For the ReadNoSnpSep request transaction:
    *     - The DataSepResp flits will be suspended when svt_chi_sn_transaction::xact_rsp_msg_type 
    *       is programmed as svt_chi_sn_transaction::RSP_MSG_COMPDATA.
    *     .
    *   - For the WriteNoSnpFull/WriteNoSnpPtl request transaction:
    *     - After DBIDResp flit is sent, the Comp flit will be suspended when svt_chi_sn_transaction::
    *       xact_rsp_msg_type is programmed as svt_chi_sn_transaction::RSP_MSG_DBIDRESP.
    *     .
    *   .
    *   - For CHI-E combined Writes with (P)CMO transactions:
    *     - After DBIDResp or CompDBIDResp flit is sent, any subsequent RSP flits that must be sent by the VIP component,
    *       will be suspended until this bit is reset. Refer to the documentation of the enum xact_rsp_msg_type_enum.
    *     - This is supported only for ICN Full Slave.
    *     - This is not supported for SN.
    *     .
    *   .
    * .
    */
  bit suspend_response = 0;
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------
  /** This field defines the response type. */
  rand xact_rsp_msg_type_enum xact_rsp_msg_type = RSP_MSG_COMP;

  /** This field defines the readreceipt policy. Readreceipt response is sent if Order 
    * is set in the transaction request. Applicable only for READNOSNP and
    * READONCE* transaction types. Applicable for ICN Full-Slave mode. 
    * The ICN full slave mode driver sets the default value to READRECEIPT_WITH_DATA
    * for such ordered Reads. However, this can be controlled further through 
    * ic_sn response sequence. In all other cases, this field is not relevant and is 
    * ignored. 
    */
  rand readreceipt_policy_enum readreceipt_policy = READRECEIPT_WITH_DATA;
  
`ifdef SVT_CHI_ISSUE_C_ENABLE
  
  /** This field defines the respsepdata policy. 
    * Applicable only for Read transactions for ISSUE_C or latter and when is_respsepdata_datasepresp_flow_used is set to 1.
    */
  rand respsepdata_policy_enum respsepdata_policy = RESPSEPDATA_BEFORE_DATASEPRESP;
  
`endif

  /**
    * This field defines the order in which the dbidresp and compdata is sent for atomic transactions other than atomic store.
    * The default value is set to DBIDRESP_WITH_COMPDATA.
    */

  rand atomic_compdata_order_policy_enum atomic_compdata_order_policy = DBIDRESP_WITH_COMPDATA;  
  
  /** 
   * Indicates that this is a retry response. This inturn constraints
   * xact_rsp_msg_type to RSP_MSG_RETRYACK. <br>
   * In this case #is_p_crd_grant_before_retry_ack controls the order of RETRYACK
   * and PCRDGRANT response flits. Further #p_crd_type controls the credit type value
   * in these resposne flits.
   */
  rand bit is_retry;

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------
  /** Unsupported feature constraints: Random retry response is unsupported */
  constraint chi_sn_transaction_unsupported_features_random_retry_resp {
    is_retry == 0;
    xact_rsp_msg_type != RSP_MSG_RETRYACK;
  }
  
  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** Valid values for data_tag_op*/
  constraint chi_ic_sn_transaction_data_tag_op_for_reads {
    if(cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_E) {
      data_tag_op == TAG_INVALID;
      atomic_read_data_tag_op == TAG_INVALID;
    }
    if(xact_type == READNOSNP || 
       xact_type == READNOSNPSEP || 
       xact_type == READONCE || 
       xact_type == READCLEAN || 
       xact_type == READSHARED || 
       xact_type == READNOTSHAREDDIRTY || 
       xact_type == READPREFERUNIQUE || 
       xact_type == READUNIQUE || 
       xact_type == READONCECLEANINVALID || 
       xact_type == READONCEMAKEINVALID){
      if(req_tag_op == TAG_INVALID){
        data_tag_op inside {TAG_TRANSFER, TAG_INVALID};
      }
      if(xact_type == READNOSNP || xact_type == READNOSNPSEP){
        if(req_tag_op == TAG_TRANSFER || req_tag_op == TAG_FETCH_MATCH){
          data_tag_op inside {TAG_TRANSFER, TAG_INVALID}; //TAG_INVALID is possible only when memory tagging is not supported
        }
      }
      if(xact_type == READONCE || xact_type == READCLEAN){
        if(req_tag_op == TAG_TRANSFER){
          data_tag_op inside {TAG_TRANSFER, TAG_INVALID}; //TAG_INVALID is possible only when memory tagging is not supported
        }
      }
      if(xact_type == READSHARED || xact_type == READNOTSHAREDDIRTY || xact_type == READPREFERUNIQUE){
        if(req_tag_op == TAG_TRANSFER){
          data_tag_op inside {TAG_TRANSFER, TAG_UPDATE, TAG_INVALID}; //TAG_INVALID is possible only when memory tagging is not supported
        }
      }
      if(xact_type == READUNIQUE){
        if(req_tag_op == TAG_TRANSFER || req_tag_op == TAG_FETCH_MATCH){
          data_tag_op inside {TAG_TRANSFER, TAG_UPDATE, TAG_INVALID}; //TAG_INVALID is possible only when memory tagging is not supported
        }
      }
    }
    else if((xact_type == ATOMICLOAD_ADD) || (xact_type == ATOMICLOAD_CLR) ||
               (xact_type == ATOMICLOAD_EOR) || (xact_type == ATOMICLOAD_SET) ||
               (xact_type == ATOMICLOAD_SMAX) || (xact_type == ATOMICLOAD_SMIN) ||
               (xact_type == ATOMICLOAD_UMAX) || (xact_type == ATOMICLOAD_UMIN) ||
               (xact_type == ATOMICSWAP) || (xact_type == ATOMICCOMPARE)) {
      atomic_read_data_tag_op inside {TAG_TRANSFER, TAG_INVALID};
    }
  }
  constraint chi_ic_sn_transaction_data_tag_op_for_makereadunique {
    if(xact_type == MAKEREADUNIQUE){
      if(req_tag_op == TAG_TRANSFER){
        data_tag_op inside {TAG_TRANSFER, TAG_UPDATE, TAG_INVALID}; //TAG_INVALID is possible only when memory tagging is not supported
      }
      else if(req_tag_op == TAG_INVALID){
        data_tag_op inside {TAG_TRANSFER, TAG_INVALID};
      }
    }
  }
    
  /** Valid values for resp tag_op*/
  constraint chi_ic_sn_transaction_rsp_tag_op {
    if(xact_type == MAKEREADUNIQUE){
      if(req_tag_op == TAG_TRANSFER){
        rsp_tag_op inside {TAG_INVALID, TAG_UPDATE};
      }
      if(req_tag_op == TAG_INVALID){
        rsp_tag_op inside {TAG_INVALID};
      }
    }
    else {
      rsp_tag_op == TAG_INVALID;
    }
  }
  
  `endif
  
  /**
   * Valid ranges constraints insure that the transaction settings are supported
   * by the chi components.
   */
  constraint chi_sn_transaction_valid_ranges {

    if( xact_type == READNOSNP
        `ifdef SVT_CHI_ISSUE_C_ENABLE
         || xact_type == READNOSNPSEP
        `endif
      ) {

      // Read response
      if (is_retry && is_dyn_p_crd) {
        xact_rsp_msg_type == RSP_MSG_RETRYACK;
      }
      else {
        xact_rsp_msg_type == RSP_MSG_COMPDATA;
      }
    }

    else if (xact_type inside { WRITENOSNPFULL, WRITENOSNPPTL
       `ifdef SVT_CHI_ISSUE_E_ENABLE
          , WRITENOSNPZERO
       `endif
    }) {
      if (is_retry && is_dyn_p_crd) {
        xact_rsp_msg_type == RSP_MSG_RETRYACK;
      }
      else {
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        if(do_dwt){ 
          xact_rsp_msg_type inside { RSP_MSG_COMP, RSP_MSG_DBIDRESP};
        }
        else {
          xact_rsp_msg_type inside { RSP_MSG_COMP, RSP_MSG_DBIDRESP, RSP_MSG_COMPDBIDRESP};
        }
        `else
          xact_rsp_msg_type inside { RSP_MSG_COMP, RSP_MSG_DBIDRESP, RSP_MSG_COMPDBIDRESP};
        `endif
      }
    }
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    else if(xact_type == CLEANSHAREDPERSISTSEP) {
      if (is_retry && is_dyn_p_crd) {
        xact_rsp_msg_type == RSP_MSG_RETRYACK;
      }
      else {
        xact_rsp_msg_type inside {RSP_MSG_COMPPERSIST, RSP_MSG_COMP_PERSIST, RSP_MSG_PERSIST_COMP};
      }
    }
    `endif //issue_d_enable
    /** Valid response combinations for combined Writes with CMOs */
    `ifdef SVT_CHI_ISSUE_E_ENABLE
    else if (writecmo_type != NOT_COMBINED_WRITE_CMO)
    {
      if (is_retry && is_dyn_p_crd) {
        xact_rsp_msg_type == RSP_MSG_RETRYACK;
      }
      else if (writecmo_type == COPYBACK_NON_PCMO) {
        xact_rsp_msg_type inside {RSP_MSG_COMPDBIDRESP_COMPCMO, RSP_MSG_COMPCMO_COMPDBIDRESP};
      }
      else if ((writecmo_type == WRITENOSNP_NON_PCMO) ||     
               (writecmo_type == WRITEUNIQUE_NON_PCMO)) {
        xact_rsp_msg_type inside {RSP_MSG_COMPDBIDRESP_COMPCMO, RSP_MSG_COMPCMO_COMPDBIDRESP, 
                  RSP_MSG_COMP_DBIDRESP_COMPCMO, RSP_MSG_DBIDRESP_COMP_COMPCMO,
                  RSP_MSG_DBIDRESP_COMPCMO_COMP, RSP_MSG_COMP_COMPCMO_DBIDRESP,
                  RSP_MSG_COMPCMO_COMP_DBIDRESP, RSP_MSG_COMPCMO_DBIDRESP_COMP,
                  RSP_MSG_COMP_DBIDRESPORD_COMPCMO, RSP_MSG_DBIDRESPORD_COMP_COMPCMO,
                  RSP_MSG_DBIDRESPORD_COMPCMO_COMP, RSP_MSG_COMP_COMPCMO_DBIDRESPORD,
                  RSP_MSG_COMPCMO_COMP_DBIDRESPORD, RSP_MSG_COMPCMO_DBIDRESPORD_COMP};
      }
      else if (writecmo_type == WRITENOSNP_PCMO || writecmo_type == WRITEUNIQUE_PCMO ) {
        xact_rsp_msg_type inside {RSP_MSG_DBIDRESP_COMP_COMPCMO_PERSIST, RSP_MSG_DBIDRESP_COMP_PERSIST_COMPCMO,
                                  RSP_MSG_DBIDRESP_COMP_COMPPERSIST, RSP_MSG_DBIDRESP_COMPCMO_COMP_PERSIST,
                                  RSP_MSG_DBIDRESP_COMPCMO_PERSIST_COMP, RSP_MSG_DBIDRESP_COMPPERSIST_COMP,
                                  RSP_MSG_DBIDRESP_PERSIST_COMP_COMPCMO, RSP_MSG_DBIDRESP_PERSIST_COMPCMO_COMP,
                                  RSP_MSG_COMPDBIDRESP_COMPCMO_PERSIST, RSP_MSG_COMPDBIDRESP_PERSIST_COMPCMO,
                                  RSP_MSG_COMPDBIDRESP_COMPPERSIST, RSP_MSG_COMP_DBIDRESP_COMPCMO_PERSIST,
                                  RSP_MSG_COMP_DBIDRESP_PERSIST_COMPCMO, RSP_MSG_COMP_DBIDRESP_COMPPERSIST,
                                  RSP_MSG_COMP_COMPCMO_DBIDRESP_PERSIST, RSP_MSG_COMPCMO_DBIDRESP_COMP_PERSIST, 
                                  RSP_MSG_COMPCMO_DBIDRESP_PERSIST_COMP, RSP_MSG_COMPCMO_COMP_DBIDRESP_PERSIST, 
                                  RSP_MSG_COMPCMO_COMPDBIDRESP_PERSIST, 
                                  RSP_MSG_DBIDRESPORD_COMP_COMPCMO_PERSIST, RSP_MSG_DBIDRESPORD_COMP_PERSIST_COMPCMO,
                                  RSP_MSG_DBIDRESPORD_COMP_COMPPERSIST, RSP_MSG_DBIDRESPORD_COMPCMO_COMP_PERSIST,
                                  RSP_MSG_DBIDRESPORD_COMPCMO_PERSIST_COMP, RSP_MSG_DBIDRESPORD_COMPPERSIST_COMP,
                                  RSP_MSG_DBIDRESPORD_PERSIST_COMP_COMPCMO, RSP_MSG_DBIDRESPORD_PERSIST_COMPCMO_COMP,
                                  RSP_MSG_COMP_DBIDRESPORD_COMPCMO_PERSIST, RSP_MSG_COMP_DBIDRESPORD_PERSIST_COMPCMO, 
                                  RSP_MSG_COMP_DBIDRESPORD_COMPPERSIST, RSP_MSG_COMP_COMPCMO_DBIDRESPORD_PERSIST, 
                                  RSP_MSG_COMPCMO_DBIDRESPORD_COMP_PERSIST, RSP_MSG_COMPCMO_DBIDRESPORD_PERSIST_COMP, 
                                  RSP_MSG_COMPCMO_COMP_DBIDRESPORD_PERSIST};
      }
      else if(writecmo_type == COPYBACK_PCMO) {
        xact_rsp_msg_type inside {RSP_MSG_COMPDBIDRESP_COMPCMO_PERSIST, RSP_MSG_COMPDBIDRESP_PERSIST_COMPCMO,
                                  RSP_MSG_COMPDBIDRESP_COMPPERSIST, RSP_MSG_COMPCMO_COMPDBIDRESP_PERSIST};
      }
    }                      
    `endif

    if (xact_type == READNOSNP
        `ifdef SVT_CHI_ISSUE_C_ENABLE
         || xact_type == READNOSNPSEP
        `endif
       )
    {
      if ((1 << data_size)/(cfg.flit_data_width/8))
      {
        if (cfg.dat_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT) 
        {
           dat_rsvdc.size() == 0; 
        }
        else 
        {
           dat_rsvdc.size() == ((1 << data_size)/(cfg.flit_data_width/8));
        }
        data_resp_err_status.size() == ((1 << data_size)/(cfg.flit_data_width/8));
        rxdatlcrdv_delay.size() == ((1 << data_size)/(cfg.flit_data_width/8));
      }
      else
      {
        if (cfg.dat_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT) 
        {
           dat_rsvdc.size() == 0; 
        }
        else 
        {
           dat_rsvdc.size() == 1;
        } 
        data_resp_err_status.size() == 1;
        rxdatlcrdv_delay.size() == 1;
      }
    } else {
      dat_rsvdc.size() == 0;
      rxdatlcrdv_delay.size() == 0;
      if(cfg.chi_node_type==svt_chi_node_configuration::SN){
        data_resp_err_status.size() == 0;
      }
    }

    if (xact_type == READSHARED || xact_type == READONCE || xact_type == READCLEAN || xact_type == READUNIQUE
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        || xact_type == READONCEMAKEINVALID || xact_type == READONCECLEANINVALID || xact_type == READNOTSHAREDDIRTY
        `endif
        ) {
        foreach (data_resp_err_status[j]){
          data_resp_err_status[j] != EXCLUSIVE_OKAY;
        }
    }

    // A single transaction cannot mix OK and EXOK responses.
    // OK and EXOK resperr values are permitted only READNOSNP, 
    // READCLEAN, READSHARED transaction types for CompData 
    // which is generated by SN.
    foreach (data_resp_err_status[i]){
      if (data_resp_err_status[i] == NORMAL_OKAY){
        foreach (data_resp_err_status[j]){
          data_resp_err_status[j] != EXCLUSIVE_OKAY;
    }

  }
    }

    // A single transaction cannot mix OK and EXOK responses.
    // OK and EXOK resperr values are permitted only READNOSNP, 
    // READCLEAN, READSHARED transaction types for CompData 
    // which is generated by SN.
    foreach (data_resp_err_status[i]){
      if (data_resp_err_status[i] == EXCLUSIVE_OKAY){
        foreach (data_resp_err_status[j]){
          data_resp_err_status[j] != NORMAL_OKAY;
        }
      } 
    }
    
    //In data response to a read request a NON_DATA_ERROR response is permitted either in all or none of the data response packets.
    `ifdef SVT_CHI_ISSUE_E_ENABLE
       if((cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E) && (
          (xact_type == svt_chi_transaction::READNOSNP) || 
          (xact_type == svt_chi_transaction::READONCE) || 
          (xact_type == svt_chi_transaction::READCLEAN) || 
          (xact_type == svt_chi_transaction::READSHARED) ||
          (xact_type == svt_chi_transaction::READSPEC) || 
          (xact_type == svt_chi_transaction::READNOTSHAREDDIRTY) || 
          (xact_type == svt_chi_transaction::READONCECLEANINVALID) || 
          (xact_type == svt_chi_transaction::READONCEMAKEINVALID) || 
          (xact_type == svt_chi_transaction::MAKEREADUNIQUE) || 
          (xact_type == svt_chi_transaction::READPREFERUNIQUE) ||
          (xact_type == svt_chi_transaction::READUNIQUE) ||
          (xact_type == svt_chi_transaction::READNOSNPSEP)
         )){
         foreach (data_resp_err_status[i]) {
           if (data_resp_err_status[i] == NON_DATA_ERROR) {
             foreach (data_resp_err_status[j]){
               data_resp_err_status[j] == NON_DATA_ERROR;
             }
           }
         }
       }
    `endif
    
  `ifdef SVT_CHI_ISSUE_B_ENABLE
     if((cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && (transaction_category == READ) && (cfg.data_source_enable == 1)) {
         data_source inside {PREFETCHTGT_WAS_USEFUL, PREFETCHTGT_WAS_NOT_USEFUL};
     } else {
         data_source == DATA_SOURCE_UNSUPPORTED;
     }
  `endif
  
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    if(cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_E) {
      atomic_compdata_order_policy inside {DBIDRESP_WITH_COMPDATA,DBIDRESP_BEFORE_COMPDATA,DBIDRESP_AFTER_COMPDATA};
    }
  `endif

  }
    

  /** 
   * Exclusive response will be set by the SN agent's/ICN Full Slave's exclusive monitor.
   * So, in general, don't randomly generate EXCLUSIVE_OKAY response.
   */
  constraint chi_sn_transaction_valid_resp_err
  {
    response_resp_err_status != EXCLUSIVE_OKAY;
   
    foreach (data_resp_err_status[index]){
      data_resp_err_status[index] != EXCLUSIVE_OKAY;
    }
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    writecmo_compcmo_resp_err != EXCLUSIVE_OKAY;
  `endif
  }

  /** 
   * Valid ranges constraints related to RETRY response
   */
  constraint chi_sn_transaction_retry_resp_valid_ranges {

    if ((is_retry == 0) ||
        (is_dyn_p_crd == 0) ||
        (xact_type == PCRDRETURN)) 
    {
        /**
         *  xact_rsp_msg_type cannnot be RSP_MSG_RETRYACK.
         */
         xact_rsp_msg_type != RSP_MSG_RETRYACK;
    }
  }
    
  /**
   * Establishes a distribution constraint for is_retry that allows control over the
   * number of retries generated.
   */
  constraint reasonable_is_retry {
    if (IS_RETRY_wt > 0)
    {
      is_retry dist {
        0 := IS_RETRY_wt,
        1 := 1
      };
    }
  }

 `ifdef SVT_CHI_ISSUE_E_ENABLE    
  /** Reasonable constraint on writecmo_compcmo_resp_err to not to be Error response */
  constraint reasonable_writecmo_compcmo_resp_err {
    writecmo_compcmo_resp_err != DATA_ERROR;
    writecmo_compcmo_resp_err != NON_DATA_ERROR;
  }
  `endif
  
  `ifdef SVT_CHI_ISSUE_D_ENABLE
  /**
   * data_cbusy field size is constrained to reflect 
   * number of associated DAT flits based on xact type
   */
  constraint chi_sn_transaction_data_cbusy_size {
    if (
        (xact_type == READNOSNP) ||
        (xact_type == READNOSNPSEP) ||
        (xact_type == ATOMICLOAD_ADD) ||
        (xact_type == ATOMICLOAD_CLR) ||
        (xact_type == ATOMICLOAD_EOR) ||
        (xact_type == ATOMICLOAD_SET) ||
        (xact_type == ATOMICLOAD_SMAX) ||
        (xact_type == ATOMICLOAD_SMIN) ||
        (xact_type == ATOMICLOAD_UMAX) ||
        (xact_type == ATOMICLOAD_UMIN) ||
        (xact_type == ATOMICSWAP) ||
        (xact_type == ATOMICCOMPARE)
       )
    {
      if (xact_rsp_msg_type == RSP_MSG_COMPDATA)
      {
        if ((1 << data_size)/(cfg.flit_data_width/8))
        {
          data_cbusy.size() == ((1 << data_size)/(cfg.flit_data_width/8));
        }
        else
        {
          data_cbusy.size() == 1;
        }
      } else {
          data_cbusy.size() == 0;
      }
    } else {
      if(cfg.chi_node_type==svt_chi_node_configuration::SN){
        data_cbusy.size() == 0;
      }
    }

  }

  /**
   * response_cbusy field size is constrained to reflect
   * number of associated RSP flits based on xact type
   */
  constraint chi_sn_transaction_response_cbusy_size {
    if (xact_rsp_msg_type == RSP_MSG_RETRYACK) {
      response_cbusy.size() == 1;
    }
    else if(xact_type == READNOSNP || xact_type == READNOSNPSEP)
    {
       if(order_type != NO_ORDERING_REQUIRED) {
        response_cbusy.size() == 1;
      } else {
        response_cbusy.size() == 0;
      }
    } else if
      (
       (xact_type == WRITENOSNPPTL) ||
       (xact_type == WRITENOSNPFULL) ||
       `ifdef SVT_CHI_ISSUE_E_ENABLE
       (xact_type == WRITENOSNPZERO) ||
       `endif
       (xact_type == ATOMICSTORE_ADD) ||
       (xact_type == ATOMICSTORE_CLR) ||
       (xact_type == ATOMICSTORE_EOR) ||
       (xact_type == ATOMICSTORE_SET) ||
       (xact_type == ATOMICSTORE_SMAX) ||
       (xact_type == ATOMICSTORE_SMIN) ||
       (xact_type == ATOMICSTORE_UMAX) ||
       (xact_type == ATOMICSTORE_UMIN)
      )
    {
      if(xact_rsp_msg_type == RSP_MSG_COMPDBIDRESP) {
        response_cbusy.size() == 1;
      }
      else if (xact_rsp_msg_type == RSP_MSG_COMP || xact_rsp_msg_type == RSP_MSG_DBIDRESP ){
        response_cbusy.size() == 2;
      } else {
        response_cbusy.size() == 0;
      }
    } else if
      (
       (xact_type == CLEANSHARED) ||
       (xact_type == CLEANSHAREDPERSIST)  ||   
       (xact_type == CLEANINVALID) ||
       (xact_type == MAKEINVALID)  ||
       (xact_type == ATOMICLOAD_ADD) ||
       (xact_type == ATOMICLOAD_CLR) ||
       (xact_type == ATOMICLOAD_EOR) ||
       (xact_type == ATOMICLOAD_SET) ||
       (xact_type == ATOMICLOAD_SMAX) ||
       (xact_type == ATOMICLOAD_SMIN) ||
       (xact_type == ATOMICLOAD_UMAX) ||
       (xact_type == ATOMICLOAD_UMIN) ||
       (xact_type == ATOMICSWAP) ||
       (xact_type == ATOMICCOMPARE)
      )
    {
      response_cbusy.size() == 1;
    }
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    else if(xact_type == CLEANSHAREDPERSISTSEP) {
      if(xact_rsp_msg_type == RSP_MSG_PERSIST_COMP || xact_rsp_msg_type == RSP_MSG_COMP_PERSIST)
        response_cbusy.size()==2;
      else if(xact_rsp_msg_type == RSP_MSG_COMPPERSIST) {
        if(cfg.chi_node_type == svt_chi_node_configuration::SN){
          if(src_id == return_nid)
            response_cbusy.size() ==1;
          else
            response_cbusy.size() ==2;
        }
        else
          response_cbusy.size() ==1;
      }
    }
    `endif
    `ifdef SVT_CHI_ISSUE_E_ENABLE
    /** For combined Writes with CMOs, setup the response_cbusy size. Note that Retry is already taken care. */                     
    else if (writecmo_type != NOT_COMBINED_WRITE_CMO)
    {
      /** only 2 RSP flits will be sent, so size is 2 */
      if ((xact_rsp_msg_type == RSP_MSG_COMPCMO_COMPDBIDRESP) ||
          (xact_rsp_msg_type == RSP_MSG_COMPDBIDRESP_COMPPERSIST) || 
          (xact_rsp_msg_type == RSP_MSG_COMPDBIDRESP_COMPCMO))
      {
        response_cbusy.size() == 2;
      }
      /** Otherwise it will be always 3 RSP flits will be sent, so size is 3 */
      else if ((writecmo_type == WRITENOSNP_NON_PCMO) || 
       (writecmo_type == WRITEUNIQUE_NON_PCMO))
      {
        response_cbusy.size() == 3;
      }
      else if (writecmo_type == WRITENOSNP_PCMO || writecmo_type == WRITEUNIQUE_PCMO) {
        if (xact_rsp_msg_type == RSP_MSG_DBIDRESP_COMP_COMPPERSIST || xact_rsp_msg_type == RSP_MSG_DBIDRESP_COMPPERSIST_COMP || 
            xact_rsp_msg_type == RSP_MSG_COMPDBIDRESP_COMPCMO_PERSIST || xact_rsp_msg_type == RSP_MSG_COMPDBIDRESP_PERSIST_COMPCMO || 
            xact_rsp_msg_type == RSP_MSG_COMP_DBIDRESP_COMPPERSIST || xact_rsp_msg_type == RSP_MSG_COMPCMO_COMPDBIDRESP_PERSIST || 
            xact_rsp_msg_type == RSP_MSG_DBIDRESPORD_COMP_COMPPERSIST || xact_rsp_msg_type == RSP_MSG_DBIDRESPORD_COMPPERSIST_COMP ||
            xact_rsp_msg_type == RSP_MSG_COMP_DBIDRESPORD_COMPPERSIST
        ) {
          response_cbusy.size() == 3;
        }
        else {
          response_cbusy.size() == 4;
        }
      }
      else if (writecmo_type == COPYBACK_PCMO){
        response_cbusy.size() == 3;
      }
    }
    `endif
    else {
      if(cfg.chi_node_type==svt_chi_node_configuration::SN){
        response_cbusy.size() == 0;
      }
    }
  }
  `endif

  
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_sn_transaction);
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence item instance.
   *
   * @param name Instance name of the sequence item.
   */
  extern function new(string name = "svt_chi_sn_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_sn_transaction)

  `svt_data_member_end(svt_chi_sn_transaction)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  /** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
   * Obtains the configuration from the parent sequencer/genreator if available.
   */
  extern function void pre_randomize();

 //----------------------------------------------------------------------------
  /**
   * Tune the attributes post the randomization
   */
  extern function void post_randomize();
  
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_sn_transaction.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

  // ---------------------------------------------------------------------------
  /**
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  // ---------------------------------------------------------------------------
  /**
   * This is a temporary implementation till we have is_valid() up and running.
   */
  extern virtual function bit is_supported_xact_resp_msg_type();
  /** @endcond */
  
 // ---------------------------------------------------------------------------

  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_sn_transaction)
  `vmm_class_factory(svt_chi_sn_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
StOFaka5Iit7mhDqM5TNKYbYK2+9O8dCWLVt8qo3DRZua9J1CuOuerqY0RzxZnd6
LcQRQnPJHODrUrlL0NSRRx7n+6zH7C2ctu/6Vcs9WdctuaIjASyeIc2C8o3Mc9tY
EAPQmLw0Mn1kqx6VSYoyLGJAUaotUgdsX19dpNeBWPY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 968       )
IzrbqiEIQ0QcfM2Pd1Go06xLy/GcLJL6awAxztOxR4vD3jBFCo8LVL3pPG+VMDk6
M9F+rAUUxoBGKEdm7rPRKAj692IAF0Oh5hrpd0dW8s2E11WzVhNgkw7x2kG2bqAf
KipIRsJJbembD7SmIklSuQSUGzisySdT7OlGfSpTp7J8sF+LI7+BVSbk63tVsvus
CArrU+/pg6j1qSABgHoU2n3hW6U2zfFAwYPLJiIJ6HNKEEsNLj1iiBPOOdpFzN4I
ieqpW9HxnyYnUbQC9jgIy2xXphw+FVx2rYxrLiB85pQNgBkQDlUjbJeVTUb1Rkjw
bmvTcimyEv66eY18VoFfWc7Ciww48EDXYb1kfq/J2ZOjniI6SBs5E9HjfrPfMIL7
hKvfSGEqkkqzNbcW+zLc1vLKxRD61ErJFjmc46d1HC+lgl5Y8tHkoqc/gr3weN5z
1SPmLLmjxZBNyVr+FL0RKkLf0dB7K08jMMrP1kNCx/44URcLSz6UDEJdE7IxvMLZ
ZesqBR3tXAw5UQ2cHNYwbNSLgpQ9AbAhlOsH90nCICvfo7dS+I6DJOLtlMRT+UfV
Z7j0R1NXEg6L8383T4DRaNNqIhxWI7ZIRnTfhUL9AQwPkNozEs+F3uxiDq4uXxkV
7gEAuQmqOCywPus7roY/ILq8IpMBj61OKH7YopX6GTOutg0QaSQanzIp4sUaprcr
w7CqCDDxaY+NFg7qkSF+3+FgudUHedWyBARqeT8LdxUJN+yEQ0MZbk/2YsScfNgG
6haoMd6URrb66R15lBYGykoIwISqlqiTvx6K15h0Mz33qIdByoSu5vAa58NC9wt5
UAXm8RUjpbHanVmdpCtMIuwwdp5lWTaJ1nhRo7oSkJSg+BngsVTgObymxid22v8k
o+uw1ADhJCgAXkwy2yTw1DgG1U9yykrfxYMPJx2t6rrAqAbwCZazs7gRePOtk6Jp
fo7KxtHAk3IyEiXXRh+RuJ3HGWKS90vw3VtBA3syUjPMupupbhxhn16mEbt1mDr4
3aBA9Ypmoy9artBRLo3+uA5adsjaH64F8Yuyy/qoOw8OqTf9omQ24cXyGqkUdnPs
cjJWSHm6cIm9zvIxjPDtknq3OjcYhKJkk6dmvMNdjjtCzzZmIR3Od1RGth1bcLbV
Da2/Egq4IBWEfnoTEfy4SJr9hgrtIAgF7SL0D3JaYSDzGFiB6cz1KjOVteYuqN94
8Mpg0o5irZfKU2IUcCZdEqb6rHhChDICvkpjKOJwQ3Gxuq/14mTS9OVukIAKVPAd
kAB+VHrctz5NwjtpMYmYzw==
`pragma protect end_protected

// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::pre_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HFNztloqWGNWQrH24JubIB3x7hhKOa9rYeGyQ3I267mfHglQekiIBfTJgrVszrVW
CcWMeqwbdY4USu/+iyq7iwH1qNoGE7PEFgfSNuQmfznOjs2r27I0ik1sc7r+VMcb
FTp8A88/oKtsJCkQY5Hd6omz5g7b9SU6/myTHqVmPAQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2365      )
xB0+iBHku/cJ7tyYNRZVRinLjMb+EidAs3YBK4abhGbwuDsiamPltetnIjo7W3sp
xOaVj6GTV28dPrjwfuEahIXV7JwjP0eGDgBGd3XNlhKYX3dyhhcYkFPW+w7Msk/W
f6Iy7tyuDWmgk1/wOoMsxHAHFiIm0zSIoHTkMilEj5xpNNBBWTL3KygDkeRMGojy
73+b5P0wNjsrsmdQgeAqG7jOEpRC9H5umo7fO03XyhBYqVkCvmcJMrIcNgsRH078
sRpW96yp3seqSaeZXuj9lFLwJH65FJgzA+eRMVY3AE4kwS0zq56qKf83aey0wTz4
CWgVTh8ZcYv16pXG9vxcP5PD+6d0QRn9oYzQl5quPmYk5cQCyzmblgehLTSwEtWX
4aNMEx7CLsZKYwoq7knzbq6py8+EchuBVh+yhfe4IT/lsqV/+KVEEtUCBE+3PJwk
lPHVQXg1mKjEfJZVIpt7Dd+bREil7BT0Rk2kCOKx1ZZIV5A8AIH+67uuuDE+xF9z
tEux1g23tbHSqBZiwqrgWbY42qh4S3m/JTOCr43mxFo48V2a5N4hrBi57b5lKWNR
J2oHuRjMXbeICwQg0XFW/WRQqqtlHO2HeKwqUw3tieE9MGYc/RmWUrlrlUY/RaMI
FDr4vN6jPMWS3pchrZ36m+oeFrmRgXVcYWtpGzVJd+E3KIXPbBNY0Jm/cG8x+Y5l
M44WozTccq6UHJSTAvarEhUdvj1kuf/s8EMIxEyR8DinBQPvauVphmTIU4E3vOfS
yJy/AO7qVQ+vXVd73B3DOg0VDQP4OdEP99x6ZpcUUNN+nnmTyUu1H2tejNhZv44q
qVDW7O+7/5kQgF+cPxrYJyvkOg8kze7tBWrHv+X5iqhGI3QHWwqHRA4hfmd1E+JY
cEmKZK44t1Rc64dNLGvNbvP5PDNg9MYd1awA74E65vSx+XyUUhjJYDfBQDQ4mMFT
s3/o7A6ETjUzXnAP7gmjYIB6P8PHQMjt6IouqXYA4XKJrTAmaFXfqGhm0fBPYqr+
ellZoA3DcJo99gCRKWpsvj+lqApEnZhpOwB3qI8Z96s6nOR78uDQczdOzzhQSHzO
n9E1Y9pNMIJNtd5dpJvs+3xf4otw/BNqBRrkSOwOSQ7P/VOQo1pD3S7uBdhyXhLf
VzgDvDv+yvoq6+uXvfKnXTd7hyDzFn41pqWFloYUcYFKQtyW55zDgPY14j9J8xFi
aTIRJku5Mchri7Po3Vs/QoIWRa+tvlSJ7GAijLfjZZzW43OlNfMCyQMCv3n0/ek4
LWm2bzcHxu+yWUkB7xS/vkKc4CodkP4f32LfGiRp101fEa6QM0SfA2bdjcjDKmLE
KuEijCOI89M/zJYlYRUzBmhE0X1D5rTxz+iNGZ9/zENkLz87ickfTB6OEME6b+5s
cfR2xUiK3I8RkU7TsteMo5nF5pkqZuxcGWeNS29EKS7deV8a/spWLaQ4VSFuLjTE
ko4AnQzikkX1qlqMd9FAbF+qepH09uXLEG5s4HlnRoh+bCxV2eaF9AcY7FoVjuWo
IjNu65AyfQddbExF+gIr3d9kkd3MZEsJKd7j1VyqAnxZoXuu9+vOhp4SoJHBeIUW
s/8cJs4tWtTP9Wik4OV34wlLZhGjWRDOY7zs96BSlXHfNV3i8Lum6q+0hrW2ZwQb
ZLOLp2VNVQodPW/jUYUuEPvaeYCHsmJiE3u52NQZFt3Jfo/57W2x2sbCjWiSCgTb
vmNS/X8P2szAXERBypBsstkXvKemRBThWL2bDr8W5mz6spKmirgKEhDGnh0C6ylY
2ZkvTysYMT8w1V/9XS3is9lOrBjAD7Ihq6EuSZscpQrjCeNATT3abehkKas90Rw/
tXpEkj/nKrpDjBn1O2y41w==
`pragma protect end_protected
endfunction

// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::post_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gyb4WvS1TEGVvBt5FjomqOr4xMF9hgFgUysxL5vH3BsNjoQPxyBAXdQFPsAxFgv/
qClYj8ZM6vnkRaCvUPdEnNwuZJXkTeepICRI54hmz9mZBxm/QEttBtyxkR0chlhj
Mf4wZOjitnVaKVXGYmbz4CK1Zj+DFMY/lENHbO9f4p0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2674      )
EMoU+rN+DHbv0DGb9PWq6Imx2yRc4JGiBqoD5H/bMBxVW4ttzaNvWCrD9Db+oGpU
4Rgh36xCZXUmOO9R2ol8TURbxju38bC6D0xGUNFXpgSe4WktuKWPRugn79XNKQFB
KhqKr+kyLgXlMjXkFM46ZWxJtJfbCc/BT0hKZY6ou4kHPldR57WgezgD8PCvjgIN
wC6tSX1XWjJ5gTBGNdqeleYrvkvSOhCXt2zJ0Qn47tT1phqUUp/ywa38JAwmHM/E
NJNDHDWrpfSNJi0nqrUuVB56FvBDQfrx9A415oTct3OmXJv6HrpqkSET1W3yfA9E
hn8QkMB/8OjMwTHW4PAztS/qChHz6Fr1SxIXJvObjJx2sNYjscL84rxunH5bkMeK
rB9xa0X7wmWYPGaUSMsIj99WaA6TVTAtDZMzrQpk5zw=
`pragma protect end_protected
endfunction
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lVkudJxs0jBu4PZNzJvLRmdLRxldh5e3IbZzeixH1bJKNgXvlpXC0SRyvXJGpSU5
WXzC7Wyb825Io5v1maw5KgM/UhuBiEKD+BObIBwLN/WNA8mNMmJo4p4tfXIUlAnX
mwJ5Rqy87VmDq/ztO8Hf0w+1IO5nd9tw1UpCane48Nc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 52637     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VIInsjOxMprL3lbjMKjPvJ9VM2P35MJv8hmsTesqhyDfwkn013/Vp1qo1+rZ3ysY
qSnUynU5g+tLLsbiMIpo40ERYCmVKz59S8F59N9y9+mhxke/1W/RIthFggyg5ttW
UO0kfABpbGP2V43f7IbFAkDqjY+u1qnet/ZY8A48Poo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 52720     )
u3XJ8IS22p6zHCBVCzeSghBkcyj7WGDt99aRX1w8Cl4YKMwK4kGJE6TJAhYQI2Pt
TiMcs4KQ8XLU2yKNyLdl/pxrPHa4P+kyEzw0CU2eiRCUpcomfmCFDrOTaAvHIvX4
`pragma protect end_protected
