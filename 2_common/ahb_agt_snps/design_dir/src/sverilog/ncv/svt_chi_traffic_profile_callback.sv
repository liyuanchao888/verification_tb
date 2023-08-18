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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Kd8DyG6K2LZ0+JbH1dOEhOCEqEe9NTR+PRvVnO0eTsE1NZtI6arBfIY2vKVfFfYT
/jCyFrL76yTJPe5nho6uH17PKW1XC/DmPranu+pAgLui7vQsnu97/TBT8F9dPgSS
fLtnW65VfsKvcYQLU+wILV6lkaPu7ZE7x/SR1oe+Hak2Gy4baLJntA==
//pragma protect end_key_block
//pragma protect digest_block
uV0sfYP6IaVrdwYjJnrsueUAm8U=
//pragma protect end_digest_block
//pragma protect data_block
avL1rqLZBpleiMllX1Z5JKgD8SWj/7wGaefSHMpJfN8NbhwGRzgkWn9m8HocX6o+
MSVJQxlntSEyJnc0OpsFA1QEmwK3JrDqK+4k9Am2iwWMnblc9nB4JjG2neSnRhBe
OmV8A0m40ic3iGekVIV57kVaueZsVDKJtD3zTbfun50ApYoWkj3sht4dp9FGnzmr
ioMLpYjjbYyAV+nXu2rE1zpUREbNIYmjC4737RSx+dy2CfSjVOgf8iao2OzmEAgf
huzDXOO9QJPJXOBsnzVKZUe/4CaX2k7uXpoNKj/C99J3OQ2CA8eoKux9q4E6Ula6
fn5SDz0zkkrQC9MoartG+O2hqEqOn7bFLmQgXULSRfx1SkCxGy+x3sbwlBQ1v53M
0iB0sIg0apbImeg0BxufXWFNlJXXEs9dCagHV/BlVG9kHYkwQw1F3HYgIMLKjVZq
PuJ3VXbKwnZ5NbLRYlB98ojt8tUGupwJIE9DD4s2Kl3CXSJ6AmurtkKavkU7WQcN
bP4SZPMoVQ/4/wDszCXATUYZCaLoya58t3NDFEMJ/jc8LKne7Pf11Z1dfpi0xJgi
vIw9Ox9KQoXFyr1VjCCEuDnOVFo5HufvaQeyGH3H3IQ=
//pragma protect end_data_block
//pragma protect digest_block
eG3VLwtwdIjyfjVF0tMTrPb5L88=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // SVT_UVM_TECHNOLOGY
`endif // GUARD_SVT_CHI_TRAFFIC_PROFILE_CALLBACK_SV

