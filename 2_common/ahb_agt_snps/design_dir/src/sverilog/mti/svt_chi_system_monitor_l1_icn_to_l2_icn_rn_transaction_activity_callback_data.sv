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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nGe3nBfyUOwBkm7SCWd0zk0ZW2R+HfHLfznmjgV+1WZ2ScnQfsKmOX9Gm2IHh2as
NK9GHlp7ReLxlwRJLacnMdDjTmEDYIs+BIzIgebtZD0u7DT0S5bhex7BoXpI0flV
215K6DksmGlY5ATF3OvKNxJIn7OCyxpVt3MFMQ4pxXQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 595       )
Va7xMyiQhsfRTavUiFAwnrrfQLz3Ll3uRIHpbVAgwJ7P8t1M/573cA2QF43JEX29
iAQikfnlqWinSYJu/qQRg/XIk61GADANZBiQrY/1JXNadEt/7VPaWqNouZkgGilp
wDHyCHD0xsKMmH0+syDmybyXOmAGFkR/iiN02VIy5Tnf5A1Ku7U+HE6vl/hKly3D
3FZ59U7yhWwLNXKpyvyVnG+IVlrMcO/feKn0xzFbuD+j6DZALjrP6vD36wdiHlbb
OGYWnrk8GOOlJrd0S/MRYl+1CBZXhK2s5+SQqtT5z1tFG8z9a3+bWy29p1Mw87EV
yc4oxAilnFFIU8EygJsxr8aHXSWXjttyfMlLiH24lpVKcrTO6f4XKBz4ZbJY/QKI
bDiEiYW8dNghg9CFThtcwfq7DNbYY2h14Mxf1Sft+Rng8OgeKL/9+wInM3OboLTq
3IzPfT+sIwmTUL9y044FmpclGbrv6BKLjQRn7ImYXwHjpLpbFVk56q5LGcvJdjGL
SpfoojKpWay8a5fzuhbmks6/lyd4OxmF8WYo4xTzcRJHC3FsnoQxzNDJ13QATpWn
vCjMshaoTNNbFNub4WcEYmYqRox6P/kJTH29ykDwxKD4ED0DpJSII4ODEMPU+p87
tUdBsAmplDZIdA/kQ4T+SnaBZcQMKI0g5kSsIGnriTIcVEsvBKSgBCqvihjUjmmH
kuXs/RzBqCtbmTJLc24piZWub7rhXoKzJwmdAvqYKbP5HsxBMdoNPxrhFfeCJcvX
rWMZqlVgBjGdfGqbjfppxuNCC+t9y9pZ2lVlSjcvI7E=
`pragma protect end_protected
`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L1_ICN_TO_L2_ICN_RN_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
L70m4jw0HUaM0KPMNVBXOpxNvULJdm/K+bFrm9ON2tXbuXXhDfkCgxaOTZQ73szN
BM68izDbHFwiW5dIXgZt3TGWrh7lCPRS70lpwoO1CsiZFVW7Be/jrXn801HNVrP5
wvasYAEcYcrLzz/jlzjKcO4A6ss6u3/BwQxKOi1MidM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 678       )
geON4GWM/bxCRODArYdicYNgURU811qCkwgYFPaBdo5nL7atAMAV5X4rUK6wzDAQ
dUHnkktPeei4YilDQPT4GANH1yQ973FreJrj822g0iBsYF2cqv2vQ2F3hjMrBwnD
`pragma protect end_protected
