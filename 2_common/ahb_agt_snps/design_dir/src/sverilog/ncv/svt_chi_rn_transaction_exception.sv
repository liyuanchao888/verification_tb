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

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_rn_transaction;
 /** 
  * AMBA CHI RN Transaction Exception
 */
// =============================================================================

class svt_chi_rn_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_rn_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_rn_transaction_exception)
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
  extern function new(string name = "svt_chi_rn_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_rn_transaction_exception)



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
   * Allocates a new object of type svt_chi_rn_transaction_exception.
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
  `vmm_typename(svt_chi_rn_transaction_exception)
  `vmm_class_factory(svt_chi_rn_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
tScQU8l4RvJFWGejLkhT6iU1apMoAcsy7oQ4To+meqdqTvMj+IyDsmeh61qXJvKZ
quU4++Q5VdaKQAjdbU0Wip+NkE4mufnubTfVttZHVB4h3a7uQLCoTIXIJtkCuTHc
TlpUmFoJH+VhnMmH+g7VdNEQEu5eqqO8ipdM6ZLY/wPGjlz5VNUWPg==
//pragma protect end_key_block
//pragma protect digest_block
ULmVkroitulXKPaBXO+lmMm9Sh4=
//pragma protect end_digest_block
//pragma protect data_block
llknkvC4NTCiDSts5g89ZpuQDsntLKKv3K3rLvYULag3RIce/uTWN9d09nSoh5bG
d1lIU537Rr6mTdWQArCV3+/vmTKDKmLGNtUwx9reEqgIYeLgUEov9bK6wIb9MZOE
kLfgap0d0wLjIXwTAVsn6P6YjLs9xUpdh5P/nZq2n1bjByYIjLkinga0chGr9Oyq
1mBj1YC29qFsR/Z0sunIzJ1urDvuDsIind5XSX3GgLc+8nvDe6xZFBhSG0SIY6Ja
JGYtMmaNuQmAxeJOvIYgbxyHm966tiAhYCKANQ9OvZb0tL9HRJOaOlGRUebNGyrm
dd8R7M6KEXkWxXQvwL/f7zNb3I3+Q/lxbFA+aQHvW6VK6p3+pk/JbfZaxe2BQHAP
Z7DBPF3t3fPCQaEs30FJuF0z1/8B+TNfM3GgxCU9CZg3cKUHUh1jce7yzj7uLoUP
NAw3LhMrCdIYZMgrAo+LLq2S/juQm5RuSQgOeAvN/W7HqIpWiFj7IFmKUMI3mK68
M8HaMHpdA9aPygW4WFXxkVv17G/oblnj9eSB27/6wnm1PL68FSlgcfnx/UYKXFc5
XN1ux3ckt8G9bYOxrNGwtLktCUDcB3yl6++f7z+Rm3EIiZjSokWraMLkqhHeJz3N
0f8IHvsCq13n2FBQs3vH1JXA/KWShiMsL95PJS190VBtr5MZ5dWo7TjqdjxxMryd
GtwNBlEXjkkjCW1m7hqe37ZlBntAwodpaCagP8rw7aETmAGAZFnvnPg1jO5CyVYU
2/urR8IIozRW33j13XMQt8J/eKcaTR4aEJn38U0SpwqBzuJo42v9ETv6a+SgZN0t
cNZB93xlkXjIKk0S5/ZsCaef5BNVeV2Gqm7MxWqM9WvML6SC9QpcPXyaN6wEd2SE
2afUzwbW/AgaSk9NyYc7Z2YSPQBAJJr/o9VbRr1PR9HvwM0z5Ch7uArwy/MSjPjw
z0kgkioAKOin3IaIHPRxHOQWAX1xeo6WgVvmhAQYEdVeVKNcRJzP8qLT5NuFMFOz
4AmNWm4B2SMjNFcRySLt5HjwlPm6Ppojvy+0PwtsXX0=
//pragma protect end_data_block
//pragma protect digest_block
OpMsV7uIYI++ZKZstJFL6RqTJZw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PAQ2R47aG0kATdDjFyH4ddGsqlr6JNlhSv786trcYAUhb94zxJj4pZCdFg7o+3EF
l6DPQCHwc8JAauLeaVHXkjf7tITJwijYxNHmawTBBulTYT2M6oBk4DHA5YdfWNlM
duDxYc1ttsP1jThJOtqKySfZlLlhPXOmUlMDki2NhX5mLH8/AGh5Hw==
//pragma protect end_key_block
//pragma protect digest_block
CWmC3OQKJihlVifUNJmaL76mPa4=
//pragma protect end_digest_block
//pragma protect data_block
5PfXpIDpB8qHNDMblg4++zC/XdKD6PPAfFoohgqhCo63s+29vpz28699GWnz8INq
X+jdZCWL8YxDDog84sL4hgkWPhYOz9+g/BH5l+X4F9/BR6yAbOZqSqfWCji4Iobp
eJav8JUrP/DgAVA5C5TyHDeID403xDqceKqBpOg7RDuqTVRyWD3RJj+0wyUg9Pyf
R9kPr2vbcmcn4utx6IIX8m1jBSY/8nC/8NSSFDcox7bgurDo7sM8h5gpT5q+H10S
Zg/A6Br7nWjua/tFWov5ZV1fHawCBcALMoeRgc5SUjdo4E0BrWN7N6NGt6Uze6ia
oSI8kVpoqp2ALqWhEayH0vVklMMyIVkRdpm5g9twboJzENVeaaf0/GxeKB/paoOE
ZRxCNpr0eUG50k85+HafEPwmkk4ayKKZP20KSG1+PpWwM15blOFpAc4i2B7+3wHP
RU1Nu1qvIaLxvPZLFHBiGau9L3d/lXL2wVXc01j4oTOr48LCSJf3VrMKCoDIZsiY
VhLkrP1WTfHezO1mw/KxMrSHE+RtgfB4Qbd93ANkF/u0zqkQ0BMTk8OxMQif5M4p
36aq+/DQGqUmzezQsy2BxOyoxY12+Ah0gH4YC3xRPcG0I5lrHA2h82ts1qJ1zWPN
kfCNOadMI1rQx1VRFO8g00RHHTwrHddOcwarxuYb/j+Ks2VEAcBoGKLPGExql+AS
uwaG07XCzK65axxPh8SR2miXBZzNQyUOawEWRZej66o=
//pragma protect end_data_block
//pragma protect digest_block
Jq0mTHez3dC9RSbpqxkYJ0LKcSw=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Jg8gtPpamb0tzzk14ay9pSIMByBXawD2FALGgwRK7Cnjmpaa2b1NkdAWfeXIms5t
fTVXc+c3BdMo3FIFzxLAY6ueS/1VJKpn4U3rmnxTQwsYeDi5A/DgOU5q2NxSDPDb
LjJpoF0QhHpb28Aqf+MdbTAZjg2PGGOpzLg8q2n8skZeGQGGn9Rjxg==
//pragma protect end_key_block
//pragma protect digest_block
Zh1vxLr5pFNuKyU4q5x259vP2vo=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
s5SWoHrKSzHvQ2VmyisErZt+AqI=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Zm/c7nK264/a89IA9boR2zL96oNwC9BmXcjoE6fuy1jBcEhRDFEJReAEQTFOS4iR
T53hD7OkztvEY8/Dz3OYEKfd6gWwrVAHtt8JKOyMpqJLFdKwyBtdCSQSBNJFgK/x
2XO+OQKUkJA2rDPqbYxM/Eg/YDEQc2Skh4kGaA5MTEat2ubqUtjd1Q==
//pragma protect end_key_block
//pragma protect digest_block
t+w/DMK3r2S6FhP1SbZ7SGFBKxU=
//pragma protect end_digest_block
//pragma protect data_block
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
C/OjnFU5okIDvSVPN+HbKw==
//pragma protect end_data_block
//pragma protect digest_block
vzzIe10W4oN92UgPYJy11S5CLE8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_SV
