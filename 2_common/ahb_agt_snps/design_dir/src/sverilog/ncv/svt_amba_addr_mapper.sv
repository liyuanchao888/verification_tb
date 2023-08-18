//=======================================================================
// COPYRIGHT (C) 2016 - 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_AMBA_ADDR_MAPPER_SV
`define GUARD_SVT_AMBA_ADDR_MAPPER_SV
`include "svt_amba_common_defines.svi"
class svt_amba_addr_mapper extends `SVT_DATA_TYPE;

  /**
    * Enum to represent security type
    */
  typedef enum bit[1:0] {
    SECURE_NONSECURE_ACCESS = `SVT_AMBA_SECURE_NONSECURE_ACCESS,
    SECURE_ACCESS = `SVT_AMBA_SECURE_ACCESS, 
    NONSECURE_ACCESS = `SVT_AMBA_NONSECURE_ACCESS
  } security_type_enum;

  /**
    * Enum to represent whether this mapper is for a read type,
    * write type access 
    */
  typedef enum bit[1:0] {
    READ_WRITE_ACCESS = `SVT_AMBA_READ_WRITE_ACCESS,
    READ_ACCESS = `SVT_AMBA_READ_ACCESS, 
    WRITE_ACCESS = `SVT_AMBA_WRITE_ACCESS
  } direction_type_enum;

  /**
    * Enum to represent string of Slaves
    */
  typedef enum {`SVT_AMBA_PATH_COV_DEST_NAMES} path_cov_dest_names_enum;

  /**
    * Indicates the slaves names based on the Enum
    */
  path_cov_dest_names_enum path_cov_slave_component_name;

  /**
   * Indicates the masters to which this address mapper is applicable.
   * If the queue is empty, this mapper is used for all masters.
   * The masters indicated in this variable must match the name
   * configured in source_requester_name in the port configuration
   * of the corresponding master. As an example, an interconnect
   * may route a transaction based on the master that drives the
   * transaction. In such situations, it is helpful to have mappers
   * based on the source master
   */
  string source_masters[$];

  /** The global base address corresponding to this entry in the mapper */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] global_addr;
  
  /** The local base address corresponding to the global base address for this
    * component */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] local_addr;

  /** Indicates if this address map is targetted to a register address
    * space in the interconnect. Transaction with such an address will
    * not be routed to any slave
    */
  bit is_register_addr_space;

  /** A value that indicates how a received address from a source will be
   * mapped to a target address. Address bits corresponding to a 1 is directly
   * passed from source to destination. Address bits corresponding to 0 in the
   * mask are compared with the base address to decide the destination.
   * Non-interleaved slaves will typically have all the lower order bits based
   * on the size of the addressable region set to 1. The MSBs will be 0.
   * Interleaved slaves will have some bits 0 based on the interleave size and
   * number of slaves an address region is interleaved with. */
  bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] mask = {`SVT_MEM_MAX_ADDR_WIDTH{1'b1}};

  /**
    * Indicates the security type of a transaction for which this mapper is applicable
    */
  security_type_enum security_type = SECURE_NONSECURE_ACCESS;

  /**
    * Indicates if this mapper is applicable for a read or write access
    */
  direction_type_enum direction_type = READ_WRITE_ACCESS;
 
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_amba_addr_mapper)
  extern function new (vmm_log log=null,string name = "svt_amba_addr_mapper"); 
`else
  extern function new(string name = "svt_amba_addr_mapper");
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
    * Indicates if the mem_mode passed to the function matches the security and
    * direction type modes of this address maper
    * * @param mem_mode Variable indicating security (secure or non-secure) and access type
    *   (read or write) of a potential access to the destination slave address.
    *     mem_mode[0]: A value of 0 indicates this is a secure access and a value of 1
    *       indicates a non-secure access
    *     mem_mode[1]: A value of 0 indicates a read access, while a value of 1 indicates
    *       a write access.
    */

  extern function bit is_matching_mem_mode(bit [`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode);
  // ---------------------------------------------------------------------------


  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_amba_addr_mapper)
  `svt_data_member_end(svt_amba_addr_mapper)
`endif

   /**
    * Returns the class name for the object used for logging.
    */
  extern function string get_mcd_class_name ();

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
v6PTtgIyug9XIapdeDlAco2TaIqVosechAz9VDt5fvqsEi8VBXBDVSpz7T4T4fPW
PLBpqySiIDmcjtXY9eTfBLBnqjH+0nnONUJSsqZYaDECBhUujCCMnnc7rkzYzK2+
eayTozz5T+F3yvUjnM/MeUrFs8bmuSIM7QxE+iq6/UJOmLlKVl7vzQ==
//pragma protect end_key_block
//pragma protect digest_block
1sK0T28HPJGAVIGrGoRZLX90VaQ=
//pragma protect end_digest_block
//pragma protect data_block
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
VJ4NOF9rQfXVyHaL6WucwQ==
//pragma protect end_data_block
//pragma protect digest_block
EA49Cbi6baqWncfQPKkN3atX5Oo=
//pragma protect end_digest_block
//pragma protect end_protected
`endif
