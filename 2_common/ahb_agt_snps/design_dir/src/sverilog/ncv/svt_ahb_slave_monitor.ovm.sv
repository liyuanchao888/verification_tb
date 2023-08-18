
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
JXVmeib/GjgPx+7gbZVDygq9RVGZ6P97+ebHWvga2QBMob243V3KkdhToms12JzC
7/wKgdqA9/X3Ajd+0Uqj8Y0S2XG3JR4pCEMK+ra1VXV2ZSoZl3ks/W/fv1iXhzEP
j1yQgxriow1vmyv528Pxb8AjgjeFXXV5e1C3VkW1V6RYVvT61j6Ezg==
//pragma protect end_key_block
//pragma protect digest_block
i5GIQzp1HeBR1eRkmH3Vs8uFXyc=
//pragma protect end_digest_block
//pragma protect data_block
ODk7kZ2ntae09Jso5SZSNKBadvGBiyTkxZY2KnXIOgSlvfhK5vh5vCnQkTYA2srG
uLZ72ors8RN0/NoncloSLixBcqPnFk9khbnDNimpnc4QdmOCbimhKPJTq9+cuOcA
gqpWe/rXt73DLFXrC6M8VgBL8Qm1DjZbyi4NCCKsoEb/zh7kREBVkmjOxigkQxb6
xMR8luT5W6stkFt5pBKOJykdMgc7A8/GvphdBgGuMbImQ9BbkLpbpXlC/uiWrgwx
Lbi3oPKt/AkpfUsYW+vP7i4fMyWo9ZDqy/cfkvHlp8B3yCvg52ZKAh20hBguw8C/
mibO5alAOj+/l75xdQ7MBNhAcqZphhHVE2v6TfSUpCHSCY34bB4Ne3kDFyxOIM7R
c8qmDAVkNunwG76HDg7/ZaJtM5J9H5d05Q+xAPNxIJgqTw4Ppq96mkyxqyKn4dWf
Op9f/nmPyCKPhZXDkNOyqXVAbWu0dkF+7NeCiEQXAouqm7k17lWuTqhxnINvvQ5O
J2uAg90IFR7mWxJeCbSAFoMghS/Ue7prnV06ddv4PyKhDgBL7hnUuO48x5/6u4+d
OHIF1NiC5iQsgqELk6TkDrZdXeGrkZmotW5kb9RmRYSOZorLExDzxKH7ITFQBw6e
ASzhfawcyRWJN5dSJTe6wk6GkGLfQOGsPERc9Ko6p/Un9LhO//4lcIm+AJkufj2B
KgeGl0TZTHcqMM5j5DCbk3lDjJWM86N3kOoJ5RBkfmQ=
//pragma protect end_data_block
//pragma protect digest_block
UCOYWnr2CC/CAb9p//XJ+svF+8U=
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
ZciImLC9c64NLFU1XeRnQ8ruwHwrr/ZxGPGraKPpe+VRhsnQToiPREw4Yjg3gC2G
CwZbeG9kYZFMsBC8SHOZNXElTryLL9yk9BhGhn1NHQFURYNfvcIMFn4/nvuu+wh5
gqCMZcbDuU0uDvdW0m9Bg3fORaN/M3eWOch8ABZc5Qpjb4xCfSAkHA==
//pragma protect end_key_block
//pragma protect digest_block
ABrf0NsQyGTtGoHub9fd6xkJL6U=
//pragma protect end_digest_block
//pragma protect data_block
7pl3lmitVLxK9Ow5UYGlUA7/Q/oJ/MeBooeYoqDKUYAKQLjjvOiFxTzKgJ8Czfj7
w7gUn7UjTCJBt3CGMlq8IKbLLSSyB1PH3GSPYGgdKU4tkk0M9Zgz3iBhl/G15Fs1
BX98zlhWgzg0G3QzzD8TotMUKGznqS3+gs8rrSmZGp5j7mG0aNhswZkZwFI6KyoW
i2FwroDyp7svTMaOrIurBwibUUPg87gA1ykJk/s5vTZstq2Liw4TkhoQbWTtXB25
p9lm5gPqI13yyrZVb6/iyko9RHF2DFzQOghCObLP6zHxZ1q+WSmqOQbs5lMdZpY4
J6RMaovMgmwgQZksqzixlqK1i1I94kQyo7c7yeKJsyMVJ5B9RA6AA223r6tMmHlP
jc/hIMAbGybKdlCHs8qONm4BzIss90VDvMfj+WH8UJXGGpYFOHOpoB6MpUHeBGBH
HE+ty/E71lzJ4xg/MC672VWO7JvxEFp/lFhLrgpJSBqaciLn38rkPH+wNvJSA2xv
/PBtxndVHcsI5lVwbVgDsesr3QYekTc2RjeMXwKtWfh1RVrY8hlQgVifPB0pU69x

//pragma protect end_data_block
//pragma protect digest_block
iYv7WvUfpw5NO2wPytbH5GOiAwM=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
104py8lGDSrIr3LXQPHq0a7SIDmlnr2x1zFgYLVRvbZ3DjCxi2i8cvQxnfRZdiEF
lTlSzAv6sv62mgOafCj3H7v9QCZCmYbMdL/qxWNTfWqj3/hjPt58CRWo56pGYuwc
nkjDXW29+IUybhyJYfztfijKokMy5CnQxTxVQpxNoJ4UZEhVIuF2jg==
//pragma protect end_key_block
//pragma protect digest_block
9ZiIHI7vSzQUAE1GJOFA5ajiTJE=
//pragma protect end_digest_block
//pragma protect data_block
+VJxXu8x008HLn4MDVaQkOUftOBlIuOO41QM+ohW+0UshBslTuNV4b+NcC1H1ryw
vgbkqDxiFkF93h4hwc4HjemhYrGNAH5YbeoWhfEaAupMx3vrbzrGQX+/KjpuN1cb
unx3Gm9rQLY4fMF3L/Mi9wdm7SthBPRWgYZYF+neCPdUS+o4pMPxYeOLW4MYYJgs
RN/po709s050M4bV1ipRLTWvkDkzPLr8mEDS44l94oCnd+DDwlCvBVPZm9fpnCba
Caa2EwOuYqBgWLbR4/CABPbzWiRsTwiX7YUiBQJf5TVwbzt4i+YnlDdtutKnPbAA
+MBfRlZkOADdvuBbyZDxB+LFTY54uCc4xLPPCOMMUd9UEw05Jhp+AXPSlhKn+X8w
O/AbcplPCYBJe/Kvk9ud+VH3nTspNBVISCZxl9LzoIH1xpAmHWNUvqwEmONTeFGN
3o+FDr6ZXDRLNlJePDSeNkhYH36/T1FXxXz0GKJuUWimmABfHKqkgdyla4A/IhEE
WfmsLV+iAyrBzL8mGrYONJB4DCt+5M2E9gw+jm/U6HwXh7ZMhyAzFDEhQ8k68ZWs
qrou4wTmdQyvtTyg1jhb79XIXgoHrhAFELeiUWRlB7A687gFrrKNwCr9pLd4uJ/L
9Qu9YpIs2KBAsw/CtGvSsszPFlhcA2hxD838tJD73nXJxmPkv1fZhWz3PWvASFj1
avYqbxuYPoiLxrXN9BKP/MaWzcdfVP6yO7i9Tk5HpII3AA8g+cD5Am6fnjXHDhuG
jNVuAJw8cwF1pLYavEa2v56xlBhsxzZI3LwXFbRvhsQ=
//pragma protect end_data_block
//pragma protect digest_block
wve3GtUKInh6C2irkNSQVrRixzw=
//pragma protect end_digest_block
//pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5FsWF8deVNImQavGBSkrxVYcZyv468ptO8aqPyyRb7D6erKnl6Zu2PeU3n3maV8D
XqJeUyhBAnUbwDeQc6L+i3GOwhP1paaqLW9HEryhM/IXKPvu5rh3hhJrhmI4AYGu
30Xq0COoOL9zTTBA105FJZjo5Vo+wvsNuiRzdbDVo7m5qfHY14xIpA==
//pragma protect end_key_block
//pragma protect digest_block
wDyCg6u6cFBa7hjJz/0bdqydZps=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
RfJSc5nM+3VW8Fhegw60dIH1Jks=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_MONITOR_UVM_SV


