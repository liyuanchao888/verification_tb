
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LK1EmY4FA2PGnGIXWNvKc148qml9lr1oH2Nb5HTyTVaKZm6wFALwE+cAYysFt3Xn
vdGX8d/+O50Sd7LNcefNBp+659+ssq1JoCxKKSANainRkutgTf/JH/wDGBbFwfzD
IlNZvACIkiUFvnAY1VM2oa/aXmFq43iwnLqsBQ0cQmo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 925       )
MbWNLFYVtQ3YjyqkQOMz0PpKyAXhIxx45rkmQi/kRfqFWjvgl/LfwnWvOlK3tPjz
XW2BDh82z41XOcqiWuo2S2MfUbKjO5YjHRegCL+diVNPvLJjlNU61lMxx/epKweB
Syb7TShkq9o+olC5wWg+qsiDyeSggwU9Mzgit5Yc83m4xxEQiQtdXLVvwZq8lXR4
Zk9U8LpwXsfWP353j8tEOKUjtH8jAuvcFPcXS8KjPr+0kfTPrRLL27RORSmDbhsr
tyuriSBmHYD/IvQqPXh+Na8XfyIgB9+lp0UN+zooO46f3tLRDzh1Iw0M5GLFYQiz
/klojJcaTnJM/Jx2W/3wqigWGIQG2pq1xvM1Iy6/LDsa9wuSWnU48xCtCwNV0ouu
dIxjFWnxFzuysC1VI/OVXhvDSfyvZEmcu8MXA94ajgJdhloH2fCvyGC4wyfnKP+P
YSGOeP74mqz6v1/aEfcUtWsWcugwlmM3XrapZDrxBXpeUe+IBsz4Eb6me6k8PtTS
2EYMAomkizpQTbG3bR4c4Gw0iTeRlEAx7qYdBkHKz02MuIsYg9pk3dJUwZzFD2FU
vm9tdCxq8PYqUgRJczytJeT3JBixa6S1+BC2yC50QS6zziK7vPTHLJNMKIR6/5Cz
Zr1ZioAQ2LUIYPIGRJE9IiDDy6cNY6F9o4YEs8GIwrMjh0FQiwVJg049TcKc3517
vuXlRlB2Vk9sECJxCIYj4t1w0zJXkel0nu2WhUhJQfceWSYI069BFewA/KK618CM
oRzozMzrgCWvifvZft78kvC5k0sjTf6kEaw054uAv/M972Js6bgS0Wz4F7R7McyC
hiNsMC9t0b/imTWXNzKgJpd8eTa9viXG6ANilQirwNZZOibU6d2OnuOq+pResLwJ
9/OwQC3mLW3nNx8T+5Q5Rco7fvTbqR/hi6Dx7j6JtCh7Hs0TY+ZTI9S1aymtet89
pJ6rvmrtPRpTc1w5PFm2dkPR6sUfkXIwOoqXiQlDLoyYSgUHYwv+Kug2d0KYOUIO
QJGsgK/yUt2Q0uNuRBMK47Zpk0tL1OSA/IjMqc0DX6M+KXqbBpxjr1WuVjWEGJkx
qAhcOO+MOJQ7Za3UfMwK5zv1dyaAWRdLh4ZMUbKDPZ864D0LpALlicLn0i/ogKh1
Es/PunZlWju76e2I+sB+yZNTpP+0JzvZu4yKhSk71yBf9FkYHz92TbBEu9erKRVh
yCD3XVPMd+15QNlHRtVkmA==
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lTNpbWR6qCv8Rnh49Bp3eTGOcOtQ1ab9hSSTqY0KfWto3wRuhQkyEeAbj0rmUPah
0Gt4KR1cp3eOUNVWDyIbWXyig31X3P5ta4ZbwRwnpxtt0khQ0Mve4+Ss6SQMxCSV
hjsmel2YA9PzJcQhlGyZKv0fSjEc6usvKj80ICl1c4Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15650     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nWzJpK+eeV+PrwH9p1oS+eqxsw5v9CUyo+1VzgXn1azFU4GTTWIGxgiFqV3tqdsb
s79SSMFbHJW1mCA7eidbOJ8S6cgU0LTt5AQM1NUIl+EhbTXfGY8/WQNm+wTNZbnq
03Vx42c0kvaz8QCNbQDY0KkilDIAzWWLP7Iqd8qJO0c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 15733     )
o7Eyt/jfmA8ntpeg1wJs11YORwsLo7LO4/vWggEOxXFTqUKKAGwiNryTTH5pGrEd
wHl+YSUdvaFvRxFEMIpHjeljhR2L1Xz7jb7C8SmpGhOD3q3ml053gEkDyhR7xGbF
`pragma protect end_protected
