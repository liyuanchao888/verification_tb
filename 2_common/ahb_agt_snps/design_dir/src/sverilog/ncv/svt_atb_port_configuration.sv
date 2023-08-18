
`ifndef GUARD_SVT_ATB_PORT_CONFIGURATION_SV
`define GUARD_SVT_ATB_PORT_CONFIGURATION_SV

//`include "svt_atb_defines.svi"
typedef class svt_atb_system_configuration;

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
UK7DmyBUWYyARS3T7BNQiHCx92hDix20+PAjeg8iyCgQoubrbBaDupr6mIhStfZ9
B5nu5YpSw0vK9AmfW8SSW79Wrm5TIGX2R6KTghR3ZGHJUVFr3bay74iEhe/wOfWw
jS38xvifCwOmdY5cywI+ff0yWKWCU4oSXKr79UhRqBcmYzqVdBEpiw==
//pragma protect end_key_block
//pragma protect digest_block
DXnR34FQm6ytYxYwekaqAqckhvA=
//pragma protect end_digest_block
//pragma protect data_block
ZqHUalf9RKUq7tW+S3x1l/7KldLhsH54Wp8uKqo2JJ39wx1bDsQq4AHCg1mRG6Ug
cgGYq1nHdZjSgS+I87kSA44BAnyI/MlSH/SwBUUsH8wUO6/NVVd26891egTStejj
XuP0ZSMbhS3RHIMcsz41NmLgh5r1IV8UvW8+x6z15n02oBeaa8h6KEo6aN7TfFLk
eZEWE5l6a9S3BBAm2Mao+tjmFou9U4cHsc3xbpvKSfuHbNFTZllok+fGmBh8odkb
3UzvYuE0cKtS1jdCzXsDveUdPSd9ZYcpCf9nDOz7vnch5Y/YP5Qob4YHp5z1S/Gq
p8mU9iGGMCVq30+Q5r5sGUrVV9Ki6j4SXhtCd0K5RyDex78cGzazmmsBn33bLX7o
zH4uO/c87moi0cf+Rgl+st6IvSxmpbTtPKusP2fLRu8Mycu2No7EChUN+NKkLHk5
k7qUCNMG1JDrxUy7snMvgcgfAzRJTfdAraoJFBjrRMJUAlPnouy7aiOiXqbtrwgM
eXZfZg7BVtx5XTj230nEFzLVVwWcwRwEaeoz+pF0CZITBazbFXagit/psW0enhfS
mG/Szw9FiHIMNeZVH7n/o/fC1aguV2dl6D+9lvNdYxCBSrsID2FoAx9YdinTxqYS
K8S47mClvRrIQBtOjgzuAytKXwz99yeRjMhulzk5swZQTkdzkpi335A8TBhTfsVo
VtWWax6BWbFkFPGkRVH1izFfe7W7sxEniCK1fX3Eg12Z+apPlAxcyuhcJRGayAIp
CxXfXErjGP5nIe9jB8TXAnJhoHmC7bei8bD6EXN61R2Ad+T0mtebZHkbMRvP3VoP
QKk+mXD5/T63QtMh4PquwM1hn3ZKhD4jjxUjnPMTGL9Q4cKe62KnAiN4r0d946pH
a58xExq9ue4X42auYQk7f6CFQIWxiS0/3O1fK9laZN09m5c9CNn+0ml01WQCotb2
6SuO2tNdZKk0So5txuvDEsKgJL7d2LEO6irSkJtdTULZbAB+wMGnB/xfZERAKvF8
Gwi0mfUmXFoE1hX+Uj038fVV34ZRouz6SdssUubY6LLZX+dEq+2v/f5CZXQ0DFRU
w54v/ahiW6XUqVjaRBGp74iuUPl3viEBCbE92M4ht5JzS6N1TA+KEpwy8yFDLv5B
QcaCE9sOg2LNYF96oJ0/SLPVD6DDCHqHVHAeE2sQ2fKCE1A5+kcYKaNKJ08GvySV
kP4cOj0iuNyFwVW16Cf+irFHkD+jrsepFTSwCRbWz+i6Z7S72ycmddghXdSKBTru
Iuehp5kj91ssnwts8OZc9ABgzAgr7SHoeno9YkPS+uv11HtcXJYMtRB8pFKsZHjv
2R45SesggqJlUHOAMpo/4QywsyOO4evT4sztcmrEWRR983dWhHP/Hv3bkhSGe7Wb
cDdh+baxxCaf+DIaIOX9Iz5vUNbeww7PJyak26IGPtwTeQu7rf50+3xcDOgkWrLZ
MxYzvL5HDe4lYclb8dYjvtkwxoxJepC7LeRAJf1oIH74xWQDcCgKWhpErd5RturM
+LwF/TrZwojJiMXs+CVZf/1K/aDjWd8GyQbfBMlHC9I=
//pragma protect end_data_block
//pragma protect digest_block
WIfE9wy3G3QqstMQmXCyHr6NiLw=
//pragma protect end_digest_block
//pragma protect end_protected


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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+t9pEuRhbtUmVG6frlAhBNYqF8Mmg/8lvEb2LpSqy6Ef1Pe4RhbeLb9fEOAV6By/
70RQj3bo+n2EFxg4uZlCgaDEEcq9kBAEU30u0axA0EAOC0XCVK+4QyKx+9QkVO4T
JMUSt/wMuruceS6aoK5NIW5P36zjVAQWzjjeo1WozqNdzU5KmZUKdw==
//pragma protect end_key_block
//pragma protect digest_block
/xWClbeC1LMRfaRcavSzjqBDcAY=
//pragma protect end_digest_block
//pragma protect data_block
4+VCV2lGNDtq/X8GlsH5eK484409LUGMndVbqqOT/jkGUX/TSe1Uol2TfukiUJZ/
JXQ+HdaQMqVlBjnbmWX8oM+Nz0XIK9ufnOPwjPtDLLV3IQVff74Ng8gA3TyQ47Tf
OrQpc3aTB14w0TanB1jh6rHWrODEfkbMO5ujMs+mUwv1baXSNzSu5E4TYZBrIJ9T
Uvbl+xx9Tjc7Eenj+doYcRqzIbYcYw9glEn7jD4hVt6TP+ePuAXA8U2/9EBgOZEl
EedQwVH9AJBEPtQT5PRk+YzSpw/nQsATw9iMzLJZfVqsheYaDdOk9n6swqQ4ZZgu
L+b5kzK5qy2CSpg/X0vtmU1k0w31jo16gzVMUCwXdua/hJ32DZ1g+RfhdKY7zgHC
ORH9npVLVJYAFqorbMhqoSuNcXZAo8Vbs3ql7bvwiFkJz07Fafp/cP55O2zHXOHJ
PLmwwCOF3xgZB60eh0o+7FJRXstP9vyudEUijT2yVatjq1TnITXxVv9RsB67+BBe
08UGriYWiIq/rnfWmdWrIfqtcQIDIeMOH/wyn9LlR2vlunhEtAkrAQBBU83gLLOu
sTvMwxHfNp9vAzQxZv7z7hIR679Q05V4G0U9RPKTPAjHTwJ6l8X6LXR5dQP48mbP
oqVlQROxJFCISQVUwq25slrg++ZrivEh2etDaMSteGPOWTxUAwHL/fWCZNm5fUYm
LtCX86fAjM/B1aVlMrLL4ww8qH8HHkE1ir8/MW1WV/arn7YRp6nyc2AhT0AE59Qi

//pragma protect end_data_block
//pragma protect digest_block
wLL/PqVkgdBXa0dOg77qntdKdfg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
P3WJ+U14NUJ+wHWPzFj6I5AlgQkzIZlRcddtSu1iLy7YGNgUtOOHtpVNf3zpowK5
vZd9tGHx+K0mhMbh4fXmkUXvcxmWIktxpA4D8iiwk/65xEO56VPn+hJzMR0Px5YG
58IZUvJ2eiz56aoldjzkNu4h3yP2bkRDzzdj3RIKIof2OP7GRyp4QA==
//pragma protect end_key_block
//pragma protect digest_block
+LhaN5nBQWvkKwq/lq5ZqUwcxnQ=
//pragma protect end_digest_block
//pragma protect data_block
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
w10Bc6hYIZxphKZvLkThzw==
//pragma protect end_data_block
//pragma protect digest_block
Zb1ybBaNmfuV1B/0U/tf6q8MCkk=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
E68u2+KRdgVJ9g6KzjH0ogFp8/NRQfrU3IsWJMGwzWQNaDKF3y62KJTZlYweZq2J
kyygi7TNkXyeAInHGxPkK/+3J8b5McEt3D6O61nsB1UJXI1MKFdDOGRjaOwYKIyJ
LysIUNzcwCaJpJ+fQB27+rCJ1kL+0teSnyztoypwefHVVjMoF48e0Q==
//pragma protect end_key_block
//pragma protect digest_block
iTWrQ4Rm1VPqHJsqv1+F20qeoZg=
//pragma protect end_digest_block
//pragma protect data_block
Gi73jefS1mxxn8pyHGDGf5l2+ngVix4+867GOhll1GX9dTx9ybOW7q0mTsDqr0g1
2eswMAPqyQxpbD3CdNoWHrSnbQfC2LIGykVR0ixHPaSD16+BDEEeJuFFoqI0ifki
a6GjNxEtxroJ4+2krwv7PtgvsZoepmuVydijTFMHzqYJp+fnANWMQyfUBRqeSpbx
RPas23cyJbCzYtkWo7jRQISQIc3QAyRx0NsLFInGgO/8db4fCLH5ILVsYGgWoTB+
cZsGlfOcUvaYVTiwmXAIa8jz54p/lsr6/CifU4R5w50wpb6Bzk9DRWCQPC3obVar
S2OQXH5fLQfgZc0rco6FDtrtlS/KWdYEx6iQMXQw4hqoDMl2bWrzA9NtppVDYFcY
o3c1TawHgULQ7h7AXDy9xrDLlKR5morZynMlJeu+BQsfkl4n38CYp/M1ZA6FgVFm
F7xiRy9RNmD+QC2mb2jk/l+RaGCGLDdzBsPXV3e5ASlN1g+7D92YrkdR7RC6Q5ql
2g+ciVEckEiEP9HqIAAe36184YOYyv1Rt4s4/jjx2gBARD+WYkKbfe1LnzgyNQxt
kn5XsBeYXlIjfUh90LTuC5+4j7/c5wDJzCvLHfdzKWnMNi3iBO6+eYZkkpsocmKI
i5Wt6P0KpDVvW/BvDCxZ9rjwPebUT4VvhfrabYtQoxVr4r2vnorQfle/GoR5OR5v
C+tUSpgv+1lalQrmSQWbkPHcj3xYRSdWex87i5qtC9Re+tKe4YR0IFddcKiAYl7b
I8f0CWcVcmcw/IGbmE58EEhygkFVnHNq2riC3aByGKO2wvlXf1WFHgBhPka8UNjG
REmgDoyg33COYNCx8SFpK4OiQYlgXyZrly8qPuk2jIx6NDLRyhTU07YtwroQtah0
9wmr2v2QjuTUReVCaAAEn6L0XdQkZhgILF+bj/ETF+14Nt9ibj2Vc1ryrsj8DwEm
HFqBZgmlq5QWDyFAZUWEMxQwrL/MwLH1wqEn5/uYYUoiuQKa428coYOrZjoxa7nW
YDEDfnrSUznJxu6ADIKQPkCS4LnmW3+tJuAph+3U8y5QUd+5jlIc3J8X5watryDt
OjPH4xM2yx4xEQSwVsRmU6xGbHu/PIWDa/zKfK//DDMeBMJGP4xu33CgyFArsQvu
2d8PbJk/CsHi+E24EgwN/9qak/yWutNRU63hH8nHfaNvR9Iy0FtbDE7h9pW0fYN0
15xKa5VtNSKYdUq1YRCw4HSEht5MQq7D12s56aphi4RLIib9ZbckT4CeVBAB3Hq+
GFeOWuM5Oy6+LYQ6Gkln73TyVIGxZ7/hYtg25M+oBwgiXji1j/We8caM10FFl6AN
WZcwri/tzO64HDdBE9lGt59SzTMnKwiLwGlfprA/c7AprdcGbmn7B+q+GlaDhsKq
Wun40LOqJyzTwJgdBXth41RGDcoMWoa3NWCiE+sjSXET+YHz9o5f8dableXpH5+p
oE3sWg6jGnL2oubetwH6BozRFVtIBSBiYRZVEUJvrvTrMl17AJWw9IIVSVaRSE8l
aU09+6SnnjP+beewtT+ki73MX1rrK0H2P/X3GV9jyhFPuREyvu5rlq775QAQlkXE
rF3x7PeJa8O3A2V8hpi0Aw==
//pragma protect end_data_block
//pragma protect digest_block
AOGTglG+RJBXx8pY3zjMHJ9FvAs=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
05pOZur0fKWLMKKhqe/xRlNIILTsMiLgaqR+OZyD5YQ4E188PaM+9ut/r30aXpVz
uigPva9rMWK9gYJAHkiWPuRGunbK/QNiOyZpBw/riTlzzE1WWOGnZCteP8xDbbdi
HW4+dZ/XBrYjNIt3sKnXO0VzGcHkQqEMjlSFett7fqQzWCaRl6jFrQ==
//pragma protect end_key_block
//pragma protect digest_block
rHVCQqjIOH0K+9MH1J/0WFsrMA0=
//pragma protect end_digest_block
//pragma protect data_block
+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
PZWrGi4mmcCd2tDY9J0aow==
//pragma protect end_data_block
//pragma protect digest_block
0mBhTbKQdHZQNm90RL3b+PoKeoE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
