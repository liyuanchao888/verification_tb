`ifndef GUARD_SVT_AHB_TRANSACTION_SV
`define GUARD_SVT_AHB_TRANSACTION_SV

/**
 * This is the transaction class which contains all the physical attributes of
 * the transaction like address, burst type, burst size, data etc. At the end
 * of each transaction, the master and slave VIP component provides extended
 * object of type svt_ahb_transaction from its analysis ports in active and
 * passive mode.
 */
class svt_ahb_transaction extends `SVT_TRANSACTION_TYPE;

  /**
   * Reference to ahb configuration
   */
  svt_ahb_configuration cfg;

  /**
    @grouphdr ahb_protocol AHB protocol attributes
    This group contains attributes which are relevant to AHB protocol.
    */

  /**
    @grouphdr ahb_status AHB transaction status attributes
    This group contains attributes which report the status of AHB transaction.
    */

  /**
    @grouphdr ahb_misc Miscellaneous attributes
    This group contains miscellaneous attributes which do not fall under any of the categories above.
    */

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  /**
   *  Enum to represent Response type.
   */
  typedef enum {
    OKAY   = `SVT_AHB_TRANSACTION_RESPONSE_TYPE_OKAY,  /**< OKAY response */ 
    ERROR  = `SVT_AHB_TRANSACTION_RESPONSE_TYPE_ERROR, /**< ERROR response */
    RETRY  = `SVT_AHB_TRANSACTION_RESPONSE_TYPE_RETRY, /**< RETRY response */
    SPLIT  = `SVT_AHB_TRANSACTION_RESPONSE_TYPE_SPLIT, /**< SPLIT response */
    XFAIL = `SVT_AHB_TRANSACTION_RESPONSE_TYPE_XFAIL   /**< XFAIL response, currently applicable only for active master VIP if AHB_LIE AHB-V6 is enabled */
  } response_type_enum;
  
  /**
   *  Enum to represent Transfer type.
   */
  typedef enum {
    IDLE =   `SVT_AHB_TRANSACTION_TRANS_TYPE_IDLE, /**< IDLE transaction */
    BUSY =   `SVT_AHB_TRANSACTION_TRANS_TYPE_BUSY, /**< BUSY transaction */
    NSEQ =   `SVT_AHB_TRANSACTION_TRANS_TYPE_NSEQ, /**< NONSEQUENTIAL transaction */
    SEQ  =   `SVT_AHB_TRANSACTION_TRANS_TYPE_SEQ /**< SEQUENTIAL transaction */ 
  } trans_type_enum;
  
  /**
   *  Enum to identify whether the transaction got aborted due to reset or not.
   */
   typedef enum {
    NOT_ABORTED =   `SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_NOT_ABORTED, /**<Default status*/
    ABORTED_DUE_TO_RESET =`SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_RESET, /**< When the trasaction is aborted due to reset*/ 
    ABORTED_DUE_TO_SPLIT_RESP =`SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_SPLIT_RESP, /**<When the transaction is aborted due to SPLIT>*/
    ABORTED_DUE_TO_ERROR_RESP =`SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_ERROR_RESP, /**<When the transaction is aborted due to ERROR reponse with error response policy  as ABORT_ON_ERROR>*/
    ABORTED_DUE_TO_RETRY_RESP =`SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_RETRY_RESP,/**<When the transactionis aborted due to RETRY>*/
    ABORTED_DUE_TO_LOSS_OF_GRANT= `SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_LOSS_OF_GRANT, /**< When the transaction is aborted due to loss of grant>*/
    ABORTED_DUE_TO_XFAIL_RESP = `SVT_AHB_TRANSACTION_ABORTED_XACT_STATUS_ABORTED_DUE_TO_XFAIL_RESP  /**< When the transaction is ABORTED due to XFAIL response, currently applicable only for active master VIP if AHB_LITE AHB_V6 is enabled*/
  } aborted_xact_status_enum;
   
  /**
   * Enum to represent Transfer size
   */
  typedef enum bit[2:0] {
    BURST_SIZE_8BIT    = `SVT_AHB_TRANSACTION_BURST_SIZE_8, /**< 8-bits transfer size */   
    BURST_SIZE_16BIT   = `SVT_AHB_TRANSACTION_BURST_SIZE_16, /**< 16-bits transfer size */   
    BURST_SIZE_32BIT   = `SVT_AHB_TRANSACTION_BURST_SIZE_32, /**< 32-bits transfer size */  
    BURST_SIZE_64BIT   = `SVT_AHB_TRANSACTION_BURST_SIZE_64, /**< 64-bits transfer size */   
    BURST_SIZE_128BIT  = `SVT_AHB_TRANSACTION_BURST_SIZE_128, /**< 128-bits transfer size */ 
    BURST_SIZE_256BIT  = `SVT_AHB_TRANSACTION_BURST_SIZE_256, /**< 256-bits transfer size */ 
    BURST_SIZE_512BIT  = `SVT_AHB_TRANSACTION_BURST_SIZE_512, /**< 512-bits transfer size */ 
    BURST_SIZE_1024BIT = `SVT_AHB_TRANSACTION_BURST_SIZE_1024 /**< 1024-bits transfer size */ 
  } burst_size_enum;
  
  /**
   * Enum to represent Burst type in a transaction
  */
  typedef enum bit[2:0]{
    SINGLE =  `SVT_AHB_TRANSACTION_BURST_TYPE_SINGLE, /**< SINGLE Burst type */                
    INCR   =  `SVT_AHB_TRANSACTION_BURST_TYPE_INCR, /**< INCR Burst type */                  
    WRAP4  =  `SVT_AHB_TRANSACTION_BURST_TYPE_WRAP4, /**< 4-beat WRAP Burst type */                
    INCR4  =  `SVT_AHB_TRANSACTION_BURST_TYPE_INCR4, /**< 4-beat INCR Burst type */                
    WRAP8  =  `SVT_AHB_TRANSACTION_BURST_TYPE_WRAP8, /**< 8-beat WRAP Burst type */                
    INCR8  =  `SVT_AHB_TRANSACTION_BURST_TYPE_INCR8, /**< 8-beat INCR Burst type */                
    WRAP16 =  `SVT_AHB_TRANSACTION_BURST_TYPE_WRAP16, /**< 16-beat WRAP Burst type */               
    INCR16 =  `SVT_AHB_TRANSACTION_BURST_TYPE_INCR16 /**< 16-beat INCR Burst type */               
  } burst_type_enum;
  
  /**
   * Enum to represent Transaction type
   */
  typedef enum bit[1:0] {
    READ       = `SVT_AHB_TRANSACTION_TYPE_READ, /**< Read transaction. */               
    WRITE      = `SVT_AHB_TRANSACTION_TYPE_WRITE, /**< Write transaction. */             
    IDLE_XACT  = `SVT_AHB_TRANSACTION_TYPE_IDLE_XACT /**< Idle transaction. In case of active Master: 
                                                      all the control signals except hlock(always zero) can be controlled through respective transaction attributes 
                                                      (similar to READ or WRITE transaction types); the value of hwrite signal can be controlled through 
                                                      svt_ahb_transaction::idle_xact_hwrite. */
  } xact_type_enum;

  /**
   * Enum to represent beat address location for wrap boundary
   */
  typedef enum bit[1:0] {
    ADDRESS_STATUS_INITIAL = `SVT_AHB_TRANSACTION_TYPE_INITIAL,
    ADDRESS_BEFORE_WRAP_BOUNDARY = `SVT_AHB_TRANSACTION_TYPE_ADDR_BEFORE_WRAP, /**< Beat address lies before WRAP boundary. */               
    ADDRESS_AFTER_WRAP_BOUNDARY = `SVT_AHB_TRANSACTION_TYPE_ADDR_AFTER_WRAP, /**< Beat address lies after WRAP boundary. */             
    ADDRESS_ON_WRAP_BOUNDARY = `SVT_AHB_TRANSACTION_TYPE_ADDR_ON_WRAP /**< Beat address lies on WRAP boundary. */
  } beat_addr_wrt_wrap_boundary_enum;
  
  /** 
   * Enum to represent hprot[0]
   */
  typedef enum bit {
    OPCODE_FETCH = `SVT_AHB_TRANSACTION_PROT0_TYPE_OPCODE_FETCH, /**< Data Access control - Opcode Fetch. */
    DATA_ACCESS  = `SVT_AHB_TRANSACTION_PROT0_TYPE_DATA_ACCESS /**< Data Access control - Data Access. */ 
  } prot0_type_enum;
   
  /** Enum to represent hprot[1]
   */
  typedef enum bit {
    USER_ACCESS        = `SVT_AHB_TRANSACTION_PROT1_TYPE_USER_ACCESS, /**< Privileged Access control - User Access. */
    PRIVILEDGED_ACCESS = `SVT_AHB_TRANSACTION_PROT1_TYPE_PRIVILEDGED_ACCESS /**< Privileged Access control-  Privileged Access. */
  } prot1_type_enum;
   
  /** Enum to represent hprot[2]
   */
  typedef enum bit {
    NON_BUFFERABLE = `SVT_AHB_TRANSACTION_PROT2_TYPE_NON_BUFFERABLE, /**< Bufferable access - Non Bufferable. */
    BUFFERABLE     = `SVT_AHB_TRANSACTION_PROT2_TYPE_BUFFERABLE /**< Bufferable access - Bufferable. */
  } prot2_type_enum;
  
  /** Enum to represent hprot[3]
   */
  typedef enum bit {
    NON_CACHEABLE  = `SVT_AHB_TRANSACTION_PROT3_TYPE_NON_CACHEABLE, /**< Cacheable access - Non Cacheable. */
    CACHEABLE      = `SVT_AHB_TRANSACTION_PROT3_TYPE_CACHEABLE /**< Cacheable access - Cacheable. */
  } prot3_type_enum;

  /** Enum to represent hprot[4], applicable for AHB_V6 only 
   * (when ahb_interface_type is AHB_V6).
   */
  typedef enum bit {
    DONOT_ALLOCATE  = `SVT_AHB_TRANSACTION_PROT4_TYPE_DONOT_ALLOCATE, /**< Cache Allocate control - No  Cache Allocate. */
    DO_ALLOCATE     = `SVT_AHB_TRANSACTION_PROT4_TYPE_DO_ALLOCATE /**< Cache Allocate control - Cache Allocate. */
  } prot4_type_enum;

  /** Enum to represent hprot[5], applicable for AHB_V6 only
   * (when ahb_interface_type is AHB_V6).
   */
  typedef enum bit {
    NON_EXCLUSIVE_ACCESS  = `SVT_AHB_TRANSACTION_PROT5_TYPE_NON_EXCLUSIVE_ACCESS, /**< Exclusive access control - Non exclusive access. */
    EXCLUSIVE_ACCESS      = `SVT_AHB_TRANSACTION_PROT5_TYPE_EXCLUSIVE_ACCESS /**< Exclusive access control - Exclusive access. */
  } prot5_type_enum;

  /** 
   * Enum to represent hprot[3] when extened_memory_type property is defined
   */
  typedef enum bit {
    NON_MODIFIABLE  = `SVT_AHB_TRANSACTION_PROT3_TYPE_NON_MODIFIABLE, /**< Modifiable Access - Non Modifiable. */
    MODIFIABLE      = `SVT_AHB_TRANSACTION_PROT3_TYPE_MODIFIABLE /**< Modifiable Access - Modifiable. */ 
  } prot3_ex_type_enum;
   
  /** Enum to represent hprot[4] when extened_memory_type property is defined
   */
  typedef enum bit {
    NO_LOOKUP       = `SVT_AHB_TRANSACTION_PROT4_TYPE_NO_LOOKUP, /**< Cache Lookup control - No Lookup into cache. */
    LOOKUP          = `SVT_AHB_TRANSACTION_PROT4_TYPE_LOOKUP /**< Cache Lookup control - Lookup into cache. */
  } prot4_ex_type_enum;
   
  /** Enum to represent hprot[5] when extened_memory_type property is defined
   */
  typedef enum bit {
    NO_ALLOCATE = `SVT_AHB_TRANSACTION_PROT5_TYPE_NO_ALLOCATE, /**< Cache Allocate control - No  Cache Allocate. */
    ALLOCATE    = `SVT_AHB_TRANSACTION_PROT5_TYPE_ALLOCATE /**< Cache Allocate control - Cache Allocate. */
  } prot5_ex_type_enum;
  
  /** Enum to represent hprot[6] when extened_memory_type property is defined 
   */
  typedef enum bit {
    NON_SHAREABLE  = `SVT_AHB_TRANSACTION_PROT6_TYPE_NON_SHAREABLE, /**< Shareable Memory access - Non Shareable. */
    SHAREABLE  = `SVT_AHB_TRANSACTION_PROT6_TYPE_SHAREABLE /**< Shareable Memory access - Shareable. */
  } prot6_ex_type_enum;

/** Enum to represent the secure transfer support / hnonsec
   */
  typedef enum bit {
    SECURE_TRANSFER     = `SVT_AHB_TRANSACTION_SECURE_TRANSFER, /**< Secure Transfer. */
    NONSECURE_TRANSFER  = `SVT_AHB_TRANSACTION_NONSECURE_TRANSFER /**< Non-secure Transfer. */
  } nonsec_trans_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
   /** @groupname ahb_misc
    * Variable that holds the object_num of this transaction. VIP assigns a
    * unique number to each transaction it generates from analysis port. This
    * number is also used by the debug port of the VIP, so that transaction
    * number can be displayed in waveform. This helps in ease of
    * debug as it helps to correlate the transaction displayed in log file and
    * in the waveform.
    */
   int object_num = -1;

   /** @groupname ahb_misc
    *  Represents port ID.
    */
   int port_id;  
   
   /** @groupname ahb_misc
    */
   string object_typ;
  
`ifdef SVT_UVM_TECHNOLOGY
   /**
     * @groupname ahb_misc 
     * Applicable only for master in ACTIVE mode.
     * If this transaction was generated from a UVM TLM Generic Payload, this
     * member indicates the GP from which this AHB transaction was generated
     */
   uvm_tlm_generic_payload causal_gp_xact;
`endif

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  
  /**
   * @groupname ahb_protocol
   * MASTER in active mode:
   *
   * For write transactions this variable specifies write data to be driven on the
   * HWDATA bus. 
   * 
   * SLAVE in active mode:
   *
   * For read transactions this variable specifies read data to be driven on the
   * HRDATA bus.
   *
   * PASSIVE MODE:
   * This variable stores the write or read data as seen on HWDATA or HRDATA bus.
   *
   * APPLICABLE IN ALL MODES:
   * The maximum width of this signal is controlled through macro
   * SVT_AHB_MAX_DATA_WIDTH. Default value of this macro is 64. To change the
   * maximum width of this variable, user can change the value of this macro.
   * Define the new value for the macro in file svt_ahb_user_defines.svi, and
   * then specify this file to be compiled by the simulator. Also, specify
   * +define+SVT_AHB_INCLUDE_USER_DEFINES on the simulator compilation command
   * line. Please consult User Guide for additional information, and consult VIP
   * example for usage demonstration.<br>
   * The SVT_AHB_MAX_DATA_WIDTH macro is only used to control the maximum width
   * of the signal. 
   */
  rand bit [`SVT_AHB_MAX_DATA_WIDTH - 1:0] data[];
    
  /**
   * @groupname ahb_protocol
   * Number of beats in a INCR burst.
   */
  rand int num_incr_beats = 1;
  
  /**
   * @groupname ahb_protocol
   * Number of busy cycles to be inserted after every beat except for last beat.
   * In case of INCR burst, number of busy cycles can be inserted after the last beat. This can be achieved by setting 
   * svt_ahb_configuration::end_incr_with_busy is '1' along with svt_ahb_system_configuration::ahb3 is 1 and
   * svt_ahb_system_configuration::ahb_lite is 1
   */
  rand int num_busy_cycles[];
  
  /**
   * @groupname ahb_protocol
   * The maximum width of this signal is controlled through macro
   * SVT_AHB_MAX_ADDR_WIDTH. Default value of this macro is 64. To change the
   * maximum width of this variable, user can change the value of this macro.
   * Define the new value for the macro in file svt_ahb_user_defines.svi, and
   * then specify this file to be compiled by the simulator. Also, specify
   * +define+SVT_AHB_INCLUDE_USER_DEFINES on the simulator compilation command
   * line. Please consult User Guide for additional information, and consult VIP
   * example for usage demonstration.<br>
   * The SVT_AHB_MAX_ADDR_WIDTH macro is only used to control the maximum width
   * of the signal.
   */
  rand bit [`SVT_AHB_MAX_ADDR_WIDTH - 1 : 0] addr = 0;

  /**
   * @groupname ahb_protocol
   * This is parameter that is used to define the hunalign
   * value for a particular burst_type.
   */
  rand bit unalign =0;
  /**
   * @groupname ahb_protocol
   * Represents the burst size of a transaction
   */
  rand burst_size_enum burst_size = BURST_SIZE_8BIT;
  
  /**
   * @groupname ahb_protocol
   * Represents the burst type of a transaction
   */
  rand burst_type_enum burst_type = SINGLE ;
  
  /** 
   * @groupname ahb_protocol
   * Represents the transaction type of a transaction
   */
  rand xact_type_enum xact_type = IDLE_XACT;
  
   /**
   * @groupname ahb_protocol
   * prot[0] is used for Data Access control
   */
  rand prot0_type_enum prot0_type = DATA_ACCESS;
     
  /** 
   * @groupname ahb_protocol
   * prot[1] is used for Privileged Access control
   */
  rand prot1_type_enum prot1_type = PRIVILEDGED_ACCESS;
  
  /** 
   * @groupname ahb_protocol
   * prot[2] is used for Bufferable access control
   */
  rand prot2_type_enum prot2_type = BUFFERABLE;
    
  /** 
   * @groupname ahb_protocol
   * prot[3] is used for Cacheable access control
   */
  rand prot3_type_enum prot3_type = CACHEABLE;
  
  /**
   * @groupname ahb_protocol
   * prot[3] is used for Modifiable Access control when hprot is extended
   */
  rand prot3_ex_type_enum prot3_ex_type = MODIFIABLE;
    
  /**
   * @groupname ahb_protocol
   * prot[4] is used for Cache allocate control for AHB_v6 only.
   */
  rand  prot4_type_enum prot4_type = DO_ALLOCATE;

  /** 
   * @groupname ahb_protocol
   * prot[4] is used for Cache Lookup control when hprot is extended
   */
  rand prot4_ex_type_enum prot4_ex_type = LOOKUP;
  
  /** 
   * @groupname ahb_protocol
   * prot[5] is used for Cache allocate control when hprot is extended
   */
  rand prot5_ex_type_enum prot5_ex_type = ALLOCATE;

  /** 
   * @groupname ahb_protocol
   * prot[5] is used for exclusive access support for AHB-V6 only.
   * Exclusive access functionality is not supported yet.
   */
  rand prot5_type_enum prot5_type = NON_EXCLUSIVE_ACCESS;
    
  /** 
   * @groupname ahb_protocol
   * prot[6] is used for Shareable Memory access when hprot is extended
   */
  rand prot6_ex_type_enum prot6_ex_type = SHAREABLE;

  /** 
   * @groupname ahb_protocol
   * hnonsec is used for secure transfer indication
   */
  rand nonsec_trans_enum nonsec_trans = NONSECURE_TRANSFER;  

  /**
   * @groupname ahb_protocol
   * Response from the slave.
   * This attribute indicates the response corresponding to most recently completed beat
   */  
  rand response_type_enum response_type  = OKAY;
   
  /** 
   * @groupname ahb_protocol
   * Represents the hwrite signal value when 
   * svt_ahb_transaction::xact_type is svt_ahb_transaction::IDLE_XACT. <br>
   * This is applicable only for active master. <br>
   */  
  rand bit idle_xact_hwrite = 1;
  
`ifdef SVT_VMM_TECHNOLOGY 
  /**
   * @groupname ahb_protocol
   * Lock control: This feature is currently unsupported. 
   */
`else
  /**
   * @groupname ahb_protocol
   * Lock control
   */
`endif  
  rand bit lock = 1'b0;

  /**
   * @groupname ahb_protocol
   * AHB control sideband signal.
   * The maximum width of this signal is controlled through macro
   * SVT_AHB_MAX_USER_WIDTH. Default value of this macro is 32. To change the
   * maximum width of this variable, user can change the value of this macro.
   * Define the new value for the macro in file svt_ahb_user_defines.svi, and
   * then specify this file to be compiled by the simulator. Also, specify
   * +define+SVT_AHB_INCLUDE_USER_DEFINES on the simulator compilation command
   * line. Please consult User Guide for additional information, and consult VIP
   * example for usage demonstration.<br>
   * The SVT_AHB_MAX_USER_WIDTH macro is only used to control the maximum width
   * of the signal.
   */
  rand bit [`SVT_AHB_MAX_USER_WIDTH - 1: 0] control_huser = 0;

  /**
   * @groupname ahb_protocol
   * Currently, this feature AHB Data sideband signal is supported only in Master and Slave active mode <br>
   * MASTER in active mode:<br>
   * For write transactions this variable specifies write data to be driven on the
   * hwdata_huser bus corresponding to all the beats. <br>
   * SLAVE in active mode:<br>
   * For read transactions this variable holds the read data to be driven on the hrdata_huser bus <br>
   * corresponding to all the beats<br>
   * the user has to program beat_data_huser for current data beat<br>
   * For example: In ahb_slave_random_response_sequence, program the beat_data_huser for current data beat as below<br>
   * `svt_xvm_rand_send_with(req, <br>
   *                         { beat_data_huser == 64'h0000_0000_DEAD_BEAF;<br>
   *                         })<br>
   * PASSIVE MODE:<br>
   * Not yet supported<br>
   * APPLICABLE IN ALL MODES:<br>
   * The maximum width of this signal is controlled through macro<br>
   * SVT_AHB_MAX_DATA_USER_WIDTH. Default value of this macro is 64. To change the<br>
   * maximum width of this variable, user can change the value of this macro.<br>
   * 1) Define the new value for the macro in file svt_ahb_user_defines.svi, and<br>
   * then specify this file to be compiled by the simulator. <br>
   * 2)Specify +define+SVT_AHB_INCLUDE_USER_DEFINES on the simulator compilation command<br>
   * line. Please consult User Guide for additional information, and consult VIP<br>
   * example for usage demonstration.<br>
   * The SVT_AHB_MAX_DATA_USER_WIDTH macro is only used to control the maximum width<br>
   * of the signals hwdata_huser and hrdata_huser.
   */
  rand bit [`SVT_AHB_MAX_DATA_USER_WIDTH - 1: 0] data_huser[];

  // ****************************************************************************
  // Non-randomizable variables
  // ****************************************************************************

  /**
   * @groupname ahb_protocol
   * Indicates the type of the current transfer, which can be 
   * NONSEQUENTIAL, SEQUENTIAL, IDLE, or BUSY. This member is populated by the VIP.
   */
  trans_type_enum trans_type;
  
  /**
   * @groupname ahb_protocol
   * This array variable stores the responses for all the completed beats of transaction. Following are the possible response types
   * - OKAY
   * - ERROR
   * - RETRY
   * - SPLIT
   * - XFAIL (applicable for Active master if AHB_LITE AHB_v6 is enabled)
   * .
   * ACTIVE/PASSIVE Mode -Master/Slave: Stores the responses seen on the bus for all the completed beats of transaction
   */  
  response_type_enum all_beat_response[];

  /**
   * @groupname ahb_protocol
   * Number of wait states inserted by slave for given transfer. This member is
   * used to report the number of wait cycles observed for each beat. This
   * member is populated by VIP in the object provided by master & slave models
   * at the end of the transaction, in active & passive mode.  
   */
  int num_wait_cycles_per_beat[$];
  
  /**
   * @groupname ahb_status
   * Indicates the beat number of the current transfer. For the first beat
   * (transfer type NSEQ) of the transaction, the value of current_data_beat_num
   * would be 0.  For subsequent beats (transfer type SEQ), the value  would be
   * incremented. This member is populated by the VIP.
   */  
  int current_data_beat_num;  
 
  /**
   * @groupname ahb_status
   *  Represents the current status of the transaction.  Following are the
   *  possible status types.
   *
   * - INITIAL               : Address phase has not yet started on the channel
   * - PARTIAL_ACCEPT        : First beat has been completed
   * - ACCEPT                : Last beat of transaction has completed 
   * - ABORTED               : Current transaction is aborted with RESET or
   * ERROR/SPLIT/RETRY response
   * .
   */
  status_enum status = INITIAL;

  /**
   * @groupname ahb_status
   *  Represents the current status of the transaction.  Following are the
   *  possible status types.
   *
   * - INITIAL               : Indicates the default state of the flag. It gets 
   *                           updated once the beat level transfer begins
   * - PARTIAL_ACCEPT        : The status changes from INITIAL to PARTIAL_ACCEPT 
   *                           once the address of each beat is accepted by slave
   * - ACCEPT                : The status changes to ACCEPT once the beat level
   *                           data is accepted by the slave
   * - ABORTED               : The status changes to ABORT in case the transaction
   *                           is ABORTED due to ERROR/SPLIT or RETRY response from
   *                           the slave or in case of EBT
   * .                          
   */
  status_enum beat_status = INITIAL; 

   /**
   * @groupname ahb_status
   *  Represents whether transaction got aborted due to reset or not.
   *
   * - NOT_ABORTED            : Default status of enum. It indicated that the transaction is not aborted. 
   *                   
   * - ABORTED_DUE_TO_RESET   : Status of enum when the transaction is aborted due to RESET
   * - ABORTED_DUE_TO_SPLIT_RESP: Status of enum when the transaction is aborted due to SPLIT 
   * - ABORTED_DUE_TO_ERROR_RESP: Status of enum when the transaction is aborted due to ERROR with error response policy being ABORT_ON_ERROR
   * - ABORTED_DUE_TO_RETRY_RESP: Status of enum when the transaction is aborted due to RETRY
   * - ABORTED_DUE_TO_LOSS_OF_GRANT: Status of enum when the transaction is aborted due to loss of grant
   * .                          
   */
  aborted_xact_status_enum aborted_xact_status = NOT_ABORTED; 
  
  /**
   * @groupname ahb_protocol
   * When a multi-layer interconnect component is used in a multi-master system, it can
   * terminate a burst so that another master can gain access to the slave
   * The slave must terminate the burst from the original master and then respond appropriately to the new
   * master if this occurs.
   * This variable indicates burst terminated at Slave VIP when svt_ahb_system_configuration::ahb_lite_multilayer is '1'
   * This is set to '1', when termination of burst occurs.
   * Slave VIP also updates the svt_ahb_transaction::status as ABORTED. If
   * svt_ahb_slave_configuration::rebuild_after_multilayer_interconnect_termination is set to '1',
   * the slave VIP waits for the rebuilding of the aborted transaction.
   * The variable or the Multilayer Interconnect Termination feature is
   * supported only at slave end.
   */  
  bit multilayer_interconnect_termination = 0 ;

/** @cond PRIVATE */
  /**
   * @groupname ahb_protocol
   * Indicates address for the current beat in progress
   * The maximum width of this signal is controlled through macro
   * SVT_AHB_MAX_ADDR_WIDTH. Default value of this macro is 64. To change the
   * maximum width of this variable, user can change the value of this macro.
   * Define the new value for the macro in file svt_ahb_user_defines.svi, and
   * then specify this file to be compiled by the simulator. Also, specify
   * +define+SVT_AHB_INCLUDE_USER_DEFINES on the simulator compilation command
   * line. Please consult User Guide for additional information, and consult VIP
   * example for usage demonstration.<br>
   * The SVT_AHB_MAX_ADDR_WIDTH macro is only used to control the maximum width
   * of the signal.
   */
  bit [`SVT_AHB_MAX_ADDR_WIDTH - 1 : 0] beat_addr = 0;

   /**
   * @groupname ahb_protocol
   * This is a beat level parameter that is used to define the hbstrb
   * value User can define value of beat_bstrb for each beat in the master
   * sequence in following manner:
   * foreach(beat_bstrb[i])
   * beat_bstrb[i] == 8'h some_value
   *.
   */
  rand bit [`SVT_AHB_HBSTRB_PORT_WIDTH -1: 0] beat_bstrb[];

  /**
   * @groupname ahb_protocol
   * Indicates the type of the current transfer, which can be 
   * NONSEQUENTIAL, SEQUENTIAL, IDLE, or BUSY. This member is populated by the
   * VIP.
   */
  trans_type_enum beat_htrans;  

  /**
   * @groupname ahb_protocol
   *  Indicates if this transaction is part of rebuild
   */
  bit is_part_of_rebuild = 0;

  /**
   * @groupname ahb_protocol
   *  Indicates if this transaction is due to rebuild.
   *  This will be set for the transactions created during rebuild except for
   *  the transaction which ends after the rebuild process is over.
   *  Currently used in the AMBA System monitor to ignore the
   *  transactions when the bit set.
   */
  bit is_rebuild_xact = 0;
  
  /**
   * @groupname ahb_protocol
   * Set by driver through accessory methods to indicate if the fetch_next_xact event
   * is triggered.
   */
  bit fetch_next_xact_event_triggered = 0;

  /**
   * This attribute used to indicate if the current transaction is a SPLIT or
   * RETRY that supports the trace array.
   */
  bit is_trace_enabled = 0;

/** @endcond */
  
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  
/** @cond PRIVATE */
  /** Helper attribute for randomization calculated during pre_randomize */
  protected int log_base_2_data_width_in_bytes = 0;
  
  /** 
   * Keeps the count of no of transactions happening to be used for
   * saving the data using pa writer 
   */
  protected int transaction_count_no = 0;

  /**
   * This attribute is only used during do_compare to restrict compare to only 
   * the used width of the addr. They are being copied from the configuration
   * in the extended classes prior to calling super.do_compare. 
   */
  protected int addr_width = `SVT_AHB_MAX_ADDR_WIDTH;

  /**
   * This attribute is only used during do_compare to restrict compare to only 
   * the used width of the data. They are being copied from the configuration
   * in the extended classes prior to calling super.do_compare. 
   */
  protected int data_width = `SVT_AHB_MAX_DATA_WIDTH;
  
  /**
   * This attribute is only used during do_compare to restrict compare to only 
   * the used width of the control_huser. They are being copied from the configuration
   * in the extended classes prior to calling super.do_compare. 
   */
  protected int control_huser_width = `SVT_AHB_MAX_USER_WIDTH;

  /**
   * This attribute is only used during do_compare to restrict compare to 
   * compare control_huser_width only when cfg.control_huser_enable is set to 1. 
   * They are being copied from the configuration in the extended classes prior 
   * to calling super.do_compare. 
   */  
  protected bit is_control_huser_enabled = 0;

  /**
   * This attribute is only used during do_compare to restrict compare to 
   * extended hprot signals only when cfg.extended_mem_enable is set to 1. 
   * They are being copied from the configuration in the extended classes prior 
   * to calling super.do_compare. 
   */
  protected bit is_extended_mem_enabled = 0;

  /**
   * This attribute is only used during do_compare to restrict compare to 
   * compare nosec_trans only when cfg.secure_enable is set to 1. 
   * They are being copied from the configuration in the extended classes prior 
   * to calling super.do_compare. 
   */
  protected bit is_secure_enabled = 0;

  /**
   * This attribute is only used during do_compare to restrict compare to only 
   * the used width of the data_huser. They are being copied from the configuration
   * in the extended classes prior to calling super.do_compare. 
   */
  protected int data_huser_width = `SVT_AHB_MAX_DATA_USER_WIDTH;

  /**
   * This attribute is only used during do_compare to restrict compare to 
   * compare data_huser_width only when cfg.data_huser_enable is set to 1. 
   * They are being copied from the configuration in the extended classes prior 
   * to calling super.do_compare. 
   */  
  protected bit is_data_huser_enabled = 0;
`ifndef __SVDOC__
  // ****************************************************************************
  // Timing variable
  // ****************************************************************************
  /**
   *  @groupname ahb_timing
   *  This variable stores the timing information for valid data beat for read and
   *  write transactions. The simulation time when the beat_status is accepted 
   *  indicating the data beat on the interface, is captured in this member.
   *  VIP updates the value of this member variable, user does not need to program this variable.
   */

  realtime data_beat_assertion_time[];
`endif

/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_ahb_transaction);
   extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_ahb_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_ahb_transaction)
`ifdef SVT_UVM_TECHNOLOGY
    `svt_field_object     (                    causal_gp_xact,                  `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
`endif
    `svt_field_int        (                    object_num,                      `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
    `svt_field_int        (                    port_id,                         `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
    `svt_field_enum       (status_enum,        status,                          `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (status_enum,        beat_status,                     `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    current_data_beat_num,           `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
    `svt_field_int        (                    addr,                            `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_int        (                    unalign,                         `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_array_real (                    data_beat_assertion_time,        `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_DEC)
    `svt_field_array_enum (response_type_enum, all_beat_response,               `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (burst_size_enum,    burst_size,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (burst_type_enum,    burst_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    control_huser,                   `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_array_int  (                    data,                            `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_array_int  (                    data_huser,                      `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_int        (                    idle_xact_hwrite,                `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    lock,                            `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    multilayer_interconnect_termination,`SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_array_int  (                    num_busy_cycles,                 `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    num_incr_beats,                  `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_queue_int  (                    num_wait_cycles_per_beat,        `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot0_type_enum,    prot0_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot1_type_enum,    prot1_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot2_type_enum,    prot2_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot3_type_enum,    prot3_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot4_type_enum,    prot4_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot5_type_enum,    prot5_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot3_ex_type_enum, prot3_ex_type,                   `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot4_ex_type_enum, prot4_ex_type,                   `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot5_ex_type_enum, prot5_ex_type,                   `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (prot6_ex_type_enum, prot6_ex_type,                   `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (nonsec_trans_enum,  nonsec_trans,                    `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (response_type_enum, response_type,                   `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (trans_type_enum,    trans_type,                      `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (aborted_xact_status_enum,   aborted_xact_status,     `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_enum       (xact_type_enum,     xact_type,                       `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    beat_addr,                       `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_array_int  (                    beat_bstrb,                      `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_HEX)
    `svt_field_enum       (trans_type_enum,    beat_htrans,                     `SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    is_part_of_rebuild,              `SVT_HEX |`SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    is_rebuild_xact,                 `SVT_HEX |`SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    is_trace_enabled,                `SVT_HEX |`SVT_ALL_ON|`SVT_NOCOMPARE)
    `svt_field_int        (                    fetch_next_xact_event_triggered, `SVT_HEX |`SVT_ALL_ON|`SVT_NOCOMPARE)
  `svt_data_member_end(svt_ahb_transaction)

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_class_name ();

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. 
   
   * @param silent If 1, no messages are issued by this method. If 0, error
   * messages are issued by this method.
   * @param kind Supported kind values are `SVT_DATA_TYPE::RELEVANT and
   * `SVT_TRANSACTION_TYPE::COMPLETE. If kind is set to
   * `SVT_DATA_TYPE::RELEVANT, this method performs validity checks only on
   * relevant fields. Typically, these fields represent the physical attributes
   * of the protocol. If kind is set to `SVT_TRANSACTION_TYPE::COMPLETE, this
   * method performs validity checks on all fields
   * of the class.
   */
  extern virtual function bit do_is_valid ( bit silent = 1, int kind = -1 );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  
// ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern();

  // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the fields to get only the fields to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be displayed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

 // ----------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
    extern virtual function svt_pa_object_data get_pa_obj_data(string uid="", string typ="", string parent_uid="", string channel="");

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
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);


  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  /** Returns the burst length based on burst_type */
  extern function int get_burst_length();

  /**
  * Returns the total number of bytes transferred in this transaction
  * @return The total number of bytes transferred in this transaction
  */
  extern function int get_byte_count();

  /** Returns the active data byte lanes corresponding to the beat number, beat address */
  extern function void get_beat_lane(input int beat_num,
                                    input logic [`SVT_AHB_MAX_ADDR_WIDTH-1:0] beat_addr,
                                    input int data_width_in_bytes,
                                    output int lower_byte_lane,
                                    output int upper_byte_lane);

  /** Returns 1 if address is unaligned and returns 0 if address is aligned */
  extern function bit is_unaligned_address( input int beat_num);

  /** Returns hbstrb generated for the address provided */
  extern function void generate_hbstrb(input logic  [`SVT_AHB_MAX_ADDR_WIDTH-1:0] beat_addr,
                                                     input int beat_num, 
                                                     input int data_width,
                                                     output bit [`SVT_AHB_HBSTRB_PORT_WIDTH-1 :0] beat_hbstrb);

                                  
  /** Returns the beat address location with respect to WRAP boundary*/
  extern function void check_addr_location_wrt_wrap_boundary(input  int beat_num,
                                                             output bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] wrap_boundary,
                                                             output beat_addr_wrt_wrap_boundary_enum addr_wrt_wrap_boundary,
                                                             output int num_beats_till_wrap);

  /** Returns the address and lanes corresponding to the beat number */
  extern function logic [`SVT_AHB_MAX_ADDR_WIDTH-1:0] get_beat_addr(input int beat_num, input int data_width);

  /**
    * Returns the data in the data_to_pack[] field as a byte stream based on
    * the burst_type. The assumption is that either data[] or cache_write_data[]
    * fields of this class have been passed as arguments to data_to_pack[] field.
    * In the case of WRAP bursts the data is returned such that packed_data[0] 
    * corresponds to the data for the wrap boundary. 
    * In the case of INCR bursts, the data as passed in data_to_pack[] is directly
    * packed to packed_data[]. 
    * @param data_to_pack Data to be packed
    * @param packed_data[] Output byte stream with packed data
    */
  extern function void pack_data_to_byte_stream(input int               data_width,
                                                input bit [`SVT_AHB_MAX_DATA_WIDTH-1:0] data_to_pack[],
                                                output bit [7:0]            packed_data[]
                                               );

  /**
   * Returns the index (of data or wstrb fields) corresponding 
   * to the wrap boundary
   */ 
  extern function int get_wrap_boundary_idx(input int data_width);
  
  /**
   * Gets the minimum byte address which is addressed by this transaction
   * 
   * @param convert_to_global_addr Indicates if the min and max address of this
   * transaction must be translated to a global address  before checking for overlap
   * @param convert_to_slave_addr Indicates whether the address should be converted to
   * a slave address
   * @param requester_name Name of the master component from which the transaction originated
   * @return Minimum byte address addressed by this transaction
   */
  extern function bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] get_min_byte_address(bit convert_to_global_addr = 0, bit convert_to_slave_addr = 0, string requester_name = "", svt_ahb_configuration cfg = null);

  /**
   * Gets the maximum byte address which is addressed by this transaction
   * 
   * @param convert_to_global_addr Indicates if the min and max address of this
   * transaction must be translated to a global address  before checking for overlap
   * @param convert_to_slave_addr Indicates whether the address should be converted to
   * a slave address
   * @param requester_name Name of the master component from which the transaction originated
   * @return Maximum byte address addressed by this transaction
   */
  extern function bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] get_max_byte_address(bit convert_to_global_addr = 0, bit convert_to_slave_addr = 0, string requester_name = "", svt_ahb_configuration cfg = null);
  
  // ---------------------------------------------------------------------------
  /**
   * This virtual method is used to enable/disable the trace capability. The base
   * class implementation always returns 0, indicating that this feature is
   * disabled. Extended classes wishing to support this feature must
   * consider whether this feature should always be enabled, be enabled for
   * all instances of the extended class, or enabled on a per instance basis.
   * This method, and any supporting data fields, etc., in the extended class
   * should be implemented in accordance with these decisions.
   */
  extern virtual function bit enable_trace();

  // ---------------------------------------------------------------------------
  /**
   * This virtual method must be replaced by transactions that make use of the
   * #trace property.  Derived transactions must return a typed
   * factory object which can be used when generating the transaction references
   * in the #trace transaction list.
   */
  extern virtual function `SVT_TRANSACTION_TYPE get_trace_xact_factory();

  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** Returns if it is the case to continue the rebuild on retry or time to abort 
   *  @param max_num_rebuild_attempts_on_retry_resp value of 
   *  svt_ahb_system_configuration::max_num_rebuild_attempts_on_retry_resp
   */
  extern virtual function bit is_rebuild_on_retry(int max_num_rebuild_attempts_on_retry_resp);

//----------------------------------------------------------------------------
  /**
  * This method returns Haddr tagged with Hnonsec bit as MSB bit of Haddr. This 
  * tagged bit indicates the memory accessed will be secure and nonsecure transfer.
  */
  extern function bit[`SVT_AHB_MAX_ADDR_WIDTH:0] get_tagged_addr(bit use_arg_addr=0, bit[`SVT_AHB_MAX_ADDR_WIDTH-1:0] arg_addr=0, bit tagged_address_enable=0,  svt_ahb_configuration cfg = null); 

  /** returns 1 if current transaction is configured as secure access */
  extern virtual function bit is_secure(bit allow_secure = 1);

  //----------------------------------------------------------------------------
  /**
   * This method returns the number of trace array items with their response_type 
   * matching to the _response_type argument passed.
   * @param _response_type Response type to be matched with
   * @param num_matched_responses Number of beats with the response type matched to
   * @param beats_with_matched_response Array with beat numbers with the response type matched to
   */
  extern virtual function void get_matched_response_info(input response_type_enum _response_type, output int num_matched_responses, output int beats_with_matched_response[]);
  /** @endcond */
  // ---------------------------------------------------------------------------
  /**
   * This method returns the number of times this transaction has an associated RETRY response.
   * @param num_retry_responses Number of RETRY responses that the transaction has 
   * @param beats_with_retry_response Array of beat numbers with the RETRY response
   */
  extern virtual function void get_retry_response_info(output int num_retry_responses, output int beats_with_retry_response[]);

  // ---------------------------------------------------------------------------
  /**
   * Called when rebuilding of a transaction is required
   * @param start_addr Starting address for the rebuild transaction
   */
  extern virtual function void rebuild_transaction(bit [`SVT_AHB_MAX_ADDR_WIDTH - 1 : 0] start_addr,
                                                   int beat_num,
                                                   bit ebt_due_to_loss_of_grant = 'b0,
                                                   bit rebuild_using_wrap_boundary_as_start_addr = 'b0,
                                                   output bit [`SVT_AHB_MAX_ADDR_WIDTH-1:0] wrap_boundary,
                                                   output beat_addr_wrt_wrap_boundary_enum addr_wrt_wrap_boundary,
                                                   input svt_ahb_transaction rebuild_xact);

`ifdef SVT_VMM_TECHNOLOGY
`vmm_typename(svt_ahb_transaction)
`vmm_class_factory(svt_ahb_transaction)
`endif
  
endclass


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YIybtPwu9EODpdKevkLY+OnrNN0TqSoc6kdk/YzpPUF8+59vKDgLmDrU/JonDZRK
MCCfxAYDxj8wHohUOa5YJ8ApE5nobP/q09T/IieVlFt6f8EVHBLwtUef3ed6XyZf
yk79CC0OImF+FhIaGlcfEsVGpzkQJCgH9U04QjRVz90=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 467       )
/i+mH+jrghgWHPc91C04LO4jPtKrq4jZ46SCTvpXNK8QxtKf61g1CMjh8mXW2hJ8
3VnyyUYrZ7nZnNDXR92NkM5kv36g309HJOySamKTNDQ8o6a2Lizm/Uzw9yIDGtDX
jQbFMb/UU13mWJEOY5cZiG4IrPRCV7ldaJJ8hwZ22tetfrQDJh4NdW4gkeisOb05
Lv48hOszwE53JzKPYgUbyGhYPOCThQ7LZLqDS1L/CzbE0ddWqS/nGF1xrZquMhRI
y3NQFpK/JfQPOc50f8W8sj6N/QcsyMeiWWtUjwQhTRQtsobiET1cN+kzP4MziBQP
CEsNIgZdS+PHIKXr233lbWTwav7OUhqFoDXZU8FaFrV8TzGRuwTcz/sywtk4f1yz
Kwcl6L8bODN23K/ciYXV4LqQmswDoGn2v/MZfbsmfD5jSYQJG5SLwsZCWXE5Xhx6
PtRu92tBajzuKjs/AqCDXxiM66bI+F6Iqbs1OxBOllW8rLAU5jlTjsLtM+nhaTRS
wYJdHIp6RHuPd9Mk3Q0qFVuARqYC+wKCZw6x4vRZ+0TdqKSz6AyWS9gGMwhGIK9c
5OZ4zyMg0GSdcZVA87oVUzT5sfAlHK9Eokhogrn7tYUeWO3IOGwGCqgKpUXpU1ML
`pragma protect end_protected

//vcs_vip_protect

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kNJDh90iVbNquty5LNb+HfM5cc5DwOYelNP6rhU8W86IUt3FzFAdOx/cWDJ3ymY6
bri5x2f/edO/BpWs9rRqQhER0xdTPd0bLA99lB4sTUqKHpUrptigmQDjkEH02Isa
AQ5+YIeikeotmDMPh4OEZ99SntizS7Wmzdo+dAwD+oE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 49779     )
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
wdnJNixyzXz4jfbBKQPaH2/vFy36mq+80iYt7F/loIt89MEYbio/lSZv9k8+gh3v
HG71zGwZdQCYeNTJMEif9RqApZzTkVE0uWtYXep6UNI5l+iBFI4ws8U8bYP1z796
Xm81CKwbta5zT5p43KDpw8vL3Q5PuIsCkYZz5T0TAnigbA6du+cVGI4ovdLBYMO8
Dg9epyGhbpzlG+YiOivGY/jOMcUxJzerWnbQF4On6/pNjjIQGtCBpoQf/4joKEls
4UQbdTARicI//3j/FbaYB1q34tI1sHCdZeL86hTMoPwz1tG4VLhDCGrBAARgOsFx
K07TiHMjROt37zgAwuiTCwhyVMxu4XZtHjqX9UGHmkv0rdttNqomQxSVx74KRhNb
rcpmf16KF9l4T6Qj9ck7s6aYU9skO1O9LXGNxYdDqTIkDpZ4FOsImMMkdC2UyaWC
Edp+dh4ZV42X3CO84Ag3+/9prGLuCzhLShaIDb08jo2pmnuVvWR4Mfu3oT9T2ktJ
OJzZmORie/3j5Vj0/GclS/TbmzdSA5ydHwDrbWoJCj/oijYh2XVdfAZAbMkpsgvp
oa286jOXXtDZ8UcCBnd77jtCM/0U6sVGs9l50qHvX1H7Tk9BcVDJ2T/CPQz8tUBf
GR9QvlzKy90V9kdCOWR+LDecm6ee0cJcPW/MiqeSr7pobcHUCgCp+ZymTQOoxqFf
JIvj9El0NQTlszeFZ0r3HmFpDpwrr1BfxO36DlnCn17fHK5Hpr+tZQNqA/boF6kP
rYWqLQpdSRckI7mi+fn5qScY576BBKDRyLDaE/w035fRckNyohxRV2RSCH5HSMoB
hmek8h8v/HW+2CG5iPWlleNH3WjM78qHHgRg1YbTzD8Fr7hpKm2pdGIE9XG+tBgt
1TL+M6SukitwfnYLpeOho5UbedD4GRcoi74DejAm1ceZ2nwX5OO7+QvM8N6VPcSf
n+g267Pz6VQvdHH6rGV+aBd0qoilTWV37+1uMrj006kXmvxsy4JIZGAabrvQTrSC
LnZLeqNx5+EQwuIll4ApZOnwz3Z9gsV0qZZ3HynUTnxwPFQkEaCHnctYf3l5+8d6
IpKsO7SoxS+vbwSt0s5ZeCCdEZjnS6gM8olU2yLkxpKAoJNGt/5JundTPM1QLl1+
Cn3CC1cETdTE/nYeWAsaNiCenJgpBIn88GNAsjcyhtGUhzJHNqBXlHx0S9KhJVeN
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S5E2ULAvGgnOBNb6sURckBNn2KRa+yfZw5bqBHSllA7MNFioixf7kOrVgDxz7Osf
XL/XCP9RSgpdwkti86NFukWBTKthhDBb7oojcgpve7DY7pdPGowTetQji8YQWMFM
ctzxJRi9LHZmRJqRSWSbIUMLTmZ2brqHdhJX9jovhOg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 50146     )
cuNhjVPbJPzJJgqtN4qU42DxQzklTr7TtzX4Z7Sn/ojK/Gvs7r8iNcedZ4k3xVqp
mmCixtM7NfkvNi9x5jL8vnbC2zooPGLD3ktSm2QJeEr2J1MHvdbrTA5sRoDRinib
X97NW43CleMQE6T5pOqWlMRPxRWsa1UlZ/XeUhSH8iUX2EKxY08HVnZGWZE5Q9Km
d9YDmUM+fsGU3Zggbn+tiYzCb18BBcJ0sMBfjF83LLQ3Fg5n3jQg08WNaVea802r
CK56YrhilA4UKgr5TjqehcdJlhEdBF90RPivNdMOKseM9hY1xyJJzkgh9IS79C4a
PhNgVnccsvBvfVlmhnUm1CmOdMYrCT4LH+2EUiAOhP40rG7Q2ZvXPNlW+p+eCH5U
S4zel2fltisH5X0qmMNPbe30SubonWNvbKp/ZIyKO23odSCJZ97DN4cXR7FFMTT6
yC7wednW/Fw+dwYVBXWmksCI+8HBuGyjg+XbHZmiNDw=
`pragma protect end_protected
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D1FNE5z9K4U/tbCSvwyL+SxSupcjF/SzPd0t21sJGWt4vQd+n9f+8FroXk+OYybd
C8RpH08Z4vdlABN8tFJXfZ8KO1GleEZzPsRNEOcSdwlCxbNeZG+71GbjJtOQM4Pm
mpI5uwOW12Jkzie8TSY/rYJukJEqYaJxA6KKKlHVwi8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 66802     )
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
X4fUpMVc9Pj+kFPXJU7LUA==
`pragma protect end_protected

`endif //  GUARD_SVT_AHB_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Xk+LSFWDXIRqRfp4oorcrEAiwG2ljFL3wzdPXZl2TurDszI0ZYcAnNr9ujj1EQyQ
y8gGhv+BQOJSnoWlgMixDlk2c6XkTnIiiYhq7TmvTzHUyc+eDwP3KQ5nKD2oC9ta
MRiPpqgvu3SCknbYLMKaem4+wSJo6wsyZQ9Mhprt2kg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 66885     )
NIL71Dc5JHUEMY6eplGji17gzA4Uu/eCV1UkcuOR01BTlIm6luXkBKjzum5T9MPj
syntDp9IRVfGn3S3lEa4VwwCOeBFzC9Idn+6hFuBG4gR2uqzF3gXs6FHlFBmzMR0
`pragma protect end_protected
