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

`ifndef GUARD_SVT_CHI_SN_LINK_CB_EXEC_COMMON_SV
`define GUARD_SVT_CHI_SN_LINK_CB_EXEC_COMMON_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XW4cfSVzR9nF6k1K8ntlYyfd7iKuY6rRQql5Co+QDjcw+jJpzqHe9TjS0cY18exn
K1Mj3mUY/PGPprVJvPqkQXQTxhwvIjn5tUpufntDU+DIWnbe+O7qqhNYoHpMbV04
S8eagfXBRTsNQo0UiX3SDZHppJnGAwZfC5iSgkmCGBY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 823       )
71iQfvOi/8lNrAcVO7G0FuRsI1aWCb9bmCa+Nfe0dB/UsYghfv6zDV4GrO5iYqvM
cIn8wm/VPf5dK24dMj8dsYM1yH3BqFAwNhiCfceIuIgqhD+nAnJQndL6rw9do9zt
5Y07mv3L0pLh4wXnq2B4MgTp7prV5TX8fbX4g7MhhuJzLkOefKhSR40zeqTAh+IJ
HoVwGb5c/XwQPyvnCNSrUDzEde9sV+I9oF8WL+AxU//QB0W9xLQBsIGcrkZYJtHU
idWouXuVz5H+RNHa29sIAFKBIZEi635XhTxfi23whmfqYA4V69m64EUosQuw1HkT
aj61KHqnEgETv9r3ML3m3M9/boUQLFN7LyVzeACFSekGrYJDR2gHg28X0PXwRhlM
b4bW7aBX/MwEFtjGPyHayQCtAle7LZIUuflJouPnVhBwbhdOMCUbUTUn/cdzX51b
395008dk8gAgP9Lb0iLqytQuXjlskUSqYu1axAB1yEvxd/GuTIy6VZYVz6/ejWXY
CsspFwv626FWb5HI1aVgVw27ePV4X5cKWQUAtKEEqx+skBQY4fQNLMxA+6HSItnz
8qsYIuJXiVzaAYoS1wV54Ac/VOxXs3RoiJXt/GFXmxXOeZX81pECIVC308IFxIAv
Kw5ASzX1861tLWlkFqHUNQoRDI/+h4gTH2vBzPyRsq/0z/8MOJiVdiVIZeIHqKKB
sBcxZJACSQiBqQE98zYdr3KdVO77Fq4GJcmbu/Z/83/TKa5cXvPRE0SmB5IDUjhl
WhxDWVauesTxfYr9SdAedMK4Wt9U4/t4wgLcyBuJHrU27yNnJbUhlxNOJ6ZDPW+z
8sfC5WL8iikKaiM+IxuwUnZP+xlHFPWGNgWVHer0PrmR1/TNlvX/P6shK3+JuFCI
Uff6CIUkRz+JRbobZT4Z+GS36HTgtgbM1gwmoOhnzu28BzL+J127hUZvlNuwDxeN
LsibpmxFedIFtAIITjvg0A0P/NEXt2GNi6Sq4JCn5vjypo3lAFqPg3BU8s8vnrfm
uAlwj0usNYqw5a5XSdikormsR6OvmjPcPLYzs1YFO+gmg088/nznQKzyxJFtAjLT
9x1qWvl33Z2IMc3GB/pb/Q==
`pragma protect end_protected

// =============================================================================
/**
 * CHI Protocol Driver callback execution class defines the cb_exec methods supported
 * by the CHI Link component.
 */
virtual class svt_chi_sn_link_cb_exec_common;

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
gZaEoUnBBzheAPIPG/JoEnqIPLgonhU6jRllXECO4WXHK25OGjmp9/XUJj063vt+
1tViQlUrO36ZOZIobJpccN4LlW2r4p14qu4B3A0wPkvKh6A2vVlAu6Bc1q5UoI7e
pOgvedpeK+vhIg75DNWLS1pAjfqJOArEkndmNtbYbps=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8789      )
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
`pragma protect end_protected
endclass

/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ARk7uMdqsfFxiXueJEvdbyWKbQ+a22TOPozsb4z12nndt5aUPW2Yslf6snPMVEGM
RSl4PW/FVly9VMIG+yvOpkrMOEjVl9alZw0nRxmBwEwYL0eybctG/6iOlNxdH+8j
QZKc8gjLv8PKVkZYK+1HZE0tz9KSzjQS/DX5TkQeuU8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9129      )
TLapw6Gtc9uxxJIbzH9eO1EyuF+KmdTHtxruChI+TrZE3Xp4baBBiKEfIUrpz2hp
FdjK0qr/YQYbi4CNUSNa1tFqIOG9b+8MoFrHI+ik7UnH+0G7mGpJnF0T2weQCq/O
hCVzFxS08ofJx/6irWT3QgT/LkmFfiVIG/1z3K782lER+o7k576cwBe+HwZnelwe
1RptmIrVeV4KwOoaODPkLRlfa+J1UWOyUfad7/ip2+yXQahik93sslMr1aZ6tcy0
lPKCu5P89xluny0WvOzlZjYRkRhfyYoC9fMEW79TbhcChhg0d/LJ0yWa2VftjhHT
mkrXu09ZwAKutykEXNp9pudckJ+IMdjTVnG1Ibl8j52789Af30afDMC6UnvcQAFM
L1CI7BjthjwwHwo8jmzbvVFr3H5ynFxSjewJ6tVufGSOmZHfiVTuofZ9IrT8xpXL
9qgfEzfEgTl2LBfzW7kKkQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_LINK_CB_EXEC_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JuxOKeQc+1RYhUarYFxtZST/L89FVhL5QlmkZ+s4/SrQC8eScr9dEnAFZdvSgts2
ilAZXh9tjnSkKQnSPmsvx14oByLZ2f2w1NpCThRmwKUG39/uyFnNcbVugjBYyIJ/
MXAnkPF7+wtv54Q0kRrL7BmEFW7Tzv0eDsqJ/wEVQuw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9212      )
rPTImLv3qbZyM9i1Rdjki1JeMJjMlRxJGmeplIb8rXE2kx4DDNHuR82//f5SSWnm
quOrAIwC+Zrjc6bIFOwJrDuddV/iVZSFLrEf6jYrxfDDiteSBkB+/EXYbrgmFx5u
`pragma protect end_protected
