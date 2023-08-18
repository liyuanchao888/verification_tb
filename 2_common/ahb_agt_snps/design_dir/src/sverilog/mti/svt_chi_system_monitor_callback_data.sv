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

`ifndef GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV 

/**
  * Base class for system monitor callback data object. 
  * The data object of this class will be used as argument to newly aaded callbacks in CHI system monitor.
  *
  */
class svt_chi_system_monitor_callback_data extends svt_chi_callback_data;


  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_system_monitor_callback_data)
    local static vmm_log shared_log = new("svt_chi_system_monitor_callback_data", "class" );
  `endif


//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_system_monitor_callback_data");
`else
  `svt_vmm_data_new(svt_chi_system_monitor_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

endclass
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
K1Hja5Y4od3LFw6i4YEDQathJ3E9cu8Z8B+xG78CgHSfTgVCdMtw8rAi7t2Hep57
H/ntUBXsyDjkj95Qvdg67Zjc9067AOnt247LQdo+Q77GsShkn077oUfX9YDZ4JlZ
QXFqCFKzni5YsI61CXIAqr2++mjV+RAT5yqvgt7Jqa0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 472       )
jkqDFOEJ44z+RbTRPWFDoIeIwiMzB2bAlOArxSO+f3rv19ec7hVA0Gv6YcvfbB8l
q3zIc8l4qCYxfAzZKtj6uQhOK/fMRXzu1M4Q8UswDcmWY7GINI8NfzKS/2pLWex/
rv+XOYEmJPdZPhIkJ1NXEBKOzwGtYbO5cOiZ9DXTffQC0UiYfeh+VLfLf19VJPfu
uI9BNn/GVvdFiBWSsV/j9K35G2Zx+g0VCSJdmGGoFcw/wZfIcCtYfH4/1mvEwprg
bTPZP2qJtHlq5tZZGCtvUwISd3qXYgX97JBLkaMnhqWNYxO0vpYMClN7qCdwgdjn
KMY7jfPzSYZXEozZJs/PSxUbqz8fpA/tXRMGhP3OAdyTWbk/EYSke1rrn8fA+sCI
XgkYXN5A4FTWZ2u3Ve6WCiEUCQORsVrGXmxxh/q3t4HoGpyfyC8zky0pOquosvmz
Nh7SqHwni8m5B87T2ao8ElBeeU1O6MUdOtZmoQjFWg2irOcntOYXOwzZMg6ySXLz
SeXcGWzketxZunVZxr25EiTPt5J/c6Nvbf5gLuVtpEIag6Sl6dJcxopD2WCBLkPv
CzkyqnS1IlKdlKBBZdRdz54VRgDFULUfq+7C2rzQIuayMSiOmCOD6AKbtlmqV/M/
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_MONITOR_CALLBACK_DATA_SV 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GGGue1JXPgvP1N9UlTrIgNC89ciIvH7Y+K9G0vXqSAM0jxybPp8lR5Wohq8Khy9Z
bJ85OKFON7Oq9IFdFm/F4ZKXQrQKCLjo6dwqdsvlEoSVxdRMLFjnXoeVSI3EGVxQ
aXQQdtYdGeqfyxiu9ReeH/CuvfRB7RBHvETDc93eGKw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 555       )
LOaP0hwt4HtUmxbSL1URJJ2kFnELt6wqHrfByQxGTbup7bc/TtPLi2E9d5I841fR
auGvNstHhc4Oi9UnqenU5qb45vT2cOs8qq3LTbzjH/whnBJ/5s629uN5rSWBFrog
`pragma protect end_protected
