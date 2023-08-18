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

`ifndef GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_snoop_transaction;
typedef class svt_chi_snoop_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_snoop_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_snoop_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_snoop_transaction_exception_list instance.
 */
`define SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_snoop_transaction_exception_list exception list.
 */
class svt_chi_snoop_transaction_exception_list extends svt_exception_list#(svt_chi_snoop_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_snoop_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_snoop_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_snoop_transaction_exception_list", svt_chi_snoop_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_snoop_transaction_exception_list)
  `svt_data_member_end(svt_chi_snoop_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_snoop_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_snoop_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_snoop_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_snoop_transaction_exception_list)
  `vmm_class_factory(svt_chi_snoop_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
blO7fmzMgf80qG4XkJgmZmDKl1XeY1HPk3uTfma5iWiOUn7aNKEkrQ/11Mj2pp2o
DmOyeYbLD0pGfZUNn+p064//8OyCu9GAOMq74zsp8wo96WjMgf2mXxdIV1xFlPaC
+c7joZyC/PDDBTfooBXOEilSN+MDpfyAp1gXIigR8T3qBz2oCTXuMw==
//pragma protect end_key_block
//pragma protect digest_block
CqRygCwlogpiyPoeQWCEuHcPTCM=
//pragma protect end_digest_block
//pragma protect data_block
udHn+gNOiUYRbRR1WVlC90Ms/wk+2/OmXaBLi4Dg/5TP+pn2UOFBR/zY+oiCwxxi
60byr+vCN3YJUumJ++/Elo1Okf3khb3KJFJxHC4VfuifWUIwmnVRZ2ZTiyqTjGzA
J4I9SMHnJ6EBmS8npb0JK7O0h1K0+QazQh2ygNzjuvI/xndfyAe27UKOHP9qHzs/
agbQ7mnhWtYd+CM117pmzV59bi7ToQtb/2LcLg/lG/dDywcP9AAf64b8ru7TD1CK
MYfVpHDjA9+KCn7fWhsvTq3wjNX5/KLw7f3n8RiO7lYyi3wNCS+N+TKpEFMSjNXu
c1dxUkHdjHlFziCP/hSulPz6x/Qbp8fLo6Zl6lzIy/mkSEGeOu3wmiTXRnbrBNxP
/9GhscjymMy4GZtHewXuInwgQWjt1lyvSF4Mw+xk5W4pxrPzHlFOBu/Ouod+ujva
sqPRIfNVyRgKFkYBWpNbIe2nqaFxg/r9a98xj7Do6T/u5cEi+kP4aM8NL9YDYa5j
OFcrJKOlQPZdfe0OyrQ+ghOk3pRCmG7/hlgy5/BmEEaxV9XOC6u3BafG8u3msUD0
BUmgT6hEo3dXUMXy4z+HphCPvYLXs/JBYdUi7IG8drI9QLOVod5Vbvlm3rQlMGcF
2gmjHKXiK4nHGoQy2m/eyPVEpB15q3tOTi/FZa3C5lwQMa2uyu9m4T2wo7ta2UJ/
uHqu3hgWHCUr2XBct5j3wtNgmC7l56nqcNJyzkcfSpuEEWAvOTP4ZZ8ahDgVGMdt
7y4FUdeeJzSv1YJZtTF8Fqi+OFH1kEN68oxGYnRSa1u5cOGT4sHf3xA0gkUtblcI
L3xp+Mp3BsqBariSXC/T6cJ8ee7KXvOSVwzfRyabfQMNwMDs9KreU7PeOs1VYwnm
9x7mpn7SwOgHHKG1WyrNmrI3wBY4hU8HdI8xxLYxuAojpUvN5Zhv0vyEiiYiSMBJ
YQxZgKnDOqwes589gq+dj2wUbCTnGxvp7oarfs7toW19uCzXcuCLruS4+IbHxzup
XLukMW5ukTr6EWKaj+MWd4m/FWkjKDo2qGc5ebaMXWYlZtxgv+SWTS+SCl/rpu40
O4nTpt5dfSdza6ucM8xIZKwHWfBV8YrfrVIoThg0W7PH9jw9QqCKwyc+7d0Ii4ej
JyFlbPWjssQZXsrIQJjzycYHFp1eTvT8JN+iWEuvIrZoLHMqZFm1nXHmOfy1VR+y
f54Yp8BavzQk1GncffFM7vn9iwuzQQR/ji+BNJ7TOgP4q3wLy5iUTIYDbsSZCUV3
yjYp0/S6vhx1sSFTTFiis1y+0PinNhWEzNszyTb76Pjf9dSYr5CMmKSy5TKUpbRN
ivB7/YfZUGtAMtHyL9jEDvsZxxrAOlrm+EtpjN5/W9vkd/1G0SBNQm59jnSuG0FT
y8WQftdLcRgpt0zBMKiGO9nie+VBqk4vSjDNy4MUlYQNIhCylqdMi1jvanWb+hjw
uWNIM0Yxlev+nVloxy9VJBLI0PqgFPkG+/UqqcHtFyn632AKN1XFGe60XD+ZxW8C
9I2Z3ybjiXtgslkfodmmsFs5z1K+gt9Q+Nznd0i65gVeUnzamiWI7ZQzxKAehuXm
aIuvLKWF8QhXBKI/odQDWxEq3PbW2r0ICKNWfT8VvW4=
//pragma protect end_data_block
//pragma protect digest_block
8KsKiWF3KOeGYWxZF/XDMXHRpfg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DBG/MGasEsUEHX4lKQpmq6ti5KcgHGXtcOSucpD8DtEjB3lxf65lwkCtDf5Xv2IG
hU31DBEq8fFmG7E3w2KE5F+Bl/zQODIVmPqaZVMCdHIibyjaILyg2xRlAfP6TjnD
twBhJqC+m4Re/9X/AJCELp9BNCdd5rJpbiG6vBiKlR2NxOYwWZhIbw==
//pragma protect end_key_block
//pragma protect digest_block
BOysC0BV8pkFPcrkrpxgCVEk4xY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
N+QjfcdLeiTlRW0yfJrIJohGVxA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SNOOP_TRANSACTION_EXCEPTION_LIST_SV
