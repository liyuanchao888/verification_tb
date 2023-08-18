
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
v9VT7ZGo5c+oHV/Zd04Z29e5ptRTD6u5ejc4zTUy6RryKDUcqlMRy2wZj5hbRibM
m8om9Olt7nqCuA2hlnFiGTd5jYdylBVrjEmh8apx//sa9YG/bqnn6o7ZeNi58jNw
UivJoDIUBVmZn9Fn3XfE1X/ijLu+BaQP80iyvYZEvKmZLNl178C5Dg==
//pragma protect end_key_block
//pragma protect digest_block
nFTOLNV7jv84w62gCmFG6bwEDj8=
//pragma protect end_digest_block
//pragma protect data_block
Paq87JQ8s485ctqWOV17G2cpbdaJ1/Vc++6T85EAZ7Zs/dMf3KeepoDLXCcv7CBB
KtWZvHu6cgqB2b3Zz4gPtaLeUrf3TYQY9BHBGwcBn80iVG5/NxtkiAMfDaT2jdS1
+lM2phAT2ObhoBFaUlpbcCWrgrHL3eFhKdXi2EI68Zo13OMSxAqJSZJtmOwYs9wc
NNl6YasbjtilzjFxc3LuISqva+Sh/q62xz2+9CxvY8wBDjebq4XXwuttCOS63D2A
rW+3WT2GTOiygiBeOJAi9uFTpzp7h6QiYsXw1v3tDb5SK+kwa4HJyTbba0+F0M2m
sMZby61x8o9mMLkCB1+7HB5dh63NysFh7Rwk4QW6XqSbqCtT9oG3FFnsfQFnkuqc
SquGO94SUMQQHXW7GdwRXWiIHqMz4r90IRoKGcNQs7yzjZAM4djhbrWkBXvG5y28
6U7gn066ZK9saM6hK86yUfYjkl6hUSDp8hS3cZEQ6/9DoSjHpy2DDVx+MArlfAvU
vqcU1PH4LYyf/frFNz6x6yqZcgR1P14Rmni+LR4J4kncC6fbRm6f9izLDWJw3vxu
Gy0mOwZA4KqFT3GMXxWyHtwKfMcNwjP4vdB39m9nhsi4OItwL5Vw77DcM3cz4ibx
YPCoanwa+mIqiV1d4XfWewvS4ZrbsmjMBJTp1HuUQpkdV94tlMXA1Dp2vKS+T34L
NFjv3QMwUlrmztZ51Mz/ZpPb5fWOJhn7SdXPNRFbOmmK9R6wMhAKNaZsU3QdO3Ep
tlPzzkY6KuEaAteb6jsI+29MX/sGeF2qylBwwm91GPHKF7iLaei/XZwrlCyOTCfy
nLqWJOpoH9u/ErCKdrit4lD7P8rfbMSdfPdGUUkN/0TbuRFIQMi5YFWwBQSYUGFX
bqHVXnTmh6kUwU58QrZWXtlC7kmDbMJ18O3rOgEODbb/bVA6R7ulcK9JcswCxEfY
yGm5c/c5ji24uoF1pyEiqDQU0yH1kVy+e737OhDkx7myMMvJpvCAjqTGYrLfcEA3
zDOmLrtDcuM9BJnwCq/L/XnLT/l5mbd2c/GdVW397RwE49uBmWNenkPrtUo3qR8a
x4pxG4OqEbQJ+8idBQ/hlg==
//pragma protect end_data_block
//pragma protect digest_block
TUOvPAyLjPiZ6TT7OE7u1bIgMag=
//pragma protect end_digest_block
//pragma protect end_protected
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JqakUsB3sNDvXMDZ+YugJp+SPOXp1ZV7lVBO6w6eFNQx0SvPY2w358G8pGh4EAj1
krmV/fvWmeYzrweEvUUdFzQlaknErsQ/bZHFAAqV5Ofj3HbuBQv79F0hRQnLcCNj
aJuNFa5okcuj8WoU0gXIHC+vTl8GLYR6NzLUSj58snseRqtVujTKnA==
//pragma protect end_key_block
//pragma protect digest_block
KS+UgLDs54BBLUGxOj7qvh0nlDI=
//pragma protect end_digest_block
//pragma protect data_block
R5vUhU88JEmNYciF32e6ZBaJMXQzXXyB0QxXUdX2wMyBBQocrD+RoetFA+/6iUjA
BVJr9SMLMnyH1tDkTpclpK1TWgfRdcYeWNNubnBmY2fPNhB/UKifrDneypNE6Pb7
a0oc4oe1wxJYxNAXQk115AFPeEtUQw0bihgHRAAM/wixkLPcZ3/lXHe7ciSy75+R
zpw/jpBZvxxSCp4E+AS5mEZmViCxqWurFdU26zgAX419b2yCJPzbc+id2SUuXXdn
BIsOZPxDuM7GNOHh+lBJSXMh8AxRs8tf/mPKujJDH7dQwZfKP/FbBezK2LtdwjQp
OI+UJLOEj84SsFVCa14+mvflsLCrrCcuJkSMZGPSo4ZOmdNmW9MDr9yuq/3fkxhs
vW4NLg5UDv/nuhHjEISrqg4K5gURhiWnA2ixVEVJeociiC/l30CLAgjnx2s3b3vr
AnLaNTxswzvlvgnhvTidVDNlMDfDn5cMnfAD4jZK1vmt5HM+TnXUg+C0H8KQ/DUA
bMfFEjR26/gKyELCjS/zvX0S7Z2aVp/qiuuvthQM0q3EHhf6NDAQsvt5faQg2dfB
4+KpUogwDXPVjUkw7SRPy6Z8hW3Iqneq3ywc7+QAxIg/oC6wTtmvRUU8/AgXsQgv
03jEUzPu596nCGXDcBmiO3F3WWlgifsaUpWTiC4ody3D1/UpXg+93DU3U+GJU5Z1
SXommsCQGsDn8grFI5SFWwaA8RHkOyjSLxi3+SHD5Y2sEqmzFUuD88fom8B+Q5DL
UYqU2MX/ms0WUq/wfP3A28zZBia+Um0+aN9ACzO7bmTvlWGNEvDgJhO643YLi/0+
jvt9oeG94/R4wnIOmSTX5mkwWY8UwW+81llkycJPfqAhJzb/a083X/0gypc0D5l/
lskgoCBX3NrI40UBqbA1rTjg68YEYAWiY6golSWD10JOyI0iaYk3TlEC6zhk/IAP
hewl+5rMZypDc5QfFp19rEsXV6AWXQtD801x0LHqwRU9kZQcyqZOKVO5HDDPF9Y5
SR7KbtuWWx49cRWuq8tqJBbELHLJb2nhTIDlZumTZYrKOYwKJAznx9f+YwuZtvhW
22J9aIMPVx6zui+AMfkr0xa4StpEA2oYBHni+AMQWwt83n7zDiMwARr/OvqfAOFL
im/FT6ZmW8o7Baqnpn57Yw==
//pragma protect end_data_block
//pragma protect digest_block
JN0KJf5VqOCsm/k4L27TfdUm2a8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ldtyD/FLpQvUrZLASp36EKcQcybBXJkTB5P30QPANlfjvVpnq5xy8m0Z4QiNXCJM
totAoWFxA0SP9g+6PJuwC6zW4Qzt8MJ+CMnnjzQCAe6qAF7MZAOZd6+BzIMqKIRm
yahgGl6IsUk9mgakUg0g0StYKcZ1iylqHCu7XCWLEKh/rFWp0hPA1Q==
//pragma protect end_key_block
//pragma protect digest_block
P8PCOMgztccQ+4LT1Slpt10env4=
//pragma protect end_digest_block
//pragma protect data_block
5CRlWQhNd+Cx1xzhMQsPpSE+z0IFrd+u8R3RZurk+sc6ZbZjO9lMyIfpltHBiKYV
LiiY07hLnlMfqGzzqgzxc/gjcSNbIZRX4kwfqcFdK1Fqjw4paZYs0dFMBelIfpRb
OGUY65siTju02UwBHBYcTGk546XPD+QVrZH54ACk2+dZ1e3ARfgEIhocBF1xiMeW
NjsZin3MYxrieqYj1lDkioOuosRTDPpV9GuZIfS15GVsY6aDcfHPXpHqYs2LMLXf
CRJ5h2WRRZWlCACCjSHzzD2Jump2yM2rqJteuGp9KZvdpM9ar7gjd+fJDbmfSHLC
DR2Og/HufU3rXalULzdDgvbFMlz1wJJMhlHIT4hAq5y3JfHzlsrq+VItL/cHEPSy
dCi1V9A0unx9eSa3Ai4ApelEeHBDt8tv+Ia7KSMe/S+6A64chWtHmQBCOAVqse19
cNhs0FCYFJsy3sQGrcZcM7J3RorNEeePbQc48wv9yzI+5aUTasy+ZaPWInsAOEnJ
1ejSrmq/bom5ljdrjeVW9Pulw5ycfKa4oKIEUximOzzXlxxKlBXi63mGpOP/4+CZ
ctXi/t0Bp8gWDrx5ZKID74xTd5oo3X+RCi69fSrbkxBPGdw68zNIN4tPqqbCNuWm
P4GuawhpTCy/f3utwvPAa4edG3PrzHY6FCCmxyA6d7Uhy6KC51/fmUKjzYklbPXE
dzK9dcQf1X0knaIjeK/sZLumyxw/3XuRFzgzVtaOikBrWAc49vSZuKyJFGFFjcHP
oEzRUF9XgrcsNS7jhJXg/sqqoTEil2Odw+h2Gyc0HuzuVKtT/jUIpNG7bPAWSQ+9
w5lRkC7E1VxEYi31KeQOjXYaVBa8KV11mohKlTvB7exWxDoDftZZ1iXGBoUAVZSY
jVKVsA4I5ZrwsCM93Fs7zEWmyMUyGDrzp8X9dVfO5uY9UMAuseVqLD1i8C8PMhC5
VssafBym5teJzfCWg9zMhQ817yopTVIgAkzJiIyGp8QdQeMRCT1HRh/yzOUis1U/
r4fGL6u2hD2dl6DNTMdOTUYLxQ95Q7CEiXq2oIXCy4yNLEwBs2uJzKDSR5DJSaYz
j1N8hNHfLgn6m3LChNbkKFE8cEcu/GPtv8KxEYQlVD8QuWRfcByggY5t/rhWHKst
SPIdan4KUlZVd36UF3EZX/OYuDZDLYvkjs7reYSXxNaEaWJoZNpz6SdvsfzT+DOE
3P1I4tmM3KT13HGGgfksuEN9hCmylnXfxxKSMDJGhwOaKbmhkHn4A05BpG7gjjc6
CjBk6bwFj77xo7tYgde/Dc8/FtUkWCsUg2lCjFUb9GDShCr30Ikpy6ppTx9PyAZS
ECptPdrYWurzeiLs29RgeBqz2o8U9LC0S9KC0HhtFNOS5cBit7GyIe1GFMu6zREw
krmJ73DGrzGyle89lRJwABMYTYI11b51JjgpxTmeVhEuQSDx6z6PyjZTfsiz2NNq
pQVKtPVm4yR3r+VYUL51GlIYaj+5c4MqzpfzbNYCCxk0nL5Dvc7DOElTrMe04O17
Vga0iXdQ/AdHpt3MvZ+m1TodYfX8f2ZPD1Izo8O8p+JEIzdOoxmfEmtJav6fvrSl
OCUDT/CozZfmGKkJvLzGR4QLudJN/2LUWZOFjMSoANoz6KJcPiz7hJtntBST8kUX
dctsQD2Z8kpfFxzqME+rtpitbLKS6MVpamn6fgN1km2ui/FCa42ew/z1lwweFK7T
jj7crr5FPI4m3hQyduJBvY2gBomBO/bhWYNUKEnRkyFdHbMmYDXsvEGCYT2n6MiI
fD26+MeBeNWYea4GoHCYFNlUM/NlIKnLAyzyhHMwTf4+NDIntaUE9xLK8YEwpOBS
BmPhdZ079q9QN3zoc6iFWFRuXTOuYB4zyNplis/y6KcttLnoaueeFFla8OmeBiJ+
AsyHPZA8mW/8IJPtzwSFXaDcm5KfzDxpz/mEesCrN4aH1Zy1+vHsJb1DSrWMgq/R
zyww0SEM+AbRlZqbGlqWGQwc4lEPysHCY+6MoFIbsUjirexHND3vMC/L5nKLhE7n
NAshHjWNwQWfG96S0bOg73GGTmpycS9vnUpNgVU/c00IteImPmyPcpy/c43pRnL7
lkf4iH9F77F1yhD/+/AgWtw3DR6BgGclGcwy9W8JrAqdIKf3S8WoJ+J+vI8uu6Ng
BvPwi5c1HmIdnJeMdwJfcP56d3Sl6lD89ghQhY8OW1Xz1bD0d7mWkDqidOsTvMgJ
AsCQVouGSRnTHsB63uAIysUmHAPX1xy6m6YWaOgJa2gHY7JycmYKDYpH6VTfNEBG
/xPrC+xWUtDerVXS7nl8O3ExF7Id5y3JrVB9yB/C0XkTo0Jy9okqLmcwplADSi+J
VQBQVVjkpGP/Cbl8sZjHYjKlZGiR6Mlf3/KSLKlByXCEX0EEjEr4ZDA10bLlJyU3
kiB/WJCGyihraqG4Yofz65i72vpwSiwfddcltOtQvOxjgHa3/QXvsSEMsO84IDJC
uI6v2PlKJAHrQZUS4IaKCnhWbIgrNzG3KC92D4u6z9i4stqPbJ5492tgbB7ddr+9
Phj5AvvpeWtGAnHA6UfaQR6vymVmITy8/EuzsITkce6BP8WOw8BfX4ndrbbSFBps
QqHmKnkFoe9wH8MSJbfrxNJAz+sr5LHowmEHVjAHXw9maTHGAQTedrCn28kddGdX
tkeWRZiu8PaHKXomK65Dw04GXkl1YGCtki+X7dh3vL3vHpf7Zk2J5BvRRr5TQ9Gn
zFuLVBTsSSyDa/CmkV1DSineXPn3B6LzTtd430WeGL4JV37e0jv77kW5N/PcPo/q
S1Sm5bDzkj9VQaENY/EkvQE4IQwEwIwqtwaWSZCUe9eNWVr5mwaJbo7qqrWVBYme
82EuG5YQzNFKICrPnTrp8DTdToOdQEpN7uYnfjOOhkVKvB/OP1S0XYEhLVdHXP8R
9RKmF5W+sxhyaE/enA9upuWg60q1ruiZdlHp8Kj8Dc7QpIxv3qDwmoF/NB0PvK/f
A5wA9D/O1lhD0dalY2XRW5LWjYooyd8ygMfajzvnsh/6m3LbghgxLUK2YZPDRg16
Wvdlxgqnthm+4oP0qjbHjMzyDMEBljJk8gRy/iJ5U7VMI1MoPUuFy/IjyJ1qltD0
IEOozp+HRzRzWICt40gDgFJo25SWVV+fj70GucsJAi0xLoquN3Wb3E3Bu5V6H8oG
uFcgP0YuSLoLiDmpK8I4NW4nL1WnIc067f81RZhYc8QL/koLgIiI0tRNhc9qGDdM
XvZ73T1ZfsCE4P2jNXDUuOfI/miAkm0PxrpmutLkjKoyoQOCTeLmkRQco42G9lZy
AzMiT4Wl0BVBGYqYybIZGtVsOck+jxEvpFI73LADwkzTUTWt2Q5K9cH6CU7PZWgS
vkugKyI0ZkZwxbshlRaYtvFNdczn5Zeo+TmqJWH2wXMgLrG1gAuSsGY+YR4qLZak
/7DQDoJHwTcDm5MlC5EizB3WzbyF+FcO7Fkxu7UtHteiYWoDBf61AKBIGNAkX/kv
tQ11alxbx8qir9s9dMi6aj1RcuGUZGQCIS6JCaaVoPNwPcBt6yDG+MGEbKrRE2jA
B4eNudbgZL45Vi1pzUClkDUZOTw3GU6W+RfnXVcVBSjGLG6TvgLJgx6NUG+3hYv+
bC4ybL7YyuPshxGDitFZQgd6olHksDOO4TBezydfTPHroWRfKyR8am1RAZQrTNtw
TXFmgV23LE12JhYEbGcBIPxJ/3kprmBpBu3UsdnUPky4RbDe1muszgXEPeuuon3O
Hi0QJj2IAx/IyPqWsjo91xSKGyNqaWFIHDC0ajega3fI0asvIlDJwLjzYC8tgj30
xphEn4wCffDFuNAsX/IqzFGPemuRgLFjC3+CQHYoXvJDYmdksc+3JvPIwYiVLIox
wrE9qdkkHpM3+nsk5ERlJgGivJnOmldYtBybvgIVYKjeYL9avybXPmfh0xNOMVzI
aCxc7CKf+q19cI6hZL9zFtNtE/6cJODHbLdU5GrFNLxpeD292tYq6CielYuZgVzb
rUQz3Oym4AXzGSVHb96LRNPGMspzMtYa036afsGxl8nZ0k80xIxF56YtLZXBRJ4V
x2gVLdoPd1Ixv+PZE1Hs/2GWO16G1lclF1q0hPwvjSmWmfVHW0q0tXau/3lyTuNd
QuWzYR8Ua5NWEKL/TImXy6bVA0H+VWJ10YYFRwCWXBOCFU8/6+vBBF1dNR9/9eGR
Aq7NYeCdWTkkqYMYaWpJrk8wKpz4DFsHJq6x+uBwcA4F1n7s8e3rvxeQKVxpfjpZ
fYNeCVgsmTz1fWZMqPUf8khNqwQTyinbueG6C884kCpGr3B4PhjNW1xhfWXDUWYn
oGchuy29Rr+VmEBTF2mcYeQztQfUtZO54VMEcIe+2MPX6ZbsUUvSAV+bi3brhRMm
KNwFWm8SIQzbSeqXThCbZXMmC3d/C2Cq/2llMovxlwRTEui2djLePcTrLhdvcVdO
25NIEFqvX7/u0CAqlYd0I1fDI+yz2owageuwfBzg4TPLlSl3b+N0/kOKo8CEJspJ
RRh0kfXI4nrO25a+zM7d5QzhGqnJhEkBisRIJmbkb+P+OZ+U1UiSEItZ+phB0Ubi
wRqmBds3TPSQCvPNpkZ7JBWeb8eUD8/6R+CPsuPHBDL5UtCLJkwXmDe6IQ1E4ny3
uheU13Hq/UO1Y8rSMrXPMY9D2xwr7XPbeFTK4L4WrK7/yYWRC9hwxPtbl4r7/yz0
22eH4AmdqgQwT26IrZzouL2rrRLtQL4r7oVDR74iySCn003baDci5Mo82rkBVyEx
AgXePtf7JafO1lRevGoYlhP0y0Xk1QdGGyGTPvj7pKRu65HwYtnv8Tv+8OJHSZTv
TWc9CX0MyagujlxvF2AeanLiAhwGTQYzBi2P1a9irLPydhyZQOM7Dw5FBQsqTvX8
NsMXOq56X96UARMcJsy8Hnb5sx5uVHK6KgMom8W9hKe9WKaRl292rBdZ6GmX4VGG
s6eXYNSjvzC3sll8OZT2W9rkeRYEpyfiXTrdziEkfww8zeWHEc/57JeTaiWnxRzI
fjbDkwQ3duUb3GSEK55Md7xSOM0aeIkWptrGeszAEckAJRvEgzcAvfPANPHFbOWy
3xrHvUNLiI+S7UXcnjpM/fOSTkoRL61vpl3ZT7VtFP2NyA3/bCRe4Y5m3pZZWo1/
RezNBX7YGm5rz9QlCZ3ZWx5VpMMfKqlmSaIUDn8oqu9y8dxo6OA7WHML0tRbzOXV
42aRO3KkJOLjF83zWkYAnOVcuvSrg1FurSQkEQzVvuQ9kRlJZsvexD65P4b4UsFU
Ma1jBNfdsCJJ/in1LCEgRWhvV3/PEmmfas5BM8BCSzPaTXMJVAk1JDu2C8HrJ7f9
3NSZBS0zd4PpDgnqRrv9qk4wqGLwxx+5JZenuNZdmFZnnsoqMIEwTviXouY+sNzf
zmSkvcgSZXQmjxpt3KLBMukCYU3Q6jKhCCVKJq7r/B5TxSwSM6nuTZjT50AUVV/R
AGS/2z+dmc0L18MsiKMbMY/AilJSozY0pI1i2VwVbdvdIlNFSX9FV9Zgz4cXpVag
VgXZtgkCyRJlIomXSmumaaleWkGkyu5ugKTGmSjAuEC7fV3CzFlVY2MZ41xrk50H
QIH+JqyRyB+UNqZVQLn7xnEE0bHp6Cu5LwAXADtR50JXwadyg/AnGi1mtP3Fxjh2
LtBkqlHVhHN5nwac8EdKtCJM7Ghdpw9zz9RHYNZX1kjyB61tyHC2plWahKqGpATN
b7bbgyJ4Sfhq3mxe6BLLRpQpDfRld3tQ31m8wJez17FZOkT9bezcLACWdv7LWJcd
afHPq3G75W19INfATtzwws2C4540L23H2qeFhM6IHrdbcxrUjx6FUGn//+QfUI4N
pBoASvddWtufcScjEDkPCgRtmtxosUIiJhyFTGHfqMpmPjkyQpjwPRb0Psi5ySwL
5DqkfcwXTNu2NU0hsbaEFh2Y1aMTxCaSRvRvX9HE5gI9afmOuL5eGozXNjMwKF3f
jSYXddbsBUMbQMrpFFmEoJrd9pCF9iqEy7QBTTk8yFSsGa8/c1pVY9PTyDaiLPU8
dP40YMzoDeXunzdjzx/1YzDiGG1RXUOnHysMUaIlo89zN4VhbVvhERBkUl8OWmFL
uyFdBsHtH78jFDSt+dVw/U9sCzHIpTZ5xxvU8X25ORX/m8Fk60fGAEWTLT3eUUUJ
UBgp9ygbNWwTDQvoi2XCA+n98v+bFLDw45REvWBxvYdctaBjcGPzZr5ctA4yMvCC
MANA/XLOmECxT4Si/q/A013fAZD/reWxpmqbTNat8Xq1bCzd6Q1p6A2eS2B6WVNd
OmVRvs4G/WMgG5vOcIwfzUGLBX8QcT//ElmWnknlhJ6av7FWV3bWlTpfqD2AxEvE
kCIS7hA4Ix+JrizLE/7vC/dYYYxbpddy7bIiS5DkddLqN3iRbgDN/hdXBPYelJCP
OmNVxL+NNuQfl1okG5wXsG3ApAmhbyd64JYpqu2xAH+koS9Fw2KeKMzNmEi9Gafv
WPkxalMlM30jXSzRGglxSWBgacNRCoLeI9N/uQTSziG+EAt6j2BZUecqobA3wT1T
P+DSpPs+QbezKITrddLOeMofgF++/BHcZ8GggHi53zGgcyZPg4UUnTpTvj5cACD+
VW9GGJljfoabOwhv92HN3XQWyzUlOmHJ/5muth4Mu5vAjaCb/wvRctN1y/TEp9ZP
Z7s94f30cRteEY+lvC6a3ylmr7meyV2uQ8yHKIYfjmdvBsVKm9Wivvp1/WFLpj6f
j1ptjlkp7x0RtZy9HaMeSUZWrmdj5ieqYcFacMiFtohDwz3zHq4XlY7ObSa5gkNW
pmCxvA/BngwmI4gkmIsELJCUOIVdmfcAB2IOvsFMdoav+zdIhvJhuRCUULMUGIQf
n13YOWRAaYgfebqc8tg/3LJFZJnKcP5WiWWzC38TLjNIdUuwjg9kOKRXubwcga0C
PixvnKoy58BeeLUyKnJIyaw11OC1pdSvcZUWxyaYmDjRSERLBCJfCXSWepMWxCMs
BU4pZ0is4LXzUoEjt9PDeYu9qhbh69f1dX2TDAcgb2fGbEvM3SLiQwGzhfecYvuN
+bTr4JKTr4jouga2sq0CIQpjRaglZp0kF9bjUmWHMV8DZHkEToL6Lcw9T7aAIqmW
x/ZghtILLqQLhQOPGYKjidMP4eVG2ypsKIGnrJuWBPMneTzO6ZLKUHBpaEbnsLN8
9HzE4M+f6ZwMGstwCN0fD0iCVflZi53GlKTV+kmaPQRLG4YOXLhvvjomEF00M+Xq
jycY7UGnZ0PGWkULpEhOm9U+LUT2Fo24zdj29hYUzrPRW40Ktq9d9RV/FjvyDobC
QA/MbFoKypnVOPz+ehzZxJn81s8FXgjBXOHG8Z7/Kt8+kL3ze43VVrjkx2t3r8vB
pjjsTh1hQXkXXbPsxfkci+vNN0k6pbaCIuD8Nw5CcQkA0U5f7g+azA/D9D/qgErc
cVSR47AsPm11BVQJp6IBOp7l665JZcpfVbyGNPFkgxYd9wtpp6gWD+wHBmhjc10K
S5O3ebK9uMz2oLS+0uDgNjFvVw5ARR5K4LMGEjIAlcYLROou3sqocXtfdwvemDDy
Kdb3kq4JJZwTxgejPjGPaX+Ry5cCNOJNZ2/jMr74kD6MBK9CVK4NVXIdkmaQ/SeS
sMl44UPACLDqo7+XLQHI+3j2lONSbKqaVn9HM5yAvcccZIcBwtmVumOYAiStBb2L
MhsrxwR8454OSTg/1yc0HJl00TCj+181nlzVNPeYyrOiVyCjtZ1mGIw/KseuJRzZ
DrplGVX8z+Nwb2T1861YerjEpb6rDFUnf6wnJoz06UU4HLabpWlzL7DAHPOam3F4
H+hdnvmqZyiyPr1QATbUPPTr+UEqtyxUKOFSkIZEeHhsoD1IfX4wAuyYRjTi6eFL
z3zV750sVfdE1RPrgTBr8KBmnnWX/b9LkuU8VqKe4eq4TWsXUOTWq8lhbymo/W2l
mwFmexkqP4RluITnQRQbaUdLtT7qxikIikJ0kTvhc8S+f02AF/EgmeHX/xF/6169
TxX6frmbUyVSCF7lTp/a0+Si1CGXj22MR74Yvkeo2KEoyQVf/7Mi5o6pEKOC6OLz
KUfQLWDNiB2UwpJ6KvNItPOYstTDawGgM/FhouqzqbdUJhvs7vdfZ2Xwems2x8jx
xmeM60z981G6A4KvYqocTiM7mXyaLTVkm4yBJ0AVzC+9TnlaX0a3kKpJAPO1Lp+f
Vwyq2+m+RIdIHpZNgJzF9tq2HlNHKEKNCg7ZUyZoBDwYHLbknwIwuPJUdPoxa8Tm
KekU5meTH57G6butnd0UmEDFwpJqkoJPosXBWGrR4l6dvzi/kiCzZfIDmQ9smpqO
jfhbzrzH2n0R910dAmpAPh2MS6SAywLcq2QKpI/FwwDWzcmtAJm4pV/5SylwWrya
U6mlPgtaOXLJ3QzDEMn+IS9iZ9xV5BWn+oVHaiMmX+N1B9GvIziXvHkFfvBtirlx
iBMbVSuIkneQx0E+fcyYr5cMRkO+Pl+nLURQhbClFZ5XeXDc32prFEcV/4l8JkT2
IVVi96mEEB4GLXE+6aXWLGqL8NiMBtQbN9FfWn2WpJhrp53aHOEjql7rY4242SYO
zsA020gWhzXwNHfMT60MVha4/TBQZcXzrfLxkZARsrCjT/WUAsqAvzQrcEXjTmIn
T4xhodgxmyMX0ZwVjgopI+13ZJK+mXAOT/u7G8Au5XEoWF3OnI2kmbuayu3kQQsE
vBE5JlgpB4nVDHvRACMts34lVkAn8XnuiBKI/8Yj1MGUMGHnfdG6Wc7YPNcKpfxW
Ds+YovF0PsUb2KE/YTIyq5frQ43N4lgyTOkUKv+wtqVAXfIKwsZC3eSc5eRYqlcC
8b3ecOe0kMOzCgWgT7pjzr/PWLVS3QIaBIs5e5ggMetrLRH5oS6x2A1wmwyjKMCT
cRvmEQKwkcDFDVz7+tuIFqjGyp1Boq+IfM1L5tFXG3uZ3rurduBrCu5LkKI+V4eX
tbr0jvS8gBZJnWwkMlI+/8Rid1AeRQIlkYyAGwcrrCFJVRiySzJCvPtI44s1upuk
HA5r0zoZB8sE2QiWAhLQzglHE/SBpBI/yxNFY5tZ9507E3V94GeqnM2SZomYe2HS
8mKWXNvkLcV8Lk5eLeWXwjLXyEGdK1ivr/0jD+kewX+CsZFbQELKfNTuRLFpJ/PB
DleDEurxX0C/Dq5Mrxe7nhyYAANbZxlJ+LUh6tqsb0qlywq7ytxTmV4hRjs/Dd9b
wY/aCA4bxW1sN5QjAP/wW0IA04ubxj1s8i9hmV3GXsP1N8IV/2u/wgJUDOwkrqt9
ev9MDf//LNLjpxcp65nyQJGKgrObHyd0WybXSJXFyMBFr7ntr1VGlTfYpQqhaQKK
E7I2q0SQr0aKgaqk/s2Xenol20oVn4/+XF2Ubu/hKb68ysLq0Ygpn+B8+1VXs9a3
pbMG7LhytepHHwqU5EMSp7fzzaXOCD4lt0gh+LA0AY0yltS/CaDL/gqpo8oIsOfP
SSJDgoEu2oHbppxC1DwNp8LbrZk8Cq070xzq01e4Z80nmIjIiR8BXlGxg7HDtFR1
C5x/xlPo4uU79DxdttZZ/K/B8nN25n7XEJ0xbx65h484Ykuot3iDXwzJ3r8CHqbt
WJ4Zkg13I/qVP4S1+mnrPjUmafuPxKrwGrGfxtDMP+DARxp3irvKlAsamrIUbfVY
ljtNgeSpxiGVvJtKohjv0mN2zZtKH3cAyXWQK8qGj3WNZMtnOiS1RLWfivwtAKcP
uuQIa69K9uYwgIMDekEs95tGM1YC9TzY+3nedjgBcd14RrFkeLLL8N3FMO6KCUlO
D3mBCS+99+5ltcNrmeQ/w+o7iKgJn+Uc31SBHWOhwQSwPat0llyp8sdkJ8h41Jd3
N5b8G444vifhD7xL7XWlfnMWsdJChuvN46/cLoI7oqAbGgC+/DtzFiuhuW/XGcRE
qjSl3bDJ7lw72cVftfsHaHHYt+9mCUgqK4d7Bpm2uCD6/feEwS3Ol+vDFIpBsr/O
HK60AWAdMEuhbz9hpQUI670R+1hxEylvjKCAtmZU90V//C9+iacDA7WpikpCNj4x
FAOqRsuJFkd3dH60O9TVASwsTHPvgSToMXTSloonKAQ45k8Qi2r61jssDijAWeCv
sIjkiIveTTsHeRKbTPQH5lOSyGIKKX1rLXgcK6lebxnqZWGOJPU97/Sxf/ZBzWWK
w0FKnBPtH2zLGDizioUfzcgB3I98SUBH5HpmeGrJf8RchbZZv0nrKjIdrqG42WhS
NBbN2QuUrpLlbULBMAHrAa1HsgxwclNf0BH9mzaiGNpQMD+cbTDb/UpVEts5b6wj
HN0iB9IzFOLTp/c4VsglN6ftCliUMHsAc0ItmOeQVtspk2f8pDIqi/h1uIdO3fUs
e/gSvkhWU02F6FXE44eLjNVqGiYXXnA9PdHTdSAkyA3Jm2dt4zlpX92Zi3enzORc
ThipSGoHEbsPj9AzU4c5cK+PFw+ZbJ345Q1NS1/JdHi0jvd68XIahc5p/nXPlfB6
13GY6e0dv1kpLIVXpDHOgV+bZOy+n06hCWApYogj7DDiGBoAIj2t4Iha2CmzQ18T
muQVd/1TKoL/XYaM+Z3CGXBt5wdaeux1N/Re41UXlWcTW6CLA6bQa6uL3XAd9sVU
0qs0a00bG0EbnczdhHOpldgdpbAN4dL1rU3y+R5Erv5ka+WVwXH1NikDrYoihv8m
77J5CL5oz4qMGCr6+tbKa7KAYa2K28NO9K9/kpr6RCLNuhkZLs/Y/1U2OGOWH/gY
dwo8NtnU5O1Fd2x/3NLgiPQKmzpL8PuvC7ONQ8A95OY8WBOhcCYk4+vxjDOx0hsc
lm+vXT8TCTcAqKpYFKfJ1AmkaZkmDCZRXCIAT5cjMPCSNJyeuzFTZop63/+Upi7q
X0RkK2qew5lEQ0FrV91LoHR6IWnew1pgsV+hT7xz6GR5yMtus8Lbp9UFjz6wZA8l
rQwvVXc5QUkl10uuj7SADPLgNCzooAqkZL+c8zGNgFB+CNn1+ZcsRAhfXoCTAipo
KRXI5CDGsxCtcOUch9b+GjRzkeuJv+9/EDUTeoq70nk/yjxkHOqpXIP1Sy0Az5tL
CG3qfHSBlNTAe94lulgEfq3bi9/pDHVmRTew+BEC6LHUXkBLO6G5Wvv5SIEi813k
1PHH/0okYrE+nn1Z/V/MIpjlZ2L6znAn688U/9Z9acKiEsIjgPgA6TasHxGg6hPE
pooGeODCX2i+kqo8rSFvcDknAJ/R3Ci/fpEGq0aR79Q7No3ASOUa68mvi76+ccb7
d/vN8IgDBMoU3nKuoFKk7aTtxqIXAOyevdDvAL1l0/6uRrZ2IUdItKgPuD7JdFLh
rfdm2agL/UtF+9GtdfgizxdogUwaQfP+ziKcSZwmqiW2FtVV5/oI56/Sbj7XQxrW
QYQZK7YIDVhmyBbDte34xXX9OPT4yzndppRYX0M+Oy1blR6euXcQSNeKS4ijmen8
n6zve51O/uwzt+MHDkWkDomdC1P4TQBULVain7uIZnq4/N2fzTIrs95DuUFYJAOe
AvUzQvsBBOFjslqzsblUVHD8w2+8FvE41iCJwiypRAyca5/e2IOYFQFarw7rEzl3
hgob04T8FOxwYIem1t3ik9KBTiiTFhuMOSEvdugftYYznr0GaVB35ewyh0yTFYiM
UWWqqZr6h3e2xUKRJ1lvgEazMs5zgtu9q8HVT1mUfoUo6v70eKjwL9X/NX1y3xR6
S5YOjP/eLthuNGmj9Rhnqco12O03ynqiwQdV4GbUGFIP4I1M4bkKkEmSrBR5CZsQ
5Z07iTVszyNsnFEDxuNFcA99v9YLbdAPQ874oYHKJ4zHMGbwAwfoo7Ty6SIJ5UZb
DDKSpl1whWMgvIpL2hLFooCmKTOn736Etc1UDT0O9Q5iQSyf7FqugECbj26zhQ/y
L3WIlrJvWsJnNDVcmTKlHLmh1+xFdARF7nuJNhMMElHl6R27va4ULuKYYLIsyj+C
CSv47LgoJ3GNCGlHam2cBNzJmWLeAs2W4qMFyuORQjTWVI/onAD9wgaBilltxgjv
I8zCLIU6L7hBxw9YlDh7MHV0muf7mrmrvRf3A/hRBKM5Hp2EMMFpvxLyFj6bmXB9
pnWFbq0OGWatoiQh/i0nTgX+UeqlqD2iqLYAxQleTkNnvJnzrXLc19VBVkY8MkAw
I2eSPNsvcAX0yQctcft/samSAk3H9KHpofv6t8pdh/ECQvkd0M/Y2tO65/Vc+i6l
L7yeUtS7cxVbCl+4XAtOKE6ztkdF9aNAPi8KmhE2lj/3FjRQwxHfhyiLWpI9xXmX
j/lmo5SrpP6MYfS04V0muDAggp/3tyd5cfBsCh6H3U9p5jKHmTK2aTOj7YcAQU6O
iRMVNmI/0GjcBtZl8awGwC1gpT6tic+gRNt1j+/vF3SFO6HRDgoWIkPh5Xp/M4ZH
odHgGnBNRvCHBAMiNatg4rtODzgoNhMVErFXDrPpRmoLQzwwhG6cUqhAQbgRY4nA
oSRfFq0aT0d8B+eZmqlkEPGe5ytyKPMGHq1WTLrdpp8AufAqcbJ9zkotLXyA7Qz5
Xwtzhnn3CIhSg9TcZvN1jy90Y0b21bhiU3LFMl9wNoiZk38feRM2bDQ6UZBPkqtR
IYqPg9Fm7KazbQuF8pZoLIrEjCQZ9T6L9rVGYX4ZnhzFkN2PdB7NYB8DasjwQrjJ
gdARWMLSaBPtJNzXPbxB5pw+1pxkT/nVLMX3pIwdRQlbHbxm3rI/4JyIQgtyT7qs
t+1PWXm25uO7FDm8XbjM5gw+PoV1Ii8MaDAuGYocmL4fKsQiDbvHkvznW2mU5P8t
SIFN/aIzaDLuuKMekQ+dgQ89wcmuwKCDqhTBp1BqgZin9tyN7jHqUDrt281lILTA
yMO/+0bd8BX3KU41sfLP9x+lDSDeBpwaNp2nF8pVYeGVcmHpIMMHvFjXriVPR5uv
+B6wPKp39MsLRh39WG+d4yezx1KbWL/CCF4oLVsdJBdOMJV3bJhLpczprwWzS0pI
SM3EwR8zqgctjw3iWNgq2tSbnHmqaoIMVpdFcOCxiMhAaX/xQEvufpYHMYo/3V8h
24Psqr0BWhquIlU4PFRKoal8OUor0uaWH4NpXD/z/VbRR/B0KeOZbJBpiqzCKlRX
WRJdPp4b//EvFW80FtCJXn4zT7p4VdiYbMl346EKOjiLLbccfoPovMQ1XFhzckg6
XGZwOtENCt9khxTlHPAj+W4bxKKSwTe1w9PTBUgNxm5V0auC0OqJ/YnvUTkTMG9V
/SkzRoxW6JzRVG07QoBz2xFqM28oFMy83HN3Ck5ik+6JsqeqON9lUJqdjIfBhLxD
lAStPr4qD4uKIy2yjWUUKM70hOsG7iv0zr70TZx+7Q6rpAHfl7LoER34H5kL2S2k
DZpG1paFM7UmS7MSp15Cy1ygXT451b0FyqxEntb9RM9aBA3TnA4xeKfITckE7GzI
x4fMRBaZ75JyuLR1nHpinLS2GKy7ZZAKcAWTlvPUJkXWldklNlfldIPABnUo4QqB
FocGOUjLvi4ZUX2uUZYwWBJjRHpzU0eBpfiqvb1DkT/JhSedpC5Ge48zqssExYz3
B/kZTnJPXOZZemecazHVkku7z0UV5ZeQPMhhOxnIz09eGyTtIvDSMaAwQ5ini0cv
NK+J71YM3X+18XV/i0L/gaeRkAYwM6V67sH0Q3ohAWyFUZFEPh2lwp1joHpUxqNv
XfH9zBbFz//W5SDjoq28JQ6wgW4e6Y0xNePDYaX57XQSQio+GXV+eMoNJBeL2Fn4
msAVDrZt21DmKY9zLmEGQlR9acNE5mu9Df05H2ZuhnKrYX8l0yNbH8Dwkbf27Hz5
8PuH4SYJ/E9+5CIt4jzm4sjBqr2EOxE6ro4OymqJdIGEsCzor+ZFTfRnwvMT2gG6
saSDGLMy9lRDMEzLtM8mlanqOkUuJB2lUbFuc7zt6wbjrZQsp/poLVhIOs11zIGv
U7jKlZ2AuOOiSVmv8mSJoMs1O5GlKo6keBqe90qBpvxv3xS72MPfjyFyxPmiJ2Tr
m662wcVlDDPUiU3FB8u78nuvUNo2hq3VvPWydFhZDg6TFjax9LPToDRqKwAqjKVb
kDkI26Rfns6Z10pDnv1R2mKv0NHqHgWxnNMbsxk2A0H1weI9OmSSgtOQpflXPS0B
xr0crOngxnFxv7/fXH7M1N2OXn5OqbIhN53k53O1zX+U4vJMyEXPKkCUxaXO44+v
QEaBUSdJxd6M2Wq8+E0y1xMvbB1FOqnbIdB8mE72Pq5kmXwMv+A4ldTrLwds7kZe
0RsTWf+dlkK1km+OcZoJnZsFoHuiC8w97FFwmbA1lB58nTS0ok/2SpXYExZjACMB
vANmPq8KXDoYIt2obXtTo5roAGZIJRUeJWUEvBLxiDVdEXn/5BjbowhuMrS6aof8
+1AJFyf7iao+J2/2IprpKnGQ6SDajHzt3+m5iXRoT2g+OwUC51NenAnsFRuzCaTv
i5/tdRCzMQ0vwWuAxn76O+gVWRQ7MBUc/zIPPbT0tnv8JXO09VKue4fgsPTOSOmK
QqHdAi/zfY8wwKMrwqjnE4NpRo6Sv4lD7Y8wzcRzRBRu7zuMY357vmA9KTslZpFP
tG33U7zmuxhtHypW+d1So5TgOOoW//khEBexrRRSuHkYjmxOz8RjXNJcoOLmDjTb
U8BzVk/lfKVeqGCvUQBr0mRBNlNq9QLj6Y3HcLjnfpKvByMKFTDRTNgTiFR8OmCY
5aeCUZGvDmChI1ndjCpGST4w+JzPapL2S+3zMjncG3fPx9eIqCOJ8dWhGlq06qGK
vMWkf72rV87Mwoh70i2rDumb6SR+X3bKLlDpZQUz6ItUSuTAK3p+/ptNEiLqzVXd
I0tmsukijxLMP2Sc9Lr4D1WpNEZLoj5gqVBmhQWYagfkSjrNCDCkZBSSvCnObtQi
xGrryDnIc2emGgE8HyGjU6NOsObH+mLIX/Jf7TNl8L9MJQo+WAGA4kyypwxcOg/A
oX6DWFSggSY23yIAfYls+nO2B9hV83hza1tjNzcbqKMlZW2nVmbx6DWb1eTFvSHz
hqY0i/MRxsIk1L1E4OzgSC8j6vFCpJNrA5uA9JB/E9mK77mH2lYwl5liV59ewSC0
RDNaDlvZzCB1OIjQ75qcc9NIAatjH7Mp1+pVZKGcC8rk1kfxoBAge+XWhXl/KKMj
ay9S8K9FHeepC78ccLcg+0CwUwZaLPZAT1QNyuRHZUChW1hdIfrsEKV1/M1abXkr
Ng/QtSeaJAXgMG8lVKGRQxKLYl8Vn8ZsRU3Evr2/T1GRdu4P4WxW3ox1isIs3ll8
l5CLXIw6zU7AJ31oJCuViiDIxPLrQFYowIgVQGc5/py3ovs5nGycNxCk3dHagWZo
XoHtBxUsEQ4vUSR66cWDECh6xsRwMcu8TVVcl8La38RkhmbNkMqdOoPrm0Bk3KBG
2RpLsexSskoyYAgvfUrvQIE9oLxVJJK7kfHXTmn2U5O6nnA71+VSoVbQxrDeD/lt
ewGsHxt0ScT3rPrdfqsQdUDtRXrlh0AcqPHBe7Kl+p0fZJ5jFSU+SlFJdVGAK2tZ
PoLST451YdsYH1c+/p5J5d1gggu4tN3qTEl7AonCdI5M/YBoTTKBObNsQmyK0qIW
b6tgMNiODx2lWlAhwbA1getpBagp6Ruo6f/OenossPnSDQm8aIoZdiw2/aYz7qLv
awHINxCAkfrO8f06NpXUJMiKgkyQ3G8cIB9AF9pavr3VOsHMGDzUHY9Rw2jP0z20
VR8aYyogpnn/Zfif0hPuGzSQrcDduurBrjlH1QDNppjJjIBeoC5uJ49yQvuV3+f8
j1sQSGqLEJ3w5FxjLF4uORsQ4FqoKlnfiBJwj80ryjWdkE0eLy6eVpw8m06hLemZ
tN4mz6RBfLnVU0PvWqp0HVM2x5mccQxVbJQFj4yd0806hV+vqjaxUixr839PdNBR
jZfuGxjx/iqr0xfVGC27jdSV93JgoR4XO49aXxIQdIfMRvq4z5Ywl21dVRaLVzDg
dl4KBHUI2d8RLQ8mAgCfLzmt9ugKzFvkjwp5xXgL+n7rAQIYxw2mgaGgtCK+8JfB
UQSAXRR/LQx9wY9J1KAenq01T2JZNnv8FMsogPuiTaHTPlxkPlKVrvjrcWH5FUae
jkBy4Cmme7phukI6uxt5tU0+oaMWIta9lzrmj1r+XppEWIOBgLQs4dmQeUrpcVVd
t9Gb477HeYLGVleqM25C8ZgKyMWTOzGqMyRu6PBflP4i5NzyFIUVdLjZq5hotQn+
HuoDOOGnNpjhMvgTU5o2oAuQkFhj03UBsCotOBlYb+/SwqlAgDYY768EahybxGzG
y1C2yj+ubHHVASXmF8YWMS5qINQayIR9w/vlq+tue1qRH0Dxwtvf3qxej8fRMAxl
AUGpkyO7r7UG+0y5rM3o9bs8KnrRBIieJPkh0hsJ9LQERew3CGAi0V34/1KiW4VB
y0s5HQAqqGGSs1ymVioTaiUdukSGec0UtNV/ziexuOOHjYlZfKHPeDcyLbjEdNnd
n0j3ij9YWkUiWFaoHuvK4w/NvgqfcyRHN6Euwjz94UdXSvqSB1gQda3B2J2YeVbm
YmH1Vu9mGvtC3XbWqh2gaIOjCzp1HW5AAqrq3+JZPlqOXF+d5sHY6qujU+MMUe/0
LHppyP4rtwb2YF+MfwuSTJ2V/tPeCwJlKQhT+jWogjqzz0OQxBoDOTCbwUfJhYLl
HtXy7eHABAyxwZtZZrhkDisZflMTpkPXMhVlK201Y945zUUacw4uAYsN38WKzQ60
QbKdUDfRkkxz+QuMyVncwJNSkdFe2n6vjki8NeZgttEp6YRDzMf/st9OBt3z3m5q
omfl90tvcHA892YQ1x9fjBLZ3zPWz/Gj1BG9L86uRgW2mA6XbemESrEYSfsWCyGu
0rKNWH8Io4HBkUycq3dAXkpMedAOFXeLO71TOz2pvcGpBTNv5AQQHWxfmmgtXM1o
Q0y+lH5WrZ8Bgm/ytDQEIeL0ckECuMo2WMCOED3JxvrlV2r91jNTGMW+fxtAVoZ3
GvtPtloM+d5N0U/jr1j8GZcpfcmtHRLtcC9j6ydWEKLMjOBml2+BJtaK7cQSUVxA
ILtN8GDEBuYcTqsweN6w0H6G+I2ccOoIdyL+mxopdQ/fJCVb6+4eL1FhunvczqEs
y8dB13b60MqBG2/emqCFLxPsQPluv9jEeqqjIzFw14bKWgthEoMWv6AhFdgZPADQ
D/QGbYr7BZCVqpNLZimr2rXo/gYZU+FHQ1vY2cjNE+0LVvR9vwHAQl7EqXG77cGi
2l+jBqXBEsdlKTZloXr/qipVZDexS2TMi2uMEgmjtTwjcDkzC1zUZMWdvdsqZXaC
rVNTLGqU3GHTvZX8uSywlbBz8PG6Kqoiy2XEphkgBI8wEcn6AKDCeY3f8uX3R2hB
JmrScM0Fv8hk8hrMyMdgdCrc9hvk6biMHJDpw4Y4cGnoKaWE3GWAB1QhSaunoU3P
9ZCYMiKJ9PLXyS8dpiaScIrcrdr7K5jMUoYF3LFLlIiPqpWmmRsbyGL9LQ5+BFdg
0HZD4Fhz6ET29SsYkDEbUTTbdquk7YJLH9688PC+/E1+LVS9LoyNp/XViOArLCM3
U27QyNI3EADUPhJ3YG5VlcZ6fYX3xjKR58XfTwFLpLZXugV9qIOgXxlvEQBRYpzR
Cf/e/LJmnIJMJQH+FQSgJOvVoHpzAxmPW3Nzhim4/jU6plKovkZfVfykGypkltRL
F977EPHD+12XYEZMnvse+UX9l1W+tUHAtHg+CCDb1q+X9w7x/33iZS6ahcUQvsu7
4mzulIbYiKo27yxIehe0KLq8ZdG22WP4TMWSHMai5upAnEzzHHuNqCfqAVVIUclH
5EXD8pGezdJGdigL3bfssHdsGPGc8SW/xE+b4Xw36oQmA5xH5uMRtVBnv3VZTsmc
y0cWAzB32q0J2IX3KcHn2QCRhDtkAqUG344r9WJMWr0t8uFD485jwSHvUDYeJ1Aq
ckDkZjwHDkUFpled8iSnYAzhWIGorncwOS9nsCa2za3iaIDb7Pj8szICGk91GhjD
wkiOlBFeFsIWUBrlTJNTwoSEj32rPP/7Ur8/FiP0zF2xSsUnWLU2w6Js0dqr4z+e
Ev8hQeqym0jx5I77fWVzKo57KQu+a0J0IG8bI40grSfd4h7x14s+MbqQFtSsW6Z1
Uaxs7YNIB9wL7KlanBDtv1cR7TO1+v49mX4tkIlKodAOknPYjX9752/lFpgqcqfV
R3c5yqfbQLAkE2pBn4/GbBxkDgp7NJ0/6OAAags5sHaEX1P8nDbSIrmSCW4Agp0z
5QwyTJfbVW4zTU9TfLG1Wzesz8Z3EtJWRzkVyPIxFCUNjtjgq14kDZdSwikzVXy3
UAKxSosAQrx9P+ITWtB4ixzOcDXXgF6lhMC65S4wKBcS0MoZ4MtwpmcAIvIttVuw
XEW7HULpfF6BmaQOPEKV29/fCWTA4ciLlBqtQ6t6j7IWFAsN5nK/D7ntuyz1X5gL
drPG24d62cQQRFoEO621eKOQBZH8N51uaj0zy0Wm7K8xFrZsYih6eHo2ceUobq9j
e9iPYugNkUAbV6tp5dUMQMDDCgjJx1pHImgd+PB3FkiVH7iiaRiedxe8iNetXH+Z
IsMQ8oT0ZH/pJOSD+neZVMJhxjSpvsh7ZgLmnaw4QTMTFlhKB2l5COIjPThrrQKU
8hP38utnv3jt7JGlDo9t4h6avS61tGJPbNmhS8wiXE7X+CPHsm+LCcwSIE36HtRx
tgon+4QZ1q1i0nYNF8DGZgb1hDPy5JZ/2l/O6UApqGzrodUjvnHKl8pD7T7L48RG
6BtT8UPgLbzl71mnGV7+L2p4RT2jb2spCQbomZfz9nfmkE/zXVwQQCtONxffHvXG
CdgYJpvQs+qaorbhNvP1lGWqFDIybBZqrlSkioeF2pb3LX0B9o/BWc3ovv25D9XQ
k8II4WWG0+5QIUYXNJCWEHyxct1keLyZiM4OZT3nAmC0+u3yW+s0/aoHBzx0SBMA
SmuUmwO7Nu2TY8MDnuH9GTBeyLDSWOvPwG9qCH9lhpbov2heyQvQVw35oG2ZbT4v
SmpRmWhMaDRRDOTQ84Fs7PGKvpkX3HFfvF2KmM2fZOEUt9h/edsceMKdinrVYP3/
L25TG6z6IaevMmlAYvJF28n8SeNdGm9LZrvyowWZQ8P9hsiHlIBbGZiOud9+e1n5
5LOzOXaVG8kXumOkRQkXmilbGhUNAsv0LC0S8eT1YgGKGELtO7BQYXEpuvE6xk7u
o6KdLgNfB90mxwRA/+YQJ5g7QwvvjPIdM4J12QN6riQGQrZIT6Q3hjLYxyvHpiJN
gO0Blx/XpJsM4j73zteetmOfrt8syebyevek/spFDEgMCg2j/aiksXTbXyHPCcQD
84MfYjKzCQ9ncYOyinEl/Al4jGjdJfDN4BhJBfpuoEod5VbNBMwkoAMSBzI4UsEE
DcYead3VmUJ/zh5HEu4U7o7tR+Q6P6HBV9Lt7G3Y3amvfLpdCJlxpmipVw8RvYGn
kSDVk4UbJfktJdeCCU+Igf12chb7o9a+DN/UX7cRFa5Xj1LSLCm1wVy8p2otcnWR
xkTjDwE68kyYzNbxSqRcgf6l5AtcPMzaSzKWI9EMSPklVqPf1p97KcjvXfAyKVHT
hBIM8hPNuwYROS82X11rWYUDv+mOaCLfbJZLkqx+DNS5cfpVRWfovavG8FTYrzpJ
hhFf2GSbGVxqzwkecD272KXm9Nul3K4sfr1B6mWu44GKnCSuq0G95ihoy/+sQaIE
VgFlvAs6svhwjMv1vSBJye7oPoI8qVvZJseVPUb+8T8KT7UXqfRj4cbsmU7LfYo7
n9yotoA3BLGeu7bdbxenDnmFPLfANqkit+Ex1nqSLIrwrDHs8dXQKhG9vERtTbMR
dmQD1xVQIyD97fhKnIxNRhAeiMdZ3I7aYjScuaEqd/6ShqxdJ2G60KfVMmykA7oW
UQ7zxdP1MPTTrzh4Olr+Ea+jGF7W4qqPYPGnTzuviP5wGIaWCg9ORLhqN99ZsHcS
BImHZHvubHdhElwKPZHEVjbrwPJc4fWorJkqTrhozQgH9D3qHOC9N18oTBwb9g0u
3VZvO1LJKE6ms/uPlsyGQfTXP9sqLpXAnz7ZGP0eaCzkmcIHpahbfOAjGfgKyNAL
7kuj0OhsbKm3v0U9ViD7qlIp+RLNjlIwu2aYpQjK7fQ1LiFt4/m0Q3xP+AKHRjok
HcIo/0w/MqI+9RUstP2CsNQj70n6cOvq4c46UnfHDFPRcpXgD449YNsZStRsHfBu
1zisfpk3MDZtej49dqETOL8brXdNk4bNTuqFdc7NwZ8GRh8u5ScFeb+GgZJS5z0H
lCW+wleudGz/abIauDPEC+fQqjuufpKw/PaxneA/sv1Dz7YcGglfps4fxieWHNqU
153fMOC2rAAjOYl9DYQDS/Ip3PHGIZ2xd3fwheCdzvLMzdgnCE45vPl7rGuc5LIf
bm8iiNfal0gfQ2jSrqPMdApOKZ1qeOmfhOvctixU/+iinD0R3JOPepjpVQ+qs3da
o9+S7JecR6YJz0jwuKl0oIgCDw+QO8+NQLZAwaxyi338rWSl3NRNw1vMtqmD3psR
wA7gO575nJIH0kcgzSkaCjoNTQfru3cGuptliqi0y877+BPBE1R/uURmyIJKO2Ic
ngjEMPc96jdRQejrETCkUyRURimpAJHpFvsZPs+eWr6VDF6PHjSa7bIZAjZcLt3/
1YGOSWcHeMSK/5ncJLSSk1ROJOyhgK2twn3M1jz/KLXC59l5HY5iiQA8vRwzn2uF
Ava1UCG3xqHpH9V58bQIRPkz+b5bfNqw4MZCWwcJwBQ29FKWMag7KnadaUGUR4F1
YXuGizr1RQ8BUrQchlqiYHMMRoMzPewmPCs78BckFjuW3P3gyFhsOyixHNpe7Ak9
ouCjcg6FXPHpuL8aIa5mVdLYBGeHFIsse5COCpQwUU0U1RahKCz/726DPmJRFK3I
W5ijLnPvfE9q92lqtzl/stX8CwBU1ZiEPDv+iY8nkGc4lkXd6SqPn33HvC1orUJN
bNOnb8GaTp9S5pdnIrZFEofWz3/qmfoGLcI/PK4zwofufMKteI32+jHjWBPTQeaj
Ay5a9q7/WR3wQwoL9PxeKL8GpRqp+oNdJrxHgldmo95uufszgZ1dE/v2897rD3SS
kA8Xly4dRWisavQMJ/TvW9OHHsaftDY+otVM/gZVjmvTdOHxaMf2z1pkIHnSeX9j
79UQlzEXH5QeP7blDn9hNWTiecajRU7O2r/WSG6MVaFlIeQbsfMtvsxGm9zMYW+O
b4bQJm/yuxe/+y0jriAgrGMDZkBt2ZH0RIv8Gs+Y1I0IjOkSadHzQRwQC6AF+P+S
43P+SQKCP2rY27YyQO3DXfgZ2JQJig9BwiDJsnqIb3RUvugUiQNRJMFxGpKkEX0M
FqrarOjcOqZ3Dk5wTvSPY/W1FMOsq+dJU1mxiZdzffH5tBPHuf5fw6gQ0KroQ55O
JavzEuBhpBvmefUp2cg95FiQzQeg1mkppwtbPkxIVHbb+Hwn7C6BFkti2wDP2uai
x1cySEpS9YYMJqkKvJ7fOCzJUdTiIT5zJqo8Q3NH2AzQEneS5WmJsHClD5r98EMS
COzUeOHnnnOFnsepoeB0Wa8+tUw49Azod6+rZHy/nG0mNlJhVnhKaODG9D6brBv3
WvjevaBrBNJtsG16SGD4mGnw0DFgnMQRQFuEe72xHAIi1QlSREfAg2NCxrfzwnk/
MPSRVvh0iHPvtb4fUaWggS7lhSE+RFYpuQVmOOvqNge5JOPpNmNKtXpLkaVX9MVa
uhxOIge9VT+sts+90BRttsPh/CW7Cy1qO5MR0lS919gITf1VwfXYMZvkSjBb1UOs
b5cIjSyyr97/kKNgatz196TI5U85bk6SwpUdWYixRbogNTN6Mv/Krr6iNHWVSoFt
69vRdiwUfQiWOOn1RSDhhQD8dmL9l5AVGzFfeIvu4ILHWGVoRo1UuU8XUzBMfyTu
hMVjt3WZlZvI1kNiMGQKbLXLp7iG4pGhNoCGyXngUY6zX+8kMznmUzfSxa++PAOd
pv2mtPUHHtu+9RcfM9QULXmKBuDPfnyubFw+AaTo56UDsOYYKamQKBlYbmuhNXTk
MVy+salK4e42UMBoD9M6jOR4KB9mbKcJRsCccKvoSSFpr3tAWiSnfgqNkgT9ntWv
bu7OGMJVRuqfn2SFiCXP6oeks25/hWU/6rtLG1GE6ZOeOmRvgOWDNf2TZ0tS1Ap1
1Nf1XWoBaroUC22ww21YBUNTDHUrs4ktSeUNnNAM7CCHGTystIqvoGcPWl8cB1bC
xMra0N4d1GkxXtQ/rzVq1FN0mPzBkgvKYDDU4w/19wbQ7OGcc+yvRbSwN8fU5Aq0
A4i2hW23M+vDRnM+pvW/eo+hF+gVNBAanA7MCsVyewBGW93lkUrgVkW4WLCkBpJZ
N9J8ekpTVol/SRuKaKzwFkoRNYI+FzvH0NHe37gQYdc5MD2Wg1pK2H5QvEnysoQ7
NY4XzEYo/C83hsVSunntr6dqfcYsn28K/2oF9Eajnnf1nkkeLZsXm4ADizLyNqXj
3iEyY60ZUT1xsffBV1vnxAwkGEvygTqAcJPva4tWpmIDX+cBu6UJtU1+AZ87+hK0
nc7RVoENr0hjlvEPoHI4i1vugYzOgdgSK6XaGwuvchvj6F5w9Lo7VSbEDsiFQMd3
RH4LwmsAuHGP3gWiKJTz/50iUom/yD+fNF5UpSEcn7oW+tvG0scosUK1FFkeezTt
QtEWtdxNVjaktOzROmOF/0Jdn8yYfcfwjzYtU6D4luaBtOFPlZue68DPxyOK4Pio
sAJ6g3ew0spXn3g4++xTr+Ms434OyqErbWTkOYKSJLjUiGostld9IhilCQfjOS+q
GzFcTol6vRMVf8lK2UyRcAV/YeCqKa5tMiBY0eV+hS7Ma/WbnnORtaiDxLV6f0fa
f5trD9PzDcX5ftZpxb/2COEKYlEPNcWkW0ZS0sXMx+Vbfs0XEE/DfWeuD1AVNS1E
1Hsn2ByIpaqpAnTechJbG7CgDQdRMNmZhz/cQ5eY/lbNJ8Fy3nrrCU29xxzHVSnt
9XttwcmMIRqdWpNdqHPHHR+a197GzysB30Im160tdufhOdtZwrG/mG5qTGx3LhAo
yVL6m8U4Geq1dpHd5LZDd9r9aNZsrv0+HciiLQTXLAYj9jYYEarb1M2wEAsJaGC/
zts1gytT+pjDIULpx49RI50PMhniCWkgdDgt7JKnYF7EYIWt7Oah2uQj1N25uMmM
Z8IJB5T9Oe6XCVeC90EjSRrFWjeYwIOeqpn5hYJOm2usQPFjavFjn0mr7IWupLN0
7MUdTSaW8Jj6fPairHG4skZSFwYW3THC7Tb/zhqIaStF+euzL8NmG8Q3SYxyHt3N
G0tkpVdRP509PEmnhyv7For52zTwNhVxK/v4fBc212Pv2APro/DyibAYjyrgHDPO
QRxo/E5D0yKwcQ4SfZBZYctDWFZnqfb9bUANcMKFPuKBISVEac2pSFtGFWqQVZkH
Uxy8rGTmFbFN7r8mlIyts7T8n8AZNTVnw1BVj+FW6E5W12Kd2eRFBFOTsaPki21V
skKMhGArc1+4Xu+79wSoVzepHTIWDp0LAQ8HKI3TlpT9EHXU6P0Whn8iJHsFzwue
TfuhHuUn29LRVepJP258BXtkvbIbh/2UwrwLzvWEcosOOet2c+9vIyfczAUWf33C
FCBV0bc8FYjhoIKY7DXYnzAbs4WYMbueAxRlKB7B4oHfUnDGJM7+ESR9ThLQhaw2
5yeC95utbQNrJ8hQgprXgUI2EE8VnA3SZHDPUOYEkQxnFTX3TAs8epsG/CuWz89W
onOWTKnC+DyC5Wb9wsaOi7zpUUR4KkCG/P/EEfCWGFSlXfxhY3Voyu8V1+wgfHVf
ud6eceC+va7+1SxiXsuQsjhQlZddWAo6tFPWsWiYKKRwsOt/S2RNW5q3ocp27986
FKi5jpwUPEYMjrM8fcP1NJi08MYxKK+T81kTqSgDy/ZSjQt8QkBNDF6e2rP5was3
pCSahGkTK0SFg+YT+lJNbWRGO+6iVOYI+HdFz8ApVm789Xg+t9zRJamGOQMQ9tU1
jU5C83tiUy88stiTo++BVhl2fRTpmLFfdMvLzgDSRysAT8wcxt11X+U2mhKh5JjP
4f2uUWXr7qtjmf77Uzf6M5+MgpL9ELfLAAYwlHMuPcL0PlNAStq4tJ5vZh7Jsk4R
EzeAaM2BclnihSH0pDcO4KJu0Kl3/cgfe0mPdeQ8sl2fVFq1kq9QZDMC8A4j8ts2
jsTWaIDPzWulH6nagdb4GXEscP0PKd8zwAoJv0E6IlFGWOYCD2ZUoWyW+zngw8Se
SmLG3sjWnfQfB4c0/7vjkFuuSfzFkl/Ab3AdYwHk1Tcc47YAjesfZP1kKEZRTvFr
VQ+hUbhYC7u4ptn8eoD1MTHkqnn+oBNV0FJjjWRxqYb7AeSx0wwOU6LSVsxZA+jd
P9C3VaNTPqW3EoUqgq0jwfcwAS+a8Xej01qMj3PBn97C1CJ4OOXPAEj8N+ccNOKc
SfEaSt7mKWtEliWw4BH6Y0L7TVZXwISujO9ctIFya7QimDl9V+Pxaz0VSV2zs0t5
uh7S4Lr9jsq+6Wm0elCrZQStUH4Drn4c0VWahgGOA8HekLdtZuT0/tec6mAoQ4B7
iE+yUflcf/Aj7Nh16VYy+tvJ9jBBbPd4wHVZTALuGlTKgvSIi8PzTmlXV07APPLa
92Pp2r13wJfa75nA4cvFpWJUxqqOmUWXeJihLX8zP6G37fgDfSdkQ+N2lJGxpRYb
QM1RuLEJP4JMg1/LC7RTTq7hqy2TIbANyKJiA4DcejFIHHL7UGlEJ9pCbIqXOixi
fvgpfaArjOPmRIx1ZFIlqnrdBpzDm3Uebg6riif4Fd9yrMF4LFV/8/3iux0GrRln
ER0/J1bMea6J0VLNhXVwJdyoOTKgyUN9HLfDtnaaZT7fh3Jk9fNObjAOHtN3COFq
EU5EQBK+kBuLXo6J7yBzzMepB28hnoVVqbfHTkNAz7mJttpF0QEpkmC5wOB5ivI9
jf1fnBi5G0ZujdoniEBXtLH5tdaBLxgwUgIcPN08x/BRyg4U7o8HXc0qWTlZdW+L
HgLc7xoBRF7LiuVjEsnwU8MMNIyk3yvLkuk8mxdOk7/Q2keMvYLoPlLBA0zlDQNz
1Jbyd56wl+H56d5xH3aVnNoYo5DLSvbqr/MNu7zKdegFP35HycgMjMVdhAazYjfs
kD4NDzRtDdZtNWY0d21UzN4Z2coTOdyFhOqbxZSQgaEzm+boLli/0o0MqSVhiEdd
gd15+hmoBirPNxLCy1bMzAo7lUS423tEgrGEQSHPXSmDRfacHhNBhYqat1RT42Ho
Qx6aHt77dK5zesU950lUMN1DyaAjfa931QDxSsxjROUlFbbtsL7EoZ86ugM1+xdp
T8FkVD1PT/v95gvqotPUzJP75KWHg5XjyPagXXBPaJpGojD9iHI0WlrRAk/JIIpN
9F/PbU2N/3XAGgo7ADpMM30iLedtZ1bqMfd9NkcE3xsvT/DhXcaJhiM8wty1YS9M
apS3dnyUu3rPEjJYmzXpZmzW/+fBT4KP44J0smgwrPEGK8CdlUkIvovS+pghj3Xx
Xy1FuvsavPZ80F0d/+yCXzYP7UmbLchQESERpBVJH08xXHkj0lSmBD9kZfyDsXoC

//pragma protect end_data_block
//pragma protect digest_block
FscZ2fJ9/5DDXOc1/w41orv90/I=
//pragma protect end_digest_block
//pragma protect end_protected
`endif
`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_EXCEPTION_SV

