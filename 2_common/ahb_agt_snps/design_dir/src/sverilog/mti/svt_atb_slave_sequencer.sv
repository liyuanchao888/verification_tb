
`ifndef GUARD_ATB_SLAVE_SEQUENCER_SV
`define GUARD_ATB_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_atb_slave_driver class. The #svt_atb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_atb_slave_sequencer extends svt_sequencer #(svt_atb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif

  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_atb_slave_transaction) response_request_port;
`endif

  /**
   * Flush Request Port provides transaction request from slave in order to drive 'afvalid'
   * signal independently without regualr slave response.
   */
  `ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_get_imp #(svt_atb_slave_transaction, svt_atb_slave_sequencer) flush_request_imp;
  `endif


`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_atb_slave_transaction,svt_atb_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(svt_atb_slave_transaction) delayed_response_request_port; 
`endif

  /** mailbox to store independent flush request from sequence */
  mailbox #(svt_atb_slave_transaction) flush_req_mbox;


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_atb_port_configuration cfg;
  /** @endcond */

  svt_atb_slave_transaction vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_atb_slave_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE);
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_atb_slave_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE);
  `ovm_component_utils_end
`endif


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
  extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
 
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_atb_slave_transaction t);

  /** defines get method to get transaction from flush_request_imp port */
  extern  virtual task get(output svt_atb_slave_transaction t);

  /** defines try_get method to check transaction from flush_request_imp port */
  extern  virtual function bit try_get(output svt_atb_slave_transaction t);
endclass: svt_atb_slave_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IJbwW17lmtfwPyaf5NS0ubUnzx52pivNBxIl3Q86KLYtt6PfS3XOiAbzkgJk7pZw
Hb/o2d0a12VcyvAqtjL7PwCnQOFYwG+MQoJ62qTo+edH9ewvjRNm2OSTZDaeNTL1
fsmlH2gKG/kww+kRxfIIH0TFsECZmpMW0iPMvqwfAW4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 686       )
K9i3ODS75Bw+1/TkcQs1It8yFZvifd2vnVwB1BEalal15TqdzU44aO764nzrn4r9
2aytVTFj7JN/0eWX8VdAp2wRIvqgvI7dbPlPvZpF0QTQ6ulJRgpK8AVyNZZLbMVM
V933OHg7wqGhsrkdAFOK0wdzoGE7o+UjPrVlpw2hR6EGYRdYMdr4gnDQ0z4C6Y2J
jrxOYunFsykW/0RN00HRJ2xR+9Gj2oOQAxgPzH0UJjKvLcTzVHyO3ptW0dbv2h6C
QF8Woja//92hpyu8J7YZaG4qGixbvFPWI5Rsg2Liq9hsvemkh7cQJN8aWGQAVjck
jChB7vq+JVkxQ4pUEJCWOGiuSnB1QwYFLJQqnWMIhedKXNa9B+KGb2cA/HZXoAhM
+zYgJonMc/8fUHTKcnk36yPCNwX4SxgV/F7VkKF8XSEkGY1S524+Mn3OZ+71PxAs
/AA5kA9BK9CFTorowBKsS4AqbGj1t7DBtWpqJ7gVi1WmLmXHTfYKdsX7O0kItr8h
pwgugLsoqIOOyYVDfTXtl+lmagjLCWStJL/SIgSmTEM35CthXsjvqMaJ2IKd0tGW
M6cL4SJ/xzgKFoqU8o9A9Ho3gyMNepK4tvLL5/vuStmqvsTNvxvkcgIZ4SrYw4Jy
8OM1NoObtGmyNIi5EIeottFtsbYda3thqZjE1jJlwN0YZ+Xf+1+UE6gJx416flQQ
T9qwFgYQH1R7RXn4zoe9NM5u1nu/156q9/AoLWrQH/ZGk8DxgY4W5MEJkKTF7zs3
KYMgh0dbzdqQRRLMyuN235uJDC8oUmj4yqlQ6Ga9miEAp/FLDR7Wj4G9dRFwqRQ1
4s3CdRZaO/rqJ6zWsVCotxMgUc/9qive8lNO/JPJW+Y7XBykjwI7bNRmH2tk7yZH
vRXLNP7TNlZlzFdeaUaZjA==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dICY5/wSqksAIKeqSUmWdJxUshx9V6eS4nhD6V1K8vcIFRuI8A1PvfT8BdRR/Dhz
IZbTod8ZVMoHred5Hi3BOkIBL6WC92I8gK13lZEwbtsgC6xgylTlC+fVB2vDOzdZ
TWtvvM34Yaiy1XSllzbPPhSgNVtPhZIQ0Wmmt3RclYw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3190      )
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
ADP5/WOoHq+e+BqxHVpJmA==
`pragma protect end_protected

`endif // GUARD_ATB_SLAVE_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U9y3qdGJhVkreJoAmHC11cNJxf3B12OQD3rxwuHEREUuyfEk3zumHKEmiUs+Hg4l
w62nalH7OwxqcrCDB7487t+IUYUWRb+O8XQEDgjyQ4F4/Ll8suJWG9OXD0WHSp9K
joduaQCpQgVAlygbkb/u+SqZ6BYwkOR2yCc5kaZpRKI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3273      )
8JGdNPf40+u1rksV+7rGV/Q4ayujp/XJ8+yqVXrlXwMk1IUTEXxTYm6d6JgVk9vW
9MmJHiY0rPCgmg1uI2YMlWfFeEZuRgedohvEyGbCS+zGmO7OXpnmhlztgFfXhccv
`pragma protect end_protected
