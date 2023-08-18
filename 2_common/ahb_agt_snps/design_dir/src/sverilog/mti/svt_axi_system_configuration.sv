
`ifndef GUARD_SVT_AXI_SYSTEM_CONFIGURATION_SV
`define GUARD_SVT_AXI_SYSTEM_CONFIGURATION_SV

`include "svt_axi_defines.svi"
`ifdef CCI400_CHECKS_ENABLED
`include "svt_axi_cci400_vip_cfg.sv"
`endif

`define SVT_AXI_DATA_UTIL_IS_VALID_MASTER_IC_CONSISTENCY_CHECK(param) \
`SVT_DATA_UTIL_IS_VALID_SUFFIX_INT_W_CONST(master_cfg[i].``param, ic_cfg.slave_cfg[i].``param, \
$psprintf(" based on master_cfg['d%0d].``param('d%0d) and ic_cfg.slave_cfg['d%0d].``param('d%0d) which should match", \
i,master_cfg[i].``param,i,ic_cfg.slave_cfg[i].``param))

`define SVT_AXI_DATA_UTIL_IS_VALID_SLAVE_IC_CONSISTENCY_CHECK(param) \
`SVT_DATA_UTIL_IS_VALID_SUFFIX_INT_W_CONST(slave_cfg[i].``param, ic_cfg.master_cfg[i].``param, \
$psprintf(" based on slave_cfg['d%0d].``param('d%0d) and ic_cfg.master_cfg['d%0d].``param('d%0d) which should match", \
i,master_cfg[i].``param,i,ic_cfg.slave_cfg[i].``param))

typedef class svt_axi_port_configuration;
typedef class svt_axi_interconnect_configuration;
typedef class svt_axi_slave_addr_range;
typedef class svt_axi_transaction;

/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_axi_slave_region_range extends `SVT_DATA_TYPE; 

  /** Enum for region type attribute 
    * - RW   - Read/Write
    * - RO   - Read Only
    * - WO   - Write Only
    * - RSVD - Reserved
    * .
   */
  typedef enum {RW, RO, WO, RSVD} svt_axi_region_type_enum;

  /** @cond PRIVATE */
  /** The region id for a specified address range.  */
  bit [`SVT_AXI_REGION_WIDTH-1:0]   region_id;

  /** Starting address of address range of a region.  */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   start_addr_region;

  /** Ending address of address range of a region.  */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   end_addr_region;

  /** The characteristic attribute associated with a specified region.  */ 
  svt_axi_region_type_enum rtype;
  /** @endcond */
 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_axi_slave_region_range");
  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_axi_slave_region_range");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_axi_slave_region_range)
  extern function new (vmm_log log = null);
`endif

  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_VMM_TECHNOLOGY
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

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern do_allocate_pattern();

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



  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_axi_slave_region_range)
      `svt_data_member_end(svt_axi_slave_region_range)

endclass
/** 
System Configuration Class Utility methods definition.
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N6P1dzBZvgen5Rc4YQ0XckFZ5FzvhOTLp0qLXxsDKYLxjQ/l39RiIQaqUTc/WDul
U1gfSud9F9M8ew7i1rl0idcmZRE4/3tedZaHwzNX9rOvyBOHDMR+vXFmJ9A6XU+E
PlN3D/xg+DVBAYHhCoqENvyJCQrHMueNqTNuD+JwTUE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 553       )
k/YcuN+Dls7R97LxU/TI9u87lQx2qKhdmyQR+n52uPtkVWjf6xs9ibzzByko/5yi
JNxW7Zu5Pmkgtp2Inmc8YnEfBppR8bdbhP/uI4oyeXgbbZeJOQkVm4N1oVyyL9x0
SEoxzdvVKMLs8Rk1wWCV2FKva04EqpMCvVX5xBg6oeLyaJpeR2brurUuuBmoaAQC
J9uZS5A+d/LMPXcoJfHtDN9ECJTMehFqwwFcrN30MQCjwPfpQ++vBQAFW70I1khd
UXLDdSOb1NE0iCOSBFE/bYbEcasVDcCtdErkei/qb248kvZl5Y6vShE6Lkqv5SGa
gVVceD7WyQeuD5FBfx5npsdnTB4D+XY/JJyB3fULbKCXLXzRASOZ1zoErUfrNEWK
czrpx7Pgq3o7IiX26Qg5EqPOwKsSdCKIdUK+5U+sNMTXrr3P98uZbTzWaQtied9l
xqhusgDYMQ5wGltknHo1Vq6WOF95fYH6dGu3w7ZMKZUXOnuIph3oUMuO5DwdIsNg
+RZlpgBE9EQ/OTXQgJJsX4HWHme6k5x0z2rMp2Gc/yRpUxlgT8gII7jR1nflWf0s
VghQLVbEcK4Athr7tsn3HVP3LVVMEEbLtGqlvrd9sPh6svckLeRYmUE152UoOfG4
ax6j4u0atko7yUh7RiHbDnCgMD+gXK59TJwmque9gb66cxHX6m5EcP3IFzzj1/T6
RU9JvaxLFASsqUkHiY8TL7KxpwEPPzDolrQtKmzqLXI=
`pragma protect end_protected

//vcs_vip_protect

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZSU5BvgDT0sUeula6Vz0EY3sPRIsuOzzysgcW7xPAK5COxp0zLuGWNVysmsKakMA
kwtNS16P0IGdKQQ9nmCiysj9mJLKvoGla8aX0sCQrgJdA1JNnWaeenx3pNxZOZyr
INyZ+1D0JyWS/eaVK+l8Tbj57D/48bkMb/RCbe9y15g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9328      )
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
`pragma protect end_protected

/**
  * Defines a range of address region identified by a starting 
  * address(start_addr) and end address(end_addr). 
  */

class svt_axi_slave_addr_range extends `SVT_DATA_TYPE; 

  /** @cond PRIVATE */
  /**
    * Starting address of address range.
    *
    */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   start_addr;

  /**
    * Ending address of address range.
    */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   end_addr;

  /**
    * TDEST associated with a slave
    * Applicable for a slave that is configured as a stream
    * interface (svt_axi_port_configuration::axi_interface_type is AXI4_STREAM)
    */
  bit [`SVT_AXI_MAX_TDEST_WIDTH-1:0] tdest;

  /**
    * The slave to which this address is associated.
    * <b>min val:</b> 1
    * <b>max val:</b> \`SVT_AXI_MAX_NUM_SLAVES
    */
  int                                slv_idx;

  /**
    * Attributes associated with current address range.
    * [0] = Indicates secured address range where only secured transaction can get access, if set to '1'
    * [\`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH:0] = RESERVED, should be set to '0'
    *
    * NOTE: This attribute gets set through /#set_addr_range() task as shown below-
    *       set_addr_range(<start_addr>,<end_addr>,<addres_attribute, ex: secured>)
    */
  bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute = 0;

  /**
    * If this address range overlaps with another slave and if
    * allow_slaves_with_overlapping_addr is set in
    * svt_axi_system_configuration, it is specified in this array. User need
    * not specify it explicitly, this is set when the set_addr_range of the
    * svt_axi_system_configuration is called and an overlapping address is
    * detected.
    */
  int                                overlapped_addr_slave_ports[];
 
  /** Region map for the slave components */
  svt_axi_slave_region_range region_ranges[];
  /** @endcond */

  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_axi_slave_addr_range");
  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_axi_slave_addr_range");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_axi_slave_addr_range)
  extern function new (vmm_log log = null);
`endif

  /** 
   * Set the region range for a specified slave within the specified address range. 
   * @param region_id           Region Id for the specified address range.
   * - Min value: 0
   * - Max value: 15
   * .
   * @param start_addr_region   Start address for the region
   * @param end_addr_region     End address for the region
   * @param rtype               Region type of the specified region. Please refer to #svt_axi_slave_region_range::svt_axi_region_type_enum for allowed values.
   */
 extern function void set_region_range(bit[`SVT_AXI_REGION_WIDTH-1:0] region_id, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr_region, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr_region, svt_axi_slave_region_range::svt_axi_region_type_enum rtype, bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute=0);
  /*
   * Checks if the given address is within the address range
   * as defined by #start_addr and #end_addr of this class.
   * Returns 1 when chk_addr is within range, otherwise returns 0.
   * @param chk_addr Address to be checked. 
   */
  //extern function integer is_in_range(bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] chk_addr);

  /*
   * Checks if the address range of this class overlaps with the 
   * address range as specified by start_addr and end_addr 
   * provided by the function.
   * The function returns 1 if the addresses overlap. 
   * Otherwise it returns 0.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_overlap(
  //  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr);
    
  /*
   * Checks if the start and end address matches the member 
   * value of start_addr and end_addr. 
   * Returns 1 for a match, zero if there is no match.
   * @param start_addr Start address to be checked.
   * @param end_addr   End address to be checked
   */
  // extern function integer is_match(
  //  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  /**
    * Checks if the address range of this instance is specified as the address range 
    * of the given slave port. 
    * @param port_id The slave port number 
    * @return Returns 1 if the address range of this instance matches with that of port_id,
    *         else returns 0.
    */
  extern function bit is_slave_in_range(int port_id);

  /**
    * Returns a string with all the slave ports which have the address range of this 
    * instance
    */
  extern function string get_slave_ports_str();
  /** @endcond */

  //----------------------------------------------------------------------------


`ifdef SVT_VMM_TECHNOLOGY
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

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern do_allocate_pattern();


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_axi_slave_addr_range)
     `svt_field_array_object(region_ranges ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
  `svt_data_member_end(svt_axi_slave_addr_range)

endclass

// -----------------------------------------------------------------------------
/** 
System Configuration Class Utility methods definition.
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e+1SXSxhZAKtOp7wM1T5IkrzwnE1XUKv30uAgwYiLeUYz9F/CsdVkEq8ZcYeLRex
SaZipujhDqPSJI83cjGiXo5ulqNQ549MfdA4jIv4F1zs0+0pBeWRudLSEoMkPVOx
Ib/K5A/bO3OXUZXTOifskB/Wmmv27pkxE27wPw4j/48=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9867      )
Q5dTnTkWBGq1MFi7cN0uEpPJJqPWapV8umLz1j3Z/8tuKWyFKUGtA9OeK2PzKmKM
tlK7fMauAO6h97DD2rsYTe/7gi+TClCogDT6AUUl6UqHVw8Yu3vCuVWQQxj2mj6v
bYLyEQ1v4d9Aio/ryKUgg3H45+ME0MLEw5y9/UvCL5svGxq8f2i+kjLFf2VDzV8W
bvQ8kRMHXcQJmCyYNsp+zprtAQCfst5nwZMJdQ5HgrJvvuYwg+ZAHBPoKvUITfje
b4SlTrynvXmb9KRkR9N7FuxseSM6ZJ+KIb6ku15EJUGBRJHcSmMXqv2j7XAxmwSX
Z4cAmAPqwGI0Nf0453oo9huCmuGH1kxYXot9Tx/FbwrMJ9TLAu6PMHYxfn6XXt8h
rEYs9m92f4wGfNzxW+oBXwiDClNIIpIiZvYPrnPaQiSL3DT8EUkDjhuvvWhRpvpU
SP9j31qV4gGlcBhUuoXtnIekZrEPmlPNzAgwD5GVz6DDFAt8psYdmDPdqBlrm5Zr
y/FDM7Drg744wC033bXpb5QcXXB3r6c+hPMyfUn8h66GN21llPmavMYfOyOwlhap
GHS/Z8uH6MM1I1YYfp6H0U8Y0YVp1ucMai0in/HlAPVO3GkwphyTyLu9gCpK1o7w
D+xg9zmL9Z6+savmvYjq7UQTYBvgBBtGGDJRDDAUbCRBYQd8KhyPBdxg6ngWNrUo
WVV8/+GZ8SZTHy7rfHMjQQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZAIqUHmv8BrKAx5750pQ0v9wAZQoFTVtOFxTdBFYFdaQb2MWyE0HYRIfpEb5RtXc
4rsCkfwHMiSMwpRY6rD+bdhY1YZngSviwhGJ2rMEHB51QaSyAG3v7/YgMBAVd4x7
wly7DsDcXQOE+3ZlIZx8IxPH5E3dot88cKGzf2xCT5Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23252     )
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
`pragma protect end_protected

/**
  * Defines a system domain map. Refer Section C 1.6.1 on Domains. 
  * Applicable when svt_axi_port_configuration::AXI_ACE is used in
  * any of the ports.
  * Each inner domain/outer domain/non-shareable domain/system shareable domain
  * is represented by an instance of this class. There can be multiple address
  * ranges for a single domain, but no address range should overlap. 
  * For example if M0 and M1 are in the inner domain and share the 
  * addresses (0x00-0xFF and 0x200-0x2FF), the following apply:
  * domain_type     = svt_axi_system_domain_item::INNERSHAREABLE
  * start_addr[0]   = 0x00
  * end_addr[0]     = 0xFF
  * start_addr[1]   = 0x200
  * end_addr[1]     = 0x2FF
  * domain_idx      = <user defined unique integer idx>
  * master_ports[] = {0,1};
  * The following utility methods are provided in svt_axi_system_configuration
  * to define and set the above variables
  * svt_axi_system_configuration::create_new_domain();
  * svt_axi_system_configuration::set_addr_for_domain();
  */

class svt_axi_system_domain_item extends `SVT_DATA_TYPE; 

  /**
   * Enum to represent levels of shareability domains.
   */
  typedef enum bit [1:0] {
    NONSHAREABLE      = `SVT_AXI_DOMAIN_TYPE_NONSHAREABLE,
    INNERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_INNERSHAREABLE,
    OUTERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_OUTERSHAREABLE,
    SYSTEMSHAREABLE   = `SVT_AXI_DOMAIN_TYPE_SYSTEMSHAREABLE
  } system_domain_type_enum;

  /**
    * The domain type corresponding to this instance
    */
  system_domain_type_enum            domain_type;

  /** 
    * A unique integer id for this domain. If there are multiple  entries
    * (eg: multiple start_addr, end_addr entries) for the same domain,
    * this variable identifies which domain these entries refer to.
    */
  int                                domain_idx;

  /** Starting addresses of shareability address range. */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   start_addr[];

  /** Ending addresses of shareability address range */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0]   end_addr[];

  /**
    * The masters belonging to this domain.
    * <b>min val:</b> 0 
    * <b>max val:</b> \`SVT_AXI_MAX_NUM_MASTERS-1
    */
  int                                master_ports[];

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
   extern function new (string name = "svt_axi_system_domain_item");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_system_domain_item");
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
`svt_vmm_data_new(svt_axi_system_domain_item)
  extern function new (vmm_log log = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();


`ifdef SVT_UVM_TECHNOLOGY
`elsif SVT_OVM_TECHNOLOGY
`else
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
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ---------------------------------------------------------------------------
  /**
    * HDL Support: For <i>read</i> access to public configuration members of 
    * this class.
    */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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

// ---------------------------------------------------------------------------
  extern virtual function svt_pattern do_allocate_pattern();
  /** @cond PRIVATE */
  extern function bit get_address_shareability(int port_id, 
                                        bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                        output system_domain_type_enum addr_domain_type,
                                        output bit error
                                       );
  /** @endcond */


  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************

  `svt_data_member_begin(svt_axi_system_domain_item)
      `svt_data_member_end(svt_axi_system_domain_item)

endclass

// -----------------------------------------------------------------------------
/** 
System Configuration Class Utility methods definition.
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
db2wA6LEL9eu4Hg+ikgydgMJcyEZv32ld/GZAJ0s+eUNMUV5Rkrc1+43BO7wzTot
lzsnhW174o2iUrJRfoj2r4+Th/n0mg5L+TLU20V7iLF0t7eXP4su323TuXMXWPLM
g8AaOWcxTy4XmoqrHWVT9UYWObEa0W2Fw+74elJhUzc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23804     )
LB5Lusc/M+A2J2S54s5kXr+BLuPTfAaA7MG+x4WQXDK9gxupr0qXQw5a//+Rdmhh
1yCvTniTfZXf8JI/y9K0LHTMJ0nAUVzgdnuljFvu7McJHw0DHpn/tWj+KzrOKl86
dY4nLgWJi/AcZbWzwPW4yTFpA65KU6K3IqP/VbA/aFAqilzhDJA6Hd2APpiFTllk
IbOlX7nQd4Qw/8/YCLVm9j8XLk7hB6RRgEzm8h9+F3n/ksIQZb6BgtkBPsP+1HGr
PypMhVQkhbx4ZhfaMuXBEEIYt8PKfGpxtQPS5iPNhN4ZU7zrJGhEDNVSIgf9y/ZB
162MPfjsD47HxEpYKCzI9mFTd3qMCvZX5biVtUDN28YmupbBYBStHE4B1gRmnvAD
nnOH5EMX4MvcxLAwaUkI1jfBc7owtT4nrM65uJj83OSAngVvndwuq0m/pR5tPZdh
7UoL/a5QpIMO4YyV/tAR7ZYtNkxmJ/fYOCAJeMVHulrCkJJbVINpIZVjHJAMXF5m
8b8YsRcfqH2x8XvefQeqNmPCQo08MzBs4S1Z1m4ZhP+yIo4MClw2M9pHqA93HtHj
05vFbA4jjlBRnZ9/6gyxszdYJJv0ZMkV1dHU1XAV2Vw8eLkbQm0Zu57SHw6XuDME
rF2+7mehey1Kr6FvfxeGu7JFhg04kiG2J8r8n7/+Y3IbyPRUgzO0zBm95bDvaT+s
xrU0xKcG2gVKapNVRuPoZAbIVPY1GFFNpfKE8709X3g=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lw90h/WHKONix4IiGi+TrN/JXSOW1dg1rHHZoikf08rm1fjVuv/VHz/Yhr+fqxaz
ktHOueFz9W7vaEetw3ZTHShXdPJ1tXQhXYyFBygXSdYHfQZC9epH3uYMRZ6fKr+y
8Fd8y60CmwvGRJvVaxgXX1Q0xkm0ccZS5ns3RjEk2XM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 33208     )
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
`pragma protect end_protected

/**
    System configuration class contains configuration information which is
    applicable across the entire AXI system. User can specify the system level
    configuration parameters through this class. User needs to provide the
    system configuration to the system subenv from the environment or the
    testcase. The system configuration mainly specifies: 
    - number of master & slave components in the system component
    - port configurations for master and slave components
    - virtual top level AXI interface 
    - address map 
    - timeout values
    .
 
  */
class svt_axi_system_configuration extends svt_configuration;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  /** Custom type definition for virtual AXI interface */
`ifndef __SVDOC__
  typedef virtual svt_axi_if AXI_IF;
`endif // __SVDOC__


  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Modport providing the system view of the bus */
  AXI_IF axi_if;
`endif

  /**
    @grouphdr axi_generic_sys_config Generic configuration parameters
    This group contains generic attributes
    */

  /**
    @grouphdr axi_clock Clock
    This group contains attributes related to clock
    */

  /**
    @grouphdr axi_master_slave_config Master and slave port configuration
    This group contains attributes which are used to configure master and slave ports within the system
    */

  /**
    @grouphdr interconnect_config Interconnect model configuration
    This group contains attributes which are used to configure Interconnect model
    */

  /**
    @grouphdr axi_addr_map Address map
    This group contains attributes and methods which are used to configure address map
    */

  /**
    @grouphdr axi3_4_timeout Timeout values for AXI3 and AXI4
    This group contains attributes which are used to configure timeout values for AXI3 and AXI4 signals and transactions
    */

  /**
    @grouphdr ace_timeout Timeout values for ACE
    This group contains attributes which are used to configure timeout values for ACE signals. Please also refer to group @groupref axi3_4_timeout for AXI3 and AXI4 timeout attributes.
    */

  /**
    @grouphdr axi4_stream_timeout Timeout values for AXI4 Stream
    This group contains attributes which are used to configure timeout values for AXI3 and AXI4 signals and transactions
    */

  /**
    @grouphdr axi_system_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable AXI system level coverage and protocol checks
    */

  /**
    @grouphdr ace_system_coverage_protocol_checks Coverage and protocol checks related configuration parameters
    This group contains attributes which are used to enable and disable ACE system level coverage and protocol checks
    */

  /**
    @grouphdr axi_master_slave_xact_correlation Configuration parameters required for correlating master and slave transactions
    This group contains attributes which are used to correlate master transactions to slave transactions based on AxID 
    */

  /**
   * Enum to represent where a chunk of data is specified in a signal.
   */
  typedef enum bit {
    AXI_LSB = `SVT_AXI_LSB,
    AXI_MSB = `SVT_AXI_MSB
  } source_master_info_position_enum;

  /**
   * Enum to represent the coverage of system_axi_master_to_slave_access.
   */
  typedef enum {
    EXHAUSTIVE = 0,
    RANGE_ACCESS = 1
  } system_axi_master_to_slave_access_enum;
  
  /** Enum to represent the L3 cache operation mode */
  typedef enum bit {
    ONLY_EXCLUSIVE_FULL_CACHELINE_IN_L3_CACHE = 0
  } l3_cache_mode_enum;

  /**
   * Enum to represent the version of DVM message.
   */
  typedef enum {
    DVMV8 = 0,
    DVMV8_1 = 1,
    DVMV8_1_ONLY = 2,
    DVMV8_4 = 3
  } dvm_version_enum;

  
  /** 
    * Enum to represent snoop transaction type corresponding to
    * ReadOnceCleanInvalid coherent transaction type
    */
  typedef enum {
    READUNIQUE_SNOOP_FOR_ROCI = 0,
    READONCE_SNOOP_FOR_ROCI = 1
  } snoop_xact_type_for_roci_enum;
  
  /** 
    * Enum to represent snoop transaction type corresponding to
    * ReadOnceMakeInvalid coherent transaction type
    */
  typedef enum {
    READUNIQUE_SNOOP_FOR_ROMI = 0,
    READONCE_SNOOP_FOR_ROMI = 1
  } snoop_xact_type_for_romi_enum;
  
  /**
    * @groupname axi_generic_sys_config
    * An id that is automatically assigned to this configuration based on the
    * instance number in the svt_axi_system_configuration array in
    * svt_amba_system_cofniguration class.  Applicable when a system is created
    * using svt_amba_system_configuration and there are multiple axi systems 
    * This property must not be assigned by the user
    */ 
  int system_id = 0;
  
  /** @cond PRIVATE */
  /** xml_writer handle of the system */
  svt_xml_writer xml_writer = null;
  /** @endcond */

  /** 
    * @groupname axi_clock
    * This parameter indicates whether a common clock should be used
    * for all the components in the system or not.
    * When set, a common clock supplied to the top level interface 
    * is used for all the masters, slaves and interconnect in 
    * the system. This mode is to be used if all components are
    * expected to run at the same frequency.
    * When not set, the user needs to supply a clock for each of the
    * port level interfaces. This mode is useful when some components
    * need to run at a different clock frequency from other
    * components in the system.
    */
  bit common_clock_mode = 1;

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Enables the Multi-Stream Scenario Generator
   * Configuration type: Static
   */
  bit ms_scenario_gen_enable = 0;

  /** 
   * The number of scenarios that the multi-stream generator should create.
   * Configuration type: Static
   */
  int stop_after_n_scenarios = -1;

  /** 
   * The number of instances that the multi-stream generators should create
   * Configuration type: Static
   */
  int stop_after_n_insts = -1;
`endif

`ifndef SVT_VMM_TECHNOLOGY
  /** 
    * @groupname axi_generic_sys_config
    * Enables raising and dropping of objections in the driver based on the number
    * of outstanding transactions. The VIP will raise an objection when it
    * receives a transaction in the input port of the driver and will drop the
    * objection when the transaction completes. If unset, the driver will not
    * raise any objection and complete control of objections is with the user. By
    * default, the configuration member is set, which means by default, VIP will
    * raise and drop objections.
    */
  bit manage_objections_enable = 1;
`endif

  /** 
    * @groupname interconnect_config
    * Determines if a VIP interconnect should be instantiated
    */
  bit use_interconnect = 0;

  /**
    * @groupname axi_system_coverage_protocol_checks
    * Enables system monitor and system level protocol checks
    */
  bit system_monitor_enable = 0;
 
 /**
   * - Determines if XML/FSDB generation for display in PA is desired.
   *  - The format of the file generated will be based on svt_axi_system_configuration::pa_format_type
   *  .
   * - Applicable only when system monitor is enabled through svt_axi_system_configuration::system_monitor_enable = 1
   * - When set to 1 the following callback is registered:
   *  - with system monitor: svt_axi_system_monitor_transaction_xml_callback
   *  .
   * - <b>type:</b> Static
   * .
   * 
   */
  bit enable_xml_gen = 0;
  
  /**
   * Determines in which format the file should write the transaction data.
   * The enum value svt_xml_writer::XML indicates XML format, 
   * svt_xml_writer::FSDB indicates FSDB format and 
   * svt_xml_writer::BOTH indicates both XML and FSDB formats.

   */
  svt_xml_writer::format_type_enum pa_format_type;

 /**
    * @groupname ace_generic_sys_config
    * Determines whether cacheline_and_memory_coherency_check should be 
    * fired as an error or a warning.If this configuration is set System monitor 
    * will flag an error if the cacheline_and_memory_coherency_check_per_xact fails.
    */
  bit flag_cacheline_and_memory_coherency_check_per_xact_as_error = 0;

  /**
    * @groupname axi_system_coverage_protocol_checks
    * Enables system checks between master transactons and corresponding slave
    * transactions for non modifiable transactions. This involves associating
    * master transactions to slave transactions which can vary from one
    * interconnect implementation to another.  For the same reason, these
    * checks are disabled by default.
    */
  bit master_slave_non_modifiable_xact_checks_enable = 0;

  /**
    * @groupname axi_generic_sys_config
    * Applicable when #system_monitor_enable is set to 1
    * Sets the allowed set of snoop transactions for a given coherent
    * transaction.  The specification recommends a specific snoop transaction
    * type for a given coherent transaction for mapping coherency operations to
    * snoop operations.  However a list of optional snoop transactions are also
    * given which can be used for each of the coherent transaction types. This
    * parameter decides whether the system monitor will use the recommended
    * mapping or whether both recommended as well as optional transaction
    * mapping for associating snoop transactions to coherent transactions.
    * When set to 1, only recommended mapping is used to associate snoop transactions
    * to coherent transactions.
    * When set to 0, both recommended as well as optional mapping is used to associate
    * snoop transactions to coherent transactions.
    */
  bit use_recommended_coherent_to_snoop_map = 1;

  /**
    * Allows the interconnect to respond to a DVM transaction from a master
    * before collecting the responses to snoop transactions sent to masters.
    * When a DVM transaction is sent by a master, the interconnect sends snoop
    * transactions to all the other masters. The specification recommends that
    * the response to the DVM transaction is sent to the master only after
    * collecting the responses to the snoop transactions sent to the masters.
    * Many interconnects however send back response to a DVM transaction prior
    * to receiving response to all snoop transactions.<br>  
    * If set to 1, the system monitor does not report an error if a response to
    * a DVM transaction is sent before responses from corresponding snoop
    * transactions are received. <br>
    * If set to 0, the system monitor reports an error if a response to a DVM
    * transaction is sent before responses from corresponding snoop
    * transactions are received.
    */
  bit allow_early_dvm_response_to_master = 1;

  /**
    *   Indicates whether coherent interconnect should perform back invalidation by sending
    * cleaninvalid snoop transaction on its own without receiving any coherent transaction.
    * A coherent interconnect may do this in order to avoid snoop filter overflow.
    * If this bit is set to '1' then system monitor won't perform snoop_addr_matches_coherent_addr_check.
    *
    *   This is because, in case of back invalidation coherent interconnect sends invalidating
    * snoop transaction - cleaninvalid without any coherent transaction. Since, this is not
    * directly visible outside the interconnect, system monitor won't be able to find any matching
    * coherent transactions and may falsely report error that snoop transaction received without any
    * matching coherent transaction so, this disable_cleaninvalid_snoop_to_coherent_match_check_for_back_invalidation
    * should be set to '1' in order to skip this check. By default, it is set to '1'.
    *
    *   This will have no effect if snoop_filter_enable is set to '0' in port_configuration
    * 
    * NOTE: This parameter will only skip snoop_addr_matches_coherent_addr_check only when possible
    *       back invalidation is detected i.e. cleaninvalid received without any matching coherent transaction.
    */

  bit disable_cleaninvalid_snoop_to_coherent_match_check_for_back_invalidation = 1;

  /** Indicates whether coherent masters are allowed to update cacheline if attached cohrent interconnect provided
    * errorneous cohrent response. If this bit is set to '0' then master will not update cache if it receives either
    * SLVERR or DECERR as part of coherent response. In this case, it is master's responsibility that it informs
    * snoop filter that the cacheline has not been allocated in case coherent interconnect has allocated the line.
    * For that reason, master will send de-allocating transaciton CLEANINVALID at the end of current transaction that
    * is supposed to allocate the cahceline but, has received coherent error response. 
    * However, cacheline needs to be removed only when master doesn't have the cacheline but, current transaction is
    * is supposed to allocate the line i.e. current state is INVALID and final state is supposed to be either UC,UD,SC or SD.
    *
    * If this bit is set to '1' then master will go ahead and update the cacheline if required irrespective of the 
    * erroneous cohrent response and in that case, it will not send any such de-allocating transaction.
    *
    * NOTE: if this bit is set to '0' then VIP system_monitor will also not update snoop_filter during such errorneous
    *       coherent response.
    */

  bit allow_cache_update_on_coherent_error_response = 1;

  /** Indicates whether coherent masters are allowed to update its cache if attached coherent interconnect provided
    * OKAY response for a exclusive read transaction. If this bit is set to '0' then master will not update cache
    * if it receives OKAY response for exclusive read transaction. 
    * If this bit is set to '1' then master will update its cache if it receives OKAY response for exclusive read transaction. 
    *
    * NOTE: This is not going to effect on behavior of the master when it received EXOKAY response.
    */

  bit allow_cache_update_on_excl_access_with_okay_response = 0;

  /**
    * Indicates if the interconnect merges dirty data received from snoop
    * transactions with data from coherent transactions of masters before
    * sending transactions to slave.  If set to 0, dirty data is sent by the
    * interconnect as a separate transaction.  If set to 1, dirty data is
    * merged with data from coherent transactions.  This variable affects the
    * way transactions seen at the slave are correlated to transactions seen at
    * the master. This must be set correctly, based on the behaviour of the
    * interconnect for the system monitor to correlate slave transactions to
    * master transactions.
    */
  bit interconnect_merges_dirty_data = 0;

  /**
    * @groupname axi_generic_sys_config
    * Controls display of transactions debug messages by the system monitor
    * Applicable when #system_monitor_enable is set
    *
    * When set to 1, transactions debug messages are printed by the system monitor
    * when verbosity is set to UVM_MEDIUM, UVM_HIGH, and higher verbosities.
    *
    * When unset i.e. 0, transactions debug messages are printed by the system
    * monitor when verbosity is set to UVM_HIGH, UVM_FULL, and higher verbosities.
    *
    * NOTE: It is possible to control some aspects of the transactions debug messages, the way it will be reported.
    *  - if it is set to 2 then all transactions that has address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  - if it is set to 3 then all transactions regardless of address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  .
    */
  int debug_system_monitor = 0;

  /**
    * @groupname ace5_config
    * This attribute is applicable for ReadOnceCleanInvalid transactions.
    * This will indicate the snoop transaction type corresponding to 
    * ReadOnceCleanInvalid coherent transaction type.
    * By default its value is set to READUNIQUE_SNOOP_FOR_ROCI. This means 
    * ReadOnceCleanInvalid coherent transaction type will result into 
    * READUNIQUE snoop transaction type.
    * Permitted values: READUNIQUE_SNOOP_FOR_ROCI, READONCE_SNOOP_FOR_ROCI
    * Applicable only when svt_axi_port_configuration::ace_version is set to ACE_VERSION_2_0
    */
  snoop_xact_type_for_roci_enum snoop_xact_type_for_roci = READUNIQUE_SNOOP_FOR_ROCI;

  /**
    * @groupname ace5_config
    * This attribute is applicable for ReadOnceMakeInvalid transactions.
    * This will indicate the snoop transaction type corresponding to 
    * ReadOnceMakeInvalid coherent transaction type.
    * By default its value is set to READUNIQUE_SNOOP_FOR_ROMI. This means 
    * ReadOnceMakeInvalid coherent transaction type will result into 
    * READUNIQUE snoop transaction type.
    * Permitted values: READUNIQUE_SNOOP_FOR_ROMI, READONCE_SNOOP_FOR_ROMI
    * Applicable only when svt_axi_port_configuration::ace_version is set to ACE_VERSION_2_0
    */
  snoop_xact_type_for_romi_enum snoop_xact_type_for_romi = READUNIQUE_SNOOP_FOR_ROMI;

  /**
    * @groupname ace5_config
    * This attribute is applicable for ReadOnceMakeInvalid transactions. If set to 1,
    * it will allow the master component to write dirty data to main memory. 
    * By default its value is 0. This means by default it will not update the main memory
    * with the dirty data.
    * Applicable only when svt_axi_port_configuration::ace_version is set to ACE_VERSION_2_0
    */
  bit wr_dirty_data_to_mem_for_romi = 0;  

`ifdef SVT_UVM_TECHNOLOGY
  /**
    * @groupname axi_generic_sys_config
    * Controls display of summary report of transactions by the system monitor
    * Applicable when #system_monitor_enable is set
    *
    * When set to 1, summary report of transactions are printed by the system monitor
    * when verbosity is set to UVM_MEDIUM, UVM_HIGH, and higher verbosities.
    *
    * When unset i.e. 0, summary report of transactions are printed by the system
    * monitor when verbosity is set to UVM_HIGH, UVM_FULL, and higher verbosities.
    *
    * When set to 6, summary report of transactions are printed by the system monitor are
    * loaded in to new file suffix with axi_system_transaction_summary_report
    *
    * NOTE: It is possible to control some aspects of the summary, the way it will be reported.
    *  - if it is set to 2 then all transactions that has address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  - if it is set to 3 then all transactions regardless of address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  .
    */
`elsif SVT_OVM_TECHNOLOGY
  /**
    * @groupname axi_generic_sys_config
    * Controls display of summary report of transactions by the system monitor
    * Applicable when #system_monitor_enable is set
    *
    * When set to 1, summary report of transactions are printed by the system monitor
    * when verbosity is set to OVM_MEDIUM, OVM_HIGH, and higher verbosities.
    *
    * When unset i.e. 0, summary report of transactions are printed by the system
    * monitor when verbosity is set to OVM_HIGH, OVM_FULL, and higher verbosities.
    *
    * When set to 6, summary report of transactions are printed by the system monitor are
    * loaded in to new file suffix with axi_system_transaction_summary_report
    *
    * NOTE: It is possible to control some aspects of the summary, the way it will be reported.
    *  - if it is set to 2 then all transactions that has address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  - if it is set to 3 then all transactions regardless of address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  .
    */
`else
  /**
    * @groupname axi_generic_sys_config
    * Controls display of summary report of transactions by the system monitor.
    * Applicable when #system_monitor_enable is set.
    *
    * When set to 1, summary report of transactions are printed by the system monitor
    * when verbosity is set to NOTE and higher verbosities.
    *
    * When unset i.e. 0, summary report of transactions are printed by the system
    * monitor when verbosity is set to DEBUG and higher verbosities.
    *
    * When set to 6, summary report of transactions are printed by the system monitor are
    * loaded in to new file suffix with axi_system_transaction_summary_report
    *
    * NOTE: It is possible to control some aspects of the summary, the way it will be reported.
    *  - if it is set to 2 then all transactions that has address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  - if it is set to 3 then all transactions regardless of address overlap with current
    *  transaction, will be reported under heading: "OVERLAPPED TRANSACTIONS STARTED AFTER CURRENT TRANSACTION"
    *  .
    */
`endif
  int display_summary_report = 6;

`ifdef SVT_UVM_TECHNOLOGY
  /**
    * @groupname axi_generic_sys_config
    * Controls display of performance summary report of transactions by the system env
    *
    * When set, performance summary report of transactions are printed by the system env
    * when verbosity is set to UVM_MEDIUM, UVM_HIGH, and higher verbosities.
    *
    * When unset, performance summary report of transactions are printed by the system
    * env when verbosity is set to UVM_HIGH, UVM_FULL, and higher verbosities.
    */
  bit display_perf_summary_report = 0;
`elsif SVT_OVM_TECHNOLOGY
  /**
    * @groupname axi_generic_sys_config
    * Controls display of monitorsummary report of transactions by the system env
    *
    * When set, performance summary report of transactions are printed by the system env
    * when verbosity is set to OVM_MEDIUM, OVM_HIGH, and higher verbosities.
    *
    * When unset, performance summary report of transactions are printed by the system
    * env when verbosity is set to OVM_HIGH, OVM_FULL, and higher verbosities.
    */
  bit display_perf_summary_report = 0;
`else
  /**
    * @groupname axi_generic_sys_config
    * Controls display of performance summary report of transactions by the system env
    *
    * When set, performance summary report of transactions are printed by the system env
    * when verbosity is set to NOTE and higher verbosities.
    *
    * When unset, performance summary report of transactions are printed by the system
    * env when verbosity is set to DEBUG and higher verbosities.
    */
  bit display_perf_summary_report = 0;
`endif

  /** @cond PRIVATE */
  /** Indicates L3 Cache is enabled in system monitor if set to '1'. if it is set to '0' L3 cache is disabled and not used */
  bit l3_cache_enable = 0;

  /** Indicates size of each cacheline in bytes for L3 cache */
  int l3_cacheline_size = 64;

  /** Indicates number of avavilable cacheline entries in L3 cache */
  int l3_cache_num_cacheline = 1024;

  /** 
    * Allows different L3 cache allocation / deallocation policy to be enforced. User can choose different
    * modes as per underlying interconnect's L3 Cache policy.
    * ONLY_EXCLUSIVE_FULL_CACHELINE_IN_L3_CACHE :: inidicates L3 cache will hold only exclusive cachelines
    *      i.e. the cachelines which are not allocated by any masters and only available in interconnect's 
    *      L3 cache. It also enforces that only full cacheline will be allocated to the L3 cache. Any
    *      partial cacheline transactions will not cause allocation and if there is a hit that will cause
    *      deallocation of the corresponding cacheline.
    */
  l3_cache_mode_enum l3_cache_mode = ONLY_EXCLUSIVE_FULL_CACHELINE_IN_L3_CACHE;
  /** @endcond */

  /**
    * Indicates if the interconnect DUT forwards a WRITEEVICT
    * transaction downstream. A WRITEEVICT transaction is used by a master when
    * a cacheline is evicted from its own cache, but is allocated in a lower
    * level of cache hierarchy such as a system level cache or L3 cache. This
    * cache could reside within the interconnect in which case a WRITEEVICT is
    * not forwarded downstream and this bit should not be set. If such a cache
    * resides downstream of the interconnect, this bit should be set. If this
    * bit is set, the system monitor performs data integrity checks on
    * WRITEEVICT transactions that ensure that data was correctly routed to a
    * downstream slave. Note that the interconnect VIP does not have an L3 or
    * system level cache and therefore always forwards WRITEEVICT transactions
    * downstream. Therefore, this configuration attribute is applicable only to
    * the AXI and AMBA system monitor.   */
  bit ic_forwards_writeevict_downstream = 1;

  /**
    * Enables the system monitor and VIP interconnect to handle posted write
    * transactions. A posted write transaction is one where the interconnect
    * responds to a write transaction without waiting for a response from the
    * slave to which the transaction is routed. When this parameter is enabled,
    * the system monitor disables data_integrity_check. This is required
    * because a transaction may not have reached its final destination (slave)
    * when it completes at the master that initiated it. To enable data
    * integrity checking for such transactions, the VIP correlates transactions
    * received at the slaves to transactions initiated by masters based on
    * address and data.  If the VIP is unable to correlate a received slave
    * transaction to a master transaction, VIP will fire
    * master_slave_xact_data_integrity_check. If there are orphaned master
    * transactions at the end of the simulation which could not be correlated
    * to any slave transaction, it indicates that some transactions did not
    * make it to final slave destination and VIP will fire
    * eos_unmapped_master_xact check.  It is the users' responsibility to
    * ensure that a test runs long enough for all the master transactions to
    * reach their final destination.  If this parameter is enabled and the AXI
    * Interconnect VIP model is used, it responds to write transactions before
    * routing it to the slave to which it is destined, provided the transaction
    * cache attributes permit the interconnect to give a response from an
    * intermediate point. Any READ transaction that follows a WRITE transaction
    * and has an overlapping address will wait for the WRITE transaction to
    * complete at the slave interface before routing the read transaction to
    * the slave.
    */ 
  bit posted_write_xacts_enable = 0;

  /**
    * When set to 1, the system monitor check interconnect_generated_write_xact_to_update_main_memory_check
    * is enabled. 
    *
    * When set to 0, the system monitor check interconnect_generated_write_xact_to_update_main_memory_check
    * is disabled. This is the default behavior. 
    */
  bit interconnect_generated_write_xact_to_update_main_memory_check_enable = 0; 

  /**
    * When set to 1, the check data_integrity_with_outstanding_coherent_write_check 
    * considers the READONCE transactions. 
    *
    * When set to 0, the check data_integrity_with_outstanding_coherent_write_check 
    * excludes the READONCE transactions. This is the default behavior. 
    */
  bit include_readonce_for_data_integrity_with_outstanding_coherent_write_check = 0; 

  /**
    * Enables data integrity check in the system monitor across master
    * transactions and slave transactions of an interconnect. In order to
    * perform this check, the system monitor must correlate slave transactions
    * to master transactions. This process has a lot of DUT dependency as
    * different interconnects transform transactions differently when they
    * route transcations from a master to a slave. Typically, this should be
    * enabled only if #id_based_xact_correlation_enable is set, which gives
    * additional information to the system monitor to correlate slave
    * transactions to master transactions.
    */
  bit master_slave_xact_data_integrity_check_enable = 0;

  /**
    * Enables end of simulation check in system monitor for master transactions
    * that have neither a snoop nor a slave transaction correlated with it This
    * check must be enabled only if
    * master_slave_xact_data_integrity_check_enable is set
    */
  bit eos_unmapped_xacts_have_snoop_or_slave_xact_check_enable = 0;

  /**
    * This configuration sets the behaviour of the interconnect DUT when
    * routing master transactions to slaves. This information is used by the
    * system monitor when associating slave transactions to master
    * transactions. This parameter indicates that a one-to-one mapping is
    * expected between master transactions and slave transactions when master
    * transactions get routed to slaves. Two master transactions should not be
    * merged into a single transaction when routing to slave. One master
    * transaction should not be split into multiple slave transactions. If this
    * parameter is set when the interconnect merges or splits transactions, it
    * will lead to incorrect association of slave transactions to master transactions.
    */
  bit master_slave_xact_one_to_one_mapping_enable = 0;

  /**
    * Enables passive cache monitor. This allows VIP to track states of cachelines
    * in cache of passive Masters.
    * if set to '0' passive cache monitor is disabled 
    */
  bit passive_cache_monitor_enable = 0;

  /**
    * Disables the secure bit association between coherent and associated snoop transactions.
    * This allows system monitor to bypass the check for the secure/nosecure bit between coherent and associated snoop transaction. 
    * if set to '1' secure bit is considered to be checked in system monitor. 
    * if set to '0' secure bit is not considered to be checked in system monitor.
    */
  bit coherent_to_snoop_secure_bit_association_enable = 1;

  /**
    * @groupname axi_coverage_protocol_checks
    * When set to '1', enables coverage for system level protocol checks
    * Applicable if #system_monitor_enable=1
    * <b>type:</b> Static 
    */
  bit protocol_checks_coverage_enable = 0;

  /**
    * @groupname axi_coverage_protocol_checks
    * When set to '1', enables coverage for system level positive protocol checks
    * When set to '1', enables positive protocol checks coverage.
    * When set to '0', enables negative protocol checks coverage.
    * Applicable if #system_monitor_enable=1
    * <b>type:</b> Static 
    */
  bit pass_check_cov = 1;


  /**
    * @groupname axi_coverage_protocol_checks
    * When set to '1', enables system level coverage.All covergroups enabled
    * by system_axi_*_enable or system_ace_*_enable are created only if
    * this bit is set.
    * Applicable if #system_monitor_enable=1
    * <b>type:</b> Static 
    */
  bit system_coverage_enable = 0;  

  /**
    * @groupname axi_generic_sys_config
    * Number of clock cycles interval needed before polling any hazarded address.
    * This restriction is typically needed by interconnect which may get into
    * deadlock state because of certain implementation feature, if transactions
    * are continuously sent to the interconnect for a specific address which is
    * already hazarded by other transaction issued by other master(s).
    *   In this case, if hazarded address is polled continuously then other pending 
    * transaction issued by other master sent to the same address never gets selected
    * to proceed further and remains in hang state.
    * <b>type:</b> Static 
    */
  int unsigned ic_num_cycles_interval_for_polling_hazarded_address = 5;

  /**
    * @groupname axi_generic_sys_config
    * Indicates the total number of entries of snoop filter in system monitor.
    * In other words, it specifies number of cachelines snoop filter can accomodate along
    * with the allocated master port-id information.
    *
    * If number of allocation of unique cacheline addresses crosses this configured
    * size after considering pending allocating coherent xacts, for which allocation
    * in snoop filter needs to be made, then system monitor will expect back invalidation
    * snoop i.e. CLEANINVALID snoop transaciton from the interconnect.
    * <b>type:</b> Static 
    */
  int unsigned snoop_filter_size = 2048;

  /**
    * @groupname axi_generic_sys_config
    * Enables support for tagging of addresses at masters, while disabling
    * tagging at slave. Tagging is set through
    * svt_axi_port_configuration::tagged_address_space_attributes_enable.
    * Typically, tagging should match between masters and slaves so that
    * coherency is not impacted. However, some systems have mismatched tagging
    * capabilities between master and slave. Such a configuration means that
    * secure and non-secure accesses to the same physical address is treated as
    * two different addresses in the master, but as the same address in the
    * slave. This poses coherency problems when there are
    * secure and non-secure accesses to the same physical address. It is
    * recommended that secure and non-secure address regions are completely
    * separate for such a configuration. However, some systems may need to test
    * this configuration with overlap of secure and non-secure address spaces, in
    * which case this parameter must be set so that the checks detailed below
    * do not execute. These checks are disabled by the system monitor when there are
    * secure and non-secure accesses to the same physical address. When this parameter
    * is set, the system monitor keeps track of addresses which have accesses with 
    * both secure and non-secure access types to the same physical addresses and disables
    * data_integrity_check and snoop_data_consistency_check in the system monitor. 
    * The system monitor issues a warning when these checks are not executed.
    * cacheline_and_memory_coherency_check  will also be disabled for all addresses if
    * this parameter is set.
    */
  bit support_tagged_master_and_untagged_slave = 0;

  /**
    * Indicates the mode to be used by the system monitor to co-relate slave transactions to
    * coherent transactions. There will be variations in the manner interconnects
    * schedule transactions to transactions with overlapping concurrent addresses. 
    * This variable helps to accomodate these variations. 
    * If set to 0, the system monitor will first try to establish an exact correlation
    * in terms of minimum and maximum addressable location. This is a one-to-one correlation
    * between master and slave transactions. If no such correlation can
    * be established, it will try to establish a one-to-many relationship
    * If set to 1, the system monitor does not try to first establish a one-to-one correlation.
    * It will establish one-to-many correlations, including one-to-one correlations 
    */
  int master_to_slave_association_mode = 0;

  /** @cond PRIVATE */
  /**
    * Indicates the mode to be used by the system monitor to co-related snoops to
    * corresponding coherent. There will be variations in the manner interconnects
    * schedule transactions to transactions with overlapping concurrent addresses. 
    * This variable helps to accomodate these variations. This is not expected to
    * be changed by the user. However, it may prove helpful in certain scenarios
    * where a different co-relation mechanism helps correlation better.
    */
  int snoop_to_coherent_association_mode = 0;
  /** @endcond */
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** 
    * @groupname axi_master_slave_config
    * Number of masters in the system 
    * - Min value: 0 
    * - Max value: \`SVT_AXI_MAX_NUM_MASTERS
    * - Configuration type: Static 
    * .
    * The Max value can be overridden by defining SVT_AXI_MAX_NUM_MASTERS_(max masters).
    * For eg: The max masters can be 450 by defining  SVT_AXI_MAX_NUM_MASTERS_450.
    */
  rand int num_masters;

  /** 
    * @groupname axi_master_slave_config
    * Number of low power monitors in the system 
    * - Min value: 1
    * - Max value: \`SVT_AXI_MAX_LP_MASTERS
    * - Configuration type: Static 
    * .
    * The Max value can be overridden by defining SVT_AXI_MAX_LP_MASTERS(max low power monitors).
    * For eg: The max masters can be 128 by defining  SVT_AXI_MAX_LP_MASTERS to 128.
    */
  rand int num_lp_masters=0;

  /** 
    * @groupname axi_master_slave_config
    * Number of slaves in the system 
    * - Min value: 0 
    * - Max value: \`SVT_AXI_MAX_NUM_SLAVES
    * - Configuration type: Static
    * .
    * The Max value can be overridden by defining SVT_AXI_MAX_NUM_SLAVES_(max slaves).
    * For eg: The max slaves can be 450 by defining  SVT_AXI_MAX_NUM_SLAVES_450.    
    */
  rand int num_slaves;

  /** 
    * @groupname axi_master_slave_config
    * Array holding the configuration of all the masters in the system.
    * Size of the array is equal to svt_axi_system_configuration::num_masters.
    * @size_control svt_axi_system_configuration::num_masters
   */
  rand svt_axi_port_configuration master_cfg[];

  /** 
    * @groupname axi_master_slave_config
    * Array holding the configuration of all the low power masters in the system.
    * Size of the array is equal to svt_axi_system_configuration::num_lp_masters.
    * @size_control svt_axi_system_configuration::num_lp_masters
   */
  rand svt_axi_lp_port_configuration lp_master_cfg[];

  /** 
    * @groupname axi_master_slave_config
    * Array holding the configuration of all the slaves in the system.
    * Size of the array is equal to svt_axi_system_configuration::num_slaves.
    * @size_control svt_axi_system_configuration::num_slaves
    */
  rand svt_axi_port_configuration slave_cfg[];

  /**
    * @groupname interconnect_config
    * Interconnect configuration
    */
  rand svt_axi_interconnect_configuration ic_cfg;

  /**
    * @groupname axi_generic_sys_config
    * Access control for transctions to overlapping address.
    * If set, a transaction that accesses a location that overlaps with the
    * address of a previous transaction sent from the same port or another port,
    * will be suspended until all previous transactions to the same or
    * overlapping address are complete. When such a transaction is suspended,
    * the driver is also blocked from getting more transactions from the
    * sequencer/generator. By default this is applicable only to all
    * transactions in AXI3, AXI4, AXI4_LITE and READNOSNOOP and WRITENOSNOOP
    * transactions in AXI_ACE and ACE_LITE interfaces. This default behaviour can
    * however be overridden by disabling the
    * reasonable_overlapping_addr_check_constraint and randomizing 
    * check_addr_overlap of svt_axi_master_transaction to the desired value.  
    * Note however that this parameter is not applicable to WRITEBARRIER,
    * READBARRIER, DVMMESSAGE and DVMCOMPLETE transactions in AXI_ACE and ACE_LITE
    * interfaces.
    *
    * Configuration type: Static 
    */ 
  rand bit overlap_addr_access_control_enable = 0;

  /**
    * @groupname axi_generic_sys_config
    * Enables mapping of two or more slaves to the same address range.  If two
    * or more slaves are mapped to the same address range through the
    * set_addr_range method and this bit is set, no warning is issued. Also,
    * routing checks in system monitor take into account the fact that a
    * transaction initiated at a master could be routed to any of these slaves.
    * If the AXI system monitor is used, slaves with overlapping address must
    * lie within the same instance of AXI System Env. A given address range can
    * be shared between multiple slaves, but the entire address range must be
    * shared.  Note that this doesn't necessarily mean that the entire address
    * map of a slave needs to be shared with another slave. It only means that
    * an address range which lies within the address map of a slave and which
    * is shared with another slave, must be shared in its entirety and not
    * partially. This is possible because the set_addr_range method allows the
    * user to set multiple address ranges for the same slave.  For example,
    * consider two slaves S0 and S1, where S0's address map is from 0-8K and
    * S1's address map is from 4K-12K. The 4K-8K address range overlaps between
    * the two slaves.  The address map can be configured as follows: <br>
    * set_addr_range(0,'h0,'h1000); //0-4K configured for slave 0 <br>
    * set_addr_range(0, 'h1001, 'h2000); //4K-8K configured for slave 0 <br>
    * set_addr_range(1, 'h1001, 'h2000); //4K-8K configured for slave 1 overlaps with slave 0 <br>
    * set_addr_range(1,'h20001, 'h3000); //8K-12K configured for slave 1. <br>
    * 
    * Note that the VIP does not manage shared memory of slaves that have
    * overlapping addresses.  This needs to be managed by the testbench to
    * ensure that data integrity checks in the system monitor work correctly.
    * This can be done by passing the same instance of svt_mem from the
    * testbench to the slave agents that share memory. Refer to
    * tb_amba_svt_uvm_basic_sys example for usage. <br>
    *
    * If the interconnect is enabled (by setting the #use_interconnect
    * property), interconnect model will send a transaction on either of the 
    * slaves with overlapping address, based on the number of outstanding
    * transactions. The port with fewer outstanding transactions will be chosen
    * to route a transaction. <br>
    *
    * If this bit is unset, a warning is issued when setting slaves with
    * overlapping addresses. In such a case, routing checks do not take into
    * account the fact that a transaction could be routed to any of these slaves
    * which may result in routing check failure. <br>
    *
    * Configuration type: Static 
    */
  rand bit allow_slaves_with_overlapping_addr = 0;

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Enables ID based correlation between master transactions and slave
    * transactions. This association is used for performing data integrity
    * checks, as well as for certain functional cover groups. This
    * configuration member can be set for interconnects which transmit the
    * originating master port information on the AxID bits of the slave
    * transaction. The system monitor uses this information to associate the
    * master transactions to slave transactions. The AxID of a transaction to
    * the slave is expected be a combination of the AxID of the master
    * transaction and a specific value corresponding to the master port from
    * which the transaction originated. The information on the source master
    * can be provided in either LSB or MSB of the AxID of transaction sent to
    * slave. The position of the source master information is specified in
    * svt_axi_system_configuration::source_master_info_position. The number of
    * bits used for specifying the source master is given in
    * svt_axi_system_configuration::source_master_info_id_width. The
    * configuration should ensure that the id_width of the slaves can
    * accommodate the additional information transmitted to slaves. The
    * specific value that is appended to the AxID (either in LSB or MSB) for a
    * given master is specified in
    * svt_axi_port_configuration::source_master_id_xmit_to_slaves. In some
    * cases the value that is appended to AxID for a given master may not be
    * static. This can be controlled through
    * svt_axi_port_configuration::source_master_id_xmit_to_slaves_type.  For
    * example assume that an interconnect appends four bits in the LSB to send
    * source master information on a transaction routed to slave. Consider a
    * transaction originating from master 1 with AxID 'b0100. Let us assume
    * that the interconnect appends a four bit ID value equal to 'b0001 for all
    * transactions originating from master 1. If so, the slave transaction will
    * have an ID equal to 'b0100_0001. The corresponding configuration in the
    * VIP should be:
    * <\li>
    * <\li>id_based_xact_correlation_enable = 1;
    * <\li>source_master_info_id_width = 4;
    * <\li>master[1].source_master_id_xmit_to_slaves = 1; //Specifies that value of 1 is appended for transactions originating from master 1
    * <\li>source_master_info_position = LSB
    */ 
  bit id_based_xact_correlation_enable = 0;

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Applicable if id_based_xact_correlation_enable is set.
    * The number of bits of AxID in a slave transaction that is used to
    * indicate the master from which a transaction routed to slave originates
    */
  int source_master_info_id_width = 3;
 

  /**
    * @groupname axi_master_slave_xact_correlation 
    * When this is set to '1', "check_master_slave_xact_data_consistency" check
    * is skip for bytes that are already associated with another slave trasaction.
    * Default value of this attribute is 0. 
    */
  bit skip_check_data_consistency_for_already_associated_bytes = 0;

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Applicable if id_based_xact_correlation_enable is set.
    * Specifies whether the bits in AxID of a transaction routed to slave 
    * which are used to communicate the master from which a transaction originates
    * is in LSB or MSB
    */
  source_master_info_position_enum source_master_info_position = svt_axi_system_configuration::AXI_LSB;
  
  /**
    * @groupname axi_master_slave_xact_correlation 
    * If set to svt_axi_system_configuration::DVMV8,it attempts to cover the DVMv7 and DVMv8
    * architecture recomended operations.
    * If set to svt_axi_system_configuration::DVMV8_1,it attempts to cover the DVMv7, DVMv8 and DVMv8_1
    * architecture recomended operations.
    * If set to svt_axi_system_configuration::DVMV8_1_ONLY,it attempts to cover the DVMv8_1
    * architecture recomended operations only. i.e it won't support DVMv8 or lower DVM operations.
    * If set to svt_axi_system_configuration::DVMV8_4,it attempts to cover the DVMv7, DVMv8 , DVMv8_1 and DVMv8_4
    * architecture recomended operations.
    */
  dvm_version_enum dvm_version = svt_axi_system_configuration::DVMV8;

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Applicable if id_based_xact_correlation_enable is set.
    * Applicable if atleast one interface is svt_axi_port_configuration::AXI_ACE.
    * The value of the relevant bits in AxID for a write transaction that
    * is generated by the interconnect because dirty data that is passed
    * by a snoop transaction couldn't be returned to a master. The relevant
    * bits in AxID are the bits used to indicate the master from which 
    * a transaction originates. This value should be less than the max value
    * possible based on #source_master_info_id_width. For example, if
    * #source_master_info_id_width is 3, this value should not exceed 7.
    */ 
  bit[`SVT_AXI_MAX_ID_WIDTH-1:0] source_interconnect_id_xmit_to_slaves = 0;

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Applicable if id_based_xact_correlation_enable is set.
    * Applicable if atleast one interface is svt_axi_port_configuration::AXI_ACE or
    * svt_axi_port_configuration::ACE_LITE.
    * The value of the relevant bits in AxID for slave transaction that
    * corresponds to a WRITEUNIQUE or WRITELINEUNIQUE transaction.  The
    * relevant bits in AxID are the bits used to indicate the master from which
    * a transaction originates. If there is no specific value that is assigned
    * to WRITEUNIQUE and WRITELINEUNIQUE transactions, this should be set to
    * the max value based on SVT_AXI_MAX_ID_WIDTH (ie, max width of AxID in
    * system). If there is a specific valid value, it should be less than the
    * max value possible based on #source_master_info_id_width. For example, if
    * #source_master_info_id_width is 3, this value should not exceed 7.
    */ 
  bit[`SVT_AXI_MAX_ID_WIDTH-1:0] source_master_id_wu_wlu_xmit_to_slaves = 0;


`ifdef CCI400_CHECKS_ENABLED

  /**
    * @groupname axi_generic_sys_config
    * Access control for cci400 interconnect checks
    * If set, a VIP will check transaction rules defined by cci400 trm
    *
    * Configuration type: Static 
    */ 
  rand bit cci400_protocol_check_enable = 1;

  /** 
    * @groupname cci400_config
    * cci400 register configuration 
    */
  // Since CCI400 configuration may be accessed by different component for
  // register modification or status update and system_configuration can be
  // used as copied object so, it must be declared as static object so that,
  // all system_configuration handles point to single entity
  // It is also declared as "rand" since set_prop_val tries to set rand_mode()
  static rand svt_axi_cci400_vip_cfg  cci400_cfg;
`endif

  /**
   * This is related to low power monitor agent, and for entry into low power state. 
   * It specifies the minimum number of clock cycles that CACTIVE should remain
   * low, before the clock controller asserts the CSYSREQ to request an entry
   * into low power state.
   * Configuration type: Static
   */
  int lp_entry_num_clocks_cactive_low = 4;

  /**
    * @groupname axi_addr_map
    * Address map for the slave components
    */
  svt_axi_slave_addr_range slave_addr_ranges[];

  /**
   * Array of address mappers for non-AXI slaves to which AXI masters can communicate. 
   * An AXI master may communicate to slaves which are non-AXI. The corresponding address mapper
   * needs to be specified here.
   */
  svt_amba_addr_mapper ext_dest_addr_mappers[];

  /**
   * @groupname axi3_4_timeout
   * When the AWVALID signal goes high, this watchdog 
   * timer monitors the AWREADY signal for the channel. If AWREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when AWREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   * 
   * Configuration type: Dynamic 
   */
  int awready_watchdog_timeout = 256000;

  /**
   * @groupname axi3_4_timeout
   * When the WVALID signal goes high, this watchdog 
   * timer monitors the WREADY signal for the channel. If WREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when WREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int wready_watchdog_timeout = 1000;

  /**
   * @groupname axi3_4_timeout
   * When the ARVALID signal goes high, this watchdog 
   * timer monitors the ARREADY signal for the channel. If ARREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when ARREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic 
   */
  int arready_watchdog_timeout = 256000;

  /**
   * @groupname axi3_4_timeout
   * When the RVALID signal goes high, this watchdog 
   * timer monitors the RREADY signal for the channel. If RREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when RREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic 
   */
  int rready_watchdog_timeout = 1000;

  /**
   * @groupname axi3_4_timeout
   * When the read addr handshake ends this watchdog timer monitors the 
   * assertion of first RVALID signal for the channel. If RVALID is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when RVALID is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic 
   */
  int unsigned rdata_watchdog_timeout = 256000;

  /**
   * @groupname axi3_4_timeout
   * When the BVALID signal goes high, this watchdog 
   * timer monitors the BREADY signal for the channel. If BREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when BREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int bready_watchdog_timeout = 1000;

/**
   * @groupname axi3_4_timeout
   * After the last write data beat, this watchdog timer monitors  
   * the write response signals for the channel. If BVALID is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when BVALID is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned bresp_watchdog_timeout = 256*1000;

  /**
   * @groupname axi3_4_timeout
   * When exclusive read request comes, this watchdog timer monitors
   * the exclusive read transaction. If matching exclusive write
   * request doesn't come, then the timer starts.
   * The timer is incremented by 1 every clock and is reset 
   * when matching exclusive write request comes 
   * If the number of clock cycles exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic 
   */
  int excl_wr_watchdog_timeout = 0;

  /**
   * @groupname axi3_4_timeout
   * When write address handshake happens (data after address scenario), 
   * this watchdog timer monitors assertion of WVALID signal. When WVALID 
   * is low, the timer starts. The timer is incremented by 1 every clock 
   * and is reset when WVALID is asserted. If the number of clock cycles 
   * exceeds this value, an error is reported. If this value is set to 0 
   * the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned wdata_watchdog_timeout = 256000;

  /**
   * @groupname axi3_4_timeout
   * When first write data handshake happens (data before address scenario), 
   * this watchdog timer monitors assertion of AWVALID signal. When AWVALID 
   * is low, the timer starts. The timer is incremented by 1 every clock and 
   * is reset when AWVALID is asserted. If the number of clock cycles exceeds 
   * this value, an error is reported. If this value is set to 0 the timer 
   * is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned awaddr_watchdog_timeout = 256000;

  /**
   * @groupname ace_timeout
   * When the ACVALID signal goes high, this watchdog 
   * timer monitors the ACREADY signal for the channel. If ACREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when ACREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int acready_watchdog_timeout = 1000;

  /** @cond PRIVATE */
  /**
   * @groupname ace_timeout
   * When there is a read/write coherent transaction which has snoop. This timer comes into picture.
   * After address phase handshake for a coherent transaction which is to be snooped, this watchdog 
   * timer monitors the ACVALID signal for the channel. If ACVALID is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when ACVALID is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned acvalid_watchdog_timeout = 0;
  /** @endcond */

  /**
   * @groupname ace_timeout
   * When there is a DVM MESSAGE type transaction which has early dvm response to master.
   * This timer comes into picture.
   * After address phase handshake for a coherent transaction which is to be snooped, 
   * the timer is incremented by 1 every clock. If the number of clock cycles 
   * exceeds this value, dvm to snoop reassociate starts. 
   *
   * Configuration type: Dynamic  
   */
  int unsigned early_resp_dvm_watchdog_timeout = 50;

  /**
   * @groupname ace_timeout
   * When the CRVALID signal goes high, this watchdog 
   * timer monitors the CRREADY signal for the channel. If CRREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when CRREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int crready_watchdog_timeout = 1000;

/**
   * @groupname ace_timeout
   * When the snoop address handshake happens,this watchdog timer monitors the  
   * CRVALID (CRRESP) signal for the channel. If CRVALID is low, then the timer  
   * starts. The timer is incremented by 1 every clock and is reset when CRVALID  
   * is sampled high. If the number of clock cycles exceeds this value, an error  
   * is reported. If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned crresp_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When the CDVALID signal goes high, this watchdog 
   * timer monitors the CDREADY signal for the channel. If CDREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when CDREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int cdready_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When the snoop address handshake happens, this watchdog timer monitors the CDVALID  
   * (CDDATA) signal for the channel signal for the channel. If CDVALID is low, then the  
   * timer starts. The timer is incremented by 1 every clock and is reset when CDVALID is    
   * sampled high. If the number of clock cycles exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned cddata_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When the last handshake phase of read transaction ends, this watchdog 
   * timer monitors the RACK signal for the channel. If RACK is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when RACK is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int rack_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When the last handshake phase of write transaction ends, this watchdog 
   * timer monitors the WACK signal for the channel. If WACK is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when WACK is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int wack_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When a barrier transaction is initiated, this watchdog 
   * timer monitors second barrier transaction of the channel. 
   * If the barrier pair doesn't appear, then the timer starts. 
   * The timer is incremented by 1 every clock and
   * is reset when barrier pair is sampled. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int barrier_watchdog_timeout = 1000;

  /**
   * @groupname ace_timeout
   * When a DVM SYNC transaction is initiated by a master on read channel,  
   * this watchdog timer monitors associated DVM COMPLETE transaction on the snoop channel. 
   * The timer starts as soon as DVM SYNC transaction is received from master on read address channel
   * The timer is incremented by 1 every clock and is reset when 
   * DVM COMPLETE is received on the snoop channel. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned coherent_dvm_sync_to_snoop_dvm_complete_watchdog_timeout = 0;

  /**
   * @groupname ace_timeout
   * When a DVM SYNC transaction is received by master on snoop channel, this watchdog 
   * timer monitors associated DVM COMPLETE transaction on the read channel.The timer 
   * starts when DVM SYNC transaction is received by master. The timer is incremented by 1 
   * every clock and is reset when DVM COMPLETE transaction is transmitted on the read channel. 
   * If the number of clock cycles exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int unsigned snoop_dvm_sync_to_coherent_dvm_complete_watchdog_timeout = 0;

  /**
   * @groupname axi4_stream_timeout
   * Applicable when svt_axi_port_configuration::axi_interface_type is AXI4_STREAM
   * When the TVALID signal goes high, this watchdog 
   * timer monitors the TREADY signal for the channel. If TREADY is low, 
   * then the timer starts. The timer is incremented by 1 every clock and
   * is reset when TREADY is sampled high. If the number of clock cycles 
   * exceeds this value, an error is reported. 
   * If this value is set to 0 the timer is not started.
   *
   * Configuration type: Dynamic  
   */
  int tready_watchdog_timeout = 1000;

  /**
   * @groupname axi3_4_timeout
   * Bus inactivity is defined as the time when all five channels
   * of the AXI interface are idle. A timer is started if such a 
   * condition occurs. The timer is incremented by 1 every clock and
   * is reset when there is activity on any of the five channels of
   * the interface. If the number of clock cycles exceeds this value,
   * an error is reported.
   * If this value is set to 0, the timer is not started.
   *
   * Configuration type: Dynamic 
   */
  int bus_inactivity_timeout = 256000;

  /** 
    * @groupname axi_generic_sys_config
    * Array of the masters that are participating in sequences to drive
    * transactions.   This property is used by virtual sequences to decide
    * which masters to drive traffic on.  An index in this array corresponds to
    * the index of the master in slave_cfg. A value of 1 indicates that the
    * master in that index is participating. A value of 0 indicates that the
    * master in that index is not participating. An empty array implies that
    * all masters are participating.
    */
   bit participating_masters[];

   /** 
    * @groupname axi_generic_sys_config
    * Array of the slaves that are participating in sequences to drive
    * transactions.   This property is used by virtual sequences to decide
    * which slaves to drive traffic on.  An index in this array corresponds to
    * the index of the slave in slave_cfg. A value of 1 indicates that the
    * slave in that index is participating. A value of 0 indicates that the
    * slave in that index is not participating. An empty array implies that
    * all slaves are participating.
    */
   bit participating_slaves[];

  /** @cond PRIVATE */
  /**
    * @groupname interconnect_config
    * Array that represents the domain configuration of the system.
    * Each item represents an innershareable/outershareable/nonshareable
    * region with the corresponding masters and addresses.
    * Use the following methods to configure this easily:
    * svt_axi_system_configuration::create_new_domain()
    * svt_axi_system_configuration::set_addr_for_domain()
    * Applicable when there is atleast one interface in the system
    * with svt_axi_port_configuration::axi_interface_type set to
    * svt_axi_port_configuration::AXI_ACE or
    * svt_axi_port_configuration::ACE_LITE
    */
  svt_axi_system_domain_item system_domain_items[];

  /**
    * @groupname interconnect_config
    * Note: This use model is currently being deprecated.
    * Please use system_domain_items member.
    * Array that represents in the masters in inner domain.
    * Each element in the array represents a single inner domain.
    * The a bit value of 1 indicates that a master belongs to an inner domain.
    * As an example consider 5 masters in a system. Consider that masters
    * 0 and 1 belong to one inner domain and masters 2 and 3 belong to another
    * inner domain. This will be represented in the variable as:
    * inner_domain[0] = 5'b00011;
    * inner_domain[1] = 5'b01100;
    * Applicable only when svt_axi_port_configuration::axi_interface_type is AXI_ACE.
    * 
    * This member is used by Interconnect VIP and System Monitor VIP components.
    */
  bit[`SVT_AXI_MAX_NUM_MASTERS-1:0] inner_domain[];

  /**
    * @groupname interconnect_config
    * Note: This use model is currently being deprecated.
    * Please use system_domain_items member.
    * Array that represents in the masters in inner domain.
    * Each element in the array represents a single inner domain.
    * The a bit value of 1 indicates that a master belongs to an inner domain.
    * As an example consider 5 masters in a system. Consider that masters
    * 0 and 1 belong to one inner domain and masters 2 and 3 belong to another
    * inner domain. Consider that masters 0,1,2,3 are in a single outer domain
    * and that master 5 is part of the system domain. 
    * This will be represented in the variable as:
    * inner_domain[0] = 5'b00011;
    * inner_domain[1] = 5'b01100;
    * outer_domain[0] = 5'b01111;
    * Note that the system domain includes all the masters in the system.
    * Applicable only when svt_axi_port_configuration::axi_interface_type is AXI_ACE.
    *
    * This member is used by Interconnect VIP and System Monitor VIP components.
    */
  bit[`SVT_AXI_MAX_NUM_MASTERS-1:0] outer_domain[];

  /**
    * @groupname ace_config
    * defines starting address of each exclusive monitor.
    * User can simply configure as start_address_ranges_for_exclusive_monitor[<exclusive monitor index>] = < starting address of exclusive monitor[<exclusive monitor index>] >
    * Example:: start_address_ranges_for_exclusive_monitor[2] = 32'h8800_0000; < starting address of exclusive monitor[2] >
    */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0] start_address_ranges_for_exclusive_monitor[];

  /**
    * @groupname ace_config
    * defines end address of each exclusive monitor.
    * User can simply configure as end_address_ranges_for_exclusive_monitor[<exclusive monitor index>] = < end address of exclusive monitor[<exclusive monitor index>] >
    * Example:: end_address_ranges_for_exclusive_monitor[2] = 32'hC400_0000; < end address of exclusive monitor[2] >
    */
  bit [`SVT_AXI_MAX_ADDR_WIDTH-1 : 0]   end_address_ranges_for_exclusive_monitor[];

  /** @endcond */

  /** 
    * @groupname ace_config
    * if it is set to '1', exokay_not_sent_until_successful_exclusive_store_ack_observed check 
    * is executed on per caheline basis.
    * If set to '0' then the check will consider exclusive store transaction targeted to any 
    * cacheline that is yet to receive ACK i.e. regardless of the transaction address.
    */
  bit check_exokay_not_sent_until_successful_exclusive_store_ack_observed_per_cacheline = 0;
  
  /**
    * @groupname axi_system_coverage_protocol_checks
    * Enables AXI system level coverage group for master to slave access. Note
    * that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */
  bit system_axi_master_to_slave_access_enable = 1;

  /**
    * @groupname axi_system_coverage_protocol_checks
    * Applicable if system_axi_master_to_slave_access_enable is set.
    * If set to svt_axi_system_configuration::EXHAUSTIVE,it attempts to cover all
    * possible combination of master to slave accesses and hence system_axi_master to slave access
    * covergroup is used.
    * If it is set to  svt_axi_system_configuration::RANGE_ACCESS then it equally
    * distributes all possible master to slave access values to fixed 16 different bins 
    * and uses system_axi_master to slave access range covergroup.
    * However, if total number of accesses between masters and slaves, is less than 16 then 
    * it attempts to cover all possible values and hence uses systen_axi_master to slave access 
    * covergroup.
    */
  system_axi_master_to_slave_access_enum system_axi_master_to_slave_access = svt_axi_system_configuration::EXHAUSTIVE; 

  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level coverage group for concurrent ReadUnique and 
    * CleanUnique transactions from different ACE masters.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */  
  bit system_ace_concurrent_readunique_cleanunique_enable = 1;

  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level coverage group for concurrent outstanding transactions 
    * from different ACE masters with same AxID and same interleaved group id.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */  
  bit system_interleaved_ace_concurrent_outstanding_same_id_enable = 0;

  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level coverage group for concurrent overlapping 
    * coherent transactions on different ACE masters in the system.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */  
  bit system_ace_concurrent_overlapping_coherent_xacts_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level coverage group for coherent to snoop transaction
    * association.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_coherent_and_snoop_association_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables system_ace_dirty_data_write covergroup.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_dirty_data_write_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables system_ace_cross_cache_line_dirty_data_write covergroup.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_cross_cache_line_dirty_data_write_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables system_ace_snoop_and_memory_returns_data covergroup.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_snoop_and_memory_returns_data_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables system_ace_write_during_speculative_fetch covergroup.
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_write_during_speculative_fetch_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables
    * system_ace_xacts_with_high_priority_from_other_master_during_barrier
    * covergroup.
    * Note that to generate AXI system level coverage, you also need to enable
    * AXI System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_xacts_with_high_priority_from_other_master_during_barrier_enable = 1;

   /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables system_ace_barrier_response_with_outstanding_xacts covergroup
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_barrier_response_with_outstanding_xacts_enable = 1;

  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level system_ace_store_overlapping_coherent_xact covergroup 
    * when two master issue coherent transactions to overlapping cacheline at same time
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_store_overlapping_coherent_xact_enable = 1;
  
  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level system_ace_no_cached_copy_overlapping_coherent covergroup
    * when two masters issue coherent transactions to overlapping cacheline at same time
    * Note that to generate AXI system level coverage, you also need to enable AXI
    * System Monitor using member #system_monitor_enable.
    * <b>type:</b> Static
    */ 
  bit system_ace_no_cached_copy_overlapping_coherent_xact_enable = 1;

  /**
    * @groupname ace_config
    * Enables the get_dynamic_coherent_to_snoop_xact_type_match callback in the
    * system monitor that allows users to set the snoop transaction type
    * corresponding to a coherent transaction type on a per snoop transaction
    * basis. This callback is useful in situations where a multi cacheline
    * coherent transaction results in snoop transactions where all the snoop
    * transactions may not be of the same type. For example, for a WRITEUNIQUE
    * transaction, an interconnect may choose an implementation where the snoop
    * corresponding to the addresses upto the cacheline boundary have one type
    * and the subsequent snoops have a different type. 
    */
  bit dynamic_coherent_to_snoop_xact_type_cb_enable = 0;

  /** @cond PRIVATE */
  /**
    * @groupname ace_system_coverage_protocol_checks
    * Enables ACE system level
    * system_ace_downstream_xact_response_before_barrier_response covergroup
    * when a barrier response is received after WRITENOSNOOP and READNOSNOOP
    * transactions prior to the barrier from the same port have received a
    * response from the dowstream slave. This covergroup is enabled only when
    * id_based_xact_correlation_enable is enabled
    * Currently not supported
    */
  bit system_ace_downstream_xact_response_before_barrier_response_enable = 1;
  /** @endcond */

  /**
   * @groupname axi_addr_map
   * Enables complex address mapping capabilities.
   * 
   * When this feature is enabled then the get_dest_slave_addr_from_global_addr(),
   * get_dest_global_addr_from_master_addr(),get_dest_slave_addr_name_from_global_addr,
   * get_ext_dest_slave_addr_from_global_addr and get_slave_addr_range() methods
   * must be used to define the memory map for this AXI system.
   * 
   * When this feature is disabled then the set_addr_range and translate_address()
   * methods must be used to define the memory map for this AXI system.
   */
  bit enable_complex_memory_map = 0;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
 
  /** @cond PRIVATE */
  /**
   *  Stores the Log base 2(\`SVT_AXI_MAX_NUM_MASTERS),Used in constraints
   */
  protected int log_base_2_max_num_masters = 0;
   int num_ports_per_interleaving_group[int];
   local int interleaving_groupQ[int];
   local int ports_per_interleaving_group[][$];
   int lowest_position_of_addr_bits[*];
   int number_of_addr_bits_for_port_interleaving[*];
   int lowest_port_id_per_interleaving_group[*] ;

  /** @endcond */

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
b82rUmBX7TMiI0kNZCXdQHUUy19sQqsbvd4UxCddZhNI20XaAdR1iPVC0z0wyUXk
TO0ZJfRE3HwR3/SYOQjhJqdJCc33yHR+JNupnzRmewiOIksmDTd9fBQq3/Cvu7wY
PEgjSbRIWPVObOOM9yohxRNUiTwusnTz1NcXhncwA7A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 46263     )
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
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_system_configuration", AXI_IF axi_if=null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param name Instance name of the configuration
    */
  extern function new (string name = "svt_axi_system_configuration", AXI_IF axi_if=null);
`else
  /**
    * CONSTUCTOR: Create a new configuration instance, passing the appropriate
    * argument values to the parent class.
    *
    * @param log Instance name of the log. 
    */
   `svt_vmm_data_new(svt_axi_system_configuration)
      extern function new (vmm_log log = null, AXI_IF axi_if =null);
`endif

  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * 1) calculate the log_2 of \`SVT_AXI_MAX_NUM_MASTERS
   */
  extern function void pre_randomize ();
  // ***************************************************************************
  //   SVT shorthand macros 
  // ***************************************************************************
  `svt_data_member_begin(svt_axi_system_configuration)
      `svt_field_array_object(master_cfg              ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(lp_master_cfg              ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(slave_cfg               ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_object      (ic_cfg                  ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `ifdef CCI400_CHECKS_ENABLED
    `svt_field_object      (cci400_cfg              ,`SVT_NOCOPY|`SVT_DEEP,`SVT_HOW_DEEP)
    `endif
    `svt_field_array_object(slave_addr_ranges       ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(system_domain_items     ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_array_object(ext_dest_addr_mappers     ,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_DEEP,`SVT_HOW_DEEP)
    `svt_field_int(enable_xml_gen, `SVT_ALL_ON|`SVT_BIN|`SVT_NOCOPY)
    `svt_field_enum(svt_xml_writer::format_type_enum, pa_format_type, `SVT_ALL_ON|`SVT_NOCOPY)
    `svt_data_member_end(svt_axi_system_configuration)

  //----------------------------------------------------------------------------
  /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

  /** Ensures that if id_width is 0, it is consistent across all ports */
  extern function void post_randomize();
  /**
   * Assigns a system interface to this configuration.
   *
   * @param axi_if Interface for the AXI system
   */
  extern function void set_if(AXI_IF axi_if);
  //----------------------------------------------------------------------------
  /**
    * Allocates the master, low power master and slave configurations before a user sets the
    * parameters.  This function is to be called if (and before) the user sets
    * the configuration parameters by setting each parameter individually and
    * not by randomizing the system configuration. 
    */
  extern function void create_sub_cfgs(int num_masters = 1, int num_slaves = 1, int num_ic_master_ports = 0, int num_ic_slave_ports = 0, int num_lp_masters=0);
  //----------------------------------------------------------------------------

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

  /** Does a basic validation of this configuration object. */
  extern virtual function bit do_is_valid ( bit silent = 1, int kind = RELEVANT);
  // ---------------------------------------------------------------------------

  /** @cond PRIVATE */
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
  extern virtual function svt_pattern do_allocate_pattern();

extern virtual function void calculate_port_interleaving_parameter(output int num_ports_per_interleaving_group[int],output int lowest_position_of_addr_bits[*],output int number_of_addr_bits_for_port_interleaving[*],output int lowest_port_id_per_interleaving_group[*]);

  extern virtual function bit is_address_in_range_for_port_interleaving(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,svt_axi_port_configuration port_cfg,bit is_device_type_xact,bit is_dvm_xact,bit is_snoop_xact,output bit is_device_dvm_ok_for_interleaving);

  extern function void add_to_inner_domain(int ports[$]);

  extern function void add_to_outer_domain(int ports[$]);

  extern function void get_masters_in_inner_domain(int port_id, output int inner_domain_masters[$]);

  extern function void get_masters_in_outer_domain(int port_id, output int outer_domain_masters[$]);

  extern function void get_masters_in_system_domain(int port_id, output int system_domain_masters[$], input bit used_by_interconnect=1);  

  /** Gets the slave port corresponding to the address provided 
    * Note that, "addr" provided through argument should be untagged address i.e. address which doesn't
    *      have any address tag attributes appended at MSB.
    */
  extern function void get_slave_route_port(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0]
          addr, output int slave_port_id, output int range_matched, output bit is_register_addr_space, input bit ignore_unampped_addr = 0, input int master_port_id=-1, input bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute=0);

  /** Allows user to redefine the master to slave routing behaviour in the interconnect VIP. Interconnect VIP will call this method and use the first slave port returned by this function to route the incoming master transaction.
      By default, this method is undefined and returns FALSE.
      User is expected to define this method with the routing behaviour of their choice and must return TRUE. Interconnect VIP will then use the first slave port returned by this function for routing master transaction. Otherwise, it will use its default mode of routing master transactions to slave ports based on the address ranges.
      Note: This method is applicable for Interconnect VIP and System Monitor component.
      */
  extern virtual function bit get_interconnect_slave_route_port(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] tagged_master_addr, bit is_register_addr_space, int master_port_id, output int slave_port_ids[$]);

  /** Gets the slave response corresponding to the address and the configured region & its attributes 
    * Note that, "addr" provided through argument should be untagged address i.e. address which doesn't
    *      have any address tag attributes appended at MSB.
    */
  extern function void get_range_region_response(bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr, bit is_write, bit [`SVT_AXI_REGION_WIDTH-1:0]   region_id, output bit[1:0] slave_response, input bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute=0); 
  
  /** 
    * If the domain_type is outershareable, checks that all masters in the inner domain of the masters
    * listed in master_ports[] are included in outershareable (ie, in master_ports[])
    * For all other domain types, no check is done.
    */
  extern function bit check_domain_inclusion(svt_axi_system_domain_item::system_domain_type_enum domain_type,int master_ports[]);
  
  /**
    * Gets the domain item corresponding to master_port and domain_type
    */
  extern function svt_axi_system_domain_item get_domain_item_for_port(svt_axi_system_domain_item::system_domain_type_enum domain_type,int master_port);
  /** @endcond */

  /**
    * @groupname interconnect_config
    * Creates a new domain consisting of the masters given in master_ports.
    * @param domain_idx A unique integer id for this domain.
    * @param domain_type Indicates whether this domain is innershareable/outershareable/nonshareable
    * @param master_ports[] An array indicating the ports that are part of this domain
    * If port interleaving feature is going to be used in testbench then this
    * API should be called after setting the port configuration "port_interleaving_enable"
    */
  extern function bit create_new_domain(int domain_idx, svt_axi_system_domain_item::system_domain_type_enum domain_type, int master_ports[]);

  /**
    * @groupname interconnect_config
    * Sets an address range for the domain with the given domain_idx.
    * The domain should already have been created for this domain_idx using create_new_domain.
    * @param domain_idx The domain_idx corresponding to which this address range needs to be set. 
    * @param start_addr The start address of the address range to be set for this domain.
    * @param end_addr The end address of the address range to be set for this domain.
    */
  extern function void set_addr_for_domain(int domain_idx, bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr, bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr);

  // ---------------------------------------------------------------------------
  /**
   * @groupname axi_addr_map
   * Gets the local slave address from a provided global address
   * 
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to translate a global address into a slave
   * address.
   * 
   * If complex memory maps are not enabled, then this method utlizes the
   * get_slave_route_port() method to obtain the slave port ids associated with
   * address the supplied global address, and the supplied global address is returned
   * as the slave address.
   * 
   * @param global_addr The value of the global address
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   * @param requester_name If called to determine the destination of a transaction from
   *   a master, this field indicates the name of the master component issuing the
   *   transaction. This can potentially be used if the routing has a dependency on the
   *   master that initiates a transaction.
   * @param ignore_unmapped_addr An input indicating that unmapped addresses should not
   *   be flagged as an error
   * @param is_register_addr_space If this address targets the register address space of
   *   a component, this field must be set
   * @param slave_port_ids The slave port to which the given global address is destined
   *   to. In some cases, there can be multiple such slaves. If so, all such slaves must
   *   be present in the queue.
   * @param slave_addr Output address at the slave
   * @output Returns 1 if there is a slave to which the given global address could be
   *   mapped to, else returns 0.
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual function bit get_dest_slave_addr_from_global_addr(
    input  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr, 
    input  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input  string requester_name = "", 
    input  bit ignore_unmapped_addr = 0,
    output bit is_register_addr_space,
    output int slave_port_ids[$],
    output bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr,
    input svt_axi_transaction xact);
  // ---------------------------------------------------------------------------
  /**
   * @groupname axi_addr_map
   * Gets the local slave address from a provided global address
   * 
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to translate a global address into a slave
   * address.
   * 
   * If complex memory maps are not enabled, then this method utlizes to obtain the slave port
   * ids names associated with address the supplied global address, and the supplied global 
   * address is returned as the slave address.
   * 
   * @param global_addr The value of the global address
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   * @param requester_name If called to determine the destination of a transaction from
   *   a master, this field indicates the name of the master component issuing the
   *   transaction. This can potentially be used if the routing has a dependency on the
   *   master that initiates a transaction.
   * @param ignore_unmapped_addr An input indicating that unmapped addresses should not
   *   be flagged as an error
   * @param slave_port_ids The slave port to which the given global address is destined
   *   to. In some cases, there can be multiple such slaves. If so, all such slaves must
   *   be present in the queue.
   * @output Returns 1 if there is a slave to which the given global address could be
   *   mapped to, else returns 0.
   * @output slave_names in the queues
   * @param xact A reference to the data descriptor object of interest.
   */
   extern virtual function bit get_dest_slave_addr_name_from_global_addr(
    input  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr, 
    input  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input  string requester_name = "", 
    input  bit ignore_unmapped_addr = 0,
    output int slave_port_ids[$],
    output svt_amba_addr_mapper::path_cov_dest_names_enum slave_names[$],
    input svt_axi_transaction xact);

 // ---------------------------------------------------------------------------
  /**
   * Gets the configured slave address mapper from a provided global address
   * 
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to translate a global address into a slave
   * address.
   * 
   * If complex memory maps are not enabled, then this method utlizes to obtain the slave port
   * ids names associated with address the supplied global address, and the supplied global 
   * address is returned as the slave address.
   * 
   * @param global_addr The value of the global address
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   * @param requester_name If called to determine the destination of a transaction from
   *   a master, this field indicates the name of the master component issuing the
   *   transaction. This can potentially be used if the routing has a dependency on the
   *   master that initiates a transaction.
   * @param ignore_unmapped_addr An input indicating that unmapped addresses should not
   *   be flagged as an error
   * @param slave_port_ids The slave port to which the given global address is destined
   *   to. In some cases, there can be multiple such slaves. If so, all such slaves must
   *   be present in the queue.
   * @output Returns 1 if there is a slave to which the given global address could be
   *   mapped to, else returns 0.
   * @output slave_names in the queues
   */
   extern virtual function bit get_dest_slave_addr_mapper_from_global_addr(
    input  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr, 
    input  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input  string requester_name = "", 
    input  bit ignore_unmapped_addr = 0,
    output int slave_port_ids[$],
    output svt_amba_addr_mapper slave_mappers[$]);

  // ---------------------------------------------------------------------------
  /**
   * @groupname axi_addr_map
   * Gets the global address associated with the supplied master address
   *
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to translate a master address into a global
   * address.
   * 
   * This method is not utilized if complex memory maps are not enabled.
   *
   * @param master_idx The index of the master that is requesting this function.
   * @param master_addr The value of the local address at a master whose global address
   *   needs to be retrieved.
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *   mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *     indicates a non-secure access
   *   mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates a
   *     write access.
   * @param requester_name If called to determine the destination of a transaction from a
   *   master, this field indicates the name of the master component issuing the
   *   transaction.
   * @param ignore_unmapped_addr An input indicating that unmapped addresses should not
   *   be flagged as an error
   * @param is_register_addr_space If this address targets the register address space of
   *   a component, this field must be set
   * @param global_addr The global address corresponding to the local address at the
   *   given master
   * @output Returns 1 if there is a global address mapping for the given master's local
   *   address, else returns 0
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual function bit get_dest_global_addr_from_master_addr(
    input  int master_idx,
    input  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] master_addr,
    input  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input  string requester_name = "", 
    input  bit ignore_unmapped_addr = 0,
    output bit is_register_addr_space,
    output bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr,
    input svt_axi_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Gets the local external slave address from a provided global address
   * 
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to translate a global address into a slave
   * address.
   * 
   * If complex memory maps are not enabled, then this method utlizes to obtain the slave port
   * ids names associated with address the supplied global address, and the supplied global 
   * address is returned as the slave address.
   * 
   * @param global_addr The value of the global address
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *       indicates a non-secure access
   *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
   *       a write access.
   * @param requester_name If called to determine the destination of a transaction from
   *   a master, this field indicates the name of the master component issuing the
   *   transaction. This can potentially be used if the routing has a dependency on the
   *   master that initiates a transaction.
   * @param ignore_unmapped_addr An input indicating that unmapped addresses should not
   *   be flagged as an error
   * @param is_register_addr_space If this address targets the register address space of
   *   a component, this field must be set
   * @param slave_port_ids The slave port to which the given global address is destined
   *   to. In some cases, there can be multiple such slaves. If so, all such slaves must
   *   be present in the queue.
   * @param slave_addr Output address at the slave
   * @output Returns 1 if there is a slave to which the given global address could be
   *   mapped to, else returns 0.
   * @param xact A reference to the data descriptor object of interest.
   */ 
    extern virtual function bit get_ext_dest_slave_addr_from_global_addr(
    input  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] global_addr, 
    input  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input  string requester_name = "", 
    input  bit ignore_unmapped_addr = 0,
    output bit is_register_addr_space,
    output int slave_port_ids[$],
    output svt_amba_addr_mapper::path_cov_dest_names_enum slave_names[$],
    output bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr,
    input svt_axi_transaction xact);
  // ---------------------------------------------------------------------------
  /**
   * @groupname axi_addr_map
   * Returns whether the supplied slave address is legal for the slave component
   * 
   * If complex memory maps are enabled through the use of #enable_complex_memory_map,
   * then this method must be implemented to indicate whether the address received by
   * the slave is legal.
   * 
   * The default behavior of this method is to return 1.
   * 
   * @param slave_idx The index of the slave that is requesting this function
   * @param slave_addr The value of the local address at the slave
   * @param mem_mode Variable indicating security (secure or non-secure) and access type
   *   (read or write) of a potential access to the destination slave address.
   *   mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
   *     indicates a non-secure access
   *   mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates a
   *     write access.
   * @param target_name Name of the slave component that received this address
   * @output Returns 1 if the address is legal for the indicated slave, else returns 0
   */
  extern virtual function bit is_valid_addr_at_slave(
    input int slave_idx,
    input bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] slave_addr,
    input bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0,
    input string target_name = "");

  // ---------------------------------------------------------------------------
  /**
   * @groupname axi_addr_map
   * Returns a valid address range for the given slave index.
   * 
   * If complex memory maps have been enabled through the use of the
   * #enable_complex_memory_map property, then this method must be overridden
   * by an extended class.
   * 
   * If complex memory maps have not been enabled, then this method randomly selects
   * an index from the #slave_addr_ranges array that is associated with the supplied
   * slave index and returns the address range associated with that element.
   * 
   * @param master_port_id The index of the master for which an address range is required
   * @param slave_port_id The index of the slave for which an address range is required
   * @param lo_addr The lower boundary of the returned address range
   * @param hi_addr The higher boundary of the returned address range
   * @output Returns 1, if a valid range could be found for the given slave index,
   *   else returns 0
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual function bit get_slave_addr_range(
    input  int master_port_id,
    input  int slave_port_id,
    output bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] lo_addr,
    output bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] hi_addr,
    input svt_axi_transaction xact);

  /** 
    * @groupname axi_addr_map
    * Virtual function that is used by the interconnect VIP and system monitor
    * to get a translated address. The default implementation of this function
    * is empty; no translation is performed unless the user implements this
    * function in a derived class. 
    *
    * Interconnect VIP: If the interconnect VIP needs to map an address received
    * from a master to a different address to the slave, the address translation
    * function should be provided by the user in this function. By default, the
    * interconnect VIP does not perform address translation.  
    *
    * System Monitor: The system monitor uses this function to get the
    * translated address while performing system level checks to a given
    * address. 
    *
    * Note that the system address map as defined in the #slave_addr_ranges is
    * based on the actual physical address, that is, the address after
    * translation, if any.  
    * 
    * If system is configured to support indipendent address spaces by tagging such
    * attributes as MSB address bits then user should consider that this task may
    * be called with tagged address and translate address accordingly. 
    * Ex: if secure and non-secure transactions are supported indipendently i.e.
    *     both can target same address without affecting another then tagged address
    * will contain <security_attributes> as MSB address bit. [0 => secure, 1 => non-secure]
    * Typically address translation can be performed only on the untagged part of
    * the address which can be obtained via master_cfg[<master_id>].get_untagged_addr(<tagged_addr>)
    * after address translation is complete, it should be tagged before returning the funciton.
    * This can be done as follows::  return( (addr-untagged_addr) + translated_addr );
    *
    * @param addr The address to be translated.  
    * @return The translated address.
    */
  extern virtual function bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] translate_address(bit[`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Virtual function that gets the components of the ID as a transaction is
    * routed from a master to slave. The default implementation uses
    * id_based_xact_correlation_enable and associated parameters to calculate
    * the returned value.  When a master transaction is routed to a slave, the
    * ID transmitted by the master is transmitted to the slave along
    * with some additional information in the IDs. This variable indicates how
    * the master ID was transformed when the transaction got routed to the
    * slave. By default, the value of this variable is same as master_id
    * However, a user may override this function to define a custom
    * implementation
    * @param master_id The ID value as seen at the master
    * @param master_port The port index at which master_id is seen
    */
  extern virtual function bit[`SVT_AXI_MAX_ID_WIDTH-1:0] get_master_xact_id_at_slave_from_master_id(
    bit[`SVT_AXI_MAX_ID_WIDTH-1:0] master_id,
    int master_port
  );

  /**
    * @groupname axi_master_slave_xact_correlation 
    * Virtual function that gets the components of the ID as a transaction is
    * routed from a master to slave. The default implementation uses
    * id_based_xact_correlation_enable and associated parameters to calculate
    * the value of source_master_id_at_slave.  When a master transaction is
    * routed to a slave, the ID transmitted by the master is padded with some
    * information indicating the port index from which the master transaction
    * originated. This variable indicates the value of the part of the ID that
    * indicates the source master of this transaction. By default, the value of
    * this variable is equal to
    * svt_axi_port_configuration::source_master_id_xmit_to_slaves corresponding
    * to master_port. However, a user may override this function to define a
    * custom implementation
    * @param master_id The ID value as seen at the master
    * @param master_port The port index at which master_id is seen
    */
  extern virtual function bit[`SVT_AXI_MAX_ID_WIDTH-1:0] get_source_master_id_at_slave_from_master_id(
    bit[`SVT_AXI_MAX_ID_WIDTH-1:0] master_id,
    int master_port
  );

  /**
    * @groupname axi_master_slave_xact_correlation
    * Virtual function that indicates whether the ID requirements for master and
    * slave transaction meet DUT requirements. Typically, the ID of master_xact or
    * some bits of master_xact are propogated to slave_xact. Also, the source
    * master is indicated through some bits at the slave transaction. These and
    * other DUT considerations can be defined in this function to indicate whether
    * the two transactions fulfill requirements of ID transformation
    */
  extern virtual function bit is_master_id_and_slave_id_correlated(
          svt_axi_transaction master_xact,
          svt_axi_transaction slave_xact
          );

  /** 
    * @groupname axi_addr_map
    * Set the address range for a specified slave.
    * If two slaves have overlapping address ranges, the
    * #allow_slaves_with_overlapping_addr property must be set.
    *
    * @param slv_idx Slave index for which address range is to be specified.
    * Index for Nth slave is specified by (N-1), starting at 0. If a value of -1
    * is passed, it indicates that the given address range refers to the address
    * space of the registers in the interconnect. The data integrity system
    * check does not perform checks on configuration transactions which are
    * targeted to registers within the interconnect, as these transactions are
    * not targeted to external memory.
    *
    * @param start_addr Start address of the address range
    *
    * @param end_addr End address of the address range
    *
    * @param tdest Not yet supported
    */

  extern function void set_addr_range(int slv_idx, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr, bit [`SVT_AXI_MAX_TDEST_WIDTH-1:0] tdest = 0, bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute=0);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI SVT
   * suite. This is checked against UVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by the AXI SVT
   * suite. This is checked against OVM_MAX_PACKER_BYTES to make sure the specified
   * setting is sufficient for the AXI SVT suite.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif
 /**
   * The method indicates if a given master's index is participating
   * based on the contents of pariticipating_masters array. 
   * @param master_index Master index. Corresponds to the index in master_cfg[] array 
   * @return Indicates if given master index is participating
   */
 extern function bit is_participating(int master_index);

 /**
   * The method indicates if a given slave's index is participating
   * based on the contents of pariticipating_slaves array. 
   * @param slave_index Slave index. Corresponds to the index in slave_cfg[] array. 
   * @return Indicates if given slave index is participating
   */
 extern function bit is_participating_slave(int slave_index);
 
 /**
   * Gets a random master index with the given interface type. The master
   * should be active(based on svt_axi_port_configuration::is_active) and 
   * should be participating(based on participating_masters) as well.
   * @param axi_intf The interface type of the master that is required
   * @param system_id The system_id of this system configuration 
   * @return The index of the AXI master with the given interface type
   */ 
 extern function int get_random_axi_master_interface_port(svt_axi_port_configuration::axi_interface_type_enum axi_intf, output int system_id);

 /**
   * Gets the number of active, participating masters with the given
   * interface type
   * @param axi_intf The interface type of the master that is required
   * @return The number of active, participating masters with the given
   *         interface type
   */
 extern function int get_num_active_participating_masters(svt_axi_port_configuration::axi_interface_type_enum axi_intf);

 /**
   * Gets the number of active, participating masters with the given
   * interface type and dvm_enable set
   * @param axi_intf The interface type of the master that is required
   * @return The number of active, participating masters with the given
   *         interface type and dvm_enable set
   */
 extern function int get_num_active_participating_dvm_enabled_masters(svt_axi_port_configuration::axi_interface_type_enum axi_intf);
 
/** @cond PRIVATE */
  extern function bit get_address_shareability(int port_id, 
                                  bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr,
                                  output svt_axi_system_domain_item::system_domain_type_enum addr_domain_type,
                                  output bit error
                                 );

  /** returns 1 if snoop filter is enabled in any of the peer master's cache */
 extern function int is_peer_snoop_filter_enabled(svt_axi_port_configuration port_cfg);

 /** Used to set start and end address ranges for each exclusive monitor. It adds address ranges for all exclusive monitor sequentially.
   * It means that, it works like a fifo. First call updates start and end addresses of first exclusive monitor i.e. exclusive monitor[0]
   * second call updates for 2nd exclusive monitor i.e. exclusive monitor[1] and so on.
   *
   * This is just a utility function. User can also configure or modify address ranges for different exclusive montiors by directly accessing
   * start_address_ranges_for_exclusive_monitor[], end_address_ranges_for_exclusive_monitor[]
   */
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lj5v0+9J1b4glafpqk6p7KuNDi7fG22h2ryqnAFK4clvLHNo9DbIkBWWi1W1HSAj
axdUV91e2CpG4aeer0Mj45sCl00Nox7IhDnKwxLAMdtHY8fZZQPHQso6RtGUjTBK
+/4dA8ZMrAwVYDv5lBk5U+HBUOTkIeiZH8A40DTuqz0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 46476     )
WpGCWVYd109i+n+GJ0WZxMI6OvLo4Rld7sPxpvsfnWN34hRAxCO/ly72JnkEv2He
xZPR1S7Rkn+WXaZFzRKSPbM/7OIG5RmPQTGXbffRKoVsM55VWMENEYOl1lH+13kC
sEXhNtB1+xrMrxVTIax3FPI2hqC7wPzYqTdSWIEPcdHq8NofCl9w8PdLMjsuxiC/
6GT50aaK7Uo+bD9ZBDNdqN7zdW2vvZxAIDU/DZu9zJJAmxkS+IvZWhNsSwsXDJgK
AF9G5uAOPjJ17ZeCCQgS4uU1EeNlFGrm0MRPTLK/HKw=
`pragma protect end_protected
 extern virtual function void set_exclusive_monitor_addr_range(bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] start_addr, bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] end_addr, bit[`SVT_AXI_ADDR_TAG_ATTRIBUTES_WIDTH-1:0] addr_attribute=0);

 /** Returns index of exclusive monitor which is responsible to monitor the current address - addr */
 extern virtual function int get_exclusive_monitor_index_from_addr(bit [`SVT_AXI_MAX_ADDR_WIDTH-1:0] addr);

 /** Returns 1 if any of the masters have port interleaving enabled */
 extern virtual function bit has_port_interleaving_enabled();

`ifdef SVT_AMBA_INTERFACE_METHOD_DISABLE 
 /**
  * Function set_master_common_clock_mode allows user to specify whether a master port
  * interface should use a common clock, or a port specific clock.
  *
  * @param mode If set to 1, common clock mode is selected. In this case, the
  * common clock signal passed as argument to the interface, is used as clock.
  * This mode is useful when all AXI VIP components need to work on a single
  * clock. This is the default mode of operation. If set to 0, signal aclk is
  * used as clock. This mode is useful when individual AXI VIP components work
  * on a different clock.
  *
  * @param idx This argument specifies the master & slave port index to which
  * this mode needs to be applied. The master & slave port index starts from
  * 0.
  */
 extern function void set_master_common_clock_mode (bit mode, int idx);

 /**
   * Function set_slave_common_clock_mode allows user to specify whether a slave port
   * interface should use a common clock, or a port specific clock.
   *
   * @param mode If set to 1, common clock mode is selected. In this case, the
   * common clock signal passed as argument to the interface, is used as clock.
   * This mode is useful when all AXI VIP components need to work on a single
   * clock. This is the default mode of operation. If set to 0, signal aclk is
   * used as clock. This mode is useful when individual AXI VIP components work
   * on a different clock.
   *
   * @param idx This argument specifies the master & slave port index to which
   * this mode needs to be applied. The master & slave port index starts from
   * 0.
   */
  extern function void set_slave_common_clock_mode (bit mode, int idx);
`endif

/** @endcond */


`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_system_configuration)
  `vmm_class_factory(svt_axi_system_configuration)
`endif   
endclass

// -----------------------------------------------------------------------------

/** 
System Configuration Class Utility methods definition.
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i5nTBnnHVKJzL6nXTv90jhkIxKJ3HNh7PdLuSmcr5gT/8XLkykvcXHvnbJ5kyip4
hPCv/rUDszEwve6tXwvJ30QtqJ06UYUVsKA3CIh7tmO064nISfZjonufIwbupK/f
UwAHjY6lC0AVqd1cOHuTYCdUB8vFRwmvGs+lGhVAmhQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 47324     )
YreZAQ/hSPo17MxnPBesgwI9W7T2gEBN0NEz9mzQYpuFpZiokAjz1ttYLzgu9wSC
tU8cJYeNLTEs54OHJ4k9Pn1Y0xGJ+KMClOxfFonhpsYQQhM/ZUACwyC8JZtDa+TS
bRYRAFS1Pygg6ftzvpLZHTP7grkLHVYr1yy2bl2dESnsG7TBt+umg0/xe8hKEkgL
sYW/8blgj2Tsq5ITSnEHexfhUGaOMEm8Fz26z4aqJcolvsRszVX8jqQi5DTotP+l
12slSLJUrICb1TO8CXL33KX8TTPHsP31GbSnuXAFJpCJgFk0Edk5B1Wx4yh77l1D
6+RTAcejNitUR2M0NRmfWts1OxMVBWK4YgtEMjpxOkSk9XiQbjySNKDxc3dDAlHr
l48mhGAnomkyozTCvD4gPePFX1gnAPM8Te0gybhHBdXCUPmh4Y59JtHog6j5KFgV
QyW+rY7sKHQUMcSvoQwkSo8qUu6YXnQFk9KaXlH4wX6KFifX1kUqmXiSkXN5JXD6
lyIld2oCf0SPrvvu6S8DyRvMdnkdwI0Hv2CocEUHAiM7BPwOfVHBcjvHtBA7Pb0i
+0SNlQugzof/UUMlBs187QgVmcSC4HBNgpte0BVZGhHkWuQ1XDEWBdPce1QFaY05
BuhM6ZefrG/RcjAnpOXDi0/g9MHxj5Df9s7wXiraOGz9Y7r9Ov2jhqUx2A91lHbl
zU71jjDv16ez9pTiqVn6Ep6FZC20wKfbMNnn6nUl430EDNjivwd6t7YbRKwVEWWA
TIG2OY4hCXooXRwfAxnFUFEHy0MMDONyRnimTry01haTp3IsSkMccSLXxo9UTEso
oj0f3bACaBTX9r5mm2ZCBplNOqbZFPTEeJ7yfGdTtbwCjsRnJjDa/yRhe/tH008h
HIDW145WqN4sNHlGfLahj/299PG4YdQJQVuxip7B9TClNxhx2KZyr+i70Al6XDeh
gTpXGpT0CAw/4tMT0woBxL/iHNdlM9PDz+vCueDsa57CN8eRDPV9dBlMs/atZYaJ
6krC1kNOhQY4yWNGP98TeiJ19GLAyXCekh4Xm2qYnwowZ5UEWDWNZrjZZ/WO9sXL
nkzJquKWwPU4PYvOup7Xj1Dd6gX59YEAzRwtqGWEMFbFfb7nVUBPytjO0ko0Qn/A
`pragma protect end_protected

//vcs_vip_protect

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PF8oZgwnKwqrNGpKX8jwQ2AjlgwyfSRJ2TqwpdwlK3AzgO4LAPeqkZVs8ljcAMs2
w8+e+YSwu0QkKfCfnFo2pNmLct2enrUpwMQxVBJNqCSX2GioHz8xXWtguavzAZXl
p0pOEjRxsNyl3z8eHp1nZ+z4O7iFMmcUPx5khJm7gEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 195477    )
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
G6zLWrorB5Vpfmdo/yBmVfkyWX1uubkD21+rQ4+RNnbbb+pO/KuLCwjVcAmGCA5h
Nkx9/EkGlXRQac2W8cqeF4mrXZ7XQp+RcPQnSxDAMOD9kaYsRtuCTs/Df+6FXi+1
FJB9w8HNoZCyES1jevXfCJWC71YIqXPcvutGjVKdlYEITj8o5Zn4//PxFgLOgoP7
DIk2QpSW8dNYavN0P9l771zMfeY4XbXiPRqoSNxNITv0fqZPiaQcEFPSLZbV0ytb
Y+djDszx/uiccQ6O6HNN/uk7sugrozTCcqaS183m1Vo/3h0QkHaXfo7QHZFRnhb/
FJX9iGh3CR8FM1uAKIz9vnPe0T1BKcQRw123vAi0uQjs4kAbmuGA4fc6cZ2VXO7N
UYumQNYSFpfPJOJf3NMZPSMIqwRhAlE6eduD9xOEawvPtXufDWvqXr7tClFGMWDM
S3MuHL1J8NVr0UMQhEOt5eO9TA3wwwq4fuBbh0evOA68adAH9hMTdf/L2Ej5zcA9
tC7HkrBzXNWJJCrOW+xDhM0xZ41KOWu9XHmP0pnclFpcMBHVBj33sNuQULxnpY4l
q2I9hmcFSplk8kKUYDK8SXREEiVVCOUPmEEI8005ykVMzqAmWD7106+yk5LxVKGo
nClyduFaLA8uYLfqEPNBN5Inte3OmAha6bSYpxoL7vhJm7MycyoYRQP4pyxWWGAR
su/LlhHjq3tviawUp6QC+SQvh6tLUDmqTfV8dxFD9kebs/5E55HCJIdkOIyam4hs
pWIDAdLASb8IQIK8hs+4rIDIXV/adiTJsamn3DKu9ZNB3XwZhGM46NnHKtJg02/a
OShoXi3S+EU8UPUw50DBLOQEtxi1VbTWK471V3x/RmsMUfOX26LrQutYskX8vgTc
eKLulo9qbQY8l63/aIkMoRW3sjcT2FL1XOZL1miECFNqIM+yUjgZxvM0Xguq5sqW
tL7V3f+a5s2HR2UIZWwPCH2dhieX544VZoULvQ60Cdza+L9VCLw79JOWE462U3Dz
IjV9H/0308tWfIVHOtDxJ3pq45M/y1/cEXAp6V1RWSGJt9NJt9GCUzLRK3i7oMRk
xXHYXkjKlFL/PWQdAoE95GFr0JLIW/PodRjuhquDk0ST8/k4l18xaa0Go/W+5oj0
G4xRJdA7jw5mhowSEAcaFgddquBkkmVCVHaEuDs6l78ThMA427Lwo6Uk0gfS0xQ7
11Af0sA8q0jbk9hYXs/nb0lNTOrECHVB6yxAIJ1DvRqVnTwjR1x7lXfO18+TTWv3
bpVH2zggSVvwn+ymwslBopYDXr5nvSry/fzRefgY9zR4KMs1jsfUOZLeQ+aBRBiT
7Fhqikb/JS61yXLPBwm/O2bJIplL2YeElfuDGC81RX+H/VcLDB9fE3yZ6Z5Wiv2D
b7aRnEDbb714rZAu4T917BlHs1y6+146kvAf4qYnZEvmM/kwebZfwMlPo2LLwdMF
Rh0E3/OHfqAMS27XPcsq5M0G3UW+OOTVuj6sj6myx7iKbdJCLNJiMz1uvypkumtp
sF9r/KHr+c3LheUF75ouDG+sX2s4qywfFiC+2TCRW3KeV1H2tTqfuw1VRgIzZV6n
7OW9ptKebBJ66I+NoJfv1w5w6yVp8+RrgHkML7sRx3eoH0n2GNg5ytW5Tu/dNjCe
1d2B1zym0xMOeD73B4uFbzyBR8KqLtwlBvELMGZrh/0zRjvZTznQcbzdmACw3MYU
jjZzU9s+gkr03I55q/mL14rbpW3rOdxmZqRwD4JTrFTHN8htUU+f8awjlkNjGJXL
fpqA/NvW6OGzRfYas0hDCx+Oe4Ws1x1+BbasPynmGRaxSVEdrxebGIbxZiP6EoHE
XhmItWeJ8FoQVay9ZY/dGtPvMHuFYMHgzVeLUwUESDkwaL86B2C40ttQWv7i3agu
Fu59DG6W8twVNYYRNcYWeayh7EJdbyrF/b7Hdah1mmYKv04P4EhKQcCpe9kv8MwN
ZqmkVtSxdsxymvXZj39LoXWJ6NvCBkS+eB8qYWfpniZ/hFDptWvkXxDkP3cfLlyy
qdfv1FVnWRATAHLo6gUY2D7NSvu7an3d3bxOvjTq+IMHBAX2ZXDUosRK+fybifEy
0NuRrI47R3vs+YAezkDivJsq1IeHnjYxUglEt3YspMaiOIJnu7wmJ3F0mh0Pomtc
5xEEQHotf0dtroR2gaFuRJYrwAOE4GBjnUPfB93OtCNV1hXYkgaeRyMRGp7xgvzC
pgF0JJpW4+oOIuJN0/fIoH0q7y9Buj/4OA1YIoVE8wmPnGLN6H2CCTvZDzwhkSUq
BRa3swrsGidxSK+1j/VDL09ogBHfYliMe9G7cpULDP+MtHDD11gDlZa6tc2CTQFt
LZ6Rr5Y5TDGAiql9s/TmpKh4CATFeRobrpl6u2AZ5Za1P+FuNEUyRraIRIp61yqz
yztutzFTjlxvXnYKfNhBfgDQLZcgfypucFRkgAsUdy4McGhol3yE9NUPKC5oP2Sb
QQcSNbo0+cc/97RGJWPmX6GmqWTkw6InO/2NOmv4QyFG4Fokmp9ZQX4t8Tene3ZD
yh36RQrsgHDTYQIXt/MnOW/07k+X2pAdNSiyqav4qcWvlDVj3KzNEJoSwfmGGhvf
hBvl+UQvknab6ehMsyAqvmCSqSAchTH4zj4i9ZqkD6xwZKpjJE0y7rQd6Ug71k+L
glOcIktzTBvzApdnlTiPh+butJo3R4M7uGDmqdmSNUu7aY3Q8gELImygCJcTe4RN
f52k97VP94XQZpaqadydbwVgTiUC2ppHRY0XCeT63KivtoO3GO5YBb9pCfr1Ro7h
GMjzIIT14TfZnXvfvLihyLoUeQ3kXPwIAwceD5I4vRswAGZCDh6sK4jYQ/SpOvFg
dOo9Krd5Hkt2UwKbpMvfUjI2mj2dRK9dPjBGU3YU3fYiIRqoLmV5/YG0gP5J2WQR
4D+gEjQdvGdDqd47NKRzeAKcGBA6pSSGRC9ppizKiBuhfVkHOn3bl7KEFdc76XQL
ASBlxk88H34oshjSQMyxgfReVPd1HDBLu03T9gWUrUdlXgrWzOvPhiwLzoWFnNXL
MAvp6UI79sVvceQTKtzU1Xw78P9EWnLaJ2mXdqwlPRJl4YDIKS8DBO1UomGWqKxe
kNhQABuLl95BHOcdoKXmeRhInl+YWEsDIcxHop8wGn+ZyN14cdRyWeoEVWSmO3+s
HVWn7NIj0Z177R4w/ZF2fPUip9fLYGvTso6wpjSTHW5J3UQ0PghgMQxFsFg6aFZd
BWlpi8j9jDJwpSeN5fkGEhsU/wY4NpmW54Ys+XfQrihvynZq/CrKgY287yiizET8
W92fkKl6uLQcx5hwVn5/fTH4dUc8y4Q1z5Pw3MTAz6+aiHJeMY22DJdxelx70Zqn
QqTnyC7Vdk5XgzS+8KGzYrG5P80fe0XKULWhhCn9Dl0SBBfFP/CH7iBSY+QdRnhW
7HJWyFy5az4uuTcmuYDyr/tKaqh17tfuxECmydqlKlOIUWIusV1rtIZtKr6OF6NR
gRjvPeJidVMdLJ//pPHdrkEsCQcBpA2FJIw9x+dMj9Oh5H/CX+lRQanZhE1NuPUU
v1nIrhGMr7TlIvbcBBA07sZ7Efhr3FOU+T067p6c1q0ySuEyDljFSSawjT0243s6
5WtUBtmVzRcanNeQqtIeg7964uqnvT2vAG4VtOREVRELo2jFxtye09jH16JTp/QG
c6nDvHe0JAqAuoTxmmy0PaW6sB4MarcogRbP7odflITWJlxGjQYEEnEvuk4J9S5G
I3W7o+sjJxKSceU8yY2lBph6R/9TnVVaEPGe1ANIMc40dfYqutPWldCyDkPQ4LUT
WGTtgm6sK2GvITqc/l45tPGPXB0IWcqzv3GByZ9uiWDJHCi8upc0czIHhUh5o1gN
49Un1fEWBjlKKg09PPLFVXd8WPJVhiW8p1RH3reUrV6OqOYxy/ynxWNeDnbdO3Hy
byLX1+hJ8N0bsFbdkgwwUPwaqKx45HPWv1sNxUIHNyVF2IDPCZYrlcETXbR3OuPh
lweBChJEqeJoGkIfGv+B5dv3V/QdcPJP1snsFzpLIdc7K2nDqsHVOwseiWQmH5W3
vnWI4z9EARQ1Ly+qAHJruk83tYasvXSmi+DTiFgUS9ixcP1T8AM7rtn7hJtuywiK
ir1I0jUoSlbiL9ox69k0HelLYZZTYhtv7cazncTjuU4SH1CXeL6NqS79PznoG06B
M7EZ4OJvTNjk1E6yVANTtDLlcO62mJQWPMkOayKj6q2pW7HNK4ohE3aKB/2SsD9T
D8mI0qssFnU8uQge+78gx1vNPKcV23RRsOEF4WicXc06U5jkhMzgdHtUYcTFyj+W
NZRHXZMumembxRclCyPo1o52eHpbQK7/vJzPtO/V8SM8zDwVk6Pinz61ZmPfayD2
Ss+qypQPKGmJVTPQQUTCVt8p7JLtsbduKjPWIUF+jLPZuiJOGAyhyBN8eZH+LiH8
Tg15dhTw4T3OPnNpOivW3iwSVOBw+UXmeIs4gkRdqye/xxtqKVTJDIBMj3ysmfYp
+lN1dB+FiXDNJSFSl+5P1ULpqcLc+3euE1ERSxDvsv2YAZpiL9dhl/3XF9ofmLMb
CHBkzqwjXaz9e+SgG1HPgGVxK6lyaMIsVrNFia+jYr96cZRPwhqSBXgo2dhRHbZV
rgqqFwUQ9Gi2bcbUhqyWxAkLdsXO08uCSybUNHKHVOWLuyCsfsMuG2j0DPVLGwEn
js+z6YXtwRIGvmeMFLDQkqBKQQo+wcOmxhGNvVBmHW80tQM9Is0yukSPVT9KsUz1
VcD0wKh2pVllue0sKa2IRsnPlqfDUYcrI3pzDzjTZESJrBWkdcVRHTjDVhKw7OA2
Tq5VcMCWB2PZcchPTS8BjWNdiYasozRkD1B2JSkeqqRaP8j4TO6dNgz+5J03/dh+
Qcg04y1riwbBXQTIcVjt+4/e59Vuhb27H2UpJBXcFMUhp1bVrchrEtdAyCq/qyK+
mM3sYv1hteeBzKWkPQqowrenNeUbGMxsgmtXDyKv7EOLwcnYjEruKf21O7VT6gLf
utiIelGpJOus4gD+nLkdQFCPaKqJJrfW+fZs9ScGjvF65JtHgxp46IwSIDa0uy1p
PXtn5xT5Jvs2ZECMTXY5jMa8k2paZ5/240+fw2qOmbeTWEFRk5hdXoPNFm6hhx6n
fVlnm+ZCtK/2izl8F0Ndwe3iEwNXgfRh3WBkPoJu6UEaSr5/Cit7HuSLcDh4gGst
pPLdFiFGqKIA+kVglRE1Qu+ibkqD/pF5iJeiB5hB9FdwpXr245V9o05WW3Yx0otf
EPyAXlKarwu4BDzK9M67ahwlJLVN1vIzAZ0MDMd2pCs2X/i36CvKWcwqx0XwiD7O
DCwlknTQjK2pifGNH75jD73KLb2H81ZFR4tgqPe+7GRpAVflvVFPWhvq73WXy4aO
0Rqkp/nVHzIPcbwdSmHzSBXlcqyX0yixEigh1JUHZTvp4PMEoOExtLGi07ZJhF0J
hgEnitm/f4S325S3cDgZdnO3Ci1AWDz6A/kTZKIDtI+7ZY5XBlc6NS5un1J8GnFh
/CgpCgivUAcXw9qy8dFTKK+LmhW9c1ZKZl7ydE8JTLP5XYTCDXwJNsEv7EcXWzr6
n5JEV8UEl7R7qwxSrPyTFvVLa2NcTtApEp4Df806thZU3adFWT4GNj/Bzhbm40Aq
jOjnCquxNI5RmVNEmiSfrsjFXm0hNXNGdXLUbzzlw5bLS6fUF74ml8K4b0+E6GXQ
JRguzptr109OPEoGS4RkVPjys8+t8z0iqODUT8ZAjnUesTkHLQ9g2XUki6UPEM54
s/sqbE8BUcmEbA918euf6vQ43XI5lIgacElRrcvrE7wewZP0CKa6LeIrXVqEh7DU
RfUjeJRwzolzWbk+Z4kmelNVRVQQUvdnwmWySc9jmCbHYutN97i8d6AK39G3cqEk
lnknZwAEm5EQ3p4QBYJdDQRrme3BLUNohu5RkIF2C5WLofLwqsuIkflOpziTDhZm
DX/f/JqSH6NiodpjitMwUdcnWdAhcpEPfIfgOZ3x38KkB52mh1MHxUdEtMRTn/tW
KFYqFFmCSWibcG3YPx/tCMr1bYd9B/jP5hiTKJKuhncZSwv9zgQKJZCb3Clw1qH7
R2F6flOMJM1o8NNJ1pM8a4V5nSR8fOI7v7S+JkPlEA2jAag8dIhPjDUwhu1cmz7X
uzeB26nnbV/h/apIp1p5TOInDv8vcYga3NM43ciBc257WdPtIkUKU0z0nUXrJUvJ
H4OPYdOzhAu80xWX9exYG0QBe+/xbq+rY5biQu7jcqCI2xFKUpTZoolXDr1rvLty
2BvvdBTML+w88frDbaSmd1492mB+K+LCZGPDMRVvy3IZzpbmeCzM8VYC0B+OWDJN
/cgM5CZ/aMSbjm5bDyTwIayPijG+JB+HhGRJ5x54qwmdWJDWCkkPd82leSNoQ6gS
zQMvRuuZNsrXU0c8ptPXtl7pcFsnTDU9lYvnugg0Q8hSoIwFCUvaTo+AqF3Zs411
O6v7F44xikOvL4HfBYqUzazbEMRnGOuixKTm+OvjfXOUlHrANIaww1fg0Z7D2bhV
9dmxE93Z76BS15SIAtEm7NsU8UN0lx9iRqHttMIRDvNcrgQQrEL3XiP+HTilC761
df6h2rEhphtYX4+Vw3foMfImnp2mQhR9O1T5zckmr0UhPKjmNXk7f8Zvk/KP7U1k
OoRdzH38/YAUyqQPlt57mjKbaOwnaEk2Z5FluRwYkwQ7RewTbA3o6jyWQR4HFTXd
rtykU8mxX4xLBpBX2UQ8NMFUlEdyo/C6htFQe9ThlPayjBTDBCasYP2tyJr61Jr5
+41sqK1oIJMgRjTQDmSOSbf97vKJDgndCEgA5zIYr2ioz4Y3WxW/Vq/K9JQbOmBT
rJyd3X98Zn8lJ26BOo4wFnqRUF6+IJi9VGwfILvzpbDTZ/mGzuZbOdejpIJhuI0Y
Pdob9sk02hUvptBIM+DYRlHQDU3zGSxEB26kBMpxwXWhi3RizMP41YKB+Yqoe+4Y
fP2bmwGy0jesZ+o7kMYZT/fBPv1kepCc+Ta3D2eYfMOXM3bhpR1EnQLHoOW5P7tD
YOAozA8IfvHu4Nys/Zh8lQGXlfXF9YUQwiBmFNkhjhHzB8/h0Akp2Ntv1+f/YW9E
WclMEbnIyv0GnPTYql2b1xobkf+n86V0TRKrgn4813wLuiHiRAA8zUJBllmFZosb
rMYogNvOUvBnTN6hHEcZ4scv8Y01i99wiErBriGxrb761drO12bOnKhrVk29MBSb
v4hzRP2deDqWAbrIAfRR97dD63bfD4tHn4kfDNV5vLOUXXcdupvk47SZglmQLFLV
R1DDxPchqemMiDVgEGFsyMtmPAS/Lg5UJSgYwz9HF7tqK3dcL/+VAjyp0+ZK9JRm
kl+nuTkUhtLykQy+sy+Av9L0WIsOSpCjpqS/gtT8QKx9CbJG/FpF26MANQ3Tgg2W
AWdLE4Qt8ADkk3HBRytfntEdBz52v1lrAddcDoob33ckYI6Gk6ecc8D894AUhzRQ
yTKggGXWpsRoUNnB32Iuigr9xj844mdjC894WtwoTPKGseOUiGLXLlLYwn7MdpON
K01/pMaRpDM6M45Cnec0Ml3/caUmeNqt4tjAAu3JfwHdKBMPthJQntZ4CByvQIVw
ga7DTLgBc24UI4ZXPU1QxXPtQTGltofekK8aaQLrz7SK65u2BwxRqola7mz8o7Nn
OJIK1YSlGrMNCP0Up0UJ1WKWmJtIGPvHp2Agu5tXiM0mZU9c6Zte1ppBjr9iR9Dm
l66kKAuk/DuT5fBvncrVa61k0tIJB2v2J40yfLWXAN5HvWa+ggG9ymxNZ31hCAmT
XIs7Fe0BFQTei19DHWWlZY+xTJukCbIPp/r+8h7ArwoxioP6ShkWKGWL1Z2vkk1X
tbTduI4VMAQqlh9OEZ0/WM5lI0k6X1iqkeee3X1UMcVj9pHC6UvhTFsARpuOR1yp
Gdk06PkFGwFB/ZP4nSgeMHVRPSQY8hNFFkpObm45mISMsnrKq6/P3Xy4XeSpnEz8
yL9vHiVMYDbMoKb7LQiELdTYDA21PLBNG6Ls7fFS28G65gaTWBWcYnxAwl6YITUk
6pLaHOeti4EQgYV0KIF0KxGdJNu3wznlqq0AqfwA2iBwPNeE9Wpimrc7iMiBc0Ta
XieO0C82WC5bM6Q0iXCnAep+6JihL52SU2Qestu5tJaAm2Aq2rLsYLzBP82iOkVL
0P+pNHMw/xa6Umh1TLxLp9187HtCjCQCH1uORnzWwkFFRN1Xrn6MG/Za9PuyxLtd
hocxBtLvBANuAWB6VQJ8RxhtxgLxQSCggOpTowz5n0XhOr01ZCk6aPj7CLCPtotr
sVnzRknlC2e+VW1PdN06t0v+Vk6O7VEuidVtxanIuJWWMPrDoOblLdljfGMPoi91
OWG/GXfP07/V2/+V3e7k0W2AKO72tLo2BN7yiW7h161Ymr/meq5/EQOkm67HF0L2
Rhj4Esk/8hbTz2fiirfizIjJ5H/6agQ5bvNJDKMzWeOr7VkTVegbzA1MoY/R+vX0
L8c4sccMWotQ4VLoXk+XsGT+YEgSroula58GdoFVXVxaOkJy6+d5TInzlD3BmLT2
Si/95ppyE4UDy4Eus8gPlQWKBG/M+rV9dtvZwhwAGOmbTwFo0QEYgJNXnd3L+1Gm
bkf+ZruuimRI8YQ9Z4W2JnRU609GR2I3xuYdBcTXdb6m1rD5paR0ICbwGbubyA4h
C2OkXe8KpU0w45CUkkzSEH9BCUCzy/kiBH0Rf3pGkmSLpJoVr7nT9DVHMOPpZxLB
WzTZGyl5k0A27F0qQYDjuEawU3MrJIfQ5YBJNmZ843LPd8pXlGBEfnhjxCztwOvg
EjpZ77uJAhfepwXSe9qd49ydkP5meerQSJkgK9tzP85KD2hWO9sYYQCrLFAvEgcI
41OO2kz/yzdau7TvrmeA7rw9lrFCMKmM9YRowRo4CykY08Ysu/thxEHOg1brbu43
/Nj8diHU33/UVCK7j8faEvR6Xvktvt7cp0bLgRAb3iv/MV/MEN73Dldwcg5K+p5O
Xn2SFlPo9/nBxLLlWyHJyyujLl80BEUZ6aL7S8Qqaq3CmxH0rSwDsbLq8/p6uE9Q
JIGwPcFKl5WsOdpf+My8SBPQwaVCQlt6maqV7h908nQfIfoKAmgSMqnL/iQt4MYg
4kY0YVZ5+x1iOzcfIYowLYc3pyoKhvKtERO2EvXT14LI71jJXseDE4AwIwyoszje
e1olATnurfP9w923I+1a9fTaq9Qqs+wH1jZL7UUmXIKDf7JcJPxNKd9Nl/aDvS4k
Wf5fJUofB53RmX3hidkadSU/NrApKBwXHYSeKJ9zh9W2t+9gulPQk70tymO9cN8w
9vknz6lW1hdIYrVfMLRHqfhwlP20AMALTN7Wgj6TYkhwgW41MCVgRfMm/n/Symge
cOrM0ryzSGTyXE5w05N+Yor6nmlS8VIAvjwQwy6IoPwt+rjPaxNyxrXdElZT4vdz
1WWjowfg4YajSRTCWS4o3NmN5BIXGDeMKxf5/WvPik1yVzuKrWq/ezisXJb/9KU3
Lv4B6a0f8Kd3kAmrWteALYdpQLBWfRqa9Ia096rhoFotL5Vzh6bdgdP2TzpfwPLq
ygQE9yjwEP1tItDsf7UOaxQuQB2jt23qiIb035HU/7M9itLN97AN3evwgK3P9fUE
ZXZ53LR6+P/EdZmlMmKChjye0Gs4qEXV/phJc9reD56MobIhA79tUSapwxgRAkHk
K9l7wls6xqeQRBLCXnoY7PCiH9h4MLzjqmmSWwyRj4vW9wO2KpHVfySWD2HWIaLY
0S/jwKL/4akz+pEj/aM+TJvxjgxCrQ6vpp1C0Fr9kizYCN7Iio0acC0BuEZPbyDP
7VG0NLmhxdgTTZx6bfe3YYP0DpGPS8exH/9bc9ndWBJsYoj0TBB+PXbqkRZ5nKNa
rvmm63r20rksbqGnCm6oUpy7gPjwUKD0nzLg5mPYnzIdUgKoZ241nTenQeH60vJ3
m1FGF/q5NcUf0krNhGNYy5R6eUqZUN68xhwGzNWEup3M4wQmhQxM0zOiwmjhcsfl
47OS58q7kSENBoq7sF/CbpsUeBoxaQwatynhWh1Y54ZAgdaR7rNHjOVk71DAEtRY
+OBKvbkDWpxP7jyr3umuGAZqzvJV1H4YfKff+qs3BigjnxdRfb5HhKiJaVfIZT2p
974M5hdwxduV0MPSoRA1Y/NxjH3AK5KFfHJVev5qjJqG1CmuBwoU+/j/1bccb8HS
/CF39fZI4wlkEEDMfDWcdR8/WjoAeoLKrYptohKMB10eMc5Lsch4iTePDTbVSRkq
wTKhjezbVPAyfTU73njC3DpwXigiHJKsfMN6n5E+1cW7AgnDpXVoUf4j0ci2me/f
/4RV9/bqbO1FJUCw2LX66+5iNZnw9HeR3/8PcKb06R9PX75uzSgAgQuDI/tKkwiA
lx7h19jj/oZ2j9eoqRJ1LMPgG58bGUz5eJqVamrjKvvhwJJoFmg8JtcyJr95VKHN
wffBhOZkaUQVQ6YyTeDZXXW/1nzyDHw6i2JKls5uwNKsxZqXfajpe2/TMo6gr8us
6pn5uPeF4YqalH+OjXzZeEzuxUE0RRPNSWXz/6vL21uI1kK5U5C/x55ilKiCVXBN
7XpGfssl75lnFm1Gb1DiXtimOYPpcCXZr99PVylLun8V2TvrsLKfIA4hEA8t0FOk
UCua6nPQ2JfhUsZC5T82PGmApbSGw8Vrm9zafzjMnG6qPYCKQSxLhVYyDAQsCRI5
3FJ4marfBz2mtFyGfNRNrxFJ3wKLSczXrlN6AruSFT1ZetZo7BOvdh6y845SUmNt
2lggGVyvVKAWSJJiGlZiNAcl6Y9i4nABngtEs3GfrFokk/EH/cpsN5pTXTghcA7V
dUuEwAMcf9vNxLsIG22v/bRJhGj4jybERN9c6G6Q+05R1iSz7Dgj2hj5bkHq751y
6HlYRGHMZXt1Gm68pFef5JNGIpBKuPE1rcGtRQkSEFODNejcG1XqKnfhjgSVTwcb
fE4+HusvtmPrQGa8xWUyaG4abW4SGz1rejrJi0ozrZYzdfsALwDTe2RtXqYD47V1
kAAUITbkSaOe/Guq+5Qb7C1xolEIXygmH8F6PL73i9gnyQd58qvN83HhrsmYw2SJ
utqDA3l++AXtFs5nzBzef279jenAq/ExRmx3QCekMr9oy+G9v5mMQDmtJl4C2rlR
Of8RvYPWXj2j6oSVOawQzRk8ldQ27SewTY2tgcUhSWnDIdAudJ3VpVhwXqNNUgXz
SGLdRTju2vQDFC+JvOhmajF3/58yVSeLA17vg0/AKTiNgaB3PAQZcjPwiroFJ9eD
5cSz7m0E4IJXSRNoNEiC04nrvBk+AHeRj2bwpn7b37L3mEwyBIpNZie7BAdEVtzF
/AU3O9X4P31zKCbHRRcntbyn9hpodcbtUK9aSebN611YkqW7W5sTBw7DRFmVvOD/
bPD+na7oEc0nF8dH1KyYN1C1JTtNosZ6BCiBUUWAh1DJ01yBnWpShGJIeQg5A2iN
+de2sYdx6kcNb17OnTlXHrk2BuRn2o6/DL7HWL8qc1Lt2b4oal4OsoH87ePjbsDl
9mKv8lU75lJuESFtS/rxA26JK7EKmzsYck+SLd2oODGMFTX+jmCmueQPNO1/qK5o
tUWLXg26tEFgogrYrAeV2rBBbFLpHkRC8u0orUOdXGhhmX2K6Mc4arnge233hzYl
LHCwu4Q/vlRqfceWCLlQS4pkCzNyVgTWXnpoafZJhARDU3mFms0qpMi/UijRz0M/
9HxxiqoU+Vntv65ggrHZQv6JuHbXeNf3zX622NMEX/J76J612199AIRC4smbivrQ
TzOi4zooeqpcsnLNxPp7G1rXMM7uxTOA2NYjMc/dOFP2JBLRBLTlJVzZF7O7a7NY
FKGOhhzeBUTc428NIptzQFzJPhqF58ihZ50+095Rbu39i2OnD6QhZ5ij+Q8/ayqM
GtMJiTFZwYreGnrwIdKWZkLuCrHJJjSOdis7Umz0Erc3F8Jpc7/gIyBs/AdQ/iJ9
ECP3zJI8Tc5YleP/YfjKkI6tu5CFqNVzBLOMzjOl45PoeGEzDH73RGZAEp6tIwHr
F900SkA29/vr5RT/D6LmclnIuexXrLDmC+FS4hIubwo1FdoS83SyHy3ijVCo8Bjh
f+pBhS/4xxoxX3cJGcrf1svDS94/KAn/l8AZJV0SdhzgZJvAcCzc8Ufo/Oi5dn0y
GithAQtb9Cy6DWCcQBc978EdnfKdAT11Ps3R+ljTVUVO5JQtjXEAPZLUD3Hx54Gu
CSycxv7X/Zpde5/eWp8oTMgmkJrF/1FCwJoLCkOCO0Hljz943huVN5vTYgeeCkoJ
j2LZ904Xk8SkKD5Ull/JrEiJvUCulyQmayCBY0SjHj2702pgra675O6qrBRdABGF
SRjyI8REnmJTfeJ4PBwNX8VmCfqHPmQDZI5VCYs64sluaV7k/Fc7cuVxE8UguDP2
XeAwU/CqgOYdvWz0f04qew33+ZovaBHTMuEEm7RPH1eQw8BEgag7FiTqexrWrOP5
UzkUeUdtmZPu3xhXpti0uUry+MqvB6nINQNF8CuoFJkrYF57K1QmwDk+uA+Bh+w9
X7totgy2HG6OKr8QPXshKwOE8dX4bathdSTEfxqeebo4H/MNbfDZ3iNMtCQO39H3
nt03Xy1gjzERrC6lEqmZyXAepbMu0IaVNaAcv81kZ4mRsGDO8uK67vwk/Szts7KK
rd9mj4ePmffTZd2vRjajusEZ6/nxe/WrlcOkqHbKVVPFE1WhLOOsWWyONm5/1UlI
pKy0ZujkzMS4K2JFwxOx1c68eC0y0YVdEzqLVqE1UGKBwPXv/csrk39Y3D7dH4C3
Z3j24UfC6NiOb55kTpivBYdYaG2EHZi19+t8cvU9c8PAj6vJ9jT/2BBKBi9tbGjy
rs13PIz0Ghft8IIWh2lKYnN7fALDuSlRcZJOYL37LvNBFc5OdxpiINyfA/wdyCND
Kc0swMN7C60hGBbnwXnvzqSvbxmKk/zqkhfR05OW17WozpzI20CtnwqrbeNKKxkD
0Nh7thMOFGCWW3Gf2vy+n/ospBviKyQ0dvz1Q1zzwAJ4g/8xMU6+g0Ip6yk14OI9
rVFvNNMEMf5yvbK8kaqycIuAhmxyEddk3xOOSXcQeuh0xZ1zMmg7w+Ak8a5QJbws
uOn9u8m4VTya4WYHwxjh0V1L2/VgYaioCPIgZ9giQ3eD+ByRFSSad8JAVyrtDOxP
kTU8SomobyxAeFO3r297APBBtAh+a2xSH1oZl4YsyVRCjtcMI8+8tizzm6T5vmtY
CHqN3QC9HhPWFQOwtD6G8gv3AxfgXTTRSUE7ihFxkhK4/oveX670FxAjR1xOyN3j
lmUtalkYt2eHZDT+D85FGKCBbvkR9HtxgltprDMTpmooTrM+hJYKV2CL8MrEMjni
2IyveC6umAn4xRWCVDMeEaz2rkctwISzX7RcZSB3kQ1EaU8RCnvqeR6sn8SNNbGJ
AyWywvLdqX3Md20ndiwgnx0JpTip9TU/yfUEGi/LWTqBEoGtib2ceEtgo5MO5B8B
DlUO6GiiuIIE4ZHjTs+NMKIayG3Tr6g3vzZyePiXM1Nx0YJFVK1svBC/a+Qn9QoO
RAWean6+ixROguw/IyNkULgFPZ20L+3qw0KaE2Pu9sc7NT3tZe9mdVapCDpip/fW
B7XSzYNxPWAOGiDw6saT9oBVSE4VwfaGSEqrXN7mhvquqIlVGSwdzjLX3WRdKYpV
8mPKZcO4GqlZmPG33BjRUPDmDr74dJzuAUCFfF6VPxRWB3U6fj9WKKxGdgxoE6F8
P85Y+VZgbFt0out1t6JZizYSZWI3aoV+IkizLRzz8fmY2MtS0o4UTsXqUa9scKSK
UNSEcCjH5IzjJV4iX0vcxuDOfufD0KNsnAGlbAFULTxNhaXWFbl+6PTcasiAHOwR
jubavd0UMvoDOVlzCL4ZgFXTWpu8HXF+9PAKGAT75iXOCRva9VarYX8z4PbrT34Z
FvsO2itUhe+KtyRY0tALoypCAYAuI2tLfSt1O0/W3nQtIKCk8M7IersXDU5REwwL
IwUGXt0I8pEnCOLfhGvCKkvsy/FZBBQsGwFg3XjLi85Hp533l52iQMLiAigVJveY
fwO2BZion/32rRuNs/jrKTpZLfjupidoRrdm5vKzqnl9ABIHhBpmrZplHxt6sKFb
bnEhYtL0Qh5SGxU1w8PyGpAztR3aWGRFN78KhTBjWnJy1AeljP/eAGqli3tEs3ZU
gN9zVKOkHRmCT1VlE/35JPeXM7z60PiS0sTAvs6vNuuWD8NHJ3lfTS0XjPNBmYJg
9yjmgEnOSiAsj0QG3xJvLZdgt+oAIktdymT1hLJ5FS0Qd3Os++Gi/NXNznq6aN2e
AzdU+3ccVs11oYpHcXhj/7Y7Uj3lexeWs2kMV4VSao2B0kziHDy1AnPScz5/GSv4
Gf9PRA0PhB8C8xcK9Ub2vBTRpr6VowWMksvBn/bD4WHydSZ/YEXRjfb5tKZ8lToq
vUGoq3qhM0Nmk0HrsCFIpmciSgr0oe8aVo+tg6Dd/t/mLLJmSLH1aIbfIEuK1ajU
raiKMyKcvOyG6nLGD9Zxpq3wkXaGXXu1YzB0HjhB2NXWB9SNNHUS6r/oSSxDHF/X
YvnHTD1PFfooggGc0uOl6uLZlbi2g76mZ7ueDnyl0oQesboh7GLvEVjgGjqrLrm6
3Qma/GjxYAmvnjKMEcufdUo1aTzp4bQ+tsIGsD+/Ys/ZBOCu6acGRE+kfvhNFDux
MJKPfYkH0ERmleDk9FJHhPBoCVdl9UNN7k9S+tvyQr+3OW/XST9mdO7z8Qxmaus0
Piz2vMZJDcDKRDk8rZDQS+SRJlHpivole6SdmzCed2Eo079pxLOvVX+Q8xYEcEof
e95QbGbS3ESCL01eLdPqC731RGZ6B7u6t22GBHhWTliXeXrMU+vFlPl7SJAOuKYj
LlQ9VOe89ZL81KQ7/Rxf0bpij1Uz4BxqTUq4qTH27YsKuDsytsKAB6L7SGZanyPZ
wi9A0hpbyD14hWOpLRhUM3HN6zaYE7uyaIls3GgHJ52emjGJZRirO52YDSdJS+F/
L8oXPzZsvos9fzcPoBg4CbxxUPutkQP1mUJBUYebzLxxzbzC2SHayuUk0Zxz6X9I
z8iW5eX6uCBPocO66Er82mqcftVYHdGJMESO3WuK1ZULGOjSqs4SgC7C+WDm/5A3
HHR9ahoa7BgS74CkM0pAY+ddECxbWR53KSe87Ne5tZ3m1oxKl4SQjpDamGXxwvn6
csn42Qun7U707BKyVfP1UICZJoeU0P0qflZ1tDIy8r8cY7CjtJr+OPUlMQ7XzH0n
zbeN5jJdFopRNL7QBZyZ8s5DtYVpiaJ+kgtvsa82IP+KuZTaqEx89YkKFFvQIpIG
fiOHXZ0fpxhUy1eQDsedk187xStK/6IA6k8h9LPvFsWvGPDTUj98UVo3+5pAA6bQ
NEp5JwtT8+GGrl7Zq24JeLq6TSU36FH71dw2Kh2aHm8n95IYjnK3D1JpeCYB3Vnr
mYwHp/DyJm09UNYh1wDxxD0rlQ5pBnQuRHCH20RGFDbIF6FQ13nwAMEm/829MBmC
Etgb9W3WEaxc/IU5eko/kwKpla/fQpgvmNTPmNxfscR7P0ZWVHgaS3iHj52rCSZp
kx2qEOhx89nTYX3oqXn4lIlSfugKj7eCRqPmjJsl8uJi6uZ+EqoeWUJ/uFsAba0R
gcKW57ZXw9oCUu7jWY/0Yw9ElH7F0pEOVzuj3QWAxuVkV0q5wWhnd5YWfrngZ+2r
1wXr/69E5ZZdIAeIcmWOyIP1uIxbvmWDkIylboD8G1GknmboCXpqJ3U8UYRmJ/tD
v5jX3kdYKKRMZmi9mYMciBqOWC4RKjmWJVGZHMsXq/pthf91MHbGbgnWAJnWl9hY
TudoCrvo5MV6LfirgUzFI94n4qijkoMtHEzAB6Qb4FYZ+l/E17IYy2RElYM5TzKL
VbDmXMREo0taSfgmejSLIxZUegxm9a7lgk+CXuIofyxAoDnvYbRkFPPjUx6OMud4
Ulyul2TDGJs3Bg/tlO6PvUsnPw+auqpMoxxKkMo2k0ffnXp/cFIolomk07VLlkcD
WNoT9eL27KWh2C+/QmEwSJphc+jz2k06dOwnnmNsk8IsFixJI4hrU9xfdmB7xLpI
HOZ2BnKxokjB/yij85ZTxtoI/2kD4ZI8YnUXaIHkMhd6RrwlmNO3D1OsO6fwxj0x
yzg5F7EV4Oirq+11mnmgrgVzbIbDqo9RxsYYy9Ki3+kUYdttoI0ef+rFlKw5OAe5
TVZYPTMUpsIxUS9heo57tqvi3nFLHWMmJqdxiS6n4Cplzv+27wQL+XFnVbffu/Xm
Wn9GpgsX9935JwB/fb48x3/UCAAZk12Ec7b0Z0K5TVIJZSHzHu6rs+DIrZDZiXzV
kisKRE/30ZnpMf80tCzAsYsV2uv2THI/hFCzLF752J3vOkEe98UTUo1Aow2poz27
wn2LUgZu2wKHOuUQFd4N5mOWapLxpU0EwtK9U1fka7jjCRYZh5OSloQXQ+ch9Igm
dLg9LnaTMCEx6NuQWC28JRGGzeffXufmMY+buMMoc6jqr1NlXvOSULVmr4m+Ca3/
uIlcLArap9Y9zmIEGkF9dptft+qWQ7b1WVb6nP9PfZmVLiIk+FoMOAHArjR0joJa
MuQO8RqvWdII7YekeVF3xomRpxq62tIzefqw8BIBWLeBK1k19cs1NhgXPXxTyp+E
aCBEJU/cg0euThYX0enGEBR1rsm4y9zPEwYSGkx0IrrKlp6m8ajlbLskUwRAaKkT
9I3Q3QgNWSYnGBaovdcXpK/3gWn5q5yKdNElJsixCCbZRo5BHLiKA4MJXi5WkN54
GhSoFUksGrq1v+CCus68B+EINkrhnq+ty6uh2CVcc/pRYJEmaRQh/JD2socelQYJ
JpFmXTM76jh4VeyEciZDNT+e4eCmrQNY8xsGkwdx8+ea163so18I/QJZ2Rn3oURR
hwfbh6SInzCLZ9G90jE/1ElkZaGku2L76xRp5lbJ99MHyiSro1Q1SgCSb0WOkof6
CJW9zZgb/t3NQ35pATLvIvTGpcyiUv5P7upetjEsNznV/QPfPfrTlTYcvodUwJia
gYGkGnoWwWs2+HjaqaHelRPF5hwyMfoFm54CVz96V3Q5H3kKHkpvKN+bKCnijRCt
CQzzHfNY9woc6VNHssDaY6ybzGcuBSfb6+6bKYc+7O9zsQNrzGBjxJfdGK0Ex745
WFJ3wDBqXcNYh/v2MbiG7iru6Uvbf8d/RtjG/ixdb3DzOYgBsHPdrakpoWJ0ND9G
MrOO8iW8hAATpzNvgnOUVUbnkyjuxZqR5G3uwhZSl31uM5mwfx0Y+Au7uEtZRjvC
1r4A0qB8LVIeBi7IJA9Ouxv3ppLNO1kmnZXiNWqpWpvbEApzgm31ddDFPuFw8CjC
LQgqY86teYpvYjxQfArO9tIljC/sJI1604Y1gjgmWJh9Tbxd+MIYaMy+aEalf0ES
vsIRUcLkAek0Nv06RSAny2g4mUKMmeg/bt/u7NBxNFBPhbtcQvTt4op5nmoUaGtV
puPHpbWqLZVJ8eECWLaE6mfw2JF99PDsxVGKuQRQbDocNRSdBbERrNb3qq6kEpba
59YspNjl5Ig9Ggx7Lv2mpAFVSizGtCsqLRlqfNSKcHR/0gNRTbap5nCmaa4FAwN5
7drN7oAty6CFsfLp/8RDTaE1x7u1fVvuDZYvaaUAjL2EW5wygNym6vjggO1LMjkN
szPtY9VaFNoCK3WQXedL04vydc3LSDxRt5NOtoTvnf5kpI4FytZPUhhpTp7SNtg0
WmAnE8ZM50Kv8/1rEyLIXa09FnqSZnWPvs0RXF6Jxn5/k9qTWr5u9TvGtJwp8YUS
oTPvpzHnriFDqjpcyVAagrL7mJGsfwOmOMwDRa96lGqSweec8nbUJjlCcXe/cv4J
KvpZBB818BxKeRpm+QnfseNoA+iScH6drQES23gLb2jOw/To3Ybac81BJAVukDA2
0kBNcu+/0UGxrlYBGUa+9ILpJAg5qsTzrjC0N9hPLYzMS+IbKdaJt1C3Wxm0OUgV
qUTQBB2Q1tj2lA9wod0c85XO9Ibw69NdTOLdeGfXI1+1oXfqEQxPi7GX9H8jYyK6
1qK40idZGHigqFVspOuuXxUNLaOjH07T+RotD/MwZlyfIo3K2Qmm6mzBrPJMthqi
Kx2UvoBakiguh5+aE8Eo56vXu6XkXER2lCquJ6eOX4KdS+drYCJFc9jtjzxSZSiI
xNN121Hquvr6RUcuKJOwiZ0C8LjMh72p+wKKWOmC8J9tlBkyptpoz26U8Kxd4Cf5
6Eu7WjtvjoJPVjVmUr91TAaldSUMAuo0RSCuFMh6AVuXIMlX9kA/E1NdNfy3spLx
27KHuHwKpMXa7Y3PeuVzq/AN6DnZi/EHcgUX1qyw9Fif4HhiTvkw1lhudvIEc397
ix/+59JUlJAWipk6mpi9l25DJFYiw2nYkOcUKTNtM71aoNQ46xcpLPDXF7/cbou0
hEioJ1r6fOQERNhkXZ5XCdc9hnXVQHerLB6ZfMEqhpJTBv1X7I7OxOuODb3GTUHJ
mV/o03tHFuUiFFeXGTw1iSWY5ZQm3uPsWJlOV6jIgXJXZNLw0+9deckndN9Y3169
2lxbMffLQA/ygri2fEX4rPPrzmgF0ALInrWsgavnkudEQu3XwZg/7LYWw9DMg38j
4INTTOiaYr/h5++mjxg0kuhJ9TQ93ryDLz+4OZJ68HDLoX9lQTsWg1vjqS0HsRE9
GHwzi235ny1V8oppNwmJ04E8gPq7zKqvxYPtdrdr1oMLZ4URd7RIxoYOWKwgb9J8
gxZnx7yrBmLv2OapOnka4hVIGxanIzfmrb4Zo7O3D4ICHqLgsGFJRZm1JlUeLQh0
gmPVZDSu7LlfiEbVvUYW1fGgB50KC1o9k5n0z/ZHkUcAyf/LtcJdUDKuHlQUvllV
G2r+Jp2nSFOuEQD0bQFvWJugpmYtKSS5xJkBTstcZOuEHkqTaCjDRYDsha5ZzDU0
mjdSdgwRMpGbo8PrQjLDJ55LHwQgrLaiR/8x+0wxuI3uJ0iiJQm6EJEc7eclkiaJ
xQS7WXpoxCnY65+HiOfE+p2qb8/8o90ZPEXrBhimQrvJx6xWNpZMoXxiq/HbtRP4
tO1dafy0y62Z0eYjkL3luIvZtZ5OWqmpJ9hczegh3d7WTA9a/fotZCp1KpSBs6pr
TwQ4AArLBX6wJxBRZUTxAYJdih60PHzj9M0vPjVSpfxu5Z4++YWYKDmOe4unDJRY
SGzTa+kiHf0zEq7tcjY3hkDc/EzroRLy440ssC67rC9z1iTecMVxM4Eto09hjpnH
DSTHzw+Io0N5Sl3hF2mp7MN3X6XA/uuFE3CPfIzt1OPdAcUJogPcOTIAgRmzXty+
GDoBUvwVZpYIClqel3YMH+E5CAH92V8RH7F5MrvJSCUzvT/SokSDyJPoyl/CAEHJ
I9oERQ98hcgmzzh2Jga4c+4n7Wdj7Tgy4buz2C4Lb+eBPK9hR3rXghsNLQzmweI0
ilj/hRrLqxisp3ViWQk9WALJ0NQyj5GwtisBze/LWc6vsoI5N/sWC03JIxOi5dnl
fWXaQbRIurrFrI0obmyKbaVfM8cb/ZzpMF7gIsoLRBGz0MWT8Ds+dXLa6YcWplGg
0HafFJb9Qd3ifQrylexyb7gNViRw53cIgdOTnc4f082n39aupcP/pNMRwCt9ySxj
DVcatmUwSTdyKN7O7PF8NpFLG8BzfdZVbQCrtDhTiT3QelhfSQv2PrhTHLc5mlLR
wrl+wWvmZNoqBmeL3vpkdWgwuvNR4V/tKoIkrJ+aiBidabOxnl0vXvn0v0z9NxZz
xbQ91G1TWrULheFzPcdgcQYLv1gZeSTj//TYbg0GNT8qg6aJ3oIaD4te9+XwZlBi
mJgTdcwilKFXCCY1jMGqQgJRMPbvsUv7PmpQfDf01R84/fDRElaHYq3xCUmX3nmr
9I5Nyt3/p9QtB6a4XYpyC1sZb7FUZ1xsf8W4+YXsQaNeSn5T+NjgUqdbaMJk8fwm
PZBRP/MElB2MI+Cv8xjRpeLYcl8EdTqHk456b7bWxor2lcNe38q7hZ90w0s3N5TD
NqT1giYz9a0H1V1flLndWPbmYKoeYRmolAr47bVJCneBkAFSesw7x0a4rgq8vN73
WTtGBkO1MVTqrRqppqXyi0IfBPKTz/dTkVefDdNimg8CdgU1zK1NZbSZ6GX3Jadj
8TX5Pc2Vs+VjbGbYUvBMHnsLvAFpu2vmVKIoo1fS0Dnn2S4aKkEMBaietu6jatk3
O9jaC6kNuluvPvSTOoLJyMUCgjQTzRf+ANbRSN1ExOYE0kXSzdShtu2VaTFx1AYB
eURKeE/kmb6fG5YOTuYZGYNHf0YTTFZi7JUypIEZoeZB84wMSeqintEnSxchZieU
B9isMOVHENEl+N4nYCVq+eMUzrYEz4DCgA29xpTRsLY6ZgBMV10lFIwTUdv5a+gR
sj60AL9Cm9bZGfzYKkOjyWyEhOvC5SyMAzEDFKRNXf47+e1IzlX3YqVtTwgpbJ1k
A78DRPSUlHIZ4KtlTYrGacCPRWcXxE6nimPmvimw8JJ+Exp2Ble2M5fUzXUyVvo9
IZ0Q+eiNNQzbjOUx8Ct1zb/5HZm1tjf8bYwUcdEfoXVKF+sKY9y7laQQJXOTiATQ
HijG5FsL6xA0ON4+jhQp9n3AnJ+6qz94G/82U3UjVjL9sXNydcLhG0+UwLwwX1P5
IBJ+fO3GZG3gZZ+Jf9Fokg2JgP5GvdAUVAmqW+VdgiKz4eB2Nn/V/o+RuGxd99oS
cH0qXhrHItU0VNueW0injbJ2YRwrGt74IzJKt4CjrQRdiKlcxmwntt8cbGD+IpKl
KArUgG166RSC/nX0Qr5M7GoDn/eoVs90WH/Vb/zvt8zzEhFod/yCdK54pLcv96VM
dnU0e7y4l8734nQyABrO3+2Zl5QAP4vyXvtFWkx/zXIbHlL1TUduK6ztcGeql57b
7ARHp10xB8MndM1ltA3qKtJbW95qgPRb1xsVvIIe5UmkaoU+tbhT8nKecaDoIfyW
ckxEVyBWxJvzxyEfWDTEHoaZv7kAiFj5eF0S0NdJEqgzmkiHaEQ8Y5WXZ3JU1fX2
5rO9NgfU778yq9yLSdGB0869gdERCeWdLVSvDOkAxU2JxE3gDFzYzWnshCRj3Hp4
rG5/a5UZHImmQHdZMdIk56950bMOettOWQVlanjk4WSxrwh1fyT+euXrr+3QCZI/
jhn1HQUtsQrQJgQh65rcFXzQyrxJq8i47AzfL0hgvoFqHoKJZHyMmgmpCCp5rs8m
WmU1QnK6I02+lGCspAH80bGtrQ4l3NHzUXtJ04dhA0Q4SLWLasDYfgtfLu3GYcj9
6nswzXpFW2uKkN6yHAvWxerkZea7atj2zujbnFjTFW+Ih9wrLxHrZlKP5NDNr3ja
7HXk8Fv5Ai9lfHUpQofzakp5GmIeZAdy15z5bb4G1pSA/T/EJRAUyslqzsg/dL1N
kE1wp6M+APk2oB4qlkmfRgshUb79Dw+b0JGEh/o2+JyxcRIZqWnLBD2aAU4dYyxa
bLJQV0LSBQrb3PSv9QQiIMW6EuyzSWNidIxSnMEXWKNB9SFJGbsvR9EC/t+szsaT
8SbpDvNY1iv62owVXtkI55veNVQ8iTfxJdD30ov8Fhr8Ybk1LtNB0yWllCK8h3bz
+qwS726jlU8snjutjnfQpH0HW/ZS50t/4WpmrLO6kUheqqfLmbgNXXMwdsFibLxt
91sr6VP1T3HaUQVI++bCM8OQ5A0qtqGvUcKF/7lar+AxNsx8F0gaYXiCijwmc4gT
rQSDSSf1Zd6pPZIPs0Bc0qt2o9IEFzNp/AHphf6br0cDejmOaure+vRJx60lnFzz
POr9exyq9wCCLPdoXtk6xNvDCg6RdxJ2ss29mAHPnkNsUfRT5WVDXttYxe//Wu1g
fDpmFvgCfT9oQtKHt/OD5pgcbTWfNJQFTe36nl3BrOiAGeNQK7az/TjVjq1NO9B0
N+uwdpzA27XyIBmdXed0eiefEsrDDidtlm648VlRjW7kEHm1t0gDC8YkyFSRP/2b
uDEL+VYWm/66xMqGerBbRaOKUKYBKkE+s7pnZAH/YdmsY/5I1eZymowPRPuJB0oB
vabUVWh0uJu7STME2sBBxGK5cP71zV+js0ysO2IMau772iy5nMl/a4pBaLk5OigU
S4QvTqATkIku82B0JNQRsCEZaPk473TFX8dW8dbLcGeMKOd2pEJGmOj/fSDcihkp
1ffEAFBc1YiTblPvb81NZ8Z5+f5pHCvcEbwlGACl1bEACbTFkxUuuNM6vNuYiIjy
8xYAiHDsidMGjywRwVMhVSwLMUiTPOUvZS6smXYiAiIXq5J5UQgpJ4MfWDkM5ynk
v56aT4DByvQRDsqnHPTRKaA4SSjSexVC/xfKoB0S/y9sPJge+HTfOPZRwcaBStvH
d979QynhuJuwP1fTMw0BVIc5RBELp1fQfNqyzbQS9enIsPJhex+ZlxlGCJFcyq6K
3pD+H89SVEHAKjrr+mom7mmw6u1SOXNqt+xunm9XuJ3wgdx3uVUzJuWwsqp22ivD
feKBrZ46kzSlASbE/ytqPEbGfv1czuoGyHct9/l8P7TglundiUufmRzpnvymianY
0IBqXVIShE6ya4QKejdqBzvlKKbqMqc004ZM3wExgXrJMyYQfv8jSBQBysV/SySS
pxEHYO6SOt5vX453hetZOF4hAm81rIwtC52EShC4mIfgn8frXxwQOzhC+vQROwup
dA234j6gZ3ntr9GIwSLfmT/gUe1wQEN85uo/p0sAvbStZnQ4bESo34FTDJP5Al1E
HB8xmqk/o26X1XDIPigtpJFIz4RrkE0C9JI+NlQrvpyi0e98TWH1Us+FHAraraxr
gX0+rMOM4PTp5e3JG/ONOJX2N0r8s00lPmiatTic3hNb3q623deItwza8+mFMg9P
pJnIBQACVGP0m00SCP3dIWjlwy2IvcirfhBfUoHvLWceoDYTRhRfDqmBwtg81HZv
eaQMhaPljDm/a2CEBPeQrncFrfyLh7VS+clcPqJVSHmGRVpWcCqrY9VqnIYyOfR4
ljAsraQ60yCIiKrgS0WyHbiwD+BBtk5THa2ATnR9iu4VHGLVO8FL0j6Ic7bN/pUK
NR00Id2AJkwTiKKjoaPy3xYFkuuH4m2whwaE4Nk0d1xtzf07E9l+igRLwaSUOs8d
9yMJAqRylUQHwtu7JwKfQS9jgz1y4M6t7kCAIsf8J/9PKOZ+S22ZWzZEWxfjHXqc
aCIE4uXYNYrLoh4440SRZ+nvdPg8yEbrCiQi6SdcrqvJfFebcOQxOoesBKCvcuYo
lZL8jMZptpHFLiKxr3F/JXqyhookNdCkSBYuWHWHTKek68D4dQ3bG3M8R6Ch/xiM
qkegTLwiLT8tKRfR/ysMU6L56Fx6N07+r4QItihD//e7wI84+5NEU3yVKsBEVrF8
TuI6V5IEy4n52mUvXJkuHkjf7Br55pIJt2ryaucpmHwYHWOeDFTcxaiAZTmJ8HEZ
OTHHTO8dUzxFw0D8YQZCo+/gkHo8j1Fwr5EYzwPezio9rIFlAt2wHoThNM2/HfGU
y0JD3t06PgA0mmozMRuciXDbqAX/oZXtx0gQtIYgKukGQFAbbf9PzHHWKasDn2EG
wioJWMcysyUxWufEOgyMioBH/GEfQ+C1XbTuX4mgjARLC1B47bEyvetJAUH7/S2H
vxCFrfp06BL7B27bsRo0cVIw51S4nhSF3HGa+AyXqo2nzorMRI4YZPPhUoqqDcXP
Fgv8bRVGGjWjdKFbj3Xpexjwp+feu0knx5qAd1IuDjbwoXL2tZXT9GozYU0L983j
ihS5T4FhKNmgEfb5WUkx5rDqS6NsR4QbYzzUMEblfZDz3srdUWG4P7oksa2YT1l1
RdI0vUisRw219B0Ft/9fZ5hp2akMvzkESrUU1VYJFPGzU7OJIylIQZbg17yMRyj/
bPiJ/AG9loojhu8uIagWd8uR60ACfJYbr6JFpvnvd6B3ROib2GvCkiqP83bz4G0O
tC+LSrRzoZqlavkVmluzUzkTVZvVKfIPMzBeyiB2Ovr5KFkPuh4i7BIP/jNLm5bK
ZisLlYYOTzdiNxmIJkZ/pmnlA/MNnW4AiVAxkCP2yyugInf0Uv1n0nFhRKEnPOVR
jdk25kOVEdLXsCIPX9dILWxJ6TA4ot8Vg7W7Fq+DS9PxdjdKs/jK8OY8l56sXi+n
y4S9WZfBGAcaZ34y983zbZVNpsejNBWn1VXudaQkQePnfB8VM1c5rcCvJs/195DP
tbJSZfG9YLrZIHCsGhle7qx8nkV6wc14jU0ceXUGb+zk65dV04aS3pRrwHpuuZRU
21tssilgst19T7ae9zUtpuWPBVAwtVR4c4YPKNI2HF+hSVqzXLCOuov01TC8zGsN
bVuWcTx5xKNyVH+w5poEWjUNxEcgGXO0twzHJzX4N2BxMRkHKnSFTD5JPSn8Ck9N
ZzmeBQo/jxiXKFsaWlfS/B+S+QLQ1DOMpkqYQeDW/F57zxqzVVu258ySjShZDymM
FXT1qBR0w3FRbGAlpfMeT6ZR5TyRLrx0TGACuGxyOvLXUaFR0QIn7tn8NlwPpT29
bzOs9bkGB+zH0nrG4BybLKkIBy49/R8oVkk2H8UXzg+IvvBeGV6quiOpuMx4hpIx
AW76hGlEFNQFEx9KsqkOh6lASHIHzEX3KOEKHUm0BI/a9SwVKrO5WN/inXYm64KQ
GsB7BS8p7fdnp/3PpH1SX4ykArmresSXD5+sKBstGX06miImZW953xfKk41t1tH1
5k2Vls6SCVcPQLz77ed972+8Sw8Wvx+JtLHTaUoez5cywqTbc+zSuqYdy0TzqkKg
jDqK2M0RzOil32BMsS3/zS7BJpED76i30DeA1nhm4URtqnGLqoDaRaW8OZYMIyRS
7NpFn1Og5Oe3Y59jeJLSbawS/9B82gQ0qlZEzxj+NRCoMYpkTY4hMIfsXJNLPUtV
TXFeI2Tn67BniHhLb0wdt56aqbjzO0Kb/N6r/hhDeadIRft8crstJYgZjeCPOfmA
zvSa9TBxnEh1ugVcKcGKmWd8+031WoRlaJ0gkeoi3nn0qytji15vRspZOIj+pKhy
FpKHEHwvpWQ5NGpcWpRXm8iPIuiN+thRFl1eDXnPw6L4XBJd2GElRJ2M/spCT8Pj
kCKOZI/koiHK/bT9M3TIz7trUd4po2DMaLhYoFTZjX2ehm/LrYe64GG9gOW3pRIp
Pl7C6hKDcnMZIa0v1BprEYo+PFrFvlXvT0Z5p28nZ4siVW8ZYbH5cFYn9vHNaxPR
LiUSWd/SAm4qvMMKBifP0kZI7FQbqBcz6TmKO8taY5tcUslrG4/uMh4BKcuvbOKs
8e8p4ZuRQJuA5XA2X6OpAcir5ThTB/PnpstIHdiqpOfHmY5PYLjhzWDCAaTCK+3y
b//0NNWrW6GcyB/YzKZdPGfS493S2YOKpx4lOn9lq7JNQA0qk4xRP9xtpSvnx6GY
Tkof3qxrhrMqW9CbPDqhbmMA+uN86XEFLYjkucSdDjnjlIWlP3Gaa0rVJxgmCM+8
iAPonlXxTPiKTxuUGi7suQ3lllvbXfQ5DRxmSK93Vl3U8a453ZgqfxP6uQ1ZflHw
xfpfdAPMtG7YujHaQifAgmqo/dSqbCBfXuKTHeL6fEd/Ar2Y9B+MY5wI7XfXHSnU
ymUU02k/WcmIlH/3AzVBOwkp5e12IXDiRtRS8Kk9beYNB0MdTJNMwqAVLKgzIx6x
Vi47lzqC1zcUgDEy9FEggQpinfqojMXOkSyGFh6mhd80cdO2On6HLF7586pplmfM
7IQVrHSji5C4eBvRHnbl4o8R3goxFLtcqvdUQjYI801hfY9U8x2QdAT5kFSV/x1g
4XqfkbnTsjVbYxO6w4q/wH0g2NyRxKi50Sj8KtgYwuwhJqA+7EXNoSjw046Ieobw
4yjDWIEZQC/H652YYdMvG6Khs8e+i7J5DxmTR0uce7KH1wzm57PRyZNY9PgaMd26
srNIw2DzELaq0MnhF7VOVB+jbT4eIzIxXYBm7bf0SRq2vWPMfBy+fKqNy8MN+diU
1/W9gB57CwySalOJdCpanDcKGf7L+wHsFffQt/oNEzZxxUM7RiTiQUBdkSWsFus7
BCaMxB+8hVNOY9ymt9ZaIZtuF9fNhMeQyL++AumPK3S9ouvFKrfp9Zv5rnejk7v6
bBP7XenyEbbT/jTFxD2tQNo3nOz6VNc21fe7+lFW4QtBsZgTLfnqZbiwOUF2jZDR
4zAX9yrvMXi6xIsAJRZqMjNHQ2qGEuHb+vgSNDzwIRgIcft2Kyw0fo7V2LxGAZkA
PnV/61VB8QAdtAvfM1txH5ooWqlwXAiMo/9rfYaDJ8/G8pFbIxymxOJnTNjz4n54
wRCV4OOLUsHT5hKgkTVvaYoDDZyiyuM52cYNZy3D324h0IyWfCrwitEw9Z2HqK7a
HAnnG/UlwBqK4VGcFf1901yqyoyFbsQWEgj/HilkYNEl9ZdOmkCMXVQudm3LavVP
T9LRS4mbPRwZGNDDA6YTB7Gjbm4bVvQqOKxY/y12MpIyrArn3HTCLpQUWv0zV8Gy
+JCA7yEFsjDq9eqSfH6t89optSIsIA+DBUR2PNYf+5c2rEuJjrffWaO4BoSRgQPL
E6rGAVndAFRBvKHRAJ7RuGnymLkpZdN4q2vmDAvdQEBMue97TdI2bDaM524rn0Vo
wikvF7HIaDpkdj0puuBcreLlD3d3AokLWphEVRpwIYT+jqP/S7hdvo8IOkwv42Zn
Tm6QQJ0Qv8vUWiq35rGev/+XudV0yPmhER20gnmnQEqfea+n/Zz2a7rbsX/2fOW9
+BEfjDdZ9ApT2seutM41HXkZ75UEZVuGzzqp3mt+MFThsU0uyhxuOC61/99CwQ3+
Su9+PCP7GZmWqu19rBRWy9oGrT3KdgDMy4T3DggoM94wZRy1ukXjE0fNekqb4P5T
JsfUqATdvmQT0UbvZocFH826LTZIlvHfWicqocKO3/cbG0UTCDY6m2ODifaLrlBK
qiT0j1PkBuUC6hsJZVYaj9kwuW+mObovrN+3PTkm1F4AWKXhTm3atYixawrupZmv
LpB2Qx226JwH7MMfmCCh2gpU8mAQ6biD5eJh9zmlHfKU7fnn5oYur82vqJTkP+po
tAZrBpYMVV3Zp4gJUvs4k0eT8LP2A8xLECbaYQY8WAgLTnwwb/OOkvhuT0d13Bub
pSiEwk4pjE+Gzkm9FuN2gno6Y61WC9bv2aMZWWVhr5zASAUWQ/YFk7O1WwDcDA4v
nh2UTb/zdy1xp9cdEsRj+MIKPFV0izFU+ZS4sB45cMR5lzkAy8o4Jh2tB2sDeNOX
Caa529C4gC+L3QxODWxLjHew8BPhBTWID1vJ+GZr+KqrPxpTFle40bB+vNFuzYzw
gpl14zJ28pauUF6F9tCI4hVwa8Uc+7nt8IWs6bA6T3NRNg4uBW4fo/tWW3KXftjg
0frRww/XmegkHdqaGsyCTfY+FeGBDOW34+F0nRu/wZ8nVo0YUzim7UNnFYc3ifxW
HPlo0O117XWFbuLB2JyJlUlVmnVXsDGk+4wvBhvr/2KdHDBtm09IAo4rILQJlnJ8
wgzEIgiePCf0Ony4t01QPccaoddSsxIqa7k82E5GDThHZDjsBclGLx6BahBeUvTK
Wrm3MwUsjVSp4sorQnflgWQDvulpeniLnIxlD+gKVg3x6/lDvvuvcNzB5BSpmpVP
8M1v5XrvbINQ7H2QCxKCMskXyevF7TsHGy6jTdSfkcoDD125wXKlQgZMVxSCst3p
2zUk7WafgJd6Yyy0yX6kbfqZIOTt07W5FlkaM+Jj4B4MCLYe03as1L8yKbfn6aE1
et3GfOd0e3AVy43zXyK4tYTRhEDtz/z8cuqO69hoSgeR2NGhCvKm3alW7ypBzfmW
Q8lTh46L5WVhpGDIGz8O9uIkHshg5ec53oRIGiAHArhSwbbKxz6Ou9mykwugwtAm
YqQ6aW/2IXGmDyQKF7fvrt/ixiIh7LBP2DD0GS4Oysl3I25hUPFt7X6CWFxb+vh4
TcovYRv7DSDKdNDkL9d76pjvxeTy1Id8NBRqSkVlMKcchqx9fF3XSBGzXsOOgVdT
c8l3gR2R9LbvEqF4J/a4cvC0kLP/ccpbcs2KrZOCoVB+jVZyDTzAYPsFX1ZO+LZ4
K77A8yy8g0S5+8HmtblK2relX92PwaY4H74necFrpK3W1pru8jKA+FhNi4Z2yA+i
YmQYSLRa1kT6yMjsCR2G+7AHutfA50BJxPT5/ql+GVuPKPBSdKmv/bT/oHy9qe76
vR5JIFuhNXG8G/SDQ7tGgbU8l+SQnz5LFQ2rWEIzsA1CDlINFO2cKHS2rYn9STjc
9u5S+pRJi4shocHj0O3Qq451c7W5X230k4P40i7C4nRxZa5JJWbkrV0wywlP8kOV
8G4/FVtNbvcqi3ExRMs5sSgYTVd2LfA+4l8y3pUTARpjA6jHaD2Dw/cMD0MSj14Y
KFMN8fj0a8GTW2svb+73LVZJW23SUe4myRr4K1dT65Xx/cPcoVJAtsuefb4bP9/k
0Jq51xTzyhUm4/br4ES/H7kv2Vy5b9v8r0SWf3jXJB2xN9R9IsjeKF+tyY17Bdv2
5AMyJoy9rPQye3NqXqhkSuUOOsaLu04Ft0FaNlurFPfANhBh5M1wrHB2FqInysss
ELWCNsc63Vm2hED5oAMzkun6cucCO19HBZfFHrNtVNTpOOR18Lqwh/UJwVotDkuU
hoR955Miimaiae+6ehWeuNL5FHeVDrvgdFOreytPb+qyFhtHZ8kHOg2UCA3iFrL1
Lk98Dn8An95CV4s/ZXE9dgXP7Wq0D234/dMktGurFzrDaTlc09oOKKOky8p1d3ud
Uu0RQwmx5DgL7g2WFX0ZgO6BitB7RvuP6XFmLTMV/gSQk49sI3i3VJw4vegNiP1O
TgbFfCmwL0gT+CnymLrB2d+BnoOgvkCJMyuVhqWmmxyLeE3So+vt0eKE/RtLs+wG
12H4/hwNg1Lk23q26cM3mNFVRuf5rkLa40Yo9DdSiPVhLlLIKCW+tSzJjOJwYvTf
akqWnrbIIwD71at+XA6uvQZ7KnYoaxDM1ZkRHQV+t7KuxcS4gq98MEGWTcMOrURQ
KpyxeVCQLxKXT+/ZT+/7KJtJZ2xjGOX13dxKlwR1gcC6Hxq8aA/kO8UaOZMGBs26
/medBzxLgOULAq9Z5kvwLvaVWlx5GegJ98NZT/BNI5zpptLJK5dMZC0akXG9S2WM
BoabXy+VcHVnAOftRc19xUW6J6dStvA71VcOtc4jOmrw/HTo/imxPvqItAuuxJoz
oQ3gkt+6RpkEMkxaZ+bSS4+zHrvxEHkjDlHZAKdXY+2PRY/XJxI71izHTQS2Utr0
8b+rwu8MZT81vFYxGJsJRUOc75cC0J1jQARZrXO4IbV3oHaxMA+rWmwNcKXxt9OS
UolgIllAV8D6F71APxkGqM+JHZsoCY2VBaOVt89F+3Lql0bnJUIkRGIo9ragTKzL
9YTqMrUTM68rp0/dE4GW5vjn66arI+R+zhL+n48q49ypUwHPgix2gzfJTmmfIkRo
J/GooPDMMXKZsXJHsYBLyffNjf0w9U7cMzw0sSPOQLtt9gRkE/c2eZMcPDGAPFrI
WaXiYytLpPDn9j0uoetULgTUjO1jy9SZDLOUtVwWtoBT3/SdxpE423eX0VIU8pig
4006KRdG/tq49tm4wt2Q33oB3pe9z9yNxGMK6oXO0NwgYjHeM4wTH5aVf6qawG3b
QRbJf76uPELQQRSZryB6JIobkYDXL/O+eitI6ahNzNd1uwEzOOX0pUVj+IMlraAK
S/cccUtzbZh6WUVj7y7SDRiR60q76dC3FM/bik+cscHOc7/a461GHeoyhrSNKmF3
19aSXGwK2Z+e4TcUGPEel/SbJsooyT3vj8iFievs0/BIwebf4karDoSXvAdDaiwC
4QHlp3sg8HBwS8KoQI+KAzGroSXIEttENW0UTWlNBigYJDR+IRc9i2eE2RumB+90
DXIoakFbGG7VOGFBeasEo9ln3ZHqXfpazW/7ns9YICvInHM6DolP6KXDGSlGjroR
UYRvy/IaZnl5aynzZ4+5RIoXQUnLXUGbTZ3ZGcjMobGryKaOrJD//DMGtPL26XbG
2QzpXOH9jy09LSgZ39rEamsxIkxCfxgPgD5Gv6+dfqnyhioIOAASRPWgBrt6e7Gi
/jMYL/0YPvkqvG/ZuY96GwpH96IZ4RrF08Q0doReuoEvp3Alq8kyE5IrpxvXahvc
k+xvvd/l/neVEEbSbhkFaz1XiXq0kgnnVUmVrTUomA5uMS9mApvwHuXPZtso5FM3
bY51kOCAwGcKXOPhjlShVtoxFCVXfJ/iO3bcCoOlKVkGWSvSGfXlCMcxgpwjYZxx
p6qKYEHoOgwM6NwMhZFtKXZ2mhtJdr7B3TFdJH1/T7BYfAfoQVUXRecfQADhoa+y
t1VhlHSqrrjVSuzrwq92Du1w/fpZsH7Edq4a/NUzy0KbQdFM6EnYIx5Yez/pjxny
lJo+yIz5mz5MGhtgzDSc0x2QG1CaqP+nHosP52sM0vS7YYjFzYtiQlgJV9vdImvt
CHbEyAWmiWVKciut2cf8FfAKaulSh6xnAoWvN0c/lL+UTqn3qb8nmDvrHIf3d9B/
h7QvB9IDDaiU/qhEol0R0oNQfYOWEfVCTl8OuTpvXkZ/RQFypkzx69H6WguaKM/l
d8yaRU2VmTTvzpIkd1dihCzDevAuE5aO7O8uo0vCNzaIdPPQ4gIMrKUEVt6zQHf1
SWRfuK7wmW4doyuCTxrupLHSfO7D+hbfHpoLnmBaKiySMsjAo2d4yTqEXLlgaYGE
wMF9U1tMsxLyi3KE6WJ53K7yfDG1OZVlagVy2hZzCV3vZH0HhCbeggJ0NFAzbiAz
y8eyiLcSqEtg0mhuz8UiaasEQsWrcKIoP0oStKKmBOhafC7h7BqyeC3h7DvHI1dh
jOANiUQ/PgbCHvl20mwf8rr/F7hcZh9L+I+PhbvgTtJXqW0/CestXOpYescuHk1I
ND3AZYIcetIHYhLTiIxPOm4cYEeaqhSb6Mgh8QRE2TCcZHA+a3w1U5hWBADL7ltL
CRcM03tNRz3P0SIWAjnRu0Ix6TGBKS+74gQVqtwRfZWfhc33R+dvWPoK3PCM74mW
ICwCb5FF1XYNNqkhDePg6WRG2m85i6QQixVLLSIVa4LhpFMmY2MNzGxvUlIu4RfU
oAsVQ6s+E/bCRl7ZRgDjVvsWbdmey8aLBvk7xvGOfod0QoGnuXodQJwBisaFDLk2
v4J9ONrqk68Nh66khOHQjlNT4Sqin2lPXDySAXM8xnhy1lvemTpp3g8i8TG1FCir
vnrR9+PPBALJqqr9wIZFwmKzbRWp+HBVjIU+PJM0nrE2OXJRSEPdUOK8ZaDp1Loz
iAaQ3u7ILIfPh6Jky8btug3cGU9+ms5g6w20tdNnRlvqW5v58AvS314ZDHfrU6xU
nfJdnAyL/7pnoW/Lx2FX1jYEY02tGCEcp4r8hYOX72+fUYG+QCubjmj7BQaz7EKQ
UqMKHWMFQL2ZYLRFa2Eit57uqzSPQpIMvkaUDuvGuJDfq72xcfrfUtrZBX6k36+I
TCGdQix18KmrAAl46J+6nvijjc/OrmNw20pbk1p1tf0RTXhiDEFYpauMH9DiE4+T
USKaUlHBoBMYgTNYqgRRzNB/kbUa/AyzQtwEUvMob+gDU23RHcTY97Q4f0VoI1Yf
VkpX4zzuQjDr5WdW5hAXyPb7rHY+Z8Nn04FAXGKwiD5QjVoslKrj39IdlE/haWuL
8iTnDazb99kkyf13JbFghLPeoYGp4vTy6Q0bb/Zqh7V+64vFGkAnzwQ5ULlw4yV3
Y3BXS2vKjJfc5+s19TWy5c9Pooeni82cMX4lofsOk1taGlzfW5AOwA4VGaMPGfa0
Ay3wMfycxKn0f5BCX7kAhl/aE/zytpY75w2hMVdPbukUNxR955mVSiP3tRSWFTlX
lvGNuPO8+l/lmigqXfs0eH5q6i0zWlye39eqK1p9H8AKBSWjsdeLOZn8wnsgazZI
7ockIpiH/juCFIptuGvxZh607cEAhpzwK00OUfVr+2kclgckDBos8OyEHOB905Ib
FoaR10BCWKhjVQ0xHkCV3C8UWE9otOwgp5SBIWsJZhIuE1zUhap6uMqoRh7HMjam
2tpc2pvO73xz9OeYvOnsRwpaS4X9ntsPs1/XDHjfjUtAF8aRAiH84vpgmAllEHXN
R/Bcq5VRO8MMOOQ7Gn6263XEyIJVQ8XX0tOMaR0juKNUPDGDruXCzfuxLENOxBzV
U+TzRMjoGeLCNufdQZUDYPZGEjgUX5dD3ghDiLsCWb+HT86DmCVNY8eiuIN0Lrhl
tJvi5YnghFSW6d4Vq+rEuWOEk1+CFuEzPKzQgMGRb+GGfZFPOEx1NJhsLVkmZ8pY
fxvixLnPgztUbQ2NvysqCRtqh/Qjdho2NFRKI2gz+/d881eV0GbOx9fWrHVb+rzX
5JVG40bLfCx+umzR5PNA68OStpYEL1Q1XKls+YjbEHJmBYgbKuuv8bR85HTjVa1i
XJWl5UlOKlUk9tkfxeViMkZWtHtYbaiS1vrhKlMCNmYRLzX+8GU0PCdFuMpqKGEO
SoXeWJuMzJB3+3gMqzApTHBRytm+yqXBJDqELw296ihrkxonaHzIM+8SIBu5oQ4x
f47zIIC5tKHTApNRHruMi347FCfVeMzOQPwr4JrGCHjiC+qxORQ6JEiPv2SEOCDw
ScftWxd6ha3Zs+szXJBO60qP9f9/MEz7D+dW4pD85VhQOPbmpPjmKh0lCVy+suRz
i5NF1t7DJZDnrlLcvY74SF5lrSDJLPB3YC2Ky/3L+qyMy0FUFNUJ+vy74hz3U7O1
mZ5zRFOIj8jRTjgHZ73lEMNIer4+FbhlO5DkdnCgM3OEHYsbBuho1p7BbW9ydwQd
dT94gYlwGWZBIuYGmC4HasMj3rSCk8S9Arb1LBiBp6GwrbwPrsKJUTc3HA58LLfY
EypSL/m0E+Z6H5LLRWyEXYoLm4koPBNnRMLTSbOHHOS//8zgCvCEesCF3KUB6hhv
eeydWMxK7fI2dNKK0z/TFffURKgdHHKKXd/eAKWBvF9UrWtgKb3vZCfngusOV9Ah
fYsxKh2VI/iJ+bb9REC5BI7/+zR9+OZsvXljm8od8KYiDjXhF5QT4x1xOrsvKx3i
Wy6Q8ZEln5kKqcmUafzO0OSOx+7ZqR9ssR528KZbEao6XneGzvWLtKbvwtVzjW1R
m3HSijPbAt8iVAx8m79BHHw1QRr9gjIeA+WsaAqlk6YOGHE4vC5/fZcqUvhFE3qX
1KdhSxXjdzS7SjCL/u1DaCb15Ai9aJ7kVB8Vih0ZtETXRY5y2npZUfK0dmJzSyiE
VJPhXVITqzuF4BKHQ+LkkzR/37UP+LQwPpj5rysAO2keuL/sFsjykCvStVD18aUR
cNhzmrn9R1EpDSLFOKG1KziY+KFXzY+wtr/hx558II6V0rCKgsNcrs3czpr9gIE2
G59RoYXQH950qbBdsedlH1EctvHR5utBBQEiwwS8j2kw1j+n48fkyEwI2/OWt11j
ZyGNAAc/9vaK/WfbLYtQyrmYtqnfGFgwZCUN1A7QMEx1+rVS08qi6k4jZVD6WcAB
/oQ5RQZrR4pZlgrwqHT2YXmqZRAxY16CGKxP+vWmkVbB9aVEzySqGBi/uRdyLEzg
f6hUU4/64H/DdE6nsYxSpM2atM46A6bR7wOuC3/hERKh164Tnrs0nRUZ9X3T2/Pn
sFAAxclV3K1OalXNjoOigNVh0KP7L7lAEf8UakHj0tCoyGFFa2so4TtbFC0b5GDs
UiaLTg9cvKgg+UPzX5G8ScBPMjhHC2BVxm6GhwppZ41JZqb7tK/r8gVhiG3BPOX0
oZdtE8R/EgZVGth7jxtNtgIZNEQanSNKvHILvfzJlthucV8L/XnD2avm0+jJtOXF
1BB6wMQxwFNzs2LPJ1B7A1ib4jD7R14iSabVxnP0OXBR918FFQ8N5Bf6rSNPFt2R
E7WrQZbpwgnRf/1QasuKu/yBRIsntp9zUJmgKaD/hXmPeRGtUfNBG4vAiKquuYmR
A1ClIWI7ZamnQskeJBVaz/4aBw2ynNAjtr/hB+gxHXG6BWbZ4SY/OVuVL9mZHGfk
jGdkchUfwzwkfaFRRB7eBqttUsFhHuG8g2exXl332YrqYJsDCIDH2+P8lVrsNKYH
xZlajjifqn/A40IzK1CfFnSg+2C8JbM3zxyh4WZauL7yUsa0Xb6wZqdLTTHDDaiz
HHKoUouwpeUb1Ecy5o0z6xC6Pu7FI/JP3YwFZiDxUCWO/OMDz5fxwosTzqZvwbFt
+rKD7YukJQkB+4Y8laDaVlQLavn7TD3QFiyi2qwB2X68vskEmF1reiYFULuqH7Kp
wiesnDH8a7gBRiow7bAJ+aIozxQoo/IBRxsyNm+EQWpXbnl8FCPQStTbM2K0zFTC
Dl29HGq3q32EfwQSMQFKrTwt6vWa9CAqPQSxf6P1iiB5IVWxY1ym83gOwZTySJfd
D7bRVZytf0ZnQbkwV72+s8vzkmTI+WZjeWxfnRKq23BmoqGcmrzlDHlvP79rhXlN
EHEMZo/CbBI9m00F3qGivnF5Fj+wU3G+24wRUt1rUCaqpQI8sqkPPQm3WoTHmAQS
nDhg+7KsJSua7vJgJr4yfGY5ao2oJwdFHMeZcsvsmsp/N4DRhPjv44vTfL6iHuME
o2srbR9kpRiy1g0WdHWL0V/QzQ0XPqZ1QSbVxujJHQX/xzYkHLS3sA+9K/62nipL
o176jdxJ0ch86zVQmZg4nhwa5ig/gNqx6werEf/aAAwBou4rCxA4zk07WWsSX4hY
Qo0bUnvRC7QUFRShtU2qebggooQYt7zAbGLpN6S5X9cgJP5eV/jd+lAhrscQxlD8
kn3rih64sNBNB7lTInDnRshTXeLypG0pCjzghit12lCtCBKeUCGxrLW1ZAsOQJWC
3U9cewl/w3jTAqwrZJDllQCmHEFKOY0kF/FgQD3b3D1NJ0z9D7NIvoJ9elnIEcDf
LNS4rJOJezR4TlwJXtdEjo0hencS3oqxHwEATxA6I2+JLfXPsdFtCeseZrtnlQL1
3cJT8BFjUPRN3lO60rLOeZCKczK/P2eYq1UAWgpiFzeZYenbCQVSHQI9klZOPM3u
Ar23foN/+ULN5wL7+n9XC+xye9l0MZFRlgXYli9wQPgCZLajE3Q6Gy/3o1Oly42V
GsVlhno2TYp2Gx7GkSQKnQEzt3tAEcY8qrBafJ/cgNh43Sau2VNvbHooY/pZVXpz
DDIIK0JksIu17pbixPC95etDnD/Qbcd0wAvtYfZwIfc/bJa/8lBGWYGNSs4Fy4YF
UiJVcM0YNfJcmOmyjcUbALxmxFG1JfbQGxjrBfFakeh5pNS7ZJWK6Yingpq0mh0y
x5b63U4gwHjaP0zScTDzTQBj5PJdgZ3OcXEQ5nXeOUqQO0CbOgls/O4pXHCRIIfG
HYWQaoSsYTd0iP3hANKuiP/TiIyscdKTBNcNAsNhDZl5vwYnqa4wnubh0xO0rakS
XKX6oTgFKojrE5734qrFs1cNNEe9ndoAiH/fnJoFQXoAmIs0axefBTbOG7EJNMhY
R4NHHXcYsTxsuqkd76TC2UG5UY5JTEGqzWJ4Zb9OTU9fNhpkIEViVC+Sx/Gz3s+6
ii9poXBtVv3kqYEbtw/APaTNeDXKt4bNHUe27oS65DW+M7ZSGtgI4WAK18O2t+rq
U9laTboQnWaZiJPfOxASYIHEvjwItg64OfxQkA2YA/p6KfWFuS2iQqPl8ypL7bRZ
/nbMYiefDKyd0oCIPQidaRXJRB+lusSRLTTWUNQ7uq7YkHjW37U4luAwD+M4y+TW
n2mmamo01hMOTjk/ki/Fajs1Gb0dGg8d1viUZE0tlSoEWuLf+MI2XT8V1s5apJ/S
BrhQJeGOJbEUT0Wg6L1WPUzDoEiGrnw45b98MrYzSD1fcdFpGNX4Hzth/QsSc+kb
mvZCUOBZz+vBeYu7KNwr1y5qekSt3L45JSIthl0oFHeFMwonDxXO/UMSaC+NkOZH
zPimQPzL2MPgdAa9kKgfw2sRXxR2O9HXHM+pSX4vOSy78kG/LV3jaHTvvOXeh+DB
lfjPDaXUi2dWJzI4ETsX93BwCiWOswxLGTioTpr0SOEm2qO+Q3+mefxoSDo4YxYq
XbX0m566MNcuQkSyPRx2f+iV9ys9Aad7aZWu4MNzvoWv28+vGoM9cyW035nfdMuY
4ICKSs2amQkvvduev75/KzwGGvsD3/jv/zJf4HOOo+5EDvfzxfKFnkW+3B+prHtO
pTmC/qNmzXS/+2iBZnHdvf5b5GyPrtVkUh/WoE7q3jhnVlhXZJ6wIinZA9ymZ7ji
d4uQUGeBbd+v52k7Qo48SSWEWJefqHb3ZuCkT1czBwV9oFN5hzybqvJRidg0/d4y
evgpCPkyxg81Shr5Y7ffpHMweNDmCMHJmQuELdtrUwXIBxRZSiXX45dGiMIBHdyi
L3ZQAcoSWcGPKzkDOk0x8KMV8aSgVC/TqCNIWEUOqHxz2VGzKXi8Wi4iou8yw4N2
gK0GfRwPqV+FffHyqUfHjoVrlZogjDxYx4cyz0x65+4p5dQGnnvIK7/zK8hIaZkG
8spip0yqVVBbqxqXlOKc8HjffU/qRvguHhExBKaiN0vmxGT4oeDxXflACuUeBOU7
wTpKKHI9kXUgOctf5ur5xFu2fSn/D1bnbvMEfX5w8a6kJdhycNJr5g6fgpPghRIt
VEI1RreFjEVS7sLEEnGGUOsRtgwRJcLAL/KAvX2fu3+Mww1ihDflMFiqTzWpaSmY
YquxYNTeE+Tc8rz2TKF0ylmeVInYx0N0ETrSFCymH02S+skk34mKNriDd+fkj7B+
zR3qNiLsP3j6VUa91eb/OR1/VJ6X+UdFG2ieiTbJIn7d82WOlXCASoP78HPC4PEK
1KTqIT/HykEOmrpYxvx3w4tFxnicR8Pqd9eyOlFD7QMELnm2AsIWuA3IoGxkIq/0
10JTVzlxW3/Se3j2bASpDnaAA+uHclk0UewRhBLbbzLRP+wIbvEZZJfBq8RKodjJ
3BNlkeTcA4/NozCE4r0qwZKejDh4NJuXKTBFyZ+DmwZvdkz0sdwT59Zwyb17BFNg
/ibFQU6H8c0YIe8Xt2p9w11FeJ8F+/vRnlTA+d32TTx5ZXuouUiZn31+6xnqZp6M
vp6UT6uLbH9FFirrpgZY1KPfzgz7M/Snfmvc8d8T+6wvF6kg1K84UA+UQ2FHXpmh
ZaBUplui6PGrIXWQdDeO5+NCbmDf3NTkxZiEYL20jc/0/MdYn5+5wTConlTbcGJt
4N6WuWKTuwDfdvfeznjEz86KC0BROLQgtqxnsgNzF2QtWEg6zzvjFU/iFzHSD3y7
FNbwcezJSU//StiKl2TNQMVmphf20bIOSCluUNXEqV9CZlVNtD7Z1ZW+5+JB4O9o
2DWhT4LUP+UzwF0S9RLRzHp0ZGTxHsQFH7IshC+/YDWN9MWPLUrmn7WXFExrk4/F
goPEwUdhBQeOpzYAz2myHxw3oeKyB9eKpKAzFoMtKkbnTt5GOJBiHjQrnbP3otoo
NTam6qUeus6e7QoMaqDKZENIHbHqczYHN9iYvas0R3/jix+1YRlzV+LHipKpGXtI
8/2iwHnpUc0M8wdrOwxzad4PJLcSpKCp2z7+wQMbKAOyumPA8bz2CCcpT5rh7JhE
tbIgPtl+eDsCoM/hapYAE/0z6nJ5dOaAxaGKdJDf2yGv45Oof8BEQHQLNL+emXEn
mNclG1ovQvUjqmxz5oHITk8VriJ2UUTuCN3XSC2ttUCMC6sXFjQMVmVCcJEQ5e9H
wUIabzLGWGFknWd6xjg9yFTCl6v/jwHM4x7gE9WVfzF1++AMiuOnt6gIAmvVnJP5
Kd50N6ET6G0Ua7wvHAEvzNOlShiKiptuILH6/SQvoFsj0zn4gxe3C3ujCvizkWjt
QEI6gKDui1B5+2lh84v4RfR4uf3sJ2wBQHV8kYi9NsY8kADq1CTXDuE2cDKjYwcH
9Gv8Ls1FNUNlnnrIgAkM2BQ+ncN7EKFfJKRfIhSrjClVrH3Cc+AxmJYMd2hn0BPg
PQ/KhGdDp1UzLQt7oVJ2R8XQk2VFztl2KRykXtvGirJcSU4lNM24hpk95siNjmw6
a8RNhcYiaek1EAtc7LNye/bWIshTl+dasEeCFOPsf5k6lTOvXoz10VjbOhXCUae4
AfifcriyIereGEnJeFmDXNOD23NbHgI+bh1RFKTtkTBc0DEHlSNrFgfNI+8XUuyt
n3BEbcvxQB8FQhbt7kYw1BcHdR0gP6vlH9utEu+crGTfcTUyzd9tAs9mVj5MuHE2
ZLipN0boqaMaTiAlc+ZtPywY/pm1vRsXADmlM6qADdfgGUylB/I7rjt47W2FkZGN
6kkaiXzkHGQhvwmtb9i62kduX3ESVE8+2D1gDkeoujxBIU0n8VQMPTNvz608roYj
i3WruL8a3oSM8mUuFYkWs/Oj/Jd+szcHu9C7jhWKIyykcnFIol8gVmV4pAKp9U2a
0gUGeXyg4Vb4Rvfv1AYO8gsNCZj5uRCiCQo58hiTgsomAH3f89We20ZVIbUcncNr
iJTOd/PfgUq+WFpgmii5oooTOycWWYqM9MIYhuUZKVnJ25EkJUu1gYDbdFQbfBsA
Aok5/r23q9ER/n+2s7M4XzOgaTkQSv7PDXgB4BDhQpt5h9sMBmM7C/tySpSv9TB+
mL1ZnzkuO/MVxF8clJvUOrtnhrqQxSH1sLtNvHr0dvDPde9rU0kSf4ex646q65+8
yFDdK3BYz2mEtEGzvnnC3Ib+YQvEOrQeqhCOdheKzpkLP+GpM+wJoQxby7gj/Qj1
kqAW2Ogy0zGwud/ak1r4NBEEuNrxv8USkDWeDZ86atIHqm0fqLmM3pmeLsj1vQuh
tujZP3WiPONBe2C5X+OSWDn3zl6j1shvcSR+MGzkU+YjZZewO0UntkpmGlUzsPXi
5XOmUZqO0P6mDvB5pGhFWo7Nt4kJ4dqQJNHuKIcEUzxOeeKPu9bC89n1DjtZxHdE
FjaGwwyZtFD0ARXYkMsaev4rjBeoQn8tYIaWPwPx1TyjGM5Pz9mILJNvci/bvoNa
0RP1SV6wc5DLA/LLG2eKppfslABE4WYwQWaY98RTca2YtQQHGEpuYb7c6doE3l4I
JRaFXJgAbqWt18K5UBNSxcmUhewYTaHqUvjBtQ+zA+PKAZ7Se7cOb0KHsC9E+VIE
7yrurMBxIoY9SJWKadF1LRgHpcKuimZvnN6orcb8J0bsWxWvSt95206h7nVPRmie
HTrjII8Hx4N3chGL7OrfgkpyURhvMipMu+V/kVy6UDgV/+sc+uP+Lz82PWY8Kty8
nqw2zW0o38tZCuadI2QusCy5s5P8SYFFvHbVIgcCxKwqijuk/xFe0MwUMRh0mNnv
PMCmEGp8CEKzNATdV70/MNJzxguk/8Uat3jykbnXcG+wIdFDl9QytThPtRjHnFDN
9ziMzWyvcf/RBMz3qpWTOH7qAkbOLJ9dR7ytjkIDE37l3zoT0bEIoeIWR6nXCtIF
a/y5JQjCxL+YbrTek8YbbwOl6GR2JATXqj9uHQexLjcMwR2j+8zpc7k7W+C/3rFv
J/3kdF1Noye9rZoXqGyniiP35zVMKzzKq5io7atA+GBvbSCj56P3Igr2SnOaWDxj
DPhjNjae5ynOmZZaYq3ejN25VIOATS5Lcki4M2YRjxfb5X2gIvy5DfH1WZ2sCIx2
P2T/AXkDs4ElCZWWrM3OspR1Wr053XaixZoe4o4zpX8WoVyQQ9pBn0sptDV/KLbO
0S5LlC0SIoEzUNWxSrL7j9EqYIkPTyJird0cV0/SQ77wbHUamQdF0sY7ERer+jhK
Lfxxo1wDwNnmTQ4FmKsTL3253sPR1ExsBWhMXkpbVv7sGoYKALkKxx99XFlNoB5K
z5MSajSO8/KCW/gHC9rqcXzpMteAACKi1lICfxTzxx4yFtv1BnkMcivbR7m2m6Dn
zCV6kRoshW2rIDEeVN/70l+/vrPqArdnvvr4F48NGdYy8y24L1wdoeJ4gE5aUsJG
LNQuLgBYQamRjGPypsLSctTiKsi/PAqHhUL1SFsahf+3IM6OX4NPpnfe6SUP36BE
QY0tmH7p8JoBufbN61CMONRUUDH3Nn66GeIYuFsg5QkcpaJ2giO/ykQvULtgqwlB
gawZIN/F6+nbMYy4Sqcv3IM41mfyTlPqFZSXSHHaEkt1MPx4o3G1c10KK9IVVYgU
PfY3EzbsQgdSH1i6ZZhc30oi7aPZ90f/4crOq3GQiHaNgqP/yujss54qWcgG3Epg
TSn9cW2TyHbHCcCg+2KsmbU1xe1tNnl8CeOhQvG1oyfLuD5qCDUmamqT1hIc3DRE
EszH0csALcQjg+ashbcCl7sZdC8MaU/mGlw0g0iqaaQBiLi1/6bpPSIodMsB++FX
3znGecjiYYNCKuD0kQkqXY+V7B+SVNNrDHp4XVNxEHqIzJ7GKRlNZ+dNckpEVUMQ
r6ZYAyTi1lnPnMoeMkGZ3qiXu9WcECnth+GcV77E9emzRWJQV9JLhLe3xyEbjnDV
P5Ki36Jaih8OhsUGiepuGhBsUZBMWagMc62e9Z2CBGyLZGs/beZgk1eQrE7ZAolx
vgby24eNXgOUHnDF7Hp0mdn3bh72Qbnv6+vUdMDB8xKj/1ZA2u7PGsSrzqYDYToa
SW5SaTboAUijssrRMs2DPGStVUx9QI/kikaRyzPC7fBn5XfJkM8s3ne8gnjCMn24
00AoXwWD86MQcEwqwUMYJRRs7BlMi3iJ1FvZyRzWT5hznoR9tVQ2HGsc7ZB85P58
3PExBONtHnZ1O5dPi5x5wgyyeywz5gs26QNPXsN7qZqoTR1S24KxlHglRXNVum9u
AvdqO/DIzBlRD+TKlle/yeauW1Ayt9qaLgGFXlaFRYIcfMq0Qy/iYEbtRg3KvFbG
3L2ia8M1yMSedrXFeky3oE5lklGan1j5qYl2VRG2idAlMlOMAquu9IX6njtvsbeg
vueLnz6O2IAbVIBpBnWKdvA02nhVBFKBSqE02ms7apHtbntCZDz59CQ9zfgEBGu2
oPcxA6wQ6YDNgoL747LChVAU5bZgiHyhrJuxaPnRyGQ2Dpgr6xf5H8udOdCXWMDT
Vj5c1/ni4HKRoE/Yf7bc1WlDYd//L1KPiCiMXlG8bljMbBzWa/q81Ht167zdTGg7
TWKj/gTw//9BU7qdgW3LlhaIKlj5LN8ryf7smY1FlYoixttYZVig95aW+e/gw/Q1
Yfqq4GN+cdhkbac9cvCEWEX2UbfsIRlaz56X8p+zNKIoWu3kZVcdcNnoei2XzMuP
UF6lySWbcpvHqSOJgE+2tTjyCmpZNHJbpQuwIYnESkCOwutw8ZyTGoULw4YO8vWQ
QzCYZRTASfAS+XNj0lXIJaloY+VltaQO/EV0FPw3d/hHn4OyszgmClMd39xVVeFh
S29eJrX6rD7fjDJrCgDBmAAqApc02zUPNekYePSPPk7eOJksvzwPkIkhk3BA2mm1
z/Mw3tXe82sFGFrfoiJTpYDsbaRtifjvJN3RBEE6X2bo8yLYOGrbGA7XVbNmgbuS
Qrnc3fb+H+DWDSP3rRSPu1sVZcfq7OZhAhfxEXS+yfKU8gq10PIHzm5Oqrm4Ii4E
I8v3WGKupRlEmA3diI/35vmuz26SXkWgKjCYzN9RVTuVtZvo22P4TWDUjOCh8f1G
TBCLuRYI5T+6NUgfSqQwAErUwxncEIGpuF9ycGKl8sWEdZzxviavQvFekjpqvqpr
aZJ0O/P2Gm8ZRSIH1eQTXbG3Zn47A+tWSvO5G76Qs2UR4j82fJTqlCtdG6lpaIZ4
wjUtVcUWQFVstxbiUDFCed56epj7LL7mgSz13ZG00inkBTGO1emceS64PgSgeYl3
dzknpb5NqQqHnrAYjemQtbekKdlgjU9NjF6Am7b9i89tqFr8r6ZcyXvdjetZ1wIG
ookHorvfbunPbPnrHl1yVmLkG1KbAKO5JUDfThhaVrMOFhHXgW4RGjJYtnLhhvXX
LvPvfr3Oo4ZD7OIEDOeOm3xnar5JMdl1n/tP8VXfxtOiNxkhOUf8DE6/yYiZ1QcU
XKiOFu0Yvz3KRebU7u5uqFcGp99pWAoeVDd4Nwu26f1m6r/hf/OB7kltoQoETkJK
iooF0jWn3xsIgS+7+cFdFmyebejlmFS5jzs2Zt6kWh88Jtreitsq3tK0n96DPC3X
GWauT0H4b9rQRDubNc1mup/S/6u8EWxn6i+DvhIBJvktTRShqeClOPRSGMMh4g5X
c4SG7IyfiAg/vdTbechmNfU0RjgfaoSXzu+dPCjFTx05eZ2xBB0ddL1yFeE/73MI
TtCQc63Je4w+4ggthSDH5B8JoQBUB88IqMAWOzBUnV971JGvRjn/OvqZEluqIje2
RsW9/Se89Lesr8aAAZjzDKtmQtUH1xRfnEiEtNikECeV1rIIHzTZihXEa0pXeqTW
QH8ums4ASmxijiOdqr+o/VjzaFWxzZENZIhFYl/DTCPqkyx8TMrvsmOC0P4Rxscr
xMczPPAA8brWNOvtE4JjDHXoXct5vImuPH8+/PTop+9+rYqncRkeZuo+wjdqY2wn
s0edXeSnRnORTPfjH4SfxXmXyer2LY2mgUWpZodS09Jb7h1kNGn7FT0o7vCAmy/1
HQqPl6hpdlVTqKg4pFnsTef8rHth8KKkwayTGnBqYtR5hjWZgLyRQfc04inxC52L
5HajLvRZjYDgrL073kcbNbYvZlClAW/Xbo7JYT9bt3PKlQo/NNXq1r0CiyHNQwks
GEKlB96zdXPdYZAUv5+mMHNcXNDKoJfAOzxw0WSQyDBEtBeGfZKxc2ap2bxduRhn
08zfZiSz9yMIxAAUe0Yubid0w/9zLNdEvsWfBKiUlSDnTI8aW0yJk4Z4XX+nxEvb
yyU6RZj3wzNvsp1zzvp7HZcbgI8f3FAXGoJbCeOUkiYcg1gSnSVL1lKSRCiT9urr
dVtn/4xzy5KYDyWDoQ69O3jQ1fa6ffMVLKw+0Hmlx9SRLOqN0m6G6FGq+zMrI6YE
tf2Vg6wSHrC/+5+lFMP8vNV/Hyfkx+0bPqtidNn9YsrQ/gSc0elSmC+O809IM5ID
UnAqGHa7lRee5X0noXcVce/7Zvcs6QBwRjk+8u/sZdSheSGFS5kWt+CtWGDlj4y9
AV8ZWAlFilDdkSkCPZjpsOlhjFioYAAzcIuypMm2h+E4NvucSlpjJNG7YQBLlFVF
boeofhX3T1wARM+HPfsnh2rvJz6h470WNom+2hs3WBD1anoqt9VGkaDCSMk5H9Xn
dCb5WXjc8swM8Sa0oxq1UK4v/ZPoXx8BxWwYkf6qyIuIHFiZjmpLcg3HoYrkD5jv
bjm7B9siLjaoWOxOCsr54goeX72b+4cxhDuXKLPsNKRmSm3KBdFyB0xvgJgOyowg
4gbdZgCu4clzr+LiCNX3vbwDOGx4tBlKy1ZysQfob+od0sk3jCGJD24V0Jod7GJr
vtNiuk7IXCYnXa9/BzcT+HdUUjRu0uwW8E1/HP0SSPXv74AfyKZr3PyNgsLCRBmd
N6rdau/Frw9mbAwMRX/WlpkYIpfj9q245OObjre7yUQ+0hKsM9pnvB4OI+9Cl5fi
JVAT35YK+gyXee+WXFd1F87qtn1vkvrniD/EQrpIP2+OfmAjuDd2/a/faQlhnLiw
iaLz6KGf0VK8yodzNHC56pT7mu0qRQ7EOmL2Pf/yoc6R8oaUraQVjawNoBjdHSJL
+0qadQvdw9h8p0ZTS2+8WrvMQhgStsJP9dJdBghYfSG2bWG7uYFxLF8kwhbbt/cm
/dVJaRG8CWlFW7Ad0Lvle97jZJVPq22eeiaMQnkPEyLGuFb/z4p2QroDt79N3SF+
tyolqjKIwr/R73XXLhlIRMtUyMjrJVgIpuC29gHEEblYDZVszbwhyTHl8MwWdtFF
JMem74nLzzsPJik8SIO8YznzxywoL5M2a6nqYuvYQl2Bc3m7dIE9csWlDD2/Fn6g
Nn6ga7EkY/J5Lv8Shevw6k8DiQSD4gaVXSjqawco1qkPsaomsOIUG006Wmw2H/0S
FK5lHFow0svGPHJgcUAt+FQeFJPsZUiXVtjWeEFLblWgi3UPwcHWkwo+hp9AdSSx
Ll2oO0MD6Y2meD9jRoehoL381cwDdf6pwtKfUdX1Ms5nwcXQBzVJuoKFchfE+/ID
7I+MI0Av11Y0ULWg/nMNc42Uz88rj9eIdSGi+DOOy9mNktffwc045KNpfyjd99bz
WMULeC5aFV5JGk5d3vbxTcx+hwiVK42LiNjLsRl5zMCqwTP+0FzKzy7juPqjBQdm
3IghNXgvFqNCv/1cps1hcBGzwxmRMaSZXYYVuf6j3KHtuReogDmL7G5DVjVK1Xib
csCFvy8lVYtveRAQemGK7DCaSog2cxBz8iMwQIqpIr/MmUdaLSH5mVY9wn0xAZpp
gNcscUgYCqe7s1R63nmxw3kgiGwi5TPJ+8k2FNjCqoE8SfwdBd8xX45tiYE3C3FL
lml4NlSjCUL/B4I6qEjCCcxT5sI4wzo3lDdDPsPaSGozlP1uHzlujd7VVgqb9Rpi
AXx9fZPU0R3h2exZ5z1shALIIzqtTeMLiXHVlkfGmuLdnx4q/iOw7h2JkQ4XUvNv
KjDxzYvs4ssR/08grdmTzM9U76t/7kxwYG1Rw7YiMoq2Miopa4M+Y5UEvSpDiWnc
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bp9YnNcI2RPdVTMWKe464TJE5WsFKK26cDFg7nlW7A4tCeFIRp3aeZUggJf7G/aH
oaRBNxTDgH1Mg+qXee8cUCl74bsexAemg8BidLqyrKR1O327fiqmSUgE1fpOoJDr
VCh2uO6NY7ioRUfkRzlyOp5VK8+6UAVMF6lUhyGKEik=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 195663    )
esuZVfyB2OyjfFqTz8VE09sMcFIudYC5o3I51SIH0sw6KJ1EsnDGrb6VgBdsDsX8
N2tYxSUB2UiF9GY4I0wXZSLxxlEYXWGvJAGCG2sBLrd1lF4nbkEnHdmMXqrSVly5
ZSYVIwxOgDhhrKy95kpzyrEo9qiVD1av0DPYObf4TzGTLpYZS7CxoemFGnXp0Lf+
pNvYUbgInXzg8Aq8iOOPf1og72jubsExUgFcYJim1Fw1blhiuIBT4VAYBRI9uM3n
`pragma protect end_protected
    //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QBql9gKhkAif+1WqRnlhla6WdYjqsaPr5Ug7WagdhXyWvcIYXCj70pKpFl1dGToA
b0Epb02aNQq5UcD6k7GEAhrT1lxLweNXm+5Dl0IxmsUMyQ96We5yPjJQ8GRYt7kd
35buFlItqr0TMJPcLUcbrFgMEHElRJ3OkLgC07kAbAI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 203868    )
/E0ssgft/3DHsX3Zlif1pb0VPUhvdOrqyCcSHTI4PWVFrulxKwDtlOmfpsQvQgps
Snzi+kjDnM06z0UMeXMHAg4TnXumW85zrYpYTdg7PuOIAfXObEByUWw+mC8/eRBR
ThjI/ggay5UyWk02qMTCZIQLOxM2BUe/8cLsXcx0u84/i0+SpMj+tgEz4J26Qbe3
3TeP8BlpKaapcvVEL/Er5gSqzbk2wCRwbXVB+e70I/dioyjzeuEz2p3fvsTTk1Ht
tfFfjRQwfQokRikHnfBSM+aJkJLWVrnDDtU7uqD4o9HV+sRNG/kzfLQMuTlJVnGC
RFqMyQ3ojjaGxDDAdf5iB8ieUOQWDnkypa+DmZ5ffpQ+uaCzWm+TV6PdtkzpgU80
DkbcFqFr7urbHpM/mRj8993EQa1swgI47Se2GisQaC8y8MUWoGCyrWw3cqkmMnX7
o9rHkyAjso1AtCuBADhhI6nT5zb/OT7M5YCsqXvqHhRfi6BK7fxG2cAKEWAqXpDn
mlLRsyl00/MIFo8HS8J8YpxFtTNuQm2vIC4gLAHcFW8M0D4Zuea8bZEvykCKmWCr
bmVYPm1KufYf2185GP4FI7SvvYRRpGEOO6ol1g/BouSCcSPG5XssYo6aVM8EzVSs
nyHyPfqed6SyAfcLdj2qUCd44RxTTIiqg9WQc86qg2cD+v9l+8nbD1HOQNEXYaYR
NACkK53TU8PDNcTg//h/rUKMpkTXfqSlvn2BlZQbSmHnldcrApNSi6pQzfGqhsqb
1JMVZ01KnjNyuJVH7M/Wc7OCQqhq4Lgl1tSn3+PLXsNldQMpLDwwVphdmwPO/x17
9DpS71gZsDUDLd0p1UYusZGa48o8eKfvi8Qy9Q113Jx0RdQ+GFe701CdFmiX00i6
Ak76YrYak3Gut7J8d4JLW6zkiRoBSUJoNP9P7PZ7Q5migJVqPyItKGQhEhs9udDn
cFVdSya2loDGjHTweCAJkGixadAdLSxMbbMGY5QZy+h80NG9msjD9EZfrZUqzirT
kSN+gE4MMcrkB/jSuGlKW14b/CQEk8Cx3RkBfvf+rKue4s4nIJLAoCGy+nPrD+kS
bP4jRUYoCD1ntDc0vMutGmNitKZud0SjrUouhQ+KXLXGcme3KiqzR+ESOHZAHQTr
xX4sDZD8DNc5561OGsp4J6UUm/11138SgL/EECIV7K3C/3LdvXw36qMwGwgMzZ23
YBnZm6AtmAqfreKKsjY1brlUOIP4E1VBRbZDfZdifTJ02/7GXQdQRH8kiiAKS8qH
q2V7txorOF/iUJdgAyIlKPH02p/DYFI6aisgWQsIhA+5ixFvkXFOtYT4rg1r61Ww
gdH6MuV9gKEP8q+VAIMIJ7fOROgX3ZZZvhCMIdCuvoVZOBtrjUqBshAaulDEkPCs
kCSSKapyoXE6GS48NAx8wCGNCrf++zTXVMtEQjcSmz7Z7C0MpycfuV9UQsnHoO/E
OSlKu+WFsqMK4HOCdfXF6T+gjI8fAHFy49Kt4TDMOOHLYmyb1ShKq79MfrYtc/Hx
ONIPJ3hXkO8Xn2vJWC6VREoYgCg3icJEW9xPMjPfV2A4P1hukhofujJMbw76n1GP
HVTdcjI4OVQjdO/iGZUpqp3pQfCwenpiusgO+GuoOH8GserclUDdT454eAlEotJi
2G+qLbzlpitRTsXWGJRifTBTpFX9ctOepfW5TEBPC7nRy1cXakkHZALaa5RoPXSL
IL/TvtMcq3WUGho3wg5PkCY4UNVq5U3ZnaZp2qarv/gnkT2cowAj9EeU1kdr1MOl
LepRkbWmnADbjEThoqoinz01CEygMeacjIe2Q8lLLK8w/v+xrV1ELz4HbB5yX74o
DW37+PeEvcidM12vHJZJ7VECaCljHhNqHkbeJ5fjiuNewAH3Bj6Zmni6cHHJcy6A
k1kC6Bl1gRvb0SgLJu3NCshrXi5hiZg7iwjb5m8ZmWbrmoT3e+L590Y6+j9pNZY3
230BaWLsbw3Ug3k4dQEKfr+L3ksZGXnifoQkxBVFKmjSSbUBaq2956GR5zZRPnDe
TnSOyA3qanRMna0xDg7GKfQs1kZjMb7GHjkClsVI7SZlhad1RYt1eNsr/xon4Dkf
k08+HF8SMyCtJLq950wsIiikptwWbMON585XqeAMCDKhc0b24JjYoQuMzF3KnBRC
dRt5Fof1R8beXmElpSem5EwB6A/vW4a9MmUJHEZn26PCixxVl6VLZ60EMZZXJPG+
oCxrOuG/Zj2dfjKIwjBR+jr+vGGFOCt56NKmRvmVw5DRE7J1qHkqJQV/pBOvOZNy
kKihkgQlb2Uz5UHaJh6qjtEsrkDw8ZbdRuu5ULQeoG/SSa5emf0mPtZny/pm90Hi
trWY5aWUM/A42VsUIIZH6IGScNQ5cyw0ZmJ65LssIxiIkdG5kzqZy01VkFurReft
Kv13IYgBKRxVvWf/hEKPZhYJsWvOmQABTL6kPUT6mVR8ycTLlbOnhC6+wGZl/lJi
R9F5ThxEdlXBmUyTAkjhXq6xEe+A6xJLB0O6pbCp5oDEbkGylptLdUvumltFWsNM
2y77WgJEkmLyBvFbRqY0E4Ln/rab/OaqaPBpN2UsKt7lqwIsbWtL9eaqMtplVflx
CdFDxMNFix2dLT4hR4y1uSzavmiTN+GlUh+yUawaigK6UlYvf1YfIvnkAgwQca5j
0Scw1mOPI6/9SY1rewY1rnyu65khcYkcqUjsIA6cBIB79x8bj0H55kW76qIZPprU
NXwl+j0mVhBt+N/iEwoIQeyKxN6k7S0ffg8ryv1kEVa7T081G16wZq1GNHHQ0s2Y
vKoh1q115vd/924xQhcnCxk4PtbSE8mnOIQTTqMKpxumeJwiP1XUsf/hI/8ZH0ej
c67uOKMLaOBbyS6oWJnk2jtRmJXBhwcc/NZRWSdM8nEOILYB96kGEUnmXJjlkud1
8hPG0AaLJcamLUcQLoF9rPTHPVR0cRfaQVTRrwIatpcP9GvU0ZQUnw4SUM8Ejmh2
1ScUd/+Xk3nx49L/d81Ezt5HtJkROA2ScrJ4X/cWznWZNkf6OnI0X9asmzjULGvk
rHQmuqMZ74bKh0buVEZH2lIX7Sr0oBhZBD2fwJgPhE87LsdRnaR92qxq6SCdlBrB
h6XB+HkwLkcuU3tTjXgLGTnCSuKpAWHC4+WX7jzxGp1ij3dRydvMnHqoj/QwRyxv
GXkDa48mi2HtI7vx3vVr6tIkxhT/beltRdXX+7MR1jtPPiAEvbo9y2rXdCTJYBBw
AHmhGPDzeNKDAVWPdH76nh/cUwmUYm/8OrD08j86+EMNeW/n3Zk4cQpCVzwiU1JN
Ea8Oby6OVWc8Mg2VO2p8YfY2FHZmcfPJlbpCEf/GxssrhToRPxcRkUgE2jT2qM6Q
wv3wVSWK9qnxJA4BebyhNyw0ZSIajo0FLk4I7IMlKHnQ/qlmO5GGlSlMKUMwWKG9
rM33OUqf77zmOTteieHweL6AIU/GbS2PXupHZRSJ8wJvmg+bBElkdwtWN6lSM93e
BKgxkybmvj9evuCUcEN2CFZGPlmv2e5q81R5NZ1PTvYYUpwj6DS18eKfQLPH6qMG
Y/62YYT5geZsdDrw7zshowstSwrbA2LNVfrF00nF+FzkrpwLLYruhkz31n4vlCU+
or15UmOj4gkdjP3DQf0mqFgCRJn2AgGY932aCOszi8oRI87A+YhXsA0zplRsEc/E
0srE18WVcPJIagn+9314aPZt0UyPlIaxqVK2+W3Au5QztrD6KS/8U0ibRNNBsbxN
UIYhOVP7/NbnebFByB+wVTpPwETAesk5gS/ZsySQS1sv950tk/KFeJPpWqyUVP9Z
6IJCQ6LCHo94/LPpeOsxzym1Uy4nTA58oCKkKTg7SRBhZAka8cKLIefnYPLrA+g7
Rk0DAYNHs4IloR/YY93tDt8mtpm7VtjHsi+7CBfP6FHxeECwzeBkhYnyQNOJ3aRn
YMFwB1iwZJs4onyAKaWiisODH3OXvPiau1RATZnodgSsspjr5yn5rMnowxWtytlc
ep028wZm4dF5W5OIato1U8eTiXkA+ji+c8CTuZsHOmt+HAJCZNl3OYZaBmsD8a9w
ms0eOY9IAdHzNoImfPYFg6lIzTrqNNPVrmK+CHV0mIZ+Zob1BFqyYYwsqN0qxlji
wPz2DYEN07AwyI+p4+0F+G+19+i8VyHRBMrcAlV9AqaXFVdY7eZO2fgYkeKq3Ks1
eRhLgf1VpBQaP4v+ZG98JaKf3Up2Th4z4pJ5GJPqFG0kRlfdYYMLKFEFdUVly8vO
y4J2KUChvu6/xKvDHSgYc+NhVUJKPsSd+yLVntMR1XW/90wceGmVUrUxPShWuanG
NmMz6h6Rk0Dp/G6e2uq6dausS97HXp1TzIUMibeUP7d40dp0VudbQgg6YyMZBthO
2nTdBDuXHcbmYO+kTA/WxWUnwxEW1MryIyMqMC4U0mr6BGoQtCtrmR+YFlgCAaRs
cIRZbwuWNcnvxPrliNsm4g2vVlnXBhC8I4xplY2MwM+Du45FjbFPZzj9h6yU0HvC
PWg4IeJ9efORp7381CtA5++q5J9yIocti4JuXsU26OI5RNT7K7bWWXpywFfIteuN
iPYBYRKAhOsNJZ2gYkFgYCAtH8L75/VhNR3FqKF7B9wHzkULbNEiMVpcTkUv2Vvi
YlpvMcw7HoGgpSUT04k+1M4ACriT6Y6qDrYV1dLliq1eDtD4BbhFc5xeHBZsjmUv
c30ma9txZTa/1Z68SbNtgomotAYk2D0Pa1qOHmgk7oTbt8t6yzFOPUOiMn4Dmwun
NJYeO40jkcgxO2sWRok/W7h0F34LMne8hjg165CaKgsRrdgMYNvpuoeyBuaXb6BF
YPgZ6djCrrvEJ57J5bH/im3kHJlYxwaGZ1fgXIFRcYt59XxAOVzEkiaOCFC3Nkoo
ez9aSVLnUaxH+3bLik8vbuMDQMSGRhWoE7IGzJoaiX0gB0nEWwIirJaAo/Gcz4Am
bnXqBDPENYC3Tgv1gPxaZ2ueox8kEgySLuHeeTzHhSREGzSd2dXO441We+rh8B7Y
mLo+76lBNtrqmF7VoOXTNoFOJ5R0Lxzn3fWLYG/lcSuFpzgoBGkM748rNlDjQKfp
3Z0OritG1dYEz9A1GAL+DTSYAnmeCbev5SChzFuBB78pbFRTz4R9O+5yUPjZR0EK
oUPItBdPMSzieQWUK2erL0rmW2SJB5D6vf501VyAjO9y7Vqb2u46d4KM9236ObMn
qUdQAcVfIb9wmAwBq4wMgy4z4rJCVNqdr8soV3hIebrv0Spk666qrDHykhCSgQOZ
KGm2VzV93dHVLQEHe54XTqT5CYg6LAgp6WGbLfjInr72j8nTBzqLCqdimBQVLeg+
vyXfRf0MiFh8q9yoSbFgo0kY6u9GNooe0zVnvcMs7/hDz9pN/yObNbqRtY/2zaOM
ud7PR6jhbJmx7e6o0dYT9rhYz5Y0y5qeRj/laO8oVhkA3r4CtKUmrZXKdAhs7ztk
e6H9ejf7hcguuTZodzFAjNnMn8pusFWe2SPE83Vz+mloLp9pY1nGQpB6tVZgNZCR
h1IL/qvGwRI/IrXSNsoyTB0d0SJfx80sQ5Pe+pHVbTKB9RYIuDsY/A8ZWLGB5dSr
yIPdVRCc9T+LCdS9xtAhFqZjczAXmfhLsauQXYmVSthXaPUqmdSWJZgd+0w2tN0z
adIBAHI6r7cckHCN9iTMd1MUSThPtCF45x+iVfmcQV8aBoja1/NDFwwG6UGKiWAs
O3ei0Rdli/Ukw8/tRu8Z7+V63bPfNr+vP6HwPMOdDOs7cDBhijGj7ORGqbgv0ahp
wjrjTM58O3YoKrV1LMqYtoS5WrQTOYJqNtZuK0Kv0bBB1Vr2pFqZWcw4yGoNWx7H
sesJ4EFO+Gw9KxuGB6ii4ie/Z4yZMCST/d9iNpDhT6GQL4XYpfCdsfZjny8lZITC
om1IEQKjnrDLHnkqL2HkOP3JOP1NieoHtCOlpwdQ6rCUqpLtWTtMUSYMJAmMV7yd
cpDsACWIB7SmvlsxIMIEHrcmZnUB3LPeHTCKnbtR3EH+5xiyoT0XiT5yV5lQ8ZfJ
sl8cjavedNfnVW4GnfnE8n5aU1mAU3JKk75SEWVn0QDvBYUTz/z25KT1eXnjEl20
N8RNw87s085lAax9lTa5f80c2yLHN1St3vCYXaavQH3kDVVeM3PKafM7oGqMzcOq
2hsPbZ3tCZH/UY35mYUWQQJ441NYlxbI8yeiipJ3xqF1DKi/bEDbdm2LXPx4wL9s
P/63xnG7DMtnKoCyE1l9sHY95D1YZ8Q/J2EbgugwiXASzR+GbRf3+xIgr0T0vqgR
YSHa3FuRZfDsxralBcCWX+4J3IJ/tfsfZdI+uYMaDJY3Uk/mo30uBUAlR3tD16PK
8sNSDJFMnWeiR/jXCZ912tH9ndxKgendfO5ft5L/Z5rQ2ll5h9XAP39msiLl7Nzj
BV92MRxy5sc0x+ExSaTJxS96i+sw32OwzM38DpSyJpHG0F83ozQjWtTKs+meY1sT
cmz8+W9zWWDHGrN1Rg4EXzgfJ2E6nDu19k7PMXF0K+M68Xihym0FFaEVF0yMe+zW
XzLShjN3op7sdiJ/6NmI6CxRxr/8PERB/1H6vIiv66qibhBV/rutDOz6+umOxSJF
i7BEe6QEBh04FEl1qSBO0X5OqGx1YwgwzQVjLqaOdTgouIXTJMcs6OafwYUdX98t
7bMARGGD0RkGW4YUEXgFstUfWMzFww5iVENr+7qHRQD11G42RMFeimxIfLx6Y19b
0Qm4XImKbPDvmt+qNcgjznL/SRVx9lQIVCvO4d3MgA2NYFPUsSvwvWJ0BgrB0cVa
V6l6wR8UABs0yUNKYRKadujqXbObpKm4zUJLTvR+AZxr44b9BbPrVXxNKnbKZ1Xj
7dK32aSpqoK36m27fVyEp1P885zYGuoYNY9qjFdL98aMGEmR/JDZGPny2eeA2iuh
PzZdarsocemokHGmDU22f/TETVqgy9p9eJRs7jeAeQMdy0FByQy1LQyRMaFq7fCB
IzpwJW8st52sgBzj8fHjCQ98aWhkiNB5Sq3Lat8q9BU/Tz0iZ6pe5se9sjVNddWt
zoz+hRuG8KEcKztnzut4UgBOFpD6XqoZ2wSKeasNMnmNE29x/p/X55KKc4KrCs93
tl5HXSRdKZ2RstTdMKCImp1rYYvqkfrO66opgBAPnNkrFeT/6o/fjt/YtXO3vXoU
tyqnZqXMxSsj5g6cHYMjNuaD3qdbNJ4go7OR0g8yHoiZyniGeOfqDqVPnPsXgjbg
fzRBtR8ureidwUow0iaZ3F/uOcSbP6usBbUElKqXZxvDzAMSXDdUpRB61b95u/im
w0t8qxsvnbAGaKOzY2GnDXwWQEIGaWGwY1Ss4O1VteZPbulyuh8FBZUSHKAxDeSQ
34Ez5m68F1eYlQXMbTQNfRugtm2TpsCs3fAkFALfNaCTw/pbgzM7YHFpqtcY8/4T
q33z7Vc6ve4g15UZU8SvfXG+6GgnEC3F3w8rsvcNfzSeH5t7JVs2apzC6ZkehGiD
DLZ4Au/b9mSW8PCvQYJjtUeUQTVVxpT0vt5q7mdLq7Mr1tRxfaIo/nC6sTfG8PmF
RazU0UXP5A4W5eosLgxwNS2YsGhRTNIIHMIHG+Bu+mz2j/YyA3GRz8rz7ABprgMx
xf5eN5iU2UY4QS2URSrR6efAN5EvGN1j/uhDNQhqzeLynB08LuYiRdWEQUbiJObh
mgwj45vlMtlL6j+8Ubc8kCYuet/4k9PzDm5mIkQDDNUz6p5SxV8NgM4ABAp/FbQJ
ILTakAxqXjqjcl7Ulgq92MvKCisilZZhEthQ47vkAiw0PIuKghCwNzkubBSSIKTI
qRDWySsbNiWSSKWAhVo1/mFJxkZ39vSYtiRs1aDeWyQ7Ek66HvlVksZFDydwkvn9
aDKS59pMC0ByQ1ifw02uUF0vsaoB0dLthSlukkxEW9/VNh3cZI4o5SYBwLb/IHRy
yygNFYTSTIzm7jfI8oyL1MBqwzGDrUMh07p4f6ubRnEZfajyrywNDaMzf/oOCYdF
1SQM2W2hL96bIDDR8w1VzaBHsSN6xDlbgseCjWmE3acQz5C1YvPJqT72cc+s59vM
cRm/AemRPvJyF5Ic9RW+iQd7XHe8CXgn3YNayebWDO8U+ArLqqj2KMHREVMxzd9B
4QVn0CpvezLmIZZ+tEWAugwYdbif7vhF1KEHS6L40pZApV9mDU8tGAagmw7mdO4e
F9ABUThgBkzsmudGhbIDU0aGNeHkz+gh60gpbOZySwhTyaxHnsxm9KZvnwzHzQnW
6D5lXLCGwuxFcMJlTb8AZy8PI6LoG/IW66igIDWMLG9Rk+ljI0QJzmuvTrNl57Xf
DUrtx/K5kxB4TaBdtkq0bAPS9LcIYSiGXtvJqpk2z2PXkTGb76faO0VnGuVNwf3n
B2yf03BWKDvb+oITLhdes1ntnhI5JQlaiDx7LhwyxHatlBoNpNDEz4weePSP3g5n
BSaFSXibfssqGzdvYJPWKyErkp4Nm2bPSjTLv3Q9jRc+whdApgoq5hdscgd7wnNE
Jv+PguzpXImJ6bNBReco7ObTuyOQUw4d+CyVdrcc4GYU+6DqDRbPLtk3B0f6Mk1g
SwXvvs6shuKb1BtgFeOw8UeKASN05pHqI0SA4DcooiN4rCFrSrNPN8qwobbPSv+f
PEV0DO7rRLZpKaRYMzeQNcUE8xOYcYp6fZ93v0hnZEIXCjjtFTEA4SGShkxI8AA0
oS4tpTuRNEhn5W02Chz8L+ggcFmDTz4imoGsNCpRqn/i/THCQlPUUrTCnn7bIkxL
2X2Bz1rGdT6TA1rWPXkUD8B/HaPdP63lSjm1u42CQwNjqFAB8J4TkT+U//mHIPsz
i5K8+Ld4EERBBBkjtH+vLj5pux70bDr/H66jMJ41VdvXvxa1BXu9c0WpRruuj6K5
zu9bO6OvvtF8J71MLxWssHPPLpSoiazrERL9osd1sWYZsj12EP7VI6oeFCjlm5sw
IQiFjnpBMNaztxp4WVoV/4dA0Cdn9PjfCM9mM2Kc+MGRq8N15aruIyCN5kjmIgha
yJ9SNEfXzN7c5noBb06lndBZ51PfJMuZOU7vNTq673C16SXqc/WMjVFNF4t/AagS
GDu1426ii96zJeUVZyAgBgzC60lTIQBr7nu32NiHN2vaGMKJ6zXdVHBVCHfGOzUg
q6j+CD0rxLQFcwPNrpIkX08NQdtCkZJG+2FlVC9B0L0YJYaZD+HjoZXN3iQzZeMc
9s96fHbNMIZZSRN5Xaz1R5uhp707asJPG3w+tgr2XgpamZ76pirqPzGwchotlsC6
O+U6EIXRthLUG/KzP/XGs7gWT127sKz/kq7WEMuXivJm37nI+OxR0adZUZvQ/5Gv
F9KSIlrlbC8fksHmU/yVyFNlOOEAC9qcv5TU9symAmRFaHbLf30AQexqDxHYreap
ws33aNxjpIYsV7CAGJtl+kMzyv+FffCehSyOOW59LdqXl6bVAkWJJzUSmenzQAWK
61+jEGkoBcwPXd9ik14Gn/wxw5UrySnA1Mu6WP/32oEOtI14KxQ53UHkg0ASamWq
H+X4FI853qwyHL2LSv5aERnPPGAv0Wl9e7TZvzL8enXUqhKJ2i9AqTgBHI/JGItf
toJWEpCgUvdjJMSn/XsnAfRSfnXKZjtwW/DfOBhhTSbvfUXHIJv9R+giHcQ90tMs
X2O9+2cd1KVzp+MZsgcgZ0hmo+Whz97Y+nlIh7uQTW8TtDR9TUIV93BBfIGk2ar4
o3GNwIEujXi9kaESWv0WGTl9bNo/5ALHqVkbPbmLzI7V0RZifLNwZwdPgQniC8vQ
MJ3IjAWux/clVTTLC+VbgEr3QKAzRFGJHpgzWCCKoZ+dDqAfE70rx6KF8c4+0jIv
aG7hTv84hr4odJL1YDB0B6IPMw39V4snStRAlcAER6KoGDdjdTPj+pFrSVoZm1dp
rfLMMNObj0wRC/MRWnDAW85uUmRyWQvdJZ9Uyqpd9FyyhEm4HXCXWyu3PNRVKbJh
4wBh7+sZWqXVfSH/AT5DFAKvbVx9S1YTe+suHTlL6GgJQCamm/8CZYpeSgBWpFa8
Z2KepmLlm+eB00VJC6oJF0PPtxBy8ctx5xwCQCsXqP4SrEBgZw5JgZwfavU5b98V
WktIHKYceJf8f4yA10P7RlyG/B3DaY5mEcU8876igNc73Ph27FcMcBB3bCPwl1Tg
y77XPGCo15SlgZz2lBTNic7vjpoqalVc1HMB7KkeUk3ZkkZvdrD1q6XQRZ7U7YOb
nWFJK1FPZObVbo7KBKmfdpWDHtaXQMx90L53ayDihlvbw8rh7Medd+BI5F3C2V50
7GTaDyIOQJ5LKS0miQiFRLIi/djJkg9DwcXbtOJ+blY93f07G8Ed5rlZZITyfKpJ
EG0amglGHDo3zktNcbyP0DVctcDSh9kGoCji52Ym1e92gE1r1VjyqY2/0aRK3F+1
RDAdDIQ2A9ULXxdJuhuslM/hNnOht+OObiRBPpjJlFrwgm/BUetcKebcH9oL2M8O
/UBuD9LrjqLgZGJsj1oojbRTvUIaOhw8vcONT0QdW+6t5LRK4HdKBuvXTeAMXKs7
Ve8lH7w18h2fG/Uvh7E3V9hzxDwml3HkrTKB8QYD/Zo0D/n3Z/E0KVjlxj7ao48f
c/tlHlARd+Xty5kQ0bP6sDjlzFBnKP7gVy3glVwAPJXJRFj5ZCNqiXqhsVwZ+EP6
1/raOt/IrLQhLSIT8pqw8IYXsqAMrXyapptlbCdKKgd1tzecbXyaQLAtgDxtVwsU
sk2iXVkdFhUxLgOm+8fE83tp0C410WogdZ85ykGPObrFx9iTReYEZbpPv4r68wjs
GtfwgmnvZYXtez55eJ0MipUCqs4DkQhC7HZHUTjPS8e7gzb08kXa0yl5hxTfKxn6
`pragma protect end_protected


`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OuwOFotoLjH7okvDUQqP0yAXi+wff16daMM36vgivKdibNqLrKCjybDY/u6ouEFg
UZbm22JL+RZ3SmLsunnVLJm1J4SJZU95kahejfQY4jYESuHjluCST74+DFDL1UHr
z4yjXzfA+U4CJJdpo+CqLx2oULCa83BIGfiWaJ63DzE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 203951    )
3bQQ6036tV8AHzeGo1NgDe3jMO53pJKYbtpZo/6Xkqnk7iyfZsVwr1usau0+qJx4
eD38qO06d43oO0CBzV3hQvomZD56W6hOXkDS+mPh8jvvt7nb9C3HSVpEXSau0XYa
`pragma protect end_protected
