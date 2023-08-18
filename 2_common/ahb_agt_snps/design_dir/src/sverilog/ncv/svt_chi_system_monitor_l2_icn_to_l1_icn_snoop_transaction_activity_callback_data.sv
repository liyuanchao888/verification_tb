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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
D7Wk1b51j6r+d7d6Ikg4DI1pKZamttAecTHQAKBn96HEr/UBdfflDrQoAm6KuHXI
PNjrqGGXHKEEKd9Cmr3qRF7WLTMSqX8H8Jo0pBtbG8v/BjGTrmmgp1/BPJq4oD8d
8+pclvlulfyU4Sbcmln+ShC+ZOylCoY+vBqc5bXK8UV8RFrNErEu9g==
//pragma protect end_key_block
//pragma protect digest_block
6u9/6rvFLiTqM3oi2b09P1pydek=
//pragma protect end_digest_block
//pragma protect data_block
UvDzYEMsQorjd/CtUiiSJuRmPUHgFwGlBFM/gNFhNzlsoHQ+iRtqDXWCB5qMlX17
huyTgeQRh8adWtSTNwZJRHuHRlLH20hs07kXf7PSpHrgBJNIjlCXFVXeMz1V2T5q
QEsLP+NkbZxxXSFlnwdh0I0MCzQ5WTf1KVD2X4Y6I83OJYhFURfpTgbpEo8b4Io6
3zFvsyFU39/CzpwL3XrLYNlM7g75ZkfWfX3MEMH7Ewk46hnxGgccNLTKnToivuWZ
2dv9TpL6ExIGn5GfwlTwzP+K10cgqqZ1KAQYodCcdS2UM1fk8t29WUNp8uC4KtY1
dQ1IbnnhcD20SYulfXRKpxn+pdoHxw9xsdDDNNIQIo7f1lT4BUpSPQyEtiaI93Gz
v5aDWqQpc52BndScpf8pDb7UV1s7SS9tgex/seyP8f0OlMxGaQhK5sWNBSufP5sB
wudeBwwI7d0Mricr2TPAnXIfD3LPb3CLi+YHd8fU9CYb0Li9so9Cps+zuCR+BCQw
knysO7LqmmvloSEs5Uqm97cp3ldfsFytwGWmhTuAkEgUJVCizIyyLX5pFlatVMLf
E0O538aT4Drsa+7jwsPTZICWofR7cR8upCKjLZdEA4S7Lb9SPFBATCxQDJ7xrP1Q
I9IPjYgOXzz5WHQOASmR3OueTdgvp3Py+WnikQcyy/WHW66Bke0qGyYV7JwR0kGk
FNgkiqpdlDZuxBKlkJzd78BLax6EsIGs4VSmNb9KgQu4ftx6cEBq0QtQ+TzZEzad
mMx4B/mnrNqzauamMUtuIcaKy+edfHY3mZQqyI9ADkDaVUdeySXtFujPnZgi+etq
6m/bZAEQiUlsdFm7FB9bk8soTFsG/Dp0n+e8LfPfz8OTEWt+d419AarZZcqDSUth
NGQiJbbLKo952bQ1oWgd+r5jJckF+JsFvlrP4k/L+PFMLIOWUMHo5uu6q7+4wOxP
RLd3KeZJcIAd+kNgW2ud25KO+ftRGlO64lwiDqpFURLtlWU3NgzDoXGpp4qllmKQ
caBRvN78oRXl7PmbWdQ5Lg==
//pragma protect end_data_block
//pragma protect digest_block
lw6/8XKslhnvv4p4Btn9eDYa4yY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L2_ICN_TO_L1_ICN_SNOOP_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
