`ifndef GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV
`define GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_chi_rn_protocol class. The #svt_chi_rn_agent class is responsible
 * for connecting this sequencer to the protocol layer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_chi_rn_traffic_profile_sequencer extends svt_sequencer#(svt_chi_traffic_profile_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_chi_rn_traffic_profile_sequencer)

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

endclass: svt_chi_rn_traffic_profile_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fOm/iSHZq3Gjaw4mQon46sEvfvxsE0Sjpr+FGCVJZaGZOu4I2cg6LG83YMtiSxW5
NVQy6hk8JCKdfEV1UIYbQaiDXZtPl4BqMDH/riNHRH2jv8IF9n0Id05dxVCiHBu+
FCV6hpMdBAe5Z1bnrgDQ1u8zpn2knUA9B5r4HVO9LA1CDYsIw2LYpg==
//pragma protect end_key_block
//pragma protect digest_block
eqPkEoAynO23wuAZXWkBzMh7WeA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
J90gTIbreFKB2OGsdcOIhQnO4ls=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV

