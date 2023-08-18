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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
awjEpQPuaUtLI3J7tQAZNn0Fr3S2ub7YCVYgec88IrvvYIh14CuE/lwipNiKgPZs
pqRju/8RpxnyAU4SClM9oGa52mQDcK5L7PNT6oD8T+lcEOSKCiqzNFCZDxkPfFzL
9hZ0vh9w+PT65GLl9GqKs0qVjL5zuyV9s2BFPy6rFy8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2258      )
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
Op8/BSZsuCKgGvzd3xATVA==
`pragma protect end_protected

`endif // GUARD_CHI_RN_TRAFFIC_PROFILE_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PB1j1rmXXm8MZ29QHHzrzQdEsupWkuT20G1pV/TU3DDxAWWdCipyb3kj+0VyyQYr
3jr/sABG6FdEsgbHGdlZ+QDANTTEilv+a/X+smQMpf/Uoq/+RgqgMqXn18GBKJ7G
47WLAgNs7HTukrOYIwlFBpqZx57Pyhhys6XfVNmHWzM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2341      )
eV0OA31ztDXurFQpxTZf8Vtk49iiZ+hRD5DLp115kj17DuiN6qqJsuYTx0HG6HZm
dEIKlRlmuFONtbO7kgSzFydF5SBAr7tTxucYJsOACqj86LEVRvuT48qUlrcpZxXP
`pragma protect end_protected
