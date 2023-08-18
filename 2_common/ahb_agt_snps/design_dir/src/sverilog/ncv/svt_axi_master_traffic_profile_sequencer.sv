`ifndef GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV
`define GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_traffic_profile_sequencer extends svt_sequencer#(svt_axi_traffic_profile_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_traffic_profile_sequencer)

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
 extern function new (string name, `SVT_XVM(component) parent);

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

endclass: svt_axi_master_traffic_profile_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F7lUM8c9ttZfhTrwregJ7JlykpKpefUegxvv8Cqevvt5ceSuBsTR6Nu+NN2EZiHP
y3bAyiaVRQhZiaAkWrbzTBEDpneXbp8ok87kKPke/V03uT9b+C1QVTLx0j0oZvfF
atNqIZKy9AbUQnmI62RCQt8qX0LPOWnBc6z+eyRG8g5cpNcB/AyBsg==
//pragma protect end_key_block
//pragma protect digest_block
zOT4hd6g/48B/CkyIq7Dqt0AwIs=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
7dB/ImKqKdzGfRo5Rs+/P/k8jO4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV

