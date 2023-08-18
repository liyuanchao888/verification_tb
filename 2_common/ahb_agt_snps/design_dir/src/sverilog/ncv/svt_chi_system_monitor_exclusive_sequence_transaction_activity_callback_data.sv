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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
un2RTQQFcknSB1Glp9MdFcTpBaG0ueI7HTJ4b0koyLxq3PW0LNLgAPwfmUcrtlwt
rhNavk3a5IoJ5MTc6qZMthE0iYHrLboo8NVi6tQu4yl69DhCXPtQ8raQjzGdNDel
BSkWa2CEeGfJEKa5qair9cicXbM0Y0cA8QkfKY2zBEDo/dfJEhapeA==
//pragma protect end_key_block
//pragma protect digest_block
JTCPqL9wdZtUqQnSaRg4mGSsZDk=
//pragma protect end_digest_block
//pragma protect data_block
+yoyU4d8FyrU71rP6T7HWHDQMFb+xUFCYecvKhgJmNG6b3EBUjQijOOu0Vw4PzFb
WoGfVPhop3VnztPWYEsvdhcWaOwFx3jMS/C7pRpgoT0OD5BteczcW0qCef4i3yVC
tIYzuYzQ0Kbqa8btl4q/9llauMTuEw2pVMpczsKz7WwAzVfFAIZA1N5cwCJwUyfP
YzOQlyXw7TBNNmKAdK8amd3mgB+Ig/5ElbVVsfnejt9oWbVkd5lxNv0/X53cdI09
Hc1Jup8CBnAstYg4yRX4fLWN+Rjqyjny95fr/g1uf0Qs75Y8LGknsDrEH0OBDsOi
/X/KI8KiigfXOKHPGmu9Vcqzo0zRltWRbk9m5pU5fpYkId5SzM79d83EJNI0Hqz1
7/muW6Rl3KAIYVovV8IFCR7mi6Vw1Dd7IN1ykKmyOAjpNjhCZ6TvHtTkwK7rQ1uS
u5lUnj1pBASe4ItlczjCE0YXwxW8qa6KOeA0zB1bKH+YCw2RsvqO8SIrVm0XeYwP
0C4Fixvx+kQO5pG4L/QULXpMMCd3E/qx3hX8Uv+UrgMPPKSYFYcKKImlVdwmGmxx
+U9Vx0yQ0nnh+GuO0cLYw/CBY54tbv51whILlGwTNUn/rV5vlcDcPCLpDSu1q543
78ADn5GJOMlFnjj8dylR2HJwH2UjoNn+kG82mdLVakJCaHB/sr0HH9IcFmiSoG/E
PKZc+YIEjto3rkWLhSyyXuehw00KjSicbmUqW0QY55VgU0Z1g/mgrKwDfglC654O
BWBzF8vUEbx9bHPmvmaBUGN8Fff8qp+zQa3+xAk5kdmH+QtRmYaXOK0FmXG/Qpu3
bw5QwE9pLmWikI2XKNcg2cj/d1BHmyo2dBpWhtS9jjpFfSBXR3s9vhuclJY4MryE
O59Yi9vn56SnvPZAcPAvenIKXlsNvEL8K4yc2C9EVF3A+ZhxsHjW5YtL6AWsRP3T
ijM5TovHVtnz7o/9MaCMiUsw6BY7mP2uYocc5LGbjebhmPyaQCsBegOwrvlsJtGh

//pragma protect end_data_block
//pragma protect digest_block
afIx6F/xUK+Mn77EFT36YS29UYk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_EXCLUSIVE_SEQUENCE_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

