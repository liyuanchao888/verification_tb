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

`ifndef GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_ic_sn_agent.
 */
class svt_chi_ic_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply TX Request Flit to the driver. */
  svt_chi_flit_sequencer tx_req_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which connects to protocol layer of interconnect node that connects to an SN */
  svt_chi_rn_transaction_sequencer ic_sn_xact_seqr;

 //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  /** Configuration object for this sequencer. */
  local svt_chi_node_configuration cfg;

  //----------------------------------------------------------------------------
  // Component Macros
  //----------------------------------------------------------------------------

  `svt_xvm_component_utils_begin(svt_chi_ic_sn_virtual_sequencer)
    `svt_xvm_field_object(tx_req_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(ic_sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new virtual sequencer instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name.
   * @param parent Establishes the parent-child relationship.
   */
   extern function new(string name = "svt_chi_ic_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Gets the shared_status associated with the agent associated with the virtual sequencer.
   *
   * @param seq The sequence that needs to find its shared_status.
   * @return The shared_status for the associated agent.
   */
//  extern virtual function svt_chi_ic_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with the supplied object. Also updates
   * the configurations for the contained sequencers.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CRk900zhDStyVMDGFsuv+8YF/ByyVCAUZmH+CKEiWyAAMdp0+QbkCzhw+JnGSWTJ
sMYNaReEnJuzF0qfE0rMjBrYa2lQRzhekGBM/FjVtbnZlL7eSEmtNPq1stxbcNVV
Yg28kQ4PW+OaZjK2m0kQTSmNhH49+H9TtsphvAnhONE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 383       )
m+XrTC6+2nO1qm73XEvvLA4rnqwK7M9UCs7lYvaMhT8qT4M1OqyS4Ex9LjqT+j+B
HHKiI6dz2BNNbnI2m9O9bWDPra1xnwwWhnUR+dLxdZ26nyBZyV28iv3w6mOs+MXE
VymbrseA2xDLN7iqGj2vuC14NSjafeHMHEq0FPXc5drHNmzCkNUMV32j+/xwCiGh
+6b4x4nOpEpxp5/RBd9f6qKeedhTpoc0AqhNpJWF2hfO3gPTYRHb1JbPfTyCJkxh
57+QSiSuzWE0Dr1qZ83XzRR4G//OI8Vbm9p4WcIMXosiIJz7usfypsMjOcAMWa1m
60npDE4K1bmhXEbVmzhZontedB+pTJTNAbR4e1L3z4uO0o+J6niAwXf8Ptm7fW8d
tX2PN6TmZLLj4LiXZnsMH6gkptug8GEMJGpiz4KFskIK5HmCeuu+RN8dmYODJp9M
/nuWMEGPQCjvEF2nKecb6HXbsBa55WAm4fH3AjSfspKNTzDg/OjioUkJJv/jEx1n
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NsFe6OqyMsuzV6ZUkCa/GzlNLM0BRZRzmzCqXo2O6MN2bj854LNRetNCwbF4LN3r
/TjAVALnmOj4C8VnXA0HydfZRXguq0g0Xbl3fMi822/ZCINrBfEGCAdO6fr9bmRW
1sR7op0DF4t8IbAQ6ngSjs1LtktpXtQJTLGTeb1L0nk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1981      )
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
vGgux+k0lVOyBSjfjugEEw==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_IC_SN_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
h499+kB3wcOJXUD9sxaVFsXF2fyEO7jlX18SX12bL37DfuYKWwH2O5JBeByIZDO4
vbYfrJB1NXIOZ+o72mxJdFAH4ygrzxUkGiQr2wxkzvMHHZq/l+I6H0K4CK4QUe6+
M8aldgItpm0LVaEok3EFJF0Ni6sLv59IWlyD7060rII=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2064      )
/6bVd3QTMXtNJ8yyvzSeVLjVHS6deNG5ye7ROLefZ6VKL7WEwGnSTTjKiCMdQ83k
PMXzSi96cNejDyGnZ9fxjp4MQ/V05uZ5IVrStPMYEQZwNtkIQLHOPu9WWhFe48ul
`pragma protect end_protected
