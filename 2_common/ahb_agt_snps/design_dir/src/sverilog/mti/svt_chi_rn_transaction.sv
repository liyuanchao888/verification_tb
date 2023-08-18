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

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class represents CHI RN transaction. It basically contains constraints
 * for fields in base class svt_chi_transaction as applicable to Request Node.
 */
class svt_chi_rn_transaction extends svt_chi_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
    * - A bit that indicates that the testbench would like to suspend CompAck response
    *   until this bit is reset for a Read/Dataless/Write request transaction with 
    *   svt_chi_rn_transaction::exp_comp_ack set to 1.
    * - This bit is usually set to 1 by the testbench when it needs to suspend the 
    *   CompAck response from the active RN for this transaction.
    *   The CompAck response will not be sent until this bit is set to 0.
    * - Once the testbench wants to resume the CompAck response for this transaction,
    *   the testbench can set this bit to 0. This enables the active RN to send the
    *   CompAck response.
    * - Applicable for Active RN.  
    * - Default value: 0
    * - By default, the RN driver does not suspend the CompAck response. 
    * .
    * <br>
    * When this field is set to 1, CompAck response will be suspended if
    * svt_chi_rn_transaction::exp_comp_ack is set to 1 for the following request transactions:
    * - ReadNoSnp        (Optional to enable CompAck response)
    * - ReadOnce*         (Optional to enable CompAck response)
    * - ReadClean        (Applicable only for RN-F)
    * - ReadShared       (Applicable only for RN-F)
    * - ReadUnique       (Applicable only for RN-F)
    * - CleanUnique      (Applicable only for RN-F)
    * - MakeReadUnique   (Applicable only for CHI-E or later RN-F)
    * - ReadPreferUnique (Applicable only for CHI-E or later RN-F)
    * - MakeUnique       (Applicable only for RN-F)
    * - CleanShared      (Optional to enable CompAck response for RN-I/RN-D)
    * - CleanInvalid     (Optional to enable CompAck response for RN-I/RN-D)
    * - MakeInvalid      (Optional to enable CompAck response for RN-I/RN-D)
    * - WriteUniqueFull  (Optional to enable CompAck response)
    * - WriteUniquePtl   (Optional to enable CompAck response)
    * .
    * <br>
    * Note that CompAck can be sent only after receiving CompData/Comp as applicable for
    * a given request transaction type.
    */  
  bit suspend_comp_ack = 0;

  /**
    * - A bit that indicates that the testbench would like to suspend Write Data/DVMOp data
    *   until this bit is reset for a Write request transaction that receives
    *   CompDBIDResp/DBIDResp response as applicable for a given transaction type.
    * - This bit is usually set to 1 by the testbench when it needs to suspend the 
    *   Write Data flits from the active RN for this transaction upon receiving
    *   CompDBIDResp/DBIDResp. 
    *   The Write Data flits will not be sent until this bit is set to 0.
    * - Note that setting this bit to 1 while the data flits are already in progress will not
    *   suspend the subsequent write data flits associated to this transaction.
    * - Once the testbench wants to resume the Write Data for this transaction,
    *   the testbench can set this bit to 0. This enables the active RN to send the
    *   Write Data.
    * - Applicable for Active RN.  
    * - Default value: 0
    * - By default, the RN driver does not suspend the Write Data flits.
    * .
    * <br>
    * When this field is set to 1, Write Data  will be suspended for the following Write
    * request transactions and DVM transaction:
    * - WriteBackFull    (write data flit type: CopyBackWrData)
    * - WriteBackPtl     (write data flit type: CopyBackWrData)
    * - WriteCleanFull   (write data flit type: CopyBackWrData)
    * - WriteCleanPtl    (write data flit type: CopyBackWrData)
    * - WriteEvictFull   (write data flit type: CopyBackWrData)
    * - WriteUniqueFull  (write data flit type: NonCopyBackWrData)
    * - WriteUniquePtl   (write data flit type: NonCopyBackWrData)
    * - WriteNoSnpFull   (write data flit type: NonCopyBackWrData)
    * - WriteNoSnpPtl    (write data flit type: NonCopyBackWrData)
    * - DVMOp            (write data flit type: NonCopyBackWrData)
    * - In Case of WriteEvictorEvict transaction (write data flit type: CopyBackWrData), as the data transfer depends on the response from the completer,
    *   - When COMPDBIDRESP is received and this field is set to 1, the write data is suspend until the flag is reset.
    *   - When Comp response is received as there is no write data involved, this field set to 1 doesn't have any effect.
    *   .
    * .
    * Note that Write Data can be generated only after receiving DBIDResp/CompDBIDResp
    * as applicable for a given write request transaction type.
    */  
  bit suspend_wr_data = 0;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------
  /** 
   * This attribute decides the behavior of the active RN agent when a transaction
   * receives a RetryAck response and there is availability of p-credits of the
   * same type that the RetryAck response is received with.
   * - When set to 1, the active RN agent issues the PCrdReturn request message with
   *   the same PCrdType as that is present in RetryAck response.
   * - When set to 0, the active RN agent retries the same transaction with 
   *   is_dyn_p_crd set to 0 and p_crd_type same as the received PcrdType 
   *   through the RetryAck response message.
   * .
   * Applicable only for active RN agent.
   * 
   * 
   */
   
  rand bit p_crd_return_on_retry_ack = 0;

  /**
   * This attribute is applicable only for active RN initiated READONCE and READNOSNP
   * transactions with request order asserted. <br>
   * When set to 1, active RN agent waits for READRECEIPT RSP flit from interconnect
   * before initiating COMPACK RSP flit. <br>
   * When set to 0, initiation of COMPACK RSP flit from active RN agent is independent 
   * of reception of READRECEIPT RSP flit.
   * 
   */
  rand bit compack_follows_readreceipt = 1;

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  /** Random Index that chooses which particular start and end address entry from nonsnoopable address arrays
    * defined in node configuration must be used for randomizing "addr" - transaction address.
    */
  local rand int unsigned nonsnoopable_addr_range_index ;

  /** Random Index that chooses which particular start and end address entry from innersnoopable address arrays
    * defined in node configuration must be used for randomizing "addr" - transaction address.
    */
  local rand int unsigned innersnoopable_addr_range_index ;

  /** Random Index that chooses which particular start and end address entry from outersnoopable address arrays
    * defined in node configuration must be used for randomizing "addr" - transaction address.
    */
  local rand int unsigned outersnoopable_addr_range_index ;

  /** Indicates which domain-address-range has been used to randomize or assign address for this transaction.
    * [0] => '1' represents address belongs to INNERSNOOPABLE domain
    * [1] => '1' represents address belongs to OUTERSNOOPABLE domain
    * [2] => '1' represents address belongs to NONSNOOPABLE domain
    */
  local bit [2:0] addr_based_domain_mode = 0;



  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------
    constraint non_snoopable_domains_not_defined_valid_ranges {
    if (
         (cfg.enable_domain_based_addr_gen) && 
         !(
           (xact_type == EOBARRIER) ||
           (xact_type == ECBARRIER) ||
           (xact_type == DVMOP) ||
`ifdef SVT_CHI_ISSUE_B_ENABLE           
           (xact_type == DVMOP) ||
`endif
           (xact_type == PCRDRETURN) 

         ) &&
         (snp_attr_is_snoopable == 0)
       ) 
       {
        foreach (cfg.innersnoopable_start_addr[i]) {
             (innersnoopable_addr_range_index == i) -> !(addr inside {[cfg.innersnoopable_start_addr[i]:
                                                                     cfg.innersnoopable_end_addr[i]]}); 
        }
        foreach (cfg.outersnoopable_start_addr[i]) {
             (outersnoopable_addr_range_index == i) -> !(addr inside {[cfg.outersnoopable_start_addr[i]:
                                                                     cfg.outersnoopable_end_addr[i]]}); 
        }

       }     

    }

  /**
   * Valid ranges constraints insure that the transaction settings are supported
   * by the chi components.
   */
  constraint chi_rn_transaction_valid_ranges 
  {
   // vb_preserve TMPL_TAG1
   // Add user constraints here
   // vb_preserve end
     
 `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** Constraining the txn_id to be less than 1023 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
   if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
     txn_id inside {[0:1023]};
   }
  /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
   else if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
     txn_id inside {[0:255]};
   }
 `elsif SVT_CHI_ISSUE_D_ENABLE
  /** Constraining the txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
   if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
     txn_id inside {[0:255]};
   }
 `endif

 `ifdef SVT_CHI_ISSUE_E_ENABLE
   //CHI-E or later specific transactions must not be generated for chi_spec_revision set to ISSUE_D or earlier.
   if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_D)
   {
     !(xact_type inside {MAKEREADUNIQUE, WRITEEVICTOREVICT, WRITEUNIQUEZERO, WRITENOSNPZERO,STASHONCESEPSHARED, STASHONCESEPUNIQUE, READPREFERUNIQUE, WRITENOSNPFULL_CLEANSHARED, WRITENOSNPFULL_CLEANINVALID, WRITENOSNPFULL_CLEANSHAREDPERSISTSEP, WRITEUNIQUEFULL_CLEANSHARED, WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP, WRITEBACKFULL_CLEANSHARED, WRITEBACKFULL_CLEANINVALID, WRITEBACKFULL_CLEANSHAREDPERSISTSEP, WRITECLEANFULL_CLEANSHARED, WRITECLEANFULL_CLEANSHAREDPERSISTSEP, WRITENOSNPPTL_CLEANSHARED, WRITENOSNPPTL_CLEANINVALID, WRITENOSNPPTL_CLEANSHAREDPERSISTSEP, WRITEUNIQUEPTL_CLEANSHARED, WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP, STASHONCESEPSHARED, STASHONCESEPUNIQUE});
   }

   //Tag_op for Write*Zero transactions must be INVALID.
   //data must be zero for Write*Zero transactions.
   //byte_enable for Write*Zero are set to all valid.
   //Even though the data and byte_enable fields are not applicable for Write*Zero transactions, they
   //are constrained to 0 and all 1's respectively to simplify the processing logic in System Moniotor and other parts of the code. 
   if(xact_type == WRITEUNIQUEZERO || xact_type == WRITENOSNPZERO)
   {
     data == 0;
     byte_enable == {`SVT_CHI_MAX_BE_WIDTH{1'b1}};
   }
   
   if(xact_type == CLEANSHAREDPERSISTSEP || `SVT_CHI_IS_COMBINED_WRITE_PERSISTENT_CMO) {
     groupid_ext == pgroup_id[7:5];
   }
   
   if(!(xact_type == STASHONCESEPSHARED || xact_type == STASHONCESEPUNIQUE)) {
     stash_group_id == 0;
   }

   if(xact_type == STASHONCESEPSHARED || xact_type == STASHONCESEPUNIQUE) {
     groupid_ext == stash_group_id[7:5];
     lpid == stash_group_id[4:0];
   }
   
   solve req_tag_op before tag, tag_update;
   solve data_tag_op before tag, tag_update;
   if(cfg.mem_tagging_enable == 0 || cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_E) {
     req_tag_op == TAG_INVALID;
     data_tag_op == TAG_INVALID;
     atomic_write_data_tag_op == TAG_INVALID;
     tag == 0;
     tag_update == 0;
     if(xact_type != CLEANSHAREDPERSISTSEP && xact_type != STASHONCESEPSHARED && xact_type != STASHONCESEPUNIQUE && !(`SVT_CHI_IS_COMBINED_WRITE_PERSISTENT_CMO)) {
       groupid_ext  == 0;
     }
     tag_group_id == 0;
   }

   else if(mem_attr_mem_type == DEVICE || 
           mem_attr_is_cacheable == 0
          ) {
     req_tag_op == TAG_INVALID;
     atomic_write_data_tag_op == TAG_INVALID;
     data_tag_op == TAG_INVALID;
     tag == 0;
     tag_update == 0;
     if(xact_type != CLEANSHAREDPERSISTSEP && xact_type != STASHONCESEPSHARED && xact_type != STASHONCESEPUNIQUE && !(`SVT_CHI_IS_COMBINED_WRITE_PERSISTENT_CMO)) {
       groupid_ext  == 0;
     }
     tag_group_id == 0;
   }
   else{
     if((((xact_type == ATOMICSTORE_ADD) || (xact_type == ATOMICSTORE_CLR) ||
          (xact_type == ATOMICSTORE_EOR) || (xact_type == ATOMICSTORE_SET) ||
          (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
          (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
          (xact_type == ATOMICLOAD_ADD) || (xact_type == ATOMICLOAD_CLR) ||
          (xact_type == ATOMICLOAD_EOR) || (xact_type == ATOMICLOAD_SET) ||
          (xact_type == ATOMICLOAD_SMAX) || (xact_type == ATOMICLOAD_SMIN) ||
          (xact_type == ATOMICLOAD_UMAX) || (xact_type == ATOMICLOAD_UMIN) ||
          (xact_type == ATOMICSWAP) || (xact_type == ATOMICCOMPARE)) && req_tag_op == TAG_FETCH_MATCH) ||
        ((xact_type == WRITENOSNPFULL ||
          xact_type == WRITENOSNPPTL ||
          xact_type == WRITEUNIQUEFULL ||
          xact_type == WRITEUNIQUEPTL ||
          xact_type == WRITEUNIQUEFULLSTASH ||
          xact_type == WRITEUNIQUEPTLSTASH) &&
          req_tag_op == TAG_FETCH_MATCH)
       ){
       groupid_ext == tag_group_id[7:5];
     }
     //In case of exclusive Writes with TagOp set to Match, the LPID field also indicates the TagGrroupID value. Therefore,
     // we expect both lpid and tag_group_id to be set to the same value
     if(req_tag_op == TAG_FETCH_MATCH && is_exclusive == 1) {
       lpid == tag_group_id[4:0];
     }
     if(xact_type == WRITEBACKFULL || xact_type == WRITECLEANFULL || xact_type == WRITEBACKFULL_CLEANSHARED || xact_type == WRITEBACKFULL_CLEANINVALID || xact_type == WRITEBACKFULL_CLEANSHAREDPERSISTSEP || xact_type == WRITECLEANFULL_CLEANSHARED || xact_type == WRITECLEANFULL_CLEANSHAREDPERSISTSEP) {
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER, TAG_UPDATE};
       data_tag_op == req_tag_op;
       tag_group_id == 0;
       if(xact_type != WRITEBACKFULL_CLEANSHAREDPERSISTSEP && xact_type != WRITECLEANFULL_CLEANSHAREDPERSISTSEP) {
         groupid_ext  == 0;
       }
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       if(data_tag_op != TAG_UPDATE) {
         tag_update == 0;
       }
     }
     else if(xact_type == WRITENOSNPFULL_CLEANSHARED || xact_type == WRITENOSNPFULL_CLEANINVALID || xact_type == WRITENOSNPFULL_CLEANSHAREDPERSISTSEP) {
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER, TAG_UPDATE};
       if(is_writedatacancel_used_for_write_xact) {
         data_tag_op == TAG_INVALID;
       } 
       else {
         data_tag_op == req_tag_op;
       }
       tag_group_id == 0;
       if(xact_type != WRITENOSNPFULL_CLEANSHAREDPERSISTSEP) {
         groupid_ext  == 0;
       }
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       if(data_tag_op != TAG_UPDATE) {
         tag_update == 0;
       }
     }
     else if(xact_type == WRITENOSNPPTL_CLEANSHARED || xact_type == WRITENOSNPPTL_CLEANINVALID || xact_type == WRITENOSNPPTL_CLEANSHAREDPERSISTSEP) {
       req_tag_op inside {TAG_INVALID, TAG_UPDATE};
       if(is_writedatacancel_used_for_write_xact) {
         data_tag_op == TAG_INVALID;
       } 
       else {
         data_tag_op == req_tag_op;
       }
       tag_group_id == 0;
       if(xact_type != WRITENOSNPPTL_CLEANSHAREDPERSISTSEP) {
         groupid_ext  == 0;
       }
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       if(data_tag_op != TAG_UPDATE) {
         tag_update == 0;
       }
     }
     else if(xact_type == WRITEEVICTFULL || xact_type == WRITEEVICTOREVICT) {
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER};
       data_tag_op == req_tag_op;
       tag_group_id == 0;
       groupid_ext == 0;
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       tag_update == 0;
     }
     else if(xact_type == WRITEUNIQUEFULL || xact_type == WRITEUNIQUEPTL || xact_type == WRITEUNIQUEFULLSTASH || xact_type == WRITEUNIQUEPTLSTASH || xact_type == WRITENOSNPPTL) {
       req_tag_op inside {TAG_INVALID, TAG_UPDATE, TAG_FETCH_MATCH};
       if(req_tag_op != TAG_FETCH_MATCH) {
         tag_group_id == 0;
         groupid_ext == 0;
       }
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       if(data_tag_op != TAG_UPDATE) {
         tag_update == 0;
       }
       if(is_writedatacancel_used_for_write_xact) {
         data_tag_op == TAG_INVALID;
       } 
       else {
         data_tag_op == req_tag_op;
       }
     }
     else if(xact_type == WRITENOSNPFULL) {
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER, TAG_UPDATE, TAG_FETCH_MATCH};
       if(req_tag_op != TAG_FETCH_MATCH) {
         tag_group_id == 0;
         groupid_ext == 0;
       }
       if(data_tag_op == TAG_INVALID) {
         tag == 0;
       }
       if(data_tag_op != TAG_UPDATE) {
         tag_update == 0;
       }
       if(is_writedatacancel_used_for_write_xact) {
         data_tag_op == TAG_INVALID;
       } 
       else {
         data_tag_op == req_tag_op;
       }
     }
     else if(xact_type == WRITEBACKPTL || xact_type == WRITEUNIQUEFULL_CLEANSHARED || xact_type == WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP || xact_type == WRITEUNIQUEPTL_CLEANSHARED || xact_type == WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP || xact_type == WRITEUNIQUEZERO || xact_type == WRITENOSNPZERO || xact_type == CLEANINVALID || xact_type == CLEANSHARED || xact_type == CLEANSHAREDPERSIST || xact_type == MAKEINVALID || xact_type == READONCEMAKEINVALID || xact_type == READONCECLEANINVALID || xact_type == EVICT || xact_type == PCRDRETURN || xact_type == DVMOP || xact_type == CLEANSHAREDPERSISTSEP) {
       req_tag_op == TAG_INVALID;
       data_tag_op == TAG_INVALID;
       tag == 0;
       tag_update == 0;
       tag_group_id == 0;
       if(xact_type != CLEANSHAREDPERSISTSEP && xact_type != WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP && xact_type != WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP) {
         groupid_ext == 0;
       }
     }
     else if(xact_type == CLEANUNIQUE) {
       req_tag_op == TAG_INVALID;
       data_tag_op == TAG_INVALID;
       tag_group_id == 0;
       groupid_ext == 0;
     }
     else if((xact_type == ATOMICSTORE_ADD) || (xact_type == ATOMICSTORE_CLR) ||
               (xact_type == ATOMICSTORE_EOR) || (xact_type == ATOMICSTORE_SET) ||
               (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
               (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
               (xact_type == ATOMICLOAD_ADD) || (xact_type == ATOMICLOAD_CLR) ||
               (xact_type == ATOMICLOAD_EOR) || (xact_type == ATOMICLOAD_SET) ||
               (xact_type == ATOMICLOAD_SMAX) || (xact_type == ATOMICLOAD_SMIN) ||
               (xact_type == ATOMICLOAD_UMAX) || (xact_type == ATOMICLOAD_UMIN) ||
               (xact_type == ATOMICSWAP) || (xact_type == ATOMICCOMPARE)){
       req_tag_op inside {TAG_INVALID, TAG_FETCH_MATCH};
       atomic_write_data_tag_op == req_tag_op;
       if(xact_type == ATOMICCOMPARE && req_tag_op == TAG_FETCH_MATCH) {
         atomic_compare_tag == atomic_swap_tag;
       }
       if(req_tag_op == TAG_INVALID) {
         atomic_compare_tag == 0;
         atomic_swap_tag == 0;
         atomic_store_load_txn_tag == 0;
       }
       if(req_tag_op != TAG_FETCH_MATCH) {
         tag_group_id == 0;
         groupid_ext == 0;
       }
     }
     else if(xact_type == READONCE || xact_type == READCLEAN || xact_type == READSHARED || xact_type == READNOTSHAREDDIRTY || xact_type == READPREFERUNIQUE || xact_type == MAKEREADUNIQUE || xact_type == PREFETCHTGT){
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER};
       tag_group_id == 0;
       groupid_ext == 0;
     }
     else if(xact_type == STASHONCEUNIQUE || xact_type == STASHONCESHARED || xact_type == STASHONCESEPSHARED || xact_type == STASHONCESEPUNIQUE){
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER};
       tag_group_id == 0;
     }
     else if(xact_type == READUNIQUE || xact_type == READNOSNP || xact_type == READNOSNPSEP){
       req_tag_op inside {TAG_INVALID, TAG_TRANSFER, TAG_FETCH_MATCH};
       tag_group_id == 0;
       groupid_ext == 0;
       if(data_size < SIZE_64BYTE) {
         req_tag_op inside {TAG_INVALID, TAG_TRANSFER};
       }
     }
     else if(xact_type == MAKEUNIQUE){
       req_tag_op inside {TAG_INVALID, TAG_UPDATE};
       tag_group_id == 0;
       groupid_ext == 0;
       if(req_tag_op == TAG_UPDATE) {
         tag_update == (1 << `SVT_CHI_MAX_TAG_UPDATE_WIDTH)-1;
       }
     }
     if(data_tag_op == TAG_UPDATE) {
       if(xact_type == WRITEUNIQUEFULL || xact_type == WRITEUNIQUEFULLSTASH || xact_type == WRITENOSNPFULL || xact_type == WRITENOSNPFULL_CLEANSHARED || xact_type == WRITENOSNPFULL_CLEANINVALID || xact_type == WRITENOSNPFULL_CLEANSHAREDPERSISTSEP) {
         tag_update == (1 << `SVT_CHI_MAX_TAG_UPDATE_WIDTH)-1;
       }
     }
   }

   // WRITENOSNPZERO has address aligned to cache line size if
   // mem_attr_mem_type is DEVICE
   if (xact_type == WRITENOSNPZERO && mem_attr_mem_type == DEVICE) {
     addr[5:0] == 6'b0;
   }

   // Address aligned to cache line size if
   // mem_attr_mem_type is DEVICE
   if ((xact_type == WRITENOSNPFULL_CLEANSHARED || xact_type == WRITENOSNPFULL_CLEANSHAREDPERSISTSEP || xact_type == WRITENOSNPFULL_CLEANINVALID) && mem_attr_mem_type == DEVICE) {
     addr[5:0] == 6'b0;
   }
 `endif

 `ifdef SVT_CHI_ISSUE_D_ENABLE
   if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C)
   {
     !(xact_type inside {CLEANSHAREDPERSISTSEP});
   }
 `endif

 //ReadnoSnpSep is not valid for ISSUE_B or earlier spec versions and default standard RN node types.
 //However ReadNoSnpSep can be generated in RN-SN back2back setup when allow_readnosnpsep_from_rn_when_hn_is_absent is set to 1.
 `ifdef SVT_CHI_ISSUE_C_ENABLE
   if ((cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B) ||
       (cfg.chi_node_type == svt_chi_node_configuration::RN && cfg.allow_readnosnpsep_from_rn_when_hn_is_absent == 0))
   {
     !(xact_type inside {READNOSNPSEP});
   }
 `endif
   
   if(cfg.chi_interface_type == svt_chi_node_configuration::RN_I)
   {
    `ifdef SVT_CHI_ISSUE_E_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPFULL_CLEANSHARED,WRITENOSNPFULL_CLEANSHAREDPERSISTSEP, WRITENOSNPFULL_CLEANINVALID, WRITENOSNPPTL_CLEANSHARED, WRITENOSNPPTL_CLEANSHAREDPERSISTSEP, 
                        WRITENOSNPPTL_CLEANINVALID, 
                        WRITEUNIQUEFULL_CLEANSHARED, WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP,WRITEUNIQUEPTL_CLEANSHARED, WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP, 
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER, WRITENOSNPZERO, WRITEUNIQUEZERO,
                        ECBARRIER, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,CLEANSHAREDPERSISTSEP, 
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED, STASHONCESEPUNIQUE, STASHONCESEPSHARED};
    else
    `endif
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST, CLEANSHAREDPERSISTSEP,
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
    `endif
    `ifdef SVT_CHI_ISSUE_C_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_C)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST, 
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
    `endif
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST, 
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, 
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER};
    `else
    xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, 
                      WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                      ECBARRIER};
    `endif
   }

   else if (cfg.chi_interface_type == svt_chi_node_configuration::RN_D)
   {
    `ifdef SVT_CHI_ISSUE_E_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPFULL_CLEANSHARED,WRITENOSNPFULL_CLEANSHAREDPERSISTSEP, WRITENOSNPFULL_CLEANINVALID, WRITENOSNPPTL_CLEANSHARED, WRITENOSNPPTL_CLEANSHAREDPERSISTSEP, 
                        WRITENOSNPPTL_CLEANINVALID, 
                        WRITEUNIQUEFULL_CLEANSHARED, WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP,  WRITEUNIQUEPTL_CLEANSHARED, WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER, WRITENOSNPZERO, WRITEUNIQUEZERO,
                        ECBARRIER, DVMOP, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST, CLEANSHAREDPERSISTSEP,
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED, STASHONCESEPUNIQUE, STASHONCESEPSHARED};
    else
    `endif //issue_e_enable
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, DVMOP, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,CLEANSHAREDPERSISTSEP,
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
    `endif //issue_d_enable_endif
    `ifdef SVT_CHI_ISSUE_C_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_C)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, DVMOP, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
    `endif //issue_c_enable
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B)
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, DVMOP, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,
                        ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                        ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                        ATOMICSWAP, ATOMICCOMPARE, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
    else
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, 
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, DVMOP};
    `else //issue_b_enable else
      xact_type inside {REQLINKFLIT, READNOSNP, READONCE,CLEANSHARED, CLEANINVALID, MAKEINVALID, 
                        WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, EOBARRIER,
                        ECBARRIER, DVMOP};
    `endif //issue_b_enable_endif
    if(cfg.dvm_enable == 0) {xact_type != DVMOP;}
    
   }
    
   `ifdef SVT_CHI_ISSUE_B_ENABLE
   else
   {
     if(cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A)
     {
       xact_type inside {REQLINKFLIT, READNOSNP, READONCE, READCLEAN, READSHARED, READUNIQUE, CLEANUNIQUE, MAKEUNIQUE, CLEANSHARED, CLEANINVALID, MAKEINVALID, 
                         WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, WRITEBACKFULL, WRITEBACKPTL, WRITEEVICTFULL, WRITECLEANFULL, WRITECLEANPTL, EVICT, EOBARRIER,
                         ECBARRIER, DVMOP};
       if(cfg.dvm_enable == 0) {xact_type != DVMOP;}

     }
     else 
     {
     `ifdef SVT_CHI_ISSUE_E_ENABLE
       xact_type inside {WRITEEVICTOREVICT, READPREFERUNIQUE, MAKEREADUNIQUE, WRITENOSNPZERO, WRITEUNIQUEZERO, REQLINKFLIT, READNOSNP, READONCE, READCLEAN, READSHARED, READUNIQUE, CLEANUNIQUE, MAKEUNIQUE, CLEANSHARED, CLEANINVALID, 
                        WRITENOSNPFULL_CLEANSHARED, WRITENOSNPFULL_CLEANSHAREDPERSISTSEP, WRITENOSNPFULL_CLEANINVALID, WRITENOSNPPTL_CLEANSHARED, WRITENOSNPPTL_CLEANSHAREDPERSISTSEP, WRITENOSNPPTL_CLEANINVALID, 
                        WRITEUNIQUEFULL_CLEANSHARED, WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP, WRITEBACKFULL_CLEANINVALID, WRITEUNIQUEPTL_CLEANSHARED,WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP, WRITECLEANFULL_CLEANSHARED,WRITECLEANFULL_CLEANSHAREDPERSISTSEP, WRITEBACKFULL_CLEANSHARED,WRITEBACKFULL_CLEANSHAREDPERSISTSEP,
                         MAKEINVALID, PREFETCHTGT, WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, WRITEBACKFULL, WRITEBACKPTL, WRITEEVICTFULL, WRITECLEANFULL, WRITECLEANPTL, EVICT, EOBARRIER,
                         ECBARRIER, PCRDRETURN, DVMOP, READSPEC, READNOTSHAREDDIRTY, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,CLEANSHAREDPERSISTSEP,
                         ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                         ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                         ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED, STASHONCESEPUNIQUE, STASHONCESEPSHARED};
     `elsif SVT_CHI_ISSUE_D_ENABLE
        xact_type inside {REQLINKFLIT, READNOSNP, READONCE, READCLEAN, READSHARED, READUNIQUE, CLEANUNIQUE, MAKEUNIQUE, CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                         WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, WRITEBACKFULL, WRITEBACKPTL, WRITEEVICTFULL, WRITECLEANFULL, WRITECLEANPTL, EVICT, EOBARRIER,
                         ECBARRIER, PCRDRETURN, DVMOP, READSPEC, READNOTSHAREDDIRTY, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,CLEANSHAREDPERSISTSEP,
                         ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                         ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                         ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
     `elsif SVT_CHI_ISSUE_C_ENABLE
       xact_type inside {REQLINKFLIT, READNOSNP, READONCE, READCLEAN, READSHARED, READUNIQUE, CLEANUNIQUE, MAKEUNIQUE, CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                         WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, WRITEBACKFULL, WRITEBACKPTL, WRITEEVICTFULL, WRITECLEANFULL, WRITECLEANPTL, EVICT, EOBARRIER,
                         ECBARRIER, PCRDRETURN, DVMOP, READSPEC, READNOTSHAREDDIRTY, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,
                         ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                         ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                         ATOMICSWAP, ATOMICCOMPARE, READNOSNPSEP, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
     `else
       xact_type inside {REQLINKFLIT, READNOSNP, READONCE, READCLEAN, READSHARED, READUNIQUE, CLEANUNIQUE, MAKEUNIQUE, CLEANSHARED, CLEANINVALID, MAKEINVALID, PREFETCHTGT,
                         WRITENOSNPPTL, WRITENOSNPFULL, WRITEUNIQUEPTL, WRITEUNIQUEFULL, WRITEBACKFULL, WRITEBACKPTL, WRITEEVICTFULL, WRITECLEANFULL, WRITECLEANPTL, EVICT, EOBARRIER,
                         ECBARRIER, DVMOP, READSPEC, READNOTSHAREDDIRTY, READONCECLEANINVALID, READONCEMAKEINVALID, CLEANSHAREDPERSIST,
                         ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN,
                         ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN,
                         ATOMICSWAP, ATOMICCOMPARE, WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED};
     `endif      
       if(cfg.dvm_enable == 0) {xact_type != DVMOP;}
       if(cfg.sys_cfg.readspec_enable == 0) {xact_type != READSPEC;}
     }
    }
    
    `else
    else
      {
        if(cfg.dvm_enable == 0) {xact_type != DVMOP;}
      }
    `endif

   // In V5, when snpAttr[0] is 0, snpAttr[1] must be 0.
   if ( 
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A) && 
       `endif
       cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0)
   {
     if (snp_attr_is_snoopable == 0)
     { snp_attr_snp_domain_type == INNER; }
   }   
   if(cfg.barrier_enable == 0)
   { 
    xact_type != EOBARRIER;
    xact_type != ECBARRIER;
   }
   
   `ifdef SVT_CHI_ISSUE_E_ENABLE
    if(cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_D || cfg.cache_stashing_enable == 1'b0)
    {
      !(xact_type inside {STASHONCESEPUNIQUE, STASHONCESEPSHARED});
    }
   `endif

  `ifdef SVT_CHI_ISSUE_B_ENABLE
    if(cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A || cfg.atomic_transactions_enable == 1'b0)
    {
      !(xact_type inside {ATOMICSTORE_ADD, ATOMICSTORE_CLR, ATOMICSTORE_EOR, ATOMICSTORE_SET, ATOMICSTORE_SMAX, ATOMICSTORE_SMIN, ATOMICSTORE_UMAX, ATOMICSTORE_UMIN, ATOMICLOAD_ADD, ATOMICLOAD_CLR, ATOMICLOAD_EOR, ATOMICLOAD_SET, ATOMICLOAD_SMAX, ATOMICLOAD_SMIN, ATOMICLOAD_UMAX, ATOMICLOAD_UMIN, ATOMICCOMPARE, ATOMICSWAP});
    }
    
    if(cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A || cfg.cache_stashing_enable == 1'b0)
    {
      !(xact_type inside {WRITEUNIQUEFULLSTASH, WRITEUNIQUEPTLSTASH, STASHONCEUNIQUE, STASHONCESHARED});
    }
    
    if (xact_type == WRITEUNIQUEFULLSTASH || xact_type == WRITEUNIQUEPTLSTASH ||
        xact_type == STASHONCEUNIQUE || xact_type == STASHONCESHARED
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        || xact_type == STASHONCESEPUNIQUE || xact_type == STASHONCESEPSHARED
        `endif
       )
      {
        if(cfg.valid_stash_tgt_id.size() > 0 && stash_nid_valid == 1)
          stash_nid inside {cfg.valid_stash_tgt_id};
        if(stash_nid_valid == 0)
          stash_lpid_valid == 0;
        if(stash_nid_valid == 0)
          stash_nid == 0;
        if(stash_lpid_valid == 0)
          stash_lpid == 0;
      }
  `endif
     
   // WRITENOSNPFULL has address aligned to cache line size if
   // mem_attr_mem_type is NORMAL
   if (xact_type == WRITENOSNPFULL && mem_attr_mem_type == DEVICE) {
     addr[5:0] == 6'b0;
   }
   `ifdef SVT_CHI_ISSUE_B_ENABLE
   else if (
            (xact_type == MAKEINVALID  ||
             xact_type == CLEANINVALID ||
             xact_type == CLEANSHARED  ||
             xact_type == CLEANSHAREDPERSIST
            )
            && mem_attr_mem_type == DEVICE
           ) {
     addr[5:0] == 6'b0;
   }
   `endif
   `ifdef SVT_CHI_ISSUE_D_ENABLE
   else if(xact_type == CLEANSHAREDPERSISTSEP && mem_attr_mem_type == DEVICE) {
     addr[5:0] == 6'b0;
   }
   `endif
  
   //Exclusive non-coherent load and store address must be aligned to the total number of bytes in the transaction
   solve data_size before addr;
   if (is_exclusive == 1'b1 && 
      (xact_type == READNOSNP || xact_type == WRITENOSNPFULL || xact_type == WRITENOSNPPTL)
     )
     {
       if (data_size == 3'b001)
         addr[0:0] == 1'b0;
       if (data_size == 3'b010)
         addr[1:0] == 2'b0;
       if (data_size == 3'b011)
         addr[2:0] == 3'b0;
       if (data_size == 3'b100)
         addr[3:0] == 4'b0;
       if (data_size == 3'b101)
         addr[4:0] == 5'b0;
       if (data_size == 3'b110)
         addr[5:0] == 6'b0;
     }
   if ((xact_type == EOBARRIER) || (xact_type == ECBARRIER))
   {
    addr == {`SVT_CHI_MAX_ADDR_WIDTH{1'b0}};
   }
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     else if((xact_type == ATOMICSTORE_ADD) || (xact_type == ATOMICSTORE_CLR) ||
             (xact_type == ATOMICSTORE_EOR) || (xact_type == ATOMICSTORE_SET) ||
             (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
             (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
             (xact_type == ATOMICLOAD_ADD) || (xact_type == ATOMICLOAD_CLR) ||
             (xact_type == ATOMICLOAD_EOR) || (xact_type == ATOMICLOAD_SET) ||
             (xact_type == ATOMICLOAD_SMAX) || (xact_type == ATOMICLOAD_SMIN) ||
             (xact_type == ATOMICLOAD_UMAX) || (xact_type == ATOMICLOAD_UMIN) ||
             (xact_type == ATOMICSWAP))
     {
       if (data_size == 3'b001)
         addr[0:0] == 1'b0;
       if (data_size == 3'b010)
         addr[1:0] == 2'b0;
       if (data_size == 3'b011)
         addr[2:0] == 3'b0;
     }
     else if(xact_type == ATOMICCOMPARE)
     {
       if (data_size == 3'b010)
         addr[0] == 1'b0;
       if (data_size == 3'b011)
         addr[1:0] == 2'b0;
       if (data_size == 3'b100)
         addr[2:0] == 3'b0;
       if (data_size == 3'b101)
         addr[3:0] == 4'b0;
     }
   `endif
   
   // Transaction ID
   // For link Flit it must be set to Zero
   if ( xact_type == REQLINKFLIT ) {
       txn_id == 0;
   }
   
   // Valid value of Data Size are
   // ReqLinkFlit                            - Any value (Dont care)
   // PCrdReturn,EOBarrier, ECBarrier        - Inapplicable - must be set to ZERO
   // DVMOp                                  - 8 Bytes
   // ReadNoSnp, WriteNoSnp and WriteUnique  - Any value
   // For rest of Request VC messages        - 64 Bytes
   if ((xact_type == PCRDRETURN) || (xact_type == EOBARRIER) || (xact_type == ECBARRIER))
   {
    data_size == SIZE_1BYTE;
   }
   else if (xact_type == DVMOP)
   {
    data_size == SIZE_8BYTE;
   }
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     else if((xact_type == ATOMICSTORE_ADD) || (xact_type == ATOMICSTORE_CLR) ||
             (xact_type == ATOMICSTORE_EOR) || (xact_type == ATOMICSTORE_SET) ||
             (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
             (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
             (xact_type == ATOMICLOAD_ADD) || (xact_type == ATOMICLOAD_CLR) ||
             (xact_type == ATOMICLOAD_EOR) || (xact_type == ATOMICLOAD_SET) ||
             (xact_type == ATOMICLOAD_SMAX) || (xact_type == ATOMICLOAD_SMIN) ||
             (xact_type == ATOMICLOAD_UMAX) || (xact_type == ATOMICLOAD_UMIN) ||
             (xact_type == ATOMICSWAP))
     {
       data_size inside {SIZE_1BYTE, SIZE_2BYTE, SIZE_4BYTE, SIZE_8BYTE};
     }
     else if(xact_type == ATOMICCOMPARE)
     {
       data_size inside {SIZE_2BYTE, SIZE_4BYTE, SIZE_8BYTE, SIZE_16BYTE, SIZE_32BYTE};
     }
   `endif
   else if((xact_type != READNOSNP) && 
           (xact_type != WRITENOSNPPTL) && 
           (xact_type != WRITEUNIQUEPTL) && 
           `ifdef SVT_CHI_ISSUE_B_ENABLE
           (xact_type != WRITEUNIQUEPTLSTASH) && 
           `endif
           `ifdef SVT_CHI_ISSUE_C_ENABLE
           (xact_type != READNOSNPSEP) && 
           `endif
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           (!(`SVT_CHI_IS_PTL_CACHELINE_COMBINED_NCBWRITE_CMO)) && 
           `endif
           (xact_type != REQLINKFLIT)) 
   {
    data_size == SIZE_64BYTE;
   }

   solve addr before data;
   solve xact_type before data;

   /*if(xact_type == DVMOP)
   {
     data[(`SVT_CHI_MAX_DATA_WIDTH-1):42] == 0;
   }*/

   //LikelyShared
   //Reqlinkflit  - Any value (Dont care)
   //
   //For the following command this filed is inapplicable and must be set to ZERO
   //ReadOnce,      ReadNoSnp,     PCrdReturn
   //ReadUnique,    CleanShared,   CleanInvalid
   //MakeInvalid,   CleanUnique,   MakeUnique
   //Evict,         EOBarrier,     ECBarrier
   //DVMOp,         WriteCleanPtl, WriteBackPtl
   //WriteNoSnpPtl, WriteNoSnpFull, WriteNoSnpZero
   //CHI_E: Non-Coherent Combined NCBWrite and (P)CMO type transactions
   if((xact_type == READONCE      ) || (xact_type ==READNOSNP     ) || (xact_type ==PCRDRETURN  ) ||
      (xact_type == READUNIQUE    ) || (xact_type ==CLEANSHARED   ) || (xact_type ==CLEANINVALID) ||
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        (xact_type == READONCECLEANINVALID) || 
        (xact_type == READONCEMAKEINVALID) ||
        (xact_type == CLEANSHAREDPERSIST) ||
        ((xact_type == ATOMICSTORE_ADD)  || (xact_type == ATOMICSTORE_CLR) ||
         (xact_type == ATOMICSTORE_EOR)  || (xact_type == ATOMICSTORE_SET) ||
         (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
         (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
         (xact_type == ATOMICLOAD_ADD)   || (xact_type == ATOMICLOAD_CLR) ||
         (xact_type == ATOMICLOAD_EOR)   || (xact_type == ATOMICLOAD_SET) ||
         (xact_type == ATOMICLOAD_SMAX)  || (xact_type == ATOMICLOAD_SMIN) ||
         (xact_type == ATOMICLOAD_UMAX)  || (xact_type == ATOMICLOAD_UMIN) ||
         (xact_type == ATOMICSWAP)       || (xact_type == ATOMICCOMPARE)) ||
      `endif
      `ifdef SVT_CHI_ISSUE_D_ENABLE
      (xact_type == CLEANSHAREDPERSISTSEP) ||
      `endif
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       (xact_type == MAKEREADUNIQUE) ||
       (xact_type == READPREFERUNIQUE) ||
      `endif
      (xact_type == MAKEINVALID   ) || (xact_type ==CLEANUNIQUE   ) || (xact_type ==MAKEUNIQUE  ) ||
      (xact_type == EVICT         ) || (xact_type ==EOBARRIER     ) || (xact_type ==ECBARRIER   ) ||
      (xact_type == DVMOP         ) || (xact_type ==WRITECLEANPTL ) || (xact_type ==WRITEBACKPTL) ||
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == WRITENOSNPZERO) || 
        `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
      `endif
      (xact_type == WRITENOSNPPTL ) || (xact_type ==WRITENOSNPFULL))
   {
    is_likely_shared == 1'b0;
   }                              
    
  `ifdef SVT_CHI_ISSUE_B_ENABLE
     //data_source is supported only for compdata, snprespdata and snprespdataptl 
     if((cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) && (transaction_category != READ)) {
         data_source == DATA_SOURCE_UNSUPPORTED;
     }
  `endif

   // Non secure access mode
   // For following command this field is inapplicable and must be set to ZERO
   // PCrdReturn, EOBarrier , ECBarrier, DVMOp
   //
   // For Reqlinkflit field value is not defined 
   if((xact_type == PCRDRETURN) || (xact_type == EOBARRIER) || (xact_type == ECBARRIER) || (xact_type == DVMOP))
   {
    is_non_secure_access == 1'b0;
   }

   //Dynamic Protocol Credit
   if(
      `ifdef SVT_CHI_ISSUE_B_ENABLE
       (xact_type == PREFETCHTGT) || 
      `endif
     (xact_type == PCRDRETURN)     
     ){ is_dyn_p_crd == 1'b0;}
   else {is_dyn_p_crd == 1'b1;}

   // With is_dyn_p_crd = 1, p_crd_type must be type0
   if (is_dyn_p_crd == 1'b1) {p_crd_type == TYPE0;}
   // Order
   // This field specifies the ordering requirements for a transaction
   //
   // For following request VC messages order files is inapplicable and must be set to ZERO
   // ReadShared,     ReadClean,      PCrdReturn
   // ReadUnique,     CleanShared,    CleanInvalid
   // MakeInvalid,    CleanUnique,    MakeUnique
   // Evict,          EOBarrier,      ECBarrier
   // DVMOp,          WriteEvictFull, WriteCleanPtl
   // WriteCleanFull, WriteBackPtl,   WriteBackFull
   // For Reqlinkflit field value is not defined 
   // CHI_E: WRITEEVICTOREVICT order field is inapplicable and must be set to ZERO
   // CHI_E: Coherent Combined CBWrite and (P)CMO type transactions, order field is inapplicable and must be set to ZERO
   if((xact_type == READSHARED     ) || (xact_type == READCLEAN     ) || (xact_type ==  PCRDRETURN   ) ||
      (xact_type == READUNIQUE     ) || (xact_type == CLEANSHARED   ) || (xact_type ==  CLEANINVALID ) ||
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        (xact_type == READNOTSHAREDDIRTY) || 
        (xact_type == READSPEC) ||
        (xact_type == CLEANSHAREDPERSIST) ||
        (xact_type == STASHONCEUNIQUE) ||
        (xact_type == STASHONCESHARED) ||
      `endif
      `ifdef SVT_CHI_ISSUE_D_ENABLE
        (xact_type == CLEANSHAREDPERSISTSEP) ||
      `endif
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == MAKEREADUNIQUE) || (xact_type == READPREFERUNIQUE) ||
        (xact_type == WRITEEVICTOREVICT) || 
        `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
        (xact_type == STASHONCESEPUNIQUE) ||
        (xact_type == STASHONCESEPSHARED) ||
      `endif
      (xact_type == MAKEINVALID    ) || (xact_type == CLEANUNIQUE   ) || (xact_type ==  MAKEUNIQUE   ) ||
      (xact_type == EVICT          ) || (xact_type == EOBARRIER     ) || (xact_type ==  ECBARRIER    ) ||
      (xact_type == DVMOP          ) || (xact_type == WRITEEVICTFULL) || (xact_type ==  WRITECLEANPTL) ||
      (xact_type == WRITECLEANFULL ) || (xact_type == WRITEBACKPTL  ) || (xact_type ==  WRITEBACKFULL))
   {  order_type  == NO_ORDERING_REQUIRED; }

   if(xact_type == READONCE
     `ifdef SVT_CHI_ISSUE_B_ENABLE
     || xact_type == READONCECLEANINVALID || xact_type == READONCEMAKEINVALID
     `endif
     ) {
     order_type != REQ_EP_ORDERING_REQUIRED;
   }
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     if((xact_type == ATOMICSTORE_ADD)  || (xact_type == ATOMICSTORE_CLR) ||
        (xact_type == ATOMICSTORE_EOR)  || (xact_type == ATOMICSTORE_SET) ||
        (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
        (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
        (xact_type == ATOMICLOAD_ADD)   || (xact_type == ATOMICLOAD_CLR) ||
        (xact_type == ATOMICLOAD_EOR)   || (xact_type == ATOMICLOAD_SET) ||
        (xact_type == ATOMICLOAD_SMAX)  || (xact_type == ATOMICLOAD_SMIN) ||
        (xact_type == ATOMICLOAD_UMAX)  || (xact_type == ATOMICLOAD_UMIN) ||
        (xact_type == ATOMICSWAP)       || (xact_type == ATOMICCOMPARE)) {
       if(mem_attr_mem_type == NORMAL) {
         order_type != REQ_EP_ORDERING_REQUIRED;
       }
     }
     if(cfg.allow_dmt_from_rn_when_hn_is_absent == 0 || 
        (xact_type != READNOSNP 
         `ifdef SVT_CHI_ISSUE_C_ENABLE
         && xact_type != READNOSNPSEP
         `endif
        ) || 
        return_nid == src_id){
       order_type != REQ_ACCEPTED;
     }
   `endif
   
   `ifdef SVT_CHI_ISSUE_C_ENABLE
     if(xact_type == READNOSNPSEP){
       order_type == REQ_ACCEPTED;
     }
   `endif

   //Memory Attribute Allocate
   if((xact_type == PCRDRETURN) || (xact_type == EVICT ) ||  (xact_type == EOBARRIER ) || 
      `ifdef SVT_CHI_ISSUE_B_ENABLE
      (xact_type == READONCEMAKEINVALID) || 
      `endif
      (xact_type == ECBARRIER ) || (xact_type == DVMOP))
   { mem_attr_allocate_hint  == 1'b0;}
   
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     if (xact_type == WRITEEVICTFULL && cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) {mem_attr_allocate_hint == 1'b1;}
   `endif
   
   // CHI_E: WriteEvictorEvict: mem_attr_allocate_hint must be set to 1
   `ifdef SVT_CHI_ISSUE_E_ENABLE
     if (xact_type == WRITEEVICTOREVICT) {mem_attr_allocate_hint == 1'b1;}
   `endif
   
   //Memory Attribute cacheable
   if((xact_type == PCRDRETURN) || (xact_type == EOBARRIER) || (xact_type == ECBARRIER) || (xact_type == DVMOP))
   { mem_attr_is_cacheable == 1'b0; }
   else if ((xact_type == READSHARED)     || (xact_type == READCLEAN)      || (xact_type == READONCE)        || 
      (xact_type == READUNIQUE)     || (xact_type == CLEANUNIQUE)    || (xact_type == MAKEUNIQUE)      || 
      `ifdef SVT_CHI_ISSUE_B_ENABLE
      (xact_type == READNOTSHAREDDIRTY) || (xact_type == READSPEC) || (xact_type == READONCECLEANINVALID) || (xact_type == READONCEMAKEINVALID) || (xact_type == WRITEUNIQUEPTLSTASH) || (xact_type == WRITEUNIQUEFULLSTASH) || (xact_type == STASHONCEUNIQUE) || (xact_type == STASHONCESHARED) ||
      `endif
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       (xact_type == MAKEREADUNIQUE) || (xact_type == READPREFERUNIQUE) ||
       (xact_type == STASHONCESEPUNIQUE) ||
       (xact_type == STASHONCESEPSHARED) ||
      `endif
      (xact_type == EVICT)          || (xact_type == WRITEEVICTFULL) || (xact_type == WRITECLEANPTL)   || 
      (xact_type == WRITECLEANFULL) || (xact_type == WRITEUNIQUEPTL) || (xact_type == WRITEUNIQUEFULL) || 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      (xact_type == WRITEUNIQUEZERO) || (xact_type == WRITEEVICTOREVICT) || 
      `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
      `endif
      (xact_type == WRITEBACKPTL)   || (xact_type == WRITEBACKFULL))
   { mem_attr_is_cacheable == 1'b1;}

   //Memory Attribute Memory type
   if((xact_type != REQLINKFLIT) && (xact_type != READNOSNP) && (xact_type != WRITENOSNPPTL) && 
        (xact_type != WRITENOSNPFULL) 
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        && (
            (
             (xact_type != CLEANSHARED) && (xact_type != CLEANINVALID) &&
             (xact_type != MAKEINVALID) && (xact_type != CLEANSHAREDPERSIST)
            ) 
            || cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A
           ) &&
        (xact_type != ATOMICSTORE_ADD) && (xact_type != ATOMICSTORE_CLR) &&
        (xact_type != ATOMICSTORE_EOR)  && (xact_type != ATOMICSTORE_SET) &&
        (xact_type != ATOMICSTORE_SMAX) && (xact_type != ATOMICSTORE_SMIN) &&
        (xact_type != ATOMICSTORE_UMAX) && (xact_type != ATOMICSTORE_UMIN) &&
        (xact_type != ATOMICLOAD_ADD)   && (xact_type != ATOMICLOAD_CLR) &&
        (xact_type != ATOMICLOAD_EOR)   && (xact_type != ATOMICLOAD_SET) &&
        (xact_type != ATOMICLOAD_SMAX)  && (xact_type != ATOMICLOAD_SMIN) &&
        (xact_type != ATOMICLOAD_UMAX)  && (xact_type != ATOMICLOAD_UMIN) &&
        (xact_type != ATOMICSWAP)       && (xact_type != ATOMICCOMPARE)
        `endif
        `ifdef SVT_CHI_ISSUE_D_ENABLE
        && (xact_type != CLEANSHAREDPERSISTSEP)
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        && (xact_type != WRITENOSNPZERO)
        && (!(`SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO))
        `endif
      )
   {mem_attr_mem_type == NORMAL;}
   
   
   //Memory Attribute Early Write Acknowledge bit
   if((xact_type == PCRDRETURN) || (xact_type == EOBARRIER) || (xact_type == ECBARRIER) || (xact_type == DVMOP))
   { mem_attr_is_early_wr_ack_allowed == 1'b0;}
   else if((xact_type == READSHARED)     || (xact_type == READCLEAN)      || (xact_type == READONCE)        || 
           `ifdef SVT_CHI_ISSUE_B_ENABLE
           (xact_type == READNOTSHAREDDIRTY) || 
           (xact_type == READSPEC) || 
           (xact_type == READONCECLEANINVALID) || 
           (xact_type == READONCEMAKEINVALID) ||
           ((cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B) && (xact_type == CLEANSHAREDPERSIST)) ||
           (xact_type == WRITEUNIQUEPTLSTASH) ||
           (xact_type == WRITEUNIQUEFULLSTASH) ||
           (xact_type == STASHONCEUNIQUE) ||
           (xact_type == STASHONCESHARED) ||
           `endif
           ((cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B) && (xact_type == MAKEINVALID)) ||
           ((cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B) && (xact_type == CLEANSHARED)) ||
           ((cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_B) && (xact_type == CLEANINVALID)) ||
           (xact_type == READUNIQUE)     ||  
           (xact_type == CLEANUNIQUE)    || (xact_type == MAKEUNIQUE)      ||
           `ifdef SVT_CHI_ISSUE_D_ENABLE
           (xact_type == CLEANSHAREDPERSISTSEP) ||
           `endif
           `ifdef SVT_CHI_ISSUE_E_ENABLE
            (xact_type == MAKEREADUNIQUE) || (xact_type == READPREFERUNIQUE) ||
            (xact_type == STASHONCESEPUNIQUE) ||
            (xact_type == STASHONCESEPSHARED) ||
           `endif
           (xact_type == EVICT)          || (xact_type == WRITEEVICTFULL) || (xact_type == WRITECLEANPTL)   || 
           (xact_type == WRITECLEANFULL) || (xact_type == WRITEUNIQUEPTL) || (xact_type == WRITEUNIQUEFULL) || 
           `ifdef SVT_CHI_ISSUE_E_ENABLE
           (xact_type == WRITEUNIQUEZERO) || (xact_type == WRITEEVICTOREVICT) ||  
           `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO ||
           `endif
           (xact_type == WRITEBACKPTL)   || (xact_type == WRITEBACKFULL))
   { mem_attr_is_early_wr_ack_allowed == 1'b1;}
   
   solve mem_attr_mem_type before mem_attr_is_early_wr_ack_allowed, mem_attr_is_cacheable, mem_attr_allocate_hint,order_type;
   solve mem_attr_is_cacheable before mem_attr_is_early_wr_ack_allowed;

   // Refer AppendixC : MEM ATTRIBUTE MAPPING
   if(xact_type != REQLINKFLIT)
   {
    if(mem_attr_mem_type == DEVICE)
    {
     mem_attr_allocate_hint == 1'b0;
     mem_attr_is_cacheable  == 1'b0;
     if (cfg.chi_node_type == svt_chi_node_configuration::RN) {
       if (!mem_attr_is_early_wr_ack_allowed)
         order_type == REQ_EP_ORDERING_REQUIRED;
     }
    }
    else //mem_attr_mem_type == NORMAL
    {
     if(mem_attr_allocate_hint == 1'b1) {mem_attr_is_cacheable == 1'b1;}
     if(mem_attr_is_cacheable  == 1'b1) {mem_attr_is_early_wr_ack_allowed == 1'b1;}
     }
    }
  
   //Snoop Attribute - SnoopDomain
   //For CHI-E nodes, this field is not applicable
   //For PCrdReturn, EOBarrier, ECBarrier - Inapplicable - field must be set to zero
   //
   //For ReadNoSnp, WriteNoSnpPtl, WriteNoSnpFull - Inner snoop domain
   //
   //For Reqlinkflit this field value is not defined (may be any value)
   if(
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A) && 
       `endif
       ((xact_type == PCRDRETURN) || (xact_type == EOBARRIER)     || (xact_type == ECBARRIER) ||
      (xact_type == READNOSNP)  || (xact_type == WRITENOSNPPTL) || (xact_type == WRITENOSNPFULL)))
   { snp_attr_snp_domain_type == INNER;}

   //Snoop Attribute - Snoopable
   // For Reqlinkflit this field value is not defined (may be any value)
   //
   // For PCrdReturn, EOBarrier, ECBarrier, DVMOp   - Inapplicable - field must be set to zero
   //
   // For following Request VC messages Snoopable should be set to one
   // ReadShared, ReadClean, ReadOnce, ReadUnique, CleanUnique, MakeUnique
   // Evict, WriteEvictFull, WriteCleanPtl, WriteCleanFull, WriteUniquePtl
   // WriteUniqueFull, WriteBackPtl, WriteBackFull
   // CHI_E: WriteUniqueZero, WriteEvictorEvict
   //
   // For ReadNoSnp, WriteNoSnpPtl, WriteNoSnpFull, WriteNoSnpZero - Non-Snoopable (set to Zero)
   if((xact_type == READSHARED)    || (xact_type == READCLEAN)      || (xact_type == READONCE)       || (xact_type == READUNIQUE)     || 
      `ifdef SVT_CHI_ISSUE_B_ENABLE
      (xact_type == READNOTSHAREDDIRTY) || (xact_type == READSPEC) || (xact_type == READONCECLEANINVALID) || 
      (xact_type == READONCEMAKEINVALID) || (xact_type == WRITEUNIQUEPTLSTASH) || (xact_type == WRITEUNIQUEFULLSTASH)||
      (xact_type == STASHONCEUNIQUE) || (xact_type == STASHONCESHARED)||
      `endif
      (xact_type == CLEANUNIQUE)   || (xact_type == MAKEUNIQUE)     || (xact_type == EVICT)          || (xact_type == WRITEEVICTFULL) || 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
       (xact_type == MAKEREADUNIQUE) || (xact_type == READPREFERUNIQUE) ||
      `endif
      (xact_type == WRITECLEANPTL) || (xact_type == WRITECLEANFULL) || (xact_type == WRITEUNIQUEPTL) || (xact_type == WRITEUNIQUEFULL)|| 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      (xact_type == WRITEUNIQUEZERO) || (xact_type == WRITEEVICTOREVICT) ||  
      `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO ||
      (xact_type == STASHONCESEPUNIQUE) ||
      (xact_type == STASHONCESEPSHARED) ||
      `endif
      (xact_type == WRITEBACKPTL)  || (xact_type == WRITEBACKFULL))
   { snp_attr_is_snoopable == 1'b1;}
   else if ((xact_type == PCRDRETURN) || (xact_type == EOBARRIER)     || (xact_type == ECBARRIER)      || (xact_type == DVMOP) ||
            `ifdef SVT_CHI_ISSUE_E_ENABLE
            (xact_type == WRITENOSNPZERO) || 
            `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
            `endif
            (xact_type == READNOSNP)  || (xact_type == WRITENOSNPPTL) || (xact_type == WRITENOSNPFULL))
   { snp_attr_is_snoopable == 1'b0;}
   
   if(snp_attr_is_snoopable == 1) {mem_attr_is_cacheable == 1'b1;}
   

   if(cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0 && xact_type != REQLINKFLIT && xact_type != PCRDRETURN && xact_type != EOBARRIER && 
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        xact_type != PREFETCHTGT &&
        (!(xact_type == READNOSNP && cfg.allow_dmt_from_rn_when_hn_is_absent == 1)) &&
      `endif
      `ifdef SVT_CHI_ISSUE_C_ENABLE
        xact_type != READNOSNPSEP &&
      `endif
        xact_type != ECBARRIER && xact_type != DVMOP) {{mem_attr_mem_type, mem_attr_allocate_hint, mem_attr_is_cacheable, mem_attr_is_early_wr_ack_allowed, snp_attr_snp_domain_type, snp_attr_is_snoopable, is_likely_shared, order_type} inside {{1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b11}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b11}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 2'b10},  {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 2'b10}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 2'b10}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 2'b10}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 2'b10}};}

`ifdef SVT_CHI_ISSUE_B_ENABLE
   if(cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0 && (xact_type == READNOSNP && cfg.allow_dmt_from_rn_when_hn_is_absent == 1)
     ) {{mem_attr_mem_type, mem_attr_allocate_hint, mem_attr_is_cacheable, mem_attr_is_early_wr_ack_allowed, snp_attr_snp_domain_type, snp_attr_is_snoopable, is_likely_shared, order_type} inside {{1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b11}, {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b11}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}};}
`endif

`ifdef SVT_CHI_ISSUE_C_ENABLE
   if(cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0 && xact_type == READNOSNPSEP) {{mem_attr_mem_type, mem_attr_allocate_hint, mem_attr_is_cacheable, mem_attr_is_early_wr_ack_allowed, snp_attr_snp_domain_type, snp_attr_is_snoopable, is_likely_shared, order_type} inside {{1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01}, {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10}};}
`endif

   // Valid value of Data Size are
   // Exclusive bit
   //
   // For the following Request VC messages  Exclusive bit Inapplicable - field must be set to zero
   // ReadOnce, PCrdReturn, ReadUnique, CleanShared, CleanInvalid, MakeInvalid
   // MakeUnique, Evict, EOBarrier, ECBarrier, DVMOp, WriteEvictFull, WriteCleanPtl
   // WriteCleanFull. WriteUniquePtl, WriteUniqueFull, WriteBackPtl, WriteBackFull
   // For ReadNoSnp, WriteNoSnpPtl, WriteNoSnpFull if Memory Attribute field cacheable set to ONE
   // the Exclusive bit is inapplicable. For these transactions cacheable
   // attributes shouldbe set to 0 or mem_type should be device
   // CHI_E: WriteEvictorEvict Exclusive bit Inapplicable - field must be set to zero

   if((xact_type == READONCE && cfg.coherent_exclusive_access_from_rni_rnd_ports_enable == 0) || 
      (xact_type == PCRDRETURN)     || (xact_type == READUNIQUE)     || (xact_type == CLEANSHARED)    || 
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (xact_type == READSPEC) || 
       (xact_type == READONCECLEANINVALID) || 
       (xact_type == READONCEMAKEINVALID) ||
       (xact_type == CLEANSHAREDPERSIST) ||
       ((xact_type == ATOMICSTORE_ADD)  || (xact_type == ATOMICSTORE_CLR) ||
         (xact_type == ATOMICSTORE_EOR)  || (xact_type == ATOMICSTORE_SET) ||
         (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
         (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
         (xact_type == ATOMICLOAD_ADD)   || (xact_type == ATOMICLOAD_CLR) ||
         (xact_type == ATOMICLOAD_EOR)   || (xact_type == ATOMICLOAD_SET) ||
         (xact_type == ATOMICLOAD_SMAX)  || (xact_type == ATOMICLOAD_SMIN) ||
         (xact_type == ATOMICLOAD_UMAX)  || (xact_type == ATOMICLOAD_UMIN) ||
         (xact_type == ATOMICSWAP)       || (xact_type == ATOMICCOMPARE)) ||
         (xact_type == WRITEUNIQUEPTLSTASH) ||
         (xact_type == WRITEUNIQUEFULLSTASH) ||
         (xact_type == STASHONCEUNIQUE) ||
         (xact_type == STASHONCESHARED) ||
       `endif
       `ifdef SVT_CHI_ISSUE_D_ENABLE
       (xact_type == CLEANSHAREDPERSISTSEP) ||
       `endif
      (xact_type == CLEANINVALID)   || (xact_type == MAKEINVALID)    || (xact_type == MAKEUNIQUE)     || (xact_type == EVICT)          || 
      (xact_type == EOBARRIER)      || (xact_type == ECBARRIER)      || (xact_type == DVMOP)          || (xact_type == WRITEEVICTFULL) || 
      (xact_type == WRITECLEANPTL)  || (xact_type == WRITECLEANFULL) || 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == WRITEEVICTOREVICT)  ||  
        `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
        (xact_type == STASHONCESEPUNIQUE) ||
        (xact_type == STASHONCESEPSHARED) ||
      `endif
      ((xact_type == WRITEUNIQUEPTL ||  xact_type == WRITEUNIQUEFULL) && cfg.coherent_exclusive_access_from_rni_rnd_ports_enable == 0) || 
      (xact_type == WRITEBACKPTL)   || (xact_type == WRITEBACKFULL))
   { is_exclusive == 1'b0; }

   if((cfg.exclusive_access_enable == 0) && (xact_type != REQLINKFLIT))
   { is_exclusive == 1'b0; }
 
   //excl bit must be set to zero for Write*zero transactions.
 `ifdef SVT_CHI_ISSUE_E_ENABLE
   if(xact_type == WRITEUNIQUEZERO || xact_type == WRITENOSNPZERO)
     { is_exclusive == 1'b0; }
 `endif
 `ifdef SVT_CHI_ISSUE_B_ENABLE
   if(!((xact_type == ATOMICSTORE_ADD)  || (xact_type == ATOMICSTORE_CLR) ||
        (xact_type == ATOMICSTORE_EOR)  || (xact_type == ATOMICSTORE_SET) ||
        (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
        (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
        (xact_type == ATOMICLOAD_ADD)   || (xact_type == ATOMICLOAD_CLR) ||
        (xact_type == ATOMICLOAD_EOR)   || (xact_type == ATOMICLOAD_SET) ||
        (xact_type == ATOMICLOAD_SMAX)  || (xact_type == ATOMICLOAD_SMIN) ||
        (xact_type == ATOMICLOAD_UMAX)  || (xact_type == ATOMICLOAD_UMIN) ||
        (xact_type == ATOMICSWAP)       || (xact_type == ATOMICCOMPARE)))
   { 
     snoopme == 1'b0;
     endian == 1'b0;
   }
   
   if(!((xact_type == WRITEUNIQUEFULLSTASH) || 
        (xact_type == WRITEUNIQUEPTLSTASH)  ||
        (xact_type == STASHONCEUNIQUE)      || 
        (xact_type == STASHONCESHARED)
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        || (xact_type == STASHONCESEPUNIQUE)
        || (xact_type == STASHONCESEPSHARED)
        `endif
       )
     )
   { 
     stash_nid_valid == 1'b0;
     stash_nid == 0;
     stash_lpid_valid == 1'b0;
     stash_lpid == 0;
   }
 `endif

   //ExpCompAck
   //Expect CompAck bit, This bit is used to indicate that the transaction will include a CompAck.
   //
   // For following Request VC Messages this field must be set to ZERO:
   // o Inapplicable: PrefetchTgt, PCrdReturn, Evict, EOBarrier, ECBarrier, DVMOp, WriteEvictFull, WriteCleanPtl
   //   WriteCleanFull, WriteBackPtl, WriteBackFull
   // o WriteNoSnpFull, WriteNoSnpPtl (When svt_chi_node_configuration::chi_spec_revision is ISSUE_C or earlier)
   // o WriteUniqueFull, WriteUniquePtl: When ReqOrder is not asserted, that is, not the optimized
   //   streaming ordered writeUniques => reqOrder is not asserted.
   // o CHI_E: WriteUniqueZero, WriteNoSnpZero, WriteEvictorEvict 
   //
   // For following Request VC Messages this field must be set to ONE:
   // o ReadShared, ReadClean, ReadUnique, CleanUnique, MakeUnique
   // o WriteUniqueFull, WriteUniquePtl: When ReqOrder is asserted, that is, the optimized streaming
   //   ordered writeUniques.
   //
   // In case of CHI Version 3.0:
   // o For following Request VC Messages this field must be set to ONE for RN-F node and
   //   ZERO for RN-I/RN-D nodes.
   //   ReadOnce, ReadNoSnp, CleanShared, CleanInvalid, MakeInvalid
   // In case of CHI Version 5.0:
   // o ReadNoSnp: Its optional for RN-F, RN-I/RN-D. So no need to constrain.
   // o ReadOnce, CleanShared, CleanInvalid, MakeInvalid:
   //   - RN-F: still same as version 3.0, that is, should be set to 1'b1.
   //   - RN-I/RN-D: Optional. So no need to constrain.
   //
   // In case of svt_chi_node_configuration::chi_spec_revision is ISSUE_D or later and svt_chi_node_configuration::streaming_ordered_writenosnp_enable is set to 1:
   // o For WriteNoSnpFull and WriteNoSnpPtl exp_comp_ack can be set to 1 when order_type is set to REQ_ORDERING_REQUIRED.
   // In case of svt_chi_node_configuration::chi_spec_revision is ISSUE_E or later:
   // o For WriteNoSnp_CMO and WriteUnique_CMO, exp_comp_ack can be set to 1 when order_type is set to REQ_ORDERING_REQUIRED.
   if((xact_type == PCRDRETURN)    || (xact_type == EVICT)          || (xact_type == EOBARRIER)      || 
      (xact_type == ECBARRIER)     || (xact_type == DVMOP)          || (xact_type == WRITEEVICTFULL) || 
      (xact_type == WRITECLEANPTL) || (xact_type == WRITECLEANFULL) || (xact_type == WRITEBACKPTL)   || 
      (xact_type == WRITEBACKFULL) || 
      `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == WRITEUNIQUEZERO)  || (xact_type == WRITENOSNPZERO) ||
        `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
      `endif
      `ifdef SVT_CHI_ISSUE_B_ENABLE
        ((xact_type == ATOMICSTORE_ADD)  || (xact_type == ATOMICSTORE_CLR) ||
         (xact_type == ATOMICSTORE_EOR)  || (xact_type == ATOMICSTORE_SET) ||
         (xact_type == ATOMICSTORE_SMAX) || (xact_type == ATOMICSTORE_SMIN) ||
         (xact_type == ATOMICSTORE_UMAX) || (xact_type == ATOMICSTORE_UMIN) ||
         (xact_type == ATOMICLOAD_ADD)   || (xact_type == ATOMICLOAD_CLR) ||
         (xact_type == ATOMICLOAD_EOR)   || (xact_type == ATOMICLOAD_SET) ||
         (xact_type == ATOMICLOAD_SMAX)  || (xact_type == ATOMICLOAD_SMIN) ||
         (xact_type == ATOMICLOAD_UMAX)  || (xact_type == ATOMICLOAD_UMIN) ||
         (xact_type == ATOMICSWAP)       || (xact_type == ATOMICCOMPARE)) ||
         (xact_type == STASHONCEUNIQUE)  || (xact_type == STASHONCESHARED) ||
         (xact_type == PREFETCHTGT) ||
      `endif
      ((order_type == NO_ORDERING_REQUIRED) && 
       (
        (xact_type == WRITEUNIQUEFULL) || 
        `ifdef SVT_CHI_ISSUE_E_ENABLE
          `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO ||
          (xact_type == STASHONCESEPUNIQUE) ||
          (xact_type == STASHONCESEPSHARED) ||
        `endif
        `ifdef SVT_CHI_ISSUE_B_ENABLE
         (xact_type == WRITEUNIQUEPTLSTASH) ||
         (xact_type == WRITEUNIQUEFULLSTASH) ||
        `endif
        (xact_type == WRITEUNIQUEPTL)
       )
      )
   )
   { exp_comp_ack == 1'b0;}
   else if((xact_type == READSHARED)  || (xact_type == READCLEAN)  || (xact_type == READUNIQUE) || 
           (xact_type == CLEANUNIQUE) || (xact_type == MAKEUNIQUE) || 
           `ifdef SVT_CHI_ISSUE_E_ENABLE
            (xact_type == MAKEREADUNIQUE) || (xact_type == READPREFERUNIQUE) ||
            (xact_type == WRITEEVICTOREVICT)  || 
           `endif
           `ifdef SVT_CHI_ISSUE_B_ENABLE
             (xact_type == READSPEC) || (xact_type == READNOTSHAREDDIRTY) ||
           `endif
           (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A && (order_type != NO_ORDERING_REQUIRED) && ((xact_type == WRITEUNIQUEFULL) || (xact_type == WRITEUNIQUEPTL)))
          )
   { exp_comp_ack == 1'b1;}
   else if ((xact_type == READONCE)     || (xact_type == READNOSNP) || (xact_type == CLEANSHARED) || 
            `ifdef SVT_CHI_ISSUE_B_ENABLE
              (xact_type == READONCECLEANINVALID) || 
              (xact_type == READONCEMAKEINVALID) ||
              (xact_type == CLEANSHAREDPERSIST) ||
            `endif
            (xact_type == CLEANINVALID) || (xact_type == MAKEINVALID))
   {
    if (cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_3_0)
    {
     if(cfg.chi_interface_type == svt_chi_node_configuration::RN_F)
     {exp_comp_ack == 1'b1;}
     else
     {exp_comp_ack == 1'b0;}
    }
    else if (cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0)
    {
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      //An RN-F must not include a CompAck response in StashOnce, CMO, Atomic or Evict transactions
      if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B)
      {
        if((xact_type == CLEANSHARED) || (xact_type == CLEANINVALID) || (xact_type == MAKEINVALID) || (xact_type == CLEANSHAREDPERSIST))
        {
         exp_comp_ack == 1'b0;
        }  
      }
      else {
        // As per spec version ARM IHI 0050A, Except ReadNoSnp and ReadOnce, others have still the same requirement for RN-F mode.
        // In RN-I/RN-D mode, no need to constrain for any of these xact_types.
        if((cfg.chi_interface_type == svt_chi_node_configuration::RN_F) && ((xact_type != READONCE)&&(xact_type != READNOSNP)))
          {exp_comp_ack == 1'b1;}
      }
    `else
     // Except ReadNoSnp and ReadOnce, others have still the same requirement for RN-F mode.
     // In RN-I/RN-D mode, no need to constrain for any of these xact_types.
     if((cfg.chi_interface_type == svt_chi_node_configuration::RN_F) && ((xact_type != READONCE)&&(xact_type != READNOSNP)))
     {exp_comp_ack == 1'b1;}
    `endif
    }    
   } 
   else
   if(xact_type == WRITENOSNPFULL || xact_type == WRITENOSNPPTL) {
   `ifdef SVT_CHI_ISSUE_D_ENABLE
     if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D && cfg.chi_node_type == svt_chi_node_configuration::RN) {
       if(order_type != REQ_ORDERING_REQUIRED) {
         exp_comp_ack == 1'b0; 
       } 
     } else
     {exp_comp_ack == 1'b0;}
   `else
     exp_comp_ack == 1'b0;
   `endif
   }
   `ifdef SVT_CHI_ISSUE_E_ENABLE
   else if (`SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO) {
     if(order_type != REQ_ORDERING_REQUIRED) {
       exp_comp_ack == 1'b0; 
     }
   }
   `endif
   `ifdef SVT_CHI_ISSUE_D_ENABLE
   else if(xact_type == CLEANSHAREDPERSISTSEP) {
     exp_comp_ack == 1'b0;
   }
   `endif

     // All BEs must be set for WRITENOSNPFULL,WRITEUNIQUEFULL,WRITEBACKFULL,WRITECLEANFULL, 
     // WRITEEVICTFULL, WRITENOSNPFULL_CMO,WRITEUNIQUEFULL_CMO,WRITEBACKFULL_CMO and WRITECLEANFULL_CMO transaction types.
     if((xact_type == WRITENOSNPFULL) || 
        (xact_type == WRITEUNIQUEFULL) || 
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        (xact_type == WRITEUNIQUEFULLSTASH) || 
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == WRITEEVICTOREVICT) || 
        `SVT_CHI_IS_FULL_CACHELINE_COMBINED_NCBWRITE_CMO || 
        `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
        `endif
        (xact_type == WRITEBACKFULL) || 
        (xact_type == WRITECLEANFULL) || 
        (xact_type == WRITEEVICTFULL))
     {
      byte_enable == ((1 << `SVT_CHI_MAX_BE_WIDTH)-1);
     } 
     else if(xact_type == DVMOP) {
      byte_enable == 'hff;
     }

   // The req_order_stream_id should be in the range [0:(cfg.num_req_order_streams-1)].
   req_order_stream_id inside { [0:(cfg.num_req_order_streams -1)] };

   solve data_size before dat_rsvdc,data_resp_err_status,txdatflitpend_delay,txdatflitv_delay,rxdatlcrdv_delay;
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     solve data_size before atomic_write_dat_rsvdc, atomic_write_data_resp_err_status;
   `endif
                                          
   if (
        (xact_type == WRITEBACKFULL) ||
        (xact_type == WRITEBACKPTL) ||
        (xact_type == WRITECLEANFULL) ||
        (xact_type == WRITECLEANPTL) ||
        (xact_type == WRITENOSNPFULL) ||
        (xact_type == WRITENOSNPPTL) ||
        (xact_type == WRITEUNIQUEFULL) ||
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        (xact_type == WRITEUNIQUEFULLSTASH) || 
        (xact_type == WRITEUNIQUEPTLSTASH) || 
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
        (xact_type == WRITEEVICTOREVICT) || 
        `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
        `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || 
        `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
        `endif
        (xact_type == WRITEUNIQUEPTL) ||
        (xact_type == WRITEEVICTFULL) ||
        (xact_type == DVMOP) 
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
       txdatflitpend_delay.size() == ((1 << data_size)/(cfg.flit_data_width/8));
       txdatflitv_delay.size() == ((1 << data_size)/(cfg.flit_data_width/8));
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
       txdatflitpend_delay.size() == 1;
       txdatflitv_delay.size() == 1;
       rxdatlcrdv_delay.size() == 1;
     }

   }
   else
   {
     dat_rsvdc.size() == 0;
     data_resp_err_status.size() == 0;
     txdatflitpend_delay.size() == 0;
     txdatflitv_delay.size() == 0;
     rxdatlcrdv_delay.size() == 0;
   }

   //response_resp_err_status is a read only field and is populated by RN, therefore we have added 
   //a constraint that user didnot modify.
   if (
        (xact_type == READNOSNP) ||
        (xact_type == READONCE) ||
        (xact_type == READCLEAN) ||
        (xact_type == READSHARED) ||
        `ifdef SVT_CHI_ISSUE_B_ENABLE
        (xact_type == READNOTSHAREDDIRTY) ||
        (xact_type == READSPEC) || 
        (xact_type == READONCECLEANINVALID) ||
        (xact_type == READONCEMAKEINVALID) || 
        (xact_type == CLEANSHAREDPERSIST) || 
        (xact_type == ATOMICSTORE_ADD) ||
        (xact_type == ATOMICSTORE_CLR) ||
        (xact_type == ATOMICSTORE_EOR) ||
        (xact_type == ATOMICSTORE_SET) ||
        (xact_type == ATOMICSTORE_SMAX) ||
        (xact_type == ATOMICSTORE_SMIN) ||
        (xact_type == ATOMICSTORE_UMAX) ||
        (xact_type == ATOMICSTORE_UMIN) ||
        (xact_type == ATOMICLOAD_ADD) ||
        (xact_type == ATOMICLOAD_CLR) ||
        (xact_type == ATOMICLOAD_EOR) ||
        (xact_type == ATOMICLOAD_SET) ||
        (xact_type == ATOMICLOAD_SMAX) ||
        (xact_type == ATOMICLOAD_SMIN) ||
        (xact_type == ATOMICLOAD_UMAX) ||
        (xact_type == ATOMICLOAD_UMIN) ||
        (xact_type == ATOMICSWAP) ||
        (xact_type == ATOMICCOMPARE) ||
        (xact_type == PREFETCHTGT) ||
        (xact_type == WRITEUNIQUEFULLSTASH) ||
        (xact_type == WRITEUNIQUEPTLSTASH) ||
        (xact_type == STASHONCEUNIQUE) ||
        (xact_type == STASHONCESHARED) ||
        `endif
        (xact_type == READUNIQUE) ||
        (xact_type == CLEANUNIQUE) ||
        `ifdef SVT_CHI_ISSUE_D_ENABLE
        (xact_type == CLEANSHAREDPERSISTSEP) ||
        `endif
        `ifdef SVT_CHI_ISSUE_E_ENABLE
         (xact_type == MAKEREADUNIQUE) ||
         (xact_type == READPREFERUNIQUE) ||
         (xact_type == WRITEEVICTOREVICT) ||
         (xact_type == WRITEUNIQUEZERO) ||
         (xact_type == WRITENOSNPZERO) ||
         `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
         `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || 
         `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
         (xact_type == STASHONCESEPUNIQUE) ||
         (xact_type == STASHONCESEPSHARED) ||
        `endif
        (xact_type == CLEANSHARED) ||
        (xact_type == CLEANINVALID) ||
        (xact_type == MAKEINVALID) ||
        (xact_type == MAKEUNIQUE) || 
        (xact_type == WRITENOSNPFULL) ||
        (xact_type == WRITENOSNPPTL) ||
        (xact_type == WRITEUNIQUEFULL) ||
        (xact_type == WRITEUNIQUEPTL) ||
        (xact_type == WRITEBACKFULL) ||
        (xact_type == WRITEBACKPTL) ||
        (xact_type == WRITECLEANFULL) ||
        (xact_type == WRITECLEANPTL) ||
        (xact_type == EVICT) ||
        (xact_type == EOBARRIER) ||
        (xact_type == ECBARRIER) ||
        (xact_type == WRITEEVICTFULL)
      )
   {
     response_resp_err_status == NORMAL_OKAY;
   }

      if (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B
          `ifdef SVT_CHI_ISSUE_B_ENABLE
           && xact_type == svt_chi_transaction::PREFETCHTGT
          `endif
         ) 
      {
          dbid == 0;
      }

      if (cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B
          `ifdef SVT_CHI_ISSUE_B_ENABLE
           && xact_type == svt_chi_transaction::PREFETCHTGT
          `endif
         ) 
      {
          final_state == I;
      }

   // data_resp_err_status from RN for the below transaction types should only be
   // NORMAL OKAY or DATA_ERROR.
   if (
     (xact_type == WRITEBACKFULL) ||
     (xact_type == WRITEBACKPTL) ||
     (xact_type == WRITECLEANFULL) ||
     (xact_type == WRITECLEANPTL) ||
     (xact_type == WRITENOSNPFULL) ||
     (xact_type == WRITENOSNPPTL) ||
     (xact_type == WRITEUNIQUEFULL) ||
     `ifdef SVT_CHI_ISSUE_B_ENABLE
     (xact_type == WRITEUNIQUEFULLSTASH) ||
     (xact_type == WRITEUNIQUEPTLSTASH) ||
     `endif
     `ifdef SVT_CHI_ISSUE_E_ENABLE
     (xact_type == WRITEEVICTOREVICT) ||
     `SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || 
     `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || 
     `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
     `endif
     (xact_type == WRITEUNIQUEPTL) ||
     (xact_type == WRITEEVICTFULL)
   ){
     foreach (data_resp_err_status[index]){
       data_resp_err_status[index] inside {NORMAL_OKAY,DATA_ERROR}; 
     }
   }

   // data_resp_err_status from RN for the DVMOP transaction should only be
   // NORMAL OKAY in CHI_SPEC_REVISION_A and can take NORMAL_OKAY OR
   // DATA_ERROR in CHI_SPEC_REVISION_B.
   `ifdef SVT_CHI_ISSUE_B_ENABLE
   if(cfg.chi_spec_revision>=svt_chi_node_configuration::ISSUE_B) {
     if (xact_type == DVMOP)
     {
       foreach (data_resp_err_status[index]){
         data_resp_err_status[index] inside {NORMAL_OKAY,DATA_ERROR}; 
       }
     }
   }
   else {
     if (xact_type == DVMOP)
     {
       foreach (data_resp_err_status[index]){
         data_resp_err_status[index] == NORMAL_OKAY; 
       }
     }
   }
   `else
   if (xact_type == DVMOP)
   {
     foreach (data_resp_err_status[index]){
       data_resp_err_status[index] == NORMAL_OKAY; 
     }
   }
   `endif



   `ifdef SVT_CHI_ISSUE_B_ENABLE
   if (
       (xact_type == ATOMICSTORE_ADD) ||
       (xact_type == ATOMICSTORE_CLR) ||
       (xact_type == ATOMICSTORE_EOR) ||
       (xact_type == ATOMICSTORE_SET) ||
       (xact_type == ATOMICSTORE_SMAX) ||
       (xact_type == ATOMICSTORE_SMIN) ||
       (xact_type == ATOMICSTORE_UMAX) ||
       (xact_type == ATOMICSTORE_UMIN) ||
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
   ){
     if ((1 << data_size)/(cfg.flit_data_width/8))
     {
       if (cfg.dat_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT) 
       {
          atomic_write_dat_rsvdc.size() == 0; 
       }
       else 
       {
          atomic_write_dat_rsvdc.size() == ((1 << data_size)/(cfg.flit_data_width/8));
       }
       atomic_write_data_resp_err_status.size() == ((1 << data_size)/(cfg.flit_data_width/8));
     }
     else
     {
       if (cfg.dat_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT) 
       {
          atomic_write_dat_rsvdc.size() == 0; 
       }
       else 
       {
          atomic_write_dat_rsvdc.size() == 1;
       }
       atomic_write_data_resp_err_status.size() == 1;
     }
     foreach (atomic_write_data_resp_err_status[index]){
       atomic_write_data_resp_err_status[index] inside {NORMAL_OKAY,DATA_ERROR}; 
     }
   }
   else {
       atomic_write_dat_rsvdc.size() == 0;
       atomic_write_data_resp_err_status.size() == 0;
   }
   `endif

   `ifdef SVT_CHI_ISSUE_E_ENABLE
     if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.cleansharedpersistsep_xact_enable == 0) {
        !(xact_type inside {WRITENOSNPFULL_CLEANSHAREDPERSISTSEP, WRITENOSNPPTL_CLEANSHAREDPERSISTSEP, WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP, WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP, WRITEBACKFULL_CLEANSHAREDPERSISTSEP, WRITECLEANFULL_CLEANSHAREDPERSISTSEP});
      }
   `endif

   if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B) {
     xact_type != WRITECLEANPTL;
   }

   `ifdef SVT_CHI_ISSUE_D_ENABLE
     if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) {
       if(cfg.cleansharedpersistsep_xact_enable == 0) {
         xact_type != CLEANSHAREDPERSISTSEP;
       }
     }

      if(xact_type != CLEANSHAREDPERSIST && xact_type != CLEANSHAREDPERSISTSEP
         `ifdef SVT_CHI_ISSUE_E_ENABLE
           && (!`SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO)  
           && (!`SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO)  
           && (!`SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO)  
         `endif
        ) {
        deep == 0; 
      }
      
   `endif

   // transfer_length should be set to 0, in case of modes where it is not
   // applicable i.e when svt_chi_node_configuration::transfer_length_based_data_gen_enable
   // is set to 0 or svt_chi_node_configuration::wysiwyg_enable is set to
   // 1.
   if (cfg.data_format == svt_chi_node_configuration::STANDARD_DATA_FORMAT)
   {
     transfer_length == 0;
   }
   
   // Generate data_size in case of non-power-of-2 bytes transfer.
   // This will be only applicable in case of right aligned data
   // i.e svt_chi_node_configuration::wysiwyg_enable set to 0. Also 
   // transfer_length_based_data_gen_enable field should be set to 1.
   if (cfg.data_format == svt_chi_node_configuration::HYBRID_DATA_FORMAT) 
   {
     // Constraint transfer length to valid values.
     (transfer_length > 0) && (transfer_length <= 64);

     if (
       (xact_type == WRITENOSNPPTL) ||
       `ifdef SVT_CHI_ISSUE_B_ENABLE
       (xact_type == WRITEUNIQUEPTLSTASH) ||
       `endif
       (xact_type == WRITEUNIQUEPTL)
     )
     {
       transfer_length <= (1 << data_size);
     } else {
       // Valid value of Data Size are
       // ReqLinkFlit                            - Any value (Dont care)
       // PCrdReturn,EOBarrier, ECBarrier        - Inapplicable - must be set to ZERO
       // DVMOp                                  - 8 Bytes
       // ReadNoSnp, WriteNoSnp and WriteUnique  - Any value
       // For rest of Request VC messages        - 64 Bytes
       if ((xact_type == PCRDRETURN) || (xact_type == EOBARRIER) || (xact_type == ECBARRIER))
       {
         transfer_length == 1;
       }
       else if (xact_type == DVMOP)
       {
         transfer_length == 8;
       }
       else if((xact_type != READNOSNP) && 
               (xact_type != WRITENOSNPPTL) && 
               (xact_type != WRITEUNIQUEPTL) && 
               `ifdef SVT_CHI_ISSUE_B_ENABLE
               (xact_type != WRITEUNIQUEPTLSTASH) &&
               `endif
               (xact_type != REQLINKFLIT)
              ) 
       {
         transfer_length == 64;
       }
     }
   }
   //CHI-A or later,For WriteUnique* transactions order_type REQ_EP_ORDERING_REQUIRED is not permitted.
   if(
      (xact_type == WRITEUNIQUEFULL) ||
      `ifdef SVT_CHI_ISSUE_B_ENABLE
      (xact_type == WRITEUNIQUEFULLSTASH) ||
      (xact_type == WRITEUNIQUEPTLSTASH) ||
      `endif
      `ifdef SVT_CHI_ISSUE_E_ENABLE
      (xact_type == WRITEUNIQUEZERO) ||
      `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || 
      `endif
      (xact_type == WRITEUNIQUEPTL))
   {
     order_type != REQ_EP_ORDERING_REQUIRED; 
   }
  }

  constraint valid_address_for_dvm_operation_xact {
   // Constraints related to addr field for DVM Operation.
   if (xact_type == DVMOP) {
     // addr[3:0] are reserved and should be zero for DVM.
     addr[3:0] == 4'b0;

     // The values 3'b101-3'b111 on DVM message type field in DVM Request
     // Payload  is reserved.
     addr[13:11] inside  {[3'b000:3'b100]};
     addr[10:9] inside  {[2'b00:2'b11]};
     addr[39:38] inside  {[2'b00:2'b11]};
     addr[8:7] inside  {2'b00,2'b10,2'b11};
     addr[6] inside  {1'b0,1'b1};
     addr[5] inside  {1'b0,1'b1};
     addr[4] inside  {1'b0,1'b1};
     addr[40] inside  {1'b0,1'b1};

     /** TLB constraints */
     //TLB Invalidate not supported operations. 
     if (addr[13:11] == 3'b000) {
       // Guest OS/Hypervisor = Both not supported.
       addr[10:9] inside  {[2'b01:2'b11]};

       // NS/S = Both not supported.
       if(addr[10:9] == 2'b10){
         `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
             addr[8:7] inside  {2'b10,2'b11,2'b01};
           }
           else {
             addr[8:7] inside  {2'b10,2'b11};
           }
         `else
           addr[8:7] inside  {2'b10,2'b11};
         `endif
       }  
       // Hypervisor TLB Invalidate should be NON-SECURE only.
       else if(addr[10:9] == 2'b11){
         `ifdef SVT_CHI_ISSUE_E_ENABLE
           if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
             addr[8:7] inside  {2'b10,2'b11};
           }
           else {
            addr[8:7] == 2'b11;
           }
         `else
           addr[8:7] == 2'b11;
         `endif
       }
       // EL3 TLB Invalidate should be SECURE only.
       else if(addr[10:9] == 2'b01){
         addr[8:7] == 2'b10;
       }  
     }

     if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b10)) {
       `ifdef SVT_CHI_ISSUE_E_ENABLE
         if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
           addr[6:4] inside {3'b000,3'b001,3'b100,3'b101,3'b010,3'b110,3'b011,3'b111};
           if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101) && (addr[6:4] != 3'b011) && (addr[6:4] != 3'b111)){
             addr[40] == 1'b0;
           }  
           if((addr[6:4] != 3'b011)){
             addr[39:38] == 2'b00;
           }
           else {
             addr[39:38] inside {2'b00,2'b10};
           }
         }
         else {
           addr[6:4] inside {3'b000,3'b001,3'b100,3'b101};
           if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101)){
             addr[40] == 1'b0;
           }  
           addr[39:38] == 2'b00;
         }
       `else
         addr[6:4] inside {3'b000,3'b001,3'b100,3'b101};
         if((addr[6:4] != 3'b001) && (addr[6:4] != 3'b101)){
           addr[40] == 1'b0;
         }  
         addr[39:38] == 2'b00;
       `endif
     }
     `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
         if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b01)) {
           addr[6:4] == 3'b011;
           addr[39:38] == 2'b10;
         }
       }
     `endif

     if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b11) && (addr[8:7] == 2'b11)) {
       `ifdef SVT_CHI_ISSUE_B_ENABLE
         if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_1){
           addr[6:4] inside {3'b000,3'b001,3'b100,3'b101}; 
         }
         else {
           addr[6:4] inside {3'b000,3'b001}; 
         }
       `else
         addr[6:4] inside {3'b000,3'b001}; 
       `endif
       if(addr[6:4] == 3'b000 
         `ifdef SVT_CHI_ISSUE_B_ENABLE
          || addr[6:4] == 3'b100
         `endif
         ){
         addr[40] == 1'b0;
       }
       addr[39:38] == 2'b00;
     }
     `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
         if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b11) && (addr[8:7] == 2'b10)) {
           addr[6:4] inside {3'b000,3'b101,3'b001,3'b100}; 
           if(addr[6:4] == 3'b000 || addr[6:4] == 3'b100) {
             addr[40] == 1'b0;
           }
           addr[39:38] == 2'b00;
         }
       }
     `endif

     if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b01) && (addr[8:7] == 2'b10)) {
       addr[6:4] inside {3'b000,3'b001};
       if(addr[6:4] != 3'b001){
         addr[40] == 1'b0;
       }
       addr[39:38] == 2'b00;
     }

     if ((addr[13:11] == 3'b000) && (addr[10:9] == 2'b10) && (addr[8:7] == 2'b11)) {
       addr[6:4] inside {3'b000,3'b010,3'b011,3'b110,3'b111};
       if((addr[6:4] != 3'b011) && (addr[6:4] != 3'b111)){
         addr[40] == 1'b0;
       }  

       if (addr[6:4] == 3'b010) {
         addr[39:38] inside {2'b00, 2'b01};
       }
       else if (addr[6:4] == 3'b011){
         addr[39:38] inside {2'b00, 2'b10};
         addr[40] inside {1'b0,1'b1};
       }  
       else {
         addr[39:38] == 2'b00;
       }
     }

     // Branch Predictor Invalidate applies to all Guest OS and Hypervisor,
     // applies to Secure and Non-Secure. 
     if (addr[13:11] == 3'b001) {
       addr[40] == 1'b0;
       addr[39:38] == 2'b00;
       addr[10:9] == 2'b00;
       addr[8:7] == 2'b00;
       //ASID,VMID valid field restrictions.
       addr[6] == 1'b0;
       addr[5] == 1'b0;
     }

     /** Phy Icache Invalidate constraints */
     // Phy Icache Invalidate applies to all Guest OS and Hypervisor.
     if (addr[13:11] == 3'b010) {
       addr[40] == 1'b0;
       addr[39:38] == 2'b00;
       addr[10:9] == 2'b00;
       addr[8:7] inside  {2'b10,2'b11};
       addr[6:4] inside  {3'b000,3'b001,3'b111};
     }

     /** Virtual Icache Invalidate constraints */
     // Virtual Icache Invalidate applies to all Guest OS and Hypervisor.
     if (addr[13:11] == 3'b011) {
       addr[40] == 1'b0;
       addr[39:38] == 2'b00;
       addr[10:9] inside  {2'b00,2'b10,2'b11};

       if(addr[10:9] == 2'b00){
         addr[8:4] inside  {5'b00000,5'b11000};
       }  
       else if(addr[10:9] == 2'b10){
           `ifdef SVT_CHI_ISSUE_E_ENABLE
             if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_4) {
               addr[8:4] inside {5'b10101,5'b10010,5'b10111,5'b11010,5'b11111};
             }
             else {
               addr[8:4] inside  {5'b10101,5'b11010,5'b11111};
             }
           `else
             addr[8:4] inside  {5'b10101,5'b11010,5'b11111};
           `endif
       }
       else {
         `ifdef SVT_CHI_ISSUE_B_ENABLE
           if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_B && cfg.dvm_version_support >= svt_chi_node_configuration::DVM_v8_1) {
             addr[8:4] inside {5'b11001, 5'b11101};
           }
           else {
             addr[8:4] inside {5'b11001};
           }
         `else
           addr[8:4] inside {5'b11001};
         `endif
       } 
     }

     /**  DVM Sync operation constraints */
     // DVM Sync operation applies to all Guest OS and Hypervisor,
     // applies to Secure and Non-Secure. 
     if (addr[13:11] == 3'b100) {
       addr[40] == 1'b0;
       addr[39:38] == 2'b00;
       addr[10:9] == 2'b00;
       addr[8:7] == 2'b00;
       addr[5] == 1'b0;
       addr[6] == 1'b0;
       addr[4] == 1'b0;
     }
     `ifdef SVT_CHI_ISSUE_E_ENABLE
       if(cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_E || cfg.dvm_version_support < svt_chi_node_configuration::DVM_v8_4) {
         dvm_range == 0;
       }
       else if (addr[13:11] != 3'b000 ||  addr[4] != 1'b1) {
         dvm_range == 0;
       }
       if(dvm_range == 0) {
         dvm_scale == 0;
         dvm_num == 0;
         if(addr[4] == 0 || addr[13:11] != 3'b0) {
           dvm_ttl == 0;
           dvm_tg == 0;
         }
         else {
           if(dvm_tg == 2'b00) {
             dvm_ttl == 0;
           }
         }
       } 
       else {
         dvm_tg inside {2'b01, 2'b10, 2'b11};
         if(dvm_tg == 2'b10) {
           data[11:10] == 0;
         }
         else if (dvm_tg == 2'b11) {
           data[13:10] == 0;
         }
       }
     `endif
   }
  }

  /** In case of CHI Issue-A spec, retried transaction must have same value for req_rsvdc 
   *  as that of original transaction that received retry response 
   */
  constraint valid_ranges_is_retried_with_original_rsvdc {
    if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A)
      is_retried_with_original_rsvdc == 1;                          
  }
  
  /** For random src_id case, this should not be equal to SN[0] node ID */
  constraint valid_ranges_random_src_id {
    if (cfg.random_src_id_enable) (src_id != cfg.sys_cfg.sn_cfg[0].node_id);
  }
  
`ifdef SVT_CHI_ISSUE_D_ENABLE
  /** If valid_return_nid_in_cspsep_from_rn_to_sn_enable is set to 1, then return_nid should not be equal to SN[0] node ID */
  constraint valid_ranges_return_nid {
    if(xact_type == CLEANSHAREDPERSISTSEP){
      if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D && cfg.cleansharedpersistsep_xact_enable == 1 ){
        if(cfg.valid_return_nid_in_cspsep_from_rn_to_sn_enable ==1 )
          return_nid != cfg.sys_cfg.sn_cfg[0].node_id;
      }
     else if(cfg.chi_node_type == svt_chi_node_configuration::RN) {
       return_nid == 0;
     }
   }
 }

 /** Constraining all the MPAM fields. */
  constraint reasonable_mpam_ranges {
    if(cfg.enable_mpam == 0) {
     mpam_perfmongroup == 0;
     mpam_partid == 0;
     mpam_ns == 0;
    }
    else { //if enable_mpam=1
      if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_D) {
        if((xact_type == PCRDRETURN) || (xact_type == DVMOP)){
          mpam_ns == 0;
          mpam_partid == 0 ;
          mpam_perfmongroup == 0 ;
        }
        else {
          (is_non_secure_access ==0) -> (mpam_ns ==0);
        }
      }
      else { // if chi_spec_revision < ISSUE_D
        mpam_perfmongroup == 0;
        mpam_partid == 0;
        mpam_ns == 0;
      }
    }
  }

`endif //issue_d_enable
`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** constrained slcrephint_reserved to zero as these are reserved bits in SLCRepHint field */    
  constraint valid_slcrephint_ranges {     
     slcrephint_reserved == 0;  
     if (cfg.slcrephint_mode ==svt_chi_node_configuration::SLC_REP_HINT_DISABLED) {
        slcrephint_replacement == 0;
        slcrephint_unusedprefetch == 0;
     }
     else if (cfg.slcrephint_mode ==svt_chi_node_configuration::SLC_REP_HINT_SPEC_RECOMMENDED) {
        slcrephint_replacement inside {3'b000,3'b100,3'b101,3'b110,3'b111};
     }
  }     
`endif

  
  /** Establish the valid ranges constraints on hn_node_idx based on xact_type */
  constraint chi_rn_transaction_valid_node_idx_cst
  {
     if (
          (xact_type == svt_chi_rn_transaction::READONCE) ||
          (xact_type == svt_chi_rn_transaction::READCLEAN) ||
          (xact_type == svt_chi_rn_transaction::READSHARED) ||
          (xact_type == svt_chi_rn_transaction::READUNIQUE) ||
          `ifdef SVT_CHI_ISSUE_B_ENABLE
          (xact_type == svt_chi_rn_transaction::READSPEC) ||
          (xact_type == svt_chi_rn_transaction::READNOTSHAREDDIRTY) ||
          (xact_type == svt_chi_rn_transaction::READONCECLEANINVALID) ||
          (xact_type == svt_chi_rn_transaction::READONCEMAKEINVALID) ||
          (xact_type == svt_chi_rn_transaction::CLEANSHAREDPERSIST) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_ADD) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_CLR) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_EOR) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_SET) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_SMAX) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_SMIN) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_UMAX) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSTORE_UMIN) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_ADD) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_CLR) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_EOR) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_SET) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_SMAX) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_SMIN) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_UMAX) ||
          (xact_type == svt_chi_rn_transaction::ATOMICLOAD_UMIN) ||
          (xact_type == svt_chi_rn_transaction::ATOMICSWAP) ||
          (xact_type == svt_chi_rn_transaction::ATOMICCOMPARE) ||
          (xact_type == svt_chi_rn_transaction::WRITEUNIQUEFULLSTASH) ||
          (xact_type == svt_chi_rn_transaction::WRITEUNIQUEPTLSTASH) ||
          (xact_type == svt_chi_rn_transaction::STASHONCEUNIQUE) ||
          (xact_type == svt_chi_rn_transaction::STASHONCESHARED) ||
          `endif
          (//cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A &&
           (xact_type == svt_chi_rn_transaction::MAKEINVALID) ||
           (xact_type == svt_chi_rn_transaction::CLEANINVALID) ||
           (xact_type == svt_chi_rn_transaction::CLEANSHARED)
          ) ||
          (xact_type == svt_chi_rn_transaction::MAKEUNIQUE) ||
          (xact_type == svt_chi_rn_transaction::CLEANUNIQUE) ||
          `ifdef SVT_CHI_ISSUE_E_ENABLE
            (xact_type == svt_chi_rn_transaction::MAKEREADUNIQUE) ||
            (xact_type == svt_chi_rn_transaction::READPREFERUNIQUE) ||
            (xact_type == svt_chi_rn_transaction::STASHONCESEPUNIQUE) ||
            (xact_type == svt_chi_rn_transaction::STASHONCESEPSHARED) ||
          `endif
          `ifdef SVT_CHI_ISSUE_D_ENABLE
          (xact_type == svt_chi_rn_transaction::CLEANSHAREDPERSISTSEP) ||
          `endif
          (xact_type == svt_chi_rn_transaction::WRITEBACKFULL) ||
          (xact_type == svt_chi_rn_transaction::WRITEBACKPTL) ||
          (xact_type == svt_chi_rn_transaction::WRITECLEANFULL) ||
          (xact_type == svt_chi_rn_transaction::WRITECLEANPTL) ||
          (xact_type == svt_chi_rn_transaction::EVICT) ||
          (xact_type == svt_chi_rn_transaction::WRITEEVICTFULL) ||
          `ifdef SVT_CHI_ISSUE_E_ENABLE
          (xact_type == svt_chi_rn_transaction::WRITEEVICTOREVICT) ||
          (xact_type == svt_chi_rn_transaction::WRITEUNIQUEZERO) ||
          `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO || 
          `SVT_CHI_IS_COHERENT_COMBINED_CBWRITE_CMO || 
          `endif
          (xact_type == svt_chi_rn_transaction::WRITEUNIQUEFULL) ||
          (xact_type == svt_chi_rn_transaction::WRITEUNIQUEPTL)
        )
     {
        if (cfg.hn_f_node_indices.size()) hn_node_idx inside {cfg.hn_f_node_indices};
     }
     else
     {
        if (
            !((xact_type == svt_chi_rn_transaction::EOBARRIER) ||
                 (xact_type == svt_chi_rn_transaction::EOBARRIER) ||
                 (xact_type == svt_chi_rn_transaction::DVMOP))
           )
        {
           if (cfg.hn_i_node_indices.size() || cfg.hn_f_node_indices.size()) hn_node_idx inside {cfg.hn_i_node_indices, cfg.hn_f_node_indices};
        }
     }
  }

    
  /** 
   * Exclusive response will be set by the SN agent's exclusive monitor or the
   * CHI Interconnect's exclusive monitor (PoC monitor). So, in general, don't
   * randomly generate EXCLUSIVE_OKAY response. 
   */
  constraint chi_rn_transaction_limitation_list
  {
    response_resp_err_status != EXCLUSIVE_OKAY;

    foreach (data_resp_err_status[index]){
      data_resp_err_status[index] != EXCLUSIVE_OKAY;
    }
  }

  /** @cond PRIVATE */    
  /**
   * Reasonable constraints are designed to limit the traffic to "protocol legal" traffic,
   * and in some situations maximize the traffic flow. They must never be written such
   * that they exclude legal traffic.
   *
   * Reasonable constraints may be disabled during error injection. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint chi_reasonable_VARIABLE_NAME {
  }

   /**
    * Enforces domain based address generation
    */
  constraint reasonable_domain_based_addr_gen {
    if (
         (cfg.enable_domain_based_addr_gen) && 
         
         !(
           (xact_type == EOBARRIER) ||
           (xact_type == ECBARRIER) ||
           (xact_type == DVMOP) ||
           (xact_type == PCRDRETURN) 

         )
       ) 
       { // Randomizes a particular address ranges from any of Inner/Outer/Nonsnoopable domain address arrays
        if(cfg.nonsnoopable_start_addr.size() > 0)
           nonsnoopable_addr_range_index < cfg.nonsnoopable_start_addr.size();
        if(cfg.innersnoopable_start_addr.size() > 0)
           innersnoopable_addr_range_index < cfg.innersnoopable_start_addr.size();
       `ifndef SVT_CHI_ISSUE_B_ENABLE
        if(cfg.outersnoopable_start_addr.size() > 0)
           outersnoopable_addr_range_index < cfg.outersnoopable_start_addr.size();
       `endif 
        // constrain address based on mutual relationship of domain/snoop properties and its associated address ranges
         if(snp_attr_is_snoopable == 0) {
           foreach (cfg.nonsnoopable_start_addr[i]) {
             (nonsnoopable_addr_range_index == i) -> addr inside {[cfg.nonsnoopable_start_addr[i]:
                                                                   cfg.nonsnoopable_end_addr[i]]}; 
           }
         }
       `ifndef SVT_CHI_ISSUE_B_ENABLE
         if (( snp_attr_is_snoopable == 1) && (snp_attr_snp_domain_type == OUTER)) {
           foreach (cfg.outersnoopable_start_addr[i]) {
             (outersnoopable_addr_range_index == i) -> addr inside {[cfg.outersnoopable_start_addr[i]:
                                                                     cfg.outersnoopable_end_addr[i]]}; 
           }
         }
       `endif 
       `ifndef SVT_CHI_ISSUE_B_ENABLE
         if ((snp_attr_is_snoopable == 1) && (snp_attr_snp_domain_type == INNER)) {
        `else
         if (snp_attr_is_snoopable == 1) {
       `endif
           foreach (cfg.innersnoopable_start_addr[i]) {
             (innersnoopable_addr_range_index == i) -> addr inside {[cfg.innersnoopable_start_addr[i]:
                                                                     cfg.innersnoopable_end_addr[i]]}; 
           }
         }
    } //enable_domain_based_addr_gen
  } // ends

  /** @endcond */
    
  /** This constraint is applicable for CHI Version 5.0. 
   *  The exp_comp_ack field is optional for the following cases:
   *  - ReadNoSnp in case of RN-F/RN-I/RN-D
   *  - ReadOnce, CleanShared, CleanInvalid, MakeInvalid in case of RN-I/RN-D
   *  .
   *  This constraint forces the exp_comp_ack to a value that is still legal, but is:
   *  - one for RN-F in case of ReadNoSnp
   *  - zero for RN-I/RN-D in case of ReadNoSnp, ReadOnce, CleanShared, ClanInvalid, MakeINvalid
   *  .
   */
  constraint chi_reasonable_exp_comp_ack {
    if (cfg.sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0)
    {
      if (cfg.chi_interface_type == svt_chi_node_configuration::RN_F)
      {
        if (xact_type == READNOSNP)
          { exp_comp_ack == 1'b1;}
      }
      else
      {
        if ((xact_type == READNOSNP) ||
            (xact_type == READONCE) || 
            `ifdef SVT_CHI_ISSUE_B_ENABLE
            (xact_type == CLEANSHAREDPERSIST) || 
            `endif
            `ifdef SVT_CHI_ISSUE_D_ENABLE
            (xact_type == CLEANSHAREDPERSISTSEP) ||
            `endif
            (xact_type == CLEANSHARED) || 
            (xact_type == CLEANINVALID) || 
            (xact_type == MAKEINVALID))
          { exp_comp_ack == 1'b0;}
       }
    }
  }

 `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint is_writedatacancel_valid {
    if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_A)
    {
       is_writedatacancel_used_for_write_xact == 1'b0;
    }
    else
    {
        if (((xact_type == WRITENOSNPPTL) && (mem_attr_mem_type == DEVICE)) ||
            `ifdef SVT_CHI_ISSUE_E_ENABLE
            ((xact_type == WRITENOSNPPTL_CLEANSHARED || xact_type == WRITENOSNPPTL_CLEANSHAREDPERSISTSEP || xact_type == WRITENOSNPPTL_CLEANINVALID) && (mem_attr_mem_type == DEVICE)) ||
            `endif
            ((xact_type != WRITENOSNPPTL) && 
             (xact_type != WRITEUNIQUEPTL) &&
             `ifdef SVT_CHI_ISSUE_E_ENABLE
             (xact_type != WRITENOSNPPTL_CLEANSHARED) &&
             (xact_type != WRITENOSNPPTL_CLEANSHAREDPERSISTSEP) &&
             (xact_type != WRITENOSNPPTL_CLEANINVALID) &&
             (xact_type != WRITEUNIQUEPTL_CLEANSHARED) &&
             (xact_type != WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP) &&
             `endif
             (xact_type != WRITEUNIQUEPTLSTASH)
            )
           ){
          is_writedatacancel_used_for_write_xact == 1'b0;
        }
    }
  }

  /** Constraing Posion to zero as will be no data transfer for these transactions */
  constraint reasonable_poison_for_makeunique_cleanunique {
    if((xact_type == MAKEUNIQUE) || (xact_type == CLEANUNIQUE)){
      poison == 0;
    }  
  }
  
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    /** For MakeReadUnique transactions, makereadunique_read_poison indicates the poison received in the data response, if any.
        poison indicates the value of the poison that must be programmed in the requester cache in case allocate_in_cache is set to 1 **/
    constraint reasonable_poison_for_makereadunique {
      if (xact_type == MAKEREADUNIQUE) {
        poison == 0;
      }
    }

    /** For MakeReadUnique and CleanUnique, when allocate_in_cache is set to 1, users can make use of the tag_update field
        to indicate if they want to program dirty tags in the cache along with data. If tag_update is set to 0, it means that the 
        user does not want to store any dirty tags in the cache at the end of the transaction. If tag_update is set to all 1s,
        it would mean that the user wants to program dirty tags at the end of the transaction, tag_update cannot be set to partial 1s as the spec
        does not permit partial tags to be stored in the cache. Also, tag_update must be set to all 0s in case the byte_enable field is
        programmed to partial 1s because tags are not permitted to be stored in the cache when cache state is partial dirty **/
    constraint allocate_in_cache_tags_for_cleanunique_makereadunique {
      if(xact_type == CLEANUNIQUE || 
         (xact_type == MAKEREADUNIQUE && req_tag_op == TAG_TRANSFER)
        ) {
        if(allocate_in_cache) {
          //If mem tagging is enabled at the CHI-E or greater RN
          if(cfg.chi_spec_revision >= svt_chi_node_configuration::ISSUE_E && cfg.mem_tagging_enable) {
            //If all the Byte Enable bits are asserted, ie, if the final cache state at the end of the transaction will be UD (and not UDP)
            if(byte_enable == {`SVT_CHI_MAX_BE_WIDTH{1'b1}}) {
              //tag_update should either be set to all 0s indicating tags should not be updated in the RN cache or 
              //all 1s indicating that the tags in the RN cache must be updated with the dirty tags programmed in the "xact.tag" field
              tag_update inside {{`SVT_CHI_MAX_TAG_UPDATE_WIDTH{1'b0}}, {`SVT_CHI_MAX_TAG_UPDATE_WIDTH{1'b1}}};
            }
            //If Byte Enable bits are not set to all 1s, the final cache state at the end of the transaction will be UDP
            //Therefore, tag_update must be set to all 0s to indicate that tags must not be updated into the RN cache.
            else { 
              tag == 0;
              tag_update == 0;
            }
          }
          //If memory tagging is not enabled at the RN, tag and tag_update must be set to all 0s
          else {
            tag == 0;
            tag_update == 0;
          }
        }
      }
    }
  `endif
  
  constraint valid_ranges_when_allow_dmt_from_rn_when_hn_is_absent_disabled {
    if (cfg.allow_dmt_from_rn_when_hn_is_absent) {
     `ifdef SVT_CHI_ISSUE_E_ENABLE
      /** Constraining the return_txn_id to be less than 1023 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is equal to ISSUE_D */
       if (cfg.chi_spec_revision == svt_chi_node_configuration::ISSUE_D) {
         return_txn_id inside {[0:1023]};
       }
      /** Constraining the return_txn_id to be less than 256 when macro SVT_CHI_ISSUE_E_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       else if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         return_txn_id inside {[0:255]};
       }
     `elsif SVT_CHI_ISSUE_D_ENABLE
      /** Constraining the return_txn_id to be less than 256 when macro SVT_CHI_ISSUE_D_ENABLE is defined and chi_spec_revision is less than ISSUE_D */
       if (cfg.chi_spec_revision <= svt_chi_node_configuration::ISSUE_C) {
         return_txn_id inside {[0:255]};
       }
     `endif
    }  
    
    /** For random return_nid case, this should not be equal to SN[0] node ID */
    if (cfg.allow_dmt_from_rn_when_hn_is_absent && xact_type == READNOSNP) {
      return_nid != cfg.sys_cfg.sn_cfg[0].node_id;
    }  
    
    `ifdef SVT_CHI_ISSUE_C_ENABLE
    if (cfg.allow_readnosnpsep_from_rn_when_hn_is_absent && xact_type == READNOSNPSEP && cfg.chi_node_type == svt_chi_node_configuration::RN) {
      return_nid != cfg.sys_cfg.sn_cfg[0].node_id;
      return_nid != src_id;
    }
    `endif
  }    

  /** Constraing Posion to zero when poison is not enabled */
  constraint poison_valid_ranges_when_poison_disabled {
    if(cfg.poison_enable == 0) {
      poison == 0;
      atomic_store_load_poison == 0;
      atomic_compare_poison == 0;
      atomic_swap_poison == 0;
    }  
  }    
 `endif

 `ifdef SVT_CHI_ISSUE_C_ENABLE
  constraint is_ncbwrdatacompack_valid {
    if (cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_C)
    {
       is_ncbwrdatacompack_used_for_write_xact == 1'b0;
    }
    else
    {
        if ((exp_comp_ack == 0) ||
            ((xact_type != WRITEUNIQUEFULL) && 
             (xact_type != WRITEUNIQUEPTL) &&
             `ifdef SVT_CHI_ISSUE_E_ENABLE
               (!(`SVT_CHI_IS_NON_COHERENT_COMBINED_NCBWRITE_CMO || `SVT_CHI_IS_COHERENT_COMBINED_NCBWRITE_CMO)) &&  
             `endif
             `ifdef SVT_CHI_ISSUE_D_ENABLE
               ((cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_D) ||
                ((xact_type != WRITENOSNPFULL) &&
                 (xact_type != WRITENOSNPPTL))
               ) &&
             `endif
             (xact_type != WRITEUNIQUEFULLSTASH) &&
             (xact_type != WRITEUNIQUEPTLSTASH)
            )){
          is_ncbwrdatacompack_used_for_write_xact == 1'b0;
        }
    }
  }
  
  constraint is_compack_after_all_compdata_valid {
    if (cfg.chi_spec_revision < svt_chi_node_configuration::ISSUE_C)
    {
       is_compack_after_all_compdata == 1'b1;
    }
    else
    {
          if(xact_type != READNOSNP &&
             xact_type != READONCE &&
             xact_type != READONCECLEANINVALID &&
             xact_type != READONCEMAKEINVALID &&
             xact_type != READCLEAN &&
             xact_type != READSHARED &&
             `ifdef SVT_CHI_ISSUE_E_ENABLE
             xact_type != MAKEREADUNIQUE &&
             `endif
             xact_type != READNOTSHAREDDIRTY &&
             `ifdef SVT_CHI_ISSUE_E_ENABLE
             xact_type != READPREFERUNIQUE &&
             `endif
             xact_type != READUNIQUE
            ) {
            is_compack_after_all_compdata == 1'b1;
          }
          else {
            if(cfg.sys_cfg.use_interconnect == 1) {
              is_compack_after_all_compdata == 1'b1;
            }
            `ifdef SVT_AMBA5_TEST_SUITE_VIP_DUT
              is_compack_after_all_compdata == 1'b1;
            `endif
          }
    }
  }

 `endif

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_transaction);
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
  extern function new(string name = "svt_chi_rn_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_transaction)

  `svt_data_member_end(svt_chi_rn_transaction)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * post_randomize does the following: Ensures that the byte_enable field is valid as per the CHI spec
   */
  extern function void post_randomize();

  /** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
   * pre randomize method
   * Check if the cfg handle is null
   */
  extern function void pre_randomize();
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_transaction.
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

  /** @endcond */
  // ---------------------------------------------------------------------------
  /**
   * Waits for the prerequisites for CompAck Flit to be transmitted for this transaction
   * from RN, when svt_chi_rn_transaction::exp_comp_ack is set to 1.<br>
   * Note that if the transaction type is not one of the transaction types mentioned below,
   * this task returns without waiting. <br>
   * Note that in case of receiving RETRY response, with p_crd_return_on_retry_ack set to 0,
   * the transaction will be resent; so this task continues to wait on the below mentioned
   * prerequisite conditions.
   * For a given transaction type, the prerequisite is to receive Flit(s) described below:
   * - ReadNoSnp: CompData
   * - ReadOnce: CompData
   * - ReadClean: CompData
   * - ReadShared: CompData
   * - ReadUnique: CompData
   * - CleanUnique: Comp
   * - MakeUnique: Comp
   * - CleanShared: Comp
   * - CleanInvalid: Comp
   * - MakeInvalid: Comp
   * - WriteUniqueFull: Comp/CompDBIDResp
   * - WriteUniquePtl: Comp/CompDBIDResp
   * .
   * While waiting on the prerequisite conditions, the task returns if any of the following conditions occur:
   * - Transaction is aborted due to protocol reset
   * - Transaction is dropped due to invalid initial cache line state 
   * - Transaction received RETRY response and the transaction will be cancelled without resend
   * .
   */
  extern virtual task wait_for_tx_compack_prereqs();

  /**
   * Waits for the prerequisites for Tx Data flit(s) to be transmitted for this transaction
   * from RN. <br>
   * Note that if the transaction type is not one of the transaction types mentioned below, 
   * this task returns without waiting. <br>
   * Note that in case of receiving RETRY response, with p_crd_return_on_retry_ack set to 0,
   * the transaction will be resent; so this task continues to wait on the below mentioned
   * prerequisite conditions.
   * For a given transaction type, the prerequisite is to receive the Flit(s) described below:
   * - WriteBackFull: CompDBIDResp
   * - WriteBackPtl: CompDBIDResp
   * - WriteCleanFull: CompDBIDResp
   * - WriteCleanPtl: CompDBIDResp
   * - WriteEvictFull: CompDBIDResp
   * - WriteUniqueFull: DBIDResp/CompDBIDResp
   * - WriteUniquePtl: DBIDResp/CompDBIDResp
   * - WriteNoSnpFull: DBIDResp/CompDBIDResp
   * - WriteNoSnpPtl: DBIDResp/CompDBIDResp
   * - DVMOp: DBIDResp
   * .
   * While waiting on the prerequisite conditions, the task returns if any of the following conditions occur:
   * - Transaction is aborted due to protocol reset
   * - Transaction is dropped due to invalid initial cache line state 
   * - Transaction received RETRY response and the transaction will be cancelled without resend
   * .
   */  
  extern virtual task wait_for_tx_data_prereqs();

  /** Indicates wheter the transaction is terminated prematurely. 
   *  Returns 1 in any of the following cases:
   *  - Transaction is dropped
   *  - Transaction is aborted
   *  - Transaction is cancelled
   *  - Transaction received RETRY but P-Credits will be returned
   *  .
   */
  extern virtual function bit is_terminated();
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_transaction)
  `vmm_class_factory(svt_chi_rn_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DnOb+um5+jy74nkBrZ5PF7tFv8XONVZR5waO5bHcR9MEtJvKl3c4kxnRHV/jxqV3
H8QczciRIV450aikMB14ZQrrL6Kf82UVFHay9IDtvtORRFWiAxSreLwG/8lgX24t
NJpEyh3pElWEAXSxzUIz0rd7R61wbmDM/j/BGGKTuYE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3866      )
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
`pragma protect end_protected
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HnrwG6sLk8v1efB45Q7QJlcy3pr7yWiuSRh4c7XRrz7LwEgQelQR2gVxFRppVYRk
FftO1K3ZqAU05DtzhdeNWxhI4izjJ769ecuq7aGen26obqilgFIz1YuuX3izJHo5
qWm0m/fKj4r8wM30FE6KspgOwZ0jqYzSnMK2yRi7BQs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4146      )
DpWkiS2FXVRRaXErq5oBgmtdKpHjKp+zEQY0FYuMN1QSv6WoqD5ZCwrF22NthAAt
S7/Xp36+eLfY3/fBNcdJdxc5NlhjCi5fnH7rQd1Wp8TBcvWx4KfnKlIPtnPMhAmQ
kAl/LkUGC19PSqDWKqsxj7Q4AgcpGGI7OREBJQdyvBxfCdxn7lpazaYngUbAeMwp
be7HurKeA7lODAexvsXjBnHjt3w8VaaBrZCUmj0njtfydOVVowtSR0R3AbrPc3gx
eXVE3Zhi2pvS4TcwnGLNKIR/tz7tyfeLX+JrKCRc/wTQazbRuV8HJOy4BqogtjTV
JIw7Fztv2t3XxHea9bYT2aHW9ZuV2kjk/bFWpNI34Qr/8aen274wzD9DuGOFEh6t
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XOJfsLQNu6VXPsZV33DfmYOyFXT4h0g/rjtKhaYjQN/m4EjHIc9BotCbudbSzlvS
s77JSVYW2afVttywKlGFe7PabVL+j8NtrY+ZaGaJlSfoFCmKpmqJAHmGK9n453Zj
JfSra9AsnYJKv3/1d8EpkaytBITf0HoBF9cJ7VC3y2s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6307      )
CkT172D3yNZdu+11Viy9oIyN7fvHkRldIoN8WdrF7NaQREoNBi+bdL87nqwJxjOE
eK4HfAL2bTYwhRHwT1PlQX2xtU2+xQwepZqo8Rv28ASj/mHvn4g7aM7ITY+XdIkh
mNCZImfQXqTwb/EjDJ0V0Wh8A4NG3TYl7pauWW59/YHl1IBe+qUl4ulBXrpG9CFz
+nlmonLFP1OwKMfetw/aucxDp8vc3MuMxscFVZ3U8PNLU2HjAZ12MFQNPqUEXwfB
oCW2MSFwysI00PKN5y9hniqrvz+6mHn42hPb43yMmYyhWa7Tf4uRKIh442VLUpqD
MxEq+BApwNNMp57Wslbtk/rkSBDsyjcuYRXR3hOQ0R5gdnLWJ6U/xhjbBhawHOTd
4Q4OjJXdQqYR/UG4lhAelXWcNbMch1iw8aLsBOSWIuYht5BpFnojB+BuulSkWHnc
XoAcHPhzg6+GE0ZV88vacuWfXfhR7d5A6jCg+shOJlseVpZPBzDJr6a43Y1tEHj4
m33/HE4lUF86qSc9NQiEPDAbHyxhI2VKmTVUD0dcq3aMaPMqc96t/XKGA5HeWTav
HjvkFz2fvQ05qwIgbOAfFSCMfTVQrO2Bv/ZybLcT16ISN1VLuoryaLHqKc6gD0XU
bkrb2EmtiKnPh1w4nhYI3/ePhgMatEvL4E/gJZoCqO8kuFR2yGqlS9h5Lp8dIa99
YiJvE3PaKNPTbU7KN/xhsMMSGXg1Xggc+B5UOqmOyZ5JkwJh5Y+MNZDZzZff68FP
Wo/lAWofCpMEpQnsylPRElMVmLhTA7vtIVJYtN9694Pgi84GAyHXJMj4KuoPCm9X
6QxKLKk4D4C8oqTyJg83uM5nIN/NKsZR7fwC8CWhFgweTsiOm6kEc277cl6KkuSQ
U5ERPeDdWxof9rZndth+f1s7ZJUCGmaH/fZ/1GZTcORqzWzz2RHf9VvY+GQyWEKO
gfBnxtZ7qdjy0hCFX7Z7XVitvn1+BQR7D1kNbqStnAT8TZ4i7uYPKNNQ5T04Ww66
QLi1077CFL2evYb0EYiyHVs0r/KNsjlP6LIfwpmuFxZ334/peXZhHLefRuY6DlPq
WCaPBCN0XpuEXgJi4Ujg5aYVLdF4hrMK/3A1u+VriSkkxfjqXNfAPLVOxK9fUWPW
5/PtIDQQ0DnlEiApBLeAWtND4TS787b6m5xruYpRNj6vEmkNvbd+rz7ZVt4HIg/y
gdVuyrwx7uR3L2q8v3+J3Mw15kCgUBLdvrYJ1/675YXcvJYSOzYgPHg38in1FJuV
czLATl1nt48zKLfhRH4le7lPjsBSeX4PFLeoeCABP1CFytOFzBNMgrhgoV4oojsU
boU2hsenOP1vnj4iGLTvfhMYU7xBkHmSLkJJ/wNud6kAw6sdoDb/tEPulbwmoEyo
tP298MrOlIXYjrbJh5Vh5OAPqCw89y3V6XFaxiiav/bc+ZPNIsLKIoozShbYvqUD
9HsHNSU5oPfHxKrzKBjYACKPpYQGhZJyrZ92sMP1Ah54rAfvJGpYrraJJhYks/sy
WCUbIbCk1rLDz+8OODK2zXeG+OOlDwO9vrW49YLIEvA/c2HmD98A7QhHk4dyb8m6
GaK6THwlh2TpM70Jiftelrjv9gzae265qtXJ6qbX7s+HPD7XY5gZinjd+52lzZKn
3+zQPpjxrzX8IUvry3emdvbLdXum+5eiRF+wzHwdAcGxnNW4aB9LEvaggRyOMsL1
nV4YQFn4k/blw1qDlMg8gqeOpuld25Oq1jl+d6MlqZNapf7euA9KKjUWDT44QNe8
LD50KpMHNi0jOm+bTBMeIDnPqWeWRwirUqx6zvLU801xcTJweS0lAzyIBe4/6Bia
ueqnXsYE/fZzRvAaIfDkOwVqh9DCWdUpsTBuVWxQyr3QDtxicSvaYwkEib69AevF
pw4+elSZrLgwi1+dVxEBiINeQdQ2BPAdClcQqu/9gcyibqMQkVAPpir/LZNyYAYp
oqMGBYSd824HGCb8tviZI6ScBdZ9oUc87gwV12vwJrCoAdO49fOr1xIZ/mznO5DL
BIc9hVvgDmNMzZexb5iApFu0FmwU1VpciaWBuFOBerLoRwYCaD6WmPVsRZ458e0F
TxdPicxkDYZOvGYfYGM3Tl7YlkCmxjY3neeIu7Apz6oiQ1qG7Y2IwYx9J8tvkX61
cny4+dm+y0olYlpRY7tUQ8rpOjua6TRzfvcWdytZ5cL+GxvSHjXA2aBXOY6Ib/Qq
xHoNBk4YupXOwVQu5P8MnzJWgdBa4f7ozrHVr/26GqHoTo1+lVvBl/0Z86vqfbKx
y1i0rQNp8naCcAwtE1mW8M40lRMMzKWUKS1aYo0nIPfyGSnEzwHI4oD7A4cpH868
HtY1nnm2X2C6N1cMIxrC29+55PqVCCOj69E05WsEUHTc9F7PwhEiAWpcCy8XJ1BL
vJFoJ0/ITxkYNJkWWtERKnHev9yXqWyFxr+9MSCcW3Jyx17Khc9xhYKr5ggsXvnX
oDDOjMra6K0OM2+c5CU7ReQE4QTm1TuQpxHMINZ+RtYGWWrL+xEPHM1LOC3DV3p8
ZnRr6lwbzZDeHaf+3UPQA474fhTYnSbcdGiZ7bz7tibP/Lp9XheMwmBRv9BzL/aK
ZVZII8EX4Ji8i47APz790hglHXM8TWsliD7uqAk8gBZBROGyZqYxWYs9R+t8V38r
eJJIzRzXnZRjulQgCg1t6LJV1ZX8ZVreQKJ/d2HC9WFx9uPjw+6V65v1rFiQ6O8z
uAw250HfeJUafXbp/B5UX/FL5izF/HUHjDxjuL6YePMMr2rHSrzqhhNGPRMWo5Yx
5K0/vZP3ORRZ25R+TLv0ab0N9yPDu1s4+PiteCAVVs+SS5zOYM9/Qu43j7k0V9/0
4y2NHg+1Q+oU/allICgiOg==
`pragma protect end_protected  

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C9BqhHZ4xwblmHuBnOoeKacRubTHlb2+dKPTXojXzMOkMRzdFxEq17+gtfN24eb/
IKoN5U2cBU2iNGsQ/ynDWppvrXHtzDHWmR4GUifdd66v8pb+oT5afmT4fGt2qqjm
twOBeWNkxENX1uI0D6gIgS5XHSbGxa1N6pPPs9zQmVQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6617      )
hRxZES6elSRvbCff4AopC2fNKjEIVeIECNZrfF8VjWl3ChJJfHpN5VBn0jQogrxn
tUUEX3Pd3ijqhqgaUwLfCNPYrrALdkcbshpdXLrLJJGSRXSXwuVCRHHWDBSRqK8R
+loy3212DYZlbv++wbNFW/bMHFa6CHIRZSvKBdiwitUDkKJyqGIzRZIXCn0qx7o+
oGftkZif+daP2eAn5M6ek2RgvXaECHWgxsdVLpZza8O2uVYuSpKaOKPp+dNW/OOQ
FxmfTyzzypl3XzyCFGQV19ya6UvSd/Yb2/6IoQIC85+PXrYiW4Y2e7ba1sZiX8g5
g5V+aUW4YB6vrjMBvcuv5sJNlLlTFU+/l2kcCtoeh3uLrysZOb3pPBw33gparpOd
RMh2Xt7dEYJnJJwdiY/9G1ngdwkpcszdBIuIMOOIHyk=
`pragma protect end_protected

// -----------------------------------------------------------------------------
function void svt_chi_rn_transaction::pre_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RBn+/c1chgJOz2ODf4ibIObp9BQLkekVoNs5SGFl8MiNsauThbFoVCSApNUUHIPL
Ysygy8v1Db0wQ3E+NFuNc6OZUoNs1J5u2CdxNPhyO/KV2dqXASz47ig9RFCwnaL6
Wg68MD1KEp06VVChfh7Xj0lMp1c8jxoOzCNjebOL4RY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8284      )
Mk4rwUSuNnyI4aJdAiFa92BFyx/pfn91uoT2AGsaq+B+RUKFJwkA2R39dGaroopG
FffrrA5Glv0W3SVogBTFf++pKNoAGMKTAdmqXEnE9ZEn2jMHMMIX+QHFhNYmUrJi
3HcHslGcjZpU2USj4/8iyrpJ2fpCT4KyFKeJPzeBX6IsCVS6UDuUV3uk72j0vFSA
e3bWLioXoT3Naz48DhMig+AF9JNXyPHONqKsWUKZUVz6vKdpiWNPP9eQk59sz0LB
AGuKvctGDS/4/qsgEjU8Z0feD8bHWYwCVtyuxDbQcZ7YKn5REYhzKebQl3yn0BNk
6RC0bsEOt6rROyyyZuQnpHD/0eyliZ1X4SmM5++QTpO89kVa6MdapED/dayAxxjQ
CB9hqFRg5hEUkO0BsDsAT0u/4o0FUuC5AT7lYCxWDH1bT6KYza20wGEgycZJEbnd
9Z+fv+jul3tR6DoLtqmMk6Uo/GrRgTTL5iorqrQRrH+SFy/50M6qyKO755/biy+2
1iXVu2GgghPG9w6ORCp935uCgBz2QQn3RBhhEhOWZehM3+8Cdvj6z86R2h2HbXUv
NkoGbSuu7ZUa/MeWbSYmFo3pQ1zNf7p8kdHBACwyXKEde72Qp63xjxuDFMI95g5W
GILZ+MSVQtu/W8mJyXoG6TBaOEMrD98Zi6/fZAveLrD2eUi2VfAf2R3h69hk+1zx
ZL7Ww0vA9Wzel5fAWeO65pmBVsvLKzLGCtPfi0SJd7Pv5sz0qDOBAPZCYvqwrZzj
aDB70m8y2ynFqIgAYOKdp+yzEUZv+JejdNXPd8sWeQse2FFVK8fMgYvcT3jQtAbR
/S9JtUTvrNCdtL+hPbGNVXzmVunBTMRXJv5pCRGsjstNhUqI3/M3p4fU5dwZ7a/v
gXRMHpFGskaQO0/kOxnAVvh1LWodKQ5V/icGI/KoPBw4EFUPpWZTDzz4NSPLJA8K
2P6DYDe4BOf4YyLxbfsomebDVeapErAZ/TE1ifVnlASkMrfiIr0XzDYrcXccyslQ
Vt13LceIcJV7WXdUypqC6s7d7gAVhUrGWvV4FZJ7kiAFSnc7ZHthegYiuWPoLX/e
fAiFww5iXRPmTZXPPmi0L0Z9HoK1N5VBb1PptxdhMo8reyCPJsDjVpEW5JStVg4T
k0h/EiLnaQwETx+imgf5GfO0L+ZQgmtr8ZcclPLJuE74yh3MXNVhhsI5eYUR+dtv
zyZknclNqQqjbQ2qGzuk2u/nRTCQ72/YOswAXgGxSNwvO8zBgbSgFx1Hc6hRsCjI
fBD157x/J0w+BLmFVBViTujUzkWkNVuwwgPXtnAU/E7i3f4G5nin1LuPDIbNUVY/
dZv8MhI67Vc6/N+Qx9KSsbT+Znegj7p3mU1pVRhf70KDdZQgfMmNzW4zVDUJBX65
OktSdZvbLEdzTIg74VKl0up35nEaa6upKb8HbNN5kLyCrhU4jGu28vO28OIkkJjL
1YqDKARd15W7Z5LH/TL91nhyUQsj2cy0noPjAqwPrnLk8Kb1cWpFRYQlGnTQBEE8
odCmGAShvO2ym3ZAVRtriZJzsFM1vI8QyahJX4HIA1pcaQeWFvYYwDdY7fJ6oOv8
GxyR/lBCBQNmabXm4QnoHhR6vfJn2mco/x4Papl3qJFZYDhCOxhaYZq2fc5bf6Xd
21bKtkj1GJmYl8tV7njzWqPuZyEP1UpG3RnlN3X33L1YravLswJapRHysTdfNaZ+
/cKj2InvvHAm1ooCUIp6Sy22TTXdHuGAhTLwYjGHuYYw6LKbW4BzAQoJFQM+8bsf
MQHduMMPZqjnAPbR2s2zB0ul5S3keALd138gtZdS0Nzac6gnUQuPyQec5s8z1swp
dDAuygX0SfDRUQf6Z9oDw7mWcGltjFin4PcDKxAFC+GmyzPiGSmyUBWF/k7lt9Rn
pWUvoKIeR5bxQ8P+YuZo5+QPI5BhEjRUkt1bAcOZCJNuTGePKX++SzK8Ekg7CpK1
33wX6z5fJlVej9ORGBTR9GIURvYWpZVsoKOKUVbY5TzDT22yQPTKrRqATfKRjqg2
ZER60XZ8cfVeLcLsVBVVayRsAIR1yOHS3csDx8MTBjL+8S5f6qmtzeOBggKVvqOj
cLNZCL1b3nDQRVViDvpbs8miQ+4GN1A3xiSD6bWsIyGcwkUmTAhTyxUD3P/FnqTo
hvfLPR9+pgK+B62CYPB+SwQcwepaitQGaUT6FXXuABzJXplamAPDyNKcmAtyCvrf
`pragma protect end_protected
endfunction // pre_randomize
  
// -----------------------------------------------------------------------------
function void svt_chi_rn_transaction::post_randomize();
  bit [(`SVT_CHI_MAX_BE_WIDTH-1):0] be_mask;
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    bit [(`SVT_CHI_MAX_TAG_UPDATE_WIDTH-1):0] tag_update_mask;
  `endif
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    bit [(`SVT_CHI_MAX_DATACHECK_WIDTH-1):0] datacheck_mask;
    bit [(`SVT_CHI_MAX_POISON_WIDTH-1):0] poison_mask;
  `endif
  bit [5:0]                         aligned_addr, curr_addr, next_addr_boundary;
  int                                               start_byte_idx,end_byte_idx;
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JTMsbIga39R2pqwgZt6t3FgtAeg1vjEHp0Xv2gAHXeOtnD8vcfdT7Z7TPprZlzV+
RTq/gupC8nwyUoOi8btP2o569/ThHPbqCPMY6vEeFHcmaGKMDazAjb83+Du/BWpF
HdoIwUwYoKK+cphcq4hTeo34Sw9MalTdxHcOLPmyjVs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22773     )
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
`pragma protect end_protected
endfunction: post_randomize

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
d9OApAIL97BAfCbQRqAYWfxTLOSC8KhX3M2ex4QdqdLppWmGCDjfzFIliIGABx1Z
LjfaflF2ARn4rrfFmSGFjvajWNGBUcMU0VBzdWRKdefdKo5DKuJ6daJ3y6PhRBJE
55Pir1FU+9eHuoyocHzoQe9wrEKRYzIvGsMjNaIz30g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24555     )
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
YfKFcVcI0/0RcQGWItieFQ==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AdjrChGMNmdvgBph80fXUVmhstc8Ads4VxfJy+FQWCArCTf1gHVYCzXRzZvA1HDr
tub8qdpmkMgOayYuhdLWL9n2fdF3wD+0qbzy+e/uLqfy7Tywun5IBf5kXFJScTEw
2DZrFCMFl7ET3ttxoT7s8UNUyw/O9oRi/16Ru425oH4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24756     )
4evuyZX9q49S0AoqtES8xwmxIVDTmO18wJxFPDczquFlXESMG3vz8x6Ggk/qjVwI
RUDQgsLcX1Vn6rIU9nhEW1Qwnf3eRd9XdLuy8MS1Ljhjj2IqkA0mu7iTKhx41oLY
aSq7eUhyW9H8ju1FYiZ0KOH6E2daJi4IwVCkY05n3inV+gSBNaDbqmAmY18YoBSu
QqAEZfOYN929LroYLlMLLNMRXzfU9Qr9fR3LeeYuEmZHzf3AIswzp3/zZsqwqfZh
opAqB1ufg30brlDOAPj9wQ==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HyMkpNaSS5SEoMiN5GHuFZfytrceD21OXe5ZTH441yONUEOeMNsFS04k+X3tWZLQ
/NK1rVv2e3nL0G8GLsspW9BO2jg5vO+bTVOa6UAXHp1OMzLdyNGD5arkKUBtBKOf
2FQAm2BZEueWDW5vAjDCeNXlSLjBGyVcIaMC9d9BkFE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 184541    )
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
kYA1X41Gyczii1urNMHg9J28MLZFcjUlP2k8+Fi4gKqbKaGvvFe/fF6PI+1p9T/t
w3KTcyqTm3YWYuqQyJR708Y5PmVtmE4mDmc0NtW1wZD1eVW1pquFBZjw0+QHMlmM
li4SksuUBqNsXugLH26A+7RtBjSMSnptXv2TCLNLsvS3u9NCuWFC0773i+IB4MRw
YIwTpTLjd1I5ugsX/LcyNCqoq+3xI94BzNnrq3FU4ISWO+sKkDT8hM3n8B7IlOy5
VSX7MwqvS124M4yQFFwGfkdIqqS0GDgKyXR5nne6x3vsh8havf4iwTd8LdZZdI6M
zd5n6cFPhkYYWeX6a426gl6lNaCS6UHE/CHZorNKWkoeJRLQrrsrZ1wtXN8phGk6
4V0lBVnUPNFd/3iwpbd7/Gf0dwpo5Dc7UBX8xlbo3NY+3g2AGnHgbOlPaJoep2UI
MhnEYDJRuhTumsSGfPQkjzjAUf1R9pCqBH2YPl6YVdMd3894VUZgbTuSYBOt/x3q
haHK5Z4eNqGl82H/8fHnY27GQ6UjiXPgmP66YeCG/PXQkeXbqkHaqwhs4Hk8O71d
aSHW1Q1afbPpXTs4lDLeGeL24nX6P/jU/7jiZdBS5rGQ1ByjKbyOrLHbnKs18D5A
xrJlHCO4244w268K+SocsfzMA8FcwTKEXfBTwERGYrLb8PFoOLxGepGUFZ8GIx25
d23lyxBYdks3ys3qIsDuJaaW3esT6mG6b9eCRyFDzUCRGPXxOJ0Gx8gTTAllxztD
UbuCdlSQaagUlq6yAMXgOBqRrjrZ+jtfyTBFNu66pzyfvRG7y71QFrLeE3RmPEXq
4MphnoY/qFMkBCqBsPjns1qdI22ijBwFtstFNny9y/TqTD1M0adl0TW51mkxyYM3
is/dsr8wHFFg0SkYZ/BK7TbuFgBKMaSVjX2e9zy7ZyrV8QJ+YcxjhZ4PjE7J/+Zl
HNPR3/qKtbq1nxvuy5DgDzjo85Ai7OEdTr0PyrU22tABbbw3FEUGEuD8jW5T4wtB
jczOh8ovPEw4i22JBNcWRphErN6vhvUKIgHGwrlWBvhrqsMunUHVH7wcUoMrX93v
HlUuA8gLZxO3iG1DXD6/MxrYfvJo+kZK7oZ4pNdMx/g7crkkNUMqeE1+lYtlR2qc
kSpOOl4KXwNjb0N+18mom62dman7F6RixiW8tYZMrsgpqNcac/eeswDIviQJAn9y
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lKNUHOqk1V/qDN2c3FpWIlo/K2EHtoQFqhL18/ShalPxxGu+2DOB/5PMmfV51+Mk
BTV7y6Ia3UjjopNuBJZ4NHgI1C0MI6FC6OAVUubk+pD27iTXAYUolK1BNVsOYu4N
Bic+2OF4Pt76aGiedHjqx+qnUE8StQDfyIXAEQOHPIE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 184851    )
Chlycz7OGF15lrWULw+WxnFbI875a3qVY3CqCWaVa8i0EqvAQyDSRoLUIxuRxwPk
Yi66svP2mgzwoxM2oePR7DpaprYwIVpYcGcwEv1fas19I6biaRiQ+Q4GGpZ8W8r4
E5D9JUCjUIFBTEa+bkogYTA2DmxZAXu41K6LSUcKeHylr3ty72w4Hd5qwUOHXVPb
ZtTuooh4Zc2RUUM0scdJLlE+XeE4goEv84KWCQniqyvjsllRUDAjTbFnyg4WpZJ4
Vam4G28O+shpvFMh9/ODj6wA0IfVHLnhxvQM7UNfmoHp1n8w+DwqO0ziaUmwtApL
ggwi7ZTWIlBuxrIzogbruGcypvqA12RFD9WkSOjcBeM9BDDV0oH6twppvT+/luSN
Y4mbwarZgOMD4OjGLZM5Db41U2dJYgGZw/cn0ZkYikc=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected  
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QxSv9V1G3wPbQk9yF+kOxadQ+DbsxwKzSr5Rmsp04oW+s3kgz6Zw8eVy1NZiaHv4
QAvKPbY+RIimwbvOqYfamLcIADr8LZAZqKfEtmzyeFJ2KaBad7ycs6skCupQkaE2
XLDDFwjLyIVMC+swQ2MvaE0+rRDIiUMxIENctzp9Um0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 243518    )
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
MXYIpCAEchmclKJVLTIGwQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NOZaOhQpRJjG2EcrBQHayQv2ylFEtPrZauX7G81zNQ1/qgiPnGLPe2AfCRfTyjm9
ATh+8hMyozyQKsbNLYRmzvIU4Z6u+MQvDCNNhArDrgwmAtkwy9uXNy7MMH/ap2Lp
9FWbNEjrXvoziGl7nu2j5C2PbEk5pKPl3yjEdqDqLFk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 243601    )
keGwObrJn/Q60NqR5MVgZFXtRV3ZYG5lUHWtjUdWwulA/DRvJw4rDrYLRWQEfu5I
7+FRMQzTs1AcdWclSrIQM3vVIWaEXA5ktnx4F5yLq2k4ZLkV7N3/JOrHCKhTE5ga
`pragma protect end_protected
