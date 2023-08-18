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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_sn_transaction;
 /** 
  * AMBA CHI SN Transaction Exception
 */
// =============================================================================

class svt_chi_sn_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_sn_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_sn_transaction_exception)
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
  extern function new(string name = "svt_chi_sn_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_sn_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_sn_transaction_exception)



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
   * Allocates a new object of type svt_chi_sn_transaction_exception.
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
  `vmm_typename(svt_chi_sn_transaction_exception)
  `vmm_class_factory(svt_chi_sn_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TfO64wYLqYbzU2v935ql8SXZRmrRzxbGcpvPOsEPSJ+hJcJmgQfJUXBZnT49bAPg
ADrfLqv/vqHIUeh+Z3dCye2DLT4Tcgb1Oo/iY/VxYO+mYjHdb04MMq1gEwwaMubL
PErA6gOcogiheH5z43lVCiWFry6SDPOrwf41oeQGc44=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
uYmeSF9a/BVahEDddys59vG/n7Yb1Rfk9z/IHPkHw/mlswSTfdzPf+5tAQlMC1CQ
BcvcoglZdhA34yUfUkHOkMANDkYW/7UJFqOIxWGOX0Ruh+pXdHYJsH7m78dI2HMv
+YdMIQYkynDeycraCRykpaCsXDUfRAJ77+Jjy+TI3xSCdCuWMo3zWO35hy2PfA0g
toOo/lI8pHTFAddtZ/lvbv/Tjj7L26XtxQG6pct/LwKS/jyvqfZHFHEbF5jfZzkQ
bOaw3tBTYQRgI7Wtx6lD1osbob9ZjivSgDs2yoXsmiqn9plmQCUvnb3lhZj9iwa9
pqOQ/fxrk9qviGsICMeF5TTJj2cSjzF2eJHTKFOrY43Rf6E9i6ktELTjZT/vPQTe
3steE3TnLxwLFm7rZ0y1IvB/qDQMXTwGPw64Y5qnKxu1YERsDfFjQs63vDdjUwQn
Kmw1DuYqPoK//iBUfh6HBuHCN7+Isl6Mdr9ZJpXqP5SmzQ8iQ3qanL0ky5TOwlNF
D200dDmYloMuaVwsEdFOyrkKTGOeDWa3v4tA0eybtLFcT19la+iVkjO0GJkO3rWm
FnRiaR5PJ2Xrpe2KGHIucyp2z4l9u2liR9uS7dVtoDltKIhynUvdWvWyj8o0eN9k
JBY6rc31nJ5ko5KlKwEfVKg7Q5Ycutpbtk6Uc02CW/LLTcPbkyxgGpqsfhLHMUo8
30c0UiOrGe+pNvayf/EBS42WE2LTEe/j7v06czSQms4ZFm80neQF5yVVbFpMqoWt
XPzzVveCZQA/tZLttyer8lYEsJmlyWhb2Cs+v5mDtxliEmjmvanNuB66yhWlpbBc
dZt8PpyZAZfl5rdMpERfmg==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IjxAB+93EZY58oS9K2x2K5D+vZAPOIbgvsAqBVQv9HRAXKBsD3y6vb9yrvQHDljv
EC6ZPg1wOealD3fR2IkPQtufguNk1ABZtTk/3mTbEz23aa4Cp5SeLey1V52uzNj4
jIAsYILyTPsR4bfLHYWv/6u5VsPKYi9drf+jjJokgRA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 925       )
xEU1cYiC4Nbgfa8IWSBF6MkQn9SfzcXgCybA+EdwGt8gqwtdN5AMT3Ck9W4SIb1A
KHEyWySnHg19TDcs+5RZlp4tl1Xv4cndgOOqplg5xjDOrsy2lv+n6XrAP4US7I/B
I8KakNjG2YzPhMQ6kQVwacI83lzyAF9ETbSAVUSQ3j9G0kP6HcUj9ol0w+WHUw4m
fdzuibOhaevJk1NVMGSG35prBPCkv1UQXGGSk3RKWaAbmBK15SJiEFIPyzmAtScj
iTzEPzPTRSNlPKKzsljqMIqfYQUappy4Jg5pEzMrMP8OzoYqNwU5gn3ugaSXQAQo
jvr2IC/qGFJ2eVOAtrEToyIvBJJvFmgOegDirxm0Wf4fOBvl9qitlj61NgoDol8A
e4IaJI6td80U+MSKoW6weA==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dAF3mI2SqfDCJ5XV2rQw4U/dKXn7xK11medo+vqq7NETTn7uCowVwyZLsVs8kakh
NnPsLWNyF3AGWAlVgt/k/4LOpsSDKZKO0lSdshXwWUCOTZfLRv7GsMj3MY+6uOFX
S0NHV1Wek/LjUyfXQA9vfLFm7eKll5vb4jxONyYH6c8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2953      )
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
W/73Rt6GiyJNJcAWmVH4TA==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ze4HYqkQYLSJ3TC34SCMKoJ37bTEtMJUohSklVN1hsHd21WhZ5dEwloRjoMRs+9W
5aUDDC2tEIKhkA4ZTSMLwDUBn1eLwl75pi/qyJeMa4hivV8x6l6yL4tNfpbZLt31
qfgJA7ET7U44vFRoQto0OxNJ6jk9NfRWwVAHe9T5NDA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13027     )
TzzecKkZzRiNv00JrCsSRfw7T2XOCtUQDynxAtIfPi0RQLfKZav/cWQN3PFru3AF
3Lp2uKd5iTuGljjhWm96QA1fa6Sf4L54KSVpyR2Bx0Bc8jh+zGyCJyb8AUsTiVd9
jK3e7qraCVTA6xADPj/2KWwv3Ai76o/6GKvS6TZE6wI3cBZye5t69wRkKDESjAAt
nC7/a4/XGsY4S+AZzQPmWrGerh+TLpENPVENrgDBJucCaRptCJX69WwLRHxzvmMO
KGI8UeNclEUbvjEHRkESujs1OIdO6Q+f5MnxN6hYjq71g1Eaewmt1cKZOBE5DPyE
y9Lcd/9s08kvYTchQc2NX83l9UMtmfDWx8ZNxx1FjKzq1H6MhRB8LrijUvfFO2uy
fnKfvVYyCWiOVbmdMNfmUCurg28o8aVpvpr01IXHy71QoYrDQOYyHoRxUtBbxEPv
5LNkpGx8k3fMTJvyzldpnOcVbiBzM983PMyy8hO9filJHnrRRYZezwQJPGqdlxjj
+r8Z4QMt5siJiPEVk+nk8ne8GrNFI8zrKJ6xXNfXonaX4VgDitu/OshkGlJj3sPB
vEeZ5xauJy1shGBdmOVHpoQICPr5uxatVfMaHwyvI3u3K2GfzN3WKd9wLNaL/y15
LSoysDOAEklkOFJps3nSjHii5SXonANzInClY9l8UVLAKKnoohTVp3rHCngjD+69
vlYCdwto1hVPwi7rlnjZVlp0c96/RLy2FySX1dMSsMf0RG/YxfSeE078KTKiuY8t
3p1ErBbFsVg/L3/QHBpP66dLtlHgGv4cZZEOtJjHwQvPtC5eY88B1452IvVF/ZGe
o4fXqnQrBz0q1wBmzfZM3RraT1Ov3/sxr7OgSzeOKV/gJW/pyYnG5zp6pT5y8Tda
joeH4IwJgIBehhIbBmRRtOSq3Ei/cFKYLkFAcKeEwufYThBssODR5b5NNctB7EbQ
vkVOx6LU2ahpombOD8VF4cbJ/D/ZDty5HTIwEHpUbywMTcD/hAmKJhXJKG6mXOfm
xseuYwmKJC6+apq9hNKC12zPLLy71OQWyWqtzweAWhtDCb8X8LkA5iycCi0tq+sE
34vETdpeovrPs5rCmDjEeWF55uu1XwsNeBwhP6YmjXoZCbrgqeGLa0HpJzdG9587
jYTwnhp2pxSr4z4ujm7zTc6cI5nWrylfAN60F1L+ZhU93wi7tgHw0/d4i6U/FQda
kqyUDlOgMWSXzl+VJ7xEl2zTU5enwz7SIKKb21/PEEi367wmtllJkkrcvtrzyfe8
CwHPoIfGhQVMRb7RELEgGyTDDurzbbceRgHtUAgmJ8ocse4FPVULFhA9NG5w3aKN
D5tKBozgL+MWvRc+lBXFrzLkklrObxs77tC0DBavcFRzWP8d0PDUK/W7+nJ5W2LO
K9ylCvvKCxxYJNfAunPselZ4xuqBidHjh2DaUZbgyzOrjjrLoobk9+snB9BsUtmE
lVTFsKH7VTYaulfeY3nnHB7LWKB2Nc04RI+/Hnhca1o1NPFZuKiM6zsbQ/XBvEu4
qgUbAv/MMnLsSNYGHukHVpkkgjzuI1CkFysqr1GObMhTK6T3jmVJADRoduBs98iV
A3/YJ5EfjUq+cnueov/AwOP2AygIhFwiXXvSERPozN8+0ikyf78B3Zi7JF1cChac
uoYp+J54zHdD65fWnwzkj+dqNazma4KqXoicVBvGdSaw9IukKJtJPjAADlRJ0ajy
64FwZGemlzETY8wN1cXRyl3JSqm+aOIiiWzlyzj+rEawfMyTa8X06zfLYxaacxKQ
nXGtjqXMvcEoRtYJHg82eBmknbCuKwjGJGwJ9oNyGnDUvgpUdpw+iWI63A2s+UKN
AUG7pb3Zm4di0qVrcMkrK4zXp7lIi7wvQCOXWVIxSCjHJxfME9n5ujwhWmnqviqx
zRPes9vPV91Eiv58YjMsLvFm97ovhi2AUDk969kmSoqc+hhJFfSIwfmkdcgVc1V4
EbHPOhnx9ido/qdpo37sZON41DmTLWT44o9C5hBP/qH2jxI4S4Zf9j+0N2lAbNyM
fqNUzK4A3+kOAqbJSTJ+xbeHHKZXwRXvJkk2QNzxdhl2RMLQC7sAE/agD+zRNk2P
orf0U4mPwG+NvUJaLm39yS8LzadsxedxdQOaPF2oH7NGp5pNIl9Z7UTew0/2iqYo
FfYfQKLsudkqlVmJEvOThrizPZyO+ksjf59ZoeuVZwDFoAgNBfs8LtZTyHLl7dHN
44ZwAerKZai8qSJozi/OXC2/Ovugs15Y0J2RM+Bs+y++QHOytsupEP5Pyumw4YiL
O5WaxW+HGzmdDTeWc84Bv5vml/nxA3T5t3I0dsvfIeYQtIvNx3W2a9DFE4yBkBkl
LvBsNaa2CRttKkG0rTgqogWj/axrCFG+Q+mZt18rJYOZNSOAhcJpx1obh6o9ygoK
BHA3mRSQPjWOjDrnN5ijomgHvur1pjxCsgB1P00Xy8Zq2WzHQgKbHBNuAA1A4CT7
ZV0l0yVBUMnQaMWOOi2ZBI0023PzgPEMrG2ucBJp6hLXxGOd7hjh5/zJyj0pz+z3
9p5TGk+eGc1IBnydB6MkmXLV+3fzr5myFKWYoinb624VLxqAkl27hkhvcEr2KMMN
ayPEp485I9q38HTN3LBkc6J3pFGjJJzbx52QDRukMOHRzCq9pm0jXkN5ImpDhi+8
ksLm4BQgSrNHDEI81D8Sktm5Hv2Nmqp01vScRuIjK5L00jSkyLDJ+5J8VVKpyDmj
WCpcMlktU34BKC9hF9PTlkecmccQ+aTiq7+XG0qlwkkC/MeVP3cR+KWiWSSfc6jb
QP9XMo5dlSZz2BsZ1bfgpRynrQ4RwQ7at7+Wc0Ai3yJHF4cVBhlQY8a1HPq0qkfT
aNgyy7MG3p6+xa7U7wGKqhaugbgpjdyaeZcb+PvK8/f6xXjDPtDPxaq7FCUAACD+
3EbYt8wMQ52HXfjIox/MlndYB8yc0Wo0bSR5odCqfkBCCmdlUR/0kPDYLlGksLWn
mibTMzEDmUh8tUnDNAauTx6KcM0tp2PVVBpM78M689/WStXA4AT0atLnvB93kWsF
O4mcdTRCQUWQpkjrc96ioZcg+ptOZJFysLqWCzJREBQHBlciJsGGZm3ZzSj0IlTg
ff2+YqtCXH1DZo59Gbw97MmSEYXVESO/tBSDN/iHp4gLjaHD82NIB/w0jQ7Fxhd9
oL/FUdpSuWSnZWUOayG9F+bSs/xs9vAxsUVv5GS8gryt/Tqs2KvKFGY6vVQHSy2V
4LWxS1FOZjdkmM7WUmnL0xuwyVdDE2vo6eL38mD7bY4yOEVT4PW+H4ngp0RLxjSX
WhSvGj+yvsvbLN3+9fYkcRA3tbz7qbb0XgZSvMnCvC3UbY/Zdk2MCHgHzDKNy9sQ
cFW2MmV+fJZ1GHCHz8jt/aYYrtlIetM4Sd8cSAOrDu8fnJtvi04m7H/hkk4XNG3P
+VV/zczjVSZxmnCilptBhsFwd3XJfGoHJ6H3zkj3tCtQLuGCoNtRK70lhi/rvwtn
MKbenoC1RTui3NRlDg3GolnrUDiyr4LIUJRnx+w4eO8bEFCXLIDk6QScM4CQcFHa
1ATBEb7NXgqChHJ1jmK29ZbLxM8QgTd3O5N+/hHFxRqA+YDwqvfFTRKlzVlMlFd9
bovutjPMlUEKyKcZh3ZI4hl3EoKbnUH2LnwM8IhzIcO6FszJHRMdmflWZQFosHmw
GF56EjJGLX11XhTjfEIaFrB6WeQunD1sLmGLYamrdKmcF0wGbMy5XLWnNeOVdc/Z
yV61Xb/cGOGQiiUL3UwoD9gImJIJNQBM1Mh0thavu7dEmym7XPlD5gVhQuAmFiy2
xBpY3yQI1qm7J3Af8xCsxrpUEufJ6FXbXfofyiCX2RwACTEB+AsdWyGBmYi0RTt+
lQk2jqPPrCVpIIX00HZ4j4+sf5vR+Mpc47kHbGeRrx2NbE3i4UjiDkyHKKpzAT5D
Cwzn4cI9NYKAxp2kpnznQTEJhB0oSjo5IEAM7McTxiJrPfyyTwrBc+91Y4jPihnx
yz8fkY+wi6Gh6bSXMmTdSwqEISVjlRUJBvnjT/tW+4NjPwObqOO6A+zU5i4L5Ahh
U4DnqgS98OnLdhDrHOgw4x9vgkj6zkD10nkIqVfnwx/XshkmPnpIEjVnbP0Utwcl
zMKJYpyAylfjIrNdMGhQE6ibH7ITPfQ05IESIzFMcFBtt/UvL29g184GhEahi0r3
XELwSRX/b977xY3Dt9WDdx+ccZ+O4zFcvkW7nVC1icKzXFZxQmqGBJUNn599mfoG
HiJul7Ja2jUc0J8g3CpVqkFGzs8zVGCl5jGqmL4zcLy3q7hxgFTOu1Rvc0q/pHRJ
CRhrhyB+00IGQrHWyKYTkRSdJf4f9UhBhIpU5eZRjcfQCOhqSMtwmjP5+mLFB7/T
EMSD/n+ZxR4KaeNvomtqn1QooiQ2jv84O1SfrJ1aBxFhzcGChVTn8BxrnM5lkuoq
yztM14AztcRUOj5ah393I0a9LCfb7PqS5//Deah09vZzrnWTPS5v2vnwmsUf0isQ
z3+dO3EPHvlPTQVAIR60QDWg1jnScpBkQq1YDeeBRYK0Un6KnFDZ1VI0QuyIQ2Ao
+996aYr90enDgcCz9lothoeJ1/0pUNrrz5KhMaoeklOQrJ6bkaLYVwZhgAhT8JKg
+43C3q2+Ip5/41m+sQJFyPuiaKhLpUd4mXUPKNuaTAh9xEYz9a8DpHJAkvFY+DXt
r2JZengSXuzBSH0lVpkVBNt/KiPa/6FsFzZv6uk/zJK3D5MjGYcBlY2BBhJxeVIj
BWXIDSLa2WphS6dfL4HTALEKMgeF27OcfnAhRkqR5sX5asmy9plUHBsU8Q4xrNxn
c9Vxc9kD0VbMcWGTyNwdjv3k5FX8kAL6p0RGedJl0idS32rBBAOJf/h5qN4z+c21
xN8BsS1sqy3mKhHiKjSmkkhg0xDUYuoxt7fZPKmMU7GuJy8SYzpedP/5o3V2M5J3
1bQRoNT412TQBrCLKP3vdm1SI6quySHMapE2CPlFfFlpYVgONHywz9cBZN+Z21GC
4Uruf1a0Vk5QnJRsPJCnyVpPniaUCylewj53GcISY4P1M/ELORGipjz/OgNCUKfa
3bhu7lglJrjxDiRzE4A6SY06+q/pqJNc7ePa97efwX9On9eKd5PqfkEX2bvtvgE3
pWotndzUn7JdC/4KA5LtICpZ95Z3DgFVVu/ZSrJzzwjvjpZldJhqjgrsHjlLi9Np
+wM6OWrKxME/7Dk+1bjS18YGIXNp9ibJlE92Mc93WDalb5e85/Ki5UR/+XDvrEwn
AU9Wlrp8eUIA/MLmCmwM2ruNMKvIgbby/dZIRLfGxxPkSbT5ZAXsHyn642nCya/d
3QbJ+gAa/ApBO1WsWjVuSXOrbJ1uvvjTTDFt/g+iCrbUrXY+ZdVDF8bxGmJxl+Yu
vi4uaJQHOMwszMS9V4sQold3HYPBEApAhXTPynZH0RJzxfPEqqecvW66C7kzLDfe
UtvFs8ZdtR/YW/CyJYv686nEFcgT3Paa+UOMb5pi9L4ddgyHrMH6rG/gIEUjjIKY
KaaZkxv6EJ0JBa0BI+opQfzABq+ycu5KmnOJONpIAWGevJXvHQ2RwcrDqHxA/4/0
bNfMI2f5JGk855xvsBTAQla9tUH8zsSckYxxp3E0TWz/rxV8CtdxVwR10DajXQqH
DqZnPqOUqjFTvvfUzGUlccF+fqJUOMhSEcQBwrSjGRBpmQdf+qhYbRPFnVFHgNwm
k8Ti31RERYQFXn+j23C4g628258ymoa6XyGBKUMcp4YlAlFHL5XiX31TQAW7FK/0
9jbJab7hH9NGktgqiQxIIPt+RFvm7McrzND/yVd34KBkw/FNbmtLEw0f0xkNMT/3
flR80X2eZstl3yCUufnu9YJ4/aDC7YQ7xBFSyqLfbl9CFL1NHqcs3Po77WO4pOnL
gON9eavQEwb6XSWxZ3gRf/RhArZuH3ZMMojfRz4jVoJy7i/48z6D1POTmRLvOTz5
SQQ9UoxgQHup4SSyp4KdyqNEoTmTwxFqx1Q80UhetU3N75t02J3H99yedlloM0Ux
f6wgHNz5p93dHktDPHBRsvl24xGP2oW9VOuTKC7yBDT+vkAyqvY/e921xIJ7tDdn
j3GLgUDdhK+muFGR/lOaWXcLgOIk3Nqaxp3v4ZP1iESjftL8cTO+KCHYIHJ5/fQ8
jSK6Nqji+ZGghod/uz41xk8viIx4eJPikqiZdB9rLgv1pru6aJXXaWAc9BRPdB7W
lywa7osEqFaeeHBkhXK43Ktnfkg+lfL9syxuwi51YsL0OgM0/ySyrqXW7BcBMuzr
/lT2c0bgp36/Iz6xWlz3VZ66wgzEy4EjoVJMk+9FzQLGodn90Z7zRHnD59uwTLhO
pNysFzXrJrDCMcVm5w95zq0wpNBem/2xB3rrnm/ybAnKKFzsMlb8P2viglOI3biC
7oSHP/BHTnQq1JH6MbaqNdDQ5g6f+6ITCRufFDasDUDqNScVD+f2CWtaDZpUClRv
PyeZ0BTYNtpHi5/r537j0RIcsA4FfP4e/YYcW5rUroZXEfE3do9VHWUDgfoXHFFS
rBiTTNnxJHPQSoi5H7aQ1easAe/xE1SY2953zO9dlkipANnau+fFWv03eYCXb753
bk81TDgI61wFH8xdbYQXnpgL24qw5wGV28BNaVqV9V1dpC3S3YgoU1kBQ6U9U3XY
g1QW7aYlKXuq7NPfq3MlzVt8duzIOr4scDTn/qEcT7/q46d3FJKNXax641cA7tp8
RnoXSbHA73LKOtEWqQ7W7wagvZfulaKp0Z/WH2KjnddszgVJL/EQooMSLX3HaP+K
tn5hkX3COa7m9bB18MZfb1nb4+BQZrFhGuRqv0JN+hT6Dt46fYP39kllg/1LPbNv
vftSKnm6piZUfR8sE3VrZkk7+bgQeWl9IwEE0/HYaOyfKt32nzfkLLI1SFbM0VV8
A3vXmjYmYjukU8M88QGQHUmqZMQ4ow+Jzb98QuoVl4OZ+q9jtbUDOAAVmL3fG9OU
uvlwvmbvQ0gmgFiWZSj6kxgIt2RiwzhjS/UNZG1g43n5V6RskAbHk2JNE+XhGpEp
aU3is6Gr0Qrtdd2esu/f6Jg4PhEL4UPnMXiaRVzJK+bLKgc15LxwnCWUCJFrjnjW
f3CG6TKfiW5Ix9w05NmDstb3ta3iAB/UfV9wEzdkttXylTMur7znlC9/6t3wAZeN
SetW1rrrBXTwnS44gSV8CLpkHcSyVPEuJrQSQO0j55y4Lc/l64H3Atr0NtX4cb5A
UL62A9gs240fv8k/od9cLPoMnxoXdOIU9zBX4WllfKl/3hQYxDRZ6dvVOZddx0Zh
0NU1VeBUyjaIRxtFIJ/RmLTFSkY6f1ZRWXM7BN2SbdD2zMOdE5EcqoA52T2E26cQ
9n4SlVqck/0Jpc8dV8NQDytfIjjpaCB+nZcXglndTKNDShBttq8dponD+6o1GUxq
sDcKDu5Y1iqcrx6Rhd5ptZ/Fq3AIubysWD4TmHo9xhUy3IQZhVJcwv9PIGwjrkCs
ggzQpYEcu4zr+JnrG0IgXZVjxVjK8+mNaETtFQ1mRotVSwHappaAGrjJojBFsORh
oBCXgTlAxZaxFjnjebyuKPMsn1SAfECwXB8zlLw0VckLv+SU8jk9BxLNDO/UQJ3l
WNk+PzTVai0JxhMwzWgCGA15XadHJQazl3vRt034kWzihZGesVDOXM+4t6XhtKf1
gIJYFtIFLeuoAoIVtEBo+B4dpffVffEq05wUG1xi/sNjnwiWYL+MEj6/s4qkJpjz
Fb7MyC9E79QNAXtkkEgPaXmWYJVSMOiVw7g2rhRos6/BJ6Urm4yodRtgt9dBHjrD
WlP8jAte3rS1BQn5LF3SkuRvEZV4vgwgaew6yY2p97wrxIsRI+kTslRp1plmuoIt
GyT8XGNvOdYSlNAaM9VsfZmP9oA2LFexJwn2Uy2ubn0agPYc6j0eHfASLbM3T8qP
hFlsLgQ7VfYekHUc0qDQVGnU89Q8llvxgzp/PdUJI9IlsWrTRqVsTFF98rlrrvlG
DLa8v5i6yHC+nGicJAi2ytgIBnDHCSRHfDpq2IvyjOm1jC5Q6NsgB67r59mUIhRb
LqsuWLCeTCy2uYDNR87QbwbREHzdTUoNd0HStFN4Nd+89tvnXJIBvJQY50Vrt5vm
IQuwL4zlgiBg6nR3SqY7v/xNFkARJnYtJ+4MsKmVRTP5ZTFIE5xTrAvJV7P+dDK/
L2EelPs4xpL/SKKmCmbIiSowIyTyNZIKrimO6qqLQVmcmWD/Sj7HieWJHIXDeox0
jquzQWWzNRSNloSuEiYC2ujoFey2XxXMWWHCd03SFrhun77CDyN5UWAt7Qw0G/hN
igkEBFVC8Jy5CR8tmmZrEQeEPkBXriAn5bxyAHRUlgbXLnE5nQwZIuXPD4+5uumH
gA6gld+2ZiczQdnfSiZDFnfcRk7e6s/U+eQCcNGwUq7n0/CpFkSTih2qPGtIrO6m
v0FocM5G/GfssNJhdj+JX8jjlL1+k2fLz2Fxp9TLqrbTwcHXW8lx3AfXQF3dsxry
j3yVUX15iGYCxbgGP7GMvxnlwU+n/sRE5UUlcjwAsBH5gzkvQtZrtsdBfCMb5ejb
/BTp+ihtXagZi0GiWyjijyJSKjs3l8r5h20waZeKX4PdPJ9CwVdw5ABJjWjEr3gj
R5CaOlhK6lzkSLNMYjsRdK4SSuXKNwUmDUh2ojU1sz2YqKmi2gS8eDI3D7Cp3qW8
jkYhNelV3Q4/oESDTKeFGEi/bbypiDeSBmv3dJoF2ntnHo8g6cKAV6QFEgHyJ3wY
IuKuivM5LhP/goFJYI8nhqCrzCKaQpTCtVMVm0n+6UCTmwRCzfRXB3UeKzX7FkXI
PH2zI/dqgxRUyzxAWrnFob2HMoSB7eJ2izKljpmr1xhOpxaQDLi9Rh4iIvi30pCA
hUg3hulw4vk5lur0G/Kjv4eshAhmSMVCGoR6D60ME2hYjsp8EpFmQ8/EZ/ts7VcT
nxwyaHVTxV1kyZHomEF8/rWH3u2a9KrTLBpYGYlvi0whUTCnyPWFNZNH0cIAZie0
TvHjn2B3O/RrVGIPmtf1Z86v4q1vA1b0TjaXnDh8TBNY7TbDm5aZTdc1rZTSYqZE
a7rAo3YIzBQYxDTo1g8HM9Tw/EbPKCtOw/krmOT2TFYSqXmqNbFh1111O97lITvg
22iBX+4N1Fz2JawjaCanGAa3tbaWLLLbJtV4dlPOy+9153LrJFV9Eaqc1sNBOCnG
IyqcTW/3QHtKyaIpzDq8D+2spjXXCHqTZvxAkqSHnF5GaY7yJUDpGDV7GhWSy8gG
M0NCSVMLSr4vn6AIwzIBYhjMV7R0v2MHkO1+tVgKLsi6qIS1I7E9UdSFFGdMJ+is
IHrHYulTQRNF6uOGs+zvnrZbyXXhjayo7avv4uCUAD3Xudu9pD/9XJf87QUcZqDV
MlxwwM1OY/fFUAPoIoLbLx4jcdWtzKztMf+PoNaCxVKwBdOk/yUJwB6yKx2kx/wD
L/XE+EYNd5JRaSzHSzUNIgiLl4dcOaGWnBeHdmLgEwnR64R1mGDugezM0jb8bEt1
ydSlHSgiwS/579uvt5uSPEl2aQohfVg4/yatJ3wXiFf+Q+6mR76R2spkO3Hl1cAg
4povDmS5Iy9CgXZRajUwUOavBC8z2zhlVcqqWiYYjYJxMw8JFuq+9dY3L9STktBr
LlCyDY0WF4geQW+YY/v6X/HyaZlduUPFR1tR5fxWGpMTaPFxmzwONAUasTKi/uVy
h6LRTAl32hjDQN9kdPNxlufHEqje2YEDDM2xx3k/02rR3DlWRB9Onwuli5d/DZVF
R/75WBcXltITmh/eUFHYGpB8DdUkrQZs+GpAahst6SNM++rGXT+ooUq94SPer1fm
+h0EgFe7n5RBIt8QGsBWfiuBN6m62cGQcTFWPuWH9nHHVmxyIb+t+KaC1Ut6GBEx
3vhURqpezthnaiJxhJDPNvLugJ4hKbK/KZ0mOfEqmKnDNi30fe1JwM4ZlQxSY2Q8
WJK0iPogZWpeTWoMxpRXb+T2gTTYxZk50UcybGbZ21QX2/taosppoLVgUHCIBXQA
QtL9t4KlbFXAhiVB84LaBPXEleIqIgO81T6Kujmd52kZf71KjxXAcJYrQQ6/P82j
cOgleYbNeBQ2cEwNlEGepxmkOiYPsdUrVAHR3Ip/ewlBGPlLNFdpr1YLsPLjgtR3
36p/OsUKG4eNWWYguss037RXdt3ElKao0TxeeaJV9j2wo3AtJOJzWeXe7CNkFZei
VWQ+YxGQfX8pXJAoykKf9wN+ZRF4tCEkemotBl8cYCha1vFGikhD48/EHgt5iRMC
5H0jbjt19Gd6mgDykYqGZPrBpKU5d6EHu4QGRqeZu+Wcg4zZn+QEotATAZp9QS34
4Ul0f476E1Dm/oYKJuOhwSZO73pJa9WX7hevlR4REtk/F9bUTukvUHytJE9JAHxC
+HpIV9lT4c5e4f2te9g2JP/Ok2FEiVp7DyFzrwiqWp487TrZNqBWFJoR47O/6Pb/
iNPg68T/5YDd2Q+nMsyxRZRMTvA/g6oXL8rxo+MkJ89sgSDUmWVDFIU8+tRU8kev
XCTtA6mwyPEaaSruJDXlJdyAbkxvZmkPYdUxKPfC9GkN1EbPrtyaZb9Xxvfihned
cJ4CY45QwyVe7NIbeRb6ZsYq0r5V9oTvTgUziROCOjthW1gDa58bxfeckbPyO+Ok
KRe+FZoLUMEbajymlE4Qb8BKNo0ggHAICatCUIylVi7z4eVYrejTi7olEfHBncer
ysJTpx65n0KUwCz1H4hDJWEI2ezfmCEjp88Ass7OQuKQCRoVrFkdOLChxVHuDT5U
/U1t4PB02r8Ho+ulAtfeT3ZkkdjU3eg6p6FZ+ev3xizyAyL7jdS25xsYFzWn4UeT
WlyctkJe/zpqJGFJJ/baLReBSTNKK6Flg4ZnbWETv7yptliL1mbSH2B8R79AtTlP
6IKVeZhMZzbLEX7sjTmjon8ROTNn3KcjkfVwXdUNqlLHxnlwLlcJPm6s5H2bdBya
1D/8WPA1X0pcdC62QUAoa+voDER5EtCnwxq+2vahD8zKmxu1WR9DHwptutK9NQTH
nnZgxf6MZeLjjAMN/PQZlL/5xvgTLSCCmRHwyjWAv1XZPdJDBO3k0OCLUMewV8iH
NQz2RCmgSNRrjPyTdbWRE3wlz2YAn1tYwOptl2dNkFWUZ1eSbudw35QiUZHTBDra
fiG2WR22tkeD/3fiXQzNzI/f4j8YRbfaSlC6cSynM9Znoe9Fl7JaKW39A5cyGKxg
z7iyA7V6RDFtf94wzIMbsRw6OVTo1olK8tqboEX3hXr8WUhMu8LaeT/itt7l/03O
/9f/jAb2IXajzGPyib+yrDFbVjkvYvh4aKuoCFW2Ar62rKskxvRm5sIhdFvQV4YY
cAab+d32yl4tmsVfy4nUzIPrFfdzJmagobQehEk2w1uceismVU4zv91F/bJkokTv
6ftMJqcMJKZJyyk8hc6ZIrTrORMT4+hcbs6/rx3ge8ehsNNj6AsW1efVvRoCAH1V
VS2VvD7pJo3YQn1k3T0wjcd8Ra3LPC2ojrkCX4RVskNWbuh9LGFC2Hf14owG83YE
xSj0QBw4h23GPDxTVSKK9eeYWCq8MVC4cgMeWiILK9e89Qq5qZTQs3nenYCgU7YC
fplVxkR6tudxgnUUs0PDW9INpkEWms6zu8aI7O+l7UDpZzZ4fHoQOmYowxPKOAe7
fXQqDuvm6ZnWt9M7OlBCxlxH6+7ssoqmPoIh3uWKIj6Q5wtY8hWz28NcZIKpf98M
sAFmP7MEcv4UeeWLs4n2vFF9rrE6G6DA2QNBMH+HZ0AD1mCD6cRIdDLRvVAwr5Zw
HZCskzI5QqdcbTKiV2NHcptyC9q5oFntLzcgw5ycXVS3igVtNI2cIiLZ6P/uSdt1
dANb9JNv5X6pVDjfp/mIUv4KUcFcqBAXly2HSzrglQmlg4L8fVhBgJErTxANXpYt
he4ksI7O/Akw4WPHUNNhggw7MwhLWHeTnl6bc6KvfYOt8OgtMriVtfYSiDDMkL33
SnDd4z7wcKF59wiCWkyblyLsNQJzl4M0iTSe8RB0hb6Wb07WJhiowbRy1JyroV5L
gZMcm0yX/uG8GAMAgOlfrJqZOo7Lx2ppF3JWIFXj9oT2hesSm6f5afhuVn0iHjac
CnlbLJGeYttyksj6Z3BszFh2bR11oSBgLTt/NS13WbZ/6K0AcjGEs0IhYVQroqAo
qUopaz1Qz11vRIfPUx2akipDRT+yz7+5N5/sMw8+LgxuXf/WZUOq7c7HxLtCAxrA
vv09ObTM4kIUizG1uFCRGOvpWzLQSvKt3X8yXfe5juXZ7rhDhRAGn+1OGf6xsF9G
cN/vPldIpwlyuKVdjhY+VDDY3KYIAqkSXUkddE60i5HXqH+UpoE/6PNXSsIHgssM
XxV+7DdAIhN7znx73+Me3dbxfRx5reMmREE74Z26+Xral7kCkbBb0AOAKiSfC2OU
0+y0c+jpZ7qN5v3rk0FdSX33G7e3XgRrfjZjaJa6YNHzx0fu6iQjZcS40J3bD0df
PcDwK9smczAPqH178hAo12BMszKnL11wOJz2pbHo6g+Jk1zk8wexclMdlmC4MCNN
6h1DqkG+dagAOQ65F6C3mQnxpwVZTIXXQfdVe3XhbUpoQCiiX6pahrbrNommCOzU
Bj8b8VNEY9LDMg6q2++XZ65xSe7vxNQRLRCdaI3nEfz71L9ocBg7buyUrQXNePna
4ZsGKpwd/659a1yEWfpO+KLDVEzfF6S32YOvFXu1/7hz1ek4Hw7WA2KFWlya6LCV
mww5EBTJJnPsdPa/LsVEchGEfvKb21a2UXMmJNwcyj72Ze8QvqjOzaCryN/hyexP
RaoT5edqQOUXt4LnFfwEWvw8nddc6sXer8ZbJMCvCaygWcZwBsuW8tZOUhLwh9NS
1heDJHlGfjLKc9FoXtklpElJiXs18U+HUv8ZVdTXN0AtQgvc+Rq3b2AAvJ7TWlY8
EwFsXjX7XE4S+jQbBWHdybx1Lt1Si88e26dWoTt4O64vims7GwghuSMySvJWrFop
FP1D96r9dfChPUAsxg5sYAR+2CyzmVdQAr8eUBIb39UaEgfWWJayK810ebyr1SY7
O5Uj7jlEeup0/lNgkKKTdzXzCAMJDqDUZ+V2GGkBEC57X9rhfVe+W/ivqouS0Py9
JAuAyFrgN7XtCgKDgz8rBsR+zy0nU3yoGP8l/BIuiuz5hVCLH9vnybaVQRLXvkEf
Z2x7ykaYfJ1aJzTGO156JbNkugiZLUQK9r4L1ZxDnvi8bbHPtSbojkfC/U/R/gSV
vJGWWszlwRBORLzp9LXEvSnWDDmOnPMAlYScitcgYvAhtRafagg2rPg5IStwBdSu
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XeQo+uI2mCDxHgB6ht5sfHN+VRDOFTz7tCt7fGSZTE9MjSdgDxsltr9cmijg1pem
njPmxOdk2TgE+Tv86Kw58IjRmuiWWlj/lYNJSBaT3P/74KVc9vKEzFNMIJxhwTT9
apzCql0EwJPMgwX7ewD7qz95HQPJXqSNpUH65VVVrck=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13110     )
BMturhs7ZAYEUFmrpu/IRtoes6rhPyAMDQYhHn0ICZC9K2bITsSLBQe6IudXTAO5
6cmGlE8hHkW3aGRFAEfBal/jvrBVeXQPpK+A763iB9GIFIuh1bPaPgaNv43QMviK
`pragma protect end_protected
