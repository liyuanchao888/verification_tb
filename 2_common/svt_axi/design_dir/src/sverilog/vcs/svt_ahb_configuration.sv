
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
`protected
#E>YMWF7(a4UFdgAJA2E>0(C5CFMFdc1-+fJgeOAF5@#T3D:4fZW2(,;H+EDUHLC
A-#HdKL96CGg/:\)?^,RSF083IG,>D]I\&gQI-D571:T2SBD/dFV1ZE>/KaFK;[A
+Qe,J10BRA&b\;#6)K;F#G&CX<05=LY/E7_2).;Z/FgaYN]R_,A^^MLIU6CA=YZ5
UYN7/_=WYT=@RY->d7a4[]CH]O60D/fbD21YDSGT:D@@b4QGNId72-NH[gKg#dd/
gCU4JdV(Z/.8,E6A+Sd:EQ9X)-/Kc7Y>N30\ceQW(>e/3gI0N/8SeZ@JQ975BBa>
Y,2(?>9XP,XJEEWHg^f)N:O5IM&)Yf\R,X/3SPd<=W<e9Q(?9-#caZ@4GN[6B2&M
.>?Te2&L6EAU\^1O>1/Ue,@dM6B=3,HB5E3QF+#(X4/+^ZE&Z-&2>,1.^UAd,3UM
1U,OTEF,c[P@gbV:-<Z5K&da5PQ^>P?OCK0;LD\D/WNP-3)f=]<^FXE?/X(OC6g&
]#A2Y^.)G;9<PCZQL-8GG1K:?9/6.44<8c<Je]>.BI.7(//_0U+,)-\K(Z[_GWI-
08[FL@P&BZS8@BSPeJW77RNA]81X&5GFW1MdU@c5DW+bT(YGABd(R&P#0MeU&I\7
II2+N8UE93OH-Q>ZAKQQYgPd0&I#5\7K6@dBV/F(W)7+LT)8[1TKM/<\=QQ.1RPC
&Fc9/PDeN:@?K+1W5::JRbTEeGA^SRdM#4b&f@7@;7#Fc;B_MaZ\f5I1+T/]2_5,
112aT8TaQ2gCZN[+82/21gH>D<0:CAVHC0W?ZdBW.JQcB&?L[U<NO#(P<TSO;1A)
Q5>bLLdM@\O#GC_cbS[>F;f7RM8]DP0@cIFL3UZGCXP#&[RUVI1F3-A-\/SfTENc
R]>(K34;1Ya5FWLW#,^@eZZ#CTR/.aB(>$
`endprotected
  

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

`protected
#6^?JLK>2fGZ62aB]J/6GBU5IUS>C(<A9;?^[U^A81M&N>G:@O)g-)(10+J7]7dc
f(@A[f<D(<Yd>4/W;e1gKCa<a]GNW_L9P+@66g,)_M.CAd;QFaUXGY[LSaJ)MS3]
eQ-dXG)43.XGJe[S\Z#(eQL&Sd@(A08)Y?OZH/V3Va([PV[&OA4@Z]HY(f_59GC)
I=bHU4TMD1fcS1:NDRKBU^cUZ@1+_]F6/Bd7(5G^AaPFB2;__I:&-FcH;M<FK;d)
K>OA4GC,I9@.DK>FWG36_baR[8cHT3R^4K)ZP1-fb5DXM5CgaF9PcWb.AF4:1W5&
c(f1B]T6fCad0NAg[]g:+aBaPIP#:&/V_FY/M(H&N1VDaF2:?MfW(\D\QRZCfY36
Q2dYW=)2<Q.]ZF?Wg<F&\.L>1XW?QUW1&VA?Ga>,6>da?eH[)OKW^f^[UKYeGeZ>
<M1GSF5B0(fQe5:K-ACg-F6GdEIQ^;2-?;6&f).\aXH2[YBG9WaSBF\QT7CgSC&S
Fb=ODGE[)F=/W(2c8159(RR^P,dZ.dK4Va++JQKC)Z\=J2))NK&NL9A(<)IXE1SA
X\N/97(EBJeO+6D8L._c8<R^4$
`endprotected

//vcs_vip_protect


`protected
W9ABS6/1KeC7B)P,7CY[FZZ&b+QaI:;a@B<C\OL?dJTe2,)1X#fb6(d2K:?bK.0U
;OX8[/,bb_-.-4I\G+M_g&S@LO<7HL>fK0<Y#T8]HMbZ1T:#FF_NROS<4d\6&1B,
HXV<UN\_R[#YG,Y3MU<[D)/dKN9:/3HcED&X=,V>;Od1c]&H]6G_^;eLe@_6:O,N
E2B,^dO(EKS)95/@\J@8^VT++6VFTEeK.PO.3BD,IIFGS>c;@RW4WZB608_fU6P-
6ST,)bP>KU:.;U6<_HUc>J/dDg?1#1,1[::Ab#-]2@9,_7(WL#AOX?G4]#K>K+,^
\D@KWH\D3)LM11W=1CM#87<^/1[TR2c_KQNAPU8Z^Ma9a.8LM^59T=BC5/[F_&+a
GB=E5/1[H&7F.Wa3X4X,bL8#(+<U_HC;O1WK,/0MH9)fX#30#Y<&9VLUWe_L@ePC
g4;EA:YIHAAE\\FM263K+<([OF4NbQ+>&+#TggW-(464<HA[dL(=XfdT4+7DA2H^
I/23A@0?-BPS;D/Z7M.eOED\Y2[DQf5);HU4TXDW;5Pbd&NQGXO>#0-4<]eBIUB4
)1,b[3,Q.b?)3agb_^PS1_g;-,VBg\N44\Vc1=^+,#;CZ,;1TM^(E>4]\-b4aH5G
NUEY0E5J_E+;@ge5a>Gg59\a+.N^b2.[CWW/C#_3(&bTUM[UD:O\_8T6=T>=0c.?
;0[#+=+XJ,/2\?7#DOD)-FE[,H-BbOcEc(QD?gE4M27S/XMH7^X(V+@H(aI6SBDP
Z^L4b(>F\+^4=9V3<Q#VS3.X7M^#cNIgXg0R4OT+^-W,QfaA>&a^4[;94_AR@G,,
A_>JSEW6>F/.QD@_[2H#OSeQL_@[(G@>)4e2_ea)->^OIY1>B_DD,NT&GaWRQ.1N
S\?#DgS)B^2G]P+814V4&H47)aPZUaCK].VP-3Y;WO-#OD05#e>2QEV.FcR\eV96
U+^Y>TANHEZPS/K9+bXSP_cgPXF3HR@JgH=ZRIfQO^JXP95UHC6>T@LcS1FXF[@:
Kf<I+Gd3\;+8VLdXQ7)2IOU1KM&,2AZOO@#D)WE6H\H_OJQ;&HZ(X))bI-0-b3>N
BR,<@dUU9W+IR7TWd>4G9_2I>f@1HePVf\JB]KXD09M8LD,eI5AR17R/Y]5?OITL
K^CRLe1PAOg<:X[C_AH&MR.Z4AZ/9F_dMK=,&gG=S>9&CbY.WWN3^9:QB&W:DB^Z
fa=@BaS9VZ@gTg3VHJ6T23>6P[5M@R,8S/?P90H-@;ePgVGP\GfIMHE<XaFWfPZc
aMX/6+\R^;(^JK3G1W70/@N4a48V3)\>@](&<A,BBYL@g_\&-W88=gH4&Ge.>H<W
RL)Eg]f/<WOW?.&^M#Nd?4fKZ0FU/fU,N#dfbS@-+<B?XBQe3CL^>cTC:Y3#_QBE
JZ@Cf-4CM8[?4cE//I3,CE)\W=E@Q59-39+@Pg\?8RGR3?[G/Y:_?AHR5Wd.H;B_
FdRM=I_EARaN<);_1T>Sb__Db)DaRGP_ES-+O#0CBeVMZ\SYL7Mg\<gT+IegU-C&
H[FeWF[Z)De-DDbEcIC848P97a:RECWV>I,g;,R7UFHTH9c34))#F)4I&T8U<b93
DK8;&755ILE/N^Rc.B)65cfJg4U]^MS/Baa5RfCT66Xc/2a1YXI0(8/OG7>?cU#d
1]Lcf61GfO]CaMdVg9NUQ+_;END(Q#H;Ic#dBVC&Z7CBe9DF3(D7KU_=-O5Zf^J;
D\O.NaVAUff[bVTLZ=K6OQ0MbSB2M1NN4g&AfF95[[f/:G.YZ5C40,2LLF4LSWT)
PP:R&fOMSD,1<T;SQWgVS&;,^J5Re_G[4K9Z]22Z\-L8dB5PQACS)5JG972d/Ad+
]4^@PP9R>T,b1W#I2)_##9/c[KbB8@&UKQ_b8?T7PHaJa+H3/^E2Q=<aHc:9O_)?
?+/P0NS>K&e/)c.,Y:69[XVJ^\^YdMA<;c:@YLH#?4T3\f&/]/B+#-Y;Y;Y6[)d3
P9\LA9[DU2A/f;WK<+@VV^S#<+2-.,TB]QV+&[7Q7DY]/_RHVg4PWD5;:;@EV/O0
#G)3_b>/W7]AY-d&F0cbXNL;+bJ#^SEfG>8:d74YK8AX(]<.d=3gbf:OX^He46;@
b&R#=PRO&M);eA;T<<6R([a_7[BZaI^/EGVZ+H^?>[f)MHXfad>TV+@_7J[^d=:<
VF[HBB5fPHL5<VXZ,5DV5(g#RJS;F:M/^DR#_SSd?P?\Lc&?:JFX_??95=CLb9fI
YQd?:8e<9&K@98V_J[XYET3&fFK/fe6N1^OC?)U.OPMU[[V5HA]R+(:<A\3:d.[(
,a9Q<SUS5:_VVO<UXFg[4U6)HL]D:^aY=X\O8F/\VY10MSWKG;:[OQ,5c6NeN?(c
D9bPE7AOcRc6EXBAUT8fKd-GcbHdLYdC0c_TJ&=a^Q22B&7EgNB&fbL&XM<a7Ic+
6KOGK;GZ46>T288aYS2@R&N+gFM;[6XBZ9X^F+L?9Y:AO9RV@9bMe&OFZDP^1-Z.
Q>WBZcLMR^+c&5P@+H<?U4I9eLcc0T_W)c^E@VH-3-Vff+0G_C1M/Z(IJ,1c0cS3
A]aOf787E[](M2N1^</Z[gI.79RMa(CWLg(+C5>,.W7ERPXR&/(UM/J<0e-N1+FF
\L31FQ\B?2I3M]=U]AWAY:D<J;I#?J6^RI[2-eG?<<GFV+]@=?0Z,bIX6g2/C@S8
,9#=dBKT0NE(2:SdAdcD;KL1g_5ML9KaEW]W,-@;@PNbEWZD4(LV;IJVQUU>e<J,
@e^R_36D=+[3F1:]O?TA>B6^M[Td);-P),P-Z^@I#/)(96/-55f0-3A,:Z)Y.Tcg
@/c&V@;[.b5a46;T7=XNRZCP#:G65S;=9/B]W<=XMWaV&&:Ce=B4IODYD0S_E\.E
N8V;\;59B@00YJg&35G5L(AX_fRD&3F4I80;^2/5E9L\SKXMe5^K:5#<_OV=8c2d
&,@?7/Gc>d)&:f2U_^YK1B[;QEVTTC+MA):0Q<B2bMJU[#_:(UE18TK7dKIQX3(Y
(SPJ(H)8FISS_JD3d)A7VB66X3_;=g4+^[_QF^)AFPC[b_G2R:(EAY]gABJO)&A9
+;GB_/Cc^b2U-T.J^@S/VcH/gSEWR[0R^=bACcf_3^eb+-GM8LGf4>WGSXQ#cbH9
d&Ib)]QSIAW9H1Q6FaO.fa,]B6^&#^4g_HEN&WH+IA-gAEEB[bcMFZ@,)+edE9V&
4@L<M=75[PN4^:ITE4])D7b34XR8@+I)IM#]/V&[ZU46^U@aO0(;e0N_V2_;\?R?
\-G/8#CH3Ge)d]=M[T)Wc@Fc0Y8dg-LGUNDOaZA_0(1f,U4QFNX(S\.X+@563O/a
T0(Z:;aUYP._VdP=eg[dV3WSM&236W:D@N26aQ0P59?T)1K7;G=H3/+7(H#-Na2N
;W8L=M?T#_Q;PNfa/:-/WeWLZYJZR>#8<?QOVc+N4+6WF&L^<4Ue];?^,2@[UH.+
X[M?d3C5#Pb_MOB<5(<6b)Q-M3_-XV7cG[OObCc>[E>85&I_T-:OeA(38bO11M2:
BKS+XU2>H&,0464N;4E,+KCM-&1G<<]ENd0d<RE8g#J(><H]3K7:F0T[14(1Z6O<
GeTFaMH4D..W/RVLNDH]\9+[eYP8[SS5K<[AS8gIFHZK<[__W;EYcK,FX3\fU1+9
adRTI#J;<WU4_c63N:7)1E5KY4c^8[,DQCOIKBK38fZQN[=O&04Ce5dcLBgPLS/F
\Rc=ffb^>>:cLG2/95;3N6=L@_G\B[YK7&Hg1WcfeK(S(V13Y3@cTJ7:=W4ER:W3
\Y4&&G>)a&,QZQ0JYHU>1QHQCXYYKe-^eLVBJYD]GRSF9F&f.\Tbc-V(Lecb_=-(
Z8]UK,_99:9e.#FTCVE4g[dW6-1H-;d-4=S[P3-R^(PZ8LP#UNE:E.#HE@>g6cE2
6IKN8Tdd,JccG7,]6a]gb^RMM8,7=5FS7-@NA]9;ZRW<a<@TdV&9R?:PXX;@]5Y3
0FH2b>Y#)g>S]##.#d9&/8A;fLXVZ&EW\FKY0^c+49bE^f3\/L7[:7\C.#6XSbe+
Jg2aVbVP0N:N(cWJ#<WY16bX^]=gGCKR>KZc.&Q<:]d1L_?<gX=H+R1K:DO;N([A
8X\5M)__NV/F\G;:/5I\^QgZ=&eaE@QXYcd&LaKgFR[IS\+BX=48T?BT\:,D]XH3
QU\@/9RP<TT-B)T34GA6#LMUg4.6O6_,)&61,WVW.Mg1NQ+R?_P2[]4N#-MQM1<?
^_DDLK[RfC;]eKBJI]4^^7ffNe8D,cO1b@0Q+TP^[_9Fe+B5+gYKe9SZg(&799d:
G]=FJH.fbfX^EQ2d5T=Df;E@f^(O5FLdU7cP4:Zfe(TLQ6S,H;V6O(2^]a:1(WZ.
cMW=X6c,\Iaa5-KG/6dB?=4@;>\SZR/=HS3<CN+I^UNW(/fPdIU)?f7Bf0Bf4?PI
1E^(1L9V#1O>VJ<K[aA6P(4?1M8BSLA?W(K&T6,g-ULFV8G4fLOA(:D>77W17Y1/
LV6E4KM7C/Zb_.?<&?+1:P.bg8=S]JZ-]68T#d=B0MZO3Q&LU,&L_Xe5egK7.6@B
F1_GU,C\+<NSH-14^2=HIF0GNNK-L;&+M).<;D>-,FMD/2>(+=Z;9#X5^\LUg5XP
TAU)QEMM3-E_A]cL\+Af2a0Fd:\]P8@daD)AYXG6+X/Q3Y35WZ?Wd[]3<X3<0W=&
G.a;:V/T[D.#RAbNS;;;I9/IT8Vf.YV),3GN92-YQ3#DYe76+?_>/)CJ^,aeE2-9
74GB:ZN9E<9([(A(]\M9T+I&,(a&P@3eaX6]]O\Q06aeDf3/@)529HaWb.(S:QUB
GWbCFH/#gKT.E2F,A.9>X5F[8WfKV)PdDA#YZfHG+?#LF86O^CVGQ5E?#gf38-1X
6]OP:I)D>#PM)8LP-;BEWDOd7:1d?G+bA\6US@b.<068UP/[CTOKGd/]>d^YT4Lg
_9VH>NG7:O(<##e<(f3>8Sf_+IP4U2BF;0UA[c3X>M):fFfI#(cB#.WDB=V0D=7F
_G@KGbW=3\4a)c1(ZA10OPYR)DBb-_a0d1WC@XQ?7OTe16R&a1FYDD,/(N>P:Lg&
NcK_ff\(a];M3?N@[fQK@/F^>da87)IMfH0MG(V\LQBfRFS6gd0M66.C.T+7#J\+
().<,0Hb^JPa1CdfbUY8W/<g+/:@6JWCCNS/:>,>7cBFTW14cDQMAF)#T9c.;V\1
K9@b>0H-NE8<@H\e3cg<QG3?We)=_b;Nbf;O[T/@?2B5Ifa=6DBM_<2P-Ob#14e.
#@A,aZI9GW-<A0+gK#Gb2:24:XXX2>EK355@N7UST7VZ+HQ1SKE5-)2,(O/BfVe1
.[@FWf@0dX=C4:b9;E7A,1S>R,0DUGdd0:KNXC4e\.S@,;WH6D+JM0+G@PI0RTL&
D0>.b.VfV:?6QX]AX7U@J;[c>a.?&<59Zd:g^UC.L>XB<MI(^/HT;D0(3TGBd^?E
Z&f54FNGCgGBgDSQU0_#29_5@6A5^TK)DA9K[;_S9Ga)J5#H>0R@UCR2#cMK0,9@
GVI:^LC\C)4)eA3J+1Y#[Ua(F\Ac_(:OAVU,/39D#0JG^M1_OVa[,X:bT40Z+UZ,
g(.c<b2S7TGXfOg07D3>^])LfJ+I6^H=:FXa7dK<3TY-/B1g^eSE7EUQ/9&(&_fL
IA541&FE5d:CXa;VWO+9FDAR@RXDSW.KA1;87(&+^.+B5g1O0BJ3,aOV9,KD6e]9
/&QF_>YI2>B#eb11#+ZH6MIQ6-b7U/b^W?d/f;5\UQ8Mc;12>BP;#<\CV691I866
P&.R+@?NX419G<R;MI2E2\bJ:[@DV#8aDYGN^g@IL\#R:8/WX_D4[&6Wcg^]f8S#
-BJZ^XF?8&3Y:)<T\6RC+bBH2eQ4ZgLg8:gE.cAO#6Q9HFV/BQf9COVdP7/X3C7e
ZI1Q^/MUMP+Xf1?Z+PbPc]L-.X)7gDLDeD2^1cIH8+,K]>:g(EH;G36B5NK2/9;1
_e.@(dbNU./>1\&;1UP?[N8(:;_07ITg&XE:^.8JeWJNcQB=DB_dZI?B^P^1,[EO
>EKG(f@^_@V59TGdEQ@>^;8?-.1_\aS?[=aF844aVbFc4AV^>Abgd,gVN9aIggIF
7N)5H9V.Ze/HVUAH42g2^Y)I^;L=fQLE[G]&25g]e3T0.D>2cQC4J1J9WW7Ef_f<
1<-Y6^S\0&5U-<?ZMFTH^6.TJ^30K=>T,.KH+AWG^cBI_RAG/^]K\(d0.@[Rb+YO
cL5^[O.eO0ZM[W:2X/)K>91g55MB<#OR<CfXfW>F0,HeP4d[1_P?45QCeW\9IV[C
&MU<4&WPg;==)G##]/#5dQMSRV6<,)5@e/6\CDDbQ&3Of#XK3aE><<IdRTX\Q3NI
T(NM[N_1Ba7gg-D7X2Z?U:H+8a#b@NF]F73C:-=#3R,9Ud#[]deK)SG02aJ\LdTM
gc@Dc5/4C(6/_UFWg\0WM#ReM@;K.:^ZUgU02;^YAd?:I+gHY;gDP>BTfZ(F1>C4
K&#PMD261;RfHK+@MZKU;,(-D6@#,aO1GZNE[]7L;GQ<;3@9._Q[XK4U<c.)G8DV
#a2\^BRC&da+C#H+K^0(J#<))Ldfe<79ZN@IXa(Z]W1/ZG812/JV)U]cgWbKYgB^
e:-0LKaGZY_7,ZT\(<VY#@B];Q;2^G\#1bec+REFT8C\MQ@W77cc@W=-4g,LA/8,
\dad_e<:Rf+=R=4@;Od/I.\F#CN]6e-a7&c,fR9AaSZ1>SN)LKNSR[SP^4&VRE[0
ECVgV94V=A&]@45\2Wf6FR\T0BEUFDMNeX,I50HF3S.CaFLJJ;H1K-O0JLNU)UEg
#4dTBEJb]I8:2;._GC4<B9:D[_XUb01BK3[Q83b(I:@+DO/MOKgb9+9_U8SQX(F_
4<3Fea=(7Y^HX69>:9^Z.\,6.XE5WZ@&447./b9cVG>eFWNQ7YJ<4?Lc,9I);(#O
B2L]\:NNRH)=JNU[ME\bCK:=X=ZP,M]T8K&TAPc3(1d+ZT5SOZK3R+9&D^<3+?&g
HIPS0273&:KP9TT3<GW6?[e0A3SQ+Mc>bR2]K1<7YK8(<=/RL#HJ<JX4G_?(gA[]
-,\0^S[C64/QHObIAF5<M(6CN3AKOJ^ZF5>Z1b,W#3Rd7RR)7#B1S97O#>AK5,GP
)/D\Tc2+_5A.34G@<A&c9\(11=/W#B+6)NUfA/gHf@:+U?N.[+cE9VB4D=c8H.JQ
<(<=_P-#73=J=eNTgHU41&Q:<]GOMG0ea2HHMe@3/N.+K+8F:_GR)bUc=(9B-U6d
X?#-a58:32Z#2g4Y+PN#(\LDdD2V2g3EBPO#-7_Z6:5,ca>fa(5GL:ZGVg@&+Q=O
@^ccN8aA&.LFZYEQ/ZHaK/-73=CVO.f;<8-J)7e?g5T667=eWQ>GZ3?IHdYIQPaW
JO>4<VAS7\H6DH/8eQAf@JM-@YS^c#\fEE\Jb?J-4KL,Y.WAR1_]3LCVb\DEW;.V
6TYI&(d17_@EaRCU/T+J\,-#.W:GXM>XSW67G/]EWHK56FcP)EDf@K(.cgL_-6ME
_QV]OD:fe0=<[P;T03_<&DAB([EE#I75>W6F5OVM/<S(d@YH[<,;aJgf4[2VM9DF
^:J7J]Xd@-J:CXKL&A,M/>]JKW/Df39GS+O^g):,P&[VS+,cEIc?Ge\>04df1d[:
7VQ<3D#D)&SB8,Y<6<XNT68H+>GX^_VOV8J&cR99_KC@g05-?)aKT^^0M^DdH&b)
#A2/7PP[Z#5b?]/XW,SOT0:]9]ZK8A5AO=J?eeF^?9PKYF>F-D53NW]6Aa:/9/JM
RTC]PC0H:^[1VF35f?I:cI+-.?>+K>L(\)@Lf5A(,;E=dRS5a>;P9&U_UeJU,<c,
S[aP&B_VYK:cJ.7PW\&..5EZ#&11IeY]e39LT>&dCZ4&0,J543>0<D>4YG+,GXTM
EF+ZM4DZ=OASJA@RZbI0fAU-<+c1(/N)/@97HLTX+)E]U2^BRVAW+J4Q,6P<T76<
PJ1cP8=3^<V-CcUJ@_Eg<D4YZW&.WBa)XIF,>(G=#Yg+YVFfCX(-22;,BJR+eN]/
G04NeU10C:TF_YF?cVRUU7\IKAZGV8Ec/Q;7H[a#F,/5ZZ0MU^V3TPEa^C-TTNCQ
H^1C&Egf:#H\0/.1Q9#9;D+YM\?2aDZe=(2>K#@=&Ge>;V051Bb.BS=_gTUf31F^
/bXCD.N=^1IQ1K/3\<3)Q=0)e)5I^@,8O7X[W3##)d_&FS49Zg-FeUXdS?X\3_8A
&ITa4abPB?Ede(YZZIIH^YO[\&cgb/7c@1&df0C>#Vg:ZZI1P\H\X3WefGeP:O3>
Q<Y8fW]3EU-SJE)f3VJO_HN4:^N>Q=^/C<:GTX;D4^4e_],S2Qd<JG-Bca/B[>Ae
]BFK6U?C^:A<;cO7cCHS+OFBP:14_(#Yed+c\=Oa.g>(Y5UcNMO[&.A@=R-++g\a
I>EXNHc_d0K+<\acf:NR>e=Q>3-;_O&=fd/Dg^@2@Q2ePE6R,\6ZR;0?TKT8(\&-
8c&23]L4:Gc,]eVK=D25Qb#=Zd1BE.FZLg\/H>d(0LUb+.(U?5RQFF&bQSDUGc6C
.:g98M[FDgcH8S)PRg_J/0:eHZc-26H^OcYF7Z0Ld@ZI/#YXVD6X][T,@Q:=0E>/
2Dc=U+VUF#OJX_UA8S0a1V_T:02>gSC:1X,Va76H2bRC0JWT&I4a?QX=c[K0GDHG
J(8LNBc=(Zd+/@cHPf1WDcRJ5/>ZI9KX/Q\Rd-JNI@5ae8]1E<+/MV<67<O3MCS0
8<(f<\^B65d2LGZg\IG]7.:K.E_.I#RV)F^3Z-<(A8)CW:5)&K(0BD3Y9b_3@53f
MYOgA&X4PS8&;RbaEHGbK+0N#.KP:MY.@E3)X]XHYDQAFJ&Bg2G+Q/V,[/NQD33R
D+F^c<e.];S3@b7Q0#.L3\AW/fSL\T:a-+6c0d/VL1202U[[T9GdN7+Z6:Q-6[P:
-2AN4gB^,9b;6f2EVe4QWAaHaJ@<[EC/c@=6><dD?,aADBBE4U6FdSe?M-HKBXcZ
^RB9J&cE#D8W658L2,5b(>5<Xe;/Md.+W5MCGZ-O\D+50?V&5+E_]TaU]UA#FPeX
(]FUU5dYB7A(4OfF+>IKZZc;A4-.7OGeMN.e6gM.;5Mf^8(@WHg=O+]GE1O8WfIB
_c7Y7D\dM\d.+2b6IXY14ec);?LE:,<Q0RR04(<QHK_b&,JDX^B6G^;KVS7HV?X9
L#Y,0PO&Uf-Se\JH(#Kd=;N;>d]b_Q0gM<E6W8P6Z#T+7W2Q#798DS<A;]GN7X.N
PUbf=FW7F0<[LSb(5^&Uc0Z5;/_.O.bA19_D).RW.76A;Y57@d.AP>]Z[bOK]5f?
XQTBaNJD]?0(J)2I\4e7c2-?[D6?3eKZ_\(Y>VCBY[NEZ,,Nd@P/=>?/6>5RX4c3
W/@AeT:DFG3EVd@+YIVGH7_K6;e[E@],/bLF\WOOT)C[^2@d\0(-#;]QC=1QONE6
U-(:+:-U9SC4b([Q\@N(=LSXg./BOR(T2)5b#-8bafaH+UMAOQ92WJ.BL6@@S]d1
+b1@&A/Y9?/RPB[<5.7J@a444X:]-3&L,5T[gfXFKS=59W(/#Vd3\D@.E#-TKAcW
A=[(7/T&D,6_BD=KON><275UY76>>;=M,5F((A4K@<^V38AKRGEKX44#:)#BEV2=
:>g3^,Sa)&K\NU]E>45SdJOQFYb5PKfc<:3FXU,=AVT8I:WL<g[\HaW4:fb&V484
S7(2KU=^:HH.CU-DRL:g4\0H>,GS77;;#<414^_C<713,aS;ADWXS_Gc5\\bc9R.
c,A^,E0]J5(UX9ZRX,V-)Y8cc36QLeN89?;bZ;3.J.0MSG=fL?/=MR+<4\b6f5HP
<ZVT9()A\I>H.XWKCBUQN^e/MGU]NZ0?[/(?bEHI1e6W,V=R>76H.UHYg3OBX:>V
<VW#_,R/7WL@3E?e?X9SMYW:.RZd)J[BDM?8Ba,,gaC/S_PdL;4^^KaQ7ZMMfcKC
&B@ZD)@#68=^R627-G>ZaE9gbBW0#Y)W-:0H,1GB;fE=N:0b+<P.eK+UI&bcH\RX
2KaLR\U4:R.#.S^ACC(1JeNgFQ2.>6#QZU6>U:Q@)NgUGWX:USDF;I.aAP)=&Qb7
aU5LPJ8(NW6J\V4f&93NYS(=37=TD\\XNL&^_MJBG@#]1\P+AD;Oa7M5S0NMB<9+
01510+?Id9R3Yf1\<(g.:NBa&68ID4Hf_UP=NE,5MFF[GU/^M;0?&G./4<O54HYC
<2RA^GLRNCX\YTEVML_(e#M.WPLRf[?]EDCK\S;Wd@@(^._I1U^]>>N.C.>d_cL5
8C0K?1c<3/0g?7W[@?3aY[JA/a6QA67BE414g9,^+7g8Ng7AR_K>C?RPR/Z4e(ZX
2dMIQ+LZ@U=TT8f3EfO@GV7B)DC==]e6Y6BITf;<>VFI5=&(0<:=#?<SWK.4-#&X
O=g7b3aG)S1PQ^DD/YGC6R7,2RX.L9I-aN6e_I))(X<Na5?aEL-GC5&>S_FYJSE\
Y;LQ8,.VeV48=WYK/.=LG@)Q9_W1I(^,M)A@<WD/E@3I\(;Q2O)L=f8)dS(4I5^<
_]&MUK66/0@9UBIR9##Y,<gO2=c>HMT8YgX52Kb./eH]/@8:]>96=I.X5FF>,eC@
cNbE))Ef9@=:1Q]ZL6A2Z@+PAR+)d?7;P42S1Y4Y@g[I:7_=F0\6=(G_@6B.?-b3
1/^R3Ac@1TGBJQ[S>O^P)HK(12V7(7H[f_\S4ITEOc8G5O5MO-eZgd<+:_eND5PV
=?LdI^:A)ZLEV[:]M.ZJ95B]9^:]19,+aLOXC-MWOd#<D)ZPg@Ed41d;.(M@.aPV
_8X35G1RSG:aJLAP:ICI6[aP3KfX)#[dY7+@-?))gDeI-W.4K18;OV^Kg)FT_3D)
P\Xe5G?6O3(\G^:X)8fB-a<815^)=^-WJfUDN9bW[ZfM]:7N\9)Ndc4/\.=DACT/
:OWd<^Vb>=CF7K0@7#26<]OA10Z9#=[GYS&#J?#C#H0aF=5<MDJg4^HP9f@8;TH9
H?L^E#X_4Rf&53gcdb&&C?Ha59Ga:8+JQ6EP6\&5@=<P4ZTcR8a6X,ELF<BMOeA3
V/J^c?;ANU=:4N#787B(N?-?^_JZA/^M:,RE9f<gN5;(Y;-[cR/b36OX;W_I6VUa
N-4/aU:IMLU0dK#\FUI,<^b/O3=ZUD[_Y^)#4--Ce;JaJ507&YZcTZ)[2LO9Eb&T
ZGA.LST-(7R83HA[&\8UZ3P^NDbQ1HPBB3DEWFI5-@CH/\RDYJfKf1#L0aV#7<cX
3002C&GT=EF(]V+.+(IDKH>,:f#@GXf:;Y,9)QK53)aRRcY_&B\@0dR.H<;G__G)
b@?0#JP8?W_V;=B/Xg(OeZGcT2aR@R[BS_@FQ9O,6PM+UcU0&OY8L9DcG^GE2(--
<)Y\-/bMQ1^2^B1I7H#)3ZDD]7J[F1bMTRS30:G(]R?cO@W,eY&G<aAE(\C:\X.>
()Mf/OV.6VFc=BGSgOQT]F>B>9@Zd9OT_YL2KX:Q:1OH(YP-AMdPDG97<OM=I;^7
9/\7.a8Q:eC9H9@77-bEXcE#]QDJ<ISIbfbZB1gdO]UR)LB65/NG++B.+)BAZP^P
_8Q=ECVS^B:=c4MbPf>+?g6KaeT>_4e#Y@bbCbUa)NQI;LR&>A4)A&Q5@]De045&
;>We2?ATQQ\,=dRabUZ:S;4=2@I-I&AZZ_9@#Hd69Z@#WB:OT8A-b@:@)+K.,_KA
Y=,#CQ?d?ZHD#N+a(:DS<da#KNY_fRf]8?F8O64[&M63/1CL]4^RT[eF5NR>0];F
CPN++_M18YCE.-H^f.gGI(1:UGDG,:IR9E(>VfbT+Q0f[)_fDZBXd5/[@+ddeEL]
BQ(8-b&]>g#1a>83KC+B6Y_U>+AXF&QB.,_@0]0c[-E\L;caP:.=?e6=@a^Lc:.&
AYZR2O^3[>.)A9/D]-LEBPa)V;a-E<-U[9_1La,CI[UJN.6+C_G0G=,4c1?)(\+Q
bP@:[aHWEPGQZb;#.3Y:?MCR@718\^HVWSIGCSMSX0P?7FO\GU<_M&F>&OZ7:G/T
7@c,587?^J(A-U3UF8a<P&C?7_@NB)7-^R5=97@;B\TA=AK=)5HbIT7&CD/<]b]e
IE8\<>.6([aGeBg/(V@IZb2E]8]gY<EI3.SS#AHaK#@Y.3;CUD(G-HG6_KVO&9GD
KT35OGc?@7aIA<.HSV6MS9>2&IRD\S;&QMaR\MP,e,:a;]KOQT&B<E.gX>TDX[^W
<<E4eW_7O]5)/LdEcFX=JEa,=-N<M),G25#Q[1U,a>\eA0UYf_3+?UA2=C.>(IK]
8d7QP,(L4#Rf#WF1e(DK7Z&AO&dD0NP5D99aWSK@1&5#QUeKU#>1,5d.5ceD?SX>
[3Aa:N&T@\)=OJd-]Gb1K/e=_4KG4Q[@bT1?SF_e<;T22G]>X5]OU3bcI<LGVSAa
I3I^CP#bd.QIE.[08:Wd-_UAT;?B0)G4X9Kc0EL/5CWcO(d<@ZX73VE<&+XRQQNU
_NdPfG5bgXK^M4@7OO6F55,g1Vegeg.&c:V&R506,>)2X<4^)8[(-V@4Z@A=gJ7_
,\5^R6>_6UKc;0@DNd1G.Qa30T84APVOC2IQ+J&O#OF(\c5#=@)>_US5UgT),T<Y
:E(cTL_[E?+60X3cPdY6Zd?8H-E/QVY=\QQ)bH^)#E-?e/@gL1V_[fSA?E(_^1Z:
0bV]-TM2(FYOB,Qe=/QYX^:@_\gTTb\_KQ<NK^(I>V5H)RGZ3)K4;MD-f\V/)L[a
L+5TH@6:+=O1YOFI.HT0\ZF0><[4C55&PXD:3eUXE,P76b=/<B+0EP_5K>OHG/eg
J&GgNdRP0I998XRMc,0J]5bF6<=Y6+O,7U?_GQLD_DOD-_0WOIbZWHGWQJ/8XYYO
&\Wf]8cd^/ZP,ee(5cQTP:d[LFWP&/P2Cf7K]H@4;LBbc]2#39XM+LKa:6J0(C1]
WL3Q1ZHDD#,ZSS(<aH4F1=T:(CBb:G(>?[6BU+?7NPba6;8HK1aKd3ee/84V;cGR
VT]NRY7W+R)@K\aIA^SZDN6LA#GNX.&^(XS,MO[<4RC/^_[&75<)?ZWgT1G=?FZ:
#A0[4_+&(O9&MA90QAPc)MXPaV,BJH#@B^AD+44M.,MBc&Nc+IKQUYaH3;g,AH.K
NY?.(@M?RL@ZeW#gJQ5CT-QXS/#=dY&5dN(MXJd/<HYT3VV&8Y_(>dU^_7WELg#O
)#d5/JePS[+f^F6:G/@08@_&a@(5+bAD>KIK&)^K9:\U?;6M9Y#.c0f7I+AZ5:[T
)&\(N5\S:@5][31I+dBG743D,]eF+@.#BW+eG.\,^33A[<2Qa&O+>6CTEOP+88SO
8;4_61NGJ)ZXP+KNSK4V.Y]Ic/55_Q\J\10TbfZPJOWU;NABb@DP3:4ZA(;7WAI1
:^0PA>+[-.PfK)SDO+FcDI>S165[-;V6,S<J[6IUJ/?]MR8dN[&VQ2(+Xe39:>La
:(6)>YRS-<C)U9dJ)4JK.Q07:,&<5B&[fd6=<FE;9HcS43&<+CN]]8Ve@U:^H@@3
-4H_6cTZYC3=R/DO>.LEa<DCHVG<FD#D)HM]IHS]_^NRL&NY<-(^cbHO2[a()8S;
+fON_TS&HTO]-Yb#0W-Se&IXUb#0S]T.BAFTGR&;I=8N>UH-U:EILbPY<1f1;7L-
._]3Qa]AI]J:3a;c>c,S+g(E9D^Pd)0g?>0&:\@e7TU(/f3#)dW9YXRXOTD]ZQaU
.G1[NG(-b+dgSQ7Q)OHYWHC,KAMP.OC-Y9VWc5C,;6R7g?F[Qe\Ga3Qg5cZ6U\/b
VPE\>Jb9BNKRFJaS>WB=X9Z>Od^HK&;3#DTbX]Q0&J/dCHUVP&FV(dM<ebB]1)Cf
PZ\&]0CBFBN#?91V88K9CF3\[5d^[A:T2\Og7_2.3EN;JP7:V0>&#GE]f;e/^Pg(
1Cf?HEGU7X)JgAGU./fN=0TZgP6F@FU/O_A>6)f;]86Q,<R;VU(b,GW)@]cTI<H_
#@DF/N4bEd-0ZfC&N\c;=3,_)-8,D7V8RNF0DfM22M06(.DZ+U36?C4:HTWUPJR9
:67;XaV6F4V5;=])T&=@4[(0(Z9IK),F:#TJX2f[(-BPUM[(/DWAI,6,8KD8[;c)
cUA2;4T&g(;gFc-O7R69L\3Y7_.E]GN9&c3?GA(>DdVB)cU>F+dfZOJ3RH6=(K13
40SGK=N-,cZ^&.<#gb3@K]G9CG>-cC]:gH9_M-g/ZFdRS.AV=Hdb4Yc>1X\#VGLQ
H9FbGAQCU^Q^1F/fXF16.4;=<P@1M_I3X)+eIH81g+(DFa&VPOBEO4;J99M^Ne/,
T/\;+CP4C,MP8>B_)?V(FA]Na4@5B7@[:HP^d_V;:J,Reg>_UK]B@XOfAgIEX6FK
eY&Rb\^3(=C_Y<J/XC(BG,]YRPVRL;\-?[UM@8;J&OFa:E.TCLO](];b5K6]O/^G
8,@Z[d-YAFW4,?c#5=?\AaI1S78(>MTAQU7L3cA4e<3NAS7aO^&7PO.V=6-YT0(W
2;DS[+O&H]F7L^WNOQ/ST;8Lb^W?1J/QaL5R\[aUHOC;1LB(,=GL,:?0RQ\V8[[E
R[A:MGcJT?G=Z:Rf-CCeH^\,?8TBAJ>19+5#Va.5d()=-#M,)1:U0c<67)OeV2gX
JD8>4]7)H&5,M&_=N2b?1VEE/T[-(14J(L:DP=MeD>FX<9W\:eOSb-5.L2W_^P(S
GHJ&6778+7G<RTDY&:9^3?7]We-HHCSS)GK.?3fQ\]F)G:aKZe;NWbRY0DaX-/<T
Le6P-NF:V4H=:>LW9N7G:T@R,.F_#.P:f>V;AZMaG]TZe,>2/@SJ/SA:2ba?=EDF
5M)T>BTY6#254_aQPcBIP;7K@VFBH8Ld&V+S&Z?CT.A8_#UA>U1^A(0e<1.H>g)F
Q4/\^SW>:SabAARB^L2#9ZPg_Q6Pg]/5,)+_1SaM^bFDSeHF\WHUMBcD&2ddS;43
YMgNDa]Eg\&bgQ.VS=50^8;F8WCYf2R](U?I&^Q;@S(fb6Q22=?Y4<Yg[]d(D[fE
<_67L[#HRA]/M2/9fK7+g9#A?872D^0dbcW:d?35PB&VO@fb88>(A+RG=)[2Eg,;
PgJ?Rd1BE+3W0:8N2dLB.9M3-I1XYMfAa).=ZKN.C70[(=ES#N0]S>d+1)]XZe85
cS5ADZeL,H&ZKSQa[gc1V>_7/K3R?eJCV)9KFG[A\Zc=0@OWN[eb1I3_0<HM94)6
c.I,F0QI<P\XDK;[)5.&TZB+HG48fK258,YJWOX2[&L/[0(b2Z61PNa>7UOg[9GK
g-5=e2/\Ug,ZTU_\9\^g@]S(^H(NGZ:c0KZXOE:_Pb0AX8:Z3b&,\F9V@fA_L7<\
GE8L:S=-5I&H+<0bbWUV2Zfa,Q\9SCI.@E)6J-.(GRDDY^UP+Z2,G3dM1\f2QTCc
7JWJ@HKR:YE75;#Z1XeN^^2R8_L?+,c5Z.0HVV6Qae[9CAT1/\9I^JZ^C7X3@9MI
WN^Td[67Y2Y&,/Ea=-0NM[0P\NIHUYDX4#d?2FIfJf\X.=/F3_,G(/0?R_S;Z)+3
@D1g\\M#d4T(LWb(V3GTD8]UUA9;QR8B5Ea[d?(I>d[HEcJ]].TX_<:VC>7agZbY
:6<I0?\:(GbeEa1Md4?UY2G5^J-M<+&:=:_S9Z6,)S50T(#bJ=f4@@,-N^g(\[3Z
5M_d_)9ecVg2T?4@PC6#^eWS/WO+fLaaaG[I@X<,W0V)Z_>3NH+P]NV=1B_6J^?]
P=E:9)I4;>dO0>.:CJdM21(G_2[1,/<EbQUO_8ZNUV=S&/7?>L1KH4;;cR=cA[[-
?O157/Y<QJ?GP\Q+/-3@cN5R(Y:L8Z(?(LNHQUNAb/^Je;:@M5/#c4.8VH?7S6E.
+1LB@)D.HUe-\dK[W_E-5.D.Z<AHA+X-fN.g+[d.#=WU^Ig()&RQY(OTYf@0(.H=
QD>^#/3V>cSaQ@c&&\Y==_OCg,:(-I,0HUCea@a[#7&KdAQ,1Q_JEJL?W;#-aS]0
BFb;GX]>G/)M@NX]C.J:V]4e(4gQdH/0(Y<1+K6UgA\KS81PfJYH32FEO\I#?#<C
:G?AOF&A]-49])Y-N.BG?08FMbb)QHbJ>J&P,J\2K&=^.;;G4?B@9P?C??A(9SKE
Pe,?;K2_.NB.X8CVG.X\_YGF[:1808Z<3=95gSGg;HO+bBN1.>T]+:Ug15[fG?C9
#Kd3EG<W<M^/3\N(S@&:?TWM63_#M)ScRK-bE51,7eBd77?CV]_V2gDX-9e.Y>8E
&FUPIc(.H2>KRTJ?&LB4&S:+<.g-cbX88R<)=32EE-C0Mc9=85DN;4N8Q8e3<,Gf
)bC)c>#@<K961d;I\-I_E6H8.dLY;_2OO+HV<H?(O.cUZL:=;gcRX&81KQ;^[MOb
Na>H[O54-ZJa2e-XQ9U;e3PA9^10[OaMIX6[/b8POI+cAgE##P5-90CeEbE-C:G6
gBR)Cb+J&8Ec7F[-QLcY(50e[3f2ZQTIRUXaJ(<[2I?/NRbff7cXGBb)^d.)>C^c
1-(UG>D\HBO)V#8E@Cd:;[4O:1VPW:#4W&F5B[@JCX8#=;GRRZ>#=AfSJ+I)B/LF
6C4(VIKUZ[W89^+YEX(\D@5BR=eS-PBPe-6PK7_Ka;9a/HgTUZ,e27N=@4OFT0W<
Nc49U.-_d9C^e/=^?]=ME^8+06\&=J=^].>_Ka:eg<7:ISbJ(e,:MLF+@2_35]KA
4WgN.L_A>&\(#XKE3E]KbJ7=gM&KE_9J3L[@X:(24B53QWOX+CKX00eVgS)[DYe#
97gYfBC1&G#ZEJ1X)ac_L7TW/,B;=9VPcg\<-;GHDG_XIX5g5(@f[+a:TIMM3XLd
?TM/EeRH@9Nf9HBI._I?=T;OIQ#JPN-N[\T3TD(b)\=I_D)(Y.He\L,J?8,S0S]1
?U&_(KcL(H:.e8=LfA4#&L]?[8,WKcM/]d9HdQS)]O^Y;4T^F.[9\A4-)U_]=-TZ
2Z\V7\J=C#-X#YH/TL(LA,c6Y2K4F.[=6g1bCN<,e#M3)>Xc^69=WH;Eg\F]P?Da
4L?V>9T6@JY]WJD:ZU/^-[;dR#/Pf1.@+F46UdeP.LRMg61BTWPF&?Ed8W<)9IX6
@Qb;Da7G3,4\+0^OPfe0GEB.>GUSG81EVc9EA+_&OEKS_X\NBU3]RTOSAQ4KUcV:
#_+X#,Z#-J)bEe<[R0?2@=LYS7FMZ6S5]&T=.#<@II^bU^CcZE1.a-eSJ8=9DW+b
<Vd]V-LK)U:Z945A&;Eg\^+IbLCP.-WI./fGK])gX=Lb@T/:CIV/&NLOC,]gHaSE
Te</GGI:d5XGF3.(.4Ob(?;d3Q9J;5XFDF/UEBB?6VSX2KD9D9()4M]^5Z4&?aR@
S>7S_3I^,U^Qf_^A6ADE[8WT<K&^E2Z6(YCa@#,d?N?EL-B]Z7:5&D^\a:_=T8b?
PfW892CYES]B3L>c6T052=LM9D^\9QV1Yf/ND,^K9IB9L7SR7Q;c90QQef)&Z1C?
XGOS9O2M6=C1Y&+?KY3\-=dQWadb34O4eM_Z05fY)BEQb7UTEJDSefWII8B6PV;X
G\3;9LTedCNSb2R-?aZe:G[.Z(^YGA/K4Nb\.dD?MPI>eD2TDN;:g+eU[)@4NHGK
&C@M[IIaIU(IW3S5a/G4MTAfV/d(MI\Z#;c_X\dT4;O=??[.F)OLAfMHP273#Ig[
HF:bR8<#V8.4Db/7BFfVbY5@A_\V_UGPM]C:78Za#<6&0\3@bFFCU3:MT-2(WK:H
=5;[dU@-,IS::9<_HC=\aP16#@6-+9>cLDgJ(_^>b]=S3]OPCL1Hff#&K26;UAfG
cV@/M8HL+Q3=d@PT<G4WDC&DeHg<PTR+#Z/&#-g7&Q2_2V8=_FT7a5VfTX<Q6e/;
/Y+26TIGG,(()#7+/E;F6U&_<0]aGG;9NXea52W1)IYG)YFB#YZZP/2KG,b7(=T=
(?]U9XKf;C/=2:#&/H^,=9c_H5A<_<VRd=f,THPV#8b17WFH=10+:Jd_P6G<)#OK
5@R?Yf-_0S#/QLVTB&XP3aZdW0)S\&77+^TdBF-]>RYQ2YVFKc1Z&+^RV[ggQ^<c
=([0J5T;-c+-C\K1(cGb:4Hg>@Y^#KC1f?4JLBC:CNR.3?P5QT[/4ZQR5K3WD(/H
Q]dIEHN97DKG)0#gYUA\[#,6&JB9LTPV=K[=<IL:4;a6<&6eRC&J=)Zce/?,a-.E
U0-T<b3M>Y+<(_XgO&fJIIdYG@a>BMSSL,5=a_=@?0WT1UBD/9I+AU3_:^;2fc[9
@UBCP4RfZgAQ27H&DTSR(VfFe6?L,X8AE5ggdLOG<OF[c,?>GM?g#9]2g0=XK:LI
\dZV+eXEO8O+I?;,&AEfI1?b4\PNZ>bBd2-c\Xb0+:KJ?4F/f)G[D:&Z8#A0-HXC
T8,(A^fTC,UKa>X<=0cEf&>0TVODU8K>W31>TVDRL76Y3#Y^3\W7<a5IIF,2Ud7\
S:0W0@Rdbca4DU0RZ)-1;:;:N5C=/H25Z97@/Y-?FT/&3gYA@bPK52TRL8/?-^[Q
K=AXI7T2OF)^,V++X93?]/=]D?S[c>3UZJ5Jbf#ABN9>/N-U6/<XQC#HOY[PgbPH
,dLYdCG):\YG_,2&H71dWB@5^EBA8+US)Z:/VC6b98b;CQT)8DJe6;-?.2^17\<]
gNbE;2)+4>8W<M.-M^[cJ3Z,TT:9]&Jg=HM=f1IH^EQ.2bIS];PNP><;@=MKU<=2
&61(SFHe_X-DZG]Y=&9MQe-?@VAF)6,Eg:EV4fc;GXV+X>/?LXLeZI.R6[8?_?PS
:V>_]<[P/Z3WVMS8S/Y/-NPe,.f0?=L.YQZPSZ<FV^X#\>RaIGN7QX3Lee#\8>#L
PV^XHQe00R1FC)AS#Qc\)e.#F._@^eW>_Ng_.fOfHQJTf[[,ER-=UKBI#;9CX,V\
5g@a90OHG3-IMcd,@19dYa:W_=G&cXAT#e1/ef9):]2<C[UBab;8Nb5C04R;,aL]
_=Z.</RecWRWb,=3<D2GGH6Z]ceK#(7</.Y&2(EFTW_f/IUbI><899\1@N:+0GJB
#JeH@eK(9f>J7-]N,Y2aE&N;YUd^(P/M@QEJeY5O76Mfc_80_,U6Id0ZCa56N;SM
eR6+;UL];)L>,Qbf3NCMVDYE>HLB6X[?g,e@N84JPR0cE1P\K>ACLdSc.)Q>QeGJ
QbNNd:&T,FF<\\6PMGZ>1WeXT,@DV61C-4LH3M0_921:-W[\@gVHEPL2)NC98((X
WK;B7X]U1Z;,]g0;&>EZaGSdP9NT#]VF5T.:;]eK2dWAa_FRc&g#b)Xg+I@IF;++
>V&;Y;V:Ng^C8HLT2+Tg6:R&SNaCWJ(_dI/),XO;MQ@.IZMf_K(]8[Q#/91/IU)3
X]CY,[:KgUg5WYIV4</DN6HC/^17gA2-M3I9HT@+P5P8IIYaT/L]12Na(aQT_632
8YdR2H4bC6=WSY:HWA0eQK)^5FK_^5JOBaAOg[I^FdE=)_A#^G_V7>5XVbG-+,,U
A@2Z2EPPP7B7EN[d+g_\0F#,Ta#<,Z(:XA=EeNf]W9a(3-_:W(N+[dJ=N>5J59CB
[C-EPe\F]WZX0M;FePS;39Kg2^8V6B/YcB:H[-15;AV9X]eZ;3Y;K99J6[=Y(8YA
#eJ,0Q9c9RSd.[L@-fF61cAYU+[IZO<ANY]bZ)NKZEIGH<+ff[BSP/#L&WO+M^Ue
N0V\\A[Q22\f4]ZI_T9=9c<7TVJ7IUeX:\Q<PIDMc)6NV[e2,RP&[FW;gH?:YTLX
U3UF0U&RK@SM&#)(1<)^I^dMY+BN;:M;(W_>ZN_/NWD#\\T#-?8&@>[D,2UZ-[b2
^QP=;@1:=V?NFKJ>_,-B2cVO(4,cd810QD^JLQ+Y(3+eYZNGOIQV)B.(A##^7@U-
4RFN/SE3=67]UfF?):>\6c=:R/VJ^DL>3ANa?A83I[IP8<GZ<LCIAVT@W^D-9Fca
\6.Y;=;RKX>8<>gQNg0ZM5-Q2DW5N2M8,.W?c^>_c/GI4#bY/OM,ef\\-YX(9C/>
T9<B0Ka/<WLeG.H^LfJ@0&>&5eWY<?=g[gV<61I>Zg>]@T_)\U8881g\f]Kb1#=L
QZPY<-cb;YBBA?/,eF4G@:W64?HNW.Y<E6@2Bdd;=ON0d++=]/)=F>^LTR?4b-ce
+<\DJdR.,],+FJ,>[E^MF-YC>)7#CZ17<bdTIY)^K/B]+U3J<:.SBKI8AK?Rb-^E
5F^R]#MWG,;AW/W&508:;;0Y+LVDS\EYAQT]:L_N-/.(,/;+>&4fe9+(K1L&]G14
6,#;U_O59[:a3/&eG3\VPG6d\]X\cL@TRO2&P51/7a8=DAgYS-=-ce0RC09EX3e<
G_WGSD;I)Gc5I-\@@2Q/;=?8:667BWA+UFD=T09fdH.9/Eb0Z+(H>]D^9C_eKbb8
YTReW10IWXK+AeGg,?[>7&57R6UK/XQ#6Pd?_Q]Ne(eLb6fLIT0G17V53D2HXgYK
=(0Sb<D)Ob)X2X8/\<f6aa=:8Y[Z?RO@cMRZ>aGN,Z(9dJ2QME0VK]FDC^Xc_7d\
g=Ig/;JH#@NN]R?VC\:(W;TIVe)RW\O+-NMK7V(-2R+JSRf(&#G\<c;eWHe.G,ZG
Y;UCUB6+:4D/5I]959/4L(Q:.?E=#M6D3TB>,4fSb&\RY1J9(ZC>H[,4e\:D;6(I
>Q>fA3DD]E:f6N-D_Kb6MA+UM04=I2-6YSG8/8(6,8e>cc]/+--?.>[Z&K&5_ZB?
2]O\@O7=NN&=@>\[)51<fd&bWc&0fd5-eUZaR92]N8&^W:Q?ed>RGGJVT>66(W/Z
]4Vc5g,:cTQMbeA&4(D968=IXJ20^KD[e0>U<#J;N/1[@PZ0\]fEdYg.E>+2=Va\
ZLG,POJ+(A4[R#J&OCHg0Y]Wec&CGW6>ObHD0JYLGX(@<bNgI)YP/6E[9]#_IWEW
HQM77=[,.R,N>&\97#YgJJ#:2#X#<))SUVfKI_>NQB:UE4F5NB-5V;5V\@RTEYbY
#E>5VE-Z^1YU?0E32@g1<2#<G1#XQ7ZW78\#O9PX4.Z@F>NC/0-GcGAG#3IN/R#f
=..b:57WgVT,FIcO7_Z#9a]A[fY.X6V(C<2UC1,YefGL71<7f=O]b7E?Lag+XD@O
d^T:S(O<@5MdFTCdR]LeUPV5(_J[:_F)P<3W=f.._1K\-B3T=A9UF2+2BGTW+QD<
(/4^UX:\@HYf_;2e0VL,23SR=OBQ<5cTW^?TbH;J2LQNR7M,-8a3PeZGeSI9NA>X
eB[)f/bW=_bB2Ze</M\AMT2dbEJ\TB.S9D0]3RXI_1@\F^C8<-/[/5WAdPAPYBf+
+Y?)LNgGRY3;E0\8d=<.XQOMY[e1T[6]VK,U)H<QLH/BRUE&e[VC_gcH(.LSM0>6
N+Vg@LDE/]3F]ec8RfR24I<(J@\P[_L>;dT8)=[Y(K3DPEK/eDc;W9P\2=H0E4gI
gSS8D+c^Z,TeRbB+EU+P3[D1&V.I/0>^N_Z_L=c2EQ@L=RP4<>U=)a\O1>GX7B74
4fKCZ(H(/E8b5:V8F_bA?6H=A-5TPA5??1A^a7D0^D<)e0BXFf@Z&(U6>e255e:d
7QNNIT_UD.ZAeC-.g09;F?Z]#B\U)RKb>02a>-T(;.f=1-U[Y?fBEWI/BXYc#Y=<
^MQ/IdgVROUQ(2WY];IU2&5N2HUS=VOf1].#>AZe\g44PJ<>^29G&@RZ(&.g[JZ8
>agbXFbC+,]8H#0JN[]4:[.=I03LNZDf[RR=-V?@-_RE<CL0G:015/>+-LGTJ+/c
V:A8_9T,2:]&dcV;,1X?\Pc]RLVOMUQU,aD86QVB_I5O:-]Q?B)+;Q96f)Tc7U7_
/D\BQ8fF1H&d/2S9UF1W)Ra^_8\Q;&Y]],.gXe4D+\K6Q_e(06MZ8D(UafJ\Lc\D
>154;TTeH?ILbP-)>YZC/,Y^F_D]^.BGA-?HQ7fb[aC+H.0@EYf<:C.\bD<f7]NT
.:Y]+S;Nc2_ABTDf)f=eQO<C&_3b#PVg>;Oe#DI&cgd5(QMF,K+;<F]d#G=.>@dA
AMWJLBA)22G;(cL-\\-TYMMF_Y>=e#QDaL&5a7eNXb[X_/9Y7d/_cE9]?KPQ,ZMc
[4.e(#EB=1IAC;E,(CaJGB;#^;4(fE\D7CR9fXJ&db-:Gg,JYE40&f5JI,SMZSJI
GSN-@^Z-X-Z.G?,.?-E?:JYcge16)/.0U0^B<;Z[;+ZB1B=edS4XP2X3+a#:bNL2
,3KdDf9U=-;BVMXc>QKDUKTH-\BgQY_[d\M)A.f(fE-P;CY3cVgH+#D_U#ZH6e<T
36Y+1-J_d9Z&FI8_fg?HA])=_[=I_JXUTA8DSJ>.?/eQ9c;-aeC8f:=4JcX4gGNI
e_QF[B@]93SX#\)<M]KEX[Y_,R5aI-UGHKgJ<L3>Z86<fbaZ/UW6.gQX20CDKGFP
B-1bB]E>Y18\]dB^3F3,LJ3cPe376S.V;\Z8a/?Kb==U8JR@#4JD33OeNdBdRM](
@_I7BWPAKHPP.@g4eCC-)M5Z/TaPeJ\-\Z4,)9E#M]X,8V]4g?6M384/I7Z:60BH
C-d8U-[F&G2\:L)A\ZX3XN:(LHX]H8;3dQN=X]e6,V-?+@9=W-;VZS,70]2KGYV/
cL70f?G;(ag)BV@BYATUf@/N#KFZEEW[,/9U^E#/?b[NA7&^S6Z-]V7/UaZN\UG_
.1:Ha/E:?_SX&PJ^4LLL73O4ST-7cOLeQ5=#EK\cXYBKge^&VU&[69>.6gDN.;0@
\<B:_R.V5Ng8NCEd?;T,SE,T2FZ<@43T5F?_&0.\W:3Ye]CKBJAgWMFaYaE,&:HV
RF8G0+TG<TAdJ(SF?_fFNM\<BT7ef_C[<[ceE.cFZVBI@>CWab&,S7MKZ3Y831d5
NcB(-NP@C5L50g5#;5K:Xg3.V(BF#JOI:^@/)K?J_G864=Se0=)W13G?N\cf=Q#7
#=5K#^+>C5eIB@AUfYg3N]-J/ec@1,:d<JTM1ZgU@I<QV\X&Y2Y=>N.KHL;Re&T+
aF-8(/;1CYX=8CMSTcM@b]OM#cCZOIN(HDEY1B[PL89)0S3>ZJ91d/=fDV?K<I[A
U549^D6G>a?CTZYWc]cN;FL7N>B\JIAG5g6#NFY:PRE2YESQI/F>98D9g>PI<)T;
Sc1&NF,_E\I.CYU9I\E)<+T+-:2R]3BW1;ELgBCWIV(XV[1DbbSE0IHYL\40Ge]I
eEH)E]e)JB_)Z+SH^0H.E.ZSHR68&d(M<M;bR_)P/6@@a50?&EY6=b-@JX1+,QO;
5829g9IX(LKaB7aA/2=862MZ1.@0JJ(6TUH)^\RG[OP:3Xc:;dg9\eN\c;(eHU_7
Y3bY@3=.>E+KbTVU_bFWBO+\<GFK4QSF6AVd&:2H_-4I6^c+eX\<DMf/&\3D0AJY
W#e^2ZS858JA4M=dMMQI\N:R#6)/]Ve,a38>TEgI\?:TM6\OHFYb2eFVd^QB+B88
ag;CMP#AUV-g(E,K\\;]W3X[3-SBOQ7F\4dWFM(IZ+ZIR<9&eUA=,,/gdEa,SHS0
cPI=IQ#REN4QB+7_gIM_B@+1JH1NUT4Cb&P5KgU./VLWWLJIdD4^/S9Q1JN#<N2I
b71CgZP-R,J#Q@?V>f;<(/=1>I[GVD(;]+3J2a/&7NE..G;gaTA1>a7<Bb[@;@,R
G>M,)>6?bcK:X1^F33KXO1LQ+Q,O@[Le#X><ggTJ#IY>EbN#7WWI\>f,</LFY20K
&NJ2f#\Q@ELIYX/aAcf#[Yae_Oc2Aa-=\)RSBH^JOSH81T+,,;HF3P<=,ZE2B/[M
<R5W:FIF(WR=^Y177ENV3N/R8I]b-26X1N/AYL4YZ?=:XTO2(.]9gTN^/O0YQ847
QdJ:]W?=4AA4d/4GaW]eHT4:L6Z4A)baYI-S8+a5(5LZ5&S(Q@TB/K#TZ/afA+5:
g106,OM=?O-J\R/__)N(?PgY1,0bCSe5#^R77Ee),=JE)f5&6eB,8FWCgObG..Z9
3OE(Y+0_U4e)P3Z:Z8<>cP8bJUCX+<EF(64,-Zf?cUB<VN8J2IQE<1^bYJXLa;b/
W-7IXdZS5Y/SWTW)0UGRTg#Z1dU:fKBZ7f._#DU&FR,K6-(f/Z06VDLd,P&Y#e9S
=N.A<-X=09C0YW9?6)M[,IW&bS,]@AS4TX2)F,f5790/N]a4:0K,3HR6^V+3NFE-
Z6Q=T>MR[;412FabQD+W7(-X:;I3)cFW.:P+_J/#=CIDN)S[(&S<__3.YV]@Y6IL
QB-[C4Rd4L\b\.,/eBU=W/J=9K><C@\:M(<aNMUJ_AV=JDJDQc)=6](=3P_ZYQK+
[g7]g@\K[2)91RG)<^DBF7PF6&b>_-GLVMHX]+CK#)/,2WRc:]G?F./^FXD60>&B
SY^&\=STFN]2_F1Y9K4P14RBV<@&=7\MS&EJ>QLY>O>/_WFAIYN>d11U0KG6FK>?
<&#g=[9P;:89bTN_4b[eG2R/(>7;PXM:b6:/G^?fe/cB/RB[GL@HfK=;T?BOeg_Y
WYDNQ;e6dVLCOUD\#R[^WAeD\><6SWAMT1;OR#+/LOKQTa6<31LGHY(++HUU\bR8
B)WC(K-_?dRT2]39c#O3^ERYB9b\+Y3S;>eLN?.bfU88WJK[_+N;DH@bZT=(06Oe
4X?7#0@@(#<#fA,UH8CXVc&Zd?^\63VgA)KDFP8PBZ/TZ.g/&gG2^KE/cKU]Z_)E
/&J+9JI[8ZK/Q#<4@Z+T(Q\3P+94=F7R7&&&egWWUXUNONEWPSg(cY1ZWOEO,@-L
F1AA_/RP^Hd&A-)/>_I35],L-6+3dE/QJH.700B92768##Z0K]>0ZB+B0BVD\[:c
3H0+GYV4\;YA,C\F&I^=;=:48aDDJC)+/ADFH8bSW.G)aR+O^X78>;UM8Z&#9Mc0
:M4IVdDG+a09JA&7cGSE\G(N^7f?aICT6V87,fg41R6/N6TD^a@.M_;cHDBJ&EQc
I,V8R]U_g3K\3;4_8ZF._C]V)>1ZU,A7E@[G;C+4YK&\Z&3A<[G1ZGR5KD+bZd\L
U]0S2H4=TH\Aa=RE]W;b)10N?MJbW0N4V<e0,A?;,4H887a(/EceaT<aTQ73.I^8
FYC]Bf=4NE+BJ\d(H/19aRJDJ)L1)cV&8G_HQ:\1YPTcJMTBY+Y/?Se[/ce7bDX2
[U.WY=fNQL[Fg4Qe1FHI]U>)gW60)2b3b(^FV\RBNF6d\+(ZXY75a#751JfK]Z7J
Sbb^?YK7U#X48c^H.Z/93V-;_aNQJ9JV^H)0RR??<gZ?:I/P?dU1.8IbS-CQ9LQ\
#)d5&<H\RS2_P4IeQGL6[64GTS76g.Ugd\?XWV]7I8-IPH9[]B?-,#2>cf0/4E?@
QDg:cCMgZ?8NIaFf\Fb0=76cHQW7@,O^C00;>X\46:2^G6X=7_IU==M<B\a/:4+<
S/H\-gEYV<;c\^+]Q_RBa/b^US9),;-A)XXY1SW;ECb55eQE;1Q\1(DCI>UQSRcQ
];W77GA7?8TbPY6X3OT2XUPR@46_P?(bEKD(IPUfcf<AQ[/\M9C#3Jc5&TU8ZHHF
J[1a6CO0bcE_(\7:8-Y&35>>9#D90+2/7DVA#&J_1@4DW.-A)O^8_ba^V#KAWbCS
)/7X1Af&f3Xaf<LZ>_/9AC/?Sb-Ld.YB.[C@\&1\cccQ0aRH>a8\@4-])ZCX1I4G
KPbN^8WPeSLN5LW>a1fAGbGD56Y:CKK>]_=?9);g-==[YYg0eUH;.9Ce)#=DFQ,2
ZH>)RM14-=WORC+f7+OC_dS0AMQ@)(?fWD\XNRWMT96dG<=Xg_=/H8)UQ26HV\fW
Kb[FQ_=7;)6QRPgI;@;]B_f0UNc[;&&NKH(G/[T8K?:<:g\g,\G2/K9cV>YRNbE&
[M@Y[5-aRN5E;F<RC.3@GbC62,P;]IT/UYQ#2R+cT)+OYJb7&=eHgTX0\F\#.J<A
W7(2cQA],Z;1L(M>2C82JO]bV<ZSIGIY_&MGCMgV30NTGYFAc67.[<Y9)RS=:2#0
EZC=VTJ_94H0/fLNO<^f5]+[-+gPL,-(NeE(6LMTIg_CA&+TR@0eJ0Y(;Zf#0T+S
;0+,Y1<f;X=JMD7)>SQW1Xa/WG.JYT;&+^ZU<]AWf(dTAEK[CWUK455?/1X+43dN
6TJ&8^\NeV#7dRM;&7=Se5WZVEgX:O@U_.]M.g^UW<A=7YC,2]GO(YQBL?3JVcR7
YH?Wc>S8+_(#a=DA]X3A;c0>)>EN8<#A[M=G+LU-O7d[EJ]Z\-N#(EG,@7?D:[Y;
E#SIH7;U(U,gXBbDccH1LDT23QN2eaTWPSG+=0T\[H_[Q]7fF;C0(HE(,4RgXKBd
7\MMY.51&dE]Oegd\EC04B_bN,KXTP4KSUNFI.H[cNSUIFVMCRfPI0EK25M8B<f;
3=BU^144c-G]W(9Y,Zc]^@11]R(ROH:[7,.1DJ<-aaeP<#VWV&F:&/TgS/Z:f)A(
GUWDdd/Q,gYc23-D+^A;ZbaeTJ/#Q1IRMANKARXWL80I:O.46G#f@CCYC]BZ:<Qg
LN3^IZC79AS+TPa:6),DWH+O0EF=>R&S,5SLf0V&P5;aCW+S#@Ub?POFPf1LPHcT
_=KF@?5+=/[_4-LBA)&?4]W7,B)04:a-VLT]Yg=dQ?_PBAFSeSJ(aX-9F,G>ZBM]
g^L:SC?:-PcO=:/U:DT4c]TJC)GT.ZcO<9:Z,fe]&BD0:]H.ZT_UT&_O_0+K0TJ,
AQ9-e#[0V-Z<@+T@+5?M@S/<<J2<Q+Ub=\eKOFd89>R6dd\&IG-dWM^Z6M..Efe.
M0EN0GTJ1SU;-&P<(7X+8cQRQb+P.H:AcY6N>7Bg991>IFNV,=ML+2.A5\=aaKJ2
^Ogc-[-69PHSCLdgK7C^G[3^fY/5\2NQH&49c]-Z,6QZ532-SNFFGDaT0QcQ7@B1
c=d09I]2K-[6_W)31f[WN/36Y)[^50O(94PQQK^>eD.0)IOTb?R)6g7]C?66N\JZ
&[H[f@0@;ON0YZYFH-8_HPbXgfX;I&eZP1@WcbZF,,JV=C6b2;:1Ma<(M]?L:P(^
NUT;:=F,Y(MA,T9Kc_-[K<&IE&WfRcTP;=+deICU6cN-bBI..(/bH;L2+J4XYTK&
]?Kb^F&g1TFQ,(Z8g]Q=bQ).e_JPZ@c=63-.H3-VF-_F>aD^=)#)M^e,3g?T[a&;
G&CVY[WV06EQ#IQ(KZd?9-PKU&YCEg?G_G747a4.N&@EE\M\F<:d+K-F/02&/?L\
4K5Y0YaS@2.g2E>-?I@L7Sg;JB@&UMJJH3E>.)5Q:+F0H+Z;MUIZ&A1IQBgBG5;0
_I)=6:S;A7#EU30W((Tb6-DIIF65+=D7EOD:@-@2,,,;L5fS3fQI#bBgZQYJT8N,
?#H3e43?+Y,,DW.=3W&M=^f]4,1OcIgEMW]-W.#^>]+U/UBP>P+:Y2Z2O)V]QPS>
Jc[MN/F/+[=aXc@-U+&ZZTLKU@DWY&0CHHY3DTB_4;c92B))9(-cZ6HdH^Ta7+\?
1eUZ:>J-B93f#471J16Z0c<5^#TbWLU_B->S8VAYX[2IPF78M^N?)(.RH;^e>^5F
;Sg]5(2VNX?J0-a4&H1Web+=F)=A=QCgUb)d5\[A<I;ZN@fKKU_\L6>g=a?K)L^Y
a;3CE>F&d97ZIJg;KAS4-\Y=[4TC_,\Xd_^WD?PJJ#OI4]<O@WAM4A8&R.c<<MX]
07fA^K0@G-6eBPXc:+,bRQXGX[3VNO@8Q=7&IY.,337gD)::3eMWc5.-FL&3#<=M
VWH=NNWQbAC[4GXYRbSFU,gf)1W[-,NK:/+77IVdE\X#4O\M4LgbeHXNC;I\@/(4
8AVVUSRf7:(MKVP7(P,bVR#W36](WQUdMgQ?@a6-,SR_WG;c760H0-OU7JK;JEd&
67<YNG\L29Vg11/P:J2Y&LDZF4I=BMGTQ350bTQ.EV;0;TRd7[LE,=.3Hg7TfUAF
G=Z;)ZKM),_J-[@Sde:_>??DYFTR-[d&MVVP62:P7?gKVF&PM33RgbUHEC@47#Y(
^V#JL5&Q6Kd+5>ES7_[8:TK;[G;W\XFQP#LO4<K\&F]Q1dc0Oe<1?-)fY]9MR7-H
BLa^.b9QJ:Y>QLI5+2:GHe8G<.AH#TX0]GOS86AXKe5DL/C;X6#ZdZgFGUB7OZB;
a\?E?4:,>J[+.@H27=0,Q2;7:[VGc36J3&C23UaI/45a+6#.RX5W7P[[f+#F7XJH
Mg[?Z#U[XLU>@@KNN_84+<3+YSSAe@\74<VM^>;T0><.eCTI&0YQJLf/RRT/STd-
D_U6R6D3D1Ba4AOF,U)FD=/N45G@gaTA?\dG;+,C]_JZWd.7@gKZJREP6+V9=f#W
]MN17=,4#aRZ1SOO(3&6C>&A)I;KP]NU,-EFe:0[HN5?S+HN&=GL5:DY40<(+X8G
J,Z6,AeL>9dK=(A_6JQ9JW3XTFY?:.@]->SD?8G9ZYWZJ>2/Vc-N0[KO)XP51-XH
[-UD@OKfce>FaRU+(Wb0TR5#G,KBDRC?+FK/?E(;>5711A:>[+ISS+d51dPfb[/R
2H38<NLJ#R(@;_8\))(@D=/H;I+&/d9PVQ;HT;J)gD0#EP[#5N9Vf:I>2FOK@TZS
4)Wb.;OQ-.e>1XWRe=g-[UN/F;a09ONHJ#c^3EUG@:>>F#2IWO.1Ic3[eG,\N3@&
-=TAG?7CMZL[V8FdPgcBY-S<d9Y]=PHfPO#\^<=BT[]KC6(E7&gVD7^1XG<7X7KG
64+cI9T?GD8<egK0<g\3Ub/gaL7FP[?E<^2/\+3?#<PHVPF5\JMN2BCVf7TS\fPL
FLGZ>dTd)ABJ<[+C[M:_SbYE<5IgMP;K.1-R,X>=Z/FEP)ZU#\4^3)_7V@?G2-T/
.\<A>YS:4,AM,]G<\a35c3S&QG7/RKd,eQ>?RN>2<)IOe=:5XSS?4?2F^MYB4/g>
b.5_(ZKQR;OCJb/7HERFZ-T:F4d7X7:Q<E:#MD\aL5UY1GI@=a\72^7];A)WM4#+
XbM/IX/M.4,P-2/_6QD/?ILfP<:g4IJUQ.fRPXCL/f,FS2C)N0__+?9@Vga?Q\J;
SDacDZ1=?DNcg-G=4A[:MJa8@U^0#ZaVW.Qe=LV7P#.E/PKNM_/YMa9RHVYGE1;#
e/[E@5+#9UH+K,d>U2)QC4ac),^H<9>)W:eVX_O8&DEMP.3O_LY2[MX3a)-:[:2.
e2O.,-S&P3KW-_J^Q@?0&Ecf7NC3BO<7eWa@MIg6F47IPI?aMX65TdfE-E<.L)MS
O[&K29NBIPdXa>,QYRMA50,[F4E1a05S2H+1W7g47K.cE1#=<MU^N>(+c;c5Uf2U
ZP\H#VLZ[Dg:Uf,OU1UIMbT@+JIPB)3GIYCPO:;]9#Ab\L8W,C(+6.VKT[27@()f
D@GX+2KE-cQ[7V#N#T<(,,_P;>\fD,:E,BC<W#8:2<]1VNbY&R3M_18/Tb_0:4-\
PbH3V9G\7=@E</D8P&gA7KKZ=4W]:P?WF+eVW6@bT:E.3/7Sb?bPDeVX)C)N?WB.
>^[55,=83H9:&:)61Q.d?7fOYSU:e8JWL3XN_5BAdGFRL\^)V_,6/;IZLH]>1Z]V
9:c22/FI2+XZQ\;P.+@C0[H505Qa/_IFb^>gY015R>\:YfE\.d7RZbCAP@M=GJUU
,)P/BW(/YE^7D5Gb+LC3+^840;LZ+IU.Gb#@L8IAYa#W/1NQYEQea906<PWb;40g
HZd>SgF?Tf79;M[MgH/=>4J&S;@:?]TFc&<F]^5<),A>e+ED?(?/Ge=M+XEF\&BP
&Ce_UeV<5WWcNb>ReISg?6&VS=:^9F-JV/GJ<+QLJUR=JeCS6KTX2HX.CZ+-d\B6
GOV<EC[MC.7]/Q7>aKJY1[Z)/,X==cJCCBeaJ+TO75EH>MW5:,-/A2O4^.e0&-fG
X/(B:=0-#T4ZKHIQ7S-5Y1LAQ.1J^)M.>Yg6dOA,2U2H,TD\LYPF.UFd.DE@Fe&4
^@ZELZfM+FbLZA;#VIZ2KLH(B::AAdeA,+SW9dSe-c53<<H=Kd;>a-LL_47P^bX0
R@2D[QQFVO9T\da->Mdb[5]&If#bHFdQ-O27YQWANVfH>05AaG7GDGUE]Y7-RTP,
AE=:_O]?0F9VSV/bFFQ1+RgOR37/\:?FSa+b1GNTLCA+OC/&&Y+&#0#,JN@;J^1S
LZd<[=abe(7^-2@D(_:P]bC/6&B39F>ZbNE\B(,[P=02<)&&\a,3S&Pe.W=1F6RH
#BC?aB;^VG:f)L=bWE<R7[M_B?P8VUE[b1=X@2R=YL4NLS;HMNb:S2dJ@:Ae\_IX
=4+W#e8[VJ(IdJ;;eZ,d?R6^PG<D3H\Q;3OMg5(Z5,0:3c-OEL60L2K+K/2.8@TQ
94Q)gIeF&<=c0CENV8,b4C?ED+JNQJRVa,6G/FdR:f;BT&-7;>9_,8E:]R#XV@=1
((c.ZdI3D6+Z00=1,@B;W@@dF],9Z)4OFe3[TH\Pc3UQF?1<ca@M2EIf(-#X\:)d
ZZMKZ:PV\?KaMD2,R[?Uf<0Kf_D[Ca1<&VR,:XN+UCPGJH@g(EU.,60=cC=E>]>b
c^[X<C]\R088@X^^P]P#Z<?9aWYTB-W/</[XCF4>J4-_--)Y_cG#WQ_-d[9(O(.,
0DM<g;GO#@1H]gY4NU(_A4;[^MTd3DS.cG),@F),;JA?[:XEP8b16=[bRc=F]R;^
JV(RTWZN5S/:D,0>XE&6)H=NS.(-Y9GLBFF2LY^DSDH>LP6QFfLFgf0VW+S0@4^V
(L23T7<C?IGQG1<A;8H6+8-d1=9HJO0fTQ;W6.gc9(IG>&H/=+)(8db>(<SXeAS/
A,cCL^T/2/IKAT&:2a\/XK^)P<fKgQJKa#,<5+3\c5KeM.fHVIQHR8/&D_[@g)I@
[TF8>]H5,CFDDaXB=dQ52&_FW60S#D^@2[#B>A=V)#;QNC4S&?&\SHA\Y4JSe.-2
f.dTPC8Z^M\9B,\S&IREZUX8DSb^dIeDL2N^U/4--G5L[X;H=,I]^FYNAHQH(/+^
DE;(3<..TfGS[U&IB@Q6G2fEaZO7-;#5A<dEH3_R@cPW?bU>2#&G#^4dg(7CL/)D
WD]]O400@G)>)LM2^99b@MN;\f<d0#BE/W^M8BJe;W8B0O3A/+F2fHLX[W43@6P;
3J0&IU?I_+HbTUKJCd4f&3T,D(N/ZaY7++RO@7\.8C?P0U^7SD0/GG;3AfdCKZ5,
_H5JSAO=+@3CON(:F5JWZNd9MST?CXb\8fG\RY(93gNJ7R\+X8J],+OKVYW<EV-H
K).9d)R,aZ@C5MXHJ3377b;A_dJVC<2&LeCP#QOT)=\^).^\GKdeH(B#Mb.^E#)(
:0M@>\2Y5^<-8gRX\VeY4d0UD:?=;g&@B@(U&P]_6dcHeJ16&@0a6K7?a9Uf\/-R
&3R@Mc=TDN3I-OI2-dO&N4&G#N=C5Q844P-B/D)6>.<?c\A^L7.QUfF0E9bDgdaV
]#c(3A]U&+.J5GGPCA4[2F5+?PVNR?U7]NBTA,,);d[;_52.N#D<MGcYAfRWI8QI
^>ATYMSNRg8IU^Bc;g0_RSeAUW9Cb8(.:MOAKBAdU,A(KLLY3eaGgX&XC#6[0=H4
c+:X?K@>V\@SREVU8ETO-#/.DHd(=4d+g:-OI,N<7e5U]V&9.Q/2Me7].S?B;XC9
<8Kd^JDS_@3EX20K=B]+R;@;I#+Y[Z7/P@dE?>7C,gEb8SN1^>NDUQW3+.ReGTSC
O253D?-OUdC32NR6b_\A.U8;Q-gcM?6SP1FDJ>CI[_dWC]UNAO,3g-Q^A7CE>HU2
6^9:J>OJ-dCHgT?L^MPLXNgO](9^WOfaW(dMM:>@d_9[(HFX^7P2DEK6;X:,ECKI
C;1PI7+F_P:fA+.+S8YZ7YP3#PIK(NA\8\MO?NOS:W36VB>[gg72XR++-,K;M,@>
dUS\9/+J+cTYKFV.0T(+NU921XSH.f3G+7L\31g<XMP?McQ/2OLO[P1#?_RP47RP
MG#NA9M^R)5P9],J]VNYP-+Y.0NH=MRS=_QT6#O+Sc2eI#MKEBYH_>_B4(PU^E?@
[#?XQ#Ne5[EE.GZ.(V+RgTEPQ4OXeEK_9f3M[cI;],V,GKfa(g&T;[;WX8.P]@Y]
aFI_P#G8\2[K;d>f6a>&(JbE2KN\NRI4DH6W;EIS[.cc^K2?3VF=P:8,UO/FJ2X7
bVA4+AN=\CXCf>2/([0^Z>1D=5[ggfgf=03c_>HXcQLYPgBO+d]0Z_1SIG,e.&Ac
>L6HZ-b,(d.L&a0N^7[JH?SB=T-QTg8;D2?#?58^WHHgJfcY&R@P=GJ4W.cF]?#:
5EZ;(6&G^AdR/?F@Z+&IVA,L=&X#KN\^@]WK?<H/)_#W>XZ[T&M;02c#D&6FDL-0
dH404O5/HF<5CY-Ab0.1U.M]//Pf77B#6X2VEW3@7c17P7TM:,RTB5/+(+U##T(C
H0(QE=0E<B?C?d\WVPODL:f+TTMVcgcYGReY??\Z&g?)YXCFeLY:EXPbGc\.-P#F
<^G#=:^F;bA&#cT]4>^ZNTOYF0UR_:U49gU_S5]1@9b&0BC&F0--a[0@0S>L@-\1
<[O[/DLGWTCX[UPZMcbT8G9-[9W[5C^X^G+=:H<[3PMFCFaX6?G@X>5G9OHe=1aR
gHe9ULEe(XN5#&)#)HYHAF#07SCQ?8\K88caEY:fN)>,e&FFNe6,Tg)bbeYIQDW6
R+(T]I:5KDB<QCKcE-05G\64]RV:\Qcb?eYY_U7DU\bc>1UEY3@WJ0HKTB+f5H+7
UUcRNf-d=-7ddTAN)DEb7YM<BM)G&WW.V^@KP3T&1eG0#9XZ3242&1Q&#G/K(2NX
X.fHQQ(Y((P780RQV096\9=HTC<&3W)6K;KX9c(aSfYYP)F<X7D9VF<cBCEf:D2Y
&M]FV1OL8IV&0_fXOTWaLW(L7V0HeJN>#8c1bYNa6d=;V2-21Md4KA05RKdC0M32
_>2b8=MEcX(8bfD6\;0AV2edM7K.@,=c7GF26L5aQdd>bFR,MdM@SFOGM[X>&:P7
.3^F,4#&QBEE8+;e/CM05,B(NBaJCT#0@KM<d(.=1Y&Q3+&17^)^[<61^MVZ1@2G
5B#M[eQ_b9dG/f1CN?G?YJIGI0F:]ScT4A5dfMCOfCIcKNK.6JFa_42Z=3LP)PRP
,?EEGA<B03fTa2/3MMJ2>P;:]AN4;0b][c0IcKfeVBQ6V,0I9EPU=_aK1OPWaO[:
X))Y^4QRKVT\fbCUQR9bU<+Ac&+3b)aSZdQ_X4GNB\.W<b[R298[[PDIA+c\MeR;
R]BOH-E\d>^QT4AK3J-7DI/53W5EL+TI1/IZR+AOe3<7Qe(U4dC_5T8e.&,VM8Gf
gHM_TW1.;SQ(G>LLO##)K,c>ND(-8PBe<@EQ4[1A][HM_-S72I+[?O?+fRMeY1Z)
&[[GYW#E-g0<:(B#O2F0WAPWL:H8-]3RcA9/N<KgYH5RfCd?;;eLMN+FTdM^EAS>
^Q5(?)BgP99Z=:AS#U;=aW^AQ3->)RFC2cN7b@=KC#?F;e_B?037[Vf?@f6fQd2H
@#^7QWM>aWMUZ^VAO?BZUH)\0OH=SXg)5>F,H>cYXB]0UHZ4#+<?#;_Ladc6^<.2
F5)MB=;ZC[8c>0Q_J>I2Z[H9?U=gX9,.A3<+UQ#Y[7?Y,d^:(63UT(58<[B6G_WK
JOafa&(4e_^_Q<&9A3-FAT.7GH/ZUOaQ7QA=A6T?8)CRA_GC]fS;CdG6e:DSVL6\
b)X\gW39]+-1:gW)=DeWV:@I\Y,T](bNc<5;@/Y.Z>:957?#5Z^[[&>#]I\fF2\f
^+8,Z#IJ\gLW<dM=F;MMH@CI-C74]TaN[58@(^dGWP]I3&QT6Q[HISNNFg_dOH/Q
(aI;.bZ9QX+8N57P)e)K>#GXD:Q4@WREdPC,NPP=;fdY+G&Me1(+-L<]gaO5XM2I
<+cC/f1+^A;K=48<gY#&4@SGU[B0M17[K(#\RP?Gff..M4.3B@Bb1&A@&g#JZA1Q
E5]B)G&9O3bSR:e+^\@=;/EA/-QZ?A>B+c6HG)9S[e,CW&W5FE4d5V>;Y(5Kd2QT
9;WadcY&S9SR&_)))2KWUT?N(Mf,V.f9KHFT?b,WUFSZBe?Z:N/0cAYA_WL^)A7<
L_)O.__)883Q&PD]V@aU.Eg\d2R6GMJ(Y6dgd?YDIdY,6(>5Ff(7(c,aREGS,IU<
_=/f0#b.9P[87f(/gFOVDaLC/^#e=JT#UVO(M7:bL84fgG#e(8EI?Zgb3B8X+c2Y
R6Vc7BGTQS.H+OFEEb>=BWDG\L#(BXB=ZS6&bV.E6cTAXN3KT,+NXU_;g3&9-Q<g
GU83TLX0S)JK_fJQ=a<293PS72P(<G\0Zba2+A@(+=)6)4eU12=.0488.8&e&De3
^:@]2L]05>Rd\+&SSB-)HDE,[T>Zdg6@Q@C>>6Ya]^WA9O#W=eF8IaMOI:4M3<)0
MfZ);4RbU@X>AV,VV>SIA=<=?UK9&H4D0gZ[3eK&GbO]58@2DfL&STAS[7/86GKM
J=>>.==.ebKFC8VJc3;RE973&JNc@6STDR9U7WS?._XKQ4-;F+>bCSW(RL?LOM>X
83#J?3HMde7@,e523N-fV.P:5<-FDK)T&PDU&3,FHJ-+FeX#beOC0@3?R(6RFM:U
Mab<Be/8)AQDB+3G@bdLb>;/TYZ@.J\3PFXdG;\X>gU6E=KTJ?.]=SSF;:10AETN
@PHDd9><&\(]1ccVQIWHW@1=6_c2_WDJJ1CeGf=OXCOO<\:Q)MbecJZN^b84Rf#^
S19]L9-Fc?LF/EIJDLY;6<C==36f9RXgF#:X@c3EWD38H,)LPO0)P&C,ML4#D(?<
f1/WM#eH^_b/2T7@,.7fRA(IS?AIP7UMP>8E2A#+>\1E)H@HV[Y.MUg[O@XX6:^F
Q+&[a(9Eb]B2>gMV.@ELO>7eD7T.Afg\8e#?1dX^^b?51]RC#+XARNF0UAFHTbH0
(Z.U,bG)H<.+Q\7?092/f<F7a+>M&Db+&Z8);]=;Q8WBN8IT#;3@/URe=#X@dF2D
ge(-;O8deSJ;=GF_6W8D2<H/G=.J7I(3[_64YJ^VQ>6UeVVYVWb0g=QN@cFH,Y_<
TYMJ;#4YX.LTI83/d0@Y[@85LUD./LTT6fQ^,Y^ME4?#NFHDbM34)2bL)9FeYDV4
:HU1F.?dd<[IVXd6_JJ;(SVCKHGU3dA&dg,F,)TeaH-1D;I[93R?Ya3M__BDSE\;
8>@]R8;MRV@#<)WRV#X\,E0d&;5QFL-\.69ID9UNfO[e=\S^V@7PMdFK&BG?f+fZ
3bdI(dA]?/8?@+27WP@KB(G<GYH+;DMI(Y>3];K-P>bSDODV@OO=McE8&J/1^6#:
,K=GOXXCDef:a85BA?MDP73AbK+@YVU)IG8<J10^c[X,^EB7<FcSA_D=Y;,S#eB_
>.H>]AR+N0?.e65/PAd)_S\1<Z/dA^WYAgB/1FGBX&Y+ZK_8]_Y0A>SXSZ=gKg/Z
K32gdCF?3490,Af.Q)::3@-P/C7M5#36SPPZ4+6^4FEY[,>A>76^g\?L<,bQM,:7
+P<#1F0V3gO2N-Ia/E12(S-f9#11,=[U&D,e0S>Z9E/>QD-Z)Y,g+\LaBR+I^DY:
b?FH<(SXc,.e,XV([YXSgb:[HA3#DV-^bQVKfA8W-JUK_b4;F=d_(TT1@5g:a)&[
.[]:WE3,3NDA=V8DWNK[H2_P0GRPJ:W8YY>g)fe(dc5R,\?X/Ya=9T\dL=V3[JZ2
X)DLA>U;@16/T^O?aK?.@VaFI0;QDg/6fJ9F/+bM2[O5HaWB&B410fLP+A?5;_>g
ZJC@)0cC/c8A4(?4.50--\>A0T@Wg9,00N6c=60-AIP)GJ-&&)Rfa<YFDC\[CU:a
_M:b-=+--^<FY^;/D_0CBRMT9_W?^^0J4dSaY4VF:S1)/2MQKK=H#a#1X0E3UHa#
AAL:)E#D6R)2EM<8,c083bPOV(ATf77U-8\\?]W_9;6+.PFd.gJMG)2-3-:(^4(-
+f48N[]Dd+dDZGXK)-aIIOcgQ^LAWFPHY6(:3T)]>_RcW151Y&J41ARR&:E<-UV]
ggIM6faDUK8?#X._TL_UJ(6c06YN]UXR@3P6QH_;(LgZWg=2Y1V40OQa0XUIFT^3
_KII,59Q-EQFV,#cb#d9;MLKUE.[ASZ,CgQc-FCJ0P1(A8TMBIGcKUL+BT+=-b3/
1c/AFaNOZ-](O2+F:g450F4WM9W==I375ZEMG#X<[#HT4R@GOI<=/Q&8W^<B)V.+
#?ac2[V+&gR@?64eWB9+cf)gT=Q<]-+\NBZHQg-c>defge-J#.V[0e<;FH&)=3:a
/c5gZ0BUd<U49J>&T@3RJ7SLS#-T+?e1&bOU]UPZ[IV7AC?Wfg,ONgf#X],0.-JU
^M92]58?OcP)>+7V1U&F,N8?QR=<5.U#4Daa[TN4[(1;[0\G.3C(&.+P;MF;-WI/
bTJ4;^6A#g;0)e#98<(ET,.2gJeH4J=?^3:F>+^ObFJQB4aF_P?3V>OTcB3MK1_1
NTE0KR(.gQV6=15Mda7,/G/\Md_<PHE96fD47Y;\RER^PQ6MA,LQ)XQ]ZJ)59)E]
3dS-;,XY6CV)=RdRbb17@Zc?FDM7FDU/O5\>+2YBM-8b3/44MHKBCcL&&0;Z.6.U
DNIKb_7^LOEe],(WQD0JMC2:.#Z^2><g+4Fdg-3N+EdJ#B57\IFK0PZW:@L7LVCF
.P=;f9PDK6_25<KKKA/Y3U^M4^&K]X><3E(-FIL3Y,3H0NIAI3fV:V:bS.XJfPE]
KVbJ2b8=&,bF2ZAc^K0_;(E#PfLP,XTHAIM:9D1=E9(()VZUF+1OO>CJV#7IQXF/
;UD;3B,MPC3PX03S-9-^&1e@H_RLT99c14=]@+]TW>Pg)#^\RT?H_Cd86e(RIf50
UWaZ)\><<YMc\E>PeK]J\b]7-\,R22(MPE,,@IHA;QA1+M_/F6ASf8]&RKU>7F\Y
Q/_J6D3Q2=_D9\dX^)@M4N(H7dGD#G)E7gYGGS<9>26\LZ1>,Ca]6TF^,1)R4#H5
=<Q@fOS4,AD/D0Qc]0M4+Lgg:9_Rc-IWTLG=VF??PRSabD(T4V>:J=)J,Z4HIV1E
Vg?KdBD@23,ZHHG]J-7e5<_O8Q;=V=T7E)YDEK1:Gc#SGaA&6]3e[Z&_MeT-7c=C
4Cg97C.3UBWHVb@I2.^_PZ2>??X^Cf>^+(1XIH:^cMH^5C3Yc]Z@UF2aCDAD366a
55NJd^J\KeWQ(3agfNL/1]@86J;e>9V+D]d>\W_BUZR/^-VR)G-ag:T7MLW_J&Xf
-g4R(DNd<D[+#+g5FU?WL\99@7+U5E6-9].T>E#/C:[@)bR;<Re,O5L233a&I(H@
XK<X,6Ra@-b4DA[gXVJS5dL>cQZ-fBFa5,^;8219fg5MDWS&L)];3RfgA&b0G&+U
eV4:W79UZX0f5/;-V?E>&6JIND0IEEDI?[)X<W:=bcPgU)YU>a+Qg0;GR18<&_\F
R=D>4.7J1]]\ceaYM#15b4WE7cIO_FF8ZS1XT3>V^OY-QV7&-EH)AS5D0b@XR)=6
P/;@]5XX-ZZ1O(Y-KaBf1Y@&M<;6/E)3\:EaK;b7dZG,fE-cA\E12SIU@GNH:&&9
8SdfXBNMcEF/?\DBX<JQC=WZ?C.+#PTTb=,(:M?Z),N;a7+;1WTIZ,fNK39M-.b/
Y8Eg:WY8&\4F13]3;af/9^Id-[2Z29+-0P@SK_T[Y3WP-4<.&FSc_2VVg?8^4&eP
-e,TbO:V&P><a_aEfZJKY6gM(e=-0X9\Rg92#L^,@-P1[UH5&aK/-4[&057Xg3L&
8V(d-Ea\]54V_C?OFV]9bD64Xd2Q_3A3FCGD<5d)#S/<+bdRH=643WOS/YL4:;[@
V3INg^6(;3?M[XKNZ/7^W3THQ:?^c)G/X,.5gT?+AHY=(;7fUEL4E4Ue_+6+@9Z\
VS7NYceI^Db0CFZ-(cf7-WZ^@+W>L;BLLc4SFK9(3>##GN9H6L1BOd@??_[(#^C(
=>:#E]OVDgS\B0KbW^]47IUKfEL&4C3&R59c5bC3)_V8;T.5PLWRbJ]F(9?P1J@R
&:\=_N-,I[X3eZC]\)0RQ,:948EX6TMd37+DQC]#f&=9HSQW\K,=]1EN712ZV\QI
TC1\XG/]L8&:U:CCL.68DMc(-U3)ET&e^U+:=MKCNd;?<71;@+0F4?WeMJ)e4Z^^
O+S-).e(2f5F\H>2(B;D4;Zd<VO&LEYg@TH0c_=ML<S?Q\(T,Z\@BY]:=>dLKJ;(
MgFI;I,M/L7MY1R9AOO?S/GeWW5Tc@8R0>/7>4cJ:S\YT>W98ZN43<Sf[.I_V3;H
RdM^ELAV/Ra8eGEY/7MXT55D?@6=?:IfZ4M?CK.gALN0R-<FQ[X49)gW;+&#S_=6
8=;aV0:I[UP[L50=70dA(^03&+V,@8I3U=]c&a[[8,Fg&3Z&2M^)SbHR6I;f4?3:
UGU>X?d36/99145B]Y_5P[:9Hf,/TZKCV<G_a#M9V)A@HLKS+L8a^OMN<gJVb>F-
L5A58VgV^/3eUU((LbI@/MUg_FNfBLTW<@Q>e2./c#9W<A2M#7S1L=J>>&4R<E,c
+1YD#3<9VVP])5UUR-53F2c^Y]IN(FRe>85e(G+fBGCFU(@d-./;TVFcCdML[T/K
?:0#6@EfX](AUIG>QFB3[fD=aU5APOR>QHTEF@<d/GRW65aXS3[=8\RF_<8]2a?=
OZLGfcQ[9XYIQ==223H^9XD@B7Vf\0?5RYA;G8PZ/:2)<Z&f417Tcb62R[\.0FMI
\4Q=c6GQ^[2]TBE_PZ@(TOb]J9TfRMae)O4D>XH.\72^>)7YPS4K(YgNB\8HKMAM
P#9]D+X/E<=&QHM54PfRX=BG=e20+?.DHZg7,EcgG/baTM/9^bDXGFX/^Cf=MI@@
I[+,PXE3+>FCfG>Md;V]1gV/,c?_<Vf=[\d9FUP-YKGMT)<WIXc+T:R@1GTI)PN^
b6BUJ\#HGMW/6^]J<IT[0bdZP8MY>gAU2+EKY-TIVLCRa/V[(b?0U7)S@@g<UNPK
.fQE&4TY+BedV^M[P#R+V_g/e1]GZ<A1@+&c)7W:>[)YYTYTHFTH]9Q0&#aBC3cQ
:)QgIdd6P=YL2,2?ST5RHVc,OE<QAMW3c.=4/3V=V57PT-V?ZSP:@<X7LF_Pb^Wg
HFRI-S3:]NeEfR]RdWQ3Z[^5X(bcCXY=_^_&JGQSdM?.G_;STER+8Kf[N=[?M2/Y
#C:A;3GLN\J^NHGa7RP(Q+YS=W3(@e<F-cB2dD.V.9XD[-dZ6C<04,T&6?++PNaU
#TQQ:f0O8Y^-)3[.N5gc_JXSC0G\Q:DW3[(Y3L/:\<\4]65Ib(1(<cHd8-B;Te.,
Wd99(8,.21f.FK=VbI6\G4Ub@/FPLTB+=gBfW<E#D74@aK]e#0aX#00CWW?F]](U
eUCRcQ)3F]27,VPg-]f=aAfT(&(02]VF@SJ_0(JaUSdcMB(-VF/5Z+-3dOaR(A_I
HX4MQ;6V+TA4cST:cg976gb?/M_IeGO+M^7H9BUIZ7\KfJX.a>,@=C5OO+eaTg@G
FWO8BW(.#/=&@f@57d,aD;GJ<)(-QO28gIHR[E)LCA-[&>X31c,U5;PFg:(8N.DM
4:QeIJf9)Q1A@1:,JL4:W\We9g?FSA3^=ION\0&6ed(b9[(UJc_3[L\cUME7JAV&
VaaC.G;APRDH=bFcIMU]BX0\4KQP1gN^M)G;#CYW?XZLB-6.JY\;fM.=Q_VXfg8H
F00^&V7=a2.+/=&XA(+;@;=a[CLT<E1WCW->FC^K.0-]8S[4&619MZ=,(8eX6(WX
@S[-F?;T6ObdFC\&HTA#BRCY,(M2H29BFJK\(_1,5X99C+\CF#,.PG?3)WD8b94.
fb[0RT]b;MWS7bRNV<:AGLgIE^,2#(5L_\OZg,#2f--,+=1a,K<C4OgRWRa(TUZ/
LFDE?XNge6_c=RWXU:&b6P(SKAU>6&99N,(<2<.gegP.e<g=LRg9_/-^8)1B\OJZ
^8>#8g70?KDCH;3/6EQCbgEa8WYU#e<M]0FBN09<=MaV[;,fI=daaB9HZ=:Ca=K4
IS2_SWCDV81PK5RP)IU8O_Ld/e^//?d5Z5HF\.)SZ91;9R7@NW-;8<MN<S.(-Z80
1<II0V?P:<V_HWIf4H?;2T?(Q;0=:?YBYRUC,I75[D8OM3ZW-IEW4ObN]U3//&;3
3D#2MI;;.9&bEfH[S_G>SfSNEVCZK]d:-F#4-?5-:&KR+d_B>:TbW@OA>R3&+=R;
UW:CK@A:E1DM#1\BO[O7#:0[O^?HAP_Ddd(IaYb<QBFA0WUOSDU@_DGSXCe9e?@.
?bcNA(_\Q5MU-Td@@8?+RW.Eb&X4f&-K:MDU9HHQ&[d\H2UZc[c:OKUHX)K?6e(_
@;5RD2TO,Y7F_Ef,_R(W-F8#^L-1SIN4G9&MBFa4>7+J=9S.)F[&+OWO\<S8aL4P
=Z7M-gL/aK_-f03[f&KFM)1b]D7N,_1<D349,L0O&C1^HAcR<I-d.DbCS7DKB&P/
RLb,5K/7PaVe=3O@:YABc;#@YO>-cE5F[;?^b;QAF-:(<.3;KM#6\>X>WJ7(JBBE
&8U^Kg.@T9R,cfU#&#0_V5\RU>/<?@US0=59Y/fCe#?bBaf\<7;>SZ&MBP6YCU):
U;YA^XCO062;^)?3HPB)^IbWa64GH]:LAP4&f[A_V@ZG=R.Z9UD>4eD=38W>J:R2
;[8:Xb.5;\;DMP_7JMfJ^J<g[6>&9[+e6<+)5GABUW9M6;WCG+da-CJPH18[_TMU
gTKI,??eL2/,H.^+G<ID&&FSfFL>+:I.YgF(@3g>d<P&C?J1]/D8[3>M,8(8X/OI
aW^V8Y;5Q_>F;VG\^F-9_b:bEg8^[RK2)CO\+RA1C\gcC(5>\aZ81/2RDHDRbVS7
CB:SP<Z7Zbc/D44<d7fXc;QeL\+4GLSQ>P[FG9D61:=CE0T_CgYb>XPbB5^e>2Wg
7;^J>g)&/AE[<;ERXAdUIUU_>cA1TJTRaE9(]I#H17aG\+&]]8?FM+,eGIagXXR^
aSW)[0&ae/T.XQ;,Ic5(#)BRL?(Z#5&WRJ\@#U\:Fdg](dKfeJ8:]Agbda3gF&?U
\D4E2b2=1eG>:7@J+^[-PH39_eb/Y.D/.J/_;\T>3_EEI&5d]V\+<I]Oa.S4QY,>
>)<JZf8>cCf9:Q[M9LDRZ#g1c;g4I<C&+V9.-AHF7<[?&7.A)d)U9VG@Vd;7VHP#
=A@(@;]M.;[==5/3EJ(gJ5F(=a)+(5775&R=F#&<1B56X^YP5/B0D(F#(.ZCE[EL
CE90^)F4LOK<a,HD(B?LM(Q:O7S&)5QK,0L+C>DLb3T_-W]dV?fe#HD=LSKCIdN2
aXQcTKBAC<0V22?X+P7<CgMX=/-1D]IPSU&Tb^:4AEIRLIZ3.PDZ],\E>(LJ(;f(
Y[)g^A,U4DE>e.DQ(VT.>^db@OJ]#XTLE61e9)eCQ/fLGDd+RCXHB5[ZR?-e:?f\
OF;/P]F3@:^RMVg?F#LD(J,#Xe?R_H0_A33^6?4X)X?fX7VJa<D@57Q8?_PfI>U-
K0,-2/]QcJ4e\JOI2FK3X<cd3,8DIXb./1J(Q\3FGB?bR=;S4QNa3\Xa0KA6?d-M
P8[96EV(\XQ^7D)317X<PICQ/;Q3F,YE;]0_;c81[X;D-b;V&LV2H+65HPL_1\9<
cXWS#?f24VHR,4<dV#V6:4O/UV:HO\.T+?H]3L@CG3@fRW:P[+\?)6/X?V)JD)55
1Yc1SS:&V):[aFO506XBa72(D_<^>9Ib1L[ZE>@B3gOG/Q:BL)#G1a3Pc(f2bS>Z
?DbCcP5;UDIF#8M_NJ92a70S):?M@[^ffd_4d6eSc8^d-S]?YQ=d>TR7L#\ZX8H^
:>LEF)P7OBPg+C<O6^FcRIG;,Ig:U7.HFc^EXF8XAf+XgWZ.LU,/,S#[gIVgU&OH
TEbH+9NH\4,K)2&RdML?GF_7@21F[=US3?SD=e]82SLWR8N<RJT_OVJUU>EI^S^1
B]_].1S1<Oe4=:<RV],:,@g9H1XYRJ2eC:/=SUO7#3W5E29=G@_a;J_O0)J8gcaB
KBcFPZ]T&84b-_@WEeRVU&<V^&:C3BDS,EDY1d5=02A4A->KW5M3MafcWF0UNKf3
H<OF3,]_@Ja00M7.g5a_(([9CbKI,8H#ReFO5F>CD_&IMGCF1QfMJ)+fSGA/-<XC
eYF<>@c9V1B(&BUd]H#=68H7\B?Y=:SKBGP[Ye88.:7gZ3ABD-U8F><JeRM[2Ze-
:.)Z+2Wd>f5.TO3GVf/[:f>Td^=HY+e=1I)0Tf;=)d>Bc5HU[D+4XN46NHK:A]FH
UH+Bb7]G&>>XE6g[IH;\U)_I+dLRX)LVZ\@8Z55<\&^f]V,=U5X@@SV;K-31=a5)
PdfW8>P-QDb-NeD?&/N:B88ZA1UU+=WLHSSg</37R[-fO()1FP+G4Bb283c)PW01
5SK-]a1IDRCRIX[W>(>56XI&?(_U@Vg0Sa(/N7H#;S-&+FZQ&-CO7R.MI2bd;7;5
+R.C8V+P(_.HcT1;K+YXa/.;4-#(&1U@Q\.PIF>?RVFMb7/&[U_YWCJ-ID6:/L(3
^38[\RO].&MA10<^[7#D7/ZVL(I;&5c5\Xa;\8]_CGR7aK4cdM+A2A]L/>R#gId_
AaW=,/gJWaX32<P:B2?3#IdCDH6JF&?P0FG-[7.XQN)ELP9S0FI:4?IFVY2_H_^9
_66QR&S:N-7D):dJ.Yg#XSBYT4<RWL<[(3YM7K=\3_=c<#+;1O2-=XgB\TZ_?eb,
7>bUdF1G+d1V2bELMX>RQb;@V_B3NI=->FCF,KXEN,Dg7TGFYF,?>KK>0RFD>fX\
AF4:Kb;5QMfXG:6DETgHDYLf>.;YDX5<<[[^C4e^S3G\AQ3;,D2\S=WbS\8Af88_
GZgWC9S:(aNJ_H&cB4UK=51ZBPL.II59.Y-OQdWfg@..fgUSGF#Ld>2G)(WO-.3_
XQ2bId00#OM=ECI^N.e/f6K@[/>IDCH,SY#2XSWGa29D_0C-04MGSO+D2.FQbF&b
R?T(U36)9YfU67E(@MZ+@0ZgL22Ge]CeY=[&_UGF,9g8CB0>AaadU3X4N_Og>W1S
S?QP8RQ\OKES)05P=2g,AV<8KZA-]0eJ1Oed1LCP7M[89;<<TYbOG,P<V_Z6L-_E
V>G]b71:^KS5Z8N/2ELD8,U4RK8B:R[.43eMc78>_ML]X7S>B0U<AYZeE7&e;UGT
Ie3;G19,+EOJ2;R-XF\3dIcBV&F[RL);3RN^D(M0BJM&=4(#aFa;@-[#;-EfRBWe
Hd:H)?=XLTFK?XMP5FL0&N@c9?V:W^KccXJ\a4Y,\I<c7,F&Q7,GF]].F,Z54P(L
[(&A-6dVR^d5Z1(MHIY#(G>/f[GBKR:A]XC.NfdC]25PEJS[NF;6TDaWSP5LL&_a
R72SHdH^G=f&HI>B;F&,.LfF<<T8>LgIgD?T(^&HQ6@XTbSP4(^RJ/G5A/D-XUOR
1]F<c65?\Qb@?](.KEP.I4Z^5[HeO>dGYW])cRge7c_\UIcBGg3[D]+J-FUGFc2<
\AJZ0_0AWH8U)IQ)I/4GF?7,P>dX@#N8E^#;(c>9aK4FA6-?ZRg#=Q,CIg6?A[g]
+ZU:4V7RX:Xg[XIg_I.M]_)/;E8Xf-e]THd,3OKJ7\;V&Y4dDa(bVEM?:3BOW#dX
.SDc;L6D<Pg(7TV8a#O9^.&^=g[fH3MBL=gKf6H#73[XR:6MA]S:W@<&&+:TPI-W
-1Z+K;<Y583NYK_V3b)I+JUPY0g&:)//X9cFP5Y;RK<cM_&/)GY4=F]P3=Xdda5D
_>bKP>ddOcHb[U->^59HB_T;7GRJD0\8dgBfSUO+VaQWZJYW]HG:\_)\@g&-3YV(
f@A0Q71S)FMcQIR1A@1:KSc#0,J,156RMc1N8F/+O0-O5QMHe+X7YVPObT/Z&8D,
cfL]IS65Sf>b9X/Z+aN8:B6I9)1F2eW3KF\R1H-ZJG187+eI>d^68@eJ\-F<ON:=
)0MZ.Z2F^7>J/HeF)29AM;U5gPSAXTFA>_P)_V8X5HHHPLZF>^N@>VFOgR_W-.5D
)&fNUQ.I@B_[0eCEaPL?I6@&3-#14?X1AIJGbA\T8JU?KcL1>[EQB<cA&@F:\&0K
Q@GKW1[/HXc;-82BNI[LJV>f,5KJ^G+2[dD7_YGeXcKWIgaOUSA@#W]#-50Xg[Of
NWH)DG>E-DcX7bA2SS?c\Q8f0A-5C9@ebC)^C9Vbc>,f,ZN>?[gK3FNM1Jfg2ZFN
,63WOfgN[?_@JdG_0W;=]beM^55FZC/\J3F^9XVa7bKH[3JNRG^E=U@<]OR^2&UD
e8+b9])I#A2KZI@g6GGEPPN32bgJ&XEX9>2[8\:UD,M..):fWaECVV##XQ+BYE3H
3#5.EC&IEg1WgFFS>A_8,IF.E]?I.8d1f0X:292?F0\?5-V4+L<ASGc8BaX]E<+@
4-&&AL.3A(a4IWcMeEK12?U2;W-2Qb(&T58<(FNT4->:/#P@-fR4RgP&V]C<5M9L
De@UKA4/0)-68FT+?bG48GJ9^aH8;6W:H?9)V(#P\8+3;)fF&5D@.:6Bf/9GWY]E
g.AZD2[9>1-W?LTLdPcC0AN77,XJ?@A@UaeA_]_I?<<+6,88P\d6@DZ^)9.cKXa2
b_5WTB<^5[;PeW=.<LMbaDeV.F0K&3^fPY]b_>)UAY<Jc2e3P&DI>:VcJ+71.R&e
M7G(,=G?6N7QfI(./:UK]O65U98D:)UK8c-f5^NcU\X@(]Cb[QI7MWA:,^cI^F]a
T)LO#?)G]J)3b=\YGg,W]DU(_@?J7:=>7>cR(B=0H2dPR;>SJIO,DLd,.0D:\,J]
HO-;@>gXbL.>H]6O(UaGJ>X3,P\Q:<;?H/[H3<LdN^9d.2(+IO5J1\;g=<QIOB;X
,[]XB,3\<NY<?)J==4BbIWXVKT2>E(Wa8@YB.V=BG:QH]0ZMb?A:E]O0;=..[+KE
,]O+(3G[_.E@@Ya[^.&3GbU]=aP?SMUF809UR?-YYZEW#aJa6TOG-1Q?@6CS1TS(
5J3M48.QN&8Za9>_><(L::Bf4<5OgP?M1KBJ1G.Y/7(17N&/#c<GZeaIK84TX6f-
OB8G]Y:MDIO@,.9G<gd#YDBH3[;d]\IT:8]&P2B=S)GNS0-(X0IaK\W,(/XA,gU4
PGZED0g^Vf7=5U^O7/BS6]O3-&I&V6H1ggQ0(\45^1[ROf\4Y+L][/[5CW5S5D-O
3B/Z)g5\F+V61NWSBRY_)_TEOUW&C7>GR,-5U1b.=+a1,KZ,:&@A>W./479T9g:8
,PS5/\XA9H6QN?[BSg?03(E7QS()6];>.^=)]?_ES?484a\MMC+A.]JEb4EYT1W-
,4a?E88Z[<6?CQ91(dLeLG;Uc)]/?4BJLSHO@B5:Ua-=X:+cUIRXF.cGF??IO+H;
\)JGSbdYW#(bZ[^Y,7+b?FB6e0V<YKG3)G)L\PfH3I7K@I4I<=XaP9-@HTEDK0[#
J<PCQc/:<?&IH0Q7D)cU;_/4)(EDCA7<#1CD.I8QYA\8^)=E^8BTT[>cW<.^3FH.
ZdEfORY&)0L)UVdP?/D0AZ8cK7;H;?6V:037_McS70,<)#&V5W?KHGXcOJ4XcAdM
MTSE5fX8X7Fac=25<,;Ue@5F[)80:YO/4db@-]XJa=@F@+LN=&:3C[I\/CL(40TB
;-Z#FV[CYJ7ABA;+;:JR^a)<&7+EF2@@+6fLfRU_2^XeZ+Q;e8G>/<bR=KEX>5F)
>f<c/1;Z#AL^?KD\;G->OVbA1R5><5Z=c<.Z=1,GP(V3_U8dU1KH[<HH.E=7\gT:
dVZ6Q/4/&P@C@g&(4=b?BQ9:GeQE<8N/5MeV\G#M\7:T7MR(GFY.\4\5T6+gC6^<
@0^-Y&H<\X6A\:B.I)DBHW8C]5FONNe:HIR?34Z+A+aY.0Fd.XCRdF6N.bG@-?M1
\,eT<b@2W^GT\N,ZG9#GM&dDaD/QL(,)<WGV8JC[=4M9AQT7.FLSXV>cN-D6FK,>
/2f:X@V@P7Q5bINf3JHg/^e3ZfOa,9BdGYB^\AR[1:VG[RUQKc/>J-bWK@W+9Q/Z
f&K@F;^Be0fPG<(S9bIXO:f.02WeT=e<7EU]E4JE#^1e9+L^#8^RV)(#EA[88Z;U
(/:+S+]MY-KG(][8)LN\0W8WF]<]WSYHg&,^B6/#f#L;VZ5WYQBE[+8PUdQP#/&H
,K/<V9f^3JI283e=+NX]]M3==2_B=T@(c@XQ,BJ6NRBS>fBOE._3RT\&K_D-BWSM
A)f0X,;;[?]\&R7aDQCCbfd<D(C@9M-_aHUYC/&S_=0\eNLPJK<FA(Sc_IS]_.Q3
0&][,Q?4[@N(<1=DHOW+2:;:MY)USf<a?9-2OLYT?.7ND_8,>-)JYB@K6S8=5a:L
XOV+9IK,8[]c,EY6F)&bYQ]1^PG(@179X1@A.3H^<f+EN\J]NPG6Y>ACH(Y9VDfI
J&HM/gLP2TX-FQ6)0EgO0c,OWJ2Qge+HE743FOD-18c2J]AFFTa\[(M2.&+?N5Ug
N71FE0>ea,-<:I1]5DE\(KTObF7=G#Kd8)@ZFQ46<Y?<1f@aOILC4TaV6+&->UQ4
.e/]PMOO@U_XN@+Y/5L_5&2?Q9J37YYX6+c&OAS-RG[\O(GYbVGX^c6Fc7-7VFR+
/].gSRCeK\Ia1OZU97DHNFNfTbJ-:=cfcabC=BL7eLEc7],VcBBC7M#4GZ55+F+P
WZ/1WWa;9VJ&cY\C5ceB]QHe^_G<0\?JF6.PKL3NI4g<59(^fP</(-W);]R=.9fR
ab(^ZS:(M+->+6)S.2.-OG\R9=7R.R=^W_c\R>K=.Fc:K@JBL53-S\_G-,7]I;dB
YZXLf:=:.)1P[/>5]Z?#&IWYP<&K6<[=DB:1_9Fg2UUJ4B69)Mc96cEaG[9R9D[R
,f-a2F:fLcD=/CJ_e=^T9A)#0BNP49.-.<\-DYY@;\)be&.^\QY^eB(LHRWQegbD
__Sa:I76U(gJ>8J36T)N+8SOfY,\6+A4R8fTa&Q[FR);<0[Gg@Fg+LE:fG40U#J.
ca6[26S^HC+;K_P+..U+LMJL6898GW#AZHVW4g4ddWLEdM#B.WN43g=g+3FU-?A/
eBZH7^@9EP]\:QK^f[T(FYV[bEEc]#+-2,K0<0aaK@C7WS=C4<LZ&I1d316+?TZ=
L_IP?]JV1G7,bQ&E>_UD79(]1ALQKL/\a^U?dH3ZFCO^6(J51S8<DbJ6f?)T,N=-
XM(VbZZ(f=SA+1&(&OfVScXSaf-cOA-WW_+?SZNLL9N#\W<C,)^Jg5GVO(SWP0;F
JgcB#90&8J>)7U4[BJ@&1/;7eLbE_]X.1Ca,fG7]7FC[?-FV7P&RFfR@,M?)eUE+
,](B?SCJ,XO^,2,AfBDfVAG^\2MD3gI_QN9-gKFUNS,c8;Y^d;c<Ja@cBFJddP^5
51;U(0/I4PC&24;f./S3C1YPWU,4+=/_?#9cUJ[0.6XUXP>I0PdHaKY8)>L0BS5R
gW;G?TTJ(a:(<Pg3-UGWZ^=^Uc?c.7[1AX^.+AaLG(Z@+V@c\B(\IgIPT2VIG^H)
E8I2I+1+F&Hd>I\Ed=7BfKN-MNG6)#94@]42LFTH#LNQ5baF@+39:b9@-&dc&S_P
L/bH@T=IGHC5AXNa-P[a.T(PFK7aL\Y1:PJ8O#&TW=c/^=W+?Bg7GH:::/PE[Q-e
=QYcC=74ecKPG(6RREK[GH?0M+/-JTM[Dg\WcfXTWXRe(@KP.<e5C:W^^Tb;RBOV
8UK,+L+Y-ADabT0fQ-H?E#A=Z4\##2?G/I;V[bRUb+G09HIM<26W(\985X8-Q\4X
fa?>:&A5+>U^4X-fJO-(XML3O#HAI^G+04@IZS(MdQ=BN2FbaL:)#V)6DY+@4V<B
3A7fMY/F0:fSTePFNM,)XI-NVSO^.RfTc&>+7=G7-]Tf^2<g67Se,<b#Pf32F30T
4/B]RKP_SDG2IDTfZXXS+48?PP8\+?GH=ZaY<9(a(8ZB,Q.O[VH3c.A-OXfLS\Ea
Gf;9QU;6Y\PT^N-XP5P;.#IM6LAf(.E6OBJ-DYR4)c_S9P>,gac)0=_b]^N4[,,\
V6GB2XR.NFQMZ(5^3V5-8NR]41AP+VL:17c^?YGW2O)UD-?JFF=d?FRg:N,2,D^?
0;fI]A-eXBV1;A>0d/IS:N@7TcfZWAaT^=.Pc2E6B<)M=2Rb</ZMDU]98^[\65>8
PAAC:H()+@4>ggW7TE+HY7W>==F3dU?cHX210C@IFADdE_aV>0=.,B++[/_,b?DR
S.BZO.+^4.>Jb7RQ#RAcSgDbSXXfc81,61<b1AD=gRW3aGNW<BU7ZCeL]Z&.2HS:
0@4L?3I1C4GS#G>-gO]1g&U;AA.YG&UAJ3><<>N_XJVMKb=>3PJ.BJe;I45E3BUR
aN\S)Y62AT[+[M;K,[f:\-4/N;QafW#=1+J2Y5/85.5_WY,?]S=+K&[XKIX+I#-a
Fc^6;HB:Y\8_PP]Zb7Ub]O4R(2.9)b+Aa8\;P-:H-M1Y,AOg(?HA&F&33;fJF5FU
--F1:Tf(X(-dPQ<gQVQ[Jfe\HRXKe4>Z]0CaDeM-3_WbgKSb@FFeN@?1JIWP,^S^
Zd=23\T9#6O8CfJHIYG5HMY[-KFaJF##dab-fC.&=01&#MTOVLDC-O2JE1Q\EEVU
K78J^ZFS\_0c+aIG[P,#]TZPXVEF^CF\FSWU+ZVGN(?OeP@b:Ja]W5E3bY:+&&AE
&L>Y9+GD3-[5(8c6=]4_a&S/A/)\L>Mb0Z0A^\;c]7eX=OY,,:8JW/gGD51L&USK
052<X4LBE/bF3\EbK;IQ]cIADC(g\UMA(dV\FX0BR,6K-ZG+@7QgDO<.cZV<F(LZ
[+]?\ALg>#KDIU7FA4,7:GPB->&[IE35+/G7U8CZ,T46A2OI>R6_W\)KI5,T1DE-
,TV:5d^Q@_D-SSKGREPJIDA6Jc[ag32G4[OJa/U-S7#65H\&6C8U,a67.3,8feeg
\CeCYIM,Lc1#DCKWUHP(IYD(;9PLe(5XW0\558+L0HTXJ/HN=C<GD(+55V08<_[G
+HLB(P(ATSEE\5U55a<&f@^I/^8XI1>/JWc\U?W6ZMd<6T&F#\_=+C.,/Z#OUT7/
LMb3D<@^KM8X@Qc#,e&6>SKdD)#(IZ\+c;)@ZZ7];2N,B+P?-\7Q?\ba&?J&DX<2
ZZ;==e(SB6]F#d^P1+9fO.BBV?I@[V#ZM&T,bWV8b@(L,:cC4JGU:;E\MW2[^Y(O
a#QJgR6?f8\QB)>ecWC8SNWD.OMFNdK56T@CF.X6]KE+:2]T9G)\5^8VC.IT<S_=
4c#Xdd^,8<E+g@R0+5f8.8YV+g>\M26SHAM=Lg9(]]=dC;5L&Gc2\)+:@RIgZ?;C
JBYXM&\ZJSf5Ha1ICaKS<=64][?F\gJDaR#;d<XPc8c2_4(8W,&g6MG9>4CXIP]M
T@0NJFGHfKSHI>].NTbGIC_PQ)2&N,[3UV^H4C-bY=TUP8=JGf08YP\HdJ8#>EJc
O4dJ(gW;2?\4cGL16g:_XJd]+]&VY8(=#=ER(,.FfE&+ERLKJ>/?\(<3G#<dQ(-e
a@Ub4,,P6LX8g7R:ZH@9c7MQ.K@@>RSVdE^Na.aCW\7-VS[3.AV8-A8KUN-Q7MMG
JUV-R:c-#e)LO00(21a=Gb+\+H78[98aMV+CAT6A1X8PY4GWC4\OVS4J=-bON8cd
:NcU8XR>V+OP1Mdc>;XGN:7YTaBf?b[9RDW-6:\1FcZC[56B6K]1&),gJE>M(GO+
1a,e[LAYIT1,\V(49Q/4]W5\,bBHKcWF_?<99KDIg144RN:TYfDd=57dUgLf&_-P
?F[JCY&WL#&X+FUBYKU8dU.W]ZCXCd&G81+<BOOL.<g:X27]HE_?:L@DP,7ED557
@V^?D)f-L^4=O:8-1_&R+M,_6+I+:J<BP42@)IbK8OUJX_GHH[JWdFD98e6YK@g>
7B.f)bX,\<N@6?H3P+5Fa2_<(TG7:BIIMH3]BV&SJ/dHbIegW+73aD3<Q@R,/^QF
[76fD8S,/L?7UWJ_QSX<G]6+2TV=YTEcdLJ.-BEXLCWL<)Ndc)/b698gWI^F=AH[
3O>98O[BJ+0e8N:>]))&UPHZDZ_(6L7>NGYIL8R?=dL,a(/O(N0DCFAAb8.;+Z&O
RV^I^XcR>,0B51KXGKYa#ZHT9ff38.14PZc,5(d/9J8_H5B/U/+)O1DRGTAZeAP2
OA.//4Z0ZR-8I@ARQEdVBJAN?Tb,03&OZSR@ZAT;EH61^GXNHV2Z@[,Eb^LOL+^P
.RON.BeeQE)B96&(JP&@/56Bc_ZT3A7T<8PE+:5C\K3&g=<fT:@P;.^Xg-^;.WXO
\5RD-TH;#5M[WY28M9>RVS[/W_]P6BRD3;&1fZSDXd]1(3JN2WM+7H94_)E>GRDb
D)[LH\?\H#6@21bP&(KLP8]UbGQ_8^9Wag#cD>AVeO^:KVJ<8/G9YJ]3BJcP0gV,
#CD80/(@+[Sg2:](2+NR?X]QF-29];4FN#E:-RWR/>].Z=,W&Y=0\]66ABacG+@K
4ZJEP>._,;F:S:PEV:9)JbMMXEgA38\Q05Q(U;@<5RXH6Q\Jd>IF(_V\Q>JV;Hd2
]9I[=A-;-KMQLVO?\&523^.N?72VeLJ<S._F(^SP?=&;50CPN^;7&Y;W?(;bF#\6
/VD?O)H9#JH])4+>bU;V8,B6[B>MC/(J&IF3aD6-S,+TZB#[QJV3OEOa;>BS4D]V
/(CHGf=H02N+GG9[TGHTJ2f\^VZQFEQJRf;\.TGC-:Kgf<2?I1G3@XW&,Z&Rd3XJ
<(SWL>Q\X#9AS#&8NUCS@(fO83.0fLN;GEbD-#1DNFO\L]@W\.O&KWO>L,e:==d:
;;9/@HU]UR?^(PHNfTQcVbC1aFHN43b7+SE37c7A(GFH4bQ<]1.NM7CLY-MRBWe]
T3=U]JTaY>4MN=)/1=WL=eQHJLE.1P+gMeRYV/0/Dg2.878U2GXC_L=@2ee,gXJS
c.0G#.QDcBf),fZ<CLX82cEKK9BIU.X;?RDc)DHE>B5IDKJd1>+ggB4K#V:gFX-@
MId6E#F0K=7P9M@MDJE]d+#c7Z8ea):dcdZ_]GO8?J\VI]8,@)0K1bQ-;,?WY?^Z
+W[+QB2J@aC8;KLX-If=BeZf5^47Wc]KH)V?:cQG;d8GHSRQ1ZP(<X\3QG490L[U
LWBVY7C9D8GW]D@7YcZ>7X39?G3Q1NDKM&>80H\[1-T.KLG;C9;D7]3P.;&-A&RP
R6E0M?YQH,E8CMa[/6Pf:K&3TF[^JST>JH3U=K#KN9-,#F.SK/^4e8TTY59RY<gf
b&):IMR8:caVdKESWOebKA>+EZB[NeZG,ERD@Qf12<#3M7+6LBdQJK2>Ag[TS-+C
XE_RQ9-)@f,bK#gK7bZG);4^T7)LAeNA9-9WI-=3K<^+<5J]bNKR;D2X_3XcFg\]
]GKW+133(F&#.#Aa1F\R].[J(K-FL^T?(SZa399,G?1VR,3S_:,=2IC/aAE\;cLQ
ZIOBaMT\5TJ6[LR-=NN>3[64Q?-GNd+U\8g3&8EOQG&;Bc(GdXFPBDf2+4N.f?^(
X;W627@L-\-PSe,5AJ)>Qa.]L^.cQd7.<GeL+>(9cf05S[;d:IbU]OC>a#^;MVB9
<U7,R].Y7]W5JEC]0>^GPQ/8L-F]-MU9M2I>Q#=?b0XG5a)2TI?>dW(JNF[,(d5H
NUXX^+]5@S>1f@+I8b505OW6@BccN^fb0(/#VH#1H<a2^W)/\(UE+S?IIMRBH?R3
[?FG1<Ka2[3FGXb6V^OX3R4[fE+O;CWU&4W#@>@7gTPR68^5JWU0JEb3Q7O5=M;,
T8L89e&Y/+-Gc3>ZcXYK]KEO5I8LL&(a#E+B;>LAgR(]?D/K.>SAGJNd<1#<(D09
#SJT#_:P/Nb1,;S[^T]J<@@5.8_-5+b/+4-^^59]F8cNDGJFV/V[M5&]2#d/+WLK
?P+?D_TgHF,()WaFJPaIV)B9VD.f:+/@3/4>FMa#(H/T?1E?//CcR@.]EADUd+P&
L^\ONE.18(_6(H1P.08aJ3aeb5Pa1H5.&-[cJI?P,K5FG>GV]=P5f6HEg@cX+_:(
gTH@M5;;=9=V3C6N_[[I9\.5M-BF51SE2=7^)dN81MT^90R?L\_0:A.CK3Z</J#3
PJ:#e\,@KbRH+A[<S37^J\1).Y,7PC46e92_7[gG[5CQHCP,2Igd>S[I^HDE5+Pg
b/)_^IQSPeUZg#bUVHgX/L5KQDKQ/IOK+];LY2bTfe@7,M[0.]?D\1@-U:7B#\/#
W]A#EBIcE8B#]&DV82S/0S\]D2S:76X>E8EW#ZO44dV2@GEYNJI7-2bY-8\EW3T1
cSN<3J)@CTf\>.P).=#FM#K_JOCR&YDg2^\4=N=GA7T:1FSD8E.Wf4GP-VEB_O8c
E#OW[.>J1YVb;D+R)UWRY;?\_c.6#RD^C=gJA;2P[=;NNKX1g_48TD?<8^0dc949
>7)@:Kd_]6>QA;eE#I?C..TAc5ZAbb[gaVS?^X.^CM@eEXORFKF4X(1O2ZY=X9Qa
FWG6WOITR#H,FI,3UeHP6VEYUY[M:f8_HN._-b1T;0U5L#=E,Q2ZP-Xe4ObNBg&G
3+@>WaQ(_X43ZK]Y).IK:a;2:2BU>?UF96NT#eV??W.<V.cT[M4NH2Lf8eI@cVYS
YfKMZ>B8<GUbI)PAJTI+^]DSA9Mg))OdIdDT7Z\<28R3<_?bBH>/1IV7B=C#;.eV
H3=K]O>P8F92=_]JT>-F@>XFGX/f\&3;P=&aV@&EH4dW/EUJ-&2J&#8(SINDeTK9
J]\&0G-QPe?3H)cgG/&c^;2R-b4Q:A&./TG4,T>E3V=,ZQY_7W/IY2E3<79KaV@+
\3a1RR4UfKTQ.&@8;-2d00f-+gMCG_57c;NF2G2_P+BR=QIJ#;ZZ_2Rb.MZ#.KC1
_\LE\93A17^-Dg,>NF6NIG/F=X[cCZUOS?VbQ>d_(fX(VQRGXI(W]^.59BN:b;??
8e7K==\LEYU_eA2A5f)aae^&:dX<cRC@Vc-8_;WTRCK_]PdT+.]:P48DL4b-W4Sf
S8X/GWgMXROK1+JTd4=M#2]>1b,8fg+-K(-3Ba=RFRD>Xd)Q7eY3RQ(<#L2d3e\>
3^FPEA&f0d9:.BJFQ0/FU#F]P/PHH])J-)[1PJG7^d#dbOIX158T-3\)FMDP>J=S
.P#g+L>Z9C>>F9>75J-?1^UDQ^\C.NDc::dPE+JEfgLK/+BgEL6_:P&e>f,5c<b/
X9-&X-De9&)YNU[VVV)a(0fLKfKL<V;\[a>8e-=/M34I^WXF[N9[_X?COc_cTW47
_M7-XD9@T=0ZXHQS>_fS(^SET52RM-SAV8-GDE@;P<2dRf:D^JZTWU.@]X,aA4\e
8P(K+Ld-E=K;CZgZ<d(@J:9#c;cG>H[^0]Lg\3^,BccKX9fM0;cUJU3BcK/Dc)17
0/?c^bE=&7gI6<K0Y:7P4Wf5?e;Uc_@S4T8>M\SGCM5]?,W^U6=U[WO/<B_<C9_>
2OGLZP</X(ET02/K[fJ-8a3W7789GS./gLG,3<[?b#K.T_D+Z5+#g]f0Yfd7W4:V
J6aJBV#\A6=JX/ZA9Z&S?@X@<_gPS#KN+G0R#:N9BG(]34aF?/5fSV/&4W9+Ib;_
L<,F/:85)Re:c5eTG8EO=,TFc?OO0MCZA.=7@66;Q#H7G_QGD03<#^6AZT41&:2c
#8G7/#fcbeJSgPZFH.N?e&cCC]aQ+YORdCW0RPZWWYNYdGGM;6<dg0Ab3I>)3Z5S
HTY/(HF^G_>Q\3]-Q>S2DdO?)T\cXPee147#8.10SSYW;+.QAgEQ.16VGB,Yefbf
2_+:GX17+FaH^/_Kd.IKX1c7=GAP989,N?9O1c,2+fcR_/Mf81IS4_5^.SBg5L4&
N.2>0K/c&KES2-8<_P)5P():GfcP@VH0?-JW-=]UaOgIQ=2;ASJ43W8,/abQD.G;
a^[?<R?>&&SWJE.#:8TA(GE:(#5D-T1e,[0UETd(FOS./8]PAff/7VW\H]NSgF^c
d;=^H9YS#O53WE2+8XIUINf+R(E(\Y@;/5RDLPSK,6K>8P]8U9[[@JWR<aV_5?+.
;E\faLbb3T(+7[ES7,@_J]a80GYT+&d)A/.H7.)#Ye4^Y_84IH0C7OeGG8)2@M8<
g/\3>)8/=^Y?_KLSYH/9:ObN3N:[6Z_7W2AQMOTRX:6?)I@&e^?g8D?U?[S<0F0+
V<a&U,UEf);U9KOJAT^[(e0=+X\QWAQ(<0W9NfEJd[<2V/.]8Cg\2TZF((2[F4:A
cM[O2LQNT<V)e,F-U9LU5FWF7T5[\=)ZT&TBc@,R,O-QI2dBF&ZHM?eOYe.4Ef?H
N.2JD?B@R\7.SK4agN0dKV(Oa2fWe4g(cbM24=c\LP<1g19)3H1V,W.0<[MV,6X=
;JCU/PaAHD)_]OGJ=;AH&+[?-VMT29(<f-M6RUU,0G>B_?S/)J=#90&O=H]5QfG#
0Jf]T[,DAK;6f<I?A<IO;WZ5#QA=PCG=V6A7O8-=_0L^V9C<+D4-826Q8JBLJRBR
_DAFfA)MJLe)6H]R2/8D#D=4d(\DL[F3BD+[G4(3UUI.H?fLMW2[;9DbCF<7(2DG
d,[)L=;MBA6AbTgMb#:,TbfgC21H]Z26#PB(NYTd>4(Z@Z<YgI5T]\?^W:BLa8H7
:<;L;_ZPDF<KeO<\J,<SG\a<P+P1Sg_Y((a98@[-O8[+YWX&A#G]0Z@NfY/eL,2N
RK;(T^-4?NPCL9A97UUd:LDGLb/KD&>O=+J6f-ebIM)0E+KZ06#)1C9#L_D=H8I^
O#&/c:&@[/g(:[[H(Q#G5^2F4;d3MVW;.N2PWZ7W=HJ^Q+5<L_[d7=9<E=3(O^;I
K,3QX?,IUKf6GYV+a@F^_9cK\D:=fbG+,/fCgP(V;(5e(3W4MO24d+2A6]9efe:(
@V,6NXTQ#OL)Q+V0_.Y#QeM^4WLBF+?G9M+0JZZMPfBBAQCMbHXef#fFB&5MU:)?
.PB)#KcB@_1P2+71D=fN1RZ[QT0\c/X,L@_>\E95CI+UP@K)]Nb1C^&GZHbO6,cN
W&/I@KI<\d(^(<ABGM137I>&G:-:f[gP5<<35#RJGA9\8B5(>Y;3PVb<#K.N@YL\
U5V7Q=,G1aEJH39c47U>:S=AXZ<S3@WGW8[<WV1/.OE-=TI6/LGZ:gEV-PUdNE1A
+/e0_M>[W^5Ae,IG16/(4egS2AaZG<WJ^:;R;WUQ0;]6+FeOf&fWXfe6eAP[U)3M
fU/BBN#O==\SOYNf;ZH>(=eY1:fP[^Ieb2=HM5bQ2=-6W^W6fPN:a_L_EbZ&W^69
LFWP<1YOBeB1Ag&K<1J(GP:9aQ)ISAfOI5(B)2cScWdW27\A=.+5S9I\AgO7PA4/
IC,@\>HVFf^UH)6NcV]J5?@CaJI=WOVR9g(/2J(-\-Rc(,L384^;6e^Kd)S&C)M;
4@e/AI/+/NI?YJDQ[MC6WCaGBX/8P(Y>?#d4YGG1S9HO72[I6:Oe>^6UVICRQ6S7
G)WCd=A5O.G+dJ8a9^b-?OgV@YDO8LB9YI4=Fe1D+agV@aALeY[V(YZ/_@SQ_M6?
&O[CU7IBFFXb@g8/&36/g79,c+\;b/P=@B&^E;Hc-\/)HJ((5.C(M(dC5aF0QRZT
ge-M>gfa(&\;c6BY3/SFZA0LJLNc13a]Tc:P_H6dYPO:dPbb=/M]55DWA^VgT&gJ
e&AU,(4KW>888Pf+RRRZ&@)F(;S()&,H^Tb)3&)eI=?1#I<2IGD[\DZgQKOR]D#X
ZI1]T,fV1.+d9P1c>Sb=RB))S/\@cdSX&+-6#C^Qac?5GaYdfCB-:YBXJ?67S3LU
NT4[##4,Dd-_JU<_F@AefFJGJ7bZ;J.(JM;5:gdRFBMP=B>;PXLa6IBVg6:d56\1
6cS(P8f&Q[[#XAH8]eaD2S@:AHAfZ;O0LVVQ<39#_4;S0_R3aP.+[d?@dL^UC<J5
YDDUU<#1,Xa;Y_:A]>[IbS7V&?W5SQ<a?MXI^eSKgWUHNNL04<&e8<[,IcIOV-7H
(TeZ=0=cOIf_+M9^H2Dd[QT<X&6d_C,L-Y/5Hf]1.(,JPfLERaX2Bb6)?QRT=N2W
_A;[JeG/<_;X=:;O+\?M9996-Y^cD,O@TI)&T<CN1E-Y=LFW6EE7>9WeA95SgSQV
decI;I<#M9HT3(bQ7ba8>A0,bbGQII3&?Bd9I4_dM/<SH?GSV+A9;NK,8_PQ-T8U
2&.NPVZ]XTdVaZ\V;+:a3FU(7A:gN-26dI0B)F[CHc#LS8UMX<c,a<X[eCcLMfAc
1<fP5,V7Af#NH,?G79CT.B^eQM:]A1aEO,0X]Y2B<(a4<3:74I>G7g4N8?S1c/KK
&@H[cBTd:;5(g)?#&fU2aEcW^c+61=WW&_9W#F(HSCUPg[5,.)VTaKefe4G9??55
:2_fWccS;a[CBgG?GJT[S<V+F_]VFUD:<=(9T5FBbZW,d6)V4AFVg-3YOGQ\R-&>
B=ME5KKU74;82:F-b<#@A53dG:I83S7C2bM>-#4USL)=g3LgZ6[6OdR90FLFAcY0
Y7^I8S4=_0Y.UFQ#W?F0ZP8V:T+W[+ND7DVTI<&Y:aHaFBPUG2@IPM4@9B9B)DI8
Y7H6BN6cC1RB@&+[d\K6S96@e)V[M&Pd^\+A,;Wc1[GVaea@C#>)fC/La.]d,=f7
PEQRXG,#7+#2,aZCW@C35L93Q;H:@AW_MR<Q,FdaP_Q2HG&(0?cD+,(CbR6[M:aL
S?-E_JZ+=8]H5;3@+/;K<0C?@Z>WId9-ZP>2E>#PQ=](KP.JfHd<ID(5SG#FLQ=5
DB?2?-2SA(OTM?.Q;,I52Y5N\g[#eZ0R&cD3e&(a1b=&IQE]G05DE>&V):gab7I.
P.K>H>28X+GaM_LN73efZ_CbJdfQRB:aLC\K81NYfg49W,MC1HHRJN1fD-6dD8Sd
8&4e^9W4#a#dDMJ-85IfH#3T<(?RI.NIQSb]I5WPH5ZWb=J;)=CcW(^=7URW?4Ue
ga;>830,VSE3ST2+TZRFBQ([+>LDQDdP=CaV2gL&DCNUB:?SF)g>UTeaDXKSdCOG
3E3<RVVQd:S<)]&C@(IINeXVc(L=Y>f:/[(ZFPJ_@KL:FVJG:ee;1\d;?WQKZe;#
a.]V[5dG20FLY+8]5Y4C9[X&>^4eD@JGK(^/5:7R[YV5aXfZA8Tc4NZM.(c5P2US
7FLW58IO,<O)=G=a06?d8BU>L41+f?+TGGUNU686G=GG.gXIaK:?[KZ/&=)5D8<7
[8R@[gKRZQWd;dRe6M.5f<5X)PC@d6CI4QMS23eVaOOD+EB:Yf.4+E]WV@;)gIeD
[KR>E@;=IQC4U\GJH<@2B^Nb]HJOAe2K4/e(.Y/>aTXUZg]7e4Q0;HA<&EZ_[aT/
)HEg=JRHT?-g7E6L,;&?TQ>/XeUD,TR&]S^1+\O[d-Jg>XQ#LLfA)W44f_Z+PEK+
daB.9R-.D+<>V9(5?\YVGFf]bA\CFO(f<I4ILPeT0YS(X]F_\H4)G]DfFP:G/a-\
GN@]7b0;J_->8ZWJ^3TO;-F9E))E=FaQ>WI;acD=Q;@N@Q9faa-b/W7]AadTRR:L
>XV\@H9fU#?^639+OREC=-5(WMGfD8gEY]\G/U\KHYI?V1Jb1c9SI/3[099F.)3@
J[J;SBG7>(^S0O[+#SG4:PMcD7[^edNC5R2>Gf#)cY?PWac,cb02TB@IG\^I-EAB
+@Od<]_349fU@0XB^Y,L#8ZHZ^Ac>cd7RTB?SD/1;Qe;Pef#.2(D2=f5beQfgF;B
L8EQPF@#-b1TKWgG>T\M6F_7X<cV,][@=8819_A#>G9K>JT4NNfEb+>U\UF/E:L0
-?SK01d(7c#Dfac7C]>D:2&R_aBOcVL;[2SS+MM8F(&RK?.W7.g1>Nd438U7.2Xa
5R@/:EQAP,Df\OF/+IeT.5cYKeY&=O?&SObd\K\eI+X3ZRK:V77LSWbVL+^>-DVb
F?DJd-T6B6.PF(6>\F)7;Q)3?4YBGOc2:YK@VRg2ZJcO]+A9-P:bGKZ_LHBbcLM^
d9^,?JS)E&LU^+1,XC&S.1;CD4If;BfH;MU)1K?0LQ32V()aQ9KYD/D7Yc#1M_)M
1^KEdaKP366Bd\aMEJ<B8L>ZXRdY]4bFfVDX#c@S\2e._Hg1@NPSVLf3+-gf@)[O
VCP3dE=9acT=Xg0.4))B_QG]R+_Wa[4UgXI>11d/=KC>XZ,MSM5B\E85)aD#HYU[
dcb\HN(EOGPf47C&KIQ>7a++gM0C5=KU6UL+^O^?TbS\HO6DIaSb_V_G,?daB@<-
Y#MeV@P7O>_ZO^MJ#<H#RVA06B(A94CP@CcE+;/M7/a7ebWB.\SY66U\Nb;.)\d(
2XNd:?c<7E\4&3f[J)_R7U09#c0Xg<^KJ6J?FP<5RLYX,V6RJEE]&7U#Z(]OQ9bJ
-e[J+/GU9IT#\Bc@B-H<<C?TUdK81.gNa[DZDSD-C=,AU@fPC:f6V.S3@aVN9-&(
[TBZLK1@L=DY0F(fYPVO#4EI27-]FWF60-LSX@eaY]f@AK1Y^_Mf_-0.=+d[+,,T
4(GN)aJ.GSKJ7Hd0/+B,8+?C?0O9Z?KQA01[AH_T_N?4C\f+cg;>ZA)9C_6DW7GI
IQAa8NG5\K-]?XcYN>[Xb3K#W,9W5)Yf^.8DK:f/(bD[9;/:]:0N4^\=(a\EY?XR
e/JXe,=I>;Y.CDG-O^8R;@X^CaW4O\Z1SQ>0=G6,,FY?[C#I(9f6&6<DN;1;(Qag
U^^[1K?V3:_1GCTg/OTY4D>U]eOHCWG]FU;7-8EYf[\G/>I^HS>@?R2P52Z:,2U6
a]^A;eQZX:LbHP8c;Uc&<7>K/e)gMR-f2dZc#bYCT8Tf,=9\2OE9Z4//#\;?<B@.
P\(aHVT,CL,5_;7If+LPeG7^HHS7I;EL&J^KFT[69:&TeeG7/fJ;bD8@X,(OcZ&b
WS46U=D>]BcLJ<8VV+DGDM1RCcXS_6RUNaI9R,957W-&GVTRG3Cd0R4\MGHJdFC5
aBUEP#T3F+Db.1gF>56H??DP?]aTED&PXfVT0Z[6d3.J:/L2-+4P,e=.2V4Hb/FT
T-:ba1SB@VG6,&@D9f]-8?\W-RbFC8MP_F@8S@Cf^ADZV@]:7,@8+:.3Vc_AF1)F
bTZc5;BH2MW0))-UX/4T8Ta@HR1AV]S]6]70X\,,:GMZIO^^Q.AfL_J5f_.cDF5J
M6^N_4SI(f.VO?,)C.ZG?Z8Qa<Q=fF5HHYP;:935d-RIRZcCY-a(_FVJe(8?efB0
#A)NB0?cO@8=2#Y#R99OOFHbZY/L/Z&^?>6(a?6:EIMMVJ?_F9K83W<]^gHAF3J4
cUV-gEb8X+a&Y\:H9ESS@U=/RI/La\M9QVgAI-e;b[20Kf>90I8)@a)V6NX,P7G6
RD_1BKZP]^N<FRUJa\S+=TG8TIaLYgKedA@^&.eJ6ZaW1e7P3&PHc&9^?A+;+MTe
ebJ40BBOK^Y2-4F669Q+.:^T<EY_/Q2ITIgI#6A:dd^HH,^8A:M/1TCeR:M0;/8=
f5YJY5=)@T0V0GUC<&UagIYc7C;/3,S3@B@8ZYa28/[5&a^#4KBeXSKHgXP;YICO
H/>b<:>[DUPc>8;=A9#b&a^^.OHZ?^8:OVWN0dg:OVg0TO0e;E(PG0^D#A/7WQcJ
RL,PWD7S<IW=ZGQ_@eGW]eM=f_<AY.6/agKggg<M#\cC0TF>82UG-H7dP;7[;8#9
^8W,<V\8(NAO^K(-)UFgN.#eKcBW?2#WJHc7aJV9f^b3^Q(86PCebRTUSITXD4c1
P9[3355>0e^bO6?(>05CG&/]IA7;\MWSVdR86>X&I61KK.Y\_J-L>.D@PXV3c=[?
S8FS2L&=8=ed@N5)6,f:74>VdA:M6K^N&Y,7SO2eM-T=.G)C3Q&UEd_C&6?2C/a&
:V#6A/F7f#ZMcE&-4@-9Q)/]N<>P;4AN>Q,A=OA+QfD/>ZD[,;L/WO75+]26&Lc)
XTPKOHW?gFW1[-aVR,8Ig.ZHN).N./:ZVY#APRSMB[a;fA&F0.WN7@2153/e\EO:
L\.M0<g&5::G?,6.K6#QgEZI9-N4AS&a-S__98^4K\b]@<(Q<<;e#,UW]7?[g.=/
3G1d+<JX+d?/:A>W-2\18de??YKcaY8f66-I(.49b.R5HN3<:]54+SP=Nf7@^UW\
=ZJ+K-HGAe24F_4#GYH2+@C5E4g7Jf8&1H84E6g6CU;\WUV[?0CGR.-CZCSGHJP>
U2U-83#G3X.FW,&f2=R\S:2UX4VDPMI>LYfB046&34QXL0DGRdc1Cb8+=Sd-d]#]
Z:WcVKB<X\XL+^#\1FLOcaZc<_5b/>^(W(\EDO\dg5)CA220GPQ^<[RXT?JRfNOV
KB8REZW&]JUA4MSL<(eEMB\LGL[/YI2]7a.F(-<#R<:O?PH,11>I>EfZX?YbVOI#
L?)_2.=NQ#:cOOcL]T>8EIb/?[5<=,L2Y2.c<>K^UJD],f2B0]4Z]SPR]S(3f/B#
P-KB6_URcNVHJ]L+R7]gSRYLG=A&S\YZ+I]AI+/#6BD?ePA35IZZ_0-bPON&S>KV
J.FR>^EeDNABT5Q(dc]<4TYMBIZK>FL+d1#7Q@LJJM/cfF/9\O.<(-_8bRgW#P7b
OC(9B7JAe]Q^/e6T,JcDIP4VNb1;/-FDT<H(_BP,\KdY?OL#@cC<(]OT,BH06A_G
KG+g311^JGW^<+]6VGTe0>c;[6cOMMT1[d\F>@C1#aKZGEPSZKRP#b27YWEBK3F0
[)?^AP;H1F?N/I]RcZO1+SaI?XZc//^3CRD9[#M-/K5g,0F7eHWAG#0BEO(8@DYR
]>.A2(XZBP93:?f1M\:?D8)9^eeRA5Z<&.?J?58#ZJ&Y@>f3e.&eD&.-DC_CYY?d
Y[HPOCb;IJT:_17QG9S@KQ8_,;7QV4_-O2N^6U=WdF1+T^W__8P8,=NN85d[P-<_
NgQ3bU-YHdbf0@[4Hc\@=OB2J7&N<Va&X[a^=RKO\8)IbbK9Q)8(?=@gV)=N6>^?
UYUUOIP@^NVMRF?/Y--e=/ES;FW>Q_@^>:?I)aQd_RX[\AE=G2Ce#0WA4eV<&f6)
TUT@6A1L5A>d0<P;HFTK7dQ741/;W==d(;Zf>2,=Z7P)bM#B/eG\IFSb[0gOX8e;
6bHbgENE6_b<P?)<IQb=1QG;+:)3)ed<=@GH]K6dJ?@,#[RE<^8CJ4:B&2D)OBb-
V<02RR0?WM/=P<Z.ecFIb]Ta=DY][EP;#=V=TW/QVF]5T._3:?IC98b&:EYcf5BT
-T@<N6F+C:S?OQU.6-GW<aC6Y5?beXBa51T)3M?C<;6X2EG6;RE64f>VHZ;//N57
JXR;<1Q;/7P_U6d?HDQ0LISG242CJ(6<S>E\=^XM8Z+RHHYU<Q(SD5CfC0=/7X#;
a,>=CQR[=YV1d0O\KE<1<K;X,c6gQDcRf&QED_+:>(JdIZT6[C.bO-]f/)YA@IVg
6>=_[d5_E3VP::L6:;_48\\Bg=\G+C[;^aS(cNQg:V[+;X/Q4TPHKaGgA28)4>JB
#=[5?K149#IUJ-\9cM4Z6\?YeB=,[_E[^eE;=L^,TdP7^@81HX+2D/A#A_O[:bDd
TgQOgeX&J4N^F<;@,^N65ff-?AMK+IfaI4fgadT1Ce-/^P3F?Mg>1Xd)Y0,bZ-=1
QPE0_d=Z?AeOW:<:Q;J8=fb6@U8.=JM;0#Z?KJe[>VXT\.4)[,.N&35aM,F5#9,G
X-9<,8]-]1TV]8]8f51K8GS7QGUT@Y2;]2&RKLaHgR3V3,X&UBAgN\<SY0fUVd@+
Q&E(B^9BK,,K9VAD/cF,TDe&;QdbEJc^-V\F+:QFYQ\_S#f<R9]P^4fN9:NQFVM/
G@H=R]d7(bTQ\>ODL)V9IJ/(-EGU:2J[<7^5IZ,VNcgSUSR8&\R3<,Y3@Fe=a\7Q
6TW&Aad_>GB3C5VE&[.#BV/++51&VNPeTOEBSg)K(ca-TFHHE#RMPS^/OcS_gIDJ
eWC0d95^cDMJ/9JP\Rf(a9,ECYQ)M#e:#b+ZH(FM,d@8KX_cI<IeX]MYcY&IJ9^J
&)=ZK4WUNg:PYW/<UdUZbaf<I<_&?QN0LA[R+SN4-c9>AU+XK4dCF0?F>VJ@3-,f
XdAcfV:9Ha=GEBGM_.0fG^K1?_FLK>3BdW=:Bd-&31YYIaL^UU6ZJP<2)F5E;:W9
KY2VeI63-E&-L,O#Mb+GAFIM1DN6(2MU&GV?_H)g179CUQENEgM]FG<L#8XNNWf)
EeIT8ZF.McA]31Db9,2D(g?EXT&cU&#W?XK]3LE;/d,M.5+=&><\]]/#EN1[2e(M
3A729CLB+a4X?Cf]YQIBAT:V[-^dJ4;5S02I>)gRX=d#_4#3bB9US^HP7[7Q>0.b
@eOR@_2\?:0<SC5ZSI(U[:-I]=f_(TQB980eg-);3W6-&?5/?[62992dMZK6OGg9
eXNBf=adKY;)B5PHO&7T&g@dUD#DZ1)g]&<@g;EF)V6JAEW,@_L(1dXE#eXPPD+Z
AedTVOR+6d+c?9=[^/?bG)51/UP7KUDNK:W_O=..V4c9D&d@Ga<2C+Y&I1O/B@H8
1c\:?d:[D1/If?REaH=/X,#@5Bd;_(PX3Z=Z/4>?OHegS1,/[3O>OVH/;C,)1<)+
D;c2VdIXac0IN>bG4;Pa+:GEb4\LBf2-93D?ZX8[2=EK_H7d@b;=NXN6@afSRA3M
/Aed:GRDc>2?FSf?PR-I.(WA&L)KfT_+^DF,Y]Lg>a1+-2ZP.OCMJW,@:cMG&]UP
P33IBKNc)R:Z;b\RagQ)]Yf:[_QJ5+NK+C^FA4(@^MGC#PA,GKI[_1Y/R+0EY#U6
:3c1-BOR.3:bfMRSN)J#E+@/^-74).;\RA+<SQ?2&KfRQGXC_2[IS:?:8D)BN]#\
]eJL+S@^#LGP[A^9<69F#;&-,MS)(Y2#.H?0Sa\XcEg\N?7X@)H7bAB1[091011G
D[AJ^D?MX1Gg78D7c0(3IfKC?bC9XcGP)#ZH1[U/&AF7[A(8]#9>Q,<MX4V(EUc&
QZJeGH\>47(SdSJF7R88ZO7VSYH1Q;9_b?(MOQ+cKWEN])C40>DC.XL1R-82#g@[
Mag>#^2NA0L>/8R0JUXXag[8ObW-P?1#M.2O,W^E\<Y6A5^fA?SQ2bT4XI+DW,]N
X#KNb@/,c+W6J(fD5Z8bc1,MW0G]&[8U>0Yb_dUG,,&/N):,4P(VeX8P>QX)J)3e
=YW/--gb(_,CCCc\=@[::bNM]XI68d)4)0\0B==<>#4=IP2K?J5YI+YeIU03M-H&
d0=P(:=;5C<9]<BJ>1TXKV-KV7+KV4Z)G5A8aVb-Y)A?H#S6QTF.(@MHcQIODS;U
F:(D9d1#fea?[,T]&,F:LBNR@[b8M2LMIS1#ZWeDAB#(Gg:M)BeX?4_[.B4eK)?2
;\g37#ZWD1;/@aLW&I5S:cZA)HZ[1,Gbe7@aPBcS-B<>UPPcEHCg^TQ(<)8GSRb[
:AY5KO:DN2eS#,09F>)GQ0GXGJDQFOB4P4&#1/.)1RUN\S_X[.__4RKa8(F\YFQ_
^8O;a9:)b0+:G.UV#>G4+OKH(I:GdQ]OZ;NG8X=8LL,5WeOd(V[=0eF^>P>g)XQO
W=TPV;\fg?Ngc:9FFV&)ZF(7+A25c,eTE>4-(_2X;d?b(GS2P7b>TQL6.R:WV[R6
Kd85RHKV5[SaH^b,<8fG/\M&^/-eH(G:P?(/);aSVFH-G3N[QQeK=?C22-(#5KX<
;;0>4aGCB)GYe:CC=e]=MQ2X6Z3S:8<R#F)FDILCWRS]V\fU-XE;OD:-,0f0.g.]
DV6f-E>WS,G:X>1K-TR#a5CJONX?C?:ZH>S,PfG&36[485@b@_LW\OgU@AQ]#-JT
4,OL3caMe=,@f8KU:.O5JK+[[B-@>cV+,EI=6V8?@bf;^3(F]MMPQ6,;(>I77377
\CZYZL+X?_.OY4,XCLM57HUeSQJZD8SH^FM@^T_70,d#S3B\ZTF?e)4Y<5ba\9]5
IZ6I=SKYZKNJS1L+Q?M2O[e-c.aa=BIDHNED:6GDX=BJP\Qa/KFIfdS7-)R+2K?5
9,^fbGHJJ@I,4<#PSI]I/eL1N&?[5/KR;1/<QGI/;G?NJY/GBOWJEH4SQ=T,IMBC
,)I/G28NXFeH&=47e:dC>?^MM0b178U7JGX=)bF?DKF_2@H4(Ge,[(YM><BBI6U/
K66E;WE/DG2Z^@U\]gOV4G=OVa9BX-<)c:bRFgEXR0NeW[dT@\XH]@MKdPG/;U6-
)M\A@aVF+IZSf>15XMLD/?&J&E;\eKUO1]ga(;#g@?c:f7X6CI82@_^D:>>HW8Ab
=RFIE=>H-&_K;&RQ3K[S:fKO2H7PTS=gHJ3RK4ZJd7T(?J.0B6fBZNCS3^R(J8[&
0)[D#eaC4EV)F\+#N8N\[N:9CO1ZgVD1(d:,WL(GX9(]J86EFTQ@K=R8<I]7N[bb
&-,PSH4R(-#;GN.+aD,J-O19dGb<6^FgFEZ(0#VUa?aF1Xga5_(#,O.=LaOHK&A2
9NUD[TI0B=A#VCYION^(,74e:9\Q?ALRdGJA5FbNX6JKB_;_KF:\\SB]J5RX5^33
MgP?XX6T@NK_fI(?&eHbL1\2I)LE3I92[JG(GDLcZ(YYQ=D9_]#E;f=.[ATNS3G9
e[>::\[4QOVS.#FO/\dK>SIa-/8EW?W)_&]UNPfSe/aJIX&0Q_Me,?gG,9,;>@<_
JV3I5POg(@HW](:_;^K;ZY/7,8SQOWIb,5Hf)+gdF/@H^.Q/N10(F4V,9+R(M]6b
[XDMAD4^eeB[@eZ]>;8.aKb(IAT.@JQUMJU1<cd)ca6VSM0#_E4@fa>;]F=G=&KV
OM=R@;4bXECUMAUCTAd?#9c:3gZ&;JeD:Ie-A^9@.5&.f#cJSC99+XNAO-f&#OcL
<_\\dCNCXQeW5I(F<E(O#8:\NSe4U..-A)TA._L6)?/_JD5,:QKVA2-#OIH)[JJ7
U4D_RVf?A48WQX\BeTf>[YUP\ZeNHX&89DB)DbgBd8+:.5A[.PB\55HFW[\-\ZOX
>-MQ?H_Le,Q-5?C2KC/@@]QA]U1-LZgNZ0?NgZMA>3Y158_]0[e1RgM<<YDD6<_H
ed^I3TMZVEdbOcI/<TeHLP?;W8>Y;P.UcM)RM\?ZMD;4=--0I[D^F)=::E-]PBg4
7(265\^W3G5;<DAe?8F<6[JQVP=aZ:C08L1^G@_(H6-]L5SB2@2T9=1Xf<4ULHJF
XXN]<1a1>fEO=]@]eA.;WKF:\aK0GZe\M,9AdR8_8dR4\(_TgATO,5b4Q),UUd^@
SHM-/V9=[+H8IE1d5;BA1;GaY0(a+IWI^dFD+DH.]R0:?=;K-W[/<=Z7A>Y3c_#T
?3Q1:I@G89#CZFF_c7G)W5@VaEM10>fC8X;RH<\6&[LRa6:]fQ/)e&DLG6K]-0^S
@^&Qb758,.fBI/I\[IURPK>G5Z8M>B8O7>MfQPQ3X/R@<W1>edWS_G,CV-/V.D8M
V:S>9>V^=cB1)PII54g-MIP8B2BW?;?WgfOE)4bg3\6VP;XD1LCIU.dN9PK+Y)Ue
WSRHZ@?H#F1>5DbA?<a/(Q^_\>-b[@S@SbSI<?9-fd46QQgU)&SV[#E1DL^FZNF&
WR12dY_3<c(]7K1];&J))4BAb1OGFWL.4&a79<F[9#=c:6/aJZPf#)_?aN?]TYU&
,]S9]:^(DYTP(DQ=3D,fL>J8(:cY88XG,5N@HKPTQ>1g2&B:?TYY1U6fX6]_RV49
?PR/EEAZASA=J(^@=dEBd\RR7C,Sc@&eA40\>5]>b2dL+OQZE_G]3MIUDM3BU<=W
WY1-@[FNN8)G@/AD@3D[_H>Y:Sb+]90)0ERfSJ/\Ad^<M2^WB-OAPFVYE0QH:JR]
C4L(VY0,Z\#7[1O09X<(:B1dD:@F5F4X.&W(=acGb?5eAbC@LV0Qdde>4._?O;L7
6LfW/?S[De?HCe&0.C\EKMKU2d/22bZA7a49LY@-QLPR=ZDQBI<cfA91HRd5Bc(&
[8KJ+Qd\g15b^=AG8gCF9[1G[gNTP/C4gB(bd826fSSS3[c8d\PaTYUMb&ROd&-N
a.MOe\:@WJZ)S&H5-L6+#M7BZ.)L^WeNMQIK4)IW^\DN_:T?3Y,KegGV6\Lc(L:8
fP62g-_>W=FVGIN;GHX,GM#Sdfd\OP8UgEf/[O<?aT<>9G4YD4H.V+A3SH5fI[ND
A)DOPZGK3Q>FVIgOY64b2S7.I/H<=F?OC&T)]OC=SMTLPJ[;-#/JAM1=S:.GcHe8
T>4=G^]EfC-BK9_Sb@1N^WU_TG3d#\E(=GMf(I:D:N5P9CSf33B[L0eJ82RL8TB>
4,(R2d\;5#IC@e/;#d50O2)d/2f.)A^ePK-_g;0H\&@B;2^/Z2bRb]3f\JMOSW&A
V3Re<I/.H>c91f3@.(1[0F+JdI<31bMQ.<#QITP(&:?8YN#K2N]#AQ)].O#8/f49
/1(W]@>(c7\GM/^#E+,NQD.S0X[Q>Z7K838)^8#a^PXP.J]KH]d^MF&WEB(F6[/X
:SZRg;5MX;^b>26[S[)OFG,P[eEGJ2ZJB.?2cOcXU=e/(YDK<aDB9Q)4PbMTS<A-
NJU8@X#[5b<;fD@fT.[CO[IJN,2e7g0DD]2)gI#<PCIZ[eKW61-?]2JS_JN&+-\7
04Y?G+cT/J/R>9D)1-(F&R_W^&QbRZ:Bd&2+_B_U=A&\O0T^NBf+1H[#M_KbX>15
[f:U_U@/eaEH.XMQf63gHZM3-O-7VJ@d;^A9I&F)5=NXD>^PH#)aEKOWJH17bA<^
T\JK[PLaYVEd.,H&=.52+FXcO0,b#Dce,7#8(O\0:g/G7#=O_WQBD+G;aC_LQQO,
E&@d=&fWb1>[gCMA[K1XPcCW[&cLI(#0T^4?;\IE3L&bCDSR&0<Gb\ed/.R\6UUd
I)3[LZeWf7)3J?)=TE;/4D5E>^..+ZEU,]>@MQ&?M]M+#g_@AM#^DRa6/ZNf3d<4
PFQ\LP&7Iaa-Ke:G^ZA=b;&OE2XQ0b#H8JEeHOg0ZY=9FTAR:(_)g6X^#YH=W[Y:
cIW-1?4D;>X.PeTXJNdV]^I;>#M5OZ9X,CN(4KP\aIV5X@1H&H[;)K#D<ZS:@Z(b
0ZQ6&KX7QJ63A@L4.P4\A=g:cGY2OfF^(+AZbL?1WX+YM-/KCP?B:-3U_]ME04,^
b:HQV[aHI\A8SE<P;FQ2GCe-]6,I7[EQ8<RHa;Y7BLUSO,76GW\8S)=FDPR>QF#Z
)M,fB@WY(>WFR(AbB35J7HOfGOaM/D6,X(0]_-0bf;:JNAC@9_c8.7A2S9b;#>b@
VRME0=XO2V?473aTM>X2KA3BXD,5d<f_;TGYc#()dV5Raf_A=eSZ=\d-c_EcOe#F
U)3H:&86#a9A/62T\S2SK2+QU^G0WXT->DN=6MYW1b=gMOP)FXM@?TD;&K,/[P;#
)g86;DRfG@<UE6@)0O^5B;a8JW(4<Wd=GA7KEbBX)9cTbX))9BN5(LKO8[FJ/)PA
=R(?R(6<:5GKCSL,<@IadePRB<cO;GQL(,)dbE5L&MSVeY.4dPS.VEM2LMRSCEVB
R)8Ga]I35V7,&@G\5J(66Mf4@X.eDOT;8]#]d&\,^RM+]X:X2I4-ABM&QS7^=S6A
8gURYgC7V^#H]O8^LGQ&D^YMaELYMK]XGZg)3T1M9Bd)YF[#f.75?9T9e(K]b6L.
#=XMeSfVN8R^P63+MSTJ-ZI6GE633K+>U4a?a9M@&E;?YCGb.F[a&dZg/8[UJO]R
d,V\SX\XM^[-)41Db5L.Zb8479I3dH7IV\UB1f20X#8V4c_Mf,e39.b+3AL0EJNC
P=&eRMF<#7cO7<-b94d#2cVdKS^c<+WFd#EX67)5<&A8F8(9aSL_Z_7W8_(8>+Z9
1WY+-5[D[5SaW22>4CT-)LA^.[LaHS]&cbSc1VH^+>E-TWF+Z46:WA_(\,<CL#W7
dA&MR7[_Z(D1>b0?MJM/HQ\I>\T_LgTL0g/F.+0[M7:8[+44U+H\UQ+W6)X(<7U[
FVb)0>L,M3VfZZ8ORW/;2+E+-(O:V\<:##(--O)[.S=D:^8<E03DP<,TJ+8ML,#f
1_dD=\T?c=JL]+7ECX+^4?-#c6_Q,a^2.25K1.XF+VF5]GLfMD97bGVB6-.IDD-O
-6[X95cI0(7?([=NV5C1IbPK>YZPaVgeP:7(eT[1&b)Z7gW-Ab7XacTE\,KYSL?+
4.efdO@6O=)#?+\3&8(T]:XSCD4a_J&,4F[#_A:AFMG>#;b\cSIK1Y04YFS+D]Lc
cB_,D6cY4Q0V2NA_WW<ES6f>DCZ/L^/fSGDCMOa2^227J7D.=Q#;E)>SL992#PD#
EJ=eS>QG(,-UU)JLIE^/8Q&N)>)c,FVO/7I.^JON7)LWAE<c6^S?Z-&_(70W6Jd(
;+<7ba/_FS<_,<LMZ#2D6]IfO9Ee5OJA_bI;<=2M-0K.d\EJI,DdHAC^]e.Vfg-=
[)LfYGYZK\:J5IGL>J=bNPdU/dba3]JP?Yb8>I83]b(Hc4F.F,Z#Q@P3Z</Q/^F(
FX<,TH9_GbA^#f+CAG=MS+FK3Y;5f5-X^1<>EQ.C4RF0VNNWa>:9FLdb)?C(]M&6
QYI;4OQ#X>1MTHHGE;Fc)3SBLP#^f.<B\Y]>,NZODb:1UR,FON\&(ZN67@b><e5.
I.Q4?UEEgES3g47MJNN<H_DYeO2<M6(A]N.3<?(I2SdW;+f,HfAd9@NGeQ?FND7;
/GT\PU6?])8aN>(\Tg#.1S:Z]a7(^SGWH80XE2JO.J/8H/1g:Ce.c79/K6NW:C,5
EcGEN8I-KJa<6dWLeS@bR764WNZJPd@bASHe_S;BYKVR9S9W0C>J&K#aeK/XY\0a
J<K_.e/C8ZSgY^[7Hgb@D>0^Hff>NWIQW)Z+ER<<1ELa-V+ca83bKSTXFcWN=d>U
eIWDa+3-?S_^,>5J<^d5N&=U(0C7#)RU\F7Z^c:\Yf-.CQQCKGObV:3E@B:B\/fZ
G9Z(Y[Y)[-7IeA\M7g5?G7CRU06SZ\a5@,)@62^AC3RV(AH6PGaV@[F2\O7bL@];
BKUQ7=I3=Ua^UJ1DYYM]\gD(SK0B:BX.^:_?AV@c9=TYa4L+1:.(E<3BJAaJ=2WO
e\7Z+U#5\Pg.AEe&aW2&>_W/gN[]&caO#7g?;7+1<Sb)U=<\O#:IKY<,9?122MXV
NYPa1Z:#F=#&cA3QZ&JS5gJQb\aP-RVQ04?^;&Ad:c/_LW_IR-\M5aRW]6Y=N<\:
F6D3g2C2+T,0c1FK.[[R++Y\J;#&?_C))9#G-VA9>\2&9dO(-L74[VJLJ+1b4dIJ
.6UF5d]FF2/<J(NTMABPeOVS8)085F./cV96#I3WYO3Ea3A4BEE^?-9\V8[Q[4/\
]W1W:QfDf,2+BF+01KK\)6U.HaQ@=01:S?^6e((8A1:IE[Z+2:gd<gL]f2Fe0103
fd7RRf[g)CD,3<<LegEWdDKH(5IAKa=@&cZ#)L.IX0V8N#W]C+9gE]&&\F50VSH<
Df<_E#:fU]Hd2@/^#eUU[2\UCF--U9V(J53SM@LW@TPXL\\_eGIR+Z0]H@8)7VTJ
+#QE5I(>(@ZPCT@9B6MOK-1+,ENZPVEIC#YNIV(\#-Q4^-#cX7=>++?VG4(_S>C^
GJGERXF=KB9DIS2]1EM.3U\,1Y\+M=7Ld.^fA1EVRRYdZX^f6PT1(aUFGH3G4S7M
g5.,Oc;<X17DY127,(OC_H3C+P<D_.;V2@aIR?.H_X&6GccN+?P[TYSPOZ48&[7C
B18A)1]2-FW&G5LKS\0E:0I61KB03ORJ^P8e<>-2_#+[\<D/;B<a#J;JBa4OGA=4
[AAS36-<F[@18\#TF7)6I0\#.@c7_DO1N:38<(=2\OfeE#2I\[fd3Ze^[.,<)5+d
HY<(.Mg/QSa?15b&:Z[L6W,d^M0b9-<ZK-9#S)E5_01fUQ@;[;Y,Kd<RB@BJAZ3,
aMT+O,3#4,;L3=fEA0-[?DD&,4c?:<V-T+7dISSegGP3V>+MfY=efgGCdWEWRG@e
67ZI.OHJURL7]2e,8;e],eB\U2ET+;+RN\8(a<aD-+)18Kfd1O]TT0)PXTZ\f/3S
K+Cb79,N\WTMM+<DB4,Of4cK8Zf1d_ZgSDD9d7M.\f<CQ&:AM^1UEZU6X&KC83_[
6H^U0D\@XKU;Da(YD@cN,Kg-ggYNO&E&M[:F2)0bVf@+^8>3C<.2Oe5]Y9<&H2//
+RGP[bS).^>K/>g7.;cX86fa_VdbHF=G&#1IcfA_KcPU=1RM-IJE^==L^;F3L\b;
)92Q3Z&:aI5=L_9WG7Zg1;,QBH85g<:OJ(dJA(>Zbf)TMMRZ/VHW#Lb@#/c4TIMS
?QO?b;(agedW3AW(]BVa\cU?EcXG2G3fS2K#EJ3N6OD8bEH4.&.N\@<W1AGZ-Q#=
@M78JZ?AE#E?eU.5)I@VYY&#>9ZT8G6b:62FDH.M@deNc;.=MXME][eHaXe6[5dA
C5fO<EO\B967.9K?0MEWDVRGZKJYY/QgX=7MTOXTB.P=2VXFKBKGFF)2V5PH2cQ:
.PNCHg@dd/+.F2VKX-(,EDI6,&Ec4gL8aP.eg,H>0X?QDPc=MW:QGJNWUERI_N<-
c\W3gEC+ZWa=&PdF?d0R<.HL6#GBGaA7I1&W/e;AOBYdHP#.GK3BL<P4\1=aNfC)
1_U#2ffeL97PbacO;#&a]NN(W7b)7&K?=MeN4F?29F19;L-C?83.IV><?K&T263Z
=DaU6=8bMSJY/@I?WKHZ-M5>@E28TQbX:^QD1D;Q7f9d;6^I_WCTB#8;[Ug98M<;
K^PI&,P:=Jg:UZ0E910Z<KC143YU9V.H00e:DRIB;/]W(Hf/ff[J_@d:4JJ-#\0\
3J]KGR?]NGD(/U>_gdM)?O,e^UE>7c;QI\H]:;A_bgA_5ReQWHVB?_?74S=<35g&
^V.:YZEA+MH@CWWgSe7AW(YY9Z<\7gAVBWS30dQG2B5&IDYCb:#6U^HcdAa(+deW
H6AD28/J2;Qf8-Q\e3&Y_OWH+X0CWOffcP6bU3&KPKf/R4=NOIMA81<Q#0T4<(Aa
M^V0d1gULObN=?e#U\3/FO^D)IUAEbUTEM_L([F6)+ca_dHff692I:g.QAA2\06.
SW@N0:]]Q05@8TM#:WKFgNC9OAXF4gb/#\Je_0bNWCS(YR&JG\V77L@^YMA^YQ4H
5_T.7K:bX2EaKPVVC&P51EI7E[SOeKX:Q/(?\NPYIA4+<fK##4RXc,d<b1d]0-F>
cD>P(\L(\QfUc]OCAI.[SO/LC>F\.T(geFJcI60F\4:K\&18.f9>U+[TPPGFV7RW
cM1<]R00HO]C>=/YI::SgbY\W.X)=(_9CLBZG[AL6:TN=RB]B3I)P=f)S]6J3ZPc
LYUAH)9THOJPD>4;O=X?UQK+gJ<H@FGdV>(-FL16;6gNB5VH8;30g??JST]FY?^<
I.:Vb+e[?KJ16G/^>X19&XSO&AA8,6)H2#&0]_?/.c@XR(L/J.<E5EEBM6W1,;<+
#C&@ge<7d3U3A>SFFAFJ@G]N5?X69?f]b:Q+P=&g.H?afRFeEQ:C<Y@.Le\a_7_J
O(\18SG7A8F2#U<M8?8Z>WfLgUX/7Bedg??:d<&E,12XQVP\#>^<E5F;Gb+6A.K:
KR3cV&G#d,V,P\:ZX]_ETH]J,.04P\&L87a^V>/a/D<)f52g^:KQ=fY&A<9S:_T_
>^>e#A4eg6B=/K0HZO^cHCa1D[AJ(cg:NMa>f:PO_U0I62d=::H2E<A]YcTg??gE
53S@]@X]+:e;RF;R_BKBV-[\ZM\#gdN^(?bPO>OV(EUH329O=af1gAC]5C?C^6N5
;Vg]^9<J9B,YgKJ+2Rf)@d<=US,B@>)PCKQOJGP\@<?5IcI6W&XTJ.K>fV[NKb=Q
Gb<LPZ<27WHI@?YKKd_)#1[V21SS+\:-bcf:ZPX4eGM:5GB7J(SJHF(T@^YS8>FV
6\G8KPAA,;#NVYQ9YG(,fY-2^/&V9Q8K3X[b/6W3MP/3:RaLV8WMKE0dVI>GY/>\
EFWge&AXLH(-ea/W=O.O^9bY,[f59,M#aW>=5T=e,DI?gU@RP/;a:P/WVH4K2G:E
)T52J?V[+1cL#Z;4R:\&:(/?UY#dMb4K6PKe/b)TTP/fEdP,-9C>BUO@Z7cg;7#M
B7SU5g:,GSS5N>aJ1fLR&?/?1$
`endprotected


`endif
