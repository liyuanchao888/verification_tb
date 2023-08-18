
`ifndef GUARD_SVT_AHB_SLAVE_VMM_SV
  `define GUARD_SVT_AHB_SLAVE_VMM_SV

typedef class svt_ahb_slave_callback;

  // =============================================================================
  /**
   * This class is VMM Transactor that implements AHB Slave driver transactor.
   */
class svt_ahb_slave extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Input VMM channel instance for beat level slave transactions to be transmitted */
  svt_ahb_slave_transaction_channel xact_chan;

  /** @cond PRIVATE */  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Common features of AHB Slave components */
  protected svt_ahb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;

  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  /** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   */
  extern function new(svt_ahb_slave_configuration cfg,
                      svt_ahb_slave_transaction_channel xact_chan = null,
                      vmm_object parent = null);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  // Below methods are not yet implemented or not required for users to know
  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();

  

  //----------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  //----------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  /** Method to set common */
  extern function void set_common(svt_ahb_slave_active_common common);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  extern protected task consume_from_input_channel();
  
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called after pulling a transaction descriptor out of the input channel which
   * is connected to the generator, but before acting on the transaction descriptor
   * in any way.  
   *
   * This method issues the <i>post_input_port_get</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback
   * implementation causes the transactor to discard the transaction descriptor
   * without further action.
   */
  extern virtual protected task post_input_port_get_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received the input channel which is connected
   * to the generator.
   *
   * This method issues the <i>input_port_cov</i> callback using the
   * `vmm_callback macro.
   *
   * Overriding implementations in extended classes must call the super version of
   * this method.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected task input_port_cov_cb_exec(svt_ahb_slave_transaction xact);
  /** @endcond */

  //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
X/eG4ngZpJnPnXvYOf+b1Fky/W5nWw77Wu/cQdkpoVUnljBow5ZyJVJ+MhtzJQvb
a7q2eABjgfqFjYfMUjSg1KR7y+R1w9qYqZ/JWHSSX3MheYZA0WNl3ew1W9DXx/+F
qUqEkaxrWb6O1aMaQW6FDpK8Epf0DP186v6m1zUSGG0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 238       )
+LNyE6BExK3AE9odoma+6iT0RzVOLfCBGEeWm0OaoGcm5GkLLe+g3dqyTzz931H7
2ACw0dybdDbezeAPSvmzGQxE1YCX7cs3+EUSCeEXs7BUVcmXl/Od9Jx/p/5iV/Sq
nNEMqnBFkZd8nri77QTEl5sNvu4Hl0AW2Ub7LSv1+nLI8prvLndQOkr1jqRjiDRo
8EEDGYiz1Nae418K6sLPIlSC+MNdfkrHKu7rWtfN6vwaGNvrLcn276jfZf5PE/VM
lODhEX9HRkdly1ZXqaxdMH1UFrTG7UJ79FLnq+0mb+ZlGiq3wVA4xoBbUtvnMtpC
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
A/AhbV2tDNAuG78WXSsRUEmZGjOpA10vqREs1fak4UZecck+kU250dpNkRyHTm9c
ONiet4tga3ci3YmvrbK3T6EK+Me4O/JjygsrKZ5I/W4tXvrNNWrQq8+F2J7GQIaC
hpIOrh0SJx07LuaPUoWhCgFQunmyOKChiU4ZDAuWFt0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1710      )
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
`pragma protect end_protected  

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
O1RyFbZKtgZw2Wxyh5h1lj8382tMcHw4r4KzxhON562089mh1kfYXd+qqJijGR1A
6LWGivrOy948dK0ufTlXUygAJk1lClOPEeI00BSwPkqRqv3GqEgTuJreazJRxMYp
glJpUpNSIQDO4O2J2rSc1vtJsoX40A1Stgd8kywP6PQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10434     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_VMM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FzS8rNm6CfHFSGi9dj0YMLFMiC+7qqG+7RYECCOa8L/RcHR/fUxa8cETjeEg7ycr
ET1cDE9PJDVoMwpO2CKKkBZ81GfhlIB1UVn8lQcWro/eD+GswZNLOTQvvdffMHVw
FHbErmiX080rdwnq73/kAPGqYefLJPT0pj84Lbkyb9w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10517     )
lYfLrep6K0WjeshnPNzQy+MXJDwJ9kze90fyiQZZIRrY8BT0lD4auPRpFh82QJUJ
4KBch+ubn0ibQVTPRRL5ReJdgBm6QuNR4Zv1T35dUWFMUUbiXTMibF+GAIuOhdN7
`pragma protect end_protected
