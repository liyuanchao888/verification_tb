
`ifndef GUARD_AXI_SLAVE_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_sequencer extends svt_sequencer #(`SVT_AXI_SLAVE_TRANSACTION_TYPE);

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
  uvm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(`SVT_AXI_SLAVE_TRANSACTION_TYPE) response_request_port;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  uvm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_SLAVE_TRANSACTION_TYPE,svt_axi_slave_sequencer) vlog_cmd_put_export;
  ovm_blocking_put_port #(`SVT_AXI_SLAVE_TRANSACTION_TYPE) delayed_response_request_port; 
`endif


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  `SVT_AXI_SLAVE_TRANSACTION_TYPE vlog_cmd_xact;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_sequencer)

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
  extern  virtual task put(input `SVT_AXI_SLAVE_TRANSACTION_TYPE t);
endclass: svt_axi_slave_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZkG1Xh1Nsy1N+F7DwkY9Fami0jiLa4GQrOTmuQaRzP+e8JaKQmxtdgxki0v2W0rW
QAItZ9EshIs1w3FFWyj5wFeb8DAHCFFSPs3AU3F6A9yTEYXz79ESuzl6jE/1fL6z
Rb+/6aQoqd6IKIc8+20b8gg8UqeraL/Ub8/LSoXc+MU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 606       )
0VUCbM/jiTA4wPTzEjoNk44z270R3Gs9WWcNIpZbuQQAcRRhlRgsFqyyiZypXVi4
spl3BxzBv6kx1NmnBoy7Dv9AJBKivXvR9cASqEHeZp9/hDSP47DgVh2LP4S4OCns
aK4fVkvovB4Wd+Hk5Rmk/ijFYJ+xOLFeCf4w74GgUbe/EZEK8s5PcwKZ5gELJAvQ
9E8RPt6fLlmHnPeTW74t5nQG4m1EY+sPPDrKQvX75ctaCoyXq6vSycvRMM7AEN/r
73mV+V1CsaToJyPNPAQaGbdIBHCjT1CHnPhL32c7lUh+EEHsFPhP7siUGv7f2wOq
sKoNoOYW5pEHAnNYkDh3HS3NGXmehjXtLeOAIoLh1SAnYi4raIhFVPwBPv31ZH3J
EViFYa37nZfuSBeD/tfgAYboboxphODWOitprcJYjiaBKuEELj9NPVl3lmmPiB+R
g807L3AGjTAON64wtdm++vEjYAveNk5XcaGz4gG5oM1XmUH05BB9JSahEc8urOT3
+plId1nXnznZbas4ofDcqRVuMnLTNLZjO9q2Lg2wrwiRmKnQPHc3zhNJRRgAZM5a
RT4sAEnz28U26z2SQwFgwhDCoiunSU4Wxd3w7/LBoie+Rw7pxmG6uIxudhS080u8
o+J/HN+Mt8gO/ig3Ge3VqUIHVMXz1FAQqQbGJi6GNg6tneRi7zFm/XobQktMwUgx
bGubfBVRqlBHhlaWOoao2g9m8BuueKl31sgZmJuPgq9qmxbE/9LsPWklm4DhLH8X
WEDHr8Hxo9IrXh8zIJmny9ugJidrdTwUbMwdEdMXhS8=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jESOd0tigiXByl9UEBOD7KPO4qvGVrYpTTLTPfcmOoMouaBoGYVvWQGVbznrSeBo
lC1kPUBZodQuG2T+m+oVcdcN1G0ebapjXjl4VXmeXGn2OZzbSJuJ8/Aru37a0HFi
HC8wOg5fqPoqQBjRNSAbx9EEUp/ysyT/KZrfrxId24Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2816      )
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
v+BFKWnKXZ8GblNsJIZMVA==
`pragma protect end_protected

`endif // GUARD_AXI_SLAVE_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WKADg4cX0pyuwZilx8fKWGf4tmAnuF+7uWfZhdY9bLrki+q6E4NPsgfjLTUdUK+z
AM3dOiLDw+83U8hmc/Wd6KhQXzZteX79b/Sxwo/HkfA1Tu14dEfaoDs6kevUdwF9
AgVDTUM2df68N02egMxtPXzdQmZUJUpNkIJV1xib1Is=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2899      )
Vrly5ny7iU7sx3fH8PV6dAEEZJfJQMm9EiAcDG930nP3TfgdZmOiZ9C918kTRhVI
/Gp+Rcl11oYEudol5zZni1gyXhzv8GixpASmkL3s+XFbO0zNgM/k1mDF3WVjSoMh
`pragma protect end_protected
