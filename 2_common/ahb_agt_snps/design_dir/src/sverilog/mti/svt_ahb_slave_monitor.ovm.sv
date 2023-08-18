
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
mUhJOs+r7FWpgy0hqMXOB7vG9wpqB8iQSU7gvd4naMcUXq9UVNHBPu3a/bRF5/2V
BlFK0wOOew6pHL7ljpjdWih+garmVGPxWMFpk41/p9qUrdQ8GCxq/CeoeY/f6GJ8
DkjfITgcyc/kcr5KVZkgTcusAHgn7HwKvyb/cGD4szs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 392       )
GjqqAWaZGODcNNnN7UwnhU/qLGlLuCJmhAADaR0CFOCm3hoUGWfPbXko1VxVJ4vZ
flt4kFI1aBxtKcFzGHU9X/Grti4SvRO/R83l0IOevXuPpj9TXi9GmJnpu+FO/Kjf
NaLLF/Fz/UPLaK9lmcXnvZHrXboaS1PRjVzNE6ZwRLfN0M3UFPQEoZXdyB8Fhpw0
d8JV7K8Ki74+Di2fA7KgHij5wOdjmxHCyngo7DGQPZBLuIAu/an5VwrcbBiIvRcT
pTzQHK8pg8A7jeGxaIYGqr74L912ChPSy13O98Halg1/Tgi3qGL5Er68vI2fwSAt
xCNrWTICz5oqVMXhEf9WgUibvMB7AM0fOP5r2dTSSOVGFe1wcOMlbY1BXunnYLKi
Kc/oMSp4g/NTbar91NAfoWYTIR9InPbvY0kgwJyi8TB3cXp2jdwrNM3WYwM419qd
AvM9DKY5vEK0MwzPqVGoVbEV6RcTygFKSyvet3G55H0AqPNFgXVw+o7mvubqad1K
YcjFWULC/agaHuiK+sjw5A==
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
RxDNbCKc9eEr4HiovQxSyFmrqmjEkIQ7PTgVmbP2aT6d6icVJceCTHd5+RFrquH2
NVVF0zdjrlFh4GPEwbSC+zG2HQ05zfreRysDLDXtm/E1LTTdRmi0kT9fWoA22oSk
fBfavYhJFLmhNDQqiVgrL+WpVC5CYUJpQGedSuGRN88=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 646       )
Lh5gSRnGBJG1ZbP58kmNRuyIPTVLgJ9BJsIvroI+dreR0nt1KFA9YcOeQclWrDhJ
owQIb+gFu7IoaaFirjmFgJlMIiKh9/JaFcZqjtsBfbQTn3suP/SXX0LflcZaIhmM
9NsKtOOM2vXbiuYlOIMQoJ067ntrLvWj8V0i2DcRm9S2/swLJcEb5jEfm8Zq/3p5
eu8RzoTPNZLVSMeCmSBTq6kSIIpYdHfxbk4cwA0xxShq2Da3XO3Ys5rBggLzvYKo
QrGWJ/VlIgQOqDGMDgKNJ8av858XaomEmDqDHWZVN4T4XRjV+lEAEK5hDp6g5xyf
iKSkEIViU0NLC7bLj5tDFQ==
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
d4hiPQuCrcWK3bo44eNG8d4wf7+f9G557VpMAdyVAF44mZ64sndNafIynZhvuMCB
TVMmB/CBbgODLbnf1Shjq96/3k4xVyIgGD0J7mDFi8gUSgR6c+k/Owf8O/iKA6hr
tkWzQcgudRVH5lgHdZUVL3yGbCMitbUKcZC1b4Mh/v8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1074      )
KQL1ic8DRhnGJn+krc0ekaPo3dS36ZR4obs1jqsMr+r87IkPkDlLrjGBFSP7Mfkv
pnc+71k9OUCI1b1Og+c+W0DGnj+TyF1+NuYQLxJp23tDbAlMGONGT9s1Ia0GLTqr
sOJThtguYJThfiF1H5SQsDtVhp8u2U2oWRG+1LENuzo7ETwlx6ylVry2oCu+uvek
mJ+YOFNoywod4/q00ikx+d8zi3Aoo92ff3Yg6xSEdMzQjsDLcCVAnQ8pyV4fsoXd
xb/qjgdMEpuorpBvW7MnrLw9E6s9LAeAqilqVIEUkyI+SRlnbaxbr7+1jR9SWXAY
T1rYJ6EuF3zj7w2vPxJnZg2HB5Vx/MOHbdUbPxotTnu48bf9SBsGLlcE2oC60ByA
QkrojR4+UHzVja6XhYuVgM2vB1MK5b/qyQwQGcX5K5Re0Z3zc8QCFG1KnUKW0xJI
jMp4CT2htP98GuI1avnGcpiclVwsGJOSSNV9urNXJqwS4A4gnxjkYXED3eP/b1ty
U0TIzFZGINd7UF5cTJpKRAcfmWtm5b39il28AWoHnX+mYistwRs1oUd7DReQyJky
`pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SsxhOzWkDMGoGa2V+hh9zAf5FJyj/muXc8jVqsw7/nFHg/q0RrDzSYleqFk88Jcd
ku+KbVxWy8DwZ2YJrZmsQoD5eWvSEAa7XnxRp/Ywz44DCpWhd0tGuQtgzqkqYlBr
+UpgRjBXOV5wsMoIbYsczDCfo2+JevzcWod406BwNMw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13364     )
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
k9Fif5LlrKsmqM1PgJWlbQ==
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gntbcZhbRVMMDFcMMubXHrVHXwDtLyL+vV99QYcsjBU+v0U+Li6vVoGTAnZClUxO
8MObrtG3jp0aOCgRSdTQoMG7j1OeRL4FE7HwKom/k25cLYuLwESkgIa1Zzb2W9wu
6DKC1ofUdDOMTPSFiSCUIN0+fDn2pQl6go++M47EzXg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13447     )
c86XHkUqcrhLM/p1EEH6AisAYfw0cEIqNev3rfZN2PJmV09druCWbV6hbkDY6hZy
lEJ+2pMu9YxdB6uhXyUCaO5Rz+MqOzUU+msETBbuQc7j8VYFCNi5MobnHGCjWyPf
`pragma protect end_protected
