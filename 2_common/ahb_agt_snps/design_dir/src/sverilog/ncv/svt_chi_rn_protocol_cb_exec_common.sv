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

`ifndef GUARD_SVT_CHI_RN_PROTOCOL_CB_EXEC_COMMON_SV
`define GUARD_SVT_CHI_RN_PROTOCOL_CB_EXEC_COMMON_SV

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Uqy9JY9m3LV+92r3i8stzb99Q09U/A4Xj0Prdmndo+wLzZf/7iBuwjNks/jsK/jP
XSqIPsG7MCxKCyYj+dRYnfn0WTFZz4KmsKhAzRToskf9Jl4QmsQlhQT1n6YE8iSu
TUMu3mSK5/AAHP5cPvEHAXhhummEv67vlETRFWSsknjNO8HA1Uqz3Q==
//pragma protect end_key_block
//pragma protect digest_block
NUIFr73Q3rHWYqzy86TRCQIROEI=
//pragma protect end_digest_block
//pragma protect data_block
hrR7ihCRbr1JaBHm/KTm4VROs3Cuv+8GYRZ2tOaZHidtr56VsjU0mMMWR4PQkrIG
bMGa8nVEsvY7LCpliEdqdEvVMN22pDO1iHHc3MroRXUREjtcMQ95DT1XSKWWiD0Y
OWKUgorxyJEkMBgMRdFJwhVQT6zEb3+/llNp2v8lBedj8z7Rhyn9KGZCPg5GtNzh
kEfxF/3Z0pbexwL3t6LunVwcEW9ypXy6fNJn3Y3UGtKGcKrNie5v+ZjB5MJvSN1f
G5kSu91cg7CUj8Jd27aXPxm1gfgQr5hyiPwSDqzJM0QE+dlllv8/wo3w8hQZl86z
aATGpDBrr1tnjqFv2oA3vZDzTUkRlQ+kF610wfLU4nI6Dejgx0aYNLdXtscmPibg
V45flnQSIAzKlCjoLoeTSxKl1q3TE26sA5jRd5rWgkbgLufsJ00h58z5+Rn5drfd
lINg4okNjaypxfRUxp/w+CYDXnsH1Mq4/GxTNdawcpDB7KydgF6DWxQQn/WO4A6r
OomtxT+dmepFgbX771rfo/RIzlE8jE7J4Xn8YyztrCfkr0y1eq09u4YA7SEsDe/w
BxzZijzG/wSrU/qua+8/yJDnyEG/V4yJ2LJJ+CWcocKRXs74ukiGqZHf+/W8PSKf
GbaIl1H4X0GPnWNRgrYe07WX2FgbLKzArDpD2cqmq7vFfNRPgbkHtC74jbOd9q6a
vzGAlase6rS/wbpeHZDkqzuR2UMUCmVoPHW6BtebcLhfLm/1VdbvmIWIbLwg9E2h
7ece1pUNOuXD9DhefNH+JyFLNdAiNzvzELuGKAPdtOVB46OcwsgAHNEedgSBg0mz
5KJH3ZboP6ga1Bm3RkRhMZ2MzAzpE++m9mqGDFBwevwzE1Rsg2FbXSisCeJny6Mk
ayxTZSsvKWqpWqpzk16aBXM1Q3gUCs3IwzNLk8lI5HBuXu/gGSuh76x3DO3kjriM
KINMp/Xs8EprFrhZJ4i6e1++TZweXmDBItbTj3C3+H3F8594v8J32GUA11euqATE
B04ZW62qUEc/gwGUboXTd0gmttc2O0YLtheSrgz5Kt4LbT/DK4QiGevSPd8sEWwT

//pragma protect end_data_block
//pragma protect digest_block
dycAvQ4eNzHiOFKbj//+2mH1fA4=
//pragma protect end_digest_block
//pragma protect end_protected
// =============================================================================
/**
 * CHI Protocol Driver callback execution class defines the cb_exec methods supported
 * by the TxRx component.
 */
virtual class svt_chi_rn_protocol_cb_exec_common;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   */
  extern function new();
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3GmvoS9nwv7BQkY+KBnYbOeB2Y46lLACqgFutNrQXQ6pmPl9Jb9FbqCAxGr9zZPv
bCgjxYcMCHGmx0+qXU+V/fVhHEoXyuFtSKxRNBccuhe6PzD68GXDmfLcAMdvreKT
H72wV1AViKB6cqY5JBEQWv/sP7YcTERMr3Yk9QEWTJleSiL3FZsBqQ==
//pragma protect end_key_block
//pragma protect digest_block
/HDGHyrvQv2dFZovK3eiYO/0kAg=
//pragma protect end_digest_block
//pragma protect data_block
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
9IXytGRN9KvmRnO5featTw==
//pragma protect end_data_block
//pragma protect digest_block
nLWZ0540+5eCurS7ZsxO08yrNwQ=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

/** @endcond */
// =============================================================================

//---------------------------------------------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
liBVf4MF0oC/zxKEKQ3ZJNq+4wmGwAKA49du59lRbcIFOKziO4KGGOIan2HV+moa
iNx3oegDd744Fs3ajzR3Uj90EC+BmzrsVtsqgP9Le+CBXoc0Fl+tKARAG6soSON7
47n3x5gX6758ixDt4JOs37w6wVPRsFNjANeedOdzr7mQFkBkpc+3yA==
//pragma protect end_key_block
//pragma protect digest_block
/ax/MQr3i8/gBR7H8bqBpkjU98s=
//pragma protect end_digest_block
//pragma protect data_block
17mB6YTeOhee9FLANTzRUKYug+zAvXPiltfC5bZSQCIv6oQyk4SFWIhWSnBZTBmL
MiryZCgmfPxiMU00e1y/cKGlFB/LI3jw8gbCN/5Ra4dUj0fECVA0Zo/LBFl/Gg0Y
qTxibt93XJfElWCZLzw++12Zhy77qo+0kdlqVu+rQ08QgsmxOMSJtk1+ATJ+1c1G
aEOjBYfsbZzXQsTHqG6VAzVLDUVxDoDsWCj5QMZbqGbe6lTF6aUacLKwukO1MJVU
sH1tZM26VICjrcNx3r2BeOrlqhpyZIICOFe6gQrxzGqc8NCQxsESfNAWHV/CyDL+
jo0dOMPiCP1I82YgNWXzLgQJlopwe/FxhkzAIB8x4ug1GxBfZwwzJ6TRShFq1ADv
J4FkPHtU7JD+T6h7jIilPqlp2uq6/gkRci1WAtdGDiKPehssDYN7Gl9F0pWUiPhr
fmT6WUrUwdNN67/QL3KrrrZXqDPVRQNPKFamN5Fja+90vqm/qwMAvEH/TQJ0qn2Q
f0DlcVrKhIIVgvc0VcITnw==
//pragma protect end_data_block
//pragma protect digest_block
hpYn0sIcfZ6pRu0uJ2a1f6BoJQk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_PROTOCOL_CB_EXEC_COMMON_SV
