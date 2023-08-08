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
`protected
O9X-JOcG-JP3fc20[&g1-HV7G)5N\)Hg&1ddg#(18_Z8K2aUff592(2O?Q4N7[S;
A7)dQ][S\#e.3>ZM@)(INdcHDZE\3Z-JX.e2C4OVb2&ggGVe(RTKM(#GH/a28FBW
0PG+EeH5]dKLP8K^^KVBPQ4/)SHPH[_LBWR1#;bOX&)Oa#00>c=-QL_D.A)Fa\\d
M(;NgO\([42(:;J<1UXG7E15C(Q:)?2EM0,1LdaV#d[CZQ#DdPSY^E/Y9&>-<K/A
=PK[?&J,F45@S1N>W]5.(LHZ9#]7]4#A/U&FS<;JY=/Db>;N\45RY@E;DBFbW,:H
,+Ic6/+\<<W(LCQMA>MVI-f[ZNgU.E/7@aeQ_TPfROIW:dDC6ETZ@g#>B#(UaQO+
c0T9N7H0=D^<.+Y;53X0(\[UGG-VdY0.DG#-YNc@>;eKKQ)cD8fV6,+.1OGg^YK#
\]YJ)g;Je_^fPVC0a2ZD4+<-XCQH<N/>WAOK([gA9a]3HWMTE)S1E:]O0-VCK]a6
afHde2,41R>61ZV=O=]\ZUb6,OJWE)=7=g>GB6?1MV_61Wb?3-Kf43[C6KV6S5-A
VW<=9F0HXGS,W5SY6OT<)Z&8.9KKCC=>M5\,Z7[bcCUFW(4<2Y.EZ[X.D5]8?N?@
gMO042(^F:&VfU=7Uc&&G45)QP_<::,:M##/275[,/PCZ+(adNf\S?-C.1fF5cSJ
_^Y^Rg-<Cg8_AK7AU.8X)XV9_XAgc@23Qa,MMY&GCgfHUgC1].Y[\QP,-A?WG1&Y
,]-(]/,c.D(ceKJ>IAI54+)A)_(5&]SA<dFNW_(DW&]<9IaJ5ZUTR>V8V51:\Y:-
M9)W,QE&JX+c/$
`endprotected

 
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


`protected
?dW=#--OVJUbGJUbURLgB]BLPEY\Ba;eNHc1+.V[DAU.?HA[RX#R3)DWMR/;+RcT
eK.2e8XPTX,Z3,IG9(KQ<T4F1&\WOM7/P3G=AXV2&O\#1UGL&^A^.6Ef,A0A7(YD
G8J7BS78\T^)\CB]F@M.\b:K>O\D?(YM8^M/4LNQKM?3A1\9;@Y5L//J?#F<HXG[
d88#58aKM4/60<JRDE[_B#G74+7-E>HEcbMcDG6=03QL3[UB]W]U1b[VUc;G+c#+
-a<H^RQF81R+)2-EIg9C<C9;N+Ib\_6edCNM6?Mfe4@)+b??W<#KbCOVa7IU/E?U
dQ\0B;#)RNgM:Y/FO[A7]6M1(LHe9PagRJUOcJacT)5K[]CHQF#6O_>-1M6:9B3S
,]J=IfbgB;;JaU&.<J7_;K7&<eQ1]-@ULF,Z:9PMY\I/9B/X+EV@Q(_3V^MaATdb
b?]?_1;9]6GU\UNQ>-K1,]XR53/BO2[bQ4G=2E/K_#^1^L>&R.e9]XFCMbDD-F_B
&N02g\FT)U=KZD/J:7/.K9a&\(HX3.B2@<QO6AR?XN4WUZ#eX_B]0M?H@B@>P#9O
_=TO_GSXDA@4URD<-Zf>5?g#MECS,73Y86J-;>H)SA)_<CA-5CJYGV--\?c:X8\Q
IYE?.&N:/IY_2IY0I,N@U(WE:DG<b9@e.f\4?A4]Q2Z4#:(JdTVWQ^JI4=@1(L=1
Gf7Uf=3F4J&@cI\[.Zd7L[.6-5TIYR;/@$
`endprotected


//vcs_vip_protect
`protected
a1/gDWUgFZFSg/]@Nc7/\B.EAOe@GQU\b?@bMQ&]O>6-]([#D^PW2(=+eM89BUS?
M>)VV)(/53eE<#]R.[]SO#R+V=AUK9eY9;:E[FOa.K29RD<Ib74<G?^19\-D?LEX
BF6F5[R_e^JK<69KUY3N#UAA>@UI-32_X_MZ9+N=^N?>GLYf5a/OfMFL0f[Ig1,V
1=YUfQG>C+e629g,PEVL@E\]#XI5ge@NIP;68(MBbMTbT&68FD?(6/aZg7[T9I-T
B:Q/H^4#feTObA:+-D2]S_S>)d\EX:7e+G4+WYJ-I=XWW]J2Y[MdDJ[C>E853AXV
5(0W>eHbR=WHb7D/aDc0B09S@A:bT0#L-K74WdIF4J#OV9/#Y+5A=,E?EFC3T(LZ
EbDFBCK@S)b5F53GG<WVB,=7NF#<LT(M\>BHe0#aF82Lfgf,MASS7AKF8FLCd[>3
1(A=e<P#6TeO&X,8:7](cWSTUWHV8:fa9+2C7BBR[9NSZb_LM136>:.3OBaGN>=L
9fFSUae#R/^_)d7-Fa+JSX.&(C@=N0+V#f3QdgeXcVNTe2Z0=A^CE&44=Da;a-B.
.GK057:+E5]1&UeeZSI+:;8fSJF9I9d1?9XbYMeP0@9U;90#b>c-&)?^,,-:4c9]
3+5O21;<PPX7DE^OKEPF8@2ePM0ba/GJ[686[6&:d]g:^+CDXcN.70W;W98=aNM\
aeVf6AA>g:29W4FY&6P=BQ,XOXJS9KZS2acM+1M6U;@5dJVXZWW#J+<C^8F:_a?V
+DD]3_Q0XIU/a9:PPF]89K5Wfd7PSR7[^QMc42I/c6@NFF<TXcabfcB&bCQ[7aG\
2+Z>W4H(.9,#@T23Q60\,I.OY_dfW7_(#HIJ2cUP@ZR4S15^0L_81+Ba,c>Yc#b+
>]3b]^^Le#;@2OREP&BPMOPQY?Oa=F1X,(5T,,&f>,UPUY6DdE-.a;(-_T-V6AGZ
3QX;R=Ug-1C2#)(@@^@@KNHOST.+e9Y2)750@IPB,OeI,)TdFJBaB&+K8S6#dJL)
?a>PRMALKDSBVJUKL=5,FH,/a-BDGRL>6E7S4<1(&]/.;d8>672Ug]W0FbLV(=WX
Q9F^gVXV92/c+C1;KHLV=P:QK/Pc5::@><5R>U)LM57S]=]g&:b>J-@JUHQ43/G4
8)3X579W[d46(1Ae_.?+2\-WU?VKKXH_F0+]OW?4J,HJZf7<T)BU14,^cR/G1gF6
DJ40e=f<+fGL@C./WB:,+PXDJ]M([_\74J3CO&V5(O3I;\V1egE5;5P7G=VQ@3RW
)E3,9@+KNQNAG0Q9];588JI@,)_;W^/VcN_+GL(/8IV49N[NSS)#WcQDCa@S0Rg+
afaXF6W8A^HcFDFP,DC[-<K/B,Q^GbK^_#2FK<GHG?8U&V,::Z&)4M@N[=T+(^/O
;ec34K[(MRCbN_X.D>RI6,PF&[&eD9B29617/9.^3&XMCf&KV@DJ_J]22U>?aK\5
G86;Lg/?S>:GDM4#:YIgYY.Zd25E7Z=++.[[#CXUb(4]6?ZCMOC1U#2LG=S1L8O0
O7@g2[;(6+C0/?N+Ja_>+N_6M^)5Z&OfBIUPD\Y^YWVLD__/a-aJd2a[MT[GRQ4?
;496g<[+IMPNT4L_KAcGN\2GW</Y?OH^OdGTG\65HdcH4ZJET9,H&(b)@7ZIeRHD
1@1W]fNVH3NdWe(2Xf8=\e/\U^2;.8:Y,0bZCYQ03+P^J^&4>4^/b5Ja6U5EE65d
P?MU&N.A<I[.>L?cBX1P+U?8^@7<X5KI;]:&,I(S3U]JC6@Y-?:U>+G.I&__/1?F
_4C+7HQL[R7D8GCGcL]Y?=b6FE+CD_LVE<0HQNeL+&_V6FT+D)7W9Y^fCJ3/RT-[
_]@E<EZ)98D&W>FJd+]ZFAJ1AdU<EbPV>U@I6)L>H9f=]A3Wad@)6[/9D4)@\YFf
:L,5^Q7)dJ1fNdWfX.f3,g=1aSM-C6X4#VYD\UR:\0b[G7B1;YAUVd0\=UR3R:23
==I0@ZZSX;M(=:C&NK11WEaVWP<[-5SLQ>_T;PY-K&YFG/0cEHSZKCNI^HcVJ16L
_^bZHAfaMU^dQe&d1PVK8b3.;&^G-,],N<//V-?</K0&E164FISbVS>g_ZUB<dZ-
C-CGV?SD@<USV<&fIS08RZT?g)+X&M#cQ&7XPPAR&VYU-YAU]7XXP&([L1S_4>1E
<Y+c2Q@2\YFVXA?d)[^XOB5d4#<)K)0e?8>AFR06([f.f-VaM;,2bT(\BI]^SOTC
ZA@XY6S)+7^F<5;KEM5UD9@C8[8bP0:.8?1DH80AK(Md37MgB(OS&OG1/-M^:^U9
4/6dP<c,Paa]Q2.Dg^gc8g_Q#5:)BTXb3+.>RQOJbI0fOYUDFXQ<:)cT1A<dXaPT
KBM/ZPa;^><XP2)1TEJJ:.=]RSB7;#VW5VD008a3L-,Z2NK<I\e:Se#b1KF6:(5E
D)6Z]QW0I,bWFKQ24IJ[P]++OQa^(gY(LT0F7Z33;->&+P(0]RO<&BO//0FVEV]F
I<YTa:BLL).aRF#?NH<[?b@+eYL@fg>:BM#K2;W=01=--0^&B./.cO(g,+Fc&HZ)
2USO^ZY2]V87eTPIOJAK=MGbA6:E#AEV\<&\^Rb\dQ#gg7,Fa>dQg/=64G/S5OJ8
JbPDMQ/.&+F.S2]/0BfB8S-dSONdRXIBFPIKV.Y-VZQ\QQ,.b=NSbFM-T46-H\LA
[X=+1Y[e)D994@]gH.W@(Ce:9M>LFZ7?1V9ZH[1d6IRfG[->^?\B^e?B5O7DX;:S
J7J\GeLc9Z/2@9JL_3Vc_5cO,@C[:RO)]66ZP>,=:1dOM\#7E9BX<2PecM^7(^;V
@^TT,E,)3L]9=4Y+^f.LK^3e.)+7PC<(+]CJc45OHM9)_Y_.A?&+O;&QRGV]4V(^
0?UDdZ2^@?URYA<VO)b,.4J<5U.@CWZY^H@dF8-<BS.aGO5ge2?HGPf5W+eZ]_G:
5g6G/dg+?G;-5[01BOb2^OQQ2bg;4LDTUW.77^GI2-U^M3X-fIH6GQD_07C\N2@U
D0BVT5K:CNLSTTDA>01D<P_I/&&?HD?-]U60A57KN@.>1g(6P,8fQD7]#?)@QU&A
.JF089;X+GAJY]WV0N@A,J&1fA;Y8RfX1#gO#@Z-;?++2=0ScG3.[(&<=REE+UVF
3Md3[?^(\e8+NcIPX//eHZe(Y._U7@O>\O8A(3b<G[-0N9QN_FY^,K/b9CZ41D-8
8;6=B&^Cb90O99:ZPCZT^+f=XEO5.YZ28AQYSELO3H>g)7D?HFC,(<)KH>KRPJ,3
VDa\>S,OM@;9SU-V5\W,6,DOgRa<8D(g=a:,+71U[PBK8&K0a4[NZ<8M2Z_[2)&8
C>OMW?\c4bTAFPQ,KIKEXd_3ADVB(=P7:)0OPW#\<4<f7#S?J5)F5f=XAd^O6,>I
-bQbf=R<3P+_SZXVbfgH6\,bJ+6g,PX3_dQ<&@f[[&]TTAUL7@dWB1UAZNYCE@NW
O;#UKN7ZJJZ<_@R&-3XEeX76^e/9.7WT>?60Z.K:O0;KP]]W02\=W/JDfg4)U6Df
Q7;PCU>a2C;8K8]&)HF0@<=O8.RW1^.6Y-M3>_fT5C@#[BME.BHKC#@ZG7R8IT=S
=+g]A92@D_a<G^13JK<=#/IdUd_5b/WdQeOdQZ,<:.VEQ/&B[CH5[SWc@<Yb-OCW
XJJ(OM[LaP,Q<>P,@(];R[U1OIDcM]?0/10KV7CC<@@f#=U&H-A1&Z/.M&X3/aFG
5JGO#G]?8Q,Ga-HK]2R+-39KSfQ<JQG-^cRT\V(R?2?^X^;A+@4ZSQ+E@X/56:SA
gY/&V,-6W&MH=IE/Z4_T(D,MB+cPZA0>CV+6Z#Z<]IGV:c4(=?(<;.8F#Y=IEJ;\
9MSVa?L74YIgR07GOD.XRg17?]Pd[[&V:Q@USAPS(5OHXK<f\>N9Wf+J+WC]M[G=
gX;cN^B_\3J>]^c(1NH-PGY0b<@>@X=FS2^PR:g8?0:Wg2gI;Y2[,)8GQd\-];/;
WeGU3d>F\KdfZQc>VaDgH=C[6]=\O@0Q\RXDUA25TXIB:BYVV@RFbFO(7#T;FM]8
Ad.[)P4E5DM#@0K8a?&94Z^?eQ^/+DHXB_WeGe>OG\;=];Z)SP>be^H0U/?OI3a6
ZN#V\XM(<G[5<PNOKLO,6FA8fe_g>K?VV[^PZ-E3d[28L3:Ddb56_.=NDN.)HWX)
<<H.N#]7M3_=71J2^f/[Y9QJ2PP]-5T(,gcY3fEVg6@WJOILZK1NGEVJVW2Ef_P?
QT&IVDHM7#OM8cE#G&_<81&b;J9ZV5dICL/f-IQ7ZW/W+[P,GgP@CI>]O(8Ved+4
WY][@2_d.Ec[<<Q^P0)g-;Ef/L\c-D/M0J@,VRCE;BDc<L1,5UWL?afF/HBaY;L_
(Pa),fQT^P9_+RW+LEWM/MS@&MV=:SW-.I=D,>2JMVI,^Tc0RLDXGag6E2Q>[7?;
/LWa)O0P(97?dJfa_Ha/2gZ\<U:.)PCAP;(-V7<\8/1gbc/b,c-]>K_3X]]b+._Y
F(?]FI-\[R7?F=1,64dVg3KFGb/A>@TH)NILFOTXaf90^Y-Z?-P7IEc&fNNI[&LN
[;f(g?BN;+/LDg=dI860ETKU]>a/_[[97ICI0DOB+_A(_=_D8/V/Q;AYPKWc?9>U
dM&B,cA/N-bbZa9Yb<TWGa_6K3^87&0V-(KISg@@;JG5g3IYbdF;#&g>IGZg[@)(
Q<5bEDWU12UWQ#f1EgE[B0Y9JR_:MQZN?_bI===N,D3P4=P(Ec?>FELf<#LUU+/c
9AWM84\[24dfTZbL7f+,I7Kd+=3[aI=;g+B0^dc8\d:@IdfE6[;42V.ea>_XZ?&T
8/69X<.W=Y4.<e&NBKe/e1g@WH_a3;UHg<U:AA8Cc=e[9ARX7eQ2Z>J2]Ed;eZ\]
=X+)@9g&YUCXd(Y3X=D,?e=&84.#E[^TfQ?X@@bJ@EF\.)fK4^&WV^&.YY31EgcO
D,Y\D<=YCFE_3OgW[)H@/_VV_YO3,N^IQ_N1T@D/JP/E:9F:&R^7#_(B,=YQcJE\
_=^&7U)b&Z:__DLJ;24E8<Vc0b085WFY@&U]aeS^#-\e9ee4@R<O)5QM)_#B.Z89
SC5fKVgXFgMSK@MG)R];T3T2(3f^RHK=WP3C>D5J@@1H6GfST9dPL=]AI&BAIWA6
KTYEOgR6F#38Zc:J>O<Oc1(&P(M&O?LUQYc/AG]J,gD,OZD:\-b\XXW<fQf7.Y)F
V(@EY5dCWPH]+bacZLJfIRb7A1NJN2O[Ue9/X8G1ba7-X]&UYWB:UdQ&)e/Y_Y=5
ZBCL1D-HKM6X0.HZaBR.[9+ER24S-3>6aHNY(Le=G8DWGYe_cK3>;:]]==I&^,<2
cR2SWgR;-5FX-I9XUN6dQ.J^c<M;;0RgY9LLa<E7KH:Q0<K(B2;_2Z@KV&:)8d&Q
:2])#Y2QfG57M]Tb3,#d<_EXZZ2P3()VL[XW-f0G5N9EfUg?e+PDSHRYE_9L^eT+
&.:aIUL646:C;E)[C>\[Y_K74bCBGZHJ+H.7AJ/2DDeF)Gd56I;]gP=YPG0^:5;7
+=B7J=-GG6[dQERM,RRAR2+K0,G@#0<K<X+\NR-:d=[ea;(,-:aC6]TdbF-50P_,
_TdVT=dMZ4?8?DXVNf>bbUFL;gMYNP<3:7N+M#&[I=K35(6c0DVa>P<UdVfZ5DNM
,_=//2Z4NNd5.,=,+_.4(>:3QK92aPG.04dH:eFY3::D6C)\c&I9=d\TYe^N=8[Z
b2_F=BAZgV#IOZ)0&Qd/@Y+>A#[:2_E<QWX59,bNe=1.g<:U>>)6O:aBUMga0dSZ
JCPAFO#/9#Te(Ia,]MN(SLa,dZXVJYELXbQ_NdcPZRG(ZOY>(GP@<XPg(_;3N1eW
?^N]Gf[+6cS,4;A7P(4V1d;f<Yc68,.F,1Y#_I\g;>0R/:3,>d25>+=/5BMM9Z#Q
#A3fK@WKYEHdQV+<H-B;UO;U4#JY59#Y9(P?U):4dADEN)/7>c;T\GTWVUJ=Y>ab
37;JG3@6-26/[I(:32<Z[/.gR_V7CKd)?DPd(+c@U84gZg?CVW;D^M[8JQFGea?c
aY7)eQ\QP5+R?D(;LbSGDU1MI/D-LOb,OLV](XYF+<(9?WPJdFO_0&HE175OPR-,
GLQU.&8Z-[19a@IAK//2R7e.fK-Jf2_gc6Z?Sb3[>WPGgONS#P8(JY:M4_SfHPH/
OF65W;Z3.[N+e.]9,#V04cd:H>@)W5I@X6T\]4_M0NHX?7X.(,;[O?6R@b\FRF5M
XGZ72I_VEgHSUgI2S[/&Z6&^TNS#G9UGEP[:\]EMXXLDIE/e@2gXO]=WH9YeKGP1
,_I89:U<^@Rd&^^LFZ)?C83^4>IPRF&V_[1bOCQ>;BLJX@W4TbZK04=(/:?_,U0?
WfeRgYV:^b;^3[29&C_b4G=^g4KHG;\RT\&WHPZENcQ#2^1U_](Ig4=^NM9CIUT7
@CAL5e;A&/UE@e_/aP:D@LC(:VL2@&WKCZ+JO]]b[9LXS]^@&&IHL\BOH&\Ad8[g
9:dPKa5\9H1M_@@>@)P@0K9PJ-BFCL.V]5Q@A;T6e1B\OWKU;LXN>R^9-9QAHb.e
30D,R5ND99C+^J(BI5I(,T#U\>I@B/INA)6a[KU^LB45.@KBNBgC.eCGc_F&TgY6
eKL_^2\1\g;G2e3+EBb2W,4Y\<V9VA+Kg6X#.,YQ;-+g+bJa3Sb16?1BgM:O9TM/
cG-Ze[<1XaN4QXVKBJ5gMSJ,JX:/KE<4Wg5bYJ,R@9&Q<=B:1>T&g,0JCG5K#Dg+
7Gbg-\&0?)N^PW9-Fgc1O4^UD#&>T&ZREYgdL=])_#D(U=cKRSE8(Xb/C-M=TX\M
,>CIT@c2(/D#-LEgF@8ID97\/<>W3aI7>,_8/AAH?_6(Q9f0&+P;X3H,Y>H[f:/T
bZfT9>;R]-1\ZVT=P8EEfY-@7cJbD@4[GfSc@[P/^=48VL[H:#;]O4OU/UGQB5b1
e2&(2@C#eBa-(N,^+,5^NP;AR0MTJIU^g9CPd,b2:a>;+@-PFf+1P??E^=0H#H)/
U8C749c#IRa;QV>,-1gQLIf^,CNF^MYO4,&<3?9ZJTR>M/3]/5LFgccfY[@V[YMV
WfHb#b>A7YN>WAb+dBG\P:0L438F]f]PY]],J;JZX,a^:;F:6/AA2g>(6dYC.g\]
2f^/[B0T+RS&\PAKFg+/.CQWL=IW(>gLY(VH)\+GFHPX#6eN;]?ecRbFJ9^aa8>9
)D5.+@NX/JV<\V\HI)^<6c7g_[KKH=P]VXX5f]]OJ[(G6P?77:YQJ]V8#X#Vfe)-
ZNJOdF8&ZE&U<96]VI<2TG05ea@Z_X/M=SQa-YR[>aIMJE8+\cW25\f)#[BMT;--
_CM5S-KR6NbP11_2D6^AN:EM2=22&dSQG>)UPeHM:]H-8D(BFb@IN7T=-c8K8gT1
]F+-:c#(4=:@I.e0OJJ(b=g,NNEMY@B6d6:NBG8GHE(PWd)W9<MTHV(OOO_OA&MM
-K9K]KHaCI-DV/VDaT&EP5IA-LSSMKT@P42H>P6_fL;I0fgWb=dHI>9P&6:0>V0A
B@bb5<Zg-8W^XZ8f0Z7g,;J(VI3B6N3+De9&@ZQC(>c10Ef6=0=GONC4K,:Ra&:@
YdaZ#+08/WDI2;e,8c.KXSgNKeX]J=cd,63NI(LA0-50^NSD^XPJPa>]0:?aDPH)
PfB.&BRV/GFaYQ08e#:1J&7CAS=3fZJC]]UC\aGfCV<TO:]K^Te)b?#7a,/1^>d6
1c&(8.=A^cM3/?OU;NIf4YI[7P+J;Q9N[:9)(\bcHbFaTC[Z6?&;G]5+ZVFD#a4A
c1dV;,dN]<@,eAFLf(SLS2CV0AX]7>TQdH+L=ZTde2g38G1-fMMMBa5P2M?f#X<2
NAH;^</?2QfH2SP1&M@AI19=?6g/NI0;EfYf7+/&.?f:Q>Y_.CYKPYYGD4K,RMBK
6bW.f+ALAVR1]\]_)T?H,V\Fe\Y[cbEWL)ge9H;WMCNG<B98<_W,\W\&\F;O_-IV
-a/+Q9V3JS.F\G3/cVTWBaOMUCdNW8/g2U65JS@=<NK75-f4OYI=<:@NP/P^cfKe
VW]9CMV/KII8K2MU3RX\8<0Lc77cQFJXR7DQbTA)^F]H7:EAKM2+W2CP:OeYULV&
(QEHdXg?O@7^e:^CZ?9@V:0;Q0]XfP0Ge0)2=gT3HM-4J9_)QSP_0E@SIOQ@M>WR
PMfN0O@0FcdP_0I9_,L(5U>\9a=8afJ4D_1</D2[J3X.Z)=F2M/.S(M>;HV4>0I/
bNM<OBE8LQO&\R,CX;d/^F#EYL2M(3BX[aE96^:Ggc(1LU?_(\C+<7?+J?S49dFT
b/0-R@/0NMN\gJW2eD&6&P5eaddcO#WK8T7)H<Q:g(?gZM\<U1?X:W].1g_JcBA2
fgU-;P0=FZ_A#,>G54Q^/7M#5ffZ2^N7X,#RL.-Nad/3N[<-EA_#=OW3gK&[[bFM
#OTCLX+S0]SG^=Dd[2D<b.U+YR#7QD8=;1XIe+80P3#6J37[II.I?C3KZ7^E45c4
-V7Nb;:e:;<ICNba#8-,??P/U&^L99Y+S)/LcFeIILVUW;137?EbJ[=A)8LJHdW+
d:0Y:73J,FMNBb)H;D1.OOHGE5=_=H,ZU219#=(34b;<GAca2e+_Y/BUMAC@-D?b
eU]E/O:M+ND511ICK-(EdEcP>(2/WX;g=-K)+A8EW;#C02L^fd)OdY:b@dJ;Cbb?
J#<CD3G(DQ9d44/9,L+KXE+B2D^1GEcc-2SWEe;6e51fKDT3.:?V=+Td5S2SYI5/
9XJF<K)KR999QPC-4G<Ba-/2cIec7\.SQ,=[Ga5-<&P_HD95:831L.\_<_1DDGPM
ZZ6Me^aI\DX6fQM2.DD3<54(Z5/5NM7[Ad]+>NgHE2VX3fMQbd#(:0e@Z]+T<)f.
dSL01C^>E;<TVASAI^Id[T5J5T]L0c[+JW^A@&cA5@\W_&.H)G2A(6g?(A.QaIKV
X/P.I+E-GWBGPQ<>cMAL>5(\K&>:fC&^.(-L&^I=JQMWQ)Sdd)]6C9\#G)/,P28K
X3K8d)dFaCG=X(^/,5>Q<4B(<I6Y5893);TT1WcQ/g=[;K@UUIU[OM8F0f,9V3K2
c@7We&N&G]/,FR961#e9/X2>F,0XA>:Od9NEAgFdY7+g=:\K8HY73MJ(7?7JN9Da
IHEHT+fV[7PB([A>:a.62[63\aL4;Y&E>CWB9VI@=WEb)JWBXT0BOGG&+^ODM-=P
^7)_@9KSH1&>[:Z-,_82(10L0FaMG]Db6b;dCL8VBLZDa46gZ3dH-T?+.&G^DIa6
P&VMWZ&_<1<7?)Sedc)gA=9.=#&WQ+Ve6ZO6+73^EUUVP56OJ4R.@EA/8DB^SCf2
A^:;&B;;JO,QddKGdHaaQ9d;IJWQ\\NJL@0MgS_T,a)D\,+\UO4B,W,5QU?QOaRW
D_^BO,?YB8d+PBc3LZ8U+OLVE8,HJ<3JA(fKcR2B-S[4<?<fg9K?KG)X#BaQ<:XR
&)2PgXBWcL,@\C8Cg@SPONUZ>@U9G1a6fF<c\EUbU6+4S.<d)d3dE3;\b=f)DK]b
C@IWa_7b8?)eEM82VgP@eQaE7(2_DT,WCU84H^DOc,4F=Z8)):P3[UVC^cDZN4:+
)a1Q.aJ95O73+T0dPI,b;(?D9L]46WfTC.:cEL59Jf(U]):c.4.Qg0E1AJC&7BJ.
50B\904DSC?3\4-O?E74,b/--Z^bKHJ3TO]d:e3MHJZ^CZA47(.K(]K+30TEPVa2
dbf0AS>ON61;5(L0K6)+ga[b-;186B4MD)Rb+/^)LBKJFSHY-Y73T9.#:+BCEM-4
<SbY+9K(BB5+8K;:3d0P9BWQ@5.4g:O,f5+_=BL\6cG#Y069;b<^&A]aQc+]GKYM
<PBYN2XYRP/A-]5BQPf_D[=bUW]UD@,K4-H9C]b].c8/?-AZBFMACJd)^#G:>3<?
fdWg))BZ.dOZR]A\T_6d[(7VTI9QBPd\b>NNB_[g#_aUV2T[MZ1+Te^S]ZU/IgAb
I\9EJS^@2ATAccN9)d@+0aWP>33IS=]<?Yd(C(PZ@&&B2W9/#1;cDY=c7D7D+Pc_
0FQ6;8)2S8Gd&Y2<?NcWa[OfCU=@4=&WR.QfDQ8>^Lg&A]Q+3<U;HQf.RLU2M06V
C[VA>:-W^G#_0.1@9a)cRY<V1],,[/9b-<)GfVO[FQDW,D\fb0f,)VE/IfSQ,cRU
d.1<_dFB6@2Ja;AVX=dBNIg,CaSW(<Z\27UV./<;O49X&<D.#Ig6cgX=3)866(dN
1eL-)0E,M&.(\_>gI>]>&IH0J0N490]@NCS^J#_27#&5;5V?A_N;bF4JDC)EG77f
5&&XG6)EYg2<c.].>F3]?J0Y;#@ICX]+@?8@&DSW\&bb6fX[d&-/R4OEDUS7M1LB
NB=9,KXFL4dNK^=(+&eYE:)6VWJ<Ze3L(7]0/QF.-Idd=T<X)RQX.2b>3MV;S/QL
Q9@Q>VJO&_-?H+K@CebJe[4\J##0)A5T<Q(:aJg4ZOb=_MVTLDRJ9[_\)MQA=VcG
c^AV)Q<T@VeL;O)M1<H+P81=<ZRMSKE:K)T3#)MC_P_[f-&f<PbQNd9g]+SS8]D3
&83;=QV453FDM4T^XZ8=d(ZSGDcAJ1(@c/]#RV-M/RAea8LAQ;f9^S+/6gDFd#:.
-X4-=?bKN-EG@J7@)G=8a49-Q7AbdgG#35P]BQ38RV(WFK[H0G\@A17#g;L<Y3cP
V9>,]6g9:B_UM0M(cT?/:]7E9\PF>OaY]A/4UNUFI[=26.B)/+7.NbTM#G2JfB[G
Ic_13AH;88I0#.@-cC\KS0]WN)/gJgdWS314\.HXO7;&\1f5))A;gSI]<.C_MU[@
)VFAb[K-K6R[e3If7EP.[W&,<]UYPQ>,?CW&PHA-F[\2/95,^-B@YKWRWFge\_1J
dJ482C92A^S#+[:eV=YRRJVLeIPcOCg#(V8d@=-(A\2,((O&:[D?QI,9NL?>::C4
=5a.76NHI7[aAQCUHaKW5EagQeYFZ7_X/a#?ROMHb28T8.M^MN=f)S,K6&V4F/5c
]eP<aXM+-(9Rd3Y&PP9^A;22#8YF6G=;CBNQU:GV3V)CH-?#6EN0bTTb.(G4[8_[
f86a^^9b.XABPBY[C2&NfG86I#H/,)A0.86Z7QG#D;>CJND6:c2GaeYE@b2dFG-C
fNSX?94S9VW;(O(2K_[VB[QZ9_58^5DO]]]OG.<a&d<=51-=g_BO,=WX>AP]O)W&
UL(DV.eA>_5FT^2#[4UgOU,Z8TNIe?46/M=H@>[H8.^D?=/19L+R_7B_#I3,M)3Y
F]_NXXSd>R+030]4KgV&c.e-(SdDDARDOT3GD4B&_@FNKOT;9Vd[L1_O1UCN[>cX
A.+a->G[[.PdAX+JY.bYX[POCMb>U1G3eU^D[dE5a<3GO9A&-Nb?\[ZcV9??;VdJ
3FfDL6OOX:XXGef/^_<ZgdCTFM=F#LKKfZg_;L^^++ed#+<,[59>FP;c^X:+dJW5
=L4JVdGYf5=]?\Xd0GC8>JAMT,QCPMI(fQQJBK?D7_2?/f4HLAV?18?NVW7N1C6T
Gg;_W7f(9;Y3b3e/KX@g^(.629PE5?e,7e.JM,;_G,c>4KO;>3M?+(??U;7d]f6g
+&A3X2Ig?3g3G7cBRZ81f[8XM,G36+PPDB0;FJN0g&c;L0Gb?dCeR99PZ7U8O\bS
3:R9#JZFKMCcS^.a8N\+gc[f6W2fA5)+K<BN-4KRU0VF4^H(]25/)^U8SWR+1c](
c(N:2A6b>2c_^Z[d8[1Q]8]=M1&^J0>S[8P:]cKL/[R29YdB6gMd7L90[5<Q_?/5
OV:63R=KMK,GU-^]SCGL9\_P2\D>=:?ED#J\[V-R3NRbZf9)b#:>b0E>87MFP0FA
,U^8M>AQ^84^W_QF\K]?&Gd\V_QPIEMCX<C?=G4\MW+&O[R?g]@>1+H8eRbO=N97
IA<OOUKeZ;M2W^:.T8T4?+05FEW\6EYEWMNR+&c=&@#^GeXfF_Z75OXNA(XJRGA0
/-X3K9IE)OC=L<>2_PN;4bb,;]C^5\OeS@[/AL[[a/HO;2e0T(L,0TfGA)gVYIbZ
W:+M4dS#GVFeW4;]<0GZK]+R,J;e7>b;^,Q0da_7TMV-HgF45e6dEOc^J6O/+DLS
OdS-3-35^RP,8+b<F](cZd<OR:dC,1]e)ATG_GN#?2W2-6#4OJ7<@D?90fH@L^Be
#<eLLg/#?WPdIY)]Z4^a\O;GZG?)Jb,;@F0#XJd:ZV>6U4-T0dS.[OQF7P]_O3QH
N_fHb=4>,MDJVU\3.5W6>b&-LN]@0F#QQ;H&fgA0+Q?,Id2f.b+[J_WaX4cfKXNa
NXUD4:geF&:8#M^-IW]C)3TR=(=eVJ;e.UH,MI??CB/M3]8P9ZU&\I_FC&([#Xf&
@Ae>BN0ef0RD11NW]GIMf>H1OcB9BJO&)[@f1-H<9(+e1A,f_3:/X0?P3JVQY^e1
/e#P)N:D>BbK^b@;[c2/.I(<e#HL&JR+N:YY3_MTCMS:G_D+SE81T<IRRCTB@Q6/
4[1/XG9&A4,8@RgG#Ub(\gQ@RM#,8#J<JS<GE5TVe^C]NK)S/KeDgM8G&U^AVaee
6UA>^ZE-Q-\5X>^e;MNC9.X#>4c4[)L6R?Ld6I=cL?/2^\Z>Z1gA=WBUfAe-UZ<W
?B:B\L/-F@JU3Mb5UM=DYU,ST](32d8J/)/YCc98F20RSEa)\LGJ1;EZ3/(^928R
&9WG6>8eOS6:f50TQ3\P>+aW4U1)a#81a5H2+;0DO7cW()AXA)2?.JGH)<Uc?VJ,
1eA4,[gKaM&.eO(,;;\L#DeJ580Q&-N&NA<)HfaM9Q#QSGKIJY2Vf5YL_W?D_)HE
UY;+9_WT42:=\R:<8gY[S+&SfM==2FG?.bK]8c<ID5^J3e5>?cG1^?7J_Jf&&Y?X
aaHA&B62MD0HA[Wd0^f7aNb@Uf\f?EPMK6aD=H==RK6?0FW5.2JW[O#?36#Q>;QW
c46-]L^4Q<#c2GX\+>Y@,.?V:LS\9DCc(>f6L:O[\LW0)402PcI-FL\@XTbH+.W5
CgOaPedY6@dJY>502#Z>ZY>XgZLcJHgU\^Q2@Y:4U]3<]I,=17QML]]CXV&G]HP1
LEF9U?JT#c[T+Ja+E[O:c\YAYQV#VYP7M87R2U6]IVf&[Z=B-G8fW/#C[+H^S?\W
4fV(5>KF9?DFUA5X)N^0<e,IP@.HR;c2e1.#]_C,YS09<GJ0eCbGV_3TgN0IZJ5>
+d7a:O[KPHE-,@-?DLBQ0G]IVB=C,VZK.c<>1A^7f^Y/.O_c;(eS#IV,f-W<&B9c
-XH&PC&45&Lf2ILM99bOC7#69ITJ=WRX&^:DNJ[F&<0Id@(2&[-2Y+(dWVaEN+X=
OH:],G_6I(QVXCU?a923I@A]CB-3WAbV[Ha8TY1WS?Xg-K>S_N,2EOPgA;]\U.YN
Ca_6I=,,(J7IU9c+U+KFM,#JIU>Pa2aL[I>^KHBJ_S6,Zba2RVBV/LM:_FGF#+][
.[A5H>S;EU5:b#&U7Jab1-FKD#S0AXfQHcZ7AO9=6KTCbTPR(UbA=eSF?_XX.f:<
=JUY.gfeWe94eKbF?,C?@^WKGIGEPNFY1Q1NS>F#VMVT8W+CR[40K@<TT27,IB\)
8.?g8aacTgA8R^3A<dKcR(1aebfN+53T]SL_2GD>\G-7aH\+J2:I)cJD1\57.1Rb
][A,&)C9aEU)MMUT>U&3=A]F0GX/&>QEg6\7[WN4FB^(2gFNPPeT;J3/^5(U=-@D
75__,^<W^>82-5]Gf:gF,b\S^MXNVf+&[:JH(ZZ)AH?5Fe5C8a#HBH>V.E)dW/(Q
JZP-H<=LJQT&;G56RW.2:+T>Qe45b^eOF:Ig]=AKI4EO?A(Z;(._CKM51V./N_G/
(ff@E1^M+QfEW6;MZfN8MfQ0(1T2_0>2?fWW8&YFf;7&R=G2VGg#@#2g8BLA:f1W
E;SF1THY-[<EORaFH.^QMG>/Ga]RIc3K<9]:B8P51J_aCL)D?4_ggK&07cF1cR(J
;MJ3BRUdG91H@I23g6;_21Wa[Q=@+[e:SDUN3Ia:?KX1DG[2JNSb>GU]S]<^C>/0
QQfb6/N26MZ]P)d^YgT=:/A64F\d4d]BH45dNZP(\AeZ6CVg>#(>7[B?GWTI#PJU
VQM3T)XC2>c98.+HE?#WM78=2QcI7=dFTK-5_JN9X47Q..XW;,TPEZW:dQ4^LSE:
?8]B1#/CaB-6O7<>g2eD61g)+YcG3\YNYSE&E#HY-XASLHY3ZK29CIL<?:af[Y-G
BM)&-RLS?fQ2[P>WBAOU#5[Ng]>[]51TSH4G=3];--7(Ag2VMBC;95-CSWU.4:(-
_GW5e)TUB+N.L;<8HTR/=MX6RQ)FBE[aULD#gU#cA03gX#eLD\>RPfX2]FMf(6RK
df&4JES0Bdca^#:cZG?B2FS&1-e6T@0d)(Q5:1;MKZ_=;K?_bP_3=a:&J60#GE4\
+X+>d.WWUJ_\-1baO,UeK11Y>a)Q3a=O7Z9]F>9CKT+\C?\LCUT:-b+B;0WHE74/
8Y0b^F+)a3PL8T2bb\]<XU/YU?/RYIR8:/F1X&5;^F\g.UK+bgaff;LI.4LT<7WZ
C4>LUSF/I(:2\P\E;B,[[)62,NYI/^&Ve4FG[^7GPLVdRcOIIYE8C)HOX([,>,^N
?D#KcSD2d@e?TC#fGI5T<>fL>P:GHf?_9V&0I?d<E^Pc0^If)J9+TU9+.)RA12OJ
@])JKT\fGAIb4Wd<7&=\>cRBa]IVEU4]V>C=5=@7\ULYJ[3YF4P^)#\g8]O8aPUd
</cca1gA2Hfe11XX73gfZKHS-LZ](:2?I\D(C@/8@Jf5WIIQTYdO&OA7H3_[EJGQ
ae.)5F,V;^+gOa37(8/6C(=OO)T)S-fAH27CFU_/^S^1[\aD6.CB<8g4VB?fWRHc
WO@,]bdC5/]0.57aQdYUgCTVc,CeII=BDH#Yf;[=J5]&)Y2##2[:M3g&YW#1XNaX
<0ce8NA+^>SfQ(I_954/@K(Z<]DA:,?BeQ,4UC?&=bK,\^d5>T8e.=#9.T<.K.-)
-YKY)W[8Bc?KI/a0W_(23^/=28eK)Z]44EcBO5Kc?-=K>YA0TW:^Mg]D;-Yf/NS7
P,#P=I+VDH_.f=UY>3O8dNGDKPT:+D^1C\+8ED4N;?J3W#@#;OS:.26\OR[c40PM
Ia#0,]94>8&I(/FFT[-Q8\-1OQLQ]I;fF6ERE1,O+J&ZdECZ=QME_U3#>U_-9cbg
52+OYIf?J@@WO<54C\OW\.)9DaRDHDe/HE9/6+K.O+?7/GN,G>SGR4[K2>.WQ2>@
4AOIdf9&A-)O_19)I=I_A&>/V=36eSa@-d.=^g]&1bV>3]2EBeNY9Q=U10BJ5RRE
<3RHF[:^<)b4e)47]D,[M\Q@D-KdA[^22Q9^:88fVG9OQ7WK+6[;65&DP;Pa,\_W
4@74/YB/]J@23+.;BSgE&Z3/]EE:,DgfXV782/UMU]6X_93gJLY40Y[@1>ZZW9.Z
X8GY7IJ^S5M##N10;0-c?6]I3^aK4WG]OFK(8>9H+MEH^HP.Dbe_Uc/:c8d2g;-f
S^BFbfJW(_>DGH=D6)f_(H></N=Ha([?+P+6-4I[/<0SbVfZK>&GWecGfWNG][;+
R0UZ,8[SNcDCKM+Lf3IE4TZ#.=77cUK)A#XA#,]G9MCC@2#EbWec+[8E4Z?,Z00E
T:VS&QL[DCZ0^&X7f35fG9dK@>971Ic=26J>&0=ID:#gQKW:6,8?0Z(L4-[=.H:<
3DAVX]IYVU@4JD76d1RKF=:fNF4N7-Qf&:D0^(T^;TC+[+5(&B?.EY6cWXF9gL6>
]E)/?I7@,[RD/[7@eM^#,N-R6L^#L\P&=//D=Vg^#)]+,c^=[:E+NGOVP@SLLH:f
V73@S5\RaN5FA1(_@:MF]gL(e-2>SKDPb9.>ARXb?VSJ]V)M,K85,7UKV?1O#a?K
].5KVB]#.Q5WQL)<Q<M;OLJ:[5QHfKA[PM7\,UN=4[Uf)IGEC\/X(/QfVY(12E&D
C9;FB\9(5?G:G+\Ed7Mf@K(+\X3RAG\#T,-Y_M/]B&@NU,GWAgO<dNfQ_;=4YR>V
2fSJH\7K6Ua1[V)<fSCS:<DFP7(I^91ROLLUUVM=E=XO8\]\V9M?<T@S6g=fBP5;
[I9_E6<@;Og[E6;d.^?MNILLVKD;3NT6[^TUT<BUa/IHT_)M3E=Q83;=?BZU7bH?
L<(++]>)Z<;/K/\Cd??O4UU:-,JRP/Ia(+XUP<=N^WcA+6C7D9b4N7K=cNAXC+N6
YO1;XD1RLO>cD:(af7Q,e;Yd=>E9=F^&8ATCaDH^+EF2:#g6HSNHH:S?A_XXGYEF
bc1fgJe>)>@.L#/&N;VIT<E@49f^JdE9QE16Y=Q9JZC:8R-ZZ=PfbT-IbE4AbOL\
Kab0V?B_X5?0A-Ha896Tf#:/(?c6Z.K#dF)E.Z4WI-CIT)ZP.HgS?8=dA+9M4N,E
^4B?f9a,;+e:aM>4YOSafUTSfY(T2TN?86=c6b^LfcI9EXE#K34907&/./CU]ZMJ
3)+1N6]16Z]S8bZJCYD<YfCT7D&b5^BQ4dbIEN/C>^4;#YG9agb\;M])8V=\PP6.
Z=O1f3DS[R#)/CKFO4>:MKGKNC==A\O7:>UM)7d_e=DFS7)ICXV^DbZ-gdRU8,_M
2cB=&#KbfMPN545FHS.@#3A#:8HeMe(:09,UES<PCIfe=M^Y4R0TQcOP[)3]0#.,
A.-7>>S9\[<QXA7-BGP)5H5Yfe^c4+7Mb5dY@dH,75aF8]PELZ&3O@)BJ-SX=F?3
If4+<FTc-ORBI?+-dV,bX<Ff@]>)DX50/Q2,=-dRGgdTEG]d3KV+;L@&>74?;T(F
3V]#YE_02>-RINf).KT8gCS_HK;#1GIMZO0_3M-4J8eT5N3VO@)J+;_<+E#1.eDR
aa6X-Ff>+P_+)g;>cUc]Ad#2ZZFeZAH8HPQ@48B+AMP<\GCJ)MS4:6e>0:HF99B9
#PMXR=f^(2ECX3VRY_@()[SUdK6Z=dUX90)+:CfV>:2WKa0=UES:AD)bce42GOe+
e^B9FFB&NEa2G?Dba#3Gb4)c+cV:NJ+>GQ\^8I+).96AVPfSGAgLb]9@PFQ5C+2I
N.7E5L\1a7=VQJC4R3WB0(O5G2#JB(gbbf\b#d^VFb=Q4Gc4V>ZLg+QU\XD)+?Y8
]#cD-]+Nf,<U/;GGI@H51gOE03],IEP6SZ:RfgEcEYC(gg;&5K[D8Id]&X^JV0/O
Ja@_K.ZK:X&Hb-R;gCH-I,-IEd>C0FC/06C.ZaW2)eA=Hfe+X/BD]R-/\FbTM1T\
a6DE==0JC.?0f.K]#I#A-(@4IY(?A(c8[\93+R\YgQD/)^E=V;YTDMa7]W&R+cL]
+(UdUEf/NTeOg&_2+GBSI;\BP=Ua^>]7JSAN1RGE-L0fD40LU^?M4I@V^1:)SWW5
+a17_F7I<)4<Nb0b=32IU\6]W0SX05?O5<_M4ACTcgU[YLc>S0K?OB3J+_<fSRMH
3]F-gf?;/(NN#0PEP:7JS#WQd\M<6e3c/\:SZ[d#cX)c/&0<0EMc1:5[/gT_;O,6
?VDb@g3Nce<Ac/8a]E3f]/S/][=0(X@c^.6/;<aK+13Xg4?PG.)<VPP><+E1#879
UR#/aY/DIP5L&:A4+PPF/>.>J\</18FFHBM7GQ5BA&CX&(YMHXd:O,+\,TC9SMG2
.SS-a+N)CJRBA2.UfWL-;:C2-1Nf?+^g1c&N#[Y>LWbc5H)7Q?6&O3&T2G4fS=B.
e6PU&3\._eFI](+_<UT[/eL@(/9bJfe=B^P4OFXa1TN>=IMM3Sf_.>QI7#=BX:AA
9\HFB;@LbDLKND#We5#.L<V@1CSSSYY);<gPGX7;,c8-;SM0^-E-f<)2,:[B9]b&
Be<b[.&2Kf>W^7>.D[WD02AMFKfL;J.Zg2B3^eHgXVKDb^C@[(F/BYB26\Y38A+D
,;B=EWQ;^DKU/W,,6TV5^ca#2;:CTJgPNDMb]g&E=])_;QbC=c+Q93<&6cf.dH^Q
?XU[)3=<Qe:T6BU:K4N.IR)X?^@.MUNS1SgE1:&C#6+Aa>RCI4H<N.TFBb,aP+PW
H<F?[^IQAF-A=TF)UFA]A;K=XJ^@gPYM?.TS;NN^abY]FOO-gSVV9<P?dNHcXbAW
4-X+7QBf2Y^.<D8b\cMGXL^3ZRMI_=A;Mc<UA+X3M[)A]:U>DN]/cZO6^(=?=I4#
8AYa/+?3<:Wg2GM@fBF,_+CQOUK\e?LdD(.47Xg2RQ[]ZKBG8bWe-LYG\)06Y@0Z
L+]+/[<FB5943?XQgdbdKKd@\2#2A_WGFcM2_.[YE.@g/+V0P8F-ZMB^,bcY_(EU
36\&(,gKFUZTZ>9(60F3#5?d&AHX(&e;T&cUA6&UB<O9G/^DMN8aRNgN0D?F89U,
<[K=74EHK<g<cKb(GR1I=b4G<eR&?X&V6020^NQ2#AP-MOL.;F8JB.QBN8\377JK
A1UX^Ya6(MME,;4(^EYM:,0S7P^2[K:#eE^M:Q&4gfSJCGO]3#LB=Ee93P?>fef<
_ea^2IcUNg2FMe8PX;9C+>WBcFE[,f5_f-1RY2)Zf\Z0eUWfdY^:&(_TWdBWa6[Y
=e56b>J22[<S=RK],URXO5HZ].UX?.2c[eWLNa4JHb.D5?KK,g-,OB_Y8NYdgU^N
AFK^<6DF(@-&8[g_/@)ggR;(D25FF=AC:LeXbZ9V):QCNVY(,cO1Xed\Led(NSa6
-UdF9c84Ne:\3EWLYIN2DD7[])P,\gZgfJ9A9be:.5HJ0]&-2^()\66cJ\8-BVY7
5#0-J5O&7e1U8(ODXT46V>S26.;U@RP^;@7LD?2P6<B59Va=P\/Ac-X4&;K4(4PN
B&?>)@JP7g&,g#;?dTL<MT4R(6ORbH<T0OOP_VSSCDJ/HA;@7[=3248GCC.a<\H3
HPb)UfX7?a([O93K:?-9;/GJ+_;Y54Q7A:\2A(FcaV1ZZ3eD(I5a16RO32@QaTNE
H/UVa;A)CU:9/@CINIb]17c@(C]<KIV8=B47N><cM0)@3&Z;FNJc3f-)fP\_H4Bc
?_T[(_>81+=G:#5M#X4\dE?2?5/7c\Egc^dPL8UHJ1\)?2e#,HR,ZB5)]OE6WfNK
.P6Ad/.a?35BIC3XZ(P2XPb1I[cJ=1U(eM#Fe=eaW[Z_dU4_&\)3#^30TMF6S^-L
_QT7a,^F>)XDd0.2P,O(,ZZX),Ee=36_#c0H2>\X4T&\/TO)]fA\9=+=(7C41.,]
)Gab[MV<=D9;HX13R<D>e<38WAQ7H-,4TP(aTLH&MU=a;9:#);]>+LDcX>..,:+)
VCbJH@Y?U^[PC<<]eaNMNE/5AZ0TTF0a&\#D0=aK;d0E1>&_4>O(Ed=eI\cE18bC
#L/@GO8bDYNBB6JR.BD??&JY>/.d(F(a]BIF)ODbaTb)&/VMe+HEIYCRfD\^-gQ?
Kg\E:1A8O02TWdD,9,.H7R^dRb<?U=1@>N5F0cff]ed6ZO\b&aOUKQ2b6P(g=I>W
(XOOP8S3c_b\<Ka(A+NMg@#E#[;DDB3g_gfXSbgQBD(DcD^A^e:2cF)X<V#5NZIU
VLYP?W;9D@T)ZBFaTA@@f2L<?P;BUcYW7a/dM:VeP0f.e8I^X1PLMT<\(.0DbA0@
:V#J_XUdF=f875cCR\RLC<X;DXPOdAQ;ERdI23.9\EWCda;R)QH_#AEX]fFCSE>I
1_A@-gVd>Q7LGRMaIg@]4g4O7cB07[4ULP9973EaRf8GZ;-5+^a\9H,NFL\OS\D-
V;dBBV7]/Mf5g[6)59cYTI5^QV332DY<_/#2-M9=Fa]K&_+ef51A(a>ZdTf]@5;&
B?fA>UG_9K1.>VA+a\-d2N?fd+RG0RfS_7/BZLQP<9=D2BJ<I&Vg9#,96F-@95bT
()2OZATJMRR,FeRE[f+V-]f54@MEda.+U=O^[]_5<Nf.E:4N-gI#&gK:=V;0M;P6
-6RI^S83]0gM=T7fT66g@I<0CKN/&dYf(P(-M]JL0Z#2^XJ1P^,N0&J09d7?T+K9
b)f#]Leb^4&_[48/SgO6)7b[YERETea#MW)-4HdQZR;(IBf?@J:2QJ39UVDH.e)_
8.gE,QEf-\VF34AM7]NgZ]Z^X3V8b1@a0_/,d?=IC\HU\8/W)fae>6HNE1cTT91P
;N4_VJYSV@aa#US&b10T)FZ=KaSRN1K4<2PRfGOQSYb=:8X<]7X[bT+-M#8,152>
7J(8[C+I5:2Z]#[d=(GVTS3NQ@=X];=g<T68E2L<dFGC1,E;HS+;)d,S/FVTRJc@
^&J</YS=dF5=Q)4QC0.Z,fC<_M_fKO8FTbdSN:YO\T2L]7+A@dD5TJ/d#7ODM9H7
XMKR+^a,AEd:22RL0S]Z2Z2L->U+)0egU;MU/8b0+H9@]#<FZWSPHLe5,)@Z;AF\
g\?2<&6/5K6(47RA#\44V5_b-f:NF-#aI36=5HP589-5Aa,#PXYa1KNSd3)/F)N:
/V\dd-fPbPGV<H0:F67E<B1_QgFdVHDc,NT\UCAaYdbV/8B4SC..VOFAAM4?+21E
9NI#8?g(WaN49@.+R;4&7cF^IJJ6/7+16I;=_f+^7)^e^5C&ITZ7+FPG>4P/4\f:
M#NDc7AKVI^K>00YM.[Ue]>+dOSAZcVPPd/X2:=N;[4U)TKBNf65K7-3cDE@NL7Y
&KWWMK)L>7X_IXOU95;e+HbUPBHM5(=2MEZ=d?E2>#;Ed+:<7UL<:P1N>4=M-KHf
Y/TbQeUG@RU,e9UcO6S1f:KX6eI;\)&C99X^fHE/7W670(U)FY6=#GgGIc_dcJVV
#G]F4=2+6DD>#W75f_>_b)e@&\4Y]F.HB.@3M&+[G[GI22<>+/B.QBE&fE;5GW&U
KLU\;@g^>:SVU=aPMeRd6?L1NSU.ZdWOMW[E:f3fKbG7f]M>)IYOBP_QVA7LeKUa
eATKOaY2J#V7&Gc5ED)MC<:;<2>)?;VNgdVU1&7>H;K3bcQXQdR[IfTU>5=CgX^[
f)aNTYT,2#U#6+B#4UVT^Fa_bg(ZTD5T#^VT(79-56]:GGMH2]0C6EX1.g84V\a8
D7(2RM(e@NM.B(C3C]Ed#b&?f7IVF,XYX.S:+b.fK&8K0DRJ_HM5>1Y2V9ZJUg^T
>WO8caFU?Pa+O,3FdXLRZ;0e2PW43>A7&e-B0E4G/U<&g92FIfeZE:>@MbUg.#/-
D&GX3];1V/#T8bS^+;BKc@2#<>c7R?1Z;gO>=L05-GJV?,@g+0+Ra[KP1U#.#3W6
RSAVe&1@;+H2WI^6H.#Nc)E3,cZVI)W&Wb-Wc@6/64(]JY/B(KWIQ8bKK\d:8?JM
C@R+dC3WB-N=E1bI5Z+:+Je)]T:L2S=+V5QA+=]TF56H8dZV)H]-KW[.;L9f9>6X
JB8BT8;G,EA6Ve1aJ.(b[[W^S[VS3egDKZbb;Kde.a>MgDNUHeN9bV+eE8P^N::4
3,I:e#3D>/,25Z>6D;X>1?N-5A-b&U)G1O73LQ3TD4XM&<CF)B2@3-<#Be);G7XK
GICB66R:ga#7dK:f6fAQ.<Q:1U0N3J[g)I?&U#&f4>O32R^?#7DI[[d79M[C_aaU
K)3@J\:;,WL5-M>g8:89(JWM-NAS7_gC^NeCPdW<1Z\0;Na>)C+5;_:;dG3DLX;U
IE1a3/SYZ#G9?4J6?^B[2GK<EB2,H#3LJa^dSeSD(DZfUBa,)F1O<QDA-4a(OAR<
dP[G0?e2Ef-a^@/NMG7_:DNS/9YC)5B,P&CYfc(R7+\g5gP,ENGU4dLM\Q@R&3XD
&FQ9\CMCMf[1PVM?g]0(;M,D\:Q/F]32SN_K[8NR0SU0]G].gfZVdEV6P\:WCC]N
/(0;JFOR?]:9\UV:<.7=:ZV]\?4H8Q:6[F]\996L[PYeIPWaAYU7H8;GXZN]&D76
+#-f3J)JS4d>2gQ&&G:4;2T1BJ0G.g4F_2<0FA]:af4.JGK-,BJJKe@<&TVYC?Ma
UPD8MDd9\NBSVIR/a[TeO?U=a:(JIL_eMJK#5/R:c:C]e=8VYS>,E15FD;7M4UKe
d&_9-dJdR[31?D>S]dUQVT,S7fe_IbU3;SNS178][fR,6WC#(Nc=0_PFG,,02LW#
](gM0cX02]f-OD/CR36SI3\82X5.RQ^5BR7+c([9<Gg@4&&G0JV4+1JN^eXI_S<[
d(^/)7H]D^Q7HX<1/5SR(&(37O:N4NRL^Z\^5)<PX968@.M?:AM\065B9?L(@9cc
cQIL/71\-<LdfZ7eZ<J8NC3UL\)_/)<JTF?&>=-OYCY-?.95[?PCXW()Q_&:8fe>
L^OR8fN8>W;B[f7=G#)174Z2cDGP[c=87_ddS(7SNVK>:d59MV,XLBE[-XL,>+2K
V<\JPbD@<\e29GTEc6dcF,]J_]2?(+ZG#;\O?Pg-HCE&[bU&)c(VdB:1b8(HI\<.
GETW6;_U-F\WX[::U8AJKWCO9(0c4ADWaNST5L):X;9_Aa)@SW)VKc5\SZ=eR>YI
G.QVAff1C#)VPS,E=3[8e8bZORNR@:=P_bM7Q1D=3daZW+UIA4G=Q7H1)K3c>LK>
(deXMdDX76PG0_ad58H_aN]_VYBfWV)Vd[3]-9Ga8(KT+N]):A/6RO-WAR/&[EeI
a0NNJD.LF3L;,?MRJV@HD8G_TAP?e2g)c,IB5E.HD3/AV#\9Ca]JdOIEdIfCWQ)G
#0<YA6SWAeX[,fE\/4GWTDEYeD,RFCN:cS,^[/IKEB5dV0@KPY-J0/eS@V>6(,/O
HMOT_QLF\]#1B/.+)764aD48XFb@X19Q,;YTcW@^dRU]<KY+fe-YNDB<B8E6[Aee
cDc0f1K7-E[;NM>F92M.BL[F_FEA++)9:JbSbO=0HYUFe-GJ5,?:QQXOgE>#L(W_
XK:\RFHJIgYAde@Y<K=FD=8I+QVNOZe,?6Yg#JF\bY_2)^\NF;JV(O4:()4R&WW9
[E6V]CZ/DPO@3/VG(Xg52>W1TGWaV#CKdBSR_@VgS,B_I,gN5cg-RG;;R@<OC7.U
SJ#5K^R^97:F/IRe9XX8_61GI2&G\6/>INMf&JD/8DA1_IOdBTI&&d.>#.5498a1
4@:\TV(3)#Vb60.U.:32S=S[+N:D8\G6<Z,-FPf3A&&,AH/SdK-1\K45-YZ]PU)R
W)O^68@TL2c>=6d(^W##bfO@L4@5VS]dc2/^CRH>/&@]\?3=?NCRR&P6?^d=^4R[
c@<P2&B[8Ac)=f_4(3<;GW9-TVC^&)2>EQ0_fRU7.)31]KOe=aWEW3[P:YY_<#gX
(2YG:Zb-?IXOB4LL-?^,NE;0[23b8#OcBL3\4GbE54@#AU4#GDT+HA>4H?\.[4-C
2dJCSY4W-1PCF1]\P>[eD7B8WNEODI_>15d_[01D7=@d/7U>b?/./MbMR\;0OZB6
&KAE+U_3>ULLG()cAb2S(L9XNT<K&e[7bYDF\L,S>&XB-G@[L\H(Q\\g#fWKL;E<
c0d86HCHAeg9Q)J4V^;P[CQ8/cXUNP2@DR=/Vc#.-XWC>UAL:+DQ>W16WZd3-]<Y
df,5G/=&GO]0-d+Y5^Y[^[:0A96UZKJ:D>+\WHa[BA.eNMVcSNR@F)\:e@6&TI+2
Z0F8LFY4?N(QM#aF^NHEFJE-)bFGNEC&AR+5\OJI>_b(0-4-I[HOMY<LW=K@7^?G
88K;:CPHf#:.#OWA#>5?WO3DM.P4P7(0WCZ,fK]?(OJ3<HDD^_?WAOJQC/E2W?_+
UH;WH]&@&9/TH45:3NZC9;WD):aZN<]XSPc9FF3_V\B[QbUd:6\^?LeH(&9LMFSd
V<g&B0DY[:5QNZR==E[=1JKTA=Na.&gb@6+gH2C4@=C7c4-d6+9eBZO<VAOG<7K^
YfA[ISWR6T\77J];Y3Ua49K,,415DJb4>Y/;X3;:2/5.-P3UIeT#^-V8W]2\^Tb#
Y0([);B16\_=C2d]K2O(,@INO5b4+/NG1Y]BRNT^76B3&AH_g[.627:J]1?<ac5>
8IGN95A#]D_ZGFC>LcIQfcDVU/MGb3OaAT,^4PAZT+TFIYEfW/TF84XIZe59.)gT
e2cW4FcQdL#=I8+TJ<@A]SLJ\g)PS;BTLbNZVQWO1Me9I-80HHU62Z76QJ@Q)_65
#4cJ_C5b&E&d#-D)X^M=Ac_L81BZ5^f>2a&A&=8\\H>]<JMXWRf9d@8ISL>@B=[R
Rc)5W(Y;232R#>4>Z<=U+?Ae3_;U:(O_VHN^PR_(3Za+NJGc76CG[-a/dJI-:>\\
AM/:e66.0DS2<-)A8TDIDPd?^FSIR^+L#^0NYb#Y(D01W:=5(b=1\[PSSS>+?gI6
aXgg>,YA<CIS;@:S(CT@\aF@)?04GXTIW7X5+&I/R/)Lf-K_9#T4ICGO&#W6\;ef
G;Ga1gH9106F3AP^Z+#A\WXV2KX#&8H<,B?0Y##b^&&gUOf:YJb=[XJ_\HDJ20EI
.W_TA163^6EUD.3?SID>#JTf\=K10U#)N,G&)8,7\N)A9V1C3/B4>8>/e:WQg&0_
_#M[cB[RFA5MX__1?ZD6IK7;QW;L8@8OA>&@??=&CeLNVTHf4d9K^36K[8YL=MGa
4,(TG09JWfM7A74?3DZYaL]GT=<84@#+OBL3_:(C1Ia+c19b[P@Q?A^,L\U0a_<D
DA,CY(T4G.WA#&TcT]?\Q&2]/e2B+#YVH]YF^)U_U(@bH7Y/bO[2a_0.:Z#7E&S4
B#9DJ([P-&NS7@P-@IX.a6e\^V0U;/OLgCZN(g6N(@M,VR>X,gBB9b_6VOZA5PQJ
gQJ9U\@4RMS2-68,B9B0,DGOUHba_eG/OIVTJK=3PeT#S-M12=@,)U:T>XV0<>5E
bM89NO6_A1aAW(M:(PF2X?@8C+TBF6\3^0TQFT2G2T9EP>^02&C[<9+Ub^P##T?9
-R[g)H7NI4aNRd.ZJT4H&;)6=4C:?ZE\g6VIWY1SIHUeZ+]P7L+.LP,_3+GL-)\Z
Rf>>6BTO&R3G/C[caD#E_Ja(gNgJP.4^(O9YP)f<fG:>?T6\KdM>:<e^;I,/LD>I
5#+OX,g85+AKR4E5_^+.5O8OQ7R=M_>7I5d^>O)VD8_fXRdacOI#.Ef33(O&Ecfe
>gA0b^O6KJ>a[1EEE7,-d.DXZU].:EfQO4WNIA=dR<5[HP;aL6H(?#?f_::MLL52
2FG#\20_fZf<O5/G]G:86c>5d3S\.GTe/T?JG1cgV?+9^92Udg2-+N\C9QPLC\-[
K8_2)_U00[KcOLe?@L3M,cP7G^T6ATK<4V]+4YSRJc0Y15#ZFc8]@-M9G7YI&]4O
B48e<)-#&QU3FBZ:N[P&GKb@SR9[AAWCF?1>02cMEWX71EDG3Og7Eab@bV&&)T9Z
:V[4&@2MG-;bU(>J3b/Q><If>AAI?541f+GdESB\SRZ4Z7WI/f)6ER(QA_D99Q9R
@bcL?)F05K6JG\gBb_US&.B/YR.dB-[?P6C<#\gg(04YF6]b2-WSc:OK<4<1//7>
c>@[d^<NX8B14Y;)+c#PGC-4E.+0Z0^gPAE0EF-Ua7KIK,]#FTX<<#JW74<V7PZ<
NEN#)5YdKQ,2f+6bG.O/UGLQ@.69=Q+&gadYIDKCUc.#>f#+=@QZH9[X:,]1AUC&
C6<_Hf]18X[8A]^.A3d-]7#Zb-]TGYAD#Z+3PXT(T\U;>]eHU&U:P<ICQOMHC)93
V(-_)RB0=<7TL\L;8JeJ-;c>UQ3(Xf7+C7E]Kc18b->VRB:)f^Se#J5>IacP\=aA
aPbELJ,9b/;(7Je.A5JVb42]3K^AKJ;.d&__S\B6]+5faS=QY6B310cP@#E/KD6)
/\OJ;5]^LW-Z;g&&@=DXUN)C^CM4??2U0EDacMF^,;?S<P2XWS_A9e5+]TXYS#8C
e9K+/V&6QL/:1^\#<&CQK/e?4de4PX1-^HED.[79HfYSc8=I\MfQ9#8N7<HaRec4
HgZ:La83<=bD?_BG#-1[./WLb]WJ3188I=1M3(+E>2S<H28\?=(c?-T904^HKOF7
W0#gL-4E3aON/7C)_HN]Y4RM)E@^)MXWQVHDdIVS)5R394GTcf]5<X2-FKWW@dId
>]^3g7,7;#D?bQ/H#OBHQ).7@#0HB&A+cW_gZ7/7VJEP/eDM=I7QE:W23TDZ:<EK
G8/LJ#-:cG(60FFR3fV-@\EJV.dY5ZK?a8[>TR>K1g/eLKaFGd.DV?[/B7H_,NY1
R3[TZ5@4CFW2Xb_6I:<0;.M9(g;+T5b^c6.RB<#D^;CT0V(..+L.Mf@603;#HJfJ
d<:=5-_A#gA.@_[T,=[B+,.D[ATIOU.-fMN<HA^EJ&?Ae[LTSLd+G3OLfaH/JfKG
;)TEAZ^Bf6,]6-.SL:LMNM\(CQ1<3<MUZOYHX]C5^@O.W84Z-[I&b__Ag2(:9#cA
[U^c+Y7fQC-QBJ?4@39TI?_WF4W+BS_[4gOg.)4Ad;<;dCU.\X[^FP=G1c;/d,W&
VaPK=]C;7,.>W5f>CRF[[3R[c@fDU^26TcN7E<7:de(#cLPd]U)cVU_=P#?,Vef7
U68FBT&CCWOe^NL[]aK^A45ABGG<\1<D_^PHAGfAbab/M3UZT<D)G[//:3OTgZ;0
W0U\M0N6JW+=.eRLWa3596G.:-He6)4RQEf:12,G.IJT+I-4PFXdVW2M609^@T5O
YdH@eBXWO5A6Mca6YM?]\PUDD42;(+YSN^+.ATbL8-N]ALRWGJP27]:f>92=Y\9@
)O2Y,/=:_gQFdYXKSE+3_AUD^;6F\4=F:]R<ON6<X:0&QKO()--?]g2]>2S^a27g
c+:UTK]1>)B<GUYIJ5YZfL+1B+S9#,SfIaO74S5Le<Q8aM+WHOK9VeI>5H09e5=)
1^;RC^G-HK>F_)YHA/3,3[LbcGHRF;MYR[<5^W>L2bY5e.(;e2-BG:E9H+N8:^7U
TA>8e93UGM+fSRdP6N/1B-6&\e?5Z<^1dZ?gN2[AC@KC&-P60aY5,MYdDe:ZLUTg
Jb&a(?#TC=dKPNU?a@X-N._#Q]68.D=\+eWL4fUGaJ);ESKQ41d--.<-Z:K<d[@)
6g@7HFV=KSbgI,+B)N;WO_H?,+^V3]:ZK<.VcNAF>FOfU5ITEMe>#PF#N?.UN@Sd
)IR&LVcVBAJTRM[Hb>;-5f9d(C)3ANAK-[ZY)Y/[:33I-C]0PI[5@Q4JJGeO[^DN
K>.P.bQd^aSH0)(3bW1QX=+6aVMWgRTYPIGN]:V;eg[R2>I&KMC(E7H1(_5R5,Ba
]:OT@La^KWdBSCAHTH[&B;N6]b8TG#GBY6/c:P2V.YAVGS.O[3;TQ)@Y^4B<bU-e
A/ag@:4__,;@R&;/IbOdQLD)I]#A=#=O^_&^g:)fZ]2&M\(6SDC/ND3NFA0SHW(a
=L-TR6DJQ,bJWVXH]XW+ZQK?V]cV.b^+<IM=[K3eQ(^\-3YG5B#DS#__Ha-T&KVb
R3cU)9FPgaSJe,\;gQ=6KKUTLAZ599JB/LdZGBZ+5HI_:;IWXOg#XFTe,b07>EaO
_(c6P<@=BOdA50?2_Tab=c?O/3R#6TU018BB6W:HCB2V1#)Z,RQK_c)gc?OV)_97
a?MN^1NN2N].:WPW@K>843CNZVa?S_LE&W7[#d:Ib[6P&-a[8BV_9&#812VAG90U
E<H@K\O34gVe6cM,7d\[=7=DWLTc-)2#&4^AO[(X/\0&9X[8<4,G[SN;eX[.,g3[
K<NO8?L>SXdR\Ef]Z;SDE3Xgf,IQ4,A4;2)[M+KX&.0N2EYW-K8B#-[VGLNTF4<X
V=[RddV,DK8P2Ecg52MTXWe>345<C_LA4VP=QP\N?LcO7;P,eg#8ICYP,d^e#0bX
)E9=bC(a?R[7?4SBcc#:3WdQ>^W6+UW<eNT/U0C]-D]WEa@CQ1F3c?eNX[0deN&b
aL@R/Y#DV(W+eZQBgSK-Y@:R#VQ<3c/[]/7\;b05Kcg_^FXKcfSC@ZJAAK^UOBa;
O,;b<cM]P\;:4Zdg;ANH;^(0_T2U49C4cM,R)H0<<f8L.1<.K?RD03R/ZV+e&MMI
;+gQ;7PS(e/DRQF=9BSKJ_fO[0\5XX=]6(P\[R<5T0LUc.]BU3c1/^L5#A0Ta;.;
A=+P,d_7]#AVI62[I_7H?==2Yb/HbR>Ae76X,D)EdO1:e#E<)a?-R-I_8A5+ZU:0
GXJ;E0]ae^R@=^K)]^=)ed)I:B_3=S68.cW(-F.Sa&/bg>@+P0Q:N(\e[gXc:?Qf
+f]Uba)/BY8Y(>&-LD37CIX?[B_&(8\NSeJ4I_4=W>1F0I@T3dY)L_f/H+3U[Y?G
W[2Y42.MBbab,7d@-RYD2@D2#PMLIdGWM@/Z[1e?73.A6Be6S:;=,434_1_DMHX,
R?._[0ZeB0Ta3[-]VRQX8>5Lg)Lb(Q:c+M^0GT?<2B+@@36Q_0:K[=C#@R(XH1X@
P<]:UMX1LGVgGgc2E&D4dW9YFdg@DNfY[SQ2/(E1]VN5?<34C1^;X34bA2KP2X0W
F1:BfU6Ob?fZ6L9VPf?,_T(\//.+6\\6>YF@.Vg&Q/(LU.DXbHe/;=4gZJ@H7XPP
Ra6Xe9?<YG<fXdL<H\b0;A;EKI<(>=gA+A/H>aD&d(Mg),]]9X2>b/:.DB00Jg@I
+YV-9=&,@C85_GYNCGdZGI]<HN.1VKD/TRED-EL\0?JcG^P(f.S_gQTc4@01NfWG
ZE,aBN_a0;=?f:P0A)&b2]H^TNXQ4?//EY#K_5HB+..9/P6)OfM6eK;SC>]V8IK,
3E9gbWgaP+7^6#^)[;a[?)V32C3GB2FN7Za4[EH8LbSVL#SEIIa4YbeVU0F3g[W[
/IbZ,B?GK6\VRL&=2RGfT2Lb)QV^QA-NO,1)UfIE657#)YD7(0AQU?7XVWf@Y<G)
1G0]ZXDU5[-#8C>NNYSf\A3#EQ,HCZ2RD)\K]H/M>52E?#G5N>,-^3gTAU,=LMb\
6f^.GdRZM\]V22a(1L2YB5:7(L>P\1K+]_F8?HP1gR50H]=XP@_B5;AEbcLfZUG,
PG[XX/Id(>eY<f-<SPcZe/.]W1a;?X<SAWQQ2d5c-J8<.R&<<,SBTKA4DI^,PGg)
-<^1HGV^,&70]LYY_HI>)J>4Q<ISBT#UECF+4H(RNCT#6H7Y[HD(71KDA:D;]X&S
8--JLPEb[8DCBFM:dT;YU)>Y]IP_Z+2&EYR(dM0IPH+MfV<T0,Ueb>\9bdEbE9-H
LJG\H#\1fW@Pf=P(cYE3b[Tf_#g1bXeG[S53DC8M\7+\NR-N5D4R4G)J)2a[#_L0
gEcHf+Z]=9UYI>(-AMP_@cK?UNbI3JH_f>P]=gHNASBIe9^OLEB&d7fcO_f6:G,]
9+cF>SV9>Va.+/E;MT=0[fRfE,c:/10dUEd=_;RY67Qa]f18L,JSYd#fE2VXNHYS
e5.6X(ebTA.HZ=>cD)B[??H-9I@PYf<\b+OYT6;/d07ENSJ.JXeF:@YaS<@LFN(N
0aedU.S.BaDURXbR?;^R,3&-;Ig+>(,dBA>Y7-PA7/4Q5Fa<L)/5R:^[2::.C6Z3
D3cV-@DM-@6G),e<U4A&^2:O&^c3]5Z.-eb]]A]Z/2,ZGZPF()6e6E]<U6J0NJ]E
C?:R87FaQFZATJ4daA3K.AL31H52E#AY3R@-/UaIeJ3:5NMOd]UK\N7JV-CK47:\
7;;]Wda33EVT39NS;BcQ<fN/R3cg##Bb[;QC18EGO_aASg,X6A+,BR=2ZfNb<VD_
O\c)^U05bKZ[MP\<Q0XE=JL,_2D=+_e^R#F&_3DI#<=O08/E#T]PYJ:c[U:aP_/Z
bXY0)99;\c.+a0AFbVeO+Id?=a9YQF:4eMEZ4Def[4D)()5-UEeOd?RJ7c,9^a]M
BBXO.4&B3[JGG3IV@L4XWb^cNU6CW/4)IDgRY_PU(Q?+5@].&H=+RY<\LB^2K(Xa
e(6e,FB6_3/G40K6UY?)eFP(=,2HR4E@1+T?31Z\gA()FZB(0PXKJ<EdQbW(T=JF
a+eHb-^VS9fV[3_:TQ[9&UVX3+A@gRL=#a2gPFO,S8&M8(&JT03?Ke35RFYTW-I/
QH1TU7HUS(@;=7(gLUc)Xa?FIOY5?&]@f#YH>]9LSO,He)#CHbIe2&bRLQK>-JO_
93?RKT-&EPd0(L#;e[cP0(YZ\0)+@7/E<;Q[9_V_7&6>^MBV=W)+OB@GY9(EX9OW
L5gC:?.=NFNMKN><M;d59V8C8Da7)=0KA@b<5O@f@C#d&cVa^O@Za-QD?4f>R#KJ
:AVgg1fDM/P]OEaK#8beK#>;O)PT4;.2;@OL+M3<6CE9NNL01Z8Va>4dVLE4C=SX
;1)OL<6WY.KLcIW=Dd&^?E+\0QeFHb804&-_5/;bV6R@H0RGRBg@7&\Q?YI+:Gac
LS:f+ZI4#ND.=?WFC.50bM=,-@@JJd\:HYTJeR14ZEO-d0R]3JU70SA>.2MI.:NX
bO&3R;JQKc=9D,[gc#CMg0e5_@SCce3&22JLRK3E2@[;=DN&5_0));O&XH_ZXXTW
I4>>3400\Og1MG<Y3629/S#OJD0dHSCY=8W)Ddf#6/&NT6I_S1beX]+5=.(g@>GS
@.&Sg?;&]9_K>ME\^d?&U2-?+X+.@EQf)gYE1bOYc?3#0(.U<\g\94a7Zaf_0Z?U
Q&WA8_J06?Z1Z(==P3>FM2L[fZ2\H4T^LfAf4L820M[P+EB0,ZD,cUE]bHG8O\a7
#,--@1O^,>.3SV>;#@TGQ.P:LOJG@K&P2g8a+2XV(:]F/>Pc#@UG.ICP[]SWBH(J
X@_J7?eG1-BC,G:<3?Q_;+@g?Q-^I;UbB_UGK(c=MH1Q(X+e^6/\.4ETa/O/[#Xc
BK+K^\,b1Q_<G7R(L/JPUb)U?0\5FF[,\4\T?<^D-KVL:JBFbG5#FZO)7c8HGUI[
:ME95VVIWJ9-9+(T:<?YD<gA3Q_.5TO9<_ce.daY]e4/]O.K_ef9bAQ[B2>.eN9B
TT^#4>ZE[M==d2-DK/6RfESVQR2T4dZU;/#Q/[6b;8EX420]2;MYd9_S8S#=D)fd
g:+(_.X[:FC(O=?GSKJ=)>X\D:EG,H5.:8N0Mb0/E?MFcS.gGU4g,2-)NR1Zg(B6
2@NRcWR9[,^I8A9>[2,RVSL#DV4U#gG&d1^TP0.K[+:V-dAbgY_N__g8U/]RL(3+
cPS0DVWT&c@J?gd;OE<0.2E^+(K)Ka(?D[78bQ>U^_I(DBXN9^aYB7</#acbJbDB
4CMOHT&PR]g:V=CX3LE]E2>b-4[_\d9R-PdHfVQ/_BL.Q@_5L<2^UdJ=cM.-@VBP
?JWH22<Bf/Ne7VbG?5Nd^0P_a?E?;II#1-CRIA31^:,\cFC2-Xg##+b@cVb+7VY-
FE39V.^9_C?>\MSW.g#,O5&-b+A47N@S51(_^SdD404)3;\G7:J@eBUbZ55Y,Q+C
a=#OeJ=GI:G-#YE1DD9>MZMG9fgCGY<BPRVbT;JU7/8@fV7I/KGUA[CT5-9UJ.@+
<^(D9gN]\0cA;[4ZZ-W,GW3WL.e@Lb=.JMSH>N7;7Y+3_L3/20;(=PN^/8aTY5G]
@]U;e(QDF:6)]]EePD-FaIT>_Q<B&f>c9^YRO4]1\-L.Y[eS>XWG[1,,@Yd43Qg4
E?[.D3AF_F@P&<,#Z2:3?8WO0F7Og)e;_;:L=MZ/C=[ZAbU--9^6?R@;#OFDQ?PY
_)0+LLUG\JJ3b?;KI5c0P,]UQNcBCM>H.Y7TYc:^eMe4VFbQ8VeAdd??9?QFT135
O)#?^,BWK-UH2ePcOKD82Q6JTffGfa@ef)B\6\Z?G>-+[NQ<.Q?PFH<8bb#DE,2S
KdV&X82)-,/J-:&,C_A2H/KWWd><OJ6=<0RC6b)_);6,_0L@>(8),OJUA9\fW(C6
P#ID&(C?R?_L8M?E33J+\:9FZ0FBaAc/b2c98.a;+>:7LLO:GGD7;Z4VgHc9;c4_
&<J\-UD7DU:D2,_K[?H,HFD,V),H_:eY0YQ)f4.),P(X5^/g.4+1XNWccDJ46GdP
R6Xg62d99.)Hg=)FDFM2V,81-,-=]b7ER<=B+V[Re@P>e3N8K^_-=_Y:3:/314U&
CB&#/F06Q.PCaXI1S>XBGaA3Z;&QFJ\XR:U]28JN?YPO+WgM[4&Zd4bU]gOIWQM:
.45@Va5(FPa,VMO\1BF@B?,.X[VD-Q=81M&D(0c;HY1ga7=-;1+VB/4BB,--V-8f
/;MNad&DLdIO+6SffJCTNQ]E]a_48@f0S&B;S(6E<AC5I4B0f?E6OO2DN>/B7E;(
LY72^SZcZ5CK;=8E&0M1)CN&Z^3&V7P(_B3D0:RVY0CJMSZ1LF8:-9_P&_T?2U2a
ZZ@M\\S50,D,)S2@8YUe:APY3,0IYM@]J;S=2KF]ZJf/3fD<P@c.)+65XE(3/E^+
B.PT88Ob\0[J<b9M5Q)<_^1XN<31IG<N-Y8M)aYPOJ^9]T4b-U\T+cHQL^aV2gDM
1AE^A4DIV87U2#JB#S0>=:F/(]R,LPD(b5-<+\_cMG2+K<0:c7@76?/\O+FO6DC3
D()TU2cE[OG8Kc1ELbHZ>/a^);TFTU8,=7PVXc?/I88Od:a16-NI^fV5@4@=\9&1
IIGU0Wa.a\/g+8W4T>#-;/f&6bE=Ia3fD6H7I2D_MT9f1;E1FLM/fZe0<b@>RYWS
EfGEfG>6fF=cG6G1LGLDZ5b+3Y=gB,+]?VcReS.2;[EOB&5G:M7VP[f\.DK#K#HL
<Dd-#2V1QC@d5&B62>XDf&JLgb:.RI&&A][I5Q<2IX63Pb[ET:a9bX-((8,>=4IX
W^-B7AE-NFKC-+J)+,W;eNg5<BZEI#S]5,4]+QF<E0[@4]DD;M]Yc-RHJFPD2QAQ
+:;P>S/U,XADg9O4VEc/+B7)Z3a@O#::38TKZTW:fW]b5/9W+P+>LQ&_LC,]0Je,
2Sc5Y3_;M-KU<PRX2A)-<YQCQ@OWO-#K(.>OP\Q&+I9)L@Hb,GdJ7e8Z\-@.(^RT
AS#XK]#@)7[.Oe]SBF68[fY>.HN\;Zf6[ZX\)c]SeLO.._5;X)[V2e^G47FMO0G6
[[.(YKC@_N4>NJ+/#dI0AO#g[#V+F1A56&>\LDJ[[/,T/.-&07<T1-K@UHT8^\[I
_TLQ<BcW+ZCf.#5d>NWV\[8b3>,\d6fJc37([JgS]Id:ZAXP->[=4\f<#E<-TY:Z
AF)K0#-aH/\;B,6;YIM/_;?;?dNfN/c,MfI2J<9@6Y@O6RK4()AVe=]JTIaBg,82
2PGNCb1>10;H^I1R<TTMKF:QK#(a+;];P\@>]c=DA7)Q7V#;6YcG^7-eI^:H:MUS
S==<0IdG)92]A.GQ.?HU#@T=&c\\6T=5EFR5F21?PdGP\L7+)89;1H1\9JP&6KSG
gM[WI884]9(O50N]ZN>W7e]INb.9G)f.L]/ROccG6&T4DZ?2G-_BD1Q62>9A;M8;
OT14+9),>0NHA3VY)-6GP1DR@&1Pg8FU-Vg;ZH(Z-5IG6E_((G-2,7FT;BU,g#fG
f\I3g97U^30&@H9[Q(K)RJc6-M(>3BM:,;(8S]aFY>d<SZ.P8S,feSN-^3GH8c5C
FE6HU/0O(D#6[@;=JD.8++g-2P:0SNQUP\1YD^<6U.\\\BD#3)[H,1W7ZW=.,215
Dbc[fMT&7Z=H@;RL#YfN>f1Fg;dH#6_)9.#K9.=R>g]WEB?A<K024/M:@8?#<<FN
U]4d7]-O:b:)TV1PV[a7LIIeP.KE9;=PWX[bOP0UN,JJZ\Q+DM3HNaK?3T.#YE@_
BYBS^IPGSWHU]8UNKK6HeUbY@30AP?VG&:Q=AaCOQfHA^Ef@>MAJUYK298Y&c&1#
8JK?[8FBTSTL.b2TbIG7]6_eZ+N:4-Da=dI/?XKNGEeG7,?#F5VLV,=P-^D>KUbH
\/D]7N/W4\Kg(MN;9P@JA.-3K\8^bcS-S>V5PCYVR6Zd5(N<CXZf?B/;6LGCJf+e
3e?S,,QZe2GZ6\V9eLeJ6_Fb<N)#<.\<dQMCBF^Tec=G7dCg,YYEW8(N-1N)\fJ6
IWR7^_:KadHZ;)&^@WN:1^U<ac+IaZJb8J);/\:^2Y@4OTQYM)F)[dVKHF7SVC#]
,F7W=X1JQD9SL=,2,a[)bI)@#FPG.BS2=2AIbI^VRQ/H5dHGR?T5Y4D(CRN_ReRE
-f-\@U6F6,Bb:A6(_WV=HKCf)H>P:,LRg8JDeQ\ULWc94Z+F]S_&eE.Na\\3QP_\
)G)bHC7DRJ<cGfY\F\.cTgH9S7b<E2A@&@F2.R9c?CTYfUN8,ab47YHEJ),6ZYT&
WdF4@\5Q/V,2)GgfNa_?<[2Mb>GM1_.9>TYR?cD;=\M0OJ72GHE7Z0aSQ.N8>P0T
YgMCO[gA8>N@WA:.-f[e1R3fb>\<dD:OVBU3e3OH+M9F>d=dBKL0gf@LATIUAF7d
W>-QMQZFf6(d0S@QAIf2WQ/1F/B<->_2#(8Y8&6AQ_-Sc\MB-/7V+N8V[CJB\(g=
:;gc>>a=PW<FH3AgZ+OX8[R9L)f;JQCCP<PB(UE/1[2/dLgbTDb.4HfKD44?<Y9#
9MI?DgOT5IV/0FgJ7gV;?^929C4^&bFg?@cI,E]Ed=A1O_4d]<S()E&;W;3V&^Q#
?4EX+E9&e>e;NX93;9TA..X56H9S=I21T.<MVMG.1:-,)<(1YSAVIEOTd-1:6VIL
F;gMb?^;K.O[CT1G0:7dWePTSHd<9U_3H3#eaH5?g=KRK++H\_6fg9O/-dbdFLN4R$
`endprotected

`endif // GUARD_SVT_AXI_TRANSACTION_EXCEPTION_SV

