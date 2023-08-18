
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
`protected
:-28RcFV0?4.H-JUU;UD)PPHG^@J]4[DCI8eP:-4Mb6=ACRK4U)H-(+F5,=3GGeZ
8]6KWZ21HHGaQJ&[(UcdV.A1I4:QOg+=W3X1dSg3O+/#MOc.D4e6OI9N//=.d^^)
Z@1,Dab^TZ6(K8OC<0bad<BW<AGU5.X)287IS?#@SVJfIN;(=3R?<#2.=A50O/1V
W?4?_+TbMHbU;?.IQb;U>8Z6T4&NH=8V6Tc#>]ed0>OB2Dg-NDUg2LCF8#e3:b-E
1XD?C[#^(O2@CaIdGXDfT&U#C@/D+<L]bG7<;__//K+1G>YTF3fKE90E,c_.NedL
SNAB^&>GISWeMUQAHY/+PKgS7D^eb?BWWbZ\.D@=+NTT#27\gba\[DBc3fC_Q#<@
N0Od;_OL1U9+>FD)+GMK;\J07,V@[g4SC@N_G-N=]^&IVeH3ZH:a1->dY6OBV?6V
V;0/@T\:N[)/32B1M6G\4O/@f^XRMNd5=dV<98bOL_I.6ZMOcg:T>H.B>VCD>EBK
=>LY0S81eaS=).0<7:5.[_CfYCga^CU,-;A8GP/9>+LbD>5-X+G?F9a[_3QbBY?d
G-Jf&gde81Y=E(B+MdWcIff-]V/_e[J(aW9-@>43Pg77#:cM?(C^,O2]]4>Cef(F
1Q\8(5U#\dGc/GL]2?9,C^M.@MTaC_:Db),E^Bdb]@GBE42BBc7UU^I3f?c7#(bd
R;_4OW[PC,Cd2W^AVWI,]8SA\<ZLI_,X_(dE<NM5JbI_5gWJJHR,]LV,&&bS1(<d
2Y#URHJ;K[<8[R]IN;2bHg&2S;BA^=0OZDV(WNB&-431TAP01F65URL&B)H]19M+
&JCfb(?)CA=f#0ZZCTJ,J0;g;_;<H+7Zc@_,^380_SSUW;JfLB>28,3@7<)2@+MU
A&+dbQ<&cS7)237YgG2FLQ#73@6X797MaXY=(WW2a=RAEE0.B^R(LgS;:@55[6.Z
K:^M)I7EbZ@fU3(^aZ)4<P#75$
`endprotected


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
  
  `protected
/N^AGV/8SDT4YaZ97-T9PP#cKD4#f@Jb.^N8dg-5YYCRT]ZTcO@J2)B7I>FcFO.[
7R+9gdO&G&34.$
`endprotected

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


 `protected
EN0OWg8Z.&R/_LW3EYH7YXD[2W<;N4BT7CW2,>?8e1B-->U.MD,14)30YaeOb0U+
Z:-YBO;bdYIS4)-<^9I+\?_\T&g=1AbdcE(2Fd1_\F\Y?DSS<+VWa7_5b6S63U>b
2(4[0X-II)YGMH>W<:g7I>dT@5-8g/XQ]&1N_Z3f;_1M:D=7]^7AGSeb(A4.[^6?
g-YK?&+RgQ@2<g0M,0D3N88T]=6/LMgCb6&IQRV<+(#(@LJ??01/.CGEW/#N(&;J
a[JR)?LPJKXF:[beA[RcUP&7U\Q>[I8\XF?CZ7eLPc@S6=]V:KI68\SDcB^cOYT,
_c_OM=I3(1M[;OO99cTG;f>@M,-eFH3VA0(DTJ#^K@?#_/^C@+MPA>_b?@^C<IWV
&6O0aN#2Q8e^8>(74dH5CQdE=XR)[40.GK],;QPVdXa)]?C-9M#bPF7OXAC@[[HG
++17f7W.JCW\PC:OFXV&PT,?0bL3-bBDMf#3KK.g1S?6N/<0;-@RH?,9/X76eXE=
99^?_5_S7EMW2I,=Qg:fS06QB2-dB6#I2FHea5<,W>UH9Gc8-?.9cE\A,2(aI(7^
:33+(YEHT.Qe45;L,G<&?Q>ZeL_R)5RF--b:DPYb>7U\HX_KL1.9[c>ZLG>fZ=,=
f/CP;F:^[&Y.&>=PR4AY[e5R3FO?P#&MHecdD/)/\/5Ce]D;;40<^G2=:aZfG=CL
32g?fc<0EP2QSNAAfG;#J)fQaGO&;Y(aQg.5?KdMSc;7.WA+[S8LBNR.V_(@UWC#
?\Jf]?(N5_6SF5<\Db78.?7K;>-E[D<C0_X2Z\<9#8K]>&33:(\1-X>[?XRdHT>K
HeTHBM@=[+MUGfK>-47TW;@&MV(3TE<O03f8CE?:<IK+1+8Z+Q]KVAH(.g#/g+H,
Pf0]QZ4#W:.4L:BAN9U(@&BND]2/5b:<9CaGBZ)TeZ2,H+8/3)T&ZF;KYIOK)PP7
4OCG;75d+^=4)$
`endprotected

  
  //vcs_vip_protect
  `protected
dQUOQP5E+X?GB->^F=GV=.N)8X6P+1d[P8]Xg_eEfa;H?>Y<?@OL.(0^J=D=_+Ic
ZLbM8McaCV_:@a+]:?9#_??E:I&MM&\;F3>BDNVJ#SDJ<Y00=?C3/JNKG](N.3Re
^=L)8R2bR3FUc8YM\Z:3P:IDMQV,V_1Sf9eSD9P@0Y>8E<&e)cDU1J0S\?TV+McY
,/f.+WNeAfQQ6.Z7Te:@7cFX6X,7W29;dIVHGKWB2gMbbH,c&VdD[5B5A\&dO9<b
/g;D8A?&GM6^c;FM[2)#C5DL>AOCKL1T.F@3;1DPTA:3\Z0G7=J8]=MKT6)d/N09
-I;MTM#a9_FfafH+NfZ.2#dB?:egP]f5+LL1CS&MKM6cM#?./>=L9_DONa:bRg5a
[3+c)8Z0A#^-EQ8G(3,d>@cNJdQ_&6g>/0.N)N9dS;>_#>,d_.#T5/b\^D85BE-D
gKWT@Z:>ee_)-eD=W#IQag5bN[P)eXA6UG\>P_E,J,B5a0N>>fZL:GX>08.P5)1D
EK+^N53BG2RPI;NUe=7NUD;S31Y>\1OOSR?P[e^ZV0EASg2P=VDIK?RH[E/CXMTZ
M_L0+0@/GLRO/.3O2TR1EcG6I4X=a?<M/[6aPOU&+RWXd5ARXe7EN7Ke;_(g\,gT
?ZcW1bVPe6V?9/?-6G@b,RfB&]X&.GOUe?\B]7dWeQIc^RG6FbN\f1YY0M/Z]IN^
RO-5N7\U@C2&WbN62:@D3\48c_/]bL#e.;@cd\E]^61QYeeVd1[8<8LaXAJB17V@
]:MgH4,6:4DEJ6aQ10=P45NMC971^5;c3)I_\FA+eS,PgBTMN:4#B=eNc42-)0VW
#KgJ+OK=,Vca9LBcHSL.aG78YeUVbcX7WU+<9B[H]9\=AJYL(SZA2feNN$
`endprotected

  `protected
B>Y:cA7)YLea=6H_LRBXDJQ_.)RaNH1(>>FCASId[MB24KEO^#gW+)cU/JM.d8.X
+SZ8\cY<19edT>3)[.-,DRQ_1$
`endprotected

  //vcs_vip_protect
  `protected
S(//FN@e=AI(CCPH8>6.WJb<a.T)=<?cg(_H6/0O/^?YO>[H=DBI&(Pb?8e/a<F&
))TNDG(ZW7bB?NG6Jbd?[LU/\aC2IPWW[JZ[N2@36H7.fe8<.?SY;cac(C(\_bM8
5bbQO6=c;-#JP+?:Ye4HO1_YL.,GME/^1(M,[K[#,=8KKG5EFNEXfId7KEQ<+O0P
T9ebZ1U6[:+4/)cNga8,MZSK?_4E+,6B#O]L5ZACHQ0S,QH4SDUeUGRP=TC-=@_.
=DI.AFD6JaG#aS3/@.8;9K+]:,91[J670]1V<_._WK;>5C)bCIRA^aU0XE5_=?F+
K<eR3<bL(3H^g6P4G[-(?gA=8.e6131cR3KaVA),g#5@M,LU>]bI_2B61;0S@MX8
;M^FIVO-&SGeTWg2BWOK+HW(cKG-<Q&4B7[YENT,^5)L?/e.fd[A4KL&f_30-)ge
AbAb6<-]R2L0gV^U4<^cP)140]?NT>-EL5MTB(9[8==CfcF;fSAeX]9T>5#gTI5R
dL]^[6H]9Z00+@:XH5@LgSXU]GGMaTO(Ja@G]FPcc-((K0]UQQDgg=,;P&J,bDCU
]Md8A](@OgEBe8G?7a?D4EPT8IE44:(fV[W\P<UP66/B2SDMUNDDf:Vb)V16/Q=-
GX?ZY3KEaNK==N](^??BZ;-;>JL>S=&a\Tf(@]FV7HJ<<Kc6:;WTBcRJLJNU_;bb
Y->X21fW)PLf-P>^:1cTY^c]+\_gb0bC8.BDHAPT4W>7XNJ#YaWOL6@\S@fB?3<F
g1](;]aQP#XCBHG&7bdG@cgBTVe^1?-CNV/KVXVR[^E&O-WGHLHW^cQc@;-DY@(Q
.TZ^KgDD/KLG-a7Ib0_CFd.)5O#GXRKNa=&&)CN7&F=B[2NbT6BV_]@6e_J&^D@Z
=94/IJe472=XDP8W8,gV@4L-E=g[E[@=@3F>]-)ZCVK2T-&4_N/U0&=L@#DGCTJ+
AU>GHaR1),_AMVS4E+<5eaRX8ID.#0)M_KJR8fO.HLI<3I<Z),_2DUCc1C0>ASP@
[FFGe3fa&B-M/5cSVU\=I?<P.aaSRc0RTH]S67IZV#WTD8X<T\Zb1)_3Nc9M0PQK
,:fRW>Mb-5VgXWKJ@)[1cAb4fLG.e=9:#YQGYXPaB4fMB-V@e&N@+&U1H83ECRG_
F.J<MY^[9V_Ya]9O4DY2@69,bF9McEa9\=1Za^>.:_ME6\Q_\:DR9Xb05cN=_C?+
EN7&\N:\R6bC7?PM]cdd#,7+7<C;Vc[dKb&?5WLD8X(0g\A83++@HFF283BR\49c
ROBLTN1DN)RD:3CLLQR:.+L(@(>>?LQbaLeYQ]W51E4BL),P9e..9#0C4=?2Tf4T
^2N.,^@:D6(.Nbe8UG7J/OAB6cULNE@TM7d<19]KfN?PJ7JVIeO<J8<79:>CEgfg
WeQ/[?Y(63CI7W[-973)RSc_e&_Y[9:aAAZ5\+a3+P^2_)I;]:U)a6f6KT:e&+-S
bEbUa&F3_,[ef+HOY<Ca.?+G-FLP50NF@K7/72Z,Yg8:2dDW4e[94)H5aO5[g1;L
1X@FZ_)CSQ8A8ReIHA]3\.gN#MY9562S)L-QB8:PMTZ0Wb3Q\VS^c?SfB0Ua679-
NWS.C85=O)LWA5H0G3;fX=6X#L,YLKF\5b:O>03;^cg)P:W#AP<E2XC+6N9G^LJ[
CP9)SXS>18YC;6cI,[,M7C5Y;VVYV6OE1gfZ<gFH+PaHNRRQCV)_=Q9T,Ie.@4NJ
FXH2:3\?)#54)UcI4c/JcT&>&g3)#FHH[g@V>(4FURMLTZNW4^=1LDa#568ac\b<
\>gXJ+;S]GN17I9_C2ZIX\&780H1MBaVG2\:PCX,/T&(.&^K0&VBf,8)13JBYd/W
f^:E5NGR0>Yaaa7?&X72B5[Y:PYa28,#d_]#[[5&;QK73H&LZT&\@03@NO5#95&\
Y<>\K:0YZM@4aZ_09=Y_TV&D+/LVTK0aU,,/5LH//^E)PW6=W2[Z.(W?aCBOXR]V
PC:g4T5[5g)1Jf9-ZJ\]dY[@?ZZC9,acfGXPIafMAebRG-X+M#>OITZ<DTc@VXcT
C(TAFM.e/8>+D9fH>e6[b/(TX.MY\8N_Le\/)X@NA/G91Q8<e(V.XRDLT&P]R,^+
.S7-7Mc(8FT7@.<G9EP)A<b<N;-_8Nc@&4[=aELBKb^4YPabO./<BgRG=_QSV?S)
fMRHSGMGE34Sc8.15eHNHRF:Oc:]F&FUAFgG^\Q4^0A5\RP9PPBB]e[3OVEZQd;e
5:7-T;J2Y@H8c/S2H(/3>/5JJb#A&]g]D2=]2b,&MH+24:\Pg4#@D&>8a[Z&;OV/
2^HMG,e^6Z[=W9[b,/+8?(S,#,[a.4LJY6LCB=dF6S/YEUG[eE_-Jbfa8(5]Y>HL
JGH2UOIY:MUdJX3>CQ@/P6X0,.>ZY\cM&X0F@9AZ=R/b[>P>6F>\E?cD^2T;56Db
K4LOL)g&723a-ZP8VP-_\=\YX\KF-OZO]UaeQ9/0+^LA?6eZZJdT.PV>FAFfNVK,
_W1EMc?^[aL-fX-C.I2754fb#(,;f_G2,b?dg;<8R/Y0PR1Y#2PXVYDZ_VTL2G/B
0(P8M2)SaXCRPUZ.I3YG+KE;68E\-RI=M;/&CIbX>+?=8M3La(6\W3.\HFH+69@/
gTE_7VK#WYYWdAObRY&_T)AcOa)=FJbXfY1g^VF8NQAZJV&D=SKQW;X.dEc?&=L0
G3N(dRW[G9:7D1_4:@HX>AOVbLe1WWDM]RaKI_T(,]5GY:,V#]-b8LfWNTH[<B7b
aU03YS#GR]#7ff</5M\dYKGL^LgWV?88-61==OK#UBX28VG,I:2KgKb10PR&aME0
1P0XG)BI-E-@PZY:;SAS:Z2bW1@TK/9C8FcfAa\TPYZL>E3U_7@>/6=<B^UK,BaC
;46V>XL]&a;T029G:LdP,34MP]U65f<)G/#^D_T+&C\feO^dG-E?[85LJ8(@C\e6
)A@@?.X3CEY4P/@^;H=Q?>:S^K,<]6/?_B3aI&1>Q0#_d:PWCSD=6XUX]R;5-+@;
aSX^\/e[f:JK[[]80Hd-b<8O;eP:?[>eQ^E]KIM?e9PTX@[0KW;aY->K;TC0,3R6
/IBc<CfeEBXOTJH7FWEe/ASLEP=a)b6T52.\L/M[T9V>=gK1?aYX4V+907+F8.>b
9./?d;e;:0@2I0=I1PfgDDUGUJ+6g8+g4I<=c<INKDIJ2SY#-WUKbS0#V+MT;-&0
<c@)8;9HIRMfJ).[UD7584\XELP;c=DQ/+/e^UT3a8T)2)GS?X2P(e+1C_T?Y_2^
CU@H5(GNY@CXeM[4#_N.T^:ZV#&16(K0IURLCVX0.+^a.0QXZ/GVC9M;;7WF2(94
RP+/F5?Q9AH\F1=V9+T3c(2C..N(U7Y0:[;KI-\X)C-QK(?/+(X32Ne(J@(dFJP_
?1fDcT?CB87C<gL=?I;8.R16@TT_AB)@ZMC7<(9.G8B#:<PN&e;^Ha?]&WXgJC]@
dB2faHA>Xcg0<a^6Q9g.O=[]d<X?2A4.^J2S_P=[&0D,(/RaB(F?;TM^;\\X3gKG
.604AH@ZaZe^S;Cb_+TY>aGbMM?6@);KY:PC92?Z[d\1S]L]N6LH#L?38R4&N@45
KLe;1a=##Q\4FU]4YdW\2\Z8,84D?_N-7,LEc@eWAZ^DSf&[b?D?6OR7C<H0:6XR
#PK::1R95AN@EHN.4HYP+dB.^AE7_-0^:g([/]PE5.H@M1e=OD9YAX9CJ1S6P_UZ
88,#ZL9VeM6I11B,\D39S8AT;gQb/E2fU?<8&-9DI:@O3S+C]/V:Q@VR:OOUG/TR
AU>.=>Y<b\bC/D,3CYT<J2+RaQ3&eWQC.R;Tg=fgJ;FYV3^LS&e8GVB:TCAS6)R(
:,,:E[A8[YGLD<KAJ[^<B\c2^gW4B@D<^<0T&G67f:5b+0AE,\XH]W_fQbX.G9LU
-^[[;X++PUXF4>&3P5U.+N7b:=HDN;[#;dBL0RgYR,gR]g&>71ZF@XWZ>0()TW9,
=d\?fc&,>D.(C4Id<D(Q>+Q@&(@@EbU(J(H0)_SX>O3C>2EQAF2a49LHNFQ(@.eV
@](G.NcN;7:;EO<I\,)2>:W<cDIV-C7#SFKX+8-E4LV<fL9K&1O&PH+Q_OU7/NA(
;6e4/>g0<dfE,MgK:)/JO1P^cC+f0]\4>^_^>M?Ub8/aB3dF8ZNfFQ(b,,&VCbJf
>FZ1UW>\KRRU7J68Hf^>.P,[4=b=A#>aJTDZW8&^D9gEg=WW\(<#bTUQ?TVcd[_@
AD1^+HdgSa&/.Ne7_C[>DI96EI:FSUGg#4(HT;KE2KV44Q(D?gRPNW5]&9(#_^<d
F0eX]gKD<Bea;^18d\1KJ=AWU/#<f?1.f?A5/(SJZ,17YQHS:<0;\H<7VGb183?:
Ua6Hg5cO129R7-FbJc,@-84,SM4;5O[[CgQOY;WHO/_MI2B_CBZR(B>1V)_c[JWB
XQ?/Y2X-7R4.-8X0O5BD6<9[+PXI14(0IVQa;?T\eWX8&CeS6EF3B4\Q4TM0EB^d
aWKb39\3[@55If+(@gX[+]+U<D0)5Z\?;,Q63dSCA77M[Ka/L@9#YFN#M5UW/L;g
?@7<M,[_WX,9B[^^4G\R<#TZC(&H5<T07V#d>IUGF5HV-1?1H\0)I8K-J/7)V2WS
a72ABY)8VJBC^7VbM/O3[C;33<VC_J92W\UYbAXMTO2B_91[YX,\]K#M2B/\dI+4
,+7MP6-T4c&AZf^^C1e^AP6T4TB_[V8U]..7/F7Q/aK.UO.MWR?Y4)GYeeZ&VH7+
4<dKH9\P>PRBf^d0/PRR/&/<_(\AITbV=_3XPR/./gK+R5IgBGE#P5PJOCA7=^7B
JE72Q+P?EL6^@_5gdMU:TLbe;(0PV]J9Hc27\[6^A[A83WC&>9[3f&7SLL>Z:A/S
<=8f()J-5a-T,6;;/VG3S8#(gB6IIb3TNIT?&<gagNag>X[H)cc\JV[&E,=OBKA/
4VZZD<cP]CZdKa:8]e+cIFPEZA-;)Wb30_U?cBRN)dRWgBJ]]9@0_AdO2SJOU4/H
\]TG^TOReF3M<X?e43LYLM0=d5K4&FQQK_7<^KHeQgOK^P5KfF8Y1:&X:R7Jb5A1
.0Ed6V3?@P(#.<+U)T-0\(;\RH4L^H:(3cTg_J&LO)=OB^QT)Z4ddcf?(81Q7@Gc
1UZPO:OZAZDbg4A@@DJI6<H1(DU;H_P;=^(RPQ5bUU85YHfcc_edHO78;ec<17]_
Ud6;HODB:U[ObO0cT<?W^_=f]I-_UgK9CR[+9](<=JH4D?fV\7[[gXgH4/WeHUP9
eP:SS&fF\X(F)3)730F+?)(L:23aX)ZXb,W@O@\6L,J]U_dA,[cV8JF1gZc4gW1>
[@L:Cd9g=U<DS(e+;(/6P3XQL#=LVG#cC/O,IS@f#bf[FEFI_da7R9g(FZ</0#]9
0c;X#HK,M4K0>aH>/a=3MC&A]^0//9VBGgTM9]@0M&WP8:e1AEg[M\_G=^gKeZ1C
A&-4RdeYT)+>2aK&N<5O+fNb^]/f[GZa@#3&5R+^)MOOe8W&L;^@E98f@/aZDO>1
\?;N:^>+cS#ZRO,Ze.b0(g[g>RPZ(9LPE3:1=T2RRbYKQ7EJabZZ>)MWH@S8O-5.
3.YGGd58&B.b1ceY(1)_<N&2O<+T^ZECYJ^Fb^aB^]=PW/3)EPDDRf.;M?=4SB2b
>>]&7<KLGR&1<PNK=U\H\JOf6)f\CFG#=Dbga(.WAP.16(Sc0/8:=L<A?4PK1=3P
8WRT\&W5:;.FQ]0a]YR]EOf7IX8-fH:dZP;[dSa]LO;dEOOTT_-E\2MgI@M:IKMT
M=^+_QOXE6CY8;/JOQaQWMe\N#?&d4F?0HE<:)(;YE?GIVMXd+/JFBdO\LX4B7VD
O#g_8YPT)R-BX;Ac]257A\CaN)/:52@TT;)<ceA[;f;BC1/?>5X-/g85F#7fY@af
FK,#GA1X6#Y@X;9@S/b_gYDDbW#MGKfQ0<KQY@5&<#TVVKf=Y5#M[)3HV]GG3+GK
7aHQ,g>R=Z@&R4L]76&TL(b>c6\a_PML,4YBS.dVR]E>K@P<(D_,AH&]fUP);>5[
X?]OX2/<M>H1(;Y@8e[1,F,S;@9P3DY#ZXO?A9<IPeQGG&(TK9_<eOReW[Ee3J0R
G9-N1F=N<NXN6VU1)(CGVO>#EJeNXU82c=(ZFB52N?P1O#)54#A^0WO_.]GKU6<=
gS,WfU>;_9Eb,3Cc;2K>0e@Zge#eJa>@8NOWEcgH-c>f2#aLL&G(2D=d^H8cP2Y<
\E8BU9^OHSD0N32&dDQ05\9e2:dVF?fK.:JUH_/N_QcGTZc5?3^e156LTX1eFPbf
f-W<#eDC+/Z4XE@8D#V..Vf?)Yf)W[F=97XBO3;T5\<4D3N3&0A6]]aOI6L2<MQ?
LPN?GY-L9HITQ^HF0>.Ufce#/>I;[c+ReQ#NJ?NK9>_,/S-&L2]A;bK+>DKNW?FS
F?UbR7gIf/)eRWaad#WYM:9_X97&b.\5LAgZ9[GN?)P>GB/39Rf+X]M_@4]MN[QC
+L:-HTA4C&d30b7JY8RLa8_\VUNa4U4>7Y?(PZM^NaC?#d<K//(cAG91@,Be\@ca
])HXI4cZe_<JeKaGG]BJ)-0]B#@QRO+fRaR;,_cNW/[EC@8=5&-,]SUCARW]B5f5
H>b?(<->(^G1XIcJd1/5RU@0HZ(]#McP?HKPSCLET<Pb0]M@dZ-c08;[_@ddH8MB
N9\,6GYKA](:9Kd)@V0P/:W#QBZI(IDE(]\MGK4=>R_5MXJ/3L>ICZ/@6RC+RfWS
c4+WXE-:c(<GdVA3geFP(1WA24bc,>7_N5.6,.CZHOAF\ET[[@V38TT2&+JQ8AXC
aKKg92(.ZVZMTe?=]W93:?<&?aNc.5C[Ie((cDOfa,>dQd?JGW<1g8R[ggL50G6&
,&fYE)gM:B;2dQ)KT/[0a3+]9<Wb_PNMIdDR#P_J.\&VYB?ZV,D<c=c@2H2_0Q^f
PgES6?-_^>+K).4bcBV-D2K)LY:2c\X#+0+\^@A(4Uf/7\d1\g=Ae>[0L+bHQacS
MF>QdKFIT#.6>05+U;QGL2b]>g)#=H+92g:RDReXD1W\;@[a_3KX?dQ09ATQ-eWY
7WPFTPaF6XKT@N@XY8JgF@AQ=:XRJX64<#a7RQ3ef2AV:P6E[@G#R;[5ZK<TP1^P
VG&I@G50MS]599NKL)V)RU#5NOZ(U#BTLc<+;-c&YIg1]>-bAHDFg.)KS2+]#>f-
M4&V<X[2L\,d:H@.5E6,7S<S);+UFHLQHLdKIW\WM>4BNI)f,D(YPN1,KVe.+gf=
\M<MPS/)@APKD#/CO)8L28M#O:8T&dM9d+35_Z,,N;;gP6,dc9[-P^6L2V=IQE99
)9KG/5C<H[7Jd_S:PX/?M&6GWVR_G)/:WG[FJbI^W&6^-Obd>RLGSDES0PN7bcUe
.4^d#c>,4B4[VR6L-Yf&V5-Z+]?5(KW_RK->WeUb9H9XbP&3XPELg>2/:&a3Z^0M
.K<J4d7+#]YK>^0CMQRf9RQ:aDO-I<9NA2Jf-3b@G.cbHBX22e=M>7^FP_VHK1DP
/H;f7K)1S>fb#X0ZX)ba4SEFQL3T557IJ,A=(W^@]EeW;E5V]Q>K/8dgAGb01b^Z
<9J3_M1fUg&QfM\C_+^YF(_96:gaWP8H]&8R1F&K36f7&/.EK)8F+R9R=g74CY?E
W4T+@D0d+9,7cMVM@TP=O&M?[(NZTf>K9EDIST)Y<g2DH.H+\>OJ_5RO44)Q7HcN
eS&e@Q8N=>MIa(7J\NQZSH6)>X3#f1f1MU>+DQab1V1#4QHIEV-/_?RUJVW9JUW?
&AfXg18Uc/O/7M>8?8WdEcc>QaIg+Xe(K(1O>GDF6#cHB&X>NeJ2MRY.6NQ42FaV
>QO.MK@=HT,3O#L9FIGHF4E/2;^TX\EN:VJ.HLDY,@4WQ^b^dE6?5a_eCJUgKb7B
Y.?4N#<2;<-OVGN)9ZJ0XH@XFS[)IL[O7a8PF6e-C/b]IEcd:T,R7WPK@:SYdF^E
7BEEd\e8NJ&QCS=7],4_:NEH2/(5dfM-&Pg+9;c1TC^^>Y.)@#(]/FK9XI78-FC>
L3bQ:<;g6)#2>1bEPK->O?#,AH9gI&IJ(ad3?(U5\OE1J)R9HD?5)/.YD^O7I=,L
\-20f+>W:BV5C8b/df+M0R@A,bI;e13:ZL#:Y;aL0@Y<g98VKg4&<8F,&C,K=:>4
3[]LQgba3S6b_./54#/__K&5UAP[?b/Eb/E6Q@@F?e&QXQS\_Y=@-2A9_DF+B&(>
9T<KcD\D[Ve&PHK&33UPaRI.U/QN^9_Y.;g&0B2U\H1(PgUX3250>c:WT;:6-AYf
F\+7a4]4--NE\Ee.R31EE2S[QKc93.N,>GZ>;7OQJ5M5^=7C:+WVFAV?3#TgY?N_
baPB])e/Ce70/2a/;4g=,C02&D>99+?&7?=EObD8X<(Z@)1dNR4#VX1O]<MG-<=f
9:ATGbR[B8gV@cH9JG3,RO?e;B,9/&R7FEIS6X-f.QB5(;4WbEQ,\Y9MC&<#4Y\#
T=a,W_@JCc:HDd2TZ,eaHM^(X4<]3ac76Id2-Y#b<,N0P,N\:TI6C79=[J[U;_-4
3SK@SI&VD2Ib(JZgeI=98X-c+RaP;W=2bg76b7YU4<IP;=Xf:64,W^K6L4TN(,64
XT65bJJ,UfOYG^ZdOX6=V3ESN;6A5BN4F7G(7@YBIfeKMH=>+>M\?[TG&83)30WL
]?5O7(T(>cLSDHS#H6AGUVFE)Bd?A4[2IA..?1,<B[?LAGd);YJ5DH^P?_<g2e>8
HIFaf@KGQ;+.J;.[T<Z[37BC&BK(J5.C?-J_I.=D,(bVCRQ.KTH)<D\4gQ7fNDMT
aF0ddLGGM=&J6\AT,3/.&bW]3g+>Rc+M.\8LE=f73^=@3QSF\W<eU8@-MI@.9F9,
,/,/#fTg;TJH8(0.D-4S#>2)ba<8dN:g+;,?O>[?7@@Q>ac25fAC3\eWRg<6PcM0
-W2[SE.D/1eLg(TEI+N=CcBQ8T?>2YKP^(EQJf[D@.KTH5D0()9YCe?g?XO.2S;[
:F,F.TFM^]cMOEB-Wbc.DDS^&8VN,+2Rd4EdY8LgE8Bg.Q]VW09B/)F#?ZYB-DU-
+K85LR3-f:9-XV;cE1LVSGYW&MHCVb>bb[[M(IZ<=GdbFd.2O,R4)dA?GV.+UH#M
[g\<?5?M]DM+>6&QCIXEU#RVcK75E[+;-<2,6-&GN0>/f13GIC[1QaWK<P#bSKDO
9dO(Y#\436:@50@M<4NO=X=76WEOO,S5f8Ub.C#;TBQ_B>a5F^+&4gR;P1d(4DE7
8c(d)03_cPX]JJLI>)MN2BP]E@9AV:8D_)XUQP/TcA>RJ?,>G7S>ed(?b6[3@,23
_bN7I6Be:N#3A<.gY::..gJ]6cEa[AcH8]XT@I\39Y)B&.D/b]2,9#AB]R<EcA3A
f0#.:LfQ;L.a[#&_fI@[^F;c7E_FWIf,9ge=_(+S4+PO;<&FR;^9&0PDZ(\.MY-/
2;EY?2C)PUN:B[B_+HR2IG>1ca3UX6/48S\aJNQO-8,ZZEcH\YAQ?\VeGaD3]cWA
\NOX\SfRaXWX(E@NJXW^Y5VLIXBVAYf5CVA)]1CBZL3AX,=C^?5;(;Zg^=S<N-J?
6+IKH\U?X)>Q&DIc#9^FUSIJNCZcWY+:QB7E-R._F#KG_SK&M=5:A@G^B?/e?4>c
>95.]cJ?<WM1SdI[B5E=d9@,?KU#J?JDC#K\.d1Q#/,Z#+f31&S;S^H0F?HbKcS#
]H206#Cb]B435[5JPYW05Ed:NI5fBV3.)gR4>-Tc91c#G#@)Q9Yb_eKH2gU=Y=]W
UAEd74\?MeT:Y([46_;>TD+@L5.STS:0O\KB+XT.F]UP.F;1WMBO?X]?g]:d^BJ3
MbA&e9@;_<:912aY0_a+<^^K1f=@+EbT&MGd@>O])[_Y:SbBC<[&Y^J6<1_SY7]b
?XUb^-)a]H3W6fXU[14QGM)+#^Z@Oa6Se6Qa&Fb)\SQ@@&UNZ5(LefbcF1INIbI8
U;;[<TY6N\MdI;MW8==@O<=FO;Yf7\5ZZ-_Ra.9fUH(7K?&)3B0/E7/-68_G=U;0
HTI\fd:e]a6b/c+We^e8#Mg&?RZR4NH)CL@CZ(gY+f[2aVg;O,5.,X@\6a2DN9L2
@a5(A/fZ/NT:d\BV2L4A?-2H?ga1T6@+b<>(CG(dKFT^P9Kb;;aILL=]4#a<3gaW
D^PU)7TbVa]4,?<eKaC/1/;_GC78c7A.L<41Wc2bc)<_^B88^:]1gg6Zb7YI]V[K
&LZA#7bf\c1)[0GC>(.U1+5Z64+W7=6ZT[g49fC]M(faKI[agX=Ff4&1_B4/gEgE
M1+;bK.,Y+>3@3.J-<=&.>F<+>GGM_MTb#(;B.<3]dH\XCI0eG;.JgL(]FQ/><H=
Ua?5[NdQ^@4c+]5f@KA^@XFB[W1eE6IEBB2gDb@BOXJ\#K0#+?A2C^XH.>F:<@O+
7+CH>b3+66e6](9=96H[38Sa1::]<)WBVX>Q+?TbZPY&UW.92)/H)R^QMcQ9.X3J
Z8&7;1+=6FW,>NH20\U@1+8a1XW:[FT0=,8)O6L?/AK.G[fH/3Z?90WX8H=#X-8D
fCV-].EZ;OW1V=HT^G5g9,T:SN+H2JQXQWCR>CX,VHOD:\SAAE_-L#[TDf[I.;(6
c\C4D)?GPQ.^c_&TY]K4IQ,F1DJ/UaIEUB>f?#WR2+_T\BXJ3DOCCggAM+J:\#/@
^<H(G+d<>56X33e27]&;RG:/MCMaZQ/c7B7g3BSO7^C8O=J7^V74XFGg?/H=0H[g
TF?c(H+d/eV/fb44ZOdW:5_@_?dXLS,#cO0#38O?=Z^c.<C&C.d:LH30d[]G)70/
VS+b(&H?(@/EBSU\W3BP/ba<?F\5@<3JXA7:3\Y839.LOZ3g__0PO^TR#CS&+SA?
<[Gd#)<9,^NgL#cO1SCCWP0_AL^\.Y+=5F2.BVeNI5+dU4gM9a#C^E\,PVdRHOBU
8YV=D](3WE[?QE]KE+;GW=IOMFH^1gK0/<VVB?2R49.I&;QDC(XU9F7?X^bYO0<Q
g@a]-8^HCAXZ_ZJL5[#/eU/3+#V/HH#+732b4/78dP=104>CCa-+\:cPG\9)&L,:
A,&UCNN7H._8f/eD]/]fY+&^Yc4U56L/Fb];O-:-K=/&g+g86CZ/B8=gG5VO<_CV
Z8UYWZ0I7.N1P4P8IDB\@3)eP+#ORYFC4@c;=XVg7b#)-e#-R6^2DH,1b;74Y=W&
,GP)^g4J&TP2P+;gc[F&ISXK>S2EHOOfYL6<B(@Cg=)SVZ3IA=;9Q)XeL6g8STLI
]YI?Jd-g#X,OUT0>bL64[0f0<8^?H(@dcU(O0]YeJ590\f^6.0#>UM-44Qb;M9OQ
c5JH+;=F9;dB8;\9=+P3<2I72#8)[GcX?g)>2g;VNDE^D8,EcQ/+K7)75.0=2GGC
S-2;g&1/A)O?.<g2UDSO7QAH9915=1a5aW<FVBM02Z7Lb;PV:5292Z\N(Z]2AJA&
K8^6L.U?PH:(LaPKVR&_BD-2Y0eG;H,[c5LZ?J?N6P,G]gY^b6aBfU@<S76F3DX:
_)b</dG+88ZN?3=7JN>ISMS\IFU,+afaS57:=PIb#GGSG]+3/AN>B&Ld5??B+UD-
4V^bNa>:[c:2O(Ab:K\[:@U[0;T[Ug_Q[a:I]Pb5]46cA>Q?W3:X/?.]4(Z#QcJ8
]759Y/e3W?^cMXfAIH;RLG^L:_bgR)MFS@GZ,2=Ja>K5\@f-I9K,J:G]1-Le0@Y.
\ScJ2]AICPMO\HQ6b2<3D,SSDLV=WOeKP7e3Zb/TU\EdbE.O1G\;Sc67_FfM\c7g
N9/;C,,0XDM8I&&JLG.6)II(/-3e6(6UT\:X\4R-e9SF.c)G5gI-].;Y+FU6LH2c
Ac5=f-ZccO@^XHA>PQ6<[&+1H(J?;)P9)IP;C:/PPPQY&Q8DggEI[):SV/Z^cQ[M
Dd.U2g79:J:f(DG6Jd[CFO<Lg^[M;H4X@5M8#d/J7YW+QDGK(U7^J1G2ZH(e:H4@
eZS<@S(g9^@G0,_ZF^D/]D^NE7+_-4N(?8aNCA0WEAE:VES)30K=SNMc,V\(L3g8
4XJ+bXbOOa9:KQ\F.MW&ZTRcF=DF:QFUeS7HfK)K<#cVd^P-GH3.4acaM(XG/O:4
3bQ2_3M^^E+#WS,HT0P735,BPF]&AS(J6/J=g0&X+IS]Z-_1)GBM(c)<O9ce105U
^dY#aLWV)EA06JH.<?d#\PO[XgQ/B60VFOY^T1VTcD2F\eAGJ2^02aGJ2-6Y)ZYA
JV3K2e7+M#/YA<U>H??b>A(@fW>MbG_BbLZUD[#@COY\fA+?N6H&9XOQKN)b8]9;
XV/(C]EK(WA2XVX5K=6eR7BTV-(2c6U)]W#aMe[4,2=O(P_g^W14M&L)M<5FMZCP
L8/Q.e+DR#P\B-=18/+:_#P77.=DV[Iag(4_PWR2:/4^Q([E3[dD;YOCH(82LX/(
/Od=_N&OId05SGFEKU_U,cDa]:U&4.OL)+,Jg[RG/@9eV\7LIMU)GJ+2GSc:>GL;
IMCJ1c&X>&FNT8A2+\b1g9TJV1gD0]_2POE0Y3\VZE?D@VVX:-7Ce1XUG6Y1YRf:
H,(0B5>D)fCM]JN:gH5E\CdAK:;+DPfJ4?I62P^(]89-]JE^.ACMTb=(1DcAgDOE
^,,?>d[8O5Q[11bLL6bKS[?_(dKG+(YRNTATda^TcMBC9KL4RMP.O0a6MNKGJ4dR
J&>G,BFS)/K:4:1#2fIN;D:bO)N0Z3QU11FO@Pd:#Y&)A?]<-7A^\58=>B98CC7V
U8\A]cS1)TSdW=aOOREeEKe[d8;e\g-P;@^@7[IP)-X2Z4a/&B9LbG2G7bRBJD;-
,43[F4X[X37.>Ic6->4MLL61#ABg6BJ9dBI_Fb</dME/^#.]P1NfdYe&30;Cd&@b
;[\\@e])Od+b04D1(H2D7T1E&:TX-?fEf-K\WbHF[K)J)FF5CYM@bIJG]Q\X-R0C
/I+@.McJLCU^0/31VcWeIQ#D2G0DXT)ZgQc=ePgGZ=QAW7F0QT#047G<-D#[O,6]
;^M?Q2&<Z>YO:?9#a(H_[O6BCEXPMDUg5DA/.M-^WZ48)Eg84b:Z51/8=CH-U#P7
6)Ja42IY:JAUa\ZQ&<:<N&>>,.G#FY[aX:cc&H6;@A(EB+TT=]\6RAc@SXMN.ICK
.UOKdfFMW-eeEMb)NO8V39AdeE?C)#Q,&V?gb??NCD#X+P?5]N.^R:4D,<NP:]QN
-6K.;L-JA-LX=]1F>c8>0#3G1N?b#^5Lb^<O6gZc?fa\_H4M)NF&A@.W^JB//HQ+
I-78Z(IUYa_2B&U])\[[5QW()ZEcSS>+_<M9(Qc5ES^]Zd,J9/W83^Vf]4)eB77@
e+cR^R(\K&WYZJ7g1eU__OA091;L[)Y<2:YAG\97cd1gFG5-+14.[a1KL:8]3-NR
_Hb6M?BZ5OU:+dLIL79#?-O._T/?L-1AGC,<DFC>fD>[cCd4f)@bIO)E.62G:EO@
[3SP=-IHLL[ABA+B?,K,RXdVN[27(>GIRL]8+0\N=Td,EUY98-aKHb_ZVQ,b[,]F
0[OgWU]V@:2B\3:&V]9[fYLX@WO51D#:d>=7#^+X.PM2LH#\;K4D1G1H&d,:A^/a
+V4-.5NC.S51I5/V(Zcf8[Q(,L1+/Ue:MfbK962LMI:#UVVM@:;OE35Q&bdCK/@^
bX\8=Pa4d9J5_&?@.X9.S,M>;<T=dMdef3S/fYR5.ee(JF8F>G6\8D:e;F^,3E_/
3F0#5a.[Xa/4[VKOfE^4PBR8]Y4797C=f0SLGeO1JG)X?L//4F&9OK=F)H8C<00X
:]N6]A?WH=5@[<IUK&PaSBa6BU]L\ADW,-19EUDKX,3LR03]3Z6Z72(TDZY;fHON
XBH[K^UR89U?^Wa6)_^5K;a9>g8,Wa3(QTeB\Y=?eC^.c\b+AZ8A]7;_,>M[XN9N
4IcHK;<V:9Y4dF&CNXHZR\)aGgAJ5WU6>QSeTQ&]50_eD/G5_<@ZUA5aZ7\>01.g
g0>BRK]XXUXJ>0PNN-ZB8Ga=AcH8+c_H6ddM5C5LKCWY);28R=)=#2e\S/WU]3eV
PMHC+g;/J/1Y5+-6WANf0Q<]N@4U)I.?L2g[SJHIP@R]AWYc.<8&_Vc#+/NUe>e9
;]YA#K;1Z><^CEfNKc.-9dO8Q=FdI;N0fV>>R[df7[aB^4-T]7=3?(b_+LI^<e])
72XHdC-VG3L,K)ZX1T4cQ@dI&E5V5f:^F(gY):#ZUc=R(C;,Xd:2>(Z#-;.8I)]H
,#M4(1LWVS2\L2:4\>0e-/-PM8+ZMWL5Z=[P?T(P<@M>G/(cZ]J[[(I030&d_23E
EKKZQI,/M#1&L@@7.6Z_7Qe\db6MH6_>LWRMf#.#)G]^G[d[GOR&DABUG-?^=TfK
#RW.R<:UWP/65@MFY637J4)F549GOAdM(_\.E+:f3LQK[NA3K(RJ[?+\H)=NN=<^
FA[-]I:LLB5eD5;6C_IC/)P&08f93aUI4)C-A5LQZL/f6a1#aU_6,5G3EbeV,EYT
T=#Q/gKd1O>)WBRb7[G@@:P.4LBVfQP@R9bVa6eIS.cLH-g3GcMH)&356Y?&cf7I
f^fR>?#T\9W:5>(>Q/KfY9^GREX(-8P1g<f]XYKS8JcD;e4G-Z1VRbZJQU6;A+>2
aVRZT3_>=g;cgNR99PJga)6Z>QXM1LGDYN\NgPC=#[UJO3Q41MI5I>M<;&e^0UB8
c&B(&Y0+L=Jb6(a4G2?W,I4H&f.K#d.c7FLN>LOL951TYgG9d18d3H_HIKDN;Sa@
c4]F.=:)S@2TD]f+6b5EC=#^1;HWVRBJ\D20O-U7,L>=FLYB#9=@WR,HGcX^=A(2
4Q8Oe+X38OC/3CYT(fDdDXd\b6?d..B_J.HC@<++B_B.J;#bdG4)3(e>.gXbK;H0
-d&N)K]:?I8XV@]FFR,;N]fFO47K@SEgfU7]5.DEE[2A/H;HXBZ@3?LTD;P8)b7K
#][2U\;F_X,d=/H4/)[?De<ZT1:ReHf295?ZQK+U/GB5=Y;_dE4S&P?NK;^7]ceG
#NHCf0XL\O6D&,(JbA+7B;XZ0daB:Va>4ALf<#fBYNB<H#1aJYUUI)64fP79<(aL
Yf7RT04X;-[2WJ5&J8G<T4X/4KWW9T-/>0)S;YUX4_AO/D&F(,<9VZb(FR9f#aK]
=1XUJX0>FS10O;/5R8CH8bA+U1+AG\EXa2=,0c=TFC7D7[D67JM[Z^M?9,aK61T(
+1^SVE]DH_T[@N/cY?R<?>&dL=VC96AfD\.[2Za7_4(3<U)M4\Ab1NFbGg(HF:S7
E._I,?=-=g<K6M>fFO\S)0.1bSIJ5H,D6^PZ]?4(^eea>V@VS12QKT-IGBA23Y5:
P[<WD_[c0d2<<d;d:^L&ed\S-RX=1KS<PBORd\:AZY3=K[8f<YX[I8J5(Da?+@SG
Z)Y\d6FW^(f\e1B@G)\[@DbXQ^\C&?g[^^>Y/YUV23bN,.WRMCI.Uf>FMSJJN0+&
9QVDFE:O?G;>I64[V&3PF]g>_NDf^Of1?;AC&^A96A,JJ2eL4@;(V9S(&8V),-/+
[=IS-+Z:NMc\?B<,JDJQQf]f-Na+]U0Bd=V1_f@UVR,g7^4PMK=S8TM86\\&PR[2
TMZH^@GDHHTA\V:#BfEU13fM;B?(#(ff<B^KV<3,V/<=fX+\-6FGJH[CLO11G.Rc
TX?:0>C=a6QC139X2IeSaI--)d;MgRc6eU@f94XF/?-2=,0O3>F93IQYNgf(<7/S
BKHW[S6_/@)ZG/N8G_4;W+#I.:\^/V],bAK-2?cM(RQE/Oc92;Cb748B.TM49\/P
8<9,PEYC#WXIV&P0]@ARS3,\_BAF\UVGL3GW;f6]8=@7LZ@=#f0d#JIAE,Qe^;RJ
WOB?;1T7:Mf>)F^+a;>EZ=A]1,M^VY(]EIBfdY#BD:HBK(e2(36-^fSR[[#8L_#F
A8SAUSS-^<KYP:b1V9<IddC&XZdCVKF21FDDJ5X/a)+9LHER,2=E>B,6OA,WEM3+
GG--42:?fO8<^.L@d5f/=).-g+#+NZec\+^,6D9df/W=#YHQ[W^Q>(e<>>Cgb]+/
)X+7UBCVG?KRb^b[89d8YS3H[<Y;/??EWdW5W<MfDW-gD9b/?/?D^9K/OR-O<.YP
I/(Y\;Yf5?\\RdK/c\3TadgFb_#2;[L-899[-]&M</^c^P\?#-@6E>A5.N^]e,SP
43G[H,5A\H5.:W-]Z?A;NB(8SN>+JM,2c]YQGG4U6feZGGL\6_E;c1DPWXO/Q?/[
)#D&DBKc1YdO^+B];V<F/Rg\dT+SSTGb)Ec]25f9<NGZZBE9H#O@P:/FT&gAHT)T
GZee;&b#,g1\-H=Z2D88MRG;/fN3Q;bHHIg:OZJ#Vc>ADSY)6C\728[BVfQc>W07
9fKO[.&:5KW)f/a]F1gMFg:0cI]/E]3E_]a,BZEFE9&W]OQfS6^GWL:1^9,bf0D3
@Y6)\@T:f8\,RH@D#Y5G.ZO\@3Mg]3H705?A:Z?9&NW.2D+7e)=XNF3Q1SMMSV]:
2G^@HaRR;\>EcKMAS0BTR?78<F956F^3H(gC&YI8IXCM3\:#A][]HL3E[CC5I;KJ
XQ[@58B#RH8C5):O80bG:c:YS[S^DGMD)DAa]:MJGf&()V=(5XA@,YP,D&#EJb&9
-+89Y#[DO&?10=M3+Y;);Z44A@WP#KCf[WT.e<)P@>^agTIgX+aFR;T;P\c5JWV>
3L=HOdGdR9MFbRYdbCJ0W?^aLF<7E5-b^R(_ZCG24AbRMOGSZZ7JJId?+ZFbA6MQ
A(Y^:[eR;d:C8JX.[VH5_+O64)OJ\L]DdTZE(TB,_.Z=EcRA=TEF=e(e9Tf_SZ8]
<2,S:X(J7bS4V(U,c<I\-6aXQ-+BA#&B1PBbXPX\gH2a(S#GT9)df2:Z\P:X-\84
D)=N(U2baB(C;Ef:7)4;[))5BL+8IH62H)B[<=78=;Ge0C.FT\X=E#]2Pg7\BfFF
J=;^LE@1d9_<F>3:.Pd5cQF5?C2#;HMea0]@T3:_\HP-I&13E-KSQ<@>W9cZ2ZTG
FSVK[cb+5MJ?]LT2a&:,>F6J5VB9Xaa&<_f3O-g9F6>RL>^@&cPG27KF(/>geMVX
6(P0K&P64A1O>^NC\KNA\PdR[@O^3&O+aP10N#;\GKg2X:5/d9463C5/VIcY.3R6
BM99([O>9g@GSOa#(cMDKW01c/-?DaL^AZB+d[P-DOWN(dO&e]O<b4-Y24G;aQ^(
2D,08A\+ZWFO7W&)+<<F<cT)&f&S&efA1^&XH4]NRX\20[Uc5RfVZ-R_;GMK3^)a
d\Xg5>Zc1TbA?;L+F+_XZa0N^N;Ie]SfS,&TEG.]JKN#;LJa]]0,()>0-=d7PH2N
52.QV]XL(P;TcJ.fC(fd98g0#ZY-U#@FB8aP<(OGfd+ZCV:N0@]#EW?_BM4:)Kfe
^>B(VZJefIRTQVSBJg36S@,.d:H19)0O[[ga^/&a6XQWBXUBK=CF1[^K=<P42b\#
_ODRe@JQ&#L(B.N0&a+T;:2_K-5VCgIKNcR<X3;;BNgO.ecEOE)(;QSV+bQV\WY&
X60BN4-b8JJ_9M<MbC-7^[X-K>Dd.aNS:\)C<.:_B#_XD+9SGF&cg+CB7O0[UE=(
[D\DAZ8FR8JLgJ1MD;O,a&fd>><O>dC>beVbf3ZT4.>f1^E6^QD^2_bB-DZ9c[D)
J6\Pd^WCd_EON8K31BL1aJ+5,(NT<>Y&O02cQSSYYdY3a[We^:AP7IC<)?;A/X.8
QeV4^Y5d[c70U_B;XVe<KZ+RWc(BYS^X0J7W9#_AZ<bG:LA+.3VN=7^.7\a6H]87
ceVCDCB>bA<<#PN3Tg7,=/HD^K@XMR2,J[LYCPAC:GWID1VNQ.9^Pg+aR1a8Y=Jc
I8\-d6:)>f56c5;)^AeIVTMC1W8YccM#Y(.IS]TQ]OZNFe\8V6V&+g]5LWWN_Dg8
RLBfEMg=64C7=MUU-ge.)3G>T3ga[R81DSZK3Ic6\#Ae4?=;Ra>PCTE?SCX^9NJJ
:J.&E:BD,DINfJ&2B:cI8S)D91U2W:0fOM5dYf0/Tb3\IM\c63U8dHVDWYdCQXBM
FIf,MUYJ:(<S.9]g-].bOB_d/HJD.-746[1C^g.A,ZB)N,^V<K_0?GUP./]R=YfM
9M:V>9-V@[T9K0Kg(G-]:.\9cDbbH^@#-YcZ-B8WGbD[INUGgF+XJHM^A8RXd7E#
R.D-68DWFeYYX&S/b0(MDP>g8/A6JZFQeg)DZ]O:Yb-R^f]1=-BQ,^FS;PS-OAVD
ZcPU.<E[,H(^QNJC@E0-2b>3g,DLdA-QbZD::Cde?#(]\PJ_A2(/dOD6VKD>07H1
T>T;59BP>IW7P3/dgH&XdD6+VUXV,F6X,CZTGN;A@)&TX<ZL>4Y4a>3<2B]\7]/6
[a4Qe(Rb&CBA-K5,=@F.Q+AL[/E1<Cc8H:M^#L,MW85c=dO01g.L-a0;2)b:cA3:
5A;NJ9AG=<1FK;BL,c@BO2>[M6,9Z_eZZaZN:_XTa1,BER\?XCg^d)],G[UOJdg#
UId,bc7L@_IC;OM^5\^:CF7=8^gV@BXRJUGTV)eK\9R;TOF@&]CX(B3P81K_A=Nb
,7b-(BF9B-\KQ_.3P7?S/EA^7W?;PYO54VJ?:X;MFC/Gd-IDX=77I&R]J-I[X&CD
HW#FFd^QB]>6CJD44?S+LYZCZG@:V=J2^^F7dZO@C.G]I.A4E5):RF\?Yg>>_DZa
]#F<Z)^;(8MR.VBgFKBGP4TZcN#cDG:R>LA/Wba7@K4&@Z-G[471WXQ1caL_ceRI
fZ9P?D:IM4DI,WII&ZNU721-B((Jc()cR12g#/F?#=4Z0\I\9)9<M/K5(]=#?953
0V=>[@>R6V@\f?&,CBJIWD?V#2-Pcf80EE]WSFV_?:c<GSfN-_J7N<G#EE/H56C2
0A1QIN=?DL?_G+WDT5eNK\&JfE8g:AZL01c:7(T)/F5)O\5/De<-C-<4[5JA--Ic
;;-JC(_3@30Y>UBG<cRLM,D_Kb_=4GSN)Jf\.Y(P^Pd8\W=.MTSQPR8774(OR+f3
9EI@e>3(WD.F824S5U+#VK:M^,BGIg;2<]5Xe+6.Xe2ceXO)9(^+(Dc;O30RN9AZ
YKZ@\e<#BEVAK5JI<W39RQ;TK./gIM3La<KB0E@N&93)Z.gTY&^&:>&]EWMEQB\C
U(OBQ]Q9C>8<82M[>@B/I.)^8[]Y^gF]<1gL5W:d=MA+UOLGc,B<@IJERb[PWLJ3
f]IPc#V5^>+<LJ<\H=OcG:G?_7e/.?YTGbDWac?AT#I4bXf>LYJH#C14R@P.@AC2
5BONQPfWZNFaP;@>O3D?fdBZQ4Q]5J(A9=L:Z+IZ+g:X10<3>346-21\^]6>@NS7
TJR@?gQ70/-)8:E]O,TeJCeD4V9/g+<[)=>N6H,PMH+B>g/]7eb;,U)7ZT(+@>>0
=UcAMbS&(<dS-)c5MWYHDbA1(cg<DfBP8=[OH&1\a1&Y/1@62I3F9JH6]bGD)+R\
-&5@0<EHD05H@(-PP[5RcYE]>PG<V^f.Gd].cO?8EW>U_?a0CKQMPH3DT]I^ea\F
NDF2@(V&X\#9/g7DF;BQSG5^cG^6LTYFT7])(JV>W-UJV+[gTU?f5d4Z42P717Wg
.X_9H1R^Tc=P3bcKW_O38:1UHTeE)6TW;M[A=GVGa46)LM.QPF)>Q7N=2I_FIbb7
^4I<f-5B.fX;TC,C<5&XW(MY0\62YaNL126-K28?@FF]6A=ZO3S015d^>>_QY6Fb
GC:F2U>D_fALEb7ECCPQG3GFc7GA?HOSUUHA<,DW9fI=O4]046^61d.-#LV-+EP8
EN8@)(DB^A</^gPIFV1D-]ZEKQ9>/>284@9>\[;a6(N<.11,_L2)[]A(#fTI^,OX
=X/&,C#0P?&)cfKb)IW&d#;OO[d&bKbK-a1Kf32J=OI72T-HFC^5W8acW(^GdMf1
C\d:>5b/GSN@8UgT9dQ>\H2Fd814?(#8V@[.WFB1f<[C<=@/^?9Z.B7e<68BS4([
I\HM&c898dg\22MUf\TCX,DZFI>>;\KG,P80]M6YQ9.PX5HI=V:U^@0<76_V>cfA
>DFe<L3T\:_#C@E74=3+.PU.Y&(,>?.H_26eW\VQ6/GHfOc\LdG\#K9Q[d).S9NS
/J@_]=V;L,.;LHg-^#FZWWdTf5D]-:&MH--7O6D/RagS+R1UO#c-5=W(?e0fBc8U
>f#9>Z7Zf?ZWGIM;UbE\8)c@XC=V:bO3+-73X/bOA/2d5HR;+-[bUN8T,KBYI:X9
-N@LDff+eRAFTY7aeG/G/]d<\8Z=S>AgJB.SJ/dW,M95ZV-M-bE>>(P\^RdbHTR2
4L#R)cKG;QUH0Zbf6fa[:N67QdD/CM[RHEY[,Z9(e@9YF6<3f7G0KM/EXJ7+5NbI
4,4RWSb0@BV4bdHgUP\O;7^Z[C@EJS38;Y;11:,EW\MNYQ\91D=b:<O_4O0Q&:bc
6=Z)ZPR1O&UQSVaN>N;@A;7>e/W0I)32TT(gX,;/BGbX,(\PA=7FQg=R8F.LJG_R
@^O-cL[dF]V:g\-eBCHR]K6Z<>,K\.)+Z?0@-ZMZaeP[/881W5MF)EAXe/fSA3;>
J>CL0]U<c7(_/#8dMQWD^H0a9Xd,@7NL/EXXTI5G#KN]7@\Y8FM[cRB4E?6)L@X;
1]),LBI[30IbEe#>E_1Nf98P8:7J_T9-VSe\IDFccS266:(Q>eT(A6F:JJC91aWA
T&,;J:/AQ0QN<K(a6#,-@e<MfBV2F0E0>XG.:1c_6+3SBAN_bXBg?CDY&(M>7IF#
-J_J><IIBOcM^@e,LaKV^9;^1/GL;gGNbP]ANT\TX9(3FTE/1?_1LVEF(PIg&F-[
;,,C4[PDJ:Fg\[a-H8G<YIYAWHG6M^bB3\5>)<Ce,8(5Q\HUfINc,PFd...>YNQT
WZL(bJK#QMM&__/FQ)ZFb(/?PYOU9U)dfWZc^5P_\gf/[V?bZTUgKUEQ,?O>#G97
:ZcHP(0[ZXV3&2>DQ;W+O3dV?3X</J_4G0M^YU#I/X]VO0dW16O:fJ8)YK&CP;K.
Y0d.(:>g;@>g^]b@O7[dSOIT-=&1P\=SM0VB#gJ1=&ZA:/8+e2WfY3UD8@7\8@);
6M>UBeCP(U(f0).WQc06_H)]B8MGZ66T)ScQ^E+P(U)9M4,>OA7A;S>?OX@29>[W
K)0;E80TFe&=;YYBB<^4M6a\[D5S(UNXCa2V:a61DU#WPe&7&DW3^&B+O/-H&&/@
/HX+M-,Jff+M>_-/,]#V(I[6g)G42M.=NKIVQdYH2>82V(XPKVE,7&LG54266Cb8
;0I.[ID)L(Y.a=5Y=2I+[D[N787Q2QGP(Z,cZX^DS>RKLe10+H]7:P.50?,BO0\9
eZCF^#.Ya3_^.L=<SD/#V-+&P+Q6+8d3Tf0AK#<G?eF,e#(S4+AO9c2C;<F@2#Wa
6;)R]b#g,;0TO@,&](-C39097+#.@P?J6)Y#NX@A9MBHSPaQ;,_S;D1=+#Q/3EXW
DdJ(W97QdH50Z<1ATKWX]3M/3<J56#E6gfUbDX0AE#7D38G<0S>?PYA_e[Ze/4QH
&dPO?J6UZI0V>CU&?P::7&9;Q-[J/OIBKfAB@3F[A/2fR\R.09SQBEC_=ag1dVNY
2b/+H]PBC_5OI]]Je)NCU@R[@@RYN9ANU31[aa#X]#SUW7>1f_S@S]D4TLO08aSS
NGNE5#1^cRQYK60R8<AD6EV)0/g+gZ>798+C(GURIc:+==N^+0<V)&e5F/^XU)C3
\=/8:V7KGV5:H3f[&cOWE.GX0f7:cOWQO)6UdZ2/[U;D<S.UEK20MI=S]J_I_/QB
((3K)d>LRfET6QURU.HLLbUQdCZcS0\3-aT06/VTa9W2Z/-8Z\7d=Lb@82c]=]Xb
9<Z#2WAS=&bY7+8,8_J:W8)#9g9ZI2]#>>AGWg1C5]O:OD9^+M26c[9=IXPC)=H]
T#R(b]5BU&W<>>[&\IWO4>\77T(MMe3LEY[_V_/Of=a18+2N@WF0Fg]-KH[589HU
0^c7G<WL_&0XMB=-C?K4TS9E^2bBOS(#38CU.4]LceR857FYcD>7#eNb5U+[\V._
Ee=edDBeDSI(+YaYZfM#3[N57(Vf[T,[5c7#7_F)4B^f2LG#.:@T.#fS-T34GV89
2?d.CFS]A0G,UXe(CE2#IO3B6QJ__M@)=]gc^94ZYG7<5[2d446^@HC^^@T&<?8c
>f6QTOFO1P9KL(C-(3]CU4J/2AD\d@Y3+S-g=+gFa^GI=,KdL3U0SCSP?N-A\83a
FNeL:6Q7LdS7>+f7X72QZ)MK]J+^TC0C.5\>IN70PbQ:aYN3,5/3I.4/:ZC[c--c
@1,VcK:Ad2KY67U6(gA_:H99/ZYI]_@^W-N2bN]@,59@C9I+HLE_\/I+2V^NWJ]I
._8bX^_(G6V[f-Q)+K6\?2:6VY17S.4K9-C5\GP&eXVI#FQ(6YT.94aH@XI/?_.4
&K\[AgH75.?>ab:gKFK>.PT)KHDBJ:W+\.5(U=Z>&V1UO^UGY+8-(JgJJUDGGfM-
FUG(_X29FORIU[11gD@5;gdDAc_48?e#;YM(E8MK^Z<EYZ^0G:NS&d5UNO2(B5E5
UTcb2.EPeaVFNMg\.A(ZC?0D[T:TWd]SARd>C(Fg@A9,XMW.DI<<HNf(fXZ42]39
F>&/FbTT0/-@//9aJcG@8SU=2V<:#P1]QQ2O#S,8V[Me5M:]/6<0&+S\7J:gUN)b
gT89=TK6BFN:,NYaY@eUIQce:J]-5H#U#CK:\Q9JW+-NOM9.H^dQe)?,FE(605?&
bS0X:TEb2&9\.3#6a5;3(RgCbcL<+NW4R?;BMQ:F;SDBZF_;15G&cMcB2_F>2_b6
dTb=dCDBQ/5#(TC.AQReUM-Tec/MPWV:,)UIM64Mg>2cTcS&NQ6@U&C)+LXad7,B
#E#LfX+#T8I^[d)4[\U.H,6=B94FBgO+(-W&3A\(1<MRWE>I47EAFPV45R^8=a\D
C;B7fO7]-@0\QfQ3&\W0^.S2VSTbV#8)-XG1=-F2ba&eUB-#)]>2+E.Rd+EaO-7<
\>0>B&V/6bT5,&ad/-aR=NfV7#:=PR,J\X1cI/1P5IH-;YX5PCQZ7Ab]H[VO55a7
Z7;J3G@IL1D9Lf.TD1I;[@Ia)-1a2@GU1-Pb;:[?F^T2N#(0#9^Fd:OU(/&[_@DD
Cd+(I?OJc1.BVM2GRHG97^Zc74))@4\BDP&@@\?DEb^Ge7MXO=e[EMH#)[VBEX4B
BaM+M(>Q7dIC&879X#g^E<TaT/1E//SQ=#>Oe5XN(D_\_612[CE4<72PZBP4IN7E
(=g?]^GV4eA#XH)ZQ/b@AM/#\?-QRc=b-3^28S>1VWPZH0NaAF=39S[L(Y;XB\R2
.:>e[1?2;Y5PWV7RaJbT.?c<M0-C,;X([b0Vb.32PYMMT4WX@I_YK#@@PCO.1DW@
.;+E/@M_Z#:b[NJ./+>,#dCbIL>T@5daXE^XUOc<S82-MfW63SJBJK74(ZF_dXTY
-SZZZ7?F6U:Kf;e_@IR0ffbR>(?g]SL+LX68KG/)f;W=dZed2[ZNQ-TF:AM)AD??
<-]_bT\e,43LM);>B;PE\OT04O#RXLNgS-Z10:e?0SDIA?VF7CT[,ODTA68:\03=
(dC.(eAJ,dQUN=F8OUN/\+(G2G)G,AO/3EGJN4F[_=3.5E>8+IXB&1Y]&BSUOJAX
2PfGQ7^66&NPO(LCU/P:1D82DA7(?#c^&UdNUg^DCNSNG4UJ5L=dQ6;bKPP#44d8
a1;0Ee=Y)H.Q@0DDZJY+S:EFDTPH??U2-0&:LaWNBY;,)b045HJe+.,P=6>D<E^5
-=@PG<T0RgCX6g2a]NNeSO5,6[8\c/@WU-_B+GNZ773JDJ+6#cO-=OcV#X]a+U&^
-9S5/>W]KFM5;[;BWE\UcC/B-8HN6RX]g?S3&]-gB6L1/=41)DDg2XD.d.)#JHc;
9L)/F2+ZVKbT(NOLb<B]I,]H_1/0VGe))7G3N(JH=&Wa\;W#Z,(0I<5C+EK443Le
>@X@QC0^&:_AS9[/VT4ZDQ/#.EQUe;:b9,O4RMAOE>;\T]]gdEcO7<GLC=3e=.3G
R5^#OX>)XaI\0R:dJM<0Qfa&BEJ;;@8\>^a&FG8U\dE(?-ARcF5AXQFe>)[;UPKL
TQAM\b3d<JU>;Y;:W9a]Y5R_#Fgg1KZTgTUb]#5F;)U?O26=MX5#^dG/FNY&O0:_
8UCP2_OTc5Q0B0OUV>6Ae,DF>[DP\/]X:<<6I6BFBC8NWJ:ORbWE>e,M(8S\X=#f
5f+e):)H_1I,GM#7Ec3(^RaEU+@WUVa[KWU:Z^599_N2)Y84Y/:eSI::EG,MJ?aY
E,@=86G.?[BM&;e@0_Za,]4]ZV)27BQ=:>XYG:W:.3>(8?FYI>.f,+V,QZ.?fWA#
P=GA\HJ-^]dMc.aG<[=C#cUB8-Q@F)?8/V0LZaOHMFf7@1+S]YP3E]\,Jf7]W+N-
Z/8W3H5G)_d/R(9_MJ7IKW)G7d[HSdVWf2d-BX@_ZRcc:e:GDB7B_M2UQa=]CY)V
:6N4(NP.Q-EK>e1<I&78#L,)/SK/)CPQ1R]ZCd;:dUf/7(_L;P)2dH:;e2=^@S-e
1&YD2_)C_((JN/DDeb&YI8aPW3#=_LGU&AQ3LO(B1#Q,5<_1@9GF+X[cV[G[1>#P
eJ>]D.M^L\/H^L?FJ0\\Y<-F7F59d8[LQY:223^;WCL.Y/ZEdL7;N1PK7/bT#KG-
YAWWC5NLAO)2V5RJ>,d,fP832f6^L-K;VASFFdR5?/0#Z[,7TNX:Pc1?/OU(TY@5
+H>N8&J/9bLIXg,MZeQ?D2aK;2G;=9a]0^7DU)B;W?WeL.#gK,;g?9>cYf2-Db].
D\UX]/G+E53MLY)cX4S?F..V7adbOJCfBa[?fU94^M,0-<5E6S6OfJJ3_7,P1STR
9VFL>#5&T?RgJ,8]6D<R3e^[L3H<JNZGNK>g;[^\1YY(Fa27S5EP69QF=RR(&&[L
(WHfVL2bdRDd27,SMReF@X]:#00)-HZ6G#;aQA_&5-53e\N)8#eJMf\@/gF1A)Vb
([MGVR0-0d]WeOa2,BMCYWg?2@U,R&<WWcVAFKOE<gDec&HK]QI(GP:E4;UI.OfY
F_a5OPQ#^)D=/2TeT6-TYYK0QZ@<5PK[4[PD[Lb:[^]L[A)N-L]A7C:K2A5T7KA=
9H(_W]OBV&>J)U>@L?3AR;K+_@M\=8D;ZV2O:LI<1;F1S(>0E[P)8d&P-c(=N>.X
\IB_U,:C<8&K;bHJ7^f2Za?:ZVeL&a,c8IECC1+G-+)1@A>WAg=OWKI7EF.#WW:,
fVaMWA[TJad7NPA5+P^La@Mg?^G<d=cKE]gVHbU.U<NdcWD:\FJcPOW2>fAQ/]Ce
:-U+LGDKOE\7;LRUa\2<#(YADT=)W0Y@N=X)00_a<A=3L:LZU?7=T,N2-8O#+\C+
]2f#gE,ZS5V,=JJD4:Q;C-H=>8R5?&eMc9<ecFd,DPcc1FIDOVJ&69cXFQ[UM5Q>
1YdG8P.6VL\<VA.CYg\Mbd^^9^?RM/@bU3F]T\FS[dA5=(U;KbUV8_G>9@\]IM>O
_22Yf,H#&R0[I@WOJJ=9[/^G/1#&b&/4>#Rg(6a9K:6PG+[d.,>)\_OVbK=5]TKH
W42ED+4,=7+=aV<F6Q;aA#PK30EL,MS6K>6W.?)<\HF0C\#4@/;#:b[F9M\;QI1b
@)&Y;eJbZ2N#8aSTL>A6>R.?).Ldbe/4?.gW),+#;WBY2P4J<MSP\<K3Rgc(UTb(
8Cf+7OO]L]9P2PLc[fC<EHgN6[>bY,A/T>Y#UP2-IaYK15]_b0(ZHKL,+[18,GWM
DX:WSeEf^#OWfLI&G2Q#(^Q<G66AD)P,Aad)PMTfSOE[EU+b6N1]@6Z7?Kg<ZTT/
.2=6I<3DXG@=P<NJ>V;;<@4eY7:3:M2f_>&X(^//6AF(#4A(fI)(HN;IeWQCTPb9
S2._<GRELBgMd9+PFX=a&f3KR]BM\^\6T#>]=:#M?>@Y2)SdDR(BZ7&ea]Y_ZKEF
@8G19fC5#a7UcGE_f9N8aH+6V=44)C<HRXL5OD.D>+@7X[.b;[-G4c&JVS/MfG]:
/)78UBD43/Z[B(.YME3AP@f:@I;>Ma+Wd+KTG\?&<9>S+g+Q1CEL6J8P0H-E=1c\
T5672Q71VfCT94K1Sf_Pe[2G8O#<-dHD,IV?T<Q)V9\OYHY2H5HQ_?4<TMSQb0aK
1:J<_/#4g1E[.Z7:XYKKe9CUCb.FI45T&\+.cVLAD5e4V,ZZIX6-DKZA7,)B&U\Y
1M9R2<XV_I+TgXPBNf@VG(:EDP]CY9[[P-^P[>,]CZ^(14W/#cMD]LJb]:64L.GE
)M+3f/Y:#A--@Nda),g^9^[1K3()PaJ6-)XW9K^1g0@@IWI/g_ReXg>\VHO\N1K?
,E]O=(HWEW6YI8PJg0+R]/g;F4WG+^,;7>+Z&7ZQ)9U-]Ze1_0#\F(Q93Y9VcP_/
.Z@R8MN&M.cN+T2(Dc</M@W&K1(;.c]aB@I\e-dP8X/A]8K;6EBH8+BH919M?a<8
CRdF:91W4gKSQF^C3-AY8>79\N+U7T7gg,QHEIVUe,QRO.FGOWHH#fd:-M=1Rb<;
caUU^,/TZdF6fHFc(@X.KDIMO4JQD<H>D+_11\WIN(^(-c5O4/E/1GNK3K7IGM=<
8P#TD&D]/QFb>&M)5P#5b_LgeH8T-A#D7K.CbYOUQBN3).LKL?64cVTQ9Q@=47LA
:e(YGN16+2RM^S,5VQ9PX)7d4(6K7ePED9K??,#I^>@4(4C)]CI5;H)H+G[RbL#.
\<#IA5,4a#61PGEUXS(,CBc5;aPeV5O].=MCW+/7;BVGYQBJ@@EE/0]aE#=#5AWW
Z,I,()@1a>Ca>YC6)7.-:?G:<1_@K1L?PB,I8)(59AU@?XX?]17X4B^;EM;-S,\M
RZ:7[,-RNQ&b.]L7F0C#fZRF259)K)P+J6S9P6(b;T4I+@?f&YEDbF)1+,\QD+eb
Y[5:)cB,b]R?bOC#T+8C^)NJR+b.9HR0W]]+Fe<7B+d-X8@:0X@=8UCI0&S:Oc\a
EEOSUa(,:.PaQ<Qd74ZA&Z/GIS??QVRbVdBSTC]Tb-GBPAP)J4<6SI.9M+JOJQ3)
NCO@Hf_O]a\4-J^?+=P<1+4f+[VRcA;)J8LGGXK@UHQ[6e1;.d.7C<6^B_#b7626
<W3DB@^KGOJ#JR>;U)(+-?QR1<M+[\:8:c1ab2g(]GJT8_B&/OC,9.JJ2ea&9Y]_
OFQH2H_:[C>?CJDB9/PDW9&@W6b&##PPe[[,U32.3\K,>a1f-eLID+E;bWPH:/_?
6XZbF6/F8Gb/:=]?R.E7714;JI,=@Y,+,([OFTBD8-fX)5dJW0DJC@G^./fB(.<#
c@W^fW,_5QZCWDINUg:cR2/bbE<-;2e9..IWUPUP7;Z?HW]@P(RP)@XJ=^ES^IKH
aB8f/FEX>db7ET(g>W2O9&AHQIWVI[4d]e_Z\\L\_;e/D1ER3.OY(5-H#V)V?cb^
+Q)[^f=e>M54Q\#J::9UUX,7I#:S]^8FRE?1,U,)4#VEGSD.e\#0@E[Ad95YVM9Y
D.A@VAMT1cWXISK6@=TUQRGHad9D3LZZ;dO.g43W&@e9S(;e>8\deZ]fcG)3aC(W
b5Fb#^(+TQ;d>OI9PdOOP0FJ5+JXODf\O<e\@a#aG\dL-EZB1]CfLR(RdDFR)VL3
gXXYP_bX;c+g\H3/-6LCT[^6d<?1+-7Bd]P@N/KQ<gf5XJW=dM3+5He?g7D/FVd(
]L_N3991f.\#U4JcDKPQ=;W4.=OD8-e)cBVKN8d(8a)8VTg>41^4a^Xe:IW=AD_&
[/7HB:caSUN#:V=\c1(SPSS2e=61UY5,.J9GP1gWdAb?LB6<\42:#ZTFQ=4(<?:[
1K<8)d]\R[RKK\a4X1S?.R3#FFA2d=HIa)+bV.8-JRGEIFA6#TZSF3_X#,OCOCI[
1SG,JN/3NKBMbWcL8ZL7ZZ:K0#dNA.,0M:46FI/U9-NX_D5a3Y7/,(4eF1M@X<PC
O?^1<6PQQ\DY/G--:J<AAdXaLPRg.Gaf2+[>=dXV+H<RA5&dGg_N>Z6W0WX1[G\=
:\P)f0M>L8[f\_RN+/<]IR05].3UJN4f9-B7RI,&4^ZdM+W)GQ<=GZ_gf-2>G[<Z
QCFD0/)8C=1J,9LJ/4_gbY+aLd?/@<G^N05[RH43+_CV/cJ2^LRYXJ;?<+^Z.EF]
#E-V8/3+I7[3ID5aYd_UB7X[]1)[0623QNQ?H.(.?WMO[ALZ?aN]Te/R#LL4P/Q?
_=?4@6VJJ5^:-4MH7]/P,I:I]O1GcF;:Q-[Q3c4e@b+X@B(ZOEGa8GE[H?I[Hb,;
TNJT4Q6/SE&e<RUU9]YITUJ&1/R?LE=L<ISM;P+IF@TV<:9FXUNFc(:&>ZDY)C_I
\6)c7;W5?+SI;&Y]-#bd)97SRU0Y#7ITaO)RMW+=@Y^?;UL8b7)Y#dLACGGV(W&&
V43^/BT++PD-8EP3S/WM<9MG=JeJ?)YID/A4J-d-OedF\cV5T-fC+^,gT._?7aVI
O5/V\X:Z7]KGC)SA8<cb,G:NL;d]T[Y_RGN(b1ZLB<6c9)39=SL.AG=_][fUILEd
/I9-[2R.>=,J6N(PX+Z<S1ZEZXId\2aK7a-JK@X<dMQ6>.0L3:X>YU2a?eOR-FGM
0fMF;3+_RJR]GeH7eG?XS?26fe7OQZF&XI[5DLK:Q\)^CB1F^?M@TG.a/_(^[0=N
FG/OJ]cTI7f\3KY4-Qe/O8RfU[B-?7Z,(+9<4PeE(;-\.)UDAFD;45GKG,_IEWQ8
VIYI45MU:@NcG6:HbIK#9\&3F?fb^-ag4\OBN3&f)M>7bJ#+_4WTb.,5P>>ND9&A
VGgRf&NU,JKc&-\4D0Y(?7g6+OBVeY1WY/]&@^QUKR6N4dAL]<:E8GTeTUVR[5\X
,/GBgALD1>#SeM_gd8GWb0JXDU9:6[@If0);V.,IJ7KIQP--b)@Z,8]^GD#,=KZ2
#S:gVCggE[Y76-fEbR1d(];M?_Q\DO4O4Yf3@bJ)LCeWW?F=2T4e_N.f=OAg0eF.
#E_+D&gGRSX#)@,;BXHK(,2Xd?HVUAa]Ia<L16=<ALS5Z2fY[W)@A.OWgaAD\9?/
JHT0A5WRYB4?2<2;1F[6^@Y(6PP0gAeY[^89Xb?1d8YBD+RVII9a>-3=BcA)2Q(A
O21H:@CZB/^/[BT^BO<N<UJAHAQ(5<N#D6UPCR,Gc+F49#[RU.Y-6JW@HKKI&U4.
<28DN^J)<S@bH=</;Vb?5VUe@4bBDB);]KcScfd44NU90;g1&G1VYVM+B2<Yc5D,
P)M[CfQX\)GcHdRW.BgKRd6PI=a54H0P7f,dZ\Mg)P#Y\QaQ#Y1Ra(?,W>5<0eFG
T8aEF=E+cPe-N:,f7\>3>(P&U@g?<^^GYe12KIJ)KbU06NF=P_QSR8bY)a<g+C5>
N)@PXUM\7LbJ.D)eGB&;9NY<N&@JbA;a\@,0>:)L(-]C1#G\6^A3R^RF#TgI)^M3
:;H32.RPKX,Bg<22=?16H\Q.)?3A9<(dB9KSKVWXZ7EG23><@XFGeJ(B(RKg^(L9
-9B5(afZa)d.a3[dZ1W,W-Qg]XU2E[X-5>\VG41gRTAXZVg(/A7GB;E7VYHWNK4)
[-WeNFGb^Y9#bX,KG/W<&6,>S5dcC3F(6R;Z5Cb7fQg.&,.IUXRBBVET8-B>WY[A
\N@ND147#[H8/7[ZI.N1]YM(ODW=f[<]1?EHBU/H6R)^+Z9L)ED+1TE&WFXG;YA;
F2O#80QCTfO(+@JVGfUZ?=,YN:7Z\/64AB<J:HKY79>B(O24J>UC5P1F+&]&f34-
\4/,MYR:),+;7_gf4d>90(DX_J8WDNQTT)XM+WT[7g&bT>9.eS6D8X:d1WB8H/@P
N./4R?)I,@A3;WX&7WZXP33d(XR1^-cC8HV?LK,_ge<a4RAKIPc86(AFE^KM4E(P
(N,X3JBH/F]0E[UFBaWHN,]G>4V_,=-RNC_HW+HFDV[Ge0<_SBb/5f6K@]?2MF,Z
0B[TD;?L(W#E[gD=&.1S<#,:c=1,dA=I-VGeb0Z,?+K0A7IVO.6PAFS2D09#1G)S
;_e+YIA8YO&R=[RM&Y6-dM=4L_1?B23TRd7:WX7/Z@=[;N4(1,VCROXFOR.ZgO)R
?c@>=#Y/J627G5[).Q3DH6@Z\#JZJN2>@.IQGO)+I9_[Z\:EGA>c_J;X<IZL<d:F
>dOgQ9F-FQ,d]dc_6;T.LTYDX:O#L[/TDJS3e@D?e:SQaaRCa;4)8^ZYVJJ8QE\N
db2d0\.59f+SA.a(-7d6OQV>1Q&E>EEGH^)?0H_3NcR&<e45S#KeL\bRC:KeBU5[
KB4#CgY#TAGD64CY<)S25bA0VPeU1XgT=R+](X>T&:3HS[M35BW.c0f__6+JO6E#
U>2ZX45cXAWZ)f7?YMP>&fPJg4OafD4X6Jd5=37P9JfII_E#g.1fSJ6D5fN-68Uc
QPSQ(f_JWDL)^DJ7N\eJ74b(/IbP051K(@R@Da36^gXE3[d;FK:0W_5)1JJ]PJ;.
;M,GUBXf(2AXB?HdVN[V63L<Ig2NVQVOf@dK7)B9@FE@)PI[d=FD>X[Ag,N]JaOS
#a?MJVI/<4M,Z:WLJ9\N<^a/aUF5H<]XeN0bU+E4NSd3O,fOJC(7]7VE&D=6]S7g
8T6A1\?T9DD[Xb@OSG_)ZEMP[Z_^+0OMK:?.N?KXL22eJS6a5B]:IH\aGX5a0_dU
653UG:be4+6>Z;7-<#N_61a\8]QMD;)e0MfIBaG5EWZf&B6JO)X6+9L5S3R3T/O1
d=J_RS]4QT>^1?\KQ#QZ?H@\(7F9a)L3,DF[P-eZH7WSOSE4aQ4=)6I,VcD[9W/-
+<Mb79>+ca,T^XFBIL1.H?FW89B:;9S3X_FKK4,N80EDZaZ/@F[3/G\4A[8I5CF3
+J_KUO&E2H\?<2c16PJ&/X>_O:+Q7L+R4@UaAPN8?NMHX6W+>aKcOEg+&cCf2cd0
O2Kf5a5G>5=FFbDQeXEC&d\>@=N#YL\].P4#W@,Q6^3:[,]0Z7B72=eNRMT+W)4f
aA,)1Ve+eAaQ_J&D87V8\,e/:QCF9G?VG8T\D?I3&6L)0cI6>C>QQN6G,dP-=^#_
Q-5C9gg59#[=7<T9f9c6F3Tc]K8FbZ10(e8ZSA+/gB,B=af_0I@)2^0dbBSN:+.(
ObU/_,?9NF)_W.BD4_HIeEQ8QI_O;)6dH<Q/J8P3/VRA]U39g5(NDZ2C7D;9eG3f
Y,77FN@a3b\-\>FMSVGLfCU[c<QP8dfHeJcZP4:#VF/:3R?AS[eHcDc:SQ\4MF@Y
)-:U3U@.@aUIe,2^R/-H_AYSe82R;-R>:a_SIA.dH>T8#HHSDM_@H>:^9[9TMZ2O
gWg@a6R^a<;1:GNTT-#J8P_WY@6WLdT<6EWO)03/(_;G1;S/7_a>&Ng.17[#g(0+
S&(?M\?/\R>#K1N.B=a6K?D5_,4;V.KH(50)(]NdT0@bOA/Pe(X[:2L@X2SX5aQS
=MO+>2YH/5+Fa.G]/+#D:;@#Q1)&^VW(_&g3C+fUSa&&29BHT(Pb:U&K8+EOgO;Y
;2[1+0H06B1YaKOVb[S^Fc0U3P[E-K=_bO1d(WOd@2Y=^#=QAdU+]NE?MB),H8@6
?Df.7FZ,RK[^<6Z:0XP)OcHQ>2AU)-4)Q85IcCC5b65NC/MK8D0K<bF<V0B)b3AP
d[Xb#X+^<1a1]b?UZ&XXgBIaQ.:AC;caVX6cB9W.OWV^,dV9WDR=NgM#WGaEC^XQ
Sfb+T;:g;LeUWZ5JQTb[@&30-(.1^>d\/TdO,@dGA\&&.7J8LB_+_)]=.D2J>\cY
..#<SPa580#9M]Z7N27(C\()9&R_-Ng8Vba<c_9N<YA8C-T6[67<OKRUe2AP.;AP
P]<]HX<]W,VOa.Xd6?;Lb]@,&;.gVcJV@O]cf.eeeTRA]7\15=d7\T;XAQHN,A<^
ST\g>\\BK[2_TI;,IIVR2G?;2O@fR([VXK^7)]7NNST.Yg0Pb6)9\==^S\>V4S.K
:MJbe0:P24],Y)e\&NG\TGQgXR0LL2.6O:SK/D-Yc[X1N\37e.72bTSM(LfdgVFV
f0dW/Q,abOW/#\1WD190:gB0S76OVVERWe]60(0S#c0.\U.BdcQPg(a&a1O54K+P
5^N@,5?DV510Rd)QJ#HAI8_U8f,QDSGVH(D2NDK&gX,XKN#=\e=(KWNPaV0P6HUB
b8A/2&R]OL>R:\]a7L)W9+>MB\EKWG9a>dg2/^R2]BU16cdG/f?YS/f04ZAK[80]
QZP#:Z:RJ6ATK)Nb8GV_eOcM&GY#22.\SVB=C>=#6[B[U)=G]^e8@[TJ?9N/Q9a6
c,M@_GCMKBbH;g)EV]??-^O9YNdORL&C3E;bVF6D,(gA+W,)fcI\;AP]1:dL>)JP
JbaTOEO/[LYT84B75E#)Y0?-5M:__YGM[f>/7b,b1:?Q9c^E8gZBc\9<L+dfM).7
S84^LMdf6]NcHVAcKP(.AE?8VFA6VFY8[#e-=4[:,(H^3LN=<]GaRX1TTgN;@[8\
#F3_O-DfF&4bBT,ZI\ZEAA0Df01aa?D[13)<L6X&>aKOF3#BaA/F32b/P#1(OOQX
7B(OSB;9?7IdI5@[A5SH6@O3[2\NTfPbAI/3YNd0SJe\+1b>bTY0D1e][U+=O4&3
4-aU.aTfLMeLL]@.LOT,M&>^79<&]1PYLF_4@3^dd)E&DOHU7Y;12]F5ZUZWeNVX
6C5ee.G.^e0<<:M2T]CCL&)/3U;dGR;)IeMY&;MJd]#3=B1[A55P:Obce,5(F&A\
G83EKLcOEVCB;QeC7&c3ge3]5C5RLMCg.2V<1gER<5><a2IV&2]IW<IJFcZ#KfXa
\5HX@fbc,d2S>#Be&-Td]1/62Y#NcbU0VDcJ8YdVZ.g:-:O3Bb0LXSHQ@FR_2eef
Kd;O)bd4J9SR<X6Z77V+J6^&=?c6TT2@C^@VfC--?A25_2-GB=]WI[LTg]F>Gc^-
V9Z=?#;6^T<9.d[P5F\&?bgKR8a8D&JPeG]NG5BT8P9B2([SaUUDHf4UVf&])-G0
G><4Q;50CL\UU\f@<RC2U2KMc@AZR=@9O1ZMg2D)RXc0fgcZF8T#ZBPIU>A?8?gg
,OCK0G\?Y,34_ATg[S@D[AD>3d(=I^7)W2R\eDgTOI2LA6]4TQRK<#S83.3V1bX,
KNUaI7eXGC7,XF1>eZC6MB>2-6,]Z1c@-eJ4XfdKY^IHWU;;G=[fA3afV<Pd3+1L
D.60VBFD#e61^OeXB=dD#I&a2Hb=Z=4S;YOJ>X<:=[\_a.MdQ+I8?BSFcJV&>3<A
63&(:ZBTCT4L-MAg;,;\R2SZ.TO55,QGI:5d2F=Y7M2>7aJ7+J9)dT/]Mc(@[2QY
M&bUQA(:B(W,/F;[WD0RXJCZPO80[PU<6<)\E<dd7/-&@5U+C,RR(NN,/JJ]Y5XC
@aT+]X75@EW&YG?;BX(Za9L;2R?PQ=4cab?UL#_GAIbS7IgZ0IU_1)OA3<]53G)F
3C1/f2gB&Q?X3f1&SE]Z&-28U;AIgS[62ZNKZaQ-7S>a6R:AT,VgD1>dN,?9\bBE
_\&4_ZU0gaa(^K;P0NYb8M6-HG,F6H:2fg9RU]#+[_Q:d>:_gY-EYRVYS[ROH0U\
+TdK)I=CI3I,QFD7HP7aAe^:?@#1[S7.Pc/^&A.#fO;_A12>5TW3,<-K,fCY\FEM
[U^PY)&NM=HW^8RXMH+9aTE+1Y,]]AXa4\L7&CE07d_+=fUC\U#FVD.??CQRV0PI
]T7.ASF27Ra7WXG1C+O;Vc&VU2V5g3\]PMba0A9\e0QPKfA##LJ;+f^L@.Z&UR[1
F1aVE:McQI23?3QOf<J[T-QEZI/)\IefaYB^0fb]<3(#S@P#=2_6.EXNF^/A<&D/
@ZD2PeJD]B+d8KNL;gC.W=;bAfAaRAKL=9<G2B7\1O)DUbVO6MT-L)?d=.b?DU20
L6c/L0<G9He?g,3aA,JV-@X,\=fJ).7UFJX4D1UQ6Ag3BY,3c/@ab.2(Q_D:@<aS
=@/2TbMcII[c84Q7\VGVJF]Gg71aDI5B]dRC=eL;(cGR\I#eLgX)J@IaIS&E(Z9?
SdN22E)aVY=Kab2HYPX8MgIQ.)41_a;E/OA-gUf^_G8YPbL_e,(>1)BWgG/5NVTO
U=c-1-:.1]&e2C?:KU2+XB4^<W[G.-:>^]D@/b=6C4GXD<LNTDA0d8cKV\WA<O<;
S44:KgC#(]7NVJGb.aR?^DcB73Qb::J]U]D\980<PE3AVB9>P7,Ye2,]=a,ZMUTO
XXT,RURSJe>PQ]>3f\+f4,eD]W<YbE>)5cDVdaYH5D]WKZOL6<VQT,[UN7K93;^W
C2eJR^T[J?[=TKbP[NI/=;N+K>U8]9YMM+OR2/4:)RO>_@5S+C[(Z7ZDXa0_SNc:
O^]0&6N<cG&FRK.I^0E]Y)?\SLV65CDGY?K]eM)(-1<d@YF/VP-++TQ:OG]QAB=V
Q&57(Z);L^8;1IN==RFXNWgcg5cVb<(F0[PJC;7.e-1QfJJSbDE/ScN@0=O[E0JD
Ac6J8VgQ&:6N=;LK93V9fB_6MTC>IDGNdBY^Q,cO1b_V_C5,T>daN[Z_YWPc^@V.
\#1[U[GaE<_@#KgfI+TBEB53AcKWD?TS1&BCTCIF?VTG3F2/Q&=M6>5PFfB/II:#
E<XS<JbX_c[XWdD>Pf4WMe6_._FF:bSUM(<)K+VCN=Q8>08@]QEXPA7a)[;8@e#B
0SEHf[aP^GGdC-;B5-Pa[,#P>),_gN8,Y]a#47P->4D6QD8AV,X(RT]EOXKAf1If
FL>Dfba[;POROZJ/UO+G,37^W#6Y;U:[G7OAKSISFV_:,C8gIQedA6-c4G&Oc07:
N,&,/T9M<#:EP)7K-BLQ92SDI4a0_b=AgD/6840L:@BU>/.M(CYWdQ3CJP&?8:b\
CV0;@K0XIR_<C=;4:Wfc7P974_9#UK\M5P(3AeeTEXX>eHN.L+#b]\]4g>ed?-Y7
:dRFL^J/B)&)-D?GeESQ54ARLe,.K0@cP)4I7\Ye:MCRR(6O9VTb1&RLa@O;Qc94
-g0C_DZV#;MM@.3.R-9^2ePZQc-8&gQ;VQQ+9AHI<.bPLFHR0YB]?Q;(=H0AT,\c
Y8LF5[\gI9B4)dfLPbF8WG]<#bQO?F0O(M1SL1>O952b-b[/RPEMA3@N8.IE2#RI
YT[(L/IVMP<fYQH_-PXV>-.NA8b5ab[\?79Y[b)O6HI-U]GZOL31,aK#^ea[3;>f
=efIJ5.9()I(gc)aDV)gd_SF=-S@Y7=15RUf[H/55-Rb>L.O]BS::5gBb7F<]1G<
=ONH0MXZ[g)98PSQ;dZ&PD=SS7+,I=1T=IAP#F(]W5UfO7e:+a:6S+XN@UbZPXP8
KMXGOK5dE^P4Tg^O(M.9U@WM^>f/<U:+.-HD2K:VRP8WDPIC\Ma1U6Q6?WLZ7NYe
@+WIF3:59bH2g,A29\J/&^U4Ce0gQ?cOGZ_5<Y4^aFOB2_0Y<-HDV&KM7Qg5;93V
8Rg4_3+gac^Qe9c@agLX1BGT-NHB923)JN,I<1<S5\\J]^C3#G4M\dA1@1H5J0UF
TY=-NN]ZL.:fKQFTg1+HWa05abX)X(N,2_?6G?TMB9H+TT6?UZ0U/Y;>>SFeO.aT
T?Oa,:(#f4gSA/X/WZ+c,WAPXE3VfV-5<8)bcc(I-KLZMSEJ[?VJ0^SCOGRC?eNF
ER?OA(:Q;(eN5=>g01GFMHXN\I.C?5;WK\QZYO>_=CIO,_HA8L=7W77+g@Q.]\f@
9Wf]P8@gTLUd_<H-]5:M6CQ6EZXFeK#e\YJ6;eebfa8C]:M(QE-\MEa<7;(=(B]G
cIcP;<0X)HCLa>.IZb]bD1JMW]CC3)0&:UbI4KHN/adWE8f^=U[<_cB0SOF#f&?<
cHDdAcVWCN/,2I&;IYc<W^)4N/HIJ7TG48M)#AB@/cGFPL-Y[B-S8PeG(&E/_U[:
SQ1^&KDT-#0Xg)d;Q5d>8b0XY]N]10b-CP+6g/92&&2&ESR;Q<FG</T6Y3(,MJ&-
RW46FGK?S6;0CIRO=E9C&(@+2Jfd3c#a6ACZQ6fXQg0a^gYQM1=NWY_@JM/?42GR
))8<R1+<JH#2fcZP53B&ZON:K\)XPJ4[3#,\[DNff^\;&^J[U7BDg@d6PbE#fLJM
8ZW,@7_S^.Y=,.DL<A>5?XL3-,3If:1.2Z-]]9W]VAM\;A//>K^f/#&J5._B@&a3
B9AUK[A62]c8g&;SR?SYXOOd8N&0?\#P\HO#K/W4?#QT^dUL,ac7deS?1IL?M/D-
DRF88E)+W4(MRQ8DD5D1)B^O^X_ATO:G531:T<N+P<gW:J+Y(WZF1NDZ@]V9f114
^\LYJBRe:FY<.a4C/Vc-LZ]VDJI]]F;DH2I6T(g/X.&V]eA5WH<?5IX&<42(gf<(
WM[=6S+(8bXJ91E>4K<SLd(XJcfF@4)RZM#BK&Y/W0b&XS6N6N-W[V,UQ&-@56@a
,Qc@IU2FcT8LEa9([(4]B)HS];+7HD5/7#FLb4RJcX]e_\1L&VE(.QY-Z:]R>V4K
AQ@Eb^f9ebN7R?)T7cRH4#X+;,Se=g_C)74bSBG]:MB<.Y->YR3JR-J)<eYK[&?4
J>(HbAXe4MN8V:R#B=WVBP\#MQ^;gfXG<KJM:I<>>#HR.+=aTXWO8\AdGTP?OA>&
>2O/BI3_HdDSB\&Ef,e+AL#TLRf^_US,T_,3RVA)W\(#_YXFZA,5g=+>;QGHI;b.
VJO1@Oa2,97O&7=:#4XbE:L71POd-RJH[7M#e(V,HV53IVM4#2V=<BEU&OWID6ff
PQb(Hc)/AW501c103Z,KKB6faCb;\TcV+L4b@U8H<KSEWETaLT-/Y3[M2,[1dA_9
8-PTP6\[eJ0P<Ra\TS+e2^61Yd>JZ)L3E+?9\RYa3?<R8#GEeUQNf<=IffZ8?f?&
9W?6,bIB.(89dCZfNd+J]Cg[J9E15IID19-H:WGW0>;ef@]FPUH&Qf\eK()gM^ce
[Z_(B)Y&^Z55#_LcSG08(>QZ9(ZD5Y-=RG<0<GA88QI\E^TEVA7?ZgSXX9e3W9G,
R:Y#@(>S)5fO=)+D=G?@W)WaHGBbN#SO(_)K-:[)HgF]OH.^e>=1=[W<(K87X86(
6Y::9VSHO@#\c?HE2SSUK;U/SR;&_S8VTVRH^@f&)SB-EZ385.,T</>[W/2M_F64
\].^@[7X3Xd>bJc;S<_?HTEL;G5B8H1>G=LD-Ob)(bRRR]T\9O:L(VKV:&d@<5eb
)LL8>bBKV:Z/5)+3EN8.3<=E+1:L/0.]#aPJ5VNWGOY(154W9SYfSDY6Kf6?+E(?
99,OK+;VV(d-(>=caQH#YFSgeAB84OSB-DOOYZV7HDGaSJW#V+g1cg[]50a78,>S
VK5XG742686A0L4R);9VSCK;\/^1[Qa70@9/I\9KE\N-Y^5:-;0X\dW=UBPXI05=
,4+R7V?=1YJ3RP.7>>IF3XQ&/3-P[#2JS3=,PTdK^46E4,BS(=SNOKZY=PM?D;cN
cZB:>9/D-=_LA]G)=YON\PC^T(W(C[XKfHN^?MTc=+/)-6D&(]4^TQOTZS(CLKU\
6]GD@U\;<SDFG,]TF-HZ6b4V#ME40ED#<^CA.Qd>T=gW-TO@&)8U_UM=13ZfG5N5
=@B-5=+WTF96S(:QIeP/8gQQV@f)]V4-BB\VBfBA-B+WNU[)RbW^aK+/7cWaG-L\
ANVb1@\=g#FeSNX\,):E(A>QDFb..B0>Q,MLKB?MgB\\XVF-&bZHc21;3?SU+CK>
:6WROPOe.7E_Z9C9=9FA:a2M>(W:#cK-/9/^.a:))/OQ#c6^0^H-B\dLLf0S4D/a
,UVTYa,-0GSMB(=92_,L12b;Y]eV]g??8,cZ<\9NDKUU@Y^cG^@IHV9_S^U\/#Y.
F7/AHcI0e4)OIWfX^\Hb.g]R3fCe+c.M76SG4RK[8CS_7V8Y3\RaKB-DSO?6ALF3
Q6,:D505EI&c?GePZ2JAH-?SWZ-8-1Q&9R0TDFcNA(L;4#G[MA<#,87;;=78fb0B
Z@8cC2/WLYPMTYa-=S67[#cg>LTI9Z4I),]-;5W)YTB+AKB-BZB-2[@?OX)YZMJK
S<QU#OKdO:(=2QYH7M)FF,HH^fM/C/=].NA(5()?+((Z(,-0#b:4#(-8[R8/ABGL
4/d::1FTeX0R5H,;Z5V#O/7IO8QQVUDL\F17^Y.WdC3SeP^M=F3X.M(a01Q2fPSd
-/[<7/OX@dBD2gdQ<L9QT7SGW/MY0FN=0^\,YQLE+)HNA/L0a5SI)]+f?()?J^Sa
T&>7B0ZDD6Q8JXb4P(>J51RO@_bJ(4D2fH++:DG#agVb&eP3ZPe_^He/b_fX)TWM
0dB+GH2JUI/(G84,RE-FedV9NV#e5@72b_eENIXG?[DPZ;S=QfA388&V\XUZ^GFC
Y(R9>d:abFF6D)D+36T.BT\&)YD8XEJ.NX?2d/D;IVV6+D@7-U2]^[/1GR_\,NX9
]<1UfCIa9R,\866T>Q^/eVNE@QRL7SV\>2Zf3B3#)K292fN^D_P8^=X8-GZZP:]e
::K)/OLg]\4N-QK:8WE,cWZCUDf=.4Y/C8c7GC\FN4a)4>7B(.THP72ad=CReI7A
/[G^Q5\,g:OBU\,F[IE=1(G]RD]5DDLFDPTY]3<?3#5OB:2R:YQ08Cb2#b4[WGV.
Z9)X2)@_aZ)gaF^6M98a/<IM7_I^G(Q1/^71R(4f1-aKXdc5I=7dd#^c/[B63.IR
25Z.?Z[HeL99<JS40e6.K&+6]#,C=J3WY)UQ[-YZ/L2_G(\ZdEd>F#:M[//19BQ<
9e,8cX(916L#2_O7_SgB7AOQEg/&1c=[:e371UU,PYg4DT2WcC,,0Z)CM/&63A;2
;I)60:]bJKEVS/Y?+M3I6=.TKZ,#WL40eb+fc]Bf[XQ<5PS.GG&RA@P.KT7<XV_Q
V+bU)R@gaeZeEWHfbb;5AJ_LeI^/Z[#8^fdJT:bJJYT;e(.ca-\fIJ1f-U]JRBDd
2>:=M.E7V/2aP<a0&-1R+gU9=Q6,&Y..^VZ8K6WN#5XFQ+:AADV2gg-(dGV\+XUa
C^]<dUb9ND[6Z@MUV#RWI=[5:P,VU=<JFSW=f)\/:9JAO.>fP-Qbg6dIS>66VCUT
e3B/RIBLeFLKEO?YQKdb=(,^)c&)7?M1-?MgGW-eFD,QG#f7_B&9&0XTR3fXI#+O
D>Q;B=]g7,fRAW89e]WD&FDLP(TV)P7T883@D7@RHQVa#g/Z:eL)S#L:B12\,S9D
@cYGRbXVT_EU5UJbBe\@:g];Y^2C87SJ@\?>&TX@D?e]U#D8Y9G[[MDZ4;Zc;OV5
UFEQd2H1WJJ/.]RFYW-.4Y\9c03:eAP0X24[UBc[D;<@de2+\LJe(JS2f[#BQ?&b
8<7KfA3#&#561dOCObEE_-=aYa+.Ia[F?=G;0X@(#=VGbJ\C\G09B]E7;;G@^5+X
5>60g?J-9@=LGR2O_:YSEgMO[=7Kd<DGB0/Q)Q/I1]Z032/O7G5\S7K)X@>\J9ND
08]?^?Vd;=^\&8J0[U3f+e_J=U0_HNABg<1Q[KV,933REYCW[K>YSE-OZ;f_S:\W
,UJ;4IJ3AS<YE<1UP=X9FMDf^TOP#eP+f9/;0L:A0O&BR5)9BUfeeO:]IS>;^M&.
6V&aM(AIJSSbbCCf[4edY?&ZWO>SDC9UL[&d+Q=2e+QUP8aCLRCVB0N5&RM;Jg\K
d<[FV-6Q_=K=[EO,^&>C88Q[ZRAJX)(VKXS>O5Sg:CT&^K>\^IO>F>.YY)8,=(>O
Jgc1WaeMLY7NC,W4=I2-Ka7a+?Bf::A#KU+;-75([R<3Gb9;EJG&_P#S)YP9CR0>
_G=N\9RW+GOe?Y\FM5&WcX3I3.L,<#J=LK6eg]_A5&Y)-^5YI,;R29P,bW6OB+AP
YUERQadOWL@=8\.2DG2A;T4I,>--UU5O=14(H[5#O5/B8Y\QQ5#)dNB=T=bF6Jb<
KVUKIcL8MZ#W?DRF]T-5^40O]GO=C6=#OTD0CI,ZWS[W+XWJcVGC]WgW,Z7M39a)
gWAOJ60Lg[_.D:bJ8LOR6a5GbVdK=cD6,UTI;e^5Q(\W21KGd:-_P<=R@/V#J0#<
R<@9D#N@4Z(.7GH8^Y41eLQCT#dT&eD&_[T<9<)A[KLU<(W:B#2E4V.#d=c9^)(f
37U2?XQYL)Q?f8Q8,cc=d>-DEOg9EdHCJAH8W;K5f#cAaT>F02\0@\g(7V6,]TQg
&)aB1<MP7;:TWMM\_6#bfNa^WOKG7c::D.RdbQZML&^LG1NN(Y^X][d<F@P#Ed/8
E>#]V]I>W01_d;b<(3.Q,fV?a)aZcTL0RNH9QY@fBTM&-C0-(?7G)DEEQ7Y#S[&9
IXN,NS:YG]ON>E\Ig7@;3EMa/EJF#YU8?GbAaPReKZ6dZe1(6ZCHC/]L3B_?IUFZ
P01Q9R)C03.8d]ac]PIQ0(7b-9Y2[/=8B->&U+\(+79a@<C[3BfeWCY;E?>VJD7;
YI,gL?5cbDWA2;SJXGgD1ZG@aO:SPTE[<5f,4Y4daWK>]<G,eY0<N\H=5A>1;>9.
X)0gDZNIf37I9-#V>N2NXYcg?KKY12gR/-V<L.1+gU-f^b2H\^f[5R+IRKDZRb^d
NgIP;&3_5g/e@B]Z]9QA2MBKaB]>N?^ZW12M?[#>G+,8KAR^8/D_M[F4A_>fFY^V
gGgEZB[C0]0.+R5MA9D3U0=?\?=B8)();([L9>ZU,W(_@-7D2H;GK/CQ@a,#Q[4)
UVJ^;2X,d\b[P)-X6?6;OSV]bHKbGQ\d,8QQ>PT2]>beZ25./)Z?3L&RGU5W-28D
R0&P#]<?5-JZ786(R1\DJ:Hg[@E2EAcGb38@g2@eC@I95E40?8QY7A<U:NE;-RK4
1d2Z/Ta:[H(Ue6fc<R_a[]<H:dE<B(S^>C;SJV\F)78RAUYDDP3T-]XJ/K(9c2_V
PW0F>deL08OZ[Q_]C;d#TC)&H&@g&7=0X6&7TdfQJ]AS@)<;[/b;PLZJZ<MW1>Pd
L6HU-NLKO1)>B:I>_=4NYe3eA0Q/38+UMFaT^_7V#KK(9=#H6.M]d]a0.XFB&-4+
B3&D?0BJ[R&@b>TND+YQE6gR+MMg:^f0@Lb@^&_&YEJ.WJHOb1-S<)1>RW0A+<cS
^)3T;e[GP9X2KM].K@_AV48bGEZD4]IYXg1<K/ZeeTW.UH,OPaZWB6>7Acaa6P=\
O.XR<ETcM2))2+]7WDSV7L(>.5@AI59RcGYPI_9F:^W@63D_-OC^>LdeIA5AZREC
#.WC3CdZ2;6Q5GHf4,]55[LK/92,6,LOQ-\^Vg.a+S]-b5E;MKETM>fAMGfQ.g.E
\M-[LcRINHdP,OHT4FMTg4[GfPJ9M\eYCD\<.&;.;Ae-[T:BP(+NBQfb6;BY)K^V
L&,Y-JWRNXXb8JBMf@U42f9I765+ab:OTWJ-)b6T6WF?OHaCN)[/F<Q>7,NL4>O_
J\-G/Qd1I]ce5Tb6\WAAB0@e2MfMUC3[5d+1ZI;4NG_3TGJZ^#BY.d,(#TP;L+\Q
:_@?-I+;3E^+;/SG61-5NHe?QS-7,PYTJ>_<Y.X<4G#5X[:_dc08I.H=0G@QF]D9
2Q5@75?MKIF-UXWC:afaP7;)?EU#6QgYC+;\OZAK@:)/f1fSUFY]H[MIX<cTQDFC
d&SO-K]E/>8U7&<Q3dG1;&7b<M^E]URWgP1fN>VSO6[#IAN<_73AX@?8FM1M/7=)
dJRDX7Ze#4c3d[H#&CY[^JaE3V.1;d0e3A9E(,226QPX3DG.:05,A1I9WCGfU\FR
e+>=<WR0S6G?4g42,(6X);@1g3(A0>e;.O\f:Y^J.Lg9g+gW,&CZE81-UTPb<PLL
QX7@a4B7]N9I^BdPCTEK(f=S=])]_;JHGcM:,]g6_L@gc]7ce#\eHb1E8<#-P)[(
dMP?_PP82F<<S</GW&CWWWb;Za/(1BS@8>(J2:BDYB_KX]K/WJWZGC^J,S0,dF/A
)1S/bAKdO,HPaYOK\?KZYAg.NC=45beMDC26Q6PG#,)5@?bT?K1NN^X>fd<F4fA:
RLf4[03ICbUS1NI<:92:fN,9Hd7XTaF3<?V?=R,>gJ-[e+V.,X@?O>bAZ52RWEM_
)4a6QeM6\CeX>@:Q+SdZ8=4?^a3<ZU@WfR_GDgJ@&][&dfeTgNPE]\.=AG\4LJ5N
CZSN61N1\>E<@]<6SEd5UcT]deC<^aO8d-8Q1Pa9=5<WCDAKZ8WG;EC;)6\YG@Vg
aCbR?H,RTW?7@T4g@W,:aX0V<eX&RD+01N5NcH@D4[VBN=c6>=Pec/D^IR(-e\5\
P9cc^J27VQ):<,&b(&<f5f\Z#eD]915f)^O^GG\>eDfU253?IP=:KU[^e,[WA@<&
?gA<g_]-Y?-O608TD@.(BF1CY=EUN(b>2b6V#KNN>bV3TINS9ZZ2(WcCOe+dESUJ
WRLQK]F;bP,C/NA^ZD95&+DdPBYL]O2=?IAH5f:Q?R\SY#Q1@ANeHc#BL5>/A5;a
g8bTb-;D2)a/bE,[7+F#A?IIKe[B\(,UO5X@VL3VV1CKb\K5:gGS]6;4;UH_aKNZ
TWG<\K]CSQ&8<M>-GG_8,d?#gIQG53JIZPVX@_/JMYV@\><HN#C>KPQCRF]G-ENX
.56b4>TTE]S8?&eAYI0-[U;O(S#KG=/Q_C2Ud,+36M.75SMfV92,Nb&ede:G8H69
O^2ff3N(G12I(WN:2=3UN.@<92.6gE<SF+<=J0=\(^ZTA33cOM61D+_geK<f/JX1
Y;2c-YZDNMP#;B-NH#8.1Y+G)/];-KV<;/F-YHgfJ4BEe[SaGTb@g4HZ(a/@RdFO
\5/;-<S34GD@E.Ae(;=&#AK;Q?EZ\bXXL[5SZ]_MTfdB_c)4G._O&PSNY4P&^PSL
Y4.Z;X.8)G9daF\MeaOH1DbgHV#A@>4^H^3_9)R;J?KZ6-TQ>\\/S\[N8a^B^W^e
9;g/ZR?DSZXCMUXL^f&Ca][[8g&Y<TT#0HeFXDCDfTV8<Y;c5,UK629.,cPI(]8I
@4\]e,D33?UMaM0bU+EWY+1McMSN,Z([UGYfOJRKOcI8H+E2QPCc]421Reed/D.1
YN=W,FL6ZVF&B7E&/7RZ/E0)_0U69CRGHGN:d<JQ1X=1TA,_3gXgJf>()K<DN)Ve
4M[4ZY+9DP4;CTU(-1]IY(4TaZc,M]GfY\+T[AfPcL,#@e<ZW1<[94T#>LJ)G)Jb
a27EZa3&gO9?NZ^\4Q->(YE5=37Ad1(61B]\/-Y[G;_@]T=461BWg7TK/OD>[NR=
Y?_&RN8Xb/FX>.Q_KL\,WA:GUa6d3b?DR9K\fSdFe42^2-K8U.<38GD)JgcZV,0:
+NcFBT5AE_9S6H4a0/6Pe>/S=D?A6MF@;(GEUT[(HgS0AFW(#&QdUZ.Z;b[&F)SE
=?c:8ef)6?/CA[NO;FIM@6>&712^#H^.YL6d.-eMN(RNR:-/4U[[=WC;_&)#H6>Y
_]^a8[#fE5?YDbR2b0OV+A8B4TP4.VMf3V6\Yc_Q=SgO6=:W4fgZbIVX)&6Gb-9\
H<)TLM/.HD3N[KeU1E<Fg]X2EF6)4CO).89?A=8/?2RDU3I-QIRR4B5XG#PWB^-<
HfA/ZAE)7NKM_Sf]FJZKD0?;_MKBOgP^F/#a[(:EfS+R6Q3a,?F8/[#-R9[5b#&&
:-4TG5BS-(?R2ZLg/-84B@F4S6[@D&(YGI+HL\#7>G0NFK->7D8bAe:J3_fFW7bc
B\R)TM0\\-3(LK+/=N.dO@<0:CU,.dP5,7OVeP@bAaAe(b3(:QDC02[/XW7M<b1c
S83O8RL[QB_.5Xg9)1>VB,5H>J^bPDEWA-EH6O.+ZM6E);fcVc5_8/W5IUPI9L0/
&Y1PQ;SMNU^E:(U?\YMZ)>5=b/BC@OdWT&F=5NBVX:/Y7;9d0]f_L)PKSCJ=SF,T
_EH0cY_c[TM,^-c]3IFW\&K+_RIc/de0Pd#V#4APJe0A1?Qe>U=94RZ08X_2aGf5
&gfMaae09e9QP]e(.&;55-9dfe__F-+3<:_bDS13#Z3U8A3GB-KAA)K-PLNSP>I[
K&^L[&<:6O(9=0.GZRZg2XC++&Hb:-&B-\^(VDK)<W&aF&;D-NY^)@>O;]-d6-BD
^V&=0;#A3NTK\ZQ2e((XN_#g,)Y7,UA2a-7.))G[Q]O#?#@V>N.4a5)SS(\5Q4=F
eKG:EU^SIV:H3QQRDPbB6UeS4UEJ/_791aQ>B@V&CC/PUN.8d>2>2:28W+Rb#;DL
31Y(&gIR@X<7LXf4YDa2+d):_9F.Wc[KY1d,-(DSBC2,0_/Q>d0&^O8@O^WF7DQ?
8af2T<RT?U4V8:]1KT\<I_37Va7[NfB[.f>64eASAI;Sc7O,E.YK-;7_RdHC[c,(
_Ed?=CH88Y8bZJG,66VDF3ZeeMa,dY3[)&abX,MXV/R_9<f7@R2B140\8D9E4>5_
Ba<YgUdU#U::EC,=:6_]5\Bb1+4Y2@Z1S1,c#d6V1G-S64BJ7Ye,P8E[gRXK--VB
X[)R?Z9dM)[VVR69A[[0EM\[[b5^gBg-O.#7X:RG>9>fW7cc<g=cP1?X2cAH@O&F
,?JSV]UMb\2cL1YEFNE+KN-Sde@(A&dZ=\M<bbMY,7>eUAT_6P_.STG?eU6G3Pe+
?J[4YID\c==8=S,<6O<-HBgA(-.^5I;:N^g)@FQ:P,HgV;D56IPZJg_XD>gbK22>
98#g#OY7U1LZWY;=3-G.+W?3@+NcC0@=-9bODKWdaR,7Z,](:G&KH89dO4\1C<:a
Y::a#RR87/7gbd#[S,\#]1>cgK_+aUFL+LQLHf9+-5F..]PRTTeMcZG[OU9:Obaa
0(VPFGQZPN0(Q/T<3Y]4RIZO,@TKES=+G5>MNX&CZC29T=^DAMM>7e+USN4U.f^g
7c7.B^;77B@6NMQ-XIb_IN9BW6[2B#A=1J43g[YfQ8GPdPHeY,[a,fE4((aR-SJb
TMIKa4gU9(f-L_=BGE76-P<@26d38SPEA](FMJ+TH(EHHDNMEgC9-Sf.(;d@M<;/
H:+&EgbK^c4)7B]b<OT,4C11R<H=09cWJ<PN=e/)e[.f@L)@81CfWg28>[^592a?
@DCPLH&YXcP_7B&<(C0Z19WQ>(#979EdB/<X>V39V5UOQUDBIR/f_NA9L.U;eIKc
1VV8;.84&X26Q_CcWZ?<.DVZaW]CHCSTH3PHc3;dc;dTLB]X.dXFZM:V8)6b1V#&
2B<Y5@CH+81.QQFB?=bG4^3a1gGVJef20TNaOHfF^ZFR1:G#9_6+/g+7&XA7HRT0
E,aTX\AWA,)=b8=>Dg_Y.T8[g<)?04@I<gO77+MX/W5:U.8YZOf51PX/SAIJ^M])
.E6]2D\N,O)X8R/CJf0JNUG?/\2d^Y_8G?e6bTObP4@82PV^;](KX+L:BTZ>77#\
1Z15I+BT.3OT6?>.W;1WM#J/-bN?,DCKHGD/1)T^R-e8f>Pa.=&MFg\[[#gL?YLL
UTa9;fS_,JgI.cXVU?)4B#gX^LV]^1e=X#^C?&KQO07OK8,fL5)M0TB3KZV[CR3/
X_0,M3ce]d(</@)DA9\L@,9JIYC1]DK6C3>)QB4c;5(gbc<3A13-,/6eF+SR-MAc
35X#5dSW&+MQ,H@<(#bP0QK[<5JN-/6.f;IC>YJeHVSW(_647B1G=.QG-=0feTP^
X:S0SBKea6:fVAH7c-a)]J#G+4OMa[_b.E=A\_)X8Y-:6]VH901ZY2Z[=6=W_(S4
XCSBM1NKS@[I4\GFYQ[L)@c]eQbZ6.-YXOY<[Yc<GLcdYCVYR0eH6J]g18DcG51V
YLDLD>UeF-6dPK[fO[9WD24Yc&O>)DE(9,_O_Mg(-V2?9U&/4?Pg0Zf^f-fTe^,c
I@a4N\(:)_Cb,HLfg4I1>\M3E\@TF&]1[STU8D9b/EN,_^a(42(d\7T0E02c,[+Z
.Kc;M11L<&aA\H@P#[aOUX0Y3E8BAQ1D#W7W>YJL7VP-=AS(,CXQ(<@:1#3fCO3^
?]0Cee&L6<N5(d9eRTW:cW?@d9K:IG=(KK#H?Xa-FA(4d:,:N<UaAUOYS7W8Z<;_
5E1^QaIQT3;J\2RJbWD#PPJPD3;OHaDC2A,?GCNQZ9QII4OaQ(0W5Od>Ka=FB665
/]d&I>VZH-,Ua?gNb7KB>A#8RXM;G45C+;WU+4T(=#RZD:RN_d-.I5I2AQ0FYa9?
(ON^(R==MU;a1T;&\d37C9W(fU0?U&\>)Y>Y27=99W/679+<95fT]CA#K^J0M&cO
[eMB<YPZ>=)[1(L3\DeI5OdFA_W?<,LVJBK(6A7g=3CG&bb,H>?(;0BVg^]3PI;<
@++cLWCL-fg^J;X-d,+I@\_@]Od&,f2#T&+YSe#5T\(>6AZ3Pf/]e\,I^JO(De-Q
NA6IUQL^EPL/02</CF+#Y6#H85DC6RCIY,Ce.(^c+fZL6PQ2(eaf<&.O<V/5aA3I
COPO&#QHX[[AS3eHG@9)&GC=_UHSH/HH,AAgR<B<>356JK8K&=W:2Z=Z8^^.CFWY
H29QX_(2?feZH>JUbZ2COWXQSNQ^4/92:4((^d\/8CH.:UcDEGKI2e0eZ/[\;HI_
QR<0-33^e;S^48RQ3fdG]<W48=[V.A.[E5:RT)&ceIgTCR2LZ3d@LPA4U=#TB&LJ
?,;C.P2DgF-H]0?2OZ2c]I</F.eZT0Ia(dg]e.W))DEYUf^<:>Q<Y>MU8E\]5b/3
1IffX(W_OG-T@&4EX6d,\Q1S1T/L>T1PVTA/<G6?PW-Q;A?5Z&IOO]XQ.O3cTYUT
>3?V4Ne1H@?0Mf^PK5G?_.VR)5]^J77#e#S<&_F]G?A#fP.6L1>3#<(aUGMV.4KY
CKKZ;c]#D4:fQM??aFE+0L3L5RLTBaBIRQBF=&A0)?7VaP4<\]R]3^,GgTNL<R_g
N.0;0OY3),5)W5:@D=.L[&AZ_g2O1dDN66X]b(?eFd3a1Y&(C879dZ.:T^9N^;YS
JKI>Z5.683S//=)F9X@VR.MC,^(]_@YRfEMO<HN.TKV=R9b]5NGN#G;(_T8S_#2R
OOBIBDcQC7?HL46]b&:V.18Ca.L2e^JVMKSN,P-)&2G.&X-4UX4_/d0A\2C3f^B7
.6R-aS?WgAP?KMXFK-F0^37-XaGUKO<Y^U@/EJ/TaR?S)/]WX66W4=[P+?R5^U88
S)[[T]Eb(@XQ)f:KLZ5K0J_5L=(.?X@>Y_EbeZdFH;MJDOZ<eCP@1N[5YYRJY3V<
TV@FIZJ\X-.)MbbR+KFJd?>QNGFWJ^C(RX-6e\PcJcJF#0C9d<e7@M=U9UMOE+J<
ZbM5_L,^&OY##[B:&CV7N+ENO:#A=L1EgbKA\DQG+WM_UKY/56[\@=F)Y@01#T^B
WHDWQ\7+&)\]4EZFf]Y,_2YT?<P&IFO^>V,324[623\g/[@?#R[0LQe&/1TMW)-T
&K@?6)6257-)T\9^N_T3G/[>:cC@ePGE?_1,AIBO8d#8Q=Y.DHGW<847[RGPTfM<
dVP&KM?2K5&a7^XR&b6Z3&1bG+Xad4a34N3QL4Id54UEW\Ng,XY.^QTM\bX-Lecc
aW<WVJAM;XeZ0K(YGeP48.N\@P]A/^?43E2Ga@;a+O]Vb]eFE7a1:Zbe^G[72BNO
^a#\S7K1Cg]WNIc@VCKB^9U?a_^0+?GP^@I^UWF@FC9)L?6Mb/EGFD=H;RHPISdN
7S?8B:5WdE,X]8T=-,W85F&LgL]>N=\CZ43;]JH#M.(LT8<>a_-[V/T:f2g5=T<[
#D&d)#G]eF<-^@&:fI_aQ66gfVf;:2cPC\#RNHS2SE]2KRSacgKb2Y9.PfS:J_6O
)OR&@f3CfO=S=Bb;RQ#X7Bd<8JJDN0:eX7EKCKQ8f6(Q+ae/WNIg+WNFKW<g/,_S
4CFT1>B_.(4]A3&\?c^?AWWWA\?OI>>;2ERRIg4Q[fF24e#e^+FR-c&/-cJaFG^4
Y@bLPG,CUeA(-U1BL[2OD&RNB##GPH\P@PWR9WXfg>6J(WagR<d\L..<P^13YC&O
6UFDgH@7IfUA<>.C:EWN2R.6/E@6g+]TF:Yc?<C(IZL<CaEb,.1?gQcQFD6fHA>/
29CQII6)7[cf?AC37D991#a5+Of<9@L?YOJVSfb-_YI51,U-T-2^5Q;;EVMWB[L0
>5:=9a/XHd2@Va0e?<)ZGReW0da#D3\UJ<&3@[H5e[&A,e22ZY90E59/W3X\8_#3
e&.fA:J,N\-O@HN=2CBOLN4;7@()TR/H)9LVE\Y)//@W_.F)=g#aS[<IT(:W/XYR
=c+EgG2add4e1)dfF[<0O2E\D5aD;?,X;X(3?dc==/\A1gf<dU^GQMFEg6,?9MB<
,DFAHDM^THR#)RVEf00>/,QG(RUCeL&.+R.725VFff&7>H7fd:=KQMPV_&U918R@
a^[/7:5bdaAEaR_-?;5YTST96[CEYa)[P47Pce0EW2cLYc3JgJA9ReQ?)@41eVW6
AL2\I6FbW3N0;+93M__cGD:HXPccU_2NYWc;<;[OX:?Eb18@&93WTJcL1c71I_Te
3]:Ug&\,QRZ7P\e+7,WYOe47144C8A(<?^gXEdQR9,4;^M]F;.?4<XZ8.:GZ&68M
3;9]MGFA.\FU,4TNP=QG7OJ=)?5GEFTP+35VYLNGH7Z,GaL7X4PcTY###7O=M^RD
M5,0ILV68F]+#Y354GE=KC5d@FIPgCRGIcP84V=9g-T]2M6_[F>cbMS1\.<.=TYZ
Lf2/73S@?_9bG/N.7\5G5>^H7;?eJS&&MYZPbZ?E8A@X=LW;(8])32XW#E.<fb/,
O1YC;g)<[b(JfQ/J,Gf7\4eI&<KB+TPMI6APZ7O=02\:B4J&[)-E)OP&=?-=_OdW
YP>d8[(N5M5Q;AB)3GdG1H.B36DDS?UIG2A\GfU9\JT#LXT07SI\7S_3V[D(?:8&
#.RO^ObW[5FN6dIU\^4>If+BWbbX[Y8^:3)Y/5DE=d=C8_;bM\=(PRD/R,(N5=A2
VXUF1OX78/eg(U?-.R_)3UGNKb5)2VD?@IW7P(fH&5K9JU@]UXgBe^B(+83fS7bc
Y6P>UKP/.V5(;]ZE4S3M^N,g+25:,3J0A+D.>V/+]g41N[_V1SeD/AVIL.D@bMC:
[/CWX#Q@^IQ&))1D4)1??USIVVDJD\@+SC7/K9dLNe#@D>(;8OTF7O/2b8>AF)\[
Bd)4Ca5GV3aWT@BTa^1#GCM2H-cQWW/]cULKO0f\,eP#5UgYg+ebZ?S#L_5EfSZ/
H?fICR]43+X@KYIRMC?-2Rc)d+O&T:]+#0a^Sg5RcLeE8[0#(Na(9dC0/1<&UJaf
YSF?:=faIV6eXW,F.?OU[[dPV#<7D2):PRc(B/-I)a?VA:&>7;Xc]#:9Z\1XEK0_
?6IM-<Wd.DfbI=YCdCbVee,1B3@IC69P;X\VF6)-XVSI[K5efMg(_UPfE7<S?2I-
?Y-.J755KV)0Z[<NJa0(b2#I+KXZDg>UJ+eM=J(+,F12&A.2NM-M,RSXVB4UDZ8e
]RBLcIYTXL5d4@>.^aPZ\B:=>MLaVdP3AH8CE;A72T0FO9)3D.2gBGGU=S76.HFK
O&P06^OMfM\VPP&@:N8CeFX2OCCINC4>9M8)#^VaOe2G1-;N,>?#1:1,/O3da(F[
^XNQLN7H:U>e60+@&/T(NIA[H9W4;0ZU(T2MAM<@Y1cU+N]X^=gYD7Y8#>;I#4IR
P.5>.D.JST8=G@A?-H[^d+^&gEAW1/GAA8X:.@@8WQX-M(Q-U\#F7de/?&Q8A64N
:?1K/gc.c6A\;&OCDUGYS9XL7GC7NC3YZY&FMUZ2X9c(HODE1Q?@UB@ECIf_DX<]
#\>6R0)f)V@/eFMRXR+_&ODb5UHAUQ]GZ:80;UP1V3,J0KT)3g>b)7We0585a0G6
\JXSQIQI,B=-gfB.UgJKUDC#e7L5F+faI-9PTOc^g/ab23#dH9GKaOPS9?NTc]\_
eC8a6UbOXUZEGMF.B@&E>H;fc=27\?VO?ddSGTV>;2@KgRW<A&SY2#&L+WgO\JK>
+SJ6\+f2e7X#e38F7P3)I.;fdYUX2&Q]B.-XJbV52DQ9dDKO?F&MT\,XdZfJ>bTG
M-Pc&8<R[?[/TXY^d^LY7C.N+2UUa&7-dA4Qf#8B66P@QEK+c9@.,I?)U=(KF,)C
D5H=/#RR?>:68.X0FQ_gRT,/TS5V-9##DJY@GQ1K=VUa=7RD/,?GY#g05>,6WbGF
3+1?&W02cZ-A353-9M)JFG^[FI9gOa4;SL;^^Vd3YBI(JIP[IY0N\2:4&)aIZLeE
\_42d2QUCYMe=2:#T37?TES0fPR>U5D)QP=2\9/VGPT0Y=eHJ>J<BcgJ#JK7ce;4
a(\QBbX:f&_<N#;Z:Uecf:00TTJ>0WGX+[1#E2IRc(3W>4II@96]1?TEHdcc?Q\A
9=;R:I0M[/aNPY6OS@@:D0AgBRbg:7HV&@[Xg+X\2&8LBD<IDH_0S:Y.G0\:Ac;S
6N.8fcP00O0A[=c#X=@,TTR6W4N;E?Z3__3VTJN5&Zd)=C52#]EUE7:WP_f1;B/(
OUTRaO;a@]P.<RDK[0P4_a:X?3C\AF><@NXM3;Sg<[4V<LR+WIb^LOa=&_A=aV+S
D_(L3;56X6[3\X_M>c@9=YFL;0fNBF\M]]4[^/6SHB@&\K,@S-9J,6(O(bT+7K2A
Q@?Q-&I0TR_Jf\OPfDJ3H,[WYJY#,5&DI_S@-b\A>ZaH/[19080(8f[6R@(3Gb<P
M2-BD76;(G:LB7fVKON97?0Y:)ae&5#4-JWEOVC<U3P6?M3,K:C^a:FP4-Y?9Eb>
J#J7:69P,dTDO;^L[?Q2gDOI/g#EMB?3+If-_D:TIf<]?ccTbJJDb/F/K>e3??.;
3FP:LBd7g<Pb=Fe2:A.(\S1\F::=?.2-8XMH@a_(7UMQ;gUNX-3?TZ[W7fBPX[VU
T_af;>FBZWF.US//OJa/G&;XA\f+@GG@A^bY-O,G38gAZ-g,T:#DMW9AOFOE+98E
2X_Kf+MCQ(I9RGcZ5XHH[+)AfKGYS=7d9:2UU0\NO_&DZ=0)Q^aKg,43-^:H2=<f
4&U=P/&W&2[=fJ5+\05-O].5YTZ^(L;cV[)8c9HU-LZeU[A=&1f0)G_FU>XCWWH;
aR68[1DJL<d+;.YBE:fggb)G(T+L0BBB&?fb;,\5R0LbG<ZNf7a:/XTYFeU&^,f]
GCGaL;N+\g<aeNRISeI4[=g4<(IaY[XT,.?A8YS@02]>(/255XRW<AF^\BC&7DT5
<4e=C3HO0=3AV0BVTWEQS28fS\L.AUDC=]\G(M8V\CLbOgBFFTE:UR+XYaHP([8A
dH[79G=K&J-fOR[a1f#BT)OYW]JK\1CCG&AD9@\L4MTEU=>B69UB93@A>#C0KNX]
AIKd:@Q0+ePZgXB.MKeUacTW?&U75O>+A\EK;5g\SYX3TW(GXS5L\G]IRK<U[IG]
T&2E-S3UQ@\?4OTf5UQT9fggCD4S00N<7N=g0Q&\HLWNBBad:Wg2/\cWN<1>PUEU
U\#aDK&-A9)1#X)]L08V>\,#(X7^8+PY,<RC7SY^5]f1ba7b+1G/]9OM:HR-XJ4]
OPO6YGc@F.G3V?XXL5K5-<9FaQ_KOUG^:WCC/TQ8FY<H<K&^5H+(3MCbc>+:Dea@
OE>4LC25Vc.,?LLYHWTVM0UJQ#F&?(B^;+Qd0bASJR;JL7)Z?V@N^f306H=.R:-<
/&CN<8#a[e9CKaRGUFA:d=KC[CEVNPE.PgA:Re\P1@1-Y)+C3M:==gba/1P\[<58
:9BV<TGSf>3.TB4&U4_.Eb^WD;9K#_8VK>_Pc48a(QFP[J1?RZXgadK4FU.BRX=D
CScTc6b,<OV#(-HQ,<9W@G_WH@1)PT2MaZcD&(YV?^4>faI&LX]C2;Kd,VaBBfUY
fSM+aR9[,91+C2=TTG/]I1\6f67dX_^8J48=GN.957HA[eB;\.CBPb,C5GQfTG[P
G56,SZEOcA#aUb]50+T>07\C>8<S,(R;,G5QD@>?DK=\d[T1f[V,1<9[U-EW=Z[C
gA)XeKH\;+:KL+0ZYXI@2LcO4;G\+<Af==8A=8P#:A4G:D>I4F#_g^A>C\NR[_[)
VC/MBgNAAU,Se_@9:JAgJb,_/O-8N52Bf7_LE=aaTL]W;Jb9[KCcfQH(9OWL0]e(
#CD7)E@)2#gfKK;^L@G;DP\H4U5[U-Y:IHZ]_XZMC1ENBJ^YA#AUXGLEXW\4G:Ab
@7T#;RM#9-J(#V-W:0,+_8@UC/FZZ;M=,W7L.<f+XZ11,gaXIAB[],KbGZ-c.U2H
K;(;Ze6P@E_aNND&W&[93N\<H1S@6[>J)M33E/Yf/,Xgg_GW.;HQB0\-K1D@gE(I
L,_X8N155f1aEY+8b/+U>2]SPQ3c8.7#1R8Acf5#<M>[Y=)JXPKN9=&eNLC1_:0^
5MZ=F1S/3PfTd5DIALM\;WP:?f5VPRgFC1/C,GXI@MBcdHPTG^_1\.WT=GQ/0CZ^
E7702/?fI4La#BM,+HeU7d#f\<^eZ7(b4O,(NdNPdJ]bAM80Z]V0gW-2.G#+/WTE
8TM2?RgEH6H18eE@3B8aE+>H2adP\Bc(@aQ-X@Y=\bX&F/WP;M5EUJB44?;O:HGX
AS>W9XWN-QbeU3Xb4)V<(WH++Y[/P4\g#-OC/.HEPYd2+C2Se3)\cMI8-]AJT]X<
PN&QLUW7\C>S=^=5-/eI8Z17<)O>+3AEG3.Q^Fa)WB?@<V)H=,b;]B[9:)QLL^8M
cd-O^OEWb.BLa=R</L\FJU\?,BZU_TKU^SM58ZSH<WB(_@P=)[@KUH5@bIeFL\,/
f]DN+0)6[6[L+F7,Ee.R9A9Zg,?]8NAZ20CbS>T;T#;\Z(TgI7A(SdD8JfM(NK.9
]eZ(g7\T6]Z71LJaT2,1#T5FR[8\9bL83]a)1IL]U4cd.L864&^-.25@@>RA,G(5
gHCBV\N<T?-bgT&+?#)UaTMY#E-=dS>fdY^1Y^(V^#C\+?CccR(Q;HYUSK^GJf0N
/7]Ud>\GGeWa4[7gZcW3J8B]_7QIRG.E-]Q,XX[=Y;.8<B\CJ23&gHTc-LEX^L.O
+OZ,MRO>F(?eY1TL7S:fP=2,QV61;aI1NY;+SeJX/TVAV0N<&c5[FD9I;O3EUSc:
9,L^Z4QcV\[WQ#DO[9-,3(.SE[290LHfa7Y=]9W=2?A1:5Rd1CHBKNMZ<@M?0OZ6
gZ-/#-Y2>M]\L/@8LVegc<;gVWSSe/GL4;E:@MT:7:P3(dA01[:WU8E7G6TSHL>U
bYK0A_+5H/1ZSf7FJScEF;)b;b.86Z:aceFM&A(@3Ef;E<F;1<2eH4bL-TI,)G=9
Wf7L7FeaB@.Gd.]1KLcbXX&FEMYSE\&BPVYS^GCHJU]7=10:1Xf5T@?Ld\E>g6:f
K\EW:<H3#;I39O58FJC(8;,_d_/Z7BeLI.fNeMHD5bK#9?GV6^T)45PZ_<3N=W9c
&I(I\>KZI1W9:7Q_9Q](860:/7D^7>-=4GdO[KPR5L<6<ZFH9fI78bDLS7.3bG8H
309^JWVJ[W,gAY.;e+HTP]\+[HZ,P]SAKTNgZ3fPa=5(IF<]>g,32#_;_]5B]D14
B##>fBTg^g?9VA5?cE^-#4V_[COc81fc_aY#HaH_<cD9((DD(M(X++]gH((GDQfO
KU,G(:9;:&c(W96_Q:fbFgaVZ,R6P<THK#A>YC+@dVLUfT-7AT3HY<)dM?R=UOX6
6g8I4S<dc4N\/Se[D:<#-,[Dd@UI=JfTXDDSCW@/f32ZNTJ]X6ME7WWe:dQQ+:CR
)\29#34TG)LSccS8J\:g(/Pb()<ZHCN+;e2X,+#Yb[9AE9-,3YOIVCR1bDP9?8\;
_L,4+1?[2?e^G-<^?b;QRb>fIX.9VECScS2XI#\KGL76#Lg]J025DQ:U\PQ5b/\6
<9ZSO2^E4)]3,+P8S[\YMS>CSVS1MT@X_JO^61b_IH]23\W_W>LE7a>\84+[D)8P
Q23013&C1TNg41&\I#.fcMW8eXUTJcY9/;^:QHXfg6bAAQ9]feW#0Q(ZK)\9Z;/:
N)QGBf7UEM4CM6(FfN8:B.4M:IZ<J(+_OM>T;Q7WFgc?Vb,C54JP>M/=V<8T8SGZ
Y=(QPXVZMX+=:CHA@^4c1eS;e&>]3dSRbeLQa50AB_5-GKP.M/Sa58Z1A>QPRHIL
VAdb7969(aA.,GH@feJMJ6FSW>VTY2=<fb9SA8/bTJ5Q4[;McbRYY@6EGe?4FHg3
W+80]D=ODU80N91ZVTR?P[+\8C1BHOS4=1G)_,I<0_2N=+XVQUPKW6,?YW&,<@;#
[-^QQUL?RNMW]P2B8c,=LFa_2++&1454b3N]QG6=&f>d)W]HA,[>+H-e\#gZdR;>
LZ07^L4CW:(5SZ#_SHFMdBRgC^:O6?O23Lb/;N#=d.H\<2?X3GE0@H]A7S17^C6c
RG?VaL,+-0:#?UP9556M7Nd3E-CA:Q[&.P1F-\OCQGec4T&/Ff/f4F68c#;(U(?>
(V(JKUB)c6N7BU.]BZ/G>DKB.W?Z@=7EOX#S_B>S>^Bd.23<,Nc]RM)_OV3CKH8,
UaDI?X#Ca>06CHOU(L?<<^C+#X&^e)@4-#0;_5Y2,OW39cX)[K=DVVM1?M^=UXPa
FAZb]Q.4@PNbD7A=Q=?BOVEgE=_^H8d]Y9]27X--ba8<J,K6([_^#MSH(<B7UJXO
KZM;,deN91(IVCB&f^#5_28^6(dEAHPS(0_UITL\@<6+S8KG/f(I_3[LV7GNB98-
Xe+N67IBUOaXd8<<O2.:]OM\(2C:\aS/IgGL_C6&-cE;P7SEVNWFCK>U?AA0MfO3
R0XGM+gQc<TQY3VCQf_;P3/AGVfMHf\eUBVKT4OF@5Q5HPSWgg&DG&g?HfCQS4WA
YHT<Dd+B6F&?S[&M.\G\Ie)N7dR\UNPJ6fFC]:NUY]Y;5abK,Q\^1?9TDCb^;#XI
G_K-H@3[ARbW#PV9RW9K0ZPbY3:[+eN;TXW(Z(7#4<51S&&LPA)ePY5)Bb,2VK>N
faJ,96GDe_7dTg>Zc=dA6.g1XU&=_<Q;F2,;Ff164R;fG+7T&\J8##O33D_MK=W^
V7HT-#G53,QIeT_^UA4d-&E.e9=(P;-#/VNU(OWL4^];&#2E?)]B\+MVF4YaCbXc
F?d]3],Q;P_[<^C>Q^</)9&1cR[6YZ(H#0</#<[J_.N0:SO9J;LUOfebL<1JgIXK
?SWe006LJ+deO]QAN-T0;RJ/2@T\;4.G/g:JK]&\KG:a^LFa-X;3_F>b:/4O)B&f
df&C]/#5OF]MHAfSMPA;gaQ?VfUMDI(a=fAe[K7LR+N\=(bafG(e?S6W+1<XB@KU
6PB6\EIaT-ELA6X^WF6_XAe#7LgIT2&&.2#G5JfS8d1D&-e2P5dVE8bT>_^:^-<^
EBf[5L40-X8WN.T#0IWCNC?^GGIdIR--[4KCC7KN\US^]6aa7&+S(eN;FE_1\TN^
NfW5#(L;W[dK<SM-bY?FFNP6C.e-IQ@LdQR7^X\^9IRgQg(&>ZN]YFWE+a0/Hg25
#2/Ha[QIef?C?dBL&Y(R\.9QcfZeNJ^CSR0JODU98gD9&c[AB5CX<((4P[H0Z3@(
J;.?DB2>2SN/1,=?#]3FJUBMFTGN^Qb/b4Y_PHIJVTT8HEKE\6Fa#GT.bZ@=)<SP
YL//JdZ&D&G?_T1U9P\3;IM(PT+7;PW<&WR(60]W85Zf\2<Kf#f]9\Ida6EdFYO\
GF^8#dQ]FJE>00V4MS:KXbU5U[GWHU:bU6V-6GOKQZ:YILGDMTNNLc5YAQ9g3F3]
TEWeL8:#dG^KSH1WIS#WLe?44.85BS(B&Od:PT8UB1Y=Ieed2&=e2dH^KMBcP84M
T,VeCPH>MZT.SDY(MK/F.a-0I-d1WXTR&]5CVBSF\aI]SED@N#0cIb)T-I&Rc9<_
?>_^22MgeE6e507+;]3J?R?DbfA]B<EW#GU#[C?D:B(A[[A?(J2(U?.^X>?D4KfM
2^,A8X:c#UC>I:0(4J5K5XTADZ1E0;K8O-cJ:V#b09bU7@\:5&#-(c/P[#(I[Ybc
Z0G+=g-2aPVVL7NQ]P>\O5@H?I2fC=T<Y=,Z^g;/Y66)T,R?e=N-b;Z4EN/JKC5]
5&eC/X#GU(8\AeQ)L^VDGFDR68CSX[BaH)5^gb&3GaAE3fY&Wdf=4Y?:IN0Gg^E:
1)50/7AKEA@D+P@a@\7XMJ-S79VFgbB<Qa6+==SA;L)]7F/S9M.7K6a-HEFI^PMW
^]<g,S04]OL^&+?--P?gX/20_?&H8DMXV6HXb@K.c7ZU)IN3:&Q2b,GCK4HFU8(6
FQ3295CQJa1FND42:F5=DC#g[K]=CJIdW?R)BbIfI?=g>,db5>g<-^W9T\IWI5[W
JCBgW5X4N4Z@[fK8&)PDDc@^5QPIdHZCR/8-O9/WOBf.=ad?gJ1PW5)_ac45<gfF
CT]CBbNIEg?N^Q;<e70.JcJY#YF.bFPZcBJXYY5?aPA<[&11W8J)T==&)-^9_1)O
ZN010c@AN2gDB?5R9HL[=2=2R32<1;EU@7QSB^Xb(fXg>5EdLY8GK[FOR]]If13D
9-Z2IS\_-C@RCS+D^:9Id9D#;2IcIPVf4N(,gXO@N0W&WWgM6Q]AA><Q#GX?5,c@
CXPV5ZL@HQ@\R-K4aL)=I.595K7d<[6-Z)dM+YE[KLd]80g9LbK6WNP71?7A(?<G
aNP)A-#P(#@)1b+a?)OCPZ-7=9?)f3?:JZYaJUEO>&;7/fB1X[c084bM,1DB&IW_
E0MW.P44P@4O3A<P3K85M0W,?&HG>1(@^@GP>/-@eTUeMMIaU;@U]LT1N&5bW@O:
=:U.X6TbL[F=TbeHISA8Y?QL]N?&@C7=60&2g/#V<C:IcLF3/,IO8/<LL_U-Q[#d
AG^I\.>R^F?fOH>]G<N02W)fZFFSI([8PX_B>0VK\E.RCN4KX)_:#R-YLaAS0Xg&
][]#/#b>#9[&LW:<7,>HSG^35QVX9g,,5=@3eXM/#e[@-62.M@)TdSKCgJ;@?@[e
[GQ^NIA0e=O-O/@;([F/f/<8[>\eMH9WaXC\5C_C2>)ZA4R1a;M-1A+9J;E5X\0X
68=\E[9^NVV#6(DdXb8RIMRE(G-2OP:/KC]<FYR1Q2)31YC-g4@E9#-dfT;27a32
ff(=4A/K.GWJXKX8Gf?E[CCRdZAQ=OP&<ZgO2XU@E@g8Z03FA:HH[E;7d8,L+<Y1
IbHB-L@\HgU,>cIKQC\IF<Wa6aFWSS1CUFS3UD0?[GaSQ#e8bGUfVS=eEbDQ/?]P
aL;MP(#6LLbI8^R@ZPZA&5L(H1W;:eCT0_YA9,XfF\E+@22cN(0NOQ11SWRa@7PR
,J0M4JH08-eEH@db44SAGC-<:Db0MY<TWGWBFLJD8.-73=^-2#Ddf-W]HYPYd)(g
#R_,1.4P2b;Q:9@aE3bDR][N;7(D5Q,]P^)Z2g>fLS8H;XC;Gc:Z5bQ4gEM#O.c)
bK,AK],VgQNR)=(.M(LOXggJX:c,,G_8.=d/T5c9cR/>=[VL<T(2cXHe/F<SbUEa
L,3da6#-3f37NRQN=76N#S#C&)&A@Y=,D4KE:7^0>N>6KQ.SPe1Xc&QdU-W>VeZ.
Def+YdVR7-)(5H>;+]+CCc2)b[D,G3W.0US0XNC.g0PY=@4#c-4aG&)C(F^]Z8OK
^Z2NAbF=&5,B:7;)HcU/<OII1aRA.JT1S(?7?[:A]=gSX8KC,da5Z51S0H)&_DXQ
&#dc@)f_.-a=NRH9C/2Y-#@@MDCd/3f-?^V#g6,<542,JMI@./FgMdSX7.XYP+/P
cV3(d?7J7b/:DL0Q-4ZSPbUeEW/A_U3-Q9H6Pa1JIT5F=DfO((>29Sf;0YI=CBBN
K(eM6A:N_DDIPRdJE>[>c@e-Z94@S>c+-OF^A5/BS@22]/?c0:-W?61e(LIIY+4]
FHHE9EX9_ZP,K700R1\OI\\7/40CO&3(Ng5e?ADW2SW62QK4>6SI^INUO<FZRE0c
^ZebW:B8^G^HIZV#/gb+dAd#V=adX/G@G15?LH@VT/AI#Q&ACNKH=BP[Y;\#)Yc/
d3O2aNF[:B:?X8=D]&;9HABc6E5J3ZW?bZ0Vc>adF;3\8M6R]>T\bNgAI#S5L0N;
)c;LK]#@Xa:S)X[Y+Q3\+b>[DJ1Z)U75O3[@Y^XWd33SN8QU\-@5_(J8A1:^]R4?
)LgM9b)IF<WP_(>b86-a>@,,@;@1eROD;EA3E76886NLY8&^\9(R?K@c-BI_&NRW
50/C(]K7Bd31+67eFDDKLWM]-G<5&4eHD-/OD+:S/[<UfX]HJAW&E_ebKJb8@=be
b;aH5eRESG?>43__,eKdGHUD4D:MCA5c8&9FX>GISU=e416RD6V#bJ@VEA6;aFJ1
a&2.2@(S6E[X-&IV4A49T.F[&/XV=G5K@/IR;TfM75I-aD67B>+)B<O=^:=M=PP=
+Lf@1P)-7E>^+fc6\6U_#A0ATLXaL\=&9f2C:670K=SD3]22e9]a_@RbYD^7W,4>
-c0LF5.U//XNaH]YJ(:c>@e1;XSG+X>Q1aOe97<XbTL:C/9Mf=)f_H;,e0g/C<M_
&0O:LS-Wcg6UFLaPUTGCZP0G0;\QD,g;0/VEWUVV9b]W2M,QLA;[e4+TGgF,b1-L
G1H\H\McFI6T#3L7H8,L\2gPG3F3)SB(GgWVL?8\KT/A5c_]LZ8Fd6a&--e);(U0
#D<2TXMNY@?M4VXd8.&X,g50fEZCP]ON0f_87+HL<&10RT-Y^&AT)WQG5KQa2QQ\
]YP=L;4F&AC;J(JNKS(+-7@7d]L4D89_GLcJ;0[-aB<7#b@(SY<M54)2>@MI(:K3
_-BPS<>3(cF82P)KSX>6_(-FV:HA4[1OcY3<\0L+cIMZ3:Z6H23D1a-H7a&OV<<N
RBJOQGeO_3BC;,/eHH^H(HA>dbXLQ(FD;eXI+J\>SH7AL\9QN,LaX2,FS[e]];ZO
?GJSE=g_eT^,Zd]E[IXLbg/1ReG^a7gbT;?)MKEZNI7Uc=ZE?[HA9H&9FLE-b&>D
aAJ;0755L55+^e@U2fG/c#X(f<4H>=ZIT9HQ/[9<S?&MYFN_N\]b2@Na1MC5BKB[
?&K)0[&L=BE<-7eM?3_YOa\,/IX9ISKO<:fF&G0=9<UJO9XXM\bd_V:Wc0d;NDEO
/Q08<92,&#8R.>Y5R&5.60._QVI]HAYWVX&83<@0+FDaVE\e6RI;d]W8[EXXg@MG
W7V,N,_X:f>7E:Yg#dB]TJCQJ<c)9fPO8DAH_G0A:-J^NJ/QF;7faeMYE#;2H2b]
)B9RU42H>b+ZFG#N^UXFG8UR_\MK]b]X,c9S4HQb@N_BaG]\5N:=1<3;ce5PaP.P
LB)Y(87F7)3Cb[G)?/e,TV+-dd7Y+^MM03^A(V=PWd/A(D8[:NF_CbF3ZQe6U.8S
&7]K@7c1G8JX_gWf_>HD-,GPOQ3T\SWeAaIN.00,I42dg/f>/S9>K&f_9R(MBMRW
@L1M=V0df(U>9:60b#1bT@5=X@bJfOdT5cPUfLURK?@L+L43a/DK:CVGbZXIRLeb
,45.>CG&:4[Q[dVFAE=6c?7G8F@,b^a(\P0^+a,E/>M@0(W2H8-I1&A2)M<M3d3_
<,KbN.>(L8/f\CB(?bbZ@L<-.L2F=F_]K6GEYTU]45;XSb7)A]C,;.S?+_U(g-F-
R@\\b_SU9Y(#+DIY8+\/SA)+fdHNJX_<NJ,YgII76>0E>gDaR/:Pg-G(F,_^I]H8
61.836N,_&J1gR\CUWg?5QL0),H&IgWZc?L\;Q1L/TB0+BdSTcBJ+MEF#E<eJ)N:
;?)bbQ8[RDX@<A4;Lcg[d&0?NIA\.\BbW:@Vb=)GS14&:]c@1LJ9HC8M5eYZ+[0D
;P.DA(3eK;UH,V+6)UeWgVePGe&<(N)1I2Q(=c-a[0cSJ\bAK.d--FD6#aDGCf^>
68/aAB.X6R>dQ1g7FaZ3Mc.SDARgIKN1[GbI(aNG2Ed#CU3;^NXHM.FZL#(:O3_M
YcV,-P(e4aG4&XC6OfY95Cd?g7+?MTgUK-\2&+.7@BQH)[XC7H+]&XJbJ3635DE_
c&_1U&JNe:KK?fRGRbL338bJ&P6F(;?:[1W;2?H[0()&YX8+JLYT,7LFFeIUP0<3
;IS&X=)>]2Z_W+WLG3CK:5,SICM]cE.fd#HP9EeMV1MJET#IPF>.=A5LHS(JdX=e
J?0WD6?Y.cbOf>+-4R6Ke#;H5(+fc4Y5E([239TabSgL>(D\(KY5O/^;&XE>)32.
5QH;-1R5NTC^V_QL;@L@f]8)gO.\-a5dZ=;/E0f?b&RM3QZCQ1G,UWMBWM65c9:#
_Q\R\(F;:]X,&H7-ANAcK1U+DJ();KU&]Z.N@1M:4\G+)g1D#Zf0^5aJZVe<\),R
6>HF\N[[.gJ1VJRXK7d)0IH?D.;\TB#RP5\P?]:M+Ce2T>5C#HGW+LI_VDGLCLF0
RK4-WML7G074Xd@7;SS&g\WI:,?MA^bPaIIAR<_:3MGMUD[O7,;WS?DF0W1bMU_+
I>/Ccb?.gR/PgB+2/M+)#]M/gD32LUeI#=SKCGB3CM,Q+PK@P#P-_JLFd=I6?eHK
HeB8eT^C,S68OQ/8+95.a^4+]<=&L93GR9TEB.?S2)[#/D&b#d-+cB+fNDN^J4NZ
E\:(1_7Jg.BW\:WX]b23N>c\2G(;,Z_f3b;1241cK>\XRd1?E,+H_:/H^^>5[AdO
5@7M-,L<8CPE:=:0G)KFHQQ^eUKNIOB\BC#6_?(8#@&NZF8,gFFUcRW7L>baBD0(
XaPb&&L\W(^SY@K:b#^8GRD_SD;/-6W#FY4g27J]V:00[1A.=>MU/Y&+H3=H,D#B
Rgf@K?c_CFO>OEQK42A<9B?K;<7fZ5gg=BO(beS(ZFHH4)OO=@d9MDJ(0MdT6[TO
H>9.JZ0G5>,UXV:a?JJH^3=A>PF4M\KG(31X&bG_MNReQSb8DR5(943H:;4]&WM@
4_a13-XQB(0?M]EK)T[@-H/@[Bc=3c_IQ_#TJ,T#+H6]O+e3-2BH5b3Be?[.bV7L
]75beE<g:/5]&4K4:?CV+AT0JE4M<I:B\&B,eS&,I8UM^Ed#PT/fJ>55d(5gKPf\
;;G<[RT>70JBe,\^_V4?EJ6:U,()aY;05N>S6g2804H0>_,ZWGAHgddD/0(A++7-
OM\UT&?^RT8-S1)OLTK^;8L@CV_(J.4bB&U:HDX)YCd.ULZ8O7d[fP7+b)8a.fVJ
7G1b[dCQ\Z&2:(F)]2<+:]LK>\6CF52@H\0W:9BDZ9(79C^@cA=12@=FKff;+P5]
7B1aF1W;R7T4Q.f[CDQB;V(dW8K8M,G/1?(b73\_Of8eQ^)YHWLS/X<-;.37&_S.
#P,NAg2?H6=[(I2Z2I;Z(GG>_2.YgS<-R?ZA;9XPT1;K?P=Ia732W#QEY.()KM&c
P1ZSTO_CZ;\6_#9)&1Z<>b1:&NFdYFUY2)McM@1A81L.a?8,(8(?R0_N#9U?<C[)
F[)><#&1>aIa[OKXIbab5OKPNf4QT5[;(76)#@&8[7&Y00A;)4JN\/aZbS(-2\Tg
5<?=#X4KdG)DF:H3)7M42CJ+@1-40Z)95OgQ6F6JX)D&DO8\;M;PF;KYU89.[AY/
gI/c0WJTG[8b&GC?@d25IGMgQDR=-_+;0d86WNW.U6LZTES1?,&._/()0MHZM+R>
7(WE&R&N-)e_I-OeGe>>E.VO&eIe/Gg,>2UeNL]D?97BSHd\8Y<^<P:I<cc3C=f3
,c8ga?DK[bIH6KGJFK6F0b3IT),24S:a9@9VbD[P9f.6MIXe2+I5.]#X[J=0->EH
4BTCaWG-FT[H]MbOc8g8]84>N(La-Gd#)_B+0_&a-<b_&A6PGVLVg[O;L_U^4GVQ
@Z0TWb[><ac\6&g;Fd).KW3Jf(#JM2^ZbAI+(GA)XZLY\#d=b]LVMPSfagZX_M^,
BW5@3)<)X@=(EJ=3<5=d],L.Q/^(9D?OB5:1_)Va\HV-#\Z/28#]7JMUJ8#>-aCX
3(EO5LORLUfBF#_,0E,FGLV+gV6)4=>C>.3P+8LM6ZIXa]^cB;X\fAe19?I<#_+R
Bc:VeUE#IY,PbeF?5=YLaK@8/VATQ&#cH&6]<Db0=aY_K:-_G<Ae&OTO4NF,f/^5
)[LAAd[,.1^He?<BJZLE3W6P3PZ[2O0OMVMDb6&a8a+B4VB-@^Va<GU>(_fG=N&C
Y1a##S1^1-.-_30V/V&G2WP1+]]aOdE-H)@4f0/Y+&L\SJ0<Cc8Z>009K^OU0)NO
4+eDZ02?(DI&gZ_(=e3[E.DB6<=/_PAW]181WXY.]&8bFCB<@/\K54J65(#SadQ3
[@V64+[SeL\+R]e_RYLSFPM4WJeN0+T@g9UfL>@QU[O9+D7f)#XDL1+>O&R+2>&@
fcA:^(>V(M_VKIFTXeELC9fS-aWKabYG_D#&E-fJSIBa5E@BDK88.S[FcdWV<R+M
:T/-IRC#N<?@EC,+2cI#,\?I0OWHZW2UgaE;\>NRM]ZDR1N1?(-MPVf[V/DQ8WI^
]W&;a8OUS41SQ7G#)GE0WH+>=7<gU(#E]R#>D,a+1#<Rc3S6M8:Z=cNaRF6\e+5;
=5#VQ6OJgW40LbW:,)LbXX?>YA,@1_RK7@KI^]DgE_II=3T8aHcEHVNY/NEHIDU2
U[;\.LdZ//VITg&.#4-M)Q1+F+?UHH33_4@gDCDgf444&4V#76,;S7IV2&TIG:Z[
P6XCQ&_]Qb.<U;J3&HeU[J[DD;9Q.P1#HH9VQ^aS0V#)SHaH-W=C?\-Q-(#Zb2A7
8L,SeS0f#Md^<U:HbJ+b;)D&F-WX67T\N=U.Q9T@J&):dK(f6PP2gX9]6R0N.cg&
@BJ:P7gLAQY6WH1Wb9(XJ>AbNQ-HR?U><-D4f0Z>]M=V&9>)+E9J,-[aG84G7[KV
/66D.^a=7J0J8<3G_]/&:+^#03P/Ac9TRP;B^Z#0[T69c05;0c&=9,_QR=(?GgAG
_)PN/\b<AA5dI7[c>3V<XC##TG<2\0IdDS2GD4#0bDN68P:+?E(#6Z(I5f(c0U(L
<d9M;Q;79IL^L.(51:cfC?-AXDKGc;:_a2eQQEfCaXD\IE.)F]5VV(Z-61D?1.T@
[dW2H,#N8DUT4O=cWV<F,0+.cM(JPSgc;PUQ&NK5;+_[23LK\L^>/c+Y>#)U&,&@
Y&.S;QV5EfY.f:,:,X<E;fBRWdSB:e]LH/8:LP086IbF>HMD)<;0I#:gN[#O.^^0
J&]8Bg,3_=S2,UL\#=0D+:465U3V>eD]dI&5N;O)S?E0gWXN<W7L2\EgD9/cT_9?
.b7C45D(\2L?XBC-/LDUc>WNfDV#/<#&e?7MQ#D5[7]^_5@<X9DIB>b@Kc5-aeeV
:[D>E/0PGaRd>g2?VM/e<?2MOf@WPX<8^Y3+Df.;g6P^+:?/;D>\I6EMgNUS38=T
R:40TF903RH=M0^JYD[@^3cd4HbMFC?V1BbK]1e/11V?J=dVAVN@[#WL/6\>-TdQ
0g6UP28>AE6/E)0LC+9^3T-[C)0Q=<C4K#Z]._4KeA(I]?<c((L2=LD9D7<5c>M/
9[:;LF4J->(;H&5g]Z\V\?[]M/(NWX\EI#DdY-f6]8VFEDIc@>\[>T2g[;b_f,@b
bKT)=;<7R5ef(/a@(G[a24S].U#4XPB58.d/7J;>U<8Ndc&Z\U85SXN_3?AH5(XV
3&MUP02EP]_M+,JUbPcTOZX]/&b#]6)(C7(GVfIS4,&1AO\LE=3\XXHS9>3a_#>a
JWcLfQb8BO\)RY/G8<d/1&P7VOdR=TT_?dYcZc?WB\\JB-JGf^Q^CcX__:+C<)0.
6bV=(P=889CV-5(a1,ZNTQ)fFUM5\47.SQ7:c:4f)J&WN#AJ))=)?gP&M&TfZ&#^
d@AY1a8Q6D,1J@)6c&6C6HS0_c.OE2.]JAg@9Z:bB>9g[^TD@KT^B@?XP>c0/6Ff
Jf.^-2g44G^MA<J<.\^ZH3V[1>G7#\ceZa5AI\gGZNI2TGWO/bBEg[;6)[OJ,QTF
]^>AJ8V\\CJ3F+8OP&FHWS1@\\4bTYWg](IOZg/0JNVEbI4PC:O-OY3;R:BK.Igf
BQ@62)DTa6-@0Q=H7Ja[>U^]#CW-1+gZ]M&U]^K4e6L28a]1.R:c,.+BN.)C/U/S
f59R14+De(BO7=XNg62\+Yf836C@\>0]?7f+&^8L0:b7S[1W)Gf&^#e2bE<IOf0R
W&E<EB;>)I>3Q1I.L&c69-&e6fZ^b]MV:V<,@&gJS:Q5)?.RTMNJQf^AK[2ReLJX
?^>CeR,74O8_<DEDW)@gEd@F,P=V.-WSR[8EP<B]=QL32dUKQ\<D,;+?X-C,P4B:
>]KaSaNJO=Y2K^TZP>-]Ic/.;3#OPT@(DLV^822X><Q&9g7Ee;2+=@OMb6=bD5(W
ISP(gX+@^:4_AMODL]XGLNd-L#H.H7UDX[-g9YgM&.^@V8OI0(3[I@5NYV4b.N2I
/VAGIb-_D0&/[cS.;#QdZP,XQP8(DY]AAUGI44#RIcQ>DfK3JI+&D)_2H#fc0b;#
8c)&b:E)1=b\M[F<,FHI\IRK0e&SY5(\PBaG4\(K)g1,fBBb[SNf8\56H#^)@D.W
FD5IAVN/&c]>U()gJZ#+bK]IaOf(:GV-G\><)Y.NL@W@4,SX]Y13QOI71b[>c[7C
_^9T8R:BfR;J&7:c5Ofd25M]dF)&PK0OE.@>P;.X3BPCaY:2K3+fIKVG;C]bNdDC
&A&48QJ&YXNA#GH](>-a9?/fYYKZ6I==,45CQIS(b[^-d3[IA@fcK#V6\=T9[.3C
TfBZ=WD@A5?bG6EG?)]9OQE7P]KN/Sa#][\e1-JY1@5Zf3Jc+>(#T9G)@NH5S6Vc
=fO3He7B>gS2]QS-@e;R&=4B[;N@-cF8E<d,)?8(#c=g4cXMQG^2W+_:.4R3XVAW
0Edg,_C?>P5AP?4KTWU7PHbSF8LR?&FIIf#BfYeFL.Y_TX-;KOJ[>8dEV(O)dY^9
L3(97IZSTGI.WMM@U.)a9F@;-1b011154JY8HP0b/Rg/XWU7bCLPXW(CQ2GCM?CK
VVfU9LF61f8L;9,^g?E8f;V0J_[0a1?gI5?B6^eP4I>^#;.cX[A#^-G.]__&[82+
F01&-I9BX-;U;+LPd4Y.Z-P=UO4Rb#7c6<-=JOQZ&5=BZcTT]b1((QAAcGb5)d@\
.&RN>3YL8b?ab#a-M^:1bNJ8a:XP7:GAQRA3eK0)(T5c^O<6#7gM?KTI-aKJ>dD\
BOL9#0G@H2EH2<L28@<(d3_8Y]PX>0bZF<d&Gc#VfP&,O:&IXb?(&f?Uf+[faIL;
_2W3Y1OaAFWYG\74g9FU;2DIE/1RF/+6,b74)W=^-\_9PTUKf[.3d8O3.AbZ]MaN
)M>T;PT>@JZEDGg=O7YAGXV1:FU)V\2S]KX80):O3>,^:Q[>)fN6G<H;1LaQ79>d
(DL&M9<OU_D_(8-??KPHLGIef<gL-L(A\TF8gD3bc#73JF#GK?I>AF)99=8)_:<f
0c3,5Ge01>6F:A=Bc?^Y#CSSF9;g;a&-;.:;geF_XfQcYK7Bf\..1c\eg@2P]_E0
P\4DQbF6<:H,e,e?.@Q=/0&KeIe90(4R5VAZQW<Q1@]1If@?6TDSZY<<4e7DCG)^
I-f:e(>PTa^0)7d:VcZ]Ca942G+D;?N4D]7-7@1,Ve2b/gER81<d(VO[YBW.dDJ+
9eF4U/QgJBF/@-SYMK,Ig\a7=0WD8N?PIL:eb2eR?X<TO+@&1K@NK>ASU,\BUG?G
T@HYADF;S<R1Sf@[2gCdVS;/[eMA)II33WXZaA+;A(@+&Q#6LbYb4//g8_J4KQ,-
#fF<H(Ba&<\GNZ=S-&)TDOTa_[@-:Beb=[KU7[]ATS<<NTB?_,VWX[ZfSI:0#L9<
c@3X\/]\7G)(Y@b8^Gg4Udf0?Y2\H;G5+ZRH7M[B?L7eOLH\1XWC^cQ#NJ:R]EKe
^&]/#7K.2G/W4T6L89Uc\BeY1//(2g^O#Q,V7I+Qb<F&9g,9&J)#EQ[[#<N@DWK0
COCGeT7X.V8[e63)>8&?SZ,E&bb=Ag^dITA9+PM9DQ53+KC3;Y.=:N?P^<Y<dE37
2^FI\F2LS)KI918(9&N9]efJTBATGaJ)Gf@)Vc_EN&]P[[/Td?A,b;S[#W5895<b
+C;;I&^/6+3C>94S_4?cG[J0SEK6E#7)F;NL<LY2\+I=/bM/-8K]\M7PfH\9Z;16
f[Nb3-[JKe<J][MQ//T@A+I)A#]V#d3<L4=A78-EYcd]ARQ37Y6\1M?O4Oa7bINb
<_GEf5f=?<\XU<W\cK:-De1d4F;V,)KK+0O37,09VJb\0IBEN0@=5a38-<67@Z0/
:KLF;<G_bg?HF(J4e;JBeZfUMc,-df.3UY=7M@MMLI+=>>CQ.L&-;J_\/:OJAI)7
g[>4#5[^7A6N/[+B;>\/E3UZ.A+fU@39Bf&]G#cFAP8^e0cOVRQ5D&gBC.C6g[g#
4C2V2Dd81059<.,eHVCQ?O[P_+77-S)6AR6fMc=[3QK>V2K4AH&ELLb,O01,X][c
f.O?)FKDSN9^;<+/LJ>c\;:N][#7JKe[MG)E7M+\O6J)#/-+;O\L&[[6,A\b?(@H
0bfMMf-L&d-KZI[S(+#66,c3:[3[#R<]TbWZGU_MJb/U6;(M9M^0@3D4IgGERd+,
<CQP(PX;X1H(gRa.E4.a]EFdd(QaZ@FO#C,1EM_+-eUf)+Me?fU\5>)B@POe8;@G
P?VBgg/Og4GFQ2R+c?Gf6661\P6/T5]F]C,bL+CD?(2OS,#3YP5B#A,Hd+31Q^UE
@+-H5U0/DZda^<HL<MCET\/a&MeD5I+F?Ed[DD\)4N3150S4^P]8JNPWQC<=&W[a
5,OZYQL=>e;@N#+DS2]N;)_0;^9/.<;c@=_:&7=B8BKOE:&g87D.,cag/CB(:&ZQ
DU<<cN,)P_5DBP=c)G?(8V,?WR2_KU:I5&(?3eL=Rc.[bE\VA=^[?S\g)M6Q]&dY
0d<2SLcO-ER\0K2#.05_I>MB)XX21O]&0NegKG]>L#::a.T4(cQe)#4QBW,9WACI
bb;5-&1f.:)]1cf8MX^e85)/2g<VcCV#3f@gI/.<]^Md<T.Pa:HC->>>I75\KB]5
G,PDZE&I]MOJNeeN>3?=38I.Y-3(&BEfVK86ZKY?g;Ka#cU[F7.W]Z(;V,]W&N+G
9R6La9]fE?,+C;a&FM:I.AW55OcTA<1VgPI#=.e67E)3L1U<e]f/OcNX[.Z4PT(0
7;FQP4VdDN^Rdc6BLIg77JJX1g&#54b<I;4-H?5eQcXECF,^OEcM]DKUZS(T((Yd
6-M6KS<Y/.13=T_LUA)8Z^&V.,.N(7W;6P26K-.)X17/QJ;&/ALCKAJGL/\DO^Pb
H:5.&6HTC\Y@[?O-AJ8+;LAD2S3SXISK+&-KAR3B;A5]8OKVeYDW^Ig@A?JH(Hg6
W=D)9<X_(0;f18I7_.gB_,SDDWg@(NS)f_._S0geRH>V<])a49Q9gA1S>)\?16:H
6I4_ga\>L[<aF)/65W;80RVI92914d6OV^Y(=>#C.gfGF?gVD,1SY?Q6<@Q.A_ac
Q(>LZ^X],NQWZU];c]>\Eb.7UHJCNQH0fd+9E\J,.4465HX?.6FT^A(>G\c4VZ5O
R6]6-3/T+dI.Z(LV])+N02:,RY>@NVOP)KJ:OIYO^-FX4cE7JX\\9NV(&]O+L#Y3
,FG)R(<QJ;WPS9VV;C4.bG<e:>cG8e+-&JW(DFZQ#JSDHZYc\CLCE9R8c_TM#(e4
H[4K10eJ2BXffd;2(JA^NU@Aa4D,V[9D@E4I)e^1XR_Y>35dcTJL:\ELOZ=WL\4^
K(fXRVc/SB-W&Deb<5CYBL].Jg#/L1,^fMZVS./?JX)(2OfK?be/7XUEcP_7+#;7
)@[7Z,5N/GfDBS6I9b(5&f,,b)5(LC@,I#_UPeDHfEDceC6#JUAO9G@GN.EY:Ed5
A=f+:1AUX,[/T+BC5MIXDPTI?]aJ<Sef\TR&SY\GK]RB=7_,T+3bQQ4XbZH;LK<M
adW?fHaSY^/&GGAI#,_7@fI(OP_H3KH0[O>,aG_-8SeTT[Q&GS;-Ib>a_4g]&68)
Sd5+eZ5Y66>^4_RYMg),E_=9KdGJ#4S2J^RXN:1&#feW3+U]KN(4FOKR?;4C[2R2
RHg+9F6S:,:HH2cTJPBRN3G_NLIWB3NFDdF9A:R[BS,;LUVH/,[8BR>N0>L)RW?J
0Ec>=G6.&aAIeKO9.d&1C[,W_<V?.)(_3bYJ</S6R=(W+1+C@.FCI\E]BGM[E+)>
UeLZPIU9D4fUV0HaL&=cT:cPTJ6Y9F&--OD\:gE)#7DX\/#MDb0(C;LgAeM5b:?P
GICf#XaEFVg1aSD\e)RAX#Nec\BTWO;WR,A#b0@S8L0Db_Id@Rg5L#_2HL&PZeSJ
OeJPP?I]2[@P__LSN@JSCdLU;LH3W,56.c75Tb020/^VSX+=PCJSdQ95B_#O7_EC
H>>>Q7e@N]W??,fCES8X[aT+O[eHc4SRee=PI0BGA/,X-g+AZ901Gb:?ZD+4D6N9
gK5,Need0>d^P-G>?^G3QBEU8,#(X4L(7e^PIO>M_PFBD_##3K=IU>LB^[c\4=I5
+AfN6_<V&ad:gI5C=00BP^Y?g<SD^##eAOd[4KS<NBC<)(XF32gg#fdX[f0@)7FX
R):b4T]S0Hc>Y^>UE<;5F\=ad_ZC_K-R]I-:OBO,9E+VL^NJ##>6<gWg8JDc2RQ(
gac;=MSSaCbc<LD8O9ZS6Y3LXS[6+<0B;O[a0bfX^[EJ<ZKW&EAL:1f=a\8=&)#L
bJ0dNEcJS.A,692=(BS95-(\8=6T<XJeW2d:Cg3c??a;/3]KHd4XIcfQY<d2\&OZ
G^SJZ6_.3W;>UUW<f)&7&QKI8ZL=EUN0RQJYW>R_6;#ZRJ6[TZ3.6]SbIE0/[D+D
5SDRZ1cD=-fZ6aEHUJQU6-.>Z:e>QeDKc&[dY1eKJKA[=H1Q>2>7#QWBS+K&HgT^
IaD;-RB9MM4;0V5@MSgL3TU79M.a1]1?X5G9.^](b&aWAa9QNADZ4Sd6O\f.Y_8I
M>+D4/Qb/40YY_2)=77^cEEeD(4UDV#6d-);3E-4Zg8g6e7]@F(NP#4?MYQYcN3(
e<KdDF47?cRV1_Y@P)_<,>c:gFX;7\-S@EEYS_D?I\7^/5RHA@)SLP>a;PXS>a)6
+Bc,M,@O6)_/>+?#7C>ea8@Q<=QJ+>d2MUAZSUV98XGTN_dY:&/MG),IW?e?0TJ0
=)3GCP8,Na:@W@/9KI3@/eVRKd8OXNc0;eRJQY1O258eH80)O\&9-+_;R1X8db++
U4C,@W2=Z4L&+#@gXeH0@.;(R,AU+K1UL/^X?AY88622^?be,)<(6^Qd<ESdG(@J
9C,+32_c/d?9>]IMc_97dU&e@(B6gcQ=ZNfX4^BR)b/RO9J9JB3GPUDNHE8DNf,f
dU?31KLIENZEfE->-@K\T(R#Y<1;T-FN^@_]DUP9c;)cJb51C68R#H3&97Ib4O?F
0STEZ+</_N[JKeDUW-:B]0?7FY+I\H[D^/N<JRSP(V[(U<>QC>L;HdGY+Ke^R:IG
a>A2<:FH>^61LX_CS2Lagg>aSc;^YB\ZQ:S3L+MgcG#e[#<.e<?c\PJWd#D]C-KX
8UG=R(?(:&-#Re\5b&#1-X89(E](8K7@(<&T11\S<?BBO6]MP#dCHd2I@\>@UDFQ
FeKPMY1WfE=<I?b2IJ\b.Q)41TIKL;(D@7LKK2,X9^CaVKV8CL=,CUC+N&BQ;C0E
^QBEA7c>:ZM=?]2Wg-FA<2UAS1@LN?^#ZSO;HO/.^NLbEX;QTe<-[1M1SeT>D/K0
4-J?,1+98WI.,[-(CK)DM8<PRK(GHF;8;X>Ha+]E\,0]YD<(55<a=HY3O]4&JgH-
)I)f\&GW;.-H>+T>7PN#0dQ+RQUNT>.:-E=-\6FD]3?WB-@a\M=<T_\P5Zb4ZAQI
)+CGV;,]]=Tf?@J5##:]A[#_NUFDJfH06I1P70gR&P)g9Z7;\BUE4)R0&;.T?ANB
N]U,.43:57LWN1NM]g#5C0b(A+aO&.O1H6W2>P<V&A2P6ZLV_5@]P>S>WP2CH5Eb
&9e8NV-6#ZSV+I&#7>f@QM\15[75[+9bARZ#3VDY^d?D@b2^d??>[@>W+@\egXLM
<bWc7g8c>g(KQI974&VF@(.^5/)Xd\JB8/ba^HV114(Z^IP2)ILO\F0>=;J\>8de
bPJRFa37gJ3WFOS8#HWd0VgNVZ@&163Zb9B:5Y<L]0(QK1E?R06d^[g1fF.4G+:?
Y@8BRPebPC2Z5->2Y1N3M>:R&=9WRY(LHYM_K+:&WDVXWK:-OHU9+D:OWT#FFKV@
+-[126-N0,HPaZPJ\Q+N^\.WBb4J7&5LIMG[B2ITQ\;:bY.S0@#XcK7O_Qd3Z>;3
3GCP5H;V:b/6<L)LEUGA-S[DG/QP-K42>NP:1LX+(b#g+[dR6NSWZeH=@fT5I)a^
M+_12.0T#IGGMSH;W<@7=]Y8;FY6TZ4(eJb915<2]:6IBADXW8MO&?^Jd7beEb(1
+W>?ZRAMZaSIEME?G>3Z/ea84ZLH,L)>7d1\GgU1Y,>V4-4c/)C1_MANX8]+/LbK
,,,ZJbZPWJ(FGFR7FN?B&G4U-Y=_F\cP16F)(HH6^([CK4T3gWe;-(2^TIHSVNOX
HJ^MK)9Z,UBLF&JD<T#II3Y8TR:C+5Q5=BbbBUZY(L>Gc<NY.?XA1]2G2#HJfY6U
K\86@Ja[XO_MLO=_Zg]NHW(4O@KJ);dZ@<XRL#=d-GC51Y\##eV6G>Tc85_DWSS.
,a87LGNZ?]X7CGD]GYH?aWU\0T:.??#+0eFE:S-BZ/bSHI5/+()3@I-1D3(5WCX\
_053LSLI[3G#&gTMO/SPA5Y#cX]OPI<TP9e<\aY6KI#[9EaWP\R)G=3g(?=1CD4-
?<2/Z^>[I=_=H0SJ+f[cSGg]JDJ)CGI[0QA./dgcWPc+#92?3923)+O[^DEA;?R2
e@SbgA6SVY02_\f0TG_IeIPTF7=VfXFd1VYC2&V/Y.+6)Y(;JT=A-\Q_(K/NZL]F
9B,b27-MeZM0&7MZ=E-Sf;(g:0-(=&=X:/J<&IG3:^E(##gCH@d.[>[^[RK#\Q_U
6/C0GU[3YX1=7<6Eg?F6B<,T@WS-0ba>9UMLg/,/TTO?c+79;XY3J-&I.XRMG-#0
8fELAUC^#.)dZVa(3WYSad(g8Q(7JNaT+IFJ6=a#H-aVg6@;A1=@B8_1O,I6+)V6
a9P9N.9JaRLfS,IR_4W#cN(d5Q]bfFP0CODPR__ab4ab^eU+W<fC04-BO?Ac=;?&
X98671&U8&c=/6Qd@:7UaTKYd0&<R-Qa=J5\GR^.d8SX&^PQSbPE]^OJ]GXD+)Rf
dE;aT6IL#V8c-?(C>f15Zb]aN?A>NL,8,aPU6^G5cVRX<M:Vf[Sc]7,GN;K9QLX2
V?#1)bf6MH746WW@I+TefAT=T/.VfOc+W8XbI=79_HCV<SR&ZcF.IGGJ?.Mdc>SF
D^PBH1eJ+XgO&EN(E1^e@HCF>8+@/M>?@gWg7.QFDZa]:N1N@Dd;&c,QePg,^cMF
&?>66(/=X+S0M0;PEPN0HLP-OQ,)XXaP)>2fA45=(Q9RCXT;@^EWUYOI_,&:<\+e
^:P>>A<HE0I71g=8Nf>A_-AT;2W-^afgMgI/d2CAO_5/5QOU<3-FTWF^b=/XJS6Y
;P;>?Va&\WIZ2()LHc1LM@^a=5_S=DXOITHT5>:I<@V9UL<705Md]6O]CDV3DM\S
F,3Y_bQSM4N)+ZaRBZ6D?-dVPFZ>.0I[4I-bHE(73YIZCB(g?dE7;_W2/_aF+&5:
K5D5993KR7FC8NE=V8Y4WSBSCY\1,[FfNag(/7M5#IbULeeSP-.5-1eS1BIYHO)L
F?eF):#dKK1_\#(K/JDL#e+[&8=L\Ag/>2-.23=6bMD805f5cA2^L>.1D-24NGS&
2WTN<A]=I;aT_23cBaJ+6NMU-9M-<TSJ]JYE^Bg-4(ELcHaT5CSfCTFW7/K(#6Y\
^>^I)=MXWYH_QY^?/0<#LD<bG6KUSJKYT-5_:O>ga=,@W<6a>-QHeDB[gR.V;ZE^
(31DC=:8,2:/K6\_GY&AdX)a62Q4C@F)VB?FZL1^.V:N)9fGfF^..<f0aJUf-C+L
8WX@95=f)Ia<>N1Z]J?GEXZ+O;JRYBKS1P0\N+U;>MYR8RL384@T._)?&_WT=S_.
,U0e;ME47]CM-.;H.H\7Ffeg9(Yg?Pe9HF#eE;)9ff,L&K;K],]J49KSN-aARVeQ
Q(d=,a558>S2LRSSgAXT=05E/_D&3P>=D6QVM7Z(QF6)P=Ub-SF.J<H=-eH-HL<Y
\9GNMbS\6c8aA8.?&0)C?K4ZKdO0XI,D>fT5VILQ)72MQ>;@\f:B1gc9;H]JK@DL
VU9)(8Q^a6gB0MQ\gYU^;CW#;6ZHWe#X/_;J6&0bD:OabW&^aSPTN1A-<Y@3+#IZ
B@PE3YB&-D\<C[=9Z-/g.Y^V7OS7]Z@PR;@&CTN5e3KEG#0^aC8@Z2PaaJ(BO101
P=<HP?U_+/I7^-D\P9.(4e?_^@<X96DJ=OeK;V2BP&3)68GGHSI6G^7+/;9EV_:<
(BRGEMH#S+Z5R,gaKH8K=ENW0GCT8eGUb2BZ?=?&ZC+;[GgV3C]QB\<c5UI7,3R,
S:-T@B6K/R\6\,HebO@SKc95#DO&L[e9,a5)FC-ZV6/^B)Q>1R/M/=+c)@HMZ[bL
^5-SO?E@D>UW9^.09NF@KJ<,,e&,XXEB=aceT;EDL6eZ15=MJ4a[\T]PIO+^C5R\
TTWQB1E(B4Q=ZFDDd>.8a-?aI.,_bg6_BgC4e@164[b1AR@._fFfaf?QYXB_[@AU
Y&dT\QNC0LQS\^E5[89H[_BYb1V,QP&9=^HSK4H(eG-@<WE488,(/#=MAEEE0G[A
ES\9Q021fc+X_e2c6Gb[AgB)EWRdcP:6JU2B[.ZGUC^ED(ZIYd7>+ag@:)E(,9>B
fe/D@S<+JX3De7B2X1S0(SgM1)A>2.QK_-U/gLURV,_YU8@a4P#0P//&eCA)XOP:
872g1TN<Q^QOZ&5Y;EdSb(N@HG#[40Z1T3F0/LWb&4f3dH6C;>(02XC7OM#I2:6#
-G=?@ceZbRIW5&JSL1Z9+Z/S@B(b9cZR>6cAdCO\fNOT\U[YA0bW:-I)c&91=1,g
V^XMV@_\^;S#OR17\5PeF/I>72Bf-cNQ&K4&,d=.S_bf5A^C=Y/Dd00K6@MN5TSa
g3Mf4f^L:6QZE3dXaKXQZQL]])4c]\YHd?/Y-ID9<cH52g-]f0b^a438CNNI20X6
[+SdQ]Wg+R_b9f2=D,gBP]gI/Y@16ID6D^XGaILP/OZD2O2BK:M;G>eA2g5KEAdE
aN2H##d2#=:P/U6\K4?Y7.?6;cU_6A=)H2?f6eR6[YMJRN;bJfeV:JKC/N#e5g(.
Lg/L6-bBfdNU:.8@Qc+g1bOY9_)[U,9>e1.[I7\9bWFV13W>23.9BB#?],X;Wa,1
g81B6W?[P8XQL1-X2(-XAYNE1G=?ORY?,9#1=>U7;\/DB>,-&A1HWaNW/Z]1^KO5
0PWTYF9>W1?5]_.(>a/d-@3I,,bIZL[=4/1(A82WbdeeAR87T_gQeZH+DdQP/4#X
VA+gY7Z&Y8NgFEL6e)gK?B.Q5A?6+_bCL@&F6EPPAK5V4=VT;VGU/0\(.EWADZLK
2FKJ^&SbPUT-c^ZEG&S&-I#B5B=eBP&ag&\WPSB.f?+gdYUW03NVSNS=c[W(:?SV
KU0gPMDC_&8;2O,S+Nd;S]RX8D5gDeC^A=5XK+/1@[N,>W^gXWS)94dE#U8e(QeS
FeRe?0I[A&G]<9Q:?=LP(=(#IHc9U#RCZ#Y:B/fY2B[PFQ0PE(&:[?be.NU\b9Da
bP(6)O;XI#f&_F0F;37=]bE4#3EK&R58aeTNa8Yc[cW=\b8R>aLAR3e+I#(1KL[D
KVBQQGXC<SBC;E@:XKfKM(852U>LeR?LN]4M,?NcYE)S6LbdZE/4]8&V3.Q@P/G_
0SJ8T,&P>;_9<1H<,+B3IX\&:[@L8_e7MH6/G2a,Q+P/A73)I><)D.]8<6&Jf_CK
X+S=EVe-?SU@;&OR_NDT_TgKf.PJeYX\).]XW+<cbYK49W,^a.DM###e7AI<cC[N
MQ-P\M^_dC<&L3E\bFR>79R;afYg^CZ_Rd;#G^F?.?bO;Hc;4AGf/[CcS);O&S_R
)X3D_feUY?;,69LDbcaPd;LXGO-b<0&EcHVHYZ1F-N:dbCdC[MZSP_7e&[+OE1HI
Y#^[bUA3WC[&J.8A.:2Pb\U3EL]gdK__UAG5H6ag6\F2QJ#KeJcF.fbXSg]B<5^g
_=Y_D-YZ_U:1eB&cU_F.<VQR#C&[8Jd\X]bc:)ee_U5e7A9JQ6]SZMD>^?<Fed(c
,b=&WWd;?6[=2DBVRfa9\-/0UOO_c6c,+9V,YMWM&:bFR_1APN1eQf+=^Fc6:Wf#
4_XGWRPK81,\:06VcC>M)MT@.2<[/fXHZG]5CAE#_:Y.>=2UgLX1QZ(#1^MBc+>b
9/e2S4\^1#A>3/B98R-KP:dg:d<NNV]Y<[#F^.9?,g2/05_=O7QX7SX&+B6.H,?2
Gc<dRZ;EfGb<b+c-5/KGUY[eIQP^C3H+NJ[[Z=C9SBHG/Ie6Zb0A+<F]GRaZTBH0
M([^bJ6aTNRQgaCHZA;#OeT9SgBIXK+CT8XfMOTc2XWMe6I]5/4>0EOd.NLfUf1^
0F-77N];,EJf8K:cBWR-05dXG.D&\)AY,T[7X5\EWW>;NIS?FZ_:\RUO[0KG7]JS
H_9CWGSN=TWVE+Hg;VY+Xe,W#J&KH0AUQP;\4<;5fYK^D.I[5XH:_1bN\8Nc]XKP
RA&5E<)+4Mc6]:CRG0,723\SHQ\AEQU_<V4WLVHO<,@RQA#:1FVGAbD[7FRaY):<
Rg09TgZ;]-EX0\;HU2KBFRe.>Y+4H2c&W3Z/\N146P9d]Aea:?NU?Z&=DN/O>:?Y
IPUU1-HP)._HK#5+,f0]d@W^Z3/+?)>9J(97=DQCgfEB=@<Zaa(C4VE[<?YX0dIT
@24UcI7Bb4Yd?.GS4G3KE>X#)d.<T#O_BbR#edHL)0(;^>BK^&]9I+BQ.;2<80UZ
+&f+e0IaM,3,/8.XZ[V>)+@[a>c>PRG13>U(0^WIB_[AP0)2[Q2E?S..AKL0ScKG
?IT+\fd,]^7XG8UNGA.B](16=_S=FC<BTB3@Kb7]cSE2C[T^_T1FadVa2Ff&;G=K
3d_R329M7MZ,G49G=7,dG]K2eN>:#GH[=BI+-.c.)AT.,R-+X8K.LOM<X,ZD26>\
;)R#cV08Kc:^dG:&bZ:M8:5#E&6,6WOZFc8-7X=<,=:f)3+;ddT]cG<T9fC&S/G3
U(eVD(LCg^YB>eN9EI>e<_MdMO_M&.W\_.UEeRF5&&XWgf.F#DZEWM+FHIN4Y?F3
M5@U+(R2U7daV,>MO&H:eG0RN+\TXMTZN(ET]7(R\D11Y9:N4V<M]),c5+2WJWJ;
E=^MGZD0DC[]Ne2S-:d4bfKGI:=?XHQRHB<3+SbbgWHLL>aM28aegU8AX\4aH.;W
]LJcHX0,9a?FF(.K1C.VNGN\)c.3.-4IN\cZB#05[@K:Tg?;cP+IgQFRQX&#(:7H
GYHPKE85&55X.T=]aX[,b/BZ_LPf,W\>WDXNNA_/cX4UMY+d594^2#GPU9CH-CUB
W:G6BSY^ec73G[3Cf#;IBFg\^[7+\.X+aeHC,<fgbUFGKVcY(FaCd1RU&:X5+2Ge
GNbCH(?:+<OV_BR-D:Ue20\QCCF-_DLG:6K5J-EV#b-_8>@>eA9WPAXWbF0#<5O7
I0CN7/=JT0WBaDf=OIGY5X,4-,;9@a+?_@=eJ[]A57gF3U7LffO^F@PfeBP+\,4L
f11PFR.)Cg.L8>]_ZRRTRXac)6616IFM^XIf+IV&c#_,94XQR@2+2C=R=bXIQL+M
219)5gf5#G28KRG8[ECI4;JVH&DI[DH]I=##bSd#(W8d;XE/C[S85[/=J;&+N_,,
C3/ge;?^fgTe+>]G:eWaB,)2M@7#MKL=&DAL>Md/I>gC?c_J@aD2>,F7(Xb-]KR/
RJ9ZCQXd+LMC-1=W0.0X5MD1T0V,-9cf^48-bS7?0,TG#1VL@[\(JWU3]LZc+XK2
5LN@Y9(^?ZWC.$
`endprotected

   `protected
CQM[c4XOB;8dD,f,CR\9Y?+G0TYT+fI:g_X75g,UQ)&QJ)?KM#3d.)e(<ZN\b&e^
67)Z3.fP9^RMOZgKbM+JI5+G4$
`endprotected

   //vcs_vip_protect
   `protected
I5ECS>Z\;-g_<UDd>BDP5T2eN]e]6^SY6^E?aQG<0GPH>MH-Q30@1(@C6gZ^@OE)
Ze(&<+E#QQ;EXTgKBC\1(P[:HL(+8Dge;E-=^Tf.S3^aCGAFB([>>O3RESD;1RE_
P56dU3SDUP?T?7\+gA.)bF;TdT(MST(Q&0OC.EI2gVTQWEITeV>-.3C&5U;7ZP+:
,U;-S8OZT<D,gX^^&CgROHge]E>.P)PT<6?7QAWQ\BFb]6<__>9[@^e=\(_CNSL/
/?UCG[aO_#+AEXEC-2W:JV7f3e(-EO;CE_#:BRA7A_dL6cX:_G_TFN+CYE@cH+=T
PX[>#Q1@BCLI8]TF@)0gEH^UTEVOL,8bf0.&NMf#J:+XV03,BKO_6#-8LP;=BKA&
O_@,]^8aMPPVBU7P1#T2HXNN2/F+N,@.NSGg^-B#GAJ#G^50;;Z3<7<R,8<]bPUS
^QRQ_/C0>F;G;RJ1/=eMSS=>:?=gWN^&TDG=^Hd#;?T./P3a1@PC8UJ6B@.Hd]Bb
-BT?W.D1^=7Ad^TaeBW>3OKMZMU@6A71Gf,A4X.R3X-eKEcFWQ@?QdCH<[)bfQSM
eg?,fGD6LBW(Q;;JK5UIAgYDU3XWfG=LD2T+F+f^WR.P^:MQ-]?SGZK0(ET5:T&.
N#5SU#6>2-DVA+9C&S;f#HUAP(1LBc0BVH\@/0?&f?-:BLX4db0/a[M])IR<b4YN
QY,,)a]QJb\FU93+);;OWE<0#9235>Wa>+aDO0W&2[1CAf(a^6g95OJN22#QddEJ
85:6?[U_FW/9=L_SM\6TAE4L\aBE2b)8DR?GK[T;L_BOIVQ7L>[DZQP2b.-J9VXE
;P=6G)8S.@^=0HfHN1+A-Y;e@-GB6B9N:N263AYM^NHe.Z[,WHCYb@#)a3QCJ/1D
e,2KUCEe9A?SH69E^=R.C])c];2<Nd-<>_D08[d,b&f1&6ZaT?:7HEf;CMV5=9+N
dG#@;[IMRGBMO@:5Y60=A7S05\cD:V83AWQBLf44)55XQ7E#?XadgLQ=XgB&.J6I
@ae-=WXUY_Qe0SMT)/_a2+d24VP5fH.MDa?-;)=OVZK-5JQd9<4/>d?gbB74]g8(
:GbdU&AQ9@++W[]e(/5:1&cbU?[^)L#RLJfX6(FW?U[WR??.YCSFK156\EgZUS8:
8EZ2^1:D>gdP\/5Rg:R56<[J]4cBZZ0,]TL8I+Te1HYUTAPb9/dHe4O\XTI0f/_?
G/:Gd^88NFc2BPKP(A_eO<S\\YJ7026H)EfB<B6=J4\,L=&^WC^+GX@J_CUZXO:U
IOPLTPU0&26\UBFR:F3_QN[W3BU](U6GccU?,cb8g@=:F=YTB144J8I2-f+-53(?
EMA6dUCN_;1;?P40d2P&E1&(12?@5690.A:ZG6^Y7I#Pd<(R^&?4LYT-7.9J;YYL
C]U<cb#6<d@Q=EZ1N#\1b3?>H(Q[(PDJ[2HWCZSZTF2;eO6YaBE52BIX_WGQI,/;
+7P+->,fT4V[BIB#N-1H.d+_X#Gd</EVJY/65&fb)7bH8F2,0D;BJ&c_Z[=F=V>=
WTP:NV3ZXWW3CNH(S3\<,BC_^073]884I#,\1dN:30]JNU\PFL2Wc&+/Y:O4CJMg
3-4BHHRFZ+I[)PP)&<8][Z72?f:5DQGf?F8<[L3S]&MdB)QU/TZ8)AKMH6=F706K
I:#T(aSA\Q65T5<8X0#HFfB.GIWg5U;>N@dZHB_:)TP^)eb8bCA4&>DaK1JP^7@.
Y-[TeYGN@3/^)Z;IS<HY?7+7dR-7)9R-+e0L5:HF94=:_)Rd[UHO@7c#e9O/ScA+
R_=J>b/#WPUZdT@cM&35aFNFG<STgSAINOfgE0bc4(/Qd7=QNf6Y3J@<Fg67fCK9
+>CFX8Ra<;739XLVRL/(J1NAA6FaL_N]UbTC(6P]I99H7,#@FH)B@bRV7a63XTZE
-@3RY3ZNYH(&JZ,L;;g@[5:d@FHJ?GgN;;bCG/LLQX[ReE:<O&S<YK(<C0La:U9/
_KMYVS<dMa)A0YIP79f6<N?JQ9&J4B.H.C1f^ME=Od6)?L+TgCRTcf9cP>0/65Z\
LL.L&>Ab4Ka6HM@TU2:Db,J[1)dZ8a-Hcf<<2B1M,O@@B;B_ReK4bE05/85=Ff-H
<6Fe2d46L<]=.e8WX[28H@aK56/#aS(fB_R-<JO<acWX18P@1][-PgH/BP&Q2M0?
Q8,I8<D-+;X\B0_\INHL\-cPKK1:@JMK(P\JBX;OYZ>/?X6D,KGFODQA67]XbAZe
YI5SNY+f3g-9a7d=(gW\W(G?^:4,US2(G@;/950,Q^.(Gb.S/C,VL--^a678T291
&1+U#D&?-bL-5bdIN.H,P&W79b@PPN41g-YNK9V2,#@3Fd)f:L=@CHY;R=/VY8aJ
GFCaKQYN:MU:&Rcg]0=)J<cL@g4G]^(3;95J,TMZ1.]DL;T80aBKZKSE3[#4e5g(
T;JbLN_0P^YGK,^dbJY^:/cL1$
`endprotected

  `protected
gZ75\OUZKE_.AINN,],N<X1ZE:<E]8@]KR?N\Ge,eHcV3.PO[ZGg2)JfdZ?&U?.3
\[=BP:</_W[..$
`endprotected

  //vcs_vip_protect
  `protected
OS7G;(]F:FH4fgY15,9QA@WI6\]JA5&-63[CS43HE>;,3YF8@,\K+(:L#f=^eNTL
cP#<#REQYNaL>4aQ2d\C/T8e(ORVKJ.EB-O&IIZE;_]9f3aK/T<_0^7N6H.4,b7P
8N0a2U\BQWHE[H59?(Fa:XW?#S=7D>H)MQ-JGYE=:AC]XgT&20^:<R5B>:,)U_4g
.agD)a-c,&cO56DOGE(6X1^T]-IDbaUXW6(&aIUKI:T\)/U2ELAP;P3UUKLgBR+H
Rga#E?1:/2IEYMC_Ja,eJ8\\]Se70[+1<(WdY9DUQK54#cZ7NU>a.=dZASU_E/Ka
IbbJBPGNeURG\K:YeQ:<b/#TJGaTb1BBBV9/1#aZ^:aW9(YRKEZ-?d=SO#R#[[YJ
:SDG\fQJ0SXeX@ZcS3Z_;FH[5/f)11f;1J)cV4I9P[+J6J+<;0EBVW&gbcA,IB+6
BEf/a-F],bNRLa?=S;:I)8T/+^<[_;3W31bOAd=11Me\ZYBgfc\:1SE7\<^A^IO.
X+WN3DM)FQFb2\.7@Wa7fKfLTSM+6X[IH/7]/I(Z1<WA,_;Z9G@_fONH[^,S]e?I
7AZ3H+c897dM?6&J^Q2<3Ad3NH/),d52T?@a1&UZ3;JdZ:Fa8f3I1>(E.Le>XB9g
<7.?3Ff9EX.?H[Q^MQ^96a)HX.]WAK-G+CS:N<cX_YC).J[^5W<G9TUYG>44-)7O
@1D_[TQ5AQ6Qdd]I:3EO3T.</53]+Wc5bB<7eY[)@;K334T=@6<<aFF<1&/TOL(P
J<;_MC@L-N/R3O@[eQg?4DBXNWfS:]?_bFR6[FM9JbA)Z[9)T.S1MBRX_dUYF3V:
-)>a+Xa1U3Y=OA/cLC,.9JYIP@EX/P+G)U>WB0A():6H/O#5f<UKMg[Ac76=HfC2
]VRPB(_TM9NS7[^&U=<2DKcHbY:V#U&AW^bCJ&0d49-4VNaMX44+2gQGc)Z>b]f6
0TRGLY>MG)HKgfXdM(ZKXNV@W,X^e0V4f.GG9#Uc(9:I3N.GTY?a9M[Z8O?Vf/Ig
A[MM1D/G^=.AQR(4H(b,<\,P+(,YLHX)<5@L>\;+f]Y1YTMfSWfXZ28HJ=J+D/94
O>>.W6@9aEH/GZ<:\R?BE(D&GcLPQZ#D7fJ=:;R&HBbf4/8F4\11-b\C@cIO^6b:
Rb1B=-=,.620C9f=S.Lf+f4]Sga]O]PD9N8=3a=WS>S-gVPR2bD]]G6_K?[0[@8[
=65f2UZQ7X(YR5T@J?g:B^3d-H_-.a<W;=bFccU99c]U&B/,(<#VWO?,YB6=0B56
9PB(3^Ce/QZXE+92f0[ST_2?OW=ZGS7&>]]3GI__?E:-e-HE3g[?AJ(:/H_NQ\(c
PI[G&=URQWQ.OS9FIG>?<OOM4DfFcCDT&&BKT&T,4@=D(7ed:QMT6-X;.HRcEOJP
-WF/\aB9d0]Y5GRC>;Ld:UQ@aPdW<H\)##T0R4J:Z6UU.<3H2[S+P/KBaK:Y\Pa8
Z_d(d.f_BEGTVQd@M:<U\RKQf+WH)W6a<ICbXB/_:fZPN/;0F]DHeg47\_4F-AXc
#6Bc#SQD<bK;,E,53A>](gdM-5]=@e+=#XSD9.>8W+OIM5cP^4@bY62Fa]V3E#A8
];_Xb)N]T.g]J8GWWf&?B^03SM&a7<+A4:UE=7FVJ,YAV:@acLdS<E#@^F1VIgb>
?I<JO6f>DBV2+53WDZ-8&-CbI)44,R;bgJ2Ng\NZY_##J6J6_IE0KQ58P>=W:ab^
^+;GN0_3eMc8(AG5:a<;>UaIGa_V6)2g@2;)U#Z,-RT[V81^Q:)#R)4GSPHC?499
+VA1F=(8T&J^bT&#/=UO5.1?P)3D7#(+7NM_?4+M6:==F8@.PK&KRB0,5.5Z]H.c
cL/W9V,J+O<F0Y0J[N+)]4]@HW//8#Z;PFJ31L\O-J);3I#KD?ZXE#=+Y3ZW#J)N
:e2[?+9O=Q/[DG&RL<+-8.T8AOI>=&AeVH1f-:5_0UIDIZT_NS:3:P0O]N65VaT?
Jg;cIAReHa6[_G0fS^4aQTfPTA/7)gHB1Lb,f4SID)_@X?3Z=Le:F&?B\)aa/BK#
C:]]GXZMY.?K^-H#(E^PO3=>(>_,_f>^U&Z:TX<W\OCVJ4f_63-&Sa31:641[fQ1
)dR(Q&)9[6[/U2CTe9]6,Q3/Wd+^cDKB8ZSQ:JC>?0,;WEGef)\#c,XFD,&)NIN4
Gbe5aA)Fe6Y3:\\&;@.P@:1D_&\>R-QbJB4AWHL@.DJ_3JTg\fP:3[\JQBY?D5T:
?1S_[aeF762<.#bf132M8=15(G;Y<)d3]-KZR8e\&DedRT0[=N-N;H9=V?)gc?[.
-YHJV@]9XPQE8eH,KR\E?40U&LZHTe4R.N,cHFQ93a.]G5W3_:<GbS.]J^K]3/:L
3\:?NG1L1[IG?K@fEJb>_e;JfJS511?c32b+S0>D6_=JCMP0BEG4ZFC2<?DBScQb
+5/aO-+^Aa3XFP_a9d8DYX\3LQEPJG6<SH50Jg5_80VZF\L#F],8T0H2K\2@3LK9
9RUF0D=#>=?Egc9#S7[b\ID2=O2Q?9ML0d+Ec<55GIO?7#U&UEVG83d3ZNR?#Of>
^W4:^cQ1>GX52-\EA47^&F=-<F[EFBPdWKZM6N<?Ga2USdP3Q2<JQ/0??f^=@WBY
-=6a_SW&IG5@S(eNKC2&Zg&T>^LR:S3<YLA_e+M(:H[[ZNI+cP)aC5,_Z56\4MXe
K10gdQ;KSIYP4@IVHScAf#[5_FOC3:LZ>bT-6:g5AFEc]1,Vb07=.0_KIa9_9NBg
9LGd4R8g2KTQX@fI57^AI260.D:g^-HQ)AH5OI=/Y0\4#Ga29G0GeYU-eX3[e,)V
+[PZU50C/\,J_g]\GE6cEOgT<PNJ\&D-f=6A\e25_5gAJOH^2dN\1K[1OJI@QV(\
a<F\>fIFgDTU,3)6Ub@b\K?dc+X^K[fYQ?GDGWRJZ7+P9_E+.Lb)RFJga6CH/[P)
[D9/@94YQP9T_Y5J9UB2L-O60F/&TI;/BO)^_:7TB6Z-#1D=Ia>I)LJ?JJIKT+VG
LW43NQKeCfDBUYM80-g.f:=<[;L2.RA7VD3[aB]#JA]&_POIV>335P)eA4[?7<CY
/;9GY=.DZ?bAR#dPe?caJY<)O>3BL7=5B)9@?b:J,?&CZA:I8C3T,7(ddYO=&eIc
c9TKUG6/,bg/Te:Z4_\5A1EHG\BWV^@e\QEMfZB,6LFf>Q^X0D<,0RcH34dbCJLb
g&VIc>8)dAL/[eX2FCZHa&9<SW?//P8a&R\CGC@5YgR((fR_\^Q<Q&A1b8@+2S1P
O+Db=gT&75b^cd9U4HS5RYL/3e=YCQ4R98SIUH>0/YWgKJG>0HAPTA:[,dUb/S6:
7GE,a&O1Z8G(D-3cFI-\3EN#GPG1-gSOX6Z^eAW,4==UH?D/IO#LZd17#e)E_4gY
#D[YEB#]f8FKV4)ECH&L>(0AF/76SSFI#NBHfBIC@.[?Jc4C8eMGR&9(6CE#(9[)
gOO.DPXbOK.+7\&e>@-dB_XO93_--);Rcb#)J3P42[,?Tc97.0f99eb2?B?E<M[a
31EYAX5[@=HT=DMGYbf?WEa/cJ&Ra+U@ZDL?-LBBbWH=:)8##K3AX\gf1ZR,3Rg<
Y2fS2+19W\eNdJMXB?Sc3bM+e8K.=E3EJ9c>+D&8<WI,;JfcLI\5T1;@2aQG&I\^
B1Z^RY+/Z#\DDR]]L@U_S>c494b_6=)-DB3Ce6=KRW7#+R?V_Og1@3GH:M5M)4TY
eYWH&176^&ga_M>2WB/LC4+5UX&BdRZ8Tf:VC^-g1)=H3DO35S]C:ZZI\T6=-X0;
PA:g-Z_-&16V14+Y(>,)\)\+EJ4e51UQ#D.g400/\g43H5gaL998:1(/U+\=Y-#,
;VNG_@<#<7MIDU-#Jb#T)J1RV1e8@:J1C;>9TCPcX31b.3:)?5V]F.CXWg_fWOb-
cPA]=X;&aTQSPIF\]#9SKF+_ZW4-X+Yaf1R^LA@<T9Vd6\4c0@&PXB5bC8f8\Jfe
:1+)5FMca/MJGD7W49J.99^M4,4QGf6CcSP.S=<+?Z5YD8<P?^J_&6.]JP&Ca,.G
YN;^U=Z58EA4_Q_eMFb:T=@CH,NX>C9^)4Uf8F=..9#B9/.1a:)D^6TIT=8PcN7W
_M7-Yc^^13+,8^WZ5=@49<.Xc4:S3CC8[)+22JDR#,-&<7=R9Wf-3[G@T,U>#L7F
(6\R[:M#<AGT=KEN0f<[e;J8Ra8@YRUF&)+#8[5b,/U+V/4_gU,>?IU\E4N>d&K=
OJ=1KJTOEMR=:6KT3fJJXJG#5C4S^<6G3P4#)VHCJ=+.[-=d\Ddd,Z<VFNXB3NQ]
5_-F15KQf)U=)>Y?#E50FGBg]C[\GBWVbAdL:+JZH?N4EdWSL?Y29#c;_,G]U/BW
)DV8bNTLBC5-.)-U18bNFL,UIY)]F&)?gc4_XOF3J[H9JLQT1;3.5?.(W6_10RSG
LQ]4O4PI/L[Yg]K=\8O3(a-fdQ=B38d9YD69LU^@:LdR[+J)7c6ZA8B(2QYdOW>R
<T>,7+,.V__e>)2?W,[g1)#;a?0,.bP)JXDK4gAffX(N2+UDPg[X<EKZN-)G:M72
f:,:-I?B;Y^0e45UQE+@LEYDE=/<+=ET(bfDD:\eQ?0Q0K;ce4JB8Y[0/[BgT/C/
@<TW\gQc#f\7Z#TLHXP#[<R^YT6TK&.(aHA/P?E^Ue^73LY4/P,4,:Q[WN\9Wb+.
R[AHEO6XF@F-ETc_K8K03@dWKa=>b7/^.E=E]0@QQaIa=A.0H>JK8Q^3D-dMQ=#B
]QBVe2F0PY;H5:d0A<)Q?.MZAHQ\JC4\>EBgQ-FWB4D@(/JHR5TF.[fS1=I(/Q;)
VEd-2;bPN-&YG=?cH7LH>\TVJ@?-9<^MX7R5a^?&Mff=QKS3A.IJSML8/A>9=Mb;
;KH=H7[E<X&2Qb@cK\FAMDe[AAOKgI0@YUK_DB+cL]^cg/D(_3,?a[-J1Rdg_GH=
K3a&7?VVOeO7Te#aZ/>K[WeCe0OAF^a[X7abCOGRX@4b0VPS2IUgG+gZ)EQ,9=g:
7LTR)O&]R67>K.-X9:W6>^6_TaMc<a_V8bP6.HFBEEX7e2/TPY+g>M\?<]=#ecGX
f19+GJ<\gDTS+>JZ464/EUc(9XdM_S5LG?&9CQJTRaD9P-]JGO#OZ4JJ6V9X6^&S
9\HARWJ32)>&F=DLVK_:(^[B)Q[DgJ2LE,).A7<0VDWW@XA33fFUa9bE+2RdIe1H
6/X>_(3Ua\?0L5Z&2(A:,1T1/G-QKd]JB+1=F4DG-g1Q/ZRD70d(=#NdK@[+&\[S
_ec9Y72g8Qa4cLc04?8A#_=G(\CN9ZKOc7NV>3JYS50GV[<Y]O;E@D<^-I5g=)+9
/]-EA(G9:AH?S+:Q2[IEP1#9?)RcR4N:@DR)5)B-eJDK.#([CZ@GeXF#B&,e6c1Z
587@95,^W?(N1a99XW?R@H[B-S)#[aJ50Y]ES?#CN&KK5ZUADO0IbI2M\9.2ANJ2
ES^bW0=e#RB^JdO@.BQXg0Vc5:GC1<)?OL>X@_?5>-YTS&>TBeg2VXd++K(#fDD0
51E1;gL^.[eOa6#<EXCUMS3L64;<UQ@>A#Q1Xe\1C;#3@1_09(<8UHU/2-e,J^FO
JQ0LW#F(<VSUN/Z2N7-R.UX^.HaQ+PgPF3>?0(<V2Pb@eIRg-^NH[4.+YK@PO>VW
IGY\aGL0KPa(+7_-5VWfI5^F-JJ.>S/VAF#cYb-@;NMOIc2eWF:?Ec\Hg8=3L[0-
^_?CNX9S)EfW/N9X.SGL9[WO+HS/BK)-\61Ec5QZ)]gJHHf:WN3XB&\3;?e6Dc=S
9ZMM=)g-\V1)Sd<G[2LAgV5-;SP1_=7(W,09FTJWJS2R:HC>d[JDG3G43_56+;@S
-=aIL0^TUB)Jeb#T7H<2Q(/7TcP]F[-6)W&4F3a5[-=@?4-f7,\KcG7SSc[YeBdc
PWS7dd0F,MRGE&A/RPdFZ+4[aFU8?[gP0]+(Cbg:g<C2X8SVBZGf)/S9bMAG+BO[
F3W9<@I?0(E/1FQX=9?UPY9L/Yc(ePXT;&8#FL0GUM7^0)P)b5G8Cg#=RQ_EG,1&
AZ_44RdD6KaGFJ=T[fRN9.V<1d#G3e.f2?B:L),<4C4Be+\>K_3b3I.,+=OI#X@1
(W+HeC-^fcII+A<<J8<J_59ND8a9[LUJ&<B::f[\#80(A3S-8IYVYZLVK&SCHY.D
WJ^P8=De#XG,&(:[:Z-g0Z>afN&=OW;dW/QRRaH\]dP:4D?bAI:12TZ-;f;(9:HF
.RNH_?BU@O<>+gC,_YF<6J+(X):0aG/eBPa,bA;I5M:;&JC-BUe9IBOM910ODGSH
.7D/H5bL6g+L@9Zg7H^;DV^-fDb;Tcb>F(D7aM_B0&/A_V6cVL[<XGN<D6>,/AE_
)c4QNZSF:?Kfe4K0C](#U1+BAG9c7#:TLJ(TF.@1FF9M)V1O9&c>S=\;E#f)cXFH
4E[:X=21LCJ2=?&B&\aaN5HEd]S]B4eYE&^U\8JYcB,[6F:X&@Va=M;JS/;WcaY6
O,&<YNF)Y3bMWX<:<1IGF&^JYQ<XW18^=8XE2Q7@UO-FSX_<0,A\9HZPV6?>I4_L
EN;#S^((078KS;a&Q<,<++\G&8[:5Kc=#;4E=.H2?J>_G97OfS-MC[?022GBUWc=
a+)f12&G]X:^.EOd>b#N:3P0>V+eJ_.1D>?SJ,=@[f0HI\T):[V^Cg\+Be(\3fBU
WMBb,/H-bYS<<A5#M2I&dEXc]67J]V0QWK4f/A7WdC]@.XI:O;T)9Y)_R]TKAW5X
AYJTAGLF,ND#8gND#F<c(R\TS^Y>EOT3I@&VeM;N1\=Cg]Ued8#X<(JIIO7V3@(G
2gEY5IEK;,COCF[eE1G<^3QDQ/g5W<YZMO#.<D10>.gQ(XDWZU3?_4N1:+^&7)2V
T?04]_R_8>L/#5bXC[WLb.C0O4V#.KHWEKT)ZaCAMgA5)=A&)1QH)&(#?7B7.Q5V
DF.3/F>@-;+6SLSS<2=A3UYCbfTTU6PW30,8/XLZ,4B^Me.2NQe?(])7C1(<,Xd&
X57XO,.gc5:IW0]cT?XEU9g:b<5T^/Cd]/cc;8BJ,_bRCQ2[NCP.9YRI-1=7EWG)
0EV83090d3c-Z;eOF5J/<EC+R&bN&>59SPCI2O:K,=S.]1d86CbEMGF?_OX^6YHf
T5fZAO#GFdd(D87,X171d2TcCQ5?0SL&IT:Ob)P(3].A6dG-9OK\[:X\4P]064>&
ANF8#C-M35D4EedaZ\DD[TYI/4cNP:FLL^UJ9<L;da2#5M8Z8?4AYSLJ>@6(/=RN
27[3C)5I6A&^&?aVO\,MgIKH.D[CSE-#PNKK=45g8&PYJ>9HNK]:N#JYRMO(cfNM
G;41PM6Y)J==U6BJB,H:D/;15NW@/)8AQ9D&\CSX&/Va9XJ+W1-@Mfb34POT47R3
GHA:Vde&;WcUc8?Q4E[Yb=YT]A3dCQL:Y=6/]&WUdLV^:3B+#FZ-&^W<]L1LL;?W
8SQ;c_TeO_M32283KbQ=N:K/:[;UW_5Y?RO_c?0LP/K==9)b_0bHHJ3/aR^LA8]c
_e6Y_?-MZaB>Q6dffb>3)8+V1Q5b).c&ZG)(6TbOLJ73[>e&?CJCBBK8P7_ACA<;
+^;]::WaOMR@\QFdV[eY@CIeWM5IQCU-Gb5_756a748dH0,:)1cK2(G1S1XLc0FI
_3C&R5ecAXQ-5IIYXF]J#&N;@QJY@ZY0,+d]QeA5IA#@F?V,e9dP]a@S)2M#Yb-]
PPD.X[5_aK-:>#)Z#?:XGGGb(D_40\:(7fWQ>6B](/AZN\(5M>^EVf186Q2K+E-@
-1AYQG^:BL<G1=gS3DagI,@\/S2J6.:cgNQae=6+QaW-T^H4T2-Z3cc6GOKL[-W-
--CV9S5@\#I#c.K(?\QCAI5ec1g7K<90H]T8&8O1]3cCNLWF>TP&_6+gX2YYUR+6
)+gfYI7#<Z&f9ICZbX7](e7+3PZOV4gX8^TG_+>(T#/>gO_dPg.b<=D(U/6K;Iad
:#9CBZ/<OCUY]T.>N@OIDX5B&^N_,IaE)+d[P=e37_4EXf9JBT-#N6N/,=S(NB&+
F;C;L858XY9g0Ece?dXDNT=T@@+4-G;G+0Vbddb9,]W5)dM?c_RPTJ3-+KAS+6Q?
dS9K0BI0RC9bWJ7Mb<#_D_7cH:41;\d_NWGSSG20Q)A+0)XLYSPM[G\+U?Md>(I5
1_ESGW7EF,]X3@>S=/-)B\N[XX?0&-IbL)9&HU6@;cd2@R#)0Hc4(FAK(T>W<EK.
5&)16+3.<3gH)DFaY,#R-M2#ZCW;BI][A_X#T:AgS2O)#IffF):(a5(:T.8.4QH:
@=YBcKFJafU<.(Q4RK.^ZE_Tg3X&J0HKU[GcJL#;Q3ON8<1_Y\ZPBL=KP1W^2OZY
Q5);Agd.Eff&@gVebH-_gH#]1J^HP>>;44QW>2BYGI4V^c=dfcaJF\31TDZ2#V)&
GfQAK[&;OWNe6Gf7+&MOCK,Q6La8KVQ<E:VFXU6CUQ6EO]>/)BaNd(RR&HZe&=gY
G)ceR=>>\)7T#65>1d)&dUONO.ce[EY]a8XfBdg+5;9YA:GKdFV@de@OBK9D#7O7
#^2=/_NF:2R4Q/?,:2)\7/9<EG2[,S?7=:OWDO2RKMNbU#fC@@B_1MWEY=Q]e:@\
4U(\I/6^L(.A5PSRN=9EPL@E68)c+5gW+a,G05f>=VE&;L>2SZQY7N>.AD0#YPFF
RZg;C](#(FWUN37;S-@I6[ICZBc##<8T7eZ3/JG;3#+dR[)?JPaNF5;5-2D/,>Qg
?LB79D#HUA_g,_;R;Q8\U6Ne42M_T0747YL-ZCgJEC8SR>Og-GB,R;N0LU^E[B@?
_A[8.ZO+10HR#Fa6G?^@A(f6bF[8OVg>AU-JG:=@e#U@C4&P.,,eXb]12<I/EN9T
E;/J?a)XS1E]XNbGScTZ0aI/#_E6YI]H?7TF1ABLR#ReL&3D2I\CBGB>20RJDE<>
A5V:YWG+f+/QUa+b:J122FcLLDUM\:P34gAB;fGbHbR]Q(C3Kd+]#\FD@?.eeY&G
_11?+X\Pb4_^gD<V@=EC_HQ)DZc94g7Ja/XGSIKH#BC42IMd7S@.?dDXHQS/+#_:
fRcdMN>X;#HS0Y).#W=+e\_YVF(g?2[,<gF6b,bJUN/]6_W[cB70[,8I\WK/;c>/
R1gCCPE]3NN8OWE<gLQBB9M_Y&R><c-23S-MXJG5[,W;PK<7C&.OIB9W/a^^g]=f
;W5d5=RWcWeEBIO:YAcV3eO;Bb96PDK18CfQAZFD-aW>g=W8Sg)RMQ3A_D-RRC&P
A^OaX-V:1^N8W,AEdIVM,XQ_[;/#?4a84gG&;4V_<JJ5KCTb3#8_>g=8<5dJa\^/
MH-[]UYWV12I]@I6-IUgZM4:-CI47_9d30C05G<@R50#&J7M(XO>?\4C41^L2/B>
(+I.Ce08N6L(U(bd/V>6UcI,LBJHLXUX599I3L8743;g78g)[EEMTP0^g(M:;)/6
>KTdKG]3>E9]Z=]WJg+U;[f-G5-_]Cf][Ef61-&3N)7X6L[GW?;4.F,\ON6=2A>D
=<CCeQ=YV57bcJF<33Eb5/0-TE<Za2K,YaI]/;Tc)=\W(Q3^@;Ba?6;HB[1Y[PAD
H&811D8]b8C)gB#)7QW16d7/Wb&M?dAaGRH2LC5IbSTg_OS^\(Xf@dP4<&&<LB--
-T5:D;TUQM&V1&G;?8461>>G+2Z@:)O:PBXb;JSg>:a<LUPHO=BYPP)DU#=SXH72
+ZBVPA+RZXA#\BXHaRSeG?EQ.&F6K5CJ_8:O8c#\KRMG?bOQGK\0;S2ZNV0-U4\6
EOb@Oe(2NW(R\T1PP;aO9JeGcP[OS8@R^U0.9,7LSJ8R1R8>UY_<E5:d#d+1a2]N
<2O19Vf#11_W[FP#N3AZT9P^NN@1@-IF_f<ag>TG>)4WBS#A.d6]8;^OWd;O7D(?
RG<fAIe/4TH4@b0aQ7R/,J#H_X)RfM>>1,^gF+WeOG/W3,D\WQ^f]bJ?^[&;^,N<
.#U-PP35)E-6K-^)W-X&_/17?d4Z9A1F[Q@VS17gSIQVGa2R(SLgKa@aVR2&QGDc
IH[:JCPX<LfV#76^P&Z@=7..,=E+DQV4c7<@JYbJYAY3##^JV,LEZW3R3[ZF:PUP
AN[d]9GH\+89)=<_S9\P(LV\XC<ANYLC([]JF;b-)>^#6ZD<#>X>QP:5_.eYXXVR
DQYecT#7N?[ET</>eP^K6-R=I4Nd,c1)SV3eWF7>U;LWR2><,=<R)OSfY>+bXGH3
Z7C#R05\\UPEL6Rf_PGTL9YZ3Z6+@#7RLgDSgGIVU,^HM?+RY8,.-IF4\EV.\XJ)
_EW/#]2((HXJ6^e]PfTgI[E1S9SQ8XI9Jc=93C;a2PY.?6/G;&V_^8fFfO?9-[.T
0-e7eYJQ,AD?VXc+YJaY)>(9<YDJcC[@L;4FY>->/]R76c^)3[NFY;<ZKPN&f#8U
O12eX\RfNFG-^bcTA0Oe1WNQ_A.Z4[>PdR_#/)Z2@#^CGO2C2EEgfL4eT:U9GdA=
)(\E6.O3QC;<@CUVHge]4P=Vb3a?7^@:1GVCEcAF8QGg,:2OdF:DBRe1M?T>VSJR
KC#3&c5V?0XE:^a9Q]0Z8MZ6#0,Bb:CYBW0[S.0dS^Z[He1..d:T^ZcD5/1Q45XH
ELI0?E3#=RS4X#=)0\fRZDI3e-Z(e7]MaL=faSAGa6RP_S<8&dG01HV-ff(N=BJM
(d,#-FD=J@=cfCEB_;a6D?2cZ2@E=N9VBR]WLfV4B>-N6O[)T+VdFfYcG&^[6GC>
R#6QRD4@KLFXC=Y?67)\U7#,FD5@0g8Y[<5c2&<Q5+NB[K^=#T]VGT)(S23d^6#2
_.Y<A])QSd.b?6G&KDGLbORC7S0(b2/KY9H<Q#55QT#bK^#@#QVf:TUY22bSI/9,
RG./c>_aB&5K-F?F8QK]A+b504^NRPX64TeC5+b<91EOO3UJER?AI^S^gZL&W4YQ
H#HPD)d:6EOceL?#fRT)L11MK-7]1cc2M)9PN[+&ca&U[@)V\5UcBOA8I-YRXX#L
]ce2V0)FX(c9+8_:\c4_K?)EY6(B?^cbA_f63@O_;3Q^8595LHG]Se7/2>_S^=aZ
ZH4-YRI5[VAaA)G:63;,;IA30Ub(VUTNR_W>IYc&YSSP9=H^QNd+:PfG[gI1GLeD
H[gY<IIMC_#g8Z#8(M_4e0C-\:=8JXbdV_e?FY,cWPbH1--2?\,8;/(c>I)0;8^#
_&]HI7:3<.BST@YEJ=C#OK/X7X/JGI8DGOLaD2HBf#1?&0-R))N:72]1D0M2]G;7
WE7[N.\[;g,=>O.^E:WNG;@ORVS>Q3Rg9&Y55O=^0HeZ]gRb@RHJ0d_,86DJSeYR
S4;S8=\LZZe/4?Z)[2;HMaENbA-_XaE:ZZ]cRR,;-U:7GKE&(RD@/:)EcJ4KXQ?&
KSEKAaR<L)1+E3:e4e(X81BGUNTCZ1cK5]IN>g53OXV3I\(f1,GUA?Z[g>3g0Q>N
0fMN:]Ga+5;<W?62g-cNf_[PT]S?<STCWK(7BYS(J5EITae9S40]+7IYN)4[2H0-
F__6G@9+D?bWC>.-M\a8D+]3Sa<HMMaT8F;bWfKd3TGBf-DT_XH7JeKMGX,dU14M
GOL1L;Z4T:7<1^,;eU0]dRLB(@:8&:.c8ACR[627@d8?BU05aA_d#9fV)#bDJ5/g
A:[EFC21P/R.Q;f/Q+N-1eaGV\,,^7:eW0\O<7O)>_>^5]AP_)541aH;/([0X]aS
A6e>+K&+^4_1I_=c3-b)0[Re26aE/+]4[J_XHaYc<4W&cSL2I:UXPb+=fXRI73,^
EO#gH&Le-P-6Rf.[;LS0dHbAgG#R[I2L.D]eJ>1-[M6f=87aBOA2Xg>Wf>Td_GJ_
EV\=Ke?U,f2LL\/N1-3ASNcVOD,4L).@d@1)N;a/1U(ISU+Q=UYTKGbZgI0@[U+A
]H5OgX[I+_A<3He+6\I++\6:Wd;X-AC=9cXRZ=(8\S>9&RL(2TdTVQ9(XF<90&)<
XM]Z-.f0F;<U2,OZ/N(I^>KLB+cdFeWQTH-W\\)4a&+Q2_LOGK(E[]G&c1EYa<f0
-:>+8JY;4,VIE4bQSMaU8c<2<7c;1d/>FE)-JS=@^PaVV)AK0G/Zcb_)_@)KYO#.
BB(O)4[Ng53<)RTE>DXFZY>KG&[1R+65J?Z2+Dc)^-bYRSH-ZCg,SA3g]9O)J=JK
RE/dZX8F5[R0ENSRZUVJ3fD30_b0Y1=TgG0L)A,6YI#G9(c]+BX?a7bSAD+95g7U
Q:-cdPf86>H;e:]:5Z+-GF[@?T]@/SNaJVAC?[aE:HPTX<g\f^@4ba>2HMBB&WE4
eAIB?a/)2[QP++4CFBT]fVMP@X>Id4caC1^:2=PPSc5SQ.BE:)31BN2[VeRD5Ie@
NBHB&17E#U\NC0\7D1W#52OdKCR0ac?1>0BeJf#5C8?=5C5J]RT;R1[WX7)49;NW
,)eIM/\A[L0R.71?E_[VO6=AZBgcB;2UAL2\CDe3LaLf5.A3FK(ZXQWB.(.<CP]S
I?X(<MMJC_T/2JL^af;]KE9)>Zf0&QX&1G&4JK3TE,?8,66QdQ)SQda:Mg_E8N9(
a5#B7LFgNJ>eFT+GR5KHHG0+ffWS#CaOQR:DDPRZ/LB[7R=CK:UR]JZLd3[:8EL^
X/Y)_LUS<4[1@ee(Yc:-/bDU:TG4\8]T>?&BI6CeO(/VA)Q862H>,@cg=,E^Q->2
TM06PZLG+]<9I^TGN.6Q-/A9b)]#b1fU1D[CM.0>a178b(30ePR5=Zga.NNXG8Y6
c2JYK3KX^)?^^G_G<@Be6=f30g5LP3VDREU\4#Q><cWB-Q<f1;KK+GObV&Z3g]Ac
(aXJA5[1HLaI&G3P75Cb[IW2]7RbTb_=WGJ)a7BGMSL&fSD(=)c5]R7@V\)N,<QV
8^e-Y3C)-Qf,Z2cePA^NO@8=M7bB3IEA8R3@^+HMHNX=YNaZILYG=(a4O4Z-IgN:
&>X?\L(Q6c=GAWE3CDA8((@TFR;_C+^c_PW^9)H/)(Q?(T#d4KYC)TI)g-1DAdRa
f]WASASIX?&;9,DE9bI-H#a7.TaL=6P-^&IM]C1]a+&4Q89eN^#T)1XD.3-M#eHP
VAe)-AU8S1D<89gg8[N4QgY=Gg+L7+,K)N@Wae,eb+cf-,1W<<)(a1=+#&K/,:J1
&D:8ZK\#Y8MWH[QG<A+WFId^@EOD9Z]aA7GR/MPE7:(f/L1(8IXXIJ:P35UXNN6D
KTIA8UVZab9.O2G55UTSFC,,g;-aIYKWYF4a)M3_J=d8#62>_+gB_&B#N9?R?(YZ
2H8<H@QULBGf)+W55DMRgfC85^7=/f_YNWWYT(50A,^(6>VBe+f>[6@LE[FXe9XQ
F^A);8U3HY9J(CLgTL5N;CFcUHYV+(V^QT=WcY8AP213L/?F?a#(9NF&aS/Q17,Y
+XJ>)]B3>fFWT3ILX_)_=aDU46)g5B(]:@<S+N^NLMHK6]D/T#^(Q@29M5ZMTL&W
=?>JF&AA(ZB&[]KV1K@2_/-AA1g3J?Yd6D4+f.C.=_JEETZ),:?&XL,bSG,b>D7Y
8Zd:KQ9R<8\MJdPP=A]HVV>,5_N,d,KC,2CaGXLWNPST2?eaE.N&>L&/KG>0=O7e
CaUgFVT7T5FRe=F7fED_WO(PHXEKbBb,?d-;<Hd5NLSOLeB0G(&3e]Zg0OYIgUE>
W0@8_5<8;Y,IR)(Jd-#4>/82[?LLgF874ULAOFgS<f@==V\K1dQS/&.II#HZG^WD
X+V]F=@2#;501YZC,XRDIJ)@]/ZR/ZJ>AAE#.3M&F1BRf8:aYH/2U0FA<&bYGQ-O
O[VH4FSJ;:5B?GA9@-.@g25E9?4^)5g)CD1A+,V9FERDgbU8=K,BBIK6:DaE))eB
D;>IceUC<F\FUe:eFEe+79Sd<MRV@H\bbCVY0;KMEP:ZPCER:95W<0QP12]K;T;8
F7DW[TY+GQK[A@[85?g+MMXad_SC[:EH0/GT+RBG@74.Z/KJNOEB#(E4Q2<:,,Jc
8bd]c>U)1R9;#&^c[6I[_T&5Jg8bc2W>_gLD&.+bRbW6&T;+KbT-RT2cJE<B&J,+
9HDaJWZ9]KT?Zc=cHgY0R)TIL587EbNNPR-_;eC=fUDagbEUKVH7>SY^-AOaI1G)
g\+6/@_3_b<)T0GB?_-]:QGB0.VXM[6aV9N410@2^(=\BH2YA06:+J]+/[?@\6&b
QH\3PH/EH6b.c&M#K52#RSe9;OE[b4_aOfb>g8J>BTXa17I.e]A(<C0;/HF\0[G2
9WX4=6.SVPL.6?fGD8@1;a#\KD;EEEW#>(VZOAKB12M<gOF95VWX?9gd3>PcL^9U
Cb#RC.Y#,Dg+3.d7]^N9E+0e(@A+/PL0:C(>8E/OdRGXN]RP24_FXEgU\@X5V3<]
E10H.9>e4+#V&Q&XNA&?G:5d\R.]@O&Ja&45^AgD_^bF?A^ccdY(M8DD/K+8M3N@
G^ca=XA(Qg]]Y[WU_@b..WQ1J]AB(?1LBVUcTB4&eE_:-.#(_Lc@7BZEDDU]RXHK
B]dRVS:PNb&<bEO.5T7OB6^Cd0\PA6^JfQS=c._RN>b_>H=@IG^3/U&S_0VcV^>C
XY&NRFILR:3OGMeA#;(Q[;[W/U:BPQ0+W-C[dGGLVcF]SV4+B+?J((3AR7=g+S4O
fJ^b#LAOFYbPQC&X2/DDT1dcK+M#SO4:P,;X^9]88+c53^-a,T&C9UYLaXE4>F/b
;9&0GR8OO/e.^b6<9B:;F(FXOHF@PP_G>A#R)/5Ug/b_fG5TU)>MEW@dG]f]I?Ef
Wb@c#T53.>7ME&7=^)#U:4eF1-P/Zd7>P,5O/@/eK)V:XT6&9O@+]:gV;?&P,3Qe
XKTM&3CWQBF+fgV9]L:3aH.#]I/?O)<2C&6GBG:bFMFDa[9&.99VY9.-D&RCdRUR
Qd97<eY1F(UE+2d;IG3J>/MeO;WAG6M@7g#<CL-g5R>;9d)EH&S0d/_+3M)W9CN&
X)Z.FW1GdJIVDJQ;.#/H.B2&QJdRMWX./P4]V4=JB<&P2S5(e?]UI95#,9L=SMX(
T_D(g:C,a]GRO^@_XO=RSB>Y<Qf2P:C<U@AX-ZP29a<VdAU/<Nd]#?5?2FK^35B^
d6^8BcP1(/3+EgPKE\aH.&A;E8>eY>NG7T.NQXfS=[.4e^I#2ROfF5G;f+^HVgMT
7;ZMCVeM&eKKQR7HeON-WRP=5G1H,O]d8SY)V\0BYD=(9&((I[+]C+GV^6&YA-6V
S5Rc)9CZTd,Q;/=X^>GN6Y6UY>&_aZSO,.R@ZD6MKaF-O6CB.5ZV,@KMIacA;K(S
?/Eg:J0=Q-Kg..QIBB5RMTHBfR/Q]eS7P41+a(J5:>Q/\#<1N8TJIJAG=ZMXVY77
&TU3gG[[[9X;9N>TeGUYSb]/cRb]4CVE6@PeK&L-I]UP2:8L=5D6DS_\A:bQ1dd;
]@XS_dcNQN-7M/>11)9L5)9CgfgK<:.:FLNWJ]HE)8aGf7cX.ZLYf+.-:[@dM8cb
<g.E>>4WN/N8RbH#[D\QB(8L##gdK30I]R,CO7DeW;0HP=[NKO5_8PR_TF1-86]_
[-BL1[,a9T53ec@O?AAO1Oa+/KG>;J&AIR[#X2.7FL=c-3A9gCC:B]/ZDVdLZ/,]
=N&\(8@>SggD5gRW/VZ]dOMg5BOD[@WTV[gW0M?6P?.U^JM7K.HO=YWM-Pba5Ta6
L&1;GHHCROcQXJ:a(dQ;7#:>f@8.XcC&e<?BYaQ)Fc)J9@(cg]e>3/V7#ZDYJA4L
gd&X\&@C&g#E+bWeWC].)P\YX1Y9K#>S=.9/.Y\9>:&M587A,#R,G@6>NGJ0\e31
Ce9D>[Gd/b7&J5_FVII48M#_@IZ>,Pcc=\Q=\@)B=&4Vf@1EA#bIQX6IL>[.8^B.
LYDUd(b0O4.TfO4X##U>JN)R0,<BP>]AQ=R+8f/E5&1/[GG-&R^Z+]=>ZX[dM3g@
6+W7)-?S4^?0CZ:)6G>=.R?W@OS<)g7>?GS<856N[DA)LS-0EPVbF1&R#R)HH^AF
E).?[/K7RdS?OeZ:QAAT0L7dD^MAf6K5G[]\.+X#B_eI1YKKd5R_(,7EK8K71EW.
A9DMNH;OJSHY>-]TP9\[GWX^+ZP-acYNE08_3\S&V#:/4]Gd+-EV@Ydf64M3)T31
7N_DBD0P5RDSBbVMg-\1cAX^<[Sa#X0??0Mg+\]d7_e1dgX6G?(5Y#VC_YBH9P;;
\A->PXV2YcS-0TRE#B:]?^4Z:IK=&Bf5PfGbPD.=CN(P;FL+O56#?2UO7+4.8S8,
[J]6E40GEQ6IFR88b:<Z+@X.A30+-C]QL/=&EPC3ARE^Bc-bK4\ce#bPaJ<J:?Ng
KJdCB1GW9G#ONJL#CT;VGGF&cd05Y)B@X:YDCI;&R=H<LAB_Y-Q]]93^UGP1Q6G+
(f8-DQBB5R.P10\&XE=Wa@UICRAF@PKCdE>4YC<cF9M9DON4B2F1CURU_80eFLc-
(fUL7Ie0b06V@/f15\N,V7_&Z4BZH_N6+?2?<)V28?[Z3?SPP+&:1LH9\113;D?<
D[dVBMd1K#Z7_?]W_YL=#7O.G=/Y,NG5]5@?;_:=,Zd^11B?;T_.cWcF=:gSfO:V
C\IXCJN@V4DaX_#+I8.7:DcI-g?&R9gWQG.M2FGQ@,_Tb1.P66VI0_@[S=g;?\G&
CK/@UV(4WD\G087La<U-eY8#&c5EY(1G970;.Z&N6VEK((WK(E6c9T(Y+GQW?J0e
<g>2^W,L+@1P5]L9E+:[,TLAH-+L]6\7;CEQT&D^D[:Y4UaG0[X>BV:HO6A_2,86
DL3LeDJ94Tb?I>FKUQZ3QS)8D=@abVb-S/:[16\(L-A<OCI+1GG&UAV52P@WLRKK
^;_4>O848JR3.IG@VWfDSd_46c]>AG2^[8R[Z^I?=;/9d,QO9=4N5f+43JSL6,WL
LG1Ha:3LPX-.I/CL]N>6PI8.ecVA0GdQJ]b_R.U6KAA9>M@RI1;b>)B4C[cU0/18
cG#1\+:b@N:QQ7^5eR?0/L76a_MHEM6X<JQ,5ZK&HR@Kd==>@Q=@a.XJ0H^FP5cW
DZBKQ(=#[@:Q>09aeBE18b32RV;M>3XfA#W686)DX___LDY[;gaPFW5R^\-4Y_M&
27WdOPTd2NWCDO6CXEa_\(]cBNF[1\CX0<?\\A;OQ19d73#=G1_H4Gb5fJXdZ@4Z
.Eg6YUZVH:cMUZQ3)-;J#^0LFYRU3.GU;&f9gEgO43]YYKd:1\c-[9\H3IO3HcXc
SGXD]0be<?QbKDBRZ>BAc8fU(gX_:d6fO2VMJ)=7&QUZ@U8Y]R,UFe6A[#_1T2=K
J[G.5[7<+7J0\Mf,;R1[NfZ=PMU)#Af3D^C4?=SFa>e8PZY3UebbW#5B-6NI,2E#
:S;dfZAX,;ZA)IZbXO.dN@,Kc_0DNNQ<<&:,bedSd>Q/e^;g:V\g@3JCT9+K-I9#
:H\+HM)?53/EX\O4H4=N_+V=DfcJ>-5(I+\c3C=g5M-8/fBH;4eX&I4V8g3SP70Y
?@-f_O>g.g1.XRR;1@69NGOJ=+L4S\6B:]QJ>gXC844:E/H#fUVW/E27XA3<I010
=ZV7\]DZX)8W5(7VK00Z9[5F&/[S4VP)LIH_2PB^I3\YN1;&](ESR\-RIa:Gc^9d
H5LB/a93I8Sb#IQ-.;PXXCN^EU98dD)=W7S2PM,K?/E]\P[dMEZT4Wa0]Z:#DUI^
WXAR<RCW7GL^^5LgJG+K1<93@Z[M>X>(]R72e2RaY&CgB]JKb(bOQ@8O_Wa.;efe
X2eg++5^IKM^=M,DgY\6F2Y50ZY4I(RE-03X9>#AG<.8QNZ>P-=,d2eXKcfC89JK
T_a->1K[FH^8e<IT72\&a@\BE9+IOBd_J9Y(d#a7O4gJ\KH^&L4XP\E62_:L&G+]
M#ZeYHaT];=0[=AbAGC+<X,+_M1<Q-]^\+g39#G5VY_aDFFg9,.._YK+&>7afT37
AVVVI/Qa^5)@SeF0],Y)Z;f]/\FISBE1/WbVf4&^2M)9JTgWJ\M/C.]LIeCDKgRE
+C7E4c?fPMeIS>BB(S-J&g.YbK&7(7#P=T\3+3J[,>QC?JM8F1&6G;3/#(QcIM:S
UNGP2]<XUPD,).bP#45&I<_9\VE_V13?+e?=D7[L>:I&/0aSBR^.Jd/?XN/(=6H>
P83fSBJeV=#=^[Gc+PXC:Z@5DKQQ;fLR]6YdXRG5RSbN:)CM&6.d-/LQQ.\]dW,]
&HHOde]BIN3-SNF=D6^2MGBC;Qb_@e:-&CPQC3&a3d;aBJC4KQ.AW48c()KE9M]#
;T4fR1b8ODT=)6eBNOf9?1dV9Tfa,0&J8_ZM9=7C01[fDMK@/31e/X_Z,>DXV4VB
CU]>Y9TOD;I[_@MSZPHEFb;5Y1P7;X>E51<OKd,e9H/ZCLA2J<V](U5:-#9__b.)
P=.&@=PU=KQ;Q.3TV(?[F&DA5fABDC;0GMHS/[>M&De[\b+dM[WV(M.-GDQ]g:YP
5L96-IU@LC:(&A>T]R\T#I46bX,AI))X&MG)HPYfX:?S(_/]3W[bD6J[;YWC;U9D
^RX^-=QeDHZJcI\@gZBZMNY0e1_\5?78NE=OID,O0DdVN/FU9+][[c<IdM-OP3ZK
,b7:N4LNEgOT+E5[4VITF;H22]-QV=ZHb4N7YK6NF]0QO@>AE&^/?dO0c?>Z<_((
bS0-R;aBcDYV^N6)]OE3J81a>PGI/@32aa<Pc:GKL5&G1LU\aZ;N]L10)b]Wge06
],6C03T9BE^)Aa4^-(8D^,:WKF#NX&J9@?SS(8CI8LKW=&5B[4RWg:aJH#Rg^1?E
<HSAG9S)Q0caSRZcFR7+>3e\a@5XDI(C+U(BB@OWcXOOC6[@0\HRL?]0/ZONEc0e
CQ8AYff?+&LAC>_bA<ZN3F\60QW72&/^2P?4\&G8S;aWL3W2VgD\gS;c19^M3)45
5E..DH[+3?F2DIFd5RD/[N76C@b#&f>Z&)8:S\A7CJ:U;Tdb8=K>Mf[e3[>J7W)T
,6=DBf1SLAHe.R3XEL7eUCF@.Y,>eHGe.K7f7/:C^0BI+<JO53ROJ&S[JJ95PL>]
9b_D_a_+@=BHN<TT/dC)COMH^LGKcH](eY1@;6K1]cDS+MX)BbEg:g4NHgREcNTf
:E2&9HYUDZ<QLH&X\HZ9/fQ_:?USE7O5MV-<ETW)SGgIO46>bWV?<@XNLE\^VBHc
+BF?@Iga5Lee:/>\ZF/KOW=)MZWe06/Gb.@SP+&X9CT&=7+/,c,7W_9T:/eJG>g7
Vc4E]<6LJAAcg7VA&U-7U=AH:G:+4MZMPTb=I<PFH,J\BQ+@66cFK<?&H7<#aV.:
^06.HGZX3))0;0(@(ZF2_J7,W_<^@;GGQ:\<Lg#D7+80A(MUY-/UB]d]W1J&[<FR
dENWfT?EZ88GdVY(gaC4N\ULS53FZ>?@)e>O0[YG/5H:0;N_TSFV5L_UCU4P?56R
/TD8>.S\1E\d,;@R^VTU93NLC][/<IU.RZW4)aEO>Y9,8feGY61<QO.Yg^H<.PN?
I6&XUe;45-HG]]@[4WQU_W2de^@8:UZHEJVL@#f@1A353X0dFJ],,Q=Y@e/)E8JA
c1:@F(HCIVf(VLJ>V.K<@?JOPRD1KVNIEPa#B;SVA<aBcf\M>(W8G\9:B@XRbg2a
6P_]>UA)g5d6;;;XR(\]D)XBA]:YXWALbR6GCF5UaT^)+OL29,O>1EH>JGG)19W]
P:_P<<?3GJ[QGCEMA#V7Jb/(UTeJEB(9+ANWNF,.0Cb)XOD(FD@WDP2R@_&#DVB2
a(]S=J.H+Z746JKa:Z4YgQG0)[>YB&^77/(TVWLV&d?cX43bBISQfZbGA.(ZG;9D
B1;aUEZ#6Wd7EP&CD]c5D82PPS@0S(Z#.=TB9&=MZD=IYX+9gPO.HDbSW28dc3[V
KZb8==AA[USLOb+>ScA?04:Q]PX&HUb-8AVeV[\NgYNfb/Z_g6;>1KPT(N\T7ea6
b[W(0HM0&ffe.]IY\#+IgXL(-ISCMZ(fe(B:gCPERD#&.CW40;d[;-G];[eKZLYO
d4Ya=DCd&Vb<2](G9R[e3+J?DOZPbRMW9X?3LFQVbfT5H1NTKg.e5?gS-cDZSYU#
a(GB@UU/[\M&eP#^;Z)?WaES+7Q2cV]ZVVT;=8]A2M,gG2,^OHL7R3(L@.VVBYQQ
14f<.<=+BAV4-@H@L).CWV8Z9.B)ZABGGSD#V^QSBL7f&JD/:+cU0FR[13:EeLMN
#J9U\D]b+d7d1INNTZPa@871\Pf\3/&5&BC+CJ25CbHI>_fgIc(R^>591A8ed44.
1_+<1Y;g)[(6COSHb1DOHNe0(BS;>VYa^6UTA8e]Fd)K3[@:YSC-7MOI/^ZL&L(/
KK1IE\-_SXdJU0F6PFPEY/A(#Q7P]BC<4VGGHH#S.Va=][\O8<^AQ#cQA5M>-C6+
;.TNLd=]/C\L8GYA2c4^2_C)ER\6-QSW_:O;HW36Z;+4OLD2cZ8SJ69d<U0-HOOQ
/dU)gP+Va>1bZPU@eL-b&c8,9d0Q\><VS_^FEDM6?R05_:_7RSR6K1ZHDe@<<e0=
TJX:E6CT,Q=;B4<(QGT7NAK4SW1LRD\Z??YT.)BD1A9ETa@)e5ffDU[^S)ACgR=g
e7YRffEKWB0LV.3HA,(_^070CG2V485AEO-,[.4M.d;JDa/I<CG#/M)BfTWUaDBL
Hb8D@\U@5L:J/P-+fYH8WKT^XL6#d2Y#GX&EFSUWYW(bJ3cRMZJ[IPWATFPMXd@-
0&NE&_WgF(@^Z)R9bB/4^#b2-HJ2gV/FE1(NA#@)/??(8\?(PV\S?<L=fC:EMY7(
RQa6.(P[f(WC]Vg]IUV[b6KIT8X\IKWbNUVB+##2Q3Z;3S=]6-P3BOf?S#0OI,Y>
d4<EP.a+A?UeOY3_8]YHD3G1D)VV>,+cU=..-,G=J]B<aRP]#F4/&HR),d_@K2<5
5S>[5=3L=1FXHC7VA6L0_&;(FUEQ42IWY997F5I^=@7K\WXQ.@/JWXL[9\+#d?SZ
7/@D-3&(XUOF#F45YUB_9./e>5e&0CL^KBdLaX2/^_L/XDEad#_F>&\<GPIf0YAS
PF2Y+G?>d]EN;2;BPa1UFAG_U8D_VK>\JO0AZCOf3,1(3MXI:gCgPLEg\,JQ(P9e
K3]QcDP<?#=3d;O6\O:\.8]C18W/<0<aGc0)2JA+)YO]-f?+Ie5<\T#(YQ1YI/[U
O<Q7.7\_.1eFdTO0N[d0d@Y9KD5aYaGH.@T9HJ(#<_QbS0R0@28S0bH.[DcBKPVD
X;Z.E;]P^3,P5Rc:Y7F:>+,O]YDZEdSPWa3]bUVWQfZ]PF&#eRH@A<&44MYDU#3:
U[^0DKZ4?BB,e(9>K&_=VE6ZSN<WWV6]^SRK=>3?LT(@M7-N[83(0bL^3Ueg_SNF
=.<#f/7Q,E8Cc,YDQIXd,3GcK,3&/^V:8b&(-K#e317-T)\,9/,OG<:YJQ\<8M^A
[aO_6OA^[V)4-)XUf&:&YMW:b=G?K&T0Q&T+PUM1T_PRI.9O3?bKX[ZC6ULBgcV1
c@M-:&M;ZXHC4Sa.(RC7P&^?#TS[T=]<;gO#J7QG@20YcVc9?N\6(U7]&bgfMM5=
5J9/U9E;_/>Sb<9I0XF<.aQ?-R+RKbMC3MNB)c4;ZGI8GSSATLNI^LgVS<?LQWIB
P9K8IH,d=S4;)HV?4^#d0a.PAVZYTS)?.W4O)P[T&K_Y?_@+6275)/^[fC.4A(=,
/=1c27JgFD+ERF)cW5gP\,Ae)Md_NZLJ^W9CK\Qd\R\>HCJZ9RT=7V[]<E?a5Q9A
I)LQ^;+9;/H(74>aM[F8JWRQ&e97)d6)B[]CQ_.ZX+\3\84._d6LAf0<gP)Z=K47
<=G>=T>PL90+Z5:K_9153;&=>P0L3\:WYRL.?C<[U\XJJ_7^S2NS]D;(MI&:d>aA
fQ)3SfVO[9\\B[YEI_[@>PdFMM6Q06\NV;O<3/bJZ2>_EJTV,FEeNR@:94H,N[1U
A&=R,VT[#7HJ>Y]-gO[R:_0T2=c-.P^;MNeNJ+1LP[Q0Yge0^C3T.5VU_-F^Nc^+
VGVJ&8;>)BW\RUIBcZAAUTX<aAS@[/@=?0U;HQ2#35Ja(W.g[E6)3V?0;+=UFDAR
N1&ZV>Nd7XZ5RE[#8C(Lg.2?+/>JYG@1\G:99gQLP2agP^^=5>=(gd;8W)BS??SS
d(fNP]G8I3N\NaE0TDD059B@3IaF_O6?@>\ecG[3OPP?f_GMR3\C(WN7P\gR>HME
\27GJ3U<BZP,A+b:=&c/P5F_fFXV.:d_B1CK&T3_QMJ\^370N4^Y?9#2S^S<2QM7
CfRJPZf[a@1S(f5BcGE8KOSL2:Q./HY;:KF4,VKM0ET[RE67;OFJ>?C6-;@/HD>_
b5C(C295,&_aZE.a5TA^F@Y9JB[bSUAGee1If#?.X955R39d7O[5S?d^)>=Y?J;(
DK3HX5#=<,XUAM8AAP7W,d2AaRbSZ5VM^Fe)/1(CeWZa+(/6ME?Ic3L[3LZ6e2[F
BIE,UY7LKE_bZ4?N9</eGO0YQ?;TKSS>@LFag&c0BC1V[e8NQ1(0LF(<95)9=>XV
\;VGV2YLW^A&b^9STd<;ET460:IK?I5JaEG96.D(B,B3.4B4c@M+,?5F7NU_<M\.
(?9E,-_W882a8L1FA^R0D9gH>[+EJcNB?)1:5JK4\gA+[&_^NCG:W0g@S=WM).,N
HYaF]Z5,26Z/7<U?eE]/T49@Z7^E8(#[&5?;eU.Z1GDP?YVAJGeIRN_T0HTV<VH>
e4_78cb1C6DH@LJ^=CfRK>A>bNEBgedY)OPZ485M;b;6([NIILUU4f2^Qc8gG)Za
Gf>D(U=J/CE,PX8_I7W.\PG(:WgFWQ&Q,6/GD7Zg-35(H2;06G^d4Tb0,7:_T(Kb
Q(KfF05&HHJ;>CY6PRc]+ccIJE&<4fQ>S<.WZC&E\W3FKa:Y/Z\bF_.cde?/HEa/
Mg<EYQK>-T0)-LJ).#[B=+OT@42A\fC=?HO+S:RNV1N3?#Y?d(^RK,3Y+CK3:aT>
T06b>)<KB/B]WeQ,,EA,QA&8cG=fV<6:A_OS?/IcTM7I,&5aXd+#0L6cc5acC7>9
H]PR/3ab?&7N3T9LLJb3dM=.#/ae1f945V]eSL@?#:QAg3XE_eFeYQ]+C)#0G;[g
.B+N?6dL/=/^(5e<D<-Sg6K+GQM7#e:5_3\KM(V\&:CD]6WW90SRgM+(e2TA,,7:
HCdN9cNW<K;PU54;&?AX]CPIa7Yg2a_GXR,FSSb2IK,PM,S&:)SE>_A1LDLK\C&R
)EQb(OO/AJ@aWX7H1_9c7DFfU&E_V2\&9ZKU1UUR4#P,)K[/1(P7Y?fJ^Y:d31Pc
G0\&0YQJZ1UaC?31\(YTQJ+;>52#6PK36dW<+YUH0(.f_c=E\&Z7:>>[/?e[HU>,
2.fM,WT0DK.8L8Z<075\+\S48b@9[@HO2);IZ;;-+\;C7OC.a+T>C4,Q-I._ZCD&
K[]3Z75PKaTFXd)W\YSB5\E+OP@SL0CRD[3G4;7EX6H[aK.Z(d8bH@,I2V&4P<+J
7UWgIDT[]g,PKa4J8YHa#Z_V-MJJFH.O;BbNRFCe[9-f0B0cNEXDf5T<dB6E3TeM
-d;U=0BNRT1YbV1RNS4/eaMDc68A.#2FFAIB)C99<1:5H^FRF&e?KLD:OF2D#4_&
gXIU;<,F?D]fWCM)TWDPbP)1Z54NV5cf/ETbE-KW&9(H86/3(WI[g[V7W,+Q]b1D
^?N2#7WL&.T4(fX<2B3DbO]+I:G?4f_\B-7LG(RD[R1dc+<GU#])GQLHH^ITc]8_
,+:E--DcU(Ta2RTAOOKY_2U-Nb.WXCdScR<MIFZAEY/EZE&bVI^-CVPT<^1-;V+T
2LQ=/[UA4AWVe8aG=ICF4R8CBSQ3_69PE;<@P)V=TGb_NR=@-Y.:78D4(W7_^CNU
WT)f#H?Gd7L\^;E9SgL\XObCACB:OU6YI4Q+#H062F.c5\WYYe#,NT-Q-5cR/LLc
O3McSSNAD5+#QB(f;A.f3>03YVJA=:A:Q36\U5PHdYFX;fE2:FOO)cdNKfWPW<2a
1<)_=L<e=MFR(G#W6F:DB]7.)b/\:>8TEg:/a;S>#6G_><.+IFK5KHH,a7:aS:CS
S627eL27A==ZGTAY,6?:L/BBP^R1]M\0RK0a7_6e?N1?;<?a38):E?2e6=S^[ZPN
;49\NWSBYCUMP,LaD7YbIa>N.M3:B=AEJ\LH)GHffGSdO76UBe2,V\^57C\FX2AR
\=)3K&F-e?[1<)OD@/D;(We>f^V,MXAYO9WL^gR6#U-&)5M>@U.K:\4=N(MaG9\L
?()ZF3LN?Z56]5\KA>^=#OfC\LX&XS)[O/1Y@PTMTYa)d8:3S0+U#ZW@P;4_gKJD
B6W<J?R.TeJ_=bE#LU,[J@.<6^12ZD&U1/FQb)=-U=D#deUKU87.T?_=QWcMG/B@
>g=IEWFO)6T)ZAL^g,.gdE@->[B8B.BGH2aZAPL#OI8.Cb8B0/U1VKL_??d<95AT
@PGU8,^78?Ud+=E>bDd.g(&##OYc6eZ62(KQ^&=(2[AM[=U\[.NCEI@<5XU>OJAd
KHBAS_3VG:WcA)PU?5L1=KQGVfY8Fb+b41I<dR1.H4&6S9(8UC=7.E(R=]Kd<fb_
#6Z1c&de)gVG3^3^Xf=2I,SCLY+AR[\]:^;\]KaVEV(L]LcReV1.dRc.8;c4@-K\
8fJeSC5HR&BZ2\W5;1V+R(YPD\eS0dNAB@/,RQVCP,LTaVYO_D1.@X&:CUEF+GW_
gC3M-DI(,Vd997eH):P=MSV[4V-M0UeMB.eNACHRL6[Wd_-R/3/8VQW2E)--VVT5
d[8CP;AN_g9(\LCK?XP-&^0@<<Vc8O:/G+=WL382&Yb)c\cMAO&XDMYQ1E[^29=E
HJ.E5)b>_PKZ-N?b/7(\+TWG3AMA>A\4[[@=FY5^fQ43[6g2O1eY8BQ\Z6Xa.g/d
Z(5=^G3@7O-U;_a[DSTM6Pe4gF,+7Z4TG<0G#;.b3]aOgb(P1>5YDbPUWEYXd>?^
-3DbDfFS&5:O?^D_6#><?S;(?1BVNd1g,YT9bO1Q8_QCHe<(DeGCSG_[(GADAf3.
g^@cH8MBCD\6ZYPM^T&bcYU[GD=\aLY(UeR2MgKKY4TMNO-_aC,KaHO/EGPEU1Lc
)#IRNBNJ^[#8P&J0TWRWQe)RQ=OIF@T0/XWf>Kg2O.g][?1fa5GBV]<_1DDGO9PU
;M>,8-JbBL4DU>M@a?@TG9=(3<P)4H_Rc[I@FH5F.^M1CA\Q;:FX\[1@a&b6>:;<
M,XO;(ZHTTD;1Y8/-b9)^GK)Bd/NYP=XVGd&T&0MT2(A1(^ENIJ0b&a2R&g[^PON
5KS+.3)IT3d=PLCe=:D,?FFX[.;,9D0R_Q:0:0T;J7bJT31BMG6=]be5LU;fdTcg
37)>Y^QP:45,fdJNg]Ig2bY6a>D4YgWS&Q+f->,X7<5@2^CA@6\J1bSY&Xg8/3T8
P[FeaXZc5MXL,K2e05AJb94c/\Z;fQ)f]8=2N693Se92;Dd6B5H>=OV?:\GQ\[e:
cL:b>+Z.=_8P<-28F19F-WObP5[fIFIG-[b4;(POg,80[.G1P0+J3B4Td4KSS)M=
SXK((A_d>3PXH&5)=b?@/6eM=R]ZWCO#]>:gLZ_0[FJ2F/=UY:=ZLg;&H[>)].;A
58@2=RFEE1W8BT1&M_<YP37G::cUYb1WLgU_\7#GH\FYOf2:Ka:Ga?eRM-]aJ3K5
-A=DN6bQgD)J+OCP)/#(S(f4^#&(UE:0_eJ[>1c2/T2+T+4eV;A;[G)NK[2A-YLB
e3Y.fMRPDM@\b/L>#WEQCfTV,^[9>aFWbT-?\F8:@G]J,RfNcW[eY^-cDIRA&S8\
)+3Q)ELXA5,RJ[QKF\\VdN>DG9GgPR#0W#D(&5A_TEZMcN0(4R,=;D=RA2QBX48?
UT98bf##&\\&N9g]KGZ?@<&^+)eeYA70R+6=/PeW295GAYQN</Q&(YcdaIg:2^4d
J)7^5Fb@&3.AI?e,R)HM5.N/acAI@]SD^)5CO06cL03.1]Iad^,#X\96/L)cOJ@\
2_J&_f2-B3[M^0#^KW0;4FU\A-?a(La3O0Pd-R7-0/?@FXCBFAcDW25C#>A^VH/M
;bYT+b47IX]XBMV]VF:4(0V[C.c[W7YDS,XB?Jb:+<BXc/]UU2.,MgQOPBNS(=d7
7AeB()RUc^S4@G2TX<_=WCa0@@@2V)MD2+V7./F^2592#<TWF]5@AZ<1IY]LILE^
=gLeV5YGVe.6;aYK^2Dd+bI2EQcE6,cAEO5[=Z/(GP6;cf)gdeL,WT[O08Gac/DW
e0I6[-Z((.CT4aGL6c98IgAbBQ?>_W(TGcK6;(>P-7^9RU@O/fF&g1)RC.JOZ>cb
HV-G#IQBa#.:OdTBZbMPA.4TeG3+5=T1NZcW?>VaJTA-6B-IH5BE.)RTa5=<Sc>+
99Ied04P0=Pg#)I&NS]&YcI^-3XMCdA<26.dCUPZJGJ5((\HA,VE>8CU]IQ1;L3>
I7#VWY6VI6D,Q76RN#>4_KKgL7J5[+\=35=DLU9CH>7YO]Z8T-B;Gd.6#eMT)-84
&g^<g<M<O<_F]B_<F/8-(^T>@LOXA8R.eK:=\.R1E?g0I+-U>TgDGM4VU]e9)-02
V6/V:9c>@0[D-<gZ,(C_SYCc?58d\32IUKL\/6-Vf>BGa]VEUPMRR84ORb19QBGX
-S2HIQSM@dY\>EC6&?A0c,GIO/XFV1UMf[^R-<aF:d:,YVPT3]RSN)>bH6.\SRN<
N8eD2P5HB8HYdbB-eNYZX371F0Y2NN/6TO[.URg0D3A#-8=5DMH[I@Vg4ZQW>DL?
<V>SU787f@cf7&@)cd0f7_C,>E4>EF:F5TZZe/9S#,[3YQO#=8cBV)PYKTHa/T_0
6EG&N8g@X6E?R4=;(&DI6>VbE[DFFc@M3BbdCYH[2IedE^[(fBcI>6&ZScb8O9:5
_5WS7?L/5HX4Y1:J#H\2O6cIdBCQO/97<NJVgW4(]B7<e#Zg03dCAMJ=4A&eQZ--
,+\_e1QIBO^BC7D#gT1;9ITSO\2C<KK7SI^+AUJ+XF4G\?Q]dJ+P0?(g@PTS40(B
8Q9DO-Ug3,08U;f&f:YPbO[?C/#Q(f78Z<E>@?1HEJIGePN7P(+=Ngca>G_#0_)1
QTDK;NB<7\MBZ(\KDEE=2P)d#c.[f#()P(9cC+2\Vd6U6H?\2bX)c0T]]STN9DI6
DdOS+E:WP4RPY>XU7,&UbUeBW2gcZ7<(b&[G6/&<I(f:#(QC?A<0-@77@&JICDPT
^.PR4GRdXJW)E;AB<J.0?+Yf0DL<<06QP&OTH.>^A<^S8A0RCH^0aFU2/4WeLI+N
6&__SR\+)ccYQ;.<(.T]U^FVA92^4ga]_P7fdH=1FVXO:P1T/b_GH345>bN#&Wg_
ROW#B65ILWbY=OM&4XN8b7N#(J^+YMLF[e.f3W^d(YM\\PDCM&5\Lf-I2H^[;9JP
Jf@5+GKS7b3CY7C<RS\PT\ag>S<F&QQP2.^)Q&Y.fd>3-HQW\Y\A5,_)ZN7UC79<
X+G[.CY9W<cM)UIOZV&16F\2c_#=2A>cVg^beG#8]03/c:UGN\U:1ZA@NaVFgeX3
E&QKAbW9^M8<&T0D[Z9Z\[)^8KBB,1E)<a^YNGF47eAPEg5XSA9QbBb7W0>/7F81
c#<905H^G48S4P?O#=)@/;2cLU>d<afAHQD]U/?-X@,F^[J(X8>JfWeQJ1/1R:N\
CM9[8]7WeaZJ7aC,V@UgGYWVbG@(QV4\bE0#e7.O&M[7(9NWN7+/A7MEK7RAI#HB
F:J6Og0^SQB?1O:fe=MgF-W]eO<W&@Sg;WGZc,+AXb@S2+2EPYd-aP&05;S-M>L,
Z@<(Q.a5K?GZ\Y\,1d4_&=YW33>K>bBVf,#H8eLRR,WAD,3#7IETAfXV9MQSc9<K
XGU7>KHT8&aF))eL]0cE5&g00FfeJ.D-EX@#.-\f+3dLgA(E0O5>2\_S=BMM8:?<
4]f.<+W^a@ZZ9=aNcJK\594EJ8?5A8AX#Y>TG339HH799.&:&^8a\B4M02C@L]S_
C.gRf-6g_Z6K,LgV?0OL2@a787K)FGINYRAGEGXGQ8=&?JbXNR/Z)1.>3DT]#A(K
g<4KJZG2Jf?SQA73C5Q\4eKY>5-,=)V@40;eK)R?b63RIfEH4gA786>>QM]Q;3f+
WZ/+1I<&NeFI9]>_RPS@1daJ_?R#1SKEB0c<_I&1-14.:&_AU,\[A]M)gd(Y[5]Q
^BX\ZC\UZI[0HGOZZRLLO(+N;\GVSW?9P?=5-eEYAB3c4DTR(57NOd@Y^BQ^^e:)
>.2=d^CUKb=@N2:9B@3<&YaT9c99g+([EQ9c?P<6?c\MIcOJd?3Wd;_6I>fM7^RE
97?V]?VMCY[c3]Z3Od4>bgg_@HUH/[(BLXY&gSa-6JKNcWXM4W9#Z,)NX]0;W6@1
]Jf#8b-)?4UP]]-F#HU8b:,(b;O_-dB&TX6P&c9_gX#c7F->WV27Ta3SV(_X1SRM
fG7LBPD=>d<b?g@6T#R,I_><H&Z)]3L2W,9C.+Y/6=44451(DUTL0//5MG202P&D
LV-;<U3;^3TCMYM8ZY5+ca>I4\Ff-V]O:-LL^\];&>0bT..aa_AQB7Kd5,a00&1<
3?ZD_XKe/;-?GP_4Z5W5&COXZ#[?W64KT;5b>9eD\A?0YO5;QL1/[L;X\F-;[1^C
ECAf)V/e6Wg<2L@^OLRB#D][4.,.MZ/&=I)&E[C\V?S5bR2aE>AEDFXLM;,V4N:Q
VW^/Y@C(Y@:d;\)P+AU_fZ&=ZD]@#DG>5^BaM/O\A/UAYWC6&>GZM-;:c_(1#e5V
)<,:GHa:bILG&W;SJ+fRS/Eb,3S_.PE<Z5_?X.N3^AO@fdaQ_Z=US_dQa]5TIe0>
SaQ8e\1E9>_UA2_^]E:JXCS@dU4dCcPN/;?_--:I\H0/a+[UOB\/Bd#Bb&IU1)R/
\:<9D;-F(3NYVeQ/MFFUPT&EYATJ-YVN]a6^X?4=e_=MP>14g29>]N?SH=.3W\/T
\47?6;Nf(>S:?a&9Abg4O3555(FE&PDfE5FPF=gC\]O=^,a-L;)/G0RfB<bTg90>
<<0XP/bW3\&&7OE=<L<KMJ2MfdVA,[60K>Y6\WTe1@\,?Q(GcCVT)I,[^HTUebMX
4PDI_6.&fb5KZTRMT)H[ZJV.;GCO9\<Mg3LKWZ50J0H-39;ROGR=H4ddE^CS\f6@
6\7[cS1[3a]<VHXJHM7R\,KCYX65YR6IY3BI3//_9WWgTSS6.#1egCP5.BgdX-QV
1fS@1LGD)Ze7OI3CDLXGV]B?KXc-;Bf(R:&7S/NF>EER-H?OcKL0dgQL9/PGUM(^
-@aZN=JTEdY6\6D<VAQ>/)ALa/a).PX,9P^T8U[KQ==((@QMaQ0c0)0^5JcK9aFg
/HbW&.=eL0aQXLb3\):M/OY)=:Y#)^RSdQ&\a/J<eD:.[F.g<04H796.SIa^=TGZ
XE7I9QB3DK0b9MJD&RECgXOCXT\MI,]F.&&5MYF.0(/]G>;??\f?,L#Y4Ec)JC6J
KU2\MeE[R]E#JUb6.:(U-b(P1:U61^82Z1[1HYIf0eZ>C_AFI(.bY(I7K+).?N]A
_?@#B.#=-Aa^LSa0NbK?(Q_K-G\1KP/6ZN&f/[_^(M7:J-Ddd>#+4F(KJAC2eb-b
Z.fcBY3L3ZeEVUP=8F(Q^]VZbHgD9Q5C2^V^Q+#+MC#J=8D801.aI1egQ4=2X1aR
49\Aag)[Y=g^U&=?/?C+&PY=4JL0+C#\RGI^2WU=][[cM6Q#XW+V6dI#Yb0T8[b#
WPZSUI7:T.H:H4S<^N&_P(<.18OM@VVOPO&:7?I2U7R<6\HQTTI;R2XTgO7ZTEUY
B+5X[XE]Y9VDQ#;9;VA@1[BHYPM>FM4A_fB6KAd1(G40,KcMbC5BXZA;D99?LOg4
Qg/K8aQQFEaD[U=H?<KXM?aP6RG;?ZF1G4;bLX7\=UTE\NGSEH-?c^;#RTEfZL9B
RKV9)-+&be=QUZX[WZ(A_3X<)U70&M+MG1)JO9FWJKE(f+N1MOO@Z[86.NFO3E>>
#Ed,&.J>?=#ZRB(8/4.SIFVgQ5//<Q2\L:Q@[Y;.)TS6TUdbA04_g@G>Q3Mg=R-c
cO-c.H99-K2JUFYU>V#YH2[)()a>GN2aUF\aW13UT818a_[]4.QN0eGQ(fKcK1Wd
(d+)McZAM+c65UJS_-eG\,(ABL[6UfV1/7F7-1K-;=^<:[f1>;f)9Ee-Z@3D,<;c
;5E7dLYWD,&D:^8](+IOY\SY1d6SDdUc0A-4F/)Z&YcAE5Hg.)XB:.TMD1;<-.E<
eb=TVA=N0G&a34T8#<R0<8P;a>8>EBMDS\V>A+]\KWQJ_CfRQ](e;1W>B1<,.dFb
OQga2bgd?<Z[D]ce-_Nd?+_\),+fDQ_I4-d8ZTS_(eI)V,9Q)Uf=YdKAf4VO+@X9
bY3J[8TSWSeYCY7_W._0S)cT_6.(HZ@UW9@cRU1R+d)Jf7KXfJ6eaHWNXAa<dP[T
E)-2Y:[9IcZ_9:/ZLgQcNSATOEZ:>]R5=A?^GEPH@g@NF/.M@4A[B2<WF6D]>(#f
eBc--dT:IK,&AT5:KLJNf#[Ta4^KCC;N0+;LZVV7V-P[[G@99]QX_F<,97:W^B_\
GBRZ^.YeN)<F?f[3?/VG97b-c[117-:WDc]I8f3PZ.66fL35:XDcLT7Z+ZGd3:S_
daE-H7dD90+S\H=^^O.)+NLG36e]?7VQ[)_T<gMX[;H&;6HW?.d2BH5\6<d,EUda
8SM<dHK9[W7>9R4MIFRYc?5Lc<586I;?gZ?-XL3=:5H)9BV(L]:[+N&+fU70e?:Q
\1P#<1J/:-NaD]>gd+_Z;KeG[=T^1cL\ES6[bEM;&K;\N>X]a<Tg:cU885X,Y.^5
QAbD.?dFW()581K_+X+8HM2)4S3:)]-L1aMabX7^&6>bMCLBJYSGP,/,(c>OM8<6
^)CO_6]6KVXaP5fT-7dL<2;K.C+bE=.Zc.X[92^0M\XB5ZE=ZALaU)8)N+@2A9d3
+WZ,?,_1N\1@:W6Q#<?AZWW#d),).Q^-g5Qd(,5@2F7<2K&^CHAFIIT+^XbWSCd/
e>+R?dO\7?d+HM]>[L;<,BFIf7)2f9VfZ80-7Y-7eZ1P9+C?KZYI];2X88_g#AXJ
_cXb3JDJW/0M.FWB/f.A/a6Y?0XZ?L0W+CB-1@=2YSR8Of);d#F&I:)Yf9c5T=-H
=6_bVF+c?<.bGYNHe1)8O6-&ETdPSY2.TffNc-ZJ+&L/^TR:c2LY#K-A<[0L\=gQ
X]C9WQA4H<9ZCLV\Y=GaaLEbUNe0Y9DIA3ND),Q4Va<OJUDTPK5M_9-#:d_BHNgT
#(8T;AEaV/X&cJGZDT0><EZ@QAK&Fe>Z)88R15b[bf,\/CLaXPcJNJdfI@cD#\(V
D@NF.5gW#GOB?]\ea\(E&8G]XgR1a;U-FA+_-00++QEF[I7NBfAGXE[12Lb7#_3M
2(3.+RZaG5(4/:ANAE#-c0dB]LLE77BD==F(7H,-C#(XK]3AD.3:e001^YbV9B<=
c4:7BWYPV_5_ReRDe01F^[):1.1W>1C@,bDJ^]fcQ=PMFQJe_?7JgT=TOHTOQ[a=
b>[IIX^N<QMV77IWDOb]IVCX6\YX:f1C5[Q[S:<.1K^^e+GUJcMf\V[\+@bIc<5?
YF+AZ?g:\b7?F(&6eW@L7C.\bceHPgAUUT1:d9A6TU3?(9cS@;NWf;:X5?deefdf
5&S_;#SWPM5P;T?((XaN_c38THBYEW.@7FQC#NT0-N1[fZL6#>SFKC3?8=Gf^fD/
VGF3d;:L,(#/-_g/)02g;(O?H745(\G=B1MNH5b9Z5)ER&57RJM8b>;UUP4^HU;J
66Y_NN6W?5H[#Mb/Y]/0];#,MA9Z^SYFg40M1,750++DI,<d^WU=f::+KEYT(bX;
5NUbaS))#A]c074\f7^)_fd3;CVG[\]ZU(VF6)H)afVPXBCb]XCE[;IC3X(>c\KE
P-[]4@[]?Y&+7>cJ@/>G+OR:f2C\TfY?Z9LX;>;5+P+d?V4&GFgOI.CGXI)7K#Vf
[aGZP#cO>R0R#PFXb<\&/1;CMG_F?X/cWW;gQ^+X5Wag.W-;7SdU4E@PaNB6e+Kd
ePUbaY]BLI-Q)XCVT<5EWF[U68=PI97bf3+IUY.1M7PWX0[g9HD5/&Ag)BVSe>9)
5QK<P\PG[\9WT[M8bA6X<a(T8cKO7DVP3Ic^<8L+R/Q@6EHb6(C-0K=KSdA=1/\M
@cO]/HC.KOa_)a:MKTV79^cBA:]P>L?eH=dGa?DPTA?XT^:L1D\0DA<?dGSYfG8@
fa/XWbPH\@;P6HKJQI-(KKFf+8I3OFa2E-6DdP8]RN(P4O75ccO-^ZXJe(+P5S?0
_2&#b-0Q&1gEbT9+aXZbS>MJ[KZb492GW,]#NV+[UWSe#,PBP4OC@g0eHC1gZ-Hd
0IG:L7YWGL0^SN9fdU-L<KV9U9@;CC7;O<K^M_+2J:g),0gGCKEd]&],2c0)\?G;
/V)]/GS.IB+<ea4WFV_21,PX3VbUV@X+.>.X0D)MTYHB8<X_(SXKMfERPYH5\<#,
3R(g2f,FNCcA\E?G._;U43XTZ_ALF)G]T8dRPeQTC0.TCIG+P<&4U+4#eB^U,AdE
J=C.#-dPQRR1ZGgFcFB-MeGBM8XaHT6eKMSH-Rd_UULLI4?E]Ggf.V?LW]KO/cb=
9MB_6c4&P,S\<BVLMCEDF\#L.::Ga(YIN__/HE7A.YFY8D3MS0bd9\^AGXgXJ[D2
NbfQRB5Y+USOIaR&=f:aIUdME&EAI>IZ3,]VH3_VUZLb(0R?V<UR(<6R:aWg(A2=
3cJL<U3/>B)Y<_^/P_FGC7ZAfJa,?Z.H=^K2<8Yg(J]07(&Wgf:/W+\65M(,Baf-
N+?SeW1YL<Y0eCb-aaT&]IGR3NU=[2eV8V?1]3ONK+/H3V7I08+YMB0QC]M^.]?9
(2IFO(VFCLXUJ[/BF?N<)_beHG0QE=BM01&Q7J:^Y?;Cg&7Wg..6&V[B13>OVIFa
F5(2^]556B1D/EL?UKd4+=A6;=bE5e])DQaO+_JfZ4I+NTd(KRF)MH\F3^TR,8^N
&ZD:<d)Z(<8_O_&Z>3I(ZW,)06EB3@_Q@<.Df+F10JIc.Zfce4d6e0WSI-=VZSWO
S@3>9N(5I_YMaO^3?=JdIe)^SBUeY8E8DNO,]O,e;b9;b+c+PWX)#a5EX;L6Q>dT
7SaX0aVM.XYDNc(ETB0D#KZGNT@,#>3R0>T\>^7Kcf)?VOV^?&5KC8?W&;Y1[5RP
gT2I[E/MND;AAG=g[OECMU-D.N;Z##M>QG^R1(^=[8ON>E_?_J,C&@[T)8g/T@2I
MU_-ULCWUKbLW+fMSR#I:34d:4:,d\J]eN<,CNe&b[3AF_4?D,7#;X;#QT9=GSFV
1.-@]G_Qf&(DA?;;@T>.K&J=+C+?:41&BAPgb;W76E\GH\DCW-53OCRY9HB]J2OX
5a]:-81[E<T55<e>b5N_B>[b8<OL@=/E1?)JQZ1C\7-X]GIZ)GG_-N@\gAD4fc\Z
3P=/O3Od#@g_[.N0DeTG,M;f8OGM?MK9O&89D-I]B&Sd18SS))U0GK9\2@V8K-X_
;FDQOS)>VABU3:?5F)UXT?I5F(=)+G/LC6UZER-X<_TeT)SC-1Xd(<:6U-5S[bPF
3dC<HgDDW1EIZ=TB&H\M@^fNa<I9^Ac-BR&N0;FdC()],U#OJYf0BNYU8;B)TYa/
&W8SOcV:/7YISIbC7<+AR?#<05;Z/>[Be>.XJK/eE./DT3\T9LUB<<S4_3I>;QgL
T#bJ_;/5aW8VW9GK:QJc\Vg>.EU2[TZZBg]AS<RDT6B#0KX>##E:X=4DZ^0L]MX(
SH[LPaQ?IQ?)?G50f>2S.WWZ8bWI<f9@)NW;<.2W=ST3HXDB2\gBcSY]/KK\RMZ<
&3J]U7R6B,4BG.0gb]^0_2^CLAW.K1KCJ.&5:2<S-;aC4]MZEG;9NOBe6XNR&921
c[.(E0M<:dfSP=QF&+QPE6966fDDP)K),GGCPY&C5=4H6)IE?JRG]L]#I8SDC&G[
YI7,\BL[-0KE3OGXACFL7c7a#0R:E<-F32/AB)V?(5?0)K8SBUeU7>35H,8fgAf-
+gF@)EERHe>/&TWFgeRBA[E)DFNUU)PGdZ-.F.(=[0X_#RX4<[@EINf1(YWU,^FS
)+g:C3B_-,ELUJ=81/>8)5.J-7S:eg,(ANY>D.R<V=QYLIM488B1YJ1&dffGQgPE
VM+N+SAH:.]g@;X(K0IYY_;V^4#.YQLf(PHM>eK9Ib:5a9GHWEN\D94);NB#X.2V
?VYG6H16I\G&P([TG(LeJ)7X_QeVV4-GDN:Dc8Y3gF7TD,N=YX(??(2E_<M0G@DB
=RcD(ZdVI?5b=):eHVe[,XNAR=?CT3>D#..:NNBFL::_VIDCRa9[_+J;_GXYO/:F
-P)5G:b;3,0a=:<RFQ4<cLX:a3G8S43XP43>gNAeJ;)\UQfKD4P@O2:,O^:5]TR_
=&<<OHXM]PQ_]CdM[&bZ<RY5ATN8RcO>USCXZ:NYMM@(:C1.EO0F&3)=3YJCTH8V
6>G@a:79+F@Yc^aS;TeWf5[RU1K5g1BI]MVXMZP=,EAO3)VW#[JTS#9GIV#V<M]\
1@T5H#>EFSc:46ab+4K0+T]]516X0f/<a7aX37XHA/_XK7aZaG10[aOR0_2DA=+,
8+Z/fCF=^2@:I7@OA+)F,#A=geZ[+-Ffb&]9:=-[?g)^a]HfA)DUc1L]e[<L?C_2
]<g,0(US2WOM1IfTX,ZZZRAd@6_QXDL:NV9M].F;B9BXMa)F92=L5LJ(ZPCX2?8R
&0g70D)D\\)b,PMD+6ZEYR<_649HJNg/C;;P@b@_R2N\I#X2A=-M1_+Q[c/5Ec<P
<[DC7..KYFSK-J.W2CM@FPAQ7ZZQ#W+HB&=.W0IYDYb&VM2-O0/dAJ/(T&E,f=,)
,30ER@@;I@+:fXX#\87?,K1ZTgP((d.?(^1-JWcEOc.D=Sa9&Ke\I2^<IK64.(gb
@A>;]B\AD#V_XJ]_^^Q4e/-UDKHTH#XedLfK@/VDfJg2>J22&6)]PBV>,^M+b8.9
\>D/)7EO3U1>^O-/8C>9@PgXc][N5,^W&afR>=\-f7>,GFA1AM1IJCG^\:a8SU=>
D5D6YI.SUR1^4E08_.D6;G(_JKL3Fb[W\#e4N&H#e)ZA4/R[P7RK-C?0f&,JJg8\
<SCee-TL?5CJRJ;37Pf8VZBDce&AUMaCZ:&U?,Z[H.5P3..0dVJ\#Z_W=g7V_O.c
YORde5bRS5aP,Z7E5\40CT0bY3MO&M<TL7FCY=&FJQ>G@87:,YZa0<fURXd113Uf
QTUVJW7AM]-Q;OZeSKHACHOH>[V3F\0W_+FeU?H1,CKZ6/-W015S?&61V]#;>+76
]G:9FZ&YLB3O56,Q\HRd@I@a\_b0#+\:a&[A+&7))B;]&^gCd[@f+bQ3;YB;.(T)
I5MD4b4M:4E]OG-Q0]<>SL>8<7Db;H0DV.4K-gTD:e8O0<FC4-,>N<+Gb-<a78-E
EFaVL([DW=c6+NXS_JA3fb2&FaZ+/G_Id1.afc96N:Ug+=GfecH2XN6?2VL>&L#U
A7;B2+7S(8cFVQW^W=?L;eeF0GcOb3W28Ia<;(+9,,Bcgd8(R>U6b_N4W<BX)<[^
f.?UB@+Y(e56V9R+5Z^@3A0X=GSA5>8XY[JP+0U4>\8]&EN=(HKdQ&2?&8SZI-\8
NCF98<:-M/LF&\<CD)P-@(.)37SLRU^]4-NOL8Z5d4&)CbN7]CJ+DL-;N=+<OR^\
(e6CZL2+Mc5Pac5=J7;0,LS^&HfPWLW&e[d@;cM8FRT]9G^Z=7Jf?d0(]2@-+f]7
^A:\1aSWRZ8:Ng-7&2:6DHTMSYgQ\>U7e]31L;7\f1#M_H8PL8;>8L=c=:E5KI2X
/=S-@EWK[EIP\&7B2?5Pd13W>:EUTJ)94[P/_BeKMN)4X;P3OBOQ2FdCOfg0gLI2
)A#GI5[8b4C+EUMB>M-cebeOPEfNXR0QZ&QZALBaFDbL@,_BPE1,LX0J^a[8d)SO
[ae<)277[TXSf:-.PW]#5EJYGMJM-J.EJ.\We1\Y1066FC+3AG75T[:W)aAFaWHa
GG6CNV)TDR75LJFW-?f7]RNMC-3e&Z>2?#N3?P=+&2a]Jd;(]:A:U1W@&R2\O\DS
(BN9[H?.X:g9IY6-&O>bM;8GV[D+J#K<.M47F#72gFc7aJ\DWGb6eL>gZ-^(a\QI
Q&)F8_=0->+?Z_d113ab\3;(C1<FcddeC:1Q3)1BMF<cW)fZRE5(&7/W.c-C_aG>
:P=9;M+TGQ,J/1[Z;O6JJ^dVBd[&)J2TR[Lb#7HJ[N9Z5NA:K>4M7+QSF,/XFdK[
MI(XQg(MF>YZ3[U9S3fL?#=b)M_BBT_aW/,8.H;f]Va)C-HGCgU@I[50K^\<5.1?
9bNTO2]@N?,9+)-1[XBJ4L+6/4BOPgXX.^LfO?Z&?:bLbc4567IF@974C^S.)26>
[..[4fK8^UW9<8L+DfY12W;RD\>(LXAG;QZaE.C&PgYKQA:(3G-Q(^a)]B?aU.c<
@UHTX_&-0XZIHH5>1<fH<J9S+2.Cg:MGg,&\.Ag@V7WZ#Y[R:R/)2:ee:5_UUTHD
fJc,6^_cHW:WDD9U4_d?A4H<RBDA\5A]IM=.>Z#\6BB>]_PJCT:1RJT4L1&6E1K(
ZRcbSDGAYZ.(,Q+P\6OG@-T9JJf[PWX@[3-S_V\P_]70I^)f2UR7ESHJ.6D^R+<7
QPMJ>4f[16#?]QQ8LJa1(K72d.>ebP4>V.4AR0/K<N^L4B45ANVc7E#/0=Tec-gU
^@X+DU0@/-cE-0eAa=Q_T+5:E//+PLE;f#d9c-469K?^\^Ubg6]WJe:A]cDNWeF3
SG-@B2-&g>I&C6:aDM-b@^[IHacgX;&.<?/-L5HV&RJT/XC-+E0=SgI)I?X9ce@1
K3HbU+;YE\8g?UaO<L59+=]N5bVVQfc>5bf>8W1(\V4;/Ke,O4APK?EXJ^XQEGVQ
\>?I)\a?_Qa(:5U,Q;gS8KaG+@0=[d(g?I2e4?]^59]0B->/:&?J3/FB7G&GZ(0C
A8;FKPIYcD9J2GE-JUg7bE/]<6/1_5[VLJIg]>T22MQ^)D#GTMSXJ0R^aa##ZV[J
S/22VN-]ST:;3EVII&L9S=EAK2T)DN_@)\)572H^@GdR0M80YSd=#^eSEbXH#3U#
9HC4PVfd@T[gdQQU,g^N07++EX=K2PHg#/R<db][EdMLLH?C6-&Y9\LVB3bRL<5W
BHLU;7SG;F8gR(Mc9gR70Y8Tg?N;PQIBZ_CO:aM-34d[3#R&E,_WEXM:X]?>5#3a
1?8:bI]D4\A;@6Z/M2#/Nf^bL,0RKe5PHFS8IAQ-1<df/3T.0.6I2S-&Q(@^bZ?:
QO?]?VI/Lc4fA?:V//J525@+a#2)=8@N_K4:B7R7Rb1/8>M>@]WLa4O8]\1WZ_H3
F?\/G)<\LcE<WO??#YG[Ed+G><NfQYEcccOY)_&X[5..-6R3/GeA7Q\N?-J)ZS27
cfR:RO1&^NXV=OKa^-^:3)_^N[X)^OQ-)\]P_^&Z2L#>PJc<VDSJ\:b+49IZ)Z5_
==Yf6D9a))S1ML.:^<I@>bNUe3?09.\F[XNU.<BV.Fcf\GCSBd\FRG(cVLG>4dM&
1=ESVIV47+R1F5Xf#MbV\&EXdPDS<)>a#DfUV,5T:9UY]_f1BfN<[.?adRE(+.:g
#=RQf-_=CbA5517^/W^a1Fb3[_GK#>#)FE6HWa/52H87_;^A^6dPH8E&)@H#=C;7
,>PDHRZ2&@BZ-01XfUMb>TbK/McVXKC:b=3#da4NC:6HXZQ0K)0412+L]Hc6eg+0
]af<B7(\g5KaeYJU[)GQ,36D/>N+:5a41EO<f)2;DI&\;:FG7;ALR&9\QH1FM2_<
(b@C0;N+V08#1.KA.9.2+)2FDOVd,]7c8=aI8c^+7>70S1+,&MI0A(2g^_GO&/Sb
TA(FXPTbB#Nf5)XXcTL9?NQg65<S@(Rc@<N2?K,BbKcK6+\bb:dKg#@0RQ<2?:JF
-/D->GVZ9)7?TbF3R\7N/P&)R_Z?;c>A5F_LDZa?798K=]XK&g)+bW24YV43Kf3e
:_:GXb;<-NRK:XQZDa80@-;8)]I-?8R(+(TaS.:JTG2PT[3^87=.>BSB[9](T2?F
NG:gK9W2-CcRU06NF(TB>EI(cUY&f#JG-5DIMe7[Y,]PcgWIW>ggJ4W;f^)bO7IG
4_(7IP_0()fK7VcX(Z:,YFS6gB8O5:NLE-J&DJ@HC4(\6<\0S/bJ3P2U[UfWFJAC
<La0[2NMU@J4R.MT3T728/&dJQ.<OG7QfWFU9)3-GHFBB2JNY/P5&Z5Q4Lg^d?7Y
^^TX<6JAWD-&C45cH04fC(=eWL2-W\03HSV<UTOd;PFW3>E]@+W]Z<@MLRF.C:7V
>V9I@I&FA^[P@&)J@Fd/,Rb)@/Ag:^IR:4.W3YAM,KI/+9@WA^Lb#3TRNF>[e@ab
T6\:-1aL1#JA4C^C.VT-K<9aZT5X]/aU9PJ78EA[0K(d_5[?I5CI-YJeL;:Sa\CQ
EFGg:+.4?2_;FH.#1EO(+B9a6$
`endprotected

`ifdef SVT_VMM_TECHNOLOGY
  typedef vmm_channel_typed#(svt_axi_snoop_transaction) svt_axi_snoop_transaction_channel;
  `vmm_atomic_gen(svt_axi_snoop_transaction, "VMM (Atomic) Generator for svt_axi_snoop_transaction data objects")
  `vmm_scenario_gen(svt_axi_snoop_transaction, "VMM (Scenario) Generator for svt_axi_snoop_transaction data objects")
`endif

`endif // GUARD_SVT_AXI_SNOOP_TRANSACTION_SV
