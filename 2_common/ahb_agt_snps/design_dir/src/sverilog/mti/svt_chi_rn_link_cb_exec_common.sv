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

`ifndef GUARD_SVT_CHI_RN_LINK_CB_EXEC_COMMON_SV
`define GUARD_SVT_CHI_RN_LINK_CB_EXEC_COMMON_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PGw/MlqXXuLhah6jr54K1OAMaIxp/X0S5+EqRB7qJAcLoTVwbUhkY1ieDl1zLHlo
p13wXJ03Pivfgl33kbXuvfPaIc9EcZXm5qJu7y2aqyqd7nDdEnQrrZ0endsKh0aG
nuNbY1tgd1o/VwZ8yQpGhUfa93Uy2lSHRSe/iQX+yOQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 811       )
iWwLDIH/S9ukYhTQMh/TU9tGJKQJBbSDP0XubPtrlPluRTDKdTEYnGJ3hBefKRR8
mx1Q6oa2AZ9ypyaH1e3HB6axn321FVLqoS7ZVApc44f+oNMV2jQg7FPSF/HuKeaW
MtxIAGdHQ2uaynksjyn5AxIfTOTQmW5F5fmLyJd9CUyzwALUl/mrvAMNCvJiLI/8
wG3dVy7sICf1H65cDECE2Zb+G/rA6c2XK5LD0Hw+y//EmHRRZ9o3BYEoaJhQ4E6Z
HFzc6dFjdlc2AmA5lFuAHMyhkAdSOgNpOVCQL+AG7c1L8AEXvxpnenum/slf2tTM
ajhMXAyXv7jHqd16ewbELerQ9+v29AErnm67WtoiVqgCsFCuVjQRpdZfVybuavT4
cfmhmFODg2IwMsSjea6getG2Tf23hTxzadOt5Xp5m9Xrg8zChwXCO6Eqd4NgM+Vw
A/DMRD3UnyL5tJrRANB9WRYBhuDq5JwqZf8woi46JC2RQc6+Pqp9BYK61qleJSrH
BQqI2iG8YxWLLL7qwBbx8j7J2hXAUbFi+nftXMFZJ6L1CkVyAveUNhJvD27sBHs9
7frDaY4ycc48Q3LAZUbBE0OhAKT7WzxfPNBE7tiXkYHlrFEDbtvcHD2rC+RI/MuL
Eq3+F/DPkGFDUDZsr13XUqXBfuwFSfj26CwHg3uX16xMyhgn7VFavMEz/UpIiw6S
12NS8pZawIV+5eDlWxMvZtzCzaYUShpVuOaoMMzikeFEHjNOvQUZUSX7UEsVFUND
B4zy6KvXC3kbd6QLWCyHyjLlZ0WQL6Xadv3RP1e5zxOxUOx4cNzXdZWGTbEmICQJ
Sk5A5UnRwkNLYwmGXwQGXhK6+RTrQ9QlU0190bc9++r6utczrmGWanjHnEgbDEac
wzu2lLw+/51TR5oXYVIBRtLFW/9Jg/crGuTugZG4ETG4PcPJnCSuzcDcPefBLWSW
rAgvoBQXyYGsompEtfsPO7Bbi5PcCImb59VQQusbs1OgHwkBsMoqeHeZnPja//d0
kGVXDDgIttZj/kywuvCveSqxwSuo6+tbmU1C1qrC7EzpEQ3WxWq33dVJ+SXukDS2
`pragma protect end_protected
// =============================================================================
/**
 * CHI Link Driver callback execution class defines the cb_exec methods supported
 * by the CHI Link component.
 */
virtual class svt_chi_rn_link_cb_exec_common;

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
GskSCfe1V4oltO59UBhZs57KSBzGKl/G7r2vgbqU7AnfCS2CIo+yGJ6MeEoSqqgv
RyeYdnAxcyv10Nco5i+JNXJxUwacD41scww7WUZ5PgDz5jgBVUzp8l+nmRm0rAKq
90Kx6HNrkjN4HL/KPd/VOvMO12UNyiZ538ib61EMhp8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13748     )
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
bm3uUa71038imbPAufyrztdFth4qHcIuXkAgMXq0HA9Qn+GrYNb+Z8dHHB0wclDo
bLpk3xnadGz9LFk0RrTmNtmRKcZ7INEBMGPJuo0NsQ9W37h0SddAlKsalCpeu1S2
0Ld9jNiF2exxmj/cw1BSp/VAFE5PppWQfDbyGAVuqLo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13974     )
Gx3O5yIVKwMpVNAVQIcDHBvqfqaI7QFjQYYDjXpZKvXORl96QP6uICEbeig9Ksk9
mTDQk6fFPW1J8p1NBgRjVH57hu9SUPfGGlm0JzjR6mU4SUtltZMHrTOV6UWRpb2n
uTQjogqa9M/Aj3EFwGWyxXtqaBQ57xoQIIAZtTPc7fJT8ErwidQ5S+wV1BPMjPEi
Hh/DhR5hEtQpmbT4L23cUjyEBvOjEy1tr57vv0N58OKpfnsqtkZdanY5O9Rg7kcZ
Bjw5Kb2H8p+1up2/3aT5zoclQfoJFvci4TLOJB1w8PGRivX0k9m2NaPW9K4NcFBm
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_LINK_CB_EXEC_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LoTwmQG0qlLixuW+aeEJWa5LdpFT9Jm4Lx6aJcOTlf2sFfCZ3w7YZUpPr6hSQQDk
xlcFYDJUltlpVHN9AA96kv+bLt7VCu588Elykbw+vCjDioCZ5ZfFfxwg1LIszK+I
UHCK0fpwz+9CVrOi1X5aLFfmDDK+NQDPlP3vexKksz0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14057     )
qbjlGV7K2MTFlLAmSRmx+nZLEAbZ01HT5Kb7CqHgpW3XJnOv2SdO+RvXesnJbcJx
kTq8c7KPDdU3GLAP/bv2rnxggdz117PXsKMESX0NwaNPEWsEcu3hnAS4iIlpm4Dk
`pragma protect end_protected
