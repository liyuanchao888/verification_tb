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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TzeUmcT6tjxWIXvS18AitYyO/ZnWa0Hx5y5IVZJ0j/+hiw8q18TckJBQEqLgs0+o
0mcxd8gjx36whaWz3uMk5uwZY/vejouraCYtlF5lipTic+K3Hz9OvtuapyghpzHI
nQQJ2ImbRDKCgTABxzZtMQvqEUdsxdiuS0lk5BmLCUI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 708       )
ssPJV7BB+LgLIyX0fIMAnt2fOUWu/Gu7M4UTpM1/1dmdm0FzP7S6atWY6t6TBiRM
re2hlJgE9ZbdpbnpdcAzHs0qpXuhkja/vT6pGJk/3zDFCKhQrLj7jf8myEh9OmJy
fGsAOYhsCwIoK8opN008JtiegJ+umarGFo7HcwGlwpaoRNP2RL8PgEkmoX+4GGlP
lLBwvmHwhJ+uzlCiUUz0Xee56aNXFgqMLATSTrk8aA1aV/HgczGt6p88XbRgff02
tCP+0KYh1m9Aei/NDGKVxv2yNY9dTSAunXyNtXhPg0R9UhPi8ks0LnivKKQyIbGp
N762TIqEaY9nXXWhw34TWHOOtBfz8bxqgmWzikaP6/us7f4FAoiPhmIaaATi0S5k
RvxokyoT4VwdXh9rPaF62WR3n4mixiGA7dc6ABxISXcjf5EAlKIlcfnVTqaELTBt
GqNOVgdrGm6DoGSF0grWJm1M4focIY1265/mkZ2E0atlr0npBnazeLoEFj4R55JG
3qfhHo2gN3tQSfJ1EUnsCPoSZOBm7DVoWUsWMCyIi+XvLLLuE6hd1eytiQNN2JkP
nTdZ6yY6NICkG251EBH8Yv2sAzLDslMPrKQh2SPP6u0GLs95Nqla2vUOPrY7Mkef
MbDphRBPV9B+kUdDPJGdytkEkVQjqwNRGvGylvOXwI1TeHdyZr7HxK2oe1H1/rKk
3SrO+yfEzq52Bz+K1d+jS/d4mlhK5c0cDz4MXbtr6emAVRyBOzEADgRCKFIqxUA6
LUXkO3dfc6qwFCBjZJ3n8D0x2gjIi1vfQAoQVYiYnsHwNGJFHsZtUhnH3HReV3Ol
fMNiQqGGOrfBAZ72XfVzIrPa9YvXrZIb6e6JjfmrWszZMkfgTCjhlNEYJsfj2RLy
g5mBBEPhiOeZRubJg7mc8gGlLhEz/w1kTOQ4ZmXqqLfiCtvtUgqcGKyCDhfxJYFt
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fjcLaUbC9J8zaPeo4iXiBMCFqmx4eLM1UqasQ1yYRO8tdvbpdN6CuEhrEKkR6Ftu
Bh7cvll27ltsHlQsPPRDaCzLKu535joFKij3cUtHnR3mxhha2irVEQEoziBSnO1k
FGAUeFRzj5nm7GtREZrq9pSEa0ST7wtB8YiJZeQ4lck=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14224     )
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
`pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_AMBA_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XHhiajeNETsPGPZdi1d35Z4S5ZddcTD9VN85LQgGa+V2Xir9SaorEXJXWPiWMVRs
ntdIfv+Fcw+148mmU46gcHnDkK2ck10dHiVmG0Px8jvkYH7lgV8JQ0UACu+d0UMc
g3Fe0Nqg5eY6GsDfIqcgfuG/foG8sHEHKrk3Uuu6uCc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14307     )
MyqHgeNyh6x1nxyT0jWZ+HeWDRdYgMFC6oPLaFikZSf+WZ6a5dWe05MMz/5eB2Mk
hJuSLWZEQWjIcd009Tuc5oZrjnv7aVq/BGTN753l48svYhz5B34oY3BNjCKmJvfH
`pragma protect end_protected
