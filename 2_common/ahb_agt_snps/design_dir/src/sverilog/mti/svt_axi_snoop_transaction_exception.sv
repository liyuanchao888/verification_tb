
`ifndef GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV
`ifndef __SVDOC__
typedef class svt_axi_snoop_transaction;

// =============================================================================
/** @cond PRIVATE */
/**
 * This class is the foundation <i>exception</i> descriptor for the AXI 
 * transaction class.  The exceptions are errors that may be introduced into
 * transaction, for the purpose of testing how the DUT responds.<p>
 */
class svt_axi_snoop_transaction_exception extends svt_exception;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z5tY7tRzd+SozvH/lGtqHns9hDrs2cJQaNf/M4EKwCSqCYervOPZpQ2ulb9cEMcJ
6iphpZQ8ooS//cZUUSs+MqSIOOnWTJzHRlyfytodl68Z37qpMOt2F+jBGYE1deJI
v73VYqSGLO4h6xcj3aph+G0HOOLUBJMsFy038rvzf+4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 663       )
t1KFGbLgJOE+EgSiwAhaX8q18fnOCp8YNx6hJx1CxsOu8Xee3X3DUdA+wMqkWjTa
XV9sZOeNWAggQGzwzwcbkjAVeZHNeMof6kKE5IuXg6XHwnS9iZiOv69KmVe5k2Fa
1yYfR1idck56vrhsBorhmcmSOGHdow/+fs8ZToRbgECCF+8Zg5M7UVaUySyTr7gY
MGju9fnLZLwV2F7goR4yEeGm5sg0LvpWNCCGiePpYg7SGh4WAvwUupUQ8u7Il1LL
C0yAsRQcahOIrRjq8k4Jjvb47eWOxtpRujhlKkKdtYT38H9b/t8h8jKjCoJu7SL4
Ap1y9b/v+y/+bt294ilzRBr3xSq+pRBzz+y3qVxkk0FE1Zg61VKK8J0kyA9O7NNO
CdVLH/i2QMN7LBrTp4b+6jDYLQ+mXJd2v2ZwESt1pJ2ysuQKK0pNE1DpXK6VOzLz
Gpx3lDrLijbZkVLpa4axNYiVvSIWPtlE3u/cQj0LwG5Vllc9Q28g6lLeqN8dI7ex
PeSNiP/XUa66RiCAYUWKGeOPWjjsR1F3cANCrEyLejNVqYZIlA6ojiInAdzlwmcO
tlKmUoNQi12snu9EAh4zdyh4IenVXoUwG4AyE6pNQtYovj12iZoU//sCcOQl05rM
Go81HVxNpMaVwrNq7FKegnxd9drwnsEAGzm8wJyCz6h7wP2MCDvwaCtX6ON6bTgR
/J6QC6Yl4qhBCoO4zc9AUAhBCdI1L0d+o8TJfLUnZAJnx/nnECVjsdgQNPr8Byxk
oJd6I2vc2sc85VF/xKPlYhnvxN3I0d/zOGMyUOTg3F9zssVSxghVtiDOmQ4ImYpc
URYT7sVDPMGZXWjTW4G9/pLiLDkLb2mc6sDPDCeRlD74mHAB2cJQ+zg6uelQoq4O
`pragma protect end_protected
  /**
   * A transaction exception identifies the kind of error to be injected
   *
   * The following error types are available:
   * 
   *   POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION: Corrupts the cache line state based on
   *   the value of final_snoop_cache_line_state
   *
   *   USER_DEFINED_ERROR:   Generates a user defined error.
   */
   
  typedef enum
  {
    POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION = `SVT_AXI_POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION,
    USER_DEFINED_ERROR   = `SVT_AXI_SNOOP_TRANSACTION_EXC_USER_DEFINED_ERROR,
    NO_OP_ERROR          = `SVT_AXI_SNOOP_TRANSACTION_EXC_NO_OP_ERROR,
    INVALID_START_STATE_CACHE_LINE_ERROR =`SVT_AXI_INVALID_START_STATE_CACHE_LINE_ERROR 
  } error_kind_enum;

  typedef enum bit [2:0] {
    INVALID = `SVT_AXI_CACHE_LINE_STATE_INVALID,
    UNIQUECLEAN = `SVT_AXI_CACHE_LINE_STATE_UNIQUECLEAN,
    SHAREDCLEAN = `SVT_AXI_CACHE_LINE_STATE_SHAREDCLEAN,
    UNIQUEDIRTY = `SVT_AXI_CACHE_LINE_STATE_UNIQUEDIRTY,
    SHAREDDIRTY = `SVT_AXI_CACHE_LINE_STATE_SHAREDDIRTY
  } corrupted_cache_line_state_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Handle to configuration, available for use by constraints. */
  svt_axi_port_configuration cfg;

  /** Handle to the transaction object to which this exception applies.
   *  This is made available for use by constraints.
   */
  svt_axi_snoop_transaction xact;

  //----------------------------------------------------------------------------
  /** Weight variables used to control randomization. */
  // ---------------------------------------------------------------------------
  /** Distribution weight controlling the frequency of random <b>POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION<b> error */
  int POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt = 1;

  /** Distribution weight controlling the frequency of random <b>INVALID_START_STATE_CACHE_LINE_ERROR<b> error */
  int INVALID_START_STATE_CACHE_LINE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>USER_DEFINED_ERROR</b> errors. */
  int USER_DEFINED_ERROR_wt = 1;

  /** 
   Weight controlling frequency of NO_OP_ERROR.
   
   This attribute is required to be greater than 0, but will normally be much less than the
   other _wt values.  If this value less than 1 then pre_randomize() will set NO_OP_ERROR_wt
   to 1 and issue a warning message.
   
   */
  protected int NO_OP_ERROR_wt = 1;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables. */
  // ---------------------------------------------------------------------------

  /** Selects the type of error that will be injected. */
  rand error_kind_enum error_kind = POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION;

  /** 
    * The cache line state to which the master must transition after
    * completion of a coherent transaction
    * Applicable if error_kind is POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION.
    */
  rand corrupted_cache_line_state_enum final_snoop_cache_line_state;
  
  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Maintains the error distribution based on the assigned weights. */
  constraint distribution_error_kind
  {
    error_kind dist 
    {
      POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION := POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt,
      USER_DEFINED_ERROR   := USER_DEFINED_ERROR_wt,
      NO_OP_ERROR          := NO_OP_ERROR_wt,
      INVALID_START_STATE_CACHE_LINE_ERROR := INVALID_START_STATE_CACHE_LINE_ERROR_wt
    };
  }

  /** Constraint to make sure randomization proceeds in an orderly manner. */
  constraint solve_order
  {

  }

  /** Constraint enforcing field consistency as valid for error injection. */
  constraint valid_ranges
  {
`ifdef SVT_MULTI_SIM_ENUM_RANDOMIZES_TO_INVALID_VALUE
    error_kind inside {
      POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION,
      USER_DEFINED_ERROR,
      INVALID_START_STATE_CACHE_LINE_ERROR,
      NO_OP_ERROR
    };
`endif

  }

`ifndef SVT_HDL_CONTROL

`ifdef __SVDOC__
`define SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
`endif

`ifdef SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition..
   * By default, VMM recommended "test_constraintsX" constraints are not enabled
   * in svt_axi_snoop_transaction_exception. A test can enable them by defining the following
   * before this file is compiled at compile time:
   *     SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
   */
  constraint test_constraints1;
  constraint test_constraints2;
  constraint test_constraints3;
`endif
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_snoop_transaction_exception_inst");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_snoop_transaction_exception_inst");
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_snoop_transaction_exception)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the <b>svt_exception</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new( vmm_log log = null );
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_axi_snoop_transaction_exception)
    `svt_field_object      (cfg,                         `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object      (xact,                        `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_int         (POST_SNOOP_XACT_CACHE_LINE_STATE_CORRUPTION_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (INVALID_START_STATE_CACHE_LINE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (USER_DEFINED_ERROR_wt,       `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (NO_OP_ERROR_wt,              `SVT_ALL_ON|`SVT_DEC)
    `svt_field_enum        (error_kind_enum, error_kind, `SVT_ALL_ON)
    `svt_field_enum        (corrupted_cache_line_state_enum, final_snoop_cache_line_state, `SVT_ALL_ON)
  `svt_data_member_end(svt_axi_snoop_transaction_exception)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and svt_data::COMPLETE. Both values result
   * in a COMPLETE compare.
   */
  extern virtual function bit do_compare( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_axi_snoop_transaction_exception.
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_allocate();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new object and load it with the indicated information.
   * 
   * @param xact The svt_axi_snoop_transaction that this exception is associated with.
   * @param found_error_kind This is the detected error_kind of the exception.
   * @param affected_tx_packet This is the index of the tx packet impacted by the exception.
   * @param retry_number The retry number when the exception was encountered.
   * @param recognized Indicates whether this was a generated or recognized exception.
   */
  extern function svt_axi_snoop_transaction_exception allocate_loaded_exception(
    svt_axi_snoop_transaction xact, error_kind_enum found_error_kind);

  // ---------------------------------------------------------------------------
  /** Does basic validation of the object contents. */
  extern virtual function bit do_is_valid( bit silent = 1, int kind = -1 );

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned byte_size( int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports
   * COMPLETE pack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_pack( ref logic [7:0] bytes[],
                                                     input int unsigned offset = 0,
                                                     input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports
   * COMPLETE unpack so kind must be svt_data::COMPLETE.
   */
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[],
                                                        input int unsigned    offset = 0,
                                                        input int             len    = -1,
                                                        input int             kind   = -1 );
`endif

  //----------------------------------------------------------------------------
  /**
   * Used to inject the error into the transaction associated with the exception.
   */
  extern virtual function void inject_error_into_xact();

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   */
  extern virtual function int collision( svt_exception test_exception );

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  extern virtual function string get_description();

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val( string prop_name, 
                                            ref bit [1023:0] prop_val, 
                                            input int array_ix, 
                                            ref `SVT_DATA_TYPE data_obj );

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val( string prop_name,  
                                            bit [1023:0] prop_val, 
                                            int array_ix );

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return Status indicating the success/failure of the encode.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   Performs setup actions required before randomization of the class.

   */
  extern function void pre_randomize();

  /** 
   Sets the randomize weights for all *_wt attributes except NO_OP_ERROR_wt to new_weight. 
   
   @param new_weight Value to set all *_wt attributes to (NO_OP_ERROR_wt is not updated).
   */
  extern virtual function void set_constraint_weights(int new_weight);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */


// =============================================================================


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UjWH0TqS1+WQ62ydwOInZNKHWcG0RCOmgHLYia5lAUmI5gtWJx6CCK46lpaZ9H/H
QGP5ysO3gk2tj1T31CjVgugA9ZOkddRus3fhlP58isQzzSFOUW5AQ5AFsRto1Wqx
C2Oz5pXPOKnjzdCOlp+ffPpFGBAR+s+GwjtHjVg2t8Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1364      )
BnZCBM+tjBKcq9kFJ8cdxhrX+jU7fCVRQUnmUHbFTuk5pLFwN5Bml2l9ClSibmzl
wQc56C2DBKYazc3wevyGmYKh4vH6WdnG5r6G9XMa2njfQRi4gblIzuR3q+Lteods
y9LUnQ7ZuVo5xPBfdRpWwgoHNNhFYoev1NmeH4L2AlpITc7svuvwhsO/trldN3kk
MevVyt/qDNdR6wB0UPmGFXlC0a+JrhDnfZsmSL2dXp1i0PLfoWxCiykPsuCs9+Hp
J4+r1yRqirP90ilMCAN2kq9MtE7e5QbQBE8uG1e1jfVGV7rWV+a9RXZXxxTOxjjB
ZBGsbjtr6iIswAec63+f4D/QcLuAHqpx3Qz+HXvxOJGZG/y9v7AXp9BAeabiCplH
DItsK4xJmEnXm3+f/z80G0EWub6cZ+ezttYOpzUgd47LUxWshT41KNfk+8TfcEhl
WVFgbCPXF8TE/N7kA0wCdGIjr1znUowTI5wv6XCNuBNLrFI/+YzCEhjeJ04Nz7IN
U8rjpI6p4I7wO+jTmQ2G+bNq72JSYlXBhbdGVNnMP9qHWDdpJULJPw+CRx2a1Tj9
WmX/irpPVXczFLNoHHxPKp2icyIYYrwCOOWBuwUxJMTQ3TT3zK4ucEQrJ6SILVfK
7aPV7kLVRMumJo3gRERDTzS7FrRjA71+XqRMyBRFB6k9XdxnE1w5oyGC79kNuhyF
kcMsKIdwHOxegT8DPBQ1/zH0frzZb7USKCyJXqxc7PV0TXozm65vX7lo1Auir9Oc
plfZGQdv8WY+24Xu6RSE1trIMfVtLGkcoMLXHJv+qZ0LgF2bnhjNhwLjVnybbPlE
eu1BzHDVPgw/F3fms68KBgKw5oXvHEmsNgXUD4Z7SpM2DIi50qJgPzfGjhm7wNZz
wTIzHM/MJxl3GHFLdxrQovEzzhi1XugPzo/K0lEASGU=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JbG9uVe0DSwpZyMgOBw/6va334C5t0m7ULEGtAjbdMOmS3QGW13CPdABdoPT6ukh
o7DUpi3zWUQfClzfHK5vKIgbUXwZmA2bmvBua9IjWyiD/BdY/3doyRnFOHFpYU3S
khwnyTOaQA6D8kGAUJby38iPxqB5FaDpFDwFEPNJmwo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20540     )
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
`pragma protect end_protected
`endif
`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RDEUEAiiH8B2mbmvs1ToJXAqWRWdV5Uk2aDE+qdjgAuHcabJHbKxBdy6KqHxSkYp
pZCYdJ3aVdaeI9YJ/JlA+4La2xGkWhvaxXu/XqqGXB0D2l7cGliqPIh1hgdB9pKD
jxDC7ICK+HWUiVF1mExFiudHeRcpc6FSWUut8mluLJM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20623     )
0b6wTb0SQltwZUyR+HYcDhZZvL/nM7fNKuoKih7iDYSjNicXaMsJtCCWOkKEinfF
r7m1VY7hYCgoU6el3NwivQHVRPTxvjQoD4/UrbyOap/sR04U30zW38SBATEh3vn6
`pragma protect end_protected
