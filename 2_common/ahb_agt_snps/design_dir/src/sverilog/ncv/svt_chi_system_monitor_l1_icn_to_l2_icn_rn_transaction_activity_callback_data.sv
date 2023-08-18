//=======================================================================
// COPYRIGHT (C) 2010-2018 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_L1_ICN_TO_L2_ICN_RN_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_L1_ICN_TO_L2_ICN_RN_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

/**
  * The data object of this class will be used as argument for callbacks of CHI system monitor related to:
  * - L1-ICN downstream RN transaction started.
  * - L1-ICN downstream RN transaction ended.
  * - L1-ICN upstream RN transaction started.
  * - L1-ICN upstream RN transaction ended.
  * .
  * All the required arguments are the members of this class.
  * Any additional arguments if required can be added to this class.
  */
class svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data extends svt_chi_system_monitor_callback_data;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data", "class" );
  `endif
 
  /** Bit to indicate if the RN trasnactions is seen in the downstream RN interface, b/w L1-ICN and L2-ICN. 
    * A value of 1 indicates that the RN transaction is seen b/w L1-ICN and L2-ICN.
    * <b>Default value:</b> 0
    * <b>type:</b> Static
    */
  bit is_downstream_rn_xact = 0;
  
  /** Handle to current RN transaction. */
  svt_chi_transaction rn_xact;

  /** Queue containing the handles of all the active system transactions.
    * In case of non-DVM transactions, only the system transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the outstanding DVM type system transactions are stored in this queue. 
    */
  svt_chi_system_transaction sys_xact_queue[$];
  
  /** Queue containing the handles of all the active RN transactions seen in the L1-ICN upstream interface to the same cache line. 
    * In case of non-DVM transactions, only the RN transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the outstanding DVM type RN transactions are stored in this queue. 
    */
  svt_chi_transaction rn_xact_queue[$];
  
  /** Queue containing the handles of snoop transactions seen in the L1-ICN upstream interface as a resultant of Coherent transactions from upstream L1-ICN. 
    * In case of non-DVM transactions, only the snoop transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the outstanding DVM type Snoop transactions are stored in this queue. 
    */
  svt_chi_snoop_transaction snoop_xact_queue[$];
  
  /** Queue containing the handles of snoop transactions seen in the L1-ICN upstream interface as a resultant of downstream snoop transaction.
    * In case of non-DVM transactions, only the snoop transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the outstanding DVM type Snoop transactions are stored in this queue. 
    */
  svt_chi_snoop_transaction upstream_snoop_xact_resultant_of_downstream_snoop_xact_queue[$];
  
  /** Queue containing the handles of all the active RN transactions seen in the L1-ICN downstream interface. 
    * In case of non-DVM transactions, only the downstream RN transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the DVM type downstream RN transactions are stored in this queue. 
    */
  svt_chi_transaction downstream_rn_xact_queue[$];
  
  /** Queue containing the handles of all the snoop transactions observed between L2-ICN and L1-ICN interface. 
    * In case of non-DVM transactions, only the downstream snoop transactions targeting the same cache line are stored in this queue. 
    * In case of DVM transactions, only the downstream DVM type Snoop transactions are stored in this queue. 
    */
  svt_chi_snoop_transaction downstream_snoop_xact_queue[$];
  
//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

    
  `svt_data_member_begin(svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data)
    `svt_field_int(is_downstream_rn_xact,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_object(rn_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(sys_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(rn_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(upstream_snoop_xact_resultant_of_downstream_snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(downstream_rn_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(downstream_snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_data_member_end(svt_chi_system_monitor_l1_icn_to_l2_icn_rn_transaction_activity_callback_data)

endclass
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
79tWtghWZYSAfwl+8ElSf7rK1qJocwetIsVm9yICOFo86I1fSNSIVd/QzmpB85J5
TIe4PoWdJYXCLy9kkoObRWhh1ZHInU3oJZJaqSnOnQ/DBlMRiCjgBSHQlzVNV3FL
i5m8jO9OGqLNNHLiu1twafwyuuN7PTj+Y0BDmS9UjckAyzDUCu3chg==
//pragma protect end_key_block
//pragma protect digest_block
gesp7Ta49TPL0hPAW544wzPRBp0=
//pragma protect end_digest_block
//pragma protect data_block
ijGMcy7cc/vgb+JFa7E+uhhZ/uBm983NLFRxcnOEC9YL/DUYCKmnY1c3a6jcRSTE
K9fk9h4/TgMX4758UwS2j7E96Je8RE8SvNGkTrpiihZunI98DQWW2WI4vxhzfIDV
L1VGaNnF8wOITRE94m5mTfBaKeVAh+MKqu/iH9yH7v2VVAwqNK8+uP01C4yVpJnP
eK2fWR8n4sMjiMqUBq92UBLrYlm8SJ4BA8H/8IMDAg6QzgfNZQbPCTZaF3uki68T
Tz9pCVZ5OLCX0VZITg48GsjNdVkOxBihal30Dz49nPo7MV9YqxLXHPtRgCMLWSpe
Hgejmbp7xuYNBvXOJ5FZjNIdM6hdgceAw/ayJfbtUxGSJwMw3Po37xxyj00sKbAE
GDihwLJSOkSi+Kol1SYgQWnGfSkAGtXEqUz0wRKBdrSWT2vc1KNE+KVgu2oBoIHx
5vVjg0sV6TzoCb1F1P7nI+1d0LAhZus3ytd1LY5WljTyCIavlYAuCj3nL7+xXAvz
9VwU+GWnv8dYm0sDxrrVIKDtfyjopxhiqkXaH2JKsGQ83AKb0t64cDGiWVOFamko
UkJdR6Ye2l+OfdnVbtNpHlaTmGdAQ28QTTMfXeLd10JOAlcmA8F6+Vu7iN0PeOIS
WdmsyGXB9AGu29a+1y+y6enYGNjgetgCf3RhHUXTX5t50Rxd0NYEY+ahZiQ9Lfsm
hFAR27pj3gd/gBJB7hCJ1DNK2X1xdsYO6BOqe4hxLP9KmQ/+zqdWVpkG0DSPSOvJ
LYNwhlwh8gWNAB+Hc9os5Y2t/yHaq36+NszCLyVVt2QBKIO/mZ662cm//ZojHiTZ
3pWFpzpKsDfgs/EMuAZVIRnwosPvOzV4xdnGtZPaJIv10DbbQqLpWcZZjW/ZFjyD
NDDPgvYB0zSCqw00/kSYZmmi2lH5Bx0ljJXhLYRr0ZegPpEmW/vPMFIUQeXISuH7
CG6jyUXNSmBMFW1rVqyrIclRBwmxPZC8kyI96pFf6y4bK9KCT16vhLa6sIOLuItk

//pragma protect end_data_block
//pragma protect digest_block
nh/026a428UC7ZjkUR7XWtEjhHM=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L1_ICN_TO_L2_ICN_RN_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
