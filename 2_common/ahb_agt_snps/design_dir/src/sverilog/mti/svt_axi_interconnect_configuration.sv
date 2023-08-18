
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



`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TwFysinLXqOhLZyOo1ejP+IC799m8oq23uTM2zXP0lfWAOQtAOrPTufC0uIC/jTI
d/iTk/NRYWObNBv9kVMrxK/+mLu6VVdqTrdS8doMzLEEJcGt6p4Hld+AIptvNVQs
CvWCpO328letxi/O0QHdJSo0duzJmLpojmUJpSG7gao=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 670       )
qPXdSl6x11m5FnSwSScaHnxifMPFKdOrVicZTa6b6IlVjI8/tVe3oAXIeX4iVtwe
nfwt1N99mSdLwPJj5g2qHBurT6Zkn+cd3snqL2771Yp1P48q39G98BICHtPgqmro
Dnzqj+SKs+leClNc1/PSYmN3CXansIN1SsDj+AcWgDmx+0FzX6oqP8fOSqmB7Z21
cXWTeOBa8uIH9KoSvFFPW8mnFrG8MpBEADAZ5FUIC1BN0kFiQCE3VK9CjK37FIRn
GP7GAyM4Bt8WX/j/1KGOWmrLB9/AVQvSdPf1jZg1bWLgt3QBIpZNCBK4IAjIJDjj
299NnvVs8GZyQ+G6lhweBl9CQ+ck54HtRyHcQ9K1GAfR6TrihJN0CZPZ6jpWwEC3
uDh1r1jC+9obpcBAdp5DqcZHYkOFs5ikoEDmHEI4jRSH0mZyek2uK0e+IAIFAiOg
C6+7TP32fzO/A7lio+bPHcJK5ZFs72AqswhBw/7N4+3nXj0SlOjKJ9/98ItAglRd
ayBIdPp53y0fjlFIaG3bB/O/LPKQS+3V+IevpG5ztEnjXzUjmixC7C3/ENFAuQaA
Vqo3fAnW7SKNBnKNEz6AbjMrsaBBb3U3F74co7kWbVz7K/uIDGubwaM8ELkskU6H
ZkH1ExHELwjKHPXxI6prEkvbuSpMDsRlhDyuxs89nygKdMzcdhLqrAt6+YbI0kOd
LD7ROjlWozYsjun0PtawJUwDmBF+AKqtwrkXhNXpbPtOLzwLQ+n+2tCBFwsWCAB3
QInLSf1fZTzAWPgjXFI1jtD8glNEacFY4PxcK02HIt0+oZrbNkFapEtikPOYgwID
IAt0l/oAsxmfc4A+SOluczUfsRgRduH8tY/FAJCqAmpf21bSsG2we1cuVaHdjKmA
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kqffN+j+vAH4X9lhKaXPlDScAl0HRS1Bw+7EyYXXZ7cIx5DBu8HHfwQkMa1ng0tl
H0ODSkZALU966/VNWwpW5yjnuAFIO9nEI/yk0SdIs2+JVq73V493WpPSJoaj/VEy
MQRHLLL5DbrGyfVFllksn69GXxEPKpyCwYFxCPOtNh4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23975     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Xlh72GL5iYTXqIArqrXg0pJCf0IcUaw5aj2zJ6+xNejGQ8S20ucNsq+gSoH8k/jE
6OvnHDJwCw0k8bK5m0xvbq7Av93P8yaO45/0H3/pa1+vrozMaippyQFpt47atpeo
hp75UEGWTgTS/0rKKyjoWJlqEudaszN8bz1olx0suBw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24058     )
+I7tBZGsgEUVCvqkA00WBdXqxWXg6arHJFGXAidtMCHKGQUwBnXwQtsype/spi6h
TkJBZcW5b3PX9Q9wofJTA+nw21yJCYpNEjC8cyy76evwVapZjT9KwkyGdQdpmBW5
`pragma protect end_protected
