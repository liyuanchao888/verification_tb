//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SN_PROTOCOL_CB_EXEC_COMMON_SV
`define GUARD_SVT_CHI_SN_PROTOCOL_CB_EXEC_COMMON_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RsNfnzyGyob6d2QjbkWx1rqt7SVXSVk9V+bhw9qyOaOGs4EtAk5r5Eb8GVnEmbuV
9MexTOuLtw7mqsAt5dA/kWspDViNJ6+HNRFxckW9mGo3y+Pw419dxQVdnoBfV2n/
5z4LNpBhU8mb2N5tBYB6goFrRwOieEx9P6TCXI2Gk/E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 484       )
6kxU7aknaiQyMKDODhg+AoZryPYY0aqK668JmK2g4coxrRpstilouhCTZ0lcT3wP
QA4haTp4m/YAtIjJXhyMiS1ywCe72PriruA1fSDe+Kj76CLZDUsKCrDjbfVuFa50
5hTdWEtKO9FrK67vjkbwQcTzvr996akKPtyBpql+GOn9A5jbSjYcdKgQXyJ/ZDzr
va2b/QwHw25t4NXD7eDSmc/gJK6GOPCXQEEyNPARBHXBFQ2k4ivk3xToLxCV/abF
3LgjsDMJGvwM/cX352U11naayAjHfH1d0j7NfrHHmn2aNLIFrpMYaE7SR/nAtefB
ZhZvH7hsCIa1gexqoO5zaUNKhwBwGwLCWOTBN7nJxwdG12AmLgLGAWSDsuUworW0
XDlRjQaq4rFQvMDyYeV9ASnNcDNRDdg40TrDAYRFceyRu27C2dj9Vc7UNOkEEhzd
piUXp384jEEvvkdTQxqLOSuthJTRx1DGng38CBlW3RySYC2CRjgAAp26l2EcVuo3
KkodYjtbHFfPboijxff1AOiy7EWfjcgiGNw5k2X0o86V4M1exaGGjTU1jrrjx6En
L/gIfPYA1XJ60wgLMe3R4XoWtE3Vx7Xxee0cRyxYju9hwR8zRGqm4pMBP/dp0rdQ
94zqjiTnRkvgQ9/fsRUkJw==
`pragma protect end_protected

// =============================================================================
/**
 * CHI Protocol Driver callback execution class defines the cb_exec methods supported
 * by the TxRx component.
 */
virtual class svt_chi_sn_protocol_cb_exec_common;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   */
  extern function new();
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GOJzw23bylFuRPOPGKnOeUdc9Y6NH7tp2frFApOxVNxVOvAWYnXRdeUgQTTLVmYc
sRP8snyW1Urv6me02XNXIV5q9KbLZ/klCFdA3rEBcE0yr53aHmLfciED/SuS0cIS
peZ94iSeKsUL8m11tphBm2pFfRpgp7PqFkmYWqJu7yw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4101      )
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
`pragma protect end_protected

endclass

/** @endcond */

// =============================================================================

//---------------------------------------------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mqrn4oqhzYeKmOn+EtcvEYXOh46M9IFHEcqWsKBkmcyahHmr7mk8wCt+QXP7k8df
fB9OkfPjD6d9kw3JFy3mTk987bvunkQqct4TDTuT3AnxjbIFStE1hXrcYISzNiwm
eDWG21J0915tJdgedP14tFN/ES9OoK1/h3AbCcvjL2o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4331      )
rFE5T3z8k3Y8McbS+1oKBdlOP9qVJpCY9rAltS4PZi15b+pjnlSA91W0LqxgAsAt
XqoMbd5nVKjHjH1rXNlxkaJYVLBXpRIu4lFa/Qa51NAZb46yJHUHBYx/4Rn2HgcL
5Vp9Ym0B1yjsAtTHr4LP+C1FWH/OqwQB9H0d5ywJhXTMr4G//lj4RRf8mEad9jG6
mPTTxBrDbnIueTRHLMt6e7Olpp6AR61PbBPtp+mOPuJvoa97JxrxydjFMIx7OcWh
02RZHskAUO76Qq2G2xk1YlDI37GXuL1LaqsYUKZuUJ88U6pyMpi6Eo7pwpHfV3wU
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_PROTOCOL_CB_EXEC_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XZ0wnYI3dhMc/oEMME1l2HazKADPimxCRCrtTb2dHD88iVzMhT67qXrCRH2Xisxj
lvm7bxiB4623B1kJxQ1bsWV/6fJYAcd5EOGr7VPRv/9BHOt0br0BpQ1viga9P66u
ipBfj+a3N2wcaIH9rWcuC1eZcNJBZXNThM7qIir+Wqw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4414      )
z6ktauUVhz/+mTQWNdmHm8WreT+Wo0viMMOBpYtopgdHZzUsEIALejs69wxeZGmC
OMLTeryjs062qgwknHdadO6TkNf4eYOyTLQiYJ09maxTdMYpf/m0ajoGmblkDkJ2
`pragma protect end_protected
