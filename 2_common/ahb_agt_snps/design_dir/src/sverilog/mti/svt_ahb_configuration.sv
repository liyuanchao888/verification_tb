
`ifndef GUARD_SVT_AHB_PORT_CONFIGURATION_SV
`define GUARD_SVT_AHB_PORT_CONFIGURATION_SV

`include "svt_ahb_defines.svi"

typedef class svt_ahb_system_configuration;
typedef class svt_ahb_slave_addr_range;

/**
 * The base configuration class contains configuration information which is
 * applicable to individual AHB master or slave components in the system component.
 * Some of the important information provided by port configuration class is:
 * - Active/Passive mode of the master/slave component
 * - Enable/disable protocol checks
 * - Enable/disable port level coverage
 * - Interface type (AHB/AHB_LITE)
 * - The virtual interface for the port
 * .
 */
class svt_ahb_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual AHB interface */
`ifndef __SVDOC__
  typedef virtual svt_ahb_master_if AHB_MASTER_IF;
  typedef virtual svt_ahb_slave_if AHB_SLAVE_IF;
`endif // __SVDOC__
 
  /**
    @grouphdr ahb_generic_config Generic configuration parameters
    This group contains generic configuration parameters
    */

  /**
    @grouphdr ahb_signal_width AHB signal width configuration parameters
    This group contains attributes which are used to configure signal width of AHB signals
    */

  /**
    @grouphdr ahb_signal_idle_value Signal idle value configuration parameters
    This group contains attributes which are used to configure idle values of signals
    */

  /**
    @grouphdr ahb_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable coverage and protocol checks
    */

  /**
    @grouphdr ahb_performance_analysis Performance Analysis configuration parameters
    This group contains attributes which are used to monitor performance of a
    system based on measurement of latencies, throughput etc. The user sets the
    performance constraints through performance analysis configuration
    parameters and the VIP reports any violations on these constraints. The time
    unit for all these parameters is the simulation time unit. Performance
    metrics that involve aggregation of values over a time period are measured
    over time intervals specified using configuration parameter
    perf_recording_interval. Measurement of other performance parameters that do
    not require aggregation of values over a time period are not affected by
    this configuration parameter. VIP reports statistics for each performance
    metric for each time interval. Each performance parameter can be enabled or
    disabled at any time.  Monitoring of a performance parameter is disabled by
    passing a value of -1 to the parameter. Passing any other value enables the
    performance parameter for measurement. If a value other than -1 is supplied,
    it will take effect at the next time interval. If the performance
    configuration parameter values are changed during simulation, the new
    configuration will need to be passed to the VIP using the #reconfigure()
    method of the top level VIP component, for eg. #reconfigure() method of AHB
    System Env will need to be called if AHB system Env is used as top level
    component.
    */

  /**
   * Enumerated type to specify idle state of signals. 
   */
  typedef enum {
    INACTIVE_LOW_VAL  = `SVT_AHB_INACTIVE_LOW_VAL,  /**< Signal is driven to 0. For multi-bit signals each bit is driven to 0. */ 
    INACTIVE_HIGH_VAL = `SVT_AHB_INACTIVE_HIGH_VAL, /**< Signal is driven to 1. For multi-bit signals each bit is driven to 1. */
    INACTIVE_X_VAL    = `SVT_AHB_INACTIVE_X_VAL,    /**< Signal is driven to X. For multi-bit signals each bit is driven to X. */
    INACTIVE_Z_VAL    = `SVT_AHB_INACTIVE_Z_VAL,    /**< Signal is driven to Z. For multi-bit signals each bit is driven to Z. */
    INACTIVE_RAND_VAL = `SVT_AHB_INACTIVE_RAND_VAL  /**< Signal is driven to a random value. */
  } idle_val_enum;

  /**
   * Enumerated type to specify state of hrdata signal during busy.
   */
  typedef enum {
   INACTIVE_LOW_VALUE  = `SVT_AHB_INACTIVE_LOW_VAL,    /**< Signal is driven to 0. For multi-bit signals each bit is driven to 0. */
   INACTIVE_HIGH_VALUE = `SVT_AHB_INACTIVE_HIGH_VAL, /**< Signal is driven to 1. For multi-bit signals each bit is driven to 1. */
   INACTIVE_X_VALUE    = `SVT_AHB_INACTIVE_X_VAL ,     /**< Signal is driven to X. For multi-bit signals each bit is driven to X. */
   INACTIVE_PREV_VALUE = `SVT_AHB_INACTIVE_PREV_VAL,   /**< Signal is driven to a previous value. */
   INACTIVE_Z_VALUE    = `SVT_AHB_INACTIVE_Z_VAL,    /**< Signal is driven to Z. For multi-bit signals each bit is driven to Z. */
   INACTIVE_RAND_VALUE = `SVT_AHB_INACTIVE_RAND_VAL  /**< Signal is driven to a random value. */
  } busy_val_enum;

  /** @cond PRIVATE */
  /**
    * Enumerated type for the kind of inactivity period for throughput calculation
    */
  typedef enum {
    EXCLUDE_ALL = 0,
    EXCLUDE_BEGIN_END = 1
  } perf_inactivity_algorithm_type_enum;
  /** @endcond */
  
  /**
   * Enumerated type to specify Big Endian Invariant modes. 
   * This enum is applicable along wiht svt_ahb_system_configuration::ahb5=1 and svt_ahb_system_configuration::little_endian=0 when invariant_mode=1
   */
  typedef enum {
    NO_INVARIANT   = `SVT_AHB_CONFIGURATION_NO_INVARIANT,/**< Indicates no invariance mode, defaulting to big-endian mode in AHB5 mode. */ 
    BYTE_INVARIANT = `SVT_AHB_CONFIGURATION_BYTE_INVARIANT, /**< Indicates Byte-invariant-BE8 mode in AHB5 mode. */
    WORD_INVARIANT = `SVT_AHB_CONFIGURATION_WORD_INVARIANT  /**< Indicates Word-invariant-BE32 mode in AHB5 mode. */
  } invariant_mode_enum;

  /** @cond PRIVATE */
  /** Enumerated types that identify the type of the AHB interface. */
  typedef enum {
    AHB        = `SVT_AHB_INTERFACE_AHB, /**< Interface is an AHB interface. */
    AHB_LITE   = `SVT_AHB_INTERFACE_AHB_LITE, /**< Interface is an AHB Lite interface. */
    AHB3_LITE  = `SVT_AHB_INTERFACE_AHB3_LITE, /**< Interface is an AHB3 Lite interface. */
    AHB5       = `SVT_AHB_INTERFACE_AHB5, /**< Interface is an AHB5 interface. */
    AHB_V6     = `SVT_AHB_INTERFACE_AHB_V6 /**< Interface is an AHB_V6 interface. */ 
  } ahb_interface_type_enum;
  /** @endcond */
  

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Enumerated type that defines the generator source for slave responses
   */
  typedef enum { 
    NO_SOURCE    = `SVT_AHB_CONFIGURATION_NO_SOURCE,           /**< No external source. This generator_type is used by master component. This specifies that no internal source should be used, and user is expected to drive the master driver input channel. */
    ATOMIC_GEN   = `SVT_AHB_CONFIGURATION_ATOMIC_GEN_SOURCE,   /**< Create an atomic generator. This generator_type is used by master component. This specifies the master component to use atomic generator. */
    SCENARIO_GEN = `SVT_AHB_CONFIGURATION_SCENARIO_GEN_SOURCE,  /**< Create a scenario generator. This generator_type is used by master component. This specifies the master component to use scenario generator. */
    SIMPLE_RESPONSE_GEN = `SVT_AHB_CONFIGURATION_SIMPLE_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_ahb_slave_response_gen_simple_callback is automatically registered with the slave response generator. This callback generates random response. */
    MEMORY_RESPONSE_GEN = `SVT_AHB_CONFIGURATION_MEMORY_RESPONSE_GEN_SOURCE, /**< This generator_type is used by slave component. When this generator_type is specified, a callback of type svt_ahb_slave_response_gen_memory_callback is automatically registered with the slave response generator. This callback generates random response. In addition, this callback also reads data from slave built-in memory for read transactions, and writes data into slave built-in memory for write transactions. */
    USER_RESPONSE_GEN = `SVT_AHB_CONFIGURATION_USER_RESPONSE_GEN_SOURCE /**< This generator_type is used by slave component. When this generator_type is specified, slave response callback is not automatically registered with the slave component. The user is expected to extend from svt_ahb_slave_response_gen_callback, implement the generate_response callback method, and register the callback with the slave response generator. */
  } generator_type_enum;
`endif

`ifdef SVT_VMM_TECHNOLOGY
  /** 
   * @groupname ahb_generic_config
   * The source for the stimulus that is connected to the transactor.
   * Default value: 
   * - SCENARIO_GEN for master transactor.
   * - MEMORY_RESPONSE_GEN for slave transactor.
   * .               
   * Configuration type: Static
   */
  generator_type_enum generator_type;

  /** 
   * @groupname ahb_generic_config
   * The number of scenarios that the generators should create for each test
   * loop.
   *
   * Configuration type: Static
   */
  int stop_after_n_scenarios = -1;

  /**
   * @groupname ahb_generic_config
   * The number of instances that the generators should create for each test
   * loop.
   *
   * Configuration type: Static
   */
  int stop_after_n_insts = -1;

  `endif

`ifndef SVT_VMM_TECHNOLOGY 
  /**
   * @groupname ahb_generic_config
   * Specifies if the agent is an active or passive component. Allowed values are:
   * - 1: Configures component in active mode. Enables sequencer, driver and
   * monitor in the the agent. 
   * - 0: Configures component in passive mode. Enables only the monitor
   * in the agent.
   * - Configuration type: Static
   * .
   */
`else
  /**
   * @groupname ahb_generic_config
   * Specifies if the group is an active or passive component. Allowed values are:
   * - 1: Configures component in active mode. Enables driver, generator and
   * monitor in the group component. 
   * - 0: Configures component in passive mode. Enables only the monitor
   * in the group component.
   * - Configuration type: Static
   * .
   */
`endif
  bit is_active = 1;


  /** 
    * @groupname ahb_generic_config
    * A unique ID assigned to the master/slave port corresponding
    * to this port configuration. This ID must be unique across
    * all masters/slaves of the AHB system configuration to which
    * this port belongs. A master and a slave may share the same
    * port_id, but two masters or two slaves cannot share the 
    * same port_id. If not assigned by the user, it is auto
    * assigned by the VIP. 
    */ 
  int port_id;

`ifdef SVT_UVM_TECHNOLOGY
  /**
    * @groupname ahb_generic_config
    * When silent_mode is set to 1, the "Transaction started" and 
    * "Transaction ended" messages are printed in UVM_HIGH verbosity.
    * When silent_mode is set to 0, the "Transaction started" and 
    * "Transaction ended" messages are printed in UVM_LOW verbosity.
    */
`elsif SVT_OVM_TECHNOLOGY
  /**
    * @groupname ahb_generic_config
    * When silent_mode is set to 1, the "Transaction started" and 
    * "Transaction ended" messages are printed in OVM_HIGH verbosity.
    * When silent_mode is set to 0, the "Transaction started" and 
    * "Transaction ended" messages are printed in OVM_LOW verbosity.
    */
`else
  /**
    * @groupname ahb_generic_config
    * When silent_mode is set to 1, the "Transaction started" and 
    * "Transaction ended" messages are printed in DEBUG_SEV.
    * When silent_mode is set to 0, the "Transaction started" and 
    * "Transaction ended" messages are printed in NORMAL_SEV.
    */
`endif
  bit silent_mode  = 0;

  /** 
   * @groupname ahb_generic_config
   * A unique ID assigned to master/slave port corresponding to this port
   * configuration. This ID must be unique across all AMBA components
   * instantiated in the testbench.  This is currently applicable only when the AMBA
   * system monitor is used and is configured using a configuration plain text
   * file (as opposed to a SystemVerilog code that sets the configuration). 
   */
  int amba_system_port_id = -1;

  /**
    * @groupname ahb_addr_map
    * Applicable only to slave VIP
    * Address map for this slave 
    * Must be used only if the svt_ahb_system_env and svt_ahb_system_configuration is not used.
    * Typically used in an environment where only one slave VIP is instantiated.
    */
  svt_ahb_slave_addr_range slave_addr_ranges[];

  /**
    * @groupname ahb_addr_map 
    * Address map that maps global address to a local address at destination
    * Typically applicable to slave components
    * Applicable only if svt_ahb_system_configuration::enable_complex_memory_map is set
    */
  svt_amba_addr_mapper dest_addr_mappers[];

  /**
    * @groupname  ahb_addr_map 
    * Address map that maps a local address to a global address at a source
    * Typically applicable to master components. However, it can be applicable to
    * a slave component if that is connected downstream through another interconnect/bridge to
    * components which are further downstream. Applicable only if
    * svt_ahb_system_configuration::enable_complex_memory_map is set
    */
  svt_amba_addr_mapper source_addr_mappers[];


  /** 
    * @groupname ahb_generic_config
    * Specifies whether output signals from master/slave IFs should be
    * initialized to 0 asynchronously at 0 simulation time. 
    * - 1: Intializes output signals from master/slave IFs to 0 
    *      asynchronously at 0 simulation time.
    * - 0: Initializes output signals from master/slave IFs
    *      synchronously at 0 simulation time.
    * .
    * Configuration type: Static <br>
    * Default value: 0 <br>
    */ 
  bit initialize_output_signals_at_start = 1'b0;  

  /** 
   * @groupname ahb_coverage_protocol_checks
   * Specifies if the component is enabled to perform signal valid level checks during reset.
   * - 1: Enables the signal valid level checks during reset
   * - 0: Disables the signal valid level checks during reset
   * .
   * Configuration type: Static <br>
   * Default value: 1 <br>
   * The below listed checks are executed when this attribute is set to 1 under the following conditions: 
   * svt_ahb_configuration::protocol_checks_enable is set to 1 AND the respective checks are enabled. <br>
   * Following are the checks:
   * - svt_ahb_checker::hready_out_from_bus_high_during_reset
   * - svt_ahb_checker::hready_out_from_slave_not_X_or_Z_during_reset
   * - svt_ahb_checker::htrans_idle_during_reset
   * - svt_ahb_checker::signal_valid_haddr_check
   * - svt_ahb_checker::signal_valid_hwrite_check
   * - svt_ahb_checker::signal_valid_hsize_check
   * - svt_ahb_checker::signal_valid_hburst_check
   * - svt_ahb_checker::signal_valid_htrans_check
   * - svt_ahb_checker::signal_valid_hlock_check
   * - svt_ahb_checker::signal_valid_hprot_check
   * - svt_ahb_checker::signal_valid_hbusreq_check
   * - svt_ahb_checker::signal_valid_hready_in_check
   * - svt_ahb_checker::signal_valid_hgrant_check
   * - svt_ahb_checker::signal_valid_hsel_check
   * - svt_ahb_checker::signal_valid_hmaster_check
   * - svt_ahb_checker::signal_valid_hmastlock_check
   * - svt_ahb_checker::signal_valid_hready_check
   * .
   * <br>
   * Note that when svt_ahb_system_configuration::common_reset_mode is set to 0,
   * a given VIP component cannot reliably perform the validity checks on it's input 
   * signals during the reset. Below are the details: <br>
   * All the signals that are inputs for a given component can be checked
   * for validity during the reset, provided common reset mode is enabled 
   * (svt_ahb_system_configuration::common_reset_mode is set to 1).
   * If the common reset mode is not enabled (svt_ahb_system_configuration::common_reset_mode is set to 0), 
   * different components will have independent input hresetn signals.
   * In such case, during reset for a give component, it's not reliable to perform 
   * checks on the input signals as the driving component of such signals
   * need not be in reset. So, under such condition, the checks on input
   * signals will not be performed. 
   * - For a master agent, following checks are not performed:
   *   - svt_ahb_checker::hready_out_from_bus_high_during_reset
   *   - svt_ahb_checker::signal_valid_hgrant_check
   *   - svt_ahb_checker::signal_valid_hready_check
   *   . 
   * - For a slave agent, following checks are not performed:
   *   - svt_ahb_checker::hready_out_from_bus_high_during_reset
   *   - svt_ahb_checker::htrans_idle_during_reset
   *   - svt_ahb_checker::signal_valid_haddr_check
   *   - svt_ahb_checker::signal_valid_hwrite_check
   *   - svt_ahb_checker::signal_valid_hsize_check
   *   - svt_ahb_checker::signal_valid_hburst_check
   *   - svt_ahb_checker::signal_valid_htrans_check
   *   - svt_ahb_checker::signal_valid_hprot_check
   *   - svt_ahb_checker::signal_valid_hnonsec_check
   *   - svt_ahb_checker::signal_valid_hready_in_check
   *   - svt_ahb_checker::signal_valid_hsel_check
   *   - svt_ahb_checker::signal_valid_hmaster_check
   *   - svt_ahb_checker::signal_valid_hmastlock_check
   *   .
   * .
   */
  bit signal_valid_during_reset_checks_enable = 1;

  /**
   * @groupname timeout
   * Used by the AHB active and passive components. This timer looks at HREADY, when a change occurs,
   * and if sampled LOW the timer task starts counting cycles. HREADY is sampled every clock
   * cycle, and if the number of clock cycles exceeds wait_state_timeout, an error is reported.
   * The integer value wait_state_timeout represents the number of clock cycles.
   * If set to 0, the timer is not started.
   */
  int wait_state_timeout = 0; 

  /**
   * @groupname timeout
   * Used by the AHB active and passive components. 
   * This timer starts when a transaction starts. If the number of clock cycles exceeds xact_timeout
   * and the transaction does not complete by the set time, an error is repoted. The timer is
   * incremented by 1 every clock and is reset when the transaction ends. 
   * The integer value xact_timeout represents the number of clock cycles.
   * If set to 0, the timer is not started.
   */
  int xact_timeout = 0; 

  /** @cond PRIVATE */  
  /** 
   * @groupname ahb_generic_config
   * The AHB interface type that is being modelled. 
   * Configuration type: Static
   */
  rand ahb_interface_type_enum ahb_interface_type = AHB;
 
  /**
   * @groupname timeout
   * Used by the AHB master and slave monitor.  If the number of clock cycles
   * exceeds the split_state_timeout, an error is reported.  
   */
  int split_state_timeout = 0; 
  /** @endcond */

  /**
   * @groupname ahb_signal_idle_value
   * Used by the AHB master, slave models. This configuration parameter controls the
   * values driven on the:
   * - inactive byte lanes of write data bus by the AHB master model, 
   *   and also when write data bus is inactive.  
   * - inactive byte lanes of read data bus by the AHB slave model, 
   *   and also when read data bus is inactive.
   * .
   * This helps in detecting any issue in the RTL which is sampling the data bus at an 
   * incorrect clock edge.   
   */
 idle_val_enum data_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_DATA_IDLE_VALUE); 

  /**
   * @groupname ahb_signal_busy_value
   * Used by the AHB master and slave models. This configuration parameter controls the
   * values driven on the: 
   * - read data bus by slave when HTRANS is BUSY.
   * - write data bus by master when HTRANS is BUSY.
   * - currently supported values are: 
   *   INACTIVE_LOW_VALUE : Signal is driven to 0
   *   INACTIVE_HIGH_VALUE : Signal is driven to 1
   *   INACTIVE_X_VALUE   : Signal is driven to x
   *   INACTIVE_Z_VALUE : Signal is driven to z
   *   IACTIVE_RAND_VALUE : Signal is driven to random value 
   *   INACTIVE_PREV_VALUE  : Signal is driven to hrdata/hwdata previous value
   * - Default value is   : INACTIVE_PREV_VALUE 
   *   
   * .
   *   
   */
 busy_val_enum data_busy_value = busy_val_enum'(`SVT_AHB_DEFAULT_DATA_BUSY_VALUE); 
  /**
   * @groupname ahb_signal_idle_value
   * This configuration parameter controls the values driven on the following AHB
   * control signals by AHB master, slave drivers in active mode:
   * - hburst
   * - hwrite
   * - hprot
   * - hnonsec: when svt_ahb_configuration::secure_enable is set to 1
   * - hsize
   * - control_huser: when svt_ahb_configuration::control_huser_enable is set to 1
   * .
   * 
   * Note that when reset is active, the above signals will be driven to a value of zero irrespective of this parameter setting <br>
   * 
   * Following are the different Idle conditions
   * - Normal Idle cycles
   * - Idles during two cycle responses
   * - Idles during EBT
   * .
   */
  idle_val_enum control_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_CONTROL_IDLE_VALUE);

   /**
   * @groupname ahb_signal_idle_value
   * This configuration parameter controls the values driven on the address bus by the
   * AHB master model when the address bus is inactive.   This helps in detecting any
   * issue in the RTL which is sampling the address bus at an incorrect clock edge. <br>
   * Note that during reset, addr will be driven to a value of zero irrespective of this parameter setting
   * Also this parameter will not be effective when xact_type is set to
   * idle_xact.
   *
   */
  idle_val_enum addr_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_ADDR_IDLE_VALUE); 

  
  /**
   * @groupname ahb_generic_config
   * This configuration parameter defines the invariant modes in AHB5.
   * Applicable for both Read and Write transactions
   * Applicable for both AHB Master/Slave Active/Passive modes
   * Applicable only when svt_ahb_system_configuration::ahb5=1 and when svt_ahb_system_configuration::little_endian=0(Big-endian format) 
   *
   * The default value is set to SVT_AHB_CONFIGURATION_NO_INVARIANT indicating little-endian mode without any invariance in ahb5 mode. This is required to maintain backward-compatible  
   * When set to SVT_AHB_CONFIGURATION_BYTE_INVARIANT indicates byte-invariant(BE8) mode.
   * When set to SVT_AHB_CONFIGURATION_WORD_INVARIANT indicates word-invariant(BE32) mode.
   *
   * This will enable the user to configure different endian schemes.
   */
 invariant_mode_enum invariant_mode = NO_INVARIANT;

  /**
   * @groupname ahb_extended_mem_type
   * This configuration parameter defines the AHB5 extended memory types
   * property being defined / enabled or not when 'ahb5' of system configuration
   * is asserted. 
   */
  bit extended_mem_enable = 0;

    /**
    * @groupname ahb_signal_secure
    *
    * Slave for which separate secure & non-secure address space is enabled i.e. bit is set to '1', it will accept both secure
    * and non-secure transactions targeted for the same address. However, while updating memory it will use tagged address i.e. 
    * address attribute, in this case security bit, will be appended to the original address as the MSB bits.
    * 
    */
    bit secure_enable = 0;
    
    /**
    * @groupname early_burst_termination
    * This configuration parameter makes sure that if master looses grant during INCR burst type transfer, the transaction is not 
    * treated as EBT.
    * Value 1 means that the transaction will be treated as EBT.
    * VAlue 0 means that the transaction will not be treated as EBT.
    * Applicable for : passive master, active/passive slave.
    * .
    */
    bit enable_ebt_for_incr =1;

  /** @cond PRIVATE */
  
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  
  /** 
   * log_base_2 of \`SVT_AHB_MAX_DATA_WIDTH. 
   * Used only as a helper attribute to randomize data_width.
   *
   * This parameter is not required to be set by the user.
   */
  int log_base_2_max_data_width; 
 
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
    * @groupname ahb_signal_width
    * Address width of this port in bits.
    *
    * Configuration type: Static
    */
  rand int addr_width = `SVT_AHB_MAX_ADDR_WIDTH;
  
  /** 
    * @groupname ahb_signal_width
    * Data width of this port in bits.
    *
    * Configuration type: Static
    */
  rand int data_width = `SVT_AHB_MAX_DATA_WIDTH;

  /** 
  * @groupname ahb_signal_width
  * Defines the width of AHB control sideband signal control_huser for specific 
  * master or slave.  
  *
  * Configuration type: Static
  */
  rand int control_huser_width = `SVT_AHB_MAX_USER_WIDTH;

  /** 
    * @groupname ahb_generic_config
    * Enables control_huser sideband signal in the VIP. control_huser signal can be 
    * used when svt_ahb_configuration::ahb_interface_type is set to AHB or AHB_LITE.
    * Configuration type: Static
    */
  rand bit control_huser_enable = 0; 

   /** 
  * @groupname ahb_signal_width
  * Defines the width of AHB data sideband signals hwdata_huser and hrdata_huser for specific 
  * master or slave.  
  *
  * Configuration type: Static
  */
  rand int data_huser_width = `SVT_AHB_MAX_DATA_USER_WIDTH;

  /** 
    * @groupname ahb_generic_config
    * Enables hwdata_huser and hrdata_huser sideband signals in the VIP. data_huser signal can be 
    * used when svt_ahb_configuration::ahb_interface_type is set to AHB or AHB_LITE.
    * Configuration type: Static
    */
  rand bit data_huser_enable = 0;

  /** 
    * @groupname ahb_generic_config
    * Enables termination of INCR burst with BUSY transfer.
    * When default to 0, driving of BUSY after last beat for INCR burst is not allowed.
    * When set to 1, driving of BUSY cycles after last beat in INCR burst is allowed.
    * Thus terminating of INCR burst with BUSY transfer changing HTRANS to NONSEQ/IDLE is achieved.
    * When end_incr_with_busy is 1 either in AHB3 mode, svt_ahb_system_configuration :: ahb3=1 
    * or in AHB5 mode, svt_ahb_system_configuration :: ahb5=1 change of HTRANS from BUSY to either NSEQ/IDLE is allowed. 
    * Currently applicable in AHB-Lite mode configuration, svt_ahb_system_configuration :: ahb_lite = 1.
    * In AHB-Full mode, this is supported only when svt_ahb_configuration :: enable_ebt_for_incr = 0.
    * A transaction with this feature enabled and having burst length greater than or equal to 1 should not target 
    * the last address location of the slave as there is a possibility of crossing the slave boundary. 
    * There are constraints and is_valid check in the master transaction class will take care of 1KB boundary crossing with this feature enabled.
    * With the feature enabled the busy cycle for the last beat of the INCR burst has to be programed with nonzero value. 
    * Configuration type : Static
    * Applicable : Active Master and Passive Master
    */
  rand bit end_incr_with_busy = 0;

`ifdef SVT_UVM_TECHNOLOGY
  /** @cond PRIVATE */
  /** 
    * @groupname ahb_tlm_generic_payload
    * In active mode, creates a tlm_generic_payload_sequencer sequencer capable
    * of generating UVM TLM Generic Payload transactions and connects the
    * sequencer to it.  The master sequencer starts a layering sequence that gets
    * transactions from the tlm_generic_payload_sequencer, converts them to (one or more) AHB
    * transaction(s) and sends them to the driver.
    * 
    * AHB transactions observed by the agent
    * are also made available as TLM GP transactions through the
    * tlm_generic_payload_observed_port in the monitor. Note that the TLM GP
    * transactions issued through the analysis port may not match one to one with GP
    * sequence items created by the tlm_generic_payload_sequencer because the
    * GP sequence items may have to be mapped
    * to multiple AHB transactions according to protocol requirements. The
    * TLM GP that is available through the tlm_generic_payload_observed_port of
    * the monitor is a direct mapping of the observed AHB transactions converted to a TLM GP.
    * No attempt is made to re-assemble a set of AHB transaction into a larger TLM GP.
    * 
    * The layering sequence that converts the TLM GP to AHB transactions is the
    * svt_ahb_tlm_gp_to_ahb_sequence and is available at
    * $DESIGNWAREHOME/vip/svt/amba_svt/<ver>/ahb_master_agent_svt/sverilog/src/vcs/svt_ahb_tlm_gp_sequence_collection.svp 
    * Transactions created by the layering sequence are of type
    * cust_svt_tlm_gp_to_ahb_master_transaction. Any user constraints specific
    * to AHB must be provided in a class extended from this class.
    * 
    * In passive mode, observed AHB transactions are made available as TLM GP
    * transactions through the tlm_generic_payload_observed_port in the
    * monitor.
    */
  bit use_tlm_generic_payload = 0;

  /** 
    * @groupname ahb_tlm_generic_payload
    * In active mode, creates an AMBA-PV-compatible socket that can be used to
    * connect AHB Master VIP component to an AMBA-PV master model. 
    * 
    * Enabling this functionality causes the instantiation of socket b_fwd of
    * type uvm_tlm_b_target_socket in class svt_ahb_master_agent.

    * Generic payload transactions received through the forward b_fwd interface
    * are executed on the tlm_generic_payload_sequencer in the agent.

    * When this option is set, it implies that #use_tlm_generic_payload is also set, whether
    * it actually is or not.
    */
  bit use_pv_socket = 0;
  /** @endcond */
`endif
  
  /** @cond PRIVATE */
  /** 
    * @groupname ahb_generic_config
    * If this parameter is set, AHB transaction phase level information is
    * printed in note verbosity.  Messages related to start & end of address,
    * data and response phases are printed.  If unset, AHB transaction phase
    * level information is printed only in debug verbosity.
    */ 
  bit display_xact_phase_messages = 0;
  /** @endcond */

  /**
    * Determines if the transaction trace file generation is enabled.
    * 
    * - 1'b1 : Enable trace file generation. 
    * - 1'b0 : Disable trace file generation.
    * .
    * 
    * <b>type:</b> Static
    */
   bit enable_tracing = 1'b0;

  /**
    * Determines if transaction reporting is enabled.
    * 
    * - 1'b1 : Enable transaction reporting.
    * - 1'b0 : Disable transaction reporting. 
    * .
    * 
    * <b>type:</b> Static
    */
  bit enable_reporting = 1'b0;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    * <b>type:</b> Dynamic 
    */
  bit protocol_checks_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables protocol checks coverage. 
    * <b>type:</b> Dynamic 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE  
  bit protocol_checks_coverage_enable = 1;
  `else
  bit protocol_checks_coverage_enable = 0;
  `endif

  /**
    * @groupname ahb_coverage_protocol_checks
    * When set to '1', enables positive protocol checks coverage.
    * When set to '0', enables negative protocol checks coverage.
    * <b>type:</b> Static 
    */
  bit pass_check_cov = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
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
    * @groupname ahb_coverage_protocol_checks
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
    * @groupname protocol_analyzer
    * Determines if XML generation is enabled.
    * <b>type:</b> Static
    */
  bit enable_xml_gen = 0;

  /**
   * Determines in which format the file should write the transaction data.
   * The enum value svt_xml_writer::XML indicates XML format, 
   * svt_xml_writer::FSDB indicates FSDB format and 
   * svt_xml_writer::BOTH indicates both XML and FSDB formats.
   */
  svt_xml_writer::format_type_enum pa_format_type ;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables transaction level coverage.
    * <b>type:</b> Static 
    */
  `ifdef SVT_AMBA_DEFAULT_COV_ENABLE
  bit transaction_coverage_enable = 1;
  `else
  bit transaction_coverage_enable = 0;
  `endif

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_haddr
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_haddr_enable = 1;


  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hresp
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hresp_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_full_hresp_first_beat
    * <b>type:</b> Static 
    */
  bit trans_ahb_full_hresp_first_beat_enable =1 ;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_full_hresp_first_beat_ahb_lite
    * <b>type:</b> Static 
    */
  bit trans_ahb_full_hresp_first_beat_ahb_lite_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_beat_hresp_transistion_continue_on_error_ahb_full
    * <b>type:</b> Static 
    */
  bit trans_ahb_beat_hresp_transistion_continue_on_error_ahb_full_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_beat_hresp_transistion_continue_on_error_ahb_lite
    * <b>type:</b> Static 
    */
  bit trans_ahb_beat_hresp_transistion_continue_on_error_ahb_lite_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_beat_hresp_transistion_abort_on_error_ahb_full
    * <b>type:</b> Static 
    */
  bit trans_ahb_beat_hresp_transistion_abort_on_error_ahb_full_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_beat_hresp_transistion_abort_on_error_ahb_lite
    * <b>type:</b> Static 
    */
  bit trans_ahb_beat_hresp_transistion_abort_on_error_ahb_lite_enable =1 ;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_idle_to_nseq_hready_low
    * <b>type:</b> Static 
    */
  bit trans_ahb_idle_to_nseq_hready_low_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_htrans_cov_diff_xact_ahb_full
    * <b>type:</b> Static 
    */
  bit trans_ahb_htrans_cov_diff_xact_ahb_full_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_hresp_all_beat_ahb_lite
    * <b>type:</b> Static 
    */
  bit trans_ahb_hresp_all_beat_ahb_lite_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_hresp_all_beat_ahb_full
    * <b>type:</b> Static 
    */
  bit trans_ahb_hresp_all_beat_ahb_full_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hprot0
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot0_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hprot1
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot1_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hprot2
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot2_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hprot3
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot3_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group,
    * trans_cross_ahb_hburst_hprot3_ex
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot3_ex_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group,
    * trans_cross_ahb_hburst_hprot4_ex
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot4_ex_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group,
    * trans_cross_ahb_hburst_hprot5_ex
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot5_ex_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group,
    * trans_cross_ahb_hburst_hprot6_ex
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hprot6_ex_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hnonsec
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hnonsec_enable = 1; 
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_haddr_hsize
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_haddr_hsize_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hsize
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hsize_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hlock
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_hburst_hlock_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_page_boundary_size
    * <b>type:</b> Static 
    */
  bit trans_cross_ahb_page_boundary_size_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_size_addr_align
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_size_addr_align_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_burst_incr_number_of_beats
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_burst_incr_number_of_beats_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_burst_wrapped_addr_boundary
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_burst_wrapped_addr_boundary_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_num_busy_cycles 
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_num_busy_cycles_enable = 1;
  
  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_num_wait_cycles 
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_num_wait_cycles_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_hlock_hsize 
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_hburst_hlock_hsize_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_burst_with_busy 
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_burst_with_busy_enable = 1;  

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_hburst_num_wait_cycles 
    * <b>type:</b> Static 
    */  
  bit trans_cross_ahb_hburst_num_wait_cycles_enable = 1;  

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_cross_ahb_htrans_xact 
    * <b>type:</b> Static
    */
  bit trans_cross_ahb_htrans_xact_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_hmaster 
    * <b>type:</b> Static
    */  
  bit trans_ahb_hmaster_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_hready_in_when_hsel_high
    * <b>type:</b> Static
    */  
  bit trans_ahb_hready_in_when_hsel_high_enable =1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_htrans_transition_write_xact
    * <b>type:</b> Static
    */  
  bit trans_ahb_htrans_transition_write_xact_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_htrans_transition_write_xact_hready
    * <b>type:</b> Static
    */  
  bit trans_ahb_htrans_transition_write_xact_hready_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_htrans_transition_read_xact
    * <b>type:</b> Static
    */  
  bit trans_ahb_htrans_transition_read_xact_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_htrans_transition_read_xact_hready
    * <b>type:</b> Static
    */  
  bit trans_ahb_htrans_transition_read_xact_hready_enable = 1;

  /**
    * @groupname ahb_coverage_protocol_checks
    * Enables AHB transaction level coverage group trans_ahb_hburst_transition
    * <b>type:</b> Static
    */  
  bit trans_ahb_hburst_transition_enable = 1;
  
  //bit trans_meta_ahb_addr_ph_enable = 1;

  //bit trans_meta_ahb_data_ph_enable = 1;
  
  /** @cond PRIVATE */
  /**
    * @groupname ahb_performance_analysis 
    * The interval based on which performance parameters are monitored and
    * reported. The simulation time is divided into time intervals spcified by this
    * parameter and performance parameters are monitored and reported based on
    * these. Typically, this interval affects measurement of performance
    * parameters that require aggregation of values across several transactions
    * such as the average latency for a transaction to complete. The unit for
    * this parameter is the same as the simulation time unit.
    * When set to 0, the total simulation time is not divided into time intervals.
    * For example, consider that this parameter is set to 1000 and that the
    * simulation time unit is 1ns. Then, all performance metrics that require
    * aggregation will be measured separately for each 1000 ns. Also min and max
    * performance parameters will be reported separately for each time interval.
    * If this parameter is changed dynamically, the new value will take effect
    * only after the current time interval elapses.
    * <b>type:</b> Dynamic
    */
  real perf_recording_interval = 0;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum allowed duration for a write
    * transaction to complete. The duration is measured as the time when the
    * the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_max_write_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum duration for a write transaction to
    * complete. The duration is measured as the time when the the transaction
    * is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_min_write_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum expected average duration for a write
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is more than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_avg_max_write_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum expected average duration for a write
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is less than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_avg_min_write_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum allowed duration for a read
    * transaction to complete. The duration is measured as the time when the the
    * transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_max_read_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum duration for a read transaction to
    * complete. The duration is measured as the time when the the transaction is
    * started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_min_read_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum expected average duration for a read
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is more than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_avg_max_read_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum expected average duration for a read
    * transaction. The average is calculated over a time interval specified by
    * perf_recording_interval. A violation is reported if the computed average
    * duration is less than this parameter. The duration is measured as the time
    * when the the transaction is started to the time when transaction ends.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_avg_min_read_xact_latency = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum allowed throughput for read
    * transfers in a given time interval. The througput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_max_read_throughput = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum expected throughput for read
    * transfers in a given time interval. The througput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_min_read_throughput = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the maximum allowed throughput for write
    * transfers in a given time interval. The througput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_max_write_throughput = -1;

  /**
    * @groupname ahb_performance_analysis 
    * Performance constraint on the minimum expected throughput for write
    * transfers in a given time interval. The througput is measured as 
    * (number of bytes transferred in an interval)/(duration of interval).
    * The interval is specified in perf_recording_interval.
    * The unit for this is Bytes/Timescale Unit. For example, if a throughput
    * of 100 MB/s is to be configured and the timescale is 1ns/1ps, it translates
    * to (100 * 10^6) bytes per 10^9 ns and so this needs to be configured to 0.1.
    * A value of -1 indicates that no performance monitoring is done.
    * <b>type:</b> Dynamic 
    */
  real perf_min_write_throughput = -1;

  /**
    * @groupname ahb_performance_analysis
    * Indicates if periods of transaction inactivity (ie, periods when no
    * transaction is active) must be excluded from the calculation of
    * throughput.  The throughput is measured as (number of bytes transferred
    * in an interval)/(duration of interval). If this bit is set, inactive
    * periods will be deducted from the duration of the interval. For calculation 
    * of write throughput, the time periods of read transactions and idle cycles 
    * will be excluded. For calculation of read throughput, the time periods of
    * write transactions and idle cycles will be excluded. 
    */
  bit perf_exclude_inactive_periods_for_throughput = 0;

  /**
    * @groupname ahb_performance_analysis
    * Indicates how the transaction inactivity (ie, periods when no
    * transaction is active) must be estimated for the calculation of
    * throughput.  
    * Applicable only when svt_ahb_configuration::
    * perf_exclude_inactive_periods_for_throughput is set to 1. 
    * EXCLUDE_ALL: Excludes all the inactivity. This is the default value. 
    * EXCLUDE_BEGIN_END: Excludes the inactivity only from time 0 to start of first 
    * transaction, and from end of last transaction to end of simulation. 
    */    
  perf_inactivity_algorithm_type_enum perf_inactivity_algorithm_type = EXCLUDE_ALL;
  /** @endcond */

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C6NaxGMTezjFtLLDpbOP1IiXmEt9YO5QhmDQsvVmQSUH087Xnk21eiFOP1KK8buR
4Pvfqu5MJ2wqRZyERsQK94jIRAwzmSpLacScaxrRH1LYSkcXsORYZiPOube1BiBH
+OBOJeSO5WqIP1ZC2wsIKsTNrgHrEofpIpLdHC/IV+o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 728       )
KJC5kIiZwkGZuEXTvP+P8xS2bdrQAcaTExUhuZvIzoTKuGYSrTJOan74+ozvTTdM
2CvMSjEMZVpge2RufbwHW7Z+7L6A9ak0Yvggg1bLVdRdV6C117031qiiy4Esa8fh
h6w4GkZrezprZB6LvSFiFAWzO3qxdG2+8WJdFNES758eCfRpw+LiW7QLyXyWKIdU
vh+V8BrAgaSC35hAhOERHPzcz5/W5+goDmFwyTHIDXyKqU+jtvBNXF2PeAdyolz/
t0dP9FjhEb5E5TboHJKcRn0zlzGCCcmB5IUlLHQGDbZiVsCTmn/q4N5DfYYPX+Tk
aAZZo6P0/9RljGrXOhKNSywyukS4J4Zi4wO70Zbvm7XXKMMiWxfMmdlPEJ6IDPek
K4Qoikluw0FF40XuStMwr2U2NHGE16UDZROFGglrb4tnDPUFo3AZDBQfoVGEr7I7
WHIiVSyugD2nNUbsWfaziiV6LCq47yzYoCxJgP2qHR8L8cZLKQ8fJq6uSiI0nq/2
Xqk4/64F3tDP+LR4XT+Qgh3ONQIh2kenJxxnUC4eCsv/sY5t8n6Ol3+mMY2DLweZ
kVspo8//5c+20M+Yd6tUDUnJDzBEdHgBhSemLmYSJuj4nepdfbWbyaERA6meRIJ6
nU9oeZRdOXD3wYSOK6CG6gDIjU9Ijjsn4lFWBii5mRddD/rXYOfvCQHVIkDhW1c2
OZyJsdO1xESdrwxGqAOR/aIPmPUK3VS8eq1EQ6MTQ3A/lGeKpVJrl6s1lnHv2VM6
7JbKcZLood6p7Ukko8uhvyFQqRPsO2T08vYkw0lA62qFtX46TMyfa+xX4EkdsHyr
CT+QcXDB0EsE1hRz2d9BMAb3RNNMk2SYAFhWFEoqUv8tvPMBLeUYySN4ZNZCflb0
Fh87joH9T5Al/fTxJEbP8tZQOvOHj5Z3u7i963NWOPQBWr9FnTuK9xNsfy0r9wGF
rGpDAfbgYINf+8idkXTrMA==
`pragma protect end_protected  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_configuration)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_configuration");
`endif


 // ****************************************************************************
 //   SVT shorthand macros 
 // ****************************************************************************

  `svt_data_member_begin(svt_ahb_configuration)
    
  `ifdef SVT_VMM_TECHNOLOGY
    `svt_field_enum(generator_type_enum, generator_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(stop_after_n_scenarios, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(stop_after_n_insts, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
  `endif
    `svt_field_array_object(slave_addr_ranges       ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(dest_addr_mappers,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(source_addr_mappers,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_enum(ahb_interface_type_enum, ahb_interface_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(perf_inactivity_algorithm_type_enum, perf_inactivity_algorithm_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(port_id, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(amba_system_port_id, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(initialize_output_signals_at_start, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(is_active, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(silent_mode, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(signal_valid_during_reset_checks_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(enable_xml_gen, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(control_huser_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(extended_mem_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(secure_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(enable_ebt_for_incr, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(data_huser_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(end_incr_with_busy, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(wait_state_timeout, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(xact_timeout, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(split_state_timeout, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(idle_val_enum, data_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(busy_val_enum, data_busy_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(idle_val_enum, control_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(idle_val_enum, addr_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(invariant_mode_enum, invariant_mode, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(log_base_2_data_width, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(addr_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(data_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(control_huser_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(data_huser_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
`ifdef SVT_UVM_TECHNOLOGY
    `svt_field_int(use_tlm_generic_payload,`SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(use_pv_socket          , `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
`endif
    `svt_field_int(enable_tracing, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(enable_reporting, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(protocol_checks_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(protocol_checks_coverage_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(pass_check_cov, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(toggle_coverage_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(state_coverage_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(transaction_coverage_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hlock_hsize_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_burst_with_busy_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_num_wait_cycles_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_haddr_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hresp_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot0_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot1_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot2_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot3_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot3_ex_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot4_ex_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot5_ex_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hprot6_ex_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hnonsec_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_haddr_hsize_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hsize_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_hburst_hlock_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_page_boundary_size_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_size_addr_align_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_burst_incr_number_of_beats_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_burst_wrapped_addr_boundary_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_num_busy_cycles_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_num_wait_cycles_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_cross_ahb_htrans_xact_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_hmaster_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_hready_in_when_hsel_high_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_full_hresp_first_beat_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_full_hresp_first_beat_ahb_lite_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_beat_hresp_transistion_continue_on_error_ahb_full_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_beat_hresp_transistion_continue_on_error_ahb_lite_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_beat_hresp_transistion_abort_on_error_ahb_full_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_beat_hresp_transistion_abort_on_error_ahb_lite_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_idle_to_nseq_hready_low_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_htrans_cov_diff_xact_ahb_full_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_hresp_all_beat_ahb_lite_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_hresp_all_beat_ahb_full_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_htrans_transition_write_xact_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_htrans_transition_write_xact_hready_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_htrans_transition_read_xact_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_htrans_transition_read_xact_hready_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(trans_ahb_hburst_transition_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(perf_exclude_inactive_periods_for_throughput, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_real(perf_recording_interval,                           `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_max_write_xact_latency,                       `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_min_write_xact_latency,                       `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_avg_max_write_xact_latency,                   `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_avg_min_write_xact_latency,                   `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_max_read_xact_latency,                        `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_min_read_xact_latency,                        `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_avg_max_read_xact_latency,                    `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_avg_min_read_xact_latency,                    `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_max_read_throughput,                          `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_min_read_throughput,                          `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_max_write_throughput,                         `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_real(perf_min_write_throughput,                         `SVT_NOCOPY|`SVT_TIME|`SVT_ALL_ON)
    `svt_field_int(display_xact_phase_messages, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)


  `svt_data_member_end(svt_ahb_configuration)

/** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();
/** @endcond*/
 
 /**
   * Turns ON or OFF all of the "reasonable" randomize constraints for this
   * class.  Note that "valid_ranges" constraint is not disabled.  This method
   * returns -1 if it fails.    
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);


/** @cond PRIVATE */  
`ifndef SVT_VMM_TECHNOLOGY
 // ---------------------------------------------------------------------------
 /** Extend the copy routine to copy the virtual interface */
 extern virtual function void do_copy(`SVT_XVM(object) rhs);

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
    * Sets the address map of this slave component. This method can be called
    * multiple times to set multiple address ranges for a slave.
    * This method must be used only if svt_ahb_system_env and svt_ahb_system_configuration are not used
    * Typically used in an environment where only one slave VIP is instantiated.
    * @param start_addr The start address of this address range
    * @param end_addr The end address of this address range
    */
  extern function void set_addr_range(bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] end_addr);
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

`ifndef SVT_VMM_TECHNOLOGY 
  // ---------------------------------------------------------------------------
  /**
   * This method returns the mahbmum packer bytes value required by the AHB SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AHB SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif
/** @endcond*/

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_ahb_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------

/**
Utility method definition for the svt_ahb_configuration class

*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NLjdnbqTdpczgbQ5o6IAnRZDfrXNrnb5MYbvWw4VDWP2H0zchAJIs5Meqm9EgJ6K
UfGFhOyShWQCGMcGUNJcEq93Q8rp4FfxAjqz/gCa6uYA9hwWwn8itmK/qrZ3aCKs
mc1htvNqCOirTkJj17ulIpV+qutlaSUOaK817bQhdJI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1286      )
AxdNbj940tXxm7yQnVlvAQzYN0gClDi73nPPyUcnXk9w/y2VuRrbcn6TCU7QmNXj
Une8tBwm4+CTuC8SovvtNdipSft1haYZqHgauPszfQz/nwDgohVxej/tQ1wHbCvs
Sei2qrH0mzWh0zxsumS0VollaO3xcZ/jKO1KNjRabVr9DAdzXRqPFR2lT2j254J1
tPYBUb0QoDMU00aFiar0fS9K0rEHx2MDkknuH1DT3CWE8ZGWx5SnKdMzQhv0AsFG
R+EuhN/FwOQ5vGF+mRyiKI8VHsiE4PDPSe82elsL/pgeBKMJwkz95SUCLd8VfB6+
Mrr8im/mFNi7W8gHBMLvUnoTtChdE04JLf8vtXRcx2OpDKDrYdXkxa29KB4zHdVD
78GL6qsj77h2CUjwbgF5n5CWW5LRHKUOJdKJMqN32Zn9sMXXHwlK/ErnHB9UVrqq
7gKqrcEEakmgsngzST0NpN/RPks/dRjqAPhEGFxzyBLRESSfffvn21pUQcvZFApM
OqjSEDJflRBuIIhj2YUUT+nzU0g9GqCcm00KMkwYXkyiiDh+CBx5INvj5hObkpj9
koVnuvRg62UJueDd90q2d2eVflh1rH5FxVLvFyovhE7YdL2PQHa7F8MoPMEHjxoc
JuFhciudW2gPu4NOpQu3kVa4LyLlr0L82UlmkInFDWcCiwHodUO0DKHici6QEd3f
duH0/BNkGgpHmvMSbl3ewuzs7GZEipUqNk99gGcMxvI=
`pragma protect end_protected
//vcs_vip_protect


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nCSIRTmdPFDvrMj3PrYIriM1VbD260PPsa2xjPyzWosCfUg8sfIwiWlYKqeugH04
KpDtRjApwUV/TM+nayWJNqDo0R0hiOQ5wJFc1pzCBhb2cz51v+1N7MWXoEVs432S
rvJ9jA/AsyBdvwk5Kl9gLgcOzi06jNxzVf+OtkbJRpw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 54849     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
W255H9Lix7P25N1FBa6jRklPkMXNN98iptSmRPktFqIVweaXqeV/K2DEqsXYI2+B
ANuXZ053F6NhQ9O00lEOSJ7bB76xPwC9K0ArKrfJxMgqwYDAlvb177zscE7a9SFe
PBXOH7zty3Zll52yB13H8W/A7XgZBKVwcxyA4KsD0Ak=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 54932     )
uLBJ3Bp77x2RrEfBUgjt/j62y2uSp/r7qlUMGsp1uwIGZiiI1gJbOUctWiV6wgbC
Jx7HDb+Tdij3S0ITnOtJZSVxuQ7LkabApVKC5k9fpXB+FPz3+jt8t7O65xax7wL4
`pragma protect end_protected
