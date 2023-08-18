//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_sn_transaction_sequencer;
typedef class svt_chi_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_sn_transaction responses
 */
class svt_chi_sn_transaction_sequencer extends svt_sequencer#(svt_chi_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port for completed transactions reported by the monitor */
  `SVT_XVM(analysis_imp) #(svt_chi_transaction, svt_chi_sn_transaction_sequencer) ap;

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hk5hktyLYY2ePdC2JDu9eQvmtxxq+H4k8DtyKgNWsDLMMF4oTJyMk6Udl8rDqLmQ
gJg6FRXca6Fs89AlIby7wR1/gGafT8Q5ltXgh4a+hUge2nVTRq127+o7cBOo5KV2
HXOw/j36xbRmAPMNur2G69qK3Um+fQkVmXzcipenmDU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 334       )
xL6vb1Nm1l7MN4zIuiniFn66+54O6kXNidPNvFisO0DU3GLNYqvUXvTho7zSldkF
5YNaFP7N+q1mqdOhoO5j1ydNyZtBvdUST6S2EGFgoClxR5dwY8SQtcrWxaQlEWdW
8h4e81dotremqABN6wzWdTEwXRyFTuIMS+AZ1hUDccCnEG9nY96DL+VXRhYlujUP
d/RSGZGjWpEjVkMtMlqC/Pa6OpqUzjqA6RrHvlp0Otx/5HlSSeJ+A3aZvz2fNlkw
DXMYpzFADs6ZA/DUKEXPl1PjAxKb9ATLna4imVy7fQ+9zSSLOiv466n+/TmmKaTh
/7AULUgNiEKQ5onQZSMdEvazacO+aj49Sd27w7sFB31XHOHBX1I2BPB+YBp+Px4L
OrW0cX4evM8OKvTlDi+tAAJ3aeZYMV3piFgDznXmkjIjpHGJWa2rMRMu1B16cLYn
`pragma protect end_protected

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_sn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

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

endclass: svt_chi_sn_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hWDMaoW041pqY8o5qC4+Luvo2O9+whmDpzo/NPj8saKtzt/qeDwZvPMP+fsOtw1y
SvOsQmtQiJ6fGfNGkEve+R6zLPhcKLHUvUJuojIfEW45bwpm3U6lnX0L/QVeizI0
RHqejNHDxLBbb4w+YJ9ik9YtTMfgDlk5JJnmc+O8kh8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 767       )
ez7fDigG4XJ4UfJSuMwc5tuKSjipbm86kR5xux/UhdVF/IGfEIQ0z55nrDxyU3Yy
+/OKuu6M3Wa2LoOz6hBWE0nTmefjCV9QXNPS+Y6CkHXKeYgJ5Gs5iiL3kd9OvtDD
HHiIhwNPTLQqx4iiQbVtA9R71jzdlKMkMItX8eAKYr1u86lCELYELeY2FlslzOP0
FMFTn0vUAcEoGhCRKwO6+Ye6nFnd/uHpIII2qOREB0OOF+dmr+8B7DnbGypnMKGc
jV9fTSGCMB94++mrpPe7VPeGDKdQNkjLJS2uoCZCzOfXFjMcLdV8/aUuc08QRIhE
H394fX5r9cvbX6VQaPaUDEQZ8qt5sCp9UTgDQUDSRbbBzs1uRot7FsmtZqI6DGrz
v4L3y9bFnDMirRLl7AOeh2R1sKGy8pYgSTvHyI+2IFLy06NO9UMG+rmoWVhmGpzA
xy3sBAMIhzva+kxw+gp3jTFMBYEXsg0qWJYNGPxxfoivOqUoGEWReY7oEkFqARXx
F1mAlmNdjE7vODOhLTjNWwJFZrAH8POvGJG5pzqdNjpyhOtbH4uxB+FccYqkTSQj
PgCyAYLVg+Ac1WilePoPiw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OKHEm2pEGefxQWdUMla7GKpbKimmSITebZzRFTlRejKv9EF//rOReN7VwlbCSCO4
nGKukB4tXNaHgPurOsaa8YeXOATK7LSz0MQBE3HvV+vV8WG9GDYsPaKGcXHTfjLp
S+aegDjY2/41CWTFMwZVNXSDSbNllRy9aeGVQGX2NI0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2885      )
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
DcSHXeF3kIh0Wfm8+uu2cA==
`pragma protect end_protected

`endif // GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hVzjLdOduzdamhnUvV1LM/8MooSRLqGgIEPRcPWkgmolkpoOZOWx/QcBWlkrpxpX
f2F2klBD2q/B48NTVmewP0xqqK3BjdTkDBVRW2IBOB00+YBeMARiWgEz1yJLewAG
ILBxLfsnaefeGMlOfLJ+m59wU0Byn20Ub8eOuvMW3Xs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2968      )
rRXpAfcN6W2cpuUIfg0xOuv+NiojjytTtytOTUvE4NfVyZqcomS4MsTllTFmfJIb
s7wCryFKUJEvEhbg0FAQQFatzjyp7atJqP8rQwDLLkznrVlPmgtjfKHp72K5x8BR
`pragma protect end_protected
