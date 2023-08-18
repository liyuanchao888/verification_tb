`ifndef GUARD_SVT_AXI_TRAFFIC_PROFILE_CALLBACK_SV
`define GUARD_SVT_AXI_TRAFFIC_PROFILE_CALLBACK_SV
/**
  * Currently, this class has callbacks issued when the user would like to
  * modify the contents of traffic profile without editing the xml file.
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_axi_traffic_profile_callback extends svt_uvm_callback;
 bit callback_called =0;
  //Register the callback class
  `uvm_register_cb(svt_axi_master_sequencer,svt_axi_traffic_profile_callback )

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_axi_traffic_profile_callback");

  //----------------------------------------------------------------------------
  /**
   * This callback is added in the layering sequence
   * "svt_axi_master_traffic_profile_sequence" that is used in traffic profile
   * flow
   * This is called once for each traffic profile transaction received by
   * the layering sequence
   * 
   * @param axi_traffic_profile_xact A reference to the AXI traffic profile
   * transaction object
   */
  virtual function void post_traffic_profile_seq_item_port_get(svt_axi_traffic_profile_transaction axi_traffic_profile_xact);
  endfunction
  
 //--------------------------------------------------------------------------
  /**
   * A traffic profile transaction may be mapped to multiple AXI transactions. 
   * This callback is called before mapping the traffic profile trannsaction to
   * protocol transactions.  It is called once for each repeat count of the
   * traffic profile based on the setting of 'num_repeat' attribute of
   * axi_traffic_profile_xact. Note that it is not called for each mapped AXI
   * transaction. The pre_traffic_profile_xact_send callback should be used
   * for that purpose. 
   * It is added in the layering sequence
   * "svt_axi_master_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param axi_traffic_profile_xact A reference to the AXI traffic profile
   * transaction object
   */
  virtual task pre_traffic_profile_to_protocol_xact_mapping(svt_axi_traffic_profile_transaction axi_traffic_profile_xact);
  endtask
 //--------------------------------------------------------------------------
  /**
   * A traffic profile transaction may be mapped to multiple AXI transactions. 
   * This callback is called after sending each of the mapped AXI transactions to the driver
   * It is added in the layering sequence
   * "svt_axi_master_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param axi_traffic_profile_xact A reference to the AXI traffic profile
   * transaction object
   * @param axi_xact A refrence to master transaction
   */
  virtual task post_traffic_profile_xact_send(svt_axi_traffic_profile_transaction axi_traffic_profile_xact, `SVT_AXI_MASTER_TRANSACTION_TYPE axi_xact);
  endtask

  /**
   * A traffic profile transaction may be mapped to multiple AXI transactions. 
   * This callback is called before sending each of the mapped AXI transactions to the driver
   * It is added in the layering sequence
   * "svt_axi_master_traffic_profile_sequence" that is used in traffic profile
   * flow

   * @param axi_traffic_profile_xact A reference to the AXI traffic profile
   * transaction object
   * @param axi_xact A refrence to master transaction
   */
  virtual task pre_traffic_profile_xact_send(svt_axi_traffic_profile_transaction axi_traffic_profile_xact, `SVT_AXI_MASTER_TRANSACTION_TYPE axi_xact);
  endtask

  /**
    * This callback is called when the internal FIFO for rate control has an overflow
    * This happens when transactions are not sent out as fast as the rate at which
    * a WRITE FIFO fills up. A WRITE FIFO fills up every clock based on the configuration of 
    * svt_axi_fifo_rate_control_configuration::rate. The contents of the FIFO are consumed
    * when the data phases of a write transaction are sent out. If the data rate on
    * the interface cannot match the data rate at which the FIFO fills up, there will
    * be an overflow
    */  
  virtual task detected_fifo_overflow(svt_axi_fifo_rate_control fifo_rate_control);
  endtask

  /**
    * This callback is called when the internal FIFO for rate control has an underflow
    * This happens when READ data on the interface is no received as fast as the rate at which
    * a READ FIFO is consumed. A READ FIFO is read every clock based on the configuration of 
    * svt_axi_fifo_rate_control_configuration::rate. The contents of the FIFO are filled up 
    * when the data phases of a read transaction are received. If the data rate on
    * the interface cannot match the data rate at which the FIFO is read, there will
    * be an underflow 
    */  
  virtual task detected_fifo_underflow(svt_axi_fifo_rate_control fifo_rate_control);
  endtask

endclass

`protected
N;)_Q&;IDBKdXBMUUW0A.:A5Lg&+L=?+c7V0HQ84BfDWKG@(ReMM4)gYc@Va+Zg:
C=Z3E7\[F[2#aS@2DZWT^AGFMQ.c4U9PQR>D/1<K#:^NP4BB7I)G#:A[T==HDgAR
ce2,&eAaL_W=)FB#QbW\Y.:VbX7Z&\7D<g0H3?fCSPa6Rc@O<^B=0)-9dEG_;.+;
NV&a[XYaP99=8DFHXfg(ESD;MG8VM.V<bg<.8)]d?K9eQ=,CTZ6DP&-9O$
`endprotected

`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_AXI_TRAFFIC_PROFILE_CALLBACK_SV

