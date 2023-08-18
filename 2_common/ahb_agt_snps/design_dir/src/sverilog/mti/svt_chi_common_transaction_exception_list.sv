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

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_common_transaction;
typedef class svt_chi_common_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_common_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_common_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_common_transaction_exception_list instance.
 */
`define SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_common_transaction_exception_list exception list.
 */
class svt_chi_common_transaction_exception_list extends svt_exception_list#(svt_chi_common_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_common_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_common_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_common_transaction_exception_list", svt_chi_common_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_common_transaction_exception_list)
  `svt_data_member_end(svt_chi_common_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_common_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_common_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_common_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_common_transaction_exception_list)
  `vmm_class_factory(svt_chi_common_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Oka2R4b8u72sPhKqP+Pe7dBtLmSdzmuvOmBtDb1iuDAlO3fAPTXVIyNmOWiBU9Ew
X0/EIT3UMqo567PWwnLexk4xnycq9VRRMkrS6pkhL80a25UEoewQ1Nji1UiosUSS
fjQcVyqWmy1iq1psgYwqB9sZQbWiSnKq2s0O6x8of60=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1068      )
x+qGhSSCjgLoogXRL87lJcHpoaYNcBdaQTxI3mRLVYnPYOlmr8LSxNkeLcQMUp+F
dDT2ktg1IE3OCj1WD7fP3TByw8JtZsEqVTpZj2/RrGt0TuTHFINp8c89PIimu0m8
1UhIqEjzmnJu4eEr5cEi4StWpzMlvMIpJg5RXipP1ZoEsvzNiGboAsew9U1X3Luf
M6DFFUDZaj34d+Sc8/TKDy79qb9z5C3T3GWXYG7jObXPwwV3EtUn55z0bux216MP
xaolUbRII9D4kDanPmLzkdAJcOBVl8eOOjnUl5Z4YqYsT8D6HCqI9YXLdS4XGtUu
6QtPvM5KzC6mDBCHcxSu9Qfy6gdgG4j+VOR3qYtAOdyVaKdLmqPCeWh3Iy91DlEn
V13dK1HQABuDPRoQgSBP9S9/3CPq17Hhni8Q7qlOa8Qb/Lbm4vKYnaSzf17DkHnr
Aq07ld7iSjBz9GL8i58/pnM+xNVJmUKGUU/V+QC4pt2N58lkeFt4kUmoNnOoqN0k
vbDKWNn1aQ8n/OSM8ap7Xiv5J9dIWxjwJl+RKFT54czpPVytMzIsWzyg3b5HG/P8
0dV+vKkWE8omc21B3FSn23c7QSVjPjph6MTMgZmrwxGnRy+q8tC+vr9TacEjahck
VgeRYG3nld0pH0HWlHcWu3pE5iuZORU2vGW81twaZuzIcFHmL1CmW/JoAmbvNfVM
M5cMDHFEVj+wAAAuC/std7fgd8K6pC+eYknj3sVKS1+Dbzcgi0Cl7DTGTfjWmDhd
3SJVN4oxJPBfN722PKBSuRiR+IKgrJaDwx9UQbmlWpzhN/OnAou7WO7wSemwgyJP
fhaQ3fJl+NXyFVrtDlF0Ak8a6c4LcIsKp1T14lICtdosr5a3xndWpwvr5WKAVTwR
gpkFjT51IysZKOIBgjZD/YZo9IZCLmjDDi7l9CEABQ/DQYCNl0rNwT0leSqrIr9o
87dNQkehQwGUk1hoDzbdGie7XL3z165f0nM8LOJCpLmFpTlZg6DubI7U0XwNt4GN
tUZUPAHVgzvGnUUydz2LveU8x7fZ3jzimlud/AEFp7x8BvB33mTsXnEjFWUcsJad
vEid32SOXTuRnL5X6tJ/3x+7ixw5j0qkHMxLaI8OM4sUkEBLe7nNxvCQtCNFyVuq
CopUq6oNOlw7eAqqA+FMsg2lv3hnVsOFnRVjpG17NhqCIwiZBRK6HyoAowPBF/jR
3RQ4FwQPEGW17wMLpPTa3+BfKkxp6fq+aZyDztS6PXDhZSeHzndHIWwykZ+LhRX+
fnr5EpblZenwCZuo8+T3oDYym1uh+HhP3mNuPgzO+nLsRhTnp/V15lq/aRCeZ1yr
XrzElHaJ0Wlp0T9AhZk1wDKccPpuxsEmP/Wl22OfbOw89FL6JnkEOyRNWFfl+xrz
9Gf5MUa57ucwkREYN9vGsQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hA+Kqcllx6h6roenDBVcsL548rKEqgwD/2tKr/TBM2XIMoqKtUjBu8CmyXnSTo2D
3XTiMCM3YduuXt76SWJ5A0u8u1UJGvg+LR0bwwHqpnnKJsS1XUqec80ORFKudkG5
AK2/SazSnuoRXbi5kyL4oBP/jVo0D79PFq5mTDntxnI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9120      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FyuwT9K9+3Lbja82vjUlZ+e/dbABZvJEMQKv3ZbxxLSgr2jdWnjC5UeDARM6gWBS
VuDeYe/vQ7boBfs76pfUSq6Kr3qI/VGwQA61dPlqQ4tjd+9eeNt30nCoq9fPMJkg
vybea3C6jOlt4OGLUe+98xlVnPLrvPhNFjTS4kArheM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9203      )
azFFyx+bmm+u+IW+X+eq1MAOdUAt0i1TPMa2RNqEKKXTShBxJk4JP2CkShUInWqH
3vqrx3Hiv4eIUuD2o4oWiAIJbgNtWJO215BoXbO9BAP9nxtO7ZSjBfEp5C22fErq
`pragma protect end_protected
