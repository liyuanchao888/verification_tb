`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV


// =============================================================================
/**
 * The svt_ahb_master_monitor_system_checker_callback class is extended from the
 * #svt_ahb_master_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */
class svt_ahb_master_monitor_system_checker_callback extends svt_ahb_master_monitor_callback;

  svt_ahb_master_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_master_transaction are put */ 
  tlm_fifo#(svt_ahb_master_transaction) ahb_master_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_master_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_master_transaction) amba_ahb_master_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from master to IC */
  svt_ahb_master_transaction_channel ahb_master_transaction_fifo;
  /** Channel through which checker gets transactions initiated from master to IC - Used by AMBA System Monitor */
  svt_ahb_master_transaction_channel amba_ahb_master_transaction_fifo;
  `endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iVp/y4VyY124LGWQWGyPrsaR8MjTJJliA2GklrFPWwDLU/HjlbLmpPNZfBcyNUbo
oxWkmHuXr27G2dbuOnBjtjGovcNuZe0Vd0lsUeEwJyB5lQJKwiK9RbOhCNJmW1ld
bRl3Mao+jyl0Fh8Z9Jzm/uDkDnyuSedSUiZHp/I5i58=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 597       )
shm4VoaNq93e3KtdiaPxDE+rnYFXiiKe3Itn+honQOV3/ItCGHpVkx/msCI2WlvP
ZRQ9kCjIJxUSNNJEHeGw/pXQQUtreRo38TXl/X3JUfKVisR0Yyuw8fCFTK4K/yQd
OgDBUS7RpktIPFNUoeat+PjsizWaEwFjTW3/8yG12YtxVCmwSDVWo9bipj/7V8kr
Jzf4SZ96S29Ium1NjcgDwGDPO8AXDjoVbOt0yZdWKyA2QX2iAWeKKoZ7YFbSDW6p
rEZ/alX3WD95ToSeBnWQEPBmtvRq/rDsghLSHkQ/VjTbHJ8fePsTEwJ45Ja1ITMC
9RjIYK8PPK6UXojLvf7AE/jA4Gm5kOmTZC8rgMOKu2+4SFTnBFhRqdXU41/8plQp
Ypjo7X27v34a0jGsdOIDDHDagG+tmJbjuYnLMy35+PnA9RbUuzLDSe4Jj1V8KfpG
F+raJtVgcAU+1mI/PfljoCKOUl02p+N8feg1Q8t0+abUVSjwcxVt6J0ySMdFqx/Y
U6mBJbG7GHncHd9DGaExmnnWvELM9Z47T8LNOH2KnKHeLp9K9JvSqVF4VxMKOSDX
jhMu3lPI4uSXOVVr8/AgqTUslX2zpHMTKehk4EbNUVSQ+JfMSeRYexQP/5WAVXjo
p9yRzqy9Mq0fw3HcJ8roYA2eHsjyfWI6YWGQyPk5ZSmAfenjnbe5Vo/TnVSRBX2+
iC4jE8rb8eJrrzjM9VcbgX25UVwwWoUaNbwIvMwcCVXvCjv8o8BkGqcuxN5LCL2O
tBeEMIgQI+765DhRjqF4XXUa4hiEW8Osr6bcSmY1mOw=
`pragma protect end_protected  

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OMd11fsO1Rpf9kGW+WB73VXsaumY0RT86UxbFfBr9iqjj3zeShavR82qREytSO/X
l7g/GK29NVDeGk/lehe3h8LFfP1GIKWyDp8frS0jIcTvy/Df2D0Efesb5nHJ8+uu
T0GpJvHzjb7vcORD7qUNh7QkOg89v+/BqacQMauS2e4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2278      )
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
D4pMF9yARrySuRdw/tHq+w==
`pragma protect end_protected
endclass : svt_ahb_master_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_MASTER_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WwZljN4PJGqoESJ0Sj5jRlKGLPWzkdguaqTRTz5RwXlsHtmwsVOjKMnjsy36us+b
DRgaVY6PICpo4JCgdluzYS1w8y+M6zxHpO5F5wP3S/88/tfAKSVFyH4m6EuATteO
NUsTwk+BQPPBm/LaH2w2jJflXQRX3V3/tanj30FxcjU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2361      )
B4J/hANevl05Dra/Wmq3AjoibPloHaqNqR+uzTZcnBqZhENYSSRdyMy6p+AZTjde
h5UDiI2rzS3VdNHnz9dVyS4Rri/bn/MeJV3C8askW9NlQvpR1/GC1rqY53wF6Tyd
`pragma protect end_protected
