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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
P3oWbPjXkh+srrf97trCdUbxbyNDNonk7b5bbbKywJPt16rBSqat6//lQyfLAnPC
SxeM0RHxsMO21uxMYW44uTHBVbFxnrSpVz49XK6Goj09E8CB5yQTsI5bMK4rtc9F
cDt2zbw1wNhPSMK2+7QnrPNXg54Y1ceMDh+hvCUB3Hk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 646       )
NNc0Ijd9z8SrVrkjO4wfHhZd6ajVhhLdfNUfBD5m6ToAO+/oAdJDB1v5YtwLn/+W
DiUKOxe387lto+IZdUUv6R87CKxwJy3iRMaVwZShxHTp8rDeIwMp4kRhXIu4Eizo
rMzVwexGHHwGg8oAIlBOhyScTwHLxsyFvo1zsNHCQOehLfo61vq75NVkEoke1WE+
mnc/JPKqw/DWfpXWk0ogGkyuC8g9UPU6Sn3Zk0W2zdb+rfhBrGJJdk3+zgO7qyov
nAtTWhX70a4BHwHBlv13c1xhMYR5cvKQvTA/HGfXtR56PJ5sIcVobJH9KAHShIfQ
Owyl2vA+RhRl+CSe6xrOxm43M+jXjBLM46WovYmfZuXJEIzkwycBw05ME4BZt2Sc
Y3DzJyWqY+zclwvEqtg3yzdLY9DtXxkpt5TGz343L8DCi2MyVZU9vPkmEqJk29gJ
ngORPLq1KtPofLsHPf4ATGdlzH7JTs9HbzVOAvjXIWsmLM2YvxR/yj2JgSt/5ogG
W9XbJ1UUlRVQ5z5tyhLM6/62awO4jbaiHiHxFQ06Xe5hcUwjJUj7HYH8jE5OmbRP
Hq8i86KkGAxUw7kQkO6qi6rNDlBmwa484cGIBvw64/AgPdGD7Njb1U/lkthXvcUq
6X5+jKTRlE6ZT08i7smI4cBl5U7BcDSAbJXKe8elNHlIeMLtA/jE+VTbs5sSMIRe
Vc+fUgBJDEdmNUIFVRkef+Id6/fM8+gclZArlFixYYrFEUb2RZjxjDjlcQluU1uw
DrJwOxZAdZsHwhtyjakKrTSaIHSX25yZs8vYLeBZoYMz8ccMVOLAgeYH0GDZvF3w
ouGK1xuAw6iZN+R2127fHKu6qtkiZoQ94Cr4/Hvl97k=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
W7N+9bxDZ9x/m4d6o/k+hE9rwYR+axnn7OcS+QHQ3DxADwR0pYYtdxYLRW8/w4sw
2e0uPTBQZEKE4+HE/viipS3ZXf9txxQrBMUzQSXO54D1Im2NRxPMRgbz5hmOsDdm
ZDyvwQD2ZKnmjg9BhHpHlPRJQ/YZJqqmKpc3YlCBuAk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1033      )
lVtB8FXgl+n/BNPvABNHwTAvX1yJ15PtHyZ3Zq6HAxrK+WVy9QIkHQ6qsIOM9kG0
JSJe8mVtyo4irmPLyxnLM1UWebynG4+isjQf88tEGZOK7LOQRu1aY2kMZ9u84KtJ
kHKROAmH4E7fYkOzWsh0D8xGCOWfKb/Q9PP1cEOpyLdESCW4xN9nujKQaqWj+zEG
iXekZd1GxhyCnkzaSaYO+OGxx6afLFBAmEnOUq3ntu3qlw5EBIJK5LkRLdUX2/aX
kNbFGAWhwdNl7isVr4kYOPxWAUXSHS300mBSe4ff60HpdjxE9U0Mb/Bwc58hCYUY
g6/Alq8FFFCxdqPVg3XdnNLrwNtKT6GDCC3yaihQCrJm4Qqzfs1g+NKcOCoj8KBl
m8/n7+CG39u9+JyMAg9bKXZ88BweuuGyeod1M36vG4G/TVozmTxHL+hUrPnEMH1/
5W1mYN2g4Nau9oorMCMat08B0mLrbOWYApbIp51L89EN6nIH61IwzDw0JCILIDpW
uFU1lBE13AubLgmMslzQ2w==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gn7B8DgmhHOAzXtd3oAsLHioC4yPKiDlrFhlXedeidvxK6eTS1e+lVXzuQ45Vnx5
YfqKdbSFm8iz6JguGLJ6a75sLj2EFQ6DOI5QXhqk0suEuJ15TVlJ4SjfFc+dCZO0
K0ZEkAlMBbFJ7c2e4QJsdw+pInmzWGFy/FMQ1qChG+g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2968      )
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
R06Q5jQPDoI7SLlK4OecCw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cdN+6vOkPpjrLwmEl1bUPWG+Or78id+DqN57+Kljkxw23oVBurjIW4MKPf6cKOAZ
+8+k6xB2voMxNTLSDnaKQjH1Wy15b8hdYTfZLbL6xi2rhLL+GrBDLVuUCD4P9BfP
0x+G/RwElGeUmpEtxWMzP7dPOKwo4+Dmy0EwR2JWEJU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13106     )
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
MbkZchjyCvpXkqaryY6uzg==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jCXCEAH1sU6rzY7Y0DmL2Z4IKaHMWnCDbAp2jiKXk3NGN1QXP/Ll0d8b5/gIRQUm
TKtdT/p3B0KqfeMpNrlODg9BSprw7PKVC35xd76HnPKN9gUPUL48JLn3qp8q2t7+
/LCfbeQ2cAJ9YYgylAJ5Un09kFVigVzgWj+Z9y5cXkQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13189     )
XfH4OXanlB3sqpO/P+RXUnOjRVazEPCJ4pqgOALsXA95zpGI3vc9tmYJtKkoI87q
aagtNsK2T1HDt7R47nNJcTeokV/9Dtty41/cWfvtUIZuvIQafIqMOKMuvtbm+FNZ
`pragma protect end_protected
