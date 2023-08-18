
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
// =============================================================================
/**
 * The svt_ahb_slave_monitor_system_checker_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_ahb_slave_monitor_system_checker_callback extends svt_ahb_slave_monitor_callback;

  svt_ahb_slave_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from slave to bus */
  svt_ahb_transaction_channel ahb_slave_transaction_fifo;
  /** Channel through which checker gets transactions initiated from slave to bus - Used by AMBA System Monitor */
  svt_ahb_transaction_channel amba_ahb_slave_transaction_fifo;
  `endif

  // -----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Bx61jQCeN5KECcvBo+yt/52dQbrNQqXM3x/wJJ7BSPVqJ+W0V2mWPFHAS7PWR5dH
ASJye0v+R30PkgzOpLg5D3AxQHsGi6HLEZL6D3MgYKgoSqPClDJsgeh1Tynr62pC
Xkmc7fFYvsIAr8caY2GNJAgbBDRzOnagLVD+gcgcZHY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 512       )
yaCSZBAPZSMsi4YMHJzJcOvi2Y3xWqZLA85bPxZgKC87XLRxfLvVtuX6E6DhA5Q9
It2iLjtgBwAd2odh+hbghZnaXL/4HjOp61wF1OHGNEktpign7iFsVGFlI/8+d0LI
2CzJEZOmaDTBm1AAAqMS1DUE7BgkyW/1oWxelSXKP520ZSgB/sdUdC1ByAW0AlTM
t0edFdykpffvC4Yo0bTRH5Z4Nr0eyL/sz65hRkZmZAEHfCXtRGgxVrqREQfRGu62
snAlSI10NhFXWJvkJk2pdqeZ9vwEqzktN60KULVXnQ1rCk5+aIQfKqwBF8AcDiwb
TDGnH8HVPBm8RW89rhuDJwSWCXGy5XEA11RYCvj5yKNjvFfAEPjYdJMYLEznl37y
8wUyy8M86SW88qhoImDCxMVGrfk/hZ4fd2LMciEFs16Bi4liUuHWVFL0/gNNUNWg
7tdPAYaSnDLaBSFS99UdYFuYa3V3OwDa7Cn5jtX86g7tI7Uf0J64z5L1jk+2I0W5
uC6ZCh7ANH1BQMyHuzv+msaPpvAt8FOf+RRTwLjx3UeCb1Bgz6Vq+TDXOjSougSi
AMUl+6EbrjLOJFgQ6hOeTNMzPoZc94KPMKr57UkawY6FZ+kIZUtG5TkYVrb15pDJ
uAdKMbG75v+xIWshE8GCGid6rwGcQfxVn+CRfGsM6nWEWDATi7TLEwZB1PiBG9lt
`pragma protect end_protected  

  // -----------------------------------------------------------------------------

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ExAkIXip45WpGp+E/3TqDshxgb+lvyBT4I7/REXbQAaqjLglpC+VX88ya6jPHIn7
YExaMPxsM6qFdgWeSx3hJ2zz3A99NzQ5rHPXzu0pj2IaRFrciHSBfTmu56Nh0pe6
VtuljU193vbmTFJWWOS5swb/kioHyCXT9PBSNDyHV/o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1640      )
2hjYMDOgqpZ1I1ybjzoVrSyZh0Wy0qH+T+BYiJ+T8GFUdM3eBdiFzFhL0L47c6Ek
908JZC1bOf9y5gG9Zo83hehKSalf+wPwInqXRXlj6yJECp97SrZNR98EEAS0jj4J
1yYa8zyFjpleIYfGszsRkqJQmekW1ICNn9eLXDB6xY1xNU7Nt9pWv7Wjyj2ouuAG
idGX0MrrnkGDxDmvUWumZLag1UcuH1p6TVXlVXJd5hmvRs4soRgHcuxte3NLtIPb
4Qrz43q9psZkj15ERs0I8h6A0cyGO3Z+JCGPN1cNz/CvnwfkoUnSJ/KCsC9N01bv
mq/EAK8HxR1OntDeEk3cLR3wtT++5RzXruyTBtU/OKce0Ph9KWW8/0OL4VOrEQ+h
O+kTQQP36CK/i3n7gMQ0fWEK1FxkpoIj9VYWJrjeItdQcg0rR64Lr8XDEM9xrHWq
7mFUqZFXf1GoZRd7Xvv50GsAVaMrJDAXAK7pVTPOT7APvXpY3RnGH/VjUBXeVwJB
q9UNdGjf2gnmqBKpjeK2651ygWZz83AaxIxPdE/epN6WsMcmXUFsibEFcbpWM6dW
KQ26CRd3/HphQrcAi6yNvQb4OP5RizdbkyL4M5+YyLjegmPyqEinlZupzVSjXnRW
JA4APjE+gMbh61te5m/wtR7SWR7DJT58fhC3nmWSTgMzADeCD0tnjGrytyc/Q643
ulisCCjfdq3GgjfEaul4bwEDmquFXrXZD8eHCwsv3yn3oLxIlmuIprfY+V/afSyW
Z6zZPUZkVr5bKXnyYS0rLDld1hQlt9dh+qnUk0qfkisZTufZi+xLkgVpM96ywTmU
bNUXvcdalb9Lu/sn+ac2DZkz5cN0T/rN3/13vyq4HJlPXsgZ2k5aE1UGhNz41aMk
7i678Z7WXwkUDiA34K4xTf7fICUk5nBm4RDFnS8qEULvu0PXM+LA5eAYd7PpQRBG
uH0v2/W1zHhZy1Dj4FYs5VeyRww9/WwZ7MaLnam3OpZ2NhCVdOrrCUGa/24dFDBd
PHw4dELL8Js7EoAul7SST/G9EULHdJZhJRXYvb8FHibpL7wm8jPWy65276vQdpzM
N5Xd20CNOXB84pK3ZXFwTo5jF4e8OGN+v9tOhtFFxWQxc4kV071bGJE8tn9B9g8F
yNsM6H2ERFAHHSxxJlpHoalJWdI02AW2OXmc/qwblo6ACwwWAez48NxRaBEOXP9K
8iMaff7TgTivUccbJZhmdBFcdnbgw0N0+JV60f1jKklTZE6kRtjFEzIMJC1E21CX
tpQAGd1Rrnsc2bQsGqTr7NntAHoyIPhI8rT7E/dWQaIDO6lOGbbtqNYoqATQTvOo
zA00sCUo0BMcXTZ/spqpcwEqYPmKYmecxR4EXSfR51uEjwF9JlrmF9LnlmpNT5Mj
6ACQ99y0abgdigwl21JaY1+OuaJKHYyWfGE+r376lwk+aPaxWSNkQOMD7mNDovL/
MkeRwEx3lhCGKP3bBk4Id/MvwVtFQk4+Fpu3GpdjXc0=
`pragma protect end_protected  


  // -----------------------------------------------------------------------------

endclass : svt_ahb_slave_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fhVgQ+kidcPVSGolHgA9SbhSh2HE2IX7KJRp76odcklAHZVSgaBg5VCMbWbp6U/c
sXe8q95eQX+zyW1L2t68FJA4N6pPt65wiFwx2yt4INbFnf+XbUEA/w1hAViW/Bn3
AAQsiBUvWGJnc2PhR32I6gdaMwl4fBmWTfxO79CaQtQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1723      )
9FqHVoH0EHW/GTk4+f82/8CtWOvBRPcNb0DWZA10Z8C5bqWn5FtWx02p0/2LFDaW
8bFmB4CtH2dCXHVseroK3NWcTJiyF9rRyn94uwv0M1paBtl9CN4in53xidSdwld6
`pragma protect end_protected
