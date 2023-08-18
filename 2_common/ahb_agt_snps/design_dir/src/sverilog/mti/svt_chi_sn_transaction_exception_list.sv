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

`ifndef GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_sn_transaction;
typedef class svt_chi_sn_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_sn_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_sn_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_sn_transaction_exception_list instance.
 */
`define SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_sn_transaction_exception_list exception list.
 */
class svt_chi_sn_transaction_exception_list extends svt_exception_list#(svt_chi_sn_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_sn_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_sn_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_sn_transaction_exception_list", svt_chi_sn_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_sn_transaction_exception_list)
  `svt_data_member_end(svt_chi_sn_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_sn_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_sn_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_sn_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_sn_transaction_exception_list)
  `vmm_class_factory(svt_chi_sn_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KJLO6wDpqYP2mTXZQtiXu8/6LZHa3M4xukWENBNERiqJLVpToQY6XSTPBky5/KMq
G4EDpKH7RGJSuv37IUoTR5wt2s2pLqCXzk6Rw0E00XRC8jlm+gqH07uLUnj2SiLN
C8EEz2PQvC3GJHG/AsVHu6LUuSnJ/6Ej5L+IDBfuD0E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1036      )
PiALbNlU/dcHOkpr9fSYSyjShpxtKgbP1w2i7ogV+aWc9Nc6wDbfvwruW/Gj+MhS
ffTxPZ/b/APDpyduk2/Hq54RvVSgGnCjJGibFPBW0zeblN7Vq17QGpXZuVmqo9xU
VQIiwBnx5DXCw9dYgedRysO77g3wdZS1s3QcLhC1iia/X+6Gi+aFmaIMXiQLiS46
8269yChQoFHzsXrtlvXEKqgNj//VwJogmQjuXo+VF2e2qO6Z2rttPL5xVJN1DE+S
10NhEFBCYg9F8j9gME+3dCE5oL4i02DhQBmG+i62+ArEpzn33Nu4HidVlGF+a142
D+p+PAsJPYsIEDu/Qy6v8jm0m8lSOTJNSQuurGewKj5AfN1EgFnc9Yv/fLft0HAU
CpvFXBVavbZrJ6G/wX+Ot+eS0dOO8oKrr3qFNqzkouHPlCN5j5JWp5oEkcFERH1r
/MZL+qr6QpFkBTweqqvnENX0eR3CIEp+/d4fwsmx2+xLKqaBz+XInr8ke+Hp4hJp
LuF4cv4Uuho6wA/4vz+U7gZSkf+A/Oz/VEepd9/SOoHY1Ch4kfhyLzl3sshxn2al
PlM2xtT+mvf5YCwjYTDEwbjgXkHgFhuFDXTsXKF31YNIDhuBityWP/FO/Ldm35Zk
zG5WyvatVUayxxpkHGqlCoUGzni7+a9D5+9cAlGdjtFn7Cg94r091sUMSX5fJfU1
uz70DKVoCCW1GMJJQVZg3oqjInZv0rtpYg/pTIg7wpuiTK4RQISH4j9Akf1oEhKn
JDBZUubvSopM7Mi+uOxn/JBMEO4ixJWpSQ+0KscW7suMowjKHhFuMPR3ZeBVAcob
nty/VgnMifEVr5jVscUMQdXU3WdoZVCW3c+9LX3O7hRz8RvnPcbgTohtwt8l2DDf
cGsa5WKtGt5VKVb+I9KLoqeDcnwwWNKVmK4K+un9zP2wKP3cvT8sKSrpSQzEVPi5
XSnV86+e+I9GeXoUy7ASrMN6NJ1L9LjNR3N1L4WMkIybcKtJiwDud8WF/ec3FNnG
7YgaSQul5WklKKb5Z4Kj3xNiakhvPrJj3BdQc02Bost49WV4PBbeBVDPIvOG8Fo/
BsqeWSxWStobKG//ltpCFfC5uhmngm66BtND52Dc8unng4x7yG2mvYWTSWLmrc0k
04J4cStkItSgsw0BJK9E0T+IdAkxroSyLohyvXt+ZLnZh9XNeF2BL/thopuLrg6Y
kFtpRp7RLMbfkrjEBiO1dWa1mqDWm0lCsIX/1n2rTDpj5eqaMjYUrmUSfwE4G1zp
/d/GuH3NArlIXOdf8djc0zzQe5Wl0ckhTpHCCyMvLyvafTTywJHBMYZjEZ115b2d
VrfojjjGhFyMwa7lTr3kCm8nZYMlSpPNi5EpitbHg/g=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M9s+5WtkLNHjlCXsKa5zCRSe97i8S9J3pHbxa9Xp1lOCK+kNhMCHHoLKJOYBEnJ0
TeYtvYkFaTFl8tCfbMmR7y1b/UjzeOSqgPt4EgsydrGFX3A27D98UEmfQl+KISg4
ezC0zENmrmelThxZeGxScWhRVl34RM/wf8sAJJdZSIg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9000      )
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
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
drWq3drM6GRbeKdZD2NhQCypvW37dZQE+CUwbrWkkDjiVCMn4KG7JO1DWZDS7GAL
F7UHD0Fsre46+2N8KnZXoiWoSHYHCfnlVHBsswb4UJo8V4aAop/G332oYyte2zAG
lmqFdMTI4A0c2p9izqsCPx8FiWBuKsDmD6+wUsYipqs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9083      )
GlHSxfK665GWQqA3dAz1w/9icLr2vJpvIZ+Q8wR8EVS7+ejWoGzHDgkeuX1bzA7H
fy499yf+H3JUYn5s7Nv0YLtThqrR8oZ8/x3A0iXj4EeYSQq+Bbq73qp41274aX5O
`pragma protect end_protected
