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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8ltTsGxyocpUHrZgOZtBU9U3Q/4WGNTI7Ryan+zsq4zE9csG4zVPWqdVgfhVWrX1
fSE3N9IAPhYbhBEhGhIK2PxolJR+X8yj8wewU9hxUcMYyeyaLrbXEynSuQRkEVrR
kwNnUBiIRbcBAeAfXahDDADyiCo2RCUg8C/+nTnaqbvTNPnoTV7BAw==
//pragma protect end_key_block
//pragma protect digest_block
1wfQ3tRJnltYNDUeISa4NZUg464=
//pragma protect end_digest_block
//pragma protect data_block
s1y2R2DrUZiDKQ95q5+TCiUnqPjdZdFxm4c0Fl72dZhY6aCvevnMEdE6fujONTik
oFplikFJfcP77Q22HSLeF17IXBlra135zcVtLUjlk3i5m9GqXW04Hk05k5wwAaog
PnhQLJAxPNlw5QfIaEfh0dGpx3ny2v9YRQWPzRxBy4mzOl4az6fOxFSBB8rQd9wv
V5qi6nwEFlTTfhz4bPQdzcT53RzIcmkndVKZjTRtB4qGsFaPvN1umckayAwUdn5h
WvFV7/UjHQ0J3rHgo9O4O2cfMTbA5rdYJ9ksgFHZ5sr0vCaUAsLvJIecVo7K4iMJ
1Av9pYcluRDeBxlUmQZvlfpELNsfy1uA8S+4Ohx6rLqIspOvweWiqW6XLsKFqhe/
L6aBXqaWbF9CavkMS96VlBaGfa4Xtgu5pqy5H06JEGSSC9EKfoo1j4yV7RPL12To
qtt/8a9xfh44diNA6Wz/uF7xlc/jQ9TJe1bAVbxnQKlLTjIX6afREkQSax37aIlS
UEfz39DQysdlNjhK7AD52ju/OGYrl3NKLNQ9C6H3+su5ZRfotk412UY7GuaQ5rH9
RrmukIBnpWHlaRyX3BxwD9/8PK3AKnbw1a+6RuF09xYN4MV6tou8cB33DSe6rvTk
448wufQf9TpD2iFpaAJKAoAp+k2CtIa4kEAkOw14MSLhFgtA3yQCTRNZzmoAoHlo
Zbvu9B37aOUbuWF5mZnR8iU3OjADpaZo/GuGYANWrjmHRQTbiaXzuaO4S3GvLyR1
PEWD+I71OUtOkF8e3VSkmFv27wZ2Y+C+Qno05TsPOxlj/EOnb9JoASAj6dwMxen2
YQtidE3K9WHQsJfyU607bdn8r7B02XG5KxViYKtBo11H+sYuprfcm8ACBggfKWQV
Ry+LVtykx8kA3iW+WSM121L9d4s2Qpbjwfol4FpFz27ot4tNEwLjw1anzvIV/caH
M8sYG98El6jaz8PT1Hbajvu2hOs5OLF5id9bb7gUlaS4z3s8w63R+XexZwS93NRb
tnBRdMOACuy5I7FQpvBfC4wceEnc4OoaxgrDGoEXxAegl4GeB1AS9fDaPfieTj16
rHBJeGvtXTYM11YclDOrSjSbnIM9iNVdEfTZ1cq9PYA=
//pragma protect end_data_block
//pragma protect digest_block
3drq4XCHENNq6y7KQVggqwPyVno=
//pragma protect end_digest_block
//pragma protect end_protected


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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
LUJZvhPMXbtMavBeI34qNQTnVxbPTM/2bONprog68fDjSN4XZyIR2YrEut53+E/o
4YOyymvgBLsa7gr5aJzTZonSd+uxbzVnezfBIXip5+emN7CVAQ0KEoci4NPrEk1L
lgi1QtcrdxYH1Ia8JJR4QGBO4NroAw9MKRJRK6o/4nY8W6JaR6al8A==
//pragma protect end_key_block
//pragma protect digest_block
0Ww9JkQCVmkQdqseGhPgSfWhYp8=
//pragma protect end_digest_block
//pragma protect data_block
bi7faYXqxnsDUCgdh5+QoP016HqjHNdOzfonLsKoOU+bWyTL0RLJ148L8thKU9go
x2qAHEJ3MaE3johBZ53Hd2i36lj/PnO+sLZgiCWjbXfqua+ktHZhkjt2QGyoUImP
0MNmb1NT9K+gj2jFq3VooxrIWzY2CwDxthPhxy63MiuYhzmUV1hKgiJgKdWKpEJT
s5ibaQzzzHvELos9jVGiU8+FA+Nqx93M0MpoczvSBeWUcrFXtbVZOlH7nnMimG4W
sYNV7m+ejCxJOtsJvpsBFh2N7mGaGTCuF27hSO/URqGMhpnRMa7rR+r4qNlSy84a
qWzPRTGwvm5C+BLLMu8cwluX9Wkph7ExJwJexMAkUdlbptKLfbzChBulzGuVen8V
b3gUngJzX5R+aM9ZKoBqF2jou6mi95oyvAVKA0KqUneX/4rqOGdFJn5othb8EY7w
fg634LF8qmfs8izsuPAwiyWZidH87O22tcu6NiYSlSEIdLm6FDysQDO+EtkQXiPU
E946PUIQHQku3XJ7+MpwXIswCzB+3UZRlA34p4/TYlMcKXCJD3mVyJaZxteObMr5
LNT3fQnbdV8OwNM1nNsosTDDD39VMU/Bj2XV8M04HWf3ITKNDhFvKNM8/co7hWzy
FhmLsULpgC8sq4WbMqvVYP4XZWBgSZVWsm6Wt6rrZBNk0Cdu7pNNOQp1oi6EFEt2
OeRDVqE566pMbcKr/Uo38RpR/o9zX8CSE9fDw8YzdMbbUhLXrLxyKdbXygxaXOk2
LHahr2s68k0mxZwT+dGphA==
//pragma protect end_data_block
//pragma protect digest_block
wgsT9m8jG7PbAxrqk1Tf1lw3IJQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eNCpcnO8ovTpiN0qP78zKzbN0+mfLcdu3HvBYVEEjUihr02eh4IqrmMXSCRNXy3p
Li+RmJZZ8BSzNqQCbjJDoMb9JYmBpWxq1dUhO6ng9pj8nNWULCpnDWxDku19hnVd
f//iKfCpsGKS0HQYKejNrATicFVK47CVWzC7Obl7p3giTmO2NK7Ckw==
//pragma protect end_key_block
//pragma protect digest_block
/2xUhL7RrVhiMAHJz48HyWtMeyo=
//pragma protect end_digest_block
//pragma protect data_block
FVCJRp3h+a0GSThJr6YhB0U5n7mtKORqcKWVKNarJN4hZrZH7M5mzFY2KWmZF8Jd
d6bsSPAzT45LeYjv8oc0+Pl8Xy/i2/JEwvFoQ3Hjrrx0w1+JtL9Q7NJLlAXUIbQU
RbuH5d8MHWMR/Bgirb0+tGndEVwZFsXAhmAhLPJbjGI5xjfLqmDgGE21ogYUoB/E
0PXIW9MmPx4NQyFGqBmNqqcorZWd0upEvuyNWtBfY9Tr/xLOJTXNAiBf2Mo3AtWD
FiX2ngJI638PZeRUa1tKBVekPdMZXTq9JJZPaL+5CZSU7ACQ/VP8IKmeHxshPw4M
bCzGo+FPUKRwt5f//QRhxKM365cS8UjZUPGaYKShJiSDm3fo+EavQEngnCNk6LSE
J+rjIqyUlwjZiZiX2ojmicSZuJ11XP11x7Q1ytLASAaXymn4TkIDDXz17m8FWaEn
UltRLlFU/+C9YcFprx9YW/BUwYqOcQozGkQQCXUmodIBYs2VweFMYqZRAivDlxpQ
XzE7ZbbimCqWuiY+bJJjRJnmbFftZgcjEc8VeYucnAsvh6/9h8k7iEpnXoG2Nq6v
Kvrgg+k0rk9Ec//80eFzZQmVvgUnqTWs39vjCEoTDBbHE8B3hwD0Bl3BFaHlk8fu
MCGNTchcuFx18vo/9a1fRaPg/MJqkqKjfIhama98tA4MNItEuN2y4rHWy3ND8UIB
qjWbkVgl0/Pk7WnA4A2R0agVieutxy9phPNRSnVrG4CXUb159kg2bqbOEPdBhhZ7
YV54PvEs0+E5RaPBipeuDHHlDkq+4o/cqU2064UChEKdWGUuTlRbSHaIdSedglYu
j9x8fxjtZ5GffRgzPFRfv6Sq7Il6WkFFqFarsDEnqfXaGpQBNrFJnZGpb1qfm6cD
wKZJ+GX+okhSu8uFFo17ztQnDWUxuPbGuSA+z7vUXNR4WbA0yzobgGPz8iVaCNjD
g1eMhpfkHOSu7tTBQQe27r9rewXDxy8h+Q9hyLzOPmbHTxGY6khS4RZuOzQ0IhvY
bONwLqeHxETQ+33YPtFg+uGS2oab4tkWLobvpCde3udroBWQ2XeI6J2ojYBDef0M
6lAzNMh0txP6yunp2Ctaghh6HgYDUITCCQtmI8QeWLD+7XqXp9EihiNgVnkOp2uZ
9A0D1mNdIwd6xSCalAGzaQ==
//pragma protect end_data_block
//pragma protect digest_block
z5pO2x4tJCNjC70Njm5FvAOgeR0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_CHI_IC_RN_TRANSACTION_SV
