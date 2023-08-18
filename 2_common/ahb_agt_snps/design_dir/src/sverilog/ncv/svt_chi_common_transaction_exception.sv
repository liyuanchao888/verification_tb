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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
S1oPQ+kgfHN33gbR1af49ehqupqUpSZmgx0LnlNxXTrdWuX2utITOpzRre1EyAfu
cMunrr3l5eQlN+7pZR6rGstcXKzO7m279o0Ptb4RCwugLxbvqraqYZYrfB9OOhsc
SLocsRC/IQ+iZBmS8Ex53y1/EuzzSKnlqOoqEyc+YbtJsHT37Fwaxg==
//pragma protect end_key_block
//pragma protect digest_block
Hn2YElQmILiGXhLmlCJ9lBc26EI=
//pragma protect end_digest_block
//pragma protect data_block
pE13iCE9pdJdaVlpVG8uC91I51RneneB0YopA7eTuaSK00EysAV0FUCG28cN9UyH
4kNn1T0dt6LQoyBeedWzYrrByxRlsI6dml9GiWwPccH4Ob7fbFRjlIHx8AypjaaL
Bj5kqFUGp3CP9OtMUnfFK+npJ+ARihEZYr0r2ZoRzeax/Q5anPPWXnjlg26o/ZiY
uLCm+jJtnTS+3g17UezpTnfQijZ+9g5PRb14SEJt4iK/OQAW4RIm5EmI+Ib1xi16
LYV6qXrc4M6DYEOmXDUihPw60KL5habskHlsurDMoqEPnZT7RTUSsxi3hKBKGbaA
zSrcdYiQ8jEfQWNtm4Dn2R2yOeT7W1meZiv1nXXuhMKt1+JhWfB+gaoPOL3FP/Jo
JPryF5rUodvGNiCUCjrt78xoypyZ/Gc8o8Jc6p0+NVOfX6gAPvnyApixxCYTi+89
UA8zQGBcN5SWFsJBhVjW/vgiqPfrgGQYX5Q3eN0GSOGxaG3kEvyObVpZzi5PwoRc
fKu05GJ+Tl6S75MwK0P1X4vMrMmmwsplqmJI9Oc8nLaorjFjccII2dRjnlIZlBg6
6BvE44TRvufzjdFW+0Jlq8F2dMGcWsHoINd+j0deGFMQ1lpo5Fr/H7q2OMCYrGnb
rlb/fzXbEyZ0Kcb6XQfvHTg8H2CSOEa616GYTYBI4cq60JLHpAHqios+/grVO4NB
NOZDQidqFfso7H3xizrO6nvu7Ub1JrxaFMykRD3lKiHxMXvkxOYITSKaltnQYmJk
PhHUC/rIEtvsPCQm4s1/bwq5Abaa5+JHwsi15c80nv23lxmREUg5Nov3qBGKdOy3
tm3dF0l9mue8DUBnHVMv9OUdCmHeU4wv4LhaODfEbkASxU2QM6/fn/5BJcNll471
mTAMqAiufd/xkbU64QWrSCh/+fWGDyadCqsCRvOKxl3wN6Vs4qhAoBekAjh1H2aV
QepAVhLYrBu/1UW/kgZelUXE+M+nY4GQJ8M74ZzNiNtHH1g9F1hzPMjx7/8FhJrs
pQJPTZ6BEj78z/T7u8V8HvuH/0o2mftIoU8wvOOGJen6CTDSv8Bfk2R6GiUTVk/N

//pragma protect end_data_block
//pragma protect digest_block
929GTSJhVMMxDXCk5e5hCQpQxTE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PunrxxGiHG8fk0gsHGWZSSkZ3y6aOm+MUWTKLLLqEnLNv/o+5CV/k9UVelVu0/7l
D6umpYSgKCwLnM6fuR/PsFDrTgqq5ALTiPRodlIOvhnCB8KhTKiSap62Rwg1ro2g
+5g6W9S8E1+DaKoIu/pLM0diAzmdSQATvAf01q7q3mpMBGdlMqrqZQ==
//pragma protect end_key_block
//pragma protect digest_block
nFswxKM8kSAYDVrRcrOnqBOExG8=
//pragma protect end_digest_block
//pragma protect data_block
TR9/Ll+hEpM+vZWL6Qgfgj/pLj7KvmXNbm8mlH9T0quaAByYBYwfpoSV42V5SeY5
RA+M3AyS3Nq69KhkAJORdY/n6KZyq+qxjS/BFHM9aLqc9Hv1E3CET6xrCTvbTf8+
gj5IkaXVChfC2r0mAzsJX4t7d+hNDgULWFchYSBlpNnwftzPWFI90+rLXN/9c0LI
VmzRDRNRwTfsExJhOlecX3Dm6keODPK/XU4UW1Kjao1nw2Pn6e+BfMY5o2RHyLWY
6HOJDv+bJp+CJ8q8Yip115oLfa3VH5OyN5vlUGmO4tjZpXcbf0jY3EKLm9ir29+X
4KsbPAmUtsRU8vbzdMOS9PXkdfMTQb7hwN+jhCf8jgTYK6236U33eHCzC2CUaM/A
iBfj8uQyLoWdNY5RxrGt4KX/5ZfVi5ZuxmuXwxhJfSA70423YjZAsE3hJl4R12kF
G3uViMQtO0Yh8uwIaz3v24FhdTOVowDc3Wozf2R1Mu9KEuflUtnhOY3FMftJiSH5
71zAFx4ytq86kFNBAzzoWE2DHrg1TKf3kF6Js1iRd98V+juRxDdalazlYsXBAKLu
6kkCwQ01iD7vc9q7ph+fhR4i6yhua3ScbDYZD+vQ+JA6RkLGlEUK3MXlTilYIXMo
dccAnwfxEuh24K7w4VlMBy1KZVX9CIliw7Ebj6HVVuYhlSKAkRQDz2ZWtw3ygHww
Pqe2qi/mJ+abFz2xgoE/RPESlzNSGcSnIt9R+9imz94=
//pragma protect end_data_block
//pragma protect digest_block
5RFj8BE3JIv3RqUC/tu4j41B+QY=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
R1glhz0MHjNMNaPeuTvy0nL0Nmdg4Reyxuty/iXmXJNm8o1XFqDSrhBid0mK6qAM
eh1maFEXWdNxYbBdFhyz85udG4YcvuhLuWIVTfSzNK9ZAWs4HwqtWX3oziQAdf4C
Ft2La0VjyZVkx5zOUGdCILSeLjc/6QhFbXRqQ3R1RP0CDN/hJANp3Q==
//pragma protect end_key_block
//pragma protect digest_block
FvuuXmyoLIlK7wu2AL8882KHeOo=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
S7FYSHuUMxWwNrw7hwfalGD1mRQ=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HP2rO6IiK/0ivJfoSF85Buvj8yvoibLRJdSWlfui/TlOctTr6nD7ELLqaaRUpQE7
rqAKMHDo9a7D5xpFSPdsKqL3KF0N3TL+DvXs7oVb5TQ7QX5fo0tvzf6z4ZcMR7NZ
R3FZMErcay9gWep5on7GtkaFuD29rvzNvfg7RWXLA3iP6gjBjM5YHQ==
//pragma protect end_key_block
//pragma protect digest_block
eUm/J1uNDjY+DzCkLWyCGU+x5WU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
MAZndVxyFQLkToVH7RX+oYbv410=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_SV
