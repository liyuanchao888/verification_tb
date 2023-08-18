//=======================================================================
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
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_chi_system_virtual_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /* CHI RN Virtual sequencer */
  svt_chi_rn_virtual_sequencer rn_virt_seqr[];

  /* CHI SN sequencer */
  svt_chi_sn_virtual_sequencer sn_virt_seqr[];

`ifndef SVT_AMBA_EXCLUDE_AXI_IN_CHI_SYS_ENV
  /* AXI Master sequencer */
  svt_axi_master_sequencer master_seqr[];

  /* AXI Slave sequencer */
  svt_axi_slave_sequencer slave_seqr[];
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_chi_system_configuration cfg;

  /** status object for this sequencer. */
  svt_chi_system_status status_obj;

  // ****************************************************************************
  // Shorthand Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_chi_system_virtual_sequencer)

  extern function new(string name="svt_chi_system_virtual_sequencer", uvm_component parent=null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Pre-sizes the sequencer references
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_status_obj(ref svt_status status_obj);

endclass: svt_chi_system_virtual_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6ttMXR5TFjh6DW04mSJS2CIIorCSu1yeHf+z8Xj34jp6mM9na/sfIADDbrwg2bqG
oRHpbbiW6/0V/kMtr7plCYjgoHnPqJHoZPbitIC5XD0v5O20iLRIHybShoSPaGCi
a3dozhnLRpT4tgwqfuf1Sp0bbZjhVjGChkry+7sV1JdwKNhkiZI6GA==
//pragma protect end_key_block
//pragma protect digest_block
WyJhmOFTyzmKBA+ClUeSc4Jj+4A=
//pragma protect end_digest_block
//pragma protect data_block
9ya6AoWT+gPoAN5ugsOVcbBdmmNRzWCrk9h+t/uIpcnmAopr6OdIpVzFVYi71WdI
3ulx4X31/a2Tlm6+RNvLL2mOYt7fJpG5Xf317o/HOqiOla4XciYcTVn6N/2ZjRcj
73uc+MxyQn34WOd9Des3cDAPBhdZQsCcNqywg0RKjuXdnnsEGp9RKD5GyQqSMON0
Npa32WEYucBJVyafHcrbst7FvYCwKWqmKc3AoqYTNgPc/iZ/7F3Jfc/g5bypm/g6
6ONh/aWM9DT6VlxQHYD9nRzYK9S1EuqrXZCqICMglTeoZrpryaB2EA3ZhCTjEP8i
IMHeR1fajh+fCLs+lAeNHiRSkonzSCvtrHzTnLVc0jpP1DVVPDf/xcZHPXdNrswY
hAFr3OJpXCb19K4xDlCt4eV1xGslbAuuiXLIlGz3VwaQNpipsMVJOTZcYuBD+Rly
jWgsRHOscu/F/bmae7kx+WWVA1RO63Mkw7KufrCW1BC+gu1wXldrOIRsGeJGWjYb
cpt5btn+BMcyxtf+beeLoAd9E3u2SN9WVrXLYedq1YJVax7iSwQlU0QJo0Gj6ydJ
x+PH7UxUwUzJqDlYEuaCKqP7CnAixRmA/13rOKqJum1anOiWtmhYE+FpElkU3EqR
fABeFSdUVW4CsLma/Jq5zTTpvnq7DBvlpFKihPkz1MFMI3QetJH5NT/yTR1UBcuh
lbWrbC4t3FcVuhgWCClCGA==
//pragma protect end_data_block
//pragma protect digest_block
x8O3CXi+2o03jG5qLX3mPRm1v3E=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
C0MQnXlj7fmYEWVXY+nGcsOKAHxr67HMMhcP/FXcNVBtdIyIa0bD6qfk1wbo7Gv3
7yXQgStvWsExH6xNK2YW5zosfnp18OBiD+U3oBIm6HXffhnxoodd+R3CYgJc8N2e
7YBaXHwQBhxeZOirg8+OtZrMKUe3RpjBDYb8UHuk3P4RYDJNwd98Kw==
//pragma protect end_key_block
//pragma protect digest_block
a7/layI59i5e1GGZRCRezONIzuM=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
e546aVZns02qOs9xosARTTZNnmM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
