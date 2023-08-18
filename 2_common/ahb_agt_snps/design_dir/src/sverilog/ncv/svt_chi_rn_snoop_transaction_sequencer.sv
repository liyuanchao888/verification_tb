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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6LZiVkb+Pn78Du+rqyosmb0h9bpy3zboldog3CMfOQiEDiCtgyqm5tTg83A2eZvv
xj0iQSNMBxOvjxkCgHd6Y6uFR6bFoWKJKwWwOnalrbGrQ4NjtebKv1HfDq8IYqt9
ZFFTvSvasr2WS3MRgiZhwjNdew79IhinBYnLf3YXUsFBKmlw92qTQQ==
//pragma protect end_key_block
//pragma protect digest_block
BRUeiLnUE6PWvIlllpGs3qlSWiA=
//pragma protect end_digest_block
//pragma protect data_block
qQa09s9Dtbzq1dk7xWob4q/mqwXEnFVLfhIi104SyAijOmnRkOiTM2WltUf5rAs5
vBTtjvFUMWmVhYfRUomJpKtx6/LwJAi7wL3kRhBY/1x1vFHYL5U1L9JVNtslo4/x
sTOWhVS/mlGVh5UF1Q+BwaNM/MbkCEsfTW//lPa4eKXL9cpxt9m8YqKe6GuJjv5y
WhIYW9fTU0A/JySSJ8aCr0GEvxlSXZHw0KcjdRnB6RkCXulC15OSX7qmdrvdoKKN
+IndX5q0mEljUE+YKmrNOrRIAOOICwXJMM5ys+8qC+FQmQotA5AZoBlAMZsOaM3z
F5HKJe6tchBGjqYPznbl5ZLcfTxwteQC238gE9km5YTs5uEwPOKIcYRfRafyH9ir
3if0LiDOvz04DWgdoziBxlv5GsKZqR6B+ltgqNElualMLb/pbltf6fSno/K3Sh+U
U7NbZGS6GP7Cf/RorVKXC999UkBZ/tDs8NpdtZzl9d+4DvM4Q3VyVC25hNYmXwmj
psTlm6GJXvMYTq/ql30a/qZrwRpn6Vj/4NBPfsqkZZrFwETbv9Y/SMtJ3niwLdlW
YK52AKpbPOfHPQ/Kc0Z++A==
//pragma protect end_data_block
//pragma protect digest_block
826GCwyEkem+1qKA2GIRY4ZYBLU=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eDE60W1S75rEFGetzmhYCFFs9UdPrHYZErad1Dy0FTeZPbsCfD+hjlEvc1TMH1Bl
A9tDn6sNCHCtjuRu7AgJH+FSNApJGiwqLJbaxFewmZ+P2+vUKCmCEOIRrFXr1/ME
nQ+AcX5UhNtvMOmurSGBLR0pqqyFX0bz6CdJEAX+VxeZdQIJ7/Ub/w==
//pragma protect end_key_block
//pragma protect digest_block
ZC0GdZbX4vx7cUKi4gAdhUpAL6Y=
//pragma protect end_digest_block
//pragma protect data_block
6iVaekXyNs+eugRQNU3ly/x7CUFUPva3RYxl6McQ1FP/KFlYJDdTovI78zaxtFaM
sZ7t18D0w7KqAcnP1HcAmY8846WStsH5OpgWGdk5cWEvljcTzGR66cjGpuZeWe6i
l1b78iOnmdRPyRuYrm+MbXlW+gxkTw38YEyc+11J6Q0KgGS2y715dwDs7v0CKat6
eHgrg0CPLHLmsYn4Qa7OvnjkKH96OUomv7mmsvzbhe62e9lh/tULyjpZVHYxHTCt
ZaDr+aMebGB9UGXO+Tw5f+NaFG2krBDk74roJ1yK9EumR/JkPTukSf3XlTe/EQnD
IYjZl7l4jUllgARMbIs7DSwc5tv9WHMNJe5wZZNpnnE7HZOtQrfckuMb1/TI/9q4
Bj6o25wwff6osaH7859nGTnvw/CAY8wa2EgqdWGpmfK+bfyGVJxXKAC86XHuVDrZ
IGHv4Y1HeQj96aVJAXaiJQ8MfA74vQnLecfBG6R2nIpHYAxhJUxMviwWEhZIonzx
jibeHbu9bMuEvRhI6pUbWpll15G3Evdn+oPC1yvjB1o5sb0b+xvstVWJhdY4g7Za
vao+giDNwcDPQRk7iUsKvkr7l9bt19d44Kq4VMpkomCFS1MnzKdS3PJYGeFJ43hh
huV+ENy+mjsgfhW3yBKftFT+RPxMrwHMTm23znNV/oEVcv8S7l1kvDcW3nHnci/8
F8m49h5XVq3A+wsmFLZnBK2n/3NXtru17QqptuK+QOFmbaWLYr2UdqcUyxv7lCHj
RquL4hsFslBVv21eYF/RLQ==
//pragma protect end_data_block
//pragma protect digest_block
4kDFcNw42uTyOS5f8vavH6Cx4FA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PoEDO3qA7vBN5I1tKziY3N0/RPkmLFlE2hIHMTTqLhxKXg6vwGA+oH9vthRBxkWZ
pXOMdRz/hyxfMWtWfFeLePY5a8Db/3S38SYBFShq5fBHZAixqDgOlsAmQ4gxPqu5
DfO7D/LUaq3ZUvWTIwpB0qNDUAgmrOGytl9AHMxrix9I48WXUhVEyA==
//pragma protect end_key_block
//pragma protect digest_block
0XAIx546lvqcI5qUFhsZK5vMo1g=
//pragma protect end_digest_block
//pragma protect data_block
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
crBf9FqP9tpTL7mnO+3U1Q==
//pragma protect end_data_block
//pragma protect digest_block
o0tIFozsGhv7lmoVsMsnddNpvvQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_RN_SNOOP_TRANSACTION_SEQUENCER_SV
