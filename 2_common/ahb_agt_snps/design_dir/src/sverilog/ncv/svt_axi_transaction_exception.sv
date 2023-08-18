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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ny1RBu5i7Deg5DoAn0yzZHCWHSERYOEGpeISLJWIdoM+Xq4KLEHqkd/AqsDL7c+S
xayRX7Wt4BKwBovzOv48h/yMOgc5QAC9S6eJmGLf2poRXTyq7QoArREnP/n/qDCS
aXP/B68Yj/heRQkTdVd9fr/6p8dFFJ2cX8U+vUDBfwbRKJPYdscHgg==
//pragma protect end_key_block
//pragma protect digest_block
aDEQI6Fg6uI6SIKof5OZedD6gXY=
//pragma protect end_digest_block
//pragma protect data_block
hfMALVmxmESYrGjjxUsVS9fRSLUoxsY1KiRqsLLBVhfrEZgord9idgZxFxpw5+hk
cZUuxWSGVeEmj9Mj0Sczw70/sqED9a+tjzwyIlPPziEF8xk4X3lN9cjgpGPzTrqg
FCbYcouBsG5OMcn8G0iA4aThU1JkoHD1GUh56y+nKb4E7LX/BxRlU4WfMapQReqX
mROp9qygMv0e4F5e/kNQgHydnLeujCXAgOFWfL07iw1ah0OcK7UwaLryl3vSDcz5
shJIxMn3aDKtINexC0t2R+1FRFs5wgtClszl/N6P05xBd1rmRnYcj4n6c/ZGu3WT
GRLIAhsse0I1Yd67+bzViiWgKhPll26FRfyickPjdICIDYOlwdSsluHhl8EwQkXi
C1qugONR5t16NMyLYX5Hj0qFvazxmugr7S73/gKk5VrVGdIlbA0z+tqOFfnq350u
BSTMBrG941RFTFfcyDdCNa1bj83Q+oCgkFs/J5nCynt22gHqb3ut61jZqkBwGG83
fa6i+SFRh05dXw4C8P0Rmb+dSaEfLCnZ5UNARcSTNc7hsSY/sAIHoCQyj2mW0ftX
xzIdtVmYni8gnm8Ao179YylbwLrYa9XJlJ8d12Lo/IzxJ5/Heco3WSmNtj0nt/kk
7M41jxv785VOjOChFvk1gGpBzHJsuCBmGc4N9yAzG1jsCAH4mMLfVzwVvJhr0rPq
gTcc80rhzITUACCFr6f34vJfgJeiuhfkfKrl9eLFZ23AljIAGdQgob9xRrDTvGOa
rA4I4+TW/c9i3gf7Z2ybCIZy0+/xZOOcPsRrFA0B53wTpEYXo8JoICBZ4gltvsCl
Hb+OZ0ROAMqUE0qI4KWWb6r3qqM4v0EASNW+4xu2ZueS/htvEmIQfp9i2JU59S6G
y2eiXUQBd41PuUYIzMMgwG7AOlCNPRIbKPOkJmS+KphsObzwdBi5dTxyxr+JCcyn
beajLo5DwDXA6Yht1FG3oRuAEJd66vEVr0QgEbxvL9ry1qO4KrsxzM1ga0TUABpK
Lbb/oj1RdXHa95+66mXPXYSvq7O9E+ePaZOq46qFUa/sgz2dBtHgYa4zQOEGbG3s
uwwg+2dHuIaS9+uW+qjolw==
//pragma protect end_data_block
//pragma protect digest_block
UhzPx2qITEBteznBEPtIFcs2x9U=
//pragma protect end_digest_block
//pragma protect end_protected
 
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
m99KXxZgeBxL3zIob0LJ8ayNJeKv2bl1oAwdlrk7lx8lBrXbhNB/NfMR8btetuvu
zySTL5p3I4ivgKPCxl5sydUMVqjxL4TowTbxyVmickfx79oCFWZFFIBL3IkX+c4w
Z0lssc8M0bVbnjlU8MD2KxyAOJMETzHJ2MQ9e98RZWIkhGW4GQwbrA==
//pragma protect end_key_block
//pragma protect digest_block
za6FVd682dPBwELKxtiGnAfnN4k=
//pragma protect end_digest_block
//pragma protect data_block
5IX5lNqTTRDnazLn0IW+J4BRl5wVdN6teeyTNxi5j/ebWH8vNVehVJTh5TMY75kj
hHmzw7NuQ9sP2sV8bLr/KpzDKdFjhpCg8HAcwkrEoZJx3iCWyaO1h1d0dj79+pYf
TrnWzzFgCjrrSyDHdmnA+0KxmZy07YulTDL/jgRAt+nj3hjGdzL8Q7Cf+XOl0aui
sbkRFZuGjHvlx9frD+rlp0ZTKESzHBWJQ1VPSYV3zifiAD0sjJ4VzvDjIMXN5MoS
Yn3gIhic63RDahHbF/Z1277zl7xmB42HeSYwuAKAkLwZ+C7/vMxBjxr0p1w3EW7t
NE7kerhRmR+wErzDSzTUhGwhHYECR4iBZ0Tr1KLdnHi34Ga/HeXcW5/lx/rjLtZG
w6+MPQM5RUJeSjUjlVLOHenkTIuBz9xaNaSI9UWNlKib43Rk3px1uAAJZBZkoldC
lGMp6Y43aimcC9mRQH5YJUfFyKE0+tCh4VTwB3ZMhyVJHtOTE4Jm5KvbnbaNGvc6
LAi7ZaaP83456/9LPs8vzWUCdFJQJxezugmChdsG2AbjCBODDQzMzMoeGFqTtnoT
u7e7AqXoLmbcDBIvMZkVi/1fH/2jOXbA5yUjKpVboGqax04v/MSzYr6UC3hq6ANC
aT2YlufdmmJ5JTUxTROaTGdPxXiBp6v3McAHFWA4KaGSVYro8ry9QOBlv3tWlGsF
jwhnGccy2aAXDcgWWpi2U5pVX+wcgJ4G9gD1zVaKz+JI+3SqAG0ld+BkTZO5YkzD
m/5ganQMcLul5E2NLT6/og5Nn0zEnwouJZMFX0dKMdwlRuvQQZpoNtYl48Qx05vR
STby96N+EYlMFODAHQRNZskIKW0XF2+L7AavRvTj26SeJCbH7jeStoJiyG1by/DG
PkjTX0bzYcxdgjxEFQLZeHKoj/mCBYFtEO85ZCyIG+21fNDTZjdzoY/8AGezYm5g
EuBk53L/la0HfaveLyrCQGlIlrBguepUQEiIdmdKjrz5ks682f7Tf2BLBId5SGtD
07SgGhZrZA7s4Wh4CbzhPl9hHK4BeDfQb9SlHsV8qixCEIgzX2VVctO0DE4zw4Ub
3CdbkU+2zHaDDfLOeSZAYQ==
//pragma protect end_data_block
//pragma protect digest_block
N1yoy6JvXWP9ZYxQno+PhWaT1G0=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wocqqrJvJWNVobAVJhDlmCd1JUZS5khSgMdYaoPDrB9qptz24lM8ckQGq0+BnyIT
1q+Q3Q1K9ylJh083rRZJN9AnNM/xH1r/Td7BeFtxEXQ+go2Rf7rndOHLA6PRn0ME
/CheoehchYeDMEn5y1ouwyzWZmAeigfrKh+SE0CncUHb8KswndCz5w==
//pragma protect end_key_block
//pragma protect digest_block
NlDt2b7FTATa/sjw6QkNO1OXqhY=
//pragma protect end_digest_block
//pragma protect data_block
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
YyhF8aPeoRo7qq6+iPDYxw==
//pragma protect end_data_block
//pragma protect digest_block
A/uuM/XJ3cTjHyM4m9M09sgFhOE=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // GUARD_SVT_AXI_TRANSACTION_EXCEPTION_SV

