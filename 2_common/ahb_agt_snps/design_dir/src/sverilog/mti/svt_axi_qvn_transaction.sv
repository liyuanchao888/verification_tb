
`ifndef SVT_AXI_QVN_TRANSACTION
`define SVT_AXI_QVN_TRANSACTION

/**
 * svt_axi_qvn_transaction class is used to represent a QVN transaction 
 * received from a master component to a slave component. At the end of each
 * transaction, the slave port monitor will construct qvn request transaction class 
 * and populate them. 
 */
class svt_axi_qvn_transaction extends svt_axi_slave_transaction;

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_qvn_transaction)
  local static vmm_log shared_log = new("svt_axi_qvn_transaction", "class" );
`endif
 
  /**
    @grouphdr qvn_parameters Generic QVN configuration parameters
    This group contains generic QVN attributes which are used for QVN transactions
    */

  /**
    @grouphdr qvn_delays QVN delay configuration parameters
    This group contains attributes which are used for configuring the delays between valid and ready for QVN channels
    */


  /**
   *  Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ_ADDR      = `SVT_AXI_QVN_TRANSACTION_TYPE_READ_ADDR,
    WRITE_ADDR     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_ADDR,
    WRITE_DATA     = `SVT_AXI_QVN_TRANSACTION_TYPE_WRITE_DATA
  } qvn_xact_type_enum;
  
  /**
    * @groupname qvn_delays
    * Used for introducing delay between QVN token request and grant; not valid when v*awready_token_grant_mode==1
    */
  rand int unsigned valid_to_ready_token_delay;
  //rand int unsigned vwvalidvnx_to_vwready_token_delay   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  //rand int unsigned varvalidvnx_to_varready_token_delay [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];

  /**
    * @groupname qvn_parameters
    * Address VNx QoS signals
    */
  rand logic [3:0] token_req_qos;
  /*rand logic [3:0] vawqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];
  rand logic [3:0] varqosvnx   [`SVT_AXI_QVN_MAX_NUM_VIRTUAL_NETWORK-1:0];*/

  /**
    * @groupname qvn_parameters
    * Represents the qvn transaction type.
    * Following are the possible transaction types:
    * - READ ADDR  : Represent a READ ADDR transaction. 
    * - WRITE ADDR : Represents a WRITE ADDR transaction.
    * - WRITE DATA : Represents a WRITE DATA transaction.
    * .
    */
  rand qvn_xact_type_enum qvn_xact_type = WRITE_ADDR;


//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Rv734QUaBWfXFAN3Da6KEKyG1vN4AGCjgFGjsIvLOrpEuc2TAwc7w9h9rNrGxjEt
Xmn0HxTL1WczdfWoYVjO2hmPWXdUzW5c3pZgrplwYVEMM6cpUmq6Hn0mUTJZQYn0
GiyzPtbLp8ILOGQRbTajeJUd1klrcDwdEbydiU3OvoU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 950       )
xMfqKoIYizz4zc6H1XuI5ZFpAEp2QyFQLEYdiqHAtk3DNvQmT2Zz6gkA7FF207BM
Vn9a46RrzymfHSoZkLx0C7v5+wRW5XjDNC3QfcdR8suhEmPlMJ7jJ3YBH5bYl9Gq
yIHkvl27+3RyqjIkGWQP9R7B+88b7uZGsUk8Q+aktMkWV/n4ekoyOHID2DsZxiU8
vmwxy72Q3YRH1EA/iz+BP9QkfSU+sMOdKpWpHCbi46i8uJv4oK6B9L/I65N3j1u+
JVjFFXPlHDA3XPxW5vcQS0I0p35HxSRWCO8hWEg6Lx1ogD0GV1rLgWbIKD5DgMV6
tHoHG2Q+mPDWrxbyZv3ORwP8rKexs5OF5hTodMQgCFp5HuQP73+R+EW6n5DzPhfc
PRh5u7JGd+EPvkrXxb6HZWTi7Vhp5i+WQOIxSk4GWO2aR3rkneCisWtw8NZMuk9z
ca6sc0lIFSRqF3kb41p8JweDq9LcLfxskfyWm5aM27a+gPh8xgSI6eblIPw72g55
kKaVKElcsbdT7WQKO5A8Ho89npJ/KR1rVJW7RmqUCrsDwlXkLuXSOLuEGwVo0tKN
0PSLh8v4tLQBx+tjAio+5wLKG73CT9LsSqQyuUV8pUnJDnBK/SbsACz9NcSdefFt
6JHtrzMUnd4tyAX3k5rbGquNDoWHh4HlIXlU/nAycoTgwEW3zQDEhm5ZsngBbiob
zw6zhzNwY3JmVL8l1HicsTH98MVlmV9S21v7G7R0R/IxbZ2MGmV9scDZaecIsz4j
lzRWPP7vUU9UL6VnSLVqTa3T/b0Vd0DPvpQrkJql6IgAcKziwwCF8EqaeeUM+zsr
nq6q/5X7N0D1SQc0Xtgz4IpcWoLFKnD0VXpjy6S/evZ/5BWpD8yJWthjq4Vua7aF
z0nujPtSs2T3hARrxjVkrMoALgkytCn8O3gk68BgY36/3Dh+N6LmIySZ+tN6vRhd
IvDUdacJ/xu1DMX6B2h124u7TUqSsVU49Ca7vx6oSjWfIo4pmukYyRQ8O2xJBZV1
f2tHfG+jB9ggiguGmzcoZSx+FtbxzKJVTTkrOxUGn6Ur4mI82V/SZ/+75wdZ7iO7
SvoobN5A3hzcDzgFYOwgnjq4L/Fn0mTbL/fXcnZ6Ou9+O3Pm/QSGqw2CUXX7cYOj
5AFiqDjh7+o59e2LIUj0leEsO6RgeDDRfR06awrw3hIyHnxvIe3qClPYYfrKbBZb
hBrDhqh4S5mKgK568xm3gLndqq7V3uownJqxYRUJwdocftNFFVrOszS/sRJlnV7t
`pragma protect end_protected   


  //----------------------------------------------------------------------------
  `ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new(string name = "svt_axi_qvn_transaction_inst", svt_axi_port_configuration port_cfg_handle = null);
  `else
  `svt_vmm_data_new(svt_axi_qvn_transaction)
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
  
  `endif

  `svt_data_member_begin(svt_axi_qvn_transaction)
    /*`svt_field_sarray_int (vawvalidvnx_to_vawready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varvalidvnx_to_varready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (vwvalidvnx_to_vwready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
    `svt_field_int (valid_to_ready_token_delay,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_enum (qvn_xact_type_enum, qvn_xact_type,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_int (token_req_qos,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    /*`svt_field_sarray_int (vawqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)
    `svt_field_sarray_int (varqosvnx,`SVT_NOCOPY|`SVT_DEC|`SVT_ALL_ON)*/
  `svt_data_member_end(svt_axi_qvn_transaction)

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

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  
  extern function void pre_randomize ();
  extern function void post_randomize ();
  extern virtual function string display (string pfx="");
  extern virtual function void set_rand_mode (int en=0, string mode="disable_all");

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
`endif
  
  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Allocates a new object of type svt_axi_qvn_transaction.
   */
  extern virtual function vmm_data do_allocate ();


  `vmm_class_factory(svt_axi_qvn_transaction);
`endif
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CHDLAkf+Dtj7QsGOO6H4EFcXICTVq5WLGQozhB1Jj/5i7b0abaMAMpElzqvb4PPu
nQA9fUt/j2mnxDJhQNnejpxbwdWOJaIexNl0laAuDhgrSWpMbYznJ3bjEJDSYsMY
8WmWbkMRaWruiUfaQydwzz1x/IDqoWCHAFdAqondlXI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1737      )
FiCtK4UhmLs61pqXeqt36pTgovK451VjL+7AI39UNYQQT0tuZOkHxRBfj7JYMbCD
tpHSQaUokQkRKSZZrMy+gnCqW4E19XU8orXb1TUV6TOtbaMv4QGY15oy1jFsD91I
GU1s1GQn4OOhRsYV/8gAOxASFA3vTgzyyWh67K9+GuzubCnHDSa171C3yIjfypul
hOXKaQScVER+UQ1lm2W97tpk6bwtLXP4wq9mGVsvb9c00WZHUMObcgahOZXz1Jh2
k+R6Jd2gAn5LVjPI6cgelbA8Wm+wGr0YPBki9RFI01UVLAtA6XFJPY1BMsk/jOlA
tu1RVqmUudmJItwPX6y1XLg07wZzOrOzRepp7pRkwBxBLpAbzlwgUBvpMtb6Lqtr
VCO3Q47p0M/iun/HKK04XWQu1QOMoqsMnetBvNzxSnhnvgkEx+scweV1Ky/J4qAs
yVcFUI0CgvI6wcvd7/c4d99frgn8u8Mid0pX19qXt0vmpZqCRUiNoWkeiEAlX/vO
rAzvd6g7Avl9lkuUDqOV98EvT5YkxPiXPpzgPcB/fKC5gbgMXDThDwihY0fAFxNj
tV/zOfyYsVXi8kgixQvGcjpoVp7K7fN7/GqdW4XzeRPQBfPs1D1aflRNEXBMYAoQ
3nKOUQxeZ1T6X779gDmKRBgaWTjfz2VDQkl/Wn2ET7aHoKxP/hk3rdl8/U0So+Eg
3uh5jkMnFzNcRMoNkQUoTaNX/Um23RVNbiS2KRz2/R2XjaGH5t5FGHbR29cT+pRr
BMrtVSVNnkzlZrBzRuBr27KgjolJIkuHHPsPAbgzEgyD95KpR/h8gH7j94RTnPY1
yR9+BKo4oox9E4TbSs/dGkzDJH9HN1yJZNmmVb4v3eZ5he1LfVvXW8NOA1oW3YVZ
z6sqYXDjg0MwCpmOnnCs4CGl0N7jRbshTGdKeDjps9FkHab/Dc7DGMDpCIUmpv4a
0mA/GjqrelkYwHz6jt62edr45L3eMa2V/gxDB+/IS+LqEY5mP38r34H7FakqXeQH
XNZdZlxVRjw31N1V3QxcVV6iXsnagZukwfLQYN8IXgQ=
`pragma protect end_protected

// vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SklI6KASblT+FliY8L5YO8f9hg0dgm2su/+BdFXOo2Luo+Ygc5JwuHrRzywK9t1U
nocOJ0w60aMnAMNJJgDYR/Yuy1MNSTObwnj/DGpasW4WBtf6Cxfm9Al4xlPovJt1
A8WfyocPVblpfP4Xh+PsQfw17fh627YPHj3knyk4RH4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8197      )
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
`pragma protect end_protected

`endif // SVT_AXI_QVN_TRANSACTION
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FaRDfJngq5mdLUv5ou1iLLZzJWEY0LRaTswMZeQAJvn+odfPh786NtVpLpaRW95j
FLKDl9s3oK3jVQ50Ta/fwOjcgnUjdJyMN3JcQAHrdv1OTMNWV685KLPwnncoiS1Q
jkqsNMcbuAy6CZh8yl/1WNwoW0QZm3RI74BU7Ropm0g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8280      )
lhY+3XFCt25XV6WgYV3FaXsRrgXa6ge3AhOTipdI5ohvOKydasev7e3CQ8/Y2Y+j
oAX+PV54wDyrMYIUNkRSpZ26WzErN6ln+oaSG+BTocT9RazW01xjXUFHCftaRxPv
`pragma protect end_protected
