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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z0TPmbZOnGhmwFml1XQ3XxivD2Wy6umt2wZ9SqCOJ/ltzB/PEjoBcDNaObPKEk7+
q0YBO8unK5BfH+g6+cS3FfqHYhzHFtLrs5OckQzCBv8nQxV9SVgsI7hzW7x9SnM1
pKISnfYVnCMYRl3d6P8n8sn7RHi910JmkjvG8hzEaPY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 592       )
BrV/S2ROMIWOyguemKQClRPiKfYm5vsW0D9AtcVgHQtPcgB/l3mDywxf5IiRrToC
UvT/5BDH3bxLRgfeZgACjqYqI1jTY8fNNdwm0lyPKEbuSb7ivoKoTEDsOqEorRdP
7xVdZX+qylmsg988wetcLfRwwWqxjsX4Yb5qmD4LZEmb+0eZPoS9TAL+57H4zM66
GM8f9D8ixvAr5SKD3bwyVX8k8Na5bFEFHOmrN+7pEJpy+lybXU40nGXDdqVXk4x6
b9RL9Fesl0xjQgtl5BPxsR9ySJNh2E2dnoCgYoRPqqZJ7XZ+VYFfZxWaHiywdhkl
jB97gqrj0wMhofgzuoxnqWazjkKs71ZmH4qYxC9N1lPiSfFzuRYQt2mSlTumPMZ/
dzKmEICbBT30NRT4VYEdqCrSo0ATxWOmmOEUvKD9KHzdnKYpMBq+FiycA5fQAeJu
Aq6Nn3Urnm6TaBxQFY/HKNm6AcWIDSYS3qhaGqMJN3gA/LN0UVCxEdGGKDUucdpl
xeK83S5rwJX1nfrL9AzdpMl9HLFxay7XUs6sXBEsLtBWfE25QK/pFmoNKJuO9i5o
fHotXQjd23Hz7RpfMSRr8R4f3AZHQNJUYMv5by10sKybWFiqeFWXiPfp43T34XOi
rPFsvacsVQZ3sUOG8PD22DddGC7980PkKneemUJxWQH9SsAn+e0+L5jOE8kVHWNM
xixt18Lpe7PYp+//FVbFDm9+g94yObnuY2Fw9sgk8dD/ys1Hbi9rdTImK/SwGkFo
X3tZAp7j90pC87L3lwU0vCf/hTUFBHBwo5AkVYPixcQ=
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_EXCLUSIVE_SEQUENCE_TRANSACTION_ACTIVITY_CALLBACK_DATA_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
o9wBEa63dF/vx+9K+0RhWlRih8BESCvsLG1timTzGy4R+R5KgVfR3vwi0cZPiU+O
Lrz/HiZjz7r1Xmrv1a9qt3ZxcfIPfODy5GyNJ9sW2yerU7/CJmxWJcO3+0Ss5R3b
qXonSNOa7+AvNOG4rItGOKIwW3Vx+736bf+dtjZLUV4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 675       )
aKG19rNFShl+JSNJVeVjXB5qnxSZ0nhA50iw9+WzM3ikkP/9InWogs8qjKeirdlR
VNWcIqPyurZJT546b/HqXqUnoV2GLfhNhWj3NryjGT5heyO4dSpJsnBFCqjKyOuS
`pragma protect end_protected
