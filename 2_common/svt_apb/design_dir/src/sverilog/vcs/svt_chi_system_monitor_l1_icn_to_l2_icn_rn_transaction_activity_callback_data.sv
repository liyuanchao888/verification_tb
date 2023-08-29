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
`protected
A)f39e-\^R_U(6KWQ>?g\B?7NU.[Nd)?]eB16MQH:<;+X2:RG6KF.)8[]=M2^<(I
T#Bg@Z+P9)#]Qf96^c-UXVFa[TEQ:MA&@>@(V<#:,=7@XIOg:gb8=4QRc8.1BV(g
4\/Q_;fdVN6;cbWTHU]:P>E&S1Ma<:_J1@>4U]6ET]DO4a[g:<8,K<49d/0UK^a^
I=6e[Z78O4&):(-]d\1[T^JbND-/1Z>5;&Y+03PZT+.YG:b4A2M6)TZcbR\ND#;P
=f-cWF1IHf1c:3d,G;LHSNFPeILC+N:=TX;S/G?bW=1)U^IG@37Q<H]ceR:-XX:c
SL3aNSe>I?c@S:AZP<M_2I(I@VRHTRa.P/?(WL-52D]8E=?]egb]2IaKQ10_?<3O
V<OWD8(::5fd(;Q:-X#^dJ)^5OU]#K^7<61ZC[QNZ^K8CMb:aU3=-#_0Z2dKNL4X
A/(L_(M]_W_JFaf:.E@fLc6^K.aKAUWL^bUUUU3afN=&g+<b.S_8ZeaQ6O+D]?@]
cJ\R@6YJ^/RA5VQNPUA@R.=];G)T)GR?D?&d2F6Q9#Q)8>FO_@5SA:^D0HPM^UR^
>X,Y,M+?ReDgWSV)D\Q,65LaV@2TD.>D]1,96V]c?.A5]QL+)L?-&#H1ER/c#.10
CSV_)I-\R94g)$
`endprotected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L1_ICN_TO_L2_ICN_RN_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
