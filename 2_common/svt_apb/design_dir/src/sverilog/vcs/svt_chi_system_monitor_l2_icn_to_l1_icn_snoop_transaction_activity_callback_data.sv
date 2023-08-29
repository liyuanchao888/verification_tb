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

`protected
T\,dbGfLJ4BB12YbbA,(;J:2/?48;g,#/YQ^?O3X&b[NAB0>VWHH.)_V,S9Z)RZ,
4U1(87\+\2b^HH-LUHP18GDLU:DC&SgbSD=Qec2B.Sfg=[1ee(02=^fXG@W;Zf22
I2R?LfSHF,MRP_2;=O74MS8@?dRI.K62REfCa59@+TNd]a+_0Md4<?IZa.#?Y7V.
_QJb[RY64W&<])g,(@?HDJY58e+c@bZ,gAZY;E5]]R1.D&>aT2X#\Q3f7ZO,0/f_
;E-0aT:9\BbN2W6I&+]3g,-)2L6<fF6Y?@bJf?.&DVefKcI-bLU2N.#?TS?R[I@.
7AA6U1_=fPUa6@,<G[+F>JJAgTbSLLI@SETZ[F4Qg1KG.T<BcWM&VHD^UcQ1\6.(
+9aOINPWYdF<8>Afb@PVGFOb\7I@@gDL&(H#DP>E+O)<Y13)GdX3J#^_D\2+N^Z]
dS(0\2I;cg3b]cMcDU2P2#a)abQT1C;&Q&G^,IH4C&([_U2CR2_(N2(b.S(_1]<^
7:H_a-ITZ=HAB=X1bVJ@L_fdS>ODFDfC??b?D&NAf+ZAST_ZBL_7f0:\bMO\)[-C
PA8)ST8&cX^+U^+-fV\<?/?+)a+-TDgSfAgW2_8V#X2)/8c1c^+9IXF1fYg[DMg&
7e5YbNTc&>;bA0-E:]L:/??+2$
`endprotected


`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_L2_ICN_TO_L1_ICN_SNOOP_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
