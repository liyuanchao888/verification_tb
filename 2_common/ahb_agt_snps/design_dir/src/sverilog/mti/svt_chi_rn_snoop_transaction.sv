//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV
`define GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class contains fields for CHI Snoop transaction. This class extends from
 * base class svt_chi_snoop_transaction.
 */
class svt_chi_rn_snoop_transaction extends svt_chi_snoop_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

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
  /** @cond PRIVATE */
  /**
   * Valid ranges constraints insure that the transaction settings are supported
   * by the chi components.
   */
  constraint chi_rn_snoop_transaction_valid_ranges 
  {
  // vb_preserve TMPL_TAG1
  // Add user constraints here
  // vb_preserve end

  }

  /**
   * Reasonable constraints are designed to limit the traffic to "protocol legal" traffic,
   * and in some situations maximize the traffic flow. They must never be written such
   * that they exclude legal traffic.
   *
   * Reasonable constraints may be disabled during error injection. To simplify enabling
   * and disabling the constraints relating to a single field, the reasonable constraints
   * for an individual field must be grouped in a single reasonable constraint.
   */
  constraint chi_reasonable_VARIABLE_NAME {
  // vb_preserve TMPL_TAG2
  // Add user constraints for VARIABLE_NAME here
  // vb_preserve end
  }

`ifdef SVT_CHI_ISSUE_D_ENABLE
  /**
   * snp_data_cbusy, snp_response_cbusy, fwded_data_cbusy field size is constrained  based on
   * number of associated DAT/RSP flits.
   */
  constraint chi_rn_snoop_transaction_response_data_cbusy_size {
     if(is_dct_used){
       fwded_data_cbusy.size() == ((1 << `SVT_CHI_DATA_SIZE_64BYTE)/(cfg.flit_data_width/8));
     } else {
       fwded_data_cbusy.size() == 0;
     }
     if(snp_rsp_datatransfer){
       snp_data_cbusy.size() == ((1 << `SVT_CHI_DATA_SIZE_64BYTE)/(cfg.flit_data_width/8));
       snp_response_cbusy == 0;
     } else { 
       snp_data_cbusy.size() == 0;
     }
  }
`endif
  /** @endcond */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_snoop_transaction);
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequence item instance.
   *
   * @param name Instance name of the sequence item.
   */
  extern function new(string name = "svt_chi_rn_snoop_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_rn_snoop_transaction)
  `svt_data_member_end(svt_chi_rn_snoop_transaction)


  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  /** @cond PRIVATE */  
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_snoop_transaction.
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
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
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
   * kind value is svt_data::COMPLETE, which results in all of the
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
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

  // ---------------------------------------------------------------------------
  /**
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  extern virtual function svt_pattern do_allocate_pattern ();

  /** @endcond */
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_snoop_transaction)
  `vmm_class_factory(svt_chi_rn_snoop_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_rn_snoop_transaction)
`vmm_atomic_gen(svt_chi_rn_snoop_transaction, "VMM (Atomic) Generator for svt_chi_rn_snoop_transaction data objects")
`vmm_scenario_gen(svt_chi_rn_snoop_transaction, "VMM (Scenario) Generator for svt_chi_rn_snoop_transaction data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_rn_snoop_transaction)
`endif

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NSRbGthoPcFwJXOxLK75k4Md/IgcBgM5ABoaE6dX9FUHi+4Q9qE81Oyl2uhbZYDi
GpdRS3lYzwa20D+/9L3se4H/K7H/YCdNZLAzwb4OpGWYuzSsNEmt5P6Q3z4ttbDX
YXD4DqgncABpILCsC8JShS7pI28YUIm/QOa9+EqPHqs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1321      )
vZY7azj2BYybwJUO2QxuTKUY0x3AqNNAhK7chlKyp0Di9DJX952aiGGGUY+nZQcn
Rk5cDrPcy2PdfoHpvkJGwKL0CX98hrqFlelIl0E+fqLv8mlCifIksAxylmVphzUc
0U5bB2SSSjdP/j7JOBIPNcTNgxQFcswdxIelYqThMjbiUzTWgFdyMrZsa2JQhmI4
EhyuC9c8VlsXFgtZxhp+0tZk7ntInMxyOuiwdYt8LumNb9zYVPnJpeYv0oHmo0KM
MhaaWnmMXAYG6rVfGlZsNNyAYee2pF0YAX6VjHZXA7tDOquohzLPl/gvN5qBszMq
cQau8tIuNwkjRtM2UhtzsxyhMEITRnIi8yjdM6AUG3Xpr1cwb0wvl7QF0qKu51Tw
zxuPkLL2AA+AR0uTuGAR1oZIX4kNRUe2hiI0BCgtdnfV33mnNctUnxArUvmTnpt2
GSES+uyCSCiXQnW8IgnLpo4Hd86dztxpEY1BjnuhHvJlYyLdRRGOF9DEKVRbG1NQ
wOGlTY0BQ4+u0aEEjZU8xZ7Sn8+11b6YAr+EIY3qY0BEymzaaAlBVO5yKqeaVKdX
NV1px2cGHOqo+y0S+2lmCl+vi2ORa8yo24Zw1B/YC0dI764ToF7JH9GW4uShpnPI
ih9PfVSzsfXRbiJDFHibuftp3NZaSQ9xfwWcZGYu6YUxrByglblHGItssT2ijwwt
ldpaYvod0nTtmZW+uy5h0f8yegq4Wyq/spx3PbE4S7fjVdk8XyxP0SOc4vmWeI9L
BP9WUho1pdX/0aD6jGEVcZMGyPPBW4tnimrbw05E2k/LE8NUDZKlaEsg56ocbfV1
fq4sx9UMDmGGFoPgrU1c9p2mIUgfzr7GQGi1+j8L1X/KtV1jAaKS1o9t7HJknimR
2bV0K2xNQsNRibqVcmKYZ7S1+YvXqCKPqPrhxmogQh2PcviuEsOS1HMvzhg0tN00
YgLe2N/ZdAb7mZmcXpVdppoDPQLUmXhfWW97n/bLJJi7fzutwz4MSI+UrqmVKeQx
uA4NfM03vo+KiHhQEIWPP3sX7UeH6prKM03Keb9cqqt4dNhWN/n/liCIoi8dJqMD
KiLzI/h5f3devlxxM4dqtPug1xfgZfymZxNIL3AXaXwW+zoOnnxTySRuR4KK9kJM
v95tbM36ZQ6cT8PrYArO4R/RYsKM5fa9Uu7FAkQ/3pNAA0n1VSJhf3OXBsklxAMU
dvrt3Y/QbDeb1KcaydcjPEtHvBQPr/DOm8XO+E2XlWpQbZLANIoy8og8AOEP6jQj
S6o8ztervHytYQNnxJJ4os2M2MzeSzNHc8qi84vWZc7KZdAJTUbePOdOngcoiDCs
icXg9I479QbOHCTl5eG7RpQ03FQmJ4YOF91uu78QSjlLq0g0AxMudh1Hrc4byxfV
DqaJvnuiP4/OeE2cnEaspxBQxSPrQ1rAMfjHoHX5sMkbIJl3ThKSZBQU55+6HCqD
1Bk1pf2hSB+VvYE1cojDEJOIfdVpAS/KvTr3dMlpnCy0jervRNAISDNeRZPL/p1w
In/380GQU9vvAv9gA+rx8zyAdCAF0XpPf9tjisq/aGMuOx9nd3hH8lTKoyaWiJJM
WSLZbq8YcfEgX3QKvAYHX3S90o0cqU710XW09G9lGbK1cXeqrDhZHIv5YC3tw/+0
NOUIw9m6k7aq2g0L/fADrUUBqOsUOQY3C0CFGl0FGpQ7fvUg8jCtHtvhEl6XD9do
8a+NteEx7vXRESw82WlXr5vVKSHYkMFC1oRJM6DAPH0=
`pragma protect end_protected 
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XlGh9EiBWpKLSqZ0raShMIfNkqIFtru3S50pFJyYQU0c55fRojU4utZL61uY7IOt
XcEOdLcwfijZ0iLwosvowkdcq9M8rdx2ZLqsEHuz0L4czHUcGsx6nZrbzTGVD7rD
v5revq93G6Sl2/eoOOxRKwcOdZc+bWPF3DvD8lwOPmo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1607      )
FSO5sMxJlQ/UxpkMPRUXfOrjjgXDFHGZEIAL0q5/F7aB22jEqShVmEvdLzC5V3HP
9W6EecmIvE0XLrE5N1Aoy+v9IdBwNNnXEUdSuL28kxJQ3sIgTFukl+VvQt0SPkxB
mYRJtz4/dbP4wbUICe7TtOSVnz6Z1l9KmVK8b88oOwEjADBaG8VHtKkBUsOHlmJr
rFx9Uvl3Y9zt0qjeZrPkXTWKw3Td/i26cUuozpUVDe+cmJImxnV7PxbUaOBQUqj7
SrqOPXTLWbmb+ye5OemOOz2P5E9IVpyHPDVEAQJT2OtXp2B9QcEMPr64RGL1DHm+
yDRDIsJ3Z8/1IaxbydpKl5YvCeh4Wv0+HDSqBFrG8B6b0UTH+uZGUvvTcddg6gUj
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g7KbcHcnXiYQnOVYOdtGXVbvZUBhC4dm8EyUhQfR6SpcEznBxJUYzTI+dxj1snbZ
43k7mC8+8KKqFy9oxnHDQCSwWGcxIJr443nY6J61BDqPsD2mAjNGckLRZ/J44GIX
g7DAAIAeri5QxW/rAYlXHiJO3tzs6xgr2zmj8M6rJQ4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3768      )
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
8pREWx4i3R+ZChRsh2DJdA==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Hk52UScgZ3Ex0aEboqR/UV1FWwbUd6q5Yr9wmRSi+xH0CMnkLWikeNZ7aHwtn6vI
JOIIhj1Rle0VYiEdInKeyqPBzci9Y7zTMOXgfozoEvYdl+lhfUA1TiyO+FyJFpjA
7YVxnmRelwEYKy5hPW9gWjE9siXpiz7ge8AcrUlGB3w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21173     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GsmE5Q49ldMiCwjg1qipzIw8/wVw/1e6T+vbzXsRL0B6PVhIlu65XmBIbHBJR2Gv
NDhvdG0rlujRhDb4V+/fXXGC9dANEz+vfxxQh19JHmha5BxV+BgrA0BCitVscS5s
RRml6YAAkTQG/TbRqW0VE48mtgD2WetB3f0PrBLR+XY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21256     )
VV5F1SsJ7kueC/+q1zIXLK/wXfmB6jUdM/e2kkNQwHBDo+9Ob+kN4xF3ENIBqSxW
2g9RFK0hiN0uvrIt2j/qW4VbkSWJRu+J8Rz8A3lD/AlgjeREIFVqWUBCU7OhB8sD
`pragma protect end_protected
