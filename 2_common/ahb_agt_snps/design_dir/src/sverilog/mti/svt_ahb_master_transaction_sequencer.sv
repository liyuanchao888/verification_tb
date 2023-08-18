
`ifndef GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV
`define GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_ahb_master_transaction_sequencer;
typedef class svt_ahb_master_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_ahb_master_transaction_sequencer,svt_ahb_master_transaction_sequencer_callback) svt_ahb_master_transaction_sequencer_callback_pool;


/**
  * Master sequencer callback class contains the callback methods called by
  * the master sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an AHB transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to AHB
  * transaction(s).
  */

class svt_ahb_master_transaction_sequencer_callback extends svt_uvm_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_ahb_master_transaction_sequencer_callback");

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hRmDXhzvPTE4fUtfnvon5cSNev/MgvafD6VSJh7rnD2BWMG3xyf0QB+AKnR+hdwU
hNWzUVYzpvrehsoP/Pv1AozlTuDZggh8ngjyd8pHckFYpgdoeZd9BkEwHrdVKyVf
3kWia1z1ioBqQz/OExt3obac5SyRGLpDswFNMPZBSRM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1193      )
e+AhqdmcPUvhHtOtUIfME/zuunha8ObBuMqvgUnbcp0JK6aV6WxTfH90KO3MwXNg
KPRZ0ZhaAl70T/qYHA+tULxsg1j/OetB5S+lwFYkFuW8s+WkpkXhiwXBpE1HTJnC
234ZOCB8DxanJnKxCi/85pUqTPIapQUNa0kh4x0GgJMAosxADEyFEoFa0/ZR0bse
iX1uHIArWK/TON0RLWE7yBuprAGdCy5B3L4XZKnwxctaUq2hHQZ6v3kZRG1caeLR
vTILk4BB9bWm5lj0yJdgRoSdoc4vI9/VfFvw4zT1jztOzWWRFOW+GFwZcEZm1Qvk
LemlyQa8UekhsDy4Tx4m2tf7Yvur8wptusGnrv+oKhA/8TR2iM0por/4jjbxGqVo
s9Xd7gzRV+YprIBqHHSckbrdgBYl32u0/2bvyRxUHidPBC2xYcK+yrG1CskSNTHz
qlRFW65mSxY0rDBVRz8lDs5fDwaO07gEQgowIcjYaLdQRluJ999PmyvUOtJhRsUZ
JdV/b2eR3q9bTSZeYgYanI8SU2wTKi2LVkQiVcJnUtwmXU3xFi8VyGMuozR1qYGh
aaEh5Q2XdsiJr6aU54UMu2erEavdQBJHtgXK4gBb0NIacPabWAYNEJA9AGb2o9Y2
dhxGaELl1XkZG6Wkrh2G12VFefFBI+mFfSMOua+kf8aOYsTq9jPscOn7HqCUeEG7
fyDZXIeAIbwJhcNFYTS2OupXOxfz6Jpo1m/LBQ8Uo7VHR5k0z5NhB58yeqPboc2g
iTVEVqA3SdYT2O+upzSrc2yi4WRGaNpvWh8ogdnzCHS8FKcFpCPAlRuw4hpKQTYD
kZJHRSYGsLxdfiQvAmaeKzkzn5FdWErSczuIFi3FsmB5IyhRwdRQmihf7w9HMp7c
6OjJgmUcEptnHJy2He+shoZCIoVpxIWB+jylh0iM/kniyXgrAEvHbcxfjJRpfyie
1Ywi4aZJbDOSNJT4+8vSW4lmbVQULTpBcUnuK4oxxm0thM/g/uXxSACE2RHd9+Yo
tBtbzhbBe4F6ovSSCy7HbR2nYsEnZUZSHlfSNfqtQTVbEPAOzTmKXBvuxRNDPl+M
tyqa3sZw+BTs0HisiaLgbEw4Xyj0mS7148AaVgUlgaJYUBau3mrO9uj/69g40jmX
8y8l/Wg1YSHfpieo074I9CSc6dDZBK2tCNNtjSP3I/soW/lJlehldxzElTNxcUmF
EXLSjBkUEQGIG2/ufOftQSVrAEt4N2sftUF652Dp0jV2Jdi9/Pa7BUDXvq9lnNHk
A2zc/liHICvyAK0wSSWxsvemI/NrAp8WDxfwzsT9MIhPLKuAmnlYHtdHfZWb9hWY
3yK6O3uDBsY5JUHxaGIGPLld3E24NxZhpHfm56EHFrCIu4pUhzKhaGMN8X4g5Xuy
ZD+dvAkvsAOyJd0024TVRDp6766kyfU05g4JMNGev8Tm+WIx6GxFjZZolPJQRjwM
Z1jLqtQREvJDmsNWZKPDVo75rIX4jfeXGfeILRozgMz0z51Qw8SdlE5cqxkB1ZG8
vaIsUxsceeUof3yHkF3TplB/OWfLYJ25IqhBvaI+0tTnVkx0pzu0cyS6Nz243gmE
`pragma protect end_protected  

endclass

`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_driver class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_master_transaction_sequencer extends svt_sequencer#(svt_ahb_master_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_master_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE)
  `ovm_component_utils_end
`endif

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
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name = "svt_ahb_master_transaction_sequencer", uvm_component parent = null);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name = "svt_ahb_master_transaction_sequencer", ovm_component parent = null);
`endif

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

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   */
  extern  virtual  task put(input svt_ahb_master_transaction t);

endclass: svt_ahb_master_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Hoimv55UmfPEl5/W3rV4yk2rE8z0yA3ak+1JYpQu7OoU4/P/9pIJxjzUoH8VOvdR
FXbdEYKJ1As+bogaSDdlFFqFoJtsxzHFji057DV5LM2QWr2gTf3emW9rk8whq+3H
ZxtCgd/UCBdhSFaN3IqUmCASaYIHHddk2kJwhQkeRUQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2269      )
b30iJn90QLvgF3CcLXoIDcesKSG12ycW+tQ7o80F+m2EILKUjrtQu2yhZmjA7gZJ
4ucU80uAOxga2v1683VUrjInpi1upCzWEqMQZsyEpT3WoPaMK/PD4ZCJdCBQeq6g
wWhowdjUfgnfdmGX7gQdfJwfwWFwXJBnZsw6BtdMxLaaHoa0MLprFqMY6vnlrqf5
PY8rpumveGTf8YGUpbkeL12sdHGicXI6ZAzKvE0ZxxoIW/0EVbbBxZFPrxwBgFxK
9AvFklfgcJoN9XyU4CYQhI15CRmSY52t9GSPzwK0pUwLcwr8J5PtPSlc+4/ZYI38
udTB0dmvA3h3dmfW3edP6Ven9VGu9m/aUmn5reTCzwqzUaEbZp62GOPx1NhPItGi
8uoLJO1v5WmZkVKX1SNPuzjlDRqjK71k6MEx0NAU7T+CtrLmx+SKXu7EXfwCiekc
W85lwKomuhElQvtIHM7Xgk/qZ9WLpvld7FB0YeBQ+nTjg0WH+JWozpRKRpMKVS4v
T+JvWJU6C5DXNt5ONnqLVEFWeasShrJGAqCNTEL2Ummhx4RF0ouj2i8ukFVuG3d0
kEWI9750VIS0Ww5WghISz3JHAjnxE+bOUb4mqNrSjqh+yPDl9K7XRcE7GCxU6zkP
CuZVvz5fTqfLTxd48+Djm2Zn1dAB02rkkOh0wAuRNgWXC2OMN29ksLUOhtOLeI8H
QPVhrLfUkCScgE+NZyx64+UH4hgTsgh0YtZ19uqChKGLR1HBYlOOUEMxVZzt0Xo4
pIAI+Rs0QdNe1bvntiYA8UdetiQbCukmaAqB+w1xaeS/U8Y0uqsTbYvEVYX+Tq2l
ujvwLwUaiTsW2DloYxlpBQ4QbzKghPExtbQs2/ahBmg933MzXKmCHhbTPMUHIVzg
tXVrOvc/SJoG2kUA38WvG9Hh72hzXeGvsz5I7zxNGs+Q+Pw30cGbRA1ZIcgLQnxD
7amdBlist8RdMKFYY78lavhVUb62cY20WDAGsEEcZwloUhOmQgOAFKxon7Vi8Dgt
6xG8A7NW2m5kvdFSSF+160vlj+8Qfm+DfQIML2Nw8OOaD/L4yB9cQMzLThVAG4VZ
jHUcJawEfa8EXSN09VnBJDboX/w7aql1XG2vGQ0Y79fuEiwa/B6xrQ/wI8ut1pqe
mXLGO+85+N3TIlQDNWtO9h2oCWRGERZTVA3bYl+iWzFoOG8kiq3dEp4FQxq97s1V
NzDmCjNRmP06QA/iRCHG25HCACEiit9o0oNldpRH77Nbe5rwWJzBHh8vbCze2lM/
qDoVKEDqGngGosnfTXyBwS2cGcjAW4uDtVTJER4WiEJUE8XiEnbryi9ifsfaTtWx
C38/clkKreKie/eCqr6E74owAkwh2xwayS0kMiHLl/WQuCVQOLWEslL1TafJIm3D
k0mGUAwVImFgnIkJqGIb9rlRI/p0zuTzySt4b4vlrgE=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LqYAw1gp9Rw2fB8TiTjuoRtSRDMA1nC+AlIX3HDC7gCd8eve/C09HJ+pQ0kGvnO1
BJnRqWDFtWQ2jOsL3nXBgAhVKdHjpvow31qf7D4TtXnjbJHtjtpIqXZ3t3IcYARu
myvZnohfi64AltuTsijNlN+CNLGVf6nqk3o5ceYbwWY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4610      )
6dExThSIKTgSljfhtyDPfkdH2+yzY2zVNIE9Vk5tToMaORI6JuLjDYSUQKglpCSY
/gmFKThZP3liN/vE2R1s3aT2q84/qAPZC47LFLp/SngXOxFvDA/GIMC2MzUgc/iP
Oyi8nnC16bz0ZFgFsDoATyaD3/grWPEdqSWU20nnLOuYepkRly/xebN/ckDkjDSu
+boqaBhjlbl9LsyT/fZheIv7CSCiAv5TiOljA8c0W0DI1VXb7xVlAuMvFMx9p9nf
SItmU589UtLPYPNsXgBEbE9GzVbjiBFWVnzu5g2mJ6hxzYXLu8FjGn4Dus/w5QNJ
2F/bRsBjinocRN/2DAgxBVvDel/oSXF6NqhBEjwygsBFp+BirxsNiUHY/nqeiejs
IQFqFdsm+onSAyUdkWkeHoQzvX04ZyT3Gb/pnHzWEq6HtlorK7DLM4HQKosCw4Qa
JMhgE3+lEZkVaGdAiCgOtWdwELAZG58kql1apPpfPTZeFK2lQlUwmImCW8KjolHT
OtxA5hnGbFo9F6AW7cDSMBboXG6KCL7fmUfOpO4z4l/J3S8Ogb2Kg8vzr2svTNjF
D8VPOkNbE/+qfShOkbprJDQ3sTWJ5Uifow2+k/C2Nzn6tAnk4/nVh0tuUH7SywVZ
6xk4JdIR8VLhXao71nBa9Ff05IbEswzvb5CK76m14r+jovp+qmsnyg5ipRWgtLH8
aeVWt6gDkMDx6jNF022ppiY5bf9ewsvnJvFmnl7YmnEn1mttYoCdMAq+8T+MAL9W
rEYmN0KoAILzO2QGWP6UexqOFvDESmr8zRqw3JjwNKbxDQWB2Tt+aG5ETVPEoYuo
NvbiT9K1xhj9A+Tg6I81aTwoUpQGFpI4z09dBUAp9wRgrgojYEhJglNokdezQ3QR
9FchDLFjj/2P/qzfPejgMup0icDcQtEs0obbEe2G9I/bfllwV+J+ygzHo7i1GCPX
jK98Ibjoplf8zgKY7C9tInjNNiIW/3XQP2pQnoF6kqtjEcitsxOrZo1GRufcQGSM
2ttn9R7cQfzu+a/4SDBf2MC446ywGZpO3ffz/ypN73hnxm0u2BuMQNeIi81pMaTP
5g5L394wpZS9Hxo5cQbblpz6AWUSHqM5nCPd1VGE5wZnycsBHeu2EdiKVNMivZYn
rIZ4tIFZ5VZqaMHnk/u8clWqa3/NtqgA0dXqTF1TB1Sq1cZ2Ge22ml2r4g/2WwWv
NdQuG758VPPeWyLKZrc6aH6Pr5AFtBlX8+GiNdhdET5vgG6Sild5TAwj+QggRBTI
BSL9Pi5VsvT4qHR2QwjlPmqUugrnohGFXWnmpCWHmx9ItJSzmAI9KSSkBSUK4D47
v9W3iJyjGoG761AKxIqPpiHcDmdzUIpIo+8SSSoC4IPdS56CW9TpGM1TNZiGcqQ+
XEeOSjh9ICY6Qs+6suo8HfBQsBBSY3CnpveO3EtO3jKvvAHCx1cmnIDnWshUNjLh
qj7kUTVGBVB9ljvow35bEL4g317HB1pQbtcpd9lRTgYIrKw3nEBa6RG3+RweTcHx
neHYDwbDbJi+MwOE1YW2XKiaB1E7zuLXkVC/leZ6d/jNFMuwPElE5B3o/BLwuHOH
vQ7I5sE0jzu29zIOYChuIFHizGMfLeI+Lhzq7cQlWvfxkes7zTiYibN3/uPcClOW
ZV/hwC0UTahyK9wJrs5aWqvoxvwFgLnI6Ml3kFC7llYCXKpOkd2zyufsT/I6oNyS
JMEEP/u37K8zFqwFmyc9Tc9ZQfGCfP0AGeT9I8FkxW+iYDtU0/Gis3TCe6N/zH5U
47ImnlP0UShy82Q4YoblAe+37i+vMagWv2xu4XIVYiWfCoc6aEEoT7k0hTJXtKcB
bTwVt8R1aIrl9vpU2uxBQ6hykjlvlF7pIk3ru31HIPSMM0QOyxGli+C0Qm77hg1H
auClEA9TPJfPPIu3gyiATgRei4brNmIUmc5gEPk7Pqgh+zgPQAlNlMxLFQDZJLZx
xJQuhpaaC1u6R40UBdAuryv0N+mLi7pgiDZNKt4N/AMXkde7MG+V+p+LHgGeC6eV
TTZEUa71cd4Eaa3ou5mxvYC5c0YxbhQFctI8ctWllPO/594KIUra/L/S5ijM72gL
W3ZqMceqmDTDKu63aNgzIr+mCfhxy32J0GBGMb+uMG2qCdko0Y7F+l0uTxFjeDIE
ARCgKoOa8qcdKSs6TKmVyZaHs8Xpk0+A4cJ2nogwtdDdWxoExpc5VZ+3QlIBekkG
BFyhNI4ftG7M5jPXvmeK+9MlSPWu2C5XZ06adXSNd6MWrfOUM3LFrHRAEhPat2a5
4K+1vTk9lxpXNTt0lhl0dwtTO04rModoZjhGdiYi7pTH/SpNU+3uaFw2hdtIquXK
kl3rYwufCF80XejPq0TxMKfDipQvupifXRcoHXklkkJ/z7W7usOEuPAfoCmrkz82
UwSfEFKB+YrAcyNWpAjPbbWrV/21vE8WZIXjK3HZZWXkvgB6d0fS3pkKxPLAIuRY
Ad2CbB1HOoYedW9grmDayE6vlw/nlLxw1+ycbHS6pyuTbAKwjCckQopzz7Np3SxW
3kvYcanYWkcKnxJCMw5sop70FLZMRtkk91o/nGphOK/4gwJsSNFYRKuA0ecoxAuf
GKrEAFRPkdWs9NLEe1X8xbIAoNbxTwvezIlPbGF3NfUsMP33Xg7zuSqwbpNf3jDb
k0NxaSns68hOBQJQYhQz98szDEEZ7Q/resIDUkGVW0Zr1aW3zWY8WcqWq6S8+K5k
7Ct7xHA+AggPiX+uwRh8INWAwxDfSdVYCdajCQSd8DLCMZfEngyLgepfah/NjiaZ
km+ckKXuVC0sJ4ha+OUuBR8VgopuUqGKHfvtVSw9grZnz2m+WYO2FYbPOvMnyNZN
Mg0MDXLOjCAV3Cd5bMjr1HNiiipAOKI+8ntDzfbra9VcqO2VgrT6BKuHmi9ypeiw
0UFlbhoEiKnu03Q5Rh+K3Di95N5k8G7nnRqBX0eL4jTd71awixrGUtDvI9RgWVB8
VxmIIV3KxZ9apvkSQ98RIKS83G/sLoMeTDypZEwto8kwGrA5pTJOLXiRcXOFmHZM
o0cy2H5sUtEfMAQL3oC+zMw+qmiCC0gtXGOhhVf1M68vGhvz+jY1W9c0BmAM/SCS
`pragma protect end_protected

`endif // GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jWeBdOeuaW/hQZIiLVrjLo1DZoqagAuGdy0F73Badnfo+57QfFJCImE4PFwPs+dV
SyVYuZMiEByGNOaWVIuuxA7KZQU37LJgQfSsq2P/QPc7SsG1LDqTdo39riqfTe5J
8hD2oH2JnR2KDPE6ShRT7WkRoyxHmfrhdXJPc21wtDo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4693      )
Cw3fI2n22gpI1XvX3iT7zb5xso8nosSV4BTO07sYDhS5llwwW58HDeIbmoP1Y9QE
8Ybx9BE5mvJ5d9uO2Cv0AjnG3kLy4GFVuMHiSi8p0I8J6EGlsLuD2SmFY3ThqbgR
`pragma protect end_protected
