`ifndef GUARD_SVT_AXI_TRANSACTION_EXCEPTION_SV
`define GUARD_SVT_AXI_TRANSACTION_EXCEPTION_SV

typedef class svt_axi_transaction;

// =============================================================================
/**
 * This class is the foundation <i>exception</i> descriptor for the AXI 
 * transaction class.  The exceptions are errors that may be introduced into
 * transaction, for the purpose of testing how the DUT responds.<p>
 */
class svt_axi_transaction_exception extends svt_exception;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lcRFgc6MAJGKSqx4lxPxU3ehQapseKCL5ioheUwTYPTfRAto0p2wtEBLzBTdIVJl
0OkS4R3FVSztk939DCwNo3FvDry5bUHRl9Ga2ME3m5RrO7+YIR4+7X35z8V9o5nh
68/Zn1zlfDIRnuDTNrVrjB0jmuQ0Pq/rBrEItrc7Jx4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 663       )
mgvLLO0ZtzUHNR1XgyGg2hHIPlyeDqYrHJfyokpqBdJVGQGsSGrLghGnz9K/lrq2
N94iAyyyaG0S/NqQmpvSnozeO/yL4GsNzJIFa3a+29hjdkTfEr3u+q0QUQS1V2cV
ZOcyrECa1pkCroVaEu/gv7rELvpnbOsJIFwFIHuj3a8qQUAek2gbEmybfnnDUwFN
mTg1I89g+aOdVx16WhPR3OImIxKn2QpQ6Wl/i2K8SvYqLZY+ugtAo6qjH9+EitEJ
IrDF7q/hshm6ry8ev97MKxbWh2tvZA+EZOQo6driqfJ3Db3W+TftWZnM1wxBded9
49IYcvQM8VuM5RJ7U+q1qOzAgUmep9PukguXkVhtmnL7mmKA+rpVZY7ShEv4ZuiG
UAS1ZMy7ztpPtTNL6AFdyfKGMt5DmYlurhkZpvnfJ6v0uR/QOUx0MSEokl+iLlh0
345RR0dDXqyg+3QFi9+q5FbIRT1TRvCr3DB5ANi66kqjnky4V3XL1lHhO2GKYavb
2C13lZHd/ab5Yrf81ZuYjETr68+BvKeq947VI6G/VOKk41kc3pOIgCgQ3an+Xub6
lZU0OUkIX+vJQlAt3D17OTn6LxjxLzvbITygduyyV/JvI5zxM8p2irHOkfAemyRL
iPNkrpp20AQlcimxJ/jkmn9v2bo9GQPj8d88daasHe97b6NqNN73jmAY4Fxkj3sf
53GjwTPZXK3dZGbA7eZTKUzaJZrdPevDElmN2rl6JdxL9fPlKKRLvn+5zB8wWftT
SH8oN62X4eQ/G2pG/JoUhQ9Mf4uKbtm7avYDiFaDGskzonsxzdoAnSdH1mVal5Ql
4Z8vZf1EP8TjtgkWBVaoVGqn3pZTJaOmhYu6tOXJVrwho8PCQeDicBwbXOL3JNuI
`pragma protect end_protected
 
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * A transaction exception identifies the kind of error to be injected
   *
   * The following error types are available:
   * 
   * COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR: Generates burst 
   * transfer size in bytes less than cache_line_size for coherent xact
   * types which only support burst size transfer equal to cache line size.
   * 
   * INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR: Sets burst_type to FIXED 
   * for coherent transaction types that do not support FIXED type bursts.
   * 
   * INVALID_BAR_DOMAIN_SNOOP_ERROR: Generates an invalid combination of 
   * AxSNOOP/AxBAR/AxDOMAIN on the interface signals.
   *
   */
   
  typedef enum
  {
    COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR = `SVT_AXI_COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR,
    INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR = `SVT_AXI_INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR,
    INVALID_BAR_DOMAIN_SNOOP_ERROR = `SVT_AXI_INVALID_BAR_DOMAIN_SNOOP_ERROR,
       POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION = `SVT_AXI_POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION, /**< This error kind is currently not supported. */
    AWUNIQUE_ERROR = `SVT_AXI_AWUNIQUE_ERROR, /**< This error kind is currently not supported. */
    SNOOP_RESPONSE_TO_SAME_CACHELINE_DURING_MEMORY_UPDATE_ERROR = `SVT_AXI_SNOOP_RESPONSE_TO_SAME_CACHELINE_DURING_MEMORY_UPDATE_ERROR, /**< This error kind is currently not supported. */
    USER_DEFINED_ERROR   = `SVT_AXI_TRANSACTION_EXC_USER_DEFINED_ERROR, /**< This error kind is currently not supported. */
    NO_OP_ERROR          = `SVT_AXI_TRANSACTION_EXC_NO_OP_ERROR, /**< This error kind is currently not supported. */
     GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR = `SVT_AXI_GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR,
    GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR = `SVT_AXI_GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR,
    GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR =`SVT_AXI_GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR,
    GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR =`SVT_AXI_GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR,
    INVALID_START_STATE_CACHE_LINE_ERROR =`SVT_AXI_INVALID_START_STATE_CACHE_LINE_ERROR 
  } error_kind_enum;

 /**
   * Enum to represent four levels of shareability domain for snoop
   * transactions. Applicable when
   * svt_axi_port_configuration::axi_interface_type is set to AXI_ACE. 
   */
  typedef enum bit [1:0] {
    NONSHAREABLE      = `SVT_AXI_DOMAIN_TYPE_NONSHAREABLE,
    INNERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_INNERSHAREABLE,
    OUTERSHAREABLE    = `SVT_AXI_DOMAIN_TYPE_OUTERSHAREABLE,
    SYSTEMSHAREABLE   = `SVT_AXI_DOMAIN_TYPE_SYSTEMSHAREABLE
  } xact_shareability_domain_enum;

  /**
   * Enum to represent barrier transaction type. Enum to represent four levels
   * of shareability domain for snoop transactions. Applicable when
   * svt_axi_port_configuration::axi_interface_type is set to AXI_ACE.
   */
  typedef enum bit [1:0] {
    NORMAL_ACCESS_RESPECT_BARRIER = `SVT_AXI_NORMAL_ACCESS_RESPECT_BARRIER,
    MEMORY_BARRIER                = `SVT_AXI_MEMORY_BARRIER,
    NORMAL_ACCESS_IGNORE_BARRIER  = `SVT_AXI_NORMAL_ACCESS_IGNORE_BARRIER,
    SYNC_BARRIER                  = `SVT_AXI_SYNC_BARRIER
  } barrier_type_enum;  

  /** @cond PRIVATE */
  typedef enum bit [2:0] {
    INVALID = `SVT_AXI_CACHE_LINE_STATE_INVALID,
    UNIQUECLEAN = `SVT_AXI_CACHE_LINE_STATE_UNIQUECLEAN,
    SHAREDCLEAN = `SVT_AXI_CACHE_LINE_STATE_SHAREDCLEAN,
    UNIQUEDIRTY = `SVT_AXI_CACHE_LINE_STATE_UNIQUEDIRTY,
    SHAREDDIRTY = `SVT_AXI_CACHE_LINE_STATE_SHAREDDIRTY
  } corrupted_cache_line_state_enum;
  /** @endcond */

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   *  Represents the burst type of a transaction. The burst type holds the value
   *  for AWBURST/ARBURST. Following are the possible burst types: 
   *  - FIXED
   *  - INCR
   *  - WRAP
   *  Applicable when error_kind  =  INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR.
   *  To inject an exception, this value must be set to FIXED for transaction types 
   *  that do not support FIXED type bursts 
   *  .
   */
  rand svt_axi_transaction::burst_type_enum invalid_burst_type = svt_axi_transaction::INCR;

  /**
   *  The variable represents the actual length of the burst. For eg.
   *  invalid_burst_length = 1 means a burst of length 1.
   *
   *  Applicable when error_kind = COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR.
   *  This should be used in combination with invalid_burst_size, such that the total 
   *  number of bytes transferred is less than cache line size.
   *
   *  If #svt_axi_port_configuration::axi_interface_type is AXI3, burst length
   *  of 1 to 16 is supported.
   *  If #svt_axi_port_configuration::axi_interface_type is AXI4, burst length
   *  of 1 to 256 is supported.
   */
  rand bit [`SVT_AXI_MAX_BURST_LENGTH_WIDTH: 0] invalid_burst_length = 1;

  /**
   *  Represents the burst size of a transaction . The variable holds the value
   *  for AWSIZE/ARSIZE. 
   *
   *  Applicable when error_kind = COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR.
   *  This should be used in combination with invalid_burst_length, such that the total
   *  number of bytes transferred is less than cache line size.
   */
  rand svt_axi_transaction::burst_size_enum invalid_burst_size = svt_axi_transaction::BURST_SIZE_8BIT;


  
  /** 
   * This variable represents barrier transaction type. Applicable when
   * svt_axi_port_configuration::axi_interface_type is set to AXI_ACE or ACE_LITE.
   * 
   *  Applicable when error_kind = INVALID_BAR_DOMAIN_SNOOP_ERROR.
   *  This is expected to be used in combination with svt_axi_transaction::coherent_xact_type
   *  and invalid_domain_type to generate an invalid combination of AxSNOOP/AxBAR/AxDOMAIN
   *  on the interface signals.
   */
  rand barrier_type_enum invalid_barrier_type = NORMAL_ACCESS_RESPECT_BARRIER;

  /** 
   * This variable represents the shareability domain of coherent transactions.
   * Applicable when svt_axi_port_configuration::axi_interface_type is set to
   * AXI_ACE or ACE_LITE.
   * 
   *  Applicable when error_kind is INVALID_BAR_DOMAIN_SNOOP_ERROR.
   *  This is expected to be used in combination with svt_axi_transaction::coherent_xact_type
   *  and invalid_domain_type to generate an invalid combination of AxSNOOP/AxBAR/AxDOMAIN
   *  on the interface signals.
   */
  rand xact_shareability_domain_enum invalid_domain_type = NONSHAREABLE;

  /** Handle to configuration, available for use by constraints. */
  svt_axi_port_configuration cfg;

  /** Handle to the transaction object to which this exception applies.
   *  This is made available for use by constraints.
   */
  svt_axi_transaction xact;

  //----------------------------------------------------------------------------
  /** Weight variables used to control randomization. */
  // ---------------------------------------------------------------------------

  /** Distribution weight controlling the frequency of random <b>COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR<b> error */
  int COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR<b> error */
  int INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>INVALID_START_STATE_CACHE_LINE_ERROR<b> error */
  int INVALID_START_STATE_CACHE_LINE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>INVALID_BAR_DOMAIN_SNOOP_ERROR<b> error */
  int INVALID_BAR_DOMAIN_SNOOP_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>  GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR <b> error */
  int GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt = 1;
 
  /** Distribution weight controlling the frequency of random <b>  GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR <b> error */
  int GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>  GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR <b> error */
  int GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt = 1;

  /** Distribution weight controlling the frequency of random <b>  GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR <b> error */
  int GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR_wt = 1;

  /** @cond PRIVATE */
  /** Distribution weight controlling the frequency of random <b>POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION<b> error */
  int POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION_wt = 0;

  /** Distribution weight controlling the frequency of random <b>AWUNIQUE_ERROR<b> error */
  int AWUNIQUE_ERROR_wt = 0;

  /** Distribution weight controlling the frequency of random <b>AWUNIQUE_ERROR<b> error */
  int SNOOP_RESPONSE_TO_SAME_CACHELINE_DURING_MEMORY_UPDATE_ERROR_wt = 0;

  /** Distribution weight controlling the frequency of random <b>USER_DEFINED_ERROR</b> errors. */
  int USER_DEFINED_ERROR_wt = 0;

  /** 
   Weight controlling frequency of NO_OP_ERROR.
   
   This attribute is required to be greater than 0, but will normally be much less than the
   other _wt values.  If this value less than 1 then pre_randomize() will set NO_OP_ERROR_wt
   to 1 and issue a warning message.
   
   */
  protected int NO_OP_ERROR_wt = 1;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables. */
  // ---------------------------------------------------------------------------

  /** Selects the type of error that will be injected. */
  rand error_kind_enum error_kind = COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR;

  /** @cond PRIVATE */
  /** 
    * The cache line state to which the master must transition after
    * completion of a coherent transaction
    * Applicable if error_kind is POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION.
    */
  rand corrupted_cache_line_state_enum final_coherent_cache_line_state;
  /** @endcond */
 
  /** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;

  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_cache_line_size = 0;
  /** @endcond */

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Maintains the error distribution based on the assigned weights. */
  constraint distribution_error_kind
  {
    error_kind dist 
    {
      COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR := COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR_wt,
      INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR := INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR_wt,
      INVALID_BAR_DOMAIN_SNOOP_ERROR := INVALID_BAR_DOMAIN_SNOOP_ERROR_wt,
      GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR  := GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt,
      GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR  := GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR_wt, 
      GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR  := GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt,
      GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR  := GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR_wt,
      NO_OP_ERROR          := NO_OP_ERROR_wt,
      INVALID_START_STATE_CACHE_LINE_ERROR := INVALID_START_STATE_CACHE_LINE_ERROR_wt
    };
  }

  /** Constraint to make sure randomization proceeds in an orderly manner. */
  constraint solve_order
  {
    solve error_kind before invalid_burst_type;
    solve error_kind before invalid_burst_length;
    solve error_kind before invalid_burst_size;
    solve error_kind before invalid_barrier_type;
    solve error_kind before invalid_domain_type;
  }

  /** Constraint enforcing field consistency as valid for error injection. */
  constraint valid_ranges
  {
`ifdef SVT_MULTI_SIM_ENUM_RANDOMIZES_TO_INVALID_VALUE
    error_kind inside {
      COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR,
      INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR,
      INVALID_BAR_DOMAIN_SNOOP_ERROR,
      GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR ,
      GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR ,
      GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR,
      GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR ,
      POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION,
      AWUNIQUE_ERROR,
      SNOOP_RESPONSE_TO_SAME_CACHELINE_DURING_MEMORY_UPDATE_ERROR,    
      USER_DEFINED_ERROR,
      INVALID_START_STATE_CACHE_LINE_ERROR,
      NO_OP_ERROR
    };
`endif
  
    /** Constraints for error_kind = COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR */
    if (error_kind == COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR) {
      if ((cfg.axi_interface_type == svt_axi_port_configuration ::AXI_ACE) ||
         (cfg.axi_interface_type == svt_axi_port_configuration ::ACE_LITE)) {
         if ( xact.xact_type == svt_axi_transaction::COHERENT &&
          (xact.coherent_xact_type == svt_axi_transaction::READSHARED          ||
           xact.coherent_xact_type == svt_axi_transaction::READCLEAN           ||
           xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY  ||
           xact.coherent_xact_type == svt_axi_transaction::READUNIQUE          ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANSHARED         ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANINVALID        ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE         ||
           xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE          ||
           xact.coherent_xact_type == svt_axi_transaction::MAKEINVALID         ||
           xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE     ||
           xact.coherent_xact_type == svt_axi_transaction::EVICT               ||
           xact.coherent_xact_type == svt_axi_transaction::WRITEEVICT)) {
           invalid_burst_size <= log_base_2_data_width_in_bytes;
           invalid_burst_length inside {[1:`SVT_AXI4_MAX_BURST_LENGTH]};
           // For WRAP type burst, burst_length of 2,4,8,16 are allowed.
           (xact.burst_type == svt_axi_transaction::WRAP) -> (invalid_burst_length inside {2,4,8,16});
           // Transactions size should be less than length of cache_line_size
           // in bytes
           // ie, burst_length * data_width_in_bytes < cache_line_size (since AxSIZE == data_width).
           (invalid_burst_length << invalid_burst_size) < cfg.cache_line_size;
        }
      }
    } // if (error_kind == COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR)

    /** Constraints for error_kind = INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR */
    if (error_kind == INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR) {
      if ((cfg.axi_interface_type == svt_axi_port_configuration ::AXI_ACE) ||
         (cfg.axi_interface_type == svt_axi_port_configuration ::ACE_LITE)) {
        // Invalid Burst Type for WRITE transactions
        if ( xact.xact_type == svt_axi_transaction::COHERENT &&
          (xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP        ||
           xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE         ||
           xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE     ||
           xact.coherent_xact_type == svt_axi_transaction::WRITEBACK           ||
           xact.coherent_xact_type == svt_axi_transaction::WRITECLEAN          ||
           xact.coherent_xact_type == svt_axi_transaction::WRITEBARRIER        ||
           xact.coherent_xact_type == svt_axi_transaction::WRITEEVICT          ||
           xact.coherent_xact_type == svt_axi_transaction::EVICT)){ 
          invalid_burst_type == svt_axi_transaction::FIXED;    
        }

        // Invalid Burst Type for READ transactions
        if ( xact.xact_type == svt_axi_transaction::COHERENT &&
          (xact.coherent_xact_type == svt_axi_transaction::READNOSNOOP         ||
           xact.coherent_xact_type == svt_axi_transaction::READONCE            ||
           xact.coherent_xact_type == svt_axi_transaction::READSHARED          ||
           xact.coherent_xact_type == svt_axi_transaction::READCLEAN           ||
           xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY  ||
           xact.coherent_xact_type == svt_axi_transaction::READUNIQUE          ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE         ||
           xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE          ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANSHARED         ||
           xact.coherent_xact_type == svt_axi_transaction::CLEANINVALID        ||
           xact.coherent_xact_type == svt_axi_transaction::MAKEINVALID         ||
           xact.coherent_xact_type == svt_axi_transaction::DVMCOMPLETE         ||
           xact.coherent_xact_type == svt_axi_transaction::DVMMESSAGE          ||
           xact.coherent_xact_type == svt_axi_transaction::READBARRIER)){ 
          invalid_burst_type == svt_axi_transaction::FIXED;    
        }
      }
    } // if (error_kind == INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR)

    /** Constraints for error_kind = INVALID_BAR_DOMAIN_SNOOP_ERROR */
    if (error_kind == INVALID_BAR_DOMAIN_SNOOP_ERROR) {
      if ((cfg.axi_interface_type == svt_axi_port_configuration ::AXI_ACE) ||
         (cfg.axi_interface_type == svt_axi_port_configuration ::ACE_LITE)) {
         if (xact.xact_type == svt_axi_transaction::COHERENT) {
           /** Constraints for Non-snooping transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::READNOSNOOP) ||
               (xact.coherent_xact_type == svt_axi_transaction::WRITENOSNOOP)) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type  inside {INNERSHAREABLE, OUTERSHAREABLE};
           }
           
           /** Constraints for Coherent transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::READONCE) ||
              (xact.coherent_xact_type == svt_axi_transaction::READSHARED) ||
              (xact.coherent_xact_type == svt_axi_transaction::READCLEAN) ||
              (xact.coherent_xact_type == svt_axi_transaction::READNOTSHAREDDIRTY) ||
              (xact.coherent_xact_type == svt_axi_transaction::READUNIQUE) ||
              (xact.coherent_xact_type == svt_axi_transaction::CLEANUNIQUE) ||
              (xact.coherent_xact_type == svt_axi_transaction::WRITEUNIQUE) ||
              (xact.coherent_xact_type == svt_axi_transaction::WRITELINEUNIQUE) ||
              (xact.coherent_xact_type == svt_axi_transaction::MAKEUNIQUE)) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type  inside {NONSHAREABLE, SYSTEMSHAREABLE};
           }

           /** Constraints for Cache Maintenance transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::CLEANSHARED) ||
               (xact.coherent_xact_type == svt_axi_transaction::CLEANINVALID) ||
               (xact.coherent_xact_type == svt_axi_transaction::MAKEINVALID)) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type == SYSTEMSHAREABLE;
           }

           /** Constraints for Memory Update transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::WRITECLEAN) ||
               (xact.coherent_xact_type == svt_axi_transaction::WRITEEVICT) ||
               (xact.coherent_xact_type == svt_axi_transaction::WRITEBACK)) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type == SYSTEMSHAREABLE;
           }

           /** Constraints for Memory Update transaction group */
           if (xact.coherent_xact_type == svt_axi_transaction::EVICT) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type inside {NONSHAREABLE,SYSTEMSHAREABLE};
           }

           /** Constraints for Barrier transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::READBARRIER) ||
               (xact.coherent_xact_type == svt_axi_transaction::WRITEBARRIER)) {
             invalid_barrier_type inside {NORMAL_ACCESS_RESPECT_BARRIER,NORMAL_ACCESS_IGNORE_BARRIER};
             invalid_domain_type inside {INNERSHAREABLE,OUTERSHAREABLE,NONSHAREABLE,SYSTEMSHAREABLE};
           }

           /** Constraints for DVM transaction group */
           if ((xact.coherent_xact_type == svt_axi_transaction::DVMMESSAGE) ||
               (xact.coherent_xact_type == svt_axi_transaction::DVMCOMPLETE)) {
             invalid_barrier_type inside {MEMORY_BARRIER,SYNC_BARRIER};
             invalid_domain_type inside {NONSHAREABLE,SYSTEMSHAREABLE};
           }
         }
       }
     } // if (error_kind == INVALID_BAR_DOMAIN_SNOOP_ERROR)
   }

`ifndef SVT_HDL_CONTROL

`ifdef __SVDOC__
`define SVT_AXI_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
`endif

`ifdef SVT_AXI_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
  /**
   * External constraint definitions which can be used for test level constraint addition..
   * By default, VMM recommended "test_constraintsX" constraints are not enabled
   * in svt_axi_transaction_exception. A test can enable them by defining the following
   * before this file is compiled at compile time:
   *     SVT_AXI_TRANSACTION_EXCEPTION_ENABLE_TEST_CONSTRAINTS
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
  extern function new(string name = "svt_axi_transaction_exception_inst");
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new exception instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the instance
   */
  extern function new(string name = "svt_axi_transaction_exception_inst");
`else
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_axi_transaction_exception)
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
  `svt_data_member_begin(svt_axi_transaction_exception)
    `svt_field_object      (cfg,                         `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object      (xact,                        `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_int         (COHERENT_XACT_BYTES_LESS_THAN_CACHE_LINE_SIZE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         ( GENERATE_READS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt ,    `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         ( GENERATE_WRITES_FOR_READ_ONLY_INTERFACE_ERROR_wt ,    `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         ( GENERATE_EXCLUSIVE_ACCESS_FOR_WRITE_ONLY_INTERFACE_ERROR_wt ,    `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         ( GENERATE_EXCLUSIVE_ACCESS_FOR_READ_ONLY_INTERFACE_ERROR_wt ,    `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (INVALID_BURST_TYPE_FOR_COHERENT_XACT_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (INVALID_START_STATE_CACHE_LINE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (INVALID_BAR_DOMAIN_SNOOP_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (POST_COHERENT_XACT_CACHE_LINE_STATE_CORRUPTION_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (AWUNIQUE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (SNOOP_RESPONSE_TO_SAME_CACHELINE_DURING_MEMORY_UPDATE_ERROR_wt,     `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (USER_DEFINED_ERROR_wt,       `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (NO_OP_ERROR_wt,              `SVT_ALL_ON|`SVT_DEC)
    `svt_field_int         (invalid_burst_length,                `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)    
    `svt_field_enum        (error_kind_enum, error_kind, `SVT_ALL_ON)
    `svt_field_enum        (corrupted_cache_line_state_enum, final_coherent_cache_line_state, `SVT_ALL_ON)
    `svt_field_enum        (svt_axi_transaction::burst_size_enum, invalid_burst_size, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum        (svt_axi_transaction::burst_type_enum, invalid_burst_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum        (barrier_type_enum, invalid_barrier_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum        (xact_shareability_domain_enum, invalid_domain_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_axi_transaction_exception)

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
   * Allocates a new object of type svt_axi_transaction_exception.
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_allocate();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new object and load it with the indicated information.
   * 
   * @param xact The svt_axi_transaction that this exception is associated with.
   * @param found_error_kind This is the detected error_kind of the exception.
   */
  extern function svt_axi_transaction_exception allocate_loaded_exception(
    svt_axi_transaction xact, error_kind_enum found_error_kind);

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


// =============================================================================


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IgXtuKp8S0NmJvrvc5tjz3pISCmcdargSnIH5IhsOPxXPNBvkrVUh/AFdJvZYcIO
YNx2JLATAODe7epSwzLku4BqsJCx0GM9PcydA3ImuROqU7VkUcpPvEKtzMLkjCVh
dB96oxlZhoxW8Ny0kiHbd+zW8trjs4kzmytv5MPFjCw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1329      )
HB3S/1Rmiuik9sId9vG1DZAFLw8U/6FDN5VMUqK1A395K7mjGDYQUMdpCEv4w8Vr
yhc0YSQ3C3ixfi0cjn5ZxT/fn222CV9AzzxpNBGrXAKUZXayoLarvA3HQbydg6b0
pStxFWZo2IL/dlzGRFtjy2xgtdG7S88zdvzMTAs7L8fMPIelYdGZJ9RD/72Wr3lX
sD9TQ8WsLoeahpy6x+Ia+svDRRal3IkyTPDPjfoZi2Ftjy9Xr3uYiu0yyBgmnG5S
qsSj948zX2c4wKLqZ1L5DcJwon4vEeuqr8v1xkdiHDL/sg7fuDOb+F6ZqcT60v+v
PMJuoNOx3HOOXRMELxu6uABeRq84PNJh+zI8kta9zwxoRYxPu6/p3YUE9z4RxPsg
xRo/myMSZmFuffdUuw2BpZHsqoTFyrO+OtSKjsrBITSdh83sgLsBfbSVZd6ATDic
zCbE+bWc+v4nSsw7S9M5i4vNQIRorIzMku6WICki6VztPIyaKmn7IC2UF7Z7BNIe
fuVK/ZxeXk2EWQgVWz9sDU4U7HpY+5ne+2/6sZSLGwumTYvBgXnOwdGx2Dyvjuw4
JfPC8rpjfggqVuUcuiwHBKSekflTdz1IdnclOupDzqkHs609JHVI8TdwsLrqB7aZ
vb/lYHgU4peaBaBKjJgBWWvtCIw0d1XlDTQu4pngCRcZq5mUAfBiz8ASRlJg8l8v
+h+jc9sRfzL1TFKvOApcJR4ni90DeJpWNVChBqy6MJJKhBG+nREVZBHDcLIX3u3S
MLte4+0CXB3vQktl8NMk+uVr7gfCYCU5c5ISJw/2zEO8uELVUYV6TsU9Jkm50Tcs
2lcXN3OXDzuvUa3IC8cXfcQ6vf7DBk/FDhSQ1TjJc8uJFraSfmKYP35tI0AgQ8WE
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g/VPdQxacMf0bQ6Lfn5GA8QTytVY1VgKxsfrpl90XqoLgQcHzAYScAmcwlBjta9t
XPYfFK6fPoW2cUq9HAjQCjbI/aw1+r/hbBHSULDnV5w9YEKeZX0RC0xg5WMQfl7D
jI1bL9PbTbIyMjuaO4v863SBgP4wweREJx6PdvFz3Tc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27085     )
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
`pragma protect end_protected
`endif // GUARD_SVT_AXI_TRANSACTION_EXCEPTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EHzg6KhzOvSo2syMShpHZ9EKWlQBXExnDI7dbnT4YCninHgMIGTGE0/G3y33o6i/
M+BsB3LBx8cqRo+HpN3TrowT+pCQkp0DagCrlO6oteu/DdkXiZgzaNZbSQGqyqEj
+JWqEs8Qvjbt7tveQJPCNxAMoHpqXsPetVX/LwshG5o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27168     )
svv5s62Ld8NW+5E4ilU+IFsvWOvl7tAPyv95nSt3dJF/zMFKHTx7k5vLgQOO4lcO
h6+7A8HzNDPLLT7GS5KnxUFb5QJmwYVoB0CCp7t/LsnMtxeLeVG7yrDoAhtKjZ1b
`pragma protect end_protected
