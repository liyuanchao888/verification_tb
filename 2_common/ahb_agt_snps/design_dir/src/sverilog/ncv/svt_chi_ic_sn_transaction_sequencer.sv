//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_transaction_sequencer;
typedef class svt_chi_ic_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_sn_transaction responses
 */
class svt_chi_ic_sn_transaction_sequencer extends svt_sequencer#(svt_chi_ic_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

  /** @cond PRIVATE */

  /**
   * Response request port
   */
  `SVT_XVM(blocking_get_port)#(svt_chi_ic_sn_transaction) response_request_port;

  /** Currently running sequence */
  svt_chi_ic_sn_transaction_base_sequence m_running_seq;

  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_chi_ic_sn_transaction_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1AJfXmY2TrdGEVtwwd4b8biXbGQdn+Xu9CmMGrwH9Bp8LfZnTW7AAjOhBariQ8IQ
hjZscrcwH1bz6eCxzFL2OopoYOllVgHMwBbOKbIOY52qoMkx9xyG/ozfhLWSch4B
uyxJrG/R6xWNy07YaPYjm8U8N26+cwsLPjCu2g8la0eUzx2hTf/jdg==
//pragma protect end_key_block
//pragma protect digest_block
OcKjIkMRMe3XXQkDQaUmMGYetsQ=
//pragma protect end_digest_block
//pragma protect data_block
MHNX7SOfuRVkxkPmVdEZX2NmTs5BQn635SnE8GHTxBvOeNBFSyANefCxYii8gMFP
DqmLWnneUlS5DyaZKYrcbgzPjVBeFvGcgyHbmpQOwMT2tWN7HvcYIxxi7aFW7hu7
jorGZKJ9U76zoCmXStA4pNwJURf9mSlqHRpYhj0jiAHV9NG9EWwXd2ekU0x0qIcr
w0akOV2kogEsdGlsJxBv8mNGjf35jgHWhyDvZLxZ9q0aKYDbyBrUgNjN9rgvEubJ
HHo7VlWLkn3AZVvHrqXyOFwBDdU7i/hGpqSwLN83aMJ3q01s0Q0nbj6ICQlGBLtc
cMuP6UVkanbggQlpAHhsKvU63xtAfnRK+ozWks86/HvqIFihYxezO/12M/LuaxVs
D8TCS5xDOqm8W+iI4EMv4CC8cl1dPU+eLcZOK6pc11s/bxoj/CysrUgJexj4vquO
k8Y+HCrcpb22lfz/eTctgio9uLzPDWxlqWmmufGlWtRyoPDORM1ukQy48jXp8xe5
ZY3tzuoBeemplhAxwWY5lJ3/Dyr4GgSuP/2O5kEQ1aiUh4kzjQY8GK2/kiKY+qty
xbM3AWI/vw1gQWUZxr8xYGxSrABCii42+SpjdIp+3weLFGG7cTA+Tmw6G9JOV5N8
XHeS6l3IQ5v7vFjxzrNROeIvFufR+KLpnRWhwt5SAb3UnzIS9lbdVHY4bJMJpQ0U
mSqHSzcfuxW+AYavN2y02VdGrBqwu1fKwyNdXaHhujuvxUER6kqWD4/kpiPyC5FP

//pragma protect end_data_block
//pragma protect digest_block
EEHG/KlQ1U8yTI+4RsZGaD26+lE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
o4gIbMvaZy4zkC6YCVchQb6GGzZ4PHu0WNciZomPcvRFB1FEaRBoMeXReXWQNXWe
wZaJjC4gpXQtsJCwnJ83/PcoybBF9MAwoHMjtVbsoJ9RpERop4VWaqccp4gFYNh/
kVngnINjIDqq5+hYrPFjs0C4qAR/M6zmqJPcIjL9q8MussNMGIscjw==
//pragma protect end_key_block
//pragma protect digest_block
m43y5YmWjVzDv8X9Ih9JB9RuOvc=
//pragma protect end_digest_block
//pragma protect data_block
r+/h5wj9ZRKYhycid76fh9c3HjN/TwkBuLKlFV+W2hi99exOzFBqvRRX7X7uTjeB
jytKYfMSL/azsN28qlG9uE90pK2OmDmookcNUE9IttEZhDHXByYuC5VjofaitEz7
zWq/0T44n13nIH4I+aW/y8ZNW2yBZTmP4nGioOASnscOq1SBgNFhx4SfRTyRfkT9
CLCikhFRCWLbubWKk/+vQrJMUs9zTtX9Ci7aYHZ3XIrKXvYbA9u8fGDaPcCKN880
DPIgmaQTwat5ONA9HpwvjAaRecDwk1B0HIwDjYv7oujlgsfrbJ1Zp2K5c3W+8spa
fr3Vnj3ujlF1u8ub6vdd8UqhYD9v4cZGRFIG10epnJRa6GEaeymCAjKTM8ELOAiV
4vp/SvIotrvtwsL9IpSBpfxtbnRN2ykT4XGsJrM1xjPUunNSLB3FSj3l/HxRyHT+
1MHoyzpkkH5GDUSvhLqiL4fQdYG7koayOE0bA4VCfOW0mK6Xm1uSmFe7KF5iYZkm
Rsf03P7ltjfvZXwUnXFqvg6F1J91ICypw1jVfTCEaGLgZZMtFKdRDa/anA6kg5ur
c9jKx2GyDjNYbscH2kLaOmK5r25rRY6oOEkP9MZfqhtrSEMehCqDd4NrrctA7DZ4
lUKbkdpBRoRVHsL4HdFTLVx9I2UNoeGSuPwfPAAypHaLTuepjfkbp03lQQJSq+2t
5coEtfj2MkVwDtJDzof02hNGpc6OXYVD6LBHUqC2W5C4LFxJB7xcxFP350GXbf7i
wCedJBOsVGP4FqktPGk4Xh9gmKPvJbtZO7mnXhU72JEp9hN0b1shNXWBbfLF8zee
64iODDWcoZk7vfRVJeSWfOhcAQgV2rEyP6YceMXARbPPzZv760ilQp6IHzbcBo1X
mbpj4uPA9HBMjRYQenkWFUXSeYU0eKVlYyq7B6nu2Ag3uGilMvZwXCBzQBl7JmR9
6jsrTuHcnH7+1nuKUGYCWQKoEqvYf4eNi0mRDiKoFuoP12FKwq2L3yeiXcXrcUt0
x+XdAgfc4S2Trn7nDqom7IBUzQeb/rkVqiI2nXoAPpXi3MNZGZ8tGBR5+km9uNWG
SkvgjEOXmwVT7Ur5RdtuXjm73WKHu3uR65iMUY3mz/7y+VgDIeZdwfnqMzWGOlgo
VC+WLDPK+NCi2yzd4eg85F8eZxQHmKnSkTgzB6rZpAFtgOaYxSlXbPEqT2ebz27y
F4PDRpgRn1BTz8w9DZSMkBCVZPfjXzwlRyRX+pSJatiR8B25NflDUsSP3m9d6noW
/QJRM4Qvc+iZgub6b1cEkXGjbHPv0e/TvlbptnchWS7o6mtEHpnHYvOu/0ypWkb8
BRl2GRSpCNiuGuTbd8edDm76eDi/impa9/8EQC/5UbvsFACICHMUODYIxsT+M1x0
wltr4glGj7Gb2mDWxc9uXGsIjaPYoBcUPL/BeIC3bPF24FqqIUXs0RYikRwN6JeK
9EFbAjToE+yqeWprUH2ZRyi0sg1jsznx1w2nh0P6+Kj+WC8TQylBE8WlaGTlt6ZW
XxBFPvVSzRNI+cV2v5BQKUcKSpRPHHoe/Riqgr3lw3u121ONOqNMytcr1EXkfhac
3XYtoIMCy5G28799kjm1YBES4/r4Xn1DEVmjMCQrJec+CGmG/myyCc6kRtYOCbYg
meWZO3A3E2tv8kueK8RX8LMAk7N4hDTG3o0E/fc/R7rkz6Z+tJF7OEdIsMjNW/JR
1Yrt2wdmpZ49pFdjddoUKE5N6m+xMJL7ks44E5ft8F21BkQf2k/xfWnsvNAoB8aA
MK/YW1LoAt1q79hhnOR8UW0SNl9FaIJH7SH8KN/mbmCmj3a8MPLttTEh4+whthhH
km61NbXRwCj2J2bQ2KKNWRYHROoLyG2aBUIchdXEVMM0hx04AaEcRtdzrvXji7r+
1abPyzsCVUlP4w93DdNoGkf4ZrxbMBQyfMWL1t6G5eNpMgS4f+gWCg6uZFTLb8Tt
im9zZq+NT0Bk2H5mDfl7Vcee+NGzFhJnmd9sgxRBxPgLd4XXdVPW+ShcQG85MTCa
XG9ngOKaMinftjHNzdJlZdQ1v2xwAV03orpWw4myxYbNvSdNdAgkwPFlDVbBMOeO
2y7GhD0p0oF6UUqOgthxxbOeuZEBHStPHcd1pcOgnttqeIPZUGkXsmpv6dZI6z/2
frtb1ERjx+RELDvgVFiHp9YiB9aXLWNjmW8UnH5nH4ur7KHQs3xx2FqEiNQzsx7F
P1H/2WDahweHYeH8quIhASGsElud+iWy9r5+R/Xm1wj+1He6Hw6t9kkgpj70y+G3
If0p0U+wRRdrjs8kBZVfmsrEFoeSc55PAQYU5rD/ucGYATlXPt6l0dV6EVeHYEKY
1hgZz4Um7F3R1qJ/Xjv1CsotstG1uwsGGwNGfz2hm4y0ZjIPwxh8rheL9qZxmUsX
HnoQzf6GrmTij8skeYbN0mQviA1nn9IP/WoC6IVDj8Idg7xNZR1E4spXogDCTM8R
O7EMcSreg/+AuVfRjbzOaAIz4GHsQ7u7uH7Pumyxan96cXcM8n3lHMWSR22yIKWO
QZrzo8Nt7/4xGWQNgyTyYmx35omzahDwSVI3WntaeuoQWNdphwTQJxir5KJbn1zF
CopTU4nr0wA6dMCLBcaEWbuZzkNKQ99fxaYsOw2SkIj51MshbM2KQ1nfn+x1tD/h
r7K1PJPrja9CPuwLdS5TgYrjpGOQRYlTneYqm49juelpZ7JcJwDxklscqpR9Gv4c
8wMO40VAjPWYWocQ6cFVZH4LmZO4JGzXAekzqDWiNF9nmUsGONEc14NtfnpydX6/
PrOpD1o/5P8IpnFjX/Greg64I6iViXW90AVAR0sq5WaAGt14CNpgJOyFO+H1vH9K
/diIKKz8XDO2wdUH/z5S9y9d0tNP8dLDTQWnbzDUy+q4TGJJSuPEKgcI6veSabUl
M+GDpKEwGJRFlp66H9jn4sNzjwpvB6Ls+fLFSSQP+CkiG+TTH1GtuE9RetN7pqvg
qNTbjp93ssSsxmPwEnqYLMGCARa8wFzZmeZdPXTxm9ChhoN44Se51vq9xoFvZf0u

//pragma protect end_data_block
//pragma protect digest_block
FJ4eguu2+KQPCwGbnsfk6V8c62Q=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
