
`ifndef GUARD_SVT_AXI_PORT_MONITOR_SV
`define GUARD_SVT_AXI_PORT_MONITOR_SV

typedef class svt_axi_port_monitor;
typedef class svt_axi_port_monitor_callback;
typedef class svt_axi_port_monitor_system_checker_callback;

// Typedef of the monitor / callback pool
typedef svt_callbacks#(svt_axi_port_monitor,svt_axi_port_monitor_callback) svt_axi_port_monitor_callback_pool;

// =============================================================================
/**
 * This class is an SVT Monitor extension that implements an AXI Slave component.
 */
class svt_axi_port_monitor extends svt_monitor #(svt_axi_transaction);


  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /**
   * Event triggers when port monitor has observed the new write transaction on the
   * port interface 
   */
  `SVT_EVENT_DECL(TX_WRITE_XACT_STARTED)

  /**
   * Event triggers when port monitor has observed the new read transaction on the
   * port interface 
   */
  `SVT_EVENT_DECL(TX_READ_XACT_STARTED)

  /**
   * Event triggers when port monitor has observed end of transaction. i.e.for
   * WRITE transaction this events triggers once port monitor observed the write 
   * response and for READ transaction  this event triggers when port monitor
   * has received all read data.
   */
  `SVT_EVENT_DECL(TX_XACT_ENDED)

  /**
   * Implementation port class which makes requests available when the address
   * phase is valid.
   */
  svt_axi_checker checks;

  /** Analysis port makes axi transaction available to the user, just when the
   * transaction starts */
  ovm_analysis_port#(svt_axi_transaction) item_started_port;

  /** Analysis port makes observed snoop tranactions available to the user */
  ovm_analysis_port#(svt_axi_snoop_transaction) snoop_item_observed_port;

  /** Analysis port makes started snoop tranactions available to the user */
  ovm_analysis_port#(svt_axi_snoop_transaction) snoop_item_started_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Handle to the callback used for sending transactions to system monitor */
  svt_axi_port_monitor_system_checker_callback system_checker_cb;

  /** Common features of AXI port monitor components */
  protected svt_axi_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_axi_port_configuration cfg_snapshot;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;

  /** mailbox that contains coherent transactions externally pushed by the user */
  local mailbox #(svt_axi_transaction) ext_monitor_coherent_xact_mbox;

  /** 
   * mailbox that contains coherent transactions externally pushed by the user from 
   * interconnect's scheduling port 
   */
  local mailbox #(svt_axi_transaction) ext_monitor_coherent_xact_from_ic_scheduler_mbox;

  /** mailbox that contains snoop transactions externally pushed by the user */
  protected mailbox #(svt_axi_snoop_transaction) ext_monitor_snoop_xact_mbox;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `ovm_component_utils(svt_axi_port_monitor)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, ovm_component parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
  extern virtual function void build();

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
  extern virtual task run();

  /**
    * Report phase
    * Reports end-of-simulation summary report, checks etc
    */
  extern virtual function void report();

  /**
   * Extract phase
   * Stops performance monitoring
   */
  extern virtual function void extract();


/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);

  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();
    
  //----------------------------------------------------------------------------
  /** Used to load up the err_check object with all of the local checks. */
  extern virtual function void load_err_check(svt_err_check err_check);

  //----------------------------------------------------------------------------
  /** Used to set the err_check object and to fill in all of the local checks. */
  extern virtual function void set_err_check(svt_err_check err_check);


/** @endcond */ 

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /**
    * Called before putting a transaction to the analysis port 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void pre_output_port_put(svt_axi_transaction xact);

  /**
    * Called toggle signals before putting a transaction to the analysis port 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void toggle_output_port_put(svt_axi_transaction xact);

  /** 
    * Called when a new transaction is observed on the port 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_transaction_started(svt_axi_transaction xact);
  
   /** 
    * Called when a transaction ends 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void transaction_ended(svt_axi_transaction xact);

  /** 
   * Called when ARVALID or AWVALID is asserted
   * 
   * @param cfg A reference to the data descriptor object of interest
   */
  extern virtual protected function void change_dynamic_port_cfg(svt_axi_port_configuration cfg);

  /** 
    * Called when AWVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_address_phase_started(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when AWVALID 
    * and AWREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_address_phase_ended(svt_axi_transaction xact);

  /** 
    * Called when ARVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void read_address_phase_started(svt_axi_transaction xact);

  /** 
    * Called when read address handshake is complete, that is, when ARVALID 
    * and ARREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void read_address_phase_ended(svt_axi_transaction xact);

  /** 
    * Called when WVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_data_phase_started(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when WVALID 
    * and WREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_data_phase_ended(svt_axi_transaction xact);

  /** 
    * Called when RVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void read_data_phase_started(svt_axi_transaction xact);

  /** 
    * Called when read data handshake is complete, that is, when RVALID 
    * and RREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void read_data_phase_ended(svt_axi_transaction xact);

  /** 
    * Called when BVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_resp_phase_started(svt_axi_transaction xact);

  /** 
    * Called when write response handshake is complete, that is, when BVALID 
    * and BREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void write_resp_phase_ended(svt_axi_transaction xact);

  /** 
    * Called before putting a transaction to the response_request_port 
    * of svt_axi_slave_monitor.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void pre_response_request_port_put(svt_axi_transaction xact);

  /**
    * Called before putting a snoop transaction to the analysis port 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void pre_snoop_output_port_put(svt_axi_snoop_transaction xact);

   /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void auto_generated_dvm_complete_xact_started(svt_axi_transaction xact);

 /** 
    * Called when a new snoop_transaction is observed on the port 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_snoop_transaction_started(svt_axi_snoop_transaction xact);

  /** 
    * Called when a idle period of snoop channel toggles acwakeup signal assertion observed on the port 
    *
    * @param assert_delay A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_snoop_channel_acwakeup_toggle_started(int assert_delay);

  /** 
    * Called when a idle period of snoop channel toggles acwakeup signal deassertion observed on the port 
    *
    * @param deassert_delay A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_snoop_channel_acwakeup_toggle_ended(int deassert_delay);

  /** 
    * Called when a idle period of snoop channel toggles awakeup signal assertion observed on the port 
    *
    * @param assert_delay A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_snoop_channel_awakeup_toggle_started(int assert_delay);

  /** 
    * Called when a idle period of snoop channel toggles awakeup signal deassertion observed on the port 
    *
    * @param deassert_delay A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_snoop_channel_awakeup_toggle_ended(int deassert_delay);

  /** 
    * Called when ACVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_address_phase_started(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop address handshake is complete, that is, when ACVALID 
    * and ACREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_address_phase_ended(svt_axi_snoop_transaction xact);

  /** 
    * Called when CDVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_data_phase_started(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop data handshake is complete, that is, when CDVALID 
    * and CDREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_data_phase_ended(svt_axi_snoop_transaction xact);

  /** 
    * Called when CRVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_resp_phase_started(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop response handshake is complete, that is, when CRVALID 
    * and CRREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void snoop_resp_phase_ended(svt_axi_snoop_transaction xact);

  /** 
  * Called when TVALID is asserted 
  *
  * @param xact A reference to the data descriptor object of interest.
  */
  extern virtual protected function void stream_transfer_started(svt_axi_transaction xact);

  /** 
    * Called when stream handshake is complete, that is, when TVALID 
    * and TREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void stream_transfer_ended(svt_axi_transaction xact);

  /** task that can be used by the user to push an exernal coherent transaction */
  extern virtual function void push_coherent_xact_to_port_monitor(svt_axi_transaction xact);

  //----------------------------------------------------------------------------
  /** 
   * Task that can be used by the user to push an exernal coherent transaction
   * to the port monitor. This transaction must be sampled from the output of
   * the scheduler within the interconnect, since the order in which the
   * transactions are input through this API is used by the system monitor to
   * correctly associate snoops to coherent transactions. Note that this API is
   * to be used in addition to the usage of push_coherent_xact_to_port_monitor.
   * This API does not replace the usage of push_coherent_xact_to_port_monitor,
   * but provides additional inputs to the system monitor on the order in which
   * transaction are scheduled within the interconnect This helps the system
   * monitor to associate coherent transactions to snoop transactions more
   * accurately. Basically, it provides additional hints to the system monitor.
   * The usage of this API not  mandatory.
   */
  extern virtual function void push_coherent_xact_from_ic_scheduler_to_port_monitor(svt_axi_transaction xact);

  //----------------------------------------------------------------------------
  /** task that can be used by the user to push an exernal snoop transaction */
  extern virtual function void push_snoop_xact_to_port_monitor(svt_axi_snoop_transaction xact);

/** @cond PRIVATE */
  /**
    * Called before putting a transaction to the analysis port 
    * This method issues the <i>pre_output_port_put</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task pre_output_port_put_cb_exec(svt_axi_transaction xact);

  /**
    * Called for toggle signals before putting a transaction to the analysis port 
    * This method issues the <i>toggle_output_port_put</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task toggle_output_port_put_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when a new transaction is observed on the port 
    * This method issues the <i>new_transaction_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task new_transaction_started_cb_exec(svt_axi_transaction xact);
 
  /** 
    * Called when a transaction ends 
    * This method issues the <i>transaction_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task transaction_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when ARVALID or AWVALID is asserted 
    * This method issues the <i>change_dynamic_port_cfg</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param cfg A reference to the data descriptor object of interest.
    */
  extern virtual task change_dynamic_port_cfg_cb_exec(svt_axi_port_configuration cfg);

  /** 
    * Called when AWVALID is asserted 
    * This method issues the <i>write_address_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when AWVALID 
    * and AWREADY are asserted 
    * This method issues the <i>write_address_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when ARVALID is asserted 
    * This method issues the <i>read_address_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when read address handshake is complete, that is, when ARVALID 
    * and ARREADY are asserted 
    * This method issues the <i>read_address_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when WVALID is asserted 
    * This method issues the <i>write_data_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when WVALID 
    * and WREADY are asserted 
    * This method issues the <i>write_data_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when RVALID is asserted 
    * This method issues the <i>read_data_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when read data handshake is complete, that is, when RVALID 
    * and RREADY are asserted 
    * This method issues the <i>read_data_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when BVALID is asserted 
    * This method issues the <i>write_resp_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_resp_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write response handshake is complete, that is, when BVALID 
    * and BREADY are asserted 
    * This method issues the <i>write_resp_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_resp_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called before putting a transaction to the response_request_port 
    * of svt_axi_slave_monitor.
    * This method issues the <i>pre_response_request_port_put</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task pre_response_request_port_put_cb_exec(svt_axi_transaction xact);

  /**
    * Called before putting a snoop transaction to the analysis port 
    * This method issues the <i>pre_snoop_output_port_put</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task pre_snoop_output_port_put_cb_exec(svt_axi_snoop_transaction xact);

   /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction.
    * This method issues the <i>auto_generated_dvm_complete_xact_started</i> callback using the 
    * `ovm_do_callbacks macro.Overriding implementations in extended classes must ensure
    * that the callbacks get executed correctly.
    * 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task auto_generated_dvm_complete_xact_started_cb_exec (svt_axi_transaction xact);
 /** 
    * Called when a new snoop_transaction is observed on the port 
    * This method issues the <i>new_snoop_transaction_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task new_snoop_transaction_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when a idle period of snoops channel toggles acwakeup signal is observed on the port 
    * This method issues the <i>new_snoop_channel_acwakeup_toggle_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param assert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_acwakeup_toggle_started_cb_exec(int assert_delay);

  /** 
    * Called when a idle period of snoops channel toggles acwakeup signal is observed on the port 
    * This method issues the <i>new_snoop_channel_acwakeup_toggle_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param deassert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_acwakeup_toggle_ended_cb_exec(int deassert_delay);
 
/** 
    * Called when a idle period of snoops channel toggles awakeup signal is observed on the port 
    * This method issues the <i>new_snoop_channel_awakeup_toggle_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param assert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_awakeup_toggle_started_cb_exec(int assert_delay);

  /** 
    * Called when a idle period of snoops channel toggles awakeup signal is observed on the port 
    * This method issues the <i>new_snoop_channel_awakeup_toggle_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param deassert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_awakeup_toggle_ended_cb_exec(int deassert_delay);

  /** 
    * Called when ACVALID is asserted 
    * This method issues the <i>snoop_address_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_address_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop address handshake is complete, that is, when ACVALID 
    * and ACREADY are asserted 
    * This method issues the <i>snoop_address_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_address_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when CDVALID is asserted 
    * This method issues the <i>snoop_data_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_data_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop data handshake is complete, that is, when CDVALID 
    * and CDREADY are asserted 
    * This method issues the <i>snoop_data_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_data_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when CRVALID is asserted 
    * This method issues the <i>snoop_resp_phase_started</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_resp_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop response handshake is complete, that is, when CRVALID 
    * and CRREADY are asserted 
    * This method issues the <i>snoop_resp_phase_ended</i> callback using the
    * `ovm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_resp_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when TVALID is asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task stream_transfer_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when stream handshake is complete, that is, when TVALID 
    * and TREADY are asserted 
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task stream_transfer_ended_cb_exec(svt_axi_transaction xact);

  //----------------------------------------------------------------------------
  /** Returns clock period value */
  extern virtual function real get_clock_period();

  //----------------------------------------------------------------------------
  /** Returns current clock cycle value*/
  extern virtual function longint get_current_clock_cycle();

  //----------------------------------------------------------------------------
  /** Returns current time measured as (current clock cycle * clock period) */
  extern virtual function real get_current_time();

  //----------------------------------------------------------------------------
  /** in external port monitor mode, this task constantly monitors mailboxes of
    * coherent and snoop transactions which are pushed by the user. Once found
    * then it sends those transaction to the common monitor component.
    */
  extern virtual task push_external_transaction();

  //----------------------------------------------------------------------------
  /** 
   *  Gets transactions from the interconnect scheduler if they are
   * input by the user
   */
  extern virtual task get_xacts_from_ic_scheduler();

  //----------------------------------------------------------------------------
/** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
endclass

`protected
IFA=UEF9VNVJaSSdVW-N8ZMNLP(7TgR]S;F]FR-W1,5bV+P7(<T9()EQ=43U@Ye:
[7:>\,V8.(?7B15^Ng[Z[/CW:2bY.;:GH]<FL7R9[URMCMLG?-7U964S1AI<bE^Q
6Of2HH3;K-T+,<QS\S75DWC/d+VI0d]d9A[ROPOHg-F55YJKO.RO,].0,[ZIUMU#
QU#J<&84AA7ac[^]F=[]^^1M<4af4FD#MM(7EcGgXRUJHAW_^][QVa(A2(a8<OfQ
J?Kd1CRZ/#Na<6)6[HS496IB_X5EA@51eVT\cdA9UKTF7,5RXcG.C24BJ:?.G3CY
C@;JX.Q,S11[:0LSS=CKO,H(#&+GdHH#JYQ;=0@3BR5TNE<,5Z\)#M.U;9e&;Y=A
M9aRS^]K&<YPPOR,?=@TFc=I9T+e6Za>_cHV0Qa/5DM;]4;+7WbgLEHJF(aIJ:<0
SC@Be-0X/PB0W-CZcGMN)X[P1=X[AU)GQBT&Fc6H,Z4[,9+(5-?930T+V=dQH\<g
8dO#,CYG+1NHOOIO[0)S0g]E#C,87EdAV)+&Je>WGARY0D_-<:O3S=\#X23\M=P?
If@@M048ffeP9KG/<T;a7+Sfg?QcTI\-Qc)Z7L^df(O9#bCd7M^bWHWdYKGZ@^Ve
2<<\H4B77ea@+6KB<ER)[7D-Q]RIV^=Q.\J<#65OVObPe4;KF;I/(b26WGEGd&Q#
VOgPY4(O=J(-CFbRe^QI[fD-6$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
;a65C[gVG&9A:8JG@gL_gPcZ0eQK.bagDJ,2Y7^/#H]QN?B:A9B@((EOYLD3)C,.
VOE?X.RS:aX-BXS#00X77fSU5^X)<H[6-C#0KY=:;&<6V4YPQ/4E;3gV6?7BGLV=
_+>.63g&EO5JaRP1:RWeJCNAT_W/,K2_dPKbBU]=<SSV17MZ)A&Y0^B5U2eeNLGD
Gc/AeK[2O02:1+2_<Ta&BD)2BZ=&c0Fa7dQ\YUcN9+/-U8E+8W+f,605bB\4T<e^
GR7c:0]8&H.V>0&151.Q@WY2M,H;UgK:B9KTLf1;9aJ0U[V>O91FJKMe-;[J;G\\
<b?ae0ZfAe=RUB&,bIBG.J+TL3Hd5O,a,GU7L^2O45Cf=JLW_:fG@JW#7;(E&PJ.
^Hg7;G\&F?]RbS>D,e16/DbON8QNbZ::d##OSa-:\XRUA=849]c5;=Z231VQ\KPJ
:EWO,f9Ce?IAUg&9R1UI&E8>]_>Qc[+H_H5/GI&UaJWC7D.<K&>>J1<-WacZBadD
.XM#&A?_[4cAd6FM/RcOE^9(:IYMe]D]?P/]K_<37/FBV\LeH@[3^=-V6)I_&McA
V0EEAS)W<WSEc2/H2VWAKR5#_3M=^DB(=[=O&dQB60M#HGMI&[T2gXZGK>JMC8;L
9_IUNc)^Q?7:#D.F8SE=c2<=PRd;]>XRB<H@8G/M0]>g]+PXUa^[N98FV8_/0W]S
<\.,;[Q6]e,4:fA=O(82)?R6_d;AaBJVWN@3I)LdP^(RNK.+Q0,&BC-c^&bEbCI+
_JPH>2Z/LA=fG::(V6-aEIHYUIMF:3;YBB+ABJFH8+N/d+4dcG.900UdI&-WDB3:
.@6<9\T,^7gb>+XaFCOZ8LW]JPI3:Tg)GU1PMRf5)JO[&+Lb1]Fd50:=B?cE@egN
)+9Q^)f1;ST(ZKT[E2AC4S#IPgd,W_cX),YC04UNFY6b9=&-g=)A4?U228DU\B8(
9YLX52E)V=36c[>SE-UC<RO+W<-CQJEQ[a_>K5J9g&DU:(^_Xe-<1fd:#;6>?3,U
I7.5QgRH4;Oe1Bgg,MeTA8TVZ[.;JTZYBCfHIHgKWd7W>[O+QJY0>=Z/>[2L>F2-
7dKEIP^@S<RIb?X6U]fJ]WLOY)0Y\O@<W32C5P14g@_91G.Af;g#V,^b1N&-ML&N
=V<6J2=]B_Y_NTQ@cGIeb_9)g1]L)EX7+Z1g^16C4J5-_MXRSg+<GA:_Q[HS?W-5
DMR9Rd/?>TL<0g1\VaK6FW&gXRRgcJ2&Z;X?C)S/&>I+1;Pb1TL1[ADFVA)UE3W^
e=fY5^8?\P4>Q1^#VT6IMEacTNT/:ce3]e5&6.I\0+S/&<Oe:H,MTYg0VT166ZF>
F2,bZND8(4?0V<OETaH4V2.W\1Cb^/dBM5;V]]5G<J[PI?L;9[JKOLBJ:ZA[1QL[
>,eE2M[HYWPG.]D&&\9CHF>12F]7[WD\3C8LeY&)<V&FDGFNTZ@Y[>RAE5Y,.AV+
<]1)7Z\NIAI?=MH??-1634d#>fE)JO5V3Me]>3^9,=S++;Ea)VLA.U5?IY.)/.;D
^.7T:^WSQY&(4F/J4EeY&PO<0#@CaNT^Y6/XBLW]M[R[ba])+Y-D3,JK6Q^.e^,T
)Bf4[g4QLUSUOX0.fG<2WKF#Z.CO4FeKNbHJI.TJFd7,DfJ#N4X5;]:Pf@Gc9H>A
LIC+<.B3&d4J2DIYXZ#_,50M-+BD_Y87gb=daSXA50e,QNQHYFG_10gA3]WY=:f5
1-D#gM2B08WPFSS[e;NdJNYGZ4HeJGGL@Gc<NXU>QAS6)P3.27bBC+A;_Z9H^d:?
>?I?D.UJMDf1QH3#6@9XCOMH\,S\eX+=G(?deA+JHdQ(:3VJAP,.Ee,SL(_Y2T]>
8>aL(I<]A:LTWQD)RPce7Mb,6:=/+C-gP4c[I76XeD1_@HP25>JM4:Yea38/Seb?
U<QI1?TVGWB[4.W5R&Ve___]cN3^UM=g]5I_A)7Xa]eK,5[(eOLSWb4,NF>URZXF
3VLT).FDfWF0M7RM:]e9XC0I</)I_f_<]W7UFQDD.>>5+T5Z7&eKfIIWGfRg_Q,.
VbGcPAQ?1Y@=42J/C.93E4(;<Z(f9:#7GHO@gC;-]]#_32Y@<JU9<S-(WH@R,#(;
\fHZM.TI3CO(IWEAI:@)^557B27b]W<+f^IC:.fL(99dcVGGFM9;c[g/NZ,C5KL7
ITLMD1g4Rf2-H7Q)7+J:=))]U6fCDN77M3b@VN]1(O)U\a(TAd01=GGW9&EZ(cAT
#PF=/PTe_.WKAVR/86KDCG1a<-Ng:ZK3#ZGdEb#IR,D6;@+Q\T^[+O1[B&ULc_[E
HH:BL:=BfU;+4^3F[R&dPZcOWNbA\#_\R=8Q54+f?U\Y8D\<0T2),=Y8ge:2dG>+
:0H#DF:?W]cA=][8<(#V#c.e+P0KGN_J7]WR0VGZ;B3/F;=4&Ze2c@PbaHbbRLVe
;_.]R_T/TV_Y).;8,Gf)a^MXH\eWOLUJYcST<S2YEEP579d;HM2BN?eM):/VT]a&
,.XeAd0RP(SXe<\W\)Kd2O-f?6GXKI>U<EI7VD5M6]D:\T5JF59E5)V\c-<2-KA)
(XL/^dN726J7c7\ZC7.ZYe2EKb7@-^^WEEQf]MT)]CA=aXYNL:AgbPNCCQF@2OB#
;+:[,Y:699T6?+[]=(5).-59?<PVO[>#9_8W7;4H&_TF^CMY?==;Zf=G:UJ-FP@f
]Q)VbA@9RF[>dTJ82b@7g]?4M;5;S4?\BZGcIC=4B,Vf;J+]KUYdSTPULOSY7UY-
GL(CF:<=F-Be2ONR@3BQ9<Xe^6<^1]/H\VgP=G5V6C85V6K(gR.8)_YN/?1dbV;.
_JG-IZ=H^?8Wffg7M>>R8ZBXG#YX8;d^,U=f@XD?HCSF[+BL\I:+[I7L\X^\2GV;
\dG2N_c_;GUL<dE6S-5AG]K77&D1L0)]f2J_65&TJf0XXP-K,U<R;F2TC>dJ2K,T
KFM09:Q)6&L51)O_E5[;gb#CO/C^-KNEO)JXVEUQVB868)TU.;1#&[E8RKb&@dAC
Q9=4Q>7+@UCZL4X,RESO8/Dfc4+8VVY46RVM+^(d65a?0GRM6I[-fCL)=UZ#Q;HP
?IO3JPI>I=7]()UU_Y<K(I4F[.F5-Yed\/Q9+VdN)?6=8(_X3:gI,;fF:fL:5&PW
_U^M:b;)>da4QO(4\ZS7C>aDOJ>:7MS=cDQX>@e.c=,DXP8ZJeZ>Q..E@4A#61(X
UDJJZVU&^H2O^WdX.<BDEYH)8dPbY5HgYTe4JQVG=LU:dHMB<7&VaL^-]eV>R@:-
\0Ug]MNTZ&KD(:^8VOE.b+>GMOadAGgZ_.bCLb6H=]EA8/[]fb<I4DPAKW)4V0&#
b?0f1V1Q5=9>,K];-)I[8c.VH4NHNX0N/1B@=agQKc6>Ya;fJ<T\f4Og\Z4I-=(Q
\#/bGLc.L-Oa9O/[a04Q4IZB_#76QW+N^8bIOD+5(4f;g:fL)aVW?CdR</6NdBYM
Sb?H?TZW;OB;Q\0]YOd#Kf-U1:9?_5[H</KU#PP\FDLS041+fR@EXS&H]W/66=B<
0?DBbXU?Me4WeL<?1>D1Kf,L]OP_J_&cS^(1e5JT3PD<Ge-N2D<7OHPJdaD?MJWI
aD=0&bFV5KD2cB7N6>:2=5@U37fP3@BW(aTcVC[,>#+F6J^e,4[9]FA8LL(D[e^S
ZRC(3[=)fFA=fC-Y<UG88Bf:]Y/.Ib\AVLHQKebEaF/I>FIQE+\S+?=d<M3>&Z=e
(HN@0,C6J&(e,U80MWcdI_[4S&.ENa-I81M)a=,Q1T_aZTGeF1Q>71I=XASfV.PO
(?C35dS12CNd@X@INTfS0U6a<X3F8ICNJ<daX[L4W/;A?QEE0GfXfUB-3?49OYfb
K4+L/@^?]Tf3N63:M_7PTOLb^fJGY6bLL+HG,=:NWC5F:2?2O_(GEPFM-TIE.B\]
aV&IUK_C\)dSZ?\ISQg_O)IN&BcAdUD]9>P+\#()F&#ZdFTAf=OT,4VGY6KbgET3
F)Y^0E4(>AdW,)F:BO?1RK(AP:LM9/AQN?2T:IWPEHISI<-1:7RcgNg<TPIe:He(
A:PUL7\>/PK_d-WSV/dS=[O&C&PL)Ugf&9,V99HQ81NK\,#OgVU^YZN4V94gVFTQ
&bBS=6)gf7ID)=XA&=X9M2=0T_QZUDQ4FSHW.V0_c5QK+K(&3DW2U#Jf3UUbdKHD
M2Z<]bRf.<)[3_.3Q_a:>_3_^/8.Dg2TDBG9XOG+4JJgUCe&g=Zb:0ASM+AQ,)dE
1KA<J_E;+LUdSe<QA&15I/U5L9Q501O@gMTATRSB_+J)<X>,Q#=<Bc^Ndd3_1/9R
9.f?Q/bT\7HU9Y&ZI<Kb+6A5CgPW>\V&H0AV/RW>X6GbUCHD?CH>DOCWHaO5MaLe
4SA,L@;Vg2@=_KP<?Id?aERHNR&).gOO@fS#SD(aQ+KD9<-[9U29cb4V=Lb+.T]Y
1#-N<c>3a/_Ad.+f3P?&3WL6LV6II@YQ,>7S1?M#,08.LS,XHSd@DK(Ma=8=b>Q4
OE^8AYfAV(ISUSKABA7,QWNW&Mf@+FN.a.Af9ae,Z?X:[.]5D,^F6D7aBfH/BPdK
2HF3/JFP/5PDOGdG8UJKSV#:d(RA+NVANM,4XIUgA2-@T#+<(5FQ>07b>6+@c-85
DbT&4[VWe[)QXg0R8+4:A5,_a.T?NOb1Y^8<J.f4>;VMD2KELBH&-[[77TGJ/ga,
VVN[/g6^0IXO;3+CNCD:;L-\HKUBH9;EETFR/=?&ZK@BI.P/8FKDL?TAU#N-[f)W
1KVZPT-;5P+eO20V>@;5,4eGI?2+4@Z-e7b6T.\TT=LS.cdF4L-d^[f_LX^Fc2R/
=-@37&6<L0=f_C\V9\.8:RC_M1c,4)CSB)?FQ-a@MS8@[64+fOfACM&b.0d4Kf+N
@<dXdKC&eN<]T(?ZeP[=>Wbd@&Y(2b6NIL\G?df1agJ.?IEZ^IPb:V\G<&264Y2B
3A_-/(P18SAC#8.7Kb=fbST-Yb\6RR)<DL(XL\D)[NMY(+-&N#cY&WbN7WF_RAF(
c(<QQ][\@)M#dKDC4=:7V1AYD<HX#JM;U-6Jf6fQLIN+KM;K=]a509]J:#AF=>;d
UYB\V3I.6/H2R#cK;:S36M/_Z_=B5)3&0NFD7Vb+K5A:FOGa]3=H.V;P/C[2&FX@
=JZTB/5?Q#,9<BK.CJZBYXB1W(]d,RIKWIHPLe./((a68<ER^F.)N4B7VYaN&a3_
KP)cfZg;NOcCdLcS.2.<_0BW+?4+b@_gW,9\;H@YB]cBa[/RFL#3cL6<&[+E=ZJc
Z]XQ;WMbSd^b&J3/;SW5Qe@R-3+45:TLE<=J=IR>A+FcQ:80ac(P:[e^GaYU:K40
b-=FU<?W;I/Y7K;#G[<\E2\2H7AF49QJ<//b)dQ2T7HLNB#5;<FNBAL<<4FGRN7c
Z3BU=(L,30W.=a=L+9F:P=E>NED(IeUNF.b=UGgCP6K5#>TYOae=(g88CZMGD=][
OEB=]IfX>fd7JI_NE:=f.PL]F1@08c?,<?QKAbNXVf3]HL^7\Z\SK59A[F<S/bQQ
g4^f]/P#&@C5eP[J_UC7,\?Ud:9L/[H<f>bcPV^CP]59J.\ZgM5C\LME/KI)_6\4
2QME6S^3DUJ>fA1cX&WOd:@46IT^\B1b_G#:W0?OTe^CgFG1XZ#VI7]+N36_Z_5]
.#E,\OU^M/SJ<(3cbcHBP2R,9AKDCX)(d[GE=.C9g+(@1fQB03#V/:,JG_4cZ\e_
CKeWB>7OGE:K_H4HEG1>9?^gPH>X-A8X.75/aZ86H#U[]#MN#;&N](QL&)Z(0[N5
1JL18@d4SERX]#.&B8K:6>6S/4dVNQ_c4b@SEc(+NRWJa_NG^J@2T>NA[_\[Lcg<
#2:1=403[LXNWR-0DQN9UL+D\889IP>>C-H2?J,E[e7A,)2D_UIS[Wg.-NKQ<-W#
f3U\)cQK&1Yb]U(V[_SR=5cY3=LBT>ENL.9f3ZCaMY](2:QMZ07:\--f]C>5gWMA
M1995Ag7@P6=G?8KPO?H#NK5ZI#\f^e9/J4DGUWWI5fOcT_3cKO@N7N(M@N?7]N(
fC5.]A3UgFe=EHFg9b8N4]0(_.EC.3La)V7Q4d@A:D#7;8Z7@>C.b>5d&BV:#\]b
I_:@9#6RdbY,LU>B@0#-U_15,QZS(e4W<VMP+WWd/93NFRHeaPWfCD1MV0SKLY0L
:641H9=Xf#3M953-CGb7/5ac8C;PM\+Sg9>LNU#S6S:/cc,N+K>^NPa^.f7MWcO6
RAPK4;:B+V>6Q>M&b_@YF+M5dZ]X8b.e2[Z[5B,AM/<1[/.bCD\18=<6f68A\Pfe
^XO(4g:EEWbWf3NGDXU3>1R_K?eTPKc^Wa^7+[IeQ/3b0ba\Jf6JJE<^Z_X282Y>
7cNWT?_4X:@4;DVG(N,B\=68^@a2L6+8B=ZF&U)WQ]O+JE7=JIO]J,&>Xg7&dD84
MJ&(S/UD9)LNJ/L?DP4[NbN8;b&I-fZ8EKMQ])[aZ[Q/-6]<6Zg@I^S:(582MfQ(
B1fQXI]d54/Ca4OF(,-6VSgcZ[E^_RgbTM,L;)ANVA9R-C-FS^c\HB8#,7M510T2
\6QXWI.f?93?Y6.+\Z_S8Db0)=WF&,DD?-(IQHVC+K?W+3d1H32QX;ROYH>H\3I.
__#J.H=;J]UKCBZ>>U<>L=&7;C\S(0C8@QCCHV?]Y=/2K3;C>EcGA-NST-e<R:SJ
^QT8+fa4d(:U]M;RZ?Mc@]^XfHK?R)P;D=)?R+]EG(HM[A;RE<XbN#c;CH),SJ4a
Jb7WM]Z=Nb,HaXFO2b0[.G:(##a^<._TM(F)LWAUeD@V67e=C1+V/caCcN#HAIf4
\A.U=JH<^YM_]<G;.9JCBLX(9XU[(UUcZ(Le,T+3H\/5\6>=5\(NZfNGGL&YC_^d
0WP4F-UE4a=S--.P<G/:e+2S1dR(@R&XJ[5d1e\c,Q.LBNY-X:F.Nd0DS=RK9Pg^
VG8<Z48&.)>4LI9+\?6IV.FPR2YRg20T+_:5<>PFM0EU3N^MKV.gG1b7eIIAX-^F
MJacW\IE5NdYDF]((ZT-,G>e4bZ)V6+0)bb]fRMR60YETSP]NB6NDCUD;;VX0.a>
^EU\EQ,_O_LdEHLaY0^\1T2__GCG3L+P2P+P:A;ce/IeF7A(J37\LX41XG1I);LV
6d+C9VI#G4,0WcKagL14JQf\f2Fa)F(\X+(C5I)Vb&Q6B]X_aB])HPB0ab(<Ha9J
_706MOCHaZ:_c=d)3H\eVFcICQa9g5Od(5eW+LI7g(F8BP4=@S<cSgI,/HaETZ]M
W5EZMF,&XTB44);D[R.c0K^GfT[EM8QTT#0CKBJKV8,AS?GUQF8_6<MgS]Y-YTH-
F;@/N0C=D@L<>ZN,DIV1I0;S2=/5OG2\W;aQV1MFK.WOC@>R2R^OT#ZEK<F^?O3(
@YA\adVC,-fa?G4c;4<K0)Te/(SEQS9a7YNf2b1P1HOV1M<B>+7TU)G\79#T788>
)0ffA=&/gGBSJe2IWNW(-S/\=d>Gf?98=O[@7P(T+^&VERCLd1+f7b@[[JL;VfP8
;?(R3\1YPc#BeH[7KG]b5M\fSSINZY:7a&TQ^HEZMc:3#^AX):1CUPSVNXQU99O9
<PHUJ]CO.g8&aDa;UbN#I2g#c]RfVLG^W]FFW?-7E;\g=ILO[,TSH5eGQ6;8;KR&
bQYZ(L1B5gfZ7VP55R-#Ia:P+^^@VFZRC>Q7cUE59f/e9&8bLG;UP1IWYYL&[SI^
gU+08@>OHZ_)ND;MGBDS/dBD5OFTg3\eMU<N-2_>f3:G5e6HH[d/-SaLQ)^Y@;gA
KN,#JWWF\dcRQ8<8]U-O+[>LdeeQ/<&B?D)._(9LSXD&CggA36(:G)=BRV_0a[3W
PEHb50(Q3@2_?WYTMJ53IWeKFCIc38A\6Y2P,JB>WA\23ODbNb8V=D.YH+V9EL3?
N+)2M4&)7E7MGf;=:60:+#eR2-AP05CgFCO2K<=M>5O&8+O2]:HAeX22R(\gS>P<
g2b?G@-aCg<FJ\M.5E6YCACG0\^Y?-_IK3S[3<[M_F>PM[3GISE/^,gC>38.XE)K
:gf6;/]_<6)W3]W&99\W?1B2SE>R7-E\3K(?53GL&a\b5d+MOGQ-08f[-?W,1P4I
3I?U>9gf[-YI]39CeD3Ca0\#C:AG].Q=Y5W-N5=P4+Pb66ST<g\LBBe\3Uf3d5XU
]@3&P[((O-^47U5gbR]V#]J9GcGYX_HPBE,&egO@9W+WQOfKRN]L?E0QQZLK_+?f
5P?LV&]<4gVFL:CK;20?;#N,g)1@5.PK;\FSEJP,+-.6V/-,0Q1\YK1<9PAXJ^IO
I+4)X?-RcACJOD,Z,f]Mg)BE\RJPHe,8b5aKRP2#&ADdSJVHEb[P2MMN;\6G2FDU
eKM)7G=CIKQ8^9VS=T?#GP9.=92&9NM+K#C&+aW92^c?R4IgOW+K7aQ]N5H9)3g;
L/YOIOU]Y,_,H_&gOa.P9Q@+fC_5.b5)Gd/CRK)A)Db0b4&b-ID<[D(XO(b.?_/:
__\5=[4:QD@<X/7XL&M#2VH.48d#NZ^a36@V@7+F2M=(HSG.@)0]Q,S)E/GCB]gU
N6D-VMA3d@<ZV<ZSRXJ:L&gA,I]@6,[_E,XV09_LBQ#CaG.PPC6JbSOC&N]]2[<8
4Z>H]NI-M]ISG;^KY].OZ&fTE<U;W_BSQC:^]0+.7XfN,V#+IAcVcFVFSLUO41/J
AFf#XZSdaDZ0&+57EMH4@U>DP7:#@FH-b#c7J>aH:L1PMQa[Re/N\a>DZ4@HU6;W
U1^:6UXENROB^Rg9T#:W\,f<ICLbbeC-Q\[>cS]HI(&1c4_8X]PT3-52=6J.e6A8
e&g\@T)6GMI.8a&LA[?FU<HI<&CFVa2L.C]6c<Y^THSER35QM6fNERDfQ:/dXb+@
2;e,a(1/=7WK[K;#d>>-9fT[283>69C9IY[(62F##M81N2Uc^g^O3MKK1g/7\d)5
-4+X/MA-Q8,Y^KE3[@M&_.MY,DfKXZXE,Z>E?2@EN[N=JCZ5gL?8^f_bf.a>51]^
M+?4F7V2(14WG8@&G/\_.TaW:E),YR\-6;FI.1(H>Ka3aaSRAJ/)=<<C[LI5da(P
571SbEMRZ=H=I^A(S9SEd@c&BK5XMb.7TL.>-9fMA40VP#b4IdLNZ8+D28_B];7e
UZ^0,03(M[LFN4R<fJF<4VU),H<=4=4cV5S\,DfJ9P&A)/DcZaF/+[cS>d;,LdW<
7P/?GWVVT59.&_G=U;UfPOAL\K026ONXC@93Z^bf.?Q4#.;M@/>#3O@L@/Y3eJg9
[ZU6a,@D?<4#2(\Cd&,@8SEVaW6[YGNJPdP-_dd-.(M&[52Z?[HDZUY[I_)U9F=R
f4CF6Z(HT0JQ#X@O)8>a>&L7NH)PgZ)C&^O6NW/7CU0G^T-g?a:a=A<4cC?ZD-VI
1;_C0-c;?3NS2)/AC&^7IG#OfBRc7R[:V))YU@UM7SZ=0Vb4dBg_)X(9CFX7EUDa
.,=WXTC.+b;2/2J;[/JYGd:a=VZe)<dFC(Y++E-NXQH^)&UOXGC?2([]82g@7XHf
5Lf&@-;0EX_6GNXb)YUE-0;gUXCP=N>VTK/GD)>R)YMGB-ed5d@8d(6=E8NF)f]7
[7H,;Hb5gN<d\Y1&)]^JZ1MS3598=+4f>[571A+DQP@O#7XS_<eeF9E:0BV51EYE
_.]US^VRc]]f7[GJZSC>f3J7?ZOTd&.=L]KeN5ZO_2[e6+g=5\P4?GSB(B;dC7RD
5[-dHKa8P^N?:7+>DVQX1JbSdWgMB4,GNeS&O2P_g?(a@b\,1REDWKW]8+^?+I-L
I:#dU#\=4_T8b(YD\dV8^K;VNKJLY=#V6:?I:^X<>dP3+)6MeZ5;eFK2+-0/@=ES
U1^@e+X81_a+dHV[T_P1RdTa]:AR-3bT890eO:b=92<K#TB35IR_H8ZcHP2@,YZ2
]Ka185gC7N)3-]]E6IF>@5F8C\33a/9bLgI;9BW)cF]T+a@AINWRFCKRa1V_Y0LM
S_RJPd/a=_eD8f5KLQPJ1GAgBC,e_4G.#:PRX(-<3eN]:A(\2AD7RQ5,W-RGZXJ4
N)T;TM7OXe88YXOZ0Wc?J[/[\JB#I1GNR/+gWCL#FVXJC<S.BI[49AQ@eUa6/N.T
=\YGT(_fc?<7>K_PF=EJc6b5:6H77;O4M_X39/A5ROS;dA5WDbU@UR1B=/]=Q=>D
&R(g5?+E.K4[5T?+@L>NFSbW?=;fW/^+bIP7a^5LMMA[_??4X1LTR1fP37WZCI7-
D&>/Wc5/RY4WG8g6LN-;92Q>2,7VYP?QS2;_9-6UG.b71).=TA@4-BY(?8e8JEME
Q)J^f1[+CSf]8#>Id\P:6>L2SWB8aZ,B4]K.]JA8SbaCL;-9E9S;F#GS,:B>T+X:
5]Q./UVF-a537eEKSC^45VR;XN:,9FYNBU.aB)Y&#)T6Q1aCF::^3^4:.SI.QA=K
KaA08#B;QO(-5T1Bd8&/<eMd3D#0\5+NGR[&<cc.//=T;99;/b_8BO(JSGg0O2TJ
DW.-4aa\G99gG#eFA(D7EO79D8(T&/_<5c18^K-U>.eS02)DHU6R]0:N8cB-2gO<
;W#P78>>+4V7-_&VfW9d^b]QSDS_,/6.We+4R;,.ZA:V/W81D^,c)\2]5LLCS5.f
5I/C.(Z._>C_0GPI:EZN34R-Ug[_&:U:YXFCe:>&CGdTX,LaGM_C@Q_1YB5cD+CJ
&8W&9INKP-_9UA:58+?EEcP:0A=EI2#=;4J].=&H2:SOFb)f:S6eTI8[U6[ReYA,
@6S[D,>8)N03Z?):T:?<IV(MQUHHcKJ>cM#J/T)]-7,.KPOSXJa8&)+MdZQW0(_7
<796RS>CMX2^]bYZ<;?\3MAA]ORY5.DJR&Q5P=N:01V4J1EXNBI(D@-J;_PO:Q8Y
gHEF_[&\?]T(JE?(QHf.bS2BgLKGPA7_G_cBY_I0+X&L&EBTLD-AKV=FDT&8d@6=
L;^-B@7SbNZ[6#6Fc(\W1Q8=./CJ[9X6MH:bI9c__f^YC>(E>D]Y3/S7THf^JE=+
C<;[S5[;LXVON:[,ZXXcLTF.<:PP(YC\W)PYL(<g24S&0HaN7QGHW>NR9LVZD]d_
fX0(1WV7W][79EZ2(=]X9^.?)H:4b_]cJ)XTM?XSd&R3/efCY4GTaFeEM=3=K?^Z
Q_X0(Sa:HFBF;B91.ZB;SNFC6LC>R2>U;.e))acGf64C@G]S-aV_F/<L6@gQfbB_
70U5&e/17WPcAO,QZG/,VXN5PH7.F^c-Y#1f]H#EQ<f87=4dK=,_L9AE7XLcc@RP
<;Y?a/SA(3;9#bHfVC^,7^g9cW&5d2O<D?M8EXgceN^e:_#Q4bWHaZ#;<G2@T&K>
_BU/1,8e_?IH3)3-Ue.>LKPQ/E^90VbZ-F532a#,M>ReFXNRY)<2X]b9JK)\e&dV
B[[aP5:G?dT:a5c)gD(3OGEC6#,d+X\5<N,6e]Zd[^H,MSF2HVUf(2/+16e?W;[V
5QR_>?cbWS_45L&Q/TR,+DL?EAeHS@d>8VM)]<382e@d(EH\EUDH]W+?a-bKIfM4
45>QGg4\0-J4g)(@ZddC#;,eXEE>)H2/HX&WF1cGB5W101A,Y7OWWDd0V)+E&<;E
ZMUA\(9H/>]S.8W(G=?ZZFD6;OHF@C5O=JOFeK&@Ma<3DG>,aDVc:6f:4U.SV>\H
+A,W544:#gNf);54PI+gD,LN#>61/C:<]/#b&T(_54/.c3e)g(_UPB+)(G>WU8_D
B0E/VAZ2&8@[5Pe63ZA5#J3ZZ5Z.7LN[GM_@bAW;Q&;IV=NK^F].ILKBB7#P9[JR
[B79cSNRG?SA:T3f(V;]ORHXP;P.PR1.4_>=gIVQ1/E9@JWK1X)I1]LIMH\M(&])
MCD8bC5b/-]d0>@g19T,JD)7QT74.f6Q0B(OgJ-:J0H6D.Q27/BKG6NQUQJN5A\4
6/=^51E\?M+)(Z1-5XTc>Y]#\D_\g(4L@EU,O8)\NdXU+4-aB7_WG73CM,?PMAXe
bY#EWKG&N])1AS+e1_E<-AJD(g_eME<Y,4[/+.<I5\C)g7-b-.LP<I)USN(:[D^9
S,1_119gVX>B>@UT2aQgV>QU5:a8FeF<N.^4L(&RgP,^O>?UKFQ\b]JUPK2U(9=6
46eUAeQ6f\[K^>FZcCF72+NMgQIHR\GTO2D<7FGWS591K=.f8#.C:03ZJ/(AYgM:
-HW6J2LO#[e1?c.9Y)TSY5TP]J1a70(VU#-.bPW3/[DM@PTCbP?4eT.0P7>+E3@#
e09Y9U7HG0e2CPRM;.4XE)Z[bf)f,UT-5W>UELK2IX1)<(LVGdS#F0-PaccAL_Q_
(&5-)C8T_A-@:S7+AF#gGc.a2@g&<>)cd?G[1+GI_:+PcdPBB@L<11Ec])RIBW&M
T.FJKBNd<=)c<X&+f@<[YC&1dPfJH;?HFXESCW.[O^3O#A4)&@6:c>932D1aD1##
@,=WC[ZB2;MEa>ZJg&/F^0IdF#],NSd>_S2N+LNR>UE/DF/??aB#@K.Rd;g(9@=3
80Rf=77S08@=[AFbX[;,JIP<,R[H.H&=/RA/HVIVNQ5FHT9-e]C#aL4aHf[GX[XU
<@e;MG00Z1c,RW09VgA2Ld]1[fe=PW&A4D7RcK.8JOTY9V4JLc6)K&<&=eP<[1@U
>IKZe;973Z[FW5F?/E73J=,HJ,P_Z\J-E_\6F#/X>^_b(F8Qc)L_,2R-R@PaWb=g
N9+O9PZ4aPeZbb,JU8GOg:F?\H<:U8ZC(7ZU5G^_>)4-:3F3S>eUKO<GRXb7FPZE
M1O:6VG;BcY:,ZV.1?_\cLA7-GMB0@_cb/UY/#c+X<[fBEF2F7&/QK^MCRd5YOG7
de;WH<?(\+82PaRRB>/:e8L9995<@WHBBI-/e,-3K4-QcE&BL9-N04:f5a^W7G@e
T4e8D)7V@+=dd[H4e:GL@SRa+VNbLV4WH&@gS[L5U#)Q@NS4:E#cf);3R&X&V58:
I(ER98T-OKR5TA4K(D.O8dX1SIadP4eYJ#F;-RT8gfK(TC#JCD6@gJfO/aHZ(WNY
WBcDEG=A1/4Ifb0_:I,(I0_-f@g\#H\c9<RRGbPFIX[F4.XCXQ:fY.US[Z1/Z86&
6N-U&E9<5NdGIE_[U?VR?/]&^JL>-B_^I@#(@RAV^SF]&^JFF<6IC0A(QMd=VRB/
JEdP,-.\9S<gZ]4_8UFAc^2N,[g1V?M#gSTEY++I:X,OYOB<D-5,3,G9b=-)&K[6
-VM]3L==1e-RaQOR1D4^D(V2#c<_2=Q8G,;X<DQcWMN#&/F2aQ7\QZ[aM.+G<g<R
H3)4[Ze59d8B==]S5C8<Ec4&SGR?We6b&J-+A>?9#EVQgbZd#:Z;ZeGbaP);I;.a
4=X,5(d0.048_CI0BZI\T.N1W=f@H[KB[BgKR4C6&3_]P_9@/c/=[L=@+O-JI/Dc
SR2e>;:Rg=<RE(cP=P0VTPf/,:NIL6UV9I65gY:Dd5aJcE5U>FKdEB#e2d5KBbdA
e+4(5BAULZP.,@B@5Y69Rg4,A:209eQeG29LNYP<6,4XIdG:Z9O;R4MS)7Xe]@XK
-/PJM(cfCc^1N9.Wf.^0b<HbD5LE247;Vdf8@7?3\V\J^5<B8F__He<eKJ)g/U:G
C\aT6\WEBX88^4C,(68?Ic6c_#e::?:Z#\\=1K0GB-43.ZTJC6T+5C_Od/B<3^e@
9A,,ZWA+LaJf25#M>=P>1AEF3R<Q?NFW_Z,)a[OCKA\LHQ39=JZZ/DW:>P-:8?;[
Lcb4S]SY#dBdcVYX1F\R7H3FOCaf>J(VHEU^+[^I:OZgHB1g:>YSFUH2?,eWWVPB
Wa-AdgFagfb<FFTPbg9=86BcJ<aIP8YIZA.M_ZO7G.dM#KQ3X9MTf.T<fcMK9U.^
OZ[:BN&^R<0>IFAM0gKLBcRUR6&U@62#L(_Of+Vc9C_&S7):O=;bP8&T,WZXE/a<
+eVHY?\WO=3.HH^JL-FQbMfO):#.YAU_1fbQST)^aff18^UH/A?UF^2HH3R]7-O.
K8deLe_^JM]GG#1\CgT:VXND[gb4DH>7b_#R&g(7<,8D(M?2ZPIVUgS>BCNAH+@?
1(gS?FH.A#/]]FUP.g@+&Y58f:22-E&\0cf#L9ZC4@:G-_+G9.VG3/_JKD@1W3c-
)UTKH+cK>SCD]YT:#UA2MCQ-JE<F[7QV.]K##2Wd,&fRQM/R@4VUWJI#D9710]BE
g21d@J4c4c,/aNP+3LF()e2#K8MbJ=HLY+R[&e<S=VT3FB6,E?EDXEeGa98^(IZI
]0CI@W?K-I&AA.&bTA&DD9MeE3S_&QXZ=90CP\?7L\KbUF5?V>#=UNG@_OG\;@OB
E_FNb3=UXI2<D4M582HB2d&@HATK8-)S(=SZcBM_R1c31fSL.KV-4aH4]Q7+aW[J
g#D)5^K:O5.B3[PJ;&>1e^;X&5DCTRE1T]EgAaH1X2.3dW5UUF\F<g;@L_:e\8Y&
AR.XJ7\9eKQ@13M;B@>?605bPUc&-Z(T-63<cSX=&D)PJOVEKP>J4bDNafHJa^H[
DUF_9S-111E.-L,GFb82>cHWG&1,WY2X@0DgUSc)]AEZQ;8()KU__>90FSgMC[b_
HS,V5,X1I-6KB_FM=+[H2KEEK);9==V#)ag1G-&b3b+)RA,/^)^;bF.Vd1,Pc@1+
^[\8QaB5K=P;[.PMVN;(O,C\;KYJCO?+Mb&64?XXIbfdX[+eZEYEY]/Ob0gd&;TT
GcQHC+WL,1?5R7:\I5GeF.PH9\a<gg(A#^,;dDLXXc^Y&b&L,-.(cfY.+Z98C2_=
Ld;&B4]N>4R_?K.CFCc6dUMW&T2ER,(XSTEPWE8M\IW(Nb<+KI4K+)GE>+cg.J-\
_.DE&&G2:5A(4B,[/SYUZ:\Zb@G;cM,@8W.IJ\8<[;/&I^3O>D,BB9U:]eO3^S&-
dA+P;XL>#.f;b(JA8=^WdD/T&IE?8W#b:T/RNUbEW86.fAXFJM<&c@1PaZHOH_E>
#f7c-[OUeN[=V2AY=-D>@G]/+R=Hc7I)[_6I(+@=V&T7T0TNBG/1PBUY[EY(25ba
R_^WK&PdbJ^A=7=\RH7&5Gb(VDC9AFe\,2TM8VA]Ae\2-6SgU:>a#_IS-X2,-9(A
>]T7TfFIc=#V.UKLY2-2/V=g\R[XIB?14F4.&(9:D7F3TcOb?D&fRQ=I6__X.-g/
?J/TYKU#dffWHSYBNNd,)##>^Q^c&_Y?1#,_?-9X>EE-,URCQL;);&[2H?51g=:<
Fd,#aH]dUL5:cXKc:LcES\=ZcWJD-2\M;NL;=>V8)^B\_L?:Z+KPHD^dG3-F:]JS
W>VXYFW-2Bd#LHf,NT5KWWU;C4BCEcN0VR(0__JN\,d0HeF[6V1=0?X0]MU\&?+S
>02=_#/YL[GW9IDD59@_OZQA9_c.AO+F[;S);#.>M\&\N<\->PZI3a@M3TL-WY(<
W(XZD2.cL#V5O)R?633Q-6948/Xb_^)&bP^>9L.NJ^Y/#6EQK98IFY\WDagRgYO.
[Eb-/(NQWPTf9=GR&f_10J5K[D#\^>CZ-fLH+DB8^.U]@E_F0O7/)OVYIgQS1@g&
0UU8@5O;c<\T7,MZgcM-#W+GHgYD?)QD8:)-^832N.OfI,6OWF#FFI\RWU3/C<5#
B@(=+caEcE2H8)F<^B]<@\:GXC38MAF8/;<.^Q=;\VEDPPF(UZVIL5&0ZMX5BcEZ
0f.dPOaX62H_V.4_a-DTN8A=YD0W,P\IQ@#&-gdf^=Y&WZD30RX]\<N-;4F#>.0G
U;J/V/UT--[W4&H<71aSJdNa,V>SH^HN7_D]c@4ZG_8QTB]eR^,Y9ZE?/;KE56N?
W]_/9JfK_IH)eS_@6)]L[d:WC(TE@HC6fX1VT2a>eRW)YWegJEFD[IXg,3?FHH9[
edUPX12#FO<8B&0KI]WY;AbQF9P#ILN^?U^L-#eBX@@B@NHGgV_REb/^KQF(SR3E
b,a?b@2;8JTWI39TF+/0ROUM@_>g]H=BI#6(d]Q0[eIAKJ(fg<0g:-H-,Cd9H8N^
0-S2&7HW<M.[;E1[#YF.+\&7V+P_Y2PA<DT#QT0(.CUR_F#&MD0O[Tc#&+8UYZ6H
OL=0XXO@G5+8\A+ZQ2S1dP#e(M8W>=b3-Pc0GHYNYbZNVI806J-ZNAYL7?VA&>@-
-]N<:;W2d0O>H/+BT2&94UHK7d<8b;Cag)5I[UW.IW&+&<J7+6Lg/1;VU83-RZQP
L5b=#_5[R@?]dCIZA2Lb)C6DS2;L1BeB@[^gB+K4]POA2CW.RXF\\5\&aCC1VW67
RaX^f#_PIV[L/>\II.+@R3]FY>3OK,3)9)g),15;(C3X4JCaBB+M3OQ[N&VEIPAR
[B?.J/1I=ZAeSc?;&7LY<T>S<Z\TPY.,=CV9Ae-b#2=+=9>O6fKHb1X7d[7C=UC+
V.(V&gg1&;M.Jf-M-ZIaC8\)6fB7G7DE56^GJFK#T[V]?L1_L-U^Pb>A7)IWbd)F
1OYV,c9c7PP0OV9G[VcGbKg0+=f>3ZeFV2M.3d+.EJ[3JMO](aa]^ad-JX]BF(g8
G[[PE8C0O9CEY8.7[JaVKX6QWE5/E#DTWQ__M<7##)4&(Ab?P7YTN?;&L9+QTa(>
9LC-/E\e6gNLaTf]?HY]V>;&IO.>JBL\cU3V8Z+01&_C[MdBYVJ-_CTf5XWA:^[4
P68dg3;(;c8)2\.M9IT/LfX&N\K6UNg8MPb:&?WK+T)\BE/3ADLE+S)O(:6ZdO6&
.^L/#JM[KEJ+B#4SR+C7[Y#;@\I++U0=?\(97,._S,_)PF./B);L>fF5^faP&S9J
4K@L=d>09\9+Mf>a-9Ba?Y,d#M@6cBVW=5AI,25,WMP#_Y8NDY2O+K>E[&0V;L\/
;J#(L@#gQ)(e=/QYR^)P:Z<1S.3_&?9NYA6S^<T99Pa41?)^V0g,(aV\KZDG@5C#
A)f@dE]]b5(>0;&U[YF1@Q(2Oeg6^5;_G_2R0@5d+CI>PI9Y:\)EU9KN&0[M_;KB
S2]C0DTg<^HW0+C3[TS>(<Jg8]M9W+4D2P(YH?\6@]eYGPE.Mf^)SB=3_EZ5H#fT
QaI=f7<JK3;9Z^&@Y8<>?/@^HTMKZ@@+)PFD29_VA:VF=[D3I[:>[9P\7S7=C:U;
\]D4B9M?^-SHeL@==fP.J.\7Mb2b&GV,cAQU&S.>QM,U.?g>PD_FPQ;]3@03:9&M
ef5Fd2#C3=.N-&+8?O4g\<8D8+Z5.HMUVIK;?)</183C4J8TY??ON&C:bJaU?(OI
0I##g/@GL5P7E(eI_#Wa4a6b^Q,?PO.e_-<RQDUHV&]+.BZQAK>X#NNfPLVUSRQ9
AVc63WO:a7_3:#+23/62@8Rc4S+:c1,LL,)02U8dCI3A_#HY982\WcYJF=4MT5bM
/QL9UVN^R[<ZP2P+IW(01W\@Z>4RXQXIa;&YRa?ZN-1f2XPdTc)bC3FAFY_E93#a
?:?X[FZ[[9Sd<0:S(gP7P^DXP/6BKB;aT@;FS+_)&+H]9Q2YE:+I/[)a^AMN2+;T
]P3TU3=T&54,f05U<IB1G1<^,AZ<R:V&)Tf;GN-=AN6DVMBE?+6;3RWT+6=+7ERS
e.()+U1RE7G>H9/90g+M2BU^G[&L9:N<9XZB(AdD;e\=YVD(4a,Y0/CZ/C2T\./=
-d=W0?LZB=.:=9a6PU][_VZ6f/V]GH,/:f_FTG2O9Ye172ZJH[LgW[LMV\,Tb4f;
2CP^>)+\Qf#F\]fI+V]O#cI[a,a^ZgXU@=ge]fdFB4]#WPa--_09>FL)[A0KKQV?
SQD05UOd2.2)[^8,)V1EdO\VYP?J^)7;-&.V?Ccg^1^^T0gC52W50cUEQ1A]]g4A
=>M=#?C-2eU;EV[EF9](E9TO14+-)DL0RB\d;L;A+_V^3?fON_LV)A:_9S)>fYD\
Ne([f?:5P>AZ3\\Hd](Ve..L>^6XIVFEKTg)a^1d_Bg3D(4TeKXY,aGH4E^MFcCY
K.)eb-fKR,?3PBKTeO73U>b1E.I34./Q6@E&#Q/M:\TL<.+V0>9)J^8M<LK886,E
cA)g[&DZa8dg_]L>>7[.M\cZ852<DK:FK8QF(04(Ya0_;.=NTAJKV/QPWd_9#]JU
I\SC)\FU4dMEMMeS<6@6PQVV4H)^C[KD=.c,CE<eZ(c>LBGbBF=V[E;>Of:<5bW-
3#^?_b54Y&JB^.=_gS3\1NIMf[[Y&GNf71dP>06[Ab=LMYG.?DL;S+\HANf8Y0P+
OaDO2&>-T-APV)dg03G.^G<.fGX2_NCW(C40A8:H?-A1/^(:c#JY7/W1<[g5a9/b
0c(3NG6Zb:D88?4]LP_IE@P@-X2#86.<9K)<CcbJ5D.W1-2J^Y0b[/[;@Gb=Y\A3
d[ee<&Aa\JB@g_AG;D0#1^d2P[#TU\4VUC++S,806/];.OIGf/-I)0GGTfMg5;SA
W<7&+f/b+BeAaOFFE+#ROI1e#8TF#cAbXJPdI2QX>fc\]LETD0GCRRA2_a_0Qf;1
>2L+UR.<)<L1L-Mg@\5XdQC]LBg54HJE639S[WL@F-@8b7]LW(E9+,]e^3>e;VCB
_5DDFc;O;T;@10XIKQM[[,AJ@@6KUV5&XO+9W&UaP+c-]&Fc@/eR0cSF+MJ>@=)H
N<aWXdG/AR4eH<#WB+ZR5):M@=)Y@1+DOEJ3/-d^L9.O:=XIM^1JL\TGfVF@.fJ&
=#&GQbf#5M;2>eM3Y?Ee/1&XeA?49CO:=?#UTSP4Ta]b?H<#IN4@F>J\7:-3,@(E
9.(CF+K0V&e&d&G>4X3Q1390>K1P__FQ&_Y22AXR:/]-T]?-eA=dAL8_Q[6\F9BF
F_+8&BDPPMWMK;f@1Ua9dTR/W8IJ):cccC=27B2M,4<G7+4C)O8)<f17[L=1XO[R
WDO:+Ca7=-bd35Cb&).FI@;U.&EFV=gBF@gBgNFa>8(L/+gB3DbOADW^[^0WYI/5
6.DYS-EYK50(0[#U<1DO[eS7]^>7:HPa(CZ[aW1<;5f+eeEf0e)&\=PBHURa&(ga
YJL-IO_H(R9VgIV?U&U/&8V&+B4+)SYf5g+@\#BCQ(A=BYR?eXM:6G=5/_C<O,-H
_C/>.A^O3G@]]JLGea,YMRX\3JLWgC?f5Y7>Y(:2<J?)T6<YZb\\EId6Q7[?e?S.
W>JJE-4B__2c(71>1N1>+TLV5L)/A-VMYM8XFW]b6&QG3WGW]f9cE8WM=9TJN[/<
X\Za&)4G5.TK&aP)9.]?Z4]db@3MeBBA[5(Y7EN^/SbT_?ID:13YCN#8UA0ZQ\e:
N[-eTV/_d2-b5.M8D]W0B7W229KVB<:f08/45Zd4C,G[XX]K;c.CTe4=F_c&+]Ag
1BcAL6.X-0g=J-&L-]LHK[N5XCJO2W8;052Jb80+87A;d/Y02<_RX^YC+4GRHf8Y
O[)+e82H+fT;BHZXHQJ)/IgY2^L?PQF?&@3QF/,M#KEaMEHNgfG;[+_M.J4=B\JT
F?H,W,P@IDQWBM4bYCAf/=/D7XC_U&ceA=&_873c]SD/@>M56X5N&2(]&CeR5)KZ
feOKOe8=?V1DcZ-dE)IB=L,(F+55\+8A[<[Z@UVa4)>V/5WeF7=V)]10-W7I0E#(
_f\?;Pa#e?gAg0=S-[+KZAC1S@V/Zg>#&3=A^COA]6;XKX43=?d)/L4ZUc]W3#>[
<N6-5P9@[M[-DLM8WG@Xf^g-+Bdd:HaP=L;g<FYMFK#<CR&2H6((UbUD:./a?=G[
X,TA/EMITYB.cC+&)2L3Q4d.97..#(=)88<_b9KcQ6L(=:NBdU_fGMc)CVaUYW1X
12O=1(c>0_B8IOGPMZ9L=bS3f_MEY85.--KOXWSKXB=GR\d9a]eCfRH2XQKaQ3Z>
UTWdd[L/MR2<LG43A8(GCS8#>2M/7T)>B:DH<-XD9C^:[a>?1fLH&_7D.-<Vg9:V
:gESHaRgB[TeMDP@NeZSa/&),;@R/g&(+Z6F5@Va5XE\H6,:fS;/<YLKIK;L[[L1
Q>W\BC[0BY8V.[6U/MeR;dANGg&=ME(6d?.T:#[e3<G@Y7&TEW?gPaD.YQeZC:bX
Se0^E8[\D_(\>&/>I+PCfdY4&=dT;M5YM@49I;f^[],NLPb3OF3\D67RbN]d,#O^
7X=9+e&0b_;U(=JBgE(Q8T.CO<)+_J/E)UPY\(DSHe(.04]P>(V->9+I(35OYSQC
<0I95G6QaF;/;\(ID3Q.U#5G]8@Y;^dQY.>WZI\<<P3;cc-3IbWNAaCV25>[bY>F
?Z4gZLVI\(BGG?M0/_XJGebN=UA[C@]D(FYUTc4NY8#cM=eM7O#@&3f+?;93aMS+
P;2;?3?+))I7ce7e2V[\G-O#egOITY#:LO<,UI=+:7GQMSW/,T[TOCYgccA,VNA3
Oe/fV)4dNXI<QR)T57:21Ae6T+J=Q<_1^@e5bRVK/<P]#,@_NRH)@LX:2N#U1@O\
XJ#TD\c+8U:MB.?P5SGVG3-Tg,EDE/RFC2<J>@CB8U@_KZQ+4b6E=THSN4=BMfVY
<=V15@88S-U4260fS)\>#BU\,D<U.V^7HU#)7:DGga];)YA9e2e5g^e<);]J5/+J
_FBd?;Y0GNIYN@VJgX870K=_MSP@LPWK/0#@S]0IX)01\5CbHDVVHJ]C(Cb[<L6M
fBG3fX5ZTH4(g;C7.)(A<IR(\UD.I@@)LB=?8_^#9a[DRA&B8:5LO[(O>RS)b3_\
cYR64BC^X:FVXJN_c(YP72ZCgDQ_\5.E5,WZ#I<&R1QUA+S55_;.eO=.aQOb#]FF
.SbW5L\]A.CEIG.1Y0G16=RIB&40H;/PdMEKJIFF:2]ggW=-C&&a/ae6dB8E_,K3
XW3e_=P/;]70g1c@P21(da@KFbJ[(A;9Z0MGC,ZGK6aBX<NOJA=-@@JOMbCPQ;Nf
3c4U\G&?3/X-:4V=+CZg=aE,aRJ?XZbFKKR@.GaEC&.6IOC@WK<Z5)XAQg2,_[00
710-_7Q+Q:?=+&d9<d9f]TPMG/KgXV4;W@B3FS]TIKad1>M5#J5]X@(<aFQ<[,@Y
fVX.R<MQ-@@+F;5bG\C,<B7@SI22aN=Q9AgX6WY?N/06+a?T:0J7_;Z30.1E<Z+&
(/H[Nf-,ZDaV=MfQ#[a-IK^4e9.0[>:fgZEc.3SGDS3-,Vb6/>_SI^&&1HB,GQ@c
a3UY1B<Qaec^W1_>_1C5eDYXbOfRg[PXW,5#aKO/VfEgBY#TUMcb(]1;gf#5W1HK
PHURY&C]b^+92TTbE::CUKGbC=/Z/264U<>P\2[8)D3[f81Q(0?)]V;1/:=)RP^(
V]N4/3H?UJ\X=\[f/)#8^C2TZE_23@/T6EYTB923dQ&3&J[?9O.e5b7c9cV79LU7
e.U6V8?VgE?0L=K?Z+3469@R)9KA#P\44=cHf3P;CH.4\,@42L5#PXS#WM<R(^-e
8b3Uf)\G1Gb3O&]1]MR4^eO(\g5L(=1&EE7[&(DQG\c()N;_;bgS+8TVUWJD<BDU
N-aL]daP-1.gX&U=Q;HIc/](FO#IVdU&ID><Y;?eR]]C8\#TJg5(E9b=K:fR:D6f
1/RUb&AaE37SVSI?VJ]BHG)=&/#W-DHGT;L:=R)>?bX9d.#OW>8.HA087]<+RIB5
4KD;@G6D57TOFG7#(fLQQ:I:&&e5P#;b@[a0LHIE548QZBF.JS2HR0+<;SN7:Z=A
:Mc)gC;U&V7X-+Se3:52Sf2EDS0G<=+1D2N).-a8e#45b^gF7>Ia)TeT:L1=]S/E
=@X?[eK#Q:X.<ZFN=7Ke21SfJ5FJ3MJ-;,L/\:ac7U[KeMGJ+&bU3^5CC\12+HTM
?@+9WcSU?>4<5G<H0^2<>:)L_,UZW<Ya6gZSF2M.X75Y=^TA_95F4&a59AD8H)UA
;TVH.VXf^7gRceSf-c0)OBd]FLSIc#A50ILD8JbFIV1M>dKPXe&Y1ZC7Q=RA-2B9
X3\adWa?f#=>^^+Jb6dJ[/9&Y:2dEdVE3aRN<8da/gPWR(DCf@T+=WGPgUaS7=.1
S6IJbP<0N4DZgL.V8a^gUIJJ?F_UU7D5)GVbVQD6..E69a17Cg1Td&#4TXN2gdaQ
@b@6G_VUb6R4Y,,B@+#6@WNd,=ZScgUgA4D1Aa4N[cJ8:@a=MI.-B^F]d,^KdLK=
27Y9=P;U-af]d0Rc<1BS?d/5?e]d>(d?@<@IZ#Q#P.AQ?O8/>56bAS@JP4=N)OLF
)aN[d05BQ:d2)RHd@T_5F]ZU1L-E9HG<^:)>FJNW]aK^SBBXeC:Zf)C6P.^#:VFC
-b?X=:7BBd3<501JKLN8H,:9O4JeeL4=E.&QFVHBHD+.B0+;Bccb>g]8bS\J.5d&
@[_8]L^CV9Jd?/NT_\^dB+e<b[9Hc9^aOd\P,>Z)G<SYDf7S[>B=0V\M]cGPPT4a
G2L&_Ic1K;5-.<2EFCCC\E\75YTBOJ)/HTOe2CHJ<K8?C4(c7@T/NAIf,Id&,5+S
P8Z:JL0BgcQ3:+C_K/O<5CV:H4Y^7I=gSBgUG3-B:A.#FPC99dZgd^3-L6[SeLVR
2DL4F5F3)JC7AO)eTCeKYL>CR_IX7HS=IV=Qe:-8@fZOPVf[Y5;9Hb7:L1:E]d:-
YK/C1^dE8dQg>NAf04\2KP)IU=e;f^^b=(gB^-E)^]6-c;./F?1QfQgNRT70GY\4
ZZ/6\EM<SLY>]F&d[MJQSSdHU<386Y@3C4T>3B^+E=^]^,f4[eLO5\8-^F)6ZeBH
K.cfYRbLJG5J/+.[6.J]2Nd]2BNSJ<(2&9Q0aZVH+5,a.eE2P^TB=XcG7C2Gg,I#
7P2&3;L507G-==ebRS1P3a1GP?g/^.U0gV7caX#3^:KUQER/f^#2H\N?G)e5F->B
ZXdcRD?<=Qg9aFCSP\.cdNH2Qg1?C)+>Q\-\9c\&N\VUK)C5.MH3L;#(dK)Q+8>(
>&R,\P39SGXE?M[KP&,H<CX.bDK&Vc&&WeOg@_\XURMH3F>T#b5LU1VEfbeWbgOM
HO=T-X+4Kc@N/46G5SRP4D#_PRd9WYVMV;5-c,c+>D?I23aFH8[e:D-\gQD_bBBb
G>9>)gBM)^d?Q5KdA3MIAfg--(?G6=/P2BYd<-8Z6OF<cOED@bZ0\4UF,d,P#2b4
67J?40gPL0M0AW5N=K4S28AW,ZYT6SRMTY6fSP.@&JCDJ+cZ,GTD?F66H<#=c[5/
;7/TX.O8-X0F2_R\AR8a(a4/[^904UE[I]M#<\PfY>2QIS&0G_U._56D@T9VE,WU
f;2Rf=0XJ0&?PZ#:gFbJ/)_E=4@R;ETH5FO)fLAA1A3S:9ZG3U+>&YA1b,J<H.D[
Kd+BHLa_[BObBJcFIS6D1(&f[)a7VO.E9+0E,ff2eETVZ1ECZK-#QC3F8=KJ9@C<
0fHSO)QPXZ&,O=5<1fTaV/#ZB>6,#>g7DJEBF^3@cC1\ITa8-g/2,BX.1DA+ZDg7
<5@PH[P@KOWNN9#HL]deQc+(E+6B[XZ(#[I6gI]#gG)D0V[;(Zf70):+)H_DHY1a
Y,Y8M-=;1J0C4KU&[?-_=6O>b0BC?Cd]U++?W_B(#g(/J4\8:+DV[IDIG<baV8f:
YMfAT^;cN3?/VD34.=ffR4VHRRA[fSYXHQ@\UYGI?eB:;g?3)a4=^QVW3faCZ_,U
O[1ZNgAGA_bd;T/GLA,?SFTg8/]gDRSRO;_UK1CAPCA58S@Z+f2aRSK;A][Jc:XF
Nfg9U+5.AZ0:[G2Z[+B>_\NB;]Tf<=+177://(UfFF/8e@Ea2/JO-MUV?gL2<b_c
QNfX[CKH3:(@@K)TQAa39;/_gS4,_7\(G2@N#<M@ZfRcL+2MA;)_TK0?RId@IXTG
75HZP?F:&Lfg#_:B:M1EB9Hdda/]0S\b^_ed8X(=?A,RQR//HA,f35<bS6L-PM-F
/?R=M5W9-IcIf92H(C-b(P?)#)\d<5LIGUFHA(NNYWAQ3#922)&8.G\>8b]\B#]+
g5Q(WYOA&P7D-T]W?aaU-=BHZSEXed=6(^Xg0GVS]J]4Ye/@LTMg3(]EC_d/>(XR
c:^):PAa_4GPYGHU4U>YPO.W34KbfW9=b^A;4PF8M-P@+VA>&P7:V:I:USV.8fOQ
.R7>^GL1X7]=&=#f9T_e_TV_\K(YB\/Q(2JL+??BGFMUA,).J7V[\Z?+ZXI\ZUae
dVL;[V[Q?,?>)\FNa7=,]5L4M)AJ?@2f+]ec]J886AQ/M/XL8C(5=-6IUWXY.Jf.
<UNES8RFQ6WE_0_QfO.P5:JW#W>0gPEW9aXXJG_B\8&fUN.d[g0bF(GBf(#fD&>3
TWKS9fCd9386S@6[E(,6O4<4E\7L.,)(+)V2A,<L3S>R_fRQQ<G<8TTb3-cc2@#Z
8QVSJV3_)((f:WgeV7?ga.H,HCS_>,;=c(-R9-;^6,TgS_fG<,_P9eWL.3+HGJ4f
Y2A>:<NeYJ<UEJ2YCQ(+aEXcc&>)\CH38LWC8He;^YQ#I9=bD4(=c[BJ:U4OCb>A
HUG:f^1UeM?/.S)2]BXX(NEU6&2EYVFF//W.+EA.]:NfWd4INT0IM3/.14,:H(S5
8=D0:eBaIeMf(U5B,73,K3CeLPPA2C<\K-He;4PW=Pf1ScN1EIA]98B/.O92SZfR
,;=DAKgRYCN=V>DI[NOV_J=T]eYVBN+=D;[;<6TV_(E+8KUH\cAYZ[^^68D[Z,bF
E+JG)[&.(H=5<MN)^E-A>C9WHG:g61^:@[R->O#GLa^?PJ_?a?Lf>M.(aIY6QMY.
ZQW,>LL#4+H:T36cX4EgNGWHRJJ7V5A(Z6gEaWJ34Y0S>,[(VN#Y<3g\eFaa/6fg
U.L+^(+6U8:A@MF3A@c98A6a6T9X?8-V/;S7\db)]G6+6&e^XX&e@=XNG@Ig<ARO
L7.Q\^R/aO/TNg/;XC4G1_8,4TG&&U8UU44:_ZY=g&2;)^XJB9:7,S_L;]E;b2SX
80e\1&H@X[I^L46]CXS?K5EOV2_SU+B/OPSbBZ7BDX^,P6ba6K6bK?OI?Rb@5Q?R
\egNTEfJFQ^D]4VQE&W/1M=P,=S:@U=@VabN)\\XT?JCaC)_<6fFbZQ#AN9)DEI^
\+XAYd2KD\N?,V?LZ7Q2PH16JIR,)d<2&LF/:[VU9LgeI/FAMUGDT/fVb8LQg<<6
+]P+GeJ8(32D7cS0J9+T[EMZ+\V]JT6-#=ONP[5>>g(4M-^0926U6&/)H2Ff>5C.
,7EL[7I)OG4OdeK[I9cbe\/89]IZ4P9Vb8WG/Cd6PD7W(8fS.f&BHYa/\>31.2C6
#/G:Og(DF3H>5CA1bf(bD,YHPb-?WGIDfRFO9<-;O[@8.CE8d2-;3T[+PYIVXPQ.
W4g#b<g(.05:eW1MX.7_SA>JMBJ(Y4O=L[RZ?)WFfX9D3g@@+Q9[RG?#=H4ENJ?d
Q=R)X2;)A4K:2eBL,A5:[;K9[H+aeeJ8KP>LI5B.gM.>dWc[bK>(bCb?fYC01eSE
a03CU>9DCB+4,_9J@=PXCGW,2<@[N1N^RNFXU2/_LZUTTgO5)e>35N\@e(.Le:8<
69AGb;Z7GAc@V\J&P1FO:S/D&eJF<RKaQ^34S+H_bW4bA23b/Me?e/67/(3YHWf=
7Ja4Kd,2e3@R6CT:V>+3db@J-aNO?/TAZaM_L#IR)d3LT5N.dO<8IO9_Ie1:V1\S
::B.55VKBHfb^,<cDE7-)AWH@[,9N(BW\/PE/A<ON)POPH:N._9eDWZAW+8[6d+;
4(B3(S5]c>[VZbfO9OKBV3J4SSg-bL6T&\DPA&0F&-?M^\N]5Y<fM(g2GT,H1O>1
Oc\A(d]<3AcN(b[@=3^7XSR.OFa[\I39&:PB^UVeYCCFEb:;e7==6A4cX)d\5P[P
0+_#S,SJ4EcR?OBaA-]=?H/1[M9[#_;g:05)K>f(c3V)CfYf6cTWaNOSKd\Ee.32
/:B66?FUVV&a38(YK]Qg20BMf#3:IF-A(?^4e6DMgAY+1I8:^[JfA:R)3QVS#&.a
;LcN#@VX)@;bZC(I&T.^BV4g).11W.KMcT,2&:]@/REHJJLC,NH@_9TX_c0S;L;O
bCI0SD\GKB>IT7OMEPB3dC9gLL.&9UBBFV/g\egAZ/ZHI)IZ#Z)+-DJdMKc<P)E1
781\_N6_aa@:3b5V6b^>HWOgXD?d0SIJ-B:61baD)><ZAa/4Z+2[7C\C3#L?5&c0
LW>FDXa:(>L@6D3ZS359fFPY6,I^5?#dBBPEcg.47KecT6C9\4K?-:9T8(SU+YJ^
\=V9WC,E&ec<ZJRBFf@0L486WNBV/J?W+4=2NV>3?J@EBB<TbP>e8@82(YQbY>S?
DU=f7X^DZ)IFLQ3(/34<HRSI)9>[)QVQ^J#Ld@@?fR[;V&RX<&200_;F-VIGX\P\
dYDR9Yf85TA-JVBTV7.03WE88NVESH[X5J2=BO,OENV,U?LGV+:CJg9?TICX;dE9
bKV&[DbMHc9<I,bN]2R6#L[[1D9I0L(b5V=4813ZY/X<MdG_e4Vd#<9>+;J6PY0.
>QUYKI,aWC#TTBZY0B,E/2O1QD7MHE]A>WDGH#8ZF&F,CO[OT7[Kb2N4_H-,(Kb-
U_WQP/746EN7:,GU(<g2.7\4ZPX&/L@5-f:W;7MS-5+g2U=[Y(,<5K)[[G[@=?;F
>I#-Hd.RYL8O>Rc7(<7>a#G\N,FCc[1WQ>_PTTZXN>c:<)NK[=035#,-3C5_A(3D
/E&V2E,N2U]BV&g2bIAge##F[/c<7<MQFPFSSTV-7O;(C/HHd2cadGb[-L):3U#d
d_dV8^[LDA/<aPJ&[^4S#=Q0+1^4Hg3?gY<8U)(A,\Q6Ze?+]@47<^HJb\YT_,c)
I;9eR2=G0OLDC4>D,OM&0YcAP4?1&O780\LML01)^gMF7dC:5(;)UEFaRe.2UKR7
QW=AAHgM;@M#=A8Y/-3<]?IaUTHLI=+(7-&I4&M8C<a?S>>_6Ng4C_[)G-W.5a)A
?=(499gC1BQ;(b(97Zb#>W7B;BV0_&DB0.7VM.\82T>,4<1EP/#/R2/5e4=.M1?C
4,.OSJFbO@:QaCHCdS_EN7VGcYW]P-Xa1dT9ESP-IV]-SNINGQ.7:XV)e(B-J8Y=
XGgP,;E2Qa.Z3F7FO36#[CE;1B^c0]2>C2b&e(,#=-IJ5b,MQ^.W3Z.&]RKY]J[(
8RCMTFZIK1^fY@)^ORa;ZVZIU:AdF:?#&-V4Q3@(5F55=.E154Aa2IEb/&1\WHf9
3G&KY57Vc4<;(CWZV94K@W#C.gGKFg0C]OFE+GBe@0=D#3DUa?OY#Ka6b-T]eFNM
g6=&W0QMH_F>4g6TBUb^@IbaF/4KS[=)>[0FRTX)P]cC[Fd-4G[H5M>=&Q]P#H\.
PFD(>T@;Z>R82=5X7XJ:]\U8[@Y@M:T.J]^=_U)/0[:>#S^-DX:(EgPA1Z^F,S[+
fA;SAFB,L^7A1(e1VI(Cc(?)9Y++7[:CT5c:fRf8QH^g./(XO3&dQOT:gLN3#dfD
+\7DA,\M77YL79/<VF-Z8\04Zc4O2YO_-6I-OOb=4(2<>0DM[X32V/]YFN4N&Q6N
U<R_QVJI+gA>-2^HQ?BIe9g1CeH5b#MSJ8+/9N^VQK#Y-AU?(f<MQF6TBROfc.)T
W(_f<V1+4:Le=7GYAX.S1:A&^.adFHJC.L2VLSS\I[0575SDY_[VaHeD_PEAGLUY
RVU_[RXKBf<^OJ0#91;-.g3/,Y54Gd#RK9A]F.,6+G^.^Y3a@\a(cdJB:,-VH,gF
^:@,;0A;?ERc>@3V>E:3ABg>C(=a^AgSPJZC0XM[PBV?M)eD?RVPYb9H^WO[:Y93
\?.&Q0X,L@LNb?>RSLGLE1g.+KI?ASG9)f3-b-)^#Y=^bLL7K#T&\YB.)AII(.:M
ZEU,DBY4XgF</3fBYD@[:WK,ZM6,\NQUcKYeR(Z[ZU;)f=g\?.D-^EOB(Y;_=?8/
2,^)+4GWM+aTQ8Kf16#,D>Ocf#b,)?RQKb(1b4gFfDdcEc:K^6X8F:c^e3Y#NTY@
CNMD<83FY.>LY(>IW7G@U+gZOWLR+6\]F4-PHT[I,KD>>M5CB5^+6T[UbYdT_&IN
]a=d4CAN[C;CPB&T7EG14BD-U8.3[bH]HCKcY\K\C)&#)8ff<O/CZ\D;@9TR1=4C
T7U059J:3N&XE[29GF;e0EU_5[<2c4L@Lb1Re?,S,WEE5KM-N24AG.9=e.B62cV3
7;_?/U<A8L4WcU@ZYX7NUP;e5)X5M7FSD2;W>OO(-4D\P/P&-&/EP:f^)E.aRe9&
/eb=g(]TFHba&:a0;WED)7L]]fDETa0S7d^c;+)(+gFPF2UYLGP0<fYK+S7\)\21
WG_IPabC:]d)[6Ec=(P.\S:Qa;ZNP/1#A_V:T0C?F,RN/+467G>&[)cW90YTS+(5
dH:^X2#7@X9@DbW3FeJ.a7AWRH9W7OAP5TgD.\bC.Ha79S0M6MeCH;2IM)Nf&gA?
EfKHVA0_(54K8<VT.<+Q6M6@=P3NBV^0SI?=C:-QJ6MM^S4T[7><95IEQ1W0dLY-
(\)JBT/Q/.(_Q<a+M#gB\<YU/T[BVY59bXAN/E3F=OQ\7ZY<EY:RJUVZbTNa\J_6
g>2S3?+0aPGbIJ5BO1&T0>OY#2[]RHRG=L7KWVJ,82MQ:FQ6c/Y[[OH#fbQTO]L)
\,OJX)?EDI[05E#&d\,D^PXSg7DW0@b)SAPV[&a/Cf4MQ3)QD\U>5Ke@I]F1GSJ[
>?G^gfH=<H2Ya1DGB0U+Fa(GG<g+]>+T<4K7B4;YH@c,9.TO80C1#;3^U_(?NP;Q
K<\;gKG8g).67IRF?CY_X0;<>g=ec_N38FSWcf]SID\NgOO5&;/1<N^EB&@GTeF?
L=7W+f3?4@ZNT:.6O?/SY/JN182cgO:dT@2Gb@,\N9?JO]T[Y@62ZNO_;P9Ke+>a
F5.Ke2T:/Z,60G4S<;aE+IZ[Eb(7=7T1cN&7D,&UJb^P^?3>^]/-O_6J<QfGN2C,
SAM&4R(B^e\K6]O>+Y@TK9(<T5YR>P=97A;E,JCAA_Xb,<?E5\_97M,>:2@SQQ8W
BDgaOHTTCNO2OXQ\[B?4<A-P3/bE.TZ2e2^#QYMSFS+Y#)?@W]IYbE0;@8]1F#<0
_C1;)>.CV.QI^>H[[g;TT&7#H=G^2?YKZQZIQ7/ac3)PE][cT^ENA.58X@)CKR3L
Y].5N\)\-RIgPAFb)a@28aeBZYafDb2;\Ub,GX8Fg_UFBI.;TD[LJK-GAcOH&/LK
LR<85.\/f7TOOb0UQJfBM+KF09?;RF[5f2),7JB;/QB0]UgW_G[ERNYaaCWH<IR+
TOB4F1d&])/PCb/10fbU_f&:(EFO)a6EJZAH^PXKfVc\@P..LTY51f@E9IbZ4ADO
EN?)2-)5A7Le5FNU4D7=MY:IMZ</^-N7V]W]3NU-=T<I@1J>TWQ9;aS,eV2?N78C
>_KWJ[g67\ZG-\UL>ECY?Xe3A39(B.9Y/=;_]dWX;W>+8WEdA[c,D?2W^E>+0f28
M-@Y\+M:ePNAPY[LU8Q>^<>+KHZC&DRG)A?e+_/=#>A4=MF&_>\=JJ/(E5E@<6##
FRe8+?-5ON>@/BG20?1@RcTUF?^H<E^c_(A:R,;0G4AM(]-V7N/74SZ)M2[b5YL(
USH=dA5EO(^,\<5R9OMf9PQTT)_.W;=_dX5Z<e87:0P-gT&CH)73[=gLXEDdc;.Z
R?&4,/UW-F(#YIW51RWf?>&>;?.d5VJ8I6TBTYVdV;-8Xb.?fZ@B477+68-OIY\J
2^]RH>VeU,]UM>,T_LQ8bL-d398Y]:X1>A,b?&VEJJ.=Z\97)5Cd7f8AbU6CFAEZ
.QZST)_-&B/S4<<)P4_IVO?GA1(H):4B,B)Q^O\3X2LI6JOPdJ82+11aa,K5(EPE
V1B84>Z5@0^@CGFYcYA58:<6M5AfF+\_:TV2VA5_F=:KGJ-2Q1YU<B-Cb#;\1eIN
bQ)1SCK#U3Ua#MX.Hbc?K@8Y>aLAK)]#2D+Y4N/49d]eJXJ6>8UXJ->69JHJQ36@
\5/:8_GWVHT=_<^g/@(eOQ;5EEV@3X5d/@VeW>Y(?GAgLG,A=,/JTc^V>?Sfc@I[
TPA<@Q^e;E_[]XVJ\OfK00^:T<U>PBNRS9);KY]C<SW1-YI<(0C[BBUdCNJ9a6DJ
#FKHC=0G.@>1Y73D@VEXG=2#Kd9/906YJ93OB7f=3](ae^5Z3JA#BWL=A0831/LS
+]_XR/@Dc,+C<I@N/S10ecOGg:3WID>1JBWZ=,MgJ-W;[,E>OIB:XJBgQ1gdPXF^
NV(?XD@>Pg(D-393#)J+;K6ZbJ_/IV:?;1F#2+&b1=K_X+7:KUCU7ZD6/K0N_0^Z
&F</FCL<T?5TRMJJC-]Y:P2==Q7S&SKX,Gb(9MC68OC,C_79g.#X+,-<8_4[Ia6#
47_#cWBcZ7L[:Y62dD\G]<-/ECaDRXb)4#FI058Bbc#1I/82,6a;IPG?,\f;=?L0
CI:AGH04bSJ=E@F8_=Z]?#.H?(^?dBD\cHW</a8_[TR#:aBD._MIERJY>T>g=NdF
GR<H[6gX86Y/>FLBITdFNGBYa_K0XZ]]IaHe4M?M4Kbf\gB^;.df93@A=ROZ^UW^
c+=:AXbNKLAPMO/8cf^0g]N8P.@g-B9:]f1#/?9XdYee]OV]8+<(LBZ4#AMI_8[X
CKd>+bJe0UH>dX.BTWZ;62CP2:I>Y-\6A?Q9b:3<Q02O;5VPP61P[<aA.<e.1Z9G
S#<L+WO^OPVOJ@\UW&d[WS)g@ONLc\NO[0PeG@4Z6.PP\6a\UE/ca?4C7:D-E[,G
B@c:+O-)[/4@IP@S;Q^V#3?[Y[f,8TWT?Sfe#1@:/Eb51\Q?V^ed&SGN4CJ(U\.>
G+M8&(Pg;@X+(<CSaLd^N<M;]NVaB=1g3G#<]7EETB+DL77T82C=.3B9^]e,._/a
+O01(7]XV78JZ=I<\0T>8P]JB?28Af;4>@[AM7_0(<_L3-0(P+Ua?d_aGX3PGTRA
PFCN&A]:Ua5.I;^_;P1FC()KW,J;Q48=WFeb4e21]EX=???\>;;;&_g))[3.1L1G
I/c;5eN?)+DVI6U[f]fEAG[;/(=,53UYAQO2+Tc&Ea_PcW2W./K&gN[8.6(8@5.A
1G(@>Q@N.LC)P(9OC5@TW;T,X8#AbR)e6\+7G6O7E^PP/g)_Y_=b;.8@[[B[(5>8
0J9>\a_JK?Q#d6II/G[9^T&+-?\Jae>_=\@;d-d2CDEA^)JL40gYJU9IcJNa<<R@
<b3fWg;d+cY9H\e7M1UI\/dT]9]NO6\=^V(KOa88<Ne,C#@2R)MWWEc2WeJ(M,PV
@35,IH7/dK4/@FQ)#4:L3FZM+MMYH+4+QV;ZPCND_&F@DBLZd1KCaZ4_39(,AVRL
8ZcS?.P>cNI=_SO5P,-LQbW-#Q6L++1V=9F2#7_[#DV=WEL5+(?5^+K#Y(S.C>NP
HfD6Xb1@Lf1L6>=EXM+aEE,L;<52#g8V)KG1YC?ZcdC#<#cDgYa(R5K\a&F3BF>P
NK\M6U<efY5Q5>Z@INI0B2-BG,P=[LF#(-e;,K]L\(G/M(QUSYW6gef<E1YL,)?)
U/Tf\8BF\<5g1>]bZ:K;]AI]@3NY2M+1P&X49aIDA1McGcI3c=^?_BN?OVO?T=U1
\.)e\I##_)=e^/O,2&;ZA\;A(gA&E+2/?T,KU_CWc1:<X3:_V\Ub?\BOGf,,OCIB
V)(<,93C@WP+U\RZT=fWA4-0OQVV0\FF/L:V5)DK)U=+S7R#E@8QS^X>_KL_Xe?@
_F#U13-@LR32E;NVaM@6Ke4URCe[<_bI/-bMR_5g>V^LIaBLAT-^O@^N5W+MebLK
I4_?+J)^)4ZIMI;KZ^339+U:R(4LI-P+C4MP;?X)W:9E)8[R:(I(TAZcY97=ZAQV
_-3\255(]DVMJ-bJ,ZW(E+J0I41S#NXSWR)CY8c:6VB_ZV<&gI#[.L.#f6[6WTAS
fI1^E5cf.LSgLGJQC_2g43d\:E?KK03.cV,IB43#/1fNAgfZ:GLDQ44+-9fT(Kd@
G#Q(>K_G@aZ4#QO[X+8>])Dc<O2YZBH(\EJ<&HBZLe^]NB@Pg=F?SXF[e569O&C]
Y);>LHP<,03g>RE-/e)b_aA(?B2efG(E3\bJXZGNQg<>?]K<I6L/B3P(e1gaP#IA
79SA@b]1fXWUg4:B/4\^]N.CdK>[O-YI_Df1a3/AUT_,D)96XIf2/8KF>0V_/4@Y
Z(0;dc4]=]_Z\Z6OA,4HA=XL.OUaEPaF&OLT0T)3]cQf;XDPE\\-0BE9>QBN&H,4
#QDM892BW\=bPe7ab7-,S,S-9Ag(HQ?0g2H368WSG[[GMF0SX(M&?M?LCLWBBFUT
1^8c\AJe&03GKSH9#:JIT6\f8=VWHW;OgXg<gCIU-3^O7AGBAU,MG.<daG:X:c=7
FQKOGQZ43V#NN816R[?Za1\XGVd03@7X>.a<[L\g6BZM\]54)f<@U[I=L27<d\.W
J4[BMYMGHAX8_B;,]?_FL1#PFY6+a1G0H\#/^HV;>>;XI>@Ma;^B36+QGZI/a9aP
:GAZgG-3&I;Cd:&+B@3SAOf^,P_<6,e+ZMQ,DT:6Uad6F91#eQCe9(@R_fVPOK8Z
<>caTI2&^GB1TcKI-\I]9Z?1KH+#B&0Lb21Z/3Rb?6TF)=:]87fIP?)0&(A&Ie3H
-7^H3F[cB_(f;D#bS3I,Z&38PLG^bYWE(.L1H-JQgV^[)4V1DZ?WB57a4dI,),G6
Yb.ND3]6Jc7JG/_ebg]c1>G3)2QW(9700CDO&eCA:e[Q>-fL^DMA[MCca6=NOg04
^ESH@,7[e3N;1TN>4?7=9GVVdSd^>&#/U^Y/GPCC[RcTe@W<Yfcff3N4NVG)KUA3
<K?R(,#eJ?-gD+b1EQ.Y6NT^-D]C]E]R\c=G:W+;[W2([#_V.e/)fQ7FF8QHPO4H
W)(^SAa/,(]R;,O7D+1Ib\98b:195R5S]ZU9UD/G>:#=ETSZ8M:SY4Q,,e4W(Y@N
3M(MAUgcC0Z?<:?2JceP@cG=?_NdD6+3d(6VT/5/U06=a=((=XS_B=;VZUYd^#>I
&a(XHQW6AROGZF/D9D82BGG[g3C74H4Y#YV3bHG)L3Z[KG2>#(HGH/^M0/e>#I((
:U93U=\MbBW3f\Y\B3AALc[D?#&DbV<B3S1+R\-#03K#7Wd&e6:H/d@QQ=.R9=<C
;e;I2XQ;SY.fCN.G9R,];2(.RE&:M<GCCJfE5/]6>NcS&33g\4)Z-0WgZBXB\&\^
OBUAd6O:C<@FPGSB?eR?O?Se(RHc#Cd,76(,W^(Q\U=S+RQ?]Z8048JNgO7g3c?&
:<@9Ob_I9d2/1\)\3]AD_(]=NF9dg8^.CAZA[U:U:@<C-:JS9IJfg:?U#<9T9=QU
#P_@DaXU?FAbW/<43GOJ#960(]EQD.YW-1XOY(^:HbT1RLTg6/R,/?HFYN0X>+_b
#@+2H^]A=YAM\<L<2DP>M9Y;5)A5WcNJT-A[O&G9A2G4HGGR3=6GB;Bf_ZYV]T&+
H@2ag+bLdbeagJ<N^=B4b-(S&0YAAIZ]>@8B[P(<&9bKX19dTc=Ed-TaXCYP6FZ;
17&YRZU-6R)YCJe7TSRXD]T<b(R/GOE,4\@JN;Y?[TCNEF\,fbN->C<7GY^5)?ZM
fJfb;[H>/LJ?8gD):B<L>F]&F^f.A=8+bAc3Z0=OeE;JV@HI=;MdR246eQ+3CXJQ
3A7D1_Ad=]BQ6ESDN)VNG6RYZ;P?0#?6dZ+GF\bGTHHIN0)5.FDI6VD/(Z,)OUc-
Q3Q9^e(?43^/Z&+-47?=0^Kg]dWP<V4M;DVK.3K4FLR&\T>^(D)-F;PCb.1dST?@
U@c3:]0SA6-0(9ba6<ZS?(9(QH#g2:4>_O\TaVLLS[G+T0B(\T2Ld0(8Ld+D9g>C
bf)QgCcgO8^[]IZE&L667JP6H=@,/9V&&Y/9_[egfB#&ZaTYD[O6]_(X-US-]cKg
2+KaS>G#EVO:>3-&G?fOEJ6Zc=F;H(c_KTC>f3[^1>>81-e?E(:M#abO1L:G:G1-
=ECX4/7,K<Sa15,L9A@J\6WJ49<Tc?ZeGJW[0VF=CeO:3DWLQ02<A#-[37J=eBC8
P77H7Z_D+XQ_d\;WcW4cb]JQQB)fXHREZJ3QTV3TD8GHD282E5Nc3?=SRXgX(O\<
-3b2;R+b.b^+3DfO;O6V:V^HEdVJa0&(:TeRTCA_EVKaN>3O,@3#G-]K&4#&M<Bd
VWT@_\]&.DG+.$
`endprotected


`endif // GUARD_SVT_AXI_PORT_MONITOR_SV
