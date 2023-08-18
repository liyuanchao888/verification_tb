
`ifndef GUARD_SVT_AHB_BUS_CONFIGURATION_SV
`define GUARD_SVT_AHB_BUS_CONFIGURATION_SV

`include "svt_ahb_defines.svi"

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ztTwiZYeUFRa+NUGW0MTcfZXphb33Aj5RrFg7gwjE8j3yHUuC3/1rE5ze0UIrGmv
7sgHZtq6DfVXTwlnn/VkZ7+ZFjBXx1KqNcnU6TZGbbn/bdPr2BBxhFn9hl1iAYqV
50iF8lImJym8EGzQsV2yNh6oGkjyOXBV2gTQ2CnTz/N6jzjXvWeHSg==
//pragma protect end_key_block
//pragma protect digest_block
pZDLui0HOVtiqpFHaCEUIutYmss=
//pragma protect end_digest_block
//pragma protect data_block
GrVfN4/O7KvW1ql7hDWk+yAiKrdTIGiT3IwdVXuvpvSiAY+G5Nl2VX+CFzcSPwh8
ZGNv8ePKckbjYmOP2Q4e2kO/kMN9bLXcklBrW4rfBM0/J1i/Y+wuyiOWACyazcDr
+gIng53A4RFy+2YywH9TyEJoqFuMpPG09O/SAmbR0AjIQA1TfhXDzwpkuRqw6wle
+sOzNNKfPNyS1edlZrezLOum0RlGCUX5xbH2Js3Bo4wrqu67AFlpCrD4n3P0r4ZR
KOKxcivsLPGO3i3jALky0rogi/s9yMF+brhHoksXxsqQqMgvxTn6okwFM37KnrHV
4UGgOUGezgwQXfTaJgXUuyJo3bJTLInl7GGoLNuufIkLYN0HLckk9tvr7qZ8JNiW
mV9PnNDEViOgP4vz1338TYQry9VqXau5TYezek+R5tO+mn0n9WRPhPPdwDUF1oVK
CRD+PDkfoQDIARPCXFauvcmlZcrCi15TP/5eT463rIrPTW57794LZe1GL4FPqil3
BN842WrX7X25JHigo3fjJxmKEz691sCLCGSplbOYdL1Z/igXO++/u7RJ0/dYXRue
epst0xjC/zH0ETnp646TLxkzoC4FE3yoY9e9UGhx5Kbzy7UKsh6jd2rI8ec6ehYu
lYy5s9iUzQ7Sw5ig+BmHqRLyn28JuI0GvkJ3Rd7pp09YLdgoKtW+U1MYqEb6Ngtq
qdCleyNWY4ySW9Z5guc3+34aFJJ4RySdLl925f0lezdTK5N/10Fe62EjDtgvU+Rh
7HTBM2R8eCJ9RJJ3X+4JOnv137ziXOSooh2m2uFKMa0rtclsurj1/TWMZYxoC1WZ
IgqLmMPvd0xVp8UYWhkip9L1afEM4Ht7nqWpkPU18TaBS4Nmw4LvgDWSJi6Jc6O8
+zhnLxm/eWcYvt/JLankW8lXj3N291T6S2RB9p33jmUpp0KdU54xGwzNYzezwiA0
OVSpZeBCtB8jeC5VmuecyL9/mHj2GtfbgOK189BzW+1xmTdLK7TS2qsePy2gwVm8
LiYtOXC0aGJjZpfovGJzT27YlS+V5H++YJ9naxodA7+8L8sUV1MZUVYnibzeWHl1
xRuD39YsmZd9t5Lay0mhvLVlVRfpQlYfhqGSqbYQpj+FQoPPUCgF8D53ILYM8pGQ
D5e2Rs/2pIDcVEhbLaR4bc6W1824JJCopLvEqVA5YTYHI20gXglPgjHk6zjJpo3w
WHK1pOrHxEIAlzg/qJu5JHwzsgEl9amrrymML+28Sni2P9NqBQ+Bve1ZGYZIFzey
KQQXdErLPDqTp49E7K3C47mRdzLhOLgnzZ6KBOorSLvn0cLDJyJRpGqVKMwtTys3
jKzfRUPig+yQCUdRs9JC7laINQEoCrDqTprY+4i9TPT9osW4N8L29Ie3v6CzVOG4
/BCs6abORAbjJanaBFMfTJvhjhBIJ/z2E+Yg4nzYiLoLcTQSR351RJ+gnBKuaPpl
mbgihrYvnP/HSU1nMM5xSgFOpl3B9Dy7J2/DxIF6MlhA5i6IX0sPoNwlpY9TBVZi
CaAbd4zrnI+ZhRsMmfq1gdk0aUr9vX/THgNG/Z/4fW9OJDtuG3LYHf6XhS0DAgb/
orGOJf665Ivv+x/zE2JhlQ==
//pragma protect end_data_block
//pragma protect digest_block
pqtJE2sPHJacJyLo5cncZ/mzd9Q=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
u63ZE7gVq3+XFZEJV/sMlGFY5vVoTz+Lg/f7v8AWLeVcMuLyBlgWgr9Uuh+ajQ5z
oLCH/u5Tc4HToLYSnT3wXCCVo5vPNsMv0A6i6tTLW/UzREyDh/CGLD36V8nHRNcn
DKRK3GiXd2G6Kqfyq8EiDLDHrzVJqxTrEPUCH3lF9OlWaOSNB8OBpw==
//pragma protect end_key_block
//pragma protect digest_block
y2z55cbwBleUAmbZP/ayJLBD0cI=
//pragma protect end_digest_block
//pragma protect data_block
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
BZdxkGXcpqaUqAvyahD9pg==
//pragma protect end_data_block
//pragma protect digest_block
2/axMo0qShobEdYWoHEfrxcbXns=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zuBFkiWvUqJ3eAonuHjJFdAxCTBDMHtIH/0kD4mYH5zVuqw3sejE3aEGFIp06/I+
xd4+YgB6P168kiT8+KVX9pLOuR/v+fAtT9jcKCyazzvCs9l/hPZVqMbxsAmFD/xA
dk+f2wYumUYKLRKrPaT5SZb3LbzErLi33Dk76OpDsoEvoF9uAgtlXQ==
//pragma protect end_key_block
//pragma protect digest_block
ztNDoo2t31HebSe1O6QnNPKNhOc=
//pragma protect end_digest_block
//pragma protect data_block
IYUeDHD0Mw7LxIacAO30O+dc0QYivto9IL8O+fMZOyVBtxhREAyla+B0Z8GonoOi
v9VM9Pl6/N++fLdvcufGg7rbwf4GKALLFB8NIPUkWanDixHZiI1VmIh0XSEgX3j0
f0z367PEjDCuFLWDR/M8b5+hxmWyn2D0IyxQmITPbCJ1fYtImBWIlJ1KWQ7i0d6N
2yy+tb37MI3OgN9E2OYcwT/+54i0FiftJbr60W2kxuVImmlSbRYmQN7nbzV30j0a
kt6hZhslE/08EYbEd4KcrAHkGWsd6u76Jd5PKIs1thLkDU6JW4PdxgOL0u2IXCu/
qf+7+DBowi5V4UaVIhvEk8PNNNAAhvThXvoXBP+L8nvGz5hRQZT2c/Y7QHfMWYuz
8wwOKluJdKIJl1psfA+NzSyVzgOSHGtQnqmSEeY1TRX3dFuqt4Gn5oFlj9B20F1R
b7pPFVrPesXPDx3ZYs9Cl33GWUzLUiauEPy7tNyuK26XKBhmiJUKb1oEP/hasKo2
ZvboGplDNeCSLq4p7Brf58tZFr1dZanH47uNtSW7CLMJcb2OxDaXIFAYmx4U8Wjj
uD12a7pmBKX58xAUJ0m9EATH+nGwV9kVI1Hcsm1yJ6smBdvH10jicGp83qQ86ceQ
DziCswqpDQujsFbNdJQ93WsXZOgFXC2aLk27ig4TDc3pX1hzmb5VZizZf5Kf1Mpi
hNMzrBxRsPqAnOQGPsIcbgqdIkJFctsCHXD1VjeZeBVa3rK5hQKxpHsubp/E+FdH
IEJLHC/Z3SP+2bQf4R1I25Yrn7csHFdYFcAT99y2jNFY4cm7ayoxnNlBf5ks/x3l
GaumxaFYp5LMXWPJqQ11mneJ0CMOjiIqc7kPyzU5G+mLEGXMqU9sIScogos0iXb4
JBGxLL6w+uPmrvH2BGgnJg==
//pragma protect end_data_block
//pragma protect digest_block
lEKIwtYgsnfUWs7g1/RtSmtVvMo=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
aeCUpoby18IYd2l///Ro4ShRhFpSLdap2uPkHHgXYdlf14sJ6nP6+kcdvj7t6TV6
vzrCNxFCc5e4GUEtSDTLeV9o8H8FgqcMEQLeoZbG2AX0cNQkpGJr+3J21SKpQ8j8
ZU6wmLbFm1n0HgrtTb3qRQiFgUOmr5mMOhaRtbGRE7KPy6+QgntMHg==
//pragma protect end_key_block
//pragma protect digest_block
i9OiFHGmFvpsnAy7cSNCEGBQLeY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
dZGxAQ2nsAUEd6dVieE+yz1M1Vg=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
/** @endcond*/
`endif
  
`endif
