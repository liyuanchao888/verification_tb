
`ifndef GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
`define GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_snoop_sequencer extends svt_sequencer#(svt_axi_master_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis export that observes snoop response requests */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Handle to the master cache */
  svt_axi_cache axi_cache;

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_snoop_sequencer)

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

endclass: svt_axi_master_snoop_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RjpMBjahWYZMntaNrUPPCkL6EZ1qRgGUgo9/RR09BimxAJn4G9Y1idtIzANQoEDc
4RYxd75WdIYw8AAlLAnlc3DR04lWbvKypkcgiG3n31EfgS/CC2Vm5RZ0RK/ykzOw
VSf6YUuIlam5Rqpjoqweg/EXZr2W4eIBJjXgVvp3RB0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 541       )
WhP3qN0n4/Pz2+z0FERGbJTvt3kw9fjfyIOzzMafNb1a535dDKbsTyszdXvliKsT
MDi+scmwF9l+dh9qSxgwknn5wjVOn6wKUca6lotdhXbGe5XQn0J2vFa49oHrZH2R
W766NaI79evaZ33713YrEywGStHI5xNDMJzSUTxuSAEI2eY8Of7RanyuAZ2NQbeC
iSO/bz9Folp2S4Q9HrLecwOdYosNcoUBQ6OvQI8stgoAELYEP12ETAf5RFGu7ovQ
tigZfR3COmihOlKVzlBXSSSKVXB9uaHlxatW8FoPNaHR3kxn5umFK7GpPILLqI+H
8kAbYWKh2Af2LaDIEZkn48Sft3EUJkgt9KW2Kl5vL6kVWjcBY/sPYAdD9t5+NKOf
+EiS6PQaLbmJwjfjrINVugixnL0Bydv/kwxbYlzrADyQ3IlxLErmSPIJqpOcvt8b
ZKoPLd24NPCWUk+6awIdbsfRINeYfpFykZcUTpG/xFG570zgvMeQI11a8I5bKSQp
fNOE9IMDFWuGTvmBa+X3pdTaemlmys6028oxAus0xwhZqULI2BXPdPI7DvI4FqGY
+p0wuHSMbs9f/pLj4lidaSmhiZD5LTQSVyk2Vq4kwRFWhP/YV0GHd1gqPTFCRVWt
KXh75LNU6jby/xhzhOtYwuXZsJCuKw1AF7gccZrDb/LsItKiNXF85GcmqCzIEr5T
bwnzhyyhXEd3P2lreFnh/w==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LRsypvGlhtRgkT5U3zQ2aXvE6fRm+lWyHjLKQWZSYfP5BSVshz9eNSGIg2k06mLP
vmgZXDlSpaa74x8lnYmhXbooLYzOKXdNeu/DsFbM1FVeW0Rg0DV4xi0drGdkuCLi
RnN3P/wM5lPaX5fS+V5fE8VDK3fSmOk5Tr1DF2+WO/g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2521      )
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
MpGXbqgIZNY+xBQDUGz4Tw==
`pragma protect end_protected

`endif // GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N0QQk3vaTpZIf4guqMJYjqvTrHsHc/1/na/N2YTwa5xjqoJHSu3MnQcMx1e/ZTUa
bvvu7ajXsG78arCZYCcJqpkFcto8Yy+/JCbfVQvlbCBimO2r9U85FXjb3hpVe/am
3LeGY3xkP/gB2GzlK+7ggYoJwYfvEdrWafl8CsNlXrA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2604      )
yphz/DPWEQhwHS9YCp7Xuf3wWESRPl5YU/q6opVDtQrb1q2U/dd33fFqrqM9TcvR
Xj6HIf5RSp5SSqKaT5CMNez66XPE2+VhRU6IFND/wD/kUfbU85wGemx1Kftoezt8
`pragma protect end_protected
