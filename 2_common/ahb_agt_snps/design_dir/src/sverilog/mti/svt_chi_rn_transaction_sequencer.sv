//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_rn_transaction_sequencer;
typedef class svt_chi_rn_transaction_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_chi_rn_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_chi_rn_transaction_sequencer,svt_chi_rn_transaction_sequencer_callback) svt_chi_rn_transaction_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * Sequencer providing svt_chi_rn_transaction stimulus.
 */
class svt_chi_rn_transaction_sequencer extends svt_sequencer#(svt_chi_rn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_chi_rn_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`else
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_rn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
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

endclass: svt_chi_rn_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ieUs/EhZh1eVBThuF4r55vhB8xftg+xbsSGlOtcTYwLAq8pE3QMLXvvDKfBC2wEC
XxsrtKsIR1tFwzxZhwAYHHZNkrk1dc24ztm+1DnqbVpT1rJVJro5Am6fGiQUB+Dw
s6DbGWsPSiiZ858gAi2SZ3fX/P+uhO/7Efj3NGbtJAU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 683       )
jkxYJJ0UW+KnOCHJ+L5K2X+yK8D7MEbS6J5hJOqOkU90fIcJg7yah0ndh5xW/CVn
L7rd/1avhc8JCDU1zAJ9DMM5SEOT9Z0RcAkHfSqzrlgwtBRVQN7TX5bfoZ0KelAW
lwZUu+ub8Mp0M9yzXq7g/aRrTePJmINVZ+kkiVKquUupGTKpSe16DS6j7NT2KW8F
LVK4pEkPeCuuW49vnKuIpiGzD1GsrhcwDavg7xTUdzT+FLMnZddHxCLxCTo4K1+C
CVRtFakZVk/B08PDzPaH9oOY7FG0/zLmnbOp+MB8Pu9esCJ0NNSQcyI6MaYuuOER
KifPRzCbhA3queTnRd4nDkqmSz8AYyI/TVFyb8fvHCp52LD3s5xjz2tVOm1wzgbt
za+hoVlQjKBJz+owWCOrcbAmJMfOAZ6mC2qyAKkZfkGKM7Qb6T1BtG30TqXdJhxs
qk2HJKyOT7ncJwPdKmTtghFfIfDkxOyUb0vPSDKR59VEHUj/f0eVRhiNcRR1p077
lEh97OmScFpiWLVAaAQPB//R2D0QDNLK2B+lvfEW30NSgw//LMFNXAKN6iR5rAZv
yVL+ZOqu9/SFWuZGGbuhSL8fruHPwQBPRG6jfN36lyWfhzCEmoI9xSdnzQTOPINo
aQIlqIvj4dB+I6VEXxC0t90cu3InSjDstuw6h3W649/IS0M00EX4h3twQUfRDE2V
xf7702GU/D1ugEXFLQLcbdqc/nb+1Z0vWUtGocTU1RNAJFF0gop7m2ujk/ipmniv
+M10FTohxm3Vv4XsyoEd05p8j9Arc7irVf5a0hpCIPyiVDC69LrQcc5G8QQV+yJC
TfDdz7lD6F16pLq0Hgvux7PQLaIxXTLPZyVrmK7L0NpfBrtNlxYPynUafVlkaRlc
pf5dnbRSTRBEWamW5t823g==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VlWmmnz482PLKvc0iZfPt6mfiUYVOTpWJ8NqbLIMzjFKGjpEUvmJoB8mzEQrMcSL
9I8HmBkFY/xnWVKbmnozynXo/3PDKwkrKfVjWDdDlA+dAU40Qpw+qz1rlvQoXXWK
iDdCcP7AGXrbG+pMacIIhsiekmUVZkhzQREkhlWBJUY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2741      )
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
`pragma protect end_protected

`endif // GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lAF0MJaQtMg0CSuILPVaM/BvR9yyY0zTgYm1gypY25biBmyk6wwsDBcyqOsmD+i3
ZCBwiDEL42OrvEbJMmDeP7uk/cmL6F0ws33MSkvaw9+beH+Nw9FWhTbAmznSSqXT
R1U9pd1qWBMq9gVKQ7T7HR097PkvAPw+Zb8B7BRxdfg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2824      )
JUHLb+md6MVWpi86p+DQ5SoMY2OgUgWw8E3Q+y9e8fhVeZ353iTckHdqJ/ngr1L2
zLDT5hhzbmDCxwuAT/IpWDldsyWKCA6p3ADEZNUWTrDLk9GjZy1DkjBhI6DOo51Q
`pragma protect end_protected
