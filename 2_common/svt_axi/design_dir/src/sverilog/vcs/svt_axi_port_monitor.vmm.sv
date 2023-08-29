
`ifndef GUARD_SVT_AXI_PORT_MONITOR_VMM_SV
`define GUARD_SVT_AXI_PORT_MONITOR_VMM_SV

typedef class svt_axi_port_monitor_callback;
typedef class svt_axi_port_monitor_system_checker_callback;

// =============================================================================
/**
 * This class is an SVT Monitor extension that implements an AXI Port Monitor
 * component.
 */
class svt_axi_port_monitor extends svt_xactor;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port makes axi transaction available to the user, just when the
   * transaction starts */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, svt_axi_transaction) item_started_port;

  /** Analysis port makes observed tranactions available to the user */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, svt_axi_transaction) item_observed_port;
  
  /** Analysis port makes observed snoop tranactions available to the user */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, svt_axi_snoop_transaction) snoop_item_observed_port;

  /** Analysis port makes observed snoop tranactions available to the user */
  vmm_tlm_analysis_port#(svt_axi_port_monitor, svt_axi_snoop_transaction) snoop_item_started_port;

  /**
   * Implementation port class which makes requests available when the address
   * phase is valid.
   */
  svt_axi_checker checks;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
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

  /** mailbox that contains snoop transactions externally pushed by the user */
  protected mailbox #(svt_axi_snoop_transaction) ext_monitor_snoop_xact_mbox;

  /** 
   * mailbox that contains coherent transactions externally pushed by the user from 
   * interconnect's scheduling port 
   */
  local mailbox #(svt_axi_transaction) ext_monitor_coherent_xact_from_ic_scheduler_mbox;

  /** A semaphore to provide exclusive access to the physical bus. */
  local semaphore bus_sema = new(1);

  /** Instance name */
  local string inst_name;
  /** @endcond */


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   */
  extern function new (svt_axi_port_configuration cfg, vmm_object parent = null);

  // ---------------------------------------------------------------------------
  extern function void start_xactor();
  // ---------------------------------------------------------------------------
  extern virtual protected task main();

  /** Reports transactions monitored */
  extern virtual function void report_ph();

  // ---------------------------------------------------------------------------
  extern virtual protected task reset_ph();
  
  /**
    * Stops performance monitoring
    */
  extern virtual protected task shutdown_ph();

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
   * Called before writing a transaction to the analysis port
   * 
   * @param xact A reference to the data descriptor object of interest
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
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void new_transaction_started(svt_axi_transaction xact);
  
   /** 
   * Called when a transaction ends 
   * 
   * @param xact A reference to the data descriptor object of interest
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
   * and AWREADY are asserted.
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void write_address_phase_ended(svt_axi_transaction xact);

  /** 
   * Called when ARVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void read_address_phase_started(svt_axi_transaction xact);

  /** 
   * Called when read address handshake is complete, that is, when ARVALID
   * and ARREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void read_address_phase_ended(svt_axi_transaction xact);

  /** 
   * Called when WVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void write_data_phase_started(svt_axi_transaction xact);

  /** 
   * Called when write address handshake is complete, that is, when WVALID
   * and WREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void write_data_phase_ended(svt_axi_transaction xact);

  /** 
   * Called when RVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void read_data_phase_started(svt_axi_transaction xact);

  /** 
   * Called when read data handshake is complete, that is, when RVALID
   * and RREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void read_data_phase_ended(svt_axi_transaction xact);

  /** 
   * Called when BVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void write_resp_phase_started(svt_axi_transaction xact);

  /** 
   * Called when write response handshake is complete, that is, when BVALID
   * and BREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void write_resp_phase_ended(svt_axi_transaction xact);

  /** 
   * Called before putting a transaction to the response_request_port peek
   * of svt_axi_slave_monitor.
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void pre_response_request_port_put(svt_axi_transaction xact);

  /** 
   * Called before writing a snoop transaction to the analysis port
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void pre_snoop_output_port_put(svt_axi_snoop_transaction xact);

   /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void auto_generated_dvm_complete_xact_started(svt_axi_transaction xact);

  /** 
   * Called when a new snoop transaction is observed on the port
   * 
   * @param xact A reference to the data descriptor object of interest
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
   * and ACREADY are asserted.
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void snoop_address_phase_ended(svt_axi_snoop_transaction xact);

  /** 
   * Called when CDVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void snoop_data_phase_started(svt_axi_snoop_transaction xact);

  /** 
   * Called when snoop data handshake is complete, that is, when CDVALID
   * and CDREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void snoop_data_phase_ended(svt_axi_snoop_transaction xact);

  /** 
   * Called when CRVALID is asserted
   * 
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual protected function void snoop_resp_phase_started(svt_axi_snoop_transaction xact);

  /** 
   * Called when snoop response handshake is complete, that is, when CRVALID
   * and CRREADY are asserted
   * 
   * @param xact A reference to the data descriptor object of interest
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

  //----------------------------------------------------------------------------

/** @cond PRIVATE */
  /** 
   * Called before writing a transaction to the analysis port
   * 
   * This method issues the <i>pre_output_port_put</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task pre_output_port_put_cb_exec(svt_axi_transaction xact);

  /**
    * Called for toggle signals before putting a transaction to the analysis port 
    * This method issues the <i>toggle_output_port_put</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task toggle_output_port_put_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when a new transaction is observed on the port
   * 
   * This method issues the <i>new_transaction_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task new_transaction_started_cb_exec(svt_axi_transaction xact);

 /** 
   * Called when a transaction ends 
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
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
   * 
   * This method issues the <i>write_address_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task write_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when write address handshake is complete, that is, when AWVALID 
   * and AWREADY are asserted.
   * 
   * This method issues the <i>write_address_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task write_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when ARVALID is asserted
   * 
   * This method issues the <i>read_address_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task read_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when read address handshake is complete, that is, when ARVALID
   * and ARREADY are asserted
   * 
   * This method issues the <i>read_address_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task read_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when WVALID is asserted
   * 
   * This method issues the <i>write_data_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task write_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when write address handshake is complete, that is, when WVALID
   * and WREADY are asserted
   * 
   * This method issues the <i>write_data_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task write_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when RVALID is asserted
   * 
   * This method issues the <i>read_data_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task read_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when read data handshake is complete, that is, when RVALID
   * and RREADY are asserted
   * 
   * This method issues the <i>read_data_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task read_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when BVALID is asserted
   * 
   * This method issues the <i>write_resp_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task write_resp_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
   * Called when write response handshake is complete, that is, when BVALID
   * and BREADY are asserted
   * 
   * This method issues the <i>write_resp_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task write_resp_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
   * Called before putting a transaction to the response_request_port peek
   * of svt_axi_slave_monitor.
   * 
   * This method issues the <i>pre_response_request_port_put</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task pre_response_request_port_put_cb_exec(svt_axi_transaction xact);

  /** 
   * Called before writing a snoop transaction to the analysis port
   * 
   * This method issues the <i>pre_snoop_output_port_put</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task pre_snoop_output_port_put_cb_exec(svt_axi_snoop_transaction xact);

   /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction.
    * This method issues the <i>auto_generated_dvm_complete_xact_started</i> callback using the 
    * `vmm_callback macro.Overriding implementations in extended classes must ensure
    * that the callbacks get executed correctly.
    * 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task auto_generated_dvm_complete_xact_started_cb_exec (svt_axi_transaction xact);

  /** 
   * Called when a new snoop transaction is observed on the port
   * 
   * This method issues the <i>new_snoop_transaction_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
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
   * 
   * This method issues the <i>snoop_address_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task snoop_address_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
   * Called when snoop address handshake is complete, that is, when ACVALID 
   * and ACREADY are asserted.
   * 
   * This method issues the <i>snoop_address_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task snoop_address_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
   * Called when CDVALID is asserted
   * 
   * This method issues the <i>snoop_data_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task snoop_data_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
   * Called when snoop data handshake is complete, that is, when CDVALID
   * and CDREADY are asserted
   * 
   * This method issues the <i>snoop_data_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task snoop_data_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
   * Called when CRVALID is asserted
   * 
   * This method issues the <i>snoop_resp_phase_started</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
   */
  extern virtual task snoop_resp_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
   * Called when snoop response handshake is complete, that is, when CRVALID
   * and CRREADY are asserted
   * 
   * This method issues the <i>snoop_resp_phase_ended</i> callback using the
   * `vmm_callback macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest
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


/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /**
   * Method which monitors the physical ports and sends them to the analysis
   * ports.
   */
  //extern protected task collect_transactions();

  /**
   * Implementation of the peek method needed for #addr_ph_imp
   */
  //extern task peek(output svt_axi_master_transaction trans);
/** @endcond */

endclass

`protected
;5-:I#P78dUWA8efcD;IEgf<<##4I)]SM\=GYT=22?;BLOgffZ(U5)f&=IB=])A;
cg[Z#3PG/[E5RYQCKINHC:#[INFKV>04Uc?2Q=8<JcVCR;2GMB-2&H2R:687E]4a
6daT(f[3KO,^#MVY65DU_cE65[+eLc&NW_F<[PRgW@A7.>C.8X[S=(;d1Fc]88=/
BJOgVK7LeDQ(,;af1&>IE=3cM#eG,,HOD61QCPb616A[D?;6=_]3b2JNJ2IPF&RY
U[+I)<3]R.,ZVMBGN_F-0^FeLHTbU_WbcACL;3VA4Uc2A(Q6JV5T+P<25TLXNGSQ
fM;XP];@He-E+\aSPQB)]Jd+HF9=0282+AbQU4dTb]V4@T0][V3BML9U>1EIOg_/
LO@[0^1K862e9gK#JE:4#<?L)a[dWX_W?#Z0aMN0Cb[1&FbFJ5DE172b[R)S(Pd&
9@Z6b1M.T_NbJ>OdS9#)J<C>6-S#A?@RH/_56(_aHD+7_&Tc71ag4:2_78c&Y3GG
1:bR,RVcf;)QKgB=ULL)[9).c<YP>XA,0BcRNF0_e+A5Pg()@0D^4U+gcZffP(]F
;O9ULeN[L4[RQR]#=LOMeO<07>EH0.7BL#LR@)W<@=?B(B[]Z7LT>D/:X@><dCLd
G&G2V9\:8Xe:f/&4VMFa^eKDJ,[]I_6=NfA>0e(8AR4AbB9TOZV:S.D7:_CND#bA
,]_3)H)2[3G52N?JV5>,^^:D;\\9P31_c;eQ?.<?-IC-111a\(,1KP(/K8:9>777
T-0RfG+D@[NNgD)O@B&fUf4VXH8](Z\(KO(SbNJ=\H_Pa/G,^)>a0AQQFPQB?-U&
Q(^49<UV[AZ1=C0WR^/,>9cgO9(D17e;eP_QAEBTF]DB)@Fb22?M<ZOgg)YAY89N
9,d_O+@5acJSJBV,#faBR<bc\XCFaV<\1<&4&D2A9YccF54D4g\2J9Q7O6#MV37[
c6+;cIQ<^2;9+5&362]F5/@g2KKG?4J2cIGE66E9QUeGNS>@<52D=B=@2G0d:\CD
Re\0DY_3_O,8:0NY,J+YI7c-.ZU3&]U3_9dQVaS\TMH)SETJ-T+S(D2@B=?COXXE
b+OFdB<bSJa1[[4-66^SCE+O(QB:b8.[1=G1aQ:M3R?[0LaX)G3(A;Ub5QKN]/XV
+cJN7ZVK.3Z=_(;aAAf6cgP=/92-5eTBHT<Gf]B25ag24Sd__&Q59E:g?e-LI.9E
ag8?;P:#P^L2-_30fKE9.EW<M<>d3(;9)/+)9&SEG@\M&>#8,OCE&L#PT;4B&e&7
U:J.56>+C1Dg\4?/Y\]g5D#S+-GM2UM2He=TgB\R7:]P?<Q_E:+D7/[.:XSPM8Re
P1CJ#6J5I>bb-XF/K29;HY-Td./1FFNfe7]<.B7<#-^9+(@OMLAdLW-^]cNXVQT<
cKAgO[?X>JV))c+UB=^a\UJMV+\YRa^.-+cAYTD#:W(QIfPK_YbZGg8S(ELf==Fc
A@UV=C>NVRc]8U.DNV3XG:O_,,8^2Y\-Q5W^:ASH4-aP<2f[&GbF=\FR/eX,88?U
W]a@O+JW]YS1;Oe&;@G;d=M4a?1<=NW;VX+9+g@Q?_\==8JIBR_M2MNJGDR&/2XB
VCL@SfC4N60#-[IY+DVUFdGY8dTM75=TBcEfG#I/?T)&9:dP6)\_Z0+9_Z2&gJ1\
-TS8]TF1V9A/@Efe@1b(6TGY8$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
15bLf)O8Q,R<GRZO0\0N?5=]&,0L41QK_22d1G3=YYCge3L)_>AM3(]UG]P]IB]2
LTNS+eEJ9Tc?T,G?(@.T^T8g1a.^3RCOeY=C^@L=d0MUDPG=a^^-/?H_9,50UaDa
Qe>([/5-Y]&\1aY@X=bL9VB([6T=<?ME&HBR-Z0JU6C5S8U5TNQQZIfd08aK)?D+
)K5IY#)T67/G.P&N+HI@C<))>c]AMc8Wg<&?G2/U=B;dJT4T/NVM2ZH\M,\Z:+gO
T(g/XS4&HC6eH-EP6g,RZfET+BIO[[MQF@<Bb&bE4L;[b<T,7>1O/gJ0_TP:E+,P
d?UE#07=:>7^\/J?7H;f=C;JUZB+e>B8D3Q=))dVLNM_eV&LNV?/9Z^QR>F56V>C
5bY3K,)Z&4?YV:c:W5=6;2<G;<_SATKeI>)ZBA.,#OEA+=O=b5@?c43F]G=OWD^Z
/O^5?^?BHP4X8>e<FO@Nd:HM4:WRMNG7GB;I@2<H8;CHOF<8V_gA[PSDcb:ae-bY
cU-\#@<d.6:[MH[8f=^WN#PW^&HXAC.AUbMe>E7S\?Wf-STQ/LZSQbb[KdVI78U#
,/\GH6+2&&9;C3[Q2APHD,?2C8>J>7SF@-B=M/L-8Y3cAV1)WC4B/IZOWOR/]gP?
.1\5\:N:)#8X^=V8GOg[;E4B\4VUDGXRI>40UI;0&Q5I5d.c#RFa97ENP)Z6+F6\
3NY6,@.36\-,aEO=89?N7Z36aT9f_0^8TQe+@7<S6f[NJc[NZSb\#8]?4.WaCSd<
Na(DXW+c[[5+C@gU-RW#O8I1]CW<9?IQ=4fOBXP,^58UW(WcXX\IJ:^P9BWNFQ5F
FHJ.2[]TY,[\:aOc\<>YA)ME1dJ3R]5aACW@SVbVG<2&>JJ3;#)Pfd#YEXR7N^M7
4OdS1ZWXLUd#ed?U\9/#?N8?TJc3&R;C&TWYcXQ)4D]N(;WBBX^.)1Ifg/9YddEd
W&\-.1W.V,GX]8JSYR;TCE^f.L=d8A1BdQFFS/2_0d/&1S2bD^R--WXTYB-UA4)?
gP[9(eE>cNODL8](N-,7?ZL-gOcPRQV[(RZ1gERB_A.[>LGOL6:<,Q_W8Yf^Ub_[
US2<Y5#HQ.0\&XfRe0ea2^bU6[PE?N2.<ISgA?U[-FeYPVE_E4PG\Z-HM6DNC?J)
H&D8T4@Lb2C&cAF/+?,I6VO)(QI-ULS8T)#U/I.@X(-[a,UG_a(<5g6P1JF:dEO1
NfE,W&aUde/XW]&W#Z_02K@-Gb>fg&C-H[RP1QaW2@A@6gO7Z<,3ICd,5MHc@e2#
UX]?#6eHR?@=[)HJ-XPL60T-PCKcK>(bf8S5\(6F@TT/#e_./YZE>_SNA(,.ecDY
XS(G1Sc884O(/&8Eg;f(BSY\S)aKCM-=VYRR4g;]^Q?c6E&8F9;#a\\gf92=G50g
>X<eSA4,9cIN8TT[bE;gT14@NcgQO8Zc2N@E:N_<CJWQ;_\?RCF(WRQe.;?ZbdJY
dB2/,?OeA,F>TJK.T[#W;8c]]O^XVD/C5/4aD<Sgb6L=?gQWWTaQR[DDf)PSg>fB
gLY+Q/5]7c@0FF&=bYSC&<\ZdI0Xd>Q9?9^1#?=(R=.[VcR+KWgW;T;H7.Qb=T6/
bf120\cA#21)RYGCH@0>S\8Q:^3d(;)58cQG+04O&=A9.Z4)1/dMIC=aK8<2Rg.T
XC)R0e.I7-315A?5g+Hg9];Fbc@_C-B6YPbe2Wf^9#V0/=9FM/IU)19;.BXeUK)?
<#V&XN/+3)1gSJ5d4:TXN.PEMH;3Z)bL252O4aO2]dAP1)XFJR-II#>7A;WQZWg5
)SS1Eb;^R\K--^P?5g0b0aARZN93:]BO^AAH/Z@QS5^eV5G.,@0>9VPF/+M(&1TW
7K]d#219)/5<>ITSO]<RUGUcg_(B;=QDYHZBV;2H:[Q^V8O;TTKe4I/VPFP=N+W]
S#RgDB:16e23@&EEJ73XL]JVJI3TC,YYD@M#G_&=CKRQ+D[=PNTD5Kg&WMcP[g80
]>d+.3,X/<6DHT5U_NJGI3F#RN2N:F0cgc/,1A-S:MRJTF#=<&UGGT)?9c),QRHX
c=/_.FQZ7S/1P+PJM-;X=?^29aO.:SUSGXLIg]c\^b_d&@?cV#6(N+WY>\_<HQ)D
1H.S9I))VE\5^gSV.09#B>g1]9.O+U_JCcQb6S)0=+dJ;N/0+XgO@=8B#TI;@P\A
[BY^\;[_U_+N3_Jc1dXgV[d,fOB)E=TOY>GdbbFP?5NSW&M0QV6EAYX:]^I.ZA^W
VQ#2_SW8I7[)KXG\4VIaS68]O,):Sc<X6O>:&2\B>f)GCRM5B549,@WMf6fFE]]<
H[-D8cY95\AJ:ec(]:0Q&0R6g7P>+N,d8d#C&NAM@VJc2B0KeTZ8W/(2c(6.VINe
E#VR[]dffP#4PScP3d&/-W-9]H:g+\IAH)Of4\6_=A=R-F1=eZMZ/H,_8X;30cd1
92PU+&YbO.@P^:g&F;_Z[65?,D0R4D3++NdKf2SAP1YFTU+_)YIAg6UGJ6a6RR=J
,Vde4MUEV8.#KdV;++Q;QA79\8?E)?=f@V_<UFY[+=U#Q+Y[EM<VL6>bMZ9D[D35
KY0c@\R:1_VBY/G;>3.#L2R3+8Qf>3L6f#Q.aA&aW[A\V8eG1)UW:5@BQ#Q2XZKX
Q@1Ee>7gE+g;eG585JN:KXLQCBOL(T_Z7363a0IDgDdCE21J>USC1#b_5Q1=X,[;
6f\QWIRMKDcd<cc^)<14/SO9gd++eJB9N88fYNW129)-]=X(HD]R7@^cFWE)EG-T
YXb3;[=4GdUDS:I=@&Lb/8Q:e@X_=PBd-_&7IW>JaQA0C)+F3B+^4<(=8;P1d8+Y
K]^(P+4=4Fb[2Fa0LbEL4Xb+LDF#Ua#U43F460:eg6Q=;_1\?L6&S&-7?&degFH:
[^cIfbO)EdY.7AM^4?B?c.;,:X2PXPcfQ2^)B<T_OeL^H,-&WWL5S6PNZBUd2fG(
97=A9I8eG+#aZ[[^O,-1&R>.RYCL&?0]F)A:1^LV-QbI:cfZW8QKZ<:5HNWQec(@
e1f+2@3Ig):5LP0SJ+1&^R0GD27gRTKW(JeOa(-WeQYL303J/K]6g2Bf:Nfd_#-3
KZMM?ff=]OWK:HMQ<;VIS([BN+@=DVB^d1)cfE(0,92b//(T-U5d2LDbH9(DDWV]
>D88NW#R<@F0+8&5f>3EWEJ1&DT\<X5f#SfRFI]>=5\<[TH(00ZL@Ca8cKKPa_<X
>^\Ye,H]CAW5:.=;W,.c,&:0B;4Qc;GgRDO#Q2W>.d?_Jd5,HJD#7TfN&?&#M6EB
S9621ZIE@?4D\LGEQ(M5S0^.UCZX#HT(H@1LG,C&8(N.HB_=,HZc_2D2+VR2]@X9
]ecI[RN)3/aeBIIHF4TeB>b5+BMS9B[&7UN2Of48DdcUD.ObO&PWTf<a781CeJ,L
GXZ1?]>Qc/.>1GbQ1aQ\5ZDMBZ+NH<Z[;N0080SR3D,aW\+fKZPeJMT_d4?<eB;/
UdN@7gB7T7=Qd?\2-MS:PL1Hf6RQGKQOCN:M56.F:M+@P6))XNAU_]ReHdFcg.Me
afe,^T\I2=eA&,E0BZ&[eF\7_eM,L5GH[,]V^ETAA9f6U\eY8bS@Y6XS\Nf>KgAd
T([IeKAeD/9IGfBb,\BH4@_fG39]7=-P,Z_a(RL/\D/Mdd;N&fH6/O/QcHPGBZ^d
4>&HBLV]EAN/]<&.b6aS3YS=L3^Ag^WW2LXFPX3=;3cEWY__97,)W@,Z0??Q)>[9
\_/>bH#dP<[g32]_f7G;A]/d@Oa627+J#HB>8>FJ?N]c]/-fW28;Y/=>8\bgB-=2
F3IaT2-E8=?N=F/4YB?dG<XQE00MSbfeB-WQ3Xd([^SfZA_>08+>@UgY?(,I7FXU
:)GY@(RC#U.C+/#cQ&?/B&Y9U039V5Ig&N9?c@VF[?^Q,ZaC5fc0,]aV5-L=c4BP
3e5WXPED13da8-7_b#e;--9fJMEK2F.^2R7L,=.@-5?K[JQ=e,ORL<.MGg=#;,51
,BN,E@BHHD(J:B=YF<N0S2:AZXS7If@U#2d;?5a9_MX+;G+A,c8YAQ.X?N_JQ&.A
MDN)d@.OdU1>8eUc4eE+ga(K-,_^THBDOV8]7a7eVE7XS:4VUgP_;:OBeBYPB2]B
3V^[gA<.Q4fX0V5#QEK.YcIgXPgL:C<9F0d]f3VNF=?H/X,R8d^Y>#JB0OO24HD1
FTT@@fZ[e6c]IL[f+L.3G.&,LH<H7F9Pgg059e:5#O2KIE0)SIVDdMDC(HE[M#C\
KI)I6TA5@8[YHPNFXg;.;NQ:6C;X3TSeZ6O;0:eQEI);C#bY-Y0>HfF;/f7@d<R]
0c>AW(,ZRJ5SR\HEO99>3LQ@;O1Ga<W(:_5ZO<.#CD[L6--HWLDWd>:)Me,]De?#
@HPfZKFUZ)c93<N;)6EWNTI[E/3He>G^_C:IVDB#QD(-Q+AZ4GG1&YKaHCUPU6,d
Te)3>Q;80=QSg0H7G-(ZC[SdB7ZgHLK,MG<M^Y#JUU&^(=G=e2DKAGI[R\ABK;Mc
57U;[I_\S0ER:()A@AJELaB=940YI08gd#W;eX?=&)>Rd]AL@V7Z.)Z<.Q_AKf3X
;OQ:P1@/5?FCL@4_c)+D2F3POdR(VEJ=-=K]=2.)N5Q7P_UHZ#d_gH74Q&5833\-
)RZKI5-@V4T)[]F-H?>Y@FZH_.2[/FD3F22>^b7^LDH+9aLdgIY(G#Z7A>K1>IF\
<gO>XVY]Fe1;c<GB_cY2V8ME8B?:R><R;]T#_)OUL9P.HM8OM=<YZf[-a#=BQ-UN
.7B#X9.>X^Wb7^]5#:aT-dD3CW]VN9OS)37;.MIH0YD@^DP-7e6\T<ALQDJ&aQWV
\[3L3\4f]ER8cJRN)=2ZaB_VVb61DY<a8567M1D<HYCg[<8.T6ML>-P^g7@9,+Bf
95daX<5bH#<E_INXg:Z6_[YaIa_#\#Ja>#0f29V[,aS/I)bO(N].-Y2:OVWEa9.C
cRCB02>B>V@Bb<;A.c)7)):T=?)<]\CP.B,HD2.Da/11?&.W<Y2agTaMbAN<&>]B
e0A>(_>D_PFYXBXcER?BY7=L<S>4-YRR,c)P#2Ma=NR5LN_dM01HMRCQ7(HTJ^cB
EWg?&,[VX-XSQc4e-,ND;2YZX2T)G:bLC4C[@JO4DI79[ef=RK<CD0gTUMNe&28(
4R7SVJS5,M)K7;M;;,1gB+ZCNW)EL4\\M3S]S<&EF21D2bTA5RG&WHc9I6RF@f,(
^8@E@\GZ(DI(/C^Tb:=3LY4Z_>ELWX3__5-P8?<NVFO^OfHYf+,HD25[KAI@4c?)
VYP:)AZ)8_4H>VSGNPFFfAT#WNZ6d7M3(B#<5OY=KDRS4UIQZ\2:L[eX6JS&N4\#
HA6=bf^IX^JT&R\MfU5+1;)]./g6R=@=(ed;#afGF>V1>-5LK)dSHI0T+.BR7)^0
N5Kf.SSQZEFAbYF:6P+:3?3G85Pd>Y.L/fZ&EH7FY_6RP6.TT9g?8(D[](#?<]PQ
82L?>)Eb.9(J\ed;C01JY\EFZ)Nc=RD=KJd5-#A>CPQ3/]K<U=+52S,E\#3;H7PP
34FLNS+Y@9F=cFCK@X9#.EEQ1dI,:eBe:]UC>eGZ6I9b)KM3+Ce@PM<J)3PD4^O>
PfW,T0Cc&2eG)MFY\^JLQDVC5Y>5^&K0O(A>fDV?+(681SM;JKP<8(@PXSCBb^&U
K8(a08]1WV(<JQL(UCL74?#7H_E,[C)Y_Hd)9fgR(ce0a<UKdg;+Nf\FXBcAE&Ye
fZ=])AXP#1YIT5>1/&&+F6.O&Y@IFd?abL3K,##/UXBO5O[RL2eGa[EffV\;+[F[
bS4#fQVgEVBaIPaO^UO64T2f/>03ab:De(+[:&,_-+1>\Q/H0IW;N>YI\1.:-97L
#;ZK^#R3_NOaEg__&bE3@VDEOf/14feS,RERO#g>MaF2>=Z7VO^<^1Ge_S7;+OZY
./5b7(.F1O;9R=5D+<f3^&Md5W?AD9Pgb]G:^U<7ISJ4S\Q>:DW5=BU.5PfFa7H1
S9d@^4^49R#V)S_G5?LFHd6:W=9Q<4VAD@>Ef(O\dLYa3=(cE^DXCcZ&d2GM4S6J
HUa?WaKD(WHcK>_HZ^VJcL=9/#PKbHLbK]_aUM&gJR1.gbQMZI296SAGEd>QV<@g
gd\d#\@D6NA?[-(A6@T.MU7OB;Hb=>ee:FZAFdC9b(<3=c\3<C9G\;7KLT+7ZUF2
=BfO\FQ7W0Q/?^=#5;8R[[^?aBbLS6H4T;.Jb2/1PgCP19[[.3E3SPZ5NY5M@.\+
;ddJ]H_GS2/b-[18\]g-9JL/FR&La&4(9GVfK@53IX_g_IC].LO,BXa.F[29Af8V
a/>daNP_G1X@0,CPB<;aAX6aaWP<aW3IXOMB<BR8P@J;X?f;(Ae\ZFM@DOX\e\_c
Oa29g@eA;]_Z1b=P/R-1T==68Pg;I:-BGM?5b?cD?G;^AaNO<W56EBWFUI\^__G1
T2?A?N?)XU\&RJ8B7G\N?<PZE4T]d5b<H6(&J)LCd]c5C+H+V>+S_R_ZF)2:JW5R
RXZ7FYL,?f.4e30VP->Me&@-,3Y>V4KV9GTS&0BQZbFEYaQS@OdZC#ZI\B2b15(+
7QdJ77T-^L?5V,gG3Q&Y9BHK_1gEG8P:Mc#2M48[aT<GT&M?G44&CISE>Y_F)6:E
AC9H^Q.K,6JU8,4_B@,.>S#;\Z3(Cb4^OY&W^c?D=7O068NNMG69C7<9\&bI5/@6
R3PV,[^M^/=eNX8cGX6aHa-KR7.C9PL<_S<ITW3NE[]:=HggbPCBI=&/BZ\D&&WD
^dP;QHW[@V#[ESZJ5QdA.7ID@X++0OeSWQIbVZ;Fgf@dZ:ZXB2&YH;QB1;SZH\a;
MaB1QFDC5cUaTEY7-L@]>BB0#F\C5(P@W,B)\36(7BMbN+@d>2-8&3,@;)(\@gH>
f[A5XdP+0.(9B>bgg5T6))2)N]BdIK_3I1#:?J6=M+B_K]1QQRM@E23a3YMZ,@@[
B:1gUM5?-\D19/U&02^JO^IH@DG2C1J+_dHaLeOC@>J>K7;cTe1b_]YFX<JP0-O5
_FdeIW#R<39eD/4/L2aac(C=,)XTb>:904[gZMDQ8d)Y)FfMbJ)>:-,=V)d:AAe_
4JD4:aN2=0(d,8FgJ&YK;9D]0]5e=IA3>fcB)D_a5+0_2F_#gFgG#:WT_Tb[7AaO
VS9?Q23&OQ<:G>9>SLXZ=M8P4A4I[Ya?T/FdGE8dId?0;a9c@?G2KK8=U<]:SY5<
4:0,9O.TXO]F\_a3ZM\<fYP_6;;3b+:aTZ>dP7D@=M(/IMNe/bFW/A+DcZ7>@JLD
edUG\aIO\P,_bC3P>bK#&-2e#?O,aCX[BK.(78&Z),He?CAX,B-X#FT]HC8GG+HN
OI,0dfJ3.=B/bY5+.MBD(+HG3<C0?ZQ+1S-BAT226>e/4[,/e#b2;:#SBCBB/K2[
P3;IN0R+5,W,&O,^L>Q:+P>IG_JU1bCH2I583M^;UU]XZ=9W4QP.RaL(LL,1cX8N
f/Y_gfN0(XP@g@d_:Z(4E(bUPCRI<9)-3+ES)]Y\0<S9Q=<MPOVNNV4875>[NbYS
SY+-dOG3<H=0)b#F0-,+c.-;,]]]LKJVA?)]L0E3b/,#-\P0CY_6&MOf[bBVGeZ1
MQI5S@(F=&+b?b@d81.XZ@g3dMN1_.4eH?)9F[-EK;KH-?NKgF@@J6WWgN=0cd.]
?eWG#6H<:3EZU<SAM<D?TA.0gG[\)B?(FPVC7^DRTY5OFdDP3/\:a:&@;K8-f=]:
HWSWeRdK]TUdVZBC16dWC/\4KVL-\>@AORHR_(PH\I/(7SY^+16eOa.\fQb+\F83
^_OQJG+.Ge00EdA@HaECX>ac:>@392,b[),e^_a#?UYBa0+-LVN)SD6(fLfZE#b7
GU9Qf>R=;f]fKgKQ?^DA.Fc\UYN6Y9ZAcZHD:DZ7cZ3TB8(IaNaN+6X>Og,+LI^]
cX@(CRYA6GN?6HCZY&0[cgQ_/E#?;,JWYG)LUKgO)-+E^J>[bOZU]OYWJA,+3)Q3
O^)g/1d>4OWaT]-5JD[METb5V;SBRd/95#YbOBZPfH5S<,a7#_7Z:6-Ub66H2<]M
f\4&V7_B[1/fC:#XQ(9&_8gNY-6U6[C=.(5MZH1SWL(SSe87\6Xf>&[QHT&P2\+<
P+J3UT3EK<]]YZ4GEc.BP\.JHCQ(NZ3VE;H9^A#2LAL-QP)TNa:IS.]GB8J_MUeB
ZT;>G&Y,&dc_6=eDD1JM56#=PA(@;=X>d?Q&WPYFV63\1?-_)1)D^2E1;FaAJgR@
be#7\bFf]+V1W1F5EAI]fNL?##f5@CMI^O>A3&YGf>HOgV,4=P^IP;aH&g8.Z1(:
7A;=7#T/(K.bGF_752+,,DZUb&ec9_&R_41R[[PZZOZM]QX(;E=a3W3E^RH&E?HL
b_X>V_K#B#?Y:6?G3V;D:EG3T?9<6XM9.H0Bce,Q>N3+TC/QWK2?7R9L,&fBM6AQ
]AIf)POK8UK2-:a?VCG0GgEJF@>b7O5b);QKQaWE<,2L+_BZg:aX&7[?/9X5019M
]Wd]JQgB_P<,J3b&)&#OG^S[Wf(B+N+Xce^D01D3c\&5fgIG+KUA@H8f]UaM91EG
:HD)E-WU=PB0X7[[cRg+^POO7@U_:L(LF54+1;^Y:E;T8OH)XT2GH7\OaF6.+,RE
)5(V(X46.2==+X6^f-[0&<;#26]Q)=T_W2#Pe1BFKH9KK7RYM[KCEDF\/7WIa]M@
7[3X2EG[R(PV9HY?\6BB=QAH@F&Ed/Ye4D?TF]6_IQ:7Y\G#?H[4E_-#DeIMUgJ6
_8X,OB(_<cOfLP:JdV[#JNRJW8b5eFI52:8A;<[EN_XNX?_Z_&1:8&#Ud<RMPO^,
Ga2\?VJ9__+#\19L<2Q^dOG[?B8PDA<cVU2QME?G#Dc;?B)A0D4d,(:^?PgY+,4#
0Og\M]]>H5(gB4GVNV>JG)2-Kb)SeDNVL]YXF3(\&b2JV(b+\3)W=W^_M3TEE:Mg
UeV6J\Q/Q<DQ-V;[2+&e2YReD4C#(W7XQ6J&.1+LX8#6=>U=ecOET@5d+P85(d,E
PP((c#M@MRT8F^&7T[68PTGQ-RHS9dTSLK=+8da[)MGcP<T[=;[..9^P?JN\8?IK
X?OJ_9C:Re.Y(8G6OAC:?B)H\VDd5_:bO=M(bM/7MV#1KH#CAEGAB83JQ?@8f_QA
cNAKMTP)1A#P>#E\?;MZQb5JCM[U7EJ^aBW>L-F)N&=.OPXT60A8N=::-3^,^;K(
_cC;GHY/TCL@QSA@5aO-UA&MWP&DJ=]1@7IB]B@d[<[K1R?fC<+(\EDLBc#<H;d;
./a,/gg8RAYPDbQL;L]DBDOWPJ#(-0FK/bS/78SH>I>@:V-[AF^-_GVfIeP9RJ^J
VFXIcYB+?+eKYFOTP,I;T^Jee.ZK>1KVSO8.?^GB7_V#AO.H=[7a1#3#VT^L@e0R
7]V0TR@Y(bg]^UeA\[Z#>1K75\SPbbP[])V@T_OE-)V=>A,,K#T0ZEJU,D?ME6ZR
:5_A7.YLdOS[0H(MaF&?RYP_YM<BOO>gbDa3S^->Mb6VTVCPW+d#GRSgYcK1HDGS
;]-JC^PI(82g6J8]:T0MLg9+(3+2+):4O&(_:DbDgJ8dULdH9d?c\=M=_M+YN6IA
@VbL/L>;MG&R\+3.H;.J:6-GZDg],U/DZ4MSRCf:Ae-2?:+GOE8/7:b;#QDQ@8^L
<Jf6Xb[]/E#J(M?/Dc;7aQ4W^DQ[RMK#9:1S15E5]OG@0>W@RX&YReSD81J1BCWL
L@OeBKTP>NEE27H6Xc=7H2>2FDbOV#5M1.a^c#XeQ9;3U=PJ3c-4aZaeCD7OS09R
^C>J2CRF,43(d1K:.ATVZ9aa&ed#XBFB-KWP7Jf0:e=^d3L5^gF)?9RCLWJKL>Jg
WVG@bCd3I<c.Od7]B_(8;[QUN,Z#cW0MK1cRR4J5/U-^Z?1RNW:DP0>HAB8<NVH4
L4T6#>,(7dcX:)\b1J]4g(O8O)5e=8WBD&EXO#YYBRDY[D[8bB7IZJ>,_?\ST0M<
1UY#RUKIP1=/(61e>3W-S+<B2U:P^L5Q>cg.W81^2/2VNIO4L;R,1YHNeU,/?#BM
UHE(UKC_)M4,b^bNG@g?Q8e[&EFO139aR]?XfR2A.K6b#O/:Hd/3^>?4>g98gUM6
G,1)9RV#c3DbSb+QU-WgQO7EQF30G9CZLY5UV\S3V>gH?[=V6;Ya:[H[+S)/[QdL
0ZPZ0Y:10:4^NOcHBF=>e?,E<H/A?<AE>AAe]^\05;HH4_C^\;;3C#TTTfH_QaI+
5DFALVA/g9FDE&E^aaOL1?=gK),-4S=f+aN]4Y(XN8<TG4UcX>U1ZBZRcP6;:<eW
YGaG&cDYQXPZgZ1<1,C]96>eWAA8Dc3<B-cI-YQ:g7;A3QM:IJfFRQG1[I;4_SXC
F0d[+^>g63]TLMGL]P4>Y,@.(e+B7B#7E6T2IS)WGVNLXSIJJBE<eZ#+C/F6()V/
g:JWN^c:EDfc5\Z5edXQ2Z45e/TO:+U;c\SaQBY<PMD4J)>HVCT,3E<ZgMS>;KWb
OYe?\c@^d:W4H9VSB..X?&VBVO>L@^VV.>?^2QVJ-+4[AYIFAc0W?9>4O)<=cJ@C
Y3d<1^,\YS\cYKNg#J/cJNCH:@F0c2>-dG-gAX#LP;6a4LJC(gW]Y:LEXUc;1<7c
(M2LKR78&_CJO>]H8Ab@>T(60ECCb.gQ._,35,JVNHV<+V)dTSK4N][;2a3&gW(d
RD8_XD,/MYaDH]U)CMC?2B#&703.M:BO[Y+Y@6PLP@,PdA9D,X><3(e;^?b.dJBI
/eCZ7Tb.2EPg._\-cFY@/:DO4LZK-6C\L1X)1&MY_CW.9UPfTL-fUg82d,&OR[a?
,2,9[XG,,c9(gd;2C77AX>;UGI-g1WWR#I9c@:QeR,TLc4XJV/64CIg9S<M>XJ9F
M,U;6S#39A?83ag<ZBCFgP@#A(OT,#Q2Qd9#O)Ob[La4N43I.Y,0bIFHIW4M;a:B
(G>g]]\b8?XT@ge:)c>:KGLWfe,ZZVP3:<?:9e<0V;_\0+MJ(YA6GV4O4dccfPeO
LS^^UW\@#<U)OU]4b]XRd-:R,/-Wd\VDbCJOT8W7db?F^#--Xd^SA6[:b(,QL31A
4TC\84GA\/8?I/FA]cfd3:013W:VTF?>8a&RgA3GGA&G8NLA/0a:+H?#a,[7GYOG
eL:c?UY1V_(/WY3M?=NGDeMMRH+1EHGEfSd.YaR2L#Vd9?Ye8USe^:2:bIUU=g,X
d>X4><#.#V6b5C;E\(K#a>#@8.4?HFZ78SC6F=b_gc-K/RPD(SR>3LD3P47F1f@T
6VZ:@6^1+c-V.^R>LNKV]R/B(=HXR^bbB7aLZ)J=Va+&\KU]8S2]7P7U3885QQOa
gTBg\cB>dN&YSI^4S^^=+=cd7)[/S3LQV/H.af\RACf>Wb1@;4Y&>JEE\A;P[3A3
CK./#f-eOLQJTe^.Lf1Q#2Zf83/=<\MPIPXWZR@YT=6Kg/TBI:(?+=>^67Q2YfLR
YUY#9R2aAg8(gBZQE)W&^[.;;Z;-aM5FD91HUY\QH4@N_cYAI&eB/E&(P61CS>GT
LeT1SAB(2I8KcMB(Z@&PQ:PI4_0A;R1M3YNf.43K23aPNK?O+6[DOVLJQ\;YI1d8
GQ0R23N+RCI><dZ1WAXL8CW5e5QC+d6Y4Q60;,1KJ-RV\dYQJ0N<H&a&O@6e1S(=
62Z@2:[8HV65f5J)KAO#Kf(5]M]A,6D2_b6OJAU:.6,cVdTId\I5)]--<\;5#aU.
fAC4P?<TD08VS<\R]0Sf7WadQ,A5OUd>-Q;HY[((FHc>?^CbSH;fL+W.=4@R&JX\
,986:O#GDd<WYa7F:+?;>1gOI<7U0W3V=-:HM1AY:1BDWe;VbM+7@4YD3g\1NPd&
,DE<,G724e.PHME)H5_;WLEgU\FE170C<RJ,O5L[fD;C5D;X4,EbD4LcOf&XRcWc
b4D6C2RCAP8EILIT;GQIPJC(3?.J]Gg(7)U?QU&.d<#6_2XDeT&5gW\D,b<]=2X(
95^K:)7Xb]I?6F@:XA05K,_(g<INS:C,ZP0[1TX=_dYR)<@A=)a:J\^=V[fQ^&IS
]1RW9K3\0NU]ULSRCGQZ_8[=C\8S76[0<3/BP9__A(60HRREJK9[C4dJ5Q0[>YF?
ZE,@QKgc[>O?;JD&)NQAd>-?fJcCXBC5+YIB:g3\URe)&Vc1G.c]eK+d3P@TZG?B
6>b3[<@RH2ecO?6&5g>RgJK;GBJ>QdUO_J3OD0b,:\:=IaLH7Qa:+^HV\=X^@bI&
XK^S5JRb,#9CS\3TF85UUNfWDC)7J=GK2TFLN]]76WWZ&^H=.:S#VfXEOEQ34:_U
U4^CTCHQ[QIbM=.3Y(e4edVA>=H@O<WZI6.D_2DWVHVTfc5d@4.=XJdR1QOMJ^D3
ARK?\B]3(c.[H@_036DG?8)_U/LJE7;O4.KVKe]dRPQDSU;7b5_2>C0>&Fe\(_YF
-XW:+,3gO(?GA?D,AUc&:ec88()K[I+@TZ=MMN#<ebAg+9@LdE^2T(X;S,c.]OaR
afD@SE\/3L9:dR4DGXc>dM1Q2@):/ZbdR.NF<FY+a36ePB@RUa>Kc7a3BdI)C>J5
f33eMT+:--b0>fC[d^+4e)<<Z,f)5DF]4U20ILQ-3;K>:K&@(:^J_#^O-Cc2^e<7
BF+6c>IgM#),Y^A[<f3&3=X_X:SI.eN\EfeR&G+Nd@&EfebQb4<KU\J)+\M9?J/-
9,D^^a9CZQK27.KSdXNJ#:g;4<]:W7GIO5LPd@bJ;KF#I7N:6e\482AS<G-8QBQ9
^J3)@6\)(e^7YJ(TJfE#1:+S1&=O0?JAW?EPKR7EPFB@6)DGGUG8DBGEB)+7^QRX
KW]#FHd96MX7d=>;Ucf.\Q^GE[aJ[Lg<fHVKLT@@/Yba14\E-0P9#Eb\G:L;FdE&
2G>WP39-dGbB^FSDH8)I60HA5Rf:SL@U#P7&]5)+(HX4B3?@@[ORe:C76Y/83VG2
2L93?;fD#NDZKA?Y0:73^LJR9MQH97](f89F(CfWb[;,2PT&+1F(P\5?_8BK\FH-
EPD]A=E(K-W-3^fD\W/H@c75#?X^;:b&X>/5L4NUSQ5.O,J[)/_(-R-QG27+cU;,
W44</a[TGAR8ODdG1,M40Ab.g9=&Z&YfL<OOSLW+KJRf1,c@#VceCY_3(J1g8C1d
N@.C0HG0d/4;AH=U^2dI&-K,(UGc[8d=2LN3&E7&70L=?TFY3)VF=(&LJ\:L..=#
?bBZR63Gb6UA;)C@-<JZL)UW.W^:Ge7&cP\aB8LF^@T(Leg_1.LTWXBNLNC]6YQg
)=.Fe@g2(aS6fC?cJAL7<D]&0@MS9\GH;f[6c0HF2&##[1eGOWd0#bUR/3^.H@Y3
S)9+5=W<UT+a<&U35E^ReXNaP(_#6\]WaD=CTJ(:8fFI8,U(Yf1&R-)SXUC-8d+X
e;7G-WTOS=c:V)=&g>W2<DN42OG?3][Y-2WEC)2A3:][MJc.,bV(0Ee?6T-LLM:d
J.-#9U5)2L@K9V>4PT;+1MWWT2bdd3P2KTM<:T<X=cYJ#1K7Rc-8b[#H?:ObDeU)
B1WAaO^SPRc]5BR@A5M9a4KT#ffDB68N?fP/IKW?(N?QBI6J1#ZUWBG]MS\7R3+c
We7>K7UE]GN3E;[U\:cPM4380bZ,^Ua6)+NL]7EU<<=G0>Q+OK]ZA=?&EfI##WRX
++68d5W)?5E8OI[OYDPGKDV)-KA-+TR6QMB6K(DX_-X@.JeT8N7,c[-e#QN7#DJN
EDDR.7O]a&-9^92H^K[:FSX8/M;Ae2..e=0FS@.FMN:2&;[fc9V(ScH:;_&&@POH
B?PfQKEG?2+S9TFM-Xd]KcFQI(AgN(Wc]XJSQ3#a(,2P,IJ72a4L)8XM\D23AQDX
69egA-,ZW,C8(J-PSJP>YASXV4U>WR8eA?.(R@>#?H3OAA9CO8DE3FH^M@MMLA,T
\<1\KY/3+?F(FU=M(/;c4BeO>?1178IUJX/2)1_FgQH;8cU99J8fVBfS?B5U<YaK
6]0]SUCa_g#MPg8&^POeJSeI3BY7BS&<>E52Pa5_/e+9LU(F#[?-.YB@DV4>MT;;
E):@U44+<\6/eEM4G?a)A0;^dQ8>=c.^7R1EK0CD<2C+/V#5CQS.OUb)g2QW4KD_
:+]_=&<1M)]=F,9;K^Yc0?abgYAYLd];8VcGX#)4SX<Z.HB^AUJHD5DGgCG/1H7:
>]ELQJ>9;8(NR(=a4<FL+\c6PK4PT.S0Vf&>NKdP22WNEcbM577ITZ[GU\N3MJ:7
@M)J5_.2H9J@\8VF-0)<<Y]d&]9:AN2J\2KdIHR<8_f3ReKgV:>/AA-\aFZeTJ#V
I._^EW4//W#;49TIaC\;T;WbJe\0/NJG<1@=W?LePeD,TPRC<F7^[GB]95>Q(0P_
?a_@8V[Q3@9@(EC_^?#0S/C]J+C)&R3/Wg<7I55DJb^\M-YL/S=RKWP2^HODg7N/
S2&\NbU=Ie02g7M;DN8+DR^S6cIb=BU,M=M5GYOI-FV\bUP=-#7b5gb4X?&K6,Q6
4gdT@I:TK5c2,&T[X1d(7F;8(-]L];]+R>P?#(ObH+^3E<;aS:2#=A=\\@_e_gET
]TA2XRd#_d4\1a.H+S@ODL-c@G:J#;b\0+]?8UUG[)4\-L9)RNd#DGU,42e.EABB
98.ZNK055WC5+/EK9eUbL4g:d8^#NH,3?3bO3@MR=Y9[_4eeH6+-Ha;d9.OMDUJg
\.\7=J>ecH;45O#LSGg&P4-I:MEO-((9S(e&T3J/Cd4A3P79FR,?LQJ4,b5O@=+7
\Y8MUKN]8=H+NA^@gD(2[<FB-<\A5aR[Oa?AIBdWK=<G[Xa1?^;+FdR;.HBK@)?>
-V;BIaaZVggZb&+T<gZTY_<4?Bb(A#.OW]/5TfJIM;#KFF6>S6I,0>,,(89P02B=
#O.PUN,^Q_>,)Pff^G;VJ<W;=#UYe>LOdF8A(&Y77e^K^\<6:]M4?=\d#CV&[V&0
:+:YO\(Z6.?.Y87)I]LPP=PM:bL7#f/4+5Q;N+/g1DM[SQe(Q8R1K7#?K8ZZ6fZ=
7?P^RQUL6P@5[=K+a72I\&2\8(H=OPC2ZY1B2[D>71[B1g=4476#eLB)Y]##<W8+
=_E#K4XY]ZR(d8YJ9/#QMFWY.7cA5#Z>T05?BOBe3H76:EN@_a@,H_JII>I,LTE-
KD]CE2TLPd+]O2P))E\8bUb27.Z?A3f[2_#OECHb[VQ4,AZ8M1Cc+TV\D-1@=A;;
I\dbX@/(7&)B(X20-f5V6&.d],-gKfA,CKT_328A)<M70bC5QV5Oc_?2RQOYA)a3
K37[J2e-3d0:fK;J@CcH&#VOG8-IVgB9e)W;48SDPRcE1M/H;)ET?;QB\d=E,UIe
Q.1e^B/<g=XZ&?1S7/4D=4:=(=/S/\],7D_La>^BF)@36Id#71L3=X7-#RF12U^M
/2^NP+ZK.RZE7=eN)c4DK4&-fQQ,K]E:EWG1.d]8a\aLC>DQ8VT4=+>H22GGg2I5
_9#LVX7.Gb4LEPY68C#V80D10cfA7LLY-7E5-fFX&1C_^@J-5)6HNA1_FOf,c&<=
#bW/JG3e>MAXP\.RKT-W:)GaZQME[d&S<E\XGJ,2OWa@N9EXRHQ;VfKV5V4\.>F3
/_?DJQcd=&51P+,ReeQ,gZXW9Y?fH1P]/N5)]^T/e1BCbP7KY,eX3H\FB_48J?WB
d_((L^+bNF:I;(6/G32L24H[Ff4a7P,>Z2b2]P,^@H@]2JOAHGB8IVWE[;/@JOCU
(f2V^Y?0FWgWVR-NY>A0_;b?8NY9faV[5;,M(fc,<7aT;>4O-8c476&?@Zfeda,4
X30(\^N9M#_1>7+[b3G(<+)Q5KA<8R0>GG2Q&1@74(,BGP)PR>)K0RD^[^Qf+;7)
7+)?4+Hf,gRT[gSPVCTV)?_#&=S1WK=3YJ\U1WS&?:22OdVK9<c&B[9AaPPK)=Ha
:g5e/_^I:PI(L,S]^]&g&MTEG.=X]aS>6+(#HGPTRUTa3:@@c(gb.=&(;3=_DF#_
>+)dHTSYG,gPZFGK@IDQ@D)M49[Red#@G(I86C^4[]EYOZE,I/c)\I3KHJaS_&Z7
MNJJ3Ab,D&TUcH08d++@#M@^L1/(JDTa#4_N)=321QG&-PTRdQ.1RbZe1[<C,4XF
:0VgGfb/CWNU[H@\Od:AWPg53FC+N2.Ka/60IR=I^YY&=W.b+@;e:8ca\8995@Ce
\GHWW2BZf..g[.0S)4N46-;]NUe@QFS1C89NNW+3&+6M=8]C7^&C:e+HC/IdF0aY
;)f0O)#KJO#0@G#CFBg3+NI9dID1e/M:F6]QcgP0(R](4+IfT:,<dQ04a>C?#1c.
3)fBcVJ-AJH&S8V;IcIf;4R#f]dVa8&BWB[FV?HY@9&F/.7&155:=_.#d,=KJY1g
XHM?72CL52BC;YdM]OWO2&/J6e^7JJ.0K,LVSJ;8\_+24\/[c^.2E+Rb_Z155<FH
47-\YZQPNB5Ue8L6VfeT\(Z,/420LQ#f>8WX47GfGCA=)R&2.JaVRURc#]IAFa/T
g/S8OW=VJ3NIb#SG5fH_WDEO\_M6+b74(NfO6U,/.Y.QW+-45&F:T.V:\MV]#gD2
f)\)=O#24M(E)f6+3+H\XGL#QSEeRTc_;3S,.R7S46O#e,(,^6^)Y78YY=ISI&AP
X=Q73+CH7ED8/GYCEA=6/)5ONFN^)&O#+WgOZS64+4Z.cUZ(5L\>\EG9S;c--FA:
:cC^53\EbP>-)52:R3#+WH9URL])[^EE9PWE&[7<WcbHaCQeeHgfVGUH)3:.6MeL
Bf[fd\_9MY.Udaa&?]I_TN;ZLE;@cEB)Cc63@]e^Y:;MM3.[B,a#;)[JPTaT,][8
+F4ZHH9/N3;0(Z64M;6HM&EZEJ(J3TQd>:</^Od_@3H=\Q62TTFLKcX]6H+.):gU
+FFYAG+&]CY5WT3.V[#O-+E_\)_.1.Pb#LZOdS<I[aa^R+;8U>8aY_4]:5Oa>]A[
-6#@8:B=ARQS,30G8CSC2/R;Se+((,(K]E9:&4+&H268;1RT.cRC<^fI4ZV9N[gF
TXcIXM5XS.aY-LRRGBDSI?=_QeY7&d,b^N=/OdaX\QMCV&=O6WX(1Y\0B.<bQL-[
#+gG4.1@HC,_EZ[O)[+geO=f9:AE+SMD)>]LHO@C\KTgCEe[]1RH;Sc0Z6bMb+Te
.7-b:feU]<H6^He][+Je914Za6)@EF8Td9?e2:1LGYf65N85Z>)86B?/cO=S^[RX
BaRQ^>+TXeUIM.H-94[O\<[R-3#6.gfMZ#N\_2AYQ0V&S_ZG5HBZAI2Y.:YD=KIg
YUVAf1(PM&a6CaZ?MU0]<-+[(S&(JB66R)O]b43+?:]LMb+X<KS4:-H;K3UW^940
Ue]S\:>TEd/0_gbMb,@/FaY.ScXR):M4be-8aMA>?)M:JgY(CVGW2KICa83(.3=:
@6@F&/9g/,(4BKQ27F-P[LYE,@/PL(?L&3K2RPW#HZT(5/WMYP#?4@1EXJ7.gGL/
B;:FbJb./f]g;__@6<5_UY9:XRSf(01\>>f6]72fg/M=dYQ1(2QSBE5G&J.]3Wf>
K,)R<JR8e^7cgC/VeVYAa[7](2Z7d;gK35#:X,^DcPG]29<?76+gQL2IbC3WKC.P
7=@1Zf0EOAd=)GSR3O7(O^3V3P32J:>&,/.)ZR]c)K@,HXNEKgeV]cMH#VJ>2=@?
+)LH:?:J.#ZE2.L&4Q0d-b3bPO#N,G;a=H84g?bSQ\/91NO@SZ<5YG?E5XSIKUEU
?NRHU/6D\g0DW6QAKL8CaP#L0#DP/\bR<Z^bW.HB.X)7(dK+ES#bgfP[^V43WT&Q
;V/U?:G)FZe^]QYK9?Q8Jb\ZG9:K&+NNGR<D#UT1b8/[CVWZV:US7\X7>QbX.R>F
[6(58f8JT0a1D6^.NDPY2Ue@FQRG7d_29d[Y2c0,LCBg(@RFO+IQ#+ARXF,cL@d<
-cJ-G#@M7RZTggC;SWQO\ZfB@S_243LSA;O@68OQLRWNO^fF;+\9#_Fe:ESNF.Jb
Z\TIC\MXDHDeD?eJ-IN.M5FUN.M+FNEC,N,NcH=YcgY?R)7Vgd]CWa?DPIf8K]+>
Tb.e,X#01CA4QU&cJ<e,P>MR5]&J#22IZKD\GDMg=V=1d=_XIJ56E]X5PSIMEH7:
]OKEDGOc;8c9V)GW2L-;#N88<A\I>W\?W+d#[BCMH6_MQQ^?H0f6-_RdLLG:&U[)
.0+Z,HK0>U8_g34<BNRL)#:.AXA:D3[M]>A<SI&ccB.I8L#OV.TQ_eNH#2;>-H,#
EXd&+3\8>TP0QH)6R)OFE_:+U]P/E.E)g-eHT(9&-=2]0>W2XLd6@2>USJOVF/<=
/H/]G?R\K2cU^,TO1AB=+bK^.+;a(Q[/@@MAVC:;A^,52?5E+Nd_;CTg\8aUG18?
TUf9:[1+GHc;LIb..]Z_(UYe^fDA+2S&#,bVg6)4@<HO2SW=f>-PFD8KOO7W\(.4
0>6?Gb+ZZ)4#K:L.DWW:2P>0G\>]L_(Bb:9fO(XaS1:][R]#4e9c)-b47.LC>#a)
V]A-S(?Y.(]V]C<OK_ES#R,SZbQ9dY8,2NWZ1N;6d.QWASHM91L\Jf-#H<N:caEI
VU02V^Og/3V.,-^U[()^UQ2DM^V81ScH7[^L[HVUVg(K)L@CZ4M8^R5E52XWfIE2
M3bVN;=(CTQaGO/NRI>??=dO&1gX[A-D44bE8BRcD<cf6PT)T(V#a+4[>WOJT][S
3?NIHc^3_b:Y^\g8KY/1Eac[EX?DIN4b73ZLQL7DPYXXZBHI?G.B/;[<_#[J\=&N
E6C];T^+J#c>H[UC)3>[cd3B=HTJ6SXN>WL+d@ZA=C+[F+dWd4aP<^1-JH?a89DY
Q#EY_-V;O^P]^:5eVFHIVQSJ2EI3&43#(Sb4CU&RJIG;/&<BC2[_1g7I@b\Wb)A7
dB]]d1[\-,1fCE5cY/\G;@bGYc)8_#1EP;T2:)d\\WLaY:L1GYbQ7C3UG5A?J.AF
NFV9g\@ZF54L,GT5c52M)bZ<UL[&<#<\OSX:C-/52:-IgA.[0OL3N-:6cAd7Z.EL
60)#9X_EZd,ZLge@<)3;eM?=A6c923aXOATG<ZA2&AWCXGXO#>-N)W#A#DgM7a6J
<^\N1=efAGg#O17<1Z.(Z@(efY<QeV@,;4S.d:JfGZY2^QbAcDO3?e>(<b.Q9Q>?
SfeWJ\@]a802;g/?HbcdN-6[VX]<cDZ?/Va&[bA0EOY)\=7RHSS7a_MM1W&aP[SO
8eg7_IU_@,VYX73(S6IJOUDBGY<a>-&2Y>b_=](_J-_;L_D83)6]Q.?&G;Z>YY+7
,/Rb^ZV8;I^(]Kf?BPP3;Z<eCb/4URWME17B_,D./]JW(Y]f25c@?/7O(WgOG#gQ
9U>=^X##07[a::_@c0:[dTG+Ja]TO4/WD3^A2\BR]7Q<10G[P&B]I7&CdJL2H8I#
.LZO_VP#,e]50)3A_JD)KLO[4+gM#+2edU]/QX?Y[2P(.N\KN?bI2X[]THM;WcgO
;6b[,T>ag<CVScF5(RbTPDI>KBKK@cZ&I]3/1/?<JM;UZZ+a&^<g_17)@E_c-b>(
gT^Y8P@E\:,AQ&94//QR/NZ?ZQ:GSaS,G[cZZTe2XN>aT?ggH3#[5#T</4c.3YZT
U#eMLXG9KIS;RF_JCa-@?Y:E)@AM4F)\c\e&AAL6H\@CO?GcNHZ2B>bVO\UM@#H.
I^9_>-Sb_QP702Vf:U@,3^#.SPe6W<Y1bMSS1FaJX.fCP?I<dQ_X(+VbeeWLT#OG
B#HCTF0O9_0EOGeN>7B015,SJ&B^CM.6M4\DAKH6EMDR3&COU&2)(5\0g:VYg_5B
+bG1,E+BE]U)cBC17,>LFFMMFNO(:P<8J_/G0PD<E42&D9+D)IOAc;a+M+^K<E?#
Q4;:\D-7C/I88(RGIR=C_)_ddZdUTf?[?G6DbG-C?fg7#;P)aS5,]da.HV4H:,DA
CBe=E.8;KD#4JL6.4J<HfQI]eIM?E&7KW5?MXG4aTY32?N7)S069=B[P=+:cV?T.
>PW@M=aDHX=9^JIg[>O@Kg^4P+<19(C^Ie+fYWN8WF88C,P8;Gfe2>4,9NT9B99K
V</RTPS^g#HO:M+^dRA.&]VP,RU\W_/WR\>GZQA1F?Re6FMQbXDRY:OfV,?3:HE;
<HCGT[fPC;e,9J1D+4&@X/T[J7&>O+NS=b0OKO.0,fD+<2V:H/HgD;geHcKZ.F@c
<&.20aVea;#6=CR#4V4_f5[Z,5Gfa?c(5TCN6AI9T]=21W+0.DbJ+^HdA+NcV,0:
,#-J-&5e[bI0(2OcP^:8ZJ-,YI)Q&E;GEI8VBQF;Kd^5Z0@7J;DB1XV&&gC7Y->c
ebeHaR?NO9Z-BfHf+&:fVLHJa@Hd+4OUYL]@A\-RgG8=LfLX#gAYY@N9aB\C>O\H
C:=PC(.aUI<ASY(6]N8,Zf+\4d;E2g1I78Fe6R41ZD0O98UD0AC#D]M/gPg]+^\<
H=f02Hc9/N>.U&M3PRHBY)\D0:.9.=.KM9VUP.GdRQ>0GB?JH(XB+G0XL4QV_Y([
0aF4S=H5.BDKGHF-97cLGH>D26KL=IPgDMN[,fB^UGFfY8C2@fc^1+=\^TXY3Bb4
N=XXN\/f?DXg@M1#d(&QC[9NOR;-\I[S:)PU&:>GIe]6(DIT,,L6e-BU0WR#8>-F
]aI)W6dd?N(=gPb6AF@057K:e<IA\)_[&L,e-XK\DB-YVec4_=RI&4(Kcd@D8I;:
?.=)Ng72E>U#KD;GNBdK-L1?OAfe3/bMR^g86X)[KD\LT:Xf?-(3XO5>^9?YKYGN
VT9\G_,g&UYA/XWZ(>6S[eYXa9.ZD9]7]F+UV9>Q#C#8cOS9g<]J,4Z>:8=0^aO[
.[AX1],7ZdS2-KHK=aU:+;#)6&[2ST9b#LY8/FIcVYP(Z)=_g8UVKYQaPG->DN7)
JPXQDYe_G+(IS5_H_;)=)8N.5N0Ba<7RFQJ=WGNYJa8-=-f(IN5BC?AH)T-X4a+I
baX(Y3cI+a>A(7Ve09_dAF;,0ZS2dEHA\2QJIL[)TBBFgW+.[,aH0<?RVba^]SS0
SIXa0RHD\5?T\(=Q:d+BdG<2OS+bZV[84YH;E?T@<W5a.S[I?5;3g#]&Db#P>d>K
;C6.>cf6[#?Z-Wfe8G2(df>_+=eY[\BbLK6M7@XFS3c>>DZF1X7ac:QVZWYf^cb7
-3D-_#R&Q<#6?EY>)]2A,P;Fd#aI+SgB&<)94-AcBI2ceFSc-H88<B#03NeTgUYR
QaH2d^HJH)]R>DPU[<<HKLU1bP;DH0/+7>6ND\-4CRO\3?EK+AO?]D+-^8GF2=J)
^/#OL7-ddRHSg9+(_0(JCd#(30ePR47]4\c<;>@fGHF_]/HeUZAdNU.+c-@aLK>#
L5HDFKe;KDH?&(Sd_6(?9/<6M5c?Z+Ge]06WAZ2OMZN5A1X04)8A?&#X(.HXN9#f
+:=ZO,L[cFeAb&Y691D&+GP3:FKLR_-)-6U,\:\OTd/D4HICK=H+>S\TcYW7<6)@
D,+649BA+-Ya^R0)gW^>1;7+F^#UD.[A[8fa2VU8W30@J_B-_2=e:-]SBOTfX7fP
+1F4?5--1YJSM&.2_#__IM>75;Q#I5T>D8N0;5]cF,fT3b4>=B^^U.BY)3&e8(g#
3#LZTbO@a.^#BGN>aHINK7QV2)#Pd^B26RQZT)??g=bU(.6Z[;[#N]H-IdFD6AYB
=/Y^]:]F)S&>Sfe+P5#4V;W)bLJa7]gEUBO]72@g&/dB;e,c.WF=BdM/38X4,I)d
[4(]5^+4:R5d5]C61If3D0G>&W_,O):\KC<b1b3g@DIa\/HTc/YQ[,3E?5;<<,,O
_1cR[(=2WJ9PF>I^Q[JGPR>d<:[#4N3b\HZC_Cb#+(SSD(6[H/XY(3C)]gcBKbO.
(;AU^2=Qca#eNHdBd1FTY<PK2^/.:3G3=G(;3V-<&K+Va[g^><CIfX#P\N;K:;V]
/]D0TdU0[?=#)@=IX[;(IDUHOY:I1b\P&Y:6P\1H1P6:M4I42XEW4B7FB6-FKfLT
.)6&c&#2d<S9D@2CHW].\F]+A(I5QZ9Ug7Q#SeN0O)LUPV+<@=^&6WFJLGd#LBDg
,82)&a+LAZD)OGIN(A/+C7-c(YZE8#F(e>aTZB]=HHJNgJ.3\V?^,7Y_+&J/1.BO
Z(KCY+9MI5#H6LL#WbCcJFgCEY@F5;KCWBHQ-AZ#BA-X.8Fg..4BI6W>40MdAa[M
7+\eL;>cN/@65FGaM,R&102=Z[[6_RCFWYFSZ;O4HAe4WJ8]N@^,2#\?5()N]KG(
MYg>R,#J9R68U?:V#JgaU8UT<5;AbVHZabW#e)7^..W=D_fI]4U<W0?;Ycf?U\\K
U_P45[YF;gPGRALNRW^3?-LWN_-ZI-9)cBW@9\\1L#2H\feGGFUY/-FWXGS)9JCT
2d^;b:GFV;2\PaRR=1PY30DJGI6,LY=TZ5>+LAJOF3Y6,EFRMG#Uf#&/O2d1[(F-
NY^^E]UFU/#W#=EUBQQ=FJ-9#=Z)\J8JY-_B#];@I8<VK]PU3gBG6@_D8FgT8O4g
N.6dCU;>MUD-NO^^bR(2TbfF]CVZMOGTJd87DY,)5@F?W1)88]E_N/4(aN;@FR=Y
1YQOS50SU?[H&[.NK7G=QTgLNe;1A&d1H<Y_H&15ESGVgTWL_O=gM[GYYT.d(SG5
bJagPDO=RL/QY;>>HcegSZM)\P=R;)09b[,:aTCPC)0-=[P_0F\&T4/:I\)gd0J>
fe&]4?Bg@)]g2dXca?GDA0OGHM97.WF(c,H(:SVA1Z/4:Y9-UQQ0DNI\PZC]64QI
W<V;87c7XF[\L+&;IWdJWWN&]-,dZb^?;dM\<Xd@fR[Q2,O7\TPVAZK_YXe]5=,;
]/&dV@AN9H_SV87PFN>]GBbL=6]\AX3+geLS@U3f32_<0SE.Q#[LFBbY<DS5eC^8
,b2cAM]:,g9:Cc4c?LCCZUBbL8CgGEcLM20-ef,RX)^)N8_FbF0e)/J^71L#@dLB
58ZfX?Q?74>R)Db\JT6^f<;SgX;GP9F9CF3c>2>INV-U(g1:49d6JV/\Bc3<F=3I
T2[Hecd/:SG>H_(A@/=K9HAK<Z<M\U#Ub>EfZ/=@;EZL,Mb[:L>6H#TWf]9_KUc6
\N3^<S?5a;(@Of[0:YFC6[)RLS-W,gEK)d@bGSKU@@_83N8gF9gcFfB<K[VVH_<X
<KBBP;6bHMgO(gMG;Ced:=NE=;8Sd>(TX<CM)T[OWcNL@cAB4IffNP4fRH?D_4.8
@KAY@NV;0L8R2UGM:XC23cPbZ0CJ@6bVcSDO.LI9efLH/3FeU1YI^;YOZ)#F5c6J
#2XFb65Ic;(0=9#656L:>a>[a:,M/RdMgUL78F5Kd:J32Qa/5VZON];Tb(@agPLM
KTc:Tg3NCQ7W6RWGVD441AQe7.7RYPfVDAR[ES:NOYcYeCC]YD4DM7[,KE]X=J-=
+9OXDFdBYFAI^,[#82_]CWb7.&NeV:9XUN9e-.Q[TY4abAL0MDD@WNSL,+F&fcEK
XQbF)=R:Za\,AKV)Z6BSZcb>,HVJU5Lc,Qc9#9SI4=UNW]ab1.97a3BSC_6^a\Y.
7W_,TR;B:7U\2U6eSO5NK-I\F2I_0aIMBcL;dR+3ffZ#1YRH\Pa6DB2T=d8]TRb,
^GWI]+2Eg#;<gaS4R.?&/#d]Y+;?(L^D=]49:DbBB[FFReX&&G8C;+4e]<aUgXQ[
:/1E(f.K3OP+2<)TGN(TP,7=UCW9fNCEF-6C#,E][\:#HP,//<0U+:#?6TL,fAVU
=I=5:;+C?V5c87eI+,FBcT&#TH1gEdRaV8>HBHB9]VLf6RB#,2?Y9PN,-\R793.0
C[_^78]SU[MMaPbeYO+::ePVRV+TZg@Q(>:[QB)dTF8gHM6)<,Q?(P]G)bM8]RB9
OA1@)SR/;9,+Nb7dZcbB\K>][bD0Z(_PK&9ZPZ4/L,(=e(QeI35RB;+EH,dF49R+
aC)&Sg-2_ZEWOYgO47/Xff[OLNE-77<^P)R@?;b1.9\TR(b2ZaDc5K5?[\&H>Tf;
1Eg_1,OCR4MHO9PJEG<f3:bcBS04L8V,6K:&3)T-3Qc/=XaH&7&RP?5J?YRb1P;9
SI#XMAOXJ8+@V()5RM#B43\eVD5[d]8+UQd;-@[2LZ0<C&HMI.JX@IXX6UZPB_G)
];IcUU=?:bD&[Rd1DA@4:N=8B_=_Y8PA=?@+I;\FW)V/5-,#+/D?P3(bT0BMaQ8R
/^@2,:^=+LF_?g+^AKD>JJ.;bR+(KTZQHM89d[\1>2I,<beI]UTJ-3-cF.T3-J>7
9^(d.=C[+[2]CO(<2d1HBGI>B33?+V\14+9@BTJ-+SO^?2b<.6TJ=,R<[bBbQ1^?
H6.CYc\(Xf(FO35UP6GE;=XfCBE20F,?B:<D.D-McM-ZD,d;A)?N4>D?:<ZVN_FL
a:T7c?_^>dcaET/Z:8QYR>WXVF06]?C9G<HI0a9AbKZ<\4S>b[C4512c@S<(]SZV
BZa5?cU8.FGPM[gFI.7&D1gMSMg)W^[IV^a>=2>.MJBB9Fc02gB=^-UX2S5=,6_9
NOa#=fW_6KfG6?PEQ@FWMHU8Hf[WSM:LA5)G03N4-&VU064TIc4]6G?_59]GP,.1
C@Rc870;=GR_WE2MH95I>ff,M-fbAd<)H6[8#^La[Cg;,:S[<Cf;#+@P=3TZ7\TX
VW0)3VJSa7RCKbePN)>B0;JA-,78?+=e0,J2Q>[7M,g6<dXcBc4?]N0ff#b6=:L9
;P22b,N/VY&G.^RF9C=&^;^&aW5/\751dH)RMI\a-?=U4eQ/Mg6RSZTK?Y3,^7-[
4A#2U?Y=IdPL(QOJAf_4F[S3?JQ2eNR3FKa]IC2MaXcLQcS5O:gg3<QG-5(d5;&A
#Oce^L^VbY-(&eQ5J(R&[:2Mafg2&5\WeMW;D?EbF=4gVQ?D/eQ-U0&)2/OKD#I7
,AWQ<YgZN&f-@)0d4G98L\YV0V0eX]>]AY1cLHCa/c=#I-a-A[F8JcNY\FLF/)fQ
8#-?b9L86JW2NNQ)7J?d0UAW1UD#U.Y<KLV;.2L?_2X+ec3JD&_\ZZ)J?A-..cDg
6=BN>HBI<[?H[:ZH?O-+J1=NEPY3&M)Tb/PXL>VZgS=e:WZ,)N@7S<D4U#@_a]bA
8HM)YB6&ZBC>OfL+a=VDF7c4RSO1D;OSNVWD]d1fJJaC#A=a9LW+/#:I@IdKVg7B
<CP;BA<OU&]Sd?S.UdT_eW_INVG9NX+DRF5,3S^\-,-DQ)+ZF<7)eYPOdbdGE7HL
](4DKVAJ_ZR/4dD99+6eRg^7,^cH?B:=1&L+C-72E.S<M\WEA\PH52O0-NfX/0S<
eg+RM:M?D(;B6dI4/F5C_CZF-T3A?4^O]14RMLZ;-=(W.1)XFS_2MB(T@C).P0E/
-T;]@.@->T7)CgT&>f(\;:X90PZ_Y<O],cVNL13GYC4a[B(fc1\BLC8;)J(_fA#@
JZ]dLVSX,6ba45.L?/DZN4HbZ0@_(P5fSFCJJ@[N3(-@/eN?PaT?Q:GZV9]HIcda
?OX&>?02Gd)GBX+JJ_M8.Y9bL=eT;c>5ANGdMO>9=gQJIT[e,Aa8a:054F<B;V>Y
QI[I6</\LOE#FT[:0B(XWX1.7QUbODUYHZMJ#<P,]bJ+H\bZ#,&Z-T@&;<SdG7SJ
AER3=)^C7R61Cd>]^YY+U7+[#W4O#Y&P:\ZR0(+B,dIY((Rg]Z_??d;>AbaYSaQe
R:XBQL\2.1=(<#Jf?-B)2RbD.:;HAHK<L0a?UC]E?JR:+QL</:,_g+)WUJN9bTK]
<WY,aXcU];edF/cO/0U&cV)WX<JH53]M5.f3g)=XbDe>d>cU(]Q\B?cY&ML3<T&4
-U1NfC>,O0T\2)?L_a0)D[\<DO[@_O\a_IK5SH1K()B=dRNd8=\Z^F1>O?()+gKO
YB,#,G1,)ZR/CH,(E<N82Q#PSK@BGYQEVRb1W0IJ=:Y)DF@Td^E@dQMU_1ZAU.)4
S_Od(O[1dZYR0^V1Fde@#B8G8WEPNR9^>c,T?IXWf@5IegPe1-O:a0:;IDT,2Cd2
B_Y<6eM70UJGLDN)dM0?B7M_:AVUd^O#5aFd(bJC2cMV65GI)f,Ha]^<\7[WHV@-
6[6CN##+4+\c?/cFQ?>T=,(aOX;^+()XE[KJU^R4F5<#-8_[[c=03Y\HIHBACD(W
D+9NeH+G377Ld5d&B2a4H.V(f[[8?9.BfK,1bSIOS_.#Ig)UV\V]VF(QWM@aLUJ4
U+(HK5RaRBSX7@PST676J/,?#&;[7,8J;)GZ_bG/b/B865_UBP,bK&7D^DW&8O4I
[@CTMFS(P3>3>O/@ZPJIe3&=3ZVAIP:3#PbN>)+2.+R(DQ[)][82.]^F)AJ<bHZ@
,O;JO)XU^.ORc9FfBOPRP4?bK;4.e6U7WLNVO\..W5+/I6MNLJE3C&aQ?VVNLK(?
fP)-2S7VO7.UE=/AGNfY3;)/:;+CN5Z_1-D8AOBC?75);08),R3FZCC,OZK2EU_V
MP)60_?B/f:.9N/Cgb0QUd:D&g-<<f&G[;+UE=_S35T<;H\<b<@GYbWd[-:9#^,^
?Pb^.g<D5;-R>HPB-VEJH0S(,[F?cM[=_TY9(S9a.12O3T4f9N&b]#b.:?b/,\LS
)d(7_/fMaI_cSb766D=J1Q#\-T4E818\=H<L7T\;dN@ARL5[De/(TG_UMMJW;cF1
&ZQY/g4G]J8>5.#YeUd6HI?;IP7?8f_NC@aA7,)K@U-C)RG)@.F5JSgN-#M:g@a[
#cF5NNbO9bO3Ca<IgB[dFB]cUe>O:@_IGQGA^,P1NQ=U>@6W7#5IKgTE=3PC]G4E
NJYd[IBPBe,[8G(U\3O1HS/>8G&g:5Q7NK=)FA]d_GS3ca=D?Y6QI11TaPf,5YW_
>@^DBP,QbL:DMJH-g3BcPfH)Q-c5,Q))fU?(M<G[^830O5FDfc_N1cgf;UK2:O(I
<BQU6KDNG@S9d3W_02F7^KC;,\V?\I4V9:NHb;1dfF-d0)[T]&eN9U>7^NRLWJ3W
8.ULc+3&W@5ZAK8f#3b(9@bAY@OcXV_:7a0Sg\[TG[1,eX+6]NeQV[cIS^#:[\Bd
II[P/E:(XQ;XU=,aV;K4NEVWU[3g0c1Z[dJAM)M0A0Y55\C,TE]JTDb4X6U>->0^
C]cUeBN&H@fEa>GNVDWNI&d].8A.9_DZ1RWE][\8cf=>^O&6)MG\Y3#R[e-<H#bC
MDJEa1f?C#\-@W0gCU;E#6D,7Mc1Z6Bg@7dBZ>[e;#A8CS,YDcMP_bfUKA@Dc&I\
33H0cZU-X3H.=@DSL==90R9QaX;VYdICK1SdN2I&KV)S^(\Z(E(UNcS5-@XR;M9R
FW2G^<QG:a4F7(>PMM/8\eaJ48V?aZ4&6TTeAWZEX6fHO+5f9@E@O.T)C+_AXDPM
O5M4.J+SDa,G0\4ZR?G)fGR<J?3G4LXB1#eC<0TJ3/9]7WF\13;N9YP6cW+eFd@2
.dQTJYLTT#6C1CHaNYR==geAWA@@H][3DL:5Aa7Q:KW:eL9N7]0)F<:MRLO+H_4^
C\eU2fUb;QSG9Ddg,PNK]G<8;-=@(1Y4bH6[F&/Mb+,4Z(=G6FBBDNZ<MB\BW@1&
B[<F,WA&aT;@H(#.E->0J^.bE4>g.0#C<L]UP0c8@TdW;LJMVH.AZD,OZK7gU&FV
0ACS:S;cX9U/P=CPFE,b&8MQd6>7#UEg^K:;\Pd4;e])2_7FGD9&A<&(BPU1G)8;
b?a<HC<IKdY>GRe^2:W:P+9MSaWJ<.]Xc^^V]WO9d>?7HY[McXYEL9JFeGQ96T]\
U45eA9,Y=VK:H4&Z96])?@OdVf#:Vd6H>\&(Ta2eeF47<fb3R[96]>PXC_R&,7ac
Y5=DJ):8L80\)(J]RE&g<YHFPAVU,8BN/ZY^3Q3(+]Fa;-<\gd7K@#c19>QcHMET
&>R1^R/_]Q]#E<T<C96[6M93VTZPgL[I4f,]@UJ?^T&GBbU-Z\OWbK&<g)aD7E1A
Q()):O_95Gc@DYd=ZgO)89>[5#):3#MH]H8F72Oa+g/ZVTQT3[.PeP[+Jf:e[NL/
<&a7\]NIJWD5UPI6;E8B5@YLaFT,M0\#VaMC3PXJ;1f[A5gN0_=cD,H?]QQ)<g(K
[eM.[043<<Rg_7Y3,YXGW=D2&efL4AWIFdNPJXO:1/Cd&H[O)Lb]W8PYK(B8F.bT
0OE1c+eO^OcQKY\d?C_fY<DP;8(4D/0\7+0Q5_ITJM<TFC5ZSM/PfOEa+HEZVAe#
@GVc;J;7A>X[:aea/F;T@OJ=RN71b;-c#\I3g^Tg.:P-Y4_\TM6,/2CEAC.14862
aaEcH/Wb?>PQ.APGXb8C:,;@Y]f^X)0MGc:)B_9/ZeR\,F_ad=9B78UDEg(K3WXU
Og;6>G:=Wa,X-fE-PaLb?E2G5->)4/#Zdg3b4e\,-Xa4N2?4&M;BCKP=->K[8D@B
/NE8@a=Ta=&[(-IHF)f68_5c\,04KI]F=RFUNW?5QTCGE,:T/IY)Z5fHBNgI<U\K
:#([AEKEcfYY)H.f53B+[ZHK07beP]-O)W18W.YP>>1]YVY3D.6LF:2B>81G9c9>
SSA<2D0B@+53G0#EC11e<3,)5:AXU1KKR-4b43ZQ_f2/\IB+2FCYG[#Y2#3MGfH;
G^Lc=fF+]cDRUXcgOD_#8239]^A]P7&3,5;+SR[;:O@628_SOW##E:cN(KP[_4>2
@NUGg)=bYC;cOO@G-U20BR\HT\YbVRKQ21PC+&9\3H)&3HfQ7&S&M0ZHT0B)Nb@3
Q<[OLRDD/(<PE#BEQIXJ<2YQQ212;Ge->U@;FX2R7&>A0S^AgWQ>B(ODIWG\D_-I
\@Id/b>\3EH35(P6\Y7]GF,EO7<C8b0gQV]e9N2C2D^A/5JJWHPb)AEgb+6;^9TZ
Y,J51G(8=\3cA(f&-c[T&)?S\4/(JZL]7C6-+PW>DF91ZL\X/1WL8QZ0.0ILU9c,
HP,6c<F40,I8:VLG_2<f4.K4[2LdL8>PE[;J<7EUe6K>:(LX15SXV/X=2c=a#^Gg
X:,&W>#?@S-KZ8[9dBBID8MPIVT6>7>,2,J>\1Xa,ba_EJ:<GQ@>-Y7d(Y@=TH0c
><1bJZQ<==.3(HHZ?ODf<0VW;WUP]3)/?DeP\5?6;-Ye76/RcRX2TD;JaCOH&?R]
:;fdMT1<6Z58T4a#4]DO0WO_18;gaMP-7S,D[=;\=gW>O-60&=XOCAQCbO=ES>JI
/+;T03e)^&5B))T:Vge1+AE[IR3EZ;fE49.YSZ2XDCcB]Y0:=PIF8F6+KHYMC2=P
-G_);CHLPZ6Q]3Q;I;[>=^-6B+Fd42SNcNAY?e#=[.g@7@eg&O]I?]E1FX/g+SO9
Of+59?c.OZBdg;Q>;P-#;HQF&+GaKdfI:?\OE@P/0I1[aZZ-cL\Q=eSH;D:>:Gg@
32E7)#;dbVSHITB>O,3#F/e-A?JN80-<[.D&^DPOBdfa<^KPE8BGB?X1MUcD\ZX3
@?N6d\19J0\LVOE/dH6?;<AEQ1J7#Z=,f)\)gF8Q&JZaSKHF7VY,=YebMJ<+IL]_
TDOb>>;1&JC@ACS3SMO948VPDKZ^#928c6g=PS0QSS((0/;QIIVS7X.]aa+e<I63
M=fKCMYCf)AOEd[W>-XETc]Y2W)SdWaB=DT\6<0dFG^;E>/R:],#MOdTBJ9F4/MZ
]GWA#V_[ATMO2ELE/O^ML<N)(2(V:@4R&2fJdZ\PURSU8cP4RcVH-GVYSF.O=G?@
^IO6Q,3KGPO0QQK-ea8D&c<K,E8\@E&6a:Cb)QNK.U<2IfQ+[;CSH^ODGN)(/H)X
/(L]&^G7]4S=C2,VL#@LfFa=E/)g2+<_C<4U8K7NDO6)?T;W\3gBDK2L41X&[ZXD
ZfCK^YI2Vc/gBGW7f0H82fWAT?F5S))20UA],)6CQeHMa+Z,4Od6M-E:G[d^=I\I
CgYV<GRMN=3>_a+3_S_V&N]2b11[X,WgIg?#eE[.K31@,O-M0@MHH0;KDg[0UFV-
K&>@_;M83E-FG8EF?+ZZCeK=NZ_+5g:[]5M2Uf51N#cZYbF;)QS^AO?JPS#CPa>3
9(U+E:I&L+??G/(I7^:=S38NAg-PLR(=3&cgSS^=GbV.(1H<]JYP4.bI43(#QaQ/
]:38d;SPb6=U-_O9\2M&K]D[Z^NI3T=\+7gJA;Q5;;c]FP3M7X/IHc66?c[2T+)Q
?f=G/CBc-.3Je#3EaIR/)bAEHLgG-4]W(&?=G)7@=gEBZ7;NB])CU/JSP[14]\&Q
S2RP0\:(F^5(9>ZX@?4IV,CHO+,?=K7(U?OZLP@4.Y5dOF]]8C94W:gQ5#PCMDe8
A/:6Zb1PCTCW&dg3JS6e)\T)C3\X-Tf/[K-@\W(Q9a2.:<W&1Z\c@/,B;174@WHX
CLJ&63]8faVB=W0[c12RF7O<<0ddQ35(>5QV]eAY<(?]#@LN:86]JF^Q,2C1BD0)
f+ACa,T.__-_/3R#SOMA^CfGZfY+bee-4UL?7U7RV8R[cZabI[.[@@;DFQF-K(Y;
A0;(6[V-gDXb>RS^E^>P[8S1;VL5XH0^.b+1OR/IM/bX[X1#MWGHYW:cf9J?->P3
_fcZ4ZY[9\bH@T+TK@d4)J:U->[CGQ(\-eVT=S>@E_J6d=CLV/X_\Y69@8-IXdT8
[>VHS1^#]Y\J1eOTRIV<F5S?P.3>6A#C_gYTaE(RWOC,V5[K(f=LBEP=O\bJLdK8
VgAg:838d#V<PWO5^T=L67G;ZQ\Gd1M=-R91AfG,]YR\W1TCZWMN=@+>P),X-G:C
CC3WeLDgaKR+H\MO]Z;M,_9/<Hg=3,B&@ed_T9+5O@5IPf6L\IYc[?+6OU.E3:QW
<bR&KB?0)^I/Y;egb5SZIYZN@9TW/;&((SGY7SRS2IN@NSTeME?Q)A09[O0DWKEZ
dKXae\SWU320Y5dR;I3O)HV6.7UO&[V7e37O^cK/J2cZg7A\)9dS:@Zd>K[M<fUL
Q:aPeg9BgB?_OP5=L94Q8EfS#_J\#U_5c_5.=ca^c8GH[56B5Z.N:YX&HKc6],a;
2-@cAD6?9F_g7DAg#JRH]]d:6>gBU:@G)DR5]J@Oc]BUgeFOM7(fO:0D37@Q)4-W
A_83LMKB[S.a,cMM98SV,e#7S>J@LdFKAW-0:989A^dfZY0gX_:@Q0,4])?a.^/a
QK+U/:&Jg0=5/W6TVWO9<Cf#Q-9]b\>?#N8:f?E)NAc)Y9N@YZeU])aHC?2K@bXN
L6+[/N2^dGKA_2X;JgaEJ>6GG,V(aG?9GBR03@Nd;WF(LKU+-[@^GA;,b^9KT;4,
#)&7YVgE=W)/Y25J-e2QbOGA2JAOB_@(YXP2P;X:7TN3Q(V-ZdG.\^;@D>^RA0^b
;bU)Bc+E3O+<&29OD?U#]?Zc-OAW\X.c+O+BQ&(_MD^LF&V/Wg.JHH6MA=e5K0TO
BX4.=X^<g,KO3H0H\WN^7Ua\8\HIWZ0Jd-:(\P><PL515<,S\V,Wf#(C??FQ9S2R
bKU=Rg2\)+g5bB>cI5ZB-1GCGTF+)Kb_:fNI4@[e[2VP<.XLcYGJV2(CM$
`endprotected


`endif // GUARD_SVT_AXI_PORT_MONITOR_SV
