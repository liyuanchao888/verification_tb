
`ifndef GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV
`define GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV

typedef class svt_ahb_system_configuration;

/**
 * Slave configuration class contains configuration information which is applicable to
 * individual AHB slave components in the system component.
*/
class svt_ahb_slave_configuration extends svt_ahb_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
`ifndef __SVDOC__
  typedef virtual svt_ahb_slave_if AHB_SLAVE_IF;
`endif // __SVDOC__

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifndef __SVDOC__
  /** Port interface */
  AHB_SLAVE_IF slave_if;
`endif

  /** A reference to the system configuration */
  svt_ahb_system_configuration sys_cfg;

  /** 
  * Passive slave memory needs to be aware of the backdoor writes to memory.
  * Setting this configuration allows passive slave memory to be updated according to
  * HRDATA seen in the transaction coming from the slave. 
  *
  * <b>type:</b> Static
  */
  rand bit memory_update_for_read_xact_enable = 1;

  /**
   * This configuration attribute is used to accept the following scenario<br>
   *  Hburst >> SINGLE       ANY_VALID_BURST_TYPE<br>
   *  Htrans >> NSEQ1  IDLE  NSEQ2<br>
   *  Haddr  >> ADDR1  0000  ADDR2<br>
   *  Hready >> HIGH   LOW   HIGH<br>
   *  Hresp  >> OKAY   ERR   ERR<br>
   * This configuration attribute is applicable only under following setting<br>
   * - svt_ahb_system_configuration::error_response_policy is set to CONTINUE_ON_ERROR<br>
   * - svt_ahb_transaction::burst_type(for first transaction) = svt_ahb_transaction::SINGLE<br>
   * When set to 1, the active master drives new transaction during second cycle
   * of ERROR response. The address phase of the next transaction (NSEQ) commences
   * during this second cycle of ERROR response when HREADY is high. The slave
   * accepts this new transaction without flagging any checker error.<br>
   * By default the value is set to 0<br>
   * .
   */
  bit nseq_in_second_cycle_error_response_for_single_burst = 0;

  /**
   * This configuration attribute is currently applicable in AHB Lite mode and for active slave only.
   * It is used for the scenario in which the master design is analogus to both the AHB-VIP's error_response_policy, ABORT_ON_ERROR and 
   * CONTINUE_ON_ERROR in a single simulation.
   * Normally master does not behaves in this dual manner in single simulation.
   * User needs to set this variable for the active slave VIP, if their master
   * behavior is a mixed one as mentioned above.
   * To use this configuration user also need to set
   * master_error_response_policy of respective master to CONTINUE_ON_ERROR,
   * if not setting master_error_response_policy then set the error_response_policy in the
   * svt_ahb_system_configuration to CONTINUE_ON_ERROR.
   * Example Scenario:
   * CLOCK:    1           2            3
   * HBURST: SINGLE   ANY_VALID_BURST  
   * HTRANS: NSEQ          NSEQ        IDLE
   * HRESP : OKAY          ERROR       ERROR
   * .
   */
  bit both_continue_and_abort_on_error_resp_policy_from_master = 0;

/**
   * This configuration attribute is applicable in AHB Lite multilayer mode only.
   * When a multi-layer interconnect component is used in a multi-master system, 
   * it can terminate a burst so that another master can gain access to the slave.
   * The slave must terminate the burst from the original master and then respond 
   * appropriately to the new master if this occurs.
   * If the value of this variable is set to '1', the slave will wait to rebuild 
   * the aborted transaction. By default, the slave will not rebuild the transaction
   * aborted due to multilayer interconnect termination.
   */
  bit rebuild_after_multilayer_interconnect_termination = 0;
  
  /** @cond PRIVATE */   
  /** 
   * Enables the internal memory of the slave.
   * Write data is written into the internal memory and read data is driven based on
   * the contents of the memory. Reading and writing into slave memory requires
   * that sequence #svt_ahb_slave_memory_sequence is registered as default
   * sequence in the slave sequencer.
   *
   * <b>type:</b> Static
   */
  bit enable_mem = 1;
  
  /**
   * Used by the AHB slave model. This configuration parameter controls the values driven
   * on the response signal  by the AHB slave model when the slave is inactive,
   * that is when the AHB Slave is not selected.
   * When the model is selected again, valid values are driven on the output ports.
   */
   idle_val_enum resp_idle_value = INACTIVE_Z_VAL;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  /** @cond PRIVATE */
  /**
   * This attribute enables the slave to handle split response. When set to 1 slave can respond 
   * with HSPLIT response. 
   */
   rand bit split_enable = 0;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B2fMt3/Na2zyxG4z4Fwksom/1GJwvzOGS9m3dcqF2HUwWzBZKmGutYzJeKQtr575
aOYOTDFMM8z4Wfglg252MNoK5xO93esklBXlUhPjfEcFdWtY9gBwDVVv2nloO0pR
umZrR4mgFb8AC75ysYCpE+yVB7+qu/BtxMDSQ59KcUM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 891       )
4eof2eQdOQneU6TcGubPj31npf2/nSa4R8teEMaMe9ejyGbzTXswIuQxt2FcBjG/
nzLgBjxc6IsDWkzAx7dzMpHpwjWdH5TWQ6Xv+QM8tlHwKKoBHmALYvUJOUpKfh6b
aW9P/gfC+yzuXsMa8/KpBQIqBuVr5VPVmRkceAGanrq71Y9OQsbFbsMaJu/2AvBu
iGMDIZJgh2d0fIodS7LOHaEYK7obynxc8+kJu5oYuKfPryur+t5S02tqLpByDEW0
Gu4x8Mto6zWD4VebLxK4m/nfSUkhQjp5KTH0xlJTjYCRIyHz60qDes2Piqfmf0Ov
S75LJPNd9JxAue29VQ2TzJYHtFYS4bsB9mhiiCsyDs+1/UHmJsIENLkBsqfMjxWG
R8SNcAhPY2ouU2Qz6Yf5HwCAGq4O5bc9+S8C7cxsDk0H0ZpfDuOJkVOtp8t3qy0a
+uaUTbovk1YxpBNZQ1FIMhSia8sQXF1jGX2bRbscFPAHB7aG4iQRSFmm/VD1gS+f
Jpi3Wi0OKHDIb8rFpP3eAPREhjou1fnLq0JLHoamOFyjXq2SODTvCZtlneVB3z/a
gRd7R0G56nRJ21AppewQPV607JJg5nQ5T4VTi8QiObEoiUynSPAIDI1i3ZTwcVf1
oJtrtcEhYgwSTl7cPJ6PYy6duRaNkyfj9PNkT8jwxjjUPMjlMhwIY62d7GrFqhBL
tSF+MkQ+pTP/B83Du/LIW957PJIz+bLelhOqFXAq4bYERsk0eb2Li/6r1JhD4gh+
AwDt+n/LuBuBgdgL56yYFYtYJHcjRDIKm7Rkiyl+i6zwh0shhNvUBxmtb6OKpgRP
FEkA6e3yWedGbaCVlAIaQSbSvNwBzzXHuj6Qg8SdJS+yRJZO8sBhjpi4oEt5tZz8
0EhgGB6AYxmtBLZgZcf1/pXAJNQKykAys1bKt5PDcwbNhMqXqA/t+Vsf5I+5/F1u
Vs0W/uBZ64dCVm/92UB6ss3e+3wArFd3oqen2RAs/wBj18cQ7NjKmjCKLYYBzvLt
PusrBGqbx5pRMjtPnwPUjvpiSo7BMuuf4AgV150MVZRRxvJD1dEGkitJJm57jaee
WtHWwYN0pynQwWMgbagmhBmrJHpBA5nlS84WuyoNd+TKmQaFNXkh+7NwPDoWeLfl
+u4wr8h6V5EtyjiGaGV9jc14NhVBkaVt799Z5DawBrc=
`pragma protect end_protected

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_slave_configuration)
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   */
   extern function new (vmm_log log = null, AHB_SLAVE_IF slave_if = null);
`else
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
   extern function new (string name = "svt_ahb_slave_configuration", AHB_SLAVE_IF slave_if = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_ahb_slave_configuration)
    `svt_field_object(sys_cfg,`SVT_ALL_ON|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE,`SVT_HOW_REF)
    `svt_field_int(enable_mem, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(split_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(memory_update_for_read_xact_enable, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(both_continue_and_abort_on_error_resp_policy_from_master, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(nseq_in_second_cycle_error_response_for_single_burst, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_int(rebuild_after_multilayer_interconnect_termination, `SVT_NOCOPY|`SVT_ALL_ON|`SVT_BIN)
    `svt_field_enum    (idle_val_enum , resp_idle_value ,`SVT_NOCOPY|`SVT_ALL_ON)

  `svt_data_member_end(svt_ahb_slave_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  /** @cond PRIVATE */   
  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  /** @endcond */

  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  /**
   * Assigns a slave interface to this configuration.
   *
   * @param slave_if Interface for the AHB Port
   */
  extern function void set_slave_if(AHB_SLAVE_IF slave_if);

  /** @cond PRIVATE */   
`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`endif


`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else   
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
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

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
  
  /**
   * Does a basic validation of this configuration object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
  /** @endcond */

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_ahb_slave_configuration)
  `vmm_class_factory(svt_ahb_slave_configuration)
`endif
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PhQ/mMWnqH5VAUlioCZg0LnBd0RZybJwcZ6JRLSSp7Z+H7P5JXDrapk6JfZGHrzZ
h51Np9GeHqHJqIAwymCQjPwFTRfH/xCjh9p25vSgHfTPlb1NSbPvJRUeNMk8wVHo
/+/i/ZqqNF2QHlUdKxw8S72M7aKPVZOvp8lZ3wb/uyA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1526      )
WhOgmvyiKPZfT1aQT41QTzY9XMvny+jriVmRHn40zHi3kVbo1co7q3/tj3SxxssA
3SRxjsvnhrpCUXIwCLT0NaECePq0NsM0DHYv+fapVyclo/ukQ8qUE9wAT+e9DxxK
pHGBLduZaMBKr+K/W7RXVw1ZwJd9FgOKk4wR3RgqaRRNAMsm9OCh4fjj93Lpb++S
KVuZqne0gGRzf4aXh4dnkPshG0yfavE2ewjuNdG2PuItbzM3Y+ebK8I4sTebgC1I
Zo4fZW0LTQakvyLI6kMihgxpeTSlCQfuLVo+TcP2eneALzDNdfyk8kh8zzo1ZG0g
Aq6w61OK+c+VHSk8p39L+l0qre22w8hIyi3B4f1/R9Qbdl1LExgrMzYPhd0K3Ag9
99G5AQj/lkgYO7FFtMTKfaNOQpcchV3cX542xElFMMCvtGQ16WtmZQvB+0ZOcGd8
m0VWQoAYHkCIVNTbKxPpOvAeX8uef7qWzUJfR5+UCmDmtphnTbyo4DZavAhdLoSU
MNulYOdXEC8uvIWDtv77Io23tcTiJ6XsEx3kRV73cmS80dZd7h3jXC5yOAJPp7gx
CX/PK784ExHdFLbhqjKDfIwcSh7snzBwHso0Fn0Z/qvXgqYdnXb/1UsEQCZVNpxb
66QnXwEUKMoi5OsHUUCL0Z4z9aZFdN0rWrmYIslmIA+vn0K+XRjKPvo+NYSXJwsH
G8j2E3e0Xk84A6waEt8H88nxi8HHivnjv2YaefOzoA70MHOewllXefLWcmmYlXzT
Z+Y5MKzQgPaStj2hOCM0MEjKtFF7QbPrGCU7M6vA9mVp7ZJbFt2QJwHR2AnWBnYd
6muCEoNphsfRwQJgbv+CQg==
`pragma protect end_protected
 
// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F7pU4RU4vPkKwPqxQ0CCAO0TaB6d4QnchFrItSbHNGw63khIJTk17+Vj78m0ItDs
sajnACyUM6DBHs0I4/Iz/+wHRzYOlRBY7WVgWBaiolQfP6mOhL5pC/238/25bltF
kYHEL5qT3x8OSnj8jC/iCzZSoNieAWhdQdDir39iy84=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16732     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B7B0tVz/XhHj0pgtibdo6LitISzQT/EKKGItBLDICNjyGairR6K49f7X/BfLhjsA
yKxuwAR/Bd0k1jdQCVL9f655xqY5j8h6jXEvTSt524b2ZtO7JrrGBzxKh7myeOtC
viYSyQ0BH+0gzPCLLI3T0TcuxiEbpI2kTKrQSjgNPjo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16815     )
7BePttV+xAFJOSc8kWb5i9OvY44Q7HjnhNs2NNBwYWFMZM18BybaeLvCkJT8u+lC
CXbBUNEuR/MWx3lfdXZDQOcvuL9+msUB4nD6Fkzy4sOokFdIWN/sltE+KVg6WJ1s
`pragma protect end_protected
