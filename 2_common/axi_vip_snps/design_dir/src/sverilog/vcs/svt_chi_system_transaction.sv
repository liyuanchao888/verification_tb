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

`protected
>//#,/cV1?@F9:5aZV)]#/d1A3\,B_9O9^b@R\S].8.&5HUd@gaT,)+M#>XNW4^I
.f2,A6GFP+Kbd<Z1PI97)R>8+Z\T(\S8GB6EL#30,55R?36-&9]3AKf-B8IQ#Y81
L\?d+@g-6Ta\Y)V[2M8RFPS;=-]8)5W6LFJU6M0[QcD#(55ZUT]J1O+PI890\C4f
5LUN+_gAHd+e4P7e3M@VS7]c.3C?ZfUQH?CBFXZY2K#T#E3AG]<X.RF[e?_MX7M(
;ML64JJG0@\6b(]?#I[GSYSWOW&QE:V>g\IQS.O7#cMB[X5@.Z]b1_R\)@=VPU;E
GdL,]c^XUAE9PKdQfQX;WZO+JD8-K\)O612E+5[<X9BfI6e=W0YPg777ZK8.4cIW
1a]O;e)KWL\L-9BG6THE><DJJK9QW>cNFM&.IW.AZHJ]a:IM&?D@^fYSWDX[:/2S
U69RWbOc]f&6gOa.&=N_5ZIIH+SaQ.g82@+Dc)(E3P@JPU#Y/_7gNUYSJ$
`endprotected


//vcs_vip_protect
`protected
(,()S:W^IPaH<?K4,4ZRR/(G^#g8/8E;H\[,YAgb)cSe-4NH7>\H6(g,9H4^S2:]
Yg.H07:86c?8,[XS4>BA:H6dF0KU8L/e_OEL]H18>5&C5TZ-[&FD5]FQNU7USSD9
?P3T>0<<S<Ke=8ANcWBF6&T76RD#L:3R(60@X2OV#D^CZfF?(=NQNL(1.ZVDG=,:
cE\V[>@B&Ub#(e=CQ:WdTaLC]dT5#3](#L])fNV[ST#5I4>CW6[2MbCHSU6[caQf
VM.CX2#P^2T<a0#Cf@PE_cJc4BEfF=2AV)C9^dA6/XWba+LK#fTd;O,#=Z&7A,9^
@H_(5c/PC>OTQ<Q5FET#J>5)Ne3QA-X4IMBY;#cB.C.bFa^VZYW>ZV3IP]V-Egc)
e,\MH22-+[6HOKU;<7QTYbE=SFZC?LD)?L9OBJU&.6S82Q2,&ebb-<+[.9N8]XB,
8QS^M4>+V/->S<#6H]?,JKG<_d\67L13LH?F:&0-V>3)MASd3QFgKWH>dLK@_PVa
IW_a(RR>HZ5WFYd?(\RYVOHV[Va83\D]+N(S:4U^15WZ63?UV0=&G<Z&P6Aa)1Kc
4]??O=\E0?2H&/\N[:HI+/B2-Q<T&eV@UL)M)\CcTY+8AcfT3AV399MWD:9(LQQ@
<HI@MCbBHTKP.)VSN81dBaF.MHXCgc^V8#Y;=C5IL9S\daO^T[28e^Xa33E(BeCA
JY+;[:^QY]UOA?)-cT:J<)SJ0YKc_EGD=RF>;5Dg]5TEA1(#;b)M4KZT?I)HB6?P
N,:e25cg#EZ\P)W:BP[(DY:P3AYC0]A99d<[E7fcZ(6?F@BE;10>:YMQ_^UGJf[Q
fEE^;SWNVN;(eK\/UFaG>PMYM(?.IDPHS?-+Xa@ULNORA<#J;>JK)Q3R)@JGOYDQ
>8)E--\)QKSCYH8&0/K_\M+@DQ+FbGUDcZdS2^TGN5SG^H(K)(?81N(1=YY[0a^e
1/K-_80,U:\F<R^/VTOd3-a0d8[+]/4\5?69ZL6>[2#88HS83>L2/H6U5G=C.ZHJ
&(4\AacG\YA<62V#],/ZXZHX<f:JTRC^e([bN0QO-_A:4b[YAg10OG,_>TH/e&JU
P[#gM>5beB^L=bc:HQT;#YN\C&L&<^77_7-<XC9)48L8#+DI0_7[MENK8P8@2gB#
7T4\dUgI,8>P.WAbX3TdS#?gSB[W7JTH/:[T1)BY8Cf8J,I)c9EY2Ha0d(bBUMD7
M4Q^E\5><dFD3:IbgAA]0fb9M-YH6&f3->JFER?UW5B>G.G@T2?gb;[GPgE)3SV7
@Y,@H_R^gc)S/^CIA6L]3)XU/cEaM.H;UNJf2H2AeD&aU(&YY#d,@NR/Y/,;b\DO
S)QOP7,K4)0B5-./Q<Uf=[N2I81f1E9\MQ94/B:1S^QcaDEIRP)0\S]-gVc(gdaY
P2?adCf_3/(03Z]B3)]ZY9H5<@WH6&@/cc<[=^\NUU[UG^(T2Y(g9GNc#c3<c:eQ
].E6;-E/H8A:d]bS5V6(+AO_2Z;QKCM/_01XVOI(;Zd271Q&7G)d6_SPOYaCRdZ7
HUAS@9X\0/O.SF>L;I6bI809+?,:PFIL=/AET7-HD2#)>2I,Rc6Vd2,]R2J=,BYf
OM5+O5HEL>?(-MJ1,(D]TABe,UHge_b6;cYdOG5+R1>b1aY#F[<JDb6OO)e-4L,T
N3G.OJ+2X\:PG>S]YK\=CDf4bRD98W)@H.Gc3TM2/0U#1a9/bFe[BRZ[a.L_X(e>
]d[DY#.9V<Q5PL@DAP:>&8Y@9+V2W&\N3OXYT3E2/Q6d0Y4N_+\5#WeT(1N@&Y7H
.2.:D/Dae2EM3O?)A,]dNSP&UDGFKR[]Y<M;&;gZ7(MR8[DLR#IZY6R,^c^:/?S1
]b)[HcKR_HWGM[Y21g=MP85dTceS0VAQS&&e_?0&P?LL:,D&#P^&MG?d9F]Z:T-e
KH[>Ge1KK?cg(\RI.--U60/M+2Z5X\c,EZ?H]PP@A3Q1T^dEUA[6[U+#beIdB9+\
=4JdAC[CBQ\S^O8Y2V1S.]9MFW10W;]=\2LLfO<V27(HF,>-)Gb;.<H,VC_.+@22
BRJ8_U;F9c?]-GUCK[/JcbXbX6R.-7[(2@d_Yb[fLgQ>(Z&MN7_>;JgOZ3U+W3@\
6fVN5\4D[QZ+Ra9H3.JJFKaDgYH/a52N8VMXNe4#,:d7aWgD492f&PA#MeZN]\7,
bgDC.BOf_E_b\H0c=3>_>O#C:PXC2&&:7_ef.3MB3)6cT=P?#.NREW.FA]A97R59
&XZ-YL-\J0V&DVCdJ-2@VWMWS/&J?75LQ]=+A:dW]1=HFd8<[,#+JETfEMQ8^E(9
7)4J.LV;#?X]?KR(;E4K2I90B+NJ<#II17?1R32f=N_4\-Za#@O<2F8O(c=VR?HT
gg+27e:WYSd3GfRa[5_WG/eg0)fP?)_SRc]39TBeab\&/bFRT;e(,&Vd=DQN-R1C
MC7DNNEMW2K49J@9F]_FXOCM_IL6O,.CR+P[B5=2D+(Wc(:<ETD-bMPN0/?dRA_)
ECXX/SN9HUR@47V#Jf:PCMKAE-cRJP5.T4.T;BA4SF?.b#@#IB;0VEQMZWVVQ9IM
,A4W<+B(17N59X6(L8:_.6b6O.GA728L=RaeB<fP#WD?1MA>,@D?]TY7ZE7PWZED
_D.#1/?&a>F;U#UX#ca+<.@<EMO=W@G81d-N.58+>(>2BP#-7[I2@X?FF.Q_E,)K
eVKEg]W.[WHV<6dJ/Lc;A>HRBe>4JBV6?41T7VB6(IQdZ+STHUb\f4NE7e5\13eb
LFM4?4=-fJO<GOeN,J@?#KUUJ8]gON(5:04E1K^_b(XSDLF(QI<@:FgJa1V4ZS0@
-)dHDX\d<WA\H)QH_8<<<e179]4LEgB&2]I(LB)ESA8&Y(S-:N+L)@<6[:Z[3WNL
fRff)3?\b]^TdGZ2OWKQbM;^g1C@gXGB##ETAG8M^d+L)=fTO2MLMR53.\P)f4]D
63)AAI7Zf78^A>#2(4&OFR9T&J3Q4H,?3e#2RSY5N.TE?DN?<I4OKbPYFPJHOEIA
_N0;;2?Ocg9],BW\2HN?O8,5O1/D3CM)D0^A.,g4&3KKP]N/0]2Lg(KKWF\<9bF_
^SQ/[NF7?4>TNdC_N^>ZW^DN<W(5H]=I)5U3)d\<=PKc<[1PSXGM_,YgT0dL)4_+
.8be7:;.TF&T<6,>BCJD=+R1a=D?<G3<FT16W@\?4&B,.HITJa1c#)c+Q[:Hdc2g
UO;1JS6+.)6@W,8EH,7O=H-4\_D:TA+=&\P)943cF?-=C&f3#O<1B&0&Aa81.<<N
=daS)D^JJS0eZ_K#8cXD1IER-g5.&3+TdB710BUaL^WgLIZ1D2CgI/A<;M#SJAN^
1]eTY]B&RGUKQ3Ld+27ZD1:Le4))N?d?&MHQ@8C[F8G:;N?D40Z[6F@9YdP3c;;f
AU\9/G\V8=S)5E2EKPE;>d2aD+eU<cW1&BG8fHWc8+#fYBX;-EQ(2ZH41T04T=.Y
4?:0.;Z#@.G7E]b\PPI_E6_:5=>R&3]]3?beKT2H4&E,Q+]V;fe5[UPc5V)1[Q4;
KGBU7F755I#15I3X?JN<NbR4L9MLRY]g?=PF(U\23dV>#7Q9/?NF?eX-D)XB>[0X
g7FEBAcOSN./2[b[&/X-HSURDS5@a572I-YU8?#CdAH.U+d/O/A:I_=9I,+]RWMZ
))4BK><P7C[Y5>BCFEYTE2YI)[G.b>95b0\3_Wf77GfG[_T#7fH<:@_(YEYU-LZY
7I6>1D4cJF;M8YUBIbYe@9J[>IeScQ<W>+3#TH=LI^;/5KIRE:?AHQ8fTQ:[93b1
].#NL]=(e1;]g=U](@X5@&f/DX+ICR/QK8CAS@H&]2NK)]766]HdOa40[WVMLWD]
VCG#Q</QOY4?F+D/C^];)/:#8L@1aHJ?>Y^a40)OCe)JCf8GDBJ9MaL7Rg.e_C;2
#R.EYR2(WHIG3PO4]&Z@3[FD6<&[+\6UY]1gN&/YF<#50K30R7G;3eGD0NB7TDD4
-.ED+^OK6=M8T+XP]g#E2c.Y#LK#S)Fg:[g1ECB3F?B]ZEe6TU@+I+NKTC1#[fES
gFWHc\.aEAG4-3;;ND6PMM@^dBMH-@Q=abL=R2.f_gg&.\C5_2KM^L5_\(7aFL@d
6c02005/O^F8/>Z0eZdCaaA-,L[58/PVf1/[7&L,c,G/,J6WT>+KXB?6,D;GJ0K6
POJd:[eb>(gI0JLX?AFRN>U(bR]7R:Ng51NRN:Og<4P:L[b^1R3PR&X66E_?BdYB
L=QQ:U:=&IPZO14]UE3a3Y#g17Eg00KWMFT\@A5<ZfJcTW)cT-8XNfZX9aWN@UKC
,?/Q4-a4RZ2:-6@QSV[9gWc&BJ_/XI#a+^X/eWFA)SIf@dLV<?Jc-bS;-J(@<(@J
eY,bYcD&O<R>[FN0[e+I.(>=I5YLfN=\KO(WN&_b@<N_KcdO3=U9G3[aMCRV?VQ(
7J&/I=&=g-5DZ[IDf7^L0)(d_MfO2N_<[I(?WE_b6gGOAGN<.EL<BK(&WBAd0f^;
I5O70OFc>,4R9AgfMF5a5D@@_,7&GdXSKN/^+a@;fBFTFR??W<V5d>:d)3O&U.[W
9DfP,Y:4=ITAe)^H&#K_Wb?)WL/)C3K]_P42&g;;X)S.DMK3^@79\;FLV([A^4R,
Q=9QgL:^8cFAA9TS)G3IJ]C<e77UX)S,dV?g6S_8YV[]cVD01-<JAUARTOP)9NX@
R(P4#I.fcX^W8,6.,P7=;<^W5).(G-JQ-Q,5V=&XL,]W.IB+,#&EA_F+JM@aX^T.
419EOaa=/W:]KH1Q^Qg?VT[(B?G:K>CJIV;LTY8aVU>,KB0[<FBJ(#R;V8_A)ISJ
gR;@7V8):^T808KfOT8,bP:SC\C6OZNP)g[P:^K/.6Id]E.W3XMK/+&,P@Q/GIa;
B2QW8O[Y.g#K4WBI#^.(6S)DgSJVU(PSX_=72A@ON:(GV,X<LG+MD_(]D;1?Te--
SNNeSd[=WR?[XY[_0f_Q\QI<;D+^TaK0(fHSIg,VGc8@CFPWD(EB0aaU>V1O8^4L
XX+4U^^J21Q\/deU7&K7dT[W>7d/4286WDLWfNID4_Z0X_LC_?LXNU518+DHK@)&
?6W-fcEH(>[\HZHN2Qb95b(8J?R\^;&-Fb=aJ3bJY2g1&Q,88&gA;T3#@:0Q/?RM
;\Eb7,0.cWP>8U-YH4c9TRfA18g>d2F5K#N[:4ITIXdg1KW,QL=0XVVO.Sa@OU[O
-B??5[&/DV;5)>9MZ=[8<35\/E/043[dc[8#Z3O=XQ(87)N_K)N8N=.8@7C>#4)]
gC4[Ic:-F3fD3NRGN(R.c,:E0cFJV<.bgJ0Ge3O@)5fA^PM1O-K>.)R)E,RW7aQ_
aWf^/McJ\(F-P;-O]V>,KE=Y0>]&C=9dcJOE[+&M.SPI]L(]Oe?#X35LF]/TI+W5
-,Y>6+\H-A7I7&:6MD:6cc>A7JCJ:@CS:#MM^9_,)Z1I,3W0(DB@S@PKbV<0[X8d
&dg3&#&N#=eRV/U[W:/EDD397^?/WOBT:;)>d@TY[&ebF;PI:HA^FH0.c8:W/LT]
R8X:^7<cV@VZ:Q?H+=8A,M?E\5A#C-QU);3B;E<7][;.H20VTUNbXfG:J.e,CYMW
N657U@/[fLV):V<]2:_1KZ:fT#8+]CPEA:1SH2P.E68UR>c6Lf4J4^N6#f9HeITY
L_J]<2QXIbfgVb[BUIb<X[Zc:,#&>VU)NRAC^BT;7//QR;PY9GY(YPZMORK\DgJ@
U><\P>GWba)CD9V3OH7/VQFEEXKU7JHaa[W2?C++(@#/MZJ;S^ZBUIg3]3]BW?;a
QDZc257Z-1Z3IMbcBGRF,C-/).XfSNR/+>^1D6W1E8]51Y#__C/<D.+7ACPQN224
6dbbFFS18IA@^;g:Q20SHDUN0J3>[TZ\;7C,^MA3Me-F:@,e\<T?a@>H#&U2?#1=
f7654@][N@f3,SdbS4F_GNb0Qg><L/1,^^]c#eO(;GcXRZ;Zd2-U,QSPfE\O[cI3
5-O5#3_fFFI(7dd>H)LM@&D3)@?6&c&f5f,.VFJH/99RJ/AG54D,(_PbNRd<4WH]
?EU&524NI(WOTGJF0\&CD93>Z)@CK.0T9_VHHICW+Y8Ie6+C)<]&W/e,HNbO6DV]
c2TEJ2)N@Od4(;&bZS9d#73:F(:[5@MJCT=N[.S)Z\3gGKI7492#@NCeX-a2:X>(
Cf_;Tb?YZ]9<c^,K,AQdOTQB7J5C,WYdWd31BJKZ-FO;VY&Hb:XLW:8PAO9RX2ET
5I6,1V0=5f3<EI8D>\/aH&c#IS7:RU7J;)Xa1ZQY2.?4FR<CKQ^aRC,UFXV[8OS8
+6\K/GQ,^eRF.RGHY.KEGgC1GO2OZb+d33N\0<QK@Ye<_2SJT^I418[=)5BIdL;R
AcP]+4bP3#-2JaNLUC5OHcBa2YUW/gd/:N/OQ&F]bE>5f]WZGX;)8J--P^La]:eA
A:eGaGX?,31IV9.gS4):DLb86T:68_e#Ra#Z+Q/cLE^MB.E/J&0&R]5I;R@)PY.&
&.?^RYZ&M8E4&:#d9f-b?M;XF)Ue\+6[38_>A6RS]H)fO^(/QfHf\6ZE1=C4JC04
aG6+DQ7CX88TSf&0#(;<2#)_;NbX0GbGM6E_U:;<DN-\E9,C@T=[8E)AW]-OH)Z\
9.BOg&1Y(G.ZIXLPQe-FY-CNbVb?)5Y>3HC;&:&1V&WDMF><<:=4CTSCe&Ta9baV
WVZ0EG&+H09Vf-\eeOb1HIS?8V_<C,(F:Y0+:-eZ6NNA&7:L:;A/Oa>6Q.e20]^F
HQU\C3PQ\LB(3QT(^&)_X/RYEZ-O4:bBFSUD#K)MDG;TCb&KB=A>BLQ7,_Q_-,(>
<Q9K<(Sa[C[F]5G2gb@([1Yf:+UHGI/FRUg\dgE0\:LfG-D.Q#dKKO[+YFa;T]U.
<:7-M@J,X0MP[QeJU]PD68Q1XHGT?.;RWDdN+Q?G&7U@D?4;8:J&G@>aH&ag[LWf
#Q?YV)CeW8OM#\SLJIB(F&f^L.fb,N2AcJd8.+<6TV8ZGUSWQB)DL50^KOA\[0<W
R)fG]<VYI3]\CM:R:1;fSUBC--f1V(b0E;//B;GE/,(K-7fU(?-d5>XB5P;8NSdT
?e;[6/aYcGH(+YL:\;MK1\DCCU]Ea,Q/d/5VQgaOd.)W/QC#aWe=gDCD78UCT#&_
>1UK&:e&H]/7(O^dP@C>I/V#D@)KDB)45FFX8Rc>XM>2-Ee=.=CbQV\a551O_^cH
?;C)>72:eP&E+GbE92,8#;d=c2UDF&4)][V>JOM?g#e,dD[_2f\fLQQ;=B.Q3H@4
Pf^^SUWf>6EeOc5&EJ<]M3HDNK;WbDWZDG</ME5d/1TYfO1P+(@@S;24Z/eYY4-?
2,IOQ-RFM)UE27S5GQ&GOI/]F:8_&E]8.e;CdGVCSB=B_c:ZaIY[0=DEZZ5U)Gg,
A;-=);ReU+/cDRF;SJ^;e[X#W^fQF6F0@0,R<WJ<1<Hf][RUX,gSKgUdU3Q[NV,0
AG8KK2cM3#DMTcCU7FZH0((4I6@f<_-KbdTP=^#N;+6bNg=Bad<N?1OSWH23)MG.
#1M0?SY)TSBQG0A9P5Ze:2MMS^UM[g=68dcM/(R)DWOX+W-M(/B)K3M+B=;7#\=U
KE?=7G_TB5AX/X8/G&&01e_^8gRG]c.(/OQUA3)#daA(JOQVE5+G(#U2J)CJNYYC
ZPO-fEM[E.3IYPC^/J:E=F^E]CA:EF?,Za@,e0+=MWZE05/>G#e[8/XIJf.f5FK=
:49W1:0FaA2]Igg8PG_M))3Rb?J_cH_HNPS5)WN;\P<Y\A]]=YO3[=(M\@)BWNRJ
(AQW)H@]aN3#+6&KI5\J/g6=<\(35.@FeaM):[_Y-1&B@g_?eLPdgY9dg3J)],Y7
dBZK9]Z4\)5b:6>6fIRL]\9GCE^HB;ZeGDcO]B6Nc+7:XQC8?DZgMDb&MbE76.&W
fIfbc&IEBf>a9@M8NfVe1aDLG#Le?4c[,2</[UaP1JR:>BUCH4[30.9CA/,33S_Y
\-;:ba;A6T?XSe#;D@RfD4^F#f1DJ:BO(c5(5Q/R#1KEV672-P3<VBJ?(:<U9_(c
;]^\^ZH5,(R7\f/G=A2I)GG4M2_O;7J_TPcFY^R)GQWPIFS;^#6F&&SIA7dXa=O<
1NX+@c7Hb2,@OAA5VN_/@9&VBO08C^\XCe>c]^]4Nc)@G8WYP#@I2=U;QDe0CBId
aQCZK/34W2BA2eW]He)JDd.5(=8bL&U]-AZ3T=RP9]bN]OVE,M_8f_1WPVUO\6J^
cJ&a@QD@R-c^daJ64Y<>7F1/XMf4B[c]A3<AaFRB#e7M5B9BX/I_+5MF&RC@DFSY
Q)LR58B2-E-0+)M+O)]=&c8Z7@GPN3bC2DR0eH[RC(/TgR>REY<O+@b<J0;.X=fS
G^05b9S9;)E(-XJ>/,78FcI/d=g=MHS98<]E-24_VN:@4FFWG?^3#]OR_M;^T/0H
Dd7Vee/f\KQ6+;K-T^2#e\06.1aBaEF7P5@3:(+)MO(3/ac)39+D,-)-.5a)T,?A
[];V,#M,4dc0Oa>G0+3[.1O&6E2Y-];7<H88c;S;\W&cacXC)XQ+SFR=\4d[E+UT
1]g)JYa(a>cE6/M++_MNGa;_/E#/8e.+>?a^5C++^UbMWRB_LZF40fI1,/OV@L+B
;c;3)3PWMXG4(:>WL((<\aIc>77FSD]TCSASS?/.^2FUA;L<X4V\9H][F+V+8=05
LZWb-)-b2F&WT6:Q,aM50^4&ATC=2C+1K9(WVWdcf&7@^T,c9J86&DB(cR+MgZ[8
KSM_G,IMCT&Z-D:UPcL\/&8)R=(W-CL^L1cCN#S\I6F.B,V4G1WbMHX\PA_Cc=/^
FN-6eBWL9(](CS:c@bPe80Q7P/ZHIWB7;1X[_3P_#dKcTV[/_FZT<=;T,>XHf,DP
E4>9Q6)NFEZB5G;&>Da6RFac<T:,K[fNDfV5UFT7g?IK&G8EUQG0YbbS/agD1QHc
3]R=Y);S0@Ic:Q78JHIO?M^:/Af6G=RG+6R;H?G,6&I#0]G=E^[d7\cB>5Lf/HU3
F?Ag1RC]_]?XA]?I5_-;a:)(QR;@[AY([>9&^BA;89Xe];dB_4YUXIa,5E#I9VD_
.>eg?,c:6BR@<G<8+IT_&MeQ;Aeabb=d<+McY#Z(BRA@0G.?\&e2H5<A\V8H9=M4
XaZca+3CBE\-SNV6DV\S(MM[^CGCO(6[@/_3W@XIC=&PC_D,;gBA[4:#3\[gE??)
02@8FKSAYU=IdP1UXJ=We;_O.D0JUGZ#fZB]/6f<c4aX4LO-A.M05M_>:/?bM(4J
TLPSac@Y4RgXK=c/8)6Y=OK[=OMc918L9@&:>b1aY<(Z\e+&_gVd/IdR(ZN6?M7a
Wg^XebfdK9BIOQggU=b.S^b<16QB?[6V30#?BR,TJUYf[[eVI(43ES,a:9f&NZ)C
877Wg^+<.#.WTM\A=M#>XJJH7cDZ=)2_YQD]:e^VF#e[a<9+K+Ed>ZLXfK8)<4?A
YYHMDBDH),[W48O>D94;U-9_8PN&/Z\e]UEgTU(Ac+,Y.-PVad./#.0dTW]/K.D2
AbU7@^Ge./E[;QX65.ULSa5Y_-Y:/LJgEU](21-f6,f8bc,\S^fDY7_?(J68+JfA
a3NY-UG(MdOR&.)CL<1d=D]EC/--WPKA52+YbSX<D4K2L,+1fZNcS=/deATS/IF?
MD<:50eb&B7D[=Z@BAZ@0KJ-e6P39LdUCb]]K+?IJ+77ecZ(K(+^)[C(FJ-PNTNc
^E87&320C,dd7/07@f:3R@<;K6aFNP5]\OA;65]WdF4#B[+0U\#^A[8,7^#fYK<Y
fV,Q>bV8]3gS1O,)64FbUCNDXf1(8EE;g3K;D_.QSN>]d5JU#(-+Z=,^&-0G0#HY
8Ka>8>26VL+0\=UW0_&^7-36Rg8RRWW8TN?C[+bPd[g0P?98WcgGdV,Sg]A8MG_T
M,,4:Y7dI^>TP^=\9+@\>JgQ/7\\gNYNdC]BEb4Kg11F4C)e?M-cVRI0IYTf_J?#
PDF,3Ea]TRXG5D0[?]>7>48+8VEXg,DOBVTQ^T3+TD],D0:)^)/_EX\YNDd]eF1g
Z+O41PF.QFS:J?EN,SFb72d[V2e2/D,8<YA]AfGg;0)9.9>^X]ZAVGa5K3g9Y)W2
e^NP;)5bS:>#^SL03)4=]g-X?55BK?b;FJRb\]T_6U81&ESf5a39)W4a(a+BId@J
D[N(_QE9=D2J3^PEDSZN?R/^5d\Qd33-\I/.^Ib)S=+d;4Je_.WL8fGI?65986/,
_D?.LdZ:UU0L#OXICGTbITT^V0,]?@76BN;ab([8d<fRHc<H9<MX;YWMO&(\V7NR
O_WN31OPg,SDT8V/NZW:]<B+F13Q^_^W:?A#,)#)>SeT@S6:#5]cKE(:;D?P+TaC
OR,a^0PXT1;@X6LMOL/V<5I;8J:ZU:D+Dg/<c_bP:,4SL_g,4ZNA=ZY8SK=2HN]Y
Z03L8Y2+1J^Yc</GEc(2DU_K4<XFLH(Z5]2gU@Z0K07a)(=47QeLW+V?^@EN^Rd^
DB.<NcgL?NX5#(/8F<N-AOI/A^@P26b9ZbQ:e;S<;7Ce=/-/eeKXPfZ/_??>6a3(
)PPPb-XBD1Z:\,/O)A)820VZWO&T<4LDf0(c3S-R4D4b<LaN7.XNPg9aWBV1<7\=
bB)-B,#M^Xf^WB-eV#N#[@C+V)A2))8-?(Pa@7N6&/:H7Cg+F8JVL+DEdK<=Gc)P
5_AbHfaVA3?gP-O6.O,&BCK,I4SM=?dHJQF6H?-^/+(H@;F,J/^<2NYCU,\gN#;D
b@33KbXHa^&bYCZJ379CV_NKHa)VJ_R?G:&6Y+KOM1B]GGQc;:R/\e=g=^E>N9Q,
E-,b;JL?F_d:#KaDTX/6AED8Z@JJMR.OZe@_8^2\fL[298H]0<.9V;^gCY2JO?<D
S:fS;b/HPDEQ3R>JSXT0+-d/UcZZdF9IYJaaR1Pb)Y+Q2XYc@9#-W569D=6bX193
D=6,Q+(DEbcNMKI:(A<RXA_[0Q7_ZNNUI&_E[dIF+BYeP]]73<2-4/YUMb3IV;\X
I_<X/MDCU_,\YGaIC>5+#;Tg#E>,K\R:GFXOGa_,QXDVfAe;_9(b3&MS#6E;A]89
<+E1]\f?H8:FL7J&#S\QU1NWaJ]2L+#aG[[4T=/RH@9ESQ-=C-3;?D.86?5.QA35
J>U7U4FT1KL9^cQ(L\:E6<\:PYN:,H#<Hf^NWG40,1]BL<eaH/#:-[O:=MN_Gf(R
7GQ.RdTC&+<>37X:ELOSZ[I^JB[73.N#&aaVTV:OW_fZCReScQBB7<O/+d\O;MES
b#Y1g^Ebg+e?]+-O8]SY--HI-]g;:CAR>XI3X_eY1I3V^7X_b/DOf#aa9c>M]cS+
P0OdIaJZH6UU@[^&;b.3S=JNJMYD]KD^_P220ST9?57VLeZQ655_]@Y<:,8TNYR;
3M^&S]Y?/FGM96D3X0I/SQZ)Q/NU_+aY=GA?9WU3UB,2cGNZ<-;:8AS6)@YfFVB[
PT#7V\9&g_EO;F8SH3AGLA<6M6#:R)//@;6(&-?-_B5#&\f=aWZ\(>(O>Xf3/FO4
,.>bH)3c6Gc]R)^.AGJT/L>JD]]df-JDeeMRdV(G)4<QG:bGfc3<?NUbfJ6JW]^0
/8N(T,1G[XD_&e?=Ra2e6=BUO+\^MRJ57#G3]CYIN8T4QYPPB_(LPCOB:Z&Z8T5-
X,Z0W_M-48?>:I1HXQ^3CDD&\YH2e1Y+FM.33SEa1E,D^AeYVe]G?De2?[ZUFEb+
Lea7A:SeZ:A9C)gI/F3/,_ENIP)FOUS@V:^.g_64/C3B-]]1_6]-DMQ9_8-WgfLg
STCJeG<X78ce[NWU(&DOdQ_Ra0WcZK(V(3ff0YDc2f@Q(?4(+Z)2#c/FbXPA\9aC
G:A>aFW9YT?KB@9429+-IC^K=&)O1Vf#ZfDU@;fM3,4#Md-1I_;J+7M7R]:>GNaF
?@&3Fb22/?;Ce7/C-AWMNFfTcYS9V+MEbU-NI.TKJ(0\6;5:BD>d(;e/0;(>0/QV
f\[5cR0&)A2QOa#)_&?+2+c:1B(e;=0GVa&R)9QSGT=F6UB9eX\FUC^3_SDX^H()
[(6818Z^X@RE(J-\@gP_5YX61BN#8)[KNdM,W3DGQKd[6X3AK>R;#-_ZWXe(<cW1
]=0XF@;@ER78A&Q>=NV@Y&.?ER4HeTFd\<BP[#JJ7QJ?A)>eIVEFfM]N+Q1bX(GT
^A+:V5WMfQac?f4^S^TARW[#cJ+:?e7DJ><5b9:cgaL>4>@BX;3f9SI[?HYERV/5
JEIUUG9P/#WDcA1B#1GZg+=SIO6a=.82]@.edV7MCcUI4^Lb2:If@/.+c-:0M^J+
Y#62ZbgYbEgVZZEC+_LI9WM59\A?(C6HR&]#dK6=H;><;,]W^S:KQ:-R<g9TE(BQ
g#-)4bY@Da^Ue@b8OL@KFY\C9\BecS&Kcc4M^#<J<0eV<(:f2Se6NDE:Kg6.@-@<
PeKJSXCG[CVX[LSB3-e./<ZS+.>PC#6cZ+^0^\W3/NdLcCZT.XM]3-S-ZB)e=@D9
BP0=0ZP(=;84HT\KAF&Od2I1_U,NaW@SS2ZcQfCA_4dRKD]DZ:#;LdJ:-WRL:ZG5
GDB1VSNP>F&e=+<2AX@Oe@X1ZCNS\7WF;A&J2GS@Q+c/gQ4f/dcEB0cZFZ;V7Bd;
SSTT]+L5WfOYG0B0O&Y]YJ;=[[(53<J=>BEKVC[5g#N(+;IP-UFYQ<Q3@JSU;O2:
adSWaX4?.Mb8QdIb<e6[YeTa:Je-f/c8@&e#?0gQK&VCJ21cZ38eG7[bK/(6;f[@
,U-&H>2dMf;Z=#(d@[9YB2cH_K;DGKOGC/P^MVKK:T8P)KO2SUeWF<],1BL^.8Y<
9Kg56D58@W=7]QOJFEFLG]8));^+VIN471VBZgb3]0E1)/3N\eD4T>1.B(SL:/.V
4?C+g>#SN)FJV-L;QW:b]GZc(HBE&E:0YO.]L:_HY3fK0?UA)XL5BY?BVM+@cOe+
_KK?CCSW5c<E4eB974Z]Gc+fTZX56Wd[B)F,0S^4UC)c1XFbN5^]_+HGc?BWb&+[
>S:7Z+36TRWI9bGEP0E@OdLdU]+YbOKQ,G2Za^,CL\9Y[BH/=b:?W[b\Z.:\.[Ya
4?[8_/>>XVI(gGFKF@E]g0dbPd)Ha+IWgDEP2Q/8:^ae+U(:V)C<31YQSR=\S8gE
+X3(bDA-4#G;IT=VDV:QQa?]B4a/,OdXIOg6/I73J2(+JVe3M#.)EY9?CKO21CFG
4Sa7gdFT.:EG\C]JS0U@1GWGXRYU;?WQ/Y4.D)FZ1.7LHK.+aX-<O?,Q;;L=(<eI
/a:S8IKTYI5HV(UdP(EY/Fg:RR<;/?P[7dXH&&<a42/bE1W@7G<fND5K4cL?H:A7
ga;GaH[gC8IB0@+&aL_JB[NVa(a9:G7cCD>XDJb+@dR6Yb8@Q,O3d\T@0YUUZUD5
.a&(TZcFbXG-E:_COc_-c-#]>M@VSGCN0=e]?B[;&YK5F9>e=cIPEE:(T9J(Z;+R
6LZQLC71gc&g.6.cA>IO2..c[U@aB9[ePYbW;c]=9EGLCKXSLE>[cc6C>1QQ2:3@
.]I1bA9T85+WaO4@S-G#V=,?.16HA5d=A0b2W=eaSVE3^Icc_X1a6B7Z@8gfXHMf
=<18_?OOXXbM1W_1N==)M4,DE2(Y17YD:N??EdKBI1A];&?QWPD:LRgAa,_G.4NO
..55=,;()fGC+,JeP:QB#1;K/>:P8#O73-?&aY&KPgPO4V_?Db&G)9Q0+5L>F20G
4=2KeSeS=L1II]3BabWQ2S;P0fc>A^?[c::19ERJ<5ge=A68[V]d]>g)+VJHa4_4
TL[>EPADY-F=<Qa&>)[SNJXf.W89RT;Hd4d^]^DJ&DQZ^V+3.=T[^X/MR/P#TIe/
-OQJJWROJ7<S.S#7^H6fQ;Z37QRV[;[F8;GXIX:QgJI_+6>>Of)SL0RX,<82gCTU
9(9;J+@^QTXE+Rcg.Y.XTX64LYMQ+7e.(-c1\<(c(H&U_B\QN;\2N8a4GV8V;NOA
&RHDdPW0a_F7RG-<D>^R1eA,e((XG[2?=8])1]3N3V^#YWQ?L^RYT,d,K>M1N(S]
WVDUQ:[4>S5W#IX<I-QQG(Q1JJG9<HCWL-&?@#T,]JL&LHcUAC#3MU:a_KS+@J(8
;.3\D&JfM;X[>HP4&0;5H/AQaU@&HXC[\AZHP^[H7@J]acN@)+#/2RBLc9>4^#V9
9M=P_6\b?Q6C;G)B]K7WDW@3=4F,\.V(OH?AbV-Z0(NO:UW-cRQcUEdQ^PcOULX2
4SgR5?CGKQU>1E9T7&1F^3c3@(NdGf.Q=>ae3@W:HS7@+?GU\3BZ\R>DZ^)5H<VH
5/EH>06[DggQI.a=KIc6L<8<C0=)3N5B^>dT;1@H,65Df1Y5_55-Dc,341S;7(N&
ALX\2gNM.=4[CFN<V@fZP[?+\Y+-G<YP0b4.Q2EAYc(^-3A<fRcAN:60HIU9]_e;
)2gU/Ta>^>Of/_//\EJe-C,F0Ng7N5Y/a6Bg3aJVX_4:_P)HE2+//@^(ZM<]M,c1
_/9(JL\9R#,(;1K3LLK&1Z9aK;J<:2?B]WXf.JO1KBAeg#Y&\C;&g#Q+FCbQ3b>=
<T-UF.J#HRF+H[SgcY^MHX0d=45LRZUJgLd[O&J.-f#I;eO4+TfYd,O>VVS=&=3G
16-&\I(:CMB5^4(=>#9cT9IFE;7DQNMD8+3>4e.Kgg=C0bB8c[PKX;ecd0)/^BA0
59bZI;VD933<SAMcW&)2E>M2)-=QCM<BfA_]UYY([V6)]FLTGeP<^ES\&^8d[6?E
WFG.G///=@LVD-gA88GQcId1FS@PZ@5B9?a#^(J.:;ggTW_JVB8J,S?e@F[)T+(O
+;DC21FA]5UH@dO5K.]VEC#D?3Pc:<>=AIf@BSC&9ZaUM\G)MeWKe?Kg_f^=/\/3
CKIF[5+/^_NW<1+2@:,5@:MaURMV)6F@UcNe,0TbM2&7HCVN@_]gc1[RZSaZ+dQR
5bV3R+L-N]bYRbB_Z5N=4aL=>MX11DZ0Z[7e/R44g_D?[1CI#88]-9fGaV]<c.N,
P_]K_cL76W+A)eQUMG_L<.=PWE;_1C^?>gH_@fLBTgU9IT##BdLV8?QV[3E[C_gW
eRAU,(=CfFgg.Z&.E@B@DXI..)-(4;]<eaT)&EWYg<I#b9OKI9:>+7P6fG?60R3-
e9&XUZSY4PdOD-RBEF0TGgN_Z16#].g-M7d74&[]L<S7Y_AfIIWgV<)IUUNX,[U;
T1@2c(+\R1&DCEH/,93K)d[>J-18X<C\^L&M__T(Q@,aFd;:aCWc8+5E:-e-RZP:
K2W2JJSS6Y=HE=U[HV,^0>\]=?X+S/EFf)GL\I-aGA,_Q]CeDd>PbI&?_[8_?>DG
+-Z5Q#.RedU>S(L?-[6bPQ@)MX0bDG(9;ag&6g?L/dOQRO@491></eUEeB=?W7#9
ZMGR]GV0[KC<O+9bZ[[E[fA&[/Z^3PB1&^7+GADUb+7_WG+QE7@6E_bO@Bb[_T&>
JK(:O9e8B[NFGc:MQD9@J60G^SWF0YeWfd4e_1_:B@ON\f)_]607<]E1.R9a5=A?
2FQJ;<A1:W93#M4N3Y0POP#Z<XNO)OJd)\Y]7KK:JJW@L^)g37>^dWa/,42?9b]U
+:OUN?c5>&RUbU4ESHP^ULF:C9OB&A^T)@8XL]2G)88_IfAMcOG-BPBQ/,=X3fDI
Z^OHL4/8FT/OXU3X9:0(A>9dR&g30U?;Y:&NXO:UAKUPDR;D&6T9U2_Ab&X\EB/-
a^>Q?&G##<GKH/>KL4W(+_3<caPAQ\cR(@<Qdb,^)(]NC)Y&R9X5_],&Y3#R8,9G
,PZL>e3@47T8\d)VHbgX68:KJa.C<dE/C6ST136f40N56Qg^JUSf1C,:4+Z_(Xc>
TD1+\5E?[g\+OYeJ]^BS<LC3@cF[9EKJKKP@gAaHNPU,80X3bAPT.=</@WgK<[X[
H=ALY(;2+.VIK=BL0gSCDIPGRA,PSeV&/M,E&BRZ2)9\N+P&MUD7eaeBaI>-(R<W
#([,D+7]eFCS35I9f(7=bX:U.#^H3@UJ;B^=fC/+EM\>W0SQJ@/[]#+1C\,IeTES
+V0\,&4=4QRWQ/UeTN..@b:e+3&#@DHJ\GBA[g90XDLC@,\_)/+^fIH2FMJgEBdU
8BRC0e-/YK4><G&R]7KQAU91=0X65F677M]NT\?<:_[55&]MZIB&LP+2H?41gdWV
0(XSA>MJ7L.GEP?@?L>&]&HQ=:XZ,+(N-/L/9IJa^:DFC.N]4E(g\\-OE=/\JZV)
THf>0;HI8EP_OQ=2BPI?Q<5SEPHdJe6>aMf#:bG??@PJ/XHZ],Q^]@8]&1RBMR1M
/#aT@1VD>8^Z^HDR]CI:b+TbTH,df8IG]0A]Cg-D<6&S?b@E5_WgTg46OA=P6/8T
.F.C:A=-S5JcEC?#76^F^bC^DDV1>MI,N-GC&-U2KC.ZT8a=Qf)-OY(Rf3VM>3[O
?Dd;gf-):;VN6/E./NVgTV:+27:c1b@(PRJKQJXdc=R@@b^7(N7#6LVJIHgDOHM.
.]HQ6191,#bK8T4MUZ@P1B7+5N\^IVgQ14b8-?\2]W28>D=:W-AW&V3BJe/UcACd
_>,B:J9C&/Q?=]0=\5aI-TZN^ed#WU>_E@K7M\\Y25)E-^97+[+Y5^bI^#46(@L-
&8MbQFC5>@,=+Le1(YZT41TV919aE\@C?LS5JL_MQ4&AJ_1WeY=QYN]67<.EEbW_
aO=1\H)/GC.QV7C0Xgb0G\ZgJ^NDdKHU@b>VH2#=-QA.e]3fVC@[NVYSU#]\N\Nb
,da1S]+TTUV>\;?.&1JgW0()f9\D.)f/17T(F<Q\Y3[>H>+?+]2?<a]-R[>J]C@W
b)U+2BT?N9#+O8^^<8S:UNb\@FY]TRC-HgY)G7a=(SfbcgE]?&6>?XRH_V4JC6=2
:C8K;gR=78;Y#0?3>=2aH37GC#DdbM]FMAFec>&f0_cR.+#,.>&MFM06b0UNKg6O
-YXNN/7CJ;KCOKAW2N87ET9;1[c9V#6.R9bL4J&4GI=f7Q@>=Q?3Q;&S]>g6]Q)9
<AfeS<:HU<QC/Nf5\eO<=1]V6=0N;3++gOCRR;6CX92^S2:7VPWdBaFXDB==[EMR
9;NY.>O&6E4)X)f<DB4=e^1,.M_;:[/8)/1M;\/,bcN90K6g8[)M^DA<,Z:H\7)[
E^#Y08:<AXNf-:)K#ZA.-\>_e9?Q^,2X9<E0gH:C,>P?0W[);W:<#B(Gc45Vc#^5
DCA)21>?&JLW&R1Mdg4MJW9-&NJfMC<&&QHPQKF7H<_Q^Z_C-4?)G>:0Y#/>V57(
MY-9VUV=2V+Z]\D^TPM7(JD60YH\P&<H?)fOH@B=X96QH-<.)X[J,.?WCX,Z[9HV
#9A>J.OO/SO#Q?^6ZFKba9SATQB&Q(H8d:7\HNF9.M29</_3NC9cd(\)N)UY6E3,
8DI6Q;GQQeeQVX.]&(Zf]WAa+L1ITIA(/:&e-H62N9NKT.(+TbR:dFX=DbH_]V#P
-0[gZZ04=EJ_<)^8=]Q5aED6E/_NVQ,SPRNAO9&dg^;2gON/ULLf4bCUeRPISc(^
0:>#J]M:a78G:^54R0HHJ/[/5/4.dPPO,(IMS4I?-fBO41I+fDAR&C?+cL+bF2.f
#Q7eUg16\ARUQVfA_:;->U<PDc/9<P?RJ_[3K6=3PV3S_BR\Y<_c2N.D>FXR62cZ
)EN4,d07+WT-;cN1+A6B<fIZ]cOc/[L[g;Z61Q+XX=)WZ2aP_T5J@OQ[bQIT-bRX
0a93R7Y0Q:IS)Rcg=N=NTP_?/0G=?5]_(T<ATaE\:)8:cXb;_?c@93.=>.2R80)D
IU&>1TT>Z97bgXd.OM=Rc/35CO:IP.J9PJa.J[,fCG&>:\dCS.6JOJC<R@4bI_V(
&7dJ7MP:[G6e8#OdDbSN>?M[#A;^]bL=0fa-XT-FC1QBW\AH2#=&;^>.739E]_4;
LRQ[KIOOS?Zd@<d^Z^68RTDP>(a4P(HB#D89W/f=cN::H#gE(#HFBge;XC1^7BV+
]BYR+D)WdZZQ3J:g4.cVg^N#_=+U[2]8NeOQJ.H?._15Tg_bUN6CCFZ,.DdNOgAK
ZM,;-UP88f,B3PP@^fC_HOY+d0I4:<8/EN5-=;CDb35GF:=4I>75Ad0=QBT-N0[=
VacUAR&2+,M31Gb0P+J;Q6DBdYb_MgRPC9J7Jc2;45IK&eIR,FLfTcLI99^)RDCL
CI8.QQ,??X)/cZ1TFCG1c.3Z@E2I8cF/Q19N0Qde5/-[Y@c-MB.X7A(6F/bUgK[Y
:a2O39:X^R#<NaL,9NP[35E5S/:^Y(a<&Oe,Uc=;3?J.T_f.PRV[VNH:E7YWJ.ER
d\W&.6][I9BBIVLa;_263\.bYKgBF7\[YB_^P[5IE,5;LFVJ=;4GJeA:FN1MX..A
)?=f0H\ceZ].gZ8&3E3[1&.Z=aYDV7XH?-VLL<BR58Z(<8Pe^:=fG/:^b:T;fF0[
^[bc9W7YR89(_5c]X4\CHYRT\QL/.E]NRKFM=];0ZY7U#gDA==@Z9Z#RG(&C4?Q2
ed[Uf26-;A-3382d;gCNc?98[)cH^]ZQG,gEgTYT0;_+-8CB1GcS]f:be0TcXR9f
UO[);:eK2:T&>E[C<5BT#cAL&I9KBJDdH:H,=[.,?bbC3P9A8+)Tdbg;dF_(Y@1C
8c.>5R^c61&Z?GG-/bH<S@X=2IPe\T+a7Nd75AOa\24cD^8LA[W^aF@26-/P6Za-
YCLQcc9J?.FNX0IgXQ3ARI31&2f^6D0#cYFD1^<8;eP)R8#>PLE@-=N872e+#(\g
>OWF[BdRc#2TL.:S4IBL\c6MNbCJF^eac4@N7&85dg/76ZgY,STOB(799d6-[+F]
8eK5dg9C:K;GbcQf?(0C1aO>GAE==#L[SG/SCg\#2F=^G=]3+&0BHaEL<[eAf7V9
@66L:G#U2(cL,)I=;,LORCFR6eM4-aEV^a;g[(Ng[7C6W8MS.AVXN=g_L,fI#@80
@K2GJ<F-?[dOX95BZW)+.b=ADEW:MW5AKEM0-0OO?280Z8=g:fRTW@>Q-4+OD^Ng
0>6ebG.EM5WWR+I8S^O\H04M&dSMJH^/J^;@1BFdO4HZP\Q1;8@dXC0[Y7Z<8;BC
f.g,F-[FVV)#Q>0F^S[DN?#HXNe\.X=f5?GT&fJ<K/M)QBBf^BJ)/gg/E;-8QI6T
0?E[/,;RM[WV)3?31GEHLdSBUe-9?cQCB27=9<@ZaM_#5WJEWdRHY\FdO>-S20aQ
^B@8;8d2.cB/=0NJfWCd0]=U^e?E\RZQ]<X2UQ9ZYBAbMFYT(I0SUMa9X3^+99,<
)OgX0OSE6;85G@)VEg\_((d>[=cEEe4\?N9Ge8\2VKXYCTZ,L#?H^1^eRb>:A0+b
Xacd]=?34Q/bZ\FU>?EIOJ)BD3>J7JXLS8ZG@@)EI)EA\JM?MeCg:<H5;-/LT5@E
+2;DK+UXYgP,S4Zb3[RV_22d:0eZP,e(D(PQJTc1P?61QR&Q#@@Fb?b/+G1@#8AX
5TCG.J,4_-7UCcC4_?D?5-bZQagHYAA;(?&.fN(]cBXK:^\W@LVeCPfV,3,KW;1-
;IU3Sc,d24=Z)eY[dbf]9QN^AcK/9cFTELSN,gWOXdS&GGRS?4UQZ@ZJf7O6\1N:
[A3aDCbLMKDT9#U&N9Z3TSeL=,X/.;V8_#<:H(I@&cR,UBV+#?>_ZVJT_YX9@5W4
L].?F)(Q0Md)-JQ,PMbIF7NFc>Z=CE6X;0-5B0,XJ73MK@3882=TgOQ1c9A4[4DM
-N^IFC:<AEU8UK?AYWK-/KNbga:#T)O6Q?Ad23RTca#@N1gM0U[CQ?38(KWEa9V/
U1(9c/bb:b0+Ie>#_Y0\RUaN><Y4(dA-c#Q?R>72?Oc.)ECa)/RK?,E,De&bCMg\
SfD]_<V6[<]XOcA\SN:/eJJ@E,\0N7O&bf1_8c9eC]Tc,Z\,Sf)N<_8P&E\BUfCN
-Baa@5U>:NP@D3#4Ncg8U]^<UYDD.B04JNMHHAPN[c2F@;OZ,#)@bWRG:IX4+R+&
4^eLPX0LV-Y@7gU706P.3;\c[L.V1O<+JQ/-M@:Q4[H7dcc&]AGTY:S(.23LHgKT
2PR]EH/C4VUAX[E8E&XV9,#)bTcB)F8T4H>-17H3HWc/g8EFO3C):L>N&]<B]<;0
:[O2&_Y.Gbd<Te+QH4>+;O5W0@[/H(+.CU)W4RdY1.43TOF.:g:5\&VY9N+&,><T
M4@[8+N;<HCG-M,\,FOVP]^>ZH7_5Z_VRK@OK&J:VG4a2BK7UMAJFTR+22>:D8V0
VC5M&:GOBE?+PQDSZY5H\FEgSV8ff:N[DOS8AS[(^f=PNL+OGA105B]GRD(a+(J9
IPH014P6D>F5]@K?T#O9e2X[1)b4OLW(1)_U81;]@Abe60\1KgH22W#c88WE<OEY
/Q;.:g1G[V/#LY0CE:B;]](:VDE?S,+BQUe8)d1dWPVWUgLEf[74[\[EE2cXFOW.
d5eWE<.S3A3T[d88[[E5Ab.?Z,F\SCZJ2&?W,NIgKX\Kg/A,A;6#9100PZP.3\[<
CT@HWC2<J[)RFDH_5KGWU)4^82G:/7a^Q,2cPCNC5gG&UMI[JDW7f<Db0887ebg1
dIgHZRV.L7_GP9SM>SNHTP5>>1Eb70@ZIS\SDCOb^I2We,.e)FTZG-HHaeY?IC8:
AW(847)6c?_2I;35gQE/V6Z;DYX<XP0D>+L^D&S4(5fH>DJ@;5f00[<6H2;dH@6g
C)@@+ZBF(L4YR(KWg>I,,?0[.MFVZNEBNHC[T2Fc^]a&4DG^;PND)bM[g6LEP?#A
Z74Y81aDUDV]BE8J+=a(MK>ATe6^>,.#R+ZROeCa/VTBWK#EPf\-bbCdP\^#5,JP
)A?\a>\YXI[:F<NT8EIV?)]H,Y[>QD#5[#4(;&Q0>Z+Y_]L:[1>c6AVXI]aE+&BW
X--WaD9XDB-=B26d1NV]H#+Ka=T?>3;]^f[H+,YHVAX7UP1U;a/OO1B?8DA4LZA7
cAH4]WUfWe@[:^IRV[PW#J,KdDG<#U),1\dJA+ANPO6:TA1STO5[e_RLU6/A:Y3D
L[bU>,Q?eF=4C<[a:W5RF>Vd]3Q8_(UXGBY2S>#J>?><T,VVV\,Hg]M[[B=+0g\[
83CA,B^)8EJ9dPB8-7FQ\d2@LLC6T0(W]:<E,W;C+;I)0O+I:^RSGH#A;0&K[Y^X
?:.M54+9b5PS<9XdKEY:GcHI,5@ZJDC>X.+XXfYCSgI[ag-=bL3]Y<]-455-fEBN
5.MUSS&:LNAN)BFP]aX40OA^>(J/]J1aQMC49#e>K,ge;,ADS5RJNAE.M:KC@3e1
SVQAL6FM0_N/=G#^FOX.Hf.6(^a(M0M8/P@E?c<VY^7W<Y]W9&M#LGMJ@]R1VH?\
YQS8GH3)34UB;&85K=P_D\FZc/9J)\NB6+e>M@JMR6c59K#U-/W@232+A=D?&:BB
C]a?F[<,6)WLZX9C1G]5N/#;5HSf9U8fgFE)X&1;AL;(BK8.2US4QeY[5[bHASUf
Zd/Z)L2#Y(VYZ;>Ag16#VU_<6[G6ef/geQ<:EQY[FfP\89Ja>C@3G-N)X,6a6+Q8
T2]Z)4+6T/\JPfB[5PV@20@EO8I?gF04BTTCB=63,_=QB7f\Z8@b_GCcdG+PRB5I
T=ITdTA>L0Ef,O8\?\RMG035UcBFKQ0)8/(>/,R^)_bN2)15/ZT-70ddb;ZE:82B
?^E5Y0##?LFEL3ZI;8GC#;FFL:=IJG\D5JRM1JXM(=(8:K<B.3N8g]A)+AX5<SV^
Ic-;0b\FPNc]<X)8+ET:B_<AfY3)FX-0/DEgdX2_//XCdS9&fRFUT(5V,F[28-A0
0d9:Wd<cJX&N;)dBYZM@LaZ:g=a3U;W/EL7&91D;(0?.?V43M#D56cT3DZDK0_G-
;5&XN?72F4:_AE-&E<3F:K(_4<g1I8?:4FHWIFQHEL)W^E77K,/JcNGD6#.]/K@P
5_bLAbU-9YP[WKM1:[]cTTB0(KRcT;HDe@X<K9KK-E3MDD-WPWgG[dH4^1ObEE>A
@Vd+9SY^G]c:K(Z)GOSB+3^NM]F+8]&&IGNL:DOcZR>?<J:5gId+^]T-VE)]#P+g
.c/0KbCGE>PO8TTG>daD)93c<B(^b);Nc=BA[[2LN<b7-@S::UNScJYH3)b;Q7DX
_7Icb+:60),&^XeRY1.B=;X;__(daGgZ<6ISY=8R>9XbMFB;gAXARIU.MTFcZc4V
YCN_8CWG;G>T[?gB2?:?SP1GWR9J_:,9J[5FQ5/1C6CY&2bPNY\g,W;U@dCLPL<R
QLWg\Z0X_CZ:/aL/F8D6E]^PL>287V\T?I_g_CD3YgY1=UBV>e=&_F_SEN2(8W6L
&M@J<#-\814H^-gB&bP,gcM^WR#JT+YD&Z)3L=CO?e7&)&]7aV?W:WZVS<91GO7X
L9DC\^.;?Bf5?b+5Cc\Se@OCU9SR[,AOaL.Cc&:TTP6@A>b-ORN9UOK7B?PXI<Pe
&;K/34_I0=XCA[/XI3K8P#YA7]=:OHR2\ZKH2aBM7WGQ/K5@Ae#EJ8f&7g&<2g3J
Oe148gNNZJ2gPQ_IXCL.H?K;QDLc(HZ[]M(#b_[CBB3be5L90.a3MLV8]ZQgO,C-
Jb>cJKd3DRVKab&(H(a(AS8f8QAM(:ALR7<ed_31)1GSfbV@X+QU>TV3G9RE@GIJ
21=9YdX[9PGV.3YL&Pa0,V1^Ra0PLdC:O)[K7W][5fb@8a&07+@fbI/L_(NTGC@M
5]Y&AgHT_R<cfAK\673FQ(S6UJM[?U8Jg0E4;85/aW2E@f^MO>/,//XZ\6HO&_0K
OV.<_687N1g9M7>L#Y8G[-7e_U4:FD-=^fJ5]MIcZA<R8W:ag=,LJ5TNDSX]Y>eU
Ze5@KBP=/=g&3I83(NN8gDTP:bDbQ]^T&Ka5D5I#V;B9G\856A3_b8c#Ke[W??FK
A.3?U1bX@F7:&#5g(D8DX-1A1Z/eFc&Y-I&X.WUUTQXH/FW7[:[.OD-e;+07/D4D
YDfd_>.f7a8.f,WFCZ_/MeNO7GBP4M2W=>P-&ZVYKYaPD2RDRVMI&5SRe2\/>:3^
)dHG(0TAY,=4RF\FX/<H9eWN.a;Y94+Y)Of(@1.IEA3OdZP0[VTY64]\HE&0^W;1
)J;YcQg.Z8,DF1J<\4@YT[,A>[<5S[DaTC;4])WWNg:Z^&OaZ0Z3R(cMMO[:C]CU
7a5:=N>_Md0EWbCY/L>SHZaFYMaI/C<YRfGQ>W0&7Ug=e<a<R=Q5V=_Uad4IE/RO
6<1MY\Q3N@ACCe4/_V+g7\C>S4U6:Ra3MUDZQf+@/KO72]_-_1.@Mc4-H9dY8dFR
B@J:MMWUWV)<M/,#a]-8&).JC56,Yac)V#V::3MOL@BO=e1(M^,:C6:POQG\+6a/
PN20,=b7[56I[]4&I8HRZF0AbdT4#+JgO;a6ORfC?;61PEd1?+F4++9^f]\?T>8Y
SL&?[WgXC,];6,.UPNFESG#fYPgNN0^fe#WD,VNQ.73F-3WQcFSeZafg^>QYaFf&
_(R6<TdT\JR,19,4CN:HaW3bg^5-ggIZAd:7>XfVB>47_WC.P+,#U_L0I_aRR2-N
-YGP03-D5[c[&.<#G6PUbTRKed9==CW3]]PIa#FM8Y;#DMIQ.92g)\.=X;P>6B^E
FQ3Td3QQZ4BL0\/P4BA4OX1<)HL-G+#1BJ^-((X765@\9=Q?+B&[(EF4#)1OILdX
#0N7:eR>/&L&MNE+7#<?cTQO#5:9[C]W-=b7WSGJQJ3X]83M40V2G^g<7R(,HV=X
ICIC+=Q0=B,R5\SW;&Aa_,E/W()JJT:g?A8Yg4PKE=(&.HK28]FXfdHC4#77>:L5
[5H(SGfVOX)+b\a]QE?]_YFTa(g96DgaXX5^bJWYN_I_?C[dPfJg6?@eVV-0SbMR
AM_/J62GHDDKYNBc9FC]5F6>LF^Q7Kd<eU/;&3P^CSgaZ#e9)]-#GQ3-^(Y0_E4A
gK[+1YE5/W+YS?A/=TR1NdaF=^,^\+AKTDF:MLTc:6U@8?R#FILM/f7WM+9VA7cb
0B)),(gGC,.SV>^MeQ8U+7/)J?^G?G=b[1BTeTcc\D0e;cTV1)db3VSeHdMS63/e
D_28OHc\B)9B]c+W(^J+<^2g2VEa6S2Y:V8-Ye+I1+5.G+?2MU06YgGGU60O4+<>
4/L221<^STORL;gYbSe,#21\KS6H^SO-74aPVg2A=:+Q+YP0+>9,I;<DfS<:;aW3
W:aK7NU,USe;;bH&0H_NQ^F<;D8?</RU;]a_2YD[:NL01.YIBE0)VLSI?@^?5@YA
Tb4N\Sbgg]eFC9:3&g4ILDLVT8@b[WAQa\8+^13G>S##aK6.7WNH,#20K[[g8ABK
g+1Q1TfNLV3&5AS#dVHR\US0<7W.X/L02KB5H9WKSHC8F^\LC)J3dMD6f^I)AP87
,D3WS#GYWXc:;,W,W7DFbWJ[@VZW4P(<83&UL1Z0aS7;cX[#X4MZX[D57<9TIH@H
/EIW3[Z3:;eZKg#;a@5?3LL,H=9VDDLFP\1Z\=BVgbHA:aR:@NYBfeOG8bYLGOP^
&SbE2JS^0PP=8Q@X/D;S6U8gE_+_^0IFGY<;C:Z(&XeE40R.V.Z4>U)faZH1FJY1
cUQ6N3Q9(>ONS+57>ZYC-3_Pc#:+C_BMcc8)3Cf5KfQ(:&6)Tf9A>=Q?=)>a^6=Y
G8R2DQU;WBgMf2)[MA=0JY6I06<>eM\58a0&AYWBf8ZNP#YWI]7#WcNf.dS^(J_N
fMT^@S<(HSQ5Me=-dOU3JK@.68LbUeW/(6gA(J,#SJNe?B5-:&\HPFCDdD?TPR@U
f/GEK=)C&^D(E[Ve+A[N\,3;J0bd-c<3N;bF+&eC<HTfO9H<AX<FN1IBf5eVD<T:
a7C;.WeDLA5M+LaM9=M75JYJ>853H:\3;(A/FBg.5FZ)6.,aUF0)[5=296VGe7Q5
Q-c-UR9GK/]J3XM0ZZA9WMg+@8G[^Z2S-(KHS9^d7/bC.L?Lf6>GG-;f^_g0B3Qd
R_P;5?08X8\CS;[@1g#<MGI2]6;KLI.Ug:aW=F9&(9BB8FPX8+,H7LMWMCF>3?9<
f_BJ_-b(0d-H>e?d;<0f8ZJa3G-V/G6ERPX/Q2d6MQ0_#&?9ZQFPSP>)UCIgU=-a
MI@#]1MH3\[-E<V[V1X#50XCfG6;0;,0eX<?FIV,Z6/gDLUZ0#3]DOQ-9)9#]CWc
f/YRP89d8T_L(E>\_1=-/:4BI8)_(K6@[-Ea2[RQ:4AZT72DaLGQf8Cg38?#e/dT
;OUT;6C0#Ug8&/N[+55bUfAVH5,3Q_-MWHJX#;;SEYW]#6aM54W;(71QN+S@4,5(
I?&U,\E5#g;[/b6ebdgRLWA#&SXV3SKQA95-I31#TB4Y?47D+UgH3^CYFO.6cP;2
:N^f2HFE\K2N[<CYLg,T\\4(DS7AP9c]d9c2#_3L@X6\=cfCcB?GTY(]_Z:[K:L_
7ZeO#We@O39C^8eVQ8Z^,_O:NLFW#O=,^K>)IY.A.X7)(176>,XKFe_,dYfSX):9
8b3-&Hc/KY_71.X7Ca.8OS86G_X/@7:WB]?24L:+0/BQIB<-\3G<,6\L>)T,()e_
?7G2W__M)PB@^K;0R-:C]X+QdRJRH2_V=;Q+>&&b+\LG(L^49F2.Z/@VBXE,Q,)I
KR-Ze]<XHT5G2+_.Y@<a-:\0DRBYGX1;UTA0g&X3Y3YR4;HUZU1O(:Y^Hg9XU;R?
e,70;YL[cbU:B-6BKQI5Q=OA?E,BVJ75/K+BcKRKLYUVGO34;WHfgAJU/X>CMY>5
1?a2<d>C[)caPbDbS5c43EV+a,LdKcS:6KM=D5CB9G@/G+JW@#B+;0b(/KGZccYK
5YMIfU:,RI_8_06f+>aH<I_C\G1-/c_LT06M,f]XM7<8.SAf1d,P)2Ja&da2;>/E
C5cZ0Y@4L4>TeST@NC<=abN2FM18VV<bRSK193/S__KKLRb1,X\g6A1dK6#F7b&)
E:)./@1J/J.C\<aL5HO^SQe:Xd2H-2<Zbg&LdF/Z#-#FaNOORI9Y0TEcY,dBTTZI
GPa8)5e=<c;<#2UF&I78#<44RIXe#:50=TUT^008P5[7Fg<[b,OQU.a@)LUf+S]7
87O?:Wfge@9?I#E8][fK]61L>7cQ1P(TK;\:F[Nc2Q4I@e>NSS+ESBMQY)+(W=UG
01@g/Bd&)09RP<H^eEIGK3_)99_G@]2;P)0)a[/7U+35fKGZ36(EMc4PE/&S3,C3
ZF.Jf(T3ge0@3O^cW7,XMO?(,P)):ARM]Z/=^YD83Q#f_EXNOEE]]CK00N\-cP-I
;]Wf-\_4c3WU]G3Wd1b,N.cC/-:FZH;W/L-HTQJ_1-cJV]VN7dRf8:CX?)J5>7]=
=;B5ecY(_;^b^?F&U;X16AZ@aQcTWG1fbKG6I0[+cQ\/7_5I,g((c=(<F7A[_PQe
P8^88.YPI1DIA;Zg1)=.d=W\cFLZ\F\8WN(OGEUDbMRYb(bV8E1OYL/7V;)Xf))D
d73H@1W3P632BeL=2WVE97eSB8LZI/Wa03Z/+I<AcXHfM?M1cW=2>S(PP:>E>Z_-
X7\f.I\gHN>8:fD[Z/Y@_6#LgO,CEA8=V0N=cfTeeC+\Z;0U/AJ0/AIKJWX]eISF
Pf./Qaf+&-VS_:b<&?8J=RK8F8QS5#J]W+I4bGH6fI<2dff>HgRg4-[81-UGH#O#
WQUKU@AQAM<aT70G\OT4[?TH)=<GgFVA-F[NM_B+C.+IMfg#FOf\K,4OK\.fB8VU
ZEbH9:A[DPaZQ/EO33:?>HdVI.2;AUbSL.3GJ^(ZM[]3/[8\MVL=R<^;.;BBQa?D
^[/6RG@]f?O>QO?2J7;1ZLU@FHfRE=<FJEXIWIE(EcO9L9F<?:VH;#9aW_1&^Uf^
cY5H+3CTG:O^)9C5<Uc:T)R3ee7a4I8d1]b6G-fR&)5O,V2J-X6Z1=[f73)&d?2F
I8G8>2)^U@)#XS@&C]-4WL(@<?NTUT&R+=Ga9<OL=e7^,HROYW@][RN:WJaL\(2+
b>+RW88dG#/(-D>9SH?_J:I&(,@X\N4#2MKS)09b)XE>;DQ>_X7NA.OfMJec@LWY
-I>dX#10B;GYbYI1ddbQW#YL:XLQP;gc+7KS+=[0)D_b[,\DSdC-_<R9T&/,^?f+
bHHP);eZ54dfEcU+Df[&02?YRAT>:_GDe:,Yg+?ANaT@L0+S#4S>L#0V:<)D.554
M&dU?,;C-YT_TE\bgH0?+/PfT:5APdbfV0Xd5]K^-0/J?Mg;RLI:B+;1+5_3:]>2
_OgF7CM-KTO=^BYa6:BFJQ.;H3UKH6B5&74PQ9ReM\^+(8<5MXA2&SIOW5(R]9,F
=YW0:6V#>Mg&^GJbL39#C#cB7@#^)H,<+^:4WL]c[,YaR4-[:AKFR]<G?]T8fV&Q
TB\dX.^b>4GX:4AQ@bF6QgY]e2dd<HG8c\2FFVc-@Y^0a?R[@SGTGY<N+F93cGNf
#ZC:7QYRO]cSfSR+9fQ#6\IQ\JAPD[Q_:=T/PW^B\0cZbb;geO4GeP=GLW<L?Qf?
,8QRJfdQ;F5/[@45.=W>T=F(gN:?2_&fPaCWLG_07(A#Y;,^CPccT1Z/HVe8]b>^
<LX=?AFf,?=6SG]cK7L)M=G,(DR>O\A4&GAc@g00^G^JDXRMRb./>.f0:5BRP=2M
ZFF(G243+;+^,:3(,Y&>?L->Ld5RegA)1;=2^-=Y_R509bXg6;/3\Mf^-4ST(#1V
FP6:M@/K_PH(D6WYJ_C,O58JcD8[5)eU1gW]9Y<1ZB-Uf#H[J9ZPOW9O4e=d8MDC
fQg8cd]Q^&XHV//)a2Z=Q#@H]/f@F3/aBC]dZ6[/69M0O5F@I,G/ENM9=:YS&<>&
/aTD);@B#gS]CD7a6GXLEV3MNLHR;\R>>ffH5Zc[#QJ3R1LW>dMc0>B#2;_+8P40
9=EG&WEf]c9)@P-4#V5efA-3?\G5L)\0WebLEGXagW;G:UJ];OK.cCdYcO)Jd:RU
H#TY=@b4(DS&J[K:SOdR;Dg]:1gLg+]?IHAN=(HZdeR9N&PCCb2D\HUfd:Gd>IIU
//9)Q0[R1P9L)):TE1f.8I5QK-M)D2>SN/YA<@FUaIY7><d=dI1TCRT4(aQH=FHF
CF\;&XR2H6+9_&eY@P,:8A(b[2(Ge_DAMba<L<<U-8V#9cXW5U-#Z8+?LGZgJdYE
_:/Ja+=0RQ.<IOebXbe87=\d\K#cB1.I1Q@7>;RS/5_EON#IUg_\b(V:1R(/440Y
H#01LKXOC<QOdXBYR5RCG2BVX_&CA6FaaT+[.C7(I^_H6a;E(-D1.&MWC7M<aGOH
-(afIYJK2R<JL(XN9V6Qge&;D5]dBXDQZ2RJ]=/PVeFUQGK3&U65]&4XI\JX?@f&
L?aU9RK_34K,P#:\?[HO#ab<d1a/aI\:2&4Bdb-QT:?E-[D542FGfH8J;GF[Mc7N
/.[=^]a/JeH-P[/deCFDO7Ad(L,d3AX:a[(bZP\8.P06^g@UG)#S6LcfSBN->Dd8
-_&cW^Tf0;D])WAdd&a+W386gCT9)Z(.RGFN_U6PA<#KHQ/FQ/B1&;XJ>GCK8.d-
H:36M]5Z:fb]6Rb[B?Q]8[U<K3&a@_5ZB>gOVA&JaEPTD-gQS9[UfCe4Fg)<,TKB
KIB0KL)L46P=cR8eJ&<3X>MBF@.=S_R,V+\;<bf2I[1CAXPTNd2_/#L-?O<(Nfe[
M?Yd\7\a.UQ.D]I=[9NV:83<bEgX=EX^ZG0)#873PD2247^,JKY\1=9/O^45[?_H
H7Lg/JMI^(;=,83#D(68C,0fJ+&de7^/?Rc03aOR)WAXJ0aE57O]^\AZ75:3gM&=
H2d^#^cYF0_&9(78?2f9U88/8D+NcdFC^[.Y7g+H@T@cA\L1b0\0Kd<OH;(-#FD:
8)7R,[H>MS[<eU[W)bL,3=GC[;:&TV\VV<U:)^^U/0;GQPTI+N3R\7gKD;f).L22
)N#SZN)IA0e^fV(-59)4N=_3\1d6,:PQcL#X]fcAH4J=4R)[9O^>d-fA0[X]Xd0f
OfZ?A9.#4b:ZSDQ,^M^NS)e0Of@.TGTQR@?U)]-AX^\SZ8T4G=dYBKa[0\96><W_
fRS[/R7Age.Va74YQ+[\Lbe]JTI7,AC[W5/EBfU9X)?8fWg;I,]b^3@9dC1X4VJc
d]8VS>)LE:Te5M3TEI+64.O#3Z;HAJ6AJ-cCX=UZ^.)Oe\ffaDQ=5(<aa_>B@ZR)
X0E.6c+>aY-K;=Ab#g39Z[TXA;V<TWL=Y<DL]._I6?5_WEa-XV;E<<)d6ce:[YQG
ZR8+>?M1fZGW.E)LF?J2E+[TGZ&J[fDXSa3XX2D\?@CcBJDM2+,FK1(7_OX5<?RU
f&8/P+]J[5f.Jb/[D9/F7?@aS>.IfW,#@.BWPGb2+_OcB$
`endprotected

`protected
C#d^)>81DO0+I8O)62H;:-Yf)#NO_AcM?FCXd;M+F1[5@X9GYaJf,)L@G9U#BLZP
MaH/D\Q2dAd++$
`endprotected


//vcs_vip_protect
`protected
+000<c6_<?fLFF[0ZGe=?SaER7.Y2)==N?N+T81]P#;U;J._?P(9+(e^8#E\P5/T
4ZRJ3a?(-UMM(3]ZFI(<3:ET)gaUE^8\c>_8NXJPR^N^AdH(gHe2+SO75X)M??Rg
dbDWH?A\a[P0cS/6Ng.0#J]H>=>1=W(_5:YAa1#_a_AQV-S&;<)=&2#B=7KN71O3
65^+dg=Y8RS;PdHIbS:V30Yc0G@e8cU:UNH2IPUa^[Z27)56;#dM-LVeXb_aS/TQ
[f-IW:=7eYEg&ZZ@_M/,Y&0^P\UZ;6J,JO>gRK:7[\gA-fb(SdEf.KNRH/1,#=.f
L#dI?V?N)@/&3YB-<C4X/Q.FPe?AB7[MYZQ,YUfUJ0>A<UA@_CUK]@).?.UU;]#C
G&3-7\RV?QG0;9Q62^_J_]1U.R^6S0Y4=@M,BSJeT<OBfHH;T>W6->S3.1+7,?d+
]QLb/f.61KQe0:N]@.WfdgH^8BNTg>LG=B;Bdg.P_MgWL,_8,HGFF&7NB]:>@Sd]
Id]IU6aQL&Z2:S_+BN=a)PF@ZI<gQ5ZF>:M)ZXY8I;3Y4RCB76fJS\KXCO#+X)gJ
^Re7I:C-F-[:b#ETG&[H\:\FXbF[OgVH\d(beQJdLRX7LI.db(H4J>cQb8W&THW?
D+bZc2<LND=2L(;JZZ0J^S9HQ.;:1#,/K32IIO)7Q3ZU;L/=+ABaC@92RTI-dFYJ
_308&X7Ec#<3T?M9=+?6b3_g>?K^L2/,5HeF/,<F)b@(4BYJ9&PVe9HCc7(>9MN4
5DKb5W#7]OI.KH>.6fP,=R)^GWgPE86.O80N]B_].Q#7#6fRP@NKY>;N_SB]<O66
MQ5[^cFG1PLT@D+g<(P)ca1UGeLD;8[_UZM[TOU8]2EfVATMR\fU:A46?=dW>bUL
_J]=PO,+O)UZaVGNL_\34c0&,]aDD7J9:=#2=\^07#aZX,?/9UC+5aY]2W/Mb#JN
M842N_PN_N0RN.3Icb\^I[)TJY\4SO>-U)/34TFa=OTFP9TY<1KU)MS(MPg:e[S5
)26_:?fE(PXW(M2fAP6Vgb8FTNP<OVd4RVM4WY;X#\&-68;[e+YN_;d2cMDE\f0D
V_&79[<cMJ9@,IN12.YXGD_X6=TWSZDY;1P(VdQ&cf=H[+TH&-5a[MFgA>UI)7,R
7R]XEIZQ3)6/T?L2=A2[b7Z2T#egF4-GRK\EMMYIQ>O=dDNEMZAgXRPD-WF,<OV2
&JTME#-@&d?\E4=XPd<.LPD3BHLCMW&K<8>c9+S7L;@C+#F<43C/(0\08IX[E&+P
T,;0K@W9QB&5E>f&_?T&__E.T:&W,A0YWcU;]4OPC>6(W0P>I\-\dI8TCMZK6XOV
f5?FXbF]Z91Y^\<NWG9OdX1;7g].K9M0\ZCS4LC9VA2aNV1eHPDUPafcL;5^f]JX
@/[GO//8fbI,gQTLC2Q05R=W]MJ+MZTZ(@MR_gd@TT1/X[Q,2102f:3XZF^&ZSCZ
G0K#:c4b-S;9UT(5UY76MEOF[R;B7<^=O_#Y2JP)eZGfDaT3OH][P8]dU^5L4]ZL
[3N<)NHU^dY&L2c:N^2O01MT(@ILE^(C4GP+#?[4Ea4,94d9ED&X<S[GB)+H;cDI
bCCH]_UBB?Q,L2+^.+.)<AP<,/D54,+9CaXG+0@XaUGVCIf^XN>9HMM2^2gLX#O7
V(YQO2Y[G8@=K3MPPS>MD.-dK26OXK7]2\?6.IS#SfV0PdM[FD7Y7N0eZ>9K<U\b
WE+g(9GS^W4A7I9Y\<5+A^K0BSH61f\]]WTaZ\PZZ5\RcA2d[_QXN#9ZBMIa^MVC
Fb/H)89dLLZ#d2aGUSNeb0.M-[WA2-_Wf@6Xa5HedVc[#AR]bX4?G&4&QJQOL/D=
9MV^L2=cYB7XBW6+c95C40f?^g#6L[GX)VJHFM)<#Y:<_???W^0[Z0ML9OI+CRd=
SS=T9W8I(N3\@C0f3L5H0c0SO.g][10bG.Q5?BA+beMdBaIW=0RFL7_^:4OOJ=bG
(8P3&N1DX<gS?Wf4CU8N-cTG#M0SA4cg?GGR[YWf3&1^;\c48:B.=YG5-ANC-Y>8
=\:@aL8T@?[\a\\9;.8ecE3KPNfOe]PD7N=XS_GPY[c86]+8,++fUJE7DJ&7@-C9
V5GeMNFc#JHd+LS,NZ-aW1^-?GRD9GQ_:afA+BV[Ea<J[B8J-#O_KIVa\dL=&^9d
LWPgTQbPA&&f,L1?M\4);;5N4==;VS5@Oa=VcHeXHVO5S>#f.c09LWfe6/]^bL+]
QfXP7.5bgde-(RO+2MTHc?=0^)=]TYYS><3Q_SJ;.]L,FGDMTF[CT@?(/5Q:E.@G
eJTg2)?[3DT_3H8(QCGTX1EVdP,?QN/<&^@<:[b9[Y35eSWCBD#<4^?_7Ra;5dQ7
[F_#AfD)cdG>=K;YV(.G<8CCg>AUdZWJcLSfV;K-Ef0GFKH-W6Rf2gNLeLg61VIQ
W70dRYYAbZ[Z[RV6CbQ\DP\&]YfH[Ce1SJB4V]HHAJeP(S+g)#R?&;9:TSZ/,VRY
.J/BUKT/0<UOELDNS&]&)]:0D?FBQ>E390NRe^[a;XP:1W/VeVPT7+^=0E+JXMc(
[\)59.#1;8<<W_),\0P[J5IDQ;,K.X]0aY?[LTdERZ[e^BRS,b7-J9@X2)D=FT/<
R.UdfV=G2a#O+G3SK=JbB=T<?;L:,5;FS=H5&VY_)8@_VQP0g^J=)X?OA[[&d&V7
7B&+.8.AQ-J1fX7(I)^,.D)9cC^J8<TKW0CeH+N(L9bJOf^Y&Ub5UA/e7]>76Q4A
&H;4K61QK@LEOBdde>g:+K>BYC[;IPYE1045A]4=b(H+)[e-FcdJB6aUId4D8c_2
MC^5>DB@E:C?L=>NF=MK0E65V5#3R;;(ee(eY^=BX9]-R6#)GKG,H\M<Z#\Fc[aA
0<[a35e3<KT@#.bd2H#V)[RC]KEb5a2aBZf2N7M4:[XXa#c5Y67[K6#]_C0AODg<
O,O-A:9565CB+L4XcVBbWc?R,a=HX<<];cWP)N_F)[QVODd.B]f2>Y#^D@QWeTMI
VUKcK.?(/X;-#@4Y^=9/a>,>FL&-(WX_=#6V5)YbEK24MCI(IR:g@9Z;Nb9-X.UA
?S&QLg@\_E718d/VXS-UDX&UIHWJIEYdORbXa[/Y^bFNV=,(,60X\+SD9J:\CKWF
E&MgM750[C>GGV0ecMaY9@<MJN:-,]A;M?05<).WgfKRTPSPd[P.7\NE7Zgc4Z/1
8g)F1:T12O\/M[@ZVZIQA5b/gKJf#ES5]-)PNS.S]BS7KacI:WICFR3.ZDR)..D>
e@AI;)ZH0S1CeQ,JIS^],@];-&_\4@#&J#JIE<T2+\9EQe+F+>fBZSS-D9YRAAAI
R/&Ob(3ML-1SZS5@[^P-Z,M\UL^@VA5-HW-X&3;2UKNad90.gUP=MbX=EZC>,BAS
B&M-Bd1ILaETYD\?I^.#MFK93#J5;^J:@_#fa8b+X-/E/7@7WSPGbVgXc<-Oc<PD
<@QLEfbc,OHDQ.K/XF]H=[/,cQR)VdL6fc2_DCf4S:aJW8<,G(N7XRHZ/#8^bODJ
YJfR8^BVKNXQeJeM+Ed>I5?KEBYDI]aCY;f[NQcQL]+]30@[-dBQ-2)/B[?M=9B-
P_1eW9P;7K5#VO,2.X5(GB/e]B6TbQ/Z222cW[QZ]HXK>7^ObB2d&eIFSO-0PNT7
#-0Pc4PgV=cab&C73&4(,:/M#D#FEeR258I>I]/6ZX=Y@B6Ta4P/R8S<CVFMK3f,
dUc#9&W2b2)50Jg^;>J#^VF46[6d8J4]N_e.Ub?:G+#:FY:NX8W8S]<G+M)cMUK2
+<d+Vc(e/:X[1AFY7#(MXG]M;7^K.S74HH-,X<Tf;LOa/Q1aDLgB\NT5KTYg.Of9
?EBdS]d9G)dYVfeE[I&3A.0FBA)USF@HEaIA(E8.Lc(B<W:BWR1+aL4Q=B+QRQQW
]AMHgGK2b-MP+ecLR^B;J=Ecb1&eG3PPP7Q:06Cf.7aQ6(RF_:[53TO=G#Q]HVf^
;?cg,R._EIC3(K7_1g&M^F><TOHTM)<Ea9@Kfae,<L]5RL5F60NKcA]3,6f_[48+
(GRMIEFV6/;Sc>Y)4-)B\RSTe-_U,K\^RNHUJV];a_73X--YO/1a_HF\6eZ/4b;d
d]bX)XdE;.=(Ie/bI,.;J?BJ>FOe<a2(,0SXL0/gAEP^:Y_M7\S5Y;N-<)J/d3Cd
^&?BceCXfCG(fEA,cdA@b3S.FBS?g)C+LWTA7M2-XXA5#Je<bf)#EMV,\^(LML.0
dKZ-gcENbaB+F&7A>dfH_:B2.R@\2E.(Z+JYA<#e^3;&R/9H.?QV,I88@I6e.#DY
+C<T;^&P.-@UPa?UT8BQK7C@8gJ=8#^.DeZe#3H>4XY7U]N#.O<XOR2(;XM;&cTc
8Kf6#g0;)-;@T>M)B8CN50&O^6BMOC6+M+#Y,ZJ@KQ89dISdJM+[Dc[X3Q0f(UZ+
O3beAA4^^+OM#:B9>P7&Pe+H&ZDgc;3R5#S7a1dLCS-&&5O,?I[E0e+FZHT>.Y(f
<Y9P<>fe-[Oa)6.A9A.ARUa,USXePc)Y#O5e._La)f9Y1\Q-)Z3g>4L57)RRdG._
9\+W#K#VQV>63T\9[@Fb24&Ne3Ma\)/G=KPI1/dB,O(P2f,C>5LE^78Z;A,+Xf[\
_@<aWdbIZ>T-VaTagB^EDCWR6HE@YI-B6+cSDV,.3f]NP5[X1b=?4#_X?;YTXd&T
GKDAY)f^A7_8^S\+C?@F-J.Jd-1)?e5^E?37YCNEK8M)>I.T4[gD&(Ke:V8@)^dM
+ad.1G.Bb[#8NY@)QHQJZE7999W2O_c@#Z5>C/_UWUF:L4#&_T_I16)-Wc@R@QML
2S(C#dT=59K]#BY9W/@;X@AD7,>WZPW7@VN[^RB59=@M5f5e:DFb3?Z@K<Kf;fg(
C15DRJTIVE,+cbM143Kf>XC(\E:M/PL[^c]OZ\G2=f@O5[NB?A:;b4,e_V&23HU>
/#N,&cN#QM4[E\3c2TDaO_>XV?LG(S)0f3_gC@aNK3_N3<e;Fe)T.H2Fe3WJ[FG1
d[_KH_9T^fWfV[gdPLJAO(=aX[X=4I:B9[:YM-2>L5]dLB1WN,.E1(Nc8b6<<PZ3
W-7/D.62X9R_PHE;9@GdV>I?YSQg01TF,?TN4GC5Hg.O[K<7DU6+AY^H#^NB7?;I
?)e1L6?,IZ=1Df;C>cb)-N3]+6d^XEaUI\<33Qb\@\KeT15gKZ9E5HHAC&/N>?VR
UDV[5/G8c70_AKQAE081Z(3KGe3&-=fP9#.)Ge-e^<eJL&#.B8)YATKLAg,KHC.0
a#AbMGMS(ZAb&4J?g?+dd7)ICTfBbF)2@NC-_=U0M4<W-Z6_-ONYN_<1M\>eUeX,
)g0ETe#@L:QI?1MSeTI:?^9+>Z5H^0_?_EJg[(b59A/BC^OR<,,fNJ2;OZgeYg5.
#HZ42Ia2F14W3)L9WAUZ@P/PcfQI=9N.^cNJ)4^[e<c99CYF_-\(H-<(UW7Y?R6(
RU0/Gd:4^,#;&X;J2KC:c=H:DfYJ5+H,g@:XU3Xf+:eeUfB>=8G&/Y_M0cXV)&G/
48CK_d+Y@@IY[HeLg.3S7JMe:Y9?-Ie(C/)#V-#dQ.?XK?;(f]SG7777/=D7Z##?
6(\^Q@b-I9+3GM3&D?JfH3QeRPU)23O[ROg1.O7;SM:<FP]N6KbL<]RSNgN.J.:Y
0D0>Vf(YO+TNY,8D0[]dB020U7<U/(0@K2N@R<X4JKV#AWMc<ZQJ4_5X(@79N?:5
M#/TC=[Z0XF.>E[OXAB:g>>NX9K,>e1Bg7;U=dacL/H](b=CKfCH[K?E<\P:e?@4
f?P9T^gQYYH-N0-<>O?8,d0Pf+T/E^a,7P=-#-&.g18F@eN4XZZ&6)1&G4QNH/K3
Kd-+?a4@#I9P4.9))W7\P,)Q:E-B+P\ddOA.-,J0\BLeQ@_=9#B:3SU0P,f3<QP?
W[gSc[^:O>B_2a=TF3MH_a.\gg6dTL1@#+^cgG/PY>a+CcPfIK-DLN1?_,=T0QBD
8&#EU_@PRDO\.ecO3:K?.D1QFaX@:6MC?UT5?ZaEcMXQ8S4\L;L(AV995R<04\[T
7]Pe;ZPM;Ie\)Z5E4PK#bE.AYac,7#FNCEB@)P=?/ZU[g:QJ+QdCE;)]9ggEa,(L
aZJbd)@H33J+KB/27>=[@-/)bZ&=Hc,KUMM/(9H:YfA.G[0f;)Sa[C:#EU(:/=2H
fRV,9U-+=0:6PDf1X3QN,\Y88b<GZV@.GR2R=N&A,?;8C,X9;-.2MV&?T0PH6-#O
cf.dHA7V#L(X=)I0;\cg_28Y8TdEODaD7^,b&McZWRRaE/)g=\dcD?CN.=4Z+6Wb
>V[bGgS>F^_M^<eNF&3c.POaQ=0LR+DD#\.eRQWHX9DV66_=UR;K<gPOXR=IFD;4
ZI->_YQ^[;H3)=^TS1=)<T6.D\2[)?R.<PYG=KV@XB82g<MW4U/9eFS[F8)0U(V;
+[H6dX^4Y_)OG9<H-dK-0Ed28:73H,31D9e9DCCeNbJ5HNc@LKD6]5KV;V):DGcB
@++3?Z=cWG_f#XT]#>J-cO&@Z./(W4(0O9>I8F2@&PO86M[5Fg7Tb46-_7AFb3.O
NR5YW+4bFC=3N8S/f6#H6&#ESN:&17EC?]+1be.bIW4>2aJA<BTR35917NQd(g\L
JGV@+IH\2eW5Ab09#)cZ)?cYTSdN#g\U)A]@_T>]Nbb31)HS])?8ZG&M>^I6XEA1
<<J8\INP:NIW(.&NX)a3)59SUOTM60XQ@Sf0MZ)RD)109OXG,<FTMW5,_U/7PZ:d
=Gc]7>bRDHg3=0>+6#I+[3g,CJ4K8WT5[8N2)9P5-=NIK_bQ[S\8249#1=Z7,]Gb
#OJ.W<AQ(+FAH5_G9N\M:FIS7K\3KbH3=V>gXJXTeHJC<SD@.&[]daW/dgP1\)VU
:_#72=X8-4_NYB>VFQ)[@]<E#)^U2.FCIIS4ETZ]bGIPd;@50:9WgdX6HQT\LNP+
>#dV4H9==9N^EZ.X644efJ6Ab.NfY3P&g0a+Q/_EB&8<?Y_P78PQ6NTQHb/=XO1<
/ICT#NC=[NO><gH5#C3eagB2Sbc>4.=Y5S+0PT-TP1A3?;M0a^bbLcA;>gF8.cX9
L\^OE3FRQH.(B=/2N[]VY6=;8(D+0OR^PSc3XB7\R?/eaK).N4fD]B7f2X6PI^[6
c-WG4U(SF)f]+2dMF-CPf\3[Vg,f>A/[):H=0=G.TCe:XHEVa\8K)^)Sc0PS7e#]
RT[#N=TL?XMGVWK=F5BED:;^?bXd(+ZU3Y;@2FNfTfYX:C&Mb]0CLNX:@?fP8T7#
_2EN1:.>[)db_gQ?J41I/.]\.GRC_X<9CL33MM+5TL)&M+g[>a:.]81VPE^;AeZ3
e+3V1c@Uc-TS&E:g[MeBeGB7+5#U:8eA5ZDPFK/a4C2bb&NR_E)](fHd@I&TWPRR
;A<XES;5Y1^HF-U)E8/S:L3e[DUEKLUHCcJ=0XZ\WN^gPUZW(DHKCA3I<-Pd_4e:
31JFRR.gb/INJaO&f>cW<)J2Sd_[4;45?G;17?Qf;XYaS&48MJ#Ob[H80G#@Id3F
IZ-DDe[:=R(G,+Aa5PSWR0B.TQ<P;RI_g<,9RM+=JTe3#gC#fH9NVeY_\6OLM/TL
_6=?W9R.21)U[\1N,,).QWfV>:J^dFG+Od6/dWgK<e+c-ggXe)+edaDOJ9Gf6CZ;
8FS6(:<-[=N^18]f7Y9E]YTXYA:3PX#0&;GR1CQf3?-?W1<b_6d2fVKb:92+>N-0
b2,fb\gIZQ-93Z2a+ONDPLL)/+#_e_.9dN-R^8VY40VY1LB\-K/O=:IO6:V[F>OW
&FPCJUJ4,Z.7\B2>?F.4>(RE;@a\T+]Xa0QY?dC9IG#VY]V0;V=)]ab8Y6/C<_Wd
2JN9GM(ORQK1[VWReKL14IWGZ/#><R1JX@XaB8COD>Rb1=gY2?RO>+622,IO^@J<
#-LD?2>D@N;c+XYO#9,dcYe\dgH[HfNJZ?Z+#9_4?M#Ve;3P+=;RGTUQ)+9,5AIO
@Ke>UBXAJ@NT?[MOALDB@K7O[,9Q?+HR(e5=75&;#>d\GY<=DOf&1@7c9Z&2=2.C
_]C#aI5.?cTAH[U=GUX=^54LE]-fFEg&:ZKGX4&0(M5H=BTa]_//\YR9R?d3RR/7
a^d5GW\.Pd4QM&X<M2R&,3#@:ffJ8CVN&f:/N5F#Zf;95RE84(_M#4H/O_./2c-a
\\De^>Q9]^b_#39<0e^7>+c4JFEAB;N<I;J)I;B+^8e.>La^6[I[O#b#UWGL1c+.
30,&O-[[A6;?JFHX+7)GSa7\NV:)>7U=af7WFEH6I3<Tg=+YbBRQ7+0XYa&]DAA7
/dT>8I24[S9G.\bNYFb,7[dFc_J/Z2E?XI,bW54g:,YR&;)(9>RM<Z^a,2]?>S.b
G&8HM5.Waf++g,dPH1#AF4^GI&NO3^T</F8W4a/?Y-K1gF8V9]I,G]QPaM(ZPe&a
aFg2Z3;D/0OJC\[EY#eM:AM(CY/aTe3]YG+.gY8XSW:_AU/WZ0YW(gV-a?ZTS2:M
7A6<XPa7=>T1SX:-(DT<:8DU/_AK>9;/F#d7_:B?-VA(S?0<6eDX7bH5\J,X]\Za
e)T:;0(;fK6&<WK[L;A13OQ,1RP+D5<fF/DZFSC_D/[9/S;4gGRW3g?7<G1g,7W)
f[_b;#1>/L0XZNZRM<F9E^>1Pa#FHFIFT?O@]RU//P4E2_Gc3SeUV<2[^9G#);g@
ea-A)LA<[Q;2Rc@V]KQJ@g>^2c0a7eG[SN7B<OFS;@+[5><LDTFPd47.&#PCO0F]
A,f;##&<TbaOYLF@c7?[W7^).=_=I<;^3_G@?^[FA;ZI]_LD&N/<V1\)OeSQ:>&A
]Q7TP#49J)V#JOfW?g=042H5c^ANNL0^Y1E=T#]EOFBRB4,PWUB_K7bQ&N3/K=O?
/K3Ge^WD>?bQaB]cKW7U+?]BWefPg6&eZA[LYBgO.P3#ebPDFH3B-X<2-4fXfK_M
SS>f,d9/C>NN_1[S:6E2J+^LS0=>#OXP#\.(g&b)J+^R1:I3\K[dB46^fRZ28S&M
gDRW&b1VaOQOQ3FSL?:;./ad5#<J0:YBQP/62A&[F+FCa5RCTJA5\Z0aO5O(+Y9E
>cM.9EaRDO1/2GK0gbQEY0:cLA.3[O#@+.?&\+]VNYaGZ.3Wa&/#R6bZ^=([eJPX
YSURWUe/MbUaJ9B51;,3GT@0e3,H-LeYSATga7bbg19-LPKH?#JUF42a<5I;3-H@
G^dZ9-(WSS8?7-8(A?;<F=]Ka[CPgQAH;@X7HRc6[\=)&KN\K3K\O=c-;14DRaGD
c[KMMZJPL[3#TGf>Y\OSBNP,6XS67S@=XLB8OcBF[GNN,-SB_PaE2V55PW]-H)<a
A1<CV_b.LWN0<dO7Sg39K8N:^F][^ACVGH-#FS]F=:5K0OA)9\.NZ7H^RW=3+XCQ
52_@02QcMB+;aTc\F>@;(@0SdI9W,4=7,4X+Hee\_]&Gc4L^TaF/(@,d7\56,B&0
,+P0INL]U;\fOC1I64Uf?T@K9gcb6P-?,Z.#HVR,U9\C\B+8f0>F[U,HaXP?/H&,
4bM9#_F#JMD@O^Eb2AFI)0e+1]<>4?9>[DBJ/S[N^=(.@8g;12HX1GcK+_3Fc>2R
U<5X4I29O3/aG?R-C3ScKeR&8d-2ALGRN/#FeAQ+N?O-UfTP6I91Cf<-X.)e^;XW
-]->Fb@Yga^JJ>8fV<;B+8R_P97e4C>G/cGY3VX6Hb<33fMT1b^#Z9B&/SY?M&]I
g@LEPOb:2SGJeM5_POLX(L>&8H:O?VM230>K33,fCURLRFJd+&bYJZ1GQ;22<F5/
+B#U)Vb+@D/#D+7[]7_M#391>\KdN]OGJ>9OIUZ8R/+4)ETJP<V0+)RCF2[6#a4.
0+f3IWXBGEU&.<?D5>1-\O#KQDG]=2W6QQIcZKI_aKWcdRJ?W_2XD-68<ZE@_EI#
Q2ZN[TJ(-^A&4TXWR&d5.F=Yb=1O[aPQO:,LW_>79^G?F_f]O<b15D=@R:AN??cQ
e45X;g2+fO55[JT(IB0HO4A1W^_c#+-TIRYTCV1I-b9<b2.=Qb.T+W>?d/d-^-dN
>_ZAKCW<M][A=@B9.F;W\XOU/H2W&HNSH/,8&MT&L8O1JF?M2XR60cF7Y/^a-H.Q
-TJQ.#VHWe7^+c:;#b69-UK\N9.?G5H7b^/4a^64[V\VdL.]Rcd6]FDZ\GTKYEXI
U^b6GF;N[YaUT#F;#0/S;VVb0#IQ8Vc]c7V(S\P&RHg?3&.VN/7D2Q[AU^CS02N_
@Pd,\BC[JX4ZU4^0]IN96@#QHXb/I;?U\@CB_Q]USKF;K>#K:USQ@J[fF]X]Z;VK
TYPU/+])BGXNUENX5>HG\d.OT@UYE]##7g3DW55DFOe9KLC3VILfF=?F3JEP90-D
O1O3R<)1\Xf[6H=_^dc2(I,2:8<6d(Xf+1);CCe[/+&/4:g]0]2?JG9@9^HbAWb=
9<-XP(CGVU.6Nb78cJ>AHHU>B?.fV>7b4&bIbWZOS:Q^.aJ\891Bg-He9JeNE?]3
]Y.N]V3?73GfgTGFfHcPE7[NW0aQ485<PR,#9T_eQQ/\e^/)?(KR.7-Q2[,VBJS)
@^H18YK72UHFIJCN#/@HTSOg,VN-g(cGf,KMa\:.HO,WR1D)69X3Zc/EOI4R31JW
/=3D@UL3)IS(a)M#&N;QR+5?J3HSK2ggAMN40M5dR/^7LVC(eb:(g8&BW^+(GL=#
R?;&93K4[DDMRKOfZY\RWbNK@cK\-UR2dLKd=P[PG/SV/V,IedfL<f^9^I)?0Rb^
QVK&#&c6]N+\)1_KDK3Z3^OP/)Tg=1V=&G3afGC7gPF2.&Z8:/A@4U/_M:IOK#Q:
1S8_\6AA,EG-HTW20U976DZ/L3^[@>QM:d/D3TK)d4bQVA.e.^/U<Y4e5CW22BUd
,Y@:^D.PW=PgD^SZWW0??THU-gJ(Vd3\\-AT5V(P9H?=^V/7ZB7fT3FQD67dG>/(
2&QDf1K8WW<9O.&1TDSG]<5dZV:D^[XO=>0J#(SB=I@6=##B2O__)D1N09fg?;eF
<?UJDFZ6^LVD<5YC,FHK,.27]FVF1AS7)^6>#NCb:.C1I-]MW=V>[WFU3+(W?6Yf
T/USTK+HNMT==(J//BCL1HJG:L-0&dC9/^R]Ra^bXU;X;U>7.>>KL\fMCV5=K=+c
B(cF)f5(AYS8;,0;+Y?S81c]9Od:[<^F_1I/N8dd.g?6^TRZS<J&[,.#\dUK(:ER
1(;T(gJ65g5-E91f98(C\X24KN2S-/A<<#e>QeC2+N32b\bHN2)0742dUFYZRb?4
gb)FLR_]@V[A@T-L^:UHe47EXA=.@O:ffL</TV7#@Jd3T[@<WEFEL4If^=O#Q?1&
NQ1\c;7:ceJ6SW-@(I[8dNXP67<YJ&9,U0[/JE@ZKRg7.;#:R;/1:/I_J:D#V3#X
HX9A1,,=86bWW9<.DHH[.3eM>P[ff#3+3UDHNN&/XW1?K]AaHR<K[]V>+92S14Je
bBRE_)K5^L9gFIGI8c+7C]\VSTFE6WcRfSK+IdP6-&B83MWYWA[3a?V=AQ[b5@AT
84T&@0&2\M74/-1)\(M/4.O3/.J&;S-QHM>_3\LC=fcL8f6H7ELUC8(,LCNeJ2R,
[eTc.:Ke]:<VF&]1e,P>3/];e9S0KQ23RLGaC/[bg,_SPACd=FVd_<M/&Z2S@WBe
IR9^&:Ve[YA>YDI?9a1X(6T]ER/[\ZGA2<&Mc9B6\dN>F4Z?6?c]>Y\ZMAO2bW[2
2:DB1+8.^2^>^d6Pb7UK6+A<&-Q+/9/94b[]-Uc<N:?=_>CZX>39&+FXSLVW:_#X
GLKNI8S19NB;;9BE;b[(P&Eg^/caK1Y(B#^f+8GL-.JHB./+6ObB57/d^8X<F.fd
f[D;E4JdQ;/_eZDX;]Pf=Q4&Z[8@7X(\(J/0R0?TK]Z3Tc0)<[Vf9\GL/L28V+;O
3QU?4L,&3QM-K5>Q;MQ_\(/\5PXC_bVNS]4ZNad#@4^O3V9-+\VR13<,<92:EE);
8J3/K0DP6VZ\#CI5E;7VHFG,HE&?S[b8:<#)(6WE;GcV#/KcI/I>Q,XeBESF_D@M
7Z>QM?a>\f7;EEJR4HNET4WcC@#)7f-0/fTF5>Ga^F/]1U<Q/F6]E/H8+5;\BC9b
P1Z4QgI48S8>c8#M]N+NL:62f2eP-cB9ZXf@O0I1Vd6)29OEIaJSL\C8a-V:;/</
\cX.8;9S,(NV6:^0UU&7YW^UC>QJGA89MY<HG=#W99MDb[V\-KBH\dQV;3E]L-bV
#(7gJFNFNZ59]4X:f4UPaW\;-@gLP->W?5]>-;YL_[^_&[:Wdd.X1R)RK3)-:>JX
I/YJD-=+^>6Q3WDA19\@J52ALAL\WVWTDB3;1?L@O><NLUG?S@LR:XI=>D7a]#EA
cdIQG([FR4-;)aIK)N6Y61F;XeW2ZeZD>@)3VS13RLWaI?[VY^-LU]&HdV#a;2AS
+dOeNPW<M7D/OQ\+M/)8)IaURU9^0JSX.+Z8HJ5/8=[e<S,F=/AB6EE0R&2ac8JR
,HP10/]3Q/OMM_\-,8-,Z&cfTCgU@)0JW]GF27\H]X3DJ^R9#FMI^&BERQL=F<W+
.H+F1]24P&/VB[J?_5g@c)V^g+,_WZ:AeE][L(Dbedg-VKKHWN6LI&M&09Ma.g]3
X=#PG&;Qc+E1Q2<:5_a-+/Fg1DLfD:/?00U?fc)K/4aWOI+6H,;9@^?/:WTIE6Q4
<&c@4ZWcdL,McW=N^<&XETN:e5Vg+,;SL\Te=21&=W[&b0\);aUAQa1H9L2+cH3I
R)Lf6aO_>>-K59=Zb#T+H[^e/O9b-a0<Y31bC^F1KEJXX\M+JGP8,cg]:[H+:d&F
80/gb#V_,YF<2D3Z(d&^\-4<MG4)?DI7F.4HF(#QKXIC]NW;SdJ_(]?U5V^3Q[P3
\R+IMVg5RT#T3GB/bTI7]X\;AZY9g3_W@>4g7\FPdP@)^(NZYL4M-ICA@_S:9<76
:<:;1O#>1,Ge\7@@8.IfN+O-4^L+M7dOJ->,1XKUA&K7A&MAC&BYe_])Z-M9H[@X
8T00&\<.g5ffB.dK&bWc/5EB:-QaDC07&OW30b+@0X]>U],Z0O]F]JY36DfN>3]f
1]-=?SEG31X&2AU2OZ2b(?(WB/+Q3WO#2K<)GG3d#T\PN,:Oec-ES#2K9(KdP\8Z
/c;DRN9<\Yc(A&#7b5+B(eaN<Mc@38KYZ@IeA6<NI]0(XV8F]/-ga06(P4F8;9EV
J;;>\GD)d/a6G2[,/dPec766:&g)]2;>:@F\YIZ?]WI2T.c(_.H/]30Y3H^L:\Ca
CL[+QA,(@O]O#<bX7=e-;L1C+9Q#Dc&I.2a4J[cdb;(_R-Re>B9HV/Jb<&:X9Dg@
A^d\R@?/,8^JUON<(WNIf=7[8UMfBYKeM<]fg3IbL7GT#>303BAV.10SU40]g8NN
WWH-Q)/H9Ue<V>L:BZ6VQ(bUFRX?0IY2@<c9\9_O?Id5VWPUdfIc0)..1AHeX&GG
7JS<T@HEge^>]#)+cbAeMVSNHgL7_d-MWA9Y6>.58)-&Kg^Vf+7=D],E5]=2_W+F
CO/KaI)T4T^W].12g)c[/0KF9/I0.f+Wa.O5\TIZ4Q4RDT5J1H19cH=T;+NS_4aV
MN4@5N2U6Q7WP[Y&F1bG/UIg0Q13Z&+<QBCQ_e2a#4K0#,H&)OQF_.af>A\7cQ<9
gN9AITQ=?DB+@]=Q6BQE8L)g4>KQdSTW+#<4,W@_1RR>Jc;T5>FY&6:UW/De_@PU
)7Q3:=a52[+V]?9UB/K-MJPd<dYdQ/:/f-QdEI,T)+;e@8P^g7&6<8?+JY;YP4X7
ge\:5]Xe?()_9R2NId^P(<eSCA0C4g^#1+YVE(5C\U6/+>AET0^QWeTMV>b,+9gM
O4YcB,_R1MJR.75=?)T<+=JXc^7RWgX00T)S5YeT.CMSbSCNcA/#7aV=8G4?.?eM
/4;)A>K1[Pa#+/K#X)2AIgOQ?L(FV#8>e<7IYF;F3:Oea/CK)63F#:1Q:@UFQ\6(
ZU3aKUb[WAdS^1[RcPE\U_H2SHdQ+LAA\Q0<ZD\F4e.KG>TIdB::RA+8?VUWJN5J
HQ-gaPHD)X_6#4FNa?.T,3/d5EUXN.2?_0JZ9_+0fA_5&+2<gD]).a-JN[dANWg6
WLXBfFT)>IIGMSGae<Vf-1HY0=F:R(fMCVC8\3@cDRJe1ENaO/^&g]<^\VF^3L\e
1::#eXO:\6P,]ZI7aCBXB7_\eY4cg/)cM2WD3RbNRaK_&\.W+cX9:7QQA-=RBg\G
c9aG>6S2g)[c]-;@g=H)W+=I8Ma5Z]F)1&T:JTT0YI/W+-<N>/WZL-#Q9:=Tf(:-
#?:0S:)9aVUB0@\PYRF#>3?&R1C]-,XF\A7([</HUDaCJ:O.CS,P2gg<]/JD#>,d
C3dSH\^L>2Z7QFL@.9UO+)d#_@T\RRA0O&W=UKf6]&;N09#B+/\9&Fg--V;8B_3Y
ITZF;b=:+<&@PR>\X,@4DA:Q:-^X<[1SgVU:I-,HFOH01VJMCVIOfT.G2YUU0Z<\
BaCG>].La.5W,\,5M_V>,d,;]7[NHfSX#ZAU<De)D;MeJ4D:2UG9K=;.7DEE)9ZI
5(E;LL:TR#/\=Y#2F&PQIe<.HMG5C:aKHYeTg>P,OMbd0@R.:-FVa7Oec4-Q;ebQ
E4E]?AG+Id-bW38(@.eHP06\X0]3J+FAQGUd]YBMa+=K,bKb(gD4dZ:1I\56e(4^
AW#Q@:OfMVB9MZ=?4)Z6cdeY2eN?[B;]V^U=+cccAWb62<gb2+KBT49?H/[<I[5I
C;[GgRHMXMd)+P(10=F[gd&bRAMQAZ:B@c.:d3IJUf3/]G725G/E@&S@#b_>73+I
CF1:\Nc)+9\EE7V-\G<.Qg<N30NK,dAL3c^KY;SP9(gY7.Q:7b2E:IJL>dfC<@Q5
D4I7RN2]b?@]]-XVF6>>OHD<XIb4G&1;_&U#5[#.,C1O\^1e:(R6fP1NI[29F<CC
-TQ>_[NQ8RT,#H>S:a\\aQ;[UV#0e.I^MdE,>Y0#,6:_UID>dQ8P(AA,a,]7cL_T
0(ACWOCQEfKAgUdT6M8JZNWILIb(RUT]U;B<3D\7]P^)2FEa2aX1ZX(B[+V)UGXD
ECdT/HZTU6MCVd.M;+B59,#T_I/&B9#X0WL[d31R8^7EQfYZ>9^T<D_8&:V<gC6)
CH.J_]31gK9EQW4Y-JARL&02:(_fW?]gd.)\OJcXUc=1,,[V8]0WYPT+a&[ZaQ.e
8;//^98@/Y#.C=4>L)ce/>/W96dD2RSCW_0N:Vf/=_436ca\:>::MW(<CKI(MfZW
C:d[-b,dQNg[<Tf=8>C.51PF4QJcDbJ\VIM))6_.(@O=_9?U84<_QSA5a@_;^#<g
WK>KU-SGQ);3+AD1>OFASA9b4:FWU.N]Y1]MJ[)D7/B/(e>SV.XD51@9]+FA^BMa
G;^=)I\K5+a]C&0#G22P3P^)F-43OS2U+gU?F#</HMCE4Df(?,cEdNL-LCSU/NX[
cb38_X0?eNQ[3Z/VQbSaKJ(gg2K<HT]589B7:Q8I?O[X2L0VH-FH6J0?4/2=PFPY
VWQKM-ZTI)RT);;X+-WW\=4MQL50=N2HHH&.:H]e:65L.(B6KeL\<:+[ILd=KY[C
><R^S=XVH>)=6XF41F@#7_0-+W-^UYd&b.FD9LY&\aHaLY5:LP+c>de;L786R=P4
e,@/(-C(B8(A(CG+d>SN_.g8b]:_;/C>2^5#/Y(.g6L;M4FbYZeU@Z,JJX8YaS9H
aU#>X,_HGJTP/7(P2,W1a20+VAC13Eb,bYCS8W50UMI+52S]+27)5Gf_(7/V.#5a
I\O1HXaRV_e<^8Qd&1[4(dHA9:]b6[@<]dVfTN7PJ1,RCY\.5KAW>>aJD7J_DAZR
O,+ACf4=gPHC+KIR#9<0;9/4)/0gD_,A]=Mf:D&D/P[+a8V:?dGPL6K1E1<^::8V
>d+K;X7e+7@Wd^Fc6d^Bg;=I#Y;&HQ1^28U7=<DCX0[?B;LeRMURaT7/Rb<-&11O
S(=c1_LOPLG48BV;WS:XI:.DN)ALCSY;6W@_-6:V)58(f0MM3CC(#V)e4a8ADY]3
83AH0G72J8A^aDF=Id;8=DD8:W]WA5-fOV)ZNe=#LJa404&3^((ATgHIUA>HLK<(
\<C?8aXOLVO3[fLX;@TP1/gb[VS/K1R07FW:?8J]_,-Ha/OaVIf_f6_RH;PU2@cV
/=Hf//(:A)aF_9]L/<]6[21QPRca]R&KeZ7,GIbc3VeF9RR8f;81,>I16TgCZgVK
TcBPdN[VdL.d@(L?gO;:UYL7eFBI9,JGYb\EdY>4:I9OKVRD7=f:)b0-(;IEcFLR
S/3dKZW?F=;;E@;+[##[PCQ(,fD=ad;TAIWO)&/c&V,gNYcD@.3KTRO57b1J1UEe
>8^>)VX6@[30W^]?)KIB(WANbF?f64B^?c5?U_=1P4M(4aS\P+G5:5EPDG2Q/-:d
U)0G?Q@#CeTB37_=^]].5D/SDJ[g,9eWcf5F(2Nc4MUT?\YK[\5a3\9,a2U<+7Z3
cFL-2G=@fAL^SN=+XX5[PPRAW2@@B7A9B?]-_W/O>[:T(;R-?/&5ZID_WJIPIWSM
?RK,9A+4NB.(>A>)23=&2^bF=SO=?F=:1Q/1LcZ<@/cC7M82S4NR0C)ba.aL6QEZ
6SC_EW8U_F<K[90R#)#\&2)H83c_2]<PET^Dc#S#&+[YX36dHO,7.YI,--0@-gX[
L&-2QS,2VWK8&dg@WCKSRTeFRIIL9X7G5@Jb6S5aX6.8gPUD)VbV8RH>/:A)d]\P
U9^V>0S+2_Ra(]TWTQ\B6^,b90?DS[7NWB9.YB>BXR,GLS6^IC/ER-:+;/&2EZNO
b2[-U#>>3#]-Tb)dI47\edZ\PW0DafEPB/g89+JfV&5,Y[&F(1]K[M0G7.5AQ?dE
;Wdc+=X4+JK)W;7PUMeFfT[R5&P823L50P_gOW>dX->(W65B90gLb9R,1D1PK26_
V7ONNP=F8]>Q[KOBSN9@GgX(,GE2;U4<IgX1R]g1@AFLTRGXe)8U=R9BTU?Ja7+#
F78XID&.:/?]=cE_]721NNfMGD).XQ?(O1R2;01_YMd1^DIcgBgEgH^_5??B.SIf
CD9O^/g@aR^K&e8(X60MC6^I=BZa1dAgCd>A,,+7^<9,=6L&KFAFb\VS_D]\T:JR
T+M+:#\_bN><=^RCaJJ#8L?N63P+Y\:PO<^La2=W8C7dH6[ST?)baL>8O-T>H>AJ
OGI2cE6;9C\;@/^AZa,dWS[?K(I9eg/Qb:9==T3PFH#8@,F7f^M)<[V2S>=d^Y:/
Vg-e0FS\VW,cRHV9PYD4.^d/;SdNQ<gNZ&YHFD@1R7EZg<;]?@,<5c.3PMK[BB_:
YT-_YW-HRV:/df]@,bA0UF:b]IBc64\95-L6JFd3UGS?00J?J?]92GMfb:gbe:AK
Db:UMRA;H3Kc=:_4=aN#VU?U<8OCLePNJ^A_LdVW^RRQXTbS)+?Z9I8Ig7cFGQ\:
PePO(fYQ(CRT0]/]50DA:1])=U)Ee\.9R4[dc&<C59QL4@6XfQ;S1ES1WR)fU(fJ
0_8J_da]:&@<O.WIOb9V^a@=b^OXMg\KK,S8;>J38;D\-CV/_)VGeggVf\77@P[/
;Z5FIgKEXd#W:U,Ra/b;<U-b;9V436X15dcURc03d<T#d94Q](Q,T2=9a,;K_39R
0BdY\SI&2L,b&]PcE^8P69T35Z9=c<G>HbEIf+]S#8R^R./?b7;F#2_<_TCDZcJ7
O(GDa5#?NX\,WI_0-_-=+g9gKJYB7ZOb,&OY(J@aPb++1ML^(eK>^8\_H@U.UABa
:8H]T+Xa(aWCa/4[D5&B#4Ef@2N\6/B48I6b-GC<,[[MgP7Y(;c#13Jc>9SbDYQ-
ZO@1ScAX#(Z[R7G9e?Ab1-=-+0SA2)agRAEfSRX+/^_27Dd7^1YBF#Mc1[\F5=VB
JH\G(-)0Y6GaM+[d51b79;a_NQOCQ\61g4U.5cI+<]34b4PSg.cR?F>->?1<7+;E
6WW,g@g82_<_2>F-(b^]DNeESfU?6IFJT>-Wf<6]LKPfYY4XNJA5FIHV\f)O]b(P
]4cOf5G-]XS3?c6eTg?S^^&bDYP8&eG)4)2e3YDQ]8ZI#M:=][X,99N(.IGfebGV
0+K?GIAVf&_.[[@)S_(47g;<GK/);<_3?]VX?S(=7dI6C_a@FEC_]HD)78]\..<3
b5\+<18>Qc>W?b2+-Va=SgT[PF0=D.dX-bQ4TKQ9;+)(7U_#WRQH?g,K_XSdga;X
1PGSX.N<fM@:EeG.TS0#7C6bKBDbM0b\LE,e(L\)4R^QJ4K,Q=H(3N-@8aWg8-GJ
=M1>.A\@<a,CRIZ&I0]?FMXCO\G^6d:?c2bG<#.@Y)/ddCN<F(H4+#O\SLNSZEf3
:BVKSeWFK6g+EZVGR/>5c>(VOO3Xe:g0-K@K7?/&JN^(-Y7SKOR005a5(_64:A5]
c1\XCYbK3CHf2>4_e)c766\.^<1;XNRU-27AJa3H^J/aYE8F;_cCZZJePW>?9Za0
-JS<54G.6L0^3(@T0eeJ\OF31JG_;J5<3[.XNgQER6/bIE33NDG/#;YWc:d(fG:C
>>IU_Q<X;;H4EV=-U;aD5X/K(X6]]KK4bJ<S]>NQEDR7HK=ea=R=S^1T0XA641M+
13)^b&?_;Zb(]V0,WP\1^TWSbM<c]JZ&SbRPF/Pg?URDP5BdH#/.=?)JaHA4/VXT
]B<6Ye@P428#,MTgA0^VEXLXgUeI^U:N?aVWNO?,Of,7=4F;G<WEgMC_90[5D+KG
]Q<J.>7W&Eg6_M>/Eg==\J/)IA317-&TUf8<=B5P>_MSXU[\ReED\1@+DE\?)A.;
S>28cL.QYQQ/EPB@=@V-L9\a8,9aD.N?SCJ24D.[Nd_QG9IYf0C0;\N<3JYC,e#5
gY)Z+0eVTPKJC1MaFLQL+X/J\OY[+R_V[a5H))0+4EDN?B:8YPR1<d[fIRT6@.c^
[)C56dJ;Kf3V[6.X/NVQ0J@79.@_J_>N4FQ4G;Ueg=,>EP<C^8H.?HH;<1VI(Y:D
_=D=UH(EBD;g:8VGA^V2<7@\SZ5M2WA7UG,[:d#RY,>6L-:HZfa(\5;8aae=HZ_O
>aN-+?/<,>cHWP#YH:DdKKAG7,H0dCJ:86R(GdL]L-aAXRIQ(a<M:11+_E-^3[cI
-@^.3M_eg?cV6U\e\Z(G+Q3I=+G[a:b-_D.d;G62GXD,Lf15cA,<PB?/C@7C<N9L
43S99#DfQB2.8]?N=ITBd?J9Sc4H5@4_\I,&CaXDWWXZ(;@gC(&.-+5FXINU(+@^
5Yb9IRBJ?Ye<IW\(f/d4eB\YMVg/dde<FI.[fQJb29ge@PB/V]NeG2:eNeJ\3:P/
J0/FQ:CcX;9QTHE>LY#2=.UXO@8Fa0:).,C]I_VS:B>CF_F;Lfe&UTF(bE#R.VTL
+3W6D&26(&7c6d7:aYW;T#U45X,-8g0[SKTN)(1UgUd=NIOGY:DD86WR4&;e2[UD
D\_K1[UJ:=NBgU-]G4_YJ]7&[FJN^?dPD/GE4-I(>F.BKBD4@I[\#,D9A2WcO[S8
NLRRCQRYfOCR_..gG_Y?bVQ[(9U@YZDdc#?e1eE3(bO)-@1UUK.Y.fR0FbL#O0dB
9(TW^@gC:fO/7@O>e-)#M0QB<HB-GCQ?]AdY3<=,d59LKS3\^M]_94OUS^CKO6OZ
X,@.OE8[H=?Q+VHZ,4JQ:X#)>O=FI\16PI:.C89U?28IK=E)dcP_M[aM3:8X?@bc
I3<Ja0MQK+YKX]BG?HU:[88:XDNH#aZF/.U<J[3=5M_\_c0[0Z<)7,f53MV<_1^E
b54L/-NOYK-I[ACGU]AHcf:9?5HM==,P^(0?ceIVb+.U>/<6=#IO#R7Le/Be?X1(
/3YI;LW\2\)E_0[]/2F)(XFc@)C<ON?\DBO#RC)4_F#<DV9G/5S2,#UUNaY+XT/N
=:ZHBS,BM:#DXQ:[(#\II9N]X@VI[?K&FA596cM7K/9U&+\[LF[>c7)V53GLN+-3
KZ_aYdX_)3Ne<Bgd:K#OaZ[HE;(8gfYR+B;0_Tb00b1Q4a4P]2FQP76+fJT4OBPU
;NL)MWJ0.<1[?]WW6DU<M,..eaCT[[fe/M,.,]Q@F0#Sd)b4D9#BFF.7[WZ7#KRH
H@fF:>+FWEIZ;Z@fNQ2dGCfDR5NE[E[Be6P5<7>)]I/6I62/LF\LX,U.>MBf9d4C
65^J5<A]GNK_<LMW\1?UXNaG_GH_>YaFVE4WSb.RRTF0U5)NLDI(G5K&4c(<\Zd#
6@P=[P0.HP9.84UFeaE@/LS[/+aJJgW@CF37K0XOO^-^Yd#4>8Fg\DF5^,cR]C@f
LEN-6&2FUIS-14@QYH_0.UW<]7#Tf5\g3Xb#+?B/YOG/3-X6L0\b1>08g.8@/NaX
(;-_IQ?gdQ7I3+EX08B^T//?7&.<P<?80][J4Q/J^d2F[O&.R]R.WJQIE[;HH&>&
FO^>;B?95>2-@eZ(BP,R#,#,RdSCXB[bCA&\>8U1b:3?KSHIea-QgTLQ.f^3M+E/
f>;,3A>Q&EXBS9(ZAT#d?U=_D3;Dab=X1fROPNCc)Z44V78JN;454e,Q=d]gNaN:
+ggG25?UD4_R9/+U[f+(/S.4@(,PGXXCN>gXQKH.CQ.eY3)>XT:K2O/D5XC4c1\Q
.1C\0C897#K[)2_5=(;]eW+?da]f8F\F[aYX:FMFD<1=Y.[6A=Z/S)bOTB@gWE;<
_[D<5K[&J&DSbHM10JW6;J+&X,0HP1X,K?E>K\(7]M7(M?+1+)7C(YSE;e:U?<U<
FXS6O/2b<I[RCQZASY4+V3aL67PJ1AHRVIF)0X->9@8I.DKELHBI)6:K8A^2I,NQ
AU?><gD]64W\HDTM/.5P8#O>EN6.,]_@T1/5:CSV6&_ZN#95eM6&b2=K/3A:)fEM
TdP-LPTK8g#<]#K)f^):/KUdLN<>g_AI&9RbZ.ag8?Rf)@H@Z)-/>bA_ZY^g;-E/
M<D:6<5)B<;3b88a\9FgHV;baGFc)GJ:+X;=G2_ZUD85#K[?7Fd\J<Y?Zb73f14>
1]-J<6EDQM=K4<XeF3:ReU[[^Q6879;fL#5#/2L)AXAW5L5-;R6=7]E<\/FL6JQ1
K(37ZV_8BO-T2<O2P>PQ5^Eb7B]5\<]SH<2_2_WNR:GC.BRf9><b>3AGA?6E^VGI
GH&ZAG(aTV3bVLS<9:SD_IfH>JHG^V8PGQG_<EJ=Q53Y7@JA_](^22fF9D3W]GW3
eTQ[\2;R(QFEMS8?8I)WLgG^0L]5-7]<@+W+aDEH)2DZ6(&897RRG[d8d[;R?Gb&
PET?-D6^I0M.?X\@-f()2?UfA9P&d3\<gVZ#V]1SC5C]X>&Nd3C\481(]MUI-d.O
?^^4K-9,-a8AF2EcH5bU1b=V@57N6cG87ZB^<P74QO3]e9(f(HJ;VbX@<0E;TD76
\IYMFgO7#Kc@_Z#E])NYL^,Y6C>]07Rd,PPM.71AC)g6>9Ae[Y#F[D#:D;YVP\FK
:Wa#_TILC/9TI5^=K1-^4?8P[Y8SNV,(HZ)OC@-UKMaM=13Z\(EGL\V)c.(Kfd6e
E9Z.#gM;B=.CSOKVBY:QQfbcNEA)YH,RaaI2QgMJg7IVgK1)74d/N^e=Z=7&1>_(
Ld_d&DI-g8W]&[f1F5N5CASfR9eC4+^>g9W6fG,R7ffL+S9K;FU^[#/C<fc/\G;\
@J/RNaUd?=eX^X6PD+Td906_ebMD+.e:1]be@;W7KR5^#GF;5D:(,;40g[(aM?G8
F<I2#Q@<,.F9-F.0S+Q\Q/;7;0DTT5LDAD&DO>@H9)7\OCNH:/1C<#->=Z?U1^5J
?5bSR#;A1^>>+V.>Q+1Y0-KTC;NBD7:Df)5S+ICcf.E4<Q@(E[>2RfNKg\Kg135e
.E+D&WH&aAZQ5eN;9\IRE92Y&.e_.d#O1MdJZ>d9F6JJD0dSI@A->1NQJaT0@M4D
5/@+6&LA^A>>ESNb5K>]dIIS;=Vg./d1f?]a+PF\NV^HA3HZ(dc2F;0,8;@#)a01
CEZ07_R0#H4;+K>&C18738&4QT&R0>(59)&dXgK9Z/Y<37Uc<5LC(^T)P1aYULVO
PgA&V)dd^+[MH)WL08>&:L0VQIb7K;A+DA;OaHb#0BYeI-\X)>_7EEPHQ)_2>_6:
?F^92/g7f1:R(HM^=U)[LfcZ?WYb-O3HYZHMQ78<A7cO8.:/[_\T(/Z,8=Z,__LW
Za-Db<QRN,X1;CC=Kd3=@HG@-&fMA/ee&[dA\9.U)<0,7>@]d#T/c2b0<5dKfM0_
190]T60U-g39[X76cD3P4^S&<c:[AW9,P_dR9.RQ1RZS>3J=V>VB(JCG+4<@8Ca^
FY#D6IB#LKJGXH<PDXe/Xg?,Z3,fcbA:^caVUG4C0[\(Y5M8Mb2BF)A,P5J5#Yb7
;-+O8aQ4M3HA;_#?FQJ(Zc<T6c>gO5/&-6[aY:QW0c)^7>a]A^GXL+D4X:\CLZK=
;MCT(4-?Rd3cfHH3:<)a]+NGLg3B]?XUGAA@IJ:_S=U4P)JE_0gAa8]9(.R:T0N.
gGE7\e3UC)V&M:#gNP&I/&<,SWKQQNZ?B+3><FC]9]VYJTCdBX6_C]S)4)0?+_K+
_VKX0GU&gDJf39.g-O-@<=]]_I/:f\]2Sgb2,-0@(&P7W]]e-8^+12?CCCLU:\4X
2Tc.5<YdKY8\^[G[dA6]#gB@G&S3U>H;8LD/gaVEI&,@64YO.U0\T=6d/[2.^MN2
)7:^cA9d+6<0HTT,K9B^82/Uf_5IBZHDLN9ND:gPZLOA[Q&&EcOf/N<e(K5_Q(.Z
C)[MOE6ISM[&NFOL0JDA5AeY(>F>FK+C)@#Md=KLG5X)Y:39;1@8ca-?L2_IUfU=
S-;\KRW]<#Z6MK\Z5OagP),40\C;_X).gWO,#>EbZ\;g\KO^7DX.QB/GQ;7JKOX4
>@gYg3A(ATO5S6^8X3bO2KJXEMMLN_><FSeJZ#/H2cFA7A>=49.LNOab#-MZbGPa
1#_+0;5,CNaLY=2[0]N0#<80VW:0^RTW42-ENK_Y/M]A(05Xd-gVC#1Xa+&H16<g
GBe\AA:#:aQLW0WHSR&5J#>)ZQ_F3-H0XA\L?WQWe9?FTS9-6W+OF:P>L?]0)c-0
eV&(T(_[,-DKY5WPTL5-<^F4Xc1D^cOXJ6_LB=,A:(2eG5=Wc@c]DQ6+b?++<EIS
@5[@XegXgH,SYX]NM]e1(:W_@[3M8FSAM@27_ZTfLS#MLW&FA6b:WbbUC.geV9aA
#4C\;VK>+@I\QTJM9V3dR7T_U@2\92,\8g-12AC3KMJ-FDQ&]G.?FO[&(3;1&_:H
-(A0E)LV4?O+=MG5,.VFDDbE]2.R_\[^22X55N_G6GfXN-1@;bN5S17.<e@gXS#N
[T,^8JJG&-KTT3FQc+(8C:NC1+4ACe[SM5&\P@=WXQ16E=N_f9O7?CX##b]=2&=Q
/ZIGaLSYcY/8XaUE3^-EL4c\1G&GPeQ:R/EVFe79457bFYe/5fd?bJ/Y-CMI,I5_
BE>#gJ9]DJ/MT7BQ[50H>^=O(fTH^eNX_W>dKgI,SfR=(<^XbP&-E89+>eN@,\2M
=W;W3AC]b2a\WIO_0_#YI9G2D(A1PMeU#3L(^2E?46GQNVLKVM19]EGA=4A]K1T)
TXZU;(_Na9SGd(f8MUSW:_I3eeeCW#KV2^#K(]dMU8+U:55WIFRE.ag_<B\<U6S>
;Sg+:fAX^[;Z8.XDd\\M9Sb35A/L6d:W<]ZCaOMfKY0OV\YDEBd&YNXgDBb4#8<B
-<CQKdA)1;R<cO:DH=EW2GJ1Xea^UJc\J-9a-&b]-CT8]ZbBFc7fGQSX1GAf#:Z-
AaeQ:I+8VfTVYC6U_cL&FHQ>A;\Q&J4Tg?B(#Dae<E:g,?O1K+R60N=eTgO#R,=P
O-+X&41edd?YRA\].g\\Pgc#\51;=NS(YQ?ACZUg78E6eDFI3:/RC4)[DCd\2Pa_
3L[=PY3VO;BRSd@KMQDWgA-VJdVeZIaZ\6[O@b\Z>(P67f=T,MQL2DJZM6/JA=[T
.3,PO@0MgID.08::@BV#6+<NHBb(E9(H(b7C,K_180VIcZ9e-22(g<)K+5R+GWOc
&;1+gRT6>LfH+Z)=.-=?#_(=PQg:X4Y-@LU^R/I[MFBN;ed+/927UG#2b&TGN&L^
<MO0HILCSI;I(RDFZ4N2C(7<L0bTRcLW7A?LdZZaSg=f\R=F(#SIH,NH\^f3E]OA
[1N<VS&#GB^?=2La7edFV_f^/@@@41:=[V^)/0g6AaK5=a>Pc2Fe0/C+]c]1+TBU
PO:3[095&+FNODC?+Me-GM_3Ee8EV].KUe+0CD22RDE.AbR@#78@-(ca@EP3:PL,
BJ/V#9.Mg2M8RAX5eK@5,#16N/8RT@VMP-?21DVL?ZR[\eNVTSW9CZ=NKX4IZ5.4
#P+#-(RF5).-Q09\:;&#XXJYV4TbXcRf89QEBRcSZ-D>?0\\C,4]3\Z9]/5?;/QM
]GY;&JbQC1-TB,:QA5f,0Uf.2c?Oc4.CK6XIE,(L\;g,QP&PW6,ES7=^TgH&&M@R
TMY>/N2+(7P#G89<\)R]]XOfZ1K[7dU,f#_HK[<,Wee:@.,OAeC_a^R&880DS)W-
?-#A7V?a9M3(J6-c1?Xc4=<T\-A3>_Y=XU&9Q][=H=bddeX4&T2Ha&&?5d^NWX?C
@M(7Kg97;:0PcQFO+e20&S-g3J6d7M<CZ>[_&\/M3Z505I^Y?P:&90Z>U[TaY7@.
0R>.gJL2/<\Ka-;K0fbYU9#BA66+729ZP/S,<]F94_4TdaHY>^<^QQ6TC/1^\Nb[
VSGOg0C<)CJ7_QO15-?cf(86PgS.5eOd[I)]CP^X[N&4,3\<;M[JU&VM1GF=5V/[
Wc:8>@VRgB<2.^^AcA-E)KPP;fAF._gdNSC+PFGSK@8ZW]QEL[T-DeBMR19B>YGQ
4RPZS)Gcf@^a.:V^e)eefcT3R-6;R\HTJPHT?DRf;R)K66SF\BS5G?)TEggVe8DM
=;6K,beGAV2O?-LcH/:#:-+:bU;eT@9[>,+L,W]B^:AU=-fAf>MEBEZJ3FVRTdRa
5;3=3RcI3,D:fbHO[9&KLbBa[c49BEN9H0X9S8dOb0D92B]B@#12;V71_fbD4G5B
W(F/B_d/?VSL0]\+TKJ-#Ia>QZ<;0MD;M\CdJ]./3I88<(X.,_2>Z5TV&RM25(VZ
=TH##J#:8,M5TOY[CLe<46SJ)?[6F3LM&NJ4gE;fGPVIDd26Ka,A7DDHH/E&<Df#
7OXcGPA7-/29]>SE:AK4_:3H41^BIWeI#R<Z:JcTC&?GDD_0_?+ag&_=M4F9?faX
2gVZVR3X33@Ua&9Y<gQ_ZU8^2M-L9JCVC79.W<#g[QHG2&?IRR8f5aXDc]ce-bQA
G4bZY[K8IAPDBf?3A@PVY7HIHUPfFJI2TfbXd\9OH):Tg&;HC\>/AX://^aSHUMW
4R:Y.da9fQ7IMO;45H^>3=Z9>eHUCL:d<GZ40>#WE]NB:HK_3MDAPC8Z/7]D<,T3
OS&6I+HY[\8O<<,<g,8]GdCUG7&UCFU0KdJ=M0T])V=/LcB>;9]JY9:4P)&(Zc73
243Y?9gc@JLAM_Hbd7Me(gN:CQ]>I+@8D3JVD>=OeMGTFH[KeV8/BN/I1,QOUWKS
/bA@Q4TLDJ?J\54.b^J,;Ce(Z(_[]T2&(LKYN4J67YR?)PK]&ZQ+9f-/5QG3DeH=
Eff>d;CY6S7.?+,>)18_D-b8V.L(&)^]Jd;N-R3A=NQ9MQ?XN,WV;e6SK,(C5S4^
(DaCc1O9C5U17NI:_IcXC@,GT>c(Yd(EYL,@;1_##b[P9Rc?3:E5H8^3+VfL?40O
X(SEGa,0;cEGV9e:2-[d](LS1D&S+Ne2T]2Z<COC6;d)>29Q8AW#]>@>J[c.Sf4<
WS^HS+(N\JWRd?^C86+L2Ra2[O&I6ADe9@bQQ[#B_HJBA1/F;7L69WAI)81Eda8(
LPAKFTPDB/D#[O><JMQ\\=1#X.b0K1(J3b^KW,Z1P_]AS.I.Tg),>eP@H@=8g(g_
]B\JOF^ZOaQY^/-1R&/dYG&;46&fBJcbJ(FN3AA.(b:b./,YgC5QKKHZg3=]&UFF
-0HaT\7;0&A)XZQVLG9HSEC47gQTO@<1Aa??G;KXTDIM6/c+;EbBY_XVg9/F1eA=
H<XB^=;XC98I21aO7D<S.+BDGY#TgV5E>TC.KCU5e\X/;L.b&/\cDWX(^af4U:b5
YGUXL89(>7(U4EWT2K#fgKXc4gZ\M7ef\T\H?>Z[P:0?:DbOTXAZ\NeW4O>;C4Mb
=VK5I(<CbQ=Ga,A0U<SZHTQ:9bd]c#YZ[V+WH[cTCV?]\9AL,KI>RA,>_5C2S=4+
SPNe^4HQ(EEP:EGSfa/ZY8A1GX[;&^9UFW2f(VAf@?>]H4K/CW/\4DGLYd6_@KR:
b@PaD1FYDYXbe;MF#\XC@?N\LWK3M927_T\Hd3Vdca.J+C&eANG4dfe,O^=W-.IK
--W_bICFB9:)L&Sg<V\WcJFa5>E16_MTZ+9:9?\[B.Rd8K</F>/LFJB:6(QeN</F
TT2VF1\6GNA3.+\I#J8KDI3RSI_)2#@24\Fc].PW,M:08OS-J,/[<>DeCQeeB4[_
<\S1;^1c?ESQbWW<+QH:YJTNAPQ0E1QcdJYE)H33H((DY0;[e?OMZd&2fT\F[TK5
g13QO=<(B&W#acKKEK2.O-/LcCQSG9a9Oa_P9YSf[]9\5PS;0T77#:8_DB;A#LH)
VN).\J<c)aO)>KF;K1Ka\DRZ6__G;+ECN#Ig0MHecSJJ0bdOX5E)ZFU+W9;(O@)I
QHJ.G^f3I1EK@@>faEORO_Q;1ZfF,<.+@@)fXW-6HT&I_f8:C(.9;?75^WX,XAYH
XR__dXPFWCK6;K<6O44dB?,#Rb#8RTJJCH3gKQ7aeQ9;AaRg-\c,:aN1)\:6K1>M
6S[9J-33CJ=.,&?fV#MIZ:A8>968\=7H088egE-U>4HY6@#d<+39CT/fO6\2NN=D
a5=ffY_UJgJ(5UKOK^15-(/97@I\O<]d0d^(2[cB7+K[U:[Q2g=>\19P\_83?J#]
D=O0.&2T=/J42JZ&<X[cNUY6.4CFG&:34.;E?+VMU]0Q0DWROX.=^c80Pd8ADHb@
Z5dTV[4Z8X<+.a0-eaa9H8P2NbMUN#e0(20J,CfdS5\M+cf8TE/0AX/9[68ZH73M
5b8Q[bMCPWA[T;Ag3G>TY8YdPe.bD=BM-/X<TY@YQ>-(=OPXMB<82C1++HXK)OM1
&(C[E40,Q4J6)2FE@.X1SSW0-C49eJ(-5I0GEYA#a(T-8LH9UYTeJM.b1:M2/I]0
<PP]bD>UD^8;E?H8+ddd2ZCRdDA\>JGI9LX4XZ.?^_/Ae]egGGW;d]d3G<ICXB.X
&8+6D@\:be]&B+c8d&c:A]31<e2.GUGP3OUU<cd/M4>-T:Y5cX[28eX)O<0XOP=@
:R_?-?;C,V9-E<K1&;<Z>K<9_\5R7J<;P^S4I&60WYNf@G@7OMI)Df>)(?[<E):G
ITO7,L\5-4YIOa;7g[56MdRFAdaSBI#OQ1a+L(P,POZ/7/^P.XT)a6,\Y_H\TG#^
>W(+-3/-9W#G7#>/L_G61T38.ZG)YTN4b;acScKEW;[Y@5Q8^&VH\/6&K=NY3+cX
WW21&Y<6/9JT<KSPPXU-.bC,3V&.(H6g;TKXOVPJFL\bS>E.#;_OVR/52C@?f:e4
&RV\0XQ)bBOT6:@8X_U<(K)=I#TP)Q:>e)ecD\FDMZWVA0;YO6VA711A\\T-U#7-
IVZ/bR[b^^P[C@5,\G[[(.Z,5fB>B7:<W1H.e<\2<\<>)(8O#958OgOC9@\/KN.-
H7R<L8Q3(NJ(5/]CX5@J3JZ(f+WA0E=Y<b?;505K8X,[5IV2_EK0VF#J)HK2U<a6
cAE@DC:NTDb/_caNB+T1egGbJ?Gc],^9d<O5)V:bV7)eT9XJ0d3&K(Z+,+56=+M_
@Ub.Deeec]:4CV]4K5]a55aB[D2b-bMcMga</b2EdF,W^/BCU1=;;&B+<&4=SB-(
N)>UTaRRfNE.bg6YZ?X43/5@]KM3Y66aA.D/bIDY\g9&)ecIKH_QL4<W0#[FDQ;T
^PSAU>XB;X<KZcP\:.a9d-6I/[3YOefcJW4LBC0:HFC<GS;d(CFYC,H0L^KXVO,C
LC?U5Q)&;ZLO^?OXBMK908M3=fG<ZQf(RA@+aXa;\dW<dJ]7VE[^3HW4/]G[S-_.
L4d0S802We>FAaP5d>[2/.aA8L:;?\WXVG<[()NOA176--RbZaM6Y1Y<\8feX4:8
[V5c-^];2&ZQ>e7:W6&CYDgGS1e#HgZ81;,REK4+1Q_,+OTYMQJ^G,[R48]ZX>JB
\/aGM1&=]dBd]02VT9V:0D4^-4U2MKb\)cG<WSZQ@;<F;1)@RZH3LUK4JK<?=VaB
J+^f7bCQVE\Ya4RJJ8cS6gK]7A+Q8=6_CdGMU.\ff1XATA8&bTO/L\N:6c5H7MX;
JRQ4>d>OZP=<N/>6b#d@>PDWG1U9&2M^_d<UB63&.WQ8e6eH0//GJ6.\e]XP-d[0
V(SZT5(8>_EVDgM3&MfN^Jc_YUS8DB;ZWF3IK?&YU&YX2M=>V=KbfJXSe>CK:T8+
34&HX>2bIHZF-??gDB;3?)XM^_<JL#TAVM_;HLc=FcZ<2QX-<S>^8Y>8@=bY>bg4
EV?72FEOTW<NF4bEUd7S.D_5JO+W@7])]6H>^I[aFT13Yf=BTSO35SRQ<;P#Q686
PQcVO]cLC7Gc3=?;,S]/=I7Z6UOBDKY=9IaPb.=)e/<;f2&O7FORFPc>U^\8>e&c
72@]0De0#XUF]0c1H_+MFJEF:?0YI(C&gG8\FaY(J=&dUCEN[^:IbH5Q/(#6<681
Z3]b3_cHG#V3A72Eg0AV?X>[JcA)-9UM_SZC^\)F;g,1+KYI\HG0MP<73K/DJ)^&
?UedNEc]f79fZ.PW\)@g>RF[\-M(C\B5LW(UM<U(6X4@Z881-36Z@S]a+J<9^UG_
5C+d=I<)9=:3^EYT[24U9^N?)QRR;&CD]Y.ASEdQE4D+XDYP+;^LF,O6WCAE2X;H
AH5VSVDURP^R@YGN,4e7?e9S-IJ,#f)QR&b1_7./>HNNM[ZO1?X_I=,&^,dW]@MD
?[bd;g>)E=NN)/0(J2WHe\1:_;YcFNBZ08.)2?fO0QZR73?Ye>(Y(eBRRF,(a&G5
C]#.:W4O0a?>)M#U/[/A.:ECLU^V0,WAG,5gTCgO9A?8<J&c8f2JF:QO^>3.H/HH
gZ/gATP-CP]?=f]EMeS;^)X&]D[N;+:AYA_K^@M=N+^KKSR<@,T+\?T&E@ba+ZPL
NR,OK)KSZK^V;GC45])5]M@U\0W(N#9V>7S-7fJRCg7G:P-AH1V5&d/]IT/8/WQ>
RE(O_H^3ggJ<XG+[\a@YgKb_I3VDEFWAebF.Yd^YITGMAe8OYF6Bc/4=[]aRBBKE
0=U+U.Qc[dGC3Me^U:1a\F9,W(HNaHH=0a/;dCK3=?V3VRN=e.OG_N87IU,JCN8E
W@-G@JN+U:;We/7H(M,(1L9ea44Xa:&.>ddDNR-<C_dM^AHSCX+<1eF<(Q=1a<dS
.dIV0UgN18L5FL>GZU@aa^DUSd@^[V/Nd&IedHaK#d?>HRg=TNF?A2&V2;aR;=a7
6W4<L]a1_-^@8WYQeFF5Jgf5\[R5O_;=<8(#b@7C^aJ&:#9(UDM\4a5S>,)JeR^0
L(48f\:e0cCf&dU)g6V?TZPVVJY_RDIIC^Z=(>LT2V_T?2,UOA;E>604Nb,O<D=I
Z3D2#PZ,gcDW]O8#4V&#Y8Ubf5g[+4B-77G49d_A1E&RdBdK5X^0F@&.2PND6TG;
(31P-M1/@L1F(G4.66F?NQU@FJK.AdHG>AgWQ1UNd=\:>(/bW(7DN_7J]V&8BAWU
PVV2E+@(JL[W]C]XJJ>BN7NP69X<ebXg(aJ)f^L4U&IdNVgW@+LVdY<C.^-\gU(6
a:N&MT>Qc=+(3H]N5_EE<BId>-bYH=YcDKC+9L<Q2GUg0g?PBXHS2&b#;AO+KKdD
[HT_&Gd/368,MI@7/50),XgAU]X39b]&:ADY=ZKDeJf3L;>aTPX4S4@W1<\,I6)^
)H2ZG\-+=;6.,D3J2H&19c6JZ8TGb3YK+cI8]M<&38]ISKZ&/+YD6;Y</1W(A^b=
a)-06[WEg:KdWX4U#C^R&0cL/aKAR8^6B?]IY[\<B\bKJCQ/Fc)aGC>DQH?dgK-0
#2X4b,J4g-_F3dXTI6]<,X@e+,/VEScgJ+/4WO(K>I#\Wg1DTSLddd4=?Sb:LQ#f
ODSQ=f=]b#ZHY.0PV=]@YWK_.ISKE@RI4)RKWD\56TGT71DW62UdfYUB-]B]3Y/I
d;7YJe_)_G[8D5[U4F)FARV(E4VK4Y&8D6-63W1eTDP,3HfS0L?AU(0F+,N@[[F#
&6Q)(=4)6(0U:b)cHP\Zb5@;)YIbdBKJ#I;9Ga@XHJ@P3f1c4H+FF7E2c,dA351A
+_bd&c&;5]N\d#XAeALgW3&F>=(,O#X]SYKfR^2I<V681TVNf&dQPdBE<1J+2Y\6
]NVH?_6>)5^5+L.WH8X+\W83+:MJ\R]\2V=MO;^@QWF?YUW(<F-1PO^F(6Ag#FOO
[6cF3d)I5[J-Z1DUB<g8I5d35&e;QR+,9?]b;,P^>ZD@JK1EHIKJ10ZFEc05M.94
0+PDN@^:.V)GTSA@Hd[)cKX;=&If+^C#^X?]g\221?0>?aYO?6J#<WS+4,NWI^+W
HEE\6/:4cN+MN2Ue;+:IfMWL45=-\?,J0NCc&#GGg[YLaD_cbXU,T+^LL;I=1?X4
<DQ+-VHUSg5^XLE;:JYD/>=3@<SRW^=Be@TdMY\3T\gD<G^;O5;08@;VP55@cLR=
ZK3YXg/)?6PD#7D\S-#BSF@W/LUQ\-G<_d22Bf-MY99Xa@0aFTB+.EcVPfB#9TGS
5HJ>8WGPf^&U&^\W_F+VOf:(eV;MY2RR/^\dB=((EY-[5JJgAV?bbJ48YZ(GcF(;
Ha+Qe#[RgD<>WLDVVJRb[=43U0AE0?d]\,<?<,Mb^2cO&LX8<?Q_O:O5f7=A?ZK.
+&Z/R))E&(^4E&.LcEUA7V_BK3GROPH5OW62Cg;CO6f<3HF)g8:e6.25LO?dSaJL
c4#b),UKA9B<SgZXN_^7Te1eMB.][K=1]R@AJ3S@QTUKZ?@deMecabJ+4L]ZP&Q=
[8+O^e;@T>[IQ)Q0Ia,_b3OYgHd5(2W]=,cSgbIc;C;P#O+[.AAJAGQ=>Xa)(W_/
QY-U0_2GLZ.OVIQR)>.Na.N8<d/EJRS9N3F26N=YH&&I@;7gPO7_9DW(fHIRSNcR
aPTD_e)7_\CgTTE5^C0=D[ceO9Ge^AG&YBdNdD[Z_86P&S>@f9J8c/<W^gS,2##L
De?F&R;:_MQ4_9e7@(75cAOL/VYHV=0]U27LF4W029PAOAc@.LXKO1+4\&DgZ53V
NN\6HXbSUfF^Y09JZ2#I?6I1,RZRPV&._Y43G_K7,MRL3>O/MS?QXQG,,-C48#b1
(Qa0dD5gVUNaN\_Ecb39eQ8S/2GDa7;UdPfQR^b[8?-aH5_0E:>LH?[bE4]Q+]2K
5cZ/_]N:\\cICPQHJJ2H]Y>cDS1,3ad0SMVD+J)QcZ=7^+YM==)V[-f-gCAI3H1g
/)Ta\c@?=#N0#4=J=g5BK.F2]33B4&KcRXTg(GVHKf5D)CEb04HGVV_cd-;W(I?#
HKKfVKGR/A8WC8DH8WWTcbT_O:/+8(0VQ6MY_ONEVN@=IK)MH3.NE]G.)92Q-PCa
;?)KfO5PL_RR=;B^,O((bcY0/<<<NLeF@+G<,\-CDVG)FfZP?cLbT4Ne60CT)A2]
+5(ZJUNZ=;QV+SV18+1d7J?&4dFWB>^b1\_cNAI/gD40]F]a1NA,8Lcd/FL1E;Ed
-Fa[QR\7I?7WE&F0NF);,L2GY80[\2X,<a-2#CXQ^B@XNFH:/7\gCW:Vdd6M:\Ae
7Df?Fgd[MX-;0WTND&RcFFN@=_5Eb57RHfFGe3<O]9A&K\K+5_.DBB]?cA14FdSS
39LJY=KEd[@<L,M[3>e.GY^?\]..f@U)\c;DeNaCC<I\.RCS#;4OM45=0UgM4^,f
dE=a18NQGIVV4M^&Ef_?b[Q94F@\^.PaV_GC^B\0;8-9PTVZIO\#a6Z966X_e5=.
aFF4,2@FbA-JNPgZ\dB8PLJA_.]ePeM0Y\KUMT]PXWJ)G^;[)UZa[OKAJYA1MRZ6
V\89BCQ+VS,Dd7_bUg>0e[K20HX5Lb?g(d[Tg8<9c=A]QHPR84fEDfIQ2DbdYeF^
,fI=cJ#MNB4VJ_0S#Gb_.^eg9C:3\E[00bMJ#g5#bEC46H+34JPH(FS1?3BHg=D_
RWNB2W.KgD&4F:GLfR#9QJB#X]K2:cZMBLcT=M]G&Q=C+\((80U)?KB6IcMGg,]0
Dc9MF+<dP&a+ZP9SOa)N<TE8BAQ&NCD.#..>N5:K.W112JPUa221)VBe.Y.bc5J5
>N8:2D&;\5f0;FML._=V#@E8<eA640CcH#/<HW3+g<<2TC@4RQMNMWJTE[TQ4@6.
dP2/&O),R=+N<4Q?NLb\6)/]g(;\85;XO<^d_cVY\AS,Y@[W&KS=UL3Qf&5:1H0=
e-8?HM[/Y=1G0T&8YgGgWA2)Hb8+7]\B]^gQJ1FgARA6:ec.)>X8Sb:/V]&@2SAR
63)OeV:#[#B+f,ZWcO(cG0?/NV/XeF(aPec-B8Gf^2Ebf8Y5@BGF5<_==_=&&N8Q
M+D7,,b,d29gJ]2U5,AC(=g2_6,g;Q(-U/C>,FGWD_K;_F3U&P>V49g):):ZH7KU
C^SWId-Z,ZIY<(]a][?.N@g;4Cc9H0F@[F5+a9Y4:&AJL6N?0Q#a@G0RG,@[UYMI
J^3)F<c7&(ZP8T7L^N-M:]1GeWGH?5OYf6gZ&gPH,.gc1.<f-YG?0<LRD9C?R(0d
H@Q?Jd(@EY6?+K(-FY/22JB=/V>0;aHdQE)JMbb1e:@+PJ#:-BT0[JR65:DNKV(F
5B;6A]Z6b3ZM)+D]dI/Y:TY5+DH#\aAFU[.WW?CHM3[4M[NYdPR7LE1ZNRe7ZDF?
;1I0.[Sf;7P3<UO9,Z8a<RHAK>V-6Cd74(E>#OR4=^Vb\_HNZF+@KH>M[PCL&E:3
-6;f;4&SFX.b.KfN@LKRgV_@],E(=eZES9>Y-IY<)+RP&#)\O3<EC4Y]d-TMcXDK
QI_Hb&7Q,.;De2:bKU&:Z3[3+,@bP@-7@2=:+=]7\NdFDI6M#EP+M?+.]8>BD3]P
3&0d\SM-X1d:T_(ZI(_D+SE;B#](1W3<3@c0I[#..32(,.T,A8N3E1<=G5aOU\;c
)J-&cA3Z5R5+6<\U6GN<_g8,A?XCY[:5K_#5<U3,AO^:M#fX#1E<>==#CJ@B#Ta(
gII<DQ62T8]P.#0>M&5Vd(I8OZ0dOA\6eeE43fR\1+KCd[(^]YK-NT?:K]<?(Y9c
^YD\W7WOQ>Z10-ALWWB:XQUfGaA((6Tb(=a>E.X[cQ(B-aIPWK)NOR[]TNEXA&R[
M3cc/Y<g&:3DW0fg>e-TD.3,K3^0]N)\R,-?1QL:-:7cXZ@fER3UR3@,7bC[>,5c
=[VOA4fSg8Q3K:<]WO00AE?T<0>.Y7^P@d&H+&=);WRV7=C0A4PB?aR;gQE,/O60
QcYZV]K_X5U(=Y#>F?Q?\d>HC]LcS.N,CU_a<CVGDc?^6@M,?9FdA82,Ie#4+<gQ
V_G<HL9@;#8/;8:VAaP;J7:O2?A=ODKD7_&RMQEG>&A8g)K&dFdgJYDSbWCeJ7#Z
_50F+LAY.Q&P0U&YXUNdQ73eZ<eUKG.(3B=J<,65G8(@Q-bJD4=)X1^KFWWOa:QL
5PLC)KBYY;D9)CDAN4^7>;7^?fZ?LP&K45JHF2D[AS2B^6_1H[<A#RI0<d7?;(=I
.#R^-NK6CQ58a\=UeBc_YA?^S#EA>-XUW83P]/B#&(2^OF]4\FC0?NX;IO(3/Q\(
TDUE9X;=7@LaJ3+O0L)fIGQgdP7-_V6?A.fg^VK5gaY?f^[>:C1>@][\/[T1:N85
#bBT9df7U05]<b\2cQfLEN(,/Q?SW[=e6b2XQ-47J(aPD<HdW&LRAE@E/e097feU
BS/[@<@bCAg:QFP@+2^GQCB08YbXH(<ReZ+,LJ(fF>TaM,/G53WcK_1K]Yd.X6cS
eeJ(<+,_G6fBd@R:HPS+a#7\:M(7IXPH<UE&8#Xa>J37(8H/c-B^a?Sd,3:S?ODA
VI<f055e)S3=S7)5UTaH-USYA?MFX5=>\8g]ZA^:MW\Ng8ICMg/RC?;ED,:VHDCP
S\;)Qe4/AGZ;B?J^S>?4a,8NK.Ia;OQ@_MS?g1cT_=S?ZE@_Q#JS\8^)7.)0=DX;
0+J<b_[RCddXAMUXc+bZSDSYa/5?H=V,XT46P[N[7W>PYdXL9Mf>f\OAgRM3[A_E
:#U&MR_#K/g8C0O3C[cL>TK;gf?F5HRH)-S[6@fP2OK0-4#B8b_T#?2V(1O+8V[e
_9Y#?\beHGM=S>RdK@0gTJeKgUYYO@C>M;ZT4PabEVF9_I<^F]eE9:-()W(3M^T:
gB\3A?>aM6&I-]D(#bYA\N+-(O/YH]>0ReaV[[GZVfYJ2E(?RCE7=23(cNZNLU+c
FEW)S8eXAMGb9?9J=]KY@?IE.EN]V.PMfW[#SXbC(_K\)X;9_7+,D9G\I/NH-8Z0
]@J8:20+C=9+^E2gd1DD=.5=<47@R[)gL,B7R7]D<^^SPEU.D]NKHH#Z#F8Qc6>L
E+J8.^fA8SB<5AY^R)7&NZP-#L]MF>=.fO/WS5DX<OHIK@B2\8\]ZUWAT.E;AfHX
X&KC-3&7N^IH41b:8+cI(A0W;RH9F0fF0+L7@A4WWF8UZ^J:1FOQH\bFVbed1\(L
X8?eDS8SACI2#dbBQ6FZHFPa7gAWeKKY(1:Z7MKBf<>)cG](S.Og]NAFXZ2O(#d-
F@1AV,=f&Z3KB306aO\O@2Rd^T9C4_ff]>@3T,_dIV,H6EU^7TI:b\\9&FcgOWWf
;g_8PA,H-5-X^F3-)Y.S3>9VW)Cg\KH^g(e;>.B4-S>\f-8S.T/IYeM6H-4dNRL[
P[24-S\-D[?X_JO9),\c7_LK5(XL+W?Y^XQ^,6,J,K(#FeQg?O5)8S:P4XQ+Q+V:
=E:W;T?;HYL2U4dWTG-Qd\D84-;9CD\4]XCG50V5Q#HX(I@J>K08Q0f-9-U]N,;5
Z5[e,CS)X9bWEY22<3Q&_#\eb,W^>>:VWOA9Y4b:<>fG)9\O.@NBeg==KQFM\_LR
5(03edF6a_XH9UXIC@91QdO&-&.e(OM/-^VA[M;K4L;Sbe\Ve5)4P(<]?][7Bf/X
/MBD.N1(I:4I?S#@.+WY9RS6TYO^T8gg68YR9\.Z,bNA514#)fec]9cI(0X.GVPW
U/?F:\gb.MIP1GQ:ZLf[RFSaYWLf3GBbVK]aHO]\Y;8HU0K;ADagH.8+3>XIP-T-
^+:aFD5BdOV@>I,WJ7.1YINd6@ET)PN-HHd62L))YGLG#CaM0PEHJ\0ZB0>FT_O/
4@;,#c<\V3b&U^b+,^V1f325Z_7;R5EK/BfL3)5YA0dOXYA7<IE)0+\I22XZ:X?A
W#P^P-;3;&^O:8g,U9RPF97,[SeXK-1D_b#.&-dJ2=3EQVL:F9P(0GTVL)7F5c;A
FN(#c0V?ZOYJP=T,DaUa#f0_6Z+_O<U\UBX23TU3X[^d1&,+RUK;PA<R-[AL0)]>
9fMS)gLHQ#R?W;I,SHFN\2R#1J.N^ZJY3R\b/BF6cC4X6>WcAdK9Oa;#8QcTgKA1
3U-?GS6b5g&=WQ/T=6KF<MA239B4&a@:A#>ScLba?-5PL^HC3+0T)=c;]28)eE;I
OX>D[/DRSf#S;V>^5?c:8WT5K()WDQc,#+;dJ/PE,e\O?M=M@096Lf)X4b;Z)d<,
@;=f/).d^.+4_Z4NPCc=VB<F\c3e##b&,E36F\>P]ZZ=/_9+1M/KB^&aP:L5KdI[
:dAGYYZMH&AKQDHTDB=c81K_;@7+.<(M?S9/>W]P\Q=fL@a=bU)OffFMYRd2F&ZB
_<9:K.)Q&9aO<7ePK^e=MCS2.CTT:]gcBcJ-=85&D(<-05GB74+^6#:IJG,2&.9\
R(Sg#B[G>V,H=8+&TIGJS?1_3]IWML],5IGOD\=3(dO?C0J;9cH6U.-R/=N6:XG3
=U9IfZg1W0]g,8>^YbEA^E6TZ=)-8aQ#AP@7a1F6d[16\SR,RR[\L;ReV#Z-dP:0
3(1I2:OW^/Q88e#3GMEJ.S1I=<]/6GA>_VOIMP0++aPGD\FO#@I=3VSRD_\#E7Y;
3V@5T&L>b9S&F[#9\C;U+[=Db5XF6g=R7;ON4TW?<&M3BN-#EW?R:#SM^Ob][Pb3
.:QOY^2_@5BMOKZ_5Cc9F2Fd@+X^J9GR]GF8HcY<C]5PVeR#;+S[YBQM^>L/35/G
b9+SP4C,Xe7&+&87INb:U):FW-N3^V.AKG2bL;)eL63B]fgb[fU34g@C7IFRSOXO
?Q7P8AbPIEEf9_M/BS-OXS8B?G1.,P]cg_WAL(W=:/U2JOH3TD;(Tf(W;)MG&_d@
>GZ?2P@dCEMcT8&1<WG0LCLM0>;XO>.;E.<_VNabPZfI>c@/,F0NXg+_e2:D]3X]
JI=3N+;)0#Q_dSfA+a1P(,)G)^?>+)L(.gMcF-P,IM:.337DA4ZIBB#XVYb5dGJg
7+_-gQ9QbR?QON7X4R5Y9TR[15QG9MJD_W1G4YUI#8@FNNcZKZF5c\Edg9=,@bX=
dY[HT7].I1268-.O79BbWQ9WBF^<>LFaeA?W-NK.=<Z/aS2ZbLTBL&560O=dbb1H
+(S_9(dIL5FWI/?-?(C.+?;:d+:Kc7J;@OT9bR>0<.8&d4d[.\82ggK+9U6FP01C
a+f[++8]5NcA9/7JLQNL\\[]/4J86E>K@KS\Z@D\(R<,.adcK1aKM&INY\0NFL8Y
#58&M@FWBQSW54;.:L9@-PE_:U&=\7Hf0R);_g1a,b3-O_G,^@Z;-aEYJ5K)B<UE
<BB@H#]VQ_)D?25W5F5\XN2K)45-SVJ\5\8EJF-.FE13b]<B(=CN=B&cHcb)H^PV
&-/&DbW7f]DBM#&5gRLbFW8BH=+Ca70XgN;>gCBK\^N_2&,^:M=JY3d:NSc_JENb
JeTWYXV)RPUGM6M(A9DPDT?VJ:bQcB18DN+N/WcM^:GMH8#33;PZQ5La7HS&G-FW
P\(Ed1BC&Q[RE6f0UMeJ39V&0K-UWBB^CRC/<#7bBQ\V8TAPYQQ:5_<,;MWNS:Z-
#5EaP5.NJ7+&:J41.\b8:S_;0GY;gW9aW))2N(M38ZYGR)?PL77Z:2&BbF]OdB1d
f^XF5/2#^RLH.Q)gRO7GLQE:BPVeMGO2cFS\&/:\];-f>67]WI7(E[XZgH>_e^.9
P#cH<5NMGF&f0T@BYd_-UK_HTRI4VB(2ZQ5_:PXE5IA4.]_Q-1X?(7?3g\gA..3P
BU1Wc#.;:1VGH/Z/PbfDU+8<12DW/]gFa9-44TVP_^37/X/9;4C4Md:QO=2.A/&g
&T;S&8,;JORfdR\\gCN8B&B.aQdIIIHW,94P&cZS5OXWbWJ459^(P0VB@2e,=^;[
IW-UB+>W)>J2d6+6SP,)F]GT,8c5N=3;F94?#<)T0ZRab(1NZ_\a6=R-BIF(fdN<
=PUf)f7O4_9<I2MV0FN>PO9<eJK(J#=@;b<Uf7;=F=>5H&U9e@M3c>0EYMKS,@=E
27DHb\fMC5=d0TJEc##<IS\SdS;1-&E#NJ4aU@CP2]Z&QN6bB/G/=BXTB69K@Y&V
>d]T#J4OH#c(SG3]He#CVUC2>0EDOW/K<O6T9/e_U]#=;2e5[@^KSSL&M?UBNK0:
?JPTJgX>C]A-02d.UX-#]#C><PNeeLQYQb\GX#?D9ee;MTb)OV@Z-N)4dKL>DM[g
+O25H-;1XV&>>,bBFFH8>W#M;B8b<QAf;_/0X8-e^O,KY?5-^f+<@G<-g.HNd/<W
(W9L:6WKO4#-?X48(A5>cZE<e&-BL82KeW:X_cON8GT1YO1AS05]<=f\<I@WN-X/
&#\:4.7^a@0e4U(D01,J/^LRca&Rd+0,14Xd,Kc=12SYXX3CA<)T-Ce60;]RIUQ4
Ne=6M-M#F_cB54T,dMM>8H?CKC:I9@,?K^J96+>ZFLZ@-@AKAB0#YcMAZ&.P3EZ#
-3&<4>0^&#?2S;+=]T@LT/A@U6F7F&f.W;BOcbRSDgVf6[-UMA-WR\-UNKRX+eR5
C<GUS6/4:]3N2Q<S(-a;M_7/\,QQ68(S0I[4O0QIYa#6I&J-@T9YM+3^F00S<>N0
LY+<>YbD-VMc\7KZ-7d/77WL-)gEZJ#V:a_9e43^e\gZRfPg-OV[IF:gMEbT__Q[
\-4V3;0&=;:F^>E.^YCCg)7AQaX8V&e5WgXYRH)CRSTZ1(.DaV--=e2X+BGgJBY[
/2?_BF[UD:<R=.Dd,_R0Q3UFRX6#+]DC#:G@O?S;U1a[CUY3TS9I=QSaESSWQ:J>
?<>W9C]AZD_\UG<+E>T1BLFZDD+>8cEdB>8TO[ATKXRHCV[?RcL5gYTAB0BCXF5P
cK_@F/@2eG/c1eMU.2M_YV1<fPdcg<B\cB+S8<R\:LJU=-a[gQ8UEBQ]/gZ^Jf)e
&5PMR@e4H9a^2\>Q^<X@N7(QUAPO=25)[8K?GTYdJAVg.[BZF/DX1>PadK/]eAAD
5CS@K^D?R[4:b?0D;FWBE,UDDOcX@C+&R,^Ng1?e]8.0-Y602LY.2T0b2&LR.8<V
5:Ae..McPU&RP+cHAQUb\S(aS6BcWNYE.+EN(Ec2J==R/Y&OYP;E>NAcF5T^U;E:
2SMadNG48,eLMg-I^Y(0X@9FT7T#3-WM=.PE?ZBG3?QWZ^N;b4>P(+e11J>1eIH8
dDf<^K^K^C&d02QBd.0)375<^=(1=f9:gS[(aA6b4N2O.;dQZK;cA,e-O7#MT()G
CP(@[C:.U+fB=7+HeB1e28AB;J/MU808F4bM4HSbgVE^BK-M262(ZBKJ;+BFPII-
ANUF<3AHD3gG3PK2)@T]bbR[\e;^\1#KKdK]VdURe650<<-WWaI:757Z<3O:C.6T
VJ5_=0>/6#K&1.^ZF)==23.cL+CdP.YX)O0OV[9f:QU4)c,H5;Z=#,PWaGa[3@,#
B0GT=4Lg.4SIV9_(-e#-?D<UeG01Fe&7gO74)>.+7@Bb3^1OQ]&;CY1eSV_bX-&?
f]@O769gAK-0@YJ+>E63(=IO&a?cTK3d(F+.Z7CBS85DT>WJETJf((N_P+(Q>Z,R
d;?4=9eN/HVSTH+1aZ:CY8RBgWOggb[EFMI-(0VbNYI67;],7&6(MT#<dXBQ)T]N
FULKde29O7J[]D8-HY0CI3g7V2F(NP3-gg64U[5)C#aUP5OT6b?W#K+G9SWg=1@2
3D<:Hg4X[#(G+Lb2.U1NP)<\[CB)EP/7QIHQDa6[P;-OJN-?AOB#YcGU?+L?B_3;
;DHXIDYMJ+D2c7DVV8O;<<Xdgg1b+#b^_5EQ]QPa5eg_R<AW4E?PbL9I/8PJK:e/
GNJP-GY7R)9dQP.dYF-.I17>+ED_,X+JHdQ)8;+,@4?RJ3)TZ;1@H+0.:#P+..eN
a>+gd/;;KS9e8HT:_<KK4ObcX^#\:+7I[YPL50bA,:E\+R(>dZ2bH8C(R[>\826/
OXRa4(1fPI,=g0+Ge2D-R8X\5)cH5?NU+,FZ6GYW8>ReLQUd13\T)Jc?,9^=/<EH
P96(+<Q4_LTC[:MD(4Y9#7UDa+R\X,8T5dd=/6CTW7&W04QY=\02KQ)#<HAdUC1S
V8W1>Jbb&4HD&Y4&]+2#3U35])#dC\bMC&Z7LH?:4_/HEE7>6K_\gMZ>ALFeUK:(
EAaQb-R60cXKN)XC?K<-CbR#cA^ZcaSRbCV5\@]G8M=V\@Ce.a_[,M5B1df;1-<T
DbD<bcB1CYLaDga2c,Cb\U[6JQ8.g#@@GUG[=fa><>5Pf&7@O:11_If8?89HEMXg
f?./g>/ZaUI@&9O50I#EZgdLf)Ya[T@G[dM+IA4SK-/9\X=Yeg(e<(CRI-#>GFK?
e&Y0_ANG9\[#Y]ONEf^.:R@8.8#T]5Y?\KR<D5Q.7gQEN091L2A-#3&]@CYD]A=[
:TVRE4OT9#2?RA=NaD3UZgBR_8EbE3>\:7AgDGKIGA0DFO&NgI6H<A\I7^Iaf\)F
?F0c?9#4K9@AY84R(2,W-.Y31V5^N8VaL[].A7b?C)+Oa>_bCLA:E&MPOb4)D5d)
Ab)O>DaNF#gb+T-.P5.NY4P;\-.H(.3bU3?8\/Age8E86LWdH=UNK.I^1U<c9X^^
_ORJ5g4<()=e(^YOC?76f3-6S#][Ce]Cf/IIFD[N-db4g[S6;<KAFZe)d-aAZTf]
))fYU8&?]@IOX)cT:=:V3Rb.^^<41BDD@H8D2J/J+B(\c;H+&9;9RbY.9JT,,58R
H;.\4?9HQ0fXc&V7;C;?e7cRIR1Df51T;[5LbDCc>f_gW+5Cd2(?M7S2>..Ia-XM
U34P@&FN\JK]5W8LM6LU28J^DCZe-#[ff\WG#:>F#fATbC<\+,\B(S#VEHd>,cE2
7aL.R>FGLGg25XH,Z/J_?bN(+93_N^PB1Rg+-]Ndg93-5==fENBJ9^eU#g)gP0P3
Ub/De7Ud-6KWQJfE]=VIHW85]0BW07D,+B[X.JG.3\dG<YBB9gDbAJEbP&4YV\eI
WIAaaAKXN-7&_VGIO7C]5e>.d&e-UbKU[,^<X#G9UfQBG:XN_gQg()4HN=YY+<M0
GVW@:,Vf3N,[H+1/X,0eIX9R3]QB(8-UB;[fX#ELBE9\Q&3PCW9#dG;X&NP_5D#H
9cdgMMB&[7D\U#E>?HEJ?9A-_]+TRBdbPfF,YG.G&[Z6Q(;Fg[ZLT(BN6Z(5dJ>3
5HN?See66D]25U:3KIX\RSfNQ;1B#YLY8PPLfPV1Yc#>5RI]96K>N_XG)ae&,(@c
DaPI)ZK49#KeQ^,4++fc?5BIFGdN3Zg/;OIcV9T)KID&1aID3#&IOG+AOM<Z^)<^
9JO+ESbb,+Od(a7>PRI<T32<W/&5&M0KH,&1ge)QABY7H^/dVRbRKR;(Nb#;]O+V
OKb0E5agLWVXC+XIRNXV.C/3O<N.50H?1[X6-\;^T#Y\5Sb^/^5b^\3B&Iee+XO]
.f8TYe7QKfW(PQP\-L/M&WdG2N1SW:OEKJ-/Lc>HO.Rbd2](^T.d8WFc8+EVYeCc
?f0[[AS;C\QRKf[8W92K+g+BNK[@W<)Z^(W;D,Y)1_&7.G[Z>A;JI@g+[_F[F[?V
0IZW>=ecYD@a/@\]GQH@.7Ref9aX5YH4E+HU\I;9<F8BZQ]f[,Z4(DO6O[.LURS[
0(2M4e6-CU/Y&D\=GK60?-YJE=H9ZLRB7eCV6)=A#AR4PUeVA#BC/?.2f1VT6B(V
HA4[0TG\876QM#/W@a\?JR[Q7\WK^<]HF1R<JdTZP1Qae?XQ7L3FcB7fDA8dg=N,
^/>R]/9M0Z\/C;QHM+VaW5.CEUEd5;@OMQ&d3;EcJ>bOgM7HSgg):T7g,U(M20/C
[GbU?IYO,(E]FVEE\B9ZV7=db0^QX&e=GH)UW5L5E3IcaQeb[FZTD(EcU8NP(a<(
A:L[.G>8G-G:6bKO_[\OZXSX2Yf_\c<U@]T#)cEUT)9[4,/T<:+7)MGGU)F)L05\
Ng+WQ)]21G>S&HO;IB0C?U=^/D&OL#FC9d;a\S3B9N7PORJRE^b51+M&<7YR<gO9
ObdbeF23dD.d8+SP7gPF+e4=EG7FE#M]JQ983NQ<D,NRgeb=#4U6MVT8G]abfC,>
SG[8NgQV+S;H#:4^9<H;caBYV)3WUab]33(F#CZ1:M8CXHR<?WNDMJK]/J?)F/Ig
6Y:?L-<W&D\f7QF.4W6Q;e&)e9^fV7JKV#b>MYg^H4S6L2eW^D=]7RWeKM&AUP=6
QE5g.9-TJNb27NUCg8\OH_<U[Z0Od<?#92@7Q;)7J_TG?_,WXbGCNM1UBS38__1F
.V6g\R.N=Hd:f8(S\:L),(:0J@B1FN#Y31-Cb;GM7F<5e(;&/;5&)JJ;(eH(XJ6V
>#KXR;C:)e_OV;a#5JNQDb7e<M=,Bc[F6WCC<APED+;8]B9KIYUF(#](8@A7P2_g
K_C>6\Y-Z]&]N(9IRN@5=G<+B9.M?WPd-9HMQCb.Sc+?GOY;G&SQ+g-Z7<L);I=V
3aIe(@/dPUQBV]>BT9abVTUU7fg@.5R6AT>MNQ#;+##:@R;<P.&2LKKA:+#gcV.W
H8WJeC5C=&S7(-_-e8F0N^U;6bA=_[>P5Ade[CG-Na@SDcVQZ..(M=#+]V6GK9PL
.aP-BL6e=X+Z8[LX:f9?#b?ZcJ)FaBUSRS6ZNfQMCLcUIZQ3)JTU.DJBP0X&MdL]
C-KW3Z]^?^QY\,e4+g[1R\8d)e;KKC7K8Y4T2FUdGJ):PF;\<d<V1@DH](NG0UB9
>JU;.68(G_=XU3d4M8ZI>)f[Q)0#e?XN6B;ITI1UP_@&YQId]/#?)aHB\49S^e-3
2A99,F:a&IK\M(BMb5DeIbZ_C[;YCgS)ZH(EH922A1K5^g&.c>;K?XF^#+H_cZ5f
L7NOE^02b@P9&C4/HeN-N2&6dO0OFaeXD;MKDW;JLDNOe^7Eg+BHXbDV,BYQ^&,_
:bN4S7KHCA?c>e6WM=g>=(R4ZT:.-[6<SQ?=&5]0J2O80a++,(FQ]dH>=7b>ZB+T
:3.X.7Qf(AD&+Gg;R6DW;A2)-RefYF&Z,.8.UT<QR5<@G#?[(5g]@WT<CKZ/;1:I
5T:;+D6IR@X41MJ@\TB.Y[DM+X2c_e<00JZ9WP/^<K^]UWK+_AW\e/H+A5#6?]<@
AA.3)TD=GLL.RUFGS]C1+PZ5@O_8VBO=_-6Z&>>I@\\+6-c9>b,_/eb3ZXFgEFK-
VG+Z;))DabC;W[H9+f[YI;OBK#\ZO#XaV_=8F^I5;&cf<@:4>1<=3?JBHdE^P(TV
LMZ1?AOUQEgQ]BX_2YIf=6<&B6(5X;Q_FDMZ;TTFeYE?#;]aeWSC2\d\+K#WF_3f
WEL7K;Tb:Da4+#RVS_I+R\8D@K4<C]IRbE36<>6207DWfd7S.f>)^HM]+DFGH)^Z
R\I6GbHPRZ_KP2L=_6CV[X6\OEF?5ZX[C/R/e7f8dW<A@5ZRV9#0Rf//?IHM^+)f
CbY&C(f^2f\@XP(3OCA^3ERC;)4OBBFeH6681HCEfe]Hf5ZGEC0\Gg8.=ZSfX#gS
eS=B81.]6^^44(V969YZU5Ee#DcAN>AU4RI?>g;<F2#3e;^-)<1gY>eK.0<MX_^P
&&E-6E+0SL@7_TGEZ70:<ZdYc(8[ZYXM1B)OC,Da]E.L9\]4^),91S^KMBOLfV0\
CeTf?eGO?B<=fAQ-Q2+FYTc=:VCF2>;2VFE7#)]XJGUO>c)2>-UC3-Oc<V2/@I&;
#RJ7V_/B;g2738a;Gc[8D(N?dQf;P>CHLIcEFWAHfLeJ2,+EVR+7:_-K_b^7OL/b
RS-<F<Aa^NCT-@O1aP(Xc3U]<NeE@L#NH@2&?65B]2c>UfaSE2N9^3R,(fSK(]YS
^MdTX0;LR[G]37(f?NN/M9AaEP^)Yg:<E^_+#NOd0<R^ZP022PCI\+ad9KcN/L_Z
M@<A);9#B].bLMM<EN+3M>3:#c#H]W\\,4e.3cE1(_UFAS<;ITDagR&9^_/#&?.U
WQ89c&g/]bTKAA:bC//^ET+g;fU]SJ>Q[]-E&ee@H7>1>ZSR6@0(&,3;CgCWM?JY
OI+7RG^?->CFHUX\aM^WKK.R:R[Gb/?=Pd;B6aK\3JOcR):3\@<PFcUQWQ,JMVP:
Y1\gJ<&2KB@=M@TbMNY:6Q]c.SE.[_C-fMbTM12]<WdbI22]=7E\[/Qb(g,OYaGM
;I9EK)/42PND3.VWLg-]&:[0,.9YedX[?e=b.1UD0II[C0I38_#V<@\-AgV>[+8@
-21,@6Jc0.(ZC3b^.Ca0W&6=F5^IC,KV\2C1K#407/WK71WH#Z4,B\W.F#),fd(1
3RQ,\D+8P0OV<=WQNN=J4FL/YV,),X?ALP\>P-1W^V#./V1\PP7RZ5;47R:KAc?b
@I\244,GRBKD-3>VUJQ,H)J;MC&f4,S\QF)5c1([WKX>R.(MQEK[L6N6[O<N<U+J
c>,6Y.:d=IWK)e9BWW#:I]aX>0eWE9?4H??AQ:W[^Q-A+NOOU>EII<NB]?2M^40d
R>ef^CY>QXF52>[UdV)D7LH:3c33]6a[6WKEW^O_P](/7LOVGR.S^KUIGHNAVDLK
D)];&5>DcZS0V.BggfTJ9)>HGX0GeE_HQB3FG,#AdPT?&/-PZT=@OCL<cM=0\e2+
+GHc&dRR3S6YV@;D0++2:(=@3R;<5]R,WULUL(3e_cf3NR.&G<ONO7PKUF4DafIV
6?2a7.]B/I((,?[H49,)X/^>L-0\RYfE(P:2HWXa9,_4KTRd[9HScO5H[RTOFHC3
3>R2XD:a]&FMdBZD3C#W2-;_=25RD+Q;>@(U-fJRAYTHXT8U,<gH:U,SSV0_6fG6
PD.<Aa4J^5cE^>]([J2bJN34&OV7VHLU3XR9Rf2I7CCH_HSFTJ&]LIbPWX?-/^V4
9ZEe^D&7<FAK,:_Scf\)D97FECf=_0H,DGN+-BVS?SS@e/>9F,IMRZ:P;?1Q:._^
O3+7)UXOHKXALN+QgHGNKc0[R=e:MSP3^ffI[e7&&A.MLB<PbH:SZ/K:I).2d-_=
2g+aeS@&<G7g5)+LbZ4M]#;#[HY9^,KDQDAJC342fN6@e]d66YGY7,eK><=+HM<1
;g&8<DcSDR>.6^\aM&YW\eTTHDFGcZP>O@/<,0J?\V^XVKJC#A0_aQc2+I3?N#;^
(5aH)gA0I#H:U/XKSIW.]&OMWA#]V.:Ub2[K:+YE;#Ee9(0,P,Y7L8Y</>8&(E#b
5Ea.DUc@VACTX5AJO4c>8+g\SKXfV,:3dAEag>d:J[]QH#cFfY#b)0W3DL.IF-e:
=/)dJ:BU^IdMR8TZ/KL)dTN;)O^ecf<[5(eg40,7W0W3[d\[1Zc_[U=FGg.HRKGg
[U@WPDVVd[?MBCHB[/e^@BGYXU7;_fS9cTJ[/IUAUfQ<1=T_.+59:Pc.#^W.d4.A
L6R2gH_7P5?M&VfdC>d+U;Ad-a1;E?416UA<U[6LBOZ;2&-?cHfFEE0UR6\[#@H+
3+SIeYa^cgRW.>fg[7Rb_POQT(TJ0eYT=MN2:edfOLNNg4fB,0?FPI)S8(ZZ<VJ4
E[a[>=g7AP2503),WBJg-401?35B&4b_)-e9#NFFGgc/BH=)(D5-Q[XXD6,3CfbB
ZQZCNTLO0?XTBE?SDF@^S2]=Z6Z[Pb7,&-=<+TaJBb;C0./GMVR^A#V?O3Y^dH4B
B&9<.L93((R&+CJa&+>@)eYNJAZf22MB\R@^+H<,;@bNI)KNJGI6@Q,G.-6XG/YJ
JA=9AU4[4FVR-bdeT<Z,L)e>5Ba3[,V6(GVBFE5Eg/bWF-EK[\9DPaL+-P]Gb8LW
>:WRPMBM=7_V&db59X=:27XKPdQVc.c9TS-\PQ/CHUA:Dg@=4KG4Ne7:(9d+FNeg
BRdNY+3;+XS(gGg>>>#[_^7@X&Ga:XL7M3fd116=cc76@,0<8K:IUV^JAFXW7W>S
D]RC3-E@gX#^ZPZd67U0FZ/;e0#0a6OeB4D.&.@+5\IZ&1T-Jd+G>KaD@YaG&,8^
)^dKL<a<DS<V.WV__AS?fgG++QG(>BfeXYdcWL4,V]LJ)R;[^RbDDNg1LWPT@g0@
T\Z)U76d,5GD#DM3Va\bOK&KJO)=.,6/<C(9cJZ):X.SZF;R>@EACUM@gL[6,HAL
UMfXA#/RUbPIZ-6=-?JW-/RJcdI,1I,/0BKgHQE=A:_dDN2GCAG</;2VMfIUdggN
#S(#e2]SD#5>]/UN;D&HHgc]EU2)&;X.Dd<VOC2:N.)3&;,(<)KY^N-OL\1^3O&_
a5[1<V>B57K#4Bb,,/L5<?@+^c,M,B^M3_5>CEL+;I[SR]4UB7(N#Eb_;4,+)B?.
D6]0Q(30\3K+1(T&L@EF9Q)T4Z)UZHI)>:A+YF7;RAZI@5S-d?L/6\8OCT^C(W)8
^;VDV7KaUWdM>K;>)CKOKQfLVEWYC4G3_@J.IG8a:PHg(]4.?-C9C,5W@+W^KS&]
Hd1BXEX:EgA>&cAE_MAHP;?c-W.[c:^,NMe3K^+VfL)6I@A:UIS&Md[M4=,GK8]=
($
`endprotected


`endif // SVT_CHI_SYSTEM_TRANSACTION_SV
