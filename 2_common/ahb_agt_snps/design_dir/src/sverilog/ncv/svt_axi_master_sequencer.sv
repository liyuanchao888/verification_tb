
`ifndef GUARD_AXI_MASTER_SEQUENCER_SV
`define GUARD_AXI_MASTER_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_axi_master_sequencer;
typedef class svt_axi_master_sequencer_callback;
typedef uvm_callbacks#(svt_axi_master_sequencer,svt_axi_master_sequencer_callback) svt_axi_master_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_sequencer extends svt_sequencer#(`SVT_AXI_MASTER_TRANSACTION_TYPE);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  `SVT_AXI_MASTER_TRANSACTION_TYPE vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
  uvm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   */
  extern  virtual  task put(input `SVT_AXI_MASTER_TRANSACTION_TYPE t);

endclass: svt_axi_master_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
g+QvI7DbvyWnx2DvIXkBI89KoEOYchszf+ngYiwobQD/75zppry4Gz9hS4BuYJH1
3LQGBXhh4HCMnwgGQnyz2KEwGNhBPbFYGWOGgjNj6x4QF75jJDaKZMCBbE28dpTw
Meop/2vLj8J5ECXxBbXMtqKwwRm+vv4WjeIAQd594xndYhHpyQqPMg==
//pragma protect end_key_block
//pragma protect digest_block
FG89zmvBAKnnBF7eDLCyzphj4sM=
//pragma protect end_digest_block
//pragma protect data_block
hjn5XR4HqA2aR3n/kXf2DSLIu2nsKdixpxzz9DFNv7Sb3M4frav05k8+Zc5dLJpO
ACw691ZOpCUIUCKAtBwcyiqJ+u1CbCQ87If5l96Aam4KxICmA0JCFeCReHHyjoI8
fY4QSaqJ0VqDROnNBnuv/L/jfIVOUeImBepNKm2OLBuM2KPZKrJ4FfY7LLoHmCOD
0Z3cqTKeB0URVijwElQU1sve+o7tl0aZhwbF9HM26lVpePF6uUyOmjKhOsoNsrkB
V2fOjk0Jcm/aJgWa7X3wYDvQgP7mz/iCNb2fKUnfRCRhcSp7uCP0pCFnRJqSOx/p
1cm7dHM1zVP8hSBKFPjQ5iMYQRSDDIMbFUXRSbph1DO4x4XZGcA14st2mODunm84
5U7JU7ot26HXW52+KKUhTsbl+atreSsjx0yztmc0nFDR/SYjvZllYJFHO8LoKqCt
sA92cfXgUdZB68RN6NtdziL+oYrD/D6lrEe8UNW8JoXA+aFUaGNdjm7ajEpnxfpe
dvOpVDtuo8aH/du5hBCrpQEvxAUhmF16Gztwngc3gPqfrrLNsXmJoTUqvdCt6+q3
fw8ZCbnHQ96OhHLuWADu/qSOmRHbXyp6xDlDsjFDFpDjZwtL3amXfo0V6+R49/D1
iJwrua6ysNVu6l1rrAPRPk24yMBNdiPhK+t+KpVNSTVtYM4riHMREDYMYXoP90/L
I2lwLivzI28nS6WV7SXURYTMYGXji9w30NZWsFB5xfqjr02JpAO+dB1tXEvRm1Ji
2qUbDBa+TfBITT6ZFLR32BewMacG5vlu6xgP4s950EKQi/LuWpFIgBifMv6SdInh
9pppCk5t/hbhEMMbUMyP3iisQdN9ZBSDI8cGYI4UjV8G1FI9gO/ilPHVlY3hyCh/
SlaOK6f7tbOu/zGbvceUH5cTMdJahBzvnVg6IxuAAXbUgmRR33mb8dObAbkSC9mo
hOaHfRXXVHjU4FIiws8Wspld8x/r4P8oukYqF8lXSxTl/At0EAhG2VKpUufDuM5J
+Scy7A6+j2xr4D9BgKI0VtXfE9pXzK6wJSUFvSRnCnfZTEXATgxgT2ut7Bcb/kZs
srPhn/izTUaFviQukofxarane4dsz9sSIdFOzuGHKNtTcJrLECwivd9r6LYOQ4Rc
nExjYT5maUWKufEbJgNFFIsfluvXLexbk5LRLOUSWLtCZct9CtH3cL+kBZ4dS4bk
S6ismdEPuzgzLXN3KSYJ7osRFx9Wb4cblTLUZ3OnAu1QrGe8K6TPkgh0a1jTVlzr
jzknO6KoUG761F2/wO1r7WXAga7T32Nk/zbz92cW7ffGpKvThTYghkaZUqdg+MPy
xZ3577yS8lvbK9dA9vmGu5SO1armYqVkIZsoqoPg1qCebJF9oLtyBS3a9yfJxKTy

//pragma protect end_data_block
//pragma protect digest_block
X/7nsOM8yU7QzsNTWAEZi3a4zUQ=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YFyKBlvkWXRgpFv7mNTL5OpUEavtGIJb/Apd6WEgTzq1pk3ED7lVUrfkezKMV0Au
pdRE+aI23oqKxHE7TMlrKo4q78S6ZA4qP0gUaijq0wVwC+dtUhAfln6KHVSdjPIP
sWiv7afTuWKyVDEXBDgMRHckh8CwRybaNCD95bBgeCEI5+Y85xx2WQ==
//pragma protect end_key_block
//pragma protect digest_block
p9ZnHp6deMe6nYHXljpAMlIUFI4=
//pragma protect end_digest_block
//pragma protect data_block
+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

//pragma protect end_data_block
//pragma protect digest_block
bCquEykbBF0Yp12u5L82h2OgizI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AXI_MASTER_SEQUENCER_SV

