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

`ifndef GUARD_SVT_CHI_FLIT_EXCEPTION_SV
`define GUARD_SVT_CHI_FLIT_EXCEPTION_SV

typedef class svt_chi_flit;
 /** 
  * AMBA CHI Flit Exception
 */
// =============================================================================

class svt_chi_flit_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_flit xact = null;

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
  `svt_vmm_data_new(svt_chi_flit_exception)
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
  extern function new(string name = "svt_chi_flit_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_flit_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_flit_exception)



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
   * Allocates a new object of type svt_chi_flit_exception.
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
  `vmm_typename(svt_chi_flit_exception)
  `vmm_class_factory(svt_chi_flit_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SSjWAkh1mLNCAwJ4g+qs6x3yhrpIjlKN/bHkKt/X/u9OBZMI4sbh5s9Wa0gLUrSQ
175J+wr7F8m/bkpaJZLRgI90eEMu7L2J+ct3XlZvZ9st47kH70T9bj50FBiQWhFI
jr90bJ8hac2kpfTImjPuPmFWU9ZaWpWXnvjRbq/4XW3Nqzobckc/UQ==
//pragma protect end_key_block
//pragma protect digest_block
0CMf2AcIBi5EPnnv+qDtdo28Sdw=
//pragma protect end_digest_block
//pragma protect data_block
ooASGPv5fVLDRWa651QzZScJQzFlonya/HPNbG+Nm+QJ0/kzFUILGYjmr5GB8klW
ZyfcCh9xOxRnCkrCHu8ovf5BU7W7GuuSKwF+7/0wO1XwVSuuRBfMSOouTSMbDFde
nLlB0LVOXLxaCgHyKym+n0ijzBfQicAIohlaprud3yehYFLcJVfYK+YNCNYeiTtJ
/CH3WGMnbRGTpE5g/1X6dyPlho7l9ny0P/V9v9iVghwqmOazffIH/Na/BIzD27ku
Xr8Ffajh3AJgN+yON3kGCfHQWNTF9mXG+NPQrjKWWun7XwJW4qV66PTWKqPQ9JLA
Zy31ZRXhzSRf1gtWdJgKx9xHpEioQQrxtNMwyEl/WsozgCfPAYVZFOwT8OrFjcmw
4JclPNs0QRp4jMqZA4TeLFI90LOMGYLHcyu5gY6Shf+yEfclXYIRZ9bTPJbZrt7a
PwfiKqRQrJDGsgh6Lw/1EsNYbJr9VwEtAtJy4kCRFmbQCfyVOCZvV4hJnVvfOYft
lgmn2xpt9chwzzK2WNfAW1C82y9b0YGbwDFY1Y7pTHcqHvseadVMubFPwXDFdKAf
Qzv5yP9dDTybCHNF4NTOeeQOI8+zjGyr61/IGiFx2o3C+n3KYsIGAZ8aN8gPpZV9
Mi6pumrDT3ZWykw+d59xZAawDGjZQi0QAtSCKjsmjOfjyUMCp6jLCj9XaGMvO4OJ
V/8g04haklXBcE6M59BJWtmojlOHDV6h0w3sBVjqjZbNdkJewYx1bC/HxTjjc82B
s9HyXAwSM3tdrNUYIXRbuiOOwEmRBajnJInpMiU3NYYQj0b0pJaLU8NdUExmPXZY
hGv8SvENdGrIzPXtELYP6ubYrlwJVFe1vmNOQ895Oj9C3qhd1GW0wYhTQT5HJJCs
NH8F42zAh2i9S86DZrTgOUe4IqwWUDh53x2/OPS/sD3DnB19Je66h/u+WeE37g4e
JUopEMbYTHtxNu3VSXCmEMXhcDVGtykmxiiq7vs9eEY1FIa5e7jWXXVrYx47QtBd

//pragma protect end_data_block
//pragma protect digest_block
xqIUT3w5ckUNX/Sejdv669kMfbM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Gyj8/0782UtwY5AiQevSReJQuwC6RInqLtWy/x34vd+RYMsZ6ln+gEP5k/yunkBc
jbDnE90ncjSSa35YGJajLuidWkKfQUeiHT+ZukOi9UT8SouwU856DbZsFfUoFTpN
JTrZd1uFUE6UmrXDvQbOIOsRDKDis39WOps5qrvYwYTDsgUFGrMCmQ==
//pragma protect end_key_block
//pragma protect digest_block
oQJ+3iOKbiwikdk57/nOBOvpSps=
//pragma protect end_digest_block
//pragma protect data_block
enBfCxWqyVo5RiJNM0DolpWRKMQQmhgFmUsfY0UJtU2MZ8iCUjiv7ZkBlZnnK9mi
Txc1hI1uq5kp+YxAyAyjzzLTT09c6nXeKGkoyc1LwP8dTHj6eeLD+UpexgDN8JUj
f7QErDXy4CpWo1Wt7sZV3yvg9Zm4Jf2QAZtOcsaHdWDIwCHHAY9VyAtg62CHcW0H
5/eMOTgc9FL8jyYzTk5Y5E2MTefIq4wQIqACEsmKuT54G9q4dtp+lBLtiibjcIKN
WkbDnOp/hU8ztU0rId7GfjEqopbUE9RE2HHpNbXqXMn7144WjfTzfgLLOOQ0NWW1
8SI6VZU1qvFmdgw+/DAFeCrjcDedeEZM4hxbfNH9kfemHAVwzLNS694RI/Y8UNG0
k1uPzYAleGvNUzWkAGuVgypkxIqzx+XWhKeZGCVEPHX2394lEiv0Y4qcdW9pqOJE
bgQ4Zkro09qOZOJRZ1htJhH9d0YZVN5pgsG7tT8/ULb9dJw7AwAlgzFDNbrUzl7S
anViZ2z0Tq0CEouOvqAPRAsOkwdcAjsZgtk7pPfO46dkfPB+Et5y+1HmEyt6B0Dy
Pyvnd9AkmSUuawEbjzwKlVJeDVx5Sg9+qULCdqV5IeWYh2Upic5XuyZGiFwHFk/E
JIyeF7YlMopEn1vYQiMGOy5FsxM4Tsgr5DxZKuUdAtpAt52UDWCFmlikiC845Ssw
5Tx00xuYHVbUkYmdmXAaew==
//pragma protect end_data_block
//pragma protect digest_block
i3fa7qPJKquI2xNyEThNI25jU0k=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3utRLSDpikbw3i+8UT/lluogkUBUJhSBoShr1cIF7wCjrLifONotOdHhiXc0Ll7R
JYH3tE3R6KHdIoi7TEvEQErNylo0kA4TRJ/Q+SePuYQGxj9k54RpleKrw9xeugzG
nh4nOOU67Vo01I2ckte5xsc+8CWw3+8SOxNepLEZDJFb29UJdTgjxQ==
//pragma protect end_key_block
//pragma protect digest_block
Q1kYKppf1aYDvnsSn08wNzexmyM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
c1V0YzX21L0uh++9zSB+HzTuB3I=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
yZVVGCpQofDvqOqgrOCXWwZUlYd04Bj+7kjFg7LRmO8bB7ToswYKkdnRJvnZn9/7
5j+JuIWesTcbevBdXIZKtbXaJykkiBaEuC6gZGKVHvXaWe05sybFd2aElfuQVVnD
fk/F3HBBs1Ckq3hHk6xco1DUkj8eK4DYSYSJODP1D2RLd0YVx753TQ==
//pragma protect end_key_block
//pragma protect digest_block
F0IzcjiIwCWNL/uTIl3yrSjMemc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
oTinSGxmIlhHNgSzeSOtHBtzp1U=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_SV
