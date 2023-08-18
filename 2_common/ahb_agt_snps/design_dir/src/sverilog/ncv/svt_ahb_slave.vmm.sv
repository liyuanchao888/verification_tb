
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5nPSEeeXLJsweNrJhX4XH3G7JMHwikfw+lDJYhUGZT70WMimlQhIuvVG+go8nw0S
maFUnsnfzk8jGgLKHJp2ZugxKMvFi22u2awFY6ArHCcI3PknIvisk7fG9sJfSfRE
k38tbX1fFfFW+JtxTgviVCZu/ca913pkiDoR0wWNld2baukQj1mt2A==
//pragma protect end_key_block
//pragma protect digest_block
iAdN9x/wA2+JmYbV7R/cYAUhcVw=
//pragma protect end_digest_block
//pragma protect data_block
YHf9sLSMvcLAQl47UdfZZcSzPPVcf0hTn57ucK/gG0r8A0rvqaUsAQpAypnxAmJ1
7kmeNBbCEkq2mKOqx5L4gthu1YpEApXlleqgPR5R5Wv22vbdG/8nKwNAamkMtW28
VHQLrt52F2mZTYcVfwqtAxACCC0GVrvFTF9/48rMigixJcbDwM5GoTPzm8h6B5pQ
n2J0voy4g7LG93zw6i23gOg1WCWsb/VhMrghAicTbH28A2CZiW8E4dcOjLNA6N0K
IVOY+dp9iYu9I/1STAo6Wf8dJOfrXu3n2ASdtzKJA0MFbpp2npxciDVhFYAU7BNN
gQfwQRK6fya4N+0JdadY1gG9GnXi0/lNyVZpCXx73fESkOkpuS1CiU3VMV8lr2Xv
YcpSkUUilwJebkm0Y2iaDNWytJeU0lGBjNT1mZFCm769aDORunZEMcP5frfls0C8
Znz0NIRDa8ouRy0DT65WGz/4ljTgIUn3TL+Fyja11aG8kbH51/ph6t/M+bS6yuvw
AzVhHznQ2LuRXmDvpvOW6UPbRJOGm9NmnD4w8u9wXmA=
//pragma protect end_data_block
//pragma protect digest_block
scAXcvYk3FB3Y6WGH4qREr1l5QY=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tuyLUkMxYrfTPBV9GkbHkSG82qQFpOhSqiQ1eUDmnPptPNeotVHF6hj5J5DvgOxB
EQ6r5CiEg77LkDKg+UddPZug6jO8hKInTPSxZg9b2EWpsqmkekXBPB13bgOZsZLy
qbdn0oxXTKXCLvqapPVnL40vaLtlvcEhYB4cb1hVozL29zxuCJEITA==
//pragma protect end_key_block
//pragma protect digest_block
FdI8eeSX7yO2o0mwmbGtqGRLWvE=
//pragma protect end_digest_block
//pragma protect data_block
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
R7E9+jOEM5jhgLy0UNq4dg==
//pragma protect end_data_block
//pragma protect digest_block
oE9uRyUW86e1pB8eKLS11sT8Mk4=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
25k9GDQCB95YuI5XzmaS1roTkcmHw4Ez9UEoAuKmLqm4BIYM3ecdjkI9DhqPpbru
5x/SxnEBTT4nIx2Qt6lR6s+R/F5F9hd7pm01a1gCfTJH7tPQQnMUj+zWUvPNYIoj
z8OfeV1L/2bUO2F5RGkuZLc5kCgaTzztWygxCe7dWzM6X1GrUS66jg==
//pragma protect end_key_block
//pragma protect digest_block
ELuo8JQJ7FG8I9C28xdZJHh5Aio=
//pragma protect end_digest_block
//pragma protect data_block
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
8q94KpDZLnoiO+T2gGM0iQ==
//pragma protect end_data_block
//pragma protect digest_block
bUe3cz194OzFAI2ZtCq6uo2zs/Q=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_VMM_SV
