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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gce7uFaSclVSkn5/Ba3crELevdJnBbY7j+zTiNeWDeEqG4hBV+5+4lyO/DUEwtno
9v9yfxR1lKhF1i8W9UN+y7qEEZCFBdxEmlarlNhcMHyl+8t9eIRI+ptIsfwO4hSu
+V79Y0o+PtthQYDLt4v/DZDA/C5EOCH2rO86qPDAW8ooPPg0DWLHOw==
//pragma protect end_key_block
//pragma protect digest_block
GCWuzcLMgMBTFYmgMRPGD57k5yY=
//pragma protect end_digest_block
//pragma protect data_block
TQvJoEziLLSRhOawiiLbWVSFCh+M+VCenHupFg5CMSMYWRr66L+JkrZ6kotQeatw
Cbf8Z2wQbroggA/0VjonU0kH/yl5RWAl2JtjBjXtLFc/QoJgq7nv+O9AMb6V7OPn
bmObtapyKUM4WSnkIybHPaD8IJIpUWSVRs8aK4qMjM6qFfxs6g6T2DsseUuesh9J
n1TLl7UxOdpCTfIfFeyXzn0e0iQMQjvwyQ9B8E+qZnS7njdzBXlFTb3adRqsqndG
io5FYt9PMc0joKS7ESERWq4G1ypnR94HyXiAdRj/KSW8kFkmXYXJ4bpckoCjCriM
lPabc6uHfxwtOlcFyCbweq6CGAsYLY1pm7yoLMaMO7k9eFUNlhsugsOyiIGaCSSf
sgn7yfEA8TM+ZeZT6GZXXMuijrx4VJWs5GkFcaItOp5o/1kXSwowSrmluE2gch4S
Qa1X0CsZpxtu/5DTReQ4p1vc6ZQeE+B9n4GQIuHzZ58zpAo7ZNMe3AOidMvSjGqC
MYrGSFGNw7nEQ22WnJXJupo1BiPKPugP3f2YUHFSMV0xayZLRNAv/jyg71+hp+tn
qNC9PsOFJgoKc3At8hkmL2BTNM+TyU8jWHKrLBa7ZxD7hPyNpKmV3ny6Q2IxyaAY
O2zwtbcPyl50IDRH7RzQ9bDublu3yTeJMDrYEBX7pTdB1NA079DBDHF5qgQeet50
0ym9HQJG+Bq9I6vQKnXEYsfPTmdNx6XPhjSmsQqJ2HIEV+ZCoLbfs886xRh8UGEk
tjKhteBIXlnj8O++caMheyON5NO5GMZ9XMW2cECj7+HK8/XaOaseFj1GFlfObc2c
VBvrUxoT0A6uVGTP/9Zi3v+PEqnDRNB/IIH9xzAUxuLxQclMbIL3cgBdyZ9XR3D7
0Edm9JplhKQphm3oSMKG4LtDJq7KfQ0otf8kceJHCIbiAKuz/Y0AU0L+KREQc8D/
lvr0hGRP7eL3CElk0BU7yvwWN9ICgV4hO2emGUDG2iCXPcy3mqsUT4CxuvdIaDzC
HCBOTXlQ/MaV0jxz37eXNMubo7qZt0zNJL+3zaaICsQ=
//pragma protect end_data_block
//pragma protect digest_block
b5Oaa1fntkn9SGVi0KpYTXpbWw0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
b/AcVLGXYXv1MT976yfog+OxLseDH4jZ7u/ROpXNjtpPCW+I4T0eKDu67BUVsf7Q
TLvC55dSlflqC0T2VA8cRvhWHx88Tg1PJGz0kqsIBBRItpM2MIpAcx0xa8lfO64R
efGNyaxEUkxQ+vbpmX5EeyEQArJV7s72bhfLotS1+7VevKluSDfH7A==
//pragma protect end_key_block
//pragma protect digest_block
MEISJ4Z91gj5srmtZNFot2XZRaA=
//pragma protect end_digest_block
//pragma protect data_block
D/+xaEJIoKsBYNjGv+i7ifFJid5Ayn7+NKz5vg6nCCov703yJRUhhOZpq8IcEsbu
YTEw3xhgqqwzWoOB60UQHM/Gl8gBBrymYkhhvK+ncR1jphBM1bpcFRCwvW+1MW3Y
uwL/lFjkpQL+ZN3svhX71qt6EkSG+oI48TPrvrLvr1kbqpfsxXRLHrp0E4zsEQ/G
pf5p3BNr0mpn/KN45gLrj7X1u1vrd1JfP6QAlcNGcwxZLjqjmnH0UhN6QVxvS+ig
R8QZHSWdkFq4aoE+ux5PtAwv5L505Qafcu8sSfVnO8kV4kKlV9djkpB6ojunEdSH
HGV/+KCos6kQ/781Wll/6UJ4l+QfLQzVcKAa+E5HHPgu/A5DVYF3BxuL2FSoC34V
+K53y8z/guJHPrgnbrXWDsOFuUYam3CgTt0uz4glS7mFJkZ5R+eeXr+68Z9fwowI
T3DBIZ3yGkoB2IXAfVB1oYHC8i3776ty+H/DAdhBpqkC6CjPmgJcY92iApcSBWS9
utYUuXkeQrZS2bYS4k8GAc/9z9SNz/wXmvIEbU0NK4co/tV13lfzUu/enWxym5cO
6awyoCgxGZBwqOQFu6HG3tfU9IypHdL5DtwA6Hta+N2WONWFBCYYq7jMw9UmC1wb
QsB4vCokz1efA0t8dFN98pnAoYzHzDICGDeF2sgCfmMAOVl+/cbUqauHOdAXm0pj
14PW5N0Wl6OKg0DK9pgXUtLw7S0UtNHClbCtrz4Bads=
//pragma protect end_data_block
//pragma protect digest_block
n9FzdobEvsl6c8Ryvuwtb8hTnAU=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
93j/Tuq/zQRVM2wu60BhYVGz4qd3FJuQAcsuYCObYX1FuMbSWYwRNSHaIG4MNkIJ
9yVJprFiSkJKjJ6I4slk7zRoKI8X6d7Z/j1FhT3kMGwySoQ57u90Pe1OgzD7glFr
qhP4pobelM8wuD8GLMbKMn/tjawsOQI9ogiDYVr9OeRxjno3ufy1aw==
//pragma protect end_key_block
//pragma protect digest_block
k1Qs0MHvFgvIRGSEAkDxv2m3dD4=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
gGP4ip4wwtje74cE8MGrxZ9XHE4=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Rgs7lYGzF/eVLIoRkyPKlTzpQ5LXEJS9jrRTvH8tvf5pz2qfAqTcV0OFAZk9fOkI
ZqMplbwvcuIzWSupsiz1Y83VFVh8AnScuDUXd2J4HypzQM1cc/NBE9EYl5CsmI9O
nJwpgcU7X9M7o+sgyFJDgHz+Oz7qY7rHaUWuLJI9oz1EogCTLjxBGg==
//pragma protect end_key_block
//pragma protect digest_block
5/R21eLZlPF8oS88EmpBxMFWiAA=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
bElpB8YnBGcWfiexUvvEmkFJdM0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_SV
