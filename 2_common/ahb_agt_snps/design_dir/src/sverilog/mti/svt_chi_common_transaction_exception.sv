//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_common_transaction;
 /** 
  * AMBA CHI Common Transaction Exception
 */
// =============================================================================

class svt_chi_common_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_common_transaction xact = null;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the exception settings are supported
   * by the chi components.
   */
  constraint valid_ranges {
  // vb_preserve TMPL_TAG1
  // Add user constraints here
  // vb_preserve end
  }

  /**
   * For exceptions the reasonable constraints are limited to distributions
   * designed to improve the value of the exceptions generated over the course
   * of a simulation.
   *
   * Reasonable constraints may be disabled by the testbench. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG2
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_common_transaction_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param name Instance name of the exception.
   */
  extern function new(string name = "svt_chi_common_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_common_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_common_transaction_exception)



  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_common_transaction_exception.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE compare.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision(svt_exception test_exception);

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

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

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_common_transaction_exception)
  `vmm_class_factory(svt_chi_common_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Zp2XJO77lkG8/bfriSySHVOp+F61NX/LENMbyIqxXQtR0STHl9fLXiXXeAjdeAGQ
0RWd5Nz0dttKQBygayUEDfR4aouoI6LokMb3GLNqiICWnmKtrgSjoxUuG7GTYrEu
wZD6id4ucAEGF4+sG3/PHdLCS1b9vLRXkHfXOS4h1NA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 650       )
TJmxfORDXuyhLzquvdto7Qhpx2xF58PbSMolQiTyaEqQZn9Gg0e3E6kOzhFVt+rA
36LqHhIuqCMiNg3ZiQvaWoA1JltRMcKmTyXn9BL0e87z5BPks7G5FVMroF3dkOHg
Jj4+zg8GuI6XFm9M8BTzJKBCo6jdD450pD/4ysBHSRGSs9Dg5MygjyVabxIFAuPF
w+aiyT9+V+XteQ0tiwm4XJbJZtnacINZAMk6Dp3FS4N3CSweS179keJks8U7QC9V
qQbWFSI8BCmuz+NMQYVQVg5UeFfeHgdJB7Nc78S5vxRF7DK2fyOEXwIhT+Z3dd00
+wTvdHw4pYOVlgBmQWTSj7X1FakWe14thc11uuQ2VXONL4KgZ782VV7sXGWgCbem
FI1D5Lb6CDED3cJMLg8QuVnts/h0ZeG9iQtCibLqAnYBahSzu2J6bB178y0SQwRU
+H+MOq/NnIuZFobkWPJXRUZAu9p1Qjqv1oKf0kY08j9T3oxojQ32ZnBz/KsOoqFb
ywN/ZjpAS6mr0eNzdLU/0W6jKOtd8QQsVfkFXYbrQL63WsX2rgpbGyNVNLBz4O8H
NSLJ2x8UmRAJ+O2yKiQr/rx+7CX2Q2OHJvtxuRB+xRNA1IJixf6YsTXXk/p+UOV9
38aiA5nKibQfr3W04lMCb/b43qponZoFMKjDVlsnSwlKtiY2LcTfjz9m3Si5hOZL
qtB7pz9+jAAre58YobYyOW+A54EVggqUab2+WpYizl8AlbO5PhuwhF3MO9PSBIxf
1R0NtKq//P8r0qAygc8rJtK6Q14Oqh9zd3x7pgBDG13vQs0NGQVLKeyyksIiLnrT
x4AxzaBBCJxooS/r8wh/aIpAQT7pSjChKbO4pPmuDhA=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gvUm0Lgijh64OYVelZc7dqGlodLZaAazM7+v3wMZUbof2QWC/UAjbBD+yGejAEYp
YHT6nTbdruCmpT/7iOcHRBc0W/fA0bZ2gBu5bLx8gq72GImFnfPLNHrDBeYn/gpK
Qq+UxmD/VEZ2EnPRI9Ct5F32JwnlNDskA2SLsNt4q9A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1038      )
3Bh1dfL/B7tadOuG8LA4G9IXxFC8/cS13A0epkOcKYRdmH9dYhPPfXC+N0PYWygB
45Xap9bGrPzOdFehvl5HzV2wn5yhr5/QOOSL7CtnIhzIS8UEL9sI4IlSvR7ZW+3w
GbRkUDrZMzAYWA23dTOYqWPihskedEE+QMQfSl4Vp+KiA9lzUxHsCNBBjY2EIoQA
Ar6+vgvdChrCRuC8z4LGaM329bHfLBA0pI4vv9SfF7WMHvZjIeKl6hnSqVRixE49
eFM9ZTb47DQvBldrPgt7NWWHyXZajAbVfVVD5iITeSE98YSeuDEdqXC3cz7Pe6pc
tc7S02nTZKoPe/4qxWsJxWBXs+CwEFnhAdPhsXhqiM6vXt4ne8346UVcVTZtt3Nb
gEUCz+a6PQPNtLGZ3s70eJmJrRrL02gX8gVN9/8g3o3z+oDt9aD3pz+ax9BtERiY
6kbh2062/BOvrLKghm2C7lMHyQk24R3NURXBAXTDjQZWHGOQKBiZ6/xsavNSeqIi
pew4kgorXo3RxHU09KkoKA==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HyRbRbbqFLU7N0rENpq3ESmHtZmO7a3hOOqh4bkHQrUMZU+BfF2ZeAYB6Wcjb3Uz
3OPXg0lTHOgcPKTeAs8lTQxPhKUYrIw1qmTDke3IMo1vk0zvXfiUn1YktiYShSKM
HwMFbHnnq4bUjnB6wD5ntY6jot61GvtKoBox9Ba2qfc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2973      )
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
EVTAKUJnWqjbf0qp79jnkA==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mZXGb6Ql5dCEZUSrD4HT2FqXf5bSn2T3eJViaACWUfME85K2Rtht7gTfJEoYtErt
AmfS0CrAzKQumLmZTVW9aHXOwNrkV+xeQ+/NMrxORWshaMmRreGxUCTwNI1yxd+0
wWJ2tKYpYX9hE5q3VZUDfLzyCmqdEs2tO3MVPpfwQhw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13127     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cPMHvWk1hmQUnberuma37/x1C8WK5pcXM6Iv1xZu16ATvv7yJlpGpSwu+kbLjb0c
g2rrfIMc/q94PvUrpSlGZEcEz2PfDUEuFwZOBlSdPUjn2EJE2fF6fbbVrKDZwgKB
QXmfcqzR6lEQQI60H8xAU5PhQX70E16Hc7TBXn000RA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13210     )
z7zk5OmCpR/z3W9jMzLABIR+GMph9xnftvqs1yZyjc2IKnThOFxYV0YTUiWjqIks
kDw4utwFdVPSKCvTEudfPQGkO3xBz7zBnmiZ3iFiIgQeTVb3nM8lwR/gNZNnN7LU
`pragma protect end_protected
