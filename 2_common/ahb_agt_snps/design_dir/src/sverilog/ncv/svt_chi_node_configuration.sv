//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_NODE_CONFIGURATION_SV
`define GUARD_SVT_CHI_NODE_CONFIGURATION_SV 

`include "svt_chi_defines.svi"
typedef class svt_chi_system_configuration;
typedef class svt_chi_system_domain_item;

/** @cond PRIVATE */  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
s3HAsissx+dWy9eTHjsuaLmxUVU6qtNG3gairaJdFg7MqsO0JIM4D4C4Wd4dccCs
4C7B5+u0hhKpPAvpPWU26P01MkD84NX6C+GWnTi3ku2OIBT1xIJMVkKlvnxyboBu
4dpsjU3h2UN5qf+lwSW6FC/OuqZgPCttzHAZ7ybLRNc5ZmyFl6giVA==
//pragma protect end_key_block
//pragma protect digest_block
MJEdbjSwSwyUoIY9j9D07I7PNjI=
//pragma protect end_digest_block
//pragma protect data_block
OsuGxMab7tjRyO4PER8Nct50RIzQzEC94vSUDyIZTNn0bA/yJlrMQDvgZexAvPCz
KJK8TeYhhMuSCKqVSYPaqslKdAD8OZhQEhHw2YgrbJDKnBCZfsbzWQ5IUjSMklox
dbC1kv/OpjNUvKBMfJebdrVpITe/MFbhENqFP/Ihh7MdU8v6d4vTD5ssq7DKBj5r
l+tlHSELxgq+MKX49KVvvp2DcLo+V+MrBsqIx0IQF+yeKn9RMdexq02MoRaL18VQ
iFvtcy2LAirzU7Egq+o3109UWGCl9nu6sQz1EorFQ7fNou625AMNtUxL+gfZE8SC
2PvMr15TrFSyN/417Bjg2AuooQIJB8lQDvMkm7l5XibUT3mki4JdcotWcm38P2wt
55C7e8Nn8S0iml/YwRPCnCSY48MAiGUdxvvyn+MhfoUSxkCQ/+/Fu7LX83JBZofW
NYOcEPOG5Rqv7M8MNwq0IlXkf5MAp2Urnk1IljSCb7uB2QzGtgnlZ6LeVjmhxFEM
Mav2yBgXrwBI5oVpDrzNrn2wNqmry/A2vCx3CwW5JHwNlGzDXg7fKtupqMCIYpt2
I/46vR02x6rzJHL5IPtZbz+2qUZ3TKJjBlUa8M0hPtxXem8bgN1tyZLG8Te5UwS1
yP4a1nDt/jL+Se3WAJdAubfILIu9gznFtUlY0z4M/PC9lMKi3JxB/zCClCNz1VRP
V1p9j9Z8fi7h76VaiPPFrZmjm62mRtxopMNX6+UiJNZEpIxGzgCbpUaelpKTjIJ9
eg0vETgyTEZq5bpBbuRXSMsx58QrVNAyUPHC8Hftye4tsWJKHJHlJMLI9bdyNNfW
mYVV84NIDlcUfPH8wX1WFSUdqHcVzlQbXZSf3TrpQzxTzwJhj6cFiFL89ieGU+/k
nxj1DDCc2AV9D7mFDBbE54ncTDegbYx+dL9pfhpyIFQsSAwvBqLKb6Fzt2SPB5NL
w1tKoX+oJNFN12AzxQTZkiNZ8Hm/qhPVODOyu4OJY/7ZKPUZzFBwPxsK/grHbOdP
9pJ1EXby6elrZwGvE6mS/dxDLhd/muiHwMuhrEYEPxrc9wxOnbsr69CAMsEyIzjL
b/+463FP43NiYDkBmh+mH+DqdGeZJLDxNoz06c4zmBUEQRs3Sfcanq6+rFkb7oGG
oyU8d8c1brtDKBEle199nTv1T08Ea4RyMvwUB7u+Maf5RMCiXeP3TzJgkZn41e+6
1FGg1dNCFzNluO8xyVn9KXJs9iO+UqZqgpho4E5yWQAcTSLxbj6CkrRmdbmddnxi
tKN0mVq3moch6F1ZfsvmOVOeHD24JB3PaD2q93a83rvtLjT1l5DVVFm649Ctc5PY
xORSBME1SHfO4W2SWTAqM1H+tWmCcvnxypoaSJl4S0ySDn3BFo18gdgihyzno4e2
hnUlbpVEl26ZixmE1BUNZwrMlejrhRFPbGKk2eRkLhekvBHMMI1lVxSEAW4dGfhy
7coBwesCN460I4tYWK/LQpx/3aFMDwzyA8U/rygRMbS+wVVEpZxl5Za7NaPIF25D
FggF+AVVE8euCcC73+1Opw==
//pragma protect end_data_block
//pragma protect digest_block
nEICy23oTx23aLxynJgDIk4gmI0=
//pragma protect end_digest_block
//pragma protect end_protected
// =============================================================================
 /** 
  * This class contains AMBA CHI Node Configuration. This class acts as a base
  * class for RN and SN node configuration, and contains fields required by
  * both the RN & SN node configurations.
 */
class svt_chi_node_configuration extends svt_configuration;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------
  // vb_preserve TMPL_TAG1
  // Add user defined types here
  // vb_preserve end

  /** Custom type definition for virtual CHI interface */
  typedef virtual svt_chi_rn_if svt_chi_rn_vif;
  typedef virtual svt_chi_sn_if svt_chi_sn_vif;
  typedef virtual svt_chi_ic_rn_if svt_chi_ic_rn_vif;
  typedef virtual svt_chi_ic_sn_if svt_chi_ic_sn_vif;
  
  /**
    @grouphdr chi_config_secure_access Secure/non-secure access related configuration parameters
    This group contains attributes that can be used to control the secure/non-secure feature
   */
  
  /**
    @grouphdr chi_config_outstanding_xacts Outstanding transactions related configuration parameters
    This group contains attributes that can be used to control the the maximum number of transactions that can be outstanding at the node
   */

  /**
    @grouphdr chi_config_reordering Reordering related configuration parameters
    This group contains attributes which are used to control reordering of DAT, RSP flits of transactions.
   */
  
  /**
    @grouphdr chi_config_delays Delays related configuration parameters
    This group contains attributes which are used to control various delays.
   */

  /**
    @grouphdr chi_config_txsactive_delays TXSACTIVE Delays related configuration parameters
    This group contains attributes which are used to control various delays.
   */  
  
  /**
   @grouphdr chi_config_link_layer Attributes related to Link layer 
   This group contains attributes which are used to control link layer.
   */

  /**
   @grouphdr chi_link_layer_vc_idle_value Virtual channel idle value configuration parameters
   This group contains attributes which are used to configure idle values of virtual channels.
   */

  /**
    @grouphdr chi_timeout_config Timeout values for CHI-RN and CHI-SN
    This group contains attributes which are used to configure timeout values for CHI-RN and CHI-SN signals and transactions
   */

  /**
    @grouphdr chi_performance_analysis Performance Analysis configuration parameters
    NOTE: These are supported only for UVM, when used by RN and SN agents. These are 
    unsupported forInterconect VIP. <br>
    This group contains attributes which are used to monitor performance of a
    system based on measurement of latencies, throughput etc. The user sets the
    performance constraints through performance analysis configuration
    parameters and the VIP reports any violations on these constraints. The time
    unit for all these parameters is the simulation time unit. Performance
    metrics that involve aggregation of values over a time period are measured
    over time intervals specified using configuration parameter
    perf_recording_interval. Measurement of other performance parameters that do
    not require aggregation of values over a time period are not affected by
    this configuration parameter. VIP reports statistics for each performance
    metric for each time interval. Each performance parameter can be enabled or
    disabled at any time.  Monitoring of a performance parameter is disabled by
    passing a value of -1 to the parameter. Passing any other value enables the
    performance parameter for measurement. If a value other than -1 is supplied,
    it will take effect at the next time interval. If the performance
    configuration parameter values are changed during simulation, the new
    configuration will need to be passed to the VIP using the #reconfigure()
    method of the top level VIP component, for eg. #reconfigure() method of CHI
    System Env will need to be called if CHI system Env is used as top level
    component.
   */

  /**
   @grouphdr chi_exclusive_access Attributes reated to Exclusive access 
   This group contains attributes which are used to control exclusive access.
   */
 
  /**
   @grouphdr chi_config_port_interleaving Port Interleaving configuration parameters
   This group contains attributes which are used for port interleaving feature.
   */

  /**
   @grouphdr chi_config_mapped_node_id Mapped Node ID configuration parameters and APIs
   This group contains attributes which are used for Mapped Node ID feature.
   */  
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /** This enum declaration is used to indicate the CHI Interface type. */
  typedef enum  {
    RN_F = `SVT_CHI_INTERFACE_RN_F, /**<: Interface for Fully-coherent Request Node */
    RN_I = `SVT_CHI_INTERFACE_RN_I, /**<: Interface for IO-coherent Request Node  */
    RN_D = `SVT_CHI_INTERFACE_RN_D, /**<: Interface for IO-coherent Request Node which includes a TLB. Such a node receives DVM ops on snoop VC. */
    SN_F = `SVT_CHI_INTERFACE_SN_F, /**<: Interface for Fully-coherent Slave Node. Such a node communcates with one or more HN-Fs(Fully-coherent Home Nodes). */
    SN_I = `SVT_CHI_INTERFACE_SN_I  /**<: Interface for IO Slave node. Sucha a node communicates with one or more HN-Is(IO Home Nodes). */
  } chi_interface_type_enum;

  //----------------------------------------------------------------------------
  /** This enum declaration is used to indicate the CHI Node type. */
  typedef enum  {
    RN = `SVT_CHI_RN, /**<: Request Node */
    SN = `SVT_CHI_SN, /**<: Slave Node */
    HN = `SVT_CHI_HN  /**<: Home Node */ 
  } chi_node_type_enum;

  //----------------------------------------------------------------------------
  /** This enum declaration is used to specify idle state of signals. */
  typedef enum  {
    INACTIVE_LOW_VAL     = `SVT_CHI_INACTIVE_LOW_VAL,      /**<: Signal is driven to 0. For multi-bit signals each bit is driven to 0. */
    INACTIVE_HIGH_VAL    = `SVT_CHI_INACTIVE_HIGH_VAL,     /**<: Signal is driven to 1. For multi-bit signals each bit is driven to 1. */
    INACTIVE_PREV_VAL    = `SVT_CHI_INACTIVE_PREV_VAL,     /**<: Signal is driven to the previous value. */
    INACTIVE_X_VAL       = `SVT_CHI_INACTIVE_X_VAL,        /**<: Signal is driven to X. For multi-bit signals each bit is driven to X. */
    INACTIVE_Z_VAL       = `SVT_CHI_INACTIVE_Z_VAL,        /**<: Signal is driven to Z. For multi-bit signals each bit is driven to Z. */
    INACTIVE_RAND_VAL    = `SVT_CHI_INACTIVE_RAND_VAL      /**<: Signal is driven to a random value. */ 
  } idle_val_enum;

  //----------------------------------------------------------------------------
  /**
    * If svt_chi_node_configuration::single_outstanding_per_txn_id is set to
    * 'MODIFY_SAME_TXN_ID': If txn_id of a new transaction matches
    * txn_id of an active transaction, the VIP modifies the txn_id such that the txn_id 
    * is not overlapping with txn_id of any active transactions.
    *
    * If svt_chi_node_configuration::single_outstanding_per_txn_id is set to
    * 'WAIT_FOR_COMPLETION_OF_SAME_TXN_ID': If txn_id of a new transaction matches
    * txn_id of an active transaction, the VIP waits till the
    * corresponding transaction is complete. 
    */
  typedef enum {
    WAIT_FOR_COMPLETION_OF_SAME_TXN_ID = 0,
    MODIFY_SAME_TXN_ID = 1
  } single_outstanding_per_txn_id_enum;

  single_outstanding_per_txn_id_enum single_outstanding_per_txn_id = WAIT_FOR_COMPLETION_OF_SAME_TXN_ID;

  //----------------------------------------------------------------------------
  /** This enum declaration is used to specify the programming mode for data and byte enable */
  typedef enum {
    STANDARD_DATA_FORMAT = `SVT_CHI_STANDARD_DATA_FORMAT, /**<: Data and byte enable are configured as per the definitions in wysiwyg_enable */
    HYBRID_DATA_FORMAT   = `SVT_CHI_HYBRID_DATA_FORMAT /**<: Data and byte enable are configured based on transfer length */   
  } chi_data_format_enum;

  //----------------------------------------------------------------------------
  /**
   * Enumerated type that indicates the reordering algorithm 
   * used for ordering the DAT flits and RSP flits of transactions.
   */
  typedef enum {
    ROUND_ROBIN     = `SVT_CHI_REORDERING_ROUND_ROBIN, /**< Transactions will be 
    processed in the order they are initiated/received. */
    RANDOM      = `SVT_CHI_REORDERING_RANDOM, /**< Transactions will be 
    processed in any random order, irrespective of the order they are initiated/received. */
    PRIORITIZED = `SVT_CHI_REORDERING_PRIORITIZED /**< Transactions will be
    processed in a prioritized order. The priority of a transaction is known from
    the svt_chi_common_transaction::qos attribute of that transaction. */
  } chi_reordering_algorithm_enum;

  /**
   * Enumerated type that defines the behavior of the VIP during reset
   */
  typedef enum { 
    EXCLUDE_UNSTARTED_XACT = `SVT_CHI_EXCLUDE_UNSTARTED_XACT, /**< Only those transactions which have gone out on the interface are ABORTED. */
    RESET_ALL_XACT = `SVT_CHI_RESET_ALL_XACT /**< All transactions which have already started along with the ones which have not yet started but are present in the internal queue are ABORTED. */
  } reset_type_enum;

  //----------------------------------------------------------------------------
  /**
   * Enumerated type that indicates the TX***FLITPEND assertion for all the 
   * Virtual channels of the CHI node that uses this configuration object.
   */
  typedef enum {
    FLIT_AND_LCRD_AVAILABLE, /**<: Assert TX***FLITPEND when the FLIT is ready to be transmitted and corresponding L-Credit is available */
    PERMANENT,               /**<: Permanently assert TX***FLITPEND after reset is deasserted */
    FLIT_AVAILABLE,           /**<: Unsupported. Assert TX***FLITPEND when the FLIT is ready to be transmitted irrespective of corresponding L-Credit availability */
    FLIT_AND_LCRD_AVAILABLE_FOR_PROT_FLIT_AND_PERMANENT_FOR_LINK_FLIT /**<: For Protocol Flits: Assert TX***FLITPEND when the FLIT is ready to be transmitted and corresponding L-Credit is available. For Link Flits: Permanently assert TX***FLITPEND during TXDEACTIVTE state */

  } chi_flitpend_assertion_policy_enum;

  //----------------------------------------------------------------------------  
  /**
    * Enumerated type for the kind of inactivity period for throughput calculation
    */
  typedef enum {
    EXCLUDE_ALL = 0,        /**<: Excludes all the inactivity. This is the default value. */
    EXCLUDE_BEGIN_END = 1   /**<: Excludes the inactivity only from time 0 to start of first */
  } perf_inactivity_algorithm_type_enum;

  //----------------------------------------------------------------------------  
  /**
   * Enumerated type for the CHI spec revision that the node supports.
   * - ISSUE_A: The node supports only CHI Issue A spec features.
   * - ISSUE_B: The node supports CHI Issue B spec features.
   * - ISSUE_C: The node supports CHI Issue C spec features.
   * - ISSUE_D: The node supports CHI Issue D spec features.
   * - ISSUE_E: The node supports CHI Issue E spec features. VIP currently does not support ISSUE_E.
   * .
   */
   typedef enum int {
     ISSUE_A = `SVT_CHI_SPEC_REV_ISSUE_A,
     ISSUE_B = `SVT_CHI_SPEC_REV_ISSUE_B,
     ISSUE_C = `SVT_CHI_SPEC_REV_ISSUE_C,
     ISSUE_D = `SVT_CHI_SPEC_REV_ISSUE_D,
     ISSUE_E = `SVT_CHI_SPEC_REV_ISSUE_E
   } chi_spec_revision_enum;

  /**
   * Enumerated type for the DVM Sync request transmission policy.
   * - WAIT_FOR_ALL_NON_SYNC_TO_COMPLETE            : The node supports sending of a DVM Sync request only once all outstanding DVM Non-Sync requests are complete
   * - WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE : The node supports sending of a DVM Sync request only once all outstanding DVM Non-Sync with the same LPID are complete
   * - DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE         : The node supports sending of a DVM Sync request irrespective of whether there are outstanding DVM Non-Sync transactions.
   * .
   */
   typedef enum {
    WAIT_FOR_ALL_NON_SYNC_TO_COMPLETE,        
    WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE,        
    DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE        
   } dvm_sync_transmission_policy_enum;

  /**
   * Enumerated type for the DVM Version Supported by the Node.
   * - DEFAULT_SPEC_VERSION     : The node supports all the DVM operations that are specified in the specification corresponding to the chi_spec_revision.
   *   When chi_spec_revision is ISSUE_A, the node will support all DVM operations that are supported in ARM v8.0.
   *   When chi_spec_revision is ISSUE_B/ISSUE_C/ISSUE_D, the node will support all DVM operations that are supported in ARM v8.1.
   *   When chi_spec_revision is ISSUE_E, the node will support all DVM operations that are supported in ARM v8.4.
   * - DVM_v8_0                 : The node supports DVM operations that are supported in ARM v8.0
   * - DVM_v8_1                 : The node supports DVM operations that are supported in ARM v8.1
   * - DVM_v8_4                 : The node supports DVM operations that are supported in ARM v8.4
   * .
   */
   typedef enum int {
    DVM_v8_0 = 0,        
    DVM_v8_1 = 1,        
    DVM_v8_4 = 2,        
    DEFAULT_SPEC_VERSION = 100      
   } dvm_version_support_enum;

  /**
   * Enumerated type for the SnpDVMOp Sync response transmission policy.
   * - WAIT_FOR_ALL_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE            : The node supports responding to SnpDVMOp Sync request only once all outstanding DVM Non-Sync requests are complete
   * - DO_NOT_WAIT_FOR_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE         : The node supports responding to SnpDVMOp Sync request even when there are outstanding DVM Non-Sync requests.
   * .
   */
   typedef enum {
    WAIT_FOR_ALL_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE,        
    DO_NOT_WAIT_FOR_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE        
   } snp_dvmop_sync_response_policy_enum;

`ifdef SVT_CHI_ISSUE_B_ENABLE

  /**
   * Enumerated type for the DataCheck computation policy.
   * - COMPUTE_DATACHECK_ON_VALID_DATA     : The node computes DataCheck only for the valid data bytes corresponding to the transaction.
   * - COMPUTE_DATACHECK_ON_ENTIRE_DATA    : The node computes DataCheck for all of the Data bytes that are transmitted as part of the transaction, including the invalid byte lanes.
   * .
   */
   typedef enum {
    COMPUTE_DATACHECK_ON_VALID_DATA,        
    COMPUTE_DATACHECK_ON_ENTIRE_DATA        
   } datacheck_computation_logic_enum;
`endif

  //----------------------------------------------------------------------------  
  /**
    * Enumerated type that indicates the Critical chunk first wrap order supported by the node. 
    * - CCF_WRAP_ORDER_TRUE : The node support sending/receiving data packets in critical chunk first wrap order.
    * - CCF_WRAP_ORDER_FALSE: The node does not support sending/receiving data packets in critical chunk first wrap order.
    * .
    */
  typedef enum {
    CCF_WRAP_ORDER_FALSE,        
    CCF_WRAP_ORDER_TRUE          
  } ccf_wrap_order_enum;
  
  //----------------------------------------------------------------------------  
  /**
   * Enumerated type to represent txreq_deassertion_when_rx_is_in_deactivate_state reference event.
   * - TXREQ can be deasserted immediately and move to deactivate state.
   * - TX can wait for all the credits to be accumulated on its RX channel and then deassert its TXREQ signal
   * .
   */
  typedef enum {
    WAIT_ON_CREDIT_ACCUMULATION_BEFORE_TXREQ_DEASSERTION = 0, /** This is the default value. */
    IMMEDIATE_TXREQ_DEASSERTION = 1
  } reference_event_for_txreq_deassertion_when_rx_is_in_deactivate_state_enum;
  
  //----------------------------------------------------------------------------  
  /**
   * Enumerated type to represent txreq_assertion_when_rx_is_in_deactivate_state reference event.
   * - TXREQ can be asserted immediately and move to Activate state.
   * - TX can wait for all the credits to be accumulated on its RX channel and then assert its TXREQ signal
   * .
   */
  typedef enum {
    WAIT_ON_CREDIT_ACCUMULATION_BEFORE_TXREQ_ASSERTION = 0,  /** This is the default value. */
    IMMEDIATE_TXREQ_ASSERTION = 1
  } reference_event_for_txreq_assertion_when_rx_is_in_deactivate_state_enum;

`ifdef SVT_CHI_ISSUE_B_ENABLE

  //----------------------------------------------------------------------------  
  /**
    * Enumerated type that indicates that Datacheck feature is supported by the node. 
    * - NOT_SUPPORTED : The node does not support Datacheck error detection feature.
    * - ODD_PARITY    : The node supports Datacheck feautre to detect errors in the DAT packet.
    * .
    */

  typedef enum {
    NOT_SUPPORTED = 0,    /**<: Datacheck feature is not supported. */    
    ODD_PARITY = 1        /**<: Datacheck needs to be based on ODD parity. */
  } datacheck_type_enum;

`endif  

`ifdef SVT_CHI_ISSUE_E_ENABLE

 /**
  * Enumerated type to specify the behavior of the RN when NON_DATA_ERROR was seen in the response.
  * - CHI_D_OR_EARLIER_SPEC_BEHAVIOR : The node supports the behavior specified in CHI D or earlier specs when NON_DATA_ERROR is seen in response.
  * - CHI_E_SPEC_BEHAVIOR: The node supports the behavior as specified in CHI E spec when NON_DATA_ERROR is seen. Refer spec: ARM AES 0003, chapter 20.
  * .
  */
  typedef enum {
    CHI_D_OR_EARLIER_SPEC_BEHAVIOR = `SVT_CHI_D_OR_EARLIER_SPEC_BEHAVIOR,
    CHI_E_SPEC_BEHAVIOR = `SVT_CHI_E_SPEC_BEHAVIOR
  } nderr_resp_policy_enum;

 /**
   * Enumerated type for the slcrephint_mode Supported by the Node.
   * - SLC_REP_HINT_DISABLED          : The node doesn't supports SLC replacement Hint feature and RN drive slcrephint_replacement feilds to zero.
   * - SLC_REP_HINT_SPEC_RECOMMENDED  : The node supports SLC replacement Hint feature and RN drive slcrephint_replacement feild according to the spec recommendation and will not take reserved values.
   * - SLC_REP_HINT_USER_DEFINED      : The node supports SLC replacement Hint feature and RN drive slcrephint_replacement feild in full range. 
   * .
   */
   typedef enum int {
    SLC_REP_HINT_DISABLED = 0,        
    SLC_REP_HINT_SPEC_RECOMMENDED = 1,        
    SLC_REP_HINT_USER_DEFINED = 2             
   } slcrephint_mode_enum;
   
`endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3qh+limB58x6u/zwb4rA8fz2aAg+66BBPSkKXq4TxDo9Ke/+Odm2ue0tVYMsW6zS
tfIC8D5hTHTtAmfCc7v8V/atSktNObkcz3GoW69bfCy1k3YD3fH0MwppohLllFFc
NVaitYd0mlTywfcDnb4XhpVqlHFkTdiwu5TxqtzRsTUl4aBPd9nIag==
//pragma protect end_key_block
//pragma protect digest_block
Ocruh6QrMeBNYMOseHDAg1fPamM=
//pragma protect end_digest_block
//pragma protect data_block
K0e2h747+cPTjb14OYsEqN2TXgRnGbOkwDkOm1KTPOoFwlRrhqGzw4LjzXp6jsUn
LIdzS1ZBNxGBjl/eEgmpP7+b8eUdbX5bKPuDRFQslK3YkWyFlP2bKin7Nt5MBZBj
E2J1HUQjgBOw3SNOH18okDQFoghe+bsVLu2U6nXwsOyZgS/zk9tes8JByIxHuY+V
/aXoKEGGkdk002Gz9Zot/haTmdrAQXUutC5v1TwE8LHXVDkI9Rtg0xfERaKGAPRc
a64KuHkFDg1NFDjYEwoy7wNqhjkfdEgpkVAkhKYOUmyAudjl/p8L0eykiuFIvrR7
qkBz1jbV9LwZ3UJB/pPluxX+i7SZpx3Jqa8DrqLFkT2rgsIZEDla0FGj7AbeONS+
S2O1GUw5eJbyuahZMbdstiGRoThnrAkIq7tv4weIhQs7l4ONHwF7LyV1r+czpOcO
G+ZgKgKVlE2sfFXHxJaqC3bK/hXyxSmJTEwIdsaK6RQH37gU3WKfNhvQVu2Y//b3
asVWM4Gv72b7CSTYqQYl3X7C5/MdYMFY8WUrSMdEHhqmELr9ykDEppL2lsQhw2FN
el82kpl+nyv/LSA6V/yAaJ9o3MCK9Nf8orJg4J1WJ78enCzPleflMTSz/9N7DGC3
n1VeBh1UjRlzEIejvFXPeWTn0n6mPgLOExCifl9rIuk9D/hSk52f4p++22OBOwRJ
W10YkGgSRiZ27Ldw3O6MX9/AXcCNMSgncjxQkat2sWejWQS3vxqRoZRAkUPKAqUH
zLNbKk1691l6WZtIQ6xFynfKJzlcDypN1yOgdkHbjJlYZkFylHU7Eoaz/i9mmxim
OQGMWHFWxBLlWxd4dXXmZbdqk1zf7A9hfQbravS7/g7Ip2pHFTfZbwD69wsRxdlY
hK8nEpZkWW37qH6SyaJau8b8j7uJo2Ui93ogQKo7DI1KHYBe8HtDbOT4Vp+QEQ/Q
31iYneXdUbW0GvJDjJ4gmuZAsFUA23m6TKJTzftUYrVdaUDDVu9HtKeexobFRsTu
1fUhh0EuvOjj5TUh8rb/OeNzYc1uFN3dBZ4mUofY/bsxpr+Fd6TfQC0B8nkf7y+l
n4ulY/rJ9d67xHK1HfYhGA==
//pragma protect end_data_block
//pragma protect digest_block
5Q1I+yqBeKIColy2J547xn+4MXU=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_CHI_ISSUE_E_ENABLE

  //----------------------------------------------------------------------------  
  /**
    * Enumerated type that indicates when the node receives a snoop request with RetToSrc set to 1 and
    * the cacheline is in SC state, whether the snoopee needs to forward the data to Home node or not.
    * - FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET : When the node receives a snoop request with RetToSrc set to 1 and the cache line is in SC state, always forward the data to Home node.
    * - DONOT_FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET : When the node receives a snoop request with RetToSrc set to 1 and the cache line is in SC state, never forward the data to Home node.
    * - RANDOM_FWD_OR_NOT_FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET : When the node receives a snoop request with RetToSrc set to 1 and the cache line is in SC state, randomly forward or not-forward the data to Home node.
    * .
    */

  typedef enum {
    FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET = 0,                    /**<: Fwd data to Home Node when RetToSrc set to 1. */    
    DONOT_FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET = 1,              /**<: Do not Fwd data to Home Node when RetToSrc set to 1. */
    RANDOM_FWD_OR_NOT_FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET = 2   /**<: Randomly fwd or not-fwd data to Home Node when RetToSrc set to 1. */
  } fwd_data_from_sc_state_when_rettosrc_set_policy_enum;

  /**
    * Enum type to indicate the interpretation of SnpPreferUnique transaction based on an ongoing exclusive transaction by the snooped RN
    * - SNPPREFERUNIQUE_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTY: SnpPreferUnique is always treated as SnpNotSharedDirty
    * - SNPPREFERUNIQUE_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE: A Snoopee that is not executing an exclusive sequence treats SnpPreferUnique as SnpUnique, respectively. A Snoopee that is in the process of executing an exclusive sequence treats SnpPreferUnique as SnpNotSharedDirty, with the exception that it must not invalidate its cached copy.
    * .
    */
  typedef enum {
    SNPPREFERUNIQUE_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTY = 0,
    SNPPREFERUNIQUE_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE = 1
  } snppreferunique_interpretation_policy_enum;
 
  /**
    * Enum type to indicate the interpretation of SnpPreferUnique transaction based on an ongoing exclusive transaction by the snooped RN
    * - SNPPREFERUNIQUEFWD_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTYFWD: SnpPreferUniqueFwd is always treated as SnpNotSharedDirtyFwd
    * - SNPPREFERUNIQUEFWD_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE: A Snoopee that is not executing an exclusive sequence treats SnpPreferUniqueFwd as SnpUniqueFwd, respectively. A Snoopee that is in the process of executing an exclusive sequence treats SnpPreferUniqueFwd as SnpNotSharedDirtyFwd, with the exception that it must not invalidate its cached copy.
    * .
    */
  typedef enum {
    SNPPREFERUNIQUEFWD_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTYFWD = 0,
    SNPPREFERUNIQUEFWD_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE = 1
  } snppreferuniquefwd_interpretation_policy_enum;

`endif

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * @groupname chi_exclusive_access 
   * Enum that represents different modes of  
   * error conditions used in exclusive monitor.
   * - SNP_ERR_EXCL_SEQ_FAIL: Implies that Snoop Error will cause an exclusive sequence to fail only if either data_transfer bit or pass_dirty bit is set to '1'. Otherwise, if snoop response indicates error bit as asserted then regardless of data_transfer bit or pass_dirty bit values exclusive sequence will fail. This is currently unsupported feature.
   * - CTRL_REG_NO_ERR: This is default mode set. Exclusive sequence will pass
   *   or fail based on exclusive access rules and not because of any control
   *   register errors. 
   * .
   */
  typedef enum bit [(`SVT_CHI_ERROR_CTRL_REG_WIDTH-1) : 0] {
    CTRL_REG_NO_ERR       = `SVT_CHI_CTRL_REG_NO_ERR, /**< This is the default mode set. */
    SNP_ERR_EXCL_SEQ_FAIL = `SVT_CHI_SNP_ERR_EXCL_SEQ_FAIL /**< Implies that Snoop Error will cause an exclusive sequence to fail only if either data_transfer bit or pass_dirty bit is set to '1'. Otherwise, if snoop response indicates error bit as asserted then regardless of data_transfer bit or pass_dirty bit values exclusive sequence will fail.*/
  } excl_mon_error_control_reg_enum;
  
  /**
   * @groupname chi_exclusive_access 
   * Enum that inidcates the exclusive monitor policy to whether allow multiple outstanding exclusive sequence per srcid per lpid. 
   */
  typedef enum {
    ALLOW_MULTIPLE_OUTSTANDING_EXCLUSIVE_SEQUENCE_PER_SRCID_PER_LPID = 0, /**< This is the default mode set. */
    ALLOW_ONLY_ONE_OUTSTANDING_EXCLUSIVE_SEQUENCE_PER_SRCID_PER_LPID = 1 /**< Supports one of the implementation defined behaviour for exclusive monitor in ARM interconnect. */
  } non_coherent_exclusive_monitor_policy_enum;

  /** @endcond */


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Enumerated type that defines the generator source for an RN or SN component
   */
  typedef enum { 
    NO_SOURCE = `SVT_CHI_NO_SOURCE, /**< No internal source. This generator_type is used by RN component. This specifies that no internal source should be used, and user is expected to drive the RN driver input channel. */
    ATOMIC_GEN   = `SVT_CHI_ATOMIC_GEN_SOURCE, /**< Create an atomic generator. This generator_type is used by RN component. This specifies the RN component to use atomic generator. */
    SCENARIO_GEN = `SVT_CHI_SCENARIO_GEN_SOURCE, /**< Create a scenario generator. This generator_type is used by RN component. This specifies the RN component to use scenario generator. */
    SIMPLE_RESPONSE_GEN = `SVT_CHI_SIMPLE_RESPONSE_GEN_SOURCE, /**< This generator_type is used by SN component. When this generator_type is specified, a callback of type svt_chi_sn_response_gen_simple_callback is automatically registered with the SN response generator. This callback generates random response. */
    MEMORY_RESPONSE_GEN = `SVT_CHI_MEMORY_RESPONSE_GEN_SOURCE, /**< This generator_type is used by SN component. When this generator_type is specified, a callback of type svt_chi_sn_response_gen_memory_callback is automatically registered with the SN response generator. This callback generates random response. In addition, this callback also reads data from slave built-in memory for read transactions, and writes data into SN built-in memory for write transactions. */
    USER_RESPONSE_GEN = `SVT_CHI_USER_RESPONSE_GEN_SOURCE /**< This generator_type is used by SN component. When this generator_type is specified, SN response callback is not automatically registered with the SN component. The user is expected to extend from svt_chi_sn_response_gen_callback, implement the generate_response callback method, and register the callback with the SN response generator. */
  } generator_type_enum;

  //----------------------------------------------------------------------------
  /**
   * Enumerated type that defines the generator source for snoop responses
   */
  typedef enum { 
    CACHE_SNOOP_RESPONSE_GEN = `SVT_CHI_CACHE_SNOOP_RESPONSE_GEN_SOURCE, /**< This generator_type is used by RN component. When this generator_type is specified, a callback of type #svt_chi_rn_snoop_response_gen_cache_callback is automatically registered with the RN component. This callback generates random snoop response based on the cache line status. */
    USER_SNOOP_RESPONSE_GEN = `SVT_CHI_USER_SNOOP_RESPONSE_GEN_SOURCE /**< This generator_type is used by RN component. When this generator_type is specified, snoop response callback is not automatically registered with the RN component. The user is expected to extend from #svt_chi_rn_snoop_response_gen_callback, implement the generate_snoop_response callback method, and register the callback with the snoop response generator. */
  } snoop_response_generator_type_enum;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** RN Interface. */
  svt_chi_rn_vif rn_if;

  /** SN Interface. */
  svt_chi_sn_vif sn_if;

  /** IC RN Interface. */
  svt_chi_ic_rn_vif ic_rn_if;

  /** IC SN Interface. */
  svt_chi_ic_sn_vif ic_sn_if;

  /** Reference to the AMBA CHI System Configuration object. */
  svt_chi_system_configuration sys_cfg;

  /** A unique ID assigned to the RN/SN port corresponding to this node configuration. */
  int node_id;

  /**
   * @groupname chi_config_mapped_node_id
   * - Applicable only for RN-I/RN-D agents that are mapped to ACE-Lite masters, when compile time macro 
   *   `SVT_AMBA5_TEST_SUITE_VIP_DUT is not defined.
   *  That is, not applicable when CHI Interconnect VIP
   *   is used.
   * - This is not applicable for ACE-Lite/AXI slaves mapped CHI SN agents.
   * - This is used by CHI System Monitor.
   * - When set to -1: This attribute has no significance, and will be ignored by the VIP.
   * - When set to a value other than -1: When DCT is exercised by a HN for a coherent read transaction 
   *   from ACE-Lite master that is mapped to RN-I/RN-D, System Monitor expects the assoicated forward
   *   type snoop with return_nid set to #mapped_node_id.
   *   - Example Use Case: 
   *     - ACE-Lite masters with port_id's {p, q, r} are mapped to CHI RN-I/RN-D agents with node_id's 
   *       {n, x, y} respectively, using the API set_ace_lite_to_rn_i_map of svt_amba_system_configuration class.
   *     - However, the Interconnect DUT maps all the three ACE-Lite masters to a single ACE-Lite to RN-I/RN-D
   *       bridge with Node ID 'n'.
   *     - In such case, the attribute #mapped_node_id for all the three RN-I/RN-D agents must be set to 
   *       'n'.
   *     - In this case, System monitor expects HN to generate a forward type snoop with return_nid set to 'n', 
   *       corresponding to coherent read transactions generated by any of these three ACE-Lite masters.
   *     - <b>NOTE:</b> Please note that, the node_id of one of RN-I/RN-D agents that are mapped to the interconnect's
   *       RN-I/RN-D bridge must be same as RN-I/RN-D bridge node ID. In this example, it is 'n'.
   *       Also note that the node_id settings of all the RN, SN and HN nodes in the CHI System must be unique.
   *     .
   *   .
   * - In case a dynamic translation of mapped_node_id required, it is required to override the implementation of
   *   #translate_mapped_node_id method in testbench.
   * - Default value: 1
   * - Configuration type: Static
   * .
   */
  int mapped_node_id = -1;
  
  /**
   * Specifies if the agents within Node Env are active or passive. 
   * Allowed values are:
   * - 1: Configures agents in active mode. Enables sequencer, driver and
   * monitor in the the agents. 
   * - 0: Configures agents in passive mode. Enables only the monitor in the agents.
   * - Configuration type: Static
   * .
   */
  bit is_active = 1;

  /** Indicates that, if this bit is set to '1' then user needs to externally push
    * RN/SN transactions, Snoop transactions into the passive node protocol monitor.
    * The node protocol monitor will not sample any of the interface signals and
    * will only process the transaction handles that are pushed externally by the users.<br>
    * - This can be set to 1 only for passive agents.
    * - Configuration type: Static
    * - Default value: 0;
    * .
    */ 
  bit use_external_node_prot_monitor = 0;

  /**
   * The CHI node type. This should not be directly set by user <br>
   * Configuration type: Static.
   */
  chi_node_type_enum chi_node_type = RN;
  
  /** @cond PRIVATE */
  /** xml_writer handle of the agent. This should not be directly set by user */
  svt_xml_writer xml_writer = null;
  /** @endcond */
  
  /**
    * Indicates if this node is mapped to an ACE-Lite master port. Must be set
    * only for a node that is not physically connected to CHI interface
    * signals.  This configuration should not be directly set by the user. It
    * is set by the VIP when the user maps ACE-Lite ports to corresponding RN-I
    * ports using svt_amba_system_configuration's API set_ace_lite_to_rn_i_map 
    * 
    */
  bit is_mapped_to_ace_lite_master = 0;
  
`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** @cond PRIVATE */
  /** Custom configuration to enable specific custom SNPQUERY related check
    * Currently, the custom check ensures that SNPQUERY is generated only for
    * exclusive MakeReadUnique when Snoop filter is disabled at the Interconnect. 
    */
  bit enable_custom_snp_query_check = 0;
  /** @endcond */

  /**
    * Indicates whether tags should be returned, if available, along with data for a Read transaction
    * when tag_op in the request is set to Invalid. <br>
    * This configuration is only applicable for active SN VIP and is used to determine the tag to be sent in response to
    * Reads that have TagOp set to Invalid. <br>
    * If this attribute is set to 1 and a Read request with TagOp set to TAG_INVALID is received at the SN:
    * - If Tags are available in the memory, they will be packed in the read data and TagOp in the read data will be set to TAG_TRANSFER.
    * - If Tags are not available in the memory for the given address, TagOp in teh read data will be set to TAG_INVALID.
    * .
    * If this attribute is set to 1 and a Read request with TagOp set to TAG_INVALID is received at the SN, TagOp in the read data will be set to TAG_INVALID. <br>
    * Default value of this attribute is 0. <br>
    * Only applicable when mem_tagging_enable is set to 1. <br>
    */
  bit return_tags_if_available_when_read_req_tag_op_is_invalid = 0; 
`endif


  /**
    * Indicates if this node is mapped to an AXI slave port. Must be set
    * only for a node that is not physically connected to CHI interface
    * signals.  This configuration should not be directly set by the user. It
    * is set by the VIP when the user maps AXI slave ports to corresponding SN
    * ports using svt_amba_system_configuration's API set_axi_slave_to_chi_sn_map
    */
  bit is_mapped_to_axi_slave = 0;
 

  /**
    * Specifies the number of read transactions that can be interleaved
    * This parameter should not be greater than #num_outstanding_xact.
    * When set to 1, interleaving is not allowed.
    * CHI ICN Full-Slave: 
    * Does not interleave transmitted read data beyond this value.
    * Currently, interleaving is not supported for Ordered transactions.  
    * Applicable only for CHI ICN Full-Slave mode. 
    * <b>min val:</b> 1
    * <b>max val:</b> \`SVT_CHI_MAX_RD_INTERLEAVE_DEPTH
    * <b>type:</b> Static
    */
    rand int read_data_interleave_depth = `SVT_CHI_MAX_RD_INTERLEAVE_DEPTH;

   /**
    * Specifies the number of beats of read data that must stay 
    * together before it can be interleaved with read data from a
    * different transaction.
    * When set to 0, interleaving is not allowed.
    * When set to 1, there is no restriction on interleaving.
    * Currently, interleaving is not supported for Ordered transactions. 
 
    * Applicable only for CHI ICN Full-Slave mode. 
    * <b>min val:</b> 0
    * <b>max val:</b> \`SVT_CHI_MAX_READ_DATA_INTERLEAVE_SIZE 
    * <b>type:</b> Static 
    */
    rand int read_data_interleave_size = 0;

`ifdef SVT_VMM_TECHNOLOGY
  /** 
   * The source for the stimulus that is connected to the Protocol layer of the transactor.
   *
   * Configuration type: Static
   */
  generator_type_enum prot_generator_type = SCENARIO_GEN;

  /** 
   * The source for the stimulus that is connected to the Link layer of the transactor.
   *
   * Configuration type: Static
   */
  generator_type_enum link_generator_type = NO_SOURCE;

  /** @cond PRIVATE */
  /**
   * The source type for snoop response generation.
   *
   * Configuration type: Static
   */
  snoop_response_generator_type_enum snoop_response_generator_type = CACHE_SNOOP_RESPONSE_GEN;
  /** @endcond */
  /** 
    * The number of scenarios that the generators should create for each test loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_scenarios = -1;

  /**
    * The number of instances that the generators should create for each test loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_insts = -1;
`endif

  /**  @cond PRIVATE */
  /**
   * Indicates if the transactions on this port must be processed by the CHI
   * system monitor. This configuration is applicable only to the
   * 'system_monitor' of the instance of svt_chi_system_env within which the
   * component corresponding to this port configuration is instantiated.
   * It is not used in the AMBA system monitor instantiated in an instance of
   * svt_amba_system_env (system env used when multiple AMBA protocols are
   * used). 
   */
  bit connect_to_chi_system_monitor = 1;
  /** @endcond */
  
  /**Indicates if the cache must be updated with the protection type 
   * of the transaction that makes an entry in
   * the cache. If the VIP auto-generates a transaction for evicting an entry
   * from cache or for cleaning a cacheline before sending a cache maintenance
   * transaction, the protection type properties recorded in the cache are set
   * for the auto-generated transaction. 
   * <br>
   * This must be set to 1 when enable_secure_nonsecure_address_space is set to 1
   * in case of RN-F.
   */
  bit update_cache_for_prot_type = 0;

  /**
    * Indicates the CHI spec version supported by the node.
    * - When \`SVT_CHI_ISSUE_E_ENABLE compile macro is defined and this attribute is set to ISSUE_E: 
    *   It enables all the supported features of ISSUE_E spec including the features that are applicable from earlier versions of the CHI specifications (A, B, C, D). 
    *   The same applies to all the other macros(listed below) and associated attribute settings for earlier spec revisions.
    * - Can be set to ISSUE_B only when the compile time macro \`SVT_CHI_ISSUE_B_ENABLE is defined.
    * - Can be set to ISSUE_C only when the compile time macro \`SVT_CHI_ISSUE_C_ENABLE is defined.
    * - Can be set to ISSUE_D only when the compile time macro \`SVT_CHI_ISSUE_D_ENABLE is defined.
    * - Can be set to ISSUE_E only when the compile time macro \`SVT_CHI_ISSUE_E_ENABLE is defined. 
    * - Default value: ISSUE_A - as controlled by user re-definable macro \`SVT_CHI_NODE_CFG_DEFAULT_CHI_SPEC_REVISION.
    *   - This macro can be set one of the following: ISSUE_A or ISSUE_B or ISSUE_C or ISSUE_D or ISSUE_E.
    *   .
    * - Configuration type: Static
    * .
    */
  chi_spec_revision_enum chi_spec_revision = `SVT_CHI_NODE_CFG_DEFAULT_CHI_SPEC_REVISION;

  /**
    * Specifies when a DVM Sync request can be sent out by the node.
    * - When set to WAIT_FOR_ALL_NON_SYNC_TO_COMPLETE, indicates that the node will send a DVM Sync request only once all outstanding DVM Non-Sync requests are complete
    * - When set to WAIT_FOR_NON_SYNC_FROM_SAME_LPID_TO_COMPLETE, indicates that the node sends a DVM Sync request only once all outstanding DVM Non-Sync with the same LPID are complete
    * - When set to DO_NOT_WAIT_FOR_NON_SYNC_TO_COMPLETE, indicates that the node sends a DVM Sync request irrespective of whether there are any outstanding DVM Non-Sync transactions.
    * - Configuration type: Static
    * - Default value: WAIT_FOR_ALL_NON_SYNC_TO_COMPLETE.
    * .
    */
  dvm_sync_transmission_policy_enum dvm_sync_transmission_policy = WAIT_FOR_ALL_NON_SYNC_TO_COMPLETE;

  /**
    * Specifies when a node can send SnpResp for a SnpDVMOp(Sync) request.
    * - When set to WAIT_FOR_ALL_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE, indicates that the node will respond to a  SnpDVMOp Sync request only once all outstanding DVM Non-Sync requests are complete
    * - When set to DO_NOT_WAIT_FOR_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE, indicates that the node responds to a SnpDVMOp Sync request irrespective of whether there are any outstanding DVM Non-Sync transactions.
    * - Configuration type: Static
    * - Default value: WAIT_FOR_ALL_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE.
    * .
    */
  snp_dvmop_sync_response_policy_enum snp_dvmop_sync_response_policy = WAIT_FOR_ALL_OUTSTANDING_DVM_NON_SYNC_TO_COMPLETE;

  /**
    * Specifies the version of the DVM operations supported by the node.
    * - DEFAULT_SPEC_VERSION     : The node supports all the DVM operations that are specified in the specification corresponding to the chi_spec_revision.
    *   When chi_spec_revision is ISSUE_A, the node will support all DVM operations that are supported in ARM v8.0.
    *   When chi_spec_revision is ISSUE_B/ISSUE_C/ISSUE_D, the node will support all DVM operations that are supported in ARM v8.1.
    *   When chi_spec_revision is ISSUE_E, the node will support all DVM operations that are supported in ARM v8.4.
    * - DVM_v8_0                 : The node supports DVM operations that are supported in ARM v8.0. 
    * - DVM_v8_1                 : The node supports DVM operations that are supported in ARM v8.1. Can be set only for CHI-B or later nodes
    * - DVM_v8_4                 : The node supports DVM operations that are supported in ARM v8.4. Can be set only for CHI-E or later nodes
    * - Default value is DEFAULT_SPEC_VERSION.
    * .
    */
  dvm_version_support_enum dvm_version_support = DEFAULT_SPEC_VERSION;

  /**
    * Indicates whether an RN is permitted to issue a DVMOp(Sync) request while there is already an outstanding DVMOp(Sync) request from the same RN. <br> 
    * When set to 1, multiple DVMOp(Sync) requests can be outstanding at same time. <br>
    * When set to 0, with #allow_dvm_sync_without_prior_non_sync set to 1 then multiple DVMOp(Sync) transactions will be sent one after another i.e, once the previous DVMOp(Sync) transaction is complete the next DVMOp(Sync) transaction will be sent. <br> 
    * When set to 0, with #allow_dvm_sync_without_prior_non_sync set to 0 there is no effect of this attribute. <br> 
    * Can be set to 1 only when #allow_dvm_sync_without_prior_non_sync is set to 1. <br>
    * Configuration type: Static  <br>
    * Default value: 0 
    * .
    */
  rand bit allow_multiple_dvm_sync_oustanding_xacts = 0;

  /**
   * Enables the end of simulation related port level checkers. <br>
   * Following checks are performed when this configuration is set to 1:
   * - end_of_simulation_outstanding_protocol_credit_check
   * .
   * Default value: 0
   */
  bit end_of_simulation_checks_enable = 0;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
    * Indicates if the node supports Atomic transactions. <br>
    * Can be set to 1 only when the compile macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined and
    * svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * - Configuration type: Static
    * - Default value: 0.
    * .
    */
  bit atomic_transactions_enable = 1'b0;
  /**
    * Indicates if the node supports the setting of Datasource field. <br>
    * Can be set to 1 only when the compile macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined and
    * svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * When set to 1: <br>
    * - Active RN drives data_source values in the SnpRespData(Ptl) flits. <br>
    * - Active SN drives data_source values in the Compdata flits. <br>
    * .
    * When set to 0, active RN and SN drives all zeroes in the data_source field. <br>
    * - Configuration type: Static
    * - Default value: 0.
    * .
    */
  bit data_source_enable = 1'b0;
 
  /**
    * Indicates if the node supports the setting of Poison field. <br>
    * Can be set to 1 only when the compile macros SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE, and SVT_CHI_POISON_WIDTH_ENABLE are defined and
    * svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * When set to 1, active RN and SN drive random poison values in the Data flits if
    * svt_chi_system_configuration::poison_supported_by_interconnect is set to 0. <br>
    * When set to 0 or when svt_chi_system_configuration::poison_supported_by_interconnect is 1,
    * active RN and SN drives all zeroes in the Poison field. <br>
    * When ICN does not support poison, the VIP RN and SN components expect poison 
    * to be driven as all zeroes on the interface, in case poison width is non-zero.
    * - Configuration type: Static
    * - Default value: 0.
    * .
    */
  bit poison_enable = 1'b0;

  /** 
   * Indicates Datacheck feature is supported by the node.<br>
   * Can be set to ODD_PARITY only when the compile macros SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE, and SVT_CHI_DATACHECK_WIDTH_ENABLE are defined and
   * svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
   * When ICN does not support poison, the VIP RN and SN components do not check the 
   * recevied datacheck field for ODD Byte parity, in case DataCheck width is non-zero.
   * - when set to NOT_SUPPORTED : 
   *   - VIP RN and SN ignore the datacheck field received and do not check for ODD Byte Parity.
   *   .
   * - when set to ODD_PARITY    : 
   *   - VIP RN and SN check the datacheck field received for ODD Byte parity 
   *     and flag an error if DataCheck is not set correctly.
   *   .
   * - This is applicable for CHI RN and SN components.
   * - <b> Configuration Type: Static </b>
   * - Default value is NOT_SUPPORTED
   * .
   */
  datacheck_type_enum datacheck_type = NOT_SUPPORTED;
 
  /** 
   * Indicates if Datacheck must be computed on the all of the data bytes that are transmitted or only the valid data bytes in the transaction.<br>
   * This attribute is applicable only when svt_chi_node_configuration::datacheck_type is set to ODD_PARITY.
   * - When set to COMPUTE_DATACHECK_ON_VALID_DATA:
   *   - For an active node, DataCheck is computed at the protocol layer, only for the valid data window (determined by the addr and data_size). DataCheck is treated as Don't Care for the invalid byte lanes.
   *   - For a passive node, DataCheck is computed for only the valid data byte lanes and compared against the actual DataCheck received for the corresponding byte lanes.
   *   .
   * - When set to COMPUTE_DATACHECK_ON_ENTIRE_DATA:
   *   - For an active node, DataCheck is computed at the link layer, on the entire data that is to be transmitted in the Data flits.
   *   - For a passive node, DataCheck is computed for the entire data that is received in the data flits and compared against the actual DataCheck value seen in the flits.
   *   .
   * - <b> Configuration Type: Static </b>
   * - Default value is COMPUTE_DATACHECK_ON_ENTIRE_DATA
   * .
   */
  datacheck_computation_logic_enum datacheck_computation_logic = COMPUTE_DATACHECK_ON_ENTIRE_DATA;

  /** 
   * Indicates cache stashing feature is supported by the node.<br>
    * Can be set to 1 only when the compile macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined and
    * svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later. <br>
    * - Configuration type: Static
    * - Default value: 0.
    * .
   */
  bit cache_stashing_enable = 1'b0;
  
  /**
    * This configuration allows to generate DMT ReadNoSnp transaction from RN to SN where HN is absent. <br>
    * When set to 1:
    * - The VIP RN will behave like an HN and allow users to program the ReturnNID and ReturnTxnID values in the Read requests that are sent to the SN. 
    * - The RN will also be able to process and associate the subsequent CompData and Readreceipt flits sent by the SN, as they are, without the need to tie off any signals at the interface.
    * .
    * When set to 0:
    * - The VIP RN will behave like a standard spec defined Requester and will always set ReturnNID and ReturnTxnID to 0. 
    * - Also, it will expect HomeNID of the read data flits to match with the TgtID of the read request. 
    * - Users are expected to tie off these signals at the Request and RX DATA interfaces suitably to ensure that there are no issues in the processing of the read request or the CompData flits from/at the RN.
    * .
    * This configuration can be to set to 1 only in the RN-SN back to back setup when chi_spec_revision is set to ISSUE_B or greater i,e  
    * - svt_chi_system_configuration::num_rn is set to 1
    * - svt_chi_system_configuration::num_sn is set to 1
    * - svt_chi_system_configuration::num_hn is set to 0
    * - compile macro SVT_CHI_ISSUE_B_ENABLE or later is defined and 
    * - svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later.
    * .
    * Default value: 0
    */
   bit allow_dmt_from_rn_when_hn_is_absent = 0;

`endif

`ifdef SVT_CHI_ISSUE_C_ENABLE
  /**
    * This configuration allows generation of ReadNoSnpSep transaction from RN to SN where HN is absent. <br>
    * This configuration can be to set to 1 only in the RN-SN back to back setup when:
    * - chi_spec_revision is set to ISSUE_C or greater and
    * - svt_chi_system_configuration::num_rn is set to 1
    * - svt_chi_system_configuration::num_sn is set to 1
    * - svt_chi_system_configuration::num_hn is set to 0
    * - allow_dmt_from_rn_when_hn_is_absent is set to 1.
    * . 
    * Default value: 0
    */
   bit allow_readnosnpsep_from_rn_when_hn_is_absent = 0;

`endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
A4mshRLC2Cf9VAmx56Qc+3G2+00T1IkjWhoEQcL598x8vjBsV46wx2hPDsofn0O/
bhFAUaLMUkwYTJEPGkYUVjyeS0+/1H9fR1eLzJitwfJEBS0A6kj7TUnPf4XWQpJX
HDupAadjaWjYdltKQVLW1taAdgzvRvvH6c62MHz7fKs45mYVgCanVw==
//pragma protect end_key_block
//pragma protect digest_block
GmHa5IOriym5Y6ZQlpdqV0l15WY=
//pragma protect end_digest_block
//pragma protect data_block
9RxfMgyeBsNyPaNl9PXtj6XyUlJgUpB+Rd4h7WahvbRUti+IHFM5KR7yqr3NKct0
P4iTseOIpdtBU+YkuAR+s+vEkCbnc+IFRU+9V4IXCnIYlVbyH1qk2aUlfiF18Bkf
QCI0mh1yl0q7YAYUz6RMVu5051ZpE7+e9jiODCJJ32c3MMRBwRbc/lSjME7Wd8im
3XBNHVazFCv+OEIMV/clmR7epy3os+LwmXYIV95ljKTN3przsqnPZPD/lm/h8sxn
6+uKBesjuxgm8ssQ7IIvy1BxjfkJYmFhdSuj227AQYAMEBSPz6WNRncpPbFIvIW7
e4FC6y6zREgb0I1r0fM4DCYLBPHCY+LWHAzKcxCT5WqdJEYzrAWrsifbaivg85dE
MJpZrwtc3xbI+OpKF6owo593ABf+nzJvWam8gdETiJWl4Z+Kz1aE4+xZ6XPGkYDu
4wvi6JkbvNlYdORn+8MikD1urdnrQu2nvhbFsZeE5EtNIK7EW9uhbvOGYQo8cCH2
nre3Mme1lg45GJlRs3+T+d1AuckXsmV+m7IHZgM4Hdz2cNC1tNaYeoNMU67F/mLc
UyyUa+mhgAxYA515adWDVReOkPf402oBcbeHZPLy4TmoT1V/Mjs1lGfJ6NM3Ggha
cc+UlpuuLgizNE0cZgWVWNFeMO5ENSOdw9DwVoT+Pakeh4itJCXw5R2uVenHBMol
1Yr0yalbLaM7Z65zU78tDkmEwTIqg4AhTXQ7Y2ipXPFYGC6NE6BkEiKofu1XDwCD
zkyZhwEZ2F4IFjmVD+OuKWM62pUzj8vCiq0uaCRnVoKZs1m0sHz6dOWZBo3jUdzZ
9VUzxsUOmZlgF/WRBi5jbQr0Yo3pOY0ipUGJ+1sB7MfXIRiI14qnOkJd5cfqHicW
FW5b2mCBMHvsa0td9pQ83oLEjUPzM2tUO5Xsp9v/Rdg0zrzB5ZAOXZjfv6kadd3x
oOYumArNurqOfKzqIwnScLD1JjCbtHTjoPllXoWhjBjALTEQxLtRfwMkeOP3ZHsY
wL3x7UDphseoP+Si8N8CrY3wxjqDleWiuVg3CSvedGF9CQ4fXPBek1SCOv4Oed2d
suNlukn1LJMbHNaVX4ZNS5gaR1YqUSzcHkjQk5PavXqeOzJwlsZtQm4l31i2QQi7
MQXuCj4SR/H7q7OTorVviyMlZK7D3dTVS/b/8lofaxU8vMtXBu1cvQwe8rwLciNr
dxeJPKjmYHOx0jK8xt6qDv90pElDDf4sW7akZ35+RxgWa/3ghTE8SFOLk3P8GVrk
baJSCZnxhORHg4UyM6SJrSxIV1zRz3yCgAkNIZjMo8fJtR/VKslXY0qh9lAH12go

//pragma protect end_data_block
//pragma protect digest_block
0z7nmwGJSejrhHozvO6KUKECmrU=
//pragma protect end_digest_block
//pragma protect end_protected

  /**
   * Applicable only for RN.
   * - When set to 1:
   *   - This can be set to 1 only when svt_chi_system_configuration::num_rn = 1 AND 
   *     svt_chi_system_configuration::num_sn = 1 AND svt_chi_system_configuration::num_hn = 0
   *     together.
   *   - Active RN: rand_mode is turned on for svt_chi_rn_transaction::src_id
   *     in svt_chi_rn_transaction::pre_randomize() method.
   *   - Passive RN: Expects svt_chi_rn_transaction::src_id can take any value
   *   .
   * - When set to 0:
   *   - svt_chi_rn_transaction::src_id is expected to have fixed value of RN's
   *     node ID, set through svt_chi_node_configuration::node_id. The rand_mode
   *     of svt_chi_rn_transaction::src_id is turned off.
   *   .
   * - </b> Default value </b>: 0
   * - </b> Type </b>: Static
   * .
   */
  rand bit random_src_id_enable = 0;

  /**
   * Applicable only for RN.
   * - When set to 1:
   *   - Can be set to 1 only when target ID remapping is expected at Interconnect through
   *     svt_chi_system_configuration::expect_target_id_remapping_by_interconnect 
   *     set to 1.
   *   - Active RN: rand_mode is turned on for svt_chi_rn_transaction::tgt_id
   *     in svt_chi_rn_transaction::pre_randomize() method.
   *   - Passive RN: Expects svt_chi_rn_transaction::tgt_id can take any value
   *   .
   * - When set to 0:
   *   - svt_chi_rn_transaction::tgt_id is expected to have valid value 
   *     based on system address map and rand_mode of svt_chi_rn_transaction::tgt_id
   *     is turned off.
   *   .
   * - </b> Default value </b>: 0
   * - </b> Type </b>: Static
   * .
   */
  rand bit random_tgt_id_enable = 0;
  
  /**
    * Indicates if an auto read sequence is to be registered for this node for
    * the shutdown phase. The auto read sequence reads back all locations that
    * have been written from this node using a WRITENOSNPFULL, WRITENOSNPPTL,
    * WRITEUNIQUEFULL, WRITEUNIQUEPTL or copyback transaction. This is useful
    * to verify that the writes made by the interconnect into the L3 or main
    * memory are done correctly.  Since there is no visibility into the
    * contents of the L3 cache of an interconnect, the best way to verify that
    * data is stored correctly in the L3, is to read back all the locations
    * that were stored. This is done in an automated way by enabling this
    * parameter.  
    * Currently supported only in UVM.
    */
  bit auto_read_seq_enable = 0;

  /**
   * In active mode, creates a tlm_generic_payload_sequencer sequencer capable
   * of generating UVM TLM Generic Payload transactions and connects the
   * RN protocol sequencer to it.  The RN protocol sequencer starts a s
   * equence that gets transactions from the tlm_generic_payload_sequencer, converts 
   * them to CHI transaction(s) and sends them to the RN protocol driver. 
   * All other sequences running on the RN protocol sequencer are stopped.  
   * All user sequences should be run on tlm_generic_payload_sequencer. 
   * CHI transactions initiated by the RN protocol driver are made available
   *  as TLM GP transactions through the tlm_generic_payload_observed_port in the 
   * RN protocol monitor. Note that the TLM GP transactions issued through 
   * this port may not match 1 to 1 with the GP items created by the 
   * tlm_generic_payload_sequencer. This is because the TLM GP created by the 
   * tlm_generic_payload_sequencer may have to be split into multiple CHI transactions
   *  according to protocol requirements. The TLM GP that is available through the 
   * tlm_generic_payload_observed_port of the protocol monitor is only this
   *  CHI transaction converted to a TLM GP. 
   * 
   * In passive mode, received CHI transactions are made available as TLM GP
   * transactions through the tlm_generic_payload_observed_port in the RN protocol
   * layer monitor. 
   * 
   * When set to 1, svt_chi_node_configuration::wysiwyg_enable also should be
   * set to 1.
   */
  bit use_tlm_generic_payload = 0;

  /** 
    * In active mode, creates an AMBA-PV-compatible socket that can be used to
    * connect a CHI RN VIP component to an AMBA-PV master model. 
    * 
    * Enabling this functionality causes the instantiation of socket b_fwd of
    * type uvm_tlm_b_target_socket, and socket b_snoop of type
    * uvm_tlm_b_initiator_socket, in class svt_chi_rn_agent.
    *
    * Generic payload transactions received through the forward b_fwd interface
    * are executed on the tlm_generic_payload_sequencer in the agent.
    *
    * When this option is set, the svt_chi_ace_snoop_request_to_tlm_gp_sequence
    * reactive sequence is started on the CHI RN VIP master snoop sequencer. Snoop
    * transaction requests received by the CHI RN VIP master snoop sequencer are translated to
    * equivalent tlm_generic_payload transactions with the
    * #svt_amba_pv_extension attached. The extended Generic Payload transactions
    * are then sent to the AMBA-PV master model via the backward b_snoop interface.
    * The receive response from AMBA-PV master model is then interpreted to
    * complete the snoop transaction request and executed on the CHI RN VIP master snoop
    * sequencer.
    * 
    * Should the CHI RN VIP master need to fulfill the snoop requests natively (i.e. the
    * default behavior when this option is not set), the snoop response sequence
    * should be restored to the default using:
    * 
    * <code>
    * uvm_config_db#(uvm_object_wrapper)::set(this, "master[0].snoop_sequencer.run_phase", "default_sequence",
    *                                         /#svt_chi_ace_master_snoop_response_sequence::type_id::/#get());
    * </code>
    * 
    * When this option is set, it implies that #use_tlm_generic_payload is also set, whether
    * it actually is or not.
    * When set to 1, svt_chi_node_configuration::wysiwyg_enable also should be set
    * to 1.
    */
  bit use_pv_socket = 0;

  /**
   * Enables protocol checking at protocol layer. In a disabled state, no protocol
   * violation messages (error or warning) are issued. <br>
   * <b>type:</b> Dynamic 
   * 
   */
  bit pl_protocol_checks_enable = 1;

  /**
   * Enables protocol checks coverage at protocol layer. This is applicable
   * only when #pl_protocol_checks_enable is set to 1. <br>
   * <b>type:</b> Dynamic 
   */
  bit pl_protocol_checks_coverage_enable = `CHI_ENABLE_PROTOCOL_CHECK_COV;
  
  /**
   * Enables protocol checking at link layer. In a disabled state, no protocol
   * violation messages (error or warning) are issued. <br>
   * <b>type:</b> Dynamic 
   * 
   */
  bit ll_protocol_checks_enable = 1;

  /**
   * Enables protocol checks coverage at link layer. This is applicable
   * only when #ll_protocol_checks_enable is set to 1. <br>
   * <b>type:</b> Dynamic 
   */
  bit ll_protocol_checks_coverage_enable = `CHI_ENABLE_PROTOCOL_CHECK_COV;
  
  /**
   * Enables toggle coverage.
   * Toggle Coverage gives us information on whether a bit
   * toggled from 0 to 1 and back from 1 to 0. This does not
   * indicate that every value of a multi-bit vector was seen, but
   * measures if individual bits of a multi-bit vector toggled.
   * This coverage gives information on whether a system is connected
   * properly or not. <br>
   * <b>type:</b> Dynamic 
   * 
   */
  bit toggle_coverage_enable = 0;


/**
   * Enables advanced transaction level coverage at protocol layer. This can be
   * set to 1 only when transaction_coverage_enable is set to 1.
   * <b>type:</b> Dynamic 
   * 
   */
  bit advanced_transaction_coverage_enable = 0;

  /**
   * Enables transaction level scenario coverage at protocol layer. This can be
   * set to 1 only when #transaction_coverage_enable is set to 1.
   * Currently supported only for active RN agent.
   * <b>type:</b> Dynamic 
   * 
   */
  bit transaction_scenario_coverage_enable = 0;

  /**
   * Enables state coverage of signals.
   * State Coverage covers all possible states of a signal. <br>
   * <b>type:</b> Dynamic 
   * 
   */
  bit state_coverage_enable = 0;

  /** @cond PRIVATE */
  /**
   * Enables meta coverage of signals.
   * This covers second-order coverage data such as delays among the signals. <br>
   * This parameter is not supported currently. The meta coverage is enabled
   * using node configuration parameters #transaction_coverage_enable, #flit_coverage_enable.
   * <b>type:</b> Dynamic 
   * <br> This is currently not supported.
   */
  bit meta_coverage_enable = 0;
  /** @endcond */
  
  /**
   * Enables transaction level coverage at protocol layer. This parameter also enables delay
   * coverage. Delay coverage is coverage on various delays between different message types.
   * <b>type:</b> Dynamic 
   * 
   */
  bit transaction_coverage_enable = 0;
  
  /**
   * Enables link layer coverage.
   * <b>type:</b> Dynamic 
   * 
   */
  bit link_coverage_enable = 0;

  /** @cond PRIVATE */
  /**
   * Enables Flit coverage at link layer. This parameter also enables delay
   * coverage. Delay coverage is coverage on various delays between different signals, flit types.
   * <b>type:</b> Dynamic 
   * <br> This is currently not supported.
   * 
   */
  bit flit_coverage_enable = 0;

  /**
   * Enables link layer's link acive state machine coverage.
   * <b>type:</b> Dynamic 
   * <br> This is currently not supported.
   */
  bit link_active_sm_coverage_enable = 0;
  /** @endcond */
  
  /**
   * - Determines if XML/FSDB generation for transactions (for display in PA) is desired.
   *  - The format of the file generated will be based on svt_chi_system_configuration::pa_format_type
   *  - If pa_format_type is set to FSDB and enable_xact_xml_gen is set to 1, the Verdi PA transactions are linked to the respective node interface signals 
   *  .
   * - When set to 1 the following callbacks are registered:
   *  - with node protocol monitor of RN and SN: svt_chi_node_protocol_monitor_transaction_xml_callback
   *  - with SN link monitor: svt_chi_sn_link_monitor_transaction_xml_callback
   *  - with RN link monitor: svt_chi_rn_link_monitor_transaction_xml_callback
   *  .
   * - <b>type:</b> Static
   * .
   * 
   */
  bit enable_xact_xml_gen = 0;

  /**
   * - Determines if XML/FSDB generation for link activation state machines (for display in PA) is desired.
   *  - The format of the file generated will be based on svt_chi_system_configuration::pa_format_type
   *  - If pa_format_type is set to FSDB and enable_fsm_xml_gen is set to 1, the link activation/deactivation FSM in Verdi PA is linked to the respective node interface signals 
   *  .
   * - When set to 1 the following callbacks are registered
   *  - with SN link monitor: svt_chi_sn_link_monitor_transaction_xml_callback
   *  - with RN link monitor: svt_chi_rn_link_monitor_transaction_xml_callback
   *  .
   * - <b>type:</b> Static 
   * .
   * 
   */
  bit enable_fsm_xml_gen = 0;

  /**
    * Enables debug port.
    * The VIP drives the object number of the transaction corresponding to a
    * flit on the debug ports
    */
  bit debug_port_enable = 0;


  /**
   * - Controls interactive writing of transactions trace from protocol layer  
   *   to seperate file(s) when the transactions are complete
   * - The protocol layer transactions include Snoop transactions. 
   * - When set to 1: Enable transaction reporting.
   *   - The tracing information of protocol layer transactions except snoops
   *     are routed to a file <chi_node_instance_hierarchy>.transaction_trace
   *   - The tracing information of protocol layer snoop transactions 
   *     are routed to a file <chi_node_protocol_monitor_instance_hierarchy>.snoop_transaction_trace
   *   .
   * - When #svt_chi_node_configuration::enable_pl_reporting is set to 1,
   *   the associated flits and any Retry of the transaction info also will be 
   *   captured in the trace files
   * - When set to 0: Disable transaction reporting. 
   * - <b>Type</b>:Static
   * - <b>Default value</b>:0
   * - Currently supported only for RN agent/RN group
   * .
   * 
   * @verification_attr 
   */
  bit enable_pl_tracing = 1'b0;

  /**
   * - Controls interactive display of transactions from protocol layer  
   *   when they are complete, with the the simulation run with UVM_FULL/VMM_VERBOSE 
   *   verbosity setting.
   * - The protocol layer transactions include Snoop transactions.
   * - When set to 1: Enable transaction reporting.
   * - When set to 0: Disable transaction reporting. 
   * - <b>Type</b>:Static
   * - <b>Default value</b>:0
   * - Currently supported only for RN agent/RN group
   * .
   * 
   * @verification_attr 
   */
  bit enable_pl_reporting = 1'b0;

  /**
   * Determines if the transaction trace file generation is enabled for the transaction for link layer.
   * 
   * - 1'b1 : Enable trace file generation. 
   * - 1'b0 : Disable trace file generation.
   * .
   * 
   * @verification_attr 
   */
  bit enable_ll_tracing = 1'b0;

  /**
   * Determines if the transaction reporting is enabled for the transaction for link layer.
   * 
   * - 1'b1 : Enable transaction reporting.
   * - 1'b0 : Disable transaction reporting. 
   * .
   * 
   * @verification_attr 
   */
  bit enable_ll_reporting = 1'b0;

  /**
   * @groupname chi_config_secure_access
   * - Indicates whether the node (RN, SN) supports handling seperate secure and non-secure address speaces for cache, memory and coherency.
   * - When set to 1: separate secure & non-secure address space is enabled. The node will accept both secure
   *   and non-secure transactions targeted for the same address and handles them as seperate addresses. 
   *   However, while updating memory, cache it will use tagged address i.e. 
   *   address attribute with secure and non -secure information. This is acheived by appending security bit as MSB in position to the original address.
   *   - The attribute #update_cache_for_prot_type also must be set to 1 along with this attribute in case of RN-F.
   *   .
   * - When set to 0: Node ignores the non-secure(NS) bit of the reqests.
   * - Note: Interconnect VIP doesn't support this. So, this object type corresponding to rn_connected_node_cfg and sn_connected_node_cfg within
   *   ic_cfg supports only value of 0.
   * - Use model details to enable this as 1:
   *   - Define macro \`SVT_CHI_TAGGED_ADDR_SPACE_ENABLE 
   *   - This makes the VIP to internally define the following macros:
   *     - \`SVT_CHI_TAG_ADDR_WIDTH to 1
   *     - \`SVT_CHI_MAX_TAGGED_ADDR_WIDTH to a value  (\`SVT_CHI_MAX_ADDR_WIDTH + \`SVT_CHI_TAG_ADDR_WIDTH)
   *     - Note that above two marcros are not usr re-definable and these are defined within the VIP.
   *     .
   *   - Define macro \`SVT_CHI_MAX_ADDR_WDITH as per the system address width
   *   .
   * - Configuration type: Static
   * - Default value: 0
   * .
   */
   bit enable_secure_nonsecure_address_space = 0;
  

//Update once these methods are added to the system config
  /**
   * Enables address generation based on the values configured
   * in {nonsnoopable_start_addr,nonsnoopable_end_addr},
   * {innersnoopable_start_addr,innersnoopable_start_addr} and
   * {outersnoopable_start_addr,outersnoopable_end_addr} which are set
   * through svt_chi_system_configuration::create_new_domain() and
   * svt_chi_system_configuration::set_addr_for_domain().
   * This establishes a relationship between the addresses (svt_chi_common_transaction::addr)
   * , snoopable(svt_chi_base_transaction::snp_attr_is_snoopable) and snoop domain
   *  types(svt_chi_base_transaction::snp_attr_snp_domain_type) generated in a transaction.
   * <b>type:</b> Static 
   * 
   */
  bit enable_domain_based_addr_gen = 0;

  /**
   * An array of start addresses corresponding to the nonsnoopable
   * region of memory. Each member pairs with a corresponding
   * member of nonsnoopable_end_addr to form an address range applicable
   * to a nonsnoopable region. 
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_axi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] nonsnoopable_start_addr[];

  /**
   * An array of end addresses corresponding to the nonsnoopable
   * region of memory. Each member pairs with a corresponding
   * member of nonsnoopable_start_addr to form an address range applicable
   * to a nonsnoopable region.
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_chi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] nonsnoopable_end_addr[];

  /**
   * An array of start addresses corresponding to the innersnoopable
   * region of memory. Each member pairs with a corresponding
   * member of innersnoopable_end_addr to form an address range applicable
   * to a innersnoopable region.This same array is used for CHI ISSUE-B
   * when svt_chi_system_domain_item::SNOOPABLE is used.
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_chi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] innersnoopable_start_addr[];

  /**
   * An array of end addresses corresponding to the innersnoopable
   * region of memory. Each member pairs with a corresponding
   * member of innersnoopable_start_addr to form an address range applicable
   * to a innersnoopable region.This same array is used for CHI ISSUE-B
   * when svt_chi_system_domain_item::SNOOPABLE is used.
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_chi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] innersnoopable_end_addr[];

  /**
   * An array of start addresses corresponding to the outersnoopable
   * region of memory. Each member pairs with a corresponding
   * member of outersnoopable_end_addr to form an address range applicable
   * to a outersnoopable region. 
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_chi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] outersnoopable_start_addr[];

  /**
   * An array of end addresses corresponding to the outersnoopable
   * region of memory. Each member pairs with a corresponding
   * member of outersnoopable_start_addr to form an address range applicable
   * to a outersnoopable region.
   * This variable is not to be set directly by the user. It is set
   * internally by the model, when domain information is set using
   * svt_chi_system_configuration::set_addr_for_domain()
   * Applicable when interface_type is svt_chi_node_configuration::RN_F
   * or svt_chi_node_configuration::RN_I
   * <b>type:</b> Static 
   * 
   */
  bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] outersnoopable_end_addr[];


  /**
    * @groupname chi_performance_analysis 
    * The interval based on which performance parameters are monitored and
    * reported. The simulation time is divided into time intervals spcified by this
    * parameter and performance parameters are monitored and reported based on
    * these. Typically, this interval affects measurement of performance
    * parameters that require aggregation of values across several transactions
    * such as the average latency for a transaction to complete. The unit for
    * this parameter is the same as the simulation time unit.
    * When set to 0, the total simulation time is not divided into time intervals.
    * For example, consider that this parameter is set to 1000 and that the
    * simulation time unit is 1ns. Then, all performance metrics that require
    * aggregation will be measured separately for each 1000 ns. Also min and max
    * performance parameters will be reported separately for each time interval.
    * If this parameter is changed dynamically, the new value will take effect
    * only after the current time interval elapses.
    * <br>
    * When set to -1, svt_chi_node_perf_status::start_performance_monitoring() and
    * svt_chi_node_perf_status::stop_performance_monitoring() needs to be used to
    * indicate the start and stop intervals for the performance monitoring. If the
    * start and stop events are not indicated, the performance monitoring will not 
    * take place. If the stop event is not indicated after issuing a start event 
    * indication, the Node protocol monitor stops the monitoring in the extract phase.
    * Note that any constraint checks will be performed only during the monitoring period.
    * <b>type:</b> Dynamic
    */
  real perf_recording_interval = 0;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum allowed duration for a write
    * transaction to complete. The duration is measured as the time when the
    * the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_max_write_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_max_write_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum duration for a write transaction to
    * complete. The duration is measured as the time when the the transaction
    * is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_min_write_xact_latency_check
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_min_write_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum expected average duration for a write
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is more than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_avg_min_write_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_avg_min_write_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum allowed duration for a read
    * transaction to complete. The duration is measured as the time when the the
    * transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_avg_max_write_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_avg_max_write_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum expected average duration for a write
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is less than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_max_read_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_max_read_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum duration for a read transaction to
    * complete. The duration is measured as the time when the the transaction is
    * started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_min_read_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_min_read_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum expected average duration for a read
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is more than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_avg_max_read_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_avg_max_read_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum expected average duration for a read
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is less than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_avg_min_read_xact_latency_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_avg_min_read_xact_latency = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum allowed throughput for read
    * transfers in a given time interval. The throughput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_max_read_throughput_check
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_max_read_throughput = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum expected throughput for read
    * transfers in a given time interval. The throughput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Read type transactions include:
    * - ReadNoSnp
    * - ReadOnce
    * - ReadShared
    * - ReadClean
    * - ReadUnique
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_min_read_throughput_check
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_min_read_throughput = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the maximum allowed throughput for write
    * transfers in a given time interval. The throughput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_max_write_throughput_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_max_write_throughput = -1;

  /**
    * @groupname chi_performance_analysis 
    * Performance constraint on the minimum expected throughput for write
    * transfers in a given time interval. The throughput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done. <br>
    * The Write type transactions include:
    * - WriteNoSnpFull, WriteNoSnpPtl
    * - WriteUnqueFull, WriteUniquePtl
    * - WriteBackFull, WriteBackPtl
    * - WriteCleanFull, WriteCleanPtl
    * - WriteEvictFull
    * .
    * <b>type:</b> Dynamic 
    * <br>
    * <b>check related to this constraint</b>: svt_chi_protocol_err_check::perf_min_write_throughput_check 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    */
  real perf_min_write_throughput = -1;

  /**
    * @groupname chi_performance_analysis
    * Indicates if periods of transaction inactivity (ie, periods when no
    * transaction is active) must be excluded from the calculation of
    * throughput.  The throughput is measured as (number of bytes transferred
    * in an interval)/(duration of interval). If this bit is set, inactive
    * periods will be deducted from the duration of the interval
    * <br>
    * When #perf_recording_interval is set to -1, this attribute is applicable
    * only while the performance monitoring is active.
    */
  bit perf_exclude_inactive_periods_for_throughput = 0;
  
  /**
    * @groupname chi_performance_analysis
    * Indicates how the transaction inactivity (ie, periods when no
    * transaction is active) must be estimated for the calculation of
    * throughput.  
    * Applicable only when svt_chi_node_configuration::
    * perf_exclude_inactive_periods_for_throughput is set to 1. 
    * EXCLUDE_ALL: Excludes all the inactivity. This is the default value. 
    * EXCLUDE_BEGIN_END: Excludes the inactivity only from time 0 to start of first 
    * transaction, and from end of last transaction to end of simulation. 
    * <br>
    * When #perf_recording_interval is set to -1, check related to this constraint is
    * performed only while the performance monitoring is active.
    * <br>
    * When #perf_recording_interval is set to -1, this attribute is applicable
    * only while the performance monitoring is active.
    */
  perf_inactivity_algorithm_type_enum perf_inactivity_algorithm_type = EXCLUDE_ALL;

  /** 
   * @groupname chi_config_link_layer
   * Enables the checking for the unintentional toggling of FLIT signals without FLITV assertion
   * for all the Tx and Rx Virtual Channels of the CHI node that uses this 
   * configuration object. <br>
   */
  bit flit_stable_during_flitv_deassertion_check_enable = 1'b0;

  /** @cond PRIVATE */
 
  /**
   * Enables system monitor to differentiate downstream RN-F from other RN's in the L1-ICN
   * Will be set to 1 for passsive RN-F agent hooked up to the outbound RN-F interface of L1-ICN
   * <b>Default value:</b> 0
   * <b>type:</b> Static
   */
  bit is_downstream_rn = 1'b0;  
  
  /** @endcond */

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * The CHI interface type. <br>
   * Configuration type: Static.
   */
  rand chi_interface_type_enum chi_interface_type = RN_F;

  /**
   * Indicates the width of valid bits in the Data field within Dat VC Flit. <br>
   * - This field can take one of the following values: {128, 256, 512}.
   * - The width of the Data field in the Data channels is always fixed to `SVT_CHI_DAT_FLIT_MAX_DATA_WIDTH.
   * - The width of the Byte Enable field in the Data channels is always fixed to (`SVT_CHI_DAT_FLIT_MAX_DATA_WIDTH/8).
   * - If flit_data_width is less than `SVT_CHI_DAT_FLIT_MAX_DATA_WIDTH, 
   *   only the bits specified by flit_data_width are valid and the remaining (MSB) ones must be ignored or tied off in the interface connections.
   * .
   * Configuration type: Static.
   */
  rand int flit_data_width = `SVT_CHI_DAT_FLIT_MAX_DATA_WIDTH;

  /**
   * Indicates the width of the valid bits in the Address field within request and snoop VC Flit. <br>
   * - For a CHI-B node, this can take any value between 44 and `SVT_CHI_MAX_ADDR_WIDTH
   * - For a CHI-A node, this parameter (as well as `SVT_CHI_MAX_ADDR_WIDTH) are expected to be fixed to 44.
   * - The width of the address field in the request/snoop channel is always fixed to `SVT_CHI_MAX_ADDR_WIDTH/(`SVT_CHI_MAX_ADDR_WIDTH-3).
   * - If addr_width is less than `SVT_CHI_MAX_ADDR_WIDTH, 
   *   only the bits specified by addr_width are valid and the remaining (MSB) ones must be ignored or tied off in the interface connections.
   * .
   * Configuration type: Static.
   */
  rand int addr_width = `SVT_CHI_MAX_ADDR_WIDTH;

  /**
   * Inidcates the width of the valid bits in the Node ID fields within VC Flits. <br>
   * - For a CHI-B node, this can take any value between 7 and `SVT_CHI_MAX_NODE_ID_WIDTH
   * - For a CHI-A node, this parameter (as well as `SVT_CHI_MAX_NODE_ID_WIDTH) are expected to be fixed to 7.
   * - The width of the Node ID related fields in the flit interfaces is always fixed to `SVT_CHI_MAX_NODE_ID_WIDTH.
   * - If node_id_width is less than `SVT_CHI_MAX_NODE_ID_WIDTH, 
   *   only the bits specified by node_id_width are valid and the remaining (MSB) ones must be ignored or tied off in the interface connections.
   * .
   * Configuration type: Static.
   */
  rand int node_id_width = `SVT_CHI_MAX_NODE_ID_WIDTH;

  /**
   * The width of rsvdc field within Req VC Flit. <br>
   * When svt_chi_system_configuration::chi_version is set to: 
   * - svt_chi_system_configuration::VERSION_5_0, this field can take
   *   one of the following values: {0, 4, 8, 12, 16, 24, 32}.
   * - svt_chi_system_configuration::VERSION_3_0, this field can take
   *   only a value of 4.
   * - The width of the RSVDC field in the request channel is always fixed to `SVT_CHI_REQ_FLIT_MAX_RSVDC_WIDTH.
   * - If req_flit_rsvdc_width is less than `SVT_CHI_REQ_FLIT_MAX_RSVDC_WIDTH, 
   *   only the bits specified by req_flit_rsvdc_width are valid and the remaining (MSB) ones must be ignored or tied off in the interface connections.
   * .
   * Configuration type: Static
   */
  rand int req_flit_rsvdc_width = `SVT_CHI_REQ_FLIT_MAX_RSVDC_WIDTH;

  /**
   * Indicates the width of valid bits in the rsvdc field within Dat VC Flit. <br>
   * When svt_chi_system_configuration::chi_version is set to: 
   * - svt_chi_system_configuration::VERSION_5_0, this field can take
   *   one of the following values: {0, 4, 8, 12, 16, 24, 32}.
   * - svt_chi_system_configuration::VERSION_3_0, this field can take
   *   only a value of 4.
   * - The width of the RSVDC field in the data channels is always fixed to `SVT_CHI_DAT_FLIT_MAX_RSVDC_WIDTH.
   * - If dat_flit_rsvdc_width is less than `SVT_CHI_DAT_FLIT_MAX_RSVDC_WIDTH, 
   *   only the bits specified by dat_flit_rsvdc_width are valid and the remaining (MSB) ones must be ignored or tied off in the interface connections.
   * . 
   * Configuration type: Static
   */
  rand int dat_flit_rsvdc_width = `SVT_CHI_DAT_FLIT_MAX_RSVDC_WIDTH;  
  /**
   * Number of cache lines in the RN-F. <br>
   * Configuration type: Static.
   */
  rand int num_cache_lines = `SVT_CHI_MAX_NUM_CACHE_LINES;

  /**
   * Passive SN memory needs to be aware of the backdoor writes to memory.
   * Setting this configuration allows passive SN memory to be updated according to
   * Read data seen in the transaction coming from the SN. Note that the passive SN 
   * memory is updated when all read data Flits have been transmitted and accepted.
   * For a normal transaction, memory is updated only if the transaction is completed
   * sucessfully with all data Flits have an NORMAL_OKAY response.
   * For an exclusive transaction memory is not updated as this feature is not yet supported.
   * <b>type:</b> Static
   */
  bit memory_update_for_read_xact_enable = 0;

  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding transactions a node can support.<br>
   * RN:
   * If the number of outstanding transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding transactions
   * is less than this parameter.<br>
   * SN:
   * If the number of outstanding transactions is equal to 
   * this number, the SN will not acknowledge
   * until the number of outstanding transactions becomes less
   * than this parameter. <br>
   * If #num_outstanding_xact = -1 then #num_outstanding_xact will not 
   * be considered, instead #num_outstanding_read_xact, #num_outstanding_write_xact,
   * #num_outstanding_cmo_xact and #num_outstanding_control_xact have an effect.
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT. Default value is `SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT. 
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_xact = `SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT;

  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding read transactions a node can support.<br>
   * The read transactions include Read-type transactions listed below:
   * -ReadNoSnp
   * -ReadOnce
   * -ReadShared
   * -ReadClean
   * -ReadUnique
   * .
   * RN:
   * If the number of outstanding read transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding read transactions
   * is less than this parameter.<br>
   * SN:
   * If the number of outstanding read transactions is equal to 
   * this number, the SN will not acknowledge
   * until the number of outstanding read transactions becomes less
   * than this parameter. <br>
   * This parameter must be set if #num_outstanding_xact = -1.
   * This parameter must not be set if #num_outstanding_xact is not set to -1.
   * - <b>Default val:</b> -1
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_read_xact = -1;

  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding write transactions a node can support.<br>
   * The write transactions include Write-type, and CopyBack transactions listed below:
   * The Write type transactions include:
   * -WriteNoSnpFull, WriteNoSnpPtl
   * -WriteUnqueFull, WriteUniquePtl
   * -WriteBackFull, WriteBackPtl
   * -WriteCleanFull, WriteCleanPtl
   * -WriteEvictFull
   * .
   * RN:
   * If the number of outstanding write transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding write transactions
   * is less than this parameter.<br>
   * SN:
   * If the number of outstanding write transactions is equal to 
   * this number, the SN will not acknowledge
   * until the number of outstanding write transactions becomes less
   * than this parameter. <br>
   * This parameter must be set if #num_outstanding_xact = -1.
   * This parameter must not be set if #num_outstanding_xact is not set to -1.
   * - <b>Default val:</b> -1
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_write_xact = -1;

  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding Cache Maintenance transactions a node can support.<br>
   * The Cache Maintenance transactions include the transactions listed below:
   * -MakeInvalid
   * -MakeUnque
   * -CleanInvalid
   * -CleanUnique
   * -CleanShared
   * -Evict
   * .
   * RN:
   * If the number of outstanding CMO transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding CMO transactions
   * is less than this parameter.<br>
   * SN:
   * If the number of outstanding CMO transactions is equal to 
   * this number, the SN will not acknowledge
   * until the number of outstanding CMO transactions becomes less
   * than this parameter. <br>
   * This parameter must be set if #num_outstanding_xact = -1.
   * This parameter must not be set if #num_outstanding_xact is not set to -1.
   * - <b>Default val:</b> -1
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_cmo_xact = -1;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * Enables the propagating of CMOs to SN nodes.
   */
  rand bit slave_cmo_enable = 0;

  /**
   * Enables propagation of persist cmos to sn 
   */
  rand bit slave_persist_cmo_enable = 0;
`endif

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * Enables the System Coherency connection feature for RN_F or RN_D with dvm_enabled.
   * It is applicable only when the macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined and svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later.
   * - <b>Default val:</b> 0
   * - <b>type:</b> Static
   * .
   */
  rand bit sysco_interface_enable = 0;

  /** 
   * When Set to 1 blocks all the transactions till the coherency_enabled state is reached.
   * It is applicable only when: 
   * - The macro SVT_CHI_ISSUE_B_ENABLE or SVT_CHI_ISSUE_C_ENABLE is defined, 
   * - svt_chi_node_configuration::chi_spec_revision is set to ISSUE_B or later.
   * - svt_chi_node_configuration::sysco_interface_enable is set to 1.
   * .
   * - <b>Default val:</b> 0
   * - <b>type:</b> Static
   * .
   */
  bit block_all_transactions_until_coherency_enabled = 0;
`endif

  /** 
    * Number of REQ L-Credits that can be transmitted in RX-Deactivate state. 
    * The total number of credits advertised will not exceed rx_req_vc_flit_buffer_size.
    * Applicable for:
    * - SN 
    * - RN connected nodes for ICN VIP with interface types:RN_F, RN_D, RN_I
    * .
    * - Default value is \`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE (`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE), which is a user redefinable macro.
    * - <b>type:</b> Static
    * .
    */
  int unsigned num_xmitted_rxreq_vc_lcredits_in_rxdeactivate_state = `SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE;

  /** 
    * Number of RSP L-Credits that can be transmitted in RX-Deactivate state. 
    * The total number of credits advertised will not exceed rx_rsp_vc_flit_buffer_size.
    * Applicable for:
    * - RN 
    * - RN connected nodes for ICN VIP with interface types:RN_F, RN_D, RN_I
    * - SN connected nodes for ICN VIP with interface types:SN_F, SN_I
    * .
    * - Default value is \`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE (`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE), which is a user redefinable macro.
    * - <b>type:</b> Static
    * .
    */
  int unsigned num_xmitted_rxrsp_vc_lcredits_in_rxdeactivate_state = `SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE;

  /** 
    * Number of DAT L-Credits that can be transmitted in RX-Deactivate state. 
    * The total number of credits advertised will not exceed rx_dat_vc_flit_buffer_size.
    * Applicable for:
    * - RN 
    * - SN 
    * - RN connected nodes for ICN VIP with interface types:RN_F, RN_D, RN_I
    * - SN connected nodes for ICN VIP with interface types:SN_F, SN_I
    * .
    * - Default value is \`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE (`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE), which is a user redefinable macro.
    * - <b>type:</b> Static
    * .
    */
  int unsigned num_xmitted_rxdat_vc_lcredits_in_rxdeactivate_state = `SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE;

  /** 
    * Number of SNP L-Credits that can be transmitted in RX-Deactivate state. 
    * The total number of credits advertised will not exceed rx_snp_vc_flit_buffer_size.
    * Applicable for:
    * - RN_F, RN_D
    * .
    * - Default value is \`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE (`SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE), which is a user redefinable macro.
    * - <b>type:</b> Static
    * .
    */
  int unsigned num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state = `SVT_CHI_MAX_NUM_LCREDITS_XMITTED_IN_DEACTIVATE_STATE;

  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding control transactions a node can support.<br>
   * The control transactions include DVM, Barrier transactions listed below:
   * -DVMOp
   * -EOBarrier
   * -ECBarrier
   * .
   * RN:
   * If the number of outstanding control transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding control transactions
   * is less than this parameter.<br>
   * SN:
   * If the number of outstanding control transactions is equal to 
   * this number, the SN will not acknowledge
   * until the number of outstanding control transactions becomes less
   * than this parameter. <br>
   * This parameter must be set if #num_outstanding_xact = -1.
   * This parameter must not be set if #num_outstanding_xact is not set to -1.
   * - <b>Default val:</b> -1
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_control_xact = -1;

`ifdef SVT_CHI_ISSUE_B_ENABLE  
  /**
   * @groupname chi_config_outstanding_xacts
   * Specifies the number of outstanding Atomic transactions a node can support.<br>
   * This is applicable only for CHI-B nodes with atomic_transactions_enable set to 1.<br>
   * The Atomic transactions include:
   * - AtomicStore
   * - AtomicLoad
   * - AtomicSwap
   * - AtomicCompare
   * .
   * RN:
   * If the number of outstanding atomic transactions is equal to this
   * number, the RN will refrain from initiating any new 
   * transactions until the number of outstanding write transactions
   * is less than this parameter.<br>
   * SN:
   * SN currently does not support Atokmic transactions.
   * So, this parameter will be treated as Don't care. <br>
   * This parameter must be set if #num_outstanding_xact = -1.
   * This parameter must not be set if #num_outstanding_xact is not set to -1.
   * - <b>Default val:</b> -1
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_atomic_xact = -1;
`endif


  /**
   * Specifies the number of outstanding snoop transactions a RN can support.<br>
   * If the number of outstanding snoop transactions is equal to this
   * number, the RN will refrain from responding to any new snoop 
   * transactions until the number of outstanding snoop transactions
   * is less than this parameter.<br>
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_OUTSTANDING_SNOOP_XACT. Default value is `SVT_CHI_DEF_MAX_NUM_OUTSTANDING_SNOOP_XACT.
   * - <b>type:</b> Static
   * .
   */
  rand int num_outstanding_snoop_xact = `SVT_CHI_DEF_MAX_NUM_OUTSTANDING_SNOOP_XACT;

  /**
    * @groupname chi_exclusive_access
    * This bit controls the generation and support of exclusive sequence in RN and SN.<br> 
    * - RN: Enables generation of exclusive access transactions.<br>
    * - SN, Passive RN: Indicates whether the SN, Passive RN supports exclusive access or not.<br>
    * .
    * - <b>Default value:</b> 1’b0
    * - <b>type:</b> Static
    * .
    */
  rand bit exclusive_access_enable = 0;

  /**
    * @groupname chi_exclusive_access
    * This bit specifies the support of custom coherent exclusive access sequences in RN-I and RN-D nodes that are mapped to ACE-Lite or AXI masters.
    * - This information is made use of by the system monitor in order to process such custom exclusive transactions 
    * - Not Applicable for native CHI RN_I and RN_D agents.  
    * - Note: This bit is applicable only when exclusive_access_enable is set to '1'.
    * - A value of 1 indicates that the CHI system monitor will treat these custom exclusives (ReadOnce and WriteUnique) as valid exclusive transactions.
    * .
    * The way the exclusive monitor is maintained and the expected responses that are computed by the VIP for these custom exclusive transactions will be on the same lines as the other spec-defined exclusives:
    * - Exclusive monitor is set by a successful exclusive ReadOnce.
    * - Any intervening store is expected to cause the subsequent exclusive WriteUnique to fail with an OKAY response.
    * - The exclusive WriteUnique is expected to get an EXCLUSIVE_OKAY response and the exclusive sequence is expected to complete successfully, 
    * - if the location was not updated, by any other LP, since the Exclusive ReadOnce 
    * .
    * - <b>Default value:</b> 1’b0
    * - <b>type:</b> Static
    * .
    */
  rand bit coherent_exclusive_access_from_rni_rnd_ports_enable = 0;

  /**
    * @groupname chi_exclusive_access
    * This bit controls enabling CHI RN exclusive monitor and applicable only
    * when svt_chi_node_configuration::exclusive_access_enable bit is set to 1.<br> 
    * - When set to 1, exclusive monitor is enabled in CHI RN and in case of RN-F, when the response is EXCLUSIVE_OKAY, cache is updated based on exclusive monitor state in addition to coherent response.<br>
    * - When set to 0, exclusive monitor is disabled in CHI RN and in case
    *   of RNF, cache is updated solely based on coherent response.<br>
    * .
    * - <b>Default value:</b> 1’b0
    * - <b>type:</b> Static
    * .
    */
   rand bit exclusive_monitor_enable = 1;

  /**
    * @groupname chi_exclusive_access
    * - RN:The maximum number of active exclusive transactions that will be initiated by the RN.
    * - SN:The maximum number of active exclusive transactions supported by the SN. Attempts to
    * exceed this max number results in a failed exclusive access read response of OKAY instead of EXOKAY
    * .
    * - <b>min val:</b> 0
    * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS. Default value is `SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS.
    * - <b>type:</b> Static
    * .
    * NOTE: if it is set to '0' value then there are no restrictions on maximum number of active exclusive transactions. 
            * VIP will drop any exclusive sequence initiated post the maximum allow exclusive access limit is reached.
    */ 
  rand int max_num_exclusive_access   = `SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS;

  /**
    * @groupname chi_exclusive_access
    * INTERCONNECT:
    * - Number of ADDRESS bits that need to be monitored by the exclusive monitors for 
    * current node in order to support one or more independent exclusive access thread.<br>
    * - The RN/SN connected node configurations of the ic_cfg needs to be in
    *   sync with connected external RN/SN node configuration attribute.
    * .
    *
    * - <b>type:</b> Static
    * - <b>min val:</b> 0
    * - NOTE: configuring with value 0 means, no address is being monitored by the corresponding exclusive monitor and
    * hence exclusive access to different address may also affect current thread.
    * - <b>max val:</b> Value defined by macro \ `SVT_CHI_MAX_ADDR_WIDTH. Default value is `SVT_CHI_MAX_ADDR_WIDTH.
    * .
    * Special value:
    * - It can also be configured with ( -1 ) to indicate that address ranges for 
    * each exclusive monitor is defined through user specified start and end address ranges.<br>
    * - For this, user should configure svt_chi_system_configuration::start_address_ranges_for_exclusive_monitor[] and
    * svt_chi_system_configuration::end_address_ranges_for_exclusive_monitor[].<br>
    * - A svt_chi_system_configuration::set_exclusive_monitor_addr_range(bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr) 
    * utility method can be used for this purpose. <br>
    * - <b>special value:</b> When configured to -1, svt_chi_node_configuration::num_addr_bits_used_in_exclusive_monitor and
    * svt_chi_node_configuration::num_initial_addr_bits_ignored_by_exclusive_monitor are not used. 
    * - The value of -1 is currently not supported.
    * .
    * 
    */ 
  rand int num_addr_bits_used_in_exclusive_monitor   = `SVT_CHI_MAX_ADDR_WIDTH;

  /** @cond PRIVATE */
  /**
    * @groupname chi_exclusive_access
    * CHI Exclusive monitor will ignore number of initial address bits as indicated by this configuration member.<br>
    * - Example: A coherent interconnect can divide its whole address space into
    * multiple ranges such that each PoS Exclusive monitor checks only
    * its corresponding address range. 
            * - So, if it allocates 1/2 GB address space to each
    * of the 4 PoS exclusive monitors then svt_chi_node_configuration::num_initial_addr_bits_ignored_by_exclusive_monitor
    * needs to be configured as 29 (1.5GB - 2GB ~ 31 bits).
    * .
    * <b>Default value:</b> 0
    * <b>type:</b> Static
    * Note: Only default value(0) is supported.
    */
  rand int num_initial_addr_bits_ignored_by_exclusive_monitor   = 0;

  /**
    * @groupname chi_exclusive_access
    * INTERCONNECT:
    * - Number of LPID bits that need to be monitored by the exclusive monitors for 
    * current port in order to support one or more independent exclusive access thread.
    * - The RN/SN connected node configurations of the ic_cfg needs to be in
    *   sync with connected external RN/SN node configuration attribute.
              * - NOTE: configuring with value 0 means, no lpid is being monitored by the corresponding exclusive monitor 
            * and hence only single exclusive access thread is supported for current port.
    * .
    * - <b> This feature is supported only for SVT_CHI_MAX_LPID_WIDTH</b>
    * - <b>min val:</b> 0
    * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_LPID_WIDTH -1. Default value is `SVT_CHI_MAX_LPID_WIDTH.
    * - <b>type:</b> Static
    * .
    * Note: Only SVT_CHI_MAX_LPID_WIDTH value is suported.
    */ 
  rand int num_lpid_bits_used_in_exclusive_monitor     = `SVT_CHI_MAX_LPID_WIDTH;

  /**
    * @groupname chi_exclusive_access
    * Applicable for coherent exclusive transactions only.
    * Possible values for the attribute:
    * - Value of '1' indicates that Exclusive Monitor will respond to very first Exclusive Store with EXOKAY response. 
    * This means that if no master has performed any exclusive transaction after reset is de-asserted then the master that issues
    * exclusive store will be responded with EXOKAY or Exclusive Monitor will expect EXOKAY response from the coherent interconnect.
    * - Value of '0' indicates that Exclusive Monitor will respond to very first Exclusive Store with OKAY response.
    * .
    * Note: reference point of first exclusive store is reset.
    * - <b>Default value:</b> 0
    * - <b>type:</b> Static
    * .
    * 
    */ 
  rand bit allow_first_exclusive_store_to_succeed = 0;

  /**
    * @groupname chi_exclusive_access
    * This control register indicates different modes of error conditions used in exclusive monitor.
    * - CTRL_REG_NO_ERR: No error registered.
    * - SNP_ERR_EXCL_SEQ_FAIL: Implies that Snoop Error will cause an exclusive sequence to fail only if either data_transfer bit or pass_dirty bit is set to '1'.
    *   Otherwise, if snoop response indicates error bit as asserted then regardless of data_transfer bit or pass_dirty bit values exclusive sequence will fail. This feature is currently not supported.<br>
    * .
    * - <b>Default value:</b> CTRL_REG_NO_ERR
    * - <b>type:</b> Static
    * .
    */
  rand excl_mon_error_control_reg_enum excl_mon_error_control_reg = CTRL_REG_NO_ERR;

  /**
    * @groupname chi_exclusive_access
    * This field defines the width of the Logical Processor ID - LPID associated with the
    * transaction. This is used to check if the configured
    * svt_chi_node_configuration::num_lpid_bits_used_in_exclusive_monitor
    * programmed is less than or equal to the MAX CHI LPID width.
    * 
    * - <b>Default value:</b> `SVT_CHI_LPID_WIDTH
    * - <b>type:</b> Static
    * .
    */
  rand int lpid_width  = `SVT_CHI_LPID_WIDTH;
  

  /**
    * @groupname chi_exclusive_access
    * This field indicates the exclusive monitor policy to whether allow multiple outstanding exclusive sequence per srcid per lpid or not. 
    */
  rand non_coherent_exclusive_monitor_policy_enum non_coherent_exclusive_monitor_policy = ALLOW_MULTIPLE_OUTSTANDING_EXCLUSIVE_SEQUENCE_PER_SRCID_PER_LPID;

  /** @endcond */
  
  /**
    * @groupname chi_exclusive_access
    * Possible values for the attribute:
    * - If set to '1' then Exclusive Monitor will get reset once Exclusive Store is successful.
    * - If set to '0' then Exclusive Monitor will remain set even if Exclusive Store is successful.
    * . 
    * Please Note that, VIP will still reset Exclusive Monitor for failed Exclusive Store attempt
    * regardless of the value set for this parameter.
    * - <b>Default value:</b> 1
    * - <b>type:</b> Static
    * .
    */ 
  rand bit reset_exclusive_monitor_on_successful_exclusive_store = 1;

  /**
    * @groupname chi_exclusive_access
    * Applicable for coherent exclusive transactions only.
    * Possible values for the attribute:
    * - Value of '1' indicates that Exclusive store will not be dropped even if there are no preceding exclusive loads and the VIP expects the Exclusive Store to pass with EXOKAY response.<br>
    * - Value of ‘0’ indicates that Exclusive store will be dropped if there was no preceding exclusive load transaction.<br>
    * . 
    * - <b>Default value:</b> 0
    * - <b>type:</b> Static
    * .
    */ 

  rand bit allow_exclusive_store_without_exclusive_load = 0;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MCqZzQv9avOZMugnrNunx1YlsTIsK7kw/98Fi3HlbCNr12iG6VvUiv0+ti/eMHTC
81lHEQrKsv7aLTd5FGuOojfHaeSm/3/HfLrRe83pNR3q7XdZDpl7FNhMVEP1ZKfJ
drfRA91EmvOKzIXkEL3nxzkY5716eGF9TBt3an0CQ88+hI66OjG2xA==
//pragma protect end_key_block
//pragma protect digest_block
yVbw54v1ibJN/iiB4CJSC2fU0uA=
//pragma protect end_digest_block
//pragma protect data_block
1w0SqJaHD8Q7F19xX1WAOiiSn5jAAyf767PWlXB1f/fRExA3jbskchC79qVh8WJO
7brhhmCxEZ2ps6jDJ3WP+j3UVyxTVKABnkpcEHu3neKxCTEFO7q8j6JaAiGG4YGr
CZiCPY9S9kHiaqpxt8Hh136OnYWjfWHbl1EG5DXb7SNhJFMmESOIi/BI20Bl3oQQ
dV/2vBmd06jm9I+gcL7czqPoxg4fGHHyQpiWKFfDYtK2aE6yKfLLjABd+bBv/c2q
Lgod5qKBCnixiOGv67ebRa6g9Vb6EfDrqEo4tGLNd2c8QHESaj3t4kfVBmklwb4A
lFKGdg3efYqzObnXPYMnSbcv/O+XT+c8eJvKF4a8BhdlnN5+mlcWjMI+hOD1cB2c
t4v/yfh0M5L/xXMyrBVikkvKG3agcV+t2QCry7atxmrqi7e4pSHlJZJhxtWqvY+e
ZX4Vp0Ex8nhyiRSBJQIlcaLksY8xatuRwIKFBnEPMkh2ktI3Yp9zx5XY3uY6PVSd
TExlnloHaiOavlcvOqKflzKalEb0Y6X0HjGb/BXNfpKfKJqmMT66oT1Lq42BJmji
qiNE1REIDhsZe4nushyqCIj76SipASPUQMhkRsDkiBoOWxCg8e2syStJvTBykMVN
wM9krwQKiFBfT8CW9Rt+IsIMbnSia7TI2VtqEKMp0AwllKLOqnTHRd96EfD9d0vy
PVc4mGxHzQYH7oPFsDKLIMlqWTQG+Qq4KJyRuljeOUx1CLM2GB47RTHuBLUV0JZb
24ulmW4scyqEoGKfHfwYe4Ib0hY7b5hfOM2C5phkY748o3+oGxMfD+1SekRlnwrF
rpxopq2QGZNrszQUMwDohOV16DSuKU3H8VHkQX+QukwkXL6fYCOIDBn1pDTqV6QT
sxbIErMoIKMGDaYpx/A4cJnvFN1NXDHWuFCi1T8edLWwysM0joMoxdTpEZXmECj1
Z9pTZ43LKt/ZKSxjh571H+sRdfdH0nymCbcTukQtvP0jg9qf9KP7jrBZuTA2VUxi
MCHi2ivLILG7ABgxOdrHUpvnAKiMu8Lm9jDw52IckfsdhcWAjAJ1TPeVX5IxPs1F
aVZYIGRGm9hz3/vo1xRPcMrVmBTodaM6Y1ntqLHfL8x4vCDf6TIcq1ZAYR58wlQh
E3SKCPWlLwsPrENHwQeYg3MK0e5aSl+TU8dbH4k2oMDtIGpiESJQCuobk0bDFdJ7
Nynl+dJJ6V86ldCGP+8fLwCOIx8Ik5ljfaCOCWhAM2xmLkL155I35l/Kv8zkOqzN
/g50KsGzWjk+jYl9o/kpc1E8gWzMltWpbHNB2uQd7zyOZifAGb7aUqrh8M5wzXnz
spcDzpyjz862/jbeXLFktiXQWZIcgMMMrMJMFjrWxCsWZHP+8mBwGirWVrKmWHOX

//pragma protect end_data_block
//pragma protect digest_block
JY/NkU3VoF2da8husQODxepGsOQ=
//pragma protect end_digest_block
//pragma protect end_protected

  /**
   * RN: Enables support for barrier transactions.<br>
   * <b>type:</b> Static
   */
  rand bit barrier_enable = 0;

  /**
   * RN: Enables support for DVM transactions.<br>
   * <b>type:</b> Static
   */
  rand bit dvm_enable = 0;

  /**
   * RN: Enables sending of DVM Sync transactions without preceding DVM Non-Sync transactions.<br>
   * <b>type:</b> Static
   */
  rand bit allow_dvm_sync_without_prior_non_sync = 0;

  /**
   *  The configuration enables the UCE and UDP cache line states in the VIP.<br> 
   *  When this configuration  attribute is set to 1, the VIP enforces the cache state transition rules related to UCE/UDP, and
   *  handles coherent and snoop transactions initiated from OR resulting in UCE/UDP states and displays UCE/UDP states in the transaction summary and PA cache visualization views. <br>
   *  When the configuration is set to 0, UCE is unsupported and is treated as Invalid (‘I’) state whereas UDP would be functionally supported but stored and represented as UD state. <br>
   *  This is applicable only:
   *  - For Active RN.
   *  .
   *  <b>type:</b> Static
   *  Default value is 0 (\`SVT_CHI_NODE_CFG_PARTIAL_CACHE_STATES_ENABLE : re-definable macro).
   *
   */ 
  bit partial_cache_line_states_enable = `SVT_CHI_NODE_CFG_PARTIAL_CACHE_STATES_ENABLE;

  /**
   *  When set to 1'b1, the 'Other initial cache state' is considered in addition to 'Expected initial
   *  cache state' at the Requester for generating the requests as per the cache state transition tables
   *  in section 4.7 of 'CHI Specification D: ARM IHI 0050D' and 'CHI Specification E.a: ARM IHI 0050E.a'.
   *  That is, the Other Initial States are considered as valid initial cache line states. <br>
   *  This is applicable only:
   *  - For Active RN.
   *  .
   *  <b>type:</b> Static
   * 
   */
  rand bit other_initial_cache_state_enable = 0;


  /** @cond PRIVATE */
  /**
   *  When set to 1'b1, the initial cache state transition from 'Other initial cache state' to 
   *  'Expected initial cache state' occurs at the Requester before sending out the transaction
   *  on the interface. Refer to section 4.7 of 'CHI Specification D: ARM IHI 0050D' and
   *  'CHI Specification E.a: ARM IHI 0050E.a' for details. <br>
   *  This is applicable only:
   *  - When svt_chi_node_configuration::other_initial_cache_state_enable is set to 1'b1.
   *  - For Active RN.
   *  .
   *  <b>type:</b> Static
   * 
   */
  rand bit other_to_exp_initial_cache_state_transition_enable = 0;
  /** @endcond */
  
  /** 
   * RN: Sets the number of request order streams supported in active mode. <br>
   * - <b>type:</b> Static
   * - When set to 1, indicates single request order stream. 
   * - svt_chi_rn_transaction::req_order_stream_id can hold
   *   the values in the range [0:num_req_order_streams-1]. 
   * .
   * Note that Passive RN can perform the request ordering related checks only
   * when the number of request order streams is one.
   */
  rand int unsigned num_req_order_streams = 1;

  /** 
   * RN: Indicates if the requests are generated from multiple sources within an RN. <br>
   * - <b>type:</b> Static
   * - When set to 1, indicates that there are multiple sources within the RN which can generate requests. 
   *   Ordering rules need not be followed between two requests targeting the same cacheline and having order_type set to 'NO_ORDERING_REQUIRED'
   * - When set to 0, indicates that all requests sent by the RN can be considered requests from the same source. 
   *   Ordering rules must be followed between two requests targeting the same cacheline and having order_type set to 'NO_ORDERING_REQUIRED'
   * .
   * Note that Passive RN can perform the new_req_before_completion_of_previous_read_write_xact_to_same_cacheline_check check only
   * when multiple_req_sources_within_rn_node is set to 0.
   */
  rand bit multiple_req_sources_within_rn_node = 0;

  /**
   * Enables protocol layer delays for the agent in active mode.<br>
   * If set to 1, user-programmable delays present in the
   * svt_chi_common_transaction class comes into effect.
   * Default value is 0. Valid only when #delays_enable is set to 1.
   * <b>type:</b> Static
   */
  rand bit prot_layer_delays_enable = 0;

  /** @cond PRIVATE */
  /**
   * Defines the mode for programming LCRDV delays.
   * If set to 1, the LCRDV delay for all VCs is programmed to a random
   * value between minimum and maximum value. 
   * For eg: For RXSNPLCRDV signal, the delay is programmed to a random
   * value between svt_chi_node_configuration::rcvd_snp_flit_to_lcrd_min_delay
   * and svt_chi_node_configuration::rcvd_snp_flit_to_lcrd_max_delay.
   * 
   * If set to 0, the LCDV delay for all VCs is programmed based on the 
   * user-defined values for the delay.
   * For eg: For RXSNPLCRDV signal, the delay is programmed based on the
   * user-defined value for svt_chi_common_transaction::rxsnplcrdv_delay.<br>
   * Default value is 1.
   * <b>type:</b> Static
   */
  rand bit cfg_lcrd_delays_enable = 1;
  /** @endcond */

  /**
   * Enables link layer delays for the agent in active mode.<br>
   * <b>type:</b> Static
   */
  rand bit delays_enable = 1;

  /**
   * Enables link active signals delays for the agent in active mode.<br>
   * NOTE:
   * - Applicable only for ACTIVE mode components.
   * - Should be enabled in PASSIVE mode component to track the active mode
   *   link active state machine transitions.
   * - <b>type:</b> Static
   * .
   */
  rand bit link_active_signal_delays_enable = 0;

  /**
   * Enables link active state machine to enter banned state outputs when
   * set to 1.<br>
   * NOTE:
   * - Applicable only for ACTIVE mode components.
   * - Should be enabled in PASSIVE mode component to track the active mode
   *   link active state machine transitions.
   * - <b>type:</b> Static
   * .
   */
  rand bit allow_link_active_signal_banned_output_race_transitions = 0;


  /**
   * Specifies the timeout value in number of clock cycles within which the component's link active state machine entering Async Input Race State/Banned Output Race State is expected to move to next valid link active state. <br>
   * This node configuration parameter #async_input_banned_output_race_link_active_states_timeout is used to perform the checks lasm_in_async_input_race_state_timeout_check and lasm_in_banned_output_race_state_timeout_check. <br>
   * The value of this node configuration parameter #async_input_banned_output_race_link_active_states_timeout needs to be programmed by considering all other link active state machine delays. <br>
   * The checks lasm_in_async_input_race_state_timeout_check and lasm_in_banned_output_race_state_timeout_check:
   * - performed when  #async_input_banned_output_race_link_active_states_timeout value is greater than or equal to 1.
   * - not performed when  #async_input_banned_output_race_link_active_states_timeout value is less than or equal to 0.
   * .
   * Applicable for Active and Passive RN nodes.
   * - value less than or equal to 0 : Timer is disabled
   * - value greater than or equal to 1 : Timer is enabled
   * - Default value is 0 (\`SVT_CHI_NODE_CFG_DEFAULT_ASYNC_INPUT_BANNED_OUTPUT_RACE_LINK_ACTIVE_STATES_TIMEOUT : re-definable macro).
   * - <b>type:</b> Static
   * .
   */
   int async_input_banned_output_race_link_active_states_timeout = `SVT_CHI_NODE_CFG_DEFAULT_ASYNC_INPUT_BANNED_OUTPUT_RACE_LINK_ACTIVE_STATES_TIMEOUT;

  /**
   * This attribute indicates whether the component(RN/SN) Link Active State Machine entry into the Async Input Race States is expected or not. <br>
   * A given component Link Active State Machine entry into Async Input Race States can only be reached by observing a race between the two input signals. In other words, entry into Async Input Race states for a given component can happen only when there is a Banned Output Signal race condition at the connected link partner component. <br>
   * If #is_link_active_state_machine_in_async_input_race_state_expected bit is set to 0,
   * - The check lasm_entry_into_async_input_race_state_check will be constructed and executed. 
   * - If the Link Active State Machine entry into Async Input Race State is observed the check will fail, if not the check will pass.
   * .
   * If #is_link_active_state_machine_in_async_input_race_state_expected bit is set to 1(Default),
   * - The check lasm_entry_into_async_input_race_state_check will <b>not</b> be constructed. 
   * .
   * A given component Link Active State Machine entry into Async Input Race state implies that the connected link partner component has entered Banned Output Race state. <br>
   * Use case:
   * - For a given component, the node configuration parameter svt_chi_node_configuration::is_link_active_state_machine_in_async_input_race_state_expected can be set to 0 (which inturn enables this check) for below cases: 
   *   - An error needs to be thrown when the component's Link Active State Machine to enter into Async Input Race State
   *   - An error needs to be thrown when the connected link partner component's Link Active State Machine to enter into Banned Output Race State
   *   .
   * .
   * A component Link Active State Machine entry into Async Input Race State is observed as below:
   * - <b>TX_RUN+ RX_STOP</b>
   *   - TX_ACTIVATE RX_STOP to TX_RUN+ RX_STOP 
   *   .
   * - <b>TX_ACTIVATE RX_DEACTIVATE+</b>
   *   - TX_ACTIVATE RX_RUN to TX_ACTIVATE RX_DEACTIVATE+
   *   .
   * - <b>TX_STOP+ RX_RUN</b>
   *   - TX_DEACTIVATE RX_RUN to TX_STOP+ RX_RUN
   *   .
   * - <b>TX_DEACTIVATE RX_ACTIVATE+</b>
   *   - TX_DEACTIVATE RX_STOP to TX_DEACTIVATE RX_ACTIVATE+
   *   .
   * .
   * Applicable for both Active and Passive RN/SN.
   * - Default value is 1 (\`SVT_CHI_NODE_CFG_DEFAULT_IS_LINK_ACTIVE_STATE_MACHINE_IN_ASYNC_INPUT_RACE_STATE_EXPECTED : re-definable macro).
   * - <b>type:</b> Static
   * .
   */
   bit is_link_active_state_machine_in_async_input_race_state_expected = `SVT_CHI_NODE_CFG_DEFAULT_IS_LINK_ACTIVE_STATE_MACHINE_IN_ASYNC_INPUT_RACE_STATE_EXPECTED;

  /**
   * This attribute indicates whether the component(RN/SN) Link Active State Machine entry into the Banned Output Race States is expected or not. <br>
   * There can be a race condition between the output signals of a component's Link Active State Machine which results in entry into Banned Ouptput Race States. <br>
   * A given component's Link Active State Machine entry into Banned Output Race states results in the connected link partner component being entering Async Input Race States. <br>
   * This attribute in applicable components is used only to perform the check lasm_entry_into_banned_output_race_state_check. <br>
   * If #is_link_active_state_machine_in_banned_output_race_state_expected bit is set to 0,
   * - The check lasm_entry_into_banned_output_race_state_check will be constructed and executed. 
   * - If the Link Active State Machine entry into Banned Output Race State is observed the check will fail, if not the check will pass.
   * .
   * If #is_link_active_state_machine_in_banned_output_race_state_expected bit is set to 1(Default),
   * - The check lasm_entry_into_banned_output_race_state_check will <b>not</b> be constructed. 
   * .
   * Use case:
   * - For a given component, the node configuration parameter svt_chi_node_configuration::is_link_active_state_machine_in_banned_output_race_state_expected can be set to 0 (which inturn enables this check) for below cases: 
   *   - An error needs to be thrown when the component's Link Active State Machine to enter into Banned Output Race State
   *   - An error needs to be thrown when the connected link partner component's Link Active State Machine to enter into Async Input Race State
   *   .
   * .
   * A component Link Active State Machine entry into Banned Output Race State is observed as below:
   * - <b>TX_STOP RX_RUN+</b>
   *   - TX_STOP RX_ACTIVATE to TX_STOP RX_RUN+
   *   .
   * - <b>TX_RUN RX_STOP+</b>
   *   - TX_RUN RX_DEACTIVATE to TX_RUN RX_STOP+ 
   *   .
   * - <b>TX_DEACTIVATE+ RX_ACTIVATE</b>
   *   - TX_RUN RX_ACTIVATE to TX_DEACTIVATE+ RX_ACTIVATE
   *   .
   * - <b>TX_ACTIVATE+ RX_DEACTIVATE</b>
   *   - TX_STOP RX_DEACTIVATE to TX_ACTIVATE+ RX_DEACTIVATE
   *   .
   * .
   * Applicable only for Passive RN/SN and must be set to deafault for other components.
   * - Default value is 1 (\`SVT_CHI_NODE_CFG_DEFAULT_IS_LINK_ACTIVE_STATE_MACHINE_IN_BANNED_OUTPUT_RACE_STATE_EXPECTED : re-definable macro).
   * - <b>type:</b> Static
   * .
   */
   bit is_link_active_state_machine_in_banned_output_race_state_expected = `SVT_CHI_NODE_CFG_DEFAULT_IS_LINK_ACTIVE_STATE_MACHINE_IN_BANNED_OUTPUT_RACE_STATE_EXPECTED;

  /**
   * This attribute indicates that when the component's TX Link Active State Machine is not in RUN State, whether l-credits on SNP Virtual Channel are transmitted or not. <br>
   * If #stop_snp_lcrd_xmission_when_txla_not_in_run_state bit is set to 0(Default),
   * - l-credit's transmission on SNP virtual channel are permitted when TX Link Active State Machine is not in RUN state.
   * - In other words, RXSNPLCRDV signal of SNP Virtual Channel can be asserted when TX Link Active State Machine is not in RUN state.
   * - l-credits on SNP Virtual Channel are transmitted when RX Link Active State Machine is in RUN state or in DEACTIVATE state(permitted when #num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state is programmed) irrespective of TX Link Active State Machine.
   * .
   * If #stop_snp_lcrd_xmission_when_txla_not_in_run_state bit is set to 1,
   * - l-credits transmission on SNP Virtual Channel are stopped when TX Link Active State Machine is not in RUN state.
   * - In other words, RXSNPLCRDV signal of SNP Virtual Channel is not asserted when TX Link Active State Machine is not in RUN state.
   * - l-credits on SNP Virtual Channel are transmitted only when
   *   - RX Link Active State Machine is in RUN state and TX Link Active State Machine is in RUN state
   *   - RX Link Active State Machine is in DEACTIVATE state(permitted when #num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state is programmed) irrespective TX Link Active State Machine state
   *   .
   * .
   * <b>NOTE:</b>
   * - It is expected, when this feature is enabled(#stop_snp_lcrd_xmission_when_txla_not_in_run_state bit is set to 1),the configuration #num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state must be set to 0.
   * - This attrbute doesn't effect the transmission of l-credits on SNP Virtual Channel when RX is in DEACTIVATE state irrespective of TX Link Active State Machine state, as this will be controlled by the node configuration attribute #num_xmitted_rxsnp_vc_lcredits_in_rxdeactivate_state.
   * .
   * Applicable only for RN and must be set to default for other components.
   * - Default value is 0 (\`SVT_CHI_NODE_CFG_DEFAULT_STOP_SNP_LCRD_XMISSION_WHEN_TXLA_NOT_IN_RUN_STATE : re-definable macro).
   * - <b>type:</b> Static
   * .
   */
   bit stop_snp_lcrd_xmission_when_txla_not_in_run_state = `SVT_CHI_NODE_CFG_DEFAULT_STOP_SNP_LCRD_XMISSION_WHEN_TXLA_NOT_IN_RUN_STATE;

  /**
    * Defines the format in which data and byte_enable are programmed.
    * If set to STANDARD_DATA_FORMAT, the attribute #wysiwyg_enable is applicable
    * and the usage given for #wysiwyg_enable is used.<br>
    * If set to HYBRID_DATA_FORMAT, a combination of WYSIWYG and right aligned programming
    * is used as follows :
    * <br>
    * For NORMAL memory writes, the user provides data in WYSIWYG format and
    * specifies the number of bytes to be transmitted from the starting
    * address. <br> 
    * For DEVICE memory writes, the user provides data in
    * right-aligned format and specifies the number of bytes to be transmitted
    * from the starting address. <br>
    * In both cases, the VIP will generate the correct byte_enable based on the
    * address, data_size and the specified number of bytes to be transmitted.
    * Note that this is applicable only for partial writes since for full
    * cacheline writes, all bytes should be asserted. For more details on
    * programming in HYBRID_DATA_FORMAT mode please refer the user guide under
    * "Programming data and byte enable in Hybrid Data Format"
    */
  rand chi_data_format_enum data_format = STANDARD_DATA_FORMAT;

  /**
   * Acronym for "What You See is What You Get". Applicable to the following attributes:
   * - svt_chi_transaction::data
   * - svt_chi_transaction::byte_enable 
   * . 
   * If this bit is set to 1 (default), whatever is configured in the above described attributes 
   * is transmitted "as is" by the driver. Also, in the transaction object
   * generated by monitor, the monitor populates these attributes "as is", as seen on
   * the interface. <br>
   * If this bit is set to 0, these attributes must be stored right-justified by
   * the user. The driver will drive the data on the correct lanes. Also, in the 
   * transaction object generated by monitor, the monitor populates these attributes 
   * right-justified. Note that in case of address of the transaction not aligned to 
   * the data size of the transaction, these attributes should correspond to the 
   * address from data size boundary up to next data size boundary. <br>
   *
   * Refer to the documentation of above mentioned attributes and User guide for more details.
   * <b>type:</b> Static
   */
  rand bit wysiwyg_enable = 1;

  /**
   * @groupname chi_config_reordering
   * Specifies the reordering algorithm used for reordering the 
   * DAT flits of the transactions.
   * Applicable only in active mode.
   * Currently supported for active RN and ICN Full-Slave mode.
   * In case of ICN Full-Slave mode, only ROUND_ROBIN and RANDOM reordering
   * algorithms are supported.
   */
  rand chi_reordering_algorithm_enum dat_flit_reordering_algorithm = ROUND_ROBIN;

  /**
    * @groupname chi_generic_config
    * If set to svt_chi_node_configuration::RESET_ALL_XACT,all transactions which have
    * already started along with the ones which have not yet started but are
    * present in the internal queue are ABORTED.
    * If set to svt_chi_node_configuration::EXCLUDE_UNSTARTED_XACT,only those transactions
    * which have gone out on the interface will be ABORTED.
    * Configuration type: Static
    *
    * This is applicable to the Master in active mode because in passive mode
    * or for the slave all transactions which are in the queue are already started.
    * This is also applicable for interconnect VIP, in case of outstanding snoop transactions.
    */
    reset_type_enum reset_type = `SVT_CHI_NODE_CFG_DEFAULT_RESET_TYPE;

   /** 
    * @groupname chi_config_reordering
    * The number of transactions at a node with pending DAT flits
    * to be transmitted that can be reordered. 
    * A node that processes all transactions in order 
    * has a DAT flit reordering depth of one.
    * Applicable only in active mode.<br>
    * Currently supported for Write, snoop DAT flits from active RN. <br>
    * Also supported in ICN Full-Slave mode for Read DAT flits. <br>
    * <b>min val:</b> 1
    * <b>max val:</b> \`SVT_CHI_MAX_DAT_FLIT_REORDERING_DEPTH (user re-definable macro with value `SVT_CHI_MAX_DAT_FLIT_REORDERING_DEPTH)
    * <b>type:</b> Static 
    */
  rand int unsigned dat_flit_reordering_depth = 1;

  /**
   * @groupname chi_config_reordering
   * Applicable only in active mode when svt_chi_node_configuration::dat_flit_reordering_algorithm is
   * set to svt_chi_node_configuration::PRIORITIZED.
   * This attribute indicates the number of unsuccessful attempts after which a given transaction within
   * svt_chi_node_configuration::dat_flit_reordering_depth is expected to get lock to the DAT VC.
   * This mechanism is useful to bail out the transactions that are waiting for access to DAT VC, but unable
   * to get the access due to low QoS value compared to other transactions within 
   * svt_chi_node_configuration::dat_flit_reordering_depth for the number of times defined by this attribute. <br>
   * Applicable only in active mode for RN.<br>
   * <b> min val:</b> 1
   * <b> max val:</b> \`SVT_CHI_MAX_XACT_DAT_VC_ACCESS_FAIL_MAX_COUNT (user re-definable macro with value `SVT_CHI_MAX_XACT_DAT_VC_ACCESS_FAIL_MAX_COUNT)
   * <b> type:</b> Static
   */
  rand int unsigned xact_dat_vc_access_fail_max_count = `SVT_CHI_REASONABLE_XACT_DAT_VC_ACCESS_FAIL_MAX_COUNT;
  
  /**
   * @groupname chi_config_reordering
   * Specifies the reordering algorithm used for reordering the 
   * RSP flits of the transactions.
   * Applicable only in active mode.
   * Currently supported for Snoop RSP flits from active RN and Write RSP
   * flits from ICN Full-Slave mode.
   * In case of ICN Full-Slave mode, only ROUND_ROBIN and RANDOM reordering
   * algorithms are supported.
   */
  rand chi_reordering_algorithm_enum rsp_flit_reordering_algorithm = ROUND_ROBIN;

  /** 
    * @groupname chi_config_reordering
    * The number of transactions at a node with pending RSP flits
    * to be transmitted that can be reordered. 
    * A node that processes all transactions in order 
    * has a RSP flit reordering depth of one.
    * Applicable only in active mode. <br>
    * Currently supported for snoop RSP flits from active RN. <br>
    * Also supported in ICN Full-Slave mode for Write RSP flits. <br>
    * <b>min val:</b> 1
    * <b>max val:</b> \`SVT_CHI_MAX_RSP_FLIT_REORDERING_DEPTH (user re-definable macro with value `SVT_CHI_MAX_RSP_FLIT_REORDERING_DEPTH)
    * <b>type:</b> Static 
    */
  rand int unsigned rsp_flit_reordering_depth = 1;

  /**
   * @groupname chi_config_reordering
   * Applicable only in active mode when svt_chi_node_configuration::rsp_flit_reordering_algorithm is
   * set to svt_chi_node_configuration::PRIORITIZED.
   * This attribute indicates the number of unsuccessful attempts after which a given transaction within
   * svt_chi_node_configuration::rsp_flit_reordering_depth is expected to get lock to the RSP VC.
   * This mechanism is useful to bail out the transactions that are waiting for access to RSP VC, but unable
   * to get the access due to low QoS value compared to other transactions within 
   * svt_chi_node_configuration::rsp_flit_reordering_depth for the number of times defined by this attribute. <br>
   * Applicable only in active mode for SNP RSP flits of RN.<br>
   * - <b> min val:</b> 1
   * - <b> max val:</b> \`SVT_CHI_MAX_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT (`SVT_CHI_MAX_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT)
   * - Default value is \`SVT_CHI_REASONABLE_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT (`SVT_CHI_REASONABLE_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT)
   * .
   * <b> type:</b> Static
   */
  rand int unsigned xact_rsp_vc_access_fail_max_count = `SVT_CHI_REASONABLE_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT;  

  /** 
   * @groupname chi_config_link_layer
   * Controls the TX***FLITPEND assertion for all the Virtual Channels of the CHI node that uses this 
   * configuration object. <br>
   * - This is applicable for CHI RN, SN and Interconnect VIP components in active mdoe.
   * - <b> Configuration Type: Static </b>
   * .
   */
  rand chi_flitpend_assertion_policy_enum flitpend_assertion_policy = FLIT_AND_LCRD_AVAILABLE;

  /** 
   * @groupname chi_config_link_layer
   * Configuration that set the start value for the medium range of the L-credit
   * for all the Tx and Rx Virtual Channels of the CHI node that uses this 
   * configuration object. 
   */
  rand int advertised_curr_l_credit_medium_range_start_value = `SVT_CHI_DEFAULT_ADV_CURR_LCRD_MED_RANGE_START_VAL; 

  /** 
   * @groupname chi_config_link_layer
   * Configuration that set the start value for the high range of the L-credit
   * for all the Tx and Rx Virtual Channels of the CHI node that uses this 
   * configuration object.
   */
  rand int advertised_curr_l_credit_high_range_start_value = `SVT_CHI_DEFAULT_ADV_CURR_LCRD_HIGH_RANGE_START_VAL; 

  /** 
   * @groupname chi_link_layer_vc_idle_value
   * Controls the idle value that to be driven on TXREQFLITPEND and TXREQFLIT signals of request virtual channel of the CHI node on power-up/reset. 
   * NOTE:
   * - Applicable only for ACTIVE RN.
   * - Currently supported idle_value for req_vc_idle_val is INACTIVE_LOW_VAL and INACTIVE_X_VAL
   * - <b> Configuration Type: Static </b>
   * - Default value is INACTIVE_LOW_VAL
   * .
   */
  rand idle_val_enum req_vc_idle_val = INACTIVE_LOW_VAL;

  /** 
   * @groupname chi_link_layer_vc_idle_value
   * Controls the idle value that to be driven on TXDATFLITPEND and TXDATFLIT signals of data virtual channel of the CHI node on power-up/reset. 
   * NOTE:
   * - Applicable only for ACTIVE RN.
   * - Currently supported idle_value for dat_vc_idle_val is INACTIVE_LOW_VAL and INACTIVE_X_VAL
   * - <b> Configuration Type: Static </b>
   * - Default value is INACTIVE_LOW_VAL
   * .
   */
  rand idle_val_enum dat_vc_idle_val = INACTIVE_LOW_VAL;

  /** 
   * @groupname chi_link_layer_vc_idle_value
   * Controls the idle value that to be driven on TXRSPFLITPEND and TXRSPFLIT signals of response virtual channel of the CHI node on power-up/reset. 
   * NOTE:
   * - Applicable only for ACTIVE RN.
   * - Currently supported idle_value for rsp_vc_idle_val is INACTIVE_LOW_VAL and INACTIVE_X_VAL
   * - <b> Configuration Type: Static </b>
   * - Default value is INACTIVE_LOW_VAL
   * .
   */
  rand idle_val_enum rsp_vc_idle_val = INACTIVE_LOW_VAL;

  /** 
   * Configuration that indicates critical chunk fist wrap order supported by the transmitter
   * - when set to CCF_WRAP_ORDER_TRUE : Transmitter will send the data packets in ccf wrap order
   * - when set to CCF_WRAP_ORDER_FALSE: Transmitter does not send the data packets in ccf wrap order
   * - This is applicable for CHI RN and SN components.
   * - <b> Configuration Type: Static </b>
   * - Default value is CCF_WRAP_ORDER_TRUE
   * .
   */
  rand ccf_wrap_order_enum tx_ccf_wrap_order_enable = CCF_WRAP_ORDER_TRUE;

  /** 
   * Configuration that indicates critical chunk fist wrap order supported by the receiver
   * - when set to CCF_WRAP_ORDER_TRUE : Receiver requires the data packets to be received in ccf wrap order
   * - when set to CCF_WRAP_ORDER_FALSE: Receiver does not require the data packets to be received in ccf wrap order
   * - This is applicable for CHI RN and SN components.
   * - <b> Configuration Type: Static </b>
   * - Default value is CCF_WRAP_ORDER_TRUE
   * .
   */
  rand ccf_wrap_order_enum rx_ccf_wrap_order_enable = CCF_WRAP_ORDER_TRUE;
  
  /**
   * Specifies the Flit buffer size of RX RSP VC. The buffer size correspond to L-credit
   * for the VC.<br>
   * SN nodes does not have RX RSP VC, this field must be set to 0 for SN node.
   * - <b>min val:</b> 1 
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_FLIT_BUFFER_SIZE (`SVT_CHI_MAX_FLIT_BUFFER_SIZE)
   * - Default value is defined by the macro \`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE (`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE)
   * - <b>type:</b> Static
   * .
   */ 
   rand int unsigned rx_rsp_vc_flit_buffer_size = `SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE;
   
  /**
   * Specifies the Flit buffer size of RX DAT VC. The buffer size correspond to L-credit
   * for the VC.<br>
   * - <b>min val:</b> 1
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_FLIT_BUFFER_SIZE (`SVT_CHI_MAX_FLIT_BUFFER_SIZE).
   * -  Default value is \`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE (`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE)
   * - <b>type:</b> Static
   * .
   */ 
   rand int unsigned rx_dat_vc_flit_buffer_size = `SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE;
   
  /**
   * Specifies the Flit buffer size of RX SNP VC. The buffer size correspond to L-credit for the VC.<br>
   * RX SNP VC is supported for RN-F & RN-D nodes, for other nodes this filed must be set to 0. 
   * - <b>min val:</b> 1 
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_FLIT_BUFFER_SIZE (`SVT_CHI_MAX_FLIT_BUFFER_SIZE).
   * - Default value is \`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE (`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE)
   * - <b>type:</b> Static
   * .
   */ 
   rand int unsigned rx_snp_vc_flit_buffer_size = `SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE;

   
  /**
   * Specifies the Flit buffer size of RX REQ VC. The buffer size correspond to L-credit for the VC.<br>
   * RN nodes does not have RX RSP VC, this field must be set to 0 for SN node.
   * - <b>min val:</b> 1 
   * - <b>max val:</b> Value defined by macro \`SVT_CHI_MAX_FLIT_BUFFER_SIZE (`SVT_CHI_MAX_FLIT_BUFFER_SIZE).
   * - Default value is \`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE (`SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE)
   * - <b>type:</b> Static
   * .
   */ 
   rand int unsigned rx_req_vc_flit_buffer_size = `SVT_CHI_REASONABLE_FLIT_BUFFER_SIZE;
   

  /**
   * Specifies the number of clock cycles after which link deactivation will be initiated by the node if
   * there have not been any flit transfers (TX***FLITV signals being sampled high) on any of the TX VCs, while the link is in the RUN state. <br>
   * The idle clock cycles are tracked solely based on the TX***FLITV assertions and do not take any flits that might've been buffered in the link layer into consideration. <br> 
   * A value less than or equal to 0 means that this feature is turned off and the link should not be deactivated in case of idle clock cycles. <br>
   * This attribute is currently supported by RN nodes only and must be set to -1 or 0 for all other nodes. <br>
   * - <b>min val:</b> -1
   * - <b>max val:</b> \`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIME (`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIME)
   * - Default value is -1.
   * - <b>type:</b> Static
   * .
   */
   rand int tx_link_deactivation_time = -1;

  /**
   * Specifies the number of clock cycles after which an RX VC must send credits when
   * they are available. This value is used to implement the
   * svt_chi_link_err_check::rx_no_lcredit_issued_for_flit_type check.<br>
   * A value of -1 means that the protocol check will never fail (checking is disabled).
   * - <b>min val:</b> -1
   * - <b>max val:</b> \`SVT_CHI_MAX_VAL_RX_VC_CREDIT_TRANSMISSION_TIMEOUT.
   * - Default value is `SVT_CHI_MAX_VAL_RX_VC_CREDIT_TRANSMISSION_TIMEOUT.
   * - <b>type:</b> Dynamic
   * .
   */
  rand int rx_vc_credit_transmission_timeout = `SVT_CHI_MAX_VAL_RX_VC_CREDIT_TRANSMISSION_TIMEOUT;

  /**
   * Specifies the number of clock cycles after which the transmitter must be in the
   * active state when receiving an activation request.<br>
   * A value of -1 means that the protocol check will never fail (checking is disabled).
   * - <b>min val:</b> -1
   * - <b>max val:</b> \`SVT_CHI_MAX_VAL_FOR_LINK_ACTIVATION_TIMEOUT (`SVT_CHI_MAX_VAL_FOR_LINK_ACTIVATION_TIMEOUT)
   * - Default value is -1.
   * - <b>type:</b> Static
   * .
   */
   rand int tx_link_activation_timeout = -1;


  /**
   * Specifies the number of clock cycles after which the transmitter must be in the
   * deactive state when receiving an deactivation request.<br>
   * A value of -1 means that the protocol check will never fail (checking is disabled).
   * - <b>min val:</b> -1
   * - <b>max val:</b> \`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIMEOUT (`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIMEOUT)
   * - Default value is -1.
   * - <b>type:</b> Static
   * .
   */
   rand int tx_link_deactivation_timeout = -1;

  /**
    * Enables streaming ordered writeunique transactions by using the
    * ReqOrder/ExpCompAck flow for WRITEUNIQUE transactions. This enables the
    * assertion of ReqOrder and ExpCompAck in WRITEUNIQUE transactions. When
    * used in active mode, when this parameter is set, not all transactions
    * will have this flow enabled. It will be enabled for some transactions
    * based on randomization. If all WRITEUNIQUE transactions require this
    * flow, this parameter must be enabled and the corresponding properties in
    * the transaction should be constrained to assert ReqOrder and
    * ExpCompAck.
    * When used in passive mode, this parameter needs to be set to recognize
    * WRITEUNIQUE transactions that use the streaming ordered flow.
    */
   rand bit streaming_ordered_writeunique_enable = 1;

   /**
     * Enables the optimized flow for streaming order writeunique. Applicable
     * only if #streaming_ordered_writeunique_enable is set. In the optimized
     * flow, an RN will wait for DBIDRESP for a previously ordered WRITEUNIQUE 
     * in the same stream and to the same destination, but will not wait for
     * DBIDRESP if the previously ordered WRITEUNIQUE is to a different
     * destination. Only one RN in a system should have this parameter set.
     */
   rand bit optimized_streaming_ordered_writeunique_enable = 0;

`ifdef SVT_CHI_ISSUE_D_ENABLE  

  /**
    * Enables streaming ordered writenosnp transactions by using the
    * ReqOrder/ExpCompAck flow for WRITENOSNP transactions. This enables the
    * assertion of ReqOrder and ExpCompAck in WRITENOSNP transactions. When
    * used in active mode, when this parameter is set, not all transactions
    * will have this flow enabled. It will be enabled for some transactions
    * based on randomization. If all WRITENOSNP transactions require this
    * flow, this parameter must be enabled and the corresponding properties in
    * the transaction should be constrained to assert ReqOrder and
    * ExpCompAck.
    * When used in passive mode, this parameter needs to be set to recognize
    * WRITENOSNP transactions that use the streaming ordered flow.
    */
   rand bit streaming_ordered_writenosnp_enable = 1;

   /**
     * Enables the optimized flow for streaming order writenosnp. Applicable
     * only if #streaming_ordered_writenosnp_enable is set to 1. In the optimized
     * flow, an RN will wait for DBIDRESP for a previously ordered WRITENOSNP 
     * in the same stream and to the same destination, but will not wait for
     * DBIDRESP if the previously ordered WRITENOSNP is to a different
     * destination. Only one RN in a system should have this parameter set.
     */
   rand bit optimized_streaming_ordered_writenosnp_enable = 0;

   /**
     * - Enables MPAM feature for the node.
     * - The parameter can be set to 1 only when #chi_spec_revision is set to ISSUE_D or later
     *   and the compile time macro \`SVT_CHI_MPAM_WIDTH_ENABLE is defined.
     * - Default value: `SVT_CHI_NODE_CFG_DEFAULT_ENABLE_MPAM, is controlled through user re-definable macro \`SVT_CHI_NODE_CFG_DEFAULT_ENABLE_MPAM.
     * - <b>type:</b> Static
     * .
     */
   rand bit enable_mpam = `SVT_CHI_NODE_CFG_DEFAULT_ENABLE_MPAM;

   /**
     * Enables the generation and processing of CleansharedPersistSep and Combined Write_CleanSharedPersistSep transactions. <br> 
     * When the value is set to 1,
     * - Active RN will be able to generate and receive the response of these transactions.
     * - Passive RN will be able to receive and process these transactions.
     * .
     * This parameter can be set to 1 only when chi_spec_revision is set to ISSUE_D or later and the compile time macro
     * \`SVT_CHI_ISSUE_D_ENABLE is defined. However, Combined Write_CleanSharedPersistSep transactions will be enabled only when chi_spec_revision is set to ISSUE_E or later and the compile time macro \`SVT_CHI_ISSUE_E_ENABLE is defined. <br>
     * Applicable for RN only. <br>
     * Default value: `SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE, is controlled through user re-definable macro \`SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE.
     */
   rand bit cleansharedpersistsep_xact_enable = `SVT_CHI_NODE_CFG_DEFAULT_CLEANSHAREDPERSISTSEP_XACT_ENABLE;

  /**
    * Enables users to configure return_nid field in the CleanSharedPersistSep transaction handle generated from RN in case of RN-SN back-to-back setup. <br>
    * When set to 1, users can configure the return_nid in CleanSharedPersistSep transaction. The RN will expect the PERSIST response to have the target_Id set to return_nid programmed in the request. <br>
    * When Set to 0, return_nid value in CleanSharedPersistSep transaction will be 0. <br>
    * This can be set to value 1 only when 
    * - RN and SN are connected back to back i.e. when num_rn =1, num_sn =1 and num_hn =0. <br>
    * - svt_chi_node_configuration::cleansharedpersistsep_xact_enable is set to 1 for RN. <br>
    * .
    * Applicable only for RN.
    */
   bit valid_return_nid_in_cspsep_from_rn_to_sn_enable =0;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
X0n/KRbFuCKfTQVQoRMg/b2lelpt/BRG+aMcXFHOvFt4khD0Y5MYjR5w2eYpVe3N
1GxkpyczYf8HRlQ4i0T9WAkN6TL7kjcbOpR4N0PcNtHjFfhTjTQbgfCMviE4LuG7
c2YPpJJjYhkI222DNJcFCEFUm/Lmi9ETVnluz+bmDNR15QHinLzzhQ==
//pragma protect end_key_block
//pragma protect digest_block
Y+rjycz1OzGIcxE/E3Ndj682Rnw=
//pragma protect end_digest_block
//pragma protect data_block
GmDzPKaUGeYB6HJmKersEnz3984T1skaqD3e7W24C84tTsbwJlRitTM4dWdtN+UB
f+M/yLiLClwG95lqiH5v9T586VIqdNFh8UwsPyyo5L9mWq1LArAPCjbfAtNrI+kR
YcTj36ZrGjAcHacvUoBft7zBrrOA8ypC2vCq0/J8W/1TOGGiRTHcUiPr3Tve3Kgb
1HfPjr12623mMslRz21g9abSWFLF/83zWneqiqxY8zQYu0da85gD6DwiN7mgFYkc
kzxw53jOW7jX9D5duTCUWc8CwMvkR7eUp9WjQF9lIRATn1G+M8qM9JAWW/xrh60n
g5aiYQ8AcaTKDmsVc3U+4o5ddzU/NwYmGlxH2375kL+XrXfxOLdP80YPbK0QAkJ2
O7a6DobijmoKsNlfm7mD945vRjABDoqNbAVJshsrT5hyHlUNj6xc61DvlhWTNf1E
0LhC5VnnolG+Ia3DkDnLXjITyOVMyPJC/B7dNIyeRCBnxvKxrnwPltaCcdGXz2eW
P3GVCSCsAe4ehsxz0TjQRUScz8UX5z6AsmxxQ/xbe/n+zZOKetNlb9qlkmXhCqq8
8lmT+1IcXlFCcQ2u/dhgb7l7yk1fZWloOdnsAu6Yi7dbAz2nP7BMg3bLcOA7A3B2
rkdVxpiK/43sPucnl/vGF0vTGv6CMnyEi4Ow4ffjjQnSX1Vzz7yun31J2SNuwlf0
gHeKlA7uuABqNvyu//+WWz4HQYRgDJa8iKwKl56xgilnN3vk/EdKThn20l9J54YQ
O+SVIfExBiGMkGik3Y6GZzWjymLpIIo0qT57UKp1/xeyBeSCt4QxXYnGP+yoXXss
OWRKwTNua57QYUf5ZNAubB9OifSxRRxaBgLFpQafYxh1W/RXllJLtYnjImk0ppyj
cUmiOWy1T5jGv8K1zzZeqFgWMUtITc26lWsMzoq9BF0=
//pragma protect end_data_block
//pragma protect digest_block
7sGo4XDbw3u4FJZClMH8OvL6iH0=
//pragma protect end_digest_block
//pragma protect end_protected



`endif //issue_d_enable

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /**
    * Enables streaming ordered flow for Combined WriteNoSnp and CMO type transactions with ReqOrder and ExpCompAck set.
    * When used in active mode, when this parameter is set, not all transactions will have this flow enabled, but enabled for some transactions
    * based on randomization. If all  Combined WriteNoSnp and CMO type transactions require this flow, this parameter must be enabled and 
    * the corresponding properties in the transaction should be constrained to assert ReqOrder and ExpCompAck.
    * When used in passive mode, this parameter needs to be set to recognize
    * Combined WriteNoSnp and CMO type transactions that use the streaming ordered flow.
    */
   rand bit streaming_ordered_combined_writenosnp_cmo_enable = 1;

   /**
     * Enables the optimized flow for streaming order Combined WriteNoSnp and CMO type transactions. Applicable
     * only if #streaming_ordered_combined_writenosnp_cmo_enable is set to 1. In the optimized
     * flow, an RN will wait for DBIDRESP for a previously ordered Combined WriteNoSnp and CMO type transaction 
     * in the same stream and to the same destination, but will not wait for
     * DBIDRESP if the previously ordered WRITENOSNP is to a different
     * destination. Only one RN in a system should have this parameter set.
     */
   rand bit optimized_streaming_ordered_combined_writenosnp_cmo_enable = 0;

  /**
    * Enables streaming ordered flow for Combined WriteUnique and CMO type transactions with ReqOrder and ExpCompAck set.
    * When used in active mode, when this parameter is set, not all transactions will have this flow enabled, but enabled for some transactions
    * based on randomization. If all  Combined WriteUnique and CMO type transactions require this flow, this parameter must be enabled and 
    * the corresponding properties in the transaction should be constrained to assert ReqOrder and ExpCompAck.
    * When used in passive mode, this parameter needs to be set to recognize
    * Combined WriteUnique and CMO type transactions that use the streaming ordered flow.
    */
   rand bit streaming_ordered_combined_writeunique_cmo_enable = 1;

   /**
     * Enables the optimized flow for streaming order  Combined WriteUnique and CMO type transactions. Applicable
     * only if #streaming_ordered_combined_writeunique_cmo_enable is set to 1. In the optimized
     * flow, an RN will wait for DBIDRESP for a previously ordered Combined WriteUnique and CMO type transaction 
     * in the same stream and to the same destination, but will not wait for
     * DBIDRESP if the previously ordered Combined WriteUnique and CMO type transaction is to a different
     * destination. Only one RN in a system should have this parameter set.
     */
   rand bit optimized_streaming_ordered_combined_writeunique_cmo_enable = 0;

   /** Specifies the behavior of RN when NON_DATA_ERROR is observed in the response. <br>
     * When set to CHI_D_OR_EARLIER SPEC BEHAVIOR, the VIP RN will ignore the NON_DATA_ERROR response and will consider the transaction 
     * to have completed successfully. In case of allocating transactions the line will be allocated. In case of SnpResp the final cache line
     * state may not be Invalid, it will be same as final state indicated in the snoop response. <br>
     * When set to CHI_E_SPEC_BEHAVIOR, the VIP RN will not upgrade the cache state at the end of transaction when NON_DATA_ERROR was received.
     * In case of allocating transactions, the final cache line state will remain unchanged i.e. same as initial cache line state. In case of Snoops,
     * if a SnpResp is sent with NON_DATA_ERROR, the final state will always be set to I and the line will be invalidated at the responding RN. 
     * The functionality associated with value CHI_E_SPEC_BEHAVIOR will only come to effect when chi_spec_revision is greater then or equal to ISSUE_E.
     */
   nderr_resp_policy_enum nderr_resp_policy = `SVT_CHI_NODE_CFG_DEFAULT_NDERR_RESP_POLICY;

   /**
     * - Defines the mode of SLC Replacement hint feature for the node.
     * - The parameter is only applicable when #chi_spec_revision is set to ISSUE_E or later.
     * - Applicable only for RN.
     * - SLC_REP_HINT_DISABLED          : The node doesn't supports SLC replacement Hint feature and RN drive slcrephint_replacement feilds to zero.
     * - SLC_REP_HINT_SPEC_RECOMMENDED  : The node supports SLC replacement Hint feature and RN drive slcrephint_replacement feild according to the spec recommendation and will not take reserved values.
     * - SLC_REP_HINT_USER_DEFINED      : The node supports SLC replacement Hint feature and RN drive slcrephint_replacement feild in full range. 
     * - Default value is SLC_REP_HINT_DISABLED
     * - <b>type:</b> Static
     * .
     */
   rand slcrephint_mode_enum slcrephint_mode = SLC_REP_HINT_DISABLED;

`endif //issue_e_enable

  /** 
    * This attribute indicates that it is expected/permitted for the slave node to receive a Read followed by a Write from the Home node corresponding to a Partial Write 
    * transaction that is issued by a Requester. This attribute is currently used by the system monitor only to determine if it should try to associate Partial Write 
    * issued by the requester to a slave Read as well as a slave Write transaction.<br>
    * In cases of Read modify Write scenarios where the Partial write transaction such as WRITEUNIQUEPTL, WRITEBACKPTL, WRITEUNIQUEPTLSTASH, WRITENOSNPPTL from master results
    * into a slave READ followed by a slave WRITE transaction from the interconnect, when this attribute is set to 1, the system monitor will try to associate a slave Read 
    * as well as a slave Write with the Partial Write transaction at the requester.<br>
    * When this attribute is set to 0, the system monitor will only try to associate a slave Write with the Partial Write transaction at the requester.<br>
    * Applicable only for Slave component.
    */
  bit expect_slave_read_followed_by_slave_write_for_partial_writes_from_rn =0;

   /**
     * @groupname chi_config_delays
     * Specifies the minimum delay for the assertion of RXREQLCRDV.  The delay
     * is calculated from the time the last request flit (RXREQFLITV) was
     * received or the last time RXREQLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_req_flit_to_lcrd_min_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the maximum delay for the assertion of RXREQLCRDV.  The delay
     * is calculated from the time the last request flit (RXREQFLITV) was
     * received or the last time RXREQLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_req_flit_to_lcrd_max_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the minimum delay for the assertion of RXRSPLCRDV.  The delay
     * is calculated from the time the last response flit (RXRSPFLITV) was
     * received or the last time RXRSPLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_rsp_flit_to_lcrd_min_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the maximum delay for the assertion of RXRSPLCRDV.  The delay
     * is calculated from the time the last response flit (RXRSPFLITV) was
     * received or the last time RXRSPLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_rsp_flit_to_lcrd_max_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the minimum delay for the assertion of RXDATLCRDV.  The delay
     * is calculated from the time the last dat flit (RXDATFLITV) was
     * received or the last time RXDATLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_dat_flit_to_lcrd_min_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the maximum delay for the assertion of RXDATLCRDV.  The delay
     * is calculated from the time the last dat flit (RXDATFLITV) was
     * received or the last time RXDATLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_dat_flit_to_lcrd_max_delay = 0;

   /**
     * Specifies the minimum delay for the assertion of RXSNPLCRDV.  The delay
     * is calculated from the time the last snp flit (RXSNPFLITV) was
     * received or the last time RXSNPLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_snp_flit_to_lcrd_min_delay = 0;

   /**
     * @groupname chi_config_delays
     * Specifies the maximum delay for the assertion of RXSNPLCRDV.  The delay
     * is calculated from the time the last snp flit (RXSNPFLITV) was
     * received or the last time RXSNPLCRDV was asserted, whichever occured
     * last.  The node applies a delay between the min and max range. 
     */
   rand int rcvd_snp_flit_to_lcrd_max_delay = 0;

   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the minimum number of clock cycles the txsactive signal can be asserted speculatively
    * - Once VIP driver speculatively asserts txsactive, it is asserted for a random number of clock cycles within  
    *   the range [#min_num_speculative_txsactive_assertion_cycles:#max_num_speculative_txsactive_assertion_cycles],
    *   and then gets deasserted. While this delay is getting applied, if txsactive is deasserted due to end of 
    *   protocol layer activity, the delay will not be continued as the txsactive is already deasserted. 
    *   - This behavior is applicable only when #max_num_speculative_txsactive_assertion_cycles > 0. 
    *   - Also, #max_num_speculative_txsactive_assertion_cycles must be >= #min_num_speculative_txsactive_assertion_cycles
    *   - Note that the the speculative assertion will be exercised only when corresponding speculative txsactive deassertion cycle
    *     parameters #min_num_speculative_txsactive_deassertion_cycles, #max_num_speculative_txsactive_deassertion_cycles 
    *     are programmed appropriately such that speculative deassertion is also possible.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: \`SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES]
    * - Applicable irrespective of link active state.
    * - <b>type:</b> Static
    * .
    */
   rand int unsigned min_num_speculative_txsactive_assertion_cycles = `SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES;
 
   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the maximum number of clock cycles the txsactive signal can be asserted speculatively
    * - Once VIP driver speculatively asserts txsactive, it is asserted for a random number of clock cycles within  
    *   the range [#min_num_speculative_txsactive_assertion_cycles:#max_num_speculative_txsactive_assertion_cycles],
    *   and then gets deasserted. While this delay is getting applied, if txsactive is deasserted due to end of 
    *   protocol layer activity, the delay will not be continued as the txsactive is already deasserted. 
    *   - This behavior is applicable only when #max_num_speculative_txsactive_assertion_cycles > 0. 
    *   - Also, #max_num_speculative_txsactive_assertion_cycles must be >= #min_num_speculative_txsactive_assertion_cycles
    *   - Note that the the speculative assertion will be exercised only when corresponding speculative txsactive deassertion cycle
    *     parameters #min_num_speculative_txsactive_deassertion_cycles, #max_num_speculative_txsactive_deassertion_cycles 
    *     are programmed appropriately such that speculative deassertion is also possible.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: \`SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES]
    * - Applicable irrespective of link active state.
    * - <b>type:</b> Static
    * .
    */ 
   rand int unsigned max_num_speculative_txsactive_assertion_cycles = `SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES;

   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the minimum number of clock cycles the txsactive signal can be deasserted speculatively
    * - Once VIP driver speculatively deasserts txsactive, it is deasserted for a random number of clock cycles within  
    *   the range [#min_num_speculative_txsactive_deassertion_cycles:#max_num_speculative_txsactive_deassertion_cycles],
    *   and then gets asserted. While this delay is getting applied, if txsactive is asserted due to start of 
    *   protocol layer activity, the delay will not be continued as the txsactive is already asserted. 
    *   - This behavior is applicable only when #max_num_speculative_txsactive_deassertion_cycles > 0. 
    *   - Also, #max_num_speculative_txsactive_deassertion_cycles must be >= #min_num_speculative_txsactive_deassertion_cycles
    *   - Note that the the speculative deassertion will be exercised only when corresponding speculative txsactive assertion cycle
    *     parameters #min_num_speculative_txsactive_assertion_cycles, #max_num_speculative_txsactive_assertion_cycles 
    *     are programmed appropriately such that speculative assertion is also possible.
    *   - Note that the the deassertion will not take place if there is any protocol layer activity pending after these cycles of delay.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: \`SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES]
    * - Applicable irrespective of link active state.
    * - <b>type:</b> Static
    * .
    */  
   rand int unsigned min_num_speculative_txsactive_deassertion_cycles = `SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES;

   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the maximum number of clock cycles the txsactive signal can be deasserted speculatively
    * - Once VIP driver speculatively deasserts txsactive, it is deasserted for a random number of clock cycles within  
    *   the range [#min_num_speculative_txsactive_deassertion_cycles:#max_num_speculative_txsactive_deassertion_cycles],
    *   and then gets asserted. While this delay is getting applied, if txsactive is asserted due to start of 
    *   protocol layer activity, the delay will not be continued as the txsactive is already asserted. 
    *   - This behavior is applicable only when #max_num_speculative_txsactive_deassertion_cycles > 0. 
    *   - Also, #max_num_speculative_txsactive_deassertion_cycles must be >= #min_num_speculative_txsactive_deassertion_cycles
    *   - Note that the the speculative deassertion will be exercised only when corresponding speculative txsactive assertion cycle
    *     parameters #min_num_speculative_txsactive_assertion_cycles, #max_num_speculative_txsactive_assertion_cycles 
    *     are programmed appropriately such that speculative assertion is also possible.
    *   - Note that the the deassertion will not take place if there is any protocol layer activity pending after these cycles of delay.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: `SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES]
    * - Applicable irrespective of link active state.
    * - <b>type:</b> Static
    * .
    */   
   rand int unsigned max_num_speculative_txsactive_deassertion_cycles = `SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES;


   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the minimum number of clock cycles the txsactive signal assertion can be extended at the end
    *   a transaction, i.e. after the final completion flit of a transaction.
    * - Once VIP driver determines that it's required to deassert txsactive at the end of a transaction after corresponding final completion
    *   flit is generated/observed, it is continued to be asserted for an additional random number of clock cycles within  
    *   the range [#min_num_end_of_xact_txsactive_extended_assertion_cycles:#max_num_end_of_xact_txsactive_extended_assertion_cycles],
    *   and then gets deasserted.
    *   - This behavior is applicable only when #max_num_end_of_xact_txsactive_extended_assertion_cycles > 0. 
    *   - Also, #max_num_end_of_xact_txsactive_extended_assertion_cycles must be >= #min_num_end_of_xact_txsactive_extended_assertion_cycles
    *   - Note that the the deassertion will not take place if there is any protocol layer activity pending after these cycles of delay.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: \`SVT_CHI_MIN_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MIN_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES]
    * - <b>type:</b> Static
    * .
    */   
   rand int unsigned min_num_end_of_xact_txsactive_extended_assertion_cycles = `SVT_CHI_MIN_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES;

   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the maximum number of clock cycles the txsactive signal assertion can be extended at the end
    *   a transaction, i.e. after the final completion flit of a transaction.
    * - Once VIP driver determines that it's required to deassert txsactive at the end of a transaction after corresponding final completion
    *   flit is generated/observed, it is continued to be asserted for an additional random number of clock cycles within  
    *   the range [#min_num_end_of_xact_txsactive_extended_assertion_cycles:#max_num_end_of_xact_txsactive_extended_assertion_cycles],
    *   and then gets deasserted.
    *   - This behavior is applicable only when #max_num_end_of_xact_txsactive_extended_assertion_cycles > 0. 
    *   - Also, #max_num_end_of_xact_txsactive_extended_assertion_cycles must be >= #min_num_end_of_xact_txsactive_extended_assertion_cycles
    *   - Note that the the deassertion will not take place if there is any protocol layer activity pending after these cycles of delay.
    *   - This behavior is supported only for active RN, and Interconnect VIP in Full Slave mode.
    *   .
    * - Default value: \`SVT_CHI_MAX_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES (0)
    * - This attribute can take a value in the range [0:\`SVT_CHI_MAX_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES]
    * - <b>type:</b> Static
    * .
    */    
   rand int unsigned max_num_end_of_xact_txsactive_extended_assertion_cycles = `SVT_CHI_MAX_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES;
  
   
   /** 
    * @groupname chi_config_txsactive_delays
    * - Specifies the maximum number of clock cycles the sactive signal is asserted. 
    * - Used for the coverage related to sactive signals.This parameter #max_num_clock_cycles_speculative_sactive_signal_asserted is used to 
    *   generate bins for speculative SACTIVE signal assertion clock cycles, bins will range from min(1) to #max_num_clock_cycles_speculative_sactive_signal_asserted. 
    * - #max_num_clock_cycles_speculative_sactive_signal_asserted can be set by defining the macro \`SVT_CHI_MAX_NUM_CLOCK_CYCLES_SPECULATIVE_SACTIVE_SIGNAL_ASSERTED to required value.
    * - Default value: \`SVT_CHI_MAX_NUM_CLOCK_CYCLES_SPECULATIVE_SACTIVE_SIGNAL_ASSERTED (0)
    * - <b>type:</b> Static
    * .
    */    
   int unsigned max_num_clock_cycles_speculative_sactive_signal_asserted = `SVT_CHI_MAX_NUM_CLOCK_CYCLES_SPECULATIVE_SACTIVE_SIGNAL_ASSERTED;

   /**
     * Specifies the minimum delay for the assertion of TXLINKACTIVEREQ.  
     */
   int txla_req_assertion_min_delay = `SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY;

   /**
     * Specifies the maximum delay for the assertion of TXLINKACTIVEREQ.  
     */
   int txla_req_assertion_max_delay = `SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of TXLINKACTIVEREQ, when
     * the transmitter and Receiver links of a component are in STOP states.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #txla_req_assertion_min_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_assertion_max_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     */
   rand int txla_req_assertion_when_rx_in_stop_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in STOP state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - The assertion of TXLINKACTIVEREQ must occur before the assertion of RXLINKACTIVEACK, when transmitter link 
     *   and receiver link of a component are in STOP state and ACTIVATE state respectively. 
     *   So, txla_req_assertion_when_rx_in_activate_state_delay should be less than or equal to #rxla_ack_assertion_when_tx_in_stop_state_delay to avoid the banned state transitions as per "ARM-IHI0050B: 13.6.2".
     * - <b>min val:</b> #txla_req_assertion_min_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_assertion_max_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     */
   rand int txla_req_assertion_when_rx_in_activate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in STOP state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #txla_req_assertion_min_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_assertion_max_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     */
   rand int txla_req_assertion_when_rx_in_deactivate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in STOP state and RUN state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - Applicable only when #allow_link_active_signal_banned_output_race_transitions is set.
     * - <b>min val:</b> #txla_req_assertion_min_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_assertion_max_delay (default:`SVT_CHI_TXLA_REQ_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     */
   rand int txla_req_assertion_when_rx_in_run_state_delay;

   /**
     * Specifies the minimum delay for the deassertion of TXLINKACTIVEREQ.  
     */
   int txla_req_deassertion_min_delay = `SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY;

   /**
     * Specifies the maximum delay for the deassertion of TXLINKACTIVEREQ.  
     */
   int txla_req_deassertion_max_delay = `SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in RUN state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #txla_req_deassertion_min_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_deassertion_max_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int txla_req_deassertion_when_rx_in_activate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in RUN state and RUN state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #txla_req_deassertion_min_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_deassertion_max_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int txla_req_deassertion_when_rx_in_run_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in RUN state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - The deassertion of TXLINKACTIVEREQ must occur before the deassertion of RXLINKACTIVEACK, when transmitter link 
     *   and receiver link of a component are in RUN state and DEACTIVATE state respectively.  
     *   So, txla_req_deassertion_when_rx_in_deactivate_state_delay should be less than or equal to #rxla_ack_deassertion_when_tx_in_run_state_delay to avoid the banned state transitions as per "ARM-IHI0050B: 13.6.2".
     * - <b>min val:</b> #txla_req_deassertion_min_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_deassertion_max_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int txla_req_deassertion_when_rx_in_deactivate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of TXLINKACTIVEREQ, when
     * transmitter link and receiver link of a component are in RUN state and STOP state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - Applicable only when #allow_link_active_signal_banned_output_race_transitions is set.
     * - <b>min val:</b> #txla_req_deassertion_min_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #txla_req_deassertion_max_delay (default:`SVT_CHI_TXLA_REQ_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int txla_req_deassertion_when_rx_in_stop_state_delay;

   /**
     * Specifies the minimum delay for the assertion of RXLINKACTIVEACK.  
     */
   int rxla_ack_assertion_min_delay = `SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY;

   /**
     * Specifies the maximum delay for the assertion of RXLINKACTIVEACK.  
     */
   int rxla_ack_assertion_max_delay = `SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in STOP state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #rxla_ack_assertion_min_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_assertion_max_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_assertion_when_tx_in_stop_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of RXLINKACTIVEACK, when 
     * transmitter link and receiver link of a component are in ACTIVATE state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #rxla_ack_assertion_min_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_assertion_max_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_assertion_when_tx_in_activate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in RUN state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - The assertion of RXLINKACTIVEACK must occur before the deassertion of TXLINKACTIVEREQ, when transmitter link 
     *   and receiver link of a component are in RUN state and ACTIVATE state respectively. 
     *   So, rxla_ack_assertion_when_tx_in_run_state_delay should be less than or equal to #txla_req_deassertion_when_rx_in_activate_state_delay to avoid the banned state transitions as per "ARM-IHI0050B: 13.6.2".
     * - <b>min val:</b> #rxla_ack_assertion_min_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_assertion_max_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_assertion_when_tx_in_run_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the assertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in DEACTIVATE state and ACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - Applicable only when #allow_link_active_signal_banned_output_race_transitions is set.
     * - <b>min val:</b> #rxla_ack_assertion_min_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_assertion_max_delay (default:`SVT_CHI_RXLA_ACK_ASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_assertion_when_tx_in_deactivate_state_delay;

   /**
     * Specifies the minimum delay for the deassertion of RXLINKACTIVEACK.  
     */
   int rxla_ack_deassertion_min_delay = `SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY;

   /**
     * Specifies the maximum delay for the deassertion of RXLINKACTIVEACK.  
     */
   int rxla_ack_deassertion_max_delay = `SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in RUN state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #rxla_ack_deassertion_min_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_deassertion_max_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_deassertion_when_tx_in_run_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in DEACTIVATE state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - <b>min val:</b> #rxla_ack_deassertion_min_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_deassertion_max_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_deassertion_when_tx_in_deactivate_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in STOP state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - The deassertion of RXLINKACTIVEACK must occur before the assertion of TXLINKACTIVEREQ, when transmitter link 
     *   and receiver link of a component are in STOP state and ACTIVATE state respectively. 
     *   So, rxla_ack_deassertion_when_tx_in_stop_state_delay should be less than or equal to #txla_req_assertion_when_rx_in_deactivate_state_delay to avoid the banned state transitions as per "ARM-IHI0050B: 13.6.2".
     * - <b>min val:</b> #rxla_ack_deassertion_min_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_deassertion_max_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_deassertion_when_tx_in_stop_state_delay;

   /**
     * @groupname chi_config_delays
     * Specifies the delay in number of clock cycles to be injected before the deassertion of RXLINKACTIVEACK, when
     * transmitter link and receiver link of a component are in ACTIVATE state and DEACTIVATE state respectively.
     * 
     * NOTE:
     * - Applicable only for ACTIVE mode components.
     * - Applicable only when #delays_enable is set.
     * - Applicable only when #link_active_signal_delays_enable is set.
     * - Applicable only when #allow_link_active_signal_banned_output_race_transitions is set.
     * - <b>min val:</b> #rxla_ack_deassertion_min_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - <b>max val:</b> #rxla_ack_deassertion_max_delay (default:`SVT_CHI_RXLA_ACK_DEASSERTION_MIN_DELAY)
     * - -1: Valid only when #allow_link_active_signal_banned_output_race_transitions is set to 1.
     *       When set to this value, the driver will pickup a value randomly in the range [max val:min val] 
     * - <b>type:</b> Static
     * .
     * 
     */
   rand int rxla_ack_deassertion_when_tx_in_activate_state_delay;

   /**
     *  Genaralized maximum delay count applicable for link activity.
     */
   int link_activity_max_delay_count = `SVT_CHI_LINK_ACTIVITY_MAX_DELAY_COUNT;

   /**
     * - Maximum number of back to back cycles protocol flitv is asserted in virtual channels
     * - Should be programmed to a value greater than or equal to 2 
     * - Used only for defining the bins in coverage related to back to back cycles protocol flitv assertion
     * - Default value is \`SVT_CHI_COV_MAX_NUM_BACK2BACK_CYCLES_PROTOCOL_FLITV_ASSERTION (`SVT_CHI_COV_MAX_NUM_BACK2BACK_CYCLES_PROTOCOL_FLITV_ASSERTION), which is a user redefinable macro.
     * - <b>type:</b> Static
     * .
     */
   int cov_max_num_back2back_cycles_protocol_flitv_assertion = `SVT_CHI_COV_MAX_NUM_BACK2BACK_CYCLES_PROTOCOL_FLITV_ASSERTION;
 
   /** Defines the reference event to deassert txreq signal when RX is in deactivate state. */
            rand reference_event_for_txreq_deassertion_when_rx_is_in_deactivate_state_enum reference_event_for_txreq_deassertion_when_rx_is_in_deactivate_state = WAIT_ON_CREDIT_ACCUMULATION_BEFORE_TXREQ_DEASSERTION;
 
   /** Defines the reference event to assert txreq signal when RX is in deactivate state. */
            rand reference_event_for_txreq_assertion_when_rx_is_in_deactivate_state_enum reference_event_for_txreq_assertion_when_rx_is_in_deactivate_state = WAIT_ON_CREDIT_ACCUMULATION_BEFORE_TXREQ_ASSERTION;


`ifdef SVT_CHI_ISSUE_B_ENABLE
   /**
     * Specifies the minimum delay for the assertion of SYSCOREQ.  
     */
     int syscoreq_assertion_min_delay   = 0;

   /**
     * Specifies the maximum delay for the assertion of SYSCOREQ.  
     */
     int syscoreq_assertion_max_delay   = `SVT_CHI_SYSCOREQ_ASSERTION_MAX_DELAY;

   /**
     * Specifies the minimum delay for the deassertion of SYSCOREQ.  
     */
     int syscoreq_deassertion_min_delay = 0;

   /**
     * Specifies the maximum delay for the deassertion of SYSCOREQ.  
     */
     int syscoreq_deassertion_max_delay = `SVT_CHI_SYSCOREQ_DEASSERTION_MAX_DELAY;

   /**
     * Specifies the minimum delay for the assertion of SYSCOACK.  
     */
     int syscoack_assertion_min_delay   = 0;

   /**
     * Specifies the maximum delay for the assertion of SYSCOACK.  
     */
     int syscoack_assertion_max_delay   = `SVT_CHI_SYSCOACK_ASSERTION_MAX_DELAY;

   /**
     * Specifies the minimum delay for the deassertion of SYSCOACK.  
     */
     int syscoack_deassertion_min_delay = 0;

   /**
     * Specifies the maximum delay for the deassertion of SYSCOACK.  
     */
     int syscoack_deassertion_max_delay = `SVT_CHI_SYSCOACK_DEASSERTION_MAX_DELAY;
`endif


  /**
   * List of Home Nodes that this Slave Node maps to. This is read-only field.
   */
  int hn_map[];
  
  /** 
   * Node indices that correspond to HN-I <br>
   * This should not be updated by the user and 
   * the VIP automatically updates this once
   * HN Interface type is programmed through 
   * svt_chi_system_configuration::set_hn_interface_type(). 
   * This is read-only field.
   */
  int hn_i_node_indices[];

  /** 
   * Node indices that correspond to HN-F <br>
   * This should not be updated by the user and 
   * the VIP automatically updates this once
   * HN Interface type is programmed through 
   * svt_chi_system_configuration::set_hn_interface_type().
   * This is read-only field.
   */
  int hn_f_node_indices[];

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * List of RN nodes with cache stashing enabled. This is read-only field.
   */
  int valid_stash_tgt_id[];
`endif

  /** @cond PRIVATE */
  /** specifies cache_line size attribute for each node. For CHI, its always fixed to 64 byte */
  int cache_line_size = `SVT_CHI_CACHE_LINE_SIZE;
  /** @endcond */

  /**
    * @groupname chi_config_port_interleaving 
    * Indicates if this port is interleaved based on address to be accessed by this port.
    */
  bit port_interleaving_enable = 0;  

  /**
    * @groupname chi_config_port_interleaving
    * A unique ID for each RN/SN node that is different from the node_id when interleaving is enabled and there are multiple nodes within the same interleaved group with the same node_id.
    * - This field must be set to a unqiue value for each node in the system, when #port_interleaving_enable and svt_chi_system_configuration::allow_same_node_id_within_port_interleaving_group are set to 1. 
    * - This field need not be programmed and will be internally set to the node_id value when either #port_interleaving_enable or svt_chi_system_configuration::allow_same_node_id_within_port_interleaving_group is set to 0. 
    * - <b>type:</b> Static
    * - <b>Default value</b>:-1
    * .
    */
  int extended_node_id = -1;

  /** 
    * @groupname chi_config_port_interleaving
    * Indicates the port interleaving boundary. The value must be in form of bytes.<br>
    * For example if interleaving szie is 64 . It means interleaving boundary is 64 bytes.<br>
    * This port will access address locations based on interleaving size.<br>
    * Default value is set as 256.<br>
    * Applicable if the port_interleaving_enable is set to 1 for this port.<br>
    * <b>type:</b> Static
    */
  int port_interleaving_size = 256;

  /** 
    * @groupname chi_config_port_interleaving
    * Indicates the group id of all the ports participating in one interleaving scheme.<br>
    * All the ports which are in the same interleave group must be configured to have same 
    * port_interleave_group_id.<br>
    * Default is set to -1.<br> 
    * Applicable if the port_interleaving_enable is set to 1.<br>
    * Its value must be unique across master and slaves.<br> 
    * <b>type:</b> Static
    */
  int port_interleaving_group_id = -1;

  /** @groupname chi_config_port_interleaving 
    * Indcates that DVM transactions will be sent form this port of corresponding port interleaving group.<br>
    * This port will not take part in port interleaving for DVM transactions.<br> 
    * Applicable if port_interleaving_enable is set to 1.
    */
  bit dvm_sent_from_interleaved_port = 0;

  /** 
    * @groupname chi_config_port_interleaving
    * Indicates that non coherent device traffic will be sent from this port
    * of corresponding port interleaving group.<br>
    * This port will not take part in port interleaving for device traffic
    * as Device transaction addresses are not interleaved.<br>
    * Applicable only when the port_interleaving_enable is set to 1.
    */ 
  bit device_xact_sent_from_interleaved_port =0;

  /**  
    * @groupname chi_config_port_interleaving
    * Indicates the order of this port in a port interleaving scheme.<br>
    *  For example : If the port is 3rd in a group of 4 ports and 
    *  if port_interleaving_size of the group is 512 bytes.
    *  This port will have access to addresses with addr[10:9] == 3.<br>
    *  This parameter determines which address bits to look for an interleaved port.<br>
    *  Default value of this is set to 0.<br> 
    * <b>type:</b> Static
    */
  int port_interleaving_index = 0;

  /**
    * @groupname chi_config_port_interleaving
    * Enables port inteleaving for this port for the device type xact.<br>
    * The port configuration parameter device_xact_sent_from_interleaved_port
    * is not applicable if this bit is set to 1.<br>
    * If this bit is set to 1, the device type transaction is interleaved like 
    * any non-dvm transaction.<br>
    * Applicable only when the port_interleaving_enable is set to 1.
    */
  bit port_interleaving_for_device_xact_enable = 0;

  /**
    * @groupname chi_timeout_config
    * - This attribute indicates the number of clock cycles after which
    * the transaction timer should timeout. Transaction timer is a timer
    * which is started when the transaction request is observed and
    * reset once the transaction completes. If the transaction does not complete 
    * by the set time, an error is reported. 
    * - If this attribute is set to 0, the timer is not started.
    * - When this attribute is set to value greater than zero,
    *   - The timer is incremented by 1 for every clock cycle and is reset when the transaction ends.
    *   - Vip will continue to process the transaction even the transaction has timedout. The timeout of the transaction doesn't have any impact on the procesing or completion of the transaction.
    *   - The timer started for a transaction will continue to increment even there is a link deactivation when transaction is outstanidng.
    *   .
    * - This feature is currently not designed to handle the case's when there is a dynamic reset.
    * - when a transaction recieved a retry response, timer for that transaction is stopped. When the retried transaction is sent out a new timer will be started.
    * .
    */
  int xact_inactivity_timeout = 0;

  /**
    * @groupname chi_timeout_config
    * - This attribute indicates the number of clock cycles after which
    * the snoop transaction timer should timeout. Snoop transaction timer is a timer
    * which is started when the snoop transaction request is observed and
    * reset once the snoop transaction completes. If the snoop transaction does not complete 
    * by the set time, an error is reported. 
    * - If this attribute is set to 0, the timer is not started.
    * - When this attribute is set to value greater than zero,
    *   - The timer is incremented by 1 for every clock cycle and is reset when the snoop transaction ends.
    *   - Vip will continue to process the snoop transaction even the snoop transaction has timedout. The timeout of the snoop transaction doesn't have any impact on the procesing or completion of the snoop transaction.
    *   - The timer started for snoop transaction will continue to increment even there is a link deactivation when snoop transaction is outstanidng.
    *   .
    * - This feature is currently not designed to handle the case's when there is a dynamic reset.
    * .
    */
  int snp_xact_inactivity_timeout = 0;

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** 
    * This attribute indicates, When the node receives a snoop request with RetToSrc set to 1 and the cache line is in SC state,
    * whether the data is returned to Home node or not.
    * Default is set to FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET.<br> 
    * Applicable only for Active RN.<br>
    * The configuration #fwd_data_from_sc_state_when_rettosrc_set must be set to FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET (Default value), when SVT_CHI_ISSUE_E_ENABLE macro defined and chi_spec_revision is set to ISSUE_D or earlier. <br>
    * The configuration #fwd_data_from_sc_state_when_rettosrc_set can take any value, when chi_spec_revision is set to ISSUE_E or later. <br>
    * Currently supported only for non-fwd type Snoops and in case of forward type Snoops, data will always be fwded from SC state when RetToSrc set to 1 irrespective of this policy. <br>
    * <b>type:</b> Static
    */
  rand fwd_data_from_sc_state_when_rettosrc_set_policy_enum fwd_data_from_sc_state_when_rettosrc_set = FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET;

  /**
    * This attribute allows the snoopee to process the SnpPreferUnique request.
    * A snoopee with an ongoing exclusive transaction treats SnpPreferUnique as SnpNotSharedDirty else it treats it as a SnpUnique request.
    * When this parameter is set to SNPPREFERUNIQUE_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTY SnpPreferUnique will always be treated as SnpNotSharedDirty by the snoopee.
    * When this parameter is set to SNPPREFERUNIQUE_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE, SnpPreferUnique will be treated as SnpNotSharedDirty by the snoopee if there are any ongoing exclusive transaction else it will be treated as SnpUnique.
    * Default value of this is set to SNPPREFERUNIQUE_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTY.<br> 
    * <b>type:</b> Static
    */
  snppreferunique_interpretation_policy_enum snppreferunique_interpretation_policy = SNPPREFERUNIQUE_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTY;
  
  /**
    * This attribute allows the snoopee to process the SnpPreferUniqueFwd request.
    * A snoopee with an ongoing exclusive transaction treats SnpPreferUniqueFwd as SnpNotSharedDirtyFwd else it treats it as a SnpUniqueFwd request.
    * When this parameter is set to SNPPREFERUNIQUEFWD_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTYFWD SnpPreferUniqueFwd will always be treated as SnpNotSharedDirtyFwd by the snoopee.
    * When this parameter is set to SNPPREFERUNIQUEFWD_INTERPRETATION_BASED_ON_ONGOING_EXCLUSIVE, SnpPreferUniqueFwd will be treated as SnpNotSharedDirtyFwd by the snoopee if there are any ongoing exclusive transaction else it will be treated as SnpUniqueFwd.
    * Default value of this is set to SNPPREFERUNIQUEFWD_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTYFWD.<br> 
    * <b>type:</b> Static
    */
  snppreferuniquefwd_interpretation_policy_enum snppreferuniquefwd_interpretation_policy = SNPPREFERUNIQUEFWD_ALWAYS_TREATED_AS_SNPNOTSHAREDDIRTYFWD;

  /**
    * This attribute specifies whether Memory Tagging is supported by the node.
    * When set to 0:
    * - For an RN, it implies that requests issued from the RN will always have TagOp set to Invalid.
    *   In case any responses are received by the RN with TagOp set to a value other than Invalid, an error is flagged and the received Tag is discarded.
    * - For an SN, it implies that requests and write data responses received will always have TagOp set to Invalid.
    *   In case any requests or write data responses are received by the SN with TagOp set to a value other than Invalid, an error is flagged and the received Tag is discarded.
    * . 
    * When set to 1:
    * - For an RN, it implies that requests issued from the RN can have TagOp set to any value as permitted by the spec.
    *   In case any responses are received by the RN with TagOp set to Invalid, the Tag value in the response is ignored and the Tag fields in the RN cache will
    *   remain unmodified.
    *   In case any responses are received by the RN with TagOp set to a value other than Invalid, the received Tag is populated in the RN cache and, in case of
    *   cacheable requests, stored in the RN cache.
    * - For an SN, it implies that requests and write data responses can have any value as permitted by the spec.
    *   In case any requests or write data responses are received by the SN with TagOp set to a value other than Invalid, Tag value is read from the memory and sent in the Read response or the Tag value in the write data is written into the memory.
    * . 
    * <b>type:</b> Static
    */
  rand bit mem_tagging_enable = 0;
`endif

`ifndef SVT_EXCLUDE_VCAP
  /**
    * @groupname axi_traffic_profile 
    * Enables use of traffic profiles. This enables the use of transaction
    * generation at a higher level of abstraction.  
    */
  bit use_traffic_profile = 0;

  /**
    * @groupname axi_generic_config
    * Clock period in ns. This is used to calculate the drain/fill rate in
    * bytes/cycle
    */
  real clock_period = 1;

  /** 
    * @groupname chi_generic_config
    * Enables FIFO based rate control. 
    * A FIFO is modelled in the driver for read and write
    * transactions separately. A WRITE transaction can be sent
    * out if there is sufficient data in the FIFO to send out that
    * transaction. A READ transaction can be sent out if there is
    * space in the FIFO to receive the data of the READ transaction.
    * The current level of a WRITE FIFO is incremented every clock
    * based on write_fifo_fill_rate.With every data beat, the currentl level
    * is decremented based on burst_size of the transaction. The current level of a READ FIFO
    * is decremented every clock based on read_fifo_drain_rate. With every data
    * beat, the current level is incremented based on burst_size of the transaction.
    * A WRITE transaction will be sent out if the current level is greater than
    * the total number of bytes of all outstanding write transactions + the total
    * number of bytes of the current transaction. A READ transaction will be sent out
    * if the current level is less than the difference of the read_fifo_full_level and
    * the total number of bytes of all outstanding read transactions + the total number
    * of bytes of the current transaction.
    */
  rand bit use_fifo_based_rate_control = 0;

  /** 
    * @groupname chi_generic_config
    * The drain rate in bytes/cycle of the FIFO into which data from READ
    * transactions is dumped. Used by the check_current_fill_level_read_fifo 
    * method of the corresponding driver to determine if there is space
    * in the FIFO to receive data of a READ transaction
    */
  rand int read_fifo_drain_rate = `SVT_CHI_MAX_READ_FIFO_DRAIN_RATE;

  /** 
    * @groupname chi_generic_config
    * The full level in bytes of the READ FIFO into which data from READ transactions
    * is dumped. Used by the check_current_fill_level_read_fifo 
    * method of the corresponding driver to determine if there is space
    * in the FIFO to receive data of a READ transaction.
    */
  rand int read_fifo_full_level = `SVT_CHI_MAX_READ_FIFO_FULL_LEVEL;

  /** 
    * @groupname chi_generic_config
    * The fill rate in bytes/cycle of the FIFO from which data for WRITE 
    * transactions is taken. Used by the check_current_fill_level_write_fifo 
    * method of the corresponding driver to determine if there is enough 
    * data in the FIFO to send a WRITE transaction
    */
  rand int write_fifo_fill_rate = `SVT_CHI_MAX_WRITE_FIFO_FILL_RATE;

  /** 
    * @groupname chi_generic_config
    * The full level in bytes of the WRITE FIFO from which data for WRITE transactions
    * is taken. Used by the check_current_fill_level_write_fifo 
    * method of the corresponding driver to determine if there is enough 
    * data in the FIFO to transmit data of a WRITE transaction
    */
  rand int write_fifo_full_level = `SVT_CHI_MAX_WRITE_FIFO_FULL_LEVEL;

  /**
    * @groupname chi_generic_config
    * Determines if the READ FIFO is empty on start up
    */
  rand bit is_read_fifo_empty_on_start = 1;

  /**
    * @groupname chi_generic_config
    * Determines if the WRITE FIFO is empty on start up
    */
  rand bit is_write_fifo_empty_on_start = 1;
`endif //SVT_EXCLUDE_VCAP

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  constraint solve_order
  {
    solve chi_interface_type before rx_rsp_vc_flit_buffer_size;
    solve chi_interface_type before rx_dat_vc_flit_buffer_size;
    solve chi_interface_type before rx_snp_vc_flit_buffer_size;
    solve chi_interface_type before rx_req_vc_flit_buffer_size;
  }
  //---------------------------------------------------------------------------  
  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the CHI components.
   */
  constraint valid_ranges 
  {
    // Only RN nodes have an Rx RSP VC and must have a buffer size of at least 1.
    if (chi_node_type != SN)
      { rx_rsp_vc_flit_buffer_size >= 1; }
    else
      { rx_rsp_vc_flit_buffer_size == 0; }

    // Both RN and SN nodes have an Rx DAT VC and must have a buffer size of at least 1.
    rx_dat_vc_flit_buffer_size >= 1;

    // Only RN-F and RN-D nodes have an Rx SNP VC and must have a buffer size of at least 1.
    if ((chi_interface_type == RN_F) || (chi_interface_type == RN_D)) 
      { rx_snp_vc_flit_buffer_size >= 1; }
    else
      { rx_snp_vc_flit_buffer_size == 0; }

    `ifdef SVT_CHI_ISSUE_B_ENABLE
    // Only RN_F or RN_D nodes with dvm_enabled will support sysco_interface_enable.
    if (!(
            (chi_node_type == RN || chi_node_type == HN) && 
            (chi_spec_revision >= ISSUE_B) && 
            (chi_interface_type == RN_F || (chi_interface_type == RN_D && dvm_enable == 1))
           ))
      { sysco_interface_enable == 0; }
    
    if (
         (chi_node_type == HN) && 
         (chi_spec_revision >= ISSUE_B) 
       )
      { cache_stashing_enable == 0; }
    `endif

    
    // Only SN nodes have an Rx REQ VC and must have a buffer size of at least 1.
    if (chi_node_type != RN)
      { rx_req_vc_flit_buffer_size >= 1; }
    else
      { rx_req_vc_flit_buffer_size == 0; }

    // DAT flit data widths can be 128, 256 or 512 bits.
    flit_data_width inside { `SVT_CHI_FLIT_DATA_WIDTH_128BIT,
                             `SVT_CHI_FLIT_DATA_WIDTH_256BIT,
                             `SVT_CHI_FLIT_DATA_WIDTH_512BIT };

    flit_data_width <= `SVT_CHI_DAT_FLIT_MAX_DATA_WIDTH;

    addr_width <= `SVT_CHI_MAX_ADDR_WIDTH;
    addr_width >= 44;
    read_data_interleave_size inside {[0:`SVT_CHI_MAX_READ_DATA_INTERLEAVE_SIZE]};
    read_data_interleave_depth inside {[1:`SVT_CHI_MAX_RD_INTERLEAVE_DEPTH]};

    node_id_width <= `SVT_CHI_MAX_NODE_ID_WIDTH;
    node_id_width >= 7;
    
    // rsvdc field width.
    if (sys_cfg.chi_version == svt_chi_system_configuration::VERSION_3_0)
    {
       req_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_4BIT;
       dat_flit_rsvdc_width == `SVT_CHI_FLIT_RSVDC_WIDTH_4BIT;
       other_initial_cache_state_enable == 0;
       other_to_exp_initial_cache_state_transition_enable == 0;
    }
    else if (sys_cfg.chi_version == svt_chi_system_configuration::VERSION_5_0)
    {
       req_flit_rsvdc_width inside { `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_4BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_8BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_12BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_16BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_24BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_32BIT };
    
       dat_flit_rsvdc_width inside { `SVT_CHI_FLIT_RSVDC_WIDTH_0BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_4BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_8BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_12BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_16BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_24BIT,
                                     `SVT_CHI_FLIT_RSVDC_WIDTH_32BIT };

       if (other_to_exp_initial_cache_state_transition_enable)
       { other_initial_cache_state_enable == 1;}
    }

    req_flit_rsvdc_width <= `SVT_CHI_REQ_FLIT_MAX_RSVDC_WIDTH;
    dat_flit_rsvdc_width <= `SVT_CHI_DAT_FLIT_MAX_RSVDC_WIDTH;
    
    // Only RN-F and RN-D nodes have cache lines.
    if ((chi_interface_type != RN_F) && (chi_interface_type != RN_D)) 
      { num_cache_lines == 0; }

    if (chi_spec_revision >= ISSUE_D) {
      (((num_outstanding_xact == -1) || (num_outstanding_xact >= 1)) && (num_outstanding_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));
      
      if(num_outstanding_xact != -1)
       {num_outstanding_read_xact == -1;}
      else
       {((num_outstanding_read_xact >= 1)  && (num_outstanding_read_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_read_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));}
      
      if(num_outstanding_xact != -1)
        {num_outstanding_write_xact == -1;}
      else
        {((num_outstanding_write_xact >= 1)  && (num_outstanding_write_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_write_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));}
      
      
      if(num_outstanding_xact != -1)
        {num_outstanding_cmo_xact == -1;}
      else if(chi_node_type != SN)
        {((num_outstanding_cmo_xact >= 1)  && (num_outstanding_cmo_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_cmo_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));}
      
      
      if(num_outstanding_xact != -1)
        {num_outstanding_control_xact == -1;}
      else if((chi_interface_type != SN_F && barrier_enable == 1) ||
              (chi_node_type != SN && dvm_enable == 1)
             )
        {((num_outstanding_control_xact >= 1)  && (num_outstanding_control_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_control_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));}

      `ifdef SVT_CHI_ISSUE_B_ENABLE
        if(num_outstanding_xact != -1)
          {num_outstanding_atomic_xact == -1;}
        else if(chi_node_type != SN && atomic_transactions_enable == 1 && chi_spec_revision >= ISSUE_B
               )
          {((num_outstanding_atomic_xact >= 1)  && (num_outstanding_atomic_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_atomic_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D));}
      `endif

    if (chi_node_type == RN)
      { ((num_outstanding_snoop_xact == -1) || (num_outstanding_snoop_xact >= 1 && num_outstanding_snoop_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_SNP_XACT_FOR_ISSUE_D)); }
    } 
    else {
      (((num_outstanding_xact == -1) || (num_outstanding_xact >= 1)) && (num_outstanding_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));
      
      if(num_outstanding_xact != -1)
       {num_outstanding_read_xact == -1;}
      else
       {((num_outstanding_read_xact >= 1)  && (num_outstanding_read_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_read_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));}
      
      if(num_outstanding_xact != -1)
        {num_outstanding_write_xact == -1;}
      else
        {((num_outstanding_write_xact >= 1)  && (num_outstanding_write_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_write_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));}
      
      
      if(num_outstanding_xact != -1)
        {num_outstanding_cmo_xact == -1;}
      else if(chi_node_type != SN)
        {((num_outstanding_cmo_xact >= 1)  && (num_outstanding_cmo_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_cmo_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));}
      
      
      if(num_outstanding_xact != -1)
        {num_outstanding_control_xact == -1;}
      else if((chi_interface_type != SN_F && barrier_enable == 1) ||
              (chi_node_type != SN && dvm_enable == 1)
             )
        {((num_outstanding_control_xact >= 1)  && (num_outstanding_control_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_control_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));}

      `ifdef SVT_CHI_ISSUE_B_ENABLE
        if(num_outstanding_xact != -1)
          {num_outstanding_atomic_xact == -1;}
        else if(chi_node_type != SN && atomic_transactions_enable == 1 && chi_spec_revision >= ISSUE_B
               )
          {((num_outstanding_atomic_xact >= 1)  && (num_outstanding_atomic_xact < `SVT_CHI_MAX_NUM_OUTSTANDING_XACT) && (num_outstanding_atomic_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C));}
      `endif

    if (chi_node_type == RN)
      { ((num_outstanding_snoop_xact == -1) || (num_outstanding_snoop_xact >= 1 && num_outstanding_snoop_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_SNP_XACT_UPTO_ISSUE_C)); }
    }
  

    // Only RN nodes support barrier transactions.
    if (chi_node_type == RN)
      { barrier_enable == 0; }

    // Only RN nodes support DVM transactions.
    if (chi_node_type == RN)
      { dvm_enable == 0; }

    { tx_link_deactivation_time         >= -1 };
    { rx_vc_credit_transmission_timeout >= -1 };
    { tx_link_activation_timeout        >= -1 };
    { tx_link_deactivation_timeout      >= -1 };

    // Number of request order streams should be in the range [1:`SVT_CHI_MAX_NUM_REQ_ORDER_STREAMS]
    ((num_req_order_streams >= 1)  && (num_req_order_streams <= `SVT_CHI_MAX_NUM_REQ_ORDER_STREAMS));
    
    // DAT flit reordering depth should be in the range [1:`SVT_CHI_MAX_DAT_FLIT_REORDERING_DEPTH]
    ((dat_flit_reordering_depth >= 1)  && (dat_flit_reordering_depth <= `SVT_CHI_MAX_DAT_FLIT_REORDERING_DEPTH));
    
    // DAT flit reordering depth should be in the range [1:`SVT_CHI_MAX_RSP_FLIT_REORDERING_DEPTH]
    ((rsp_flit_reordering_depth >= 1)  && (rsp_flit_reordering_depth <= `SVT_CHI_MAX_RSP_FLIT_REORDERING_DEPTH));

    // DAT flit reordering depth should be in the range [1:`SVT_CHI_MAX_XACT_DAT_VC_ACCESS_FAIL_MAX_COUNT]
    ((xact_dat_vc_access_fail_max_count >= 1)  && (xact_dat_vc_access_fail_max_count <= `SVT_CHI_MAX_XACT_DAT_VC_ACCESS_FAIL_MAX_COUNT));

    // DAT flit reordering depth should be in the range [1:`SVT_CHI_MAX_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT]
    ((xact_rsp_vc_access_fail_max_count >= 1)  && (xact_rsp_vc_access_fail_max_count <= `SVT_CHI_MAX_XACT_RSP_VC_ACCESS_FAIL_MAX_COUNT));    

    //Number of address bits used by the exclusive monitor should be 0.
    //Currently setting this value to 0 is supported
    num_initial_addr_bits_ignored_by_exclusive_monitor == 0;

    //Number of LPID bits used by the exclusive monitor should be `SVT_CHI_MAX_LPID_WIDTH
    num_lpid_bits_used_in_exclusive_monitor == `SVT_CHI_MAX_LPID_WIDTH;

    //Number of exclusive access should be euqal to `SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS
    max_num_exclusive_access == `SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS;

    //exclusive monitor error control register should be set to default enum CTRL_REG_NO_ERR
    excl_mon_error_control_reg == CTRL_REG_NO_ERR;

    //CHI lpid width is always euqal to `SVT_CHI_LPID_WIDTH
    lpid_width == `SVT_CHI_LPID_WIDTH;


    // Random src_id is valid only when there is only 1 RN and 1 SN are present in the system
    // along with no HNs.
    (random_src_id_enable == 1) -> ((sys_cfg.num_rn == 1) && (sys_cfg.num_sn == 1) && (sys_cfg.num_hn == 0));
    if (chi_node_type != RN) {random_src_id_enable == 0;}

    // Random tgt_id is valid only when the target ID remapping is enabled at interconnect
    (random_tgt_id_enable == 1) -> (sys_cfg.expect_target_id_remapping_by_interconnect == 1);
    if (chi_node_type != RN) {random_tgt_id_enable == 0;}
   
    //supported idle value on each virtual channel is LOW or X.
    req_vc_idle_val inside {INACTIVE_LOW_VAL,INACTIVE_X_VAL};
    dat_vc_idle_val inside {INACTIVE_LOW_VAL,INACTIVE_X_VAL};
    rsp_vc_idle_val inside {INACTIVE_LOW_VAL,INACTIVE_X_VAL};

`ifdef SVT_VMM_TECHNOLOGY
    //Exclusive access feature not supported for VMM
    exclusive_access_enable == 0;
`endif

    if (chi_spec_revision == ISSUE_A) {tx_ccf_wrap_order_enable == CCF_WRAP_ORDER_TRUE;}

   {max_num_speculative_txsactive_assertion_cycles >= min_num_speculative_txsactive_assertion_cycles};
   {max_num_speculative_txsactive_deassertion_cycles >= min_num_speculative_txsactive_deassertion_cycles};
   {max_num_end_of_xact_txsactive_extended_assertion_cycles >= min_num_end_of_xact_txsactive_extended_assertion_cycles};

   {max_num_speculative_txsactive_assertion_cycles <= `SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES};
   {max_num_speculative_txsactive_deassertion_cycles <= `SVT_CHI_MAX_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES};
   {max_num_end_of_xact_txsactive_extended_assertion_cycles <= `SVT_CHI_MAX_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES};

   {min_num_speculative_txsactive_assertion_cycles <= `SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_ASSERTION_CYCLES};
   {min_num_speculative_txsactive_deassertion_cycles <= `SVT_CHI_MIN_NUM_SPECULATIVE_TXSACTIVE_DEASSERTION_CYCLES};
   {min_num_end_of_xact_txsactive_extended_assertion_cycles <= `SVT_CHI_MIN_NUM_END_OF_XACT_TXSACTIVE_EXTENDED_ASSERTION_CYCLES};
   
    if(allow_link_active_signal_banned_output_race_transitions) {
      txla_req_assertion_when_rx_in_activate_state_delay inside {-1, [txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_assertion_when_rx_in_deactivate_state_delay inside {-1, [txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_assertion_when_rx_in_stop_state_delay inside {-1, [txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_deassertion_when_rx_in_activate_state_delay inside {-1, [txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      txla_req_deassertion_when_rx_in_deactivate_state_delay inside {-1, [txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      txla_req_deassertion_when_rx_in_run_state_delay inside {-1, [txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      rxla_ack_assertion_when_tx_in_stop_state_delay inside {-1, [rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_assertion_when_tx_in_activate_state_delay inside {-1, [rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_assertion_when_tx_in_run_state_delay inside {-1, [rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_run_state_delay inside {-1, [rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_deactivate_state_delay inside {-1, [rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_stop_state_delay inside {-1, [rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
    }
    else {
      txla_req_assertion_when_rx_in_activate_state_delay inside {[txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_assertion_when_rx_in_deactivate_state_delay inside {[txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_assertion_when_rx_in_stop_state_delay inside {[txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_deassertion_when_rx_in_activate_state_delay inside {[txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      txla_req_deassertion_when_rx_in_deactivate_state_delay inside {[txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      txla_req_deassertion_when_rx_in_run_state_delay inside {[txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      rxla_ack_assertion_when_tx_in_stop_state_delay inside {[rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_assertion_when_tx_in_activate_state_delay inside {[rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_assertion_when_tx_in_run_state_delay inside {[rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_run_state_delay inside {[rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_deactivate_state_delay inside {[rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_stop_state_delay inside {[rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
    }

    if(allow_link_active_signal_banned_output_race_transitions) {
      txla_req_assertion_when_rx_in_run_state_delay inside {-1, [txla_req_assertion_min_delay:txla_req_assertion_max_delay]};
      txla_req_deassertion_when_rx_in_stop_state_delay inside {-1,[txla_req_deassertion_min_delay:txla_req_deassertion_max_delay]};
      rxla_ack_assertion_when_tx_in_deactivate_state_delay inside {-1,[rxla_ack_assertion_min_delay:rxla_ack_assertion_max_delay]};
      rxla_ack_deassertion_when_tx_in_activate_state_delay inside {-1,[rxla_ack_deassertion_min_delay:rxla_ack_deassertion_max_delay]};
    }else {
      txla_req_assertion_when_rx_in_activate_state_delay <= rxla_ack_assertion_when_tx_in_stop_state_delay;
      rxla_ack_assertion_when_tx_in_run_state_delay <= txla_req_deassertion_when_rx_in_activate_state_delay;
      txla_req_deassertion_when_rx_in_deactivate_state_delay <= rxla_ack_deassertion_when_tx_in_run_state_delay;
      rxla_ack_deassertion_when_tx_in_stop_state_delay <= txla_req_assertion_when_rx_in_deactivate_state_delay;
    }

`ifdef SVT_CHI_ISSUE_E_ENABLE
    if(chi_spec_revision <= ISSUE_D){
       fwd_data_from_sc_state_when_rettosrc_set ==  FWD_DATA_FROM_SC_STATE_WHEN_RETTOSRC_SET;
    }
`endif

    if (allow_dvm_sync_without_prior_non_sync == 0) {
      allow_multiple_dvm_sync_oustanding_xacts == 0; 
    }

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fNMeHS7YqWkDJHjinyE1kFv1C1izrtEPNHBKe2ghGpDraYRzEVG87r2dqnmO4Wb0
DV3jHXUUHu+Y6PhatoQzikzxujj+vhElJ62GWZk7DUlUlLOGSOwihSfej2bOjFxg
hnGJ5It//Sr1PyfvA8uzjdCV6ChyTEMFsoHkeCFfEIjI1dcsMxwhOQ==
//pragma protect end_key_block
//pragma protect digest_block
+WVIN4T/sInFUV48OysS9Hr2pfA=
//pragma protect end_digest_block
//pragma protect data_block
FKiBzcGv8r6AQEeolWU1Bfl9Ctg3SvjMr+4ut/FiUdsxCHSiUtXs8xI4nnMWT4w8
osw4a8Y+nZBduOfESSyaZ2pJwuQSwZur1o33gNsK1SQ0fBDA3+V48bmf1UBCW0sK
BVsXJIq7noB8Bo7B09A8vFxeEegwU4hZZqLAwtJ4TZ2C5tQAd9LACdfH0d4pyAFW
Z7Y7aOd6ZBJEH1XiO13T2lvkCvTSdiijdCIrVp1z5t4bZ0+XM0aD21VmlXqXroxU
m70rEeJH1sK4gG3PwsY/bKVB97u5/QYZit11wSZ8Dn6as0ML09UUzM2NND2SL14n
wJz73Olm5FzDmWIE4Vc/ujEnHFrOv+JFrKsnCsMFIy+KW3WHwIqvcrIDHT3kCTPK
u6m8ljpcqcHH2E6kc8HeU11wuRYywAcy0gPnMK22M8VMhki+pm3xWGAsLHUYvc/8
4Lm/iACdxsC1GlyHf5ZgrArQCnYNS4hhQDqXt539u9NlPE3AzqvwZbdo7MnQNtkI
BS32XwlSEI//IRvu8G5AVozTkTW4Udn9LqyRosFK28gFHEab8e1cOgOBBDPKcWQO
L4jnZ9xf6Xi+fk6nOsRm7uHk/FPQbeHHjxey7/bMkzS4MUDhH+yR37t3ZroQk2s6
kJcDNbeiSjv5KxH2TUGQh3lTP/DSeResNs6PhRsGFXyEGEFGKL5YyvOLxPAPcmYD
WMdruxhrWniNN7/DzJ75O7PaLdvLxzcufXkuOlaGSfLB+gG8c7CHGFZliXmNEsYl
4tnbb+l/izyCsV0DlUHNUL7d1tunG1PQpqcQ1SptL+E=
//pragma protect end_data_block
//pragma protect digest_block
xhnS6kI+SzYJs3PK5i1PJ2kjkjE=
//pragma protect end_digest_block
//pragma protect end_protected

  }

  
  //---------------------------------------------------------------------------
  /**
   * List of features not yet implemented
   */
  constraint chi_node_configuration_limitation_list
  {
    /** svt_chi_node_configuration::FLIT_AVAILABLE is unsupported */
    flitpend_assertion_policy != FLIT_AVAILABLE;
    excl_mon_error_control_reg != SNP_ERR_EXCL_SEQ_FAIL;
  }

  //---------------------------------------------------------------------------  
  /**
   * Reasonable constraints are designed to limit the traffic to "protocol legal" traffic,
   * and in some situations maximize the traffic flow. They must never be written such
   * that they exclude legal traffic.
   *
   * Reasonable constraints may be disabled during error injection. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint reasonable_num_cache_lines
  {
    // Only RN-F and RN-D nodes have cache lines.
    if ((chi_interface_type == RN_F) || (chi_interface_type == RN_D)) 
      { num_cache_lines inside { [1:`SVT_CHI_MAX_NUM_CACHE_LINES] } };
  }

  constraint reasonable_tx_link_deactivation_time
  {
    if (chi_node_type == RN) 
      tx_link_deactivation_time inside { [-1:`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIME] };
    else
      tx_link_deactivation_time inside { [-1:0] };
  }

  constraint reasonable_rx_vc_credit_transmission_timeout
  {
    rx_vc_credit_transmission_timeout inside { [-1:`SVT_CHI_MAX_VAL_RX_VC_CREDIT_TRANSMISSION_TIMEOUT] };
  }

  constraint reasonable_tx_link_activation_timeout
  {
    tx_link_activation_timeout inside { [-1:`SVT_CHI_MAX_VAL_FOR_LINK_ACTIVATION_TIMEOUT] };
  }

  constraint reasonable_tx_link_deactivation_timeout
  {
    tx_link_deactivation_timeout inside { [-1:`SVT_CHI_MAX_VAL_FOR_LINK_DEACTIVATION_TIMEOUT] };
  }

  constraint reasonable_num_outstanding_xact
  {
    if (chi_spec_revision >= ISSUE_D) {
      ((num_outstanding_xact == -1) || 
       ((num_outstanding_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
        (num_outstanding_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)));
    } else {
      ((num_outstanding_xact == -1) || 
       ((num_outstanding_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
        (num_outstanding_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)));
    }
  }

  constraint reasonable_num_outstanding_read_xact
  {
    if (num_outstanding_xact != -1) 
      {(num_outstanding_read_xact == -1);}
    else {
      if (chi_spec_revision >= ISSUE_D)
        {((num_outstanding_read_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_read_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)
         );}
      else 
        {((num_outstanding_read_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_read_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)
         );}
    }
  }
    
  constraint reasonable_num_outstanding_write_xact
  {
    if (num_outstanding_xact != -1) 
      {(num_outstanding_write_xact == -1);}
    else {
      if (chi_spec_revision >= ISSUE_D)
        {((num_outstanding_write_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_write_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)
         );}
      else
        {((num_outstanding_write_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_write_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)
         );}
    }
  }
    
  constraint reasonable_num_outstanding_cmo_xact
  {
    if (num_outstanding_xact != -1) 
      {(num_outstanding_cmo_xact == -1);}
    else if(chi_node_type != SN) {
      if (chi_spec_revision >= ISSUE_D)
        {((num_outstanding_cmo_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
         (num_outstanding_cmo_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)
        );}
      else
        {((num_outstanding_cmo_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
         (num_outstanding_cmo_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)
        );}
    }
  }
    
  constraint reasonable_num_outstanding_control_xact
  {
    if (num_outstanding_xact != -1) 
      {(num_outstanding_control_xact == -1);}
    else if((chi_interface_type != SN_F && barrier_enable) || (chi_node_type != SN && dvm_enable)){
      if (chi_spec_revision >= ISSUE_D)
        {((num_outstanding_control_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_control_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)
         );}
      else
        {((num_outstanding_control_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_control_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)
         );}
    }
  }
  
  `ifdef SVT_CHI_ISSUE_B_ENABLE
  constraint reasonable_num_outstanding_atomic_xact
  {
    if (num_outstanding_xact != -1) 
      {(num_outstanding_atomic_xact == -1);}
    else if(chi_node_type != SN && chi_spec_revision >= ISSUE_B && atomic_transactions_enable){
      if (chi_spec_revision >= ISSUE_D)
        {((num_outstanding_atomic_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_atomic_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_FOR_ISSUE_D)
         );}
      else
        {((num_outstanding_atomic_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_XACT] }) &&
          (num_outstanding_atomic_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_XACT_UPTO_ISSUE_C)
         );}
    }
  }
  `endif
    
  constraint reasonable_num_outstanding_snoop_xact
  {
    if (chi_spec_revision >= ISSUE_D) {
      ((num_outstanding_snoop_xact == -1) || 
       ((num_outstanding_snoop_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_SNOOP_XACT] }) &&
        (num_outstanding_snoop_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_SNP_XACT_FOR_ISSUE_D)));
    } else {
      ((num_outstanding_snoop_xact == -1) || 
       ((num_outstanding_snoop_xact inside { [1:`SVT_CHI_DEF_MAX_NUM_OUTSTANDING_SNOOP_XACT] }) &&
        (num_outstanding_snoop_xact <= `SVT_CHI_SPEC_PERMITTED_MAX_NUM_OUTSTANDING_SNP_XACT_UPTO_ISSUE_C)));
    }
  }

    
  constraint reasonable_rx_rsp_vc_flit_buffer_size
  {
    if (chi_node_type != SN)
      { rx_rsp_vc_flit_buffer_size inside { [1:`SVT_CHI_MAX_FLIT_BUFFER_SIZE]}; }
  }

  constraint reasonable_rx_dat_vc_flit_buffer_size
  {
    rx_dat_vc_flit_buffer_size inside { [1:`SVT_CHI_MAX_FLIT_BUFFER_SIZE] };
  }

  constraint reasonable_rx_snp_vc_flit_buffer_size
  {
    if ((chi_interface_type == RN_F) || (chi_interface_type == RN_D)) 
      { rx_snp_vc_flit_buffer_size inside { [1:`SVT_CHI_MAX_FLIT_BUFFER_SIZE]}; }
  }

  constraint reasonable_rx_req_vc_flit_buffer_size
  {
    if (chi_node_type != RN)
      { rx_req_vc_flit_buffer_size inside { [1:`SVT_CHI_MAX_FLIT_BUFFER_SIZE]}; }
  }

  constraint reasonable_rcvd_req_flit_to_lcrd_delay {
    rcvd_req_flit_to_lcrd_min_delay inside {[0:`SVT_CHI_MIN_REQ_FLIT_TO_LCRD_DELAY]};
    rcvd_req_flit_to_lcrd_max_delay inside {[0:`SVT_CHI_MAX_REQ_FLIT_TO_LCRD_DELAY]};
  }

  constraint reasonable_rcvd_rsp_flit_to_lcrd_delay {
    rcvd_rsp_flit_to_lcrd_min_delay inside {[0:`SVT_CHI_MIN_RSP_FLIT_TO_LCRD_DELAY]};
    rcvd_rsp_flit_to_lcrd_max_delay inside {[0:`SVT_CHI_MAX_RSP_FLIT_TO_LCRD_DELAY]};
  }

  constraint reasonable_rcvd_dat_flit_to_lcrd_delay {
    rcvd_dat_flit_to_lcrd_min_delay inside {[0:`SVT_CHI_MIN_DAT_FLIT_TO_LCRD_DELAY]};
    rcvd_dat_flit_to_lcrd_max_delay inside {[0:`SVT_CHI_MAX_DAT_FLIT_TO_LCRD_DELAY]};
  }

  constraint reasonable_rcvd_snp_flit_to_lcrd_delay {
    rcvd_snp_flit_to_lcrd_min_delay inside {[0:`SVT_CHI_MIN_SNP_FLIT_TO_LCRD_DELAY]};
    rcvd_snp_flit_to_lcrd_max_delay inside {[0:`SVT_CHI_MAX_SNP_FLIT_TO_LCRD_DELAY]};
  }

`ifndef SVT_EXCLUDE_VCAP
  constraint reasonable_fifo_based_rate_control {
    use_fifo_based_rate_control == 0;
  }
`endif

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_node_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_chi_node_configuration");
`endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
759esmtbbVOdz8Z4DnjrlUHoJLbNjnBUZpWydCJaGQz8Nn6pgQuZ4gZIUqD1+Oka
XIgIdA9bQ8WLkCJrSdry7TCOah4IqI8WJKRrcmf5pz3wg+tf7xLxeI9iS8C8r5/8
T51B8LmJRb4bGZy/1GysYI2Q37ywPUk1l91mbKklxjxwO/sLdafu5Q==
//pragma protect end_key_block
//pragma protect digest_block
w8dCuqaTvdIsDIBf8dGcTsHA+98=
//pragma protect end_digest_block
//pragma protect data_block
ppyHz5Jx2r6iqyitO4IaYcO8TUaVJQgVqkhW7mHnbVQpwi3nf5U+CLcGmOhopo6Y
LjRJXr1js7gY1vFDtkOm1hklYaXIndGYAsMorHz/2wfcieAvMbnz+SIkIFgHX9Jp
4p2hVf2Td/BFy89mJYq7JtA/mx4q2BJizz7qERbQoA8oaohPX8NOr/JAbPsJARWz
jWTPNtIb6QVey3WyDSc6ADh3LrRck9yuYa4o4rNkSfmZRxits2DKotNBmZJ5lanw
lSMBgWodhcRSazKMlsB4nZyDq6b7NxOIrPkzvMX73lHw7UZhvk2JseTnujn1Zrkl
sxKuBfBEvU9op4y+dVIVKIsczy2bEjupTMe/sc27invFbFzlrl+TTsn3HC/l7XDJ
3S15xBHVjC9+VpKUaePFTEYcdTiq45A7Fbg5Ibf71VtB2o0RzWOeo9aTnDtBca8T
EmLaIuiMDSXdx9qy+7nqzXH0gnYwRBgUtdZRMaeLEhPUJvZbzpGULtm0Gz1Vrh37
9PaIBbejl/4JyXoxeyd5e4NcR+WevTZWs881+i+gJTRFhozTGvA5QK25eH0qfANN
jXjR+C3pQQGOvVT3CpMCdrYM2nuqM9vx+fWd0r2dqwtndOa4Nh9gPDxFHNKu7Zxi
N9jzNekoUboUuu9MRIqb0vNFSJeVxJBfNDRqJRFSrmhafp7ERmisGx1oiz73urTo

//pragma protect end_data_block
//pragma protect digest_block
3Yl1NN4vRZN16SBMpNiYiK/KbwU=
//pragma protect end_digest_block
//pragma protect end_protected

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_node_configuration)
    `svt_field_object(sys_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_array_int(hn_map, `SVT_ALL_ON|`SVT_HEX|`SVT_NOCOPY)
    `svt_field_array_int(hn_i_node_indices, `SVT_ALL_ON|`SVT_HEX|`SVT_NOCOPY)
    `svt_field_array_int(hn_f_node_indices, `SVT_ALL_ON|`SVT_HEX|`SVT_NOCOPY)
    `ifdef SVT_CHI_ISSUE_B_ENABLE
      `svt_field_array_int(valid_stash_tgt_id, `SVT_ALL_ON|`SVT_HEX|`SVT_NOCOPY)
    `endif
  `svt_data_member_end(svt_chi_node_configuration)

  /**
   * Assigns an RN interface to this configuration.
   *
   * @param rn_if Interface for the CHI Port
   */
  extern function void set_rn_if(svt_chi_rn_vif rn_if);

  /**
   * Assigns an SN interface to this configuration.
   *
   * @param sn_if Interface for the CHI Port
   */
  extern function void set_sn_if(svt_chi_sn_vif sn_if);

  /**
   * Assigns an IC RN interface to this configuration.
   *
   * @param ic_rn_if Interface for the CHI Port
   */
  extern function void set_ic_rn_if(svt_chi_ic_rn_vif ic_rn_if);

  /**
   * Assigns an IC SN interface to this configuration.
   *
   * @param ic_sn_if Interface for the CHI Port
   */
  extern function void set_ic_sn_if(svt_chi_ic_sn_vif ic_sn_if);

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------  
  /**
   * @groupname chi_config_mapped_node_id
   * - This method is valid only when #mapped_node_id is configured to a value other than -1.
   * - This method by default returns #mapped_node_id. 
   * - Users can override this method implementation in extended class to define any translation
   *   of the #mapped_node_id, provided #mapped_node_id is set to a value other than -1.
   * - Note that, the arguments to this method may be updated in a future release. So 
   *   please update the testbench implementation of this method accordingly if there is
   *   any change in method arguments.
   * .
   */
  extern virtual function int translate_mapped_node_id(`SVT_TRANSACTION_TYPE xact);
  
  
  /** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_node_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   * 
   * @param to Destination class to be populated based on this operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_sub_obj_copy_create(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to populate sub cfgs and status.
   *
   * @param rhs Source object to use as the basis for populating the rn and sn cfgs.
   */
  extern virtual function void do_sub_obj_copy_create(`SVT_XVM(object) rhs);
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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
   * Does a basic validation of this configuration object.
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

  // ---------------------------------------------------------------------------
  /**
   * This is a temporary implementation till we have is_valid() up and running.
   */
  extern virtual function bit is_supported_interface_type(output string err_msg);


  /**
   * This method returns the flit_data_width in bytes.
   */
  extern virtual function int get_flit_data_width_in_bytes();

  /**
    * This method returns 1 if this node is an interconnect
    * node that connects to an SN
    */
  extern function bit is_ic_sn_node();

  /**
    * This method returns 1 if this node is an interconnect
    * node that connects to an RN
    */
  extern function bit is_ic_rn_node();

  // ---------------------------------------------------------------------------
  /**
    * Updates domain related information for this port. Relates the address
    * range given by start_addr and end_addr to the domain_type in domain_item
    * This function is not expected to be used by the user. It is called
    * internally by the model when svt_chi_system_configuration::set_addr_for_domain
    * is used
    * @param domain_item The domain item corresponding to the addresses given 
    * @param start_addr  The start_addr of the address range corresponding to this domain item
    * @param end_addr    The end_addr of the address range corresponding to this domain item
    */
  extern function void update_domain(svt_chi_system_domain_item domain_item,bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] start_addr,bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] end_addr);

  /** 
   * Indicates whether RXLA can transmit L-Credits during deactivate state.
   * - For passive mode, this always returns 1.
   * - For active mode, if any of the paramters num_tx_*_lcrd_in_rxdeactivate_stae > 0,
   *   for the given node, this will return 1. Currently this is not supported.
   * .
   */
  extern function bit rxla_can_xmit_lcrds_during_deactivate_state();

  /** Function to set the extended node ID. */
  extern function void set_extended_node_id();


  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the data fields in the object that are related to debug.
   * 
   * Regular expressions are used to identify debug features that will be enabled.
   * If these expressions identify properties that should not be enabled for debug,
   * or if there are properties that are missed by these expressions then this method
   * can be extended and the pattern can be altered.
   * 
   * @return An svt_pattern instance containing entries for all of the fields
   * related to debug
   */
  extern virtual function svt_pattern allocate_debug_feature_pattern();   

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_node_configuration)
  `vmm_class_factory(svt_chi_node_configuration)
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
Q2pFzh7wyKAhINFTFXex1XiLtlpRIMGxEj0Y/wdc7T6aNOEy64h4gH1ORfnIVEms
LIm6TaOlAypIMBKmHwGFQSzg+l7HoqwrlbNhYLix+X1dLpVVUR8qf2HGNflbp1L5
gH9K5oJIpB5Y8JoylIqQhWT2jXRxK2IZR4RGDZbd/TTl41oxLiJrrg==
//pragma protect end_key_block
//pragma protect digest_block
BN18fpX/IdpQ3LQsUnbvcxQxnQg=
//pragma protect end_digest_block
//pragma protect data_block
bY+SxARaFk/dcdxpAsoh4FT6Xg6McB0nhMexAzlk71PVi5G/nw1RS4uAbBU37lBx
l9VioroAUGk1Qf1AsqjLGaRDTG4iD9XEugKaDEwf+XWdmn9Ou6x4w/EWudm6/ZmU
8qJ17jgt/cjYdRaqHKB5xBCt+JKsEr/NTVc1m12ePzpwgsib4O3jPnA5LmsDdrDr
LxgfjZvU1urYAQWijm/OjwhoX/h1P/MYPshaEtYx3iJYPVyQijmZoMWYFGCt1BfL
7tigPSVgEuFy/Lto12RUOJ4gLeKt53C2/2ekZ003tgHPXr/OHohhlr4Bec+X+03Y
0b2cySJ77eJeRP2yDFVJKgdKHGiE0UGDqop7ygwQfKjC+XS6vg/t8505OAQH8W7u
CYKUFRJPBjcYKgsKNthyYXhe8wShZ3h3e8tXZg9a1+yqiD1rTedctTh/ErsbBoAE
mSgYN1YAjzv+0Q3h6xsswtjtrqsDKZP6NyehDR2rJaD3z8JcEU8XI4emxBUX/Jui
IsGdA7y9oNyhe1sgAdpAgrWKj4hzI4ApzoKAs1h4fwApFh6YUG5V8kEYA7XTLHsY
ppojrmnIy7IdSoCX1+0H/uVRp6PCb75AV2zzIBM2lH7CicEvgQO4BJVzDyjx4m1h
DFQ2cwnu6ka77r5MyxJBzTWgGzLzrrpL5Yxj9PsNzk80zzctA6P1HThxK884u8Lh
prhkZR1EROAkMW6IWrlbKC/gmXOHsKZVNjslDKxhdYEP0pOwDTS0nA2dgzhMc1Hy
Q9K7kTWca6dHVjpZhA2dZQQq0XNYrkc+UgIHafMnHQ9OAo0+ZMpjzKtUZBMz9CXs
nLYRZLFMUJCCGBu8keamqWsqIdy4hUctp9YmtNYzqYIlK375XgWKrK9591oYepnu
wpAAvvFpcm/QIHWCn61/+MmhtjwdOWZBMT14U2LmuOdEE6ro1xl7ao9PvQq8Q12o
koyIvgyrWRRuMbVGsY+QvPtNoODzFSos7jW+/ZyfHhzHy7hxdqR1rS4ePU+iiQzc
SsmAryotzGwWgQ7OV02uAEW363XP8Ps/K5ZQadzYL3k=
//pragma protect end_data_block
//pragma protect digest_block
O131SDhpHrNn/uf/rIZrhz3I6dk=
//pragma protect end_digest_block
//pragma protect end_protected

//---------------------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PHkd0S/fYYEcL41/xMWZvi7p5ftyXwfy1o0lWyLS50oqCALm8JHD14crohUBUbqd
xkPPyeeDGA3JgcYWRcTzBpPOsCmbuTBJaNZ3K7iuDSVOH1bG49rVs6iRvJSMavgX
z8pNMBSIVqpBRFgC+lQs3+2eHGHAJbbK0+mgotgRB3hPKHUClsaiuA==
//pragma protect end_key_block
//pragma protect digest_block
LM2VT4bGrdx4HYirpojAUCvT6uM=
//pragma protect end_digest_block
//pragma protect data_block
98e3HtzbLAdh/kT0aTzbOfT3XkEGF6WYQ91w9Bvjpjz74xecyvX1QD4UnsuXmbPv
bL3Ub6zfSrwEZIOkzKapnlLQ0T8+bTB7eqI3YyGdgA5PTNYdMqDqXWtxnNdvR0N6
4aalDehnPMCkooR8Tzqbb9/2eEd+8Xu3Pmw0lw+f4wkldjOH3Dg6LNY4e2bx0bOM
2LoqAsqn9eXa+wwpZUPgBuNECdiVrGRUSOOR4WVh/e4Wnulmm1UNy5ukERWEmWmh
STxzpn94IdGpQj1JE2SCALuLaV35Pzb+8MERx/d53o5apiPB+ibMxWa40by0VJjj
K9u1T2oGvqir2kTYMWd3qQEQcBeGlp0oZ/J4CqrScGMbht01GMGAYMzu33qStWHW
pX8qNmAW4jKMO8Z49tzULaEdmFbWSZ97c9U27LIOwgYRgrUrDI+j4v3pTPe59A2w
pyVqcygPvT0IOS0jalXYY9ZEJJvWkyEltROI/OFgtkfjH7MTzWL+Nl21220llwIo
Zv9rUAiExsODb8juaxudhaheKCCy5l/8cYl8D0O43cNXbXivl9qqR8TKqUfRtgFP
BUm615+v/vsG370auG22M3MVMy9aVc8YuGGWX6plK5N6IwEBkxf0uIGEZRhWRg+Q
h3rlUDCfoVe8LM35Wca0Af/ruO3YeLP2kx/MHVM2XC7Y1ddxZD86aJSZmBOQJ8kj
zbBqlRHe8CPRQLmT2+H9nXe+qm7gF7hcGf6VfhLZNIe2adD1hhVSFjBVjAYEeZM/
Dq2XLUECCEkX1eIiD4TQ3TyvBHXR29igGLFMV7vOoCwX+L4FnP6Ar+x8oJp3xoE0
yZtme9ceMxFawqUUrd4rRSO+bn0I7aMLV7Nmt6XFMUlrlsKvi/jkrtF18kcTtDRW
6rrBbVvnbssGgYZIj2V3xKCNLXz8HIKmvzNzN2i83VJ6drOfD2mIujsscraVwJdv
g0R13ggNzdsOzOhjnZXgdlKm+7CxONTNoc0IKZJsRhtQL8uIbBFOB93WhzQPKsul
ZVkNKrd52Cfjc14KJRJK3iL/+jKc5gBBIrgmpgPzCvUEXaV2kpjQ/e+6fbiKpLpP
kgXxEMWlgaCBtID4RAt7JCLyPHocCVqjzFdKlSmFqCBcHiNsrrbXpPfz7xekJXIA
DyYJGPTK5/i5d1S2ocp6S4ntL2snYzYUXpgEtRagW1wogJwWaV0996zKeWov36lA
phwi8NlhzuRduRNzWQ6oxkI8n6O/IkuUDWQnqKvaVkA=
//pragma protect end_data_block
//pragma protect digest_block
ne/gy+DR/yqU1OYHvHtUzXpibeI=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BfKCVxZsKDnMZajBghFe4a7p0aiyhb9sB5FtcCQxuqIlCj9C9al0tmyB61igTk3K
ZLxuojVQAtuJE22jmd0wxyO1YmlvBkm1lOWqJ6ekGhHt6B75Y2Lfw19tR3O1r581
DVFFsjhIZfrJSIGxZqhkIxQLX0BQIirgxXryWxa3+cPBmMYA94evbw==
//pragma protect end_key_block
//pragma protect digest_block
ZFYT2aaJMeLd9a+7wXoS6TT5z38=
//pragma protect end_digest_block
//pragma protect data_block
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
dC5b5rV4PCQEXVW0HoUM1xb6f2UMX5cZzB8qOU5Es+OZGbILqLYHiLCkfltH9W4C
uxVODqzCbKYP8ZDiFMKjNbctELOyvWim90iNWL6W5e/liU/OyOyk4ip/5b2NFGvm
p8LmtB6Tai3XoYfXjutAKZfpI3vKj1yBMGNBbDDSSRO2CWJcPmLs8Gv04VCfGhFM
xAXGAfIihV5LM62aZIIxSFo4lFE4cvgU4l3+DhNBXR76gcEE/ZU4n8eyqRdM4xfn
jdYb+mahyTbQHM+5vOkSo9jIff9XmMrlPZoqfNa906I70B8mg3S2U1APNyFvM7qn
F3j+baiZylL0aMCdCDw/dfwcYC1eBnMT77HYG7cs6YMMb24qItOlc6wFZSw0ibWw
77pahaF3dy18by6l/XLTronOYn9q6kPB23U5V7Y7mmjKeydVjeNBNnhpb7OhY5Ac
evPGgnZ3Jva/vNrnQ7kEKOQPXroKeMUvAE4qUSWAvH0CCwULuoB6KrV3hgasxx6G
Pf5eywkilcvpeq996oMmoqe9ZjqFw6tutZHoDuBkrWKl9JB4whG1sE7pAobrBLuO
csAZrh22Vr4ovkGV9Bfzk9rrhP/GtKo9MHyV1okcSC0QjdgpEimO1DojafOytbu0
TKTN88eVUbukHLAonKNA4l2zEWCW02GxWCQK5YHFmTolhYntyFxFhO7nz0eqdI93
gCx93YN+dzlWefg+bAsOX4zN2Ku1dvchXxbe2193ejh/wSlcnfrHxPgOK+L3p+e7
98ABK9lDKnjnODTWwEfQ0jG8alX5bOjQ0+tf7PrsF8Q7DkzR0HTQdONeLMuM6DFS
jbFAkyWM5OAL9O1AkYlp/3AB3kMOUcQU//iBgaFNDLxQN8yoGAmJ7ZhJbYpYA2bi
/8Oxa425FBR9+Mi5Ic3xv/ghsg3HcmcPQldakUdnc2IV7aXzREMdfxTRanpFXacO
YcfJ0j5nlw+OawUPeAiqeHFgh9JPukaU3+ffYYwKWf91LX8AwFknF/A7THbBIcSr
pQieTN6kDohwD3oHcB/u7zwPHYksoSCMITfO5zfnYELEA3FF2pD45kAe79xkiion
ao2H9c9NultRr510q+32uLEqG/TV0Xph+2VtzBFUyOYNet0Qp06RFkfmhbL5HysR
32M2dmFcOX+qnVmHZq1uX8tx6M+nj1uoFdvFb0vWOz9vBe3tzG49Bp79TG7lEPDL
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
iUsndTFZ4tory4BeOYCRbQ==
//pragma protect end_data_block
//pragma protect digest_block
xLu0ofXDwqrztxKS+80CuXfducA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_NODE_CONFIGURATION_SV

