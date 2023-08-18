
`ifndef GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


/**
    The master reg transaction class extends from the APB master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_apb_master_reg_transaction extends svt_apb_master_transaction;  

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_apb_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_apb_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ejBbiRQxy3HLbhEIwGsbr/tVil/ugy/LY94V3LCtowuikT0RJv4j2Wdjg5WQK7JX
rfqDRQugFhfxQD2RA8as1EBS1eT5EONh7f4e/0yVXMLTzZM/ssAcndK5V8xs/zHw
OrsDXHmmVm7vztwxX8woPaC0RReUjBO55+/Qjim/5eDu+B5/0lWzcA==
//pragma protect end_key_block
//pragma protect digest_block
gnYgK0CuHk84hwqyuitwKCRpKbE=
//pragma protect end_digest_block
//pragma protect data_block
Qir5e1xqEvgM+kr95vxNtVksxlXNXRhjbVzhvZ5ofBUIjuEq+ggIBODEdQQW4zbr
wDob5m3qD2LEHBunSFrK2I5HcXgHvA9FkBgTE1oqNzaYM2Bb1abtFVpJ6L6TVoyY
9sNEWyPInOX0qzg5kgiC4j8YEf5b09fKQLL9bIBHe7eccpy1BoxNLQQQm/tsAwiM
P8vlLvC+1MmvWdUhk/v1rLSw3Phk63QQB8Ccl+WcCd/TzN8Z87Ikr5el6Z4Ep7XE
2gPQNgpRZc+47AlMzKgKb24S0zKBoKLHtaqqaGeGS5xPZHbZEqcDCX7ugHdB0L29
r5S89ecqxGppE6Bk0iM6kESu0E3ikrQVImXWwnJ2pCnMnIawtoKBxh6IkHMgchLj
lfvIgjB2yV0QBwogICW3FjNcE7GPlavsMthSHPWMtNAkc+OQAXultmZ7/xxQ5BGc
8u2lAHNmW5IyTo25ooZuKFxC6Z6Fg8dHSbR963wxT0mPhJ57pOWSOaAYXqxVqAVk
WS1+V3pG7R4e9AyXNCW8q9wXZrjdtqZZizamHjwJQkwMCe/pEl/FffVXpMJVxWVx
DgYjyAphzgfJlUSi/prpy6K3PW/nw1K8yskySDCMtyNBODAKetBAD39uwHBd/3ET
9fAObG0Sy2BII7ifn/KpZs55v3Ody9HnL3Dh8GPBoMSCAqXw/K0gMdOngBqzpZxC
sRbUWWDkuv+cPoBKX3bPj2L2uGbwt5VE72DdntrHolXBsXwyfQng+TvGDazlm55q
m+lFGFb6FuWYe+oVvJuq2Y5BpJ6NB/9+t2C2ff2ogQWJSpoT7A+m5KvMl9LvqBYN
AK/rd+4XgDPDiO79uZ2SaqRjYbV4eiioF4HaPi/YC/hl/lj50aOsHOjMF5pwqFsP
3w5V8aMo/rCon1JuBvG1BUBw4eNFqzPWaFAtqgE5Bhojce/N2n4z9OXTZx9ybCvO
wn1W/uGdTa3Ln2zpOvnWHxba6EyQXa0S4XVMD9NNTFBOe6emcofC5Vc8UJpV1ejt
7IOOyctKBr9O1/j3lfSYwwYDFS7tH2TOkHj7+AM3zaA=
//pragma protect end_data_block
//pragma protect digest_block
NplDuwfphACReMoQohx5OnYcUss=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
W1z3qtspvO2RY7t7IqgIVz0O/+vYuc6wIIol4UwnQQKCTnJ77Evy5E6DPk4CJ6ih
gIl1Zr+fJ6s7ssu3PwoFx6USTfmtTUZZP4R7mrGkhGb76DgNKlvmK+3WQGbaEXNo
3vud+8qb0Z09jcShRTTGyxvA17SmUPciZx8ax5O/hFQkFJieZU8o7w==
//pragma protect end_key_block
//pragma protect digest_block
Fbgkp67soF1KGrtVmuiHk7ES5mE=
//pragma protect end_digest_block
//pragma protect data_block
5A5tZOje/NPzxhJeUxKBUIBJBcPijBDH42jTyGF5OYBlu7x9ct9NIQkMfnCwU4x3
AB7emQ7xP3bZcYnyFy4n94J3++zOmeLJ2x+TBuchco/q7qfvqS+/zVXIHc+p/uFZ
fKm5U9X41fb+9D32rdETIc0JzrwE4KUM0mJuDlgbVFU+B6ZFBu+d5TnjDgGKK1eo
5KoGvNCprPmObRlSWqfribMlYQzu7x1OhBCzDQYRGNV3xOzW+fWiW28EbYbZ72iR
bnXGLgGNPkl6NpKGMXLeDbExyX6xOhxheFtDaWwlsDrFPSA+mJYrE6nwwjpfC6+7
j1n+WcGN6aypqjiZGlC0qPnS/4E1bRTlfQwhknUaYUHd0v3doMgOxPD4mMd3Ys9B
jD0SNiiXrZKcuOY7BjdH9SjKP6u3mCHn040PtzJ77bWQOj7HRi4B3suIo0QwARfC
uoSiu4mSK0ntLTpRluz3ew==
//pragma protect end_data_block
//pragma protect digest_block
aZcNrW4hycLBlCPss4xeWcGdUds=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hve1XvAsUseKeC52Q2vrmZUEPqfznqsOZ+w+0O4Va5K+rY/yCs9zMnvGe4I5tL3W
pt5xjsa7UpJ13bYldmgvAOowlkYIAnmdTLmNGeG/3BL7hrIvQHT4CMvCWGnCXE5u
xYnzpdFk7SnPrgB56eNsV4mLakpd3sO1IC3Pb+lXerk88NaXHMcsbQ==
//pragma protect end_key_block
//pragma protect digest_block
F/rvs1tCAZxkWNQ497aKKtzfrXY=
//pragma protect end_digest_block
//pragma protect data_block
KMb3afJPWuFiTwdV3UiUaqXPSrwup2EdzEexrAK3G6sQy9GTVofAkRhnIXZs1A5P
BRpglMWEeUxx7jvj0OiEokfBr9JhFHVw1ATya1NHTrYMPYAy7muZyC5igCzvKUOR
47m9f6P5mP7JajS3j2gtUfzRN49cY/dUMImS0K6iAM618+MqTToA0svEc+BKMnL8
ur9IVQLJZcIUUNHrgG+/Y0p2mapGiR3j0uK3VV2F0ebLkVNue6seykISYxkEEGMK
Jl2zlSbpSAaIjxQfziRm732UWm6BF9/ibid/CvsZI4O4tOWVoqs94W9krnK3Zsg6
GWw8sn225G/DD3/VWltySIF9/mbK8Z6BhCVJumrFCUI=
//pragma protect end_data_block
//pragma protect digest_block
xC2ckK6iS1S82zbN4C7vgabY6I8=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_master_reg_transaction");

`else
  `svt_vmm_data_new(svt_apb_master_reg_transaction)
    extern function new (vmm_log log = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_apb_master_reg_transaction)
  `svt_data_member_end(svt_apb_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_apb_master_reg_transaction)      
`endif   
endclass



//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eG7IJnZlW63DdoyozYChl88HoNGQLSVBwwlr//OJ/PVB/o/51CKlp4tlvjLv2KyY
LFH1rEs2lOw/XUuagnNYxAxs9BqlPNCPySSMW4HlThvE8ojQQeJCEhfe/dZGzwwN
n3psKllKwvgYfo2GJ89ntIAvgHMhNHuOaZKCkN2vkbSNCH3pNPJwUw==
//pragma protect end_key_block
//pragma protect digest_block
1limpcN0CiuLsXRURtd5j6vQFY0=
//pragma protect end_digest_block
//pragma protect data_block
2pNt4AXr+yI1E+FzQYz7F2vDx5bwvApRHQP0uBW99BXqkmas44txJo8gWu5Yn+ln
1IjhvRN9+4g/WoI7sO4kJdQf0V0L7COA7n42hNqfB9m22VJkgAQUO1+6MQ0bKrTw
PwXd/IMKv0RYR2115XHJsA2B0xJwLOdE40dSc9CLl/V6vKHmApsxfexAJ1gvPTfh
pUtx1AqxVZJsJsYlbww06BgY9IrQcqsllpdeOrXHfesqUOaFDCD1aRIrkISOmZAv
uppbOUiA/pun6ANQtwf7EAmQ/4MEozsK74X783hw88In/CdmrfRQvERORjb7v7Ol
+Yl0i4/yKrLhI9v44UzBEHuQc1EdTDqfwsT36NxtbJRimajAxdjrMsyLRgI6ef2b
wN7rgY9PJFMbDGv3ic4NHm2uhxCBJDKBiQBL5Y5GDOSITzAhqdpIPVroGrZIWFkd
nA86+fiR2Cay9ZFR5yc6jdjkrHYdV7wYeAVK2Gl/2oMjEJyKaPiCXqbx4jzJKMxj
+btBpviESW3o/b1nrxBu20yvYK1+enkKbwfGagNNNcQfPijZdkck9iVWhUeQEQCn
5L0KCaHZ1NRoF2nXF3E2hWomvdh0QOEqppivgpJ1PadW5APyjLRheKG1mxIaNpd/
ZeAPyCtk7hhraFeeARRUNY7b+fvo4fQ/cZN5KYgXoSz3aoNymhbjbe6vedaaUpml
KlJ4OCDPeIXMToKkD8d2uBgb4HyKRHWuV7qea+Ldl8op6AcqbGbd5tf2k6O+xPiq
TV4uA/FQpIjeCeE+iMj4UFWf+1fhg+QFpy/4HslnvLGS9XKE+aPrKO7pU1jzzV4K
FEGIbej0LQgy5IscMuHX9/VQo5lPodNiD9yvYRACN2ZsacyAwAhv2FuW3tVZzfvV
FZPeC16NHyiV/59FYig853ZBWsG1g6qMR48Fncn6o0Sg6ihKqCEifH5vayfi6PLB
C4b+ZhYZq6VTKw/bFY2UfZKRCZJ2gRr0Fd6mjgh0vUUjQtcwV6y2lOtxjGToI6VC
kvUTxmbCi7qAwJCJlZ4DXJzdn5oSNhRI1IY716Vq6EUxW4T6qQSUBxgslWcgql1y
7f6Ze1BAY6SDcdYnYYxhkomNIGZAVij3OIvcCXJ4UYBeej+Gl/SsDqwxa3Ue8oLG

//pragma protect end_data_block
//pragma protect digest_block
Ccin6n/ZtvnKMMFCl8g/Nm0MV3s=
//pragma protect end_digest_block
//pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_APB_MASTER_REG_TRANSACTION_SV


