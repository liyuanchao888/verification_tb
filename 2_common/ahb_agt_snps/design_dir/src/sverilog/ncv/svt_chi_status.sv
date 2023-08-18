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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GNOouPFEu5yOqzGCZWDAqiZG73xhlZhCPa/q0C9kFm1FvM9/Ot0gRai2P6Lcgd8g
jFN/enX9r1gZgpAbqsKnTv7LaYr8MScP88suMLrcUZb47sUf1uhGMal/Z5vizN8+
l1hsVbZ8V+IaRD53nptiGkEzSuolsSiEVNsuqCnsmFOzv64aY5kolw==
//pragma protect end_key_block
//pragma protect digest_block
Y1tg3zSweHGFbSc/0PWG+xo+bX4=
//pragma protect end_digest_block
//pragma protect data_block
QGUf21UxIZ7d/MGvqaCfw4dL/S605gv09yZvwuO3CPjfOI9cY6vq05OKkHvwqOaB
Km01jeCt+QqD2QA6MOLcderhjv9LzJakzD1L8a7Dbmsub6sybPYZ7PsxPOCx9nBG
J7Kg2CKkxkk1RqUnSEp5t/nVdWPfXGpLwmLsdA8CoRWsJG8Rxshypa4m0YJt5ljV
tq62APw+lhC4vopLUyNHwXSH+utdFR/hmHWHyoTVtg36xcT0wMISt5oO7mxGm17l
Ni2rIPxnExamUTYV75SQyV0ZyNfLEe2aC3PrAxOjaCkr881t4AW3Iaa5Mx+KBZ2N
zqvrV7ytps+8GdJkcm2VFjCtlD3l/PRw+dsvrM/ZkZZQJWcRJKg/H9hqwFRzwDdi
KbPSaz9AeCEpcfQG7Mpf5AxXyRz+Vb36adjNFzGuKlNi+QMOL82MYmUg5fqdgrXj
yp2YVoJ2tgUY7hUn1THrxg9tWbFruVMmZG5yFXq4wCYmuIm7bbMB7JvqDLBy8MUo
ui5/QEeoNSMWdE990SgbUAR8/X71jrKruSpNMcPVrjcI38GdehJ10boa1NyhCaL9
l2V7y3Typl/6vu65SnBd5OOYIru9jP9yEu/ycEMEBZduu+zYzXUp31Ym3icZLHSI
tNJ+qLxSP7q4Ygagc/d+D3RWxAJ5PVbWRNILiq5twVXcEJb/rz7jkaKd3KffN2SD
aDky6h13MgobPvBqnn9/ro7+MFHs413STon0IKvYGUXGUMYuxWINL+ciCVLqGFxI
riYvaDRwBFs+T7WNewrrUMiMOnupqXmgRwSEq8o/FXmx40OCisYXqgQU6mIiCLcn
g4wCtG2fTLIgr3VebdGEt8HEDtdY7k+gaNxRfm9iNDohB2ybzrIlVfQb/78FSL8e
izRREN+ihE/Td+4jhFlAYy7JJj2bfv85x5Fr8tJqFysEYYGBSLbPrzTeq6GvdbkA
JJuG1QBXJT9+ujsMmwffurr8LmfP2dKinZPSFYt91D+q3SCannUHx2SYZBXDGmSD
xVkHD1emwbgpG0Y1sMQx1Q==
//pragma protect end_data_block
//pragma protect digest_block
t4hcy/0j2fvo/TdYZUifVb17gM4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
b1UhJr0IuX2M3D8anL4QdxraQT5c2Js9WDSStpz3bbabKEtmCvPib4D7M6Ig30oz
uL2Drvd5PA40cRMiTNqNCW0GraK8ld6iLDLGWORYlAf8DkoDV1QOiXRAAdP3U7oD
3fTWOUW9uzkOVzQxHaD1pxTbu2WnMz9dfhWNVUZ1DUfeTemQ2B+9OA==
//pragma protect end_key_block
//pragma protect digest_block
tMRzJMCF3O2Hu7rWHxLUPcDFPT8=
//pragma protect end_digest_block
//pragma protect data_block
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
l9v4vXjaf4qITuw0VFEYae6MG5izdJUhi7KQIcWJX/p0HxIZtlwTJp8SvYKSqYiT
2qAV5f0Ddv1ZT1iRd0hUloPlvolf2Z8O0US28vRGF1n5R6btGyrY5i9n7v0up1Ue
JJB6LkjOb5j1jFV2w/tg77+gQrE3VYNxSUXueH1j91A+42LuRMWYYFxRP6ipX32W
ZjrScPgImr339d/W/n2YA0n49VpLwlrWn2vlp8gwcc05maoSZDsWM32VJ7V1CvKx
vjkjyEniLQcdmXjD3gx9Z4iHZyAdYU3Fv2J6TJc4qdtWL1DlNgZ0J6k4JZD26ING
30Mikrqvr0JACFMASgdFpq5/z4TZ7H90ZWiCycLUFa8CTev9hiJe78XFNUxJBRPi
iEQfWLvF0Yv0iLp0V2WI+O22n8yfFtXeOkat4BUoOgzEe2MgaRWlsWZ7g/Afw36C
nXy/CyfPg+Xe5ye5Sm5cEViB0Tfs6COEZn3EOL3f0YyiwEtcPqM7z2Ingd3wOUPk
px4avuesfqfujVCJetZwFGiYIopVyXUiqJz85v+r/aFD2zya46BRr0X52e2LiWEn
M1LlNVlQejT8mLkUkNNRU6DSNbtzcao+cGjgeWLc3ZNTI42mUDnAFB1kzIE0sytW
CD26wooaXAPGXLkQT2ScbVHbbAoynApOWYBXD+arZVeOn17ET7Wz51/hqb7P9Gp2
OuQ3dFtC257kTWKJJ2EmcNR/M1CTR2E0b1yNt1uX2GrzTUTwBZFUCMVs1VmL0Gmn
WQlNYwVSEUU07VhtrsHBNgXXAk259sSQJLkxoGNPAiVc8X3PLvHwOTuMOnq8tULL
I4YdktsLTFS6l4xhHk4qwz+Db3UpG0530KbUG1HJ8Cqklk+p3lQyz7YfmwI5U+HC
aDlwYyeu84eepZZZK8RlxezyMSzGM1xGRsGsIutTvTVYy6hmP/P7r5Kx6HH/QdUh
HY7VP/AI62ssu/9oVDQpeKgFLXhMBQsDjQFnUTrA1EWyJeX7YKh2+aDRKdppYPdr
a1FSRgXnEZwSctb7zErExWzBpXrqqVum4MTSjH1dZ4jkfaCzgDf3Ro9Ok+jctz6B
3fOmE6orPhJhuE01PgDWfpltta7h3d9utGqfFuUFc1P1eXVmGxJdg+2V3uvB0m3z
1XI2QSYxuvUq8T7yqkY0aEfS8aEZ76HEJgj5qrAIrmc+9JJqVn7EnL7Klr/N7Xba
Y6Wzu5nkYhiySqg28h8K6mp/K/wF5VcwdD7Yqy1wR2SRvJ0Zyz82KW7UW0ZNcXTT
7bA461U6loJ92tsTd9Oe8SANMK9BOzT9drYN2LeSeBg18ztMNsl65OwwfxrwfpGO
bMcv8qMrBt5r26sf0luDpmfQsDspPBLkI/STHNFK1u0b2GYZe7cfa/tajlVCsC3y
mGFFsd2x76l/s9oZN+jd7bkM6ebLvVnWxYcsgWNs6q4F0MbZYnde5O2Al0qRs7Ao
wrDEySqfCAlzOP9JObILxPSsEw2l/k/lgJgjuJcQzrVwCCLMwRxoHmd0DCiUldzt
1AJ/lZ+H9RrpFs5qYRqqk9VOdsPE3eAolq01XbQlqz93l+lxFgT+MLvV//OfZru4
atiWL2GCnYImvVpQMUmSD8ha3SUNmgyI85NFy3ZW3gobSxS5VBo775pTEqKoZ2d4
7JnSere1g1C0n7qVmLKNBaR87TVLryaOCODbCAMgcPGWGKLWU+GZ0LYvFvaxePBa
FddjZliqcvU4cIjgj5imka52lxMUtU7B9eWtyqWwzpZ6RsfJDnFt4ybJyYJIbyB2
bISS2eONBGDRgtqTFEe7N/d/r0pgIq6NeIn9t/CBDsUiDkKvHxK7NIcDGoQfgqvJ
y3oBxQ6C4/q/TznGXAN3QKrA+HzaILNBjaaHbyUIFKMeZZvwMG9VJ18RnDEaGQVt
ihL0Auc4B8QN6GXPNusT7D0d5Y8zxGdD2zrJXAqXAjCkq6GRD99x7p86K2QdGmZD
jo52kQ7cduwbPrNLfisaY1i9sWPGjfgxJVb2pARyxw1eCJo7C/buNBIOFCxhlE42
cE0KK3itKD/MVI8zcxr5nvokgI4ReH6Nn3EMiiv9Qr0=
//pragma protect end_data_block
//pragma protect digest_block
3Zmwsx1QGUatkjgzWIMaAu4x1s4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_STATUS_SV
