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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cDFrNgef4H9EFFFGj62CBssR9LM9zJSNnecFC8FzWTfDv0T5KNzZypJAmHPAQSzp
OfkFgHavt73Ny8OrUvQAj+lu1/dvMteYfP08zRADc3ExM01oFVsAOEmnpX6vWdIw
tA1RHvXRqQaUVXHrpaIDNpmlBD1KcrxLH42DPhYGSX+kZYO4Qv41Mg==
//pragma protect end_key_block
//pragma protect digest_block
JxFT9wbPD5/CbsaQ41onwGQYnjE=
//pragma protect end_digest_block
//pragma protect data_block
fs8a8wwSV0H2hl7RObp5mkvNvARxgkswgDqUv/ngfbFrFIMTOYEqvkeCK2E/5U7V
BuP2QOBQEDaO9r5vwaAErGMBwDkGmtcYeMc/eiBd45OaoRGupnNfeqNTslkT78Ie
6WpAeDeTQnazv5nxqdL9ysd56VqgdSjeJypIrpRhewWojq/5p0s7BThk8l7hQQwU
gxS2bmBjmjKo1netF+qw5qoEIn/9ekyX4e+QCbvD5cexWIWXwIeUUDi717McmLZQ
B6ElPPpJRSqsmEd4ynxQZXfIRO/qxbKWV37eDKGCMs3Lvi0TUJVJBuJrq09l3vxY
dzMZVd8COXZMaNTFohMUvnZcn8hsFCJDQzSfr9xurkph/wddr+SaAyTAmx9f1ioH
0b+SEu7eojybN+bF173LiHVva2X1qgYkXogl5Kb8M4PMbiCwNUviTsvt2cAWZIlr
T0sp1XCDYnvWA9P0VSv1B8dHCuHgzPvmeDV6INlQnLFey0U8VwxtyvUvYlycfW6B
UGKbYeZ98vRGQbXuX/8GMpjCKh2difCQO/NEMLPG2ZOpER7FSe9EKtf8fWji9PXp
RbyYiXEOvD6wGRkL6theLa3snWFFTC7zqN9D5MA85tgN67u8Iu38UTLQiSyHYlJo
G83Bs9Mo2whLZqHQ7pCppWGiP1eL8sg96fOy5zHLwSsgryEg0iwXLou6XLKwuHZ7
DLibbBZ0sEiRRwaGdYvoBCwohro+eWGA6Jm0uGgvAC0M7OOPcCqDw6Qy4dC9THLO
1WpU5Mhx5KC2pcIf9XZXIzVbpgJHuiOg/YanGw2IsSwwYsYo6AE2eFL78pgz5suh
sijw7skDDipdGY71vpUcdg==
//pragma protect end_data_block
//pragma protect digest_block
tklKcumDbmjaO0s1UFsQ6t59ve8=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KbXG7C/F/ojzqa3SlCSnRjrjVucG730V8uPWaGARLu4UKJ2NNBA8iwRXPVhkx+qN
9qJelzITBA5cWoi4Lqdr6ZsCogFLWfYOL0NRwTEz3ahj5pZ7sO5FimW4aOb/xq/0
4LYA8mo+DtWPl5MLNH/2ex7xZ70/UTUvmH2VgQZTtAT3TrPiWCYLBA==
//pragma protect end_key_block
//pragma protect digest_block
5hRHOvvavSZeK1axkZPHONZKJJk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
NvExYyvR67OyAmQmePfz8pvWoWo=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CEnqBejQyFm9ox+edJkRQQeUrMwyqvAA+EggtHPfKXbS8wBR1YA0xjHNBXKEI522
9fykS+JMZOG0jU/OyNFGX8yk8Hj4sI3EYqNxf0KHKZmvHwDEXa+rqcGh7+/reEn3
DDlMfJba2+xLmKo6SH3If90/bgizTGmI4gPnKCQTP4jDVQ6Ckbna0g==
//pragma protect end_key_block
//pragma protect digest_block
2g7KKeMnhKWmYGJE0d3PDubgWMI=
//pragma protect end_digest_block
//pragma protect data_block
6eckUAx4t3/44RZhAiqAGx/Rygi6wxAnklE+j567f+e+XBnAex4o7RHei7mgStkh
9Lc65W03EYbsrJbTjgIz50SeYUna8Ib+AHPVBX0mIuc1kag5qifHy2iko1DT8ztz
h4g/1jIdSx+5f9LEWqXYVLNNd4zjWl62XPE4WSth/pgRa04nNhZbqAsmwYNkIizX
/2G30MfA8nTSgswYoqduCe6juew5hgCoPESYBJb+uNRy1oUD54fXuqKL6MBGW7uN
XTxJWmj1zJTRIDcHm4rZlnRzuutIJr0mZiN6P9W/TF2/6g1meKDTdUJd3YFJhXUC
hRqVle2vhAiN6PceGk1rLMs+iT9DB1vN1B5n/IG32UTGSmfzg93gmZVUcZO6W2cl
ERxSWNhIzEWAvjL4IlLabsi0f00PTiXz+QJXkNcKK510ADEs6eiEbo7veqJgOYiO
ZCWVj/VXSmO32A8/6+X8VLNIaiILo7dQb4zC+8CE5Up5ZqdRU0myA+Uhn4+aekzz
QFXf+8zY0FVnnKHw5BDVJ4ZqlYdWuBkADhQGrotLLAw96ktPZUkGX5YyRpJMsgVK
6c9GKE/RivJMb12XxFLxAmvlnh1guUbUeClPDaXjw25U6IgvFVdhKMHTX9RIW6nY
t5hbF+ij1HatVrxNK2hWKJPTsTBpthvN/M/gCJhebP1757i5KBDgJojC9erh8oR0
Wi6MI4+b8qF87sKQ8NDjzQ==
//pragma protect end_data_block
//pragma protect digest_block
XL2bwvv5YFK2E6J+Odtib3OXCmM=
//pragma protect end_digest_block
//pragma protect end_protected
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zeXp27QEmJwnEsb2sru3PxKVgrsLNlejQyhbyYvPSOVhXv1bvKIpPuFdRlw8BUoO
vqBjQ3xYXBEMKGQry4aO1gnjJzfeTdaUj5UG45QdWZ6SO4GRg0h2wqQ2XYjbd3rx
54j7HZ7WxGVHtC0CuZT5ntW8y78XHWPDSgEMkWt/WFfUgNmsEJBwKA==
//pragma protect end_key_block
//pragma protect digest_block
BQ/1SCxankU+IEJihZ31H5zeuU8=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
hgpuhaQUKNWmR/kzQ1ck/DqB0FQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //  GUARD_SVT_AHB_TRANSACTION_SV
