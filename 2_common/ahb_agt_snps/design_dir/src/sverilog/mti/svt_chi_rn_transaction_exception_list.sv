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

`ifndef GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_rn_transaction;
typedef class svt_chi_rn_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_rn_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_rn_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_rn_transaction_exception_list instance.
 */
`define SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_rn_transaction_exception_list exception list.
 */
class svt_chi_rn_transaction_exception_list extends svt_exception_list#(svt_chi_rn_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_rn_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_rn_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_rn_transaction_exception_list", svt_chi_rn_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_rn_transaction_exception_list)
  `svt_data_member_end(svt_chi_rn_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_rn_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_rn_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_rn_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_rn_transaction_exception_list)
  `vmm_class_factory(svt_chi_rn_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
creiFSlpUkV+mdW/UBNngalm6zBtqhLqMGc+PpZH83/vVFMOOJ2u1LkVrb1rUD2y
qNg4yz/idNjygzw7HR9AHVpVX35KL6GMWo14zUKe3ITmtNk20K6mz/KVnocauxGF
PbTlIOXZlmFmESFLiHncQj9vjSvS+wL0pW+eAYUkDaE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1036      )
sQ8ojpu7+waPgGRXI7dOP0Gd2Q36pnsY5dvoqbreS1dLHCeTNGljZMP1KZG3OAdx
5/NOS7+ose2M3A8NPwuw5qhBME3KFH8WMXpyUMD8jA/1MddxghW7VyGTyH9Vjrgh
MYK03FBY6Wm0ME+vZiNQ0ruWMcB9I/E03TrqmIL1gqxgD/Bow7cFAPx4gOI5x+/a
KogUdzKwQcyorsQWevETFCQnHe7EI0Z8R5c89HpvtW8qIBmI6ZKC/MgU9GIK5BK8
Fjz2MlxawOaSGxjwpP+AfsA7lbKKNOnT0vxq3kt6hwYufnIq62kECRfRMh/nCifr
ZYmCNbkKD4IT47NTgJ933q4BR3w/mg/qfjQ5yEu0zwiBm+ibW3hNqHer5sMgrHzt
JOBIjal2Ss1YfH74kDcJhhAIYk7DWUZMUmhfpO+DlAsbdN7YD92L+q+bPCKM78IB
mLB7PuXA4lQ6AdVSCcLrvBDzz1vo12fR91iePO1Xk0OjDvy0KCuAb5Denl1ufVh2
eDN0J8xGKDEIEo4ZNBdbwLqppS/PEEDUhBhYV99GUn472YCCSwWHLai/JkkM2VnG
RECk2+KaRuQJ1lfwSJplpgIdEDCJg7+0/dysULX3Re7h8Kt5JK27+zZWxz/bigIz
59J4+zH341gB90lcxSzeAmZ5igNmwE6Xj3YPdZX8PVGB55RT6yhOnGS1q2NREpyF
Zw1Xzb2nPPYhiQuZ4qjXnRu64Y5VsAqma6NDY365hME8XVGOALXUV/Ts3YEyW659
4bIW3FsnrnOdtkfsAH9ecJ+0NqrB8hXFFerYY701YziXdjjKKz69vskMjl01lAT0
fcmTNA0XdWb8zZD7t9ToHIKxVuv9Rb6liYi5qfv04RoY645E0FdHhReJwjpoIOhY
plPyeLynY/sBGHY90wLRpFihVjkcHGG5wBWDfXjJX/Wr124sSdynnlO07Ly+wZfo
jg/z2QH2XUTs6eVB/GhbwDjmvA+YLBEyhL8h61TB9cztVcOnzfM983jJwIlQxuFL
IFznnX+pnZuai6NPCvdeB0yDBmfg94RujpwNAIsk/NzJsEVYQ15Wk7ORHlqfHEc5
YTiLJSPFlVxfDVq2oB6bPWHNmeJYu/NhbJl/A0aUcWx0aZE67nh0Pci7ltCjLuAs
/XjohtRm4HmSACtzc2K/urI69pSgNQLbriC/NuCcO/eaVihEBEODkvtPidk9h7YR
bpEfNIf5SWPvrtKxuOH6SlZch4G9AmxaALwqqZgwJKe/LgM+oRJWWpIIFR5f+tph
LCnUMJV6cA0f7Gd72zP6lHREaSp9Jv8/gJ9MFmZnqz29TDRGvbzmC7TAX0NOsn/P
mghKTyYXJUroy5rLtrtVpXPbf8qhueoC/S8GFfQDX4s=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CT4ff+EuCX3UK1jcRAeDicaxv/3SUyX/Rhuy9SY6hdHG5rB0pWL58RHOy3TO/wbb
jpQMMV4GJxxT6gMhOFU40N3Dy9F9ECkTkFez60ufPUMYbpEVYtamRVkxQm7Q9ENi
PYuyJIHEQ22+W+nYLwOSehDMfUDK9c2b+4cqQaO0EfI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9000      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
elorheqeT461sMfzy4PwPA31xmgn9PeRlp1W/aZuFfteBffgZq1TaPV+63OPwf5O
ThPwgTIvr+UACzqLK8OzYmonPOv/CFfbcjyymSF+wOoqDwrn4xRcgPnrPdONxjyz
vKB43vDyjfiELxC1eLa/eVrajgw39Hy8DLW0YBZOEwc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9083      )
H7iXSSvxb42Afz0w5hYZno84u5ZP0/V67FT47g45bVM7Ont+I1fEsqQWHCBTjD/F
5eGAiPwB3jV6JupMVWrkMe0cKw3aNDmMsz377+OriCN4D7v7MgBXqdrzVQN5+/KE
`pragma protect end_protected
