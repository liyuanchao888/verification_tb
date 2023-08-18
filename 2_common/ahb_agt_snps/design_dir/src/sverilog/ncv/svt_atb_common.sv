
`ifndef GUARD_SVT_ATB_COMMON_SV
`define GUARD_SVT_ATB_COMMON_SV

`include "svt_atb_defines.svi"
typedef class svt_atb_checker;
typedef class svt_atb_port_monitor;

 /** @cond PRIVATE */
class svt_atb_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Analysis port makes observed tranactions available to the user */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_analysis_port#(svt_atb_transaction) item_observed_port;
  svt_event_pool event_pool;
`elsif SVT_OVM_TECHNOLOGY
  ovm_analysis_port#(svt_atb_transaction) item_observed_port;
  svt_event_pool event_pool;
`else
  vmm_tlm_analysis_port#(svt_atb_port_monitor, svt_atb_transaction) item_observed_port;
`endif

  /** Report/log object */
`ifdef SVT_UVM_TECHNOLOGY
  protected uvm_report_object reporter; 
`elsif SVT_OVM_TECHNOLOGY
  protected ovm_report_object reporter; 
`else
  protected vmm_log log;
`endif

 string inst_name = "common";
 /** Handle to the checker class */
 svt_atb_checker atb_checker;
 /** Sticky flag that indicates whether the monitor has entred run phase */
 bit is_running = 0;

 /** Sticky flag that gets set when a reset is asserted */
 bit reset_flag = 0;

 /** Flags that is set when a 0->1 transition of reset is observed */
 bit reset_transition_observed = 0;

 /** Indicates if reset is in progress */
 bit is_reset = 1;

 /** Sampled value of reset */
 logic observed_reset = 0;
 
  /** 
   * A Mailbox to hold the observed Flush or Synchronization Request 
   */
  mailbox #(int) req_mailbox;

  /**
    * Holds slave transaction observed by active slave
    */
  mailbox #(svt_atb_slave_transaction) observed_slave_xact_mailbox;

  /**
    * Holds slave response transaction received from slave_sequencer
    * This mailbox is updated by slave driver after received response
    * xact from sequencer.
    */
  mailbox #(svt_atb_slave_transaction) received_slave_resp_mailbox;


 // ****************************************************************************
 // Protected Data Properties
 // ****************************************************************************
  /** port configuration */
  protected svt_atb_port_configuration cfg;

  /** clock period */ 
  protected real clock_period = -1;

  /** current cycle */
  protected int curr_cycle = 0;
  protected int last_curr_cycle = -1;

  /** current time */
  protected real curr_time;

  /** Stores the last sample time. Used for calculating clock period */
  protected real last_sample_time = -1;

  /** The cycle in which last atvalid was driven high*/
  protected int last_atvalid_cycle = 0;

  /** The cycle in which last atready was sampled high*/
  protected int last_atready_cycle = 0;

  /** The cycle in which last afvalid was sampled high*/
  protected int last_afvalid_cycle = 0;

  /** The cycle in which last afready was driven high*/
  protected int last_afready_cycle = 0;

  /** The cycle in which last atvalid was driven high - update is deferred by a clock*/
  protected int deferred_last_atvalid_cycle = 0;

  /** The cycle in which last atready was sampled high - update is deferred by a clock*/
  protected int deferred_last_atready_cycle = 0;

  /** The cycle in which last afvalid was driven high - update is deferred by a clock*/
  protected int deferred_last_afvalid_cycle = 0;

  /** The cycle in which last afready was sampled high - update is deferred by a clock*/
  protected int deferred_last_afready_cycle = 0;


  /**
    * The configuration that will be used for the current time interval
    */
  svt_atb_port_configuration curr_perf_config;

 /** @cond PRIVATE */
  // ****************************************************************************
  // EVENTS 
  // ****************************************************************************
  /** Event that indicates that there is an activity on the bus */
  protected event bus_activity;
  
  /** Event that indicates that ATREADY is received */
  protected event atready_received;
  
  /** Event that indicates that ATREADY is received */
  protected event afready_received;

  /** Triggered after any transaction ends */
  protected event transaction_ended;

  /** 
   * Triggered when a reset is received 
   * If a reset is received, this event is triggered prior
   * to the is_sampled event to ensure that all threads are terminated 
   */
  protected event reset_received;

  /** Event that is triggered after every sample. Other processes synchronize with
    * this event to ensure that all signals are sampled. Note that if a reset is in
    * progress, the reset_received event is triggered prior to this event. This will
    * ensure that processes that are synchronized with this event will be terminated
    * at reset.
    */
  protected event is_sampled;

  // ****************************************************************************
  // SEMAPHORES
  // ****************************************************************************
  /** Semaphore that controls access to the active xact queue. */
  protected semaphore active_xact_queue_sema;

  // ****************************************************************************
  // TIMERS 
  // ****************************************************************************
  /** Timer that monitors atready assertion */
  svt_timer atvalid_atready_timer;

  /** Timer that monitors afready assertion */
  svt_timer afvalid_afready_timer;

  /** Timer that monitors xact activity */
  svt_timer xact_inactivity_timer;


 // ****************************************************************************
 // Local Data Properties
 // ****************************************************************************
  logic last_observed_atready=0, last_observed_afready=0;
  logic last_observed_atvalid=0, last_observed_afvalid=0, last_observed_syncreq=0;

 /** VMM Notify Object passed from the driver */ 
`ifdef SVT_VMM_TECHNOLOGY
  protected vmm_notify notify;
`endif

  /** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param reporter UVM report object used for messaging
   */
  extern function new (svt_atb_port_configuration cfg, uvm_report_object reporter);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param reporter OVM report object used for messaging
   */
  extern function new (svt_atb_port_configuration cfg, ovm_report_object reporter);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the <b>svt_xactor</b> parent class.
   * 
   * @param cfg Required argument used to set (copy data into) cfg.  NOTE: This
   *            should be updated to be specific to the protocol in question.
   * 
   * @param xactor transactor instance
   */
  extern function new (svt_atb_port_configuration cfg, svt_xactor xactor);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Samples signals and does signal level checks */
  extern virtual task sample();

  /** Samples the reset signal */
  extern virtual task sample_reset();

  /**Performs checks related to reset and update variables*/
  extern virtual task process_initial_reset();

  /** Initializes signals */
  extern virtual task initialize_signals();

  /** Sets the configuration */
  extern virtual function void set_cfg(svt_atb_port_configuration cfg);

  /** Waits for a any transaction to end. */
  extern virtual task wait_for_any_transaction_ended();

   /** Sets the clock period */
  extern function void set_clock_period();

  /** Creates timers used in the model */
  extern virtual function void create_timers();

  /**
   * Sets the delays in the transaction based on observed values.
   * Calls to this function must be made before "set_deferred_event_cycles" 
   * (which updates the "deferred_last_*" variables) is called to reflect the
   * corresponding values in "last_*" in variables of this cycle. 
   * In the case of bvalid_delay, bvalid can be sent before the address
   * is received or after the address is received. In either case, the 
   * burst_length information is required to calculate the bvalid_delay.
   * If bvalid is sent before the address, the call to this function to
   * update bvalid_delay must happen only when the address is received 
   * If bvalid is sent after the address, the call can be
   * made when bvalid is sampled (as in the case of other signals)
   */
  extern function void set_observed_transaction_delay(svt_atb_transaction xact, string delay_type);

  /**
    * Sets the "deferred_" variables to the values passed through this function.
    * The set_observed_transaction_delay function works based on the "deferred_"
    * values of event cycles. This function needs to be called after the 
    * set_observed_transaction_delay function is called, so that the current
    * cycle information is propogated to the corresponding "deferred_*" variables.
    */ 
  extern function void set_deferred_event_cycles();

  /** Checks if the handle given matches any of those of the active transactions. */
  extern virtual function void check_xact_handle(svt_atb_master_transaction xact);
  
  /** Starts the processes of a transaction based on xact_type */
  extern virtual task start_transaction_process(svt_atb_master_transaction xact);

  /** Does the necessary processing to end a transaction */
  extern virtual task end_transaction(svt_atb_master_transaction xact);

  extern virtual task drive_afready(svt_atb_master_transaction xact, bit add_to_active=0);

  /** 
    * Notifies the slave that a new transaction is received from input port.
    */
  extern virtual task notify_slave_new_xact_received_from_input_port(svt_atb_slave_transaction xact);


  /** Returns when specific events are detected pertaining to transaction processing */
  extern virtual task wait_for_slave_transaction(output svt_atb_slave_transaction xact);

  /** Advances clock by #num_clocks */
  extern virtual task advance_clock(int num_clocks);

  /** Steps one clock*/
  extern virtual task step_monitor_clock();

  /** Waits until a valid or handshake takes place */
  extern virtual task wait_for_bus_activity();

  /** Drive the idle values after initial reset */
  extern virtual task drive_idle_val_initial_reset();

  /** Detects initial reset */
  extern virtual function bit detect_initial_reset();

  /** Tracks transaction inactivity */
  extern virtual task track_transaction_inactivity_timeout(svt_atb_transaction xact);

  /** Waits until the transaction ends */
  extern virtual task wait_for_transaction_ended(svt_atb_transaction xact);

  /** Wait for Reset to de-assert */
  extern virtual task wait_for_reset_deassertion();

  /** Updates response parameters when supplied through delayed response port */
  extern virtual task update_delayed_response_parameters(svt_atb_slave_transaction xact);

  /** Waits for specific functional event for which timeout is being tracked */
  extern virtual task wait_for_timeout_event(string wait_event_type, svt_atb_transaction xact=null);

  /** Tracks timeout for a specific functional event */
  extern virtual task track_timeout(svt_atb_transaction xact, int timeout_val, string timer_name, string wait_event_type);

  /** Returns handle of timer specified by the timer string in the argument */
  extern virtual function svt_timer get_timer(string timer_name="");

  /** Drives Flush Valid signal */
  extern virtual task drive_flush_valid(svt_atb_slave_transaction xact);

endclass
  /** @endcond */

//----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KJOG8NJoYRMczKU3XPKXWqi6PutEa1uGxMJtueDinzxkMqamXTYP/lH8Iqzbmuvs
Xhl0q94k9ZMJ8deFagNY2D8nOlzRyjCLBt7PxuAamDJDyp5jwVKk1wDKyCvAfwm/
i33yCOUIpbi9HJ3V70LhgjlFsORJJI/Iitd0WChzm15Jtt4VJ9vFnQ==
//pragma protect end_key_block
//pragma protect digest_block
f2TnxDb3nLahlaNPsDg8ixx1E/k=
//pragma protect end_digest_block
//pragma protect data_block
gyieRjPyS+BvkP9034pj+WrfCUvVxZFoxnzxf/TfZeTHs87alDTw6s/gW2VVQ+ti
8P31HZYpgaZwhym8njrELcSMyfx5Er6QNs87zULTSn7blLUVqFurnKnvcprtqJ+w
Xn93VAlXoQQof9Ypr74JkrT5hBXB+OG57sE1FwKJloJdI97rq8P44BJmwzqNiyzH
E4+lXyHFSlt/+8PK5vqiio7bDBs/6mpwp2bC8dfJvTRch0tFozATuLeT4/UaklUP
YTAyKPihsQs+lfkZwSov4EzlXeS0rx1B+OTcEyDH9ic0y+5Kr40OAHmD9lth0hPu
UZLZVTB/K8rwW6IP6BTZup4QrUXSHZkbaKac9TwPRpDABMBWIDStX5ANi2Q5qnNi
77PyfzbKgXpgZyL5olYxZ9jy/EIGcNCVXmgn48t4fez7FBYC/5GzGP7scR72SU1z
b3dj33cYzZ8wNuWsUqFnf06ggeFL/vKoNiii1ELibFbOLChMp+729q7+mrDdcj4P
sdnsIGaxKdidlmK09OSs1KYJcVAxPqIpYfF2gY2qpO0492f0o/GXw0UcNNf1w6AH
stIZ8MGBvRvwkF9x8OaHKGrrf8fABREt8pRpV1PBLneoVVTXe9j9tQ9mMMUwR2pa
i+W1mzEiGOFZDKjbk92LHrghE5ijt23ZKsgyiNaq/jaBoGL7Hf/2FweORQaaMYKS
n0Td00ibpkaVlYI8rTGIOcapgMIGCDgGEaeak4xexD4U9HwXkA2OXEu8lpLit4TH
206lufO8pIb/PE/4x+h9+MfYdP9FMb6TcNm6LBqmIAVqBt2KaOga389sShdcsfwV
jBcUhdGlyVUyxzMGvJZvV1K4msgL3IkcsSuQvPgXSYHnpWM+3awOPRce41yh+4gw
06PzFsaOEv5sdd8J8aOJUDL1rJmt8vXw6BkjwvMKC7BgqiPxqek5YqrTcESlzwon
koQxVucIZTs6HT4Svo44JRwONA6ZYSCKhXh9uE/HMWRZ2Ii2Ti2j8NVXhC5jf4N1
oKYy8UL9N4Nrjw3FGd4h7SIlFdM35mGqZiNuo8u9JRg8K8TS5ypJBk1uG7fgxhkL
yv2sgW2Lvt5LoGcI1OonFIABq/6Ru1ij5qPhLQ93X6SCoRuv/xrgxFkidu6yhQ88
ZwW6SO+VvM0x5ZVla0GNT9As+XdalIrbwRAgL4RwH4GHUCVUsLqljxZRYvT7BSJi
mKRpW4wa+z5MpT2WcfUtuYURfjRSF5SXXPm8+8WfLrLptG2/Gs7bFwjJM6O0NBAN
edK0kDfmp8qs21GNG0C7c2yBt2ukNGAxFu1edaqJ14tuP38g36JZTgDS8wHFnWtR
LS9p3g2c1CbCDtvewIMV6N0FDlUnt5MjHblM84d5Beuhdz6Zj2+Ahe/nx2C9suVN
yhuOplvbuFSc/5h3t1ZmPILnyp09C+KCkrLdSzyKrVgxHkMWy7RZkKedVd88qg7u

//pragma protect end_data_block
//pragma protect digest_block
5aDoPadwTv8P4fSRrxvWAtvJOeA=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6Q9aVJPnmfxyDwWtBRCiOr852RRJZwWppmiJFKFKdZvq60SQjTEum/rjbWryVAOS
0bPr7hs0cfFl++atyzOs7puP6VLQZgFxQjR2mAZxgKwmaZNSyZvWVa2/yNaOQu1/
ZqadmpJ7zFe0Q8yCzATNco6KUkkYKryAR4BO8pB62yGZoOdqiSBOKg==
//pragma protect end_key_block
//pragma protect digest_block
oPKqoOPB819ljGyHaI0bltI9AgA=
//pragma protect end_digest_block
//pragma protect data_block
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
88uOCcsGJK5pveVvDI6ZQA==
//pragma protect end_data_block
//pragma protect digest_block
NneZ3TJi/1WIBB1HhGhVZjgj7Gk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
