
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV

typedef class svt_ahb_slave_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave_monitor,svt_ahb_slave_monitor_callback) svt_ahb_slave_monitor_callback_pool;
`endif

// =============================================================================
/** 
 * This class implements AHB Slave monitor component.
 */
class svt_ahb_slave_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave_monitor, svt_ahb_slave_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Implementation port class which makes response requests available to
   * the slave response sequencer
   */
  `SVT_XVM(blocking_peek_imp)#(svt_ahb_slave_transaction, svt_ahb_slave_monitor) response_request_imp;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
h6l8u+sbq9j2v8eGf14ryCVXJRoTpsFK+qhOcnJp6ngFU5RgCLUBq58K9ptba5Jw
bdQNbW0/pNPydN8tko9nEhpWocCckx5N9COY9+KKdHLH2TKdtfmnnhuacya4E5ey
Z1fjI0PMOBCvOZcRGtAse7NrbCUV2mf3/WbtOhTl8hAkUyfrdaxHIQ==
//pragma protect end_key_block
//pragma protect digest_block
FOC/n3kOjmNt3TR1ykIHVpq0CdM=
//pragma protect end_digest_block
//pragma protect data_block
Jhg+i+TU2ax8Z1ZcdWru6lUl/nbQzejfOn6/8DHORRRflYdZGuxG78GRmLDyFoMC
K1UUfUMEPpnEiAH+gxtoi9ujYcO/qKEn+NIrE8fjaIHUFQGFS/6F5t7CUX5vIwVM
ErlY554jeUOVvcOZkV0K3hbQFDNOcNxkIxEuhp+zV9Cud1bSwVh6/4J5vXxgemwG
T/cCreNYP8e9MfX4NM1PBeUdl4AyJZtjWTb8nnObCzo+tcic59qKHuHrLLvXzYdN
CZf1vR+sMWHmF21Oi52nJHfTgIMkbevIJssgBMbD1sJxsEYgQ7l8r/I2EBuu3SP+
r0xP2E1SJViL/7ZUxEWy7QdK056/ix/rc7f68tZ9P3TkYzU4V3BUkhWZNZEpa8l8
8Km3GvRAvpWKAQmcGQtlHvdmg7rTobMxzyqHRNHESl9m2V4Qm2404N/erS5gKbfh
31FMqseV9MxFwGgcmfcU1HrR1w+HGfhh33EzJnCIiwHlXYECo1dqEV50ha6mioij
OS1Yuhusf4qwqwjaNrqrfZenNzsGcC6hGOlmd/0IQT81p01QolpJFf3OFj4gbcfu
eNsurwd+4PQYE7Q4P7uxT00H9cEpF4o0BQjGApIQQ9GU874hWl8Y4/aDkKD9HqVC
6Eje16vTyClxIdn0UzDJIhHJcOdjXuudAT1ZXOLwjW2SyyucdZnSEKyUETOkF0gO
CvzIb+83IgGUPHwLKd2dBHTfaK+e/ZpVAt0zQF/bDz8=
//pragma protect end_data_block
//pragma protect digest_block
qqU8sFeWCcUNnC1W9KwTl/Ad+UA=
//pragma protect end_digest_block
//pragma protect end_protected
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************


  /** @cond PRIVATE */
  /**
   * Local variable holds the pointer to the slave implementation common to monitor
   * and driver.
   */
  protected svt_ahb_slave_common  common;

  /** Monitor Configuration snapshot */
  protected svt_ahb_slave_configuration cfg_snapshot = null;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Monitor Configuration */
  local svt_ahb_slave_configuration cfg = null;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_ahb_slave_monitor", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`else
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase (uvm_phase phase);
`else
  extern virtual task run();
`endif

   /**
    * Extract phase
    * Stops performance monitoring
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`else
  extern virtual function void extract();
`endif
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_common common);

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /**
   * Called before putting a transaction to the response request TLM port.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual protected function void pre_response_request_port_put(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_slave_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called to sample hready_in.
   * @param xact A reference to the transaction descriptor object of interest.
   */
   extern virtual protected function void hready_in_sampled(svt_ahb_slave_transaction xact);

  //---------------------------------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the request response TLM port.
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is accepted by the slave. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------

  /**
   * Called when hready_in need to be sampled . 
   * 
   * This method issues the <i>hready_in_sampled</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
   extern virtual task hready_in_sampled_cb_exec(svt_ahb_slave_transaction xact);

  //----------------------------------------------------------------

  /**
   * Implementation of the peek method needed for #response_request_imp.
   * This peek method should be called in forever loop, whenever monitor
   * receives valid for new transaction , the peek method gives out a
   * slave transaction object. 
   * Blocks when monitor does not have any new transaction.
   *
   * @param xact svt_ahb_slave_transaction output object containing request information
   */
  extern task peek(output svt_ahb_slave_transaction xact);
/** @endcond */

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ysIpZ4CXzCE0ENGX9tKmSzOoz4uWbrdHbilyR9oY7mZxstpLObxv64lCSQOpFpqN
+S0NILY9qQVu3qsM+xsevTqcCuXT8XacgCj0DjKJC/vsjs12Hk5K1h9yIGpAKAvv
FfIRYTr3xpJD/04cVb1VOI479WK1zck80xYbZBYF479B5RM5gzAnKA==
//pragma protect end_key_block
//pragma protect digest_block
mYCZU531GdhMehPmjZljjD3P7Fg=
//pragma protect end_digest_block
//pragma protect data_block
RZoXwtDEf6V4R+A7EX8Ene9EagUolQs8cCaYoKyFX8i43LK5OZnB4QCeA70iLXT+
sGhaqlIibSRRXyu7FFlaEmvSoT2QRxW5xRqO/+hD7oT6dVK75dcS+kr96dd5PLMO
Y4iiAkeW1bDIeqtqT3uKjEKbqzcdhGaC+UXlsGG3HgracNljR8a8ovJ6KOMKEWU9
HDiJqYIbWq/d+EwzSG7GyapjlZpmkXFmZ3FV0uOWqIBhujvWjNz24FksL6BYeTpm
jREmf50tYbGGogFEjmz8mvR13cbJFsSt8vGKPPTyZzbJaPtDTyAHbFrcnYfowDqI
4pLIL2/jume/qj+z3kS44je7VkyvXboj+fYYOq95NOEWerAZpSY1dH4guvaKDGV8
e2GVANu6vwa9OQRqBzt0YuiMFZBs/OxqXxO2h18s6DSUGEV3kt0faFY+EaLte/lK
Oz5Q36rI4gqb12dignzE3b2jN62eSarrbph7KyCrOfiWSQ5jtZ1PkWyP/Pn+kbGj
wSvVu119la6eMfBhcRwpXFhuoxAc1LOS7/f2fQSaW2AeLjTO2iaRwm//q21bBv8t

//pragma protect end_data_block
//pragma protect digest_block
t5RhdAgcdZCmk/BCSPHwNtz8mW0=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YG90C9zH6sq8OUZ+emeoF0b/WAd99AewMueFD3tM5XKgrUuKivt/CI/SwDakS8U7
dc+VwUt7XZHAm73fo4kzSS8a1aVJgSEn1C1i0h9gIbeW98XfdoP/Gm+fUpyNmBUK
k+Uenf44ZvHLo0l0Kp83uJei9ejkWkvWA+iw0P5qCGLTHztG/YWC/g==
//pragma protect end_key_block
//pragma protect digest_block
nPFumVqOjbgSBhCnpF7HKGf6BxQ=
//pragma protect end_digest_block
//pragma protect data_block
4I4L9bnYTR4Pnx6PgiOYMdRp/ZqtcXnzAeWY3DH6DAk281XOWLIIEjyUMqPfIgaw
PUPRF9rMc01XELo1NPHgOGcv8yAT/tY5xgCvAXDb8W8APZh17MGc5kaBAz7jW7T5
FROW0v8MhmMlWbvEV2ben7NBJjLiYB21B1i83ujVV/nrZ0V/1FaCNZSdiQGu6syM
+lq0Y3Hx4Yqei+UNbKOQx/adwJDEOi3Aqieepdi5hC+8LlI2jrkj3vTW8b3bnzfT
EkRTzqb9ebB8PpDA1W1nyJNgEWUW68nVxcQQWWL3UTiSipPmPgRJIHmGUFFA2XEF
6VRWdIgC8VffTrN2RDihfWFfJajCbqsDjQIL6iI39FURYTHksa64eMndQsazQcs9
Go0VX4yqk3LzhWcMqiZrxdJuSFwYJe2/ZPVFWpXAaIRw9Ydm7EWTo3pZPY8wv5uZ
tJeWqBAz6jkWfhxBFJfXJZlYpiJWvLK/snK+b4A6PL3/pja4+zUiWn8m3AM30z9z
mZKz3tFjm73nOhR5ZSV5zFvVcgvqVorTzO0xJsNLiC74gC6LktubfxwT05AGYl3D
gU9wev6M3iokbvyX7AnC9syI4STQMiE5TeEHNP5eTjdTdemEhAkwj19tPaJ8Ew0q
8cCD9U5WmmFAHjE2d5+4skdIGeuO/PTRTswQqXq0f0v4lVvxc71usetS6wnH6nhH
12uTgKYjCFUtSfu5z0VQ3gNypCM2r7aKasBnJIXnu9DhjF2GPhI5CMvFW+CjoAcc
/JE6/4mdnB2tN9aC/2+DplpQ0WM5DbeipQcmbXS9YwA=
//pragma protect end_data_block
//pragma protect digest_block
U0B6momP04og/sxCq5U/myOAGM0=
//pragma protect end_digest_block
//pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cfKKo0f9i8W3FlkHgsyNLkChZUv6gLuCuATMEa9uRF6SyrXxUl2HT+tW/JzsHqUG
2EA1dGsEp98K/gu9h211233nSJMF41wXnYjqZIZ9PVc1nsL9V7iYB095XSc9XsyS
ItGZlti11OoKifp5wvwHHoSKWAl8NqogGGMWrOqPzOeNo2jye6xezg==
//pragma protect end_key_block
//pragma protect digest_block
hzyCMBF/7sIU8RFTz90uIPUwxFA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
HUu0p+mZZATPl6AX1zFemAsnxVY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


