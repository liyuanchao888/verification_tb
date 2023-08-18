//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV

/**
  * Rn_transaction sequencer callback class contains the callback methods called by
  * the rn_transaction sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an CHI transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to CHI
  * transaction(s).
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_chi_rn_transaction_sequencer_callback extends svt_uvm_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_chi_rn_transaction_sequencer_callback");

  //----------------------------------------------------------------------------
  /**
   * Called after the sequencer maps a TLM GP transaction to one or more CHI transactions
   * and before they are sent out to the driver.
   *
   * @param chi_rn_transaction_sequencer A reference to the svt_chi_rn_transaction_sequencer component that is 
   * issuing this callback.  The user's callback implementation can use this to
   * access the public data and/or methods of the component.
   * 
   * @param tlm_gp_xact A reference to the TLM GP transaction descriptor
   *
   * @param chi_xact_q A reference to a queue of CHI transactions descriptors
   *        to which the tlm_gp_xact is mapped. Modifying the CHI transactions will
   *        modify the transactions that are eventually executed.
   */
  virtual function void post_tlm_gp_to_chi_mapping(svt_chi_rn_transaction_sequencer chi_rn_transaction_sequencer,
                                                   uvm_tlm_generic_payload          tlm_gp_xact,
                                                   ref svt_chi_rn_transaction       chi_xact_q[$]);
  endfunction

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mxf7d6Tq4twZ0ABCdOempfPUU1tjLK3rRuehdlO1PwkMbuJmJeE66gMl26mjqIy/
ZnWwqOy0kn9wfbaynBxgQq+PnmbHVFfbJZ6bU+97s7RKt2pGDRj1lZqjYat2VMKx
E+anE7IxPlm9CL4sJFydt7Z70rUWrlyPVP+wfUYgxCs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 316       )
lIoLX5hVqV5R0ZTPrTgw5S7mtOMTWEk09XuK6nAchcINU7sMBVVvQ3TmGbrVAHdW
kbdmesw3kKaRonn+tSjYTS6GPm/TEM7I9FKjW800FXqHmImBx4jGBNumYY5CvkmL
5lPqbiVcci98b0MuCD8LvWvrcUiGjoGqi28kCG64Wm8BG/XosK6wSbN8s4dBcZfX
0Cc1PTrTjKsG8vLaprkPe/S8QqAXm6yTws1JQfZ6SADeHlbOVw9hxGZUEvedk3Pc
oH6aS7pZ+/loaea6tplESTWUJoWzNHfh9bNgF9Tow5LvyAot9vY+fJaS4hWDbhs0
xY46/566rOQOcWDe1OCv9WK3TjOAZNshm8qV+jOizGESIcV6YmbKwTIql0vVdCZz
q89wt07oS7xzglYRo6/6A+x/cjODpG+YDYnnqIocdZ4=
`pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_RN_TRANSACTION_SEQUENCER_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AIA9EMtgwIgB3V7B9o4o9RKG/M+iEt6x1qveqakuYD/91dwNnDq2Ne2yeXb3+VTI
0LowbjDIPx9GEvSysB8rVgHXJDMONy241FPVMNxSxo2O1VLhhBjXWoF+yb0+bP2E
hneb7CotryscXRZgiAux47ZBY1WoaNSeCPc02rnmtFA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 399       )
AZWAeKv0bSBjoO2lWeAQB4T1nG5uXBYTlSKJ+HDuViI0wuiVWKOmfAXTrZ2Xqx4R
Hro5XHLP5xB9jzFFz9OKevdGFF2VC95Wr5/aChAmH/+V/RncMDiXdmUSCUau5xY4
`pragma protect end_protected
