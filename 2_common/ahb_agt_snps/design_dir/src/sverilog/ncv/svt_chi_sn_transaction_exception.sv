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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
S+JUKkS8aGfTwmPmc4P1GoknOcz88PEThfpcK+CggGRYfOwwciUbRZQguP4QkSqH
JRYePGQFnFfktF+zOAfKLH5Sg87eiiBIDT62Sw0+4pU8UTfBZzCABeFe+6b7cDXn
FTAdv4tJDUlFbc/vgp57DCDb39up98HA+K0xA2lys+7CdYGu0fYiyw==
//pragma protect end_key_block
//pragma protect digest_block
u36tmF1B6KyK6H5hWpZrhS40zc8=
//pragma protect end_digest_block
//pragma protect data_block
0JlBRUkZzYV2k5Vh1VKNdVb2HAcymNdulZo7wpdCwn0JHlv869A1WKzaI7pI3Vg5
biszoKUqZlicbMjKLmAFG94nz3leBtWW6S/5mXa4RWueKzHP0/RvCXtBVH6N53oc
0cQ0VUWgg9Fwin0GENRDnp2MOU4MplIsP7ncew9DImOPxOLAO6b7ZWtJHED2kN2N
wLH5QjW1UqsPc7rxjHR7/ozllsyLgWO8hpMrZ9hoPxUC8E/wiu8uDeLtNsVb3Zou
t9HFmG/voSi5tv/fFRw7FhzLtY6mME+y2yr3wQhpF8LEM5+2+3XySgLMIQDsWV0f
DfxHCcon7ZYKn3HTo+gARxgUY30qmFCsLA9RHhdY9LLPCt6UIlR47ISNzIXgpVIQ
LSHK1d5mI00HZn1+o1S7QMiO0LpfUD3lUTSTL6QPsq+8/i82k7X83RkTsXIZ6Xwd
SLtVgjSsshZ75v0DHGCSnKW/1e8m8Ah5H/c/q4F7jaFuBBEfiYTMfjJVY/92PAMb
9ur8NW5fC4UVknGEM9b8jJOT8tsXXNE8vrJCcnpuJzcS+5u+kbUGK4afAqxIVlUE
a4Jd6czclE24rIrXyiC9RZ+hvgRXOIW73NRjQn3Y125sn0bOg91sa7TQDxfOy3DE
qrQEUQJYqOdkjJLtAiASronsgQ7oE8g8oHJ0HRUsHjk3LCzwvyiKxrb4lT5Ay80P
ws1OAFWijqCx2lCzBC5q0+8mkFv3j5xlwTYr4DRaeBBR5m7lZthsVkyr6og5+dyF
g9PczlgYGO/LgCe66hXr/Zo14+drpcgbfyv7pcVnHk0holOdChDk/r7xh80aPIfx
yhdumK68KWgbmvBWRG+WGybTvlUb1P5jYP6eBJXFkqdvrDWKp2N+CJZNt3RaoDX3
W5tqKDRhT9rrcJ8EFFME+Dr2QPAoCkdAivIGutonTRzvWjmSnjTLCGA4B30jAbJm
cMtLimoYgiyMtvILIHrDEUz63Jh/Wi56YKuUzpYNGeZlk9Ag3g0jquzN1BvhAGPq
RZFhg7R2c0eCtgMgM5gRV+oGi6ZRc9wv+6NaIPyrW0Q=
//pragma protect end_data_block
//pragma protect digest_block
W0uusMp7a1/DFZpBookraZmhNJc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hUSMlEZhgseDRBS2Mhu5mjF9pKp+jua+0WxzhH3urcfhfIyGcZkScenr+fSMRmv3
nZjxbruHe4h0JkFza5NLrusSfcip+M0B7Idk9DZV+c9wESNedDTOhIUSNT+zItEo
VodkYNystvkrkOVtUFPInrXELIsbYK4iERiDr/zh2oPqgOwhOnAZBQ==
//pragma protect end_key_block
//pragma protect digest_block
K/wo7NjCG8IyYFSnSEi9vLW3SVo=
//pragma protect end_digest_block
//pragma protect data_block
4yfi52K4pIwDWqEPMb/I7lHoteyJ56vsbFP66bg3kcJmaKwxYqq4juqGdcvgRtaU
70RmJvrGHumdmDX3apfTIR5aRKS6fuozPZ5U1oBAWuyK0PgHs/X+q8kNeqMo+0mg
Q8j/soVuLAvoIlPsUktLpTSeAEOemugahj3d/cxXqa8j+waBFzjzmPkELlm3e4DF
ezIHAaUwuUSQtiZcauow44CD+4K0Mhzzg1mLRMt63K0Bc9auzHD+B+O9W3dYU7V/
EI0RraG7fhmRY+vTvcWIEAN+ZGA6q2kOw3DUhgmaFBPxngEfuUYpuLngqNbBUPg+
7SxVIELaZwfGsPDu/5YCCpMOsH57M8y+bwsS5y/8xUSCHpYThK6gH3IQrhMhhC5y
Dsj3iD1togEadXkOLT72RY01Y0RLPMjiQNmH6sXhEtCNX6hVJQkEfT8zHImzUkRz
a6cRxEfM0lGKz9C4qdZH5Xfe9TWIgNe9zPmTzylIz585sINU8337YhrMVue+yqr5
bbCrDfJNDQZk3wS0PC4U7n6o2Xk6KP60QLHNmlfJsBNJhRi6bqqrSIINfFURZwtJ
9Be3RAAMGqwxVzvjKfRD+z6KuEOJeeQ9LHF/qUXJjDU=
//pragma protect end_data_block
//pragma protect digest_block
sXMQ7Bmc1iGo7egNFZjsxksjEak=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JfwZkWoQqfxm/7HfqzGzwmlL0m+PGPHRYAZevm+wfbYjWzh/oOGBrdqGniHSP+Oa
p6oOz8vohROUpAImqDuE3kK/kQ1WSON5meMKCSJssJ2XVzUf+DfmvB8LFWCihTsg
Fuk3Hr5+icw68OSf115/0+g+pQV987cVdKrsdA7jXRHWzsICQT8CLg==
//pragma protect end_key_block
//pragma protect digest_block
4YGGlMi4nYmkexip0NwgWu4dMSI=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
fMR8dnS8jc+8LVjVyyrtkvcAjw8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pnZ4Vf4t5X+0QWc5OPg3EFRNTEQ6oE5za3Ch7XmCW13tGqmeJKBohPL3NtPofVzV
gy6aysj47Y7jFqldFUoZMYsi/YVHf/A1Te03AVDEmby20ijBQnk8nBKhDtvFNU5l
K+xK5w9WpiX1uQB18UcWBTAFsXEAhmUK6Wjn8OoIFGaf+VQgM7IKiQ==
//pragma protect end_key_block
//pragma protect digest_block
eDEVTGd7vk6D5R5gxzH0XcjrD9U=
//pragma protect end_digest_block
//pragma protect data_block
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
TitzrakLuiTj7JJGLIYBIA==
//pragma protect end_data_block
//pragma protect digest_block
PX1L2w0V4NskMSH1sicoPuljpNE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_SV
