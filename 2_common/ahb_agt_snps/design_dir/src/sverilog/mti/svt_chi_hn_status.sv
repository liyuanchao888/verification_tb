//--------------------------------------------------------------------------
// COPYRIGHT (C) 2015-2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_HN_STATUS_SV
`define GUARD_SVT_CHI_HN_STATUS_SV
typedef class svt_chi_system_status;
  
// =============================================================================
/**
 *  This is the CHI VIP HN status class that tracks different transaction counters/metrics
 *  from a given HN perspective.
 */
class svt_chi_hn_status extends svt_status;

  /**
   @grouphdr chi_hn_status_hn_info HN details
   This group contains attributes, methods related to HN details.
   */
 
  /**
   @grouphdr chi_hn_status_retry_rate_throughput_perf_metrics Retry Rate Throughput metrics
   This group contains attributes, methods related to Retry rate related throughput metrics.
  */

   /**
   @grouphdr chi_hn_status_bw_throughput_perf_metrics Bandwidth Throughput metrics
   This group contains attributes, methods related to bandwidth related throughput metrics.
  */

  /**
   @grouphdr chi_hn_status_qos_throughput_perf_metrics QoS Throughput metrics
   This group contains attributes, methods related to QoS related throughput metrics.
  */
  /**
   @grouphdr chi_hn_status_throughput_perf_metrics Throughput metrics
   This group contains attributes, methods related to Throughput metrics.
  */

  
  /**
   @grouphdr chi_hn_status_latency_perf_metrics Latency related metrics
   This group contains attributes, methods related to Latency related metrics.
  */

  /** 
   @grouphdr address_based_flushing Address based flushing related parameters
   This group contains all the attributes, methods related to address based flushing.
   */

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  /**
   * This enum type is defined to measure L3 metrics for the transactions received
   * from RNs at a given HN-F. <br>
   * Following is the algorithm used for a given transaction:
   * 
   * - By default l3_access_type = L3_ACCESS_NA
   * - If L3 access is applicable and slave transaction association is applicable
   *   - Update: l3_access_type value = L3_ACCESS
   *   - For ReadNoSnp, WriteNoSnp, WriteBack, WriteClean and WriteEvict transactions
   *     - If memory is accessed
   *       - Update: l3_access_type = L3_MISS
   *       .
   *     - Else
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   - For ReadOnce transaction
   *     - If memory is accessed OR snoops are generated before responding to initiating RN
   *       - Update: l3_access_type  = L3_MISS
   *       .
   *     - If memory is not accessed AND no snoops are generated before responding to initiating RN
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   - For ReadUnique and WriteUnique transactions
   *     - If snoops are generated and snoops responses include the data before responding to initiating RN OR memory is accessed
   *       - Update: l3_access_type  = L3_MISS
   *       .
   *     - If (snoops are generated and snoops responses doesn't include the data before responding to initiating RN OR no snoops are generated before responding to initiating RN) AND memory is not accessed
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   - For ReadClean and ReadShared transactions
   *     - If snoops are generated and snoop responsed with data OR memory is accessed
   *       - Update: l3_access_type = L3_MISS
   *       .
   *     - If no snoops are generated before responding to initiating RN OR memory is not accessed
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   - For CleanUnique, MakeUnique and Evict transactions
   *     - If memory is accessed AND snoops are generated before responding to initiating RN
   *       - Update: l3_access_type  = L3_MISS
   *       .
   *     - If memory is not accessed AND snoops are generated before responding to initiating RN
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   - For CleanShared, MakeInvalid and CleanInvalid transactions
   *     - If snoops are generated before responding to initiating RN AND snoops responses include the data before responding to initiating RN AND memory is accessed
   *       - Update: l3_access_type  = L3_MISS
   *       .
   *     - If snoops are generated before responding to initiating RN AND snoops responses doesn't include the data before responding to initiating RN AND memory is not accessed
   *       - Update: l3_access_type = L3_HIT
   *       .
   *     .
   *   .
   * .
   */
  
  typedef enum { 
                 L3_MISS, /**<: Indicates L3 cache miss */
                 L3_HIT, /**<: Indicates L3 cache hit */
                 L3_ACCESS, /**<: Indicates L3 cache access */
                 L3_ACCESS_NA /**<: Indicates L3 cache access is not applicable */
  } l3_access_type_enum;

  /** 
   * This enum type is defined to count Snoop Filter metrics for the snoopabale
   * transactions received from RNs at a given HN-F <br>
   * Following is the algorithm used for a given transaction:
   * 
   * - By default: sf_access_type = SF_ACCESS_NA
   * - If SF access is applicable and slave transaction association is applicable
   *   - Update: sf_access_type  = SF_ACCESS
   *   - If snoops are generated
   *     - Update: sf_access_type  = SF_HIT
   *     .
   *   - If snoops are not generated and a slave transaction is associated before response to initiating RN is sent
   *     - Update: sf_access_type  = SF_MISS
   *     .
   *   .
   * .
   */
  typedef enum { 
                 SF_MISS, /**<: Indicates SF miss */
                 SF_HIT, /**<: Indicates SF hit */
                 SF_ACCESS, /**<: Indicates SF access */
                 SF_ACCESS_NA /**<: Indicates SF access is not applicable */
  } sf_access_type_enum;

  /** 
   * This enum is defined to specify the mode of address based flushing set for the HN-F. <br>
   * Currently supported use model is: all the HN-Fs should be configured for the same value of address_based_flush_policy.
   * .
   */
  typedef enum {
                  CLEANINVALID_ABF, /**<: Indicates Address Buffer Flush mode as : CLEANINVALID */
                  MAKEINVALID_ABF,  /**<: Indicates Address Buffer Flush mode as : MAKEINVALID */
                  CLEANSHARED_ABF   /**<: Indicates Address Buffer Flush mode as : CLEANSHARED */
  }address_based_flush_policy_enum;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /**
   * @groupname chi_hn_status_hn_info
   * Indicates the hn_idx of the HN corresponding to this svt_chi_hn_status object
   */
  int hn_idx;

  /**
   * @groupname chi_hn_status_hn_info   
   * Indicates the node ID the HN corresponding to this svt_chi_hn_status object
   */
  int hn_node_id;

  /**
   * @groupname chi_hn_status_hn_info   
   * Indicates the HN interface type of the HN corresponding to this svt_chi_hn_status object
   */
  svt_chi_address_configuration::hn_interface_type_enum hn_interface_type;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics   
   * - Indicates the number of requests initiated from RNs to a given HN
   * - This doesn't include the retried transactions OR the PcrdReturn type transactions.
   * .
   */
  int num_reqs_from_rn;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of retry responses generated by a given HN to RNs
   * - this doesn't include any RETRY responses to ACE-Lite master that is 
   *   connected to interconnect through RN-I bridge within interconnect.
   * .
   */
  int num_retries_to_rn;
  
  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_retry_rate_throughput_perf_metrics     
   * - Indicates the throughput metric for HN Retry to RN Request rate 
   * - this doesn't include any RETRY responses to ACE-Lite master that is 
   *   connected to interconnect through RN-I bridge within interconnect.
   * - #hn_retry_to_rn_req_rate = (#num_retries_to_rn / #num_reqs_from_rn) * 100
   * .
   */
  real hn_retry_to_rn_req_rate;
  
  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the reference time at which the first request transmitted by RNs to a given HN.
   * - This is used for RNs to HN, HN to RNs data bandwidth calculation. 
   * .
   */
  real ref_time_for_rn_hn_bw = -1;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the inactive period i.e the duration for which the reset signal is asserted.
   * - Initial reset duration is not accounted.
   * - This is used for RNs to HN, HN to RNs data bandwidth calculation. 
   * .
   */
  real inactive_period = 0;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of requests initiated from a given HN to SNs
   * - This doesn't include the retried tranactions OR the PcrdReturn type transactions.
   * .
   */
  int num_reqs_to_sn;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of retry responses generated by SNs to a given HN
   * - this doesn't include any RETRY responses to AXI/ACE-Lite slave that is 
   *   connected to interconnect through SN bridge within interconnect.
   * .
   */
  int num_retries_from_sn;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_retry_rate_throughput_perf_metrics      
   * - Indicates the throughput metric for SNs Retry to HN Request rate 
   * - this doesn't include any RETRY responses from SN bridge within interconnect
   *   that is connected to AXI/ACE-Lite slave.
   * - #sn_retry_to_hn_req_rate = (#num_retries_from_sn / #num_reqs_to_sn) * 100
   * .
   */
  real sn_retry_to_hn_req_rate;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the reference time at which the first request transmitted by a given HN to SNs
   * - This is used for HN to SNs, SNs to HN data bandwidth calculation.
   * .
   */
  real ref_time_for_hn_sn_bw = -1;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of data bytes transmitted from RNs to a given HN from svt_chi_hn_status::ref_time_for_rn_hn_bw
   * - This doesn't include any SnpData flits.
   * .
   */
  int num_data_bytes_from_rn;
 
  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_bw_throughput_perf_metrics    
   * - Indicates the RNs to HN data bandwidth utilization in MB/sec from svt_chi_hn_status::ref_time_for_rn_hn_bw
   * - This doesn't include any SnpData flits.
   * - #rn_to_hn_data_bw = ( #num_data_bytes_from_rn / ( current simulation time - svt_chi_hn_status::ref_time_for_rn_hn_bw - svt_chi_hn_status::inactive_period)) * ( svt_chi_system_status::timeunit_factor )
   * .
   */
  real rn_to_hn_data_bw;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of data bytes transmitted from a given HN to RNs from svt_chi_hn_status::ref_time_for_rn_hn_bw
   * .
   */
  int num_data_bytes_to_rn;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_bw_throughput_perf_metrics       
   * - Indicates the HN to RNs data bandwidth utilization in MB/sec from svt_chi_hn_status::ref_time_for_rn_hn_bw
   * - #hn_to_rn_data_bw = ( #num_data_bytes_to_rn / ( current simulation time - svt_chi_hn_status::ref_time_for_rn_hn_bw - svt_chi_hn_status::inactive_period )) * ( svt_chi_system_status::timeunit_factor )
   * .
   */
  real hn_to_rn_data_bw;
  
  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of data bytes transmitted from SNs to a given HN from svt_chi_hn_status::ref_time_for_hn_sn_bw
   * .
   */
  int num_data_bytes_from_sn;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_bw_throughput_perf_metrics     
   * - Indicates the HN to SNs data bandwidth utilization in MB/sec from svt_chi_hn_status::ref_time_for_hn_sn_bw
   * - #sn_to_hn_data_bw = ( #num_data_bytes_from_sn / ( current simulation time - svt_chi_hn_status::ref_time_for_hn_sn_bw - svt_chi_hn_status::inactive_period )) * ( svt_chi_system_status::timeunit_factor )
   * . 
   */
  real sn_to_hn_data_bw;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics      
   * - Indicates the number of data bytes transmitted from a given HN to SNs from svt_chi_hn_status::ref_time_for_hn_sn_bw
   * .
   */
  int num_data_bytes_to_sn;
  
  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_bw_throughput_perf_metrics      
   * - Indicates the HN to SNs data bandwidth utilization from svt_chi_hn_status::ref_time_for_hn_sn_bw
   * - #hn_to_sn_data_bw = ( #num_data_bytes_to_sn / ( current simulation time - svt_chi_hn_status::ref_time_for_hn_sn_bw - svt_chi_hn_status::inactive_period )) * ( svt_chi_system_status::timeunit_factor )
   * .
   */
  real hn_to_sn_data_bw;

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_qos_throughput_perf_metrics     
   * - Indicates the number of requests initiated from RNs to HN for each possible QoS values 
   *   in the range [0:\`SVT_CHI_MAX_QOS_VALUE - 1]
   * - This doesn't include the retried transactions OR the PcrdReturn type transactions.
   * - The width of QoS of ACE-Lite masters is assumed to be same as connected RN-I bridge.
   * .
   */
  int num_qos_reqs_from_rn[`SVT_CHI_MAX_QOS_VALUE];

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_qos_throughput_perf_metrics           
   * - Indicates the number of retry responses generated by a given HN to RNs
   *   for each possible QoS value in the range [0:\`SVT_CHI_MAX_QOS_VALUE - 1]
   * - This doesn't include the retried transactions OR the PcrdReturn type transactions.
   * - The width of QoS of ACE-Lite masters is assumed to be same as connected RN-I bridge.
   * .
   */
  int num_qos_retries_to_rn[`SVT_CHI_MAX_QOS_VALUE];

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_qos_throughput_perf_metrics           
   * - Indicates the number of requests initiated from a given HN to SNs 
   *   for each possible QoS value in the range [0:\`SVT_CHI_MAX_QOS_VALUE - 1]
   * - This doesn't include the retried transactions OR the PcrdReturn type transactions.
   * - The width of QoS of AXI/ACE-Lite slaves is assumed to be same as connected SN bridge.
   * .
   */
  int num_qos_reqs_to_sn[`SVT_CHI_MAX_QOS_VALUE];

  /**
   * @groupname chi_hn_status_throughput_perf_metrics,chi_hn_status_qos_throughput_perf_metrics           
   * - Indicates the number of retry responses generated by SNs to a given HN 
   *   for each possible QoS value in the range [0:\`SVT_CHI_MAX_QOS_VALUE - 1]
   * - This doesn't include the retried transactions OR the PcrdReturn type transactions.
   * - The width of QoS of AXI/ACE-Lite slaves is assumed to be same as connected SN bridge.
   * .
   */
  int num_qos_retries_from_sn[`SVT_CHI_MAX_QOS_VALUE];

  /**
   * @groupname chi_hn_status_latency_perf_metrics      
   * Indicates the total time taken for the transactions at the given HN to complete
   * that are iniated from RNs
   */
  real total_xact_latency;

  /**
   * @groupname chi_hn_status_latency_perf_metrics         
   * - Indicates the number of transactions seen at the HN. 
   * - Includes non-coherent, coherent and retried transactions 
   * .
   */
  int num_completed_xacts= 0;
  
  /**
   * @groupname chi_hn_status_latency_perf_metrics         
   * Indicates the number of Coherent transactions initiated from RNs to a given HN
   * , for which Snoop Transactions were initiated by the HN
   */
  int num_snoopable_xacts = 0;

  /** 
   * @groupname address_based_flushing
   * This attribute is used to specify the address_based_flush policy to be configured for HN in the interconnect.
   * User can specify the default address_based_flush_policy by defining the macro SVT_CHI_HN_STATUS_DEFAULT_ADDRESS_BASED_FLUSH_POLICY.
   * Supported enum Values :
   * - CLEANINVALID_ABF
   * - MAKEINVALID_ABF
   * - CLEANSHARED_ABF 
   * .
   * The address based flushing feature is not supported by CHI interconnect VIP.
   * As per currently supported use model: user should configure same address_based_flushing_policy for all the Hn-Fs in the system.
   */ 
  address_based_flush_policy_enum address_based_flush_policy = `SVT_CHI_HN_STATUS_DEFAULT_ADDRESS_BASED_FLUSH_POLICY;

  /** 
   * @groupname address_based_flushing
   * This attribute is used to specify the minimum address value which is to be configured for HN in the interconnect for address based flushing.
   * When the address_based_flushing_started is set to 1, and if the address in the snoop requests lies in the min_abf_addr and max_abf_addr, then
   * the snoop will be marked as snoop due to address based flushing operation.
   * The address based flushing feature is not supported by CHI interconnect VIP.
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] min_abf_addr = 0 ;

 /** 
   * @groupname address_based_flushing
   * This attribute is used to specify the maximum address which is to be configured for HN in the interconnect for address based flushing.
   * When the address_based_flushing_started is set to 1, and if the address in the snoop requests lies in the min_abf_addr and max_abf_addr, then
   * the snoop will be marked as snoop due to address based flushing operation.
   * The address based flushing feature is not supported by CHI interconnect VIP.
   */
 bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] max_abf_addr = 0 ;

  /** 
   * @groupname address_based_flushing
   * This attribute is used to indicate when the address based flushing is started.
   * This attribute should be set to 1 when the inteconnect is configured for address based flushing and should be set to 0 when the address_based flushing 
   * operation is COMPLETED OR ABORTED.
   * User can access this attribute through svt_chi_system_status class object.
   * The address based flushing feature is not supported by CHI interconnect VIP.
   */
  bit address_based_flushing_started =0 ;

  /** 
   * @groupname address_based_flushing
   * This attribute is used to keep the count of address based flushing operation exercised by the particular HN in 
   * interconnect.
   * The address based flushing feature is not supported by CHI interconnect VIP.
   * This feature is not supported in the AMBA Multi Chip Monitor mode.
   */
  int abf_flush_count =0; 

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cF080HyUHURf52JERgTeC24RtgBoRYpPsXS7ZL7jvvyOiiRlFs/894w6nXz27l/0
o5mVLtJoy4iU7sn4vKN9YpRtSWta//O16/AQo8bHCzrOduKdFIBpUgK/mk6hashf
PqVxn99Xmz7HmPoByDOEaPsWAXJImdA2jAc/Xj6yvVY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1902      )
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
`pragma protect end_protected
  
  //###################################################################  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_hn_status)
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
  extern function new(string name = "svt_chi_hn_status", int hn_idx = -1, int hn_id = -1, svt_chi_address_configuration::hn_interface_type_enum hn_if_type = svt_chi_address_configuration::HN_F);
`endif

  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_hn_status)
    `svt_field_sarray_int(num_qos_reqs_from_rn, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_sarray_int(num_qos_retries_to_rn, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_sarray_int(num_qos_reqs_to_sn, `SVT_ALL_ON|`SVT_DEC)
    `svt_field_sarray_int(num_qos_retries_from_sn, `SVT_ALL_ON|`SVT_DEC)
  `svt_data_member_end(svt_chi_hn_status)

  
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
   * Allocates a new object of type svt_chi_hn_status.
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

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of requests of svt_chi_transaction type initiated from RN to HN
   */
  extern virtual function void update_num_reqs_from_rn();
  
  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of retry responses generated by HN to RN
   */
  extern virtual function void update_num_retries_to_rn();
  
  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of requests of svt_chi_transaction type initiated from HN to SN
   */
  extern virtual function void update_num_reqs_to_sn();
  
  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of retry responses generated by SN to HN
   */
  extern virtual function void update_num_retries_from_sn();
  
  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of data flits transmitted from RN to HN
   */
  extern virtual function void update_num_data_bytes_from_rn(int num_data_bytes);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of data flits transmitted from HN to RN
   */
  extern virtual function void update_num_data_bytes_to_rn(int num_data_bytes);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of data flits transmitted from SN to HN 
   */
  extern virtual function void update_num_data_bytes_from_sn(int num_data_bytes);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of data flits transmitted from HN to SN
   */
  extern virtual function void update_num_data_bytes_to_sn(int num_data_bytes);
  
  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of requests of svt_chi_transaction type initiated from RN to HN
   * for a given QoS value
   */
  extern virtual function void update_num_qos_reqs_from_rn(bit [(`SVT_CHI_QOS_WIDTH-1):0] qos);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of retry responses generated by HN to RN for a given QoS value 
   */
  extern virtual function void update_num_qos_retries_to_rn(bit [(`SVT_CHI_QOS_WIDTH-1):0] qos);

  //----------------------------------------------------------------------------
  /**
   * This Method updates thenumber of requests of svt_chi_transaction type initiated from HN to SN
   * for a given QoS value 
   */
  extern virtual function void update_num_qos_reqs_to_sn(bit [(`SVT_CHI_QOS_WIDTH-1):0] qos);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the number of retry responses generated by SN to HN for a given QoS value 
   */
  extern virtual function void update_num_qos_retries_from_sn(bit [(`SVT_CHI_QOS_WIDTH-1):0] qos);

  //----------------------------------------------------------------------------
  /**
   * This Method updates the throughput performance metric for HN retry to RN request rate 
   */
  extern virtual function void update_hn_retry_to_rn_req_rate();

  //----------------------------------------------------------------------------
  /**
   * This Method updates the throughput performance metric for SN retry to HN request rate 
   */
  extern virtual function void update_sn_retry_to_hn_req_rate();

  //----------------------------------------------------------------------------
  /**
   * This Method updates the data bandwidth for RN to HN transaction 
   */
  extern virtual function void update_rn_to_hn_data_bw();

  //----------------------------------------------------------------------------
  /**
   * This Method updates the data bandwidth for HN to RN transaction 
   */
  extern virtual function void update_hn_to_rn_data_bw();

  //----------------------------------------------------------------------------
  /**
   * This Method updates the data bandwidth for SN to HN transaction 
   */
  extern virtual function void update_sn_to_hn_data_bw();

  //----------------------------------------------------------------------------
  /**
   * This Method updates the data bandwidth for HN to SN transaction 
   */
  extern virtual function void update_hn_to_sn_data_bw();

  //----------------------------------------------------------------------------------
  /** 
   * This method performs some basic checks when address based flushing request is received.
   */
  extern function bit check_for_abf_settings(svt_chi_common_transaction xact, output string err_msg);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VgZp5AnRNcfCiK2MsGwMIlons1Z6EUiHLkioGeZnsS6tzYFWsZhMQbuasatbb+Vf
Wr2EAJiHZFnS30ZtctNok5VpiaiBXjJrt6oYb43o5cA8b8R0tjH0KktJwHtte5QR
XPxR/O2/tyXHnlGpG1Jqtd6bhCII+oD9y6Awntn/neE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2827      )
cHkdprIFD7BNGCQTlSK0RM6OxsGHL7wfaQd8F2t4apH7xC/c+G6+UoZy0J0M/LvO
V7k517redVqrAWxy3rb9lQmvLDXJx9/E+yUfB+rjtPb/MAXaFbMbw4a0HDU7UQNY
XIldisljv67XXiFyYR/qCYc84DdqonE+/ONGyHKRYEbjGNzNmCjt79G3Kn2TFFRL
ACIQrYO896HiZo/0A1ZT/3EledzqnKvurAH+yLvaq7aSPEwrTTUoIF6zD5qDM7Qk
3L3/eCjVeXJiFJsXTlWR1xw+8bMzt8WmS0D6Mi0Fon0l9vYUm2XysFTiR/YyeCmj
GwDcGUK5yqYjeLUqIPc6HTXwkUV/0HzhFIk/NVybKD6URKks7i1qefyWUFPbLdNx
FGNXzs83xx9pzXWbsDgGxvJBEuSGV12OuCxISUN2FQn/btSqyzkog6buFb/3RYo2
fOde4iQw6Qyj8ehxhBvkTWvnS2LitYPe/JqcGjkt/k40QBxN0cMgSSQo8sJHqLWk
d5UepWgg5lQ+Yl7gn1hZBFHmiPei+qF0Q8ZtkTH88FdfCMBCzrnVUzDvfgbotMkM
MjQuW/pSoVfMhllFvFbzdXPa6R236ajobJFs17c+RNNUK2VMGFCod8e5wpFcEnSO
PiDTJaTAOYl+iRnoG9rRtSInARnc4BicjMHcdSA+Ar0/TGfprwZnn1xCnSRZNmRd
4Nw/lCRFaYv24ht++iYyCBpXqd8tu4JLDo6XKA8Kw2se1rlpYokqd4brZw6WCiMk
8nOHE2KI8YB1Qj2UU4YPO7Fn4Z1OX+yEgBFx+NGOlLgQ2OE4ZnX74I3CxDafj+Um
tRiPvoNQ/cpG/PFggop8RTRTpO16zmxHoAYR4XetsoQNDfdP3K/uB1SjktFd5A9n
voSrkp+UtXDWvSepPmydmMUEZTzmuDZEGyj001ES5FiA/MaZuAFM5UZiWVqre0sZ
S4Rfqg8pNI3vPI1YeiBhdU3yNGjWCOB/MTndYMsfGMZmIqulvX5FcXKBIt2N6CTZ
hOYeyYJS+fRYMtF+gzyl3jZPeDKwWybhBrr3mUV9ZGr2uLVOApw6dg7PmCx+y0BR
9aCT1y3RqzMzRohO5Tiylr23IvRUzMxuf/Vin5ovaqSGbMDjdi/2B3Dq4pcH+okE
Dw2mtKNYTarO7YMqC84PUCFkbxsF7ZzeBeb+0FY7yTvnwi10g1ertu0h9iYp669s
ZEitpZE4gET/7Nm6xNCb5A==
`pragma protect end_protected
  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_hn_status)
  `vmm_class_factory(svt_chi_hn_status)
`endif

/** @endcond */

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G5xOaaj1AlxS9p5ouLZBuG97LAJLB1C9qJPJhfo4qDcFBsmZ5EtT7Lz+0XZYd9TN
EeVkPMR/eDeEt0reEBuxedV9SfxuzFUPH8/HgbdnPUBTGD/kdjKstUhyjnbaBqJt
rkK1/SSsmulubP3YtKWdmy2VfM4jvQE8f4GXSbApGVY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3707      )
CZh30v90pZUBM96NBy+kHMTKkOBUr8yoB7StZ8kbZdYLOb8Baeu7SkWrib1ykVFV
pS10cVxnRdD0OXwFnC6Y5klDGvqA1nTkOI5GytlIKE1DLNuvXf79GB7u7wcc4DDG
FF7/+c7TZyIbmhcPi0ngap2xvAcru57hvfUdp4oqzQ/wxPBZkFxln7CBloWtM2kP
MYreQXyeu9Ogv69S3t0d6nRoXZ68EVRx1U5hXhCphKVclyCmZ9YgqbYLtsEfQ6+x
c+2WLAAjoDIgJlW0B5GO9sujW9TJuwRJ3gsB77QTtde5p3solaOeB+wig02NTghS
6U4ybHTp5WUpxuejs0jtDXNa0mY19vn29/I9drtXHBfqK+SDl0guKE8DxwqwtxfD
cxWjrXRhG5N5Z9PdJTbHx5mLwahMfa5EsPt7WMDpkLh8GvR4Om56Co4PrEBW9dZU
eyhihIBn9h5xmqIjEiH8I/gJtjazqlTsPvvkj7CcKcz5r2TecVmTWSglRqzbsivz
dUSdYpTXZrPXvUpISvx3a0l535QtyqyPEuxqujMXb5t98BveE2MI67dEFCuhiTTw
jWmtsQ3L4B39Y0kccEc0PUVPwC032Hm/HxA5AgJlz8NuZwGESia990X83B8TiK/d
iQ2IBWP5D/fwYf51h1SYF4qWEJPO2osODmfnLAFqsh210FBAjR03x/z++/TW2gJJ
w6kjVsdpg+lu/CuUwlJsxsOge/LB8mbBkh2Rp3QPwVF6AlJp7GSYLFYkNRr1fv7H
nCfabilq4G7Uw3ufJvF9JzYPQnVGd5inGyE33FUmcsE2gjYDptvallRoBp64u4tz
SUB6RCevLLhUHZ4z/1hUZCe2T0iQIf+oEmj7SjpIm1TJqcvRQ7h/leD0pApFRX24
hE+3glw6mO9s67jk20Sp+ZSr0QZY+RqlB/h62et4PonKa8p73GeP6bCHtoFr7KxQ
W4TjtqeBFEduShENNcTuQuy0BpE9ZowhYgUnwszQdq775OoKVHePFxUrTxGKHGYq
rTf1+pnWoda+2X7MpEeGT2lPNZ6J9TFsPMZMPbOwLIMEm+PlSU0RkWdK0wrKzGea
/BlSuFQJ6FzUmbuDiewswNLOY5iEHRFn9RAZHPnYXJFL+xAvzT15Cu1Wdr8WUSNW
BmEedsicwOaH75eDxTYP7zEg95FSjZmmM3cTZsPPqWo=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
blIJGh21a4zZE449IBN6H3wnJYAtsQ23d0Kibwm9L17rdbTAhFmws7k0WsjUyxfN
tx7lyEypbPlkqgcAu1TTpJ0zZyR5aKfFOdujYkV75TFLmev8bwVs2BgAVN0CfFBr
k072TkwWcjQX0plavybKEU6UrEa0+05A1BlYw+PUw0Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 37616     )
wsHGeYQdPvSfescRbap6/ovpzEPhFC1LvGmkFHIvRZ27igP1XntsO/3RRxM5FiPB
WUgEFeprcKQEdEHMe4/4D1vGZvjqzdM5YQnE6wYAwY0owL5mbPoJwJV5abu96KsM
rms6Jjn0aZxVREywDMOVmThelY+ZfG2kl5RJ0sTUKaE/4R87oTNjhs3mUpWkg/rX
2xO4nz+45SrbQC/C59xijaVI14Em4J05WbKSx0oGSBxB2snXzSAe3F0gaZrVYcp3
3Q3oXG5LTET/flJ24Idi3x7uz6wHwf0PpRZIOD5KlNJJUQJkZPOslSQQ7YnSgDle
XJ3lrTSNMFudrOUl+Ud0Us0nxhzPzsOha481oA8VpaSHc4UkyfwrzIzSU9SMQq5L
kH0Z9oXwr+U5VyZ73tHwq+yBUsgD/hyIHJAchf//T1U5nKXRAzjK2bUcCBFhkD5W
BJ9WPybOQRFzs/95PdXJcHzlO9hWYzplm4xwMdwDj0MntMafmGUg4AKRMpsLh7fR
CQrOLpkyeqh5qwnqw7WavgsT9PmAKiSQ9KZzI6TGCAEsunc4K4l41jmM6Wnqgksu
6PSAWKnE9FdSCb2H3gh8ADWBUse/pp/6UoqwNXaTeX9QNgB6aVtIOGcGbuaHQPjC
t5C1oNUWQrtX+gjq51f7Z+UPLovVnFBStcIAs1ojrtZhwaQSRwiIuzY1CmgPTlY3
o7ec2mO7JQsE6jCsRpb5vszhNZKB6OpFfgPZvOjrfb8uNoQitAsQ5y5OFlTwYR6c
JjcagXdsEOm8chutE0j8UYA6QAXStcK/xgL3Ib+gFnVtRyZr1fQFzHQ7X624CQOG
jL9//ptI5ZP0SFcWS24G/gPiestjOUoyMyeGM3fCDgijjuMumQUOh19+m6cdOXhO
MDP0HTD5OP7eGLol5g4GkEdTZpFnHI7k/C4u3Ojl/MThio5+BdOgsxc1lFAwVno8
sH4QMAvzrFF7FuhAeDs9Z1ZHNpTkKub8WRK6yASDWzzl3R1Qgn1zprq1PSFIAkz4
O38ET7vnF2hNhnQoyPiBIpZVRicFIcVLz8uaOoOwHdRQ/pRUlVN0fd75837seG0s
UsRE9yvXTO5o9yhdglL3efLQ5j1Ay27PbIW1YjnyfHCRZoyktaNCQHOvwzLtqer2
E6y6AhuHbyrO0fG4EH0W7s09g1h7n8jQcUoY5zIZdfNH9hR1PZI7EC8FtXidELdC
5a+kK7vO+G6ZKTw13NWBCcUfsIMdhnZgN1XCiHYCW4ix1NHpArojhdf5+R9DaiGv
EM0DwxCpFKcBLuDOrfxQ7Zc/zW3ifxgWin2n9nZq5RrFuMzMIou/h7+LvpGYcRs9
UwNOjBlP4YJecUxkSUP2v/2natsjwbhVLce4r4KCQgl7LBrWBkpmDVVwzM9llC/X
Ncllf6sh96ai5yRtVeyREctC3xLn2qS2A6BINQYxIJAsF8qEGhkT9sPEu8epCWIF
aF19lynxvPh9t+ol7y1Zy2xrEKij4KVpV98+hODCW1zUbcUGg9rKfbt3L1fqHHzR
aOMP0V7/PejqqCYR++xzHTieLGyFqVqRuiUjtiZ1M4WwIOH1onLaBUCNUuZOe6kz
AObQICZNug/lPtEhx2eJ9ggsDF94EQm8Q1BmlovTmGra1+1ToWmFsXRrVZ2CDSo7
invLBfGgR3NfUp3ly5bNgNEyArK/lqI8uuiqx3+fKOkRlB4NqZA+WnRTBURDg3Ti
Smq1oPXic7UVLZzuxdaq1J7uQgDAKEx94rpeRRrDXRfulvWeHuOCHlIXLMgOU6YA
vWMvaA99PkLjJpX99h+HSqV2Vqx/z0/v5Qwl3hKPP/blTYvbRc013SZxy3XBgNzz
N8XGWNxlik9x6jXWbXACKYeCTutevo+PkXgmkct/WiDzxzBV74DOlnEjPjM6ISTx
/4JM/nyoF+0MjPJbxaSzAhqqFFqRHg4mxe37JVTD3/eL59oSdfgWgdb9jGZmzKnn
pOyC9pv6TCj+Pa8p4NR9H47PrTYgPWtn5N4UP3fW/opZ/EcOqe+jZScSxd2Pg33B
sS9QTpgdfRKg7wbyPAqfYgx07H4hBfyMm4vCqwX/xeJLfsTMWfqq89/ovVRRsRea
r1PIwZDDgOQME8eqdG/jqRddlNCXgoPIegmXUlCucn68XNZfxUQY0hhrUjz7lUg4
BGfyJP3WX1sGGq3JOv8Y42QTDWFz86LsszLXjI3aTWNZKTTuXtHVB+nejeyMxXIa
EG0ZAj74IWgkSa/n9ZlLB0ztk92U2BZCyk+D14s12bVtSArX+46iFw1YvdcJY+d/
dkNbMsJvmAiA2cxW5pdvb9y2sF6hVxrBX4Fv2MAWDzhAWR+eqYjqTudTBeR3osNk
plWaq6znsCtAHNl8qk88yazMkJj1osdmKb5TMmlFJCDgDxEVZ2mYmCJAN5O9OC+J
PTNnRlQVYOMc1ZAjHg3KWUzZuCbdwvbh9lWVfoEuPlInz/pcyiE8feWTqu/JYOW0
/gkvNuKesZMizdYvbRfhtzvoO4FBwQYmhFnxvckoEY9I+2vK9SK7awNejRARCEMa
2cAzjGTyeTDWe/nUW3+jD6ZN9yuCzUP1fjl8fLT4fbBz1AFFxnjLfRE/lTQV9GMa
WkceU3SKsGnbMofz9YT57xE8JLBov4grhP679++pUBp686uQmZDP9Or+OXHHl47y
dQzzAc6ZYyBprIJNahISyPFt1fyrfAlO93RhxrBOJuloaZoK5OSMa8i8xxyr+fnb
I5JdvysU1GbndG5h/TDT6WBNES+ZX6hnjh+asRNZP/XLcONYUqJcptaI/TgqBoG2
i6GO8cbl9/k/luZw63oRFLqFGsov75WLnGms+f/uypRhIIbO5koEQbo6mOvAWUla
vqM/Jx+VGCD009i538EHl21Jnr7dsEQpBG4IA/nx+/7WMlt+/1KwFdKh68vMWfEQ
8j7n18Qr6Vf52syqOm3nXbbB9Mwl1QJakczrODJdtSvWReS5L5s+2FkOUZJUGiDs
EcVzsHw+Uvv38mV/uYi8b3yJCt7WNagECdmSpnFcfJG2ZuFL3iA/gNJ/19MpnJmc
3rcwqS7XfPsc3FjtkBLUlLhDydrYko0yHFF2hzzuKfKS6Pu9yB5Jo86nomxVVP6e
QLLVP+juxIk1qSVsfYyy+o81hO4Yk7bdy3kYju0wWnOFhHarLiE7e/r6l2I6yaZ2
rHD3HamhABR/3D4pSHvAaF7kTerCht2KVEw6rU4xLysDMmZFMbZ7kIcAVacnGzxj
Zkz9mu+1EWux5wcntoKghieQLYRlnEUPVkVzX7k/QRh+EMwN3jkNfCi8P8JtkByW
1a37JoIl8u3/mpawsfn5+FckLRvP2yrRBYHVaLEYBCz+ax2eiYIc57sSNbA2Xacd
TixYuoCRTcwwpOioVV8fge1Zx5+qOLdAncCYjhn4lpRtOqv9GBrxWR4HaQ9HEDvV
dEM3kkcm9HvnhlXO3IXlggHcRgI5beBVp5eYIoAXqNmSo/45KffMyIZr/qsEL19n
bNzW2TlA5S3EkvVfoYSbhHlDnHRPYX0P/RurLMoPRcUY5qOei1reJmqGovbU9jo6
5wxXVtEhzZ+1xFy2SdCsVqsD1SL0UhUUaele45KenjRiGqFM9kVX9Ykkz8m913NJ
ErchxPvYnBYblQr0LwaqVjHez4AgycyjinI7VCbp6mx5ft36ulZ/DdY55YuSh5x8
dvO4Kh5Oh0Pwvi4EBanrxF+BZvC3+OMy9KntlDs5tifMrYHHW9ynFGuvEhatg7ir
Jbt3urPCrEID+zqu5coGdIPCMfNhEe8Hw8hoBPaPKbmQSUysahTLbKOzETtE5KFS
Wz6H9IjQ9L9oaym7FHVJdLqDsCQ+ctaXNGLnN32yEh/AyJWdJK/Ko/rGSA6R29qp
N43rAZJWR1hI9qea0bcpP9E72C7TjEgfssXhDJPc9dewTvgLFxWs7Mcj4ZVjoBSv
ulioMSZam7wdBajXCQ25pufTJIoGG0ybqm6u+/NTA0SD8Ja7Hh1kIRfMjv6Mq7Ti
240YsYE3AeeQYR/S8pL5MrZU4XZ5sSu81bdr8dEr+cH0+IkOCojMLRdx/zQNcork
uSxdLCo3Jp09g3bktNnawTCQBJrsNVns0Rt2o1uNle4p5DHJQ4an9SR+m9GseaCH
IllcD8KP/41UDXaswqoWeE3mNc1eW7pDzVtlGAvLnnlJGqyyDyRbxFvxo3S9XtTH
80siwBbRZAoSlRt/g4dBao4WV3fybPZFuFqXkxj85Axp7gfXaDEfJocqTAJXSAhF
MkdBbb+05YnFjPok66vvzDnXWH1UmmwY/7150tnmjaGmhtM2Xj0GeWuIdUAF55hW
mIONm6eyYUR0IapClyemL/JBKVWIbKaNX41li17rOvMioDetrAAKnfs7cdsOEcdC
8JZPxdI0QhfEZPWBH/DUCOQDwr8MH+l0wIQAOUiXcgh3INaE3syIb7us8qDP8gUf
QCdF/UFPjqY5PCFcc/aAGTxFfCXTsE+j13KR/m35o/Im8CSDrNPLRnnk3BuKeYTK
rryAoktJCByl9+Yt4kDMO6gHZVD1zFZR+MWg39eJrQUedzMp3hQztsZhmQABNkT6
ON8gcwQt6fi4gUV2QAV1YEC5lO+IBOgoMznKwgqQWRWAAJp9tqikTwFf0vNZEM6t
7mru76j6zpVKnfXIdZFCSIZkZ/1KOKCSM+TPP/kj9ISI2dCwPcq5gdE3h9D/m2XE
f2E2UDWRh7t/GxK0Qnnyh7ZgK4oZRBZDRK5V/41y7nUWR2IzYwPeGqkWO+F8+pJ8
gqV6u7Z7VWsi5R1lyjtcPD6X6rsNvVj3NnJCuLSgzLsHYyt3tcIdmzaXHTa9Pzn4
5s7Pbc1KtCnPx1xr0c9ftYODPhTJ7fPbzrrK4qbfdqvYTCz0I70hEFbuVFc1lagc
0qej/bufXl7OdiBPhVSwHoMv9/1P0rt2iIHNCs5e8iUvK0nJl4MhRfLYnhl9IClO
Z3X4v1IAFQfgW7bgz/D9VQ/W+OzceCtp+WLU3pasPo4r7M4sLD8HXEtfRICnMb/t
Mpk+kzdZZL3Pd0LaH1adesXBNAQG2b7ksSrbBSgXWFUpXxMN5sKgQUP0PinX1/X1
OXLImYsk/1mZ8K0373a7+LxFmSQ4b/Rw14qp+A9TtnY+FXhHyN2RT9Fvu+0/iVQh
bZIDFdLjE4RMT/GmViJXkCFk57oDOzJsmePrrfZPPWniDVDLYFxmLbA/DPEJdfHZ
71usutlWe3dkeFYWLy3hbdGYuN2iFl4IfE+4mCFXsyc3ac/9n/xu+g2nPAejP3VY
/DzWerIfBAQ3le2o1baeoueE2bZ+nPI4FQoAl/SjJy0FViqDY4GDWP97oop7bOpD
+OirRYdbyhQDFGBKCaD4BK148xU3V+D8mYyznr+k931HAlbtsdKGa1NLEprMIQWp
R27utV01LF3RV9sK9RkbKlHxX0FDsBOLinp+ZnNHGsy7/Faw2BzJAGTSeoTK6ZLn
WgS2nvmAPuTZ7qbI7r40bx+FXtOFPsLzvFKQyGnDzeLK98UcbXb5Pksq/VQyRfQW
0qO4SCdYgkh7z4j4hz/lM2KGLuMG8LpdQlsTZ7OEejOUxeALtVdRv8kJFNe9EkwA
qDBfY2VHiCzKtKNiZry5Ab7rKgIuGKoVqNTjjHtfxULLDp7nRVuWMfoXmzpbAo7W
Tw0pZAwvaNNVcbHoJgTrRgXY6pbdqBycFirSampS2Pv6w8ESAEtFdNKZsNxZY/lX
RqFSH8Y7Cm8RQ3YyS7rNBb9tGOu/Z6RqxOWdCcQeCNjMbJ/1aUvBE4pqm5yamzOr
T5aUzUb/R4PlhB1U4g0BHN/XTmZVNrVPMHaKb1Cz0YVP4OYtaMWcKCzd3hx3gOoo
A7m+S15/cqBoEnpmv+d4lt66Pzt8Y0RDo69MXAsOWgMORliAm17U46E+OX0wpKkQ
hDnNgzxYxasT4hOXvYFezISdJ+Sl5OM4/sPDgV5AQxLMv8lnsNUadwCovCFTolkc
exY/kPuFzV+bQI/U6r3PHNieHG1OUDY4I1UsYV05CQCEPe8K0QjpoORqk7DTpn8Q
DzhnRwlWutMCjKoeLfZwqbsXt+Frf7N87IfCPVSx3M8JrvK+skgP+TlOQ+qrHTlX
1MVzUZF1skCppTOYsNkZjQmVEF//hahzIJcHXt/6WG4ERxC8E0ionfjmkJDyiITQ
qs4t35WBST6bzLpYWb4ZRI5WNEL0hhw+Fgi5ZYtugnBPdmw+Qy+EOIjlwLHvtXQV
1sNvfta+wDRoASwUWf15YXvQsKn4YAIsjTC0v3LvUbG/JZbHQ5AUx1nArOGvM4Ks
AEGgXSbvzLyzDpjpUfdeXPsq8tUJV95+RlpCL/D1QaaUmJ2tBh2uT0qbpGQ6mEx4
sb7FQoepetBQjXy1vdCmBcEp9RK9JJcMhHno6fPHPWO1OGHEZyA5f9fZ5WXTMBhK
OpgR2/dq90wxmrFtzlLihU0C93Agwl9Yah2U5Ooke3NCV30MjGGj6ZH1BSEi3sav
cun4NYxvY4zzFMx/zB1By0fEyNH3DXAlkaZ0e2qyZxtibDmO8HmLOFTU967jalK8
yuW50EMUWy+NkHGbnDMBroCBjtlN+W1yqJJ5qcrj2jXQhB7OOvGcD+pol91+ih9k
Cv4A5SoffvkOASmeg8YNrVY+oT0SOQeFSCNyiLyZZl8BR/ki2NYTf/DkNc7Akrkp
DXHR917a6Azjt+TzLa5TteHCL2ZeHDQJ1a+rznLMsN4ABVO+q/z7PMUBu0aKpBa0
55VURhC+uo/1TX6vH/ki0/sCrZqm2VqmKtng/Nr0jkxCLou0bnuppptJcwR/Myuk
/GG0Q6UEVxmWkIPWhz6vtgaB2RcQu8QCNopjHhRJa6nWQoVdtqzG+dZNodA0bsM8
oGgXlVpGoGIudXQ8XSTDqfJYSvgTOu3dBfu/JacEGQ+KDLm4quTG05HWSjH2KSmU
sRAawgFKci2Sx0lRkquhNjjQshs77/BQ8Ot0iZJmC/qMdrooL1VMtr930E1YJ+Vt
qmRAS0twpMfN/pCJvl1vM5tgMRJv/4jTExY3kIKN32U5050S+QjgxAzQl2AgIot5
K2CmQwHrW5Q1u2QL7zelEnQW7Z82eFsqrQzWmnvWP3h15fpJIzl8fwZruJd3CVmM
mtR2kayjDL7sOVZewLztiTQKkReyfWs0j3v1bKmTJs+WWq3vNVS2U52h7WdB6DhZ
j3x1x5wuy73bANoipduwSOfJtYeTH2vsbLgOS9pnud25nIpnL79KxektuNyU6D9V
K51Q322LJoP1PKG69E4AVWYZHhvPVXKSBvIjUDxLKRHGWSLHyFbS8iNm8wHGloJh
46Tvc0JEhSkfuZ31br7zpTUbG3gQOWY+P/NKdCLEeQ2eJ4HOtPXkwO4qlGdwmmv5
FwBRsUJunwckEh+++5UdylNH01Gsw8gvdnl1c9l7DJ4UiFHRPdArvaUiG343E+Mn
YTELAmPKQhqdOM8oX3RPncyINQlv1zDefg949el6IODVm0wRxQ7jkXQCs2mF0Z2l
1qSL20AVcFXTPJk4diyKaLuoM5blIIqJw1mJbhWET/sdZbS2ZjvY1BIeXOMlRD0Z
zSMTy1IPcQ+qaj1jbnJ+ABJ5FSvkj8Tj/0SY5kN2ObTwKZdMA2O+7C3x88LwMuUu
mXUnkaav3LpZwEDJM3Zxdrt/UUNW+pDLUsP1lVnZcL85jSDTl8ZcApYofAcTbYrO
GzjSIaKXBznqFIc5fXtW3qzKKtRiKQENGoOrWPoAeppN7Q56lStMzVNiKBjasnIc
OFkO8L2PZJ/rSC7kUwO2QP0JFw6ff3XbPcgf3vxZZnLHApOL15ry7Ajg/N8wWmx7
+NyXZ42Wu9VL8FvhqVNkUqxpZlwxr5S59kV3uWpORDYCwRLBvA5mH7DqWsuv7TO/
JmRsuhRK4/e+v+hOb/v1QN0L4sP/2DMCUr6sek5KHuP4CD/+VwaGLsqTbfqLKdTR
lkU6Kq1xlcBEz5WJ9S+cmn5sd38zhAGcNF0cjqqbmbG5XgC6NFiE0V/3HFDlK3kV
Ujp3QIEACZKmGFH+0U2o+F9OdEh4Ob5wVXDSNim0WFmZwOKe7BW2NC4YH4PZukxG
/nyTDtDeMxdlcJPxQ1SQ5bxYHZ4Ewq4k+5VOdywjKxrH+mcXQGWtjZuM05H+iMRW
oJeFbBAR9QfX5BRJ9EacXTrQFaMZ6jmPrCcWI66Lt3oAUTh2/XI2PtPqSmnREV7T
ctXRp1cjuLtSARiuvGDScJssMsYCSqrB/mb4U0wwzhS0B8ZmqU8C7ky8hKfE6tml
nv/m2cMFnkGFagQfxu6/ZTaXawyOe20Y0MN6aVvM8Sk0kbU6H/NbFeqaeUz5nMVG
olE9CtOkgr6GEB+a/SztgxY+kaNZfj5FOw7K6BDp0N01qcFMA3H3TYfPUMbuTnDo
/IduYyw3XeF9vXcWCg02aMPOsS97BbvvBgubaI11FmM4MKKPXBRbLI2HUqlFcECk
/Lh/n0Uk5Ke9Z1Sbc2GriVYGJJJ5tByME1Zrok+9p94/0gNPKXp4djoAo0u3SZgx
6esYz4VoruaFtGW1aGdl5BJD6TtGqwioECM33y2ICKl4WfA7kJjZqkTWMGjDcYta
ZXhpVED8CXrE64F6nuFgN6I2NjrUf3IDFVtJnRLnwXoYc9O1SfeT1vkGY4b/eiie
Vl4jj7+jNkxvsxOGckKnOZOWGHORgTMfZn2tBSb8d2g7EZbUfuWe4UO07tFm9qpU
4ssA1/slhK2vZYx65RRdFIkbqzRzrkJN2P1I3Uiz+YpSaeR848sRUu6r6m3AWktQ
tgQ/t01nVqa1SqjG8viSLbtyfrq4l6uSyZBc3MfketlLx4jmx6/JUA6HTeN0cRk4
kVy0wt96n7/pRG4pU2G+Fuwd+F+QcZsWNFf5LPNQ7q1sOuJKA1T5w4jRI08HEqd1
qhjsb8jQ3MSBr0IEK+ucBoYK2Y8Fl9aSaGGQb62Jdlw3vyh80I2qnjdLPvlDBMbn
NEs+gwEXu/yzolXsHoJuE1BeqFDo+7OSGAtP7UoP608jjVZkz3EIRWkUBlEIWEFj
w8KBIcVSBnOp5qI6vy3rsCYGu5pXXJLAeziawzOAgoxPX/wc0HKciPc0nanAM+0J
RQmFneODYLhT4NvtYbCuiujrYI4TU0t+/Y28jt5WPhg2Y84I69EiZD7UL8jIQh7Q
WR3BvffL3gvaqbv//7dcjx13kauA7kMcxs02CzmFp1cQ63A+vAf2SH0UvyESZEht
G5wdmIFIL7umPNl5la3Q/x0TZlpm+j/+SK3bFaEtDtq6HMtp+2WQRVGDaIgV3IJq
vH1tuIWyAWBLCzXHsV+nmeLCH9hMx+gYyd1yF49yAblnuNXssp6WBilJ9TUb2eTk
fU8mQO1UrUm9B+5AemPtqyi53nErBaFYx3z/GZF7nP9ttNQAZU9mSFhL/HltZ4wB
KpDP/+EfW0VeO+FglPrVXOgY0+wlg6ngcdnqT6tgjfI3Rrdz4kIkj8amHujSp+lZ
iQnprNWbx16GN4aGXW993eEEqmv5dktjk97cfE0Gq774FXMFAw+r1PGIXHmwkFw+
ycNWwVFLzAJejcM1bXmMigjHGDiOsxlfdeeZq5fwc9kyNwdh3EuFF1TLQS9tiId7
RtAyxVZ+fg/sZWUJ9mKK6WDnYNbMrHYJ/wr/tbXV9Uqrjfu9DZkYkMOx0dMR+a0y
ejNka+D+HZfXbqUmOYj6Xvg69zyLlCcmsGp71Y4+3ZLKyluf10DOavNKHb2sE4Zu
lLXq5JfxfIti+ruqeWeVrA/0l9NJWZM46PAc/cWFOwrdUo7yY5lYFJc+e5ViArNL
6hrXtOzvFcA3oFRrghi/ljWExE3f6f0WQ5bYX9mrIRdNXRmQPbrOwXVr1WtPvZJu
M8QrDqd7WmnNO2zLzcD7fwV8C1BAi9JqEeimHScUWCrdJtro0VsKgktx/rCU/Ved
h0RUPLaDQFaE6M/KVAI02muWnj71VAKCcV+6npgEXudb5tyLyDzCtvKeh2ITe0EL
p2gIutTqMifbh7ixkocWFphpV8t0S1qv9O7HFZ3mtBZJ1TEnldElUFiJDxXUKsa8
xC+mc0RbLyAXFQy7uFPhIjA9rrYtxeVJf/TqhzMueSwWJ9uQG3TzX9TbB7u/MRap
XpXDRp/gvNzeJrtdctcfy0a7BhvYJQRcFJwCCdgqZPMErK4qoycgg5WgyCvoL3XU
c3HOqbnCNDUix/EGin+D8m9/E8eGaJsv+yE4nUH9S25WtIWY3+LyYz6iT7ecuTft
R2XuPJ7QXzn4GMEMAk48GSZ0Zf3Z/f3x8hjjtooHGrliyGlOW2JVUhKIahl3F+Zf
NeF1eJCQqFsEkiZOocA7RAxa78osUer+9SuI88reTHkj9UzRKXEU7itzvRnpPWM/
01TmyOEmwTYGI4A9Hmcj224bxdlnEj6ljRJRWUHv0EIhc+ZS2iD0v1rssIgeFGET
64daJmXa2loAyAOCize17PZ+Ob/U0jwT+GK80Id5N2HFIKjOB5/3oETloE+mRTQ3
wxfTN0zIk+YL9tG8CFrs/eDEOBTQMV9fdx7AICo/6aw7GlMQSO+mBzlw4X9kv/d3
NSkdEFxO8VoCm0vM/3WPXMQkYnNL53dKdDLwRECRv/6vFj9xg33+BJuBKY0UPAef
vXoSdcUpXn50HQ1UObzwRfNg5gAK9gz0fkyOYONFdvCpN2vXvlHEvnGYPJY2Vf1D
KjhWJLwoFp+ucSt89lLoyKBCVKEnAZKneObz2n0zttvU53HoReUpfvQ9o3f6w7xf
THR8W8rdeuGjKBAjDUw2XkQHQh40AHoEOX5SRa9ACx8k+Q51Ley/NHAV0+s/kNqW
SXoZ/QrGAXYdRFY+MUEEkg6lGqrSh0TsIHl54hSHH5lPxiIAvq5VaejxAxeZLObG
WTebHJYl8ebXrhaVg7gC8aHpi8sjOepG7DUIRQPiGUJlBg2dq7OWhuzSod4Vtqjo
WNsaUqzljVe5iUP9adHSra/ljygzpt4cw9QMBNGP7/HqQQafUNySmj7k4BDOqOmZ
ziIabJkTqpFBnGs1Ahf1RBHIcMWKM+gzTkqYX3A/UC4mqODbakmSC6J87SG7TdbN
KPO4KR0pgiVHA+Upl1iYfgfdfB2RqXn45zGUpv10wjDWCTgrIiU0cyGzYpZ4YBOF
rgrr3TdmWydGMVXXAmPLXQXvk5qYtJNmwZF6TNaj+8mbqP8zDi5OF2BotW3DVFs/
lnU2ARptlSYbFemk6kv9+T27oFbrdWl/nF5hvzQT6c4E40SueFfSIOYoYJuLo4R0
IxfI6+uITReDmhgallixC0jeipDnsA7/VgbUxoBr7oNwqnahmiakBxc5paJhLKWe
zViGGY4+gT1vSGUJx0PKlddxUWEbVNN7WzZkmpJYNCsdWu4J1yd60ZFuGDinwo8c
bns7W+cjgpfZalXGpwKoJBrTiXgQLuf4Pl7t6xFhHGCrw7pZOH0emUm33sDNbhi+
qzduAv8mjriAH2QFX0za2JU0LZgyjhgatG6GZ4aX+DNLpfJpzz/wITLZxkfgfc3X
0yPSvfWqXQaKyMvSIdoQ/4eU7mGo5uOivOgXiyTRaqb2KcAGZKeYSguiPYeXUOuX
sw+ttQUoTgJspxdSIv9l0obVTtnXPi9NQhZMvEPn/Oxo4ZeZFltmJkO4uPQ1Q7Oi
7WJ68CsKH3c6hwDDsTLayTDfw5sf7Ay6QtVe3xt2fDDpEUDqg3Fcd9NBfuiHzfHs
NXpQNHxPrbjgG8ZEcDdjBUhSaRiIlHw7Bd9rNZnkdb9qRTckVPp3Mp2MV7nu9w5I
rbtVfxnzWcrgikCOpGWdd8ZN7Y28cPe1lUeBjbDwT/K21pvIpwrYqdAOLqEFf63u
O/D3vQeWmFGkpV6z855r6L8oJ84J7soo0AhytW2TcqyqfD1DInPC2fksBuvxwtCc
XYXHbj0ifCrAYyNLaeH2Dg0bGyh+LM2kyVb9HqbwElU9jCpB6a5zIFXP+eU53I3J
gIyATaWlMNHAaaAU/t1dIN8UiuldiSk3UKOterO6u+0NnY7J1Ix53znGxaqjJFol
rm/LyQ7RU9Nwe4OwHcaQkgDoHPZbnXoHlWfzQMS0LVr/U5hmIvpxBgSlQSlVpZgT
/oosN4rax3FfWhzGfTLf5IMbVlubJeV9omCmkjxa2dJnOEYaoZdZIop3OIAmWw9/
1Dv+wkmZfhT7445sLj1PvGNSM+DObSWh26qJ9Eeindzt+R6efC9RE0f9Ptb8jH9z
XmBq6NpjUFSc+7dYOCgGO00nkLa05Sfra8llaTpZhfh5OIhdXnsM+9t3AW/t8hIN
Ey1Adi6DJyAtQvCjOpexC6fkyEmT6ePg9OQe2Ms51q6G4AlAgA9dFxdCNLegt13Z
B5UNcZ3Gipx5S3vRv95TSsgWsWnrCAyD+9m4FEybCODrEgJ+1MtA5jcaPfI1bnRK
kU4wzfuPVBttmW0Tb4GwpNwlASus23nzj4Bzq7Y3EJCdlsltPjEYEnt558rIdSAO
dxa6NBGVcjUjaZeafRk445dCJ1AEwX7yOUa6+ehAWYQK28uRqrhuPSrlN7BBr3FJ
kdaUqQmy0M2enYIr36NZqBAlgiTkmim1mSPnKtTG592VYSiYj26YLs4XZf4iAoBC
v4oRRkAtbEAIWc69t+bMcGtGLYXF4r9PqV0Mb9IYA6qInyOJqe/U69cusT9LF6d8
UwikWRB/sjNyXh8kS2MyKAdXsAfMvSPOZusRRum04FlKEtzBuIrR+cK6+pYeViCN
eOjYc1GbaTH7jJmmxqwH9jROqo5nIQavtMqSD+uauQRjdeKJHxvoYbi1/Ei6RhHJ
jPn+sJQHed0zWYSo+/d8fvrIdYETAPwJIdSa0fPBM0rUTPD5+s9UXq9J9l3pkTlO
w04je8kmoALjz/TkKkjLtXX1ENHHIGCW6A+Qjxpxl9tpy7+9OGmd8wTRXuNbYXWz
0Xwha+skj9ngK4HGYvHBTL/QMcl5d4/OihaltXQSYvNlIIMhKNJ6M8EfIlQHN3V8
Ut2RNUiQZ/eGazCTx5MmAhKGvZ+Hr8VowNIVb3Z4aPs6qUa97fibxIJnHjEhD+/c
tokk+Ztoze1L3LXnB5DGSZ1C6nICxle9NMevpgKEAAGmn6kZBeutcU8sZfyzJCAw
WxcOWYB7VrmD+cJ0akC+p5ydn9wS46ow9rc9axsTVYE9nVZafoM7H6S2J70KvJWE
vlvBAaZ9mzgwPE9LLq/q9gnIDtT8VcWs/W3YjLkkH9MGFhcM/3FkMnG68XFsJIq6
yOKv/Q4XlS+lPgoNy0Rhi20ATej7YNs+JLLF4M0ZM6FWGwaxhqyH9Q9Ov/STUKba
j9NBpXG30xSmo5jUCmXkagYveArsTp0wgiybX6Sbgi+lc14fnooHgq0kXcKq4JXx
p/LJe6jaqePiDdpBF3KAZVJP3dLl04AiZDu09JOTdXqR8RbUldk21hFljKG95F7C
oP25o6uvHij3sTN+ZalebXfTIyvHfWDLEXEXf0rFfdCbcZwiPbTAK920EzqnMglZ
INyX0vzie5lOfRhA5uo/wJTndJF1eOr2myJbHcTze78pqoZAdJeyKQ87EaCA6BG5
2AveGRk6E0bUmWLp8rH0p6QDGLspq6e1I7joIO3bzK9Y2WC1Afy9XaifqZ+ct/VC
D5oKsks0imuClILUVWpJUFgdXZCS+rnMxuA9j6y7tJlmJ1bFhZRM88ZdBz8awaY7
2zScaOZ5h3UzXeLuESN5dDhwlw5c6+SK3Y7l0Ht5njdKB9H1JOHgAW6GAQ+wZrP4
Ve/3dGJSjg12XTM5cxbSFsAI6pW/XkIImUgapBBaZs8OjKgy9Ssuh2kjH0/B2FAl
sKatORdeRyAAp+AY2E8qganr2+LHyaVK8otrVDt4zWTmcqT8o/Zu9O0lSmzBtNLu
FneybPyHEc3vOORV4xcJ5o58NGDXBF4DeqMP/0YvVTTqf+h8fZ7XdBUYz3bMng5d
4NQSCcrXTf5uCeZhrafnnQm5RJXMFx2X4WqKVJLRlWThbqk0JixgzvVr2YWQk5Z5
U5wWKldLSeRgBawjuFgZDNW2yynFnyppqRNZj8zAj6zRu6WBqXoHaknUt31WABoy
PacKrtsGVgkaxQ1VpbDV/xOJRzU3SYlJx2Wy3KTOOLd/XwDEUdrCBl4HtvoKjUoa
IwXicO5dY5sPT2SdzfYdcunkqlupT/GO0dBfNEH+hys2Gl0Au+/kiyeDgPwCKC+I
T4gL3MmZTMkRNZa1enYR/w6K4+jr+venYTx6jstGoN+8l089FqfPi/NgC3QxngNu
r+DOotVetszaWtSuiiPgAiYkD9XjVR4uwFE61gW+Xf2j0CjAuc9i6VEhdQMP3Y3t
WS+owykoGhjtpXgxhOmUllNZtT4RbagWLvrTBbn66/AQjoJscA3muK1bPz3yA5pE
0T64o3p9AQ3THLR3dYkR/SFa33ti3jDFqYxBbQg18UsrNOsbjMfMdklu/ACg7Izd
/SrHUr18+s1oywpJLQmQwapyx1X+OfZzuI+wGDW84Hi8uSDIqztv3lObgiBfYgqZ
GGe5cfe4nmy9KCSt6DKZGO+1dARvkmdBSStYYyf4qya+y0PnJKGDZwWynTSoGdkI
VFAW8Z7wL+4HQSYEHxELF6Yrb8LkezF6iLYPenBCQUOfEEgyTptikaWzSGJXGtk8
ze2IVxr/1mQudhfJGYe5ygV15PJMAViLoDgPAQSFcQ2mDrDF6aRdqTED4h0izKG5
kw8G8TelSny3LEbziB9TXAsBUVK5Ryjtc0ecChsV77u+kAEZ00K3Ll2LNyLYMWEl
2979F1eVT8tV+JVojUBxUA9vFmPMaESZxaM2+/9Qj706e4Rp139GGCrIzCbV+Hs6
syB31q2bQZjnHqLs5FTvYnRSDFFrV3dFX+QftpG2MrNeEHpP1D+tfgPPS47HvvCr
lpX2PaJfyZIMbVV1v2yXqYjxtRjtYNqrL7tm3KU1Kz8CFhoDV/WmLsXwUlLZ3Cu/
LB+PYChOCNpqQV3cgp8a8Ox6uqCtBcmd6a+sRhqJQAIu66L3r9sNehbplO+E1Vr/
bNHlfK0f6b+0xBGvAbF+Lz0+B9AK9s+pKDrqRnIAkNWOnP8lVqvZ4SYr2xMTMfmB
MDD88Am1usv45BpaMr7wH00ocvxWIrK3lAqi5nIFC9iR5DcvTL3r7hKlPGsJ83LV
gXs51MRBtgY7gVrZrDCV7UJSsNPlNlW0r5oHLOMksO8YTr3KLyOJkYoWkdfQRgKY
+JDC/qqja8Lrz5u6MDTifdhJ3/Vaoc7UHkJ97AV6ltAGg8FVHnP9H/lh47D/vETp
3r8ggEeg/aMPDjmvUmuPIh2KAdyCkpMfSuem8hP0yeL/rWhvD5bt8KzTqyBRvRl/
ekML+KcuZJQAUWolVDh3T1DdYBUyNGSnMO+NFRp+uJ044p0IOL4zcq2LnUkUFub0
ZwoQRFGVAcyruJl2l5fJtuqHAyHjbyVpW91v5s7DOJRiI/UK1j01tV5mVIPzEvgc
rBcUhzKQYL4KxE4oW6PxvfbK9ZT2zZgHXRjR4wko1myNZF7umvPnxEj63Wya4gtP
oDRyIDbwPCgGvBMVqfNR/Qgo9mprG2ThCd6Hyij1U11q/AAVyIKi1qr90Jsb92YE
xmcXMLxmcDSGhN1UncQ2y8FL+r32nAm4PiLhyCl4oMjWzm1kAWfJUD5JMeunXnQu
MSAUTpJ3QkNLUHwokMWXWVr7OdOH2Ck8lBDv5nC1tYErAoxB+u23j+voPt347tgd
YWotGyaY0qqumDevdddvIHu0a8KA3nYxO0+DMW73PnMGiPkFGnIDFFvwD12RDOF5
ufdtZFnBcDaTS8NN9wE8ej9YyRU2YlvGbE2IffROanCQwD4ZfoUGDRx6PrFlOlHq
JjmmKr6CbSThvxeNsqxmo3wiCrBGLs03tMlxMAn1IXK7hVw9PARafwnqA5wjq+Qt
Lm4PnnfUZgYZbcmrQSDH+HYW0e1HiWuzbsL0KLe+vDcnIKuMC3vHS609HonL/Hd1
xV4Up/EtpV8w/BXMw0rjF0I2fdwSWULaRKTru4PdKvop1zof4fCnf9bF/EgDQUyS
mQTAkQ9rcGdIAPCIgCruzxO+tOAzyKRfGswACrVClcX3I1z0FuAofOtInVAt+Yl8
t+ObxJD4c8fSS8owSF3KE1IOGm5aMKqbEtqB5BnGnLZfF1hwFeg2klzdf0MJIUlb
VWQTmSR/Ku8XcaasRSysSxXNPfvpyjRz5d58FfueEODrtajOzmdOZgs+Ybn1dNgy
/GUgC4UBsP1wUUJAKnz1EcX7uHaI+xQ+7U67vEgdf/oYqANUSugDNu0PzYade0yv
QiBZ2dgxN1Ev2JFFOOPTz1VzzG6hVkhzTQqDffMqeaETRBnEMG/ifIBBXNDmxOaQ
SBex7Ci1/Lue4VxIl8ijTICVcX6z2pN10n/tWNEpiZJsggjdmkmLWV9k+MWqTO4E
y5+GB/E4JIjsNRwRa8hGTisfH3az40kKnNsDtDRK2w2hfPYifthA0vvjN2fqg9u2
CbGXbZTuwlPH/CWkDwrWKBNQ9bEcydR3mWE0NsbbulSNo8QOgz/3KLrNNbbPg93F
FLmylEkWYBQDj3bBqPkw64CkTMXm8M8pqtvoMR/l4nrBF2COVqpHa/9yklo3NZqU
l8xDRKCsPckFpr1+PTEenAhM6GT37p+Ve+bNMkRfgfKYj+1lC75hlTLA41dNsjBx
355T2hkVq896XsOXbMJSEWHT7XBQ/mkXd6y6cV3DkkbvXhd8y1hO8DE07CZikFl9
CmCtYsyqeiLeLUFLaVgSlN/NTpbOMLzGeiAG1bGNAIm3G2aHBeToKXsrG7Ei4jW5
TMY3UVVRA9QYbrdTqPm+NC1IfLu1ATIfVO723rFe194/sEIfonRU4zS+ZidEcmmf
NAnyXfPEmx4YY9PZY8f68QPbwxiyfmxne6W/GIsHpYgjG825Tq6T75dBHc+tB1Fy
SL6sDEAvM48rMoH2FfpM14URmuQhD4KhCZo8fMYzagdDW0JALbXrtK6+TvWGAhOE
MucJieIbSg0Vv52YUpMgwhUPJCU6GxMwqQcDNuUdegsa2C86b+nLX+VrNth1+9OB
+OEJEWir1JtDr/WCmBFl2fCAfXyK8vevDfCQ6/0JEO2HmuENuyHC6lsWOIoUiUlv
x0Y8vTkphdNL5xHgAwQ/09Bydd8q6uiU/JzRVhWpBJo/w5CgRPm3xjGp4mTPLn/c
j/0o89NYvk3NL68TIorklg/et1eO2g4Ymt/uosYywKEMN9sq+1wVvQ0SzbSObY/9
CSgyT2ash5t2Cl7T9H6Xy079DAzi5wlmJmSXdb7iLj6+tYcnzYWjrGkrz/mxUOdV
c/tEZksy4jX+xCc7oIqQSp2wWNRcj1Mo+rU+0g4DKunNo7dMB+yM8d960LSNJFGe
X7wnG35AjKnUZK6jo2Mk70GG1i+V4iPRDwKUcLzzECh/rDTGROsAwxznUXVDOoPm
XoUNXwW9uiqQpJYuLFlQHuP8bQY4V75teESxcBlNplfY4Hi0bOO9TDi3Xp3V8sCr
K8gs8SFePEtmnxaYgXrOt4HcBwsK/fkNESSyZ46nlqIYE4pb6JzKsEEJne5pFBnP
K9EuHRSTCw78drBFCDrbGw2A/z2YGvz07Sv4ZvqlpObWkaSxbw3v9eMumpylT7oG
tGonf8ZZ1wA2axg2CGG3NiSOu00N+FVmkWHQiUh9EaOntj2+94VPf89AlM15W7h4
eQ+yP0G+7qya4FWjb7Mr1qa7+iO3n5Pj3/NnMZNWycY10yMg7iKvW8T9JQtm/CoN
Bt2MZpY5ePGwTc0jlc3ernXP3TKH1endmxSGdsallIJt0Al7Ge9GqqmzOvK6+Yv+
1tbvq8XNInxE0ridAUyAM8Zv4+XqR0QKY3Ei8c6nIQx95MEmUox5mB3069b1U5mu
3MpOTRYIyNX3XBik/J9yrxo+APJ/LX6WMS7D5ebOIXQkNB0n2JD2O8lPHD+brw06
kEll48Bj6gxU5wk/V+KWxfNljLbo99FAFkcsGO4IonzTHvbZe/Gez/ZfhpWnW0sQ
r6v8nL/6neLnrcYCJZZ14O4kYIEo1TVr6OgEUbWmu5J2+ktdoY8ums03ti3AzdCg
TtkaFawi4VxP0zS4EsJXn1Kzv4/5+XSM7QyhY/306ssNWWoXI4X/W5v9jYKDefKD
0vLOMWX3I1+/3j0odwksOK7v5WvQaVvlZR8T+1F3jlydlQXljchH28iO/owgM0mB
iqGtKCeCFi7kSqX6uOWdfzcGc9f+iFBLGHovFMSAw6/ZTb6y7+utWctdQgoDrQmg
wFppFizenpoIc5B/tec8xkqI7NDcbSr23y2tRhF2T7E8MFg3ghPoBdxkY1lmRsj7
tRf+wBhbVP4Mxenk3cbjsWPAqqklcym9x5mHHtxhQEdmDShRYldjXzkDpC2yYYgr
ZxWoh6H/WKB8p4zMNIllHetPTOiaCUC+VXVF4VBh7njyDDrtGszADklRTuKT+Fzd
d/vJoNIT6E7fTEROsAMKeJHbKPQLfbR+LGAydsgwC9ah5LYOlmEon6SyaLuueQGz
PjPObsjXcEMx0VPe+o1j5ouRwCwesm9t6qcTtRcwSc2csN63CdH7wKbKRpPaJe2F
Nzj4y0Bexkn7ZLmcilzRLNypgNBk7RbwjGWN66dd1xfS7SC84S+CV+9TaVi+7TOM
7lPHNgtkVRek+ZDrfargBjaAEriJRoW4bz46sN0EYyAjUE7jTYrEVqxQnubnv4Qs
NQnCyYSES2Hhu5K1QFvVdWKq/Mvu+TGMXfsnQLy5Q7HKgnT3pESN7AggwJc0R9sN
UzRh7wrLl3Dh9jtYTpIZbmQ2YuTp4ehb5UamJM7lv+o6avrgXuGh5H4DVVbixFae
CK4TKq8o7f3dI9cnrWHuRjg3sIKJnj6VplyMZA+xzx+syipSQFSZqcXnXkzI5yk6
iHz0Hb/97RIoI2lnr1fcoBepTsHh5QCdZV0eGef3RbLCj+QoaRid+2HvJ+iYkBZJ
Yw1+LzCFXEtb7Cg8eVo5qmhVMpz1yJE3OJ13SB+zGfeh0XvHok4GP7vrBhU34ueX
X+YM/IquEJixGhy44yB3+QMTktBqK0uyzY+JG4VJHL/5di8U7zpA2KA8MUVe4KTm
6meEn5NcTBAAvE9+Jbu+9gaJTaKMKMCTEIU0LLvyG1Rp/xryWHgARZwuCsaS6WEd
Ivd+cY3Bwhkc4cFs5CYK//RuQsWMoIYrtoMF2NcG5RZRiBcMU+9m68kY/Til0nAN
LWl6yndToIu0j2jgLwq+cRWI6ndkRpW3YNqSCVq6rsws6By7fWhEs46kuJGnf4pP
49CUhb2u3OByhpgFZRQ+QyV+5t76YN4r4hHprZn3p9FREfZNS0d2L++P68h7vidJ
NtC8e4EHgOnU+WcDUeYS4LVdjAM/wbsrHmMTIwnJ2VyuF9GxE9fXj0qQR7fh8oGR
YbXA8snyFQfcpei/JwZFKtYVYBCncF0QEzeaHVpOZAKzbZrwDZk3kUJqAYStKRJd
Qr7ivymKNQRKlJnbM+F612xqJ2iAWKrzRiCz7pP81/pVRECB9GML9fffX5jADPOz
cvN8HydVV/B+ZaBA4wiFplCQYOTm9beRLJeb236O5zmCwgNkOKz9E2LqytJHE9be
bTYq3upbPDkcDj1w1MJfrzMSO3ggZl03wYoeXmyaWrh33AxDYSc3aSC71LeQX20F
zEttWTt0spy0tV8EMCe9xA3gNxXsxCBO3/lAfPU8WNXMiTRU2rP6c0xlp2WbAG/I
WtfiWwRcGASGRpujt4y54NhFQPlSCcjIrE/HZOI2SXap8JH3Djg+vh2xDeby1/Ix
uApQGU4F072SLAs1UQiO6D9h7NmMFolYrtRXehmAjyhlIZdP3EPSk6+MXd4yiRiA
5LAi84VzDHAjrjju/vvdBV7PgpYsh+saW9aBB5qEvi/Bncj17ysSDLvuWBql6XnM
om18rL6R9PYF2g/N0PZjktMO2Y4Dk82wWOT7CZ8/3WfLsMDiIofomAdUBqun8/A2
scFJ6nwxRK9TIZx463QtZWVOUoWX5bPT5AcbzCWaHRr0HpsBXbKWpQx+67OsKGmf
ModGbPrl1cWWitKA0ObYrecRtkdSSoYdkQAg46k3sjbBtMObycvUQ5tW9dwFnX2t
x2S1e9bbGJfSnLKwJoaPlPw8sUQnZhDOIBxgrQSy88zyHLx9IP1vyOg8JPL297IL
NW36niuAPrH0rSsBb1KAB+oUwZlrMSchPf0tey/FPPoXZBBPSEXzI6zRTdOdosuO
CxBM+PdTLBQnC/olCLm9zPaxsLtK/LXkudmx6c4Fq1cE+RodJOYylDNKksiu87R2
HRvvwILoFSu1QMC7L+i8Wi5i0MNYUrJDV7YfFbq8WIicN0/1ZjWov54I1wQSgcgt
Q1iRPqiig720h+eLmGoLKNvCwj1vF4JtSdEAwSBwQ7nmpiLCrK6siGHf9N0sE7Ub
x3GDhifq30WSlF6xNbrEwGXD9Mkj3u3wHSGOsKZ6l744Pe5UCmaU1WNDBRqGZA/2
cVvBr1GwvOFfJkPEbWLYAqEiTyP4t7zyJkbQCmOxquAkrEMfoaXJMMYmrUMxNdzi
xJ00lXvfNXmvGHqXa3YACL4pg8KIr9k6e+oXvY1o0wvePRZcHwI8C49l2wNPritu
UpQkGwHfZeV13gLiQ4+CfTM2d+umXjWHeOswud3kJa6Q47VWH9SJuFfvGMQJaCdi
VgeHXvbf0ADG+iIZTD/lhXLo/+p1zhUK6dI9ROpGW9TmLs9aq4mUDs/6jjSW6Ot5
nqQyMAEtHMa4GZ+bunX15x1RurWfrwl689IF2+vNZpVvw0aWb5RgD94vmJjO25p6
+d9SAtcbyge7Zpz8PvoatTkS53BATeLBqVip2BWaANQNSHZVek+5Q1Z0FUeNTChC
y5Jgmha2duWpRqRNCKfwel/UN6OCGtSw9WwJ/d8HIMJ+8DnIGxTe6mh4SSf7dS/g
omDSgrIXf7rJcwzN68Z9r1spNzd94cWeKDRvk35HqOkg8CBHzuOTVc6Pn7dn+kcs
pMVvzRnYbj89gmArDbqEBE7VteyUzbi80ts/Fly4aYmw544ATqSRcJrzW8MlWw65
x3RS/dTWNSGrFbHBziyRGXxQc/CuIbqvr1aI9mXzuMM6MBAuJYNQHoeMQS6ZZk3w
zmlA6oOlSBOjza3VunKJ+4RLVRy6osqjD9Y0TsPRaCjLwz3ZYw/A2siL/LrWTlfm
yfu/FbxleZEIB4Euhw7GAQDShU0HgJYqou0UswwiaOJTcM3nykx+TH87qvgqLlZd
gxTDxxqlIxpX62YsvnP9Bq+/aowqBv4LD6zdkb+bvs4X3SmA5DqxkitKpvapoLvG
O0DVInP1H3CtXUzm1OLRmJGXzhPh/hit8XmpJ/v1rOp67CH6ilbQUOnfhRc3T8B6
gR5PhhZQHF1dziPQZhUFdzXJfjC4s8EGsdXrtnG2umuGBo+X5xQ1tWMC+4AX+SAF
/Qoqc1da5sVtNwed/wzH2ocWdlmnwS4xW7t9zFIbYGS51u0b7Gb3+ZOdu7wtEh0e
ycrdYa4lZkqnTaguhazpwhDDQc7FtMBmG74NqG3jMTDzk2ItIZTQAXYJRagegtd5
2UP184XjAYNe6vIyVLn1S47vwiv2LtxGb60ZCbXhSNCDuSAgF6LL8iEUjmGFRxj2
5RMfuf2FU5nwDw/9S3r/TdkZHUD7HZggyaHWCDM7m5NztftDYjOwuTZW4hgNKAa3
L0mcPen+AEeDe0h8cMTOmMG8N0dZvNIeVkF8trWK0218huWqdsK0exFox6KXrBYY
VKeaFK2SuiU+IuxiEVNGB2ll1xN9q9qplsNvfQ0f5t59vDfeS9Qk1JLSPAhUPEiP
uLeaiN7Z2RVnM46qc1ew8A9HnPHbDVkz+jLTPSuhvPSpzJg9nO4mdPlxGex9w4rX
/j0xCIKc+oOmjntAaQO/hzkq/V6NJByqWV8bPErC2gaOG2p+PDxh3vpxNdHOYCM0
sSlFeiZ+ilNFGtvEa7kjwwi4n0s+U5JCLSOgGZ5XuCFHA0GotKtLLpbNm8ilcdGs
KwcShPSXzBqBJl+X8Kt5qoi1DDxOYNqS4dWjSr2jKHqmvLIBxLIlzYr/SmuiUkeY
DVpr4mfR9kilfPtNT3L6aSA/T47a+xPWnbyXB6WdOF6VV8ULX4wH0q27gJOY7PGq
tnoEIf9SlguOMRK98mmmlt3MPJNowlpI/kZ7OpPi/ETYO39Jjinm91JVW6UO++1H
DlXd2BZDs1pQYg1MZ8GnP3/eUSY/Oh3o8TAOcPfoKeoAC+DrYPP9FCUvRHZsbMVy
Ke9JsyDpA+60iqQJMs6yh3vOFI6ElMv09ASOS8rZK2ZznQY0ww6CrbEoZPQ659dd
d628WZ/hsgziJhzIfUPIPuI0NwacB1EwR8aWVxVoDltPBdwC5Ib96nchMO8rh1J8
HxTZfBD7CByAyAVvQZWObaFIv3q4vMBfHRxaOEAeXdTjTVM1JyCHHiWGyNHMYNyY
aw7Wa8LRqgM6k3tE6wMT/MSXPAQehl8clctryhYaTqhc835IB/NY+eq0V+w+xBgt
tmnK1AiGoJUOStWRXFYiXAhgu8m0eFROHikmWA3GbOx0zfbHyKX5FkkBZZ96al+h
/E0XLG+dw1cqBaDF59vU8ERc3gtgQ5L9uCxKWcQqxYLQcsyhHghKDpEHqUp+ezB5
61svSrAWDRqC60KhJ81ZF8/ljReepkPiyFQ3BQ23et9y+/E9JVeUZF+BbTw5t/r8
toYqGjXg49CbWEuEci8NYrQ7O2r4pAkSuKfDVDkIuPWZsGwWj9pfTauFnoraJD0F
ohEH3F3n0UmMmli9r5mWIX/U222wKNUcCv98BpjQVJ74hCBKcDWNmQsF2vbwOd8O
pUcdUlYX9aczlVFuMGTJbwvyD+YLvwlGFyMR36WEIRTWCTdwao1kQNMp7M27fTIu
SZhw6T3YWdSEzyU8PjvwqiAzfOmvcK9Az5LFHeoogdBsxRuHrqsw/wxf04R0hA+3
Feee6+MTDCKZHblGZ/guqu+G7hNKhIu6kyQh4FcKkcwqJ/CtGS3JhJcuCvSCYbUd
NorsA+Fci9ZWL875kOw9Nu/6fUwLJPw8k6JaxBZnZcq7O6WWbDT9Cm4NmEEQ2OSs
z2IK1zDZh9Us4ITcsn4MDAdx1A4SfqvyTBqOb6Wu0lMDAXIk9Aenvq7Z06eJDm1U
rel3Q1IP+kI3byQdOpMSzxjYE7R2YgDl0hpj/UNusd47+I6TNGqRkhrWX877Xi6K
LbosAlmmUQRoAcJ/VfYvMK1+RyWAB60mx89L5tNoIAZxfuCcVpSa4mAyJQfekIMu
MIHVBXXL8ccAIvSZiKme5lVyq8o+rFPMN2An4C/MtFhfExJpv3pCNFSAw9wsuLaW
AiclmlXDYZ7yuPqNVjof86qg8hceH49/KK6b+o2i2p1B8Qh+Q3VVF9EvnpANfRYC
/xAwS3ntrK66PH1uvuSN4byIEWUlFmOOAZhHKrp9wd7oFQXMWUjGGiVc4FkUrzcr
KK4qEN3gMiloQqwtGFqwB3AeoifiLAcr6o0jDMG2uGKxz4+a0q3+dJHkQ8J68UDj
J5vYU8sN5o8A8RWaQJgduavcUainV/KKpFe9y7Uq27W0GBtTIBRJA8a6DfDMydYF
wAQ1ccn4ZAigl21+83MSeJY/71RZHcus8kScoiaK7/aBvT23SLqD2KNZ8tgBrRcc
cMDoexSqZn21AMRIb5hl6MKc61g+VP45L1Iw/6EUvC/0Y2d4j6qaHWeyaTTAluyy
jKVyhWRXmi0HYe+3GwG+9qXRisNRSyqTrWyey4ax62llAhkSKG1z6M9EZjDrEGpt
KBxzVP2pwgKQESO3CCcs09Xdgz2jakmhWa7nJMtb849WHhu8RLOvxPEpoVSpQDdE
VSiJpRI2RKAYTbZTHUQ2UZjpiE1MkpXEoY4USzjdI4CJ+c4P3fOjhwz+v5i/pO2f
S6JzXxNK1injauNkG/MrlFddAr7RVvafVvMIt5Qbh5UEpawcnxPDAamac5L2kQe5
CWEjdAQvSM1nvI3vxJaOovi/QlelfVTMbb6tQ5G1drSV9axJUl5wHOgM19Qyyv21
IqEiFbdvGRCeZ4ju/ptos/RJE8kIKtwgsGe06q11olBwSmt+1OemBxIezux9ASOr
oLfsrWCLto5X7vHghTXsGVvAiY5l8cy9WRAfQL+SbV+4UU0CD4MUCvMsIagzaPRJ
p0vtdbRrs84wWm1IySCcl47484YF+Y20FkG6fdHmW+cy3f36XUIf5l17XL2WL94f
b+OCSrns40scU0s8mUqQ/RZa6GFS9XDQX59Lh2kpDjtIjK4Vw+FNLu7g3whxN8IR
NVdnW9/oKPkHtXUZX8+G6ZdsJU8I7w5dETNXV5XzhPpwGp/zUiLFr7AhvG5X3AOQ
GKhOa3iE7zjOCcq/1/KbVtGGPLJzIR04fqhS4u7rztQxJc21zuCXdi8ogK+y0ueS
tSfStzYEU7uXhHGVWb99SPZBE8YI9oiwhz4HzHf0w7PYSd9kNsVQT6NRZhLUyNo7
yuChNbGeHlSP1xiYyaSiix+ocbG3/DXZHa8mTzn0PYW3A/hRc/Tro9TXoyPl7xFq
4irKkU7dTNGp8+3rINETi4m0ls3cyqsmbAanBlKn/8cOGNYp4qibSm7DzRQQp5r7
0fO3ROF/o/2UFyckDqzYInHTuA0uBT4eQB5Fcsjf4Hv8xbhK6jkCgBhdEiwDezwO
jSO5vgAAGQdCpF/RQfAcn6cnnumx2C6psrqbAIOGHBM3DWX5btBarRCvbQ0/qYgb
a086y9myeldYqbeFBqpAnBvw2D6O7lbWXkYVKB1+v0g8+06ZWtEzTL0AsKbrJKcs
qGE/PwKkCzMguO0GfliTJKVwE52h5rf8a4IIg940t243WUJd9O+H+F8copm2CjsZ
dI6ghbVx6AYaFo1gVnedGIExAowwJe1XxaCqBUreEObch3TPt6axH+BgHe1gcpvc
cDWLcyafK+SRTAN49Iyp4MQdpG0N52TieWz3IuN9pi2vUUBGmpaRQOLVT0K3+RyB
zMxE+lDYWoJCjFwWw5RRy9vzs+A8UJAYyZehIu5ZzzrClI98q4snddyi9SEArACB
jokoXXG7NMl2+1pUFEcL4eGb2ENMnutaL5Sh/TTyuCIwYKhFk9rBNgYtSJutM2WH
BqUC/6gKgTIiFFHw037fZMftil7eyy8bxbOteSkisimlEOHeNN8tnqE7QIlcszMR
DvSWswM/zlOeI+NOlClE83OH9WlT9tLLyCkVnvMdLffW9kgtdqGQcmhMCGk/BKrg
M+v8L28zAZP1aKbPfz2ZHJCJbNSO5CPa5CaGpQGQeljWnzIbQjRASQ4o/rHN/CvO
u1grwU6UpFAF2D1LJo5F2kqX35Dm9HTq7o7aLmXnn3+1LxSGPkQLZm5uX3EsJnj2
AM00mV/Ex0lQVUgqWkTxHxipI4z9zCjcvM89eCgCAJvdmA9ZUxAFLdE2cT3H7ZyN
Pu5YSMrUGe6VkYJqXpysb/mJmqAru10+76+hBf/4ugCjMbZoKjaLGRTw4AQ3ZYxi
5mKbLGFNvzy+7s8FGy31ntY67aXKkl5Qf9U6K+bk1/G0fQfjg3aGY9vdsc5cJb/Q
+Invp1FkDAT5TNuCG5QdNWsImWrx0J/nZcyba4NC3OoB0mN8wpDNL2iUfL0bAKki
ptAAMXiy3lVD2cBS+OWk3rOf9rvY68Apj+5jf0OrjWTUoUY/uddPrjVwEce9fvpL
MgMaX6LRQFSTbHW9O7KEjrHUME/CmkScdBMZj4hFqaufkQu5uiBgBRA8B7IC7uJ2
jyKh/JvT0FCu0oOV8sNxObesGS7JrsLHCAwaBblaujqea9Xef/PB5k00Uhwnl+cd
s8l0DQ60CfU1sI58dbodC80B9Lc9vhGev1+d0RZVq6mZ7P8bGSeGsitEElU8kFTb
K/Qmk36uHiWGKR0/VABG1FxtCqg02EHDGrBhV6R7gVFt6xyF5cgTiy3R9i6XZG4d
dYto55OLliPoJK8rQCOO/7qm448INhxIXPP35RMxsGX+21kza8AsguEC0ufG3INg
63kk21QERvJoEStNDRGkRPzMIQIJWU6RtI/82LyOWpfnYaKghjqihYrwWFbK4n31
ciUMVPoagqgV/XW5qUJlo96Zcn2NjO2uuZiG60vuGZZlUUzISRSKHk1OvNVykKGK
+9KR0qNbg52a9tS5QTLd0txR+fw+l04vvsCeL3GgF/xn0PXXOmniDrNmJn6xDDiA
VXSTGC15VeeNFKaUYmhLQRd+xZhEdkTY6iqsB380x5n2HpMHeDoQuQFC2IhSZmIE
qlZczgXrizzXeUvEv/8VvMWyzrvvEIi4eIYTxuN4H08yn4GmAF8bLOEX1qVSMTX8
Meo39dOoGqCQOrWOelfSS1dMu+lF6nETkR5oXRN/zSjkTXtwjSTnLe4xiaWcEsqr
IM54gYWqGxv8sHkNxnukOl18VuwSfFB89uIJD0unmejvarmzhG1SedP05ixy4eHA
mjLOz3CN0b1PnsOwhUBbHRZ7eZqDB+yek1GdEJO60swXy8i3LWBEaKTKg+w6viLx
icFYNau9HDffZOV7j4tOJYQA3riX4IktLZFMyf1bUyRwqlhkmuZzupMwSiAIyIkd
qHGkKoeV+9uIwS3t7fBgzYAIlG03WmIhRN9+Cqua5flqUS1bmMxwx7ZCloUC/IO3
mgbqGCnHG/mDo6p1/q9JJcUhTImTOjOM3v0ONGiyq9pLYVZeRlyTmOaLQy1+Juyb
scOACRZRuQU9Yzmd21XLJZeuqSllSxAwAAt8YoZqIbzwz7ajeKbIZORRCcktvOzM
fpZxsHKHhV3yKownxF3EYMR3lYXcoNvJtCPbptAefggD5rXrS+yBAvFNJfly0Efu
brKmDCvIZwfoIMwleEs7BMvUbL1+GpKU4QMP7VXeQRkY+tsrAv1sMkUZYFr7AKIB
6iV7N45Z9md5a6sJsDJKK7gPXgfG/z+UDSAWCjkavcKFGhpI2THgrO1/03fEqAQO
A6ouiu/3FPUWJGRWbpmYHsIMcM3vtgcxkQafOQsYhytFz7ZhsZqWCuV2/c5zLpy2
9KvejMMbArtP4ROZmDFjSJP6Sj6S4IYdy3xWT2ciUBVkbaz7H3T/6qgvO5pr8jrm
y17sOb1zybgRwZCpfWGJgXH0pnxHM0jX0i7R5qrapEbY9alQOVnfII/jdGniCCCZ
8bzlrX2QSjyFYk86RAF362Hix3DZhglLjmSQRZIbuhjTxkkxVqOh8V7e22Exbzbo
n1SBuffXtEBAeQmVO4vjSDEP5ar6xqkJMZAGaOQDr0lYpguh418t/kmA0IzKPCAj
C1RSSHks57GlGsk8n4x8kQx+CZ3iZqLKwIM5u5nrh3fVzitM8FWviCBh12IX9XBn
aCsRJ+tCRk7DNdFprMxDUPB2mKHLGEgHgmxQwLsx/TouNjLllnOdNLO55PV/muM7
Cc0+K3heVdtreJHOaqZwu14VLei/ghCZz23jWtodcSH6s2nsfbDBnJiDO9H31agG
rMs8IALw97jY8MJ8Rx2rT26acOzeZuqTKDsh7aBDfW057GKEqzvwporYhkokJ1y2
O3CtDzLRCJvNV6H9tFqQcQHq94FuIXrRlF61tsEm4YCdxBEG1eosPnPjOBdyK90G
fbQImh2x11QRDgkg4IoKzAI/ayRTKxOfCK7lfKcx5ZWB+R7QGe7BLdpm0Vas1it7
wFqZtgT4a3+v4KnJbpBoxiF5xYkTHVE6Z0hj07mxLgHv5ITHtwzsfgR8EZCHqNsY
gHEhOWHM4+FyXJ092cC1w9emy89vHIuezrPkvW5aU20EsTVGscgqPmuC6mVPy7QW
o8J704rxIz67ktanIB/YeV5QXNWbRBS/LVKqyzZ7ghleiT8PW/wSyRumjTlrtjMG
j4l6uUtfhZU7uClAj1HpOzrJwYQC/0/mHllgNJwlByJ2Amht8SqkZmNTvvLZ1/O4
sNqt7EQMY+GDLklQ7qy1gIqncQ8Xu3B07F+pljwC1vRvrMAlURll0FSB9jiSgrMf
h82HNMikGl+1v7DncH2p/gbAy7i01ChKHjZoMEluFDl3p8DCWHnc4LydRKSD18L7
RXOBdBt1brfdYjC5DuHs54F9hhv0DkQ0EL3DUhdjk0OxQDgHxv2FEQDHFHuReApB
HDOr1QBG2mpdQA8g+j8Eg5pJ0l/cpF9Q+PJj+tM10V0HeNCrmcuoUlfqZLQpJKXJ
ryl0rWR+B3HnBZZSvtn2YDKb+FEWjrY8MGzekVi9HAUo2F/0dxF6CG5Vfjti5iTJ
EodqXjfJx/y7kQ0acgeOWmW1V3OUs4GhETldw6HTlcI3GiRze1S8GWAsuIl65Wy3
k5qoZGhkJPxhZUzkgw9dV4a5lh/BgA27l3/1cOylciLvbWy8AvQqzIbHo9ASX5yP
ntp+LPe3zrWJGt3xlzDVRe3ztX14/NOKmPXN9oEN8X1HaPBpzYT2zeU7YUpis5Ne
30yGGnkQd2n2uxLOtkr3pqWXDn+WOoLuI9ZIxYifOhQjsc5IUrNweHJE4DsUw7Dd
9q8pVGCPXJvdfMgkkcApbstN3iBqMGoDnWi0/jdjrRwhEB3sjbD9eU2L3d++mD9A
dXt9z0XlqSRMZhLQKWjsVDk/3SIwOfqEHkiPy6i2EDJYf/BSmQePRQM+vDsMPm/r
AOBJgKxuShpHw3D012kMwUjI29E/rAnRW9KwGsKP5cknN1VZD6AQrdDVZbUk3xJ8
Ymu6C1vKj9Uk3EXCY7IdUAMEraK9X50EZDXPte2t2B5kZ7jLVyBMr3b1wWrHYc8l
Qy6mFQ+vS6ducfqadzQXRUEonJLiM6Y2/nu3Lgap+JngqXwBsY0e1gqqiYglSVtt
cwjlnb72dU8mNN5UgPsNgTOJN6Rvs2x1g/UsKb96GQN6YgUm3RTjpjUiCVxnyyO5
SWhz3FLhcownXmzKEXs/9UKMAcIZRImwPHd5kBGLO5rA60BVePQRqatZ4/6/W9uL
/qzSSjC4HzIciMUY9tc0jSxvG09SaUeuZ0T9GLdgRCs7XWbc/u1PqM55uAc/d/QW
8zT+wxlw1pNiyiRBEc/STt2gICKpiBLIvxjjE0Jb7FQpLLvtXj39VoiIhYJ5Dp4M
W4T+GsCS2lkaYd0R1Lmnhe8fY2xxz8/LZGvsMwetwYLPx4ZgRPF5dJW2NsQ0SMFb
+/JLmpMoswP+n78EZjzaHxrOcvraFIezQ/Ux+6WVaWCce5e/h3ZgNLQoHp1dMfbE
PIfcHejv+PyNmHhlkH1emMCcY1DizNs/RTfyAgi7oQS2K5FKSebD8HLyx7F6PQyt
S3gTGhSqm2fveXvGM0IoCJ3asS/U97pwGSavUUjGxn/vjr435jN+j/PJwMB8C+ci
I8G8jjypNUFhMEu3wYStO8LGOeZpNjuVKDgzc6sJwzRYIEumXA5sRYM6H5JG25As
CysdbeqJAJDUkvSi6CPzf8XwmokzZG2yxCEz5hQDKeJpDf1yofkvU+WK5jdD+cS9
1rWpq8dgk618dyQ71Eqs4v+Q0uP2uEFTUc1Attd/pw2mDJPSM2OyqfJ9lAPiw1wH
lHnzyH8yfxvFA8mCiiSrDzxbjdzWzpFEQ75+oZLeVoBa+mTJx+J2U/8ooBxLEDWI
5dda7XDYnESEGidgPNoxqkNJea9lGNvkO/PqIHCoJxn/G8W+ikBBDJvTLNJNde/e
uDnY/dOw4qZGGfQSqi41C/+7mbyG/as/fBJd1mfcfW1SCQ2bS8RIcwPOkDOibXJe
uqttQZEdpe6+PDvXSYMNHB0kjAZZwSwKcuDDUe0Q2uUggQcP0dsYjOHj5CmfLrac
fP4GwR2ZyrGsGO6q6C8AO2QHeqVUA0x5W3JWN/v0McHWKkPZ4AvbF7jUBg0GX6JF
ANebWKHwpHnuE2CyHv94+JMe6y0qipsWKD2ONuTgnC9qq/bXNwqfg0gyUqIZJVWH
GJu/1Toefy5U/m/EKe+X9FRwYYG/go/EkyXs17OVBlCP2t5O16uAwvUOiTADcGfU
rq/q20K+cjGT0pibP1IJs0vmXjpsPucAob7JvQjpbEhUDa8dM9NPcUXizdG09ak/
1qQCzZ1mNV0z0Lo/bkcW275tJx6rPQ//FbXW8SgyAsGinSKn0xkoMlO7qsjq6ag8
sJf7iqzSnqSTOtAc609dKyc23c1jaVcnISfIlc+uu0tnhflGRsfuuAC/qp8H2Rqf
zEQ29euhxGwibBaHckgYCKFaUmArYl5ShyOAv2LZ9I7fAxyRmqlNV/7nCwHjdNl7
UNkOvMlhdjkaOBsPyD3oo8Fhfge5m5yapZdabDZSSsCMSR72WussBA3H8PLle/x1
cym5iglMqYunQ9WZPP7j5HDHqlvwX9CvaOhZMY7NpshKIvPI1t2ibFLZXgL9m6fv
9wfgfAvKaWPf8SqUBKzBOJXmheDZFPKFa9i7MI+0Py1Tlk7QxWTkQnHcEfTHU4UW
9k6rUo+46Z2pAAdNjq3uZgkv8oleLQaxf+LmCLgHAUTejoMy0i7btMTs/DTy5X0C
E94pDQjNWjk4PsEaQXbWimTjiaeQNPqKKldAc3Nynq3JTEa8WlGlzWpxi+PMv8RH
YL2mBPie+RdNhR41EsIahkbASAzmtn/VEuu41Utqbe3RIQGav1RJdwYc/c42uV1n
35eLIxA7UswrkF8GISd20sgZuqZKwQ6FVBuKlpOnOGr5o7GozELdgBM6bQ7RUqUh
RntiT2JkaqIcLHZNO2SNurSjB5OBrya5TBrRlFj/Jvwk9nqgLmx4I5LyqynM01+6
jIyba9WswN6AdVHiC7SK6y7ZspyoS3UuFJ5HHI6HgAMgqTs0+9q0x+3qg7Xf2oRV
Hj454tXZHLla78fEFVCzn3g32pWzUx1w3KG6OqkkSADzhCe4bAS/zViY31nOFDLW
6aF73hypsPK/IceAfuHd2Xo/I3Y5stJlUyyTHhirQJqoD+0XHK3R0h8443m56fHD
Ppnh2UMdrGvuBDuVP+yFSyT1vjzDycH7UnN1YY7FVIl4li/yUTB8JK4awm5RPdC6
+jBekojqYg/wU6x9sQRY50LK+BkWpHMotBeUgXW4B94FQDA4lnES57DQmvzaUrQm
5XHPzweZaMVABwsjlBumwJAJuXOtkkOG7Mk02vldBJ0LMjYs2wn+n7m5wak5z5Kx
BR2x95rPmEe4detwJSpRXLUkx8S4Hfwm1y86bMdTWUA6Yh4ObneTbUXcyYzwwAM+
trkVado+J9YuOimN3cXSQhFaIU+WIosQIY0//dnIN6Pj/m2C8hy7+npde+nQ1XTa
NNZOhoFp9t04ae8Auvg/SxImYa1MPi0SfoSPmRz5mfnwNaZRIsUZ04oS3m9Amyud
cPuf8cA9xC2N5ncHmc8wXzbQ5ps+aYoaMFdkBX1fWtPqCERwvVJG6NGHiT9sTiaw
xu5I1Yt3TuA0cEko0LSNoH7sNgy0xMTNJXGv2iLiLA4Cb9Y/EvgZ0hKOW5ANYEpl
1rybKNDgXO//OAFDhVMRbmw03+JvGRNy+XoL4a8TlKmJ2XV7r8iYjzhFQaJbJY/n
5AJP8QXTKrBamqXHsfn1OEXAqD9B+a+GUOFaapAnNFy1oM+TfRt/E7vVt3HfPoc/
/Ge2wOeWXgCqHYl554aZ+9ZT3mOXzY00iTGfOkCrjAOh0YNBlbDNmIC0K8Es9Aa0
AkfF/GRMlRCAgzHNekDaWqwpPk8WaQDP7ISwbqnk3+FeO6h2lAmYn7Y6bGtb41rk
egsFxROiOsFKulOvihK6IEk57ODuxASRul9XrAFZ8OPc5JeMArEyR0g6ebjYXvB7
NQR3/Aw8Io8u8y9zY21LUCAenhTZqz7sVtV19ysimlbyHJZpgoJIJxOWfkaeQVKA
WJTJ7WOzz820e074xrteCMDCBFJkLNIoq6R21QLe7F2BXoqfaEZpjCFf4R++Tn4F
b2a4YQlvfQU2Z+AgURucFQOlYhbqrKEL3jPCTPApnR0FH0zfAXrTxVqbzB0jtnSb
vT1wi6OPzMurcIPYTyG0A+WjBfRHK6SK9Ifu3yzMY+sDqr2eI3VwvCeuAYIsc6T6
Z1CLjs9xhV20rN0xjDk9aZsNVPO5r1k8lbjbBn0fgowyIYcsZppcP4VvqK9Ye75e
xSB2cdublIL/G8PTcvSqPF8abb3vtB0NIcnhu3zEybZO6pscQpLNYsNqpWnxpJGB
//X7VplQvxhHaDUCSv6X3xgp3DEsLVUC7YwDV2wA8c2j7QKHpNWgRYpfKxxk3JYa
5aGsHgkA02m0ISRnzsymIXmuKB2aynHtzMdaELj5masZhtLq+opxH6dt6wVU5JmO
lsflaEEnhjD+hOHOCFT3GBIsEIAiK50amAU8IyhqfykxasjvlaudC7Y0KjpC6Mmq
ztqFKu+3v8nbdMnBWFi+vsbEqq4hUJ8+ukE5DMjUfJv1DPggYjoWWS5otWQhfEPl
2UrvleNIcCKdXzz0eZfxaqOVHdiXqI0hgzq/qL1lqvnotg9VQs7q449zWfqz3OET
UEM/TN7N03bSXqRzHkTlyQG3jfJ2LLmulAPwi1ut92MsgeNGrD/iD4LWHIQgcSgp
8NKUQzvVLepJk4wkUwTpLGw9k9RNC0jfMiwiJccwD06DJQEBOFfoL+UHphwzc+2o
y1VQ97emkhHrAynCRwbaY83Plcpe8LXlq1BQUTSnvTtoia93IHu6DLYOTpJ1UKJP
kefTETMRcJ+Lbi23GsJ6bl0ZleTxaywLpTl2senjrQXVWP45xrkBR+8Bjp83YKjh
4eyFH/dLOrsQl75b/CtrhoT26EaCMnP0XSqIpJP4qeJ5P+vBVnSm881TS2h5iBXO
yt+qs4eYzj/eNB2wOl314Yo0BQ8RyTKEAgKBVMX8NE2dW4N9pnv6i+OrAiIb8A6+
oEJN8Iam7zZZ9pskm2lbgBTFkNyDZaJXZjqmIdkp7e3Evc0ZqAuYZkFr1cgXOqtZ
cc1sHmvKsoqnlrSvYLj8V0Pd7FxOsR6zql6eMhaxlu/6fGXtxOjqHhWlaghF5q4o
rfFI4SNwL3IdDumKXvCXzvV3YoVG/6NT/IymqYKDwF525yiodC++9pnRuk9kf3+o
x49UzkL36/YAvMrWZRrERP3pBscDbCRgxtXgm/0MWOK8xJ9zzdyZAYU0Jj24shu2
MRhrm1MnfxX4D6G6vp0TMi/kPHOPN1wNtona6eZ0CDRxc8DTfWCSoagdfYB37Gz4
SP5ZKoqUJ/l5NOuLMYQ30fg+U2amxKSgzgAJal/KfybgWQVexFFZUeEGNFDhObLa
K+zAVSKjmfRTQru9yAlX+h5zKAZeQHCqVgrKBCt6LLX/87d1XLbBdfH2qmQuQdEA
6R6fRtVtWxbob8khcXTLsUx9A5AjzvDbx0qj4bxEieIpoSGsnp4+95bELMOt6aOW
o+bF/cH+MnMZSiwxNFhxYPdskQRhCqw4eDzm+Wo/Zq6zAmj0XeMWC7u62103Nwa2
O5u8HIUelEt2PfbyD6HOzUg8SnthcouxIoflhtcmw3773GAX2tV53HjZyWhX6Xux
dWVsqVvSpwA8IzUaUge9/h8S4A4DlE4/dgpCoCjRjbohkc8kwvP5FXb/LFfMfdZg
N6ODe+tCFc4iynmA4nvkE4TLPj8dizCBegbYxRxDB9iVBvSL6uvHZrwyqMDR+Lkj
L4QfEH8dDJESrSnzSLZkBZcjovv/lczzBV+Fw3K3tzfy8glKBboeCIAa14lyqmJe
ADGUch1AYMtOgH70alhngiFn0QF0BcK6LO8g4kTNS91Zl1PniBFWvroDZL7S+XQz
EZow/BecQa6ZhOcMYj0N0PiBe8NEG7zqQCvHhbjxKSlPKqxm7akw3amFrcwGDzgV
Tk6QzpUPe/PKSFLFSmdpcIK6FHeWkPXGdY6xLynr9Ws49BGoYVxqLwAs2vVvGBIa
N9HldBC/FRJHQODD2QOuegty9w6ltCbwaEkR2lcUkYxoRp/3MirKgjjwFcQMXNLn
+EjwIumIx0Dn/tmrPOEgES1iC1i7b33YehhudhP5ovksUJWKI+lf9x94kTnkB2mT
qfx5H8e8ppsTvY97EDeRZyK73fFN3c9SrdKXr61HVxjbDlD5HdbmA9Kq6Igxh19K
zkO2Uvg7CbN562mHiRQ56/zjdY4F9QFQz4kl7xvIOLlN+L0y533tjHTMLOUq+Ipz
P3NRWjLTNfgIzKE6J8tRAiNcCdo+NnEI7UQRfi87jP1jHKG07//mUibMP9abdzYf
zo8VFMdXsP8q8xEKf3oOHRT7eo1EIOCv5tHRm7HYj7PPo1VnSHu708Q06dSpcId9
LiM0rmskGExcyRkT6MT4ibsAcv4kpiGhnPsaS+Zp3xxexrbxU+x3Cld+LJMR/7FI
coJu8/YRt6W/g6BKO934JXL3W1LCEVdQjtIkLarFd5iugUZQua4vgoAKV8AUjxC6
6YjZf8+6KjJldFjTwfQj43PPzljzrNXmG21wQtM3hoWkmKyS7gGjScOyYPOKJhRk
QobBdGFqJGOFrOaK2LyCzRSZFNSHQF3289XfceWAh98MRtfDNDWiJd1MS6gnV0sK
lvKWXeaxhW71Ph03YQY8ztNPa3/vxKiXYDFs13wAjmTIv3LC2cuE7aj5MBGcbF2K
CuV06zMPuHpopj4MzOQ4i0kU52rib4sMd3yxEI2K5KLUX6woFOcLUkrb/kwH+6Gs
oAoNaTUUZwB7rIvdYlxrnShn267qews1hVBwHfvdvz0uMplYq6tnI7YOirgO12q0
4wcGyW+gJZFBULGReORZ0QV+UeMhBIF+v4DFKLK/uTa2I187Dn5g1IU4FKyBh9gq
YvDzjW1P3/W8GuBM73dFW7A5nOfUKeOPYyoCrpZj2IaStx0q2SSiRxPTDRKly6oe
idZ6EaDYVlGtYXzZh+uj8xX0ZueTj4rrvIKj14FaAPoBPJY3w5AIBo5/oYjbgb/K
kpTM1wLaTyZWHT8lhoNEVCnt72ZR5G1id/NKjlCpmLNePy5zw5WyHKkOeAnlsN0g
ra/KldNroatR+GvBMFI6Mx4kr2UgRpbqtlGlTmUQaEm7475Tev3qj6x9pRLfpVpq
YdlAHRp4Z/FJPa58Cl3zxCU8O8fC2Nn1z9UeJyLDovm0lUPPA5ROBwKlNdmRmD1U
F97aMvSM9HeuFLqn3gNrkVw4dAZYErPAyew8Wfz08BkkUQETHY5zZTQgBqN3gM9g
XBNff2dpasfOP8PeZ9TA8N/9FuWn82RBZzXG9i3pBLIZoZaHGU+hXLGogj5ciLfk
Cb56tHML3qMG/eI/ZOOKWUSEVMJAH1u7hUp2hX/H+Oz4SQVuHWs6/XLyNaVYwWzU
bwjEIs7Fngfwb/ecBPMbBDjWNXn8U60YspcnD3jBhxH9zBhJRYNfkhOzZIuK5Rk5
CDNMpGJD9UMapFSPh7W9Pr3xb5Vpgn3+rddNIc82p0nsL1PL2+Y2pRFpRhhPOVWq
k3E5My1SEi3ANZ5dRveM4hVIeePXtf8Khr8wL1/eMXGPcz+FfQF/Fes6s+t/xAWi
duWiZ1MoimKG2cDvG4SQqfmUNNF90KFm8Kj1Zlf3y1gh42TBe9R/gB2+Sg3Ucyn4
AIRR/IJFEwW5lXENfUz64DV298BdAb0pRN7Qx8Gzw1a+tucYUBzwm8ZqIRqZDiAF
oCFKlB7+6dEXVj6FhuR0Mn8SZr/VYixoEmMeKE96OQZfWJBlz1RMDN6Dw7EcLHap
+E5yTdO8eLSngRZOcVsPj1xtK5ecQs+DBfMHtPA3EPRhhWaZR/qXW22TqW7p6Imt
ljUCh3fkdHt0ntjh3SZFEG/4JqZ3EWH9dkuHeqSxza/OFJSAYBlTu5cFoNWrax+a
82sLqIkuY4zKtSzU1tM6K7Cu+7G55Ankb5raRVWbd7VQKY3UXotgQmWZNjwcXwZt
FHG1SwsL/ofNfo2ULNgohRskSotTnvze1CTJGdKVFMO9Ei+b/KG8sAZ4g2iORlKV
6hlu3ShnLcsJRw/ERgBa6sp9/Rt3PP7+uMorB7+q4C+D78wyCLPGLFR3u0V5RiEO
gHmrZ3lwnLnZadeKJze2Rwhpym3lOFPoAbNDA+DN3kNxAsAAY8hIdtp0q9+3M4Ia
6zEDLWva6qqp3jCpvFrefYpdUH26h6TuA6TlqYtDZDEG0uiAQnHNaMe5m2k6IJNf
P9ktx4sVON+6IpS33AEn65o9WULD8cZ3Sp+Da1LOKSIsvyqsIvOH1f97KKr7gwsN
3IzvyiRRC6yd5i/uVZwVbWLVNMDfzfSBeFu2FPNGIHDm4z34KIbAN43xc39v//ji
OHMCZvlKKcW/od/KMnBmzazpgLpVnpOdHi5iVHUO51gnTSC3iZTsohyNCAWp+E9g
DGKbSIGYWxXmshTAXkfKwDVgT5UmMpynEJ/povIzT6Rgg4quu5x61jNfaxxOtIMQ
5hi8Oc9aPnMTBxA8aY6dAZSAbwICgQAFXO9wi97j87j4biaYP0OWi2nl5OMC2F50
fJTD6foKVfGNd8D+i0uTkcM/hr4VL9D9++Gt+sXwLeeS52raUNw8Jq0e2K17UBE3
bpTkWHV2LwT3Wg9VEQgssAT1RU8zXhYPFPdiD7bgNed/RfsctgOyi092rSm0SpEf
+8EQKNbzOfK+6umUMLVU/kmAuRiqPEJ9zcmPeWRQXBQU3+KUcNJoy1mxx8Rk2b8T
gE8AJZ4Wg0K/d59pkucgQU4zTCAmxP0xToJsnIxI6aQyQmcfYR7k0oc5dPOuuqnt
/3GCkVsMITnnilKcAbYbEKSNroZDWibVuVAZrY4Pz3mAuNXKrE7F430snHGsX7MS
sDQfcCZ6NHVsHCqNdHZ/BgcE/xt4cbgvcQ0d1CKmDWnb7w0ii5CSfr35fq69HXX/
YyVryda7LdCB8NKFjx6hD08aWCl63WQnAUCkFMMxtn256Cg1rav2LhEnpia2lgae
RVOHXY1KJpt1mgUPh08xf0ROPSC8d1wWLav82mw2fBgA9pFCpR5byZ0n7ZbBJP+u
iWa8XgbG8jVTwDpZ3l9Ky86fcrjz3yr3Lk7stlku75zJU0TMhAxrLUAI8oNjduOR
Y+aFKiAtumtNLEgEk+EdFHQplLi9IIL89QVizUW+qKtVWNDVOWnLh9Fgrn5y0zNu
rDtFSQN7tgyDfesjOSbKbcyUWq7+O8h7KxaAdpfbO3tF9O3GCZP1U4trrKpMwAan
VebwLYWZTXY9CZtuScIvgV0WBnTjlwc3aTkRbmmiHRk3w3za4LWhzVetw9mA9eVI
/3wEw8fSAFNDn7nuP1XgWjl59oObLaG4gRTYGUb3Jl7pdHailOtkfr9iUfFExVO8
10xzSnO3qEYoLzZI43S0rHuKtOj6I8SbaXJSN2UJ8Y1509YAmtc89iENWxhDP7/I
ixZ8AUFC5gTBG42nU6IpktL7J6z+G/mJ3ZCiIsYPemk1pH80W/BjgiwYuBc0aZcb
8O0kCwGtemuvzPuiYLIOCSaD9wFRzPNMkll7MyI6YLqMmwGBkvuPt2IKQY4xq49u
E0Qvu1aqkTVS3zjEC/BJ3cWIjjZbyTX1bpXN+yojflRji9gte3lklzGRgVDxKsnv
N7ZZTysSk0LbN+7epavL4E7e3xArhU6AZpZclr76YJPTqO2XNEOTU+l+efUQhZHr
jtGCIGT3BSgoiXAFHzoxQP5H8IsPYjdsaeLQLe6O4r3cgfVyPBVRMvFitDHV5DO2
KOWXcmUl7UQYxbJ3minMSbtsY3OJZEYTOxSBh3f1AQJXwuj1hMeU8FrFTTvbJpLb
IwLmeksbXwjE6swsdrPHfy4P5a7X9sm1dEfRdx6FcK1JkmtPKiE1R3eu0dSPNYpD
wLGuVodvsZ7mWrDUCjW0QstOKZLMPGysSnEtbfnqYKvpbk7rhqbo4zDOXsAOciNL
qGCCRLs6iY4Z1bIqETum3g9J1atyOGUz2FCy2qTI5CwYXWtYthRsKWO3FVpVlPuV
uBUv4uJdUkzPr/JQQKeBFT04FnVLOrBmI7l1eN2X25GYZXgePZqrjWDFyjPFF2bU
nbTcfEa5BdJ9qEQB42iiEQN5zCf2H4mIiJ5cGi+bMuaqxD7TKso2AyaoYup2NJiG
dFJZ06vup19+tCgrrH08CgteOtkN8vWbmU18HIYrezyQ8orqRG695t/ZSmvsu6jT
SdGJCwC9ddKXjpbyW2OHU2raHIsc7BWLGr7RNeEc0ObqPaXseNKQduvMMccKOn96
K8Fc72oy+q1rE3APnABfXAR80OZtn75RQSYUaPxLAsucBRyyUAUwbgoUPO1xi8jF
TPUNnG+pGOePsPvPw5pm9IFo9Qb4rnVeTvCJXUJwS+FZRVe3NQOosGqFmp7yOafa
uOyD85H4DNazwTlQskJAopxVsySWG567olRzB6nVj3QncpK7r8eEjlb70kR0EQmd
3Aacl2/5UOzCj6+/sp8v9GB07jilHwZH/Ke9/RvRdlkXHrEIhs+jM3R864qu48ye
9K3oPeIDSgqoj57rz6TP/uw55iPgw7Yo6dt9rnoiAM69LBGFCJUInM5tVdkFhrq0
d36/pt8BM+tdAbx4ffQjvBNdkyRNxvUpTodgvpizLPuQqb/lzrb9YvJAg+yXtNoq
720iJA4XeRKZm8t56zL88swCsgKhF6LFZLktltBR1JdsRiLJcf8Mv7ZXfE0eIlTa
k/MazbD+GvmXww0KVuVlGks9HSvPJ8xm3z3xRWCB0hsTM7U6Zg7l4SBmVcUGPd6z
nVd15vlyWrIPQBAcUqSh7gSfYK0BuBavYGd/rJ7qfN5NAC1PRs8QBPUTkDXMai8s
crT4KbQgFfxD4fVsFnjgpzlqpFYiGfHdkSIjFjZ/gC1JvjNkp5XELjufbDgaLdpy
Y4haNIM3zoF1DO0KGKHgk6w79vCX762vUx6vwc34yRsrY53X66H/WC++IbGWurnU
piERs+jHqdC/EBV72drqXvQjV9kSJYqkYSivmXE3EulrNEIuDt50HYAVQAfLnuS6
owPA/+eP3rsPoPN9nnMvJOB5Ug/XTArbSmlEwWElXP3DtS5Hxcscmzct+Kvpfggg
02yKcHYGs5FHN9WYCBNJE4G5sN5nrNpK0mR5yxZQGXAjKy+lSO/aBQL6o/j5BMF5
tfE6VF8DNGZqT0XSxtTdOaK/O+6z+3TiDSA/YeWSQy5xU3VFHhJiB2A5u9nrDs8R
yHxIpEXnhCEJ9KqnzeBsIaqba+oXKLldK67aNdwFzWK/dTSeDloF9F0zMEhurhCD
qerwn9UNjzyEDeBcyQCb/TindA+LIk+LkqwykZJacZbvAqI3YC8MuXMVGvT81lD6
LT6Qf0SyAnIdw51mmP1wyLOSS2/nQMXHul4ROIyltbLXESoaEP8bmk45HCXWVyHD
5EmkBMVjHFY/Ux8zciY+9IObDkpLTBBDEcNmqkGYLFc9afua41owWFtr6vwMlfm+
e3sA/lvr5UjsCFVbdFyycjKfnhaEV/uzLYn6WYKL3H1rqF3MB2e9F2TuN/Tu6GZa
rSXTjI9gXHAyZ6PbCg6GiIdCpLi69hYaZsRgmUUo+4RDZ1qxc91XdmZa7ZTS5Cio
wavGQghTDW9t64sDkc4NSyZA7HL63OIQggwv55vWEVyM3QP59JPpGX7s8cH5Os6X
sHywWB5vpBKCjrbzaUHw1e4zv57sY+1RWWMELY3r9bib4lr6IYlf88TaT63YcXig
xMB+lvYNrxAZvwH0u5w+7XoCtTLpH250NRIn1kieDc7rnModcIM7H7mqLNrcLk0i
I1c7glKDKPIwkJPfy5XLuq8yDuub9PCqfHUNjkaTE4SDVFsrMwvHc/dS1DqTrW9i
cNIPF9iRg1I7VKaQnU2NxI1ZslgG6ZyA6NOMaaDcCpGTIhFPTXaJSsgW+w5x3V6s
z7JzaBP2axMe6Ff5qQ66JyoQwtRbh5UbPjrt8v/56QNsPxDfT+rU3CDC1cz5XDH8
aBJkONtUirzUsuESJ+zhSdunSMNM/saBwmF0ai626M7VrLSB/qKnfE6loyXVD0cY
nwLsj6S3qeTH9CGx/DSjIzEDfH2GfTkUdZaQrFYWwS7dpyV0uEqsmFUl+DsK7IMJ
x7jvnq1ZQMeHWl1bWlshArBlz6LfH4JgZYUezWVzem12mCOdT4odHUfZIcvUGp/9
c5ObwYQWVRHfJDTs93AM8evtRzii0WRlGCj63ffpgRn56PR/3rGEHT8qVTkysMBQ
B6QY1l9U3j2zs0jMkWVZnQYzXouhnzNPj3X43/g1/PUNPMcxlX9JPtucp24XesGN
WXQQyhcSKeYoRWh5BjZNlY3vsW6As8MhyWtSWo0IoT7b2XRvFZ4M1YnytHjGwRra
BILfue7lifBpV1Im3Wfm58adRqG7JoBYRuf2ptlAmLA/S0qYYGUg9L5PEMdgXwW/
xd3CUEBhmSvaTDWrRsdfA7YMG2JiQp3O4EoTI0d+mgQ3aqwF21Lml2EIyUw7VeZT
gOJ+VKsqlmrECoMcj9aca/o6Gr4qjvXPR5wOPYU906OOd+X7uMrX5JuL/sItFIZL
A5c/dRl+gg06JA2Y1ewhquTEhtn7bS9Dc3VECK8YsiCq9sHS3ojz4vpZH0KZh2CX
rPkseWZXInItHICaMoWpwc586LRMwJToyJ2a4pggiavt2DlU0UOTNBFMDAclsZN7
Tj90/B2EbBEtBV0HwQCyWq2qEUtbvOOCiYwqISNjSoJYVksEquMBs2WFYU+ZHcJN
ivTHJLuzhRPTATPH1hDJr6u0jfyOqcJR3w9dMRWYDDVLypahgEzQBGLEtRwlF/qf
YsVwUWjtX0dTVD6ybxH4sn9jYWtsWkySAN8B9UKKV1g6CQ58FHtQU189+rf/nb8j
E4BQlCwlMgZi3y6U6G/0192gfTMYALx1MZ1LZvXaC6MAmPEHYXT2gi/3Wj7gtwFx
6QBbHM3Fg6jN31C7n99vkyUbgKW1uzcHbmEGDEYM9xEcSMlwblfGU7+vvtg/WaHx
t8+cy4OBU7c6hKlU82KPBBO8TzM9vL07zVaTI4ZG7xlYRbbMsGjXLbBUDqcsTwxd
lts7oCMVQXj3VqwI/UTg7SV7ANB87j9g4cNuXqH0SaA2Byfg5uA0ZsZaa/34q6Ra
Wc+j38o9qfg0V6b6ePoIA9hZBEQ61DGGDu3fCUMjGxDY8p0QNyttCmfnzNa8FtJ9
xZKRMAELPJLB/Auzad+1vYwNUL0SXBNBZvOa0j7a0WA4w1exedDrxLZWXxrsuAcz
1y1d2mcbDIxp28S280dpfqFCRN7qJNJsDei3DXcjeTc2lEVBkDjJNvpAB8z4vgtt
ZykqgDGckaW1Lq65x528m/NL0LOpbf2vkZTAJ5PyXctEfno6juxlND4uX+MSEAlY
TWf9J3hQznP5p7m6ukzi4wSAWz9d7gjlBuHI8qjr7A3FWMqsZSA953ckL3GDTjjF
Ni47IA2vlidCmrIPrSY5u+GW3jzStByLm56S4kT22IkXDLsROjSMoUm+hG2ydtKj
KHMV/HutpsF8SV7k8d34TvARlOiEcfKH34cdOBAXPAjRp+MLPn9KODnLN+OrIs1C
s/ke/DB+ZnHY/rSaGzFxtpjdlMTTF05D19kkp0G9ofvrj6w1Ix0qSx7gFILDwUYZ
5KRFvNox9CB5D7sX/m82Yb/Kz2cWtUtc38b6TBgcN2kmV6Q2Ivruk07SnMuymiOS
nTncNuol3r+9Ky4UpSbs5IuSZtgqTD6y1WFNUycUmOI2AV1iEowxumifbOrDy9LF
X8y8X52v8u1+rFebg2cEttJcen4NJKtDhuWZTUOxD9YV/EW74iwbhoqSrTO/0BfR
kEMgPFkFjSDJgOVxCbyOg1t2VCebqKIbYPPoJ7dB54Mk24XSfJaYF7bVED9VliMq
cL4tr8925kzSJ49j3643FoAKijYL3xGG9fyLUY2a9akIU7aaWhrmaT/PKYdvVNv4
tY2SFaOZj7Zw0aT9kjKHh5U3C3O+8Hwmt1I4CHMkop4du8dAHaj0QLpG3Zj2uiUh
C/ARs9BFqCf75XkCLcBvypFQnMA936/q3pH2YhbDBQHgcPMta/nozCzo7tpw7BXg
q9ijJBVcM9trV8fAY/cnILHb4A7AkcKbaD8Dj2XEcly02xa80kJad+FIQhhAOhYa
X8oHCdIJknuRZoOdmJ+mIJX+qujP2pAhtcNzB7/fV/Ve/vv6m1zRhPEwnfjYtDWo
tEHvx/uxZzgwiMLAbrqsEq9Uqoz9rJtQEmayIpZ01xUM+5f+Rk+qK2EsuoJNytYy
TZvW1yuZ54Kmpc3J2+tiiIeWbmBETWkw+edBpeSH8e8Xz2Oiwufay/VAL9kgHg5L
EEt+WDHx9C9M2NOiMIebS2yX5FV7RQIykOqepIMimr8iswQBGao9ytcMEzPIOP8N
T6++acdnfP2qsiJcBCbeNEljaQczdOkhDEB3hm2U8D3hx8x/ATt/3Vb0OJtN/09i
dE1wMZFAVdhGqPhJJ51U4bp38u5caiUZzTyaKEuz+4u/6hB+WPCNtsPkuhj9pIfG
tjxvjOeL2ILEY4hj6SIre6dgnaqYunt3Ib7HC1zSpEhqwxfHXetUMVHGo3t4kBJW
C6knv9Qcbbr9MGKhwgiCF4CUsmc5j56PA7861m9Ag1kb2WJOLSzdVxxPib6Wqrsy
SazhucP5u8R5JEKw5Xkl5hWo0bhd1ucKmJDiWi+mylYX2HDfR9z6C4HJYH/4mntG
fxzg2mTwIApamMa3DxIHWSGAVJ+WXf2q+f6Y5g8MSt4aR/hrTx6r+skalLvfH2EY
Fcz3xNL2/ldvC90NrW16bwoo6jZN3XGJXp90EU0IvCoQmVlgQ2SGKO5mOX9NPafm
xGjwwl7bw34GQzA/UW0uB/mBuYJvCVPS2Sw2TM9KO/gq+5NJL7LnQ3CJl1ycEYty
A4qlvNEPFr3FAfRxktmALDe0ex0wmanHWfdxoUr+QysN1CjA6YAaNHvw++A5BzBL
jSshU64SKKRJnsDPSyGZjh20iGudXmSqESr1KTkz8GD+qT0zmKwAeArfKxe8/AyO
JrN1oafP3oBHGL+l2BBsl4V0sJJ2sYG7W/GYJVuhgZIgSSf39pPR+rOzSIlENWIt
lXjCRA+tiisMxbl1UHEoLACkzwYGdDPOjBLucUalhREbMzNzVk+uX4e0CfiMQAed
YUxxlH5ghbn8ddBLUBcbi4reOhz1ztQ7pQ7/9WvMXr0KQib7kE5J4OBrveNt9So9
YMe5bF+yMDiut3QBci8eMGb/H6zsPb878kY09gixgbnXH8bIKG/JbVBzvSDS+cN3
EFvYz3ffBBLEYQkGmd1eBPWk7h61PcIjclMi97ScvG/81IV/ObR52JSAmNK3eOZ2
B/7wt99TaHc/1WMEjO2q4yrTQYmJgO6S17zIW3kcDHiVoiEVgLEHuwYWrCaLY0I9
hiClqfpQ4NRegWwNv+J7RwLUo2bU1axyh/0tpiviSMShcYv85aWg8P2EOS6aEN5L
pvAQKv661skkNjEDNzBZb7i0M1uQm3OzQ2v5KqYVlkJKVPsTs2esZLZYNRZu5WBz
FB+1p/mV+/lC3Ys6/Ftd8FMIxAwRwSR7sUgNnTIpS04QKwO2BqO8Flzeo5S9UlGM
dNDbTJZ3dGh23zsguajzqSgmzajX7H7mCW7D9ChP7dyaram68+mJRcfhAw+2Yy2+
/uOLCANqvUN3+3kPKrFKN2VX9u3JeTzOd1+6MnwEm6LHxi1UbdwsJQpIwM0qKOQ7
BhVCJYlWQfPxtV5tY5YuESBMD5LC9DZtSyh5N5Wj/FNUAb/IggHFg7OZQcyY55E5
0WZ+5i7nIpx5Ioqo/PuM07Ai5U9gH7H5LRWd4HcacWKDr08kzdsnhLmmgG7QPDxm
eoZY+fYhA8u6HGXb05xFt+z6izwBiNpcL+j3MKSf9ownqoMllscizBDE6A5EExME
/X9i0pdUC/i+VzOztokFOhQ0c8ZuEIewFxeTSPbvNDRpWgtxjIXmgC2KzDzE57bB
gMDNWxCx1Mk+wlclD4uYpIwxPKIAaEB2XlWGr+B6U0isB4IBIfbzmGbYiBh/6sfg
lnCwd626ssRsGbEQI8nMCtZBsts8Ql30pIKy9YegrqchavQwMmH/NaKeN2b5ykaC
cJJEFfUa5Q5tOg8eCyN+sbZuAXan9A569MBXYKWwc5SUW9e49EXSJmBCMDy9FOks
37RK9pdLDZlaYfidKLuWrZ1bmGRHPz7gtpLAz7HH2zJCYTRp76U+DERSE/yvZRc2
80nmC80vfDUVOXbAK08bP5Fh1ug/QLhpfSfibEIJ2UMUIKI8GNL+57m1d3gqvS2R
mtjjUISsvoXyr8vgsxjQhNxeVwERx/ZJsPJesAgZRWAj4AnrzKJ4uXGIfmBy+Ftj
mJOGHSr8tMGAZ9lYRgHwkQlG/WsbNj4+Gg5UxkNpGAj9l9SqZct2gJcsWJMjEjyM
8YxALcm+26BcLlPFtSeSzoDbkfx/x7H3UZHw8KBakwxnNicGOsFCzNX2dyG06Nyh
sCPfog7ZQmSs7jH08xXdWY4wgWwuqvJLmBOoLQDyf9lltrb7zFZ/bklZw8Xny0x/
SYNlAnETceTy+eRxkCdVmZflPCUYbpUiPqY+4QSuakx0vkZb25MphLeMUMOtB+tW
P1ojS2nADLZ+JiwpQP8J20V+zqsemAYI3KljQ9osdY+xibPF38Z43FmvoMnHHnxP
VeAAc/z5D2tBvYjRSKyYEEvFytmtTECwwUEPFPKFifmpdZiC0jw0sX5lUJMqov8F
+6BEVrsI3/HSmkPPpa7PbiG3Su/ymbIJMSiaHM2XJecu8e/Hhd/7O3TPc4+xfvVJ
y+wva0X7/5s3wnRcDxMFhbbtTJgjIJE2uf4V+CONV50uKHcfEerdqfs1aqc0WMf8
I4vIMyti1jk7EOjf0AwzpWQmZ4OOgB+yhEql+SDKH0ZooXg2OTcoDeKKWMeAvFkt
Y5oFVjwBh/Z9b7QFLytgircqo1UtGCJf5SOjxHsJzUO5or9BZxtnaSd90Yeic8p1
y6lxCxAHNR3Wia4U0eBxdeIZR0kYCBcPioEir+X0mcE0TR/rQZ5dYjdI9AEfksEo
x0qOdfRChh4Ec0gqksbW4n7oRTHd7CeYBSFUNv5771s=
`pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eG0QlgYYNhRonizOh8vcYfXQ6veReaLzW+7uYfM+Wyl5QjgTZ7zwrJLTAerzuK17
B59Fr2zBD9J5eRBV6bOF2s99jyPYSQMHE+Kyj/X+IbgpK/ZwpsPlT/81HnyOIrJB
dSLLthL7WAxnb3m6mpG7R/CBEPYXHnQbAISmse8fVU8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 37699     )
G7sAUUdMu5qOfHUrHm4LeCrYXwZp+SFlBdXj1Uv+cacz79LFzoGU3CYKra3GoyPy
avQ4kJbF8Pey5sEWDM6q/MfF3HD/njqkmzt5r3lrvv1BkPSF9nlTqBg7IHSKNX/r
`pragma protect end_protected
