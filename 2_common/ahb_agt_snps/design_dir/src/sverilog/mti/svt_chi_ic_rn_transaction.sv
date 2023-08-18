//=======================================================================
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef SVT_CHI_IC_RN_TRANSACTION_SV
`define SVT_CHI_IC_RN_TRANSACTION_SV

/** @cond PRIVATE */
/**
 * svt_chi_ic_rn_transaction class is used by the RN ports of the
 * Interconnect component, to represent the transaction sent on the
 * Interconnect RN port to an SN component. At the end of each
 * transaction on the Interconnect RN port, the port monitor within the
 * Interconnect RN port provides object of type svt_chi_ic_rn_transaction
 * from its analysis port, in active and passive mode.
 */
class svt_chi_ic_rn_transaction extends svt_chi_rn_transaction;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_ic_rn_transaction)
  `endif


/**
Utility methods definition of svt_chi_ic_rn_transaction class
*/


//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KAcyx9002NPwZhSONUpvuGmjW+JrRD6TYk0JdcEvuDKU/qUkfPQOhxoBfWTUcPD+
TkBMjOfhygbkrpdMxoxbErWufhI+Q0khrAsh9IZfutn/NtGaNigpZCxwHhb7vgGv
dD/xhCbj/oEX7yphA9K12nvPlf5AlF39KolF2B9pWuY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 672       )
RKaZhx1nipWvWsnR90KPPGEXfcojm0ULcjdIKqA4PIFTDSd1NW+10cnBZcOR/XTL
NeJXUCUcQOLPZLzXQ5LT3N/Oz69TP7AM7mTTCdtY6lxxfZcIzHuB70etwK/Aa7IF
wOKqy8BJ2gyistaNgkniVcIjTrPkS5Nu4hjYpYCZYSgOdatjK0ofFg/AfZASAvP6
oninnhwuuVdzk1RWj3TB8XpUov7XW1ndI5eKUkp4TnVlMCQHXEpZ6egXOM+8o82Z
vy7TraXPtzzR/mPj1pA9HnBjP1ZvgHaDPQzWICQ2hZSS2Y7oyt2yWCvwp50bKsAg
3kM8uRyyGoPubUYXcE84dF8GiR/SCblmTxcTqatoNeG59I0RqheaYwUDhmMfCcpG
98cAS1+nrT9wjeSy2UEfV57Xfen3FVxgwdpxQj1GekLQZXJkpDD0GRfLIrd0r/Vm
tFR6wgXmJ6voNmhztaTB2eo/q6lwkrZUoUDdLGELJFLipuDIdenlaYUW/we+G/6M
GceB2KeW5Q5k16u1ievb1tKtNgv6V6qwxO77Gu4BESsfLlJtu4k0SJ69KIWDP5Lc
LV8AzIJmjzzVDjGiArRRQ964ztP6PyNG7fbMXJzf5OcD1gK6HTkZc1pSPKRcdBTA
QdKTbu8eLEVsnWZsCo/4wUhKnbIjdO89nq32HW9OriKY0k9tL4nxJxPNqUvXr/Yi
vfZbPD1pmejTtn5PIXLv6IHYhWRiXLZTJcbuQp4PtsBcA4ax01fg3c5fLcrWBxhR
0ySklPORoq3mY6lV1VZoP9lpSirqGEiN3g2h3/LRYAVaIolueYbAG6fVUdcSz0QY
QA0uBrLLdgWWvz8B5Sru63sKYsOu+twpCQJgnpgmEMgV98FJf+RgFG24o/RpILD1
gIhuJdQx5wcld9RN3ouuUw==
`pragma protect end_protected


  //----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_chi_ic_rn_transaction_inst");
`else
  `svt_vmm_data_new(svt_chi_ic_rn_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
  
  `endif

  `svt_data_member_begin(svt_chi_ic_rn_transaction)
  `svt_data_member_end(svt_chi_ic_rn_transaction)

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging. */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /** Allocates a new object of type svt_chi_ic_rn_transaction. */
  extern virtual function vmm_data do_allocate();

  `vmm_class_factory(svt_chi_ic_rn_transaction);
`endif
endclass
/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i7FpSpxCVKhJkJ2OiHsRRTAqJ8175gVbJKF83b9CBGspogRTTdZNPDZcFu201IIP
lGDpcqPbIdfYaxuKzWdH3NoPlyxVRfkB/M8s8hCZrT9IHR6tsDxKIpCukii+XVZ/
lJOwkDlSBP/Fot9ci+iNVNn1VbSk5OiJT9Asz8pBTIc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1088      )
RwhOJcfh9D+payZLA3Ouyt6KZNQ1XH57gotXOXqRVG5HeBCMhyyotf5tD8CZGrH4
Zh9uKoN9X9EriM4GiONi9Nl8c3vPcnHQrLdvtrtHKPNuxMoArA3C3+0i3xsW9P8U
N8bMdvpkD3RcCb2T/J7uXasLaAUd26lYMTSvFmt1IWwTlxoyMQXvLLNpw9GcODmW
NYeAA4TGdfbt4hvqklS3mSAuuAR+N7iFcQFPzJnXiQPi86DrOnWrs9Gv6/xcjT5o
WNOoTZPVSLf1yNCBXX0haa3UlqlB6kBnoo5xFhvUGydgkIQe60NvnU8Juc86Chgw
N2aqcnSJmyZkZyOOgYzq3Z+zxuzmFKrUVAUGFAzdtHrEZTPR7Mt2lbiPJHUotb4M
AIGL530Ivv0PouiYs9atvTxbtfZ+h0z0HiqEPW7966If7bWcr2lrPP1UpHUkx4iz
OjS6tkO0WxdDIpVS5+8oP/MlL7Nc+REONe4bewiLlxB7Y2TMhUNNayA+3oY41vqk
njXl0wBEE5HVbjTVDeWcHh3LpJYGWiKksCGT9YbfAUOHFPKWfnfCsEtnuo9yNfba
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
h8x+1tw4kXjQrnOsYJR5Xxg8FaJ0cxxnPHlYtdRKv6exx3PhLoJxXcA4Z2IVGn0A
7cY0tfDZAwu/gxmQttpVhqCMzQupCXBVPKi8SdzkCwiI1mMzCKjyuGdNItNnMiY3
Q6blgVcfiGTpwvNUzWZHzW7BWX5nT07iO05Q9Arkp/M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1798      )
sgHMkJ5hXWvLCwyne0Rc4L2XTS0VCKJCtocVGBlXgg/6MtJ/Fg4njihJebuBSeqj
MrWC6417msclWm747xH2mx3slpsbsYyw+2AyM4qH3iYMoz8zU4f0w4bbAwT3smsj
fizvwc90bzW6fBSPwBIJ/y5ucM/2PPxeHFE3MjIzZ+rvw/1LL+fBLYOFeU7beG0g
ltN2tPkqYP3wDsLMg30JGaCwoGtJhEC/EU+6TQqstLTgsCjvZYTCC3QwmJv/Z+87
hWvgb2657RzVPvTzTOQ5IRLtgoc4JByKWx7DqqjjxtovUbe/D1aCbsJ9xkZ5shx2
T0A3YzV7YFzb/QEAnVL7NA7WDVwWKIlO2t3dw57BbTlFcF2ydRoIBP85dqiSHnPP
FtiiEGWaLo/dYbwiTb79bIz/4jfadmyi84aNNVfIDOQ2iCZvHCY/cAN862IhfFj7
NiqZazI1YYj8Mr+9MdyeGlr0ShouiA5pzHqckGfchkipYEGIHwhdMVS1RJQQ+QoF
rbxRkqbizVBZGCB3O+hRoxLCbw4Oy+97PMEBWCQCUTsb3BE6lMkZuPo1ch4bf19f
4wrbctFrCWiWGx/eqGUh0toC6MAN/qTmcxQa+v8jrQ8RYmyrtcWdKZ5j934gqTAs
mNk0DK4LJ2npWLK0gX8nH/P8qReQrd2+2uVmuxl6ViyhqgnUVaVDVtgtJZeJuIkp
8msbuann0waJ7tBI0WsxQ7FRz6KCvtP0CzDTU6Rs8ZVMbf5urDBBXEi8FEj9GfnR
ATg0G0yYiqDU+si7Z7GN/iKhAqygtvbk21VNBp0H5OElllZ5MfE/ZTWYBydGXanE
6QL0s74Y804l+paK2+hbzZjcoi60RDSwkgtqAUjFp/h6Ehj8o6GUjCBBfuOGbxie
tUYYNjVmBbkSq5zEl6SUY6ONb2q4V8k8EBxF9e8fgZwuFGaqFOWg8Ezc5BotHtZu
`pragma protect end_protected

`endif // SVT_CHI_IC_RN_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g1BhDlDNFYGN4XqIO7Q5s2yac69VvIAj6o53v6gQHTS2bjU4am9/RQOFjK0dLvs+
P8OJIS6uuUiM3tDJ7dhIwMoQY94wO90wela/puzXFbqdp2cgJyvAOXZkpUPmfjXx
a7QgvPEZbyvKF2E1bKcHIxXOuhii8JUn/7vZ9xoCW+E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1881      )
RNVGXh6mP2Otmb/1y/klAds6+wTs6wBVsVQxzYiaZymee5UESUCpX/HaTD69VcKM
+2ORWJB09IH3QRbvcfcBR3r3NzzaLq6Hk/DmI+NJNsBrPRljNEjC3ZQ3OV8+xsCL
`pragma protect end_protected
