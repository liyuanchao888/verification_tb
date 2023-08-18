//=======================================================================
// COPYRIGHT (C) 2020 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_TRAFFIC_PROFILE_CALLBACK_SV
`define GUARD_SVT_CHI_TRAFFIC_PROFILE_CALLBACK_SV
typedef class svt_chi_rn_transaction_sequencer;
/**
  * Currently, this class has callbacks issued when the user would like to
  * modify the contents of traffic profile without editing the xml file.
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_chi_traffic_profile_callback extends svt_uvm_callback;
 bit callback_called =0;
  //Register the callback class
  `uvm_register_cb(svt_chi_rn_transaction_sequencer,svt_chi_traffic_profile_callback )

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_chi_traffic_profile_callback");

  //----------------------------------------------------------------------------
  /**
   * This callback is added in the layering sequence
   * "svt_chi_traffic_profile_sequence" that is used in traffic profile
   * flow
   * This is called once for each traffic profile transaction received by
   * the layering sequence
   * 
   * @param chi_traffic_profile_xact A reference to the CHI traffic profile
   * transaction object
   */
  virtual function void post_traffic_profile_seq_item_port_get(svt_chi_traffic_profile_transaction chi_traffic_profile_xact);
  endfunction
  
 //--------------------------------------------------------------------------
  /**
   * A traffic profile transaction may be mapped to multiple CHI transactions. 
   * This callback is called before mapping the traffic profile trannsaction to
   * protocol transactions.  It is called once for each repeat count of the
   * traffic profile based on the setting of 'num_repeat' attribute of
   * chi_traffic_profile_xact. Note that it is not called for each mapped CHI
   * transaction. The pre_traffic_profile_xact_send callback should be used
   * for that purpose. 
   * It is added in the layering sequence
   * "svt_chi_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param chi_traffic_profile_xact A reference to the CHI traffic profile
   * transaction object
   */
  virtual task pre_traffic_profile_to_protocol_xact_mapping(svt_chi_traffic_profile_transaction chi_traffic_profile_xact);
  endtask
 //--------------------------------------------------------------------------
  /**
   * A traffic profile transaction may be mapped to multiple CHI transactions. 
   * This callback is called after sending each of the mapped CHI transactions to the driver
   * It is added in the layering sequence
   * "svt_chi_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param chi_traffic_profile_xact A reference to the CHI traffic profile
   * transaction object
   * @param chi_xact A refrence to master transaction
   */
  virtual task post_traffic_profile_xact_send(svt_chi_traffic_profile_transaction chi_traffic_profile_xact, svt_chi_transaction chi_xact);
  endtask

  /**
   * A traffic profile transaction may be mapped to multiple CHI transactions. 
   * This callback is called before sending each of the mapped CHI transactions to the driver
   * It is added in the layering sequence
   * "svt_chi_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param chi_traffic_profile_xact A reference to the CHI traffic profile
   * transaction object
   * @param chi_xact A refrence to master transaction
   */
  virtual task pre_traffic_profile_xact_send(svt_chi_traffic_profile_transaction chi_traffic_profile_xact, svt_chi_transaction chi_xact);
  endtask

  /**
    * This callback is called when the internal FIFO for rate control has an overflow
    * This happens when transactions are not sent out as fast as the rate at which
    * a WRITE FIFO fills up. A WRITE FIFO fills up every clock based on the configuration of 
    * svt_amba_fifo_rate_control_configuration::rate. The contents of the FIFO are consumed
    * when the data phases of a write transaction are sent out. If the data rate on
    * the interface cannot match the data rate at which the FIFO fills up, there will
    * be an overflow
    */  
  virtual task detected_fifo_overflow(svt_chi_fifo_rate_control fifo_rate_control);
  endtask

  /**
    * This callback is called when the internal FIFO for rate control has an underflow
    * This happens when READ data on the interface is no received as fast as the rate at which
    * a READ FIFO is consumed. A READ FIFO is read every clock based on the configuration of 
    * svt_amba_fifo_rate_control_configuration::rate. The contents of the FIFO are filled up 
    * when the data phases of a read transaction are received. If the data rate on
    * the interface cannot match the data rate at which the FIFO is read, there will
    * be an underflow 
    */  
  virtual task detected_fifo_underflow(svt_chi_fifo_rate_control fifo_rate_control);
  endtask

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EzC7gjCB+BIBh9Stpx/dnRgEu03f6RcMYeLOZDUF4n/aPLyEJZipQ8xrPU+T0Trf
/CpF8yhsxypnt2zEZOuQda6MkAJnguc0Ddo6orhMvUaSDy+hdz2W0TyzFXOwmEe5
jMP5kjl6z1eFIbp7e3ca/dKIDKpG7pmR25/wUwB4t7Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 297       )
PLvrIBDNAU7CDmHEA6t8LCb/bolFLXUlMwVBaw65EElNWU7EXWXGp3HE02ageODw
ynfQDTLThfe+A9XFlJPPU6/SVv4FiDCBzj1IBr5RetI3koMAcmXvrmekgU1GQtKK
5XKImPDQyteNDiXGeRs65hyN55ZFfo9GlPRNYF8UaScZUR2RGEZrMbj45uL7wVDH
pBavaR2em6/nG09v1RIlmCdnH5Gg1C7LtdbaNP5gTXJbMaTph6fFOdcCdSDCq6yX
/SqGZ+FReBeRepaLEJdkftmRZo9KXIZsVqemCketUvnleM+aNqxNHZzMMW6+6C8b
HLYaQ1wshit47+PatxdtucXo4vPpqidkhjYt+JawL3jgczgj627sHhk/uVzo/u5g
BgeS34ZtYhUF2FRlluB7OQ==
`pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_TRAFFIC_PROFILE_CALLBACK_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Qtqm1iaoJxkNcv2xl+/OejCETR7WMwh6xh7e09LWIBv9QqZ7ouxYyVZzrzhQzuRY
LOwApsP8WTjdf5aMAmOGIOYk99l87Zt1+3ponJ0at/psn+q4iWxLjRYCAI3RqKXD
dDSlBPJ4Oh3LcW0bvwQ/VD/YjixcFHNz4aiutO628YM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 380       )
qPlKE1UI0r0zHMOh3wQixZnMTnIQpbljel6E35vH4+NwWGDS0+3Id/y7az05HCMT
CIF/A/LOGjzmZeY2/PElGMfC6FimscYKgDeLOMbG9E0sO7ur5dVTYUrju5rDfZ01
`pragma protect end_protected
