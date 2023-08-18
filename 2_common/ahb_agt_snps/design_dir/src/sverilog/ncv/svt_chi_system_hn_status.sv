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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JGNamItpCcdGxvCqXqP1eUlgF87O8HZqX4x/QluTHNPMllvKH3AQocOFOy+8EASn
2/QZxgn+g7lwbefgZYDMkoZtgd3jqQiHeN5UUgejGf7VxHGK+3D8pCd1Hcyh0EF6
Ot8HJN9b1m12p/YqP15pATdPipnlOaRnjSHtnlxGH9/5z2GXovFq9g==
//pragma protect end_key_block
//pragma protect digest_block
2ZflmuNqszDSJSVPOLLc+liSnPQ=
//pragma protect end_digest_block
//pragma protect data_block
OQ5x6I7TEzgUBR9BPnAq+O/Wt6O7wznUArG6veFKKvSe7V5bKSdAqGv5c54DeEnM
tS91EXMn0MHKgQPKZN7V2g5MCGUxF0ZhDI8lRP4a6syp8T2ZZVd7CDvOZ3Rjl9i1
S9W+CC+r5TOlYwQxsJTnDGw5eQdv8g3cjUolmSsbV25qdCsn3Qmn8VRDYIR5uyFS
ALkcWS3BIiu3iCzpi7CM/37BzNtfrwbBGdRXzEDcBmyJL/b76LNS5SxVsZnY/F4e
MbTuFRAL+A6M6Yf0VFWLUP/2pTuzJVR1gY5RaUDu1eRBNZ2QsaZf7J7zXYyckbLH
Jp5SiXAjurU0RRvOVI1RFFsqvP40vwXUXkVuXgKmOG830/gTQxcEy990HDA9/zGT
sjcnhkF3QFn8HtTk6olmzMSI24D9P7vDYov9IZAUsj0FPPj78tlY7R7LfD//Mb8h
wJLpK7tsuFkGRvBH+/XX3ZUtQmTIT/9j9Hjv2CDJNghRq0GEE6O/c1iNPm4c42HO
txTkj/nEWxfUM4XcHJsxFfDGFKxcHX6w7qvcpTtoIOireLUNuiONTFzvug2SybEI
CnoNHtOsHdrPgdy0XkR9ebjlRkngUR/8CQnNCxx4TcjpqUr1ThpdAOjjvew5qyK6
glLR0a2D0RJsrI7Tf3Zf5ajxiyPKVR1lL5W6mR6kdYaVRfefHGsjVMp1qX2TbJpL
InkJgzKN3kte/6xUfDyR+fN8a2q1mogDoCCiUjlw+hZgU2piE8WJijkJFPkH5/Bz
anAtAUWavTjjNNPxIMF+4skoTbJWlxR7jAi9kn03FFp5prBd0kjf+Jaq80szOjat
wR7uWbLi59o8NXHuOTsieUPmyNyxqnT8qXq7rzCPljAwy4CdTG/rgxsPdF75/FV5
EvlWiKXgrfyqt1VuKTT4gKEQOWBdC8TwQN4aBSyRoEEIvaTrG3Q81GvPrg5PWYrA
Y7cTo8KMmkgY5PHT9ID3fFQWifeq50Lm4ddTRKj0w2Cufav1MN9iTvruSwOLRkz7
yYnCdVuJ6FYgTiTVpT7GIrGRnf2pR+lOr5Stx2nmkKd9ExvkQiyyhbf/0dvARw4w
Hxy2XQkMBIPgLAi9MsA9GplbpoIVKCx35XKbcWx2e3S8buCJvMsx0PITu8dEY9p6
a6UbKgCTMSEUDsscdRdMDkpu+VzTJQ7ibzUpX3jL1SOsuZp7fky1MTdnvyQTn14h
zUCe15i9tktyahUSvW3mH+7esoPA95dJkGzQkt0SkzxPThT5UGCxJCc1rHrNMp0P
Ny3zlltXvRuTbjr2bou0DEjLDChLiEwj+yehLbLB/oTWFeR69vmzlVavi2nv7fPj

//pragma protect end_data_block
//pragma protect digest_block
Mv6EB1QqPDDDI5LamlRaEMB7n88=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lhE44B6t99xcoGdNmFCrWbAYAvEPE3iSbtvqdvXb3O6bsfGhu+G9nvtsBM0x/zoI
NsWc8PuM8bW0iEtR0JImUFdm7kwsq8G2fOExHdg8T9TqgtRhQK0/h9ENH7GNlrdb
XZiVzBZo5evpkdHpv3zA6YiSasbHEX3WwolyO8sS4NJpo35ahSckuQ==
//pragma protect end_key_block
//pragma protect digest_block
TTTN5vjAYpjZWmCbqVjG624nE1Q=
//pragma protect end_digest_block
//pragma protect data_block
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
BlFut5Cg0Cqq8R8B7yfO/A==
//pragma protect end_data_block
//pragma protect digest_block
lvACbGjcWBsseG690CVNUNhtbEA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV

