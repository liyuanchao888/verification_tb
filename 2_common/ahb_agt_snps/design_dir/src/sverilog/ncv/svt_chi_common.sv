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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2HO15zW5jcRdxapBRxJCBx9McjPNP3C/KEGJDhmib7Q7UR+f3bSs9YGqWJ6vD/Hu
z7vTX7llDTgFSArqrJT4sVTNMwjHEt24InciQ31EqUMBI3+dSWIlrLn/3PWCGNih
KyIvQctwxAsDPYrvvGMKTYEfZ0XyyXjuiSoTem8uRkBqbF3xEqU1Bw==
//pragma protect end_key_block
//pragma protect digest_block
Fp6qXU5n4+N46BPASURmCt0OhGM=
//pragma protect end_digest_block
//pragma protect data_block
sqErIvwXvTovJvzyx/C/Y6MeXTU7Am6LUoHRQzW7UkPJqZeVN0frscresNsCbJ++
GYOqh3uAdVYgh2HCUv+mcVPa3m0PBp4V+oXssnpvzgxyIa4zOEXSxzfgP/gtfFbd
tQVapAzDFOwPObMbvrROtGx8cd4VRkGePgSZPw30Q3s2Jg+dIavxDNZ5DJA22zpn
sBiP3gkZLRNGhckZaLzzEfbyxGKGFN3YYlduYJCJ5abf268zQrGKI/MQxx86+QNy
CFVDTiqltwowTs02Xngn+zO4UkVn84UxaNQvdYQyg2zws9+TAaJfBn0KLwFgtUBk
3A/t/kf9Js0EDRLRjuE4lO6avBr11Yr230LMhsC+ylPe5pv46tD0ifExXcVU9COf
abxfYbmrCdZG6cnygHG4/8J3uj60Ssitr8Qf1kvEUrc=
//pragma protect end_data_block
//pragma protect digest_block
MFlMdemEfQ7adpMcKLGPKTn2xiY=
//pragma protect end_digest_block
//pragma protect end_protected
  
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qTuZJE5PWuoCa2qvZ0U3/o2PGBxqhlesUnCq8y9/LF2/19shm9hkeyXE0AN2zD0D
hcbvn2T9zCuxuGpfcb77bKv+vSkSdKQI9vRhnPxCLLm3/CKyJGbvDyBsmnFgFE+A
E/HmYItVQ+huCwKMjsUqKgIejexAMjkEy0OG3wPD91r4rh8OhLctKw==
//pragma protect end_key_block
//pragma protect digest_block
1s6RgPtxzsFWq+Uu96hrtqdl/Wc=
//pragma protect end_digest_block
//pragma protect data_block
vPtoFHJcxkRts1Jyqz67N6OJ+OCENNhmjg6iZj0vVLt4WK9D2S15g6GwY9Y4YZDM
4yiFx1mMQ1hN7rjFx3HPu/FwEeEXFyEjkI0vPHNhBPkkLd1TQ0Jap5nrz3aenLHb
DgaFBwewmS3J+dT+Gs2S6VadmgngsJR+NBMPAUpo7JSekZ0+CD1MpOeRN2CC7bA7
RSErmKjeZnrwyVSUrGCXIz88a+HEmd9f0OULMyeHJ7bH/OZ26sPOvu02qerOPOAe
1W0XM6XF8tMesHLg7aBsPHmKz7dbXw38uQa02yLbs/D8BcPNPFdrvVV7vgUvv41n
i+gBLwA41gTDLuYd17AhFi45ixcbFfCce03R5uGhOSX8TWQBPC+cMTUcq07aSV8p
+6uWH4PnmIzdlK2uswnIxYu4/VW9dq+JqVJJUua8QqyzcZsj3kXc7vS0ZXDq+GcQ
0hZZz1uhYUramS3qKf2+Pjo38tj6z1QzEvS6eG+F4zlj41v12UbWOPpzjDtH1cQk
9ZJ/dVyIPmNEY4/BsZGP/qzt5cCYG2/VJ5mVX6pE2/mdwxrfAXlYPdQze7DocNjG
X0yqj4sHs9voMzwpXkyx+d/QevKGV9OK0uV6j1GyMdWmCkxwDw3mGQ9iC2EM9ZY7
jr6o8HzCoCffih9wjVFyFPoLlNWrThHqT/tTHnHpHFAsgW3hGWFtz14AeK2s09TM
9lSsmKAS6PAQXrPu+LZKQfe98bHLioJuk8qrZ1oNlkLvNDtug08894bOzz2/ixzv
0bot1tGZSospvZwYWUMj43J3H37GtQA14odYzIAILaxOswOY/9JkWn6GZepkQXX+
ShgiJ0YdSMa1Co/xu2jm3hdmwk/UbRby2iFOWbi3RySmXqFFWZSzynXjG9jCCc+G
EyqHQggeh1z2RveosMb54safLyAnQ6WrtNXbguQPm92Ihv+AajASRBQJukMEHwix
2BH2YCEc/DJqsNhFWzmODbA/5aL55v3N6dKHWWstxNsreK/AtJxVqPG88fqyyg63
6sukEaG80Q9MGTeSni4ZLw==
//pragma protect end_data_block
//pragma protect digest_block
k+1zMuUvbmdWR1+Q3bufB1VXOSM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ulqEMBKbdhE+7RlKJZHM9SqEuqE5IZ1oQLGEczTvirf8Gg100Ia3LUJswGlySiVQ
2sO6R/9Zvqr3AIKPzLzDgar0APRtdljhxDt71Zq1JGz7OCFHgRzviJ4RUph6xjDs
Aj3rziEY55JU9w3X8TFJHF/AQ1sOEkz6u9XnJ4bGPnhyhGg+wVizqw==
//pragma protect end_key_block
//pragma protect digest_block
QlmegikMygOBCEzVujInzF2stpo=
//pragma protect end_digest_block
//pragma protect data_block
h0tei2Ji9TBQDt70XnjVXpMhJPJ5FSBLbDe+goNkXvgfTyesUNxFqfgwhzGWMIXN
Mg2395UlmBjAxFiQVltFcA7TDiGl1IQ/ttWt+p8QWT6pNNG14czH+qBYrMGwkhXk
ohJ7vh9qz6jinCJU6DChLe9G2NAosEy7wSvagfYTLZBVIC1Pea50EUTBcMB+XbtG
KW5Hl65WUD6xoYNrGkUgaRvsG8JEWLQ8GGF6iVTjdTVeRsgIhLfzBj5FsOzJSKud
DMpucleg6PeZF25hGURWnPbHhwg1zwdAdQZEBoYUk0fvElLBinHnnFqqhTDRWl4L
0NDUTgtfG3vqaOOVE5HduWwJOFeZnub7gVYmo/uRp6w+LQVodG30tYP+WvQin9FS
UzUUQUyzabm7EDGXE8JizKZ3jiPy6LMGmEtYBCVjTige7zX2PocMG5/ewR+KTOQR
9ZoJGxKNWOS6szrXYQVvXAEIJ4A7MIob8Fk71Ch3Bgt2VosfvTt6V2KpxzYxGR93
BghFrgcWH3NSsNhkUMUFmSRv62yTLt33XhlvOlyY5T51rD3IQN9ukDioizBNeVPi
2d5op876iwPRs/eFPybX6UrVplnMr6vx5hE1JgiVD4E6ijg5ZA7fvvXxtHZ8IGdx
Zdaq0qZCv3h2VzjDN1XTKD2QkUs8AkrHjY+not63+GNRLw66ARQjCTPLeV3+QS0X
b2iAcYfQ/izIKqCmkAtGXJ8xF7Rh3NBRN9LGYQgSj0TQDPFCwXlGMpVZnTYFoVZn
zQ8STEVxe4sN+iaPDo7AQqgGbgcJm7BB3zhyRw/gY8gIbYyuX7hYjG9uIvY2Y+Z4
3+gOLbzOC1zLit5puU0cM+fpEWqzEi/fVA+DKij/WJ24+RGOqvQeYkK2hz8gEMSe
xNoFqLvbvFePWIZwICiEf+4IBCcQwTHpPbp1xVblNG5X5LwIrxzqaqmcRYzEWU8Y
UDExdJ8x7YkNH3+9VdChvFLUxOvd3bVUPUlv1f/yqtqxP975Hik4FIhxvMww+bPf
z/9rDEiLuOC3DR/ptkQauA==
//pragma protect end_data_block
//pragma protect digest_block
QRvtcO+kIT+JBwJY2hnSdWpyFJw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_SV
