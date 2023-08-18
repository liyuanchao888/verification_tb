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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mJSPinW2+q1rFkZrHRW3E3+Ks1io1hjvwWwC67IvfBN/MxqN7By8ehfuQywYjlJB
aRpiT7mHWgvpYj15/WIzZlfOar8mbSekathvnPgOZegREOyEd2tr6kIW8GWutXH6
/LjbgYVtZeM0aX4Qu+rxwtuFLT8YmUsenTWCJusBHfQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 594       )
cqIn3IiWvF2LYW+g2Y46y6uIoXkFPWH4XO+V1g4N4brwUts84r7F2hhRq4TytV/D
N/94I7q08bLMLZlwqj7/Yh14jH5D6JeEsr5xp9ADgig7Sf4GaoNoHV7P4rQb8FaP
SXNvV9VHR+axmAqkcC5UyifjQDobvyfQSOQDr/BdQVDk3Jh4y5f2Jo0Vzo8d9pbL
VEc3F/O+3Ub25av3h2LB9/NW4gohlW/EDdnxrCzSJJWnBAQssnYir+U7tbpYLyWC
mPf2goHcgFyV4Aztv8740rUUv2E6UUR+p9MATHZ9Rqs8MGpTIFF9Ltcys4H3WJeJ
xweB5xa+91O3x3pAOQgCinznOhA/mMmdj1YiAnyLGwBEetdN4jn39YrNyCS2g8tE
qJhqNl5O6wVMrD0aiTdpHX8OFMe14yVnK1FeQQ8rZ6pzreoTsuOWbKF0ZjXhYv/l
jUK5toZfaLItMlncsY680AG5FFTtl9SlACCaX6OXBBZ8Ks5D0q0OyQK6KLuy17sc
vhDjiHSWX2IDmjGcU1vHJLqZSliMsV/bj6TZXiLB6E3Hl61Gc8tf1q4Alm+Wm+YX
cGsRvkUHAHkXm+RO3mTFDVCqAmpbh9IiXSplb5zBpf2qy2dXdlAXE294LchH/tfv
AA+ffWQVdo2yNksH0aUDsMXTllw0EGOHqSEcTqSPxwBkOKchQ+a3Z6zTuX4nTqSl
suXJu/wq4c2dtL3LkE6EHRzTMCO9UYP/XN6BroPgfn/5bcNdZdeytJ4m5cvkUq5S
W/3bmp+ZdDUc+FwlSwRo1AlleSyRKn570fFY3j2e3CY=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CTDGBmP3CBgU6LUGMWezCtJMwrNsoYM640q1+KMILLGsF8e8BclEkmyZNE319qHg
ga5EnULNlYcglJUrBMgv3EC/AAuqNAXwMRVYQmco45Aj+NwFR7x95DLxSCxTV+Nq
7rDP43SBU3RUOHqZ9AdPLnzjNjdHwvlHzsI4xvTT85g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 968       )
Oc2PIJu73oqRXKh60zYEtjEQSE+e6PufpYq/Q25+FopZZCV5naTzhe+4AkpIFpM7
uSGow0RI1wcOOlye0XC2soYfIkkxz7rUItsx1OWxlNKa+MWbUZJWCR8BSGyhOtyj
UdRU+q0dvk9VFBv2+w8OkTWpOhEAaXIrkq6R9GsilHN8wQANp1b+xeBtuPJgLYn+
tIwqryJh44GM0PGkI9GFQpXKVK1WZbBukhAjzPWEn5p3SbPHGXvuhH4r2tCF7c4P
5nBOVfq5O/NZV10b2jKAKiO1k9JkqI7KD0vfKZtQUvtGtm0N5ZvpPmY8QbNX3IJj
sQpVIygus3FYkR/OqfMeqxKLDEMIAjscCvdEDzlIHk8+UemwgCSg/zBAAGHFrHvh
Ccs9dvcOJ8tK6CYrPPVhNdCt//UQVjt8lg6EBCHgWfL9Oayn0cynHfhAQXUDD5Pg
vycGNasgNtFrA5Be98NiO3Ct9PjS98P9jB0DGzTV6n1T4t6P3zogeqlQOgGhJo9S
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Vdhm9mvgCnQ+fs/N0+tZsCurf1Twypr5rSGQqDmp6oMQZ1+xpVD9xXjcoYpK27aL
Nfg7V87GHnl+mCIstfLRBM90alkWpEmtCXb7hxc+cHnMVckYIHIF4R+qIkhvz6ql
P6AQfN7gBfSmeet6FI7qRiFoERwNsjS01xtNJFgzKYg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2903      )
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
85hPPcTuA+6VOT2nwQpwxw==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VP1pnOQ3kB2Wgg169j1k0DTeSozElIb+mYvcI2kAi7LgwzZV8LUe0NmOMJe2xF0W
XbPc78P7Pa+mkhAaaZ/M0wXxaFVPQy1FaxhP9uBWdeIAtQdyWSxwpux5RYv47ce2
HB3eHFjWJbD0+2W0P7bUeyZ078qs0rVT2NzU0neZGDE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12767     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hd/JoASUyj6nDLgaA6S7D81RwB9J0Hqq0PjtKvOETkttgCI6L5RYj+P/tSWtpFHp
H9noKTemblk3s+QHlYzUbpYJaUX+9xTa2nvOvLjlrXQlJf+lYvCoWrblTi3tXfIq
cKDGJuiXsvsf66rcTQqIwwNKCF/xohL2Y8jsEErtW6I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12850     )
NET1+lK0MNdAgee/Mwt6m5JnUz4ZhkOUvxXV5hA0MK5glWIXaNnccDG51Lke3130
1jD9dOzSZf7ARUnXXkkON/kHYEk9BADW0k8Lt+P0zuGXhvSUgjZaETdSbZsaxnlP
`pragma protect end_protected
