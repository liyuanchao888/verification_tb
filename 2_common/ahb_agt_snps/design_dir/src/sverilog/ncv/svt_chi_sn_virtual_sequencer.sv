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

`ifndef GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class defines a virtual sequencer that can be connected to the
 * svt_chi_sn_agent.
 */
class svt_chi_sn_virtual_sequencer extends svt_sequencer;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //---------------------------------------------------------------------------------

  /** Sequencer which can supply SN Protocol Transactions to the driver. */
  svt_chi_sn_transaction_sequencer sn_xact_seqr;

  /** Sequencer which can supply Protocol Service requests to the protocol driver. */
  svt_chi_protocol_service_sequencer prot_svc_seqr;

  /** Sequencer which can supply TX Response Flit to the driver. */
  svt_chi_flit_sequencer tx_rsp_flit_seqr;

  /** Sequencer which can supply TX Dat Flit to the driver. */
  svt_chi_flit_sequencer tx_dat_flit_seqr;

  /** Sequencer which can supply Link Service requests to the link driver. */
  svt_chi_link_service_sequencer link_svc_seqr;

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

  `svt_xvm_component_utils_begin(svt_chi_sn_virtual_sequencer)
    `svt_xvm_field_object(sn_xact_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(prot_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_rsp_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(tx_dat_flit_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
    `svt_xvm_field_object(link_svc_seqr, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
   extern function new(string name = "svt_chi_sn_virtual_sequencer", `SVT_XVM(component) parent = null);

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
//  extern virtual function svt_chi_sn_status get_shared_status(`SVT_XVM(sequence_item) seq);

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gLzpd/snjUVs0/2QMqd3W0o+aUlWqs5dUPACnTY1/TVz5x4VAq1/8T+uvv7zImu1
VzjKjIPOF1Zni9C7EgoxJLc54lbVdCXJYbEgkMFGxQh3b8EzZ9aMM9heaTo6oERN
RM4cT9ZVOYn5lEBclZE3QZD+Hbk+eB2P7rF702qEVYs/2nBDm5kLNA==
//pragma protect end_key_block
//pragma protect digest_block
0uyXYE+la2zGfNvXztdW7d3HFOY=
//pragma protect end_digest_block
//pragma protect data_block
W1JhuQSlYDNO/jWV/3++yfAs2KMBKPbU15CG2Zok6ksfTR8V/hTg2Apa1L3YXQKq
GggO+hDpCkEoNsFOnbkmjCRR+4jo7nhH9tGFczCVCgTL+2fnJHOaOh9tzmyqlcyA
h+6OSsXTgZ0gBTqWoN5aTsxKaFybYVgezFJ08ZBu55PpkbHi05d2xE3UhseF/TFu
9lC3u4hf19ATtYYb/Scau5b+EWO1CIz+7TZIllCzeu8pCmzLdZMLJUCM0aWkmsc0
GN2xpbm/2t9Vefsq6ClEQJaflZuwFr5DU59iThQJXR1w40gG8VQ0mv5Hvtllo6E5
xrhKQWyL3UI8WbevAdCobjJ9zU+qt5RbtwY9ZUe2uPK9y830R6ZSuqYTu/SleMwl
kCwx71rzA8KoJ5cO4QL6hK/0L1S0vbsZvdQ6qSNaZ7ufwra/MbvogP+0rPvAEHH+
nJeEzdPwH/EUJe0ZFGNHJRoo/A4jljeYi5umvvYW1aaLxo9ajJshMF+MoPl/fhdO
c6yMzrgKd+aOiMgmwNom+XH4yrmSFqoMc6XtLkBHdqIXgbHDd4Ob+9+oLUAsb/wC
mDEWDinxMhBG0fTud9ahLDAy6G1M+Qc8ympcq/FYjwz12K0zSOcGd4aPtUEL4NLY
yLIg9C4kDOrdx9nBLjcnK0uo2uA97SLu+Wol/oAJ1JMZJJHOSjXJlfhjhXzf6rll
AusXMM0631JoBv1JmX/WIw==
//pragma protect end_data_block
//pragma protect digest_block
+b3GY2q16cN+kjprfTB7uLfjPow=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ziekcntqFo49xd9WjACfQAdZuwkBcAyjv+Ilq9+gQ4lixT8UHD1XpGjbZ5BAfoOG
FCEMufrQbtNK3nvIwpMOfOSZ9cNVKHNIH7fQwsy8hVbKh5YaQqids7sUjQW5GXKt
F0kGrIkN88bkDS8fRXHCjLBzPlgZoIOK2FC2uj92DC0AY2HcyJtqkg==
//pragma protect end_key_block
//pragma protect digest_block
h8C/Qey2E/si48Ror8CDwosBXGY=
//pragma protect end_digest_block
//pragma protect data_block
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
TjF3VhaN9u6rUxyp5ve8JA==
//pragma protect end_data_block
//pragma protect digest_block
4m1P4kadQO/xesPOYTTZimdj9/E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_VIRTUAL_SEQUENCER_SV
