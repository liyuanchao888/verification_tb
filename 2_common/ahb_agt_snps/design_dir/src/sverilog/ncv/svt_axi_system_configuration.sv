
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rk7hG28k5QqxX37w+nH+ADcy0msvb+quHQUGxETzDTnt9Bv59KiVAifgqNFsoQoJ
SthODkBG0O2TmCiWUG0CnTqQAn/LcEkXS0QT/wdvXD9Jp46OHXJcwH0NeGCw8Cdm
1FrhpMch7pI5rLFf11vWTSSQKA2/N3tnUeDnzzz7o17pvI1iu5oafA==
//pragma protect end_key_block
//pragma protect digest_block
nNF37VErw1xjUbPYanjDZ6bLOLk=
//pragma protect end_digest_block
//pragma protect data_block
HfuGmBP60Y8pcHb/wci7ZB8LwmEGA9k/Db7pj1IkXpoZzxRvhmPZ/VBZgKIr+her
29htbkOJvkVw4hc3CIvEe+VGpGUsLfkvC6eDEA9D+QwQv3tuFMkn2dGtW0uXApuJ
40dCrAwqmS36hIVhqrC2zeZjeoKPykBFQFtKxW3MdhMASniY/oqmBHLqRSSFRxMs
VvMbkKPQNsgof+HWNB2VabupwqAs0V/Q4557+cQa8Sd8uXea5wnus0jOqulSJoq/
LPAldJo/fX7YlzdhmnOC0ZhfyKYWdoUzhS5NRADstz+HBeTzuKlLDwSj2KphtTTz
GEV6P9k1Cib9VkOGgETGj9STT7tC5Nrj+V/pz5clh0QJn7cOaUxAEDsUNVVP2saq
1M4jBFyQS+TCMw+CEkcl9ldyBoT1LByaZI9N440QnWfgK6US6XDmO1HfkfkLdj0o
6H0RBGxqLo3LxXceKROSojs+9qdjn4S+Z1+Oed+i1e0JNdfj/EarHXSArSP9Rqke
y80fM7+3Te3I2N8udnU9tpv47ZUtuRXAfCXcGlzILW0xxdBW8vE4mocJoXTM2eb7
vSlRFTb+8i+v9hwRA0BLvqyqQAjPbkNm45+f1sTbG+Mp7AxhKU5XRRXpDh6ZDYrJ
30Tmyc5kcnN0GzR3TEevDPga2hsIIMgZ5br0b57sAlikBrrEGIYk8Ja9l91iQYnu
C+n4vEqESyiS/Bvz0UJD4UYFjxs/abZFlxsDWZLRmZlWlitFynypM55Py+UZgPCx
KsBZNcm6i3XhHQ5XLHmNAUeAR8rZPL0FYtmhGGCpcptlHoD0OByEYWrX9SI8CgqN
+rOBL+7WKltK1/VF3K+50HAv0r6CmMw99IhtKgeVzPUeoL6W0fkprNsrPJg2c86n
q5xx8pU/JWXe7MGBlN3ceXxI+qxypI5lfM1q+Cugh8mKanI5sJpmUN6BfWN3TvPE

//pragma protect end_data_block
//pragma protect digest_block
NXkMnXNElh6ZVe81KOyE/uVHlQI=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1PUC6F1VRL+/Zjyac4s0uz0Ccnq6V8kXxQadYwKbFhpOxDMuCbbMsJFta8IexpbM
u0Cdh1G0RbeVjQ+N28QZiSMng1CK1FtEPUmIYP/EtKVuwAhj6r1WELbda5avZ6TO
0gP3bfsSnZwx7Mwk5mJGy4CRBh3lUUw9yX6tMwN6+B+DkZJcotNCrw==
//pragma protect end_key_block
//pragma protect digest_block
AELMfE+t39A1BhLoKSHmunuTJfg=
//pragma protect end_digest_block
//pragma protect data_block
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
6CO0eIVXbXKh7SQuXf/igw==
//pragma protect end_data_block
//pragma protect digest_block
3PlepUbYtOGzgH3K8hNWZrNK8jo=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BsxyF2y38Iozz64KnWcaPqn17DjrKzkT4PTUBUoXXQl1Kot1q1rMi0hY/TDsXcMz
yn3eMWrEWgO/uVg19ouaN7c1+zdGPCII2BGNHG1+WQAds8Q5cLDST1u4HnvBdBDM
h28BWMTtKge8YRlGqXBDr1PyMddk8inUVXvpOO/dljuw4V6ZaFE2Ew==
//pragma protect end_key_block
//pragma protect digest_block
HXLyhyh3ifEMTupZEN1iO/lvKFI=
//pragma protect end_digest_block
//pragma protect data_block
sY05ezZNybYepmBaumCIABkzqhEM5ynO5qlgTfttB8uVtyL8tUKbDi2TBmocDePx
dXwG92T7EY3Hf5yUwo51gT7zm4IOa/SXAGcjhScc+85/nUqJB/M1ckXE3CSDyHRD
PdvJY9t0p2Uz4OYDMVmM2gWpjH7fpOWz1kOgSMxaJfYRaAh8G5AwrfnU05/nIJFO
UZYLq+/gBcuPq39WQt4w1lVaBIkmwwB6q/f0FBYtW8uhVvTSadGrEvmJp/5Wz4K5
VegqbC1A9cI1VpAYFdKaVRMlP2ZCZqsyXWROfXomx2FPXDFiWoRStEgjbrYI+D2c
VGGQonYPJN2bta6IaAw127LMHz8heMu94cnBqvcE/gr9VjUHNnfqOjLoz/5zKEfr
s0q2hRW33Xq4nS1yBazeunjJ0E3aLazVQkAX5l63GJQZ1kddr9Vv5pxValSqHfxO
Mq44kdWINnDPkxPG5ciP1xC+n54KdVSAra1CVqZUn1kk8zk34sdIs/pGsKUxo0F2
H91bjZVCwXx+YJyoIDC+seWWj82Bjdc+Oi+p8a8DcR7sM1fCfdrhKphQeI+RIDff
ZEhKXFXZ3udmiNBpy3a8DtQx5mLweqbVei3xmR9ujyScTvVnRbTXTTqlsUsvUWYw
kC/+oeocZK4A65kwDQWyZaPvqLmnPff2sWYRYOsHBwL89xjV3RpJcCa7J/Ha7zyR
we1vHzpJd5X9AgNkmiwrMb1iAPCsYMSDMWZ7SOV8csO78whsK+/Ui9SdfNsby6kO
fbmpAyEIZCbBIVI1u8hQZoKFNvR7Crfi29TLGMTxO5QWnhIFP0QJUAsMDKLsdmp7
oT2NrS0VkdOBgYmf67GJePffUAQf/DKwu3remS6HIahpuNKaJoJ5WR9tnI8nxqeL
Ansuvdy2DlXMzVn9IPdiixxsA09QwYsn1MBS37ywnmQ=
//pragma protect end_data_block
//pragma protect digest_block
m0uNOvxKWjLWHWVGsW8foOlagYE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Tn9ZF+pvXLRok4YaDku2KuU2BIzJ9qtohaY1pnTAhLAkOoZvUxIWYPx222NPDUn7
7vtC3BwdvpgSWuRShgZyd8nnQJPQlrLuKONRMD1Tskb98cG8G3zQW5VHvgvLI5tz
CnQoA83MwlULrvnnOVP/8DE8js745fYAl/8IyCj+osk1sm3owrsqvQ==
//pragma protect end_key_block
//pragma protect digest_block
Q4xH5qeg/TkJCYsiRWD4PuWvdw0=
//pragma protect end_digest_block
//pragma protect data_block
2vrzta3EEx1q79D0rl5GU7HidwO7WPP91Va1BxRVwdQdTZosKKJR/1M7IVp9qJN3
8sVQyzGOBfCzrhe3puyaLOWJJ8RNnV3akxbREtUO7QcJfL5PusQ3h5gDl+1ZE6IR
QbpAOd2WnM2gkyWpR4OHvRZRVIk0iFLEeEsqzMvguXwtBNos8wCin7+nUL2q2fWO
VRlnNwtaZQa4BtUfpvbvyawcPj04lZlaowfAI3MkCFae7KTVO4wG4VLl86y88AdN
yFKztSSZbJrAgF2dsTQOHFQVOZH+GZpo+5C0GWrY3fwpf0RU67dkcqo9uvo3X1fs
5uJf0Fzdnq8yJeEf6VOqtVHz57JuW324Zk3imRnykEKv1xci4GjNyMkUp+5OKRb4
lqBz7JeLC8zAt0MsQibHUEGwXKA+yR8FsD7Tb4goNDa3FYsx89Empe9VnG2u9yJ4
BYksEXbIcX9xE1hBHhv4YtpT6qSsMKCtVnseCW24W1Ux+xRuqQBLZjf4R8njI8FM
0+Y648yYMt4tlolGbWCI96CEpdc4+Cu450iXs/I6yowMkl4J0gHjKZNka8rL/TiH
a6OwTUtyeKlKX6WzKxuHrFqHytPev2fMA7nSWBma2dZtJS60nGHHgDFoQWdMc6vr
Gs1T0Mr9vLoYL3eP6TnDUBbOuaukyK+5t9pgujjl8/8XA5kBGz4uBdhFvaZcBT7c
8ycU2rrA5yp8E1q5r3sZfxiRTdY2j0fzmOblzPaZMTINE5jYXakyag0K9zcQYuZK
eqU0584LUEF5SpebrHhRHCBhX4biTQH4XGCPFnE4dWshCe0udVxvL1h7+GxS19Xn
YH36LJblO2n+Cahea2wrsscOM1AoFfu+/jVqFplqpn085AguZrdAf4awj+3SbtBS
Vf6xLbjnAy7X2ctMBJ5m8+f/oloqkMCXQtvHNLFNhtgY6Y29y+vqhNb3P2Uegyq/
x1k600hX/Lf6LOn5wL7XSJOcEN7SVlPMMLmgdb1/waK9FyFQrGwuyFawyydi033I
GN+M65NYkaB56VU90IRAzYiGFI/jD+eY0l+M5mm5bqMvxY3+mXfQLMCwXDvXwn1X
a3E/Kuxebw2K8T1H+Mtoxws+pLj/ZZihz1SnW7SlGyIL8W6SfBthHAcwQ2qUTDNp
eCaIYKOJayAKkvXlO39Q2ZWVqVsMroDoHJf0WL9QvXqZscEepQ6Ix5d3HKyIFbk9
oUF3CAySVQOyirvvlwZHHyiSiruQrZcQ8u53PRrzLuGt8YcTQY/Qzg5RTo1QUnat
mwSTrRbvIbR3HGnqLmHGcl0YlFQyM5o8ZJ2JG8bXF3VkXlGWc4k2jgzUMQ9FEPeP
woTfbKHQ2mmwkV1ETBxBAIpp2px/Q7wBZP8QnQfcDmu7ahcrxsOilJtJYG9OUjmR
ROmyO+CCmE8ayHIRBEBRUKubmXPKpNpbFd1aOmx+9zX1dwOc9jC1VfHlbMO/yjFR
lYUYdUMvfixvamRnWthLn6x7yZB08u+oEcF8JOT5l8tEylRI/arfwpaUa21xXKLI
ADjcm2JK3DOwFWpDR0znOhxFj906eI7qb/pwK80AOnZzUNJMn8gMplHVEX6C+vy/
HOlknTuDDpsdDVTtOjqpcclYbnaXqXsiPOdi+DBO5AvgYgYolnKIOTeCVArg+x7Z
iDXGKtkqlDenai/DUQzkdji2OTghYiIf6a2WCyDZJffRtFtzgYkIOehS5GOoUb2s
Ps4hAdMFzIhJ666SVaHW4qVEiOqgdiwZzREqewEQhyLGluMu7hhb2msjaKq2BFhd
8rjUTM6AtE/wdTCQStCZK6yXfA8mtZ8ZkKKPJxfZjq2lSy8OV/WoEay1yntE2Gwm
GcNQxK6eeTYaN459XYoyrz1pLmq9b3ooUCyoW4RHz+bYkPIaUfwBXO7E5eqpDlj/
9Zwhwlq5m+kYSm54DLK174pr2+4lVVrIlYVYCANPy4KyJpF+w6YJpj7cjRJlgks9
v5C+RKl6GPF31VJt+oOHM63f5ow4tjggKOSXQQE/Y0ZiuQ4L4nt+894ZLN7QizNW
Sapn2QuZIN6oikkc1svXBcAs0y5EIto9q5ya96x3ceo1SktzcCx4XqwjhJByZV4z
uGwwTe8iB3CKcoFUirOC+KCga0VBYbmsUaF/XdoE1KJoMsR51dbJ0WXXJIQnYCEq
gCVWpA8p4wQPqzAyx+0WbGeZAOedRj6ijjlOGzlh1bOYpMhFQdx/g5EfPmVLBbcX
bx34n0r+rdL6seXYFFs9HSv2REQO+hws645KXSlLL2N01on913+X46ATxjiI3TCV
LETCSooW3lldrzPj34JMZF+i9OF0bcpIEoxEHbSznsBSy56ii8jiDUlqamRIKaw8
wfqHMO53cgYMrSIDr93mFxpGezHclVOjx2/q1gNmo7wsfSC2NzUZNt/punvl0elp
PhMELVEsS02iMqZkYtWRJdHUi7VepqWRco/9Hku5JYo/6ja0+7tc9N4E5f2MdZzB
s3bz5QFOP9OkficMJ6eKEHz6zcyUXpLnZMg4IDX+Mn0kt48DQFrijDgsMjQnkKfd
nJj6tk31WGNJ+8tI346p4dvHPV96cQcdJ4nPTb0533ryAL2xNLOwji79SKuxKinb
/QZUsSXTEwollad/jkKQdbMV6uGCAnVwoPWRQe4CZp2MgI5ccfkhEwogJfp1LuI4
8eDwojsNXk70DfTLcSDzP8k9JZohnz6JDKH0Di8uuluzHYWtjeSq+cLFs74bvimz
BsgshMy6Y1F00a8aly8c0OyQoxKrr7yWemEYxVfT9jQe6bpIovAuOxAnG/35pKSg
8kncLx2piNv4OH8StfTLcSw7sP2naSuYJvb9DYMf196S4u4cENjVngE1zbo4UWFq
0r7+TtFNQO9ImZs5HPYN3ENxScPu0xfYQvAvMeYWqbHxJFRxZeDXvUhOSVMXvVSn
IsruYQCGP3nvAVW1uwSonScXgBFwaM+DDLmIVyBXLEL1qWnpUVZx4l7ltPPCTS4q
ahdy3WE4A0EBd+x93jqD8ZxGckeQOa1uu2/w38qg7wg/btzABRsLbW50do6WCduL
+YMewgwgbzKEMSjV1byQBv7CAPCylThFBDjTo6yspGXFsvKA810DDfyYFCP9/Et+
BWD8kY3kzV5xxpXB5ZnQC3Q7NZXfRXg6B5WnPhfd9/7s19lw2jVg+PLSDoAOq/LK
dgzTewzSwVvceskdfIi8dVSuczjEHPyrAlD6sTproL6ErfPV/Xc/FFNvK2psXc39
lTkpoLSM78gqtuHhpMJfbeDI4YYjYxm54K18s38II6tjbLCfDovWFONH2xowQRyg
qIthcCdFYFwc5fE4fZOyOSjf7wtQj4w3zPsLz6GW2qamdzyhDumqYA2XggsmTXal
xWO95kykAfL2CBQH6bR/K2VPHj/6uMpwlB0BmYdPiIM8WCYK+CxcUlkTCdD31NWZ
VzANnXsPCfrwq31UQr68kkDXgI8xSKP6fIve97dT46LY50kYUCjO5PT0yzVH6t8r
aN03eWH0FfnkXTYTnQJUl93SzJ99+5T1UEjFS3u5WEPp3GDHQv4W7SwqUiRWFF0y
sA6YjWIg6SGlPATWdh8BS1c7hBCY3Jk0G6+VHO1wcS/vt4Fm1uRSJyjHfsHvO87X
g4idauEw9VKWc6PjvBiWHYFFL+9FAXs9o9tJjdetktoan5PbAFk+sr0wEOxPgpn0
tpRZRup3ZyIXBLpI4sSTC4zVgWUDQ7zY+7oHcU9c7M4xJwO8HwJmYrQLZHpVj3K0
4ugMoVttZATaAOrrJNF6UqS2yFDNZB3ZZPfK/reVjdjzE0CXv2mA+la2aYcMSEl0
yWzHBWhGy0pQFtXOF2VEadaV2HVvQOFHjooli7rKCmmpbe0RG+UiNf6MUxchHBko
JUcy1z+rJzoLOAIHU3NDc73ztxUWiR+ImO741IC7cH50tnw54bGrEqKgPlRi0Avs
+ejYH+ZJZAw4cShVM+A0kRKCq3SPjrKtOMd3HyBl/Aw8tdeFrAs165pQCKcHTjBV
eTkzjOC++3g/5R2p++aAOGkjfMW07b4oQWdKtA6yH8BgtuwdM3olenWwpxTdS7W9
i0RgQWoE7VCdwBSMhW/P81hu+WkJ2CDXG+OJv9kju4G0cWXap93skqolGUUq14It
RAwHKvHrCDQu7IM9cdJ1UGsFBK8Lto41HRoLotFHJca9evhsPyqx1ugatGxMqBIp
EVGJKm15fxZh3nLQDT6UP8NxsSiB3AvZYrJaogqg00/oCKAw8IONgIRHcWcIDu6B
ClJV2/PkH6O9ZDLx0W1uUTbg7oLOBRpghly6Q/8LMphUyT45JqeRvCg3jNkoCXYO
S+4u4wi1wZkkjwoxWuSR7q90EgyeBJm91pWnTJFojHv7XbVLQpQ76nnLvFrC6MCl
pXYs5EPlzA9UxrAGIxVj7WCO90BbBoHnEmH+mvu+1rerMOVt4nF5SgOXWrJBTpXN
UIjKesYDqqjVRoFkjSYqTBgkOHkLNFMIaLhqvD1xbH1Ettln/akicUoTfafaKyT9
q5IXXkTZa1nHPykjL42cavsO8mmmyj06EJfvuT/ZypYadO4Hf2MP4aMqr60mQUQt
/SynbLgIdoetHLMuPfRTV+iyZVsoNmp4BkCqCMvnuIyJJYP++Z4KphGAnRASBhFb
B6FeaqIz8qdXcYz+85IOwBK1Zw44W7E3obgjk/3fbeGoyofumG7jxOCdBsrIVCLx
tTldcmor9A4F4kfwKhXehxXuKVUUborXf2h1F6Lo1/lxNVcSzOtFdAmtB5TEjb8F
09bT3RbD/IGHwLTGHDljLgc2p0IULBLKHMujNKrs0HmQCjORLJPmhpKH52nqMIZT
705GmAVNZhRKVo6sMiBJSwIg6YDAQhboWmQjmYHGv0AQVZ4emJu5jLmBnosL+5+N
ct1iUAvcH9Z/PkOrsxyQZnbW3XmBWYKb6E3XuVijIK6TDzCNJRA7wK0hIfnbrM9I
5FI0gR2IeXqDKxoAuSmna1b3T495z2NpdE6qej8zsEY1Zcjcohrapi1JTc/MFn/o
Dv+9i2Nu5m6P8G0Zwdr4Pj1SuKerO/7Yko3s+PakIl3RgfV6iLKPxTSC5PaJzFmk
wFYSCi2QLk0bu7PKLXX9XPyLayTKz9vZ1sDHcBz8wy2/Dn+Cgabn2oD54bNUlv5u
M62IUrydfzLUOi2XF8HUfDudiZllFVSHRMtxVVYhNfPfP2oFItAPhfKhHqdPHItg
heRdLIn/fVpArz/2PbYRfKLX3Ege4t+T1ORhF3FkiijBwarZXjZLSzH7b1TENWVO
AEWLEsDUBIrCw7KJgpvVpnCDlXGflWybhnR0oQdNLP6b4ZmiMnCuNF0stXjvHPkL
ZlY3QcW//XaIFK7djXnC2T/mSVws4nkk3I6Jwv/daQW0lE5LSbN1G0EHK7LG2vYS
fbyanm/AOlgagCI0zKkQwYm6U/SHBQlscT1x6qjU+iL7c7Uj9G0jHNOpj/fhj1ZQ
rtX+4bmJSGr4IG+w2JlbW4lLaabr1gouuSCLiLXSB2m4sTF2mPc9fBU2rgshsghI
pNVu/PfiTmK4mLjSbbA/ANsvtPQ69LbJSJXO1h4LqByyAD2+NvIZ4NEzpMvUm2Xg
k1+iG32NNv9Q4GEZupcd2cHdKLfzdrYLQBcMCvluEG86plySsKtbPh4ZSXUVVHFO
BII/gsWE0VSfQKfxJCnoR7jPvk51YjxcKJou9WQv/apRGSE9N6OdZIZNk4KWdPjc
sWTZOAhmKBlejEfMaAmLrwCWz4zgFA3uBFu3drmeCS6HNCPeqajyrlL2k1qR/Bgs
0CI9z1rBdvFDcACrOCqg6+6q6Q1FO2uZ1EMW5Bq24L9tCfjCFGs9ql1sd7xswM/t
Uo/Uap6HIqVjjlU4V0HUUwg2CkxtpXB59IC6yh3HIUohlPo9aej6H8GqNoI/LgoJ
CrjIO6QlPL9Iqe8djFusn40nBRNDuIFOBBvAaweXauHrts1cryqq49bIWoy3XN/j
33DWwRC1FnfEzUHCqVyiJ114+3MsCFgFxkXWPH24BO/xbLWCv7ldZUJKFCYx45Tm
ghpxvymsaNzvkqzfhNP9h34jf9v2if8E/pe5PMYeItufDa/cDqcMIre224pe8rcq
Jf1+zpTMeTvDL+WdU9GxVKsTaSOstk/8q1x/YisEsq2FS4lVgH5mrpI1ylyLVuKd
rKCUPSjGoKD5e39fIf9qgBPsF/2a8+OYqHYaKIHi24lXfu1Xr3DQIAFu5VpStUpn
oLVRQxtVTCisaKrRZ7O+a6YspUWu5mcJxNH8CAa2cyyFA2LTKbO2I/cM1IidQI8T
vtB6SeLrqMSd5TwBBZ/59mOIfGziLCpjMAyYptv/tLD6sPtCKfFKKKa3h2aJpqXQ
N2hOWrMZYiuTYaTM9cOFruVq2R+5HiLprNJk1Vsro1lW9XcVV3EnxFoOcLv5ce3a
Clm34nTbdfhKUA47oPPVKi+YsBg7TvRDmzFXOOhVEF/TUPii3F36DbNv5UQ2K6fQ
0gHyWxUgm5iQ3GzOf+Z2j+8xwp8VCpRuz29GTAasnOnyENQ/EFQsskokk0z4IGxY
+iBhiK7w4lPudkEu3Faom10N9ZwHG/crCAFfHcfxsFR5XAsJWIux6DG/iNAz06UH
WxDU5djgtrGF8HpCQ0jEvcCuvUdeeqAqhPDGj1zNmHB/zvMmAvn3EL98WXO9hk2x
g3VZzLwPN5z6DXzYHPw4BQxcPOuHd8aIPeXW7cW6pQSCsaZ/0kPje/JLuVWgCrVV
dILYrVlMc0GxS61sfDz5pAN4n7XtrqknJAOvgZc8PcJVjISMe8zywluymUo/oFAH
AElqNyqnck/IhqJ2evC/4/dqYCHLzs/ltYWMfatsuUuduwaZc2H9m8onfJvAcPfx
YTqRu3HW6cNE1rPmGfMB9qWzBFJBJfFVpyyEbA+AKbOXVcJt1CaPSskt+bVknwdl
i5O9uFnP0L2izYiyenS4VbBpV0Nr7jnQd1B7vKHKlOubv6chP3EbVwVlWSKh/Jny
ubwAbl2wHD98PK/93gqErD4w0rv/PF47EOUec7bpHJIOPgqQo3fG8246RWqmcT8+
XQ1QDTHn8IVTawKTu2+fMYjk9f62BtsXokPCbcsubZVPPSM5LwpoIqQqEKhvAkI0
j5CCyYssSGD36ETvFI7qLkFp9u8a4tVyHRM3W1iG6tuDw2kOX7+e/YwS47ZGRjhv
27Tb7RU922ma/Zd3LeNBO+5/SMictqV4TXy7JxLCIQq97lZ5hJVI3MYmYbcjfAxz
ciyKRs4kBENbUZ53ry/Yl/+amesLZchcUEwonIEyweSCVIxZ7ELpFUg5+TIBtJ9C
VLWSDB0jGg3CNcBj7EJy6W1/jm6r7VzkS8JOZDxvVm8kDE2w9VNPXzjMLneomszR
ec8sdZtrD2IYaGAtkqtfrdVcpY6MFffzKfv+sdsHSdd+heIeyRwfkVDQ7hXUuUqI
CEfrZbH86Mys9NneoBulDrchDxSMdc9aRj+cEDUDeSVXU65MAI+54QTXhG9RVzTN
zQPUy4ujXmtMRhEi7Shl8mJjJefzzFZugF0W8BJywkU3VdQMEGC13zw7QCEgdqJh
H1DqqDRTdx1d3bbZMCg+uxapZnHHWl/y7rJnVNw/+fQg3ZUClBfRHhYTYaiv4faq
dfDXdOXZtGMVpAtxXyJWbK11hpjFj41Zz3uLf6DkofUyBW6FpBu6Wl7/4+E/l+ze
MjgU0DFJEmyzhmW8whISQvqygw4qBUis4yI9lD/C+UoxYTkdvMlMbxdlTCf0goHe
/J2J/SMMBv+qL2Aut24ByVnuee3/aZp1DWClb7HmNCbpHrLpqQ4zRZaRp3QJG5zC
7EOCmuk8YSr1zT1G/qTxlOtjvjiajXo1bMs7Par0FP2fAEA/gjoinleW7ZfVTq8T
/fa9Izv5ss62KPcinASX0owB7KU0mk/Q3TViTFm1j7SOFBpN1jmSG3Anb+HYyfR4
rD4pToJZ7TZZ+/YOQV2a34IN8tnM3SLFS72PG+s6dWBQ5xkGs1stH5EKknDhWYUb
uEYj8Ph5GBczvSbq4nsns/GbRHRJIOX8YG/1jTLSGsQz/72/+SQNezDguj6EuJSh
oNvH4c9OtDAd3F721k7NWqmuefaqMPXqCUFkui6u6PlUEU8eLZRVG2KV7Y5u1rr6
DOGoxmWeX+bSh7rlrbg24MuX9EB6eDUaPmsovyvle2yogmaz+C3wwUVOVZMvpBN/
eFvMZ8iTe2ra/cpQa2W0H1z8Oj/+tsHZ4AuMj4VLKC3pIvNcAxudg3/Cmwc5Rb8L
hLzfWtUu0mQm51e+zGjWku0zxEji4EWTOHbk+6mNDiJ9S03j/5pGUl/ORoUvOqB9
3DGyqyHFKJXHA9h+lFkY00Kj8gg7CpO2+AdHCZcTRooI/jLDxR66cKeTKlfYX9UP
cveDy4qNGA3AgjHR/K5TzdwMcf90V6dE5I72ZByF4+HJEFYSIOj7Arvd+STDBKAh
OrQa5oF1SnAncQJGOAGkIhXiAgFCxWirM8T25rk5Eu0pyGRfU5fFG6WxNXIR5ds3
BVhL2GpAPFpKXexwbdu6zA1gTQt3N250gb/J+ZWS6MYQqG0FxFsWfRM1U4qNgvqy
EAgeZTcVvgmBNlYTbNj9eMthL93ROGXy22UydlhEe4HJmUQc5vbO/nstlyhWwH4r
Us9mVk2xO/Wz5eq5H1sZlcM4q2nZFk6f/is4+JFWDnGcX5QrBVDEA1uKQQpSnfKh
35EnWmcy9DBJOLmu7s8s/R3bSenGjlCGjYWVHv7jUkxyVn2LzlBndQyeExjKSEzI
+Nx3lKIfTH3aV9YKlYJKu6hHccJVDcVFTSflkoSpL45Mkm4yDTcUDkqwxxz9lKIl
IOvniAxPGhqt/clnY3Y2FsHBnaAAqQf1akiG+6uEpIOJiL19VA9c7y6B9x3mTvzS
kqazBaVDnguWNYvST2P7asoZJ/pjTXNg4Zu1BqqmbPbQ78iee4CMIw9Ce8T6xSNK
DIvad780+dyGHsi6Q4cX5LR19mvjLp3x7j0MWFKVnLbKW10mebv30DIV867SAaZZ
V9TDb6gbPuT7Ew70ahje/wrcW8gdyAdVGeHaAooErTg0RhE0qPzOsPA0vJ9IRMR5
0T7xCiQDkvYYZI3k2x/qNCrltATGt9rQmNgw1LIBGG6li+7nmlXDnD3XKtqwvjd6
Ptz7+MSITPFvqayNP9c/O6H1cdJW/O9eWFmIeC59EIppTW0V/nCxLoGhPXNbaLK7
wsdeLXUL9hwRprqikuFLSPfJJywDqLrkR8ozCSody6cJU1UBjByfGsiSpVGqk0NP
FOD568fOnfiWqHUqzM0//pCO9irGwHCRrNUzKhpiM3m2gFbAi0oYjnQHR9Yj4JeI
N22k/rAtugJteBerQsRst5vRBTLAL+0pYkG7BVr/QP2oqyNvVTLjBd9vAj+B3RWe
eTOMtwouhPJhds3PLN9pajkkI2AsO9F+fYId1/CbXI0NGSrwJH6zRZJuCZKyO5BO
aXziXJXyXBV+Ba3eg+ViXY+e1bp9ISwXfPWfuocd5Dp9l8+3qCxac4vsdlhm5Vq+
2JvFQpaSPdNH+QIY0GlZODPQBmwssSJ4dP1VLtzZIsfAqefV2IgUwh5nEd1ht8Sh
L1JyysikBssW736kVDEhI4QM20ai+S9UNV/XPm8xtK9Ja6Fx3AFAQAzWvuLQAFUY
a2a/b6XTO0yfb0kX6ZDZ45UTTh+9okbmseH0/rk1jPuggx3PnHt2+6lg1pr0aXlX
kThClSqmFllx7HvOSiChVZJY/KtIZM33ZujaGi6UVSzL6iELw1ZlN7Yfq+YsgnkE
TuXtgcfMFi0cUwDKfxFqu0Wvu0yj0s+8yYUYX9fBk1FIYvepu2gnyhgM/2Sip9Ci
X6XReHA+7T55TeV9Pt9F1QgBXcgXvn0kCW7yXNvKrXqIBPy/xqtVvBRIL5d71Fha
ZHSI4cksr4qZ99agEo6YEviZKVptZRzp/VHjtfGilVFvUwhEG+cJeZ5HRY/0TPjV
wWgsf9xi6kksD7F0RPBd3qClaQJx7USWXRT3OM8ek2rp+pDhraXAJ1okefwU3lbt
SSahkaSqM3bfvzfbjKTPfef1jZZY2vYCuZQ0t9u4Wk08kwSeOx1WWQOGEd/1faGw
5kJkKCzyaPKs/A4j3EBvSWSTmL1Qh+HdWCwCZni5ni0riIbKrV4vxh4EgGDek6Ok
kuUGcfODKLVh/44czEqF0OXIdoh8GaPVzsLZb8iqFGyPU8rq8RKPJTXkyIU2DMs1
kUu6k3Kq9bgz+7QQeyBHCyVE4gRC5jYVLc8M0LeZ3u+EQNJ+OmxtNJOUknfWM3I5
pdcnPw/O/IY/lgxfU2r7ridDOZNrga2ldCQeSgZDDz2PqXQy74Zorc97kLC+1HNZ
Xa9nEQ/4Eai2DrMfMRDhI9kG1h3V1tIdLt4gBLbGkpxijv3vPJ11K3k2qjnq4gXz
u9OndWah8BiU9+S1DacLl6Csv/OwYL30F71RVY7wF/C+hA7NCAR0t2l9S5ePGjFT
ACy7hZPlN+4fPei3Z5winl68Yk4AqsnI/vHoO8jcThUW1lb4zQJtDoO7Bjd1Gb9C
Zwf92dZx54PntoHnxvY4zoWu3tta+oC4avfGAjXjWppecTP1/y0AV4Th2vfZPyvz
ghuUzrWiNc2T4H9lnOoEmgZk1YvANrQGjNGPXnWSp5x+jByd2NB5495osgAXSPvD
+ETkWBqDW6g413h3e7Tib0kofn10F70N5zhrPAxwfaYvJbKWxrWgaQ1BwWoUvZq9
8W74Dima2XH5SO8Lc2OUTYFFq4CnynQcYsggkVBh88+EV233UbRm9Xq5ZL7E0HyV
eB4SzeUvA8t/AcTrU1Mw2/rg6nkXt9OnB9RQKV4DzwAQOovtz1PEGyOUYFzpg/T8
MZkW8jhenh3r9GRhY1vJxIHlzo+2SR/rpX/kJVX5Ra7uRwAFovM1Z/avzCJutx0U
39QFRn5xKwdHeDCgx+Phsc+arnv/UnOtUZDgqI9cY3wIOA0NJapdM7Wbu1xe/m+M
FMvdcl61ILzNK+A7ocucMW0eKDdoz7zQo7Zt2y50WT92O5rwjE/ueoJH0h8EP3N5
TOrpSA3DsJtLCrS47oY9D2dOtNgQCh1YUkf1UmufTg9g5Q2LzJBVI8uscKwEhCJy
+WYqJ8Htxjsmxvsh0XU7xMbUj7QrxauAER8VGDTk5diGwtJpdWFWch+/0MFI/Pan
Z+OXCbGvwV1jFnuoJBlX0ruNsh64N76VUorT50B5bsAgrU9/3BD6DTHOXzyYJPmu
yYof2zF63Aua576zgIdbKOwjla7XLx5+riBrHk1cqzj6CYNjiMlt9+xNZ6YeX403
eiI2s/06+4/3mJnNbpLzB8K1w0SDXQarBMsTOa68DMDZEdN5lxMn4MOFkIy31WP/
GQnhx607kzBe+oUJl0Q8bkTOzekI4XaPcBD6xYBP38ZCauIjAy94A9y/tsEkMbNF
6rz4fw/y0t2aZjXwK5zMrW0r6Qg/8gCfhT7fGvAGKc38kK81FT7TEnZfR6k3Fpe/
AugKYFdINsxt0fBbxicNADImQKlK1EqbixHp6VSc67xSp0kZzQQk67qejE5qBQm5
uZH+bI75Q9ofVMbkU+ZawtWZnLgGXcKm7z2J9T/jCcmDurKDaaf+vTDQ4yaNazPw
uU8JJLYWPnMFCkBDQbR7hoiapmQvrp1oqMghKd4FvEG7e013SfyisYkVtNl+ww/Q
ZSmHXJ7GveQUA4XWrVHNI1kkaPhoqODUrl4XB6LgaaTqC+UptznuQBBPNSWsDppi
IfWQqls00ovV1eEsCABNvH6E5Ftk+mONu1d9pWcPQ0bufspAt3hMVtT78eL5Z3Ge
7WjPt1T8Xysd1u2th9qT8suXzulghqVP3heWD1oa7arbbLVJvuXBEt1tRdxljb+v
UBH30C5soxRyTAoBRWkcyxOoHZIwH/R/Lf3R+QAF2gW+kJ50+GhlUadPvKWka+Oa
tgYumc3jzCQ064lGrvXV+82Cr6hSVDuuEaYrN7Jf7UxbuqqCUH6vlZV2b6JvxcaY
RUjU3m7BZKDxsHgKlQtJyR2LDTakehXlyGm6asG3KHN4L0AF63XpTPsK1d9hDg/m
R1bzW0gP7xUcrM7ZVXDp5TKBv9BnfOHwUNrnqXYHEVWMagNsu+jFBuoFwBwBZYjz
f+6Ewt/KeDan4kBUw66nCfrD02wBtDEoxifZ0A0CPXbLYtDJObTtFuUAnfIkDDSH
8JcBD1u4IWVowEjVCu9tjw5H7pJw1fhw4/VJkdTCzH3b1FY9ppwKPCpfi1GPGX8T
AotVfi7W80OjtCm0jZuIRyF8JVvykofSUHDeOyR2Opzx/wy2h+7rn+GfGxY8Z0k6
hfgsroo4xw/WT7KfBk8DaFJ1GTvAmE2g8IqQT5gWj8zYbVg/RTKU+hPo8zSiZXx0
UrJKullcm09w2IM/z7j45RVfhMB60pApB/u6Eykfb9rldlJhfy1HKArxSEzQxaiJ
oNfqKHq0n8Vza2OYb8C4RyHxR8e3nBIQIcn8N+zfLLM+ADArsu4Hdv7BsmPh0LPw
yxxkQM2k5RkA1fQCNDdAWcCoRNYNrks5IezbCsRKAEgP0qTuk9ZLKwolIn/0zuDu
CCgKcZNMKnEIavZHnfbkrXy/yQ84WLGMwrNapCVMlbhxQ9bn6Rs9T/nD6LSTrD00
JHuEosTVpytCQLhlWrQf0cOPl9ypcEq7s56Y2eFJtd8NBfCPP5X79kALPVtksoWy
tpzp8bMiDELsX0qRqlMCOsN8IC6ycVvmfjozSiFqo95v2hFMIkcXSamngma/3e3p
MuZ8S0UUzIvVdxJ/v8PhY2qBTirjCbdqT7arD1HHLo7reShtS2+k+0LcmmHAK+PV
MckVJFlr6UsUB91QLSeyr3A4Ugut3LXHU8tdcDXsJVJnq06OD1YWOoBGH/TDIpFs
Q4AkhdkBDLru4erKOmAHLZfl72VN0GeRNN0a3pAsF1fP1YkzazwBmQjZ5LPCUBu1
yUIw7iWF46HnCcjA1gGjwSkhLs4XocGbikajeq+w037nk9herA+FBI2Ic9V0mHNP
b90gX591xc5qCF6qStwpcllIpmGsQ3T7mMvXtIXeO8nBh44y+OQ3YFGhJPgle6Nu
GNB84UTLEwJAy1yizwel4fFTKTiRGL19bzXoyaF/RT1m3jxEcji/l3Z4tfJLEorj
Tfbn6DIsufW2aBNA6Kj4TqxqIWzlpIQ4S5QIjpPn9YJuxQ3NSzvbpiH9h5ynqL5X
n7dANmLHsWV4DJyX3wt2KZWY9x2u0yUOwmvpvFZYv7XiyfxJ1n99CXxoBiD5EAWK
FGVvPGZ3zDpc/ZhDNXF1Rp3v7fpxu12xSSiFQby6+srvGXIrpXpK+0zQFqlVy7Jg
4+mPMcG9lY9yMMYT7cQDxBVtaaEOsZ4PGh7jGUd3jmNvc1ff3uSoQTXiD3+WQ3zW
AOqpeFxU1PRBim3QoJv+i5yEHvn97Q/5ezoCdyiBDkWRWfTJA1LjcdFsM1vEZsPu
AG0Op49dhnOZDi3tnYTWS/eiFA0Q6Kcnql4fYckIp9w0LcE5vs3ySAhWCuV/6MuV
FsWPg/Rfy9/bQ+5lzI3moCZsCcfvSE5c0d02t1e45IAX38yldrsv2Rqp2/zCzR02
S+euC5AZVVlD3ju0todMFoTejMYwb6dkjh+vdiahLkHXYZY/WF3JLyH4zzSiR55P
tclQZOQdf12NN9xxgBoDg2aI60YEDW0iAwinccJ0Xc8sluju/B4y8HpWMMPGCK1/
YuN2AwwCDuJ+Xq0Smx32Fd14DSqilq02Gn2cQbnpyrxFJbrhfD3PMYAfj5zoO3as
vw7TMSzn9P75dcooIaSFp3wQTz4JwJvXqztwh2thzU2OPtvrflFRGaAH0dIxvQ0b
VGSz9bcQ5S+Y8/z/biHrzyDD1J/AKBCIK39xoZrRJBtGsfzhUGVfq5PHr9qNFXLa
SAJq/kPM5tXJ3xUJy6lEpiR66jzZdtwKS5lX3gIu1VNLmz14Im+WQkev5U0hUZn6
G9ygS5xU9sLc/TGlaEE/k78AZBtnlq6egN8b8n3JQaRtybIHnMH4I4jQ7Rhj6Ai2
0iMlTGqamZUou+rynLIxCY3x9UnQbW+ktwwtmFHraMfSS3H6rFUaRmwKXRv5leB1
kGiMGtR2N+HDUs+LBWN675nHzjuibeVRVdlwP6eFmoVgULzJ6aVdr3bxlB546OGf
iGT8VL5pCipGo19Eq6EN2JlYw6mzmZzMXIfziGglKuWGvtVdKNgHWTFzf7D01ig7
JbYsVdRGS8LyWE76kc0zTvvzvFFc84FhuS/EltyxWKfARKmRAMVxdmxSp9AhhbRy
r11siwZR0Q6gQRmAyrYxGLYyLG9/azGpyKbq+iSD9kzE2R+0gsokMQQkIymeOFFg
KeGIrI/PBWkORtNjtZCOQVwICexQgrOvtw3fQrV/qKSMpipb0Y9paw7/9cJ2zzp9
G1udMI1szdisHX9fMR77MYZ8fReL5Uvr6rZYx+KrQN2mKPJPCZQ4lrrdUKsW35yn
EnWtHXFjoF6yha9xSe+pdQLXCNprzNFixTtrGBOFFXMvYEJJ9l6RzEJRPlJJJDgb
m4EvK3ifTSDT2f/5dP2ObX0zCx8Lv/t5kz18IH9oKvyfOvt8sTCtOUR4XNmLpyMU
i9+CNF/hcVtj390D1zV1crdw+K4q3oQJh26UQC4D25cTM4HTwGdM408ftuPidtMh
7D16tqNWEjbEmFnUrRfXoW4aBjWFHg0hBxrztP3PeHAR75hPTb34mIrYd9mMTe2D
+q8JVNMjvWJKn86+L0aEeupP74+pphH2eLgJaME+VkFHzxwjqnfg4Rt7mizxD0Ia
wvedGDKj4NeeyXbGjGv9SaTspyuU6YJ/UKBfpc9GOtRSR0Y0v0NWVO6P17HfPZ6K
jz3o81DaqGnhBYAgwfI+XW7O3S/CZidLOxygmQhEy4chQwVUosK5Ip/hH6cGQhsy
XsIRM2LNMc9mhSR7AcT/FXrJnXhLRr0t+Ea8VCumoJJEjn1zR8hXAj2v96BGTyx5
DD0OA/cnx8FH/Kk8Vnah7BBdl7M1qovz74my9O/Jwr20+hS9J9Ucr0HeZdoJ2XK7
gsnFXlRlmD+C6ANxjwJ9bHD2eQc5Ddx0W5zRX7sQwOKpF/j4Zq1lvX3my9OZ9AFZ
PvKD+EwLKJz2U5jZ003w1Ikt9XA0RBTYiborVU2uWM3UewkWcKN3M1/FpZC1hkdn
5VWpsbGUzK2OpJ2e4CcZm0PRaJicT5hbE6wA3/Re5eTF+nQFC+WLl4a1QTGdSV+C
3+bfD0UJo+4Vy12VKWncWwDdVST6/+N5vlIImSFbhDdBziSdCD+2JVHx68dra/nZ
7kCwyoXI4+nJo32UVGyws+nAarW65C7KVcENyQe8LDECHKkzIiRmOcBWL3DnKzOF
GUcH/DNAphgJfD4aH0Pi2vrEfAXEPtm9gDcxIJ0HpRM2EgBxxJo+2gpm7vXFMhXW
Sv0RkEjWqm8r+0BVWMqFqpO3AB0ErV8ihy6J3OKHHvaKh1KLuoXa81gmnhdSz9/5
+fuz3u9tMbNPJQawAapLsXSb8Okhoy19WstfmL270Tuo1DXA2s+3SiPh3h+t5WEu
dlv3wUAhsi+dJyqpixw0y2lf2S5fsnO7g9V3h6QAQY1aMwTGY3qWVK6tXXpeDx0u
6MYlRtQn6/86quoOecngPjuy4NDYOK7KGg+dvGkJ7aRS+kjRGE+1dXTwiPC5M49t
eEFreVCedplmWr0SYK7hLkHsJNzfqx7Rp/zvBYVqWyH60Brc3PkEUGwy/o/K1I9w
JlNpic7nKcJSZv9sbs7DtZ5mdjgviiFo7uSnJ3etDrxigGckyX2Dx7r7AxXWZ7Re
Le4nk3h1ZeMWQOj8E1RCUiHFf6SsrsBhy7gOPvo09o8UVFfxfXd26ajvIdJhtK8e
O1IdW9HZE9zXEoq2cOQmBHRvqsUiN8xwRX3toAl5yfOJ41mPrN1JNk3krv4LMkhw
sGyIXwkFBDhg/TIUBaCdOCMP4NGaHDitrgJWxXu+w6yUJkGQWf7oqfoxgl2pSUf5
tpUkwFXsSYJ8iV7tpSm09nV7Klr4uSUlpj8sXlcW1A4dtu8xoPGgPucOrLRd2AE3
u6v7CzRUBjsQOjs+FlhSNmyCKkkAwVF3LQe4Ax0B5iHY2IlC3wG4F7itp+NGabWT
1xuPfkJ3bupj//9eHSzD2e/VON6QpytVKWB+fBD4kqJ5YP4HSQiNQyWnY+uD2fRc
q7MaPn5bCVzlmJonuXmIZ0bJAVoyD1pNsHr7igmSMufiPkwM+xzTeT6texH3fh5X
FnQ258z+OHY2IXAvPvA0DLh5EA8Ak+k/p5wiKHKVQusz0+GIubhkNZeH3Uy4aIuP
bQkkR7I1pNhJUOmMCAIOM7E/UDofyrB85cEIpUt0if+LZkxN6yQ2ZNWRN++UoXCX
uGNPqj8/PLF96hZk2k0KyGttxlj6HfHBSR1ntEwRvrjkuqnhhC+hziWagbGSKsuN
2MbSKeXwWcZkJLCVi8su6zIjWPgqUyRsJ+AylL6XYe+rByGAPvtxWZW8AolAHBgH
zEOHipdUR+NK2AmqrMMXVsSo3nta5i1Bx1RXnUiiFtk9mYr3yRkKg+U4CFPzTsEZ
pSN+jEVMh36ybTwSrsxGB1/pNLe8O9DbhZYP5HjOXkYoeQMcqj3qWds04GfFci74
ncnkYIGIzKl6+t3k/dzSc09GZH11kuff0RhC7U6K2gtGmaJZj1etAZJA1ynunfdR
EU69JpswJMfyyXI9aUodVZj490isoOSKRlhkMiVDZc28+Nptsu7VE8chTW80bOGu
uiNDgvFcHgSFfP+QOuVYfHyR0jDTgGde8FXp5LCQuAeewtBKjsieG8YSZg4TJ0+N
wUNTYZ30xFtz8uoTIjCQnXL8t/RQl2NQxIK0brSnZCEgkzIiHquLkm3CAXrWlcSQ
XBsWnr0xQ5UqIr4ZnvCJuixvHWrM1muzB/PpLAz2HQ4+JsOhqZBbPlPTwu1+H9av
zgBugdUAKN0rmJjSqGoVzV6Z4IyPbZQqkjaHjCslmDqfkV9uu+IZBWmdP1JHaGi5
kPeqKkpXD+ucbAQdj3DGW88rva7BykO0fYAmcs/bIeY/FIsMriCUWrU8ZmHjAUdV
7e4lzUDryANGWPqOnT8uvZDStnuXHJv8o6VWOPjjwmnmemjlT8kk35kE3dpqwsaW
RcYO2G1z4HXfTAuDyc99oEjx6DdOVvFVqRRhRWhHSNYktH2FoBddkZgOU9JLFqQu
sDyGhVWNbEkNNIirkm5bDnV5vhkduzEk40o+it7OqxMkCifQEEk5dn8cl9zD/IfR
B0XkfFPZ8CAtmdAkJktacYFSE2LtUxeZfc0FSm8rq7My+FqaaJih2//mjmsqY/d6
Amy/aKYsQDloFD4wQR/LkPhiKNuB1hCHzCkEmERMhXv8mGkQLiQ4UxlXFlJOc0mK
HgtX5Akg6L+cZD0JVfiQHRWu3wLMk7tQn5b76D2YKREl3lUa+sspysDgauzntjxM
xPQlQplPjanWRaSwvNeXnfY+lvKfkwbG4aG6DNnc60Qj+WCYu+DRVZ4DDa9WkifG
MAhOHxgyhieVA+Q1GE7HW9gaQAwUSw8vrJutgyGo8czVec/QjUYzTrg9DymU4bBk
9hGdZAEGpRackglXpI+htIZXq2JrgckGUsqWMo3xxj2XbMYWTYXuGkEGlsL6QCQc
he8wsEB19+mJZitdGqvUnQTns7+S4gjIN0ce7CBQ9lIxqr7qnICjEJRgDC1XD9tQ
yDoiZWEzwNcVu9QxcWrQZVa8Ktj/shf/gtaxRJps5XcBBDnvy31P/hu8ndVQxnoE
YO0jh2Y/Jh7ep6DYhbAdvBr3vBUl0E9q2udgAJ1ifYAr1or09BULDK812NzKx4Oa
7ovqPaPxvWmHZAbQpmg8EJPzZ4YvV6O5BPKv1v3m7rH8V403MeH+NpsXnwkk+d12
Ne757Fpe7Ajb4waPafsTaw==
//pragma protect end_data_block
//pragma protect digest_block
9NxS3cyP4e3zZLgbNr2zuXgFOIM=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZZlVfTbVC4I6rVWtkDDnz/nN3hGmz73OJSUPV6ONXPHbJjR6Ad38ad7d+lNtyuoS
Yjt+80mXjCDCs1Y3F76LtHsIF4PDQYeWIjPJOohe8ksnj6JgBwwsXM/TZ/fuf18k
yd4b/nLV/hMbLUibya1RSk5+CkxfGWhYLWtTatO9+uNyqiKkTiYz1w==
//pragma protect end_key_block
//pragma protect digest_block
xEOTUoAsOVXBhPAwVRXVJcmfuXo=
//pragma protect end_digest_block
//pragma protect data_block
OPHIZtN6gY/2oYiUVYxhb7/pMoGaUNWC4uaIsrQMacNsPoGwphpz45iO6LtEUAc8
rSulGvl6mQOmJDD39Ebn0Rg0OjiWqlvQz1OlTmAn0M+kxtMubGZ6B11aMTKJWbc7
7mLjJ/FFJDlMl4YVPjClucyLmGjFxGyEzZ9PCuQToD17tzMHv/vKZehM5aeVuo/m
VYLWqkVSLKi+DcQ4cX0LZBEjaBF9N1FJf5ZHcWAP0sWszDmCvhbiyY9H1de51sUz
xRBgym77q2v4Rwse+NUnzdFK/VN5EjIcWCvqrwftlD29A9lchC3OjbKn/pjJFVcc
jtNRtu/ckfLK/mNIBBzK3FZbLS0NtKltMLawRz2KNjxLb8SknWouCKhErRvuke8R
InEqK58b5oAVZKq6LatWl3UT7YepFG4vsUyreAgVL7xyuv4a2hREWHNhlcGPgqjG
7vN722WkSuVloyWxNkEJmj6XoH5L0FbwANFrk7r8QJlglV6AndK3tyd4OTLZVUOY
94FRi9/GO1BZpG3AjOaec1mV+zoPM9vx6WF58eU8DqW1KjRbG/+9x5tMThIyO/ni
OyzKNBczZcATMMz/0f5ufpJPN2FNI9+/ukOUawlfyRiO3Y+xVI3747qDOl8m9gVh
JE7nSeb8Xk3ZkCQ5EYFFm4MyYb4p8oe58tfaeT8bpNXUMnTfUJairKUecYGKGu3o
WJvZcqBo0xA6o1D4IDUXzxGLlDCIaffNxCB+wAIp/WyfowIiI9cVVadCc4dyMApi
ZbHJSw5j0R450G2ozj1x+36/IBlimmwW+VzXzVRhw0dtjSXekB+TCNm9JjlpwvXQ
79i/i+cJcMw214T9ddB/1I+oS2cmibOq0ChFeUrTcat4ssxUNQ3DR2LeyfZPZJ27
plDgMklVTO/6nI9T3rCONzvLgDB1YVHwfg751xUULgZBom6/8s3Spjvd3FKsBPJb

//pragma protect end_data_block
//pragma protect digest_block
zMKthGKMc4wbtp1Vi+bK2mD9HyU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Akuu5/nBqOHKmu2otbmPi26fWwsNiiekpbcJVpdx9+rGeMUhE8LBxjVaun9Qfbaf
YM+KJcjhxNI/JgeGSbzeGpQe5QG6V1FNlRkgKedHWDMWiOZa1kezLMkbvlN2fLRW
uDFrlHc1ZVAt6WErLnVtodN8X1myBACbdvDGmYyL8tHJROsSZUatvg==
//pragma protect end_key_block
//pragma protect digest_block
Kw8Ls1adwaALp8hCnUdmL2yK1vM=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
+aSf/DLz4OzYgHPRlaGBH4kq7JE=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mCzeJm2Afogh/mUGJXr7D0NEpbtH3+PcB7HrJmGi6olOFnDV4JOATx4Co3F7RZ+i
VaAzBihHVs3uBEVl5CwwbzbSe7CUkxMLGsPmtMw6QsZbr93xAecZUBr4lqh3GilW
hKmxRlNfcaeGklJ0z3tf+Jmxsgl/WqnJ1nVOsxDFE91lR8TAgnd1Xw==
//pragma protect end_key_block
//pragma protect digest_block
42RXQ0W3XQPKbIAvce6LD4JEXyQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
7THMA2h113sVqYuylDok3hZEKUk=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3w3oqVvSozN0k1i/X56bxfBEo09XbCpK/MH4kgwcq/INBt+/aytI9AW5wGyxuWid
aF1AiIvdRa5QFo9ul5hk5OJPs8vJRpUoj3d9LUO2PZpPSlViGlZ54/onId73SJwP
4Bt/a/SZqO37gpxm5DKaGIQewE1AqzTpXG0sUMX21/4HU5ErlZ0Zvw==
//pragma protect end_key_block
//pragma protect digest_block
u6xx+opfWrEmaBEgXVbxlCU057g=
//pragma protect end_digest_block
//pragma protect data_block
5uFkrAp8XEA5ZcqN+4GwwZ6Acr4ODtyqBMk4HkQXJMD08zar5oXU4Te2v/Pbk1HA
jL7DnI1QSDMZgiwnCf1ZlwVi0lc+qtTXSTSrD6GkjDE59Yq40FAht3NjtDF5VK74
PjjvlTD0R/eULAm51kqwWATomsZPczeNg67MuzRa1uevGgk5NfUe1CeBGXIbnFvj
gGV+b/Q8pi/AVO/vP3Y666/XUEd5bw5py5aBY+glWbLmxrdX71P46UZANcLc/7Rw
72tF+1dpcdl22btn+2x+JWMS9sCEgG3eBK63GhP6/uGokuPDN4aSRgE+Y55PjODd
PWAvPXkgZPNbUZEWrQ00yFf+x1y7s7oByMdSSRAM8PTK6rwxVOgrcKRV80UjBq34
T18zppGg0A2ds1sJt6n+ZRwAmRMc3nIzAo5RjtGoeNtep6a021a3mzjMAXYPkui9
+eKTkkoqjesIneafXVxLEmLbSYVh3tVe+f5auRPDjMyXeqS2r1+Ee6o0xYdrZtex

//pragma protect end_data_block
//pragma protect digest_block
4ji4RGcqI8JCDYEWEyFcuZNCgmU=
//pragma protect end_digest_block
//pragma protect end_protected
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jj9OA30AFm2aZbSxDG1+utXWDZdOrMMUmD8VNy6WuYg5C+ufB52bnsPdfL5lWgiJ
iNE+bVjxVPGtdJnIRcrYZOcQlqT0x+PBq8/V89RaqQiJY+hepZS/IAoVR5liScta
LBqjcDmGI/YRY1V/8nrNdCV3z9LOfSzBRwc9rVtghak7uk7Kh7oyQA==
//pragma protect end_key_block
//pragma protect digest_block
vgdc55F0L+awUV/ZssRHSQOwi5M=
//pragma protect end_digest_block
//pragma protect data_block
+sortcah8m7FalKmMI4zfFRx9G5XUtAoSQgniKqiotjWTb8ar0OYxdgLV8i4MRF2
cHXoIHhVOKg7HGsWUjRsGPhEv32gn0DCzyuWrIxmrfZS2YxEHq4sECM83kzelkMZ
t4r76BzYRBoPZrv6RdJEIiJnEjzzrg8XhB1T4jBNmiFvmpuDvv/GvqDMIGqUm2pw
7OWNJuTJQ7piijVR9qAoRHpnNRFK720QZjuI0SyXL6KrALTTi8TrtwKlMeqB5ERp
bYy6Jbm14GW+D6NT40FrxmQfGmDtzVnENZpJnPxkR/1VKpw3yng8fa1gYA2aFgOn
SIxWOC5nZ8fn7ACYBjc0c68p7l1F56nrOk7cv6MRXPatxbLrfBIz8uc650IhjctA
nPfi3b+W97kb+ZwBbaW1V+HrYSlfl7zNJoTx4xiKKe9cNcK2tGOReCwLOVImxC5/
3VW8knhQswy20SUIagrkX60KoT1oJqqMlMBX+rNGkDSni2BNbjdWhu5A+PoVbQGp
g5bkBl37eDYp6FpmMR6DdSnosYZb58YVIEOFGnhVtS/pp4EFfsDR88/wzaq1floP
nJK9N5aN8vOVLslAaJg3ketXJ8KqjndseNxUvOi8Mx902qvx+btcffWHqM2oTxuV
f+5szisTKg1OoUIkfSv6kpQzSEZ6ADkpX4QEb7mUOU0TSiaQ4drk8zSpCxsd8458
9ddDXpFDUhM+HMvIJy9StLYd3hKW4U8iGPSEF9kHJE8TelmHYgKx3xRqoXoJO6tK
YKSHLUHLTZYkY+3z8zz0Y5JFyOWLt0wIqmBSq8l+ZYTplwEborLnYThtKKdwsFed
uC/001C1wKQG+8nucUa10Kiu/afasKOY48SGC/Hpb6eFMg0+FIyYYi7qNzNb2Xt4
g0BpEkM7xW8Tca67hzWhS0TBVkvdSqMD95Or29Z0BOwCz0UDUJ3sGyG+UwTm7sly
xZoZxlkC5LW6vRXecMPu/5/ygqS63w7LE2Z3uS4VQ7ud2tIJPyYFY9bKWVz98ZBM
Oy06bh2BrMBiOCeDy+sxMYynfIIL6Nf5chkaNIxYCCtehFAm9EOEApA6l3V1NRPN
dnT9F3uxWOQDAMtONLSh4AUcwt1u72cTKlKwKadOJYYJY/t134tCCcTAhMzctWuh
2jzMkUJALX8OBS677Hbb06ZK+8Sajlb+5sE372+78GLhmjAaIc4Fn5nwxYCtgzs7
5JvFI0vdAmnWtDoDJShhrLsyZ2Ik65RDTQ8Xcy6CtnTGAG/Vaji5f+AlPwj/tpPT
6P+XC9V+M9LcJKKe24LeTULw/EAb38hCjKpn1mkiEj+RGqCH3tg1TK1qTWAj5jab
8b3oRTchnGwZLSItaE7+Ug==
//pragma protect end_data_block
//pragma protect digest_block
3d6+UFWcRgdAqMSAin4yzX2/eus=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
r7/tw04JmcFSBoU0WEr9P1wnkpTUGq6fptxG0nealzRsPhG2Dt3Xk7sydGqaj/Cd
g4VFwTr8kwuSklekkECJmhkNa5VxYOjr1Kv4zBKhOFsfQXR08YXXes8tgXrgAUka
gPK1sgmX0DmL3yRjPF0eqTBUqgrk2/oM99psbEftgpD0zmZ88Cs11w==
//pragma protect end_key_block
//pragma protect digest_block
ajAXu81MPf3NRXc0+BF4sBnZEwE=
//pragma protect end_digest_block
//pragma protect data_block
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
zxtXyb29RValfgjwKSz2EY4JF0W9RZ3mxQFopm8BO3P3jdSqgqv1zOuo/lm9tHBU
p8DlukzGdt5ZSYEr8KkzLIb5pe7+lLdXT/k6HFxWRlLU3qwwaqsfMkLZI0QDHNHQ
WC+y1lpBJH8Cx4H/xdy2xGGTKqM2r71TpOxl5oK3XlRU5MMdGfgjxbqZP4BPIEyy
JVMcTrNMR7UJWomO6dBffJvdWjmw3Ou8xwrz/PfrJVvz0mT2/fPcRXtSCZlJx8Qv
78JStzXb/OpAO4Klm1SaPTtnPtm/S9S1oty7//rsQYB6q1s2L8Zn2UlG91MtuLPj
tZbUwE1z902dcDjr+8p+jtQT2B7+h1144KHaspDqephfvLFplgOB9eocl7FkWGzm
ceNH7lXGxu1IBujFB7NrMMStb3yQOb+OTXDISr6dngsxOdFErrPcOYK+tmyo5wWR
4tuPUsSzMN93IjJgYertSJip7Uemqu6qn4gppXv8On21wLGQf9at09qv20DDqmiM
O4RiAsbGgDet9LYOx5D6AC3rIRV3hmg3KBD/XiqPnkZhmXWwHYNH9O5iQEVHdxZM
CzQnsQW1PqS5Cxdasy1sl1SZcJwRD1B+ckb6iaZXHzccD0RNqFEjZy0CSdhrQ1MF
UPw1hoTQOvuNlieAhEB9ZIeQLolvZYwFmyEMpzFQJuRrAk0VUefRGIzeUx1qf14a
JL0noHYrAX9y/qMpxfzJio/LajLM97wNWdNsOjKfo5U4Ufo1za119LNqBh2Oo3tm
3b1mdQ6KsKnUe3nQdS2GgKzBEom5EcCxcOiFlsEc6mJYfs4DabPjlDIOmD6gHoow
4EHYKtqAVPsAm/p8q7fuWAAnLTNWeqn8hLyOi29wsVUlEkwJq22jTKELY6UuLpWL
A0KNRy7Bb6SR1PHm8fxV6DEQtqy02rScYvBdYVKbFh2AvV2RefRxZ9ebXxbPcmRR
1qa5iuTfxdnoH0+AaRX0JtqE0b4sOBLebE0YBX089kolrMZVWJaT0tRJxUGBVfui
VxbaV3+k3jyMEHG47hdppd18wE4E3yN8ibArX7RnQd7c6UP08EaWAeJz+V/WJ09f
gC0lj+6KzxO6B5cB5Qe8Owj5pvT1/y6sNcTtefUeaR4lW/+p5V0r6EwBPV9Rrd6w
v2H+CHx5oh0bwEzO0soWuPYWVFoaZTTX8bHeJtqR0rl1z/HZRPZhvUX9ZiIa9SmC
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
WKx3yeIYSdiTZWCaHqZXwfrCVKx0wYJqrnSNzZZWNb4kl/gkJG0JCqk6cZwaalBq
GjN7zEx/GU9xpeoeHovVS8Ive2pAMqKouGM0R2ZklcI84PJYv87VXJKx02dFYnSp
aofVH8xJu77AKV4IDryn1XcxzbF3o7aPRT2p5QPGrq7tNno/YY0281daWQVYo9rH
1bBk7xYY9aq2fCmU7somxedmTAPNinWyHxb/Q1xATrzTZdq3xR65cTFhEc00jSED
L0/jbTPJakXdoCHlQZ19HlH7HoUgB/c/NzCYSM8qrLeqauepjt5GhaPYlbmTlJ95
NQZQnmX4iXPjmAZJj1NXO9mWivEFI8rSPNgHFn6/khv18eBI1uj8ap4Y0jDxb/Ml
jI7HKPIeyWHAvSnc2W3YEWgr7J/oOZFuDq+V1Z5Do5CWRLO92v/E6oKGwCbDeH+m
DyWwKjvQbFQGe8/iNHvBQKXmurOVi60YbgE8Oop1GNLkYNfqo639zx5addbQ0LCp
amlnB5vGqYNn31GezKtu+NKtVTby5PAOVBJIrdrC4SnoX7tQOXtAHgVc6puQKS/U
apuSx0g125wWR5TPFPxKJiScjeab77duqcZ6yGVwng6Ewoq7/RYCu3P/RH0aA6vN
CYZmp07b7LIu47XLjgkhIW3l+HbF+3Rtww9Rohs6Loh6eS++u6FFcL4yxOizgDiM
72OYM2ucxMu2bTk0/EbcU+ubLOWv4xQepFmcfGeU9nM7+v9F3Yq5Kcd6FH2WGxff
q43XRyX+ChzfjF5u9VtDq1TQS++cg8dchB1K97oPrHxVm3bLt/PRDIYqYtJe9wqY
k9djOBsVHB5n6rmsZynM/XlVeAnkPcaa+2dIM8ddd1cP535CHliCWVY1SPzV2vsf
rilg3fubKevFjiF5+5HjGTmuRFxKeaboHEG1W+NdZ17Wx0XyVdVOqw9CKh/Dr4dy
+VOucbnoiusqSO8jRe4LeWkSq1+JKwtXE4+XtROGQcEbl6ZsQGKdzzWJQqCmYKSJ
IFNdgABpjg7EXJRmEzy55xVnmVIdE7P7a4qU3wMR/QLeSH7c0D5sMo/HtCryEzZc
BeaLi/mAQlpwgCxrHb2TCFC7XFgQkz/Z/rq1OH7PViQscyBZWJt9t6hyS0HF0t0q
/DSi9+JS6k2cdls+ZS8SjhyR1JOUongCVLZ8xTgcqKu4S24i6n4jQ1KDLwI7OWQZ
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
oKIyCdyjIEivy2xCjM+9J7qq5MIwT6xCSaNURkNMqZiZQffeeqTXZzk3dfvBlrkK
a11YHSYhC+STd8DmWSkpgoPaxjxWu9ANbAO474Q/GiNZ8FjBM0NvP76xIBiWYUcn
QMatBUcN2MirY170xdgN8pw+bcMwrP8lDDmYNQTfUTC6fIYii9ezDw7VABSSsBz7
eDwDNzvmgQfgL4oq1TMk8SKH8y7fzqHWTmU3edvbKAka4Dc5sKY4YoomoRXYD/t4
ft7HNvx1TuZTfSbmR7SU/zLfP8p0ladzhDN6lxJ75cYpzPDvFP3h/OV6YT8ll+FN
/KlIRJ2Bd01e3kzK9GAfDbDz0RskuDMQORiyXksf5nB1LZISEhOhgbbbqDEoCMYs
lrH5eFaGOegSkm0NFhIteQ5iaE8gAjCmWewWz1KVIGTn5d+86A9r1R+3IQe4qFvq
K9Fd8vgx17xg/dkCgqUYFas12pK2JhW7Zi2uaw2a0/J+jokUarAk7oqpZCMyT9Q3
/i7dCencY5Jxxfy3qNKh5tcfwDWSPbOXM9AI4GM7Xt15OHFAoO8i/fmS4IYVmhom
QuzAporKILiC3ltAKGDlmP7tjsn0SjZjAoZ4GoTUxRsSPII+sc9JHdizD/+CTM+T
JDFKjD/agDayB56dqhReDuWYUYP9jZn5nFjenWco0+gM9EX4JXbNALzmzd6nK4Du
dwc/pRdOM1QUZgShHiojEg5kw3utyb39A2+1IE44vrDh0HF6789fRAUgO3/4ZRja
rnJZUpKWevp0z4DemgrLRTFsf5BmV+W1PuhOo7pe3rzE9K/ovfczIu7tzr7Moavr
w0OV9jB2IlEnJuVpt7w+m1x2MteSueR5tgoezAls9Ln3VxvNp5631oywalsN0Z1m
F4CKXJ/XL4XnG6h3bb+1Lup1zSJnfAAW+a1GYyYzs42cFkltf89T8y/t96Fkaq+Y
DXFFDewsuY14LLoF8JXGGXcvRf1T7/0PVwyBsf8fw4QVJQB11sK9yPXoaJPbsbv8
vjVbWSNsV9hQuqSgUxQyNBdy5ILUzqOo9sPvINqMj9fqjHCb9c6mLSUpC9I9N1Ha
ntAV8R/t/tXMz+CITVNLT/zupQQbm3nBPljoYCzWchEpSJWqaT6m2k9jSl1Ale/2
HgH4grZupmCZ8T3qpWIMLzcNucSN3tDPTwp/DW05UBaw244wCDOzYOKufZOGEQvk
5jZy2H50F/ykMY7XHlPu+STdXiBY+M3MIu1cR11QpRyyp1eUElEmTJWuY6nHIXFb
83w29HmzzrACQDsZpKpEGVHwzcosiPqdIo6hMXSiNayFs2FjY/Np37z7Big+p0x5
95iY33Tr4yeU/DNQjBIu15VIZrb0k2E+6gdXvODsx3FkWJl53ch8T/tfU/OxYudO
QDqjIBtgbuGwFDco4tc3siib+2WyhnZkAvdUuHyUUnsCVST1iB4YCGEhK2vhpzAv
1B0JR2jadYSgdN6iKQ5L/HZmMT+c5gcN51LKi/hIKLeNSnOc2UTKfYdj/Jnt0MHE
/SRajHGMFvJ+t6CF8VAlM1aQNNxTvjQSuO0DaE0WBvF5IAO4E1KxOkvFcD3/TvMt
oE83anIMv2tHgCE2IcIuztLoUKbp4mYVbm3ECOYaxqd263/0GzyTVV6IQOnWhJ80
+5hPX8V4FsNuUxI8e3m29oBORmanurwIG+J4J8uzrI6HWd1jxHk8PJBhck8AM/bf
rD2Z81sY6Gt+ejRDE6yas4/RAF4Y2FJeT+8VI/XEiSRDmsByvs4w4axkdSAx/eEp
i3gCUtsJgC/Rcd2FOfN3WZsBvUxAxFHwMUYLTDZ6JNI0d+CcWk5iQTIB5LAG9l0a
sCqeVxU4OZSuzP8TyAPz1JWRT5aHaOOuEFXukc0oL9YlpRox1xAG10nHiGETbZJx
6TbkmHmmn+ARxwHrhsOW2YQsnjet61oJQIaL7e+T9q+MTPwr080NNPeM8HSAt2iv
A4e1h3RLExnfzW+jzXPl3H3hq2KHyCaDMBtQSSkTDCbuY/tu0p8q5xEWJ6UlEaAt
Tij6d0oyP1lA35884BeNhr5mue9IaYBYRmbRht3Ca+gUGPtMOMa3wCsTayqoF1LN
jrBCJHKT2Q2St31+CFh74sO1Dh1lCOAzuqR9/TI0DtATh1msFr5hW5dfUnQOXrvf
RFRpbJoiGZOdwDElc+usmpvoBgdaqo9N7o9dkaclCFyRFB9/zvrJj0xkOewBCP3u
+ifXEVNqLLNYmnobuKxRBEii6chBbZBhNGWeH9sm9i5HMEEK1cb/AkVWbF5NyEyR
jp/a8sk759lzeUH0oVPDyHVFuG3JoX6s96CgAqg5NsqkpmCt2Hnvp7YEEZlZ22WE
IDErYIdTAeQZkmcj933FtDrIheexY3a3cZfj1WR/+tIMzRJp00zUJN5tPWocGI1L
d/mn+Wh4ZZVTFnUCtTVPEpEczVEMQZRmhQhLqK9eAmIZzklJQA0dujzkgZFDTFYb
NUYAh8upjH4W2P83XrjLqGilbv9d3Askit2A1PFcO0b2JdcD/Z81TMAlWgqp+L8j
ji6t9t436jnsK36tEW33uNDHgK8Tvjg2Cfw5KhG5zSueoofieoEe8urk9c/YFPmX
e7coOSiqegOamUAl2c2KVkW/O8Ml300B2ALL1hlZMj9ETy3x1mh8ZOfV5rmLx9V1
cLky8oSTAdpjn/RpyUH79jW5rBbJrB/88tXpAppF7eExHodmLPrUa03D7kvwDTxc
ocl1netUfBJNcoXsceJgTJL1kLK2mmv9ogtNMbi4duYyx27yorj9FJ34CXMBKJyU
TRtR2RKn96x+5hQEXS9wdbySl5/xdcMF2pxCitYtle33qefEYomadIhBdtV3rFtt
dmL3jiNV9ehgg0zCHMp/N6x9O0qqkTgd/fRUtXq7jtJYCXCvYS0t2jTx6D+hcOiq
3qcu0vR2RuzlSlzEM7IZWSCkneJHjGxQjKeU/4sedTb72JfLtz0xOKKaLlD2VT/9
IxTLIApbeybzIzjNjfh1e/7NVdSNGiD1niMSpEy925EfM1U6gU2VWkc8f5bLNgwZ
MoIJpadinFjmmGdE+JmmO7RmmFaH4M0DK8dA/DJvoYj64YXMMM0EEIX1k75Zftkb
ezhgkvSBYi/QNXUQPfhAjMInP3TlOwnn4i/YAsFLkwgrhB2DN+706F22x02XBHcT
hC5sOz0JaqFBfQc2oHIL836gRsA3lBbHB2eEWT2nZKD7oDqr/ZCkQDVfSdGv7EQE
Tpp7QlZotJLyGmLMOJyRV6V5B1tullqu3AnBtV9Et8kNtCT41KaU+SSMLWDRM6Zk
mzlRMNtIoXAyHmjoFqEprizYokF5c6SVQwNPl0mw8o6LtuP430ehYKjT0PmkqpWl
x5LveMRMl2fGPr3+q/ZpJmud2QIcsl5j0w1AsFIVPjwZsq/nA3ObkIVs26VZsU6o
Sk3b9lOHGcLWnXoSYUtd4UJ8fYbfoKv9iAtc96fuRX/wfAxMYzFh/19jaS5IG/jv
OrIp0vJ1SjccadJmbrX7rMLTUlzQ15Yk7Gy5DLhLfTYB/RuKy8h8MvtrCG5L3h3p
pmrimSGn92tqiMpSO1og7inwkA95YaTOCk8ZrPqNRxYg4Jy3nGn4qohwW4Y68uNQ
Q68XngT3PDfqWEHy7ncT9WW5zI3JUyuuOX52Eh0A9gtvISMbTlDWlL7Z3P/gMxFE
AyYYYZd1lBNgK6wOn5PxVVdmjeGIFt7rf23wHfwi/UuBy0TFOoNJaAXcUUKUOS+f
gCN06LEaPjLWYsOlEN0/tGYxOqf5Lzr2EvolVYWHFtXcd4cd9+JQ2M3c+hHeu9fP
Gx6TkRe7ASCEdDw8ELvMwktlbNeSZtieGTtqGLU5+zeL3L+LHpUEXEsjecccNLDp
2+CjVDfLI/LRwlaG0KL1RMd5zyMPBc5hcD1n9E7zAmyrwkdykYVM3b6nROhnnQaE
QIG7jVHmt4Pvg1qEgtBCIfCrsLvjLwm186b7qvu7JlgDXwGj2tRD8KcSum2/flta
D8h1WlIDFAYqZby+/3f+co5gtgnY5zDEFbZxmILmHJ/FsEbLEfrIpPMjeVEoYn6R
Z64Waq4Ztc1hfVEwiDUDBEKb66bwQaVK1jGFlMBi8r+Lg7io/NTAcV7kWOFhReZO
agb+lUhuGZ6Z65miV8RihtTBOFWEIdd9JxaYA7xfnxcBp7jhSSmqqAUFgrngi5Ix
3fUhJ3vxsJxXNU3cAnWUHBCEy27czgh5Xf2A+PidX2DOX6VIbMVlsn/UlrC+Hukw
WMIjfjKxvTO1jMDvyahmR1sEnq+gDx0HH5SzLsB7sCfReamFoytLry78o5dfXeF/
w67JiG20Q3bdO61RiksisVmLD5YshVR82ScuOck2l9pH2dU/z0hH7QPyCJIzflTe
wraHRaIPBp9b7ZqefVAgnu79RFAHoif1mnutnKa7rpeo8yQhRFb75nOdbem1wHfa
rQVNaOyEdHy9/He5uHZzJ48Y1CdcNlHfCMdwmUpQmoKR321k/gmUze83RphF4vWO
gW31iWmna+dx05b7FBn6F5RO50ApMEsJrBnrwPws3gMJz4uBlggLm0fOJhEYE0Oj
rW3lwts7zjqE5XqbduarGlDYlM96G1+JAP6jaA57oerV8RD1PWLhHb/uCKo8Auv/
foiDx+uRYAm5Pwz32mG76ijLHkLZjAfUFP9A3wUkVHLsSMIOpwZ67nFbajjhvKQf
uVkUBnc0DvD1/XW36Hhin+SaR3Ao4t3VVnQ/F/EBLjTE9TgnzhIKJnjHshNk05zS
XI7g3AUu6QNtxmc2eHhQDXfKVxbFmHYItTiGINFWVXJwycbQdlvLn2sm+NTNVzij
aKKJckylD2PmZKlwOy/zm8HAftt8iSfz/fFrfgTXXYIhGIaCewK0FtARlC27nIMf
zMWBLvjQJ3nXco7egIB+CnubC+OFf6/qiR40NWHbk6pFyUU6u+5zVYsUnOfofRf8
cg9CSKFAfBEU+0CmSMfq+6kTX+a6d+fQKyUwaeI3rJunh1GC7tACPmQ5DbErZd78
c9BxU5OLWZDnBLyLu91hGqf8RMpoBkJEkZpE6tYxlBlb1ErY+3pP4ukNJxdVqSWU
Yqqb+SknxAsYVvnlDbbk+eXcErX+qHpqsXuICvozy23VPVjDxUi68m2m/OcQ6eK+
0WWFZlQL5GNDFj0h8vYZQECQyU4nRLuSaNoJzfdrJ0W1Cxo1SqyRE7LMp866paXe
0cK2wNmq/rLmoQHZMAEBQ4bA9VgMVNAhSsZ+K61PEATw6KQKVuAr7X9NjfblIlYa
r9QXWyZXhrLtBt7hixZLQ/8ni3BtniZ9SlNv31EV/IhEqYqKCOPHPGAkxMJAwa2O
w6SfNPRebFKGmoEYFkHDcNHf1mJJ/3HYIU907ZbxCpMdDM2MVAiYlp5pQCPrhTwJ
WIMxNEcOpLG225yQNJteIDU0tO4v36yg3P+tiZfMx/ZZG+Hg1nzkCVCsaUXduzRh
uNiW+ilig85dA4eA8X1dS7XfVg3U34TbVj3DWUcOROdfAFnFO9dPK29hHImWsCMv
4RHWjTaWXVRDbjhnQwHLAabbX4Mxv5IgYemWGHDt2aqf5TVnAswxUgOTBNHLJUcN
QX0KF/5oN9uF0EbSgwGpUU+wdKQop7xlHGVQ7T75SqmTKDqQeWUTW31+8qnrM2Np
7MasG7HhsJ5omO4GCwIMIoIdeb03z/iF7TlZt5YrPBiE2c4odGOQlItuNR9BPuy1
JeSmMLdmFeQquwdBFL+ARVzjawreu6OcH5PSGKzlGfkkEWWaYNZ1duoGoWdoKZEL
vnw3oc8obdi3Yg+AO4aH7B7IIhyPdMJBFca1ouN6ZyYTBZWOHKEB1WfHPjwhV7sq
ZsmyffJ12KwGFoEDTtYrfWg7ajbXFVZ7+oJydxffhNPkWpt0G/s93JjEcWxgcQNa
cwcZNrlSl6vZsiwc1PMnc6bWHnzCLH4OAVBFw4EHMDZZUKQaq4RcUTD/Uguez/jz
2i4YYrw4KZ2uMN0V0Xdsd9h8j0iZh7AiOX23kdokDCMPKzJgrwzZ8SieWarS/dj9
52f25iwvg0lG91m/a7CVYJQphCab4n4199UTwt2jPwUmrUM5qKA8W0jj1hD250Q1
FAh5qZWGvZqQ906bRVXEmNrrsaD/AN0JG5XLpuffLVjt973ljPKvGWWvouNy3dJA
OfSSPULbgLLoFN5/4zEegdfN06TiVTvEgodrR6trJx/L17lkOA925hZK+ME5hvvl
B+c+9YsXu6sDTAr0yh9VaaiftKrRNn3JCRQ7Gc4Oy/ap4gYWOQz2BRlyezvJD+gl
jq04XzQuE8ktpiagnrulYEagQbtL5myoYoaR1S2dE8AVD27nnfrkdXG4wMte3PYA
o1BNQDkFzRDFPtC/AuQx3257eiH35MwSBAlEN9ZUWhwTaxf1d60QHo8L3JR1GrAK
vZBvLAFCHiYL7v7E4+IjC1ahWOEIH+q1SndLKNvYzDaTSLcv/YQ7KvFsTaPR13TK
9wAZHP3CHWcIB3KjhS3NJ2yLp8lOWpN/apPIKyGUjcxjnHSsHOAOPN2wf4Qs0BDY
JQou0yFUrY4yKjOaC/020O5PUJeIECg8hPSrcLYoi2itzVnVD7uY00oAyKbsfd4Z
p3gcu+43zLBQ426ERYcDFFvTG+34DXfbUktIkV4ssq0ispxFikVaGKev9wxIJUhS
ai/a0dVJWdEBoCYg8EYhjXH3IwxrImPGWKZ5CXoodE6OAwDgOsZ6jVWvEF+RQm2B
KaUl9meybLwlMRbmA8FspP/tPC+t2JBDv+MdTJ6JOeYs0/XfamoExGt19wh9rsva
CFZEoe6HHRs852evQkokuRiXJJPb+0bQMwXFU9OGMyFGZzzLPmidHC2pbswpatVA
CJKDYJr9eZEEq6by4GvdagSf7AUbtGgwCSUpLvFay+vqSqkt6I2HzKXcBi0InyLp
fAj95haXE4ty5p+20X5IXOKEwI4Ddt/Qf4DmcaJzACSFuQpsvmX8xdr/mFNb+yoZ
AFvuDnApLMmsHiHVl7HLtmH0A5CJmkTIwdwvfnx6s8nXQlZyNs00jbL02W7yOkzJ
el12iEckRwZELCj1hQxGKq0bEcfgTb7fwuDEzbJpKRTe4YFHL/+qkzWg7/6KwEGc
YK6Ndt3eXu4SPJ9JhrSaj6vrk41Ui+fDd+6bWL8m1szG88rTwsPcId8akmBpRgAL
XrHP5VkJZE6247a59ueKCdx2iNw4XZPJmWt52jyKkQLELKkjWqluxLYLJC9K1zJ9
9sY8MmYZxY4OhhBA0pPMdgdgxsiwjBscEhURsos1m4dCGaQ987a6wAFdF5MAuq18
G2VJV/d4p/qKLTBthc8Re0Vyu8vXEBny91scv0CGTZZ3ckfmGVZ8B22E35VEjzPo
dxOsJIuAUn5NdO8Cwd/L0x7CJ2Wr6kdZFq1LXkVlQozM3am0bhrduYy9SqunAxjR
BK2K2zku7gCD+voBK6mlUC2GjXFlRCul7yq7jncQVDBfJTZ6KpcU1U/JhLuvaQcl
nntyJpVwpKYDPftnzZPo3dhOOvjfIs4T23hoQGmm0+K8SuNLASjPhp61ozsPVfIf
IBvWrK1DUm4UnUVadTnj2FvBNC2LTPrD2LEFuXQrr3KaE3sqYwhfcU6U5Roc+oGj
ZutPAHDV3FsHnFIEOc6X2CfonNpGoPbUitlQ4e3/qsIICNdf6FBNnh9ygVfb/7Gc
wTQIO8myW6G/EGIlIo16WaMuJUfUqfVzjj82Ua8S3qE8smysr+foweR6HYEsO4ia
JaOEQ4Ho8+H+6LBUBiUq4xXwu40syVmeYo2YotgWYqUhSf0jb49yNGF9IVogBUwG
4s37+cn/TwEXQIQTKCXFQGtTpzUcof27ZQPWOzTlWOqdfCtu7s0e+NOqmANaKK/A
UgK65GD6QSA5oA62k6WzwDml4Ch9WuUXuEp2LU9sq72TIRTDTf26eo2WmplHDuLV
VTBKYpk94SU0/+9Ba58+9zAwjuRw6otzZQu7vdVWqr6uJ6g69234RgCKG2Ff8WeP
VBKpkvabfKb/QtcjhR/yIMEUiVf4vQkorFVX3Fc4bBnfN9BTz0UZNt2+USln4aQr
jRPgyzx5b/CL3mktot6sEuKpCUSZF6luBxxF1DFATYani567fFJI+9d6VNfuloh8
9IVhlXcMpS2mZlXHNMdzSk+EuhFlimkU1SwIx7lBni5QEfp6EN4qIfdF26Avmq7H
urf740RbjrFoMhYPtqj/fktTd2irmYNRG+HTdgCIsLm/TDH7n0YQDqXX2e9V0TFo
qNB1To4479nONLNZuutq1CclV3r7/6KFjMYvaXlL50n6fNs6fjvRC28mcd8JIXkt
yhObNZJtcVIsLJOeP9v18QxhDySZPi8b5ULle4xSeKMUawL/oEizNc0Ui7MlnwBs
9i2ZUtG2C7f9+sHAXBYPlsIzuAFpnFiC0PJkO6AshoJa/3zmw0PJpsO8E2N8BHo+
oyBCuGCzUoajMTHtckmRUT+1J2B14w9OxwEXDkQC14mC/87qPuDjr/Ip/06IOEgP
QfgRfvlHb/kN/CUAMm1IYWvxtB1QXF5mRDAa/xDcBp04LabBe9hyBl4wevMnO1iu
NYNuv4/FCdYzMBXa5iut0SmTwCaBb3WrcW4IyN0i3Z1U2SIo6Tf+hkWFBEL6jblQ
MzMKTPDcryGOhpH1tvauyAD3I0rN6Lu0I6VvCl0cba8IH35x2JiY9Xyo3KIr6GTD
WT7TM0DzuHWHilxqd5FAVPfRA3zr7ARgSx+X9lSvM/m2S4ygWguSA69ZdExbkBar
0xBlHywclgkfkrVzvbuhXdlTYZpacwYm/j+jZzZCXfDNkee6cQDCVeOgEGtf1c48
DVuxGOO4NLnWU1Ipruz+fQ3Ey7RcfD8Knfcrsi/OoL1JnrMOqh90rzT7E8EAKEYp
uDz/1i7ERIeXp9CsRFN4SuJHfFBjO85fMVYx4D3UiG23tGCZ0EgQ2kPFJZP2Eeq8
FtnBeoLT+yfZIy4hEyQ0fHOglEAlEKpEwODX25uaFqUMUl772Mv9DNTu9D88sr7I
ohP3WcUO9bIe86tpbm/GIJr0rJjczPlq9sjGOZ608Q2K7AjHKXOSowue8IKoMGQ8
i1UJD/1lNRgproEOdDxJglvvY+057IdWM0jQyBtYK8q7DwHxkZWaECa2acQkWthG
mkiMWGIk9Xtmr0qhsrPXJLQkU7/BFWROwdNbDd6B4e/+//rTtd3aSnfvK+N8rfLK
Ob8kXp16rXJhwt09uzBEX3Vnxfc+WqRJfU28ZgtdvuN3AZT70pK7/xCicI28sG0l
Tf/YsEe1tagBHlLfkUTH/plMI84ROjPMuQUon3ZwNnT/X4WtM//FHxL5OkUXtFOq
zaq5e+wEE+VyxjUPa8MZHAb/bQXOgWRw0s1aPCCpewxbPYo4qYvcdEGO+wVUBH7i
Ea7ySXgolyt4HJxr3m2rH70+LIM5Xw92bdjlEH99OAqMjq4mAsxQ2mD9hObGRmFv
NuADyHQQpErtbE6HO8Ik+4/HEzdL7rl7GpKf5ZCvUewT/5PvdAVgJvCcI8QQdO3X
axRk1Gf5CBZ3vO+iZ9zSXNyrVNZQs+jH2RfVTkuTJy0anGCEgWmLMUvX+fBsCX6Z
sgv9zpFD2Qf33aJPBWEoruw2psnjPOf2XNcd7tSPwxDbBr4PR1Nv8gjlJ/QwQ1A2
L1IbLHla5iKI4PPDzYzSenCcBmBhaWvg6+x2EGPS1V8QjpcrA0AF2N8SOO9Vz5Gf
FYaz5s9lHesmpPFsXDlF3NyVbtQx4HVxX2jlTHQoC7hdJnKq87Bs9DGIqfho/KxF
jzlKkvQU/1GZMzOaVVeaAdFR3GSIdBraFWratgR7dd+I4CaBAzpN3w7hIzohmMyA
r80olAfXp00KU0a61s7LDW+UoYnsujzNtHE6QSNIhWoAQ1K2UmdcrIw6vpL+u7g2
AlLiw1IP/lhULWmbPvpQkz7DDWR18vZeM9DkPTsbcD9j78wKfqni2YBOwoCnd1fu
YCziMvRPyc8N8VdU6n/ncvhbQU7irriiJjeJVLXkpx6xUIhOXx3wK57isYZ4mlEa
oWy8POC4YxKJZ/v9P7yCaD5Lp2wts0HRrNGUf7UfoOk+B6KaYqhbKUV0FlVpJnLv
yBEA6FakVBBVyLBtbc/qviePh9KtUlKSeSQym1pgjQJdd0wARxNK9uyFKQwnRj5h
JxiaeoKrrZs/tRXam7qXcAfHbuH/IO8QL/A77UMQUUnUvfZ4Q33plD3pn4aSvUOk
SRmVIP4QAQc0pI8SmyW9n1pxBGKEqlVlb8JR4BUvV+/XZg7S9pX8BvafVZfrsIt2
Q4R5dhqHWGGFHdLy41Us/cwZZ9GwPzegko8vesSoF9rjiycP2NWdxeO4shsLy9P5
YpES0sXpqnhhza4xuCgrfrM5RQRBaqxhi5Jltv3FM94j0+1/KlCqu1RBFmuc0rHE
1fZSNsb4W3LCcuz+mO4lsQtl7+TpOiEJ8dF6edZKxUxOkMaqxO9fpRKhjA7lMzzq
saI3p30z4ntGV9bm0qOFwpE7w4jiIx3mF3THOXNeAHjkV3b7yGBcmIfG//Uz5o5w
NgCgDF9Qvy7PshRQdnhNEEihsNGyiBTHagGxWczUM31nFpyNcWjuZ8suTTehHSPW
X6Jyr+rKqjZyviTUaN9QxytnBT+ejyMVb9OaQgJL6Jy/kcHsRUZVl4ze9TrN48cy
sP4v5Nzbik38IRNqRROdQnR0grk1CY6ws2vcowylV6veGZFBiezeLmjIQAM7Ar8C
ARri+8RHDb+PrllV5EesZPd/hCbpHrjQLv7ZLj4vcjKhX/Yf3RxA45DRUsi90Dyk
6bgeumFz4tXQMao+eg+wBnNKxU5v2yHc7VT7WYuIOHvl95opPRu4IvBXyLg3S/qE
nWnMmddyktbW84+bzADWpsPrkGAzKvEr7swusdYk98uj3ANUTkT2cqVBCoN/niPA
RPUS0CQtNEJ8hjMT9kWWL8/69f/ecHl79+jysJkYT9EovU9O/LIRRZ1+BgOpv1P8
c3yVaEaRaPt4U9DjgFTEDwNZCHJdqj8Bl/7bSe3oVuLyT8S3vTuftzm90GZQj/6d
l+mBmG6dp7IM24rd5m7KSbvJh0Wjde2nEQFWbTtfFBCPiWS+aKAh5Rj4ho8ohVZn
qV07ILw2HTZVt6e1Q8UqSGRKXEKDyGQADWrKFUz75FrEC9A5B22ZQvtv4B45nxig
tsk58Xuj1FfqC3SYMjXGPDYNp0oICYQVIt/DiJoo1TMY/uCPjBCpAlZ5XCHLCUQv
DmpUpfQAj8unjEkz3pMoEqAywP4I1QfNoCiRzWzy3PebCRuM1Iv4j4Hvds4Hnzco
LpWM6xW/LOdIocpOESHGyHqu/EAdpPvDRtK0tunbwDBaU0Eb2h9/xYQGoJaylTCo
5/EzcXWO3pWy0f2+Cwd+wGtzqVtUHtVdQ3qt1JZ2fTeX7IjxOC+H7FHJiqBToA+/
AzrmKSa/enVFZp2BtALgSLGpnicQoxhOJDfz1WED3FfiXu4hkQzsgOD+4eW5+cSV
OazZ+phmoYZ3j0Hn7u9lShaE7yh6t6Y3Zd155uxqrfn9qLw77eg9Y2OyIwcsKVPD
Lxp3GlM6V+ODAbq2Z0gpKQR8dzqiAgjQVCoNGbwmRtwCm1qfp/BsT2PV7PrBmhGB
UYDa0hjhw6YzVmQASQg7X6V8KCRPcWbU9M2AhIJSWyiP+7iWx+Y84vVy/sMtCIv2
XuxJOHKoyybFkg27VmRb6K8VUdNDlsZ4D3QRkjBXepWGs/w77Z2OW3pvwe39dwwT
/BaA7DW5XL4lI4Lc1O+xmd2g6/fdSvBqul868gIyC56xfWSbRTEqH/iF2Vgz3cIM
VLZKBS2KXNY0C6jFD9cHReaoILADqDBq6MO6j4Tt7opcAHwWf2G8j8uiknHiOtik
BkHkA6qslSDPcbHkj3ifFcTCgtHYijeIMwuw7MrXzixMdII9ARb7VNEcHHYH5ok0
8edGtyT5M2A2urvQCdkSSySy9c79LIsv+lVWxV2CiDYYKj90dP2VW8BShgOruVGd
xgy79QMXnRjcbrbcNiMkLAXbm8RQ/LVaRVg1hAAsx+ATua1uj9OMyAnh5CiMuvdf
RoLBxdVmGXrwbHtTlZGPS+CaUOJ0xSNh7/4fPnrqT7hksTIqNw7UNg+eim6M8Oca
FjPOkDRVAIU2QZ4hg6u9ceEH2vmpZipWv7daFus2NRS4HRG0dmxNABDY5oMqTxQZ
YDx6xOAa2BoKWFJBO+7xVV5+0UWtvWIsBxjhTf3NzFn7WErz3yL9teCmiI/lowb/
pqGjXRh+eLP7BZ1ToHxuFjvaOPb66kHyN+/i3/v72A8Gq4cL5XGq75jzIzAF6QXt
EHM61QynbA5fXiHajwchEyJyv2lg2duEtVXjd636DN5DJ00WqvYqSFKlzjwMm8sj
JD+vI0I4MqW7FYb/OyecKo2d53Mjl01MsBKAdrdAlEiXMOBeO8Gylu3PbR79zWig
Jgc0SQE7iEa9IYGnc3N2DNrktlNo9pMSLgeWhv7ogJ72XINTWrBhcvw3LIILSUQV
pXhCXwYKLhjwzTXI+VWF8xtEULyKyR2xkOQLW4TJbBf09r0i0crwBHJE1WnlbA7a
zLVt/OfVIebPpaSeSC2nauu/km8cTx54NmNTR+5hB7n44rrJZfGV9Pv5VDGNXYUk
kkf8TrlIJZW4cX+fAywbbMrQCAvApyHTnnh7DiXpCXA5aRoGGcxVxgWZmaffvejc
aKWEP6DPLUBNDVGQ3Aexc1XljMRXVyqFHXCeRJpmTo75CHBFWY+lTeS+suLqT1jF
65upv7MzVn4KhyjrCgVd1ROgfhI9diIypJCckh/Wl6gfWi0cONzuZ8BH9yPPH7/j
nlgqCpbQsUIYV8y4CUWM/51OhN92kbCRN8J+9M5uC0E1B5747Bq4AwN06oIki/Qb
EkcNE/o/57GfopbFMzbkAI2jTIILGniZW++Js+LKNTufFy8AZuIBgDahDOodTtTF
84aIvCVRR69Cv1kIkZEivQP2/fNKL1QUA2ohHhyDPEokda26AgR/bbTbu4kimvHY
lIjuZY5/X+wcgCjPcodoUXqnygM+8U47dVOmZOw1g98ttJ6JeqmMGwRmyWuxhYlf
LdKw0nt4SG+jCvQ5cJCWQw8kxxwDce0gzxvcUAm1in8zOyCIwMA6cH8sPlOrvP+Y
eR2wGrXHpZlukFpFIBSIpSaljcCXkwp70A8+q4EIqtnq8JcEo1hB6DaJMdQCk3ws
Omnv6l6XM9Oviv6av7kUhUmC+A4aOY+90pwvgBs+7w1vszz1ujiYsrskttS4bvGq
CMUBCY7YDNMGRA8kS6tTbEZjuhbeEaLT8kTLGTUWSiqEZIW27A92mBl57pn7T/3B
iDW2CBts//JVfLQP2E3x3fVl7s+bI6W4z3ESlXgU+XbbyaYz7X6G+zRKWC97xwUf
kpwOHYF1s/0vHSYs5cHfhXWG1o2HPH+OvaN4pr0lzQL++JeT14MGJ0TYrJ8AJ86Z
teprc9FztEsEt+cCdGFUVh5JILc/W1XRtYhJdJa8VpggDC+YmgDbwv+rwDJlJ8UP
y8oXh6+jAVXdA+bdRK5uE/FRYf0VWo1BbhHTuwrU80svIMp30kX+pGL/+tx4sUhw
MDEPfN7zx2CTvSL3XtKJne4mh1+72j8mVYcLeM5FT1c/xwk2yYu66rI2KUhVyD+v
YenZ4IlSYRpSo8n3AXEgHSa2UMhaJLfObVav5zNigUM8L8YP+9Eox5kPTVV1gEk9
dzQi82/ehwKvFIUpRECOWcGW8CqwiA8tv88VFdm1YNt2ktmEEKDHuE36xombXEkE
4T/RLytnjz69D/gy6tIuz/UpYQG55FgpecDdlEhvX3jSvpM46w9Eavlpv3fz/H0j
bZTL6tZGhJsFH6m1hXq1UFD0iI+El0g5IjVaYEGEta3wYqEyejm27ugY5/vvqiH1
XGcvlfH88+n59/wC138bK7OfI7PmYV7zHGhYtp+frT9fDQRS31X5Eg0RixCvcOmI
FMFOU7JbgJ9N/6phKrPVKe0+WCEXfOtsCB5Nz+BIwkVeq1H/tJvJyKoTsOYd6aVQ
4dvYyZNWhhJYnJQ9dmqYYOyay+7ajS0HLMUh5EJm3hOvXvYzfAj2qToc4u4B+sd9
0o4gnwAPialWHsi7AgXs3KiXdDINoHlEuTRpdbv1hA/gSidAuRMlh6IDpmBr76b/
Sejnu4argNb/ZsYr7h7NhkbMZ+393OsWQA0cVnn6BOmEMdFJxtGyXx1QnKuYZVQm
XUKu69Tx5fGeUpoXLh+kc/edpH4p29ri2kdpPUfTwBVJ2W3r/95ZLpoI45i3tofg
+bEcqgkvFtdAwHwR2U+S9/Lro9c2ezFKDKCNX/SpSVBXt2vgAPH4mVPITYrFcyJ5
gW5Ikxy4uG+tOGiMVL/nlf0w+9ZeHQhaSv/lWY06atSBo41K3knkraDM/ZdRfU4d
ssCBNvS/n2dHBo3oWq1VetDJTMX/+pT4xWg+CMgXgf8cEx8sAhZTjEjyAi1vQHSL
EaX2Vl7/vhw2Rq+zalDo5ezwYjYTct+S1khJMH14ISfFA7E2X/kbTz27x/BvbEJz
+PPpWHLUmVjR48w0oI8ldwt/H+CsiMF5kg1ZjVLfnCP4GWoKh0r0pinIhL7R9wK8
DUgAz/bmsy7daUFWJDTBCr24YALGrwkyqBqoqOZ3sntY4HmgZwAu3qwTaJqBJAis
2M50oPCHEGqWZ0qdeMtm8vBBk64UEh1gAWmIP/xCM0aVBxQAs2dC3cryc6S2fN3B
Tf6tix7dZq8SqgAVypWXICM9S07GStx2k2okG6biOJH7nioEg0euN1x4Mk9hIrFn
OR6ITHgVvquZbT27Hik+7yBQbK5bGDojEy0aNJ8TbGaOh5lkVLn8g/wvXqwPmr6H
/R2tTz48IvYE0tr/kuJLPBHIZm86y0lTGANgS3TyjmdT6VRH+LRy/oO/GpW8zmvW
3yUI4Rhp0XkKv8JPV1dIiPVKm3v47tZ/NUkiB3iEwt1stUIR4hxhottaKpNqx5vF
/G+ElUZee3Hv31FVffPIOSB9WtXIvb6LOFBhvJr9NGiKhwV02wJ0+01PnA7L9lJW
5646G9b5v4jOgkjgtgyz1V7w8RPj410gEpCxgHBd1UDc1jWFAFSLFGjc6/Bt+3G9
elGb896oGnn+o+qen4LE+kHcvBIAsd89eRn5F/5wrHWxkF20U9P0srrLboqfZbbZ
aegW+ufWpiJL3B/9XAhfDi7KODFfqIicjn3SCC7NpkBp7x+rvIug04B3ra96F4uq
GQUpyhNwVKweGxOwtXOhbZpy7Pf/mVNY4NCxutYlYwB5XTGaTpCe+k1G4MONTFBh
yMgJ5vixbqyjp1kA7l14o5XZOj9ZMZca725U39VxcG1hGUjm0MBUxeW+0sWOFi2p
XsJn5eyi7nKDpLl6JGwhBT6Lr0dWIilmseF3kwHCkuxAphIHEKZW9ZVBzub6tXO9
HwEUhQHLAApaSgoqcOSRLSa0DNO3Ywl6xYN3rsPPLDyZI38JO9FRRs+XHX/2OQYn
h/p1+s1waz7Q5SWfdtn2pRfbbw0x+ztReazOserlIxWksXbypy1nk4QQAJFZg0yT
RNp5cX4x+6KIJQWPMDobH3FFsuBtPBjgDt9+DxdRu8mHb3qHgJKtDhqlE31Zw6Da
dcK6IHLex3TKgnOsfLUbqSnVAbJHbOCiYbn1TqXOkZT+Rwu/qtPbHeRc+U+5gga3
/fUFkR1PKVWNVGvQR18PDQfR4ojU2dPtu1PRSIV/nWCwwLXesULrSJFBvVMk2Cn8
4UKBZGsymcQVvd5gZ2+mp8necBXJGugAroP+HJEpfCYo9qOTkUJ/1oc56R4Bm8Bp
rG//yWJtqZLCpp7JB4ZPjNhxpWBesuQmktLjyNi731zOBZ2Tax/5yrA64/6j1yrD
yfQMZ1nt2JZTPBE40mdJt0Le9BtQuGvF+av8CC9Ph5NRMiwfZqnnsPrrWaiv3wiO
PlMIlVuAepOB6LRWWtb8/T3QxsU2B/KAXNXyDNcoPJmgeJSM0N/zkGlytl4ExCRH
YlyoHXjObg1xTlwV45tiBDTU03ArReJ3tSs0JOtJC1lODmx/EvVJqdfxIBCmM3cR
iBoth3hydDNC+T8nfACOXK/I44bHkZShHjGvbAP1TNKQtCV2HBSczxcGdIZwjbuD
JaP3vyugyRK7hKWWN680INQRx9mNZ10Q+HntSsUpI9+W2C649NpPDm5rflssI5y9
NUmT3Lx0LSaX+lXgGyckzn+XO+ooT+wu5FDXXZhuPWgQx1Sd70jRGuBR7LfJxaZI
+qUN+gcjlaEYwM5v2mQfNTQnpiWCWJQUhlnsVM3YumqRyls2r3XNbWAyl3FSYl6S
F2jEtznkoNVVjrKq7jyP5KAnbFyj5Xevus3XZObRIaQ3ITVu39C8lhQ9FETijOsz
reMggsjc8SMhAUvbzq4ne+nbmF1hqPXt2RwueLrXQcRYS4XkYYMkc3SW8PZLG2uH
3zZyhCvl0Atkv5Epwsy4I9rCGB2atOpQemkzaenOxLGukt1pTg0NKUfTwg6YCeXL
KhW7W82lpLPJENnl9sW9OnDkH5cyF/74R4GoEnJWASbbFX4z73qtkwIMeBy8aQz/
SkrwCK48f+/JDH7ppwZMonztYW7VRloRlTmGj0jTjeQQoX+WDRuT0ngK3dYJCVyy
F9r/W7Yi16LwwffmgcDc8GbrG4a3ZDVQ34PxciwlM5w1MJ+Nr9ly9cgjzd8nND/D
oLh4Lfz2F9xrOvlmBNuxDfAX+d4Wa3ze5iqvFV9bZqvpW0klGMcuWATdj8e1H/GG
hUYStV/jCkyS0Ss3Qt59+ua+JVw/JcCE8oPLgac9O5z5t50SQUH70QLor5BJ7V45
CpdBt+2bwgLJCpzHJMpIkxLFxhH9byRVU1kzyFBWuwH91/Zli+FbYPjeHq6f5o28
rJ7X1lPntKiAmfvCVW3XvAtFonJjN+Knlgv+L6D7JtOdzO/oF+fzYI6i3BlyVdzo
ts3RlGQMsbVjZF1t6GiO5iM3DKdfYORm7gaZowdY7iD22s9RHSrggWltRgFuEVB4
7Kz8TSoISdg8jIAikn752bo/M7nAXfamJYWJAjzflyrX8cGyEV9Zn1bZrQw8l4wW
UW72LRLAtqG7/HTIy4uwr8jSKztX2yZ7cQ8jIHL+pUomKK1hT61p5RrajolceprU
+me457sFAZyxtrNcmOfuvQXSVpV7CQfJeH2HS306U3rhCXgj6qyAL+tdgaSZNprJ
Ye+Nm4AJxgKSMM3RRu2vbpNlv2an0U+QUNrBQyOiePsERIsZT0OCA1/ejPb2xtdB
TxmBz+niPkBQdBxC3YDvJMySvHdgEYO34Va5P2CGTj0kNMiieT1oLkFKGay5a+xL
g9ln6NxVD1CTpgH4gKSVpjgH0ap6ZqvharXmRckccpYZ2r++/VYkNX2ISDNRZ+Zx
kPh/cmY3Mrvo1dKEHAj08dx1A+4lHHzSYen9ZlTeLFxGbmqCpIuC1N89xhToXjH1
F9Nq2AiWkqkiN8X0fWGhM1cI7BqQs0zxu4CdATrMgrDdm8LRSGozUSlNXobZ7uW7
sRAEIWaH3nppbVXDPdkNsNNUYJjgILDBacaAfs6NsehsVb7PQsx70DVYR4wTlwX2
5yAtkPLmDkmo1s7Fg5YMKOLhnc+c+bKRVNzDcigCKjRVZb31eZ0ap37Dkcdox0LS
hBhpl/bDCSVzEhgwabbMaqfX+stiq2IBqyuYGmhxtlWwMy30hbjBkyfpBkQUwx2s
ai6VYW+qKP5zrefg7SK0kb2V7LDvbB7kBS07n8d83cOQxhP0vzMtpn2BDL3VHywW
jdnaj1DnVE8Fq3X9/8jRc8rssqErj1isIMVt1vsr1jMkkS7mFTO4Tgz4TLS9lciL
oynJtdx4YTd2ockiNmIWfMz/1wyknbgEyFADmmcDweBhWAh/PdKD3bLd04sxTb99
/zGiS9Q2o0noZZYITf+8m5eaZesw7XDJLIHJ+8E2R3o4QjbkiV9HOOfyZBD8ngHN
RVFj75wOmspGZE7UrGkeCL8gYwda4R3K7tqn+3sgQ+XaWKNjtQ/E2TgsUvS47xMo
h2phkmM0Q3tHY1pMDtC6QEzEXlU8BxpSsxG7bTTwaXJc8xVx15f6slJ9PqhlgBWd
G7lVGrITWzWt3neyjM4xw7rvFYKAtqqFWz1JzXCqgVrZdB/4+OIndyzNoXdU7Nha
95e/kqJPfcB0lttG3pKDPruO92Dfw4lDLIKTy73Ie7t7aH03gAecWaONwG2iydcP
Udgu4II2wAZcFSafqb9zr5O3KOBXUiulLq1EaykI9vwFIl6IOOpnh6g+m6WILdR4
5Q97OHYw9gmvlrJGFAIhAXEyPGgGB8rCnEV5BxP89EoBLcE7jl89mlrbauQq8c4n
2UHPSVYObj6J1x5mtpEKDLVPsw8h8LoXK8VMtv6ZijBViyhzmCWcKTLoy/V6iE2R
ufE3PukwcmLAwT+fTwcn9GuSyyIctkLdcKLIxLGZJkKyfwTOXoBkb4jZ26a/W5nL
Ie8tRv0FtZREYqwjYAHr0U0nKtejNpJOKjQjFeHzBM3wXhKHv4ThHBodk3NjLDa0
OzOILUWaYlTYyNxShGRgqZn758cVxqMAH4V8FTYEM9JzizyxwnuMhTND6H2w/5z+
1RGqIJiuZUlIxJz584QUrrEH44mN78xaEukkYUdpFUV4Lq3exl1m/QXt0cLHxWSq
NREd4DpavWYHn6jjz1ZJ32zzio/ugctcsLpsw17rp3/Au+kkZ4LBT78C8qsmUFIT
HX26vasYOW8pvG03AKJykIYaa7vBpDXuYrbfWdQ4APMZ8pCxT+vXeVFaxhPaIhoE
reG0KamjkUu0p71nhzBHgpHfkvRooD3hJk6m+jwK0q0qbvBG3VmC9axCC6BpPhCl
I7Ly9ZGHtVOhpVL27CohRhMstOGXOtWVcq9lMFoB4mCsJ/Jk2qH1i87aQcAf/Doj
UtJAl9WxGK4XOyLY1lsnihm+zEXuYZuliUE/s+bYTdxG4squLSJHTBQsfTnhTlBH
sCZatghy3ES3wZGqphkdRoXzKvSlnjzQT+BSCzt2oGald0uVwR8JRMpJz4CjfaPF
OVLGul3UAIEZTEvUuHIa4LfW/qQCnu2rvMpFwyDX9lC3/Gwl95B/PzHGEyIR0VHb
V9AzfZTITiYRIq8YkPWibfF3PLE6nh7RzGLVZ1Vq8HEfEMh+6g82mb739Vy5E4/C
Wh+UpsHAdMRMSwWmxB5/JRlQuXHSF9h/rJGhEnLX06ybjZtRmeBraCSDn9lJuLti
c4GblT7J7C6J6cgQPZ9P4Urm7zA7bwR8Iar9xB1quSwbVf/d+xLm5mbbu2HeQA6V
AJGj0Tr5zrr7B5nwdVcQyxV7vkG5+NjBugENrngVBg1wdY6yKCMzlBDNPQlq8nI5
nlswMzZ8tZwevzGFIbjRD45CfAxJHjmtuR05SwibtbsgfHEqgEM/kU4baI0c7jWE
nRtFkE46W4upPNw9U0vs/8/gGDOXqbIKTzO9GFr5REEB68FKgLNrqs+dTH36U0OR
xUXyf6MTA9TzOl4IU2mEFcCClZByKL2qoQhrBPG35Cb4UwhYiPrka9EtAoAWaKsY
YeI+rdFVAb2xiSll8kyCVHUCC7c+WLJ/zqWWyQUQfgZu/yOARFhbMjJoJ/Wb06ed
7a6/GnabDG0dRNtwv98Vi2MxS+aQ6sxWArfyeGCjSLyq7CK2P6vR73NZQhz4Ccgb
ndnkz6LgE7Wdx/i10gBaUWpb0eEsNxQjDSzLXPi9RRmJDAU9frBpMFBerZ6sAjfW
2J/u+rkqh7IWasNHnXX9d0o9Vz3Kw+nbh9mE8ipU4aKJkNhS8Zb1pdWye98sG+DS
5DUgY3p3pwuYLED3q2WqIHcE3s8vlPrZ0ccXprjNyeGsDIUg179V0MBHEcg9Wppe
fxzmqyHbVO3BFzxzoJRH1mixV1C905RlypeemW3dvNyS0X2TkdtK3wd/qu0rvtw4
gAHUg9bC9VETcLPuzJTGmRcVsrm7tabjvt9etWGRt6J/j3lQU38ZF26UurRk3W3F
+im4FecBPRli/W5EJCJD19Jep7qPiUqhJwT7bfKqntNl933bQt1hZ8I21pC0WinR
Y96AEwMg9gu9IYTHCF6Nm/uICtpcCQMYy1T1mGNoZH4YOpL/jfSorWHmiKXZ9nbm
n3wwhecJQ/h32xjh4d0IrkizUG/TxE4mKN1N1K3qf4nje60xacfrDI4nREIZWRPI
sX7gahm6S5h+qYy+oCGJHE+9Tmavwv3NqzaEvvtuwCg404pKf/KkcPgxnYd5XVUR
9sx4zK4DgrrP36/UDO73RimnugIprH7VTg2AeDn62VRhZUkHMVUzL391Md1eYy5K
jbC3REoPJdiB8Hw/PQ97HMcwP2xpkbwk4Ra6rabtlad1G5n8TX7huxRKzNOKMUBG
SmQJzTcoMSS1M7WmhIBGXAseKDj8AR8mUNvHS0FVMw8iBkreTPrz0jTfN3pdvoya
vL+kpC2OeyKvHREjniEMRthTwlg1LAVHXTmXKPDSKDx+f9qkkiKCRBcrauyGHZf8
HN08/mle/fQ7katPlb/jpaO1F41dSlpsgz138sgIEgMQxHRJ+7THEaThb3yc2sKa
n5CuKsQ/OZBm/UNvU9z2OGuMqRVyPMWCVPIjEX+pg4rpFLZCoFoI80wpomaP5VQ0
KQoDMvtVlLSNuoqJZ6NkCeXSLhaUzAgiQzHsAGeuwZUp4Pfk4q19RctCjTYVu7Td
mh0/D3g9F1Im8uyQ/uPZP1chyvtESsVFW25hClVYimZDJy8YhGCyNsTk4SGlQjQo
/NqevLGlAzw5Cy6aW1arHgQqUrkTwurbcZLHY5mHBEGZiROXBHIF448LTs11GKSu
uHSbzfrDI/Fhy3b/R+8GfEMXu642xwWrFDKK29ALAeTlPzFxN3DV8FOzbNaTRDI7
PuGYNUQNeimQMObhZG6Vlu9Pk6Y/oBZYRU2NIjbR9JG8XbZUStX9LwgbOlDl6oH7
9RwjISdcHFN7y2HeqKdUAyvkF+ZDfbXDZkyVz1vC1mF+Hrt+i9K7SOJZnJqqWkOI
E82V7bi7Ozy8EFF0AXaf9KgfASELBUS9/NrqrX56OS7owjctIZVEdi4mRVIfwdTd
GSVJZj6UdeXMG/pQkRJFbfKN9sVMPXSEx7WX0HbsPrm7/EWwlORUpvMW7rTYPFV2
diX7P8hRDosQZcbx+UrMADO8xhGNwjvaokFhFDx8Im+nRkVxns3+84DrvCnEBCza
I1JbeXI2J1gJLRbbMPlP/NHE6WwLzRqOz5+UAdO25rPFfcyK6QC8vphzjc8c2CR5
g0Ho3cxY/gZKuHVi8k208VttwVddm6yBJkaAjjeFYBg1FW01AZzFXJWV1MSBAd7C
J8FQQmMxFgYAetpbd3MmrhGrxT2pM9VS44hWpNbGnenTumlXY6U9Qn/2c3l4Z/MU
qVH36ymQnHxaP4xpJt0Q/PakVthpnf3CbAaYZTz8/xxaZTJQKcLON3bB3tKMQ04i
YlSKS/GvtaZsAJ9eO6xe9PC+fJugzkqlrpuyGmSAnXDPTYPU5O5rBwgNhyNaRIen
wldR5I1sxlBKU3TMtAGT6vu2PFBIe2jlCvHSNzgBy/6o010qnhSaWefPPGVkGO2X
w3JTsuGI7UFcc5kOwAstcS7Ox+C9tCX52J53s30P9zT+3gRJaCPdOSWZt3HoXaOT
EW9i/m3Csl4Y0SHIL4UyHmZmePDawXNnyR0IHcqXN+zr1B/SinSf7/23NsMKnaoa
XyZKn90aCcqJ5VWr6TNWcwZyawCk4r8uzmdDygGiAduhuOYPYH72J79opIIEo6b6
k2+foakMXmlMcyxW1IKRybr57s700OxQfMJOUqPNLkTCIB1csEmKRNTBrcepFhIU
vVBXW14QxFIhU5fbXNHHo+YIxwICfUHnqkgtE7IiubFZaDv8VT+IymJlknQXABJl
jCnK8zRt+/nHuGfjX5oYhCQoI070+2fYff2g+3w8rtg3L+LNo4tAteVCs9giMA5t
SEGOg2onu1GlGI5OMvJesDrKG/leQ0UdrH8NmF85iJiCRhYTvgTP0jCbwxOWAa7k
UCxYFH2JB5uTBU0+1iHHQg7hMcdyi+azlT0paysAY1TIiffhxha16GKWBx0YogOS
Y/I1Cz+5Sjp+RRd7IwYZo4rXxGOr6qfwJI3WgPutktFis0Z3Z/awb70jdyq+n60A
A0gBOatXnWOWsvSyNYPUC+oifa7GvF4OM8fXXYhNHKewXtm4OWytpAerTLW/03Fh
55dT0tciXUu9kwpX/RdIcnLcByu8NtKyOxgllRDHLeQDoP7jO7TznQ2J+Nr/qIOh
cytvAZo6m+we+2Vq02rNZJxNwBKpRJMUzHo+/HWjhMvUkwqkN+XnQ4vhkNTzfdHO
W8P5H9IKExwOoxlWeq0XIeHvrZTeiIn+bTe3Uw/zeWi6k5r1wg4StVn1jn+Nw3TK
GveJgBHzIrv4ad+3+2QrMY2eafsvKYxregAH5YPtldLC1GkdYIr/QmBaLTL7mERC
zTmk97gfVzXAzGbF7R3KmTGkcuwK+8+0PPNFeXt0xQmTofWGTAH5Py/uBaMQSxqN
DbF3N4AO3h/LQLxbmaiAtrJLnYXKVv5oaSXJoISvrhgOUeeReCgmuteAL8jlaQ7p
tWYeoq2YEKJzyVkaVJp4NsY09hJ7PuR7IXsudXsUAqAFHGX0k7c9qkSw8+yhSBBO
Xwh07OXmJ4AoykQT514bMP+qM/hyZydurf+ReksOl/1QGShbO8rdqj/LHBcr5ggh
Qe6LgNfyMDZtHMAPOnSgjrHF2NeNqE9+hm8lXNWIa6yVZynEhsHa4ng3OD2DjT+G
bWbmDs1bB1ItbYzEATfHvLfKakAA3CMotbDR71/fj9ZF/wt41cY1gRsAlSfU8Id3
gn664aDKhGhsN2MMs6+/wn089rVOxjkl1QuTmdRnfhc0onN8gKW3aYGFFOptpMFm
ZwXO3CcMU8AyLC2xcNDEG1OLdobgxNxJwK4189d1KJzULRXGkXpNTSmzATatK00N
cnHvBa9pNK2wiIZbuzCe1e1LPvN6RjYXtbSB3bJ+yq39Y1xOVOsc3TR6HqOnCjqt
dlTOPtq5YUoKCFIJ1LplJfrjvhMCKbSXRGm6BYI6RY972KfJszBHX2J535Og2pp/
Pt7pr8C8l1brXaxMy01QFMmWqIfX4loKdfodOouD4OQluC2cC9Ae3iVlC/FyFOGJ
Y3GuTD++KUEmYFAzdAmBnzlwgAKmORbKsUCJa8GiFvLrJ89mvWS1YbIGLNVDwAN0
K4nLhdRYVvJnlK02MJPmaaU02/FOdHPruQCMfmxi4EsWNcNjGf2QbwzhenA/gAQL
aoHC0CjAzXz80+dqXSbhF3QCEhMDCmEyWd3GpmXfOWskDIQJ67b9LZ1ZhwjOOU0b
rqwJn/4c4JwO6uL3ou+kzdRmo5HqGjGtCTaeqXG/E0sQIv1stR9nJqV6uL2VSmS6
GSFg6WbssB3vsrNmMXqSugV4nAvbJF2/IgjT63g40/70kjVXacxlntyXC1NjsTSx
h9MK79qXrTA5zUmyttK+Rh6D8eJoShaBNxaos6Lt55gOkSWBEhW9FqwM9xTEY0SL
VEVqLR7QplW6eJPtZLe1qGJfCe+HXC3VoW+wlECwpWcdxu+wAKPu6Czz/awjaUn9
5VaW7R0YYYOG5bExzahQLevsj9PGNCqAlvbMcF79t35kBxo2wWBdrGvD5+0LhUoO
GXOsTqRFSP6ioeGKxgwRjmMHjvDwacjBr2yTuMxSIRvU/t2WWtl3SASKaDqUahFu
XkF6+CSWclERh/f2AuYFp9FIBjXVOIOdI6q9ekXUOaWWThJjJFHwOL0tCeR0hGly
6QuCdvfi0Fx+8KJYMqH0iWQl/tpY+X9twhByeLYLJ4NPUYASkRDvUHnzCD/e8ZH3
YWGnExgKoQ5iakhLvGYFkQ0DZA7U1qs2cfBkj5+sseKzrVymliX6O9e236G/tItA
gGr42c+dYhTqTpMQIgiV6JP8o2zJcS3CTNMfWce/neVRAGEjic0N5JidJIqkcg9S
9IMGcAdWvA3fVyFWcI8tbWDf6Tl+JC1nKYx+QroZ8kf8a8pAZBvdwjJlLlm93t1l
2l8YYRY0+GyP+OtMkFezmHqDTPlh9OXLPS9gqfSjWaZt7pYwm78sZrVBuwTCEJ8c
m5fOjxDUwst48wbNZeRAY+pVnR2a0mhQKlCJPvuyZnS9QwLkTF7q+Vt4U8qb7uYQ
Sxc2qZVOezwPPKobY5DqA4iO7/v3zsnNu289U8Op8/WXxN08siKT+znmFNf6o4aR
3bfV0vbOtulqmSM9auPZD+fnQWTkVPuUsDtRikHZI9n1TXD9Ve6zMavqoW0z9ED2
KlW1O2byKk+HA3UeHMu2fQy2U25unEchAmZjC/GCspsAyi4krWKbnzpH9DL+kXlw
ThOrK/5+HG6XWfxXFSYIvhqTUG7nIJlsixXbcHDjhUESY7BP2A4LJspF67GRmz8F
vUdDK3jET98zP97QXtWdNL4npVzzqZvpMqVKshLBUWOXcdDhqz2p3Oe95UqqM8U5
NRGFxFUwX8DxEF2sYOKq5T/sS2csY0KivsGcV6rAL576Vfww0NCWMQLIM94TiP9k
qYCSALAgeaehAiIm+4mL1uV7+1V1Iuc7lfZMlZdIw2g/HRNLr45bzOSJVHg1Y3JA
KkcQhPqT87RVMBVeWUQxIE2pggct8V5d/OW3U0Tar6vrqujYKZm0zak7aeOX+iCb
yZOmm345+iv8KQhuRPr23rPzFZ1Vlyq4KjP3lVlUb5Zbw0LJqxQ694DDdiimcMzU
maSCqursLDvllyGnbkQiYv2tBGz6hgbCb2OG0OuqK9+tNwwAD8wKUeYBF3rK5UEJ
k/6d0EvXZRCJ/c8jYelI5iEP9XzvGrq4vaBBHgllzyMl/CE1H08IJo2yMtD9Q62o
i6Cs4w/CNo6dR4QtxQugCzJUGpfqVegr1JbGcXH2nYTojfVtvK71yqIdKvnnTqHZ
0sklbEhNh64TnLFJwqMolUEc1mCRMBuPhI2CyoVJ3psJvp/oQ0moXxdD96spL58U
SrEmqIy/wwruz2k94XT0l0Gk5objyMi55KvF3CNqIjA6nLvEO5OCMk0WrpfWdclY
qNECbKDGgvWeHgLL/OMdWrWdnDu+nH5dGILSz3jPcMCEVhMOPxlhQOhp3ANK+woF
zMNd7akWDAYgWSqnc1mUcOVG6pwEj2fZ8WoN+MoG0kIXnjlYFCFDO7AyuziJZk5h
Ig0zBC0OL21U7HI28g82T3B9Qu8v2oYpjjkThIkA4KGxyUxH0rJCu2dPh6oRXp5q
hneTdnCeBQtRnCPhyTzKF5SniVbjVS6yG3wdqJza/zvaOVvUsRwix+gPmLxRpX7F
dbyyBmkBLDW6aUtTdK4zRZrXJUB+ob9TFVo/ARsnLhekdFkw6ZgAdVhOpnfezWHE
NJtvebiFRlcxSvMI8i1BWEiPFYva+BphmRJR5P5bhSIqNbSv+Tvo6oZbMybQ+naa
5pYcKC0owACLmbK4cjmswc10LUnkJqJ8wL3esxWvQITZc0SFLZypiKCaVDEX1hrH
mtkGhASzVhI0GFnmpNBD25q4ockxGppcFdKLqxyja8D8YWvJ1WywiVyy2PqFtdzk
/3jOYrvUvoGHE/atyyDRMgP/3dk7v+UKb46h2fcbM54/yIEGBHxtzMPKv8pPaoh7
8YduMmJcckof8AW9j75cMKS/eRRBCNUFVwG5r2+6OoNA+XEivqk31XwXEkdTpIhw
gmrUXcg4bRti/OXKG6wpsQbB0xOKLkc/v0HeOr3q+ll0EX9VM7CqFY63qzGMR1lo
riYTvJ80t1KRduHJ/VWvVGdt/IVpYVtlrNel8rrUOS80OYFRO8v84MZixGPpJp9j
SUADHq19YLict0XbeJJnMRuytisMetoEq071ts09Aq72ZQTxD8bOpWjUkTjVovx8
DwXnjQf2Q8Rec8km2it2C8hmrmpxUHKQxIP1+nS/JRP676Or0L7LhMENmmLOWkUd
nyJfTl47paMF2x1RfW3qM+oYrusUF/4xjjWApeJV3fgGdsKlXdJKW7PvkxD3Ivf1
a+IWGygKdo48+rwZffP89BK1H6sWq3r367EDUy8mJmfxV3qnTwYQRvcsKu6ilrmu
0mYdONg9vdd+mxbZy4jQUvJOI+35x6s8LJ+JgLuWy+LC9Fdw3eSPaehJtkCIVNT0
YKwB7ERy85ZpWNS1wB/pu6NBJd5/YOvWjhtDrb+ktbGsxxh7BX87WUSGOIabQJR9
S09DaZ8rNO2ZFIU6P+tJjvNwDvynzhI0IwTUelKuJxtb4Pe7fVs/+k5p8I9RoJfR
3W7tUgULbwVHhjxQ33oQRbUYMexUIToMBaWyJbanPQF8dHqCNAv3IPz09/W4GfGe
h2FDCG2g1T9RdkanVjKNDGN0nNWZkgHUp5kMlEcy70a1FOOhrKObRS1kRovPaWJA
Vcm/34jrv6mRVFzg9evajo+Ax8g5vLMSgB26UkP3Bl1hND7yLfJCWFUc5uZzOe1a
achQLbsT7i1kEdralGzUC58BXR1Y1iyCttTpuvEk4IyA3fu/0kCXHnEVDRtKj6eO
/bz652LwYSGm8LTS7aPklbBAnZwqmTpxAg1P7V3VdgOl7D3Bk5BeWBsxxNpzy8+H
0QWqyZwPuRl9jLl1DTnTzhptIzYWO7bweworsvN2O2MAx80a2Ih8Fv5AQAfaAH/P
mKdhRy9FaKUSjeyFiXsHx/fCLSrrNEOLgCH4dGkf2x3nDxUeFW+xvPRlNxUW4kps
CcdB9qZuUGmfKBkN70WYIY2eZLoYeskQ16X4veHbiX+DwQtQnfz0/EcTLHK8gnAA
aLvHWZOt+Tr0dQW2BZ3OWhiOVgobq3HpYtdTEtNW0ig518xU+3x6B7vKe4dofxnw
ViXteGC+ZyTkPBGlerKgVyIFjvjnz7EfixgCgXIokZIv/xvo1RX4r4kFz1TnShiW
2yAPf1N1nnllF4W2xmBqShlGW+oVitAFcrutqqqiqAib7wvG6pqCWp3pkSq1j17z
vmgaegz070HRwqhnouSkwRXiRD0UcvNmPUxPveRhrCu3ydMwMwt+X4VvKS8Bq8vo
r8jXv3NkQDvjNDd7PGP5hJ9JvvePY1dU0G4WaVguJU+uLhADMIdsiQSaCSuTQD/k
zdUZxkK0W2fi99q/XiwME1jplxsj8oUySivgfNYW9/2lNZpAZlq4aNIAyQKDa8YI
n/udkj2mDA4OQs/cUkqmxF4c98aqlSfIkXRVzzgz4uMLpnXtEtT7/NbDwpF+iV/F
imtYc4PS3I/mJkDn5Xrc7tMGg16hJzXGwr1nTMoCQLXpYRFM3msYqVORFy7KlYr6
86oN0/tAhkSgzPy08mco1kDFl67ZmMnfth3KiaScGusdo79kdZYp3EfQV6MBbYUg
mHMHh24gzLdIC7THErfppRKPIiKPmKb66r064rrmZdnEZfnKnZsJtdGu6WzoTqic
E0c8RbxYiY4k4I5IVRYaYKWeq6Rw8zX/c4HpdTRTMP7Rb4z9Rmdu4sGgzXnzjQEE
ubmiNiSU9yqBprRlzxkljY2Wsxrv2y6iJ45GuXGQf/MLhpa4cyNvpMirHkP9ts0X
9XCRt8hUi5yotrxXx41pqvmVuwsrn2zpuBZvUwZ3QYrkur9RSDwEsM4kCPUwowAr
hwNML8UOjZSg5bAT88rIDfQO5eFfuBVMWFU6sT2QBl55gnO+jQKAQG0s0k5HTZF/
sN+wdXB6a6HLJ97nwmfBbLJQqKdFY1SsE3+ES67Hg21JCVmkIVDj5tuNZzrOj55+
P+0H2G8sLEom53I464kFLbc/s22U/k7pxHGgapNGDOcpT8mgNbqiiLL3uE4tj1zs
Q1qZicxovGU1qHncSmkWBCGCAl7kOsHAQyZk+t7sGgEEMTUUk2ZoitfXRp1Tof8V
bsqIAzRhLLpjJPenxMVtwh3JnoXGqzekJ8N2/NwCQcawzI3VDwundEV6Rc/okeep
jBzYoJ9w+P0RDTeeg4P8AT80wxrQotWZG5quzIHJU8HvUH8mQfTrJf/T7ClqHOSF
aH4m9DdFutVbcSiQ//iAMWufJcSpBHVDwuTW8YyjOblVSzOtP/NmXEgwA9an0jfL
k1ELV7o/Liu7RKJtmfd40PKG9TS1cXcXN7JB+LD37rXWCb1Sz/ZZaawK8nr1TM7m
UtRx8675OckumPqNgrGpbvQVzaDNW994HF6Wgg1Zgd84/BuTmAY9YZjI/hyWRWXz
oXY5NYBM+gBvBS0MuoeM0z3T3hb+bpAAky8+LrnCWZc8srx6a+bdL0cvjzORt7OI
302aQq7GUWX1ciVqPAFRX/B4n5F+F/w9YAJ6ZThbA8MIftbTnFaVCW665LuR10IZ
+7JFip2hJda7Dsk1SlmhWhDY4olsly8KuWBnoNmF+jT1S1yScl7ibvQnmqUyMyub
xP+Y4QpTpNCVR9n1PEtpUU2EWcutks+ek5sViigLJWD7OGE0tBvDw7UzbvGus/l4
rIBYr0HGTN7UwuQ5PXMTu3mmMSmpygCwW8cEc/A2mhsydz239EuSw3EJFWO1jWY2
DqhLSNs7vv0+R0aw9dARx4QHiSu98qjjpXmrAU3EkurEWj25NCu6ji9p0dtjj/t6
fN/Q0eVIoZvPem00N+ZXf1rqpVyeKVkxAzlxal4EWvbBpiqyzG03bG9YDvBGiXaB
z/EudcJIWUyzu4GwkiLn9w8nDALICGK6zH2cqYXmqCvCs2hwNXH3QoJ+iDYyet/n
bO0HHFCUIoMw4pcE7zZnHZMKi/bInAH49zwGXy1BtfKpDSGlheY5DS4tJJNFYQMf
oUu1xE3OGrnHba4x2fyL7PRakL8CC6zFjZU6KuQbmFycZ0ooIBXB85vrMt4WRamy
YlHbrk2QGTHfC1fhQHpd8IjXmFp1eWcXt8sfXB2gj/TU0hRwpZSTWTzOVD5sZ3WM
ZrY5YTi5G0nLuL+ccjIzpV7siJM/12hmO0zEKuYs0pGJDgS78zziWaTjFF/10ik4
tpQKO7OkzKgn2qwh7IrtvK934w6rMglv46XA+9piXlPmDDKc9F9Q7WBIGD2gH240
fX3aMldC5ugZxvkv+Sx9fR2ulgf3WfHF7v3JuGhtGd/J8szkR8gA1dwbIul7910d
YS2mv42zfawkmWaJM+0btQGw37g5N6jTGcxQfGSAEofd9P/oknNeOhiYFuAvEHdo
4TYSWGU0/pp9XtRxCJVVqFSskaCIS5SrtaOkMTvtjSPfKH8YF1vBnY+sGhp/m7dL
FWlrMlMJNQjJNwlXZ3vUKkqiLwQrYxrXgp43e8zWCLs/moUoLY1HYKhbWZeWQEKL
tTZ2gohaeneL0bmKgdh1fAOKhkHvqcnSuAM0QIz2dOhCk9ZMsHevZzaEVwekCo9b
HsyTF7n4Y+pBdl1FgVjSOTaK5RJtUlpgOUu3wSaRcfkt/YhdnMb3sJl4bJKyUPnx
zrqkqlpYizx2iSOCogdYRetY2cNLEeg8d2/tnO1qw6oH0tM4FbAJmIt0bjJG8Tw1
EeVos+fBbtCC2ztGknxSYQ+MBv7XZOtwgmFYZGOLo61BDoGHtS1nAJLMdgIoejW1
gDDeq9S+g4sWKnorie2LzfIIKZfVlLoXKREkUgoasX8SCKbcQVCuqAfWFqWklbDQ
vTkSz1qXMvw6DUbaKOvyugwVWudeddgNCFewYIt333BgOIl6+igXSEc1gSZl6u5A
KnB03WXuvQRYKP/oRb2+uqQnLIbvPC/loJodNv8HxiZHseHy1LOlw5uyZ7SEXJ2o
+fY7nk7WyJVhFJz50mJnK9mmGu5kcrqQFyzu2XRhrwcZVkNgBcEj/We50K4y7cLp
Z6QuXw09HIZzOB7G8W7BfCPusX6GMw5O5sd3i3xhgl6qK3vaSLIHGc3mv8sEietL
l2TC0Ne6xv87Uyk6OZgu7yR3UPnsyqK634Vxm8q/feAnvx34mY1txTJminYBfGBk
Ib+oKoZ8U+6xbBcWarSRG2xDFh0JDxLbkS+yi6CJB0WmR1Ys1pgBWVuY4UxBwJDB
rHrRDJBuLxqIvbxTNo0WIrZp0Ds0h7hjTeTEFUZ5rK95jlzu1rPNCyZoIrNFNUTP
eoJ9nUol8VXW3mO8QFRUMCUR/5x2NZOEDowZrLMJmslifJn7zZcuYuj+9mCSP5ip
yWcq3p8eARbTVie4ySzIgJYwOYF50CpeT0WXj1HTvBTyQg8w9o3K+K0CxKTq8+T9
xPsgbYIUKPdlSGT3SqpwI/gyE7nn2eeejgDb06dNZkTL14NN30yb74XN/N3WU9vo
t4jrT/go47+uSHO+VuJRxzBugJvdXv2OTRYNmmNudipSp6/gyvjoM6rMy/oYPpBz
mB8F0ImXygkv2qjwBz+jUrVXB5aL74ZHOb/EatzmRpYVgqGlzBbBnSwHhEgIGYQx
NJpF4rHesN7s7r9XLcRBJ1RTnK3i461ko4/HOyCgPxU3TFrRmyqxcK+/IrDC5Hvn
H14ekc+X8X/T7ljydqVWdwnMOgXmb1c7KYsy9VldjTEFhZAf1d2WgyVAysDLhy+5
rM3XcjGMXd5Sg68dSYQjwWuy/hTLLqnzMkFcELrdAx9UqYXQK/2v3p+Pp5PvvOOh
vCZ2C7iavv/jUFMPkG6sy8h3ljRW6BviqiREHpqEIBSKXvyLK1xCBGqOZQjU4S1S
2UZp2kVl/Ty7PWLoFcXl/kuPGoglecJmKnPVr8KIZm5gvpOT/Ut3iOcDbRpsAKPW
KyLZwXkuG54borNtLNpMaXuHi9LN4iEpYSX2AuFsRT28Rwh/GtPbj8y89tkg9Cv+
P0NAHTrDO6l5DoIsuGumP9G7um02EOAJQnTUOUBZ5UM2LDLzErhhzceVZhicwKgL
F55yDyq7BmkNa6y4BA0xMo9xfg1xtUKiyvdRtSLuJ986dsIXNk4V8gev4YpDt6S8
GvFMMCCxzmeNcHJNkDNhQn35XkqLdCsl/k7scb31GhaK5vnPHeAsbp6M3biew8Lz
nIjJSeRTs+TMxr4SeqINOOY8sozQLGAQU0ttVvxim5J5zDokbmqUsXcTUqAlriii
ovfJ4RevOpSIk4LJJYwgG++YpRvqc92IZrdJ00T2OFOq+34tDUmBY6TaezmuqlHj
DEpP9ayppjGeHwttZtU09xEzPNmBmNqgVejNScljTIGDNs3U9mjs22EicQBgtbFu
99bO93mepBjwoUKktGtcMGhZoSs9kjPV3NvJ3PuBgiGnFKqBjPtfs+W6y38Y3RZV
ifSVYI6B/6mtbZYzeJuygk6iOkKUTtsfJtjWXGHQ5DTetKpP5+a+dqiMGfgK/AcP
t4yi/O4NJD3i2lJrkFvZLX/z879EU2zobyFNrv9780EARa7pj7teJU0d+bgGeXjT
Yu16ugWF67KHRztmHW9mUq/Jyory8IFosRLNbjrJYRSsC5BJDC7NJiicyJBOEqlp
65cpQHoDW5FdX8M2udmExK7o06qU2HXURuOdJReSn0sIX3uVGIE3IBBXRDdcOAJ9
3NJ2e0ICOLzrYuFe2bn2V508Ox8QEE9RIWcCirzHAf3FowvmQtNoYeXSi8ZFA4TV
2kjLbIjbbjDqc9nFHiWo2Ue4jm+9K0d80ZTIMeluqibehFjI3+iwPeGKtD6eboG1
ucx8OpJHLBcBFfnl6VE6Z0eriw1VAhVw0Ba8X9b4xFhPaSMZMN1/e3pXiLnxvCCF
rJoC5Nf/HD3jl8vnF5yhUZyoIDi6KsiJmXIB9Rzq8DSp+B/hxBNhsuybIoMbGpKN
jcvvpbfFw3Tg8quSOhyjkcidNoBsLqHfXrB94UXRDdLwDyjO7XksmtGkSWj5aZPD
6x5yDOd0TKMy8l745Qb4b5sW7auYHa6WObx2S2/PsQGBdlJJTMzaAiHQYJ03wAMJ
uST2Zwi7nzFJx7ucM17U67nVg/oxnqppGvA56PDrhpLlaaAcFhrVqH7Fy2tz9ocg
hyJenhlV+rAEDtPBAbfTbI7IKHyuK1FqtEObhT7+jFeNVbMrtP07ZPLgFMRWQRZ1
/jAS23n31HRIhPTzZQYMDQVeBekWFkrqrjzkLQgWhCW4vFpAb5lJdkYjc+GAv3VT
UJSVeL+LEwlD6XWz31HdW/iseF6EIuWtjRvxxgNQZhOsN0C2mITKZcTrYRqDgTJ4
o3L/l509jrJIE8FqQXJQcy/b4QXvMwWygNZOziTYChISmLhbQzRXSBay6c3ytSvA
c8Cbysf5NDTuEiCeXpXbv8Pe+wV5CgiKajnjEwvv7USZIKnsyq9BniapXaywA6Az
Ed+bYud1AVAc3D5vSFE0fF2KWPLi61N8uRCDWQMiWEwcEvh1z7/+MB+u3G/HgmsS
R5zLZYvdYuVmASqFFNJ7svc4zkXNpkSpUaGBLouCBk5jDxyREE5Nmq0Pl2EqZERv
c23o5iDPVIcDI8o69rWY3YNkK0EYqaldL8kugNyzJRgSJJ//GDrrFlAhux5SAo07
2pK/SQQ4kPlJ7h8uHep1xnOaP8yXTAoK+HGcSmD6AvRLwk7wguXC9fQoqAMx0CeQ
k6K1ttK+UqDqSrlZd86IHmL3FQRp+7znlmSxNl6V1fctyRMtSrhzwgaG7HZenL/g
43aWRfM9t8WoLPL4sVGOQMKotddps0bclRHiSZyITp4DdPyCB8tkr8nTmMThFODX
0GF1BvUxKJezgGmmHUD04gzeLwcrhnxFeZ2mMLYZC0GlzaSp1qbNRGDu9glr9hgK
m/0gamgvSHIwIiESfywQvUkidQ2GAXrl2UEkgMUZ1jg7mfna11U4NhkVIH4ly3Fu
oOzWdY0TjGAK0GIL5tt2hSiAaR0NaVxcKfiAvYv25NPbrapLF/hcsXMFbI7lWCwT
3TG9c3zjDgQb7zM9xRXPKNP0huT1OXYq+LeWwjujSjlgJ5w8i5ItQl5KZrPtg/zk
lyBFS8jwRbZyCEddR/xUU6f3qWkjDnbmZ+YUOfPW/h4EGhuxp5kbuFqjFF4MifbE
oBI6sOSWHLoqX41Ah7QlSZQu82JOcjk66eDpK9JXOD+tc6cxThBxDvG6IoQnqEns
OMuETKlRaXUS72DAXZXXFjj8RsPr6q+oFeJV8CR4BN9JeZkt+id2BxUaliJvgKGQ
85TEwKdJqv9X/AYjieNcFlLZonlJX4p/ZkWJ+zjosIugWyE3tTvTS+mXXX3fdYxN
VXiTvfIs19cbPwqFI7LrYytrv2POO5XcF7Uf+tRL34jeuTHJ8Q8ryDNNSAA3yHH5
MzzqaA5i5ixtIYzALbgUTpZ6w5XeTHeZEjAani5OV/aTkK8QsyEPS09QbajDrdpU
4QkpSIAzjtIqRjfWSYWfUZagfU9d9slqAgiygtY0DUo6/amA3kFdmTETy3O7PlsY
Cg86xw1V8lJOpBnsvqGFJQcro/w1rOHRCj4o5PaUagnFFCIqxug6U0u3g2Swrgfr
PDsQNopgtRuuMVAO7rjcoM2w+7a9VNFJWjyYmJZRnzBwUvHtpYEbp3pDwjX5UfyA
bIvdABCg/ZI6U1gSNEeOD41BYlg8Y65CeR8h+rvsaY8mogXizelFl5mXHwyL/nKu
1KoCQhjrPQplI5Cj0TWY6LabpkFBPFc4Kw/cWYHwUxXhLO2Watzc/fUovH6Yfsjv
9ZCzoPrCbixp3fKwQDv8weicDJmuJadd2EaW0zmFHGKA4db5W3i2hIQlVKirXW73
YWwv6DElWFvXZTzLG3xB0WYQ1kbs874qKoqGocqi7cDXTe7GQHElhGkSbU324PUn
fkpfugjc/rZah7HXTYjrNtUmS0m6FHU0Ou35wiA1Vt2o3MJIfvqXCu2hRqO5yBB1
dYc4iQ/nl4JRtWIDFqrVQ3MqcwBGmJ5C07QdLj7J98e7Nc7IfBW4jftZBUgOwZ17
YyrwyJIXTA0eo3NKknxnw73y2LH3BTxA2h6iuyQMJkoYP2CIu6JPeA+nt1x073n/
ueCC8i8zmQ6oTemtYzf/xqW2QuYMF1vJfbSBajGkNU/dMhez00W7P9u0INlz123Z
CPbRrRAw8sLYR/hBcSbswFbBpU35aqeyIeH4tDQBhrQY7XD0vAI0gSrGe37fo6w7
y7hbn5PvdCQ+FBZSnqg8zIePk3MWGFwM1/drNuMeO9bgO698BtlGeaXjFQ46rxX7
pMytX7SnxiPW9e6KVywvzBBMyjQhOgESLJfoNIr1ZMl9t4VM0c7lpiOpT2zFpZsD
fQ1kyrpbrpFmea0Us5Kh5qZFa4tOKgI//xpBGgnU6sWa+XuhyB2xFXL/My56JZ2p
NHBmEZT93BiIo72HFH+PMQqfsnVmX4uiZFIa9//BD3ckD7pPOVoHacNZyUFjvqOm
Fx3bEkWeP2CHS1v8eT6vifX85Mm7hLSQAOazTQa1bTi7aCm1jpDr9lTl38SCKxZ/
zqzFxGdyJsDA+hsC/UpEaIQoe4IjU5Mf0Ua5AqlR36nfS5JkLbl4niaQ1pKuCdA2
kMF54bWSYaQeHxC3ALjyl5qXqKh0vbOy/asLbLNqv0WX9g0OXiJROadJ3E1MpsMK
UhEAJekSqpePM5r15ieFLOb1GMdZD29WA5+SglAPvkzGZDvGVsiK5fPQQBi5cUOH
GelakZmzrJNFu5bhB8ZB/kjtFozl/ubo2GYKsal3ejHw+Zkl23MQUAR5uiICuinD
uxHEAKFaTWM6PiuJsuFw1I8bTN1p7yCvA1VyR8fprrA7FJx58Rqlq9+gVFnRXjN5
LheAbZ7lq++tzlhiMS9H8doH1/2g+2HPE+W7XMqgqFmnlVRYRuICFwX53Z4ZC9Lb
UJC9ZE3zXoLBvNtHAGimXTUnayH2qZP+8kGoRgElX4CAycwVk5ynEqv+qhgKAt/W
jsdRr3+RMMnHQLxwgopwgeP9Xtth9LfMBv/y8LND+ivVYgNK3Uv7MlhiAlo1Gh7Q
3LE2RkMVv12nVER4/ceu93yFDq+T9InQ0Arnu7dHlP5vgR2G7EA8AZVJvSa3Ejuh
9dbUGumbW14tk8aFVOeUddKntFlzoXo8Cfu5P05b0+i6xH1KoTI5cqYx76Wc9Ln3
kghZ0XTMZIeicAJN6KPVych1nvhWqF4kOXTrwsofcpqR5mSCRFTAhWFOvD4xMy+w
HeAtmM1J3MQolidEjIU14Pt6lgUapDU+1iPv1jLVz/x5MXIddDyTwk8epQ8V1bEz
s+BR3mIBsLBdPpJ2GqqUtJLTCjfktHp9eDepqL7+Q438FhjJhvPAwR482aKYGjVV
Bk3fM4+FMH0NldMd2K0gp+fbrP8Ky10ug9aN1GHpDEf7WDVnsgp0XtOgtxwuPT7q
atjt1VeNQxPN//LTTYuEn99o8heXN6ESBk0KwY4GucBbjRkCxTgkNfMehk2BS+fR
i1HYS6L2mrYtOxiqnTHsmGf7Fsq5p8UVpRbltW8QDVC8lx884iiu2JtpzDtOXBLA
7AzsuzNCdZ4Yqyv+J28pIa9kfCRxBKoE9ucy6E4jgGxqlAfMaL9nCXxsSO+f5kgw
dNWKbn5NwGT8PG0G0mSNoLZuZdrreyThuwPZOE0a3trXHp12cfLgEENjIwDrJ2u9
pyCQ8r3zV08yncppifwelK6qI6gIY6gh/MmdubaTaUxnGqp4jl7wTM1KG9rvwDJs
R3wXBh6Rt7gMdr7MnYB0f0QUoS6F+uHvlQytjZ52mrqMNcT/+z4ChF5EJ0U+uqmO
29WysnhCQQgz2Vs3SQojDqBwDUzKLEshuJg1Q28Bz/Yd+6m8I/mNchfi1HVzjdEw
qDZWvv6vpNemdJ46ZjUW1oRRnFCq/mzpv4WnugyzbmSQKmAMxJ89cnOYopRi39qJ
/tK2huj1C/WdzzBpT9Acfm6uOANgEuU6An72TBOodb2Mo6JlkDIY53MZQOI6VFio
lyyeV6zHdfMfEEj4OOrWLGOn438EY+prWCOMSTUS4puHjsimatWB3o0XcBlJoCXp
BQ4kBa6hWZgVUF8esByzrI/Q921sO+EPE/yXkQcR9231yIoqgOCyJ7+6Ro7Ja5C1
9IUZX5wNV6Pe5aQHM5ka7n1STHI3VhA1DIVrhj9joT1OFqWH1goAf/r4bEp6l9g5
3BZWI+YOOYksqEijn8VtzWG23NoMJ92VP0i0Zx8J8dtpxLYDTsr2Ds3ZL7zN9Lhz
U05DSN/rN7mI7rwdPjT48ojhtpZ9zAR7NIl2kcApZq3UjYwFSOk7xB64uW3TPFue
u9siXE7eiXRSDOXJBAvPX34R9a5E7CcUgfb+2yoRxVfHizlIzmESvKlWW/9DOLo0
4Oe0Jo9rrqFiY+cceVGzrTXjg6oSdoejzUvK1OIZY1jV8Vkgv2bhHd+w/AYuPAR7
f8o+Rq3xX0c50iwRSs67OjoOPMnHRQAUf3ZTjSdqOY5G2+rPp66wZk0HfhMvlKhs
2zOHSHKpd5OHkmSR9efhskM+V9Qs1ydYO0kN8aIkjfxtMoLSaXYg4aA+Wt1iBDLY
K5JMD6NdisgAALD8Zk2dz8MRlplk+2OhW9x03dOCeURsZVtM/I1quQmNKz+S2CWV
iAg4FplZ3GL3fSOpNuifSawsZM3qpLup87EGRz0/FWuaC4+86x7/FKbeDQLHFVUx
fV95B36DTEqGEpxt4bqyykk0JLOrJWPKmJ5ZChvUQxn10nDC8lvnDOQu2B1dBUyX
hyJ0wgr7SNkVgmzNoE1bCsRu1v/kDH56YEZeR2W1uHBgZnG5ncZ54fZbR56uxCVZ
Dp3lCqOyzd8AqByEHsKyYdkj/VLbQwXr8VC8IKoglYEFuig8EL2p7RDGrbvODx6I
JWMAGQe5bkOpYUozdx3T7Os565mxrlgkVIEHMM48R5B7P8Fh/oQjUZFi5aR6MeBK
QJh9JV23/oMn0pHeaw0HCtOok0TkkRoknZ1xKAUCHutmQeZqYVi+ODuKpXNo7QKX
9BrwndzUJcwJcBa3SYqtlprU/PexqByruh3w5aJ4vMikoUBlYbewYtAmAJn4wUBl
ou2GIfKHh9xMdqlNNX+nfyaS4QP8BPB3A1QdCdvbaZHdDRq8yJi2Dg7bHcfRLRHD
NaTZM7IVMLo6H8jThb83lp8PddIRK7Lq45qeXhnpGwLr/dO5hcH2NmBL9UHRtNDZ
e24n8LyKGb+vRHrnD+irf5hFt3vJURWC+GuGFB5XyuhuN1GlitAdfLD1w0YvbdVs
5lQbJP7TC4ft4iuhk6Ep0f7anuf8UlgPm7UlhxwpnhbkurjAliQ0PVJv4mMPfXpE
3+ENIKomAigWTr9TCZJAw/MH+gZ4cAMPHbQBNJ1zoNYRw96mYwSYHIW1t6oLfgx7
PVIDxn3vGTa8wOF5I7JH2yqIHjLpey5ycVx2m/gixrw0qaPQQWyim+TGgQy7yj+C
4SrL1D7MDRwz9VPJtx6oRbJaZWpzZGkKIu94/aE2irrHfX+BYiU5F9zapH6+mpSm
cDKEJz5wyaiBTZYx7n2kvavQZAaKBxWeldOwPDTwetuLc7/eUJWMrq9VwHn0rRLZ
btWplGPcVEzjv+3WNGqRoiDWDsKHUBWvwx28CLZXjT9R66Qs1YNw5B5BD9SLW2Me
B8GYbC6U9Pp1x4cumfUbp2qqYafpbOBW0iWj8DiX9tkYVnWvWEKCi77PZ1uyaoaT
1t1NvqkolR3BGX139BvCbicn+t/pcI450xJRdRwedl5ak7NMwm4KJE/u5hT/CQeN
zhbZDf8/LMBYDgpSB9txAZ2jjkpBYu+SaesfyXgdCFVG3b+tFERSgFDjyYVdF249
H61T7i0p8E6QD4qgp7iyrPsafRqLxE51lZ6ozPDORyJhEjO9eNli0H3oZcR4zehj
LaveGLnFmWGKtOxPxANJi/aUOFDeXCzI/u5u09779RE1VEOyw79tM92UkKXAWmf6
L7iLLOe+YdYO/tOX6p+kG+kY1hjG0DLGNvy1BocL96N17EantO17oDoLwMxTHbao
aSDMO1keuvgjWVAaSHS/yqn4TpGujuhenOP9MpH1CyrluwnUGaD1jI/Xc+dj2NsM
52gPgVLCK+Xzwvk6y6kSxzpn0vBgciDtpWicI45uaN4zQf7nJCtB0sHgppqcpBPd
/MgyZG08THoWbmQoxSKyic/P/VdmfbzegznzOKO9/cnPkdn/HyM3w9eOnHQm7Nf9
Q/1DiqUIJ2basN9UJh1BIIoTZJ+kxpD3fTeXpzmdmn6T9MT1k5QrOk33qBUCBf8I
vPDjbsr0GyGI8jq+Cr7p4Yo3fPs8J2EtWr4n9+N6U+vrcMgWiLwGfgb90mPGQzTp
ILL/o2TQ9qHcpqUMgzuRA/Rqvskx1k7cB8ZWuUcOs0Y+1WrX5/6JDWuTan+F6upo
aQeKe82lRnuMf4wBlZ+T31RnRxzOL80k97kEtimoLC7d8sekbOgYg4xBgP5m1HQZ
6t6prGUpHiRYLl/5Pyfht7KT4wQFM96rcKsMq77YN066FW24nNgSwi23gedfXVWO
bV2u551AglgcbHR1PXAkNLD/ygWEC2z0pdoe7y4Ps/pn4Aabvo8q6+RM+lmvDUc7
JFDvxWmfDWFysVU9I8O6n8V1VfCgf7OqrjT22yAJ4HI55JArtPMJivdLCGZ/i5v5
1Kr3gE9ZqRif0FlnFZMPU08KvJ+uqjywx5SSgyZuiTd4r76Y2IOeELJql/7aExrq
XBgb7ZcJtyp6pHRG3A1GAiyy1BWhBMhpJisIqcsyLNuaV0d0t+V1Pga79DRSR4IM
cTSGG5UZUjqR6um8pkcDHtdAv52dmYkcr3JsbD+ZKKfy68gsMnRLXlD4J313IsbX
MEV2R+Spd5J6ibh15kE+V8p/UJwtOhKzyEQYwdP+OY5y7C1RflQMHnPvv5KulR1I
bD9Th0qSfnwzo6lSDaIEtTzDItDGTEyLmw7rJQqnPH4MuRh38wxegW0dQEuyjOeM
924vrW9M43sSFcPX+Kwo3vXq8A9nbr97VuoulkPi/SpZwdhTi4eGSF0vttQxpgJp
4DHZUg0FIHYaq8jwYe6H7LYowFVMTtelLvgt+sJQSUsO5oDdP/ROWsAv5SkpfUfz
nFiSoLhv2NidxCeK9a6n4z2xxPCrYBHwophlLxyaYdHfvnKz+2/zbInu5yzL5KTJ
g0UMs9vvi6G8/FqTmoG33WhHUar1wZCMGaxcGQU4ZHA+jdIJasZAcYWdtZaDD3eW
rLQelByaiVFFIRLxGECepR2UX+DBgAVMDyDipR+bX7DZE6dpfH1KqzsNNi80y47N
G0xErMSyBTiQ3bDIzj9VAgsnbi3awVTsSkka/7ty7eeAzGCjAfpnBfYb4cZjxmhl
BocXSEehs0mSsFndKwUamEkbJlKb/PBzymduTBn/lXxT6g+FHcwSJWvdwU+3igI8
hqOSqzi5cfud5kToMrzQmF+E6SNrPDWO0mQPaumiilzhjgLOwRSWw0mbEbaySle2
bcSmfRV8pca7glAFktd8e11Lk1fndA6W42pkI5ZSPVm0ica9DM/tWNuyXwJtbviq
pYGNYXarDejLECHmH7eifheo+k4oQK8sMN92XDWveuJ+Bl+00ZnJKbIpojmgoRmQ
6rRaOJ1eTBBR4mLz7iDP+C0ydhmI+zoccyvIx4Ymy6LbWFzL0jBetjv3BJOESNW1
rvvaNzEqMEt6OCL96rKv06kptDiZPSGShbMgKwbarSkoJcb/UToNCZn3J3FY9ehA
0EFLvbS2uKSqB0PPyJx4mpx2c9wXq7zrSlmHa4pvnFKtS6UlWveqJtcHEKokHZGo
u/K3N4A5K02NJ273oGAuuxpalAoACSN5ixZl6+kxIJqjy4HtTYFGlzbCciBcy1IR
wWJ22yE4BXuZRQVHUb+Ies5kZow9Zl9K66rR6hwsR7xAhCtgkbYEhFSKX7GMcV0q
Hl9z60wrbvPyiya13gYa1lMUkvV+tqNK+Rpi26BbckKlQnGccnaS+ds5UgW1EAHd
e6yX/3dAjveyWqrxHMPM97VAASojK7TN9HVwqb6kciHFXSYQfx0dcouk2axxZ6dn
sOAByDuLbpY5H7zBB2vdTJK7H3HovXaUX34Y+TSas3IPS9RSvGV3TNmdN3lRGDLi
MdE149XSfLBgaCIyUWPUiZE79DNQJS7gArtnMWHQM9yhx90R0++X8HzK0rZu/xK1
DU/iVA/PYkZMfBRoBHn1W3SlG9bf42G3kRvNizU4nppGNipgTxubjeAMPXSwWhDo
//pI2AIEymdf8RqzuScTOs2lrt7oXTaEPDiAPDBtL6ufhkHtQC3z1T+vWnKcHOqJ
rDcr5T0rV2sZCSwej2qpZDdQCd7KOY7l7yAF9snIX0BMTUlqXKUknBca8xrrwFnE
ASTC+2u+sINL3ky6fWHzExVSy2SK6CXsht6T52ZdP2Aj/owjxLv23UhwloPLTzJI
oU1yrWMJ1hHKAt9cfhh44lVtijpw1tFRBH1qhSIWoAoKDyUuZ2dKjsOBrlvlU2Yy
nYACzmx8cZJIKP5WZr9pgNxYSYYVfD5xNtFadbFGzrEC8WgMfJ35KP352F9Dxyrv
HSQSk8cDVubGAPUf5CQk69HZiT4nAKsFlj068/Gf39jfVqlO5KOhdhyYd0FtbEYC
tu1QlMkjzcIxgBzEXFobrZN80gPCTnxmfPzMBzd/sk6rhyeKl/Og+LVHoFDvqRpV
2PEMelgo1AlNUIs8SmyaknJ7ec+d/rJpQPdR5pnpkSwR/2P6piiWaQzMdS6WZNPY
/5rH5ywwwzCzUm+UXTxV55IjH5l1K6ebpt0Nn+mubgKSTJbdfshciB/HiaqBgaGP
49J5tlgVZ+dQfwiGElbEaiWI4pP/90ie0cojZI27gDJNUW2KBKp8VtjSOlniR9aS
WiKs152AASaAxblFYLJA4yVMRDYbKesSKdDiURX3g9LMYybMr7jl3i1gJr1oeAFP
+/5MVxzE442bzSCHsgsjobg+sSSNcce2wLXhujGrVL0xj5/dN3WM+TzQbdB0r1MQ
yASDv/i3okUBmSZQEiGku6646WrSzEB3Gtripsksp/tHHtIhDQeQuihP7sFZLPQ8
Jy+2wxwjbaON1ChfDLfUNt8pgHdSB2fHMn86uV6Iz4o23NPoNICpzLlDT0urmqzY
zl8P8y03tTih+Gskll/kwp5rP8dLvlIKYfKOLZJwcD6UZXZCBiu3nCUjdoixqfn9
Pg6pmmHQRUbcIdntcJm4kJgSLrXunfLgFmb1QQH2WpzsLcbfStqPjswj1OauF/6b
Tnyks+8pmkmwZEyF6xUPfUxtwyZ78zHY1tH4aX8ttjiVsIFr/fvf6a1HohfM5dlh
uMyP8SYEyZWirrILNQu+OL4iz/7+N43wCR43Qjdy3629ZlEzyvyWnNcIkXZyDtnR
H4zght/nbJ0v4hXr1jIs8bsO/vJRL3O/3vox85QKemg63T7nB++sT0OeXyJ7KL89
gR7/MWUWWMnlE/n8T4qVxYOIX5HAAsPmUalraRgtGGjNMk/hwl5+68xLipbqOg8S
ieKMNH3EO1XtPXmUtYzCaswd4qGZqkKaw7nhTaRomiUIGFcZtNOwc2a9tAJz7f+h
z2TMxIu6IfZ03/t2d2aJdwoh+rtWxv/yQ9jL06zYIBs+hsqYycmfdzsMY04bFDno
39zTK+gVuHRi2dFzPswc2m0ZbF8lE0IxteGrHgtAVAamf2pyJaGiHxUFXsQmcBuU
a+Gi6zU4FO1zLSZhXUb8kNyrx+gfyS5EOCemLBsbuMWXO+IRZr+ByIEy+C6TuLHl
ejBCjCcAHAWytflXSW/z32u7sweslw0IJTH+AK6+cwgGBvEOWHP1LB1d7KAh1OH4
vQlXt+69wVvMjC8XHTo4medTkOM9axC17kNPf5Gun0T+Nz8vv7tbtjJ0uJibVxNc
7LVeRIwmg/xJO8H7ZlLEQU26LuDTWQosfw80AcoOcTE2kOY+F4KVXWMQNRyZPG83
azo8T91aHVJYlVlod4BLDlccwE5rvbhnkb+52VNkryiwOhcmDsOmgzmhlbK1KP61

//pragma protect end_data_block
//pragma protect digest_block
4be5tPzI9Kkfnrzh/kOyJsuLYdQ=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jK7U7e4QdpZahW4qCogMlYlIROc18X6raBoxxngtdrB0QnPeOeLGFHx3VQBAmcDP
Rnvc2MOw73o8iLzWL5yTEwP1rawMnJ1tW+9a9G9iw8owkOWZmAL8RST14nS4HMj5
r4nrqGIONWTfjeyFV0SwBO02YaN3t/2HNp36kQ7Mz4Lh7mUgXFEQBw==
//pragma protect end_key_block
//pragma protect digest_block
gGQgZjQNse6IU1QSUOQayiTb/a0=
//pragma protect end_digest_block
//pragma protect data_block
HlZ3Gn1EE+RbzU4DA9b86Ju/5ptzUQGUGzZqlQpYUZgb3e6UGcblWjL4dqWuMouy
50st0yfOLliFD5KKq0+A+joSyO5AFJ++yLMZDgBa28G++0kPRxcvLM457ksIWoTa
TdCJ4hkxIAGNGfdiJkdVwaD9R8oLfmUN+pt9gwIGAF4kod1gimqLGDuQ/K0fiKs9
hASVKNqZ0TxJH3ERTjWG78exN8XKumRZvXAbNZU8CWPlrPOSXarBpWWwyaCQGStM
MTrUrJoAtuKfPR7LpjUOrd14JuIX980JJOLcqe0Iuge5rVbnCJKDZ+jqN2i3WY1q
Y5SzDW77ixpFiVhx0FGrVxcvOcKvh5CeZCyzZF8htYrxqyd9eTU9IjfLJdDvWro8
b2kY2h/5uoGaiuCY+96vz5X5ChKBOp91kqMVOspxBPtm1IyqNCxzed2chZWpydZQ
saZ3mZQzbam2p3MAywN2UA==
//pragma protect end_data_block
//pragma protect digest_block
Rnmx7fdp63OGe7pL1NMHI0QEVsI=
//pragma protect end_digest_block
//pragma protect end_protected
    //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1UUmRHBA1/kk9DVAMz4tcaN5gXF22DpT7xXujEPCjeS9mvQkhzmsx9yLRIeQ0UkW
goydpm0OVIcge42qbdkfMwHqooDKPK5zfYXkbg8mpAtNe+zupjWkeTkp8zPh0bXG
UBXZ0X3gVpQbyDTFqFDvJZMzVdjdJ5DSXAOoLtUlGFbwfhWgHgD4FQ==
//pragma protect end_key_block
//pragma protect digest_block
eY9pp9yb/7HFefYHWnv7lq4xFz4=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
FMQPr/S0oPnKUHUjzB4RRox0yRg=
//pragma protect end_digest_block
//pragma protect end_protected


`endif
