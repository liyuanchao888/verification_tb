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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Gbs60VLEF6V/usYenyO1I4rzTy//8o2m/zMVdKIyfgBnCPS7Fh2fHH4PTF2WqOAL
BVUkGcw/8k0ylcpYrWhR3ZikoC9MNUBOedVekT9Wp+VVzIzGH7Ffqj5j9GD7BeIg
EqACKhXKA3Ph3TH+nmjWj43+Z8m+XTaQL10UmC2//dLvOvoYUle+Zg==
//pragma protect end_key_block
//pragma protect digest_block
eIHpCbmc6lSiRLPBQlxzXj3NfWU=
//pragma protect end_digest_block
//pragma protect data_block
QEM/+N8An58vErf8mToFnAV44hHhjp6/RwGDzEURY0iimROiZnHeWJnUvJIAB18T
7ZEZDv0RMg4Q4QxKWTAsEPVkS3bu+zbiFmaBVJoxSUptYXFroYpn+J5rJQBMmmCw
9+TckUIm1HXgSURVgj8AGLo3sw4Rm6dPhZGC19NYh6IKuyqOeJhWkQ/W6PP8fZQH
h2Cj70CDVTstAKuzK9Ji9tHwP8WQ4wT37AIz9ZO9oaNo0O4g+U8zN30fBXsXAw1g
Mdzjo1qqktMIhOmZYzVJBi1AyYSvGQwLO2ShDhuwH4XI2qb9A+zMmoL4VrKqbvEV
eF+1OWWBBSGtekr1Q/XRT5HA1NXuV14nGynzCtBImqGmo9cEnv4NAalk80hTjQ0U
44rWdpKfMewD8s8SsyXYhwy/SCfIHq5R6GvuQRKbNGOU+tAdIr9R0fzhi71AqTD4
kjVh7kxb1Bez8hNdsbYsbJ5ecC6OzBSG8Pqm9yIVjm9hHnSS8q1xSZDQirYm+SlP
I8tj/qik4+iYR+NxG3BRNDFJrz701aEMEHFx+21zQqF5KlntCRRfObIqvOPK77cd
GYushgV13p5vgDPJbkGz4nNxgO4cTOj4GO4TUTJ9ulNA/7m+ybI9o0uoCvFoOa7N
NtXfW9uGPygmLOZAH5g4En7aQsODa9p1OufU4gpvg6nSBg6e1Dlqd7rCpED52fRh
nA44Lp5nLnXWecWHtDc28d1hnyf6RHqntOI1lPVSQuvaYqMcHYZFZZ+xRj0encSD
1M7teqM+dcYDhFyuCBEPu1GYX2lg64u4YbAdEj3c0rXJLS1H9jK3VGhsV6EuIhko
AvMKLNESMK2smIrrNaEAe8U+k0gMQVa9UY5GWqCjSlkzRLXUOqF4sxbo2wjaRIdZ
dzrb0/10VsOFupE+fNQQeK6hZ0SFnQIL3MZcP/QTYMAG9slRay5rhhwu+QSQ8wzD
JdNu3dlDz+H6L5dbiVTm2z28eclwTBssO5wY4ZLjD2kwzKx372BdyVeQUfBzuJj0
9nbi9A59RO4F/mXUJHm4zVdWgie85SVfv2W0/RmT3ZqYkf5xNO9F7pPX72Tkc6y4
t7n5ijG3MGXhTz2ITeXbFFFyAouzUsbBbhk+3kc/ELeZ02Op1jF5erejq3UfI08Q
Z93Fto+STWVS1Y82bRurIPUz52mCtI1recBEuYCCbW+j/UOdyFP1IKy4w7yoNu31
pLOSc0LUGqoKeMcHkNojp6fmZWEpPp1w2KPCVAuCu+3S5LICjvr8kuDE9jbt1EeG
Ag+z3SccINEBamnLkEir6VjJbkCFcsyGx61JArkYAk9IzvW+N0PcwHua2+sQ3y9s
nES+QUVp4ccJWHyBMYWxKHGLDGn/w5AKz6kYqnONjV2Tvep+DrO99Ap7ZgHt3+wp
RtjEjqDkmZcuD7ydrDhoiuZrQQ6WUasN+z3XTjEQsnFN2w/P7ETpDbrVmyLYnPLR
AnJtGazA1MwszS8Ez3dAFAIpVm4msIBgqqM1Yz1obpU=
//pragma protect end_data_block
//pragma protect digest_block
WnBhRqQ2nMZRgM2NNlQUtjrdQHE=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::pre_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
p1eXnKqs3iE7pGMDryndxbgitB31/yeEXewh/ePmYF6GdN8KlvqsSamfDVrUV13H
zLAEF9jB49MGtWgDQu6tH659AGqizddbqyxyD+F2o6K0/doiRKYV71LeJ37mdbrd
MpWa/tBPuL81hXWv92dRaWCS5DPbkoE3giwJRABgZfKgC6Psdkqc+g==
//pragma protect end_key_block
//pragma protect digest_block
LRQiA7XSHs66xwfN1jfQHxCSqoY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
RGzstRxinfbpbC53SR4pQKnMHk4=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction

// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::post_randomize ();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Br7pW658sq25DrTKOExf4+B0kwn6wV0tFz7rVsHG/+hM+bm8hfzDsbbarmgGK3Tk
zX2TGHYBeC84xvBTBp2mvr/4OQwT/eDGbrL5VisHpNHFThCFfaFIaHa5P14EZsnv
kPjHV17ao5u3jNYUO9wLWOWVy299YIndji4OF4kUshf6LgU31P8y4A==
//pragma protect end_key_block
//pragma protect digest_block
cIQuhPgB5a+kvNF8t4sej/Y2ebA=
//pragma protect end_digest_block
//pragma protect data_block
5mNpGhfHIhUV9uSY+AjfXGgOFpRq921TkVi+hyTz5/hv1ClSqHYA+PG90eUJwgoI
w8gcPbbFvWjy1Tfe76t/h5v3530kpF6hrrNaIkiK30dtWIg4CBAddinUAt9wj4vF
70LhTgUMmi6I+h4rgy0/s3bHDK3pCUE+yEVTt9yHWqk5m5yjOdUVWK/HEA93mBLk
p2SETmvS00tax9NmtLPKL1girKkoR0xjyk2BWZMLgSJCX6lwdooSyAnBm0kaoV43
CsjcAL9i1Zx9Ny0SDZEo/1PqEa4VJL+Fa7A3flTGeLpBmXR1w/t9ReTFRlqWUlhb
5faH92GqjaA3G6Hpv8VN8G7xzUVT8ju+OIzENLpoHG37X1hQfVtvvnbI9+xNeGSB
RjUKZ8TrkvvmU4753ePVfo2bBCoIFXu2ivSo9LlupVOyWIBvEcagQANlEkyzJKSm
EuIchyNUJyTmm+ReOXPT0SInIlPVv9WQhNebBz87KL1QW/clXIk0fwFzQwS8t0vf
QAWQozWLtUvDZk9gyPQ1QudOAFQ/+CW87nxgWXG/aASf/0iiKBEIsEqhaN9uRfk7
gsao9UffQg+y+jaEXIlI/+H6CyZa+NoqLttNRN3oVnHznkZ/Gxb1Ja+jrTofy2PF

//pragma protect end_data_block
//pragma protect digest_block
3f2ARDh4gPqGXuADFr4FRkxjraQ=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2EsL1pY18dElva4uda3lrRDKYk3JEgLzzb33n17IyG9dadSA6WOj6OVnBydKEVRS
4jex1ir7j6iyzj7h8kis0EXOfFMIhnMDgPx6ElTGtmFS9lgRsZaKTRzI/uk7ZBXc
VzSPlzbPvSw0km4TcMhlLibL7RnppZ+0P1XhIp4zyS3aASNVR22d7g==
//pragma protect end_key_block
//pragma protect digest_block
a/rSLhA6lfEgFhpMl4dTAeKuQcw=
//pragma protect end_digest_block
//pragma protect data_block
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
zT3OjsvA8XnL2l4T8xuC8A==
//pragma protect end_data_block
//pragma protect digest_block
5oUiQdeCGQFyj+lGBDI5BEwiN7o=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_SV
