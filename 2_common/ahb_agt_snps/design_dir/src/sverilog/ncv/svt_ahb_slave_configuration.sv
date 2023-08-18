
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pxYgW0RzqCsYJpGLmr7OIifAgWmoaBX0+OuHSz4pNrRxi+eLsw51aUQrhcVVtFCY
uRcatobLB8Macc6g+InkAWRoMxoVRh/Gk8aP6AJ2mY4/ZKnMtUjy4lEzGuGZhjBw
UUertvX9kamVB+PxEzn9SUvcHbn1vd24/pArQI+2EOnWmnQyJI6Xfg==
//pragma protect end_key_block
//pragma protect digest_block
W3QPLPQSgznzhHh30GwHcAroA+Y=
//pragma protect end_digest_block
//pragma protect data_block
Hdlkz+/4ZoGgcoXrk8iPM55UzW76lTGNpu7f2nykB0xs/ixiMI1cemFxSJx5HO8S
aJ3MR2iUuJDO5iJlnCYvDzN6KMEf31uta2rAGpXlNhuZ/M/l5y/nl6k1+DtQVZMG
dVg8MkcROeYmNVz2pXJtO/7XcEjJ995YZjVxUvVL+8hMy7zwidLQPMQRf6EjiJZp
j7CcVTOvlZ7RMdBGvA6hErTowXDVxw0VTfZCyzDOkuNmTaqnNBhpl9Ci6el3i741
xwWuPiwn4MQp7BDU28vDtwnrGhPf621EdpoZtNvq9ZSB5xOH1/jambG5Pq+oPqFt
OfJPOUvuwRdhln81goYiBoKsBXZV8gPb7iO70xi8u26HsLU86vDdJuzPA9gH+JB+
YDoJ2ilTgHMMmOLKq9eFNCTKKQUycV54yiHu6taIr6yaZJ5kVooyH9thji27GN1S
iysK+EAqs5lf3WL6wTQ4gQvVrQmA5g8i9i+rQyN1zd8finkEwb/fblciricnx5sy
7Df1oSZEoDGi7VY2/Ptg5+mGxTaz7lKA4KRjb2EMUZP27Cc0luAWfL6F3Kurn3qg
uVvwpbj8gKDoBOCxqJgBd24mMI1Uhdn/diRjtL4HD3Mfleu7md1p+TWS8JLNYlKk
Y8XMEVa68pc5gXf4fai5zuIkSNqkJ9t1716GV2PwWE38wP3FJyI+opTh1McFNnZ8
tV8tAaTeSwjyQ2F9VFcIjrvcx6DCQ9icQzMrAIAK9dKwEnnURKdpqCEH7BAb4uRq
HHL4NEVCTPfbG7QFuwxPOSn6nQpRBMR6ojIhYQX8scavOBtFlOnvLuPhihb7ygH7
2c2PpbUALH9155DC9jGcYt0SrVRdvZxytouLyYWKrLvVv0luGDTK/viFS9pJcLuE
VVoajx7fFmW/0BPkzrqyWdrqfi+X7SCiuaoKf4JkdD+sW69NqCJUg/akJ+sffGT2
B+i8p/Ng+6b8+iWuPTqchdcN5R9bHcrbOt88IZk63Zjcyvm1Y42kU4gQ9swpouTf
bT733xFgNc39/RGXZlwTL0bFNxjxQ+rCkAJqW7EjgOvc9nGJJYjdIoAbEtkIV4a7
Ykri5DHgW5LBmvInc6AEP2DRBAK8lJETCXoyijuWcU40IXbCmp8vUVD/DeYzqN3J
cXp1NG7iw2FGrdnDfYq5XGS8/S0zQS3pv2u+eU2o2qWHjhldCI1VUqQU3/K/tznn
uLRJ7M/pjXLfzXhCGBIGC7ba2rtLPcOcn3ByBLMl/cU5pbTbNEYo+IIZWqDazkA/
dZB/LB0mbt8H73BCqeCS1BcPRpYgCCViaBmhCZL6p33NxSeMHUlXyegBLBaS1nFT
QYucd8p9nC6QBCzIZ0PguR0m6BFep3xT6s0WxxiojP1kJLMH1Hz9A/yLEhxX8Y/+

//pragma protect end_data_block
//pragma protect digest_block
m6pUTDrIW2pdjDbu2ApE+n4rHxY=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ulnDe63e+zwKgsi8JZfSfYD0Sb+u0VUqMW+VgnRySHjQl6E+ykck8brJzwgIm4Y2
Y3g8L3FKRlKRPGfUp7nBsM+M8yeYnLXOOf8HGwkd0qS4GbdFQiiRYXoQirTxNruc
WDynKJKQABdDfGFu+SzA/+FeE1gS2MK8pdWk1lE1wfqs4Ay870SdkA==
//pragma protect end_key_block
//pragma protect digest_block
6XoxMgDuhVyGqdXlHtZHfbgFB78=
//pragma protect end_digest_block
//pragma protect data_block
UV8jmFA2Gy1aRcPpj013deyRpD3X+AqHcatKFJiT4JX5DXOT3vVsnXibXS4DkEyb
N+03TY9d2BYx/OA812fRj+pYfQ2CWLqJNUEMzE5K7zNxyG+5669SFIiVlJwtyfcA
j16WcV173bK21+riplfcnSz9bxrcpX0ZlWuEyczZqK1jM/k+GAOSIDem3F0Rflw/
zrUzwNggGeeCuCmm04jLbvnu8JUV1qBK2In+TlEPnp4qAMVlXUA1vduzWVWC0Vqh
vtAc8UWxIah/xS6xFUTj2QZQKastTYoSEw+Svdne1YxYhsQS6ccxLLlQ5GWhRrSv
zgfFsqrHT1YZ516EtOu6pZMLg58bJj1i41c7z7wv684nmkshJwcnPHvZLNvzunGA
fSvLmxc/ErHHc0m/coL3NbI7sLU+UAN7QI65A98/xuzSyo/5pgP1SAdWAbOZbTrc
gZJ6f1e8aCcPovNMKNIwgZgSBjYUTfxLOhLjSk0tGq6RC5wYVzvuhVhAVq2U8xF6
1vj8eiuhrm9OHNWGhS6SNq1QihBoZkAfT4SW9D9+qLusEEDJeVMXEWRha6Mozw/t
LFVJwlgnQ0R171MVt50OUrGueTDuokSUZeFqW3cu9TZXgfDrJwUuXQuQpBD8RJzl
tvmTkUY4iuxp8zoqcxIWtLazRI6UvpYjw9Q9A1JIjXu+8j/nTywovE+l2mhrNwE4
kcvgcZoxvmRHOkgxaPKcSQnfKq3cQ67ktuOa9E20qIsphw4nf+IrWfO0wmuadsas
KdXY61uBB/vmPQGlq+CD5pWmGmWb5ReFQUtSNjZIG72S7ckkcNkaVCFyEW8MGRrb
5sngq4PeNpPyWb1fzn3DJLsgbR0UOH+1+0JoLHdzQl0IxazBq3v7tYU5xLPENmDn
/PSryr9VNfORXa8zi5uQORL8/wlI/9evPFzKTR/qs89q/tvPu5xo2IW2omtI+fol
hM7IhAD0yMBYPDffksslSTY/HR8xkwEkAP5pn5/4dzlY7EDQ4bbOtuLrM/khKC9/
+vYybEGguQP+ZerJ2nyZS8Gwb2K34SXI4J7B3IFc08s=
//pragma protect end_data_block
//pragma protect digest_block
Q5qGbm3Ei8xHmBPPFZShbuNQnA0=
//pragma protect end_digest_block
//pragma protect end_protected
 
// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2N8S73VKWEgc/kY/9Joxt7qYc3D1369zCNxeBQAG+WBVvVrETMea2nbV1twBC1X4
LT/eCXPcyLUWYvq2gUk3drGMkovvtCwdenXx0XpNWjV7wgOm9SiZG9zZxhiBgbAS
vG1oLcmPUIHoX0BIM7bQ5/9G0gKDO9PqUHzETdgmEo68hFBOzLWriA==
//pragma protect end_key_block
//pragma protect digest_block
qFjFOwdTXupJygBLeuCUK3QGdiM=
//pragma protect end_digest_block
//pragma protect data_block
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
N34DGAyzvdJZlamXcZ2GAg==
//pragma protect end_data_block
//pragma protect digest_block
OUB5uiaw++XHjNm9PXsZV6aF3g8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_CONFIGURATION_SV
