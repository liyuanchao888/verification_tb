
`ifndef GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV
`define GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV

typedef class svt_ahb_master_agent;
// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_transaction_sequencer class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the svt_ahb_master_transaction_sequencer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_tlm_generic_payload_sequencer extends svt_sequencer#(uvm_tlm_generic_payload);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_configuration cfg;
  /** @endcond */


  // UVM Field Macros
  // ****************************************************************************
  `uvm_component_utils_begin(svt_ahb_tlm_generic_payload_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end

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
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */

endclass: svt_ahb_tlm_generic_payload_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kuYKAaM6U3rFTm4fQwH9Y5J7nJc8Gl3QbNseK91/0OahDlHkA/H8bjJ/AYP/jU/n
8koBLVKSj7FmOXdRB9fLNrdRYUzCGNLH3W6tn+0WqIfqWN2lHlu/aq9MIICaIeIh
g70t1NDm3oUXX78yus27vJwlKTrZfvbgKM5NYhxshRI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 632       )
h0TdddcltAwB+C4Pubh6IrOyredB8J+EnhnWebCbXJZPo0rx/mJL4jAYFOJ/N4L1
v/3Y1Pc33ovj1O7+w1yvPYLsnKS4tzqjiS+QbqaEwjuZjNh2qdUc3lgFRDBiFNvH
7d0q7sySDqWCjdFQZyY0Nu8x8fs2hAoA2gJllBOavb0qR5bhEwLoC8fX3Fn3exax
f+3fQqY8oWMiy+zwfutdBvjt2XsGt3rPAJgonxPspwwfFSNC3etMrzDttno3zjA1
GuqS9jNAUiddNVxD+MuxTy0JnvvWq010Q+nUZbMsoCHHOx77FieiO8AfS4NP1fIW
OhsfFmPEH5HJLZidplLKL+2YKtINZaWTEZfRqQoQzDAvs8oIrbvRKOlhw6b+pSAN
gTlC1JYe+vgmDWLOa1wgvVLQeZahsud0WaqcoSQg576zcdEwRXKcInhr7a9VqMn+
rkg+V+BQa8/kGxo7SJIfe6L2/x7sdBTJLi0aVNIoaWAgfvYjjOPJ4pjAQIvhOkVg
Mm9q6kToKBGerH0XVpZlv9w8/bBQpxR0+bVpGGyrzPVQ0y8ePMsq8ah+vH3oiKyR
s32E2mVxLWAtrKec/PTtzCUfM7HgvUBIvO2uUE1a19/KOjd7e4HTNK8zD1hzzvUJ
i3dtboyUmAIW/0fEUNFg+5PIYLZQLmTSLZkX52PKYeTVJ6+BotxFKey4z9SYgf7r
B09+FUWOUUqhnnkjHojstcVFSqgR0LPeUnosLwbNIPtuFjwGMl28bSRbyRtYCITj
lVliOdrAxicsGu18n/f5Yv9mqQhoT2U1eab3R7IxYHdCmJ49WtMmu34TveZaGD1p
fhFHRrKVY7SiasU+FiEZvw==
`pragma protect end_protected

`endif 

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ECHu8lYB2j1n/itpha314a8KGcRHpr92UmtEL281gmG+HxB5cfHjt0h7zLkG5Kcr
+S8wzSX5jpD/6u1O+VH277Xs4u1bD/lu2kguiz3Ct8rpzQqHBVwZbDNJXNg+ujgZ
TdyDpEBtr2bp0Hv8sydAOyoKsdmTQqKSxb5O7RdT1RI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 715       )
tkBYubt36vc5LUonjaL+7y8RkqwALUtZvLxl3aCbnqQKGqjZGkGOPiwybYZjwCFz
p071fiA5ntGFXVJPNb6tH2hlrrybucFOgG3v9TOU0NMzVUaCYoft7r7iALCp8o7n
`pragma protect end_protected
