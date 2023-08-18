
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3wsHsuZGdZm2EGw3xhdanzPubGUUpjLZevL2AC8KeyqIDhIsIY+rTF2dI5/Da/dM
ZqlOTHdSxul4X1BhQ7CfDAj2C3OYiU6U4AM2X+X2ZPLF4RGxzCtEIqB86Zx9iTMk
3xNjp2Fo+H2VfROB+QHrqdpYK/LXjuANbcROq/U7mGzJ1BE8Bi3/0g==
//pragma protect end_key_block
//pragma protect digest_block
naq2pab0dVjnXFS4lHq2ZRfatGU=
//pragma protect end_digest_block
//pragma protect data_block
WjdNQEO/v8jtSqcMpVocYFAcT0s37whNbsaOV/Txx+syTLJ79yz7IkdO3TIG9TX0
FjCxazhxDhkxwG4u1ZZhC26SJXD8TvG+n1RWpPTSGadDI/Marfzf7PtBfffYihwV
IN8ohkrIbdRBTrw6HNLJj7n2ithZzvsudvuvNMQoPU1IwDQIzQQjiY5a9G/K1BUm
cMXAQ2ZejlZ0F06samGWyfmc2H57CiLJ1OKqz5+GQYyf1uLKv4eg0h6XrANxndU1
LJp/MRn4Q1PLedKLi7+q/xW5oZ0ZgtFEmtqAjXIwF99FRKletINTW35T1z6T4k/5
9vJRaCsRBsX2jlZ2oAIBPd3cq+ProSCnT2ufyQSq5TlyWYN2urjmpGnPnKdroe4c
A3W42RrOstrSWc0hVqszsI3DpHk7CSu+O8coQL/f0kwmOTruc0rMhk9ApACGhCnK
zpH9Ouef0LY6ObQBifY/DaaaxcDaiOByZnIVYebYPbKROJVZGDmMwMKFgUowTbWv
f2t8Jnrc47AIz1c3Po9S61Cr1ru85gpbDfQC87uyrJArUzIcrFMkPYcXh8ZuD3yx
KieyOl4cALy42KiSWXxAaZf/ddHhfwifpaILKqeNAj08y4YMRifsLm7vGi6eale+
PgROW81a1O3obPt04dVMrZEpUbXIzQOnZE2yQkJ41+XXhbZ+gichSc+WO2ip8cwJ
ytmNamwQBotEyDZto0YMuWd6F2z4AHQMKXF1lxpPOL6xbYbS/Wv9APBIzxwlzlNW
mS0AFLGL9rAdSYn2CFO+p6LlWoOLHVzeN0WVmKIhsKwMvXxJz4l9pj9SuBZhUzMN
Y95yzkZws5/jytgDHZPdczHjDl0moXUmTci20PI/iOxhH2HrEWOdDAIfp+hEqdNR
KT2jQYLibsMf3goTwZpkSpt9MpwHordwQvjcCpOFRyB3G54Oc4itX7PZT4zQm5GM
MwUxH87lhRaTgnBX8uhnXHzw5VX/xZicXXHobB7/veya8wsx+LxrWd+Jh+fOP8A6
iPShEuyiEvf7Lh83UAN1sa6SJGezMTdk0NrfxjcIfQgbXHJ95QENcHEZNwyEL3pF
Cql+VUAZlW5aKzA+w4YCwixzjL7faQzrnR7zDK5i8ZZ+c7gHGxRdwvwyMxWMogat
UTl7vuA51dllK4FZP/hgSL7GM7kXxigiLPE9jDYFX9/JkSFu/NkMAJwfxV/SK9ag
3U6BUbvh1P1ghSO9VIU5STV2WJC+it20lmfZvJf28FM=
//pragma protect end_data_block
//pragma protect digest_block
hW6H27lB7WkuyOfxRfzyOunBax4=
//pragma protect end_digest_block
//pragma protect end_protected

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
  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PGP46TSeLktb/I8NNxev4WN7/oUDJ3kit8UzJDZgESAKYvbZANFqeYYPrIgIhnHe
a+ZNnuEXaG7IabPyZmmSv4YiD36k95UF3+bWhfc1+M9a3INRYUrOOYLyaFxKSicZ
QzSbIuOpqt0gxJhRWlL316+TISKqioH64LVzzt/M4+bLUPi/YSKodA==
//pragma protect end_key_block
//pragma protect digest_block
uzA1SAuP8S6nN6NeWcl9zixyk9w=
//pragma protect end_digest_block
//pragma protect data_block
vpExsMDXyr8BRPO8e7aJrOSuFUJNJoTI6O0b6dFiuOUwuo2Psdn4I9eQyjR1yoCJ
a6ojZJZ6sRKCqKWrdv73FDobkQ8pxM9F5mPuXf6Yp+r5l+ZzL9W/mNDqnvktCuoP
HU4F0RBqN3mYJNBKMxI+nfuWB89sXAuU8z1KFZOeQhkaxYP0LBPRjYyuzWs1tE7q
HlYIbfs+pRgK7ipWg4DiNVLXeg5dJTGvAS9EfUqwkLKwkOe9Mvldlabo0cdQTtSV
UDauXYhDZcK1zGS19BiyohNqQWCFbv5nHzFck1e5BCxr0ObEXoZcmqrW8wk+XDF4
KF5GBPAyVmPUJdZh+sl5rWzyPremA1LPL5AEnxPaoSRvuVO7FXYIlu0tJNDuEPpu
LxYqsN4cyhu+ByF7Hwfkuw==
//pragma protect end_data_block
//pragma protect digest_block
jRGFqusmb8eqLBo4CuosYUFX8kc=
//pragma protect end_digest_block
//pragma protect end_protected
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


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8mAK/wRqRiSrPubE494HC4VHxYqtL61VzrbS7FKsTpHxMl9UHZpklWbMnzL2TMir
i7qwskVKk/0NSNbOfkmAnbKYlQ6DRjzDWA29Yt0Vbf4hHLh6fusetrgfbsjeilQP
4xUrbqbM5oCDXG4S7eILQgwbfWmPlatbsZ6bdHBIS78UpLNIJX9kkA==
//pragma protect end_key_block
//pragma protect digest_block
eb7cfixPSFTY2CS8qmq9TClOh8U=
//pragma protect end_digest_block
//pragma protect data_block
A1ltkqkK+sRHg8TO7zd9GyKwdorSWkNtAF0tAu2WCEp6E1PAm12wslN/zR6Xbi4F
4FxNEi1cyX9fvFnsJwZIproS5vrjy9kX3uf6DWS2f2IQ5+c2Uf/Cr+CFqUr43jf6
hrzx8f9aCzgJ7i7v8kjLzfymkwaolzjQ055bVqef0PuglHlwJYfBaXtjN1YG7nba
PmwQgvtGbLfG6nU32aFHzcsybTx5cPu1u6Tqhqmshr6pDzyQN3cdiMePkN+pCc+R
kvOhoFUg5wKi2gYLJN2NVaBgZ0QIfz2tu5I+ISOHTPGi+LqpwxzdJ01Hr+CfOVdK
HMmrhyHFnCiQtIAqChpMnzsXaaDKwXPtgmiruw5/Czgy7hfD1VWrkW4a3c3JUqwN
UbLoQRRBBhkxxUPVILdelINoXtHxoMnW5T6wXfpGul76yNVkPe+CQwgqqpzToxgm
p7SJRuDRxD03jEZZpbDGsoXkENaD4IaovGJzqLXr7ErYVZPuZa9f39hGa3RwyL8D
iR57kYg/VROedtAmiYnJcjKwyiki6gVn4YVPyapAGG2yGlr670MvfJA1Zd+Nd5gk
fIl1ceUkgFSYQAE/8Vk5gcr1cVABgUarCYeQicuywR2r1r7kTCn1AT3Kh/NwfsCV
ZWOrbfiR1uAfUjZOvUzhe0i9St5gySj9eYLikKD3jF8YH849e7WG1Uf6Et9/Gw1j
P3k2f1n9rNS8dS1h5fFTO5PJpgcjwefXdqkU8+KJDUqnx7hMn+EZVZpmPJJKOYOK
jZbzfF7W7/nhkFy2e2D3miDugnjWzQxgoPqbPH0nInuqpW2ywORRHfA//0gRZjGp
xN7M9j0VkddCysKxh46MC07j1mRATjgzY5Q93gyB5Cd9pxkIQaQSWKKl4lEz2hod
WBBd4NU8RbO/69pe+VAwKEV+xBDGd8CtPVEj+NcydweSeti/yo0HBrlalKxzCCd5
S5KHCvBjavZQR86A/MtHbtWBgzcJSqTriYEOt2viqLZwrJS489se3TUkfS8nGsud
gshch4GLIF52mYvEnRfg+AdZR3qXljkob8EZ0wM0H+UJEFZyv7tol5dgurcDk9A1
JxPqqCzufOlMmzFdxbN82M+Lp3D8/HuDEiZ+pbFJ1U/CNfRnQfuwLt5ZiVj/40a9
SvuBYHkiZObluPeiOKca9opisn+SBmYK6Plg9xETUjG+xlp0eTZERUPbp1nTgkH6
DinC4GZSv+Bd58R6sJ/3K6YsBsQe61FvM1JCWyrQ/7Pg27pOJba6BljSQ0UOPHNd
5N1gtoG6Q334r7XuptclPE6jJ061vY/uegTwzpKr/jtreMI3AkVQORh1tRXaqUs/
RhKO4LQw06LRdEW9UeTGD4/1R7INN/lFUVSCunhcGrHA4eeFg/9BIqxyGfb2of3r
OZv17kcf0ARg5/z7mhfzs+j1Q0723IUaDlJWMrQlbi/V4TjGgUwjdbm4Rn+oM/V0
NuxAfNZ4cv1oEN0SJOYtihkUqBIJgYUykXhytVyZBZN7WuxG44ZtBABWjk0B3NQB

//pragma protect end_data_block
//pragma protect digest_block
C49cB8AO1jqIB/MzU0wWNa4MxqE=
//pragma protect end_digest_block
//pragma protect end_protected
  
  //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IQuSMZyQNvgGAFafhJY3BkXsFSmvD54QeVkUtevG6CqnosvSth/VfT6GviuluUEv
0n661QCRnJ4cvl0vM0eb+0xQrNhDl4E9566I9ej//cKs+jRXYjJsS6N1FR2+1zoD
KlmSgwWjhDOBKXLe7fNr7H5rzudYshmXNghF3HLzBQlZh1tkLCuGfA==
//pragma protect end_key_block
//pragma protect digest_block
iWqN7iGMrVS5fEQ2NOOXHOQfie0=
//pragma protect end_digest_block
//pragma protect data_block
BoPHv/5MBCTO3idh9mLQ87MxDcBxEI8mKtabHqIEs3eMUjO7ETuxuc+fdjEjo6So
jx9LuTUlu66aXGHNC4+zUl1aklEPoI1ROSYD3PAcsDWj3TlpnV25bjSXzCb9+Y2G
rOLqndf1chfq56zDgm8Cdp6GGPxJIosTkB1QUUJDIcd9kPpVmddrd0sUm4mO9xuo
NZkaH4rvOyjG3ThXSuCvGM3wTX1/6u6tGGyzEloci4lrt54skehMNOSzowaSCK/n
TkgrDj0NVruVar7oFwja1gKvjw4NnWIpSW/tcC5OvQQUryDOi2MgZtwlFRm6HsKw
P5/sEmnzEVP9qmnom8C+Nb6JnfOYpt5Dn6IQrouD0nLeM6nR4n0o9iiZfpXF0kc5
+cdQ3SzjH6MRUZpDXeY8SfgM3jpAYdtEK2uMnFMCcVNG9gsVJ7TrthT5Gh7NE32u
6s6PoLPML3uhn1h4lBIudH436k4EpfEugxiMa2ozacDA6g2cVfy3hhUDYt0xr4mD
usgBzkODsP63P00N4xIq0EduOpKaluVJbNKATCXSVcuS6xjmtKWs6hUG7tckPZhS
N6CGYTABUIpFa4WkRkQqoRjhpB8bCee3acvFFE3ZELgj4LQ+rt4NwtzFaeqqZ1M8
8YEdLXhp+qn3EC/nrgOZDj60Arws/5pcvNrQ6CWdK6nSDPK2SuWjZGYyOqNJ4r9n
4Xb/38oiam1VHGOf0Imfd40uHBK3mwNzjOsWZpqR2+VzJ3Day9ovr97J+lq29+7c
7a9bILFdLI70NODKLwMoMcn38LNtgYBghvKOtUZTlJxrbxcdHJ0vx6x9qWcYr4Ek
pAQqV+64pMmz1dXsRytAJUakBIfJQS18oc9QcvHjT0DrI4s1EFFPebOVkD+iHolJ
iNOTzoBDzwu8yjGCwzK9EYz4JOS1jEnleF+5UeOkZdwHW0nk4yFnfWrw4+ObR9xI
ULEqkNN0r3wXXVV1CoIS1pd7jAqgOcHD1i2ic7sbDTwMUmuWosxTRq6CjtiP1KMq
Wol6ArYhblF5hC36LqXQuhkXsKW+aLnq9GbHyEIRGXgX1MT+p9KzMW6n7kwxyobc
Xh7Cp9ysUSPdWQ1ZHE1z+qN1INBkt2tmJ39Kzjk4fvUf9vL2jRTTxSCq+8ZmzqHG

//pragma protect end_data_block
//pragma protect digest_block
I2T0uXzlFgfW6yj6H6Giwq384BA=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7RKM9pbxFDiTiFto27FOoXB1n/DZYBXe6JzV4+k1T5Rp59ZjR16krbkJf091HRnZ
BCFAS0dlOWCFfKZvutVjcY8Cq4tz2RNTgYs8eWbU/hAp+GWrVdZ9dL03N9rm/PQG
VmQgiEo0YoSG1097d7hapLWD1XWw9DlMVnbRU8p6aMEPULvuJ54RBQ==
//pragma protect end_key_block
//pragma protect digest_block
0gVzdODb3d4XqnlwK+ovupxZS48=
//pragma protect end_digest_block
//pragma protect data_block
UX10hqtpl2TnLCvZIpBdGuWHWI58nEi4Cssz4ToNHh/QKeyxhv02zMOjkzwM62xL
ueIydrUiWNFjhwpLFvZE3vSzOPlv5oBcUgRxOz4DT6Jik9wH8FmNHeriYFZd3kN4
6PEGJkr0hPgcBDDFUNI0+tJOVwvm8kd5SgCXJ/l4VUcn4Gu/fcY709a9DtLZGVWC
QSMLD9wylBBLe4R8OxXDwQkSECP8i8dTlXbJLamUae5sJNI5JvUF4Re55rdcRJaf
Vr2fi56p9nV7KVSz4EEqgcRMiYI+eeVwHrKPWZl0iNeG8zsgj+QKBsQSPbeYRPwf
dxlhoei5IMuwB717FIdsANJfrIlVTdf4muGoTfE3C38P3u8sqjVUUx04Ct9kpsvE
AtoULJrweCXT8d9eQ4F530tD75BrZ2ttwOkS0M2AIStlrsoSlxDDWuAchmdUZZNy
gXXs6tNHgR9mwvHgtfviZ08EaKah8xcu2bA+LMTmhAY=
//pragma protect end_data_block
//pragma protect digest_block
CmiVCbdZpnKS2ud3ZXT5UrCTsgY=
//pragma protect end_digest_block
//pragma protect end_protected
  //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MNPhSDfnaA8rCDKOqDJrLIhnigSLa5ljFzS9P9H7GkeSaZcmIZJaHsY2aVUyrgVd
382VNrBdFuo5qj86pgDtv6Kqom1GLbnkCVQHLyQvX+GHzLQwuJJGUxtNuqeQIy0k
WdDTT5fcsNUg0YoNozH9BmF9q3GGsBgD1pT8IDHMlAeIwhi8r+Nszg==
//pragma protect end_key_block
//pragma protect digest_block
uSbaptOd9R5rvcVWf5oq2J5ApXk=
//pragma protect end_digest_block
//pragma protect data_block
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
jP+6iVzpG+HFQWfZOKaTHg==
//pragma protect end_data_block
//pragma protect digest_block
DJ6UtVRQFVG1CNFbzKIznZHAM4s=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
y7/2DVhqNajJ1qN0jxPh1tho/4Cigt4dMAO4QeEhCvLhKSdqzGSG30+W8qMC0BbD
3odHUcjtXtyPxOtgl9+/1alXphM6+dH/l19drCcOvFV1shXab6W+yyA8AzkfssoJ
UDh1YCeez7mYwJQMMZ/q9XYvVcPRW8glAoguS6WvxqlDama2cMGMFA==
//pragma protect end_key_block
//pragma protect digest_block
qny+lzva20yrbdadpN9Kee7PYFY=
//pragma protect end_digest_block
//pragma protect data_block
XU5vPSjSTiEqPAJzn/4c64B85d5Cquap5hxCizG2GtwwJgzI91Dq1EtIo0zxEd8T
59Z7+nT3zxUY4E7S3yeOySXeTy39CMk6CMp8yO/Jzi0VEQAfoz3bIL8M50jmdyAv
sy3PI6ZhrfDOh36EWDWt/Qm6n5SbFwGfarzQVoiegPgp6qv29PyyjrNoyk8bSrXi
TXmIWRuPus4FW7iuwGj8JERg+yFzJa+LS1DcVM+i/d09IxqqNNF0gEWaN7/V2seI
sP9PQcpuvUJYseYuoIFgzNYB3Fh9QxoV1+4XGwiq/PQYpjARPOMcw+LbseWHGfCr
0C9VwLLYPBkX3xbF7Uaz+2mcmL3+VaAY2XlOunpOkIth0thPqFsM2wrAH9cwiM+f
XBy6p3T7L73tfGvn/sNY0GZoGFK8JtV6VjNnz9L7TmwdpVHhSGHAjvrEFFxpCLh+
65L9NGomKu3hDDYY0v460Q4UY/alYKh3Myix2aYe4XjwrDjIjHEZxtM4BtZWQ1hd

//pragma protect end_data_block
//pragma protect digest_block
K72XoOxMfIoAjz9TVeT0y+CxH30=
//pragma protect end_digest_block
//pragma protect end_protected
   //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kjrmo6OrNhWEhe5NZTW4QP33E9yPkrpxFv6tz0J142nOl0UhftzMfRoaTLAsWX/1
v1lnqEZvGfa/YYceFMTyt1qyfQi2AobhQ6mwiZzBl9XJizZ6MFhM4vRqMJtBthQd
18C72VXO0TvNEozq8xwAbcp6ppyvGJryMdWKVrFAzdHPyL1yNkn3zg==
//pragma protect end_key_block
//pragma protect digest_block
XidQIkeUHAb6/VbTwys/4gFhNFI=
//pragma protect end_digest_block
//pragma protect data_block
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
Gqc8vnRVvdyZE2zBdJi4/Q==
//pragma protect end_data_block
//pragma protect digest_block
+mWBLupv/3BmmW3SppzmGl6MDDw=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BX3nEwm+MLRyaWn6YJviClk+9ENCUyC1P2FqfeHVGSEN1Fstz804G1lUd5wapkgX
WmQ8+rQEv3vWPKsh+dx3BNoVDtLxmamp0Oza/mQ8Vn3gR+eOw/XOCpoy909ZGbdg
vCmkpQCT+ngpftOFCsamjGnLqQz7DVDQsnFLa9j9kvoNxKLh9dUwQg==
//pragma protect end_key_block
//pragma protect digest_block
MDPoC14N1ubgKOzN1SZ8qNdzp1U=
//pragma protect end_digest_block
//pragma protect data_block
OZaQJo66uvV+xB7ezxxep3SoXrLykjZq72gh9oRAClKJzbI6D88IVPa77oXVBeNI
Cc4bR8qXaUA+ovg/FfKh2ZqvsjYa73LeNTRNAy3F5+Q8qJwcoQoNoSP9Ns4q0r5u
sb/0Ug93psLTTyfdNSEguMm1S6hrrlEMGzmdDGPQscD0wUInUjOSgAFC/gaSTJOK
jUD83Mkg96GsYeymw0r7yUslJgq4WvTCHFh2YTgk0PWpaBOnB2FmKZ1pd1rqaT+6
SEBe2PxNxM23r+A2OPeQUh87TiXyn2wbpEgkLFDkcaerJJNaNhdSK7yxlBVMF58g
AO0v5yXi8qfxOW86fUXIsDHhrYktDbHx8J6IMgq0TMw=
//pragma protect end_data_block
//pragma protect digest_block
eR4eL7xksltiGTr2kwbP7PW8swg=
//pragma protect end_digest_block
//pragma protect end_protected
  //vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ktSUmwO0hfizO9cEHbu1B878+gESjZsEYjBw8kIf4HARkYeE1u9/GlTCy8oxvFhG
+vHil5JLgoCKKz5QtrRm5DL10dvVeZTfTVBzli81gErCriNFOJtPo12wjmFuVqd8
ePzJ5kIY93ifcD/y5C9OstyjYI5r8s8vTmSjuynH3e+dTGZSFhxy9A==
//pragma protect end_key_block
//pragma protect digest_block
dBdTufPFeRQspmo8YTpx0lPCubo=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
8TRL/1a5kHy9dlt06nLL0EsdYc8=
//pragma protect end_digest_block
//pragma protect end_protected
`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_snoop_transaction) svt_axi_snoop_transaction_channel;
  `vmm_atomic_gen(svt_axi_snoop_transaction, "VMM (Atomic) Generator for svt_axi_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_snoop_transaction, "VMM (Scenario) Generator for svt_axi_snoop_transaction data objects")
`endif

`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_SV
