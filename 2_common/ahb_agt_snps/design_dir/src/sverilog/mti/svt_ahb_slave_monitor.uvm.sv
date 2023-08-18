
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dm+X6HxbI0DQVOOXwFPjtTeOCCs/uDYIo6qdlBjIqj5vRTYhpa2K0Atpvjf32K7o
CUP/mhofLceb2DQALHNOL+Nh7LqY7kD6kw024ALurnYSBSbvACx1YDlN7wmZ3dE3
IQ4pkzWriBYxM/ImRtak8PQ2W5qGJ7aczkKGRETUu58=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 392       )
pDSw3f0SNYEzIAbfGp9lmRcfB/sWUboowYSGlZSXJnZFggaInBnCh2QflI2i2k+i
jmS6zy9Wa1+yKYSr558WgBRZ2hrY4pjxm3j+UH2q0db1ES/JFj6P+Or7axekbZx2
zX+iH9kYyrAwdXQX+ukwVQvfbAqXhe29rrPZr+yOJFLO/+lckWM5KQ6q+S9qQbD7
0ZX0AS9ic6rm/o5h4de3/98WC/Jf3ZLObHr2UTwgFb7Qyw+VVz4spX7UEym+ANPs
JoWgl8cEM5xijBQTAWeQYO13nAUgsZC/ezMpsfuU4W+0tENh54v90YiWak1cwdot
4UvuINb2vihC14sK8sLxop3l7kceRpgRTqhW8gT0fx1tVWDM8tRAfieaYw0ZY3ZA
kYyY/misjuEUukfAfUNh4aMsAbFy3GvgXXIOFNxRtl/2sgKFvpbEkM6WNyFonC+5
iv70agxoy9CnsaCZr5Z4zYY6mIPfrlqoLRamib+iK+v6/NPIXPfCKywkXGPy1Mkw
/Ia/yTPzqHGLXXCHMHGrTw==
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dFkza6h3Ox7LUx7HOQBY/uStR6rpt6+RAU+WAE0Cfpipe8FFcvU1cA4CxLcwD6pS
+7T5NZpfJMsUW+Rcwm3SDX5nLXX8LmMxfKLJDJRhDXO6KZx5UlAbgiyoLx/UV2sI
4pMKxwdQxQk1XvyLEl2yWWU5Md96eyf/o7YJet2iYIw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 646       )
YOLlfS8pWlrJh7tNszsRIUznDhQKDXeMx3v5cFWhM9lPQhvEXnBeQGgJUhsybJbL
3qR4lfaGwcFY5d3Js/bnPEU70XmG0r4UzESsmUmFPInowWUE9QE30Y9SNcFrWXr6
iqh8VfeZu8kbzb2/srTalBa/4bh+IfxrAMmjxJxnkl1JtycI8GHY+/AYHBTBpVAy
YG4OHw5SlAqKhnXLYdjJaZgpYe7GRTogZtRip0aCiDy4pU2ZEc6pNPzc4Om87tw4
TR7pKjwRU+qav0R5ktwZWfAMKtNP6pgq6EFTA+ekTITIDW5WuO/x/rrICi8KySzI
4q+i1PD9xuq8qlA7KpF2VA==
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
I+e2o8e1hStzXQtkbtE4wMqD5WUc1G6PyH/F2dI4WJiOh5mn7ubqhFDfYZVmn+bT
sGQRU1ey2G3yPTbM8jysrUHOu7C/59ShGF6mZWxjT+4iYTX2llPtq/PByyJuhknU
jkazy1F2ihOdM1RmGXeb+mwNXcI/cdl1lBT+SVgSDIE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1074      )
RyO6Y3nVOIHCWznfFZEoHRbPtWSWd6h77lcKD42X4JfViyYslmNVYnj7W0+Sl9ug
06GcyzYdkVZR+3Bz/5OaGS2WwLXhCW2m0lyCEoRAp6Y3EhvzD7NBMkO6tpOZBXQb
lbIM6sxcempJnyt/p9kh3wKRQdeJWE0HDqsF456lC3MjTutk2U9N5SmjCUMAeoJV
gWvpJ430WjpadZDJZwKIjTa1h9jTxahJLeYz6Bx/lqWiYKUxmEVc7BzBYF1EiaWl
Hr+cEf/Tvncj/I55G1k6+I4qE1B4DnDSun0nowaFuAcpiAG0+MaSe4AMHaAIl7Pc
UIoEITYdII26IUtN3bNwaLD4aM3WMw+jd6ONOpEfdvSzDRHtt+17WfgtpdYxj/tg
eVBOJsA6Pk+QXxJd42F1AvOxqY+mF3DXZZKhVHEO2iWdkw/Fa0mQei4SEcIzXqUk
QdkZZyOrtLds5hVZHus2oouDoYGYgPt2TdI1mSRDjUSCIUED02213TKRixrGBKBJ
BY1gPiQ/tKgDC1y6VhHydhePcsJEg5/qhE+5Gq6XuZybWIDSZ4m1kS1qzS3QE9+e
`pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e3Hsz+75TewSGZJyNwneRP4Eimzz6PQINSxFXuPU25S7vGTsOENbK4zGjtROz7HI
2T51ebasy6d9A+n/TzfhJyaXUImWSAfc/1bojuRPJI2pmj4zIGxYBw/6NID+ZmuJ
6LER4SrHSDCuz77+ARpp8AongwodPDKcTEZUZoxnpKQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13364     )
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
NFb1ozu4JDN/4NBlvPQ1Qg==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
R4Tc+thHY3QSHZnviAdxQctJPewLOotFBZpgZau3kyBjchK8TVrATkK6NkqU587v
+p2iTuu8aCg5z//NZIHr/8+P635bH4mh2DZ3LxmjUtM0iB8IeNLczDN2CXcTpKwy
fbRh8IswA9BvyCkP3u1Yq4XRzukBiMotubyDJ+mDaAs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13447     )
WIehd8pGq20hLtuwxYWwD2I+eBsNncnlbtC54TV+OLFWVTTQbAzSrCQBt6vnchbB
b3TUJtmFKLQhxw9SuunYhuqbcLPRJ4yv4f+4xCEqNSK2mualG5l8frIK+VXsboOf
`pragma protect end_protected
