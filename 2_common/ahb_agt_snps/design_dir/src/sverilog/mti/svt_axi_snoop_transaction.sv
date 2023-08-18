
`ifndef GUARD_SVT_AXI_SNOOP_TRANSACTION_SV
`define GUARD_SVT_AXI_SNOOP_TRANSACTION_SV

`include "svt_axi_defines.svi"

`ifndef __SVDOC__
typedef class svt_axi_snoop_transaction_exception_list;
typedef class svt_axi_snoop_transaction_exception;
`endif

/**
    This is the base class for snoop transaction type which contains all the
    physical attributes of the transaction like address, data, transaction type,
    etc. It also provides the timing information of the transaction to the
    master component, that is, delays for valid and ready signals with respect
    to some reference events. 
    
    The svt_axi_snoop_transaction also contains a handle to configuration object
    of type #svt_axi_port_configuration, which provides the configuration of the
    port on which this transaction would be applied. The port configuration is
    used during randomizing the transaction.
 */
class svt_axi_snoop_transaction extends `SVT_TRANSACTION_TYPE;
//-------------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_axi_snoop_transaction)
`endif

  /**
    @grouphdr snoop_protocol Snoop protocol attributes
    This group contains attributes which are relevant to Snoop protocol.
    */

  /**
    @grouphdr snoop_delays Snoop delay attributes
    This group contains members which can be used to control delays in Snoop signals.
    */

  /**
    @grouphdr snoop_status Snoop transaction status attributes
    This group contains attributes which report the status of Snoop transaction.
    */

  /**
    @grouphdr snoop_timing Timing and cycle information
    This group contains attributes which report the Timing and
    cycle information for Valid and Ready signals.
    */

  /**
    @grouphdr snoop_misc Miscellaneous attributes
    This group contains miscellaneous attributes which do not fall under any of the categories above.
    */

  /**
    @grouphdr ace5_snoop_protocol ACE snoop protocol attributes
    This group contains attributes which are relevant to ACE5 protocol.
    */

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  typedef enum bit [2:0] {
    INVALID = `SVT_AXI_CACHE_LINE_STATE_INVALID,
    UNIQUECLEAN = `SVT_AXI_CACHE_LINE_STATE_UNIQUECLEAN,
    SHAREDCLEAN = `SVT_AXI_CACHE_LINE_STATE_SHAREDCLEAN,
    UNIQUEDIRTY = `SVT_AXI_CACHE_LINE_STATE_UNIQUEDIRTY,
    SHAREDDIRTY = `SVT_AXI_CACHE_LINE_STATE_SHAREDDIRTY
  } cache_line_state_enum;
  /**
   *  Enum to represent snoop transaction type.
   */
  typedef enum bit [3:0]{
    READONCE              = `SVT_AXI_SNOOP_TRANSACTION_TYPE_READONCE,          
    READSHARED            = `SVT_AXI_SNOOP_TRANSACTION_TYPE_READSHARED,
    READCLEAN             = `SVT_AXI_SNOOP_TRANSACTION_TYPE_READCLEAN,
    READNOTSHAREDDIRTY    = `SVT_AXI_SNOOP_TRANSACTION_TYPE_READNOTSHAREDDIRTY,
    READUNIQUE            = `SVT_AXI_SNOOP_TRANSACTION_TYPE_READUNIQUE,
    CLEANSHARED           = `SVT_AXI_SNOOP_TRANSACTION_TYPE_CLEANSHARED,
    CLEANINVALID          = `SVT_AXI_SNOOP_TRANSACTION_TYPE_CLEANINVALID,
    MAKEINVALID           = `SVT_AXI_SNOOP_TRANSACTION_TYPE_MAKEINVALID,
    DVMCOMPLETE           = `SVT_AXI_SNOOP_TRANSACTION_TYPE_DVMCOMPLETE,
    DVMMESSAGE            = `SVT_AXI_SNOOP_TRANSACTION_TYPE_DVMMESSAGE
  } snoop_xact_type_enum;

  /** 
   * Enum to represent snoop transfer sizes
   */
  typedef enum {
    SNOOPBURST_LENGTH_1_BEAT    = `SVT_AXI_SNOOP_BURST_LENGTH_1_BEAT,
    SNOOPBURST_LENGTH_2_BEATS    = `SVT_AXI_SNOOP_BURST_LENGTH_2_BEATS,
    SNOOPBURST_LENGTH_4_BEATS    = `SVT_AXI_SNOOP_BURST_LENGTH_4_BEATS,
    SNOOPBURST_LENGTH_8_BEATS    = `SVT_AXI_SNOOP_BURST_LENGTH_8_BEATS,
    SNOOPBURST_LENGTH_16_BEATS   = `SVT_AXI_SNOOP_BURST_LENGTH_16_BEATS
  } snoop_burst_length_enum;

  /**
   * Enum to represent snoop address delay reference event
   */
  typedef enum {
    ACVALID       = `SVT_AXI_SNOOP_TRANSACTION_ACVALID
  } reference_event_for_acready_delay_enum;

  /** 
   * Enum to represent snoop response delay reference event
   */
  typedef enum {
    SNOOP_ADDR_HANDSHAKE      = `SVT_AXI_SNOOP_TRANSACTION_SNOOP_ADDR_HANDSHAKE,
    SNOOP_RESP_VALID          = `SVT_AXI_SNOOP_TRANSACTION_SNOOP_RESP_VALID,
    SNOOP_RESP_HANDSHAKE      = `SVT_AXI_SNOOP_TRANSACTION_SNOOP_RESP_HANDSHAKE
  } reference_event_for_crvalid_and_first_cdvalid_delay_enum;

  /**
   * Enum to represent subsequent snoop data delay reference event
   */ 
  typedef enum {
    PREV_SNOOP_DATA_VALID     = `SVT_AXI_SNOOP_TRANSACTION_PREV_SNOOP_DATA_VALID,
    PREV_SNOOP_DATA_HANDSHAKE = `SVT_AXI_SNOOP_TRANSACTION_PREV_SNOOP_DATA_HANDSHAKE
  } reference_event_for_next_cdvalid_delay_enum;

  /**
   * Enum to represent suspeneded status of a snoop transaction
   */ 
  typedef enum {
    NOT_SUSPENDED = 0,
    SUSPENDED     = 1,
    RESUMED       = 2,
    ADDED_TO_QUEUE = 3 
  } suspended_status_enum;


  // ****************************************************************************
  // Public Data
  // ****************************************************************************
   /**
     * @groupname snoop_misc
     * Variable that holds the object_id of this transaction
     */
   int object_id = -1;
   
   string pa_object_type ="";
   string pa_channel_name = "";
   string bus_parent_uid = "";
   int pa_count =0;
   /**
     * @groupname snoop_misc
     * The port configuration corresponding to this transaction
     */
   svt_axi_port_configuration port_cfg;

   // ****************************************************************************
   // Local variables only for internal VIP usages
   // ****************************************************************************
   bit [(`CEIL(`SVT_AXI_ACE_SNOOP_ADDR_WIDTH,8))-1:0] acaddrchk_parity_value = 0;
   bit acctlchk_parity_value = 0;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

   /**
     * @groupname snoop_protocol
     * The variable represents Snoop address ACADDR.
     */
   rand bit [`SVT_AXI_ACE_SNOOP_ADDR_WIDTH - 1:0] snoop_addr = 0;

   /**
     * @groupname snoop_protocol
     * The variable represents ACVMIDEXT when svt_axi_port_configuration::axi_interface_type 
     * is set to AXI_ACE with svt_axi_system_configuration::DVMV8_1 ad above.
     * The maximum width of this signal is controlled through macro
     * SVT_AXI_MAX_VMIDEXT_WIDTH. Default value of this macro is 4 based on DVMv8.1 architecture recomendation.
     * 
     */
  
   rand bit [`SVT_AXI_MAX_VMIDEXT_WIDTH - 1:0] acvmid = 0;

   /**
     * @groupname snoop_protocolnn
     * The variable represents Snoop transaction type. Holds value for ACSNOOP.
     * Following are the possible snoop transaction types.
     * 
     * - READONCE
     * - READSHARED
     * - READCLEAN
     * - READNOTSHAREDDIRTY
     * - READUNIQUE
     * - CLEANSHARED
     * - CLEANINVALID
     * - MAKEINVALID
     * - DVMCOMPLETE
     * - DVMMESSAGE
     * .
     */
   rand snoop_xact_type_enum snoop_xact_type = READONCE;

   /** 
     * @groupname snoop_protocol
     * This variable represents the Snoop burst length. For caches that support snooping  
     * with more than one cache line size the snoop burst length is used to indicate 
     * the length of the cache line snoop. Holds value for ACLEN.
     */
   rand snoop_burst_length_enum snoop_burst_length = SNOOPBURST_LENGTH_1_BEAT;

   /** 
     * @groupname snoop_protocol
     * The variable represents Snoop protection information. Of particular
     * importance is ACPROT[1], which indicates the secure or non-secure nature
     * of the snoop.
     */
   rand bit [2:0] snoop_prot = 0;

   /**
     * @groupname snoop_protocol
     * Represents value which will be driven on CRRESP[0] (DATATRANSFER).
     * Used to indicate how a snoop transaction will complete.
     */
   rand bit snoop_resp_datatransfer = 0;

   /**
     * @groupname snoop_protocol
     * Indicates if snoop data is transferred using WriteBack or WriteClean
     * rather than through CD channel. This bit is set by the VIP and
     * is not user controllable. If snoop data is transferred using WRITEBACK
     * or WRITECLEAN, the #snoop_resp_datatransfer bit will be reset to 0 since
     * snoop data will not be transferred using CDDATA channel. Note that this
     * is applicable only when svt_axi_port_configuration::snoop_response_data_transfer_mode is set to SNOOP_RESP_DATA_TRANSFER_USING_WB_WC.
     */
   bit snoop_resp_datatransfer_using_wb_wc = 0;

   /**
     * @groupname snoop_protocol
     * Represents value which will be driven on CRRESP[1] (ERROR).
     * Used to indicate how a snoop transaction will complete.
     */
   rand bit snoop_resp_error = 0;

   /**
     * @groupname snoop_protocol
     * Represents value which will be driven on CRRESP[2] (PASSDIRTY).
     * Used to indicate how a snoop transaction will complete.
     */
   rand bit snoop_resp_passdirty = 0;

   /**
     * @groupname snoop_protocol
     * Represents value which will be driven on CRRESP[3] (ISSHARED).
     * Used to indicate how a snoop transaction will complete.
     */
   rand bit snoop_resp_isshared = 0;

   /**
     * @groupname snoop_protocol
     * Represents value which will be driven on CRRESP[4] (WASUNIQUE).
     * Used to indicate how a snoop transaction will complete.
     */
   rand bit snoop_resp_wasunique = 0;

   /* This value reflects the value of trace_tag */
   rand bit trace_tag = 0;

   /* This value reflects the value of snoop_data trace_tag */
   rand bit snoop_data_trace_tag = 0;

   /* This value reflects the value of snoop_resp_trace_tag */
   rand bit snoop_resp_trace_tag =0;

   /**
     * @groupname snoop_protocol
     * For data phase of snoop transactions, this variable specifies 
     * the data to be driven on CDDATA bus. 
     */
   rand bit [`SVT_AXI_ACE_SNOOP_DATA_WIDTH - 1:0] snoop_data[];
 
   /**
     * @groupname snoop_protocol
     * For data phase of snoop transactions, this variable specifies 
     * the poison to be driven on CDPOISON bus. 
     */
   rand bit [`SVT_AXI_ACE_SNOOP_DATA_WIDTH/64 - 1:0] snoop_poison[];

   /**
     * @groupname snoop_status
     * Represents the initial state of the cache line.
     * This variable is updated by the driver when a snoop transaction
     * is received, but before the cache line is updated. Its contents can be 
     * used to generate the expected values of snoop response. The possible 
     * states correspond to the 5 states of a cache line, namely, 
     * INVALID, UNIQUECLEAN, SHAREDCLEAN, UNIQUEDIRTY and SHAREDDIRTY.
     */
   cache_line_state_enum snoop_initial_cache_line_state = INVALID; 

   /**
     * @groupname snoop_status
     * Represents the initial data of the cache line.
     * This variable is updated by the driver when a snoop transaction
     * is received, but before the cache line is updated. Its contents can be 
     * used to generate the expected values of snoop response. 
     */
   bit[7:0] snoop_initial_cache_line_data[]; 

   /**
     * @groupname snoop_status
     * Represents the final state of the cache line.
     * This variable is updated by the driver when a snoop transaction
     * is received, and the cache line is updated post reception.
     * Possible states correspond to the 5 states of a cache line, namely, 
     * INVALID, UNIQUECLEAN, SHAREDCLEAN, UNIQUEDIRTY and SHAREDDIRTY.
     */
   cache_line_state_enum snoop_final_cache_line_state = INVALID; 

   /**
     * @groupname snoop_status
     * Represents the final data of the cache line.
     * This variable is updated by the driver when a snoop transaction
     * is received, and the cache line is updated post reception.
     */
   bit[7:0] snoop_final_cache_line_data[]; 

   /**
     * @groupname snoop_status
     * Represents the status of the snoop address.  
     * Following are the possible status types:
     * 
     * - INITIAL           : Snoop Address has not yet started on the channel.
     * - ACTIVE            : Snoop Address valid is asserted but ready is not. 
     * - ACCEPT            : Snoop Address handshake is complete.
     * - ABORTED           : Current transaction is aborted.
     * .
     */
   status_enum snoop_addr_status = INITIAL;

   /**
     * @groupname snoop_status
     * Represents the status of the snoop data transfer.  
     * Following are the possible status types:
     *
     * - INITIAL           : Snoop Data has not yet started on the channel.
     * - ACTIVE            : Snoop Data valid is asserted but ready is not 
     *                       for the current data-beat. The current beat is 
     *                       indicated by curent_snoop_data_beat_num variable.
     * - PARTIAL_ACCEPT    : The current Snoop data-beat is completed but 
     *                       the next snoop data-beat is not started. 
     *                       The completed beat is indicated by #current_snoop_data_beat_num.
     * - ACCEPT            : Data phase is complete. 
     * - ABORTED           : Current transaction is aborted.
     * .
     */
   status_enum snoop_data_status = INITIAL;

   /**
     * @groupname snoop_status
     * Represents the status of the snoop response transfer.
     * Following are the possible status types:
     *
     * - INITIAL           : Snoop response has not yet started on the channel.
     * - ACTIVE            : Snoop response valid is asserted but ready is not. 
     * - ACCEPT            : Snoop response handshake is complete.
     * - ABORTED           : Current transaction is aborted.
     * .
     */
   status_enum snoop_resp_status = INITIAL;

   /**
     * @groupname snoop_status
     * This is a counter which is incremented for every snoop data beat. 
     * Useful when user would try to access the transaction class to know 
     * its current state. This represents the beat number for which the 
     * status is reflected in member snoop data_status.
     */
   int current_snoop_data_beat_num = 0;

  /**
   * @groupname ace5_snoop_protocol
   * This variable stores the data check parity bit's with respect to valid snoop data,
   * Each bit of data check parity is calculated from every 8bit of data.
   * Applicable when svt_axi_port_configuration::check_type is set to ODD_PARITY_BYTE_DATA.
   */
  rand bit [(`SVT_AXI_ACE_SNOOP_DATA_WIDTH/8) - 1:0] datachk_parity_value[];
  
  /**
   * @groupname ace5_snoop_protocol
   * This variable stores the data check parity error bit's with respect to valid data,
   * Each bit of parity check data is calculated from every 8bit of snoop data with 1bit if datachk.
   * By default all bits are set to 'b1, if any parity error is detected the that particular bit is set to 0.
   * Applicable when svt_axi_port_configuration::check_type is set to ODD_PARITY_BYTE_DATA.
   */
  rand bit [(`SVT_AXI_MAX_DATA_WIDTH/8)-1:0] is_datachk_passed[] ;


  /**
   * @groupname ace5_protocol
   * This variable represents the data check parity error is deducted in a
   * transaction.
   * In a transaction if data check parity error is deducted, the this bit is set to 1.
   * Applicable when svt_axi_port_configuration::check_type is set to ODD_PARITY_BYTE_DATA.
   */
  rand bit is_datachk_parity_error = 0;

   /**
     * @groupname snoop_delays
     * Defines a reference event with respect to which ACREADY signal is delayed.
     * Following are the supported reference events:
     *
     * - ACVALID : Reference event for ACREADY is assertion of ACVALID signal.
     * .
     */
   rand reference_event_for_acready_delay_enum reference_event_for_acready_delay = ACVALID;

   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for ACREADY signal.
     * The reference event for this delay is #reference_event_for_acready_delay.
     */
   rand int acready_delay = 0;

   /**
     * @groupname snoop_protocol
     * Indicates if CDDATA must be sent before CRRESP is sent.
     * When set to 1 CDDATA is sent before CRRESP.
     * When set to 0, CDDATA is sent only after CRRESP is handshaked.
     */
   rand bit data_before_resp = 0;

   /**
     * @groupname snoop_delays
     * Defines the reference event with respect to which CRVALID signal is delayed.
     * Following are the supported reference events:
     * 
     * - SNOOP_ADDR_HANDSHAKE : Reference is when last address phase takes place.
     * .
     */
   rand reference_event_for_crvalid_and_first_cdvalid_delay_enum reference_event_for_crvalid_delay = SNOOP_ADDR_HANDSHAKE;

   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for CRVALID signal.
     * The reference event for this delay is #reference_event_for_crvalid_delay.
     */
   rand int crvalid_delay = 0;

   /**
     * @groupname snoop_delays
     * Defines the reference event for delay of CDVALID signal for first beat.
     * The delay must be programmed in #cdvalid_delay[0].
     * Following are the supported reference events. SNOOP_RESP_VALID and SNOOP_RESP_HANDSHAKE
     * are valid values only when data_before_resp is 0:
     * 
     * - SNOOP_ADDR_HANDSHAKE : Reference is when snoop address handshake takes place.
     * - SNOOP_RESP_VALID        : Reference event for first CDVALID is assertion of CRVALID signal
     * - SNOOP_RESP_HANDSHAKE    : Reference event for first CDVALID is snoop response handshake
     * .
     */
   rand reference_event_for_crvalid_and_first_cdvalid_delay_enum reference_event_for_first_cdvalid_delay = SNOOP_RESP_VALID;

   /**
     * @groupname snoop_delays
     * Defines the reference event for delay of CDVALID signal for
     * second beat onwards.
     * Following are the supported reference events:
     *
     * - PREV_CDVALID : Reference event is assertion of previous CDVALID
     * - PREV_SNOOP_DATA_HANDSHAKE : Reference event is previous snoop data handshake
     * .
     */
   rand reference_event_for_next_cdvalid_delay_enum reference_event_for_next_cdvalid_delay = PREV_SNOOP_DATA_VALID;

   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for CDVALID signal.
     * The reference event for delay of CDVALID signal for first beat is
     * #reference_event_for_first_cdvalid_delay. The reference event for delay of
     * CDVALID signal for second beat onwards is
     * #reference_event_for_next_cdvalid_delay.
     */
   rand int cdvalid_delay[];

   /** @cond PRIVATE */
   /** 
    * Object used to hold exceptions for a packet. 
    */
   `ifndef __SVDOC__
   `ifndef INCA
   svt_axi_snoop_transaction_exception_list exception_list = null; 
   `endif
   `endif

   // Variables needed by the slave to drive signals
   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for driving ACVALID signal to send 
     * snoop request to an ACE master.
     */
   rand int acvalid_delay;

   /** 
    * @groupname snoop_delays
    * Delay to drive CRREADY
    * If configuration parameter #svt_axi_port_configuration::default_crready is
    * FALSE, this member defines the CRREADY signal delay in number of clock
    * cycles.
    *
    * If configuration parameter #svt_axi_port_configuration::default_crready is
    * TRUE, this member defines the number of clock cycles for which CRREADY
    * signal should be deasserted after each handshake, before pulling it up
    * again to its default value.
    *
    */
   rand int crready_delay;
  /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for ACWAKEUP signal assertion
     * before or after ACVALID signal.
     */
   rand int acwakeup_assert_delay;
   
   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for ACWAKEUP signal deassertion
     * after ACVALID-ACREADY signal handshake.
     */
   rand int acwakeup_deassert_delay;

   /** if this bit is set to '0' then ACWAKEUP signal will be asserted 
     * before ACVALID with respect to acwakeup_assert_delay.
     * if this bit is set to '1' then ACWAKEUP signal will be asserted
     * after ACVALID with respect to acwakeup_assert_delay.
     */
   rand bit assert_acwakeup_after_acvalid = 0;
   /**
     * @groupname snoop_delays
     * Defines the delay in number of cycles for CDREADY signal.
     * If configuration parameter #svt_axi_port_configuration::default_cdready is
     * FALSE, this member defines the CDREADY signal delay in number of clock
     * cycles.
     *
     * If configuration parameter #svt_axi_port_configuration::default_cdready is
     * TRUE, this member defines the number of clock cycles for which CDREADY
     * signal should be deasserted after each handshake, before pulling it up
     * again to its default value.
     *
     */
   rand int cdready_delay[];
   /** @endcond */

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for address valid of snoop
     * transaction. The simulation clock cycle number when the address valid is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   int snoop_addr_valid_assertion_cycle;

    /**
     * @groupname snoop_timing
     * This variable stores the cycle information for address wakeup of snoop
     * transaction. The simulation clock cycle number when the address wakeup is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   int snoop_addr_wakeup_assertion_cycle;

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for data valid of snoop
     * transaction. The simulation clock cycle number when the data valid is
     * asserted, is captured in this member. The cycle number for first data
     * valid is captured in index 0, cycle number for second data valid is
     * captured in index 1, and so on. This information can be used for doing
     * performance analysis. VIP updates the value of this member variable, user
     * does not need to program this variable.
     */
   int snoop_data_valid_assertion_cycle[];

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for response valid of snoop
     * transaction. The simulation clock cycle number when the response valid is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   int snoop_resp_valid_assertion_cycle;

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for address ready of snoop
     * transaction. The simulation clock cycle number when the address ready is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   int snoop_addr_ready_assertion_cycle;

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for data ready of snoop
     * transaction. The simulation clock cycle number when the data ready is
     * asserted, is captured in this member. The cycle number for first data
     * ready is captured in index 0, cycle number for second data ready is
     * captured in index 1, and so on. This information can be used for doing
     * performance analysis. VIP updates the value of this member variable, user
     * does not need to program this variable.
     */
   int snoop_data_ready_assertion_cycle[];

   /**
     * @groupname snoop_timing
     * This variable stores the cycle information for response ready of snoop
     * transaction. The simulation clock cycle number when the response ready is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   int snoop_resp_ready_assertion_cycle;

   /**
     * @groupname snoop_timing
     * The simulation time when the master or slave driver receives
     * the snoop transaction from the sequencer, is captured in this member.
     * This information can be used for doing performance analysis. 
     * VIP updates the value of this member
     * variable, user does not need to program this variable.
     */
   real snoop_xact_consumed_by_driver_time;
  
   /**
     * @groupname axi3_4_ace_timing
     * This variable stores the transaction consumed at driver timing
     * information. The snoop transaction consumed at driver time to begin time
     * delay is calculated as the difference between begin_time and
     * snoop_xact_consumed_by_driver_time.
     * This information can be used for doing performance analysis.
     * VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
 
   real snoop_xact_consumed_time_to_begin_time_delay;
  
   /**
     * @groupname snoop_timing
     * This variable stores the timing information for address valid of snoop
     * transaction. The simulation time when the address valid is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real snoop_addr_valid_assertion_time;

 /**
     * @groupname snoop_timing
     * This variable stores the timing information for address valid of snoop
     * transaction. The simulation time when the address wakeup is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real snoop_addr_wakeup_assertion_time;
   /**
     * @groupname snoop_timing
     * This variable stores the timing information for wakeup of idle snoop
     * channel. The simulation time when the wakeup is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real idle_snoop_chan_wakeup_toggle_assertion_time;
   
   /**
     * @groupname snoop_timing
     * This variable stores the timing information for wakeup of idle snoop
     * channel. The simulation time when the wakeup is
     * deasserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real idle_snoop_chan_wakeup_toggle_deassertion_time;
   
   /**
     * @groupname snoop_timing
     * This variable stores the timing information for data valid of snoop
     * transaction. The simulation time when the data valid is
     * asserted, is captured in this member. The simulation time for first data
     * valid is captured in index 0, simulation time for second data valid is
     * captured in index 1, and so on. This information can be used for doing
     * performance analysis. VIP updates the value of this member variable, user
     * does not need to program this variable.
     */
   real snoop_data_valid_assertion_time[];

   /**
     * @groupname snoop_timing
     * This variable stores the timing information for response valid of snoop
     * transaction. The simulation time when the response valid is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real snoop_resp_valid_assertion_time;

   /**
     * @groupname snoop_timing
     * This variable stores the timing information for address ready of snoop
     * transaction. The simulation time when the address ready is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real snoop_addr_ready_assertion_time;

   /**
     * @groupname snoop_timing
     * This variable stores the timing information for data ready of snoop
     * transaction. The simulation time when the data ready is
     * asserted, is captured in this member. The simulation time for first data
     * ready is captured in index 0, simulation time for second data ready is
     * captured in index 1, and so on. This information can be used for doing
     * performance analysis. VIP updates the value of this member variable, user
     * does not need to program this variable.
     */
   real snoop_data_ready_assertion_time[];

   /**
     * @groupname snoop_timing
     * This variable stores the timing information for response ready of snoop
     * transaction. The simulation time when the response ready is
     * asserted, is captured in this member. This information can be used for
     * doing performance analysis. VIP updates the value of this member variable,
     * user does not need to program this variable.
     */
   real snoop_resp_ready_assertion_time;

   /**
    *  @groupname snoop_timing
    *  This variable stores the timing information for the snoop data channnel blocking ratio.
    *  The blocking cycle for a beat is defined as the number of cycles that
    *  valid was asserted, but corresponding ready was not asserted.
    *  This ratio is derived from data_valid_assertion_cycle and
    *  snoop_data_ready_assertion_cycle, calculated as sum of data ready
    *  blocking cycles divided by sum of data valid assertion cycles.
    *  This information can be used for doing performance analysis.
    *  VIP updates the value of this member variable, user
    *  does not need to program this variable.
    */
 
   real snoop_data_chan_blocking_ratio;

    /** 
     * @groupname snoop_timing
     * Time at which this transaction is supplied to snoop sequencer by the monitor 
     */
    real monitor_to_seqr_time = 0;

  /**
    * Weight used to control distribution of zero delay within transaction generation.
    *
    * This controls the distribution of delays for the 'delay' fields 
    * (e.g., delays for asserting the ready signals). 
    */
  int ZERO_DELAY_wt = 100;

  /**
    * Weight used to control distribution of short delays within transaction generation.
    *
    * This controls the distribution of delays for the 'delay' fields 
    * (e.g., delays for asserting the ready signals). 
    */
  int SHORT_DELAY_wt = 500;

  /**
    * Weight used to control distribution of long delays within transaction generation.
    *
    * This controls the distribution of delays for the 'delay' fields 
    * (e.g., delays for asserting the ready signals). 
    */
  int LONG_DELAY_wt = 1;

  /**
    * Weight used to control distribution of attribute values within
    * transaction generation.
    *
    * (e.g., probability of CRRESP[1] (ERROR) being asserted). 
    */
  int SMALL_wt = 1;
 
  /**
    * Weight used to control distribution of attribute values within
    * transaction generation.
    */
  int LARGE_wt = 500;

  suspended_status_enum suspended_status = NOT_SUSPENDED;

  /** Indicates if any memory update transaciton is found to be in progress when
    * current snoop transaciton is received. Master will set this bit.
    */
  bit is_mem_update_transaction_in_progress = 0;

  /** if this bit is set to '0' then WasUnique bit can be disabled by user (i.e. set 
    * to '0') as part of snoop response.
    * NOTE: User should reset this bit in snoop response sequence before randomizing
    * the snoop response if the user wants to set the WasUnique bit of the snoop 
    * response to 0 even though the cacheline was in a unique state.
    */
  bit snoop_resp_wasunique_enable = 1;
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  local int suspend_snoop_or_respond = -1;

`ifdef SVT_VMM_TECHNOLOGY
  local static vmm_log shared_log = new("svt_axi_snoop_transaction", "class" );
`endif
  /** flag to indicate current snoop transaction is part of multipart dvm sequence */
  protected bit is_part_of_multipart_dvm_sequence = 0;


  // ****************************************************************************
  // Constraints
  // ****************************************************************************

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
m/oiATcI+RMZIPQiZQ6M49haxx8nxZr0Vi4U04a13Y+jo3w2NCW1udDexhWXrTA8
v9q0YwxUF3Cl/RPsGAwSxa8rtDtZpihSmSeG6DrKkdJ38Md/to4i9nGBtzic1IwH
tSG4eIZ8u1w41N/w46goze9OwI//aoMU6Bzza02we9w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 767       )
hWMewXce6ShubSCxy+kTNbpGq69VRuD58JByUGnOVM8SAHbJv+p2rT67WfUmlxAz
pG7XvXIc35BDQQ8FfAOQzkSyi8j9I+JMWIDKjZEmwQWpjEqV5fLRKCN7qPB9vI4R
FVQV3INb1kR2yyrDNisUc5nsGCX5rFUd9vzBtxzAConm9mquwgBBSxNuezjB1rmM
ZvtUZ5KeqAlXzshtcrxCKvflK4rDQufboXK5XtwknzlFCzo3OIYuTfKRR9rjPlgi
d2Pk3ACJDvcnxQwwCIfclbQpgZ1AXhrWivMyif71qMlQ7JY5VdxtBSoIFC84p+W+
Tn0c3PFV7PtCQvHjU4h0Fg6jTSqJsdSo6qxj9EpSiNNoOXUVinAJnu1ATYuaHwFY
7V6tX4/BxR4YLUt48sBE+pWj9T2iqqtCGEAmnE1OfFLEQU4WJ0j5DP4a2uLNRHJQ
FMR3GU2Y9g17jVZi5Ge7koInmBDwNjm5q4X5vPSCQEDTnzilwLXW+bEM8b6gyM8K
r2Cmb6mvIEMb5Rflj7fKv83O3j1rDNvw/ieQRgl42kFMmiZRHKHqkJ6D13h93M1N
RHGCji7SQ6XAAHdKzFoOlijAOukjJ94IpEq9w3YRcMLZbL03OF4NuJd4l5o9OUgQ
a188+clGUSv9NBQhzPHVYAKdYckWEIxY4GFvQw2PWQtC6T81ugzIQR7TbDfp6ift
I8Hw8h0DuBCrQTSNp3x0OQx4u65TYdF/e+N7ApejzTBM8t5hx6yzA3dnRmDD1OH9
6r6u0dNMI1PYON9ix9N7wxZREDAF83yFzY4lpCT5C61bVameYxOuHbBSEIXAA+L8
U9FkKlXAKi6BB1XRIF7wzfLKpfNKja21+DLEr0YJ8SGfcwjgL/DzmvdynMq2PMmH
04Lu0Ns38xxRgS7JMCGQRJSigdLrKncUJIO94527y7dWMEc+ocZPiSC2PS1V/PcC
bUyY2M03DAZ4bN9aXm5x2r3iwn51O9AbcJRW/ptNSAUDJhI/1JC0pc8M8JZQv0CF
`pragma protect end_protected

`ifdef SVT_UVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_snoop_transaction",svt_axi_port_configuration port_cfg_handle = null);
`elsif SVT_OVM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_axi_snoop_transaction",svt_axi_port_configuration port_cfg_handle = null);
`else
`svt_vmm_data_new(svt_axi_snoop_transaction)
  extern function new (vmm_log log = null, svt_axi_port_configuration port_cfg_handle = null);
`endif

  // ****************************************************************************
  // SVT shorthand macros 
  // ****************************************************************************
 
  `svt_data_member_begin(svt_axi_snoop_transaction)
    `svt_field_object     (                          port_cfg,                    `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
`ifndef INCA
    `svt_field_object      (exception_list,                             `SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOMPARE|`SVT_UVM_NOPACK,  `SVT_HOW_DEEP)
`endif
    `svt_field_int        (                          object_id,                   `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_int        (snoop_addr,                                            `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_int        (acvmid,                                            `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_enum       (snoop_xact_type_enum,     snoop_xact_type,             `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (snoop_burst_length_enum,  snoop_burst_length,          `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_prot,                  `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_int        (                          snoop_resp_datatransfer,     `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_datatransfer_using_wb_wc,     `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_error,            `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_passdirty,        `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_isshared,         `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_wasunique,        `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          trace_tag,        `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_data_trace_tag,        `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_trace_tag,        `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (                          snoop_data,                  `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_array_int  (                          datachk_parity_value,        `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_array_int  (                          is_datachk_passed,        `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_array_int  (                          snoop_poison,                  `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_enum       (cache_line_state_enum,snoop_initial_cache_line_state,`SVT_ALL_ON | `SVT_NOCOMPARE)
     `svt_field_array_int  (snoop_initial_cache_line_data,                           `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_enum       (cache_line_state_enum,snoop_final_cache_line_state,`SVT_ALL_ON | `SVT_NOCOMPARE)
     `svt_field_array_int  (snoop_final_cache_line_data,                           `SVT_ALL_ON | `SVT_NOCOMPARE | `SVT_HEX)
    `svt_field_enum       (status_enum,              snoop_addr_status,           `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (status_enum,              snoop_data_status,           `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (status_enum,              snoop_resp_status,           `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          current_snoop_data_beat_num, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (reference_event_for_acready_delay_enum, reference_event_for_acready_delay, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          acready_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          data_before_resp,            `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          is_datachk_parity_error,     `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          crvalid_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (                          cdvalid_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          acvalid_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          acwakeup_assert_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          acwakeup_deassert_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          crready_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (                          cdready_delay,               `SVT_ALL_ON | `SVT_NOCOMPARE)   
    `svt_field_enum       (reference_event_for_crvalid_and_first_cdvalid_delay_enum, reference_event_for_crvalid_delay, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (reference_event_for_crvalid_and_first_cdvalid_delay_enum, reference_event_for_first_cdvalid_delay, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (reference_event_for_next_cdvalid_delay_enum, reference_event_for_next_cdvalid_delay,   `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum       (suspended_status_enum, suspended_status,   `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          is_mem_update_transaction_in_progress, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_wasunique_enable, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_addr_valid_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_addr_wakeup_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (                          snoop_data_valid_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_valid_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_addr_ready_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_int  (                          snoop_data_ready_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          snoop_resp_ready_assertion_cycle, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_xact_consumed_by_driver_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_xact_consumed_time_to_begin_time_delay,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_addr_valid_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_addr_wakeup_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          idle_snoop_chan_wakeup_toggle_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          idle_snoop_chan_wakeup_toggle_deassertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_real (                          snoop_data_valid_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_resp_valid_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_addr_ready_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_array_real (                          snoop_data_ready_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_resp_ready_assertion_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          snoop_data_chan_blocking_ratio,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_real       (                          monitor_to_seqr_time,  `SVT_TIME | `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int        (                          ZERO_DELAY_wt,                    `SVT_ALL_ON | `SVT_NOCOMPARE )
    `svt_field_int        (                          SHORT_DELAY_wt,                   `SVT_ALL_ON | `SVT_NOCOMPARE )
    `svt_field_int        (                          LONG_DELAY_wt,                    `SVT_ALL_ON | `SVT_NOCOMPARE ) 
    `svt_field_int        (                          SMALL_wt,                         `SVT_ALL_ON | `SVT_NOCOMPARE )
    `svt_field_int        (                          LARGE_wt,                         `SVT_ALL_ON | `SVT_NOCOMPARE )
  `svt_data_member_end(svt_axi_snoop_transaction)



  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

  `ifndef INCA
  `ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(uvm_object rhs);
  `elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Extend the UVM copy routine to cleanup
   * the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(ovm_object rhs);
`else

  //----------------------------------------------------------------------------
  /**
   * Extend the svt_post_do_all_do_copy method to cleanup the exception xact pointers.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function void svt_post_do_all_do_copy(`SVT_DATA_BASE_TYPE to);
`endif
 `endif


`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(ovm_object rhs, ovm_comparer comparer);
`else
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
  /**
   * Does a basic validation of this snoop transaction object
   */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern allocate_pattern ();

   // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the fields to get only the fields to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Generates an SVT pattern object to represent the properties which are to be
   * written to FSDB when a full tranaction is to be recorded.  Note that not all
   * properties are written.  Instead, only properties needed for debug are added.
   * 
   * @return An svt_pattern instance containing entries to be written to FSDB
   */
   extern virtual function svt_pattern populate_full_xml_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Generates an SVT pattern object to represent the properties which are to be
   * written to FSDB when the PA channel is SNOOP_RESP, SNOOP_ADDR, or SNOOP_DATA.
   * 
   * @return An svt_pattern instance containing entries to be written to FSDB
   */
   extern virtual function svt_pattern populate_filtered_xml_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Generates an SVT pattern object to represent the properties which are to be
   * written to FSDB when the pa_format_type is set to FSDB_PERF_ANALYSIS.
   * 
   * @return An svt_pattern instance containing entries to be written to FSDB
   */
   extern virtual function svt_pattern populate_perf_analysis_xml_pattern();

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
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

//----------------------------------------------------------------------------------------
 /**
  * This method is used to set object_type for bus_activity when
  * bus_activity is getting started on the bus .
  * This method is used by pa writer class in generating XML/FSDB 
  */
  extern virtual function void set_pa_data(string typ , string channel,int count);
  
//----------------------------------------------------------------------------------------
 /**
  * This method is used to  delate  object_type for bus_activity when bus _activity 
  * ends on the bus .
  * This methid is used by pa writer class  in generating XML/FSDB 
  */
  extern virtual function void clear_pa_data();

//--------------------------------------------------------------------------------------
 /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
  extern virtual function string get_uid();

//--------------------------------------------------------------------------------  

  /** Sets the configuration property */
  extern function void set_cfg(svt_axi_port_configuration cfg);

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
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);
  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ZNOKW+wCVsBn4IXWSUz9btF7dr6RKbP/SbBu7JPbc95mZoK+LtV82a7BKK6azeDQ
9qYb0HfH7DyL3aoOGeYzaBCbQlxpqPxGcjJ9Pm5HM1MIMaDrtZ+Ic4JcJCC2NC1s
6PmoFcZfReANuYFsh9hIEMw29blUQ8tWjNZbF0zccLo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 906       )
BF/hlCoio7gqot8lMr2AxfC1MCSTFyDag89FLa1YSSprELhZlw1/NLA5qnJ6j1Yn
kuZf1lkd01BroWWQGywpfnTCkJ6y1EkkvmasRWjj689e4amjDwD4cRT2QA4F9J1I
YNk3VWEP4lf74BOZvx5VZemGYU1NfCyULVBxGqHMENKeQHn6hyVsDDofoANUK3F7
`pragma protect end_protected
  /**
    * Returns the encoding for AWSNOOP/ARSNOOP/ACSNOOP based on the 
    * transaction type
    * @return The encoded value of AWSNOOP/ARSNOOP/ACSNOOP
    */
  extern function bit[`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0] get_encoded_snoop_val();
  /**
    * Decodes the given snoop value(ARSNOOP/ACSNOOP) and returns the transaction type.
    * This function can be used for the read address channel and the
    * snoop address channel. 
    * @param snoop_val The value on ARSNOOP/ACSNOOP
    */
  extern function snoop_xact_type_enum get_decoded_snoop_val(bit[`SVT_AXI_ACE_SNOOP_TYPE_WIDTH-1:0] snoop_val);

  /**
    * Checks if the coherent transaction is DVM Sync
    */
   extern function bit is_snoop_dvm_sync();

  /**
    * Returns the burst_length as an integer based on snoop_burst_length.
    * @return The burst length in int.
    */
  extern function int get_burst_length();

   /**
    * Returns the data in the data_to_pack[] field as a byte stream based on
    * the burst_type. The assumption is that snoop_data[] field
    * of this class have been passed as arguments to data_to_pack[] field.
    * In the case of WRAP bursts the data is returned such that packed_data[0] 
    * corresponds to the data for the wrap boundary. 
    * In the case of INCR bursts, the data as passed in data_to_pack[] is directly
    * packed to packed_data[]. 
    * @param data_to_pack Data to be packed
    * @param packed_data[] Output byte stream with packed data
    */
  extern function void pack_data_to_byte_stream(
                                          input bit[`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0] data_to_pack[],
                                          output bit[7:0] packed_data[]
                                        ); 

  /**
    * Unpacks the data in data_to_unpack[] into unpacked_data.
    * For an INCR burst, the data is directly unpacked into unpacked_data
    * For a WRAP burst, the data is unpacked such that unpacked_data[0] corresponds
    * to the starting address. The assumption here is that data_to_unpack[] has
    * a byte stream whose data starts from the address corresponding to the wrap
    * boundary
    * @param data_to_unpack The data to unpack.
    * @param unpacked_data The unpacked data.
    */
  extern function void unpack_byte_stream_to_data( 
                                            input bit[7:0] data_to_unpack[],
                                            output bit[`SVT_AXI_ACE_SNOOP_DATA_WIDTH-1:0] unpacked_data[]
      );

   /**
    * Unpacks the poison in poison_to_unpack[] into unpacked_poison.
    * For an INCR burst, the poison is directly unpacked into unpacked_poison
    * For a WRAP burst, the poison is unpacked such that unpacked_poison[0] corresponds
    * to the starting address. The assumption here is that poison_to_unpack[] has
    * a byte stream whose poison starts from the address corresponding to the wrap
    * boundary
    * @param poison_to_unpack The data to unpack.
    * @param unpacked_poison The unpacked data.
    */
    extern function void unpack_byte_stream_to_poison( 
                                            input bit  poison_to_unpack[],
                                            output bit[`SVT_AXI_ACE_SNOOP_DATA_WIDTH/64-1:0] unpacked_poison[]
      );
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
    * Returns the value of CRRESP of this transaction 
    * @return The value of CRRESP
    */
  extern virtual function bit[`SVT_AXI_ACE_SNOOP_RESP_WIDTH-1:0] get_crresp_value();

  /** returns address aligned to cacheline size 
    * @param use_tagged_addr If it is set to '0' then only cacheline size aligned address is returned.
    *                        But, if it is set to '1' then it appends address tag attribute to the MSB
    *                        bits of cachelien size aligned address and returns the concatenated address.
    */
  extern virtual function bit[`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0] cacheline_addr(bit use_tagged_addr=0);

  /** returns address aligned to the number of lsb address bits monitored by exclusive monitor */
  extern virtual function bit[`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0] excl_addr(bit use_partial_addr=1, bit use_cacheline_addr=1);

  /** returns calculated parity value for 8bit of data */
  extern virtual function bit parity_bit_from_8bit_data(bit [7:0] data, bit even_odd_parity = 1);
  extern virtual function bit parity_bit_from_16bit_data(bit [15:0] data, bit even_odd_parity = 1);
  extern virtual function bit parity_bit_from_1bit_data(bit data, bit even_odd_parity = 1);  
  extern virtual function void parity_for_xact_field(input string xact_signal_name = "",
                                                      input bit even_odd_parity = 1
                                                );

  /** returns the status corresponding to the status mode value passed for snoop channel */
  extern function status_enum get_snoop_status(int status_mode);

  /** Returns address concatenated with tagged attributes which require indipendent address space.
  * for example, if secure access attribute is enabled bye setting num_enabled_tagged_addr_attributes[0] = 1
  * then this bit will be used to provide unique address spaces for secure and non-secure transactions.
  *
  * @param  use_arg_addr Indicates that address passed through argument "arg_addr" will be used instead of 
  *                      transaction address "addr", when set to '1'. If set to '0' then transaction address
  *                      "this.addr" will be used for tagging.
  * @param      arg_addr Address that needs to be tagged when use_arg_addr is set to '1'
  * @return              Returns address tagged with address attribute of corresponding port
  */
  extern function bit[`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0] get_tagged_snoop_addr(bit use_arg_addr=0, bit[`SVT_AXI_ACE_SNOOP_ADDR_WIDTH-1:0] arg_addr = 0);

  /** mark end of transaction */
  extern virtual function void set_end_of_transaction(bit abort=0);

  /** sets flag to indicate that current transaction is part of multipart dvm sequence */
  extern virtual task set_multipart_dvm_flag (string kind = "");

  /** returns flag that indicates if current transaction is part of multipart dvm sequence */
  extern virtual function bit get_multipart_dvm_flag (string kind = "");

  /** Returns 1 if current transaction is a DVM transaction */
  extern virtual function bit is_dvm();

//  /** Returns 1 if current transaction is a DVM transaction */
//  extern virtual function bit skip_port_interleaving();

  /** indicates whether this snoop transaction must be suspended or not */
  extern virtual function bit do_suspend_snoop(bit cache_invalid);

  /** inidcates if snoop transaction was aborted at either address, response or data transfer channel */
  extern virtual function bit is_aborted(int mode=0);

  /** returns '1' if current snoop transaction is of invalidating type and considered for terminating exclusive access */
  extern virtual function bit is_invalidating_exclusive_access(int mode=0);


`ifdef SVT_VMM_TECHNOLOGY
  `vmm_class_factory(svt_axi_snoop_transaction)
`endif
endclass
/**
Utility Macors & Utility Methods of the svt_axi_snoop_transaction class.
*/


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kOBLpjzoUPy4FWnhnSh4hxNOvENrAnLZQIrLh13rV73nr162ga++QPBD0dPoqIO5
mV/Lukj33eQADgxSO4pfqsdMcbRrNLcGjiJemI08NX23vQ8MV1ydaCb0gc8Du4KE
aDPY/3obv5oqRUgL+Ha6ZrR+z58LvI2h4+IOnZKF2cw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1880      )
6x82QrTrbaxE/GjS/gaH86zWWP7jM0sLwciv0NuySLRglmfLEJ26mjXeT62XtzHK
MIIRXkFThivlmp8BRiXl/YRTtez0vRMA9jxZsFrSTVQQ4m8zAU3RYqlqpPyp44AY
MNfoJmGAfAVVAEx726VwP+I5XVDweKIVnIocfIClK8tSDdo0yOl3zFhMQVMbc73T
u2mUQj21o8kzUUy7vmBfeH0cio036Ewi8XTMwdMYmc2txc6wRnyrYNaxsJ4jwdOX
KCOK87POidtAD9IfpGzJ8Bw4Fki5alHMuuLSBzTVU30xITBruT7YVbRyfE14OWpR
BO5gVtWs1qxKWM/jNpsrLOZ23D8U2K/9+zKFKM4ApPG118RvavWzb82x9H03YJMT
2dvbH3jIwFauz6V3ZFKyLbbcIYWtaXwoMVEwegOH6coPMNymkqofTs/yWMUNQw5n
uP8CM0Sp1KyV+z7NzizXTWPFyuw1L/WLP3yTRLxFgRbjE/Mv/OI+6GZGTihnnfsU
Xt7q9SLP1YeKQU580O8xFWsxaxU2+yseGCwkCYm40yq0J86b3e7fO4ibtmYzgsoZ
CnjXf6UtM6fFQQW/sJdcEHYqGx9SN83zI01gxTwPWR68RdnEquX63ZRcWQWyoOej
yihw2UG19g8hq+VafqcGsvC/ycq4WeXV3FkVeaNV6JYqvF/BsVuoNmKSPIMHUQjU
duB0OsHruXmloSQeAHiDt5Ow8n0IHsOz0o2qvBPmz8BdP+yEHy6aN+7B5gMB/M/y
xLf3Tubxv8/olYq//A/WtANIbrysSEMp1ZDlzevVSyrYjg+KuKLCMmxqSa1fBzaN
ILhEIilQzFRXprwKg1WRxZYGhKtD/RsytLwTLLimz8hAQ0R1Br15+3rXH8G7U3m1
LbSOscl8LaAdCRMhuj5d3DbyJ8LqvP2GnTJMEoGEPsXBCvrPTkPWH+FJ0fm1QWju
w8Ut/vUANHxwzi71pU+G1R1kDGIJAu7JvlQ6levWYKnoups8qnzomsKPkUMgFQAh
55hh+1uvwi8VmL/nlj/PFIuyQs8iYh7R+oTorOcdchUnbqqLZDJgQ9suZAHTBm1A
FCrbDstPnpfwSanywTcM02qC3trXyK14fo8UfqNJATf9mDVh5EWzj0bDlFNKz2dr
Td/sZi+Zbm81TEshB/0bQeIQVbi3AwZJmwQWHjOtpn1qza58RM6o5/pzm+ERls5n
9xF2j+k/iWm5lfmKqYnVTxMXRR57SiGqV3h6AsH/s6+ITpytqfjfmYO7VdJQDMRn
qoLl+GfIplbaKsNbSHg4Ug==
`pragma protect end_protected
  
  //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fv6qijpVxIdWY1ehJPcX2TVMYIja08hEaFMdbQvaXU6HINe8q5msGlYoJfFZv1AR
H/cdSmFMHwGvMKUyZmk/7JKC1MlzCovWsAmrSysBYQQMo0BdbYRdifEddw/5B569
GRti4DXy2gCFP3b3OWVVKsUGf70gnzgKQd+HFk+MGSM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2574      )
b4iMt4CIl4Aq+2l4DPYpvxPva4a35HKwzznLv5dbUyURAMQ9ID6PiGWPkRRcAp8t
WjbdV05cjaHcqQBd9kjav7B6ZKv3BiXXmtbf9iY+rA8kx77DXIdfkwZy0gvizl4n
r0NMHXWhmdI2o6Lxk6rQBTYMKoQpdIhUHkZ4mKbwP41+Jw1EBAXoFj7MKAb9ADFg
p+VlHaOk2tSq2b+5+Jw08MOcaizbiCcV25CTAZarMrWtqHQDTVCq/2TqXOHHJNTx
uS7Ja79pFYzkExDBEpQyyaswJG9ew1dqVHaYv8yhNahVwC9JN4zICuFJVTLlWkKN
/DBwMIIJ+8uuKqKSc0v1iemha5kL+pFQRrXiJmPNQDmZP3/GL7U82tofnxahGToW
lYAVro/nWSb7EMF3n64aiYFmzageYfSa1UL3MeEscePCli6xadtrCjobwhIvf4pk
e6bpirTCKnbtwoh3+lgon8iQRRfaKiSvNZjGuyLAgWfKQ8r15oT4km2tRHktA7aM
gdB1X+umdFHzwMccDTf7nZ8CXdDMfESy4XwxzPrUK3IvTjMyrUiuXsVuNcBKRfET
7lWY+H3mTG2DQUaUSzHlKWWTOYUe0VLgzLvOa6YOCy7KlM6mjD29YwARJX7PTPFp
MY2/pNZDrzU/15DgzLBK8DfVH9nyu6m6wjC0dWpf5+Qz4I3ahheQaaj7ClgRHR3D
SAMxhiIqdhW/HpjRvOuAZ2RYi021KIeY4IhUPuL/bBfSrpAL7BufG+P4HtCGzMvl
vT/5iRTigXpty8eFH66tpjfGj+eRFxeZqxfTmh7xvS0i9I37dBhr7VBoO6vOmx8l
Hxr6irn2kzKfprLUiMWyNpGnUEQ1mfGsyWlJzVnqsAoLbiCBkA0eef/KVpzD1jKf
NRhtdX+5JGocxFMUii6h2tYvtvkglnT8tltJLoeufoI=
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U5pyCpCih3fTqOtKKqJBETQdzB2MH4amLqki2myXEaFHCyVokyhHm0eBbtRKAKKA
BL3p7TmsZ1sn7Cj7a0eTbqNhIF7NlNHiOoLtPR7E3QDX07rd2Jzg5RLhzFaGmSHi
appjDDMAw1C1x27lobz5dY4UW3/BuFeDzsGXQqHiwTU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2767      )
K3bZBNxvwts2gqm/eDAEgUTwt3TUAaMAfgvS7hjwkqtRqmvQfQZ+Uep5GJaKyCxp
4S/A5stSXUZa2kLFGL2HyCUSi9dKpHkM0Ljh7WP0bDvwggPiwalh6vd4RFJrb9wW
sELtYZIrTVyq6LhGMgJnBKRGMxaAzG2/idgPVGOpYDrF8eYKGSaQ29DUkCFoIznS
NYzcXb/Jn+pyd+X3jFwN2Se0dh0L3QC1WGjB0oRyA7OtaDZy6S/kIfYNy6UxHdfP
gF+1vhaupHBBBSk82oHrQQ==
`pragma protect end_protected
  //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Rtp2i2OjDail95c/s+iPsC3TxN0ThDb5hdQACX00DNBdZFQ2eCWjpn/Xy8H6a3nm
iRYt/7HAttONlTYfadvLB1v3HIIIx3AJ7BF619jFSnsdkkVilfdvvK+He1eKhy7j
prqlT7dJli4tc89YG2ZTnYhE0sQt6hlR2MdDD9q7RpA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 59348     )
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RTVteV5ffyCttd8gjGTmpfGLHwCCwAGwYtTg9kNdzyImVW7FVIpfCdI82SxfC8Kt
CNtzCV/wKmUIukwHWkk39dCROV0BjQ9J03BbIImrMsT77/F9b4FL7jiYO0O/4hGS
65R/+cglEdvanI3t/Na+a51wuiKV8lpFZ++4uQoU1a8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 59556     )
sG84rTk4rD7cV6ZcLCLYNZoePetQbSEGeOiZ3BQiq6TKerdxpDWjOLu+CsDN9Ng5
UzIvAA0CQGMTg9GbO8rm39YYOrlyCpos8fwynFYAdECeHvE56oaTFOFjGYOZsIdV
pjKXc4IrOaCS9lSU2brYr42UqwBjqB/mvkErqncLIg2xwld6/1WKMNyRm9J00HB5
jpnb6RK516kQ1BHi2/eHycaUI5q1zGfyUdJSVr8yHMU6exNzO1jxWZH0U/RjsAbr
+rN6nU8w4bK/xxxm/lvWfh/YjDnoqWIS8MkSSyafYbM=
`pragma protect end_protected
   //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Su/EjA0LvJ5kPx3K44q1+knYcPS44FSsMGqOUNXMkg0YyJd2rzEVjEyHcaJU34dp
Y5P8oA+YHJLa9Ug9MgyzsR5mLk1hoi1qFQHgNvtY7pekW7CjQyYp8a+JMLkBVdFR
dQw7r/NaxXllPXldukqdanaNQLSyNojHBlQjrDKFhZ4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 61421     )
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ktqcKKamxmd+oDTYHwNnE8eAkCy0nUZmoQme4oT28h+f2/sPkJxd3KXORY64G+Bm
PkQl5rO2KEYMNQBhcBT2xGhOL0bdOfulIHmcmIyfXdOWvfZ/7TJJcWUssm2YGEUf
kmRPk1DHFooue1eDj2DA3/VQSJW5oDexPDa/da1E8bo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 61517     )
jMPJrabeNBMd2S7sCli4l3csdl6MxFfuHGn2Mo8ONaB1FoYMu8xUEgRfbPPorTch
vvQ/ON2kXThSGIsiNUbCFCn1NfXA58EnqdP3mekblP8/itoqtGU3MAD6qj6JgbC0
SjpdCkpH4a5SmbZUVg+MTg==
`pragma protect end_protected
  //vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oOk1jLwmVlHn5ZYIUATz0GpN5nWCNp49Sz52fuCR74V9k+74vl+63RVuPUjv2kla
4KBrs0w7Rn8ZOA14dXqAbD7ljqUlBITGLc55Du/438L+Y9Obzo6vvYVH8Sw5ZU1c
1207YvQ+0jGPs0kJCux/Y0LhMrkw4678SrrhzccbchI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 90219     )
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
`pragma protect end_protected
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_snoop_transaction) svt_axi_snoop_transaction_channel;
  `vmm_atomic_gen(svt_axi_snoop_transaction, "VMM (Atomic) Generator for svt_axi_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_snoop_transaction, "VMM (Scenario) Generator for svt_axi_snoop_transaction data objects")
`endif

`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F69+nbCISg8hb7G8EL+ddAkCnON1WD6h8H0hjgReXXV/Jlh1gQAsfzRwcDtgFl2w
7oUhyzoSlT44SAb/IRMb+N4c//JuT8ALynyNxAzKQ2VlFE4UCqhkpwXepJHb+Qyj
MgL2XzEv38rRBGK63vlYr/n7x6oSOV1Tlu/iiojarCI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 90302     )
YCKb4N9qQoA5GPqKlaIG9+Nhh+0ifVGgFydHo3WbY+2v2PWRNdC5YCIbUeNyUDbz
/n9eHYKdbd1LKvZevZusQuolojqEAS+xe8WZkf3K601mKmee1JeMGR7xYLK5ViZq
`pragma protect end_protected
