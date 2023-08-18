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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
L7I6oxnEmZ4N2p2r5Xw76D9HY10evuTEnm0QFRJFGD3HDHCEaRmO9WI7bJHhPPNb
sbuNgF6l26TjOE7PPYJWGzA53e6Wf37+rwAz1ptuZQ2zIFGvhpNz0eGqJw88Ke5L
Yc2ak9cxwJOxpN0JCRaIFwLWv5CtfeESVVF/UahQ8HA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13564     )
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
`pragma protect end_protected
`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZnwVCO0Dk1C6QGwD39a68YwUBgVwaszTjf0p9Ymou6hzX4DkUvje3XamvIDvDFZD
GDPR9HLhZni6Df5uCo+obpJHFtrfF41TyE3c02gmu+Dm8NGwWbAUyS1KbOOmvLem
JG37zkHmifOza+FldO7sxp900Vv9scXZ/dxkXDbbFVg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13647     )
KHBiuxj1KbNDM2kDxnIituJ9kgpxBTIyCkwkqW79aS0aoNBgVKqrCAaBkRuFZqxb
YT838ysv2croMWbN7GppzzrSKSTux8e4LIXv2rqGGpcXydPd/+aKWpJdDAV2ile+
`pragma protect end_protected
