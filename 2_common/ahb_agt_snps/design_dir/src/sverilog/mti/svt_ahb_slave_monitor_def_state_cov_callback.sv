
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_DEF_STATE_COV_CALLBACK_SV

`include "svt_ahb_defines.svi"
`include `SVT_SOURCE_MAP_SUITE_SRC_SVI(amba_svt,R-2020.12,svt_ahb_common_monitor_def_cov_util)

/** State coverage is a signal level coverage. State coverage applies to signals
 * that are a minimum of two bits wide. In most cases, the states (also commonly
 * referred to as coverage bins) can be easily identified as all possible
 * combinations of the signal.  This Coverage Callback consists having
 * covergroup definition and declaration. This class' constructor gets the slave 
 * configuration class handle and creating covergroups based on respective 
 * signal_enable set from port configuartion class for optional protocol signals.
 */
class svt_ahb_slave_monitor_def_state_cov_callback#(type MONITOR_MP=virtual svt_ahb_slave_if.svt_ahb_monitor_modport) extends svt_ahb_slave_monitor_def_state_cov_data_callbacks; 

  /** Configuration object for this transactor. */
  svt_ahb_slave_configuration cfg;

  /** Virtual interface to use */
  MONITOR_MP ahb_monitor_mp;

  /**
    * State covergroups for AHB protocol signals
    */

   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hrdata, cfg.data_width, hrdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (haddr, cfg.addr_width, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hwdata, cfg.data_width, hwdata_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RESP_CG (hresp, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_BURST_CG (hburst, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_SIZE_CG (hsize, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_TRANS_CG (htrans, beat_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_PROT_CG (hprot, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hmaster, `SVT_AHB_HMASTER_PORT_WIDTH, xact_ended_event)
   `SVT_AHB_COMMON_MONITOR_DEF_COV_UTIL_RANGE_CG (hsplit, cfg.sys_cfg.num_masters, xact_ended_event)
   
  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
    * CONSTUCTOR: Create a new svt_ahb_slave_monitor_def_state_cov_callback instance.
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`elsif SVT_OVM_TECHNOLOGY
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp, string name = "svt_ahb_slave_monitor_def_state_cov_callback");
`else
  extern function new(svt_ahb_slave_configuration cfg, MONITOR_MP monitor_mp);
`endif
   
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aB6eb5NoV/S5I9dq7koYUJYtAIHmJ2hcLQn85XtvAPwXMKUMoyNiPWx6hG2LqXWH
SAVuUibnXkG9xEp27AJJVF30shzdeWbiHwP/Gox9MmqZCZb6Hmc/aZ4XiHTo0qpC
WJ3nMSQrlYtPacyuN6hTkDigFVZ/+SnNFqMqMhOMQqI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1667      )
jD5uXncosTNYxdSAUPy6TA+AOYKek9+X82oI+qUFsHDi/15v30c6bpd3imYZC4lI
jdR5aKfcCr/I8z6bwp0/5xz3fnJpnkHR1YjAERqpqRYQ9mf0HNviZTBMpwz8Rhv+
ns0YJ/+009b0RqeoRLqEzBJ0asGkZA3Dv+BWPAUl6N09IGTz6eqnH9lcR7QizKsw
n8VEfx1Fx2NL9M5XfDfrhPsKZo+jVjl+qzAi18IInNbwLue6AhhXYMqgudW6SDu9
hf/Dk5oYxwVVWQm0tdhPfAdZ+NZ2zgSXtQl06jKKp6V/TCcMI3Kg0KyKteW2n0Pb
R4qCrxW5GYn6RAZWQFNy4CYbqVeMnaQkqz2BRFa0MpMdHDlF2rlXJwf9ICzrrjYh
VGJGGLsl9sr6cyQwsWzgp7GTHuYtB9PfkBZAbOWbXcHaJ70Gfh+A2eL32VwsNs5J
Te0QhxayjcBuhrl+SlPcE28adQeBnaHo9RQNxD7OI1oTIuwwXwAdhKaFcDhL+2/k
7YplAEwhhwuUtPKIeLpLmT5mx+IsfBHPE94YpBWOFRTMHAudwHPcI6u1ej72gKg+
LEm2p8163Zw8bUcBiruNNUvXaUEQPbWb0WDZklW908gjw5E8mIW89Y9E9ksW4XX1
oUk+jcpTxUVlGs5ipmdw8PgYPh7G+xvNuxPOnanB7PLBNmnwDY5DaS1SYwQYIBvu
/x+qdGufffobaW9wc6vSRB3OI7Nrkjfu6XzMbw1nYknTfia9wkIX6DQbB/L7rGuA
NBkSV7rrFT16DOQJQoniXrSCkhKzp7tVKdDM0YW9blhDXxQCElj8bpsp4tlsaroi
SRPrY7XV/NDMNDCvmTT9QhBvQZpuKX/pI1WSd/1FUi/BamP1WvA6YTld+GpfNI6G
B2PX/j8dAFE7OaH0i6xzOCGa0FXXfbq4nfwTokNeUHPFEMaUnqMZjZWEreuvGVzK
1WYEd0zINPzPBkC5TI9cddcbm2ST+6u9JLUgmogfG3P1/XheN/Ae7VfpFsxXjqub
49f0MFaFx06B/2xqJL1JhjAN8i3yfKU01AwV+Ce/+tu0k/lCzKVRksiNodxA/mhx
lhLtoN3ZnwLog0gmUme0OywY7lbZqXoGcQtDiV3fhyBbRmHaWnP+ajKoyMVyuX7s
4ineQqxRM9Vimrs6s7xQMFgNFyB5g7Ki3/QJNnP92gPheszstu5Fg5Svoag8a7W/
eyrVLQCIGiOj3ddXRu4I9nMgZKRonI+9Anc+oQ8WT3jd9sJ+ZyWeJF/QbiUMONtY
n6A9u5+t5he1LC4T3IqZqhmWrPYyKO9L04H3H8JyYBmfRcXZI+k37oDX4uXZ3rE2
tQ0b2HvwUhKWrVGA23ljckLXDhqWWZOgLgwCtfmKjJBRmWZp89v7s+CdEuvJKsJn
TPX+e8KV28gmKNM/w8N5O+hYDeU5XS+SIZ1bUcC1cE4AICJBSufQ1SZmhuh+Itvc
xoVciE3d/re5srJCGr3y1K5BTlvgkJFPHNDa5UujlEUTE3GMXu7ZHLwBBzLPSAbw
38O61HcAm6ngO51Wzj16Fp4SO9gy787/2LKwdt9bodY8Y/3yBq/tWXWpMUurK0R7
aW8WqiYkyno/U9HrGaMvP9pGRmRqzT46IruGtyQrTnOBgQn6UZ4YlDjXnsu6cshJ
QjhO4XbcivhPhTzJpvFF7OlsY2DotmsAHBvlUY+Kgkr/UwLmh2UyywzTtWe+I/ua
XE6aqiCwbQw8mxXj+5lCd5Xv/xBB94RpFviQryrNu6IM7tUlwn36r8sv2TtP2re3
YaZheJrAPwBEtzxMkiwZcsjsvWlIY2kr52FoyO1n5NKCyO0s59z9qH1Hmf6niKTn
NOlvJNmEokn1VePKAc29i9qun0ZH6fDW4h6/6rLg2XQRxw/uLbwNAGvzykP5lGGV
vg6wEdjPO/naqgKDKAA4YlvRsKRTNFKy5NsP5NqD7oRv+sm6C8JxdOa7XberNfUC
2DVz12SYX6B4DK4e/e6Cd9lD+05qvrETU91ujLUNfENIQzg5j+U4NMeA907GgbLD
/ftsOdnjyWpe4DkwkwreahqtnCj5vubpZLe10+ILxR3SSXk3emxNx/ibwjXw+GCb
WloVb4AIKTdSGmCHBuJxNYkpzk4x+28CJ9kPkoxhTxWdTShQrnzIP5YN2abwErVr
ZLY076trdodhF1Cz14UnsbMev/QmVaChuxIm04/SDOn1EFmmejo4uJa5MWMsQZOd
`pragma protect end_protected

`endif

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gj49IV9dW+G7TrIaK96ZgN1EWJ5ZLXmsreAYHF0hhZUVJ1OLuYhOQnIeym1MhfOm
1VogNZp+zmKc2yGDLHLGqxPFM4vf7JUIaAu2PpL6HiU73ku53stqTb285gm1zuM1
NK+fKcRnO4MVhsGciUqDPWKqIjd1izwMhWZjz1LWlBs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1750      )
nI+UP+vL9FT0Nnr6EBBvukWgSWKhQxtDRv/nvBP2w5vBAEA4UcytIzN5W3ivXPmp
BfPy0QyH9hTkHQd3DXpq4YA7RXDTXtB2YRxMjaweITHPb+1mXh/CN/bx5Q20A6OB
`pragma protect end_protected
