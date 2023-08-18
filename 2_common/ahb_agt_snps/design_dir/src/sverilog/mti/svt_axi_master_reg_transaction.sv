
`ifndef GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
`define GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV

typedef class svt_axi_port_configuration;

/**
    The master reg transaction class extends from the AXI master transaction class.
    The master reg transaction class contains the constraints specific to uvm reg adapter.
  */
class svt_axi_master_reg_transaction extends svt_axi_master_transaction;  

 

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_axi_master_reg_transaction)
  `endif

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_master_reg_transaction", "class" );
  `endif

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nhEeKTPHf/g62uQa55wXdp/4OiU6viblPeDWLRmYnAYPB4iPyDu3bVPSHYl7dPaC
S4d6za3TBBLxCNmb/zy54WpV5JcDqsz/PBBpWiAdImoMAHSFIRAKuPpoIKTaJANB
1PA+BERHrYujaqxG2aqkv3CCNY3ecNKhxIgphIUhZD0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 880       )
JdEw+D+ijA5LwV+dv+nILpfHjVx8f9XmuFbrbphXo6bAsfHHaLX2EVeus25DQLbp
5CzFovvRHSpU66AzRiqDZQ3R8MUe306KicCjIYJ5VpoCIiOZw8u00LZri6rnWHxo
RkzchYNaEUEUAPEEAB2hJQybUHPFTfy0gSMtqMOt6+zTx/h3Za2h3vupuOE1MsMc
SOnjRF6Of327txhYc0mnwGZ2t78gqKK+qoMurVZTxwiKvO5PPz4h0GY2xtftH5V8
1CVRRx+18xSIxNJPvMaU4xplsQtCdL4wpyCuNf74/UYmLwMO0yc5e7AOcKvH16cN
efTW8IztVZkuLUmUKaA5QUeh8rDHUS74R3eU9t/5x6vCXTy4etP5b1sp7aXNARy1
y7eY7X1FrrYlrRPsPcWTBWq1qPDFZeKC9BJdqC0i6USPBjbCPoL1h7gd1qb0iip1
GlHz1m8GKzKWOtxZ3x+z2usDkJ6zj/IVDC8edOPRH4i6hNlYS6hjDf13BZHx+uAh
uR7CzMl/+rYDKAH/0zd4+Cn2Eu0sWGrItkhRlcMg0WJle4Dc8+KMDixhBfcJK9fG
vgpmykgOAXHQ80+pFIT0ad+OTHmQUiFYtLooxoeBmkhgZ9RjTnw5xZsqe8BEF4MA
4IXzoClB1VsMRyGaeZ4LD++J0FG+l/n6D75Im3ONTZocdwdxLbKi27Lb2n3pqoLy
IcBjtG/h19+4xVRjPOMjEriAezcy1we6GBjUWIdUOUeuI7M2Z2GCQrzVDB/Uwh2l
EKCCYLw6KoQ6QE5Ny719NfZm3MBSdHts/bxBVr38f32lNG0sb1l5x8R7IL4GhFUo
vzf2xvHjLQan/Vp5WVOHA+U2D6eFSwtUJIoxuT+CFp8OkmxbX4oMGBBSxH6fHrKC
7WK67BZd/DJpA4EpldbI3KhQfSoBo9Jd+A34RaGBohYFtmLeGFocYcUX6Wv+mD7M
7Sb0Nz8blq/EhqIIKRalhvX9cCmuKUaWhGIcfM9x94snldW2NloUgYF2R+4WoQIe
SEAALjwcEJWRbR+ielHriP5dDPpamTghW7MxXvykjndpcxugJ7pIncyYNopSBgrL
wiLJm9lnp8GvplCaVEqWujMgtvxQrOvp6Kh0sAqHj2GbhlD8Kf0tS4HHNUA2u9UV
EX131nJuCGbdZvOJRNrlXC7m6USAB7zGjKuexXEm3Pg=
`pragma protect end_protected 

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_master_reg_transaction", svt_axi_port_configuration port_cfg_handle = null);

`else
  `svt_vmm_data_new(svt_axi_master_reg_transaction)
    extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_master_reg_transaction)
  `svt_data_member_end(svt_axi_master_reg_transaction)

 
`ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_master_reg_transaction)      
`endif   
endclass



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cS3nN/HWC565KKfIQEGDkgl0ckcFf4/JzgOUlJzGUaS9Q2fKKfmmSXNGE73/27OI
7+IWO9SQxDiqg6AM5lTo+vENCheUOFr1RZzafDp1IJ0mcOSFghgEOlNQi5S7Je2y
tpO2yvDgkRUsJkrABpys98RF4MeIYP8Kn6iGOBI0zM4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1767      )
eE994zl30YEheO3pUHOvNB8dsUS9/r63kmmiK/iqWzF6hVcHevMwRJFGQUqWSnOM
HsCEehXGj42PzeU6LjGjpFHNz4iX9JWK79E0P5vY8CQ6li+eC8mFeNq70PGd0qCZ
cg+68GQ5ph5I1CDIZgyJfh1UMSJ80yjRgYmnqiEHz0DyUxmIkmDzsIPGv9AmyTWj
oJ8T5F30fowhQz2a3jbWPPhcygPjEpjr6OWdkIwIkYWwLj7BL0jyJxdLZluJwoHZ
UiuVtbaOlqqs6uujHEUIJQNoUN9uj9XZk8WPmyv6YlZ/B0jn5FuOoRzpElloQht3
SohUx8FHypBR9uqvqkumuehKi/UOlYL9ZXaRHH8OBHBL/ZAxpQr/hQUl8Kpg1WrO
HA5fIK01I8CAjV8gVR2INc88D+x2pGHdDaxcj/fg7phH/EI4noz2cXDo1JHP/wsx
63AV91ImBSKLZaE0dxcYBEG536zyStijIrJoQTHILRfnsUN2WLBfKeDhO+I0HjGO
hK8dVgjhvuuuZA3SLfwdFTfjxz2vKxBqXSVtSFHUh3Q/dzs5CQ+DTC4u5DqZSNWO
AXzlr01AR0z8TnHOkZorznc9kZ+MFMH7l2pzuPFRM8bncUSBaHVwO9PqaucfkxSK
q72+TZMtFfQNQS2KpekoLt98W+Y69CFCLo+YM1w7aTH+XqldQIple+OEIiIj4bSU
Sl6QuLrA52MvMEMDTbnBCc7H3q0XNdG4rElJzneXZXWmoJgnFFwvl1wwCAnYg7xm
KN7V47YTZZPnLLVKKrVJ/EsWgDlS6cGBseC1PwAzx9oJE0DoG1UWnBTZUAObYxHe
s3F1RQ5qBxFsNwkjTpAu4XvmF4R7PCVsbqNDCJZdRkH/V8CyVdcH6nsKkeaADJ9k
63suuAbj9rv7fJpUv8Z/mGibEtzkEaBA2RcNkbDoOdbKaKyVIJW9UPs2m7nf1akQ
m4kI+80OjTE+2p7h0S6XJ/V+tf/ddu1ZJUYgbXf753QaIFS0zndz3ZtZ2aXbOYnr
eCxJk9JcYePqIBfMleDSlWLJmB/Hw845GeWpZe3ygb7Vat5iASbis9/2/xKXB3qq
HKrTj1bAFzWwdRVvUJJcO5/LIQGvjNI3NzBfIm8KA2L4wygFtfNx8Eg+bEqBrWhK
F/lXnE9Wl1DJUxFtXtESnMiDX6+3x3nUW3PfBc4ebIA=
`pragma protect end_protected

     
// =============================================================================
 
`endif // GUARD_SVT_AXI_MASTER_REG_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BFl3R9Z4kgpzA140bJlLB6iXIVVFFA2+0f54silDYUUpg7bzyPuvyvOmQc7g6+u2
5IpL8Z/64De/N5RhZ4yQD+OXpGvv3MO4t1jSZybk06ixJ/sSk/SmGQVQZQr7HfYq
TVIuIgmAmzSevuV3D36+C71Y/KE8Stn7YINwSv5WTQg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1850      )
Z39DV8+Kkr/2RGkZwSNwmihiyD7G6OXDGJMbxEJcre6gzZdO0RKYvtg2MgrmkI82
d1/xi5iQyYX8Y55lKL3eez2Tb+AjvGWYR33E65sqZ3FYWUUiJcwFR7zR2pFMq3dG
`pragma protect end_protected
