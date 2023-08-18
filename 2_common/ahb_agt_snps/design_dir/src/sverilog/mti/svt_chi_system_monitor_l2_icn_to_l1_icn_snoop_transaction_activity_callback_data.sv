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

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_L2_ICN_TO_L1_ICN_SNOOP_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_L2_ICN_TO_L1_ICN_SNOOP_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

/**
  * The data object of this class will be used as argument for callbacks of CHI system monitor related to:
  * - L1-ICN downstream Snoop transaction started.
  * - L1-ICN downstream Snoop transaction ended.
  * - L1-ICN upstream Snoop transaction started.
  * - L1-ICN upstream Snoop transaction ended.
  * .
  * All the required arguments are the members of this class.
  * Any additional arguments if required can be added to this class.
  */
class svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data extends svt_chi_system_monitor_callback_data;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data", "class" );
  `endif
 
  /** Bit to indicate if the snoops trasnactions is seen in the downstream RN interface, b/w L1-ICN and L2-ICN. 
    * A value of 1 indicates that the snoop is seen b/w L1-ICN and L2-ICN.
    * <b>Default value:</b> 0
    * <b>type:</b> Static
    */
  bit is_downstream_snoop_xact = 0;

  /** Handle to current Snoop transaction. */
  svt_chi_snoop_transaction snoop_xact;

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
  extern function new(string name = "svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

    
  `svt_data_member_begin(svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data)
    `svt_field_int(is_downstream_snoop_xact,`SVT_ALL_ON|`SVT_BIN)
    `svt_field_object(snoop_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(sys_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(rn_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(upstream_snoop_xact_resultant_of_downstream_snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(downstream_rn_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(downstream_snoop_xact_queue,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_data_member_end(svt_chi_system_monitor_l2_icn_to_l1_icn_snoop_transaction_activity_callback_data)

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VsGBoEWOglEZHRjuFCCESnekywqlfIdI2GTwGA/btaGSpVrC5IfpI8Nb5bhnVCqk
4yTlKTD+0gRplcWq80VE3oqIy34KFbgdSDP2oxBjQXMEeRZGKM+GTkyOWppjScea
t4Fa6WIukXTo0iBxYYxxQeUg0/q++gnVReeKMYPN2RQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 604       )
g/GJCMNSHhc137u6uYrJk5htlmfGsHTflaLYJRcAapzOFuuQjfZGoPQTrWyIRKYV
ePoCxfUDwptEH5GFKedooM0r69fpU7N5HA6xlGkpsASIM//eKkiGnABPYCqkfUKo
ZMXBKU6mWKBaFwatyHD3rlPbl/zFkz3zbPbgRHvGhDRF/HrQlvz7XK03xDornKyI
v52dcnSbpoXLlzEDIvYnh2QSBIxuuX6f2pohpiE9zT+A1r6f1HopuIHTG9O+BpUd
+/Y7pH7zmTQZjZeX+KVPLC1CntIU6+/RiJ5rwJKUrgFKuDdmU5dXmraiE6kuswSp
mceFCgwjM2alygYZikiaz3KPDzn4/OXfXo4Izgwkw1fj0QgXlQLMqIlkr4YyW3TH
IlV3FWw5T2J+Ti1yUwFAP3VaYjCIz1Gst2eVOoXVUAUDo/ynLun3gzlqsOQIv1pq
YUDpF4700HJYU8dpkYllRM+KDdqXn1NkGmr1KTIDYM3eQpFqbEDd1Ur5K81fzFSs
x7bVE/wONqeMpCsMq1L1fXw4As/A/BU7ecbg+767vwC8QpnvA1A8OX0buG9ggNO1
axSP8h1XhkamYClP5wVqBnlfJloF5O2ggrN4P6MWk/BcqNPB4N4NkqNXqfdmpR1M
W/QrC/auFzr1636TGLHaEgR6XjAMlRTDoQQ3iyxiY+Tt2c048zue2C7PZDdO/OKe
JTwS1/BAniaGnWzkAC6pbms8nOJiPxe3e4ozY3cVR3MBWk2P1A+y3HhhUBXzsHIZ
N/OLH5wml8YmLZyr8capobG512MmECAASpHK/n8S7+I=
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L2_ICN_TO_L1_ICN_SNOOP_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jziGrUn3ZxpU+A4KnaJBlDZsH19gadIU6UJms5bEPd4ZHF760ehKJT4SG9ZI5hNx
u0ZtzE3fvpkreFcaQzA/UpviOuzCO9/S2OCrLeo7EwQRil3qrRnzbQkdUCsNyKkF
+6qLfHSMuZnCatICl4P6TQ9Xb7qnL0VZwlt+A38M8k8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 687       )
YSacdEADkXvmLieX1O3FGcfRDwgvbllP0o2X6k6bHtHCzl1IEKrTPCov+mlM0gwf
QJwJwRXl2AjSBftA91fpX4ktvs3QOYKeGea4p5VHNS5dtmkG2FlZ+XZJgMB/65Z9
`pragma protect end_protected
