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

`ifndef GUARD_SVT_CHI_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_CALLBACK_DATA_SV

/**
 * Base class for callback data object. 
 * The data object of this class will be used as argument to newly aaded callbacks in CHI VIP.
 */
class svt_chi_callback_data extends `SVT_DATA_TYPE;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_callback_data)
    local static vmm_log shared_log = new("svt_chi_callback_data", "class" );
  `endif

//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_callback_data");
`else
  `svt_vmm_data_new(svt_chi_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

endclass
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gz98aF93G/2Vf+YRyl3rtRoOilWCmZ7dDkPeTzxSLD4CLT1BlQ4HZ7Xk+2qEzhxo
lcT9kDnCoHmXknVrv/MNScypsAsREYE2f3ACJyH+Z0j03t041hutxVfSF6uNSkWd
I3p/X397/v11hPCA31cDwoRFP8B6eGdLYMn8os0WcgIb8CPdkfyhGw==
//pragma protect end_key_block
//pragma protect digest_block
GCIB93bSdZVk4JVzkGm/ZTdqzLA=
//pragma protect end_digest_block
//pragma protect data_block
UdqsvPmu6LNMPwBExZToBJoenqcg1fOtVx3l+Tb994gt4xcSpbV3wlVs2zQIlBAb
PuUgVO+hWC+xmsFPj09fJ9LMYsicb/FhpFw6DMeWG7ydzs8zuQT+eYAaCGzR+s56
LEf8hnCqk+GnY/iSe+kztkEGSBuBCCY6lgU0XlM7OJoWOqrxEyYyJFOT7JORgH8v
bmgTyE71CHIWW7PWRSHIN10FbxzR1H2B8NUUNaN2AXcs05eppRgd+ZR4BBIvYnU/
F9tr1h7DOoFeRyZY1Fs5MfbSqDNJQddlplvJRSEbwWVt5Mi2mgDVl935AvskXqhU
AXg+gYMlQSeK3VjaTxEYcBk3+517WOMMTln8editHIopjq/j4InAM6NLJC51q7+m
SmlavGdp3+Fa5SH5/WO370P03mS1vpdwpX4/1Sg/TNgaiKyNShXB4K3rN57MrelS
R9cAWSU9pLwNAHydOqq5uKPia5rcUi7lptCldTud48UTR/NAu7++XDvmDXlHxd7O
lOgqBPkUpf/XHlzC6y2GRm9isTWz+2AAZFGMTXrmJ+DRd9XbciF+0O1QQ1XGSO9F
uAY8k/CEVESY8VzlLE2wLeKTeCtVekkRHwwkT71emGlR/+Upm89w2GDLX94jOW6A
JH/dJRiu2RzOfAaIx/NOhsKwKW7BisL5nZuafwLaCuRuR+riHkxLcQBf9Nlc66FU
NMLYV0q6krDvC4ZwI5kEPITxzbLL8s1QiaUm4XYGvPnXTusNevMwbqDQLAsg6zT6
XPDXV9ugNsaTVrSdAeXNOyhiAYJr81TJQuhOsKCB3vc=
//pragma protect end_data_block
//pragma protect digest_block
Fyzaj5d2BlE+FbNJXUU//Xn3EQY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_CALLBACK_DATA_SV 
