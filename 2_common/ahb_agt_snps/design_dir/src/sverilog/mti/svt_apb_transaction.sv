
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ynpq4rVD8NrCapExpMHlVWct92yEj4QE++rBUYqAJaWHucEg5jABSUADEtN4uoQz
2w1wx2/Wgka9DVGvWYMfPvPaKxSnRPsLnQVo+yeaA4S0m5bE6Gukxg15ucAGKaKF
QmHcncR7aLapsbK0F8Hu7m/nkFElOzdwyxHSlZub38I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 297       )
fdrsxlHaAKaL33RRmISdAS2NA84Fnbj/nxcuoiFxqL7mEnFkJHfjRWlUmZ7jetrT
2q1Q70c3oCtE6GMWRYHQNqF5zBS/ezh95v3zTqPZCj8PkvVWy1hxhK9/bRPdSnSQ
4VGSqXspXejZsQ7DkduA57x+TwFtJhtLD2r5TLSukOQPgQwopBKOnu0NOuzavh+G
BObzzpkwoieQbMbyko1EePeWZRaxuzZy/v0hntZVS0Q4j5gs+ocKV1wEpEguVq8B
c9wc+Y8R/PyD0ZyuI8ndmKssOS/VqlQ529izTgr+aJgQvhmyq5QPf04hIKXtfx/W
mjwl5udNph6Q6BSAu4CS3KPJEK+nLjCXfBv9Kb9b94YsLRAoOFreXm+j04gZMvGY
xk5/xGvGPozfpS+s8YxyzQ==
`pragma protect end_protected

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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FtHIGNkAZoOS6Nx+UtPiYmVk2Zk+l7E+rpj2MIWG03i0NJU66fBJCHSn8twuFnLq
hz+kHnArzaioTXdUoQUbzXj8yqhUbydbbLuYasFYSx0whByJdgvHFHOHEXXrARf0
W/tqfEGHfynLQw/CEDQE4SWNrzmFVxVNqxujnAyRBIg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1157      )
MrM3Pygj8dGwkrXiX+9fI55DTcRksz9VAHs3OsmfXCFdGvdRDB6l1NAk7/f/5JRg
yk3YBK/pohoQwyorq1bZVUOgLQppR1Xqe45VjmNQjMXSVJ7SMwYKpnVR9m38+qV5
LFy5Sc6lIOkVmAUIhLU3uDqoTQxYeBg23SN6EhJnz1Lhj6Jnd8JHxkuX1XhND9sk
SndgkVqc1s/qiJstOqPmSNLMfAhjFHi0am9BpoZzefUUIKOHNxEBEqn8gfT0Jtxq
RZ0dzGIWByQpti6TTosZRegUa66ZGrUC1vCtnqWD7hrVvKElnQvPKf//dYQacAR2
IikMH4tF3BfIKRuw/ii0nZ2XVLCkv3M1ddxMdS8ZLEQGCEygT7bRiTjrr8+b80v5
jjkr9vHvZ8gMwPj+rrpE9Tv5JIzMNTZ92IZLSHuP3YLfBbwujYhtsCAZ1kmLSO4l
iUbdgcKQFkvWrgVUD/QoLGJkrP2qHqeqynmGQGCE2brfk+Ls/gBlztJEqQKJpbTf
ZFwwxp/6emfgRx6ajj476K7ywheJD19/VcQDaweRKL+BDnP8aVcLTfUJyMVLQ6UD
mE244ZuHwcUd0x2fgEUOo7wlXTt2Z5J4DvXIeNgYoZ+uQ2r9OrSt+IP3ZwNiBdx+
vlepF/CsyM4EtRWLaCUxBpF7UbYMNg0E8VUTquU0EglxHm7td4Q3E1cmADNICUWk
KOAWxwAbbSBUsQifkrAVaxsQ1r6S4rQBwjka+8s5RLWqOZiFvayxkuM++R+VE3Nr
/irMWLV5kcXr4cE0eDCMMqYy2Okb2Tk9kRVW0l8/uKqJi5shWZh05DWiRc4LS7+R
DLZXUdSjGy5NBzhXjt6Ht9GJC2bWMSXDMWHGZtVQHe2BVQkcnddcy+bCsTMSRb+O
YE9jnszgoU+8YwlYvB9R+cVP6njUY7/+1hvsNYjqUOi5CxUZR+L+2hzHXa+5c+dJ
sL2YRmufJH+WMAe2YvcOlhiWRJ9TiCE4M1rAY33dG0XvOjwMyR6Jw8saODLCLgMY
3ffEtnlz8AUVjmGxHDx4Ch22ovI8BWTkK6LSY7U+5r2SpLwCHd5CWz7rpHjEBrpA
TZpj1WW0t0+b7TLRUJ8bl+f0Na6UplG+PUQIhqBZ530TpuJ6veXY9yf0HlAD7Jn6
`pragma protect end_protected
  
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mzbM6Z1/Vvju3EVwkrcWIQorOUigV6zaQpDc18isO93jX1Tn6dZZoxChs5ugHZ3w
EJwEvgSck0BjjGMmpHJW+8zTJmaGx9xS34un+BeDckh0S9IaQg3nxDJ3J7UzwrfN
wIUYwlFZWQx873+irbzvgRzrrwudTEcR8d+3Fj2wfeA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1674      )
reBksnvwqtcP2qUi/TqGnalAW416lKiQte23intWpPIA30e4wx3fzEhWMi25ddg+
MFkPyKlwwpdQysjQ0chL6ZJM6eMaTWDtnalPkrOq762bOph48WRUknbvw3Wu/ipY
ww3Z7e/MwX7Ae0gBvl9A9oSlmvcwYchKyADbPGNfo6Vbrbg39pm5ZhL4MgkgaIR7
oPBCVX6MfqQrLaVB1aC/yOBOe1xSXTxRgldwXJ5O18wjPfaXfOalfZ6oZAnisBaN
Q3pMv53AidHRaaeRJyfjPcL9/L17Mg9alLzWZSWp3EgNEjbpI/PQwaXLdG9wCEHk
foYlRughE91fC5xPmNi6fbpGWjd9XQW8oArhjM/PEBAX1MZKD8+uJgkl3j6pB697
+tf1J/EacLryf8MZJRqcl2L5c+qAppFwpqbmKDJ2IeJhltUj/mUYv+632x77kF22
DzHdKrYgIG80lSRESXvTGgwL6qMxaFDGAzACVJ5UVR1xghGyu5POBl99t396wYWG
+NjkIR4f39yhKVQQ5lsjTkQyjwVuwykGoUpk6zgp7wV+3AbhHfqQ7f7LpEvSrn2z
qUVnwZhvN2Fun2uZ0YwAsiB8+Yc2FaFUAXunV+Oow6t6HmFs1YESy4Em4MgONEm5
2YwwqWbwEuq2MmGlkqhJ8XAvDz416Yt5ywFuQ3LGmQzppkLLsk4jV/fcr5qgo2JM
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Rtt8qTahtQ4Jgt1/IsQoQccZP4p7SP49ilSo6ISBKLD9k6FqF1K1s4pH1J3jG0tU
qx+n7iNLXFXMj/hUQsiIx61nfuZlmr+hlpe49PV9jN3dgSlh8cfnKlJskry5iM5+
BtuhGX9gETGFYf+Afontv5hVrtR+iOCewp0b0IGsJ9w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1944      )
inTNdcam+PuKhZSUaZYEaPYIgzAZpO9MGZUJmB80FTHFCbgCS1HTNGgc5AT/ebdz
umt0JyHHnT6p0A2T/fr5K4bPqPtI32hN4NVT1D6CYtsHl4+lfYIj6RZDkVIVOexj
txQVW4OMuPmwNfFiE5NkWSIgDExLR1jzJgzayurzO/NrlXx2xHPVPD1jJYmfjF9Y
5tA5whbBinauWfDUlVebe88cuaMc7uRtJfVdZrKelGwsN88lfjaegXJGiX1Aai71
RYgWQi0lvfqfzZY35lLIhUbvsUh6FL8t4krFanVqLLDEALcCO+34yFoJg9MkJ23/
abT35VViOcFu86x+9EJgLWpLP+wPg3mOd9WJHUWIjoM=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hVu3DEMc9rGruCbMpdCHNctDkyY5LwORpgksQ9HhUhI1Wxt8OA5pt+qSaO9YPopN
r6uYmBc7WBrPSux6x1W4vixCJI/6xFP/Lm7+w7ue+lsnNmpTOuQIH4Q4VjvQTBPF
Q0oY37tlI9o900mkkPc7nHQ4rMuP8bEqJ1Jk4o3mGCg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15214     )
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
`pragma protect end_protected

`endif // GUARD_SVT_APB_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dZwtHTRZoNNhPDeE+4FoVqd4TGIJtamsOQLsfb6vk8NbetBu6uEkw577k4jMH9ZT
YSFE+GmPtH6+/V5/2ZYJs2jnkhZ2STGzBfy/mRVAKPcBga6q6cyRwl6V1Dp4wFUT
ATqu/16Q+TBcBVh7+LJrPrIcHrCx/6NsZB6r1zgv4Pc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15297     )
f58NwdPY2AZZtFdk5zX948MddrvNXP0sUH5riPrlck+VzBJ7JWIp77/KKKOjg0/l
Rw5rXs0F8t3vrhBXQctXClzgsCU3e/JonFt2ASeD9u5sfZWQbDNSHgvbzqkePMfz
`pragma protect end_protected
