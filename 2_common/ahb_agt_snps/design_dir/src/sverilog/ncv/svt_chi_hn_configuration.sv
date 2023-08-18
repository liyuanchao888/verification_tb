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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Wf4T4+E1ZNbse7899RT0sYGAi2SW4nj3FQci8WI+5TwLMhZmFJE6PUJZiqxhDZF1
0AjuStZHWuxQHFy7JC3Qp2wl7kW4U7gf59GGOxY7rsE8kE1iYmv5aJn4ALGCkTKV
EpuUgIeWlLEXJFfDge9XL+JiTFZDnPEel/oISlgkEpkHuB+Tg8B68g==
//pragma protect end_key_block
//pragma protect digest_block
O1wAQCSvpPn79ststktwK6wjEEA=
//pragma protect end_digest_block
//pragma protect data_block
dJzGhEeaTN2YozzGxK/XEpB/vEW1PjUjOVyOM2TTeL/Jvv+qH8EFr3aeRPSkyL8W
xhtaf0Q7wkr101hs0GYM0TL8KbSruJ73ZJj9I/o7rapoRNwv1ZzNVLjCVG58YrIm
uB/axRub7T+XLkXSxY3VtmVPOedYMhfrjhkO5OepN97djrO78Ooqkaa2L3DgGvpO
re8mTtXqEsdqQr6NbyIaOO74GwRs0TcNp3CJ9Am0OyNb7/lzEgygN/S5/MGAhxKd
ret9GbTpf2H1AcHreg/7kjPqz0jrz9aB+k/o/gIyI9k7iNvWiPqML3xkKUH8xvCK
y2TF3qlr8vy8aEm5DXk8flhFam1nj1QsZBqC4YiAWT+PRfR4SRXrBi9GKE6PqzY0
p/pIa3n7KYte4K3lyPGi+pr6YgjZg5OGmemKj2fHQBs3hRXpUuaW6KEbh+RrEm/d
WegPizTxIL3mcKtHNRRJnXsdOMuFgvzMUPMqS5iFbPLJFfg3nDNeOIcBQGwkakNY
kk8ANzVqi5owAxhnW7AoJudDIL4htCeOgQb3GJNkSVLuH6Ss1wg/ANX1zEZX81sP
hTsTrqXx0Oj5cFrvLMO0CDKCw7kyQRgEr3AB4qd7C9RRGgw+bovwbwoA+cUxF/Ai
iu2XTZ8Ns1x4h4rteOkiDEFdRRcxhoKIRiAkv2+QPg/yb5GHQx5pVk1m2i/r1eOZ
qn+Yx3zr8Mr5/26Yp2LcxYDdKOgAYa2RSQ8VrnGVZNvsYS8yzs+BuVWT4gMu5fOq
Ri6wICIAjjXhItYrLELLkMbaCwJnMpItjE7kDIjIYXdQmxB84khQkeRJdBB8/vB3
wr//kgHO+6mKuyL7/wu05HOwSO+xMoT/CzeSQQobB46hYdFW9QVbjzIxuqL1OXtt
wqpl0NILcTMD6LfBqOW+AjtwGsLqbNetKds7XgtJmiaTQKwke3WDzwiUl6iviILi
dxcxozviE30Ly5hGnembYjeRnzcBKPqAuwxq6QCveL6wrIinenVUREpg2zfsPeMt
URDzY+AEu8mK5fwEckgaOj4nvPwRtaWq2V5B4DZVEZla0VvelRdUnatmIoYKvjRa
y7W0fe6wt2Ef3gHKHbfZFOoxVYqUKL9tb9V6tklNeim/bDLxmcpCxU3KhLO762Z8
jTXO/iM5t9m6DLpmu8ITQ3OuQ/6aWk3E3u4zuaPMBeaztNU1fztP29TKL6hggFrG
dt9hlMc74jbhQivMBbGEIUz4/ujXBmCLKavoXzBUcuWgu4q1ujEISjLeEKBApVdh
H8sM8FNh3c7kQx+0sgDBcLvXgI4JB+e+WhnqQVJdrT3tIh1EfjOcJdTJK6pq2YQ/
Ju2Fes+fDyd5YX/hBwpzG79b6BxX1YzGmMpGKf8PsPN81KxtZyTAjlpFTkz96N/z
6tbahdGyTNGxaVuGvWm2RB4JDCbwlbUqCCypdm7lnDH1DuF9Pkag0686MuT5SX1i
DEtFVP5eC48OQKz4x8oVftci4XvhGOkYx0qdUzkWF3JSoj2No/s7JgxK40yxO1z7
YudvD5cHP5ry1ljGQAzfrjQ0Y9w7Cdgh+rcN3ojfrtKCRvKPwUAQbF+vpvi5E6vD
ZdoHA4p4R5TIoCMCB2pexbQ7HulyMk+0YloFwOySo1xW/gpqZfzguw3AyzytEmQs
Opp2WVd+X4dsacBjnYgtW93cceceejtMSbNSmJptm6TztBLcnJRpASJ7sMubJoDK
xZR1A4YSgpHlJw8mHiFViQh/hND/X5W0qM1ENFmPG59YkpHBcLjzwJbVfjM/uieB
OQjPUfzEATSMV/G63658iczHTrF6/Tn4AI0CQ3NMSmWnnvYdYy+Y5udwD/3Q65w/
9HEnEINmMdyLJO152yfTKpJI9stHnS/cMAtTmJQVvwaKMu/WT71vZoqKwn+6gdhA
XEqF7w4+DchDvBalbDSOgbFIbcmr4LaMQMHnUuNou8Q=
//pragma protect end_data_block
//pragma protect digest_block
c9a3iFqezB6unbJqsPT6l0LURBE=
//pragma protect end_digest_block
//pragma protect end_protected
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
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fNECR0adUFyA5t8sLwX81qKsqnMRGgBw2BnshBNwu6qbuRFjylRa1Iphtnt8Topm
ayN4r7PQrVO2IaWwqZQLAUgwc4iib5YcKvg6Osv/BHaJvjrF/uznuONa5f3Eru9r
Q9sT+1IfqdsJ9ZJ1Q3as5jlUFjWHYLsXgFvSgC/U6FCteiQ1EpKGnw==
//pragma protect end_key_block
//pragma protect digest_block
0TU0d/GqyqWzrnmT8Y4R6ozYxsg=
//pragma protect end_digest_block
//pragma protect data_block
yJ6eoUEGC5N0ptyGJXFaSbvvkQOD9NPt6qc3TxGy+PD9r26VcooYUBqreLUbQGHv
jx+wwi0ZTZvF1A+C6+Nbu881vyPPMxy5chcPdfcsv2JjaXhd0ff/fUuEqAstAQUZ
QBs1snkB/Om2WHPwauSpfNsjtspt7lb6SH3aFz2tfacmWaBI2UD9DEUYTvkwO+di
RpPjaMx34DMlTozectqRb288mXWqdeGLGwu4mrBOpxKdSCj/t01gaf9MZ6VPPmZ0
bfEHRyh4s0YEArE5W0NHidjwZiLkxZu7peK9/DgAVmrCT8Yz/G4aK99xTF/upSaN
6FGD3ddybm8wOcdiJsKrxo+7+iz/1ljaH8XfxAEu9BNIBzRgM83GHxKqOSs4lc2t
C64FrLZR49MSDCbsphqWtsw/8zCetL3lQpAVF1qUheqzEiD9ydLO6zmZiKSYBpoB
d45ARWijwkIfN++Z9YX66hX+iysnMbbHDbnEgDyODrf6xbUY3pkXRzXPSLF+TC+9
o3ZhGtLZ9I13R+J/9PRSLNjVnFnAyLZipHDzBFzPpp9+TVoiiJqXGDMlrf4PArOA
I6xdl4ACyQelrH4e0K8YHgnXXly11qPy1Pkd+pPcY0Mge/gc4LNOxJtUeUY2NK97
fkJ+nCVU73DuSPBZyk917CQaNpbHMvq9BJS5YzdU6389RKz3QZhlymTaELysyLTY
uS+0spEy7fRgTlIFJpgTpVDPFA5K+TwHvEQtxWvr6xkYSaStsXHDwPw0TmeKFzk2
qYB6ksJqAusE1vCCLKT535Fzy0iQzVWsb0LjA7+HSKkmT38GWhIx4pF4kOlu4jsO
1u6G360Bqv3aepU9oH5SMX9PYPW1yQsGJOx8Qkjw9Dz9k/w90jZngmZXVPwagWSz
/fy2Hxsu0GFL+INfhJT4o2VBlHCvw5ThVbET4kFgnT81BevG8xyyMA40Ny6wuPqe
apY5ouLak2Or4OnB07U102rMdybaM5Bmu6IS/eETMs+JQ3ufHI31/ysiAOr2YVpT
w/Xdci4ixs8NIJj6/O09V/T69ZmZTT1PSy9p8gHeWZldvYjCJNpWzdhzhjnDk0fS
Hxhysep15TvRr4hrTGF71mnK3EPgX67ArNdtiKB2ptUOvdun+5FPxbCpWaLRIsIf
2roWijVbIE6zxd9in1iAy8VymgQcE4W1MW+QSGgiZ88=
//pragma protect end_data_block
//pragma protect digest_block
9+Gq/4Y08QsDc43C7EViVOob1bQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0fPtkoY+Pk/B0vGSQJX3tpTuOXypw4jVXqncOTVNPimdQETt8gda42PiflKZZ+H3
qHcZQsT7gdo7UXmy56wfOwk4HeF+wnvkwIXz0ZPcqHBFgSZbobv4dv0b1UwxforR
nN5d4NMZR12QBGl15Kx9qB0D0TkJOrvt9fnZh5143cD5JFhF6m647g==
//pragma protect end_key_block
//pragma protect digest_block
+8ghvn1n9Ye5jwktah3fvS38rzY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
GqEGxO6w1x4hB73SVOv9WrnagjI=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
P7pdDFy26V1oD8VIrMP6X+LZ+Or9qJCOn98JM3NjN1W2/LY4sVOmrmSIshp6FJzG
LyI/ZKbXu7geHm8cGbz1uWF6TlGmRB/xjdG42H3qzUJviR2eqW1IBKA9P2zJXZdX
61HDMYkU9fFV2HcFfQTNJjxDs8AxtOwMgvOZzoO7CCvAOT9TMnahvg==
//pragma protect end_key_block
//pragma protect digest_block
5Xh9XPaXaFTDEB6X1lHJJr94KY8=
//pragma protect end_digest_block
//pragma protect data_block
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
+yjDzf2iTMsP0/2h9Z8hXQ==
//pragma protect end_data_block
//pragma protect digest_block
6dguCmQ+BqmbjSTFkOAN+U0YP8Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cvXNMhMo1ipaZfvU1y+zQ4Bi4SPzHfaXE5E7xPbz8TjOMKFDNZqMoz/OdJI1CwjU
sZPU8WGjH5fkh1gJk34fs45duhr3ZfO/CSg7iVgnuzhvDcq65g062BupclNtDlrn
lnR0Vet87Wr2DxxOIFy/ClWsDx+JJP3C0Ho+zhPPDA4nAwx5rsXkQw==
//pragma protect end_key_block
//pragma protect digest_block
euMPJU67u3MlWZCsblTnYDVit+U=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
MxGGsf73KAsCvqj9iggxo0pC5Oc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
