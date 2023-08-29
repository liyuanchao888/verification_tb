//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_EXCLUSIVE_SEQUENCE_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_EXCLUSIVE_SEQUENCE_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

/**
  * The data object of this class will be used as argument for callback in CHI system monitor to set the expectation for the excluisve store transaction
  * All the required arguments are the members of this class.
  * Any additional arguments if required can be added to this class.
  */

class svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data extends svt_chi_system_monitor_callback_data;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data", "class" );
  `endif
  
  /** Handle to current exclusive store transaction. */
  svt_chi_transaction excl_store_xact;
  
 /**
   * RespErr status observed in the response received for the exclusive store transaction
   * Applicable for CleanUnique and WriteNoSnp transaction.
   */
  svt_chi_common_transaction::resp_err_status_enum observed_excl_store_resp;
  
 /**
   * Final state observed in the response received for the exclusive makereadunique transaction.
   * Applicable only for MakeReadUnique transaction.
   */
  svt_chi_common_transaction::cache_state_enum observed_excl_makereadunique_final_state;
  
 /** 
   * Expected exclusive store response
   * When the callback is called this field will contain the expected exclusive store RespErr status computed by the VIP 
   * The user can re-program this field based on their expectation.
   * User should exercise caution if changing the expected RespErr status from NORMAL_OKAY to EXCLUSIVE_OKAY as 
   * VIP expecting a NORMAL_OKAY response is an indication that the exclusive store must fail as a result of an invalidating snoop or an intervening store.
   * Applicable for CleanUnique and WriteNoSnp transaction.
   */
  svt_chi_common_transaction::resp_err_status_enum expected_excl_store_resp;
  
 /** Expected exclusive makereadunique final_state
   * When the callback is called this field will contain the expected exclusive makereadunique final state computed by the VIP 
   * The user can re-program this field based on their expectation.
   * Applicable only for MakeReadUnique transaction.
   */
  svt_chi_common_transaction::cache_state_enum expected_excl_makereadunique_final_state;

    
//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY
  
  `svt_data_member_begin(svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data)
    `svt_field_object(excl_store_xact,`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_enum(svt_chi_common_transaction::resp_err_status_enum, observed_excl_store_resp, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_common_transaction::resp_err_status_enum, expected_excl_store_resp, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_common_transaction::cache_state_enum, observed_excl_makereadunique_final_state, `SVT_ALL_ON)
    `svt_field_enum(svt_chi_common_transaction::cache_state_enum, expected_excl_makereadunique_final_state, `SVT_ALL_ON)
  `svt_data_member_end(svt_chi_system_monitor_exclusive_sequence_transaction_activity_callback_data)

endclass

`protected
Se/R/M/PJHgXD/<@CANbZLNc<>_cJfOQBG&c@X2BgE>Kd?Af\UJf+)b(c7:M<2^4
Ucc55U\#-.Y><YVIKcBXTI0/3b9KD_]K<;YgT.G;4K,Z;GH6O2[)37TAgP+I=X3)
=4ZT,[<TR]SY:7TVRcHR/36@\G2T@/Td;))\CT35BgG=I:?[;6>KZ_ae[d[5f.HP
?d;>(E6EbKT_J@0deYd\NbcY519>\b^:@?6X/aJG_Q57=>#7AAF)=71]T>)=9Q><
EfVdM^RNKKBeD?)MB5WK).YZ1Df^6&7,74eH)MW#,7&1BW&7+VBJ-?b_.2^P75S.
0[C+Y9=60a\3bDYCD(RL1;2Q^\b\cGAO3/_NY9CWV^?+J[?XG\(-1=ZO]d&D->9(
4OIb=TFR:7-b@Z+dADKZ1bLdH.:egOFf1c2.2D-Q3_ZUHCZ3;+5^JbQ0#)E\D,.U
AAA//:2e242/C;#F_]I7GaKLOF=8M;MF:CN\15:bT,e4RT81?-J,LE(Y__cXDKVc
>8He835]U?#&L)b+HD#MbJ763\WNGBR3J&@(@3g\cJI0SNN;2+@RKKB[JE22TF/A
,;?N#90M1\,a:XE^(?>E/TU5IR5Q,+FNcI\dPUWV<;Kf(1BH7-eSQ/;a6S<TM45#V$
`endprotected


`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_EXCLUSIVE_SEQUENCE_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

