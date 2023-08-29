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

`protected
K_;Sf-XV11>:QU>XdW89bMBOL7Q&BX)1G8=Qf3bL&acP3EN]0Wg15)#BNJORM[5-
=LFM[IX]3<aFbgb:U.;XIXHC#X^X/P/STA>e<gEKU[NQY;ZOJa054\>/1=]6f:#C
).DLN@bSXOZ-RJeQ#\a\HLP[V8<VfKO5<>UWTeXgb#-c\Q.L6=N(-2W,XPQ]TT6]
BLBJPT[=C.;V[9B,,O8YM&f642+&d<MgOMYfcAbCG5JN,=JeFAMI&6SK?=/&a6O-
0A2>TWFAC=X6J7#E045.f@dUN#T4g@T1REO8J69WY/_[:?:JX2F@R&9?N7?=IBS3
1VREOYA,(e\OcVJ9bg^6#Y&&+F^Id#\OSF\MY,De2NSWG26(A1)Ad]EJ-g^5R95?
G/U]ZXAdc1UcRBK7g9+V09#T[F>5RL_KMU+<JS6J^)fUZ8\8E39@UOE&<#K,0(T2
8XF#b0QSa@5C7[M&Ha-_4_J8OKG=Of)O/gP\^2(W0aF[\g+NB>]&-c0CPEXPe1]e
D_0[YP4MWMBa7Z^A0.RNKT35C:O73:7A&BU4#N)c:=O75Z<O5M;f693I<Cb+YO<M
FC_/&JRf]_US.cLIf;/:HU7Q+OQeY-B2D;\_7S11+C()K);1)L@F6.?1&E7B\BeZ
7P\gO@Jb5GB#9L1HASVO1AVX&,?]WcTf?[WVAD<(e=65g#c^;TRYT#+4cg(]SO[b
dQ&D4DMF@,\6L)11++AN=1?Y?PRaEG8&WaRX@@GaSS_,Le4X-?X6#5;1Hc7MfeN+
\I^@XPb?UR#g.LLMLg<b<;6#C5AG#SYUQ,(CP7;_YA5T8<74_1Q.9(Jb?]7QH=&;
d3?;HTC/66[0b-<_+5<104HBcV#+]ZBRVL(ddEL/5Ga[9;2b[A-9cU9-Ra++VE+c
6/Ja4:?L:(0#/FT56CePQWJ?:VZ:S;\]/+3/c<_MaZR[5S;:<5Q7(Y]R#F(a0;5&
[E\\9>NbYT7c#XSI]9>TV^EO5SPZZ6PZ]841I;&,M3+5?e,ER637\SaCK/=U#7[@
,]f&8N#_OT+O<QP:?0fRFfSMYV+@P^FXBVV6+0P]BY61>0CI@=96\BaCK$
`endprotected


// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::pre_randomize ();
`protected
GfO-IS3M:9C+_5Md:ZF0<9_1G;>;I>13:XRZ7CEfGGN8V2e.QJF&4)+JQa\(X(.^
BDS>gSFb6F1eJ0S/aVgUW#8>-gJ)C#5b:/\P>U=B\]Jg[L0;M/M\;8SZ7^Y@<T5e
#R-ZW2/1e&+GaAYA87LgIHW]+Je7:S9b_e^Me=Hg=BEA&^DeWgRGW-V9YaL7[T)X
/M#K)7O=ba]_V-Q34LNecU99O#&C./7FgCcP:8._@9RA=e>[@?b.GU))N5+T@H7S
<+Kb\;P,&TFN&(:0-b<g>I.<S3E-9A[#Ab^J6ec9ccb\(fPZQQ7,=VeD,3b<1H(<
ES?I7,(::A1N;([[bX.Qf9]6N_gQ49)5M0-9UK3f4H^++=NgK);-(Q;+&CH,+C.G
:QA,.)]126c8O6bg@X#f\T#eA]Cb][@T?0),;c<8)/cHeF00:Sa@L=BOJ)S9edf#
NOV7==;HXDOIIPS=5cQ[&a8B9<HP#54Efae18?WXX/B;_.[[dPN^WKSeVa2^Mc&c
L,LRX[76\YGP9OO^E0WAT.C6EV/Q?_.Q6;9\Q#QPZ<]]C99V(Z0_G]:8NE06H5g1
J->1+b#?M#UMM;>LHX/).QJ[e7>5X/B(UEK^&Z4T:0=9VQV-2B>3[I0X3B6e2[Aa
-L5U)]1.<PTUEVE3T?]F17/GV;48OcB]#1f0W-QR9WWMGaR+W84T<_ZgYd1:ScD+
d:Y@3JgO4HRae<6a+UN)<D(Q1[Fd(/Jd,UN^Wg/]VBPVUf=BaNZWZS6W98[e6:dX
9HA4AT:?PSD-eK_cJR-g8dQQ8KYd8XXUB/&\INRFFK^]KNcE(4CYMgXX00OIf..?
28_=DP(PgH(H&U5-eL^LHe=4:]_(SdLZ5cF&#OU?]8>Dc/5gQ46\R;MT7Nd?_8YN
1Qcc#V4\@#>1#;XKMP+,1W45,,<3aPS9#(PMQ:-C7\>(4-MO?@\+EMVR.Q8U\/Nc
.WVa/WK)VO?d5VDVQ@^G2=:HT3[;0TF=9X_O9K,gbO5LS0B[cW&&/;NNA+:V)^Ag
X3^@NUN;D+9X<U[02^Fd\6M&CS;S(60Pd=g<a:\+UaMFVZ7D#?:^3;P,b]ZaG2PO
E3QTQa@-a_[97aH]Gd]B(/F/N?EdN/fQMb_D#309CL_5EddX5cOeM[2<fQ3SZ?S.
D=Q.GJU2P.;b1FF(TQ=Q\)7f,W0#gTe0,X,NQD/9&=;O/RYB:V8^ZQG6L1d,9C6N
aN>03+eJ=09,U@9_d_4;C,(+dX2(=7fM[fXO&0:0MMBfe=]0\1D.TN#;RV:Ef53_
_bQ4L&A74@KVf:Z,I#^#&H/)dAYS+=]059W>M7Q:[eR-<P5Ae(D)P#:f[OTM-6/g
CPe9\.eYA>SHMU,Q,+.H)UV<a\g.</CP;<V#68>P?Q6F&2Z?],T+NT@MS[K,0c4)
6SLfQTHI6N:D;E.J,B(A34MF&-P>.\-JYOOF/=;[KVe@/a2OHK36RK\:feC3?a17
-I0P9.)JRAd-3P)IX(cd&RBKe)SYG>W1e=;AB+E@O=f9eCaY[M=3WC)S++QV?UQ@
KaO3O;Df:D2RCQ(=2,\SA?38Eb81HT:Ec.1eE0R\eEe^,c./CGQ7GY)SK$
`endprotected

endfunction

// -----------------------------------------------------------------------------
function void svt_chi_sn_transaction::post_randomize ();
`protected
Z7(1@Zg-Tdff6A#BW?>8=YKJ3<C>\9@A;[955Z9:AO@X#8,8&98B3)[TGF2+&WcM
BaXY+G^FJ40S/7#GOA[HJ?Ge(b_+9-LN2?;2M5JRZ#RU:F.Y8^H8_,Y,IKD#3),.
K9]C8BB>E/5;Vf+ONc)-PB[LV9(J@O91:TbA?1/]\3ULfW[21Q_]>2/W,.gN2&b=
C89@Tgf#0OUZe+=5_4X_LY^A:0(.RIY8,K02c2M4Hc6aVXVXBT)K1AUZ^&;(&/Y_
N+,F1\:,MFD-T+@S8(NFA-6Fgf>T_4-bf/H(01H9<I_aH$
`endprotected

endfunction
  
//vcs_vip_protect
`protected
0]d]0EUB<EPQ?4+aJER:9.F/cDLI>9P<7f.EL(\A6Me4>1c-fXe<)(\ANE8+0W>H
>^WfL8-e/1UTF=2;,5CPS5EHTW6/b/d2fZ54_#VN<6@Y69^..4L&;AL7-E9g3#L3
+.FH\gNeP\aP8;X-K:G&KG-Y>3B]>.[NfLSC<EV&bNKO3)W6c+6<I_83N,8>fK:(
-B(RMf^C,76PY5c,TASH:UgE+#/T)f_0([_C7C-N<847dB&8BC#F#H)gW27&G2c7
H3:V5cdFWEf;,a^T+Sc+(RXa2<g@b@OCS9UZR_XDYBE\,V1);<11BU[&+3W+?NJe
.BWcUTU629#VV(AQA]eYE?A8,Z(KE_caSR(@].cM:2[(d>Y5QPfbfO=Y]U@#dbV5
RZTdVKc()-F-88@IDM0OY.^0Y/D/<-A51+3H2bZV<.\Z;.N.PD&#T#((Z:0C2?,)
Z)K5#2+F:G(6G9QD#-R26MCM8W\3M(_<J0GGL^<F(2@^&BGYGdN9[M2H9NN)f>5:
]MV7C5O,[]^DgGY[[96=KAM.^GS\(@B-::68CNL;.BC?ADc[6<+R7]OXV<?6?7;O
;GD_0b.L\]17TJLH#d_.JeT.VLeV>.[fSD(UM<ME[@>D54KDBAf(feEL4,T,C59>
Qf+KDgR+)BRTb&[KTRI55:EJ-GCdO@IB0BDO\[2F;.5&9+:25,\H7HM;YX9A&gf;
Y-F)UX8CA[4=>:.^-U<N1T:MDHb#d2eg2AF:^7ZFa@]7WKDB2fbf)T<I\9VQ.+Ke
8Udf]QF;B)5H+V<7,<ZU6SQP47#/DPER-HAK?DcbNS@QXeb9Q/3[VFQFHcK3XQNK
)20PNU(/LHKP\bU5I_[.K9XA46[(07WI]KX_O1cd;fSaY9ZfPg5;[afIIINb;4.N
NT-S8LL.fE5f6@&?9=9)[O9GZ]5GN,YE3ee@G3Q4I3#=\JN<JfbG]UD0#9)54_@>
Yf;46Y;aL3+LQ_5=NQ>K@RaDZXcC[Za5\\][0K#0+>T_@6>H=?M:GVCaeQ?+M3HV
Mg\8&Y?gECFX0BW]-A,DB]=_U@^EU6Z&VdX#ee:+WX/]KUV[)-T1VeIF8(9eSQF>
TIG&_<WOdLcSZK)(LQQMTGW#?gCFBA^G)A=)b5SLVJ.PY]f3P^0\NUW5(;;2.,9O
.JQb4-A(YO:X25:K8a9d6P4_c<Lg1c7g4S_S5;d58C5(DBVZ&AE-a2=0B5LF-8bX
#[F-\@Y:[H_bQ^^/Ia@B)3-RSB6^f8C?Xg-VJdARLPS5fb:fC6c6Q0:VJ6C\Pc?Z
_R4VK[8W(8V-8g(+=<2.L5)?+W<QWe07WMQ1.XGJ\,/_VffUA+/dV+3cgB1R8QW=
:;TXTgDPJWFK1><J/35SA4\g@A)?a[UZHebee&86a:S66=:<EMfOM=M:6NTF?0P_
/RDJ+W@/L4ZA?7)b_IFX(<>7.+1N.=^+JAK<0X>@7R.6A\N:OaB(XWX/UM^-O+Ld
L5W9+8b259)VeGU/0(<D\B^:24#<#,;7R53Q-4(N=a\/C;/F/T4fA?)bG@4#(gTc
-?O9MLFM(:ggU30^8b^EQ_)W6XE\?TCNe#=:&>^T?[?#/=2+ZVH[/+.4C7MEM=?.
^9;f(fZ5HF6++CM^X&?^S>7^b2JAIQROGMZeLdL98(52IM1UTQT/S>/)cXbeK0e(
4854[:K1XO^D1WS=YB7eXOVB;M(VN40._B\;@E15/(>+AIEJc^LJb-2fP9_V4<b\
VZ>^R)U7)PKG-+:GM5\99&OQY04d29I)<.5^[9:A^?F=;)B6DB0d0J@]]CGc<,Ra
:VT8f4CJ)SK1;Z^Q4Ne)V5-.JP;.c>SQ,e\853HX++I7B3PHIM;+?Ob[J9^&[[/Z
WM7bQEDEB>()TeU;VDe@\:dE@;,79QD9D2_J^MC[6.LQ;/[dI9[0HcaQG76;&W^d
]Jdb8>C.6V)^80)XQJ<2V,<X=>2W]7O)/)MF:7dD+VV+]Ed(@5/RHO#T&b<8)I1d
deJ1LdL\=#[H04-3\9LHYHR:R(BNH&#NSHWJECMRfZ7)C[W_J9]5WL&-9C3:9Vd<
D1,IT\\88b23UX>7gOLAUG;)gGGM-=LU1+:L6c]]7c)7g<Eg-_U6/abgLGKXN-9@
&?e-g/9fF3fVb;[HLWFJ6A8_@I/L,\-]GE\2RC(&c9Ofa]&UPV3I[^TCSDAZ-86@
9fL1O7=X6]aA9#\9&4b\[A52ONf2eKFNe=J/<HN1L]0X)3-C9T)MbQ.fXfJ6G;BX
70Gb6@c_;/LJb1e2,fcISGNUaP.RYdHdHKZ5?&cN?N)\TY0EH7LWWCLFNFf-^dY,
d(I&1+/:Z:LUJWN/[(g/b.Jb>8:IDTOg8@(U;=WB-E0R1:+4PM=3a8O_&LIK#/HU
@A+cdQC2Ne5UK&X;KXc&5DMb)bc+1B)N3+KcRCE-Y.=CCTNef=dSNe&NT[\<&F,U
f2Q3K?NGeN\4Q\b_ZVVdCb.e\2.OP/,f_ZZYGYdLD^8W[>@MTQ55eOOI[.H8=cCF
J:.-e4#fFVS.0LN-<b(1I02ZY#Zd2dYJc+R@RZe?;T2;=1GSJScdEGF?3F?E9GbF
T^cS^A0GeFV5S;JAH,]_OdggU3ee?02V#[#NPH9P3,;CB>JVa[V<RN4Wd2@&SbH]
+:F:g0YDKe3eH:?L;\GT6<gGDW@4fFS4a2X_3M7KbNIWZ;&/(]MTdR9W?@7BTcX^
CT(Db724gQeFXYA]Of@Red:=VRIGO7410SE5/c+UNR[KP89S0_5fN4(JJ-<8XCV@
[6bD<:A\:O9:8Ba6OG<SgXTXIXG]NT-F?LS26)[BI=3OE;^3=IG5?M+@0N2a8)Sf
LD?N&KcQ3UM+2#gHR^+)Y3gfbY?/6V#IIY?Xa:U;\IU\2KDNcbKLK1>)U?ABCS)T
b0R;/0.E-(S.)7&_-)47S3aTF/+BKSJdfQ9W<@H0:6Gg?dERAKH2QaPG)DIFNBTL
B.Yd[:5=(::2^]a>Q1R^eCYR7AVZWY__9D=b44N62dY(7Y1_IfRd]]da?:ZQ)a[]
[UB]eRKd?,GfVM42.3OXJFaG+H0D2MT##d]K3A7&<1OC0#KQ/Ue_5f@CAP933PIY
a<L/RKV+EbTA)/>UdV>C\2HeD<>G>Q8>GX(a8)=>(Pc]_;\HGNZHYNJ:;,@^;<])
F]Z02-D4Q>K1U4,Be:=5/R,+LO\AV?Zc(7KH(X.X=3NS9+B(c#+Jb&^g:FYaT<(=
RH\XTO2QN^O9^7D(B)YXY0af<,W?T1S<CUJZ1_,?=H4[=AWGW-KGaY85S5C+6R@W
Pe>WO5)/WHS#GNR[^SSWF-5N(22Fe?KN[\A7Oc]HWS-4)_g4PGT4@2LgT:7O+77S
^L@]>F;b.eTSUe4HWG8aR_<73H.cO-D2EK_I^>S;g9+J>N7gMX(<VcQ/Q&8VZ[N<
b)A1^CZ^:G<1;c1Le-[)09c/]+2ZY8,VDEBQ@-+@O4AE20D/E.SRM(.7</CXDCEI
-FZ7a7X&72?U4T(^NUT8NK7)3C))<6G@BVNWYAJ]MW#<-Kb>>>MI,D<)A/JOX>M]
5T-5(QG+f\P[RIB\^IX]+HK8_18U6[Vf.0.I)&27PJFS)X;dU7X@,09M<2EKXEJ3
1#.C=cE#=F.NUTO.J#ScdXg,DWe[69.9,LG8TW&MYYB14JB.\96T?YO)06.AY_GO
G^cJRegS9g]2+.0-cEHXR-,MBFUI&6<9JIA?3YJb,Z,HUSF3G-e2YU3?J4UN#(^_
HAS0PQK,GgUNdV>+-7NBBTGYP5GP^?IaWbO&7V-+&MJPYGQO.S\)8HY\cc,8J:;R
B41\[dQBW3;&2TWLJR.;2WS2O9dL/]\e?TV<>V8(+++eI709HPAMOJ-eGe4TfcPO
(6X=MO]dWR@9[+(T+</7g]9_QO&81WFe:=.LQ(fQM0S&H;1fg+ONXg4)ENS0Pd+U
8A5[T]#3?==eZ&JRP>G1Af>?e>&GATNA1+W:,V:9/:-KH\R2O[&B)2H>9g)ebVV(
&Nae^#fF#N/6a?edV_1-a9Cf9dTTVbZbYU4QGVG].6,9J&RTaTb,:c(58^1;XU#1
:NW]a8\bXe:(V#D301d)N>)fOUIA8e2_V7L#bCg@8dG1Q>3O\7]8#BN3<J&S@Kd#
VR_N4?6;8>VF8()gfG/>Y5^Na56B;0&\4d>;44A27+f^?6680TLK=cRWT6AeHT)9
.EQbW.>LCSgXQ=((C60C>SaS]&8?^R3PE:dN[P;JYf#/_IW8:A#4d(DB<1DOYZBM
)=0WOO<QM&ecOR3DW]ZSd628L7:#cS@)KTXS:1&A1/RQc>4GPR2[,.MR6G-LB-@>
UdT0[8;@DOS@13NeggMZ-Bff9Y7)4T3>^)P,1#eY-80)=:+U7PA(7a\48:XT0+@Z
3NX)0?X11F(/(GDE&Bda8J7L/Ye1ZXG9<L(@eD1#>GH&(#R]M+PVO?CSOKTeH[I=
>[G+DE8P_SZ-5Q/:HYFdBUJ,FaZ.9[/2bGRKc:-T@Yfe<AXYDK4gU<>UHf9]>>\7
(U2+C/Ng24/S(LZ)g0<C8&e2BQM6<64^(TT[B^S<?C?DE=Q,IAE?\8D3^P:59>2G
C_)_Z[VL/I6?_4Xb67?Ne2CZ;OEC\9X<G/\#=_;Y&0=c.]>Q(N&X&MKDG:R[3CYf
^=12LfUgZLU5f>G]Vg:+486c6W[2DF(Ve^5]9V1Z=VJ?3@d.0+)2HeZ#?(-5[U/B
PdUE)c;07&V^<VN)ac.bV^g_4Oa4SJ0[X.:a((V)G:e:/3^^UYbeFB\9ceK7Qa?3
F4&=,3MGa1J&QU[UK;G;/bbC^@5-C^+[/8:@^QB)48dK[fJO@POHZ3aS;\Ke\+YL
LaBL+8O5b7,Y\eD-DZJW9K_1[T:bU?_0eDa:U(^/I86T0Gb#]aQ7cbBZSS2^J@^_
E.Q:<AWL(N=dNOeEa8A<;[9:DC(d;;2BSHYL@@TF9S&6d58gLgg60IHJ=MQfX#[4
UXAM#LE&[P_?.F)#JcC4WGLg84.(]-fPFA7]->.WF4QU82@E7@6#O4L)c\I=-6FQ
dFW.?3D@M85c6]IVQc2;DXad)C[O5dRIBWL_;#KP<4XU/K\7CB_YJ3eEQNf+_Qgd
Z#\KLe?F+DF?M(MV;85H]CHYY:6;5fSJ7^e1LR_Q06_=R==WKT00)Y^-f/;MT>R9
79-30L;MPN?2\U,C&eb=H@Ra[R0?WdZUYg#M)QN9ZST&&SFe>2abOW__N0Id\\ZO
)T[cY52e=4g_IM4Ve,6\dE5f]&PN3VVJ-gFYC#MCNTf@:7^@R.CgYM+2,QBaQ)R<
Q\7&I119g1Y)dUL>G\Rc)OH(MB\_d3Te5)57/P>:JKQF#_AeG^=f=fFfIg1Le8eK
bQCWIPLWYCSM[L7O)1CBHd2>VJ;E)A(08M^HUdSD?/QW(]]O3Z,/d4;EMdTg^A26
ed7<P,]d]HV>_5ZY<@?8OE4VRL?J6(EI[_NL,_OFI6WV-F[;O2O#_UD@Ta1H7L&Z
-?f[;8IfB&b#3\KL/V.,J+H#-O:WHA?:)SW2;?\K:X8A-R1DT[Td:[CYg_]&UGLV
J2)eV@Y.;_1A5gN2cU99:PP#E/@2<0]OQ-A>DDeV9^UeC(->E>M/Y6gG)M(HcMM8
OM,H8MM1N5Ng5.(]a_(V?0)-=aGeZ-+FX>,0QaHX:VbbKU/f=-gK]Ba^&5(>M,34
_IC?W3R(DaO&[1]T+Tf\c8d_^[+^?-c8Ag_+9Q-XF5]]1VdT3IG>Vbc2:A+,)4+9
K.G,Q)egGX\b:7N1Y_T;_2.U1L/B=UHQ=Te1,[[0U90dE7PFT_aCPL#c^e1_Y2bI
2;JT=QFGKa>a?/6:13_(4(b.\Aa\]eDIKS8<e383EM5G>N=&.d3:a.b0?<KHPGg2
(Bc<YH&;)@a;3??[(FBg6>M-D3?6f-7GAL+b(;HB<EeGA6;bE]X2QWZMfML\Z5>^
T)FTA+Z+BZM2\0]C9@?=ZO31MKP\73PC[#gf:NE/+UGE-c??OHbU[FbZdW=?#IE5
ZAg2E[)5_F\.^_<Y#6>H\DY1aR0LJG;G;\SRNN4O5aZ^?S;<A.X<8@3@H.4]]562
GIK)&S+:1d9KFf4.ZQ99P/YJa-a<g[)IE]_H,K2?D]dC/\Q.H.[18YdKT.eY<0Q>
MJ;YD6@-0A&Y6_S]Z(P3E0?C3d0C4S#.77Xa,.@2>.F+5VCb1U</d1:dg+<#/X>S
\Tb._+5D>4/_B0#7FKP/9RF7MV\AI>5dR168)\+<8F),NIJV#V&+7WFV@)c+?/Be
V(B8_H]Q)e7dR,5&]HW6<7C8D?2bW6dINc(ZXA8G2<M)R3.[eEH59KM<I@ITBd-Y
ac?NCQOI)HbA#.>,0dO(-.A(IRPUg9(8]FH8L_Z;>0(SD]&M2bTM<;:CcTd,E+,D
[-T?_P/RJ7;^(_a@/)dH_K:+W+<]DC/=4bTPTQ&[MW^@\;DMQaVI1(?fN00NRC51
59#FYF^G(.4PeLa3R6bR/2G<R55VW^D-+dEd78X/?MYJFUO;S=bEfJ(AL_29a,E\
B;e[,gR^RdY)UYg^J4R?aMG^)NGQX]W+[#g5CFYd\WL@d2)2<UY:HCMZD(b6WT.=
gDfGU=+0J[aSRP=?S5#++Z-6F)d#cf3TXH&dR6+[,WW2>;P=ZTI^<9]Z:fU)PQHY
INg(g^/a[/@68=\&1XD/UgP._g^B6;<>WU4,UI:^OHE]A)YA28Fg>\eP#IWQC8(g
eV-L0<?LK#Y=44YD\Sa-Y7/9J7eH:BX.30V4^3A#TLY6Y=I7+Jc.DgZ0MG8>6a^=
VCU5J?ZP/4M9]Y@G/.R2GT@Nd7dV+GJX)g5\cKb=\W0@bS[2+OME=5O465#+TR)<
B;PA=]-,YE=-KLeO[U_/-@-OEX)g2P7.^Ne.@,W)c3b27dF\0OZG?^<P[O8J@48S
^&\B;7SKXXYH:3&4K,;eZe64X0B??VbBEH0J2e>fb[+?V,#WeL#9HKF7^J6Ha+)?
e8U70Z?#=JU<f)9=7TKDW5.@(4F\63fG<.VR1F\0R]+HFOG9-X1:TAfGA,CBZ-5e
G+2BG9A6@\I^XYD&8c\IVBAKV7M3A]0gVET(8H>I<g4X;4\\--O]POYbg,P[9(G9
8U#.fJQ52Q-><R)@Q/&<RS2a3FC&S@9Y4E>5c>]Z-^)ECN1C4C(GVa1g3X@U6UAF
;9Dc9.<^;efT6?R;4A6HQAIY]ZHRSg++=7e[79+&@^[E39P8aC9Pd/@_ZVfM(PDG
g(@;V,8(DYY2DKG;f@]K44V:&VU_#H(Ya^(8gUI9+DUKe8gdGTcM5J&/AO(I[<C(
>A\_64-eT?4\cf<b/+C325d:N>9-5ND,\]J53T][I#>[(;<J1e8Y&2(a1IU.LJ1F
H@g:TK^WN@Y?^G+L=f[@S>Z>(D5<\O^^D#P;3K0;/8[6OK1B@0-,VcB&U/H0349]
DZ-O9&JgD^PeW13B?B6O\RDVHY.<O/b#P^cS4GWf;SS.eac)<CGEU8b8PX59GZ\)
#OTTT[e29(,VHDIa1G>E5]HDM@b:IbQaW6KE_;V&\G@]74ZQ(bWW+dEFG<0_b;+Q
4R3;\dGE=J5RH+4H,=bc3\C54WZgHWZc@[^PAgB>B&>-H6Ua.SN@S[F+C&@J=TJ,
.@d>\BT:>a]O])Ea)C)NL=<HGJ&IU\WG1cOGgLda.3>0G7ES(?EK\(19[RAWJ;?R
2/H?R[.I<LQ^\e7\SCI^;DX+XN?AHTMI@1cT;SE/;M9(/7ZaVK9,9O/[&1V,Y_MA
K+@b>TFgM_L@@[=8M/a6R-WM&JA50Y]EWY&@?3[dB<<eI&L)\2O7ZdX?eOI?7V\B
K.Y&:b)62DJ&BHRQ.7^gF36TN6LI.:+>Y:\d+>DHM)[Q)/V,>),4ES4D4)Z/;Y3O
GIXe?0[N^fWI[&M41KIVZBX[1/E6C+_bUgJS1HP_1W,#K.SRQHV_JIOA2YC[-0J8
DUH0;<cG<#IP4?[S97;(A491:d[,LXc41Aea>LAE4]AfS\U+C,gVa&=9;Z\Q[F9@
[J#J.9D(6Q]c;]<K:+bYVVM#cUI(9>(E@bLUH=N[dc.-49U,DY+0#GNAEIZ87?f2
HSW3.DP+^[KWX>9OLa_ZJ/)T\].2&6+KfcT,Z&Gb]#c]@\1NQT7f]((SaH42E^KS
e^L[J4[3;Z;V^Z7N:4CUgJ1&CM@g;D2L59)Z4c/K-fH>bdPJF1^Z9V86]QGZ_4]&
L/^OP(e0+b:dG>a[U3:-78a?=g>@&G7;?I.HSFgZZ>J\,KR+9=Dd#Z;ZXE25EC>g
AWBGDD1RZZdMAD9&e4fD.O6aA>7+HYG[BTW2.Hd(L@CVAb-_#;5(&(NWgSgPdZCS
<0-2,E.933AK_=:5b0Y0S^/87ZYMeT2WJM>4.5T#UK_\_[NO.OW0_@W<K0RBf@5#
9HA)<(\f<;3W=4LaT,7/Ca3&RH.;?9:L?+Xf8&]?\b^KP,;c<gK7gV1_^&Z8X<P+
f921NN(Z4f6#+]Y&@,A0FF@bOQ1:eAWESHBS(S@1#,:->a5L7FbM1b(-&T&KHY)g
IdOWJbKO4?d2MMR+\7ZgK7(LQ@G^2/RMOCY,Y,V5-I&cYR/[@]A>?6-]&3@Qf;I,
dL1ROJZE[>JM3M8f0Q?GS(c37S1L6ZCaRTaC/B7M?:/ZP>9N1He]ga)0H5@/DB[#
/8dE5Z79/gA0^BXWVQ#:=5A+M=?9B:N1Y5M/:.&CG2TfWV?g0CLBRWIRf2ZNUYgd
BU]H(6K3S(.([?:&0K(ObO.L//e?)1]BGc<YE]f,c:T5O0P)>7ESeAUBL<\8047H
3@9P5b5RM:KGMW/?ER]]O)\)[gRV;=,L-eEG^M</CPT3a-=0OO0.bF\K)DV?FfZ/
Cg4bR]9[T_HJ;:6;9ff>VU@dCGRc--)9#J=a3=ZIFGL1,cQdQO,N#PH.<PLff[N]
/=NVFSN@Z>0:&+gQ=;TQa:;D>]88SaIdB=;BK?&eZL&_U[a354F5a:09:PMR[a[\
#2+c.3._f6B]b9.<;/#dF-[)aXCN&6b?L#]=7_#eGI7H@EU7^56V82fb&5;P^R9+
NeK^_FVD2O1gaI85a/TL2@WH>XPM.;7\+Y8OaVNYOJN6IHeK,8(B4RIW<KI.M6.=
<)(#eT>/9Z[(W=9OR8Y\691[&Q/NVF>4X;S=G2<:?,:&5b2/M(+#ZUVHcR@GBb)e
:\#]>1HEEJ=4VCTLJ0dMX(O-TEX2YBE4H0Y>)T7Ta&^8/eg:GF3eg#B)fRM4]_F)
S._8YSX7;O8\b=0FZ..fY#HR:MM=cFOJe-?b1;U-CH,fbaMV:3T^5H]<X.8-0GE>
R8IL/RO@5);7K7JKe-PB7J2H7UQZOL+],Nb(<1@EDCG;/-cP.K7?;QWMS+bYg6T1
TfS=5U4gD1K10T&:9HHaF7]D(#NCTQ5\F\A)\(IMF4G-Tf&PY^#G+TdC_Q<<+ET+
/0X)=>Q[,-K/TKbSZC>@fC7Pg@-,e\78NIaBf60#La]cG:DdeKLKLHf#^\HHGaHP
E4K;8M15-A4X]/P4_6aG\KD9=MJ0c7BYfA3&=[QJdWdJS,0\5)Xcc5b+9+2R2>\D
4G5[&=JaPP+3\EM0K/T#PGH8,3;Q,bYD)W=)<^K>/:P98ZIHHPJ]H>L34>URL4DS
TOBW@[_dQ&g8-AR927HPe]K>aQ.CL>-J?77.bEc(50.-;;fX1^&?A7]e&U?UYUcV
I0-4bH5O>L(D/<[9SYS9RW<N(]QaNNLSfMGNSH8B8;JbG5E4]b/?9:03B.PBS@,I
Z4=4&KNB.6]OD;^X61M:+#+f)MGGQ[UL.)Wf#c,Q:/^@aIO0eNPK=L.RLP3a[+e>
c[/]21-4W0W.a^<DcRb(,_K^[S047<F6-N@ZT(ZgX3J;5D=5VHI8GK=X.-&^#0&.
cA?7R;_IOUF\M(IA^#J;9(NRP8Z8<Ic5LLF29/a@(3G38@OM[bD];-6=3#UXaJH4
TW=RTC2b[UTXE,;M^E>I-_=)FPd;]<f\4;(0MIK87U(b<g4[5=S]1AL;bN0W[97I
b9NUfVLF_:5bVH5W]5LP]=Z@bQA)e1.@cQd+W<X>3.,H>1/(_<2MfX^0HTUIDE#g
c=SI[3VKd1D8GSAb2IU5-SQW>@5S.cfCG=]G4cG5dY70Id+#R92(KaYRdOb/(M0Y
fK=BMM)5Y>aefUCf::f=GE))bN&(C&gf@DeD\9T\A4.1eD.V@c_;Z)<)C>PJ.5X@
X=Q(E=.\Ra#?cF\=_ZF5W[7H@WdS(&<:>XAR#f<FQcED@N)e-[gZ[3_^ca2@d1Jc
4)=28#,F0<H<E1S+Keb#Kg^K_3WHJ1<=_f-)^&LdOLYKIa.W&^Sc7-1EZOVIUDaB
_TR579^b9/H0MZQd=968HH(X>QLd5^gbedc@b00ZaT\M^B7+9Ub<bYU1D;P>7FF>
.0f7N@9P(/IEeaVNg7(_RO&EZ=0BeE=0b3=;cRg&G=^3fPaF013ANcaAeKO)0@UX
Yfg\+d@gP>[:GY^#cO)W4JG<NLT]XIcS=H#EdAL,[#38g#bT@^USTSM]]@Z(8V6Q
U0f.BGc7da/\=;YFIW89AI?7D62N-:IBUNLSLO]A)KYU=>VSbde;7ISC^?T6P[OQ
f@Jc?,>H.A#P/:egYSO+D@RE&\+Td;)=W94;OdE#D=#=feC/Ld9U(MJF(g4WV73A
?NLMH6ObRI1c-T5H\8P>9H12>@/H?@1J2,/Y)W3;6:9U?LQCXAS4NX]/><IY,==V
D(O-PP<>GP,PQLcG\c9JT#?HQ\63S?dAAEHaDMdf0f/)Hf&</1a2OH^_dLa^#6M=
/>^g:c&0OKJ/c-b;+6EW=<?#dIcCSbUK;55P1F:bAO]-[:GScNGZ?&RYUN,0/TN4
D19K8-[##;cXf<X+6SON[_+6C.IRg^e1-NA[Oc/;DGC[)#@::4P5XMU37F+_@SCT
_C5C[N[OfAFHgU3HJ?5HSH@ODWV,c@<4c6T9/#QgM)>NXJ#;>&cT(c&-X.@Qd?_V
Fb^Z];X5=_AET+40KOKIG.;HDD+S.dC11Xb6dHd0>J#(C69-_T/d#)9;S<[:6DE=
<]]S,U1<H>MV2_U@P.4c#W_4?CD+6PV#U3#342A@MARO[[e\f+-);4HQ(+\,JZFK
#3[WSJ-UTLNVM]@fGDB<Y=#))LK<[gSA(.a;),6:&RP9bd]7IR01MSZGZ^-cGa&#
^Tc?IHY8R0/)2?Y(Nd_0@LYB_6AJZT@/_e<NJEVba(.ZfW[6Z+1P+fc#6fc6?,8Y
R1cC6H1cLKIbJR6E4#F#ZOK8Ad_X6D^6W15/&9ZWO/4>LMF=;2Q,-V5#GNF.9f@9
=D2aT_A_:[+NcB8E/;Q_Z:8.NLP6DP_=J[aFL_-J5IP7\gA-GCA[K9>FO?E)WDA)
T;c_RBC&5^GfAb\Q@V9#e//._&9WC(N5NH\4^3e5b-]CKGMA]UDOJQgH[>4,--70
d.>U/FaQO<#fb9<g0+cNLUBb>V)(J@b-YDEJ.\2ERYJ.(C89Q4d0d]4cWcf>:+9d
.?6J:D^Oe?.>F]+:aS+7E6RLeNL]8VaQE1]E):(+<1>e^L\5a53a)cC[8J8/V9.>
\>M058[+K3VIN^1MR(d()MUVf8CW45S:^bFUYZ.aYUVQdOZ#VHO[CN4-_29_Q5=4
INaDFZRIeZT@CYHJ7F:MF-A;cJ[gNR3=-,??C78;D6(D18HLbQNNW#CfN8&MEX4A
\).;K75AW0N#L4f>DcS&2&:\ff&OG)KM@?I;BR\3Y/ECf/ce51YGRgCVR82caTK\
D#GE<AL6L55gLAXQI[D=4HL;&NT=g_B0J=a[e?<]05]6X@D1[;3d=C<2[<,edGG#
RR]Y]CQ0gJKJF#6LQOL^<YgV.73NJ?LQ:^4f,0I_M1/G7Ub^B),IZ8&c05CUP^:\
+N@0X)LG\4<2VGR_;RI8M[M24#WF?6(<[]>.P=0RQIUM@2ZT=bgd?XT6JdMP<d3U
QF>2<MAD)]56:(_@)cf)V6MF3\N5cPYTL:FV;VZ=E(;@2<F9@DF&83&W(Nf-CdJ5
08ZW##^:]ZQ2O6O.3T:&5TD(V>CUBW74_&NC[[de4&,^?25PV;FICJQ,)6E+P(gV
b?O.5ZeG<56aVdG]SIU[@>PL@6=]#]c9I_3W.PJ61H]1QSM//XN8U(X@dQ_d:W8,
cfVH<?M=+G,1Y9NgS-:fH(Lc47KIfc#_>dBRVWNIHVEcI?BR1(?PO:/@R&XN>ML5
AeSUCT@T4eUdHd.Mb>@>^FcX>K]L?N,MXfbU]Wf(2Q]]4UO?#g#KPYT<CLD[LRN4
,<DE9MO&g?)]Q<@3PXD@_&-J_AOCcNQ0c(D[NZU/&&JQTX5O\>KUTfND6Sd](J88
HOJag,GR5G#IE8X6I,KS-d-=7:e;](?>eQB2f,D=D5(4D;b=H:+<;#<YM5e#Y[.6
3J9eF-GM.Id&G3VJCLBg&>g=Sd3PN>CMAJ^?#-^N=T,AQZZ[Y^b.B=;7I+O#_Y7R
YG]ED:6,(1X9eF[&3LBADUM;3IeKP]d-2b_=M:?Je75C(5JaENVN@,V^eDRcdX+S
J7MSDe>N>D+=;,7VeC:)+J668dDdP?\X^XZ5>O,.@VJUNb4\.)TJREQ85AJ6>;?:
72Y+>QF#bRc+LT7JIXS>^_eG3\;+WG9NBWIM&_&WP6BQRc0@^(bA0fCHdE,-e4,T
Y@M.WK/DaL2WOZa7JJg]C3PBYV;\T<.19;]IeP8]D5JSW9<++SN(SV,dO);.0/8G
XQ_;D5-J^OBD2.6-?&e1ED]K(gae57gYf+&S<4BUY7aS7MN###/@#]_:8FA5.QVa
TbfX0+eSHMW\EL1D-_cN8P@8e@T_^.\+9\[6[ZOPR_g&OPg5<S<,_<c3SH-<//<e
>JEbJ?Kd@:91KGJbP@e><?<91^b_#GYcZ<\+:>DC:aLPfX[BUW64PE2YL7VF-:1T
C;SAK)TJEI+WH??c+;I^PbJQI7TUM9+WH\/_K+[f=&fSTD+(UfMRGMSC-/03K89?
[W8BX&06W:D2;;M^#g^e3[AU\#8AJ+63(AR^f26S/WW,?SPQN.1,?M>d&b[U76(U
T#0Y_0#@1&Z_RW&ea39J7_2T8CbY]RV;P&3fG/Z\U9E6RCebI[54_RS1JNU[cVN+
+BX9OAVJC2MESYgGHM2g=?;[(bEgA29+F6CD81;@\):6@[dQba1)VQ@EH(a[G<V)
/B#(YV<6=d84W-5GRCW@5cgX7Y=ENV+E]I(R_YRF:6Kf\aPNV3/<H2IL?X8]BVOY
STE^Z@=5+\aeO]cJ>T+PcEPLGegTHN>Rf7X0BaNe0Z&FZ6@UX?M;Z0GTBH1?c;F=
LU(LHVE8P_fa)OR6eS,-YFM2.eEc6MQd)D1RQebM+eA0eDa\V?W[gUF#1b2(PgIG
G-ZQ6fYN;V>\H/[bD2@+@LJ5]+9[IA9UA;.,B+HdKAC\6)2./aA[SKN47?>?FGHM
dR\\0gY]>b)b^S@;d;7\Wd>4]CZHcQCGL3,_W?c4]5>0\f3:0e)&OP_Q&:C.1;a;
DWCUF9T7];VOLf(Y+f(+KEG\W\1-JMW5E<DP+JS:5=:[fB6-;8]PF\[<d7ICAUTT
S&8O;;P?]D3)dbKKf7J^&^7_1c[GTJ/1KeT>OgA\&E/5->?e=;^@B4\e/YCeRC1A
=]E:)eSM@U5>(cB>P_@8+12W7?-+B9M2aV27X8)M/E&QI\P@a(26T;D1b9&,Y48.
0H8II>_baa.\FWW49D3Q82TOGPEc-&_bdDHHcOIP]D.[1]bAJ\?_X(SBDA[VE.A/
^LeK>UBBELFU\3M]Y]W1b,dQdbM,/+EMaZT9(9KNB<AaKSJQfDS1;c.2T4VR0=0N
KK&\PW]:IA]Rdc=g^A??_Ng:#HB2+-13YOD()L\g/V/@Jb(1_Lec1=KSK4&5ZOM-
YSF,bHZEJX]YK2BD4IZ7CT:EXHfMNJ#O;#aL:GY)[)&]d>&X_:7-OZ87YJEDY4Fg
N&@5WabT>VB74Jg0<b39WQ7L[.XO9EVND4_E=IK8aaAb3)N^.TcTca(;C@ZYL4+&
6aYYe1B()PV2-_C\;Fc^_Z]W8+[:P5Q/CYL82QM0S-II=P<@8B_/NIA=91W8M35O
c^24F0__2?3/eeOL6E:d3MU@,^4.(DX(\SL1^LFP)>^=O-7LG36Ja[AWMaJ&TLMf
C2a]2D;?Q-I(PBRMJ\-ef)E:,RT6:7=MMbEI.#RX0E7G@f3[]KgT2-_KJ[,abbDC
U:>BX7NH=AH.ME>2):GO)f/NNCdF.8ZbSMP^YW:(^)H+OO+KaeVMJeW9RfY9[A_:
gd3ZJH4(^\NYU9D4MG>#Hg=?]3G9dX(?e97&&T9]80f^KXBRNS[R:\]?FH:c>K5K
eR-^F?,>+Q;)HTMHIQ;16[a8G#(a&6E?:?gA/,J0Y=S<2G_1T>#_g54U+MO[-#F8
dM/S<Md^Z4BJVADGaQVE&d+K=]Ef(,/EZJS)+REdBY/=_<NaIDaB)cFRNgcCJac8
H3@O4NI^UY-bG,E=,35Id_5P=Be7UQJQ_<=&a0S>HQ781Z<<KYP.V]&dWM\)Y9g)
APOU3Y&(LRIX?gX.7#<F7bZ?L?3dCHG5?K.e=QgU\cPA/1#5EC_cV@?D.GU9X,9>
=[>/A\YaD.WPf^aJ^03/5/+4Z>I)TIVY0RL0@[f7U::XOLJSZ]V1U(b:Z5,@06Z&
g3V<@,B>;W7CJ.eNcGg[32e9^3U3Cb/8fIW8RM:/T7bdSSe=:[B41\CN+BS\RT-^
W_DK1U>4ABa8:.?;,WB=/@/J]RBUBY7/^Q<<4OHR;C^bC[cEO-SG<[3AU\J[CC9E
?T@0@.H56+I]K_de;3P[M,W61>BVV<T6WHeTLWbC#b<8J?^)3<:XED?MTM@0[?4A
gN;SV:;::+#^3a-EX6INg(@LCaCOOI_M[(9bTeWYTIeb#7[R7KeB[R>\G1eB:AUW
Z@RSUBXLD?LKY3DG)R8[XI@Q##_B-Q@XA+&D6O)-QP+dE,STU/9_^TSd.?AOI9Ha
K3:#Bc5,A&dN#O8>QE,S5#Y\TXX7(;003YFS@a,@I3ebLXA]?f@T6_M:FW3+E>G:
-5Q:6&X;R-ILbO,Q3,_=0XZdf+7R+7(K@)9\f[MMa\FFTR]PU?aTD)4S\T\MA.M;
<C,3?V6-.L?RbV992D&W?HeMCN:BZE6RC(5P(F03T802O,a,EI2D84c]/L-:00-J
3NH+@?g0>\ZG8W<QQJ(KP9#G:bOIY.:\8D;]40Bf]D:E+IT[E5I+@Q(ReMSbB?KU
#Ec)66RR?^Bf[/=\a,Q9<AbHZeUHBU:7K-,]RZC_Z&35Bed;)8cA;(+a6XC0fe5G
/6RaD6])LgO2^3Lc>J8V]-RbP=]N,f\-+OdPGUQHe/aU#T<cPXU=>U6eN)QSWEb?
[-LW:5I_469IMg0c&b?+YCF@9SFW?G&DOXA>##7F0#21Q24N[e4BaKD2]N7^D6gg
>=)A=>U778+57N;5<:O&3>=.JVQ:e#(c3Xc5VG-GFeb?0@5Qd?#2&c&G6;_,3U73
-73C]Ta>5B=<f>>?867#Qe]>R[SL5E3?Ub:W2R/U=<dZ0;K0Y3d;SgV3BSTJ5VaF
7HTX.ND_Z),BfVXfCEdL3OdJVa;b88C]Z3_,Q?Jf7dd69>L/=3F]23D(C&=cPGXR
MW2:VN1?f;D(I,ZGQG(a8L,FB^]GEW-9XIBVU)RF::YBGQ&U_FT6<_aJ+(II#8[D
g5TA4K/@dJT3)7:8e9^g.C0EEeN@JPKbM.#K,]RfXbdA6_4H,>ILb53gX0W.0?]#
.VTCO/fQ:7WY405G0dPJQI@Kf((3H2:2B#72@eY>YGS+V?.]]:-(FHWa0I3J9I?@
UKc_=Med,Jf1@A>f]-R6f,ZBaYcAdaCV>U>a:.SIb[a9+#e(UNPIa[GdW5G-P?9M
\5B4eX22R6^R(LNJC>d3Cg;6OH[:SX2Y47D5d7C=;4S86]>8QO&UP=NR+6EAJQ8b
_VUbKHUW:VLT/R5>PC2^;cdH_Q^(UV#]c@WY,V^CDH#^DQX&9X1&;c0aA]GES38:
bQ#eW?^4U>3RP9.=C3Z83)4IZ>f=WKK1/1af)/DQG>74F6L_(aC>Q2WOS<HEX_ED
/1S>f=VK,FLQ(&U+LXX5fY5]&,PdcWA0da?I+S#:E:eg2IZXE#(GXLRPMKbJeUd0
O+21IVSN30.[)OOIDC=Y2g:g<cX1)a:C:K_AgCOD^Xc46GJeg\6\_F67aS507V?c
37-1.4PBVefJNL2N3&e<B6CE=K4eP75bUH_,NK+G01-Id1,+5aYC6Q14R&eQ-025
ZYaV\B_2f-88ePQKD5WUGb,&20V37RKFD^WFg/=gD6CRT2>[VfbVe.OLVNRe@DL)
S+:1EK]X,;e,_2V:B>RfSJA\9+EY<TKGMe&7\^?dKRT>bL@MOH3,\g;K=^J_EB]7
5Y9+KIEfP310P)&QcV:8a:@99HecGOTS(6)Q/0M^GF+MR+.KE@bdG9CUFK/[(@&8
#,K@c4-gO;<S2/V/8@I=B6KAgO;f)PDCS[N-BFQX[fYZ3@<c17+H@1^[)/#a-MdZ
(^:7Qc4.JE?L+]8,\;4Af(&]LQT(aG;OgcIF_)\7(SH25MMMFX,/AcW#K\8Za2HB
DW>=cfV)Q@J&Z[,L=>9>d/3+6K\;[S1G8BVXM:FORT^VTc4I[._D/UO)ZF[6ZFa7
<5><3FcA\R.;80(gR_Z(,JSY#72&XZI/R.I_UU9cac4UOK8/X@E9Z-)3Y,Jc>J+Y
==ZG<A#<;Xe?@Bc=B@&LZNGFA@\5;V:@dNa]1KRPCCd?3M@/9PRbQSg#Bccg<IZg
eJ3ED.?SZB9&RJ5)b><@1Sa2.eEJSVU2DDT_\D.f_ge=^Rg)?<6MX@?^I.YH7<0A
DAA[#AFaHg>A;CI?@3=d?:14;SOJE?_XNOGJ23H<Z@PH(5g5/\-AZA0c,YF7H=N)
#RGYN82b_/(a3dS3Fg1Lf=4O?;:@_Nb?aNE7MSTU:B(]Q(@-EC-1P^99^IQB_969
DWfH>HW9Nbe+M)bOQWB1VDJLH.OfSS[[=X>dTRSLDYV:PAJ30TH]3,VIH;(aCX5[
fN@NUOUNY[BHU>FLM_SYHg[9E70_aD2D?b.Z@bR1c7>[1e<6]FR,TfLG__g\AX@f
f<==,./T57EA:)B,=^_=@#=1ULUa-6H[3G?Q872W=(cLSO(W[\8g(ULfZ[5#I4X(
T.]5AJKT;)MLdeb:9M1>>W1FMeaK([W#FZ^RT9+@>QHIQ6AcPfH]#La;=(:JYPO?
QCA_+N/Ad^[V?N58Q4941e25XO]#(9&Jb_+(D(35GYN,2cEJ<Q/H1[<+?(\+[,G0
PYX4[gBf?#LXVeVZK<M?9S@S62G]?G@Q?+cg\9BOdLQ/cV:Z.,1=U))M\+1.W]QE
I@Rg_D)6gJbX^D]]P+EU>0_4+/FJ386)3L.S6/WaB-=ILfNe8CFfXe.TKTT1_S3&
[T5J5_P@2SN5LZ+FY,A/>]FWQdeBL3RHGK46_9HYMG@eYQH>CKSOQA.A7da#a4g_
)8P:1KIMB+=3CNdT2#c4D_^H(>aS<#].a6-X^C[Q5?]e=EgEI^XNQS_f?C[,D[HW
0TaEaYcdA+D4cZI7-?O@(g@M=AVf71BTU:.82Dg_7L4G[KZZ;?f=EW/<,8J8_:@L
07DVDOWRCaJQ]IfZU1I;;?@fZd5Y[1Y.TIW-2CLF[AD4;=a()V[MM_AVeP<VIXAL
2F7fcUAg5;^91,9_MO>X\XJCVOHZ]Td#Sg@,03,-b;_GYR>7N)S>1Ef^g&GVFNHB
AbQ<gafN5UGS,^7:52P\,7CDKLg@@8Sa/598GKOLPWA&0#M6a^_O+:g)=Z7J<4AR
&Td]&ONAA5KYOU(M^0#gQSVCfS4OX)9/g+PO@7&FLQ.<K6S4\#15)g8DE+eKZdII
FH^9G=9VVe<[OT?AJ+N:2V8=+cX7:GT;G4.?bP[>6_>GVR?NT#9JM]HCM6A3TY.f
[JH,N<fYGCc?K\)feE09/_&^g,/@WNN(_VcT8U5dECWY>Vcg_+#(SPQ/f;ZSSN1b
K)3Pa#2-GQDUS]Ad:PL))cE_Y@7Y7ZVG,7EFc-TRT)I&)Z6,O[8E@P1MEg_13W=]
Z,\RY2Y.;#@P,T+]/@80/Q7:J^WNKb6;S[Z=U>]Q/5=<BAF&gTIcKaZI^=^G]EU;
=<#:5\g=#@Ea+a^W#eDg9cC=:dL;Y8-eBI#2?[/c_WSOaK80-cC-L/GOg^GCffIa
0WZQFa?:^(J.5DH_V5NP;NW&-9_6(?TIHeU2#7;KHO2L67J2YC]R[[(A,I8KN1b6
9;cb&H[U(O/M=<^dW68^C8.C(J=.IY6EWC\K;cA/b+-#O0^A3MBfA:&Nc42fDaZe
E(Z\95(WH?-dQ<0VL?fdAGgUT._=CY6W-SL)=GBg3QRKBQ@]g+(?)7<IDcME9Xd.
:]HSg05VQ;BEA2R;YDW&04U1#CT-aE(>[=B]SHK(2X=KaAB&M&:2SV1_@,G>-U\A
;dQ1^2^#Ggc6L):0L@Yf9e9^1\Jf>d684+Fc&XT_LG:N73@7fSN1-X71f-LRQQ;C
@7S>4EHX<;Le(I[_SP3C=/C&KWfg,,.&A_&gME<?,#RagQ4R:fV0FJ?A-1;+G]Y6
(;?A(bY#bQ622A9:Na_,]aWZ>T_NW]7JX]OY5A,CN]2B+EU:J0__ZXF]V0XUa8+[
UK3Td1A8EZ4HC/+O@VfN>-G;WF4VGVK8U8cW0;W&g)2KE@F@O><>,1B3R6NeW1RT
]_-CYe0ROZ=<_9>&c\_<,c5R<5a6MQ-+6@&N4g4/]S8]eBRH\S-=3STC3PSOW0fN
82]7b>+\_2.N(S7E0c439NA=AXG.@4>P5CeJJBKS\K=>Q0V>_Ng,H3JX^.7=e1OT
TfW;1A\bPN8dC7RaBPD;EL[@+],MYP-I#,6O_\?D4OgIMV\cOVf>)QE^D&Z0^NZT
1fI46KP7T;>8>4,8,JJOZJ][^Y?5Z+UTaF#N\LR&#@\,__GKE#Af8>]P-(7OTb/+
(-,#0c;#ee.3N_25PI.f9eMV6QLVPU0]\SYF>,-V-IdS7074(29VGKJ[4O4PQg,g
OA5D;Q5cGQ;;N8ZOPHQIGA5[OFSQUQ^028S7VKd89/g-dK(_&I+ZMAZY@H1#@bae
E^8aB58G2\OJ<bg5FPJJ,A)-A(,059E^\>.&0PN?fXT>DJH_5_G,GK,RP6&?PJE8
-9@GeO6.,H7<aNc-CWZDIJ@E>36\1C3#^BQd4dXDD^,2/)b5_NWE@JJF_QOFf&Lg
3Q&X(:RCZS@a<V+P5:dCLOZ5(NbS,..eM,@+U;dQ0((#O@<H=O3ba258OB4-<g#4
48N:cJPN2R1IN6W@6ZP]&AgBIH7^G]/]IBVf<VbT@T<fX?MU^CTF8_CU3@ITVPNP
gR85S+SIA@d15QF(:&;2CG:9e#2,eP79U^H0VZMYHYQaRXA+2ZVQ>Da483O-FLe8
fWg&U3C&/CWH5WBfOMcCM2&]^-fQSROJ,,C@Fd1(Y)_8A[=X]Q>a;AS&ZK-4_0.8
N0DY9Id7>W6/OZ@\d<0a>JIZa]/.DQHY6]bEa(,3O=aG<7:-.aeeOPe24;01YeeD
_._eS;<=ba)JS;(?R/?e]B6:Z+eH;;HCc[5I9:X.VeIXTMLVa[&9dScT9/,.aJPE
9HWX&\/8#Ua<aLPB3RCH)C4M[DH0K^TfOWIe,R3U?(FQDU1=O/D6BTgfdM)O:+N8
^9F+MAQV0JbQPQN^P8V1MMIX#b_PNC7Ga\S916dSQ-WI-\#>Q7/\,JSL_7)-1BDc
=.:N:CHLWc^TV?>N\_WXU7gB[QU5a3__((+?^f<Ne+ZR=5VbNPHG5L_?X19>_C8d
(5)&FE:]]24E5]VI4@PU^EMD[dRCK.E6H.F#/;-KeC85Y<WK7g\;>K<dPPO@4A@:
7YF3LH/a>^V[ZSFWG>a^4Vd(@,MP,G_e1e9=C2L1e(@V,8HO51GCCKHL6=R?\T64
93\EPL;SA3fPXb\3\Uc800-#V\8:&YIOeeJIa:DMb.52;R#^Q@GaP-4O,fCZYdP3
CgUb&\K\ZaS@_cZRdP(CNPKX:>3)3D+bDV,b\Yca8DE=C;9#@H,XY=:d)M5.gYW0
&B)1-+7]_Y6B=]D5c@&?MffK_d?JO@6EbUQZTJa-YJ@T8\Y=Bc\Z\Ag+W]65[81c
&,8HT;M^53SK@U\V4R;_+^bSYH^6N<ML)W[BaW@O>(S4B,ag,8Nf8J(50&EVaH_I
;/@UTf?\3.+64+)aM=/]QXM8JdRfPI]<JR\4&Y0?OH=L^#6)GM)C#.>eBAVg(RV?
3#X&ZP9UgdaDI6([^7+G668):F_?<bO)@G58@eUWDaUM<4/Vg<#?FFd-C#CWA?[_
)VXMO]9^14g-9CVX\5TJVQN>1\O>.@79\X<F5b;;+fbcM28I<:/g62)SP692VcOg
OZJg&31]U=ag78+6fY0./Ec.WSYdHYE2&L^.af4e<bF[U5GYTH@fUQ6KJ>CV),Pf
8F.Q_gHZQT&@0b@@?SI3JMWV22^O&ZG>E9:QY;J_Y]9d&:8O[SE:WC&T@]c+8YRd
M_NeJN)2e5_8.1VG<g+]8C;3MH0S=:+:dQJICdI+bfeHO&85(76Q3&#^IFF#<UD4
WYB2=50TaN(6IEX+:cg+E@E:TO3BdSUcT3bB5EC;H[LeQK:QTM-OR;fY4eZOfV8L
34Vf&bRE9[cMGL02Eb64->J_RLA]<6@H+DJdMTJOFX.)[?P7e?ef/&2MY]?8bJ4<
8+aI:IePI-=d5MIN3Z)O38MENNQ-:.-?Nd-g]:T65PS6H?f,.,Ve)1@XTKOQRgeA
=9_fVYG/;J5PE8?ON/B\B?K/U<A@0B.I=e-\a9=5<OSO)PBb+6a_M/UZJ>+HX=VU
efa(Ofg>b0U#53@GCg,.R].Z3F\2_M/]3UCPH06g>Ddgc-c&;?e;H\M;E3>EHICe
F#F=>R7\gV]V=6GU<X2gP.Y,e79T83TH=_LTRAf<]FEQEFI^T=:fZ<-da@P:N3F9
e>g2f+a_V58V,->390L_H<ZKFXcb2:K_\2D6J>cO_6;UaX(8,dMNW]6F4ePc&@\9
4[)X_bc->E?gFW[(cOE+K[T1e<MYI.QSGa[X41H\GGMcQH27gf,A?OAB.Vf>\)GP
W#10AMZFI0\=f4(8H/Z&1_^1E@/dWNNX&cS@PS@SL=]UZ<_XE?RU05GY//K18JWK
O6:6;15K/H7Xg<d]g[]^I;HCV@.M6Ba0U@3aP.dRWd?,-)-24;7@^&@BO&U?2-bX
V>-GF_=GOd1[@HF8)>],MT-K>a\?IU+fS6[7U?IUWF2+Z3aaV[DSab(1S5C.;daT
JUeecPU>:PGLTPIV8=dWNY#AY.]JT-WI4b.3\TdQA8-b]J_Q6[;&f?WFf#9:;Bc-
2SgfQeHJ0.J13S/-C_0gL4+_Te9T=ETYL(+,VG+Gb7LX_HVFX=I#\N+ed&7H/H[E
NH(NYB?cE23,PM_]G?.7-_2_<+Z94PJ62_8.2CDQ0<?#L2B:0,EBW)b1c219IcQL
QUcAefRCcZe>Re@?J_:(8^:588GAbWba@1ECDK:[5d/M)8@CNF-9Dad;+):RJ3UV
&K5R.DLg0D5B=4I=@.a#ZaM>7b+(aB?a^##.1.F?;,,SOf+&&&&QTQRM:EEGZBa7
H<Yg6ScY:W@5>+Z3M=X+a#HLga@\D<cQ8A[#)gG.O>D[e1Z&0/L\[DVM^+<aE<PV
T9<++OSAC=8U8ER:[NKJO&>EUNZd396;GEg/2YB0,B_<^56(V)(FeK8^Z7;5)IUP
0W&D2JJ0.C97)YZZRKM4_PgMD5UER^,UXWe)??STeg-\>E,)=D<2B91&1B](T/OU
;D=WCRd;)d2T,C27J69DCYV38^M56JY3+;NZRKeL(T=DDBLZ&\c4d[DLN7(C(7?D
C26fX<(:ZL=14KX#>],S@_6P+ff49CS3T&N<d7_?_L_^?FfY\_UZTPIKXDd&>NF2
^0VY6g=WS82.e+:[.aabR>f]CIQ)(_c?7L,;->-3_+>@ND[6J62K10,>e(YCY2Vg
&V;-YSaEG;,DBT0<FVOdZ?+e2&+-U==DDK/V#eFNM9/fNN^(CQPG6)Lb;4LURG36
BJT_?UF4(AO_d&I;Zd7^c-6?<>@4F0@fC34^SGRD.]\(Z3+6S#KCAHN7Fe[83EP7
U>eKXW@:\gf,-[FP_CD@&gNWEaTdY?GIA4E88W3MUg<J8d(=a:6Q(Va>^E?9P39(
_(8eK:g-FA[>N54789d2bAbI3BEb^f.I:/a\:aXNXTA2YE;_P6b:.5=?\2A,@3.?
)W39cf;]\E9LU07PT=I7[#VFNFH98H><IbK;/bR:\,^A8G,QB61[Sc7TNV#G\#>K
2M85B06PW>;+#cU<4ODD@;HQ[ee)KbQ1PGd](<K9M)@?DVdR/X+L0,G8cI#^]@P0
/.1PPE)7#(G7CBEDVI<-f)4R1KA;.UOcF[J-;_&BC.BR2E-/J\\)[+Nc3gC.Y@ab
bKH7D\;UMb:^.O](I9fNLFJRB_)OTgaFK3_1Z_+T[OgS5.SN6M9-9BgX#d>V:U[a
0S1E)1WC0eUC#?@N\UKZ@H4L^94FQbM.+=NE;[e8QSN>GP6KEV-YeZW75,PLQf#R
?3C\+(B>=5&@.gC@@80KA:Gb\S3>OD8+1J44fY9,^#+Y.-8,VCcG=(BQH81S/eZd
ZSAKf?3Ugd()IUdXb=-VRS4-8#9F<T1_Z+2a0]-.I/TFeWG9-F@WU7IN.=aJMc5B
NIA\4+<VY3aDDc+[:UA\BQV9fA+#@2_7Se#_1=P9W\E.KP5)01;=BR=<DENOe1O_
T6):^9<,XWW,a\Hd<T0H3+11g4e-@IfW21KGMV1a#4?<H8H3=cNOI=JIK>CO+_g,
?&e1H(I^f6J2U?S.)^;a6,.@aE_.,<BM3=.)P8;Yb;LO2ZbL+961O_#g88E.79M@
<=9-+5[&b-F:=T;+5eNDGL<(M/.S-?]7D:0F#aT+.V0D64=g<:D#:<6<EWW>;9FC
Y(EAaJ@b>>U@QQ_]GUJ+gb)O6>2O65_-Qd>&NGD3:X(BdJSfNV=NX>D2>Z-P]aGT
5aVe:aO[5]c7:--C;^egg2+)^Q-J&R6]RO>bUB:>#L@KQ4KcU4a-_g2K-dd-bg@(
KJFZ4FKU+Bd[d]C>Q743/-(M@&#X.B0GQB0LO/JA7O5]Ma17Jd5:]7KS1CJLUe=g
<BRB8Xb>FZ5W@O+GI+^OOO[ORf]0@675-^0JR/JWB@#68WcfT\)&++S8f57cAb?A
/d+A@7U;D4f3BU9Z.7f=5Y8<Z):(I6RZPHgYfJFSRBLF0BX_-P(OSaKGMF(/KRf7
<T37^g<O3WPM[3_WH=(BNJ?99FS=Bc:IH-D+c)HLCY5R\af[AR(A^<-(1V3?baB;
S:b?bD83VMfF9SW_;N[56)(V\71M(d(P.Y4I3>IQ;FHG#Cadbc=H#.0OK4RZc^b&
dP+F]64,)(PaZDD]==X>,(.6#A@FR@Db/[//2a2c(>JLdU_,A2[-KWOSV42J[__-
@_B4IV5;]b_2aPeP>bH.S;UV](]T5f#6cNe[>@6-GF1?04+4WMWKaWdQMO3;Ia4_
VFZg@Y659K]fBC@.<LRaOdG/4_5/\HPK@97Sg,M]H7?MA_J-15D&<,5N_FT]b2C.
M5c)GFP5<21/2NMG^KYe&S3G:b,g58)3XOV<4J]_\-\GE.E9c16G8+Q+MKM).#GM
;eDUW3M]XL)S[_\[\V+&#?+W]4FN8QJZ&0@]E2?1+/e);)dJY\>a86M[@W6PK^Q.
75d2B\:\1:E/8XK<Q-?0@@AZP21[CG[#9f1:::K7e[+bb=_cNa+VD:HXgYR^T_--
>Q@8;?0?bTB484N8G@+eNSIN0DE[ID_A\FD.>PR]ZE/>HMX=cE9WK><N#[?(Ie<V
;YQP;+=g(H76^?Q[;77K&E<g@.@ee><JG3d6C3N#<\S(^4PcA1S?AKgO5@T),S7B
XI;Xb1X<54C/S+eg=c#Dg65d?H\TEQJ],JFA5S+g7/8@[_>abc-(U9YeX@B39Tb5
ELE_CQd9(=g:,B\NdfJ446@?1M2;+.1][OT.5/Tfb\#))(NgS/-96@U(+ZY3YVBd
UWOTZC;0AYMTaU/ZK.<TBUU3B(YFYK2++_=]G:]O<?EWQTXZb<+,V2?(bNAWUW\]
;]++[&+W#GH8HKUBPWS9J9CG?XLKFB<K[3829^Q=O&M)RS+@#GQXZV]IG?[>eS])
eAL_?.:,#bfGc@#I;HOg&O^_F?gZcd.0();_gIc-e,2VX/SOD]UZS78\gYM7V6TA
]SPH:;ZSWV[BMa-59;I.1f+VV>]XD&b@.B@H<;K0+K3cVP@49PXXa:3bLFG>;aK9
Cg,._#&cAM?MT9>=S+ZJU\XN[J]f28.GUC;06G>Pe-9):Xb#^<<85.@YH?,ZPY_f
8cE;Pe&PK?O?W;CgV<aJ222@H_L)NJI\G,-&g_.>>dKHRSc0WU1?H=A,J\24cf5f
:BXS:0/KY19fOC[U:CbNeOd(R8VG5CK5;?BE);5->@&@02g0+78SN12)YV;>[O0#
@RB[g?/=EC.[)B;(C91Ha:B6@B^,fb;a82:6a-f7g=QZ.+Z6bSd4[Q\6&K-CD46A
F&dN5KHP6c4&Zaa@E92Db/KP@A4._T85fV&S:W:<><11OQd6>&FY0@cF_2JeLG8f
9[(ce041/X&02c:eaP\LW4aJc2[B<KaOHC,6NANI:6dJQdAPR^2\V,ZN<W@Q]dZ&
;RVJB^0<9@[&LI4:;;[HLE8Pc4R;gf9<@5ENBG.P9,^0)5Pd0^gD>2Y#_Be5.+bO
I?b-KeZO0f2^Q9eEHS@=(0_bEND^DMRT:_S,]:]=.S5&D)])gX-PELa&V,(.NPVO
CO^97P(G8YbGIFN4DS3U&./+SNe_:Tb3=Rd]g)RbGC+]:^1162J50X75(];V/]B+
b8g<JL#9QLbR#8H^5O549<2F_[/dK2Vc]HIP5aNM=dHe@Q<C@g-?4>.^>1CVZA0K
3@.13SE<C->@+3HYZN;K&\T:-+IW0Z:66G)bg4gN>Xf(6gb-@A1)POa@:H(bG:+H
9AE]e6,]Y(_V\?@:L@18=E#(fL5XN/b1R\-L@RE=WZ1WIF#c0A<3?XZT,QWCeE[Q
0Eb.J<;MTHP:9TadS0WNO)OQK>eNPGaSGUEb6Y<3<_;bMC.aI#BaLMb]335N7N#1
844cLNW?[aHG5;JF]B7H6T+5>N+#QZ1@>?;RU[>fNE6#[?LE-K19H1:D/B=;XZ5X
+-BfK.M/_F_J1.Rd)PG[3P\X\\9_T^(,82\b#)(\TP65K8G9)bY.cPUT7(FZ/W33
T?@;W^^LCM0^D-0VT50<QBLd4e;^L@1CaeSGfeI)E4I+UP=FI7ZUC[)UQbH^,:=T
<21Q3DH^I(S_-PGaGVP_)fFf20NO<<[&LI:3Y/3d71?/P.7ZR6f(()_.LWK@>J.e
\=R2[\9R9:.Hc;=L1I.[VfVLEY>M&K81;ZGBL@c2;(gC\&T^f9a#0@(^WF2S@\))
QVB#3UOYXU0]bAQ21_U6N0]RD(RJf]U5M:/@RJ5Fg4B/EF:_7f6aTM_d,2,OZ)GD
K>c37NOHI;,4H0+8B=<e_JBB1/D8HS,[7b?I&CO3=IM\_\UM[@>+-;<MfRHR4[;R
DX:L/TDc;KR79WMMHOHe9.Zf5=D30PW;4EWV4QEBZN@;BJ9C4G<TUZIRELZAG?bg
^-c:UAL3c62FWeKOP-9Ce>K4(Zf1-6V0+8(cY6?f;-b8K:(0K:/6La;A7?W?dBVc
U&.O2VOB&4e&8:gG>0UI_U[;S@PXOOM<)Y,.,QeDTH9OVgG-0:a]QQ/eD#dNY))Q
:DM-]3N+g_J#[1O3Y<P]ZQ6K6_-TS00BeZ0XPLbWf?D[K+d8IEN>cJMaT94Kd8JB
=^YJMZ09g,6-95N>e@0cZ_R[^1UC2^9MFR)?Oa(,,;DKD1PZDK(O:EL(#e=g\gNL
)IQBK58(1eaTDb#.&bYDHeUBCGR8aaZ_4.S:fS)HN),[H)SQ.9:ZF;.>,:#a.JPE
eTWcUVD5D0S2MgX,1T-:cIga5PW24+(.K&;=NedH:\O/<5eCWM#e0TIUM=-e7_36
<bF\-FaXB=FYF9aB;8QG(:)1SdR23MI8M.3\dc4SG15L3QC4R]a@bSC:3FFL+J&#
)X)Z=2cPe/X\EFX/@@#SKb;BYDCaZe1)dD6O5S@B68J((?NbWa+?Wa_Q)GgBUWMD
@(QO<K,;PA\K?M6SO).]M=5P3U;YTM;aObA+7I@OZ+d(#0[3H/1f<a-1GTd&#KCa
,]T>@GS^,,854OA.LaY?XBT]0V_.R-d[65/OZ>Cd>0(?IV:>7bKGUf4Dg1^F#&@<
)O<G<^<@,fF^P/^KaKW=@bd=XfY(7D..QT#@1FFV0ZZ_Ba]DAW/S-X&(FbJ+UTE2
cUK8L36Q_2fI6c@\7DGUdBg=H#\8^4ZJXX_T7,c-&V?O4+e-T+,LebP(8[N8M?G=
B>@gcG].G[Zf>g4T3D9)F@SE=,7>Y0AF97L8/7^gO;6/PJJHK.,]&f2[Qdf@.Q3Z
M:EE-PNGH=Z3L(bX6K93J&214#=e?]e2+V7XYPJ@JCdWfbMS4#5YQM]E;DE&)ScX
Xff3OMQRO?<QPT-9D133bQDd3F&W5RGOgV>S5W/6([(ML2.?f??O;^&T==V,dAJ(
-EbIO[A3f&8Id8;2)VL[ME^&0Q-7;bP]YVd74Y&31GM4&[gL/)&Mc.2?V]7(:J6O
20<;W^Kc5J&7Z6=BNc<XO02G\P0@E>fJCI]/JD44b@YD-8eIEJb6T4&,1=&(a5&R
LUE.]74F/<-Cca6g_=Z:9gO34W+cBQ@9Y_cLMKO7g=83KLA&3eX9BeSf_ZbVg=?^
W>]FV9K)V=Z\Q^;PT;e(HC#LVS_(fW_70(XJ&3^3e/5K6O2N7>]6U[G_OC40FeaG
EbS+J:PGF-O5_O@G+&V7-)@:J8X&N3&EaAf>,8/]cT(NR0RE<-Og86?X)ESUT2WP
)H8)NM6Q\?c/^O)9bAN?DK\gQ?_KK<RS557HQB>8/MNE=MO]E:(FRYW()1F]IeSS
0B1B,,XVTU=+;(<,V[@f;[XH-A6bQF(=KgDMdY@]F(PFV;Yc#@W-d3AV4[.LO:Na
OIVX&@b_P/\4P2#-D@0VTC[G,<F?NffK+=VdA)Y6e_I2IGX_#b3HS.5Q-4OD>@H[
UR40GV141dU)EcO/dJ7-Fc0AaX;1aP>V4Y(VI^IQ;-<QY#;F;-1AIKEDSM_I;Z0L
J1<._+..-CNY6gF>45d11U9Tf@RbW0?WO-@,:MH9<7Y+eK.\)[NOMJGU\OLAgg/;
>2S4A[XVZ:9,We8bZH:?4A>TD.-\e5g0)+.dQ)a?YT,?RSY(7GM1d)@=bL-W8A#X
fJEcENEAOU#:ID52/T&[&=FSg@:S>Q[6^9-@Z6FY/D9+d<DGCPRQ>&S\202HL;CX
T6#X.-[RERZ]27:1UK>Q29b/U>>#V?HK2R3^<5RUbg<1;[MJ=?PCN(7C+J8c-8ff
@O#gRQNW-S7a,O\Nf\EJSTCf>5OfQ\T[PUU+:C>:WR&gSB?,3Z=6TT8:fY-B;>C/
8=DBU4G[[f.SOP>_R059WdF7@]YT/=baGcXZ-_J<BY?c;Aa,eTMSXPKMcX5NZI-9
\L2FA:bA[aE78^V@fe1If_d#@&2?^,aK5M6XFVT&,^;8AO5K7?0S46bJcMZ[c6Pc
)fEF>Z(WgT>,bLZf6fIgL(M6)AZAT>3U,Q(0,T@[1D/28.ZU6\;7@<)DbL];)cME
BV]4?661cYQ<S6HO?(^3@;SSA#CPTXcEcG:;V4#KbH62gFEDFQWOVUZTc.db+9;M
&P5G]GE]HG_B;QY?FFgUFd_O@X70G)TDZPS&W0A:N_)NQ,F5A0N#LM7C0Z7b+?Nb
)Z?U0f_/<9@#a+H-F&FSMNf]]fQ23IKR^M#dVe\HZ&<[]cg,[PH9J[FO;U18DAec
ALFNA_:&-?2AVEI+.bAV5]e2fB@6Xb4HJL4Xf)C\N=P.:3gXM&YQcO/D[fMC8=c;
UeVX:M/>5)a[R(1TL@-;/g1L-&,Z]M>-[;3cHMLfUTObF=^?gg1c,W(G4U@13B9-
ag)=-e8&;W97dcSL^;=0J=<G@e^VLd3YSNK(>,Y+/M#CP?2=BN#)MYFU#6/,X]EO
84gNXP^_UO)JDB@_RL/067I0]ILGc?W3b@/?YIE./TZ,O^@f&30JDBJ;N/V??N-6
:beQ9DS(+_e+@,8?P8?20]]<:R;:\ZfH/,Uf62-]-]O62ZYIU?BT\N[eT>3aJMC:
ZAMPOC3LVPW;a=(8.U.Z/1U6(3F9d)D]=7=T3>02TbT=\+ZBQc)@\UBP]N5VF7+O
7CGAS;ge:01=aaFMc2^MQ@>3cO.14-08X1@#_W7gYO8&CY=\ML3-@9COdW6_TW#]
GeO<,A6dI(gNgY2)@=2R;2F(LI5KWcBHSW5>Mg?4>6T>3-SUIOTWG3UN9KG?+Z4[
X7H27[2N.1BS)IO9McCdaCLbD7FJc9;[E2,NHS9J:KF?UbE&@.AASK/=L7K;_/;T
L)V>&L8e72F.ZFbX2LaY3E7>><f>eCT[B,F.__807)c/bSgbVKSg<@\^</F]]6Jb
d_,HU-K7;cagZV<T=E1R>A#Y_F1(](7dQIb3WB-CS;7Ue)T4g_fO)^/(P2G_];X@
RLONP;494+Ta&ge;e\B4^?8=):Zb[CX[Bg\OCW9TPI@.T/SMEY]EVR8RaXY_7I,;
N]9./8<WD:a(Y7H7.ITOYFeD=?6LVe&ff7FX_5RF@EI-C@0@QHF?RY(J2Nb<0]_]
>-8]eKK<(_QIW9)],N5()dWUF6BK^&EI;F84-&Y)CY)-IHf:Ye^]]>1O8eS#CbFF
-Xb7TJc<IeQ.f++6^Nc+17D/ZRO#.@M3U#N6YZ?a?L+/X?&W6<D7U(#WgUO#=:O^
d[2\^_Yf.=c>T\ZSXT-+VL#,5/(c[N8J)OUaf6HK/g8R?Q_fDb+GdFd0T-1N#QW(
5)EA09PXC/PL-&UDbTXM>CJI2]KZcf=^@RDDQ:<>+[,8@adO)4<@?-IOfKDMIUK&
1Q.@N-LfT18JC.aNd_RJ0fP/(&N.^NgZN?\R,F&e1I3+-?d+eM&#L=7@VIAF4.Z:
BSIW[cL<44,7NR6M#[@N84FV@RDZD-(V-]8?Q-RUa7;db:QJ=6e;fFW,E91:&(;/
TGD,Xeg74[_;eL()b\0;;([Q:H22Da]J3KC/O[ONTZ0P@PXYO]YFMF:ZCH-\f;3[
c./=)>RU+L9e]:]aO/]4LQ)<402[,[4G(+[GA\b&ZB6)E&C8K7RGXfa4[<Hg67MN
EfP36C^4/+Y?2+@YZHXA02f3C[aa8K6393(@Ua0LXP>@I/G>WJ[LHZbAAT-0BR1f
P<C-98-)8gJ\>N1RcccY\[5#CbK)H1b,RM;O88QL-;W[.OERJSV0Y?cJQ&^f^b:a
QOD=VLXa?4EHbZTa)1BUGZ8Q,eSMAORTHfdQb/81,5+<F03=T(33fQQ^09ec.[C2
ISS/I\JEZE+D33P6(F=;cU36P+e2L5]K.F8MQcA;GG0X8>-37_\H2gHSB)0JdSN<
De\.;=X,gPCTdf\G-TS=W_+^D:f#6<5ER3./)Oe,KgZQe[8L.BIIX(:BF;(UdVFE
3?bKJ,=:J,;6,bXIOWI:GNPPOH,>4M.bge)^6MLW8fG]G;:[BbO8gGaPc3]<ES=T
LA(>)BFQ0feJ++@7#2(DMD(J/f+HULJ=fbe5^OQ5@PWK4#:1C]C?gE+X2S/d;L5-
(;W=+^>gHX188CDL.Lg)LXGN^5+RO0CYb=bL<-Q^[Z,H6<K<Y-bPT-;dQ>.-M[A.
2dEV6J(d)75I7(a[0HLW>R?RHUIUI<be18,OB[DGP)^9A+Ie?W_IO>.c3P@4&fU)
(bg9;PFMBa.S:8gKC&N6(;&[DfCb>,B_dUT1F;eYeODWOH:7L-_CW8ZD^XW9=;W.
EA^__URW_\&3f<bEL_C:ZYg=ADTV@>5e_H+e-2[OTa(GH[)f9BL;-86Hg[dII\[Q
P>Q=FWD(I>C0):8JJQEK[X#9?&9FB8/gO2Uf+..1Xb)f1LV:VQ;44ee?VOVc648K
:BYPZ/F]2:JAdUM-[SBI4G+)L)Z.5(HT0<G6#cg>PdF::/F=@]M0_HgW(>T7Y(LF
@](2GeLI:#cST.;];JBKdEdSB>eM5MJa6\NO:.Wa[/FYJDa\T4b)V1B96+c)X=;E
4;OL6A02c>)ZS)NQI?U(&?A0;3]FE1dLN;VOK.G&/STF<ZL>9C,fDcgYAPeJHETL
.V8[2ea;GcfVc4:YW#@XOSWb^4KAMOCD3\>?1d=X<JIDd#4b=;F-87_7,YY;6.;S
-<JN98XZ/I&:2GE6_.[4QGP1><28?&P+Q?FO0QN=HJe.Ud.4IIbU3IQ1Q^4MT^LI
Y7E0K_GVWA@2gTNAAL\0JD^Oba3YJ2W>3=QaOS\I.c[R?g>1@dE+)&ZAG/[a@6g^
BFXdQRNZ:CY3IgPL59fMgGf&[bH:YE)UW1MC?V,K2P<-#/)>IG>L-R6?8GVS(BWP
3#S#KA)E3\&YV>gSOS[CZ0DdGV1GS8f[B;@(2b;1Z?L-)#_BA=@NMI0T2LgM#7L>
6N.4J3,[<g4V)(1O-YY#4:E_T1UB^,-B?SZ.CT7C1f<?N(,.F5VOf5@;TR8C?7:O
&AX#]2AY6#T<@?9Z:YeER0:+CccUX0S3^=T,P^@;I2L)KY/Wa-^R\<4[@[7&L)N2
VLZ(9?gLKD@eUJ(:Q#,#cMb@CIE?@PbI1Qd->_0eg4fU42@G<Z?[^PH#c,aF+ZX,
,5QJ=[U:U\4+<)E1-d?Z?bNC@d9cJ+)-8#G/:G3LQE5\P+QXIA#L13+->--:E+,Q
0_JI;dX/SXSZLXa7Z^8=_;Z5EdP=bG?cPP[.]4/]@YDW7-+:CXQMU#gMUSVN-3RR
W-Z.=L-]e^W;^1,:K.U&6KQ;9Vc3H5H75g;+6,eI&gc0K(30)@H&W>VfOeJDY?bQ
H7VX2127cXO89TdGN6(X-Ef>e;99eXU1\b9ENIVc2?gAQFA(,SO;N.2,O9f(E@E#
^O4CFT.3e74b5ALEgZ/IPf&NdK25I]+AfOP83[S5;(dDfA;L4N?JH;:#E+g]2;<:
NT_Ng]@Bf)Wa&/fL)2<,,;=IB0R\_-(A4YDPJEG]\X@UIf4L7,eTQaeF[0S+O853
)e+>]N>,(cQA?PXTV3S2a2.5T0Wb<QM_3@bGT4bHMA<_Z#3,&P4DeD_;HQ4[fWQc
aX)+B0WH87ggdg9Z-3Cg)T(>G+.#XX<LYgR,(dONaY_#JMb(.3fMPfdR\OW;Ab-\
(T\2^56Y.<b3F7CI-SCU#cL_?g2Q)_KAT/B;ZAdU5?cIfC5GM@ZM/eRJ&2f-.REU
+04Y(D.0]aS5P(4F)a()+;_cTNYDf@+9<NDCaXbg3,]I\5aSGC)QG:=W,LY[aU@S
81F=<_^U3P)L6;@:S]KN_@=[B&K#Ma<C0K/MU:=>U^A2Y[J_+FYfO]E>SUCCWE9L
7D(KJd(Qg;BYK?X5UMcf=VB@JaT-NS2T\Rc7@LG5UZI>946aJ,Va.]G7M+=gYP)0
KR62Yf\,,d<FU_UabQN[I,D1<)_^62\5F##F?17VOWM#f+:U#7-(A_eBG7<RO)TU
=-Y1Q[I2YAY6P7bH?<\D5IY/?5A]CC\,ZAD4DR9b7O?5,<JeUE/C\gME#0@6N/.#
ec.7RdH:c\]&Q.WIOKHT?4>1bZ]g^f=V+R3b6SLU@/P.9bBO#(Z#[P9]#?V5>)cT
3.2+0;=P1U0?M3g6.c5=#R6>CB-R-_E#R5Y&)]Qc]N,S#d&bdIFWW)N73^XM6c5B
&B9X;ZSf#PPW?H/YS+EC/U556)]Ie.U5#_27AJ45&1&OMeP:X5Qd_1]G@4EP?[IH
9SO5ZVBMC/_>#(P;.0=^G6@TNL=[Ya,?3]&@0fQOc)9gZ346T7_:/dKMCV388L93
0W?LUG509&];?;M-5KPIK>Ua0A<=6/;FCM2OQXP-L-3WIF+M?f]S=aVG>5:9Y3RB
[479XKGJJGGV-ab+Z>CP1W_+Z<RUaX#?@X?QZN2e-7ULB6aE5F<7Zd3+Lde7EG(S
bN2c2(A98<7R[P4+TFd]();S:-09->^cDb>I/@f5K[b=&]7Q-cH4ONZS1^JXHT2T
cFbOf>Zb/3:1N:T=H:JWa1f?^e(5&#,7HSIY=\b+d4P,)_,0VaTBB29\S_@+J3Z<
0=RU/^_3]XEc\E\(:-6FeU^-bCe^/1S]3ODWg?H.34UZ_JO2Zb#YZPXbZc4ba9&6
[(GONHD7INOdE]PERF96Ub:\gDCd(4E(a5[2(3Pc#_g>4K.2dE@],;7VTd#89ND3
A@]:K@Pc[3(MI9LCE[._O23#VC/U02Ya:\?M9?8]]1<cZE(.#SN^L<>4W)[L)cLI
f5;DZ6E730932G2V(?;_O@AJJI89GTG2&;fG/_-H9H#M/EICA)R7CF5[:6,U;-28
DDTG::#U&>7\bA<cEDK_CT@d,)B[KWcAB@fPI8I..NNa)^9a-(;7;S.GOIbGRD?5
4FG/,BAZfT&Zf5/U6NADRLP+(#C2T;#]XA4WG;<]&-8A0_3S\Ca-N&_U2g)^\700
9)G7BH_N>S]6b:\SR4AH;]/@=+?WeHII<\.?GWO5FVaCL7J9bNYNc#gM9fL>7Ig+
Bb.5X2+BCA\,S(6b3\^g#fDCa<Mf-Z]Sd,,.?7T/]1>4)I=+V1/X]B^fGKf(_B7J
6U-56FNaaIA2SO:GYA#=MQd\2#X:T@WBDC@]:_cgW,;f@1@IT,\.KT.X0+^b#OdL
63>W^CKbb/=g+8ZJWF^_dNCH^(9KV<U09@f9<bZHeRC[-UUGP\T+^a:[F.+c1?E>
DJ_<gaA]6,&B6(gIgPVHV@XKTV7N5C;cc9,SV:CA)>9;VD#G4RB1^5df-UfSWGc:
W.#WLZCKc7?3]f>GQ8Neg_V0+&FYVcf\Y&9M(<3\E0[c,XH,9fgZ_-TDDfC>S<3Y
SR]\S]\8SE@(d@AFeFNDOc>/g<O]dFHRZ>992#6b^PDTFgKa5YYQV5:<1B2)S)A.
6WOZ5&G&0G#E^aTc4&9P9DGD\R_W2<GC81,A(S6O:91&P]3f@RD#<D:U_-R0^.?\
R,9\:AI\bXca=>7XCD)BERDQe.?:(7BO;a2S6T@G)S3.@6[6H)Vb=JJ((@>-_Ya2
Q&;,;d0ZDcPM_dLd\(C43c;C;^=\d5.X;GSWV.S@]>T,N:B:REGKSb;/TK]G=d[?
:MMT2C519cG>^cF?K2KI(f0GM27<B>8+JA\TF3PP(]QUE/+OQ&+V?<<39L9FUZJc
L)FE]G<dH84C8W9BM@BV2SGC[&+7^@RC2-G&[HMLH2Z3O6F(gdK2>c\5)LD<J<#O
?Se@EU@T^9^JJ+@):_4ZT1S<O.&824Z/16FH(F1#ICE)16>;UU.I(VPZZ)a;HQaT
K;5Gb;XGVE)O11G[]J9bV:CMa&7bRH9M-M;5>-RXK)ASYb2#HRef[,8^/33P,R;]
:OD(..-EC]Ag2.:DEF?^N79b:4(dU+e:G-c[84:EQ<KfcMfXF@e^QV\?F/<3;-&0
=O>&La94G2TZ6dZKCY8?9e;K#8-V6/TKS:c8[OU;(7bOE#,#:220T-O94J)[VJ=6
@dWg,KbQ>O;]FOd>PbRcME4G<aYF(=I_OOGMF[@5_N]XTF:VFgYP^cbZTBS]?@)T
?c/6]FO_bBN.9GGHT303ef8U=PI-0;L83ddfad8E8DM6D.7Q[03c44E+X+CT\\BV
?>:G+KJT\V::6;E;QJRO16,9\5HOV>2a:J3-?J?\8;9-&,6(;)(gg,0E6HEU3e4I
STVQ3YF_@TXe<\<L8AZX1&V&O@O4Ub#R-g)R8C72OT&Ba(gO/@fa7;IYLO>.-ScO
f5#C-9MNbCgJ\fC)e+8FGQ<Q@1d,DRZ7JQ+)QG1T-eN2YaQZBSSY?_7IURF(VCDS
-/CRH9:A,7J[]O?E)0ZAQCAaQ.E;<SL.4gZ/Z.P&\G9W:c1C:S<S]GVZ\SX@^1.a
J&XG4TP2BPd8MLX<@cg4QS9JT<fNUDN<D(LM_:P/AY>_AUXLZ>IaHd0F]PX(&Y)]
W6RbQDZYDLNWQH\+dLI&FfN,Q9_;Z]]7VFd>R:L++baCMK=f=T59#)_0QIa@?La5
)X,/g-2EHGfDU,>Q?Fba/&8_?EC=D^&.4@cS6XU4>e<d6^)19T?0aeeM=Bf&TKU1
,6<(&JRIPIHHV4XHLG/gVMX](RZM(;Fb6T+g7EeVNfJC+U#LT:&YPG7CaYe;<040
SPWX2<+Ac_Lb2He?]&SZ@GJ6I9Ug7W)YU#GKJ2=_#T7X3CUA;5f;/V3KdY;Z-I<f
5KWQ,b/C<36DZ(:V\C[a3<gd8V?SA:#=(RQA&QXJ_J2X47(ZZE^g#\5RV\<7.Z;B
>/=gAF(d5[-HR3&[Y]eDa#&?MVWG;f[b7@8M;?^4SXKfE:@PV=Pb6+J(65\17#<J
^Q559U(P?W8@6d&dKSP_YF.52[Da0:Y.9M[6Uc+e(+BIS;1PfRA23W34K,YF,2(G
Cd\Z=Wd7IaJ,^<T)fYDA@b48Ec>DFd3U?SO),Ub1UdaBS/LU\ND2ZQJ;#V&K-a\J
bQ5&44c]P[BN4<?^53[gCL=+d1]Z0#&cO/R:fR(eeQ(MWc-e&>G>=YM-.RBIZTgN
4e=d5:K,P;7#7KB/_[K<^2&PAWeM8<AZS)]]EdD&;>R@[gX:2PJX7F6N92[8MLcO
+5Kc(V^LVD,F3^1\7?a([:+7&.[<65^9ebNg[g&&4cbG@G=HGAB[d36MW/4\6R96
eOdN1ge?d>1H,Nf._C3ISb&YA+.d,L<J)N.d,/V?F_T+=:-<0+gT.9bf11)b8>@#
:DW3WQ2V=JA=XM9fMT18[WQ.aaN#FNC>>4&e.<6_>;+VZTO-J\YcN]X7HU11V+4W
3bUX4.-(#SOCGK8G:0dQ<2:3T(0J=c0(<5]COPK#X#P58[D9Dc+Q1ZC^2eL68U0L
N8COB]SXc,GdQSBG3S=7.2&+&QWN6AVI#8P[#E1(U42c4f=?S08EJ67e\9JGQ&BO
F9?:EFVd.I0SO1;-^Q523.c&&]4_a:2>1V96@=7de,SUe):<Xg\&0(=WUcB0?(J-
E&a46/LaZPB[_[X0D[ONfO55R],cLVF<&J<K<32-gO&<@Y25LGeX-XJUF@K?K1EC
&/P99[EN716/4?./9;aQD+/LAJU_\L=++UKW=^G:ZI.fBP^@;O2d0+3[AW.<:&WK
:FeETg?GDWDJ;QM(E0F7a&KUY,B@,\OI-7\)I>c9E2SVP_@E)RXbL)WR9,JW@/P+
E=AW7#MDNga=DNeU4XCA)DW?9Fe&J^B.:AR[DSUWdGP;6NILBF]dIL9)N@<Y:TT&
A+MIPA7GSP6ASc.PNN)<L=IF\DUfIcWCQXfQLQCQ#d?4.W&6T[GbKKT@T3&\8[X7
_]M3Yae#F=TT#M\Q</e8RaQaFV.Ne(Z]ZF_+,_.FFF8d\6&;#b:R)I#(<7L4J7e8
J&fC12Y]:DF_-/)5?<GE(-JTL]EG]KC;1)/GDS9H&Af@Q0aX)S02<]PVM_D>1JL_
FZ7#8[4F8:(H2Q?aZB.JPL@FNbb#5e-V(Q];Qdd8+6d5)_b)S+ZV2Z&9CEY6HS^=
7\Be&.I1K6)A.Y[],?SC-La@BG7](cQXYP1H.6DVYfEY1X2H5VC5L<QD(HefLb^)
M:CD]^^dEZN;VC#/>aG\[Ad^-5-:.L48AGWXN>(6B.OPO>DQ2HY]9e<a:(S9([4a
C0^I4@fefMVTIe[^/@@4^YY-d7R)A3P+5]#7J09+F<H)S.f1M&eU(6Q.Qb_^;=NP
L_SUJGSS6(gf48Z?6:ZT:\=cJ1XdGgb;dBWT&Ng,b?.&Eg=2T8Y;OS^JU2[MQHJ1
(0_J4J6.2#g8COL-QDg<_N,c,#7Y<.MQR3?LfF2?;Z7H2JVF&DdWJ)\33A>WWK=U
7C.J3@&.(CfF55)N_4CWH&OX>)7c[)@e@&]YgW_f8V4G,Q_OV+O_#bd?Q8eQI;?7
<N3<DA6E8I6J=@I#)D8Z(,Fd+I76<R0HKe6P+LUdM_(dKIUW;L,aY464G05,</aP
ASY1BV.9Q]#;+C88_VSW\3\FC]2@S0]/dQ36:Z4]gXR16.5fU^-gU;;[g\4L0,Y,
aEfQ;&G[5<Q^9_T/INb7\UCbL0F&G177+BeZ]2AJ_V[MZA>@9NPG//+,N_g]^R0@
N_QG)?d#Z51GHZPNM_[.^/cgL<OVM5+YJBQOS<@];E5-ZHCEdI_,,5[;78DDGfW)
4L#dU0LNKK@6&bRB_7-T/44^KV6HdKMI[9AEbKg<_b;a3K_bHf#1WMa:DA6])T8[
01GFd4YRWGOeSdH:ZK1^FP-S)(-<YPLS50-T3SNeT)>e3J:_3>P#dK>F1<FOS)fX
c4BgW,N?LYWV7^0(^-+8WfE<:=PEQ2I)596@M5)?d#UO0&V=VP?3gf#FR5>Zg\FY
dda_LN#VR&fZ=3L3Z^M)L9Ee^MF?6B_^bgb(IGUXOT]EeOJUQ-&g4L\I/&T[JYU&
.\f^Y1SX.37UfC^fZQbC,e,,\ZGbP#@.cS2R1HD&[@V\Y=&X/5_BVCP>FR0dC.(I
]SdU^f9DgP#+Q.,S\0e:-H@1,b;_(OL8[BMW1T;B#Q.DN1=E?S/2fYEC9WLRS7&b
,\f0KQf7@H\](7-.F[AJTcA68;cLL#KUd<@T+K.YX:PcFA_+f]Ye-26-+e2&N&=,
BG;9._)<9Q<1[P<PJ9Z\LYDTfIQ3F=Y8,HJRYGgG42bK:_B\9Ad<,e+<ME^K?cQJ
^?GC;Z)R6NHJO#X&XR?e1Y)(T[1J-+9(0FE2HAUEIc_#A9NIVId+QecQ0@L8Wf3W
>2A^>f=EH+d_#OR.ccWgKVZ@Ke<V^(^NVO]AaI7d_NF#<2BXI16#&JR/99))BQg?
XcC&[[2WMZJ6aPVY089\]MZ#-d[=VP/:bP1_FUNVFG^KIA,1;9V98f;L/3WFK4U4
;>JKE7,XT+?^WbHR?2e/9[QUS1^QWV6)G2DeP07)Td37Kc[Z9VV)^KgOEEI/T1f>
Lf4:=4LX^0B6731JEZ?S.SL>5KY?IdA>01Y>2[K94-O_.,NZZ<P5f@Z0b:_5gIQg
1@)fe5^F.LQ#(M#K&VMgF1QR++X\eI.<0@VIE4<@6X>6P5F32DP32ggC\PI>:g_L
?a2E@F8f7[V?GV67DHT\[=RJ\^)W+Ga/;DK@(b^O_J-+6?.g\a>>\WKN^R,XR2Be
E2JBd;]-(L2^^ES)(P&VJRX/7@\HEb[U_^OUTbM,;O?@5&D]Nbd2:E6-5YS/0=#c
G8FWLGbD=XR&5[GG?@Y.#d/YA4=20,-_\1:.U>=]Ce1dW#Ze.(?L(CL&0^+bUGK&
6<2>BG>0<CTa)Z,bbc_\TMI4NZ(g?HCZa;FC5FKJ9MK@X5/Tb0aVDBS-<DYMYM44
&KYW6b3@<D6bP3_E,gL);=]VHVcLPHN\5YWK.O[-Q?bI7RYY=LH=AKA1Z+L,VTJP
L4f-(aO)X.UB7-3\gPg<CK.12(>dD320WIRdFK3Yf-3-Y[\)7MUFCb>=@faQ:(;>
Z^g/J<8+@Q=-IT?\Bb<&a=3P&K5/@6/DI6&0VaOS/DJbG&S,bF#WI(Jab^1GEU(I
?#]V_1<fGc/6/FL6fN/@5B\(^>MCbZ.f_HZg(@#X]L7e,a?DBS8Z=AaI+3;[6V:Z
ED^Z@<3M,-cD?K84B\0OC4gHa/;81KI5+?_ZI_;747a;)O;(SL:ZDgINCUSJJLMG
+3XJER^#gd\8F:B1gd0:?8-Z&3aUT0T3KX40I;=>-IQaTDa:+E=<]\TZQX,)\84]
EHDQHB0DP?BEggRI]DB;0>HgJ;I&HQ-g]TfEf,V6+aLMO0EO[:/C-eUA30_QS9LE
U5)MOY:Y=U=Q]PEEDINAXf;OWD:g>\>/^EBJ<]I?7J<A@>\B.D])0N7?_;PeH:Te
;ZP=P4MRgX-V^S-KY6bc]PG@A.0=-W1.V\#INF-\74D#<:D\\F&e/+)OL#Y0A6<2
AH2^cg8ADD#M(Q<Y<]0(@3\7;P6W]^CcPO1R#-:A/KHO//c9MUcEH?Sb0(I?.L]0
HW)&?M<E@C\cC,1,OM3cU_-1>F/N_bLNZA&48#^MAOBb/<FLXT5YL(K)AOFgIWE^
;J_0OJ9JU?Q./b3ea//D\0VHS9R];_g:6KO=+gE3?7d(O82aH>Dc[#PbO_c4e0,\
(CW?Mf#93g>W#c4)65<D0]Hfb116<g?(+R#W[Z:#^M^Q89HT1-8FHdZI^=W((RH>
AM1)>)Z:AeLb]7+KK9ZT[A&UE+\1HF@=ZgW71,1=QU>SXVM7H9^Y6K9K7[OS0K6+
32gJ</,M;^#1G,4/c>56cL0[JgO0a>8UJfcV?caf,RG:RI;eQ,I9a&V:RMJLI^Z_
SX(60Y#=L=AE7dQNV9G/J\2IYQ++c4JSH4NJ,ZCR:g7/PJ-=IK],X;L<dDg.:(F\
Q<.a-NQbV?FeVfKM(:3QGV@R5E^g)D2aOX&eH(a#-A#_W7fe(ZA)#AXP=HGb<K0_
LB,=5W\5=QDM4W^R,=fI)Q5&LI(cf]fNLV(6V&UG8XDF[4d#Q\N/)D3-.DY9fSNg
GF:gP^EQgYO=J:8_X06K3eX@ZS-P6Cd>eb=:WP;:4NG#<6WZ@QO/0YU<a&KfU)1&
gNAY<-0A4;e6cd(1>N&4W^2d++D71,J/74bU191RC_/A[(J0=F;e,5B@M3V4T6Te
[PM,5A@a1<0#Vg?IG\.#G@dS([,&H,AH:KW@49&&.GcTFfLEgI-8R;<OUDS[+JL;
Xa680=-d#g;A?b1,L(F>H-NZ[]2a4Q21#dPY(1B8=NP1,]:1:3.7(.K5[DCZ>:@G
WgQQMA#g/G:Ff^L]bY#??>]P@>5V=:78?U_dX-M3=3X:=@-WbPYPP=@>_,>EUN1T
#)/D(>H[)PZ2.XP\W[HG5(6,\;0EG3)T<3;?YafM73K&bL)=V2[5N6V0CET+70IX
Y(>/3\M4[;YaO3253Y^>>L>8F-/_AKLA_Y=6EP(.3aT>CK:>(&I4XYO(^BCC8:GO
f0MW9E8-g7PS99#YRUE=:)Y.0f8Z4EaC^_82M8:+]c)@+V&VHIdHJ,b5T2.g(Y8?
,b@?0;\YY)^XZ[2=?cPU0&<UL;GTCeM;-<b,Wd14e=U],TO-S</0VQLg0P&(SFXO
cbfY,eO<[5Wfcfd_^:VaI/#ZWES>D2RO?G5g?<(CJGT+J4AOcN1g-\9bW<#2cGMU
4##^PGbBcfZHe8G86Rg7NQS9N:N5F&9&C><L#JeJ/IFf6AA45#d2BNg/;\Na6653
KBDZMaWLX&V?YJ0a([dbY<ZS?]^D2dC;:WeCA4.&@PTRc-b]c4fZ71X++DB]KJe5
3Z)S:\:OC&HMc-4@&P?5<]4+(##,)^;H2DBRHP.5.3[X&(WS=1,?X^fQg)V]/IWA
)PVSR@M>CWJV6c,S5\26fLD&;gY,71XOe2d)+UE+7>_)bcSd[8ZMRL0JW_UA[:CI
I3G2T_:#7L?-4/CUH/^<,A&]g(^2]Ie2a,0ZL;f,f\3;5P=Q2?L4PE9Sg2GTX8Ff
8[2-#_=1c5DQ>KUDUaVE2.>.CNNVC_&a)RFH[.d[2/.AJGI(5_N2G@(GY;O-QO1a
WNL52T>Q0)-8PUU1))C]H.D^82C&3F/<=+35L;U[Ff+K?K;A0A_#7>=2)XD7T23.
NH@+Xg>RTf&&K95K>9KE[_eO40)bCade=UR_R,H==D3,f7&Hd88LTPcPfT9E/TKb
0fEFXE7DTS8/:P>D:4^fD?PaYg.&S&V:FZc^E\WN,Ob0JfY/ag70T6EK?P>87?-9
e68NCN=A7Lg\5],;F)?c+0Ega(a7WE24=Z)?/P.H7g4D84EXgHLa;g+N+H;b=)aC
3-GXgA5S<OgZYCD<[3L4HI,WTCL.Be+U;^6YHaX\1V]66#V]/DIP4(69bgB[[(RG
Wf]J#a^Q]eQ+.F4]K2RO)bQ2E#V\4.,/.f0M_-8CH5f\LR9[E+-Ce5f[ROO=P.I?
\[aH9]GJ3DE8F8L__TZ8KFMENe>^;4DR)_?:Q)70YeS&Q];4MeUf+eJ=/6VX71g:
L1S;HPSASV(.Ba0=&#UFTCA32e>RHbT\8g,RBG-06TaU;))(A:@72/:]gbba<fFZ
,Eb4C+NLL5L=F,UM194VJ47<>c,Qf-XWYd6aMgVDHfbOGW<2B#0O[WQ7]A>.:P>a
BW=TO25e50:FS]<.C//CL;04X;9YIE6c/Z+<Yg\B[0?0KW=XS>6G9+.4O8GFM]Of
3_2B5Ag?)YS+[[]D-[;L^8J8BV)<R]ES65b^_f.G^a8VRK/f@15:Jd70f#Y+O\OK
UgHDB6YK.(A7NP2OMd(g>I70-U=:a=QN(J(=b:9(-KGW.YAf=WeWJH(E.>fZD4eC
#WP3dK@cA@E,0U;>c=gFA.a2H^>;H-GH<><I[8dE#M)b,9=YS4Qd4.F)-]1T8@XK
BFI:X+fSO5E6JPK6W+0WB&,8\,=.M_.X@EH8O<ZW6V=LA7H2M3C:[0__SQ5EEKER
dB9Sb)_:a1Z9c7Q9.FB7OcUQ\eTD;MMP7Sg^9GH7)/OL:=1-=0T3.IX#8P@+Y09/
c5D:9_=)T]TgBVeFS2UUO=VfFb.>?=_V8^JCWgc?FZ_J/24IaL(7WaBB>/UV@@Xg
a;,D5NI6fE3g=L[#R;d+Y(C7T(5)_0\CX2]1?N0N/ANb@A;g+RBY(CIGdT12F^E7
fV)N.ALO-80J?W2.0HC:MTdT#PMHHWV85HH3T160_1N#Xad]eH?MXMWZe)aSUN3B
0V;V<M^GTb^>NXO.Nc#DBWF7[=_YD-C_\EBH,1&9E,]OeXbIOYCE>;DaU2UR9_=)
b^]^,.7C,;T+\M,8VP6;Y.5f;GM((W.+,IO>\J8VLLX@T_:6)5Jg/E\09GZKFK-]
X:R&3:Vfe#NI/1L#0V2=)G:IMJKHZ.]#JbE_9FSO1dE5B+CL:TO<,#]_7:69bTKT
SR4<BD_TO8))@1Z]>7V)R00D]K=d<X,K]\:2cB\_T^MM+Jd/GQBRRP#f\9]OC>TG
;#e[NJSTSR8_0IWc:a1fRODJ;_U#Ig7MSRgAG)Z<0B1F43+I\2XS#7dOcO;HAGV(
d^R&BMKM;CZ5D\K?e2gSFM0(-gEW\cO]0J=-cAE0R.:A+(2KP8F6K7a0:0(>a-g0
^8J^=1UfK3:WDQfQ#BY0f#(Q:ge0eX):.<JVGY,):)V.fbMVZ/=/9:f2R5/]ZN.:
bM\VJ51;PUf:7;@>@(,#R1TI&+I8[]&82KSc>S8W96Of+P=6;DW6Y\&W=fWQ?/L_
;(dRIY>TEOB<<@FV-93aOWfA[a8TVb^#Ya+CR=8.ZPY9>a6DaO.].))_@K6SYI^P
#86SNVI_A24+R=Ld4K0(S.ADSIYGAC>6eSabOP<1NB]YA@&13fVN,BKNd9e@[e8d
N\&e2K,Xf?DBPc^H8JP9Fg30(4V-#G>W8-(+055D#<U,;?@&GWdg6I:,7YDXY9<=
.9EZKQ[G;G4I>Sb+\BQC.9-f#Z,Pg6_2O(X3<VO+]7O)@1)VN];N8(R,4V_B@P04
A7BLaS6:I/<5;_Ega0MaD\aPde<LF8+5Y5PGMA_31HaQQPI#+M(OFI=<UbSfD-Y&
]9NG3CF[,SK9^,FG&2O1NTVRQ#YIJO76CD:BSA?9_0Sg<##QFOUVI#ga72#c>#94
]gHSdZ2N=I2(?(\@UDQ(\>7bAbZQM#YZI^a05WUW]9E7-6ZcU^0_-XC];\bfU:_b
d?=O(Ie5ADAK4K676YSGQFHC-F37ZP-5N4PGB<LHL@(?/H],4PT1]93XOMZ7bN>W
TbW0293?cRc+XBO>-WbD7eXROX=Dd?PAW=QCIC96-HRXCNZcD?R?I17QKM:.7W;>
?&=^5A&^^b4WFI:g@U/IK;VD&Ab](NYc<;8c8f6[6B81KV9L^c#ZBdLgg</ePac1
7bQK(_.[]#fXY1:[I0<cVQ_\88=?V6[@GREf3PL<AUWELCc.^B#<S9Zd\XWa_+U]
b>dWP8HIK@g20C)f3+N7VKNY40)^&PYbEU+VW3S],NbTQ9)C^H2cGHbC7H[1^]\=
FC?d\]PTcAPG>Na9Q+ZfPK[T(-FKV29WWQC1NLL=Y\?2]LW&Z3\?^(Uc]-NF&69;
DeSF20I\@>IfUFMRB+(MTOd^4)5Dc0XZRMg/YXYgb5=BFUW?dA3-0>H7Bd]CI>^F
>:5B9#GXL\OP/X)e8@)MA^HV<A/PX&IPV.JK+#))(bSL=PGcE]IeH8?.ce,VM.14
gFB:EH.1Rg:>MPPcA0OHcKX[>.b@W\@SH+F2#<Z/765.@NcVOOGXXO&eR()[-BNW
:KAdW;YTg#QE<A8&QIE>:+Ie2B]-K97H7VDLFP<RTVNOYT^b_1^]B^bO&]EXUcc7
#=170[NP:GOf89&@Q1?fSb(Q7ZA#/:G<;J#+B)Q8g/2ZST4R#YVLMS+2fY?54BHC
]#=P(3A-VF3:OQZF,4f7GOgE(QD)\HC#KKGD[VaD=W07ZJV]c.c.:-9)V/[YfHgY
FO(-^?KWF&-IeJ?/0.<G1R(He))CaU^W,VIM_>-CKDCY+(fe\]@O;?=dbLaL\JU3
gJ6#gN7>VC2W?YM5(]TK2X7EBZ)JcBc6QO0Q:7HO<L@6XOegX+6>bTC9Ye<6fQ1.
b+)SJP=[T9E\GPIN1A]cL-ZH;E2(OdY]A).NQ;B+0[>B?IX?gH1;MKZ[H6&N#N;U
Z\XIWV[HXE-Z;MRdZ.[+\]U.=\<2aZ2bB,SHKN]b:Tf+WL-R55FYAG1:#V7>ANPf
5:Ab3bTK-^Y,ORe#S_W=SgbFZb\X@XX6RTFM]eQRQ?&N_-Og]&O#0B)EOe@OdVBC
BW^J_#@aZJQ0H2\.[G4:3-HF=.O[>WP#I=&\^Ag\ccL_#dgS_1PaFQVIK^71@34]
MdOTbgbL=BDTbG+QG2Nd].?@3>a95^1(aMV:M^ID:e22QSB26(eAZQ3gU?:f0O1Y
JDZNcMZ#[GE5:eSY_1Vc&G:IGEA3>4OR^c\82IE5J</A0TW(dNP:_4AR:U##:KE0
<2&<LV:BK+;NW<deAU,+//_/8e5cDYZU;0@I_J0;1eOA.(VJ:6P;POX_f^)OY3[A
.D49Id<.E@9YI>SLA\B[Z1KPS>EZ?SWgZ-74&8DXR8-1<A@Ua?#3Saa:^e8Q0DOM
G8Q-NQA\bH/Z1JPbA8ff\::c[6&SYB9[R@@-][XHD8HVY3SPS[TR5F:\#[N,_?R<
2g(^K6@AK)HMU79.RK,G^XHK/0R7PA/19EM3IH>16XFc_6&90Y8V9C7P_b>^19J6
8@Ye2EIQX7N>5Ld4TUUcRLIUN@0<-@,HW_C0Z0O#3MIU=P7AO5SP3>_;UEW<3gQg
BV#91eQF(b5[RRPF5aF640],e/JZW20Q<=]._47WEE>ac+G&MW;ee(AD)MZ>IR^a
BVPYcYKaN4Sf@eU99(>=MCY3+1cU9d([95=7/:?9R+NK27e?XK#+[aRO1.T<+9gf
a)H\]0E2)^\YM:3RbCIIRcSac(C_9UIGId;D&ERcL+A=,)7G\B;-V&I=b<>[?0cc
Eg+c7g#O-G/]@453ee8A/TC5]cJRQX,V95NPF8.T@PQQ,@T1(3#IKX)JU;>Z9[6^
:KOJfC537]OCATROIc3?beKYLMd^+/@:_CIG]3=?M[DXg&[L8b),>.1H58@SEC]a
4J[_6F4<I\,VO&dBEc33YTgMNGHCQ&RH0ZOXKZeKY:JG5bH9-#+3P8F:aA4Q&FP:
?Fc<(gVI1].4cLCS^AQLO2PM[,ZTb\B0b6ZVHQ;3O\,@[d@e5KY0)cM.H(/(e5HW
OU.BT6+b;>]=S_4AQC(GD@(:d1d;^BN1Ig^-0Yf3KE_0<eCA<@d.1b/O;M.@[dYb
#\R3gK\.c)PF4PLOaNI8LRY@[D:9D8N^B/GN[SZ3[NOE&AHG38\d?+AG2c@;W#cS
AF^gDD,f:(<CZBGE&B;N&-XLg5(DI/U_XK?Se@QH@C&V+aWgLf4/?.J,f#8G&MTG
:_aW<X?\#(<1d>[PbMEW9A8P:AdE=?_8WF88Q^M<HG-TDZ3-H)_](IC3UPHY-34@
,WM6E#<8;fd7AL2Q85^R.Ld;bTH<&.@U0Z^0O>7W_U4-d#[W&3d4)=Q-2+_DOL#G
O^GPL&VTcJY=HBN).dCGV[-89&W6M^=.7[P1,J(0]F,Q4_?#>1LH&8F1TERDI7a^
AM,Jb0U4AF:3R;Q-QXR@Zf7H0S^-LD.&LW6L^#GNTZdY:^=Aa#bGa)R3XYQ4:S(g
\\8LM]c6XWgDFG=RZCTc^M3Q/I<UD\.g#_a#abTb8>eTSKb,GL6\\?F=\CG7EG.]
UIcf<d[O^HWV.PXJbPI[/?F.5g7X>+H6JJ7;6GZ49G@NZHf6E#]>AN,g4Z-(A^W[
UdS:dfOSQX\EAXCBaf->8=UNLD0Z/X?-f-+\ADgQ2MP17XcLS&K4>]]>-U8PVd4F
EEJ4PHAUFB5<Ne86RdfA:2R\]J4QCbb&P-(]MA)3B)AZIF3#J,.#aIZ>/=G,MKP/
O)f>gSYI=K>[6?UXc)g]-XE.--.d8XFgJ))/CdE#bRCE.8C:IX6N]T40aKEGJ9P;
d3W41b6+G[^7@9O3T^N1FVbf?:Ted;62ZP=)?]aOXPWBKI(._5-Rg1Bbd-8Y=K=Q
c)Ec[NMSYF8B>JBJB#/d=WN7XLTI&(;DFP]4a]IcGCC/;9]-JYILFELH,.,3^MK5
TJ+(KNPHWMa_P5H,gQ,3<@<7RC\C\HJ/LDLK]&CG@F+HNG8BAAOg4gPa((.<,UYL
8_6bNe)cC[:cR0aBLa7bR5?E5&FP^V>.f7f&8OaD3QYF[IUXf0YX9gcU3QEKFf3b
E]FKIJ0E3X]7,M2/fC+IVF]-:EgDX(-b<5GM.8_cF;7b4\GU:L>_;=V4LINNZ0O9
b/S_VcFMNJQg2H6DR4dZM,a\aaDB\\HY@b0d6Z;?9=a44&?6.,F.V,>2;fI_IY<^
cVe5#TZ(:e)T;6CX(04<KED9MgR6\J@dRGG>e:8MZ>C,9?6GWXGGVH#B_6@P#YbK
(SW[6+9#4KF)1a?8FZZbdCZ+\J;IB;fRFZW:KEDG9#QE[RQ[@<C.Z;-=K-;OAe[C
ZPVYKO><]V=U#W,#0PHPd/b&>da=0b3[/R=4SG2J]=:-aX;eWWUD-G5g(JcJKJY^
Q0OTDBWf,M+NeO;1=#a^(CCC/1T?:V5Ea:[2KT729KWUA[(+=B47f(5OQ+5PT-WX
-bHX?L:T3PFT<P>LA^H3\FGGGI:R6OU(]94cGbNQFI@Yf6KU8]Td6_:=?[5MLN);
gXa)N)H@PECfUG/KC=H@&+eNcEK<7ZF&KbJG.(2R3@/,O+ddATHY(X0FRPeM@<47
#RAXVM>6e:,VGC.XV=:6.V362d#6I_<A?<Ma/b]-#-eN#QHAO_Q41:.fN5KgB/Z5
Z6NK=B>c20][RX6C+^e6YT<(;TH5DDLJ7]XJ5/EbbfWR1_,]dG=Rg.@6?,aPNg>g
#HK_C2S^?\)cU@@4<BNM/D)cP_MU=&TJK3<@O8^M/UWRR)K.V]:VXOAJ>FfV32_T
A^9BGS__)ET,BO9c0X[ZU=OPFBXR+<1.?Hg>V6?XME<G/f@H(1bd@df_G-O1#848
0@f/1.;bG=.4HNNB/.3A>B8ZCV^A0YD>4D:=VB[:+EU9Y7:[OU7MS7\E5g/,<]F8
?d8-G]Pa?7H1FZBE30V>d,gJ=:)KTNL#>2(RI[N2^8=VD8gfVHTT2VA@(aXGJ_4I
9DO^]KU4g@K]-cG(CN]J-6IRLcK]>AZ?8];F+b&[cFDX1RKB&S^C/L7Q2LfG+:K#
WSJ@&Ib&:f/FPX[A3RRYXG??XR&/aQ0\XR-_7,-SMOVS@K:G;/^TYIL6/5D,_FHP
@.8;YIL;E.7-M2W\\><<+H^LK-S/[I(H2PWeM)CC:GHVE#1;?1\B#9cIV>R)(aH>
</14ARVb&M^O=\(WfU&91>;Y_R;[_9PYSd/b+A?[TTZcN#KE3Gb549[KLT-Q3+2K
4(RNFRZFDUJZ#cKS]@FeaH[UI:39bS6XGb0)XLVd@E963G5ZK<I]7OUd,6bR+:GG
-;K?J8?_+#-_A2NfI[4#P-FM>#[gCe;Y,GRKDN;R;4Y1&L08JVZ(^62g=H;eJ:UV
Q=?b]aQ-?cC5B4SPS3I_eVfM6GHL<B#YG)bc)[R^^e7F[UD4:d6]9fZ@4&N[DAgZ
_1aXaG64G(b5(\;_87MNS,+54WK\.#:bC#\2/7PKWW.I@LZB<1VFEHWSTF>=DH2\
])[WdP/c6)&g>S:GW1O>(IfbIdEgL-XO04e>N.S^H-PZ]gBO=FHR^&.6\CNCA93T
-ZfO.JX>:_[AF^I0Oc-b7)_SPE1,;D/DWbCafa&I2<&c19Na:K2QYW@Y>Df7&2O2
FA#N]P46Ta\ZUdCO+Sa8U,&\NLSNCM8(d57bPe?a0f[#9(cD2:f(4(H/bPa9E=(P
f#L&RS7,YTeP.;1VfOgFDT]f@/[^67Y0B5fbZ(09YcB90]O&]+/N=L\RGU8FK#2X
&Y6_SLfSL@Od792=N>^8G3c)@b>-&]SBFbX+_U9,fgU@feR53O>:?ZfY3Y4P]9VD
4Z#(@DaZ?[:2[89/:0Ndc(eET8@E()c@.^(gfbT(?gXgCFW]WK5XCYEVG[NJdMH+
-)Oe/K_@>&@4\(>]S@T>GSP(c;8N;0\F3X<DgeHK]g)CD_L+-J4H0_:E.EX,Vd:A
\6<,28A#648W7HXBbW;V-KLUV>Rb<O]C)E(PP[Vf&:8)^0EA=M3.LT+Z=@LdfP#9
g3+(Rf?+\FDKe9J4\_)=L.;426=BL94+FTNZZ^W6\4Ce2L(K(9W]bFeegYD=8+d9
Ib?&/RULXYCF2TC1\7d[E\f5ZVQcPA]7>&N/5S1;?:DF5#_MY[94E@XfM<V<&NbD
fZL[Y(8F9(.<AcB]POOAcOAg[\Yb>ERUJ+M45X@5WTSG,^YQIG21\GNR6HEHII/J
@>L86D&I[C]Ic^K+CML4QZR^85)8N0OGC.6DN\_XeQLMbR8XU#SU=D]5H8QdEa9,
EP44JgO1X-,2\)VKU&Y]K+^B/;FI:b&NSF8)@cTZ<:C0?BO^J?UU0[-?YKeEOF)+
b3\.-W2g5b93)5;F^0WS<=3fN@:K6[J-IVdA\XQJ&XH.K5\C/O&E;4.,D\YV;9K<
DBAS1VEL5bgbP^G>GZ\VKY9X5IF1E[NNX,O9BeI^V&,/C10;?KK=YG:/bIME;ARW
Q1=7L/_76Q_6U:6cS&;M9/UNd]Dd8b[aBJSS,+BJ8)>^bE]\36TVHcISQC:BKVG3
]7K1fZU62:^cH5#bF]JLeVe3)J:aU0)5L_]2.Q+ECA;1AKegIM_dJ3/ReC_0\5T2
EM]4STCb6BJ_(;_M1D//E9.R;+>4L(K4=9bD7<WRKKI#4MeEMNb9cV?E;PIS,UXD
0?#Hc#B+eI[_&Ac,G2.0,ZAa241P<O-c;gTSO4AT@5K8L8ZH_99Q+&I01\a8\](L
-2X9.PF<0YC)EaQ\3B[\0(:,M84@cUH@d2LRa.))BXb@I5S99R30S,FaK:A@[5D8
I-K,+)_gRYBIXZ0OTT#7WQ\8[8]KcU0@1]8@V9_X\;EQ\(.P-<6[H^W,^?1Q/?HT
I\]g@T_S0RUF(AP#7f^9^:KHK0TQRVGLNDP7)bFW;9_Q0??7MBB6b1]EgWK&c5&f
<f4Bc;cPS=M]BP;If,QVU&7d6PAIYD)FIN6g^THR\gP3DH,UM89HD;TZ.>=EEEGQ
U3@Y#C>7.W:bMZ?=#3[J:QGT7C\)eEY_@AU+2^IXYK(^T]I7AG0+>Z#;KaMLcY+B
a@Y=GDbV0=[b061XOOf1E,O&3(cE^@f]]2I/ZP,)<,SL1>/56VPKFZb#;3YH6/]^
/P4ee)c4Bg-[>JK=J_V:\gg=7:3Q0[7^?W4O>cC[QGU7\Jb@;JR(e)@PeR.1F4&0
QR>L[UAFePLE@>FL.]]98Q#1-8K(#^.bIL^?<&)LY93()6TIagO8?LY?_91]2#IH
g_fHKK&7]?]MVZ5bF0P;DJNAK<d\M3,?WWa\YE86VcCUP)WWN(5]?45?E]G?;K51
:YZ9>+CLD\TMfHV-8U]O>g/Zb.\/<(F8NQRUG8ML&EUb#J;C^<M.:7g9LL:D(YW&
UK_<BC7^T(c@)NG(a(\(2RY^0<@XN/9SA^6.Z\29X.91MM7UK]&<2SWV56G@QSA]
E-F]7c,OOA2BSU,E7Q_D7/P^dYEZe2K@+JD(#=(O@KD92+P\K0\L)[/\>2Q7E]TC
0+8(NZd+OI]/B-J^>BGP>N5XfEA.,4EPddTI6Dgd+CbTW1KWXJ6IQ@SX>H.IVU/I
5@U@3V1MGa+LL9@S8?/I7e+e-a]d_HBP\6N>9UF;N;g-cIDS=S;P6U(9N\_6Z6D^
aa^R>5,-4_bMRM.26TS@&D/c@K7\,Ra3>8QfS++2^:S1_H_NN,3++Ig1b<bD/[eZ
_V[caLKHLS5QZ9ec#.2[>97Y50[#S>+YPXG;WBQ1:c5CI(BS5c9@_-aDZQ^T85d6
U+)#J9>GT+5EM/W2:(JA&N^>,G0Y4ef[bI1:b4YW=@=J44.OZd48YcQ](>G?I_db
c^]gHE^IPfEL0L>5.<<4273=7)2OPQQDIg,7:f(bR(J^6Ga98=B6UAfIP,TIH<Y7
C;M]8:U7@:Y6Rb=;:XHYd[H<W5dMgCfEcP:[B5F&B_>L7YIa,L#S56ZE[44d\V>>
KF&_&#J2Ka^1Z?&\^1V.g12,Y/VF63.<R[IG9beEWFT?S8J3ag:N7e28_PVgf@Ne
Ndf./f9H4;DEL2?4V13@Q;;U7G(BN9=37;=GR-;?M748+@bEC=3c&XfH/d;2;=MF
TZR29U\4KMHN?f?1e(^4dgDMdE1)L@QV8_d,XOg2^,LR2]2WM_IZTB2&S=HO=4BU
>-5J;20>?DQcf)0F[B8cd/1#R_e=&_)0O5S\_ZK_Ab@9,S4I#ELM?SG)02/IL,?&
]PUXAeO.K^:PZHXYFC/M9N(3Aa[IAIN_#Q,2M:ICFIPa>V\V2eU8)JHTO,DCNYLL
.??=(/ETULIS^c_VTeLa&59C,M7g/D/+8U0Y0.KU4UD[SME6/>Z#PdaG[cY[5IF&
<:78Y&D5PTc/DG+7:,S0d/:7<?#4]>&Q]N_<TN6ZaADK6VAOb:GHH[R?CT-1=FB.
KN1B;(4>-5eXfR^+C[0SDO<EFHg;OE#_CX9+G8N^F59O,1ZO)=Id9X5XgZ1QcI+-
K;C33E#RS.=J;CJa@QA7G,]0K3\&N#>UWS)G>8HZ02ILI2AEY0L\d&8ARP9QEC[R
7JBZKK</Z@EZ?C]98EJc<=KK<DURJ.P5E9[0,PHB3d:FUE;)Q/0Q-aL\U\?T&aRS
66E56UgeA9=]A>3LXEZ=[\6Oa@+Vg-@@Q#-JDdg].??0C7WG=H()#982Ze1_9Lf1
.a9ODYU0MP^MK>E/GcD<e/IfJ)Qf0MEe4^2+c.:@.Z6DO2=I4+FZMN<UDHZ,&bUY
8KY8g3;X)1TX?I3]=?;0D1YeEW(S4b<)Z,OK8I,_:bR0\QeAQ7a\F@XK=V54WFTX
K^1X0Q[,PY@KQO=YYOf12GH?ZRS+U2D)AC^\GgKcASUJ3MdUZd^VdRcc8TcYJ16F
A&V=S0#Xaea-W[T,EH1Jg&5-8):_L^PVNLV?O2;80:eaPcB2VJ[P695GYXWORU2;
5CTM(A7FQ:ABMWX&a,Q<#gP42JU1#-AWgSLbJYaV.0S6E<5?3>_1]NK,S@E?Z2ab
FZX#G3:8<agS4;2GY.I^84:?[HOXA1G(.?D(>S7CGTC>5=A2:IE-S_Q.U-:?;C[P
?gC)54L/_D.VANR:8S2<UYLL-(6Ca#N;6#4K-aEaHZ.8/6M9_\55d<1;F.JaBXL(
Ff4+f3a(-8S#c7JA&\f6X.L<YAU+Se:L)H+IC+b4\?MQMM+ZU7^&4WC2GA.6gV-d
LS?LO<S45^\G.#d@f<gI/IR4gVcI,+^Q3DY=DET@3_+(MVMZg&8&.H5^gE>[>0+7
d<^CB93[L_,DH,d4]6=2OI2SD?<Ka)K9[JR3YKd/1^F-EE?YR]7EHe><]6.9E(cJ
#:f]Hd,P&6_DEfN<&e.-VdJHG2:SIGadLaF&79EFdNcU+g_AINde7-<#6T2[Z5>E
OZ_<Y&;>@BCG+[WbY+/76K\B5X2b4>:233XQ_>bIHGaA&a[BV/.06+NU2]/,^)\c
USIU2(R&gDaI3X&@FV].^E/>/&2/Ee;fTRKWcLXV-a]-HNZ(3C]?5g5KZ3:GWBHG
dT705+4fDQUgF9aPDHKHcfgGRE2Ia2S=6.dHf]CM;:)JWc8#M6-gF1HbMZW5K5])
Xe(DHL:3UReN<Ka#M2,7EdfcA6NdS7.b4c-(/T]ED7B(JgCB9V6a-D+I029;#fgQ
20g9\TcOG(-Q(4H9#OGZ_fN0gg-)(:.KP&Xa2(.)O1EL32[]9aB2FG[dK_:\-XJF
T#OVcYYCgP\)R>3e^>\OgC3.2@8=B&bG72?N2H2be2&dW>V,NE&8A^B,2cg)Q0Z+
\)Df.&Z:LfI3G)\?b=CS8[>7@&ag@;EFUFb8d[CI=YJFL39?YZa)H):H>FO)RTW6
-(2S)T(f;=]BPFL54;O1=<c/U9R5T74dVS#gCE@GMRM7fZ2#BG7NCGKV^(ag>3B]
<[<Pa-QPT]>PU-1Ld][,BKJHCGHS]M@#\X@8[D];a@-feT/1UE(X>+Lg)d\fN[6I
AL]RH>f//7#99b9Yb9Y2;=)e5.c-PTc8#d-fS)G<F+_Qc2R=Z5Y##=?I2L124]ES
;QNT&1B4_4AN8&a5VgBVO#:]V?5f=CT/9c0+MYA=L-IQWT.C/AX9Je96ZC4<10QZ
3K&OVSGGfWC0]\(b0g7PQ77(I6Y37LV=e8A],GW;Y&A>a:bOaFC<]d.B6:,\5MSA
YY10DcEdef9.64G)?&=I[?M<+GZ1@Z328\0b<HbWP1X_77]-IKUYVYX5K\]/Yb1S
D9-DL/E<1T[(P11+WN,3c6FEZ^IfIMVP)BF/bZe?YL/>_+.EG/&_</7H@GY+HabJ
;]dGCAX3U&XU9f6DWJeBdc+5f2SMVHQ=^)FaU=Z,_R-K,<,8PS0cePfeH),YKU-@
]9)1OfQ,>,ReaMR&UI[J9)c6NWg3A4,;H_6TZZ.XaZFR:f(Q/\[#CH079@+C8GKB
(U@UP0Z3\HRI<.Zd^CU8ZHW-@:Q5G4C(bEbW]@,R9b=#(O-)@eON7d31eYNMAg>_
0dR^SE7D9EQWN0Y;4FOa,fg3J,EC8\:44=-=/-ZdaP^e2Mb3Id>8;40RQD8\P]@E
e?[gH-^38Ic6KVc^AI:JI,bRZ<12gY4T=>V;X\>/@BUeKC9SST/6XDXWI<fPC9_H
O@@Gb<5=FE+2<eSJ(#J+EbeX+X=/bZRBVf>Kf5K8g2^QHa#5GW,-(JE4@/2.&M3N
d(GP<3D,_T49I4.,VZZJU:^M6&[H.13f41HU4G)eMNTHY#f1F_8YN>^Q:-L:;X#+
EC.d8)OHN[>.MIB,bH&7?<]a0e)Q#T&SQ],^;WI:#g(R&\F5)?3K-FJA16,M29]8
:09V8/:5dJ_XDIFP^P\bXO8&Q7f^B\_WR<?9ZZ#2<0]+1_fSTeQ9CXfJ-&fR57GE
H]\]4EeZe(G2:4N6ObNMfPW@gOLESFe4[&P_8+/_JVEFIgO3ab>N18?ANEB?0<>)
]S@Wcg-_+(/)__P;;&+KS0:>cSJcZLUZXb:?2B9ee4=cc8FNHe9W1S=?N]OJ_+J4
Oc<0-HDEU/+.>NQ9^QZTBJ42_:TWd(P^F7_fVP1L=3NPUg7B11cK60bI,YW0_g>J
M&#V0\C;YHU5^gMN@gfGd<_XC;BM<,cIKSYg3<Y6-<,.g.5+f;?17d/+T,F[aNYU
6aJLb)3Z-gFZcNb6eQRI=.+8CZ:0/f\[fS>U<G#X61W/IBQ--7X3S.KI<=FXO/+M
8740^20#eO_Y1]+ZHH&T-O=O@abGCRS]=<bZfH__XWHO&,[?bB]]^M&R.I052TS?
E-)(+\&H/7aP;aD27/QDe.#XZ64NUSL4Q0Q)305/9&QQ[MSL+:MSK^>-Yd,[6+V(
)Y3&5\DY9H#063-)F+?.8P8RN.bJ9LgSeQ-&8dZNM^Y4?)W>I.9+0S:,LVb-^5.b
M&C5&V@fBKVI@/Xg1ILS0\A-#a-(\5+E2U0R9H<eA7((>8ONOU?5^/9d#f;NW5:c
S(ge6U/W;,_1GA9Z]2c7Q;..OHU<JN2ZEOYD9L>;e5DP59?Ag\E:/b@^eQH:0Q<I
Q5&PX@A.30(1=&a#I/UNa7#Eb)7(f2#f8)dDC/^:HM>UMaV7bKOA<C0G,IL51Z8b
XJPT\CCWSNP/S+C#=gb2R-;?W/Zf.K(g[NeeQ([9<@-dX]cCG2(+:2:3Q/.e#6df
;_^KeJMMK&=^;C:Q,]LZ-Y<Od/0L1S57ZZQ_c)A&BJ0JcL7Te]6F(g9B8T)=XHJ/
I(&NeK\W:cc:WOIaU^5MC?c<-bWa_#g9^3,MC#eK0:#ZF(P321:<dG[?\K;7S)#]
R9N0K])Q._e:f4G5/a5N2IA^8T4+^_I@O(dL&Sf:\S]VcW^:SYN-GL-(dQ]1TZ,1
)7+a)?[1L#UUJ_NZ.R.=H=MG[TS.VGCODc-=/H4EVU,LJZb[YR7a3P(5B-]gEF:U
TYV?BZJdfO8cZ9CV-d6W0YBNfT2HMLF,8P.#VKOP9P<)Hg38^0;69#]]RFCbM^SJ
Y]99?IWY(UL1-P)a[g)\M\8X]Ub[6\1PUf>;;-4\c:,BbKVE(H@4NAZMXf#];AZe
dbJXIa09J1Z4L17G9?L-a]dF9:BE5TRH0f?GUVLKELV9@LUFIY9&6Ud4#,GFMd;5
5^@Z&U3I?NJ)dM79DffL3bUdT7Ad[KPY_&?CbM1#5N(TS@3X_bW>8HH^9IJ=7GL-
Fb@I3821YVZ918/17g85fb2F5Y5CNOc;KVU4^P-cgD#.K<R1-e:2UUIPUN>S1K#=
YJ91(fAa#MbN+#4@0#^@1HbLFa(cY0NV(T?Y(Ld@86C96BE6V3fHV:.#G<\DbIE6
#^FD^J_HIf<NH38B2-<W<R2D41IA^Kc.=^eQ=G83=KC]aHQ;Ug/SVEPP&X1e4&H3
W0aCZ7C-9^;BHTc5ER56<f\H=3=L,PNZ4X;Z?c-^<QG+S^WQWEO(ZXD3F3\G(D^]
-\I&4@@7&-)([Z<(XfF=B(G?#D2WV_I1-0,->5ZNF_C&V20O6#-3cB(\86<5I:;_
b&ec/9<?EJMD9[(a1/.\N0#IbK&ccRbVPGG:Y6B>N4JbLU/c5XU?HOID#b1bSEcL
SLg-HP-Y-:6=,7BIME@g;1KLX\GFG7H9@/)WLGQBe)0[DX>LA\_J&2S+&4&R6.7g
R-5c=/&7CK^6C@2-_3PO#@M>g(]6NYT>R:N(JMETY>L.(@@/;]Z\YA.6XI?L4)OY
/7Q]af]R5F^,3A5fW0#?4gV)+#f\MPYX\bcg:H>Ze+WH=-22O/bOPd[OW(>dG4TQ
\EPQ)M:+>LG>R8<HO_@BTL@]b^[f)8K?JE:SR1HSN_ffJe)WJ](@E+[S2=+@6HdK
H9RWK;O1cCV6;M=ETQOQZ;N)IM/6[JAT_IANIZ_eDe<XKTb0WTeC0AWfH#^V,^\D
H[IMd&B;e59&A98:)W]W7VV5D3:VId3O^T@,DdD4JEE:X83MK9_(S\90g9IG5Y\Z
0F8g3YD\c\Z@SRXJ8db^3bODRGI_G3G7Wb=>Bb66B/94T&AD6<U)ZeCNfZ:15bV>
VFO<,S&]MP2d3D=KgU^#(D([L88H;G74QZJ1EBAB17Lgf,JKFK(2_FWeFZZG>-)[
WI6LBU7TWCT#Y>]VFJ3=bXD.-0G7?54bb=\ONZb=ANGG?#?<(XLOZJ_SbGFVC+3=
(K6GQ:ZR:,7S6Lg0CR^\SCT)cEf,28_4J0Pf\CfW_;DO/_gC\b[MQ^ed+LU8BMJ@
8E/FcOg^O<CKU.:^B_c_N&<ZSGB8aKbA=HA0A)d3bS72Z0=9Z_29Q.(bK7c23UZ8
eXZ^[/7C6PG/LeXILI6SYK]Y=,g+7Q(<\a>Jb@=4H9F7.-#I-MX+C/<e[X@JgbSW
(b&gHG?NFd=KNKD4:g69b>bS,W[2^b/8G,e9R=6dTBgA[-C\7Oa2b6QK2EDL1X@3
VW8c\,KK42NSE1.Ka45#8N2cCB<YK.+[[e(B5<IZNRaTcFH<Y4g9&L97d1,KDLX/
HFS^](X=89b,P\CPS8Xb;DF]F/;52?)50LDFJUcI-</c/AC-[E\)KW&F^\d>K0ZK
?cJV=aCTM=XD=c<:&<:)@^:CfEaP3Zb\T+.D#0EBS7ZK0=C6eMKa@0](.;3J[Ug+
EEU#XNP&KC>??:Sd]dQ3CTNVD,43P)O=W-=.d-&IaJg>8R3[>:.VCQgBLI:.#U53
?.T/aU.P,d_VOTf17M\TB9)]gKM\/,V<(K]Z833e_<g/GI:62>KZO\][K(&&R.G8
(4M]-YZ?d1dXCGDI,<bVbP=EYB5W5_(^Q:dED<5C+0N[]5Y;^+=<C-_NdTP2R)<<
[+\72Y5IYb96=_.3M+_U047J=(08L_O],9R8S/X5&\YgI8g;95Ld17Sc5V7YE+T@
Vb=LTZB@RI&g[-RR;c2?4Oe38D,4>2OE6SPWcUfH\AJ+>=a?JE?:RI+MD@d+3H;-
IP#W+]VZ7KbPJONW3_/PYM?^J7cdaBPH?+4\+]4=A=[cAd3VT#2d,A27AJ^ORWDH
8-PBY/B\;&/Y]7ePI(Gg^VI<._\K8>0aGNfPf<7b<X-9E<L?^dd85-35K;.R#>14
Z,=eDHW9-H]6S3>F0Tg\>g<Aa_/_f\W9E\9L=KA.:6GX]W4^4]-BQ=;RPg4)W4>D
ZaXa(^d:U^d-C(>b;D&4Q;Ba>5EYfJTZ,1E</U<=L.-YEQ:&^U+OT6R2GD0JGF]/
D38<GYf)FV>U^9O(Y/\4C[^X^(MU@,+&^E#F2D4XRdU)gHcJ^]:VAJM)^;)G1c@D
D9E_:^Y].E@d++EIEa2(&[b0,8[Xf@,D:PeGJ\Z0^QY7NJ@bbA^dM]\B?C=40CEP
8/74)8C..G\AQeS9NPD@YI/;gCEZfR<bRN;^6;BNA;[UZ=5;:_:T?@16BaN&S-K5
\9E:S&,gJI6Pf>RANI.#W2(L66\7>[8B87acdb.K>@9^(Z.H7=@SUa]NWcDe^?V;
5KLTUU3B\aXB=]T0X?0W9gUSgLb)gc5@?@0JX3cOJ2T[D-e3]g?.=WbPF,-AT&[<
H]TDOP,/],4>T>3eT7]H^10W2\KcgO=^)^[1WG\&8gA/aUN#W,U-]DEO3d?CNS0c
X1g/,0KbG9:SJT(/f1O4HKY@K&L+YR1)5J)b73?+Ge>XPCf#V];36d=#112[FdcI
1<?]1Ba:3fU1/T1#88gD^CQ].2@CN:EMW)KL+7T6f3(HTM4_7W7aA#@S97:);]BX
b343HLI=a[D)(I>PcKJULMEDTa/[HRQ[Y0Q?-=dW+f]#N.AV:N?PddID9RMPY&Z<
AUeCdR8IP0HUBL5g>R@0ECIQ2FFQcdW;-L-V^=?fI^J-=fDC\L1@.L\99eOe/W43
2XT0f^LFV+]40-7]CGfPgATA@[-]=3bJHZ\0C1F??>gX5b>VNa[))fR3ZM?(H1+0
/01P138UfS,>9-[fMPQJeXf1+K0?0B4PEFD.QWW_3VLb.ZPJfZ_G4R):g5KVeD#C
NNEb8]_<.N@[G2&VW[<@PS,=<-D2Pa[RVfRA)NSe0+(T320V,IZBC88>-538[<XP
0Ia/dVW)&+W=FU0M#6KYBCHYa4_Q&EUgcP6I[6XK6T<P&:4I+11DLFP/D1PUb5^O
DQL6WN=LdQMJL/>-HWNcSCd?,Y=X2]^Q_GAON-K9XbQ\BKMKd)K,dN0dEc-P.NH[
,;\eH9@P+>]MOKHO4A#@>N..DW=&_A-d()U2?JQ1NQKdC)8dg.9XOJ\O]bUX#GXI
28ND->@5D3CO)LP>:J_,E@.J72-37Y^M.OUVE4XY35@P.3;;?Kc,_]N.>RX0?4e\
638-J3/IdTH<g]L_JaCO_C_Y+K_INTI55;V8YRb36OE.cfeLM-14_AQBQDLAeGed
7CEH;^b^DK&X38/[007/>,N:PFNa:[/++/>-08#/NEc,2B3dHIK0Q>FQ0d^OBX7U
@JF(U9c<_@,Mc&,D4@5Y0[GF9:1O9<+0;.>.NR0S-F]b,@WB.?&&ON+&J+f^B#[P
[=UOV&^I+,5g0&5b[Y3>cAD7AD<GVTY?O4CBbc8dG&B)<fSbcVc5E?(;>G7)T[>:
(WOA(DVeW_8[(5O;L@&e?(+?NC>eK5f--W^HJ21Q?1R/AP3g#)._(a03JP@>fCT2
Y_1IBbGT=aUNd4(OeQa1IL&/A5b.[>U#b-O;/X\ad(&/)0cf^[>9AW1-AaQ/IJ6J
U7X__b)\8ZB[5OJF0bOMN[f,a?#A:^W@6DHBG@),MLJV<E76aP;g+_9TV3JG]8G4
Rb<#EMd15NA5S,g/eJH8Q/WL&fUT-dVQZ1b80F83RSWL/[+a_E:<<UVM&T);aK(P
=9S>A5-HG3RJ;O^;fcCUBf.a=MYN-HIIM(@63D]&WG6;&EIMJKV<Ng5YGH_7eAZM
A\4.X8SN?(2HU8e0Pf@@476J5[1E_2g/UGMLK;//>FRaG+0#M/CXP6#4WbN_I_=a
eKB6/g[>[f01/OMG5<OAC99[N3++W&785+77C_C9<NH4P46S4;>NG2_DgD?&Pg].
bWKP=L,TZLdR>FKO0=fdEZ(1M@I713=9<fd=7PNd\5:&4BAAI2#aDf25/Oae[3/0
+(AAae0?Z5a0].=IJ7RH+&83/T,N[M:H2a\M<=/F^ZEc#[Fd8B_5/g@&#F\_#A#V
Rd9/K.[A0D8C0YRS5FP4N[G.ZLEF]5=4,M3ZUXG1?gM.\KF+D<PPH6.1ZD,NQ,W8
S@0\E+I7P6K:ROe-\7gM8DX3fJ(,5d.:Vd3E43HWB?H6^Ub-/?ORcgLQOL>.+S..
K5Me842@9)/T0-dR812G_XfP7@5KUZPD2Q=8A(PPO]W5UW@:RU>:.dLWVL8\gJRJ
NL7[^7J_6<a=PEPG@1S@DaZ#)36:4+67\OQG+;5Ed?e-#5/3@-L)B0[ZMO:G^\0<
c^gfOY<YEWVS1BU\1c_GWM2Eb0:2BI2R])Ze@=KK\:MLC.?M^Hf??NZK<IQ+0M+V
/<4JMO,D>IORa(#gOKGe:8ed#Y+bLYVI<9(&7,&P2:>-d3P#\@KFFWJ&/]dc>-a8
T&[2;X5-?_cI@G\>+ZUE>/NKOe?UIZ8TCZF<N.?#a?6Y_4T.P>4QU;Rf;Y(<EK=S
e[33(fALKfP2V/\K])F/4MO7IE,W7Y4A&8D9;W@YVFY,dc1:gCQRLH-LW-:5\;3R
>:.NYU6X\T3?&2D(MVH2R8P;bA24K&\QOW3Q+HfG/d?FeSTKW8?,0<1e#NVX2aaJ
]?4CZX8D6PP4KX/=)-dDEX^13].QOQ:P(aR&P>NP7e&4D]^).FbUBa>A-<,UcUA@
LcDM91QK[2bFR[bML+Hb@G;R2YDHYTZb3LM^:gLQ:J[-@@-(bYTE_<D][7a6O&AU
?=:D0R>JM9c12ZR?:F5NBX117V+VG?,>?_H\4;A5OISYFE>SeBSL9,eJ2PJBR5[[
5B)LAMIYTY@GOX)GN5(f^DI1ZEQSH4H?aKFWcW0(R_G&52:&(U^]b@P)Vga02L5H
:G,I&(c@@/O.K#OfPND>S_f;GH3?AD7G[TDM_7V8=28OQ7-)FXD_B@X+[dd]UU^M
0N3Da7\]8F\fRAe3QfW9XaS@A2)E;0gJZO<-60gHGSX17CE8Te9KAV6c]ZBA^NM?
[E6Lb]K_;)FaNQGW4M(BMN2V[QQfeK]#<PaU8K_AOPDeXfIX+a_2W13fNT/1ePUE
O9c=Af>9:S=MBa>c@A[T^BDI(J27E+<KR,8SQCPJYVNKMeSN.O)&?N@)3eVGI.&e
W^_4Z>CJ=O?^,NC4fBK(0R^&IGHAXP5K0fE^DE29d:C@7Y#b;4P;V<GB)[ad<f8;
-HK650B)1=M;#]c@6d4FaWOd<e7W#P-R[25X9e&QcTb>Bf]X;>0G-W=SYd=gcQ:9
]/8\1&1V(>MO]G@e1D:DOEVd67/4-3EVY,\+7K@P+^B1):ZLZRa@/E;_J6^\@&)H
W>9XNdW4:,:@HfF>C+B1AW4^B^V?Z@g(C;f5c/-A,)4ZYSPbO(FO@WS;U>QO94Y&
H/[UD02.ONS\+]b6<Y=#e;g>G+I,&d#VT3K;5OC;+D6]7>U8>OZ.79H84Xg//JXS
K6#J@OT903ED?FOCF^,I)27OcDg9)J\/YO7A0Z-T;7DP(DfbVQb0\Zf5B2Z#2-F-
ePP::5,?KJ2QL:O?Qe64WH.dbX?T&@PX60FLI@fdX\.4QXP?(Z]^FdaE)dQPBJLF
KU^7[N(1G.YC8LQ[,cYb3B\F=7#:HGBS5VDS9U2[E#<1()URG)G>3OW;Pd+?;][C
b\2GLbd@-,5V7S4090XX=USBO@Z&ZcZaY(f?;WYa0MG;/LNa57;H4B)O[&_eR_)6
+F4PKW_5PbggYWN479fW/\,1/-5D<4B25PYD=C()..5+Ke+-aaK3(&LD#P4e4fH+
1.0419e]C^1[H9^=5]aKK0/S0[Z)VJR^P9A,b6(Jc#=+SU[LQ;aQ3KQS95a#U0)g
>VdL;F&HcD3=MRL9WNEQ[4&LNGUc=Nad>N3HO5GE51-c8[:c3fM_M+92_2OgR^Za
;RPMW0X.3gTeefa5\D=dffY--:dgQ?>&^QWLX7;>/AR@\ZVUCc2<&@YFgKHWMRWB
4E^:dS\H:a]4.5)MY(3I1H\&;KZG1_K?.,fe]OL9KIK?;7/6Q>(NET5ECgOXL1B[
:gdbOO/^cb.d\>DOPXOOW]UK>IH)Z,K50B&NH@O?27YBUB)D8E>^#V+T8UY,,Bgb
Gb/BQ@FETETEVI<.\0<dO:cYR^Ra8REK6#7Z(fLA,<:ECK+fG[](<@A.PE.c/\H#
d87_8O-R16=[_TB=>f\YTC-E]2_/WEdNV,7&:aSABSWA^-Q=-fLb]IOHVI3E9OBM
=L9PO4c2R8<R3P/F5T:6DeCC_&:1:B=W_9:8-S8.OF-eB5KJ6A:ZY^]HP4JFHF\^
cETKMRK?[UQTY.?7HM=X&JX?V?UPFRN]@Ue#SQ9TZGEAL6_JR5Z(?cFX#UTE/O6)
:#T&4dN0JH9(]C)6FBYN0?dJU^#>C<OCc_+Z\0HG^66cf]I9AKI4(VaZTP-b0<ME
@GNH]:KOd@DMA]I]#Na.(P^bCe<GDH4E9:2b6g[JHY1)-HA=72VaWdQ0GD.(b2?C
S2N9/Df;X^YMO/#Z(49W^7(QNB/N:L=-d&Feg>2ZJF^35)T0<-/L28]AR#WeYJ@C
A,7A_+BR.CT5XGKOJKeI9>:2]G_e9c9E+\I?9b5Tfg(4Rd1/80\7]eJ2G47K)a7g
Gc,B3d/6HO.R<2\(,JG<2JD8WM6&(>--IQ^D9KP-1;5K.bGR54)>T&;.S49:g-V;
M/KRAD=.>-.1V#>Q:HKd@)3e6B_IW,fb;2?=dNUW@4R[TIGK7NMMP)#--^4JI>DC
=CDae,K7E?NDcZgN:6&CfU<A3H#TDDS=0>Y9)6T=;]OKJfGgS8AO/_WK>#PGI9]Z
3eOQ)_7O.80-RO;,Ja;2DGM+0F]+1c_3LX\?1fPPW2+#_J8DJLa9R?H-TJBgJC&7
6MUF>CR6^)FS,AMY#V[33J6A290E5116W<\_RTVAQL;Y,+?AR-e8gG(g1e5<b_cH
<[[Ic(RQ>PdTaQ0W.KNG9g(/_8LAd5I?B7B<14-_J54U;E([V4>DY^\fFX?M,9P\
&AR^__\CHEYYOVBY=;^MLPZ5]cZd91HW>Q]>2MT/[A2BIM^P_+&K.U4MQYG6E;5?
>9N#H&FR>F:cSD(97RP20#^@3_>Q4K(ZHZ7(8P6>8MG.&V[[+JEe[Aac<[#03WL2
Y[g7WJAgc(FS=9a75Vg8@&^)6YeKPKL#[/.K-VaC&PYgV9/,S[#CG.=)&98N6D0/
K5?9OOYJCU]J[&FEMgXA6Z^7I)dM[8A3X9Sc9aL=K,;6Qd>g8Jg&]J6SXbEYVEa=
fM3[62SZ+PJA\W[R3@Y-dX=_EBF\&Ka[W^QY7Fc/]X4IVNb_C\;d1JD@7?\=3)84
QX0eW7#U7.<eF2L^@<C1+b=G;)eQ9B9Q7#4(?ENZ^K;T-Tg&gSd+:<3gYFH>KO@S
4._<OLC3W-X(.6)E?U,9a\J;#f8_dHZ8c0f^F8GdPXNV(W[@0HVBL5\BU\0\G/e@
7TB)\>[)5Z@E1O/OC;;S[7]2R0WF\caaI\?LH,J2?[+SG)5>YHOXEZRX>YL>EH,9
I(31LS_GU&D80..K&H:cG^;FFQ-GU[6Q@I-61PV38ZDMOIF/f8-\#eC.#_R@I:#?
#YF8aN)N8-6b=C;&7aGCO5B[_^fHcNKb45N>[PSPQ/f/C0A9H[1#9=IEEXXQ7[;=
@IWG2-NCLT\Pa3ca8J.^fFPg21W-D/:V2DOJ4IgM1IE<]=72PAUUb:5f\+]G[C:4
>RP+BWO;VgW=\LLHBN/N]3?ZD-SdZ5&_<I,Q1O2I^R/KgLD<BN\UYeNDDC?@R;X(
@(,YcR&131Y673-dgH#,P_B3:D6;<]5^J^T0gT83DLRU+cPMBaO267:2G[MO3#:D
VZS5PEYANH:M:eE,@1#SYK??G8:J4+Q-FS9@)N2K;bOPU-S;JP;?M-99BP\c/EPC
f;G6fYDZX5V#H3C#GD-KY_4\CMH>fPM.5X2R#>X#N0LV=8Y;;SP_H#X(5F_/b>)2
.AE)d)Y+(T&_^5e=1^eHWbOR-N[(^=2bC[dXL+a9--U<O\ADE9WI@A:2(Sa3ZH4F
]]1[1d)S-Q6E1d>68N;8&S_[,>],LLCd(RK]];6LdT+O6<D/FVSG?-T01O:)_;4\
:F2B&]K9fQDeJD0D<FHT:3[8[Ug:D_V&IGU^GA][E;NB5Gf-]c]A2^UO+JZ(aEPJ
CS))\32PU]6W_;ABX94R5KFWMeCRXa/2f@)\HTKY4P0P5X>>W(VcB\,T/HPW1\T6
bRe--EJ9cAa+/O[O^_0.0>3OPaTcg=F&4AQHI/0J_WQL&Y&U.FVC6U<31W>WZ,WE
2X6TBaVC(QN3&TDBR(a]PNNbTE1,FB9++A=O>I.&gJ=:3c1NaC7db0\P3<@eB[ed
bU-RBe<>eeb=Y]bafT#MS>-GK>YO4,ZBD7Gb98^^JFDOWe>@E._\c91_d:J6/O(4
OQaRBM=:4RK#6X=?;\\5a5A+=T?/&>NGG((ERUb.DdJbW.KgW)TB6+.4PB68MdR)
E[ZZF,N0:GE0&]2[#BFZKB<g;3M<c3Y6T^R+bOFRK5N03QPHF5c;&C5LJ9f(28U1
H6d<[A[=gBC,MF-TIXLWT]BdZ9_XY+09)DD)B-69aZ-#9@67(;22/S>Gcb<^8,4F
2:>/2M>[C?GPDY([>;9J2W\EM96G0g9g;+2X,J.G8@VP:C6IYC3+,-?)BeQ6:88g
R9e@0J3#]G(;8_.8Y77LOFB3>g7:&T#>GW.dTQ.E]HCEba0[R-(OF[EgN,JHcZdP
>Hfe7/[(R[UK;3M2DH9B?7gH]P4Rg^][0\5IL9bSg/2J.O3G^VDT8Kd(N;_US?.f
1(:aW_O2_8c+Q2RC42D1@PH&<Z^V&Y/HLdeY&)GM:/CPAS=KAcW-76Z.XFD)@#+(
C=TQ83AH510g^PF]@,C8Da#]HEDSQ0IfK(ND)AFIgSWd^D<[W+&-VATE9Ue2TZ)b
Jf-6GN9:.#4Ub_\,XVfU1NQHYafXU,YM-5^NZH_c1-/dD<_f6#;4D4C^^^X>-<^A
c>C=@&XU9#Z1W29?CI1FEQ<AU>=I3DEbCI<V.RL<c5-JMbTZCR+S]54D5B@X.>1Y
=5_e2^LRJGD?3A-a(PGN451=4b=B.=:,3U@C[N]Q]_6FGUgU6]5^18X&Yf2HGL_(
:_d/]XY,_1dKY)JZ#f)VNSQH[F6B6dX.\P\0=@g#>@BN4S/Y/4RO:^26bR17HV3P
T<BHU;J7ZA-.GfJa>c=OGGN3M]=_g;I<HDV+>VFY2A9&K\B8APDL-Jg8+=79ADS5
CYW79,0d.W-WW-V0:7d4<PXf>KAWW5#)OWNKgB6aB#GY@C/(M;;8ZH=Z7c[FYW?d
3NVNd>[GCKEK]Ne4IBS@(#Mb5b]08;S1XWWbR,b&-573_V8]E8dXEGXf[gg3&1c^
594Q+7WJS==13&&FV.+JL)#YAK&8#EG1b.febeJ=Q)A_GVP(312fV=MG]b2N,P]g
LfAQ2#FI74+//7MSR8G01EWVZ107(KA+21GR0+[C>N50OgUQ>G(WCbP89&6#X[AO
;6)3/150fa8b]_]IQ89/QTc]gS4c,#AUfF+bZQ2UOU8bPVZIQVbT?/Y/JX(AMXA+
MF/A]?IX8fLZX&4#[eUK3^g>S3b(QVMH\\d]e+E:Cb(:e04XOWWQ@TfENbI[/^EB
(0V3+4d8@39dFZ>.c^>JW2>K,AW,GAf;^CY,f\##eYI;d9D.M<^_8N8ge]C#-]YX
OX26(#OcBG@Sa#:2WR7ZOaX:a_N9e@GI:.9\WS+5^>3NZ@Q;g8)AO(Z2WKb#8Q/8
+K<7KBDPfEbG3W]VdD^/C=,g+Q4d/d\(=Z40F5K]@=(FEaCa2=/X1UL9FE=<Q(?L
83YU)=T]F8[W_e[fCS^+&Y.X[Uf/MPZ_LSI5QZH&b-b_&eQFJ6e-I>\?T,<N2CD>
<PO9b/N=6#Q/PMJ1OW(bS7cfgX2NG5G]=(S./0L:,3+M]/#I>6eM-+>7G:6WB2?[
HAgbgIbB>[gdY\F+9Z(3;9K\:8IeU>DS>E53?=]T;G&]PF;0;5C#,@A2MZ4LMG#[
3g;))KFaXD:;#C]6e[GPEUR+O/Y&+)Z>.WF,,WV(EKDEDBL.\)M_8SR]J_SfgV85
^)IT^2ANG&E:Rg+OC#UD^K@?L,J=Y&V4L7+cOBX&dIGBNcR,.C1,RPc#,VHVE>7.
R#LCC-.gOI9B\(3XIKW+b+2HZ1e^0._d<LTf3\V4POM\@AA8QdDVR#N2_?<4NeHN
_U)SffWJNJT,=IfDJ\.N,R[=B<PGWJP@Hb//KD0<eJ^1<bCH[:HY=E03EG8SWae9
;0,\HP5\fC&0]-VCMS[[=-<@[b<?8@:/C@M)D;-.?B_U][DR(H,/@cNYZF?;8F2b
WaY:ONK3UU.7Z3XNfIU\3c+R\G5g^)9[SGdMGKf:\WYBT[#>5^@97bdH.J0K#>T#
^PXPXO=K(K(U(Jc^d6I;+C3>f5=UbgKMT8Afc8VDEDX99N21C&&<a4R;9E>f;\W6
C3UT<36S[?=1b6EB)G5,^@\YgB6b0/9)-970b(XOH,Z_3<#+\+b8=?:/5U=79L<a
fJ,5<:6bRcXS04FI=5I/#9OH0U>dA_O6;L<Ob+XAJ0+IUEeS1/V=+^]#U@UIXWE>
9ND@);KPcR;ZgfdZRNL#f/_cVYK#L6de?Ue#,>(8&F:?NGK;Mb-OQ]D1aFe2]#]+
](\V2K1e+P45(Le=V_/b4,C+;8D+QV;9C</.P]d>2MYLR:ZZYacIT\Jc#C[&1aSX
RP81D7FDC^McJ^0PS\<0S\\+@=A?[37O,+TDJFF?GY6VJ[F0>b.0@P]L(V.0:@<.
>,AcC@;[B@@Df;98\PU0ZcaQHGU8)0):5I;#LB5=7?F\;]MCWPU:VT5[BM)QS?91
QNWaM13O7>J[,O/LcR3@)_8I+caRC=K,:[-MI.\]I_cSS&=55]P6KTJ9g8SEV?OF
:)Z[9Y+CfZ-+9D[KZ7UR&?UL2FAK+&1]<5=IKKa&/+I[#d53_F+VPF,JO_@MO+H\
J,_9U=XdD,7JLNF[dWTDJV=-O>EeI5(cLAa<[#_aDCDaCTE-)RcA^gC(RE5M^>B;
FK/3MeIGHeNe9SNU33?c3-ZAKG#_NJ535BR<cJF=e/-MUQ2L7LT(8a5:g+SB<P0<
:&V25/+fDD+aAe9/[NdNJR&7EL7GD^OFD\4C+dX5(#\gPZU5<^4S[O#E9f4CKLQL
C;1;F&PEU-D?OeX6N79XFM-J(4T(DBdNF;fN[3-;3&@/ZaG[3FIXT2]X6bPD.OS9
Xc#F8#;H3Z^D+^X2gLUNb,Xb/?d(\B+9Q(&/J_OI/#a6LNZ6Ue-,EERBK0&f;0:P
LBUK+H33:RY<X;^,7O;bU->a;XNC[8=L+3R\_]IY/;^)I&I.YF_/A_A>FKP(?^,2
&41fE1T6\[U8I1N0OX?c\=</>+X1X^WX6T.H:a9g9L?#(2K]-^#9P0=4eZL\S(+5
b>aLWb200BEe?d5AcW)O]J6Z\Jc/CfN<.X@)dVYEGcDW\U/NE7JX]R05c?9eT=[G
EKff(&LG:;d7[@f&^Gd1eKaG]UI9KJf._6dN+&;AX^Q)^2f>dP;C/7684e,e5+XN
aTN\Z<;Da7PAR]Y]dJBJUgGW+JL2XVeN^(>+94aLZ8#^Cd#C1:.IE@N#NOT-=Cg4
8(g@B7(TR;2W<#;K,A]::/,=S<B:D1.=Ud3D9:3)K^>.[[B.S3Q4IP@5;.A+a/4e
5LI0G5MeM2<7M@Le8Q4X;G07+gX?ZMI/eecJ0_;IFf^2aN2HRPRTDUc#XOM6ZP:S
/#8@?@b^C0&AD;d^\@/3;<18N]1cDXJ]V\_,10gT=#BDZCX?G@Q([:MCBSHW#f0[
g3Ue8TDSb6<b(J.eaD47>9+)++VcK8\SG81/3H4^VBDN:JF[7GX?@-@8fB^cYX]P
ZNCeS+NYK/N\1;_#EL-#8>A+@M]T9e_(T,-_=]Xb<27:)JRc+B,_1G^UY@S>;/f@
dOL@>9C,=d:-4I/BVIF\@aegeC83B:9S>acYJP775a);C6Z)C1QLcgaT\=LAJ(#J
NXV=;@GPE_c#=BF>d7HLg@_@-e<U;:;Oc,PU<G^G1adJDf^9d+ILI;5\/OWX?UC=
(,.&0(O/R0:Q4CfS;^(FZ/0;PSCU]f@1Q8[Q,YfEc&Q9>QeWCRa4[/4W1<OKg;W,
3e_HS,-7D#YD=8,JMCQEKUF.8^:@RP2#-Ja4FZS-g[@CGab6\5\((C<^RUSa^0+[
C8<AI27LA9Ff]SOM(=.Q2A1,Y\.A@/QQC@AES9b9QCWPb(0d6fQD.50+/c3L6@#g
gIeO)A,?]eR\b0I4Z/)/^_BT0(2?;@3@^ff\].,GN,-,bD]E;La;F^/^d^D+bX>>
]TG0^d^ABeIZFE<+dR#,Gd@NRVO(DW@M4/EH,872dfWIF(:Y98f@+G:X0NB#+4Z]
2(S+\Rbf0^\/JC4A.US,[N][(S?\KMFHI4E3ZKXE[5QS_B-L0HQ0Yc0YT+B^Te_&
<NN4a(:<M^beb6XB>+cTc0A,D=4^A1e943/#P7+2.+\gW3gGIZ9>VR-N-1Wdg,OZ
[7WDJ::USZW,J@[MA(,9A:AF<&^Lb7X;HU.LXUOE[VZ.J#5J5efKdQa<.R5UaM;U
_9c.@HE,LM9BDF>>Z++(P962a]a@K&4)O]YVG2M&ZN7gVUWg\P.PNG.4)gH?<#UG
b;F&ZXA23b0QB.3B:1++K@FBW2?<&3P??Y(A:3d-+?XFfRT61SJF]6)PL0KeJ.99
<U+^5@.]9,0C6,4F#CPCL0b8JM&Q:7H^Ha4AHRb]O+dF5bO15)?(>4)?eIa2MQES
,(0fdb7<Mf6dV_5ACVU^Lc@>MN]N5PH)E]?UMQ_2AJ]=)(ET68UO-3HfZV&DKY:=
F8-OURb#CPFHV]MT:[^gD<[/,HPcKa@gT8B\4H^NX5aIT4-V.gE(3/HBaHKgggSC
3?45<X-<9Jg+Fd150Y[Oa;@S+B^=93V?dH(A,g?;9?&K,D-9II3VeM#9#:POQRT.
Rf,FYe<0,22bOVS.?[.>g]1<&]A,7AYI7a7@d0.#F@+I+\61-QSCX?(F_:7:@JgR
-@HgWD>I@)&Q#5MA&0<O6D.@b+Zb:5d:.-45cF<@JU5Q7(\6-8[E2=3[Md,dU]]L
Pe0X0.QPLH1;=F9CafU:\OP=cYWM5O\AU1K3FEE22JW0PY9S[7>=[PdX,XHQ_HMQ
[9=N3Tb\EF,bRD;ddefSY@/AD]J[&Bd#KD+GTJ?D>b]=_O;V=Da:K_3O+:5+-Y,.
JQ0584<G&c#Q=M07>4fOSXJQbR&-_1O5W84.X/VH(U:)e.=dK[G1@&d=D^<4NF2K
6JW0E5MYB0S;I26/AO;3.<g+;LSD@6+Q3R=a7</RW+;9L:aO5_,GY]7BBZ]X;)I_
aPU-2O+DUT#PM?/UX@N&]@1I:39d<7]a;#T8^dII5CP&-5C26IHE.ONJ78&G8=Ma
5SEfFSdYE5TJ&NF28U=IVK4=AWL^\7]YVWe9)#;?YWE-)Sc.\f8JEGRbL]YEL#Ce
UGT0783DSgEIa[5T\gb[cV>:L-(P#<XdX_XX^6=1BX\ZU^g9fYDHbAJ:Df;0b1NU
[V[NW>4.NU7DUff#0Fb\H50aL/)EC3NI_:?9AEHb6\-KSGb8S>68#e(OK&Y>\D1U
1.e0CbPQcb?9XV?U69V+P+Q]KESF^9QD-T9<BYI_;N9QH@_d]+.9f;;9S6O\[9IS
@&:9eZJ6+fXRA<K2-e=Gd#?-^b.G+0QUXA?gT5K#70A-Rc[-aZ-J7,DU-,#XO]7c
GPU37A&cdA4=3HdCH=OM5cB?RPdDV48=P:&RDWe5CF(^2^-6ZO-:__E-=[5b.YK9
_75.>?KQ7g6=R.?:gSR?^@R_B9e:TH6D32^b@LG@BWRg-d]^1]57-_V62[V(/?E1
9-NX4^5LR.<S=ET5Q[]A:J@+2Sb<9faM=BDbK\6)<@\dP(G.&.EY&[R.cH:?a+]R
G]:<1A+G@+FR/CJR>6b5#+Ne]e&L6]8ZYU,/H8P4BN;=\&<g\3]2>)d/<Fa#>fQB
@;U[e7CJG73)/@JR]=MP1Zb/SC>1H;Mc/0HH-KINgA42KZ?<QYc:g\7<BPYB>==Q
G:7ZbUTeEK(NAQEOS/W#[^A(7(7-OYd>:W73dWMSJ4^=@ZZB9FNJJ=30I^GT;=TL
54QL_N(eL@U65-4DG@D;2J1aT;4/S[DL)DeT&M/:DeN;e7CHOXdfc+e^6-c5L^g?
0d08J>3@XZVUA_&HT5X4BId#NDB.5.<-[9c3)KE,Ag#KA+ZF>Je12_3+P[X.DT(U
/9?>ISD:AU>>-],HKU-MRZd#1$
`endprotected


`endif // GUARD_SVT_CHI_SN_TRANSACTION_SV
