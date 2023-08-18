

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JzktQlZSM3d7p41HzD8OUJqI0HAAidSOcSQs9pGPynOYQSA8SbGfk4wbQUDoJUYu
s7N1GaNtLkIV3sl2f9cYuluyLV25PRDBWVgW3OQqvg3z/23WdwNicXMGjZjPP6AE
g1iRZ8xppyCxpk56Ktbwg1BMVZ0mnqKx7uyrBAMI/ba/PJvPsc0QWA==
//pragma protect end_key_block
//pragma protect digest_block
GoKhtzYZTs6oxD65hiq95CkLx2Y=
//pragma protect end_digest_block
//pragma protect data_block
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
3MScfcH5cpaeL+uu0ZqitQ==
//pragma protect end_data_block
//pragma protect digest_block
V8204bXtNVba/hTCPEy0QlHqjiM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //GUARD_SVT_CHI_SCENARIO_COVERAGE_SV
