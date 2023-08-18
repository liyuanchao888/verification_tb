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

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_snoop_transaction;
 /** 
  * AMBA CHI Snoop Transaction Exception
 */
// =============================================================================

class svt_chi_snoop_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_snoop_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_snoop_transaction_exception)
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
  extern function new(string name = "svt_chi_snoop_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_snoop_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_snoop_transaction_exception)



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
   * Allocates a new object of type svt_chi_snoop_transaction_exception.
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
  `vmm_typename(svt_chi_snoop_transaction_exception)
  `vmm_class_factory(svt_chi_snoop_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HuA8sqv2In8JApm+KH3nlhW3vhhoBItPVSLGHDbQtPnH84jitUqM7RTCvNHtQGlY
kGkugXDAXI8/CrwtbBz0gr6kYKYAV3W2JGfNXd8tahu0fAAIBwqznqljIcBE72Yz
1i9uEUJXCijpVwWlCL0KXyLyUOYhUfYaTso9iEs8uIplTmDYWPNIlw==
//pragma protect end_key_block
//pragma protect digest_block
76XrlQSZkztzfSxAhgKUMF4me7U=
//pragma protect end_digest_block
//pragma protect data_block
VVY5A7S4gPMEXRHJtGN7PBZLBUM+3lBCbdWCyBfYjBX4YaqPnypf36hZEhYSDPzP
LSgx4W4+hjPyqEsfsochGCAGYooz0QCOFzAI982mzID0MQkztBtu7keGR59yHr87
GS95/hbSEqdhjlV3LK6025xm27vWUhg6pcULdsyg3w3nfkrGGrrzbM6832UzH119
3Wg8uVdiGekJtu2V/2P1wHZidVRKnHkHpuwnaWrzlJIMr4VGefhK8/KDFtL6MnXz
LIBm7mgAP4gxKgj5rcn7X5Ltk2BLy8ftjBDHiT1fmli6PLsArAvFHmOgHXKH3MpI
OeC1g0/7UqQ7Q4lKN5q3kHTGSYIXIutdo7X+uoVkJwUkYAWQBVNTDjJj31o7zbxS
Vniz5b0XcONjVR803hpaQIegX9UKvl50TCuINGRM8aa8UDRFw4BBi102m+5gRdpJ
ttn1eKP2R/rwdVoUxS0qSOOJk5bvWT0/xibL3Ablamx2CS/uuQ/8QDe7l32nsPKu
9555sa9AQ7CdDOq5ITLBqxq3G9hs1wg7YBy3IXENj53C8cgqzD7vKyyVT4PNHvt2
2Jy2SIRRp4rCwVUfjDqRAEO8o6Iz5eNTh/uizr2ioZV/+htaeD+9Q91CvvGVWfcl
YRv2MyJx7ugZqv9FWldtu8mOCncGerhjW7VZRVkzJmymWw9SLR0h4MpIGdH7mlri
brdK3DDvMZ+TTFsOq9JJMV4DKiSoA4/VqDdtuOZt+0rPSk3wLZOax3WAn2NilddY
DZRWrO1EgnzFR5zmQEsiuBg+ms1I892tiK3OH3L5Inr/Hrytb9MmuWK3zYTIBcMX
UzyLgeMn+spBviXHyKN2Tuq34f/PaYYUyQxq+/gBZccGMNWf6PZISDT4kJDLUGS9
G6gGzMahDcL8t/NFWL1HI84r3FBnF1CrMXkYqHSzPpVK3zvTAW6HVzUZRhZuyu0T
VXPsMDYIAWQkgUiaxUhhSy5lSKx08vtPMQm6K8gOPIn79lkq8LPv/ANEYbEW0H8m
xIBiYF5GlwhPCbYfYEnosNJtxtCRHIavm4xnbrXKv5Hh+auVObzct2/908maYGhU

//pragma protect end_data_block
//pragma protect digest_block
+phvDpCuCmonK0NoXscGQt8H2wA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4a4MYUxHfFeQqheHZsBCqrJ+/YvBrY1Q0lpz23wjK4Bv1a5Ltt9FP1YpLzS5QuIL
xJAH3F+foXUYpMLEGd72l59ONqGc+ie9eQXfeWf9AkqcwHRlcZ4yF9p9AC9lvKj5
/LM//MjuCyjW9lOg5Tdj/HleJVQKcH6VAc8/QgwqjVskwPNsmuMzzA==
//pragma protect end_key_block
//pragma protect digest_block
/6MfuZD9pu6feZKxptGy1g/8W8U=
//pragma protect end_digest_block
//pragma protect data_block
D/49kCTxNwByJb1wxTrFBhABwhJ78Ke2l5zUvWzH5R2uXeNO2TPVuWf608ZR/3PV
qE36uZXH6aiy+kb8DxonEn9NvPUYXUEmvORM5TM6h3npkbwh//j7cjqdbBd8ex0X
hJRM7KLLJY8LPHcz53Ijy7+m9McKURjebYW4Vu2Z8zGSKD1b6TgpyJzaCcEyJiLa
A9WyOGfk68osdTISy1MdRhVqcNQpSawNuTvn7NFxY5ET/OOLLi32Dka8FibP7Tha
gQ+1yiYPSLZD8+yK82y3Ne97ZQToAxRUDbIrstxFdgsZmeW2tIx4Gdhcxs28fsFi
OjA3+5jIManx+lLvpT2S2VPiU+QfKmSHBitHLjE8I0cMFDIABzbaK8OORlxvU+Y5
GFd6bWen+UNepoMPlZYQiL1Ema5fxYBKvdqi1aOFEMzowJQNQuGfC5ovqJ71K3+g
LircURU/2Y0fb6+EiwKoHuE39UXnC0O/rOZAUrLUhRSI2r5PdudHMoT6SEeIy6vQ
52sqdOs2dGGf0fsi/jAKOMDav03+hssHPkbZuS8DHZ/Ipmd6Vl1EGZv61tL9Y92c
sLmPC5/EStuxqv3eZWXXF8pb1tifRu5Sad0FUtKa3rxU9wVGQuNkv28xOwFQGJ57
6o+nw1gE5Xrkmb6bb2F/s3dgnXjY+JKNzO90IP9QXvT7gKKCSE37Wbgl8huxAWaw
sheGKfAaeaMDYl7w1fVSlR828lqDvCYghWHAnZwS8Fw=
//pragma protect end_data_block
//pragma protect digest_block
j1FWCZWzy5ZT4sdE8CX1TNHEZ+s=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
veeUWMiM51flVFy6ZjQgeFQQhO4rkNfNR9w+5x1RTGXrabayEMO2vd4Q1Lm1rA8C
kXvaHAz69HcW/ny1DOn4YUIudOx7UIfFQJAdX7ZAAYd40xPO46Ot6dsbNsXOXxAn
wkAIDHaefgZh22S9RqSpJhm46XyRriBBsJ+7SwJTMeOQCM8HSxdXtA==
//pragma protect end_key_block
//pragma protect digest_block
CCwD/onR0q1xnxI8OyAUV3zFFtM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
rmpskDcsM3a2R+G/sIXR+zgvlQU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
iCpwIOek6iZXrUsjnH0amv/LyM5t9YFCcBy3xiLzajV0Bb2L6uCFrX6vY4HxU3/z
x1Clgh+PQToMXCYXJqfgaxopVHqQ0aLooAj9rHKDmx9HvzCCcFwKtE8nG72Fj21X
sHlwnlqZaPU1f2twIUEuDLaQQ+6c+PYENz5N8Chp05V+oUbQsbpbzQ==
//pragma protect end_key_block
//pragma protect digest_block
U1fblP8e9bC+5pXUFPMwim6PkXU=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
CI2A+WVaYz3DD5iRUNPiqRZTPus=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV
