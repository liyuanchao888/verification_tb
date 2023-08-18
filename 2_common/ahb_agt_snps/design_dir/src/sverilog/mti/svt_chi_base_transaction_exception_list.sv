//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_base_transaction;
typedef class svt_chi_base_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_base_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_base_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_base_transaction_exception_list instance.
 */
`define SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_base_transaction_exception_list exception list.
 */
class svt_chi_base_transaction_exception_list extends svt_exception_list#(svt_chi_base_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_base_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_base_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_base_transaction_exception_list", svt_chi_base_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_base_transaction_exception_list)
  `svt_data_member_end(svt_chi_base_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_base_transaction_exception_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Does basic validation of the object contents. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in a COMPLETE validity check.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Pushes the configuration and transaction into the randomized exception object.
   */
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_base_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_base_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_base_transaction_exception_list)
  `vmm_class_factory(svt_chi_base_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i1umJZkccTSUtEe7W/VtnLk8JbmGZm6RlQSXiHkxUN46QlgblnxmbGsazJ7jfxi4
3a3P8XJEZ90TSjekjKMqeQ4/DLUkzIjQRtcUhy/rpuBD2eEcP39iCoUowPHvP1SU
WRV0nVetyIL1b1F/r5488TWg3qx/+xwbVsf3O7g4MWc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1052      )
u7myHN15M3BxRUyWsj1fDK1OzVtVt3pn9gbz0LiOOaWbygWK4O/NNl1KM8Fhc5cE
u5tawA7uHR85Qr6mERTYeoz3MlFDg0ENXzXjcF7JvcYM54nYbiBsgpVP6cqTd3T7
X7+hg8MTepteMuvBtegcqVaB4rp5d1ANHZFwr3vU/3LwlZp3DmTDL8WABWUISXQc
tJIthBwl5jMK7BuVWD3ZzGgh9ogs082dKGe/+NRyhKkyrSAF8XsKrZAXG9gz4lLM
jHN9rL2sucsoX7GZb6Y9uoDf89uOzud+xeW/ePL8UjzJeCTe1SPN5UIjiizvSm1+
z/r8riBOq/NuvYJvKroEmUwI5dImMLGJF9ojo+CcoRIaW8iDq6LO+yTNHM+w2tNW
LwyMnQVD5bGsPrTRXGYeBhH39ipy7TmWqoDRjRVxGZ82EswXGfsJqmgRMqgTth8B
JsHwiFQ7XTOSzHGo4J33iymKP+9q72CYrns/DlSN8GirNyATx/tZ9082hnwv8pLG
PTNxfwvZz3UBiR5PNxgGm7KbdR3bkN/oC7Se6cjekGPhBFL9/TOb8WPV1jOVvEGe
yu3eQjc9/0jdIRdTO6wxfZZnFJmi5WSBcX5mDsK5OJfkZ2nDhQgjjNhcjbHuWvbc
Mdf3ANGQIAJ5J1nwieUnmA/P3b6NlvnZzESieEIFfuYd80lLeGdiYdCyi9zQyyiB
fd7ONbaxtpAzM1d9Kir7BcnOJ/VOZ0WXqksOOtUgmgIk+2wpMQ3jarmIhJtzdtfu
4hwtlBCEA0r7elpdePaz87TTHZwAmVbgf+utoga23Ff9Sxa/xEZr9mYKakY7d0am
BQxQwwX4e9pL7wqZMQHkDGdGiDsq4GR5kNkGINqGx4QgHuFWep5y+XWP5zbcXCFk
QQXg8sBleBYSRCCJMsQDZKaOzhjwJSteuxr8PnG/jsnNj07/Xypqe9OMm8Y5nAMQ
feBDtmmNozhbvY4pnLQntqfWildk04lKYmbWcknNyJzsc79yrI2U6gyF4N03xMQS
KtCikZFcJpBLpPyvRLYis3qiG60wDJcZslzuiZJv014sjc0qbvzAUnmorhUj25H9
iovtedYinR00D01Xxojly4aWrNpfdtPj3LAonFXYcCH2/d/3LE9ulI2dqKgNoT2c
FMZLAfSB4EMckDEwYHuH18StPlgxUGDMSH4Ya1olc05OpUFu7Kzgi0XcgoC/Aalm
bTHiH33ImJ3B3P+ZWe+UhN9MuvDri8KQ4vEaDr/WNtWHGxfNG4Xg04eMq43bSuVs
5uOzu/rewt5nvvkOPMsCR7eduRCSCsrWHZs7jmBdMOEImje9ppW4wxG0KQK+PADR
IM7lOp52WvD0xspaRRT9idZ4pC1iSwRFRCCXJh00HnZ20tbEPKgguRR0j8WRWPM1
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LOpU7wwSNq5dzAHlTZI4RumLKs0ms9FQDMVtbOLQpbC4d3sVGsknbiYhf6+uo99D
+nlkZxqfAj9e+8cR3KrX8o3frTbgVhSYqJ9iOAtIUS0+XBk1Q5oOb1wyPOHTzePY
sL3pRvheq2JUtbQQCLmnpKZGvdWQs9TZOQKDqkOePXU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9060      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YhF1PWDPObKzyM81UQik341CjnHvr9t4wquULEOjYHosIXMS7uJMbarcNOMB8sgW
sIlmQtflbxmbXIo8WK3Qt4Ni53kcbnIfKN2B+vnlJiPLQPe9uN2Hm43ODCFoEoSD
5LUcz9F0gKxqmJdY//VA59g2MEtAvvf0HJNeavAXrUk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9143      )
6641+4+AaYMdC862oXBGIM1KJRTgPFychyjfwDRHIshSGHBFKQEHIOMFqlSPYWID
FYFuxLJem2voF31HHP76fHSg472yCyb7xGuCpV/d4kFa8SzIvofeiERNQ70XMhZB
`pragma protect end_protected
