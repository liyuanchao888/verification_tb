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

  `protected
2]?QL3<08S&:;=TMP[C5S0M^SAf&#aRNeC>BaSS-.5PE?FU/Q-I25)Z_(IM:2UU_
J8,2T(>XbF,^+eNfYE?WEQaIV=&4/ECJ6=[7B0I7bG85:SH5OI^N[N;3BZ,\/A^+
#3^TKH]7@7(YR9SW^TZH[OB(f[HAEH?;V<&8)Y8gb;0WQJI+:,;cN6V_E62WWN?B
TgV5X^f7?X5,-6RgRJY?5EBN>6_80QJa^IF)+#-Zd1YQ,V>3dX7)I4c??8cSJ9I[
H^X)&)3&ECf,W7L(_L8GY[JCSYQ52F&V+0-UVb[>NQC9Cd3N3g\e[37NXT1ZWX=>
7bbW)I[@QP)0fG-g\-cS\fA?0g7X(.4.HJc37?B?7P9)29LYa9N;/6U-V:KACEQC
EJ]T[gLSB:@-N4B9LT2,LHJGa;dFJg,+W51eY,&DN_V^:[)?W)-L6+&.6ZV-12,<
&9Y6-AZbUQD,H)0W(/Z)f(Q9/2@E:NX6;]Rd<dA;_^<G@)A4PL.7a5c51^7@.fIS
Q9T3#A([5ST^\O7/??P3bagQLf70VK:W<DdH7f5]L;2HY7[-R_Oa+g00bZR9,DP7
XPYYMNC1\R0]0C5f(B4]<<1daa];cG^eWZd.Ca]d(FdD,M2)V.S&FKd?>TS3N;ZG
9LJ6->ZLKW:ALXDQ#6RM<<1d1$
`endprotected

  
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

  `protected
[2M[e=)9;GP^@L.J+P:-H=G7460TXB,F9:L+EK8XQB+6X7HJ#^aL4),=D/TNI4)-
<H<0F=eWU[-V@19#2)M(V?,f-7F#[S6KD5L>\_G&H0KV1,Z07],IKR0F8a,2_^\G
MG1PLWL6,#CFUB_N;ObLI,G,Xb4G66[g3bU)+-91:b:Lg&4(M,ZLa).N^(=g7c^&
JR:#D[LaXB;3QAb1IKJd\M;@</7^R#@QeCIb-FFB3#Pc6P=1PEOHA:?D\<JX;LY;
_GeJHdL#?._.^Mf\<YWHUTC]3&C2=E(WP[C]+EY<eW2XQTaRWQ2[07a19?JT4ca(
H,THF^BB/)RYb6faIW+;G3&cNALB&[6f5F?5PA<&:^bG^\Bg1T#,)6/X+MC7W_9>
7E+K@IQ+GN?\Z)Nb@R38c+)3e-RHMbL@^WLYVPT@J4..&1ObZ\]CL^\@^a^:LBM/
2AAH1_0LQ#N?IXVRP7]?CZ>>=5dNH+gNQVNgS6;-fYP<[B1\SIUPOZ9/RSb5V-b-
c2U9d1R0K/aP87N//@]gGWVOI(Ea9P>TP.A@BFBWR&a700YG62XNO?KK.c-e+VRfV$
`endprotected

  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_hn_status)
  `vmm_class_factory(svt_chi_hn_status)
`endif

/** @endcond */

endclass

// =============================================================================

`protected
92ZUCDN?J<6[2ME+I<_]=1/4Ve^T94DYGHID/.UE[15-=.,-ad=c6);QOBOHP7XP
&c^36_983MF1M^6(8(E+N(dA=9BH)^R1,bFS2T+HM]@&#.]=TSKG7RQ)?:\D5G7e
&_DC,N3E6=Z^YOMOXM8^Ya[FIc857@55OBJ<EgQL9M97U12MVee.&6(F73YFO2\&
J_732]>^;DP[CGce^AdZ+e^f^FJC@#g:ELf4X]6+SO0I8b9L:#J=-;8&0Z)+Q?GW
WW3WdB4aO#LN.G#0WYK8&<U0XBB>dN?e?M)W92GFU-+_^SUcT8Hf0B+D[+4N092Z
]/&3@]bP<R/SO);EQ@^[4\G2V+_&VJa=Q5f/TQG_+M+S7Q&.;S+:e)=1]eS+BE/\
6Bc/XCLSM9H]IV6A@3H12bE-+N/[MKAI+:P+H;8AQ;]DB@\6Ag=DSRU&H13_1NZ<
d&^KQS?c)N3>.202969T0]ZPI^Ca6W+P<P;]QR3aC=g5DPYR1IfDScD.WJGPK;S)
9R.ScX0e[84+g6L&B4M[4]LQ==_9dZ/\H3AQQ4\MKf186[^N(\\4OJ?\WcR1D=U:
=QAXL^>7^c1d6e\TDf&=Q<<:916^X5[J71Pg7aSc>9TgbVeRV=^Uc+_,OV[SHOFM
V_MdB^9C&(TN@<C4<JVNf-JAO@U/Lg6=ZUHCV+ZQWRVQWSV(Me)D;O(ZBY-E0F[(
IK2(,Rc[_7;5]2579OGW4_&Y:bUM\?)d=<GB4NQC(Ye2/8F(Qb<^BE[SX,6OEC9#
e,ARWQ:dS\;(48b043;==fY8M1>#Y^#(3=b,JdUeO6U;dX<<(X8#b4E\VJODH5>(
0:<K#JKBC/.8@>:O(W]fd8LFUCX-LH-=bJA(e,=-K(e>XDFg_LE9f:NaQ;db]/[W
b;U2\I:BY(AY3+B?G[+HF6RaEET<[XbdNYb-&70HDC?K6cdAPB:G0<Odg6C:JL)1
<EfX)<J=Na/B3GV4_[CZS>_X>G2,;GB@EB;&d&MbEI<&6HIQV]UC(DIJN^MMM_@0V$
`endprotected


//vcs_vip_protect
`protected
Y_@RF.-.TTEB#;G/.XP5KCeA:WJ/9dbC7N;&W-JZVT_dPA.@0<@O1(380Jc#UW>]
\<ReAYc5]M30ZYa\E.>O]1]@^AK5XY@2fMQHZ7(aF@[^D>TA]Yf?ePPY_NHP@DG9
66<Ce-?:4ZV?fP,#;XLYM-+-aDZR6KPWU\W@SP+f(6O4gLQL=3PBVS9,WLa4eX0@
#:D]HJ[-/8>M/a=)DDEa9O.V,R9RP(Jb6OFG,GWaCV/D0=fYYH:/KEQB<,YBI^F2
^GKZ8W\/QDI1@b>KWg(@=0)0Sg9PD9+<Gcf#SX9IU@-8H&#Vga.#RBEGW?)@X7C:
Ng6)^_\U.eO]P@W;X/;FQ&U6:T5HLIV6WP[<V+>TXcYOPN-Ff1Y]G80f5>@gg[HO
cIW<4IK,9/NQ#\+6?6edbBD(K&G+R?=aG\RC1L.]=d.2dX1H+gR)OH-#b2#)-7X_
bVU=8<bH;\bPT).WSB=YCC&OagNLI8NY-7NaNS]=.2f8[Y759.L68L]&9V6J8-7D
IR?81[E?<Z9J7&]ab:J4,/VcR&G&GJ_c0:(IGK(NfecV^2&c=W-b#c+U35EYGUZ,
&8dTH\?gWNJ@T.2I]Td4:WVMYG<H<45+1Q=fbB/+M>6X2FDN6\Y3J)Y6LHD6Ub-;
5?F7EeQgS5ZdRH3>QUEU@EU;;PPA6\gACZ7O^)_2<_dVG)c):(WD.0<+e;LOQeH6
=c=ATHM58:88WUOCW5c&a-8a8X>)GFEaf]=dOT1dSBUUc_OSLFRY10^+.=[M<UBd
+CJ)6eXNEZ#I@Be#30e3bQa-,@Y@Q6(].5GQ0Hg=G/YAZP6KU@V(g-LF#<J+C^4+
K_/6cVQW]1I5_:FP47-^T;:MJK?fNQM&#=@.,6NZ;KRL,;I#5<0..U0+<]41APe=
<(f-b2Nc<FH>IWW9#g(I<W6Xcg0;KZI6SUQ7I_F+;Ac.9f>aE8^8@Y:3^,/6?CG5
6>NL/aY<3VG[3=+6;F28?EQ<MG<6c2=&)P(<Le=SYWL^d_O<_g1GZJgf,B;cKS_C
VeN&[>(9=8SS=>J=gLU07@U^LS_5E+2d8&&E27J,b-_dF0CFN;#<1@.LHSP0b8KA
Yc<=N_,(e#@CQPEUT^b)d&@&TMafPY3\&RfB1G,CO\GK/M+\8-^^;M<=f4#LKg2f
ZcgQ-/9,NW3dE7XBcRP(O7WIYYf5AMcJWP,b59de>+?V97EDT=>E4/VV==dQ<D&4
]f3a2#4bKd8a(M(A&HUSd.G1:@G9QH<8g[ZBgBf13Kf<-EC,6J.Q7CKZ>g/>H6GO
@^8,32g1[(R4Nf;9TS2G\&=1NKO^cG?3LM)\>-1Y@??a,1BNE)A>1:MYe2B[:8.5
2@R<UY.P=EMG+H-IL(WE<845edZG-6JRS4Y^ZGGP.C@N#V&9GR6QNGB:G#-[aHO3
-&dCU\_^,G?1WSL3OXDFQ]Z;\WUS:)&@ZS/63beOOY8PdZ6]TH/AOb-YNI4,OCPU
1=Be;FD)QP(.cJG#_?+,/GKO(,-8^+;R1YKcgQH-+<(@ed8]Ue:.32fBX(gVEe(1
&FY(@81bdB+Fg-gPR5KJH;BbV<18Cd.E:N/Yg\8<(Z5/g4f.+@faA[57[EA1LO=2
8..b5J/Z<Y+FH/XD.<OD3MS[+cBDQb)Y;HaNCE9\/&/7(b^&>W5R9X;gfbDLTTHa
>+bQB/I30HS2^Nbdg.S5?=WQ1[HgLeKLgKX-:K70&FBac_X\MX<YT_L/fJO\/;:L
NGSe03O2N5\QYLWC8:MPR_g6(KR6BC@G2KXH@AEQ8ff&8(Y6[P\K+/KW[U\N4=;[
.3QUegTbFFL7_cI\f=AD<Y=HQT:8<UFcOU)@ZGC31<ecJ1H#,gf\J2a6eZBFPe.;
&6H6I4<XX7&bfBYG+1<W,B_^MeGFMJE7P,Y)c@&BQ,e,A/W+3R)M3aMK4BJREPY-
<;\?XC32EMERgPM6J0S<O2Z,06JCdW[G2gZCRcXLg.9RT,&PO)/(S-8_N(3><Wc,
X1A@5Z]9,b^1_+_UG+6bM_Q[A?)<L,FDE]+X71Ccc(=UX4,20,D(8B]2(gO4CWF1
S?=24&YeRA)^\M7<1I2BTeL(WU0_MNWK\ZANX)3,4ZdFYBFC:L^Ze,G0(\NC&feL
=DJDV-Z=Z)ODQ5C/^HI7J)RZHLGKbYg(NV?g5ZR^bWM-<>J3KX<4(]+<<AFV&L-Y
5_:0eEd=?XQ(=eXPHebY&(4O8BbW\(T>L=IC.@JH)=fcMD)L&YF2<9.9<AS;d:5E
9X/:O0GPNYg5A0\]O?QJ0#NC:a.Z4fMd2AI@S9ZcS:CU(A[#)5.7WVf6>D+YSL2F
:gG]I)],(7#&^Vd,d_A2U+73FIeXJdM#]#I0Q>5:C&[GE8bHK0@FL2B(?#3FP3:W
NafD-8]P/?>OZ2Q7.?&R=:2;3NQ7P;\C(VFe,HF&5\dHWRB#^4XYWTa.;2H]3CSH
Z?>FdSWd61TfDO44TJ\GS.?P-=&\f&YVK_@dZEAK@=N&FVZ>-fS^8aGE7PZ5F_Y)
L:\bV\U+\EU/\47d96(:-AAIdQ(9PTHf2D_(&9<6CYN5SLX=@Ea^Re#,0TE[S;ZX
5c1IN.Zb\a&<K6],fIUTO5OD^3L<PB8:Q3&1+?B<g[/8b);dW-EaTUe2<II<gVb(
->eW>JC_C?XC^,ZZP7]&[&P1MUD1F_^Va1E7T(SVIR-4,P7eeMIJ=@9;PBQ08f7C
,:=K)5;_^AA.Zc8>-D)MZNP9d)-DSN[@3Oc3d9fIIgR\(aHEOM1)geU-F&KI92@V
^7#14=BV)KPSS<5/BX_;O:?O5\b\>S;ACN0a]]0AS&KC]fSK=37ORN@PNYZ:@T63
S8LPfa1:=ORc4JTYJXISLA_L22)V7ZgX_a^A5QCc^/]IPAZAES#f9--?)15XX-@K
F-1_(R@PX=J.X-)_]#<c8#GX39B,F7=.P&#DL;\><NbU:2DOR0TV<+G4W7:<_1<<
2=F>KC;^6[N;H_?d62RZbIAcOKCeS)e:E@Ga^Hde_>-YdG(fObL3g?]aA]O58D&f
VNc_OYUC>PcU0XbQ3I;7=NgEa(HS?>16ML,0W6AYd=aJ5WNX]?X[)1MC9L<4-9C;
KNU^63DB<?1&W34a-1g9I?#J#TZAGb&Le5N[5H5IEOe?XDBL03<#/+a<HS9[e_;c
/>NcP,a1U(0gQ7+0DaeDf]a0c.b&=9--c]6D1Kf_5<ca<DfGbKDMY(ggE/4]bMP>
TWA5+GK;\)^,W</WU:>gb]CW;:)U8J3Lg+UgU:Y+CU1,E@7^0.=VL+b)L93gNA-A
56+a+2->9gd4)\(0DQ\Y^Rb+E<,_Z4?MFXY?#d.@5g9aQ-3ZRgI9S:bK=S2B514N
0XZZWf:.<T_7G,.SXe:<7P_GAYgNSJ5K;EAR//3NcZT<#P&H_BfF6]d[^/GT87W\
6?IbC1/FE:_bJ5N<TX&c#OT)RIWb?@<#I9,A#(e.Va8..J@HHO>G.a9./3=/8>YH
g(&YY[=/+S99M^]=XF>^6J.A7?6,:0O/ENO/aKZ,e8GD9&)K8,49L32(fPTa+L1#
=/L_0D>B&#6.D@6J<_)V/=>c>7E2^09P;1gE=5<QdOeKJBA17PBW@5Fg@EVf:_VM
bId-e6&\X1N^,JLIeWU>Q8J9HT-6)f^\eL[SZKG;5/P+UK^a/5+3WL8_EbeTH8<R
KbZ\-F;7LY]MV0S_S=OTH+<ZYSQ7\C\YK>cUWg+MT_0ST<^O/,F_PB@&8#IS9-e]
2(eDF8d9#QZ57,,--V5U_WdI6aNKIB,^ZLU^EZB=E)=?d4_N(T]FHOXNFR9IE6c3
2f5c09W#-=#>6Tb.F4eM,@PO73b03@+/9A0Tf-9;GG#;6D\U^dbU;W&Y2Q7J^VWO
<#.N^720d??@#gT7RZ4,>/(KBEDBOcPXM0#VU8/YPRYc]e=Wf_(<6SSZ]_S3/)N:
TYHFWHG0EX>27_[L(POOF,4TMQ@7&1^J<VBJYX<eRNLYS)f1<bJdd8&?&-fIPdP-
)0@L3Q&-F;W?#:Q[I.4^DY1<+76&P3_Y-5HKR<28V;\ZQ&Q>WKZ_4Za_.D5PN9We
L<[C&PLORS-.)N]KSNb?J^O)1B8>QVYO.I8fY00.YH:SJ>#-2_X/B#,-;b]45aZ0
GE)<]G(7Lb-UI18@)EI(Y3DeNA&#F=FY()8f=IUXQ?]0f2dI-6L66dPbK5dUK)>b
_GRfFOOf5DS#JT8JTQT6YO[>J.3>@d45;3a/]PaE@4dVSNJLOfEKH[]Od_57.f:O
c7)8XU^CB;A(H07+;EJP0[L5:I+;9(B(bB7-Nd1aQ?ZbYC,L-XgGH:87-Z,6dG05
eg8H+9aZXXN&2A6<=Z)Ab88c+Cec6,,OUL-1X8)XXJBdgN+fYK^[[MBLb)N>eEeD
cGV56KK;=[(eT6V?a_;CLCH0]=8(^=4<,J@L;^PK_YfVH&\589&[J_Ve5=ZYX/G/
+U1YZOe.ZLF,E,2Uac2B<_J\.L9]45]91L^8A9bI/P2J@[eeBS/KN3H;Ae-D?@KH
<H40S79IF]IdAR=?YCAFVL;JCfda1:#(48,A9O;7)f,.27^RW;gU[dU2/-]eQX=P
f1P;I=adNYTe5d6=57IS((LEC<9+<@QK:VXVS?@DY^OAO0S+ZJ]99VN^=J_DQ8I7
6XS\@YC4K)DcgbIe3;,L&]C=H=9ZQE>>@EEfYT8NRPaM#Da7;8M7Y&Q&H@_9PX#Y
bYP<1E[U8_KL(_fNaOG_N]F=TE89B]HP2:DA;Sa,EN5ae3)L4(f3Zb9bGb\Xee59
&[g)e78NCT>d2?:A]I2)K&Qb\>L;R<Le?E6RZCG?A&.g?bF4>^JM1g(-gc4/J+7<
A:7#Y-EUL=U3P)37\DPEc&6??E11JQeT1.3&HaW869+1@PJV_OSTH0(65,;,)V/.
-2P,(f]f>?8:aV/U8[aKc;J)]fZK]HH,H/HeIe:5fgUN\678B<P>TUUM7<LMLfd9
O7@C+#.b^UKEMfW@82F1SY_@1-@6NN5?Ud2)f7]dY68R4@cPGd_eIJOH&^UQ0)c=
K2WJcC;(f^\PL+D)e3cJD8ZHGJZ6O+RM7)d-c);B4Z_5bSg1YKC4F?3K5KWB=5D7
;XH4@6^a[8[0I9TbRA2&_26T6+ef_OG?-K@QUVWPCBJ_(b;b5e^@4?N.8HHdU+E6
ON.RHDCT6G3MQe-3&0;QPfEUE>d9&3E>FgE&/Q#75O@23LBa==)dM>1c<^/K@MHF
OC2,97@0gX[20#@b10faCQ6-5J6Xb<E7NN5bg4RZMfQ#&+X5]5E=e#7A1<CV;/MM
.4@50+I_V-9Jc>7gY&cP1SK.54d3VD\#HJ8^UJNg[72K;Id.AW/;cH2&0IC(1S6f
6J-cZJ&?+&T1@A1N.3-?5)+XSA+ACFfJ,@^VJa:QU18E^8KZ#S4-O\J.2;+?M.#\
)MSX_;Zf&Q:Oda=9@6)Y-ZGY7W]+_E[]X=50C0d\V:fS5L9IIB2Od1I/[[;NQ@S;
NaBCZ.dg\3fgJ=M+H1;_HMP21RKDcMMP0\AF)?J+W[[aDZ>;V4g?4+:-ZH19CE.e
HYc])(Y]DZ88V0RdAF&bU8R+McQ5&W,f[2K(PbFLMI)>K\G[:A:T_G)T?..ERQ<a
0R(4YaL(AFQb34@]5NDMI94EZFc@FQ_<d6=N2RN]Q+]&T+X4UB4S-YIXVJSfNSD[
R7&.HPJI\VS^9GF2A3ZB3f,G5[^]Ob2e8&GD^/DeT_?QBP;W5-g\a..R-cQQ^ZLD
^cb44f>)JUWA&(<a9Q/I]-<dO7K>[DgT(D7/B^[gVdI3d5G.B1Q1-8OYB++f_T5L
5L&WI0UCgBV^QW2W6(2[8C8af6(4>.5J/cGdIYb@\g-X2I1OX/5^eZXKTg+0LMT.
0b6D0bc(_<P_#5gKI@LB4OL>Q25Y+c2)g-26=FbB>AEEE[>\=aOHRVM0bWNXdV8-
>=2,:>aE\AXSWKL/2_)5,1RCU^?HeVf[FF+IP+P4YT_<LD8+=#A;6/X;>#-:#,Tf
^1TB[6M_8K:]6F_Z[OQb=5BgXLeH.L#FEVG@IK]Y@7S<)#@XcVDX&D1DSM3(;8]?
L,LFEG-ZfF>Ta)?EcOXD&A?WK]eV.)S1^;,eC\>aP@,T1J/5.6FMAUW#2SZ@>dUf
D86f[?;N<#&:b6)@=b;4f##(LC.BWY818)+W6?N_;/-8BXN)TA\D?c1,KJCIfO5:
:#&HT:g0/MI9AJXg-1e3GK(YcK3V^D7&7^R\-Jf7f=4SSVa=XDL5X^3Y<XUcb9=J
,NeK[<TCS_+I=G+<@6f<D#X5cGPeJ,SDHR6MRJL;E+MR@>9gTgPF)@;U;;TU:>c[
)V+2A6PS)U_@(R1)JcN^=T=^@N\2?CR16KC@GePD>:VZ3cK_da8-gf^5[M:b^0&Z
_AMT^1U)@H]Og:FWK;Tb)\9QfV1L]UaEaMIX/3IFY7XL_NXA/</R]NR4PXSEFND9
ggGS\2U\1Q1]Bf15K-Sf]PCOb094M0g+[TI\V?@[<ATIQdAV/5;aH23\1KL^E:I[
Q6_9JbS^5W.J[+fM-K)<]W)(1e2X02#P+2+fbJ#J6&GgcJGQB9I?D@G=H/69BIf\
A:&Cc2c2;<6U<2MN74:VZ?^D?V@-9=NBJ7^fLVT4YETE#8;f->_U\=IUe(=b6d7_
32Pfd44c->b0J([(-RK&;X+(-3U(5ef):8ET)g,Xd2(@<N<DBDa]_=&_4G[>K)H<
(-GEW;9[63A98Xcc.g\HLKE[c)aR.;PD_Q^--[[QFICMdRU,B/0H8C94F&(3Fa/&
6C7>.)3B=e;/&#O:d=>L/@P<bB3:Ma1+MVYGA.E@aW;_))>0D-eVf@#Z4\R@M&JD
/(,fCQQ<b(M73B0EJd[W_;O.LPIba0F,X?N-Kb;X/@[F:>6TWI+L_1@@Se,4S@b5
?EN[ATWY[EXD^K5F&2J4)7YDbC:c2AH1@@S2CPDC/NXSRL7e-O0B([ZG#L,5G6(>
ZGHbL\eA]TWdD@I=)P&?74UTQ8-&-X^I#8_ZW2,cQf[LKT3.H##<N\(eb&.(aC9Q
R=]DCZAV_.Mb=VW72\OR7cP29(d6=bEEfP_6E]UB/S8TW3<]LSJ+FPPI^2O,D+1d
^?Z;5C^)MWJ4GYUSL[B;<ENJ&BfLfJ:H#cY\H>&BK-(eYKPI><W=4dSXVW.@<c<:
/a:b>C\]K,@4UaGC2@8I(-IVZ.33;X-7B]HXL.#7>U)beDTU<6ESV:J4dEU@GKOQ
@WJ2G7SH7E.fe4Q\eQFG6OQ0PJTQ\I[A[LQ@:aAT;1c:(LeWGgI\O/P7&\c[/aT:
Y,S@L/ST#).X,7ZWaMCgI^PMPJ\E50:MGT3Y7]RYB[;R7L.=&<\0<g_C^C9J9[Dc
JXNH6:,;,MVAD(GWQRF8+b#8JV0S-]L3F#bNM&8(gXMAWDKU7bJ8U?WF>QgL;9g<
<8LVE[FA?_e0->531UYg6dKGSHc]7>[F(3=N69N1HZRL<L:=_OFL^,LS&d=PB?ba
>3571C[+J,g=\V5AQA^:c,[@[F4d(].B3aHaQfZM>E<YE1?(:CXb\-B(3&))@-e6
W;;ETfdBA33KfW?O)9?0(59C)LD?]I-9#=.NNC5PR:TCcf\B3S2WQ3O5^8):-eEe
VSC97F?G@ZXMK):Y8:P\-G;A[a4EIQ[_LBa_<7#3?R3b<JG0,gCOT6cSV]:Y\/;Y
.@AfQXMa68^+7?c=U;T6WR@(5ZS4cIF-Vb)M)Y+(a<-8J26]fadNL[&U6P9\>fT<
:5bR/#AR=Q>2#fEIHfXccg:\O<[5R)4CV:4P&[A7YO2R)SZ4K-JQ<)fQP6E,X:>E
DJ2PE-WB,D/d6=+g@\6Cg:7&bU2X;5:H5[be72GOOHY_K?69b(=[/OA2D&&?8Y-J
JAb06GO@TY&HfV^U^_d?IV,JR7b1L8d1/=J<4=c]L-K-HF>K(\K13d^FUXWJ)PXD
d5#IN#VGJHFBB61g)^e9Qcb&YI^T0X><QN>;N7&=15?Wb4[g9)4)=AM]G]c7eO1M
O,HI+SHR@IaDMd0J25S/,+@&b082.O45Qb/(7_O&cS^J?VfGbKOV_OLR,KGO^?cK
(;[2fe;YW[6<X+^/:g4>aJ,dL]3;[Gf]VHYfTU>gJ)>=]V&B,U:LFB)?Lc)?&QI<
.XRPe.bgZ#\dE=1E]&,7TeZg^)560+LFPRaQ]Kf]Ce>AL^SgBa7S0,+A\PD_;TGa
<g@1V_2QLdC1c/T5H&KHLFRGOCfA;]K@NEMJ=U8cS^T+\>#&&B6=B_&A)Y2TXL)J
XZ0JLgN=&GeXf<E2;g<e?4RMOIfH==TMXD4Ad.PgCdGAg-T:;(,NG=M?[NJI^bB,
Kc)eKJR7S0abbbYKAS@IL4SIW)b>2O>N^+1,3LAbVgT3D,-e2RT]6P#\Y^>=4cGa
ZL[C9P[eK]F-/e8.O2:Id6Q[Vg0W8FP#:_1TP762^4:[@1S1<gDAIQDPXHB[DMV<
_/(0bAHd^,NI46=/aZ>-B9/XWNMMGNEbMV)-N(;/[F;]@e\)ECe])9B/^HI3Y,G#
gCL[EKJ4_92;&[gUD_d@aaB&Ad^d;F,=8\XI4QdN#4:BLg5ac2=7f/Qa5^/8.Q<U
D<#6]2.VMI.U^:@&.18:e.fdMLSBAZO;WbSMI@fJLH(=5DH(\=57c5Z,_[VSOH?4
#Y-;bNX9g#V-S8-(F[J:C;=[a8Q,LcWUG0-ZSGeOXZHBCH+O)JCgWUS/eMKDHb5=
N,,,fU8_,A3S2c/B6KQR>O@c1Ae#J1#b,9H6>O/KHR+^eZEMC@&>=SV40IKHY-+R
TD29:\^..abK/4,3>RE_.eOV2)PN/-B=X5P(.;aMCH]CT_W#93GW;bDVBRCc@X0Q
JWY^HJ3^IPJ6?4.14.LGZ>1gBOe&ReU;LB_LQ(8(ICTU9@HF69\2dFQPHM>eD5Y6
\][T?<_f/5H8Z=::SfG;YJS)8Y,>5\FcaTO@0SZJ9e\cVc^Od4#KKN.dR/F&Ig-M
>Z+])gD-JKOK=g:D5N\V&0;QKE9)F=3FJU;D5M1T5,42e++ZgC7X>P@>&_I[CE]A
5E1ZR\Z/5;<B#b;4LEO8OYUJ03[^207MJHVWO8&->=I-bH30S76A:+;]-XI5M3+H
[:LS2KeD<4R-34J6L)K^==c(2^19D^-\G0aCCYN,YBeZPT\Kb[6<IK_Y#+FBP@SZ
88d4fOdEVD@)2A]]MO3.Q<VS_a:H,F3Z2]0;O0E_UCI&[CPJ8DG);9bFGKaU/4/[
QOH)XTW&26\=VX7-288#cOO^/HcD=-a@<Yd4VH+eQGU_WU\C\,M#V;G^@KAI4L/\
,O_S,T=M&J-T,ZFSR,E-O:7Z4[\XObd=I+D<=\0^Q:AGO8aE<884Z3(#&UXJ62>0
RNQXE_8?2R:c545<?;<VBL:d?OOc==c9Q<];C:H=G)0MVg?f(H&>A9XTMZ-^4Q7?
6](DfK2.VZFJFc/.Q5BHTcW48AD&ACC<e3(2R]D4VXP04=)HO:8C[&^+A)^/(<d\
UR\8cbI/,U5Dg:Q(O:Vgg?G(T04&GJ(I_e<@\K:TRW]]cSZ9,g-S]\fMJdF[VY],
93Y;gI;Hg=S6MA(9^L\V:Y[@&UbeF/&+-7Pa+)RIRWH??Y+YRO]J.[-SPWMcRKA2
3OWYV8Qc/UBNJMX\>6M.+8Q-=CLPARTJ:@ZE@1O)L&Y&#dRD&CK(S/B4aC/;H+7;
;3DE&?7HVWM[\[C>W;76DM2+V=)B98_+H(=KU]V\>OV[Y=:A\=a#TYTb.XeZ3ZM8
b]BZ5&1Le]BbP(3J0+18]aP1M+OJcc9BU<eY-VZE]IAAP;.]c7]@<c1&E(59[B1:
:cg8Kd:E^.5I^@O<XYE#gIO@HJZ=[7L3Nd8e.#Q0<_eb(dMWa\bHg0e[gI3X@@53
>5IaE-e=?TW3Xg+52TN6d478#DC#OP99TKW=#eFS5+M,^14BWa20DPXI>Y@?VC@W
[-1^Z&\-_DG7<W-(6B-TI:-^e;bOK^Y70K7EdYQ2UC\)ZcfQOd;E3bFWDBJQZW7V
4D(12\c3(/HFcSRgL5SO/P]>=Z;2LJMg>^^B@2N.L(N8H3]f9LIQTgRJZ0\@IBd,
)O#I3+2,g#J]_R9O=T/^XKfT/^eY<UP&6\LZH>DT&42V#S+)-24Cdf#DJ2#CH)K,
)U<[=-O#F]^8<bN&<ZX9-6D4B>^+0K+_CTOJ9L9/1@gP/ZQO4JC=,(<,C8/I3AN5
LS_bT.SQ=P0e5Z:?,_a2H_GfQR-AX9YeeAY;:\9G2ILD[>3P3Ff@8f;>/-5U@,F+
U<010.SfHPJ0cgR0:+.4V:Sd\&&7DbC;L>I:92/5(\NJ[,XWd]68\bA([MMMTG]U
0W1U[0M\e[gECP.EV.gX#_3ZfI:gcQ9GR@>&/7SKg=2+KT96<7.MdK,#L4GUXd0=
#;PGGD6/(LTdeFRI.c\GOBFUb2>,<YSf]VdS9(#a[JD+?]^P4GYeYNX:RS;78KLX
ICA6Q[X<DQ4P+;-75<_X69EFRB+KZ^R^[faQ8X<YFaHY57dOH@I0e?QP-bGB4D/W
[S.NTd3@_<;53+RJA4\672;#P60DGE3PLZ/8(R99#d7@OHTPRUB^@S)5Pg#c@KZ?
GaRQ,Z<A8e0<M+3:O6Ab.LFWDWBC;4>;d6/\@+WM;.BK)=+FVeM>^X&6XHN;T>?I
T9Td6JdeU7.(Q<NWSCbX\XS=\7?J[Sf.9ONX>F3[LcIFcM?ZBb>@;dBCV4S?P44#
X+W,gS;/8^dHD=ggOXZ=Y;f-,4W9e\e&.>b(>)(0FCbKeV42F_Z;-8,)T.D:AKMZ
NDYc^C]d;baF;AX?KgIL2Z9cU+8(^gbAbZ(LO/:>AHdTdJKaGL4g(7:WIX_dJPXc
L^Z<0bX=46G&>dF3df&-:2V^7a4R[,JZKd@YB91CO/8;.W6GC@Z5/Ac)NfF0K]W5
4-?G-(6g-VcB2)7JMQeS^bXNE(aAF#0<G654Zb><XX\L6@KY\RbC18851()Q3e18
[Y,Y5c+<\aU\gb_Y&Jg8FF+^10#.S1M.&@-0G+@4RS54^(1KXUFZ-fV8IRPFGdB:
__)W6?F&)8/Z]LLEWF59:_\bK&I?E(GHE>KPaO3?[eKL:J2bfW8-9C[RBPcLN1UB
9QB0=IFZ([+-OIDc+G:_=+HG8:@:>I@P>-T]LP6CA;P(5M.=g6CP+Tb:a+]+[W9>
G(7^LOQMZ8;+@Hb#CUV68X1?UQ8>1HC@-;3EJSCX4N:c.\EI#8g56K._=g=OE?_b
Z_J]_>-A/7CQW7;S>C8,S4P9L(6[_2&8Xg4;JdQ\:O07O#[RINFAN6B_^<W7J\MS
FA:eZFTScU,]XeO_:KR+L/V;SLW+I.#d:4cA0RVCaI#1TE3SARH^KaP1Y>5_2.V>
6_SJ0Z]<N=M=&6d]2/29K@9HCe_b<H#9(IP<fFANG/L&8@7<A9;Z,MX\=0bLUV:H
Y=_OK@@M6CLMg3HKUPQKS_ILM.XI9X),];&Q_7370?g]>6A961E7c<L\\68bR@g,
,F<P;;..f#T@?&5@YRTe;KPcFW@BHV0T9Db)^K)(T\g]\F[:T8KMVNM:=R,e<;Me
bYW[X\D#b.fU<I7U?;CGeUOeV#Uad[QA/7=f.HNL3gTZUMMD)CGFJ<1&;8a;AD2Q
@X:WTXge>6GZ2RGMBJ-P#>87-@2@3G+X]Z-[V@&.\?-YFWHcgWJ,;M5Cf0.?X>Of
.2J9.+/FLaVHT>X@)^gDYZe#f;\?HTV,aYUC6-ScCU?O+PaE_,K,>KQ?M^]-Df#-
Q-ANGE@UDeK.A[M-PV/MfTP^cK?fJ,>-Q:L,Y^E#.UIOgNKGH,1EY9^V2/X8<#W+
SX^17S#cM<\^]HH3Icd=U7VL&PD;,TK]WJODC5IY/c+dKU^f1IHIAc2=VQaTVU&=
KeT[H(RU/a5\CIL&=@]F37H;S#34(?J)#WMH/QT:&PYF:EV#568X(KG1)TGJ2H2:
0(3=1e3^SY=gKR5&AB#X4R/A^X[<R(N7ged>#M/aV_TWWHc^d(B3;30YHXWPg;Xb
1c,=fd_.#2:GIAN#.g<O7(8QKVKWTIC6b().#^4V.SDR:Fe]0[B5fdTXZUECe,\a
FD&7\cdT(K9>N0Q/gV.9H<NOFQZDYC[&#Y#2N[7EO>a#RC:NP/;.)UHbW7IRY5C)
.3eA^#HTA]EUZ.+HdSgZH6OLW&C-C[6/1J1]e@3&c@#d1cb#^C,:P=g<FAfV#)7-
gf32LgKc3EM?e4g@^EZ0RbUE0B:3FN#:N=LUMVEL2Xef[ZgE]?e/(aN=)EWbEJ&=
U=(3+5P<3IIf6g&&=]YKJBbf14_AF:fG<GgYM&L4Mf8SZe8c^,+IDC/a+,/SS&U?
\3@:[K^I?E@Rb/.YHAbHaSf7L8O5::&E,SNa^:V1\W;Z_D;9fJEEE\d:IRP]PYcK
>;fVXO,7(^A]1e9d;]5YC^eNL(;Jb[JafTCAD-JX;aggf05->gK.)38I-.-d_65(
3-&V5M:fQPF5:7JQ6<NA>4OAL=eY5R/U&_6+5;N@gS<,J]fMP]8HIAc[Z)KPa+EE
CRFG5AZ4E-HcT_]]C=CKLX;>V?0\E:Z&&6D&=,RT6@UZP\=85[QH.KJJ[Jd_20e0
LceW),G=PWgd0]5cLecc)68?3?GPWHQcI90G)?]8JH)F9#Fd0=.#<gQ2M8(V=-Sd
d:BL>^6:E#>\/?g=NB7bD@DI.;:;.SR\]AQ]8\2gX>91U_NIfYEQY_K,8CafXO\[
;fb+?_=5J796UfeP\RCcLJFf(TZ:GEg62HND_71==HP0A]0O4\3WQ0PC83W[6Se\
E0Tc@AXF]EX2Y4AX/=PC8M01D<9(d^(WW@DeSP+7_9QI/47Q935(R>(4FD<#NWS<
<R1@N;L.:^NVK;a[35YS__@+PS;GEGCX),dg=,d)-6REOOD7JB-H/^-9E/5O<Bc#
UTY-948()GQFCH5<D]T7\d#Q:E7E&3HO6)Rc,JQO4+=RZ.f/3;Qbd6b1F_N(\(3[
-,5ZD,#YT9.M#9cHcH:45JKU[3IF@L+2H6.9<#?ISc784>JcX,9>UA+\M(MV?f>Y
MX-dK1/G3_T#c(ga=;HXGG)7bgK.F,Jc#9LB&7,CZb<=b90M6#dNefMZJY]JEcIJ
)VK,^9<X1]]JVPf=BO;dK3Se>^JNL>D;AGR.&>ab-YR4125gC;Q3&03^d+e@KHe.
01MVL,]M:5J//&9QZ0f1GS>PPU=<WS<KDfVdITIe]8;M;(5.OAMGOXWbO,B_1[_f
CY&47MT.?&e+EVG[Dc6E[KTBOdD)XEDGY;d38TFb(IZM9LEK+@?d+F-F7Nc2b34E
<+)A\B^JS?TI9K@A8.W7N3[&@K<K,UH\JA]8=#>&_(W22^<./\X6;)L,X_J&BGJT
[K)D=JG5P?Zc2fJ9=&R)1OS&5BEWIN&UNM[=QdfCAYV][?.I:e?ZBA4.beJ\>Z)B
\2ANBUE3(f-PANgV#W]FEd]U_0;,;D?=M,AA?17#\?HaeJ#g3&-3I0EQHLLA)<b,
QVSCMXCK:@JQWXDfXe.,<,LON#_H)<U2@]C8O&RPPaf,I/#NZH7GQ4^_=E,e:81X
ZBY(f;?]9TR5KKbQb91GGBZ,_-GX-?cWOcQggH?D>1:;I;8OA>LS^Mc5\;A/U\ZU
GBU[^>MdfUU9+WQ^2O1cFW;:&f<92/e4-M9#2QAMDcWG<Q3XJ\Zbe/=EY]/W(Y)7
81+C3,g4;W<F6(VD1bCG_d1+LOCgCc?K:[XQcL\_GWe0Ef-8E\aIH=\,PA\1+We\
0ff=bU#NE4>6?+AS>M3+XM4V-9Y9FD/b,Of2=b\1LZ.MG:fb-TbHCW2f)C1UR=Fa
e;=9b3Df&G26NcT8X+GEbAT9&H]bV>KMc.<A5<?O,34,\:3;]?K?Lg5GNK<H]]#+
1U[P1YW43X5,P6A[C\MTf#,^5-d^VfB,^9:e9cg^O9E15O#M;DQUgFbc_[T1ML&?
U;ZdcJaQ\4fXScgOdb](WJ/P0Yb(cf,I1YA#I;Y\P,,->-DF171ZA7^Rg]-V-GOW
I6P+/dXG2P-+9SKT5CgTS56ee3Z&Hd8/3;>Kfb69&fQ5I/bLaU8X\\XXWDXU?fb&
P.W=->S48IM.@c.QMA0-dFcI80LGBICFZLc:JL=MgQUM+cbE^(;dO]):.9H3E,-G
)&K:7@^PAa#];Md+QeQ>_Wb3NPEgc1:8^T^1IaUGS&K+-[:1Y2)dQX0N91EU,b-;
+T-?LC=e.JDC-Y0CE.a_(D+X),C&b98&J\9f0STX8EW6D4eGc)ZCaXG9:^PF&>gE
O#+9)0-CQ,65>-9<JNeR.[=&TC#R:=f=@76I2.I>K)R.S.C>fY,/T<\b;#&eMYb^
^KD\fEdcT+&+@dG[Z#;@B45e0AOfd=-P^C]1?[1dATWU59aEUeNLc1I2RgU]Pd2K
41ZBFfTZQP\DKXDM]AD0de/L0//CIWO=Df&F^Q6)AW)=2O0F(Y_K+(\L3Wgd7#J^
83c[ZR]O;;PA#fg\(9(17>=/UZX8ObJPOXN]=.;V([NcHc3d0-,=C#aBcH(PL&5,
V]G2__H)@MIC&]+B21(TXcNc(UZNbJI+9X-^+G@REV73F?\JVLRRBQc)3+STWG2f
7^L8eO6^?OcJ?-dM5JIWYQ:g6e4:8UIPVf9Kg7=RSOUH.]DD7Q0aCb9<eAF9<[F/
S]W&Nc+?ZCNM2f.D&N7QEYZGB^dES#\;X4K2#Z[K+CFdP1&U99_R^86L)N84&#MZ
#Jg/?\QR)M-Q/2);XV4,RdINS\I/5?2F5aD8T\f)+\e0<CEMR9]Sg4]6F/Ka=0:G
6UZ(@78GXZD3dQSVbScaM)cYDZ#CWYYL(+-Vc(HY:XT03=c5Cb79;b_R#_J=-KPa
;WDY]=M+N&LZR;YECYK10:A<)VS#G:56\ZfM@WH645S:X>7EF-0@05Hd,::=KQ2W
#QYc9RFD:cT5?DI[a1aSRN)FT9eH>de]5\.Y4cG/D6)YSF1)^>0/=b\L#&+LFWHd
,TfA3/Bf3Z0g-O[\?P3<D_dNfeBK+5#8gUWP7^F_=]\FJL:2:QE)4VFR7K09OOJ4
UEN;aAC]1T7T8/WB&PJ;-(J+5RYGd37Z[>4+:Mc6Z4Q,1^>S540V[=W9QTH&EL<c
U<YJ]Lg,AGBJQ2G<fHAQD\OEV5#=A+-OGg+_MK?SdZT/E\?8RMSQ+DJ=[?;E:#/3
fTb?M+bfRBSM22N&ZFAIg@+GIacd)I=cKMQ2IG\=C&+H&1+-T1HALNE8U2GOHTZ9
?BS2P[5)<>c,2PWYNXN[J-UXfCIf>[>^+3MSKX(Wd,HV(DTN/J^QTP0XXbEdT,(b
JKC)bRg2\\Yg7E6RRg&^ac-DWIL=6K=#:Y;#KL6f9cVN@cLeVI8&S0^@I66P1Z\Y
?&^fPM?+.+&=?@0a&7SS)-KN^,/6(<^=V6S-<9VBUb:^-\GW\0]F[Z-JER1R07U,
6)2g;>@4Ra2#QWH-DGC9HP,B/8VE3ecPV^;@8PYN><-?#GS=92)6LO+eNdb^4MBC
V]fDDfL5W^=+^Qfa86W_.L.daeNbW7L[2N2@T27;_:)c.B,NWHJ-3AI>ReH.SM?L
4MS/OLaTLXP_aH7;8-1e<3\EH:5#)C)Ob6,UYC<48?)[fbe>:EI(UM]H][05ZV^<
]8:E.?8,&GA\[/a+&d>&f14Dd5^[PN8>EEGI9.T]/+ASB;f-ZS(13+TIfCM67:G0
4E_:U:#>KSB,AaUTXN;6_-.;0<eSI&=/cQ;RQI;CPMS,gUQMUEW@,XM:_#V+3d#e
aDQ3E-DOOF?2DefK_E\0AeK[HdUKK.JaabM(NYJ_D\gLdY5BFBcY\H]2+M[(V3Od
#aBDJaCTe-d?Bg-Pd?^+:.[2g\2<4M?c/6ZCg#=/>4QSaEQ:N)F(FDgBe,W7d\^>
D]-Q-c8E@:5.ZNY\<b=I>[.Z)IKH->=^V^7O#PE[Q@G;/ZDC6]>gAcB(<a#F<TZ#
CN_S&HHT)HMDfe2ZLDB6)6TAW.C8##I:DM6g345B,1[IT)<c/<<Y@;E\J1_abMK\
WcWG(a.@K5+Z,da&[&gLOcAEdT^/F2b&WeA6)d;(3eC@9L?9M7^5\\CZ1cgGa#@A
Z.<G#^A/V269<#?#^_[/PM/4DN].bd6;DBZ]@^Nbc9._AgI[e_[ged(4D>DF.5Tc
U+c^g9WZ#(<+T-b#.JH;6NJCOM=?aNf:cKYb^B7K8MXA4dD.GaVfYUGMS>HAEaB;
O<YOK@U_:Ld),1US-)\K\:f;4cN4,U2H?:EL44>VAGPZ2[eD9\0F+9/=)H8/D39Y
;@a()a683],H/A\:IfT@_)-1X&@]RWaMPC<MHSV.H<L?9V4.U>U.ASBe3HP2XW=2
.)LO0_:)QB?/Q8>#(d3ZL.1AF7XE@)->4\E+>NZ#E:DST;VHP=+d[)^;FMQ[c/QU
EEe=U??IC7X)3RT/Fg8O1^&f0Y=6?B4D[g5-b;>@BH;XQA?_VC0KTJ9C<Va)H@gb
MFU-\P);II?3L):W3We3KI@V-6]3M\QeMDZ-=-T;Z8[Pf-8R?.NKR@AB#6([Z&E?
+c3)C,cTN?7MBGaNMLIH@BWGWVR^?fDQF/18H?](\2FVf(?/dFCgXW==P><N2fE2
);^bJPMADRZ-GJL0DTF@-])<13M92R&KQKS4HFVNV9WHC76eR_eaCfW]GMODT&Rc
YYFeS8FJ(K242?W+)2RQP^E8;X\L-51E#D2gH;a)RUW?=M@f6.[((ag[/.K&[D><
F4E01T1UX0&:NNS&8VTRUM0;DG3;HeeE(\c;>]e_U7[JE#GJ,D2Y<g@1C3a3QRHO
-I;fV/eUUNffYDVKRQZ^dHT(A>@f]#THd-f(9Tf@Bg_(]1^TO9aJeI3@J^WSHP8;
A&\]CPaaR&0bc4CW9D,JAM>+2D(BW>+0JJQF7.VYTL^Y3U0/Yb&_60bcPR3_OY.?
RV;d->ZcV914,BKbUND7Y2a3Q7;/82V.BgI5d;7TIZ=AT_a:eWK,FMc;T=faf\0Z
Z5UBBcJ(N&31:#VOffIPA(O2&_Y#aT/^U-_D1<O:MD_]UDW?/R572FA5.aNCZ>L>
0b3f<Tc=:gW.;<2RQHD&)RKW:fc#F?N6,G]^W4:gGZa5R][G3>I(]\>-U;gaR7Q<
;2]S:<MNZ(^OZ.,X)[@dC<I;0RGe=H4IBL9a,HB0H3HN0KYCCB.1THV.+N]d)cCS
bK9?]9Z:dU@DSERJ9.WEUfFHL@==M^\>#8Qe.TPd[GD<R\=TUN?cOR;F[B_I])BZ
UE_AM1_UONcQ6INPIP-(\O0DM7U/,U(.+]b[SSZ2.8F^YOA?YM^CaT22Y0Ad\B2#
(P(^OEY[agbMZ=AECc/dc+=&)b;/K7g7ZOfEY[C\4#LE2V#,.7V;c_cB)0GMXc.L
ZGIZ?PS])5f5K?d\&I-.AX#JQD&b>><WDZV9Q3EVRVfTBe3aW?&KUX:0b2d]GN0b
[OSGTe+fEUNbfC]T]R4b:22/2Z#,B\dCG/A-eDO(W+>U8)G7H-1#b/9SCa[/FaU=
0]#L:8DPSWg=:-#),c2ac]/KYHfJ[=YQcWeLaVSK+T]O5WB=9=663CO68Pg4SD3?
8WSKOMaa=I2/43KOP[R;:;&HJDX]5c&^8K_c3+5U;b8?PK92^&\?FcS\F:d@SFA0
5EYKEFQTBPN=,W)4482ZBQN(42@_]:3-f5QL#_Y&W/@\=Lag>,UXV?221[TNH)VK
C?]:B))55f5T:^#9eB]N\c[?_S\aCYG/-5(L1T362.A2E+]&YgAG(:Rg5N+EM1^R
Kga=OQa+P<)PP74-:@,HaZa(N3^?X0-;2Mfg\.]-0gDf9Lg>3X\SU=7-B@?OER-b
QLW-P>CA2a?A?550Z\_@gR5&DJQO,Z+GCBT@28<@.^MBb\1A]]==Q)]LaKP+(6OS
),[]^;Dc5U)2:PN@2g]7TFgVN^3Dd-R2dbTG2QI#aH)c14S3;]5/3O[P\.Y7GA61
@@,,M[;6W5UJNUI+I<5<>c;Z9Y1BD#[IZAB)1IK&U+EY=/J>W@UY#ZAX45aLe2\F
1DQ]QF>U//R=\V3=>8?IA73GbD#J&+NWOLb3C?10VJ<<;BQQ>NM3S<-4XX<4K0^0
6.Z\/LT;=@B44+SP:8(;QQCTg[<B=S@+Va\]DRE#8_a8FQ;dPN0IW93B?&Y=H4^N
)#5g;(YAbN65\2IG>&:^WaDB1VRFYNX&R(XOHAaECc<;E9A=7+]e\YWIS41e26b[
Z86K^[4#W]PM?5,e^f3VGdV\TZO+c/FMFY=([>R,:U&M<[b5O<+PL)2R;^8gXc>L
1W==:MJg&6L92<]fM4-Fdf:<R@9R0BR?3D/&=&-16,.)f&3a\+1[FTgEPLM/E=3A
EA2I5?TC-@QVSCFfOR0DY^=ZJ1Q:Y0g+]/f&g&K_SN,W1WI]X(WHg5:)eOaL3Y5)
^M#UKALbMAWf1^\?+c32.KT](/V.N[g+<,DKe..W0-I0.-<>0#eI15EYM);eP\aI
JCQQ;@ACc1(C3L(,bAW@Y><>LX;C+=+.DY,SS1[A^RJ&+^46QA]E@WeE-U+[1efB
MO\J3A5Y;a>eRd1V4,I?HA;]W2;KW2H5D1<DVa_GJ5Z7,;c&1,G5L;SRPY[BI[9J
/UafKV_1RWb1V)4UZSWO(:=8XN)fSN4Y,JP05E]eHd9FPA1?_;);P4)3P4VgacM4
9HAG<BNAaE8=76^f3T^Q(A/_e0AHcf>L\.2ec2MRd(gS9QE02O=PG;bB/gMNUWR/
b+[I3QV&gKJbg_Nea:168ESSK1N-2&J#?A7H/D5bG@(2;Ha-#Q#\V&B:U@FBUb83
)WC)CG?JE9.:WJ5722EPf.)/(e+gKP)Q_8CbH_:@P/HZKVF;([+;L:0N#5N@7MVD
?]E)[WI3DJ8=:-=9J0.HM;9#N.b]cY_7/M[=LO[Qb:V7G:?,)=eU7-N<>CKLQ/bM
K1fR[XEe9062H3G;OPCCd<-SLDXE<8JQ=-\&G50cYO7cE:f0Y1VLI8eSaCJLPVbC
M1W[[HZ5O)B1^KD[==K[V\dMTA7,Z9<8]2Md.647a&<EQXM[8B7B/dT:QUVJ._f3
,3V[4UTBI>:_:-(#.ALFdd-)2BT?QS^cB#UMBP?S=Pe140H5[W5c#WSeULBAD6P6
V=/=H(,WEDadV92=]R7f+5=dLa\H[OG7bO0g+EGNNcY>^B:=cAS79EgUT@@<(2+2
-T;]W7g]SAaWFK5YF+b[O4bX?g<#K0B9>?eQEf8ST,bWd:,;_5^A\DK]b\Nba,1_
V=X<b(:=OX@7@)HLD;RO.2E[5F9db2/.CME\AP0QD\:Y<YS5)fWPU:+IIDYL),E@
R5C-ERG[&ROA6N2K9.S#VSYWJMJ:3G#D)P,?]C0)P=:U]\35&/QXVVWK1?fO-8QR
ce,33DL::eW\;Pd0)J0>@Be49/4Ra_\TG;-2N=Q#LGC8+7IGQA#/O&V^9T8--GRK
72JDF4Y:T-\<49OTOW^@CH-,&@KHI147H,/2OPA^HB.6GPRHgRbdE[23+37AA+8G
W<:QX[T^-,9.WX=JgCK=//eO6J8PRSD-VQC<N@EPc:?>@R;@b:./Y@>_IWbJW1T:
XDOF:AU>d[SWX(MBg^TB:fe&D82XKU-M&;gOOPe3UB/I_FP>OgeY96b6S-;I92)G
]A4V(1bP@T)RSQ54Ee8L2)\)KYR3A=A,GDB.W080cXK&^c=QCH2066d7[P5DP4=R
+_HG4]\:);;ASS2[5G_FJFCZI#PN+->&6<L/#P4G&=O=WcJ;Uc6;UPR,X^[HY4(I
#NE8+ORSbbI6W.Ba&d;SK_(QJ.Sg7(EcP6D33@(V0[_<JeFVf&1:92,]@HY@Ab[]
2B;N>W0V=W)0FUgX7JEKN\EaL>2O3>(W^A_@DR[b?P7&:(>H:HU&g3+F>=d.Z>Gc
2=e#=2GLc\1&[>0[W/I+g?O)3ZTO:SPdKaIZU82^MbJ=((1AD:N9J-(M#2+f?P,/
C87DE]HQ)T?54NT[DcL]:4ZVU3EDLHNQ_-#)<C?d0>6EQ70,:#TZ6A64gE&+7H=L
7K&&U@73]b,]:1fgXF@)(8559g&29^M9;WBfAf>Q(:J@(H-gT5Zd#-\6F8/6g7LZ
#)\_8CRWC-^Z)QYf;6A_3VS([W\H^/8:DJgAY4ID4XTd;S]4\_eV/:N/PAU.HC@Q
<HQaf:?N[feSWJ]g9-XIaKQIX6J5_]2K?4B8aOL5GQOLFc#2ZQ0XXE^4E:Ofecc9
3#KJ?D<ReH:@OF2e]HUU--WY.F?6P=?O4Z@Pga.EeO4bZc:(5;)2>.RI_5UO6X3<
Z7R=2Vaa54-5dKBJ1O0<(=@YQ386PD)K#A]&[5,&.MV7@Z0-\,//UV@057,1+9](
W3dB]TZ#=aQIV1D8M:I\AS8.8PVfZ50(I>?VLEZe^EC\HbXSgFEa11EgP9B#1GRf
PS6(3_89/#;^6?\L>PNN-,CW38S=GT74EZPdM]@=V6d\TY[.Kb@F<D_6J8eYCM13
g/F<&XVLf6Qea&fA=?E5,gA98b>OgVAaM@_]&eeNd^MJgT<C?3^D64,e>8+]K[6Q
c@NMQFFa5F9OAOeFWM&;a(()?aJ2B[a>7[0)JNVVU=b0&KQeU^ND7KLVQ2K(B-/-
\_ZUS>C:2FASEF8-1;>IE_^J4c#+g0d@e9:U[Y=B<AKQB2WB>c7I]\>/cTBD80&J
gS8ag/BQcMXRWV^3Q>-VX=a[,0f#(39_C\b<(>7d5b5?U#)&EM=X+:=.;1@f,:6a
HY@52<26a@[N2Y)KPL9\5IZU6Q7<Ve=V=RT26g8SMM;I?Uc(9;NL6D1Y<1Fe7,,e
0:7Ic?(@7Jec7ONQ#CA##0IDH/QLSC^-1bA(4+60:M<@FAH.=B;IcU+bN(gEL0W.
=H[V1E#WTWA<&^Vb@c)A::RF88QJ_feXN#XfbN(KNfO_g+EFaN3V:4?IAN_)1Og1
?W&IF^e+NVgdXNGI]BZdcdZ?Xf-ZJ0?=H.NL+P=]?L+fXV8a;JCA9B2/HOP>?861
F]4[Ia.VY6+#dM+]H0LD#>_NfS#JFN4Pe;S@ESNa(AT90Fe2INbT0GZ-P,Z3W])#
.ELV@22A;17D^1YMF9_6:WG/_#X^K)D4_LWS/,^BUDg0<N6;VX,;R#7NNU(\JH3<
A:-OB:SKX8:KEE^;c>OROg^C?#b)@<XePbKZJ[.#PV-C];[56&SB<U(#25.VgA&X
T9&88g\b+7Q0X4]HC<GS+]PY:]A(?46H7@<YfNVe,eW_\g-A:CSU^\_#G=5<HgF8
NP>;+/#dV+)7BBZXgW/96V9P+M:RRe;P1AC3G7#OS#]<+RC99SaI1:,^TNQU3QY/
G[FbI+Lc3O.;5d14G7:g\IX&[FQ?Z4P:5=ZTIf1G?5MHHZY53NLPT0A@0caF7&#O
QT]Rf\J>CJ)D/G:c7&0fCE4)9bM;=+5Q[gI132]eI5f.D;EQ>88=dDO-123]Y85>
SgQ+Y((VJLc4^Z_MF-Ob4/4[5JJC0HZURX]3XJ-&Nc=Qd3d#MGDd+H4\)5UT)CKU
fAJO)KGfbWVO[caH34^[M9[/^HTXb#P]/#IT1:>^Z2DUYN&YKcgQbP,YDFdO<W&[
fIPa+84e/RE2g[5/OVF-7/b42AW(LA6e+e+e&K]-H(c8g=K)2902d.9CRDb.+eZG
Md8+AfYSY5#?/NMA6]#f?MfcW6:O;7<5#C/?9T0UC=6BfZ.^:=+#CM4KKe#KO,JF
>WDCK>W;X_eDR6O]/Xb]VUV][6[9=36S\f(2b]_;G&9Jc=&gDVPR)#?S)OF#<P^T
8F.:=R-[XbeQOL3T#GN(EC05X8-GK-/IAe0,O?[[TMOXJHN88(6&7XX\]B=M76YH
S1&g4>7WO+OE=X8DHJXOc)5)L/BU^:A#\@UQ77ODWS@=S;C2M/4ecTVBN>_97BBH
Z[63#Z62<F5MR8K\:)J;[4B-dWB^NML(04GNS9F)HC\DJ&E)L]:50bS;EY0QT=eD
=5?=eF@[SIFJQ2T.YV@ecH&LBRG(]&,P9RR30g3S\dReM[BEBT+,DeQ9^QBD3e6_
V1&gY1edFVJ9@,5gQ>@JdDDc\01a8+G\4#X=+I;__509U,)9YbG<X5^?D_g/F=:c
NG838>BQ4E&+U<M9&a9?]_YX+C-MYVF.Yd&8?RE@NY)H+:HF(:2\/?[9@)V@E/f;
_(b4U5#F)GNc\A(BaL,d0aWI1H6=9:Z1XBFA_96JH5A?(YEW(H]YKM^BOZ#_d_U1
OfcJVYI81XH(/(c97MDGEJ&VU.ef-.:B8#+cJ8@DO5AHca8-.X]9/Y14c3bdP9,5
aH@0J#Tc5LRA0\=-HLTH)6&HVSF=\@]:V[L)9/35^Ib(/c,:Ce<^4aDEEM4[c24I
&N>52H(OM-@0GPV3W;AeOcH)E;.M7YU6U<Y]4#gYQAUX0Y<>FA8P>R>gL>@7AAB7
KWJK8L6NTE7QY5U+=/,1@3@]T&dZ8ON<1:1,,5&Q45B[g1AO.d75@HD7\AY]BPKC
WcfJ[DQ&<Z=X.ZC46&[41+57McL&-6Xg&@_GEDaQ7R8Dfa?ZRbNNMOG2PH.edGb@
=4RD-dCIOX+3&,)H5d:Ie/_1f.FBaD>6J,_T/#VG\S734?2+?:7_,&F;B#3_7f2-
.R<cX_J9Z)@^;S[d+WS\I^e6E7@H986SSgY06gVDZ\UOY1eN)F=7S&?/C]>Mc.&C
gK=N;fa;b_A&O?XTYB;R?S>>-UE#H<0T#eT>4XfS3@K(c<603d./K\]P8&LA>:@.
O<SReK0g&5dE,BcOVG(d[&:ME[UVAV&V@5FE19S#aOCR28[/-OT3e,LI]]D;3AXO
g+SN;&YY,RAI&FZJ[W=:#Wb>^7,ILb[TYS.[&][H3^8T.]Eb,L2QXaS[AJ7UU()M
^[:<f,b+F6gJb,,?G8Tf7e4T#6;XJ:)X)1EBG#8-]&1,OQNVgD1@gT;-42c)NdXg
X/[22T/CZ;#cJ01J^WaG\,;.UT87d1XTKY->[>Q,]4>0P3M;A:,@1Ra>H>g8F?b<
Z]>6P3)^6KP5E6>9Ab027DL2O<>&U&Y@dU6d[;Pf.DLSN+Df#T:dYf+3-8f(CEY:
-VHR82PIF_(TA]OC5@/-SgSEDAVeH9[.7F)VLOOPGgQ#Xe0_FM7?QYGOXXE2Q=+-
]=R(:D)a?gPT4.O/14,3+T5e_EKdfg:IVVKGJ-106\.GX)MY,;+[GNYE]<.YB:fe
5=;,2W<HDe,EI4F>8JL@a@6<\YCP)YdSX/_\\7H6NHG2XTVU?f]cO?;<_N7?G<0A
A50_DV5+_VY+A>c9V>XY7>_AeaEC@Pf2UE[MF0(HP&EEV?IDQ>1U,#)0(].3)bBM
Y>RRM#NZF=de2JP_K<K;/_+6&@99a?gfYP#\^O<A[Nf_B55#)H^<;?]Dcb^@0:;W
:S?ODNLYY\YeJ<W@f7=W#?V1Y9QbdF]T7-4PE>6<7Z+(E6aOA.)\4?O04\@e0CbH
L^\G-B3-Q:_eVd<CIV&XLg?[Z[db.c5de#[;_L>9@,9Y.1P)?_0IRMKUDH5C5cR:
FNc>0bgYZ@)fUU;6>6(eB<#/L;BbJOKF(&5;R5fFU;LY^]PP@Td<IB6=6:&[,EIK
KFPN>U6?&R;OTC(BcHSXc?;BYNE)0Ab8PR:f4)Z,/VW?9E)@&g=EQON0WU:CA1@;
_(R??214+Q2#7-4OX[aO@?fX:\JRCaG?5Sc;A+ab5IJBHQ\G4MZOGH1N4]&HM,4Y
MD0Hd2LO7748CDP0JJ7bPQFKg-HgO(<R<GES)1@SJOAC1S&BP(f7G/^)3/9ZNCKc
N6;N#;9C0gL@HKR(@ZK/^FCZO8-6JU6H1+SJRFObdG.E9V:TDL57gT2R:O.W?T4/
NIQ2fIP_Dg(:eBV7.NQ_(68Y3RQYAEN]TMBcZ+1J06GcIQ#-QZZB7L-c^4GP;V2C
ZL392ScE1b-ZeH?]<)cT)R?;,:@Q:e0>RFV7=,C\L>FD8GD?[b5/d9f)NBC+aV,C
>B#+]518?Wc[O[THfR3Y=+J6QK\XU&WCg)(]+K2N_9,PPP2U0SC?S<.I0JMQb?;\
1:d[81233YY:9Vb27e:5D,aSSALKKa#RX?MK@OTT;_TGM(3KX.X&fOZY>E[eMKGd
:c5(Kd;f^0UWWZCOW:29#1&1Se45X68J62bL)T#[BC1aK#+4ceUHU=ECIfML34Wg
:eO?GR4(F=_,B&]L]5RZf;HX)2XW9GW9+([\DFE#2)C#KLd3R=(J<d?LBYGBg]8A
>F[C6YEag>=T7gC^_H#5COAa&7,JY,a/>.:;3RV>;f(ZK_M5W2G,)dYD2&f#3\>S
\^XaAT)2(78H70&0YfG(/[2T50LKDYZKJ.;^08FJ<(1FT]=@P?L77=O.#Le?XRVF
g9=\5S>MWBb^XMI>5TOCcO_P:..=8/R_Mf=,F17eY9=FgHd7LUa1\;ES[=Y2^#,O
4QCW,^J2f+FbNG/0E^T9.9?J#FS04a;_KU7XBP(OD2JX9gfVAVKWPRdaONd,K06W
)b6_#=#2G(]Q]#<ZFgM[./X+GE#+4O(,+=BS;)8a:F+bCRZdd\K=1LM[^K0=aW#S
3\D6]U:#dOf.aK<(9d<X0ge5L8;gZ4#9I[7BGL:YRcLVG9_.2E#)?KEC7^/.4gI6
LSBHMcb_V@7<=RfJ3-GAF,#Z,B8GT1R5B\ML\IH[_B\/:580ZIJ]7YfMRHS93ALQ
1/,8aJ9O>d6]VI91F4CF:TUOBe@<Kg,0gC?_fTCD=^D??eMFcFa1)B&EFMC;.L]Y
<e_>Q#L95/TI-aJVR5YVAD78BN\.CJe[F>SY][YT&R9\eJ>+IcDW7CPGI7B]>8,L
]XB9<f^Q#\59@:RKZPgH8g;@68Ve/=?gL\g#TLAg&(9G/^B[,^8OZ5V:N17J#LNS
7Jb0M3?S4BR[^8O<>E3LN.&cTe&Z8b<P)&;887b1g#/3W(3DO2UQ:Y=PEc>_&Y-5
1VPDY-(^\Jd-[8ca]B4OY1)?JOO;=.-;R(P1.A0I>D_I4CBde8>:O4gQEa.;bb,R
6;RH\FTD(,2&U6P45RK]=<CN,MLda5WAHe<accdYB,KBM(NT<2N<c3EH?RdH?;b?
Bb0>J^#9c]7FAdZBP:0TK5NOd\0)RaKP9IKG.17gTF0-R?S5SGL1K(.<6<=;I-_c
UXgg(SDFe+9+dEVgRfVT_9WKRRF-ZQ&Z\W>_(VB9Z3/-W1aZ)d0B625[;Ygd5:_@
L-),d,da#VFO,_+=SKPY4cf?O@Eb]^1K.Yf9b;>Ta0),c)&,8aZ\NgS2\;HK0>PE
K2L]0O2WI7Y+C1)=K.8d]MGeRg]J1G8ZNZQ@,eIa/.X8Vf;R;8J2=K)&ZeK+P_SP
#(U5c[JFMQ]IR298V^bZU3V&,Y#RYa_MCBC1efC1[=U3eI(3^e,];(Z(8RJ8aRZ<
0F:06T9e[De[LAXRCBUWSTcL8)C1c5I458Z02/A+FBE5#Z.M]A^R=AFDUB@F].?\
?ME?X4?^d/NY]R+QS.WHRa.Y8PJ[J<+@DJbfRJ\0eRP+FH<X#RgU2I]9)<;/&FS/
D+GQNf1BVc=fJOcS1a;POW(,Od2aBdGS4Ge.ec;cZ9fFe5-/+SC;^[USZ<g1g:>-
Wg))>P;:SEG>d[R?RZ(d9E^9IP9G@Q0a:gRdf;@C80/G[dNEBX=KK0Kb18YA#6>5
E2UdR,R@5FaBLa^:IZ+6QYQ_:JU&(9VKYHa\bAUc+aFW.;gbRY_4X3=A.a_S+59#
]V.V[XSe=+6)#)d]HY[A9eTbM,a4,M;6Jg4_UK9BQ8L^6g>e_=C<[a5,3(BS<g-I
L8D#1OC-:79FM983GFW8RgDV1bHa72L:6W-:INIGYOTD/<L572K23)+Q&P+b?^G\
fGYPQYAc;SaV[-,[<2Z&#U10ZX^dJ]@R_(B>\RTE@XUY.(SdBf+_5fRUcH95(&f=
?2OZT\(UA,YX6FT5=GQ&>UGW2D[A<Wg,NaL>3N&6dW-+DNF?O26[S1-Cc[F():1H
B+Zd:<=43(5GVEdBKP)(,B5cF#I9FSJNWU&0(b.H)-D]F(VNaS:[J8VAFEg@F.#&
]OZJ)G@A^YHccc4,EP<)3dN&>a47ab]BP@6@341NV]7C0&-Q9ZR+?SK,P+G/@)#L
)2A03Z^gPS5FP10S^TBU388/[5/W@6A+^_4UK)?Pe?XE#-C<gKTTE_R&Q;?AeP#3
-)/eFe>IJ8\c43A/\U[@U06L[bf3-bUY<R]@1S^RJ=E]382\b9/5,K32(;(;XAI[
5CO_&\aO6:DI.G2GEKeH&^/4M;UgEQI>\U+;&+X\fZFc-5&8X4<D5JGGK>IT>TVP
&gFbWALHOQ]?@+<cSaRY+c]gU8aL3CLJ+\/gN)(.,U9B(/D?0f1Od_<;;1.O&7;,
&-+]J_Qe=.\L(DC#>e]X[f9[I#:8?>=T4IF6N+NT@fUSeVJ:<fPQ+0^/#J_1b2cV
IHI(S0FHVN)-DT2U3XS\2V\\,(K;0agVDX@:e<IV3g)KHZaIC(bS\JBdf4Sc:RJ=
c31Ka>^]E?]JKSP/R8BN,?#]cB_M=N6M?.S1I1V7ED&BX((;,8G:ea#e\OR]g3[Y
V0CE7_.G-CfU/(.MO)J8GE5Y(+3A-IKRa>dW#J^P)2HBX\F^@H.N^V22P]X4AV]a
DQ:[.]D^-:-/\C8FJ#D/BG<b8d1;2GK=WFF)CX9@FVRQBe4JN/Y7N76X<^H105Hc
,KY;).EG@42:<;cDc1CF</H<P.AFM5:@5CI\JQM.A0H05M?^D99-<U^B/_BB;c4e
f:dDFM=EUc.4PF).R@4_3I,b9f+D)b;(\WBZU(XgX^H@4T<BQ(#ZeQ#\FQa<(c]4
E9Ga4cCPNVD6^=)EaFD3FGg6C;N+GcN=Gg;>KW6>FC50J#U-XS>[c2Odc4TfB]T,
HU]SPGCEVT?dfNBDa?WOW8&gNJ7:5UJTUD6</R780>ZAgP15b=g4QX3S.CMZ7MZO
9]eMOK&0g]>9aPI_aD>>J[ZAK#g-&A9ZfYGVF()4V8DX][-H_L9<gU[>T-WN<BE8
L1D=BIeU(K+Vc0W<EXNf;GP,ELcU>,:/EC[&Vcb;CI;&D(=KB_QUB5BEdNgQ>_e8
DC/P6e2dK:?])M^1.He@VV,0<N7][X,SU#/:;:Y;6TgK:D?a-8NK2)b-[2,:R+-8
&7#LDD>-[FB]gO0W=7.f/>9Y2)-Y@GM)G25?)?XG_KbI<JYgD?#N08W2ZW9Q5WQP
X8<4gKY0aI])+dPSfDM8Yg75,,8^N^MQF;b(O_<[<MBIZ=;4g@eVER.TOGW^EW)E
JG1&BQf-H9#J3KEL3dS[>[CHYJ&+U1/;@)QYTX2W0>e1CU6a0eYG)<STBVWG;N+>
?eO5IU@Q7bb:YUK;3HR&edQT-@PdZ.GSSUR>H[:3GeTJ_R<g#HcASQcJ]g.<I7(N
->KCV/Ka,L1S?PJ:eR_fe>)L&3/6+6/U?L.S-=F]WMU;X@QCLfWGRCBQ[F@=7MA&
@B2OUI8T6ELT#\ZWUTgUU@Z=dW)EIg3N9dB>L#?HMAE)31O]W=DO<@@aa<C6?,Q4
Fc\^VX2\XBQg-;6dQUabA04G@c.E(EC_VdGWdeX#VR)c]UP-?F>5AJ2H:U^4aa<U
FCZ+6;?bYMQN5=6;XFgJ\8:NJ@2(,6e8AL\@&>L[dQ>Y4Y/Bg>8Ag.).4;dN]TRL
X\H##BJU16R,L@>F;1YRH&(_e^?:eJRZG+@?2c9dVB&MROB)7\KCUcF7BXJKM6<L
^fI^=54_LF@OWDV2Z141-:-(AA7Y)-6&>O@0Z;WML;:g&CG+)Ra:d>H?g6e<#QGJ
,J5=DA#LQObQ0_bQZ1?HFQRFS24I9<(g#]8_J,K5(8/5Ha1+42C9RQge6XDOZI.c
\\:NM<2KP/KD.>g-;;.Uab5U@VII,cE@_7R&@9E7dCeK]U_[RGJ2@:f\Pf>/Q;XQ
ZI]f598KOAQ;E;1,fH:UIdW_J5.-1WW?70C)X^,b0-TU8S)]66=Y7d#ECcUJZ7X/
;cfN5@f(;?IKJHB8ffR?O;4-3L;>E:ISPA?Ye+d8KX\4);8J>_Q9eH2(-FWWBEf@
PH>)AaQd0d-::L/6d3==:ed:XfgUW+/A,X4W_[UZ>T+GL<;4D\?[KR&XY]OK@::+
@_9[c]J@;OKJE\W09?2=0_<]D;MEDG-42SI2Md,@V63DL^fFFB@2/Q03U.dS&D9U
WZY#Ybc#W\7RC:0TO>e,L]5NYO-=&eC^W+ODZW[Q;I^[P@(YZ;X/OCbRe87a;@a,
I=YLXIgV_M@3H1]E7/5T=RH80@F2/R,=6cA)WLgf.I3cc[_U48R0#/,ZTXOGM0UC
T>efRQDDeB9\-0F->WFL;/=dbVM\V=DcJ\^9\:;S4+g<#VbW_:fBT3Q(Tb>P&5>L
G<f\[K,cC2>R[^_e=U;?N^7bCVfL5acga/\X0@[8\43^cTW#PI[E)23VW,7;8cG8
8+BL[<5Ed:A3F]d:Sg6+IDG1WbR&^EYGY\HKX0KaXgROPg:fINcXJ1P^>Y_H>MaR
K6ga^,XM&Jf6]1:@M0AWGG&Y6:FVC?fcaPOF9Z3>NMP^GD4-WSbQ05cQ8g=<.dFI
@c:._417#eFKd?\+OABWa2N9OTSDKX)V/(F^1XB9[6Xa.2=991<C:fL4QJ_Q/</e
7[RSX3D-)f+OZA=)B+VY+fRQYZVFNW-2G7EN\0L)3gM)NGS/aOHIW2,O@eNB<2T/
X[2RggcQ7Z,KF\W\JBcS0NPI)<d8;R0g(_TMCe0fI0F,T&LH=c9Id41aD)PXSB5L
80Q;CWH/H]c.YH-)f#WFYK-@TMY,UQ]U7<9GDTV70Q>_W?WV6[b>=B=#Z4=7QeTb
9JTg15S,G(IE>Y1XMX=Hg<9BcOH)ZG/^FVRgW2Y6H\WMMA3^<)S>;RdcL&2Mb<-+
:A;/a=GS-7EO\VY3>JU;\4dE.FcfBXG=KgEO86:J_7dYS)D\HI[VQZ8D_f]>g^EI
,];/1\Fe3[D(TG6[\FOS@>NVG6]\/IF=[M<cQV5D_Na<d)#T2Hb[A\Sf#15g(gT5
)>S+TC_:TV3eL_6QLNMO?[EG+&51bQ59f9.2;I<P><Cf-&G&d62XRQ8;3.0),S/L
7Bc6_Jb4NbfK:PB:@C,I+.<)PCUK5OTG_F-Kd==Q(=ON/gC^ec=8d]R[A0E\g9NC
:1C?bKTD.+4.Y&N.[OE153Ed+H=[53g)ZcMWL>;?=E=-F/@80E89d,MYDPe(Saa9
1\#b7PM^P,1\\Ta?,-SW.W#_IID5<>JA779]QA>g4ROW-S.HGg;[PJL#@.ABcNGW
afVa(A]3dHV=e-^cIC3M5c@+=@#5Y8=_Q7MPa.^)C3?@;g3GB<\#0HD+,?e0BY6Q
_4H:\]FbUQELG@/B&##19FA>3TG>^:\L5He+J82OQ)D4C[bE#K5XIWJG+DJ9N@0#
/M/D#K=77==6bM9_C/[<H;XVSdEE[^I+1.J;.0B<a=TZA0]V3.PL(]BQPLUR;1He
dZ3V9CU9J&GJDc<8JcaKD_0f38#M7;54^<@aa#SJ<C/#H>1_,89)V4ZHY3Ma..a3
dHc\94#^<OA+?L5[=]M3/\KZ<e2C3.8MICYH[S^T<?(-BcKU\-Dg@4&&4:NRUD.T
\-dfD&C;(22#ALN85gaF+0C2f=_ffI-G^)V0c#:H3<MF;NO6X=1BZI[_<TH.HJAF
?9d\DECAM1].WcOc?4-G+N-T=JP,Re7a[7Z)[3FY\VRM@&V(<DQEb6Y:&@EY])^(
N/ae7D=(=;:JJHZ6(.;;aX]+80D=a18OG_egW^c:(g&X;V5ZBad9=[N4LNFB[G?H
2(_UeSAUQJ:VE8_KJ)><#IOA[DdPY0Kg;M#]79NfF_6][)J&WSHG8gC_EPFZM_aE
8VY><^8_I:(6^\&)?bcH?F:3#@6WB7LGB=^B,b&YP\G?(c]\+=[0J=,6_KEF7[E[
QKU=HOK]P/=(EAU/[+SdVM4-8W(?\9-KCO/GQOZGLVZ=V^[/C,Y5OcK[EJA/+_U-
G(Vd8-SWQg^9#J;f)PF+OR>^^\YPRd0D)Y)F3&J7PP4;T=^BOS0@#?)U\0(;@(4/
MD^F)]aJ-X)7(7J1V7F1+[b2F;;#)LPJT,eb?DaN2:a<MZU^?B620L?#8Q8>7#9)
Rb;bR2LbG?5=6@^&e>-3S.?).a(RZCCOUe?7N2IZ6^#6U^bSE6&34.RQ1C6&H^aW
b,VKRSe>0a5,LPJe31X9OX,MN+0E/FVdVAZ89/SC4;aVRR@SbITgLBA?>/B(4N,F
5Kg,8DMbVM?ST(1AD#D(H+KJOcNHZ8=X[AIVKE\\D[=e8/[^XMH2,Z9.@<_]?Be5
EML62ACW@)fAS&VCIR8=D?1?WdZ9S:96Z)IA1EW9-2W-5H_TJ>ZULT5?EWY8QKZY
B@>>NN)cJ+/L?A.Sb_E73KH=@30cRH-<;M/#X[N7A>RRLaS?(]FQbUT=C@c+BCRe
S;5^78gK#1,V5>VB3(c<AcYeN\I0_L>U+6-Q_YL.J:aG)JBJc6)7WNZ9Y&;I9A7/
K5IGCEY10N\3?e8ZBY0R=;J=UI5FX;#OD]PVX<Pa<(;^Y]2,7bSGF2\<A0.)&B<N
d1]AEP/9A&0([&;GMc>_7dU88W4VLEX1NY^;8X2B20O-E8;0G-I@[d.II/>-.V8.
P.Ie5JdMOYa#6fS/9-(<@+39ZfFPQ),7SD34TE55a\aQ4;CGY<Gc,0ON\EC/@-[)
M[OA1,YZNg0L@#.<)14W(Z)]Ea)UO+I@^[S.b4<6V\aUZPZNX5H[\8G^Ef(-SD16
:,N179ZDgY2G68>D<2[(9@46K4;CWNgFJO4)fIb5^#3KHHf5;a4N,BEGI^C2\Id9
RYFX\DG\+5#]VEGZK.B9Z3YM+#>&LccdYa6CFXM8A?3YN7S3&1RA;?4)fB4La1.a
@45>4Q]9K(<QM>Z^Z>FD(@MXUU(#MTX#E&O&WS.P;MXa^OJg+/D=)c4g9,EGXURg
;:,bB-@eg:Zb@A_2bf3R<BQZ:&gRG\HCOUfN;DY,g.8#HOT6dGT,<#9^[0;5&QfH
G\<\ZM9_g(VN?F;VGRGOUU--P]=eL-)L]&MO9>1VG#PSf97X_AI)^3AfF/8]8BZA
P2__&]^=;e3N=](e+;0XVFcfA][/^6X9+PPB@4f5Y\;[5>XT)9bR,PVgfc4&SF&5
HPR/HX88Z76g1[/3A+0@]cTH:gUcFbRg0,_)2>f[[U9H)UN&_B1J):&7\bNO[f@T
)BcFf;XL.21N]</_U-H5d7&)S>&&0Z7aNX.90D2fF5<_@RD:e8C@FC59D(;dN91D
PV&JAWY]9:g_)FSR(5VT>.@J^=aX3Y?USR3[D]..2bQ5DI-J-T/UU4V.Z5fd[E#+
-NP9D0^,a^VQSOSQ&-g-g5b@WQF+2;O+>5+\[W17G+eTJ5PP.5?+:Y-\Pb&e_=7M
P26Ua=#F@_3&E00+>DBJ]8?@ge6=5BSI^>M0[1)HMC5(JU:54H]TOODbD@-V/.8)
MXWS6FVL\<eJ;aS1>8S9S0Lc/)90)-XOPQ5@XZf?XdcMD?-:b\:=:^Q9f_H)O3IX
,AHdU)]&14KMW/>DYN.VW(#Sf<>?M#RHG5<7[CXQR-=^GE<;?dY.H7a:W=G73RSS
c]@>7^3X[g\=+U^]JDC2d<390g0GA,SZEE-[.d6KB7[NQ8f.Ub/<&9H&WbP<gQ,F
a4+Ng-)8g?:076Z5Z33U95H-7R5f/gY4C35JSS:)2SCPZN+K:O?PJFf=8E+1V@R=
]]b3RSP7AgTdJ1)(1&Z1MB,+JFNFBC;cY6EIbY5[<+M/4]FXD(U.\B7EE4a,I]3H
,V27LY=UM?@.N##\J)c>PI=VQ^WeJY0@()e?9;8g?f.B]4<5@aB&L_1dWf>4&]0X
#E?O@>@]<9#]M(0#C,0(df_0N)V(b7T=Q.Ea)T1KD9>0MTCJ<:P&Jc4O6G]d6/AL
:I+#.@Vd3=3bQS<\=e4W-NSVH8^IgR9&^Re0e_CQ&:WX:AOS:g2AD]07?H,.RL\J
_#,a2-=HEA;\&B]6d=9EEc\-7F1IV\/;ZDCVCabH1@R#V#IcVRMTJdbg5TP0+.bJ
+09GfP1(9B7RWQH@U2ARfW#df+Lf,E]^I5Q</&Z0L63&fB\Sd>=7bAU]P]+O8c/>
c8<+TZ4a8C-<^V[12aN965)PGgA<+b--]?g<dK_=60@ZgE4YKS(F6TZLHH2<]Z/0
KAR&BYBKcPEbDTWa-5-U1JB,T;=9<^GU3T0fEZW.G_8JKeN^Q,/W=cb=TNPHM1BZ
__,G_;T5,,TV-W?D::^_1eHTBT?OfRXX9S#bNe7a1Jgb63OP2X^ES4:N]&^C&#_R
bE>3M&gOG<-0.T0M;I]DZ:Sa[@=?75#@QD^baE91-O#T_GNbd?T9ac9BF=.F8F/0
@gS8QSge9(MMO[LL+BPfcH3C=FAdMc\DQ(L_2,bBA7a)QdG\7eGfZ2A<SSD2IQc2
AWF@#9@6L#6[G)bUSTFY=9,FW,b98U(P=9d2TgaKC&9gC]=ML7gG7VB/&=P4VPKg
5RDBU4SBY^+H-MfV]<:cCB[2UXE0E9-(@>++KB4g<_CD9>\)[<=c4?D(Ke+TAFD=
WV9CVc<8((g53>IZe8SB]0OK+BABeOIdDPZ_96/\5R#:]4P&3]dGL0[TfVP+Fb/F
8I3VT6J+I_D0QK_\>HTe3^G#YIAQ\UG)TEF8O3.C6Ge&.Rc2Q;[BDT8e_G9/#BR=
F:3I(YQ0&:-1F[?@]4_N,/I[G3/XXRZ-YF-E=\4U3a]&9Rg>,[;bYM8b@AQ)^Zg3
KWW60:?3::Y#DIV9SY68+09.]K4)QA8a[0:[C?2JQMR,Rf2^5<OZ?NE1cI\P_PX-
\GM4OE^0SJfd8C\gY&M)?(a7O9<g2]c,XRGcQKYL^-c977d63:Y844Z/9NF<5S6d
1VB_aga[Q.^S/W.FDaTC3AGa3-d5_#IW/WBDFV3K(>7:^1V[cD>NKc,3^IYPYGK:
?,IZ#aB8GIUWdM[R=D3RV:_f1C4Y+0@Z[[V9aQ;;VFad=A=;f0W4+g3E4c.(=\BK
/7Q3_)\__F_cIXXD4<_Yg_+(C&GdCfL34@H1FN(4QJ?.=<0X7C^VF^IA(&&EESY)
/3\c-&fZ24:98TD737B+,P#96C6,g)Y:3;.\+(_FcH;Z^@8.(?+2C4eOQZa^WYC&
Q@&OL7Cegd4;ga0_+//^NX_R.:/d)B.Q0=S]=[BG1&eI2T>G\R5W7/aNdf8\MeHU
a,+5P59+C_#fJF9.KM(MCS7E_G@:>df:f[.?(Za:H^V-8f.Z@QI/X8=K\_Y>\-]8
\Hc/cf+:bc+R_)fF@_AQTS;;T:+(VGPMXW?KaAccTP_#GK,cOE;&A_e@9]Ua;#f.
+>W&b+8EC6\\4XJfZZ#HgNP+eLCT6Uebf[^W+gRY]=AX<IT?=dWQ:Z62#W4GY.9=
FO-[bbCd7bS-.9_/:<B3\c=+>7X5bVL,A:=g\OB4:KMFMWLE6((+O/FEgS2@J0LM
a0gS8KV00?VaNcDg,E@IJ7YBK=g&eeCSAecdR-=cEDTNDDLHLeHR>U4AHdK;fGDe
I/_/=AZd5,aZ2TBLO8GV[eR@6eH.c&F\d)SUa[ZVG^K:TDNTM[-DZGU+ETTIR/G?
6>ZLHMGH(e1gPO36B5fT2\ER,_;8LH(1IUW-a_4S0FV3Z[RV8QSYV(/QeX70M\\<
HW5aJ6KK1@;SDeFY=<DC^XB0>Z2JB]aOYF.VAO/EIP_]5ENHMM?gMbFTR+T.&W_,
EPf+96^a].>H/1X;EK[BX=(E15J18,MTfM()OD]SCZ>,5@KQUZEfYdJ@U;CAKO6\
SBBO/(Xe-=Vb,c27Ug3PN;6SL6f<<+,QWH7;Bg83&>-XDNE/)/T+9&LY-F2]\EZO
&4]EQ^5.&R4f],9fWD3FV-^=V#T+M?1cdc[.S6^a-Y/\d_P6X4A0+E4&_8IZ92^d
\#75PZG.V6.C)HDVd;.HWS=F9L-EUYd+MXFT\4/9X4#fLKUJD9[>7LDCc1MCePXS
Ve(1>A6[?:;9DP2T;3#RS+fK&K(B7?f.4&]:&7HeOE#I11b)(P[Af-@V=NJaH>(J
9IbJ(/b1S;]\>[PK759S:ZC+FP#CO]M,IR<9_@NPIZ(9AAN9^A_0^Le8;RdJ\c4#
.-5^5;K+HJSB]#Y4d[eO/,aKQ?DZ=fdb]9N5YN+6<S,R7bS0WZ<Q#c_RO&MRfMBK
7]#SPO,GaX@e&?g,G-<0#;aCAVCWb8RJ(0IO?+I2P+UP=bVc/HV&0bV)9304L/Q+
?aQ_=7&(?dQDP[abRa4Hg^/\<>:e5cg@_)(\KBTN/^&>/8:#GO<OK_P(+cY,7M+e
_SI=BH)bRc;6#ZQTE(Q&3dL15&INTJ=5ffT=6eVTU#+-EOeacSB-K22S.L,,=dA>
SJ>gSQL4,:OPF\>;DBWU20>2<OH->P<,4?b&66H&(Y1\\6cHf7HQJ(J<20U7C4:g
bIKf/3^/8d0X2cW#<JXRWcKT2&T&KT6&cK\I5G0TR(UNBI_@b@4GdS@5(_-A,7<B
8Zc:d&B>(5WBG/dY[.7ZbA)O<47:Wa/W6K-6LF12<[X5F1^Be9\c9AgZP_C;_Y6=
12A?TB@S37-4VA<XN)f=DZ7&P\=WMQ^fb,GDCdT-+L(0QO&X9,XPC?,&#94\KUd6
JQ2>c?=1M4g+J^[O>N>/#VG@B]HGbgV5U>bd0BOF8,1&+9#385GS;A)Q99?HB53I
H_)HgbV3(4^C=H^EY_>R()B5/9[a\D5)HUU2THZ;6<&E=L6X,=-2OBBH6[@be5\.
-+C?TJ327?YX^A2:UJ>J..BI/6VF8bR2[Nc91;S2,-)65<bgU#()(GIB9.WI+.^R
:VG4^GC/FfYKBJ-^]@<?dfE+&eb#^#Xda^ZJN9CKX:GDR\B\67X;T8_4ZYYZXHeb
)I(2(./??08(94K60G.(fT.5_VXdJZJN;:_I@5.TT888;(cV.[Eb=J30b9BLI\N^
acR2ffTce?e->+XcfbFJ2McdB2?Vcd,D#FVecFBGQg?\b\[L10We#B3J84&C(fO8
C+a_dD+M)Id1<;?LYb+^N)ME-HW3=e8b[4NCc;(:1Z06F(e#>K<\HRW(N&(?0fHM
3-C?IX#3J+M0:fAJeO4e5G\BYA@6.F@S\d,BbXFVFJP4013JC&A?[+Ud@9SAZ=(]
c]a(U<?5a<5VH]/KfQe9:Y]ZTAg8e4&[MfJQY^8YdJd7C+?]d4d6X^DLK+T]_dYU
S.3Yd9dPVX>5BDQ[T<+4-S6-.^+5,X446Reg/K)f\aTb4,.5_J5YG4-M)H8LQa9A
g.30IO7_MJZd_,IMdbX>b#[/=fUDIN\:82aRU)a(aP)\-_\Q8dH_3+S-K<Yg;dAO
P.OPFe:\4I&UbKHZ<dG2PZMIBV5@:G;g:<2SNY^:Ag&Z@05Vg^+P7?YR;\<HE3KG
T?);aeJD2KS2VZb;RDf8?L.<)c-&7VN\cgf6H7_b9/@RFZFOZVIYVc<MT@TT<Ka(
3;ffGD1dHH0NbddBEc?UMN\@RC:J]Yd-3T5)Q^AX.?/Id0gCS7?XOERbK(UcUE.4
7V.Z.NN[PbAH<<47NVg(TE#><Xa-,2II[8d(]Uda(eGF+7NRJ:A1ERM>47Va/^gR
f+Y=V(+0>SZH-PB-+0R29X:K@eT>&5U1-OI_E,]4@&UK;Vgg1B7R1+/A(MOI/S06
cG\3R^&b2,d/RWJ,,DTdKB8EU,#7/S52AX+3D3fCP(]P]R>/c:BaV-Ab]PM/1UV3
D<Y-41YDbH0b3e)QGaNX&c8.HPPdc_.3TX4dQLZ/JH<KA;OCSZJZL44M29#/-#2E
(YHY.IYa#XC:Z9/=\f_b^)dgK_;ON;Na@-.C<RU5^3ZRGO8Y<-7R3<P424O<1>/+
J7cJ[_cO?J+bcQE8#A6/P?(-C]@c=^^/bHQ.2dXH[[\AJH/eUBT(R?)ZPV79>eAZ
]XJ-.NP\OD&^bD(Z[1V7H8)fcF8\dgdC:Ig#\Z_+3Q;5FS<eK)Mc<&8/,5/Y/P?]
3\6<FR?&TR#UKEg3D]RbIHM>5[S9R[+J@L4M[c5PG:Cd@K##-#b.YV_,WIV.STE-
#b_>7OXO3J;S/IRcJC@NR]JOO<NKNP:K\FRg8P3WV]a48=E@9g)aRA<8=G/FgefW
&6^A71U7LVV]?VD6gQ?L&N3BaY:X4gdGXXF\3G]e//QX/<V&Eab87R?_)MN\?:;V
dQe6H+#5]5OIVE-)=US40I5&4]\8gWUZ>:LY(=JFCL+e)5BLKKHbWG=FBPP)1=9C
QQcYWS-_8Q#[]LV>E#4D<T&_)La.ZCTe4fIL@=f4.cLW]/2F;<0He>&OZcgT]59S
@EQdIQef:HF4;ATF)a90@;)+-.JJfY8FOO<0KAQ:9PE6@Y0PabVBRK.;GW.W^Db5
I8H;cfXRULc&;cX>F6\HW+>2QOB7;PN5<1TX9ABK.E+a/1=dSH-OXY04Z2RbAMV3
0,PY..f9eV;;[RP)fR-(e);:(3S95@[TJ:@7AGF(&DD3D:g;+CaKc?1T17M2(eG(
<>f3Z:ESYQS/\IILX_B/)fI/KDRec&0Z@T+S>GG&eC2XK(^.M>380P8GX[1\S.&Q
E@PFA98aE=g/UOAY)4PV6>]RW,O;IS3V&9K)T(,05)]eK]34?Vf)E1N/3SC^5=_H
.e#IgAM3L2bd0G-8Ea/e<E&9(BQ]+?=(bVdQaFa:]F>=g+8>Ya]P^cdWG.5_9@EK
DF+?eRNSS+HG?UYS-F11=H:Ic#[??M@;W@C_6(EJTT26>7SaT=BS,La:LXbB><+Q
3ZK-MSNNgN]XIAL#/\<1^R.#Z82A/RPO0ZOIN\fG+-SRe/6OL5OCLH#D\</M>CcN
VW;:Q]f,e.^A.\B=W?XY:c094,-Q9C3cGI)#;)Kf#O:gb9D1W>g3:T2/,cM\V>ST
I&<;<^-M/4/-TO@#E_)F4CG5F/-9_S+U&G)NW1V26/)G9.)EV6+7:/RT(6=:KZUV
Z0CcZ5/>\^GT-ATIFNgg33.M1O4UYL#T\#JT(3b6eO+J0#\c<].>\[X;Y@_(G:&U
><YdY0ff&-H[ff(EfS?Q6I,:0EaY;6(D&#0g]6]^#DHGgP]Ye(.c=A)bTK;Xd\&e
20OAOVGe1&(Q4VTJRAIc@CS3C8N8d]V_-0V6e3=T6=WQHOSDENfP0X#_&AK^?eE8
WSU<d/5gee7#)dUgPRXadI&G&9,<=.E_[#SU=#6BfQ;a,(RT<gN4=]MZ;d36>#]4
EG[1AP^/I><UE5^C,VEe5e_3\e(\,TE8&,Q1O,OA4W@KMI>/CL5?CUJZ=12T)>Ed
V)&CEM7440afefI8K3XFBR+-8eI#:UP?T^,S]6W_]ZDA<=3cL50Q.6PQcW(IO?8S
P(bAaLKXRT+7U:Fc\.3b;?bbGQLW8TWCW>#>XWT>KBH\CT(@SO=[e1cOOL=4I-WH
XU>OI\DR4EE:QX@S:\DbQ)8?U]<Ub?1YO2C22dPaTg:>>@^7b6<OUUab[4;c4]>?
-KK3@D>_SRI<bdc17@W\S7N)Ng-?\5R>[(WIbagT(:H6GYP@M[MJ0\7;b\^]J\_C
fEM)?=8_(3Y]HaF2,g53(V]=.g#_gYM>&#6HG#&,B92cKJfd\e7gG=S#JM:95WQ@
cT.0&P3):O_D1V85+d?3dd/fCQa:4F(aQc7\f7Z9S8a,PKG6HB2CCCT2D?&]a@N:
JC.E[OOQ6.LKO4SYg=\[[T[.B2UW>W=@#]PU_?YUd\^VP^IH>^4<[&NP4g;>:[Db
+<Kab[]fBTK13^Nd&3&RHY_>)VX:EKAG[UCE#0f]I\SNZBeL#113b=CH/>HJd9F>
M:FR^E=<UX62]JHY762-1270a4d336c6-G)7&WQC6N(OH09^5<XWW4[O+=I<?QCE
_2(.3ZG7>1CQ/5305+;.H>[/DaZbDJ6AX.g@bcUgN]^2B0fYYdMg\Yf_FOO)@fGg
2AE5&99A8[HJT0fH&aW72U#WX[,GHQ6V\IJ1d2;b:E8Z0[-J2KgS:BS9T<BYVF=Q
D4gTNa)R9eIR<RU3086XX.SGM+^Z:Md;N8/QNM+_2aNbTgbXd?GKf2MYQ5HfL,ZU
SX^V;HH<6Z4+a>RX?FAFYX@I#Ba36]?aDf,QE_ILK#Yc;)GbgKK4+J2K_J?0<,M?
E8FE/UeA6&FU5MDC<6XbJYM^VBA//8RNTCUX]eO4V?+>-@VMeFf<4_LO4EK)1PPe
_0O&f7A>&TLJ4DJba]@f7HaO__eE3<(dMOHG/1B@XH:A9JB+D1)ca9,6/2a7>Cb6
MM-EZI02_F,[G4[fa;/W^_d-c-/F9?HQF^?X/[(<0>;>XA4c3,R/P8G1N_(XZ[+&
C41[0b8Q6RP0)1(Eb,f?3d#Q@#g.Dc@GHC-H&,[QNQQ@FB)W9d>K8HaMg#P(@3\\
<&BN3aL=E=WL?3^L/ZeC#[N4A-=;3d9)+4UBXV(gGV5[IG-K\)5c[T[,0M/64C&?
<g+)cT>0V-4YN6X&4JR3XWab&1><R1#>d[RLVJIM3RQRJD-WWd(S0[@\:[5FPKPa
5(e0f-V8C8+Ha2,7P,6U35FDXK)IgW7]_#GQ>CP25,+-0KJM#F61_V81-W7EYXAY
]gF3MQ&W)4N<[L)BKZE>K,7M<P:Y_S<\5N^N9(;E>SM#RG[gUOWQ0MG@<8bQbfA.
Lb_]e87e1@^/YMd-?XQf=G\T_bd;AMDN8J@3GMd##cCHZ#XK.d.(24#S;#8N9,V9
]gQUeaV6:V^[,c8/&JJDAS@S<ZF?A4HW7N\B#L2gJE<LP5(ZfUe&]>g:&NR]e-#W
G37#Z4XY].I:VdO@@@?QK&S9e117248@f.F?7UaZ4R^Te1;faY4@)4>3TY@B;&18
DQ5&&6_HX9]XN)?/(<U6\dTSAB7HI5MggQQTe8A#5@c9T\3BK(OBd:#ATBF15^3.
^TXgN6_GB9A[&f,aV61aUBfD_QNb/3@L(ACdI]f8dWc7IN#3R[ERG/g#-Ff.U0S;
ggTbE;XBfY]M\4[cTcVQ:bRDR]b-?LRHfV/L.ee3)WU-=M550F6/N]V1:)^BST+3
#M\4D/R3M\\5,;.WV9_M#WU,>1)\ZX\4?B4Y4OF40TP^L.-bc)^7#^VIK>+UVd/V
M2DU12._P2Hd[-XGJU,WaBZV<#PHWIVXUCT;1><fG;MV?(LH.YTH76K;DJHYL43.
0cZHBN:V?:T_0=C-SHM^:B;(aaDg2bW7cU\7&AN23,K2EQQKZO<&[eNNKA;1+J2;
U.aU(YNHS:QaA;-=<\ID?d+B\^/DWPV2==e_0@f+N]0D7(5Og<(AW#:dbA=&IR;Q
.MYb<_UGXMWeZ0A#B6MBF6QM:1=?X)=]]8W18M0[RM0R)KX\).0b+M4g3DMe^aYJ
=>/0;:WDe8+GZ1[MRQ7G_Y]\5)JQ:_aHWWSCKgIg;KUF1.#7LB3fDRa@P)1)e\B,
SL+N_<0;4@,7863M\.eRdL^T:/9R[TB._d,4a?@;]2RAL?4OJKDaBC@SG4DN[PR9
9:X</Z:g4G84b?R7=cQK]ZXX4FI3/7#GeB\K9/^9FXLJY8I+F[_K\01IGV^K#WU+
bH1G#=X;AbB6@CDUOGE/_P+OX2B1NMb)Xd1PJ-SE1+a.TR0:1M=_C+W1GXc.Z+&V
HE.Id6;&KEK3T<I\3F\aRPZU&.SU93/EF,<9adG;^7S7B\4>fV_2@f3[=-#\[WX?
@7FY]Z7eMb4^ZZ(Z[P=VJ1^(L+V4&S]A&)R_X:2@IH6BU&;F:Z]BPYY[E11@8G>7
fHE-;)aGMP0Y^PGYd,E4Q#\MAGK>A@6FGB?-?WF0R[@T3:S>QZ9L7HL\IOc9](X(
U(8QeAEP7FX;;c\GOG+,K+eCE+]>SJI(.;>e(01PD-+Rd)&dE/R9/T;f5,FeIG,2
J#^@B-Xc)2.@-Ua^<FUM-XU\aba0aHQ(gHB?Sf[dMG&O-)Ye2)_X^7A20XW&#Z+9
HR@B>cUgB6XW?W9D1YRVDg52c=S_d(2@,P70YeCLZ1g1S;c/U6\XY0.ZOPCe0(X5
P.KU9TM2QK8-86_BVfcW=4HW5/F/OLCI+A97DJ8P&AdfT<&e?9.#[9D9FI1F>;_U
/G^:d?#S(6^=6/BM)YPEa<[a6H:-/;.KLS+C0UB38@OKdO>A7H\A:aBUDeN]0/UV
(5A9F(+XfMSJ8b:6NO_.:eY^@4F-4>E\\):TNU<M\LKMM08;RJK?UOQbaSO0fLSD
JJJ4_+0cEALR-caHN[@?QIWDH=#M;IJONH^@]GVOd-@,\g<#JHSD_6@5M16J->QV
EMJJZIM3V[[dN(,YdN90g](4_&>)=_DT9T56YR6AA7)&Lb@<>f2)\A985\K#\=5R
Pef<d,7)bF4N..0WZNYZ(f<C6g.M,-[<Y-P,D5#B9eAB80G3.>]V(\U5HV8ef)Y7
gE&FMcgfXW2]NG(I9.,;c:(dU:)IC[bMM#SIK&@IN1[3J\^+\gYf4dID<\TIYJ]0
_10E;,K_C:b\>0bc7LcEHR6MMDZ<SOL8Y@9f@AC>01+WMQ/EM:(UbU@1-;#a(=,X
XY5\B0]A1T;LHV.8IO&NSY,<?=BbS&YE\@5a6Nf7VVbcf&/WVQG\VB1;K6;P9J5Q
[ZWPBGc4R6K:OAKMLSFXBORG:,KNR:+PW423J[e=^8L-Z>^^Hc\,^+U+:9JWCDZP
(_TTc72C:DVXFBN^\EL8G?/SUf+DbS<U:@D?.68H081T=OF7E<R,J5TX:,GY9R&,
8J]Ad-#g\TQ:H4G6b;_G(NK6@fWYO>e5QI0Z?D?Vb+]6>PQ,c&:NJ>4XH<)NI8fK
DURC>BGVMG]#^9K(e6e02E@,/8\X=6VR^K&;>4Vc;1:cSS8QL>INRZdcO(Y@7C1V
[[J?-PT?PYV9=9SQY2e97>((,@^]3OU)Q+?a0VPC=2]K[RbLJ5a7K9<f3#>9389Q
I1;f15]]K>cB5U6cDc_&0#cCIH]L;?d>:P8dTW<eDa1DHg>]CCLMQ/E3S><OHdfg
Rf5SdQ\WENYa_<XF:[UU0a8I2+GQPW>+W<S#@4FB,LKC:YDZJU.SLY.fA9GQE];C
X?(J;_SS;gWIU1@cf5fM3Y:4VJf\D>C5T2QZKO#=&V@GL.+-+_MWbd-A7\AgSF;6
MeFYVQ)KRGA327?SD>96?cT<f0H4MLI#4413GC/K(QBP:)S4QTQB&GGJ<VEP+KHg
(+@+;E.Y3OFdCZFGMWQNcC<X(1H:6;^&D^.f0ETF9\D0Z>_g[,46aXP12ZJ1LJON
#TaH@5ED5_.0]NeEVJ3BBCVaAH[\BCG?LHD\/41;(M,6cU9#,TVA6b(+?:.^a/;V
aEgKTDW-e@P_^&<4]8-/c+PfYLI8K-UdQ:Q^Rd[[DCeA^VR/<2dbV62G1E0P4a/3
Mg+64V#Tc8AU#.NPJ;&Mc:cd?)TG>^^Y<[/Mg_8V3f)7=DA0.PHR=05BDBU@54B_
I1Y1D.4RL;Tg@SZ)4&5+OXAJ1(FE2HgE.?I@)KaG(NDg7QS;ULB=@F@=?T,>0M0G
6-&@Xc/2SDM;L(8#>[RC_]O,M;1e[XRVXC?#>;b\Cf+I)&,(6F9^@QWa>VIZ#e)T
1U^R_HQ)G\U3]42JT\2=I<-6<J@7;_+YcbCb&f#e4C/^C9()SC;TcA8C(#I7-T+-
L?@g?YFC:40@H0fR&d7AD_C_H\BV<T:#M6^9U0/N]Pc;YO.X/=Ac@-H0_SKd+41S
A)60<\,]:e,R#Z3HLBPFT+bWP>GG?=;.B/W2-(C#II>-0R6Yc#FRN5FLN#9R3acS
B2QJ0[PG)0W?2/KEDRdH14A6698:T7gV7Bd\0=61U9ZM<5,7[J<+;bK_R[b)C)I-
]\6(C_g^9Q#6C#B]>f:XP;+1>LCI?Zd@QL7P5Ve]Oef^13.4ZELM6XK6_+0B</8#
X2ZBVR)C]3,PL[)R3R3551^80SUI?=e33.,<b>N,2@:Xfdg#XP7dMfa;MSTYVE_&
7,=d.M?RC?)Y_SFO-\\XFR,[5=G@AIQIK@091d^W2&3->BX7QeSb[9^Q/[TI979#
TF670ZY\43Wb?9@J6).AX,AP;E5g6,g.Pea<aH(_0]UMb/d89g9^<-5=c:X:YbIP
)^4>=6SI@,;1ZV#J#O+T].G&?+2M>SdPd9?+RE_>-)I0dCBMdJ@0Afb3Hd6))Y3+
5SZEd);Z(P8I^g1.c)\fDP@TFTO&GBRfR]TZ[KVSaTLGX5:F(M))VG&Wd4H<W(8g
RQQf=S+85:I+9B/::4U+LV_K863X6,NX.EecLJdCg>>/N.6?F>PQ=+K;e.H)edcJ
@+-((AC,TXbI(B#,QAF<&JE_G_K;SLZ.K.9d2b=g5D,e<DAc[)7dZE6e/D4cHe;1
PUB<CAV_HG3:A7N6,-KY_AK1Mb+\D9WLfCYUHbWWOA,,=ScRbHfX&.@7RZGVf9<?
_cHb>eTd;QAY49@WRN6Jeb_L:Oe(-J6;He222GbgBdKP2aBVUN]KQgV<A6bV4T7b
S5^3F/JK.[31+9P5Y:U]NC)@JX;<89&Y(&.PB+D&L@]S(DSI[=gKP=?URNBYV.]S
#F-24-?FC1GZ-#:;E@4:8][a5O7A5;4Y+)d;LZS#(WS6eG&00#?],I][^acd>FI(
Q>AHD+BI?=Eagd-S^^?^]17J3]&O@KF+UB:\(CR&,0aI5K<D=KH>FXWW8#/[A<Z0
(.-L8HY7a=/<>._\X#Y+5B1\ZL81Y=d,d/X4LKBfQZ@33J;\?-[_+W\SYIA5Z-?L
dQeV>0gH;(X@&N8C3RGW.V#;JeY7cQ,cZd9BK5);)O;>X4/?_dKG=9#:VDE51Vc/
;,WKdH&-#dE7,1RI.L]\4SdFKFOe\--8ODJ3&[]@bEe/.50D,QEL]9&b7BP78NB_
@Z3I?K>S[SEKYUYZ..JL3/c(adK]?>98;2PF@Lgg6cHEcY&FdA4[2O:V762/7U]Q
]YX(8MAILS>4D,-6T/;L:V52M/Q;/6))ZPV]O]?Hb6FC_X9e@b7#5&N7QPGBZdB>
9_BU?3bWd4W(I0aTHd;8;RLXZ<]M654\HN:AERKO16:5\=0K+g.#fJ/R>;e<Pc?(
N-=<#YYG&/Y=I2d_@BM2J53ML8C.YB@dEe[b0>4FST9]Z^6^Ba6)GaWR/#37/e32
X9NIRF3<9&:@C&?D#B2geAc,dAL)D@_AdH6R=P^P8+e[HU5^:#(>Z\]L5:^MIF;Y
5M\;P=@UV(02<4W6IJaggR\U+1[GC2@AM<c]1DF)G24#IJ>@fU6QB/Ia8Bec08H_
3^FD;AD&_2IRY&J>8EQ\LHK[GQ>Ib5?,>]7/&-Z.WJJ<>WJ(EVX3>eVRX&H:</ef
RA0dYCLP&^PZH>PIdcaV8K;DYfDPaIFUI.)WJ(0;g4PUI6HG.NUJ1NO+d)SW(=_2
O72Lb;4ELQ/6]],NfR=b912aCe#L\DPF]&^+<^;@>:((VcHNA)WbA]94cU:G@5b>
^9#]e/caX73YKc._/2E&c.QL,H3EEaXP-D7P+VTC^\PYNWNe5IU3)RX7))1FFfZO
FC+-BOOLNSVX>Y.-QOIQK]/(b_+LHK#AU0P7\LLTSI@BOU4G,Ogg4?fa(Ga[2_3\
O@Zd\U1;WV/,33X)0+A(aca+#9ZP8I5G1RQ+POAd8HI16#ZTP8T/bC7e<G7fIdWP
0<:1ae9045/M<96Y^<AT[[0Z?]-4]9C0:;XLFWgA3BWK0G=J<I7DS[HF2Vf)_+GG
2Vf:H_?:.<gS+YdKFKUK-7+N2a=-.a0+L-<5>5cV^S0YQ^C-M7]G+:GfAbRbA@d+
5=2AYOISYDIG-d&SW8J6G0bL;2#;\3UB5TgS+C#Q/(a9H3LVI0B[2)QFTGC57[;C
YW2/:5=U]4J>Kc@L+P_.9/)&[ZX:fFfFcZ,0K-YRAScA_b)=aKUegG85OCP;R/7/
>&7W)NGUNPI?I(.C1#;DXSU/G)=U?CQ[/VW5<GBbN0,_#LEba[a?WS0\S[,.Z0NH
5K=N[bJJR.RI((gdXOJQH)8e>?92YJUd\8UCIO:S/G17?V-[FQ9:U)a?SSbJ;6#9
R[I.Xd/.<ON8bd6_S(V1Dc-HFF+bA)6^7N-H=7\2\YfCPMZc9:Ug2A&O.(DQ-W9#
2O=XaUBK<Z,6^ND-=^eG+M6Df>e(X:?_A4ANX8Pg@I=FLdC<f8b4/PFXX1)#C=ZH
A]]eZVgI@24X3g\/KY>T46MO>#ceQH:=9JPU/YWQfGf&6B]eSA20DJJ7:L#\]VIV
JU/8\Qd8>gV^>d[V@)CXfMEXLP4f\1gV8(R574c2/O_T++7VGg_(.Df^cDSHPd?/
dETcA<]Y],aa5g8CCQ6J9LEGA^S7W7O4>.(_aeaL0eS(\+<)7?K:Q6^I:(e=-FZa
],]+XC):^c[KF?eL<d]JaWaFKLGLE/D5c4:[CF@O=:M?Fg=:QQ/eFOL#e,\3@YST
RN^a2W]=;7Y9\C3;6dTf/\9,\?W[J#&APIPKEKZ&,(Q23J#O]-#FU,N.\-1eL\aH
E&Td3+^,;Xe-YV95c>YGWeZ2^59/L4DH(JMeU0)7#:F8UE]M;)INWL5+Z_237ZZ3
1,9KOJBSgM-GfXdXgg&#U5;J,0N^R&a#,^FIO6]P<_gWQEISUH)c?f6BPC4.&(\A
MO)bAGQ8E-/<5&^HX,D63_7U^[T)MIKE(6H&>I-.I;GAQ<&IZ\O1fKG&_1:b(VN-
#a?,X>U2=)a9HeTPNg4EIZ(.B(V=:DZB([/J4L^:]+X=ZZ[?#>(C&4dFd#+^\4N+
GT46cY&W>f8Y]F/gBL?CJ>TQDSR01@TA#=:ZW7]G5K8?\BGR6;Af7OYWa7>bH\(=
gWC?@BQ)6[ET5Z3Gf-?&8;?g[[<3#)/bZb(]fbVG9YZ=1W20<QNP^Pe\]A#/N2E-
@=_e2_BB4)^)NN?\E.CUMO@EJJM?_4S4aaZEP/1]9;@@Ac7V_TZ0gdXEG+RJA_OY
3GccY6^M2LT3Ea/<??8L-,eD5d5<JRIVa5PP>5(X>g;3QdVc&IdK#REJM7WKGEN:
b_>^TI2#f@EQ],5IOG]TOI1dYQYE0LdF].)cK9W,MX/dWRgAf[7(ZbX2+0-B]F2X
K?MQccR4ge=0GU]\I@^X,G;=gZGP45<_FIC?\P177,Z_L9f_]K[4b].#.g&1I3#g
TgS6@[.UU11c;/R.C=0#<WK_>BT-LC]TC<_LFg<=9/A?b0<9>\<-X_HT]=XBDJJG
e>SE:6b8)K1J(#<3S#76T65eTJP9VS8QfJ.bU>MWR0N+W(JDQEL;\)7.W5CBRT([
cece;EC8FQ;0P,;Y;T,H@])R09HPYE]0,N85>VPOTFV1Q9_J52QKB3=a4B&8T#O^
,^=/cL87_;]F\B7L\+/O&^&08:IO/#J]DP4FGLJF1&Z\(3+F=84-J=QM#A4A/VNS
]HMYSF2<g,)<.)]C+LQB?J5]9cY+I363Y-+7T;a4^F>55#XOCLGJM)3[(ccZ7:3\
1;.4H6RLaT>BKN?bM=0=7H3gQ^gD;+R:@dT+X8BEEK]UaL&=XaNQbT3#P/H_L\J<
W#R0M=H]4D))Y)TW-JfB+]0K[>8-]G5)U0]K^F\dE(2(Efc#g5,GVLHUMPg)@a#\
CP\Xd_K=B&I5-7DFZfG1WYKC#5e@N;=S37L\]70/VQYK.T&@N?VV6\HUK$
`endprotected


`endif // GUARD_SVT_CHI_HN_STATUS_SV
