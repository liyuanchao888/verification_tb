//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_snoop_transaction_sequencer;
typedef class svt_chi_ic_snoop_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_snoop_transaction responses
 */
class svt_chi_ic_sn_snoop_transaction_sequencer extends svt_sequencer#(svt_chi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_ic_snoop_transaction observed);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ECoUjuSeL7KUxhre5EaH+1g5eJM2Pq0yK40qn00aM7YG+bHLYX9SXv+/qL4JJ2Ex
/caRjF+o1k765BeN3Iw3FvC7tGtnWWuf9j6eJbzufP+2xWlpNdxzDmlrY8qxDFpb
2e8Np4c0wsMiCrkDwV8TS1Rsx2hVrKdetElUYzajlvI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 367       )
s9dUprIinzKtUOPFPgYJgx6PPHvH6iohurCXt8FJ1IBsDDmSr4X2dAtLp+FE6xBe
f1iQm3NTahVqq4ufHmkJS69WluYT82XtezLyYd1ZPGYLqUKG2vzAHQJU3SYyuk+C
AFTXqjbHd08GnPhfg2LFaRED9Vxrtuk5To6lGc408OtslAxXWWH6mY6d5QyMGJyS
1zksPwHYIbc7zSjYJzawK/R7kn2rnidY+fEs0BTxJRELxKAZOsWUbZjd0vrlsa3F
zti4HpNeR1FTU6tPkbOWWEsaCjR5OFC8ZVWcbVuVsWpCfRm4Rmdp+4NASa58WW5M
VxNBd62m8Ae9ZyUhb4YfLz4pbvQ7MQp+oa0q+R0k5qvwWCW4SWYLBZ98e05OedXw
jwaXSmbph329dugaXDAjRrUVKi3onAvBw/6NZCyLs3UPKPQZum+8su5siBTOH955
vysXFTortqHi8y7M09bbwqDSWvzneoTPguPFT3GVEl4=
`pragma protect end_protected

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_snoop_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
 extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
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

endclass: svt_chi_ic_sn_snoop_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HzX2/JmoQ1iTJHLw23KgJNdcZTIB8UJzwI339YtdcEQOK7eMczut24E7CmNu7UPB
GeubSh9zJk32V+05tgkBS3++cIm5thSAV22j231DsefnDEYT8kLUFlS4vRhESa7O
zLOm+ppxMVrQ14H+4nhAPoM2mpKRgbJsqba+j2Fdvbo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2887      )
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
`pragma protect end_protected

`endif // GUARD_CHI_IC_SN_SNOOP_TRANSACTION_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HNhX9Ys5F1E8/7vYFj8pShXq26IOj7CxiqyqCVZRlwX0wlNwx2mbYKYTfKab3cqJ
5RErbUX1BsFzD9K2G/bRZJdHHW9LesObEYrOFxVrNDOIM9hDrIkeLkuzVqos+MC6
2CqbZm9mJdyrdKIEToYoLGWZn7t4oapU9lH0LyWO/bI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2970      )
ZUCDQJHQW+874W1uuec9oE/qmrXtQfBtsyhYa3uTdXyqMJBbAUJAvms3VMqtuAEC
IgnNL30J7iin8Em3SW1UV7zFuWqQJObZqHY/c9RJkYAVkcnnEc1G+puijv4X46u0
`pragma protect end_protected
