
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_SV

typedef class svt_ahb_master_monitor_callback;
// =============================================================================
/**
 * This class is Master extention of the port monitor to add a response request
 * port.
 */
class svt_ahb_master_monitor extends svt_xactor;
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port that broadcasts response requests */
  vmm_tlm_analysis_port#(svt_ahb_master_monitor, svt_ahb_master_transaction) item_observed_port;

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_master_configuration cfg_snapshot;

  /** Flag that indicates if reset occured in reset_ph/zero simulation time. */
  local bit detected_initial_reset =0;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg;

/** @endcond */
  
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
  extern function new(svt_ahb_master_configuration cfg, vmm_object parent = null);
  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();
  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();
 
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /**
    * Stops performance monitoring
    */
  extern virtual protected task shutdown_ph();

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
/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low
   * 
   * This method issues the <i>htrans_changed_with_hready_low</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task htrans_changed_with_hready_low_cb_exec(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans is changed with hready is driven low by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void htrans_changed_with_hready_low(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

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
  extern virtual task observed_port_cov_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task transaction_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task transaction_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task beat_ended_cb_exec(svt_ahb_master_transaction xact);

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
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_master_transaction xact);

  /** Method to set common */
  extern virtual function void set_common(svt_ahb_master_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();
/** @endcond */
    
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aY1y9nvrJw0jf9NX8vEaoa9AEPofifMumBrz8yBxJXLtyEJC+NkwcvESkdP3jKVP
30yAAn6HZYr76x8iEljyqkK3220DX3CZgDk1v5vr3pCbZUobuNX0iV/kfvjZGbQj
7R7GiJaGHDqhBR0+Az7b49KaJxqUFMbOWhXwBtz4tVU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 256       )
3or2/j0bCMekaqGqhrHQBi2hjbNGQwhfitLZo8aOW0hjg6n+LphtvEtA4eBffhEk
LNIjTWCFsmg5gborGIFGbV7lERgIvuwVfYI1Sxc/aN+MM/eu016P1PGrAHyham8c
2UYKO0gAWWdhG9Kq5mWPTizANdISczmYD18EtQlkg0PC/Rh/bZW1rVa6fu+VAGZX
zSHQFvfW8tWcdPMAt1afuAitioI+lTS9glfilPN1LDp3kmOxXomT8KnIWXuSWs9W
DUWmph+pQoFJ95by2fIWMe+jBwVlnU5FDmOIfAK0YcwS4JYQGrE9gaH1N9NM2uGi
3/Wv4ESAFaNhB3bDe3dGNqUuSEcVuYfdmCCgfohD3rA=
`pragma protect end_protected
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n1l+Q3z5gQbXej5nGlcjyM/1FaSSPoJ+ug4gA50H43kEENhW9zb1u7hR0Pc/fBCn
EcwElSw310zx6kcLBssfeRNQsKWTVA/2tQA6MTYQgO2/hGSXwgd1A89sI9D0fo2b
5HGeGaRVAIKUqoRtweFoWwfh85r7vr1OlY1KkPrJCL0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1420      )
6+V/xAo6pbGYLpXwrQH7c6UgiyoKWT7A1JgVt47JL6GyagZ3+50xY49UGcpcqhMs
JsE/wEX3EuBmR7iFj9RK2M4OL64OGjlYNRVHouljxeiPH/nXnDCGGFhsc56DlYIx
CXSBGIGAxpzu1aWxJWfd4GliWTfbigwPvi1cmw9/4dfDsFsMA4rGQ1yjrQTsweNu
Dvmhr4jSZALJsPOlpoJsEoikgEvLf7/nJ4gmqgx5FYO9RZ8bgXGiYeG1NApie8d6
AocgfSzQN2wGLptrYRs57aAXptge6ofgkyDEHrAPhHigDeUJt5yQgH2I18LUIPUl
RYhLb/r1CTKIwcZb2aYB2f8W53wT9sv8eoNkAitL2JxmgD/N2uXyXEmBDTEFWNSN
gPeApBbvAPtvJcsFEzOUMrNAULm7YeMkEtYXbuuCrAHTZ62cdvT1veeQhxWnqWz5
DBUMbUivvI+JGnqh4nip7YCvEMmpqEgbmAvzvsODRHZRHOYtgBK3L6p8e1pZfcCn
ZnNmTwQSZLBSpQwA2gbMfalsRplFUAgCt4CjsLRcVvjgl5vOBcDez/Z5QI1n6FZ5
7bpfVICvOrlhQbkuha4JewadvyBuAuaTSN4KkXilzTrUorWwdDP9/TewjU88r0rF
JLF3r/J2D0vQ7YisxSWWKeLsZ6JPSaj4bCwubl0IOqHVivBFUMucf8zV5Cbn5YQo
DKhRlI8NQrG0oo6rFYdwVrzU/6+d+qd1uWMxOD9VzUKHtf1wCz2Zh+g2xSkp1hgI
oW031/7JbVKwb2FRUJpKXa+74XY1exlUYudkSpCsYqzjXe0f9HQMz5ZdQ6SuEZjP
Ll15cK/y5Qxvm2xHsdjzUuKl6/A5c5dfnUPyTH5ovbyUQ0YmMW1WZ/0AQ5nxcY3k
PH5bBqm554kTrRpGq3KOJ/eFRDMRL/8fcAJaUMXYsaSIPj78ej0cUj/SEu+urZ91
vqtFx0GuFGTMGGY5lxrgG/OmCmj9AHOeAyaDkGovtX1f3aKFqn9czqxGz3P1MMse
6VOajQ2pqwqM13do5BgBAk7ibu65WtahkhVjYbFVtQQ0IYjdYXJylXG0kJLet9Ch
z6inA045rgcjPQURUKo+g6T7+dlRQz8wF/qploHhgRopXwJYebhlUMb3q8yEnoGF
wIYqmjYlWyLarRn4SBhPGERG8u7EXjRvrGPdgQZBY4DTeo3Hc2XAmQHvOdoQ67kk
56CkKKhZNSOVVhH2yJlIR4Q7ikooBt4QHDgm1ItVO7fqq5AmaP2bl4kTXaDKLFPG
GANpyVNuVTO7NCljfQoBL6fxp2TDdsaVZ0ExNKHSZ6LG02Vtzc+3hqX+KPv61k88
PCjgUAupA51FqHA+qphHsKwTUTh3hLbK5Ysi0gAK9lAsCmfRom28YI7eACpO3mWJ
4htohIwwdYfyeCYuTPmIbPUFcr3Sacf+AsEzA2heCKeoIVGTCIBzV6NZkb7fpl/F
vVn2BNPyXsrt40mf0w5baVL/hWxk0vD8R+6RMVFK6+oQVsKJampdIAwe6r6wDxAu
R9ilEKSoy8cFrhvXKciPNQ==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MWuAli4Ox3Qqt3Uw3EZ0YEcWkuoiqFnyBjmmolsqM7EJK2bCbdgBUXUB0gVD2390
fFFHwYwq9dOu5VD29Jj3ITY1psQN1Vyd/R3ePCDZiGb2lUPufBX8G5nv8RXWjFCv
iLkpPoC604vk9ldMa16WRuB/GWUktLnwz4AryDVln/w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12577     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Am5Paz8FMcucELYbMCbhGLKOXqellY+3fQ+jEfkHthpcoPW3AfC0cSOmXSdU8tfz
F0OLVAkEk4H9Oh50tdSxJW2wy5FmuniIgKUjRvHd7PqG+usxx3ZqNdL6rs9krlMP
g53oePYV9Ixz8DwgUWOYLSx4hncoq0o/Y562opiLHQA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12660     )
6IE2fwjAASEGOW6aWoGfhBAgQDsp/TCj8e+Av6EYAMZV8MhkhyUXYAjDV5IvIOx2
BdQT6B/2KP+zSiYDxrD+ek90c5QmlChAiBzXes1Fc54gc1lGO6lmPGn68vr8Mukc
`pragma protect end_protected
