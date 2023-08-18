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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
66Y4pnp9aS/1QpzBdGe0Z6178paeoZtqYXRF36oOYsC9qK6Oy0NUtMJUvOnZBztS
1LTSkvRzgLfe1dYy8g4Q17EVElLqbb8G1iHjaNC3+rs+y29n9juKvj1Re8cFRVJw
57CxIoABN0kMgzRh6QeYUvg8QYhfwrn5zA2TBuUnFhcdRyOPFZwy0g==
//pragma protect end_key_block
//pragma protect digest_block
HSaz7ygpxxI7fML5r//iug/3DKA=
//pragma protect end_digest_block
//pragma protect data_block
ebgNeQXSXNLVrrgohfOc6ZLR8XcRLmNz1A1HtLFit3qOlCuM/3pTCoka8O6wwmV5
mKAiS45PgxlGTR2KdmSlHrSFEvOV//S5o2ixnXkPKpMpAcK319NXhosQdXdW0yvP
oaTXABmATyaA5+3bDGJHD0j3azJheDFBMHVV7Mjz/BPMt9AYSZWBOwqxREwzIBca
BBI+rMBzMeXUOxkGmqzancRgN7dxyxewOwx3M/ostrtDPGpa70x0zzrt59M5nCEP
n/YSzc5qh7j+JTCVOXxm28lyOSy9CaDZjNmkaUvkmsWk4gE306JsvIe4phhYC/RS
YyPERtX+BYuZETEMj80Qi5ppCIHNMGJ3lhk5ow81yf2PXltrgfVBZ0RQfwmge+9b
bHx2cNonxY+urkv8WpAUdVIH8+jNrxbXGTB1A3F/SIOknDfC9qB/k8nGsqXh+QIp
IxQXQweM5VT2lJQhilK8IyfCCle4HHfa0oIY+BGZ4UJOXfBCfTETdHAScCnrm51t
Rxi/NviPNBKiVPbvxgyRjbUDhMqhzjQn534Zrq5TInzrI6wUrbd3qlDFP3iQYUQv
7pjfKqC4xg09FcLRBJy9lme1trnrQCwAyGt2Hm4wI0RszQISAmQ34snexZAX7G2f
uXDAOIWsnN9exHbL3wqR4tCzRp4AS8nEdb68UyBp9sZ41CwEA02w9G9ndL87W5RB
8EYNHjsfgT4TmsbsYAQVS7n7oWmsw4ijFiQXakwumBHlUxGNErgI6FxaeAkC21OM
dfLLVQfaogYEQNEojvjJI+1chdJHS4RHM/oxAv9gtMBau1kMEeDh9Zkb94AgC+6F
KqR3CoDw+MRgrQn6sfOp/1cSrU8sqLBxd1CKS61Uz0aOI2rkach+iJwfUgdfcNZl
ot74/6gYxLJs4KqT79wPWt97AhuvSiX/Mins41zylTsmqAmB9xgKMld5cWMbXzsc
2Y4iBYtNRJA4XB6TR1VuoV6ox7Rko+aHONKUng+rnS+Qo037f8644zA3s1oDVjMd
gAs79lCEXYODhK4YZKXJM+WfOxhCSy7F0NBer3z2u7AFxM2pNfRnf1fS0kubXcWo
CEEfKjJhwELSejiQPqsdBylPnfBezX39rABpA1JzMMClsUsW22R5pbY7fVtGr7J0
45H4sEyvpWlSVMRYUp7P0xwkzC047v2xhxaxcOV5wzOISihbEV8BKIeo8IT6aMM2
77Vq5HvI3EQhlhAVf9pp2KgF6MZGr4WAGD2l1WiP1iBfC16vHB9Vu0HlAt3q6FRj
wWUIsdhlHhJYbbq4MCUWXO57q8tyBc9u/vFxSBoYjizANPwdppWoT1gX73aq9zw8
BeX+8ZeD7mhwxt+zSDvsZbr2VoU+1kxH0xm6C71vYZJP2lyEOs05HvT+mqEu5zMn
sgIwndoOP/b3MnU/y1sxcyxXadoopd6UWX0M1fgwhHqrQlSMvip62IuLumhVp9Pb
bBt7fpBrUUAl5lXJXDpKKAxkh7x/rQ+a2tmBkByAgWU=
//pragma protect end_data_block
//pragma protect digest_block
WhuU8uj3GJ2yt/dhlJc2x12lh34=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
clqXdv6hkrCgYNXu7ioQhdMqMYQEkFNHTHurGf+aSuIW77dZ3sC+MwDsmo3DDox5
T+6FKEoVOrdkzWJOU3gM8ULPiEhT4XASV+7FbvILBdfEKr6bec16LAvj1aCOH57E
9f6g9BaOj8wrX/YcXq73jsn6k6voEwKy2thj17HUdbaTjziWossTSA==
//pragma protect end_key_block
//pragma protect digest_block
e5zjFAyyZduHK0rpSc2cn4zwZ2Y=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
KM9c9z8sUQ4DmlX9vlLxaRc9n+I=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_FLIT_EXCEPTION_LIST_SV
