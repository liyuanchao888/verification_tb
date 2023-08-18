
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

typedef class svt_ahb_master_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`endif

// =============================================================================
class svt_ahb_master_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_master_monitor, svt_ahb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EdpfYSK8ciJxvl5GTWly2IefQUxPHnbuB+MkIgXXssrZ7U+lKXrvm5ALtkCHS/SX
2UKfAMgxhKG7/Yd6We2dvgpu/Lp2C4yCsfUMk6gbOmhfU3Qr6h3qVU2yPwTtw3M9
WUUxyIWa+eKbOqF80+1Vja5NKB4ScB09kB/Z7/1vUe8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 341       )
IU2ogALtDSttTP2BhEfTArZzJki9SqIQUV9EknqAJq+x0EOpQZL2CM3dzRP11JSc
HakWXJkihhWU0ZDcW2cq3++MjQHHwvOjV7JiYn7O10tV0/6SwbbqtTilgoO8oZKB
KzX3RxJCCUQVhFgF6upAXnj/sLPuSol9Y21+wpuT6UyC7Kc0Cc8Lg3jt7d9OjmgQ
guD4Fs3YxSGF+owDsmuN9gr482AWbkbtKfm18OfCdjtyyBz9VXYm4PF92JaKGi8e
4uvgX6lpGBG/RVzzGVI3DVTZ5mUU5OqvBCx5DN4Tsl0j7goUNnX5UZYKuIEfSTTV
cfdhVwdtUUPh0GCKswcHUx/QCiBgsmFa9dRhLCMpoZm/h4Dtb6Xjm7BB64YsoFP7
KXUeUOCgJ1IQMKHNgCKDqdRUsUJGUYljlzAmWIqpdsji9QMWLU+kqOk0EuVmN5S1
9OfZw8G0ZirFT4jSB9zz1w==
`pragma protect end_protected
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Analysis port publishing observed transactions as PV-annotated
   * TLM 2.0 generic payload transactions.
   **/
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_observed_port;
`endif
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Monitor Configuration snapshot */
  protected svt_ahb_master_configuration cfg_snapshot = null;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Monitor Configuration */
  local svt_ahb_master_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_master_monitor)
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
  extern function new(string name = "svt_ahb_master_monitor", `SVT_XVM(component) parent = null);

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

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Called before putting a PV-annotated TLM GP transaction to the analysis port 
   *
   * @param xact A reference to the TLM GP descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_tlm_generic_payload_observed_port_put(uvm_tlm_generic_payload xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a PV-annotated TLM GP transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void tlm_generic_payload_observed_port_cov(uvm_tlm_generic_payload xact);
`endif

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

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_tlm_generic_payload_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_tlm_generic_payload_observed_port_put_cb_exec(uvm_tlm_generic_payload xact,
                                                                        ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>tlm_generic_payload_observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task tlm_generic_payload_observed_port_cov_cb_exec(uvm_tlm_generic_payload xact);

`endif

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

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Xyv6kfjIRxVHYRpLrVOtM8uHlnPOQWKKCiVwrPps2FH2JrbX/+pDTfwVyb0NXIdb
e1yA22kZQidSf4YVIvIUXYB4BYRyg/zBJUO14S4z0wXx5gbEfCUp2z+a2LoLz9Y0
CpUWtFiu+uA6+W0uP6m6f8a9ZK8jOhZ5zcnFmvOXXfM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 597       )
A5VZ+Rny0O6ZnxFP4sW1ZFmZhkkuNeIVGPRsA0inNKlu6Brvk/H+s7ZEOi9XTefn
/supjQAT/p4RzhNhUS7JsLs5uvu/50YFHnFIHJJLg4v1b5k2Xa3kIXmcJVnYwVwl
RWE6o8TzmldnpJWZiQhyfIeogHabtjGBPoN96bO7Eoyp+PJW3eRLInEdVDKXM41U
9Nm612lmVs4WdPxj+EIHAHNYJf1jV32AwCZM37+9b0CQP3o3QqCMa6B/D8ATKLaB
1DPG+wlH+YElry8vTaWkP0TbfiJbEUPe87sB6LdlIGk0LiCF/8VBGAlklINzK5f4
BPnS8JYPkkzTloHKzcK4EoyXD7vEUVS5lGGjZA8sMME=
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G1VZSD+iOaXbwBok8bDDcyYgjoRGgCinXfb8XW/804MRL746edRgRNwfdKsDWTHa
3gJh/8Rtl4eSwRGhUC4B/PEMm9ZMmmfYkmhvjPb0+s2oVsI38N/0E0evFaxe3Kko
nrWaFLv92Tyq0aODMfPOnAInChpt24H6olW4H75hCm8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1084      )
G8ewwkD6CyfRbMg0daFZCHVDTU7pHy/Z7hL33NQ9mFhwzlYWzx2cZz9LaPe5lrtQ
eVfVcE+sg8TI7O8zt56umriXaYcx1oF0Ec7Yv3xMI5JOKOEZT1OXhDplmgtF+nN4
32e3a3YjuZqOZShdMXFxim9LPSu8ObjHzmHe3Fa/zJ/sCLd3LI9ZFMpz8VwaTCRV
Jp/28DSiNVYtGUHMZwU6faPtgCBXKVfTyNEmYjpb2KI4T7XzwIL3KM6iUUv1GPwA
sUxOLJk7nQ2uMhgNkc8CddlZrFaEHM/BgXyyJqH2KY/zMZ1hJuMunSzTfHBmBHIp
W00O3TP79MM89kMPyz8OyiWwe2eVP+3U0Iietpmu0YPDybK7TGlEp4mbjBQbpNtZ
0yH2DMMPFLQgCg+YYNTni2G+1TK0bFq92WmeZ7XsNZcEwE+30gD8FabTuhiJ9+Io
tmRsATaZWVdPwoNxMhnn4l2M9P6tjECar25rkakT5gSESsIaCuhZOWkpFj3oUeF/
NBvqCT3qKOSXcRCUxjHRwItGdrV4s1EuplSrETNDIOaPFnT6s5sZkMzUJztVP2H5
tDXEMZTaBbbhrsYiEU3JnQEtRxCQcOQCfKhDoYImbqDeF8oGs6rzgcSf0DsBYqxf
DRYLq5wA6wirffe1F/O7Cw==
`pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NijSvfIJiQYO1lPUE2Qpnz0qfzMKDM3097kKySZeBmhfxpPzWXAFFa+wRMyEFVg9
IxGziN/RKhRd8lks5sSIdqbH+55tZT4R+Wgv2xShSjMSyDzyGQHlTkd+44zKOh9h
IhTJCNxqu8mwLZBa6EOqqMwvEQfgRU4BHfBwTRxAjJs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13177     )
+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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EO7IxEfUEwxWgo3q9dykfQEZLvQlGeX2SAyXGadzQqXlPtrIL+XMryr+BeCo+Uck
c/IZSE5UZhl6+LfWb/2cpch06kNogFtcDmpkMj9uPtBnq99ItM8/6ACzM5yw4v+m
Ef90mIhkxUT0ssZARG5McZxtdg7lgSTvy5iWb9DDgMk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13260     )
mk2QFeYf/JeUcNFnq4fTGUPV+vpE9t/0ZjF9pMvA9J4RSyMSkxLzgcRGX1JhPeMP
7K3Ty1QklpHjtbqiyxouTnIOxqwNGyh4NNA5/CEPZnM/UJTmFbRxt5shmusRec24
`pragma protect end_protected
