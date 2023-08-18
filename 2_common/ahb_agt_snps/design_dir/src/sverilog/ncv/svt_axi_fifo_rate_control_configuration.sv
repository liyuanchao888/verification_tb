//=======================================================================
// COPYRIGHT (C) 2017-2020 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_axi_fifo_rate_control_configuration extends svt_amba_fifo_rate_control_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_axi_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_fifo_rate_control_configuration)
  `svt_data_member_end(svt_axi_fifo_rate_control_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass:svt_axi_fifo_rate_control_configuration


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nBid6JsK4QtBbXjHgBx+bC9sc/SYZ87arWpg7J4yAwXGDEE8/5vtqfU1Ov4F//iT
dBo9eQwkjkfC2I0ZqriY+RBxDDUhPO3FwF1QWtrqvA/OhJ+56v9bIArEXl7mu5Yg
oN6bHlt69yMKcmyRICO/pLkGIeBFm6MksXYBcndwU9b7vfrk3Jvp2g==
//pragma protect end_key_block
//pragma protect digest_block
HW5oECCgJDg4PvUjyVUCOiFuU2o=
//pragma protect end_digest_block
//pragma protect data_block
zIQ3m47QphzrTk1xXEnxOis7ouiIPF1mgtP7gT3mgD6j6sMGTLYmE7GzSqTLUaij
YgricTIJs+SpEQU8HdUFTCG4b319nZoZ7dr1Qc4ZnirWEup/R1O+Gzxv+QPr55+F
BW0Vq8I3va1Utojms+9Zle1HtcMbLvr3K8g5hx/3yrjArHqMk/buJpwVW2yWMNy3
ILG9yYUpdIGLzZKJZGFVwKTWG/943e3tLtRHVALtF+2M6U8XgNljM1o76WNR+xpS
bfpM25scZDYhvLljRxuKZ86o9uWhrk6SbYqx+2VmVJgDFMjvMj79D6MlMMToTG5J
6C8GzGofrtk9z5B4NWgGfIWbYoSSHHLnKZP9xplKPTF2CLFErIBUQjP9iwFnT1op
vnbuRij3nUv/k9FnPqXfxOGXzs5k+9OFqOM+FfbOMjP3fApZCJcarzlxaDXqzNkK
agJ5w5HQJH304M+th1VLRx6oYblvA6odYMsVumU7nu6Hqab75qD9DbYzjEnv59N9
rW97QtiOLdhI/H1zuP1otByTAdOAaf2qV/8hy/isc4v4NyowbiCQk+46XvVPbx31
awWsVpzB1qQcJ1vWmztjiqkoN03xwnBL6UbRYHGQLd3GnjUipCSFP59oyK8yKVjm
Ge2A8UacDuH+rCxPZp7D/h0lhXo3ebckajQmGTnN9Hy+F0LXPvmzyiITNFU9Dhbe
k8f63ZW8OAPNuXCJaqaTUBdm4StGAdpalocdHWbsHe61ujATMaPhMa+b7/oFqN1z
/pnogae2wBvgoBQ/91hO/Myq0towIb+j/ny727TyfN3DWgrbpGomyqc1oYsY0Xsi
jyscmprJLMsYygm5U7a6HG910NQVxGYz8ucZzEznvSEWqXrhDtu7smK2oZCOROER
ZH8x6xkydsbl5GmS04uhupLG/Rph3aPrJC9OqLcjxQNJ842mSS9tXSNP5OCo4Ks1
iFfhVo2XL5Lab5ri+j9tzVi8Tb/sP3N+COuZAOLYIw3Cnj4BR/kKn+dh/UonmpUL
+yT43oO7TKHKPYJQQm/gm8Y8vnqu5iFDS1T1140ajmuiOeD2Qmr8nwW6o9mNIKzv
nwQ6ewK3cR2yAawKvtszPbp0bHMMV3aBMSyQeIcMIxOMF+p/s818d8FgFHMnwgYR
7cD8FTlvYqQnOeu7xk+TzA==
//pragma protect end_data_block
//pragma protect digest_block
Vh4WSG7yrm9KiYMPCTVOACAtu7A=
//pragma protect end_digest_block
//pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_AXI_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
