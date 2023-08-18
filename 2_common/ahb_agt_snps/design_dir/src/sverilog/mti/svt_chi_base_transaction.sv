//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_SV 

`include "svt_chi_defines.svi"


// =============================================================================
/**
 * This class extends from svt_chi_common_transaction. It contains attributes
 * which are common to svt_chi_transaction and svt_chi_flit classes.
 */
class svt_chi_base_transaction extends svt_chi_common_transaction;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  /**
   * This field defines the size of the data associated with the
   * transaction.<br> Note that Data sizes other than 64B can only be used with
   * ReadNoSnp, WriteNoSnp and WriteUnique transactions.
   */
  rand data_size_enum data_size = SIZE_64BYTE;

  /**
   * This field defines Likely Shared attribute.<br>
   * When set to 1, this field indicates that the requested data is likely 
   * to be shared by other RNs within the system.
   */
  rand bit is_likely_shared = 0;

  /**
   * This field specifies if the request message is being sent 
   * using a dynamic protocol credit instead of pre-allocated protocol credit. <br>
   * When set to 0, indicates that the message is sent with pre-allocated protocol credit. <br>
   * When set to 1, indicates that the message is sent with dynamic protocol credit. <br>
   * This field must be set to zero for all requests that use pre-allocated P-credit, 
   * or are guaranteed by the target not to result in a RetryAck, or is a don’t care field.
   */
  rand bit is_dyn_p_crd = 1;

  /** This field defines ordering requirements for a transaction. */
  rand order_type_enum order_type = NO_ORDERING_REQUIRED;

  /**
   * This field defines the 'Early Write Acknowldege' field for the transaction.<br>
   * - Value of 1 indicates that Early Write Acknowledge is allowed
   * - Value of 0 indicates that Early Write Acknowledge is disallowed
   * . 
   */
  rand bit mem_attr_is_early_wr_ack_allowed = 0;

  /** This field indictes the memory type associated with the transaction. */
  rand mem_attr_mem_type_enum mem_attr_mem_type = NORMAL;

  /**
   * This field defines the cacheable field of transaction.<br>
   * When set, it indicates a cacheable transaction for which the system cache, 
   * when present, must be looked up in servicing this transaction.
   */
  rand bit mem_attr_is_cacheable = 0;

  /**
   * This field defines Allocate hint for the transaction.<br>
   * When set, it indicates that the transaction may allocate in the system cache, when present.
   */
  rand bit mem_attr_allocate_hint = 0;

  /** This field defines if the transaction is snoopable or non-snoopable. */
  rand bit snp_attr_is_snoopable = 0;

  /** This field defines the snoop domain of the transaction. */
  rand snp_attr_snp_domain_type_enum snp_attr_snp_domain_type = INNER;

  /**
   * This field defines the Logical Processor ID. This is used in conjunction with 
   * the src_id field to uniquely identify the logical processor that generated the request.
   */
  rand bit [(`SVT_CHI_LPID_WIDTH-1):0] lpid = 0;

  /**
   * This field defines the exclusive bit of:
   * - The Transaction (svt_chi_transaction::xact_type) AND
   * - The Request flit (svt_chi_flit::flit_type = svt_chi_flit:REQ)
   * .
   *
   * Value of 0 indicates that the corresponding transaction is a normal transaction.<br>
   * Value of 1 indicates that the corresponding transaction is an exclusive type transaction.<br> 
   *
   * The Exclusive bit must only be used with the following transactions: 
   * - ReadShared
   * - ReadClean
   * - CleanUnique
   * - ReadNoSnp
   * - WriteNoSnp
   * .
   */
  rand bit is_exclusive = 0;

  /**
   * This field defines the Expect CompAck bit of the transaction.<br>
   * When set to 0, it indicates that the transaction will not include a CompAck, 
   * so the receiver of the transaction is not required to wait for CompAck.<br>
   * When set to 1, it indicates that the transaction will include a CompAck, 
   * so the receiver of the transaction is required to wait for CompAck.
   */
  rand bit exp_comp_ack = 1;

`ifdef SVT_CHI_ISSUE_B_ENABLE

  /* For Atomic transactions, indicates if the Interconnect can send a Snoop to the requester or not */
  rand bit snoopme = 0;

  /**
   * Indicates the endianness of the Outbound Write Data in an Atomic transaction.
   */
  rand endian_enum endian = LITTLE_ENDIAN;

  `endif

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
  constraint chi_base_transaction_valid_ranges {
  }

  /** @endcond */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_base_transaction);
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
  extern function new(string name = "svt_chi_base_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_base_transaction)

  `svt_data_member_end(svt_chi_base_transaction)

  /** @cond PRIVATE */    
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
   * Allocates a new object of type svt_chi_base_transaction.
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
   * This method returns a string for use in the XML object block which provides
   * basic information about the object. The packet extension adds direction
   * information to the object block description provided by the base class.
   *
   * @param uid Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param typ Optional string indicating the sub-type of the object. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no sub-type.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method uses get_causal_ref() to obtain a handle to the parent and obtain a parent_uid.
   * If no causal reference found the method assumes there is no parent_uid. To cancel the
   * causal reference lookup completely the client can provide a parent_uid value of
   * `SVT_DATA_UTIL_UNSPECIFIED. If `SVT_DATA_UTIL_UNSPECIFIED is provided the method assumes
   * there is no parent_uid.
   * @param channel Optional string indicating an object channel. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "");

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

  /**
   *  This method returns the data_size attribute of the transaction.
   */
  extern virtual function bit [(`SVT_CHI_SIZE_WIDTH-1):0] get_data_size();

  /**
   * This method returns the DVM address.
   */
  extern virtual function bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] get_dvm_addr(); 

  /** Returns address 'addr' aligned to cache line size of 64 bytes */
  extern virtual function bit[(`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1):0] get_aligned_addr_to_cache_line_size(bit use_tagged_addr=0);

  /** Returns address concatenated with tagged attributes which require independent address space.
  * for example, if secure access attribute is enabled by setting cfg.enable_secure_nonsecure_address_space = 1
  * then this bit will be used to provide unique address spaces for secure and non-secure transactions.
  *
  * @param  use_arg_addr Indicates that address passed through argument "arg_addr" will be used instead of 
  *                      transaction address "addr", when set to '1'. If set to '0' then transaction address
  *                      "this.addr" will be used for tagging.
  * @param      arg_addr Address that needs to be tagged when use_arg_addr is set to '1'
  * @return              Returns address tagged with address attribute of corresponding port
  */
  extern function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] get_tagged_cache_line_aligned_addr(bit use_arg_addr=0, bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] arg_addr = 0);

  /**
   * This function sets the field datasize_aligned_addr and updates the flag 
   * is_address_aligned_to_datasize by comparing the addr and datasize_aligned_addr. 
   */
  extern virtual function void set_datasize_aligned_addr();

  /** @endcond */  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_base_transaction)
  `vmm_class_factory(svt_chi_base_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass


// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JEJYZdmgVFi0OtBZuadoEeAafumk/gNEbPaNcRJlx+BtEhiiQ7hHGUilxIN4m8uu
DdDjkCzd9UgyGYByyqHJ6O0mH8CUXGiojkMergh50qDX9fQW4CwMf0iTiuJxUl5k
BL3KKWLEOGcn9LL2+oiN51nkKkSzQU3ZrhJPJ+DQpAk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1134      )
y0FlC2DdrhyK3cKgxTydWc3tSloPd3Xx4RQR9sMcfLRYGIRO1AqfPLLT1HI99la0
rZvRzKRHOTTzjJkIPXTkwFyJaSdu+0OxCGk9gX6nETckCdsbdrzvKZp6rWlMwJcL
XWRHIz7+5hkPkbZe70TNEmTt48h7Tt57YTLVOySzle8L77SuYTqyc/B566NkQznp
UBklZ6k4Vda5MO6egrE80ykK+8PXsiILBNNGNaJegpzdPc6SN7SzJmnGE6/hLhC7
CEvzcRxgD2AhXY7JLE95AkbH+cy8mUep1JzcBzl6LBVmF5D9RPWjtkSUv2+dHs7E
bFgOyTXKWQhHeLDpQAbHVGaN5rbtQga98njOH5acHTDV40Rhle4RDq7/CGP4Uqsm
XQn++N/1TXuKfRpsnkzLgfIoPs19Q5bPy3NbIBlROkBzZXaJfHJ09IZrDAutAIIb
jQo3eZVbjCsvVPx3ya1AVpxosGyYRxnN3z6W48umRMa7f0YxlAL5lb4ogZ2rWCYv
iIKdlxnTsK8OWevk8fGwTG6P0po9JS588g15FGip/iZMe4OnXHuDeTREGKr1kCZ7
48IRliZUX1YjtL8YfwNT09lSOXNTuYy3zvqTaRKI9Acqs4TfDByExmLMhtkzYbRD
xc1nK7hVeBOFrZoZuoT/FJXM3Nk3ictF3RS1NuCPXvJZ5L9yKAIjorAFBwMUbKQO
yp25QZsAec7p3K1NXsJ30H4M7KJYqWW5EmpqYtHUnQYctbZUGsCgrpDupDcZG5IA
mC6/QPioUwMEU5HFJEhymUJBwSCcdeyz3gxsa/FGLny4BLgoubjCbeK+heSSEeS2
kWluiugtOZa9aKoDDzBIwPwnnT1eHHoJoCZ3OsJfC8DORHu6rbcs7V9qTjFigYU4
K89z5TbCaytIQ6mxvhETAwTm+obaHJWHS+5FNJ7jbTc0VGQ0vcEpiIQKuFHX7Gwg
GHBYuDb6CitbJoRmaVXODG5g8JWnJeTvEbpVmh/l7TYCTKpr3N5H1g2naSSbx1De
RbpnS1mXqa0VFl6ObXy/QuMKtchBNHc1VAFoZqn/aKfMHYoCgXs3MHNT56Yjy0uL
eYl5qtvpzvlBFfEjYx23sqlo/FYkAN366IpP+iyD+1DZP8gS7lbjPNKvfAO6LeAz
NXWOD5wI1niWhf6yI0Eqm/vkHu5HAj2x9BtZfQqDRUlu+KSeQ3y9unmoOZapKwKv
zWtBOL0mMka9ZHz1HrD+CdrYfjm4lfs2whGKifdYw7k4XGPpk/Qk44SP283j9rqz
QpbqolikcnEmBQ9QL84B8XrjLHu4UbkyYStkTWjcHxL0mGC+OcCtNVEKSqJ5fvJP
5r9iB6NRy882Lt24LWjHWKTErAm10X2ddpQt+TLaed9uMuPtLEyFyWbkzcRoQRX4
TPR6PC1bC5pEA0xjiZQvJUkwexcR7GManDfwKca5J1CvObbpGLc2rvjrjz/U2MdL
FLeHO4AdN1YDL8HGZXw0WXzrS1ytxbHYnqcsGXbl0L4=
`pragma protect end_protected
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hlzJVu217fEAIRcYf3QASUlpIfowOc6gxNUV9MrZUvVBiAIBe6VAbEwqVNhMnYRy
u/NBE7Eds/dcFz3gnR7dIVFXh8rOlQOaIhYVZxfbbUPnZLlxrnhqX0VKqDbp2snI
pay2jRZ0ZBI2lbJCPqSPBmW55cxrNo7bhOZ1nqUNYXE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1416      )
GnIrKqqG8p6iybztkT2z95rMR/Fc0AQr4JYXHmzUkwVT/ukgiUalP6IiNyxsvLIC
wr/Mm1SViPadle0SPAQJQwvxskXdLMY+jnaP1d3Q2lPVTNouoO0zJG1PqGLJnw93
Y86LvWggF/BUNt7OWBxQ93fgTjHahhJ9avVfgRpgTQGnd0eAVycFLy0K+j7aOq9O
SrgZv1VayVFJHJ8LM31uwLE1AWJSJAlYIWTkviCQ2lEXA7xNulEQcIoFnL0FTHNW
ChC22nf3t4XxebAzchmnheCaqzVpwFFhWJW7aNP5aWhcrmQ/3zq8efAHUU4vSoUi
MxAxckO7CSdK+vVP8Vbm86f8qQLYrHT6DXBReBnVmU5Lrb0QGnIVQgDKr53/+Slo
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PJwNlp8tEc3+2/t2raYy/sJXmpVJYkiQC8gbZKSFsFL/a3Vhiv8eddqLrkwFTgKV
UNE6PLTy2YxsY10uCWIswSrAcnp9tHR3oSsdXW129hgnTBIHMxuujPYcHhwh2Jp0
4S2CYsuBAV+PDp1nm/x91lEEkW46ekUd6nqGFKpB64g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3577      )
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
7vooZLobgCOaV6n4BLdwkw==
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZnCHDOM08ECQ0KW4I6pPy34/cuV1ZbKatN/NKXYnMo8sJse/Mg3HlgajDMmLlN/k
+ApHUDzbQZJNiXtxMDEYPU/kbVCDS6tjBDcUoOw3FLVYn+h47y9Tip9FSvfHMiSX
3FN4BOYULujbtkCZpblD4dE3OEZ2Tk4NkQVYedrnfqc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22784     )
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
8L4aXVUVhW3oIEu9jzaysQ==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AtIw5oQAaX2522h5d3voyXVT437F5I6BgZ65T3qRI1guFoWUbV5a1JXBU8bR7dhM
n6d0e5xzK9I5ef1KwequeF1i8GjXpb4dbxlMfHS2BB0HeJ7Mr9xVvOqNCHQXTagH
h/kigLCJ6WpnPu5TudzXd8nOxDs+I7xXAjFASRzrS0U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22867     )
xCJ9kas9WRXiayWvEmHT1PF+YvwOUHogw2s0dBBOb8SWTSjCIp2wRzo1hLSQ3Fwi
U3Q0bedqDaI3s+7nz6wkVurleGlJz8tS+lKevh+KUYdIXwXUoI39XSGwLgrJPgP7
`pragma protect end_protected
