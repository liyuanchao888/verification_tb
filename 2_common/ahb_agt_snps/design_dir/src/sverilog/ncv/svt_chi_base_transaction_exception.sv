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

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV

typedef class svt_chi_base_transaction;
 /** 
  * AMBA CHI Base Transaction Exception
 */
// =============================================================================

class svt_chi_base_transaction_exception extends svt_exception;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_chi_node_configuration cfg = null;

  /** Handle to the transaction to which this exception applies, available for use by constraints. */ 
  svt_chi_base_transaction xact = null;

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
  `svt_vmm_data_new(svt_chi_base_transaction_exception)
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
  extern function new(string name = "svt_chi_base_transaction_exception");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_base_transaction_exception)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(xact, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_DEEP|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_base_transaction_exception)



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
   * Allocates a new object of type svt_chi_base_transaction_exception.
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
  `vmm_typename(svt_chi_base_transaction_exception)
  `vmm_class_factory(svt_chi_base_transaction_exception)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HPwTb1S1879UE6cpzEYARjWwi+emwIVhYloZjnPYSQUo8lFy9MWoIGdyRcVoUjeX
3ZH/J9vRrbALwkqbsCRJhIDPO1eYu48jbOfdAPaW0a+6Aqr3RIAnPS5V5G1nlBGR
3dQFAucty4ny2f5I6wPthkBkJObYumrVWKj+BAHwVIqC9cbEm+jdww==
//pragma protect end_key_block
//pragma protect digest_block
lj+z30pr5k+t/p1AnMI1r0ZMbFY=
//pragma protect end_digest_block
//pragma protect data_block
03pM8yrnkD/cnBhJq6EKBavyXEpphLmQ/sUApJPBeQSumEVG3EPWcbGUfbN5anoT
zxI86Rs6B0azk/T0Zuym3kG1RUfhmn7h9ehy3RC0XcwO0MAofwXaMQgbq2q5s9vM
VQXdvXP8/nl6gv4bYXfXeD/BqAVKkkKO0BkWS0PlJyeYoKctp4kysvze8JkUykXl
Wr0BQ3SIUWFlmZyM17VfVecSqvXsiZVDYd1ekl8XVwaT3wFD9I2X93zVVeCw38+e
KyZcxcOUdF156LWKdgbUw1fV3NBgKpVaEa9h3a5oelvWFTHgUXPrzHOp4HsB2WtD
EWVsq/iC0gXhikicSi5KFTlE0Rdc0o0JEI36BEuiXqq6ucDx2BhmrWM1bu7aTm57
Xdc3BRUA4r1aOVGx5kdFDVEQAn65jHssUtRis8aEqHiSxzyzCqccbgtB2MAGUHoH
WEjMIx0TlyLT0rbWzhDbYv5hixAcbgJB29FxKYkhkShEZUbqXObhvvdI4qpT5fQl
3PqKkZr+VyaQJhKwxZpj6IIihrmqCx45sGsbBd4MaqKPgMGjr6+gfNqVphdv47wO
ilVr10KEnwbI1PzABzeVk3K5tQZROiYIwpSXZhOX4L/rCSygtE4kopuonD0JYzCf
o0DJ5IvglLD34O8x48UBCevoP3mYi2CeWndE+qOlCZ8+ive8G0SNzNhdyuhi+M76
wXTIQSrP+YSDt9TOQeCkSnZd0WMSYvyL27Zo2xg95J3TpdNFJcpvirAi5SmP3gTA
I7bxb4xHsLglcJ2fqe5IVdGA8HyeGFnUVyaLZL+Eqxl5f3w5iHHxdMxzBGIiQTs3
x6o2+NxcyD2V7i4kMkl00eLyU3p8hO1gxf7VLebvvkyVFe8y1tDxXYxde6zKMMkU
dwNugEwIgOIyJzhJcxts4NrkRuhtJah1L9O+fSFnLTTB1qhv9NnxKjSXIOtPzdXK
L6GjIDa0ifprk9IbmuEflhwF2sM6PNyFrkscI8ZXTiL1gLUQhiKxf9LFHa0X+3Eh
8Z958OsKlBvbDISM2NH77XpG+Kt9iyl4oRE5bHGBff8BhAQGRjGrk4TEFzttYUQI

//pragma protect end_data_block
//pragma protect digest_block
Ow1zJZpZWO4rDdabCnZNYv1rSEg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OdOuRWNGEqSF/Hks25DnlSyF+s5hI4qaqSzaFhq9zoLi7DIDJOFbBF8L2tUFWUMV
3Ybk5TaQCsE16jPKWax5Y6oDfdnsadkUCB56Td9lhWKDtHVaAJjlt2Y4LJy4xA/Z
g1mS2/MYrzttiokYqlVkx9sFKIVukp/PQ9Za+vS+epzZEP8hg7N0pA==
//pragma protect end_key_block
//pragma protect digest_block
LIVre3iEZhIM39lUNzBE7+IDWM0=
//pragma protect end_digest_block
//pragma protect data_block
BYWUFqacTz4bTjLPPB78j0GJ6B1Fwlm7l7F6wrnt3C8lyixhOqZ27JgydDTFWzJ7
tKyvoATdmbFR8wHWA+ZnyTqBeOUO/YdI60MBz/jN1CSHL0AoI8lJpu+OXaN5Nh71
5vYcKrF7O+RLeGo0uFQmFzfHk1bjKfsz0OcPMldBdoBc1QBgDxuO6JHIrc5yuKcl
TguOZ3PxscTSWSIBMmJlYV7UmfwZf2pNoklAHx7wHkqMDBfQnykwqLIoAhvrk/Q/
ouCUYgh5trqK0hRCG4o/fdJiKya08+VkWudZia2XW0p5PZvQArUlj+J06cESD3HB
E/hlCSugS+nEHxguTmVayqjOJR+dBYgYDIb73nAwZkoPgjRqFCSQPT7YnEE42zv+
LNM4A0A+97SEpYU6O9gN3PJxhY21n3X3hPbIetUnvjoFxIIfi0F+IikAP+L0HKGC
4iclicL3jgRFHsoJ+4W1us/u/TxZF6dUk1dnvMKPZZhEAupfrnB6+aSgzI1HW9L+
Bz+kJKkrmN2ND1wd25wZDcyruK7X6TptZGt+3NE7zQJnK0TqfgulJ4g8w0I+yWu+
zux2UXujUfGrFE1XfF/vcOOFXi6t/NbFBFw+cE0KCys=
//pragma protect end_data_block
//pragma protect digest_block
dO9UdcRs7D6pk4t8fkoMPK9Ikg4=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DpIXqMMsrcBBek/KZE4qYY4QpIiLbFw/1/X1t5VjWsemelnWI3ipDj0sSeYms6LE
HVnwpH/BUrFQMQtD5n08v5vAbKAc0uK0LXRXFPOjaOtjmJ39VBqzFw4d2Qc0/x37
ESTxFNdQf2GiNqiHPMnTvX2iPX2YERsxLoW/VYmaOHsxichd4GBLuw==
//pragma protect end_key_block
//pragma protect digest_block
+Iodr2Ls2kjpPDH1k6htuGiBpT0=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
ojwZXnvcZNfXFIi7BhtsPXuxP8E=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
T/8LQoSEQK/CghbXr3h0SI5h598oKTgw1fddDcvOZ2UwIc5wyPuefrkUllqsNn0h
/CQDXMyBsxYnKU2grvy1TUn0TabaagOh2hUycdhm19SslVcHTZ+zOGEvDs16ONbU
fibPdsqU24Juvojao/neWFcxeFHjFzgJ4+U+0yq4BoX9zI4gcZ+VIw==
//pragma protect end_key_block
//pragma protect digest_block
kd1wtSbx5mjzvm60pzQnzyaj+OU=
//pragma protect end_digest_block
//pragma protect data_block
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
cg62Kb2jYoZEUPQVQhQN6w==
//pragma protect end_data_block
//pragma protect digest_block
5Zri3uCkRfYFcxkaXE0664kY4ko=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV
