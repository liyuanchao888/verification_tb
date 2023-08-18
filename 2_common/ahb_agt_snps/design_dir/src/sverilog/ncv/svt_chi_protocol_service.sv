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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
msbOeJDy429McAPosIubrShoP1OiHVXNqGfYHQM+9epihpFVDcmpBUFqP8zQZv4O
SHEUi/JLLMATsFCfN8v9032a9G6KTF9nF4h0TXbWLTTxwQtqxOzxHh1T8RE76i3H
iQxPxQSzqQNIqLAyfu3tK9VAG7JGFisAXcSTdNhE8Moy020p8eU0sw==
//pragma protect end_key_block
//pragma protect digest_block
cqmt2F51SZ9dikpIxXIoaB2JW/E=
//pragma protect end_digest_block
//pragma protect data_block
23K/GwIaL8Kz95r8+U3MOywIVZlOeCMLWvRsR4z5VHbUkuUDtAMSRuD77gTHJ3z3
44mAWMujHbRcE9SIhnEikX6el1jFn7KyxIW0oavvlDnukVYJH+ly1xHkYqP6KOFg
B/8QgI3Cy7eqJmsTvk3SCpE/dTqO8hvkb4oUbrGppoOSsv9R17tlc0w1zP7iJttd
dtOKIh/QrxXWV44dIAVj4ZxjwRj/TeLN8pHK2taUW8+Vh7NXgJjV5az3l5UY7LKt
tu/eMKmGBs/6+Fpkvl9x6QPLbl4G4Pb9QHJ8AQUgRl8sbBPh+x8HmHLApLipHMVX
Wb373Evwx4uuST38T/8AeUHDMDk9RUDSHRvGrletuvvs6YJOiDml2IFTR8Kj3n8O
hZ1yngsSzk+mYtu7WwdhC96ALoZ6v6XCS86PWBE8DEebWzK8UfKf4p39Oteh3fdT
BnML5YDHsgZQqH2do1ydUWGzgKbdtNn/s3vg7TzCUmY0MMDuq6TvZu8/ssAVcbD+
+R/yhm0wdzVw/qc102rojN3Sf+AQiGqiLL8u7iqtnS0oOsLKoXUtjeYW2vqFQdIg
Zk+LKnVZWBNQTwjofaOHeGXpXdMeDBhGeFamTh0L4tCR11wawOwWrIDOnuaD40bw
qCDCGuRZcw5Fw82xg0mDC129bv/I33qLEMDWFgn8PWsrNrxSZzJOAWHvCHNs599q
F0/qryKdbFHER7CEV8hgYLBB03HARRgch6w5iQedgLuT6sS7cErvRmEjrzvrfIeI
/Xenr73JlxFiLisQxWEiMvYWVEV0YuoB4yJHGs+dcICXNP2xMZeqIZSEGWNuzvmn
ggSAZ+mGQhY5vKpK2DZKp0+NVDOHFOc+e4CbaSd9lHmZkca7F4w76LH8cbDkW1pD
27c+tGylR+aWEWr+4vzzEydd7Ex/Z5qNy49+Unub+AMw7B9wiJyWSo3/X+/ymDdF
r9+cq2C72f80sIq2lDsg2R9wCRSL6pHXRicFaL9X/802mkmAJ0b3MSPcbWKL8p2F
71ViP4DW8jyB551zEMbFm9sY17NhoYRIckhj7leBtO8re5jJv838BIiLwQN3jWYY
bsSR2JEHAjikbw6Zgp+YWvDBMJYo+BzZOwfA6iznod7YdSx2sVMX8ExhfG1c4cPX
lQn6Fmnm1Vk/Cp2nsMv0Ih4nI/B/ucMSGNBWxPCZQVJ9X4ClGC9uCwuRD3JmPKwM
9XT2BtHafrmXe8SAXEptMBeav1yhuSh+N2W/CKntcfWSEK+oWi42qrY3BKk64+Ea
3l5pfFDHx400mHKwbiv4oDSd14OpM0fwX/Dd6uFgz8tEMdr80Br5xhx7Vy7MvBfy
0ZUUUNUO3TpeOTwv+oiO3vOxAq+Bj4HlZXWARdutGiab7YmbdOy6FoILx3YwyXu9
6gmBpp1HjHuZQFsmwfYqi2cszvXmxUc93SqoUl+qyeryLCOkCMFwfjHuIJyeasAo
Y9VR0Vxrfjr5JG95fjFOsA==
//pragma protect end_data_block
//pragma protect digest_block
jjWRVU2ONKLnPCgmsVaphFsEwn8=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_chi_protocol_service::pre_randomize();
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lr+CKFlZ2Tqz9XgxwgrFck6FUVwa3Cth2i60J28R/fiF+Wl2ME+Xmo11+VXiw4Lp
K21xCna5FUe/CaXXtqxANkky/NmNVuLUQYsHd/IKaZ7hhnTs5swp8BAoww3mR1RM
M3CIuU7HSmWEbpSdvQa3QTyZUETFLFVOowkasM9xp7+2dHrikHOqaA==
//pragma protect end_key_block
//pragma protect digest_block
ar+mlvR9MM+pQPqJH8Am3Hhbpbg=
//pragma protect end_digest_block
//pragma protect data_block
Ue6X/o6q3RWv32Kayoi7Ii/7oVP0lxBluhD/ZpGbpkomsFd9X5Cl/arsZLMLvTi+
/z0h3LHNE5KIetAKxjV13VvDpMBie5NamaEDTvhwIT4w8s1jhK5K90q03p8Pe28l
de2qW8JJp+JzmAMNb1Ymb5dejfY1NTHCZzPzOGo8IUev5LaBm4kaxqSsgEJS4rNQ
9IsrEFKXCrPOHbkgtMEtEhWf+ILuUXUjuo2zuEZocFoKDZmNwQ/XFAi01IwXh5pI
LRjwmpdCn6rlPzDpN3jwM/Iogqstha/VN1VqNOIOLx+MOQBQjy/RZEF4ZOrQg+4D
Dhe0FB+tHpLY2mAozUHCGa7qXqlDBpW7dMjJt8Tg2eIKAET7UMayAYbxn558BA3Q
vPSU1xYdAwC8OTt/7vFkGtnYyUbkdgCueQcoD9FxiKQQawc8v1fjAeueySyciaPo
bihR5tLbWsS1umiBjq7dTHo1ybRuQsGW3it23zKmqGSumQbfWZp5vGtOVVZdIkf5
huHOWDlI9BO/rNJKX1ZCiXoXIqppAEYs5tSKP3rrWvJPRs0FWzw8SokPhVtExVJ/
GJ7FtVzquysqpnnoSEZ5LWnt4iizSCzpU4g2MCb+THXGZ4Wym6DmlJQmen47g1wF
wXfaOL2Dcrl/gDgLkVxAMSEJ+GSQHyLXKA6vFOLsIFU=
//pragma protect end_data_block
//pragma protect digest_block
q/vobUO1j2u6bx0XqSZmKQZS7tA=
//pragma protect end_digest_block
//pragma protect end_protected
endfunction

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/fn3+RTu/PkMwiovLo2OxPdflxxkNrRv2B3yEKl0DCpkrSC8IbKK//VDP6m75NyU
EOJKwlnahnrsrSGYy5jPLExCzvDOtR6je2bcm4dyLuBInGGK8kQIkZHgNqIqZesC
XSnRq5J6Qc5YJQ/fwywi6oD/eIJQKLCGIH5In5GIXRMiFROek+AD6Q==
//pragma protect end_key_block
//pragma protect digest_block
bHrmBx9Wu4dMpPfN3d57uNwIEOY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
EEbc1E1eIAaq+Uzyz+9ewAh+hrA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_PROTOCOL_SERVICE_SV
