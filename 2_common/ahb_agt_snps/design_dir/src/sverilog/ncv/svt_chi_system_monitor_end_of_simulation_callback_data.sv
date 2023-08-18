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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xzFNVt+qhhRWPxt7aQ/Ynrj3MI11KEPEpZYoIDx+0HDLSpkI+dvss0hpO+lBv0Rz
MSEj3Xxg2ZjO9+RUDiOJKTgIXzvA9BcjyLZTeDJxpl70SCC2nkK241AJLRe3n8CL
5Op/B8ZYOm54qt3Q2KUHxspBMoW+33j4I3Bh4Zg6GhGmhIvgn062tw==
//pragma protect end_key_block
//pragma protect digest_block
c0szvdhV0gZg66HinIlfXz5Bnoc=
//pragma protect end_digest_block
//pragma protect data_block
aF6+f3yshxK0m+ka2p8/TkB2vIkBiV8wJf8AxkrMP2DICz8pQPcgTi8I3s7kOJmJ
aYAw6jRz7qfh094q5BuluonPLUQwQuPvosOX2GDhu3voFyN5F6qjPIuSciSEzKz0
WUbeSgw5t3WzWq4vZMNeEIA940rRNiQTx4kotmdy9BcFdtymsrDA6oXBTwl7WVMm
nDtVsJ7JuadE1y9SY608Z+YwC6mN3RTDxYpGqBRK1wXkHYSh56XNLh6hO5af7s2e
CtphV3+Holz4Wz44Gjn6bSHUp+yuftCmlWAqFr//95HC1NgaG+QW1hpiaKyE5zeo
XDIqsIL4KKhMth/UbB1tX7Yab5hgcmuW7gJMAm7kpTVl3/YI3gayKZpWkKmGG2zS
e5jz9e8bY6qqirDyHdv3QXB5JowzvNdvDHJ6Xkx5ailKE39E4twdAZV58unOclfn
O9m1SHABshOX9Uj2Wlj3PXe5uPmLRfLD8cVYDDDKl9ktft5Lrf5DOaK46XJQ1jnQ
anNhIzOx/RuE2XCFPy4qeNhBX5628But+cKtrII2bQqZ87fW8kbdS4FvfM4Gzk3Y
wRsTfa4pdrNZNxQqcjdpJhtXqnCzA/67WbYYKEMNqF65+hrLzT9Wdb2EJ5cXk+MZ
kjdjfDt56dAdYJHqsCGu+sG3G+p1jfLvt6HZ60zc6xUlA9jSMJsRF5ZZIfwj4ncx
uB6ytoWgMzhk+PuQXzj/WPMASDNZRTE6uuZOKQXUa9714A9J8vVFjKGwr75d1gRP
PcDKXiIoHvKn8F2Vp2Lcwl41joqFp+nggeZ2ZHC42fih+qcKQ2KEmEZYMmVXhmEK
Zt35NO3Rj2G7FSvfhfw1OmnDlX5szOaxQ/wuY+4qfYODy8ORuQnrjDcW/U2OfLXB
P3vmy3YM1BXmXPhuaidGcE1S1Pcg4KEHAEMrDB3rQL4=
//pragma protect end_data_block
//pragma protect digest_block
TzPhcvjyBHe2Q/0Xp3YXj+K5J34=
//pragma protect end_digest_block
//pragma protect end_protected


`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_END_OF_SIMULATION_CALLBACK_DATA_SV 
