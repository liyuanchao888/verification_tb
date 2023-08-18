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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VkkIasXFcAGXc0KLJHRVnKq7oXbc59SoZFuWIYyPmoLCL1ypwLjtQ8wUc7NR5ZiQ
Syv4TsDzanTtjaAlDPUs0L18rjhNe/ksL0adGMqHjiPPv3yv8RdbWP5PVG/Me5If
0cf0nVDCEraRixeGxoyAKOk/M6F5hoLiSIxPpejT6gE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 526       )
1GQhqBhZ7YEyEC8ffGxvPQd0GzP3dZZfqRh5vAcwNcGS5r1T6+KaFBTEV5FmazjT
l22xmh8bhjAEzqWJhdkUBumMYYVi6klmdsdep7dTRU4PJxVZS4z7E71wDAkJRNsr
1JHYJhnJUAWt0LKE2ahbmBaCQoMUjc5FCL01iFmiObszKqn3Hjgtm04JgPBP+LKv
uqdB4y5z+t3e+DCjSKAEchKs5Fwwj1QMHS38ifrnjJc4GU0OAmNZ11lj4mTh14gA
jqTA1htizQxLGlOEvL4NsEnjnmUagDrG56WclfCINEjoEoR5/mc5P9++sf39paFe
6P1o88t7jujvBbluDpckZ21Q/NQshqrBxFf83SUGJQ19u36GvoX6cvL4yujdgAy2
rIG71HxjG2CyXV1/wYRRjywCT5sJ04fojBg4R0cvpf1Xo9LEXNGHZzSTY4ydcaAB
HBFMZ88fNbifmusGbmoUYFyh3rVe9r9pPyW3P0SIJejfjvIKIatim9t/Fr7yoSve
XbM6+CmPSdW6TpuWUorf5aCJTuCE4Q+btkMMGei+dO1b3Z7p/WAfgfEGfPzhsVH0
IepiiW6HIRS4zu24DkzqWEthB+mmOevqj78DkfMH/J52vL0U8fWOEDrxZswMZP7M
ohzycPWRmexxTCxJZITMK7uCu6zDDdEsXkYXZ+DiZDQ0dAyFz7nyvqAQpjT11n0L
`pragma protect end_protected


`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_END_OF_SIMULATION_CALLBACK_DATA_SV 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MJk3SRExU9DmMPfXmW4RjiGE6zMIh3eT5QiZ6m0e/HFHBJC6KngjfeRfADxiuw7I
v5VH5+SI7sWWCYOspXvU18CxoKB+kak2P4efzIynrpy6TRqRoE+7s1i9ES9y/iTL
b0392MZf+f8/6yGVUHn736AtIU4MPOyWzNAj4a2MpFI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 609       )
n/9Z0rtwV6X3IXEW/zl4KOPhZbcrSJ/X4YhqbD+KrB4zDfm2vUT7Z5btNqgo+Tfa
+BBBuWnz/sMkDWcbPFY//Cp1x39D0OoICtAK0DSGZU68/e/KeaNyKRFwzL7wubAr
`pragma protect end_protected
