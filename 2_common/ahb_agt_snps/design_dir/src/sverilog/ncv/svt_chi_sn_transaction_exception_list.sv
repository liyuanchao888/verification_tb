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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
b3aagJZ92esEo/BKCsJau+/QUO1AApYcDPdUi/1ppA8z/2FL1G9n/gh03bIKvUzP
k/bvAXHJ3PPocCB/b0IzoOJCZQ75nAHKAQ8+ZHZP6x1UNu+VyfVi5vET4DKXo+Nz
gPPHKskB22h4k6Q2uLgEEoXiBMumIXgDCs0QAUMp2Hh4YbVKF1BC3Q==
//pragma protect end_key_block
//pragma protect digest_block
U8Cj9tgl2Hg1FAcv1A7PeBkjqgY=
//pragma protect end_digest_block
//pragma protect data_block
5t2nQf2GhcOdfYIAgKTrSn8nj8xsiY9RDRAyn5emE8tfHw1c6umBmCf1R51fb52c
H0utO3oBwoFnSdiWzTEQjKIQuGSxIIGvuW1CFUQwr3Kw/8FIEE5oL+qqDgaa9GFu
AzANbYk+gshWUv/QBAv7E4DI6++g++2MHsBaoNmtQU7zEUdm7Z1+7tL99re5+62O
+e1IWc6bDDof/mvC+6FdVDLJEd9GsK3kzCJV4scy4dynopTX1smjefU6oAhYlo7Y
wcwwq6Bj0zsqgNQ9frJpN7m4+G45ivNfFAJNH5sqxNHI3tPDjbYM/LPeT8hh+Vge
40Nu5dXd6qBPF4/OJoDp+fTs/8vr3kCjIkobX64m1N9JpYWR5JT0HnjU6r+wymWc
vlMy5e/KEOKqolXWjlQuKrJCw+jkxijh+dJgAV/5xXWRrBFWpxfiw9TrvWz1vLcv
mMd8nVvQFmr+8L40VshqLtUb/icBzkuF4lVkMbyQd9xOlkwtJirarCKLiXlKblQo
KHVczNRELBn3kVHm2/a3zJgADvec30/ClX2iscHJLvkhVpwI3k3iQz2FDnhrhHsB
8gTv5HC7eo3PHbMLbrHWkFkRcCp61zk26UWdn5UsjR2x0swLhOggaqIOK0bm2yCN
J8jwOHNwdNPn/TdXz2hTaoTANGHPEpV1XWARHw5Fspp5RC/Us/ICjSSslCR9Ixvj
+QJup/oMfYdQtE3PdjVeQxE8ZrMMPNsN7EKJ/fqmuFIbuUQq+L/MWbvDPU5F+/yO
CoH2ibuVW10Kd0siM2sTXd3ZWiK86vufntNs++t7oUt/baTZE4NhKwYjzVai5csL
5tkFosgN+l0YZ5dYjndukAZWq1YejhcD8p7xFqpyVDsdcLNNeBChK6kaSOibl8Vw
2sQBVILBFjEAPoqE2v1aKbro6QxkYIpWRV8wT9qF+Lgw2AQjyHzIMJy3ZkVak0Dx
4XuQW76/8FGVu+NhUWprhdg92KHC03MbGvYsWF3HT1IM6JI7xKTXsvX15357m3SR
ze6XokwyaeJapWT8GZtEBE6PvzOjOqeW+6vv9+8dC7nU+9lf+t96ntHd27O4NQgn
9DFp8swN0yBNOgRt+55fEPtpvhU6ppZ2e7YvNUKGwiKtPFyNtJvlltsk7Uadrd9W
0kDmhgnSSkfz/ok7FcIKMUqMBlmRCLb3FOiOmsVUyRk6p/B4SGIlXvx7JaIvTV4N
rMdWs0JTSCN1iTmOkARwKH9ehuC31TdRhsnxcidmdeuYeS8Q2WhpfqMy7YrRVbMH
bwTezIVcu1yGLugE6vyNDr7g0g2SWx7990SSLAAEHNk7tSOOkcnZ2r84mVGwTv6L
fXaKL6kdMzs9bpPukGirIYW6KfoTSbiIhMHh44fDE1iCPASZWThNMpqZpz+7voN+
yyr/jiytid12Mh6A3/RdDG94Sktp/tencwXC5J2l8dfGHgYoiNFVzeDDO+aHZrtt
X1sL0KMlmkRx28vrKVqcEjWkOFxpt9L4mm6ziyTIPqZxOJpYRW3CqO2MJwofklpc
u0YFDjG7h/m7nuvOGtPXgV8PhdQlnekPfe3yGEbacMil3EqdMcso7BaHf/zZif2D
wAFOIr8n8Pypg5IIyVQ5AA==
//pragma protect end_data_block
//pragma protect digest_block
aRJAoxr84BiJrjQrqf5YclZTsJo=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rZIp73B80igeceevTtR3QDOhbYAT1+zzAzcV9mqyYEZsD6TvybsT+zcYmUkWgLbf
OnKAnAmWZtKxPpCD2hurHb2aW8qL5fzk/oPAUuRuMiKONZ1P06+hmgg5+UIoUBFl
NJUvZCQ+InMxuXfyTY7pQo9qA1CWGtBY9ZhicRYrx8saidKoDXjl6A==
//pragma protect end_key_block
//pragma protect digest_block
s5ejkWehskkszVxORQKl9Fdal2Y=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
KSMickiaVKr5CKsJz1I+WhzEPKs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_SN_TRANSACTION_EXCEPTION_LIST_SV
