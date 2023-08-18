
`ifndef GUARD_SVT_AHB_SLAVE_SEQUENCER_SV
`define GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

//typedef class svt_ahb_slave_agent;
typedef class svt_ahb_slave_transaction;
typedef class svt_ahb_slave_configuration;

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_slave driver class. The #svt_svt_ahb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_slave_sequencer extends svt_sequencer#(svt_ahb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  `SVT_XVM(event_pool) event_pool;
  `SVT_XVM(event) apply_data_ready;
  /** @endcond */

  /** Tlm port for peeking the observed response requests. */
  `SVT_XVM(blocking_peek_port)#(svt_ahb_slave_transaction) response_request_port;

  /** @cond PRIVATE */
  `SVT_XVM(blocking_put_imp)#(svt_ahb_slave_transaction,svt_ahb_slave_sequencer) vlog_cmd_put_export;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  svt_ahb_slave_transaction vlog_cmd_xact;
/** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_slave_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
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
 extern function new (string name = "svt_ahb_slave_sequencer", `SVT_XVM(component) parent = null);

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
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_ahb_slave_transaction t);

endclass: svt_ahb_slave_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OGCai1l0OeLSPjJuAyV0LbvStbFCvziPCdPIeq5XifcjvBKEIdtlPzgvc6d4veps
STmEDX9OH7FmMu3BrT4qolQV1qqRwetRiTMnh8+A/OkIqMPFM60sn2BXe5+WA+pz
MLCU9GT5/ro2NQOrSqajirfCplMOh9AdD/jutu3e0uA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 515       )
JdC0vNR8I2yRQkUcgR8YQ0C2Vz84re02lwBnaNj72vvQLy5Q7HK+NhwExE6lIaac
tnarNBmJc/JgZYOvWJr7L/3So7kyCw1swdenPM8VewEvLnjWTZl30UL/QJ9J0iim
dz9OSh76rRT7ybmV0pehmNdkN1QUjeuCIpdnX79Eq4ZugwTXJMguTQ1FR7KyHxGt
JqysTYEBod9scR8tma/WCEcqBI3xZ155Td67bTz2QToz6ls4JMBo+UMOd1d9XiOC
07JqaPSFw59PlKTmfzfoDdw4uhb6Mfxeni/84pqjy+AV5O/XhnLOKfpxBPyIbk26
ASAQhzVTB5NMnHX5p86XYPfZms6xMxwNJpavKbKu1LXQ/PWodBxs+15mxWyIg1pl
9bC2yrIrlS87ZRTecbdfTd9R+tySX9x4b28z4VqG8uJuyM75/DhCUdOHSB/H4ot3
nEeAmGDNVWmm9soRC+wxN91o85qEBha21BgRDiuIGJElRDugEM3Uz87XY8lyzUFW
+7YdekQGNxUsuFF34TSbVNykTKEI6faj1VfocfEAwG0cZVQzDXl4uhFb1uydKY+X
FvzEmHxXFiYDTdsqQUjSioinJJMJ4b6EB+05fd3+hFIue07/jEgO8dQ84dJDb0/d
M6QmJTK45/NSPxhd0tYysn+ca9+4FdhC0mKSAWFNYbHVSi+Hyr417lA+G9S3zuJl
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ehfx935rXIebbnqMuz+kIETy7UqnxneA94SvYikXRTwwpszkEdu4wipNucKanWiJ
Ksjph8A1NfEB+PppHTymzthSQMKkt1qAxJypnRpSHx3g1cqesSEm+kI/oeAlm9QE
RajfdvduXRtmv6C9EytGLlToQdEN0hrEgCY0ZlGZpwM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2499      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F+Edwc9YBws7thfQtZPlIWJK5B3UWkfDLX/Z5Lp/yQQjAEgI42EqYIS9V9+wdN5J
mvFEIoMcUJCd4CjCiwRRzx/2BiWMdPLJPAJkog6w6Im5GZWLk7bGoUwtLCjhbbRc
P10ig/lHtwmQzJ0i6VNPFVGRVihpjY9MhFrmy38Zo8c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2582      )
t6c5y5D8EPW0/g20/0sSPWCPge3nBlEf/O1nzq0IntyE7GBirCvVqoIdnlaIjuDr
XJnlpy+orZHALZN69wGudnmLrQNGE/7hp0RtHRaARYVdwyjYJg6KfJd/U9S5G5Om
`pragma protect end_protected
