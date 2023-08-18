//--------------------------------------------------------------------------
// COPYRIGHT (C) 2018 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_STATUS_SV
`define GUARD_SVT_CHI_STATUS_SV

typedef class svt_chi_hn_status;
  
// =============================================================================
/**
 *  This is the Chi VIP 'top level' status class used by RN, SN agents(UVM)/groups(VMM).
 */
class svt_chi_status extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /** Represents the combination of TXSACTIVE and RXSACTIVE signals. */
  typedef enum {
    TXSACTIVE_LOW_RXSACTIVE_LOW   = 0,
    TXSACTIVE_LOW_RXSACTIVE_HIGH  = 1,
    TXSACTIVE_HIGH_RXSACTIVE_LOW  = 2,
    TXSACTIVE_HIGH_RXSACTIVE_HIGH = 3
  } txsactive_rxsactive_enum;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  
  /** Represents the states of the SYSCO Interface state machine. */
  typedef enum  {
    COHERENCY_DISABLED_STATE   = `SVT_CHI_COHERENCY_DISABLED_STATE,
    COHERENCY_CONNECT_STATE    = `SVT_CHI_COHERENCY_CONNECT_STATE,
    COHERENCY_ENABLED_STATE    = `SVT_CHI_COHERENCY_ENABLED_STATE,
    COHERENCY_DISCONNECT_STATE = `SVT_CHI_COHERENCY_DISCONNECT_STATE
  } sysco_interface_state_enum;
  
  /** @cond PRIVATE */
  /** Represents the coherency phase. */
  typedef enum {
    NOP = 0,
    INITIATE_COHERENCY_ENTRY   = 1,
    INITIATE_COHERENCY_EXIT    = 2, 
    ENTER_COHERENCY_DISCONNECT = 3, 
    ENTER_COHERENCY_DISABLED   = 4 
  } coherency_phase_enum;
  /** @endcond */

`endif

  
  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Property to define TXSACTIVE and RXSACTIVE signals value. */
  txsactive_rxsactive_enum txsactive_rxsactive;
  
`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** Represents the state of the SYSCO Interface. */
  sysco_interface_state_enum sysco_interface_state;
  
  /** @cond PRIVATE */
  /** 
   * Represents the phases of the sysco coherency. 
   * Phases:
   * - NOP: No Operation. 
   * - INITIATE_COHERENCY_ENTRY  : When there is need to enter coherency enabled state, initiated by RN by asserting SYSCOREQ signal.
   * - INITIATE_COHERENCY_EXIT   : When there is need to exit the coherency enabled state.
   * - ENTER_COHERENCY_DISCONNECT: When the sysco interface state has to be moved from COHERENCY_ENABLED state to COHERENCY_DISCONNECT state by deasserting SYSCOREQ signal.
   * - ENTER_COHERENCY_DISABLED  : When the sysco interface state has to be moved from COHERENCY_DISCONNECT state to COHERENCY_DISABLED state, initaited by IC-RN by deasserting SYSCOACK signal.
   * . 
   */
  coherency_phase_enum coherency_phase;
  /** @endcond */
`endif


  /**
   * Updated by the link layer, this event is triggered when reset the reset
   * signal is asserted.
   */
  event reset_received;

  /**
   * Updated by the link layer, this property indicates that reset is currently
   * in progress (the reset signal is asserted).
   */
  bit is_reset_active = 0;

  /** @cond PRIVATE */

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in DEACTIVATE state.
   */
  bit accumulated_lcrd_tx_deact = 0;

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in STOP state.
   */
  bit accumulated_lcrd_tx_stop = 0;

  /** 
   * Flag that indicates that RX state machine in DEACTIVATE state has
   * accumulated all the l-credits while TX state machine in RUN state.
   */
  bit accumulated_lcrd_tx_run = 0;

  /** 
   * Flag that indicates that TX state has been changed because of assertion
   * or deassertion of TXLINKACTIVEREQ.
   */
  bit tx_state_transition = 0;

  /** 
   * Flag that indicates that RX state has been changed because of assertion
   * or deassertion of RXLINKACTIVEACK.
   */
  bit rx_state_transition = 0;

  /** 
   * Flag that indicates that TX state machine has returned all the l-credits.
   */
  bit returned_lcrds = 0;

  /** @endcond */

  /**
   * Updated by the link layer, this property indicates that at least one reset
   * transition has been observed.
   */
  bit reset_transition_observed = 0;

  /**
   * Updated by the link layer, this property Indicates that the link activation
   * sequence is complete and the link is active.
   */
  bit is_link_active = 0;

  /**
   * Records the simulation time when the TXLA state machine transitions to TXLA_RUN state.
   */
  realtime txla_run_state_time = 0;

  /**
   * Records the simulation time when the RXLA state machine transitions to RXLA_RUN state.
   */
  realtime rxla_run_state_time = 0;

  /**
   * Updated by the protocol layer for active components and the link layer for
   * passive components, this property reflects the value of the TXSACTIVE signal.
   */
  bit txsactive = 0;

  /**
   * Updated by the link layer, this property reflects the value of the RXSACTIVE
   * signal.
   */
  bit rxsactive = 0;

  /**
   * Protocol Status object. Contains information related to the protocol layer.
   * Refer to the documentation of #svt_chi_protocol_status class for more details. <br>
   */
  svt_chi_protocol_status prot_status;
 
  /** @cond PRIVATE */
  /**
   * Status of the HNs that the RN/SN node is interacting with. Refer to the 
   * documentation of #svt_chi_hn_status class for more details. <br>
   * This is currently unsupported.
   */
  svt_chi_hn_status hn_status[];
  
  /**
   * Link Status object. Contains information related to the link layer.
   * Refer to the documentation of #svt_chi_link_status class for more details. <br>
   * This is currently not used.
   */
  svt_chi_link_status link_status;
  /** @endcond */
  
  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_status)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_chi_status");
`endif
  /** @endcond */
  
  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_status)
    `svt_field_array_object(hn_status, `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_UVM_NOPACK|`SVT_NOPRINT, `SVT_HOW_DEEP)
    `svt_field_object(prot_status, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
    `svt_field_object(link_status, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_status)


  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_status.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

`ifndef SVT_VMM_TECHNOLOGY
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
  /** 
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
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
  extern virtual function svt_pattern do_allocate_pattern();

 // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_status)
  `vmm_class_factory(svt_chi_status)
`endif

  /** @endcond */
  
  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mxgSzjCt3S3sh4iU2MCdFD5//P+JRorNCPKByNACZRfdV8sMgK++jYl2m/nu0CKi
lFI+twNJu4MTWsZOzdVDssY930MnTPIptPY8SeGhEeW0s+/BdIklkqaUJSv070cI
mT/EB6ydFFsPpRMKlxJy4ble8H4dU+P0+Ha5Ap4vCEo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 605       )
c8OpqVkIi5A2QPCkhNMwVxHCniqSssmQTaY2G+d9z7nucyuRYiHpH2Ueb1jquMvJ
SY9jSV0v0TfTj/+x3gCzvTdGD9GVvsP4WtEQ6NVjyrHmG9/lJLTEpYGi0B4Psd4N
kV3jKOQumA2tcYSYDrtoph+8LEmhDBQDxO4uDuBaez6d4N5xIXDb873FfXtq49yj
4NB9OBfouPhQN1tlCkB0NhFsFTagQ+/B0cxRu9gf7mn3GpecgkiEOOF5HkNHKlK1
uhyvvW7KL8NfW3aWwztXEwBJ9gkaDjXDkOeQtRp3VR/yFpqagD73waAUjibNufsj
f+hlYdmf2zbbyAsKmsWyF+CzgJCYkOH8h5YorUMTZ75xoJX585STA3WZxKDLiseI
cqalJd76Uk8oCa4UoO7SFIZ3dbgYFurHRbUHHmSU3RNFMeSb5M4a4/0J3yCoQPJ9
S/7ZmMi2/CaFb5rA9J9ovGat7S1L4SpPFf75ZNLkP2+Esx3YEBzNwNCn3aANsf2L
9ETRFiIS6b5JIyIlP9e7ooN7oWticv8NnZ6JN3pVVk8Zp5wkcMmDZFDx1ATFPMeA
VdUqPnH62LnQdWhNtPFFLdYDIwDOHj1YgToDTvgSmUKOJWV0z+/uSKVVdaoip5n9
b1zroEXSW8g7sJByHks2NvJpQ95ETNdvM5kqh00QMqI4MR7oHTn2bLE+V2qWHsNt
5n2SoW7UCWi2Me6FF3SGPPZxlD18mKnomSu68TKunC4uq9lkQ0dKGtZhUr4h2J6/
iGKWTyshC+c14TaiIKgeLlRgfc6fZUuAg8uKAT7kY70=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fjuQk1KdhFt2Y63TmBWtTHlp/ku4WrSdc3f2QHYzp7u5vf/k7w701UDpcO938G4g
fReQpTAjI2mRi4vRp7PMEQCP8fxwB+7ZPECypoOZlDorRUT4C5Ucql3tZdzB1MEf
bHFVmrMH9HIy8r3FUBUQNlGrJXB2RLeItXB4s/wN4uo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15675     )
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
12AF+65R2oPKXncI9lp1L6Zdk3IztI88Lt1qsM+J6lU8bnylVBpm68yJ6Ew7Clb2
uNG7TvN2amGoLnWb4swEeE/oiLb0Bpe4MPuKAC5XK50LHT9xJm6LcdexiN6q3FdC
2QjX6oHNxFKw/HzIY5KlV/CTOlM+m6/S4/KVzywN0y00JEN0VBB5YMIqPSdOQ0Kc
6qw2d3RpJFoQLvQevIhkT04M4fxeXiKW2xT2vBpdEKOrDqdzsolYih4gy6v+W+hT
untmeSpNUPXGgDC/svXNjDp/Ck1EhFZoq6QyrLGc3oiumNKw5X3SmYPbrIs0c23c
6jWNDNtcjACRcqyZax4ZtL+uawyqW4J2xui5dGtV0Dd0ZM8dii8cuOjOfF8FySor
PGU9D9I4mYRN+DY8LJAmM+WTQj6b2eHiAA8trbwsldilHTP/X3JicGJBkJYalwgP
dDmKZoU1AhqNtDyt92CBGfvsMrpm5VglHx3Shd9SLVHUIfCOhfrQRKjc0WJ7hwbW
HFqR33v1LTN2F+Ew+TNKZJHuXkwsswPMQ2EJr3gVHPiPaR2Yv+BUxPpw/4VYkPKK
gjlzUJlY3uT6cqXT0MgYJc7+07VfAGN8Hy5Enuu4KHMESkQUfWU4jZ8HwgMQguKb
y7321p1fvVEy6MMqfMx3IGYDQ9PQGavIF2d3cPX4zPqRRuRugvkab8OkSc4wrLda
yuwaKqj2LkUZnakEKOz2seKzOwjJ0UdHsAeUJw1gIWKWp1I1LwZGmSLP+4DKjIX0
jDEv26w2htBAkq775tYNe48gfzr2X9yYUObx6f7kQp2VAopMflwLz8gtnHVaw4AD
rLGNRzanj/vxbYMjH0n1xmLNMQ8es/YYU+3Xqgj4mmuCHudJMaH9NxOzQ6G5fdct
G5+keJ0cR9Z3ejDZzA+DF/SqZqpWQh67iuJfzgVLMKlHN6wzaCCbLGdHhXZRRvst
hiY6Ijpaq5UrIkpV9qNmbrHdA6laHJW1wO1920VpGl38JtIO5Is1Z1f137iLzPeX
VbMIOqz82CLQZjjdP8xriePA+xvvp5WxCdsTUfnwFq6THkWTSQQ4/kOwsL7NkvP4
psJdzpw8lMOw2XExv2CxP9J35J1HRx0aepa56J/49CuvNuw85q9h/DeDtt5zazBr
klR1JiWfFxJ+QHL2sRWOdX3br2MiY3Y8MIN06PA9wXzSqr+2RzQEJxqbBvwDW3NN
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_STATUS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
myBenA5VY23mBhy+NbXxzLjQ80bEDCmcwFW1PkcVIKx5TxY9VFZzE2Xa+eAI0gvm
h/afOmhuZpiS9z4KKI9akCNjfnWSwk/N6MZN3f+Zv/eriAS3iMFvUzroTXQ97mqR
DVqlNABUml9TlGN82StxEgzwMuZuvk4laoXLKktS1pE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15758     )
nyfShr/Ai9gyTwUjS5bm983/o9f0nLa1uwU4HiO+81frWRnjG2TI6bZ3mEenyxBT
YLiNCDPqVCVqjxzPHBcvWCYMUUdXUfjF3/5ynIq+3sQeFxthg2B3GUuJHu9zSgxv
`pragma protect end_protected
