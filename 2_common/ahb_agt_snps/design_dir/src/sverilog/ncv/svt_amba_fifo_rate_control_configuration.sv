//=======================================================================
// COPYRIGHT (C) 2020 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_amba_fifo_rate_control_configuration extends svt_fifo_rate_control_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The dynamic rate in MB/s of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   * This is dynamic because the rate is changed through the simulation
   * based on the contents of the array. Each rate is applied for a period
   * specified in the corresponding index in dynamic_rate_interval
   */
  rand int dynamic_rate[];

  /**
    * The period in ns for which a given value of dynamic_rate must be applied.
    * For example, if the value of dynamic_rate_interval[0] is 1000, the rate
    * as specified in dynamic_rate[0] will be applied for a period of 1000 ns
    */
  real dynamic_rate_interval[];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint amba_fifo_rate_control_valid_ranges {
    dynamic_rate.size() >= 0;
    // TBD
    //dynamic_rate.size() <= `SVT_AMBA_FIFO_MAX_DYNAMIC_RATE_ARRAY_SIZE;
    dynamic_rate.size() <= 32;
    foreach (dynamic_rate[i]){
      dynamic_rate[i] >= 0;
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_amba_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_amba_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_amba_fifo_rate_control_configuration)
  `svt_data_member_end(svt_amba_fifo_rate_control_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass:svt_amba_fifo_rate_control_configuration


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ixr3vdbZ+2c07U1IyciZvmK0HrvIynCAb3kywRZxpfpFrpi+1mnEl46Xj9UNjwm/
oa1gyZcDJMCSpgD0yPOPPobWTPvgOR67j0W5sKh01iaEi4hx1VqiTIcETx+1UQp9
YYLu17nfzw4VihBSqryVu9W6KER1NhOsJUJ23E9nSvFR50iOYwBXrg==
//pragma protect end_key_block
//pragma protect digest_block
Ai6F91T7925Nue1yBwPoPecOY9M=
//pragma protect end_digest_block
//pragma protect data_block
46T3XLPDtSviqzv6MwbpPj23pqzGPpwFVRtIppx8B1S28kGu3UlYrxdwOgN/S03/
tb/wWOUIerEgYkFKeHJFpNDdbBo8MXWa4K+O6ERkuCWIgTk/QtXu2xZP3q5g1G4l
zxSWfRmdYgWLoX8u7q6a+nxoygZW952ke83CsyNdptoYarxoKkwKGxwnnUiyNrF3
LGLwVuzTbEHwBlCXx9Th7CFuUlsKOpbX616Gck3gFaR3rEIcBtbWscqske6X9wwz
Qyu/EHBmN3osJIGsTH+gUuwLd0mNv19TyrBGVMroz2hTcMl49jcDJI2J5C06Bmow
tpLhNQkvzqpkPoOOJXfljLByOg3fIokuEuhqVtkvjF/puh+qS6g5C9P3MdKmjdts
WpURJbWmO+9Jd3brlON75T8cfLFOqf852BkK65J8bVj0DybB3vegru2itI7Xd2CM
IG3/10KTveOL1ZDudyUCRQhMW/sqw2bqpmcQYK9/JMpOOE0yrXsdL4qpblM4nT8l
GgdQ2rR4sfWW1aFAYrSqyWyFzpi+GxEHO8EiUy63YUk79MIYCLLxse8xriwgiS3f
ZRjCc34C3Is8wvylIhVY9HfbTYM6K3sT5nzq62rKoqA4/mERIiUJLMNtY2L6aKzs
/ySvLFG53jGpYxFDSIHSAZzaEMbTojoCi6AdZ1HdjZiStaOptIr/1PwX7e/R6CRs
P4Kjf4ZYdVp2FoNBm56xIyh+ppAoqffjMmea3FO0Rg/tJuC0SJPHU70BvIxU6pEf
aJ0NbN6ZnB3I0e4r67V8AAh5vzP2MsQV6fUuPpH4L/BiFJIlY2xb/v2UsPMN7llc
peowUm6LnUd/2SIWLkoK4Uh4CE9oH1hlhUo0TqwuY8SVKjO9SUqsBCku26iaJoU6
OFokT83/Zzem7Vpl5REJr+SE/kD9PY4jC4YG9qqNXVPfbX8DbNluhr8zOIQXuWpA
VImgWESS/1MrWrRNgC83tc8dzwSgCL8Noo1elwET7Tzuiqp4sd17uFtgsMv3f7tP
gbi/MVLycfe2LdYj8iwTNWyEoU4cAuUMQyYpZYTK3fYaerkArzs21otnDM33XZDY
7AxsIOyxL4HTmfuh4Huv/ZQ3xuAhZwjrYcAnBj4hj2+86ahaYXw/nZNl0f5ALG1a
bOsNt54v64onk4qefwKFLw==
//pragma protect end_data_block
//pragma protect digest_block
4duq7P+xjpGLj/UQ/GIszjWPonc=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
g6oz2Fup1Dnf6M9dCq32/lT0rcacY8+0PCPe3mdWWT3j2MpPkX8H16e3hR/TZi5d
6JhlB7uV61CaGRG/LokY10Slvq1EJNmuUp4JaMY+zqRl8LniaMKLJ2eIMc4u7YlV
Fg6X0i0KwXUT7ArFASOL+NymcKW2LHlLAfCmmKyGAm/SlOEmhP/RKA==
//pragma protect end_key_block
//pragma protect digest_block
jVppJUMgdVnzH88pimEffjSTLMo=
//pragma protect end_digest_block
//pragma protect data_block
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
wmYt53Zst2e4CMDdJdVwiw==
//pragma protect end_data_block
//pragma protect digest_block
jM4KRaBBfLqmWYUGMoD0HPDOhvU=
//pragma protect end_digest_block
//pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
