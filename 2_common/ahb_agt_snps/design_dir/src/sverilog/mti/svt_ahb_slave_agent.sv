
`ifndef GUARD_SVT_AHB_SLAVE_AGENT_SV
  `define GUARD_SVT_AHB_SLAVE_AGENT_SV

// =============================================================================
/** The svt_ahb_slave_agent encapsulates sequencer, driver, and slave monitor.
 * The svt_ahb_slave_agent can be configured to operate in active mode and
 * passive mode. The user can provide AHB sequences to the sequencer. The
 * svt_ahb_slave_agent is configured using slave configuration
 * #svt_ahb_slave_configuration. The slave configuration should be provided to
 * the svt_ahb_slave_agent in the build phase of the test. In the slave agent,
 * the slave monitor samples the AHB port signals. When a new transaction is
 * detected, slave monitor provides a response request transaction to the slave
 * sequencer. The slave response sequence within the sequencer programs the
 * appropriate slave response. The updated response transaction is then
 * provided by the slave sequencer to the slave driver. The slave driver in
 * turn drives the response on the AHB bus.  The driver and slave monitor
 * components within svt_ahb_slave_agent call callback methods at various
 * phases of execution of the AHB transaction. After the AHB transaction on the
 * bus is complete, the completed sequence item is provided to the analysis
 * port of slave monitor in both active and passive mode, which can be used by
 * the testbench.
 */
class svt_ahb_slave_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_ahb_slave_if svt_ahb_slave_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AHB svt_ahb_slave virtual interface */
  svt_ahb_slave_vif vif;

  /** AHB Slave Driver */
  svt_ahb_slave driver;

  /** AHB Slave Monitor */
  svt_ahb_slave_monitor monitor; 

  /** AHB svt_ahb_slave Sequencer */
  svt_ahb_slave_sequencer sequencer;

  /** A reference to the slave memory set if the svt_ahb_slave_memory_sequence sequence is used */ 
  svt_mem ahb_slave_mem;

`ifdef SVT_UVM_TECHNOLOGY
 /** AMBA-PV blocking AHB response transaction socket interface */
  uvm_tlm_b_initiator_socket#(uvm_tlm_generic_payload) resp_socket;
`endif

  /** AXI External Slave Index */ 
  int ahb_external_port_id = -1;

  /** AXI External Slave Agent Configuration */ 
  svt_ahb_slave_configuration ahb_external_port_cfg; 

  /** Callback which implements transaction reporting and tracing */
  svt_ahb_slave_monitor_transaction_report_callback xact_report_cb;

  /** Reference to the system wide sequence item report. */
  svt_sequence_item_report sys_seq_item_report;

/** @cond PRIVATE */
  /** AHB slave transaction coverage callback handle*/
  svt_ahb_slave_monitor_def_cov_callback svt_ahb_slave_trans_cov_cb;
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;

  /** AHB Slave Monitor Callback Instance for System Checker */
  svt_ahb_slave_monitor_system_checker_callback system_checker_cb;
  
  /** AHB master Signal coverage callbacks */
  svt_ahb_slave_monitor_def_toggle_cov_callback#(virtual svt_ahb_slave_if.svt_ahb_monitor_modport) svt_ahb_slave_toggle_cov_cb;
  svt_ahb_slave_monitor_def_state_cov_callback#(virtual svt_ahb_slave_if.svt_ahb_monitor_modport)  svt_ahb_slave_state_cov_cb;

  /** Callback which implements XML generation for ahb slave for Protocol Analyzer */
  svt_ahb_slave_monitor_pa_writer_callback slave_xml_writer_cb;
  
  /** Writer used in callbacks to generate XML/FSDB output for pa */
  protected svt_xml_writer xml_writer = null;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg; 

  /** Address mapper for this slave component */
  local svt_ahb_mem_address_mapper mem_addr_mapper;
/** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave_agent)
  `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
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
   * Constructs the #driver and #sequencer components if configured as an
   * active component.
   * Costructs the #monitor component if configured as active or passive component.
   */
  `ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
  `elsif SVT_OVM_TECHNOLOGY
  extern function void build();
  `endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer TLM ports if configured as a UVM_ACTIVE
   * component.
   */
  `ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
  `elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
  `endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase used here to set is_active parameter (ACTIVE or PASSIVE) for slave_if  
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Extract Phase
   * Close out the XML file if it is enabled
   */
  `ifdef SVT_UVM_TECHNOLOGY
  extern function void extract_phase(uvm_phase phase);
  `elsif SVT_OVM_TECHNOLOGY
  extern function void extract();
  `endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  /** Puts the write transaction data to memory, if response type is OKAY */
  extern virtual task put_write_transaction_data_to_mem(svt_ahb_slave_transaction xact);

  /** Gets the read transactions data from memory.*/
  extern virtual task get_read_data_from_mem_to_transaction(svt_ahb_slave_transaction xact);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();

/** @cond PRIVATE */
  /**
   * Obtain the address mapper for this slave
   */
  extern function svt_ahb_mem_address_mapper get_mem_address_mapper();
/** @endcond */

  extern function svt_mem_backdoor_base get_mem_backdoor();
 
 /** 
   * Gets the name of this agent
   */
  extern function string get_requester_name();
 
  /**
   * Set the external port id and port configuration
   */
  extern function set_external_agents_props(input int port_idx= -1, input svt_ahb_slave_configuration port_cfg);

  //----------------------------------------------------------------------------
  /**
   * Function to get the configuration that should be stored for this component
   * when debug_opts have been enabled.
   *
   * @param cfg The configuration that has been supplied to reconfigure.
   * @return The configuration that is to be stored.
   */
  extern virtual function svt_configuration get_debug_opts_cfg(svt_configuration cfg);

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EDW9S/9w21DjEIQbhmk5ucutcbj5snTPUiqKM4tyoGpQmfDA7y0mRn47cX9B2zdU
ZmdV/hn9SFOPw+2ZZVw8bzgdPKcyg4yAk5yeO5YxXM2XIC7wUlGWwd9knqlwREGM
80msoqPSgI4aKtw8mPiEVzhCRAEGMxUDfh5eTdzQBJ4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 332       )
FY776U96QYfq8sBpw9wloPnQFX2fax9WdTKe9J9lcXjbAJm2rbqkQzwAXOYLwXoC
l67ceidAPHfn7d4SJPTiatPitVIkfmGNZinjkOsAUxlw0mrSJTBUoFga0nQLpUeL
LO05GkcfIJt4XOpXn7jhjQ/M9fYNTGcFz1Y5a5EoVfZj+fGi5bojPbfVz4yvHglV
Sb4mHFZZEzl7KjFM9Mx0kJ9wzXOkAkxqN5M2GzerK9dNyf82yv4vwzVYSoqqXrMM
SIVrVNB6c5CbiC11OpLnGxNb5FWVZrwSCN0P2dkK4cSMKuka15JW+/d0QuRK7jxN
y+9m1RLqat+ARyDK24hb6WgB9xbxDrA+3LsEmjIViHj+tuiAgg2kN7zZK0nogLSW
7+KfbCBsY5MTYZuMy+iSX5TMUz3jq+mEfymKag8d83oydo+zmjmdlGtezPJWpkVG
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
H5wOnea25CUVMKJZEdopw66lgKPxwGo59Xt/FrWevMg5vFCTWW8XI8VvE+T2gCar
MKqgIq8aNOWsVP9u2Pbh35N+KQUdK950Ldkt/xXb+4CpBxgls+S1KhbV8u5CSUZY
5NO4bsbyFvne1FcLVMlzwyUnZ1U04ZfjCK4KA+71/gA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29472     )
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
adOQJHykT3jMZIVeGxtGXg==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YPCuKNS3hglZuEex0ztuR6uJ7sxh9+BL2rGnU5RJzjWnSxPupX0f0oiww21fGs1J
gKon4RnFfN3aj6Hm697X1QDp/sKlA/h2b2rmONY9euFoVepaih4fglbZvjw76k2q
92Xz0gSnwP6RQrJcc2lHyjDIHVfz5vw4yXLRUfSC4uM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29611     )
kALVu4jxD1XpXYxIJEcojdqnbAlGQ5BrVIm7C9Ww5KwImexo/2scBfTzajxquUhH
yPnhn+S1KbboX6Lbmw8vrotp4rsCOr8pHVIzYm2X0ScNqatW0hznGNMV6T19Xujy
C28dfa5zqKdKHbaBLY/J8MJiCKKX86abtQK6P4FasaJdzEkLdfrCC11FBnO+hFbq
`pragma protect end_protected
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SYTzLWyxlXyU5fHDcmpvxmjackcfq0jsytoKyWnfaH1cNsD9xppHOj9lSFggkv6g
8217VA5dqip6FH7WnLr7nn6SXRhK1W0ikbUcD3ReDxQFRM1Efyf8lDK/A0KBubom
bNnnYsGAvwjekwfvY7jMThggfEqdSCJMSVUzjH6gbIc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31278     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_AGENT_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PuDZJr48Kij6SANDsAhKGv6HAiz4kl0B4w8HoNZgG08B6MN3GjezvdBJ3lCHFmAF
/N0LrPYgC8ZZoKeGqObSz1t+qetqV414vq5v4tpDtadl3e0PdOtJjpNgk+3FI7X4
/gmZ0VZaSbpRTJJ+2ql2MqsUTmMiIx/IbVMC4/2tQnY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31361     )
l25Ke1sUKfkKF7q9T/Rs8x5G6d982qOASr5+D2WBp0dzZCrkGZ2BxXXI+2ZnAuJ+
WSsAxzLourflEhFHQI9gfWtC0+FTnDSs66S7Qir9ur5nxlNOvmJVtJZPyWXzK6Cz
`pragma protect end_protected
