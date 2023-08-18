//--------------------------------------------------------------------------
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_SYSTEM_HN_STATUS_SV
`define GUARD_SVT_CHI_SYSTEM_HN_STATUS_SV 


// =============================================================================
/**
 *  This is the CHI VIP system HN status class that tracks different latency counters/metrics
 *  for a given HN at the system level.
 */
typedef real real_time_t[];


class svt_chi_system_hn_status extends svt_chi_hn_status;

  /**
   @grouphdr chi_sys_hn_status_l3_sf_perf_metrics L3 cache and Snoop filter metrics
   This group contains attributes, methods related to L3 cache and Snoop filter metrics.
  */

  /**
   @grouphdr chi_sys_hn_status_avg_latency_perf_metrics Averages of Latency related metrics
   This group contains attributes, methods related to Average of Latency related metrics.
  */
  
  /**
   @grouphdr chi_sys_hn_status_latency_perf_metrics Latency related metrics
   This group contains attributes, methods related to Latency related metrics.
  */

  
  
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics 
   * - Average latency for transactions initiated from RNs observed at a given HN
   * - #average_transaction_latency = (svt_chi_hn_status::total_xact_latency / svt_chi_hn_status::num_completed_xacts)
   * .
   */
  real average_transaction_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics 
   * - Average Time taken by the HN to generate the first Snoop request after receiving a Coherent request
   *   from initiating RN.
   * - This doesn't involve the retried, non-coherent and PCreditReturn type transactions.
   * - #average_snoop_request_gen_latency = (#total_snoop_req_gen_latency / svt_chi_hn_status::num_snoopable_xacts)
   * .
   */
  real average_snoop_request_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics    
   * - For the coherent transactions initiated to the HN, indicates the average Time taken by
   *   the HN to generate the first Coherent response after receiving the last Snoop response
   *   from snooped RN.
   * - This doesn't involve the retried, non-coherent and PCreditReturn type transactions.
   * - #average_snoop_response_to_coh_response_gen_latency = (#total_snp_rsp_to_coh_rsp_gen_latency / svt_chi_hn_status::num_snoopable_xacts)
   * .
   */
  real average_snoop_response_to_coh_response_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics 
   * - For CHI RN transactions involving Memory Access that are initiated to the HN, 
   *   indicates average Time taken by the HN to generate the first Coherent response 
   *   to initiating RN after the associated Slave memory access transaction is complete.
   * - Not applicable in case the memory access transaction is complete after the HN
   *   transmits the response to initiating RN.
   * - #average_mem_access_to_coherent_response_gen_latency = (#total_mem_access_to_coh_rsp_gen_latency / #num_mem_access_for_coh_xacts)
   * .
   */
  real average_mem_access_to_coherent_response_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics  
   * - For the coherent transactions initiated to the HN, 
   *   Average Time taken by the HN to generate the response
   *   to initiating RN when L3 Cache is hit.
   * - This doesn't involve the retried and PCreditReturn type transactions.
   * - #average_rsp_gen_latency_for_l3_hit = (#total_rsp_gen_latency_for_l3_hit / (#num_l3_cache_accesses - #num_l3_cache_miss_events)
   * .
   */
  real average_rsp_gen_latency_for_l3_hit;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics   
   * - Average Time taken by the HN to generate a Slave(Memory) Request
   * - #average_slave_req_gen_latency = (#total_slave_req_gen_latency / #num_slave_req)
   * .
   */
  real average_slave_req_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics   
   * - Average Time taken by the snooped RNs to generate the Snoop response after receiving a Snoop request
   * - for each of the snooped RNs: 
   *   #average_rn_snoop_response_gen_latency = (#total_rn_snoop_rsp_gen_latency / #num_rn_snoop_rsp)
   * .
   */
  real average_rn_snoop_response_gen_latency[];

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics,chi_sys_hn_status_avg_latency_perf_metrics 
   * - Average Time consumed at each of the Slave Nodes
   * - For each of the slaves:
   *   #average_slave_xact_latency = (#total_slave_xact_latency / #num_xact_per_slave)
   * .
   */
  real average_slave_xact_latency[];

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics
   * - Indicates the total time taken by the HN to generate the first snoop request 
   *   after receiving a coherent request from initiating RN.
   * - This doesn't involve the retried, non-coherent and PCreditReturn type transactions.
   * .
   */
  real total_snoop_req_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - For the coherent transactions initiated to the HN, indicates the total time taken by 
   *   the HN to generate the first coherent response after receiving the last snoop response from snooped RN.
   * - This doesn't involve the retried, non-coherent and PCreditReturn type transactions.
   * .
   */
  real total_snp_rsp_to_coh_rsp_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics  
   * - For the coherent transactions initiated to the HN, indicates the total time taken by the
   *   HN to generate the response to initiating RN when L3 cache is hit.
   * - This doesn't involve the retried and PCreditReturn type transactions.
   * .
   */
  real total_rsp_gen_latency_for_l3_hit;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - For CHI RN transactions involving Memory Access, indicates the total time taken 
   *   by the HN to generate read/write transactions to Slave (Memory).
   * - This doesn't include the retried and PCreditReturn type transactions.
   * - Not applicable in case the memory access transaction is initiated after the HN
   *   transmits the response to initiating RN.
   * .
   */
  real total_slave_req_gen_latency;

  /** @cond PRIVATE */
  /**
    * @groupname chi_sys_hn_status_latency_perf_metrics  
   * Indicates the number of Slave transactions initiated by the HN, 
   * that is, the number of memory access requests issued by the HN.
   */
  int num_slave_req = 0;
  /** @endcond */

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics  
   * - For CHI RN transactions involving Memory Access that are initiated to the HN, 
   *   indicates the total time taken by the HN to generate the first response to initiating RN
   *   after the associated Slave memory access transaction is complete.
   * - Not applicable in case the memory access transaction is complete after the HN
   *   transmits the response to initiating RN.
   * .
   */
  real total_mem_access_to_coh_rsp_gen_latency;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - Indicates the number of Memory access transactions initiated and completed by the HN
   *   before response is sent to initiating RN.
   * - Not applicable in case the memory access transaction is complete after the HN
   *   transmits the response to initiating RN.
   * .
   */
  int num_mem_access_for_coh_xacts = 0;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - For the coherent transactions initiated to the HN, indicates the total time taken by 
   *   snooped RNs to generate snoop responses after receiving snoop requests from the HN.
   * - This doesn't include the retried, non-coherent and PCreditReturn type transactions.
   * .
   */
  real total_rn_snoop_rsp_gen_latency[];
  
  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - Indicates the number of snoop responses issued to the HN by each of the snooped RNs.
   * - This doesn't include the retried, non-coherent and PCreditReturn type transactions.
   * .
   */
  int num_rn_snoop_rsp[];

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * - Indicates the total time consumed at each of the Slave nodes.
   * - Not applicable in case the memory access transaction is complete after the HN
   *   transmits the response to initiating RN.
   * .
   */
  real total_slave_xact_latency[];

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics  
   * - Indicates the total number of transactions observed at each of the Slave Nodes.
   * - Not applicable in case the memory access transaction is complete after the HN
   *   transmits the response to initiating RN.
   * .
   */
  int num_xact_per_slave[];

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * Total number of Request Nodes in the system
   */
  int num_rn;

  /**
   * @groupname chi_sys_hn_status_latency_perf_metrics   
   * Total number of Slave Nodes in the system
   */
  int num_sn;

  /* 
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
   * Indicates the total number of snoop filter hits at the HN-F
   */
  int num_snp_filter_hits;

  /**
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
   * Indicates the total number of snoop filter misses at the HN-F
   */
  int num_snp_filter_misses;

  /** 
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics
   * Indicates the total number of snoop filter accesses at the HN-F
   */
  int num_snp_filter_accesses;

  /**
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
   * - Indicates snoop filter miss rate at the HN-F.
   * - #snp_filter_miss_rate = ( #num_snp_filter_misses / #num_snp_filter_accesses ) * 100
   * .
   */
  real snp_filter_miss_rate = 0;

  /**
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics   
   * - Indicates snoop filter hit rate at the HN-F. 
   * - #snp_filter_hit_rate = ( #num_snp_filter_hits / #num_snp_filter_accesses ) * 100
   * .
   */
  real snp_filter_hit_rate = 0;

  /** 
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
   * Indicate total L3 cache miss count at the HN-F
   */
   int num_l3_cache_miss_events;

  /** 
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
   * Indicate total L3 cache hit count at the HN-F
   */
   int num_l3_cache_hit_events;

   /**
    * @groupname chi_sys_hn_status_l3_sf_perf_metrics  
    * Indicate total L3 cache accesses at the HN-F.
    */
   int num_l3_cache_accesses;

  /**
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics
   * - Indicates L3 cache miss rate at the HN-F
   * - #l3_cache_miss_rate = ( #num_l3_cache_miss_events / #num_l3_cache_accesses ) * 100
   * .
   */
  real l3_cache_miss_rate = 0;

  /**
   * @groupname chi_sys_hn_status_l3_sf_perf_metrics
   * - Indicates L3 cache hit rate at the HN-F.
   * - #l3_cache_hit_rate = ( #num_l3_cache_hit_events / #num_l3_cache_accesses ) * 100
   * .
   */
  real l3_cache_hit_rate = 0;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  local string update_metrics_reason_str = "";
  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_system_hn_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null, int hn_idx = -1, int hn_id = -1, svt_chi_address_configuration::hn_interface_type_enum hn_if_type = svt_chi_address_configuration::HN_F);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_chi_system_hn_status", int hn_idx = -1, int hn_id = -1, svt_chi_address_configuration::hn_interface_type_enum hn_if_type = svt_chi_address_configuration::HN_F);

`endif // !`ifdef SVT_VMM_TECHNOLOGY
  extern function void set_metrics_update_reason_string(string _reason_str = "");  
  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_system_hn_status)
    `svt_field_array_real(average_rn_snoop_response_gen_latency,`SVT_ALL_ON | `SVT_TIME)  
    `svt_field_array_real(average_slave_xact_latency,`SVT_ALL_ON | `SVT_TIME)  
    `svt_field_array_real(total_rn_snoop_rsp_gen_latency,`SVT_ALL_ON | `SVT_TIME)  
    `svt_field_array_int(num_rn_snoop_rsp, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_array_real(total_slave_xact_latency,`SVT_ALL_ON | `SVT_TIME)  
    `svt_field_array_int(num_xact_per_slave, `SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_chi_system_hn_status)

  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_system_hn_status.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

`ifndef SVT_VMM_TECHNOLOGY
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
  /** 
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Do print method to control the array elements display
   * 
   */
  extern virtual function void do_print(`SVT_XVM(printer) printer); 

`endif

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
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
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

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  /*
   *This method updates the Total transaction latency along with the number of transactions observed at the HN
   */ 
  extern function void update_total_transaction_latency(real xact_latency);

  /*
   *This method updates the Total Snoop Request generation time of the HN along with
   *the number of transactions which had associated Snoop transactions
   */ 
  extern function void update_total_snoop_request_gen_latency(real snoop_req_gen_latency);

  /*
   *This method updates the Total Coherent Response generation time of the HN
   */ 
  extern function void update_total_snoop_response_to_coh_response_gen_latency(real coh_rsp_gen_latency);

  /*
   *This method updates the Total Memory Access to Coherent Response generation time of the HN
   */ 
  extern function void update_total_mem_access_to_coh_rsp_gen_latency(real_time_t mem_access_to_coh_rsp_gen_latency);

  /*
   *This method updates the Total time taken by the HN to respond to a Coherent request in case of L3 Cache Hit 
   */ 
  extern function void update_total_rsp_gen_latency_for_l3_hit(real rsp_gen_latency_for_l3_hit);

  /*
   *This method updates the Total Slave transaction generation time of the HN along with
   *the number of Slave transactions initiated by the HN
   */
  extern function void update_total_slave_req_gen_latency(real_time_t slave_req_gen_latency);

  /*
   *This method updates the Total Snoop generation time at each of the Snooped RN along with
   *the number of Snoop requests received by the RNs
   */ 
  extern function void update_total_rn_snoop_response_gen_latency(real_time_t rn_snoop_rsp_gen_time);

  /*
   *This method updates the Total time consumed by the SNs/AXI Slaves along with
   *the number of transactions (Memory transactions) completed at each SN/Slave AXI
   */ 
  extern function void update_total_slave_xact_latency(real_time_t slave_xact_latency, int sn_node_idx[]);

  /*
   * get_average_transaction_latency : Returns the average Transaction Latency at the HN
   */ 
  extern function void get_average_transaction_latency();
  
  /*
   * get_average_snoop_request_gen_latency : Returns the average Snoop Request Generation Time of the HN
   */ 
  extern function void get_average_snoop_request_gen_latency();

  /*
   * get_average_snoop_response_to_coherent_response_gen_latency : Returns the average Coherent Response Generation Time of the HN
   */ 
  extern function void get_average_snoop_response_to_coherent_response_gen_latency();

  /*
   * get_average_mem_access_to_coherent_response_gen_latency : Returns the average Memory Access to Coherent Response Generation Time of the HN
   */ 
  extern function void get_average_mem_access_to_coherent_response_gen_latency();

  /*
   * get_average_rsp_gen_latency_for_l3_hit : Returns the average latency at the HN in case of L3 Cache hit 
   */ 
  extern function void get_average_rsp_gen_latency_for_l3_hit();
  
  /*
   * get_average_slave_req_gen_latency : Returns the average Slave Transaction Generation Time of the HN
   */ 
  extern function void get_average_slave_req_gen_latency();

  /*
   * get_average_rn_snoop_response_gen_latency : Returns the average Snoop Response Generation Time per RN
   */ 
  extern function void get_average_rn_snoop_response_gen_latency();

  /*
   * get_average_slave_xact_latency : Returns the average time consumed at each SN
   */ 
  extern function void get_average_slave_xact_latency();

  

  /** 
   * This API updates the counters for Snoop filter events type which is
   * HIT/MISS/ACCESSES of snoop filter
   * */
  extern virtual function void update_snoop_filter_events(sf_access_type_enum snp_filter_type);
  
  /** 
   * This API updates the counters for L3 cache access event types which
   * are HIT, MISS and ACCESSES of L3 cache
   * */
  extern virtual function void update_l3_cache_events(l3_access_type_enum l3_cache_access_type, bit decrement_hit_counters_on_miss = 0);

  // ---------------------------------------------------------------------------
  /**
   * This method returns a string for use in the XML object block which provides
   * basic information about the object. The packet extension adds direction
   * information to the object block description provided by the base class.
   *
   * @param uid Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param typ Optional string indicating the sub-type of the object. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no sub-type.
   * @param parent_uid Optional string indicating the UID of the object's parent. 
   * If no causal reference found the method assumes there is no parent_uid. To cancel the
   * causal reference lookup completely the client can provide a parent_uid value of
   * `SVT_DATA_UTIL_UNSPECIFIED. If `SVT_DATA_UTIL_UNSPECIFIED is provided the method assumes
   * there is no parent_uid.
   * @param channel Optional string indicating an object channel. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "");    
 // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_system_hn_status)
  `vmm_class_factory(svt_chi_system_hn_status)
`endif
  /** @endcond */
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dOObMebCvQ98eYRje3nYs735X6qQMxrA3uxZbCuR3gYDiPwW0QVHi+WUKAp9x3lk
KHUyL7+KKMKP+6G1ZH/XvcivbpDLwsi0HRnzz0imSxGOulvLRGraaFVuH2Mfu3nk
OUys+/u3O75yooICIwJy0xP3xv3YfBEIFjLGPjZtBjc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 830       )
uFgyl/SDlOe3gjBqiFTkk8FwHsezGRia71QMF131NpwEdDvEQizXBc4mEGCBeea/
ertDfSUbZkPjZDkpck2cDVuKGbzp2MvrkwxAVOF2DBw0tUP9U4fP8mUjWnFmvyl5
4SttlViolZJbn+zfA/UAG8Kr9Z17nM1CPy9ItYQ/W8FIMa20Ezi4ecv0p5SWbW9l
Ch03RdOFxfo84L6oZ7vrvJLLurDczdRmGmITE9KtFyEIQ4BRVfS31FHbWXX1C2iC
cYC1JvL3V89uJMg58OOrjOZWzpdl20APtJcT30YMzSFI98ENaBwN8HL+jjwJo83i
5wfTz9tqVxNnGWpfWPbR7ZYDWTCp1B+nQh6hZ1iqyAp7aar+9rafa3Ilz3mECyAH
a9V9v3xyLRKEgnK7ujc8e21o3DRgqivV44NEROuPArbymaO6vVJHNUvPhjxWxgVU
Wvb6OLwrhxkZFB0MKehcQnljxdMoxUQ+/5BaSN/X1lwPHWhdnRuYyM/mvnBlddV7
SE+fGlWcYjMb6K6TlrNViazdq5C8e/cA4avR702BoFyl+SxnnZy/P2699H9PijJM
IurTs3QSWT8AFEdt4hkjR0Wl9C6ACbiirCVkVKfBrP7Wua1J3RPmtAt0FjeyinNo
Qypv89KWPFrY2DwhZMjaGO+wXNoRxgJqSZQZQnTHUtmeb8K0mFKJlq5WdzpxK6F7
eAZ6Z4rD0QsJ+9s+tanfUanPJ8foF13SLwqarsWHABLtiqq+NUbPRS0NSB/WnfzQ
T0qwWOex3mqJlQbvICy80vlYsfkG0M6NhZnnU6c2fi4rtzQYxO7S7BHyqnmu2LVj
QhCnfre00a9JCma/Tz/08/FJBCV0GtobU3FEV68UHbLlj4FkyXwSJa5Gd1UBm+gL
qzDTIMUjItz/Ub19tVrQ69SwoJF6DCbMiV9GB5uQVvhaLEdRbi1K29453y2U4wlm
qzWC8hzja7gRYqI1R8ZFsFDG07ca2Rw6J6isqGa6d3plH4CscGoQg3eNipn89DGZ
t/Q+fEZnmpYzebbhUqsjAndL8U9HX8+Jo/+2MztrzI9RBaZJ9fJ9PWOMKO4jM35N
fugf+KDC27AMuvaph8JPww==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fDAJZsfxVvevVLJl01fhzTRPq+zJdpJOyGuIufSzaomeeOWgbvWW/CtEp9uK0aIR
asTlzW3r9GERV+xcmvXOeLuCakiOi2yJiBYtJByteCv0dsYpq+bmPJ1LLXSU6qqQ
bXx/I3kCMEqCKbcfvyOpk59hy15EjxfWxgpaf+BfbVI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33127     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
moCQstcGszxcxTCnS1uiAe/gBKTrvDATszbD0PfZ+i6AcMYOHG7y7TocD0+NmZDl
1HQiXXxS2oTP+ADU5Lig/LW9pNk8hijTPzsZ91LgSwKEPIYNYBk5b/Tl09TEI9rm
2x5IuMNWJDIEHi+rr/ivS0Hbyv4f3l2onYj0nCl5H8s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33210     )
Cg2Q8bjEdatHOaD0+Na3rWybRwYYq88PpWlYCww7QWqFG9grGr2kme81OKgWIBZg
uOOrmVJikuQWzq88NZqKjr+2PELTB5uaqhEgbN9O0u9Ic0XSj1/P6J2HCC0ptJsh
`pragma protect end_protected
