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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WBSi2e3hfekAMecx9KNCytqDu6kzbSXQboyP1cFSF3+DdNh+bbIjjrWoa5Qlc+xZ
s3ukmp5QbTELO2qWE34HuojOrVJtpyXARnOJW6cD7TcLtmBR3JxWPkazOwe+7sTN
PlLnp+3/C/epBoPRXMtLjMwzQ/prxB5uAhA7BvrsjLLkrN2bJoH3Jg==
//pragma protect end_key_block
//pragma protect digest_block
ITHp+4Ta3zJaz0yB5g3OokdHmZs=
//pragma protect end_digest_block
//pragma protect data_block
TSJ4Q30vnEIrdApyG/hzIIuNID0ViOwifNVwtw1Uf0wO3A/LT8o8u0W1YQQlfD/Z
J0gYrFFnhrxLDyEPenMRHICR61530hrWJDm1albGA8tG14gXM0J/s06+BDFRXbSx
BLjvTpWHNHnxBQ5zaHTpNgESr3Qu/qfFIQ2GO0+8j1vawvPB3kMBqh0dbIk3RknH
Uxm4iuwbtOI3gvttPXw46+8b5vaLNB4pdvIfRnCKtYsnVpgywJw2Pp7PZxRF8Yow
NScza978s7B7HIamfctEiUX1z/xc8BInKoDWmiZDmnavQyirePN7TxTfJB5nNiGg
fh+EMJRp0mlKiS4l4K4V/+Tkf01Sq3KnEbw3i98/qK7T3O32UJJn/XgfyuSSpHR+
4P0XQfPp74bQTjkqjbuEb+Qpmca69/+Xk7guhCUVGv4T+TNjPk1PXZqPU/07Cbu8
bOUKEtEmWgPlhWFMEpmnNDKzBE7m+jnpb+/DDSWMGtn/59hBZPXKkCxNw5RIpFGA
DWFghXGeXrZU02uWJtLMcRpO7UAHimiFUmnBNEVxJ2qmjSLo5+l9StLTHdRjQs7/
daUUrz/2PWny1C4R3tjr2gFCvVahA9Mb6a5aLgRgZm67i2n4xm42POXQSL2P/NtE
obeurXiWQ9vh7mq7ZLxbqOVlM8xK0UMRTsk9F9087YZXrUSx9EB+9y5SlSjwSRwI
3j0QnP2JVHCh3sPUNS0pdeE6EES36II1ql2auIFjOqy9OYfdLSW7T2TPbq+sLyaL
l0fytM49dy1049Fh27wwTGRHzqQQyfFkDIC4rd2K/tH31zAM8CvXB47L5FIVy/SX
hr6hbTKc/aF71VawCg/2YWku8CQk1JTW18MKFQZ9VqNbdDHy/A0szPSOfuX76fzV
5AyDeWAaB5DEH2qas5X7Wja6ibeWtmvJh1Sbf/BWfMKvHunTtJCMuGGxMsy7mxXm
epv3HrMYIEVGn+Qu9d5Xzj9ji8IfT0oXQs1acty+KlrEYLNvCeGpFOTE03TNKjp7
jXz0kKKxZaLtPQbWM0jdfeTWmZkizI0Gp4aWrAzOaHUAOLp53iqV8snxlHLHyfaQ
3iZDgzXtj153RvP/74BfO6PHgIoMtd+XYtGBWAaja544357ET54STvPxVeYlpDCo
P6myseg1C7WSqB0ArJz16Tu6hz6ugOLFoRTnEDuIvZj7UDLSvmeheImx7zJu8QXR
/LMRnMg+SwPsN+Ab9z0sjdbTY8+gxRy6nbUH4yoykOtOrcRhx+77W0Mu1JBXzmY8
wenj8X37224Ouua9qUZ8tIfMDG9f20CEjlipXKnhKITMOvhSt2b1mTz5XH9AibmB
Jl45TdOmxiLYWUUGMUWYzKNGgS5C8yjJO/dEGcnbJmGVWhV3c78qMn5W6uS3OtLs
g3hFE+pwFNGTkcddMMjEc8qtgypDPCPg26xo/5JbyaZIDh7jv5FUlgavZx+zIrlK
96RtpB5LzI4CmyvCa4XKwGx2rn86HjlyjSrvJO8E+9UA5DzPSvfA9d77EYhpHNLc
GUDzsRPvyB954koPvE2wXn8BJYfyyM9FpbiAlkO27nmMgDQ2BNZjJCfo5P3NmVad
W3N+3BDTwQQgxwdQC2mDa3l7XzJzn2M/qzbC3I0Dpb7enMX+LqleLJ7NTGGu/Fkv
k2XOO13pTYbdHw9191ORDIO0TaplAb/FZRk1vRU33CSFfkfPAhtTKreH4q5bKIiB
7QW3it/degHXGLAaz0JUiaD3LhWRUnqA3rJTe+RcCGhEFf/oydS6D+/uxxdco++5
xw+bXBXvurt9xR05NsFnjLwFT9hoYMUHHvjK8+4gwcMKAO5uinNwfo/jnYiyZzkf
/UgUFNfJmGVWtwWULeZmRySVgo0KU7kAgp0jqBrhEjPUc9PDBVpsQEZIHklVjkm4
J9TL5mfDSMyZmYUduQUGqrGDjFf1hskI9DA/WBmOpq00pNQX1bJQcvDJn53eFm45
xoefq6SPTMugSR6nhtmiKSad9ZNIsD2/8RmnR9N78bZjfNss7J6fTXZJhDRH8dE+
2yMTJ/Vo7nP2Tio4VhrVTN3u/1yg3MIY/K4/qjcyznwuU2JW7klGFTQgqvN2FAw6
jt9jAsb6ByUCK9hKs3d+rQV8hWS9O3Emz4r/+S8MrAYRhr1yxz3r6JGCFy4QMmIW
wfKL6mAp/pBpkzOgEjysK+okk2x+A+5zHApdvwuz9dWX9GRWG5Pt5gvHcgMaJ74c
YGG0IW6xF73jUznUiYwsS5eimLMhWn2dwYO/+bk2nw0Jx5sxJAPWLa69UFU4w5bi
7R6zz/+52NFhrYugP/v91KnUf6uGdYqcBa73qEF7BPQSa5c1u0fjjn0H9o7BcRPD
KzOsjWe4G+M0G2cv8b9C7s7TX3p/o6SEiBxTBlDQmm3ZWeB0K9qhIKa9XnJf9BW3
0oCzp/ozFTZqcg474y7aUBiXzSXe9OmhQmywHW7tPCCXZnd9nGTnMmWhBgbqyaOj
0Vt6LgfrWr0X8lqxHARyzYN1xIWawgaIWPv3w6j23vhFgrjW8H7WWG31bv8jL7Gr
meLx3sOVbvXgE6Tb7/rsUTU/TOVZj5IztKqpK4CZM+EPpp3bT3JbDVc0eDo4yQ5K
4mWZ2XgXzwUb8eBLykDPVIPtzYGOERO+/uFHNT/loz0POKADgUIQ2iGlHRhr8r2+
z802XaCc8Lf+xX365PK4M8uVsVzv0OosToE0ApaXpEk8k41V+DMsqnlGQpKs+aBe
feGgCRiuoeTszEqQN8joSQ==
//pragma protect end_data_block
//pragma protect digest_block
QlqFcKr6cKX5gsjgnV0/5CvkXTs=
//pragma protect end_digest_block
//pragma protect end_protected
  
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KzH2JXO+e+XnVJNdxfIOlPdRENEwV+iSfHCZFN+jze7UxT1jFKnkCTAKsSUR2ROy
92t3mDOvM+8tFWyAepdmzrklIcwJEKGx7e7QiWr4sWTGOfCR4/xm315vVueAx1vW
HvoR9HT69zqgkQbwHom+fkeNz/1FcxI4VwDEpb/VTQ+kIooTWjYq8Q==
//pragma protect end_key_block
//pragma protect digest_block
gKPzjnogDt/wcYazCNO1LSWT1MU=
//pragma protect end_digest_block
//pragma protect data_block
eoC9wSnDq2amaxMJdaCEmYYiOjZmy3HAPgnZ+EKJbyEfe2AzLlRl99aU6s0nxq1h
qlpsaV41xUt4/90X35gdqJU9bD2rO7IYzDeGQQyN6m8bW6lFwJX+gUn9iGK3iQAA
MjVOazJNnwFbi4Me5yM+YbR9cQL9LCVvE6wrOBqRMm9mCN3HuSU4e6gMB7B5u0uj
RFAJQqDJKPEBAVcarfKnPCBuQGNvRYiWqnK+KmUt7ifUGmNOFPSNmNceJ3zYKhWd
wBbUdoUphGO80DOhUyueGN1m9fzOl8HDbP6Dfh+vxS8lNPdbet0TeuuVGfkaKekk
e9fWc6ZjIxc+GA9iloSa346j9BHVBmWBRfndBLIBjZXIXYjKRqqLc8u4ozIDv9i/
SdEjm2ojr0fLIPckXrMg/rDi9MP0zo5FCsWpAw48cbC3rXLqXA5MnoqLYccm0KCA
W+QSkitiEuiV1ww68Bu3u9/dIX0yOF/TjjQhowAFFLaq0CdqhXa8PLeydO4Qdol4
FkebzMKfxAS0w2mNczUAIEbpHkMK47sF6UKFbTAjhl1PTPv1A8v5bo6YncyFBuQg
01sHAwt5+M6jFkCn+RMSvYL2SdsqEohG8mclCeGPkKa4PfTzEZdkI8LCBmdtHTbY
DJKlrwN/9P/D8x5+bBe7iE/2WgwdrWX+Y+gAJD0/lE7+e0LZHf1X7MPoGraT1jeI
pgPsVJEy1P6QStYUdAt8n/KCBeJrSgqP4E6okv+oiFjs3yPTDHvBgNd7P6RkR1zX
JRxMSon2jTqT5LiLbOAvqCwy7AeK2YXSmL1wVxA3gy334b6Zn6R8l1ZbpDbZF8qu
KzQR4NiHWWidRFzOokwT4qilptozlNGH7ZaxUTDAEzA+VWIPw2StF/M1uOP5V5lQ
lcWRpKgGA2BYBiYH2woc0ccfgSDkLwu7ILAveeUT3YnVa4PHp2zgWHRPDXEi1sJW
W4RlTJAbIVhULR2RQEG84W/oFgQ9Mh99he2f8Lcvewj/Z9l3MJOpe/Kk+fU1y2Y0
bmdorYUQ8dsaHp5AMlcXK4wOoxtzqmmx1nQfx9w7YGVI2opcWc3wD45IQcgGrGVJ
iPvqXCU01TUQS4XDav2SF07vGeBqITpV8bPwinxzFDK6/KQnGEbgtl5gdtwEIkJr
8fehJpLXnSzSK+4rHLRscNHR44jBxPvUBhbvN+VhLs4sXD0QGes2CyTTC1awmrf8
81U+lo/Noq0D+yKOhTphgnixWs9uWGZuwhivF16yhnlojX9hpQmYjkbYc+Q8RO7V
KQZhZ+6ymySfgEzipt2m7tfKERU/G3Ik18SSFsBHRBerxTT6KYo1V7a4DBu421F0
gGLIyopLWNiF9yssKRIIKBjMk+2gkHm1ct7cw3NEWg8SWJRu+l3LrJqrYzs9EpaJ
OJSBT8YdfJ6YebLybLMN+6qjMx+tPXKuc1FJIRWFpj3RP1Sg84wynL9JOP5JCbL5

//pragma protect end_data_block
//pragma protect digest_block
nIwqqv8/OMJcfFPldTZsVju1xGk=
//pragma protect end_digest_block
//pragma protect end_protected
  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_hn_status)
  `vmm_class_factory(svt_chi_hn_status)
`endif

/** @endcond */

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wcb/iLBzJCpHR7PS+UVvaYZ50v2zwollP+THBVj1iDRfPaG6QKvbQNu2uPWRFtAO
l4/GOxXP4FZO6LzK68HqLM1ixknbOGaFG3KCjRZO3IfjOBlUWqD7aW5XFLThbwwy
eme+A7EPXdvLzzpqb2AI6icoklcUrSaBitTyxV7mBpdYhcxcOHZPyw==
//pragma protect end_key_block
//pragma protect digest_block
RiAqkGbLwq9RVM6gtxCrcg9NyC0=
//pragma protect end_digest_block
//pragma protect data_block
9+U2ZEkAUIFaRiZk/dcp3oXxpKf28XAsYz6WeCzdCej1uPK8XxnCgP9to9ELRMvb
eW3oG4varS43A6uiIvnjC7v2znRiPll0LAIPR8UxZA3racCd+PNBx/LQNJ8f7yqx
mU3MV/4BksPagPiX+XsZNbmbQ5nTWXmIfWBvmZm/v81vBQ8r0qnHpjDsoh7EjRVO
vX20PmkeCAi5L9FAaKRBTeuBR8Dlmyn684zZTnvVUtdAmYlWXRafo564eXy9AMBB
7Bg2oruSIj38ehkP8NWg8N1lntAyJS7hCdIvdAKd94bxMQ5G5q9nT6yG3TfvKTZj
0WdXvZ7qAMIzeRNc+rFSFCwZfnxxwuD5MgzwOvxRKEB9GwD3tTtAWx0tIxDLAw6U
4X30TvTQ2UPNJ5DyKplYrLZ4RYAkLPpnoWmBcRhPqG28ywHmwTTveOI0pM4lksVX
iuzD2yj+Lo6q2ZmYwV8Rx1Tvqou4T3sAfTZlCd6dkQx2UtQ/oln8BMQpyhhjGf5x
mAv99JLaudketOVrixkJBYt9fmG4+FBeo1ZWbOVy8+jflevrlXhe0wmUCGBl/FJ/
GmKDOFmP6SYapU11PY3BlG3VjoFwCTc3AqFGZBZTZUamzUEQjoX0Rl+wXUiY/Xn/
adK/Pe5rVpnHqwo4Ff17OpuYJVU9PJyCMSRAwVYC7zbFyATtUqrJpRBMw9WClMhi
nKOamslJhc1YsSoqdNJtMzx7LyfrEVURCZSXjb1gv4wez2U0dTjZX4mE0C/d2vXn
gdg1HkD/LyfuxR9RTojOqtOEoPq9sxHCcADILoEfwTMjjICqP3BUC89Sflp6IseR
4bWFgl6lCZIftZ30RKSV8qyXrBg5XjvNySR/V6nZNYHyg4Y6igvNpeDh5/ITpxft
R2FyvoJWopyViH0T0YZLlVeMdg4zmqDhUoVc6QsNtUSTWKTGCA2v8BO7Po/KzDSA
LTmZzVbhPXyo8wjEKKGHHXudifisXSgvu9PowYa0ekOg5utibblDdbLs+bd/087T
kw7pbEK5w34KgY0wiV9eZwZQQPyPmImtHP2Xf8v2ZdjcLze9JmfOiKwdsKFYgHDc
Pp6yFAFPY7YvMDuf58zWi/bxYXQHo6/wFD4GdSi/HqkF4uiuQfe54usJwl15sftL
at7nR36nBVCR1FlOr9/mAibyadHu83Q2gv4OgdoV1OOXVdMoLWAitrSM+9HuKn6z
GEL3FoCBbw/2AQUSxiIewR5S4V/xrJI8nYVR8lbfuvpxU2u+lBZ8zDEVi12MP75l
03GXDxLMoEwO1MtijzydYqG7L/GSlxss9MpnQDawUcTZMbaLS8oV6VbTc8l/TeEb
En9vP4Fonj0ONUvJYrWfC/WXyrGJDFI5f1sanDmR3gN+kQhJhAZshcP5WDWq9T8c

//pragma protect end_data_block
//pragma protect digest_block
HkazcJKYW9aBvUJkVSJyPwsN6/Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qMmnz3X1wmEZkLZyx6NE+x9wCsFrsh5R3gNKSeVJNXrJsiGAbiNtztyk+njd22Mm
K+NTwBswE+9aro9wMN9rNMZYqelZPVTB2wmC5m4GSr2u8Gh5ZgvY/VQOpBzfNiJ9
XN1p8jGSXq+nASZHRoi3hM2b2Yy1qj4nkDi1U6Qo6VYPnzk6HHoR7A==
//pragma protect end_key_block
//pragma protect digest_block
foZ7t24vPqIbB+0LoQULcyYCWVU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
R+B3ssJiywAemiXZ8GjN4zjQKrc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_HN_STATUS_SV
