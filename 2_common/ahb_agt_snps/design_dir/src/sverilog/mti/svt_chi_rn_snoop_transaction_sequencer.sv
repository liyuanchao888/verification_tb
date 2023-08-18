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

`ifndef GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV 

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_rn_snoop_transaction responses
 */
class svt_chi_rn_snoop_transaction_sequencer extends svt_sequencer#(svt_chi_rn_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
j1ngqKvnwJtNUpi2Dd6I33UKhlTbQ0KPnvIOtXccULQnK4MKFnVE45BQlCY7rYRq
XyvdTh0eKDBjC72O2fauXTH4GTAEVMbuxTtbUCtiQOlXxI3w7vSx2kjvzKBVoSll
vhwowMKOIfNQ6nzSg2TbBlj9E1v8d4WwVjd2DyVvw+A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 270       )
IaNhGsALvtyWmAWNhOqxuSYzo9+RuMrb3eOVBJBzg1N9gaZhS7WYJSpqACTNqtO4
nzzctvmxG+1zpZW7TFi/B6bhCTxDzEhA3cfQKDXsSf70sxjNbosuWYf3XZl2j7WB
cOFhvYcbZxoPxW+xFw8rO9wM8s6BgCXttBl/uy+qtPE0REb7mxySo3XzPvYgQWL1
ShnTMRngXci/ebJVjAwvu9ysPaaKPURkTxS4HL3pn8COX7/OL/yKBb1TWSWuV8nO
c3+mUXwTr6pf9rHpYrjIQ61yny94Fw8vjGk/l+r64eS8+SQWsuwAjXSdKerF4wA6
L9FfMN5b2DJzKddH852cyQ3SEfpvehniMyz31TH8/Ow=
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
  `svt_xvm_component_utils_begin(svt_chi_rn_snoop_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
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

endclass: svt_chi_rn_snoop_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SxoAU7cDecHY80fBDl0CRjOmpRIbtTdvLv9BD4F/vpIRxbTeW3/KR6VIcRPuQzph
TQ05nnMdHKRMefj3D/GwXgolMS9WsuZiGv8ZzPp2Q2KER+UhCLILBsORDmYkSoLG
/YlzrPlJJw/o5MqoYYnDqH+wVNmiwZSZU0KJh/6XAQY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 692       )
tLa1Ah6S2qsk2ZKoa9NmiyvX5PsSfK7c5Ag66tzpNz1fGL3zfwX9sUUt40oru9W+
BmmTfIyhjPQbXI1R54LH7Z4aD/LPNRhG/kG4E77yBzt/LPqo8I18VHOrRlkw2hbV
UzjkMLcBRmcgvu2yCLDZrHMVEGvui5xapYAPSoisObYZX2g+n8zqFzf9QSa0lQXN
G4OSAINeXLfdgYs+eJBrj8QGdAvneAxoNGZyluV4IRPqxbAqahpzf/Olido0EiPA
XNl82sZUQvVxPclILfuItNHC6wqZkS9S4KN4viQBZqY15uVASgXpso8jhqtT0o/9
ELntLLB5e06MQI/LJ18y20mdf5TMJfWAw54KF7Vb+YM1WWb0gC9Hggqk+JgVLTtB
q8N2QrqJkq15TthgRD4NO9xqrMswV5c4DXBvT8yi5B/ksI6Vv69Rsc5WDVs0wKJX
5iGYNN12EqEJNc71FZQrb6Gzfmmu7x87p2tZP12El6pSkAyAa07/IMSRJpS9p5Hz
bVxgNaKp3I83z7eH3oFoR2xiK4mglCqzZpbxskEvjnPxLTRJCMF6t8E9eTyDwu4D
`pragma protect end_protected 

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CdNjM10dFYDSJh2OlbYGAONnw2w4Tt1Qi4BN2t7RB16XoBDh+HnW1B4uY1j6QMGf
8mK8c3RSayBcnjSm0dIwOrCD5hhR7NiBkBmYyRHQk3Lq6B4fEqvobS12O9ZC+vAZ
pv+YPevoh8kfU/16gGEw3cfAAkM9hbts/j4QZJE99Jc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2599      )
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
`pragma protect end_protected

`endif // GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bQajxkoXIKEYHHBkxyN7w1Bl5tUENBLNCjod41AR4fy6vL+cQWTgGq0P2qQAhB/g
63cH+AWopobPOuG5ZzKTf8zBKIkpADrZ3fkwRqT5WlZjRh/PARe7xC2BTrll66QY
dSP5WKg+JScFRIW2hphUk2BV5KjfhlOgFBmHmtkD4NQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2682      )
H7lm4G8T4hCQv028TU1bL/IWv4nEC3TfW4IY+W9zx1pP3rOeP5D4qJPPlPLXyR7k
kX01aF8LNgMM/Q8Cbjqxe0OaAGnusMlj38/6VxAV9TC8woYOBmnzlhOkTjVYhDK+
`pragma protect end_protected
