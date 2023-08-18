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

`ifndef GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_transaction;
typedef class svt_chi_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_transaction_exception_list instance.
 */
`define SVT_CHI_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_transaction_exception_list exception list.
 */
class svt_chi_transaction_exception_list extends svt_exception_list#(svt_chi_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_transaction_exception_list", svt_chi_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_transaction_exception_list)
  `svt_data_member_end(svt_chi_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_transaction_exception_list)
  `vmm_class_factory(svt_chi_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gZKkhcolVs6gAj0tw24lJ7noAfJ/sz1yKokwQiVT+OuInZKJXW0PKXH+cKDH6TnM
dPhGCn6x6+W/aYaccnDn1ePF4iCZvxgROGrPwkZ7Ia9zGqde+JQ5s1EodjARCSuJ
7ZzTfSWS0HuvcO+aw99+a2f/AJ1t4ELihzYPq5vhlc+AZmDo9rppUg==
//pragma protect end_key_block
//pragma protect digest_block
YIg6vIkJLQgcIkLcc6EDisLW82k=
//pragma protect end_digest_block
//pragma protect data_block
GYGpe7TNVdyj3pn1Td5wPteEWIwDRH4QGuGP3zF5K8J+ckNjpACAmV2wz+Mnf3t5
G3hU6Id9w0sstgyTTLgC4EJLsN+XXKZv/TMRJa6b+7DoXtkB+2f25uzZUOIWKcpv
PYrXdMw24n/jp8ujE1pXKJinxM5rK3yBWtU6D1kqO5GY8Qv8RToF32F8akQ15a0D
iuTd+XlnkwVU9wLKezQezaGRhv4bAyAZlcxNhfCbb6OPgcpQNy+dXfQ/vbKJMNJF
/F7MdSgO1MMEU53mL1kr6OxsbFGMbCgP6XSauYQd+puJLXYre83unGnmLuvuG+uD
eHkoHUQ5+nSjGqiXeQnLR9A8MSCQ4BbJGIJOUfplNF8uH91RezK0fSg+xnpgrSSb
VnK9dZSAQQ+yOVsmcva7Ex0HBZGyX4GX5WYru26IzhA0K9F0TdRrThXdHdHkYl2w
LdXj0BrpzcvwjPRjA5hjvgYeoDzNSg+9GPjiz377Z4BD/9KGsJYCFNxkSDL5sInV
huJJzXgrIim0RXRMM7MGtOanKWhcQvn8rtKpR8Y42yJnLmAQKciaQh8KQZQnUf5+
IrnIizR/RfyGe1rJi1k40PJomp7JHr7Rw/AZtrJHqY6ZQIQGKCEF/gX/pN6lPuE/
G2qUrNwr3QI+LO+2YGPNMHZybwPewE1huYjtTWSGUySiNq56FKdUKfMbJJCm6aq0
RMxUE/PC+lSllVyj74KVy+DS6lZQZt5BlF6yRaUAY03NWwN/gC6I4w92tw5VGUUa
J2ZBmBvfSGMl5XG13Zfhq7EJOt/GprOM0uO6cSMe8WbhcmWulvH+/6lYWxvi+28o
jr8sn09nCfQ4GS9A6jnH6e8l4u8TS57XGYKbGOoAGw/MuR0nNUNld7irwODG7/hp
Nkf9xnpQqUAUI2SCau/Zr8OLlnaIrXWRbZP5CuVJNISzfYrPH+9XgLSwl6mLZf2X
sfSdTh+VIURNxNm0VepPuJHWhCQp8dtVef3+MOKcvCUBNaSo1ai3g/8tJ51amCTW
fHJcEwLjmwTH3HxfPnknDzO7IEyo714XZPc/pgRV/aImTTjaSUoR7ZtZKMfJ45Yg
lKkUrjgwDhSv0M7Y3vgz6xscNbqhNBFiHLLGGjoQAuHPql6sKTIg3UZ9JG6XFIry
PWviwFPTr1x7dFVKBKrpjUR6/E2rnP1XwUKIAhD5eE/ShSz5/SeVl07yZ1ApQMLo
AEw3Emrt9umEhaoCy3HJWThwr/lUevRdooifuDYI01GPNbRc8zvHXrL+sQEyzQ6T
sIP6EDy1drmX4js/DghDWCI370N4tAdVFvTF/nleCHI8nsvW0Xts0XN+JbDn86/e
3w0grWRDylcXTFKeGF/fV4KbTwHBL0+iuOAxvvOC4OmjOSfRHk8D9BcCwBi1J3aj
tO+HwqYXzjc5Ryksyp66/1ULO0aWjrW3DyPGuP9oVKpqxhpkWWF4WR3BBURNtY9F
KgfRuoTEg2iYm6FDQmayevl/nhTX/GoKO6X5zsrNhmvX/azge0djRhwiRh0ydFzH
Rhee+p6k1MgoUZA+ajMwW01vFrwqb6Z2tOPoNCL2NIs=
//pragma protect end_data_block
//pragma protect digest_block
eRoWi9hUzQxCd/cmO8urodxf6Wg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nkXqGiG7BF9PvWU0LSTAWXy0fcs11k9qt7v4q5/Bn/TWLoSJM/tp5d826bA+qlp5
xWaVYNZIu29rUmUB69V4IwHYhlz2tVql8vAxeaQKPMhzyi4LYOwNIxY7nvAWB6hs
1c7GSG6gk65xpnlFCYGzQ70KcubT6Vwy0sjxxdJktO045zqW3Y6d6A==
//pragma protect end_key_block
//pragma protect digest_block
JqwtVo2mVsi0ImKpVdSQZCZLcTM=
//pragma protect end_digest_block
//pragma protect data_block
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
lu8Yf1fSPUd5j02s7UkFIBkpsErxFOwAwI/tAJYubn0RjJy2WRnkIsNR+/yYl6Ai
nO1zVCNB0J9nIKEjlGKRPrr/Qp0qwDa3KG33x+KZ3x1aq3cFWPKutGQgyL6fezXM
cCUbSjj1hA8n7hkxFU8sf6EocWfv0v5aJhT/Nfe+V1RlJT6XyfzU0rKkIXnkrvmo
f3PFrnvHqzyhuvMdAOTQvXDfLT4eT8hGPpE84HPVeaT2PNggkgJwzSR4kBt6EcOm
QGGE3Q8IhdCrHv4zl5MOSiKFZwJDg+KgdE2bTVDkGX5PyMCAqkcTCJz3b5QxYujM
u8SafalrgNo4iM1lK0iXVbB2XyQY15J3zm7NPgJbPFMcD5W+q1/MFIrCWeHi2spk
uQXxJyZ92hir4osx9VtCGgT7IkePX6INFXttUpxtGBN/YVDbUkBo1/gydCIxH19J
xGv7CM4XmDzSUSKwOwK+XncJB78Yi2O3mugfAIvpYhouUU0csQOhC3vL3zGZCOQG
awCT537YmuB1IpNby0lMwbNMaABl/a+zxfn7HhNIZiGfjjVpjxpQr4631CxFVpyN
OhHPZ8VpqXiDRaDl7m5Vx9LOeFzXPvJKbCEGJLW9J/5z3KsjkdHE/CC+BrVjpcef
YTyAa8O0Wj5reNGPRFlIrVbZSs44bLjkppVQXu22leRFzW/Uq7U74DtaeYKHOquQ
MNnQBpwfR8MmpkWDKi/xvPC42+arisIepFhUjqAjdv/0O0M+v7nSjAgOrgzUSx9K
QZYZPunu/dIV4aHrysDFY3rPqSlKmCCaEAP8Ru3jFHVX8wQDJNBbNa34cR8MHzb4
QiiBt0t9q5zKQOAbCGOGnngvrgZyixUVCBp9OXAj/9cBcXtieW6t7Ttu4qaGiL1d
5hIgDHfX9BxiuBzzgMz9P5ZxbG5yFXJF7sca0OcYtu8hBEiuavLj2YMeAqM/i2/G
54FlVzqqCwr6znTtfT99ix0TOlOKttGZkUFO9ounneUpmgpCFgDgKf1iGKYbrxMX
JcfirK1mMNpuLnBEN3FUsByK4itXBjeiiu0u9+Sc+WO8HcApg7V3x0Utq/G+NSBF
9ajyzW8liud0NiY2iAj2vXOeL6qWwFKJcBVQ1Gha5KZySkV5AJ0/5EPUoSoqeaTR
5LgHw/MJLL0CPeWWVFyKg6PYYox6EuYLdw31zTQmRUS5GhnjWUZlPDQ8wp1LEuwk
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

//pragma protect end_data_block
//pragma protect digest_block
tht9xgDygbHvDrE98XjW1B0eIYc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV
