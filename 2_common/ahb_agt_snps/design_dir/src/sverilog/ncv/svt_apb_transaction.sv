
`ifndef GUARD_SVT_APB_TRANSACTION_SV
`define GUARD_SVT_APB_TRANSACTION_SV

/**
 * This is the transaction class which contains all the physical attributes of the
 * transaction like address and data. It also provides the wait state information of the
 * transaction. 
 */
class svt_apb_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ  = `SVT_APB_TRANSACTION_TYPE_READ,
    WRITE = `SVT_APB_TRANSACTION_TYPE_WRITE,
    IDLE  = `SVT_APB_TRANSACTION_TYPE_IDLE
  } xact_type_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    NORMAL = `SVT_APB_TRANSACTION_PPROT0_NORMAL,
    PRIVILEGED = `SVT_APB_TRANSACTION_PPROT0_PRIVILEGED
  } pprot0_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    SECURE = `SVT_APB_TRANSACTION_PPROT1_SECURE,
    NON_SECURE = `SVT_APB_TRANSACTION_PPROT1_NON_SECURE
  } pprot1_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    DATA = `SVT_APB_TRANSACTION_PPROT2_DATA,
    INSTRUCTION = `SVT_APB_TRANSACTION_PPROT2_INSTRUCTION
  } pprot2_enum;
 
  /** Enum to represent FSM State
   */
  typedef enum bit [2:0]{
    IDLE_STATE  = `SVT_APB_TRANSACTION_STATE_IDLE,
    SETUP_STATE = `SVT_APB_TRANSACTION_STATE_SETUP,
    ACCESS_STATE  = `SVT_APB_TRANSACTION_STATE_ENABLE,
    UNKNOWN_STATE = `SVT_APB_TRANSACTION_STATE_UNKNOWN,
    ABORT_STATE  = `SVT_APB_TRANSACTION_STATE_ABORTED
  } xact_state_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Value identifies which slave index this transaction was received on */
  int slave_id;
   
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** Defines whether this is a write or read transaction, or an idle transaction.
   *
   *  This property is rand for master transactions, and non-rand for slave transactions.
   */
  rand xact_type_enum xact_type = IDLE;

  /** Payload data.
   *
   *  This property is rand for both master and slave transactions.
   */
  rand bit [`SVT_APB_MAX_DATA_WIDTH -1:0] data = 0;

  /** This property allows user to send sideband information on APB interface signal control_puser
   */
  rand bit [`SVT_APB_MAX_CONTROL_PUSER_WIDTH -1:0] control_puser = 0;

  /** Payload address.
   *
   *  This property is non-rand for slave transactions.
   */
  rand bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] address = 0;

  /** If this is an idle transaction, define the number of cycles idle.
   *
   *  This property is non-rand for slave transactions.
   */
  rand int num_idle_cycles = 1;

  /** Number of wait cycles that the slave injects
   *
   * This property is non-rand for master transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand int num_wait_cycles = 0;

  /** On Slave side, this member is used to inject slave error response. 
   * 
   * APB Slave VIP drives error response when this member is set to 1 in APB Slave transaction.
   *
   * On Master side, this member is used to report whether master received error response. 
   * If APB Master VIP receives error response from slave, this member is set to 1 in APB Master transaction. 
   *
   * This property is non-rand in APB Master transaction.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or    
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit pslverr_enable = 0;

  /** Write strobe values
   *
   * This property controls which bytes are written to memory.
   * 
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit[`SVT_APB_MAX_DATA_WIDTH/8 -1:0] pstrb = 'hf;

  /** prot[0] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot0_enum pprot0 = NORMAL;

  /** prot[1] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot1_enum pprot1 = SECURE;

  /** prot[2] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot2_enum pprot2 = DATA;

  /** This member reflects the current state of the transaction. This member is
   * updated by the VIP. After user gets access to the transaction object
   * handle, user can track the transaction progress using this member. This
   * member reflects whether transaction is in IDLE state, SETUP state, 
   * ACCESS state or ABORTED state.*/
  xact_state_enum curr_state;

/** @cond PRIVATE */
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the addr. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int addr_width = `SVT_APB_MAX_ADDR_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the data. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int data_width = `SVT_APB_MAX_DATA_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the pstrb. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int pstrb_width = (`SVT_APB_MAX_DATA_WIDTH/8);
  /**sideband signal width
   */
  protected int control_puser_width = `SVT_APB_MAX_CONTROL_PUSER_WIDTH;
   
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
U2nMtBKyAZCVTkktyzlTQjlaD90VC6aHvqdlwakR60qf2j7e2JuFg7k10jeh9sgp
r2rzLsPS09Hax7YjATGAd+ltE1/MCZbbI15lhFtrwy91ehEWIxfcg9sxtpQAY2z+
06APW91nB2JKJwPX77aLf/11uti8NQIx+weGptg9qWUNQU6CEYOZWg==
//pragma protect end_key_block
//pragma protect digest_block
AGNLRT1IRBjU6qDKDfxSQmZ0n4k=
//pragma protect end_digest_block
//pragma protect data_block
6u2bOwSx3Yttjrqis0Lr5IziKpcE6gtU7b7ax0PAV70AbunkOpQzlXzdIwepwYQa
fRJnKZzZHSu2BCXAtwtjcPhWaHGpky5hF7RsQzkB/8QgyccGufPqoy/8iYGW6pIa
7pEP5bYIGR+njs3BclSPfF2es6EeX8sid3Qhq1yPolITj+IW0tAQp9aPLiaBXwR8
ijtQLMt+sTOOv59DA4KTV0Qa0VlgN612d7/WRM8Vf1gqEQYynLhaHwYH0B2DgiD/
XtMR7/sgmJrWg9c4fTfFoZfsG/2g1UomSlJNNleEWueZbS5Zj/HVMqiOYdxoBeq9
/9QM6BA7ocPOJp2aAFpfzXefXQurMgK21uyseZid07a2tqLsyWncHpW7iihWJFoQ
OStEGgid/TC9eHhq8OItF1OpBAd5whuOikBXaAQHmQIX3QV2Z2y7lFBUD1FBIJe8
g55Y8Kohlf7W88o7VOKemtGncjqzzMIMqyJ01nQumupJmqayN9l4BJ36H8+pDLwB
PK/OP6uzSFQGrgAnVvcQpVmEtPdgy1TN4qb/edSv7NoCu787+ZEC59YDlvbcB5Ox
aGJ0ETkPHLe0YHtnR7bIIeR2xMnCkmpjnwNuBh4EJeo=
//pragma protect end_data_block
//pragma protect digest_block
cOEB7srmwCSxmoK962JrvrvgAms=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_transaction);
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_transaction)
    `svt_field_enum(xact_type_enum, xact_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int(data, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(control_puser, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(address, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(slave_id, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_idle_cycles, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_wait_cycles, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(pslverr_enable, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_BIN)
    `svt_field_int(pstrb, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_enum(pprot0_enum, pprot0, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot1_enum, pprot1, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot2_enum, pprot2, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(xact_state_enum, curr_state, `SVT_ALL_ON | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_apb_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

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
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
 `else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
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
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

  //--------------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );
  
  //--------------------------------------------------------------------------------
  /** This method returns a string indication unique identification value
   * for object .
   */
  extern virtual function string get_uid();

  //--------------------------------------------------------------------------------
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
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

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

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_transaction)
  `vmm_class_factory(svt_apb_transaction)
`endif
endclass


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lyU1qeJKa8R7x8mw+Xz5ApeUUIcbGE3LThU6wwOLBcTU31igQOOfAII0gdyhel5C
eETVwORFiSBRWAGuzD991/pmacL3rC8BVsemVVaFWRnsbrI7Rt7cTLhKs8NPukfB
qCeI41/v+fUddul+N/xPNHVM0JMf76FBCndnTSXDb4dzcL9Vhc75WQ==
//pragma protect end_key_block
//pragma protect digest_block
TMBPaLT3NO6w4+iunpN1Io3d8Bs=
//pragma protect end_digest_block
//pragma protect data_block
qKx3KRxLUTMLP+Y+k0fVWHj2DtvXsEhKA4/mT3acVt+UQ2bBW/One1zKu93EdzmA
Hqn5qZVsAfDSBjGPKCjyf6Al65g3HsKJEIM4C8k9Evm/52GxGvWnOBFOBCyvUSPm
2ZAp4A1H8X0vW5YcJ+Mo8TqEVPMHMAF23N0yi3m3Pj4uW79+qmmRUsJWwVmKlMWr
dOelfJXj3hAV0QzX/gz0vR5YObUsQ0KDmDQ9Vt8vsUcm+SC0uLkos1i3zciYS41W
KpscEamQ+fYN0bIq77VituJ1wBL8pAX7cbkGRU10IwKDtZUgOw5FttnN3jNKPTIc
IggnfXC9yr/8mcczqiPiUqA1W6f3QLtKrN1WmrglrbDMPlRTmdC0phvhrbVGVyzr
6dmuWTuoBVRbVCDpU70vHt7vLuy6VsIKoC/tFb9nQVURez6j4TB2BBgUjmuvgYqk
x4iiV65+/xealTCSePg4+GeExhcFp7BOh20MUqW9wHOmraq3hXuTw/qUz0REsVzB
Zh6JLHDuRN+2O5JRr+Ph/VNGkcRj6/Bw8xyFPFK4zZYz4fu22sPOysrTlwTPZRVJ
oPrZKNbkFPKMbVYyapKj+38vqAXiG4wdI60JckOOf88HkCYgYIkpC5Bjj+dbuKmB
ZXmIU7BRWkRtvFMAN0KsCTfbNNZZXHG/zSqI5Cnetg8OVU7NSdipUDiEQnxeum9u
N1s67v0f1M9fNqzo6bdputr1XLcwcz+clWmtoaaPxAbdDw8+q8e2UUMq4p9Dzwut
rR1nvTYZDLAN36+aNH/sRGpG2pPu0KW+NfkxivqvAqI9KjymddXrz/BdIMJ7657X
KyimZ0yZUFsAqcDPJQ3QjEm5Me8G7EDFrKFFQVPzfvLsKibDz+xsS7h1Txif2mV1
o1Kepy8ykEtRNV7d7RA/dUTxPPJ9OXR5uqTUMxNYJiXnJffkS0BJXlncD583hnvT
C1A0d45crDW+lF1+KFtdmR5Xvc4VZM53TNLC76FLMgSUcNYWZovmFONn+yzPTffC
w/Wau2lHvzSMKlauLwor5yrMMNsnIQSksDTqy/60O6OGnV6v7eYKJf/1/Q4A0mfc
hJ0K1bgwVir0RkPzSiKxK0bOqgoJFi1jfYgUWZ3c8OKyNJV2aDmaoJkTx2ph3GPc
OWVWLInzoofWan3pxV36mfiiCK6LNBkqiOtMCFjY42u+h+cRXoEUibJcM/jBdz5e
wrP+JlZIFk8og2hA3U+VU01ltRFwVV2xm1wheSz0rEHIs9G/KKAP/6hUG1FazYWO
7bhjX5ICezP/oEm/9sODxO4CNLiMj1Kq44Geb+VrL2msb2I7jXpaKpxT+VFWIVBM
Rgy5LWwqI9mecGr0MdMk/RxwMQRRsCjPeee02r8IPOg=
//pragma protect end_data_block
//pragma protect digest_block
Wkqv4Szi4ZC1yTUni43tprepcdY=
//pragma protect end_digest_block
//pragma protect end_protected
  
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hNvwyTe1sjLFbDRkJIre3v1S2eAKQyuZMqcPq7fLTK9CMXKPSMuWbyNuHCaW9uh1
Aosy0M2XuV/e8InoFm/DGx7kekTuX8AyU1YZ+OBAZJgt1VJ3L4FnvFpRaH3MjK1T
1v/PBlK939SsD5LAJeg/a00PUE81xX/gBEdKrqU5/y74m4SGKUvkgA==
//pragma protect end_key_block
//pragma protect digest_block
3IPgzEgJ8ajMjboPUv12ffJLTuI=
//pragma protect end_digest_block
//pragma protect data_block
598afEixnbJBGn+mfatBwZLvDrBgeNAGnlBUVGTA49b6ZYPFbmgl6K0nkZIZwtbm
OmXxx7kjvAV7z65AitxDqyE5BIWEue4IMZpip+xpsmBQFHtcIg9vil+Z+PwdMkKT
H8qIDY3AL7j1YfDe62cem8xXXRKEAoY5XHOGfN94JwoA8SZfbdPZHK8jNxdWVui6
z9mexKikalOHHl39WCzHg0U5f/7fpwlrVkXdGtVPkX2xPkTJM6vrhYUHeSlUqfoc
lM2zGteayw0EcULfWd/LXrPSqNk2z8wtD45IoFjzg+4so3P2ghrllT8CF9FH2kn8
a2WXGAl9BA7K3ZVlRTVJtpUvXqSZNqfQhH68bKNE4lxSaclZ4BxAutKIFxcJcg0x
2zNr5do3q14Xwr7eACaUk4f5ZHIkzfTXCJbhhA4onKoOiGV1dcWQMoFu59C0CqXN
6QW2JFuEPYKwQEaMxIfwp+TKL+0IoLaGuHlo3sJu0/c+wBuY0tNYbBEosZZBt/7p
bW5FnxahGq3hy2GA7oc2dmFfNhTF02jvN66y61jsv4sT03CyzLvYEQg4R537THis
YRZ7ciABL1EYD5d/zHyuxXKD8JmGa2gjBfdPUgPTofoSA0DfXpgxAJTqSVYy1nYv
a6e4elUx12OYkWGBCdxhXaUXXuSx1in0JG38QpgdsE7Ngw5zT1pOmwsziO8/3Np8
nmbtJVAV01mfMP350eo4mdWLp/nspfOvIAbupojfUgZ3x+J4Txti1DdJLviRAIYc
3a4o1vkaZMxCcfzSAr0kS472c0Tpz1JSCbZRcPV+kO7wGkuE7iD6tgOs4kH2c99T
jvhf+CeO7nTZhu3fxDqbBvhqsLnvTjIpVV3j98XzljbMFTJR1WOvBPCxkMs9zb6f
QdqcQM8dAyucRYXTAymJaA==
//pragma protect end_data_block
//pragma protect digest_block
gbMl9pV8BseVQ7aWGQPJHnIKOa8=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YVbqRA/N6H5iuE6fnjcqx5uAffyDKXEDXIh3JhUTG2QEuxbk7zzS4bvClmBBpeoT
K9dN615r7ZLcs7xsAMSVP8+7hQrJYhmaebTvL7vHng1F87uDz/b+zxtnRSJoVkBC
Df0pmNM/wcwfsn/HixezkClKaJVhML0YqX6bj7uWCKVSV345DSmFTg==
//pragma protect end_key_block
//pragma protect digest_block
0/w9u9jMDtc/0V7QjUt2HDwStn0=
//pragma protect end_digest_block
//pragma protect data_block
pmhP/ZukkWr57RlHlUFGyTklFLwfdzGbON6TzewTsJn9Dr2c1tpivly+krvBAWV5
tnoDetXwxHK6tFVmFSmiimqVaC0EkPLEZh7nrXP6AvIZtpnfyIJ50JgRY+E8FCVV
izn/T8KmRhrszEq9QRX29SaMukIXx90d2kgrFRMXJR51m6YXti4P8hhD1NWL5nOj
QvYMydjTsvV07NFPWVc+xlwKnNkJTgZ4KsUT3uTvX/2o16RKwTdkaupnfw+wCVH9
MdvWntmjNrdCZLutrx63V7rDDjFFBQQZBaqNd6D0YVMZXAEvKVxTACRS7HDC305l
wa2eouLsfNKWaroA5g0WBZ/Trk3IjyTKiAAboZ7nOkAAiRNJxCzd/zfNM3dw1b2k
UUvJ3pG12gqkZ2sNGbjmnqLuu1J7fVeAXIxF0KGXosrrejyDd/oC5/SajugNCNDL
cwnpLu7xaX+vIPYGi4OtownVm80mCS0xR/0k2ikybfDcJk12YeqpfsMi0VU3Icg2
mbgopULG0hXsoHWjkj6IpXS9xH9JwEtY5NctnJWbPLBSC3tpccrwg2ecMtY7vjaH
LMEmSpK+ZtFrD/AW4hYhKQ==
//pragma protect end_data_block
//pragma protect digest_block
FYbFzDYnEpSHe4qwjjVKusnHrY0=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
M7FpivfJpUNon9a+VohIetdMbCNB03yL+vUC72oZXiaK4BeI73TOGdJJ3Ni5DPh/
hkVtQu+SpZpIUxMQp9pFBiiJxMSecgu1pWooG1ZS2ocyB0XfboZAE37ZhLOPpyDd
Lpy49q0mmNMoOAPju2sniVD8l8QBfRrTSixRP4tHVZ7owRs7SmEe9Q==
//pragma protect end_key_block
//pragma protect digest_block
Qu6qD48hiiREo91nzNe/oXjUAxA=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
jdlWQbgcww+7KY3V2T9LCFovQqI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_APB_TRANSACTION_SV
