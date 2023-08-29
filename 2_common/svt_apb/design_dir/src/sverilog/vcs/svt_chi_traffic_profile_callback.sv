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

`protected
G7?&f4]cf3E[3O:+;2C6b,e,8<D6gXZT\ES?^P6TC(\I:QM7<+TZ))7(G8?A&GC?
:U57.95]^;S;\RRe5YNHd##K1a]]&.J;T_<&X[a/^B(bPWPYM_-N8ZHcAZUC+Y,A
0ba+G#K)G:OBZ;87G20e6Ga_c]b0fGX)W#PHB3f)9.fg2CX.:a@4L]WXQ_OaL#fa
[.)P]SI[[?2IGbM/c,\?A3.[AZ+g+1P7TU?dC&cIO^d75eB+]V&P,<WXO$
`endprotected

`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_TRAFFIC_PROFILE_CALLBACK_SV

