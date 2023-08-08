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
`protected
Lg#R(A;cJ/X]I:)LB4\)_Bcafea=H<?1.-EGPA?;W(/72<4TSf6f3(a60B-+WBGd
X5KVMHAc91SBeTQ]EJ-S(BSP51dGe^]O@ONH?HU&[H#ScW;?&9>P-@>4OCYf_&,H
Y0CBgV3N4Z,BMc[8@\V5(CD;@B5\6W+#_c.T4Ba/4R?W4-SJU\GMV]Gg@4&\gT)4
=PbfCGR/cbV:T<H@J+feSJ+&cR^3K=R1]Gd)IQD.N0d^abK#,8XGC=U[CC-PgfDU
,FG]fU6/^USTKB90W7JX5Ibb#<QBHaMLKJ]-XcWVH7,1LEUXY<GM/[A5Dbe/>CM?
V#YJ6P8X<N]^XRg6Ya&0<;RJ9c;ALBN1c^7-,,NDG^\ENG+4^G)U&K.\gU[Y/F\S
(N5#9UB0,GgZQdV>4Y5;GX5VeL2MI:9HZ@,.+MRJE;S>TV.WZAaH\8,()@KH0,Dd
MN.ZQ;?YS@D9C?;3>PWZ8NFgRR04Z-YCA]1,P)33f<_gN9NcCSB\XF;5?/\>S;3W
#_=Y]PX+I@LRK37/,61>ga2#f-LbH_WSM-=L52A>L3<][6bUZ\L=_&T,__[K=7BS
JE]D)&Z<=U+F9QO[J02A>Y&E6O9NO([8=S.=X=+1=V]CCQg1[@DOYN^Z5c^7,,_4
+L-WWWegF>Z;@-cA.(KI15/)@NM1?dT)gQW=g5&NMH5K7.KdM03cCc@4+HfKFIH(
(\A#a4#L>FQ]FEB4S)3UHT05_4@)I)cV;@E^G4>d2fZFb1AJ>58F)3a/D<WNNgP>
-e-/V+JY7]Hg>HAV2413@fOIYS3=O7LeP#bK/8g]86RX)K14X+N]93/fT3F3a#/S
]@MfFJ#7Q=3RFa)U>:C^CX3W>BE3[RV&O<=VT3/d@P/[FAGe++=4ggG5gM?K[+&P
[BRDR+(fK#+)6E)VNf+)@D#H^HWcd+T4)&.]657WO.4=I4@fI1UF9.I9U.U[S&PP
5V/FK)E>)MBS2g@:E]1NS9cTDDI:_3HVf6cXfJd[T=W&-;KSAd6MN\@g5<R].1-]
A>[Rb=V>YU=c8Q2E8+)&P=4OHeYU?>=QN,)aU7+^4W=M.\dRHXPPJ8Z^H,=>TX-;
LBV2\UeAL^ZJ=QW=@;K&g)8BJ1CaD1#2S>a#Q1XM=E;&T9M;a/#cXNUBaG(+JIJS
,@RYa)+_V@:<P&cGe534:U/LgP.-[ScBb#a>VB>Wd\Z)+8OXaZC:.P19K?+R#<,P
c)eP/+71.Y@P]WcTV@&,GR&3PRQV^0Z\=11?fYMJ;EO+KP;_C+?DAO+6OgB.c+2F
Z45bMR-19>,;3_CK>6,J.GX4GV+aQPIXeL9@@Yd3+&cTgFL?7+2:LQXce\E8EH3,
5MIRKX8SC&A4N9GLXF^fb0ET^J30]&9bFC[XB6JSE/]C=.d(UdBW)K2YER?,>T8-
=G5=<IGD></EG_Gf\>+6+.+ZIKR.8ad0&gJa/)&#W7Ya#6_,CFE<Q&[(&+D(/edH
D:@;H7@;fV#NS_KTZ3N\P-S@-DKIY<?eFW&VaNV=#U(A&/5=]5U9+6@Q.+Lf.,1^
\C>BEa2I^T)]1c2@80#;IDMVM/(.HbDaGN[1ND<dCdV@7U5EWSf#0cf?f,d^GL5M
X+]@[SC\I+A\#>Z+fO7N&9gASI3^O6WDZ.6#aeREYDM@/T,Z;DNY+>>d+4f2UU?F
a?^:A(K9K7g0J/CVa=P-8K?V(G=KAN=R@$
`endprotected

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
  
`protected
Dg^WcGee=fXP[85gZJ57=)(&]>)R6L_JbZ8NB\R-CYZ_7aKKS+F,5)O8]A2E@P2D
)?ZG[K58Vf+1<)[>LM_UWPJW<G0-H5U#:)BT9AEMb:=_fCW,OU/M[>N#@I/UJ9WQ
5H4VV5DS78P]FO;69K6-?7@E=M.YPBW;(EP#)\-EXefI[:KT5MTPQN95]O&.&OF2
3GY,PU=GT[abR:-NWUMOI+VgRIA(P-4.7c_KX<eU?4YBS<Ib^?+R/[&=[WG_,<X#
@C6P:]U98BM+-8(<DCA95DN7_UaSNN/gG6^4=;HL.<S9QEb&O@.bN;8O#5M48R>0
68@f7eB.GM31L/R18gR<&A0&+&#G@CQKHcfV/)cGK8UKF7AdbdcB(.5AJ=OUPeJS
CD0-M)F?Ig.Y.+1-ZLD1_LAEb\90dVeQ[gP5^-J9?;)RXI^B]UGU@@/F8.&4HbC)
^0gf=Q.X2=90N.-+S99D]07/CT:9G=+R6#7,Q6>@ZeEMb#2]/#=I[XLR-6aP>\_9
U,?b.)3b+-5M/&KR,/624P>18XBQIdVWC7eUK/,DUUcdU4J6(:1YC\YJ^]fG@)A3
;a-?SQXbQNP@W+@E(ZXFY0ZUMLK64Ne8G59/I.TCU[_G0J-LY(Ac8:R.1I3OEXD5
[XP1A].4=4K7V1[)(S](QJ:.D31EN8;bS;WOC_cUI51W=c8_e(H\bb2;0.ZA&DO8
>TRM\D#baF\7)$
`endprotected


//vcs_vip_protect
`protected
0SPEFd.0g[4KFDQ5gIA3#&g[);Y2B>2YWNJbL&3-MFb,9^bEOA)b3(@.6e#GK/bF
1N;F=c#+7550JRVQ;=9:0/TgbSR&)2g)_PgNZ0YSTUa?M=^@MB7+3^DY?L.:R_./
I3TJP:T1PK)DYP\([0ESb\<dY&\P<ebYVP6BU_M=W?>bUB;A##Ge(eIadH#-D/4)
]U/RKUf/J-^HWL&NbMEg49Y5/6;1FV7F^b&/R50R6_EgLOU_-/L[(TJ86OWI,6(-
fcHBG3Yg]/HIC>GPE)FE\JA8V4gX;.d6gR,[\>[?J+gG[cNN,dIJT(O@IAS?0Q4g
+d8;-:N_SH=M@gN);QTSR0-BCgW-HPe(cH0aaY5-?8Mc@@4Xd^IN2D]?gPU-88aJ
2+2,,O-_,O#VdYFLZ,8IXdE6,5ANa3QKOGN,SEc9Q\JBT;TRc,<7W_Qa(bN=,D?2
2+YM-JdUecFJTbS/=X+:E8a5c8KVJE9A?71VbES\/^3aU;FD1a1J5\^4.HQ:3P::
M-UJ75(+JE6;0^L3.Z.]0\R1MUXK#=eaKMcK;SYTM(>,?OKM)WB4\c5gF/?C??]f
eQJ=Tg&A[P<&bBDSGg6@T.5K4M6LTY?T.fMMe_+;f,HXc57\=V[S7WDN]L:9Y;Mb
cIe.Pe1]13KA4(>S2f7SK;-,:I+YCb3ICC_acRD-_J]KKB\c[J4;BWJ^aL?dPF-+
[K4gA,K/&(4@I?RF1=4?R+83^\<MOM<W@#b>;<bF(+Cf:-G:gL#NAWO7Ye]@P/H7
CO(&\.<&g(\3QC@0UQ2[E(U7Tga=\GC/D(eK^IOO(G5-QP?]1JZH)/-I+7GgK&@K
HYB(ZeeH?;2FN=,]8GXT;EAIbR7K2RY4D3LPb+E.3N:)6ef5Z)B?X1#RaZ&35D6-
R;+W_WT3.[fE[a37Zf,bP55>JcR^OW/G.F^,Ec)[/8]:TLHc##31=(A9#Z3d.G)2
QaBAO<)JZR/L=<.J]I=<A/\K]Z1adNSCH.c3NTOTKIJ&<BO-DX8VR<Z.@OLQD;LS
G5HB>P(@&dOeO>f>g05IAXDg6+M6=FMB1Da[I=&;[a/9V8SQ<bO?R-&S.Z37./F7
dX+Ed.KMb,gfS4](d&Pa1Hd<^g0^IecJNK(/0>G^QX\?APVW3MZ0dCRFV7O1De+R
MeTaJ.fWKU#GU#0Ab@F/eK/2^Dcf=cOXU/<[-[7]#N\AE^FLe\7&HcRKH_AgLB9O
b:XeMS@ATYWL[DYXD&g5HF8I;=)_WB@;5WQa9[1U8@6;^6]4D2BX[J&g#e[FY?_]
3W[5dCfDeb,FJ2?N7-MVDZ_VWU+?XMCLD)Ocg?E94H0N_:6)=cP/VAKY7R(15:_b
C<^6@F^#9U(D]^7OfP18g&MX>=?8D_(./RVG+(13DG(0QO2bMQgICAX.)RRWO^L8
7fAPa<(]&I1=3f@P.5f.EC\2V-;gFac(2;JA;Nf+\+T2IdT?0V;:N&)BY=1\YW;f
D-1eTa[^D4YdF)HZ#@6Eg?M\TG[&S_#VcM#VG:eTAH:/\G<0=c79C33Q&^[d+cJb
A^Sa4^W)WgO[9,^:8?_M-OgBg_<3(;ZN)Q@e-aOB4M1cB:Ge-729=GN+3A>bg#L-
e[)b]6BUc0((DI9)YV-?c,3[bJZ_V^TB3=Z@G##TB\B5U8be<7P4Z(.2b9@71DEZ
G(EC1@3[EH<bdgN?;?_(,=>A),;bO6Z>RLC#B>ZU8LXd(O.X1^#f6/<H)BRa8AU5
5D&@-I#=U#YR?5IOc7NW#LG)eKF?/J^;SLgOI00<CECURAZ3ecR(b7aeb1B>.ST]
b>>;P_3N?5M(WAZ:7E3dP8#YU5;@/ffg2@HJ\)6S9-O0g5@\X\EMaKCVLGd3/3fC
5-fC#;9^4UR#?WJ/4^0Fa4:C@<VdMC@cC8a6J4AK77XS1[FL=X(2A/CVN$
`endprotected

`protected
NGY:8e^\A_gbUW0-T[Ma5@F(CgScDDA;(J>39)E,QGVU>])[Z75K2)bf.,VL&d-+
W?@#NS3P=Of)YQ^O<gH;#S&c,_/#]dYP);gQWJ#TJV26UG]fQMFb^?ZX[2LD43Dc
158..g)1#If-3O2(4#?bP4Vd26WI5BXS&_9QEBD4CT70VVVMcA^_/2BJCG7#8.<6
<2RJ49Z;BQG077I^:(^:GV^eBR<KF@D0:\0HTg_bL;P/-+6+HN.]R9Q,+HK>S)GeU$
`endprotected


//vcs_vip_protect
`protected
?N5/U:D<,^^D4;(#^>H5;M5MO=9Y&48TZ2;A\U7FaXX]EM4=dV)]-(B(@^WGP+<S
<4-CO^LBb[Dg^YF(8gTX:aD)KGV1XPTD#/)QO8dH4Uf6,:BAW-6X/S<fXWO#F?75
))Cc7gd33;[W)9^[-M]9/)4+Z59Z=+=PS):-.LR:#>R/7POB.@6-R6ZSGT.74c4:
3)fE=Y9PWIf38gM8EL-7><dO:@A_?+&21PNL9PHd7+a2HRg>-,BYVN:5W>W1=1Aa
Pb4&P?W,-A]aT#1A;ZL53@PP7&(Q9W.UIC)deP;-1K?2Z<K[W(#X-UYEZCE&<_T)
.H@);6IY<gL.LPGc2&,34FJ=RGN-=^B]JNN.Na#,SNbC,2,(JG>;e=_)-?]Ng95e
E(,KbaU&7<+Z.6[+d8;PLNc#+-D&^I6QVT]P-0G-#V:]aQW2,4[gFa9/U?<APGYL
BZ/6_A&0T,eARc:Q&1=DK,@.1,3FR(DX:V??fU\7ZDg@U@-@^MU-Xe8GcgPH(G[>
93DI#S.dQOV;;GQM9;1,f^9#4Y6BO+V:,^QRK?\?HRX3B4@1YSO3bdR\TUA/3QFG
Ad@fD7g?LWE[]RXfGG(.S,6<,;.2R8S<<H82YPSJL>9gX75]Ka6OW(BDJdOM5A)F
\Y^KcYRHTMTe-[eW<9H,\b]e;3]98bg(/6O8:9FQGSTRSeSe^AP]/TYX0R2:ECDX
SUIA(BGN/b>\Gd)[2a6d>d;+FZA>C).?DRAFf#29E?f0Y7G3_U8@^2;GYWIKb#cM
].\I6FTG6(5A0JN4fK1FULXQ\?bbNC43F:;O,0L;AC\30gV:,H.84[3@P@a^C/cc
.2-B?Re9L<DYJ3)e2NaJJ5KBYQ)-WXCHR=E_P-72O#A4?bd\SKX0OAa[cDAEP<2U
Kg,9aNZf1&e2^ZS[(+HE^28VUJXH;7,)9.>P\&bUUB^e6aVTI,2Q5dOf0L>89><W
Rbb;E45M^968=@N;D3X.]f49DNJe2@ge0E<VBAXOE+>_23)_.8cPMC5<P&,BA:[\
bC<6?-,c[0U)0:a1JFE9f+&</Y3S:RV3@]@V3T7+g^D,<OAZWSaf;E,YV/6LXUV=
H(gB((aA[+E-+<NO..M]::J24aDUSVRe>T11>QJ6954>TW)NM6c^]1E0K^G,OaD^
=&1/H,O4ETG=S/0:f&V-a_>b;2aZ(6X@T9@AN=U],97C#0>\MaJ]WOb<aZQcgMF=
ZX]Kc+#/N(UZD&WdON;g,B0Z6)gAJIYJD5(K9&:S&_,Id1/ab[-b_8+M)RKZ+NMD
3N/.FSIKRcKHRDGdTTU;d;JGBg/]SN)QC-GH^5YN(_AQI_TM,DN[bI99,_B_L-8=
^PgTS&]^?MAgE8f).,I1)-)gGLZSNcF;<R@JS@K71JP:dgAZ><,62-VX91:.3dE0
)U(ZNZ;Ic\2WZ.A9AWKG+g0DLXFX)Qbc2?G.F4QUYJ5IWRUP(7/R3:U]B@_;)6K.
NJJX]>CbIf(^XB;Te,>+BIAT8B;(UbS)\HK&Le=NL;EcVRgfc3_9dRgb>a^OL.ba
VEgC&3FDY[;TQ,,.TTYa37E,C],<]KIG,&M1GGa8,KK/TO9KK]dAR[I(NR#U^Y;f
g0?0f3E..3DT\X3RXY2EQFK==?JgXWSP#CI?KD+_0Y6:P3V4=5@-5MF.(_DM]Z9g
g@YXaA#8/_ZC>_^Y2Z7UNZa>#3F0:CH[YeI0SB_J3]3e4>AYAf:=V3]F1M0UJE)<
I6Y^d[\d7eYU<8#+&O0KTJ@4NcZU3A/F-^I(+&X@Z19-#W^aCA=.=4dNbc8<d)()
2IW7_NN2>P9cHV:F<VN,WKSUWZ]W/)^JI(cgIN0HC-eRc2BC3]SbKN,)FaP-H8-^
cK5()QNfS3^69KL4)XFPbMbXMVT\IEX>1X\[,Wa,\=MJ90b-YMM-#8=d/Tf\\4M(
(Kc\Q+5<:J/3&EHNY9>.)6,&@9EH[YDc5<]JUA?(_OE,XA8_T&W(fYF+TP[<LEH-
J765]S:G?fOZKQ#-9F0b#g4fHHYK,+C<;>@;Y:H.:,)U6QLVaf6:]2Ba_G2gQdA8
NE<\A7D;;Dg[H@NX@G]CJF:K?J.9Eb707QMN?O0,V;/>EMad[]BKWRXWP74W&?SQ
I[c/1KGf/#K;eVN\YPcD<88E=+BHLLc+A<=QEadK#)a:-XO]9#-1Y(MHZdI[70AG
(]/;B?Z76]-H&RZPRU->K:2>.C>1PAf8NYI]?&KE85M(D(+GFT=9KX#@U<-?H3E3
3^2](C6\<P5+6H+B+/\JeBLb-O.0-b1G[Q1GNg-2U7C7DCH984UCdJHM7A,,ZdS?
:H,=U;S@f>(b?.5QHP(BX:UJY\,UBb_J\_X?Z_f9P.M@.FH04A7[\]+^?C2XV<0c
GP28fZ623MVUE,,b#(\9Ebf_UfW9N6\IZVHD^D1(RJU85gF)BbQNQ()#fQ44,_3J
_(d(gL,6Q_Y?]3D>X-3NRMES8#D:GeTQAJ-]ZU,17+g#WP,[G.JReRKIBJBD:<A0
OL8ZbgOW@Qc(KT[+Y3<_ZEHNQ/8<OZ?VXI^3egPMe?2]?cH:)8WZ3\3[We;(_#B^
6PHIg8VOcBb>&e+JT\aO+I9W;Zb.bHVKHQ?2@0g)=SYB/GDMO#W96:(,&Y35V/TC
f6W<f>b?eC[AZ)D5KAWM_a,1J#Z..b9KQ96\30)6&3P6@(74eP;Wd0=3:MaWFF/.
8HUK8b\8D3M6GL8K/J#R816FMC,ZAA]O5#XcH-ac1:VPE=F6-(\AMKFT-T22,^H]
>FBF)2XF]dKS\809bT:RMV&5AW;SB\76(AUgeT^]Q.LY&6/@04T@&/0VH.>LB)<=
b2/O,b81g6G\,<<cH:BQ6BNEODJRfX:5J+X<Bga1I<@2eIR<_A\[1bVT=>GBSCVJ
c@F+)2K#M>L\a46+9bfZRGSY(^GFFNRFf9K/@9f@D/cA)+P^^4Z>2PVgL7_SNaEQ
Kee&8:-(_OZ42Z7X\JgVIF@Jf;c@C.W1)>3aa.WZ]0MeG[\V@^_/L(gZS[0O?L4e
.GCC4EcKQ0Ie@3IT@IIH@;V.39Aa]OebJ?@)(db9KGKH70LMLcF1#2;1a3J+\T#_
9b4A<6KZ?Z8[UR).GbZJNAa#P[d^e2W26RNN0cO0<G3[2+[P&.CQR^@Tc[<-1M.4
EK[GNGcTDH6T[8dKfMJcfgHZc7-XCR#CA8@Q87g8UA-&0X5FdY3S()JN-+2G5\71
\=Fb\cKGBHZD/,d/BdaC,XL<;7-O?.1HPf:#:_@-RbD>1HfZdGKPM_dN(c1DE&.^
^K4<W_FK/?9:W[XbQM6AD)WPS+W#+(aQ3IaZHB+61=/&R:;(2fM#FI?W0SXe>]d&
@//JF?e\1DGd4H@RPGQ0VWA_c(,6-K6b01W(U>Y..bU4;GPGU0eW^E?2#d#MaO<D
^?.HA:6Fg+_ITSTE@3NE^g/S5ZEN[G7b1e(\+[^^<d,I@a@6EY91O@FXV&cT^Og=
^]Wf6LE^A(MBSB#:ZT#V2HN+F^]4<f^X0@.f>I=1?^)@fc]>URO[AWH2I?,X9Yg_
>bW5MDU#Z^PZ&Za0\./VgfFIeTAdB;f-</@D(3W16Q4da6?/DVAI\TG:[aLYWB5@
ZB80ZSfW+Kd(+2PP][a/Y9.))3IPH=S[)\<=6^-[TaFBHg/eI2J(&9L\;S:DTDfD
dBE>?#bOX]43+3^XY1,M&PS2=5G-CLFOJB.+)B#@[#LD5_BV2(DF;Q])CJcW3EDd
38>J4]-E#?6Q9K72<c7)_XUN0b714.K5H]N]MDgKUZ:1V3X[DMBHQA-FO5?&c[=F
V><&-0U\8]9O>R(<(?JV<)HSFfaZ#Q9)E)X@=E^;I=HW-a2RP9&Q_AN>f[:?QgU0
<\AfH5ET?+e:CIgdBN0eS=].0PGO8ZP>ceM)FDMX^C5IA:X<b/b)dN#O<>HeV_Xc
-^0X=JVYXCXI)3^3.RE\N:FS1eBDJ<WKRC5,OKO]OIc01&2X)D;W4(8.?;NM,A]Z
Nc]?8=de_D7WUeU+&LG]2C:R&S-W2O7ba6SfONa-4DJEIL3KLM3c.G0Y3J/X+f3b
E)OPUc)T&;\<<+P\:GQQ5g6A2gg\DVQL?F)4UN?P>UM[++-133L-@:(Q9a<_+Df7
;(([S,-?R7.dS:7NYPI8eG,[?FK.:0U_e8VCUZPO[4cJ([eL?L-_F3+PG+2\R-d^
dcJLRd3TbX@Sef.>-(;L=f7:J;>EG6\a^&+f7J]2OdcXO7a,.\F,V8M^:b[15(O=
>+YLN,@ZbIb(:aQ..1Mf#KQc.ca&.O:&#8:C;5R4FE7XV71LQ7T)ULK3+Y:-<B6A
^.d27G/,MQg&0F=>F7Q35ZXHF,Y_?HD2>U9264Z/.H1+N?;#IJ+J+/c]eHYg+\0B
5]:>TgPS^;IYC#<DPV,/ONF5GELcH+XKDUbY)(Ag2/OW55P&>_0APF:.a;18J;JD
@Q46G.VT:e^UE^]GL,#27@PI.TX#SIX(aZd=E)0/A]X5PGXM7&KGe#\VdX29Z)W6
1Wf#gY_0^3^QS4Oa5\d<\Y]:2/fE9:J7^d](R\^MVJPQD6&0&.0-X(4]P:]W,13X
F9@)@&c3/5F^Y-&K8]-KBR_R.b&Xb6-c=#0ZP^K=BOLRa3aS&SHF:7<Q(8TUV^#4
Q&Sg=3JG>CO[:f9R.JNaRe=_]()dEV_3HA.e?D:P4b0[YLAfa/,bO?Zf];=;:R/B
6/LT,NBH+[J_&MMF=a[1EGPHV0/5d>.5S,PY#<^_3:4TM/Ne..S>ge?J.c_/:JP)
5-ad^8:KHd1]3\1<I<O]V#c5aVeRP01D)S:e:&>&BMA[.3ZaN)g&YfAR66_+D^ZD
W,7^6(KB84fL)b2+d9Icg8GagN/#E]M.6PSe,5c@L.bgfQI#S&W:3SUVb-JX/OEf
[?MK1[#(U8OF],71Yffb-g8)X.>(EM1=b#D75.C(9@gXcGPfOg_D1ROESM:)X8VX
=a8b331PNOO?<G85^(eLG1]IGNNFQ6N3cC_K[15dR,b:V)P8CfgMLJ,6bU0Z4/LP
#]@P03#dK18XAc+e;RE;C&I>:QE[PU]:U?E2g2_,F;aAb+@W)c-/>JXKd/2O>-L0
&>bU00IH,W/Z+O)^SNZ8/94F5=aPX/51#QbE_O:ITI-gb+O95<Q11B4G;GG:U]a]
?2)JXgfV;38g5f/DfT#5H54N;RN?YZ;[F=R9SF05Q<2)ba[[_Gga^gF;8Q+dLW]+
ZAd,:8dT(#Q:RKROBafOHg].8:gL]Y-C6GE_g&)])F58/PJXG946)5VY.cB9]#MW
387I)PDRfU]f@5YeQCRO_I7R9C?\+61N>PL+Jc9fO13NX@+H;/7aDCHHWe<Ke)eQ
32??5.#WW2;>dU8O@>]KBWXbeP,9>ABSL=7d@T?b_a&@U^R]TabdZ#+)_a/^.S)D
#:QWcd86L:(]4?15^XAO.DaUP_932Ig7])SWH+VY?,3fEL(VH:G,aRB9ZA.=V?Mg
EfN;RM2BL>.+/N4&KE3N@DeE^53?:1Rf/QYP31J6/H[[=\]S-K8]=_.Q(6/@eNdc
/a)\eeG)1[OF)IeG]:(7aIQBgP>UHHCa68RG&O1OQ=b5Y2:]X;KR-;L=<.)-W(@V
1b+Ue+V/BR;QKW4V[?.b^bY4R^8HL;d20JJc.:I]@YV;YKC+JQ5_UW0J^WV_@H?D
O\NTR>?^1RJ^/O\(Q]>,Vcc/2#4d0B3?YDL=)6E(#A.^.+=_cDH>^GM5OWfD1H;_
FC:O\V2-N86bf+9(dDGIVHTN=bdG-HRe2R?cY23?<@\.PVO^UcKOC[Qd](<=cEbg
M/A=05BZ#GX4@WD3dC.Jd,7a+IQg,T_,H5KVc/6Y4.B1S/SB?F(2/+&^8-S>29;8
Z36cWRg]=GP8c:#06>a#-WIM;E6YFQB]TOE/K=U-DMQP0B@:UI_+ZZ.J(Q=cZV7\
==<#-2O0:Z+18S&^Te#X++);[gd_+C,]R0,I>J_##S;?++L?;ICU>a7E^IUf#>\@
U[6LZIT)S7QMV>HTdd@]G#(0+5GDEf3W3gQd<7V<>T8AW+SUb)0ZYaS-_cGd[?D?
eS\B+\<85X_c/9g;Q4/IF6&A2,T0I4Z;],6a(?#T4;BID48JS;6;]_a>13I^3CaM
YIO?Z#/X<YJMGH,]Ta+BEP22D\SaER)I;7\=G(MK@fCGc1H\3>AQBA]4RU7.:#^_
MX?D,S_7RW&SU7+IS]/YVG[AT)=XK59Ef6+M72a-CB=@&2)/(=Q.IK5e(#[WIcZ7
P0Q@\N_HC.9RJ)1QR75&[/MfCQL16dC_VNd0]OPO.T&KF@S9BCR&\+e?3;(@BOH-
6T,g<U&-9PP@g4.:HY#5<X6<OEI>@]_JKJg)<=10[ZGCEN\e^?SOKSL#YFB\dJ2\
e7Y\O60c7^@R<GF::H.A/.??7G,E0CE?2f#Ia^aDCO;Z39Za4b[HZfVWV1ALaQ\1
f,&\+WR_/07]d4V(Z3[^/S>G4Q59_0U&LG6,a:.cJN\>fGJgfSYd_MV;,&)+IH,@
gSM.cEWcd/5[.]7f2&X8YNc&ID5SUMNO<:gQT^<K?E\3,[J:E?4/;]7cV8XRTC&U
C^LXYPHMMV4@_1?IGMCITOUSP]8T4\VK-#F8f#?/_B-GdN#SWa:f8WVR2Rg33+DL
K8@NSbD.M0[6Y+ZH<L<dY82X:GYLb/_TYI[LRb6R:]9CeM4#g/74UUA]LCT@;H/g
BNeddX[Gg?@:3<d-<1/,9C;[6;MDD/6_AdFaEaP0Y)78;BZVcO4[b6KB<252B5;)
G?XH&G65BJPB&[-^e0F0fQQ83QHN\=J_58E0POACfN8)P<eP6=ZN9,TM,N9<)3\#
c8)[H76:58-Y+0/T/SV#LINQS1@g.]2WbbE=LR]9NDA3[.74;;^_OXU;9>].c&9L
-@G-e-V#O@2.8+U+H[-F[:)CC+3Q?D;/3_0bgNC-L78S8)ZO^56\P3.cA&\<B9.N
JXK;f)#&/=U[[1J4/=G<gVJG+gPQLR#)PR;Q\F#bEBF;TP^0^\+63/\XB0bGI&=_
](N@=gODb=AP;WQ1@QN.-JU6@HAKMd86V<N^Gfc?AGKSG)>JK^]d[XH<VMI6LC)8
Ea5^CaG@YK.3MY2Z_&UBOSITFVONHSZ6Q;QR^75=>Re^d6/W(<6Z(D;7Y2_)a,E6
>##@;PU6>3bXNVMeE^]@Jd.4&8Bef^2K>@;e^/.NAM879]),PbV8IO2-)&OHXES/
Y9(B&,eEAGc4V/;E8=M4-Q4<;42G9VHO_FB\(#]4b?F/9f422eW4g_S?FOU@&.A1
MQ3O=)-QO9=?JGLQS2EbCef1H<OMcbB&)9J>&:BK<S\@)>9H_PGG@;^b_#OAZV+0
URV&+Q<dcgAL509Sg[;HM+<MER_IUM2gZN<=GIK&PD@1-R4de6c?J]#XcHX2DBAP
7T__ZCK(e.\&C</[&;UL9R,BHZLCJ59K3a&ANNIA/LF7IRIM7L87&EBF93Z\8P0T
V_G]>X7V^H_IADf:b\-LUOCaOD16WS,W;+CPO^;a1=Q+D#fe1:eeW36Vc6>]0Y>U
]?]F1MZZBdLD44D^R(XK^XHUe(dTO6J^G^9Q^U:)e=18YY)#):F-Lf_\8TV)QT<W
TF9363<IWNLM.#EL@e9O_Bb3c^<?f63bbZ#R.SHTN50U[\(-D6c>6d.XGNb5#Ec=
/Y#5ZCQ8gVK(HQH,;,VZQBR64XAUZaOHL>c)Ca=Hf48Z+2L0DXGU+L,#^&7/dg&(
9-BN?,1_g?L<P?&E_LE=[QF\;N\#Tc+U,H9XM7Y)a0C9MA7fQfYW._H#^e680=WC
R(Q>C=G<P<Z>O73dK?:S9bGfV._V.G:(E<50g;92\8^F76&<HLdK+0&>aWJgCD[C
ec#C_=@\ZFe;2e7b:[:0;TRGXGM0[&a<V+;+Z,U()]I,FU&RNO&JS32QH5D@VVS8
H&G)B#HMLc4e.eKRR>c)YGOfOMeX79Q^D+2DFbUPL4D^<.32M_D6d9LEBFDVg-/Z
:EGA<^+FW),5#bZ8ZUF>ge2)7MB39YaN+:#Y6,^P&(+FHLF=H9\8EZAQ9J\4USW0
Z[<1DG3I7+T3,EQg_ZXC=4(aJ@FGQ?g,3G(C1YG5ENedSVLH33PdJ6g+P6/abCe,
f@7B.&3.\HgNMd,^O^-?/<<If/I\;_&W=G5ICK)2(]\e2-;U]](&(\Ne[cA:^@Pb
gBK:YT=e/Y\S#8-eN0BN+FEZ?beM3^^@1<Q4^2?47PVCLGd/B3H=IKW[.9:_@[9+
]dLMX+C7I&ZII&NdE.2Fc&1>Ua-?W(BeGNK8K4PRW1.=A=c/Y8Je(gT2\f^Hf.20
_[\NB@V6M:]C[)?F=TWaX4[-S=aZ=_LIN.-&).7/&_TSBeAZY)bEK7;[AI[IW4>E
A;bCAPU=C(=9&-&27aB-&S[BFb5BUfHYK[T:[EYPRE/OG_IAeDM>E;XgUPg=GOX&
5\B0.B#+<PXW;CWG--?C6NL49@Y^aV&K=/b6FJE[EAJN[>([WH)eGK<_Q0cJe??S
Y;V:?8C@YKC#O#KFJ,GX\=J+\^f5dgLPFM;KP:\]^8[SEAR567[DaZPW).RGO@(_
D]?eaPf41DUe^aEa#Y6-a7_DP1\7=^::7&?87J@?+Z4.&aVe77X1U42;eDX.G<R:
>+?a<,[TVO[0QV]8\PPb<L4/OA)f4HJ7BMRI?;5;TL5W.[[QKe5[SbaQPQA-8;gH
+7O^NF,&&KJURL(DL@2aQHaOZ7eVT5(;>,IX9L2KPH5VFH:[H_CSLGMC/6KT-83E
EPC9,2Q=748W[@J>?d:,d,2(J8=.L/6,)2FRPcM]P?N?7fT2]?)Ug\U4HcPeLZgc
Z?aHR.BUR0MQ<F(22W(J;QL72Q;7L]27E2TKFJYMP=5^_H(,KL]P:G)d;@HSZCA^
BbeRF-\EBED>>fcIJ__5W.O(L7L-Z2E,aDWQLMd,VHdW5?2JF4)F6YeULf?JBJ.7
Z]G6(>]I4I.NVN>((6IN&48f-5AXO07cb4&OOCA@VMD;ZE+eXVc(:K&#S)P;CE=/
-5@ONa/G[?O-LO3(7,D44b#4X7b8d)NNg(CTI,.?QbBWALd@\L0?/5^-b[A=+KVU
fcVOPN5Q[PNMW9>C&g9Y5.MM>JR4>5?fPDAVG+1#Rf,FR_C[KQ:e(Me5J(C9?NON
?b@6Z#R,+F&)C<ANd8XPW@>SZ:24;^\8HM@OYbVQ1R5U;PSCR6\f>EHQFYUIC0(W
WDgXc;S6c>(#(UR<1<f)0LBZQRLbX[QS]TGE<;cNO)-4R2N##3(Y2TfV]cJBZ(8H
KMV[@RPe&X+R(5+UQc=Ba#MF=S?.?P=YfM=)-.QX?]7&.ZVe6W-K9BMAWeY#ULNP
>8FEV[JeP4fG20<QYLb2J1LCS@I+\B26>A]#JK5Sg-f;XG+Q7[^^)-fI:J1?^;aC
ePE8.QZ\bNEL/61]1FH][FBbNIPQJ9;C)UIDCM/PQD-TQ70-4<I:;_2L#VPS\W[?
dH<(FfHGc.#cS9(GgcH_CC>=IS?\6&.c\[IL=^XUg4_gI5C7CVPAg+Bg@46;fgJV
7I7[Y0,[[,40F_R-b4R,JJULV2.CY>(TO>4ga0d>\?D0GOO\/=UZ7\aX/Bc5M#g2
/L/XLTYZN#X2KZFAbPFZ(H4TD2baG7K^UHZ<)T1gE=3cWfD40d+1)-_1,K[KfEZ1
+9<?ML/U?RE[_@eAZC5@bY0&WW\GJ;LVga-0V3L:_8+#_DHHQ7</fR7?g\@Q\CZ#
1P-.LJKI8NEA,_&=O?2J2/fICM2g(2BNL+[QN:24aBH9;&(YUPWf_9>^ILZFXM5[
6B]]\#B9FGF)[3_1Z.;NA8H)-[A+)CLbOWMT)<ZE+;J<0_-GegTZEZ,,71,HA/+f
4CH.Z:5FCgI-TZ0BR7AX2-+Kf_W.J.0[VSRaYR30=++SN:SFV^?UPU-)+P9_6ad6
]FAQL:_I-I8PT?2S>D48A73_Y_J@D@HCD8UKXece,DWG3bXGFbVLS,\SZ_E8PJZJ
5\R;O]@T,(:Ca2XZ/2_7MMT3XFI3cVEaLCa(.Y#G3P,gg4#,GJ/H)gff;,&@+?Ig
#Oca09/UXbfG9X8QW9c0f2Mf2&DRNP4YQ53.]]&ffBL7V54Rfb(XBU0Bdf/8#CLL
L&/7?[<d74VaJ]^GARWP[D1g_@e,;XZdc^IPM@55O#70:?;BHB.YcH8R20OGOD=+
)I6e+T;DDOWI-b&a8.9HV0[8TM<_2?&/U=9JE7?MGO256M@aIT@\W9TCB=:aQTR/
I<Y([-6OX[_XNE@GE)>6W;D;JDKJI@U(=AbPD-a-/^QH,3C48=6da3V&7A?d>e0a
SA1FAfbWUIAS=b<>RTQ7=Q1C-Q>fGB=G51T\R)</d46P.=SG6Wc#FXIa(F(gW/2X
8ZC=OF@JTQVSaHNN]Q\7?+O\&a_NE;99S_;ZaQWIaXX,^Q@+DYb>4F[S@VagSO0K
XgS>>+L-;)E@@a\bdU;HDKYSQK0MS2Ie20^2)4S@JX8XPS45]gY3&UW&?FId<@E8
J:JN?#)RE4<SHb.3dU<Qe3](e>RCQ.@];f]R2E]0ac8NC<H5[fHd_:TG^YC(_G(3
g?,_J@fIgNSV9HT,d;0NMCUB2QEBB&8\N][IEDU]#\)B?9L34WL8Q-E=VPRUW<N(
.=#Qa2)?JR]82@5;KP:,NZ/bbY26A6<NJ0)J72TaW@9BZNbBJ4QE:e(.>W&Tg59)
4>)Y1@XJ/,cJ1#:=B8K:.4IY_(=dLMI=^KaeD837K6+a5>(F>E\0[BJ-X:W@:gIA
OD=8D#+2&[D=S:c?,9@9U6V9ULM?5VCP@:T=NPUe7GFWFIYXM+:7TO#]E9Z1:I7P
gC=7(LN.JLDf)Uf6VLPY&E=-3;[98,4(YFO<&8O-eLM,N:aL,A)cIaW2E[Vc.O0T
@4L;3I)[K\E6c<UdN^D;_O0EFR?fe;ELbFBF[PVGNWBU2b.IM8N^9Ia#WFJAQ7\;
R6@aDURVeK?1N)gH)FX3=LWM37K__g8cKCTee&(HOgSJSTGgFXJ.LS;U?<--1V0Z
]]dcWYD6IF6[I/,4?&[DVEFH@BB?-b@KLFWFJY^G:fcT972X3=.2S]d?bT.+-g5?
f7#HD@]CLSA;f5CJc8b5WX&&Q&RLQ_bCFY^(@9f98\Q,Z=Z;&.?5eT#A75;@ZBH;
@+8P8UKNX&0]Ma&d.3UCH>]B)WdVD^UgX\^?A/I&,NMM\d)U9F[8.2f?KRSJJKRA
b@;,<8PI97KAL2LJS06Q[[f/Jbc^Y@P6/fa@SF0QP3>?UbfNB&88UT]gOc5M8G<J
V,Y-K.a3.cJf-8#e=9B95FMW30>d.C(?QBHSA3TKR)>Q3.=-b[1KXDQ]MM5&@QW>
aL(P@U:ZA-LaT&IOPNA:5dLK4f&E9G&U/BSKF_2<5Je5,Y6[PV&L)+ITJYg?D0.@
2<KcI_+cH,&#BY.E/L=LgO=@9cKSUX;FY1?7NOb@F\UROeFD;L.AIaS;R4g6fXXe
11JBZ02CFHfQB8E\QD)HZDH:Acf+NAX\/,\/-CH[(e#)@1U?:cLUTQ9_UAC70B&\
_g)RBDDV-O6+B/D8US4EbT5=C]?O>3C;NH?C-4J9M:c\X\PCO<Le>e82Ea95:H;@
3aJO6;80GEME64=Mag13N;28HJR0:)V3+cL7fC_4eK5.b;&(1fJKX\0R[NaEdfa,
@Y4-E2(eIfTb]E2/CHSYd(>9fXH=fXC4S8#QV@,;N;#BMBXT=V9e<R@L9G^<gV7U
RL07\B9Q7>)(#aPa,-_.Q[S?,Q<g,4ZfCd5:XM0LP@],fG;aa/aE;a8-Y.WZNb:7
XU[1?;NJ<4J[9f4C6cbX=?g^IHZ>J3Qe_gcH9&BF@A1A\MOG4/O^4NYBGWK]>B/6
3c#C^+K;;,S)N0VJ5;cL]R5BZD;J&-GQaISfJ<96&S?.B@^fJ.[V=d8\U0Z8\NL+
<3LZ<1Cb;>Q1\YP9A9<?JPFHQWdfA:gGbHFc86,?OC@@RVGW-?RK.@\K#\83L5ZC
&X;YPc]aLQcfP,\MX1gSMf7/g607D1TTZTaYWNMQ]PIBRgU1FSaB;4^^]f#W>L@[
,FfTdbMD]HBd2O5cXaEIX/&.CGGD3XcYG#f/1A:g(&B&fSS\;/ANXR2?0]JT85:#
#a.#^M7g68@RX[O]=DL86(QS,)[)MS)#2XgPf8;?==P:eP5PM+I)H1Y/3RT5SfC-
GL>:F->5^GCPFH8:.D,BVP,9O2(\?^Ab.,cJQ:1DNTQ6Xb\B8MMZS8RSaTcY&8=G
\Z41@;LHMMCf9C,G.<Td]-Z+6S4_f\S;YDc,,R&G.\2/S=A(/K;#:KCH]KGDdG7:
I#X]V,S0[A<L>R.K7aQ^NBARTB.SMI:bDcTSSY6O5F8LV66_EBf+?6EM>SW1Y>T)
H6ZAXT;g8#NQ-U[Re0N()5#/=H\K_6E5T6D4>Q7.I\ASE/aK+fNFG+PIU\>Rg0G5
7?BfI<aTT[D^)QZY[YVVV=;6=YCSa1YMQ(_W8V,N8c,a9KgPHXWc\@H1D6d[CO(c
K],?]/PQ03N&<:(+7I(R5^-V\+L9FH_@Ee_8I1A^#GMYL6fI+\g(NNU(--?S?1MC
.F)5KV9>E++4):N0+bMd(9J_-?\F#:dRMVR1A/3\Kc&>IXWH6.3V81_MJWIKgJeC
MSDIUN,9SYZ&W?EI.0VL,S+gb71F/9]C#Y-fN<gEZ:\/[GR)./-UJ;;Z5S=cH4g;
FRB7gbTSFa.WDJ6f:MR1:(MELb(UJ8^4^PRG.ea/Xf3JKSa-1c#U).c#a),WNJ<+
Hg?W=P[3EV;d-CI:3(Z8X+E4VF=LW-@;Y0CG#T66#f@VG3\eF3AL2N#M]bQJ21Zd
a-[fQ+)f1OMV02gSC&:Xa#YG@eVK3.^PU]]5X(SECI0eBGM[JR;;HeRDX4PRd.#V
&^8^dA):DeU5F&WZ^4Z[]I15a&E2fN/)&-M,PHK7N6<-OKEE\T5fM+-F\7F)Q2b<
Y?DN:f?9N\\Uf0AHPb9E1P&0J<DS@agD7UaV3)eE5L7:B-(c^7fSL;8cXY;#X.Ve
;D2R?A9BD_07XF,F9FG@AG-Z>fH0^0?2Y=AE/OLY_^ASbeS[HZGHK:\:.P@HRO2V
ZcI&P#Qaa^dc+BQ3RK(>GP7^K4g]=\)\/49Ob,EdIU,U86GS#WNH&G<aQS,5PG0A
6e&Ub<]>J,NKFDMcb300eJYI/XN36Z?ODfAQ:,SESeUM;^-)\Y-Cb8-9,,DgSZ1N
89-[<Q)]fKJ/QTHCc(W7?F+FHKTU4J-Z5T-LLPQVK_gBfS:CdP:3OcN^ef##,6.&
U1U(:6_GJIDVg.Cb2PB4LF&e4;JW-e:.=ZTT5g3c[-.QNQWa3Ig>(Jb]SbHYe2Q&
-YM+YHL<@Y09@,1?#2O8GLFcL9egG#A;VE)2gYVXB:G3_a-5-gY&#Gb^;Fg=EO0S
>.0O_a33<[(]ffWX+027M#ISe.SY-&S(/NFY.4#7=e,A;A9(WSRa#3]_^\HFN<D@
XFZ_<]@a<=0Te#1NJ=YG\JM=#?)O:H@(?(_(>^8KC<,+G+UM8FXf@[FD8gK:f&IN
^c[7cWAB6W#\Lc97>#H4W?]+S=1M[2A6F&:aBa;UE106A,K^^C(NGedNC?9E1F#g
P_+F-/53?,5)^]RWcLOa4\G9BIA-+A_8CQVA5;(=d2B5cCdH_3/H(^/KIJ(532HJ
/SfBQX?2,V-SY(A][?JIKJ+&IFN90Ob69+;J]Mg8))?&#1bTS;g0[1d?&\-5dM=d
[G[9^ZWCd-C(2RWTBPX+JX)=LUN7cVD3XJ6;>g(L/J=^_d<AQ[#]2Z7Q[+Xb59L1
#&aC#G_CL:c+4HeSZb,691_K(5E7Z;/PD65]+?>XB,I5X2J^Q^B<c(+A<]cJZUPg
;_=VZ1K[-/5eOM@dI7VG#;;F69YQ9H0,e]Nf>O2\3G9]0A@HT.7QOfH]D+C[E>].
Cg](LJEY1@AJXC/&HDSKQ-)b:Xa\-(AK5Uc=-]MBZ.(@5RLGDP2Z#?/[WF,#6B4:
5[_CT>._YAL56,=E\eTLd)-(;-BgV@4+6YOeK=-M8/ZG[XF>+KZFC-YL9T@]@2,,
QBB[^&V-N>M2D\(,N:GK<<.@G4J1#94AWI4JA,?0]R1T@[_@&S-_P>8dgPCdCW84
=2N2P-cU36>MR0=_10_W;1eNTCN#(UFR+Nf/eIRBdP[a^DTeKHgI0>8/LFG6WJVB
Z?BXgS^Q&=.-S2;UAc)@KDQ2]\EBI6.?KEUaPAS3XCDeAK-c-X7L)cG_/SVdX1/9
a0;HE3N<fK=5R0@ec[P@+Ec_HLWTa]5H^&)8^]33Eg0(4N>K)adFU51B;&2GRD86
d_+RV=Q_A72_MbaZ)Fe<cdQb._&UQbbX>Vd]X.?aL?\b=75bB3a((06T.aDgA=Sg
/^IJ^S+F.:\BK;-&X1]/WHAaCC+d8BJD?eK/?6Y4BK4caB2D[b?M[[CN7ZY&XZG;
O=[;^KfVPP;9AA7A+/c+KX1\G/c7U<S+bMMP.gQ8=KbL[BK5LH>L@FBNfN1^9b?R
B+#7A/5#K&B,gGf-[7S+[G8>Z8eJJ:aBT=4fYXd9e>&7MB?V,?X9,8F+gQ#Y_V.f
]>V4+71:U+@;):G,G0<J>_>A3<A7TQdRNc,;c+Q3dNIfc7e8S#LSP^OfGCgB5A7c
M@b65g^&-S=PU><+9H<8LL<2)8O-JCcGL91\18X<aJ5&,C94A#+NPP>f[0d0fQ\<
0U#4O2MBET]c9:fF&dU89dQ&D.LWge:)<J6f,@_T&B.dC^1.FA&fA_f6Q^[:7#MA
+WX<e&..H2=QO-T;#(:5^N.IE+S50\K_&MU,P^1(\1J3Z8F(@,))]E#OS,7EK@DE
CJc+0&O497a5AdFY]FYc\g@>f)KC6?3/[^IXbZ10L2R3-EdTJaE96#1[^J.WP0(]
<=X@b+-9?[HZ.]SaN0FTO_V4DH:BNcW4TIbZCE+7<b;^=LX7d#>18GSbd&MS8(@R
PLe#UR4DOKYQDDAGK<]2X&,J5<R[e+L30A+9RfV-+;OK>BK\)\0[[/>/TdgA:VB_
9^AU[UYCd9U^]:633<I4M+\>.aQM1,PK,J7c1MZQM]:2BgaEL)37Q6,::g#c>(4X
>1-DD:OMgC+E0A8VgWVNC1FK@V;1FY<;G2[Y<b;IGX6G\+SB+U-MH)eNO;A:JQb^
9],4,fE#FVE.\KMLP-3C]SO(=PV3WfQ^AN3;DRa:2IL\).AZW0>B?O=DQ&[08;-Z
AGYZARD[GG><f+TWXb/P5/Q8cXE=V)JB,XH];B[Yg@6V@??,,(U,cHZGOCY->+XQ
BJ4g33fA,=?Y\e/Y7:9TZJO&#D(&g,fD-+(Y+OfaVdNg3Z;aN6-89O)?2Kf_N^V:
A?6,ceSc:B>)<MFgQ3AW-U5SA(;IEFRV.);7]A&>?UBGHVRfM-)E7Md>82SVY8VY
IBGJ]N\[8)9d;5.2B)[(R:FU0MCKCdO=dRL1]D5AGaS6\(=,e^>7>;5CE^6Oc6MN
QWJOJ-D9^\G.XJU#RMcSHc3QMAAJ4Y\+5X_/83;UKNCdUS/QYM^PG068:a7[S:Hc
2>KYbRSW#\/-@=D.c@6TZ=PB^C71EFZ?Q?aT:XYQ7,K5>AMAW:WPW2D8f]9Q3(3N
.9WY7,4Z.]eR6>9f47eAW.QZAB8Q[:SC]?c[ZN(fS+GXIX6NCG<-3V[f/8B=JI5R
J_&J,B@-#@?#E(KV<]61+g3#HZ:6_0b:ET[_:^T-MfeP_Nf;=YBBS6(AC[Q/MLBX
9eKcUeL#-8)#;KWX2@TR2GOIe5M_>LW[UM50IX-PC?UI[R4^1FU/V+f=Eg]0\SF?
C1N^3<HI@EC9._#+P_DcUea7,b;2V>]G719QGR+C^4Tb+<5cQG0[5O-_V^5)cQ4a
OTc)==2Z,#.3[ZNa^bgRQDMbFWe/+ad_4GSTDN4TXc?U^M_^37?^IY8E[94L:KI9
\TBObI^B\D]cN>9]E1Ad6#L\SeJ]=;b)I5aeU0R)De9gEgA4N978/N4R^O:^8RJY
<gIOLfe^LeGA:]0?B&;A><C#JVEQKPXQ1+T.5UVBKd=A92W^?77L:Y_50D5_/BXJ
Q<+?A97gA\#Z)_5>H8CIAYDB8[Jag;-c\_I2R74/T6OFHMD,_g?Qa,2NBfQb8PWX
KXPA6C;1)T(XVJT#1@6@R+b;)+gJ_US.dPJc>BYLNKC5P04O^HV+CX;3,=U=59gI
&6_YaLKIO6gIB)WgW5HG?=7gTf=E#_0-]1c_SR16c^QS;ZQ,.IQB_&:2X08=HZ@@
;]g^?d07XcZ-4SUgHKRW-6)429K0bRM:L#MKZ-g(_I^?WO,FK;NJ^/XJ#PU73<@e
J@JKHM9):4=P+,LCIb>MVGNP2^VO66g6,EB?2Zb&L6W+\4(10/_#fLJ&3DGZ5g#3
e#a\>d<NSIV8I^J8+b#(?gY>TY+0=0VQTJ803.1=&MBA3Yf4]c\dFG\AgQ_XZ./B
1dd>3=A50W5S\0B=D>[bb?_DDA_7+N[+@Z0?_.)_(22OQ<8SIZ_E,c<>SM\GBO@^
a6ZG+QB)84R=/4MY146)<JY=IeB^01P)/eO@(aU4A-gZ\;-HgAd]gFTL3b5]:8]g
0Q_8gO8=PJdKd6.;^W&/Y(T5bW8d#VLK6?d&/M.HfJJ?YM-\C&A6>W=Gce)N:/DN
;6bUPMX^EWe1g75@+&:;D^c^QY]@M#5BHN^[S8D,_:M;X4#@OcD&ecd=4-MCO.GC
57AZF]RX^-d46DWQ;PIg0=XNe6Q-\IU;aPTd^EbUdgW_1Z4_7F1.41JbX&UPa:U>
g\-X?L=J9:ISWQT>(=;2&\P_,bRZVRQPBR6W#,?6JBM.dDPa+g@H2CCMg-V+^4T>
#L#OLD;aW/5-4,L9Y]?=Ce[YP0QU[F)T5SRf];SV@7R/Y<_+VD(ZMV6@<LJ+;H6_
(G2P0.08U3bME-@cTQK72-JZf458-L_9<+aL&@#A]W:C,b0,=V?SW,TdA3a#R>-B
N=RF]J1&e.Vb[Ld24]cS\P=ED,U,]2Lb4ZE]2NKP&23VeBP:61c,gb=.L)5]c91(
J.7c^AbI&<IQN5=Z0[3[-K_DfX8Bdd/+\Ta9G?gB(&aQ4,XV6U/;QAL@)MO8XN+>
a=1b+BQg]d2I3[Y+XWLdHM:9\<+&QBHcQ(G<&HOb@,g,I1Q:I,(=Y@<BeIV1fIO@
ON]B4NQL5VK./Xb:0OacSE7+eH7L7I^S2O3A();J6]LII=Kg&]YK@E+?7(aaL28B
<#9g&eB7cb5W=@CS2/12X5J8OGJ/=YT[N8;S]OO4g/HD(.\?.UbBC1gPe3<-;>.G
D)2<M01VT4-Q\-4B\3g<P-cAG6eBgB?fOV>5NN?;0JY4>9@#A/H2FdJ^7[BE(99I
8.Z_&J+\:a7NDLBWF-_9J?NC-G0T/QCQ6>UN3LDLcfGC/[IIfVcL&@P3CCYgKBLF
N)<[W9B>U\/#>R1@_GgG1,MR\S(X<Z8VA6[R,S727IQXY[F-G@gTHbe_RB&2WCJJ
UMgUIL5]+@aSZY2Xb8UgU9YC_MM1L?MVQ]ZAJF(6:@03ZU2/HXB=fK[b7_N+-3#M
f0NQ8>WF_0K?1:MaI_F?Z-BYFaN9gWPCVaA:.APgBbA?1Hd.I])3^Y\1?d6Ka;?\
[_/1??G&N^gRH,^KE6G7(gV,f_:?&_>V1.cH)_^VIY]J;Y2,.L(bP+QS#6^He,6<
F.aS.aH@?g2FQ,Ib6LN@11_aB:/PEECLJaR+Q]=>),)/JQ5S[GY\R#dM)+\fQf0@
C/&#F_#a5_7D33S-I0+430GGde?P+WY()?MTdb@+-^?9(@5:KG;dX/P+[da<RZCf
UKQgcB2Q:P:OTZ;7g9d?W0-K&2QQN.gK/P^<T=BBDE^ESBZ7L?7X]A9QOF.E=RP+
Z5G&>bYbWW78L@VE:^J=cLD8S7cFJ6IM47P^\8X7L6.bHf>53eRP:a2.COLHXeWa
=acCJ4K&J04=IXeT9^6O;,d;4T>MZ24-[-H7V95T<-F58VBT/>(K.T?NBT47TQ)e
IXVe(-DN?(8B8CDR_NeL6NSXPN7M7ff:8)1d-aYBCX6;UE[(D)+E+_f1W@K2fAA5
B)YM4>25@K\Fa&3d=ga_=./##Fe.VCaEC4e;TM@8e[dVT1<cZ06D1dYI(M>CVQW]
g(8d(a^63eXRR[HA2O/f#A?()EGS4Q>6BD8H7S8CRCX8X7_L?LTJCD5+gg4&>V8b
dW;R6N.a-+-R4bWX/TV[9&V@,f\+TX:eR#\+b?I&[O[]RXV5AC.GD,USL+H2fc]7
WdUKAE\Aa@I:2;3C3OUaSeT]BP@UIIYNO(d9&K@9;f/ScAL/34+.\8C,U9>aBA)S
2^G>^R#_:LH.fP4BS1>@P[J1J?LHIM6(/gYD.LO@Be\V6>ICef8W.eHJY-WGA8Q1
/NBRX#<H+NNZMX917O77YR^d30G(/GK8KeQXI2)b&YB9&=:VVE+@V&dg=f(EOSL,
@Ac:.a&A.Na2+&)+/N#[J\cGCbb@OCgP\O0b1@Q2<?A]cE)-;a-2QE,X,6/-O_Cd
3STOG#Z6,E131Bg&5ebW4?VgE[MUO+D0.Tf93=3;L&2IXD1.)@^5dT336ED?9#./
<MS6><d<]_7.d.2D,KISB85ORc@&b2.2ZFNQa^6TQHZ(F90U<(Y]+_/?g.VU4\H,
/4_L;:0G&WK0RA+c1NBD,)LU:C9G(91X0=c[#a4<.VHV=IW6)(&MBd9Ieb;TcZPg
G6ZE]06W5,c1TMgaHH^fb7AN;I+I<Q,4U1<L)c=S5ReG=a^C2d[MMAeT,f8K<+3D
@&gI60<8D2EQb5@=?&:A)-/5b:NLg.<6X7SUT35]F[U-)ROV>,F-dB7,&9A2RQ_^
J1T-#FF(C9^P:M.+(c&D5.<b>@#eLJYR1BJ./HG<88N)LTX@VQ;QSK=QdGRcDC/F
G,=&9TF)A-g.)O-&3\FGZR/YYdaS#W._M#[b=C\YYBU8FH(=R#^)H_NG(-RaL147
^6-^<&N+>)eRK71H6df1F5dIB2,4JGaLIVK/)aP)Ma:O+#NEI/<LWSZLR5JM[+dA
cGH=_FdHde5@OfXH:e=\2DGQO4Ub\=8[gf#dZ[6AYU2I/S>C]Hg]5K#Wb;BP:2b4
HA^M]CC_0f=#R+S\N.:E^bgK/^U+K]-G5bY=,U):9W;QW-QSZ6H^dXS>Mc6MPg+/
Zb[c2U=1R_[@B9O;6Ac7^\c]]-I(e1DU9Xa&FLA&QCYYJ,@\&+18S2O,RZb(:P&&
3>L3NM@#4D[)c=((SB^C\,B-ODGgC4F?J#?FXI1T#G1E-XcCZ<_Z5cD=&&15-Ye(
]B(EP(2G>\MUaL=PdIf9)TN<>5\eTTfR^ELXbH1HBa[T\YS.H/M+:BJRKK-?.gF7
])[Dd[7.-bZQ37KMG\7,@G[(5PH1e686b-.[C4I2BGGdMWT^;],#5U^4,dV(8>4M
Z?Q1ILfS2[P&gPT7bG)E]IEb>7Wag#eCK]&KAaD_4<SZ2Q+9;2\:(R42gce[MSV9
b(\<g5>&O8E(VT=J2QC1C2/NZeAJ(X:A>Z+&[/)GA=AE:IS/GO]2@:=eB\d(6a0e
YV0(^WKcg6VW[02;:;Rd(B]NN^H0c0)SG9f267W(M/]LK.fKI2Y2M7@S(1-d@R(P
BT8XPWAR/I7a_UM8?E(+#((=)/MLIMI<JZ,PeCOVf,KF5&EgEU>,gVaJ,EC;6BE4
9P16g^<.fB<eEQ_SZ<K3eST5=P<3PD-dda3ETg0GWJY&DQ^bIA;8Q&L+;-F>N[EX
_P<dge3T_Te3#F1,aQ-62<cVB&H>BN9Z_T3EVJbQ=>2X=58<;./0J>)>QbZHDG#9
eJ11FD/UGe&f0RAWX@O51Q]?N^@[?4Z\eQZ^1WYW2APd:(QZ&=X<4,#fXc=gJg4>
5O:.2I5&6_O;J-Kbe;F+ND(2LPJ+#4+FRA&C-P:F_1R<7V?+3-@DO0ZG5NT+M\aV
e]4M+\([WL-6ZX:ODF>UbX>SGK6;<0_OVM/bA?d)_;>IFI?+/OBZ=e^7HO_FdO@K
K759+E]CKGc,92?N@,G//b^5E<_5&[-@>.16VY-WbVe8G&?dI(^K#)>;ZM+^?3?[
6L[^=I>V?VfD6V\fG0,AA@G4RQQWW<(X&5;T41][14>=X9\-^fa4c?Y.N1[J]\6Y
V@L9&dH5FEC?<8Jg@]</2S1EJ/d/I-T@fA\:Q8Hc/3]T>+5,0]46e,2gS.ZT[U/W
2Jg\L@16H4;La)YWW_LE7TP8<0QM==(HIAL7,0Z7^F@5AK_]L]1X@d#0T3<@2-Vg
MSOH/JX9DaH^+_/P#^2&G](>DJ@dI@?1e<D2M.ggBdMD@F(F2E<SRW>9LUP[3EQD
NTgg1fb(G+fQbb4[PTgfX3ZE&J<U;XNIA/dR3bRK(N6.+cbVdSG<VX_WB(=WdT.O
OgRJQI//X7K-M:(0Z>3gFf5N55OY2/LZg+EbF/3I81\-4=LZ@#dTMJ?[Qd2=eAeS
OJ>KR/M/L&QY[Wf3e;@Ob6YF:E=:d]4;)H7E+^?<?AH>YMC/)9N))R[b4JNB/NO8
WC<AK[B.=gPPZ@E#(?B&:6,>LDUR.>#VO5G2]]&024LTD>Z\a<Q=P1\UJO>5J-.+
H=8(Z[8H5(<8TaR[Q;W2dFDMUL._8^aWgVRWG]K4)N-DQYQ<.#]3Me=:3dfTR#-<
eF-LN;gN87=NOc4aE[9ZQ\1GB:BVa?-M>##W,L0P+M+[;KMJJ(-G,Y-DRNW2McNV
ARX>UNE2&eY_?,H]F>#fK@P13R6?=bJ95X4EEg::T:MKa5Id5bNGO(XL\P?#\:,?
daTL[=C8&VWGXV,XMHPgKb^Q:3.S[)@Ga.V/XOG=&Za4_6H_>8QZL2WL4SZ2^&(6
7eAJCVL03d345W;_V_ND5+DJXH>(a4c6&XS&></X;Dd>a7c6RAc]-<>8@)^VV3+_
Tb2KMdAYG3MG-Wffddd_MQ:O-#d1M-X7@X3G7)W5_<;D6Of#d<(Y036C1Pb47L_d
?-D9-.+F(7YI;0)aD,@)b_?48:\Dg36aT,2-3EN_3C[_9NVb9R2NaUPVOfMIOV4N
WbM.[)1c5c/(<8acZR)]a/2@JPbXO4ZF)2NH\&)@VI[4XaN#9[580)e+C..@IIM[
S)eHc>ZI7a;?^=+aK.UPSH;5&UDH_fU;eR779H9VaJa4<G+f,Z7Uc3FFZfY-7QHM
8N]/ULH/@Yg.FcTWb(S)/EU(BD&8]I]>?5U,W.aKS@7EG7CH[gaGDU\#LIQ&eDJB
B2TI4Vg<CUc-T7bK>9GX@Sg-e+MTNNJ8^>>[QFNE40Ra8TB7L=LB_Q?eD3V^=1HC
&AX=M9+FQ7K=cMIJ7Y>R5LO.3V(35J:)JGRHe]e+aL9IT=20P[[D0E[/<^IHPJT)
H</=EJK5ZBV-X)HCGE^JRYW/331=MM8;N;/aT[JQ8TA:-_+IJTNQ#G89QE.BQ-XJ
3]^L7DCCETeARLf8DeFf7S@M1bLRd_RE\SO)=<BLb58_Z41>W>P&TMC]@<DPDJ93
[_2-,6PO8RR268e2J7#UM#ET;91g7NF67dX8IL2Dg/JLB6N;;FL+RS[.2\GJ\)U0
[3H0K\;D8<XF?[f@PB6/^YWNN+?)XZB5AccbV0WbeQ<cbB>3bC1CL&@<I52:#SP_
)S86AMEJG6RO-.eC9>M)-)O-e9K]&IS@KeK@a2I4:@OQ,YB_RU;PR_;=+8\Z(<d-
@EZK^O&+g6)4dAg6TIcG2W^I(^aER56b3H9ET,>7AgPfN_=-_79G(+X96NEY?6/_
Ca/QfeC+K1=W02&@<E0YA/TaKf,Z\-Q\N:VO5)=494JFF]FgB1#c=,cL-a_Ic.Qf
B=aYP]#C3@I,XY2O<\D^,+^fd0g_+;G<:-H2CF#1a4bU6J\PgW)UXHHAb/gQ.\cc
IZYC\PHB7,.gEf7aM31_dS_-?C(DBJ.dgHP(.,)7J/B=4AO5A?;VTY3=CMWacS/N
3V18EBG5&Af(&ecFUIJ>&Va)WY_UG(^7f1dF5(-1#IaH..PH5G&TVL15_(.>]Tc&
Qc@&Da?R8_^ZF6?5GMO@cEGcZX9IC_JR&\-OX3+=5b91^)1A1XW.UGaI3LZf53GX
\RUUVePWOQV\;H7#.B:IAb^=,-,H>e4aA>#6gA4(W1SG[-]5P)0^JJ#X[aC=BA_@
ONN.fU32YNa^/7M/7SU(_V3Sc/:]ST<U\5:\_@eW+]B-6#eCJX)Y>&S\\c/Kd\_B
0a/U,aHa/.X^@R=/\(S]V4-=#.W4=A+HaX4KMZ(6P-Nb@b2/gMKb-SWc.HVE+7eO
464We:.VbdNK1^KWG:+LC.6),S8dH^cRPfW[OcY6[WM(9AAO?)T,\eH+#HRge(-1
IA&FWD=,@2De23RKETB=\RDa7LXB=0&2MX_>?.IH\&[11:?F5OZ/#TN+VHH5f-^;
/7#ED>W^BUW+]G_Z_D8NeO0+C]Xc5QGcPY3H8b+[EfAIJ._3A9e1P?,V_4?AV2+/
I4P;UW;P4A@NU(_;9(LUIeM2@DV+56R[OBOH=c8E0WfCO>\VV-A@?KTJZTS^JKU=
6/b/+5;+Nb6FIbYI#7VE^d1IPgZT84=^?Y9Q;@A-1YY/Q+&>;=Vf5;e+#&A/bDCV
A+VU#c@DIY_RM52[=T4\gU>g10BJ^dYG?3eY9?):+9?N5G8IUTZB:ZUWRg7\PM,Z
2:(BK]R&-B82cgI[/J:I(LD2>T,+-b0eWO#9_H.ZW&M0,_XE@aN^_Q3#V^F+.^EN
@CS.S/83U19SPMCFF.N;K0P9K^4L,4VbHEL<7bX4fQ_:g+;<1MH921U.E/IH<MI?
NP+@cA=;32(PU>;A;g&9\?F^E#;P3IU,&<I7WH+W(1R]-?X:Q248K#@aQP)eQ2.Q
CBD6<,O(2N>IB[O.ea<R>3>^b=C)CB[\;11X)E\<?g388\V/&5BC9edQGXbVLX)4
4KHV^_20<K\?[QOR(8]^YA78RXBEI/ca=8XSZP,##5O]X6,MHcfb;N+)KQK;D;Zb
AOec;>6Q#(?+:CaAZ.,]cQ_U_SdK_^>#5]geegU5?BX4]\/&UN1GG(e<RUDb&5gd
6ZM6?I;X@=fg:PPW#Q=>DU3P&AC/Q0<TcH)?V^0-ME.Bb4WK]3bN4UcF6>PEP#9f
FO50TXBJKCRJ,5=9[U\1O[KWf2D3:)W?X>M&E&WI#c&-O/UI3+0^,&LIS?3UB=E(
E[))1;-?GAPW8OU4b\;M+),Jd=f;WX4bM6fBD^+Jb[5.#(BXK2WO4=_8Efa\V/&8
CN^XB42+N)DY_.JQE0#;-bZE8_??N@@UTB.M1D;FG:>LbPDYQ-UgBQ<U_&fKRD]d
SdZL#f&b<;V4MOF:WG4.2&bScMO_.:W5Rb/N/Y;WR>P/:.O\>2BK)-^NI>af&KE3
YN+=V6F_\;0e&Ya/ZD/F;H68V(TYJPSdHN&M;SB88Z(R]fGNPD\MWDeTN?cgV_HF
.^GK@,P1^PQCQ[Oa.JN>:SY(E7CH<6T1\]20)]DR;.9TVF:;5+2/+(TQTf>R&dR<
;A76TcJ\QS5?)QD8G<a+\PGEOHbQ[II92>=NW<ZUF8)MF8-K6XA0Gg&e2Eb)L1#F
B&G+/]K#@>ES2D:E^cS53f+K=(d<OEAMKJ:D(a.DY19O,9E5]SKZJC6Q47ZU+)2(
STdGJb@6:GZ;^4UH5HQ5/dHEf2\_d@?#2WRPd[G..22:#U)=f1OF\ZAgVN&T,9-=
#,)DKNYHF/PQY9BDQ=G)\:.BWMVfW)83@^P^M@>_<S/T(7W8CDYT>QOIO0(1&.E8
Q4@fR8#IVSK-;#c^#bXf:H5e/FMHCITI[H,A?Ce\<5[(&#?XcZe,O8L33YR561L/
W?],YG,<>Y1TDK-QE\D3AJ[#HHF9DFZJ8U^N1@NCEEIW2O>K+d5#B@+KTW^8&[R1
MZ5LL1LT05);E((C#1OZ+#P,b1>X&Of>+DVBgUgd7WK+>a;a1d]\EK7R.QBIJ43;
8cY:](OE,&cTTD73#Z_:GU]Y^IG.ELI??@a6X+dL0Wd=+\\CN:fY[.X9BPM&FN8[
6cQ6GP56=Ze1A;@LdVcH@KZ6\S.E]Q6e-g?eY\HAW53E+)FPO:]-;ZBSM<C]G</T
e(>XO_BX^8#:-fY@S.8bEXX/C;cc1/]?b@5/52^OaZ2&3b?IGT+TdHfeb(U]\L3>
g;\\)f5S+D=8^-6[J@)1eXJ7D<OAUZF9O&HfC4TgXaRdURFeD9RJ;@;dKB?UKI)3
89Y],)4=H^RJR3]c/U4RXPVZc_^&@PMM(NUMQ5:RRFL-WeB-YZ=VB0ZKFK95+4HN
O3ZNA<OOUWG5_S;MUB(A-^RRBQf7OSJPIbW?+M;#XFJd55T94OGCg8PK_D0,fQOI
YY?=^XP292E5KUX<f]&K^C@;GO)b+ReW-.6F1.JI7]8C[.VA>.PH/)]MURT>MRE7
&3f.E.F+9.\OWa&1AZZ^^WJ0Y<5aS\S(;\.^/aFR0[-ZO.)ZPdV0Q^XHeGT9-/I>
fUVT,Y5OBKY#S9#/B-d;ZASG5=+51f77c/1M(:Ng-N;abee\-/MNOa[2c:W>X=6d
S)bb?(W#)(K(L>?beHO9XZaD2f87]5MRC.+LD&\XMCF[\(aO\0&/(T0=2dEDJ]V^
eV/F.(FMQeN.:QRf9Z[Qb_OP3^:\O+R68H7BBcK@6BV2FDOD>#_J(SR0^.0,#\gQ
GK2_\?.3A-QC(HbBf]fT10>?&D2>R0T5gP?aX=d1PeM+J_+D^&B^\ZE)]NB4M8B7
;Ie;1V\M1D#b:9VMb(V+A4e<QWJR)(1#OEKOE,H89^&7)<?TB[Q5MRF^U3c+-8PL
eFf_<<E(]g:SGd_.(G(FEPFCJ)0L8f2d=-5_<-NZe.BU?4bII^+[[A05&)I13#4[
@13&+;WPfQ1aG(GXOENWR(CW?JX__bg0LQa4ePXd]89A.JL+R>C;[40JPU2gC5dU
>7W@+,e:0gTJ/2d2d&-D-N.K+N/KOZYa\L[K\#T<B^b/=bV[;GaWX9A]<,dO.^\/
a,=SA[NEH1Y/=7^5HC&IT)O?;9N)SFLRF.8Pb4G1_e/>1gb_0A;XA/OdX7LX\;W@
DKbfb0:>R=08=1=b@IOVG^:HNVaVebD+c4a6DbCE<P4)HaEC0W:P1RK1755O3FL\
GfaL)dc-DO=e/)CB10OOfHZ5bDefL/ZG@IB5SIOFV/fgF\A(4SZ<Z]GUDRe)(HJK
,^/+d0DcIQ9]REM#F]P]_,;U]0N.7d1eBX<e=TBOGL7^[@))RH)V0XX&BASYb^_W
)T-^99T9gN3-QM/H/IWP;(/9FEE)GA34#_EI6T=4#.g.Rd?1:R0L7?QR>OZ6PE(O
c2L]_gY+>:b.G,F;RST&>@\]TRK:g4+)RCR=CEEZ@5OQOD#?04HQFRGa/C5ZfXA:
;3_XcL&,JYHH?6B-A2);0.BN/BZ=\fK-7(=LH8,+E]]eGKMI_,D8NU&^eT0,ZI_C
X0PeYY6dE)1]PC(]O;,93Jb6g4/gd4O.Eb\)>&d+\[cKeZ<<bABbd5@#)a5PT#G2
>aC#@1?TV2,beMV>\3^/bM5/+^ENC7UK\3&Xb7C\W;E75QN10ZJZfLcYNA9eTT]/
9US>8_9\RR#B-WMEVY><6&(;(VI=<d+2#5@[)0O:c@AB4KD_D8=D;Xf59;(U^9d6
E(fM9(2Y9CZ?3#5)+)QS^Q+?+;Y#^FZ:88B5f(G1O526FQb1fKM#OK+:?<9Aa2B@
F,(S@Q^ZX)b)[6@B8<1,57-)Z0QRDOJ]N40IVX\GX4=6V2]15S49gDAF,MDR5(Ig
g06dFX.P4FC0(+a)3agLHHKQ&Z2QK4O8,5ea/eW.)Z+8TL?^PQ0@:bV.b<CKIO.)
8O/[E0Q:&C.IX@[Ed9#Md8/-+HcV-;KcRZ.)31H?BUZDTUc>_=7#ZK_;->gNb#U(
J4gE&F=)R_Z=WS52QQ@U:VM4?0Q7/]Jc>OUCDVe^UH.a>d4LI6Q^<cWA#<_@d@>V
0[2X3)7GY.DICYC<686:I7X5,79SL>P#L1H9N(CAQG.[=A.b(_Z-&(+LEVK7U-FP
+AC4aI#+Q6A(7.XR;HVWE7#GXPB>AZVe<Wb@Nf[9IgYfV#(#D,&]Se(:]YVd[>a\
DZFeg49MXK2^aU8TD3M:^A#G:0XJF]1T:(Qa4M2=>T^HVTcHZPbFW&D^U9gb,@IX
2gEgG<FI7;0K6&OWg5;VEg[XX(O\L3N5NQ>R=@/L@e2a06&&D<.;;5(/HI0&2T/&
[_KSC&F2:gM(JQ)EF:UBT<):@8gg@O,3>M\NX&P38f@5)I[^e=M92JgVVYg@EF9S
[T^]?BD_W:X7?][,QSQUW0DA^e[SVMJ.,KM9SQW.[^X+LJO[RGK2L4I^<3QP=EaF
GbM)MHMLJUM),gI2K-aPSeK/;[/GaT:,]6cY#L+IQbR/>g^[GSEN7@KNE/.L[R30
J]F[OS@8AU#T9ZWVU,b=,A1SQ.(4JH:NTVT93dSI5U>REfYQ7U8aS42+acS#?90<
UeN&O)eF/3^]L___8HLaXIKeENFBY?0g212a#,1(HRLA2d<2CY/^H/<8N6JTMKVM
P-b2B)fTV\[^RbO62_;a.J/5E>+B.BV-T7eW(:\K]T..1[fX3g^W^e&VG<3=YaN0
4Z)/Z+BVL&Xa:XPDWK2.A-fETH[FFM7FD=]dJ5VC6:Y=^N8?4K)5B_7.W:R7IO(5
)Q3C+,V,UH>BPMbQUI])(S2W)IHN^B)[#_-/RN:G64</?CH\8B#F#;C73:DHe\\F
;J@WL;c,8De0cBDC[_R4e.&2>5(YKaD7N-(JT4L3dHUNBJ]K5LE9R/]9P2Q<7>Ef
:3If<L-:O;4#c<O9eZBa/J\X+2COaOddQNU@@?2T0ULKC[/X_:3#1Z\Z)ZTNVI?T
(\90-4]\K.V(;73Q6EKO?FMA>]f>KX;Vc4?c#,B>Td+?/1WaF\>[2XbcJ?/=;:OL
DV?-A>\ccNV^4;HKV0+2U)SdY.WKTeK\7g]<[eI/(:3ESJ&5@YD.X)b?&]H]_>eC
:)7bU>-5PA1KPSGcC;(4aU@=[K-&?+\Gb[#KFB]S;8JIP^&/LE;RTS\,7V,0cH<g
N_SV)OU3cX/46T3;\-PM?#FP3O-#J--\#.Ld+D+Y>?^4PQ\&@PVfY\a49M6LaX&X
W[_?KAD@B^+f#g8]83(WQ&+VLR&E3-79f5ZU7TQ,g;7&F52d15_U?;YHXA[GBRY\
A)CF,Ea9E2<SV2dW+\LcPaW?5P6;N(I97[0FL_A>DCK^5Q0/P;IOe2SMMT;<\25J
d=+>QP6fXaeVWQ?e.J5K=fKT[OBOaHXg0VN]Y68TeL>^<>0ZIYGRPR8R/VaKH;^E
=C1eOW-7H[XSHTF,ZZ\BMf\?>?Mg6,I5#ceKb,U=>Y&X__^;fFZO=fS=bXDI]G(8
-NR4#.;W8X&^SR@IecY>LGdA:Y)NNb^7JG]HfV9<N,I9J+EB2Z@>+#.BJ;#YEF&a
T<<2(6XV969W@H5]4=\>U>43.4^F/Q0?]Q3/07UG]AEQNC=G3DXRWOXQeIe/M9EB
?[,^4Xa[e-\f2/MfR[bBd/#2CJNGeOA1.MVFWHR]#T51C4>=,8BFTHJa:)FEQ#<+
T/4^VL8J&ACM1TE_VN=YPcEF-PWg_9f\9dN_R^OC=[I<L(Xb3Ec-N>,Z?BH;QH)1
\]XEB</.NMFS2&O8b+0ODga306Wa);/8EX7#L\=3ZfJg\:#0Q9&0cO-OKI9>@c3>
_#0ZBR+T@IV\QAeN[0OY6>GAFC^f-_^<KQ3,Vf19aNOG9G#>917UN=6356KVQQ\J
DI=DC3=>e?D@]HfC.Dg&44B0>I5\3<&Y&0@V.SZ0^FdD+W(JMAdW<cL=g#;PZE#X
BALM,D0+?b+9WD:?8)e6;WQ\bIB-?:N&N23]0=4/J[V-T5gbY?eA&+,_KXDPGNIb
T2N11;)A_(,bNQ)6?/cTV+_QI6:L?[JbVc)bF\43f11PT2/,\:.Q.N2eE^F_H&QB
Wb[+]=bTF.#e\2eXP\R)851cM0G[N^06W:a./F;+X9B;c495TS+75\P0;9N)[eV-
PVG@;J?EY=A7;WK_81\UFOK4WI5DSG?4Y(/NJ](\RIab@YE2L5L0DP<R[3Z<W1A1
F^.R_^-9X.>-L5^:O-G3K33&8]Y(IP\0MfG3#aG?9<M75D@Z(b(W;2\I@M_PA3=?
3,)T:VRKIgO8&AN(ZEV12>NgM@g.[,V1#I#9,M,>0:@BIc]SC6RQVVKQ#^NJ^KgN
H(f]TDE/CIEQQc_).XTE?Y;,P<He:d)B00<d+[;2=O>NYS]5BKE#@X&F+,Ze>.aD
A(d=_P._J.;F3TOG]/UFTa1Q/c6LB66-V9VNe(B.^8gW\<B>&OWSG)/M;KADDTRT
c>:6VBS5?a-,04=Y^>R@gG73J.S<N@0[.X-K5P\@0=(B=N_+DS=,@&6,FL18-,JK
\S4EKIaJ.6&Y0?9/De0=./S\5HZ]Q@WX/8Z&a^4I2a9D\M;80GUAL)YD,9JW-Af4
6bQ4T47\?S_Q\.\^Pg2+8PTDMSH8A<ME_81G#O>XReQ]+DR7;a0.B2>5Z@@/4M#7
J(,FS=_cT;6J1f(3_^66_(8,,QWSP(fH)e\W/Ec_R6MTS2?HZ0[D#[C:X8K@[_5;
dU[HY\+N9]49QUEB0N7Y0\=XNgU@?<b_+-g/N4[U&f2UXG?MUf]EJ/LX-X)CND^B
VB\TV)_^2@>U2FGcYU5G@ERGf=6GSd+E^K5:4C]FHf<7X>^:5O00ee_e/Wd]0F@8
7]dbCS]g,XfYC;4WS4^a+g[(5T2H2)F2cT5)I#gb(.RfEd]fI3LDd\I+3N[RVBFQ
e>XH6/IAMRW]VB_NfWGVN:dSY#69]F^U\ANUVRMb&Ed&,f6W(53?PI6ED18\)FW6
cD-DU&381DIe=TdZ)3D?^,#(T\@G[U6P<SADW9]e[=a<]1:L[MSRL,,^SFO33UF8
V03O>\W>KW>[&]I<X>Id6c1gcICSU99+C;3RRe8)N2LCfO;3acbF#KF#I>60c,S0
YYaUA_PU<UOAOF(b&)V<6HUSR\Ja5=,EIcW.MZU]P[VKJY=g=O#D7Rff4<ZS/J7Z
I[<1;^O7J]Q_KVaEPFHZ)3[Z3I.?f__=13e#.Tg_^JW>BgQGWKKc=M72^(DDY#7&
OKdV4,M)E31?TBS.QQf)=KJS#NA1A^eBIKALRc[D7]I(,[ee0[/<&g0,8Y#)OGcg
JPWB327Q[W-f\=UNL#_-9#R\U0DK^IN(L8A)TRbW5_<,WK_4;J#A9_C.[:OVC_fH
>7U1&47]JS,=GQA:,V8[&)WPc&AT+2522-GM#?H+Y&OYITGCY^YL8KK]<]QI=7Hb
g/1M<NBA,U8EGB[#1;W+5e^5V=2&LW?A3B)VL(&&H>7e^,UGNgcG+:KON^XW.d<O
>7^FP1@J#(d;gD;Y>g<N6,gWN]CRXYT\WXIJMgE8UXXRO?(f#(4ZV?/Cb0+cW5WA
74P\Z-2)?A;JT3M.)_K:/Z;OYb::aY672.e,T3KTfGT@a2E0D+A=7gYRQgES4F9Z
C5P6>M\M8Q:HNUSQb=+6UX?:_cSbY^QTF2+9-MJf[P8K1XFTJX]d,eb7?T?#AB^5
C6^HDV+VE-@I)eO1))SF7NV+R5Gf1R_IQLHBUN0e#,SB-81G6AX:dNdYQ5e)3(V6
ECYbT86Oa7b^.\YM.2Gf5Y12ZfYAbV_gOF@cIedCVg>,(/cd?(,;F/3)01/]2<I&
.3)ecT5+7=1U/7^5IEIB@^\@KZ93I6-0Z34YQ=&1IA88)08NP7LRI?;I63Q,:G&B
JJa-J/bd][D_JOgMKV+7U>BE0Xd+YF3NE=)IAF+^NXW8&M?QNa25H1+>L@7(CXO8
E]c5cF_f2J8LgX0HC9+=ECU:#9^BK(=eMV:9bD72;C2a+JZI<:=Za;#@I&TP##^W
^RL@g](f&1>(UYR?F(452LWHZA[U[L-Ob]cLK:T.89S=;\O^\&>@Z.S=Y,@K=?Wf
cAL>f.-QT97+ZJEaD#6KOREK1+&Mc=LMHae3=A0A/NAa__,]J_ZgZde0KGS@TU;0
df(3V][CB/5/aANS\b:=E_#0c-e0[_V_e\M1a@\5_<RU=[=YcB)IL#M773)W]KBK
0@GIbB_&ZXFg4PV<#_)_^)4K<ZYQZ20BW(+,X-&5bZH)a\-TM(69,(U:=OH9B/6\
&WKb\gVK?X;O?Bb/d6L3W\egHOQX/\eER1;-b=:.+&AEU03N2E<4X\(5/Obe?B+>
&+>1#(HW]IJ_+^I.P8?4:gc42;]A(58d<QDK30L3@gY?-Oa5V<f;eGSWA\MKJ^eN
/K9T7(0JD)eK#=ZJYS.PdT6a)f9Og?WSdUF:-#Lg9V5C5+<Z]VSaS5CHc>KU:VfP
7>KB4C\52_=FZ_g_PON\15QCP6\^-aJ\9J#TD\g>D66\?4#5WJ+#U-+fYYG?eN(=
UDV<3K)4698;HJ4=0f[R_g]^1]IIVQ)>g>WU?QO2Z9C8;:g&fW3I_Zc?I0?#E6SX
@=+g;VE)Z&#D_IGO,9cTU[Ye\POQcX;=SR=82:P4:F6&N]Y]W:FXXU-fbOef>N_&
8TS3QU-e_2ge1F>FSVK_#FF,51?aI[b=SU;fJQ^]e+<?BND(d<=&DbUd8bF8IdB_
V,(dI:+A@I.+#(-,CfM]F)ALA/F<3RdLG[X:VI&,]X>.#YSbT0TT@:853@U>49?5
+d4Sc4[-YTF/33W7g54YF-1OF87)>-MN-\f&1M]Y(0P_^M:-FH)RI3V)U1JSSEc-
>4:&a>PXP7W3d;e_aHM<SCFcYD45,d.@=Wcd374LFc8N7]M0N6#:gLO.Ya+.D>,1
LHUXMA_Me+9SZ=gcPP.74+f7R4fM4X&[:S?Z&3R7QBaC+@PH][IH&,?eVVgL83-b
gL>B\GDLD#NQ:+Y&g-GR.C3KeYJVecMDBCN2G=ReJ[IE]b2;OW^:+([+BK+XZP?I
N0//4&Eb?2(FcbYXZMO;.XA&K_eK#,[=Vg4-_;>U=7\KT#0,=.B>AT4SJ5J>(BJ+
PG.JWFU)2#>(L5\AHf(cefZ5(;?bB@Q011gJD;9?J(_ZQ^#]I/:3>X\,<RD==]:B
F_X/g/GO^T,]@&(a\)=@JM-YG[Y82L.,8)\>-Le:]TKAHEdc1G+HW]#\P-,IGDCC
S1#5BLI6b&4Fc>XNdEBXDK<L6B:+cH0LS4<K5W7IddgKOKT6a-1?\[ZbaV+FNe6g
)g/9C)>T)KaZ<U=7eg#+&TDES:=?<N5M4>_ZUWBbG+K3,e7Zf,d[R+K-E@NW8&3?
#B.7^#3L#+F#MDb@F0U[9MV:VY.+EAbHQ4KD[KA9_5<b&[=>2GgXB_K-P$
`endprotected


`endif
