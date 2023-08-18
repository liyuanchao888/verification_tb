
`ifndef GUARD_ATB_SLAVE_SEQUENCER_SV
`define GUARD_ATB_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_atb_slave_driver class. The #svt_atb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_atb_slave_sequencer extends svt_sequencer #(svt_atb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif

  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`endif

  /**
   * Flush Request Port provides transaction request from slave in order to drive 'afvalid'
   * signal independently without regualr slave response.
   */
  `ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `endif


`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`endif

  /** mailbox to store independent flush request from sequence */
  mailbox #(svt_atb_slave_transaction) flush_req_mbox;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_atb_port_configuration cfg;
  /** @endcond */

  svt_atb_slave_transaction vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_atb_slave_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE);
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_atb_slave_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE);
  `ovm_component_utils_end
`endif


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
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
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
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
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_atb_slave_transaction t);

  /** defines get method to get transaction from flush_request_imp port */
  extern  virtual task get(output svt_atb_slave_transaction t);

  /** defines try_get method to check transaction from flush_request_imp port */
  extern  virtual function bit try_get(output svt_atb_slave_transaction t);
endclass: svt_atb_slave_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Lr+Jbv7JchVtV5Mpu4phKYINWIVkG36y08jLSbwsLSnyUXN+a2AQd5Be9gOwl5cs
vHludVipZTdIDjaE549LMPWTlND97VP3L2mvaJOQSlmw5vNdbXW7FCRREiO4rXdN
GimNEBP3F7iaITCgZ8yHd3qRtb/qRyvojigaS3miNnWybb4tb0Lpyg==
//pragma protect end_key_block
//pragma protect digest_block
3wQipMQgE/YZndSUyLKaa28v2nE=
//pragma protect end_digest_block
//pragma protect data_block
8t42zQbQjkC4op++Lds8VLC6j1GzqFeqWUn8i81BnQKLOC2zAaHPfghBtLBGqc/C
69WcJODe6L7ICyFEVXdU+QWNmAp2wvE0h9fZq4RsiFd2AU3tXICiGSdbp62dniM+
LAVB4MKDd1uQhDWfVd4vFrQvjUdCbGwwRrG/6PFkl/8G5km+cLWIGVc4apdUOaG1
k5Ors21XLrFNcYDXetu277BQX3VxLBvIMzbTK6VfuJqVm1I2Q/DbDTeCq1KlxVVS
YFNqDfMiTK1I0kbuktCDhDtu5Dm/7NP/ARLTNz0CIqXphbrXw9OxyKKXjvTi1846
bY67nXLYsxbovOQsBwKW3gdDOncrVz7RVgrk72TFpn2u7fOX7so0+ezUjt5mC/tR
xo7C/o4sDgZOufDThGv64emKZEWA3VLx+u0mqRzKpzRrVp2/6H4iYTSkGrEAwNRv
zEE/2dhuSxs0n2g5Y5goFqqWWnqtsR7nVs1giL/YxRRCpXMpodnQ7HDOJwK0Tdz+
3ETh+TF7M0chBtUEEWGEzNlpyc5NSDOkOaaUWkGPsaCwl8ukn9gio+2JzGMc+ax9
eE/UgqQSdW8g90bXNFF0Ly/BGQY967RZ6Vxis16QKQ683h/XIyvdkTlbF23S6ST5
Pk6r1y1s2NHhCOYjDa9xDh2us47kgdrvrPxqwEsSKxsmCZ4joDQ70odlI8rIsSOp
DNB/enijufW64Lm0EttupTgv0k1bN8wiwdjMiEA+XDIGzLemlJmiAuzuu/KGYRfE
XQceymiWXgD2CAao4TfkYMv4k7xOPrkBeNvKbTMR+/IZfbgYltnpJV2O0rMhzzAQ
8mChm2vO/X7hz+ao4Spt9HbLIn7XFU3wO0N0BvsHIZ3znP6nklUSJlmzD2YYYaNF
6EfJSdD19VfiZkuxcH4bqfFSUmSRe+5oWj7qbl4K5gssPDlP067SbU7f8QtpJ9hH
DeyzyeE89GMEtQYxqaqmtMEXeIauKhqN8p9X75SMnHbU2QyGGL1mluVCFWiGRBtp
GKVukQJ8fzBYR1G5XtHc/mWRsSX3fuimgSxUBvFy4H8h+UUDdsr4RfMSu+uIy1WO
5fWFRg59oNAyd2iYi4jZ1NnwPChSW5j6Xgq8lRmZuvR37eBZI0xeQebaKeMY1Ocu

//pragma protect end_data_block
//pragma protect digest_block
hagI9MOO2J3PtxLelCFeWunIckc=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gLWgIIRgGOh8S7+jaAP8lA+99Skk4HpnN7rg9sFYnWHFiCqzwQUGEBlYEP+Sl8UD
BGM9yAGvi5NdebfmnZ9NpPBt6LV/6wfyGxu/kUTNIaW2oc450/3MGluSkJfwjWi0
xuKYdruCx8ExwxzRHFzkQ2cynzFnpXfeSGuiwdlzEdLmON9vnHUBzA==
//pragma protect end_key_block
//pragma protect digest_block
LTe/jIZTaBBf+fxcIOA0NTPz74s=
//pragma protect end_digest_block
//pragma protect data_block
+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
//pragma protect end_data_block
//pragma protect digest_block
MUMy51ixmcKQcJk+U2aOWPh+1eE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_ATB_SLAVE_SEQUENCER_SV

