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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DA8VqOSVMYouAgDSNo89gLv782iq3cErjFjU/pYKsbDuFh75U9m6OxfPCBwUFm2f
s3ZhRDKLTzpmeU8GH9zmVfVqKFGIwhogPtYNDPJqYvo6OWGj9PbaNa/annZo8QsB
8wzVvZOyDWBCO1HQEPnteazI0N9+acgHZJkinzK1/IabXgnEV6j1xw==
//pragma protect end_key_block
//pragma protect digest_block
Z4FoRUDr9rhVJ67Cpv5m3FJvmmc=
//pragma protect end_digest_block
//pragma protect data_block
cvNSfcloS7bRzzJJC6GU5nQgvSS9Lm9oU+INAI6atEPsDwCIVeTWPOzOT+nB37vk
v/O2knkw/9RECR/vfSyfxuB9mqMmBiiRH3dfe5pKu/EqMHa4S3chUNtWYrs/v9Jp
+y92ZUKvcpQxLWHMig0Xvobrcxdvf+Y9DE9sFUtTtPeyVKFjzmA90yToAnF2kuxk
+UP/SpSdWgu+8w3yJUA9sA3V8GfJ6HXWcMKrhPSZua4KEF47y8Fx3+dhoxZKjxFt
9nVt/Qvy27cPAHmLnS5ornBBJYMm+ieGIk3+FRrlymQzZrQcq86FYCTtIVv97hJL
MS9eNWKpIsqYJRCYfx6Wr3y5pQwMOvVzGEKn1RcmnAWzee4f5/IMqjWM4MVM/vWK
lWGcW772GNyGRteMS7CvD6cdedQAxxFavqIVsBLsl8F2hoktJsSaayupNdz+rOEj
Ok4bJiIhWwBFtOnSRwkEcA3WrpTrU0f2mDm3Xlbqm2J7JrT8oM81U8Gdnbjdg1cF
3jS1TDxDyF23pjWvsPNkGyyIL7W1bSLkrJZS1JQDXtLL2vX6Smmiizdz40xFtG1/
u+4/4djl1gdFdRu9y+2NqVzAuG6qNln6ii6ZCGUtMDatqArvh1/QgfSAIHvK79ue
sgrAxGlSGr6MJT1quyRKegscH8HGhz/V+5/7rt+S8uh6r9ukXogvLjydjAz02rMa
CImd+n0HICogUfdhKno165UQNON/aXkrfW17d+3mOzbqt2VvGjKerTkaPH5ObTVs
TlwUmXjJybyphG2sMsj1mCB4CgOWqeVtkj1AJh+vltL14PgIfft3SUKXDxnFnQmV
aV8I38qiLyRPxwApysU3DnS6NDHpoVXLJ2S0CbPk4rk=
//pragma protect end_data_block
//pragma protect digest_block
W6fp/klWXXR5qHRwZuNi+BL6rFk=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fXTi3so7Wsn11wD7xIFmdmQ/Smo2fOc05rY9TazQw9n0+Hxs7xi0ycH3jYMC5kNg
bz+k/T38+ETJ6jD+2MIfQ9IfNzmEHPnij8OhjKAAVpZzRRK8rJLmf0ofy3Q9T6Ok
H7B2Ou4Kxr0grR+n+6vDT1nfp+wXuCQxUYK1g7LH8WMfELgIRK/pFA==
//pragma protect end_key_block
//pragma protect digest_block
NNbiPaviiSBF4CubcHF/kLoK2/8=
//pragma protect end_digest_block
//pragma protect data_block
+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

//pragma protect end_data_block
//pragma protect digest_block
8GYlwgYpKTx6tff+mG3Z9z50Xm8=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TnmSEY6u/HShK3r2ecrTs6gOpZKJm4P/H8Msvt3HtwlpzdHHgXUzsl75Y5YYjkXp
KIrQXVM7u0jb+rHhu8s4vXgpirT/uuRotHeZd5UsdcZJ1+iwes6eAeVEUGjdlqkB
NrzvWoO7Ym3P7S+Ps9OwEAshoD/BaP5F7kyRjG3jDiFxeZmMEOvVJw==
//pragma protect end_key_block
//pragma protect digest_block
gzSNtPI28s0mmbxPRGbTk0b//go=
//pragma protect end_digest_block
//pragma protect data_block
9qkmdAfiYb5TvByrdNCAal7wc5qOb+I+WhptcBmxmlHwzUmWsWkG7kcEQHs/Tqk1
siXva7606mW5nC7iJufHv1Lq79/HQKnUiZkemm+80UdmkU3FX8TFQ/8cqKMGYzv9
GdMLrxJEwbptiKsY7yKS6ioftZ6Ne3kfz4hqB0JIEC6quY4UQGgIMwzoBB+d/mnm
r8ihXMxVmiULd21I9pzeypz4zx/xpNdgdtfH3FKc6YLc9yixZ+vfkt0ZMWcMH3yd
EdM4vVXebmEOTMUFIjzNQk0CG8tMeQZJlAArDhdOT1WRUElABTvWnrO26KE0076G
1lW5tZ5ZC4IaBxxOe1x5CbEj43E/U2HYBSnMzxzsKEGI2HACQVwDO2MJGVejZSFi
ipc8jzL1R1Un7rBNbjNMATCTFLPy1xvipBkgWNjnXTRTymgH7kf9EFuEsNYLj0Qc
qjmLlT+8qUW8rgKc2DTJHYl9uc1jfYqtHJS0onduik/2CjAJ5DFLS+ZXb7+cest8

//pragma protect end_data_block
//pragma protect digest_block
Jq+sPUC7oVfuJRglji4gapQGPiM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qXbYwjFLlS+ouvJd/viLw0Ee8cHpE+Ff/iM9GH5Z5Dop1DkYwO6zTw67X89SiMHc
I2lVJrOFzzM62CbAYGEBvGsxFqJRWwVcjjRtj8KlSc/PTA7+1xQ3XhwqMXVosIUu
iE6tp24rmIi1TQjOPNUzmzAgWY1WL62JUKiy7TtLNhfvVzl1kqY1/g==
//pragma protect end_key_block
//pragma protect digest_block
2X/nLgjCkdivybtkGfEKrFj4PgI=
//pragma protect end_digest_block
//pragma protect data_block
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
8OQsWFlK8IMq4zFvQDXU5A==
//pragma protect end_data_block
//pragma protect digest_block
esJu+0qZ6YTlreB8DVOBV7R5yfI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_CHI_SYSTEM_TRANSACTION_SV
