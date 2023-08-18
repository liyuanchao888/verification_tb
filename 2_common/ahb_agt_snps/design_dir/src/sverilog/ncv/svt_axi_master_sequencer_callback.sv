
`ifndef GUARD_SVT_AXI_MASTER_SEQUENCER_CALLBACK_SV
`define GUARD_SVT_AXI_MASTER_SEQUENCER_CALLBACK_SV

/**
  * Master sequencer callback class contains the callback methods called by
  * the master sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an AXI transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to AXI
  * transaction(s).
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_master_sequencer_callback extends svt_uvm_callback;
  //Register the callback class
  `uvm_register_cb(svt_axi_master_sequencer,svt_axi_master_sequencer_callback)

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_axi_master_sequencer_callback");

  //----------------------------------------------------------------------------
  /**
   * Called after the sequencer maps a TLM GP transaction to one or more AXI transaction(s)
   * and before they are sent out to the driver.
   *
   * @param axi_master_sequencer A reference to the svt_axi_master_sequencer component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param tlm_gp_xact A reference to the TLM GP transaction descriptor. Must not be modified.
   * 
   * @param axi_xacts A reference to the AXI transaction descriptors to which the tlm_gp_xact is mapped.
   *                  Modifying the AXI transactions will modify what gets executed on the AXI bus.
   */
  virtual function void post_tlm_gp_to_axi_mapping(svt_axi_master_sequencer axi_master_sequencer,
                                                   uvm_tlm_generic_payload tlm_gp_xact,
                                                   ref `SVT_AXI_MASTER_TRANSACTION_TYPE axi_xacts[$]);
  endfunction

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HduBULVbNclk2uvCJRskmCZcRFUN+BVvQVlSMGFXD/F3sW5jJam5jIKVfGtphMLg
LpPdDh75HW37s0TlY1Yeb3hgd783NqsQwOTWGJnh8BDQam4A25WUN7yl+aKnyms0
xybKbOA70nZxs3a36jamzih0pjFx1yAvg1O+Z9NfjTlx8xmpLrU6iQ==
//pragma protect end_key_block
//pragma protect digest_block
099K9ySVyjzDGsyg+PM738xHihM=
//pragma protect end_digest_block
//pragma protect data_block
3d26syPMy+qS6lHDNUi3nKN8N2p2tcPmDS60+iO3nrVjnvPSF9pIRIT7O1tzwTcu
qP7rsZh+j3g0+mAHgRufWBKALke31Ulozavz5mwzkR8i8MdITEBTIYyORNxTYbjw
0Qqz1P8InrBIFY2OlF3/P4IjQc3USrZ/O5yiBMab46gY5mkqZdBpDKrKBdFOlCJZ
h2RMJGFPaAgZxmfcIc6D2/G38RyO56kipss5wmOGhgbRH0ERmRlUrW2IAxkdA57i
c2hyTSt+XmZ1/iHJWSQz6sBsKC/WuuXqfbWsT/8MNKKbjOsVWcV310rn6io0D2S7
Cfesv5mW8JgDqEWPDC7VcJqGmsNf7ORVfsJW0lNUEi+ToaCGq5AccBNtf5ZHo87I
bZ7+DZslYc14Nt0LiO1QEUF1I3UvnNTV/3Vw/UMOHiGN3nqEED2jj8SsbSjLl7QL
PugtUj+GD1KbdsnvtS1Q3mFJESkMSsWWzUtP4fTxP24u20O74SHVowyphsfqecsq
/9bGKgr9ZtB3sqZLbup72m0+AL6f/O8Z4uL/b664J4aN2huOxTreEAZ9IRfY90+j
/XKbSjfpfOAbdoUkyYNFd8zYKKcgybAsYklG/fyAkVc=
//pragma protect end_data_block
//pragma protect digest_block
oxe+zEdP7wNC1v/QuKYxzYl1ths=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_AXI_MASTER_SEQUENCER_CALLBACK_SV
