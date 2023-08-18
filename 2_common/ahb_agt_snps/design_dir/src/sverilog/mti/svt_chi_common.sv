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

`ifndef GUARD_SVT_CHI_COMMON_SV
`define GUARD_SVT_CHI_COMMON_SV

/** @cond PRIVATE */
`ifndef DESIGNWARE_INCDIR
  `include "svt_event_util.svi"
`endif
// =============================================================================
/**
 * Base class for all common files for the AMBA CHI VIP.
 */
class svt_chi_common;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IDtm1IFFAi0V9d2X7VV70mE4yJqed3fR2QGjcpOKK4965qsTDN75dkRSM4NwsJr+
ZrnTx5OABmvCOgkUMAeCKGnkt7de0LG9BDEeV+fEy24ROsf7FjB5k/XOPrPDgXMH
DWMxxNyqS2E+G91sfM/5sMYEB3K/P+UkEFKLrMJKeEg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 146       )
31uWjkXhwZlFuf3P2H6CV9fQtWbB5ne4lRb0y4HMIz0Prsj1CnqLL3kq9SegLZH4
doKO+hTT3CsrdxDkuWlCr54BWXgYxSetcUsbSHA18Aa9dibIfKeoZ6mSyM6p2za2
zDbo1ew2RG/4q+LzJyE4ugaGbmy1PAKqXVlL+hzFnmgRMgKbaxvnWYR8e1o/s2A7
YY3GyBPR9FXC0NvMyD5bEA==
`pragma protect end_protected
  
  /** Event triggered when input signals are sampled */
  protected event is_sampled;

  /** Configuration of this node */
  svt_chi_node_configuration cfg;

  /** Indicates if reset is in progress */
  bit is_reset = 1;


`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;
`else       
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;
`endif

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param xactor transactor instance
   */
  extern function new(svt_chi_node_configuration cfg,svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new common instance.
   * 
   * @param reporter UVM Report Object associated with this compnent
   */
  extern function new(svt_chi_node_configuration cfg,`SVT_XVM(report_object) reporter);
`endif

  /** Waits for link layer to be in active state while reset is also not active */
  extern virtual task wait_for_link_active_state();
  
  /** Constructs a "friendly" name for an XML file. */
  extern virtual function string create_xml_name( string xml_name );
  
endclass

// =============================================================================
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jJBU92rt98y/IIgf+mYj/4b/tyF3H8dpwtNGeZRm1BioKRkXRu29zttDmh3cuwfG
T9t7RBPuyROvkUAHuN8ldcyzPGIrQsOe9aheFB3QH9OP2k2Z6OEWJxX3DAPNLoPF
+9u4Wsx20hSbPjc9lsUJQwJ2IX8GOETpYdAnRoboPEQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 755       )
cMoJW+0gYzUQdRxa7B4Mts5PHYCEoinviY0J6HhWxJHTZb6EvmkHm93P0deZnsBi
eOO1YNkzU4c/QBGsBVcS6fX0MnMeVDog/mvXQsZx1cnq4ZGZ+Sx7ltC3P+Isjg5a
I3UW9U+IyieDk3DmwYW0S1vR+gEvdZShixBizFKA6JffoRLNhUU7hSFy9ZBLzSJt
YC6EEiVyENakr4OUKnjGh+FC8mbGfYTEV4TwTM7J/XuCLMCAMOYknuN54UbGSnYX
3qSWD7JiCNwPSTmQ23IY9jMLJnKrgaX3Suao2HVLXryVhX+cOGyuqRBbzs/dVXIF
Zdi2CQAO3xNO1ZDAMZnx1P63KauGVwg/Ov01j8HFBSiV2ilZzLE4mts0Qs2oy6Rd
ZUso5jZz38CVBZiLKd6atvTwBocZHpLzMdqyxxfDLXuzaLuPs/hSGR4lEz9APPRG
9CGDMU9fqQSI1yH9NVkDl7PKyXBxrSPUCKGIYZ5CMrqJCBt8ONo70ZdPhQnnDVQP
ui7q5MNA3K/GgacQ50x24pNluEKtYVTk8LyCN2bgaAlVs9Nk1mbN5aDBWDRCdzjf
RDG50rHuXTz6/JtJJwbvlVDN7tVU47EpE1r6rStkVeXeNLlepDbWC7dA3y6IXKpz
z9YicmkxSI93nt7C4lJyhkvLTj94E/ORxh2l2hTHJgme3EbxguSnFup+2vuOP5H4
Lno1NM3EVS9R0qxQsRAaUGrJDswNmD1mYIsxDJ5C/YhwAEJbRMXnHJOkLkbM4vvi
IaaDuLMHs6R2H+oIQE2IOd8853usGp046DF+IjVH9QQnjN5dFAjpFDamxEbTNQIc
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jpJA88iXVjL7xtCG9583TE6Nt52KXNZGAGYSDC+x7EcuozMs69iNph2uLB6V+4Ch
E9PzDWRn6XRHm5BXoAs78+guCrMEf+gNiz6cx7GMNraDjiPQ98lzU0mpsqs6OSBj
b0nvol+dnEcQ9RECfSPsMFHmBG289VApILQ9qxvJqbY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1372      )
MLxPuWxEPIHx98KzMEIRGFExqqJVJi0k13/sQL8FARE3BU4s+Oion/SLz3j+tLfu
aghmecxxIV0AYAQT6bfs8pDlXFB4qRS99+UlQ3Kunx/8jt92yRen2rEbdoxy6RHv
2zI4bc0UZfNfR29xKk//8fnx3ALtPqq1gBUm+UFShaOpORuN9zKI2G/XJX703uLm
E9tmhht1fbH5VubblKtTNQpbHSPwap4m91i8TQajujcuqVX8cgBL/tGiW0AwpMuq
lhm0nZZ07nawJCu39DiQNRp6pQEzg4DP5SM30W0QO9nCkJTyBP6NHeo4HY3e64K2
PO3kFdn7WLxEd2s/2q/fvrP9yXXqzb6IlI5PBslHYXWjhlG5I1QgRh44G1oHOzQi
a7r23k11z7vrLEtFi2btsyHBCc4pJz/ykHH3eub6UtEIc6bsOK/4E8yQNM+xzvtG
trknyAafUVbX4Rtzcp8ix9OIWbaC913NWqcS8UOMNO0zT1yn2cSiU1U19v821b1M
nHUZckDPt+9SO4ry3O7Y5QFvG/0FQ+zwu39Jx+4dAH6nkw/DXKSf1rkwbxrFIed5
NtUIZz4U4quk+s0Ipvln2nrNIWUBAE4va3VnswHiu4XTE+sEsmpjsPyrVP+ZtdcL
esINixHgjUBr3/3ZZgJxV7volrMWRN2wpwrAupmtAdKuvr4ikMcsgw5nGQjO0/ZJ
bIWHa4uOcUPhEIbXey2+zABJ7tKP7e3q57QxXD/ew+1qEAww7k6wPZdAWw2gBugj
hfo1R5xpZ5dtmFliXS64I6UCUCtnj5CeCTOZW32UeUkfMWl6Xbwax0TtW9JncxlJ
`pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VpLfDaGuBaWyQhMvV0STAFJsp/CiK9NzDvF3ZiLgcXKuy15vVqB+MfLB4Hgv+VUp
KM1NarZ2gKP+oWtupSGPc/+j+/qjdWer3PtsE9+lbmI9sCGKC/VNDBkGc7Oe/2GC
ZmswTW8mAniWIH9lbSXJN2+g2hrao8h/g2AtYUSISi4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1455      )
AJid0/kB1hHo7JYSkGwwHqa1bMIab03e+USCgd+NR12I4F2m4/oPFXh8SdtA8hPD
INYO/yCfQXfbEt/4xOyqSay6Sw5tpIXRZTl7mP7ZmHbO4MtUMNk2ix/60eMv8Edg
`pragma protect end_protected
