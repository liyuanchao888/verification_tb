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

`ifndef GUARD_SVT_CHI_PROTOCOL_SERVICE_SV
`define GUARD_SVT_CHI_PROTOCOL_SERVICE_SV 

// =============================================================================
/**
 * This class contains details about the AMBA svt_chi_protocol_service transaction.
 */
class svt_chi_protocol_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  typedef enum  {
   NOP = 0, 
   COHERENCY_ENTRY = 1, /**<: Guiding the coherency state to enter into COHERENCY_ENABLED phase. */
   COHERENCY_EXIT = 2  /**<: Guiding the coherency state to enter into COHERENCY_DISABLED phase.*/
  } service_type_enum;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /** Type of protocol layer service to perform */
  rand service_type_enum service_type = NOP;

  //----------------------------------------------------------------------------
  // Protected Data Prioperties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges which insure that the Protocol Service settings are supported
   * by the Protocol components.
   */
  constraint valid_ranges {

`ifdef SVT_CHI_ISSUE_B_ENABLE
  if(cfg.sysco_interface_enable)
      service_type inside {COHERENCY_ENTRY,COHERENCY_EXIT};
  else
      service_type == NOP;
`else
      service_type == NOP;
`endif

  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_protocol_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_chi_protocol_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_protocol_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_enum(status_enum, status, `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum(service_type_enum, service_type, `SVT_ALL_ON|`SVT_NOCOMPARE)
  `svt_data_member_end(svt_chi_protocol_service)

  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

  //----------------------------------------------------------------------------
  /** Method to turn reasonable constraints on/off as a block. */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /** Returns the class name for the object used for logging.  */
  extern function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_protocol_service.
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
   * For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  `vmm_typename(svt_chi_protocol_service)
  `vmm_class_factory(svt_chi_protocol_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_chi_protocol_service)
`vmm_atomic_gen(svt_chi_protocol_service, "VMM (Atomic) Generator for svt_chi_protocol_service data objects")
`vmm_scenario_gen(svt_chi_protocol_service, "VMM (Scenario) Generator for svt_chi_protocol_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_chi_protocol_service)
`else
// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_chi_protocol_service, svt_chi_node_configuration)
`endif

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mww+tawGtoaD5qP3ipHsBJHd7nDENZptDxEumKZICoIoSzHxYGCVcslaQ7S1Bh+I
PQL0j6F7gnjHbxdrbKg4msfiMkxIS1qjH1eVHutaqomWpDs/5H6fG99Xb9iSKYwg
knIyIgsSyI9fd4X4v6BHtOErnX771EzEiN6fjLe7sII=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 944       )
zu7caZwrsc6LtE5BFPUMMnpUGCPqma/53ZgYtjXD2FDVXKoGWaw9vU1GYNN8Ghnh
ZbbxzeAh7VKVR9nv3+01fNMBrdueKJEMzBJxfUS7/VsMMtqDsEAhAIBx51Z0Uzva
ZLEPXjJTXjg84UPisWuUfY48mxAU5r/Wf9L1bddd+TVi0IOJxg0ONKul9zjwQIoc
gQ5TpY7X9PWioauHsIJJnRiiGqcs2fnE3VzXunv3Yx6kwReVpEUpj62KUKSKZj6f
t718q8fCfpEnW+hzxL1xT7PwYjB+pKrM1s8s/eDM6zAHN3VBctgyKng/kTBkAZ7B
YYHuTyJ7OUADRfwz9CnTCsSf47SsncPNyjf7IBkH4va9BVtDAg26MZbOwmHs1Aiv
rfY/Bae98IxNUNOgMFDH4UouHNd2U2o8SyfMT2PIPV66PQJrmEgO1F8ypvrkyLKl
W4Dd/XgW7rGyv6hBtY0fqL+Z6+Eaj2FhdYd/TaB/nOgjx0oVzmHfd84A/C+UrzZV
ckuwJTKhloGZECQRap3+IspuGz8PHKi79m0dhSyT18/G6+6VLukpesUgtBO0/iel
ADRNEqiyK1hRj+7i5PenB7EBm5Y8jqyOEtME+RbQmnn2F+ZBhM4QNnmyp1l4WUF0
1ReM40HpWsSevBpJk1saVtwZFvmQc5oS9TvZnA11/WNQd5iVjZtesPrxNFnbPzxP
EyBOCx2U3mgAsHr23N2W7711ob1tt/wJbicu1Ew/nSEINcVzcmFLoPvrLuRGtjxd
ZaWsoVRpmKJxjsGmGInbJori71P4Rp6Creh4JChYca/LZ3wKms+CVRCFNEuKluKY
ZBz2uq72WN1xhUQhsnEcq7/vku82AchkdcuUj6/yaTHBpueDJ5MIX2Oojopah6wK
LOIna2/VeC3J225d5hmqmT3AD//raGp6sB8x4510TqRbrQrYTk/rylclA9enTgUo
VCUIJ1HxuUGuET2m1D+KMUVRj+DFtlEAyjUbYR49mHtqDWUdEePhjdNy+jy+UCxt
N7pdHk1K3SUGOWZKeV2+evSTJozBenMkhgfNZN/1xiDF5NfxF9ZHwe9/2y62xvWH
YkxEvBNMQGBZmkds1kdz1CUL5cfJHRNe5rjybDJp0EkQIWDJDDrestwpqkW5vc0i
qiEo7bx0ZjsVCwB5C8Vs8x4mJZZMguCPf8j0OfqxiYlXNI2gQRrLTaMaFYsmB/93
Aotp/prMQkVuZNZgOCOkybDUDWYnmHjmKU6jgdJRA/jAe3FSUtSc7IujGJK3u5ih
`pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_chi_protocol_service::pre_randomize();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MTIm6acUxHYSe5HQfvQReqWd1m0lJdy+yvG/npwvqhRhyiYVGVRBLarHRzwYMaVE
GUL6oxtCPmLezOEODjDEQWxYDngHVJXt+oBQVKknjv0D13Cio3WkXJAO1TxS44Pm
oujq0WMf876vWxYc0EW8lfsKJBEVYj35kczL9B9YiIc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1276      )
xDBCRpbfM4Y8lZ1HBwT3rPg0dILaDGSzE7Qnrg2vdYA2pOzHe+/eaYP4IzKVPqq9
MpWTsT2WUpOx5uAPY0Xv073nhsbbDS/2kCsK2GyfYUz/SdVVdoiz137YKBUS5Oo3
bjFeMq7d8hGCiaNALpZvP2Oh9cqg3VP0IlSJkBGgKYZab/xug5x9drcMQ9d13aGj
mFFACGfs5vW+vTPRtkpt60DvUNmw8Runc6XMZFhewcu/T+8fjgB020QVSWGEXM77
eSCSofwIFqH2X86cydYkLa00oIsudBpJn2MTu5UC/8HJzWxEAxLGBM2tCrOBTDfA
UI0Se6c7LJAqOvxTKUVSrmgsSanboepdLHDCagPdY1GZnprBfZ2kWGF27KUuwAaM
5m3PjJCz64fqd6bK39eDAWchqWbUz40svE7NqVgqiFjAbaaRUmsCdtmyW/8TjAWO
`pragma protect end_protected
endfunction

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D7sYLefHyqmDKD8nciOj7iUqRAi0s06PMg8g3a79of2AvBjYwEBV/XwdlwPF4zin
vx93NdCiUH4VuX4mbY8sXWyeCgYT7ZYYLttT3eCD7Yem2WWfcWriG+VNqv868/uh
bLKxiNfpFSNk1HtkPchLCZ/AFFXJ9I1dHY6+bRoXRUE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13665     )
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
KVQK4RSc1+2AtRQbnfqzwQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_PROTOCOL_SERVICE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ghWcRT6BFgWjj/LgJdjE8fto2cUlKgmNmvV/spmKKNOsJrtXLyoEbFeAqeO4iivs
oiX1m8brS0oZGxsXyn5vXx3aI8XVpH2BVEUBc0UsJX6zp2RHswhJndWjzRnS0Rj/
/j6/0fcEAtdbMuQoJ5YsbSACe65sHeTxhLJ6wKukfXU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13748     )
T/0QHE5lnG3j4UxQMLW4Y7N3Ahk9TXBkhDBNc3X4n9zvzQo4sK8FiJWcfg5kcC42
LSm/1I5p470KzGYQaF4nIiXmXo0SQJ5MTR0ncEw+9RY7i6JtWOKlQoeUrJaWaOGs
`pragma protect end_protected
