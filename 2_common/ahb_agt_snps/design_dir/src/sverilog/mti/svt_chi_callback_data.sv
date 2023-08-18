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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NdQIrQwcmZB4Nj57PWMDxgkYBNkQofJYMD4sdyEo7/+3G32n8GpJdf6hfy2gae8E
Xvl57J+5xsRHL6Uu7cIgbgi8qdLK7Gx2OiT2x6MUZ7W61tq5EuvzFWL2Gmvp3fHT
RzL+bC9sDTFR9lkgg/ROEf2ItRDXV3dUGdiVL2lJA4Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 435       )
XJzTADg1Ip+nVaCGi2J6hm0MRHqZ+BeB/zLAIf2Z8Dqtt25aHysUaeqzg9vqSv0t
CBVI3f0CTjFZcFw8HZE90DiCHUYUJRZgWWbCe0FfigvNLWXeFcECPbLoPdETGieO
ykYgmIs+okDueT6ULruO8SPaNFOrYbxBQzg9fcbKvOQoTVps270BiS0DKJfD+U3A
Nk3hrVlaoGqjQdgvIseAPF9hquh3yB4vn789HhnFwky0EpJWaQwBv+pLB28AK429
PBGOsu9j0MWC3uG71koZLeOLax08AzXte0GwUbNfduu3W1G0/i8UDj1UjeQKrCDK
XWrPhoWTVghIWxdMfqi25VzS5C6XRvHmdjclwKQpykRiAcZxD3o/3Q2MOVV7AvXt
DqfFehEnVrxh31eexJfVx9VnAFirfODA4hC99mEjr7LAd2e5AoR6C2hoY8y/PSfN
DmVJw5Xn8X5twMxRIuedTIs1047sLibX8U1f9KIml4INDtUPW9bJPIo+nheJ/sc2
J4+xNWOSQlUclK3ptm3Aj02/S+wbaDTZXmNPdbDBkOvMt6JEmE+tDVXQbkwqvRUj
S8x86A4ASt95uzWIkrRBDw==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_CALLBACK_DATA_SV 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ENrQ6RyRRr8TgZgMULOIjdsoVteojfhyexMuCAoTXZWU5UCShso7z0c4BpEeZUFq
pGhDRUHQqXvUjBvDI2Bxv3bnL5yE9FdC9L0zjOKV+lX3n0FLJS5GI9WsSbeguMyr
XSpm8yEF/yxv/xxHuCqUM1ir6QrK9nW/j6NcU3+F+7k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 518       )
4/y39mxh29rUHjjUnGxYnPJxBRuXVTwfffG8eaLIzoSRtwqWLdh8OGmYiApUrqyy
1il0/M897Ee4gGqoGISSHhP5Hx3qvwcukdxcXlzWsPGosvHA92B5kOMi1QK9EdcN
`pragma protect end_protected
