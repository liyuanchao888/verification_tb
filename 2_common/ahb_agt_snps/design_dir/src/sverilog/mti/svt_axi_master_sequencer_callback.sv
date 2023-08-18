
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cTy2YPJs2VrLX74Qn5MPPUPaXhdomAA/8rpPg65ho2MyQJDaSUQ8qFCME3uMrNKE
YwDp1UdHw1AsZmzUO19CgnWDGWiE/v2a1KtY8ceoEjRRZ9U9/+tTDlr+S7qyKTIg
a4UJdKzLNkVMW2Gc5D79/nmHH6DdYxG3ATfhZ56PPTw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 299       )
cwIqQxv5X5wSSwFa7IPT6ji42Pa4zZYCwgOlhkbvusgFdLIM8R1kEmzVZ/KHPSAG
SV0xeKAjOAOd5y0jzZpGYbmO09WQgKx+VOjE7yGn1W60ZWvFzh9bphjFkeYanxxr
VZ6jdcHsPXSRhtK5rL3s1K5QFRKK6ErAno08Mhu1yMQ7uCJSFEAjyBfZU07HoV7O
7+URBGDKLVUrr+gvOafTBT+9Rbwp1STgsJ2AXE4vTxyS+iHwCrj8Xu3A2+FBNDdv
ma2iE4CTBVAHvhf1gajRAdq0V5g6akXjOZrsv8zShFUM04E6r5PIh7qR6FG0bWiI
6E4XHmG5FULzJrigCzZYSEVR7DuYG0wRPR4hqJD2FEWw0Ys0v9pZe3iZrKG1Vqq5
Ol7YiyS0FWQ3fmyljPFapQ==
`pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_AXI_MASTER_SEQUENCER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JHG6RPPE3J4Ryz9NSaq5mGxROAAgg6yn6sY70k1oRlK+nHTiaLP3tYFFiC58r23l
cIxQKjZmsTaqZriCi+VMQpfUiYaLBEjEZYfKFijVPHdWx0wGfzl9bTXCYwVhHZKo
WS6aqy9SaWve1YMnhleeNw0h5QUwxvGAlV9bTsEFY88=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 382       )
paUYkcpIkhRMiDFSZnm893shy6ow9+OU0HWzMH3EAXBj0lPbKeLOujwK8U6wLLYM
YwKQLRh5PED6+QdL5j90VJZiSh21uTIFQl3Ti42ry4HDdS3++1IuHNMMOeXfgSST
`pragma protect end_protected
