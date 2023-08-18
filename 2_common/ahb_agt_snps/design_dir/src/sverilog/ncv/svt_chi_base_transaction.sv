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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3a3B32UekdfVgqkPCsOUkty/vHMsKLj+UvRNr+cpZLwwSaDpbVCuYser5snlJpFv
eDEhnTpcbnD6bKv1//yO2QQWFiEN5vwWwywMWK2zAr3a4x6w1jjsJPokSARSomUI
pCTHcda/STMt/xOglmyhIXPrSaIDwxkk14KpUl8eOXF9BDfLXkDsBA==
//pragma protect end_key_block
//pragma protect digest_block
+yO+aSOJ5XEXNc/2gupVlPp7Qt4=
//pragma protect end_digest_block
//pragma protect data_block
PzDXrbdVapXvLA5+u9yUP6hZIkj8JgPZgLHYr9NAkDaWXIIrGu7SfjZx+EhAckxj
NsK6wE2WojMoW7c/GvQQ0LHoGi20ecuXoCS5fXUVZMsaPIXlEZjQDQKlNa8t+hOV
vN13dcHFno2W/blSSAC7wpZQlzZhKefPq35xKS/zTR9ZXNYQ1uMvY4wlM7b1hW5l
YWURMs6rH5QSQbuy8JtVAQ3VlI84ex887kag0oWwSfpp98UZsyywE7EaA5nsLVAk
eN7tR4ei1++zDl4dqavmTTQZQ9/2G/Xim/JNhnow7iyCGgL5p3hiCOmEzNVNB6hc
5Q3+6J8oYEBmbYVpeLXa6S50z7snEd8W1UDjw6h35HaggOPOACgDhWyrg/MOpZac
503jWoAWKwUDBVwczDD/y3eJ6B4Ug3DLmNSCWWZGs8r08h3/FZkBVppjt336/tAv
8guopXr3enI5JIvBgSP1xtcd+xnKl1EfUvCN4nba1EQ9nVGMSSnRYkiCs4kKWNud
PY/NJPmX6iuDjQ43HuHSGPVn8o/BqAYIVqSjy8ojE/a4C72LIIRCBRvg7ezNy1s6
IGr4u/Am3+vwEKms4PbXY8m/mwW04eVwxWTEg4p1iKo6lUUWwG8Gb2JKD7C/mC2u
5gz1+tyGwiEFFgrgg41iTvx6nR+T8QliyVkA/jmQW6ulR08xa8rwzQJMCAs8Xe1H
fnY8bnvbGYKdTxrg5PRIw7+wNx6zQIRdXvJglJQy4wRK4Jmx+8D07Sulhj7pp1yq
k638uBLpYZ6w/uopbvwHzFzF8JC3P2bEYGWGtASFE/+htdolBiv7dnbyrbAOtS/4
CUwh2NGTEoBFaN4PboQ/ECw/SGVHQEeCIgyAUu1LGLQ6uOJCwj2sch94ggxHn2A4
N5gqpMcft27BK6JXCpJ9HG1MPJ03YbUmJZmpH8WDO7kDUMwieh12q5sNs0xhz6er
fVoYgyFSbWxNDdrVcma7d8WTm1xBz22PaWBR0f4RrGedMSpJzJYLx+v2ppVxOnBJ
dwoaxL4XKyFwRnhXBLNIWsJkr24DHQvuFmGnJla/9IcwG4rRwDF++Lx5ej6uSPyR
vbEa0lZPcNqItzNeAeX/A5SJj+lI/i0vr2z/I++3M1Bq837020Aca4IsbB29EgGF
12bf8cE63lNZtRq8a2x0OPtxVBIz25Ak5ZHMa9+pHODzaak5g62Meos4k0YkZHGE
JuRJ6Hhj9hMriUmFNAhIkIwIwVKFJhD8Rnz2wSrdvlRuNXj7uPJOz1dovAQM5OKx
Jibl+LImgj7D2mjsZ6DTAfCERm5Izg10cVKiHmS4H3RMM1GbTdYPYNpZRCH0h/En
xZ2mJ9u3YbFihENSWBvFUeJMER2c7pBOUcBB7eC8LiZyTfSAANYhRRAbXBkOcBRb
rO8x113bcCfDTNPAqyxFZKlCGMFghlRSOJg8mk+uUv6jn7NaRyguaKkX9brNVBIx
gGtlmXDoXPLHVDtepfEvlVjY/2YyE6C2+vdNBcZocbpab/p1DRvNzvqyscs2qaEO
WtaYKcNHXyi8SSAbKtJ9jwe71XQcG3EvIAG19OOMl7vbA/66TC9WE7BUlCflIVe1
o2AlD5nlxFtVgClluOnUoKsNbcRw0p698cS/f+PeplFyrDTBdVzNf9sayXD7VATU
BvTYFZH5cG7xUqe42GNhsvPV6aOZi891beDRCOiehGIhhRx6nQqQW1M07Rw6CJP+
XATiOrXpwB17LEf3fkxo+A==
//pragma protect end_data_block
//pragma protect digest_block
m9Q+ERDGAnxtE99s2CfR7f7tnxY=
//pragma protect end_digest_block
//pragma protect end_protected
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ns8yZFz9ZDHXX2VKmeau+nRFJWbvzArzpN0S7JK8Xi9hQzvBMudFtMLzY3J+IdT/
FPiuksHNwmFvDWqbWKt30r/N6z3F8DtowBmMSTCWFGTdliG5lN6MIR0cA/2RMS29
Ygpxp7nScKRXdQ3EUu8VCNFGHu4/Gt6mI4wAi5V1D8EtOXJIZ13/vQ==
//pragma protect end_key_block
//pragma protect digest_block
+xqgvWfMONA3Ib92Dkn/sFQPMv0=
//pragma protect end_digest_block
//pragma protect data_block
DNrKByNiV2TgttvGyuet7FnkjGSSFi5lXOHLwX0e6hAwW5CGXcTXoHwql9EPJZlw
v9jD+lSYkop6ya5lJPTo6+J+OA8wQTtJGx8GzNhASrbNBMfWxfJWc6tKZnuHTQld
gNSEmVAx5CWd9sQBo33X51JFMfNZGGLXTcbT+PTNWPq/gtTQP8QiF4fck9tGS8HH
reRv4UznbO9RK+MmDndaj7Hh9mai31oak7uvU4vhOIYLN6uw/2fZxek2jS4Jplqd
X1qMTWcn1Mz4ri00wKku1FdzFov8tMiO4TcjtwSjHOrpHvUeiX/+wrNjfzqMVIvi
4n7Z8Eysyf31M1OlT8oFv8QgAxKE4hi1vCjRRkLPbXy5bwPMLnfxgBmg2UQm9JRk
K80rl6KDL9sK/jmsU6J5dd72mK1vz9v7tzxkM03zMyeewmyoLb+wBOBn9hapBMIP
MTSSnWMocZXLdMZWrJI1gztSX+FhyX9zTCz4lo6AYQAE/MW8WP+Ny8Dr4TA34VVn
mKyvbMR7ExaeAcnMBhpThZPYsKUgP0Mv4utu9vNIYP+D/LJ+vgHdY6YiCX8mZXTh
Tcw++dScQq1/nUO46s+3tg==
//pragma protect end_data_block
//pragma protect digest_block
KXq8/xMrKSFgVv3cpYgUMWjyXAI=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KLxhwWr72m4r11TlFXwWJFJCrcIfjuXQlEPhA5VVx5fo9DghX1jByUsJvPfQGwFl
frTG45QTMuoFW9pumk10+NGK+BjZpvomHVFTct2Ebgmz48XdvUSSsmlG3A1SXVIu
+Y0KH7Dmp4LZHwTcq7rBUgR6DLfKNYng9CY1eqsoyqKBKP0m2PhJwA==
//pragma protect end_key_block
//pragma protect digest_block
tCTlqrUH/WNjbzU4siecKfPchCs=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
p2Ywz9tFQowv5yvS1QJFv2HN9wU=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KX75dc0cNOgVfnhqd9FNgKyNovDUg2/ykUfsALVO1Edi5dHu6rI+05NZ99xVQfZJ
7+IIjIfybllhAoCr9ajOhRQ9Wqp+393JoP4Kh8+dF5/rfoLytUIMOItZAjLaVbVh
Tv+5kn03No0QZ3UmjDBFykFEPEDs+/c08PBgyMH1lcWJ7N46HVP2gA==
//pragma protect end_key_block
//pragma protect digest_block
FroGh2CUWqNEoIes5YtsrmJ3PxA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
6TyBMnnN0ROfJ1eLtWwy4WCSczs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_SV
