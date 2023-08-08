
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

`protected
4#DE2=#^LJUP/eE=BYX/D@>OMfIGK>cdRCH3FJC77HJ;Z+<gR2&\))^I2>O95DgO
RW)^VY.,XSW9#/>C5CQM.293<D@[868VXVY2>Z/c+?M^UP)aEIZD&ed@F4acKIcd
dZ13=V0&X-f\CKXO[RHI(8]RafCN:aSB:J]f7XCCa9bP^3_[NW@R&@U)YEG-3?NY
S>HP.W>dU&A/0GJ7UKA11c\3U/eH:C26NCRQ0f47WZYUHfUX?8eN@E9V=DM_N>CLQ$
`endprotected

`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_AXI_MASTER_SEQUENCER_CALLBACK_SV
