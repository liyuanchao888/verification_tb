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

`protected
U,<cU[^(^SGQd73,>1P47,SW:#5,dS]A<6WWfX8bWb1+P:d^Hb+M6)+N@M36AY6a
K0?\A,E.O#>6G(^2]@I)(.g//XQAE)dXNeS6IW8W;<.MfM=,_P1<I_M(beRWc?1P
N&#:N75eC=.:3ZN&[Ra)FAN+f.J/+g]ZPYa)-4RU;]52K4EF/RST6<][V=-d?b.K
OP9b?g.ZQZC\L3K-)6b9e6J33QEGK8SFC+]f#fJeOEMfSI+Q)g:FZdTB\S]?N/1D
.X[5[[e0,M^UM:[,47/0CMJD+&_G_#BUc2g,JI:6T/f[8&50J;4fH)K)YFO+b(]C
=g_VDHY#?27^2;,Vf0RLb9\D#HAK]&/P+Ib1W;EMPSa50SObcGQE/\/[ONIGAa3c
I,G3PY@H,L=J[AIGIZFKT.S/0^Yd+POf\J^cHM;bdFYVPEAd1&/U_2d@MaDD=d-(
[V(&]_JdgH3/V9Z05><2c+JaBb_U(3VDP2:V1:H4J,DdNFaWaPF/MZ9Sc)[RV<Q)
NZ^L6PgA:R5g/Sa/1)DO0]-KZA?cM5.E#V5(LIUBfg1b+Z<B+)bT6HBIa]T)34WG
?#b.B^-&0g]D-M7U9H/[E8<[VPeZ3LVc()L5^_ZM9HBO(C0^55.6T(2T9G2CLN?(
08I+@e,H>WU97M[Rb&U>WE^1N7.\QC=aZUgO#JFgG86WgTFZ<d\d(9,)d?/bd1YF
&6WaO(7:XZ]+Ec:3gK8=Kf3E0I,#PVH51THB:A<\aQO-]\UHeFYB;\A]3-J7YIN8
YRMGN;YWIIGY-KMfE3W&<30@FW4),LZ3f#EP:KcF_fG6Z/7][&B@#-<fYZ#Z]C[;
R^C6(<8ZGH?<-[2COL]a<KE/0]1W0b&>><M@O1)5G34+HWMURN(T/&_Z#G32cQSZ
1SYf/<X984#7;E1ZcHdH9J72)G3RX+M)GH[MVPbdQ0ZdZFYGb>bG;e]>b=#=VX-DT$
`endprotected


//vcs_vip_protect
`protected
e6YR0L(-+4&P2TX#eMReON0]/KfQdeGT6L,_1Z\.6R<_f85MAJ?72(HWZ0.Aa-TH
dHN^?;P)M=,;FWI/S2F,AV=gaHH3B8J@)_8\BWaA^L?JRDc9bPQ/dR-fG6M#g3T)
X4@]@&Jb5.D\&gZK]O#V>CHKVY8d987],],Sd<GPVQ[P^(dN[c\,1TN&)>aRa@ga
?4GCWNWE/4(2Q@N)WTeG+cHRe@6UE.CU5L^QL0)ZQSLS6d791NZE6@4I:VMBV8\/
e3/,N82U?6S)J=]bLR\H#^H[=8eB9\W3e\+-TB#WOf&\?\YC-]V0N>,)&EJYIFYR
R=6agZ@F-G[Qd0#;<BQb>.^SO;X=+M+d20f,E><.9[c#M@]1-ZPXeC/4:9_>PR4P
RJJg^d4W6+Kg64(/+H)852@L.<Ue#)V?(D#VCHB4C2(&8O,&D-R4dW<:G@5X+\N\
H9O#\S4B(6G<A\,.YBE60/^.Z7b^O1YDaJ[RL>a6@bfUQRGWTgAc)T31b?)O^NU[
^/-5A0EGAH5,a(F^7@2?6WSZd._MIDR\7KQ]0N/P7;Y@#=DeZ74_AfAFNA6(DI>]
1CPM@__3DZR<6dU5a5C.D[Z.bCgI[D8\GdT5d)/2_H]#E[WT;Tb@JF\&015WQf8c
7B)711fd[DQ;KSHR7^^0(Db@EQ\YORQL5&Z_4(P4AH5I<1HSQ[X3@]3ZYafHHC_2
B^05B8[,_.UWJ_E>;7V&+\(R87UK9&BE#_@aca/EZ[Mg9[66I0]^Y=.fgVZE7APN
RN&/d]H04XAY=E_Mc347AK31d-/UW[:+R)#N^E[)\Y92?7AAJcAEZcOUG4J(PF3A
7>.fLbD2WI;bA\0E(.9XK\H]B-Y@GX=X6/bFN>^V@d)dX<#a_2DEa0)a0_#2=+_#
5#c(?WZfd;G+WZUVCT.U\<:IZ5HaVS6_X^Z[WLgf40D8Eg+==\7Z<0ZQ.NTbRFN0
N0K_Y:;FcgY&],)C8GO&)^JXRCJ#;B8QO5#e2^(CbVORf\bPdC&6<<6Ja=<?C<32
dNI[[^)2^P-B0+78__))<=?X(UB1T5;fI6VP]T(H\_6O/b&5I7N8JR,X^_e.+E(K
c0U&#+<G[=P[Za],&POX?Ce3^&PBT]U.L\b1??.X+fPBK>9P&/1BG1&.EZ;d\9#b
MKd4KT4<NR4^R2D@2e96g1>?90+bWMHSZDc=TQR=f4EG?:[LY+W3L69bO0C6:AM&
@K5Q.WbYJGD90O4U2F426([?V;KCQU:7H4?PMN.)LWI6e+9;LQaV=HW]^-IbD5e)
R&5_[Vg6.BV@>P>;KREJ_)NJUf3Kf3T1(K&S6\._WE>FKLS(RX>Jb&C52:UbQ3Y4
DN(>1Z:MJP.<]9Z^-JYM_.IeA_TYYC^Od4_[9)G4^(#^_aL6D/cMPU^L.368PC/-
><:YEX)+3HUVN_e(DJBa]@0M+B\T=Q/&4UR<F5WWD958f-dLTBVKN3<CSX]F>)/+
f9[3RASKc&4Df,,-TVb?CbLZ-4[QZad7N^)ZHD=:BF(+:4&J0X>6aebN]gJeGF(E
E960eK9QQW00M+R1/+]CA\ON86X&Y&5?Y>HXcC))89:H]\Xe@J?JMb0FZ<R2Kb(d
7-6aZFM87EQ-e:E6V_Ae4MWKZW7B(O=_)aFQ@U<X_<+X)8d-;=42V\(?3RJ]eNOU
#c(dDZ?J0TN<\(C&#S^(g>=&D3GTP1R69+DG<5Q+]eMC4QJBR2FG<CC.]7SZLc,3
)70__).14HH;]:MZ_b-2@_7Q-A+dI<\UcbDA_1[KFT)EZ+O9,^D<0/YbXVOa]K-A
9&V0X^aR:Z3a47.X54f\ESKI55HHW]c3^E3Y2=U5KI\c1eS,<dK#X^S..Jb:SRM\
7+R]#>XG-2NBN,FDI7Z1XWCR4TI\&-X76.E2EXd>B5@N@I_[+?N2^N8,-2Q75d8U
WQTG2#fC,CS69[<WcDR>&=ECZW)gUW<HH@5(;Q]NV1>\M75)bU>f=WPRDH,=M0SS
8J2NB8GSPGg_N\([ZZ#eTf[ScBASd.B)6(TL<@S-6bR]0N3UPbBF,[;P:O[b<IR-
E?a7\VTL(SXER74R8W/Reab00(gF)c@cY6<-7;a7@X?+7-VMa3ZO&b>V]2&GVH5W
X(YEHDf;X:NDT2N-#HaebX<_NI]((=ATE4E2A,NKI&2PWcC@772,W_@WcKXPG19S
aQKJcd[Z0BPNbHa7WZTJTW+cA(VB:IRU<D;0LG-1S[=A;=e&.f0]]3-0Q?^D;OD3
YJ^UK&ICSNFHI];+@3#C3C(UAPU)RF1?,.(?0,gA,^F.@0U9+(B=:VFcT&+1b?K3
/D=cdBT@<EN._GV-P<@P,LaV6MA6Ic>@-H=9L_)]d^cG:gL@LNMDNPY=_+5.-^83
3JD3/\_eTV^+=5CI-#A^W2ZMLb8ZEX:0&2Ef4NN,8SDg4?4dD\1d8W2f9>O64=@K
?/ET&SMMT7dKQ04@d?5L1JcI@U3E#AIX^)/.17WEa)KDI[X>NfS-,UBQ4=CL4T2#
bCSd7[BB^fWMS[c#;V,NWdILXFc;Df)b7)2B2(>_?:8)?#<515bV7da(@V4MJ)V^
ef_[V[W,8f0;M.E\PGbBLW(EJ]N(e>WgWPf#,GB.D0W(d>7UR.]_F.EQ5B^Lf:K0
^Vd(TV_I(RX3?A.E:f/5+bUKC2ZX3S=1S8WG.WF:J-8A0+<DKdD3a64X=N)W2)/@
Y5G?e4-Rb10+b9aH6c9#gP=L@_@UaCTSWMLd.#M&FSeS+)K.7.=b-VCQ9_.5TYBa
C9SDaKF;A@Bc?g:2>O]>FTd>g^P6T4(9.C/dd2V>f_RJ+WCe72KS3A/2cbK7MBHD
+cML\U/,6>XUBf1[1)=?ZM@H4bd;6d5@<;THKLU2dM8K/Kb3X47FA_WbF9.gAK/f
eX:CE6^NWe)U)/c\1dVL8\Y;SggG??IWXe#J(P?9bK.??6CI9,5<[RDB0R4I[0cC
6U586=W-\ZX2.Qe)(bV^RW=70H(T:OXa18@ZMdE?]LWO,IR1=g075/TgF^.I1@6F
#\Ud.3S,5+=RfK@<_7]\Ee?7&W5V#6H=d.Ke=/d//=6b<35&5B>bE@XFC)A)]aHD
@>Gc3UNS3=]Ne\[g1_0>^+9SY6<(G+bC<)7:\c\Td0@9UO>)4b4UK8^;M8f_3^Xf
E714I^GU7a@NJOD6?gFZ8YF:EO,3.B-E1\=).6I3>MSO5A53.?#A-&T8BK+;IPHb
>^Fad3Tdc<H?1-UFZP[CLM:HU_5+SB=0L74U4,-E3^DF1Ec>Bd/Z5;&3L+JNQCD2
<CJc#GbN]<?<a8gG==AE#c.]L^36F7]bYcQf2EcdV4?Q,5b,MR,^d.HJB/WcV++d
WOT\bG3KB,B9O#6;]4YcW\]e\).eNPJQbUY/O6SV-,3Ma.#84@,.F#4OUSUVcd_8
OAB?gOPJaL\T\&?EO0TLePG]7K1MG9[,9FX=OU0ZLPYNDM)@E),QD0JPbM7TV2AI
NM1gf03GP22WZ4WTIS)dBVN@R(_:fccY#Sa69YHf6f3-PBE44+\d<XbYBJQPPR50
>XS5QA(O,ODO>08;X^XPWBI?EA;;U#5(;fTNg8dX,0KU0-9]<+_WFM-e]SPccbTV
/Kdf^>;/9/+<LGN[#S\b3#3?(,+K\WIT>VW(&43aa&N5B_G>O[@XA03:Wc3S7KDR
GDgSUQ.+=0/9/RW1OSb@BE/=:SBA9UH/3EC:cB:bJ#2(MMNGONCK/?;f&1LDJ]3C
0bNDUF#139()dV19ZZ.R/_VV1cSCY4R+O6C8V-QAE>?^E)(Fd)_O&><M,MHK@@e)
,1SV[#<MEXY,4M=b&BKM<U-]W:,U@U._AUBX2UT-R9M4@/4;#;//Z@aKQ2);DW#c
NKTK.cW(K/c;+Cb]BKbCVC-)OgO0G?d&b4C)NJ9-X^X-9YO-VFbTbT\KBGLd_8bJ
ARL>Ef8dT.S?M8Pe6aSE2_,QbUDMScAG^4^7A1+F^1-42&O3O+c]5#ddYT??;,M^
-7DRYR,[<I>LP#6G.72\Xf-?P\Sc1;?AT?R]68c[ga(P+D^^FRS?>f/C<3S.#Z8-
?EZ(-FA&Ldb;F/c2QZ;A0/4e_\Oa5/01+RTa3a\S<,Ye4BO(+>gL[QNG-PN<=2B-
Gf^?[VK:8]TC@b#[GM]80-+dRSJSg@/3UGH34EC2N&df&,YNAA6W=F=d8GIbf:fX
@1.&+N^]a+g=f+B4:dXf[fQ4,T79G4[)R:T8-8O[),B4\:3@)>[2H\O)WA[Ha.9Q
[[X)QY<3g-:5c5fQ\RB>SeJW6gRa@R:]07G#eL93.Y:^O7^@:EH//?SCC(8Ic#JN
EGb_@/.cfH/Y6a7INMY-4#42&-ZK26L<Oc5>:-^9N]f:5H:^SH9HZSAW1C;[CgeG
#B44JZT=5.+:8XUcfa9H4K#ZU)IZ0VA,GS0V1A+fcU(#Zb[Q=AA,\?LLKLI]\Yef
)U4b69aL^YZ\eZFI37N^IgWS.WE:(\Q(-[\5R;D^a\_8,]MLFXf@:<D9.]\=@3^A
K0/cPSY7LMFg]GfL?><Z5c2T9/fdJIM_I,-7CGCL^Z&FB-Yc1Q4^9VX^V1.1RX.T
eIT=7JFFXRHYMZJGS0)7[AGN-.6[QWWA@MKaE?I.fKTAgc3OFUfM\Z>+/UP/,IP@
AdJ+(H)g0G-.,1bg2<\.N.ERHAH.b-./g(;SBDA]f\1:f.4b0^BQ7f5(;)-D5^G5
SSBGA0ZF09:]e5g-LYFfHY-HEcZ6d;DMJ.O#3:8,@<@YY?9;]1EC4]C>9.W0U@//
V7Z,L-<<MaHC<d_,<X7;gIWJH8Mg-DSb^M_8LT59\:0R]X]C]AdfD\T.J:AMaIc]
K+J@V8>+,:/(:F:V=+5QA(BAFHR_9_cPQ)AcC4U[(EA:D_62,;>0,aA2^dG]P_8)
,.&0JRf9I]fJX;MbSDB=#Z)Aeb=MCEbg]DGW=6<Y+&G)09PTcDX7=)O9;,/HY]-7
0O?XKPSF4I-@f5AJG7L#&8>D,DIHQ,b;3@]<3^+\+DJ-,I0)gIA=-;aU-RMVJ/T7
3NHWDUO9(.:=NHYWgA&c92UDHO_KU2HOIZPAXZ8\IDH_(G)3KZA+)5Ge=2?bc9PC
>:17D@I1([X454g<Y?5D-Y[E1S:TXR]>23bcR.358\UA0PcEV.bRN,?>/G?7.G5a
+U>O.F5K\#aCA7[TD@a1#TW]M=4&;6>7d1W9W>.(T_dd._;[#4K9PDJQ+DYKEDdd
C?QH7T61\&N85Ee0G5_[QUI:H/,=FA12+.OJ6]F/#Ce;?d+GJNGT.d&8ES/HZ>KZ
PN0[TBf-<a;;C=IUNLFIWK1\YW.SN(_5T680BA/\?5)cP4GII51eDb1.2N:PGc<8
3=S6cdZOEA/VLY69QFPNI7@1abN<+-X1Y:-CU[46K;g[6c5AcbIFF.cbD#2b;#Z)
a(Og^3Bd+IT^DI=@NS,dYR?9)Z&af.]:fd;>U\R,_e^=adBAVH?Q.FC6Ob,)F1WM
3N,\LXc3_,47I4)0A-aU5b,b(Y?aG>_FOCaOK]aQN/5Q8VdO5L?@H=bK:O2_59AO
HDO?GfA=,5/:ffaB,L(&9:3FdGY2G(@KH:#&>HfXgE1ff_b#fe,V(-/JAf9X?G_#
H8NWbA#A<G=DcQ-#bVA:-G-gO>L8+DTC-daeXRDZJG;-ZAac=SWJFU1H5@CYG(a5
bA?O3_W)DCg8eL8^QJ=HU#)bR&<3(5L2a:b<d0#4H9ME=E=+_VB\6W#G;<WTXDC^
fSC7GO;VA^H.[7Q1H06J\6IbTB[fd+#3QI<2ECCN<9AT-:W5.0)fa(M0Sa^H,+Ab
>S_O0-&5_aJ#Z);#Mdc4XQ.YB^?1Q:5434d_2V#eZ:;fd1Jb8QdQPaW/JRaK1>G@
XT-MM.-_aD_a_P9,6J4LbT29X7Vg+:9[bV3^@&REB,g7SAMb81TEE,5:Q<D83E5K
^=B&/AB76K:;dWT,6UWKDGb>26&VLO@VGW@N9YSV4[K<.]ca06V3PNC41A:@9J-^
cWb93S&X@@\?.4c2#_-EFT?W+V>CA)FM+>GP:>,\^EJUXcCg#>GHZ.HYJ)L]Q+52
<cK+LFXZd(:D7#[0;-BK,IK@PZS0(d>;D=Q:_7178.:I.Y<89FV8S9MUH)VdS9<4
(8O28N^79Q@+T,9AQ-QSK[_b:L^/-L(BC[dAe(BAH=MN9BgIE[+G;/5c</&#;e.V
F_?P#]7NDTB2+1g^2P#d(:+4LHIE0IAJXD^-S5Zd)>TW]Z=O>SE<.0\<gfN\D,Bg
dg3E5]WKL2N=2]2;1HN=4b0aSRAX:N(P.F=,5P<,b_.MK[Q#T/[:278+-OU&4&9G
6J&:KZFeC@a3R?B=1F86:C/D5VbIZ2/(1[A0XO?cEA;cMJ/G+^fCa#_D.[T(IVU9
G]:ZSP;e5F2.SM<aMW-QHK3C/H^.<gS7FBVe;\Qd<dRG&5#NP:OTfP+81aE;2d[I
@f9_BA4cdA;>2<L[Vd[fD,E\8(JVR,,.XVSZZVNdXZNQ.SD13f7-U/3H=5:Y\](G
6-RC)b@TEa6B.fUK@68,VJ@0,&Ke\5bT36#X>WCUF::gc#0T=(PTZQD:88H[c8NR
BVQDHUA,,R5@0\K/C_9CM^F/.G#A4_[^TCN42_1R/:4>PXG,4K],??g\<FM6K]ZN
W01A)5;a[@J/I&8e8c0FfC3T2-bf7M\6JJZTU<Cd5?OJ2cMVV\[J+<&LgT214GfT
<X<=4PF+[,B<Md8FP^?<A?S?#eQ&\af_e5__A3B8#OQ@_YJ;XgDeJb]:Dc(O,FI-
@O?^7;F6,#L<cb=;+6A,CHGYH@.#fR:KVGY[d?(I@PCc541^+O]:6b51@e3[@cWJ
A>Q_]V<dT(CEWTK8b[^G.#=N1SQL:1K:CVO&.M8b3H/F_#7R\c4DDA<A5b-TA(.\
,e7cE.HUT.0Sg:f26@fQ20Fa2]AIFRd+/JFO.LK(.1bFJf([)C3=H400067X7(KB
c_GGeHa-UVX,]\1g9-d2g5f#YA,a4KCN53?,)KeW^8JQ85,<e]Qd+(^XV>8;HAUC
?g&d[[VUD],UJJe7<MP,7LYXCK/)<O)O-8I071Yd)M)-Sd2IDU@=^F?@0BGTbN.(
CQYPK.e]7MD+7P..29a1^fDQWE^:b+JT?7SE;QG?d17V5__Hf=SN6;J2=7W,(f8:
SMc(;H6bDH&C9f#aN-c2H<M[b](]O0D7EcT,_@+G]C\eE@,(/G,2N0/1g(<:_c.^
<Q6HgM6\D^K__^YHDFXRaWKEPAV4Z4)613)I?]XYaAME(Z^](V\<9/PVAM(R+=\@
BY6^3\SX7]X8C6adI7\2K8Y1a_3F](feQ,K,@<H7WCZ=/H.^TV,M,S<E<<2Rb>E@
0V=[N4NVJV;C.8_1Nf;(aOK=;,PeZEN[+bYgfWD&UT3Eeg1Y(\2L&V+:[cB<CNX(
/V7QG[XcZga<QN]_U<e6<cb3C:M&XT0^a_g^3YH3M+P+<E-6e]S;a_M5)OO;c^)@
,T]0<#8Ec^(gTQ:\QZe##N44P9B]J;T6Q5\A54cd(N5?USe&0?F63OMAfe]455[[
Q?]HF/7AR8HfF^,^;IIXaD>#3OJTY8g@Fcd4>A8->&-PCVW<JCHH;gSecD;W\M>K
,2e4&+)C+=/?f>B@;d7D@Yc0=d?H=gEN(-9S)M\W>:6S5XM2#(5fY47WYFV^CGU3
\6D\9YL)O,cF#Qf=eF5U9R.T?O]OF@;e\U]4Rg=5(1)dR#bcTW;S.@[&R,:G77TK
Zf4_60TR(W+ZBcKeb)[OV7#)?P8?2T5KR/WgI4]G@;V40d+feBV,Rf0VU^L>8.a@
M:0HeFYIe-Wa4Z8JGDeC(_1;a]8;]-I6W>9#&ZJN[)SF)D9JPHCb3b?)<<(1(QL?
5U,D)P:Jg6bICJg,,E<TQ=F,<;XOOML&+]]1U?5EUZ>bacMa&f[MA?-\K09:EBUe
M9/N-P]c>;V.9+.Y]87d@YIEeFZ.N=?&B9POBS[CLcGA)I58SWM:9DaSbTM-d/Sf
P\3-NWN.E9]]UQB[-O0KE3&G1?gA.&+N]N:]@T>6d#e#OYca,:SBK/TH^((2KQa-
WfS@0<28YO,e)J2PZSP8/&4HDf,KQ9[YI54]UD>aUacGTHc8848#,a&BM54AIf_.
CA-9.A>M+_bR]bfTg;G2.b85E?-f;\(:KT<@[;A.U2Z]<A+C]ccWIA\17ZXg@,?[
fLc-@8)gAd3ZeOZ>(6cE54LO/L0G3dV+UP_0+3]g<Ma3fE:eA<8PUM@G._8^W4OX
B4]bMaJ):cF<K.XLHN54a4Sb_?7DeZND/c<)&D>;P:G96&RH<10Z2<>=MUC.0OKZ
D/Wd=/UO&aP)_\bSPaPRL[3\e)aMUG+5=fKdO:bJ_TdQK@;PNJ70+5g6FP;NL<8P
e(?=LJSA3_[0QSbd7+OdWW.f/,AUE8]]]aJ?JP)B>abAP5X_6F#GIe]KJVa=.J;>
K&6/0FS2afeQYTEXJHf0NTW@U&D;HKb9K=R7<e8)5SV^AL<=)XXAI3/,6eFf7Q4?
V:gG-R/OR_dPUV5Qf\_?gGdH.J#OaIX.UWgKKO283dg-6eb9M0F<7?5ODUO/42S@
])a.A_CINQ7T#J2H_V=ZY()&\V?J,;()]T7/gef@FW&#V4N#a]?LKOe5WgUNeJ4O
8ENef8PAL(4Q^F4C#/Z,]9W[D>]5:@^I.#-=R/[g=X#J64Y0:,PO\G3-H4:WH-Md
C.O>8EV&_CB2eNGVYE:=]^H;Jaaa5_-[61Y0a3C<42Z+OQM#9QbP^X-ZX.[V5>E;
.IZ]3I994U,5O63L^f,;</>L;e?W^DIdJT5b+SF#/#SaU#_=3R6)W.F_OD30b[1K
H6)37c6_=YV>>SgU&O=8,^fGcK>fEW0RSdA[LE3>./P4XKMO>TH9LO:^DSP>R86M
ZUcLfP(Q^[fUd5[e\I9+a>\^J]4ACa@GDa-51HE.)AXLZDK)8gaU?c?LJ_G>.9MO
I5E,/5P9bGKGVL)9WVFARR&cTO.X+C<H7c8@NV\HX4a@_1ND9SF1T]Rf3cZM+dTX
+AP3adEd:0d&eUVR:AGK#AVQXY0M^H(485IBTT?B)Y(b>ZQ@A&]],:JH73T>SGT7
ZA-_>[F4N7V7N^M1-R0fY?3Q&@Ye-N??6e3O2J5Y6N#+\VNb#-@<XR=HI+^PM5He
;SGbFN>92&YQ+;^;YQIFYEAX&dJUIS>71JK=7_ZTZ:U8T7+27_O<B/[\692V?ZES
S2_NH=@95JYF&?I7I4UdGL7RYB:^(4E\?E/,ZOHJQ(T^M2&)H28PcK6(:]2^Q8bX
cDb,^21\Tcc1U?/bU6PT+JLb19JH^V^Wg>I7@g@XPM46&XT./@R6Z8_\:ggf2<(P
.=fK[+T1NZ.MJA/#/U4c,U###=)O[1eQU]N@B&_MWPLKI#:K6;AK@XM<_7:NFg.D
<<\],&c45/&J24/)/g>8fG,WHE\=&(?0Z[#Ge\8#:H_IbIO+OE0#^Q8>\b(Sg=d,
5L+cO9b[YIIg/AL[;V1QCH&J[&bc.#=,8PH\1E;RRQ3Dd.N[4<U)X;K^N)SOHH>=
1&H<<+SM>,485CV9aWC\R[0??0&a)\,Cg<5e=NGYI)0@06-[E>-8N#NKKMLZC,d-
/L()F&A]6@cD,L6ALZ\^1>,/QC7G5Ecd\Hb;,1OgG\a>W9HKdI,BLNNF2S)M(;;H
\3E)+.&d@eZcCYCe:I+TKV=[;SLSE1_O9S@#F_N>5f:(Y=6\cCV-_E/3Rf>\&.g?
,J6HbD@e[_/;XeT1.gO\R^=Sd?@(R0+Y1#L]CV<]MS\+;-8/=_4-eY3@Y^F@2]<K
\5@+BNaP1NP\bL[eRU&.9;?:>I\PT@V\)9WK_E05)[fF;H)W^K\aK#N8A[0?:TNC
0O_I@b_\+9O:.9E2BX93a?+LK-ZQK@(M(NUAY_P<0Hg)H&I>dNTZD3_7Y0]&@\)V
3ER:S9?W5AgJTGF&P<U<NV(5_&OG.Z7DTNYZN-0Q+O.__3O1PUI;>dfY+7W]g=3?
LE)<E2.+2VYZfeK:ZM=fG)3F][#V&TPRTgK?fdM0:b\Q(6.)ZWLa8((\dJ<MT0XO
9R)0Nc]MWVddB72/UDZF2EXfJT^c#HbY3d#8^;P[?9EFQT+-]B1YH.QKU26:[Z5E
X6#CFDZI87F5W>SR+.Z6^Hdcea<MbSEbJd6_]FUcOR=I/_eg2X)Pg]bb2,K]Z&]F
Q4J_TQ,HQ.-ENREZG5#?/Q[:SQcR:([F>.F15Q@Ig5DG:T:]_Ic+;M[7@#Wd39AS
Z=6/QVP5T2MI]2L-,7]U)ZJIZ/_?XEX?VDDXa\)E:/V.gC,U09,0VbFBMB^e5\Q(
A[.]c&bNDHa>3282EKX9^V[U7X=NRW&[G,QW_+1:LM=1V_M/9,\-g\4]fgU=?:@f
MBJ&@\Y^3-X-B:^Z8YX]A9WU]<75VW?TW-c\E^.U6&R#1S;Kc(?&;KX&515K?2,N
IR1_POfB&Q^;G3Gb/9.\6(fYRE[&I7KD?,C&)/+5(Z1/1@.bVB#Y>H][0-N7M^fc
c9O[\1&D\f;gM(9H[<.?(_<=5f)C#E)TIVZ0d[UKa6(<gd>_MH6g(._SXDGLFTXX
]I?=C.]^K8D4EH.+9eJV.e@_)4LXZ<;Ad+N.N[[d-;?0cA+XFJ9><@e)_O(]&^(A
N2<NKT=S<LHG#RZFf<N_E<J^JUT?]KgIf_.QM[EGDYDE0.gJ=^VX.4C^NW&P84R)
PF81GP4L@cZ4RfTAeeObT&2#Y\>XSf)3>&c=WAAARA+Ac5f#E=?V(c7,J^6K;2AQ
JDV@4]29#cXPVc[+]L<TG#U2G&SS>A-8)I,GEeOZSB.VbM[a#X>Z20V4:d+Z9<8L
DLaQ8IcG=N.H?g/I8V&]0_\CJ4Qeg9]F,Ya[DVVI\AUCHMO;&&2(?U^><5YCYWUW
&ffXS0+_8/Q8X5I5P14I\V205BRZa3e\CcI>D5b,LV+c3(4IMXCg+K.QA\D[)DcF
#7.QYK/<.#4NMHK)>YC6g(P&F9[WAF5<=CN=BNE.U2YAPd#L?6Y<_#-/YRVKSUE-
]d]=_ge)?Qa6AK)>e[A(:0a+gdYPOYA,;bR_>1:-DMc29E50\<11/DJ9Te/97J@b
LP\01L:6V^fb8+/I4KIf245V8NgGA;;NT)(U1b/D0e:O]Ec6EcR0,_ZaFc^G&Ba+
=NZMTZLO(KY&M#4QDcRSMQH<XK4_cdHV6E&]XT315d:U?P/-Kf]IYYJcP[>eY@1J
UN8^HZQ:32\LS2ZL3H,\>@BeIf.SP[>1]7>IZ,@88U#J\dN#-:V<L1GIW4:7\1SC
I(KdVSLLM^-8PI:f_HX^1>c89g8OBf@TRYQ#Zf6?.<:Xg:8D+>3306X1::eSCR]J
Cf//^Zb_aM)/#S2Rec74/V4.6.FT&7;V#2a<Fe=RcTFaN_,4f==#2]4aQ>_-aQ[E
JH.39K.5]L-7X<:QK2BDEWT6,?.MPFE+K8GB=3==f_A/+:#faB_7&Q.Bc8#[:adR
M+2Gc1Z.b.+:C[5ddaOAJ1U2HFgPH3+9d=<8T]3:5;]V]YEQ49;#UP>1WJP-V2bY
,L.A&_:@PC[HZ.Z;D][Y.d2EP^:),g7SBO5N.,,b#f[(cfT)HD@a+0MgDg<&Z4b5
,a,9NPR5?>5_fe3<S?FC.a5LHME<d4Ta=;HYL59^f#4C&;?H0]R^NA?YR4-Z-)4)
S=W07AE/g.<@1;9-V(LgIe^4?IdS-L7\Ha0/)gaH-Ue(TY)b#8Cd)MSgK).SODY+
WTJ[U:OLB-M,ge3MXXXd3W6P4JXCBD,&QQD#)M?.bI]JUKHc;=0MUHeY/D+DT&JB
P.31ZCZ#FD=CN/VdQf^6[G409@N7\+;^D)HXQW8>LWT[/.+<9WeV#7:=A-eIf8L9
dg7KY5+H;#,K-C6Qe_HEeg-(LVM8g6URMGWS\a]3KFYV6S7>=:Q(J-eW@+,=>Q-2
C^&PBbZHKX(KQN;5)Gc&1F;HeH(BW-V(7f<.A2V.S,/f?E3-ZdO#?J?:I.X?@bU6
V&F@US67<f+Xg3/Q;>L8@3QCb5B<fRIK]GC4@?F+3\=#IAdc;5,#-RC@-Q2;H/a=
V6Qa]/55CfMF1ZJ;O7_&L.-f=ebLVd\3cKPXaX_\c@&OO@aJL4dV:6f66Kg-_0&-
_5/eD45]D_YDA;QgB6M1GY\_5JMF1F,D0a,PX=>?QMXEBHZM2gPM?=Y=F8OEQ]UW
FOb@/UW/X;Wb+U?[<JB?PT2ZHV9dXC18&[@+28;-36&S1NP>IE#3d8IX&O5RZZIH
D\.M62^&59^R[E@QL-&WJaV<Pe9bD)4cF1V<9=KE(<f:E?LJO5I]+?[PC@,L)7Gd
+-N2CRXPTT1_M.94Sc5]&bU^S2VaE8/7@#+Pbg5d)V&UTV5<10S.18Y\VWXS5?H1
D;Gd7W^-:@KHCeOfd77,;>/[G>MAWM.+c-[_J07RXBg)3WHM:(Wb=bO<&3>/#VM9
M5.-?a3e>5S>@/43gB)\Y?ecG;[R,^&U9U\4X\0ZcHaFcd36CU2eWZ/T3f18&K(4
6Z2DdKI?[SSY5T(>.#S,:-XR.dPW8))LC1>FNN9.M@])_abF]=:(B);4MQ]D;9D=
?fP=fZLS,=8F)5^T[)=A]Z0YS8J4&<IYB9LRATQCR(508BAR1UMHJHS08VfP/G=N
ZXe_V[:[-)GO@(?GA4XF2B>:Y,5a4DKLg>76IZ?+0>fDHK9A-f0[R5#^2(eP=R(.
B2+@XH?eDU-=D&gPdN=?S=G#I0N<?/,3R@&[EI2Def5K4-0_],3J8SP2GXORR=OP
UX2e.XKa3_.)THG/XH>=>5<6>D>K\.VXKS.\E:H)037)P\JC/ERJ4ALb9X&520gP
OY698FH:gT8LU,O?@ORV-Y7Dc_V6eG;XbAF/W;8R1a)RJ1T.X.gEa.,1NIO71>/T
B_BCMOBW8#JW->c^:U3@7.fJ8Q,LZcZH(?.-R>DPPR[dJc)b6^-\,6d)FW^+YK.c
[ZHEP>#P2VDB0JW)I)#6NV]X;bJ\D-=>eY.=FP#W.1V^8Nb)_#NNV#HBO47)FG?E
N7dY)KP=P.,GC;Le_]1RZ/_Y8+KbHI;A:MEbb>0T404#SA?0-LN1#YeP06\S9Zd)
Ya;8\bU6,:^GeAB[CP]CLbE[:M9Pdb3dBdM>_O8?ZOZVB(H2AI,4d2E5K3dda/RZ
I:CSKaG&UN7\,OeDJ]5dHKUI^2f1cgJ4S,E3NWJJ6[K4T5U4bXT&98T7J[=PXHM>
=#Ja@,<J/DbX>\/:@Og[:;4<J+Q[V2@^Ke/HD262V=;XEb^5>b#W@D,@a1V,F^eW
TY#;C::EUbB2F9faf.X0^P_1X&0JeQ3JZENLR_+..O/HC])V..Z3;:0?3W5:@RY3
[^N_[dNUPK,7<E#D\Q-VA=ROfTeP:fME4#O,AMO9UW[Rd,#]ONACKH38<MeM3Z_e
f]S)^,9P@E4?UM]Y)IAZUJ>L4BPOY9E<W5.DRcOG@8d#6&d+(FX/(K_M2BH/__L-
Hg.P#?O#5)NAMPCE6()e3323FfPQCB,>K>OR2?+bb5D:NDS[?B]JG&AMOgV0V^49
8B,B\X609+f-TTA]FQc5ARcbA2_PgW1S6:QC@<@2=<bKVSHXe,@SQ\BCDE>)S>\:
ZN?b6aHP.B/GEI.Wg[C4NgALZ5IW??&eNF0(BETYb(=cFTAT/9g.OD\B#<7UdRe]
9>K69/S\\:S-BLS_BdSZJXNA3]>+.@6]-@QgcCI]6\>R61MbUR<#P<E0[4_PEP[^
cJ2B2HR9f2aP2BM-<8BbI(BXZ.TGKYDPW84<MS?,R]_HO?#\YW0@L5B-B4fXG9D]
E:]a);F#<DL\^9H2.:.&8CI@6B/2PWO2,22^I];X+R):+8TfB[IY5[)91[f83AMQ
CAOI;^fg?0:JD6THZQRLAPOX0f<5N8Y+=?5G-U.+Fc\Zfd8E6;dE,bF+QG7,\^>g
U7DcY0BRfe=P.6?bC6g=VT^QFAFF7,58_.AaXQ>b#<+)5^A0HM^#6YVT_9-b^_M_
\T5@Ne<GaY4RJ:fOd00dNLF3X2LTG]&Z2@;R,5P-G-0?b#[9-aG&#NB,[Hb5\N_H
D/>K+f5&[gUVg@J+K]Y8)GV9F7GTf&)+_I(L@GUdRY_c?:>BWPVC@]XTKD0?CR&S
;ag4/;>GS.],[eCOHg_<)Zf[QPf-A@JM[_b9PU@(=AYTg-6WGJG.gDZ5Zg<S&VI@
PE(d/AY#.O:Sc+JNNCK1UVf_eP)fSQB10B;DN[?Rc^O\Y)WX4[=?/(AL1<PZ[J2O
cX5GDS&L.f-X:S4;f?\.e7M<B^SZ+g0DGVRgFf>(V#g56>1Oc@G;65<=\?^JgM8J
ea3X3,gfegNe1VT\90V-c?e6#?0,<AO?,)>d?c;AB(Q1;\P_]NedfEXeHT^Dd_Zd
>4-+K(fW&?XDFQ_&9/,,DZa^a5O,#HCc1Tc04TgLf3d-QfJ[=QC?U+T-)O9Ff:B3
8a:EB.B].96T2,)-L;FLYT:H>eg=cOTA,.<JN1LgJQgO//Y:eFN<eF;]HNLca[.<
-@;A:gR&<]W7:/4BM#56Z6cYC&MY+)RK4b+SaVD8EP9b?&T1d&T\/NOa)03<)P6^
_\[.-)COaOHG+;;LML37YE_f2/-)15a=>;?/G;eGE[I\FPFJd-J8+>b,XIc8H&SJ
QITUYJ)J.gOPM8HHXKK/T#U[&>1;QHN0M\Vg()H=-+Rb(L>ceCDD\JI)U]JFLECT
?6D#I@&PW-/=bU7:MPM[Q9BM3#gJQ;+HBdG/?+9@?S/;=:7KW#WFA&5/7S7/3A(f
>Y0P[R8PK1;)8=W0G#=Vgd1I@G4Eg[0)H=Bgc,K5?4#GG1]<H4T:W]a9^-<Z11CP
FS.cGa-0I(UWRbJEM+KS9;CF071C\YS^=MUNZ7&USL164M_H>^5+g?(_)7PVJ8KD
K2H);\[eM6B.190L,[MK:bVLZI6CS7(\EN4DYPNRcCH4HH=VRURCM@P6M4G<gW\[
gTO4#,QZ:Qb]OO\6.;AK=[JIT<?41P3/aIEIX:#:;b(.[G\-Ma7d:&I(O=[]aNFP
]:ANPUge)c8^-C@M^fX1DJ<fZQ2KQ#AN4>Q11;b=bW)X3R.FPMQbL#\&@TT#L?BR
0_OaERL0K:WOJ?N/?FO\/C1UXBV,RS+bGBE^1PF2/M&ceS=#.g6S1YTP)H<_fZ]H
\9ODfFDFNI:6#EKYaJ&ccCT/13abHX/A]N7RTQQ71W3ffB>@F9d/fR-ZJ@?)(/Ka
ScXJS2cBEY_?GW55@H4]\AU?O;Tg\(:^1/I_I>BYf]9e4)XHf6?6[T?HAP)G<5(6
=+He3.B06(b:X^\@XN<N5_g[.2XF4c4]9WaV,.&N0/2f<ACW?</QC6CXWM3O^(>N
WTW_^1DZJLRE)A8+3b6LQE(18CcDBg+TXLT[_fHAG9-bBKc?YD10T-RJY0,09g?a
:fX?b:@.FF^C5OD\g4X+Bf0R.ATQG]+Ye@Q5]&GE.SbXfZC@G(BW]VJIKf8ccEdc
<+(/O]DC/N7\GB,QG4.g1-@a8BANDQdeFcL3fbTdARJ)@dc-Y]^=T:eEZaJD\7g.
RQ0Y^gf/-;7SMIg8K>Z=U7COUK)P_7GY]K>PKgHVTL]_3V_CL[^ReE_BCH#U\,8&
;/E@^c_E2\0J8g_&6K55SDRK#MWf&O?(Q]I]g+I\c;Qg3)>X(&a5]VdQQUWRVTLX
V2a@,G@B2T^S?-g()N1BZ9]AN9)HBKcBWI,DDRNFO<W3DaRe,cG0U]c.CcBP8DJ-
2;QZf[^]5J>0M_-DeHG.U<dc9O63X/P_(RFPXgN;EMV5JLe>@@EXea6I=8J4Yb](
TG1MTVJ\#c(&MCfGbLe;3?@SeG3<DR)9P4_9#6K?2_+;Z;@g#R]X#Q@7]Id=d?T\
-0#:g-[T\,^SeG((W[f6_1aWcFW(e1H2g:,Sa9ZM=-P4)eJ;T@^0f971KSIJ5];\
.UfXYDeA2+=+3A)2B-BP/Z2O0+VbOaA\AJ8W).>=.SL-.bWQdBG#5/FQ_C+a.D?S
fZ)E=13a6R2ABYPM7b]Cd3LG[-g_=V;B9,U/[F_MXRFQG-[RXf\3K,R;0T<#/=&=
G,Z#F6OQ+Q,:)@3&\\2=8TFNK5Z#LAKD08(2VAe7a1ZYbBJBf4KN>1\_bWGY.A6<
^BKA&VbI<LENQeaGK+:0:XT]LcXTa0fY>IQg4VBOU<#KBO_We8MJQc405-(3_UML
WH9)a2aT,,^fg9F-?5DW+De2.Ud0[6X2IK(fCEd]La:G_UV2CR&4I9)=MO;;PTR2
?A0Fb@XO-.gGggV>21#a[?3D\Y6AeWaQ)NU?6MUAfb[-LB(+).PPQ(Z?Heb+gR;b
a]>7D:ONgAe);8f15TV2X^fN4f<TLEUNQ?7+CURS6AX>W9BgLMJ0[Kg&EHJWGS&X
0>g/aPTA88XM&@Q87F)7M#c9WS?XL+6PQ<.Y1N(1[ZM,_VZI?P+[gPV[UN&+2C7H
3&=<7P8&4Y/5RPFP3?Bf1PLP[@664dEV6E+>9C8HCO.)-WLQ>Qd8PA7Q,,/RV#eb
UTU00>&-2d/7\\HJC.R-gTHZ>JB0.NH.(0COIY8[Z6130LWBeMGTcbf9>-9[1D^V
Z7-<g/A=0)[9)>J=RO=:Y0>@2UGDf^RVW+Pg7dg>/bJ>(V6-(J5NUM0VG[d;]O:7
7XXg\#aELO]KgQKW6PCPQW2G_,D]>S(FL7]D=e3HX3M52=FcW0\P&)1/.Egb_g0T
OEZZf]B]>HNM,]YZZ\H-8-B9A@WQGVdDGT)<ZM=0NXSWL.,^&MRLV7+>3Hb.]M?9
LVeV&Lc;45Q;\e99@c4Fb>1EaGJ>HI>A)/U/8Ga79>WR((?-7FbY:2ZZ:-C>WPW\
f>/g82gR::Y7XWJXWU^&[+07_:<d,[-#+5Z3#N;Ufe@F=..Z;\4Yd&8bIZX3\(Yg
E3U?(5X)NN+_9MB#K=[gT^/#^D;c0)O=[KVg=&ea3HOH-BW_^&+TEE<W3aGJKZV#
?O0Xg2OH8#Z_2eRB+<Db/.dW@NB3[W?#^Y-7Hb.&UaPW]<S.eFVIKe>C@AN5Q?eI
.>&H,\G4JKG&Af=6\9?TFC.8Aa+?C2JRe6<,-(N8=QR:QD4X1V=O74<:ME@08a#S
BVQC9:U[H+1ORF6>dQ&21(GeB]GOQ[6-T:7D?=DaP0dg&JHI2(H)[0KLU\[-X=D#
.LA6@[2?3B7_FER5<_1U^-+fGV50]/4GH20(G9JbJ&]4FSV[PdEc)<)OQG:KAK[a
:J(.Y+9LL(_MT_eW-[F[8??\O<6a<-&UfV/9af-/<bK;LVUMI6>^ZQCT[Hd,>=QQ
X3NBaS[:1_K\F9-\M[>)<^Dg;?e@NVP.CfMT@a\2BP(B>HY>JG3):<7dU:NU^;HA
3-4b&\R5e-FS0_KNc1]XU]JR)]^<d(gVH@2Y0,@R>YVZVaJe&2W:EZ7c@C],R_F\
>B8M:8L@T1I@ZcKV2=]YHa2T)RD8./1[:bRe^YW+^9\LbPIT3DQ1b);;A;?F)KY;
RBNSd_bRMJBG2H2K\3AS=?[T?Td&KQWLO+UE]-W[?=S?.)=.&F37DN1Q?e?Z7E6?
BI08_O^R47HR6,CWZ#cBC,TcB)GP5K\E]]Z@b/]4Y5M5MJNG,)IeQ9.#=OU3TgN2
ecL:_2-/H:.MO?NW.\Egad^R@FVGUc-#].R5K3e3GOQ>/=#-c5P:JCRV-b7FOH1U
33-?_RE\^M?AVLL#CQ6gMg<&JXTLGd^9c->b^=LeCWY<MdT&3L.@N(UVf^,=FDE(
bI6ZSO_))SW9a&B#:UJA2:?K_R\K&&(X;b6[>d?eJMCOO3ce=1MYXV9dPMa0PR?T
4BIJ^9&aeE?8FV<(/R5BdCMHd8Z:6Y,XW>@c;T[9/4Q8Y;TNF[25))AGG]WN_c-4
<ONM[B/J,;f>6#5OU)C/\<eU2<P.A4D3JdX+Xbdd<1-8_#a[Te9F#WF>D-fQ6L>e
.@;W::,KNNCc2\8FLF(4Jc<A(8JU^0fYCLQaY\NFCDA2d3,^e(97:J-gW9cZ,=LN
KO&.UA3d4PNH\\\/fd--[WVLOLeCST^A\SaBL=-TJcA]W1B7JCCXbQ\eOL##\<WN
Y18(^J60dL=D.K+TD?5?^<eR01OF#-\.1M>5?G6DW-2f3TLF;4gC3Y.8/]?,/5N2
J^+)c<Ug&aP9B6A[;#V;6@Gc-L=ZaE=@aJ@-e+\R?I0Y]R8b+PBe^WB7+O8>BZc?
FFFLa+E4Sgd;ZG0_R8]Q7bc8g8R\d9374OEI/b.Y_b5245HB@6VAD37EKIb2@@^;
;E0bON-:Jaf^7Y]@:ACd(@A?eKOU^]8@I587B/R7NDWNXf[agKRA;\eK4__0dTD#
#/Wb>]VKB]=55f)9a=P?E.;VO=7>AOb.BO2?gJY[B:E6I/eCY#H/:XUObZO+VM1,
GXB.dCQRF@SN]3BU1&PD\G_KXRUc>1V;M[6&9#af(P<?L_fW;[?g-9U3H5Z^WddE
OYY;^2,^1LH8FCb<FH?R6C_L/^BM^THJ:E@@-66LU/OX5]bMV/R<;b8AIJ1_J2Gb
(9J/-)I.]WePg]]US:08;Oc<ZGQN?1B4@E&T.-::f4@+R-LU\g72X^[bSEF<bcf9
OY[DQ&#YA)]-A7RF<V0.=A7>4^^<K5d#,?Tf:J:N.E/IKE>:b,EXUN6Tb=WDIYNJ
W^(5+Y[BZU.=&H:_(Fgdg4#WDE1bRV:MD-/8Vf0AQ\C_5K:\[S8,[P-K#.T)D>9/
]JQ[ILad@:OJDcJJK5eDR0BP[F\<\1DJ6<MQ)A6AX8]_SYceBXP1GbGR1(7#U_-&
1BXNCE;)B-1WQ#]6edUH?T:P(/C9G8]RFG//2UL1Ac4W=5I(gW.+GMHcYH+.T@W=
@I7AWVJ>0)9FM]VS^\6+4<UdcER)]-@18N)Ag,C.=^AJVe(PRV)):BT5KO+d//:S
I>X_>HAO_Q,Pb3=e90M59T-4Mb^@L)aMe(5(_/:(J/1Kd+#IRNYYe8PM586E<VU6
H[]OZSeLJ2V57+6ZUKX<@Gc(LJ5_79a7bE;K+^.6:_6Q0N=KUCRC^0FN#FPD,6Kf
Bb>S0-D\>_=g9]2ZJV9[HLVT^^5PRb4_WGY7SaN_8?6RA_-1:A&4>MDI8>=1MY?A
?9_4488<^UIabJfXQ9-2U\gOKDY6+R\f@2_38d/EMWR7d>RC/#TGc28A[)W1.>((
O&/BQdJgTU2^7IF)YgbK26=I]KeZFF-XZ&J\J/PBW#2-1Q4DN:e41CJ<3c<7ed_M
9D[RaNT>VJB66.9b#c>eNF;+42DVK]1YW9/\g)c.Mcg@-\.Cb\.BG+XeRPX3&QH9
A?e>_1I(9b/]4Oe&D#-LX#1Bf3HWU#FW-9RH=T4>[@9=6e\HY6g>_R]Xb_a,UDBN
F-<::K.#75-6Z1-B,YL@e,+G)KL=VRAA8SbFLf>G9[[b7(e1E8JRd)(R#HR+<I=4
;XO6^;>g#)a_#0FgF-+[5O.f^GXTY=)):-V8^IA./2WWWO(XAAgE]],R;)Q)SMSF
CSL.-[ED5?TZM[N29G<J)BD#2#g-U.bI0.UI4+bT6#?BFZ+DED+_1[LEL/ecO<94
/T&5(#=X24W-/,c4QG9F;[6_L2D]ZI)I[0K<95SK8KaM&<J7XgPV?>204(P&-;V9
W\F:H83W7(K]9YP/Sc_[_::FQ.AF+GF.^G2_:-R)5a.=);KAYOS;_Z+QH8>/(>g;
-fNA0GJYGA5^C8[V5]>ETNZgER]L9ZPAH4ae]]XNX(&085U9:OB)E59VWU->/RQA
I_8)Q5EZX96DTQBO++7J6B>f>\9)?7_4cWMg+X)gR=\O8+^-NL)D,S&KR0^H0FKT
9.1/,1JSMQI/,6Nb8I5DH>eY=E23O0=TW(X3aZEI>FZW#>[<-1)TU_1f-W08OAHa
dX##GH1L+BZG1&@U9VgZV?>,=H/KWZK@R2YWH:<F^;]6=Eagg7>dd3I]1FCX,K<E
_X7B2IW[_B<G[@WQ-5[\\6LcOEBV,=7AAPFa=)H-5a:\]0BH[WR5KKIHKTWcTX=<
(4T_74.E\J&M0eIgQ3S3,?P7GePKK(7f-4>/^G#(H8<PcO3#&)#3UYQ^eK8S3FE_
<eQ6:/S=&\)L=]M:,KMFQ_59<#/eB?)NL6RN)M03P9YXE\LCRO##1SC_Gb0+>0O-
L,CY<-5<+\f<PPb@B@PRY#LV1Y_4E65T\(OUf1E?TKJV]IJ9G&,]fcSb.+SFeQM4
E+DF#)Y&AbULEWDf@eJbBc;2N2&c+B?):(WcEVF7N,cNU3I]U_/CVVgWNX\ACZ0H
WWT,IW&d^WMg:DaF/@b#J=19P)>8V_H@5>Eb7N7)PW,8RJS4Qa7OE&EQ<2<e<I,8
\B.WgOQc@MRYXG::I,&TNF>P+&#g.-Qc_H4IcHB+04(?QRA:1>+4aVZIT2^Z71H4
EGETHcG2GfSL,DTIZ^TQSO&2+H/H29RYA?[3:<U0CDd<,2_C./C(-2=U)SS7bg<Y
0-6Yb(?QcB)b=.f(&6^&]fNQWd@aB6aJR#@<[\-5P3/=9gg,GOE\)MYVN6>&+AE<
HF3CU7d5fIMHZXc-D.b\E?]82Se&dUg7[b>DG:]?.S#Q)\UgZPc1gC[EHg1ZW_d,
gKXPQRg[D,L(F_N)8B,Z#K0+8()/LQe=)#WOfX/[[W,Bb\JX_/9AEd62..FF8ZgJ
@^JVeSaCQW4RMQ/;BA]+S<23AD]/ZK?0_fHX&Y/c.eF0:?T(4A8M_e.FJb77IaSf
F68Y6DV@8BMI[)EZaZ@@Eb&-B73>;3[C8LC)YY+dbUONB.+(@KCC3]^O1M:ZN(dP
WUf(>0O9I=7e-U@[4SH1Z#dUO,=5LB?UGY[5?7e>F7?/cRa@[8^91A4<U^C8Q?Fg
1C&,YK9#<Xf:9ULR6:b6F[[?eO,5K;B>Ka+<D(YCWZ//bP3:.O9N@b]0BQ/g8G41
]&W<@L]_@9Q]1<DL1YQWdY#H#.5&&C1><QeFYLEG83\#0:^YP;G9eQNF9RQ-=<M-
+PEaT(B)+Nf1N;4RI&E0,;\agEV^Rga&6S5I-J5d)Dd6cdSL/K]Ubc#J0H5]Q?00
gQd2>d8]f/eA)>F;#:NLf;D5dZJ@G?4XCST;<JTPN?OB[V9MY+?M0B[7ZT[@03Z;
R1aaNM_+e[(:fM5+S8fM]K^@6W;K\12;AR_^O#2C>/7+D#WUc,.:>,P3RUZC5?d&
Y+c^/I)Tg0>@(6+JV&/1+#1ZgQ.,_e<P=cc6-M_96_X\V4aVTC?JQD9-O@4)_=RG
RV-W.MDBE8I+6X^Z3a>cQP[8\TQV(D8-?=F>K7@6C&+K[P2&\7IRBR\YL5\f/NA[
0SUYP+Y<W,Z,POR&K\>2PN0/gD\2J+^M5RJC#K&\9FZT(+bCLHEJ:BWX=f;N_XHN
DFe(((_dVO+(,(UZ:):OQM4Q49+K]ZVA,I/^Gca2eWI-SX)Xbc(/U[R6&NA6Xc,6
e1AOV&VI0QKWUaaNJa0O^7bC&.<+9>91NVF.+[N\GIF_=X435W#Y0K@3?[LVK1DD
.CTBA[D.?C\L6Cf-7D?b:(bM+gNQdH\[U(F2;WTZg@ZGM.W@RUBKMYB6KLTV@28[
0Q7RJf=C\M&^Y[cd.L:IXI09[LdX<P3D^U(\<GE:.KTaAN+UOgGO3&H6WW5eLf)d
T3))AbbAKeU2:X4dHV9E6b.H+_8=_^^V:@,72[&=YQ\B8=SSZb5_14>@V26#\c<a
(8R(>M@a7@LVd(;\J?Wbc1N#ED>8ZNeRX.V7dc)&cIF\LG05Z3A[a]ADH>1YH]7:
bT[dHB&.C0<)YUX(BEQMBUF02\X5C2X>9+K_^(Y5(M\#1X8<<^3-@aI8)VDCEPf?
H]C,+>86#QS0f-HaA017^@A;H-#)WUQEXEVR\/E<8WJcZ:?90UX[?ea./d8e/G1R
QYA)?6>4BWF@?Y8e5:F:]U9LE9WUT-FX#G0#7[MXaCI^RB1MP;NA_Z;):953MAS@
JO^_@V+AGQNHa;3;dK46fLVK>H.3eK8M,e;W5T]DRQ^#@_#[B&62;9..C?JJC46D
<B+<6bV&^WbS37@&gFEeDb_:6dRSM\,9?OcC8VQXH:BUO,CG3<X8[UEVVPYTbcEg
:[^eTR()E5@#SGEKKaOQcR@8=a1KCK[+/V#2;2O@dQ@VRf),8Ea\.[N;D]QJ38Q2
e/I5cH]W/FN>A&BA,Edb?X_cEK4]J4:GP>\)(GdO(PU4#9-VVB6aVBFH<,LVFI5B
:(KEB#1a@_@d6I0@ZbS6.6_>2#G[FbQ9F0?K0EPfA?RG+;=4c@T<gZF1GJZVg:=O
DYP6X1.5&U3/?35-.^=[<-A)b)>PS6PNS<Q86ZVJLca3J4&b6)9.K7[^V]([:E3#
D;.H8KHX7^HW[^(<ORKO4]?/^HIS/7R,e]35KJZK[/JD.P\?cgVa?JLRO\Jf:37c
0S\UP1)C1NXeLeX_7(K,+gSAI0daJ5C<W/,RPc(;>&].e:--&[V<CSU,#R>BU0ID
XDD&<R7fBeX#+#<[\ccDcLOF<ZJXT/FbH:U20\4G#2dX1S:>GU_N>/ZW/CNHa6]@
N6<<,_)^JQ#6VPU:.0Ye.>,U]:,9DF13(TU:gB1)Y):Q-0K^fBbIGHg(HS_b=\ZB
1be:&I<+S1c827FA(DFW<NR?@3?76c=c7B=IdN=0eU@f&F&IAFI>^-9BfHND\3PZ
5+V#.-27J7GPWIW(KTZ6#cU,I5Rf)VN.?H=8[5/Agb)B14A#4VD[A6/=N^Xa03H3
Z/Zb26)JV#&g/II/XZ_FEgdHS]4XdVMc0+(ZdZHD4ME2_J^.M&UW4+f79E;U:eDd
&[_;A/4Fc9+ZD0eNT^Fbb<4VB6BeFVIfX]U)dGfI/AR@#>/10Q^8IcFKQK7T3XO\
Z7g,V8)X4EL,+50(K)9P;dQ8.CbCE4.\6#X89Y@P,C4CQQNG@b3<Eg-?1]+XEK&_
_5BW&^1Y>eJOAd^2J(dK5Y7fKX4b,,GHcO)Z<>:Bfc>9)^71UH31Ob;B=VLE\dK_
S]3ZWc::3VgS2cd+T\A#9:bUJN<>@gV:4U<F7gC7fXF_4/B72K0dEI4agd&XA05+
JLHF4IC9b4+/+D#\cWA9EU6/MAO]:<@Hc1V8d,cSK6Z0N\:)3#A>6^fg]A41UC0A
.0Y(b[9I4S9&,6S5g>=QB&2[^5f0B2JV24>;IRR29O7)a?7aZO,/[>a[5-IWA/WF
NEM?ZZA[0^1d0HR,&#7eBWCYGG=L2_5I=0W8OJg^2_^5PXB4ZC-LZePEeHQff;f+
Z;D]cdST=^I(@KZ4+&M6Y-/5,?3YQ4EB2FUHJ;2?_EQ&6VUA\H,)9QO0FP+7a8<U
/Q#@LEP^\2HE()aR/<.;?(]-QCAcR?/aQ(1I[Q67^Ga1+_[R/HFA,D<(IBHL:4X\
ZT(3+V;C>b)LP&.KFI,UWGWR)1DYg:cHfcJQZ96,].F];)4/?.g:cR\+CTMJ-c_d
556Wa;:KMcZD7bGDZf(3CVQK3JV9[e)g_3Y9R>1c7&;(7O@be_,=]-@D@\OP@fX^
DfDM2)=CUgM66_YEKH__-363LR5^^&@S^EL:&&YVDJB;Ag=a_AG?(5B1&H6\P<?#
,(5+86Z<DgNE??K6Q:IE78Pbe)6dN#/LAPWB^QF>=04S7LJBS6Gbf2e3[J.ZfXR6
^Pe.FG:<c#dA[.AFYO:CL8>6:OcT-E(0gOIGIbfUcdNd2LY15F1K+a2]g?WP&9)g
+d9A)dBb63TCVA[PbP280+[Md>6KN5GYR29OY2J-0ZdPc:>IZ8J.S?<&7d(-&a7V
2dJ=:(Za-EL8F8^K\HSE+4^4ge?IZN,/Y:-Vc7F:)c[K@DC2+&(S\0ZG-Ae;_A,N
OO>OP(UHHIDGA1_:5=RILWN^9EHWg5Xg,0b9B;MP8O#Q^7a@^]RVRVZE9\=WEA#9
X&F8f\4V[b[\\bHX]8[A[8aa=g=dFT^CV=LS6Da5A8QD6LF(?,,WE17IR.gaJ:W3
[#2LEP-2#B.bdNZ19]=>VcdAPZ,VW.S8?06V2M?=J:]AL_5.G;/F?[HHP:4b@\1,
GB?:X,#C#[03)P4L9+6<D/N@cYI&8>-e0dUgOPLN0ac9=60E(@BD5TCM6cK5Y13Q
292.H8\L9Q[H,VL&8IR,f7&+POCNXP\f19KBO]Z6VIY+dX05_AVf5E,4<H/WUBe<
Z^e9T8D4cQES5W=K+SQ#L&dL11g>](aZ31UE9@eBN9D7Sb8FMWD9I..J[[X3g&0(
<0&,:K-0)6dY=BQCC2=W-9PIT>T0GC;N>L_/RJSZ@d=E&R#ZaR30eNJ&72^#^?>g
?E)8M\F09(dEC)c+1.FaJc_362dSOYIY\cdJ#E/8_7&X:O_VfU>-27dWSg32/cA1
df#c?@1+[N)]]aeQ(@TeXf/06J1_,3ad^NAQS^\FZ1QeE6fgWXV_4?H>SCKEQceW
[T,FXG];>R]Lg.10CRIA^:A.@==MF9XgQZ<]:5?e._.AS@b7fYRLU,?Z]Q3+[/L/
SebCVN,ZQAZ:gE.(N+8&9]/,B>VH9Q_R:_25Q[4g4P<XaT:WQF:1?<,KfK^J,7L?
g2Mb1P7(Bd1-SD:63^7DYP0]5[RHVL;@6=5AL:D&^>>YR8dE9&;Je;PL#0WRHUJ3
&C./b,^\THS>J\g3^fCIMb8Q8PWTJ/VB+8eN=]Lf(M^8.BbS<:b]D0_8D04)+>a,
RO/2H5ZFJK>XT=9;Tc8-Fa@_P))(gIAXUFLP0H>-;@U@J1,WJA4a>&5gFg(g6F--
?G\H^-):MKGR^5+W(945N)+UJe&dL:G(5KM-T9:/WUEXAUcRZ,Hc:VE8QVVUZP6=
#TU9=G:7J6aKJ^5ARTbRL42X9ecP5RF3TC\;44[f\0(QfGIHCS4Uc4(;(Y&+P=TT
HIZ[6><+fNO=BRYOKQ+#&13J,D.2BF;#LF[&1XO.I3Cc8H=X>_C]/b,:[\KU)f[Z
_E_63EdYW]SWb(<SaI?HcEK5[A:Qf]OB.0F4L6ODf&4;J,VeZ/Tg_HgB1/f:FD<9
>cD[+(R;e^:RVS.QWc6-P)]J/F>HET-O(Q=Y,.-JgG);)Kec8bQ[+HAc6Q0YM&J6
51+:2b9:X6RI.@\J9Q^EbT]&[A,@/6GCCO;<\.4CYX+;@1bJTNJ+6>gfa9Y2M.1I
geDZ3]DaB>[5U6]AL\09#PIA79d5K_O6\1Q+Q:Jg@-DCLOcS=](W7d0Q0=]W(=;/
]ND\J/\J?6gB79A6Sg.CA(Z+>N,<A#bW<cG14^AaX2e2K/K@(d[_EXS32BJMV61&
OSRgM+(8W/ZZLH9.L8?f6_&CID.14+g]:BJZbFgW?Y/)EFK-B=)QW@cWZGS<DM5Z
HJKd=NO6S4@OFT:DR;:d9<@FEUgYE6a.V.Fc/N3\AN1PbTbEf<+-G/K39fa,aCL?
CM9VL7f&L>X](8&)dITYERJCAW0S#IF<0/+8M7cO+d5Mf.PK5^]M/(?cWKF-?((/
ZC5^9T/-)+a/Bg?8R0K/Af-#_GVCc/(S@U/:@[E-+SIfSfg]ZZ4fgECKPBI#Lf@C
c/4].E/?(8\JaAMQ8HF)3Scg\<>HV_UF\30a]T<UAeeX6fC\Q0[8+CeR]I=C:eI>
eH9^:>B26C,M4]:/f)SI6cE&/_(+1[5CEcP+4^I)DAH\&ge1G5)764R3V&/d+,df
,G:-ZV5b9Z8_V<WXW]SP:8)M3cgfP;RLKXA41HW&F==BIOR@RG1X9Z5<1MW+KF/P
^7f64K5^&gLfWZ4/7P<V=Pc[O^.;bVdeO,T@L)5F).@gY(_9XL/eWQTg)C5#GMVb
2C7/Y=N=2PWCFH<K&O@GIO@^[U]a[WZTT?O:XSa(_RQ/57^PGYGH]BJ8+Z>_9WZ-
5T0M&_-7a3,:PbM/07T^cH@L.3;(9bK8;cRbPgB8,UaEH+6&:G#_dBJ5JU=2H@T+
KS@)1T06eXM_I-YeVYH3O=R^5d#F@:NFNN&F0b8TA<4Y9<QIEf^UDfRTML9fc[JM
8#,3E7;+FaH8E?/UD?>L>G/T?A:e);-Veb<-O>fK=@(We->XN&K<YQH[A[KAF8T&
_+V9dC#/gKZLY2UZ[bf>):E?&_Fb&LUL)][3C2FWea9HO<T_3Cd#HBC2P[dV+a#]
XaeD3BE:];;DIG;2gH]DRRc.4KNUNWEX-_J-@PK&=((]gX+EX.D2W);bF;?Q8>=f
Q9d3TgMU>J2@A,G1-I<YgfJg2;/AYEPScA?;Og_LN.3Qb/PbU04MT6bJ(&9<U4WD
86U3-P7fTg,W,U#1=&P4eEK4T1+N-8EPbf@-=,>_9F.LBPe/;0f48T=;\gK5c#/e
faa[)eZOI\7Y?RH6A2E+Ee&dRHfD487,fM5;#cZ9&@_,5UFcCaSe\(DH#dB:g9Xe
9QBDV@8IW2L_<:\::SH6_)CRX8geDT5[aba/W9?:2Sgd,,=Ne51Ee^R:Q+5#::QE
14=8JGI-]>A@/.24/8;.&eU;DG1T[I@AS>QY14EEZ/TKM@K5_S=f-:5EB8A-VDIZ
@[ZMDHbBD/C,/<=&ET9^.IE;2C\D?YNKTUc@gG[:XE\e6K@UZ:GCdb8b\GX9T5\)
LJQ@+Fg;P^YS\I#?32YCVB2/&>9c3NW^&AH^308RI2AWI@0>B\8>QccY8\PO.@W_
aV2AdK71O9+Hf5E/-JZ@_L3?YTBAN-2R3c4gJ(/)ORYH,<Z(,:B\e]b3;LQZU+&T
I4VSc9;]0]Ke36\bU5&9.3C0VH\e\1J3gQTSYYOcOIP07d),XXE6cYf6+G&,M@20
4P2ZH&bB:_G@[@8.5&ZX+YZUbWRWT9LY\YVZIQH4(;&dV<a0PfO4LP8@>)gQM4>L
)O5OK-McOTD)I;B9]YdUU?_R#W9<.<QB?NM5#5^4]BdUVBN75.L#a^=.S&Ae#W^4
=2//LX(37?5J>VXPBf5(dbFC>cV&<5)VHD#?)f\LMHaI#48dV0EaNR#8[I0YFEI/
]5.;Z?::?+e.-I;e>I?M.QLJ[3_>QP1@MOAH//0faOeV]a:FY4&9;BY43]e2/O:G
7:QI)2E]^[QPIXVeaA[fGC??A/W]/2]C8&fFEYJbP7P=U-J(M9;T@-..EI_K]V(V
@.R:IL:]YF5T&[fJB/E7g6\c@)B:.,&H)a=fB)#K7)dYXc<Ib,._;g.76dAX>@91
/53N_@IR@SHR+:8d@6PZ2>+DdU_2<RAQAb,9Z\S.9^++RecPIR>]2HeLIHK7IUYB
/GGN@[:(U_VSZC=SH18I[<#I_]H.;@RD#-Wc#S2.fE^>NJ9-Q.P9/>VfeCf\KdfH
7a[D(<6A@6=F<?\9Ud1,XP=^13V.1Z2e]25;EHFMg:CJQ@\UDZW=@D[dCU@&(b\D
94JYda:PNKNbd+a+5cLE6SKB^c<@Z76O<;OB5D?BZ(4a4:@3a^W\6SGOUB?gM:e/
>RA7+EJS;F(0G4c6Bd0JCN9P2FKHR6XHNaG1)gCJd,ZC0:R4^;]1eg>Q;W3V\7>9
VE;?A)=Dd\=/A/B.W(Ta:.GZ)Te/B_<GYY]JDaV4]d<LZ3cgWT#T0\?92LNOWMM7
#HOJG+_,aBe4>1F6g\),S?0P]832T@7BPW=T5MNJ[L4P+WCF;8O.N4UdK9bSQdfH
C[-dX[0IEd-+_;FAF\>U,X/-f6;VAHA3^d+_RU-9C1EQ=aWOafA+T.7VQD^QK\_K
faf<dVC3?;[a+ZQ;H#A.[=GRK=S=f+/2+NZb79ZO_0gPV[TV(_I0)3=7;+#P:;@R
2PB8<_/cb<d&RcbF)V]J2_T?fFbA?3Y<N+/8N.eJUM-(\HVIH4ODREZK767O9e9A
8ab-=NT3-U&CYRE=0N.4[:DZXb@aTEF>bR@/\)d]b?CZYF)dJZ.I:4-dSK7W&F.+
>4A[NI^FGKe\fM,^BNUQ3\.P>K5Y68<Rf[@8\cS+>?_RDMH(HP#BUd7gUc9UIf^&
d_/aE3)dKC[/gEfQ,g@gfY;)VK13AY76g7C0LTKBT-O_KW_@Ve;LN5Oc7O2]7><T
fP&6DRIL#gE^[RJHY6)?V[9Y[bND8^W>N)&8,YcWg=c6>&A853\YGd.0\@2+38]2
E+)Ug=_AZ&+R<[GQ>K6<4ICaQI16:^<Y-CE7]?dZeUa8_Xa/JK<<QIffU,ZV;5>+
@M9PA6E]Y.:7FA/VbMWeZI0]+Fa1a#BCL3D_QRdJ?>MO)CP+P&;G:OPG:5(QPP=X
#RE3?AD2\Z.?aF@.?V+.^/++1:GG_6ZP,[HU)acc>@7&]G3MN^=Ob5E;Pe5fd_Bb
e^bV.eGgL[IXLU\\^@PXaF;#K#HWNC]3)^.)-N8)1#9Y?_&IF,aO^,C#H-S1/S0&
ZMI<<.d=MDC99-B8/.POJe0UBG_#S:LR>.(Rg:;C-a4D.JS)B9Y3I8-4BTKa=WdU
P_FM<5T=&>g-&La,5(C7M.Mg.1QCKXTfWSAAcc3]9Q_-A\(]><d^Y]<X>YVa&3c>
#7Y[4_5-R^b)cBU)ZdG/V@PTC/T<=f0e>:(C3?WC5g#[WG-E,,#L/0f[A>/70B#:
7JRXD^bf6Mc7VEF01C[f57W51&K19W9B@eV-,f(3^XMN42V,(ZA5HD/Y;]G<d)2@
E>BadaX1cM;G)?]g39J9(QK::<:F1DC\:CgGA+@R92b5Wa^KUD0bS,9@BZ+^<,TN
CK+VK_44)g7]H=YI)M2QUB(7M&;\C8LGYe?P;\_c,NB=X81-G2aW]2F/eQ7TRUBg
^FJS>,/D;,&O)FbB..e_EU<c.+X2[MQ#QB#CcM(HHQKSA1,##2>03AI.X6eC6RP^
WSaJ77KUL(Q>H4cMY(W@B=GB(fWf3WXV6dgDIWYIMP^4>Z)K_XeV#XTdO_/cIVbG
DR9L@(=8C>>+.G:973&@9[FV)MHe=-)BE(##PDTO4d=N6gW>Y2&G/D7&C@ABJ5Ob
;c+L;G8ET[]LUIM:T/2D.\aFTL8?J>I>17a2/N&Gd.>R?([R>:.QNXbQeJ.2]V^F
-/7TgQW.IMX+_1P=L\e@Qd0Eac--f0\HCG^YFFa\]E)9ba7QDO?:E;KM\:.gGVfX
A5-O8(c;cXG).S_62(-0U3]S/N4^-8DCfdD;B7.PJ^JbY7bZ9(,BO5?e5_]X1/W.
KK@RcN(G[R[L1?HBH<S6-Eb^.T\Z(_fE7/7dE+.ME1f@A1F\D>WaDLFEaBC\YM;4
+[9bO=JYF4SU#4@HS9NB1a6e.SQfg(d,=c;0#C#4KLZ_-NOZTMPVTOT7R=1d8K4J
QBAa4H.dU_R;aJX2?NI=X0AK7VL#\[4DT2CJUe1B13[eKOENA6-\JaMgVAab+8=\
b6Gec5?[(J,3^HTG/]V[[;ZNJ)^+94H\;b2XJL1:Gg9#O>N)F5Dfe_6FL0DYHR0&
3PGF4+3QB:M4Y5KcINaZMG9FQ0J6Hc>B_dDBRVM[10?P/FR9aZ]0@<86636SSM7X
G3T_27DO24C;e4./@[;JeN#^1,K[4S7XFLM4_FHc<8&P6gO>415YDD1Y72S1CNEC
.bCMJM@0HHNP,3+EG>3]7@X2?S+WH,b_E_be.#=7+[#)g(OB^&_eD0ZV/U[)>W>Q
g;SXC>ScPCNaT.KX/Pe;XVXTKEEP+T;ZXf;O)5,M66PR\I1/JT?Xa>97N^dAX]JK
\/HE97g^_]KJ69X[W9_edF57)ID?7?bf,Z1\35TBd1^MPU-NW19@L_W,gGcg):YM
&I6^+6<e;;QSc[#=ZR40B[1dd&DK0DD=V@NX,1,_6D^eMJ/]^8b:[R,aH^[H5D8T
)BSQF9)3J<A52L+De37DQa@BU>;0.,P9J.&Z?Ud2,@>]2A95=&@JV-Df?7@T9Y@+
:;<[-3/\I[_MM0-\46AFH7]N.5F2bGUU<1?:[We;##a11WVaZ4->;ANGCPd/5BX-
?A^FFJ/eAGF7A/YV>EOEB?fZPU;F8++(<<+3b+aAI(/1^_=f:)9R2L1_F++d?d>#
A?L]aNK,>-2,N9)KYa0])AeB2[W#1d@;>cJZ(29Z#Fg8>cJ+[)//4K/FV\]9b8N8
?e/[R0g,03MR9=LJ=G&EU6#d]@F\c^&;^5cP8aP_81/DYS[:4L&(=fHe&X-6LEI>
&.H]C6R7?S=)G?4ZFL>R@f6P?.bLHRJ_1T#7J?YYbEO2&cFT5VO=VO@HCKUP7;XG
4WT7+QD<D)WAA\TL^@b3Y/D=bZ\9g)+]&J3>D9B\1/-f1+XYN_[RS;N=(4QS9F&d
@YeTBLQbU1;;P.>b]+&BA9?aeKBBQ;2I6f+@H<_?BU7]/;68Idc(+,E9g=cFT;K=
\WM1P43#b4R3_?EFWIB(_+L.<S<(9/P9\OD,/PfO)[?Q3CRegHdI2P1H_;4X5>@g
]S2Q(G:(?6R2Z0F#8ZM+:O9/^NQAK\&6EDBCYKKPJLIXb1ccP2SaY(H4[8GU;=DP
4Rf6A0?2C#/fbcD3R,eVM#J]CS0.R8:UcRZ1g16HDE22/)?fXL2/-7&Z)d<\^fRY
;A/^4EXMLM+M;ICO@gH0,H79#E@?B>B(cYL@#W<>?8K4)e^OFDDG<C=^aSc+.-;2
,WI,?AJbSeBZKN0#C\7;K<57=<5Y9J+D)CJ&<P(9>4#\+^b&N,7USF6KOI/c1S;1
L6-C7CEd88E?cVWR003--/4a^7bO.M)R<G-eH/>5PGMcI>+bUW&-Ig-C].YOc3:6
R[/.+Z73+=FEfP1aMTe(GVfX2YSC?09Z@\GFQATWSY2ebSOC=NW=,.dR?ba<WL=N
fPX7(1WHN/;5U?&&[_:fOY(c..&8\+^^F2\D5IMHZBOM;>9A>(L:J<Nd<>\Q/.>a
6H0I-<-,+V3FX04M<<-aJH8?Y+F;6<_g607HWE4/_L\JWR_1G#^b9R])8#f5JJMY
,?.C+/YH1HF?HH315c(P;;cP/^FP)/>bV0@a:#<R3,N?X\\L(8gR[KL:=/TQP\R?
R+.YgR3cH>Q[cJ><(e#.L+)7>.=1&+J9IA37R?F\:2V_<LKOcfdLB<b\QH>,_CZ+
\&XT#?A37d6+f#+50c_aTV3JcOL\+);J8(@Ea)RM4DP:fbYWHCTWd=Q#(2I7b04)
-X>17>1>,3#[N+A)dKM[G+VXDFDe06fd6#TC1?W>W8./a#UHS)VGKFEZ2d>]>#Rb
-5C7R=bF-Ra,#FVOM_N7/E8ADYgB@YDG_N0)&II?1@;0^7&&EbW666-+0]4VCC[9
HXK]/.BZAFNM5G(26J>PTFZMH,Ff)S;TQ:JU9Z3UMbD9Q=A^3D[9X8JaG5OOK.=]
DB>P=/bQIb7gRaTYZO<J<R<WRV3<GgP<H6bX^I\+@]_Ee,g3L=cH=<@T\E5^:a37
AK@fGM[SCO8AM5cEV-O+&O0YX582V2@0YO_?77J(6>7^^IUU.Q=T)WB_(:2DF\g\
MFaaG>LcIKSc0TOZ)6_KU#N>O/AIF?;5GQX#71LY77N3/OSI+8I4:V2__0f]CgZb
3+7-d[\VNc9T=KVWSHgGQ9?IU9fH:g^NX5_SaC>Qc2\]6adMLVFA>A<AK)Aa/L=U
K34-:R8aQ^H+572@I6-G2IW==.a/>dIL^f1RHEW5d6aGV7/,bK_UM&I,K(VC&8D?
aET]\HJ?;0A,KOZefF>d6H<=4X@:5ZW<?b/LEZc(&T4Q]>Q>Ye,#\3G(5+F5_3aJ
?H7,JGVg=c1(/AQ39HD=PO(NgHA/E<GPR9+?4PDR&V0cOOP?CabQ&T)M6I(cfW:2
O_f80#2^BcZ@)_X-e@>L&7L2@6Bca?Pe09@DAD2]dg6K:3ZSaCGLEO0DD0^#f3A5
4#.BZR2=94/(=8_5J//+Z5G3^HO=dT@fdO--D:,4F.2@I-=0a-P\E9NeJPUF[B5^
?ZVL0X?BW,K-FbNXKB=KG3OKFf0dfCEb>;.R@O\_WFIe?&H37RC;3YS&1@NVd&>3
VZ=X<:FY)P/G3A9;/KdfPIDE7/7J4f&I99gUW#+a,C(RcQa&0U>RHG_4(RY7-.PB
,-#C->+8?FN)@0NG[Yeb0V,<(CYT-73EQ;aaL.1Fe=?BHM;c,[6MbD;@<g/(HTZ-
b68]JM(Tg5D<(U@:^2Z@T?/))DHP=H<K8@D3\>^Xe@KcX8F>G]BVVf?:^KK3?I>4
)I)R>0&3X_&OZ1BDS/5WD#OOK:cf^KUc[66d+I:Ig/HM4EO/CIXOd-6RO^\^;(2O
;9C+gcQ#QS)S+f9)\+EA9)=?WY0g>ESB-1].VeBTH+f<&WA8#WJ9@[QbT7&-I+S4
?JHeb<4e@B+Xb0MG5WV_Be;W>,QYJ&5[8JE1C]MB1/\P)VM3U&;gbfP4U/.]0+c9
DYMAUCcELW)E]H3bC&ELb&?7)R^.F?2S1N\T>X&BV=F8EX9@#J[QRLY&1@UT_bJ:
F-?#;GEC8&#_=WTJO<3WN6W_-SW&D5[EZaX25.&;.aBg,9LLR9e6<Q^)TF(<EdWF
>?)ccdAF+P+([6#;fe_ID_LA20CgW.@^cf]0@@YY_[]Q7V7#b8PC=N+_@;N=OK&<
\8D-=GT7V(bCT/>KDXedM=]06<OX>MA\LP0?LRWb6I&g\_>OR5TV/#G:;6DL.X^1
2MOCDe2@)d[XI(:?.CA?(<L_VZ:5WWT6Q?9HEO#KLd0<Sa^d^F)&NcG//+(HI)_7
^JD48IU(c4AY:OA?9KeKJI-0Q48(;@:5/W]FB@0;CcF\;SO&VaSIX?.[>_ZeP^9+
9Q=baC94B+X1&##SB;W8Abf.@dFD5)\f:0M:_IGDR,I)ZFV=DFQg+(OJ;XdA&[DS
Sg&6;\W_0>)>HI[VD9N9]fK[a\?:V]O??O-@]8>-XX6OJ>]908#X.U)(eQ3-J.OK
6P>Y\6c1f/-:fg31L0^GfVN#/+T&##8)c^X2/O):cg.+PU)MS<-\c0ZPNZ815/#6
c.5PFbaY\]:/OYb06/CX#FF]Z37NM3>Qb1g7W=#F?:<g[gFPDQ^D,0H[7Re5\TLP
4H^\8#[#6Gfa;eM_>NgV1KeQLH8=8WLVcC0f:#6AJ#=WZXF.J.6Y?)6\3CILaW-D
gWDEeI?.R:08a^LN)\@P\HAg<a\gA75f&>P+d,3Cg=G(5fUY9f^NAGgM[FVRT)J2
;4+T0gI:;MO/Taa.Qf:,^N?]5#J2\<^TES&I;_BHfGV#UbX)P>WR3+XWB+0N&=ec
H&UJ6c21c:ZMfb,LfRaBHKVO4T35+1P491,NN<.Ue((57_BA/:9<]+-g).<KUA)&
VJ-:#(VXe^+X59I8fc,JLJ\B>.@K\4-D4,>9&gFRW>7BV\=.W4C.0[Yf[c>f@fRY
WcRCWJ:NDD2(VNg<,J/>#39cK=0?gT;Fcce?)M]EW6=fb)X?GVUJYe)54If+A=VO
/DH4,@-d^VT0LdEM30O&(7dF>d,KHHPXB-=<V4X3?T8VK#K]_>]#Q@)H>E.F(39[
YGf.9/Z6DPI_7=T=^]HPCFH3#@b;CbM&2._XM;A>;RgIf07]K#3-R?Wba@[O=MNQ
DEM?>.99#^=Od^UeZTg44LC:P\7BUQf=T^&7((+aXc[YQPA#SQ<ZK0K<?:M]^70?
_05N9Pg3eX\I+4U8X.T25JK3S6DJ,XD+OB2G&V;V@R/>KRV2d[FR=LLfJR0Ye=Y[
7W<[_\4#,.3\;N@D=AeRXVC#BgS[V9GN[A=0A9/Dg4SJSA5#O/W6Jc;N,G+(_7^O
F9b/Vf<e63+3dNOf1+G9c/\#8L.cBDg..P/b,:2@>f[[)-0b^YbP#^c@5&[ONX7e
E5.6+XAFH[N@aJW^g>#7=S[I1KL(ISJ,@7Kg=\SgL&eU/WK)GbYDV#B(UgOe).WR
=d4;66Qg8/2HX5SHYNgNKU04<IVD86?gYOWdIFf2+SdYaW,L/N@D8@RLf;E;OACW
Y#S;C=+G)6[J6M:T91@E8UR7D.4MAYU?HgN[+8,WO@g8&V4c&4c7WBON;_]08NH5
G]10,N9g&VbQ#[2gWE6;fBE_#^HLHaJW7)M+TUL5EW033gV/JRHU2I<d>L2B_00O
6DV6,F:bgC[=LNZg[7AP3+7:@1)T;M+)2+/@TK-CR\\C,b5VRH5T48;)fT^a=)^Z
<N[O@A/CWOO=MP1c451&@[2A+RcVJ5a;<?.X7Je^]FW[4R1IeHe<2T;Q:E<EU5PO
F=g7aUXSAAF/1d](aaEe;9.C/-3OVU-/?TfTTA3O_=:8;4gDS.ae(#<+d,c=VBBU
3Y_FC-U[EUJZLS;@)+I[Xd.ICA]B=W)#:V;e^NWgff^OE\GbB:cKOYf.c,deQ&.M
Y_2,+afCKV#5P]H&M/BKB+6gOC=T@WF3_7PXb<aG8O@7_;YE-,/#d7VG,Fe;X82G
25X2QfL^,4#FWT#KBL12:0VT/L&Q3+B^QY]L;RfXLUdBP-H_WJXK7KV^Te840361
Ub6L#A&RF;6bC<\56C52K7f;VQ&QFVDG(R#[8\#?K^WgPaO-?<<cYa+We_78S-e/
gCOb+PLP;G#Z>Q@Z-BH97gZ\E.+)W#20=7YMU&SH@A;[Q>>2We,dR6JaI^XBB[3S
<=Z^V\>cL.c-dC;>Z,c:U-.Pb6))g,;2527\+4:G@/.2S)3N0O6OZc<P[2Y_Je(U
;/;]fN-5CU0Da/JB<,0+X4.&ea-\-CbQ/YPV5:bQ+aD\TX&CB?L#AHALJ00G>94a
OWfd-O/.-UJ2D3FN)Me[1cCPYK.bKOED228Zca]E7E1^Lc=O0.c]P?<XC8/^5YW)
Y];Y64(A-?HOe3]YI)W^&ZQc4\H09<T(X?UEEBcM?4AT7L\^EcB&1U[aVO-H6:WP
+J?,9D.EYOQcf>3M=V2-4SGcf(P&00W/2]3V9e^-0:6K?S=W=L#&d8HQ-dFZ-D;@
^P<U2J^;S_CB\A-]5,^WGe5^Dacf/0S2Z7^:>GM9702H(3Z1&A8KMKN=f<9U9gQ@
-(@cdGU,<_F&PcOB;4Hb0]X]:M6OS7_g,75dBaf7e\.,#HaF\Q>=2dUG]dbd&]e9
O5CT8QTX-NH=c-[e5-FfF22[<:^AK3+[c8K[KI((WOCOTe>453X9#FWJ<K65)N1)
M998LbG5//V3d7?_/S8[KY8I,fII4LZ_&Z)/>1eZ\;<31^&bF(5KHQ&&22W-ALKe
;V1T[XQ7TTN?5bVMc2YW]Y&0[Q5SUf:>H@/R]cIH6f^//5XJOWg<>]LYS(RH_U#3
M\VZ06I8>U>I(>/bW4D>[EG(+]R:GUa+1^2)X7g-HXaHcW0//AMR45<Z[ea&[AHA
@#(a&VFIBM_V\a/Y.9S8-HRce0S1^G6.49=Z&J_O.#EDHf\UQ^e3d#=CRBAZ=0E(
?NK5Nb0]&5fJ3M5Df\O:C[@9M#(#<Dd6-gd4<[g]EbIAU2E_g-dc^<RQG)D,[&fE
>RQU2N4#WSYY29[:N<SMYBd0aSCMBIUQf_19)SDI0-\/R27ZM0?[.](E+X@D4,ee
@f1M(_7I3QD]R+d(TdQF1JV6C+gOG279ZZ._2P[PD(BFX4)a2@(?R-FZT@,XZSJ^
9DQG-@3)cJ6N4?TggfP\Y?b1#O&GI)7^;Za5?b0gaA>J7LbH&eLMDNFL.I>^B?>d
=A2B:g,fZ]PA\M73RC&/1/a,[[5dFGfBDT\;5JL4H0f90^1>Ta?(FBeZGY45AM]@
d,K;P(H5c_EJK0@D)e-Z@T_I,+0J;+2Ae9b<I6[XBZD<JWGV#6O24A0A,NFC006)
_<[P,#WO;TB[9=+:bCI^OO:PbXUW<E/Va1WPIT0E4SBF[JVcM)S]RK0-c5.+QVIH
6GPKcc)HFbL>)M-Cg^NDK@[\e9]U)=8eF/M&TG:[NacL;D:JI>;b/3b^30EQ(.?_
?QR\I38[7R^,c.0,EQg6bA+:OY@4HM.G)NdEVN1UVcZ.P[Of?A7ML2;f?]7ITEf:
\-H5aWe1#fA8PRWbK-c,gF:(,6S[_:;EK2(4L3T>^VMYJdJ(+V?&5DK[.RG:4#eD
.2PG6Y==Gca/fX?-eOEQRWaP4.^&\E)4Ef>>;bTG]g1_AC.af1Q9>/KR&2\NeX5G
2a,\VR&A2R^[TM<:^XHYFZD(4Y>RDTQ2e1P@NZ41gGUQ/_b1KcA3gREaQU65V\^.
-Na4.E=16(UE^R2MbN@QOB63df4U0T2C1UX?G2FAECCA#=0[S31>E7Gf325Xb;B2
<6c+(68(;W3/A46cbF]\YS86YL^&I\fFN7B[M]1MS^0]KS8/2N4[LSO6JSd;9bE[
/1M^@((DK5e;Ge,-7#P(#bTI,MbBUI?b\A?P8+a5GcUgMW:)U#b.#B9eeK2:0KK-
EQUdXMX.H#5@0,aB<NXKgZ=a#+N\Y4MW(,=QM_[WPeD>Ta/,@7KV>JL:f(.aEL?6
MWA)==Sf#\AL>1X?cc9Ub<_AF[8QJXf8cV7D&:8ggV,DZLBBe5^fa\Eb(eDa,J^E
0CI3B.@;?G\NL:J\2>^D&U:J1M[IOFBLgB0CeVLUZ(2DJT/ZH0-ZD<M8A3X5AH9Z
&Y^HK910>=^NB=A7gV9RVM+=F#(PdW>P?K=aU(7,DMRM9X/NOaSC[ee8Ec)bY&21
_OD=ba2(V2^-e./=^>Be=L)^,U+C[SXI,VEJfC?LH<.K]d^Q4^Yf7#9dZR9S:O)T
PTRY&B)F#T@MfIYd5b&cf^1DWc>:g:\8Z8#O:TEG]VVOTW?cPW06QFf?O.WT]U,S
E612+]OR-(O9PVF>DX8RMP&50^<POOaZVIR[54VL0KU<C=)U[8TY9E&I);?P79GS
8VH>c9_PFIF\<<0b7DeK(W7VI@]CGD@W[VdJYGS9f;TeZ^[.AM-\26##cf/fLMc9
cDZF@S:/+5(Hf9;SC5ZHV+PT)bZ-gFd_f:R2d7cR\8+,K0Ie?L]c^N9H?UIZJ)V_
35<I-&TB.3Y=bX=M#MKTS?c;?gMe;#[D@b<]=0=)C.-;#IK(eYb]M]-#0K,D]0.V
C1WW^Q<0+BP=64[=:6Qc87F_a-8BX[OS<UD:=H=N-N4_J^2W:(EP<Gd>KFf>HTSM
I:_(Bb;BXT#c,&;0QFV[K:dEO:Mc)ZM.EO<CfMSS;2[a.0D0b+5af][gR6DM6E7)
FJeF-;Pbd82>M2A[d-F\#L23OM;f?J]JB5fETX:./a6a?3+f_YfWa^eAB/b0e#3c
Y9W_bL1@3/P-C_6S)1F?O#UJ\Re8L1:VRe;G_aR>V/X4)H3HN1#BZ8I6IR^Z^LMO
#c&P/R:G2XXITW&0g-8C]G)?#RA1M/Ib(KC<gL]Ye+(UF@HH]:cZOE]VZ8VE;?FR
B)E6U:fGdM_.C]Q4d8V,[M^(?dQR&/NY:9CA@Z?XU\VI>_]XCLR717]N=RV+4518
)beX]eHL4D#W=>Ee-Bb??CJK,2I@FY:BGgOc\?K<IFIVZ1]c.(Z__Z>4TMA>2@WJ
OCP?Q&a@d)GK=S(K&1UT^-=Q<2#SS=eR&B0B:O0QT=Z,684<J\f8#7&OI2R[+X.:
XEW/&./5VJ)UbC+0UT1=^73O9^^NQNfYIB)70HNK&&5BH(NW,VbB4OMBBC^,T=NH
R3PeF;WZQLP.;_2-A3T]=\D+]WV2DdC7C(V@QaCA7GD/P_eOf=Ya_EFPVV?M\Da_
_<Ca3FQ&bRKRcNaU9g\U2d0.B=CNf+7PX^RT)_?/G,^gN)Vc)P7\JLZB01/N;Jf)
aQO99JN++#AYIP0^L[=X1U)SeF:WPPZ-594AI-J9a\g)#>7KBV4M[L65\.;4)6X;
ZYGDK[A,+QdSN]=EdJM&\E-Ef0;TeMg>GTVD&1CdLT>[TgFMfV.GD\?(=&2VM8T?
@bM<73L=UT_;L+EW-SgSdFQg8&/a57N0dC3e,d#5S.OYBaC65gBG+^5/^W1+7M7O
NP^\=fK:<>IR+1XQNf5F>&<YgC+IReW9ggI?WC3.=L@6YE6=IG[8.e\0-2TG0b-I
d+#_&IE39,SM?EOd+C)]=63gA4DRG;FZ;>#=@Q0b6;Uc=_NQCgHH\IE_O_U1RaWg
(O<5LL9HPO>d\;E^Wd#[+/L^2c,-fcAT/<Sa]?N(H3:>P)_1)fb75G;Z):J76X)B
<FX?\/U-KJ4d6YP@--,/)PaD3_XV@A^bK?^-ZH0G9U^>#VO>+OIUSQ1LgMATdVYU
^\;1gfFRCRMCT[gOg)4Lg;N^deH-NVRZ+bH;?5EW6W5F7&[JEc9<J<D=1:EE@S\\
^FH#Q]cY/7\Jf@V@D^eS)&A0;WFGJGF^W:ERB6Sa5@VU+Z.25N\WNIR+Nf_\JaN-
@gB?GZ#HTK8O[=@F01GO;H4:X:U9@QRP&0>O2PP5Wc:[X@S6(WVCT&-EHCH3Xa_0
W1#>>B&aT/^Cd/OO&fU4fAKMf0d6OA+XdVZSV[T(W_OYBge)f2;CC]]G8KVBEH#2
Z)8RH[+9@&\5G(339^GL^+ALRf(+fH(Q(@AJAf(f5XQ]E.H?OY1ZA2(TYOdN>fML
3:+aUBE29eIMEf2OLTQYL3gGD>[,dB9O2^\J0:^8PSFS?.GWc;.^(N<2^.HEKD,d
&#7?[ZAE9-U:CA_K<EGH[3H>e\>OKe<R^<&DAVYbAF2aGMefO+6R2Fb6J-ee4f@R
=D4.JQT]6+5@:MQ-EN)afXZ0.W=\=@bQW_^L>M9[8f:2IN76bIT,bSIU<JSX266@
bYge,IH>R;??7DU0....-N-eM@e&6Va5c1VJ3;<Z&^@LQQN(FJ3(Y9O00.S6.KW,
,;Cd<Z\FFKd29/YDZ(GFL,//E@C)AT0__E^ffK_@J/Z?RKfeK=2bW,I&-DG->:?E
CYUG&MW#Z.&MFXNPTMP+WH(D1[>HFYdU31Zb(>9:?9:d^]QdDe-/.)5JDceXKIEU
6Y4AO.W_._F(O1V^;0A8.S]4bWNC]VG)[/RS=KeQM]X=5E=Y.c@cBV4P0g5+7(9c
K=M#e3_T=5FA.g^Pb?XQX97UG)H-&?3]S4f\a1BVVJ?[+e.e&.D)[[VS:WTM#:G=
0BLd<3gOSC51L\Fa0.&47_1=fT>>9P8cLR0agPa1FNc;Ra=:[B=;WW7]#.9S=YV.
<^/Td&[/1Q4@V+/gc=T6eG)T1MK&Z[M5\./ef.N=/CKI)]QZY5Z(I]=I?Yd0D.O8
35:XJb6N&KB>(94&4TC=#9Q7\9CT,/:\gVR3+Ua1+<C?S(f);2dG)DQ>:2+Hd5Se
/eHPUbZ-b9bG(LgF:BKC6\(dc1PSJU8eY\:S&\+VP&@_VSHf_Zg3Jd(G]UB?^Ke,
4UH:H9P^:B#I9\DbJ)/:?+Q_LUXE\@P;-E:N-:c&d=M(a[TNAJ=N6IGHVQ)dKBC&
J+,9I]FH/@7S<c:/P62FKUa^\P-^.L],2W^Z-QG?X7fg^-f@JbK;0;Y,L&9cO[>D
@U_E4[BISXM^K9^Oc5>4c3OZ,>b;(IVYUNZ&QY(b#E6P[g]gE;c&(+Z5L^-/)E43
T2<I:I[NP9,+dT7Bf5Nc<50G0EcEVg-Yb:S32W-OcDEZ\K4]0G_gbX#XVUZ9LIgM
Feb3a2#J@/F>:@C(C;2T=U[1[[56AL\\4K95gM9NdUJ-Ca1S#GPD<<e\W=?]WLM-
AX]]dcLcGSNeC&4:C>bPW.-&+[8K6g(TfTW,2C9K01C_LD\Y[)\(3cUS1U3Hb:Ic
0(/7XdM(_bW]d/W<R\@XZeI]+DIFY5W>YA(H=[[#&PWZ@Yf=df<fX3/aU2P7C7NR
a6\ONCS\73-[^g4EMG4bSP10D)G?a;=JBH<M/gVU0JXT(<6Z^=>.Z#+?@J.TN8_0
TQT@7Gc@,@bPM6P?J>JNA+&C&Q1d1/[Z[=7fAAWL?IDNAGH6XF2((,_(&3^#Y0DO
3I/-?CY/KI9+9LbN2/UdQQ;N?T[T.\@(W-5T^R)AYaXg0Z7GCfaEV_Q+(S]N.??I
K-gY/eaSe9VbTa4c1TB61)c0.b+I@ON\SVfM9/NJ:Z^XYJ^?OIBf/WS^-\(,HX<b
M@g^79d+H@2XD=NHN<UfcSKY-=E)&dEC5/<==Rg3;c\H\bQfaM+1ecNO2H(L>fCR
;FK6bL2)Q>P)Y^6=0A5JH<9.eKT0E(16QV\^OC@)RA8DE:G=XH0^)0b8LRMd3TaS
DQN,@H5EG[):+>+&YW7D0_KRQ/NF:>cQN#dBL2/2++I]OR(_e9DYc+5[\=6[+V[T
BQ>Z>AgB:-P6L]JS6bg?/UbC_9V(CQbQNEB]gZf+PJ^dJX91S\9@CN.2QN1);(NB
>R)FTW>V@@VB<G2R)L,_\V</B(YPU[5#G3aT0CY3b0993);Q),,T8@;d_aM\#<.V
d9egNWYX9]c(O15Y;B.Q?Xb(.9K[cN>&,VWg/R9aU=V#JKgF#:W7=HL1>EV2;1,T
PGQ9YIbF:2H>81+WQ;AAgD0)F#C@=#g#TQZCQVAC7Z3]T-]]2TAFHeEeYA5bQfB4
5+)PXS:B+9AP?7/(faZO>YDbV6GbBQaDN;eG1--;M-HI)DEBY1X+C9NSbA_b:CR(
3b8K[D.[O#eO+)KSgL3>T9B:GRSB##Pe=/+H:)<b:TG=ROe.;3K28_c0/S^PVRJH
(0bQ#VEB[H@[K:-3O::^+WA_3bA3/TBIF&^/K[L3)>bPZL3(6<09\V,[[37gUE&^
(#bQ)a++2^&_5-6:aES-3EdU8HQRD5/0TI23V=@N[_R<YYTV64#ANG^-/Xc,)a2c
A4^8>B\&,Ca6,>Yb2&UN,/)N=W\;P2[-G:FS5OE:CR=TDU>FJU6(fC_@BM@dA,0I
@-cK[WJ:/)BeC?7__b?XRRa)YD=^#1>ATI7SY\HG(GRQcDff+MF9-<&PMV5#+BgX
J:\)1B:AZVRa9T/e.]Y)2a:F,6=I8HaEHM(5AGYcBY\OBW6:eLDd6L<+(N]]Cfe[
Ld31b;7E6C#EX;/PdV?93#e^(6cS#LB3VbKXGdQf;@]F.@\[_YLH,E\C=H].RC2I
<^QP3aQ:+33OAL_;Y7ca]CKBAJ/gWVR&:dW-=E>R.OWQRP)_OZMg8=5MR>CPgQMb
YZI1/MMg0AI.Ab)MN=LS12eH=deT0\Y7+4YR:^KC1K420)9#V<IBXaX)]\bIG^V#
^8CTNFG\PE:c?=c4XVH/2HB6:L7_(L)aU2BTYL6]4)SaD)4&C4ZL3e3Y6N,..?be
HVA&Nc58FM/284Vg]aY^b6S:@?^OMGF5R)#N0[I292LDKged/J,>;b)F+C&75MRB
#&:GUS0eA\NS0f:Q-MFD,<>--AE&M\_EXR[+7]H8eQ6RK3F5TF.>UXcO8SS)GBYg
?FOQG0EI\&.DXTcM:Xc,Z/HaQP<@VTaCO)1\1\.[O[da7J&WGM#3+fQH^GX3D>I;
d6;9afCRU&@JC7NLBLNVOK7218D--4(F2>SR)gJa(R?1PXNf/C,4\eO\RZ6MHHfU
_YQ(,IWV;.]6DEcYURQYO->M.@=<_4-M^O2Z6HX-\O7<5OUT7KNdRD@-VM((JTQS
dA]_4J\ZR=G<EgLPHfA\S^KV=C&TIf?>Ue18\<PVP^>(B,XLJd?D2.@P/Za;EgF+
[7UVME+&)N3B33GW<57CF.H^aX=GdE5aD<\G/IYZ>a2]T;BO+Z2U@FA,B:Z89K?I
U.-+g;GcKOZ(B9<(I5)MJ]-G>Ce2P&<bc=CKGfgLVM;J[M6)bHF0bb+79BA:<31d
T)[^6Z>4F[5B_^(-;)b-Z<ff3V[0+VGMG9LL?P)F[c,efFV#RKa?L.91/W>cAN7=
DeY/S2JM^L+&LXYF<KG@N9<918^K[Na&+gIAD2B+FH16VA1fT1WCG;P.:8AX\UY@
35\6WM;\4J2aQ>Y,<2@.[&Q_.W0#KNU)[JVZcY.bP>S]9_4^W\=.<@=8,ZWY:e_g
_2=/4,3Fa0a^Y#HLb,AABDDW6A/#,>=A/DD4KOEVc^UC)M1S_65.2Wf@=)286DQM
2TII>:2fDCTOc(>Y+e&7AWDS@\/<6^aQ=E(M_<8^6PO_N21e@55_?V^FDbW_.;MK
E,I<G/,6OE0d0dd@[H3BOF/1E-4:0Q-UP0+gU:9:.^B29Ab:=]),2,FgS[J1<SC]
DT6.KB8H<0V:MQ7=&CI11d/KNeKVZ79N_C[QT)gU0EIW_7GeMfM1f[[-B=^/N689
=7RI17.K)UZ4\YL^;CEecZ<]EfG03O14):@W-180F2/4D6#YN4&PNIA8E,UIV[ae
N;/OG:7F=Wa1RM6?bF,J(eIa;KXRa7(QL3(=())QMO-6JA.d-B24\XP,<Qb0&.b<
KDT@^<8#._aFF@f)#]IGM)1XcHJ&;#K::]#&U[)2[27SKAQ8G:BY;EB4d8HdB+CE
(7/G<=<;FS1NRc?7[6#AT=?US5N])LLVd=P3g.D=V<A_8D7=@DcDEJWeLIb<aK6+
EW<f5HNKRN0aabM3/@<dJCZ<8cSc^;DR\A/?CCY<Xa133Z70&V-RP2Tgc#-3e-Y[
[76C3#-gU<O\VG)dMH46[QCLR?G\Y8HAgaCbc1aB.UaFG@S8OX.aGX@=g2GL&OGJ
,PV\0f8\5-e#CC=#9ON/II8&(?dSOaaLA2.-(E_S?>O7)\Y,c=E?#B(?<1<X.Y.b
[2/@=79NCd9a77<Gc/#XPCZ(]8CK)?]J#/^UTfb_O=?-SA=-V7d/<RG?@8NB:/,D
MSHO^AFab[\&:V42=UWM622D-#/I,dFRER\S.XQ/<M33HU=6#eE(YBXZBX/V,),:
402]OSW]Q/MG<XU@H;;Bc.Uf63S=I9B(^BK)8\S5C[(dT.>&DTBU?&,EID_Udd0Q
H>I)(Ne6+>8_L0K)[4,K<+3\-(fUF81V\G+I?S(3]0MNRA#,[S2g0LE0)d.^^3@&
-0d)^]C?^W8P>IV=AG-]L.7,?F2G/Af?a@?e)(N<)4&O84#g@]Gf_[Ta:X\9a6\X
D]@(9b,,:@[AeQ32;M=^Y)aS\2SA[V2VO\bV88WSM;GZBHE&]3)J_BXL=)]F5[g;
@TVZZD?6=-T6,e(&MWWJCDNKK6Z6L84.8H&b-b4&(cG8;Bb=<BVA,18P6G06>7YS
(??KSRWC770=TWa;3e@5FfZA[@Jd65V^>J=/)A>NRQI+&OP;__>A,D@cF?d4WJ7^
,GC-M)V3R/A#SAQ,56ZB16MC>FF^BRPU-LJ0HN;7/3X&Kb7?CKFX;e&YFb)_gS&+
JX3J140?(#62;L+^>C1+9_6]]Z/0NZH)DRUAUdR0d7d]P9@FRc..;2>Y7^c#L?B3
-V]-F#I<D.@:Tg(1TOQCT/@WW4B3YIgJ4=I&d#eGY(2C&5K611/A&gf4NOX99d0K
>+LT5QDITEgfeR++=)<R-.1C2)0@&)(VSOH/MPTB^A^]&#;9R<SW)g<4^15EANg>
61TNH=[eJ[CECfGD8X?S4+,81P@2)1VG)G7>LIJ]QVT>UeC4ZRRP;;O>R<RW19L#
S;4YO?XUXf^3P&PeeJ&XXDW+7cO^&#?6544WC]c06>:5I33I?KNT^XVKZ/[E[J?Y
0Q-3^P:g[Vbg)+3+eb/XcI93ZgAb;D=X-\=:gGgcXd6_0CSfKNQfDG8LTU(T>Z#S
b5;9?4_L_g)\V48H9YT-,+[&]^dRF^812+XEQ8K.3^XNDa(?[53(#&<,8]:Nac2R
8b_-?7dL?C]\/$
`endprotected


`endif // GUARD_SVT_CHI_HN_STATUS_SV

