
`ifndef GUARD_SVT_AHB_MASTER_AGENT_SV
`define GUARD_SVT_AHB_MASTER_AGENT_SV

// =============================================================================
/** The svt_ahb_master_agent encapsulates the sequencer, driver and master
 * monitor. The svt_ahb_master_agent can be configured to operate in active
 * mode and passive mode. The user can provide AHB sequences to the sequencer.
 * The svt_ahb_master_agent is configured using the
 * #svt_ahb_master_configuration object.  The master configuration should be
 * provided to the agent in the build phase of the test.  Within the agent, the
 * driver gets sequence items from the sequencer. The driver then drives the
 * AHB transactions on the AHB bus. The driver and monitor components within
 * the agent call callback methods at various phases of execution of the AHB
 * transaction. After the AHB transaction on the bus is complete, the completed
 * sequence item is provided to the analysis port of the monitor in both active
 * and passive mode, which can be used by the testbench.
 */

class svt_ahb_master_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_ahb_master_if svt_ahb_master_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AHB Master virtual interface */
  svt_ahb_master_vif vif;

  /** AHB svt_ahb_master Driver */
  svt_ahb_master driver;

  /** AHB System Monitor */
  svt_ahb_master_monitor monitor; 

  /** AHB svt_ahb_master Sequencer */
  svt_ahb_master_transaction_sequencer sequencer;

`ifdef SVT_UVM_TECHNOLOGY
  /** TLM Generic Payload Sequencer */
  svt_ahb_tlm_generic_payload_sequencer tlm_generic_payload_sequencer;

  /** AMBA-PV blocking AXI transaction socket interface */
  uvm_tlm_b_target_socket#(svt_ahb_master_agent, uvm_tlm_generic_payload) b_fwd;


  /** Handle for uvm_reg_block, which will created and passed by the user from the env or test during the build_phase, when the uvm_reg_enable is set to 1.
 */
  uvm_reg_block    ahb_regmodel;

 /** Handle for svt_ahb_reg_adapter, which will get created if the uvm_reg_enable is set to 1 during the build_phase */
  svt_ahb_reg_adapter reg2ahb_adapter ;
`endif
 
  /** AHB External Master Index */
  int ahb_external_port_id = -1;

  /** AHB External Master Agent Configuration */ 
  svt_ahb_master_configuration ahb_external_port_cfg;

  /** AHB svt_ahb_master coverage callback handle*/

  /** Callback which implements transaction reporting and tracing */
  svt_ahb_master_monitor_transaction_report_callback xact_report_cb;

  /** Reference to the system wide sequence item report. */
  svt_sequence_item_report sys_seq_item_report;

/** @cond PRIVATE */
  /** AHB master transaction coverage callback handle*/
  svt_ahb_master_monitor_def_cov_callback svt_ahb_master_trans_cov_cb;
  
  /** AHB master Signal coverage callbacks */
  svt_ahb_master_monitor_def_toggle_cov_callback#(virtual svt_ahb_master_if.svt_ahb_monitor_modport) svt_ahb_master_toggle_cov_cb;
  svt_ahb_master_monitor_def_state_cov_callback#(virtual svt_ahb_master_if.svt_ahb_monitor_modport)  svt_ahb_master_state_cov_cb;

  /** Callback which implements xml generation for Protocol Analyzer */
  svt_ahb_master_monitor_pa_writer_callback master_xml_writer_cb;
  
  /** Writer used in callbacks to generate XML/FSDB output for pa */
  protected svt_xml_writer xml_writer = null;

  /** System Memory Manager backdoor */
  protected svt_ahb_mem_system_backdoor mem_system_backdoor;

  // TO DO

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Configuration object copy to be used in set/get operations. */
   protected svt_ahb_master_configuration cfg_snapshot;
  
  /** AHB Master Monitor Callback Instance for System Checker */
  svt_ahb_master_monitor_system_checker_callback system_checker_cb;
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this transactor. */
  local svt_ahb_master_configuration cfg; 

  /** Address mapper for this master component */
  local svt_ahb_mem_address_mapper mem_addr_mapper;
/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_master_agent)
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
   * Run phase used here to set is_active parameter (ACTIVE or PASSIVE) for master_if
   * Start the TLM GP layering sequence if TLM GP sequencer is used.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif  

`ifdef SVT_UVM_TECHNOLOGY
  /** @cond PRIVATE */

  // ---------------------------------------------------------------------------
  /**
   * Forward TLM 2 implementation
   */
  extern virtual task b_transport(uvm_tlm_generic_payload gp,
                                  uvm_tlm_time            delay);

  /** @endcond */
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

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();

  /** @endcond */

/** @cond PRIVATE */
  /**
   * Obtain the address mapper for this slave
   */
  extern function svt_ahb_mem_address_mapper get_mem_address_mapper();
/** @endcond */

  extern function svt_ahb_mem_system_backdoor get_mem_system_backdoor();
  /**
   * Set the external port id and port configuration
   */
  extern function set_external_agents_props(input int port_idx= -1, input svt_ahb_master_configuration port_cfg);

  /** 
   * Gets the name of this agent
   */
  extern function string get_requester_name();
  
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
C+PRHRAbPn1XKdQqCnIRJpJc63fJ1+0rVKAmz0pab8AUO7KJEBwl/eoB0FKJ30ua
1bdvrVWZ7R0sHSQt5QRYSK73kDz2Vsq3AYwwmHIQGjb7NyMdOWdYz/6t1Y2u9CTC
PRA81Xk7A3OHLXKGh+BlJk7NUvFKE1rQoCe0S5WDKvw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 333       )
XvUwYsBk17Yw4Bot9NsuJq6lUh+Y6koZhXvGCLmRqwnmjDMKGGICExah82cZrxQV
wPb3qFuGyThkinYVaWU7Gp5rw2qripRRdevaj99m3MQJEjw448J5863kMsOfnt92
Kl1mmem4mazhmnUSL04ZRD6oGvgpt0JXpISAQD579rA9+ipEk56y3GWlDJAbyYUW
ycGOviFFOqOIbrX45CCDV2oHyfVYu8ImmFWPnfL5n4LgWAX0zTa6MygvewaUE1nU
79ehSH6M4/Ay0C0QxaadQ7yAu2vvQ7gECQTzJ4VTWsr4i0JeQ9tquLN6a/VEH9Oo
viyoDXgEtHyGDlq5FD5Fdl1+rMVKEnRqZ2cWIC8m13Xzzs0VKwZlLKKKEsNIuwph
CRPbpvDrxzaBiMLyknVhnjlo0d3Zx6ucHoAaItvDyL//dnXNQncbzm3KvDmW3FNy
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LP6Gz8KGkbga7P/5STkxJ9kNU1NDJp+q/9yEP8xehbLmRtOzBaH6gWDogLG9kblk
ObeGLzFjT3WTAtuDfUeffbZhormCyMIfVhq/gVJfmA7loL/lTsR8fgwApSR92iiX
5i8r6I5jprZ79xNqn4KbKJT4xG6oYoxyBgRkwopMgtw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23505     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_AGENT_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IfwKcTmu5/vStPgO6BzuaaaC6NKyvjufS4MYAc5lLOLypcvLQ83VpgJsJxc6jJEQ
dC4LCvwgcppRIS9MGxBKdFXLDGrzE9Jcdp0pRPPGuxD2AIAsvGByS1Py1Z7wJeum
/GKwF+UOq34z8PYB0wEAlJtkXFFeZZbGsa+FSN5Kyag=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23588     )
4dZFFuRsTiJC+qwsqx3lAnFPfuX9RoR4uCn3TvIDcI8rCyaihta/Y1N6BamalfMJ
iRcpiDRaAEMuOQpK5IrpHkPikIxqDL311X8Uz8iifNOCXg9bvnDDCHaf6SckuALz
`pragma protect end_protected
