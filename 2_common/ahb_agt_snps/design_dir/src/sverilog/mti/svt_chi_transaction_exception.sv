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

`ifndef GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_transaction;
 /** 
  * svt_chi_transaction Exception
 */
// =============================================================================

class svt_chi_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_transaction_exception)
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
  extern function new(string name = "svt_chi_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_transaction_exception)



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
   * Allocates a new object of type svt_chi_transaction_exception.
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
  `vmm_typename(svt_chi_transaction_exception)
  `vmm_class_factory(svt_chi_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iEK1K1oXJ0NsjUkSLaOa972iyTh6x4vUCm2EmOvDTMq+CX5n4TZrYJhcvEjYfXbj
UqclmwxC/FT4ob2uJOYEhiGAsLh4COs1AHIXYwXCjry85JQcik2WtiXG/ssfgmBF
nTjeFh7g+dnnWT32nf7QT/q5EaVzjY+Xsrv3wJPF4wc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 622       )
R5TdQ/fuWooVkK03kMNzXc1fFeZss8B+nQwzESGiOElvKijHsoTYVKscdyo0jBU2
R9mDGbU0rn8LK06kqf7str67iaD5FKNjFhA1eErCtRIEPMbjsXiL3jsrwOXrTDEX
l8zIt56f0xTtaLg3ng9hLvVH6MUbK3mAihbTBt9Co0EyXwe/mVM4P2KgK0RFR+Ka
O7Ag59YxwB3U8kL1Txh9hJTkekw5TceJH/3TTREUH+l4C4/j+zNk3sB+48asX4c5
6zvLTGJ/nU9XYvOKb0Qkt9unAwyXotiN0P81sDQmoY0G0tJs0rHMBV1jNFyCR9aY
xbD0Az9Io9uybEiE89Pb1cY8h/otBeKw2/nHKwlfrnYBSRljfRMzGgCc5ZooSbBL
lHIHPEE1FiLfOeMcA+diT6IbUuTIrJl6xGFExrPIWawsngeEkz1HbqNLq28MIl8r
X4uD/P2Wqk9xK1gph7qokMVLc1Fyb4uiK6htF7mPP5b/xqrz2/1NoHVQYR2XH+p7
kTtq9VFKRlRUs302CqZ5+y5wJUr8Kb1xA0Nyy/c4+0DC/xbmD/VXyNNnWwvAQtVY
qysrVqL8/olq2ygcfY5Q7ReQI5WZTediM2NSYk/+fNTdFdfqkBQQWdVrQomZ+pAo
Y1SJD+Wwv7T8W9sRpOvnmB7QTnkuUwz7s93X2IqD4RX2qbqF89Z9huKmr/cE2dXC
kaIGI0DixTASU2tGj6+PRAeoy4szzZJWhdUf/Gml5n16Vf5mzg4+7xQLNi6HIqr8
2ViSOSoXesGX6AbnDVzkSSWcLB9Sm87G4izlTgeODBN237eOl7/xe5X0dBG7zy3O
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mOrXWgXSPfpHFPs59K3jmBsZsgEHB3uubJP4GyeGUaOtEStH4tYd7Dsse1Wgbvag
NHuzS8OyZgFkDFTvIuhBd/uROKPDPPDLz32dmmNiOpRH65MevioYGl0rZldOS2Va
KhaA6EcPT7YnmYw8Ie4wsUMKzOyL6EjJdp09J2KECJs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1003      )
eX7bhOuF+bYjAKmuTbfnw6eDYzKXgcz9s3FkPtB21VkAQRSpg5QNilUjRaDlB21r
9LBawgGxd6YAMMgxyMHalTjF3I3jXLA+1Db5qAB/fJ2JgZ64ZGSyqS37JjFfPMmN
uy5ybm+OvBXKKTBoK1okvSy4gQKNGbxGC8Csz8J2uEAwXoK/3vtJQNjCWg8sFDSu
xoF+DAesXxQfVi1+StVuoFm24Aw53oqIhFmcf0hsqzxHR2ySNxgD6yQ9brKXVmLL
GsUPo3chqQCNpOEmSnB03EW0/EHquul9QtRX01bZ05+Vhy6/SHUCBdLKf05VOwAp
lvHWEjrLtE54LpeZM03k7v1K5ffUXG7Mqga05Z8Hc9EqC2rXyZF4L3O67JwhxRZ4
7XtXZ7//yPjdwy/62FiGbeNXBCWjNtN2NLrnr52BqDilpIbdcBtsfWreM2ecUwaf
tdQDHj/pt2937kt2t0EHTn90ewi3QoIosaPWlyfdZU4gkadDj7ScO8qbvfULR8Oo
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JGTBnPcXR/eVFvD7SSC9HCaF/QplnaMgAyc5ESFC2k2tO0hsRGbTVXEidz/DTNv9
cLUWhfy149ibxvtG7aWBKKfJklOQqSrir1Dmx/rDg0vasdK+Klq6Dn9ztNdwPEdN
Y2ylQ6iKo8hzxXZcqlxbcPPwSKyQJoMS9o2GLgXixoM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2938      )
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
BaL8gFsZAQ/ShDwzf5/2Yw==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G6F/aKp4Yg0tu1U4+OFI+CGnRgpvPgjh/6pFFLyKK4mBcxathdG3fk+T+gZVrLj4
zI8z7oe9JsF7hT1qov36msBoc7SIw/tIQHYLqm+p/pi6tzDW3wdric4OW8/ySRb9
Qos+eXulqmyCYVEflCJXrcLtFkIE2c/TteDSEQaAZhI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12949     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JAi0nrndYTSO1qYYbcCKSEWpdy/v5SIq72gyedBeQ1CvfnBwS+5m/7cjFEMFap3G
O3Xm1Rfgh1J5rLaZY75gnGG13o+q2mLPthDO+fqdp0kFS0osZnJoZ4aegEACzOdG
394B5zH1RU2oxaMzeiDw2SLAvdtiyO5ZOijiHS5ELEM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13032     )
vQipk73Af2cLu3fBUEhfYIVMEQC04IV3FP2eEseokRaerQH+JNpkt1cXCnmjpBo2
j9Uax1H4YBSHFigNEh6ItcMfdeROWIDuZrM8DeoOq9qWZxlslBbystzqs26RAaQ0
`pragma protect end_protected
