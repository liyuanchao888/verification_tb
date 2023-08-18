
`ifndef GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
`define GUARD_SVT_ATB_SLAVE_TRANSACTION_SV

`include "svt_atb_defines.svi"

/**
    The slave transaction class extends from the ATB transaction base class
    svt_atb_transaction. The slave transaction class contains the constraints
    for slave specific members in the base transaction class.
    svt_atb_slave_transaction is used for specifying slave response to the
    slave component. In addition to this, at the end of each transaction on the
    ATB port, the slave VIP component provides object of type
    svt_atb_slave_transaction from its analysis ports, in active and passive
    mode.
 */

typedef class svt_atb_port_configuration;

class svt_atb_slave_transaction extends svt_atb_transaction;
 
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_atb_slave_transaction", "class" );
  `endif

  `ifdef INCA
  //local rand svt_atb_port_configuration::atb_interface_type_enum slave_interface_type;
  `endif

  /**
    * if flush_valid_enable is set to '1' only then slave will assert afvalid
    * otherwise it will keep it deasserted.
    */
  rand bit flush_valid_enable = 1;

  /** defines delay slave driver will wait before asserting afvalid */
  rand int unsigned flush_valid_delay = 1;
 
  /**
    * if syncreq_enable is set to '1' only then slave will assert syncreq
    * for one clock cycle otherwise, it will keep it deasserted.
    */
  rand bit syncreq_enable = 1;

  /** defines delay slave driver will wait before asserting syncreq */
  rand int unsigned syncreq_delay = 1;
 
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

    constraint slave_transaction_valid_ranges {

      solve burst_length before data_ready_delay;
`ifdef INCA
      //slave_interface_type == port_cfg.atb_interface_type;
`endif

     data_ready_delay.size() == burst_length;
     flush_valid_delay inside  {`SVT_ATB_FLUSH_VALID_DELAY_RANGE};
     syncreq_delay     inside  {`SVT_ATB_SYNCREQ_DELAY_RANGE};
  }
 
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JMz6LNYRBu1mQqEbFGbxZsMzkDhvk8jWMfSzh9At1rMulHIn913FOCquEjPVdAae
nYr0eT86ml1a0dzKGz4xEcUqxm4Ek4pnK5D4r33NCYDR/XpVm7bZ69XfVv4NvtHz
TIXDWWhavphDAqKeKYHn+YGmn4L9KdGW3eMLpQtQpDw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2048      )
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
`pragma protect end_protected


`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_atb_slave_transaction", svt_atb_port_configuration port_cfg_handle = null);

`else
 `svt_vmm_data_new(svt_atb_slave_transaction)
  extern function new (vmm_log log = null, svt_atb_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_atb_slave_transaction)
   `svt_data_member_end(svt_atb_slave_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * pre_randomize does the following
   * 1) Tests the validity of the configuration
   */
  extern function void pre_randomize ();

  //----------------------------------------------------------------------------
  /**
   * post_randomize. 
   * Calls super.
   */
  extern function void post_randomize ();

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

`ifdef SVT_UVM_TECHNOLOGY
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  extern function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else

  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_atb_slave_transaction.
   */
  extern virtual function vmm_data do_allocate ();

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

`endif // SVT_UVM_TECHNOLOGY

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
   * Does basic validation of the object contents.
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);
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
 
  //-----------------------------------------------------------------------------------------

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Jyjxohjnp4yzSGJz/bcHUquOXaJ+19NexHCkmADKwaKYR4Kx5rj6rEo6h36IbISc
Z7cvmb6Upnn3cXtWmkyf5njpZWKsIhjPYBo1TsKEBQSuGX2AX6fL5v/5wYabINZm
JBTsZCkCqkBcskDvAuS1QmwkjchyF0Vl6R6Uht+9s28=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2168      )
lhtIjZ4MB501WRptoAwFRc1nPZd1+Jdm3uMUJoeo0J7gYSKE9f/Lp4KEvagTuuBj
zxXKZO9xqtf0CkUoNEIeuPuMxz5yTTrWquLUqafP304RjDK92zervyurZ8YUPx9e
A8Z4rCyOLios1cp7mI8+qq7RQwNPBBViXOfBtqHzqM4=
`pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_class_factory(svt_atb_slave_transaction)      
  `endif  

  /**
    * adds data bytes to data_byte array of transaction handle from dataword captured
    * from physical bus.
    *
    * @param dataword : data captured from corresponding interface (atdata)
    * @param num_beat : databeat number for which current dataword is being added. (default 0)
    * @param valid_bytes_only : only bytes which are indicated valid should be added (default 0)
    */
  extern virtual function void add_databeat(bit[`SVT_ATB_MAX_DATA_WIDTH-1:0] dataword, int num_beat=0, bit valid_bytes_only=0);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

`else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

endclass

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N2by4ar9zZedXqou8KNTIUZy3/kE4yX9kqDdSkfUgo3Mn0uIYq/4m2PMOyWzPJa+
Ff+hyySuwI6TU8C+VCsS8uNnH6hLerC7Ex8FFritJEa7FZCtCZ+veDF9uOmEPuSQ
JBcvR2g5hRsR++cYqHnE5FjnDBzU0NKHkq9uHe55dfM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2682      )
um9MECxyRhC/My9ZhrhXr7d9ybJpiZ/VCuFHjNwXQpuYO9f4JeMOkcg07tuM0Tti
+8I+f7p4on4FRf4o6VkpeKkT2/Hm6rZt5pqkTG3AlRCXHNodCEMAjiynMP+uaulD
SDCvwPNuny1fjJ/gS+sWTEwZMeN0GmgOC0tqEh0R7IK/auMahlZWJwiLJ7lD2XRp
lKfY3QCWg0N/MN5sWGGg/8cnMWjfXwAnv0zgZxsLgW7BxOID6YCLNYXNQkyknX4/
wV8+uANa8QI+4vXupgNz92V8B3BMeAl1vRHSBcuox99E5zHRLV+rFqi4z+u8hUm2
I4s1DaS2i+NruH/QXNkea/MZM2U9dqivyhNO7ArhPEfNPl+vIVNjuw39PhYr37lx
82/C9HEQxUV84Ajmtxk4BNVfCxbNOGEvWGgUqWHpyZOO2GZR6RlBiaXbtqK+da8/
rysJuLrExJaA+/A2ph7V65wGylbtMtF2tUPQvkHDTqx4+g19yz2nzk8PbWDQLTCN
hq0FZMN2jg572alU7VCRzSTEGtbuB+xib00lYStFY0nJjjP8xBegJRtKMl1/aShm
xWhWXehms7+Hhw4PGuIuIgAhBFynIRGYTQjso12m11LjOhDDk65Xh8MPd2WhY1xw
C48IAY/yKQYIMy49r73EVMRTQuwjZyZYl9qXcIwfhRLL5o6pSHYhXpw1v1JYLK0n
`pragma protect end_protected

// =============================================================================
/**

Unitlity Methods for the svt_atb_slave_transaction class
*/


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MfqqOw4D/gaqlmPENWk8L4HgiN0FZ8RNAJGU4em9ql1L56VnfI0wMrkVGoDC6XsY
78UMgoUWOHd3mUtaargN9xQl/KWRcH640207itxjo6QEmjxW+DHROaWAblXRgWGK
IAE3Wkk4j5wN3NjBet1FBZgQ5cSkkOIxz0LmWECz/is=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3904      )
RCLtcx5tOG/Tcw058Lfo9cp5HkR+fVtGAsnxYWffFRrMwrHIt950CJdizAWU/jqZ
Mut5YSSz3bv24loWlaX/gkyxYFwKnS199BG/kfH9t07tqZXoGzgexzHkpC9/EIyU
4hJgGU3e54Eg3eQnA4K9smx+ZlT/USSdGystZ+dfYezT3j1RjvB+UW1w5jrvDW9C
VgTMpQzNbalMiNJokMFI52mrR2fd0VPweKkB1I+/kAizUDCPV0xHae+uV4EuBlyk
qRsJIWRpBN2tZ8lPMLj5ifyycw9vOGGYhDOSD14MQleGj9knazl6crKlVbndbtXE
Dc3Kppds/K/Vj5D9gET48aiUzFec6RkWE3eeW59LZGKHe7UIkQdZWakhdndk5E8M
Q5HFgXB07ORy/KRE92tL/L98vXc0rpz96bBZ0s/b5WXVoTvVUSIe4HDR7fEMN0cT
EHZcwBa3XOnXhNjEpLKTPK5w1ZnrYIFhvZN7YBSF1IUA2zUoqU6A7XiT70IKobFU
Wzt8Lz5jNrnXhtugSEg4CfDawCs0OU2Kh/xoWS+MkuZn959M5fqolNPuwJ8De2wn
EbrA/GvI9pvGVN0QfuQtT5zDX1RipdAWygJ0Nc55lpp8zQhQkFFBeE1sNRVXGKll
LLUpTc904TgZ9omfFXztMkYJnKaMriIhTy8Vom3aPq8c9FTOWNC5xz0Jn60eSCOn
d05cYMRZwTAEeRMJBWZz2/V5n5lreBQPguc3JtRTPnalJtQY1AOap8BAmhaV7vFy
ydvkpl25fgr0KKshVk8A8DXMGILTnnDGy45sSNO40vYb4bMXtYFwK0Clv1vbndMA
nQgoy3f5/9pUADjopN7jSjDqkBT8p+KlR6d9zdDFzR1iB9gakxxd7I0mdrp5apIA
BHeSywQefHNfYUYs1gbJFCM1bW3VC8IfaXZQ7XRXmVDY0gRTBv3Z8VgrWhXl/BnY
SMnfayc2b7wV0KbsPUhWc0Sc7AtrR5RfTRyCZ0FsLoDhq+daQG2BD7dzhhCxytCE
Bs6JGDYkKE80768XqjyaPLEe3cancyaBdK3QD+KemyCqUJ+RJMt2P1mZzfD6qp39
op83sP1AQiiu+cmXPCpQvfjSSYrXN+D2chQ2GhXgkawgvIEhrmpTAdnZsICwvcKV
UZnFEOs7V38usSaU51+2+pNAbagtYOQ1BnKgup/Bn1C5kkig4AUEO11QK1QqsUjb
xjGp9BTtD7nlXFEj60xlWZXuqp5/kyuqWm/INWD5uwiy3CeFjhu5lJK7z9OjpEXO
wEFpevVJwK4HArzofzQaLtD4GXtvFGC2nqnpnwCSOi89j+iqfHfkNC37KOkd7x/3
FcYbSzV+oJ+4Xc8No7K8sPqAuWMNfMFZi4k2PQx80TWmQyTnNRvidJeHoqJN8SzN
DxMAWjW8bxEhmV5wMHwJjr6CqAlj6hQ5hNY0hU2UrGFMZLbDvW7Pux23ONQfBDFe
BSnFBgM0n33i+26Kp2mu6KnJKIrJ9XvY6rldv5XGsF0+YCUalJYHrRySSBaAfcv3
Ig2ZY0XwcoHivjP2ZW4wLYMOyQK0TiXdu4RxHdRk4TBfpXTjIbvM+uilZCA4W94/
eVo8uIwmZTDvd6qp3L0+K5yyv4EpoiTmVUFndw4EFxI=
`pragma protect end_protected  
// -----------------------------------------------------------------------------
function void svt_atb_slave_transaction::pre_randomize ();
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hm+fcZarE8yO71nUFJIs06Bm/UdSJ90/k47cqtthWlbb2FueAPWfwptRkN1uLhyI
0FNKkrHzftAgoU1a79NzBR5GGDPT1OHQLjUKLi4eXD5+88yDgw1ALYrn3OwwN6i9
tsGaKnQ3gkQeq+74rDqQEOqnqi+U1j9EwJq4UNWVZLI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4477      )
/RfHiZbuGdzFQvRcwE8xJIi+pQ7cbZ5fP5QGnjbTwjU4JtHduGkH2Tox+UwOe25d
UyU3B36Heo1wU0w4AtHtoybjFJhkNEv/B7XEzUzax5XhXshFtSIjm7t2pl33M829
Egy4MH1z6VBDbscxjkCXPCdbkNWzyl0VuQ8QHqN/s58dd99yfdlCkHWT0TUjKePl
Zd5VUngKUQbcuZG5npIxRpccWp7Lm67AWh5B+BMQvi4N4MeJLHyuZpPgHKpfRu1U
Dknclm3Bs/1tjNQ7PtO1R3cuapJRyvY29/lT4fbuhVS8aujZJMpzrdV3A811ksTR
v//PM3pGBwlnmwzXSgHcEDvgSVF6gucL/z/WWUdpUZvd9JwzqKjrtWpeGXG4KpQJ
qcHP44aMkr5gYpnRn/hjTEsrNIfl93ZGt1JB+gpOqxO9qaTT8hoQ46u0STME+XOm
uEiluuqMHyxOWz1Cd7FUOHnTPaaapcj2ioLgmGkKUPIO3rZiMmHh154Dk03zsraZ
WPkHx+vGnv1QoPMODf8RLzzMTkBnKlMJZW/fqhGzsKce6Fo2ZBjwgfb4VpWBxJ5i
1wJV2rJUU3Aa62kBd6KPblT1d/749NfX2ADCl+tUjfw1kqrzoXUup/kqJkigkrzP
KSdPKOW+wQ0uaefkY1VzDS3tYUjzwMPqzfqsEjakh14GHw1m08TWLQAlLrePpEwX
/ZIRrtowIVUh93tUTaFseSFp97AeNWI4QOfrTIWdZyHik/VeDHyTtrZhcw6Umb8U
`pragma protect end_protected
endfunction: pre_randomize


  // -----------------------------------------------------------------------------
function void svt_atb_slave_transaction :: post_randomize();
  bit data_only = 1;
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ETuZq/LOVz7eeLUjVzmWxy40M+SPGaRKie+FjJqtDb/8gJKvLMPCkzIB+ocGGtTt
HGcF9CRG7ShVwHt7Dor6iOeqZcAVTtV7qq8OucyZbnbGKZwhrpNOq6m/PlkxWd5A
aDIMsd9PBA0hirrN41OkhYj4gbMmAihbBkBl1OMTxGo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4586      )
2KIvnzTxzZ2gfWB9+UVmsB1l29GV2mPBOh2Pu6DinoW5aHRenUaf+KQSbHGG0mYJ
oUnIG0ZzGvI0DE/oY0NbVWgSTgj3DMsv5JlNlconDBC/CCJKWPWPl5wsnJw2DOFe
Fq2r3YI1gCZkPDfbbvWo/w==
`pragma protect end_protected
endfunction

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aD4AT/d9AaSSql3//bsRJ+eAYVvaOT7xavevuWAl6OltELcDFL/V5ub1ZToto/ae
XGuGOQm+6Kkt8UxcDCrBqp2iqKyN++sgFnWc90+Lpm6yF/rP0oUZekthzklZ+TEV
m1T1M7ptjfgW2f5eN3wyKnT7cLEQU7/ZQ44vixgYFvk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18969     )
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
`pragma protect end_protected


`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_transaction_channel;
  typedef vmm_channel_typed#(svt_atb_slave_transaction) svt_atb_slave_input_port_type;
  `vmm_atomic_gen(svt_atb_slave_transaction, "VMM (Atomic) Generator for svt_atb_slave_transaction data objects")
  `vmm_scenario_gen(svt_atb_slave_transaction, "VMM (Scenario) Generator for svt_atb_slave_transaction data objects")
`endif 


`endif // GUARD_SVT_ATB_SLAVE_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JtNCae/c9qwjRHah9tcsO6o3AyEennk4z+8dWfFb+Uhr5JN2DUDUd9UH5a1V6e/y
4W+xIGPQDsLYs3mst/8ITa9BSgV0Oyn50rZFCPPcgorM2Hiv7QeCNvWT23ezIyj3
pWo489ve19HBb1nm7z5kgFchJDGXUDkugE8TMwP3RVA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19052     )
6f7zaZOAcmRE3kV96RAAIYBzrpjrrXlWs4iPz8zoUMzFM9Ht3x0BtwI/Geod2xUq
mDIe2KwvwnENjQNbD3mn/FnmTztB0MAPWVI1nLVb28zXdyJ5r/IQH88xKyfYghEH
`pragma protect end_protected
