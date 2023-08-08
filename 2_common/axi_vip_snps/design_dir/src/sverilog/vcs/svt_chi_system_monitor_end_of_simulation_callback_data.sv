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

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_END_OF_SIMULATION_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_END_OF_SIMULATION_CALLBACK_DATA_SV 

/**
  * The data object of this class will be used as argument to end_of_simulation callbacks of CHI system monitor.
  * All the required arguments of end_of_simulation callbacks are the members of this class.
  * The additional arguments, if required to be added to end_of_simulation callback, can be added to this class.
  */
class svt_chi_system_monitor_end_of_simulation_callback_data extends svt_chi_system_monitor_callback_data;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_end_of_simulation_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_end_of_simulation_callback_data", "class" );
  `endif

  /** Queue containing the handles of all the SN transactions that 
   *  haven't been associated with any CHI RN or AXI master transactions.
   */
  svt_chi_transaction unassociated_sn_xacts[$];
  
  /** Queue containing the handles of all the AXI slave transactions that 
   *  haven't been associated with any CHI RN or AXI master transactions.
   */
  svt_axi_transaction unassociated_axi_slave_xacts[$];

  /** Queue containing the handles of all the System transactions 
   *  corresponding to CHI RN transactions that haven't been associated 
   *  with any slave transactions */
  svt_chi_system_transaction unassociated_sys_xacts[$];

  /** Queue containing the handles of all the system transactions corresponding 
   *  to CHI RN transactions that are pushed to system monitor during whole simulation 
   *  and eligible for RN-Slave associations. 
   *  This queue may contain some system transactions that are associated to slave transactions.
   */
  svt_chi_system_transaction asso_eligible_sys_xacts[$];

  
//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_system_monitor_end_of_simulation_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_end_of_simulation_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

    
  `svt_data_member_begin(svt_chi_system_monitor_end_of_simulation_callback_data)
    `svt_field_queue_object(unassociated_sn_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(unassociated_axi_slave_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(unassociated_sys_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_queue_object(asso_eligible_sys_xacts,`SVT_REFERENCE,`SVT_HOW_REF)
  `svt_data_member_end(svt_chi_system_monitor_end_of_simulation_callback_data)

endclass
`protected
OE>[EGdEfXDcA1PYEgD_G57G&YJFWMDHd9^VOU,L3@<TH6.4&Oe;5)?D4O>#2FJ.
TdR^e2CQ+a;+P\BV(I.gS^d]LP7PSU09e2.Q53A>[4;:a6.eD@YKdH04+MU:34P6
WDZa(7P\^4HG_]?I>,84^EdR3YEXVJ4YNH@(Z8aIJ/PWd+IYY^//[L&b<WKdE9FJ
5RCXTJ?VbeGbb7XF2cPZb/-A3]1,&SP4(@g&J,EQY3<?#W-9c7KA9^DONSD\,RNX
3N46#?cXOW#=H_b0C-POCI0@b,\QX/g2,2SA4c;_^<NJ0Y3d;[02HJ>Hc@7&A7Me
PeA_Zc[c)BKS:1-7d9Ed/[7<1-6U:=g;::fZW;[[f#R:a9FD3JDBZM(M9<K0f#8)
IYW4O_>^HKK3[.\d,(F@E[0->589W\<X>>S8/aOVHAe(>:-gbY9RSPE]G^VZ^a?M
,]K4#COY,?.C8Ab0[(Wd_YAbWS+ERGQLbFJABAf.BF^?P+854e/gRBaa&/_McLEP
fH-]:&aZD0A#g+8fGKT-9eD5FTY0804V4XB[>=(YB3Z?D$
`endprotected



`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_END_OF_SIMULATION_CALLBACK_DATA_SV 
