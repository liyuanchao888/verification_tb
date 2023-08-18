
`ifndef GUARD_SVT_AXI_INTERCONNECT_CONFIGURATION_SV
`define GUARD_SVT_AXI_INTERCONNECT_CONFIGURATION_SV

`include "svt_axi_defines.svi"

typedef class svt_axi_system_configuration;

/**
  * Interconnect configuration class contains configuration information
  * for the interconnect component. It has a handle to the system configuration.
  * In addition, this class contains configuration for number of master and
  * slave ports of the interconnect component, and the respective configuration
  * for these master & slave ports.
  */

class svt_axi_interconnect_configuration extends svt_configuration;

  /** Custom type definition for virtual AXI interface */
`ifndef __SVDOC__
  typedef virtual svt_axi_if AXI_IF;
`endif // __SVDOC__

  /** @cond PRIVATE */
  /** 
    * Enumerated types that identify the conversion type for
    * AXI4 to AXI4_LITE
    */
  typedef enum {
    SIMPLE_CONVERSION_WITH_PROTECTION = `SVT_AXI_SIMPLE_CONVERSION_WITH_PROTECTION,
    FULL_PROTECTION                   = `SVT_AXI_FULL_PROTECTION
  } axi4_lite_conversion_enum;
  /** @endcond */

`ifndef __SVDOC__
  /** Modport providing system view of the bus */
  AXI_IF axi_ic_if;
`endif

  /** Handle to the system configuration object */
  svt_axi_system_configuration sys_cfg;

  /** 
    * The number of master ports in the interconnect. 
    * These master ports connect to the slaves in the system:
    * - Min value: 1
    * - Max value: \`SVT_AXI_MAX_NUM_MASTERS
    * - Configuration type: Static
    * .
    */
  rand int num_ic_master_ports;

  /** 
    * The number of slave ports in the interconnect.
    * These slave ports connect to the masters in the system:
    * - Min value: 1
    * - Max value: \`SVT_AXI_MAX_NUM_SLAVES
    * - Configuration type: Static\
    * .
    */
  rand int num_ic_slave_ports;

  /** Array holding the configuration of all the master ports in the interconnect
    * that are connected to the slaves in the system.
    * Size of the array is equal to svt_axi_interconnect_configuration::num_ic_master_ports.
    * @size_control svt_axi_interconnect_configuration::num_ic_master_ports
   */
  rand svt_axi_port_configuration master_cfg[];


  /** Array holding the configuration of all the slave ports in the interconnect
    * that are connected to the masters in the system.
    * Size of the array is equal to svt_axi_interconnect_configuration::num_ic_slave_ports.
    * @size_control svt_axi_interconnect_configuration::num_ic_slave_ports
    */
  rand svt_axi_port_configuration slave_cfg[];

  /** Indicates if barriers received need to be sent downstream, 
      if slaves support it.
      When set to 1 and barrier is enabled in the downstream slave 
      (svt_axi_port_configuration::barrier_enable is 1), barriers are forwarded 
      downstream and all transactions received after the barrier are blocked 
      until a response from the barrier is received.
      When set to 0, the interconnect does not forward barriers downstream.
      When a barrier is received, it blocks all transactions after the
      barrier until transactions before the barrier are completed.
    */
  rand bit forward_barriers = 0;

  /** 
    * Indicates if cache maintenance transactions (CLEANINVALID, CLEANSHARED
    * and MAKEINVALID) received by the interconnect need to be sent to
    * downstream ACE-LITE slaves. 
    * When set to 1, cache maintenance transactions are forwarded downstream
    * provided the AxCache values indicate that downstream caches must be
    * accessed (writethrough and writeback)
    * When set to 0, cache maintenance transactions are not forwarded
    * downstream.
    */
  rand bit forward_cache_maintenance_transactions = 0;

  /**
    * @groupname ace5_config
    * Indicates if de-allocating transactions (READONCECLEANINVALID
    * and READONCEMAKEINVALID) received by the interconnect need to be sent to
    * downstream ACE-LITE slaves. 
    * When set to 1, de-allocating transactions are forwarded downstream
    * provided the AxCache values indicate that downstream caches must be
    * accessed (writethrough and writeback)
    * When set to 0,  de-allocating transactions are not forwarded
    * downstream.
    * Applicable only for ACE5
    */
  rand bit forward_deallocating_transactions = 0;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Specifies if the agent is an active or passive component. 
    * Supported values are:
    * 1: Enables driver and monitor in the the agent. 
    * 0: Enables only the monitor in the agent.
    * <b>type:</b> Static 
    */
  `elsif SVT_OVM_TECHNOLOGY
  /** Specifies if the agent is an active or passive component. 
    * Supported values are:
    * 1: Enables driver and monitor in the the agent. 
    * 0: Enables only the monitor in the agent.
    * <b>type:</b> Static 
    */
  `else
  /** Specifies if the subenv is an active or passive component.
    * Supported values are:
    * 1: Enables driver and the monitor in the the agent. 
    * 0: Enables only the monitor in the subenv.
    * <b>type:</b> Static 
    */
`endif
  bit is_active = 1;

  /** @cond PRIVATE */
  /**
    * The AXI specification defines several conversion and
    * protection mechanisms to connect an AXI4 master to an
    * AXI4-Lite Slave. The interconnect uses the following
    * methods to connect such a system:
    * 1. Full Conversion: This converts all forms of AXI
    * transactions to AXI4 transactions. This is currently
    * not supported by the VIP.  
    * 2. Simple conversion with protection: This propogates
    * transactions that require simple conversion such as
    * discarding of AWLOCK and ARLOCK or AWCACHE and ARCACHE,
    * but suppresses and error reports transactions that
    * require a more complex task, like burst length or
    * data width conversion. Set this parameter to
    * SIMPLE_CONVERSION_WITH_PROTECTION to acheive this functionality.
    * 3. Full protection: This supresses and generates an error
    * for every transaction that does not fall within the AXI4
    * Lite subset. Set this parameter to FULL_PROTECTION to 
    * acheive this behaviour.  
    * <b>type:</b> Static 
    */
  rand axi4_lite_conversion_enum axi4_lite_conversion_type = SIMPLE_CONVERSION_WITH_PROTECTION; 
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  // ***************************************************************************
  // Constraints
  // ***************************************************************************
  constraint solve_order {
`ifndef SVT_MULTI_SIM_SOLVE_BEFORE_ARRAY
    solve num_ic_master_ports before master_cfg.size();
    solve num_ic_slave_ports before slave_cfg.size();
`endif
  }

  constraint valid_ranges {
    num_ic_master_ports > 0;
    num_ic_slave_ports > 0;
    num_ic_master_ports <= `SVT_AXI_MAX_NUM_MASTERS;
    num_ic_slave_ports <= `SVT_AXI_MAX_NUM_SLAVES;
    master_cfg.size() == num_ic_master_ports;
    slave_cfg.size() == num_ic_slave_ports;
    foreach (master_cfg[i]) {
      foreach (slave_cfg[j])
        master_cfg[i].use_separate_rd_wr_chan_id_width == slave_cfg[j].use_separate_rd_wr_chan_id_width;
    }
    foreach (master_cfg[i]) {
      master_cfg[i].axi_interface_type != svt_axi_port_configuration::AXI_ACE;
    }
  }

`ifdef SVT_AXI_UNIT_TEST_ENABLE_CONSTRAINTS
 constraint unit_tests {
  num_ic_master_ports == 16;
  num_ic_slave_ports == 16;
  }
`endif

`ifdef SVT_AXI_INTERCONNECT_CONFIGURATION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition.
   * By default, "test_constraintsX" constraints are not enabled in
   * svt_axi_interconnect_configuration. A test can enable them by defining the following
   * macro during the compile:
   *   SVT_AXI_INTERCONNECT_CONFIGURATION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_interconnect_configuration");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_interconnect_configuration");
`else
`svt_vmm_data_new(svt_axi_interconnect_configuration)
  extern function new (vmm_log log = null);
`endif

  /**
   * Assigns a system interface to this configuration.
   *
   * @param axi_ic_if Interface for the AXI system
   */
  extern function void set_ic_if(AXI_IF axi_ic_if);

  /**
    * Allocates the master and slave configurations before a user sets the
    * parameters.  This function is to be called if (and before) the user sets
    * the configuration parameters by setting each parameter individually and
    * not by randomizing the system configuration. 
    */
  extern function void create_sub_cfgs(int num_ic_master_ports = 1, int num_ic_slave_ports = 1);

  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_interconnect_configuration)
    `svt_field_object   (sys_cfg                  ,                           `SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
        `svt_field_array_object(master_cfg              ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(slave_cfg               ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
      `svt_data_member_end(svt_axi_interconnect_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------
  /**
    * Checks for a valid system configuration handle before randomizing. 
    */
  extern function void pre_randomize();
  //----------------------------------------------------------------------------
  /**
    * Sets the array sizes of the port-specific variables. 
    * 
    */
  extern function void set_array_dimensions(int num_ic_master_ports = 1, int num_ic_slave_ports = 1);

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
  /** Used to turn static config param randomization on/off as a block. */
  extern virtual function int static_rand_mode ( bit on_off ); 
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /**
    * Method to turn reasonable constraints on/off as a block.
    */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /** Used to do a basic validation of this configuration object. */

  extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);
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
    * This method allocates a pattern containing svt_pattern_data instances for
    * all of the primitive configuration fields in the object. The 
    * svt_pattern_data::name is set to the corresponding field name, the 
    * svt_pattern_data::value is set to 0.
    *
    * @return An svt_pattern instance containing entries for all of the 
    * configuration fields.
    */
  extern virtual function svt_pattern  do_allocate_pattern();
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
  
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_interconnect_configuration)
  `vmm_class_factory(svt_axi_interconnect_configuration)
`endif
  
endclass

// -----------------------------------------------------------------------------

/**
Utility methods definition of svt_axi_interconnect_configuration class
*/



//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fbzXtX6EluH/d0ReMBlwnDpTb3/6mIt0Uk78wEWuhNbmcWQ8WQ9JL1CBWBFrVfzI
QLiKAS0YCOXOuyVd3hIPXuJWFlsfg4DqEeaDfhpLTO1QFtgiL/ORhiy+Od7s+omp
BqtTCPY1VPsDZdbrcvgHmaF9AfpQhGgGHZOciYTeDrcBeO/0jK0FZg==
//pragma protect end_key_block
//pragma protect digest_block
rAh1mpQZS+Vv6lW3PATUXUzFnOE=
//pragma protect end_digest_block
//pragma protect data_block
5dkWpZv/LLMvFBJbKO/6EHU2ajfB6GVSkynmpMctaxMglqg7s1huSfz+0aZulvS5
OU1KbfIWphCdUHzzTlkVcrkDONXe/vYHoG+DAWnOGmqBLpOhTKiywCuafC4tEDlB
MvS70tKV2mDbVzm/XTurjxwXrGwcQ99qyCLCLzrbyIycncHpj97P/8GdqvVX0X1T
zNHtsSSopICmANWmnDcin7CejsOiTYAkt2ofbLVIusW6WpIrnYvI3MQyqMG086sO
9biSp068VD8bFvG6mFy4mK+bMrJ/uV3/w9bw/TYVnq/ULhXIcsuXC1A5ETuVOE1H
4xGyj+QdhECyPX0RdHUp42z3Dg0rayWOkr+Zhk9/nqvscAKJ6eUKNKB36jhvNNeP
UMlGWWcS6Q9ukeu8V8LJFbiQYuq6HLbO65xFgwTJ1EeEluiLksDRuMEPE43E3ArD
8o0in+mWu4HqZP/UerrRuQQ+2jq0v8U8d8xXMFAthPOWfDFgPIGQq9apX98XagMc
lgp1QERoNqWTfLp8K7gd9F1a893QiUXxsw0NOyRxay6j4BYrPi5F+k3fmYPPdgCR
UrtFNuVvOpd89gecLe4EGoDx7TYLzKiQ0DO3guIHDDwGDmIsGFux/C/cFi9/BvIz
6oq5/sZ8nDRvh/PJLFZQFs1YXTe5msT6iX6sDZ/eaGIawkamkAVBbtuOP7U0mvxm
TQp7ZzLsjnkOhrA0hmyASZ4IUCyU6cO72DPdL8kKJ4FcCFVz0CGN9ujgjcRlb8b4
HCujQByKn4sb3WJ1FNMUZtKCdo0u4Lk2yyck8QvYzjDXGb7n0zeXsNLF6k1mnw9K
A0qYdyFYmtKVFSyZeMZwG6ZRpiAROlqahR2AElkNzCs3V2v/HIvbWyb97aO4Zo8r
tn6sGpyXfMo3dPR7pJmfZHZgb7pBCp/PsJwLoG0nUBx82tiqYab0JMqSF+QkOTNd
mYa2LlYkD6nduiE6XFcWjz9WSK7C0St4c3M9dDhz5iVXJHS+rTEq1lkfefCz0mDn
DVutLt5Pnu4qCIG1BF4JatzZ+rO8BdB9YylW849fPZ/Afc51XXJ2zX6uV1uOdNrT
RxVvo+jfsH0FVdX3AjTVeZd/gos9hD89j6Pjz0t+5aA=
//pragma protect end_data_block
//pragma protect digest_block
5PjZXtx77y7ijTQHPv26Jb0bB1o=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
N9UBfyfpudL2ETthl0/Xo4Rijye2uEAtgBwz1vip27Y8RS2lbA/l50xpV0f/iEIi
XhoO5sdKydBZLqc3gjTN/nk6qHOsONvWkcQZ5Ve4cPlXj1pnXNJxD8/AkTojSaKD
3wUiZFBRkiRuDrRghSgcTk/UddGpkeVyX9PqDDHvuRiJs29TeWbIZw==
//pragma protect end_key_block
//pragma protect digest_block
1zFAO5X8gvi7MLkif7KawlAi1Ro=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
WCBFi48PePsmXQHU49SLGkySmEc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
