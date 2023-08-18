
`ifndef GUARD_AXI_SLAVE_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_sequencer extends svt_sequencer #(`SVT_AXI_SLAVE_TRANSACTION_TYPE);

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
  uvm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
`endif


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  `SVT_AXI_SLAVE_TRANSACTION_TYPE vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_sequencer)

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
  extern  virtual task put(input `SVT_AXI_SLAVE_TRANSACTION_TYPE t);
endclass: svt_axi_slave_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
9eff6JyLmPhyzv5xBIy2Oe5hFXuXNFgD6A5+m7xXLU5KZTnctLNEA3HVl9JqzTm5
R6On33wv6jrYxf/C3w8kqPSZ8sUvb2/6GlxUZJt5Fa1wvZCZhN8E803PZq8Cf2j/
5wwecyqiy4U7R3YEbEz7rM6Sr6xhiiKdKygssiw0NQ8DkJSopKoWRw==
//pragma protect end_key_block
//pragma protect digest_block
knAzKX9nI1BRg+UWyueJMJc6+2E=
//pragma protect end_digest_block
//pragma protect data_block
yJQRAusoxR2YhN+A1U+sxR3BT4RXnWN8rPan3Z4xGl3VJpauHOKAi3FJTu/Hb1P/
EPyO8wWEzacZIegkoKfLxuF5ZVW1tkU308Pmxvqd61zgAgSyJ7fsah5/SmVYH4A7
OpzUbasqTOVIvGScMEwxFEQ6ncLHPy09y+O06T7/+Z4q0Zt1KkmUXjeW7epPANin
TqZQZDO5KduhEohbAAt1++NNtBPhimKIa1R9+uJj9gKiwYJum1vZdsok/WEhetM3
/m/4ECPR8eTK3PEZiuPjNZTlQ+D6apr+SoUheDtLkm6JCSOe2cLtxMSHnBRJ1f2O
VfQ1NiJGQ2M1nEtPeonUC6H247t6gap6JQu0TEc6mDiPuHr4VUnaAU4zJhUEM2zW
SPK3bKeipsKNb+ehzCje08B4u/fd3OAJIdIgML2G//PpBJcBsETqQi9DqS7Rl+Wl
AU4BnF2YiUaYoYYz18PyGllQ2Iaix8N1N3B4di6PPkm0cbawzeR22eQl44fsPK5+
ighUwsCtttI+ie9DM1ZafFTFtYDf47zgYk+/NbQdNKyvJZRV1uj+DmUN/4K1hcKh
h9CKi6BPSIzz476X6lM25m7rUc3OfBUZhIg59MM+OHbTcM8PyEanvTzHV7xqt2b9
NESThFs9XAj2KLs5nvYTBPvyDgkKwRUYn16MEAUoQY2e+4xNkNtdbCKHADCQc2L2
WahtjjXPgCsEH/E5kll5K8IoRCwzjkFhbDFRrzJfNW4TIbjAdRQtqEeqbF9T7h04
m3AbWZfVmfZ53R2EoqL9V1CdGRWAjJupQh1D1laz0+B+TKIjbgNjdFDFxtC4mnB7
zwz1EVb2ZyaNFzr2QqtmenLBePG/n6MNYMseN4K8eI0Qip8kMtptRNR8lQEmLEtq
8EtHiDhRZeFdkiYbJDrqDKA2E7qe+vMrxonY7CEb6pFA7R3y4+UlMyNULhtlxDh+
azSLofqyc18cFbFpSXcmCxtfjs1a3mscA+ZRoLo23kfUHrFJOBRFpb0WomScAgLw
DfFTHo8ulWRrHzpobOCzPg==
//pragma protect end_data_block
//pragma protect digest_block
J9dRp/3fHQPijwAdaiNtZZCrljU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1V1Xqekpz8c51BJioCSL2UScwRfS4HKIrONwcb3hVJ2JQPnXDtFTKobnmR4hMSzC
PFzcAMeWhM+DlQx1L2GDoJYzxYCuYCGwveyAWB00gNQP66EzDbzCFYYM+Ja2i2i8
d3MbEX9Rbjpf8Vvv5Af2DcDeJd0xk9Yb7RvpuPyAok+Zq3Tx6PDUQA==
//pragma protect end_key_block
//pragma protect digest_block
Vtas1475owkK9buSRjlT7qlD54s=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
4Z//93R6XsD++B1ecMstVBiXK6w=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AXI_SLAVE_SEQUENCER_SV

