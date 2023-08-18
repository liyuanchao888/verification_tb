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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
TpP3p9P+SWHpavcUT8gYe7RoVyLxSUarP/1qAo49ucLRJGZzCMQorMZyYN6hO81A
JWtR+xraMNPVV8R25Nnl/uQN11A+XrkG3BCOiW07GMWXiwIOPfMC0OHxcWU/0VrC
DCOFYNXLVZaTm03h9CuVFFM4Xmjoh3pE1ogo0p8yrrkJ1hTNhoKK/w==
//pragma protect end_key_block
//pragma protect digest_block
5taWc2tBtSrzd/YvOChsr8b99Ps=
//pragma protect end_digest_block
//pragma protect data_block
QoTkpa1YTDzis06Sj023AoGXGfCddUEmVRpwIm1LKJsqSVGBuWFxyspbyg/012b9
X7KFzhsdX4LTDtvubOKqJ3bYapgtcZMPWtOiAXqOgl4VkDWHL6Ig2KMSNo6w3JWb
WNq3JyvrxlAzGXhuVciEREr+8j1Vky4mASI09J+G5FWc8BVa7dbnBuLIzt93iQyR
6lEX8sBKkyuvv2LVr7IyemvBSnSsKMaoCSVJb26Pik99eRJHAwXA2+Pw/xjdkURp
VswnpTB9sqHbKI+fNNfHyYvf75cisV9RPZZk4sIx1zV9876YiHp8wPdngMa4yJsu
35DOdHA2RzvEYEb5zDGcxfnyJTVDHrIri/4mj/cTXP7hwEH3lAvlb9A0b+Hfe9K8
1hjYZI4ZjNv/FSGX4ciyLHst1McN4byNP5VZ2+1QZaFDtOz7H/ahMgRquv4sycoT
jVhNA4+sllkRLsOTOt7wR4e4nJDejwRjZhfkfK/tvr/UYUQtEmeXGd+UnOggxT43
Gro4urJaxkpAe+oUWipYFx/MN8YPqHBXW47NBK/62aoKDlYPzVbNkE9ucGWErPMj
QjQr5vSjQfecI6ln25dQ+Ls2318FM1fhQq1DhnR9hfJRZ1ztRiqqomRZETQNkskq
AnJRC/4qYHPnW+SK/hRVuCCUGXCgVzPyUYPihB3eIhI2JLLjel0swpRVhah85tMp
gy+gdf6VrgVuVGaWgwAqEklIktmBDqjx+Sp/D3UPcwXyrhdtumtycbrwbhM19g3h
Jw8dG9dFJrtjAYX8s1huEkBHYez7FKcn8QUn4DoWDK5kHplwmrpr4Hx1QhTKxG2R
WtTb/7WyfkHezDuNaBCTgHKbWr5NQd/45ewCVgaRqsxwdYIaHyKOaxnJeQokyBUo
ivCZTGtk/y0B0yHN8Zb0tNQv/p60qG47EIfzRQooLWPmQioyCH7mL0o345q+7RHq
h5dJVCKXEtfqtxxJQngyBTxe+rYDnZdNiiY6Ps3dJlQRbgKAu+3GjwqdXVdx4P4y
Efe69bmxfZEa2IbacmOQxOogthhM2t43xYWy3GcxqTbjL6gwB8TUTJ+cIHrnMO8m
Qey8TgSg7BFG5xhQ4x5qqjFziaOb/hQvLNKIHZtQ0RuYdm9T+ezgjjkuzZ2bLaSJ
BDg5GJqVyfpM8BzBnFBUSWPDeHYCxEkzFBHOe0aIgybVWbjogAaaxOWbaoGKFs1g
sUuwpo75oe/oj0ehD4r+B/Syvan9Y+ttceZ8AIPpJHnoar0qBp995kAilsph3B+M
AhWvd4V4OSye7nCmerCyoIlmkis3VP+ucu0E3MTOOkmVIkJFzluEIo9uN0bsXU/e
W3uzfIXcNgow+cpZmhLMc4NtMBHZaIR3DPFBd6PlmZqDkB3mKNeym5UUhB4Moehf
+iy1s3NdYIEgO6C/J8mzQXiSwMoUolmauHrpD2NyYAOn+dA+5HpBy4S+AjTwWLHM
kGWuVqVuDiC5c7F1B2dvFlQfnLktLqnlAiUI8IhHgQt0zgYtDmngBlYnD8m0hFKT
Na4PT1T/cyGu8jNmqAD8bVWD5mIIu6WVr6ZZiwxvWhDQypBii9758JhdafhIde5l
QapTZSGFAY+/Ve343amdlw==
//pragma protect end_data_block
//pragma protect digest_block
4ocwWYqepItkIodrI403SHuTTes=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
za8ezW1L3fxnRjUpEkzpuioGY1iy5MRyentPvicaoT7xSPPfm6Q51BZKNbYIGb9b
loNTthcF4MNWKv/o4/LRGZUAXOUw/o1lB7ak/mOIeZhlGhGNgmrfBDH98UMJCAe5
kf85t6qTOTCw1F1WVaDdtbSOcyBXeVk/CGHyvvj1gSin+IU53Nwh8A==
//pragma protect end_key_block
//pragma protect digest_block
BS4DHofg49ehVdANhhHTEdxLMGw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
kYhLPTRMbsaW3mo/cV32bbZ+VlI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_RN_TRANSACTION_EXCEPTION_LIST_SV
