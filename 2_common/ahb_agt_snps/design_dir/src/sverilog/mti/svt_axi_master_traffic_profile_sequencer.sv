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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CjTiqe4ObLfTGhwZe8wlHyLopwsvthkrqLTPXGYlAWlO1nTRSJTDEKPlUuGdR0QY
AXwzFhxOrVnR8WFKWJ6S0+gdXFv0P3tepmv9qSDN6UYBp6mXxJHV6imsPMuZmrXu
WAO0akzLfgepiblEyl2d7KBrQm9Aoaua/DUjsPpz0Lg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2282      )
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
`pragma protect end_protected

`endif // GUARD_AXI_MASTER_TRAFFIC_PROFILE_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cVouZeqjX17HiHxJJl6QB++rKsZbEBsdtQoDbwnSA9xLkJEaezA4UPfRoagkEaco
0WQJ4u8D51Nfwd/kxhKETa7mI4P8UTNehTMrhQxS9kew/B4ADlfhoQdO6OCLJVAG
cdXl/c1L6s/Kn76c+aYpPuqFcDQw1hMcBCI/lSdNRzY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2365      )
jw7eKGTkbibh+9hTEnpqJYXBtvySbV6wn/khN+bUJvUsaETyaICHHyxP/FlsDtOD
hWjWOdh8n4P5WhkCJ3rtnLz/6Szg/jjRkKuk/f5REuKcaaVjHrHFwOAyJZJYhnAD
`pragma protect end_protected
