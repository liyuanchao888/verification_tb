//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------
`ifndef GUARD_SVT_CHI_HN_CONFIGURATION_SV
  `define GUARD_SVT_CHI_HN_CONFIGURATION_SV

  `include "svt_chi_defines.svi"
typedef class svt_chi_system_configuration;

/** @cond PRIVATE */  
/** 
 *  HN Configuration class contains configuration information which is 
 *  applicable to individual HNs in the CHI Interconnect.
 *  Some of the important information that is configurable by this class is:
 *  - Enable/Disable DMT for the HN-F
 *  - Enable/Disable DCT for the HN-F
 *  - Enable/Disable DWT for the HN-F
 *  .
 */

class svt_chi_hn_configuration extends svt_configuration;
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

`ifdef SVT_CHI_ISSUE_E_ENABLE
  //----------------------------------------------------------------------------
  /**
   * Enumerated type that indicates HN behavior on propagation of Combined_Write_and_CMO type transaction to the downstream components.
   */
  typedef enum {
    ALWAYS_FWD_COMBINED_WRITE_AND_CMO_TO_SLAVE, /**<: HN always forward the Combined_Write_and_CMO type transaction to Slave corresponding to a RN Combined_Write_and_CMO type transaction */
    ALWAYS_FWD_STANDALONE_WRITE_TO_SLAVE,       /**<: HN always forward only the standalone Write transaction to Slave corresponding to a RN Combined_Write_and_CMO type transaction */
    EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE /**<: HN either forward the Combined_Write_and_CMO/standalone Write transaction to Slave corresponding to a RN Combined_Write_and_CMO type transaction */

  } combined_write_and_cmo_propagation_to_slave_policy_enum;
`endif

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /** Non-Randomizable variables - Static. */
  // ---------------------------------------------------------------------------
  `ifdef SVT_CHI_ISSUE_B_ENABLE
  /** This enum is used to control as how an HN will behave when an atomic transaction is received. */
  typedef enum  {
    ALWAYS_FORWARD_AS_READ_AND_WRITE = `SVT_CHI_HN_ALWAYS_FORWARD_AS_READ_AND_WRITE, /**< HN configured to this will always forward atomics as WRITES and READS to endpoint. > */
    ALWAYS_FORWARD_ATOMICS = `SVT_CHI_HN_ALWAYS_FORWARD_ATOMICS, /**< HN configured to this will always forward atomics as it is to endpoint. >  */
    FORWARD_AS_ATOMICS_OR_AS_READ_AND_WRITE = `SVT_CHI_HN_FORWARD_AS_ATOMICS_OR_AS_READ_AND_WRITE /**< HN configured to this will either forward atomics as it or as WRITES and READS to the endpoint. >  */
    } atomic_xact_propagation_to_slave_policy_enum;
  `endif

  /** Reference to the AMBA CHI System Configuration object. */
  svt_chi_system_configuration sys_cfg;

  /** HN Index */
  int hn_idx;

  /** Home Node ID */
  bit [(`SVT_CHI_MAX_NODE_ID_WIDTH-1):0] hn_id;
       
  /** HN Interface type */
  svt_chi_address_configuration::hn_interface_type_enum hn_type = svt_chi_address_configuration::HN_I;
  
  /** Indicates if this HN corresponds to MN */
  bit is_mn;
  
  /** Indicates if the HN generates dbid in random fashion or in sequential manner*/
  bit use_random_dbid = 0;

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** 
    * This attribute defines how an HN is expected to propagate RN Combined_Write_and_CMO type transaction to the downstream components.
    * - When set to ALWAYS_FWD_COMBINED_WRITE_AND_CMO_TO_SLAVE, HN for a RN Combined_Write_and_CMO type transaction, is expected to always forward the associated Combined_Write_and_CMO type transaction to slave.
    * - When set to ALWAYS_FWD_STANDALONE_WRITE_TO_SLAVE, HN for a RN Combined_Write_and_CMO type transaction, is expected to always send a standalone write transaction to slave.
    * - When set to EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE, HN for a RN Combined_Write_and_CMO type transaction, is expected to either forward the associated Combined_Write_and_CMO or send a standalone write transaction to slave.
    * .
    * <b>Default value:</b> EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE. <br> 
    * <b>type:</b> Static <br>
    * This configuration is applicable only when the Interconnect is compliant to CHI Issue E or later Specification and when `SVT_CHI_ISSUE_E_ENABLE macro is defined. <br>
    * Currenlty this configuration setting is used only by CHI System Monitor to perform check 'rn_combined_writecmo_xact_propagated_to_slave_custom_check' and has no impact on other CHI components. <br>
    * The Combined Write and CMO related custom System Monitor check 'rn_combined_writecmo_xact_propagated_to_slave_custom_check' is performed when this configuration is not set to Default Value (EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE). <br>
    * If L3 is enabled for the HN through configuration (svt_chi_hn_configuration::l3_cache_enable is set to 1), it is permitted that the Interconnect does not issue a slave transaction regardless of this setting. In such a case, this configuration has no significance and the system monitor check 'rn_combined_writecmo_xact_propagated_to_slave_custom_check' will not be performed on that HN. <br>
    * From CHI System Monitor usage point of view, 
    * - This configuration should be set to ALWAYS_FWD_COMBINED_WRITE_AND_CMO_TO_SLAVE for an HN which is mapped to a Slave that support CMOs wherein the HN always forwards the associated Combined_Write_and_CMO type RN transaction to the slave. 'rn_combined_writecmo_xact_propagated_to_slave_custom_check' will performed.
    * - This configuration should be set to ALWAYS_FWD_STANDALONE_WRITE_TO_SLAVE for an HN which is mapped to a Slave which doesn't support CMOs wherein the HN only sends the associated standalone write transaction to the slave for an RN Combined_Write_and_CMO type transaction. 'rn_combined_writecmo_xact_propagated_to_slave_custom_check' will be performed.
    * - This configuration should be set to EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE for an HN which doesn;t have the fixed policy on the propagation of RN Combined_Write_and_CMO type transaction to the downstream components as in such a case, no checks can be performed based on the master slave correlation.
    * - For description of the check 'rn_combined_writecmo_xact_propagated_to_slave_custom_check', refer to UVM Class Reference Documentation.
    * .
    * <b>Note:</b> This configuration attribute for each of the HN can be set using svt_chi_system_configuration::set_hn_combined_write_and_cmo_propagation_to_slave_policy()
    */
  combined_write_and_cmo_propagation_to_slave_policy_enum combined_write_and_cmo_propagation_to_slave_policy = EITHER_FWD_STANDALONE_WRITE_OR_COMBINED_WRITE_AND_CMO_TO_SLAVE;
`endif
  
  //----------------------------------------------------------------------------
  /** Non-Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  

  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------
`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** 
   * - When set to 1, the 'Direct Memory Transfer(DMT)' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue B or later Specification,
   *   and with `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - DMT for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_B or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_DMT (`SVT_CHI_ENABLE_DMT)
   * - The DMT enable settings are used by RN, SN agents and CHI System Monitor.
   * - Interconnect VIP doesn't support DMT feature. So, setting dmt_enable for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit dmt_enable = `SVT_CHI_ENABLE_DMT;
  
  /** 
   * - When set to 1, the 'Direct Cache Transfer(DCT)' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue B Specification,
   *   and with `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - DCT for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_B or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_DCT (`SVT_CHI_ENABLE_DCT)
   * - The DCT enable settings are used by RN agents and CHI System Monitor.
   * - Interconnect VIP doesn't support DCT feature. So, setting dct_enable for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit dct_enable = `SVT_CHI_ENABLE_DCT;

  /** 
   * - When set to 1, the 'Cache Stashing' feature is enabled for the HN i.e.
   *   HN can generate Stash type of snoop transactions.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue B Specification,
   *   and with `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - Stash for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_B or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_STASH (`SVT_CHI_ENABLE_STASH)
   * - The Stash enable settings are used by RN agents and CHI System Monitor.
   * - Interconnect VIP doesn't support Stash feature. So, setting stash_enable for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit stash_enable = `SVT_CHI_ENABLE_STASH;

  /** 
   * - When set to 1, the 'Stash Data Pull' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue B Specification,
   *   and with `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - Stash Data Pull for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_B or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_STASH_DATA_PULL (`SVT_CHI_ENABLE_STASH_DATA_PULL)
   * - The Stash Data Pull enable settings are used by RN agents and CHI System Monitor.
   * - Interconnect VIP doesn't support Stash Data Pull feature. So, setting stash_data_pull_enable for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit stash_data_pull_enable = `SVT_CHI_ENABLE_STASH_DATA_PULL;

  /** 
   * - When set to 1, the 'Ordered Stash Data Pull' feature is enabled for the HN, ie
   *   DataPull can be exercised by the HN-F for ordered WriteUnique*Stash transactions.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue B Specification,
   *   and with `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - Ordered Stash Data Pull for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_B or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_ORD_STASH_DATA_PULL (`SVT_CHI_ENABLE_ORD_STASH_DATA_PULL)
   * - The Ordered Stash Data Pull enable settings are used by CHI System Monitor.
   * - Interconnect VIP doesn't support Ordered Stash Data Pull feature. So, setting ord_stash_data_pull_enable for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit ord_stash_data_pull_enable = `SVT_CHI_ENABLE_ORD_STASH_DATA_PULL;

  /** 
   * When set to 1, forwarding cmos to slaves feature is enabled for the HN.
   * Applicable only when the `SVT_CHI_ISSUE_B_ENABLE or `SVT_CHI_ISSUE_C_ENABLE macro is defined.
   */
  rand bit forward_cmos_to_slaves_enable = 0; 

  /** 
   * When set to 1, forwarding persist cmos to slaves feature is enabled for the HN. 
   * Both CleanSharedPersist and CleanSharedPersistSep transaction is supported under this configuration.
   * Applicable only when the `SVT_CHI_ISSUE_B_ENABLE or later macro is defined.
   */
  rand bit forward_persist_cmos_to_slaves_enable = 0;
  
  /* This attribute defines the behavior of HN when an atomic transaction is received.
   * Since CHI VIP interconnect does not yet support forwarding of atomic transactions to the slave, so this attribute
   * must not be programmed in case of CHI interconnect VIP. Also, as CHI VIP SN does not support atomic transactions,user is not expected to set
   * this attribute to "ALWAYS_FORWARD_AS_ATOMICS" for HNs which are connected to native CHI SNs. 
   * Currently it is just used to perform some custom checks related to atomic transactions in chi_system_monitor
   * when L3 cache is disabled.
   */
  atomic_xact_propagation_to_slave_policy_enum atomic_xact_propagation_to_slave_policy = FORWARD_AS_ATOMICS_OR_AS_READ_AND_WRITE;
  
`endif //  `ifdef SVT_CHI_ISSUE_B_ENABLE
  
  //----------------------------------------------------------------------------
  // Issue C specific stuff
  //----------------------------------------------------------------------------
`ifdef SVT_CHI_ISSUE_C_ENABLE
  /** 
   * - When set to 1, the 'Seperate Read Data and Seperate Response' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue C Specification,
   *   and with `SVT_CHI_ISSUE_C_ENABLE macro is defined. 
   * - DMT for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_C.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_SEP_RD_DATA_SEP_RSP (`SVT_CHI_ENABLE_SEP_RD_DATA_SEP_RSP)
   * - These enable settings are used by RN, SN agents and CHI System Monitor.
   * - Interconnect VIP doesn't support this feature. So, setting this for any 
   *   of the HNs with svt_chi_system_configuration::use_interconnect=1 is not valid.
   * .
   */

  rand bit sep_rd_data_sep_rsp_enable = `SVT_CHI_ENABLE_SEP_RD_DATA_SEP_RSP;
`endif //  `ifdef SVT_CHI_ISSUE_C_ENABLE

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /** 
   * - When set to 1, the 'Memory Tag' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue E Specification,
   *   and with `SVT_CHI_ISSUE_E_ENABLE defined. 
   * - Memory Tagging for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_E or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_MEMORY_TAGGING (`SVT_CHI_ENABLE_MEMORY_TAGGING)
   * - The Memory Tagging enable settings are used by the Interconnect VIP and CHI System Monitor.
   * .
   */
  rand bit memory_tagging_enable = `SVT_CHI_ENABLE_MEMORY_TAGGING;

 /** 
   * - When set to 1, the 'Direct Write Transfer(DWT)' feature is enabled for the HN.
   * - Applicable only when the CHI Interconnect is compliant to CHI Issue E or later Specification,
   *   and with `SVT_CHI_ISSUE_E_ENABLE is defined. 
   * - DWT for a given HN can be enabled if all the RNs&SN agents are programmed with
   *   svt_chi_node_configuration::chi_spec_revision=svt_chi_node_configuration::ISSUE_E or later.
   * - Configuration type: Static
   * - Default value: \`SVT_CHI_ENABLE_DWT (`SVT_CHI_ENABLE_DWT)
   * - The DWT enable settings are used by RN, SN agents and CHI System Monitor.
   * .
   */

  rand bit dwt_enable = `SVT_CHI_ENABLE_DWT;
 
`endif //  `ifdef SVT_CHI_ISSUE_E_ENABLE

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /**
    * When set to 1, indicates that the HN contains a snoop filter and tracks the presence of a cacheline at each of the RN-F nodes in the system. <br>
    * When set to 0, indicates that the HN does not contain a snoop filter and will not track any cacheline at RN-Fs. <br>
    * Based on this setting, the system monitor also tracks the presence of cachelines at the various RN-Fs in the system. 
    * But, the snoop filter in the system monitor does not track the cacheline state at each RN-F, it only keeps a track of whether the cacheline is present within an RN-F or not.
    */
  rand bit snoop_filter_enable = 0;

  /**
    * When set to 1, indicates that the HN has an L3 cache and the system monitor performs Snoop filtering checks accordingly. <br>
    * When set to 0, indicates that the HN does not have an L3 cache and the system monitor expects the HN to either fetch data from Snoops in case any of the RN-Fs in the system has a copy of the cache, or from the Slave in case none of the RN-Fs have a copy of the cacheline.
    */
  rand bit l3_cache_enable = 0;

  /**
    * When set to 1, indicates that the HN L3 cache has invisible cache mode enabled. 
    * This can be set to 1 only when #l3_cache_enable is also set to 1 along with #snoop_filter_enable set to 1.<br>
    * When set to 0, indicates that the HN L3 cache has invisible cache mode disabled. 
    */
  rand bit invisible_cache_mode_enable = 0;
  
  /**
    * When set to 1, system monitor expects that interconnect will send snoop request to relevant RNs based
    * on snoop filter tracking information accumulated over a period of time. <br>
    * When set to 0, system monitor expects that interconnect will send snoop request to all RN-Fs irrespective of
    * the value of snoop_filter_enable, ie, irrespective of whether the cachelines are
    * tracked inside the snoop filter. <br>
    * In other words, in order to model the complete snoop filter functionality both snoop_filter_enable and
    * snoop_filter_based_snooping_enable must be set to '1'. <br>
    * The system monitor performs checks based on the aforementioned expected snooping behaviour only when perform_expected_snoops_checks in svt_chi_system_configuration is set to 1. <br>
    * This parameter can be set only when 'snoop_filter_enable' is set to 1. <br>
    * Note: even though system monitor expects that interconnect will snoop based on snoop filter entries but,
    * it will not report error if snoop requests are sent more than required. This can be enabled by setting
    * check_snooping_strictly_based_on_snoop_filter to '1' in svt_chi_system_configuration.
    */
  rand bit snoop_filter_based_snooping_enable = 0;
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TIWQe9FFKvSKXAJq/80gaplFt0sDGZe1zWINF4jsu/+ckcvDj+ONNrb1KymRQ9Jt
DhTgnoz8E1g2Bcm79SjliNxMticdqUNslemFsTSRUGgYYtaNBAkGx9zkKReyAjO4
iPtpOi5pMJZz0RQO1/P+yIMzPmwycc2t5KqNWKSOgyI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1306      )
LE1t4NmebILUKrgdytmN6y1rlJ/nT+2QfAjFH5QR8zk/ysaUlHn2nmwCi9aVon3L
4ngnudB6qexzoj5Fe+OGyXvoWSAgnkNEcIaxwnHUXCNXwWLIWV+lkK6IDQ9KMURu
6ux1i4Y0nxTw7tbJzI9CRWGrTYSCcMTWNfdyc6dkZAfYAuUxJE6dPTiKWg2zlymP
ZE51PdvaOeB3Puv3OHzBesX4EJf71xzbyqTLakpDjAAqB5J9wmKCxn1ThwHL+VpF
ZxyuqATXx24FgmUg4TghOiX+MOx4cXXQf21ndJwwMkf84pty5nNvfbiJcNKyzEkw
ncgaSdrb4gNRtf+t5llUVYkdjeznq2vm3wedRcZ5cp9JuLFN/NAvAKcw3+M4VtaN
f108Sxhf2gIZIZmciz9vT1sA/tHb3GT5oAU4YvYspaDEKVFPAR4Sg10PpCTWh66q
t8VHzPYrkDcLXmjGd5nmH74gEnpN4marpj4+TnfSs7xxTFXTpmwGdJyUSoxPVJHP
4NlGDv937VcahT/Vbo9nTg4qjLRJKQfIGaJ0mMhHDP6y6vMQFP3BNhWi6RdY6gpT
yWUUl354NYdv77U7XL6iB4tNL2ke28tOPeIvkfHVlFTAalDqwVN/MotHYm4dmpM7
YIiAHgLVn8+WBO8nvWp66HA0uNGx248U1XuPQHtfbVLxn/Ean3upm7BVmuPrcFAQ
zze4PGmomO8AZ2x2DsWEuDUVlau2HyEkKZimJA6NlSOPwB2yRx67lza/mMpdqEZt
u1W6orLGCFuLRA3/hTZVytYeOlCo5vZMNNJ8VnfjPeBA7EvLbJWfdfGOnn7MTh5K
4wHWdlahOqPywhLWehRLsgU6DhqYZkyN3g6TbCcfb6Uas4hDPBldfSzfQgaQ80UW
5RJg4V5q2nUpnzEqpErDVv8ZYN9+v09Znz9g/pOP5LLUTmuSWOqP7OGn/oO9ujeZ
XLX9OQymsXaWjdfw0YRnUQ6u2xNBJEq/sICI02d6EfCnqYzrjM7vT8ysuB4BbQoJ
fm3SJ1EYms6PcqhPjARE8icMiu3MXQe+bI48YW5RJQ9IRarn4B1gTQv6a/19pKRc
NFIj6X60qyQufup0KEKJAbGVrN2iYd7IFDMPpXmyXzoiZtG93eNIaf/DUTPlv6IX
/7iuko7bESCaMvtrV9LF4EtUQeVnuH87TuFHN9WPREmU5uIH6LKbleNTfmJgtsxt
xyV31/AnyXg+ef+aoRuTquOUxhlfRxzLz+H8cOMqHsCKTXBpFTTVdM9hGePcWnI5
7hzhb/thRNamIHW4xjzOcvihKdj80+1FRTocKdu1ckssHsbiHTT/dMx1SGw/mEVb
BPRzxj9bU0U0XfwMbM8L69hMwpvTdRUIJYUUjf9XRYq6QZ4adzpFD0eKcf13OKmn
AOSakcvmZuvp4Cv3Ddjf+bLkDogGWQ4Khn0jBDxog3DerVZ+AK7yZEXGDcliQsRF
YYaHWdSZ+WYlbaCjoXA8nfuu0yYw5DP8tu3YZSu5XpMyZqvtsqFjM/998lV72UVX
sEv3HWFOLGKvyTFkvnxjuAoYRufZ+xb/xbBApFnL1WHOg2ercXx01LEAi9ltR0Wj
GGFObhDABQVMsC7SVqTGCjoWc9+Y3sC8BsEdv9YGdvla/pCDUgtQSMaXOMKIroje
OKN2JnNqJP/FWLizYZaGjfnA/yeNvR15txwC+3Fw6NBPZjfVNEi09HVEb13AbyAs
nCabjNRM3zi7BKvgqQFKyQ==
`pragma protect end_protected
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_hn_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_chi_hn_configuration");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_chi_hn_configuration)
       `svt_field_object(sys_cfg ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_hn_configuration)

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[],
                                                    input int unsigned offset = 0,
                                                    input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[],
                                                      input int unsigned    offset = 0,
                                                      input int             len    = -1,
                                                      input int             kind   = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
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
   * @return Status indicating the success/failure of the encode.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
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
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_chi_hn_configuration)
`endif     
endclass // svt_chi_hn_configuration

/** @endcond */
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EGDUtvW6LyqkCbG9ixEhRb49wfHfrKhDbC5sg6CIAizHoRhOKBG9Q+6hrDZ+fulR
jqdPGq5YOcTA5tmVBdLuLZjrelZON/j4/niBPaf9BnR2ObulvBSACUlJT7dpo3mP
eUwk9kf6UYD9rA7aDuuDXRAgGR8frjqsGTjaHYIZuqY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2029      )
tUrlZZmV3l6QPqz/ucf6TYiL2OapQSC3VyyqZeqbKdx8WGrsmb8B4YVvUiiEPjHX
0UvcCnyGgJvAglqHPME74RkXbIHyQkRo3HMsq/Sj+in+ZA+Erl+cO8/6fGdnpS9A
9WaiF2EyiA8I+4z2j/AWGS2DqMCEHAmlhIg0dGtNpdYEKuFNrNGEh7LgOCOYp4tm
Pztn9S/3O/n7dbWqHo3tpYZWdgWV0hjgOtyZbH4u4sAG03YD9tG3IOlqSe0n9mSK
bxKSF5fYsRR66YXjJl/mDKb6PTROYf0gdYInzUcwHhYewx+/wVdbnnlphUeNF48q
fzmo7WmE+hNUpKySZw3Vu6ir56w+YMSn9IvBlpzjFTpwUH2PeXVrsgK4WKSoa/Tt
IKmwod1Sb1Oy/N3xYoAS8MocYqs9bsjKFozitEOvS4i+70C5xTzt+lRDlrD0N542
K+pXLqvJSpe98vVVp1D9Hv51iTWEHd1t30Rn9eSm9aEAT7pllMbG2UXpj/EzxPYL
/qgi7jiG3jVp+ie10Fe/fUCCffQq1lD35RXSFue8yuvBo7ahvRK0RKCpFi5SorqU
KE53KjNIqLcfSCYPIGgyVlJu2kABb6wRpFChde2ZZKMBJ0JaEX56QmbOk2Ha+4L/
jO29h/ndphbMdceAL4k6XKVjZPC31XxLq3Y/dsKgPc6Z1kT2YAHicCCv0dmMtdsh
HbNn/hpn4LEMN5ovKgh2xFZjlTHUc22aW6QF0LpfVuNAWzSfusHRDy1b2Ah4d+SJ
XM/oYxbqPMTIuGDgdAu9Fe7yKVA/x8O8Ci3E+6h305D+iF89+nfwmMn77GiMzj+C
SStn0M+U8IzvPVugI0NAqS8IILS7Ry/+ji4nphVJ5VE114/+Y5FcUS5N2q0kaN2J
g0LH/9QEZH1fk4SP9e6bL+3ttG4vfwYCarEhf/t5YAuBtvt5b+1UzSUM9yfaspcC
9890iN6mwBQgBLcBU3mE7w==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
czbF1xNtr9HqjSefijjO5AJEDDp3VSfvKgi/FjsFkpyUqyxIo8BFz/IrPgaqGsQY
L/gKLXhZ7IToiYEFf6T5HfMWOam8FcpB5pEq5hA4pURqPEImHo0pv+LYRGB7wxfc
/5eIU4Ik/Tq9yk9w0DLVIhZjXws0XVYMm8GRxpF8i3Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3493      )
sHxmXEB3seD5F85DBsU65LXfmnwlR5WR7ewUzQvwtr+Co7ue+DmWBaXZOnuVUpDS
C5ESfbGAGHBAYNyc+VuYUXYQ+4WcWwsV23S8174Os0+osCbDyBXgCRmVgcED88J1
qNGNEAatAlT+CkEH+pMbs4FNFeXq3ASWXI3e2uoV7tIx/5Qt/M6jZ9DTBKCMTdNn
8kJ6kQqzn98e43sXphIcYBWS2zLpvUzf5MeewiCEfhnhU6ZB/hAxYh2vHwNQQ8jQ
xnrYQ3vt4PsD3kudEKnLN/pjxrU0MkOrNna1yb98UkDctkWXhR/mKqrNAO7ohDwz
fsV7+o8SEXEYdKk13l62XKeTV+shoPou0xDgZiHMiAWbvb9D3nMKzkHWpdbwvgd/
SWf2XG5IjnkUD3Oij/HR5HlDkgvLTUhO+IeSo2BTVf1jFt/w3PhaS21o4zzRYMTS
pKnZ2W1TwX21QUGs428b65U8+8AOMb3wXcS+FYpOXtojZUAx4h3MLPKGPFSkg25+
ENCxsQBHNOhZIdipBZs0kWBDt3JqYdtdvIzjF2fJnosepeSEQxmPF8xbi69XEbcO
dNQoDwGSa1bC/rByy5/ZBW3JoLNiHe3BWC4LjpKAIUX5tlJwW7NkbQQt4tXrUeqZ
RAOUEzAuNH3e63laWq7zVt9bCOS43y6MSEl2gHYHZRwvi/49qYTkW1BR6Cbz1nP5
q+nihK30offJilFDCcIvlOVGJdB2+F1y7bj+4qsjUhaxEU5GNZ7RdCyZhZEeUWLA
ndvj4HlYq1wPgj3FF6WrT51Ou60xvI5DRBgSX2cb10KybUB2nohqtVyt3cT2tbGv
6TR00pGzNknlv90qTtViQrWIf7GA+cUWkhY5V7Ufv4wfkysyiRri8CQnVd/LxCqO
D8+yrZ9NHi0N/InXBC56QB7hwA3mKDk1MbPD66nrW1Fc6kPO5q6hjwk+HelLxUY0
NJsPolwXBfPh2mw22EV0MJaI1eUJGDuGI+nS0qjIcd/20zJqjt/oIj7marpJe/In
RpdZR4QftqvO5cw7xn69Jsz50opg7Ehy9zLjxAmqcoISFyCygFQPKkztx/r4vt3t
09/02OXcWCtvmAuBuWF34Ps2qoSCHPLST8e6dp43LpdelY8dZ08BDW/tJFqfvICV
c6RJ82Oj2hMyFy1dAW3I+yx5DbpAeFZ53uh66ZQWbacWSSrezZnuzTFQhJZ9S2IR
6qGJL/X3eGk8xRgnPy4dsafh/6ZqDkUSfNPxFbXCjx1wywCUfuTqSj3dxsvYwdYr
0xisP5b3UM0MOhwcnhXyzzjalA79yBMR+dD/ntdY/2baFLFhfVpQROF2OFDYz4Fs
r1Ws349EkWAD28gXtltV0XH5SYuNmv9eYkteGMgDZQLVq/fxuQ4OZ3fto0L023Wi
x2R0wJro7+++A62B/O/qHHcSD/w62UdcD84Rhq17l+1Ny11/1IxWyjkWGPOaGg65
UxS9PnwYKn603BZ8LM8tTT1VYQOZzmolNVqsR9qjzgPvWSeYSSGoYQfSzcZ+VMbU
yWyZKpSHUs81NDG2WCndW4+WHaMkaTIyu1GIHQXzBpZiI432kB3kzoKNgzNqdMKb
bx2SXPWWG/w0+q7aZ31XobZzrLRE2UkVqhXDHk4k8gWBGu8yqpWLyIz46S3tL45I
ydg+BEvFnzx8HiKxv6mGcs44JgQwcD9JDzTbujLOYXqfW5IYlpUIRKlIr/dE4SxT
F4sCXPnb6WQRCUNmUIGE4r6BgHFgfq5hXLHvCfUHmcY7zKmxABhWlFNgXIk5NfsL
V2YKLVm6kAqZkTYggWrzgZJ58MGFrxA2SpMgYkADvFBTP1JSCLWg5lxPF6+CpXTC
NX31uLgVWDf0zxcAoXqgysa+jQv80TkTCpbFWgm2b7iIRRZA5l2iT87PObVt3ECy
wdQLlVdF5SA7EW8h5LQ/g9PuUH6DbsVONhW44llt/ZA=
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
l4cw4ECZ1arZgI3IfkzsI2+fUkyMOlSpGz88ue0vnqT9D0/Cb8E4IOvva/4DAZeN
cHkIO2RoSaEpdpYXVoWy0Rk/7ao+C9z6phW56ktZxZBEtJxO2xCjTv6PfE9UPWbd
hW3kdSTl0mPT15NK48aoTMf+Aau/107OqwNSKUWQiQI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5503      )
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
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MY95xtDMPn2Ibowlo05NYTs87QkdrmKFyGKVI1ojOHZCoq1L0kiKoSTB92pzuOou
BGRv06rGzja3+7iUomh44AaxzU4TCwxtIR5gOyuFTOLa8w1TSmhAhDjN6p6TSGU2
0DPnivz3klSbTmhZHgeEIZw2xbUkRc9GdUtWcJw5+uk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 28809     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DXWBMvQwMQ5Q7h/1Xk3niShQGR/aUvOGmezKSV4eAhB2tj6AEb/8wbqJh6CiYpIV
uLX0iN6ajMPYHULA5NxEkTlzgPFdyYQWT1pJKQD5XZy95zwA/yKTno63G/NPonZQ
BjgR+1JafJ+iH3w5W62243JBiFlf1gQGcFffGlYbyj4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 28892     )
sE/SivTBBqFhv9af3GFe6cxuDpohABXnhlHYQPJVbl9GfGz+J1YVT8nQBmMPRg6Y
+3a0qt3V4eqgbCnIDAiSMRpOJgaz1+HPul3XURmCrXqF+7s+dAtMlKDipefOBU7/
`pragma protect end_protected
