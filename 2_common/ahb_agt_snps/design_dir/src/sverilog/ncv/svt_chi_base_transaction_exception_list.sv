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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qaSjd8SOCkQz6di/BjMU/CC+8PQ8VPqoN9lNAREgGEp43wO3me744jgv4I+o+JsT
MT6fjHs4REowHzh3a6BGzbYpRSgMnl7O/LO2VQN4FL87AXwSHolf0JXNaz37hCS5
y2iyhgY41sKUHB0okoAkKm9l5OnaXsmhc5bnPE1ABKN7Fmoeu4Xytw==
//pragma protect end_key_block
//pragma protect digest_block
JV5Z2AkgRctnc2qlAn7PXgqZClM=
//pragma protect end_digest_block
//pragma protect data_block
xMur3pty4IQB9lIfFUud9NgLGzTW4TH2om0sWXwhWOxcGlKQyj41hnQioRGkSiw+
7aS0JDAfYueQo4eZkwc6Jk2nkrO8rk4+EkMJNs8+HpM1M2RvG/CQX3zcBl5mXiot
k4SPrxef6ch4vzm2qxwzUNSGjL/z6E06C3STyf0L3AjpYt162lciZAV+jmqfGtCi
Nk68Gwnan4H36UcLoRCxHnUA2rSlaC7TW3WDTB3KSC1YV2CWnCZaaaXQVEQ8P1Pl
0hFc1T00V+kOM0OpmUAd9T8zDSTZL2sRyVbIG+7PvYx8GzH5gG48NiT4BcaTEh93
9htZujOlYuZx0R+pWUitscIEopAbbghigXziObVefBmbayOtZbt0j4UCPpNLklaX
z1BN94IpzsMy+MBuboyZF2pfBzW1c+DrS9Ee4ZzheQimaP0onkURpQw1N3CQlsCG
N6xWZXfVS+rCOkijVx72xFxP1q2uqhqn5xfeNmkYCcJrwevOVtLAA9GkVLc+CF6N
C/wmd7ZDOFTdS9XInF7hEioJb6eOT3L1Nk7hr8c9cvRm1DAC76kdTzZB/zAVOyLN
ZsSjz1I54JE2E87V19j6NdRZjfb3zQRrJg33Kjc4Ldglpf9/AYAdq4iMB+UIoLNC
W566gzqeqBpjRWS58iV2FiYPL4niSRPR97OOww/QBrYzomma8BU/zSm5A4sXSRYb
rPj+cSIBBfcuSxOWIzjxEk7gRUXSfyVVkpPT0myGk+btRCz/r7fDI+n1yDROs+6G
Ik1YOClmlpBpjSlBYj20vOgzrejCeZDbqNWmFrZTPE+Iqz49bcgaWYOIVtqNHa4M
WAif87rW3AaB90W/pf6ucjOl/sj0+N3vviLHPZhf21syLJ9oodLsNkHg06VQmFLh
ati8IaKKpkwELZRZRzSq2jMGHGzdN/5kmfOIu4szPC9HKsirywe2NzXgDRb3vIyY
voHk7nwPYPWru+wkFnD0z89Rix1il7xoM8VjuprlBAmB5x9N8PCQfZCS0EwxNie1
4ll9PBZ2wWVXiVna3bfPY4JMgPN7nwk6aXqgx4lUa8r0DHgAhc6sXU5ENLW6HNJF
skSc0x+dUOvNvnATsR8SDrw+l241ONFn1ryTELOra1KHrCNo/33Da1G54PWK0bxx
joKLxAi5Rvv6dVZYGOuBsSFCPHV6RQH8jvjeVmC14LcMZZiIutbi0kSpFpnPixtP
RFIfQctOY7GfgDR+0inb4i6E5XHz7CwboegliQSnbPbc06Wu+6HSdK4gW98B1qDE
M0KKlLUoP+B3b8xtPi1U2MdFP/g5SHRGSWAs4VmZ3xdnnV67ZOAdXRDAuWD1mzgj
MCM1976MTQyWizZLh95Chnhly0w2OkEoO1zUfg9xaJxA/ZSzbidtouchegyUY7PI
mp/1RJflwk6Qil+qTYLA5mshp0GsgGvaqLlB8brylOxP01sEVKAzag5Vc/EQWXoE
T/dGgx+bSJhBwDueoNIpAhoJFBpKITKc45cpCgwSOLYGknvRQ6klc2pYi98Eb9sg
Kt3e4R5pA1YyKM9IELm7FB/LUzGSgwB2nqjBQrbFvFdiLez92fdaAqR6ECZG/rAh
AMYOiFu1PMf0NPAZum1XmwsRmuCRojVgwFH8f/fQfAA=
//pragma protect end_data_block
//pragma protect digest_block
pnce+NDdIpM0GvGE9+HjxOaHrHg=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kucBDBnjWk480brAx7XkLEfysi7DRQk+YLOP3Jyey7r/tExODRYhHnJZjOVcMchm
4wakk7BLOxyukj5YxyK1vaj8RZFFzo7zTSH48lXNBAIHaC1bJ+If3hnWNksAEBfp
8y9ODmmW6Lg1an1Nvqo7DYvHmJhATL7/acyD4h+jYSxLTUvW4ha0Lw==
//pragma protect end_key_block
//pragma protect digest_block
oyknB/VmUrXPt+jCOITGzR5QiKY=
//pragma protect end_digest_block
//pragma protect data_block
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
pITGfiU9NTr2sR3DB6zikw==
//pragma protect end_data_block
//pragma protect digest_block
RIFpOC+1Ah7rOTQ0VdlsLClq8Uw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_BASE_TRANSACTION_EXCEPTION_LIST_SV
