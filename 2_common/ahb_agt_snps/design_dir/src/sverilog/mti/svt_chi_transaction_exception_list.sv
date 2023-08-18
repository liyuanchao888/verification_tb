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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dSpQE7A8VodMb35Ya8JtOjiDBicb2y8W6wQKCOgMZrlpZvC9vBaaQNq10dkobOoK
o8JAuaAuvJVgPy68Bb1uq/lQx0jDDWfCfYiaf3Zot6TXbXgUNPTxUHCyHzB3zDjz
n/aIsP66E/SyzHuWbyOU4D4iSQjBWMIT3Sqg/A4nRNU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1012      )
FfyuCyJvJjQRWBuKkj4Ql1YhJ1keeZaZDYAxdX6VpEMo2g95jSTei6rYI6dvjrw6
HI+P4SSFlIOIbpvR5mNKWsyYMX380eIOGR3P0mOMg+4b/zWOJCdJd7JoL886a+Ps
Iie0MxrsVwCVpW1O//q/OIH+jHzkjltpEKKFwqGe4FubDfGDNIP10LEIVtgoeeil
kxU04Vr8yUKQnNL57Ot87ks7bk+N7VBFTblwl/yy5cC3P9/E99olIUkH+rEcjpz5
Bqw1nPekNFE30UItcaWJso+CfwtY8a6iT8iCKIWe3mrRvjICCA1HK0qozk51NiCn
j9VWmTo7VKgFA1pXKxd32vh1yq05Y6b2RqblKFwjYeNpMeQwroS9EnQ6Hjy0cLlj
GXc2H398TAIJ/expMfgBDY7dX5FoKRFMk6NMdWE64BXCEP4tGjJGgQVAhOPDDFYU
3IcJ6rLziFMozaM69NZV/EFZpXFc1nFBqHYnu91TPSsfgUoQnE0sEMTrHf5f4aYc
RCR7Z36ONX0VZGTOSgDq/6+z0mzp7FvfWKuY0EdrBxklLIOxb1qRmZPPnqHFGKTl
DnXU0P0dSJqufjGskaPuSONaFq9/gLtI9Ns71C6wgOVmRzJjafOcY7TZGVqxe8ky
KUFtCWQmfqcQ8auFbZdgTkNObLO/m0JZuc6RNxDHryxhQCQ+psd9YQ0+LjEody85
UHGE3tXCEKQvN2rdMgJbBd2R4zyT9Rg9kdnhi/234pEGDXVVhjD7pcd+dD1eVD4V
E2GAPceoNWxi55fSIafLOzkXuJMeySqBMAjGNLcOeT9HVweemnJcHFX0QJs0Llcr
bZmnAnxIW9PHqIpa7r30u9JqgIqOn7cqduDvciEsAfCMT/oqcuaBlSmcStUPfqg4
M2Geg1EoJnqxOPmf4jWP4sTwo7gfhfWuujt4IHRwYd6YgxXtQcN50sb0qG7kV9J3
B1Y3hR89bITp5JK92FAro+RBudYX1mxiebBXhSFmMH65tOvCKVeG1Wa1MkJrwRu8
5Dl+qi9NqXaRKBX0CyNUQbFO/rg4Z7EtyeQIVsPDLADI5Ytat2gCV4PbqHkgZbHG
ssHCKKlWJ0ruDsUcIY6qOOlmLpKeQd8paYxYvOYHG+z1kywCiVyyrrY2xTdY+3Yj
PFxMh35vP4bWF9AF8fJ/JZDCR1ILJ9ySo0P0fKNKAFqrb/LhBuAapp7RspWMe/dh
HBPoUvV/1N1nWKww0VRBBVKTYaGeQaoH1su3aRpThTs40wwem3VxRZ0iPL8rC+Jf
NtPHrJWNtwCxCv5m8bCAasqaBAfdEkDdAz8wsHZgb1i7kYAOU4aB2fhCf1YTHDT5
wAs0MAhU4P/oOxfzDej9oQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RQR/PYUJjT46cXu58jxAMjZO7SQKsQL4uI7TqUzCQ0LfIvphslIxZsbmVAdAzVab
FTzBhNSlKp4o2Xw1wQ2DlUbYMtvIHazjnGXVNMZjAXJ4uxd0+iMZ4CAFRqfQs7OQ
z48IzOZZ0go/gISObt0ng6mRNfZIS3BdsFQqlmVhlr0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8910      )
+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
D+O8NQ7W789B5x+myd3mnOMRRwdSpvSthB/0A+74ZRE1fEQKJKQ4a17x4jFnA1iI
yrhdpGDytg+L4DhjJgEAdIRXVOON5UBk1W/n+s9+oQkbYs2v9o+priwGexYJ0KvW
dmwHI0457ISZrRMNeA+PtCIGlJJbFC8LOeyq329f/29OiRPC5YyneI+THyaD6ANZ
z/JdNKLT3Hwtj7AYJA/1Is1cSeOj3gJQyNmwzA/TTLbh26uGHkaB0iYc7XKb90an
OtBM9n4HzYIAI/c4uoutkuF6e98gQN0xrmVh9FYqcKNb27/p7r2J9k9JG9Bbd9rZ
2yF8pnrsaOcgpfrjAZCf9edU8dby9MNWVfqPz9WeNFWc6Qu+06GxHIRU2fSdqK9Z
8b4bmRkWJ6vFSCOXIoNAy7EXH8e/abHz0dnyi0Y8E47LipfJZkEJ8nlkhvJcOUuh
L8RXonNJb/OewPNl7SB3fRjzTQlyf2HXw+vKYfrXa/rTIrhQW8Vhv5idvjFMRwDQ
K+LHJL6iMx4u/3MIaFIGZ2KaJGo/PUaC+Ix2sGmonbjBCbsCwaYvEYv314jv+qwu
MVZ7K9d2nrzEglzMxgC9vKThiO6SXb5AtXXUvZJXpeIoIT1cle5iS33eGyd3E5Bw
1QOtFqDAXml7M1qwWkUE1K8+N66WKsX8G5u3bYPnH/ikzECgQIv+hSlje8iacMSJ
StiNk3YaAl10W6PuldYlC/M2NNfXNqNayHAy1iQophFnZSfIm9eJolCnGdrkX7RB
XrHBmpTEKSv8zgG5AjhsgMyh88xRdJAL4dQ05wZH+Uc=
`pragma protect end_protected

`endif // GUARD_SVT_CHI_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
I1xMkdA5B7Lm58Es6oNqC/xjptxg4R0QTWwDh7jlXARpY/CIRMMfWXItOfaGTFwn
zNy8Ks3CKvaBYB+nGSL+Q4w3qJe3xK/XNhMxkXeEN/YXvaLnZjz0VAsH/bWr7pPO
ZtOyyuyQCf9rJ6vxQXUOyoIKIaN1/CQpF0pUAto26CA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8993      )
bv+5uGtJOiVwFjTP+Efs94XJiDf/LjG+U3FqxmY8KERdYV6ah3AMIeICKARn/TtK
+J13UYAFfyaQkCDOaumA14MZLBa9Sb2eG6SUaa2+yQ1iFyTUXREDQJMgcQZ7Iy9U
`pragma protect end_protected
