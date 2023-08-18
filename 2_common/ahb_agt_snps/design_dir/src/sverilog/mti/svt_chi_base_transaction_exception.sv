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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G/wsH+Gc1Ipo/QrvEL+ETB/5pKxfP3Vipy2dTDs1SpVeTx3PxXq92ZqVf67hM9Cz
GZVrZa8xkrCm3/4i3F4o/JxwWSq/faQYfaiftf1xQBstqzr7fmlkTB5ITfSPT7hA
jnX581yM4pyzc2NxR3I3qhuVm5zFOE8WQGL45Q3Eoo8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 642       )
PBj/Dm1J0kPCUep+6yuj7XbGyp4vjwiEVR+HM1QhixE+c3rrB80vwLEOgeOML9PM
f8zyBITvoHcB8eSqp0V9uKMi/jc7R69jjQ5DYSRqeRO6DwmEBdXGYSaFDZcKzfbE
PZRblowoCOu/FmVKWbnqTZkwVk8/s1XuIUkspMBMIcP/HoW39RgLdDDgrg6q6ZCN
WWEGjuJeSjWqTaCp7DqRznb9HoYsGSZLVwOXbR6qpmWFRVr5HBf2Rx/4Mrf4I7Rj
RNfH+LkNV+GSs41ld75kTeOT2xI6+d1O1geP7IQklM2vWvyLrh2gWWimXB10+tTG
nLCUEcnWpa+AKd3S+3/iDnobkL2nm2w4GRarQ71cvfZ/OUhrvgPpweVlST6dJwsb
kyxoQPimzpuZJGYIYExmsiOer7gxAaF7GW7L5absyJS3N1kMJYTXXLSQwqBTRJ0O
DqE01PvAB3jhNa9FhWeMSEJilDipeTRV6km2XaLsP5dVpMmacz2cFT6miklF0unB
pH35cLEo+Scwm5uHHgYN8a+iIZ1fA5SPFgZdLGSvWhbJFFi9DUX2uWrrDux7E7Rr
dnoQTvJl8yM5NOZnnoSBg0iytoCD8lJZi9s8RoQlZ4OUrk0xkBSYNzaiKtchx+Bl
J0+5NTxNvqSk/uowrhJ4oVPOtcGQM9fZPyElU/c07QMDj7zPbOa38k1I6v/oCG8e
cIqGeJSu6I966dD+wDzbgZV2AxuqUkVG22uTA18EdmRxeCh66M6UwiHjz15I39Yn
EqwVoQ+Cr+/X/y3UWjBheZL0+swG5/H5s4Cbh63G4ANyA+1S91xfPKWyuKedpfVi
8HpEa0EFH1G63g138HH404WcfO16MdJaZJy6w9NONLY=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U1c1P0MERyodWxxOUJ2cmlxEX/yiNgpE5LvOSuh4ybiBqGE9rC5BmekbOdlOxqsb
1rxcgIvt1+gXtPDd5IsDB4srjTPy6TemPW9BDxwNEznRe5rqeRAuYP4hqdeEOmyR
funNunMPo0OI3YLBmsNYabcWEHLqKQZl91VW+Koz1WI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 935       )
U3xggzk3AA9u8E4FJfboWaANwQcUEGgkc3bkMYJTkBVtr2foxxHIW+cuJiGgmzkE
QcP0rsJiY5lsnWbfqLcFY6RFVQoaj6IvIWHICllZviXQULpjwDd7I4fJjYyWLzsu
pmUuNi/uq6LYPzyCIzHnJcqt05cPNHwRZR4EqL+4r9SBuUBaecImkW9nxTw/0SV7
bO1C0urA0GBCRsFKi094vQBqmuG6wb04qCFbmhQFNLrx8D9jm2axEno0QZGAspzS
Nb820PL11UMqNWhhNFeXPckrj+DIu0QHqs7T/pLXAjAMoEHsahcR29Jk0FaML+ij
ueYff2TiB4YZbXeOoe2h2KbJggxU5AmIHvZOKq20puFDttrUNhUaNVITXVxQYv1w
cpH93Kh1jGm1KeHGXgt6Gg==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MFPepqJKlGT3GzsCUiv4A0yNKkAOOMkz0tZdyhQeKXTXm5UMntn9mWz00vfw+wfT
7oPFkMO2b1VKJ10RuOm37+Alz3hMQ8jke93oGWBRb2cEcTGXal9WnNNij7YbdbKr
SnRAnbRal7gRZKmy3+Eqa1l/owcXu7kMwOanej93epU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2963      )
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
5r1g5wmB887GkcXxoWtQ6g==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XYzrlY8/SDiZDwF3+UPw4AipIQhlb5+mjfz9XfyVHCAih9j3KjIWUWW9d97hu2uU
LTpeFsHPLYODyNO2QYNHk1q/weO7yLVYiJmwHT+HV8YQbxzq8qYgfEBnMtQwBmUN
IO8bN5SJ/0PZVaZ9GjJRoX7kwPxcIr5Cc1JRQbApJH4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13079     )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pLnro6+Unkr15ock+Vg61VIXmi8v29LP8vOFE9XXXqm39LJ1bK+NSj2B6VdGJFdj
jqlhaO87D4QgGb2fxrz2RX+hlz1h2hii3UmP2rBkZVXKYxY5J+BK47CSNlkrcAX2
syZc62OGbhzHTYyQhYKgPYs2lTvN4vaOtl2u0RBPaQk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13162     )
jK3IDEMNKbbHAm5Paphga8HOg9UlwGal3AKJcvGYCGkcl5Lsg2sVpZfuR2LoFfex
N36e2EicoF47/BiJI4V4JZwnslgPFghosGViNQkQIj3d2nJLuqNZt8R3r5pqrrwe
`pragma protect end_protected
