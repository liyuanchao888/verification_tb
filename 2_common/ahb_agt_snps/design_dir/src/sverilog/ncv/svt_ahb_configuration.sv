
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zysljQ41z82dLkt5IdRvt+DZ9GJ6Q8+f7M2qPHfBqkqLkB5MD3N8tpQ8R9kVnCKn
lpQvg2ZiZe0ZiDqzGM2MnUG56mA3pA6cCElskyEku3VIfUjFIdCyjtVY4UsHqF6O
j2VqkzljKJTlb5afdH7zK/t55jMah1ILlvokBL3u5JP7iLyZjB65+Q==
//pragma protect end_key_block
//pragma protect digest_block
7c+AKFD5B4LEq/DZ4ez/V9x6hss=
//pragma protect end_digest_block
//pragma protect data_block
w6GYuD7s1LLHaVz5KoVEpSuyAwxAY7iU7SDb14gFLZ1QZ4souikhQne/JR4S6WiP
QGYKLsHDE+NSFU910BfN3vCpnKTo7qeT3KalmJ7wFaNfGpNq8LF6IQ1rqnoonJXy
Ch1S/IcVE81TyNwmlGyeS1HvYcj7ZiWzcrrwr8CetqXqDiMgNKxNU79O21HKEt1i
Bo6pHe/sglk/q6Jlei08uInoL4pk8wjVfNlFt3bPG6zmVFXzGctqz+iSvUiR14cB
kVF0U/KwKbhI0KFG2EXCVRi9Gb1xR+aEDwuW/T2HuoGN0ZocbgAsFSeuvttkcpJc
q2S7xuuhHBRtv/o0k5NU2mDpe1UXSzaxcVBuUba8x50s2Y4cbFs/WGqhk4rz8A9i
+jvOBeyfVPt9AS543DoxpR6vtKb08zMUepgpRIQbQapsrm2FdiaJu1VFe2ezMwIr
btg2unEa1kzjiypicqzjJ1Q5192t1u0U8o5o3uN/iYcUVWBpUFyqt0lCcMuoub7u
Es6f+4OYtDl9A+R8lMMCGkRjBpPGQFi+wSzxq3ZF8HGKdb7F4iUboN7kwOeCl/9G
oCp2aznAiwblSYkKCHhs6Zt2tfuFqnUnxvhwETNpkyL+GTGsnUzUNPNB7h32tOM5
BTiDw95NkWkePG/77Q93ecze4N82KpaRMSlVytrKBANZltFH/cnP2V9rwRs7pCcv
AvqFbGxz1hjxnKjccZu8e2K8Ve5veRW8JPmRTDW1SxBNlvgEvF6sJX4q3EcshAmK
ICDoaWG3KbQxJpzXLDUgoBDs5d0WlFftzOnvAqJFth1YcU/IKZzfg38qYbIfyQT0
D9+Fx0Tsf4iwX+q1eMXnNDcI3Hj9aoDyCPE1dK5CAxRm/LSEqWlrT2bHDNAWE0b7
NkWBUHYmqApfcWWG77IoT8s39UaibZIxMa3/2N9g9jsbtlLhjHKVkyT1AwjJBNSr
XetWDq+q4TaS/rqjm1t7u8trpXT5XfECfEXfYIvt6CpaFVfBcudvOZpDuU6vkicf
5eWxQ41hpNsEx2pzf+solzn3IrmwEsx3ejtKlDMmkvbbvSCe4M40QZ02IIFoLIgu
AcWZvjJ4kY5d18M14qmXDn0Twq2mkMTRUs6Hg+s5DNa/28RU+f0fahtQu1StQxRn
v88XqQggc1CTjRJDTMtd3sSws8YpEh+UL4HeYgTaEJo=
//pragma protect end_data_block
//pragma protect digest_block
n8qwtfyw+lPOWO3pC9zmt5dtMng=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Iif1GHmiBT5b185KQdpc72Ck9PLvp+qc6gTvkbRGrnlW4Pp8CNWWGls7JFWbzCA3
ShCbA2RNGCuW7so3rL4DSE8kNkgV5DPh7XvEU/qzqfof+aDY72IyrH8FMi9x4Qyh
QXCe3dSUcaP51LbuG62UTvX0Kts/in/Yo3EKwIbcWWAX9OcR5WPZvA==
//pragma protect end_key_block
//pragma protect digest_block
KFlpHF00JclA+SOgzayZv1Rhiqc=
//pragma protect end_digest_block
//pragma protect data_block
g97yOHeaamXYqYYuUVas8vq1T5d9S1FkK6wSYuFzfLXMnv9DFqOksQZBJuW7xl5c
EfJKiDNNEFtF/pkIbO2sPPRz0UjEWJ7pUrs6/si3uQ5RFsdyD1WCHuctBhGIKndH
82s3OLChnurHnjw/k/ofZYJ1yfIvm35u0h7TXsAT476R1qtI6L2P1HvG8Ev8ofqo
1YTue2EitxeLoPi7TS079hett6BUdRJVVwIIkppo1B2aJTy8N9o/4zbtWulEQrq+
NHRETuVnMPWALWupR4E5mVtDD+LVTCDeW5L+x5zYtj3YWRfC1w3AdB8YrJH++v6+
Ttu9u2w60+5TbcQoGD6MQOKX/bCRtevmma0OSiOUN6PlS7SJ+5SvHSzXz5BJEPGW
geb6QNyPOqnDOL3cRS23Ax0fKRR0D3Ajq95k/6iChYx8SIwa16594zVe2nr3jUbi
heE/24CxPyOCY/BVQymtgQGWLvwH1tbW7cQrMsiRZseQoCou/cRiJ9eSxfsL3FWr
M5kbt8NDbQCslVeeHU6dQuuChQR9keqiE1SGsdq++Y6ePOWogc6WO4SJUi+tzuMC
U//zFNWsZMhMxpB/iotusstoy5ZyNkh0TMCY2bzkmEWYWNMy93lIfHqYPNlTWmgD
7myawgQI5XiP65pNOZqxfwiXQlUOCue4dcIRX4+feiDSzmRgkl3e7QX3b44rUt1+
PyxTLOPswPEIafHg1xBeEbzBzKsRpiairwcW9ZP6jH+qLjqFOAekVCETiO+IqiMq
+2A4KZLDynjFyDyhaV5EKUm0r7LJLppfjUde8T9jgjycACq5JsrpT21BsfbAy95U
fkIksg3bCnlm4xL/cnP4NcXaBVAkjZydX3kn/jZiSBGRseJq/ew0Zq0+5m72zer7
SAsnNDgILJSlWl8sh91V8x4NZXQ//W8RpbvMDKic3LdU1ElV9cXLz+d0rVTqWe4G
EN/+E0KLrmb/KWAw9A9OZA==
//pragma protect end_data_block
//pragma protect digest_block
vcFF76Fv3uxUhiQilrmMv1r+k4Q=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EbMJCFh2qqxH4dc3TQRR2xAHxqbSEFKKNQZRM5iJqc8ueIVa//0C7J23Mjha0Fn3
TCnkONkXR3LR9qD0pFVthU72pIs+pSxWzF5cBFwMCzCnhcqS3dsjQc2x1V0B9FWU
LzwGekZc7hBsvXIGvoSO8yoNYDLApDshuuXZx63XkoVZZLv+nm0svw==
//pragma protect end_key_block
//pragma protect digest_block
pRrIH72k+YU4sRL+oJjdsCXvlS8=
//pragma protect end_digest_block
//pragma protect data_block
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
K3xtB8CEIDnyzSS7jTnw1w==
//pragma protect end_data_block
//pragma protect digest_block
BwoyfIV6Q7l9ll5tYasLZH3jT9w=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
