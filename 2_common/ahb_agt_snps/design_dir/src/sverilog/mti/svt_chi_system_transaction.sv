//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef SVT_CHI_SYSTEM_TRANSACTION_SV
`define SVT_CHI_SYSTEM_TRANSACTION_SV

/** @cond PRIVATE */
/** CHI system transaction that is used by system monitor and VIP interconnect
 */
typedef real snooped_master_response_gen_time_t[];

class svt_chi_system_transaction extends `SVT_TRANSACTION_TYPE;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_transaction)
    local static vmm_log shared_log = new("svt_chi_system_transaction", "class" );
  `endif

  /**
   * Enum to represent the coherent transaction type. Applicable when
   * svt_axi_port_configuration::axi_interface_type is set to AXI_ACE.
   */
  typedef enum {
    NO_ACTION                         = 0,
    NO_ASSOCIATION                    = 1,
    ASSOCIATION_BUT_NO_CHECKS         = 2
  } action_enum;

  /** The system configuration handle corresponding to the system that the Requester is part of*/
  svt_chi_system_configuration sys_cfg;

  /** The system configuration handle corresponding to the system that the target Home node is part of*/
  svt_chi_system_configuration hn_sys_cfg;

  /** Handle to transaction received from a RN port */
  svt_chi_transaction rn_xact;

  /** Handle to original AXI master transaction */
  svt_axi_master_transaction original_axi_master_xact;
  
  /** Handle to transaction sent to SN port */
  svt_chi_rn_transaction sn_xacts[$];

  /** Handle of associated SN transaction */
  svt_chi_transaction associated_sn_xacts[$];
  
  /** Handle of associated AXI lsave transaction */
  svt_axi_transaction associated_axi_slave_xacts[$];

  /** Store the associated slaves byte count.
   * Currently it is used for RN xacts whose parent is AXI xact with burst_type is Wrap.
   */
  int associated_slave_byte_count = 0;

  /** Indicates rn bytes are equal to associated slaves bytes.
   * Currently it is used for RN xacts whose parent is AXI xact with burst_type is Wrap.
   */
  bit rn_slave_byte_count_matched = 0;

  /** 
    * When the chi_interface_type is CHI_ACE, rn_xact
    * represents a coherent transaction received from the RN. In this case,
    * if snoop transactions were sent to other RNs corresponding to this
    * coherent transaction, #associated_snoop_xacts stores the associated snoop
    * transactions.
    */
  svt_chi_snoop_transaction associated_snoop_xacts[$];
  
  /** @cond PRIVATE */
  
  /** Handle to RN transaction observed between L1-ICN and L2-ICN interface */
  svt_chi_transaction propagated_outbound_rn_xact;
  
  /** Handle to snoop transaction observed between L2-ICN and L1-ICN interface */
  svt_chi_snoop_transaction propagated_inbound_snoop_xact;
  
  /** @endcond */

  /* Holds associated snoop xact type final state which it has data transfer */
  svt_chi_transaction::cache_state_enum snoop_resp_final_state = svt_chi_snoop_transaction::I;

`ifdef SVT_CHI_ISSUE_C_ENABLE
 //Stash updates
 /** 
   * Indicates the data response received is CompData or RespSepData , for
   * the Data Pull read response sent for the Stash Type Snoop involving DataPull.
   * Set to 1 when RespSepData is used.
   */
  bit stash_snpresp_datapull_read_dataresp_is_respsepdata_datasepresp_flow_used = 0;
`endif  

`ifdef SVT_CHI_ISSUE_B_ENABLE
 //Stash updates
 /** 
   * Holds associated stash snoop xact type , this will take a valid value only when are_associate_stashsnoops_present is set.
   * When are_associate_stashsnoops_present is zero , this field will take a default value of SNPSHARED. 
   */
  svt_chi_snoop_transaction::snp_req_msg_type_enum associated_stashsnoop_xacts_type = svt_chi_snoop_transaction::SNPSHARED;

 /**
   * Holds associated nonstash snoop xact type , this will take a valid value only when nonstashtype_associated_snp_present is set.
   * When nonstashtype_associated_snp_present is zero , this field will take a default value of SNPSHARED. 
   */
  svt_chi_snoop_transaction::snp_req_msg_type_enum associated_nonstash_snoop_xact_type = svt_chi_snoop_transaction::SNPSHARED;

  /* Handle used to store the stash snoop xact corresponding to coherent stash */
  svt_chi_snoop_transaction reference_stash_snoop_xact;

  /* Handle used to store the stash snoop xact corresponding to non coherent stash */
  svt_chi_snoop_transaction reference_nonstash_snoop_xact;

 /** 
   * Holds the final cache state set in the Resp field of CompData or RespSepData used for transmitting
   * the Data Pull read response sent for the Stash Type Snoop involving DataPull.
   */
  svt_chi_transaction::cache_state_enum stash_snpresp_datapull_read_dataresp_final_state = svt_chi_snoop_transaction::I;

  /* This bit is set when system transaction has associated nonstashsnoop xacts */
  bit nonstashtype_associated_snp_present = 0;

 /**
   * This bit is set when the Datapull is set in the snoop stash response
   * set to zero if stash_snpreq_donotdatapull is set to 1.
   */
  bit [(`SVT_CHI_DATA_PULL_WIDTH-1):0] stash_snpresp_datapull_read_resp = 3'b0;

 /** 
   * Indicates the CompData or RespSepData response received is from HN or SN, for
   * the Data Pull read response sent for the Stash Type Snoop involving DataPull.
   * Set to 1 when dmt is used.
   */
  bit stash_snpresp_datapull_read_dataresp_is_dmt_used = 0;

 /** 
   * Indicates the pass dirty response received along with CompData or RespSepData response received , for
   * the Data Pull read response sent for the Stash Type Snoop involving DataPull.
   * Set to 1 when Data pull read respnse has pass dirty asserted.
   */
  bit stash_snpresp_datapull_read_dataresp_passdirty = 0;

  /* This bit is set when the Do_not_data_pull is set in the snoop stash request by the HN */
  bit stash_snpreq_donotdatapull = 1'b0;

  /* This bit is set when system transaction has associated snoop stash xacts */
  bit are_associate_stashsnoops_present = 0;

  /* This bit is set when system transaction has associated stash snoop xact and it has pass dirty */
  bit stash_snoop_resp_PD = 0;

  /* This bit is set when system transaction has associated non stash snoop xact and it has pass dirty */
  bit nonstash_snoop_resp_PD = 0;

  /* This bit is set when system transaction has associated stash snoop xact and it has data transfer */
  bit stash_snoop_resp_has_data_xfer = 0;

  /* This bit is set when system transaction has associated nonstash snoop xact and it has data transfer */
  bit nonstash_snoop_resp_has_data_xfer = 0;

  /** 
    * When the chi_interface_type is CHI_ACE, rn_xact
    * represents a coherent transaction received from the RN. In this case,
    * if snoop transactions were sent to other RNs corresponding to this
    * coherent transaction, #associated_stashsnoop_xacts stores the associated stash snoop
    * transactions.
    */
  svt_chi_snoop_transaction associated_stashsnoop_xacts[$];

  /** 
    * When the chi_interface_type is CHI_ACE, rn_xact
    * represents a coherent transaction received from the RN. In this case,
    * if snoop transactions were sent to other RNs corresponding to this
    * coherent transaction, #associated_nonstashsnoop_xacts stores the associated nonstash snoop
    * transactions.
    */
  svt_chi_snoop_transaction associated_nonstashsnoop_xacts[$];

`endif

  /* This bit is set when system transaction has associated snoop xacts */
  bit are_associate_snoops_present = 0;

  /* Holds associated snoop xact type which it has data transfer */
  svt_chi_transaction::snp_req_msg_type_enum associated_snoop_xacts_type;

  /* This bit is set when system transaction has associated snoop xact and it has pass dirty */
  bit snoop_resp_PD = 0;

  /* This bit is set when system transaction has associated snoop xact and it has data transfer */
  bit snoop_resp_has_data_xfer;

  /* This bit is set when system transaction has associated snoop xact and it has partial data transfer */
  bit snoop_resp_has_partial_data;

  /**
    * If chi_interface_type is CHI_ACE and rn_xact is a DVM Sync
    * transaction, this variable represents all the dvm operations
    * associated with it
    */
  svt_chi_transaction associated_dvm_operation_xacts[$];

  /**
    * If chi_interface_type is CHI_ACE, this variable represents
    * the snoop addresses expected to be sent on each port for rn_xact
    * Currently used only for READONCE and WRITEUNIQUE transaction because
    * these can span across multiple cache lines
    */
  bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] expected_snoop_addr[$];

  /** @cond PRIVATE */
  /**
    * Used by the interconnect
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating RN. This field
    * indicates the split transactions of such a transaction.
    */
  svt_chi_ic_sn_transaction assoc_split_xacts[$];

  /**
    * When a READONCE or WRITEUNIQUE transaction is received by the interconnect
    * it splits the transaction internally and processes it since these
    * transactions can span multiple cachelines. Each split transaction is
    * processed independently and once responses for each are received, a
    * consolidated reponse is sent back to the initiating RN. This field
    * indicates the parent transaction from which this transaction was split.
    */
  svt_chi_ic_sn_transaction assoc_parent_xact;

  /** Internal queue to store transactions which are already in-progress when current
    * RN transaction started */
  svt_chi_transaction xacts_started_before_curr_xact_queue[$];

  /** Internal queue to store coherent transacions issued by RNs while current RN
    * transaction is in progress */
  svt_chi_transaction xacts_started_after_curr_xact_queue[$];

  /** Internal queue to store system transaction handles corresponding to coherent transacions 
    * issued by RNs before current RN transaction */
  svt_chi_system_transaction sys_xacts_started_before_curr_xact_queue[$];

  /** Internal queue to store system transacion handles corresponding to coherent transactions 
    * issued by RNs while current RN transaction is in progress */
  svt_chi_system_transaction sys_xacts_started_after_curr_xact_queue[$];

  /** Internal queue of snoop transactions which are in progress while current master transaction is in progress */
  svt_chi_snoop_transaction snoop_xacts_started_before_curr_xact_queue[$];

  /** Internal queue of snoop transactions which started after current master transaction started */
  svt_chi_snoop_transaction snoop_xacts_started_after_curr_xact_queue[$];


  /** 
    * Usually, the system monitor associates a snoop to coherent when the response to
    * the coherent is received. However, in some circumstances, when two ports have sent
    * transactions to the same address and one of the ports involved is an ACE-LITE port,
    * transaction sequencing(the coherent whose snoop is sent first, gets the response first)
    * may not be maintained. In such cases, the System Monitor collects partial association
    * information. This is stored here.
    */
  svt_chi_snoop_transaction partial_associated_snoop_xacts[$];

  /**
    * Stores coherent transactions because of which a second snooping of ports may 
    * be done. This may be required if a store to a cachline happens after snooping
    * a port and before sending a response back to the original transactions that
    * requested the information. This typically happens if the original transaction
    * is from an ACE-LITE port (say READONCE) and targets multiple cachelines, some
    * of which are present in the peer caches and others which are not. By the time,
    * all peer caches are snooped and data is retreived from memory, a second snoop
    * may be required.
    */
  svt_chi_transaction coh_stores_subsequent_to_first_snoop[$];

  /**
    * If there are transactions in #coh_stores_subsequent_to_first_snoop, this
    * variable represents the snoops that were sent to retreive the data stored
    * in the caches. Basically, this represents a second snoop that may have
    * been sent.
    */
  svt_chi_snoop_transaction associated_second_snoop_to_same_port[$];

  /**
    * This variable indicates the time taken for the system transaction to complete 
    */
  real transaction_latency = -1;

  /**
    * This variable indicates the time taken by the HN to generate
    * the first Snoop request corresponding to the system transaction  
    */
  real snoop_request_gen_latency = -1;

  /**
    * This variable indicates the time taken by the HN to generate
    * the first Coherent response, after receving the last Snoop response
    * corresponding to the system transaction  
    */
  real snoop_response_to_coh_response_gen_latency = -1;

  /**
    * This variable indicates the time taken by the HN to generate
    * the first Coherent response, in case of L3 Cache hit  
    */
  real coh_response_gen_latency_for_l3_cache_hit = -1;

  /**
    * This variable indicates the time taken by the HN to generate
    * the first Coherent response, after completion of the Slave/Memory access transaction
    * corresponding to the system transaction  
    */
  real axi_mem_access_to_coh_rsp_gen_latency[];

  /**
    * This variable indicates the time taken by the HN to generate
    * the first Coherent response, after completion of the Slave/Memory access transaction
    * corresponding to the system transaction  
    */
  real sn_mem_access_to_coh_rsp_gen_latency[];

  /**
    * This variable indicates the time taken by each of the snooped RNs to generate
    * the Snoop response
    */
  real snooped_masters_response_gen_latency[];

  /**
    * This variable indicates the time consumed by the memory (SN/AXI slave)
    * Only valid if the HN issues write/read request to the memory
    */
  real axi_slave_xact_latency[];

  /**
    * This variable indicates the time consumed by the memory (SN/AXI slave)
    * Only valid if the HN issues write/read request to the memory
    */
  real sn_slave_xact_latency[];

  /**
    * This variable indicates the time taken by the HN to generate
    * the write/read request to the memory (AXI slave)  after receiving a Coherent request 
    */
  real axi_slave_req_gen_latency[];

  /**
    * This variable indicates the time taken by the HN to generate
    * the write/read request to the memory (AXI slave)  after receiving a Coherent request 
    */
  real sn_slave_req_gen_latency[];

  /**
    * An array where each element stores a string representing snoop data
    */ 
  string snoop_data_str[];

  /**
    * An array where each element stores a string representing snoop data
    * of a second snoop which may be sent to a port due to an intervening
    * store
    */ 
  string second_snoop_data_str[];

  /** String representing data in transaction */
  string coh_data_str;
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    /** String representing data poison in transaction */
    string coh_data_poison_str;

    /** String representing data datacheck in transaction */
    string coh_data_datacheck_str;

    /**
    * An array where each element stores a string representing snoop data poison
    */ 
    string snoop_data_poison_str[];

    /**
    * An array where each element stores a string representing snoop data datacheck
    */ 
    string snoop_data_datacheck_str[];
  `endif

  /** Associated Slave transaction string */
  string associated_axi_slave_xact_str[];
 
  /** Associated Slave transaction string */
  string associated_sn_slave_xact_str[];
 
  /** System transaction summary string */
  string summary_str = "";
  
  /** Indicates if there is a write transaction to an overlapping address in
    * progress before this * transaction got added to the queue
    */
  bit is_write_xact_before_curr_xact;

  /** Indicates if there is a write transaction to an overlapping address in
    * progress before this transaction got added to the queue, whose source
    *  is an ACE-LITE transaction
    */
  bit is_write_xact_before_curr_xact_parent_axi;

  /** Indicates if a write transaction to an overlapping address started after
   * this transaction got added to the queue
    */
  bit is_write_xact_after_curr_xact;

  /** Indicates if a write transaction to an overlapping address started after
   * this transaction got added to the queue, whose source is an ACE-LITE transaction.
    */
  bit is_write_xact_after_curr_xact_parent_axi;

  /** @endcond */

  /** Stores the aligned address to cache line size */
  bit [(`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1):0] aligned_addr_to_cache_line_size;

  /** node ID of RN that iniated the RN transaction */  
  bit [(`SVT_CHI_SRC_ID_WIDTH-1):0] rn_node_id = -1;
  
  /** node ID of HN that received the RN transaction */
  bit [(`SVT_CHI_SRC_ID_WIDTH-1):0] hn_node_id = -1;
  
  /** node ID of SN that received the SN transaction */
  bit [(`SVT_CHI_TGT_ID_WIDTH-1):0] sn_node_id[];
  
  /** node index of RN that iniated the RN transaction*/
  int                               rn_node_idx = -1;
  
  /** node index of HN that received the RN transaction*/
  int                               hn_node_idx = -1;
  
  /** node index of SN that received the SN transaction */
  int                               sn_node_idx[];
  
  /** port ID of AXI master that is mapped to rn_node_idx */
  int                               axi_master_port_id = -1;
  
  /** port ID of AXI slave that is mapped to sn_node_idx */
  int                               axi_slave_port_id[];

  /** Indicates if this transaction is targetted to SNs: Barriers are unsupported */
  bit                               is_slave_xact_association_applicable = 1;

  /** Indicates if this transaction results into snoops */
  bit                               is_snoop_xact_association_applicable = 1;

  /** Indicates if this transaction has mapped slave transaction or not */
  bit                               is_slave_xact_associated = 0;

  /** Indicates if the CMO rn xact have been mapped to all the slave CMO transaction(s) */
  bit                               is_cmos_associated = 0;

  /** Indicates if association of snoop to coherent is done */
  bit                               is_snoop_association_done = 0;

  /** Indicates if sn slave xact is associated after coherent xact is complete */
  bit                               is_sn_slave_xact_associated_after_coherent_xact_complete[];  

  /** Indicates if axi slave xact is associated after coherent xact is complete */
  bit                               is_axi_slave_xact_associated_after_coherent_xact_complete[];  

  /** Indicates start time of coherent response */
  realtime coherent_response_start_time_for_snoopable_req = -1;  

  /** indicates if associated slave xact is complete before coherent xact is complete */
  bit                               is_sn_associated_slave_xact_complete_before_coherent_xact_complete[];  

  /** indicates if associated slave xact is complete before coherent xact is complete */
  bit                               is_axi_associated_slave_xact_complete_before_coherent_xact_complete[];  

  /** Indicates if L3 access is valid for the system transaction */
  bit                               is_l3_access_applicable = 0;

  /** Indicate the L3 access type for the system transaction */
  svt_chi_hn_status::l3_access_type_enum               l3_access_type = svt_chi_hn_status::L3_ACCESS_NA;

  /** Indicate if snoop filter access is valid */
  bit                               is_snp_filter_access_applicable = 0;

  /** Indicate the snoop filter access type for the system transaction */
  svt_chi_hn_status::sf_access_type_enum               sf_access_type = svt_chi_hn_status::SF_ACCESS_NA;

  /** Indicate HN interface associated to  this  system transaction */
  svt_chi_address_configuration::hn_interface_type_enum hn_interface_type;


  /* bit to indicate if snoop response is associated with snoop data*/
  bit                               is_snp_resp_with_data = 0;

  /* maintains directory of cachelines for snoop filter operation */
  `ifdef SVT_AMBA_MULTI_CHIP_SYSTEM_MONITOR_INTERNAL_ENABLE
  svt_chi_transaction::cache_state_enum snoop_filter[][][*];
  `else
  svt_chi_transaction::cache_state_enum snoop_filter[][*];
  `endif

  /* SN indices to whom CMOs must be forwarded */
  int                               slaves_to_forward_cmos[$];

  /* SN indices to whom CMOs must be forwarded */
  int                               cmo_forwarded_port_ids[$];

  /* holds initial cacheline state for snoop filtering */
  svt_chi_transaction::cache_state_enum  initial_cacheline_state[*];

  /* indicates if a master port is expected to be snooped based on snoop filter status for a given address */
  `ifdef SVT_AMBA_MULTI_CHIP_SYSTEM_MONITOR_INTERNAL_ENABLE
  bit                               is_expected_snooped_port[][][*];
  `else
  bit                               is_expected_snooped_port[][*];
  `endif

  /** Indicates if self-snooping is expected for the RN transaction */
  bit                                 expect_self_snooping_for_req;

  /** Indicates the end-point address range index*/
  int                               ep_range_indx = -1;
  
  /** Indicates if system memory update is done.
   *  Currently it is applicable for the atomics transactions only. 
   */
  bit                               is_sys_mem_updated = 0;

  /** @cond PRIVATE */
  /** This field stores the sys memory data correspond to aligned address to cache line size.
   *  Currently it is applicable for the atomics transactions only.
   */
  bit[(`SVT_CHI_MAX_DATA_WIDTH-1):0] sys_mem_wysiwyg_data;

  /** This field stores the snapshot of the sys memory data when the transaction request was accepted
   *  This field is currently only applicable for Read type transactions.
   *  The data is aligned to the cache line aligned address.
   */
  bit[(`SVT_CHI_MAX_DATA_WIDTH-1):0] sys_mem_data_when_request_accepted;
     
  `ifdef SVT_CHI_ISSUE_B_ENABLE
  /** This field stores the snapshot of the sys memory Poison when the transaction request was accepted
   *  This field is currently only applicable for Read type transactions.
   *  The Poison is aligned to the cache line aligned address.
   */
  bit[(`SVT_CHI_MAX_POISON_WIDTH-1):0] sys_mem_poison_when_request_accepted;
  `endif

  /** Indicates if slave write transaction is expected based on atomic opereations performed.
   */
  bit                               expect_slave_write_xact = 0;

  /**
   * Indicates if system monitor summary is updated for the corresponding RN transaction.
   */
  bit                               is_summary_updated;

  /**
   * Indicates if system monitor checks related to hazards, snoop-coherent association and master-slave association must be bypassed for the transaction, in case of out of order interconnects.
   */
  int bypass_sys_checks_for_ooo_icn = -1;
  /** @endcond */

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /**
   * Expected SN indices to whom a RN Combined_Write_and_CMO must have a corresponding Slave transaction.
   * This is populated by CHI System Monitor after the reception of CHI RN xact, with slave node index's to which the Combined_Write_and_CMOs/Standalone Write transactions are propagated for a RN Combined_Write_and_CMO transaction.
   */
  int                               rn_combined_writecmo_propagation_expected_slaves[$];

  /** 
   * Actual SN indices to whom RN Combined_Write_and_CMO have a corresponding Slave transaction.
   * This is populated with Slave index's every time a Slave transaction is associated for the RN Combined_Write_and_CMO transaction.
   */
  int                               rn_combined_writecmo_propagated_actual_slaves[$];
  `endif

  // The below properties are needed for unique ID generation
  // Used for FSDB writer in case of VMM
`ifdef SVT_VMM_TECHNOLOGY
  local int my_inst_id;
  static protected int my_inst_count;
`endif

  
//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_chi_system_transaction");
`else
  `svt_vmm_data_new(svt_chi_system_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

  /** Set the RN transaction reference */
  extern function void set_rn_xact(svt_chi_transaction xact, svt_axi_transaction axi_xact, svt_chi_system_configuration target_hn_sys_cfg=null);
  
  /** Set the RN transaction reference */
  extern function void set_associated_sn_xact(svt_chi_transaction xact, string xact_str);

    /** Set the RN transaction reference */
  extern function void set_associated_axi_slave_xact(svt_axi_transaction xact, string xact_str);

  /**
   * get_transaction_latency: Get the Total Latency of the Transaction.
   */
  extern function void get_transaction_latency();

  /**
   * get_snoop_request_gen_latency: Get the time taken by the interconnect to generate the first Snoop request after receiving a Coherent request.
   */
  extern function void get_snoop_request_gen_latency();

  /**
   * get_snoop_response_to_coh_response_gen_latency: Time taken by the interconnect to generate a coherent response after receiving the last snoop response.
   */
  extern function void get_snoop_response_to_coh_response_gen_latency();

  /**
   * get_coh_rsp_gen_latency_for_l3_cache_hit: Time taken by the interconnect to generate a coherent response in case of L3 Cache hit 
   */
  extern function void get_coh_rsp_gen_latency_for_l3_cache_hit();

  /**
   * get_slave_req_gen_latency: Time taken by the interconnect to generate a Memory transaction after receiving a request from an RN.
   */
  extern function void get_slave_req_gen_latency();
  
  /**
   * get_mem_access_to_coh_rsp_gen_latency: Time taken by the interconnect to generate a coherent response after the completion of the Memory transaction.
   */
  extern function void get_mem_access_to_coh_rsp_gen_latency();

  /**
   * get_snooped_masters_response_gen_latency: Time taken by the snooped masters to generate a snoop response after receiving the snoop request.
   */
  extern function void get_snooped_masters_response_gen_latency();

  /**
   * get_slave_xact_latency: Time consumed by the SN/memory, latency at the Slave 
   */
  extern function void get_slave_xact_latency();

  /**
   * get_latency_metrics: Calls each of the latency performance calculation functions
   */
  extern function void get_latency_metrics();
 
  /**
   * update_snp_filter_events : Get snoop filter event [HIT/MISS] for all applicable Coherent requests.
   */
  extern function svt_chi_hn_status::sf_access_type_enum update_snp_filter_events();
    
  /**
   * update_is_snoop_filter_access_applicable: check if the current transaction [rn_xact] type is valid for snoop filter event count */

  extern function void update_is_snoop_filter_access_applicable();

  extern function bit is_error_response_received(bit ignore_data_error_resp = 0);

  /** Sets initial state of the cacheline(s) targeted by master_xact transaction.
    * Primary usage is to set INVALID or VALID state. However, other states like
    * UNIQUE_CLEAN, UNIQUE_DIRTY, SHARED_CLEAN, SHARED_DIRTY can also be assigned, if needed.
    *
    * By default, this method sets initial cacheline state only if snoop filter is enabled in any peer master.
    * Hoever, if skip_if_no_snoop_filter_is_enabled argument is passed as '0' then
    * it sets initial cacheline state irrespective whether any peer master has snoop filter
    * enabled or not.
    */
  extern function void set_initial_cacheline_state(bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] addr,
                           svt_chi_common_transaction::cache_state_enum cacheline_state = svt_chi_common_transaction::I,
                           bit skip_if_no_snoop_filter_is_enabled=1);

  /** Returns 1 if initial cacheline state for the specified address is VALID */
  extern function bit is_initial_cacheline_in_valid_state(bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] addr);

  /** Returns 1 if initial cacheline state for the specified address is INVALID */
  extern function bit is_initial_cacheline_in_invalid_state(bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] addr);

  /**
   * update_is_l3_access_applicable : check if the system transaction is valid for l3
   * cache access count
   * */
  extern function void update_is_l3_access_applicable();
  
  /**
   * update_l3_access_events: Get L3 cache access event [HIT/MISS] for all applicable transactions.
   */
  extern function svt_chi_hn_status::l3_access_type_enum update_l3_access_events();

  /** Dump L3, SF and latency metrics as PA object into XML writer */
  extern function string dump_l3_sf_latency_metrics_into_fsdb(svt_xml_writer xml_writer);

  /** In case of out of order interconnects, indicates if there are hazard RN transactions and at least one of the hazard transactions' completing flit is sent by the Interconnect */
  extern function int detect_hazards_for_ooo_interconnect();
    
  `svt_data_member_begin(svt_chi_system_transaction)
    `svt_field_object(sys_cfg,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(hn_sys_cfg,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(rn_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(original_axi_master_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(propagated_outbound_rn_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(propagated_inbound_snoop_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(sn_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_sn_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_axi_slave_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
`ifdef SVT_CHI_ISSUE_B_ENABLE
    `svt_field_queue_object(associated_stashsnoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_nonstashsnoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
`endif    
    `svt_field_queue_object(partial_associated_snoop_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(coh_stores_subsequent_to_first_snoop,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_second_snoop_to_same_port,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(associated_dvm_operation_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(assoc_split_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_object(assoc_parent_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_int(expected_snoop_addr,`SVT_ALL_ON)
    `svt_field_queue_int(slaves_to_forward_cmos,`SVT_ALL_ON)
    `svt_field_queue_int(cmo_forwarded_port_ids,`SVT_ALL_ON)
    `svt_field_int(is_write_xact_before_curr_xact,`SVT_ALL_ON)
    `svt_field_int(is_write_xact_before_curr_xact_parent_axi,`SVT_ALL_ON)
    `svt_field_int(is_write_xact_after_curr_xact,`SVT_ALL_ON)
    `svt_field_int(is_write_xact_after_curr_xact_parent_axi,`SVT_ALL_ON)
    `svt_field_int(rn_node_id,`SVT_ALL_ON)
    `svt_field_int(hn_node_id,`SVT_ALL_ON)
    `svt_field_array_int(sn_node_id,`SVT_ALL_ON)
    `svt_field_int(associated_slave_byte_count,`SVT_ALL_ON)
    `svt_field_int(rn_slave_byte_count_matched,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(rn_node_idx,`SVT_ALL_ON)
    `svt_field_int(hn_node_idx,`SVT_ALL_ON)
    `svt_field_array_int(sn_node_idx,`SVT_ALL_ON)
    `svt_field_int(aligned_addr_to_cache_line_size,`SVT_ALL_ON|`SVT_HEX)
    `svt_field_int(axi_master_port_id,`SVT_ALL_ON)
    `svt_field_int(ep_range_indx,`SVT_ALL_ON)
    `svt_field_array_int(axi_slave_port_id,`SVT_ALL_ON)
    `svt_field_int(is_l3_access_applicable,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_snp_filter_access_applicable,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_snp_resp_with_data,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(expect_self_snooping_for_req,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_slave_xact_association_applicable,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_snoop_xact_association_applicable,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_slave_xact_associated,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_cmos_associated,`SVT_ALL_ON|`SVT_BIN)
`ifdef SVT_CHI_ISSUE_B_ENABLE
    `svt_field_int(are_associate_snoops_present,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(nonstashtype_associated_snp_present,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(are_associate_stashsnoops_present,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snpresp_datapull_read_dataresp_is_dmt_used,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snoop_resp_PD,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(nonstash_snoop_resp_PD,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snoop_resp_has_data_xfer,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snpresp_datapull_read_resp,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snpresp_datapull_read_dataresp_passdirty,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(stash_snpreq_donotdatapull,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum(svt_chi_transaction::snp_req_msg_type_enum, associated_nonstash_snoop_xact_type, `SVT_ALL_ON)
`endif    
`ifdef SVT_CHI_ISSUE_C_ENABLE
    `svt_field_int(stash_snpresp_datapull_read_dataresp_is_respsepdata_datasepresp_flow_used,`SVT_ALL_ON|`SVT_BIN)
`endif
`ifdef SVT_CHI_ISSUE_E_ENABLE
    `svt_field_queue_int(rn_combined_writecmo_propagation_expected_slaves,`SVT_ALL_ON)
    `svt_field_queue_int(rn_combined_writecmo_propagated_actual_slaves,`SVT_ALL_ON)
`endif
    `svt_field_int(snoop_resp_PD,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(snoop_resp_has_partial_data,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(snoop_resp_has_data_xfer,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_sys_mem_updated,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(sys_mem_wysiwyg_data,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(sys_mem_data_when_request_accepted,`SVT_ALL_ON|`SVT_BIN)
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      `svt_field_int(sys_mem_poison_when_request_accepted,`SVT_ALL_ON|`SVT_BIN)
    `endif
    `svt_field_int(expect_slave_write_xact,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_summary_updated,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(bypass_sys_checks_for_ooo_icn,`SVT_ALL_ON)
    `svt_field_array_int(is_sn_slave_xact_associated_after_coherent_xact_complete,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_array_int(is_axi_slave_xact_associated_after_coherent_xact_complete,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_real(coherent_response_start_time_for_snoopable_req,`SVT_ALL_ON)
    `svt_field_array_int(is_sn_associated_slave_xact_complete_before_coherent_xact_complete,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_array_int(is_axi_associated_slave_xact_complete_before_coherent_xact_complete,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum(svt_chi_hn_status::l3_access_type_enum, l3_access_type, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_hn_status::sf_access_type_enum, sf_access_type, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_address_configuration::hn_interface_type_enum, hn_interface_type, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_transaction::snp_req_msg_type_enum, associated_snoop_xacts_type, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_transaction::cache_state_enum, snoop_resp_final_state, `SVT_ALL_ON)
    `svt_field_string(coh_data_str, `SVT_ALL_ON);
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    `svt_field_enum(svt_chi_transaction::cache_state_enum, stash_snpresp_datapull_read_dataresp_final_state, `SVT_ALL_ON)
    `svt_field_string(coh_data_poison_str, `SVT_ALL_ON);
    `svt_field_string(coh_data_datacheck_str, `SVT_ALL_ON);
  `endif  
    `svt_field_array_string(associated_sn_slave_xact_str, `SVT_ALL_ON);
    `svt_field_array_string(associated_axi_slave_xact_str, `SVT_ALL_ON);
    `svt_field_string(summary_str, `SVT_ALL_ON);
    
  `svt_data_member_end(svt_chi_system_transaction)

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging. */
  extern function string get_mcd_class_name ();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /** Allocates a new object of type svt_chi_system_transaction. */
  extern virtual function vmm_data do_allocate ();
  // ---------------------------------------------------------------------------
  /**
   * This method can be used to obtain a unique identifier for a data object.
   *
   * @return Unique identifier for the object.
   */
  extern virtual function string get_uid();
  
  `vmm_class_factory(svt_chi_system_transaction);
`endif
endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
it5KVor6g3whE7XVKcH/Q+26+oiaVwRUEKFCNARoI/6wjRLuNdZaqmDoHzj9loRP
cyl6m4q8jbBuUhZS8Zj8WmTGJ+4Aaf8xPMo0VBI/DJqZFTvlB/HCGprZTw3igpl3
5TjoiLFPF7qi9DHlh4e8HPivmu9MWurPYDYOpNIkIl0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 484       )
qcB2UbZyc05VZg0AivM0Tv9ZQzkj9egifT6P470oQCbJjsDp6rsYHjX1HVbO1lX0
Rdsn4KnIC+oe8OVETYu97udsxauK799mDKh7hAJTcxjQaB8sonGKjGYSEAMI95Bc
QqUTFcYnjwknaC0IjRwsMjlo46w8aY5vGuK41+01+WscsmNmMbvctKwQPmBqwdRD
UsAUfuwQVFwT49twO57S+AjiLQGsnNAPtxwAlKQz0Ymr+wZ7IBksJi2mYyW/8nPu
BlgYf9p9FgU9KR7L22h5A2KPi9o1pIDyOppqHyfF8hVnqKrJlBUuKyjCn0OrVeay
orvQDntLU3MwbJLqUKPAyJQ0aV3KIWHaGrCZnNnGmxy9K0h1leIgy49P3ThLygee
jwUi54d/iE/g9mTq5X8+nvjY761MzW9SCaHmUMSPknISmV2rH+G0J3TEbBCxHxhu
vy4ixhg8Zo1uwgnUJtGz1QFgZ4/AYacwmhaoVASvkJVJIDD/4g4M+DTig16MNZqb
vkdXB0PSfbj1Gmi2fB7/5yPVjxHJx9+0sQwmJrdR8MveJcLKXo4fZ3DbUFWZ2xTF
WPkQ10P0nb23IIzTS5Ifo6p9sB7TUCHuooTTaaMq/Y5OnET75E3DbRSmjpH6h9pN
Qa8LyQ95KdHOK9lPTzH8Jg==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PVu0F/fO8BrQLxBfzDjz8IJjMI0u7avQZP5I9YKnrao5SIae6unWvjRQoj4FuQX/
5WUX2Zs7gfbJS+79fH8wqdlKW+DQMrWfRZvA2GFzm1ZovkN0zi8/ntmSWPj8Lciu
rJ3TlgrRDtMIxH+aRBeA0/juzcnEZSF43lYy61De84c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22336     )
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
K1NoD6KkMGthI5y8F/j/RQ==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HoKtmAnQB/jyTO6//HgAYO9RZrguGu5iR8uFoEj6MawcrH92coOgoWdMabeZYVw6
OkKacyLja/wKUz3N+dgKLKMiEFCn/RdlT5O04lNlj/vxON8Uz8PiaKhWmO5e9p9V
Lg131JEMctGz/c200Rg0gx8SVto7tnycny7Z+DlFGKY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22550     )
28rrj5klF38wpCagIfFqZXD4tYzf/sI+vitzqA7T89hB+DMC5noSXSCvHHrTeQZ4
PG1FH7nprTTCnS62hAOA/zcgoQJMV2o6+uwedXRLenFfNSRG7rzR07OmD4EvOvCq
38e4VtxmCvgTPeGnuwoqIMjjY/kOoAcBQDW1r6ICMKxG0Szh9YK1dCfLOodt9dGv
i2evaz8VMJjUDksv/+wXrE0jlQHxfoKwpLPKrj+u9AXmY31dRl68z6JpGAjlvSbt
Ebnsyys5xp3lCsC1csYqPJ/PWBIE6fa8/k3aLqFFqrA=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Sj+0Su+AzHfAcYFTxRbBKQP9dZP5jdYNmdaSn3/MQfxrh6wfze+PsfDoAidgDK9F
dhRi3PT8mw0KCIA1e80GQo64BHAPrS9V5wnB5r26dIKx8iP6TiiyUUmXwsPy8lYZ
blFLDA0bv3cG14VXWNGPrUh1jlPfV8+NOYR8Q/Op/jo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 56904     )
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
`pragma protect end_protected

`endif // SVT_CHI_SYSTEM_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BmvKMGM1C/TGVH8nicMFUa8RDSH9XOGqwIuoyYs5FnCDmnksJPj9FQ9iVXBuFKcm
ScFYSad6PZn6KqilpouYhxBWcSOSHadK3i43r27s5s+WEK6CCRRTD1xHpJV1603P
YBq/TA60bbYlD5zL1RXDoryi/wJ8Jw3OLPhWhcg5IHg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 56987     )
QPH0Ka2+gwxnJgRa6nhx7rHl4hGKHrn9HxlMEHdtL8I8iZHoTqsptg8i7HIb0//U
JSB9437nObQ/vcPpVqkckGHr7jDaJSGx59vvX/a7Y9y+ncgESJ2Lmep47fDTMm7e
`pragma protect end_protected
