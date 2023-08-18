
`ifndef GUARD_SVT_ATB_PORT_CONFIGURATION_SV
`define GUARD_SVT_ATB_PORT_CONFIGURATION_SV

//`include "svt_atb_defines.svi"
typedef class svt_atb_system_configuration;

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AsZFeehDnQnzM8LjvaggPWL4pewxeADYc/Rk+ayWNdkG1T8Db8AtduYW3w4Kn5in
Xy+baUkimsycaY0VOCahId07dGR7btcHPggs7BJyQbqolxF1ErgTPrLype/YE3ea
Kadm1Nm4gKTqEfXJqpmYR9oeao2QHymovnFtH1FG9Hk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1004      )
LuQzWO4E9aqaIYImt404LXAiKsd6+yYSsCIKnCejc3LnzIsqU1QXFzr0dkf6nq02
V1T1IGi9BopRDpQSxlRf36gdi/vhk20bL09pw29Dqf76nC9Q96QLb4Ekw/gvRZpg
HT2IhIBTMKuwRZjtKLdH8pTuX1BjBeQM9VghBLW0XRTf5zuyMQGvAYhppeHy50va
6NfQ0kZIzLhb2FHPwekd84rYm3NA8HUwn7WnuCFSG0i9lSkYQhLQRU/4CCYHKYeX
/H7yscQvUTJJpjfXubrmO146GuxY/04hzExFwiS9K4vygLASaGs5QCXzWAeuM4Ee
4r7t9NT0ghiq1Nb7dNDDU+dNfzOgAtZG0KmKdm95t19DoZtEMz9wdywLpP7bUizp
DAPANUrL6PHtwVPr/HDM1+kj/zzwKZG5EMc5sUlFQvVfXdZK31k03FlriJ0y82/d
0T7tZkcqHlMIlCGsIzysk6KPk/u68mJew8JAcjAzlnVeTN6qhDsCNQk5g0rruL0d
vZTjLKHwV2G/86zPk9uMPk7XabZ/NLu3lKU6oaC4X0z8lRTCc/Q2yOUDZnuSXUqg
cjwjWL9OGHYXckDR3YAWgm5mEXGQciRpM/BWkcKdw5TlQO41Nm6DmB+zdVgNEnIM
mmQF4amVonsONV4h99V0BKZdk8L9AD0ZAwXaIGstX9soY7PFImeL5xnBOWhJCTVw
9vPZPIb8p3tperkaOjF9PJrbiSsxdLQtiLyIN6v3vG37KIC4z66XnISvQh7QjhM/
yU1HNwAQGxlicRsF+6IejhRXk+LKLSxUzwcJAT17oreBqlKskTi18XT2UHI3C3lP
TnfBqWnNV56SekHa1rUY0QQFyxwzEEa6S+CzmX0QtGGEq/yjAGFmNH7YEM85wXPi
tqXBcovkJuLEXqhRfecsTz/LLeSkV+HcHCyOItiZVGjqZKtvic6Nds7a3DFJdHEQ
Zo0CcmaT7FuJYtWHh8ferOXj6mXOIjAL8+UPKb0dlzGUbzLaCTkDHA9jFtcghArv
MnqtxAhRuwuQOncG4WfR+0WnysL0s7QzNJG403q1Yd8BtV96fwdt9TPpxJBZFerD
uES5wPqofC8CmeBH6KLrR8/GxcPKnyUhrLrncSxGSstqjdbM4cvIcOO2UsFmvqDI
HYoBtAwndSpigaLDeTWgTMG6QEBF/OLi97uzspK0jeIwrFahzTXbHBlXMrx+OwXA
sH9JjQPimhdD4LVeR3Siik56zn5rQmxleF1cm2VAPkPDv5kggVjdt+Y3yoBNnyHE
AtR5YFrjYTkxDuc/+HCTkGK6wk5UdFi+ZnwvvArneXvJL0he0sna0gnV6ejbwKei
`pragma protect end_protected


/**
    Port configuration class contains configuration information which is
    applicable to individual ATB master or slave components in the system component.
    Some of the important information provided by port configuration class is:
    - Active/Passive mode of the master/slave component 
    - Enable/disable protocol checks 
    - Enable/disable port level coverage 
    - Interface type (ATB1_0/ATB1_1)
    - Port configuration contains the virtual interface for the port
    .
  */
class svt_atb_port_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual ATB interface */
`ifndef __SVDOC__
  typedef virtual svt_atb_master_if ATB_MASTER_IF;
  typedef virtual svt_atb_slave_if ATB_SLAVE_IF;
`endif // __SVDOC__
  
  /**
    @grouphdr atb_generic_config Generic configuration parameters
    This group contains generic attributes which are used across all protocols
    */

  /**
    @grouphdr atb_config ATB configuration parameters
    This group contains attributes which are specific to ATB protocol
    */

  /**
    @grouphdr atb_timeout_config Timeout values for ATB
    This group contains attributes which are used to configure timeout values for ATB signals and transactions
    */

  /**
    @grouphdr atb_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable coverage and protocol checks
    */

  /**
    @grouphdr atb_signal_idle_value Signal idle value configuration parameters
    This group contains attributes which are used to configure idle values of signals (except "Ready" signals) when "Valid" is low.
    */

  /**
    @grouphdr atb_signal_width ATB signal width configuration parameters
    This group contains attributes which are used to configure signal width of ATB signals
    */

  `ifdef SVT_VMM_TECHNOLOGY
  /**
    @grouphdr atb_generator ATB generator configuration parameters
    This group contains attributes which are used to configure stimulus and response generators for ATB
    */

  `endif

  /**
    @grouphdr protocol_analyzer Protocol Analyzer configuration parameters
    This group contains attributes which are used to enable and disable XML file generation for Protocol Analyzer
    */

    /** @cond PRIVATE */
  /** xml_writer handle of the agent */
  svt_xml_writer xml_writer = null;
  /** @endcond */



  /**
    * Enumerated type to specify idle state of signals. 
    */
  typedef enum {
    INACTIVE_CHAN_LOW_VAL  = `SVT_ATB_INACTIVE_CHAN_LOW_VAL,    /**< Signal is
    driven to 0. For multi-bit signals each bit is driven to 0. */ 
    INACTIVE_CHAN_HIGH_VAL = `SVT_ATB_INACTIVE_CHAN_HIGH_VAL,   /**< Signal is
    driven to 1. For multi-bit signals each bit is driven to 1. */
    INACTIVE_CHAN_PREV_VAL = `SVT_ATB_INACTIVE_CHAN_PREV_VAL,   /**< Signal is
    driven to the previous value, ie, the value that it was driven to when the
    corresponding VALID signal was asserted. */
    INACTIVE_CHAN_X_VAL    = `SVT_ATB_INACTIVE_CHAN_X_VAL,      /**< Signal is
    driven to X. For multi-bit signals each bit is driven to X. */
    INACTIVE_CHAN_Z_VAL    = `SVT_ATB_INACTIVE_CHAN_Z_VAL,      /**< Signal is
    driven to Z. For multi-bit signals each bit is driven to Z. */
    INACTIVE_CHAN_RAND_VAL = `SVT_ATB_INACTIVE_CHAN_RAND_VAL    /**< Signal is
    driven to a random value. */
  } idle_val_enum;

  /** Enumerated types that identify the type of the ATB interface. */
  typedef enum {
    ATB1_0      = `SVT_ATB_INTERFACE_ATB1_0,
    ATB1_1      = `SVT_ATB_INTERFACE_ATB1_1
  } atb_interface_type_enum;

  /**
    * Enumerated typed for the port kind
    */
  typedef enum {
    ATB_MASTER = `SVT_ATB_MASTER,
    ATB_SLAVE  = `SVT_ATB_SLAVE
  } atb_port_kind_enum;


`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Enumerated type that defines the generator source for slave responses
   */
  //typedef enum { 
    //NO_SOURCE    = `SVT_ATB_NO_SOURCE,           /**< No internal source. This generator_type is used by master component. This specifies that no internal source should be used, and user is expected to drive the master driver input channel. */
    //ATOMIC_GEN   = `SVT_ATB_ATOMIC_GEN_SOURCE,   /**< Create an atomic generator. This generator_type is used by master component. This specifies the master component to use atomic generator. */
    //SCENARIO_GEN = `SVT_ATB_SCENARIO_GEN_SOURCE,  /**< Create a scenario generator. This generator_type is used by master component. This specifies the master component to use scenario generator. */
    //SIMPLE_RESPONSE_GEN = `SVT_ATB_SIMPLE_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_atb_slave_response_gen_simple_callback is automatically registered with the slave response generator. This callback generates random response. */
    //MEMORY_RESPONSE_GEN = `SVT_ATB_MEMORY_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_atb_slave_response_gen_memory_callback is automatically registered with the slave response generator. This callback generates random response. In addition, this callback also reads data from slave built-in memory for read transactions, and writes data into slave built-in memory for write transactions. */
    //USER_RESPONSE_GEN = `SVT_ATB_USER_RESPONSE_GEN_SOURCE /**< This generator_type is used by slave component. When this generator_type is specified, slave response callback is not automatically registered with the slave component. The user is expected to extend from svt_atb_slave_response_gen_callback, implement the generate_response callback method, and register the callback with the slave response generator. */
  //} generator_type_enum;

`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************
`ifndef __SVDOC__
  /** Port interface */
  ATB_MASTER_IF master_if;
  ATB_SLAVE_IF slave_if;
`endif

  /** 
    * @groupname atb_generic_config
    * Handle to system configuration
    */
  svt_atb_system_configuration sys_cfg;

  /** 
    * @groupname atb_generic_config
    * A unique ID assigned to the master/slave port corresponding
    * to this port configuration.
    */ 
  int port_id;

  /** Helper attribute for specifying solve order */
  local rand bit primary_props;


`ifdef SVT_VMM_TECHNOLOGY
  /** 
   * @groupname atb_generator
   * The source for the stimulus that is connected to the transactor.
   *
   * Configuration type: Static
   */
  //generator_type_enum generator_type = SCENARIO_GEN;

  /** 
    * @groupname atb_generic_config
    * The number of scenarios that the generators should create for each test
    * loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_scenarios = -1;

  /**
    * @groupname atb_generic_config
    * The number of instances that the generators should create for each test
    * loop.
    *
    * Configuration type: Static
    */
  int stop_after_n_insts = -1;

`endif

`ifdef SVT_UVM_TECHNOLOGY
  /**
    * @groupname atb_generic_config
    * Specifies if the agent is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables sequencer, driver and
    * monitor in the the agent. 
    * - 0: Configures component in passive mode. Enables only the monitor in the agent.
    * - Configuration type: Static
    * .
    */
`elsif SVT_OVM_TECHNOLOGY
  /** 
    * @groupname atb_generic_config
    * Specifies if the agent is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables sequencer, driver and 
    * monitor in the the agent. 
    * - 0: Configures component in passive mode. Enables only the monitor in the agent.
    * - Configuration type: Static
    * .
    */
`else
  /**
    * @groupname atb_generic_config
    * Specifies if the group is an active or passive component. Allowed values are:
    * - 1: Configures component in active mode. Enables driver, generator and
    * monitor in the group component. 
    * - 0: Configures component in passive mode. Enables only the monitor in the group component.
    * - Configuration type: Static
    * .
    */
`endif
  bit is_active = 1;

  /** 
    * @groupname atb_generic_config
    * The ATB master or slave component can be disabled or enabled by setting it
    * 0 or 1 respectively. This is only applicable if it is in ACTIVE mode i.e.
    * is_active == 1.  
    * Note: currently only active slave can be disabled, not yet supported for master.
    *
    * Configuration type: Static
    */
  bit atb_device_enable = 1;

  /** 
    * @groupname atb_generic_config
    * The ATB interface type that is being modelled. 
    * Configuration type: Static
    */
  rand atb_interface_type_enum atb_interface_type = ATB1_1;

  /**
    * @groupname atb_generic_config
    * Indicates whether this port is a master or a slave. User does not need to
    * configure this parameter. It is set by the VIP to reflect whether the port
    * represented by this configuration is of kind master or slave.
    */ 
  atb_port_kind_enum atb_port_kind = ATB_MASTER;

  /**
    * @groupname atb_timeout_config
    * A timer which is started when a transaction starts. If the transaction
    * does not complete by the set time, an error is repoted. The timer is
    * incremented by 1 every clock and is reset when the transaction ends. 
    * If set to 0, the timer is not started
    */
  int xact_inactivity_timeout = 0; 

  /**
    * @groupname atb_timeout_config
    * A timer starts as soon as atvalid assertion is observed and keeps
    * incrementing until atready is asserted.
    * If set to 0, the timer is not started
    */
  int atready_watchdog_timeout = 0;

  /**
    * @groupname atb_timeout_config
    * A timer starts as soon as afvalid assertion is observed and keeps
    * incrementing until afready is asserted.
    * If set to 0, the timer is not started
    */
  int afready_watchdog_timeout = 0;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** @cond PRIVATE */
  /** 
   * log_base_2 of \`SVT_ATB_MAX_DATA_WIDTH. 
   * Used only as a helper attribute to randomize data_width.
   *
   * This parameter is not required to be set by the user.
   */
  int log_base_2_max_data_width; 

  /** 
   * log_base_2 of \`SVT_ATB_MIN_DATA_WIDTH. 
   * Used only as a helper attribute to randomize data_width.
   *
   * This parameter is not required to be set by the user.
   */
  int log_base_2_min_data_width; 
 
  /**
    * Stores the log_base_2 of the desired data_width.
    * Used only as a helper attribute to randomize data_width.
    * This parameter is first randomized and the data_width
    * is constrained to its power of 2 value.
    * <b>type:</b> Static
    *
    * This parameter is not required to be set by the user.
    */
  rand int log_base_2_data_width;

  /** @endcond */

  /** 
    * @groupname atb_signal_width
    * Data width of this port in bits.
    *
    * Configuration type: Static
    */
  rand int unsigned data_width = `SVT_ATB_MAX_DATA_WIDTH;

  /**
    * @groupname atb_signal_width
    * If port is of kind ATB_MASTER:
    * This parameter defines the ID width of the master.
    * <br>
    * If port is of kind SLAVE:
    * This parameter defines the ID width of the slave. If an
    * interconnect is present, the ID width of the slave should
    * consider the maximum ID width of the masters in the system
    * and also consider additional bits required to represent
    * each master in the system.
    * <br>
    *
    * Configuration type: Static
    */
  rand int unsigned id_width  = `SVT_ATB_MAX_ID_WIDTH;

  /** 
    * @groupname atb_signal_width
    * Data width of Valid Data Bytes. If Databus is configured as byte-wide i.e. 8-bits
    * then there is no requirement to indicate valid data bytes in databus. For that case,
    * it should be set to 0.
    * data_valid_bytes_width = [log2(data_width) - 3]
    *
    * Configuration type: Static
    */
  rand int unsigned data_valid_bytes_width = `SVT_ATB_MAX_DATA_VALID_BYTES_WIDTH;

  /** 
    * @groupname atb_generic_config
    * Indicates default value Master will drive to AFREADY signal
    * NOTE: currently NOT SUPPORTED
    */
  rand bit default_afready    = 1;  

  /** 
    * @groupname atb_generic_config
    * Indicates default value Slave will drive to ATREADY signal
    */
  rand bit default_atready    = 1;   

  /** 
    * @groupname atb_generic_config
    * This defines a limited bandwidth of slave indicating its data acceptance rate.
    * It is measured as number of databeat received per 100 atb clock cycles.
    * Example: if slave asserted atready with valid atvalid handshake for at least 60 times
    *          over 100 atb clocks i.e. 60 atb databeat received by slave over 100 cycles
    * while max_slave_data_receive_rate is configured as "50" then slave will de-assert "atready"
    * next cycle even though "default_atready" is high.
    *          Once data receive rate falls below this specified limit then slave will resume
    * asserting data_ready according to all other ready parameters like, ready delay etc. 
    * 
    */
  rand int unsigned max_slave_data_receive_rate = 90;   

  /** 
    * @groupname atb_generic_config
    * Enables Synchronization Request feature in Master or Slave.
    * This Feature has been optionally introduced in ATB_1.1 and
    * it has no affect for devices configured as ATB_1.0
    */
  rand bit synchronization_enable = 1; 

  /** 
    * @groupname atb_generic_config
    * Enables use of ATCLKEN signal in Master or Slave.
    * This Feature is optional in ATB_1.1
    */
  rand bit atclken_enable = 0; 

  /** 
    * @groupname atb_generic_config
    * Enables Flush Request support in Master or Slave.
    */
  rand bit flush_request_enable = 1; 

  /** 
    * @groupname atb_generic_config
    * 
    * Enables a separate port/export in the slave driver
    * (delayed_response_request_export) and sequencer
    * (delayed_response_request_port) through which the user can input response
    * data in a delayed manner.  When disabled all data and response
    * information related to a transaction must be given back to the driver
    * from the sequencer in the same timestamp as it receives a transaction
    * from the monitor.  When enabled, the user has flexibility to provide
    * response and data information at a later point in time through the
    * response port in the slave driver, although parameters related to the
    * delays to be applied for driving ATREADY, AFVALID and SYNCREQ signals need
    * to be provided in the same timestamp. 
    * Refer to the user guide for a detailed description of the usage of this
    * parameter.
    */ 
  bit enable_delayed_response_port = 0;

  /** 
    * @groupname atb_generic_config
    * If this parameter is set, ATB transaction phase level information is
    * printed in note verbosity.  Messages related to start & end of address,
    * data and response phases are printed.  If unset, ATB transaction phase
    * level information is printed only in debug verbosity.
    */ 
  bit display_xact_phase_messages = 0;

  /** @cond PRIVATE */
  /**
    * If this parameter is set, debug information is driven on the debug ports.
    * The transaction id as well as the transfer id corresponding to 
    * each beat is driven on the debug ports.
    *
    * This parameter is currently not supported.
    *
    * <b>type:</b> Static
    */
  bit use_debug_interface = 0; 
  /** @endcond */

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    * <b>type:</b> Dynamic 
    */
  bit protocol_checks_enable = 1;

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables toggle coverage.
    * Toggle Coverage gives us information on whether a bit
    * toggled from 0 to 1 and back from 1 to 0. This does not
    * indicate that every value of a multi-bit vector was seen, but
    * measures if individual bits of a multi-bit vector toggled.
    * This coverage gives information on whether a system is connected
    * properly or not.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit toggle_coverage_enable = 1;
  `else
  bit toggle_coverage_enable = 0;
  `endif

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables state coverage of signals.
    * State Coverage covers all possible states of a signal.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit state_coverage_enable = 1;
  `else
  bit state_coverage_enable = 0;
  `endif

  /**
    * Enables meta coverage of signals.
    * This covers second-order coverage data such as valid-ready
    * delays.
    * <br>
    * This parameter is not supported currently. The meta coverage is enabled
    * using port configuration parameter #transaction_coverage_enable.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit meta_coverage_enable = 1;
  `else
  bit meta_coverage_enable = 0;
  `endif

  /**
    * @groupname atb_coverage_protocol_checks
    * Enables transaction level coverage. This parameter also enables delay
    * coverage. Delay coverage is coverage on various delays between valid & ready signals.
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit transaction_coverage_enable = 1;
  `else
  bit transaction_coverage_enable = 0;
  `endif

  /** @cond PRIVATE */
  /** 
    * @groupname protocol_analyzer
    * Determines if XML generation is enabled.
    * <b>type:</b> Static
    */
  bit enable_xml_gen = 0;
  /** @endcond */
  
  /**
   * Determines in which format the file should write the transaction data.
   * The enum value svt_xml_writer::XML indicates XML format, 
   * svt_xml_writer::FSDB indicates FSDB format and 
   * svt_xml_writer::BOTH indicates both XML and FSDB formats.
   */
  svt_xml_writer::format_type_enum pa_format_type ;

  /** 
    * @groupname atb_signal_idle_value
    * When the VALID signal of the write address channel is low, all other
    * signals (except the READY signal) in that channel will take this value.
    * <b>type:</b> Dynamic 
    */
  rand idle_val_enum atb_chan_idle_val = INACTIVE_CHAN_PREV_VAL;

  
  //----------------------------------------------------------------------------
  /**
   *   post_randomize does the following
   */
  //extern function void post_randomize ();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UJ/eE1ei6ZID0q9QssrWGckqBg45zNbG7WKS+D9UaK0rIGCFUxtuIRk9OBDvRqWC
Po0/hpVKUsz+8gCFsXrZVxFRKMgBEMWq5JykTetoBzUA38fgrhzc+zMz0bY6gRqK
xJBUf/IHGFsZ81CuCB6sZ5KVp8H8CPQHV4PGk1UDqFE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1403      )
/IZZD5blHR1GVrAgnmjv7WnA9YkM8KOC6wGakMeF/VRfEe4mHCRGezOblkFpBGIJ
y2AwTm3HyiHVHip8slfkDcVk6xC8WHt9IfQSV9lp0nFrh66rIeo/wucW8Ll+ESYR
6/UuI4Kog1end4x5a2SrlhGmgYyKNlOgbUdNIzjVu0h85AF+zHG7etZA69GX/vs2
hCN6fOPgJmmUPLczchq7ywcWOVBODnkfaDIM3nVhDrnL+mSC8GMuxTFKw3ib+QXE
x5DV2GfQrzjs4lPYb7kqLZxajR0OUMgfTagrFQ4LUOttBf1KkTFreKLczQu3ghqq
6aqYDwXfP5nb2fl7yibOvMQV7tOXsD2HeBlpaZ7BGLZjNAEljUrvVom7NeZjBi5p
ZBdSVm8zed8DccZtY5JaQgC7hoFc45OftR96JOTy/HmQedLxXcE+vwIZw0V5BdRD
hon8D8/f9q/AvzAhVJg/GjUL8AkKBGD1A7xFgNrTV5FiDdVOcgHdYG62MAG6UYqt
nOVtzYxQa7fNvI1lpDQyug==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Li2jvrkH4OGZWundxF8gYKltBTbntVjyVuAf1nAxPkRGOOLC+922fyivFNAzodbp
GLd11a312qEoF+DoO7QQ2f6ectFkTCV7HtKAx/iBPsmWtTeWxKBYhDNwGdsUQATL
f1LuZdSkFOiXn+OGtjiVhqoHINaA0V8jwdGoLz9l32Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4034      )
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
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_atb_port_configuration", ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_atb_port_configuration", ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`else
`svt_vmm_data_new(svt_atb_port_configuration)
  extern function new (vmm_log log = null, ATB_MASTER_IF master_if=null, ATB_SLAVE_IF slave_if=null);
`endif

  // ***************************************************************************
  //   SVT shorthand macros
  // ***************************************************************************
  `svt_data_member_begin(svt_atb_port_configuration)
    `svt_field_object(  sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int   (  port_id,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
`ifdef SVT_VMM_TECHNOLOGY
    //`svt_field_enum  (generator_type_enum , generator_type                    ,`SVT_NOCOPY|`SVT_ALL_ON)
    //`svt_field_enum  (generator_type_enum , slave_generator_type                    ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int   (  stop_after_n_scenarios            ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int   (  stop_after_n_insts                ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
`endif
    `svt_field_int     (is_active         ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (atb_device_enable ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (atb_interface_type_enum    , atb_interface_type         ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum    (atb_port_kind_enum, atb_port_kind ,`SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int     (xact_inactivity_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (atready_watchdog_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (afready_watchdog_timeout ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int     (log_base_2_data_width, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int     (data_width                 ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (id_width                   ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (data_valid_bytes_width     ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (max_slave_data_receive_rate,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int     (default_afready            , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (default_atready            , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (synchronization_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (atclken_enable             , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (flush_request_enable       , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (enable_delayed_response_port, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (display_xact_phase_messages, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (use_debug_interface        , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (protocol_checks_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (toggle_coverage_enable     , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (state_coverage_enable      , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (meta_coverage_enable       , `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (transaction_coverage_enable, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_int     (enable_xml_gen             ,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (idle_val_enum, atb_chan_idle_val, `SVT_NOCOPY|`SVT_ALL_ON)
  `svt_data_member_end(svt_atb_port_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

  /**
   * Assigns a master interface to this configuration.
   *
   * @param master_if Interface for the ATB Port
   */
  extern function void set_master_if(ATB_MASTER_IF master_if);

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the ATB Port
   */
  extern function void set_slave_if(ATB_SLAVE_IF slave_if);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(uvm_object rhs);

`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the OVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(ovm_object rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  // ---------------------------------------------------------------------------
  /**
    * Compares the object with to, based on the requested compare kind.
    * Differences are placed in diff.
    *
    * @param to vmm_data object to be compared against.  @param diff String
    * indicating the differences between this and to.  @param kind This int
    * indicates the type of compare to be attempted. Only supported kind value
    * is svt_data::COMPLETE, which results in comparisons of the non-static
    * configuration members. All other kind values result in a return value of 
    * 1.
    */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
 // ---------------------------------------------------------------------------
  /**
    * Returns the size (in bytes) required by the byte_pack operation based on
    * the requested byte_size kind.
    *
    * @param kind This int indicates the type of byte_size being requested.
    */
  extern virtual function int unsigned byte_size(int kind = -1);
  // ---------------------------------------------------------------------------
  /**
    * Packs the object into the bytes buffer, beginning at offset. based on the
    * requested byte_pack kind
    */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  // ---------------------------------------------------------------------------
  /**
    * Unpacks len bytes of the object from the bytes buffer, beginning at
    * offset, based on the requested byte_unpack kind.
    */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned    offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>write</i> access to public configuration members of
    * this class.
    */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
    * Does basic validation of the object contents.
    */
  extern virtual function bit do_is_valid ( bit silent = 1,int kind = RELEVANT);
  // ---------------------------------------------------------------------------
  /**
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */
  extern virtual function svt_pattern allocate_pattern();
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);
  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the ATB SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the ATB SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the ATB SVT
   * suite. This is checked against OVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the ATB SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif

  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum value for range check done do_is_valid().
   * The max value will either be the MAX macro value or parameter value if 
   * paramterized interface is used.
   */
  extern virtual function int get_max_val(string width_name = "empty");
/** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_atb_port_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------

/**
Utility method definition for the svt_atb_port_configuration class

*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JQfE9D8t22NZCfnWHiUefA9FxJkC/d6OmkI2whrzHzKQYIHJeDVp2P6SCOrGZwIh
p8da1Ba0AvKhmYxSK4GZEDfUx1DkElWy9gP1UnGQcLUfiAtzsJu+19Pgn6CRwy/g
yDnNbp2/I3S1XXZe5Ni9jceYw/n9k3WbXR4YbgTbpPs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5075      )
f9MPss6u//qqBn5iBTVmJwMMk2DvMKfEfjYC3NdnCcAV6JJ3KQQvsiwU9mRzMmJf
QD8we4zI0gIJfgZtuSrBX6Ooa2hUuHoMTdD0Sxo0+RcryB+lFl2p6Hisndhe51P4
mxCVWsKgk7GFG8wb9GdwA0mRxXJALmlwOyxZDv5hOTBrZllOoDXVQMKBshSVHtEq
cnmPAXLCWtsi4zgsFZW3lcJ/M2S2COwbW1qrYdV4O8EWAxpRTlpvcBZ3SFEh5RS5
4oPnqdz6+xi6ioBVAz6qUFiw3qOziNom7m7j5MHlqP9fklKXMJakSZ2xzSwQ5gti
heT7xkT5ygQQmBygEfvzQFh860wSSzjIbw/HrmM6w9w1EQBVGC40IQUlV+ZcqZS4
e21Rs7QdXswlqCbrnW3n2tHW/K3MJ2mXGdL5+dX3QNoshWR1AmHgpcihxqdJYzV5
g+ZembMHqSERyiVc3bsVeZaetFxrtKWC70e8WoUocQj9DgnU+07T+Y0sJknl/LPA
mbFLEZNqPckc+fInozWiL2r6PIrGBWjW++TwmT9ppYZX8dnhGl9fqVopHxYmjshH
28KXNmuWcS8M3tE+WXCdTDah4CenO9Esmx2l2HO449Cd8Jf2JM+NX2jkjgZ3ZKRL
CC7YWd78JBBJ4e04di3q0ucD0XiaklPEA/7cw2+Bi8eO8uj2UyPxWhfG8ue++iw/
1W2zNwNjnryF9/6EVAtcgxa11bki028jVyz1jBgQVaTwd1tyKyB0NtIlTaE7hcG1
Pf5T09ffjX3KdWMkBzL69oZUL3cRNze9EgGDj8cQwJwU4Bg083fJu+TPLgWO5rJa
e8qkKxzWsQDkJGEIUcd1iHN6Y3ub3VT6wtpF2uDkSg3Kfs0f23sy6e+XyyZwPACp
prVoKoiFq9si6X3dHP0Dayn1hPcKY2BdCIbfJNexnAv7VVE8xQk2Jp9VSbLk2wmt
igJ44CM6f27YG+7ifAp58MUpgiN4E0jvAhPIkgcVS1nqrEbrR7wDP+VkaDpb73K/
E8gx3UFJ5vVdlUYkZRN2ClxkyDleHPffGm3UX1WXxljUkN2KEAj+Y9UkI1BZ0DXP
XJ88pvA9V5ucRtRF5fRHfP8Vq+QzU9lEwycd7X4Cd/DsqXVKoJycxccP1TWDhnXR
CotCZtzqpRj4/1Kd4nLW/BmBH3qgemFQdrWCXscBj51q8zB83k4kRx1MQs5AHIwO
dpIWGg23nEW7a+gDZ3qAHdIgLrI3IUbqLsrFmVHEw2tgTgYVksjEzwoorBw0pri+
prICu2kqVLFnbhBsqPKa/6q2WZomyPxtBct7I8RRn1dk17XgRPCVjHAdCfjs3PcR
msHcihqrfz0wEBV6BcFyLUgOzsV4C0hZt09SFV3JTr6So2H6+BS92yrjbyYds2zd
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AYxrXQSa04EZoDE5bP7GrI4m/LAME+/CP+zq8pYtQ3LkF0gx6sz55xa3Fv6sofPL
a63YgFLixPAvanBCYZo7VAOvh45hvgj9jAdSuRv3zY5CH3eJWyJaW/JFaxWtA53d
CPsi+oXfjRtSeRhCU1PaZbcw/xv4M0kAq1dW+2oUWuU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33666     )
efMDcZlPAgxLcIwFORwQez2va2vMKzpC8Fi+PKxuBaaVP3env90HxNThi3KtTxKC
03DyKC8T3wVR+uxrZJsA+bWCxGjaZxLK7kHBy0nLp+uWP8XrORxIfX5bLIveID/u
qvvQ8WltniurVRiKFvgPN39I/azHC8V9KxuuSDY1DDZW67NZaofipTGAY19QO/pO
VqOKR4msw24sF9z8j1sMrnrbBx7LNVOESb2LCdMcycznVJ+b+Rng4+62ZW/vpL2C
qZNEp5xqfX3jDAte0SwasxEDTIicHIj0cVcuLrq3M/CpWf1NKR1iMFM48BFjDy+S
9Q0wjlc86SEadbtT2e+XsESjWC+xzqlFpy7D0wExSYffPXhb0zJqiuAG3evLEZxa
J7lx9PYN2vmFYWZ7HKz+YVGYw5RbLZRBG3TVdZGBkNKgYrLwH62kgPFm8xkoDrMa
WdM5jQ5Lkeg9tLDrab+wGZpNI3xTnZN1iXqQyG1BsVURK5aavBero4MF6aHJ/kRx
bgEvMrsa2LyW3uEJWvK2O5aQ/0Ww6M1O7nFd9m105qlh1EG1Gkl4UqljW4mxTRO4
LcVW816UCwXjK7CwlI5cnIyJZ6EKol3oA3HKKazWs3lkxtlNqDiQ60qrE6j/W6p5
xwfugyoin3BuCTiGT21GUxKx9ZGc9RpEkS+MvMeQN6+wECoKkZMo0Jf81Xyu5eyp
16X/hyz8acW7YFobXj0d0/Vo2dN8A97uaOnrhoPlrU6bj7cbrkveERADsWpvzKWR
LhAZLf+wbsZ6a6IUnVluXhrU7d6EByUNPk6AXFAZMuPFxfiJhgZ6mflImZQPyKfI
Fxdt9LOR0yY4bUJIRyja+08LkkEhrQ0LbdJOVG6Z0pTNhuGEGsWWZphkay52Gw7m
zR+Xkl3ds/VUPklQSH25/aLUlkN8souLVU87OFHYbNnHjrKnl9X6KUyh53CqTAON
z/CRDdWu/H2et2qnaF+6IJP/wYo8y34jc5ubuwvVDq5tfk6KOiOQxsat+JiZqx+p
z/AxJWEPAbII+R1CIASVESWZzb3Rd2Fu4Edh1il6NrCntBA9wPRJotKZf7n3tLOX
/nrgDvfXNL+PPDmOk05aaPc+wZ+jpcVcMeDlLR3Y3HvA3dj3mdxtnNdrRCEanmiX
xIxcE4bcfyNmr+vgpmnXkabmECPRWi/0HLIWcX+DLQpJfQOSQ1KFFNJ6LrxasWeg
pOcDap6H7O0SONLnYOGWnGTgv3l9pC53oNfaoMTKdafQLbCDDrAGaUaidyXryskU
vxXiqs/fhCeyFKseV+P4c7cDAtPs0hZYtP74ACchpk5GN7ng7Z0uUY5e6o2rHt8D
pS1RUKfpSYoUIo9haCq4eUvtHgEbm5k3r4QcFs0GjQJBn0kAUW01aRMZcvhWWYQp
BAv98rltdlrVFIWwnTkChm+ouFJQkv+6/R8tPGQnPX/Uaxib6wV2+O9Qo6yNbR2M
rITvlO7i9V5+UPrsUshvXhUX0z4tzGpqF71zVZk9vtnXkT9DRQN9rPYksu7qSV7t
I4HBrxn5w+p0AoaDAkA3pTn+RcHWzqlCiwg16qciIDRhiRQyZmhQbanUZcGs5RmZ
kgkW35dhmw87o8t2FauodLprQ2WEb7TV3ZcOIyVpEsOYgPz+GiWoP2I629uuhEv3
NXbViTMfDcSbz8T0SY80FzJ1DMW6ewkoIytALQN+Nkt6wjPX6y2ET0qauPp8C4A/
9tiDcszm12j7TSKiOvvCnWbwfPVWT2aXkdePVVFB4HeY0XUpAn+pEOUHaMBT7O+Y
a1D+GqX/hBJeUEJ1XWvDSrdYI65s+V5OXlGfj7eaYtkczPYONQeNg2aAbaWEd36v
6/iPVJUoIbrwKDDKiKNFga64Uj2E4QapDtfbNTX+S+p4QhB0zVoe4DpLUaSR/7y6
RCevld3tl5dAKBQmStJ3C0/yaFwfbEjryEcS7I8A5636K7w8Z8nT8nXznO0AGI1D
JfMhReEarO+IkUIYedkZLEOrUvbt9bf9Rb9JY+4J4DXQXZmQOqDDH6E6cOOQnjuz
ARKM/6ZE/jpyEIRIc/yUypdIPlx+OSuo8nyKys6WhyzclLW//5H8ftJfo/UhhkRx
7TmAiibbOgbOuw1MV6GxwNPVqOba0Ijvu+mYPOpz1N17cGjRx10A6WzM+Xf+J+oX
P6E/jho4oqyOKp+yQzQYjEInzFZgc5AqiSKKoqDCojwF+ca1rpzsueOHUb87tdLn
agCPgDZxW6CNbMncd4OrdWcIZtm69hNnGQ5fWs8thEq4dyLMpULMv5dHSiQ3ybyP
sjo1Uxia/ofaqlEPnlLJC81XJ54k9iO1TRit06Wvf+6HLfP6HPH+/h/02Iv6e5tp
Tfz2oLB0J6RxoOHaNldggFjC+wXXN/Bv9F3C4WbNWf3s79J4KavONWi78zQDtufX
FIjNcoy/MtiH092c4UiKRdkqFn8U/sp2ngNqJ3AFxnLdA0fivmRfCfJvT6bdF2qd
4FqHWBzCPSyYBufPSPUFgH79ylU3Qm5MSbT0UkRBCHd3R18i5RExSDkTH0an5v79
hl47oTsJI7mvXsRZh6ZmKUprxmAXtlalLLa/3FjtyiscMsJKFqP9H/ECxKw0aBfS
kwxDs2PebjABnVLGUcS0a+OX2y2sqkvF9aWUQ5ECw08gceAZ7Ix8qPIZOe5TaYsv
pSfdqdtLPjToNZrvxIZXOVz8dDm90cie3JvTU1DxPz998QGrFmWV3u4LPHLtqypn
71TrQuxt81AqiDDWQW6CLZ8ubE9LnJ7exRLvsJ8oaHwSBwCp0uk1e7xLhneE3eJ0
htrBWTsye/FvikBalUfX8YOtyR8GZ7mnMDXoxtX8xZPkFfcxgZyeR9koXPDirvrQ
l5iG31rDY0OdPBGSvOh1daiELtn0vCFbRCCVcgOOHWrAySRXd06L64a/asF+GWIA
l7y/trBU3fMp1X96C/uBHXwAu9r2HNcb1ssKcq0G1njRmLlzsjCTNOFQzQ4hlOVu
DFZ25FbJjVXrHiNAKNEloxPns6IHj3YgNMouoen/AkFxjv60ij0v+w3PTn0oFJhZ
aRn60DZ24qgUMQixKxHRhpoe9Wnz3YPGjrvzeqhci6+WP31LRWGdsdyq7y6Fs5p7
10sm0TUJwKhop3pJzEJJmZJoy0Bw1q4gWlUNlg7t3EdzmVai0OGocWOkoDs395MU
x8lOqlqQOJn848wYXt3GS5FLUO/E8LREjY6GXll6RYuIy27vORk615F/0J3IYZxj
gue3JOrpwBwIFZt/yVG7AOx/P6m2HjKqExzy2rE19PXTbSoqbAwcwZehf8oRSpD0
dRmz3Y/HRE8D22f9DaF35MWmO2G64sgAQuYbWEP+UG2H+MPgkPDEIenpkiiz0aWK
eC8vyXUlllunZgXjR0FJ5xhWkpPnlKEpJDffa4q4u26XXz85uazucb0lVwwQtwgZ
LQlu1EQ5Al2x7f95eqQii74RiFqGF3xg8cdMVIGU0dJPGTyhIUEgIcC0AVLyY1Pz
ExGRHts+uHgir7S2rUsrziiojb6v99NxUJBUAF9bKjJ0X5RsOHzQ0QohIIarR1qa
00kXdEykx3uBlCSXNDnCCu2xHndj75bOuiYHWjSE0Eplid9YuGEbS1m9AF+yVQWG
WBmZJGpozRcuVyFI9/JKI652ElsIt7e0XCUiVbtCol0vG6iZMi/hPFkb3UHyRD96
f7B9LY2ckSzEYQ/bdjTXYgHidzVr9eqsadb4C3k9xkL1+gYxDJ0ThehC6jm1dX/n
Cifxse4H6UTOcRFxp+Cj+sRFUlHk10qtI+DcYD4jlmsKknQ2l9FsbUpaPc977zGt
krJgcg+iN0rekc8TfyKspw/eAZ3VHNo+JHrWqvrL9XCZrgBaEpiiy+AsMvdBVymx
rJBgGfZXGxJbSpeWEP46C6c6SIrsgFKUVh2JfZnSoMsjEfura6spY+KbNE3jZo11
yhbe+TlSk5so858niAAiZJ1N+l7EB6nkjtnb3yfYye7o8BJpPWk2SMP00mAO9qbn
4NOGUWbDGWXLK3JYOGEOo03xibd/viREYocNnRoSKN7aJmIphpq5Wd+sOKRK6rIU
mdFDQM3731Z5vMR+tv18hBwHCZmL1HUGXHTR3vVJR5kVspxk2eZjMXbSI+n5OMgS
fPyn8ER6+3Mp+lN5Wzv2fYlR83DZ5iSEVaEo3xZ/K7bPkEmNHRISVxb1NU10sYg+
Yq3OyZtHDrn/GKdyiho0YLefHqvQw90YE/P4AiJaxtTepXvii1poPWl1vRBVUmgE
bdJKpjHWMLpv7u14b4ZjIPH52SzkLefYISaD1aTWaWnHPtpbV9WaX/Vt7aTxB6cO
geJZa47eY9Z3rEHJ2GkSh3VN9LUjanAPSRTZX1Zk2T2wYH0e0bdYX5bq3EWYSe/e
JUx3oxBJ1WPnFwIXEq8tb1pK98kTLaaLtoACpXcNrozp1EyNm6UV2lOzn4EVempH
+hYNO/+O4iKRzvzuOKV1ixp2d0BuKf2IMMgaO//6eOblEYg7iwmKGEDXC9GYSxcb
mzZ6W1O9uSVj1Qn76ATaQCxO53d7JG3Bm/tunx5m7UkbfSK0aEoJhIQN6cRZoIli
QyALyBBX9IOZ5pIf/6k0Trl/LPjIR/zL5xmMdUnSBaUY1iILlRQ7zETdyX4NwGLw
93oOK0j6HQg3S7rIePteIxHD2GyoNz8PX/9VhdyZzKhs0/F0FQnePBGcbhef9yJT
aVQbVHVA8r4v8Y0uxV7OacS/YzR6IB5hZULNz0XsePcKf7P8B85ReZTK4BLl5OCv
ntyOHITUvqS8/g/lxocg+Seot5P5kIrz/hYsYHvYYLCIwprYfeOvcSqcag5DGZNw
MwfHNsarb/5larg/AyaEsOQBtSL7xJ5SqJ2vmk4jct7JUOpJpGTWv81BhwvhS0Om
IIsllP+s4Plwj3zQkq1sKOtbK/gDMf79TqSW6CfwsZhXVO7WeqdB/YHhQOYg0OaN
+1goxFWWp/I8/Hc08+FmBTQkl+4F7q8qiUJxz1Fjv7DygAowMxaQO0qMo406lT3f
q4xDVjCvSmo0GfbpCNh/pUcfqKsMhKpT645KkfetFzlEO/s14twyudYzbGr9R7t+
PeFRjmbcKphGFzMitwZSSclxlkugGidUmbqLnsMDuuZ2N9Y/Spv99zDYNK05B+ME
UlgAxMeg53VK8175t+P2edOze4OvE3uzMu7VuB+loZn7vYe1eSZcQ7KqBVQuAkth
r5cPdYrL/oWlIfbB0lxt4fxNJgbvpopJ5yKMCfFu7g3VMDxhFPb5t031TGS4t3ub
7LY15bas6ERoo6ll2dCQWc8sHAyrK4z9B3Q6dGiKojjF99iUpZ6TZFCPDSWXyCI9
ciYBHCnXGkfup8c1mqlkETrtbssCCH2K/MLm2q2d3ZSnzKrjvyg7UNAQaxgM95Sv
pxuy4IwaDSIwuroFyJbsARBuwi87v15nM86HH3k7iBZw+STUNQI/Ux8b74YfHS0n
AI8bDecB3HbHQJwTj4wAt2J0joyA1sbVRO77fdDKH2BB1Kfrnlp6tHeR9/5cB4yC
UJpvAnO9FO31Autg8VfPZ8RLNpTDvYr17ZvCSyYN+pfKYPM59D6WRYE55DXxpK+W
mTsfIUIWaVOOZK47AxvJM6dwRkGbDtk1nv6/79Rqd8ETcvUjnO+V+8ZQRb3HCIdl
tIXm5B7/+6VO/eePv7B4Uy46qhqrEB0ARrbPibL854caMUzN39JxMXItoqlLhdF7
nQCxXydq+04aMgbF/6+VKcPnMmGdlBFhTWmv7g1GqTEXrGT86qD1blCrscYYi3Mf
8C6Oe9AvSGmbOuvibOaezq7j6whCexUGJdpxeaANQ/vUR3Zy6X5UOZaD1WlqjNFk
Bo6MncIDKJnNtYJYRGwVDdet9w/WgeJXhVaZx9+AlU35NQXI+AGDxq9HuWDqBxIi
VZngddLGQ5meMkGD1bxkT19RluHWwsDljXdZYhJJVMMDIj0Zv2xy0YhHikptk7Wy
ueQyBk4DPVhmLOTxCEtJZY66PLabAUXRgvIgrl9298iG+gQaHz8Ae5l0kROB1Nf9
IMLqZbr+1Ko1FYAI3IAkFOVYq0DiTPTg4si2PAMT1hp2dO0Vp7rgU8us+f+6PkDa
wCadBMfFsuBaT736TCKMOJU8MCEPhhyteOH7WSQbBQfdKJ6UZvuC2yCwpqRgOb24
RJW/lM+dlHjn+MIMQuwVNIfWSQH+k8kcjxIgUZuNOXhNBEtGdxy+nm0OWxBQQCGi
ShpAAUPqwAReU8EdW3XQ7RYW/n57eeJBE1JQhiGwFkm5yxvJqeZNk4P7tX3JxlqO
ApG0BQ+2HmqGJmdxhHh6mLGUM2Ey0jrMie3+RdfhlV+I5IcuQj0Yn/VWUKjbVeHk
W0Edn2MHgjwnz0YTXbpuVogiQyYpRFHSEazMZOOv5r4VfNxH3HVFfFuWRqAWN6dW
iDkIx6cKkT646YIyzQMGq4B6rs7GAJbrUncHwgxkeRm+z5juiG7wUK6rM/vW95Uj
tSoeXKqh0fsMZUdnm+8bK+YPaGU8Wpn7ZZjypotE8l4Kg7pnhIO5hKgMV2z6pcfg
u5NTJDZo9KjYmBHKK48Ia3iL1Uyc9+gBkK+uWqUPlBTbHUFNpOTEajagPH/SR0/E
/yXZ7tQxE+0sICF89kEQaNSmdHKEKX/0liGDk/coJlZpEgzrOBRPTmqTQ33c0p5y
j9qG/tZgRMHV7KWTC9m4asnkRsfQG/wCsyTVbq2ux2mibGSqVRte50S0NjBqcCk3
7dAEqwckfKDgdwNU9uIzkDBOK8SOhKGuUjG3SoZoYa9ZLvHJl4rgDkijxprCNKLb
1uTCis3mpwCdY5EwEkfL3T/+o7Da1pnzrMwRqhnHCy2hgFCuBeK6gRV5bACIAQyz
KU594AmDYI4kCUpafeGXcK7VBBTS92D8NuncZOdMK2JbwrInOIN/QJUbA7omBL2a
U0L0IvLcdmD/Dc22E7Pgx0p0cYTDPLCC0JgUe4F5A+jPVKIlLwgA2Pm6e2ympHg+
8kO5bvB3X9Ojb/1GV5i/Rm31HGOAFJX1x1bBHm/vKW684TLRYq7Rc/qMJZoKXJd/
HDoDhtvjkMmP3mtRbS3vfoq8Y/qAUcKKdgGzaacihSw7hnC4d8UWINukEUT4Lae+
ZJ8j9Xtmb/aoYvkSvr4KZPDrp4+D3LURqErkVuYr1unyuGNF/Ba3XlCO/OfqaJ8D
NuTZRCLAPh0gw4sfbCv671jTR3paPSJtfhP7X+3dGeFnJ/l5jqDnM27saa8/9VK+
OrgPZbWL4fNuHMu05KCbj6wWc3l2fR6976YesZDmFUjPYmE08ar4KUVsas96oFQr
bzOVBIuxMdbrAsQspCfVtI84nf0P7ytcT/C4AdZPSIv4rNShjrXjZYWlrgUnEBTx
Gm5VjpB0T18zDbch8FMxgSDorNyBr9lGgjGgIw4q2IPbiMFAng9jXaz7ArUZ1aMo
ubWKMGULg5cQBHHG1VojdO94Yqk5UmpolX5ZmcniFvX5YoqfTgc32/srcxMsnAbP
NOyGPIqov+G6zahY7eN6bkSMk3lf24xHJXzwA9sUhjxao8xdgRsNPaRr7XxFwRq+
OJk4NNQwlo0MItWFsVZF0IJdmupYEyk17W156LMxNodTm8pM77eAa2gyy3wp90Hk
X4wLnbFj0N71Yh7qAxO4diLn+d7rflQorxhw4dBcrPhpp8oGOTI9BvrXC2xQsU0q
gVvG1dcIkww4UleKKtwgMsj/AC247Ml22F/DuHIhB94wHFZS0COhHQjyWiY0ALRZ
7kOb3kp/dUxV8mWWa9ZgR3CBHrVE3ubCN0vCQ5503yahuFfWhqzFlbtxsZs/emIG
6vDTP1lsPQozD991d7bfWvsrgCixMLlYg9mK265Xak8vVm9KZQ2mowWXPaW/H7G2
Dt5WPuVmiqrPFE8s3V9/nIgJuIBPZLh4P/BvlFN126Z46/+fOH7waasdz8MPrOFu
3hfNhpuFYUtHz3x3QuKc7YTQJ1bRmScA9HjCf5exZ0DHEDBud/DC7wy8MdAPFKh/
DrQbCbX7T4WhogDlFX95dxaphmPMHpJA9RhFUAexYNSZ5apCR6Aokh8+Vs05K9IG
CMwVVGsccI013pyVL4YmU3ArTH64pocHqRD8XKi/yQeCOUL8eU+O1JtEbh+SqYFT
vaj1yBoJA7yBH3CjoR7ZiaGJPoTLEdhe7BL2TEpIlLUvb+chtlXASx0mJeo5yOMl
tHjB2+3hsuRbLT+2onvXINSnEdrj5pXzjSW6UFLIsV+sjRo8ezhKTRcBGWdBdo95
0UtRU27C11gOfKLbL0FguAP5TYhEhb2nmtPq4J9Z26IFvjzUAn9EaJ2S9yoew3Yr
N1Ni9suBB8SedPUoJUajifNH+nlMcfuI16ZZF44heT74IPEbm+FXb1REQbduM3jH
6WlmSJgA5kaI76jy9qDXEIMhIZnNerB8NSb0U6sO6EogDOUH9eByiRWUhozPm950
EadaJqsIZIH7dygmpmLRxswu2z5AjsabRLM/GhRnZOGwUwhwdPK7x6YB5SiL8vLn
vo4iPtHp1SvV9mT9aGet5H82/D39PNRpx78XkTT1Nbk32hhIIgfEfGvUibDPYAxX
zbXY10z0MTQUxf8CnbTp7jDgOetU2bblvbpzOYQ5wxOxfibEVw7TDLfPhmGBsBT9
mkD6f0HZ2rOc/SFoQAxkm0lSbf6Q8v2AxXGYvSl2hNXlQssFtH/CVTkIGRfHTjuK
fRUieKfSC0b8fQ+uVv8rXK7aA5d1Vw0EJ94229/2dl+VHNISXBQawifkI3HNkCb0
zHxZLIrTXfOTyrgTJPM/uuK9JU1Fmws7NTY9DSpj3MfEdrQQgnU8NaJnezcT0hTg
36J6zll+Td69tB9uch/NL7h1g+JpoA+Ps9IfNCZMj1ObUo3ZB5zLT0+FugduSsjz
srkaavKfmUFDgMiODAGPHG0emzEi0RxOcZiAlg6V7iIDX2ZrIy94PqbGKF0n35ai
K/F7lggN15AQRRF+kj1e39IDV7mTNxmpCSxLaOnvdicNZhLnCIqRWjo0OYF/t7rq
x0j/bZc08FH6U4fYRMLVrkP6aiRLti7OWCjnNiT6dy5L3eyvrAYDhP9fWfEeNEaC
sfkC56gN8klTJMoFbLF8adlKvObNt+KhnkqumLK9NoCrCHUDDj+4DHzCReoMDc8C
dCjaEMRqY9LhWqXCZBv2ik+3IX7qLO/Wmlq2Jlgz6sZ1odMOOCZmZMI+DaCP16Vh
czsFb2huT9bwJGKKYh3ZekbbHzdoydAIJZTIQ41vhzHUVIcBYvC3XPiy0K449v6G
Cfy5nuLOYn8MDKn9G+ySV/rPPhoIe7RHic7lU7FMAvfhyKV613I9RJl5Na8LD1lA
tAq1kr3lsXWbw2AtsBrayIn+pOuf1o9OTSWIgF1SkKxp+Yd33Q9a7ecAbw74O4cF
J7KODPwTLmoNIBqElWi2S9Gt+eAo5AFG7VsGoXCJXDr2ubo4ANsIpA2AfOxYNlWo
SuCHECNeVH8v+0avdzRdt6bygWWdqGdsdssX5ufU/lsaKrmZIqxfKrLBTrkL7ret
kwHxbyCTrIRRETNj9i/Vx+lDAbTq+01QtyjqSN/c1r33Q+sfqioaQTbWf7BNKbaN
88IrxQsEmKjYRHYP9a7/xh+wmOEsYk5RAj8C0+X3epWFifZPQYYB2hUutCozk+O/
Zkc6oL+UvFg39IihEWHeo2+Kbf1G+HMizjc4AwsYmXnb9NeivRIqN453MOGv3Nwo
5TOFwOPesTJXNeqOhaICsMSeOSNddDVYrd4W4Qxf7BvW+aktFNeHTZkID1PjlbHz
XtCAdtuZBpb/hk2195Q8wxr+CzJLh3lPyRGDzO8BFLy/GSb2uE+XzA3PqlparSIr
5PgTCGIyfsLe8uBus7yjaM/6NnOPYLzlm7jAKmahiNd5K9eXWwSaGacFexxJlYsy
CZ59uGDU4gqcsjQ465bv/PIdA84bePVSVxssGI7yTEFTvlqUDL1VI9012MM/q2xk
tgsH7WEHru5Ty6lv9HAWb2lR2ZPCoCd5L+4V8A2YI3GCmYBRtOYr86ZKeeM1TYnI
oZT0rBNPooJ4glXZdpRNCDE3JupTCInVLdQVYB3En0P0AieHeKYlQbZRADXc/1Hp
glOh+yOqqsqWQeor1P9Nkw6/yvTPdDpdSAVL4FfXMe+A2wFfbjRV2quPKResbfYO
mE3gKAfNWPg9j1uBoi5+W4Hk1QSAEM8wbPFD8JFXzXmdMjJCXPvY1aiMrAPvrD8j
edJVDXJQF9miSemQp80SJUI85bmGW1fniq7kMHM7vbW8h2Gog7vtcTOGm44VwrcS
c+/wr/RimQ2iExNZvZd0t9sIcf/AtkPEYozEW2iPmSbwBKQ20f2Wa6IQyHR9hNf8
9/gKRRTi0D0gegg/X4rkSsuBUk7SyaRlt6Qb5OA21KpYjmalJLEV1FODq7d/ySQi
lEomreaH7x2U1gZzDJoKMJdsOCDe2y/zCPpxauWhPg+kfcVyoSn0B+jX7l3Len8x
B5BJfqiptXCJsPUhBtzWnW0hpKkUE9EzO4OQ+/A73+vghnG8x13/y6Sfwi3dADtc
kpUaRUxmw/+lvQv4JnRMYE1uwUekXU+o/uGrekEMokcKkIjUSGV/hnbYk2gDImHf
RhKoWM0/PsuvwQxAzulWCTtnc+3jYBhOYocOguN8Ytij+e9ejxCWzyjuaxR7CA81
OrFx+5q2+WM0Abj3g1Gj1m3uD2rRbxZjwhpCnqJZUrWcgPvhdB4KR/UTT299ScYd
LlE93KqxsCd5wgPXCcRcz/vpZbYKL661KNMFn3rCeATY4To8rAzXK3uvLbVOifA5
LlDrObxc5R6j4s+mlducgieY14HtexuW5Q74oxZFefC7U6MhgLYdjyN4NThOIfNp
vc44OMPM5EOtdN8gt7a89zDfleOihtDpsZJgjYZbJ1ooQO/KV3NX8Ybvs0bQa3W+
TJ4DOQBXpoFDilzil11FTi1LPXlXs5SRKWbsO4Xnt/L0bmrEJypvn6hjpGZuQVIN
vcmW7xd6Cjb0iRYN78CD7YrXTUJxN3FetgvCmniP4mOgLdsg85jln9VpGc0GYDmC
x8dK7jndhcC8dQtWDaO39V0x7ZU2xbMg1vkDc8m0cJOC2gSrclWbrg5DFJkeSGhX
GMW44QtOkJNJuJ00tD8kWI9HtXEFwwQJxM+NLEYK+IHu+MKQZ00y3+TZ9Dmn2ewZ
QP/+rjEvC51ASS3tW2x3iJ0iP8qZcVbOT/j+qahZxPTmPh8UXrEpuKCZUqZe5L0x
XVkxeCIlnW0G4ltjWYxEijTmw+EnHFMgaC2aCHWLZ8c8pGZqX6pv2i6fl6uaar4p
eRuNXHOu0KkbPJY3Szl57TWmI2miiM7SFFAGhuI5qngl524U/UgF6d82CXFkL9GO
es10OLAOSHTn2kd+A2RMpII3gT6NPX1mJaalwpccvOQwnPXlUgrqUduC7Wb8X5uD
NzKwU8dPl/DjUQ9OGGPxYkdSjtX5q8LVhjKJ+1E1Yf8tS/VAd8BeM+r+NuE1V/M1
OfJuztWnM5l4sU5XJ2Bsv3CH5ARZhrM+uZPJnkzyvu1pRwnL86FJ6l5KTeBsiv2A
sNxZIn3oozyF12V0TjPYPaWNvnQIb1ZJd0f9FgpxL4o1vA7VvFySI5XQZ2ADdkol
coOBF+kOG4RYnD+wwPiv7X5JfkOD359/WZvpak8kx0NisXONRZdSn5LWJZFT3w8K
NTcAAFbkInvWXwjvU3u8TArxu8XM38Cs0ljraBepEGzjbWOj4XZkRu8nAyiTJF3S
4V1LAhLo1HuWD31BcP30wVYEGzagE/bWx0BbgUyCbAP1WNt5EOiluC3lhYnDtVSI
9ykubssIx5LvYikLpozqHekedusoCXUAbVNcMgtZQOXdqkwvqICIzctdXBzvGrgB
/I6Z5rtvgCgF7vNkqllB7+HWDEBj2VMwOyDx7CGVfPPhYC6TIvKKG7jPaXuIUJZC
+ZXeY5HP+L4j92h7smxdqAy/aM+HYoa65rBb+2f6hNPFSUM7KbrzuvyusPuRo+A5
cBsO9B6c8azm8/gUHZpkM4r6nw+IkiHcFpHqakTzCwb0Qq70IXO/YoVAI1RDsbgl
QpIGRFEeWvh8ch4RZokl07+U6xVGiUQXLBm6ECizIl8fPVsJd7aYbTdmweNuBFOg
v3jkmcm6qcBEO4iJ0YoKUWg4T/7V+/1wiI4YRni+/JQWaQFKlEa90Ch0ijJSJJ+y
GuqbP1f6BjNaZcoRD/WRmkPR+MrOVJO26glxkYRkuYVX15p6h8QZMC8ro7aQXK+M
oKgo1GLSG6Y8eYeMpeGXBoslL5kDzanCfwxotXl9Fru1IqYcTmRoJ3AD3T1od32o
/QuPtdQIakB+10nWdBtlr5buh+7spk4voWJcfpFgDCOak3J899w2uvRgFBn6iUVy
6rzQj5gSI7CkKwlc2eARWb2uM2+ERW49+8mT/ROjjnjLjOBFT2CziZFMhRH69Os5
Te0eStdwbZmx2PmZ8GSNzL+Y0j2Av8OpikCtRlPxSz0sQ+z5G3tOQ6KVVPA9Tcp/
FqmDHpl5UwEV/Cmn2inNwHG2DYzO2gO5jzSjX8JRNdhbhOFmZTx8yg3su8WQJyFL
qcEnwPVJz+vitfShAVcJz6zWPIw/hvmJGGN43BmzO/Er2NINZJex79p/mMxsgUo2
CmN/+RV1BRWuLKbM1FWIQi1Llg/kUnHNgA6Y4C0cvmrxzLtycS/AgPGEBps2bsjS
p8dP2pIlNer7JgqPxFb9wQlpcKwWd1+QCi3HD5WhFvc70jk/vqvmmtNTfTf9XxRx
xghDbV4v4XqNIfOizIJTNPxlFTvH8PePhyWHFFFTtfXJCK1ugoFsqO8jLALShnTh
4PdFLxYwouTDTY8tYpvctPrMubklcToD9EjGiKA30guH10LM+oUZ87AH+7jNquoC
I0Ugj8yYfM8GaremUk2Ihx8lPq9OhtWHVTlV055TC9qQEZ34S+JXWNi5ScPtGJFG
9cktBYj/zGpB372ZYWdF6yrJ4ErAn4IrYo+9Ut0NeMuTY5D0Pz1S35O+wHYh5Zsr
fDXi7xvAFKZDWRXBusAcyy704iwoauORiBfPpyGkqhIYe027Jm65+/ATwANRYq4+
CQMQL3412AOguS4lH506tCxLkUpDT72JmZx8QBblH8jk/kv3n+nYZP2t2CyE4XRf
HYmjsJOwOsq0pi1Jp+zJxrUdcGQ43eZ9acmuHe1FXeOmb7h5037ulz6KmbSWIy1M
IAU9mhgbfnT9/o5ValWphdrjgzc9CbPT0BDgEGf1zQ/SDM9I4UN1PyHn2bW4uM/L
H1GxycKfFT87LwJCiqJOX7ao8B7kmyWzh+PweQrTE1VmU6+nUQilrJZ5MlwTZfPK
iqfZGpKEtwwieaSx9OmNBr6rl/+K1+H7fH70BQGOCoJtl/RVt9iLP+hCuFXT9eKe
gaIgohthQHEmY845sJ6mcR4KX0jZEjZce1qmRP+GFSLYw4kcKBf6gBCVsr//37m2
lglcMrwArrjJ3izzIfdhWC0e7+51zSPeMxEj/bKRi/C6qNFD45l0wwEecrdq4fU0
lb8q68W84b4J4QlNknykdHrTIAeHSuKoOCeZbPjUvin7le+yxCHolPQ5FnI/c0yY
8rqZwIbCodGt57E2Lgc3MIwSHAR6LEYtTzUxpVaUi5V+uiwQX2quYbrNTdO4qakT
su+/nmdNxbcWtIGEU/pzulbu27zhmoBHW3FwjnwRyL1SaVpb0mKpGdH8eMk7GEfv
o/20ltZmujush8+oXTLIrohN+ZmS1uovL7H4QiO27Vqst9wIVHU8eqx9gLZr7xNc
vmUeXjx6rCTyqa3VHqjsdgSU5f1JT9EitYBFxfCTDZsQhZ/MubmMamuqqaHChAa/
av9R3LX7AV4YObxW1Zj6FbVAuUFbUe8QTaEHIUKpGPPVIxJ10BTZndwWn/JKUp3N
gUPMC3QjBnoEUpok5RgnGr4/zbNRp0mgUCr7/ui2Y7GapTD3hzV+t1q4ZXXbetlR
8cGsRJQMtHdMRctukNJFSkXyRhKyTyikyMvZNlW2Y3BImqGgNAyt07RnB8ZfEcNT
OpEVeYZhgSv/myvu4qJHUvXV+DG2Heb6juwCjrNSwQI3ikCGhclvitNl6/WBMcSp
SRO+Celyv6+3fd1WJPgvxcfi1wb4MOM7MQBCh7qZUyLZ58xj6SUzmx7rhIn9ImWu
9beG+HNWmXG6w186RzLlHliGO4DbYcSJFS8qri1LE+V6l86SlpV7XaYx+dHk9df7
kvEcEqn7MEo4hELXIp0CXgvsZdTBFAlK8nmY8AfB6yXIfQuLhi/+9hmuzZXZ2g/B
39l/ab37L5LkcUBZWgWa4nYv0VfBLI6iz1E6uOccIIbf+7DTk+XDCDrb1Yqme96C
1RauWLiIThHHaP2n8MMjziPTrWhibFG3ISRUeftAEn+4MEc0eQjaFE+RJ8viZeRp
t/rdso/DPeRlJbQm2NhF40p4y3mrlg46AwDTY4M1N7/lqgs/yCOwSL/KR1ew+pUI
VitLYGscEsVKBAbC6iEPZBEMXgO5GoM2hBwbauzTf56JQGrV2sweyZl8PM94n9NP
ga3+G7f5fU+LqqrZyw0OkRzm7eTUFTz+A/mxJg1EpIBHArAbWuU7CKkBFmIkaFyq
pWsmNvJHGBGFxUFkoGlg1DhsBUJctur+JC4vzBbyTaey7MsPxjXx1QHyRadKVSIf
S4ZbX4yD/BUN8KZC70/VcReleFIgBjFTxK2Dpsytg7j6IszjIZz0IBLhUpLBJp7h
ZRfcTDVBKx0PDadmXC9i4+rIC2AWrhZO6TcCk1pqNbo14tqBdlZdmgA+Kh5tl+dK
QeQ6Cbe1NGtg5Bg8P2egsR0uWx4fjsp2DOOE0LJig1hjtMBcHcgghCq24wKqFkG2
sWlHO+y9JeBpoo3WJxaO3ad+IEt7QUpVsFrKMBLI9CcW2Wackff7FLUUS5UorX5W
c4XHXiBXKDGGSl0m97drFlxPore4443z1Guw9PTh+ZedR+dJuPuB7Na7M+RRCM1R
wRQrg5BMUthh61BmfWtE12k7vaMo8miAtRaOJ9kCxzAQXim16XKiKpk9w7dl7CeZ
H90wgbS2fSk9Pa8wkHv7Q5+IPkrtTo/BrLn3Qww429+rXBa6s821yjrX9lJn9TK8
RME80Lr4zs8cR+3AZh8yH0HoFh0S+6YerowlF2rk64Wrypbp+ph0uQJ9OdrckgoB
iqn7uoEVEOgP4Cg/Ldv9Vhq4E1H9PrrIGAv0XH8Zb3Z8h0v4b2ACiGJrErv5oOmx
d+AMUEyd/4yyxmFnNaRHr47/9TLL3AESADybeQfCBXd6nMdZMZ3EDfVEmTctyr6d
2tjPpAToBHyjCmsPI9wk+wLY69JBtlzOrVqI6Hr02/MccmTC1fgrYJPt2VX2RBOL
qwuqn/o917966MREQjDXzzIrPOf4rKQ4tDKGXdNjJeDlnC9+mouv1XDKGO9wd3gM
OGVGWzy+dNw1p2P1ZOwz9XZwuotU4oJL9FCM/VR9C9YiF0B4Cj6kXu8RUYMChJJ3
FtpPbtFa+Ldu4L1kXJ2PKY9Nr1qzDdAjxx3pguiUIoE4tklBV8QUIfoldTZadhNs
VR9WFL2APOGGZQrey+SYR4DDKll8hQCmNt9GTrGGIlQZfKmZlLtywisSl9T5sHM8
UL5vUt3o3ybnk98dWxi8ADQ+BELz3pTZA0f79TstDmgmuvDr0D8s09ZuAwvBNrOk
SGKfFXnEoY2J8jm0+btVQTNB/H2u3Fe+nJ2zxVPmreb4BUem2iaC6zsJSmwWyLE2
dSmal77f6o80g94AXvuZbo1bUbYfD7YU33s1Hb7t6ga2+H4mPKqMp34CHdnv5oFw
dYm366QCxyrgGbkY0CZJAOvqtArCfNXFGRD0UU1gVLmQzMQn+rM/gsCX6WEziEEV
BbEVnO2PjJ//r42Fy/Zkp7YvajmIx70oFbVly+9G6beRgcbbOChxg3Oq8Jbcq+cd
wSpW8rI27S3kxh6hbW/92Q+cGVZh7f4wZvL5wQs4+5oegcv9EtNBd251Cljt6Og8
83/4ANDfLh8VV0r2Z5FsYDyDh7REcLn8vYGcI3BmqkAhNMix5n43yqK5T7T7goyg
mP3d764tMnVgXAwfGlj+YpiOHaiDExj3ZWsocAvGV47HDXDHIY53oz85np2+uTuA
L6MxuAE2wkEkcKfBKqIdnoOpYb01Ij2v00fMPM/CBVDzvDRKvq2NUr3PRebza3i/
xCf0KrHvIUgqT1zN/JdK5yKslThr2WuO/DHZh+ka5fnj+ve4/agMypAUOHGrQBJY
pF+7AAs1veAzV03cNvcFjYK7zDOP80yDfiG2e6NfJ5qL4WIChaWoc77RvkiZNkEq
PJC4AEm/ZXxbs1V6566CCvzQYHYMch4frXRW58bWDCEcp/QmjJ3OxMfaGtE6c59R
AKIg5vfWzmDiePuaAByjyaJ2BLfE6U8Do2fMahl+9V56OZhZsVjG77rNGdEp/mCO
bsPSxvjJLY4vu9SI2Hrp58oACo0rUY5b+RETB9OuPDKOxutxiwNOQ9Etn0N7L8s1
5tXZ8XTml+F15ECOzoKYpPGJMlYgk0+cA+hVHGxHo7o9sDtONPVaqgqZJdSKaw5n
Qtv6S/qyVsChFF1Jn3KC/ZGck7q6pD7lcLLKfDSPstWJZH80nnYA6gY6MNCK9Z7k
b+hI1idHXJCn6gK4C1mBFiLFkSKXjPanYuAwWINJ6kHemetpBQ+w5TdWSovaZskP
QgLX8t6jhroynJTa8kYQq8MI703+NNsu0+D3v5hFFVq8WD2N7xrUSHjsGBzzUaJN
6/AJeiAuTB+RhQlLmQbtijuWLLfDZVOBZOtISDNrfMc3JWQc/ZKohLi1YxmfGC5f
GI/I3nAReRzPo26eqGjrB5DPzPnLoXez3Gg3nUDu9EdmCJt/1ep6WwYxbHSEoUbR
Y/Yf9Mx5RLt1/dfzqF0WuTxp2dN+dxu0sCisgbeP/ZIaAGyr0LuqUmbW0qpIgPYY
PufkASk6p+wK/6eHPvN1jxV4q+d7z2ins2bAZwUQ5xiCDR8GXGutDuZ+kMxrLIra
K6W6QqS8TwZl3lx4bS21f/tO+GllSUXdddj1+BoFfS3l2EAKk0eOHP0HWk/yZoIE
vXUifg3Qjv9bU/rijN2MC6bhodJoV4JFiVcxIQXw9BZW8aBSuRPzHRtEl29Zajhi
CERiGQi+VDTZTWOb2D0koJhK7dw1ip+04YN0lGWQ7+gwtWNUrCkJSUz4GTRtWPNK
Z5+8VcTYXTxWvoXFncPLXD3h9desr1vkAKdZIhUnWBFKbSb26lcMLyq5Z8WnlUZK
n1cWctE6t9dbgTUfvL1nzkU87uvKgLlFj4gHjvhp6czOAF0GLT3KP/4FtBMzdjFw
e527Fa7yUbgucjbPk9nsTONUkXJ7Uo0Yhh4SSfQqPe49zG055PN4eB1dzML27TZL
tpe4DVa/FSXXa10u+d11ERPgRANMbxRNYYJb1KvTqMYrCg3qCaCw96PnYhyzwKkh
8G3SN3OflnoUkapvPVKnFcnTuBBBzG15fOp+5xl76pTFwBYtj7DJCEJgWAEPdMBX
nWE3Km586NK+GMwAvsyAh8rqHfvhZ1E8etBqBIW2MdI0st1o8VoavX4IGgwhd2rX
FTKCrAIgssqnzl0Jccs4cz2Hs5kYZwbAQtWifpac/yWO+bDQY9E+XV2y/PRl91H4
d9PdeLy2Zs/JA6uINUShzczPuwiPzVvAGK8EQ79LPlMLz1pOGWBMA9J4rmYaYi3a
KOGgdvgHHDMN8/SlupVVIIYLm4GOqpPom5ahgnLYdtfLBgfFuNcSE2O+JyISkBOA
UkRRRmtgTfX5CWEx+AKVv2IuW3Ag+fXLrEWVIgyrB+Uw7DNPXk5PUIw44uoij4zF
qP0zLIfM55rAcr08IIXBjL0zRxSNq06aV87taynxlpBM0nhlZctmFGeJ6DXIvFRs
r88LxXA9x3LToo425NGTxCdBujzu1KqvsB5G3puFL1X3NSDoeY9gTOCIejFbLOm+
zzw5I5hKc9NT2NEnqrF+Yw00Ca/XzjNyNhNYiaHMg5snvHWY3593Bs3hZlu51MpT
16H83D1LzqsyezpReq6r3nqRIrqMroQVZfbnvaleCZuw+giUzQb/sJzkrhTBN9NM
8p6SKuZng0qB96XVRkjQxoa6RQnPoyCRn0CzqJfmwyLBna97wPLJ+1DELYx4/1T0
4P+MYLldyJvMxzD7L7K2IsJit2jIidgoIGgrKaTxY91sdWzmtrogTvCQj71LdMI2
SxeulgL2sCDjhMNm4Ey4Y2C1JJmT2XBHd2X2a77LDLLBuv709ZFM5ec5KVeDpmGZ
W7XIqkb8ESq14BY7aOJN51cMh4y8I6lb6ILMdnyxElU3nbYMJm1zzWZm7SsblC66
+DDzq1dZKWrNDPY+uhBJNgO3O3kDOesBZit5LFSkuCyntl6gGtuNqZoU8AJztsLl
CTIEB3HqY1BCZ1/QHnTx9T1EyXbYv+Br8xSuLWGOJxR/98JV4fHXyf40s/imnEPK
SUJYVpY96BCX2TPHs3ZXRKnCFLtIZUZkaFghe8XKGkfWzjr2MjB+DGvrFUCAiop+
SlI1FtOxdlS+9Cl7f29y2Utb2hSXJJCRKLpqf60WOJBdVh5Pja+hFwLeYOzlrxgU
qj6Ta4T45LefmBAKkmVgFhy5lAinht4oM2bTjtjrpsfwAbZeLY1PhwbkQXiZE67U
ZwHys0ROt9fM05Evm6Df3wtCUbQYaR3iWMC/ALO57gxdEL65NiKyzXOVd4bH0w/k
s1P9MfskZaI4F9E2V4uJivGW8HhuuzLpoknAZanzaZKy/YoX0UzNOgROJqX/D48q
R6pdBfaOn9VNzS2h5V2tAaEwsxnfVrZXhbUfF171xaY6Qh669Ju2rl78ejDHV0LL
U5hP3I5fF+rdiiB1FOw9cbwSpWmRCPqESok0onvaejXK2whXq1qQ2LN6MPxcu6vy
8mWlPNN9n2/rpY+1MnJtWulshNkmD8IoIJjktBs2zQBQG4qy0r5UAEXe5jskeNx/
6iftxKVhW6SfuNKbXWWdcziHffYwn2Y8I2tZ1hKVVVlU7WApkX+5e/86EflabZ5I
msdeGLxRqo31SjOzBTTdXgK67rt6sP7vMvxyyzazZ8aJ5LkgoMiyLhGy2jw6VyWG
xnpmK5qFqYrVJeJqogt2muNo/RYxlTYc+o1IUHnlMfAo4wPtqnWlSpx5Pe2oLXMB
m+jdVNLacMtQ6A0RC20PD7+MtTXuvEWOJLpcMuwu3udgqUpWeWQe0TWtIJkUSmZw
lpeq/u8rMny3Z0nLXxJThdTgv9K5OoU/ZrVXalTk199m5WOpCUZhLyFLx6WH2ByG
Kw6KdvIMqy9Pc77i6iFgc/8tPXPA4cuQG6n0XN7/CT4FhrZMNmSL9PBCnSfbI6KG
F6vjNA4kdrjoSWCly1VDZApw/Q38nv4ZrKNHaK4JJiF1zBiFcbfLeW8GoKLAl7WC
E9yLXqe6dahTpUOUSxKsYvAx1qUBF6dI8ilLwIFzSHju+htQf4cX0sykRe/ApJSr
tkWetx/q7AQso0k7vZlYJ9Z7R8z7R2clb4XUQQvGPoju5TGO+IvVDoAN4NcoWubv
eDI3Qwzztc7i8ruZ4TKxWZeljmb0tb+NuEZ3lJmkjaYf0xgVpPftMOWjkDFsBB+/
/9PgTh6MVZSG8FuponTZk/NTN6bpZ2fHv+Ly9WDMt4Vi7FrH5RDZVBQdKUMf38iV
trtkagMBI/CX3nlGuFbzla+TfssGvN2Xt1+kCz0z77juBi8ejT+aN0VhdpCKqD4y
i2k+U5JdllAt4r5sL60AYbEP+e06iPTiWSjFQoHt+RZU3q9ZEJBIO6NQUxezt02a
3ETqRNAFkL2EnJMhvFjFwePCP8cfmm59+i6RgQVBVaxRH/0ru5mzM+nfMVLCGai+
7zCiNkHXuS0zyRzSuaKHCAmTdB3G76nxinJQXiWP8HZTWXbrI7oMmrKEDaYbbgdy
ltWZaphTod2ipMBEmxjNyyq1QurEMtKw0UC8lg8Fgp9PzJqNs4BxBvslvj0c1fp7
y1tMo8d5/6MuSlrE8HlG/+xRowEkh2QzjUm+WU6oqR/0qNcrP9QCjm4MAkvVgINk
4SDt/vO5JnQQRhML5FiQl2cSsfrklhc0Mf2pjw/roLl7PVkB+mlxX2o30xvT/xOv
xZshk3xJsvZqFUJ2ugc0yj3YomT3iZCW+hKi/OvhbaCw4jpkqOrZSVMAX3axIJUe
1yRp4V9546Sv27FUeO02Nx1S2HWk7woZUGNRkK8gPn59mbaWoqGxWtgGczL8Sv1W
I3nL/U79biRA625k4rmGehgNy/Pkb6FwRLGUZidr9MLy9fM2wOY800Fd/MLsGMXU
sgBfpeAFqQC8jP8e7upWrbdg1K8wbbMx5aZxVUINNMW/K5dp+9RPFXkDbdIJN5h7
KaWpLeiB17PqBDKoWE0fGV+aQCRU69wiW8JBAydzS1LhMevvpaUyCDRuKRCIL4pG
61/jURWQD9wGTWVUnscgUR9xSCy8Oh8CBigLJm+/M8q2yKC+1UDiqpS+Wz+ykTBT
/vIeSrKmYE9T1p3tDz+9jQbYP4cY09is2gxDSJEGwASFYCnk5H7I7RjMIdvLcBVs
D3oZdWz2nxJqW1adPsgoxt7Qb8OFzuH1+IcL/j7Vwa+lzMtiXXUi0ehSQxIsQepc
gQcV+v/jJV77eqIzvz3v+jZevrRXv1bm6GsXXPHrDiTaM9RDizwobkPwzkocpsqo
UFbUjpgzxemIFP35YMCxeBygW05KNNhfEcxS4RA2rWZ/UopVJ8yu43k86MSgp3dF
I2XL3BRwE/OxOuRYjWMbta/gfFLWcFrUbnJ0+DedFhGAHT5K7iCFLtBG/6+RDddH
ZAEFF1c17WiBG36KVJBNWXeF6L2EvV9qMEvXFk7IUhmWkZ7QLICCAYIFGEwsAjmj
bvuORB2vSGfWasy//SzEXcmb0UvZKp7FKQDKfDcdakLcyFXrpW04dQq9KmW1nT3M
d5+trbhvcJ1BdfFhbnUr5kNK/IrIV1fFsnoD3xVnwoaYDsqprgYEz1xBQpvwKWvm
O65Hj0+YSDCTn9IoD97HIz09DnN7W++BQZJjVuZXENHLGJjcyBzcu8VO80dlT8zp
Q9GE6OU01K13E9Wz6ZHlymGw2eKhEgAWq+9kvAyXke7nY7lsG5Jh/QXKfaqn0F5z
4AucXVhdvKoA6Vzh8XZJjT4sJKbZPbzmpQExMeAwE4szHpQpB2JcJAcr1gHgclfg
2r+mC0pInYqfUX7g9EA4njk2jU+G6sfwp/c6RRtbk/kpjx2NZRa1cauzspAwJqnI
bMaf8meRVxHu4Kl9f5IzV1jOBcR3fVBflKISKR/5RSg5YBWu4lZyQojDAGyNxNSe
WXsgmvJ/h7+MzV/G5N1o0dGahykdIQQ2rD8KocYT45iqBp6k4/OyXI8pgwUVloa4
FlpDS7BW6Oy7ljwYHwPGubXOoapzllmpV5ghRmk9IbciQoSBVm4b8f/X3rKDx6wc
yS8owCwIjY4OpeLEHW4SrrEeZcDdU1vf2gl9rtKSslEP7Li5Q6/3XtuTIkAF9Rbm
FU9yCNUn7XntG5ERMF2QqmReuKw6GEKVVfeZM4cHLooVUGHKSovaFlRofkv7Ftix
qAdSUEDTQI27Nt8qqvc8qUj5KThV7KYynmowUH3W8IcpQg0G2arSuOZ/OtJyQnRh
3xCoOLXI+0YD9/+9omO05zm9Qze/5J0GBunXh6UkCudnNINS7ksc1gMLokzwGAD+
x3GzL4fNP+4AArTiBZ4Zgdd9uciBID4nhcYYp5vm9lPgHL0BnYoJuBBOpWnla9GE
7JC4TCm4RuHdF9tX54yQxFGfVm1lOHbzdcjdcAD39iMVpEAer1bLRtm7wqZosnM/
eza2Kk0fEeCN5X6v7M3SdPpxOleI1QJw61/mrNNPgMZsYC1CnngStTiAHQ9gWyqM
XQgrVShFVbhFWTQzHwUwRSjXQcSco4e1HrMA7hKY0mXmBIhDfFvUDdaRIXqieAOP
JfLdJZK33jlJnrc+50lg8+mcSfky+7a4J5BVhyc/wrWopZ26BvKXAptTHhLhN2PR
PI4GLHhpAQLwFb8e0X3JYN03emn/OCfppsqPi3plIy3hjkAWkI/Su+iM94o8X/KS
/kiDQzsisHK6DGqnYrABJNXP53YN8tHAX7rs3fMQbYeL8RszdB/S5/1SiDRm6dg5
bvrbb6jEs0/bxgvbVBHPHYJ2+FMNzREWw2iROXELCEGA8v5qxS0feTtQoouaeBiF
eytJ5DgbLNtXpnquhVVsdjZwoQ21mUA2ZNYaEACJyJj/JVCMoXdSUt9tAiDsaeWr
R9QSwRQJ6trLZ1laxYYMWkJRhbW9y6k6Nes2DB2CPGU9VrLpb3JlOWBkJVkCl6SU
CmDeWL8FxaRsO+kCg3gtrk35Y5wvaDt61Jows6+rKO7AbR1RaAX3v1Q7TepLP60S
Wnler5tvcTIuhGZDQl7KOhrZYamHhjo+gRwl0FvvYs6UHzcRIOTyD+GeP1UI10fd
2V8jYQHcAqXdWN2Nx6jRyHZyV4IzhVz62MSPlHoNrnVJ9j5OMWgZ2Lw4q5IkvHIl
vMCp3pdXv3BD0jZFV61CjkGgR7iksDHu0H5L8to9lwf0G807bD0/tIg/W784HZAZ
0u2oohLgKo86WZGMifstc6+EOZkLRoMmKVEi2qUmf93RH08HjP4jAsIm3/bNoHxl
saA5rw9TQZAd4yA59aqaZfOsgo3vRQt8aUlEvKCEPXCXnxsgp+JREU2niN2gpxXV
EQS6PiW2i4TsjlTYikEwqYBZWLzbgniY14XwfZq19XF7SEeYenQYwFIIfjEQZIOc
/sMPE6WGfTW2h2u0ROUE74PzlHr5DtjoztAg4zKNkp4RQdlKxwXNXH/2P+XUDNYc
pREw9mkdaYmjEmr2KhME79foFur8qorcWXop943i7mjr1Gfp/mGkpxa1XxeN/7U4
VIGByoHDidjeZrFtsoorQvHmFEo1PMBQiAdOo/1YDVsFLT6EmMtxe3+ML2NYa/EO
hwEbh3UjOTxjaxW/LqsQgw9twNz/kVPC1SjacpkBx3vMJ/N+Es+/6/I+CPTexczC
0QAh5v7Xisa9fIpYvtz32FqUfTOM+GOwL/l4BKoorTtUTJmyVvIxycdOb5mm/EfE
Ma8PsoFSx549joi0eFx3d+IwnEBcDwCSPdbDhJ2XQ0rn/6pwzDe9sGnhidquWdbc
QtlAjjHB3Ntpz6PT5rQrQ2Zs59WvlWecgo9R3EJENvWHd0/gOArM0eMTK8Eo8639
IWDBI9hH2KgtWRmNGHnWgg54gHU7jTzlizViiZh+uws/r1KJboB2SRjTkYcfeLbn
ehZzwlWRgN1hcC0mWt3jE9fx9L/2PRKbT+g4IQdP6Ui9DU7wgZMMlKI6nzPLvnPb
LZi/hbsHM426VyNfJFk+kl5yC5Yo/+og46NavzambFLY9k5q5B9UFTtQUwOR1MZ/
F3K43JJzhbcn+GvZ2+9W4+YsF0iMPTu0hNjdSbCvm234+90SKDLg1Ne0w5DIQulk
4L7FBjk04wxLjnejakGBHMjAybbRgzGmnHxMRy12C8JHuS8f3+txhtlZISzAada0
/YmhZfGEgYTcDqo3Hd6jBcXoq3He/13E6L2jVgKiK4/JtKZLqzSLlljS0fFGJGzP
EHprjg4oOVoJT7Kvt3gBzHdboevLhq6idx2EdADmCHBtn6qsmT2+GIMRJGXgA8p7
OoMxh4EDfw3UqjUODe/7b8up1/QLcOP2PDuPgWjnovRyaVKSEr6PCZWtU9NXn+f3
DuV5hHgfDztk1VErVlTYX2TGPrbglSxZMbQKZHBIcOX7fnMiCCGSEU9VFpy9owGd
hljSEFy4GfyRPNf0htWV1evZlGZo2YwNuPzjaoKt7ttFkjRTGrTUN08N26oEHqSr
wRr9wW6/FGCFKE6xK+gq5Fwp3KCp3Po7AmeRc1FHnkxleQQZrRZALsBi9Je24yiQ
VpmKzD7ROLg0dj3od9mQEchOUPCoxgnp9PQRUUnWBTR7tMeWLIJcpuHaok7XYYz9
lxb28VAl4Rg8JECo5oVIzaBRzmtw0CwPDg5KFmRZlK+Uv105pr5hUl6xZdaWL7HU
C9xSPI/viDgk5v2kMVz8D5LQNocd7r/wqXOXlPWPePKbPC6yPgmB7men9XAr1JKF
8ws68kJdsczHpBrlLjBS5s8T7SeF5Yzs7EDwIvHltm0THmtosVCGzNwLZttdSFNs
coUzkpTbRheRLtViQv9ZpVLJV06oO4hIS7zJdM//UMe5fAZcCjdNwIe/I3Puzwxz
MR99JRr/jFHFj25vREKBKjMH7ClfT7fg2b+Sy9yscTkrzCj1wO4ZLbb19WtdtFiL
L8Vi58qm6ZROdqdyL964Gvs4jhhHP65YhwOtDfvxxPquPuS1ourR30WiviT+fx3p
UzzwZYB1qyrGLxZ5SI3GjG7kmUcQindhoBDePd+6tGQCzqGm2Nktelv3IAjzJ6BF
2ljav90WIiQkWlBb97ISPd70PS3m6766KlS3QAxflRInCx/2ucXBbQcqZaoLTX9M
hvT4saes0HOOKiX5smlNReA0N9j+46PSZ1CAHD4ehaLTyRQ2syyVXGvg/hewtfsT
SEk1AMF2MNNkM6zVAXZ+1K10goWLtKpRm/9ref8/IaU7vZXYzPWxP/EuLId5fPS4
Q8cgOo143O5Z+aCSFQa6AjWJgahBPwwrgkSX4QAuaqb1nKyNZZD23BIAACIZG/Ce
IIxnN8G7K1QI2KG/dXSdwpNUCq/7QFaWkJPfG9qjAjf/06hsO1UJNhGqpAGlPrqs
++UbSYFCA6gfE6KhOcDBltbFNIYk8Oho4o0oblkuUkvPIYhmTDBwmLzGUDxypsLh
XYMphEcu+ALixvPHu+8oL+YC0eUajJoW/OhkyN1w5sbfYl8ztGlrkYPwBtMv+tQ6
OeqAQ8GHpVAJrJ5AKCHQ+jgUlGJO1pidWHjGlkqvaq5abWf0o6aya61B8ClIZfgl
FCNFgwrEJrFvUCFIDl5u3lLE/EkpGvT/OFroUZbNvH7CvlSAC2CA7+Z5fRagpdzl
YxalRyx8xk7UJFhOiKdw4ppS965pzzF+FzFzGUJ9bt9uFxNFQpaw5QtwREn7BKaH
LNZAYhc+prHg2G7mhlrxjsJGapAhi6c1/ZPCNYVycMSh2mGnRkBWQRgtNCSmvNn3
9gw7sP3nS76efgLsgdMrF2pDIcTVFm2Wdl8JgFxk/cJikHFY7xNG0g2ppIoV4aLf
rD/qTFZPNtjlErRd0DcV3M7hmeQlfE1v9KUmAp1MJwr6N3eRaVbmMUFyR9uS0MtE
lYOAeRFTdY+3F0qtT4BvQ3JZnVFOjgF6iv70nJXzAY2Ma196za0MXPf1O3Z7DwNk
Y0PGkfqH6dug9nhtJa8pZ+c+H6ZwFjVn58w6dmLT9cTNbas3sVLO26RKi8cInZVg
+1B9cFlYYKSa6+xQFHb29ERglxh1jpU1fpKAkw1H+NMXVn/bSll6G9ux3NKVj1fc
WbANrXa9SZS/ny8u/ga2QWzrgXDP+wT/8/WiXdDTE1V3AGvSv71uDP3g+kVAnfk4
PmtC8KYI8f10x1wkBm/UjiuPdR1aGPKtSfU7FcdKkIzGBkgpGtXLBz6pBNy6bzu2
8IB0W0VmwUIHM7cOw12iv9V4X43Cd1Lx93qEpHdc348h+eY0R9HmFRpREBJp8+TI
9EW9KP0cdCM7kYme4TkOY3/goeNT9gpGFaWW4QXJlgmigwsjxZ+TqutWclLU+HNu
QYoiKRSJSQOzK2IPA157gLGY3g3DlCsxDY6LYsQBFAZVW9gDogND+uiZJTNgHGE1
eoLE48bEFV9+xuDi4Q3bVcHO3olHicCoQme0m5u4NtwqZA16p/4oSj6bF3veclGo
c9UBncVT/AUByIWuswdUwLn5F6PwCDv2RR0V4MT3JYXiQZQSz0/Nxdq9ge8/o657
h0ouDsHSxj2WHHSh0wZcDECyhBWGEV9UPmdmiYPW0B95OIKUd9GziFnT5CrZNmKW
Cz8VxtCRNq/4E+K0MbJG+93zEjvskXZQSbKTxBNAPDH18x4+KvT0GjMSFx+1Qhxq
t1Y9sbRD56nJQSZg+ebkAzM5F7zkvw97t7gh10nQj5Yf0J/1Mz11ImbdAoq8/maO
8F0qWVuhgjbZ1x8IN044hWAstkcqrf+QvY3JQmqubTVu6UOjtyTXw6XaUN7f7FC2
fZ9ye71sgNp0nQBrGm6rPOZDmU0VBJ2hwaZm6qI/d7RIcNii7CbeDhRcrhFIfyNO
rVFu4JKPMXu951FYZfmnSWMvuGjuEANIojt05ISsI4ppVIGYxKvqoAsBRtL83KOb
AI6hF57VCVvPiuY1jBQ/tRMmgfB84Wq1zue2G3xaeo2CypFYML3y6+cdJJXsN0E0
4kKTDuh5dvDWZ7b4inQBVpnZkYY7bNvkbyQeYKMjnK9IHPvOZ+drUcQEzYqw97fO
6o7tuJEdVUcuDxSaD4n+U/f8jSJ2pW+j3K5CgdOVawmESHVBVKJQAQ0kv518q73V
+5/JrMMIaQy6+BDB+Qvz9wabdWdLmO1ekUad8GhxDT8cnvLNBpzWSF9FZN7FIs3B
iMrspRjVeI2sdp7e5IrgsaRMh5NXKl/OfySC9uDaxE7SK7NFLoZjvUrlGmXcNzb5
v4rRnNcm5UAN5jquTWV8oGwrCPXTEgVr3KJ60zQwVvcQbnZN9pZbh7Z4KxG5NK0S
8XnsWCRonV20EQYmtdfQn5noA8ycqfLSjuqi02Pl9+3/sX6sRuFFHOH5/BS7q9zP
jMUAk/IX7zWv5AQ+rCnyQP1jz9WTOWK1poM/hgLg7+EYih7qu2I+R9BSbC2Lwr7J
Ns7kCGKkG78yroRifzLp1o1xt29E00lUQNwAPoeKlft0/KOpPhKTr5k9miYdZQhD
G+rUtPx02ZoolPQR1SzV36R1GMPLCjBiF6Pjcybua1Y8cBd8sawHbCkBvEjX2/8H
Yagy9/7m9r1/+0KAQwuiuFinmgF2INOoUB3XplLWN9KnGx3eqMVczyJW3HHCVctr
UJlij/lcWVJtvd5EYcm+LLZ7/1vjmNjsqAdV7e3bPRwKevQiu+WLA6YBqdl8BeGR
f283rv/GOxX5EV3C3t7SCcqDuca3xaNgq9c1gYKxAxN7eu+4I3z25tWX0UniT+sL
/FEPHu3Oq4/7GeLz2hmtLigoMEoiD+7vyOUHTGZbq0ZV5WxHBu+5DfhZnk7/uXHu
Od+c82KPCfUhBHJ5oS3wNcEbXRxWnM5EBLexYA2Yht2NvCsrs+RFfVFIuR9YRH+N
JWjtJZdrGePGl2DfoWCK8MylzSyIhhsWLWMvrDEK7flXGdRP5utHx7J5cpBKdkBv
Vaj3yZ+ts+PJYAe34x1GEU3q4pdEAx2pcEq8rL0Y0kQeBtcpR11W6JPhPt2lYHq6
x5ZZziTHAxOLFHqxMMjZ0qyufbWPGHFfx3piJQ6/C50YDjIYtNK65flSs1Ck8NYr
FraKXszSmP8pPPugtBzUffZgrBFzXcYvFH17RRpY5hvcRR1ouWhaM3g3GyMytnpC
xkvz/TWmtpLh1lO9rjzTl2i5PUHG910br+A5UQnmj7x9gHucYILJ3EU9Uhdp3NZX
cth1zW1DIiyu/dV72lO4dsdTm1JeY7rATWKB9M0qwWf65j/qfR9t0yjMnwJHA4OV
SfHbPnxMkl0sZFYWP3at7KhyzrhmPdqpDwHJwjeXiiG5FRCyoU2cavhECyMN8aDu
iv3oIFU0zofkMwja4GQUtwmBJFv1qW+xjUgTbt4qbeUdpURpjNmOPbxJDVh6BHA8
mzllZyjhRczAgBfVyKfWURA7LYPeNjJmrAjnww3yx1C/85o/iRrm6JWENhcm5Fii
Nc1ToPx6ZUwinxM6PixjVmmndseOoAvyJlzdmXShg4bTEIa/Kf2WI+JPZClAsqdn
zJfpsOozGxW3qfiHoGIEQrMG9WDzqKq0g5i295pVqO7C+t/LnrH9luAX1tNsKeoR
ZxNhktKACI9rObNwIO5bc4f5M/diyAbVnu/+dBC0p7TZx1KFyvX3BGZm09g5s60e
qszGEAzNRjiY1NAmCwH5grlXslL+b9DxLmXMS2UaUuKICYuHzpcFVKq56jc+vn8o
dn0iZNXGshF+uslvu+yAxaNqqPM3H377m/QUrbak6WU8LFa9USYthIZ/PWXXs9Sx
fzreRDHMT6fzKh17beRKXaAHSV9BHaI3wZLDrVtlQG6JRbSV14UnX7SJ7ludIuIu
n3zdUYDMJI6vYpOePvRivZqO+Em9EiHHkyOVQo+uJOWVkgrPqhsEDT/yJMDXsweM
Zk6NyyjCh0P1ITsj8Lk5Y6m553cGLF2DUu3PIIgR/855D6oRyGGLUsDTPn/KO3sP
qmn5qBrCFXn4svViWTex1lJ3VwvOM8lyQ3MjRzZZzhBX9RwwBEcBXb8AUxfrkoU2
/YJuIi5zy6QQj0onLbsZje+r8+QK/wcL4wBJGx1UgUOHC20f8UMJAQyw5djIF7yB
ggLwh1T6fDVtB7LwzrXTbz5Ohj04ISdUSM1OHkiboX3ViVAnpzUL/DY/sA2U/LYs
Saw50yDNrs9HSzPTULqkMO52ePxMBIBgdBW4XlT6h+zDTB/6c1x3WktaBmkAfepF
aLEiYhpulIWQEeGTLrgl3rcfwYE4WeO9XXUPTLN50bkiRCUpUxMWejrDwgmb+URW
HrnjfjlG+jD0zjhAjKQLglKa/drlx+c8oY5MmF9zYXBl5Qp9Q+l9P1pPXna9Tr8m
lmB8iY2352M9+CrrFCAMIifHwR0Y+evMc8ifos0xkRE1Qk6EajZwvsqHVhg8R8X2
a8TaWmedRe0ybC8WO3mJO0tMD1Pgo8tdHk6LdZftbF5NZNjcPgq/8o/KvY90infa
SnNPbOsfwrGPVBsgEOGWzNhCFuhAV+/WZbCN3vx4uj2ISUS4FrL/RyWf5z1ui3ce
PwXp3zo8ojhMKFtEHreP1LqyvYYzPXKeweWXPu829OD70mhQidBf5aJIQNFMkwyo
Fafu2ZJJb51x//6xfjza546Ro/6AxCOjfdwhxMVJoR8tl76vwc/os8XlkL9QiVrU
34c4MkxWkEmAsn4sVInRiNbLNc/0PSEsplp2fXqGLHCs5tqaSS5M1OfLMNslgIK4
+O3GMhvMXXF2Av7W9Pq27Yp7bqIG6VBsyjEeZRe2XRiJ0U8PCVo2dpOrIx6DEB9X
R7DarT0n0gdew61RTHZcDhGxDcnww+B5EWXTY+VZWzyrYDccwehbRMp3TQQGrSFX
UNYNdH+EkOtD57/JLlEaVo5eCR9/qsDE70PyRGGxy04dxmH0MDL/8PyJ8qy48kkq
ey2Oz00RiTYa/DBKNBVTGhSd1BZjBFlHGxKim+ZigkgilNT5Vn4dvt7tpudrvcMx
L9/+VnVsVl2r+GQl5LLGWh6CmhAd9myvW5MzQPxoQ+t8WklJwhfUVRAFd7UI5jPV
QN9tgmBGRV4Tksbe5UG40eJAbRNPjJ/zYPh0fNIPtZwMrPf3xKWxuGxeCKP9E/KM
Ue5Mow9KMqNOhinpZRgrJVCgziM8ejgnFG8L94nqAH3gOvtQobxf0YxbnzKpbuSK
n+YURIiEVMplg+WmGoNoVJaxgVO/sLIjiSe/0Fjfl+GnIk0rsfOKgIFtJxK/YuEF
+MAYxIxi2GRoFiQa2pkbz5eGVylKvjnQFhk0mH0JKGrWsMMr6F/5ZrAAGpags/DS
7urubOzQfEGyTt7zogUKseOY4Q0l9i9h0gp+z5M92Aki1YJG1/tR/pQxygLxkVIQ
zfrndh8xCMCOudtD2Ci1rmXTa+WNzownPJ8Sbwekq7YzohEfDrsnmoUuJg86J1NX
QnwwvFX7lezU84P6Mzjt5138S3YPZDiyYAeI9Z4xc4C89JikLAzh0ksNi9ztRI0X
emvHUiupc3Qs8U5V1NYXlu5bDKU67u58ow6h9lkvnl0uNJzvhA0PqucwIgb0/6eu
YCuwVo5QZllwOyEFtt3Xo7wBk9jB9/e0YZTF7lBCHB7l0ojx8BdUKh7VGdBaTng9
VYS5QQJDnxcKY0ADTZniZzKFwxGkjOhZR1qm+Iga4wr9KBx7BwEbxVQU4y55RcH6
u0wE32iBjlNhPFPMNln2gWDgZ8sO/5eMrOCuC5a46J7jvGVhk152gzzUCnhWXyvT
p0qAfGWlRPpyRUgXJoU/ayAOcAdpq0Th7XP8A06GuQNYqmyzkrIVQ48vPNZ26wil
GQopfCbdWoOz3FHzgaYR2bJqWo6QVptA5+/ggA2X8n+2uo7IJL81E411lA9WCBUI
d9NzTVVz009ZlPeQzME1yWajZYq0sD9OWvaijLdjnRcg7HITl/D36WFXeDOROUFu
X5yPg8wV8ZR8IgzbuO+1DHEXo6pfUrWIipLIgn4g8zlMO2wn1lDId5IIZMRA/34+
WzZRjRSbKnd0khcZENlrubzrDV83xrqEihc6NFxt9npTAgLqqrUCUNDpNl5chDXG
lMgvDTZzs5xE2qWjDLwa0QT4xcyAioPZKtt1Mkiky3csGNd9DlJYH0HKXROcM3yg
ym4HoAq/hHaEtj3ZBkLl+tkOEN0otfynOJ5UEpbNLPeJWAXW5WyhTAm50zbHg495
GgHjulHOvT73OFOCHFRWJq/ntyoIwDTkPbgU0iRvifJXnr8m3bFaNwFaS8F0NXLU
MQxeBTgIfSOHoeVa5zNx7f+TwCRFQjSKIF7+KGVxKecs2CjcA/AhoyOznLJxy3wR
DfLNTy8Azd2PiWPHFfjVNQUdhegkM/mt610S4hbTmvHnjNXMf7yiT2GNv8P/hBVv
dYgmA++EC2rbB+7KQVTAMzFLeg9Ix37ktwQ12Dz5APIo89kXhIr/Z8qNH37pvAIZ
e8DOXdzkbCsAFTHTs9y9pMCSHY+cW9S/m6J/dpaxXXDWm8czL8RxMx6HQqWn2hHc
MHxD+9mR+9a3OCx8WyKFKiyjhv0bmetKEU9tkuGi9dGz5g4uvaky0EbOXrhDd4y7
JcpqWhfClrgyT43CBkP+Elmp7gnK1k21UPIDvT57jWATslWk/n1yXLSG7qMw+hba
CPvzNKGY3MDb/cCzjP+A10fulvDL2rh987qefM2VXG3vYQspSyQivQ9RjmxD5Tze
qaOOlHfZAZigP2AhmWMvvFKGRmR1k+jZdXTKemnAvFiFbyoGJnBG99CJLSWrMaD/
GMio6gNUmonb66Ucv7G6YEOJAqaF8KBTMHFWB8j9l4deTRWIeRw+/8vQcSFsdULN
DTw2oZYBmecDHJx9GlulJ8QrtOFGyTxhhqHY0k5yUa7JSD/gorByR+lEGJ5pqbV7
PkJlItmGknITR+M8M8X308RfpQfWHe3Vf6W7Htm6NiIVrmP8AlVZW37hj8atQWhO
v8INtbMprmFmWIj3/CEJEel7w4yNZ8alinAEN6nDAE56migRQ8ontuslF4kUEmhp
6UV12eHLhovWVI0yc1IZyeaz3Zz9qQl970lipnr6ESPNLpAY0cvlH4/5efJ5anUe
0Igrlw1JAa6sBYc6hRocMiJUwbrkH6uwnVgIqJFXJbaXNdPagYKorgXcWgQeBPUN
E6+nykywez7tArxU7xQcV8HPaAWbDstAVlQC1QzORt/KGW2rIQTF2M5WqH3Dsfic
T0tEhIGz80GrTtpyHEBS82JmLsHA8ubb4Ddvm7wQ5PGdAFZSiwfATIioSqlh/wwa
CMRgQ/oDSI2aJfSgrG8NDkYYjWMkVM4LvcgSE0vNccBAOtneATnuw9+eSHPQkrcY
oLZoZNoq60OrcjkuBHUK2cRhGPeS8eFMOUegHFXvuCc/NuP0eRJFEb/81DnwwMzm
P/o7h0nai1GqZdE/3EYKv0Ok5g3EQiiNqoT8tQWyRFEGo9cGs0CmjH4LminzUGtl
GWYckxP9BI5hCZabbFmR4J4s1xOaGHfPpgvs8Jd4mE8gOoypFj5F3rvijXyk+sNS
f/MsKyMO5faErzh79dIMPdPYkOpR3vOgjLJ/DAH8/6N5uZagRfQVpFU10tw25hh/
SpaQjKFPq6VfKrFW4TueXFYOAj10lD/TSkdWlF5hCkVy70F8X5e3mH/JNMGM4Hnr
dLo5MrUddLTh745sjFKoN8LxOW5YMKU/kohqZYQR/+ApYOec9NyNGfl62L3+lff/
pWRH2mGhBribjScbEg927PC5omIaFy+5rebmdDTwSaMU0wNgtrDLLbEXt65Dzxxl
+nFL8DQX21kok9CQeLfk+uwL6v6KJv64gEDahtQGVMAFpX5xL0EIula94nyjsxFb
0IRK3+GjDIvVwdgYsac5GRbwgViC184Q1qjmzqEBzlEJWCVhjGUrzjsxzjyt4rgG
Oe18gta9C7h5OJ68Edq8oAksKmjJwv3fbD1ilZTCi172jtuUr68o8KQrA1l9xacF
gPtRv61XHu6cjYsWiRMBKebSIHfy2EL5W/5kzElM0K7JpBHXamj2pCyGlk1u/M0Q
vK8joLsoox7/bH6/p+xvqUtWvAt2QK0TaNkRloUAq8MV3eDfPm8Nb2B9ESNZgO2I
nh/IByVaXFWZS8xnkS/bC5/G4FjIZGxzljvs6fAzhUfz7mXdeo4VU2Scd7vG0KJy
013ZANASOt8ATtTxa31B9vPp/09RSFUUbTjnnhdecBnX5m0CPUj7cVJ09ZfxRvNz
qhWnXpnZmSUNQUElX2BUw/0jB49POuKQKu1o/bCwAwsK6s0R0gc9lw0Xqq1tEfCF
fxqvQigPMZs7gumq64+SDcEp8WmyVUYkcY20SilwvT/Dfq1yfekbe2ZJG9wty1n5
wemNPXjYYUPfBDsxPR+cs1nCblacwYt/YD88GV9RKGhyQMlOZFLvhdfdU3b78hOe
rPJfs9Mo4H8iarfkhL+yNjTWtcAIYSNx8sAsXhOPi+24Cp3ojsBv/dnO9kHQTkhs
xD3PGElvfeDfV5Fq1FMQyQDCNj1QmT1YaZhcQaqwl9Oo3qCXUVQ597w0de5JiIY8
iPjJrM7YLA+j9Iiq2nGiiwlBLkRIHQNW7d2VPsqi3Wti+RPs+yp7/ztaKa6/RjIM
RgOsnypTs50vOxqFIT5GIYGf9RXs1jUzbohCsO6GjCBieQy33fvOm8s1HzjarIRd
ixC7A0agdt6YuB1EsudlHSUnLamciBzw59JNgSJBWLM5k4lSOALaxgkdFBGn+/vv
T/uWcRRODKv7vfKizQQDpAY7WRDd/NCjM/WOhQGoZ5rZDL4q23n3YIpd5GZJEVdP
l5oTuYcNZxiNMN2eqhouMF4poyd2VLxT0puaEO3+HaEjDO193/4OSY/BRdQIaTwl
MTaMV4WMuY3iMdiSpFeronPzz9+AHdFLnBx050X+Ed8NexkRlOySoHWlm1qp/NDo
iJyvneyVMAufLdBuwwg/zmOaK4ar+ePtGAv1We259jqurXElW+g4bjPfgEKlFX0k
6YGaOsTN6L2gj9UfCg1Y0ObgNLJwWIfe1q9FhssErRS+FJLVjn4Z1T1HDv7nEr5R
66BImvJZzhFa0448EEaHFANdnPu4zFoRWOIPTRSy037us2zXMjj9Bn9xZ/d46fsr
zUJys33FjAZHc8SpXlmMu0zwdUV/IkjZ1dLQ459WA7WDOL4VyN3FjsWznCCS920Z
QgYeWJDc9z1jrjrkUDT0tzceMAvg5le/0yP9P7zVfjmsGIDBnuMrpjOtblwKpTtc
aNMtVypCZlHrOOXcWB4OJ+9SzubVTNSAlbpyGzGlM31kttTtbZSlgUe2i9tcWyQS
K5tNPRgF6z9pM36h1TCmFDK5eC2Ra3UGMZheE24YQbb+upfRW9rMWmaR+14ezhig
B0/k1aWcV4yUn2W9cqbwndHtFHIRqsp1Nik57a2WIYqrtZKAtcLjkjEaxJIVjPqf
jmIQSU/aMglgrisL8ibn7xU8KERs+ogve/EeXm5u+eszLJIJrxA0KxKLQiD3Kmc8
ujFoVgrq0UCRtXVihuEkNF7ahMxSC3O/RzwTMeaNwWkAxHq/txGoVppYPacZ3Aas
fYcfrRdavoQBdFmV4+1YxU+UPr1ejEWW4J9w1ahR9EbTkRA6XDBr3PzCmCaOeQj5
MukqCfI0ChN00RtjjvFB4dMXEJtCP60g1b0XUPopzG2OUgl2i28dznt09A1+TJSD
x+yV8u3rKu+OetNnIJgSq1m7u0ceZiO1g8yS9079j0QuoBsVE5JsCaG1KHB9UTBk
FLS98ifaC35N8tlaLETxFQRt+WzOBk84zA+ixSbCVSUMalVn1QaSqPrzTmX3JLbj
+KiqHcr2tXwmcQw4l1SdW9YaN8wf7iM1VeNr0YvNhzeyYOqlUPzgDgl9pynaHTuK
PhsDlkh1/bOj1GWJ2uita7dJjRBPcnYOnsjWUSZ+oHhhRTyN3GxG0JMha/Qpe8UI
bcQ9Bn0bkjwzk9TJO7UjHqc5QWLYBMXRZ8K3V8FXc+H9FOJ1WaDJkICu2UYWOoPR
lnEzJZY5PLhpP+SXbYHhpBLDNMxJHdHjZVJtHSPEKfQHOOEOAsFLLBXu6ZggS3yp
sfMkKd+oqBn1TLn7ude8KOGO/1krR9koDU7iNGfsIvZ8p3KpR7YWVSIafisA02SS
ZlporHw9wabBdRsemrQ6cAyGgM1iBF5MRl2O06vN43/yC1mvQ7MCJMgt8YOuHcm8
0FtCvG2gYjGsmGYfKTgZfFiwRQ2nRX3L0ayJpjGM/n13LMtiDg2IsoZi0sI5UYae
JJ/AwxncBWatbsStOzZY1IGnE19UbehHOlNii539LhMq3drLQlAeI141e/mLwpnD
8LTS4ZgXfXX08zT4GDK8VW+9sYxfktbRAiUHWxZxhlAOsDD6iAvtA8KtP7iZCXbj
5Hv8r64qSFZTwzz50ur+CbdcZU4BnZj08BtW4eXTDpVaTTzO7w0WS33UcCiibW2g
N/E/UhEcgZNuL8vM6vX4lM9p0VS7MfBlnGBb3z69lGWCJ7XmfFNJlCgyOlmBX13d
ewfwqXkDlGO81CMYjp5bkz1TwjmiVSI11NIKULIk+UxoKtT0bCTlruP+nE9NH6RD
2sny73bkAXYrN3FGF8Nr6ZdpxBCLo9NhNYv6OgO8lUiPHVIWXZjOQ4DYZKKDn7u+
dTkG6fAU72COTKTbvVgF99T/SXZho2wVXNFR+PsOh04TCJ+wriL96ybOTXqLwEhC
IQqin+g2bJCsgd654dBUI6dw/Vm/fAH6q6OIDp8Fjoe/InglUg1WgMSjaMhS8g5x
vCjiZ7VSVDVJipiS693/OUkA4XSgPpj6b7UdAYhV3+Wk0SPcx9Hj6s8Ur5wPh9u8
vtrF+MLNuDBsREJhz5SJoi3dPtK150F83cRKauEaxqTVWlkeV8iAiH+kpIkvwJg0
xcSHvb3Yqeez781jSUUOnESOrG/DiJgDLB/gdmQleSAFDdmd1GAa2ZWU32vcJDNw
mLEyR0ZLiIAy8kO30zH2DnqLcRC9KVtTYgH0XtDaNieLdtQe2598xjyh7pbQNXE6
g3gKds7SxXc28eZcJBibHUe7dykLStnWRkQj8C86JiTC7lP6SGD9acKtlQ2cjKID
V+PQReiVBZyGaTLJP8szVZsRWhIcCkTYtxLPPiPNhAr0f/nFVIOpiJHGzUzcK5tC
L2CCrSIh2yEKpjlrVUOIcdCMhRmFYxZ9YCTeOWsN9N0H6QftRUt0iT84WtUAtXf1
oIzVASh0VuQ1CzK8TXdIZobJA05f69+3EiBauqiJamQnLU1JbbWcqwa4qz/9qEIi
FCKYGkaal7KONumbZeIqC+Pklnc4bC1mpGWzDG0uu8dJdDJzFKgdzR86pANZMwiD
0xU7rPaS57/rPifmmsDvJGFiHOi/3s5x2vRhnxugUg3AY/gM9JXnXEOrJO2X5aXc
XSHmmH21/GTbYnqmHW2PJ4M4PhqPCwe4g3X7CxH2S8vfzrw4Bi0DgseuFFF3ruVM
O90DLNYmpRdvkqGmyCDU2NNB9SCHs0TRax3oPJZHraETI+8cXg+GQxSUsk8/O/f6
ghZWdfxMXfvbW1Xd8yy1nsj163/OfDNR7g3oovhCyb/W2aFjoY87TZQujrxXytsH
h8KGpGLXl617cOIvggAfgNhH+x8BDBQF6qhA2ePouwAeyzrpyfouBg01v11Spyee
3JqPXyV8aa1ukfJhg/Ok1hrwiEGcWE9vdhaKB4P8Yya6X2fUlSPOLH9Teh/JqbI2
hb8RE4umlvpK6uEheWH/N5RGmdvVQEnrW/mR2O25GKBPSACkTPhwt+/BNwKQ6A7q
viBhy/ZyLPEW3sn1x+jDK3rgqh0q6s7AI0taiTXFE0r6RuoeaKO+/Juy9b6XJH/1
KVH8jqlZwzO6id/94gJr0OmwC/t4F/UezHh5bDohnxEgT/qERWjKE9Ji+yr2cfKs
FkUQVjpRf24F73iunEC+E0Ux3RxMlC2/DcM4bu8AdvAMCQK63WNGBJuAYbOYr6L1
fAJsO+jYHp/vgCVQjqYucaL/jzoSTkpgt8U01vT7MmpcSOU+C6II0pHVDLlqR2+q
/buNP2Npuc0/30amlmDKLgdyQVLAPgyhZHZ0226HteEVJn9bMOQG2LVWLqCce7q9
DQ0jwOXeaCvs/Fb7tXdVmM2Iy++fwh9o8JEwnnsmpGclYzBBmUKHAVb940lnrpBX
Bg9aQAznc6UM189GCjanlmfFGoT6qhGOa6tyfGsYsb8uiR3KllhqUMhuXzVfrr+e
IA4cL5WpLyhCptT8X4B3WZWvouiRyya3olQhzebwfk4josJUSiRqd6k/zq9a5P0T
7/othOWWsrS5g+8thrU+BjdXSju9B+Oz5EQMgC+/h1W7KJlRH0O5iJsA8Uw1zC7N
WeWsf7M7Wdz4AvGvHvW03L7oMAnx/49CI/+XA8NsCrcfo5w1fGa/Ndq+vcOnOTvg
SI3o8Esea0s/00rVIfBcTVCzr7S5spcVW1NOVL9bF3GtPhbHhnSyKSKvjTbhwBnp
DHBvABenq+IPJBfHIq++p7s9r3YTl1MMzlGd3CRYyU5ChFy9xYeL0jFFk+8Z4oCQ
/RvltBDlT2wFiEXWn9S0wZe9Hsim4kLJQMJuDLGc1r8STHYBRjwNaMxy5L7hGnJw
9tSCHkV3wsC7i2VeZxqWfIXfxjEynaMsBq+KCZOP7ZciyYrgLAYAatfPhE1sIm7c
rDmt1zPcPItEi2L7p/cIKyA5smssZDHAsVpvXQfx0TYBzT5l0LqyzyHCuRCGzu+d
z34loP1PdM3kJ3FsbcKtIp6zzkstBIHiaQKCVa/2ULhRwH2W6bUlW8xkZ744sxat
Ez39mxzecBbHeaW9rFSe4JUaRbcovRolWrF7GuBeNlVWlYp3B17uQyBkynO3Riw0
ZAoxueBbY518IsuPtABbf6l6IL9IYnkyqBi5c15Mchxzl8vswx5lTLm8D06Jdi8p
loIQDFd7KnmdvBKPTH+bTxXVQgWh4ddT+B2if1LOlAiHx4zGy7MEakIvVIhVJHty
fwzfrn2b5LXJ3Zzw/DPscDEbzDG5Ep5WGsP6aH+/UttPeYbEOetFepjYjjZg8xIP
1GFbyU+kwNuuCmV9YIzTG7RFJHxF/R1Imh3Sjws959vfTGDicXAZolaFpZauR5sg
8FkaavDTyDR9AJE8uBZEn6uV1hH+Ep+DaV1B9NHUE3Ru9qQd2ZhfGuxNeK0hgJ0F
L3z5FYUBw+09jGFQlT2Qs4zmm1iP16ymTrfRrCLd/OA38tcvCDBIuQsrWtTmqNDQ
Newrjf2EhqQ1Ax7K3Mzbd6bSmXZ0bbqs+DzAExO/++58bBNOWe8jc/rNfyYutbOM
UbQwZ1sgijxdBdHyBpfMUC/bUV9WOKicXTrcbphIMg1NwaSJR018DuVmrEpXnCe1
CIppdZ7qOQnsyx/z1rCV4dY3DQghv4BALQD6r5YZLdSaH59bwdyqzl/O5PCk1NP3
5SA0VclYkCIw3V7XutBJxmuPbzEvF7V8Cp3jl2wSxig=
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DxBqsmrMLH1IecwCtPDrVCNxN3bBQHrOsAFJoL/Iw8sKunbIAsb20uj5V5rHlG9a
Px7u91krUZ9yUMeIw+sHbx4PF3TV8uuvUJJ2b+XRr7plgQGKs+Ndz+7UzA1s+b3X
PX/qREG2ATQnhHNSPGzSATEBdfo29HvZJ3TAnZd8djs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33749     )
n0gr92n66Jzk3KRXFw2tQ+SL0GufdzZkqb1QoycBCbTtFKL50dwrtnSFXhFw6TLY
w7cW88floRChKTDnuoyifq+ZY5EbhleodD46ncueUOHnYKwYUciCsAxcE/CyCS0X
`pragma protect end_protected
