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

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV

typedef class svt_chi_common_transaction;
typedef class svt_chi_common_transaction_exception;

//----------------------------------------------------------------------------
// Local Constants
//----------------------------------------------------------------------------

`ifndef SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS
/**
 * This value is used by the svt_chi_common_transaction_exception_list constructor
 * to define the initial value for svt_exception_list::max_num_exceptions.
 * This field is used by the exception list to define the maximum number of
 * exceptions which can be generated for a single transaction. The user
 * testbench can override this constant value to define a different maximum
 * value for use by all svt_chi_common_transaction_exception_list instances or
 * can change the value of the svt_exception_list::max_num_exceptions field
 * directly to define a different maximum value for use by that
 * svt_chi_common_transaction_exception_list instance.
 */
`define SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_MAX_NUM_EXCEPTIONS   1
`endif

// =============================================================================
/**
 * This class contains details about the chi svt_chi_common_transaction_exception_list exception list.
 */
class svt_chi_common_transaction_exception_list extends svt_exception_list#(svt_chi_common_transaction_exception);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_common_transaction_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param randomized_exception Sets the randomized exception used to generate exceptions during randomization.
   */
  extern function new(vmm_log log = null, svt_chi_common_transaction_exception randomized_exception = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate argument
   * values to the <b>svt_exception_list</b> parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_chi_common_transaction_exception_list", svt_chi_common_transaction_exception randomized_exception = null);
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_chi_common_transaction_exception_list)
  `svt_data_member_end(svt_chi_common_transaction_exception_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_common_transaction_exception_list.
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
  extern virtual function void setup_randomized_exception(svt_chi_node_configuration cfg, svt_chi_common_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * The svt_proto_transaction_exception class contains a reference, xact, to the transaction the exception is for.  The
   * exception_list copy leaves xact pointing to the 'original' data, not the copied into data.  This function
   * adjusts the xact reference in any data exceptions present. 
   *  
   * @param new_inst The svt_proto_transaction that this exception is associated with.
   */ 
  extern function void adjust_xact_reference(svt_chi_common_transaction new_inst);
  
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_common_transaction_exception_list)
  `vmm_class_factory(svt_chi_common_transaction_exception_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2LqVfUTqR4i4zD5vASHop9fBLo8dBmR2dzrrLTN8cW5lXM0CJYpIkr+LeBLSQqOX
A/lVTW+ETFwESJ7OAIN/gDI9XXUP16Uj+bkyTUjoaak65EHnajL4VekqoBngv6eV
1teBIRs99s2kZVDYkNzwoqrDj8TSdrWX7HNI9T1kkHXHZwkNvJKySw==
//pragma protect end_key_block
//pragma protect digest_block
TNDBawlurZJzUE7WA3/DvVPZ94k=
//pragma protect end_digest_block
//pragma protect data_block
NQ2wTU70sJpi/qcFN+AyMQTD0FVR6XdC+tO3hAnICxNfh8/8j01gfeuu/0fvGIyW
lnobgiB1AHF+9z4i7OUyxYiYjZQxC2nsxdxK1tPNmYcIkXryX/T9PFIPbppkavJX
fR+VEM3Bo+gZwX8jdBZR8Ef8NlnCDWivW59EqkDVrxH0McoJcC5SKaOTzdSVf93J
kvZ3ObKF3Uwo+0875GHW+TMexqj3aZ1ReDu5o2oYK1Yta6+m3sv6JvYL4Oqq4sbs
baF7de8kTZRrWydh9oQG75FNlr540Y1xnEB7+StSTkk9zJdHkko6ul0VYgzH7RPQ
RSOxm3tKcbqSSH/xvRfRhSzID3CH1zNFYzp3mjg63cAywIZlQbtm6oJS0vcxduCX
ih+H5hA6vrZA6Sxgmmcy/UeuGS6iMTQGrqJzvzd1xkB1a8STwgEEhtBDQaz0n1fg
iDT2EUXzOO2P8PjlCcI0wi0ykuEdFFVl8YB+TwnE159SNN0s/Qag3bfH9U+Hl2Du
3jf8QEMgKNafCy/J2jk/s4vDQ1WwwA/jtlMwpCrkhv6yYpJtW/2lxpP+jbkuZuek
x0pvruLto7ADQbX2fpMMTcF9Zud+ecWY/jH6AcZWVq7eScmg//Y0YeDMm0mHipMo
XCw1FRZ0cquw5Wcubdhr9r79zDbgOmOLJOwHSS4wNJ5In/fwk/Cs2wtbCGRbtwcG
ubF6vO+OurtWUeyrtcFKo7GIAkRDDu+rPmNenMUr7zddXBs+kTa558YZo8qCuzIy
cAUjwxYyC6tXmpSj1EzF2vM/2mNsaL/2nk771HOTg8w4qqIRmDlreWTungws8HDV
y4PKSjAraAxigbOPeOBhXdyoIMiJ/MuIpAtOPV7PPqmf16aRx+HvkfZrtG5+vj9Q
76yYeysoyRSC35jsRIWLCyUoHk5uzpvDU6tLgtAWHUVGSurc2wqUy5vOhkxYSd+u
Fmqw8t8iDCAJLyjwQTE0YpINJOwiUo6RiXm4rdEJSEF5Nt/pn0PcRGBZ6JLXRz6l
6AOoc4ZrkXw6yGcz63cnM2foZuzKLTX5Er2b59OcnB5BoH6gs5uTU81qixLGMgYF
WeDErfMKAwsuDg477978eIsyrUkR0AkZWq/RJAHj18UIxufGddFfu9ztHQJushvQ
ImTH9f9uQFvWDW4B+xuGDSFRWVPNp5wm/pozOwzQCNgyt5ytUWchGo9eR2p0+ne8
KngRlKWO+gun3vCmjyYBEg2+trZEPLzM2JWXpble7yWrwkSuQbRANsZhuP1MH5FM
Q6Uo56Te38EIvxMuJ4afKtnpdN8Pwc4OJicnjKDG4E3sNnxGTBVg6zJiFrkANbHS
SszbrDcNmySakmK0sX+mPjj5ZatU20Y/0FJCFCmaEtLa1IqZ3TpTbs3ZVqqrpF96
P3lOUrO834xhOzCLmKyNhWi2GNZPtwrSqJ4JDIFSujXyEibo72BkWv22OYjZsJ07
dD4WZ6aa3O+Rw5hK60VeTfNCm/KRVfd/Qe/Z9zFD4DP0GLp0C2dLW+ZUgzTjKIf1
O7/dQZwbglOh9nqDGHO8b+ag7DaqjF1LH3wV664HmlszS7y9fZ2TWYUYYd2FDVP7
KNTpYelcDU/sPCg8GobAtlYkzE1Z3juHfYSYujM8pzmTgfZoyMSWFWjzwszkotIV

//pragma protect end_data_block
//pragma protect digest_block
s2JmsX6qTvTToEPx0Zh7Q7P8Tcc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w0/ug9krtn2DAKOfdsh5OqIpQcTK6s3I4AelLT4IYxcPkWap7SGF3pc+IlwqsMnW
giXxrkyV3GaJvlI36FSAnVNWTKLT27CdTNSGXTqlc7MKYNZzbw6VjzSlp2MsdXBD
L1wNN5KgbAqAyDj/VJ143IqLPpPYehZ3w4JCvSzT38v9iwILDudhzA==
//pragma protect end_key_block
//pragma protect digest_block
S1oqxCPC1m0I+0MjG7/h6DK8Lao=
//pragma protect end_digest_block
//pragma protect data_block
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
hQ+AWhucJYOQ6f5wKhk5Fg==
//pragma protect end_data_block
//pragma protect digest_block
UU5MlqUN05V2MiZ4INUCtRY6dhs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_EXCEPTION_LIST_SV
