

// =============================================================================
`ifndef GUARD_SVT_CHI_SCENARIO_COVERAGE_SV
`define GUARD_SVT_CHI_SCENARIO_COVERAGE_SV


// ****************************************************************************
// Document the covergroup grouping categorization for HTML documentation
// ****************************************************************************

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_MEMORY_TAGGING_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture scenario coverage
 *  for CHI_E transactions with memory tagging enabled.
 */

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_ORDER_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture scenario coverage
 *  for ordered CHI transactions.
 */

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_COPYBACK_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture coverage for consecutive
 *  CopyBack CHI transactions.
 */

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_RETRY_OR_CANCEL_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture coverage for retry/cancel
 *  CHI transaction between/after two CHI Transaction of same TxnID.
 */

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_DVM_OPERATION_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture coverage for
 *  CHI DVM Operation transactions scenario sequences.
 */

/**
 * @grouphdr Coverage CHI_SCENARIO_COVERAGE_EXCLUSIVE_ACCESSES_PAIR_TRANSACTION_SEQUENCE
 *  The Covergroups under this group capture coverage for
 *  CHI Exclusive Accesses Sequence Pair transaction scenario sequences.
 */


/**
 * @grouphdr Coverage  CHI_SCENARIO_COVERAGE
 *  The Covergroups under this group capture scenario coverage
 *  for CHI transactions.
 * @groupref CHI_SCENARIO_COVERAGE_MEMORY_TAGGING_TRANSACTION_SEQUENCE.
 * @groupref CHI_SCENARIO_COVERAGE_ORDER_TRANSACTION_SEQUENCE.
 * @groupref CHI_SCENARIO_COVERAGE_COPYBACK_TRANSACTION_SEQUENCE.
 * @groupref CHI_SCENARIO_COVERAGE_RETRY_OR_CANCEL_TRANSACTION_SEQUENCE.
 * @groupref CHI_SCENARIO_COVERAGE_DVM_OPERATION_TRANSACTION_SEQUENCE.
 * @groupref CHI_SCENARIO_COVERAGE_EXCLUSIVE_ACCESSES_PAIR_TRANSACTION_SEQUENCE.
 */

/**
 * Class containing the coverage groups*/
typedef class svt_chi_scenario_coverage_database;
class svt_chi_scenario_coverage extends svt_chi_scenario_coverage_database;

  /**Configuration object */
  svt_chi_node_configuration  cfg;

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************
  
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    /**
   * @groupname CHI_SCENARIO_COVERAGE_MEMORY_TAGGING_TRANSACTION_SEQUENCE
   *  Coverage group for covering the below ordered CHI transactions scenarios:<br>
   *  - Write followed by Read targetted to the same cacheline with memory tagging enabled 
   *  - Read followed by Write targetted to the same cacheline with memory tagging enabled
   *  - It is constructed and sampled only when svt_chi_node_configuration::mem_tagging_enable is set to 1 and
   *  - svt_chi_node_configuration::chi_spec_revision is set to ISSUE_E or later. 
   *  .
   *
   *  Covergroup : trans_chi_e_consecutive_transaction_with_memory_tagging_enabled_sequence<br>
   *  Coverpoints: memory_tagging_transaction_sequence<br>
   *
   *  Bins:
   *  - write_with_tagop_update_followed_by_read_with_tagop_transfer_seq              - Write transaction with TagOp set to UPDATE, followed by Read transacton with TagOp set to TRANSFER.
   *  - write_with_tagop_update_followed_by_read_with_tagop_fetch_seq                 - Write transaction with TagOp set to UPDATE, followed by Read transacton with TagOp set to FETCH. 
   *  - readnosnp_with_tagop_fetch_followed_by_writenosnp_with_tagop_match_seq        - ReadNoSnp transacton with TagOp set to FETCH, followed by WriteNoSnp transaction with TagOp set to MATCH
   *  - readunique_with_tagop_fetch_followed_by_cobyback_xact_with_tagop_transfer_seq - ReadUnique transacton with TagOp set to FETCH, followed by CopyBack transaction with TagOp set to TRANSFER
   *  .
   *
   */
  covergroup trans_chi_e_consecutive_transaction_with_memory_tagging_enabled_sequence @(memory_tagging_transaction_event);
    type_option.comment = "Coverage for consecutive CHI transactions with memory tagging enabled.";
    option.per_instance = 1;
    memory_tagging_transaction_sequence : coverpoint this.order_between_transaction_sequence {

      // Write followed by Read Scenario Combination
      bins  write_with_tagop_update_followed_by_read_with_tagop_transfer_seq        = {`SVT_CHI_WRITE_WITH_TAGOP_UPDATE_FOLLOWED_BY_READ_WITH_TAGOP_TRANSFER_PATTERN_SEQ};
      bins  write_with_tagop_update_followed_by_read_with_tagop_fetch_seq           = {`SVT_CHI_WRITE_WITH_TAGOP_UPDATE_FOLLOWED_BY_READ_WITH_TAGOP_FETCH_PATTERN_SEQ};

      // Read followed by write Scenario Combination
      bins  readnosnp_with_tagop_fetch_followed_by_writenosnp_with_tagop_match_seq          = {`SVT_CHI_READNOSNP_WITH_TAGOP_FETCH_FOLLOWED_BY_WRITENOSNP_WITH_TAGOP_MATCH_PATTERN_SEQ};
      bins  readunique_with_tagop_fetch_followed_by_cobyback_xact_with_tagop_transfer_seq   = {`SVT_CHI_READUNIQUE_WITH_TAGOP_FETCH_FOLLOWED_BY_COBYBACK_XACT_WITH_TAGOP_TRANSFER_PATTERN_SEQ};
    }
  endgroup

  `endif

  /**
   * @groupname CHI_SCENARIO_COVERAGE_ORDER_TRANSACTION_SEQUENCE
   *  Coverage group for covering the below ordered CHI transactions scenarios:<br>
   *  - Write followed by Read  to Same/Different Addresses
   *  - Write followed by Write to Same/Different Addresses
   *  - Read  followed by Read  to Same/Different Addresses
   *  - Read  followed by Write to Same/Different Addresses
   *  - Snoopable WriteBack No Allocate Read/Write Transaction followed by another Read/Write Transaction to same Cacheline
   *  - 4 and 8 Back2Back Ordered Transactions to any address
   *  - 4 and 8 Non-Contiguous Ordered Transactions to any address
   *  - Unordered Read Transaction after two consecutive Ordered Write/Read Transactions to Same/Different Addresses
   *  - Ordered Read followed by an Ordered Read which is retried followed by another Ordered Read (Scenario depicted in Fig 2-23 in the CHI-B Spec)
   *  - Streaming Ordered WriteUnique transactions (Scenario depicted in Fig 2-24 in the CHI-B Spec)
   *  .
   *  The new Read and Write types introduced in CHI-B and CHI-E specifications are included in this covergroup. <br>
   *  Covergroup : trans_consecutive_order_transaction_sequence<br>
   *  Coverpoints: order_between_transaction_sequence<br>
   *
   *  Bins:
   *  - write_followed_by_read_transaction_seq - Write transaction followed by a Read transaction.
   *  - request_order_wr_followed_by_request_order_rd_transaction_seq - A Write with request ordering required followed by a Read with request ordering required.
   *  - request_order_wr_followed_by_request_order_rd_w_same_addr_transaction_seq - A Write with request ordering required followed by a Read with request ordering required targeting the same address.
   *  - request_order_wr_followed_by_request_order_rd_w_diff_addr_transaction_seq - A Write with request ordering required followed by a Read with request ordering required targeting a different address.
   *  - request_order_wr_followed_by_endpoint_order_rd_transaction_seq - A Write with request ordering required followed by a Read with endpoint ordering required.
   *  - request_order_wr_followed_by_endpoint_order_rd_w_same_addr_transaction_seq - A Write with request ordering required followed by a Read with endpoint ordering required targeting the same address.
   *  - request_order_wr_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq - A Write with request ordering required followed by a Read with endpoint ordering required targeting a different address.
   *  - endpoint_order_wr_followed_by_endpoint_order_rd_transaction_seq - A Write with endpoint ordering required followed by a Read with endpoint ordering required.
   *  - endpoint_order_wr_followed_by_endpoint_order_rd_w_same_addr_transaction_seq - A Write with endpoint ordering required followed by a Read with endpoint ordering required targeting the same address.
   *  - endpoint_order_wr_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq - A Write with endpoint ordering required followed by a Read with endpoint ordering required targeting a different address.
   *  - endpoint_order_wr_followed_by_request_order_rd_transaction_seq - A Write with endpoint ordering required followed by a Read with request ordering required.
   *  - endpoint_order_wr_followed_by_request_order_rd_w_same_addr_transaction_seq - A Write with endpoint ordering required followed by a Read with request ordering required targeting the same address.
   *  - endpoint_order_wr_followed_by_request_order_rd_w_diff_addr_transaction_seq - A Write with endpoint ordering required followed by a Read with request ordering required targeting a different address.
   *  - snoopable_writeback_no_allocate_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq - A Write transaction targeting a Snoopable WriteBack No-Allocate memory followed by a Read transaction targeting the same cacheline.                    
   *  - snoopable_writeback_no_allocate_no_likelyshared_no_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq - An unordered Write transaction targeting a Snoopable WriteBack No-Allocate  Non-LikelyShared memory followed by a Read transaction targeting the same cacheline. 
   *  - snoopable_writeback_no_allocate_no_likelyshared_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq - An ordered Write transaction targeting a Snoopable WriteBack No-Allocate Non-LikelyShared memory followed by a Read transaction targeting the same cacheline.
   *  - snoopable_writeback_no_allocate_likelyshared_no_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq - An unordered Write transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Read transaction targeting the same cacheline 
   *  - snoopable_writeback_no_allocate_likelyshared_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq - An ordered Write transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Read transaction targeting the same cacheline.  
   *  - write_followed_by_write_transaction_seq - A write transaction followed by another Write transaction.  
   *  - request_order_wr_followed_by_request_order_wr_transaction_seq - A Write with request ordering required followed by another Write with request ordering required.  
   *  - request_order_wr_followed_by_request_order_wr_w_same_addr_transaction_seq - A Write with request ordering required followed by another Write with request ordering required targeting the same address.  
   *  - request_order_wr_followed_by_request_order_wr_w_diff_addr_transaction_seq - A Write with request ordering required followed by another Write with request ordering required targeting a different address.  
   *  - request_order_wr_followed_by_endpoint_order_wr_transaction_seq - A Write with request ordering required followed by another Write with endpoint ordering required.  
   *  - request_order_wr_followed_by_endpoint_order_wr_w_same_addr_transaction_seq - A Write with request ordering required followed by another Write with endpoint ordering required targeting the same address.  
   *  - request_order_wr_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq - A Write with request ordering required followed by another Write with endpoint ordering required targeting a different address.  
   *  - endpoint_order_wr_followed_by_endpoint_order_wr_transaction_seq - A Write with endpoint ordering required followed by another Write with endpoint ordering required.  
   *  - endpoint_order_wr_followed_by_endpoint_order_wr_w_same_addr_transaction_seq - A Write with endpoint ordering required followed by another Write with endpoint ordering required targeting the same address.  
   *  - endpoint_order_wr_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq - A Write with endpoint ordering required followed by another Write with endpoint ordering required targeting a different address.  
   *  - endpoint_order_wr_followed_by_request_order_wr_transaction_seq - A Write with endpoint ordering required followed by another Write with request ordering required.  
   *  - endpoint_order_wr_followed_by_request_order_wr_w_same_addr_transaction_seq - A Write with endpoint ordering required followed by another Write with request ordering required targeting the same address.  
   *  - endpoint_order_wr_followed_by_request_order_wr_w_diff_addr_transaction_seq - A Write with endpoint ordering required followed by another Write with request ordering required targeting a different address.  
   *  - back2back_ordered_writeunique_transaction_seq - An ordered WriteUnique* or WriteUnique+CMO request followed by another ordered WriteUnique* or WriteUnique+CMO request. 
   *  - snoopable_writeback_no_allocate_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq - A Write transaction targeting a Snoopable WriteBack No-Allocate memory followed by a Write transaction targeting the same cacheline.                    
   *  - snoopable_writeback_no_allocate_no_likelyshared_no_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq - An unordered Write transaction targeting a Snoopable WriteBack No-Allocate  Non-LikelyShared memory followed by a Write transaction targeting the same cacheline. 
   *  - snoopable_writeback_no_allocate_no_likelyshared_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq - An ordered Write transaction targeting a Snoopable WriteBack No-Allocate Non-LikelyShared memory followed by a Write transaction targeting the same cacheline.
   *  - snoopable_writeback_no_allocate_likelyshared_no_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq - An unordered Write transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Write transaction targeting the same cacheline 
   *  - snoopable_writeback_no_allocate_likelyshared_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq - An ordered Write transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Write transaction targeting the same cacheline.  
   *  - streaming_ordered_writeunique_transactions_seq - An ordered WriteUnique request with ExpCompAck set to 1 followed by another ordered WriteUnique with ExpCompAck set to 1, wherein the Comp response for the second ordered WriteUnique is received before the Comp response for the first ordered WriteUnique.  
   *  - read_followed_by_read_transaction_seq - A Read transaction followed by another Read transaction.  
   *  - request_order_rd_followed_by_request_order_rd_transaction_seq - A Read with request ordering required followed by another Read with request ordering required.  
   *  - request_order_rd_followed_by_request_order_rd_w_same_addr_transaction_seq - A Read with request ordering required followed by another Read with request ordering required targeting the same address.  
   *  - request_order_rd_followed_by_request_order_rd_w_diff_addr_transaction_seq - A Read with request ordering required followed by another Read with request ordering required targeting a different address.  
   *  - request_order_rd_followed_by_endpoint_order_rd_transaction_seq - A Read with request ordering required followed by another Read with endpoint ordering required.  
   *  - request_order_rd_followed_by_endpoint_order_rd_w_same_addr_transaction_seq - A Read with request ordering required followed by another Read with endpoint ordering required targeting the same address.  
   *  - request_order_rd_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq - A Read with request ordering required followed by another Read with endpoint ordering required targeting a different address.  
   *  - endpoint_order_rd_followed_by_endpoint_order_rd_transaction_seq - A Read with endpoint ordering required followed by another Read with endpoint ordering required.  
   *  - endpoint_order_rd_followed_by_endpoint_order_rd_w_same_addr_transaction_seq - A Read with endpoint ordering required followed by another Read with endpoint ordering required targeting the same address.  
   *  - endpoint_order_rd_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq - A Read with endpoint ordering required followed by another Read with endpoint ordering required targeting a different address.  
   *  - endpoint_order_rd_followed_by_request_order_rd_transaction_seq - A Read with endpoint ordering required followed by another Read with request ordering required.  
   *  - endpoint_order_rd_followed_by_request_order_rd_w_same_addr_transaction_seq - A Read with endpoint ordering required followed by another Read with request ordering required targeting the same address.  
   *  - endpoint_order_rd_followed_by_request_order_rd_w_diff_addr_transaction_seq - A Read with endpoint ordering required followed by another Read with request ordering required targeting a different address.  
   *  - snoopable_writeback_no_allocate_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq - A Read transaction targeting a Snoopable WriteBack No-Allocate memory followed by a Read transaction targeting the same cacheline.                    
   *  - snoopable_writeback_no_allocate_no_likelyshared_no_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq - An unordered Read transaction targeting a Snoopable WriteBack No-Allocate  Non-LikelyShared memory followed by a Read transaction targeting the same cacheline. 
   *  - snoopable_writeback_no_allocate_no_likelyshared_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq - An ordered Read transaction targeting a Snoopable WriteBack No-Allocate Non-LikelyShared memory followed by a Read transaction targeting the same cacheline.
   *  - snoopable_writeback_no_allocate_likelyshared_no_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq - An unordered Read transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Read transaction targeting the same cacheline 
   *  - read_followed_by_write_transaction_seq - Read transaction followed by a Write transaction.
   *  - request_order_rd_followed_by_request_order_wr_transaction_seq - A Read with request ordering required followed by a Write with request ordering required.
   *  - request_order_rd_followed_by_request_order_wr_w_same_addr_transaction_seq - A Read with request ordering required followed by a Write with request ordering required targeting the same address.
   *  - request_order_rd_followed_by_request_order_wr_w_diff_addr_transaction_seq - A Read with request ordering required followed by a Write with request ordering required targeting a different address.
   *  - request_order_rd_followed_by_endpoint_order_wr_transaction_seq - A Read with request ordering required followed by a Write with endpoint ordering required.
   *  - request_order_rd_followed_by_endpoint_order_wr_w_same_addr_transaction_seq - A Read with request ordering required followed by a Write with endpoint ordering required targeting the same address.
   *  - request_order_rd_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq - A Read with request ordering required followed by a Write with endpoint ordering required targeting a different address.
   *  - endpoint_order_rd_followed_by_endpoint_order_wr_transaction_seq - A Read with endpoint ordering required followed by a Write with endpoint ordering required.
   *  - endpoint_order_rd_followed_by_endpoint_order_wr_w_same_addr_transaction_seq - A Read with endpoint ordering required followed by a Write with endpoint ordering required targeting the same address.
   *  - endpoint_order_rd_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq - A Read with endpoint ordering required followed by a Write with endpoint ordering required targeting a different address.
   *  - endpoint_order_rd_followed_by_request_order_wr_transaction_seq - A Read with endpoint ordering required followed by a Write with request ordering required.
   *  - endpoint_order_rd_followed_by_request_order_wr_w_same_addr_transaction_seq - A Read with endpoint ordering required followed by a Write with request ordering required targeting the same address.
   *  - endpoint_order_rd_followed_by_request_order_wr_w_diff_addr_transaction_seq - A Read with endpoint ordering required followed by a Write with request ordering required targeting a different address.
   *  - snoopable_writeback_no_allocate_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq - A Read transaction targeting a Snoopable WriteBack No-Allocate memory followed by a Write transaction targeting the same cacheline.                    
   *  - snoopable_writeback_no_allocate_no_likelyshared_no_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq - An unordered Read transaction targeting a Snoopable WriteBack No-Allocate  Non-LikelyShared memory followed by a Write transaction targeting the same cacheline. 
   *  - snoopable_writeback_no_allocate_no_likelyshared_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq - An ordered Read transaction targeting a Snoopable WriteBack No-Allocate Non-LikelyShared memory followed by a Write transaction targeting the same cacheline.
   *  - snoopable_writeback_no_allocate_likelyshared_no_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq - An unordered Read transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Write transaction targeting the same cacheline 
   *  - snoopable_writeback_no_allocate_likelyshared_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq - An ordered Read transaction targeting a Snoopable WriteBack No-Allocate LikelyShared memory followed by a Write transaction targeting the same cacheline.  
   *  - back2back_4times_ordered_transaction_seq - Four ordered transactions are issued one after another.  
   *  - back2back_4times_request_order_transaction_seq - Four transactions with request ordering required are issued one after another.  
   *  - back2back_4times_endpoint_order_transaction_seq - Four transactions with endpoint ordering required are issued one after another.  
   *  - back2back_8times_ordered_transaction_seq - Eight ordered transactions are issued one after another.  
   *  - back2back_8times_request_order_transaction_seq - Eight transactions with request ordering required are issued one after another.  
   *  - back2back_8times_endpoint_order_transaction_seq - Eight transactions with endpoint ordering required are issued one after another.  
   *  - non_contiguous_4times_ordered_transaction_seq - Four non-consecutive ordered transactions issued.  
   *  - non_contiguous_4times_request_order_transaction_seq - Four non-consecutive transactions with request ordering required issued.  
   *  - non_contiguous_4times_endpoint_order_transaction_seq - Four non-consecutive transactions with endpoint ordering required issued.  
   *  - non_contiguous_8times_ordered_transaction_seq - Eight non-consecutive ordered transactions issued.  
   *  - non_contiguous_8times_request_order_transaction_seq - Eight non-consecutive transactions with request ordering required issued.  
   *  - non_contiguous_8times_endpoint_order_transaction_seq - Eight non-consecutive transactions with endpoint ordering required issued.  
   *  - no_ordering_rd_after_two_ordered_transaction_seq - An ordered transaction followed by another ordered transaction followed by an unordered Read transaction.  
   *  - no_ordering_rd_after_two_ordered_w_same_addr_transaction_seq - An ordered transaction followed by another ordered transaction followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_wr_followed_by_req_order_wr_w_same_addr_transaction_seq - A Write transaction with request ordering required followed by another Write transaction with request ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_wr_followed_by_ep_order_wr_w_same_addr_transaction_seq - A Write transaction with request ordering required followed by a Write transaction with endpoint ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_wr_followed_by_req_order_rd_w_same_addr_transaction_seq - A Write transaction with request ordering required followed by a Read transaction with request ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_wr_followed_by_ep_order_rd_w_same_addr_transaction_seq - A Write transaction with request ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_rd_followed_by_req_order_wr_w_same_addr_transaction_seq - A Read transaction with request ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_rd_followed_by_ep_order_wr_w_same_addr_transaction_seq - A Read transaction with request ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_rd_followed_by_req_order_rd_w_same_addr_transaction_seq - A Read transaction with request ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_req_order_rd_followed_by_ep_order_rd_w_same_addr_transaction_seq - A Read transaction with request ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_req_order_wr_w_same_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_ep_order_wr_w_same_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_req_order_rd_w_same_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_ep_order_rd_w_same_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_req_order_wr_w_same_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_ep_order_wr_w_same_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_req_order_rd_w_same_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_ep_order_rd_w_same_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein all three transactions target the same address.
   *  - no_ordering_rd_after_two_ordered_w_diff_diff_addr_transaction_seq - An ordered transaction followed by another ordered transaction followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_wr_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq - A Write transaction with request ordering required followed by another Write transaction with request ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_wr_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq - A Write transaction with request ordering required followed by a Write transaction with endpoint ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_wr_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq - A Write transaction with request ordering required followed by a Read transaction with request ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_wr_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq - A Write transaction with request ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_rd_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq - A Read transaction with request ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_rd_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq - A Read transaction with request ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_rd_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq - A Read transaction with request ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_req_order_rd_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq - A Read transaction with request ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_wr_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq - A Write transaction with endpoint ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Write transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Write transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Read transaction with request ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - no_ordering_rd_after_ep_order_rd_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq - A Read transaction with endpoint ordering required followed by a Read transaction with endpoint ordering required ordering required followed by an unordered Read transaction, wherein the transactions target different addresses.
   *  - ordered_read_followed_by_retried_ordered_read_followed_by_ordered_read - An ordered Read transaction followed by an ordered Read transaction that receives a Retry response followed by the retried ordered read transaction followed by another ordered Read transaction.
   *  - req_ordered_read_followed_by_retried_req_ordered_read_followed_by_req_ordered_read - A Read transaction with request ordering required followed by an Read transaction with request ordering required that receives a Retry response followed by the retried read transaction followed by another Read transaction with request ordering required.
   *  - ep_ordered_read_followed_by_retried_ep_ordered_read_followed_by_ep_ordered_read - A Read transaction with endpoint ordering required followed by an Read transaction with endpoint ordering required that receives a Retry response followed by the retried read transaction followed by another Read transaction with endpoint ordering required.
   *  .
   */
  covergroup trans_consecutive_order_transaction_sequence @(order_between_transaction_event);
    type_option.comment = "Coverage for consecutive different different ordered CHI transactions";
    option.per_instance = 1;
    order_between_transaction_sequence : coverpoint this.order_between_transaction_sequence {

      // Write followed by Read Scenario Combination
      bins  write_followed_by_read_transaction_seq                                      = {`SVT_CHI_WRITE_FOLLOWED_BY_READ_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_rd_transaction_seq               = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_rd_w_same_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_rd_w_diff_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_rd_transaction_seq              = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_rd_w_same_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_rd_transaction_seq             = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_rd_w_same_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_rd_transaction_seq              = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_rd_w_same_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_rd_w_diff_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};

      bins  snoopable_writeback_no_allocate_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq                          = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_WR_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_no_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_NO_ORDER_WR_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_ORDER_WR_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_no_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_NO_ORDER_WR_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_order_wr_followed_by_rd_w_same_cacheline_addr_transaction_seq       = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_ORDER_WR_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};


      // Write followed by Write Scenario Combination
      bins  write_followed_by_write_transaction_seq                                     = {`SVT_CHI_WRITE_FOLLOWED_BY_WRITE_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_wr_transaction_seq               = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_wr_w_same_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_request_order_wr_w_diff_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_wr_transaction_seq              = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_wr_w_same_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_wr_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_wr_transaction_seq             = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_wr_w_same_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_EP_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_wr_transaction_seq              = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_wr_w_same_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_wr_followed_by_request_order_wr_w_diff_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_WR_FOLLOWED_BY_REQ_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};

      bins  back2back_ordered_writeunique_transaction_seq                             = {`SVT_CHI_BACK2BACK_ORDERED_WRITEUNIQUE_PATTERN_SEQ};

      bins  snoopable_writeback_no_allocate_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq                          = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_WR_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_no_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_NO_ORDER_WR_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_ORDER_WR_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_no_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_NO_ORDER_WR_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_order_wr_followed_by_wr_w_same_cacheline_addr_transaction_seq       = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_ORDER_WR_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};

      bins  streaming_ordered_writeunique_transactions_seq                              = {`SVT_CHI_STREAMING_ORDERED_WRITEUNIQUE_TRANSACTIONS};


      // Read followed by Read Scenario Combination
      bins  read_followed_by_read_transaction_seq                                       = {`SVT_CHI_READ_FOLLOWED_BY_READ_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_rd_transaction_seq               = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_rd_w_same_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_rd_w_diff_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_rd_transaction_seq              = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_rd_w_same_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_rd_transaction_seq             = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_rd_w_same_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_rd_w_diff_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_rd_transaction_seq              = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_rd_w_same_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_rd_w_diff_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_RD_W_DIFF_ADDR_PATTERN_SEQ};

      bins  snoopable_writeback_no_allocate_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq                          = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_RD_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_no_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_NO_ORDER_RD_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_ORDER_RD_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_no_order_rd_followed_by_rd_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_NO_ORDER_RD_FOLLOWED_BY_RD_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};


      // Read followed by Write Scenario Combination
      bins  read_followed_by_write_transaction_seq                                      = {`SVT_CHI_READ_FOLLOWED_BY_WRITE_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_wr_transaction_seq               = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_wr_w_same_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_request_order_wr_w_diff_addr_transaction_seq   = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_wr_transaction_seq              = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_wr_w_same_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  request_order_rd_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq  = {`SVT_CHI_REQ_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_wr_transaction_seq             = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_wr_w_same_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_endpoint_order_wr_w_diff_addr_transaction_seq = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_EP_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_wr_transaction_seq              = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_wr_w_same_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_W_SAME_ADDR_PATTERN_SEQ};
      bins  endpoint_order_rd_followed_by_request_order_wr_w_diff_addr_transaction_seq  = {`SVT_CHI_EP_ORDERED_RD_FOLLOWED_BY_REQ_ORDERED_WR_W_DIFF_ADDR_PATTERN_SEQ};

      bins  snoopable_writeback_no_allocate_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq                          = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_RD_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_no_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_NO_ORDER_RD_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_no_likelyshared_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_NO_LIKELYSHARED_ORDER_RD_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_no_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq    = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_NO_ORDER_RD_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};
      bins  snoopable_writeback_no_allocate_likelyshared_order_rd_followed_by_wr_w_same_cacheline_addr_transaction_seq       = {`SVT_CHI_SNOOPABLE_WRITEBACK_NO_ALLOCATE_LIKELYSHARED_ORDER_RD_FOLLOWED_BY_WR_W_SAME_CACHELINE_ADDR_PATTERN_SEQ};


      // 'N' Times Back2Back Order Type Transaction Combination
      bins  back2back_4times_ordered_transaction_seq         = {`SVT_CHI_BACK2BACK_4_TIMES_ORDER_TYPE_PATTERN_SEQ};
      bins  back2back_4times_request_order_transaction_seq   = {`SVT_CHI_BACK2BACK_4_TIMES_REQ_ORDER_TYPE_PATTERN_SEQ};
      bins  back2back_4times_endpoint_order_transaction_seq  = {`SVT_CHI_BACK2BACK_4_TIMES_EP_ORDER_TYPE_PATTERN_SEQ};
      bins  back2back_8times_ordered_transaction_seq         = {`SVT_CHI_BACK2BACK_8_TIMES_ORDER_TYPE_PATTERN_SEQ};
      bins  back2back_8times_request_order_transaction_seq   = {`SVT_CHI_BACK2BACK_8_TIMES_REQ_ORDER_TYPE_PATTERN_SEQ};
      bins  back2back_8times_endpoint_order_transaction_seq  = {`SVT_CHI_BACK2BACK_8_TIMES_EP_ORDER_TYPE_PATTERN_SEQ};

      // 'N' Times Non-Contiguous Order Type Transaction Combination
      bins  non_contiguous_4times_ordered_transaction_seq         = {`SVT_CHI_NON_CONTIGUOUS_4_TIMES_ORDER_TYPE_PATTERN_SEQ};
      bins  non_contiguous_4times_request_order_transaction_seq   = {`SVT_CHI_NON_CONTIGUOUS_4_TIMES_REQ_ORDER_TYPE_PATTERN_SEQ};
      bins  non_contiguous_4times_endpoint_order_transaction_seq  = {`SVT_CHI_NON_CONTIGUOUS_4_TIMES_EP_ORDER_TYPE_PATTERN_SEQ};
      bins  non_contiguous_8times_ordered_transaction_seq         = {`SVT_CHI_NON_CONTIGUOUS_8_TIMES_ORDER_TYPE_PATTERN_SEQ};
      bins  non_contiguous_8times_request_order_transaction_seq   = {`SVT_CHI_NON_CONTIGUOUS_8_TIMES_REQ_ORDER_TYPE_PATTERN_SEQ};
      bins  non_contiguous_8times_endpoint_order_transaction_seq  = {`SVT_CHI_NON_CONTIGUOUS_8_TIMES_EP_ORDER_TYPE_PATTERN_SEQ};


      // No Ordering Read Transaction after two consecutive Non No Ordering WR/RD Transaction
      bins  no_ordering_rd_after_two_ordered_transaction_seq                                             = {`SVT_CHI_NO_ORDERING_RD_AFTER_TWO_NON_NO_ORDERING_TRANSACTION_PATTERN_SEQ};

      bins  no_ordering_rd_after_two_ordered_w_same_addr_transaction_seq                                 = {`SVT_CHI_NO_ORDERING_RD_AFTER_TWO_NON_NO_ORDERING_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_req_order_wr_w_same_addr_transaction_seq       = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_ep_order_wr_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_req_order_rd_w_same_addr_transaction_seq       = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_ep_order_rd_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_req_order_wr_w_same_addr_transaction_seq       = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_ep_order_wr_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_req_order_rd_w_same_addr_transaction_seq       = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_ep_order_rd_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_req_order_wr_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_ep_order_wr_w_same_addr_transaction_seq         = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_req_order_rd_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_ep_order_rd_w_same_addr_transaction_seq         = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_req_order_wr_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_ep_order_wr_w_same_addr_transaction_seq         = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_req_order_rd_w_same_addr_transaction_seq        = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_ep_order_rd_w_same_addr_transaction_seq         = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_SAME_ADDR_PATTERN_SEQ};

      bins  no_ordering_rd_after_two_ordered_w_diff_diff_addr_transaction_seq                            = {`SVT_CHI_NO_ORDERING_RD_AFTER_TWO_NON_NO_ORDERING_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq  = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq  = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_wr_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_WR_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq  = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq  = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_req_order_rd_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_REQ_ORDER_RD_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq    = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_wr_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq    = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_WR_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_req_order_wr_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_REQ_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_ep_order_wr_w_diff_diff_addr_transaction_seq    = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_EP_ORDER_WR_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_req_order_rd_w_diff_diff_addr_transaction_seq   = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_REQ_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};
      bins  no_ordering_rd_after_ep_order_rd_followed_by_ep_order_rd_w_diff_diff_addr_transaction_seq    = {`SVT_CHI_NO_ORDERING_RD_AFTER_EP_ORDER_RD_FOLLOWED_BY_EP_ORDER_RD_TRANSACTION_W_DIFF_DIFF_ADDR_PATTERN_SEQ};


      // Ordered Read Followed by Ordered read which recieves a retry response followed by retried Ordered Read Followed by Ordered Read
      bins  ordered_read_followed_by_retried_ordered_read_followed_by_ordered_read                       = {`SVT_CHI_THREE_READ_REQUEST_ORDERING_TRANSACTION_PATTERN_SEQ};
      bins  req_ordered_read_followed_by_retried_req_ordered_read_followed_by_req_ordered_read           = {`SVT_CHI_THREE_READ_REQUEST_REQ_ORDERING_TRANSACTION_PATTERN_SEQ};
      bins  ep_ordered_read_followed_by_retried_ep_ordered_read_followed_by_ep_ordered_read              = {`SVT_CHI_THREE_READ_REQUEST_EP_ORDERING_TRANSACTION_PATTERN_SEQ};


    }
  endgroup

`ifdef SVT_CHI_ISSUE_D_ENABLE
  /**
   * @groupname CHI_SCENARIO_COVERAGE_ORDER_TRANSACTION_SEQUENCE
   *  Coverage group for covering scenarios related to ordered WriteNoSnp transactions. <br>
   *  The Covergroup is constructed only when svt_chi_node_configuration::chi_spec_revision is set to ISSUE_D or later. <br>
   *  The new WriteNoSnp types introduced in CHI-E specification are included in this covergroup. <br>
   *  Covergroup : trans_consecutive_order_writenosnp_transaction_sequence <br>
   *  Coverpoints: order_between_writenosnp_transaction_sequence <br>
   *  Bins:
   *  - back2back_ordered_writenosnp_transaction_seq - An ordered WriteNoSnp* or WriteNoSnp+CMO request followed by another ordered WriteNoSnp* or WriteNoSnp+CMO request 
   *  - back2back_req_ordered_writenosnp_transaction_seq - A WriteNoSnp* or WriteNoSnp+CMO request with request ordering required followed by another WriteNoSnp* or WriteNoSnp+CMO request with request ordering required.
   *  - back2back_req_ordered_writenosnp_ep_ordered_writenosnp_transaction_seq - A WriteNoSnp* or WriteNoSnp+CMO request with required ordering required followed by a WriteNoSnp* or WriteNoSnp+CMO request with endpoint ordering required.
   *  - back2back_ep_ordered_writenosnp_transaction_seq - A WriteNoSnp* or WriteNoSnp+CMO request with endpoint ordering required followed by another WriteNoSnp* or WriteNoSnp+CMO request with endpoint ordering required.
   *  - back2back_ep_ordered_writenosnp_req_ordered_writenosnp_transaction_seq - A WriteNoSnp* or WriteNoSnp+CMO request with endpoint ordering required followed by a WriteNoSnp* or WriteNoSnp+CMO request with request ordering required.
   *  - streaming_ordered_writenosnp_transactions_seq - An ordered WriteNoSnp* or WriteNoSNp+CMO request with ExpCompAck set to 1 followed by another ordered WriteNoSnp* or WriteNoSnp+CMO with ExpCompAck set to 1, wherein the Comp response for the second ordered WriteNoSnp is received before the Comp response for the first ordered WriteNoSnp.
   *  .  
   */
  covergroup trans_consecutive_order_writenosnp_transaction_sequence @(order_between_transaction_event);
    type_option.comment = "Coverage for consecutive ordered CHI WriteNoSnp transactions";
    option.per_instance = 1;
    order_between_writenosnp_transaction_sequence : coverpoint this.order_between_transaction_sequence {

      bins  back2back_ordered_writenosnp_transaction_seq                              = {`SVT_CHI_BACK2BACK_ORDERED_WRITENOSNP_PATTERN_SEQ};
      bins  back2back_req_ordered_writenosnp_transaction_seq                          = {`SVT_CHI_BACK2BACK_REQ_ORDERED_WRITENOSNP_PATTERN_SEQ};
      bins  back2back_req_ordered_writenosnp_ep_ordered_writenosnp_transaction_seq    = {`SVT_CHI_BACK2BACK_REQ_ORDERED_WRITENOSNP_EP_ORDERED_WRITENOSNP_PATTERN_SEQ};
      bins  back2back_ep_ordered_writenosnp_transaction_seq                           = {`SVT_CHI_BACK2BACK_EP_ORDERED_WRITENOSNP_PATTERN_SEQ};
      bins  back2back_ep_ordered_writenosnp_req_ordered_writenosnp_transaction_seq    = {`SVT_CHI_BACK2BACK_EP_ORDERED_WRITENOSNP_REQ_ORDERED_WRITENOSNP_PATTERN_SEQ};
      bins  streaming_ordered_writenosnp_transactions_seq                             = {`SVT_CHI_STREAMING_ORDERED_WRITENOSNP_TRANSACTIONS};
    }
  endgroup

  /**
   * @groupname CHI_SCENARIO_COVERAGE_ORDER_TRANSACTION_SEQUENCE
   *  Coverage group for covering scenarios related to OWO Write transactions. <br>
   *  The Covergroup is constructed only when svt_chi_node_configuration::chi_spec_revision is set to ISSUE_D or later. <br>
   *  The new WriteUnique and WriteNoSnp opcodes introduced in CHI-E specification are included in this covergroup. <br>
   *  Covergroup : trans_consecutive_owo_write_transaction_sequence <br>
   *  Coverpoints: owo_write_transaction_sequence <br>
   *
   *  Bins:
   *  - early_compack_for_second_owo_writeunique_after_comp_for_first_owo_writeunique 
   *    - An OWO WriteUnique* or WriteUnique+CMO request followed by another OWO WriteUnique* or WriteUnique+CMO request, wherein the CompAck for the second WriteUnique is sent after the Comp response is received for the first WriteUnique, while the first WriteUnique is still outstanding.
   *    - Following is the scenario that is covered by this bin:
   *      - OWO WriteUnique Transaction#1 is issued by the RN.
   *      - OWO WriteUnique Transaction#2 is issued by the RN once OWO Transaction#1 receives DBIDResp.
   *      - OWO WriteUnique Transaction#1 receives a Comp response.
   *      - CompAck is issued for OWO WriteUnique Transaction#2, even before Comp response is observed for the transaction.
   *      - OWO WriteUnique Transaction#1 completes.
   *      - OWO WriteUnique Transaction#2 completes.
   *      .
   *    .
   *  - early_compack_for_second_owo_writeunique_after_comp_for_first_owo_writeunique_w_same_addr 
   *    - An OWO WriteUnique* or WriteUnique+CMO request followed by another OWO WriteUnique* or WriteUnique+CMO request targeting the same address, wherein the CompAck for the second WriteUnique is sent after the Comp response is received for the first WriteUnique, while the first WriteUnique is still outstanding.
   *    - Following is the scenario that is covered by this bin:
   *      - OWO WriteUnique Transaction#1 is issued by the RN.
   *      - OWO WriteUnique Transaction#2 is issued by the RN once OWO WriteUnique Transaction#1 receives DBIDResp, targeting the same address as OWO Transaction#1.
   *      - OWO WriteUnique Transaction#1 receives a Comp response.
   *      - CompAck is issued for OWO WriteUnique Transaction#2, even before Comp response is observed for the transaction.
   *      - OWO WriteUnique Transaction#1 completes.
   *      - OWO WriteUnique Transaction#2 completes.
   *      .
   *    .
   *  - early_compack_for_second_owo_writenosnp_after_comp_for_first_owo_writenosnp 
   *    - An OWO WriteNoSnp* or WriteNoSnp+CMO request followed by another OWO WriteNoSnp* or WriteNoSnp+CMO request, wherein the CompAck for the second WriteNoSnp is sent after the Comp response is received for the first WriteNoSnp, while the first WriteNoSnp is still outstanding.
   *    - Following is the scenario that is covered by this bin:
   *      - OWO WriteNoSnp Transaction#1 is issued by the RN.
   *      - OWO WriteNoSnp Transaction#2 is issued by the RN once OWO Transaction#1 receives DBIDResp.
   *      - OWO WriteNoSnp Transaction#1 receives a Comp response.
   *      - CompAck is issued for OWO WriteNoSnp Transaction#2, even before Comp response is observed for the transaction.
   *      - OWO WriteNoSnp Transaction#1 completes.
   *      - OWO WriteNoSnp Transaction#2 completes.
   *      .
   *    .
   *  - early_compack_for_second_owo_writenosnp_after_comp_for_first_owo_writenosnp_w_same_addr 
   *    - An OWO WriteNoSnp* or WriteNoSnp+CMO request followed by another OWO WriteNoSnp* or WriteNoSnp+CMO request targeting the same address, wherein the CompAck for the second WriteNoSnp is sent after the Comp response is received for the first WriteNoSnp, while the first WriteNoSnp is still outstanding.
   *    - Following is the scenario that is covered by this bin:
   *      - OWO WriteNoSnp Transaction#1 is issued by the RN.
   *      - OWO WriteNoSnp Transaction#2 is issued by the RN once OWO WriteNoSnp Transaction#1 receives DBIDResp, targeting the same address as OWO WriteNoSnp Transaction#1.
   *      - OWO WriteNoSnp Transaction#1 receives a Comp response.
   *      - CompAck is issued for OWO WriteNoSnp Transaction#2, even before Comp response is observed for the transaction.
   *      - OWO WriteNoSnp Transaction#1 completes.
   *      - OWO WriteNoSnp Transaction#2 completes.
   *      .
   *    .
   *  .  
   */
  covergroup trans_consecutive_owo_write_transaction_sequence @(order_between_transaction_event);
    type_option.comment = "Coverage for consecutive OWO CHI Write transactions";
    option.per_instance = 1;
    owo_write_transaction_sequence : coverpoint this.order_between_transaction_sequence {

      bins  early_compack_for_second_owo_writeunique_before_comp_but_after_comp_for_first_owo_writeunique = {`SVT_CHI_COMPACK_FOR_SECOND_OWO_WRITEUNIQUE_BEFORE_COMP_BUT_AFTER_COMP_FOR_FIRST_OWO_WRITEUNQIUE};
      bins  early_compack_for_second_owo_writeunique_before_comp_but_after_comp_for_first_owo_writeunique_w_same_addr = {`SVT_CHI_COMPACK_FOR_SECOND_OWO_WRITEUNIQUE_BEFORE_COMP_BUT_AFTER_COMP_FOR_FIRST_OWO_WRITEUNQIUE_W_SAME_ADDR};
      bins  early_compack_for_second_owo_writenosnp_before_comp_but_after_comp_for_first_owo_writenosnp = {`SVT_CHI_COMPACK_FOR_SECOND_OWO_WRITENOSNP_BEFORE_COMP_BUT_AFTER_COMP_FOR_FIRST_OWO_WRITENOSNP};
      bins  early_compack_for_second_owo_writenosnp_before_comp_but_after_comp_for_first_owo_writenosnp_w_same_addr = {`SVT_CHI_COMPACK_FOR_SECOND_OWO_WRITENOSNP_BEFORE_COMP_BUT_AFTER_COMP_FOR_FIRST_OWO_WRITENOSNP_W_SAME_ADDR};
    }
  endgroup
`endif


  /**
   * @groupname CHI_SCENARIO_COVERAGE_COPYBACK_TRANSACTION_SEQUENCE
   *  Coverage group for covering the consecutive CopyBack CHI transactions<br>
   *  The new CopyBack and CopyBack+CMO opcodes introduced in the CHI-E specification are included in this Covergroup. <br>
   *  Covergroup : trans_consecutive_copyback_transaction_sequence<br>
   *  Coverpoints: copyback_transaction_sequence<br>
   *
   *  Bins:
   *  - consecutive_copyback_transactions_seq                                            - Back-to-Back CopyBack CHI Transactions
   *  - consecutive_copyback_transactions_seq_w_same_or_overlapping_addr                 - Back-to-Back CopyBack CHI Transactions to Same/Overlapping Address 
   *  - consecutive_copyback_w_same_or_overlapping_addr_w_allow_retry_transactions_seq   - Back-to-Back CopyBack CHI Transactions to Same/Overlapping Address with AllowRetry asserted
   *  - consecutive_copyback_w_same_or_overlapping_addr_wo_allow_retry_transactions_seq  - Back-to-Back CopyBack CHI Transactions to Same/Overlapping Address with AllowRetry de-asserted
   *  .
   */
  covergroup trans_consecutive_copyback_transaction_sequence @(copyback_transaction_event);
    type_option.comment = "Coverage for consecutive different different CopyBack CHI transactions";
    option.per_instance = 1;
    copyback_transaction_sequence : coverpoint this.copyback_transaction_sequence {

      // Consecutive CopyBack Transactions Scenario Combination
      bins  consecutive_copyback_transactions_seq                                            = {`SVT_CHI_BACK2BACK_COPYBACK_TRANSACTION_PATTERN_SEQ};
      bins  consecutive_copyback_transactions_seq_w_same_or_overlapping_addr                 = {`SVT_CHI_BACK2BACK_COPYBACK_TRANS_W_SAME_OR_OVERLAPPING_ADDR_PATTERN_SEQ};
      bins  consecutive_copyback_w_same_or_overlapping_addr_w_allow_retry_transactions_seq   = {`SVT_CHI_BACK2BACK_COPYBACK_TRANS_W_SAME_OR_OVERLAPPING_ADDR_W_ALLOW_RETRY_PATTERN_SEQ};
      bins  consecutive_copyback_w_same_or_overlapping_addr_wo_allow_retry_transactions_seq  = {`SVT_CHI_BACK2BACK_COPYBACK_TRANS_W_SAME_OR_OVERLAPPING_ADDR_WO_ALLOW_RETRY_PATTERN_SEQ};

    }
  endgroup


  /**
   * @groupname CHI_SCENARIO_COVERAGE_RETRY_OR_CANCEL_TRANSACTION_SEQUENCE
   *  Coverage group for covering the retry/cancel CHI transaction between/after Normal CHI Transactions of Same TxnID<br>
   *
   *  Covergroup : trans_retry_or_cancel_transaction_sequence<br>
   *  Coverpoints: retry_or_cancel_transaction_sequence<br>
   *
   *  Bins:
   *  - xact_1_followed_by_retry_xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq                - Transaction#1 Followed by Retried Transaction#1 of same/diff TxnID Followed by Transaction#2 of same TxnID as of Transaction#1
   *  - xact_1_followed_by_retry_xact_1_of_same_txnid_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq  - Transaction#1 Followed by Retried Transaction#1 of same TxnID Followed by Transaction#2 of same TxnID as of Transaction#1
   *  - xact_1_followed_by_retry_xact_1_of_diff_txnid_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq  - Transaction#1 Followed by Retried Transaction#1 of different TxnID Followed by Transaction#2 of same TxnID as of Transaction#1
   *  - xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_transactions_seq                - Transaction#1 Followed by Transaction#2 of same TxnID as of Transaction#1 Followed by Retried Transaction#1 of same/diff TxnID
   *  - xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_of_same_txnid_transactions_seq  - Transaction#1 Followed by Transaction#2 of same TxnID as of Transaction#1 Followed by Retried Transaction#1 of same TxnID
   *  - xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_of_diff_txnid_transactions_seq  - Transaction#1 Followed by Transaction#2 of same TxnID as of Transaction#1 Followed by Retried Transaction#1 of different TxnID
   *  - xact_1_followed_by_cancel_xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq               - Transaction#1 Followed by Cancelled Transaction#1 Followed by Transaction#2 of same TxnID as of Transaction#1
   *  - xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_cancel_xact_1_transactions_seq               - Transaction#1 Followed by Transaction#2 of same TxnID as of Transaction#1 Followed by Cancelled Transaction#1
   *  .
   */
  covergroup trans_retry_or_cancel_transaction_sequence @(retry_or_cancel_transaction_event);
    type_option.comment = "Coverage for retry/cancel CHI transaction between/after CHI Transaction of same TxnID";
    option.per_instance = 1;
    retry_or_cancel_transaction_sequence : coverpoint this.retry_or_cancel_transaction_sequence {

      // Retry/Cancel Transaction between/after two Normal CHI Transactions of same TxnID Scenario Combination
      bins  xact_1_followed_by_retry_xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq                = {`SVT_CHI_RETRY_TRANS_BETWEEN_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_retry_xact_1_of_same_txnid_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq  = {`SVT_CHI_RETRY_TRANS_W_SAME_TXNID_BETWEEN_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_retry_xact_1_of_diff_txnid_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq  = {`SVT_CHI_RETRY_TRANS_W_DIFF_TXNID_BETWEEN_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_transactions_seq                = {`SVT_CHI_RETRY_TRANS_AFTER_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_of_same_txnid_transactions_seq  = {`SVT_CHI_RETRY_TRANS_W_SAME_TXNID_AFTER_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_retry_xact_1_of_diff_txnid_transactions_seq  = {`SVT_CHI_RETRY_TRANS_W_DIFF_TXNID_AFTER_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_cancel_xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_transactions_seq               = {`SVT_CHI_CANCELLED_TRANS_BETWEEN_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
      bins  xact_1_followed_by_xact_2_with_same_txn_id_as_xact_1_followed_by_cancel_xact_1_transactions_seq               = {`SVT_CHI_CANCELLED_TRANS_AFTER_TWO_NORMAL_TRANSACTIONS_OF_SAME_TXNID_PATTERN_SEQ};
    }
  endgroup


  /**
   * @groupname CHI_SCENARIO_COVERAGE_DVM_OPERATION_TRANSACTION_SEQUENCE
   *  Coverage group for covering the CHI DVM Operation transactions scenario sequences<br>
   *  The new Range Based DVM TLBI operations as well as DVM TLBI operations with Leaf Hint, introduced in the CHI-E specifiction, are 
   *  included in the scenarios captured in this Covergroup.
   *
   *  Covergroup : trans_dvm_operation_transaction_sequence<br>
   *  Coverpoints: dvm_operation_transaction_sequence<br>
   *
   *  Bins:
   *  - dvmop_tlbi_xact_followed_by_sync_xact_transactions_seq                                                                                                                                                                                         - DVMOp TLBI Transaction   Followed by DVMOp Synchronization Transaction
   *  - dvmop_tlbi_xact_followed_by_sync_xact_with_same_lpid_transactions_seq                                                                                                                                  
   *    - DVMOp TLBI Transaction Followed by DVMOp Synchronization Transaction with the same LPID
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 with the same LPID as Transaction#1 is issued by the RN.
   *      - DVMOp Sync Transaction#2 completes.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      .
   *    .
   *  - dvmop_tlbi_xact_followed_by_sync_xact_with_different_lpid_transactions_seq
   *    - DVMOp TLBI Transaction   Followed by DVMOp Synchronization Transaction with different LPID.
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 with a different LPID is issued by the RN.
   *      - DVMOp Sync Transaction#2 completes.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      .
   *    .
   *  - dvmop_tlbi_xact_outstanding_followed_by_sync_xact_with_same_lpid_transactions_seq
   *    - Outstanding DVMOp TLBI Transaction Followed by DVMOp Synchronization Transaction with the same LPID
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 with the same LPID is issued by the RN.
   *      - DVMOp Sync Transaction#2 completes.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      - svt_chi_node_configuration::dvm_sync_transmission_policy must be set to DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE.
   *      .
   *    .
   *  - dvmop_tlbi_xact_outstanding_followed_by_sync_xact_with_different_lpid_transactions_seq
   *    - Outstanding DVMOp TLBI Transaction   Followed by DVMOp Synchronization Transaction with different LPID
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 with a different LPID is issued by the RN.
   *      - DVMOp Sync Transaction#2 completes.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      - svt_chi_node_configuration::dvm_sync_transmission_policy must be set to either WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE or DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_followed_by_tlbi_xact_2_followed_by_sync_xact_transactions_seq                                                                                                                                                               - DVMOp TLBI Transaction#1 Followed by DVMOp TLBI Transaction#2 Followed by DVMOp Synchronization Transaction
   *  - dvmop_tlbi_xact_1_followed_by_retry_tlbi_xact_1_followed_by_sync_xact_2_followed_by_retry_sync_xact_2_transactions_seq                                                                                                                         - DVMOp TLBI Transaction#1 Followed by Retried DVMOp TLBI Transaction#1 Followed by DVMOp Synchronization Transaction#2 Followed by Retried DVMOp Synchronization Transaction#2
   *  - dvmop_tlbi_xact_1_followed_by_cancel_tlbi_xact_1_followed_by_tlbi_xact_2_with_same_txn_id_as_tlbi_xact_1_followed_by_sync_xact_3_followed_by_cancel_sync_xact_3_followed_by_sync_xact_4_with_same_txn_id_as_sync_xact_3_transactions_seq       - DVMOp TLBI Transaction#1 Followed by Cancelled DVMOp TLBI Transaction#1 Followed by DVMOp TLBI Transaction#2 of same TxnID as of Transaction#1 Followed by DVMOp Synchronization Transaction#3 Followed by Cancelled DVMOp Synchronization Transaction#3 Followed by DVMOp Synchronization Transaction#4 of same TxnID as of Transaction#3
   *  - dvmop_tlbi_xact_1_followed_by_sync_xact_2_followed_by_sync_xact_3_followed_by_tlbi_xact_4_transactions_seq                                                                                                                                     - DVMOp TLBI Transaction#1 Followed by DVMOp Synchronization Transaction#2 Followed by DVMOp Synchronization Transaction#3 Followed by DVMOp TLBI Transaction#4
   *  - dvmop_tlbi_xact_1_followed_by_cancel_tlbi_xact_1_followed_by_non_dvmop_xact_2_with_same_txn_id_as_tlbi_xact_1_followed_by_sync_xact_3_followed_by_cancel_sync_xact_3_followed_by_sync_xact_4_with_same_txn_id_as_sync_xact_3_transactions_seq  - DVMOp TLBI Transaction#1 Followed by Cancelled DVMOp TLBI Transaction#1 Followed by Non DVMOp Transaction#2 of same TxnID as of Transaction#1 Followed by DVMOp Synchronization Transaction#3 Followed by Cancelled DVMOp Synchronization Transaction#3 Followed by DVMOp Synchronization Transaction#4 of same TxnID as of Transaction#3
   *  - dvmop_tlbi_xact_followed_by_cmo_xact_followed_by_sync_xact_transactions_seq                                                                                                                                                                    - DVMOp TLBI Transaction   Followed by CMO Transaction Followed by DVMOp Synchronization Transaction
   *  - dvmop_tlbi_xact_1_followed_by_cmo_xact_followed_by_tlbi_xact_2_followed_by_sync_xact_transactions_seq                                                                                                                                          - DVMOp TLBI Transaction#1 Followed by CMO Transaction Followed by DVMOp TLBI Transaction#2 Followed by DVMOp Synchronization Transaction
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_followed_by_retry_sync_xact_2_transactions_seq  
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp Sync Transaction#2 while Transaction#1 is outstanding Followed by Retry DVMOp Sync Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp Sync Transaction#2 is issued by the RN.
   *      - DVMOp Sync Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      - svt_chi_node_configuration::dvm_sync_transmission_policy must be set to either WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE or DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_with_same_lpid_followed_by_retry_sync_xact_2_transactions_seq
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp Sync Transaction#2 with the same LPID while Transaction#1 is outstanding Followed by Retry DVMOp Sync Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp Sync Transaction#2 with the same LPID is issued by the RN.
   *      - DVMOp Sync Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      - svt_chi_node_configuration::dvm_sync_transmission_policy must be set to DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_with_diff_lpid_followed_by_retry_sync_xact_2_transactions_seq
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp Sync Transaction#2 with a different LPID while Transaction#1 is outstanding Followed by Retry DVMOp Sync Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp Sync Transaction#2 with a different LPID is issued by the RN.
   *      - DVMOp Sync Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp Sync Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      - svt_chi_node_configuration::dvm_sync_transmission_policy must be set to either WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE or DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_followed_by_retry_tlbi_xact_2_transactions_seq
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp TLBI Transaction#2 while Transaction#1 is outstanding Followed by Retry DVMOp TLBI Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp TLBI Transaction#2 is issued by the RN.
   *      - DVMOp TLBI Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp TLBI Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_with_same_lpid_followed_by_retry_tlbi_xact_2_transactions_seq
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp TLBI Transaction#2 with the same LPID while Transaction#1 is outstanding Followed by Retry DVMOp TLBI Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp TLBI Transaction#2 with the same LPID is issued by the RN.
   *      - DVMOp TLBI Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp TLBI Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      .
   *    .
   *  - dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_with_diff_lpid_followed_by_retry_tlbi_xact_2_transactions_seq
   *    - DVMOp TLBI Transaction#1 Followed by DVMOp TLBI Transaction#2 with different LPID while Transaction#1 is outstanding Followed by Retry DVMOp TLBI Transaction#2
   *    - Following is the scenario that is covered by this bin:
   *      - DVMOp TLBI Transaction#1 is issued by the RN.
   *      - While Transaction#1 is outstanding, DVMOp TLBI Transaction#2 with a different LPID is issued by the RN.
   *      - DVMOp TLBI Transaction#2 gets a RETRYACK.
   *      - DVMOp TLBI Transaction#1 completes.
   *      - DVMOp TLBI Transaction#2 is retried.
   *      .
   *    - The node configuration must be programmed as follows in order to generate this scenario:
   *      - svt_chi_node_configuration::dvm_enable must be set to 1.
   *      .
   *    .
   *  .
   */
  covergroup trans_dvm_operation_transaction_sequence @(dvm_operation_transaction_event);
    type_option.comment = "Coverage for CHI DVM Operation transaction scenario sequences";
    option.per_instance = 1;
    dvmop_transaction_sequence : coverpoint this.dvm_operation_transaction_sequence {

      // DVM Operation Scenario Sequences
      bins  dvmop_tlbi_xact_followed_by_sync_xact_transactions_seq                                                                                                                                                                                         = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_followed_by_sync_xact_with_same_lpid_transactions_seq                                                                                                                                                                                         = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_SAME_LPID};
      bins  dvmop_tlbi_xact_followed_by_sync_xact_with_different_lpid_transactions_seq                                                                                                                                                                                         = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_DIFF_LPID};
      bins  dvmop_tlbi_xact_outstanding_followed_by_sync_xact_with_same_lpid_transactions_seq                                                                                                                                                                                         = {`SVT_CHI_OUTSTANDING_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_SAME_LPID};
      bins  dvmop_tlbi_xact_outstanding_followed_by_sync_xact_with_different_lpid_transactions_seq                                                                                                                                                                                         = {`SVT_CHI_OUTSTANDING_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_DIFF_LPID};
      bins  dvmop_tlbi_xact_1_followed_by_tlbi_xact_2_followed_by_sync_xact_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_followed_by_retry_tlbi_xact_1_followed_by_sync_xact_2_followed_by_retry_sync_xact_2_transactions_seq                                                                                                                         = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_RETRY_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_FOLLOWED_BY_RETRY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_followed_by_cancel_tlbi_xact_1_followed_by_tlbi_xact_2_with_same_txn_id_as_tlbi_xact_1_followed_by_sync_xact_3_followed_by_cancel_sync_xact_3_followed_by_sync_xact_4_with_same_txn_id_as_sync_xact_3_transactions_seq       = {`SVT_CHI_TLBI_FOLLOWED_BY_CANCEL_TLBI_FOLLOWED_BY_TLBI_OF_SAME_TXNID_FOLLOWED_BY_SYNC_FOLLOWED_BY_CANCEL_SYNC_FOLLOWED_BY_SYNC_OF_SAME_TXNID_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_followed_by_sync_xact_2_followed_by_sync_xact_3_followed_by_tlbi_xact_4_transactions_seq                                                                                                                                     = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_FOLLOWED_BY_DVMOP_SYNC_PFOLLOWED_BY_DVMOP_TLBI_ATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_followed_by_cancel_tlbi_xact_1_followed_by_non_dvmop_xact_2_with_same_txn_id_as_tlbi_xact_1_followed_by_sync_xact_3_followed_by_cancel_sync_xact_3_followed_by_sync_xact_4_with_same_txn_id_as_sync_xact_3_transactions_seq  = {`SVT_CHI_TLBI_FOLLOWED_BY_CANCEL_TLBI_FOLLOWED_BY_NON_DVMOP_OF_SAME_TXNID_FOLLOWED_BY_SYNC_FOLLOWED_BY_CANCEL_SYNC_FOLLOWED_BY_SYNC_OF_SAME_TXNID_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_followed_by_cmo_xact_followed_by_sync_xact_transactions_seq                                                                                                                                                                    = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_CMO_FOLLOWED_BY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_followed_by_cmo_xact_followed_by_tlbi_xact_2_followed_by_sync_xact_transactions_seq                                                                                                                                          = {`SVT_CHI_DVMOP_TLBI_FOLLOWED_BY_CMO_FOLLOWED_BY_DVMOP_TLBI_FOLLOWED_BY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_followed_by_retry_sync_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_SYNC_FOLLOWED_BY_RETRY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_with_same_lpid_followed_by_retry_sync_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_SYNC_WITH_SAME_LPID_FOLLOWED_BY_RETRY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_sync_xact_2_with_diff_lpid_followed_by_retry_sync_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_SYNC_WITH_DIFF_LPID_FOLLOWED_BY_RETRY_DVMOP_SYNC_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_followed_by_retry_tlbi_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_TLBI_FOLLOWED_BY_RETRY_DVMOP_TLBI_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_with_same_lpid_followed_by_retry_tlbi_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_TLBI_WITH_SAME_LPID_FOLLOWED_BY_RETRY_DVMOP_TLBI_PATTERN_SEQ};
      bins  dvmop_tlbi_xact_1_outstanding_followed_by_tlbi_xact_2_with_diff_lpid_followed_by_retry_tlbi_xact_2_transactions_seq                                                                                                                                                               = {`SVT_CHI_DVMOP_TLBI_OUTSTANDING_FOLLOWED_BY_DVMOP_TLBI_WITH_DIFF_LPID_FOLLOWED_BY_RETRY_DVMOP_TLBI_PATTERN_SEQ};
    }
  endgroup


  /**
   * @groupname CHI_SCENARIO_COVERAGE_EXCLUSIVE_ACCESSES_PAIR_TRANSACTION_SEQUENCE
   *  Coverage group for covering the CHI Exclusive Accesses Sequence Pair transactions scenario sequences<br>
   *  The exclusive Load and Store transaction introduced in the CHI-E specification are also included in this covergroup.
   *  Covergroup : trans_exclusive_accesses_pair_transaction_sequence<br>
   *  Coverpoints: exclusive_accesses_pair_transaction_sequence<br>
   *
   *  Bins:
   *  - exclusive_accesses_sequence_pair_transactions_seq                                                       - Exclusive Accesses Sequence Pair Transaction
   *  - exclusive_accesses_sequence_pair_with_diff_memory_attribute_transactions_seq                            - Exclusive Accesses Sequence Pair Transaction with different memory attributes
   *  - exclusive_accesses_sequence_pair_with_same_memory_attribute_transactions_seq                            - Exclusive Accesses Sequence Pair Transaction with same memory attributes
   *  - exclusive_accesses_sequence_pair_with_diff_snoop_attribute_transactions_seq                             - Exclusive Accesses Sequence Pair Transaction with different snoop attributes
   *  - exclusive_accesses_sequence_pair_interleaved_by_another_exclusive_store_transaction_seq                 - Exclusive Accesses Sequence Pair interleaved by another Exclusive Store Transaction
   *  - exclusive_accesses_sequence_pair_interleaved_by_another_exclusive_store_from_diff_lpid_transaction_seq  - Exclusive Accesses Sequence Pair interleaved by another Exclusive Store Transaction from differnt LPID
   *  .
   */
  covergroup trans_exclusive_accesses_pair_transaction_sequence @(exclusive_accesses_transaction_event);
    type_option.comment = "Coverage for CHI Exclusive Accesses transaction scenario sequences";
    option.per_instance = 1;
    excl_accesses_transaction_sequence : coverpoint this.exclusive_accesses_pair_transaction_sequence {

      // Exclusive Accesses Sequence Pair Scenario
      bins  exclusive_accesses_sequence_pair_transactions_seq                                                       = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_PATTERN_SEQ};
      bins  exclusive_accesses_sequence_pair_with_diff_memory_attribute_transactions_seq                            = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_WITH_DIFF_MEMORY_ATTRIBUTE_PATTERN_SEQ};
      bins  exclusive_accesses_sequence_pair_with_same_memory_attribute_transactions_seq                            = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_WITH_SAME_MEMORY_ATTRIBUTE_PATTERN_SEQ};
      bins  exclusive_accesses_sequence_pair_with_diff_snoop_attribute_transactions_seq                             = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_WITH_DIFF_SNOOP_ATTRIBUTE_PATTERN_SEQ};
      bins  exclusive_accesses_sequence_pair_interleaved_by_another_exclusive_store_transaction_seq                 = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_INTERLEAVED_BY_ANOTHER_EXCL_STORE_PATTERN_SEQ};
      bins  exclusive_accesses_sequence_pair_interleaved_by_another_exclusive_store_from_diff_lpid_transaction_seq  = {`SVT_CHI_EXCLUSIVE_ACCESSES_SEQUENCE_PAIR_INTERLEAVED_BY_ANOTHER_EXCL_STORE_FROM_DIFF_LPID_PATTERN_SEQ};
    }
  endgroup



  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_chi_scenario_coverage instance.
   *
   * @param cfg Configuration handle.
   * @param name Instance name.
   * @param log VMM Log instance used for reporting.
    */
  extern function new(svt_chi_node_configuration  cfg, string  name = "", vmm_log  log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_chi_scenario_coverage instance.
   *
   * @param cfg Configuration handle.
   * @param name Instance name.
   */
  extern function new(svt_chi_node_configuration  cfg, string  name = "");

  /** SVT message macros route messages through this reference */
  protected `SVT_XVM(report_object)  reporter;
`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V1K2LVsIyKnYD/sDBZ/tlq0qdFHE3ne6IkTeds2eg1Hx8UKt9sV+mGXHI3QcwKYA
s5QmKsTh1CSntkFN/7Nzi7vfKkFqRhP4qaa1/DinS3u48IMpWO06YE9JENrhDiig
S6kVjc9JotxEcDCsaznlMAaUSHLSGvRqKXWc9Z0wqaU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3105      )
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
`pragma protect end_protected

`endif //GUARD_SVT_CHI_SCENARIO_COVERAGE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HqCUrv9R2WaEivFl+714efDp+9gI8Zo/cReFc+lFR7Bwq9FVTgQPgmkReanEV8Sr
Yyg68DhSZmW4wyogUFusy0EPyjnyBRKvdjcbvplWAJmjIozQGkg8pMsmbaZnS3QX
AtGdbY+FP2jaLMZkWbtmYBrlnD/UE3AdlQsnhLxytiQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3188      )
EoLo/mJHnEUHUWc6iWUgBIjt009HU0MUfAiEzQTJzqgOidu09rliWGoYmE7LZDaN
sPF+b0vGi0MM77HTp8+ZXp1T0wl0pA5ZpH/JlJrnHkzoBZnBfQQCkLlr0GmQ09Z9
`pragma protect end_protected
