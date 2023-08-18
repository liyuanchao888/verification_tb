
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZEwKCnEFbF6NQJGogIhP3hP40PqpRfqiNI4vUXQ8LIwMfd3nA5hKlXumAh/2UGGo
KDEjgvmIei3nlg4TXY2L6VSWlfjpQfLN5JSmxNLukRC2qwMusxdLRrdXFzdTZv32
kuNZdPtLaRgpBHY2drAG4b6jviJEoY8BpHr7eHIgz9k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1774      )
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
`pragma protect end_protected
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nAc5N1zRFoyVsi4KKJCoHFLv2nS1A1CT3Fygz/APnYylfaeVcrxEEdHBCG/Vb1zW
8HM/q6ezB2LSsXpmZ36Bljz5A4I3G2kvFl1GeNaMySQlq2mDrGOAk2lDfnZ6rYVQ
VxcOKvnf8Avd2YCIO41mpgPBzVcL/kBTr4wf10BovM4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2152      )
vqTMu9xWqdbHvvWcBt1xdSMuS0wN535dRRcm5wkFTqausH2KENHqm3ZpGAH+0qkB
ekANwlh/1zL/WOEb/rUpekBboTTA+T6TJaLK5tPNeN8Os+1QfSn5aIIqc2VwYKVO
yD1slrbO7T0Eq6zGhr6NFXzPM3gCftvPQVx911F1a07qLTuh9vY6UygE4tL2RGLo
gUs9ObAj35G9V3rH/xRrVUEwJlJzTFLFePQMX6n10r1pC06DE4JRERB5VWXFz3Y3
/NUgX/X9UzaT2tuf3xFSksSP0ViJax+Mjv95+JLNqhbTMrBSrbhTuw58lSaQN5Dq
VOwPoGYC/V0ikRQz7XH2JKW7K0sJsQio3HnmtdE63pZu35pbR3dOuZphGudcIpdw
9LKyCrBg6BQqlnsyfNIgVogFjzU5402NYUi0Kpl/lluCvBapWYyjFX5GCFhB0Srr
KysCGaADQnDz/NWRKb3PwDSJOk1fxfYeEg2QtZ4hlCpFE/M5hMmsPYqZEcjAZ59B
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_CALLBACK_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IHsTI1jvhObVTFbsgBlSUU4mUsEFnVBb1Au8CZOItmTwKB1bQsbs2kiW9qoAbULO
EmWknIfrda9npAMVTd6dpUlCVm4DnDZ489rRHJEcv6CNJFlL6ugX/WKJ7Yhq2dPY
U/RthdkTq/brFcoU8/6CxGC76S8vy5BhSAwNKua9+xw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2235      )
9b+NF+T0LEW5gJZtjL4UsC62N/QKTpgxD7jeQCrRpqpWinhUZJgIz5jtKnWYlb5I
qASpXMiqur6eAgd/rsSgQ8GQfVIHxYkKNV/LMbgNHFy6P091CnkvC1ocdYthOJqH
`pragma protect end_protected
