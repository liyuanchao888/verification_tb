
`ifndef GUARD_SVT_ATB_MASTER_TRANSACTION_SV
`define GUARD_SVT_ATB_MASTER_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    This is the base transaction type which contains all the physical
    attributes of the transaction like id, data, burst length,
    etc. It also provides the timing information of the transaction to the
    master & slave transactors, that is, delays for valid and ready signals
    with respect to some reference events. 
    
    The svt_atb_master_transaction also contains a handle to configuration object of
    type #svt_atb_port_configuration, which provides the configuration of the
    port on which this transaction would be applied. The port configuration is
    used during randomizing the transaction.
 */
class svt_atb_master_transaction extends svt_atb_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_atb_master_transaction)
`endif


  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_atb_master_transaction", "class" );
`endif

  /** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;

  /** local variable to help in randomization */
  local rand bit primary_prop;
  //local rand bit force_zero_data_valid_delay;
  /** @endcond */
 
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
18ajD279ppFnlVT0uRPi90jq/IVdLjao1w/zQ0Tgq58wU+z/NefIMTJfbRA8xdj/
xb9XJNxGbeqzPWp1JxHE1mgRB0JUz7vkKkgdTjD/bsahKRnGznKxqYqsIY6Pu/DZ
GTGD30v34chuId1xfOQJM3B99Hlif5SzrYxbguMD0Qpp+SpIQz19rQ==
//pragma protect end_key_block
//pragma protect digest_block
AbVBiTWmi4RI6dHjGD9ZSjEGJ6g=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
2nGob2k2Rydo3Vow8gHfBwB0Vcs=
//pragma protect end_digest_block
//pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_master_transaction",svt_atb_port_configuration port_cfg_handle = null);
`else
`svt_vmm_data_new(`SVT_TRANSACTION_TYPE)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_atb_master_transaction)
  `svt_data_member_end(svt_atb_master_transaction)


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

`ifndef INCA
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else
`endif
`endif
  

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

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
  //------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  extern virtual function string get_uid();

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  /** Sets the configuration property */
  extern function void set_cfg(svt_atb_port_configuration cfg);
  // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique iden/get_uid
   * tification value for object. If not 
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

  //------------------------------------------------------------------------------------

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
   * Does a basic validation of this transaction object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  /**
    * packes randomized data bytes into dataword same widht as physical databus
    */
  extern function void post_randomize();

  /** @cond PRIVATE */

  /** Turns-off randomization for all ATB parameters */
  extern virtual function void set_atb_randmode(bit on_off=0);

  /** @endcond */


                      

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_atb_master_transaction)
`endif
endclass
/**
Transaction Class Macros definition  and utility methods definition
*/

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1zSV2j1ehJrBTEcFRLgXY8VQCo/1cO2nmzQ9OhMdmgwfZ25Mn9pZU/gk5MzHtGqC
WgyyXwDge3yZOQMqURTbMTOQBy+8M88fFHQaexPXbNOi08FuMYHmNeQrkyWFo/PD
bM+/c+v3I55Prbamx6v8ZxTsDqo5twDML45nEmHeiSSN439d7ACu6g==
//pragma protect end_key_block
//pragma protect digest_block
JPxLuEtGHF3KJAJ7k3Fs/GsrZnA=
//pragma protect end_digest_block
//pragma protect data_block
GK9GOem0g2KXzUbKGsJq2FIzw5xzCmzGCXHLfB4c/Gj051jh3aUotTg6iX5Q2EeH
+xvQ9NKPQvBem00iY/m1V4Td2Q1iu3RUcV0M2niriaihzB4A4BGJx+y0L3uv8TRd
pev/trzwG/X7oK8Kz/o31IqZqe97Bm2s50EXl0w/TdSIT9JSTacOOqn3J5s30IJg
bsSZGkvQBjpIbBQ9nnZqDGK51vRdUfhmNjzq5TnTjXSZorOzzAvJiXdDirCWNYd3
zZHlu1tvZz0XAvGvpy8BhHQQ4d+LXZh4aP2D3F+coAh+CyWIYkCGUv2E1Zurlsn0
pu2UT2TSr2PlMA/P7EeWnglB6iQnUq1bxKPfqI1WRUtRu+Pyf7dlHw0JNI3d0OGV
yQxXpGNFzH93ffH6KArvPvolAopdTu5Wpmmh1vpZwb7+1b4KZ7N2tOJlwerKuMQ/
1JQsQHt6sihXJRKOHX4bDMJnTf8KRwANySMb1iuuUN2fCzcze86mP3Hl3BdJqzun
XskgtIsfxr0XCBKezLGMJVISIdKtEaJj5FagX9e2iLsEFB+zdI/6x18UfRiCrqsB
qFfpp11HaEBVWv71eCS0t1DtCg/OjxyNxBLjMMaJW+iq14aRs5wnT7v+mKxxLTTc
GGsS4rUsUPtRKy6BDcXbza5RHALv4kuQqys76b/rHWCc2/L1mhbyh8nj7y4oswNd
Jg1LaqlesMK7uC4i3ynt1MgmcPbewbpgB0AR9+ZzKlQzpM5Z1RPfdsLp9QTuc+5p
8MMN0AFnz56nsOz6RxwtYR+i69k9SjmzcFdA9Eh1CJvFiFZAKZk9E91ltf94bmKy
oaOy25eqQDYHSOjF2G0E2Q5TCiWHkyli+f5eyMfwZvRCDWibZwrHy21lgS9UH7P7
wHuRBQjxYph3tP/TKE+u9h/R0KmiAiMjoH7E453XWVbieE8hHatmK7R/I+R3FYGt
moqcjSkBcIJd0I6otQ2sM2hPe7AUdZNXfGATUzAbpLDIHAPFmpTdzo6pR2aoQQSV
1rzrzswb0CChT3ZpNcwVZh/JLx3Sev5aiNLr48tM+JGC63+I1rzufhX3LiFjXn83
KMWf1ecOJdyK+uOxTb7PhPXnBz/8v1LahKjDrYlR+Hl2nGGldGwPbbjmqYulMz7L
QXLCZs7qo7C0isN2Ko8Quzw+S6ocvzIiEle80maZIDYIhRGB9UDxRQBYS3grkHQM
xp4H0Oc1Hst71EjMG6Sss4hNTTIFMq4SseQYzzWsR43knNpPHfy+jzCe+IKyURQ1
jai2CJQXbBjIqIWx4hCz60EZQumyW/5Q5IF9ebTIg/yKBGdV9S0MIJ1M/Bgh30C1
njc29IVwXTxp0PhhkFTT80mU+BmMztLB02JqEzp76/Bo1yaH/11E2zh1RwarVKKx
GCaKTDONK2UWUQLUQLUcjQ==
//pragma protect end_data_block
//pragma protect digest_block
s6bbkNUMN98bzODj5Mz1+seOmz4=
//pragma protect end_digest_block
//pragma protect end_protected

 
  // -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PBfkIN45UQ7CCN1DHliqeP/YPLkvUwyeT4db1/PxIRpu7s1/MnVghOT1wUKPwnBd
u8X5NQjULf5WAn0bhAKBk1XRgKpmMeWw1rf/gPoHwddoJQsS2nAwtZ9VSUKbnc9B
fJmTWJCOy2MjuZu3Lr9xDHyUnu4y6pV4HWtG7phKbqP9pRudBzdtZA==
//pragma protect end_key_block
//pragma protect digest_block
ft1QHUyn4yzGO3/LjShkGy9Ea5Q=
//pragma protect end_digest_block
//pragma protect data_block
QNr4x6FNpliCyzxgeWjgQzgbieb0XkvGlycECzWuVQIaLIyfjbrz38Rjdux5dn78
U0aSrw/w5jaJ1iTQIEWC0XMaBUmeW1QvqXNaiR5ppbsfWRFC5+WHq/ICLCYNxiBy
7g5MOqp13qpkotqtQ2+jGNGdyRD3Xna+rMkaN+Kju259Tx2VffMP/FvrpvA4kTHv
cK6kKoNKzKv6UYij5RDFnNMnbrz+k3I7jQAN/x6+iRQCpmMckNqrYpek4EIHDuoO
m6+Lz6Dg/qT8k2GuByGzS9bz07RRqHnM+p/VzL1iaI9d48mUBWzc8Foya464m8xm
w+p8hqs6VJhpNVNgX3lWpzWbvxRg7CV+QJQKWoNz9yaodjyjdI3hhU782A3uN3qz
+d40f31nlSyhw75AkW9E/r+bHfY5hLaAWdeXDiMdKdyi+AybfGAgj0hfvHAq3vLv
Vnp7TKUeqndjkwoepWW4Nwhry99ilcP+d5/plGNcrtvDvKEwQ6M88tolppOc9Nxi
MsYX2OYMIa/2H9mD4xDlPiUR9T+lW1IlpGkgkGVb3GwlgKjzc1sbi6CZrwMJO1fS
CNtoPutLgrS2DmK56HzmkMP3eyszOjP1OHXXWeYhT/B4lnLWca+dcVaI1r+3QgU/
JzxRVtwcka+QU6PbeIqQf+XK4UDEHmDArNQB91qCvHcRJ8lgCJkuCgx90i44Q0es
I3ZeyrU8J6O4dOY7rTZMTBJ6p/84IoN/VvJtBt/b3YB3WJgWIE6GmWCYL3OLsOtH
x4OxdydDr+1KsT1m5b1+ckFW6VHluidmOxnBYgPmvWRwP+pJ5Z/YKUbS2DS68hpA
dtLxrHaG7w0956tNgeNhavTwtha8z6MwWhwBFK/Cu/liC3lHBr2bLQ0NHb/fKaPd
AF0E7oUaYY9zliSzjUIMZWA0F++Y/cRN65p9j1myTNb577qHU/OLvLs02oYpYcXe
+7PtYOEe57Px8nazXWubRNYLM4cC0B4Sha+fOtVzFcGFwXtd6pl1hHWkym5aMdUj
Xpb+iORAhFtinlJdA/yS0vzpuU83UPWcXLnchojvKQBUp3mE73ZiwJZewYAVucNd
PrxaDsuqXroNYuU5619udEU2/r9loSP7qL8BT2ubgyBVTD9ZQlYolcgT8NCyefgi
2MdZz499uUBBzKzsn7pP1flaKSKh7Tn7EmYx5HtKJuI0LuX+6Jm8xDh0tSkeRbx1
ori8IBDBz+7Lc17t7shZcL0iGZ5KoXelBKOpHEze625FH+zcin2haQfzEdIImLiS
ruHUsgBxSqGNUgUSD2nEyuWOeStHTtbc7+2De8mrtOJi7xIY+rcGKFLahOP7l5Rg
UMewbOfIhNQFzhyPeV4VIQ==
//pragma protect end_data_block
//pragma protect digest_block
1OURJ2b1HBaVdbrRca557wTniqg=
//pragma protect end_digest_block
//pragma protect end_protected
 
  // -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gMspRFI4Qw+QNGE0iLFvf4N2KFtp7fxXcz+C7CwC/Sm/3ff95dZxYXUI/6W2k/ZT
mOyMr4s0Bkjsto3XkXz0mM0oRJTgCZTHyXiZBijslaLuO4ItghGUyCdzzCF6mZ5D
BRu2Gsktx4yBCmJCi5cvq1JVWVzUNyqmVcB6PMt5VdXO4R/PcwyJ3Q==
//pragma protect end_key_block
//pragma protect digest_block
bwRRc6N4l13O/07Ec2asi93Vdbo=
//pragma protect end_digest_block
//pragma protect data_block
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
wgyfKNMFw8z2P+SNlf1Oug==
//pragma protect end_data_block
//pragma protect digest_block
rQhC0Im4LjHcWwMgdDdJ5YYsKuY=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JmoIV+TtPleBBbBhToD1PlhFXW3cdDmJyf1my293QcFtIZc2JXLP5Xu19AYtup0P
kr/wpK/YGPQUL2nnUgtrSqD10XR9cUswlt4jAu4Dp1Szd8iVuX/PsuTGC8AHJmao
QeeGPcXsQ7SW2HfVi9jlQQS3QabAkW+U0A0qZHsg9HLYvIiGUjsuvg==
//pragma protect end_key_block
//pragma protect digest_block
yNs1Z1J2nl20v+CUjfTELrqy/PM=
//pragma protect end_digest_block
//pragma protect data_block
jxri70Qo4ZAevkGEI0R8i7Qx6F9XFarU3d6aSWv/mEt1YrX/WMmTBMhyDN02Y139
XSpWBzDt1kF1Rd7CWBPM2ZnKVf/tGsqDiE+PBsLf6eKTV9gQ/3AgOqn6UDd+nGoJ
v+b461z+wB35DJPNQK8ZZG4lm7FeFmiUSaJ1tWbZLLCyQeqfVU/yo8pc5pbpMAl2
Vkd1pytj1qijRj7UXZPGA7PU2FR32YlRJSZpUPJhduU0Z0upfsLbCCLeAc+wmO9/
OShcNCgP+8Fe51pIXV2n3pYu7XDVkqxwEp9KGX5xUuGcSkVWlUfPv+46IkN502Oj
Xf1jRPfm48tGNHY9kfW0v9BHFjrhE6p/HKj7ZRHNNyC/p3SWp/01l14E8muPNweZ
hLxbzoGJNG6IXQXU2CiaLM+XoRBIzkm+x7embi+sqKdykRILIN+E2kmntk0C2eh0
FH7gmzAbkF9zhOg7YvrIDW2G2JMlci1J2fFYTLAlaMU=
//pragma protect end_data_block
//pragma protect digest_block
rGDHEYbEI9BZJMtB1mjymPhfeqY=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8WkmMM5aA8BYYgg2ugvSAY3RQFSU0u3SzN+F0yDezLd1BLgkDj69A2rdDOxgrhqO
XCApxQyHdLWRaltK8F5Ug2xcAXzGauI/7XmYY8SefT0DFtF5IQLYLjc5OfhnwRCi
pPPiuu6m/kdTsfRUXbWxLWvbZv5ndb9Vdc7Yj099Z8HZAuGAt0k09g==
//pragma protect end_key_block
//pragma protect digest_block
0Gch97UvxRIN5o+2M/wg8zREqHk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
8V3Pm0KJs2cTD1mesB9QFB8VV0w=
//pragma protect end_digest_block
//pragma protect end_protected
  `endif // GUARD_SVT_ATB_MASTER_TRANSACTION_SV
