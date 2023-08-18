
`ifndef GUARD_SVT_AHB_BUS_CONFIGURATION_SV
`define GUARD_SVT_AHB_BUS_CONFIGURATION_SV

`include "svt_ahb_defines.svi"

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mw7HH+nHjdrhdPhYjIjrRSV+7BGg3zswHdHm4ZpflUt2IAaHoZot2/cn+KCFojf5
OXZk9cS78BkvOjyuk6ljxlLbisCXSDzvwASPu9G2LH51tjrLW1WCNIH+NMWP3AyI
WHCscEM7XsqLURYQOaKSM2Y26CtAzf+ESBX61hQxsRs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1039      )
55s5rAhCmSEvomaO6RDcqvKz9Sqpv96A/6AAnTbvdr5QzVWbci0Hz6ah8UGPLSKn
DsTahhl8aNRIS8Lj3qm2vq04q/nv49yleLnrii3wOYAynoNi21VyZk2vBtZS2e2g
twjSNQV6NBDM5GjMvQAtw5M66lWieYWgTMEteOAB15Wgh/XfmkJgCJMoSaygvVZW
T7j1JHwuHy0DGCTK9d3nD6Gn+AJ1N5DZwffuMvQeYAcbFDH7M2QeNm26Ubz4/oRw
rVHVcTODWOCeiHsrX/KhiISsDUa2qr0nRjnNUSIswa3V7yq/TWF417lrNS5yDBsj
v0CO5OMB/Cdas2ktFuWyc9AbUbHPPLDYQNrlPcuqWqEWEyOYDIf6dE3tYCErM3E3
F58qjNKWteTkNAxq7/BXA2DpbMqJevmSl+78zgapY3LPrdOgn/jiN7Sk1WqHxhYM
6d6XTPiFYQhfIAMb1oKso0b3+MWA+yEHpWk5raq3XACvK7bd5N+XHLmv4H4YjjhO
1zkLi/LPUpKOzS87uaQSuhq44wInNkQS4aDtjVwslPAsg7l2qco4YXjCeQsUIzj5
OGQP7gc6YW65xVeASY7El9NCOJ1aX+2//ycIj8+bK+7oTabrFdGKQofibq3Q7iu/
yAlrMraSd0mO+e5OZ9+mtfsqg1SEIazebdUVjcluJgNXMsMXITdggFPQZLNOJgJ4
wLh3suOuRSAJQxsruocAN4DjRnif/4+Y2pDchiZGY/QpqrQM4Wjy+zJZ7Z0jyKn5
WDRVaom5tozPs989grhV6GA0ptwWJBGY+6Ly/MtueAC7kgxpO/pSHNczxpaVN3mn
ftT/wr61ot5zbmDw9rny64Ga/HKNd5sOVAb7Xr2TJGqY9AZLWIV+QP3A6l1ikOqc
rOmzMaKxeLBvvC810CY0255bGfvgVGfGNt49NrogE3jvWUYxQWa8HFuwawO/Oj7V
ANVHZ3kmPd79Ge4JMDuWbgpYjTB5KSauwTxOuXYDU2kWThrfWeZ2uPM8aFsfDvgW
zIKQYwDxJDPWH/JLXjhhmqRQ3j/SHClhUsWbEZzO/zxui4AJ1hwmGUHvSDIuBbsh
S4RKgy1eEF4P8hoJltrmw4wboWR6RoEnsrZBScR38QEJAuoqLzEeJBxaPTvBIdeZ
3CxN5wTHZ6LDZ3AtIYTfLddEGhDW2V92g0sDoWChaQlm674PUr024hQ1WZsRb63N
p24Y5MfJHDmZpTN048iNy7MxV7UqMvJVYbL1PrLF6V0FEMqrlvJ2GFnyeKidvti6
KFUye3y0lOnYKWfKO0zYnYS5A7/fLzbpfSmdSVEERwvBUokh8EgVQPPbD06687H+
wJtwOJBf83hvljAEDsQWfZTEVEUtrDNLiCJJhPnFUNc=
`pragma protect end_protected

typedef class svt_ahb_system_configuration;
typedef class svt_ahb_configuration;

`ifdef SVT_VMM_TECHNOLOGY
/** @cond PRIVATE */  
`endif
  
/**
 * The base configuration class contains configuration information which is
 * applicable to SVT AHB bus ENV.
 * Some of the important information provided by bus configuration class is:
 * - Number of bus masters
 * - Number of bus slaves
 * - Address width of the bus ENV
 * - Data width of the bus ENV
 * - The AHB virtual interface
 * .
 */
class svt_ahb_bus_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual AHB interface */
`ifndef __SVDOC__
  typedef virtual svt_ahb_if AHB_IF;
`endif // __SVDOC__
 
  /**
    @grouphdr ahb_bus_generic_config Generic configuration parameters
    This group contains generic configuration parameters
    */

  /**
    @grouphdr ahb_bus_signal_width AHB signal width configuration parameters
    This group contains attributes which are used to configure signal width of AHB signals
    */

  /**
    @grouphdr ahb_bus_signal_idle_value Signal idle value configuration parameters
    This group contains attributes which are used to configure idle values of signals
    */

  /**
    @grouphdr ahb_bus_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable coverage and protocol checks
    */

  /**
   @grouphdr ahb_bus_ebt_control EBT control related configuration parameters
   This group contains attributes which are used to enable and control EBT settings 
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

  /** Enumerated types that identify the type of the AHB interface. */
  typedef enum {
    AHB        = `SVT_AHB_INTERFACE_AHB, /**< Interface is an AHB interface. */
    AHB_LITE   = `SVT_AHB_INTERFACE_AHB_LITE, /**< Interface is an AHB Lite interface. */
    AHB3_LITE  = `SVT_AHB_INTERFACE_AHB3_LITE /**< Interface is an AHB3 Lite interface. */
  } ahb_interface_type_enum;
 
  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  
`ifndef __SVDOC__
  /** Modport providing the system view of the bus */
  AHB_IF ahb_bus_if;
`endif

  /** A reference to the system configuration */
   svt_ahb_system_configuration sys_cfg;
  
  /** 
    * @groupname ahb_bus_generic_config
    * A unique ID assigned to the bus ENV corresponding
    * to this bus configuration.
    */ 
  int bus_id;

  /** 
   * @groupname ahb_bus_generic_config
   * The AHB interface type that is being modelled. 
   * Configuration type: Static
   */
  rand ahb_interface_type_enum ahb_interface_type = AHB;

  /**
   * @groupname ahb_bus_signal_idle_value 
   * This configuration parameter controls the values driven on the address bus by the
   * AHB bus ENV when the address bus is inactive.   This helps in detecting any
   * issue in the RTL which is sampling the address bus at an incorrect clock edge. 
   */
   idle_val_enum bus_addr_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_ADDR_IDLE_VALUE);
  
  /**
   * @groupname ahb_bus_signal_idle_value
   * Used by the AHB bus ENV. This configuration parameter controls the
   * values driven on the:
   * - inactive byte lanes of write data bus by the AHB bus ENV, 
   *   and also when write data bus is inactive.  
   * - inactive byte lanes of read data bus by the AHB slave model, 
   *   and also when read data bus is inactive.
   * .
   * This helps in detecting any issue in the RTL which is sampling the data bus at an 
   * incorrect clock edge.   
   */
 idle_val_enum bus_data_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_DATA_IDLE_VALUE); 


  /**
   * @groupname ahb_bus_signal_idle_value
   * This configuration parameter controls the values driven on the following AHB
   * control signals
   * - Hburst
   * - Hwrite
   * - Hprot
   * - Hsize
   * - Hlock
   * - Hready
   * - Huser
   * .
   *
   * Following are the different Idle conditions
   * - Normal Idle cycles
   * - Idles during EBT
   * - Idles during reset
   * .
   */
  idle_val_enum bus_control_idle_value = idle_val_enum'(`SVT_AHB_DEFAULT_CONTROL_IDLE_VALUE);

   /**
    * @groupname ahb_extended_mem_type
    *
    * This configuration parameter is applicable when svt_ahb_system_configuration.ahb5=1.
    * This is used to support extended memory types in AHB5.When enabled, this extends 
    * existing hprot interface signal from 4bit to 7bit signal.When disabled, interface signal hprot
    * will be 4bit signal.Applicable for AHB Master/Slave and in both
    * Active/passive mode.
    * 
    */
    bit bus_extended_mem_enable = 0; 

   /**
    * @groupname ahb_signal_secure
    *
    * Slave for which separate secure & non-secure address space is enabled i.e. bit is set to '1', it will accept both secure
    * and non-secure transactions targeted for the same address. However, while updating memory it will use tagged address i.e. 
    * address attribute, in this case security bit, will be appended to the original address as the MSB bits.
    * 
    */
    bit bus_secure_enable = 0;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** 
    * @groupname ahb_master_slave_config
    * Number of masters in the system 
    * - Min value: 1
    * - Max value: \`SVT_AHB_MAX_NUM_MASTERS
    * - Configuration type: Static 
    * .
    */
  rand int num_bus_masters;

  /** 
    * @groupname ahb_master_slave_config
    * Number of slaves in the system 
    * - Min value: 1
    * - Max value: \`SVT_AHB_MAX_NUM_SLAVES
    * - Configuration type: Static
    * .
    */
  rand int num_bus_slaves;
  
  /** 
    * @groupname ahb_bus_signal_width
    * Address width of ports of the bus in bits.
    *
    * Configuration type: Static
    */
  rand int bus_addr_width = `SVT_AHB_MAX_ADDR_WIDTH;
  
  /** 
    * @groupname ahb_bus_signal_width
    * Data width of ports of the bus in bits.
    *
    * Configuration type: Static
    */
  rand int bus_data_width = `SVT_AHB_MAX_DATA_WIDTH;

  /** 
  * @groupname ahb_bus_signal_width
  * Defines the width of AHB control sideband signal control_huser for bus.
  * 
  *
  * Configuration type: Static
  */
  rand int bus_control_huser_width = `SVT_AHB_MAX_USER_WIDTH;

  /** 
    * @groupname ahb_bus_generic_config
    * Enables control_huser sideband signal in the bus. control_huser signal can be 
    * used when svt_ahb_bus_configuration::ahb_interface_type is set to AHB or AHB_LITE.
    * Configuration type: Static
    */
  rand bit bus_control_huser_enable = 0; 
  
  /** 
  * @groupname ahb_bus_signal_width
  * Defines the width of AHB data sideband signal data_huser for bus.
  * 
  *
  * Configuration type: Static
  */
  rand int bus_data_huser_width = `SVT_AHB_MAX_USER_WIDTH;

  /** 
    * @groupname ahb_bus_generic_config
    * Enables data_huser sideband signal in the bus. data_huser signal can be 
    * used when svt_ahb_bus_configuration::ahb_interface_type is set to AHB or AHB_LITE.
    * Configuration type: Static
    */
  rand bit bus_data_huser_enable = 0; 

  /**
    * @groupname ahb_bus_coverage_protocol_checks
    * Enables protocol checking. In a disabled state, no protocol
    * violation messages (error or warning) are issued.
    * <b>type:</b> Dynamic 
    */
  bit protocol_checks_enable = 1;

  /**
    * @groupname ahb_bus_ebt_control
    * Enables EBT feature.<br>
    * When set 1, other EBT related attributes svt_ahb_bus_configuration::num_ebt_cycles[] and
    * svt_ahb_bus_configuration::num_mask_grant_cycles_after_ebt[] are used to control the EBT from the bus VIP.<br>
    * When set 0, other EBT related attributes will not be applicable in BUS VIP.<br>
    * However, EBT can still occur when Grant is taken away for the penultimate beat, if BUSY cycles are driven<br>
    * between last two beats of fixed length burst.<br>
    * 
    * Configuration type: Dynamic
    */
  bit ebt_enable = 0;

  /**
    * @groupname ahb_bus_ebt_control
    * Specifies how many bus cycles a given 'master port ID' can own the bus 
    * consecutively before EBT:
    * - Default value is 0.
    * - Value of 0 indicates that the EBT settings are not considered.
    * .
    * Configuration type: Dynamic
    */
  rand int num_ebt_cycles[];

  /**
    * @groupname ahb_bus_ebt_control
    * Specifies post-EBT arbitration masking for a given 'master port ID'. 
    * - Default value is 1.
    * - This cannot be < 1.
    * .
    * Configuration type: Dynamic
    */
  rand int num_mask_grant_cycles_after_ebt[];
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KX57WQKX/qOM82Z4nSbW2gvIs9AIyPvRNoDr0xDxwVuQD2RB2Qt5XA8EXif5psad
9Oo+lI/bvdWoxN0BI4wSiSqsBaXcO/YQhv+e+JhOGk1Vsm1d4ztkoTWu+TbB8VaN
0DJldplyOAVQ11KakPenwESGde2HWlzItSi4ONuLY2E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3614      )
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
`pragma protect end_protected  

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_bus_configuration)
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_ahb_bus_configuration");
`endif
    
 // ****************************************************************************
 //   SVT shorthand macros 
 // ****************************************************************************

  `svt_data_member_begin(svt_ahb_bus_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_enum(ahb_interface_type_enum, ahb_interface_type, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(bus_id, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(bus_control_huser_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(bus_extended_mem_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(bus_secure_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(bus_data_huser_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum(idle_val_enum, bus_addr_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(idle_val_enum, bus_data_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_enum(idle_val_enum, bus_control_idle_value, `SVT_NOCOPY|`SVT_ALL_ON)
    `svt_field_int(bus_addr_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(bus_data_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(num_bus_masters, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(num_bus_slaves, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(bus_control_huser_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(bus_data_huser_width, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_DEC)
    `svt_field_int(protocol_checks_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(ebt_enable, `SVT_NOCOPY|`SVT_BIN|`SVT_ALL_ON)
    `svt_field_array_int(num_ebt_cycles, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
    `svt_field_array_int(num_mask_grant_cycles_after_ebt, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
  `svt_data_member_end(svt_ahb_bus_configuration)

  /**
   * Assigns a system interface to this configuration.
   *
   * @param ahb_bus_if Interface for the AHB system
   */
  extern function void set_bus_if(AHB_IF ahb_bus_if);  

  
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
  `vmm_typename(svt_ahb_bus_configuration)
  `vmm_class_factory(svt_ahb_bus_configuration)
`endif   

endclass

// -----------------------------------------------------------------------------

/**
Utility method definition for the svt_ahb_bus_configuration class

*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IpvsqUyJeXwnDWSCD18Q45XFqrKS5WrwH2NjrHb3AVbQrIw0cgnoXpqWS2/jprT3
FhkQI2K/IQDMZNiiQ77Vni2JEBdl/C4hM/6anAtQglrQ1bANZthGzC5xkX5V/nKv
PFyk36+eqbLxvANGqy9PAecXNWQCsFHCfp2qhmO75XM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4123      )
GFRs65p1w8oF0FrAuAMFEJqL057mxiZyzKXLt7Vi8x7AdbBqG9jlXbwIw5bM1fsn
rsYfB5XX+lyypq2weWGFmb0nu5ygnb8JqDzhh2JnDdoyIpYvYUTZxJyPmt6YiWMt
rDWs6K5SEjSTY9g2MxeMvVFJXxjTfi88pOqv8h9SSC9Jzp4mCFFFFohrh9ROciod
QK1KasOL5edOTQUYWkcsrhTcSsvxrkTjMmqFWR838LASZjNECgHzUXJAqcNMhpsn
h+3ckYBx6mQEWLGLxhPudy/9Oqr0r3L3XxdsqjEASPRs0NW+pM1BqPz0e2jqbfC4
Fnkahf/dVVkqDXYU70A5HIzEqag+k9FE526bAE4lT4Nok7u1nBwQIJOuSXiaw8tk
UckWDlr4X6wieR6P8uYNazfteUH6nelSjUgbwrvBHznPaDo/6N7fOnCYeiyhsU+M
Raua+m4m36ULBt1oBC16tAUs/1lEdFhSZ8b3ovhXe3AISMv60vDgVyo7pR3j5V6l
YHA+Btlj4yxoxWu8SXWcrmPFf6salqKmKfL552ZCi5qBXgFKH2x/wCeNIJ51MDXf
sfc51tgexRkSEc7F/N/45eqiFFt9I5fxjxA0XSAq+vdhW63GCjVB1J490p52Avns
mCtnKitndE/IlopkCaMIbJnrnno0g1zl1HeTxopFgM0=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MRlTr/l0i9kodtlY+zNvLKai0U5QO6KTfBE+9XKp/dK/Q8RmJqIhJ49Vy7FDWSdp
p7D/l/gShrI6C/nkP/OjiO3SudnEgC4X0h9VopMZbB1cOX/+NbmXOv1Zy9/etBHv
nsVzeSdMx7dOwPwNQRU5hyhUiLvWNVILW2ozglsjoDA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24385     )
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
BX/yZ6pZC9jCtd/sotL52Q==
`pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
/** @endcond*/
`endif
  
`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DmQkjjXY2mnA23VLRLZHzSDqNu3+fNeHB57GfDbLjyyTzN+wAhjPdX+R6ykNB63G
Y3xGV5jbBsW8MV7GWSRVizD6u/xPbeLNtKSuiFuX/0YwHWTmtVunT78f7Qrz3YOD
+733sH6JWGcsAY8E2OmC9ZbSElmm8V8EgnOdGNevxYc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24468     )
2m4xLLfZTTORap7zKDOdjHH9efb92qpA3/AbpP5JAtU4BqPxwdqPi5gUzdkFng/+
Y5cUQIRKi6pjNN5aU/KvR7ORwY5GjEDY0fc0RzVyM24TxpeZ5q8okhjms0JXwICb
`pragma protect end_protected
