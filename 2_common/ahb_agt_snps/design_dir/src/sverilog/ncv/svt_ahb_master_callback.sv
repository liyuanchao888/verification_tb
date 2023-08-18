
`ifndef GUARD_SVT_AHB_MASTER_CALLBACK_UVM_SV
`define GUARD_SVT_AHB_MASTER_CALLBACK_UVM_SV

/**
  *  Master callback class contains the callback methods called by the master component.
  */
`ifdef SVT_VMM_TECHNOLOGY
class svt_ahb_master_callback extends svt_xactor_callbacks;
`else
class svt_ahb_master_callback extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_ahb_master_callback");
`endif

  //----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZokJ+rX7SXxXsXCUfF3+MFI8TiWW8IY+Cnxl0snO/mw4prmN5PvpAGuRMjI5DwjX
p2wmISlNNVJSyELEmNcEclIBUQdlABX4iguJMaAmpV6uVol6hmcWOts/K2x2/D8z
+KnhlO5mygmGqNDnzZ90dHfY6ilx53qyVvDyydvmjiKSYFYXQWhNAQ==
//pragma protect end_key_block
//pragma protect digest_block
JiqinoFiuIa/h2R9OEjkZo12XuY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
7GODGDC7CuPSE/ubC/+3lGdGJqI=
//pragma protect end_digest_block
//pragma protect end_protected
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7WL2aeDRRA+N9icWnHGEI/oFIDSzFYNFwXcoreBcgzoQSGY27l8FI/+zsrBo1Zix
Ze3dtfGGVN3VKW6pQsT2DrKAk+1RttZ+p2yHo7YVQroWT67pjoxhsvjYrHYdnhnq
ZvHybNhTj0uBWMayXsa3owu4NAqBtkcLwsoE9rWfAanKXihyYGD2vA==
//pragma protect end_key_block
//pragma protect digest_block
XJFrsqEIKJlW/ibRUzGxryf9gsY=
//pragma protect end_digest_block
//pragma protect data_block
RT5fstU/MU6L+uCTVH3QdttKgVWWGE+0w4ftz79chPklDqgX2MHquFMAqoBZ68Cl
rVbZ8IJBPo/k8iNJ40btGtdZgS8u/mKXOFWBojW656XfXVO4uUBO1+Osrqj8oEh3
sDqhpQKYYRKx4hWHmtTYvv3CpzA3JCkWeAqM9ASS3gNs2Nn6cqPBAt6NyhC/+YfP
Do9Q/+CzmpiS2AuIDFEQMwtlsLxVtu1rWwot/kAjD/SQpeyCl2D8XYrXE8wpLmCK
dSg5jMSo2o/qn/bg2SaXKB+vtn5Blx2WkJKPLqRbJRnl6La/AdLh362oXPdUttLK
N/fyXSQ5etfRNYOHymqc+kfFF0clo61LwqUI5AvGaHyf0mkWG6RESvDazUVJA5uU
IrAev8TBLdmW8gZmR3h7oQ3zQ2YrZ9a9qNRhCesoqvMHajLOmKEsSsO6RAm5SYnp
QtpN4jdC1WSUMX/bKKiVvuoWmsAuEeudMqNwXHI8QusTRBKITJamCzqfPxVXqH1c
0g9YyxCZydFpMeL43WBLbrGeiPbbI+f6Fn9MlC03UIv4wpSzaJNtT6FFG7vcFjO2
RozTssvD6KgZBxKNBUEAj+sFAXRBx/V5na3QppY3BiYdcGOjOOBlJUISbXEe/7Kc
LfDHIdXc0TMZv93Z03gUIyKeWp1m0wwEH/CZEsQV6nxR3DnYRig9FdFkpLMp6vHC
SYhMqzQ/u30T7dEFM6PsRg==
//pragma protect end_data_block
//pragma protect digest_block
PqtXiYKl50alWyqiH0DhoQgx3BQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_CALLBACK_UVM_SV
