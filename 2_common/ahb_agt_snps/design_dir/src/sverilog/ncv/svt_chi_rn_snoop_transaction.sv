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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PfP/jZlAfvSxUq7EFsMlstMbmVcT6RnxFO4X5FJYIEIpvhlyC1lEWmzQqOfiMzS+
Pmqu8gQQmmLczfJLPxObcBV+HW/vttO+qBdHajqtyl+Te+EryPiGz9HqD7YPVZn0
szPn3hLYUzc34X0R2Eo+7CETSlqf4MT4ZWqKgzXVhQQQRav0k5MCMA==
//pragma protect end_key_block
//pragma protect digest_block
fmH9r7rxRfSS0HT85aaffqUElSM=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
iohLu6YrYX38yysdy51Xsls6pTc=
//pragma protect end_digest_block
//pragma protect end_protected
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bVYj62egIEb1YGhKyAt6pSVID3dbe9LkrLJyW4qtLqZb/4hZ1YkRC2BQPkIi3Qbb
MLB/GidQyHGMe+grotCzpRFkmaHnhU4W0R9NCECgF5FZ0aCbgP49a/IOyFLC7H51
EanOmPdXwioTKdPLtMSdwBMKJyFQkTEc5B0k1QjE4I8sE8Ipm/Vu6w==
//pragma protect end_key_block
//pragma protect digest_block
wKnIT1Kiu/wnagFuoAC8qinl5aU=
//pragma protect end_digest_block
//pragma protect data_block
41hm5lYvaOt1pzK6UpJujFVFcKwC/TMM+JDx1fHbgmmT/VWv6Avd4fzNUv3JR5QQ
I7if9Tu9nQn9cLvmwm+zWo+0Iz6E6cnpKCTWbwfVQY3TTstbk6PZhHQvj2rjMhzA
nt8+pM0fQuu07ou+OokFjAS7eikQkZUlj1FTP3vAWu4VCcmSQG6xxxkVEaC02zQQ
QKVtYJZ6/XZ2IMhkgmFkSBNHqSWegVePDxLOedQ4L+bg+setAYPk+5vOvvJ2Us/+
oPm8P0zS20SzyfEVTU+P1bBPc8qfPuQQMZBGWeAhooZkJlR2lNxNu745EZPkKsrZ
/e8HuEGZtArUwvK10o6R0H4kFz/8lHAZFJXJkJShCUegqYiYYEpCNaxzhisJZ+Vx
3CGTyKvvmDfT9ZgU5z9f/QUN0VgM+HBk4ckjDYq4NcFNn4bdTxBaNfgEMJaHQgdr
khAMtWt70KX6rI6MLlFZDbsKqcQ0qwEQDiuaonbZ6dXYa3FaQsgmyUCkcuR5T4Ae
vYrdT/Ewj0xKhZnujdoUuGRkmGT/zeteGqQA0CwtoLVVHPn/jeNmC6SEaN4pqDav
8X7Ul5UwlLZsYJm7HuzldQU3RXe9IlyMYUUxUDXRecU=
//pragma protect end_data_block
//pragma protect digest_block
ahu6BRBMHcRfYyHfmerrIUK7L+U=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CeYPkdfy3UwrBC0qyClV8JaU0VfoeAyWqDbfkCgB//A/RgvR5ZVvvVYzzv4c4Ejz
7wwUWgilXDc2Qmte0g83723/KKtv1QnrfZBEURoHMPT6PcDGJwqbterX2Ejhu5bT
yOyQ6MCPLu1Rgs3ldvUqd8e3qyJ7A6ZVt3Lpjb8L9GOJVoNLVxmiqg==
//pragma protect end_key_block
//pragma protect digest_block
Odpkn4GdOZnC+WwhzgIPndXbM08=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
EbxD+rYL+wXYffDveu0ud6GZuX4=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
q1zE1UvEQKN3gMd12IdxoLKHbM++agzaoSh8+8bQpbzE9zPFJDIfl4xiQ0rgM8C0
6RiDNYNz1NhiC6mcA4FhbgmrXT6jqpAuZCkwXYdoHme+aHt6YXIw193sIGPLT1fG
Z1LzWvw0XlzlfVyJrrtbeapfAFc2bZQ5uc4YuxuDQICD/SSKUEncuw==
//pragma protect end_key_block
//pragma protect digest_block
WWX0g0agj+bb5uYwnTtSTY+AFTE=
//pragma protect end_digest_block
//pragma protect data_block
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
LGaIlCMKfPlwjA0qqbGGmA==
//pragma protect end_data_block
//pragma protect digest_block
sMwsSHRcqgm2AYnog5bTggSFH4I=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_SNOOP_TRANSACTION_SV
