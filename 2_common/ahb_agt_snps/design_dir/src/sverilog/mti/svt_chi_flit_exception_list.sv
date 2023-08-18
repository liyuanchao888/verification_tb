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

`ifndef GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV

typedef class svt_chi_flit;
typedef class svt_chi_flit_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_FLIT_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_flit_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_flit_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_flit_exception_list instance.
 */
`define SVT_CHI_FLIT_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_flit_exception_list exception list.
 */
class svt_chi_flit_exception_list extends svt_exception_list#(svt_chi_flit_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_flit_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_flit_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_flit_exception_list", svt_chi_flit_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_flit_exception_list)
  `svt_data_member_end(svt_chi_flit_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_flit_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_flit xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_flit new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_flit_exception_list)
  `vmm_class_factory(svt_chi_flit_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J0F92N9dCb6W9DBGTWl/NwXguVCEC8TPR2uLDCbmk1HzBi1USmDpoWBpikpiDOHs
re7yT+Wuz+ucyCagW5eWVw1tkYWJkdwUMU1I05cn497jptpOVv8wdbKc8lG/R9Q6
NBMcNwwufOIwajhqIODTuCc3swyM9CwGWR8ZnbkUWuc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 956       )
40ESYFz6lnuVWeljaBbmRPSVQ8AJQjZikZCaRd4nF9LkaRaPoRm65d12Gl2s/xb1
B+yORScyVi0rIksk0mbdu1fL/CwTH2qkXqBmcPqBeCrBIX+BVMy9T6BsLy9OB6hG
lRvRGCq6VrsTeN7KcyHj7cY529RAI2Sq3RUq+CAuv6M2vE6uKq+jYU9xq8+AOjpD
euPeups452Gn+yYmxDbblC/hLOk7C0GEMJIjcONsgp9pht3k3wVg8hbeQQKyYV1S
MQfRT7KR6rv8TpGAE/cuCqRPvxvua0oPEOfAdGGLlqPbTieCYq6BtgyDVXxwB2C9
0u6XFMU2Jcc28i0rwwz5eCfU473vcd0Halz19RmWWX7rxZmSNrVnRNiYiVKflu7x
5CcMEhoejTsgmlr1EA2xlEKJYZvJSv0H5cN4RRwKngTEgKFAOVRnsm0pBnfthFN3
qaEreCnf6TrIT6PT+JrVTBZeMEWmrj/eyZaKDetz+X5dY9mh9mHnnaV0IkYjw3V4
k+0bF6xDD7sGrS/GYm59BIrSSx7gGPEbjAxFrUpFZfEAw2f/PTHGlhe0e1wEBBbY
hyJhGlv5Mc0QiOnirj0DhnFej4If8nLX0yADSwiDljJ6kRnyW6C90e3o64QaGjHe
v4TKN12SIwEZjJ+9krQb2o14LFHIC2LMGoh5Q5d4xr/TJvkPNi/zrdDcl/ZR/q3F
z7wPfAFPJKqYENCnyjqzlZ9R8MkSv8xcnG3v++QASk9KZ//E9XK01Mng39JWDbc1
cEkVP8Z4+CGzQ65iv0qYDY1USEAp1O9HPTGRK8Dq6y629ql6qSekLQlnLz7pcF2X
ax4OH2C+NLm1ggad5LMjEE+jojPSkMa8g9noDL5ypiJBsa9lGrOid/sDVEQwOrS9
s/rhZOkdI3+NVNlNkh4TQqsh4wMMBccE4skDXE5gwfV2d5SR+bXWBSB3Aj6MYZHN
G8ejHCfaVrSbN6PRy17Jmrmb2x3ShNFbW8IPBg3ZN52LCGGy/D+WYYKmb2JRIQjR
ZL/vaHKlSofrKAJaO0fso/P7wvxVAwRFlTDn8ZoPZ7Jl9i3YlQQ4v1uX0k0e3KHG
ltck5cXACYV1SsJIv/9c2NrHiHXoCPZvLDos4ev8mOIR0vLcKYTROBcdk15xcqSR
Y1W8FYK2tF/iQoIU756niBjCu06CrfbcvhdRKx2hLCYK5J8MCEd8OJDSD86DbxuM
uM1UrQyrYbE6dKcCXgCyM6rMEAG17vM8gGcoQ7PE0EQI1yfYhSgP8drRUZVReZJs
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ImrHnk8u4zFgwjCgTrq8Hj0BXEiWlEDgEnQ6DN9nnaG+RWO7Gk5gnf28r0gf5bOS
/pxN5zCuOaRteJHgU+TrkzB4YS5qILMEJHmJfAgTtcL4CQbLFrO2nZ+U86BZ6eV/
QWfRgqHiTSCCmMVSr1kgshIX4+FJxkPxbJF5dM9CU1E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8700      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AjR1QjKYugumQNYLAEdRxw6BaowuJmCthXDRIeKGhwdq5T8t3ZYSxVvmuHdzVHRt
WUy58mkYlKEpHwXg7Z7RPJ+ixJf20HVx77Rw/PqBETLDy0MECX54U29jQnmV5rPY
/0DlHUBpYFTAtWbhlC9AmnpKlHnqAMFrSdXr7gq8tEA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8783      )
iyUobEYABKJvc9NOK+yI05BnvodlrvZFMWNQR1ydstNhPYpjpAowXPZy12QT3TJs
qvd0kxKAaC5JNG9IGV2i+BRRIxip+E/0dUsnwqgy60vtAe/6QoVyCWtDqyCbl/ax
`pragma protect end_protected
