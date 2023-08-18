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


`protected
G+a5U>_0/a&)P(e6e2F5GT;Z\)gOE2W)BfZ,PMXg>[BcN4MJR+;O7)L<&5V[#AA/
)P15>VXRN@;ZGB[KJ)Q.7=?#3MQPU)b8WY7<1QNZgfREd,S^4D1FOSaSN6@V(b+5
ccd;IOc/JVg[b5;AW1ASQ5IbY:FYL9\S(;INL<E.bCO89]_(:-RW/2G2^G+77<#f
R&gQ@LJ:8dZ7B=C6[J?HPTL.cf);1^42+U7:#Lb36OG7YD_SdMIB4GR/d]ag(T?)
.+_63FV@4:f&/)UAJC6Y+_<@X2F=G7JXX_4H^E,1d=@:X_#D#,9R[TM#<PX+#BVZ
HJO;E^YKP=7G6#WL6Vd1I()X#P[4YW>&7CI=>F#J3X4QEUCX;Pd#T,C\C(GgGI39
6fS&#0^a^bW5NW\#P[;?GcP@@]<Q]J/F98^OgU9<U0.P+16AQ4D:cZfM>U5^:;FI
D?KbSc0GMV#GLd_BP9TH]5eS]AeBI2N69$
`endprotected


//vcs_vip_protect

`protected
^[U+Ag3aLICP-].?Z[a@V//_BB/CcZ/f8.<T_aT,.)+=4f^3H4&&2(5PA#(H(80P
d^4=Xe1[.ZPN+;U;<(SNF.9MR0S:ID6c,bO1OHLRJH.?7T@IDDZ;:aG5H;0TT9Da
]eVg(4V+UMb8IfeAIK-JHL;=QRc<gF[1dgFMPU_JZU<5WWD1FZ3cIW525@CJ4d<O
M::[V]\G&O/;U]F&(L1N1JgXG^-F=D-HT=QaR=K\6]ZT5,<P[<)NCM@e^7KA6F]5
(6>BI)Y(SKd+32;@:UJD:eD);2AM);JA6?Q#R]-SK\;bET#B+MUK]V<P-&gTIDJ-
5O.5344#]+3K9W0[G]&3-=S3B)^8/R<6HQW?(WCM^^.-OWX_)JW@([S-X_UDeH+?
DcNH&Q79OXU2WA06_-e6X(K\WZ.A>3EedQJ8U>;R>.R=\3GP]5Y#\IW,CF10\F2&
:,<g[b,L_/c3LTB8?[B#\(N&OVAE&,<@6CR<-5M@6OEbeQ[_V#&;cE@X=]c9[a9[
\L.QY-D]P_)_6#/=3D.N<D@+?CL-Qa=XNNJ]Y8HFR:,3D/d/A@&JFF-NMCKX+KU?
^QL+50:L-W&29+[Pc(JA#\7)@.HbPcB:5UV,^)4X_B=25AI:f9[71QKC:88:Y)C<
\3\0-VJ?P(>/)J6#ODMW[Y_9B8aFQ,9DHWDUWgRW?/Z[30<c<ROMDD@0]2C2<7dc
d;=&6HAfcJ/29I-6DQCPA([c2+[U>gD\OH<A.>7V=W-W)F[,=2H[a\/X^G.[2S6?
;&>4KfHYKC#gT3@^FM(#;JC,a@9(?BEb4/DTG\_LJ-GC3S_G)f(g6ZeV-gAYJP8=
G-L:WXX75H,,+C;Kc#?\X1dY1:KK4BXW.:B,C^TY/Jf+J46U-B(<<TdYJ]0[cJE@
Ld.\4d/N;D8eV\e.CC/U=eIB7<]JQN-McAb7RHf^abY/,U9/a<8]c?3<G)V4ZW,7
->g0CZV4(d/1>Z8[,^Y#03N05>FOF2_<_a1M_L(J\eP;>ZA>2OVIL,^A>H3TI=Nc
Ta_?-V]L^@dATBX>cDa7G5\2LB/K-OX^PA@ITPa#QOc4RY#1M\gVY?DJc;X,a(-^
#Ka<9L>7QAacVU5?D-:c?QJb?c+K@CgaLLI^IOYRKKI7.OMS<8gNGYHM.,7gP<(9
0;/RLI96IVM&YD]7dG]L]CG_P/&8P6Ug@U]N[Y5YQdK/N<U86e.GF2M]3>.58e@b
Q]D1SJ1;S(23WLP@BD\gB]>NVb=LJS4^JB2D^bY=>VddX9=(=CMb5F6&P&9=JJ16
bNP>dP7Y&4W+>C/,d=c[)?3:5:1f:W8@,HG#2GMPe7/LB>V;g@M_QHI;DTL\9[[R
MY:)K@QO<@SW(g\I6;P-D_5,=]\/?KDK34@XLa<MOW<Q-=4[5FfeR7cZKJ(KN6V]
<X2WBQ&3O=^KU2S:aDe8c:@/2(^FN+JU\:ETYEFeX26\)#1Q,HdC^^SCb8ET8g+I
W7fQBSHH,M=e/,.J\:=(<bJe,d,@GAA-)TDefMD#\BB#[:g-[1W^a:JPKO=V](XT
NDW4,_9PS:H40fJ:3C7bdCH2#c.60dFA.91FN8g1HcSOM=Cc7YKR1_A94TgCV<.9
.Y5Df=0aX&NIZ76PLa(ccIJ)E=,@C5GW(6c8\@FI<<[>\MGS^\-CCfWdYN.^QK#L
C^5W,;3?X/7ZH3<gE+T56I2Y^NC,#WFE>N6^^dQ0P,g4)-A)U1X&6_Z.7M9BN2^N
HbI[Q)Vb5d1Qg-D41<8Z49#@aH^IMd-HCL<:>5K<IU23BN7,dU-7NTN9.X7OUO\M
D>:LfY=B;fU<6/<OOIX+-)#&d_YH8.P9WCHH[)6?F6.KW<ER6+[P0IC,R>-c+>H\
C^7TGK#aEZO=@L1^eU[K8(,KC0YD]Q:FNY\/IgTKQE\O05a4feb+Ug>e2MXF0H9c
I-0O_14=aTI[IT^FG_EI5eAed/K#0d(5X@Y1819]1)bg&A;,@GZRICGWLK#F5HFO
;YEDN,]1^6F?G7OBJ?)M32Q,fY&T3MJJYS<>gIPW8N3H]TREJ7gJd1e\:bZF8##E
aYOT.580TWJQO1(BQB1?)C>@(>[/6=0NJR#7J\.0<d86:ceVV1[7:P2M?1:/0XQ.
Qa3[L@-]QT[DK]/g9eAM+F)\?Dg2g.@G4gO,KeI6LR))5Q/FC&3-U-)a:O:e&NZN
C2^KROb;Od^GEGeX+]L3MeU40.,JdgJ0?INgC^KKUddXS7f9M5F)..=QOg0&YQfZ
aP6fA;DUIF@@V]];D)H?eF7;XdF8S@>XE,XS>Df^;GG26b6cU+0<dc39R.V,JFW[
LMR(BZ\)Y>-8B;B82&<;Oa0b1ge3T-2@//KY&A+\]5MP-ZH]#8+ZY,:R>B/HWPY1
4=g&6K;I2JM[LfKO<OZJPb)4@Bc3O,<b_A+V.Hf=L1.g).>X]G?9^)Na^+b=<ASI
,Ub5\VQKY8D=[\g:#I+;,YG5MG:G,F/31:=bG@(Y+Ge144(F#CYAET\_W(C;6C8Q
K[4\_6aE]M5W5<0@-\J,]<6O1MZ,ID)RY3O6AV0.DD_]bYLBZ^/Y0-DE6d#\CZU1
9>1dGIX8UaVB5ZJ_XcA42Hg<b5.:P2VAb5:E=3L4)BHQI#P[JaSHcNR5]&X49JF0
W4F=4^CM)+6JW0aAA_/ZcO=[)W5.6_E#3ZLc0T-8Y@&.(#5N#:X/23f>U+U<@;0=
JCBAc8GK3,32e=XB0-<gYDd,#AQ1:#)8&5ca9VdCD[cL:b)LJ^O[Q3)M/U,G;9AA
b>.eRGPWf#,SM]fgWY7U5YQ(LeC[Eg7),Q(B@W66IXMg180a+Pf]OX1&3ZF_Tc,Z
#>>@_HN]JOTV<<LgLQ&A8;b-2?\N;J/R6eHL;A-T)=6BA&7@5JC60A:/WA[R_E(7
9b[5@beZ>WeOEEce^D(G?^;LKM6I/5+]aH4JDQ#H>gd\]C2?:QHSO-)5g)BQE^(I
;,(:Wb,7SbM(=-X&.W^+XOD)a?[)3(?X;Z2c:G1UDJ#6RPBVCEM6D\ST\Q#7\Z9A
Y83>7(]2#gBF?\1]9MUCK-;I5?aV@P9&?N#+;#RJ/M0#\KS<5:@),gK:-7M+([c[
V?\B9-QHc?FLN+@]#_IFY4+--XC=)WYR.=0cTZGC^dJ]b/d>STQFeMQ:+N^(J8VX
WKES[CPf5FcE\KdT=e>0;.=FD-b#DKB\I1_S9UM^+30]4He9Y/<Z@0(P,)><2X2X
)>cY_3EC>4(B\),S?2H3J/1_S]Nf@C?TC,2UXTc,GE&IA=O,70CA:H0X5DYJP_\:
6574P<TN8?5a7/7SfAH(BD\6U,Z7a2a#Q1D3WQXYX)[\N/AVVMdKK_V:8KGQD0g.
9TR9.SdXE?39_0R=8Q]Q<HZ#Fc_&MJYHCC7@C9#VF+.V6+?LX)MfA&<RfCe/#3>G
WACSK(eEeF-U53F9#[cK@\<b.8:?f\P2Vf_960<?BE.1NCZf=?66Vg37F97P,76]
P3a1g:B&D@0W9(9g176eY#<AM@7a-P,2cG[cY@B5?F>BfR8,(d-c7K;3Z_HVXBDd
Na-CbgZb6OA?.G7Q#Y>&9I:ccF]8)[]cLIX\4F)CZL3X[;H<^,;6N3D+Da,HK-He
M6D]Y.f+;8Xe;34@.:=J:<JLZ.ND_,#2;eVDQc<;QGAA\a=DX.Wb?7;]2R(fB:0(
cUdQDEfSV5U;SA(RB)ISd;b[WJA^JaG/JB3>)=,N&UIZ)Zg/>)ALPL>_OMLfK?PX
B7H1N=6\a=X+3a;G,f;P?>=7R?gfg7UURR8TKa]0/(<ETDO[JSd()a?209a3X^e9
2RO@D:NXHW#^-1HA-0d9[/427IP2;Q3/J3bgJE)Z/<.RN<WaaH<c+d&SQ?>6JTb5
deFaKd^(_/BbWIC:#+_T]:G=W?,VCFFJePB1>D><S.4X0Jf8aa0.5M#L1,>>^=MR
D<,&RSPY_I29VBP@P3\@731Feb^B--7Pe34Uf6<3_L^K:dG03OL/7_RaE3NDBVER
[8)W,A6c,51AO=g+WX?__Wd/bIN.S/Fd,]KE0a\FC[H..-a(T256J/eAX-WL3BdB
ABQDFZMf/D,c^MXI2\+#fNQHF/Z(-+>7]3AFUO9&e_gL=ELHggd/fY^^]_eZ<\D\
UL4-g74HTc@0G+,I6L^:;_[8T=K&0FKXF=fEd.8A_]J#_6b8Rf=799I>^Ce(:gK5
/+<fA9[.O?9gD7cTW]2H<&EZ@1[60:8(PLDgN[@?;VKeVVY7IeK=@&GfM>e?&3YN
=VR_TO?FWE?W16E5&+AMZc._OL7b&R,H0+GK3J/VeD^a:_7ReK39YaA_-?(:-g.#
L.[VW_^1Y1O#@;_PD@AbQ5e&5OS7B:ULZC:)Eg+1#ERddD=dfJJ@?TM_?C/d_Vf6
B0OB4GNegaXO52G67>=/a>QMVFL2)]FE+=T]LcWHBPcUD63a]daT75g-;NP@2(gM
aDI6IdKABSa8F@>??=O31LfDS[a2[JYfP([VAI67Y79GQT4>M7:=:Y0Ib=JE79&P
7]&_4L#_9(E]7ST[YQNS0[e,L]0?2cUc:G/O(Mc-gO90J;XJUDG#_Ad\^M[O?=d3
6H>L+7,GbaLC5KZ4,F945dJWQ_O&-K-BKD.#)#MHCB#^W@XE9;DMF?FXfE&7M(+S
+6)50T1(D-R@,..c7:=;QV]R52]caM5CB5GI;<YNb/c6<H0J#JUa2P(gY-@e&-\/
2^&_=]A#_&F#A_4#6d=b<ILFV-5>Y/HQ3VQTOIQJI#@Oad)?SNG&FC2dgfIEM,c1
C/5+]ZOY9;+,;26+/@RAMAg2VbJU7IZ[BVP/L3=9YCR;-Ld9C)EB(N?0F,)F[JY9
>e/X\J,Y+6&WLQHbUe@D)(T8#17dA.Y50EP>&HI&&(/O(N8J-^N=S+&Se=F5DB1_
JUSUcOWcRH)]:e+@RJ;g&C[@?a=94OX+9/]0SaU5:2Hff5-.9>I6@W<](>eAGE[2
ceXS4\^3XY@T<cAR.fOJ+3S:^JT9-aWHA>_)<),[O&S8:Z4M(+I?,6G:g0TL=N]0
TB85@L16G;..HgCA[=G7:\;93QW=:/W5eE0&7.a.@4c,1N-)]Z?P.<WCF[#V8WCK
Y:^d4<IZ:?>U.V\65IPV9W?QK&:YP<RAd&9Hcb4a3;3X;CK41]X[T]#RCDc@JA/.
f5bTHW^S=Pd#-7WV-[Q^DNB]XK4;>:2W)VM73/XI@WMDSUL,,L[:=0&6-Q\6Y<IN
^g]F_6;.2e;CN-Se)EC0+gU9^[5<;Z(K)-6+]Ne#44e?(gLBaMFd0UU)^SE(3NY2
/WA-MJa9:7@Q,VG\c;W7HT;FN+9(X<B0/T/Sg^F-^.50g=X]W7c?KIB#-&5=L;FJ
c2,_1C7LST3?O@]db/ba8VW\&c(WZKPYS,Y8U=MQ[WfVT^Z:_/6C>JW,/1M9C&T)
eW10T8A;Y.Z?K#QA(+\>Q(BY+KMV\[]DR+DS6&,<P27.:LQOS15c9\Q6Z>gNg&=(
92/+4Q<_J7=\RT&,We?S5?39dK10HV(\g8fSF;VAIDHEB=e871]2e>a7dWGf(:OJ
4?_CBgF-#=TN^^.5QSVX;@b]LL+.O>F4E/,V>2<NeV:P]=+=?1g)M-63OH;1)[KB
U8-00#Z5K?QA-CAa[@U<\O4M&QVPW1MMD]f#G#L0IYc34#.J37?gO(?>N[8?17JD
CC6[#fH6MJcN?F^3SPJ\;[:?b,M<Sb0PQ,VCP9TXbe@MV:ZRIFB.IK3=5=.+Uf-Q
YaAL76cbb^U;[?d-8.BAO.fJcG.8DEXR;4XA,Vf)U?KT>XH[TMa()M:c\f=PZ59a
55WVM8<fEeKUP_c:-91#GVa\M(_YE>1-4N8Re]_ZJ8\J7?Y@^;L5DBB-f@Oe_Ra@
G4L)FC2G2+-JXNN4RgHLD:K<bBY>K(U5(.d-ZfDT)4;g=\Z?.X;U=]<BOI1^bId=
I:RR&aTfID6>]AT+7H1<)g=8faWV:^a3bb17Wf<JO8A0Cd:AXI+-(?EJSDg(U-M;
(I:-HAZ&:MD]OII4eD1^E7#<fD1D-B@\.ZKc&A<(\^U+ZX0,83R[T#Dg>dTZKNXb
1<;TB8<<7D>-UbAJ8QReP@bW:aTRT&B&H5)S&2cM,VTD7E):XWX(=)ZGV+XS&Q>g
>)@LE+JfA:g#9K<I-cQ>XW)9geFB^Q0:X6Q715),5^^1D+_CSG9O0DK(@(?L<@=L
(?2K),b&;dHRP(>g.\0IFS1CbVPEa)db-ae35LP9H5Ca)5RI5(bE1Jd,G&IOJT^_
9ePbMY,+Y41IH1eEc4)9,I[50T:4@=_/MVY2O^U6M4IQA)][\(?97>BQW5L>M/cG
]?@1B;K=3&(NCgI2)@X2KgL@[TKg_Fa25Sd7/QZ#S3G0IPdL^[c-?\eeS=760@PL
b12\bcSA/Z.O#e-@aF?:8-^>b_.T&]#P.>b#JNJ<,-RU7Z,62>dg+Kg4aaIN:H<G
CFICZ+46;\?cK\+VL&0FK7eZ7T)5d,A@T#I9ZC/d.G+X;>49\-89P@1f=OcS;HX)
e[:A7.^Y4T;\g)>0B(RA/1.a56J[83ZR4^AO8:LZAc/:1F326SJ)AIM7WO5F;+VW
5c.XG&=+PIJF,+/W(&AG;J5G8&8Z.I#Ug)06JLRd4^S(fK2_IW-ca;M)g)V#ZO3T
FBS[]CP;A)G<S/Tf0-f-ba1\_/)Q[H1U81[#2T@-?VQ4F:b0M;?AX(D.CK+b#_O1
,40A/KQgAV6[MOB6=,^UeUP8H@0XJ\5aZN9?T=H5P/:UL\.4Z2/7#N]\KAM-?1@D
5/PAS[R4J0[#[PXVb1(&+8-JZH;NQM7T9@LG1Zdc,&AVX/Q8a1c4<4(R-f+LHRF1
]F#,UHP]>eD9X>Z&HcCRP1[4d[;ZGG5D5[=.9S,d1<4U^0QI]V+UYTMQXI<UB^4_
(>e,25fSe@,VGRb<-RMQXDM8<bI=1O>HTg,IeVSOVZ3B6>TNFTg_(87Ig[cN>e1>
G)3Y,@6a7[Ie/E3B6bP5UV&=[=BcW5#]Z4NgX7c^gA/HTFM&8QJY^GO:Y#]-gXBB
dLJV71&D&DfQFK2N9]BBL&OV7bXA_)NR9M:PKL-;U833=JFZYa0L,<?1>Q_4GC\g
A(D0IM@dN.0O(MW4L1<[Y3AdgL,S8=,,SH19I<a>H4DFEV490IGH?.,,#<=5Dd67
I]-,X<T)RM=g6d4L/b_87>CJA^&V)PLU8N9S4M6WCgQ&^P=RNS,9Kc&fN\6V]/#L
T88SfW:3=3CRU.(P@.Z8J@C9-gSgTKL,/S,D)LS#L=P574BY\X7(=fa=\R;6\fP,
fN<K+IMCX?6;KB3>.,R5R8(3QAW5M._c523KTK-e;&RL7CQ.Nd-QD1D5V#9HVKg]
2PX(Jf++_)-0=BMG-(+0_8@WL];5a,aN\,U][Q)49AG:J-bAGc84fdTfHa;D3VeV
0)Z<cC5K=c,/Vb(G:ALC\1?Ve#HZO^8+JZeVK\/2(_Y&Y)#0H<K0DU^FYgXT@[.Q
7Q3IK59#S+O,,1L?>C(:VBaKVHS8/c6=Sc[&07EP.C&+>e0YE\(/f/XfI51/8N0&
^d[=(QIE:+gV8Kc5V([5V0-VbTc41Z.-JQP#JAE[RTMJR]OP\JNba@,2cKBR&5(^
9c<K06af\D92^B&FD3;L7:6V8YC-M\-UbVR4^V@(&g#400QJY>]32JO:?88EK(2B
9=IC^NJCHOM\V.b)6,Y,J-KNGH_XA(EcSJUK-.V^XaD(+)-+CAadDd.^>GKXF\OV
)KEd\8W[>:30J;QA&gC17_(GgACa.\TQ#-W^N.</-U64:20M<?GF+&?c9XEQG=d.
eZL\:5J7?APJ,S3d6O&B?Oag,1EH:V)e&R,OBFQZdRJa(4c9)JD^1CYN:2<D/^;W
JG-(Q]?.GX4R^9d_^,:cXfVIK&N5bOH\+A5^6+Bg3V@W_7_Y_7&EDFa5dU8C@KZC
7X:3f1E.[@88_CTF;RdR5_:4cOLV[0&\Ve?C&>2]3XL2IY)dENBYMLY)H??]#EQD
ZTWU-&HG4.97=,<B5FIE.EHR(G38R#2(H#a.4UUA,#S0\;>U;<bQ4Qd_H&=+W)67
0KL\C[^_Y=W#36@aU^/F_ZEg@D1\B@QL@&?ad^WKHTZMAgPC+,H58<NOHXc]CMF2
CE6JO+,AG:F9@I/7MbeYTeSYMN8/C2GQ@g1I&GRCOXDfKYD4H\<TO&&d5)O0_#Xg
_N0:&4aDVQO=?)c[D#ESLWd5V>UHOR(O+YZAFKWcMSK?9_->C2E9KPC2A=Z+Z[Q2
GB)L+Mb&V6egD(]D;EVTW<9BS9J-(F7Wd__M>5_7AS>7/ID)M@(:(@WLf5[XU^BG
A:bP(G(_IY[OZcR:9R?]?Nc2,MSA57F]#R-BFgQ;HeMI#V?@^C;]GEF<7;(]X_K_
:@EJf.[(OG@4-U-aY(<,C3Z]fIGG6c;&FI;gL[&MeQ=T=FOO&B^Bg1]bKZ)F6(Pf
OLW1C<@4HJ3bZeDY?WRMU\3Da#3+ea8+],;NW-A?S07F@^Fa\55e(&T@XYGaS9GY
g@BCC5fDL4.+f]Q9:ID(O?=dYc]@AE1FfN#4/BgeCQ6_^@BO(AE_<WIL8+_R_>#=
S7eKLW)SC#3PBb]U@&S1K5I2Xc.Z@</7O>;]V1B<)O^\UbU6da=&<AD/SJW&B57Y
3fR3)6(eZBCES//(K^d_+Igd=:aEd?M-I678Q/TV6UGDf#/Q#_IY9>6f?M?+)G]M
\ba-.a3@AE;dMfFGQWSa1@X.[T7fV.W<E7XV3gaG@)?\9JJ;IBdC?X0>K[>IcBP;
A2-dX.[TKMWMNF=03U<7a>SYVAYJ3<SQG1Q0_ZK-MTOTE:;f-U;BQZcAT23]a5OD
_FIA,.g3Fe5IBG72@ORGJR;P+H^AP?Y,RL^,e&D?V]M,cdeMbOU+FD,#\e1/.XD<
ff(NI^CK@3D8ag//gRQ/Z5AJQ:Q=-#U)7/C0J])=R75-^XWR[A:41+dL6&^Z(#S9
<5N5J.6FI<M#?W3dC?G8Mc_Kb>::<WBZHVDTFc)e+=_,7fZcC][O([SL.&9VNF(9
:b[L()OQdQA>,ccPSJGFcc(:FK/gdQRQAP+;@Q]YNgL-/IV:_55TE/9I:X<K7U2:
.K0E2HU89>gY3f.e\K=)5#8TH\K]>WW<#IQ_#=NZ08O/A#UTD#E92JH3J,eOFeg3
388TdWHKBH#R-Q_@TN9G4fH?T_8IEEAHYM9W@-U;X+cg)VS[YFFNQ?T\:\U:MK?E
_\42e6(O;(.PJc1>gGOJL6E.EU7KV<FG,Z3ECK3IQbH+I(EGfJB>f)@-2DX4^SgG
W/OLIL?F-#X[O9,[[&<X\@Fa<VHc<8fbBB)c\HMTVVM?J:W&e8\@,J6B3\/0GD\.
]H6Hg,:1XI(UK[)^P4KcdJg.?L-[-4#_,E=P3L9QJZd8+\/74\<d)?GS+<NBHT\P
[MH?<TA&VG47dMI2K8NP&FGZV[1<^B\b5J3TbMcGEPT3L[>3[619X?cGb7cR>/VN
T4O1=SdJbVd+P++V-C\)B=+@OP4_8C4_RBf_.&(CA)4>DS^d5QWbOJQZ/=-R3aTP
W?aDf6AMDD@:#M5R9UJB_P>CLF[D&JUXC;MKc?AZC@0gS,ILBe>1M1BH42-c3&QR
,[U82JTe_);?VNESGN4QL#M;F-/:?Za.;U75BOJ]2NN>@+<UBaJ?)RJG<KZ];;eO
A0^@)94LPY8DB8.a)5HeXUEHe0)-Z8OJ)G2aULG^2(U5(?;e\8GZe<f\#4_L5O.@
6+9Bf5[5I[dP-@W.0+g?8N;[E7,002_be<(gDFJQ_&6DA>NA#dO_1<[1X[fV1E@I
eON1C1-4YD^8#R^P&6,B:NBV7N=<H8CdG[Gd-K@JX,Yd;NQEW.e/](\(2-.5b;^X
O8U)Z[b^de/V80QaI]>_dK.0e;]M6DSO<8ZO_W3bbMPPQaJg^@]:)O\):4UTLRcV
&?K]&GFI_R4V-Z[0Z18S8>>.VW_&-6)/_IS4<<K1b,eM_b:)B]JKGOMb.W.YI.Jb
8)a,aA]=;2\a;/>4(558@g_<QIQHFbI?VU3_#Xg-QO3F@W76?d0b6gRWZ0.+Ob9@
/N:C21ZUOgWKY2Og2B8GTX?@eCc_V4L#f5.0KK?XHSDb@a482G:T9g@_#_N,)6,C
XZ\??F+.bb46F5S4;Dd62Zd@,?#S=U:+da2K_?A(&V(9]X[:d2HdeIgDbO>T?a[-
;L6YgGW^9.FP];CO1VT:4Cd8WGNaR8I>>521(aRZQDW#I/E_V@5SC6.4YM=W&61g
,]NNMf02&N-2MEZ30V2)LFI07U\DW>T?c);/E5f?N\5)]7TP-L)_7LV,306McAEZ
=I6=0_:[1MJPO0dZI<(SVQa=-,FI-N]7J_bCTOe2+@>G9HE/A:AT-P?E5^^8F0Ge
>AZBJg,&\F.B2V,.cWGPE892/cUQ+KOHY.4-Bf:ZQa#GM4XOdEX#56+,e=F2A-e9
_F.D_UZeG?R:G<16&XH+TDZ<N9?Sgdd5++;\>7QAEOT;c]L4&cX+)9H\fUSV.dJT
UB7:2aBO6f^,.0c(5ML>-]N_9cD;@98WWYQSLKTR2)H5f<?;FV9<,<U(JQI-:dSU
#3(V@<XfDcaDF-,,@P_7;:-O\[:ANYH^S9<<CFe>O>J.75g3,\KC.ZbBX+2.FD=^
GAXNJ/]>[P34JC2GRE15I&VeT\ec]F\24&99TJ3?P0ecTNQ()]I[:O6CA>,8H1E6
b#A+BXF)^3AR#::5N^bN,AP6:B@VNaZW\YN>B3K5/e\aVOPc?\62^E6<JVI@6b(#
HeW[4ML-f8[YRH8Y>?Fa0@X2Q#N)#U_?#)M/#Ta,,UX_7Z(XP.D>Z\B/VY.f@BTC
bSHZ1_X.b9]\Y3dEH+1>2>XC6H@TT<d9T+-Qe8,O&KWe:2&(fg6;,#U;(,C2<e)S
_6geBAOPED9LIBRD]Y@P^Ug)RfUIQFR:g:E2X?SX3XTd=>#<-=Ne\c1Z_b739D-E
0:06C[A0=)3_:,K533ID:e-3.#5[FZ/\T,FE-2O\2S+JON#9PcYZd)_5.:4Y)eD\
:&TNL.e7U(=.1R+K.NSHF-Z=a_.(A:.)V>Z,32DTW>7JA\-C5eVK5e>>.\5-HLKg
OGZCG(1#^d5B.?\Hda<<f5NB:I.KfaN.JWS/c?Y6PQWXG1LBFO-?S_Gcd=+A?e/b
W#@CLV>LFP:9g,:9(5WXRJ&IQN\65Yd6S<8JTSPYc-OQPT^QEKT2NC=9SfaMM:0#
/&gY5?Z=aDJY^Y&C=d)QEQ#XZfB.)66Je^AC>?1Y:[fZCXBND_S&+KQ,cFQQ:g5Y
QXMJ=0W<FcG;;TeRJ(;d^&b,_Z2@)VFM6FDJ+?+&)a+A=IRaWRY2_MfI>b7]+[U(
a6O.8KXbH21//2NbE@B6]VL.]V0DU^UA0JCJAY>BGOG-5T>6GW=#KEf4SW_8bW^f
Yb1F5SL_PG92_383)a5Q2@B4UafO>CPV8=3VK>K3C=HA_3ZETM]ad3^F_:KY;08O
aRg8e@TYWLZ2LLE^D@&8P=\EXdPfZ3PCbTZg5,.9MAY.-IC.bA<+P]c2EQP1NL9S
M8@/)&-\SI_RM0@>#Z#Z@4S6XYD+c(U[=OUbQebII+gXH4e5F6V=[CSKDBO9D[G_
B7D1Z?RKBHOMVbH-[W]b-:MMc9W:SF72IZJVJ?.AD3=O;FEP,?^fNBbb+DFf]B]>
1T_1C.[&X;)4X;Ve7@WJe;ZJ18H?PE=MB\]5/4Id)_d2J(/[6[H:/EN+,9-A]V9G
P]8XY0=0R#.J())WUE]J)f#-NUO::]I8Y[;G&T(#gM>.8@[46RYb1Z2J^<[>B_V,
Te)3C9<^fSJ=1;aRV1Z1D(TOM1H7M[=+8@;OPCA:fN25Z6&,6AO\4&8VB[3<3I[)
EA<)b4NBOSQ(#>2Y7,,7K?H/e2[]WIGg0Ib8ST(CE?ebIcJd,-Bd-_C0NO0D+)@f
+NPJ3,D8LJ>\KdSKAU4L,ZM,0cbIATgP&SLcLD=)V+X.GIgc4T;IS:Hc=>K.4MSc
:JLGKC9L[,MVBUZFe.?V)WU9\UO))=Fc@^3Y]FL&a36>T]4=NIKS[KJ;?SU<Vd#2
d-_ARX;M9MCH+ZSV;2IH3(GWPVNdS37g:W\R38=,4RM[@4<3<]2/ec,cFUWKFB/C
Q]:0bX/T6#05;8A_f]=?4Xg[d83@A[_X0YUS6[(LdBa=>d22K1BbY5:U0HDY<W\H
GeS59U1V^3ee2H7^3R][>VV)Aa.eBCa5;I,?V<QS+XXQ/H-.+\f;9;UK>3>6U[Oa
4<ZR1IE@e9^XWS]QU.9PA>_eQ@G:(cTOG9F\UO[[WH4OSI,CI(Q-I<GR=4Db)V-\
P&:?CS@YZJ4?4:XTIMEL9JJQ?He5?NW:)_=T^G3^U9EJ9I-cR>CBZVHeYA>R9V5I
]T56ecT)FS7eE06abT<QG6MMC7G2B.^_61UOM:F/?P:CW\[^W;)AT1E390cFgUW8
c=IHc[\\:9OZ+H#Z05M^E^2;GD;TJV/LO&/dOE+14_2]0MENT0J5aK@1&K7^2I(C
&D#WN^[XeMXZKLJ1GY0RU/67Ke)H1MdcJVUf2:Z0I>bI0<[3#99_&gMWW0S1d#J\
/<<\42MVV-#8.45g/BX7bA;-<a<Y8HA2[@Y<J,f,YL13P<@3CE]WR-K?,eNU2A\;
=d04:d&T^J=E1ZTOK4@O^8Kfd&9DbS0RFELKg1>a8J6a9W+SM,V)[_-<Q+4NJWZ;
:IK39UZW^LgK+[/XZ3Q^-(gRcC2#,@gYUFQ9[[,/-NI;<Y</7@CbXNJfPY(HXJf5
Y?KD5VD\;Q2D&R&b]-\6YdU4f^T:/M]6<CZ9T48N5&7Vc>AT:JdE_)KMeVYMePS1
&_.6]MUJ4I;X(6b:2>JNXJII5J84RKbJ#VCe;5JDX??ffIIE(GUT/EVR2UE:R9-.
QVdB-f8PNKb0Y#)d2Z[:Q)EO<Jd@29N&C;A,3R\R>#Jce@aT/:Ra>_WHE5bGCFe1
7J16,70OT,RJ=&O_1Td;9>5W,QB)f94;[=TfRF720E+O@0>?XU</+5:IKCB=1;5:
0YZF.H=)C)K8^\#T5C5Z_A?;28K5=bA5:c0NSfLAK\.6SfT5G3X_d8F4E7&dKf4=
TD8J)MdXc.8MGMEW?EdJO)TUV8_V5bIA:eI)_N9f;U9FW+a0&g(.CSd18:V2bC/e
=ZdQG@/Rg&UQ&@L7SGKB:IEX44_1B9d7/:+/e033Y1:79B-0VOS:N^;\&FBL2b:P
fEeY:1KU+aT:&V(H7HNaSfGd]]PRTJ=C;,=)8Bd54#&<6N88E2TaA2f-+1cee7ae
GS&B1_;XQQ9E[9gH5--9Z>LCc#@[IGYR=[31MXX25gK^A1_Tc.:@(DICg8RN.gOL
LCNRdW>G-BPBQcfcg\.#,>]dN0.R8]P^@>]Xc=]F/9@CZ<fCE8U4G\>#BHSJ[AR2
&X<fASbK#IF@cAedd6Y1d=cZ>&Lg+&d475L@+YP#SK\,>bO+SVA[[Rf72\RBS(WS
SecNV/]6\5M6GHcDXVYgWAUM:_9bTX[/X4#Y0?HK?I\cUT]-7gU4C2RR>>#Fc_>Q
-JQY:_:8=(D<VY)3M/5_/^G@E_O;UF>2HgGfFH@bKg>+A8-PL8/;P[G6c9Q+R:U(
^[OCAOYTDe#0gC<M+SL;M<5[F5BYS^,NOS<W;/@PMF3,CO44QPD1>eAEeKDKe/DN
;7MK9O7H).Pe28TX4:d#0>IaCLF<YL4@I[-1P<gE7.@&FbbbMG[9C<aO\Va&]_4K
c8^b8:@dVf9=95^JJ(d+JB\T)KGX=K-N>9]<785;)HY(_,1_]=DXG7Z=LG@<Jb_H
SA5?+N1AD;?6(4L;^T[SANded2)aJ^ZI;K8D]09PWU&ET2<R<]R_O&\[0)?5Y>=W
VP3WdS9;0+>Q<U9ATbMPC6C[?N)dL-&/=-MUbK4]40H421==>/9\H8@6de6M(831
6Pf/>KE--eVPO-&BVSC5-d:g0Z&,7M\e9+eV8HWcM_)Y;Q-e>FW^DOE#F7I1K3DI
U5AM,UMJ9Y?=RSI^^<FJ:]fLAA_>O+Z;K6D0X:f?[2NFLWME0_WS8VF?\e6X@8GH
47FaL]0c4BRdba>X,:YUISSO[O70XP\)KXd9?^@EPUca)YGB4c?0Id8:cLe(6<6^
(Z.<af.NC:54d;I]c6_;81,,V@IAVTbD@aK?1X/JHD,_&030W?R)],=ceZ1Ma4c)
:BNQ]@9ND[\1RR_I),HWS8?cG]KN+@CcK@&#N^X+OL6d[e)g81T;0HOK+gZRLB7W
?I2eVbDg1Vd;E9_U0I=H0gP(),:QO8Z(OA#(J+80f6J;.E:(6[0.8JXS>N)_>6YB
MKZcH17#K]5K&L>5CX-#^<cSE-0aUUCcLf-e)c5RaQRM4PK?HCDW#8II9a6F=KSW
(ST?],Qe^]F1GB\<?G^;FC2::gaU2J^B-d@<GEBU^FJJa#JbA<Pg#/1H+G\IGH/a
.>YQZV\bP768+GA,U-CP[Oa,N1T>JJ\IW?dGV.O?M]eP=7IE[BOUZD340<0^G-#W
XQ#fG/+e=PHA3_9UKP@\TC?Sb]S-=1e/;\2](&61BG+M[e1;FR<-(LDd#4;.W7>5
=d&&R>9d2VSD/<AT,cRT&86?9&,]<fW9E>H,IfV6].HO9MGd5<&WC_Y4=c?0C,K/
^.DMC]JU:J?-gRH-,YGZB5TVM/ZAP;_A,&CaC<7Gc#\&XfW,I[IL:?;fYRGQJ#cD
[+L^OaaSD[4LJ;Q6G-8\gfISEL5@^G(Q?LfcScN>9>:690bYN^UE9\,([Q/8)WT4
f:<AH]@a,P?PO-+E<g(0Jb:6@,1#3g.>ANfa-HaAfUAR<)@)IT74CU]R6:eM.W2T
I_AM81:f9?[BbG?g37<:^4)7EWHCO/Sc<Z&89P?Ka/E2BAcM6Mc>5(VA]]F;T-KE
9Hg9.1F(KaLY7E&e2G&D-;[,J<&=CI_16)>(L966Jfbb<7N.6:g)7P#H6S3P3(<2
I]L+QO>dPgPWWeT/8U5dS13Wb:Z026T#9ZEY4FEMFRK0X72P7C=TfdcEC<G;SPO(
+bC?+Y2bFZPeZW7L3LLH0NX;E-D#]?1TYP/OSJ>BY:.4\\+R:H_g/8XB\#.+Y8^D
^_M3NM\deHS3LO9+WBKE;FT,RM<QXYZD43UQ:I(^0XNH6RNFB2.FZKR,:,9Q\\O8
aC[FReO#Ya&[P8bWe.c>7F5DO8(UCc#G@Z>E]aQa.aSQB-_L.a6B<UEGT6^CbU?W
ce4V)3R4M_4>PTW4[8P_(O>@V[[,2H]5JH]@:60Oc]a4X^X^c0.-ZGJV#J##=>D@
YBSGd;IL_:^/YfMb_[BcM)T5#O]+/#5(.(2P(@04(B.7G_DdfP1Q+Q=@YL4)eA9U
EfWU0V]c7<D-c4M^SSM3B@0e\BQU)3@cCSPV08RAE<);T_c>[\GZ,FLG=E[F<VMU
>7,DcLW]]cPH^<2g<^9a(GWUORcB5-JDfgQ-7B]7I.6-Eb_FI-YMFXgDTB<)#>EU
-BO@H>@G)@[C#Z#0/V+BeSV19_TC(@RSZL6g3Ld1_PN91VR#PW.:ed8G-UDINY(9
Zd\:E[1Z)38c@dAI(3I22A-K5PS6ZQLW9&-JcFQLOd,CcLZ<>PIe9SCeW)6GH?#)
FN(^#HZR-P:FF)bI0f2/XeVB]c@UZS64_Y)CC-H1][Igb)EQ5J9M4@YTP1#W_e8R
UYP@:/F\MG+XJQ18T7C<aH397QWJZM(VB3YV05^[fCWgKeOA;JYH#B[8d#<7SB(>
>Jf:H=YNeJIDX4Q?[T57T<\XP47FD-(A?IM(-:SENC./CXB^E>:ea>a<)74,M6Cd
ZaX<>WcH_2C.c-Q>R6dd5-_6=aZ2Z]Ue<7B-??8M61),-eI(Cf32L-07-eMb=/RA
:,DUT&GgH/WTbcEQc<]:QHV.LMLA),\We8.P,JA4-4:0+Td[@fC].gIdTQ]T\+dT
ECa6;:^FOac14]@CTU--P(]793FL&K(M(_+SS+FHDJ((b,34Q[^,:2,L]bVXU)LD
R<222?VS&c0c#L.JS;EE6IDb1OIVeIc&D0VHNbL5\2)1V>L7e:F3d)g_67[2129c
3e:QI3IA@4TO=:29;AU4.^0;<PD:LUZ2Z1gA9G,+]U0>&Y&HQRbUWNA]bAA?V/TU
0F6H4TAf(VM=/ZgMY&5GA?Uf;=V<(Sf:AcVVe7S(=LE1gZNa3+UKI)E&5g&5eP&L
2cU][LQ[_+c[[?][=?(\].,]2QVc@c[<7/KQ2#,SWS2>8f0W/eAfd/#<f3J22AV&
PU;1#:A\.9SZVaSaJ_fG?<I-HS;6F2J2P&^LKA9)6DWB,O^MN>c[3:38POSg\[K4
(.ZO?PWaUUKK<3P_R0F+IXc3U8c<4d&#U(8<\?)c(_]?RAHQZHWfVQ-2H.VW/3fg
fQ,B6g)]MS=P4>XM2(PIAZbDC83&@c#ecX2g[R(693QPIbR#C>GIgV(<UX&J0JC9
Og8<^d0=#:_a?F/&cRI_(0YU[9/aXa\G\UR.1N128D:O?OI30THZW14VP2M]G5<E
=@]?)=L2,>Na;P4cJHN4Y@KQ^=]ZQUCD[[[F8Y&aW2Ka7G_&IP2R1a_/MK?B0RZ#
YS6RcGL^b.SUDe.NMB,R4\BRS@+ASIF//#24CWe#O:MFW.2NCc\O5+,N;<+EPO+b
+60TdV3CROgVY6b<eL\PS-M#aNN?@Zc(8f^V?X8U(0eb[N]=6;;[+7?^;5)/4A97
(_[dA8R&_FJa8eJ#09cO]5X6e91-B_D4-O4a\Tc1.140g2WNABG@X?/=7R>&_cA0
/-+XSJ;Tc2Of&F?bY@?HaRME>U88C-:3[+<e:PO0a\#?c2QMRZ98c@>1NEe^V=RA
W.(S78cbUDVcXFR;L7_1F,MD-4./=GEGLA17]NQ\RL;d.CDggX)d2B2AAS5aU@Ug
8JAP8Sbd@N]DIEBA+N2b]a>RKYPJUGTHFZDJ1QH+TS.BfO>0d>#1b38K-Wa5#\]^
L<&R5f&g&Cg<,>TLZPDb8H8gDWZ98U@0Q+G)CE<HdK7SHFYCNb_=U[MPUIOUGSNb
U-[=@B64\#>Q04+&786GBHH1-6g7<))G8:FKX#Q7@M&6cJZF](N_#>1L,_EM(;OB
<[0D^+a1&fMV)dY80V,)M.EOT,68?:]O:X;UZ>(E2a.7ZWf[gdAR?9dbA5cd3]&=
PT9U+g+J.FD9Bd79IH)LdO@>A^)dZ^34LW_?KED\1>cEbd6=550g5>fY7M/WX4@8
5]5.X+EGEXQ&PBC0O&&dLfC7F;?NebU=R[ZD-Q?C^W^@LO[\;JM\HQa4\N9@.&EW
F?:g3EGceF8C:eNYV6I,ZC-#;fP]RKYKHd&&L<D(2[>P)W#1G&c9[C<SIXL/?RC1
I[IL),\;.)HCR7IHf<6E.Y[gXTL+#>_E&c_5XOFD;ceaC/TTf0V1Zd,R9c)02(FK
/,)W0W@&MV#6Wd2I788EN333MTDMc::TLQYa\W3]MI\L7S00QUDS9M>=5-85QGFR
db<a?FgaDQA,@Xdaf^:DRTVE5]GVT+U\)?Mf4b4RHX#W@a+T^ae,VYU^9Y64&<[O
@9USfPH^G13aL08D5/]Uc?ScHYJ020b:S?AK\I?57OcL:R;.+;+HD0V_HgAJ\SQZ
SM)X-C[AI8H;9(6>5,a]XV4..E@=_b.EZ#@I(Q&/IG4?b.9)7A]5e[3be1P\46Mg
\/gM6H.#^N#^9@Oda(RNJ:6&)N;L-(OEgDA7f9]A+7AUdC-^Rb\@+Egc+bGU7K41
&N,;5A<_RcAc)=>c;]c\R]4aUf&Ge,O\]0+fP^5+L-8=B0D=L\-9&W;cM)WSM.d1
G/5eCXP)UeIB;M]ZJ/I5F@-PfT7E_[KO.F2@,@9JIWU>OI_O_JOYTZ?+T<G/F&+8
Y:[_?cNK?cgU[A0;OI)N5F60U7C]Dc6(@8169(JfOa-eV\7_]6.NPOM&Jb21,;<c
L#fK?QgOXUWWG_H2OYCQ/=M0gA5Qc3[9@>[Kae2TdRWRXfH,0P(4:U-R[)HKB.O0
6O.gN+B+]C.eeMB4.-D;0-0RM2X?O;GQ8A0a/LZ9)e-,1<d4_W??V>AB=3=H)T=J
_Q-d>F\/\]a,VG7V.420a[d@E0M<A^G7IO=caWXAPLW+?38O_FGMAPYcEW;W[XJe
MDP=#864VL66:6J>ZLc66bD9LeWM#[C[./DL;CUG,Xd,6;@(/(W[^#JTF&K4OR??
(2eCA4:#+4I7b@:c3<@ANdN[MaDMDf:XcdeWG2HG&@O[?#Gcb^@KYS_^M:J9+._.
J1SLO0DHXE08fQ=E5^90)bJ#g\R^00;RBBDg#&8?IX7I,UB@]U2Td-1BC_GdTMPC
Dd&)S^R=(:]@fdg+6M;Dg+UC<Q8bDXUge_?a4^?^619JXZ#QO+@H:ag[P&K608;_
CMW2Y.;.]If5<.S1@E@->6[YWJT<CP_IaRe>\-_HbF3^aYW12gdO)/-Y??\ALR_+
>=d6YY>c=0_ZHa4UL/EIHB3gIQ&B:BLU(BEeHFdDJ48;-AP&3U)=<#JU<HJ-HV+Y
3>ZKA;6JaNG\7^2[?RTD@aN3N5K3,K.aX[\QSG7=@Qg3K]7W[25dVg,6E#L3V^DV
J+D&R6_OSVaECI@_GeT[gM9P+bB3c7+L3WW2S)NJCS0Zd=GbdNJ2K09?=IYARP;@
]1A+VCH[8FK[K3S/URZ;+QB2fOGS+N^P1@e<Q@@:_Gf:03:)_W-<;UU:,,)YMSG+
\@Cf=9If-#.P7]C-[.4FJZCb]NN.SC<_H\eA&;_;N>bVfFBBdS;:BgYU6SCTM1N=
0&:M0F0.;,O>>+P.>eeJJXgL7@5[=LO8=bL?IYTe_cD\0<TXYJ\QB98eQ+A(]NI0
0U@/JJ-G&_RC02MS_ba\DRCI^WS?8bQeLTAWMGLU3)IWNa9HVAcS_9[5Vg:aPEG@
<eb=TL4e8^-)0E-9ea)0E@[D-K@1/TJJ^\V-,,T+W\Y1a?R_63f;3bBZgLN[:4g_
B@Y&a3TEc0=CdbVdI6Sb&J4f&Q=X/U8=)P@cSTB4OegE(\BBQ\BgKRN._,a>,/R5
b:0ZS3R_&_A>5[Y8F.#7<7K3@^N[W,N-IR3@4?KW49[WP<@03LZeQa^[GN^g?3<X
&cO,2.-5UKaO\c[H#Sbb-^[PBG3FTM6G76J2B+WNES/4c;W[=J[[=<0Q0DJ^PQE5
</\]ZA)]N7&>Z?&@De:J79>#W3Z@<QQ#-4V)S-aC2&gA_^Za=K/Q4;O9cR5eD]OG
?)5HU@:0XP28?gD3dXMg/M4\L#05bEIQ:LU<D;HV)1KdV;+>6-RQ:C<Ve4&0EHeH
9>VJXJFgd/QR[)N[0Q[X;E74<bI:cL-b:^KE1V/.eBDePA]W1L\A./YNBbLS98#T
&;FA@25gG^F+0\4F/KBH3?a=:O32TRb;RP7./7]HU@HBLK/^5f0?B3.Lg4/A.1P)
Q([NFTWWE;.0G>/.4SVM:(eWF#MI43,J49#^:&H0EeAY.([6>^INO4,H;.Qa[-\g
IN4(0d_(M:a(f<e-TTW<L-c38K7<G8gd1YY6-RJV39#.UDE<cd=AK[^KS(;6g+/8
82=D9PVKJC<BXDS=U64>O-PbNNaDR88[NCZf183V(R8Je)JM^b3g=O:2^&2N<+fg
]Jf,GCQ<&Ib:Z2+0C8U//T9/fD0&)/YW,56MCWPCD^RT][Mc.UaR6Z-g5#,Tc<Y@
SU(R)-+e+7<C=[V[=,f,eQ<<J\9_V/fT,/\c7XTLT0Xg)#2<e>@JbYe-U08A,+FG
e=(,LQ2GT9F:YK2aEWBAf0@S9Y]4))P>)#(f6Nb81Z#8ERHX=Z69c0)7N:EdW./M
=?,GQWH;Z#KAeWb>>F4M?#0MSD6-B2Z>X=RLWd(PP[1ODCD,=U[,,BKPgU34@XNP
Ld36Pf4)ffKM1?QN6aMEX.a[=]]+X4,C7^P.88Vc=)G;+2_3O/UW=bI.Ed.8FCIV
KA;F+3QSIW;FI\#fKCYXCaH.W8c2/YW=9f>7^KQT(.V,9\.RB<0HW3/GQ25J2KW8
bQ&@H#YaWgaDR.&5c?K\XY8KW9,<GS>UIe3Zb#\bZYE[K5Xf&4IKf_gG@BN4^[5O
.Yd)/ZI0O/W&+?WZ-&]J]IF-E\M+3fS\-CDB[LOA:<S,-9X#[&;NK)6DI?/P,8Hb
<9c<S=(Q[F:,FfMZPfFP:@:W9?5?W<?ed-WX52eYD4+R.>>6e.)7-NEaPCec4HA0
f+C\1TcOZ>>C.@:1,Y-]8d)g12fbKf7]I6ZQ6b-F>TbG99O77(CH.MSNZEA0ZR0X
cB=F-<a>IB0?dN>VE7(-+AQJ.]U4VgXVHSP6(2</@A+KB3;G=<M2<R01]WNDVIWX
bQ9d5A6\eT7a2R-R2C6.f\^14OM-B-@<H(R4(Bgc^&X@;Q3I&<3X6MU_B68GU@UF
aSEgDI+9/=AQ,^-6@V+Vd]JDg6R7WE+<Q(1g,D=N7]_7==/1X<JIeAD3g0b3e-17
A<#Z(Q/dJM@(2ACMfR::ccJ55UN9?_6&/Z:Dc.&GN47b,^7<32CN3:ZJ:;YG.KL]
:?dIZOZE>>4[77@Z89L<&9VK104ZCNM@XDfQe-b0SaUP4::Zd8Id;7ZUbCT<8JTA
DMJ[;K[8fO-=e9c/5R=I=&>8;A,.^?-L_JU4EZ5F/F-BdH/A/>+[I[)1<D9&WI_V
6_Rg@R@Oc81Ag^(5OSa>=B.8Uc\RR5W#8//MI]V>;Z4]L\Y9X47X)C4DWZ7(7eb8
C53_\Pa?4:;IW;A[,[aZ9H4Zc?Z9VYMY@Z/SYEUW(eSWB#0NK1<:ZU>,e8@L3BS]
/LdEc[A]BL:?)X\O<Y3V(M3I,JQ;edXJWf+/3;VbN#/0XG(+V5-f-GH:+DYgRc>#
&/#1?9?P7e/J=PfGF+2BZIPJ/O;^@M54Pa0g1--b(TUg][Lg4(:0GfMH4N[/AEfO
[C)(/8@KdT_bD[?DZWUIa-]ea:Rg8a+.>1D..2]K=1EVe-=9cG5QI9\^4IQg8?#\
dO;=cdIJ#-.CYX=+TbDKg6VX>TV3B5;DITQSD;@SWJ+_4f;L\_/.&B=+7NQJI5[X
c0E9^))5Ba>S=[X-N+@T\9PNV7U.=\.FKY&aaP-L^Cd&<+Z4S3GRTG+^N-]E9UdY
>PJFHg\3B2>>^cSO7dQ@L6\#QOQ0)A5_QFKZI;+[4CF4G38OE;.H,gcWPX#SaB2\
3^E&[?O-&Na5^9ZGgdg4E683J&DJ:2&Hc<SJ+EG+XID:YMZR.dNL^?,(0U3,-,3L
-AC]/SA08Wf?Z6Z?10VQNFE>E@Q;cL351cE@<R)X]^a;:bSBT;<fG\<B;#=O_,1;
37/d:fKeK&HP^HAZUcaR6ZZ=Q],MJFR06=J(&YB[UafWE@:9VHY,]Q5F_L/85SOG
GM->gP+93>B,F_.LF92-/K)5F6-LUCX98P/5TAd&B9LHf:^b9fcY^YWP\,\gJ]HE
J(EV/;5VfU+gacaB>dX,8=Fb1E]TC1BE[0DR9=?X]T?X740;2-S@Id5]<L@L7<?R
J:I<)8FRF4\@NDB;V\-L/<e[gG?0f/Z0Y2X\UAFZ6</./WgY8+e::4O-f,AZ_RE4
aF\/I>RJ1e#0@2UE5]AeK-7@U2fWSPgXZ(/+ffLe:QUb3NC-_e<CXa4=9Da(gA8[
IH=MQ[&)gE:7EAR,U5>fbEW03ggQXTEGI\52Tcd^UJE[Y,@U+ZaJO:ICV;=GUb&\
(?B_FECK,6VZHHK(91c;L3PW7\a<MPcIPISb9TX_^16]R/3TEc(.C[)E#]1\-X)>
/-#LF@gaLOJ91cKeO<9=[K/1=@#a&<AL&64^I)=\:F-VT<;O(82^R.,8F,RIGO,f
\V+O#PI\?1ND.Hc&WSSW<DAC7LDb1Kfd1X-@ZE.[?3?(Y,a(L]C#55)A7c=R6feg
@J47<BcX4K[D7)H8KIHVXPb#5Q#)CdRWTWHf09K7+c\PS.&FZ1)@]8IbA;>aP65C
L:a/.VeWOSc7^\G92@HH_2)^#OK@CJ)Y5c0c=6O:cGW8MW#BY5QK(\7#VHD&95Q<
&Ka>-RDS#(CDXKCW)]/<LgRK.<N(76&1Q=cJ1\4,5=R<#/HL/Q>&1LT8G>;X1=-1
aK\K,;HR:OYLZU?0e5;FgXQDC9&0aZ<+eC&.2@PY1P0WaeJ#.J:&#JL]M=>D4Q2Y
eBSXW(cL.>8AON@EM,/P-SX#,#>LV:HAM5e#TL2JJ:B<e<d0Q3(DRS>,:\D:,gWY
XeUg+2&]7K1<G=T=LE@^<0VI^XYR):b&.OFZ<,fFA>N&Ge<G.6D_J+82BHQ_MRH2
<K+)Pg><\VC:CDa,F#59J3c_8P;IDE\,/I)&[+D0L8Ic<+?EP4GY/=gUS@A_LE9b
ePb64I8K]2U+:4F6V;=&\1;6Q&48L<f(fTd&EDM,LK;4Z=DJ_:T==SDX]-gSV29+
/I[(9UY>4X6,LH-JB:<Q@I2K144T8a0(.[E)f][M5;.UZ)M?N9A(HeX4TE^=A460
=168F,6NQS&U3K?bCgfV/^1;Ja=_#ND0Vcf-2#.;Y84SI?=FQJS1WO.TBIOgL.8>
-K/>>UV0CQ:3L>?eS0BH2<aPfJb][V#F0CNJG-6LNQ<>-LR]&BX-TZ0UU.KD[Q.U
M@&WD0fXeFd>cY/,TO-Ve(B=/Wg/N+I;M<g)Z_&FTgP5\3&f]QGP@KV>XcaBNU2#
S?c3)Z\,SWQVYE=CR<e:K]X:dAED7/X(Y#NEJEF=7,<^e07#X]V=DC.de)=JT42T
Od12/=-]>@1U6(E@>,cDV0NH_ag#>RJ^O5]g[&MDM9G_5V<D:-_RbY@ac[_<SHMW
<;b7JRNWX-R_cgX+c](b;DG[U>(OC2B=f)+&.G,E>TDSJ>;cB]FITG?Se:X&+AJ-
4LG_^N?RXE:86e<5.bBTHAFD335c/gHWYPJWC1?T&N-7Z5P<ac.c6aET5/]c(-:U
)AO=[[5.?M=edFR)fV_;A1fYBC,@DWbUgF7\68N7B2P.#9RY+W^>SHeC0OYE>=[V
bbOLJRNM+8EZD:@e@b?;BDK2<C2<<HP?c^[?+(E<Q17@1A2775D1CBc1>M8_bP,c
=<GBX<;8QUTSEHV8W-O:eB&7H<?YdU2O76229^-J2?4QK/g>EO>5]I#Z,AEXMQPX
V1:FR.#YGPC=8:f]S1g:FCE\-68J9/:BCVW)_N(3,7Y:,RQBb]Z[&=ZeU55_&>gf
^L+E0]6#A[bDc(c01EVQ]G(+Te:>ZZVcY4.PT8AU8<3A#NQ5YBaL457gAHaEVc?]
2(?JYPUJRN(]>.\);XQ>,FD=LTY[;bJAc#ZM>R^2(J8.WF&3:W[&@61ga&@<J9=D
)I[SNB)<Ta#V0@.=2eLb#^>()4=f(IT.g.NU?,XSZI&c<R_30OZ7@;RR(JVeL>6I
ETDB6<ZICC/]?UYbF;;/&\HHDXdZg42M#_3.<&;JPL@eeD9>K5g(UY<C#.faP#g5
(dbIF-X31[QCE7N.=cCK2-?fUV<7d^7PM<AY@b-DaV^MbWgH79US@?:V_D9BS90+
6F/([HDTg\]_7HH418X_=IHIJ-VdH@63&T^FffQ[,C)dYGO+?\VSKE9CGe5;9AI.
gHIdgd^-aZ]X5Od/NaP(QV\GXD_W^b7.\4[+AS6KAP[b4O9A6AB^5D56],9gd9;9
^4cSH/)f3-1(503YV>J/-\/,-IP3&+MXaP?DR2@H-(M]:E-ce<[\LGTg3KAU4Ed[
49J1,313^aC3JHe7_K.agS-/b@Q+Q&Lf-CWGHZb>H&1G,F9Wa1ED44&NSC7FG],K
b8eT#DM<,(4IReTF_P4ed&42#Vd<Q4N^4#]SLcWe-L#9;-Q5;4Zg88feZ]BAJWNG
NUJ,-?=dH?4<9M6088[6f0dRa0/_d;&--7GM;IVS3(>(H@#8Y<BaFdcb39G)UGLP
M_Qe5LLB-);4^Z,58dfJ/2EgKB3;&K2b_9/>FL_PbEJISGRK(EK+[)JJ+C[LA&c,
=,;.c)MFVe_38(^7,@ZF27P#O#(:@FS@EdXa^--&G.#RQ:H5(@)P:6dZY5F=XTG9
3#4=8B_FZ[DXYPO2N?+A(Z>>]=5OZNAb9aLUJVW+6DFR(NHdSa0VRD<Yb,=9af+D
&4F?P8]+W;aNM2+a/afaU+<(CaB2B,[4XcAE=H@V2C7-Fb6LJCVQQ9#gDAKMRe_4
4M&O,e>ZcbS=.S38HG>IY=1V4<9W=d<CC-a[d86_9<FOM^JC<beD+T3?]4.C@:[W
CQb7AU=dGSRC9)AQS0DG:Jg,N<ae>f;I7?ZA](e#N@OW]6JG&E9Fa#G^WcRNY@W@
=3CaA\G&LUQ]eG#f@:H1MeM(1+2.>f?8Z5G-[&d[Y.ZYad@#gX+>#McW(MN,_?ZK
VSS+<7>Z<L,/(/abYL3.Ag2e)XZ^c9bfQ/ESDJ.-W7+QE@,C@8K[A2_MQgLI.#Ge
55Xf/:2&2^Fc3#0753@7L7,<CgHYZT]DNU_a8FX#1G1Z]SKXWG<=W0Y48QZQ6)L=
U+A<6gcL094KI0Gg2PMV@?dQe^GDagG>1Cf^Jd<a+\e&UHF6(>(37M<X4S>)X_5=
XcTfGRCDI&+\/S_W)[:V/HKgEfT00Z(BCe#-=ST^YcU8#YL(DA(2]\4&Q_J.(@RD
:V<Xc2AM@U5N[XC\88A@a:?#I.B3W;58Y,B=LD-0_-;>^:>3gFCTbV^?&2^81g>V
,@]EFf4;.<79QT/N4cb.KYgg541H^@0fYaYNKLM&YX\63.SW=4,-+V._&2&(W+6O
?IT^W;c<[VR;63?ZE.\A#9ZW7G3>1UaW>),QM<-:GeKe=,#.U;B^\XJ?/]H\9U2W
4@3aX(=7&+]1;g;NQg(F3#F6EP(>.MZ[Nc<(gA;JH^4.b,E0@K_<\W,H)W2YE#MU
AB=f7Aa&K_A+IG.&eD:/?_Qb5)&XWP3d/5c3P4[U:=C3=:Le8U9)6BaM(2B6A,e<
UH9CaX#QZP>9UK\DKCN.LGJ>H,KgIfX5?;Kb@V(e,GM)(12Q9R5.9RUY:Z1(VJ[D
2PXgZGW6e6TQZON^b(eI7PJGZ._Q04=S9X#0I;6@(3gd_,=K<?U:I,YF(J6U(7GW
KKS4&0-daB^>:(EG>CIIE45.,-T7@?(=QcRJ5Z(g[=6>,)SA@:#S@+eFfC_BV=_.
&X_IE8bMcR3):WVD4IX55&HX7(P0JZX7ZHb83Le.7,(3^K],YHeXDO0D]J1a@b)c
gTLXVW:<e6.TCd-6?DA?[eI=fI-+d^EH/>Q,GDC5>AcI5b8>_<Q&[eg)]\dUW:+#
&LGaURWgecE[f7(K(S]95^#OEK4Cc5Aea6/bGE@<b,[cZY=E4(d]Z5;V_H7-EGgZ
V0G3d^C.=DTKM9MLJKV2]SW)^)X6SNE>80G/(F5XB7+9;3UHUGb0<4=\B0IJ3e\.
Sc8.E8)QWK>-R,BIceJg)Y\().8@@EB5<g<ee):eYcE\&<V0O>/ZAUe3RS,(P&3B
egE.J?ZDaQ(Y_[Q#V#+9F8HPODF8OE/].HHZ^^=eEZ3a43@))M@LQFHgf3:;07fE
N-9GJ]8\]U2gcH&&8+;VfgS:I53R@\56F.aPC4@G,@4Mcda<;6^REB&;3d6B1.(a
S1/;@G&9QANM7f?1d1-a1-GQ3@P:SB1U\N@)?KMaQbB3/c=.,B7C9W>.OcNDC.#A
<^;VE2A^\0PI#e9OOS_.2@-IF0^PeFDU#4DJ=+g&Tg003/bd)0@2HB(,>Z5D0a,9
4/8PD#WFV[-?RIUYVDGGN\@TCMfFJC#4-IK8)UKCS-ZD3bdX_Z#Q?^fH2<;AW6?(
LKeWV1g5LO,B9PS>4;BAOe/g;dR12]ZREfTH]dQ>,?U(dB159HZ?ae<XSI&=:Peb
VS1S1^Y60Q\PK@c8eb(Q\aEDT.cCUX9<7&=MeOUDgLVW)2E05Z<5K&D<IXa+a/)<
GJ3MR1E#31).gB/.:N8HJP4\Rg>[dT)SYVK^&[egH2G1HQfbJ0R.AV+G>R#cW4[,
7]#CUX(_W.)aM0W-R;XVGNCga;HVW)GTTHA?+U&DR+B@.J1[ZR-Pe<.6QKUbBMT_
K,]35Q_e#IV0+>AETd@W/>R2=b,,7W[/2DJI4U:_N9^F<1]?#):F=^&6_0(_^=JI
3gU#Ud9&gCUR/8<eU9X+,RDdG9U:7E9)0EZ.fI667cAUM\S[2B[;9dWb_(>F#aF@
d6_^0+,:W=5P,Z<I#_NC6LOFQAc(D>d(\D>9ER;PL^T(5M@)/V335,RRE\b0W]&=
S:I^PEGOFbGPS@C==;E4B_^VF_]5\[G8,ICPT>Z(ED(>,8=21:Y]42(/dDa=:A@R
2=,8/&KLV,1M(4P&,\T>/M[S@gb+TTB8V+O^6]V/b]g]=>0812eM2@J;&.e5/LS8
I=9Y)1PNA_BO:QX,S7>KH4K3,C&N3W#:,HBEVgLP_-WXF]8/A+C\cI-2b^3..8;W
D.NXTK(IAO;:+N0]M531a):TZ[[FV6ebGI)489/?WN(Kb0aR&6D;H3C]]0R<<B.E
&.3eagE\S.5]LVUE?<+NWIS;L9EG@K]T;e5-I_[83Z/\g]C[=XBD@_=BQ&aB(#U?
FW#.<2PPJfEaUcW0\geI;D)3X@\(e++IXd2CH8bH&)[^FUJ\)S/\/B;([IH::7[L
A@=UI>b+;EOE=4IJ?Fc167&&I+A18W3RP^0W+.CXOa(ANGT+N8>.O9<748M2VJ+1
1S>3,eTX]Q>DKJOg+^,e?/AM;(U>ebCI<\+N55UD2NY1;9-G2KK37\P\6>HFQeXd
>5_XM__S&#bR@J1+J#cGMc]a1(0MLeLbB@LOD5J5YLda(R?N.)FB/FB8)A.;I:NW
fNIIQ>>J8N7K4a1&IfNWHS.?BER#??IZaaC1W64LT/L/S5ER:#fB0c78YJe^9<Xf
@[_58/ME[OaYW:A^CGA.O,0=7Y#\&8UCG#7GYgVYG&J,@+(I92&#[;cf<5>aD6ZN
O1QM7AOa3)L^/V24,UgTL-/b6)VU\b8RIH38<NZ//Td36#9M,c,[&U?f\6#]N9/)
7US:CYb\WPKS])DS>^DVQV\geCg:AE(@:@ET0e=aC1V>DJ8F45B/9(M<_FWU@dTd
#cQ)2Zb]e48YG[e4LVb^Yg[c9Na)#QX#NLEB.\bFY4SE=5^-Z\c11;<.gR+#2G6(
\V^CBSEg0BC76EW@?Y#B2X-8a##W;DNYXEb1G;Wa/d#a>E=--Eg4KJRO;_ME/L7+
UXcY_@J&aWB4^RJW)(AfW?U(YFaSNRXDNEAD79600[.L?P=bgaB2b,-&9C1g-f=/
]H.\@F0F\6g_DES#ZW[CTLX2bP)2>Ac)g83e:9-H6_DQ._3OUV8Q>L+/OfcJ33B-
;YUY),>.</1>&E.C-Z/VbS7fA/.RM5P]H1D#F5QQQ>?Gc(+#eZIa\H5UH]X3^&:Y
#,&K^TdXUO8ZeL]&;/;>.IB\IN\K.KZA:2>&aA+I:af^OA:;fg]J6;=NRc=-fBff
eT6a=7-<?R+^\\H5e-K@:gN@<fGd5ga7OBKSEbd;/c@]&:SF#0Dg)/V./PY@V<Pf
]U,KQcEC6aNIJ=A=F/ZGc\RB<FWSBa4+AQIU2,L)I58.&W><IAa93@Z_U#9FSV23
K/>,0AEFe_6J20N>E)37,,9F5bAeaSV5A<,<Y0S2:/40/\))>84P9RQ^KLOc-]gD
:C2J-JTXTF\C[PE&ELE7-3+UDNBd.,DAJ^TTQ[+OLZ^We,e,RM+I1;?0L,B<a0MC
J]@);T5L<9d+3M.d&G70^S(5=C2:f=5f>T7Gg5++H.<NJ@Ad(U&Y2KQH6bX\bV-g
\:,8KR95F3c(Wf#+/eUc@DVAa_/>Zg-/fQ.UE>fDS;(/U.VIV-UC09\6E(Y6_[FI
4WVF=I:9gSf?BcJf?G](e4L/.;Idd+?a0D>CF9JYYb.BD]RW5C)&PN,cV^3NH0MY
YdcfB\AT)<8bG=a@88N_T5;XOA>f[IML):HFad(,>2@-U[+Obc8DFJca,.eOf#WB
g12\GK53>ZBY08?@D?bCG[B4SNe&-0-R5=G(\UB8]fX5AT\-U._)Q1cCTfRM:5.W
bTD2]JZQ+K0,E#8]1KAA2QGWSAKME>,O[d-&+8bNR)S070&L9IO\)Y562;T-4Ac/
WWK_5I&M1:1M4f]TaSLa^T5\Z7NXT_MO2YV_D?_gZO).He=d#&:,WT;eAZ]feN;1
]g=]Ea+Q4I^QH_f7?6S]S/8XI67Tb,Jb0Wd7)[_>5ZFg^NA;Y@F>=WfT/_LRBD+D
;QDNG<B?D_SbYIQ2?BX#(TbfTHP0ACD?7eT4?fRY8SI51gH>O/I4M@c-)_>\RXgX
V)9K\PBY&XQ]QGHBH2=DBZL/>/Wf0?Z-DQTaR2OTA)Gf661ZbReJ<:\=I3<M(-8R
FdE^P?-\?P?8(c[)(#>5Y/O^67=DQWI5KT66c13-e:OX6ebI0F+;Y1dU2[#@PYV<
BLf+/33f0UFa9:2&#BY,;/2F^GY=MOT@^8]MEV@98A/DeHC_K1;AdC]ZRT,S[G.T
8>VVEY#)Rgd1D>>^a_OS5;@<ZU)SAJT?D7OPG=+Z:8V-K(XXI9a<N4b5JYI77?b1
06U/X5d<=4QT_?U<c^dKeVTb_H>@5EYPK:b7^0J1Z8\fTO5VSUDeOH-/6gM3/WC\
(C-/IVS+0P2+Z:6TH8<3^cE4=bP6TJ(HSDZQa#;MU]BcZ/XZRH\#BQ-@ACFe6<?(
W@57/4NX.W\\DW;_9gX7,g:+)K5J2_Va>R.CaP_PDG?4We2UgeF?\:._VNUMCZHN
QY-3d2X2,\2BaW+<UTWA\1ZG2[)^C/N26,3+P@GZZ#LOE5YcQI?J?@df3U@(C>L^
c=R9;9:6Re^Q7HadHcEdIb?41W@.,T(-[XJ//M=GG_JK/D&L1)A+A3E]>W7^F)0:
BL:]R(&6LDcZ(L;^9Ge16:0T)N;E-(;8D098Y4-.U:eUVN_\.d9OG_#G9-B1_G)G
V.X?9OD7#P3c@ONG\W[XfA,ZR&16OfCH,OK>_=CD>QLVDC/RS=M=0g/L^5/PB&T\
?Zb8U4=<J0gGU):dZB>[fbZWDO+6^>-S6XfFB@<D&47O2@f\=C7MCXJ<cba?AZ>=
>L;+2X.22C3\E60#G]^.L7Z#d;6eO#MPI7cR],?\N76.J?:@V)VIPZ_7Z_I>?B/(
H;?11&/[6ScPeCPDB./aWU+K].J4Z5b-3HL1&?W71ea#J_]TENWT275>YLfIeND8
7ZKI>G6..K/Y@=[_M6ee2X[8:(&=?6Q>]X^VDG=X.6DFg)9W\BP7AQ@\K6KY\VDH
NSH[ZRFWf,\=A;>aR;b4QU1-O5/QG.8K/BTe(K[T/XU@)Q#+1NF37WBSG_J7-ZZ2
=9+/_+4T-BOZVe#cMOO^&SK.R+>GHP-\4WBV]1R6_/Ka]E>U5OU=#R3+#;K3VgH9
EHQb3]\W>,248(=11.Ig[6K1<N]WCSW:FTRb_c88E0C]J5d1]Y,/;/aPN#N7fE^N
)/e(R2ScPT/A&,7RW3=3)ENHCgfZ@G8(Y4FOXK7T\[,Z3Z_K8T[>LAd,>GWdbEf>
IPQDcf0#(5=(?7H]e3QL/P,Sg=?WQ@QePX#R&JY4^Dc5717c(JSQQ@>6]6\B@C]O
M/EM->OKY8;I&/371H^_&6UF]HJB>3:9:f2[\LO<2@Q<TI(L\X>.@3EH<D,a;aK=
0-E^N@b9e49C4])U9Z(+5[#4^-fP876;XBc@&)]2a@266EI4>&=;J6D<Na^eUA(]
?CE9F?]@<<7[V2//2S>Y@c-J&ZG:_/,:8?^E\(b+@103-A]EWgKg_bN,aec+>.QR
#=_W_Q\1NZF487MBEJUCFg1WOb_9VT-:):FES3W/LE75Y,?T[[W&=ERP)V>8V@:A
d)W0;0ZB(_B8A=NdJD?G5[BF1/?f30?ZJ^?\Q)UYYc60AF6ee<4_7S&/dR4GbUT:
\(P[Z3IEcU7,bff?>Pe9Q;bC5B8#W2Lf2-)\g6fB;T?)Z26LXKB7;21(F.a=E_L(
eSPZ?5U-Q?YK-a8KAL8N0dBJ_33J3X\c)L;_3P;b8)DcZaA7ScbbCeNVNMd/?13g
]_AW8e/b^/a9@&(<;U-g:?[P43Q/HfL6)8@f@HeP1DL,Oc#5-=[8Z^][T8QHC1XH
FeB)LfII/_<)>g;f,_U;+71Pf)88P2PWA@N+HT(U^/8#TP&[_HVZ?M[+9eSPf=27
e[4(IZ?3=V,#)@)X+fFN?JQAHFa&9bWEAXVWG4QV[d.Ud=:(+-K0GUE+88U/D(]<
0S0:EBa.B\K7&I)1_ZXMR:[V-DeZ/2,D^_-<M+O#LeDOJcS9YDP1R3CIU)KM/[_6
PZP-)P(XR@&O_<c([V+[&XbgUOM[>5?CId75;Y0URU+56C-#O[=NZD>MOVKCU0(+
P1)=C13.WP.-HTIL[<A,F<T6gg7VB(EN35?QeC7L9,&fQ&HVH[U].U<GD(2MYC:6
6CDgN8-Q/Q(D7/=CZSTT57f3?T>6.KF[Q+;A=G&WFgU1=N=__BFZUK4-a7OA]Kb6
bQC^C+S@S;7,]L2I]_Oe.(&V-Od&5]-B;YKR0cJSUg<RPFZ/PH@;Q:4UF]2Gb,P,
=PQb_RU?F>=6GVGC^@JHCVFR=N;&dV):()(6:95VW;b@[KW7(Ib9ARO\-PJ4c.&O
0cKRZ4QWF2^F^S?9V>Kg0H?Y0GWJ#+Lb]_?Fa17N09BF76>=K931IZVX7=@A6bD:
O,(cd<7R7)5AfZA(YFYO/e3de-?2Q&L+1MY_584YNKN;#=eV]:L.8-DfR)MRfeQI
8IP(]?8X,.<C7JVL+]@6A(D0^:/J=\NbB@.=^5(a-\&V=&_DMCeb+f[+?;9ZOIJ)
Ma56Bb.#cM81EVT]f)M)P?:[\-+F0D]WU2LHU61XBSHNIf_7]L^M\6HO?56GUOfZ
Z5SB7?9O>(+=G<FJ3:c\0QFNa[S,_?SUaDW8]EU9];a]g:KNed)a(NUTae1#bNME
NVegT:e2F;>QH?MPR:b+;RYDE53b@DZ4_/AXF+fK-V>L^()G+B=QBN#,Y_4IGL8R
7]K>X+W]=)FU9b7cXI\KOOHG#1K@40F[d#e/I^EU/9&P8;A<-CK=#,I:R_Uf0PWS
M8?@[aB)EXW:W+VTSD,L.a=::97C-ag)&\GbU)DOV66CM4PNG-EX:@Ea=6?7Ngbd
<e34EeB;Yd^9+MG[46AZK+Xb&R>L_dC9EU[/<e8/[g:UWFT/U<cd\IeN<A5d<FST
9;A45=<5T9SA/Hf+#fE>ZRb\L1=N&X>P>0O.>IBCT]GYQ)/]]=,b_)376H#H8Y/F
2D+McV>,F#+O\8@?[__4aCC_M4V?(KRdFY3d+_#2JIba[@#2g(X??g5U.WNbH?Jc
7SX:4\a>&4VG..MAa?Sa0L#eGM+3<WF1CG)G?3>VHgO:2@E5BK)ND.+C2]fK^LCL
\9U3ZV5JIJU?\L/VLga2\:ABCQe>@U\-<?d5P>OM.6Uf[HO1VJ)gL3(H;DJ924<-
/@HTV19=K4DKdN:eS)@>b4E23PAE.Z(^1&)F\4g.2:SQgEBdAIGcYY9ZLJKTR&L^
aI&:0f<ebT=ge/ZD3Z<6g34URd0g.\a#[SW2+U/N>54AKBa1EJQ+?B/aMUWE\5I=
M@3D(NLdX@LJPP8aAW0R4f)27+[Ub)G5)61,I4_NY.5K;)J><06>eg[:(N)^d>SX
3E<>142b73(F.WA@;,L@CRdVD::)<A8>c]d,)8PG><Q]f9)^@]O](2;+8^S.9K,L
4b3D/d,8^?-=2<;KKN8;..0fa3YdEG<F8N+8H8+<EQN(g2dWdeUWUL;MO8D:7WfI
Vd?2g4NcXfJf&SI[H/,&(<-Gg<<5Y=Qg2QX#Tg3^8?@eIb9MF3)ZI(T6.M?a.#dA
CK4?P9Z^E#>1R3@\?S?3M9T-Z08BaF+B?EEQ+^,<]\[I6_+IR.V3Q:W?+f_?7C69
L66&YVB)>ac5_\(\fSM.FRN+H>\b=[6YT>-#6J?YPa><.5JF:TK#G.CEcO#/<1Y/
T_1B8ObGBXe?4\Z;^3#DKX;3KNSW/CUg_-D(17BEaceOV:\6R1+^IgcE8MbW_[3f
CJM2f]616\JIQ7UOQH/=2FDX<]D[RR6G[[bOaQ3A.2_DAPCHe(I7B7MYPY8B7J90
E>@4e[<J)E=,6W<(WKGSC)P)[LKd:Z,L(Q69[B,_/SDH9_1bgK6S2Ga(@a;=P3(3
Ue2BCTFZcdG#)_7EICeUQbFZ@-[.GA52g_Z2=UH_g?]GT,(1T)=:2?[XeY2AaQ(+
\4-SDZP8Z0;bLGOHF5V1VgSQ8,\/GF(4e.N-bJBScDcL[3>6Z62RMVPNEeGJA^6#
K=AgNUbVN#3;T8;bc^JU(U,37M\eZ.>?V7H>1K(OQ2UTDeb,DZf36b-ZPQ4?1.VE
726K\M-JR;JM49eb]aH&\H_Z8XZS,(:)EQK&SX;^18);;-I&T?2bG9T#K>RA/D33
b.P46:?(_cZ3GYQcDPH70AXQ,@)2<-K@R6E(Z>WQa.&(P>5=&;c.=]&X&BMEc)e_
b\:HCN]E5C?#(&K4C1N6)7Y>WD6Sd/dQ7?LMZE2&fNdDa[D8acEgXE\<W0-7+I.&
MSOXFN<UecgM/KP=X04).^]BZMQPTaPVBM,cV_1Z.)0d>5=D+,@X/4TL8F]P>^^W
DD\(1?5d8&H5g/S4(3d6L;<=7I7ZUA1(fd18Q@WOW?4^Dc]eS&9,?AZ;X&PII+-:
_?.]RO;38d^GTU)S;#RDeMeFG\0eOBL(aY@]:Y_7D.@>4K)&WYc(EQQA3&QK289&
JZ4]_4gXE:B13L6+@.4:\8]W)]<@3Y6;^(dK\Ia(J#ONdI.d3cb</G.JW?+:1,H4
fB1/@2EKZK8KML9aB++Z4[)d47MJ-:ecP#M6,BH,UXHDV;H[5&18Y/O5WX1ESXAB
9dINbS5f^0M5?B2cYH[-f&>B:8e,D_M+2+UC+5DQL9RBgF[7#+K\T,V.^1Q(RUDL
(T^[54?\TO4_-Ue;-aE9C=b[9[ND)66YgR0EfNUGQ#Fg)bHIX;^-H=O4e6B\SIV[
GW2+JP-YCN6V<OE6.E>V7.0@7YP,LQT^V.O_.)BeD18f;/W5M_3RC];5M<9AW<OR
M.T[D9IHJ,2RL>K\<Q-=M.5[,EC.ZXFKP5]Z7?2PDY)-=S4=#:Z&O0Ia/FS+^A@9
Z3G73PPdHJ:<@2TZ+PBYKQ:SS+K@Xd;C&/DgWRFbIV,?_FD9ZVMASLd7YCcEc-QK
7TAf,A0YCX9;1IB8Z#U+\R/_3]GfOR_cOHQ&D5fJA9@W0c]HcfGO0cJe^ODA:=&L
[(07f6Q.B^:^MDZ6_70aOT9f02.U,BU6;Nb/SQLCE=d6SH<Xe,cG2X5QAOHIR->H
V6>D4cFNN6;NS,7&@TIe:A0G_3f1+[RUYU,2.-(T1bCS_b7;FC.<(NJb9^[Q<Kc@
.PM0<7:EN[O>9-1);M:AK>\fSfRF7/7T3EWGX2gBT+Y<g>11\V^WKWcd<#5S8AdO
e9fQS<9QWdBg]E^Q,/947/OC><c4=NgVbCDOD\HcB1DNF&YCdCBK4cW+?g2Q?588
;Cb1P;.fEeD1:;R;^Sa_1@Ze7:?BBcC?8>;B=?++94.OI;/S>EEB/NDf+)/91I.d
0)3Gf7F<[Q?PP\FcSNFDeE[#K>-#.gTOOQW?U;\,WgWT&c@T#;I1><(0PR;@bc:b
:F5f33+8M;aOJESK)E0V4AE:f(H5:K3bK8/Y>Y6+2:8EeX[6UXf#;ZB^,ZJd)ZDW
e(KW1Z467RJL.Cf77475.[=0VRgO5M?gX=:Kf9/+PdD9CF12SAF@GRe@_(;E9d?O
H7XD31@(EZdXT;fA9)OKYDM\7BB1dI_^;D(a/@^>9:-c4V].SFb]J<EKCTHPd][I
g\Of)bNM&G;?Y[1_ddCEA1\LY5&\Se^U(JEV,9GG-[<]d#UdS)M-2=&\6+@,K[C<
#6b&=S0W@H?\JCg,J:&0^9Vbd7XUAKS,Kgg6gOKV0&SS:K11dUZ=^_@f,P749Db:
Ea+5eN:,,aL&b0NQE#R1e_=V7^f^\b)T8T3fdI,4V>cS_SHP;2+7+a5QMA11TS2.
b/<QY/;NK9CcDeQ^P&Z^G2W#MacJV:OB<:CC97G:0Q-9/8S3X)YKC?b^M6/.7bI/
R2Z1\2OeC420+b<TJ2J:-KBCDB_P5_?:1XG><P/#YEG,cT>,IXDRg4.[\43Z28I&
5\S43cQ[J#9.P#;=:@.H==[;.<dNZQR016RE#_\02E.7SRRN(?,XbM,SZ\c/;9,X
MeE>1\e,O]&e;]4&RXCd>Md@&D8[bV(3X):Ug#C&#6&#8)C29?F6JaB@(M/\3d,U
,[_eU4(B+2=G@aM9^01]&:BCbN>Jb;a(2P6[3MU.USO0=IFM0UT)-+AC9)S]66W3
Q(bYbSWU@W(7Bg7HM10.MINUa4[U&@ZA3f?9F59)YUH:b=</H>IX8+Hg:bK5Z=FZ
\-C>5V/.)@R+YH[OD-.P>R^DD1&.M#O4UBWf:M<DHe;-2\T<;d;DU]?ANZCJf(Bd
5:F_]:eC5Q2ZQ:+3f@P0?[RR90R3C,6>1)A<U9_?9V5^KQSQ:^&d-Ne(5I&)I>&8
46SY.Qc2J.(85/X:Q6Fa-d?=#2J7?3?-+<7K3,K[\#QZb:C27g_O<MN+8UDD62UY
P_LTVYOR)S^4VF?Pd.#AEbF1ZKS(g,4R#0Jd0f,+@5I+K.5<?=48VNP7#(M(KH4;
Rc:<;GX_<g9)5^9\1U<C<@b2S3e;dD:P&0>VQH[=0&a/-W:0R[CgZF95KI\ZNIYK
M?MM2=a#dQY=D:Oee7B&a?:@#c0XJA5#+M/)<8DZM4W<T1R:CMGfA#(2L:F28W_B
>;S6#_g+Lg/K.QQ21Wce70OKK#E@AI57FEQD9]27/^/:TW^=dBE526:+6UU.GX<K
S,:AGZHQf/RfHX3<>L24X1OWT1YS/>]_V7H7f734E9;GMV#D:@Q,WK\^0G7D<[)#
6]]CFZTGf,?/(OAN6;1>K=CUHS35:V\5)XC9?E3<IUCSb,86+_YgK.#][AFK7P4H
M7&\b:(,/VXRB\/B5L08HS]HJ-5#V0T:Z9UUH1E=c.]#NK-J0\I@aVW@XCHWAMg+
?-4DOg_7@RDMN[4?FC0I\TVOARL@.:O\5VIYed^,3HG83P9+\)0f2.4MQYBMRYWb
QK?Y<5(5)IDGJ4Ia?V?ON]1BB4cJV1Z-E,Zf^N5XOJN^?+d5H2(]-7Hf;_N2E9[F
-FfOQ9@CacQa;(H#7A[Y[2MW)CDb2e&++-QET]VcF,@8N:(,2+,dda,>I;X?_)aH
8SCH+W(5&<B[SMT9G]2DcYFH&\6[E2gXG=,5OPCP+Q3X#LB+:T/(\N0a,&Q(eWQI
a,UbVEH)QTc_XAg&7^CIbU(T_)-7-f#7=D+J>^UZZ2]S#QYHHXgD):DIGd9C0@-V
_ZLcb#S3GX8-0JZ+gM3UC&D/<3dJ9fJ3I]?3E96.-;I;.+OAGK.Lf&3C_dLVA0P0
1E@2XWON(ZaO[QLRO[H4+N/&P&9E+LE4FE).8KDe[7\,+[]L2H,86e]^;E6#).N#
/?>fHLV.IP1))ScFK\C]#O(2(YXQ[^5K3>3:;]NF8(<?eB7P[7(_Z31[g6?FL[MK
\.J-A0@5A&ZMX(K6A]E>Db7V2QP9I@-FV2(/0@#)2T,X6SEHJ64N5RZRF<g6e-eM
861GD.4RB;C.K&;#g=_Z1QD+BW@\4JXGaY@cN<@U5bKKCR,B6S-UXA5#KF)O5f9b
_BKJ,=e;DaABU(RXeU:T4;g1NX?cHM#PM@V6.1,]:8N?-1)XdV3S8ZTJeP])BZL/
5#Y&?>EY(ST1C)7U7E@(H\6Y&8)N<W_2,Rd_Ia,gBf@_PX66_NPKRaZPGFIUZe:)
C=&O>X9(a.<gN&.9WQREb3a9/Z-=Yg;M=A&50G9:JKe<P;@a1J#f)f(N)+0.@<.A
ARbG@f];RP--2CKN>ZQA>_O&LU\@eaT;TYV-94C>&:N2bW.HGP#YeF9=)C2dRB\b
9&9cgK-T5,PgBdec#1W@_0,PX<=dNITc4)D(OXJG7cNS)b#.B0<dB/8PEA^ZQfGE
(:H-gVE;54HF3@UZD(:3BP3V9O(Gg0[]J>cC4RE9X3dfB/fcCNWLSdHIfJZ=D:>Q
]D/g5fTM=CF/1]cF?YWC0B[X/cU?]ee?T+f\70d140544C,D/6H8aY2-aP\2E6]I
XBIIFS9XC;X.M,AQW)(A<@_9[,.&X7JeO+_L#O@Q)3OTg:,.X-91K^#369BQ?7Gb
-X7[-bS3:Ub8R00eb#H\W/B[/H>>8M7\DOA-<;H(NU+,CK^S(8LXWc768BJY0_5J
8.PgH>V/JXPO-A]MLJ2egJG8P&UfU#_aJSf0SX(Q<-YI7W9O87_+A=7Hd3JVI.XD
Q9UFY9A+X:UN:#d9e8(_+6^,>>0Za6Q615:dG9RBeKSf1L5Y62NdAYRB\=?DMIZ9
XDAA]KZe;0\0cUMeZ;PT?70B&)ZF]2TW:cY:2TDNZ5F-+1K/@-LAG+:=VC4:)Y\Z
F6<,?H]+N1V,C=>)DQ.^S\7&\=1Sd4f-0FV76&1Z)UYKXFM[/&AD:B@#CN2M455/
=:J98cK.,8a-MWY/=UHHB_L^^/-QL2&/ZK0/&FJ0Sg]7Yee0DB)0aWS>-4GAI3[3
;bS_ZGQ2OVD)f&@(+&,(&cOF)&DI??:gWf7dGYTCUc?XCC&BS?<S?EGI0>MNP#6W
8SL+F=V>7U>JcA[;4J>X3^9Q&+fBdO+PAaN79JT&#0cf,cG3T-(UAKOOZ<?[YZbg
QWZ/W-0PZY_U4/T/(W_I/_)3CcFLYRT>OZDX=LG<PFZ,0?80X@3SY&T/Sd(3Na.b
<P8WOTN5DQ9dQa,0&^G1Z^@Y&D_8U/[c;T&D:^>>/L<P=g]BdJ_V0@J0G>S;7U2:
;O),-9[ad752Xf8E?.2)[_b)I3OL,L,W?JTVUG\;0U_M22F^a^E75=FZd_^<A91\
[T]Q)6-,G:.DOY,704?JbHfE9]TU3I)Y-,b?WQ]7CAII]W5_>5AS01=H:S9ZNc?=
->MQ2+U\D-.\LCW:Z6-eL[eXA1RZGKd3OR^e_.fLWOdag=P>92?B0/&WWJ6O)PS;
Z28d<CYYJ1H48QRPcKU]6f#O5K>]?..>Gd&31b.AQJ0J#FIRROXK6J-&faWd;;Za
ONCSN8-=BeeWZ50ON#SFa_eW\fG,&&=0_Y]PHS[gW#+_Re^A\GXgKE-#Uc.I\.a,
X\I(7S4V1P2Le]#fJQ]CNZg\4=NbI6EVV1U)Q?^HMK01#CMJB.+FTX:fAM,2;GI(
ZY(^:[T5THa2:b.[0fR#IH4D^(3]4.DAV4TcW,3:7=7H]92GI6[7P)E9d(N]F3V+
16#L(U\O=9>VSJZa?8^7@TVKe(E2SL8=]EB&_?P:T@06AXP]FS-[8g\=[7GJD7UA
\cR7>MCS@JV-?;-2]I3]e@F?X;HJ]EVHCE^41:f):#(KgIM5Y6,Gc0c)LI3;[D=d
I+dAMDWFOBU-0[PC9?eMPW.UF&2E^-@I^gd6Tc:(Q57?XB:_(/NO0Kg4YSAP]XA(
:Ga?@GEX&^U]^\5:#SV1P6[I3JZLJH/JMBKDY_L(3&Y:]\(LD.Z;\D/)#ac&E=Q]
Ea8QJXdIFZ];H8@a8?ZeTceN#,Ab16QP<bHd83:eLN]Q+U6A2_H1SEc8_US][ETZ
d4H65WF=]@Va(MbfWEWLc;G=[?6R)Z9^<S,WRX[S+SLQ]Q11cTZIdU0>D5<>O4[Y
;_aZ(/>G6a,U:>a:+gXaV<@^De3CQEL7S;H&b^,>/Lc3.-^CS_baZ,>c=5Z<8cC1
RG)_1U52=g^\LB3\PYgc-,,N<c_S/;QDA>S+WXg\GU0/LaF>UZ.S<53H58QZR]@W
;<:9,Ke4H),EeWM#_7dHX37Ob&?H^8SV,bI;g-0DZI<0WaCB)IAK7OK6U:@26X_e
9]/_\.R,:.\.;)2fK9CME[DgXT&,a,6VUcD+D^TU/(O5Mf1PaC2:M5_ZIM:H/&C.
c^e89QbWecWg^Dc(U@Z:4Q+#ZbVQOD(:9D?T;d(ZE;.+CUJ.7K;Hc3MHATAFgY&[
Y9c:cQ7d8[MgG#5H_PYY86/M(JC[7DXPZ(>]3H<VNM0?ZUcd]4^e(ULKD@E(\B/Z
,Wd+7Z]22Y>8]QJaRF+<a\b:VT9gA?FA3WZ9=fQ8b-\R-3Kg#c0Ib4cY2]dQaOcd
#d#M/^1UPE<SLe^dc=EGNMWE2T-B)C]0)I-?HLMHH0L#(PBGD<2-RERZcDSLR47U
4fW[6Y_,&MGRMgaF9E6c5a^VAN7NaR?-PCGR#4f?/0g\VTf9Q<N9G_1C&=]Fb0F+
3&e0U.aU;-BHZ+&6BeR;U2V0XNLU;_BK,B7^7+/29VN^3B?M#9H8;H:V--@E2;ED
RScf<-W^.BT7U>dc5#-GU^]M>D+eII]Zb)VHSC\+b1)baJf_cP4XOb1Mg@-2OePT
F4?HA(T^Y+JMYTTYG[[#^</4;=JFX8Y>cD5BM53e^(O2+A8>=S=,d\d,M)B4[NAJ
H0Dd_FDY3B>B#(@42c2WATR0ERcP.030?38>2\e\)eU-[BWU#3)XN^3I8,O^I;N3
1SK;egDf]]L2;TN@a5#K5[0TTX[EKgPKJeD>+P]-9d^@C/?OX3-;>2:]H;d=_PW.
a0eV^,<4cGggW4/BXH/7Ha<=2:VW&[X\c]NJG_T8YbUZ_gV.Yfg1K0)5]@Y-3MW9
,.);/PP<Ebc_Je]+,91HG>[BP4aMI.e_BNJ:M\@N5b9TC-<_.91LLAI7(7_A)KfT
[UM;M-I>g0O_/Y=GEd):J014e]OM>>D1<Oabgd_Hd5R34XD1N>?]CWg82\6.DATQ
6>fBTU/>f]Ma\ce191T>>/EABO:LFATW]UT?IQT7>G6BTDe=:RBdQ2J:#UT,R=P(
H6f2-<K)\N4HDA(R]_Ue]Z(D0>ZYHA))@DC3WT1TD2c;f<,&Q70D^?>I5X6LH#3:
,5e0RA+ET=QaPU:I3:egT#1QJZ_9S.ZQ/4Vd7BDa-d)eM/<UU@c5I4G)8?FVHK;G
\X#J9IL&>&Y=[d+D/4V<:N-NEK&NWA1N;O>::/ET83^W7PFQM7RB7<F7T5EcLYf>
M0&#F6-94JFf0gC49b#DB./fO8(7GTX2AO[QJG;P,<CTZ+KO25JG7>UVU)HUXGUa
3.e7Z])XMga3)VZc@^QKQ3X6KMY:\Z/)4eV#69/6Og;?+?>2+?;^0S^\;7(;:OQb
YI<YNW/@5M,\C<+_V0C>N-dTKGP8Bb:8>TM\c2@U=;;c[cN=#7HKN,?4KO/]]?GZ
FPWO/7D.a-,\U7c2MeK0PP2YdU3LX]6WQT=NR2K)CX[7P6)Ee9RZEe&V>KGPfgB;
Q,0JXTS.7aA;S=>&bRYa,.<@d[1=2Z@:7]FS/O=D\OUY1^@I6MK3F6&b+U5[[L,F
CNI/18+]8Gd=R6U]U@6FLK3MVW?+GN@36IZ.fEgNW0ZeA2MV7:W_3@>f]9._QX-4
LTC->3C+2H]8WbJ]=Jff<MRC/g,[F2:7C]M;O5DO\)]@+E+ab<I:=/J]=MbCM_bY
8[0fgXPV8P=(.K]+JGD3#5@PVQK#QZ0P3\[7dcF>1OOSYb&?6\f,XH1M=4.,d;1W
6<FD^b=fL\5/c5-3P\+OQCcdY6Sb1P1;g:>KTS++,fd1VPcDA@#VW5-]U&@A\>N0
O&dB\@TF&=.+I6^cL2WFaFV:_f7H=;=@3ZgD_/.QQZO&<a&N@W7+1SeZB=agT[.b
REXL6KZf028Bd3M8()D:FA>LA7II8S:<1N>=Zb]Y+JZVd(V5HdZ&XI99R126W(21
&SA8M2dYA1eZbQ@/WG<HB(4,A.df[HUNL7VYB3/;EAH>[HC6f4=CPE2@eV81_DcC
[.KI.3_b=aEAf,;,<G/3RME?#cLFHF)22.95F-P;/eO@f11Y_DVZ^0A(ZHCg1+IY
6BLM/0SXb<5C40M)ARRRZ.O]aNP43DJ::J2HT/Kf-7e5Nb>C#]-U+6Qc)G50a@9b
.2PO:T_5V1_;DF;-EZ#B7..Y@eO]DZ,[Z)9>OL7d2PHg4Zd2DJR5@b<#620EJY^E
/fc&]&W_R]A5gG-\51C(6^-D&gZ)^c_@]9WK)?b-;IY@)cH6IT<\4,&-:38A,(_\
5S(YJ\+0@Fb6D/4AM5>J/-e&V>+b</G9c:f@AA]EM8WBZV42OIT;Y/Y^2I9<&:=:
NT)NX;)JgIgMMED6H?5VT-;Y/7]F,PNDe+QNf+:RO[XP\_A=a8T<(D80OKHQ7H@.
2Z(Z@I@Y6?Ef+ePG5QH.)/)U]G]XNN1(B?I.a-fg-^RBZTgRW/d?UN#JKGf]1/Ve
1@6S5_Q0RN?.WFJ)B0X62Of?bW2=AZcUVE1[0>;3/)Z^K\H[#9a<Z/];gDE?[#/)
?5_?d_0@?#7(+2DB@XHJ7V\<T0Va@Q7/;86P)7:<N3LVA0,_X@WTMC2SU5b0B0f^
e=TOBX[J;+C^>VY5,9;NP)1JOGT4/O(W)?J2TL1+TLSM_OdP^5XbLFW=&12_0aRP
f<JM1eRYN7_G20UZ9caOF8aD\^T=Y(YE/:\a@aWH5TW3;@>TIH;-S6?,Z1eJ4_TW
ZTb)W0NeOD[K@FNMP]_/3NI_gRTGe/09GX3=\?7NgQHJ^B0K)M2C;1#VcB5[fQ-3
,H<g?D,B7c_cOcE3=B0R<&,[g&M)+EDc:E3ZMWKL#I_(eB-SbX]T6(P<EWJD7+8g
6S.);PT@:W1c?O(+U2??\:_VR2]6ORE)#;9ZEIKXZAI5>bSSUTOV_]S6,GHGc.6:
VH,R]K0=>3E3XbVU,?5^M)=\NM;7VV:55Q1\fL;FH>4B)R/HNM))F)(8SACeNJc(
8ZMB8:d;LF>N9;BaVH.FI<#DBS0LTVI-&GPI+Rc5AK9\)GfLAf:(eC\8@cIVP52]
>Y#(64)WaZJ&\gTYP\S/fe3;[]/eEC@a4@BOU.HU,P8XX2)SF43b6W(F7/\EI\FT
<1A+gG\?RX-TG,6+c,>QRAH1Q53<8V9T^NZU1fC75?2.13#F&6a29(-IC?Y8XW+\
TSYYA(#:-2TMJTSdKNZ-YbUP)B?DF?_+VK2L:SQA@Y-\(4=,XT+X/]F;OPQ7/8F/
>cPID,/LRWL<b8&T4\W-&eX=U]?R^)c[gVW#)HS.UKVH=D9+JgScd7RD1F3Q5-Y?
[8&T^;L8;U]@Y6YIVR^X-2B^dIDFT&DJeRS6[-I_<+71X_e^C32-N--?ccM0E+]P
(U@R]O=IfH+:7:TUY@4C##9BZWK=&aRC;+DRb/C/e2ZNAfGZ=1V])#d\W6L]3SQ0
QL31KXeAC@>C)(]SgWTEW+_-I_]NcO,DMTEJY3NL1(JFMH?190[EPX2J=W+a4cMJ
&VTN?KIb;1XE6DJ7GK#S4Y,NdbYX^AYT4YKQKd-1EP4M1NL?)O8W:^f9:GJ<WQ=e
MZKNe<aLA-g(SR\bHb1@\)Y6EH8/4>-E)0-7HgL&:N;c<A&K&=f+OZ9?8OX#@4NB
)\6WPFJ90LU4&G;/1;E,2c7Z9SE)K:_H:5S5#6;#YPIL0IcTW7FQaFZ#Va@-FZW=
<&T_Z(WPX.(O\S^[0[P@e.6X[Z7MCa3PK/SA?eN,D:57,Q\FAB:+0I^(ELfQ^KL<
-LCNUd3f341;D)B;e-&R-HV<LVd-P@=>5f>1)I5:AW1?3Na;J(60cQ6gOf\CP.R=
?[9L_&g2J1G7Y9[7X9Wf(AL111E[BU4EabP251cBV:Sc;6I#=;b;d.83/\#3(EH#
AH5C,1>KV92I)1QS4_R8#@:\@\f-^HP<.&b^JQ&8B]A?Z:#YZ/T(fd@gN:>4A2#0
<2I[eC.D4(+ZRfOGK,2f?X:J;7+PIHH?@fM]8]I,,;e[Af779GITOCP1fPQTCY:E
NVR4ab]DU&SPb51ND#3>A5+JfINC-LBg-LOTFE4EOI(4acB;Y_QO4371CZEQVT+(
S/<QEFG7CR+=?b(HW3+XUZQ]TX6_PO+BW2239<Qc(L?JCfTa:BY:=6\_V3YZN#<1
S2)XBE<eUS27;H_aW)_T?V>fK[<Ga_ES&IHH8VZWfcX_YL23d:]2GW@Q7\0I;0=U
14?P.[,?b=KRE7RcRZB0bM),Y-@eO.4W<?TbCUgfX@GU?#&0La4^bDZ^[PW9=J8K
c^f.9XLC6NM3^6]#HN[,^QCY<.O[9V3SQ?f;LRXZ#8B5^(EE^DE<7S2W71Y[g3NN
KGTLF=d>-bY<V]S1QK66WUUdED6dL:cb61b3Gc?gW_7R>\O<#gF^D-5Y#;F(DK+)
4GSa).(CV=F5AHb?/B,&6P1<M<XaF?^1=.g2F]eRV&RBa6]1I]Pc6bH13CS,;UAU
?a1E.?>.SbG^X8XDa<;&><c^IK;6V&Bg3g+8PMC.Yg9N5:C7MU.108V9]_JOI9[&
LV@e05H<_PdY)YZX7+0ef[2+)MAOS/XffbEKP>P?-22G[CBc#Y?U^L]N&fY)W)FZ
E\>&UUI>f\YKXHVF?.3g(W\8.4W0P4E=e]fWVMKN3)gEEF/^Q4,#>.76gD-Gcdeb
:J0S.N6,^J>EU_baDcC5eSLZ@N65,6]c=TTR.cX:,,,5?5f[?8(5RNgYLL_C4^(+
S:FH[_6I.D8U[/>LPE[^K+ZgJPB+M@Y3NHDC[\<TWR)ZG13f>@NLIF@7W+aQ:NBV
L^H)Y>FJeg=+[;fBR9O]95T8?(5Sd_2_5JVOMV6b/@-#H]U[+O;#3.3PC:ee-J@E
Tg8]_J#-=cAgN7a\0#g(>WE4c2X[cW,.f3@A2-?Y[7:C,.#^MA:E@]&QIK=JDOXP
^K[N@TENXe;d6B\&_O=B2O.RU@U[#+35YLcDB,U8\g@(&JC7cGRc-Zd1B6_2\QXb
:-;NU)b]#(8/3)1g@V[OMSOQE=S//KHV\(9>SG[JG;QO?C\T^7NS6/e=:]+]X;<\
@M[Q6AMQeJgJ>Af(-_WOQI8,+H?>K@+V_,?-R=V7EK.:<1&W@I:TC#[E9X0[IYM)
,#&S=,KLD,W.GP=2aENQEe6g<[^3STf#\@&H+IP?;B;D[LM0L@_H&-C&@-c8CIN:
E)9[X_\FH)EfB].gT\XX:ABF.B+Og8=#L;Q-fPX(e:bO]@[,-_\6XQI#F?CJ7\eC
O0W]JWLNC@O#T^#dH.YT6(ROT7.,96I=G,R_ZJHdOC:C-42>G?^Jf:_2&CLOa/-@
0#3D\?g<,;7_b.4GHDTNJL,DC=HB^HWUR?BC;-3c^#:H[YFA8EU?_#SXC69[@?H5
R,,4XBKI5cBE0TX8)EfGV_b0M:8H3L47;XFOb][[cfZL-=Z09^WI>W4K[=[5A,\+
#\8_J)g6CH?:OWdX015L2f&OY1-]ad\NbX?9d9#,]=Q-5E/D_f)VR2g^:P6@?[ZV
HO0ZUYD_/Sc\P;^=RQ5\@R/F@U0a;L4Z3_7[KPceSLDHH2T2,V+H]5,>(DdM</>C
2;5M26Q>MZ+@D+5-(RdBNKb3+V#+;(?U..M820;9UGB[Q=Jd>@,d^N-=>9YX302I
cg:Dc8G,.2H9-bH:+g,Q/)AP7H5B/H6Ub?U63eeDf7+f?X#1+?E9JZC&:E<3IYUG
\,g@C^>@L+J[8-:\bX5S^]NN.E^f0aJd0DHS;WC,_fQ2Pc4OZB8#0HQ/4Y]ICF0;
F\9M(_VA:G7.01#HIZ:d-]\#c8cWLC(@3/N0MfA8?/Y>2CScO\PD7;+U+N+YPP&_
VV#H&=)1S]QD@e.^d6\Qff]=Je1OfXUM)La\Tb<;/P6)0]7NE2\2^?O.3bGA@+NM
>OOe-G^TGS<g^RXc<J91CL0Dc@:BD&\U,V1=U=7?W:g\DaG.ZV8SfFfIV>9;2;,,
Q3Ic;9L3)cAOKdOL&FVE17Q5+Od#]e,Y?U<-M0+.TcVE=:G?NF)Z.&b8fS][=I4E
UY8EX[#VDJUd2TUPZIbX@aSCB9+cT]GDfXdUK&<N2E.+/9[FIJAd&QHP:UT:fP8J
Se1[=,e&ZV69g-6(\M:?DSCQ3U23R9&4g7H1,_&NFXD@0EQC7JO>e6QQ=+Y3gaF?
>OT_?@H[F^gfJT2AKc<^<D27P7bV?KUcV(6<aL)c3F_a:_5E8.YGH(^Ed<73R3_V
>N.K/LY\4.6.ARXZ.62bF-I+[&)JgCd=[_YAgGaWa.PQWS]OP70_;NM#_bSX.g.L
Z^4S3:YVTca:a=LcSfEXb[@DZXJPS@ZD9,S;#1?9JN-6,9S6X73]CZNg-SgT96fg
6HN:VBFC2A])^FMb6(FCFK5P;3\NLdfc,]F/b-XY73VR@EUZ48f\J1b#[M&D8NE;
X9KR8G[3;)c/gc=agM>C7fJ@A+2=JO;1O@D<=;OMLd(VeY_C#DZUJ+P;A^VXIV03
aQN8VMRG#5W/Mga#Z5I:&,<H+GZC:?:6]OM2HY=A8@WP;J]DNHQe#F+#VV<Qe6TJ
;2S_OK<5[N5:&(,R,.a>8&;EZWP4\TG]T6;8=:W#N:<P\N.T0VI/5>>d6.7WY\_:
E1f?dBG7[,-@R<+HfgAJKNH:(\O./JAf9\>3Y2)&Y81#Y/)Zdc/GS1RdZgPC78df
gJG.S6#cW_ITIa2W9@\LfTEe[Y=IEP/UfJ8e4Yb3.V<HAFb4.L]^6d2;_f^5@26O
f(ATN@<9I22ENICGSAO[JUFd.)->KXLfL?fX+>6)HIWE4bc7CF_7><VV[)^Vc,O1
g[FU@?DK),#J&.X:DGL=0LK3f;?[EZC=FMH)FG8Fa-Yb]@8PBee>;WS+N6#Sb&.6
W=fHV2V:3#e7)ZJ@XgN#7N-_[J&RI-B0bE&DDK4ZLWad](_/f2\,KQN0W[CHI5^7
a6.EXM-&SA@&\T7JV+R.TA#WgT[LP8)JNZIC)A:V_>P4(TO?LG-PYc_5/O?7R]]I
G[>(D/27_LVJN--8M1?^g?:M9L2KAOA+CNGW8V9=M:SaHZG4.UgMTO0//3U\V^<-
@Jb_g\?GED-H)_MW&:BRLa3d_/e+@-]_.6CS,;Ff1L(\UI;N;Kd8HaT__,75EA^a
?Y>:8?MEH1dMNR3?a4)6=OI8g9]ed6?XRAHX_YQ/=fe>9Vda3Z\RJX9gg3&eK/\V
)D=2=H(__-:#;.6^V+a]dFHQU^<T#0UFN1UMX+WgBNJ(\\4HV-;8;JDc/8AFCa)b
B54fHFBd&CS,OERZV<G_dLH(RF:,g@/N[2ZD51^KZbO1\EVHF[70#gZ)Y_?@QeDd
A]2ASAC1NMYD^3>/9Fdb&3CRY)FFS5.W8g;M\LH<M4aQd2.[2B\)7TcB/_f[>?NO
S.,dP^0+&^=EWHMb+63._\/g)e#-YPTGeBB<F:)A>-d@QA?=L#;G6-EY[W8ZP:S=
4KI;A[57ea\U:a0f^[LQNS7QX.?725L-K:[(2Ng;_&QF[YLae=N[VRW-6KgAHAAS
>(-^CBJ_[/5@J(X45@F\1gAJJ+@LDAW<2V9#]20^gQ0C4c?@E1_VNT<EVK?UJNf<
)2._+O;DBGPf.EGRL>bgSIb<<KC(;F6#HWf4=V0.JR>)GV._d,/T]ZL;4WYPD?JG
]T..5+Q2:[3,KZEVb9=7@12U1ORCA96bS4#KE\fI72F3Y8DFTN\DOOG0T_&)5993
-J^>VLe^-QB.(AcK=G(>@S)BQ6(+5,QS6=bg2;KM(M2TQ_<LP^9X18_>ML:)27O^
@\MIO]9UQ4eMc&f&T(..D4e?0GAXMff2H.A/Y?SXM>HQD<=0ac@AFdQ0CNU;M21b
H4f<0_;M9Qf26>OIL(8A[[5&F[,GZ/EXg,K3)&+9=OPcD&bKc\>9NEZ>Y:J5X2KT
_4ObSL(ROQYZB1Cg^NA__fG+YQJ?)3KCWT@-W4c;&:8cb92,S0#(TE&5dAbL-=_+
8,c1),Y-a=0IFY.[E#VZ>4#deVMg?\H&>]QCADH,&T2Z[:aS,K#:7]3?ZXXbJcNf
ZY\[M7&8QWKbOHFgI_ecQMc[3gIKPJ:+-@/Qe\O8bV]M\860<S&ZQ?^OS?C//QND
@+?B3.VGHa4a^.C7EfM5P.a:UK.OPU.2G7IYOXP2BaO6K>MV?8MW0&a0M7/-<94c
N+HB7,C2S[5+.MNc_?^^9;eGN1E2g:HUV39U_e53;g3OGZBG2./K,Ra>(B15]2EM
5IeOPFZ:g&VF_ED-U\MU-<f[C.f,e_3Xd(T.10_6R+>?B)cY]dO_MY<D3A,]Ue>f
PYN8&_0T4H25CM=&>T1dI[KgXcb.J\4GCEf]9?)We89]&/DJ)8Y-aH2(HQ&_-MSR
Z#.c&T#G_8S>Y4LIRDJSbJE-=cLO2+f<O+1QLc;>KFb&>#-,Jg\EYaH@QIIF:X3D
YJU#Vc<P63V_RQC[)f11HSIGJ)L77FEM7.D4a:f@2XO)41:e5>BKVD^]J:))fdWc
QG]BY(^<-Fg1f&MHCg[\DL_bM=f=)=L\AFFUf8aM#OJa+F,?H>>cbL8LCY&W4WE5
I+a[F+NNLIG98<W9bSM3X(QL>K(d+,E#A0&Z&?5B##bCZ:0.abNJXB0T)+1.d-c[
<_/RIR#S#fC.c/A(O83;6@HaA#Y1^W-K+e,V)[(I#RCF/>d20?(:T[DV4HQK,0&[
M?XYf7/]DU2YL:HTK1IP]Q3MLC5bH@P0&(?_-Gc\3&B>d3J8N&\fGZcRG3^.?1^[
G?Zf5KE4T9AMdE(=X9IP>&26B&PHaFeWg/QE.F<=b6cRL[R9ET\<J.91faQe#]#B
Z5dPCUD]SNL[LW\(/B)&a7Y\HHO?)#WUBcWDI11,F;J#M8KgI(S)Y6a2f0&.[8EA
W.eWLKG_N?C;ZBB5,^TYRLMQWHVI&.1Ha\Ac=JY>:CEcCI530648G6.cRH8_YQeD
:F6^0^=G74,YUaT2FN08Gb_45=_J3OC3@6A\@?+7K/YI516(TJIaO(1Z6\0dbZS&
S88PJIYLG+^IFgO(.K6:AQQ@e=d=P(PW]^_fF^73^P/D[KWOR.ZI@-[eU8KFBdD&
0@K_]aZ?N]Ib+Z^V^-Da&]IaU\S\7,I-@83V/,HC51]bH(ece>0eM32[3(d3@NDd
9Y+6YQBQdORPPWJ]a_Mc9Hc8JWEXD2cAZ4[,b4]N&7B?O>-A>>CA-,A/81RJ09<b
OW11cZ8D#K:DdJO48P8A&W<KJR3+M4HX?JeYb<-e8XZL5G+_&N?Y-=d2#Sg@D(5e
8WK\(?0f)F[@<X@&H6a8d]\I09QE76J\3[@KW979YfWGd=M4(MA1Q[86^LH?L-H@
3]?IaHH7)_V41g4-=WM6]WM6F#Q)Z,ULZdcG@Oe;egb#EFE>)2G4NQ/dE;SS_Q9L
/B#>OIY2HZ-d@^)3+B:;;^S3Yb9F@A2TUW87MM\gR[gRL]S<WU)XT:ZZafJ_8afI
Z]PBQNWR78D=fcdBO2C8T+]>dEECO1#EJg6gA=ST120T&OG8f<<BT3T&aFN=WOc[
eEY)[,FR+4-bN&^+2=M)_>2-?2;L;2M>aG1<V>)?QS[Cb>98_Bfa//MbQT,eb@C4
?DMa\_cRSJCgX#+>gd:>gf4VO/Wd#>C(F5)cR;DJ+@0G0FIC&Q4Z&=F]SG:QCb@?
eBX1J1(X_AYf@;9BbL)#;55OBL_D,LBR8/(Z<Ke2&Z-=f^ecFZQM-4-];BN,>-5d
\FGX(FPdI^BK7^BQTZ9VC1g@P6gCKUF1?&46Pf>@1F3J\Z;QG<ZO21e(UV<?EWG9
D[PIF+b27N_G_O4D009NA5c6F:D@])NVcD\YKb-\?gO)/\11+=[Sa<L6(B(LR39U
#]-a;F4X2/M7ZK9d)NPXBREW44C3.U:L/aa6^T]gCFac/JO_SF8b74Ae[KZO8[V?
aYQSREHb]#?35.LNYV-fc6faXS5W\S+aCGOIJN<db2I07(S->+>Kc>IH1R2NH/LH
2gX;1aG;A)c]Ue>,<)3#ZG+=T^Q4]T^?Ed>S<1AOdb0,XS@N\65eV:XY^;fBPO7Q
NHS+@VQeA1J?>(T;.4(.IaRV_R3:@+a[Zb48EJ,-QMCCYJ,,Z/54;,2]UcBGWUI5
]Hc;+&P]Oa)#c88_\01RGZ/_)/2&KD02^a?PG-a;J;>3[7/@E6ZgeJc.Y-;CeXK;
(8dKB3/AVS:&SQNG&)O6I4&OI300+7(F0<SLP2X8DH,=00LYK/R+VM+1D87P(#7\
6=UDcT:dXA^^\O?cNQDc]QLK6W3BA@OES#T7>2^cAa>OK-B4.I#&WU)+QaQ-#;:W
-[X&4d<d/,Vc1A/>\Y>N+&c0,)KMafaSHR@8@d=d<^?LYR2Uc8d#FD(^cMLXO+9O
&+GVOQF,4F225f&JOBKBF.;cc8c&O>f+6>4b>\?VIUHT)Y54C&e4E81BNPO7@AJH
KMW[B<Ge48g)J-bUH2R.X9_V_GO.0R^E37FKKB_XJ\@6Y>Z(-#6cJ_Z0gH5?G/5f
&0L0E,?b#fIR0G5TQ^MV:&4Y[c^R8PQHPGO9N9@^+Z_7W#QOC5\d&GcX^0/XC&4[
d\dV?:;Gf\V^9d^fKA:#Q<9Pg.O8Mb8;CN=+MXZDE>S=fPbCd5>_cA/#_DH_I?gO
f2^\WgG;KJ:5Ta&P)f@6NMc+M9U51]5W]PRH2dBE2Y/Y(C9Z;g&@[_5+TMeI/dFQ
XJJZ33T3&H;^,U?:9E]VH8N12TU@>M,b)gKe,F-<Qgf.HE3>ec/4B0@EU@C2OZb9
+<83dLfMM:bV@RW@JY_]N:X/&S9ES)Q5J-fO_4W<0&0.SM\<,W.:,FIcTW2?Z1ZK
KWQ9Yg(f3QYO>.5R+(:HZ>PU,VV\-/A3.E0H]8&gTfK5347/?LXKc#,_4.BD]C&-
5EBD>>?]F5E&2XVg4H0f[,46,HV-[acT_BdL/&ZRN4X+<##beX=11?_DHaRe\3Ca
OQ]=KVK+K8U(a7Pcd^EV:V+;a.8[b;SGXUc@[3]4Z]<><[JP5+#XN2E0H@F2G4[K
F:IbbX#aQd1[.I)>7<4.U0@&1U1?C_+I]1S]JJc;B(e-TA16dZ>69ae-d]0N4eLe
B>a1bL>M0Lb+&Q.\S&NFK8[-Xd<@Z,\,\AM^D-_^F>Y?[GMV)Qg</[I1&1+]ND#C
CA572UMF-I-9;M:5P]?=CWaK7d2ZSKK[Tf?FQ2bZ^eU)2)<.c18DX_W5d^Ee2TQ&
aecdJFV&_V-4.egdY<^f313TF_CCHfbgBaOg/:fQXVd#@S0=I[R+7EL?)_6E<2VY
Y5+3L\WL4A:(]5@EGN\8d_#73K6NT94X<N:L=\[c>6JBP1A]WMc]-dc:[6QCVXZ(
,Cf:XRC]DRKUFH@SRcK;A6=PH&]()cVC5ST8#QTRe,/G,^?[JM5e;.IGeWT(;+,)
0JgJP&;]Q\X)196?M+FPe&?1eB5\?d]Ad->GI:)Zc.2X,1OWP#B)d<>_@V\\L34_
d0c6(e8&2(@I?fA[X06_8W.X+FXE3aZ]RgLXM@fUY]Y.HCX]eBQCMc^d9M9Ic[?H
gd,,=Ha\^&6M>)@W<,IPf#6bcD8g_^UZa8Q2/X1Q]d(3(b/M-5dTgWJW;AF=78(1
Y;GeaFYW77d[J]3V:K?_=F0(IJSbI1+N\14g9.@U/7RcJ:DH5WXXF5Z1B)J2(#H&
WD2IW9J<c3Xd#/g(eG7^)K9<Ud3JW)H<J4S)#=XR\BeFIJeL3TYdGWeHV<&^d1<T
2@IJ31N(J?FIB5MY878T5CCZ2#]Q?=F@B,>P)(-gdX>c\R=J=K-/6bdOca_:14?G
[=g[PgRWP9_A0BVHAe+A(97<B#KCNHKMJQ8EbFQM1Ue,8dR=64)\T@b?aS9E4HXc
C3Nd?SH.d<7I9>3[#1/Kf^B1)F(+YBU<aY]N_d)&J5+f.d7WA47TdeN8&7Mb3?Ha
RA_(Y4fV.FU86[>G,/NCNPL:(BU2,[TVR5P.@=4T6.g;GdLYc;#V8FMEgX^4)d-P
4OBJ3e89^K29^,V]JebW<A^H#P>X1RWS9U=?e&0_;:bRG:)MFBa^O)LdOHfW<IAg
gCNH_MT(93(KBCM(-Z&TD?9VZS0)f-f=E?<1Nb5LH[+LA+VV9[6=J1f9.^G_XP&R
PCH:2/66\Y4PMEH#RZA,1&XP;0HU#=:Wa=H4_R-)9>eP6c-P:)H?MUCHg6Qf=JWW
7P\G7)D0U-G4:8g;-T?0:GA;@6=^M;7cG\GW].>GL&5bGNc2Y&]C\6P:#dc[9f2c
9X]K,6\H3>0Y#YF0ZAKV5>&PV]^g86R:7GF(WPZ]85fc(#Q,J7/F23))_Q+E.[P,
U-cL]^:SW\9RY7^Y\,cN=dQ39X&BT?>g)0-D]3R.Z@d9FQD\?CB0/,78XVQO.[/c
;^]FYBA7f6,GgW6X.dE=1MgZJ^ZK3/STI.,MEY#IBI#VEf-U=OQJc:1Q5B_&2#=]
S@N.[K+)P6PXJBL2;;L\=_&4c=M(afd3=AH&Y)K89?UUX2GdY=:0WV:=e,-eP9LR
Id=4@LXBODMQ0<VOK3PH,Cb335;L,EWc3E-]52Y4&TAXNDP[LR7,,ObK])NB94Na
gUQXQA4YEV6+,U2RF3&RM;e30aO23XZ0+[08E-@\.;57)CW08?Ug+:+WCXTACFLT
Zf6&H\8fWc_bH\EWTU.C#aK^G64C-a7,0=OBg+5RW]47CS/J=DPVfc\VgL6IFEY(
O]dV5L6A4:O196d<6UZ.=0d#(A=22Jc]V-]T_4263d1TR]5bbZ:2IdK(>H0:eA1R
U7G]3U(BZ_DMXA<VKLMHG4ER5_;3>+I8K4#1_b#>XSNKXe5OG+KKY<,)&@ZcH8N.
ER?HH1fX>@C5=X99ZSb::LPWXFJgT-;6/7M]eY/[fT/Pb]>Q#1c.5WQd#JVX<&\C
0(?^,=bXZV=64e(K54BObR?:-6XKW35,H1(_TY&KAXd2#CM=K>L:53ZN4<RG+040
3DE1+O)>A3?Ec)/[^DBdT]^=2X?OPfLJW+=Z#4L#X-65V8RYU3QK,0J)\G.46#dW
HCA;TaB>XX4b&9I]Va^BOJK56C<Ke;C+Z8V1T9=K+W#e8H3C3-16CN&KOacb0R:6
QT?OT?fE]X\RZ[d3WgM;#.J]S6PcAUC<IIG@L.G5_[d28.89gGbP;b74a#&U_KJ:
YX1<+Y[P8Q7AVLM)[-6[2H9Sf_2)-CJ1AdJe-OU0cP31>G#NO5?6C+,)^4>TLEc4
45B..g/8&V1g,WR5JcP+e4>e?Q2Qe,4TCc0ZRAWa@GVd\(EY^<Qa>W^/QXEZOJ9[
Z\ZM4E7]--2,#BP:7[F;NH.NCRd:BRD?QR+J4a1P#7E#c=[BSY,:=NZPS:3GUcLF
@=:<LIg?ec[HaKNF0FeR+>K@9BB0)LE>;BUV6O9@REZ>Z7(87d62VAM=Ndf,H1WB
4WS0.;d]_UO\Sc=fD_PD@;<X(.#A_PT2d8@&S5SF)Tbc)Og<c?@B?2)NF+QWE4\B
Ca(8>;53M6gcd=:R4(P4?7bE3g=T@V>T#071aWP:H-?KL)\X7-+_d^QG?J)bddE;
T-.3SK.Yb+f:@69eX]EdOLV?d6)044E1I.@/c;;gC2<Je_8G.#OWW(c9+<T>6a;V
-eP4RFJbGcdQQ]X^K2+3LVCY02P>A4RK@eNc@^DZTF]G8d/+>_)fVK8ESS-7QGFD
)N@7TNdE7O&T7HbW84512_A\W.>=1Q4QS&[g1cC^6N#g-c?9caeC7e>[4Z+E[N>P
eJ(5PfR2/1FB1g,H\WBB#2f+MgL4=D8#XB4@0QXdDaD2-f)-1UF#:?)5X,7XJSGY
d(aH,K1IFN5eNfL4A=RAXW+_D@^05#99C-g+C=C8EN924^21-QI@FIU:cIc5SPVC
&Og)cc^.7FI+,V/EN-F8YG2_a3H0f+NZ8>(O:;0LVX9A^K#24aU[8L/CAPB>Y+K.
HZ[=H#c;?\,[M[=A+A3R@,QJ.</#LRQ&SdM<gD:,6Y^[R(DO#B\OV#M(RE(PZg]f
UM1N4+aI#&(GPI+ab=@3YT:AP@QcJf^d?@Q.dGPK^V-^8ZZYf;1f9CSYU-0,9B_&
>S=CTCP:U.[6dF5g9@f(H4fUGV@+MS3GaWP5N^N/_K=+SaOZR7Fd=9-@U#Ma=:=]
7L0DFeG)4.W2HAf7N9d&:/4<O-^XY0K1R@KJ_@H1d51R]+g_ZAITfgW31c(>#ag;
1U^e<8IdgZ>5+HX7/CES^YEG8S];G;?eXPJVYWET@=Y<UC8.MM;a[:H?^_TAKG8Z
[=2^MM2++,0Z>#gfO];eQ-[4>JCQM30fXbWBCB4.G.RePEZ?gE:N(,R4Z=AS7\>L
FG6;B(JWJ<:dNa@Q.Y6:FF@/OQHD091@W^6JL,g+8J\F3#M#SMc<U#c>,:<6)AT;
V[=^<bCcLFdRDVGbU0>@8I,]Pg#\ZP_[V?gPSP0@f#Wd\AL0,GGe3LA&^cL+CI3#
^66PCC:CU[[d\XeG_[],P#QL.@P-6Ia0Y?66S=D6=3VNYe>?-I^G6R3N:5^/(EUY
>XJaN5aO7ce:^0-44<V,:(&+YcaCeCUU29/)<,/ZZ/&<5-B?(,9bB6+c9b@bEU95
cK3Q[6U)BH5:g+7C\B;#FCEKfT3e1-SK#4&<&U/OF&WB(C\4#&8?^P<3?8WEO#^g
ETb4Le1AY[-B5L(179JWJ/&Qe8B/:L08K]D&Cg3C+12^]Lg<\:b:d9DHLG(+<3@f
;bb(7edS1_53N6<M)#H\dJV?8FEb#6X]E]e>Y0aS-3SH1Xc]A:+X4Y?OD0GA/01&
ME(R77+O.bPK0a=L;137CcY82cCI>8KUOX2<G?J6YcK[:Y1;_>L)GIBYaR:9?bD2
8]I3RFC/aH8<Ya,QY-^8D0EMe7]EEGB6dE)g[ffQ)3KdL=.B8QcT.<4,@@4@MVBE
U)DI>B9LEgFELD.,F<d]SR+3g9-[7TT0_GP>f#H54VL4W4D3_@]VR>>:\Y=1WA)_
ReTOT^(Z[9beYYRWMf1\<500]W07#CR5D&L8\eAEJ-P7TVIV:G3M<WT9&M&G9YQS
#f&I]=CZFFZdQcfQ?cd\ZbD+ZG5VZ95R>VaD4MKa9aeQ?3EJSZHg4H)G;J(5>;1<
@W0533]J7GRaM]I-XMPfL0Y/SZO,4X6;]VaDZOJ5-P,.Q^MR04=ILe=BP.A@]EG:
#GAYP2bY_a(M;b0E6K0TBHb404G<?@HgIDLTBNJNGS<X4/>6b(O-M:@[1WN:XIMN
6_dGXCJFFTb=[[#4e1:G_Z(1WXc9Gg5P,\CA7>3RZ=JF>@LaTBba/(P(7^9?R,DY
CU#;FIQ<:S?Q]&cS\WB+gMAce=a+bNYHYMKE..d2@0]-.+.,4-\(,KYP1YA2GI6@
a=cH>E);)QMVa7=(\Bg8c6?cT1#O?9-<9J&-=,NFXPPDL3b@JW5F6YaMFJabKP7Y
W,\M4>D3_MWE?KZTQcZf)Z.dAc\VI1(Y-68d/^FJBMSX[Ia/Xc#@I3d4J3(HDSR]
1S=38>U4dW^1We=G\+V^7bO(9H3C,;Z5)(RBM>@#CgfUWPT(e4c8OPCbAG-;7gF-
3T3-&gf:bX>/HEH]3:e>=&3QbC/>Fcdg&\YfO@f+fNf/^[^3NC[<VU\9A/:,]4MJ
=T#@@cP;#W_46+&&;OA8OO^<=7BMYf3A&FS+N+CQ5C?dL]N-91W494T,J[3L[g-,
NT\_G-fSa[7GgKEDWJA_4^Aed<L),/L8.&>_#/7Y7R[\d[NS8BW_0C1HfbdT#^_Z
bU[d-YfTedW1/B-9D502/=IL&[YD/I95=eBccO3]LKC&F3>CNUf:e]DEfU;>a##H
HOI(Tadd\H]@f#>,Wg:eD=L0+M,e_cM?_>;@)eLPWQJ08852,HI:F?<^aM/N+HF(
]ERN9/B2:<&U-a9BJ9)Z5:67EL1da[YE0S.bU9Vac8R_QU8ELeJeNZ[E.ER@A@4[
,#;+8d73_8d^CTDVRXYHCRdGR0M.IV.-@#Ma:_RWC9Tb?KTN_HA)cL++R\0,==MC
:YB-R_acF:9_Ud6F&7Re33>J#;4aQ;L^V;C.+;U1?3gZe)fJ].X:V7a+&O,Y82FL
?H#6UgWH1:,GAZ8NF^eG;)>J/L)8=eY=a+&;W6f(PVRF5B-UHG>:UHZT1fIQ:DT8
5O)W&L^a<DYQI+5]Eg_GMPBe93N7a9PV.RW_I^)=8V0:QaOeNA[189gN-F,S58E3
7;N\I,<JHE3Qad48aEH]bL(#]-GGgS?9?aYH?LUYR:XT(d0IcL=?b#-Q;g7&bTL_
L]GEVg2N_YU&5#QQ0TOe6=[Z3G-f2<CfH3M0D1C\C]U<c0-239@b^J&B+<;KfL9T
76WWZP<d]@LFFc:V0CDRG6a=^E3;CD:/SS^fP<fX^4/Vb0/4TPU/V]@=<UL5PS/R
93^P?1GV(Bd1^]b#X5H5LH:./F=V=-J@2JJR2;bJ@H^(OQ@XbcE4d7#,??TDAI<@
,fC6O[]-d(;G^IKQ&RT(68>EQWEFFN2.@WXdY&1_,BK3,IO8A>F]@7Wa#&M+X,](
H0IV5)N0Ee/,#(dW)TW_/ea7KL=QfN]e9a]9=T>-1O]B2RTR&@-\[>f/K#c<AP4>
g]45#g.GJ(JS,ZW]6XHXX_[1U0[CTI.EE/M23:2@d=N]G\aK)(Y>H:?]g6EWWOcd
?@I49VT>L_(KdW7V6+^57,27\R&gOX,NZV8A#V6#X0Nc&B<])#e,R/1ZU#KXgL3^
]3MQ.,F?#V5F5C>J>fNaF&P.(2HDPa9<a_)DA\-b-^.#AP_@ecQg4?-a0+W6(Ja:
.:?g/^4H&RT6ac[GOA@TX4B]YU0]B^cH;1218J>F^U>FXG^=bO\<@=2)2_X&^NB3
Id8@JJ+)^Y]:6;5<ReG:3#=UC;DKPSPb;,VFT#\YK;1[HTRfV\ZKPb8&R[feBVI?
ZL8N/.f#SJfAcU<.VcgNLE9a]YbSFO_24-,<>K[c-KBMeJ[c,RD>-CHUYND297L0
4X:CZ_MYQTZ/[H0feO_<BG-g@UMW(/?<fLaOL=_b87^H+-g6(fTUCB[5O/@]C37P
S?gPRe+,gUPB,\KB[V8W78I<ZM3BJ&84QR_#)5+>L5dZU^(8e<X/6&7O&=G6DgA/
Q[CF=W)Yd:OYRC+F/144RYD1cU2I>Tg1?UPQ#<A9F@\FcaLBd?JR<9f8QXI#573M
FXXIbdF40IM)[&BQGcCG[d1c/9IaG0a<PCAG+(\Q1TN[_XXf@U@X<:QTM8Re=GQ8
HVFf083AC.WD]>>XJH?/?VY8;M5L47:aO=V+,&>;^]\FD_<CV0Hg/Q^<9gYcMV#Z
UK&9DW1<MHNOZ#7+g=K:JLca2bZ-<5gVB^)M#A0>97DYZ=+:3H:eBU/AADe]5\?#
_/1(/.M(CHHB=CJdDSB8VIc]9L\SPJ)W=c&g9P9F(L])5VZ2^;?8KPIP_L\YaDaF
4C+b.)-VZHU&>cH>&;f?>3US[2a+)V?J./GL7:GUSQ;&0,S?FV:SM:6&8)/&E;/T
=2<eO+L_+YdVM89Q)=;CTF0XQ-@gJeUTaUA)Nc_8a&a3UVII,@9&F9S(4dE?HYP;
6#V;@YG7T/3LZ_g5SB+Q4<+c8YGE35/V46>&]AYGS>c[9:XOe8_)L9f^OA-F05B6
@GBY\L\A=L3)Pd#;<<(+6BCUCCbEa&I_9U)=RH9ab]_>eR4W)V<1=-7Z=@OXH_S7
AHXAFEOATU18,b].8;@?NCUD&C:LOgTQVY5f&FJU/=3\,9bRB&?C>L=,\CbC--S\
WT,+LcR0Mf=.BZ[L0_VZYNL8QF4,K@PHW@I7Lf20:,SOfBMb^C+S1<X[TOR#EdK(
N\K&::?4E60#9#<Y^VW/T2?FfCEc7X.@Jd>9/>0;9aeTF#c^C4(0,c6JHY7(CFOG
^;-+fYeBc\L=8C&=25,>e[_57G\_>I;3#E-7=#1gY(KDf[;^R[0B5_CM+R7+[7_+
aKf]c=HJH(XUOTQ,dZ:U)-ecMO4^5a#\UdYG9:305:H;6.dg9Z;16eM?:f<,e]@:
2BMN8[NHVG9-;H1[>J28d7H&A85FT/Q)ESB]d?SQN+g/00[CV/8#M\DW&5>IW1_W
:Zf1O,_.<(QSHW/gBQe-8_a)R?@WC;HT6eae1?@97_IHe1,bWc&]_c_^;[^[<ZG+
=5B=<5@Y7U^L:JAGI=>AX#gd;SBDf0WKdV\[=^[\WXH,?GJdTD1P+0->a@EAQR(]
@+8J_0f=2[Q>3-.(0\;:A:6=36af_1eQ+g<DO:6>&QTI<MW?5L3_LCa1_](?Q?KQ
dY,?D1+c7Ec9b:g<eNH_(T+F+CP8D@P@R@OWS5-5b,QQ=]6^,2f&dg/-PH+aH/+K
Ef-5JfWJTWJ>3.KL[DL7?;f_F5(?8OL07D=2GSC21U>/WR<#Y/4DM[Y</8D6Jf_M
K8\Q@/V]aaKV:3)FR_c&Y@<Se;_a,+g/5_5W29[<8dgf7&cFBfafN(FX9FA\9EfF
[f=XMA4K?_O591RF,5RA_81T([?44F<XdOOE./J\Q8cO(PWU;CBW+fN3A)H?IS0A
RP]9N0YPA].O6XDW.f;,9G\[A^T/&>&I+-YSFYH2fM2+cbIfO9T:NXSKc(0H9d_=
:R.Z,,,T>2gBWGbf@YaD#>8Z\B#].OP>2\^T#aVJCIS7.T)38D&&8Q]=-CU>b4T6
H#.M)4EID]gFFTENQ.A(Q)V2>OfL8;bR0:)=4&I,S6UC-a,AWd&>+b^BNKKQ&PDH
H<D)R=d:8:NS]#?[\0=)O]&.0T@8W-A,?a.,U>+a?JB76LCW#8E9b-V#UbK4^U2d
f3<4aK]Zb?7N\@gA@c@Z+^\I4g[Q5=>EY:W2U>WWX]V4>G\7?Bf)@7._E25TWW[H
C&K9;WN0URUDd?UH55_03@gPM_Y5_3e6IP?Ze[\1E9=7b1]Q3]MH+/[GaGOMJ@?P
:PEcV\^0MCL[GJ-<NX+S4]cK+R^W8?X5)IHdPB^EA/0/ZJ,U@2b+g[aSG_/?WMDH
[2g9,AGbS@F+,LY9RN;#2[HEM1S)@U^MQeR^3ZL^90g15I3KYUENK##R]f/)^2=&
HQc<(A7(Xf;=JRE@662LdW_PYgaB&dWAC-CE55Nb9@QL2g2B10@P^2(Sa7R+Cd8L
=WIbA25LVJY#AGFT^;1?ZE:)ZN;dX?<(cP/f)F@5e+H9X[YFbL@9]ZO15Q8B1L?H
=L@VMJ>_#c3Q6+#e@Z)QL;X;^SeKMAE-EX/G^5&4)Gd3(9g]YL@J63,RZLb<LBbY
QC;A7MIK^#0#@/<4:fX5-(O\?gR4d7O]Q@@-Y=@eB6f>EDF(O)gW-._)H+aSYB2&
<85]4c3d=.)[L,TJ\2?O6@Q2g4SIHaJT_a?\[S-TB3?B#>FE-Y>.3?]X5-(C^3g^
4^8_RP]BJ/f2TTLKYTK;K5#J)+1X,-LT4=B6Z]W#fTW=>)@6>CcZSWY.T57R&TdY
4;W_9d6W6A),@UUBWW2L6?SX()&C#F<P9;[P2XX4?75G@d_gEb-HL/YdAW:8Z]M7
aLFD#PTM_2^9SOeA-c.\4#MEGAPGcf05]g>--[I6TU=[3]CUbf/c0M>UQ1JE-\X7
O9JAE]DS=+M5.]0b\:/)b^O4QDW-(^/@[\2&3)Kg]WN5N_g0S\_T\9L5NM+?2_GP
?GcQ2N-Gf7fL:UG;d[R/\bAc5Ra(c#&/TCUb9+4TA61;UbD[6N[D:P?W5R.,a@#e
HY.8Ia0b@AQXa4#[5;IH2e17Of/KQDF4c9ZCY[<K-aX&FMF]MB:[A+ETeMGG8DM7
dMU[Z7RWQa5^,#1gT5KSQSTS@=cSWVK/#dBMQfe3<@9\6CVAOC7+2M0,TY@#=Z(9
KdE&c#;2<4[,B?d51bSbHe47<-^@2MHSg^[=U6@PPe.^[HG4A@J@aNKV^fHT:52-
Hb:Uc[S-TQ#W^:5.9b.(JX1,=F#DKc^2D2YY+7.E262+4+GZ97N6W0V::f3KV3^b
73f72ZY\&T9\e.JO_:5f.7OIBU_]\U\JL?Qgb&UD?.H4g-QS_ZVP(;NYW5@DIWN2
VB/L2[+.G)&FP:H]BC-N/#Mf#&SM3^KG/#DH#T)8H/01+Bf<SfL52Lg@WKK47&Dg
b..TgMC8RNOf#2?8d\S5defI;(P+CW^-M;H[;:eK?cPaH(73JB(gg57>a96)F&.K
)=P:a2eE9gQe,Ecd^CK_@;6>\NaF/6#AAg>a0Yb<2>f=2OHIRHd99)5(5=1SV,c#
.PB+PIPg,#2R^Q,R>e@J4INBeR7_I(3+A3FM56&>PJZf4c+^INc/=&O-U7G@QdGg
RNS/G3RP;+-Tf0@U^.JXF^G<^-[L#Yg;&:29[^#1FPf&G4Q#:4Sf1,/KE1EEIERf
#M7R+.IX0J7_a;@=QQg.J+f<GSS)J>^\3C&LJ?fJ&7QU/a]5<#EHU)V^H[;1J--Z
]BZ44#B\0dKPQ##/E_H-VW6BCH>7F)/#.RCRQ)6X/gdgd,=B_@Xf)=ZA>MgR5C+:
#F4E0NRe2HRPFN1QYcB_AITKL^[QD+aYO.G9+-^YA^31]P9c[=X]gdF3KP)2+QR:
)1(V^fZQT0^O&ePL84G,gG4>:X))aA/-5e4LGLIfMcEI+I.9-=19BGb&V<dJ9T,U
-=YALP65ga+?cbX4KMEXI+6F;8YU<?8bE;HYI_NLD)=+=O)M(QW2]f7S/,ZS58a2
/=OYICWS(26@?F?OZ<Q+f+3CWRKB?dd0X+CdHL<<4f2=b0dF4WXaWBJ/ZeS</>ag
0+\7H8Xc_O=#.IVZ5,&bTJ;IX&I2^0U.f9REC)H+[W++_D]V8d/>NF\2V9^28EU?
cBR^PcV,SJe_b2_FN+7S5a;.N(cRbA=S:?E1V]74+_dUTcFZ]J1+UZY@@GW7aVC,
H+AfV1/Q\Ob.eF,>^/+d;,RQ5)JQ6PJ-4/I)@/VYK1YS1JW]/,<Y4b^76E/0/g2J
Qf7_&+L.#HJ^QIH<-81RC.(O.R#(eG:2_8F:)YIgBb#=I21DKgATB)5R=CIQdBAV
IdO\W53&[@d;][gVJgc:++DYb:gBJP8WCU1MRIgPYdL]A::QC]LM+[Gac_5N5eII
)AR<G^Y#gLN#&6=QLdZ3ECD7c7TFaT26#)V<#LT0e22dXe]WUg#](UVI=VZG[ZB7
OBY5V3IgXfa985)Z^/+,/<cXeIA+YRW+[FL]Oa?XT/22;9^SaFfO4+LCZH<-eE_/
+8J@&N\.CQ?^+^;#E)&V>TI8GS:T6fcfP0=/R:Q]:M#+^6B_&@+V(<7W14:8<SZB
93PJ9a<YdJOV-dga\NdVD\,L;K(]\3A+@7@99[?,cbC\>K&#].gJEBbAMd;BZ)CN
IAcg(-f&SV>NVS02MBZ&+E#39g9MMS9.YW25bDK/_?W6;V&RaM<L^:5(;F(N<Ye.
&9+&F,O^9]A=Z4MD?&0;V#)T\g:.O2Ad\Lc#TXZ5F7FL4Zg3C4-[9EE832SL+9A>
/WRJgaSIf:GEbO:7,O]O]^5Ud<SAWRc;QG7=G>?W2T(3ZEc3>IWQdIce^YKU/?V/
FPQM[-;aTG#EPR9GZec;8WK][=)PO\TYAdQKDa0-cT/23><^f-R>ZbIa7MDB^OVX
U(WFX>OMMAa1H.X&fL;&9g5NK;#BTg,J]\.]K33_aUJXf)BI,KM0X7G:eWP8SOdf
1cBa;JM@G4ZAZ:CcQJAL@>ZVB5+\_(;FD7(6XWQ@MX5Y_FURC(Y:-[9-]BMc8;;3
:US;>Z0f;Y0S6F6PgW0I_bg)U)HJ0]YZ;W>T=F&5>3;\9D\g@GTZ]Za-BG939;#9
e9K;()&]&_1J-7e/Q/CP.U>eeR4#,PVKAHPRUN=Q43GM+]/=N<:g<?.PUB0R0++U
X(fb+P6+Ad5Gdb6G40X6:Mf@,]C@W?E<Of[b90SgWd22.@Eb;DD9K<7aN)]6BAa=
;@^S7,aL,6FdVb6YAQ-X/F9O422bN9(@&64&,5Q15A0bEd:Y;I54&,UVGZc;<A4^
HSRaFL_K9X,:0/)bF<=<QQ/S]78A<<20/;WgZ@Z\W9P>(U?Wdd7T9/08RV8(;a4L
=YT\(F)Mf+Q&S\)&\OE&4?[K3?0)(ND;]LF4G_F^@.4#&+;LTNG3B/+/.Kb?9@K[
9XH[c,0\=LUbUL=-<Z/R)AbOc2NA>OC^WFf&.9(<)B;DMe)&=#dS9HggFPKYRd^4
>+4RZa\[JDC<[;:-c#26]M#0aOZ=3bcRC/TgPCLPX7=Y>K\K_]f9Xb_?7\]eA5&A
(BcP.(6?0Ud7;cbLU)+7Y+d)/gZ(1ba-4;2O^4>]LR9:13K2K6b#0O08B(H^1cN8
d)M7OX;:O[Hf,DB<XR\^@Y4?^^<S2WJ&=P#TB0CK&WCTGfNA,8:2??cILRLc@5LB
&gD2Gbb&D4?XL4[E+fPa#GRKX^7XA]U[3(F&?L_?VeJg_c(6C:5TMOaSPB0df8G5
9.b8KXF([<4+#)](V4<6>9RU52RS[@<<:1aB@#0a@HL@2OLZ\:.-5:-U7I\03HXA
0e58C:G9)#SI;&)=>V:NB<K0<=-S95K5V)@e=6\<WNC@2U:RYAQ0QK.<&Nd6C0&Z
KMZ+>dT]+U),A(<KYK>=E\3]gLTMKdL-41AN<aI.aBUV<R3D,dVXRHR2\eN9K\d1
_@afJ.@W5a_5X;8_[4aH26#?NCa4\GMWcSL\9VY\^@YcaUH5bN.FgXL>Qa3CC>gV
aWA/RK5LAON0OC&fb[)8O[AIe1:@e+Mg0,X;[g<]6X(#-3VCV.XIT6>_0dSL5V)K
73dX5We?XP#5CMG+.Sc]gG+Z,cHa7GR.4P:#ca<b2[EL7JKeA,(K]SHU/fOcK/ed
V^T_2.IBADG;??(>-)C<.3P0f/RBE)ECQI4c3eIQB7[eEZZF>MJKPNJ(4UDe/#)^
f0Oc+?=B[MM2<WFfTO:PTVcd,ZAF]<HZ;HM0dU.;>W5]S;UceV^WUC(3UfS9d4fD
;=_.1ZA4eK3adV2/+R6A.0gaUfOC9WG<[<P2NB/3gbM2#8H_K5.#)<4:3:dY^Cg_
;gMI>3b>_G8U/D<K.a8@X^FK->#?#8[MOMZ@+GR,UE^>1./VA0L0WI)/ZM@2<&Y@
g\@C/O5FS<[I1CA9P5S6VbdL3WKcR^FU2+4e,4aH;f&c7TFbU;R@a6_9?+A82<,H
J4]4&PJ\[E/T/;8\(G8<W@MR8NVYD;U4R/3fE^Pg41\MV)LD;\PS[_>]9OG>M9HE
9.8>NEL(NK44_?XP5\8QXIPM\B9SE(>8;e(;R?&VM^d/RNX6=@6fe^IWN;@#0F69
LWT<:;QMH,FGRQ=R+^D>Z^b>Ra4-+I@;><-0aS40]2>?XYR9SIJQ=Q0NAO\9820]
&>FXCGJ^?MOUBW5Rf9LZb13gM]/6/R;11^64[.L_=6)M[-51aC52bRW?XM.-Z]/8
TM0?+#CWgT0gW+4-bYEOd25@]()JT_MKT?K#8?3bJbRL3S.aB&6SZX=;AH(?3S>+
=PB8L&aKfeM8EOY\:W_?X5=@G.a.0@7(&II?6_#gNcM:\DHGOBcc0f3XN\WXIRNO
OZ?:1I\9+J6Pd>7Y7.Y1X[28[5--]d;R6?g:?I?J=\017Q0CRZI\=NULHDY\ee^d
fBDd^9^U35W)]@H<.0BXSAMJ=3XF@_aaD9UKLeASZ6R@KU6X3<HWJ4)Rc=T@921>
CEL5>KTR6)+c7W9Q,X6O60LW,geGf(8=0PUZOZEMV)1:0Q-T,/g(92BU+ZRfc3?9
]K.K.b49LVcWK[-9.eKfLOO,OD7;URCG4;?@=Z/?(-<E?T577\[&<P;^@0DQgdMS
_2W3?a01Z2U@UQW#dEN)Ne1L)9FE\\d+6JD&#&K2;1-U)..f5O<.,LRI]X0W=XME
Ja&M6KH1Ee]/b?+IM5_Z>W^#[?U46A-[c3aTLc-<5a]N,bQH[VX097gD_2IT;CfK
.L[>1ebW)QO]_9eeFLT_+?QOP:<QDcM74LAb@YHDGZ@g)_CY8b\?=SP1ZKWaI&TN
VV0RENA_QMG>3=47YS((dEN5Jd9AD6@,DO?\-3d:<K)^IX4H?H]J?1<EZA[;S5(=
+40E?e@4Ig=?AB&C68D=8=]aId6QEKd\RUGS=^0_1R7\e.6G-)BHD-d+dVd/e(Qa
7B-^K/IVS0#L;Ye8PL3f([73bIS]R^7SJFfBASL8b\2WT=AL)NgeK?RYX^M#b3DD
5Taa<Ud2G.?5d0c<7+#5PgR5,YF2]&ZISf-/=fa5^3.7+4+R7SAH8?6RLB6W^HVB
YO>M0\H_],NX8:bPKF9fFb4<3c7B0,._/.<HV+G=F,3\2cLa)@VI+_@g5E&QGa(<
7^8aB,^Y#c^R5P]S3\)09+8(PT_V<We=[5M;I/^BOD9G)cGDLYQ15U(6-NN5&:gR
OMO[NPN^AH2.c[FK(dHAL8I&Fa[d0/:68:+-]4GO_K1GAACD]@0164-I9F?UUHfV
FQ^Q8B.bdGYc2FRIZ#Z6^a\R&//J#.M>T]CFg#JC+G5^DDLe0,X8.:>Y9E#UPZMK
K_Mcc<V9C-<P(O)=EJPZdgK8VL[R+9Pec.37.aA)9-Q&[+,POION2JUX4?^GGc]g
O0TZ-P_8@D]4J)PaZ-a(RT._D>]BG(4]\<RYQ)O]1J6YTg=#76WGG]A@>HX3K.6E
YSX#B2<Y>\Z<B0B;]JI88)8S^6Q#>],1?7@V_F3+@.6beGONTa.,0V]-N,@eW3N;
HW3,Le<+OJ6W@AJ(H^O2TPc_>H@++#I1e9UN^YQ5ff_8EBC6=]26^IPD8G/XV:3S
X<5TJg09@29M5JRE:;6Y+J:98-CC^[_C=B1R9A-(V>\VLN[O/)QG1bD7.)\.#42A
I#Y8CXIf^AJ5T13cSGAcH#LTe-a8g,T,3Y.LDf8G&^^c<2D1X=)NWfCB/a22/QRc
OXL2fF3AcI^R[\9EOa@=T;,HbNeLIIO;Od(beceV8g^4KS:H_?,]>VEbOJNU<JD\
6g9R5W/=faBGg87&@2_aMW2,CIF\H0DMaaYO=UMSXFNK:LGZP-D)4CO6-O#AIXR[
U(Q@VVD[a7QOfR?gP&-HJL^P<f.f584I^Bb8[G;J#;cB[#3#;e-]DC+&eY2Bb<?_
4N,RP=F;H:U@RQ?@aB-ccPa9VE_[/\P#--C]04bJ=MK:[MD@Uc#K]\6_7O9W6ae-
X>Nd5I>?W]=]R_]HG?/^W6&T/<ISO0@/1Wc#1/Yc6^LBOLKGY_Qcf=2>1]CA6b-I
SUD_10>f-?C=I:)+P\E#S,L,<B_T\>&Z>]cGd=(d;;);B\./REb=RL0QdXE9CQFK
fX)#.CN+1^[88>8EQZbCWX9X-SS)BT/Q<</ZaT9&A(]\X+dA623N21(d+FIT>?Je
/9NSfVcC<SOU&MfT)3XH>RE9?>?J=)VdcFL?=G)[RQ_V7XMU=(45Te6dS9A9FT8e
:MXIWIB]M:0[8eeT;5[I<2MH=Pf@c0V5I3L?e:ag2X6GKO?PHdTL4]RcHO^G,]6/
C0F@MF<0?V:f\E4E2EQB3[eN>@QLA;-4/a4:.;YUJ>NPab?>WU)WA3b\T.9MP9JR
C)Mb6O/C[R:R)cICIF@T(fa?&>;#I<;&1?[&+/N>U#.=-TWFJW^;4<65e2-@4+=I
EE^eROV/RLLJaN^8a+eO@/&6bI)&_UNOM^[>[3D61=PG)TC8HfAQ;G^C,RBAWYa>
Abg2eWV6P>Z0gQ[7P[,^/YTCD/L/;ZdHcVKMf.#I4ZH=dVSU.YCbfd,g(\B[AO_/
<&?^1aNRP_W8G#DJ>;-__6\MTa;f\M,KDXI9ZeSc[I)&fGH^J(QIE_[C511)=eG:
+S3,?#GCY.G0EJ2-4M(Ig>3Ja^Lb,-6Q,;+(,4<(>LHOJVKE=MHCV(T3:7,I\OBO
-b->c98(@e/@K\(+@&SE)MM0^->8=LaO[HY[dX[-DgUV>XFb\K;Y7W9/\7JC0SLO
OVE5+T&@##5^_g,?;,MQ@Y:f_ISZc=\FAd2,KF#CZWc^Tb,/=>=O+D-ZcEf9c?=<
/KdC&R+GMPXC0G30b(Qec6\>31J[-K&3f>LS^(5,9MS>5[0VeRbGgX_CUVL)Tb00
R/ZLL4<&C7<[BW\0UfgXB^9B7@c-c5-ad15[B_]&GO2ef+#g_7Y/&#,GaK:aDg6W
F#1A.@bKKcS;Fe>R&WH?@cYH..APCV<4<?WL)A;IVCZEN-SJ5QA+0d-0=;X,4DGX
##PRV#aW\+-P_+.Jb[a(EWg\\[G[J7??M;\cD(<>]J_B)MaWTe.[N+OZ2P97f0Pe
1^621]PNZ,,YMb2HQPab1=RIW_O:,D?^^X_<RJ8-dT,N>d)cNRe8J;^1ECTe<eaF
\9MCJ2C8STDE+)=,-4X6YEE-,5bc&4g-+CM=^a\S02X\3)>;=SW>-<_NC>aC?2;a
5_P?PdSfFLYYL_^5+862_3g4[F)g_\_D8[VI9/>O)fW2\QWN;O6Z9E+XXcC&;Rg-
HY0TcT9TDFETY.<ebT+-D>d:BWIG-:1e9\9^c]PdXQ=A3&];#>KYH0-IH[)3@>&\
D9JJ==g?/3.>Q7_#(.FC?H-68eHNHHMN6b;&:KEW#cI5;YLTb-CCGbZ=-b-34-/1
4M43QBX+?dF\=6-c]^QG7PV[U^f,\NNN3-#@]7/aE)Dgc,\,L^X/\C:7Y7E..IJA
5-_H-=S#_=N>@:5H:Jc>bBO9SMGe)V6HQA1b??DNI+[H>KNbfbJB:76&]HPAR[E&
b+:f+GOa&X_Z>VRa6T=U>+0V;99E/]LE)ZWK@MCfP4GdQL0(6g.f.\C9eJ?B]D15
S4<c9_E&FM[ebN-LJF+&&:c2_Y&[[X(TCFa8RT4YdT4[_>#YX>XIVZUTU?QO+_=]
eDg_)9&B1NF9>ZEe3MO5LS1E-9f:T:ME&d<ZB5R3faIgfb][9W\G9]Ld[];^eVM6
0We1.Z)>C>L7Q^TWAHd2N^C6NGca6QD&f@V2;dX.DFE/LVO;EI]U^=,BLDN7(.Vg
8V)@^2KY.2Vd(G5P)2=77(:DIH/(f</W>,d;J@[Da_,L@QMC()bG(e8Hd3.W-Nd)
2(^UTM\6+ae#<0]\?-/Z4N?:eBS.^7)-8fd+>_\=UNORea\1.HZ5gP4(a+J=X\N,
P)&MF0b[Ha09.Z]ZF/LfS\4WIOYST0/GWQRcG#\55cF);/A67K19K\8HLZ3+G7-(
E98gDNM#UNb])>QC1(.WYAb:J6?3F8HK4,UH0(?Z1JAHVL>33D]W3T[(RLU=-B;>
X?LBCU>3NV_dT,1#:WT@DDOPMb&gf1?C.(0QJD,2dWDfX.=;BD7Z+L2#68.9.<5M
<##P(8;@\g0#aCCc4cA9QU7R\6M&^-eUc;SH3^(+]3>,QadZ#?O^508+V1[,PA(.
4MJ4LeOO+e@WUJJd7?#HX?I&X/=+gPH+#<eWRE/b@+9-,eVB^X:Og?Q^J6\A4P0Y
[N8G:.Q.YV]3MJ:TJ<Q^\<9FE.aE]\VND<KBE.P)MS_D:G#4LZ\gLSB6T[-+F#\R
>IR?2KfO+g>XL]FIGV8fH8VUHcgFV1VBM(aTf@.eJ9N2Qg[/O(_C02JRE6\3S1/=
&)K^a#]f,Yc]OM1M]&MXg^QPEb2M/2;HG17EU&eO3[T>AD1K=,M34D8Q_3/AU,dR
.#1a8c.\RDJ+J&,,:9&1/eB4]<gHU#_K@Yf+;;Y5.E+@4A0Z/5,WOd)/K+\eI)ZK
S[d3gE-.,5bN7,Ib:S;6H<U[3Y1(gQ:cMGMB(Q.4W8MYPZY^b>VP,.1;H3,,N224
0)OOR9NZg@JJKVHCf/fQJ0.e4=D<>Hc8APfW/VU6HS<P]2Kb@/;17[#RGL/I-,/9
MM;I_TUdJUB)GG-SG,=[ME:KZ1PQ=+G9/RGccAWEY53PFQ3Q>#V4B<15JLNV^,ES
VeJZXfB([QRX&@Be/VXM<L+9>F(,L1UH<MR9&X>W@8d#(G+T\7DRB\Ja0EWeOAKf
U;=;I[.[a4(@-d0#eC(eg=7MB8]W)fN/0bM[E5adBBC^CMPc&bW0a+5I79A-CDF1
8XVAaOE]XBXd>1(ZHEe&)?Y+DZ1O7>CWES#@6GMf=eSS?(#K=_4BV/WfLDAN<.KL
.PRYZAg4Y#J>aK4LI=2Y/212M1BS[>=I=P/._d>E],,#I_5^+JS9eD;B)g8D6;P7
GGDU2:L42/ed\fFcBa58.4e(R_@C2aH).QBZ7H\?=&?deNOEL_f(3_RNBfW9PSV8
54S@PBWbe<LUAKI9=(ZVF6BY[=bTaF7D>;F(0D^1e2295R4HA.A&dAc:-4?V_JN3
_80MI+^P-#:Z6F^_f95@)^W3V3.(U&4>aV54cOTB2<Z->]ZcL@7K8Hg<T\N^dWGK
:b<c0:6CUcENKG8^OT;-&LcVP#0EZ>?3ZJ</-WgQ&J,J?8H@C=9Q&XG]-I[L,:7R
09E4B^X79f0[#EQ53]D[9[0MNd#A(B7N\5O8,Z<Q=.SHZ<QBe]H#]EX8e?8[/g?Q
:G]aH,9AH;<R741F,1OU0gW\)BO9M9.fVeW1OgFR(BN>Y>,bEF#gEX[=,8,E#f7F
QQ<G;O+2L]OfM3MRc^LUMTSWH>8N8W?.A[gc.=L((:(>F$
`endprotected

`protected
_0@MZY\a5Yf0P2:[[6:R#T@:1V:SS7[_K_T_)?df/f5c]DF:IQ+:7)3B+BBT0,.,
KJC_.+.5;C^<(HHPLaO0KL]40f:E3CfQUUba+S4R4SF<.:QW0,bMbaTATLGZ<K:CS$
`endprotected

//vcs_vip_protect
`protected
PB]TJO#9Y^>]@V8XfT6YB3b;_bA;<,(G4F@#V1DfM5c;38[X8#HC,(=f67(3c(2,
Z<J-ZT+b(0P3:_V4N8aQM1]RHM-Y6L+@50YW]K=3P>F3S]a[\2H^EMNN:K5@N(bP
N(XQFK,62.2\#:VJ#(VERHACdg[QOU#JbES(fME+OB;CPR#LIc#&f:DN47KaMOB>
C-<W:JKOgT0GK7-8OR:#C_37b#\N;\27Tb78TZJYggddeXG/+(35A<aZ=05d1>:P
S5ge7baX<b1OS(>-6>&SRU)#LMJc6BbCaUX<CWbIXc>)?DcV+X,FG&0P&TLe)BSa
&QOFS-QV5eP_Eeb3c2_3[VHdODB+6&a?I^#gRc3(JG;^F4CZg,821^J]OR:\.]1b
1cTYE_VBUe@E:2f&+)5Xa?F?R[M_aXR6b+\<Te>D:(:;3(0N#DH>55U1D3Yf.e[A
&VaUgeXD2?35A6cE[(QEUUCNP]PIG::?[[ZLWZJT.R<faaFE]^&G6DR6c_P]15U[
4F0?7JE9CNU/HE)IIWga@ea2#1dBDXF2eN,W>)FKU<#JB:3+TKWK@]S8/F(AK74.
,-4.F_.#Z[gJ+QF)_=bU:cS<(@?K\4]SFBL-fXdaMde+2+>3Y28NN--K#8;b/Q<.
QU<SH\O\(&(&4C[GSC#+5KO7_QF2Y(]@I?K/YS\\g)I>T.O78RBWCK;WbGO;?=TH
L:_G4-KI+PN9K^;[@+P\Sf,1J?:HK;B57\&-V?>Da:E-KBW7RD?C;XD8b<V0B@-Z
6<EI:TcSCD_E-\W-];]c^8+H_+W&D3EY:-71]7C#g8f]&8V2:Z6T]LJeIJ(FA_<&
).??>Je/V[D;;E:RCbU--BSa,YHP/aP3NJBD,W,P,&Y4JAfKdVagY@&],:N]/#&G
8BU-XgKRJ+G/NDF6Fe&A,;WWFI?[RF_gS,19C?eHBD?cCVSZ;00YZ\V^C:]g.FMb
5D5fL=Q=W9M3;39&Y^WF\M[S_e1FXTT0ILNH-Z7=>IN(9^:&&NQ.[45Ee<PD)&XX
KIXg,8S&,b7bS[aOfc,QY(a3\U4]<,Sbb:T1V#:KGH[/dBcIa:N?N@=2Ye+9PfPg
aPPgRXL:>M25bdd0M,2(NRfc7?9VAM&@[H6gAUS-8V\1;JB/,17C?M_>Q/56?]8;
U75V6#FgI&\+8Z3>.e4c][@:ATVSd9]XO9g9^M[E;2YdPf+eGPMX71_11&+J&?]N
-^W+^:I69F:SUfO])-BK8G2GIQ9^bb@4IX\a5FUJJ>X[2b3BaX3Qa>QHGLVX0=F=
IJ#_))+Ce;P8_9X2W3[[\b7afJc9\U_f-]E4ML,2^5I@JF][b7XC;Qg9>a>>faE-
B/GGNJF90+)Y@g]2>?HS#4V0]LU(X2ZX.HMJ]T9F5AZd4^-\>.7YAUYET-@fQ>6,
5M;b;bX<Y<Y?1E@3AWfW:9Q,#WV\U.K&&7fU[FDP/c:F.+3X]]]FJ#Q(]7eN)\FX
&6QDQ6LEA5edYR4]d,P[IQEFI+a)3fIgVU=Y+be>Ze>Jf[3;&.5#4G(]ASK&;d#H
,YG2N9@.DA=.^<-a=IV=U=#,@CDTA=WL_1PgIa^(ScRIM)BWK2S[UWF>D,J43/]&
DBD,R.,D_<#H&^7#\/@^4MHg;CNA.<\c786eL&X_+Z,fYRC-0.+7fXXLOe7G<0-@
LN\55F)DB@\@O4->QJea7X#OfHd(+]M6a81^119.B)EdaCf&PL\[,TPS_^c^F&Dd
H&HN&+F0Y.V#B_+O/4YS/#8:G-)TBR>B(ONcEc^A^H?,Y2PG>Y5d>C3A_6))4b-K
,HCK_-G_B-YM:>eM(E+c6@#X7DRINJK195[74(P&(XX<Xd&I=K?[eD=0RV0aFHc1
=8.<FfM0?O?YD;LJ4F[_S?]cgf-SKTUQ3]L61(@<f^/9[63[4cT-/B9VN?)FHB/-
A>;9GU#ART))+H9O,M.1M:Tf)5@O<6P[LTV\^dL>KW9LP:fM7CfY;&acA^7N^85L
5ZKO5AeU-6KN1U6BO4^^aEH=L+SeGC:8.9X(1/2P+Xa8;BQK&>##W:.@dMM]ZaTX
0.+J;RA_[R(M6&KV8H#<<-GAIOZ?<FE(.7O0-f-BEH@Z\Z3DKD541?4QOGe:BZGN
e^H&4D[D)1AI/WLbPV.K)9a1.IX/<dS</bS]bSEK3XU7]&(#X(OC4U(cUHL?89C(
TXLX+AfS[@-7Ed\[eg:(IYA4b?LF>[+gSD/fNPgP7@,+)>U5GB0cD#J,4^fFOgS[
U[[Pd4d>&34a46fF:?0H:D0G#1X[0OKeMI8)@(b<3#]@4Y>d3B37>M1GZ4P)D@((
gg[I?e4H[;E=QDCN<U^B<B(LO0S04Q7I=C=AfVeTcMKL?d?4]AdNH^=:=Re6BJIX
]>.g#2QOE3)[A#-4JR3<W]HK+O@#APeH?)](<g3JRdDF9#[,K6g27]:7Z6cKEW(d
Q:+gT#73c)=L6VAfG9b0N3:?>M<(KJ3_MeOEcb2UXFTY#4BF3FCc[8a/R1_VFWV)
R:b+E^6eXB6[<U4>/7\<KNFbGZd;J6-U)YKB2V^<=CQ5TgKR+CG#1EF.TG:BE2=_
V58g?eNW+Ba3;+=JZ+0+eb:#VEfBVG9F1H4H6\X80.H-dRU5Q88=,d=I5EI&3aKc
9CNV52=)IO9/VWY9G6TdfHHIM>K5TRM.cNac0]E1::\K8_(e4>1N.f-&V&P6+f#0
aQI#.a5e[=LTFJN4K2g<<P#:3L]bcL.UHGC?+0&UTR@U5O?P&C9R:JG8PgeT@E_?
3e:8EWbg;-[8/KLZP7_V4+Lb6+Bf_192L_A6>Q9YT=FYWMOB1.AefBEJLQG9^[1Z
KN^U@a)7OQ;4cTQa4S@7U2LSXA(&DKf5C:F5]5P&\F_TcV^M_JD8MVGH@5V^KZ&\
F_N[dBI,;;0-@O]LB+Yc-8_#=Ye17TWT\ZI>A>3IXcfa7DLI,bURJP,df_,8@WH8
92dRU-W5K[9^ZS?bS;>7B<N3aA-8a7)Rd)fDMPe/W8g/B<TQB=[9Y8^E<QaEPRBe
eZ,/[P[M\HYN8HA,<>#PL</cCT1L]78SH:?\3E=L?1#RC-^;>E0L-YbB?^;T]SS)
L@3&AgL[d=3XRR+N#=ORNdf8&;eg<;UXY4W=Occ^3e#5IfI6M]C-Wg#0_VFZS26D
<9S27-)KBgJ6BC&H=;^bS=e]Q]P?MgH0N6NJ_9NMSUC&Q(HCYYbRfPYDE,E8CP:8
4]^-NF36IS6THT_CL?5Y4Db?^DT?8LEcZ<#aC>H.A7AJ.-g_SaY&4NMQ_aCLQde)
f_b-#AFg,)H):B)QgcUWe#+74Nc@_912M;VEOBb?BBE)T>/;M)K+>3-^TP;J(Y.:
[][.MGc(gf;&CW(-a,@;]fed1ggSfSLC0V+YDA[..5&=1DJ46D0bRPGS8c;[3eDI
1QJ/NKL9YIc90^&B@3a?QKf052>A#;#4GN6/G=T,5.7e[+49aF.4c<HH/K07aQDA
8^1?NdT(^b104,4VO8ILA1;II7e\#dGZ:a-K/,UWRN;H;[X80DEX2f298M#Q1e7A
c])?+;5U(;F6dJ,E=W1,?_OJPYBH_c8A95P2aG1a.:T&(NRcHc/<e6.],RYA@c#N
d.Y[HJ-LfHUXc._2V6(YW)),KXNX9@5UKO@fPfc\12gZ+3?G4eDJL0;<<b>cAT=\
EQU9JV@VP(IRN3U?ETKCCgAA<^T&IU6[A+-5YNNK?\XR79df_J#ISV@7=cE_Z-K[
OWOSPI+6bV=X+&2TAY-cN#PeQOV/#eELcSBLJ90B<YK>L-THVRE1AKF8C/9dGOY8
CL4V87R^B1#cUO6,-H7f/Y+,\gQdKD)MMM6?D85OR+][HPQT:#:&3)@#9.af7cKN
dS_+JF9V;K>UZdPJ4NAf;IM7#JgJ=9EH0Af97Y?ZS07)<4d\g&7D+41_,&P&.513
17CX1L-#UZ,FUY&:<<Y?D+aOEN4&:DJUI=0?MV5^;HR:31g+c_=[WELe0<5OWO6;
_=7F--A>b(<SC[#&]H5UceCI(H4\3b(O#D1W_O1VJR=+3,I<L<;X0FRTc129DdQ2
4,=eIEFgg:E8=]3d3STMN73_H/;9GMY<0Rf9?>3ESb,IF])>F#&--dS7dD;E-S61
-DE=>aG_HbM,96e3]S[#>A8c:cSe(FE:PcU>Z(0RdF,(<a\C,Ya)b15Bg/2+#dXb
8BIG.@-,5M+A6ZD#bY26:[NF84,UBHWYJW.F=YM)RHZ4TSZ=AO4I5gNEb8__VDBb
+MV[[0b0P(3Q/K6ca\O51X;d5J1RENCI7:87@FJd2ME-2=/03?#5;I6-,,H4\,AG
E\\<A&B8#Ed2ILa?NgE[A.6a&OXFP.R9RV0F^[UB[O#+eEJe]\A6V1<^PB7OKO.>
J4\2?79<7b1QMf]._9\TUO&DC7Q,CG]-ObbDbbJgf6I^dPe)&XW)FAV:TDU7\T13
f6S/d9MJdBcB@<99WK3-1@LNP]MF_9-25fBgc7?,,Dg:[RU/17LL[Tfe9JT40D=+
5:8LUc48GY4=42YI,JN7)(@EGb\b2DEP2<&OU_e)4DWZ49GYJR.Od<&cge?Nc7UO
B@-(M:7Edc0=9;cg\JaDe7e5(3U((f_6BbPS^9EbPd5^bT/fKfc7Z(]OQfA0=f)A
5F2?C=(]5d?5QSOaaceHgBN;cH<]39[I,V^T3S&6NRBZYL,FU?_G1dFX6_QN.V5N
P0>_HADY@2_?X?#JFCg42[<K&YU,LBQQd5500\79>=>40UcgC0[<_ME1C6S9XXb+
beI#3?E/@BMU2\U]G^9R=a2YM]9eg\P0J2+:WMd4C=Q/.#[RW<1^:M,=&-1]IaVK
4FVbV2bD.[2#8TW)]=g9gLH)Jd[]+QYI9)8BO&XTQ1.Y3<QQT[.H-E2MJ(BN5B^G
VgL>T3^L>Ge_?,Y4_DV:fMd/KU#&,BKUK-7dCRSTQN\^ZY3bSD2JZ#EH(V/7W5ZP
1N>2U[ZTF_QW98^3gH@Qf?9LHE>L^),WZA>gQ3>RQ#G>T.YH5R/<M)WP(A-QP@8S
dAF<G:R.D/@NC&/>>4<[V6G[=GC]/bQ]5e4L.O,cIa8)ILEWIKW6;DNE&R242H0&
1VB\XW+5:.<M&K&_5R-0&YBS0ML.[8;BX_-(Z\U^DDDD6+c\\)=^<\;Z-S@cHS=7
JbT7eZGg)9a9G,9D^C/ZcYd>KN<3F[#2SCOLL2dFUG1cX,1.QJGb[@)>b61aS1IC
eO#bX-DG,MQLU=:be=U4S=3D5eQCZ;K#C#1/Y=9Y_C2:]DR(bSO0(VEdeR?CgNd6
169IHd&6PCK:UML>_W<KTg,LC=E^[1>&675L[P-,007C7.=b]A^_-Y^2/RWW1L7;
59A4VdA^#Bc90]ba46X?dX#3+MQ5/2YURJ6L]0=0IU#:-@BNZ#A3S@<Ob.R8;VN0
WcW:5/L9C.HG:/a51)Y6+;cfW]]HEDA2PP>gJg^(aD9^3\O/?\J?^_<70?4a0BDP
Y,#?\_ED?ZQL+3C+S#f1]1F2E/9][X\^OB0\a[8WOg/Hd]6SgMb8&OLL6&da.&Bf
)<eG@cZgS-SUG?9:EU\c1__^(T=KGd3(#OUMLd4N(^d2Bc4Q34;6(1@H7-H6eRf]
K;@Kc<c/91=@eV?,fEBKA/X<Q0U50=g-DZX^&_/_P7E5N]FcI)Q#(LU?59g#CL^O
]/U]c5Rg]F_01+#4PRf\(c<0,QA@#7IT@f[#+d=-3eMa>NOU5KY-IV=E4.)16BK(
F2:F/=Y?<S)TJP.Q7UUCIVe]d[R6.05^cYB(6N8OK4=LTacTZA-MD@DRR+<e>I]X
1JEd<c5?K@99>3D^>4fgE]R&89b?NZ.0T?\9T]EHYJc[LCI-&F:5bY4?)LEOaDY0
[g]&S2>LSA,K72eKBJaOQN+[\KD@L4A97UIUZNLS;QD65[M+2BDXWH5_7OPK]Ca,
C@1P9/c.d=37(,#01;H]QB0IbX(9A^V82_\,6OBU)>U7FSA-PbG;SS0>1?=5BCC?
e_K_I4^dXUZT)3BIOCg:ef&DT0O7Sg1Adc(DH]4-I4Y#:f_V&QSPSa[HdT(T#(#Q
f2gHFPc357aMPF235\:H)4,H=HS?ZG<.HZ(b/.I+B]#&CN>5f0bIRO?&I6gWKQcY
Rfe>;U7(8e?[N//AV_LFZ^???N?1abE2S[5gBWC>gZ81N5YX=8W4_VO=15.G5_Z/
1&VQSPMac\[JBf0beVC?:#9@/62AU=FT;^eQD-)8H@F7dL4&86a(<(&\d[X#+>Yb
#(9&4U]7JA^F.(W[dP8QN,c)3KHPc9#)<L]8/AM6_N:,/(fA?O_\8FH9c?HNa5<U
e8CFL/W&(4g,X:8cF-\gS:0fW5b7RGJW8K:7N-2(_K_f_?KdW,I5;Se))A?eR(43
,356/,R/NRgP53B1c&B;VNPW_D9\Ab46-U3#+>Jg]>WZfFILO04:V8Ag8d#^D:3-
P6I<[(_-H)/#P8+IgCP#4,GG1#6A#&<][>T=>FX_W.]d1Wc&(HNJ/0#0[/9QGBL/
P=UX:Y8\]-\#2JG^P:8NTI:V_Ta9W\Ed:>HMN8_G2N@[G?<UE0V\#>@a^JYP&4;O
\eGYD)4(S+U:_EDA74WMUa\)8+#^?V>L&IHKb;C-Jc?(ZZMecY2Z#?Hg8&XWLe(C
eEJYU0ZB/e#KGR9Q&3:RGa<EYW3;M,GVTP;Z?[ZU\Q903-7P[[OED:]E#d\4cOBV
@CQc(a#OVV1\)aUN_ZY=5,Z_]#KY0W<&P+Fdf77J)=[+2Kf#1eI_c^^0cP-[\4>X
KcM)@S0]a)7VdDZ;/Pa?.WPW?MCGg,P[9+V0]YMXYR^Gf+C-):NC&,^SFNcQ?Y26
HT,E(T<R\^[YBee@aMT]aF04FX8fCAI4OIce-EHC9T3:5;&6#CWYgS/5#:6(B-;(
:[PJGgVAUa;84ZV2[C1A3[U#IHF;LbL.YEC,.+0.-_66fE,FOGB2Tb4HPQNJg:Z>
V1_I[Z^3.EJHQc0;f<AQ\Obb?A1\,DAc(JfA0:&IUaTCPH5G3U+>35Dc?@7PJ1[G
3T8]FgAK@:X=OGR?P-=[LJe8QYdF+6fgc@e9X<PdO9JD4<UP(e..7&5[KAAd5L)2
_:C;B6/b+<)4_HD+ML=2J^dd2N5Z9M>:,/ebN:94HQ;-5G>A7J&Z703&475=<]_@
\ZX)T,&b#(/<>dd&D6BeKTKIF0#C/))[.-aHKH1WAe\S?0RS#4EHE66,:5=IQW8=
FX>07eO6GS2=Vb#\ZNP@Jd4W&T_NW8>fG#d9e#4;8a@G&fDc.Y=OJgI-]=E]J5F<
([WGUOW]AT&M4#bYYE(bHI3[#IX;gF2@11T4:IM\Z?@=VRCG<MOY2GE]IB:>OWGO
4)WR9GPQ=^K^_;K^=>YBFbcRBA__TF84E^&fd(-,K87;(T5X=M5Z@8F<cU\2^Q#M
I9/K>F>32491X(+6BE?_T2=b]_9Cf&cSASE932/6#&=GS,=:F68:@&aD37C:gb0a
KQR5[L+UB38d]^g.WB)_(HQVfb9+gf&>IbWe<c(IYK]e99:X0GeJbCND+6I4dFD-
3+EV871U.;.VHZE&aG@J>C3_U7I7-/.gF29(Y@.ZJ^6/2F3G4V^(VX6aUZ90J.=+
GH4Mc4+=;-F_VQaA\a0I/(&L-5Ha>-UO6OWIb5LEUZ2fFA<IVK7?BB?3NE?5NCDI
B6d^1-_2=2,OQU5aF@GV9_Fb5DNS1A,.2KQV493c:Td=deUFF3c4F\F,O=a(,IO1
59DI-93M-e)#,7KG<9_J6VgW9b:MQR\6]c\?0D-N3=FR)C@2MS/[R]1OUSUO<2#6
U:3\^]NAGB>Ld=?:QARS4@4S>/fQe]c[VbT;e0cO8<ES=5MEf:F#C3AVV+7WaN55
UY&,KWf;H:O7g1EW/]AV;g8>4BA+-K.6OfK=+#GU]Ue6,^K9Q26S?0(QAV-F=(?>
H17M6^cQTKg5a;N9\<b)4RYZ/CKeLII9^caC(0f6gQJ+Q]^H,_dfDPW>Z6SVC1N9
;9S@WIJ+DAa:ag+ZUaIHfV+IUf_M(MNY9>O3-T7YD(P.g<:O9gPSYUa#Q\_9W8?e
Uc[b^c#=S,Z7_\D.8]G@;VO2Z#B<6KF7d6M9\2E0DKSce)MXeS03C\c_+T;<8L76
XB+C.)f/K[+MTGQ9/K+Q)-M;Yd=bWLa0.CYX/P/G8MPZHdVY(&H/V1^2D04+_gZH
[6\^.6LaJ5X;LfS.E2#gO553GgYQK3KEX&J,f-5#-YVHQOR;MFK_agP?M,>.P;:g
J;R9c8@P0S8bBWg\N.)M246La+4U.Z9HA+6PRY.KZeYMLWP1M70UD0bH<;0;c0R/
Ia;:M;3cX\R\N0K\cYff9XE&Y@^g-[/7MZ&>CK(BU<X-BHFQOLB6J>ENT3BU>:S6
_DQ.42FN--X9,T)5MDG58^2YZID8<80^][caAM:/:J;CQ1&^(Z+XUXc?GF6[WNYW
H27S-0cQ5^:K24MT1e>5eM0G?+05,9PN&-W_dBL=aWcS[3Q+]M&54,TcE5WWO.?M
IdWQG=W:>KK#C[;4SRdW</^+Q_JeHR.AUT_)RZTCUb=2WN&0^^)O9:-EdSg2F+#A
a7eN;A]&=AL8a.H(g->:.].9QVT<9#:I>&?[1@3Pa4KM3;\gKOZbDS+fe9)g<c2Y
b.Q1SegB)CK^G:E7[ZabB#XCe>#7.S5AA_397QcaJ,B(L?POcTS#M1R1[EB,SZ/e
L\gV\A?_4G1fW8/L(5P<YZ/8Y9-65HbU)DL#Kad#BV;a/fB_Qfc2DfE0(c)4Nf_/
?=eX/g2W[g_C?c8D:Z>OVbWXVE/V=>TQ>^C&.9S46g.=@TL<4C)8BQ\V(7f]#_a3
(KO()d>-MY0PN0,X63+1]D,DV-D^8Eg6DN;Y/2@b7bAPB_baP@GU8#KICLJZ4#cF
QbT3,eQe9U0S5\3+6^]G,0V#MK4WXRFNV,eTaANADFPD&:S1M\?>3,L((]&4135@
,:^Cd2ME8XJ<3ZFdSf>Ja:88O.Y(L]YU?41RSFeC/=V]:N]NRGV+9eKAF31?UB]5
AO1gN.MW7J8^C+c;@+29AA/X7<NfC\MXJg@g5a,A0:fNK/1g.15I:X6+;#RP?MCe
D?13:9?b2[aUV^eM-#LXDG#KEPR?^6327bATH<&SVHGUA3gNHf]@1gH?4RX8g,#T
4<PQ3XRg@OV>3^;UQ&QLP@C?SWa669?/5:Q=4;Ef0><a/Cg@;81DR.LT)Cf6BO,f
+aHK5?&R]-EC.V1bP0\8FP\KbReL\8IL6RbWe7EGff0U(QLK3dA5,F=ND9HBc])a
4?2#9a9RF0HZ\Q4-d=0O+f2dFL?T(UdaH4,)e<X(RFSUg@c5+dQ<5R4F(&97eHDe
7SAX51>088b;;eVV40\C^Z&Ra0Y.B4RH^Fe)GdI0H,R+]>L24g6^NW5e6KK)Jc]A
R4NK;+F2&L?/1gV_aE:;/5_R\XA<[ba[.WY#eR+5/\4:F8b47I433?90Z7&EdCSI
#F5_M,M^N(:AcAbfP_TGV.:-L[D^c-)TR:)LZZM>HUWN2Y9U#6Q.^O^aUGO&5ZL.
_TLP:<>SR82ZP,W)#^)<a9;gZ.&f]DE4;T#SXX)e8ZdKHA5B?=6YY^#G6e1UEAXX
bQ54ZYFcVKA@/)O+4f_G\,^E0R[fg[EUFKfC7SIUYfgGNVRD<SR,(RL(@ZBaf?\)
FRQ.[Z#5_T#F+ED37A+1:87P\g16@OIg?OX9:Za8_)<DG=W<(4I-]\(PIHDPagL2
Y;+/L=++V^Ga>Z;J[[E6^2U04dBJ+X/7gWAN?5Q44?Ud(2g3IFN#XL(AbU[BD<3:
QD_bPb&10M_U6@LeXc[OV9;dKa9HJ6H9T[U[T0PX56E0B5MR4:=gRXB#N/OFS1SQ
3.G@R?+-@J++I6[T2(cB9?3L6Q:(\EU<_S4-LGW\+,&QJU9fHgU;8I=HEg2:DAYT
X]#2-KBW]dDY&PDW-a4X_:Mg(E1Ab;e-:E0D[@)fDO:7\#KF3XK^(^59C244Q=0D
FNWR>7-8XTObDO;U,87ef&:D__HRX\=L<b3V\;L@#><YbeDJ):Q)GUJG&V7WbTgb
?=O,NPA@:;[\^@JD+B^_MG]@.:LC#g6[JZDW4B.P?1M@<AA?FPP.GRF/LHgE=T-^
IR9P7_>5b:[WE6fP4)E0c+87@4IK=3]1e7AV_XKS/BO=aeI]^e9E/e]A@\[/IZR8
5H/6,C<JfeE(Z1+GJ/5DU/]SUPX=)):F0Bc.>:YJ[C#8d_9I.13OA1O_&feI@E3e
5+K/FT][3,bNgZQA1<V.?(fQb+g4Q3BYPWbYb0+eGZO<;4b+=&A=9a2?+RMP;MN=
9C@ZEH)[Ea)FCCD?^3FT8163P30#-(?X4K_^/A#Ld^V2>DY+H5JXfMc[;e85>Q:<
AH;V)4K/NY;e?BJAP25H;3bdgbW.G,6C2>1V3?IWW4_3#,e(cK#[+_]#T4b4DH+5
O/)J8O9=I;H^38WDKCg@XN;.B&)HOafWU.c#MHf=&VX4E?=a;7&[3@DDQ6Nb2G[K
A7>324#=YeZd8^IbcA^218IfX&,P@S\e];IRN9b?=T#fdU26=<;KO)/.B4J(OMTS
=TMT71SGaY[:J>9S1/e?/,4PQ9?N\(>G@>&?0cR\7d&6F\b@R]MQL2DC[X8_Yd6>
ITA)WUfdZOF26R_:Y\aI1X2/SZ>B<F[256IG;Y[8GdZXWdbLV_[Ec;O4?FQ;F?)(
6(X=P^PUgWc5H7Q=3CAAGJALBK-)43B6S[6)H5U>)&/b(:5ReO]WQ](]9a9=#FT4
3T27Eb\V>6>0-@L(_[0&>GE+,H6_NLG4<.^Ac>M]&a;+27f[0D6^6UJ3@;/?.4QJ
,Qe@_78g=9B0&@B2J-&&S&57]RLYTV?MLTNXZ(E,KQ:)RI\gB.,:TCUYXd[cVa?;
\DK;P&RWfW.(U_Z946Ka98)OM)5R#P?P-MY2BS:U@.>3;[)U3]AJg=IfJ-d9:@+^
T?X]?2^Cd+PWU:20(@&CeTD0gFf;:b4.c[TOQ;4/f2.[EH>NeAIJNg2/d6U-4[O1
=W)H[^A5V6V8TFcgB9bI-eBDPIa#E&F50_Z;EZ\(e3de;aR5N#U^1Ia4#OAb5dF#
.+ZOW5.:ab_((1effHJT4?;YOb5X/&K\I3?Q[]R-&[@fCAC1720,S2@^6<]2AO@c
J)NTe(+b+@a\bLZ0ad3[gG/92BG&,E4X+0,]4I[?,4_]F?^6>UMf?#W)bDRAB&OV
be2=51J_c5<^g7S#Ia@RL12OHfA5B806UCWA5^+0Ke@.:O2IaE@:S4LFBBTS,O)6
BYA\D/>gWb[?=X5E??VAB.74+@?IeZ4UJQ6JbE;UQWdcVfec&(5.,^T8VBPW7(7(
e33:0X&DI7;@:gMP/E=A;V;\c+g=;1K&gK_6#?YHK??N.f:K<aG4G6TfQ=?4)P6C
f.A;.FZD5_2AR-KUD.#KBeWFKK4J,eHQ3d=G\CT<+Z@;WdC3<aL9<0DAR,>V)&01
;\WA.9U3aX:>6/+395@WZ11[c:_JN)TV;=]ZIcJcVB?@JbKSe&G&?/18MOO6<DER
;KT_.]W=dZf;B0e-0Kd6eeTNB@aB9R+D53eW-2aS)EBSdC\+(;bag12M8JTd&PMf
+]DY3/RQQfa._aF4<-A=G<I5G6^]#QO@<CT:W]G0;X]1P/LZB\&_A6D([=Z^ZA54
I90Hb[-9=[U_]:4HXdD@N(D?3E>Zb^1BaTcMPaPS:KN:\3_6CKc=4OETM3FSbfY+
X?K@\G03We;IbN_:)\SM5cH4P2GJ=7_<Y^f#HT&7HJWLYaEIK-5/^7SO247c0ZKH
_.+)Q./O24__;#V;_RFPT3EP==(dW5]\,W?^T#7M<d:H.gLcPKT:XgD1Te6gD@AA
,_JGN=GO3@WW5VIIQ+]M/#-OX6D7KWY&][RT6XLT0;91?:#TCcOT0RUI@JQA)H52
?V@BbN6;4=dUG0-__9S0M>HOaB5&+N9fJ0W;MG[O@L;]QMB4g7Dg9/OFL:K?E@[C
L9e[4QV-U:;U7f/#9T;M[f,1)e..PKYSC<YP:9)UJAEd3A7?CSAg:9XTPP_#H#@>
6OUTaRA+BZ:)^AEV:dWX/5L6&<F:);5J/PF.ILA^_MY+BaG[9I7=_B2>(B4Z(a-0
PKF#+1465+N,&a,4B_0GZ<YaF\,\?HF.L6EB;L3Q8\HE:XT]WgR,Z.4)b3f&S1?T
@:FR:G)XNBP_AG^)\9-W4AJ?2,54H<f3cPTCYWP8(NK]G_&0]f_2YdSOEXG<\8^E
D/+^ZcMe)5TaW_)0IJ:f:;ES(OJM.<O<H#B[A=8_72[7eeR=4bgGdSFd?HV^9JB]
=.GLQWa4:OJ#]cgP90.[Ig>(@/Z_Ac2ECF)[?7=HJ>TC0?g4>CF269YIg82Z7XE3
aUQXe_g=W5)G&8g2fNLVXUADYPa&+&aH0[]PYM0_QD>CK#F)Bdb2,O.J[b7TSaXC
431(#:O(VB]O)C(>90YCcS0a,XLRF+M&HIII,@GaT8QBS2/fZ#R8);LL)5(+-^X;
RP_FZX\91f\F5cD02f5#NZDdd-/bbg/UJV3XcNNS/RB-Rd2KVM/-4?OK.A=CQXYO
?CJM5Q>XCgcN25IU)R<D)LIgO>+Ce#2)#HUX^PeYe]H62PF?-_L<b_Q4J/SIGZJ0
:TMe9,2Y)W=-4[bL+?^\/fF5MEECN#22ZK9ED[T^;(_28=J@c#Z[eYRe;NH=]&G_
2GPWWM+.OXX(fQ#+?X_JK9Y+^,K):7_AHdYX5CRJ>V<9X)O(MR058M(34_(F3<#^
Fe@9&aCD35E\N[DA?56\:R\,B#edg4S>J>CHOL._P;S9AAB9>@]3+R>>aHTC)DJE
QS.P2_f72Y_F]5KPAbdg#,YM.U/(UND4RebV4N+4IN4Wg,AQ.<1,:)dH;X^c9?a^
3f\+W&OQGNC;>22?MP+U87gE7;c@gM?F+#4);:#N2N1#\:0;a8<4-(&<ZSTOAVgH
N@H&WB<96V20S.^J@DUSLg4>ZaFLe3If@.X0dE@Q=EZAcQDK(&@OeKO5CL/:X(&-
.dD+LQ?L?_XD+TgSV]Za7\XQ8V/1aN>>gTCFJAUSAY\/dKK8.#CFdadU+U:E)SP3
+?4Y(d;02-A-_^XPf?GOG6S3(Y_AEI01M0M9Q07@Z,XQ=AP\O.CC+:K8+RY#;/7E
+cGJ=CdT37TSacLV+0B50KOL3&;)8N@:+=;1H[=7SU\]H^4W?VYJ-:,AL)S[\@GX
IGO,<VL<0:;HaGc)9(23599_QC9Y]Q(+\G>MT3Wd-3/(:/HaF6HK@cbR.Od5,C\-
_64;8:gAX,),<a45\?.Ea&,&&IB0ZY<@(L])TC_K&:=WG:SBZ-_O<O-g6[e9LZ4,
^BJVQB6bZ_G_UNQWOfc:\8?aOZG9=M25V+\LN<]H#OY8a+_]FaPH1SN=UT;3Q>9Y
gTFU]cZ@IL;6bLC?Y-:,bHg:]+NJ3Q0WYYC[cO19b/e4bTfa>cM2#G,XDOaVZ;6O
LT2G\ef<-H7E+4(c92.gZd;=M9LFWgYS_<_?e&:)++EcPeQHd>I(Ge<Z/d_1Bb+O
RJ\d5O+A[J[b>MH3,6_f-H\S_/I)[6Cb7SWeH9W_+YN.R3Q;16X(LQS#??C>YLNN
L4]3KRgP9,cKC-UUbQH7&&A5gPgT>c3#DIQW7[::bF/\)OF&@?IPE<G7G\c/SH=+
:YXT1WN2;FP/N7V+1<&S?P:MCd;&cHX^[OJ[XA284g6P-JY/XQC?);8?A.Ib-7CG
[&FUgM\/AcHDPE59C(RI,2LV(?S;-YKdG;eXG/C@T3cKTbR+a)#9HW)5](b7C_((
?YATEc38b^F^<YPOe6:CUB9.Y;D1U?gV?-5@8)UQUSaC8I@I2HA@6Z47G6cg1OdW
aZa_ePC=Y6974?+#gL@A41#0aH9e[)/gc0gdH9fO+1I10Z^I+KOMcBW>BUc+J.-.
17=TJ/>c<-&4WgPWT-]5cGWPaBF&@>\cN06SBBd76Bf?55fPHF[O51SAIZ3L6#?1
gA3[)P?V@TcJ[:.##4#ZL84909c\?&QZTSY19aR@8RJ8^6M2K6?<GgBL9+b<=/Zb
]/E_RTYabV@:#61.+@F43(^);S^e<_1>-PB)<ePe[S3JF/dZ&BQ-/e+&B17gSOQ(
g\_\A?A.BY5JcJ6/>Z<M7(62)\g?_)M5KaPH1M8E@HJFN/b(a>fOG^86_MNAb,3H
15aW^AgG1\RXcH<3]H2Of.)TR,>L:AY5GQ9/cUP)cU4aRI1Qd>_-7H?P^K-&FXNd
ZE^#e^VS<1CUb<T9KZ7b7&,ZcFC#=eZ\e1R\OXA.CQD+#AJ7JNI2JO^gIE<.1V47
/;8R49UPeOONZB7A?d\J<CO2DJ.TaJU?e1L=eG[9A14.&&0Xc<=#)d\X#T]5JP=0
PYSU:9bVQ/dSKJ<8Ra/?:^,c/b_XgH>X4-P+MDB;;(e]@+4&NOUc_)JO#,QdKPZ2
B.f=A2Z)WTT9DX-2)dJJ=A@Z#a&d_ccPD:Z,QVT+WB;CDO@f91a9WNEB)1Q1cO1,
)eB\-U_IC,d&[<=@daddAbUgWI-?2a[BbeEDb38LK3dSa+R.@54c096b/\J>>bG3
:&?NeZBEBM79:2([951WZG3I;:0UFd6-DIU9N0)==10Yc(/S,cKHTAFe/14+JeP3
DZ_-\M=3,LYGc]?8MHH9@d2GZ6a7^Z)OGRf.&6A;0:K3>_fc(R]?@(]>FVI-g:8=
5bIOCee,dUa74IV7\2FS)5:_LQ2+I4bMd,:2Yc/4QU-;<C+^[/cE4Me&C=V]/c2B
?Nbb<QK8BI##\,_U0fG+^3#6JR_M(PRff(G#11?6FJDGQ=Ub?+A&e^\R10OG5fHY
QN8S6W>+e:#MF#a;^,]DN#US)>415-8_XX](<4W,#GHEe1)<T_=@\QHZZa:+2P+C
29T^YVV9bd&4bJa/RgZB^d0(6)\^@74S]6<=8F/P7ZF-5GaE)g-9#XVQQ&Y?V#LD
];X.Wda^&GBDg]=E@(>_gH<&a4a8@)-C<K>NCU2HGg9afI:TPadKNZ.OFD?f#3JP
bO7TN4.H5)CD3H7YCQ9\.]M(.Kfbeg61C;ZRV<[VQ7JIIFSWV9&_G[DQdA5OeHB;
N.>I(bZV?0M0.:3]D(-LcT8I;&(GC)(Sd4Xb98S6=:V7H9g7c+]fdUa6QSKL[NdG
#<eW.gK4:=X/A66a]\DXfC)7V:BF&1P<C&HJ3d>-aHG6K;F>UHNM3/e@D-+KS?W=
Wb5,AGSSAd16ZEJ^.5URcT9g(R:7^SQa&12]fgF3<[FN[8Re^F@&^TTa<Z4Sf\\:
>.=aO.K(;-+71>:=GF7?[_V>>+);G76<BX=VOPF:H/?1Y7SUKfMfESa=<SLVBOYD
e;Da]C9#<+PBe9X\g4R);X)X]227\_^Z+a\<aa#fK4LYASW1MU>?G0Z]2DVd1J^N
N=D<,F)O)B>b,T4&XG[,?a9GM,B96,;)abV[V<Oe;,=WDAf>79>T6bO=O(YZ/C:Y
IA[>(;_YVe8(M.d.cbZA-aV+@Y7Q=L^)#,c[JSXEgHQ0@;2Mf\)C-)B.=c7^SODH
KI)3#J6^)#7I^L:)NRT>G>g[ELcE)REZ+1fTOL+US#cKf0Y=_e8<VDM0R&LW-C=F
cS<<ITJ&=NV6BH@(CU>)Ad\L?KHJO<DdZ+STXY;+fQ_3BX)=#+a&c^0F<g#&T)gX
Y9T=+gf)Q4??\U=.[I+1L0C4-2F8P([8+T<<WE^T)_VUc-b.L>#_>](6^+SD=7fD
98Q]3WNOE,4a0/6R[,;V7,2(-3<d.gQ[8<CUFI&SA2@;a?JZIQ(_R#eB>Z6:N?K(
a?gI:X6<#K^FQYbEQ1\#T2Z6=P>9R1+G3J<CE9+D61&?QOQa5d^\e(80H_-M=gQY
@aZ3<ffMAA1S9Gb?U+78+-#bQ@?L.@PJ(gZ]69gYPb3#;R@aHSBESEb_OSH5BC6U
Z<B?B4eZaL\+L00.:A;Qa:?G/&SV.?AGQ6+SOg]F8J1J#5Z(a=M&[A_?Rc+7Kf+6
:GE;75<Z2?(bdK9TTI@#-FD]?aOb,Z](,[P]3S4fXRM_8TW<433\LeZ,C8f,.MU=
>;]_dHV0Z9B@eJNM1>A5/;-EGK0(NOdP9O#+:A/K-C#GN[dC,@[OV1KLWEdT(VE,
8+NWPM=JOEEV>7d?ODM7IW1aBI#V9(B?UT-^;:bD+dA/^b^B9VXc^fF#@[2C3GdG
XQ3+/6+>52#^TEe7aBOaTD;0S?SaM\9KJ?_a=d=]R8aT4X99B#XdU>\Z_9653-;#
,:&Md1@@6OO47<FV=fWD9AUQS:KX<V.-#,5D^1V3NWCF/#e6AMR:AZaVX?)?,-T[
,XR#[C:.^GO5_PMI6+#B3;C5^(:7Wb.-76PD.>2<cRDM]XA\N]=A4G)N<(&0_VJ[
1TLS@#T0,9f0G.2BdJRQ.Y[N==K=eC_ZGAa#P/1XGRe0)@+U2d8H1NQ8B&?69;5g
W)K3.\>#WXG1<&N4)<c6&a.9\B]2XHdPW<c6#c6FTW/fI?ZW=K?K,R<c0IE<bZ@e
/XdPRP&NSJD;TLX.H+93^.a8@d6@\D_T_WP?O12&_:@D_@_S0UW4f\O40DY4.Zcc
Z5T[KD77>D4&g_ZOd/IR<MWbX/^-7(Pg-D;;XG0e@O4VRO[TS,gSF8)70fc=_XC]
FT(<&O,b?He(=D9^f0K,fe/V0G8GWeSFV@J0<;U/cRg5S4g5WfJ>6YP6K/[S3L&?
I&/cCGLfULY\DUU0IaY48bDLPL6W&?-NUX/AZcOHWZYJV>C/Ng)=OL2>ebT1QOPI
2C92bFPWX,=b(RJLUaH]>Y@C4A55&4+?MN/f8d])cGJd1O()cSY7<]0CK\0KE>.,
A5=D9gLE_,=Ob>^a)RUf87b6aX,[g7ENIRP,2_65dbbQ\L8K\D@9CbS1^>I.Y-/2
HR-bN>A3W\^H57cOMY@^RAB:W81Z.TMPgdF_8^MGbJLU@NS,Nc-a@N1Y^QS,cBOJ
=;QOWH#V_ZJ=CbaP#?I<E]gW772gTb/0f)DG^KWScAe\A3,;:OL6fZ7Mb<MZ(>L#
G^9:a-,TJV\9_@<)X<V&c?1\B<eW27A6QH3#0PGEg_Q&1=)3fZ+-:O?OR?];PK3.
[^9[-f0\/RaRE4dZd=DQY>.dB)f^=)gV+(D1N<ePe;8(5D<P4[fSLD1^;MSZ+CB&
g;&d;UMJ(5O7c04PO?2JQI)]XAWF<49D?/?<AMVeW8eF#]@\)-0S\g9+dHCO=D#R
HHJNNBBg.(_.4R^^U-fHQ+<Z/+KM#3@L^\)=OA)fW&g-URE7Y^?/;D\SZP&MYg)f
(S#Kd/KGdT4B:O&@(6ZHPc_e)VI<(b1gNNE=\#]@[VTKT)[,O#:.K165]+3#@e)S
bV#.T][@&UD4D2[fS2Ida&-K8ed:-Ye3HO<TCd_G9BLeJ0O@O#XPQ[P>9)]/f3PA
8bK5C92^/^U8^QV&.U@]1e]X#P]RIXI0=>P1f.-BIY1baEbcKL6SLd@&G-fUZRC:
397.G0H@MW,bH[Mg3A\>9YN[AgGEd:[OSFJHgCNM4FgB/cg.+]_N/ca3[Z;D[31M
N@f<C]M<I<R]BQgdf#f0JG-Y=S4Q=9b,aeTVV>P69?P#g31=C<]3N2<TW(P>8V<7
0:0a)VO/VDOE0-8+0g+(c:PR;K-94(<QE@+dS_@EMEO4QM6e+M#,O^L;JV.0KDTQ
(J84]B6_N&g@W+^<D:CWC08:J,^Q;PD0YN[ASCJc,UB_SKSgM4--dL&e(<a/Z0V]
Sb/XgIL(4d825N)[-YORK-SJBG4F.[Y\gVHM5I<R\.f8Sf[F6]bZf4Z1@\.M=XLL
QU]/cE^@PH&4@>T37?W_>YM@JV\TB.c(6[IFc#,I9[G-,4(>f?VV,=I&Fe=9GOVe
^FOGJ)aL-HV(M5@<(ET].Q\NT2(AW>FU?aY8EfW7b/BM9.3B@Y?8HDe-H5OfU^HV
8L:4;NBgV_fUJQ(4E4)Z59-\#^eOKF]TA<2;^Sgd@#7P=Ae?L#B#CEBT#>ZMNB(5
4F-1BDd#K=E075C#5?a(QF8?dXVfU)B^=SA)883R33S003:(69O=7gW-_U-,9)GD
.SO[_GCYW/:4^b)LN7b,V>HegD#Y:]U#8R;?1\9NRWGQNYQ5.D2^g@CW7,-K-dG;
9&:;7PMYI:^UcU_,Ze&HR&J#MD7[XZQ^]G-+D8;PAZT9PGCSg.N_KfV19AdU.83+
F+)YAcX)_,I.a7D&S]FM3@b.@K.PY,@-,S__J1)NU]Sg0VP@S>VB7\g^?RDSa3E8
A;O:.e53HfX__Z&Y[4E04JM820/8N2V@GfWK>+GK&YMaT./848Q<+I:4&A(,]LU5
/4J3B1Ga[+),WK=4.<Y;U5e5J?M4aEYB)DJ)),XHR;\-D7MYVC@)C6a14L.7/)aD
;:_7#=+V>dL7-[7J9.(NQF,:b[aWU>=Qg,D\Z.b;1LBXA/V_V57===I3CTMbg-SX
JX8X=+<CHQ4-2(DVc4;@g\S3EgEAcQDVcJc9P=_00VALWa]F,Vg[:Q;/WYI0cTT+
B_W&26cZeYWgMG^/+7^fG1f\GcM.PS20[54/bMI@W6YB<.-W].WN:?6+\+MS:ALX
8P6YcUKT0&ULad8NPW<GfL2(4YbB7,ec8_Q/P_Y6SIU/<O&VN.77g>1<CELA<M^]
&)Feg(PGEX3VUN#-a(U_O?Ge[eE/DT<S8DS@e+.TP9VT<B]>8#_+bN3K.S9.AW@_
FOg</S3E:QWJ>A93IaaBPW6Y>1<<?g+;9//?4FAfL83+abH@]2]MZPWU/\CbY#KP
V)/_\RVdETa^QI-0ed534+?+7HVVY,PO>N9==RSW@b>1)47EDWD^\IY,=SDXS;Ng
;)9GQ2EdC)40RBGBHET.2RY_-bV&?NTV7f#59Ce@KVW.#:^GgND[MY<OC#O1<15(
/O5B_T7?W\[<b@@K;F5O_W5Kg9a)7d78TZObgXNBI^c0G@<<9WY2IB:^:.G&5^(Y
V8L<J3U>T.8+(eG]IGfb&0IKE?CO-TT^),/B2U+T4Q;eEQD6C(&.L7573J/(-8c1
X^eD.;4H<@1.e@(Af95.;=6S47>BHZS_;a,+cb&A)bH[/)_ORd#AW6Eg&0@)@LVf
OYcL^E,=/2>^d53-e5.-X0_+U+F(:?<SM]^^Ug5A^FN7b&QfAg>eRXFVKQ61,Qb:
&OC_R;R->0A/30@V:bZ:YVD9&U\\M42fN/)B9OK6I/SLH=c1V0S1D/aTa9e:_9YI
<>6Q72X-KCON#T6M8L+8_M:>MV?6,2ZVXR>Q&,>Ed0bL/Q9X0,OCgLNOU_E6[]Z0
SRSP2H.Rf&XXE.(T)3?M#1IgE@O4K4fdb(DaYNCFVK(Rc&J.;KQ_U9VIE];8e34U
Q[#dEIW2bg-V:CO;PCA7<4A&W)60OKRN\W;93(16R;N4f->#JgOD=8f@OW]6bYC(
U])Z7NXQP+C^P1M&+aCJ1GJ&gY2O/)L=PFPC0?HePX?LIag1Kd^cd6NV[B7;0LM^
Le5&bOY,=&T,D,-31eK45?f<V.2]LYbVJ(3T8>/E:4LS;_BG+b)F/bT))ecN8TXP
,2?d00YWDR_I0;U?_\424B=2Ke+f7G&B+]R=X&S<(YP@cMaKZ1I1V<#^><N6NCK,
VR(C:3Md0Fd-6RBBaYXMGMfFSQ20d=E>bO03XH\cP4-LKG)DFIU8B?>U;4H-&N8G
P;2<,A(f6C0\]:.:KFdA7#A0Q2\48Tg\QW]^#JCE=HLT)8@NeI88#J2Me@Z_.d03
#DSP;_MIH#R(QBQ3<D&J09XVKMa?0)]8L+Ld8TP,KSP?1d9ccHF0>KOS>C\S66+8
:L509_2BH,V@1RI[]5Ecb&&8ICG:5P7=5_B4]4\EK-176c/b)\7c#3P]B/Ve0I1O
RN#@D&_MN9A]8C;I3e1@P7^DXOE-g#FI]K9SGXg[NV.cACffdJ^A5Fb#PD)gK/@)
SI.,<BA(TGRIB<5cUEN)5KZ;DaEPQ5Z_bC_S)\F885>.-R<a0E+TW2S]9[SgaJ3^
N]OgAU5b#S_dMGP;08(Pf1]QfAJ)7\JKE)_V;^Mb,@CS,\9=e59FZJ&3AQF(2VB1
WZ<)8)/+^H_OKN],JE-XPgQ:TgG;[:9?GffLf+M]f;eUMd83aaMd8:CfG8LC/O>=
b3_f_OS?e=LR6;+-O6_53:F7,HC>?ZVJ3eG?c<cL32:(+cIf_W5?;ZLQRDc.g.Gb
SSWGHK<gK^Z>B=];A^,(N:J&^f<dYB:;7W0YC1.7-Z11A<_Gf/07-e52UB_EM?bb
?/9^\Lda7e8BQ&\ASC-8T:0L-V9V5GWI@AIeWJ.NYV>PP7+[[^;dfL(b(daUfZ6>
?F5CE7b<:QAI5^MaX6Ad/<&8-D6FWFNa8GPR<0R+?/^7H;@KNEbL48IZD-SA5[/N
90HZS)MPa.(X;7#^9ZaAd(g:I8Y7aD,7]^A.Q)0-(/LHbfT7,B5^PYKdR7<UH(]Z
.5=7[S;DW]-8U5\<5g)IbO,/a:2:0D=g95C>#X#RVb,X2OIaIfVY-3a3HZR[_(+5
/3?10K;M_KR@K>(:(?/LfT1aId[&(@B=AbdE9=^4+&AgL[B<O2g9Y3<O-M)(@SMM
ICJ(,J)YP9;cIE1,69E<bS^8?Y6/6Rf/Yeg2(BD,&@,R]Vd8;<OX=X:\)U[B;.Y@
9DX1Y],LA;3+K9AaY4VIE/@WeDEYBR8&D(Md^Y\MRf>IY9;b_2M#cAYOCE-]8<57
8PJPNdJMW\MIgQYOKB20]-ZQ2Jd=bbK^Aa_QD)0+4JV_\QB?Z5@HO-JV(:4I(R+L
[I9acB;:cQg>.EF]-95@@QAT@f=/F_T9,8QX.K9FI)D:<_DETXGN65,=6]#_@Gf9
6+?ZfK]?VLgGUbe,g)(/)CZ(:T-7W@VMF[;OI&#K\S??R_3A,:JV7;4[JMTH>1,Y
KC(.THE@S_L\1@QHHJ=77=]PdYRg[Eba>3dRaG;^TTZ+@@-_d_&6/gY&aLF\#Vg>
.CPJc>]^=ZF.@8&eQ6ZQ7-OK./\MG5+ZEcJ/=:S==B+-7+AL0S\67+#Y8BL_b^9c
?LCQQDFc?#V&&DKfI7[I9.71CUC7?UO,SC>>X1d7dM5]7L-N-.E1;G4_FOST801a
BLdKaA3ZY,#Y8>UWHB61,B+?=gEX>KcU0DP:Ba<>7+06.1DQ9aV&>/Pg2S1SW7S?
#:.RI#Q?)5YU<\f7d-8L6e.NXAUBN>F2?cbAbPc;98FN_ab_HN3;>Y)U5g?0Bf0f
OXU^Y&V4,(H?)OV.dV#f.Ra0QKJI84ba^aKbDSI5A;-5Y(SQGN.,5XC\R209GCQ_
@DJ?E@H43JPc8,OS6+869Z(WU0O?,_9&-b[:Ib?A6XISJ<DM.1=BMUT1M]R2?ZDQ
1O45&6?K3^LLgK)I/)b?Kf\5SQ(c=5<LbR^>aV5E38K-3/R\G;6TC-DaAcZW@2M_
WZ^&L(-0U#@AX10/e-aOQV7DK:Q^)1B(>68KR9^YJ>2E+:@a)8M@]9]eeEE<3+FZ
B#eZ/82dg<<A-U);Y4eeD#TO\\;Pe;cAUf)W\@#H0SE2=PWLOR:M9](;g@&7@SK6
8^c)=1]LZ7f,#JM@:)Z>KG5W/d33S713=)/A_a_SYI)7eT8X+X9P(E2-05bB_25;
[J(IQU]Q#)#1fA3E&FK771UP@;D:=7R0>BA;]@R?L)4EPPX[3FN6,J@bKg/)3#:X
JQ+25Gf5Q_aVD@O1g]O@7&g=7^G&]7PR?LGfG]Z[3AJg?C^6XLR0[deeN)2@L<G>
7F2d;b/CDX1c5Eg\574aK52P-5ed1S\<;44GH2WF?)K8RF)WZRNd4OaR7C3@AeW_
V<S?]/,Z5FS8HI(_ZedC4+O++WC=#bHOBL32K=U^MPX+D\5e6_D,^7V;AJUPHMPD
dG,Z<HgCZ<[0GQQU-Q&\Y^9>Sd+,YER0SHFPKJJG-M#7_YP,D\@XXMPg6NcIO8JC
3/PH_?_N\]2D_33de#KT-GN=CWW+a2ZH>?+JdZd1)&5&^95,/F\Z08Nb^=4&G8Ia
e5D#UUSd6#CTY9U>VYLLL#\,gf9<C[aL00,LJ_.Sf:GfX@7+0[:/Q[A)HZT33NR0
]=\SZKBd6VYHU?_Q)1&/.=<^U3AL3,5L2>c@NZ5a1;gfeF@@J2O-bZcU,H.:7^@W
cVfX_V_/NI&D^9.&=ca7C>=L6>a4FM6=B-fI=O9Ib_PS2d_6Z=(Q>a)#J4fYEMM>
@Wd&00./SXaQ:QV,f-QW<<2LXDN=:F-.^YA@^\e=DAVR<NIMXUJRW?LT\C\KDEGM
Ff&5?b@?I08-K-<3f#6K0g),G(TcI@N^[RX2fLG@IHdB(d3]IE\Dac>Z??C;(#a^
)RRPLW[5N-3TTQIS5)V_P)),6$
`endprotected


`endif //  GUARD_SVT_AHB_TRANSACTION_SV
