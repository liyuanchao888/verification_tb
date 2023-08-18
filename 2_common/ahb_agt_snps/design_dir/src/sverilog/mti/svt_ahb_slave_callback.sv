
`ifndef GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV
`define GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV

/**
  *  Slave callback class contains the callback methods called by the slave component.
  */
`ifdef SVT_VMM_TECHNOLOGY
class svt_ahb_slave_callback extends svt_xactor_callbacks;
`else
class svt_ahb_slave_callback extends svt_callback;
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_ahb_slave_callback");
`endif

  //----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KPEKe6Ev8FHicAlz2x37uvmEMoxmufK+lSTQFDU++PeDeES/r60uvi7+X5Ob8PiN
CNMBKcxCkLi2TbDDzigeCnNTAQ9NGyphyVXfP7XCQRTPGnyBpybFmVH8c1QSPSqD
wRM9l5XcbWmNaQ/1u98PvCerjh5rmgAlFRtkf6hAGbk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1762      )
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
`pragma protect end_protected
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GgPeO4r6x2Ul4EalklHxVJWl5U/k2qzsg4l94mSPI43uGtsgpCgVtusVGaPc/QQJ
gSD6e1lRhHxbAgV9bSYFbXPx4Xagj5S8cQlWgSoN/eANPOc6UC6Rg6hzcleYsA5O
V9xkxJ/bdb0t20qp3PfB56tVrEG/KvuhRbc1Rvrxv4I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2137      )
J0L/9U1ko42XXXstk5WhdJNtFDc8IbztkDU5uaWFHDgSp53qUXgwk6efvnf9clx6
uVTP5QHyQqlcbLRmTBGoF8Xx511rrhSFmWDdLt3jLeZyWL4mwD+6YlRR1JDWUO0O
WhbjIxjrm1V7Qun4e7G5fM6N7wZPd4YoARpa5vThCOWVJV1fj7PCEO93OL63WCLn
M1wab4rCzG0UEQKn0BKrWZwEG92ku3BvglwIGSNyUnBAPZba4Qb4DaUIFKrgoJFQ
PzH69pv6nUWTLcbwUbGZGIhtD6TqZsikMJIzMLDbNtWUJSoMWkfSc/sLH4ahulFq
e+lhljRRPbnUH/zVhpjPNhvXJIddbhRUP/7Jb24qn0ga9X/usiH1nYKOB+N0I47t
28x0oVsQ3XZrQlQiDt+We40JBMjg0NTCjZjV9NS7zdTB7sEIjjswT+JFQOc8ha9Q
PG1xIURbTHtBbLDIZ4Rdph7lS7AYo+hjQXzXp4n4DccC2ftNeMFq3InCvio9H8MR
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_CALLBACK_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Qukyor8GuWrXjGYMtJB33wmobHwiEwsiPtYxInOokZVSJX8tHe8207S6XCjlJxno
Cyqdi3VnrBqqUiizy6FZk1gxZGVkTsK3G++45mFwJLR5fZt1AFKUS+hRDfRrNMu+
FDTH04cPgl5axhrwOj6lJuo2X6gj+bGSKmN1kQd5DLM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2220      )
pmUIadvy5EeEtS6f/ao0yCo4F+4h7z4Jel+spmL4IqxZLr0Qb7kVmCesOoshBdc3
ppSRWagBkNccmXSBZJB+PtDQlzqsG1zq0vsgOT/g72yQmhoqeuPUy5U+2kh3wyUK
`pragma protect end_protected
