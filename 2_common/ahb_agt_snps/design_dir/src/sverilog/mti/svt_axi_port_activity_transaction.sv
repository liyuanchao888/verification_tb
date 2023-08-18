
`ifndef GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
`define GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV

`include "svt_axi_transaction.sv"
`include "svt_axi_defines.svi"


/**
 *  This class is used to capture the AXI transactions as seen on the bus.
 *  It also captures the timing and cycle information
 */


class svt_axi_port_activity_transaction extends svt_axi_transaction;

  /**
   *  Handle to port configuration class. Must be provided through the
   *  constructor. 
   */
  svt_axi_port_configuration port_cfg;


  /**
   *  Transaction id obtrained from the Bus.
   */
  int port_id;

  /**
   *   This variable stores the cycle information for address valid on read and
   *   write transactions
   */
  int addr_valid_assertion_cycle;

  /**
   *  This variable stores the cycle information for data valid on read and
   *  write transactions
   */

  int data_valid_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response valid on a write
   *  transaction
   */
  int write_resp_valid_assertion_cycle;

  /**
   *  This variable stores the timing information for address ready  on read and
   *  write transactions
   */
  int addr_ready_assertion_cycle;

  /**
   *  This variable stores the timing information for data ready  on read and
   *  write transactions
   */

  int data_ready_assertion_cycle[];

  /**
   *  This variable stores the cycle information for response ready on a write
   *  transaction
   */

  int write_resp_ready_assertion_cycle;


  /**
   *   This variable stores the timing information for address valid on read and
   *   write transactions
   */

  real addr_valid_assertion_time;

  /**
   *  This variable stores the timing information for data valid on read and
   *  write transactions
   */

  real data_valid_assertion_time[];

  /**
   *  This variable stores the timing information for response valid on  write
   *  transactions
   */

  real write_resp_valid_assertion_time;

  /**
   *   This variable stores the timing information for address ready on read and
   *   write transactions
   */

  real addr_ready_assertion_time;


 /**
   *  This variable stores the timing information for data read on read and
   *  write transactions
   */

  real data_ready_assertion_time[];

 /**
   *  This variable stores the timing information for response ready on  write
   *  transactions
   */

  real write_resp_ready_assertion_time;



  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  `ifdef SVT_VMM_TECHNOLOGY
    local static vmm_log shared_log = new("svt_axi_port_activity_transaction", "class" );
  `endif

 
  `ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_port_activity_transaction_inst");

  `else
  `svt_vmm_data_new(svt_axi_port_activity_transaction)
    extern function new (vmm_log log = null);
  `endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_axi_port_activity_transaction)

    `svt_field_object    (port_cfg,  `SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
    `svt_field_int       (port_id,                             `SVT_HEX | `SVT_ALL_ON)
    `svt_field_int       (addr_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_valid_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_valid_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (addr_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_array_int (data_ready_assertion_cycle,          `SVT_DEC | `SVT_ALL_ON)
    `svt_field_int       (write_resp_ready_assertion_cycle,    `SVT_DEC | `SVT_ALL_ON)
    `svt_field_real      (addr_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_valid_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_valid_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (addr_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_array_real(data_ready_assertion_time,           `SVT_TIME | `SVT_ALL_ON)
    `svt_field_real      (write_resp_ready_assertion_time,     `SVT_TIME | `SVT_ALL_ON)
    
  `svt_data_member_end(svt_axi_port_activity_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[],
  input int unsigned offset = 0, input int kind = -1);
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
    extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned  offset = 0, input int len = -1, input int kind = -1);
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
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
   extern virtual function svt_pattern allocate_pattern ();
   
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HTVbT1V5sdDLS/0Jzl/yjQNx5qyDvO3gAxAGrq5pUIlJ0ZYYKOUh6pVZh8ICHVTp
3n9pDbLTqAHM+tWaSD33FeCRU/tiB75QA87/WHsY+bl5c0du+PphbFIONuOfTBFE
vQ4oF4dO0oyTHX/Ebw/Is1QdXXT3qPmQNPFJAPBqBFs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 121       )
EfN5wlhAxp8eRzWLfPRRxmdLxfHMWfoip2PJ9qfaD89CU8PdJeyhgNBq+ia9vHsF
SNr3ezU7/6jIzHSDa28i2MIKksOzRLizk+fqjPFtC5Vi5Bzzo1PEvk8TwYN0m/UL
vyl4TLGjnScxE7XDIGCK2Or6NJ0nRMugD6YZnOrTTUA=
`pragma protect end_protected
  `ifdef SVT_VMM_TECHNOLOGY
     `vmm_class_factory(svt_axi_port_activity_transaction)      
  `endif  

endclass

// =============================================================================
/**
svt_axi_port_activity_transaction class utility methods definition
*/

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eNRVnSWDxZIqIUPujacmK3O+GzyMs0ob7yy7mBLKXRBI4GG6cK6K9RQtWbgxomo/
PdQisap0S9B1x56nMcpHqKEKF77n0B0UcZpWWpHxWAZJPSB5jRHZf2YwzktWcpE7
nPJk5c56RFo3luL5pFxeELUNSgc6SXfqatCcef0K2dA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 666       )
KV1fSp//NH20uTIS7+5RWETicXe7LUC+PYnbPti1DhA6j2rkBd1Hr9aJpesefMwh
a0kLO6cwY2RWEzCK8CfczOYwRkE/atnOyUffiTe/52lW4vWGhcqp1uyGmZi4OyDw
HcsuriS0FhJ9k18ye0ZDK9Q5tNAekR8Lq4u9Deog7tB9jZq0ZcyJoPaSVdTWUYDo
ZL5M77AE4eKV1UG+PCcoN+1JrJsplouGL4g6GuCb6Xb0jxl18L+8lNROUvd9rKnb
fOkX8rMxNQ58FxKQ+LQfRCGaz5mNxfXosO3CoPhkDQKaO8DKK84m9OzOkz0zWPcn
66ci5zx/GOxyCLv9W5fsv+WDua3iHf26MhaPFN/V48T77KTkTL36j0I/na6LV9Yw
P8x8uF7A5vg/ezUR8AKXMBOVJBX6klfk2zJwtXWwH7S5j+nx5p9gGYCLSgfHf62u
mipjip6waV+4Fz07Lqp/jYukF2t2r8ivmL7op23uxf91ideYBBGdQBFfK/YTqy22
JO5eAJWBx/PHcmzC09CPoshwd9Ikg1qAn/5hXvuC6dwZ52jAdN4rQt34J6xCX518
9PlOTy5/N6ND3Rgku8irYD6XzPSRcapVu7oiILX5q48KwyPoprJqoDk/TiLP7pgR
0kyRBBnLbK6dbKttzG6sYv9cEAtVdSLq8wY9rhB7AloK+30EKoczERMe35C5gOhV
R/f2SQEUaj9MR99kvd4THZCRoR23BD8dfRthgLgGPhw=
`pragma protect end_protected  
  
  // -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
maqtSm7D5oz5dbC92bdnVAfzxUy3p2COhX7ge9+jTY2v8Z/lPW06lhPBsg84Atbl
+FWaV5HlCXeqctywkoig127Vrpb/4E96mVExiRvs6+kfW0nvDiFeLLBV5PnTbjHW
PQVIKcJaQuMtJ4hJZ6Ko0DJNnQcz6IEaY5JpTftK+/g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11284     )
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
mXGQeSdPsljMNXi9QqvjkA==
`pragma protect end_protected

`endif // GUARD_SVT_AXI_PORT_ACTIVITY_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lL0E+4y+T9f8TZyAadK+8B7vjKWnrW3NZvsh4UDKubPUz3FJqbnaNKQKnaRU+Wk4
xEmBrh1PnK5FfKnAEzcKXXzgKbixIS+h7B2a8ua9f6B3wzIZquqd1vkB43GpQ/hw
UB1JmyQxxX8nZFjs8cHhi/zjfW6IT1jKIwONDpAMMaA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11367     )
rPTFKw0oac8HWxm8bOBM1quomVUdPQ7/zZDAutx8V2ZLTmzw9IF8gPYjPIXP+dKT
An2ltV5rT/XeLWKDqeKoydA/wuK+lLYRhdz6gdQZucI7jCHeTds4VfdCUZwauw3e
`pragma protect end_protected
