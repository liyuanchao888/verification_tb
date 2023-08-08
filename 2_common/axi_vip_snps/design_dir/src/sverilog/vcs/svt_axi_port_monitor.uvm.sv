
`ifndef GUARD_SVT_AXI_PORT_MONITOR_SV
`define GUARD_SVT_AXI_PORT_MONITOR_SV

typedef class svt_axi_port_monitor;
typedef class svt_axi_port_monitor_callback;
typedef class svt_axi_port_monitor_system_checker_callback;

// Typedef of the monitor / callback pool
typedef uvm_callbacks#(svt_axi_port_monitor,svt_axi_port_monitor_callback) svt_axi_port_monitor_callback_pool;

// =============================================================================
/**
 * This class is an SVT Monitor extension that implements an AXI Slave component.
 */
class svt_axi_port_monitor extends svt_monitor #(svt_axi_transaction);

  `uvm_register_cb(svt_axi_port_monitor, svt_axi_port_monitor_callback)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  //vcs_lic_vip_protect
    `protected
UWA)>gZ@UN7AI?<&cJdTR2B,[K@f#XOKYD>1BN+&Qce&F>_1FMg5-(U,6.7(\ZAB
5[1#8+4--KZ_:72;2E&X],RbH^/a,]Y#<Tc^3X0J<+<PW\C)(+0YRC5E,]+177Xe
;)AGHgYE.WZ+-;3e(VM:CM)^\A<(#D]G6=>LSBPK;<<7Y8g3S8:SR9.L0:bMC5MH
)+#+=Cf]Tb([Y7J,9;)5U09f??]RCbI7EZ6,.g5]6G;.HV7&N2)B?:MgcCW#Jb25
V^>)VBe;O?,,#&L&&aTO^:@HK:L4;0H34?J\9W9^1RGT?DT(L9F_-S+8.g-FJ359
MYS;NP742<W87<9^_DM[K#V;AQN7:)JY3/CJgfA>.<D.+ZD#GIQYA=CL,_>5[5@Y
A:c5ML0K)I>P/JX+;8-#4]BK/WOV9)O_,_KVK,gNIQ.X)bZ3XJJEJ9P7](1a[cL-
(X:]5U>7Y]():c;S;PGDZ>+Bc6OaHBQ0Nd+8?1Ic(L+-bO?_59[?]]=7.\PO/d[S
\+QU/^N0NEA4b@@0(RZKI<5<,1b5_(0VP-&1Nd1\SfI7gG,6^Q<]:WV1_YVU<;GC
O/6S1S@g4(2<f/IW8,Id9R:/bfcNg7-:;)adPC(.-L&^8_)47]2H+;\+H:0@b/A>
b&WIQ.8)H2LMDM:;AB406f].e5_@G3)2XBR1a.(HX.LH]#eTDVc)ARa19HI]]MBM
ZbC>c7=A3,<LB;IO?;Ib;;eL<N=S)-UE.SWIe<Z4Y=^d3[APK\gF4.:&#DI[:Y).
4_O9<@4;7+:/>Y5Ke:/+GUD.-^+@=B.[S1>F\I\SFOe@OQd+d<,VNU_/_[OYg;UM
RHa9X[I\)D=fJdWa4Q:8OS9Zff-Y@O7Ma(8e_)]-N<W?dZF=V2_#Gg<.1C-^@fNf
P2NX,+BO.IJ:bFO;I>;K40P8JJ;a/#:@&;#SOB28<^=-Ua8Mf-\/+c#<,OF4[\>e
gXf,5I>E#.)L764@cO:8^_4#CR9TET?S?I;TcX]O#G9e<<EV2,O9IGL=>]4bdP6S
($
`endprotected


  /**
    * This class implements the port level protocol checks.
    */
  svt_axi_checker checks;

  /* handle for common error check object reference */
  svt_err_check err_check;

  /** Analysis port makes axi transaction available to the user, just when the
   * transaction starts */
  uvm_analysis_port#(svt_axi_transaction) item_started_port;

  /** Analysis port makes snoop transaction available to the user, just when the
   * transaction starts */
  uvm_analysis_port#(svt_axi_snoop_transaction) snoop_item_started_port;

  /** Analysis port makes observed snoop transactions available to the user */
  uvm_analysis_port#(svt_axi_snoop_transaction) snoop_item_observed_port;
  
  /** Analysis port makes observed transactions available to user as PV-annotated TLM 2.0 generic payload transactions through this port */
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_observed_port;

  /** Analysis port makes observed snoop transactions available to user as PV-annotated TLM 2.0 generic payload transactions through this port */
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_snoop_observed_port;

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
  /** @endcond */


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

  `uvm_component_utils(svt_axi_port_monitor)

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
  extern function new (string name, uvm_component parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
  extern virtual function void build_phase (uvm_phase phase);

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads
   */
  extern virtual task run_phase(uvm_phase phase);

  /**
    * Report phase
    * Reports end-of-simulation summary report, checks etc
    */
  extern virtual function void report_phase(uvm_phase phase);

  /**
    * Extract phase
    * Stops performance monitoring
    */
  extern virtual function void extract_phase(uvm_phase phase);

  /** task that can be used by the user to push an exernal coherent transaction */
  extern virtual function void push_coherent_xact_to_port_monitor(svt_axi_transaction xact);

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

  /** task that can be used by the user to push an exernal snoop transaction */
  extern virtual function void push_snoop_xact_to_port_monitor(svt_axi_snoop_transaction xact);

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
  extern virtual protected function void change_dynamic_port_cfg(svt_axi_port_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern virtual function void set_common(svt_axi_common common);
  // ---------------------------------------------------------------------------
  /** 
    * Retruns the report on performance metrics as a string
    * @return A string with the performance report
    */
  extern function string get_performance_report();


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

  /**
    * Called when a transaction completes and when use_tlm_gp_sequencer is set
    * in the port configuration. The completed AXI transaction is converted to
    * a TLM GP and is made available through this callback
    *
    * @param xact A reference to the TLM GP transaction corresponding to the completed AXI transaction
    */
  extern virtual protected function void pre_tlm_generic_payload_port_put(uvm_tlm_generic_payload xact);

  /**
    * Called before putting a transaction to the analysis port 
    * This method issues the <i>pre_output_port_put</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
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
    * This method issues the <i>new_transaction_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task new_transaction_started_cb_exec(svt_axi_transaction xact);
  
  /** 
    * Called when a transaction ends 
    * This method issues the <i>transaction_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
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
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when AWVALID 
    * and AWREADY are asserted 
    * This method issues the <i>write_address_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when ARVALID is asserted 
    * This method issues the <i>read_address_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_address_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when read address handshake is complete, that is, when ARVALID 
    * and ARREADY are asserted 
    * This method issues the <i>read_address_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_address_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when WVALID is asserted 
    * This method issues the <i>write_data_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write address handshake is complete, that is, when WVALID 
    * and WREADY are asserted 
    * This method issues the <i>write_data_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when RVALID is asserted 
    * This method issues the <i>read_data_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_data_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when read data handshake is complete, that is, when RVALID 
    * and RREADY are asserted 
    * This method issues the <i>read_data_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task read_data_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when BVALID is asserted 
    * This method issues the <i>write_resp_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_resp_phase_started_cb_exec(svt_axi_transaction xact);

  /** 
    * Called when write response handshake is complete, that is, when BVALID 
    * and BREADY are asserted 
    * This method issues the <i>write_resp_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task write_resp_phase_ended_cb_exec(svt_axi_transaction xact);

  /** 
    * Called before putting a transaction to the response_request_port 
    * of svt_axi_slave_monitor.
    * This method issues the <i>pre_response_request_port_put</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task pre_response_request_port_put_cb_exec(svt_axi_transaction xact);

  /**
    * Called before putting a snoop transaction to the analysis port 
    * This method issues the <i>pre_snoop_output_port_put</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task pre_snoop_output_port_put_cb_exec(svt_axi_snoop_transaction xact);

  /** Called when dvm sync snoop addr handshake is done on the snoop address channel and master is preparing to send corresponding 
    * DVMCOMPLETE Coherent transaction.
    * This method issues the <i>auto_generated_dvm_complete_xact_started</i> callback using the 
    * `uvm_do_callbacks macro.Overriding implementations in extended classes must ensure
    * that the callbacks get executed correctly.
    * 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task auto_generated_dvm_complete_xact_started_cb_exec (svt_axi_transaction xact);

  /** 
    * Called when a new snoop_transaction is observed on the port 
    * This method issues the <i>new_snoop_transaction_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
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
    * This method issues the <i>new_snoop_channel_acwakeup_toggle_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param assert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_awakeup_toggle_started_cb_exec(int assert_delay);

  /** 
    * Called when a idle period of snoops channel toggles awakeup signal is observed on the port 
    * This method issues the <i>new_snoop_channel_acwakeup_toggle_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param deassert_delay A reference to the data descriptor object of interest.
    */
  extern virtual task idle_snoop_channel_awakeup_toggle_ended_cb_exec(int deassert_delay);

  



  /** 
    * Called when ACVALID is asserted 
    * This method issues the <i>snoop_address_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_address_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop address handshake is complete, that is, when ACVALID 
    * and ACREADY are asserted 
    * This method issues the <i>snoop_address_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_address_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when CDVALID is asserted 
    * This method issues the <i>snoop_data_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_data_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop data handshake is complete, that is, when CDVALID 
    * and CDREADY are asserted 
    * This method issues the <i>snoop_data_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_data_phase_ended_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when CRVALID is asserted 
    * This method issues the <i>snoop_resp_phase_started</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual task snoop_resp_phase_started_cb_exec(svt_axi_snoop_transaction xact);

  /** 
    * Called when snoop response handshake is complete, that is, when CRVALID 
    * and CRREADY are asserted 
    * This method issues the <i>snoop_resp_phase_ended</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
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

  /**
    * Called when a transaction completes and when use_tlm_gp_sequencer is set
    * in the port configuration. The completed AXI transaction is converted to
    * a TLM GP and is made available through this callback
    *
    * @param xact A reference to the TLM GP transaction corresponding to the completed AXI transaction
    */
  extern virtual task pre_tlm_generic_payload_port_put_cb_exec(uvm_tlm_generic_payload xact);

    
  //----------------------------------------------------------------------------
  /** Used to load up the err_check object with all of the local checks. */
  extern virtual function void load_err_check(svt_err_check err_check);

  //----------------------------------------------------------------------------
  /** Used to set the err_check object and to fill in all of the local checks. */
  extern virtual function void set_err_check(svt_err_check err_check);

  //----------------------------------------------------------------------------
  /** Returns clock period value */
  extern virtual function real get_clock_period();
  /** Returns current clock cycle value*/
  extern virtual function longint get_current_clock_cycle();
  /** Returns current time measured as (current clock cycle * clock period) */
  extern virtual function real get_current_time();

  /** in external port monitor mode, this task constantly monitors mailboxes of
    * coherent and snoop transactions which are pushed by the user. Once found
    * then it sends those transaction to the common monitor component.
    */
  extern virtual task push_external_transaction();

  /** 
   *  Gets transactions from the interconnect scheduler if they are
   * input by the user
   */
  extern virtual task get_xacts_from_ic_scheduler();

/** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
 
//vcs_lic_vip_protect
  `protected
-RQD2;HGM[CV]GWX[IR=-C4(2+#>VZc+A]):f]ZRS7DfQ&SNWH9e,(:2B]ZZg25f
B,@U&YJ,aM#@QN&:e7]G<L:1C.(ZN5\XB;dg3;Z)fMSDK?6[ecb5A7R6#bgZ;,fF
[5K)ZWSMY4OWfNP(EI6X@?:HWZ7;B1XU8CDP-cNFL0gZ:aB&WU&+V\e/3/<I3[-\
S=\ffVO<G,IA,fZ:B4AN.BA44#9?84.b[062Wg.W^/g<Pf7Y?bd+^^\_Q-DS0@1b
^\c5PJ3STL-@QUfOMZP.+[+DAS\MCQfLI4;L0N5,^HO<B$
`endprotected


endclass

`protected
dM57fLJ5#b&Z<\RMLF#5+,_Q/?7D6Y;UUa/HBT:T_RZQV<@)_Yg)/)9?UMV7.ZZ.
8D5A#aG@N3O_S:YR</B;?W@g:d>;@=d@a;SPT87[c+&J>E+[SWWbdS+WY&MC_IE>
C-(4A[(aL&2ebF+UMX]KG;I(GE;TI\)L6,d4:gN[),I&&&[3CRK9#Fa/I7JYI:Ha
0d]Oe:0CT]Q>1OI1L9>=#Ob_BO2@CLH?3U&@aT-+H44WL2UG1[UJ42Yd5T29H07F
D1Z:;-(:>M1\M;<XcL)K]UDMN]MMQJ&YVS0A.gQ5[XD=S4JNT+[VY\KW86A[Y#\d
R:W7T^W/#RPc8CO50>dTW20),8+0Rg@V<63=EKZICFXFQY4ggXAbZK6SYJJ:_^eb
//-?6=E6/CEW4#\C],VR..]V5>g/R?aEd\MO<?YR+6A3-^aXFF6)@J[P\\PUBMB1
S9A,FL/V_K.dJ_,R7-^WfXf=ZWLU9E8J85NaZb?D3_]Gdf?/;VeC;F))KYS9[@<X
C6VAD/?84acIQUJ(eHFIO8\4Q\cIWde?B,d3EQWX?_?R_A>CEKfa)RAaFWOK_<.:
aN=A@&O-40RBK<V+0fFfH^1]7R5L,H=cCDOf^2W&O^?@_WICb\BNNb+0JdX1cI4N
DD/W.RFDEIfU,:>2KYV>3>8cQ@,&@<73\-g.OZZ:;S,F\M4gRB<-HV\SXZ[I(#1@
:P_/2MDIUJ]RRc+Q(9;CS&8T=(;WV]^@;.FR2g7I-NI;B;I4P&HWb&5DRMHHgSNC
)?3;832DP-+.X1LJ]WAKgJ;7_GAGL2>_0cZYHVU-?08UK(f6>5AJW&QJ)IZM^f(;
].JA7+;B\9..*$
`endprotected


// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
  `protected
B(]PD5<<aP#V7+EgLW0C7QN>(K^[P8_,GPDZ+_7KRe:83+:T,.)H7(.ZLM]bX(FI
c]=V#AS.QFg:29c78OfX/NSMd/Z1O:MO):de[@(FCd6SA>,,Z-U@#IHJCASZOQ.)
5^,ZV_4.YDAO4>f()<L&DaHJ-]3<#a51]PR9dF40)KgM=ff0B7.V#GZ5JFL2Uca]
UI<R\07aX=XS4X<A354a+4b&g^/G#e_7D_g7_<HefPOS6gWU&0.+?&eX#I3cQQ#(
HT;&bU,DL8-GJ:e[JLQZV]YKQeF0BA1,+g.0K[P.QL+T/V#)P.)81E)?L?N2ZGPd
)8L#81IOK;=Y.2Ef1\(+CH,IZJY1T8TO@:WgI\cB24=C^+7,^Q>IC5^-8/8@/]3<
a2c<@49N6fK&2VZfO-=1,BEEC\7G?.0c_L07=]/^<Md1DZQP&3c7,8?^51+gX:\1
C_5<c@ebVMPH_D>5BU2N61gE^26D=8??+YZ1M+)C],,-F8F(8gKGGJ>T]cJ;0]CH
D+AKUQX&/Sfbb&G0D9cDYK5N6F6O[Tbg;>22@H+1KUD_PTcWO[T4KBD_-_<?->G<
Z&9;0AgMa(&.MdHQ)e=^Wa>4d+aRI<,>d2_@SBfLNPF9Bc=^EMQM<-AaZ7HK#7/E
@H42[ZW/+#1<QE4;Md9QENEO63c,fNS(gURBZ_^:Y_eIIG[,J.K^S@-SW5>[&+G2
1=VK\HFFR_(-947Z8a/4YXI5QAI:O_ba6J5?6?CN5A>=#Sc(<:6I@7OT6J.6R?4A
O(#R?/ALd5&18VNG>Na2+,PJ3W5H\&f48&WMVLg?JV87a3c<c(BK:\-A,(#_Oeg?
W2A?VI^].W7>K#Q9#.cIK;+&)PXg=G-B]a)b0&gD5]S;cB<\>^3S7KRAPYKONX=7
4_M?)J[GM[LC#-=<CAW^&N2ad8c6e0BVUC&^0=GTJ-\<[0@]db3P@Gf@J?M5(DAN
09&2ZM-Jc+]Y2>.&H\IT\^<C;&e1ec.A+4:[W0/VU7HGT)7NMUPAVM51KR]#MZ)V
b6[TT#(Zc:;/<W_K#>(6\7Xc\3F#\P4eHQ0;[(,QMU:Wa.ISYX_G=+ZF^XXGLag]
&^E@EbbF^c[@beeR?D=[M<VH<=()DOf64P=0Z#XVcF[XQ_4U/UdB2-H(?NB,>.FV
eMO?O1]G9,JR8FgLgW>I&:466+E80JZ]?&^,U6VRLZZM>9e_8JB@Ef8>]5_09H[E
Q^30:\KUJd5b:I)X.MES+:DQS,IW4XVE5HMKgV(_Od<1NOOHVN<+.VP-LDZ,I91?
cKJS^1(Pc^_08(\[)_e[\a&5-8A>7]BZ,XPWC&gM5<G>=#:Of^TV?7Fe4NS5YS&A
AOg^0#INZ@ACX>O41/7.<)-S91.-O6fTQ/7DMQZb?T(>C&_2a,7bC]W&\^+]/9cW
?9]9f7A3PZGTNRITIMK@4,CW1d#[=</<GCNB7E32^Vf1=]&MG=5EWW]3eX8gPCO[
Jf>93(SHdP/4MB5&4.LK)S5WJO-HNWN41MO3@_/E]R,eR+(MCJ#]G8-c;H.KMB?(
05AC?.G8:<=X,9Dd74_B22\YZGIT=E]^8A4df2eLdWXK0#)O@VS3SLH^;M/;BAgF
OJ:)[:4U1,W\).],]#-A/Sg5cXTV8b(cZBCaDA+G=0CCcLL#deN?A/e>JQJ_2C(J
VU;HI0(BZ#c?S#W7QN@Ba&.QI#:KLadb15UDV;Z3QD.,@?dI+6-]QYSI&/]9=OT9
&&#@TZ/45=;ECZ_T]1KR3&cVbdf_c&LMaBL7IK(SQOgWI<L37b8eZFY&YDBRHWPf
M1BcW=cNV7g[;FDETFQA#O5+ZSC23\>U)V3JN4WEa[Meb4Y2H(Zc]:gf^CPb_aQg
4/cSKPfc1E&ZC=0f-Y.OQaNA_DTb,+3f.LJWPf]97N&D771>X]=L/E?5c>LPe86F
_a=UJ:K#4B>b3.,U>+YAeeLJ\?W5E-NDTNA(#O@^c.bb=>>bST15,CXV?bEb5>d:
\QH8UAO/O4a@]d=6=B@QNX_2;F^FR_-B8TJ.@]4F;f9-W[OeYQC7IT(GU4XTKHbZ
fGVRR]O))cee5OXYJ3BHMHdQVO8MN;+d4UR.3d+BF[Ob][W/0\+50ELbM6-@R(Wf
c/06-La;d\I[eJ&>=2\D5MT9G0O<.-XDGJ+0H<..1Y#C.ca5A1R9,G-3a]CPT<B/
9?aZ(CN-eGXB2U-e,?JYcC>:<g]H.)V&)Me[YeF\JKV&W0Ib?^U74OCD,-3O=cFc
;=0<2ePfFX[U+&K6S7S:7CN6A:0BZXV<(f^A@]-]F4-Be9OGN<)gg]e^W_W?\MD)
49WGG@cc=cEa;Ze:R0G9a\c0JXD1.^C+?U6Fa[3,N-C=g98HW,_5T\&6&d,3G@XJ
X>OI-F/K-8TGIHO4d&L(KEOY/ZY/HR99,c:?bJZSNO2DFM#;T<X<:(>gF-;4^P(3
gLgLY;X^ZHbfQG)3WBTP=VG^F9\g[(^:[TfVZBO^EEO^SH=c0DP/BK9S>g7UVB_#
A]KV&WH=[^g4b]Q\eW0b0fccQHSP_Q#RH-@ZM-3D&KO+&(D/g_Q+Ge&g/723N&E<
#UV;RHI4#8E00f8>N/YF)[C>SD??T3TU]VLgG5bI-6&)^K.S:D\DJ;VW@,fRR#1G
)fL8&JW\8Haa7cX+8J][;<(5/?B(D?WQK\3^-#\5@cO^-BE1EUDS,]TX4GP3-6dQ
OE>EIKKS.eHMI.K0TAW(L+)+c&bN7Q4OJ>OQfKG-.,7(>cCfD8^,=c98G(2,TPg>
#73)0\PZ><AK8KQ>A#KQfZ]C:CVIbd528;CCXK^#f5e/IG6_SSU+:6,-S>]aD[e.
B]/?XOKV-D87=bH=MMC9/HM,I_cf,BPZY:G@>JTN?O)8F)eg9=&;:<5F;FL,\LXF
)4dTZGBJfQ?6QVUHA+G(YeWd=P\#)()UMH=CF<Z3dWS/Q2@SVR/K#RWEAJc6eJ&I
3I=Yc,[U3FX?(Yc6LC\#&(V+MYYF>F_=(AOPCYWTGe7B8CDZ@YB0,51a>dbS86IM
AEPQOaC?4O>N/&>AOa@<<R[2>::9JX#/2B_X\SE-6,2\YN8Z,:5c]3(A2E+a1M<L
+[QY_R)2_3c5&b;]d0(HN@a0:@4Q__3YX[^.gFa,LZd81UXKALA5P\Q64<f7e(OH
0,P/N(4@+?S/Sf+Ig/EcW&E43UG]UTB2dPKbL5PgPXPKGK09(;Z#Y-HMZ078S0@F
PPC>F-4]a::5K1Q;8U(ecJY7B6:LXJF81#gBOW=WMg2R6^(4]#b;9e=/E\f6DZ5N
7NFd=5#(PT11]9_Pe0gc2IT1))UgXdIfU.^UM5UF./5cd@c4K&Y]RVgH5,JA5P<W
3;KKLH04>+P)BgGe,H8/3T?d_Q65&L@U\e:Z@892)8T#QHcGVD@UB]@I3]IAS_e/
S49(2X1GfR^;WegafgCC\:_ZAe1c_AM_;Gc.Sb.L]V/2^J0-(g/S,=^c2KYJRd/J
C6Rd7Y4CW>dOa-JMSTMHX(aYf3ZF+G\HBXdTA4+.2BDWV&XMd^K2gF_fRR)HR;U0
bg#g4Od0OPO0&GSQ\eb0-L.)1HYfVHS6CK=Pf<:X0RX)1dR_I(W-WN-218JIJV;S
>7cfDO&O5-H6=eM,0Y&DRM^.57Eba;5D:ZMX7>M#a(-.&PBg<HB#4F75V79U<P&;
TaE:bf5[?NaZ;d0<0;K,RJ,9/6_+T8M\2aS2bHS8c\V-47cbX5E.)MD?M\TT:?eQ
:86[BMC+g].>FggRA_<Hc0Q69HI53^0,K(O&&-NA[ZK6FUNW5]_Z90J<c.YC#A&H
F0ILA3eb6[9_D+R[+#Y\=39[?Ta:7IA?4c(__\BeSMMN+COU?e85Q0-]MdPOXZD?
5FOc3J>VGQ&FKRSa^4B/D\8>d6#AU]U@TgGUN&,AH-DW:UUJ4H?^-F99cJ?P_^:9
QHV8)@LaN>NaAY>]GYR&:?[UO<:e1UV271cF-C(T=f\VPO-LdC2QM4<UT=39[9ab
Tf;E=?8G3/GRZP6^K8NEKV>,WIWID7JE^Y28JE>#Y1ScI2NZX2V)H)L10d,#.e93
TQ:1>d))S:VT9P-45BgN-cP3\U9WY,NS5B[I\H[GT;7MF+&U:B8H,b)(5#/)SXH=
0]K;;a<UX4YYCN.)eM5#QAYA:F;]P##?W+LWe^(8KY^PSCXIZMBDSS46c<G+fCfH
?aEK(5T)HYcTe/VUO1L^S[4<D-Q\V#?d\A,4+d</+1;H_cM\CfUaD,NYK#a@LYDf
b-8T+MdP\(MaQdN.&M>5,3NLHT7Jc5F]OYdOW\?92>:1Z#A@EN/14JGPN=J#:5ZG
UOU>fWO\IfBf,;de6N96A@^.MKWOb:c9=UaWX[F+5OI(c[C8A3T<<<SgA6Z,&S1L
&aT6gEgQ?^G(Q4O+2VW,>aDKL2(BR6GRGR<-MdgaT5a,E9UH6=6Z,M9eF[2<Fc(^
-_?@>FNDgKQH2[][MI#AX1+-OO[OX[VYAFHJ2fJ=+g-3]Kage4./#D2FYN,\/2BZ
)d9Q5AB)XDa?<dY<d#G(20(CB:Q^8HfZ;U5Of<J#[Na[WUIJ+.=.8UH=X73,<:9a
&;..QI=D=eP.?(A#&//[g-^4beBb.;#gMRT54/1H-aX86:_G)4eMH;/+=)F4E4V<
L9-\Z@QPN-c_Nd[.]b27N#CQe:>eHS+CW,0C+0=Wg>[bb]QRd^9KK1HX:[+\LJL_
>)\5,1#&gEM6FX^ICKSS]?:V]3dV\9NSX6Xe);_MJTD@(3Ccf.2Cgc4\[A5#,+e@
;W82R-UT?.W>A/;,EA6ZDAV,,2b?fBde2ZFMYJ3>Fd9@E#0a11OK-fJ&7;KAFQ.H
4JCFU^1NE4?Qd8QH?_>AJ?CeU#]AWSd+c3_cF8KK4a6<?D\cSA/3d@?L:#KW(HMF
O&QYTD?,LE)6Q>-&]JT8)B[J&Z\Lb;80M4/T6-3<_EB2/8=a)F4,g\aX^D=KPbWd
?#14KRD5KKXP4MIbc\8./[YA@DC=3QT^/RO]N<(_c&\-N/cR>2bY>0+@10+U5A&:
9]+Q#5\?b/O9EWO_bV=fLH=3C,Y_eC=_gCZJgFgCLd_50Zb_f/.&K350]O;7@gbN
+dUNd;WQLQRKE)e.0/>;dOHC-W-]?He8>,TCSDa#;SS[22[/9OT(IATE-,R8+&]-
b#e35A..X83IcB,P(.XOgPW^>NXG8./6GH1Adb)c14c^c1BGEd1V1aX<CNce@NY[
Q<?R1:OQN,^1Z+LRFQR;V-b(febU7+^(PMHZ6OK;e3V^N&bU=]X7:K@T-AS;_]N>
Q@+b\HaQ_A&-1,;[#\(Dg6R4/+7-V[7?PYSQF#WdXW)8G7:KeM8YFeCUb63gB.Y3
e6\?3RJ@,PG69aK?SU]/K0bK5BJ[Y6&6^eMFG+C/5ZX:KQ0Q_@Ab:bUTLQQ870Yg
:9NF&<S]E0;Tbbd],Y<(g34GMI(ed_2Hg7d@1?\.GM<\cc4\IQa>WJ(9e##P546T
3BQFG/:;D+MC)+804E/g8Ae;T28b)JYS0[IGB&RN8-:gbL?VNZ6]?KJQcg5PB,;#
JgQ0(85DLJ&D3W:QIOT:?ZfPZPSbPE]f[)S]).E8_&IPC)10-HW;2=>XC=TXVGZS
&94^I-+)0UUH&X;=IP9IJ1S[#HNB_+L?@[V<C25V/XQ.S2bcUfJO<.YEQ10FW:bR
]V9KAM-4UNHHK<JaL+7-?9ISR82BM^cY&<;JQD.cJXMDeP#,gL)K]gT\Z;D8><Jc
E6/B]b?f,I@A1ODRZABGRN?6HZ3=#&7-X(M?W38@22Q0JN53@5bcggg:dAYca,DW
Mf@N@:>MXaF0&9SRaR2\^@a^-91-[86]3<Z(Kb@aaLcU0dZO3ALbLY(PWKA+QGGD
9d_V8eRV8]/TVg7fBCfT8Jf@Rg.TbF0W3b;8NdOZ#32#X:fVRG3f_Yb+ae76I@bU
dcIE&1MB),+&fEb/H&KH1cF0\QI2/g5OI]Q=\F1-4g7ZD.Ba[<=F(ATJ1d??8J?E
GW8RE+T=YUAQRG<MDe5WC+&2<1(TYD99Q4Td53M7^4&>bFTbH@1^\H[[RZ,A@D_D
O&/TQ^I0],_CTTI3X?@,&K,]^72e0I&P<5cLVMY0H^;Q35J_&FZ]f)EL?,--Pc9c
>43BVMJG5:>?H@8^_Dg71aM<^HA7S28_g&@Be7H?A+g9SeZ5<cNH<gICg<H5d:_>
Hb4=AZ6U>1?Y3&9]<+7G.WB]d:XDCeR,TAagE:F<V#3aSV)(\cHR+MB(288N[//A
PL6=N+@>Fe(d.d(5]bJf]RZg&8/N?0CXU\^9KBA[,eaa;bL\^fUC,AJE[JcY37D&
M;6Wg_2^<=7^VdC+UaIUW;^H)P4QUDQVX,OSe+(VRK;>OZ7&-@V8W=N4AeP2XDa-
((fL^N3BH&cO5E8(#M=(3CK+dKTZ0D7_/X7]SbVUUI#N:_XH)>/S3c>F#Gg6F2E_
^gMfZMI^O#+7:Ze8X&OXAfNfYJE476VaHX8_b)RA/<O0ZNKL-:beYKH0SD/d#-G[
A=C7J(4QR.e82+<RC[,-=bc^GT#37PC[.@P><#FH,89^(G0&4Ja3fMEA<26V0E+P
JZ_Ub@Pd>W5b3f[MF=ZMcE&=2>^3.=4UQU18N_F[>e9O98&:A,A:JC6cBf2ZT]c=
=V#^X)8Zd].W^G=aL-_bcMP]^&_D(cc5MOMZeALSNe0TMIWLPa879cD3EXY1RE@F
]7?A36GT,OH87De5PQCF?WFT.[HGH=RDO\HW5F9BYJQR]\5N:X/(GI[>3<=/fQR5
1&&+33I78d=V9:Xe62I3T^QAAXZg67eY8M,IJ>KX#?FSNMWc2:7SB@cI?2(HTM0&
d/e[PcSR<bg]DS5#C(F8.9OZ\S;8;Y7VG_DSTEN;YRfZ_A]Jb<fK3K@+?SL4H?KX
^;5JSC)O_fUcd1),MO/V8R;RB)RU2A&:K,G;GaC&fc)WUHDT.Qd-c5[bd]B=a\2^
IF:Dc3JMCHR[J#T29Q-:W))Jc7Ye[GQG7c?+dO)6M#@IIEUg68^T,E>IM,C87,G;
]EddBH(#LM19d)6;QQVDE5#8a]R1H40-Z=-)889#(CP(^Zb,3,DEM0)KaA0(]-AE
aF2Y=/M&SB(3+#W^.R8#+SB,-Q-H8[)O6^/I=IIODFMN=YN<+<E;PM0K[Y)e8H7T
+TL,bO5IVL<U_\9LVf=E_QV6f=PI.-U836XgZ0>LN5GEJE<^OK.^=Y]Od[adLEHU
WGd=g6K4\d,agdE#5-U.XYcX/4.PSJGO\NI1^^c3:5)^A&#M^+a=BOM90L[)8#3K
,&]CRAf8a>B^/Q<Ce;(c2fPXLM>R884#a(G^=@R@FK(0O(edT9J-1DcF&.U?U15b
4XA:DM7RK)W._CSbBe4.HL&AW,+eA<19,9<&Y&;\,Qa1UX_HeFa(.MOH:#=E#a4[
,P;V<JK<SQ4BLc:O)-d^Q?:JE_^C/P#GN7Q\6D->^N8Q?TaYX4eFYCc,6/P,T2T6
_9;<R4)Y1-Z.KRDaES<911^0Vg6DU#NY-GB>G>3Q#6.K:R]?6dSd)Y6CETL_H08K
Eg\WKfM(<57U;==dPIW@,A.d.c]L;;.bgEMPT6153#OLgO.C_NK.\e:-6L)X#EV,
1GQ<:b6?@?B5N6eL_fXCC#Z:IB^NGDJaLZYWD_PC=-C&-OA4WU/VFL1S>W:b762T
R4e8:f5-;[af8a2UFB.[YHJ,ZZO82^91ZL@6Oe)X5@[E<P#<FOaaYU/>AW3?D_FT
^?e#f+Ge<\Va2H3\<N^2?g;)Lf/=eV;4<QQDfQCa++1X4?NgAE8+f^#&+YMS(c6V
dWX+LKPWI?3H#R_F4(+FQa\350D;f4SeTYfSG2GWGHNR&d1Q&fUgUe9V^aD-I)RH
HNS0][SR8)>U8Xaa3Z3_3cLd]-g+,BCP9Q<#g^LW^?0NFLeg6VgV<#d5M#MdZQgK
QM0Z_aM[A>M5S&TXf6H#K^/<dYW>=+4fX@T^F3918FH+9TT:LY0J3([=HUI?,[GV
cP]57<;?3:Q>RF@b[V3(2#R(69->fP#/I#:c?@dR;&HD):-#@&JSB0;OZ5(X@\9a
]N5d=X:bU#4UX?e^5IgA8,SbKQb:S)<XR@UYa]gRT:)a;??5UaDf/[3>X/+01NgX
;2bMDH\S_bOWUN^H-/V#HZ8g&VNa)g[9VZ6U/WG1Q)<F3)DZNcY2-P#1YZIZXbb@
_.>=K?K8<D@G+>f;N?00+V-Pc:C0+S9)\?X9QN+SBG84WgM(#HL&+d5gOC4UN]>U
baF3H:c3SM>fb3[b;ReZ7/#Z=:VT4SVd:5^WP/Y^)U])-6WH6aN/B7ALgb..gA+,
N5@C03FX2:N?aC[&#Ud0)L9523:K4T5>J3&>77W&b=4)6RH@;Jg5SaL7dd[@+/^8
@OOCA94aI=&,N2>C4:\XZFR-N9-02b:eQdY&V8D9IR^:0e,BIYeXX&C;eGAY+2X+
X)>FgQU>Z^Cb=]_XUS:;ZJ1,5[C1Z>O1_A1[a3aV^^OZ+aKZM7YZ1>Z#0(4Y1PG0
+UR;)OYe30Fda[6,YL(R(-E67eIAWG+]f_<8d:Ke(:X&<I9&#?eR>.,3JGT52dG7
(cWS_373eX:)]bWY,\+YE/E#(a[+,cK8^0G1gH^]c2>:DT\dA_M9/LV7B,d_Y;94
HS-+NR>QFHVG9JI;.LS]HA^VY](Yg?fI@-+FD6/J+;a:K&TO&3S6C:<?AXG2a.])
B-P.OFERecI4Pb_Xg.PYbLc:Oc>;Vgd<GD.0dKZ]dI)^Rf#2S04R@BQPJCF3\WcA
&F-XePS^+D_Oa=1-+#&FU<)dB^KPXfb2HR_eHF<.XL6YJM(+=H[S.>.:.,c0VS5^
#0,7-:+KJ7-XX1aUJeG5Z3W[V@Y1B+Y2BUc^WOcCFHTDee)1X#&5e2M;29??V-AI
QQ1efQ0@1?aL=2J/(G_C@LLN4EK_8FGB5\68=S^5fS7#+K4&/RL:N:K(A[==3K#N
JQ)H[PE5?PY@:AFbcL5P-J&I8_:X7b9\UQdcWYf[7-8eX#V+.KF[?]:8^RD^JEE=
ZMBWI/]ZFUWMCOb-I#0?P&eF5?KMG5XT6MDf35E]+Z/QO.E,21ML-FAL)cU#_DR_
W3X,QG.(M#6JP2NAOYK3QLJ<[-HH8B4Ad_YLfY/5PDG/:SXNT(4W.KFXBU49A^f@
(UKTE,.4b9#BYb8O85S/1Z#U_B:]8E]@).b.MG;IUO1U^:4b^51B(N2T35;ST#LK
[c9.MO;-KaX9^Sa;5(af.KUf+EF+[56#I3e&OWR->I,Ja3P8A./HSPRfTLE/e&EU
]@WIQ3L,38:T)9-bQ=]R;aDTgLWE.gKK(=VT_P&3g.W8V5;8Nc8)T?(GRTU^dbCR
)(]GB5KWOON#@Q.Kg,J9]GB^8C;<gYg]@\9e6d+Zag#E=aRY5&);X]C(>?XB1I)G
d-f/(3-=)?E0-gdU?VFO6U<_)2#8W@?\dIQOMITBT]=:e^WNO<T,QQVTg^b]>UcM
V8[eACd#eP06RNf>O&edPD1ITJQ)Gd]\U3>32@WEP&L#<HX]5G5L<2DR1UZ)X;>#
/NbE[g\E;^@;@?WfCfb&@M;#,LYD]=f]\#cJ]1,3-Y4GOT?LDQGZg5bB1-A]X8?2
:(P)RDBVeG_Z<3Ig)9E)_<J,a&T(TL38L#H4Q&MIKK2+R2J&@+;+<X#(ZX/0YeaG
9&0fQL9:8P@AF_GEKOW0:AFCLd-PSQF/9DADV2(=AY/]\S<f3+8bXIBNYUc4]cGM
R=Q]g;2?^AE;/e&]C)Q8Y,3?fY3V,6U2(A@aMU1&>@]<?2HZ&^]<S&T_TRV8gP5/
P+S]O])^Y8c1:NgOCNX^&6=YCcIU\5/@^35aM6^]S_BTeZbF09aI2:UAWL=bL-#f
]\PfGHdPYO+S3)PJ0?U&Gggf[2GM8W71cbYA^0#Y5f@)gWgSceO377@E(bddBCJb
CDF::##R4^JJg20DU&Gbbc04ES+#Q_cZed04E.3CgYE;^f.g1SH0M.:#;_>a=M9R
F7JY93D())A/J\C[NAG9.B8#eLaS22].F1Z@WNI@)-J8T@Le1cUWRZGEH>b(1G5+
EZ5bXLCLF.GE0-d8C,Y[+dR5OCgU/:>C9b_\GD3.=cabHWM)fOQ>;CWSf)9-^+GD
6TM3FT76T[6W9[&MAX5]24EV9c]F56OdLA8QE3I)e)JS5S^QYCSQ(CD=GC9fPTA9
.b31S[Qb:@R(_VV(c+Vc+VT.8e18>gBD7,1.O/B(MXN6X.^&D8b#6gZ,A=TBK@\C
MgJ6Wf(_F5XA_+8V4<Q5FWe@.8:Ve@;VIQK/V>X,YNOT<#MgbAQbY(:WR@I\95D_
GdL-(C_AC3>H7:90,M(/eRIAGRfEST3-]Z<96R-^eYVE,?8fdOZfUIFIO2?e@=\F
0DWeX1.5O14V89)I^+?C/R1OUg,>Z>>SK4Z79NQB=V);]X,25c+E^#&FV3_f@8S)
+MG>FPfODbg)V59KLQbK6c0I[6b&]R=LaO-VbDbQX53JXNKH.PHAH2SPBK]415T,
_=d,UaC?7S>Bd0_@<7gISS=@P_=C,f\e?9T,83R8f]a4cIS6-J0#A[2S>V]2(a(3
B.XQg-B_,YAA1O5RL(->Ea2C>+N(FgB?OXEYB>]B@aG,P9O]J,8\R91Za1UD^WAM
eT&YJ,A=5S4Yb_#,S_0]9QAQH,OPN):87Y?</c?30T-\RUFWB7M7@:CXEDbQ+H,D
_+eTA.8<^U-A3RYHR=a@1;_d0[N9FF(GSe#.(dDYgM\I0cd+2QAVA_aI3J^H/F5Y
JT7^dMK<R7YHbVTTZTbB.b.?,_E;f:\b3[&OPS=7A9S.EeD(\A=(>4:KRVX93)d[
ZHJgN+[GVe1^=XU=9fPV@b+<XNBQ9:NX8Y4CWJ/Z=(K(7E?fO(Ob>Z-J>#IR3SHV
WCF7;=::=(9Nd85/Z)\/AfQ=W/C0)F,)Jb#1D.MDG[2d2&3(T67(1LJHJ^W6&fVJ
=aPI^=69b.NLC7F6WI_HZ5QF#8d#D__D8M+R08a.cZ#_[fd91bB[E.IBf_SI8U/-
NN4FN&<1-CWbST:AKB3Ba;dEU=Z^W-BNM+#e9Y=a^<NOb:V_BOLC,f1AUJI?.GMF
\Td_:+0bW)QGb<X2@<]\fA4;Y&g?UJ1Sf\5=]&RGdY(0((aGL&47X(6EK[Z+2&E[
g_D0#NUN+1=C-FI]#]AQ-2M4]D87+D1VH15FBIK9H2^;2g3\Ye<)f\&8Z:0_J;K3
ER(+QIcVf/S=^<C][3T=IeL?CEUG&GCM-RBf7>Z_H36dbXK&2IU?&MQYbBeVF/;:
8bRE(=1,fLg=7/;Ib0979UF\1/)b8fS&S4g-K;TNR+,X6GdC3N,>6<A7,&H+AP4H
T_\[Ob,\CD\9bP+FQ3[b]&&WV8,CS<eZ)+]<MGggaNaO@@;Eg:1,Y;>^DPV-_P:[
=T\,#NUN8X(XZ5Q>dD8/9?FZYN2GO(f+.)/;O95K]=c5D9Jge4?6;Ng[YPTUaCAF
d(469f2,f-(dV,bUDM23b(d)Ug-]V>(a+)D=DRd[YAdJPLQ(N\J@+>9K05>YAY6P
Z>G;5IDfV>W3+Q^JT@^]0e]X>KN;NND+I^SaWbe\])IYP>19Y=@?.bXIH[.bA/9Y
,ZP\Z)[K7(=]eQ&6@JKS@R(6;Z.LG9[+eV]e?O,V0?_f,3?3[-]OYWQF[\\5JVU#
9+^</5QH#9@2T;8dgaAM(cfe0_G?:,c6T583bV[,N2[b_07^>3YY#d=MTG\]-5(>
eE^D<7J&NTEFG:7N<_09[#G]#Dd&RSa:7[(=\S19149SE=,W2&VEa\ES\2?[dbR:
19dX2B,F=Baf38Ze-:L/@g/5(LGd4,?KJa#N<^1?Q0dLE22&YP354G7<#QQb1[QD
-NG:K3,1>\f41G^BeZcYC78c:JH5XK<+4.?)I:?gDRW:?X-\]BMdM4ga0c5[#gSQ
LX^+_,XVS,K#>>eBEY)5V0?L#Pc#W8[(Kc;T^(H(Mb.bG+dM)ND4X:bQM#/+GG\>
_-7+O9IE_P1M:WTB@)J)#SGHIe9Z7=@1L_ON@=0eH?4R:W7C9659G.?g3^GDT6Q0
cO:&-1I/c2Zd;[T,;bP)GFI<R6V:WQbf?JK6@)2F,9<K>:?-,J(V8RJJ4WbdH2U5
_GKAKUT_=@]a1DZ0YE1,V,,c+<D[fX6?VId_L2#0Z<a9#_^,+#G_b@P><N?2f0SH
7:/;P(0(B,NUEe7?9gEW.>()KEa,0BTd04EUcW)fSPc^eU1)GR>Uga,OP0BDA,WT
gUTIVEI3?c>2GdXQg#3cH3OE:6Q63b:c9Hc706<d[0PZXEdggdXFZDKXM;7[6-fd
#WcDJN6)ZG0WV]E=B39R/I_>PA4^@):S:.<C7?CP2LaGO64BE_X935GN/,#BOC24
AU;+P8<>NC,4C5?-^;[)-\=(E9?]-5b;/C>.VZ<63.MMgU.;=Q/1N8VVUQAe7<E&
:3KLT<;KAI;AYQAYDPD5(WCgg#YXb2eW]H\de\^(O:TTeBIN<X[]MTW5_7ef3PYU
=>_MDGBgG7g#Od88-64I/WRZ@7\Q:]Z<JVT;NG)?[f@D_T9Y4+4dY+[&GTD])6\4
Z(+_4H+?D912F?+B+QH/Ofe>]J2/5#ESFgX#W@HK[3fA/VS]3]2X+2C^?=<ZWOI^
d5_Ma=U?fM38TY+,D>0d.UE&1Q727NcOC_B9//9S949KS1Gf<P+_Md^eJ_1a;=G>
(OfJSQH1fS4=X&CJZQ=C\DN>D[KAPTe=Ra=V?+C^_8ILXd/d_ES?LU@H2_=:fCbK
Zg+=4+HOT3V2^([)WM@_ZZc.&+3RfS,_8GW\5V#=@2?N6Y?1?1cU<T@RLD_6506+
>S4V7Y&_EZ\_,52J?I(>gSO6&RL:b/EQW/6e6f#@E>[HY^/<6c[;d+)<a7LdRU.2
T4U82FP(X4>O#fQ_0H.S=X2P6FY]>+,+1(X<MT&VS:Oa9@@;g)We+43.fGMCJ_Z/
d,1\Ta,?X47Z=NW@LOK&/B2W,N(-C6:8g^gfNV-.NP/_GU<WH(U(T2LL01_Z_4YV
7EW\f,TN:VaW.N=gA.D@IGR-E0=-3]fFOAPU^X4RUZa&J+&@]+G>#-]Na-<fCD>c
A\/7S.ST_LUB1.X7U1OO?6>35;,Eb4::05,-]V(3;,O6bfE5f4a#eaMba^X21CX7
+G7JcBe3?BPeASKg>1bf(/[\IZ3Z-VYPCBRX#SA-=TB9]W2=gTYQERL3TVa#.@P>
]]N=63(&R+-Zc8=1g6AIYZ\fdgO^<9M@9NQ#J(c6\P>eWBKKH_U0AQ@OT\V)U,10
EI)c3f^Z[9;JgK^7GSJD-./&1FaDGK0PV?NA]K;,79S5SOIE-J;4E0M2>EUXeKNU
23D;#J4Yb?+W+2:C@#:T3)6@eXKS2Me?OVQ1(>6D__I=#=NM5W98XKb;YGf0C-D0
@PR&c_FfI5FDA>AYA&XA267<d(75S6YC=DeTVGId-CgNS0[E/Tc?9/,R<LRM^>_[
2T;._=Tf:&B<V2>\4^_VNL)X-WJe/J-]GV48YPP:Q#&XPFL1La_#PYYYd</3@Q79
:0E@G;KZLEE^Kb2M(E>HR0b33a8OGQ02Je&R[&?4V:+F<=BP,P64I\WVATLL&I_#
/MbO^47acM6]F/WTR3)d>AF^:N\^AHJXf\X9:&eSUE&5/TB3EY?FMM7I2eZ67W1=
F?VGb.]AZKHP3eKOC><[QC9#8WEVaQSUW^8+bfCJ<bA<_e^a8-?<+KBBZT6&eL[^
eAJ#B8+?:ZDB6O+[>gMOBE4aMMJ#Y1HT>5CH27]@9OC_B>:9A+Y_b99dPd6D4N0_
8WRcE8]YW\c&B6LST9ML=U6R&OQbcYe5ZA7>@/2IR^[fJW?YOT2Q.T#f&KVL+LNI
LJ#/;XQTgW<cA]+44FR&f=c?80FI9O2AWE^E3JU9FGe>6<G^+bA6c0[/6E0->Bc3
R?7.V\/>Be)I6+6P[6JTOg5d.aP;M)X]dJ_0.S13BIP@23gUXL6Z[A03?&,-?b4P
.c>]?;K5dVEMS7U+F?32gIZ]?FccVV-?_d1?CA)-bU:Q3P2TI[],1E:O?-C(0;/J
GEKN_CLaUP2&91CdV5D^8c@=gdS2HOH]Hd5P.21B?B\8_7&OFR^L<CRS0+^PN)D/
Q5\8VS?MG/e7<#/>/W35OY>J9KNQC2N_YAJ(<c-:>D/3LQY88GH=,\e9JZR=11)e
N_(X+KeN?_J)-=TS9a5DTW07&^0ZeI:(VbVD8+DA?544L<bGG3&9AHW26()44Lg]
CIc=?/1XJL80:L2.>[C(,Y<?d1QLb+M\F&:9UG@DNHXa^)KFBX(XgR5BD_3&[-F&
G7@MKPD_T<;)H)-:.e[B/4_IG4,/FF<?B<6H]Xe:Re4g7fTXT\=cX<g&9EV+W0?>
EJf2YII:1/BV]ZDf93-M()^L=IATLAWA[L]/gMa;?N,c&e]9,U,I9RXcgGg9VWG3
gF:8D^F=5A^N1E;+R^\\d((LTbJA^ec?]d7BDNJ,Ob5Q8ICZP(aH.DG<dG;5MO9H
A>#]FDN48=7L&;9L\J90.?2?PWRU=,G>[)fATC]Z4Gf;HRJA3TNZQ3YQHAQg\Wd?
9V&4;FJ2I,W.#>5V4&/eB&=a1R^KfNI]+HNf=M?#GCG@J&P_f&Kf(\H;QS+Jf)2-
/J6S/(^J81^\gMgJ=TP2)YHF6B4S&GC2(N>WP5K=;7=5)GL);_-W?I?D[7^16M7:
)H7EFG0Y(5g0I^9c1:?S4a0\g@0DUY@L9\b2>?C]Ge6\b(S8bQKZZ+M1Ff<CNWN9
dDRA04;?)_S^K?;d.cgd30&8U(IZcA][3NeBL2A;fF>E]ObUW=RZaRDEKU0BM3B_
D0gL?VYC5=>ZS+Y#L[K,;H#Z;ea#ZAK#DA]3Z2\H8g3g1Q_d5#_WB748K9f-3gAE
W_>&[e-MMU=Eb(e^W(2+,P9T1M.4eL;QY2f4ONfNH4@4&D?ea;H?413OaL@_1F0N
9?4.?_eS/b,g(_g.R&M+dQLT(-@QCgg<+6WE)U^2FAD7T&N0BbNQL+[#G#XI>V+3
,)6INcQMEV;5P0V1[#@2[d:2c\VJ0SAE#J]TRBV7.L<:#<]-5:6IJ4[B_M.VY?2E
ES^>\YP+VCX2a[FB,EL7Na=I9JY_BFd109>91WaTc&e53II53>VECf&9b5;D,W@W
E:A3(GP58)A_T9<O(FNH#:B/=;LD_8?LN@RV#\0fC7(W:KaI2>::JF(W)5\&DGFK
7]RAMa(gO?3&:I<;E:GAeOO:bB_b92G)@5L3Rgf?dO3fQcbQR</3cHW0)GAfIZ<e
SVW@+^172WT31CZ<^=CXN]F^.>c@ea&-J_4)8bK.-fRcb1Z7E\+SOd.UJINH-V9E
9#L+1,U>SJPUHT]:?[?8bWY(Y0K<5LI#/1,CA8F_8XAYbG9^AHN2[4?G270g1K=(
5\QA09M0J^@f]bOHM7+U<D@U-(-JKgDG.4a@1dgST)Zd4Z138P_?HL3#SRD5W>PU
/JbBNHc^9&YeH/[Je2g&A]G@YIEBMS-ENQWa(4FTXA#g0+Q^S6^.G+.7-O?A];5-
bUS\(Z1RG93gZ;2Q:+<5R[1&U1@DbeB8PB0[B<;UC-FbBZ7CWX7)O[+U>),eQ5aS
BQU-;(9^7QaCH0D[A.6S1gD\9TWWW[Z\ZGDSa0WITM@;F0Ac.BMELN>[a7,NRYW2
OZ)de<,ab3)c<5aAQONfOCK+>cP,7)LMR;]b_\>WbfdV]RNB[01.HMB>^V<I]YeJ
2c0BZP&c^^W,G=J3AbV6B+=c+]LYAV.D_JXcVOI&b.;?]D+(8c4g)>/b]+O&Xf]3
NEU?FCV?X(f-?c3NW_S(O]S)M_QI51E.#U5c-&g9P2XdM^4-IC,67)6+8.:@0KRb
_2IT9]V6e>._V?)H-L-)e/TI^>28[eSQbT&S0+)#Lbb]RHVE)R&_8J#PW.4/ZL?T
O.b=#W3C1YNIWIQg^Xba1^5ZP>#;QZf1f]A]_JSeg?>M9Z8\E5&+)54A-PY0S\XT
_0=Hg6Vf?.AW,.@BJC2;R:e^=::/+\d2@JEP+U/^WfcJ^Y=9f@7@#M@T2Ug(8:)b
gZO;+\+3<1;7LLI8_U_R8Yc;_-,Z+BcJa&OPG0<=C:=KG\H5<S-Y2a&f2^JVd7W/
]JW;LaQ)(^?AN13)e,_D]MB1\AGV+B@M/g&?KW)bC-8WE/[E4[H6F]]0_)UJ+C,=
)b#49CK;c[,7=fC&TBdfXO-QJbG0RA,U8?1.W4\;V[1dX?)1?C,=&<=,0WVgD55c
R@[DVX+WX65;4N[?.D<),J@da7TR,/H<_/<(Eb4>\fX<b6e9:WM5E2,bX42FT/BE
VH-E#VJS>QRJ9c).P>)_L\,a>a?Lb1c0U.U)1Kg?e#Q;/2NXg^RSZ\^SUW1^M?4Z
CA270F8DT&)DJ,_-FZF_V67K)aaT9OgW?=)g&;SM?e-/B6YCPNSPXC=]0dGCA;Jd
T__T?OCX@64H<@H0-]Pb5/IY4+[4\E3D<,6c<Qf,.MEfV,g@\EJ=d^DK?]Y9P=A4
5:]QNIG2N_7803FeYO#FV<ca7dcJ.#eJZTZ+M.JGUU^>K98CN[,]8;E0g7Q]RRXL
P1>@#f?4=I/>^TEe<QE\OCWVKg8-(bZ#Ke@+>].O0.SL@?6DZ5M_eG)dS&UEaMSg
HgA-cD/R\S)6>,D6Y:/UPK2J:4]\9RTNZKCZF_N+6gfN3L_JV\5N2ZSWVT6NNH7/
3LG0N.cJ,(N(Y_)S7E^7gSP[bG8/AV7JM6:\:Q^Ka8ccO:2Z8<6RI79ZNe>]C_@4
C2,N6]NX@2AH768S0N8E1;=34\.9+:,_<]6)@a7;H5?@Pc)f.WTF,JNY.CaEV;TP
YD<UcPCE+V\-;7R<H>HFJ_DX@QR<b3/7g1f8Z&AC?,\5+Z-<E22@=Q;QLI</a4FI
cNW#F+B1Z9?-+SKP.:-IdL.PWY=]35XITC(DX-02ZB4A9:dKZPMDM8Z)/Rb]5OL&
0WF5@f&VOFEXH-Da;M?#_X8UY0cOUGK<C:L5>XWPb6gdG_d?f>OdE8a\#:b_AaCd
9^U,40&-bg3=?6Y,THeLfV8\>D5D7LMN/Z>21,=(cC23eZ__K_2SM7Q>S(3^O7G?
(Yd+GWgI_XFb/fV/MV0BfAUM^R]d<ZB.:&dR0[L)&cGfMfBX=?9&+-^(TD/352#4
98^Dg6?_0RaNDO8J3fbDS4[K]MMaTI:cb7QW^XN=[TRL2-g-32Fg\WF(QKA>@PY?
7(FZIOSK56;@e\W2Q?>C3bHDOEL35QAd]E+2HMN(L)4KgK_6.Dbd:,34@S2BT^^7
C4-1d->Z?bdf:ANdC__FTCM(/CGbPOR((/-c8(YNR&]OXLXU(2@//O_E)?XH^8=O
<c@D;&VXd#7ffE8dg1,O;2dWX@?8[>B.(e3QgG9:BL;_+G[#1DI=a(?fU::Ob[I\
6RS#2c]6<M?ZY,\?dHURb[TAHMbCafOF0=#Of4MN^AdOCBd>X,@50DD5SZ:8_S;2
T9JZ=J8J0VB6O1UA2gU-WNK>8]^=S?/(W4b(SQ/G9QJP(\IN+Zd&2dLB0_1Z8MIf
8?)/)0\BKT.9aR@071&1IbK^6-S1KM?-ZQYZP:CEV&2d4S,/XB-2@;52cbV37c2E
F](+Bf2/BB[0D:&&=df(QV/.g13(88\R:/8ORLC1aGR,.W.9_=Ub?L[61VZ#B8AT
NI.1K83BCUZ8aC<#e(,@SCYCDPL?C1LS;Ca@6^C-.<\9fH8Tg:((J@Xd_W#Bd(@c
5^51:e4RU4OFFb)Z<HNcO1@aE?Z9SH9E9\D0>YAXfR_g<YZaEfYUY77[_B,QFF54
6P2;:Q4c,JI+?:YXX0d.[V0W3X:B-N1]A7:+1M7O[c[C^2?\G+Y,<fXE5e.[A6]0
\6LUf0E@+D_)>(@#GCS+T^YE/XT4LCgCU.g@W1[BQD4a@C7If0?P,^G4(Ye[\7a#
bc]_.^N2b4&AURf@;[T9R.7D86T;/X.4N6dfL\^#7K;)(eZD5GYVKB)P518cB8QK
//F-f9ISb2F@8#J8RD>GTZ&>#:;b.L6++/3#EK[BJ9\B]R2fbKAeBL_4LN)Jbc5^
;1QP;KAbaFLNX?0?dgcdD<eQbD1K-O6Za[W4C4.FC0#D[468?B0K#22fZ9<,_(c4
<d<dJcI05db0/cg^0?+-Ob6<5GOF#gA(5TLPa.E<[U@IJ17-ZLMSSQ^T5:DZ>(4P
FKPd_ceJ,RPLgIdP2#E_L?[GOJM.fJO.LOWG6.T;;F8^2_[]JD1/&)gEgCf6d)A8
DZeXR^:Z#/-;C].DageL?18dI:c;RVB/U\/P5Y+.7YKZR@.7;ZMJN4PPJaT3TDeR
Ib[&PYG2-.=J2d#JX1C-)&(cGY33gJe]E9P#QYM@1\K=4Lb-0;Q3VE2//H7^dCV+
UQAY:N/@-5P.COU@,/UaM?3KLgf<;-Yf\##&;_=_dAS_,>;7>GI#+(OCC2RI>d<+
I0BZgG7&c=QSc5760<W&4b40/PY;P=JJWe2B5W6;abF]ZBXaD\=MA..2+GG6=gV1
GG:;-bH;Q#NZFdHfET3N/[JA/+^>,XGDKdTZUJ3I_KAU:TM)cCU?(\U1A4PIXCB-
WP:<fN1;SHXQ>XG4ZY6I)Xd5g2LWR/M-a?HDCH,PUIgU-VD6d7Y.8CdC70U,8<&-
,<2O2)WG@DK<)AU&L?7aYfQe>)b#E8XAH2W?6WLD1IMUVK<U6]+B8:b88@B_PAKB
6OR=S/+M&dRDGR]X9QgW46PJSTT.-[)X<M:MT[4BOA@#.A):fUObO>T-?8LFg-GG
,#&Z.3YZQeT#8TIM3:aPaHX=ILXbOZK?R4.GG;>7eF4fA4SEV)#L-7<RZA?c)M]+
?a2+RO:_ADF0QZO@aGH[T\70Z?RedKB]PC?JXVL(\:LJ@aJPdAeeM/O/GRB:-7c3
/7HJd:2A7FIgc+/N#P.\D^^R/FaAH0GINQd-J8QaUPf[9cG>>W/N/gZ/YJg,&NVP
@]^9.)PU)(M+H>fO,@7=AF<2.56@T#Bg5Eg0:APe(#50^-R+c;JLg,OQEQT(UGG]
2T1P4U)gJLMJg1-;SJA+S_b2O&[00O4AW(]fCXUZ>3@K@/bB9@4R2CVB#ZAAS[CV
3f?Z8ITc.eO5Q8@5?fWV]d8;/dC/V#5Nd]L;c^[2[T2O2a.G_c0K:Q;.+1LL]6Ze
(V@0.e>,MYcYfGgE_VA<e@08E37:>\-M<TOQ^:BDRfO,X_&G&b3-eTG[G1KJ>W;Q
IPgE;96A2+#?<D1[=DI0H;<\9:A>;DVU#UbBK#d<>&gNfJD=(g#P;FOAR0I[G.&a
O8->aX2cC))9A<d/cFJ5gL0S[JOW.W\;M<f/[fFTP(:Gaf;C=WSSXbU1<6EM]EI7
?PA@/X9&86f8T0YU2cWIH3;0AL80B3Q;>c6Z:=;5g/L?TXA>0-KVG5/dXJ=-T5VM
XF;DNFB)J7BD-N-Lc,b)PRR:2JI0UHMI4+ZBW(YIJ<E0P_=060B[JLPH+9<QeETM
=)1V,@+TAQgd9_Y_FcOD@<_9R\X[)O.=F+@FRT]dg<AN(W@.a^.G\ggQOHb9#1?@
8f.Sb3BUSWI>b7SV+;H?\[L_?]&H#V9E;cJ=5+ZY=OOU1@c^SH32_SIWaKESW/3;
B,D#0I<6GO#?=C=+a?@@YJbf^1+_a4f,IPdg8CRYJ2W3dBJ8-NbZ2AMEC?Wa,&8[
UfJ)+0C3fVE+H.C/,#-.?_U:18\]3B8+aZg^5:8[N2HR^f\XfO3BC?O]O6,44:V.
5a5.VC7GcJ1aCIFFf+P>Q:9a&@T2::4\PCCbbABLG:57:gR8A=g]203D.1BRc0GP
@:gV@<;/:J2,f>^R]#bDcGbQS[gLcN[>-#931-,g,N[(@X^]G^S&PL?f[;G[82,1
ZXU3g,Q)V7_.QOII[cVcM8C:E4_X\13APWI^16HE,WFU@]O/#(J;5WKcfN)6ABTd
>?+aOTHaM?aRHD#D7>f>EY+FX&QAFb;N3G=>16VM:KbK+@J,8W,b?=^70LWP9&Hf
5)WabC,[)WM(]<2VRV1QKeC>S]O3_)/MP/5cKM>D)>K&K.5/[f=OBdI@S3S7aSe]
,D;G=>WZ2<+;eMd.FFO_3TI4_e)I-bOFf^OK6XKO+Va@95O;5RIZ]MNC#S9WAIdc
:XBFK:7JEX._Z+EYH8^1Ngd?,)Z(X40?Jg@)2cC3,K[UcA_]B\KeH0Z:9Yfc[:=4
BM[N?QR]7V;0Dc2#2;EA6eg^MT/],.UfO1.H/ddEC^d@]A]V&QKLDN7Cg;5N3@MO
R>US=B<fMUTO,Qe--0L?D85&f<]BYA=(c<CHKX7N+T+4K.9E_VbSU^c.5_(W<@);
OO/T(SRO<XNK=W=N(G?dJ/GM7W>H]W2XJ;N8Z#-_0R0>3\:8aF4+8&CMNK^5JL7E
C=OX08:-/\cg3fP-b4MaAgICQV1NEU?EX)DZY&Pf]@J.2LQAJATN,Y5U7Q=-@TRP
^-M4Z;.@X[HPH92C0,T)F)Q\/<bQD#MUf@aNBU+K.-G@#VG[.d1<;H)4M@1C-)R8
^L9O8C/<SLGd7:\eZ@g40VCe9VN/4?GO8=VK]QKE)#PK5Wc1QVe<9T230Nd\1EH(
NgC-2&81>:&PX^U]=UTCL_SZ3bKW\?dM_HJCaP(1<_UV:#fE,_Nc#D?I0M64a>KU
3<7cUA44e@^F>X(c=QTMGTTFXHGf\@D4ZM[8YG/05\XO[&6g#\^5Cb#V]-P\e.-(
O1J(c@XW&[-b>;R@?Y<^e8<CU<7L?S)NBVQ7WFe_;N<?Nb@\-VFSO,Qb0g0)HM4B
T,dVL^fgd\YJ@L@QgLN7PTHeSYN)8GfB=9ZWFM]DRWDI2NgHXcaA.^U0.7@=RP=P
5E\]#0HM_/@C+><DM>P?4Bd]63_/>TJC)e2W&T#-b5I]]gDa3L^;,VDecBN+^R\;
JE/7+2,_]?]AbYEJ9O(4JPMA^<2WG:UN+ZSb6dET[LLVd[67KG+8,L.b&J?L<5dZ
,BI3e_Yc3FZAgF\db=QIOR)4cbUE9IKBV@8/F4J7>DBNDcB]]TC/CAK#]NIN5Ta&
/52+7N_D^G^Q5/OU-_@ZO3O\g:-7FZgMa<Ef9#G=5+G&T^]IY1[PCf2=Kf0N]^NA
91eC?^Y&=XODgHSJ(>>TcCC@CU8X6J[a\[]@C,+If6,N2U#a3a<G<)7D#PA72;.b
8&:0TfFSIET[-M+AV>7aX]9B,0?Hb&8&>aP_PO<XcLM+MAF2W1=c02]Zg4_,:E(c
-6(Q40RW/W\9L>T684ZC<=3de3UJH?=W,D18<];@4W5<N6NTPPP.U;O#8=d@@8?_
2R9QJ9);U.RJWF8Za[X)R5U31)9>L7;c@ZK0fF_(B7GB;B1;VJB+cS(&PW?147L?
aeEKXfBc/=&6C)[]G+HS90X[C#<#OR>=GK7.29?#ISV.[cX\)+fNE/&94e[\1FJ0
VD1^J3^C3ZZ)f5A_7G#4,KF^:4S(V\LUIeP?T+[GMXTX.PKGM#5d=Ba+E&5GHI):
2D/053LbbT=U9HJXK8YE8/>Sf?B-^\;_1e[=HUgZJ74(O2J(5FJHI3N1&5S:8AZL
17/aC6ZPWF:d3X5<-=QU\6G?D=W:RW\DE:4#Pe?Nf-M2gRK+//H/>28^1,\/\Gc\
I7AJU.2U19([]&6,N&_9;YY4S-?(=@D@>[R;1<6JU;UE_ARgHK6J2UX,PD5#/38#
26_?8a&]VCX?;IbL<@M7=_O5/<f1+eYbG2N_Vg(=aI,)-?:7BCSTV.c#UCcU;=&Q
aT2TRSA(MS#.3Ff;C,D5F9d]F)5=K;(364P@5QY_Q&7dC?_+/@L#,E0.::g(A]I]
JE;<C7=g)-=9-P1]#,9M0+&::(,Z(CZB2a\MAFaFNTUf(2f&d]5Z;XKH(>CSNRa&
gSG@[>f-EO@4XU&be<U^(>G6BEI./TW;J#DR;M#Z)(B+?&APTSXLVAY#YT,OM(eY
)V0>fX3-V=8c#&ee^H9Jf_\W4ABgIL+QVce(]eLLPa7]IK2_/NASHLT@>1;#f>DX
9_+T]aMRKfP_F0@&O><L/[\O]g3^D=+FBOCX=]T0E=D_I2?Z,\O@T>GV;0MeFK8:
IU]dTV6.&c\FbEQb.7^TWPTZ;K@fTZB7-<_X9)[[D<3#ggEO3f5O:AQ9TL#b/PUT
,5aTGDJ=2F39T;dD_21OZAN9bQ++C>?/V]<G=PLOV-.ITMVH90?d>QT(),I,\]2E
=/?HOP,O8>4]VcW3EC>?G)S<;(Hf:BCSQ>A@b(?JEaU]RJ;8fW43YCSATdb):MKH
V+8IX583N.af#MBH6C2?>cP=M&9P6ZcU)ZLJfWaZ@#F>O8eTSHc\c:b>F:g,7af(
=D0JXDO=aZE^O7U.K\?/;#O2.77_DDT-aE\8^(Kae=^]ZZaFN6NA#LF#a_b8eCXa
@W8-)+Y<^DH]DR[_[1a625FZe?cW:FNY#g,>3_Q&:\fNH&M_DI;^)cWe;L;4B9P[
X7&/TA+N&SQ4DMEXSM\(B;8^EKY6.BFgB:)6U)AW3A,1ZKX-LVE>gWV33\RScH_2
O\4FAWJUFK:FcU7,ER-VO;A&]>TUd.9^&WB1[]R8A:QO&,@3g5fb)[4cRDNV]>A9
[eO?KE1C9T_C&NA@T&<NNS<PG6)^X[Z[+/JYA?0D:QRFNg#eadVgJAgX^dJTFK5K
dQ09:1O9LX<GbP]cZceHbN0.T1@EfBY8N(NA?gFON30W,\<_1FY6WK-E3<:-&\Y9
WAD]0C5];T@2QOIF-5c97NFI?8#_5SP^V@_]&X68fQ&WKUOC_V4>EaMA^86^RH[_
aFbQ?-[gdgW#M7WL^>Fcf7;:#@&?8f)5)2NH/J[+N+)PVM+(>=66UBf\5>G^>\e9
4V@XcJ-EFEK^]6G^a]L<M#b]SaU7.LL41>3)I[BeB?dFd[]Y?(.=GBP+X(4-);B9
A&&6B5/W3\8V2Oe:D9<1=V8=bXP;KJ50\Mg,))d+J,B)#YII.&WD_EXYFU3QU+_E
Y=NAE(ed(M35Qc@OACT&D8LLeO(B0&],(Jb4-J(K:F:\H@\EM8OFLEPN6eQefE@d
.O21R+.-C?DY07aXZQD7X&OC[bA3S+-G1TZPUM0]gSM&-7N?)5DU]A+?YIF,1X9/
8]?S7?;4E,c>@a4>aDIK]Zf^20B7LLQR]aQORMV51JOX/aAU33-UXdM^(B6^Y4B^
H0R_bHV2R>aGUZ7>W-T8:CMO_AQc>>CLd,ce[8I15YL#9KGFE0b6@XRed^93=AfV
7e_8B2A[?8ZTaDVVbOK-Af59<W8S3aZG@>H:YG/QfJEaO^P_-cG@HG-ZD-A^MWJL
6)8JfEP8W-&/T+PMY+0?G\_LYGK+>C[/G9/b+Da:,8:9NA6AD2cR&S@_cP[JS;(R
/.Y]&KgE+W-8E#0bOP;C\636+@fNZ.Y]_8N99eO5QMWAAb0d#MY_+UcDQ4e=C-28
6\Kc3BC&W2Q>1ANM73NKG#WNT21RPO?V?bGD7NXB8J\6S;,)WWEP<9X./^Ka(46P
;bMTc?^OKg2CMKc1AU\X.@a4E^CQb)LA6LZ0O\F5-MKIYXMKV,S7_03;Aa3KB<<^
3E:X[b)>5=-S>FV[\?g4SIHN<N3[FK<)DOXQI4X=Pc)PK_e:+RfXYLH/c76:0;E?
:d.-&U/=A:QK26QXb6XaS^0A+\(Vd.V?=XS=aWf<)Ge;9L0fHD\D;@?KP)6@5MF<
9,ET:IRF7R5#@Lc.S4[aD_PHBcNF:/H8.VBT\f(\]FTdXJ36gTS#_T(T]2SL4bVf
@M<.3cW:Y3SEH3VW?P]aOISS>cJW6FT70KGcA?f;XO/U.0#cD1M_gA/0\82+g,YF
28S)]6P;2^17V]__BVd<,bSdbU#WOGdRV8R-)3a4B92fSMTE&5\UP.9.Q2S.>91S
SB.MBA&><J@,M1(9\L7YQ&+XgBaK+bLM021\?Y>7&4gfeUW0aIIXAaWbV-U^>_-P
]B(+T4Y[:A.5#U/?Ma:7B2LPb.fdLZ6GQ\8R=Cd.XdIW]I.[aVD33-dPI>fWY:2K
_F607^#&\76IQD;42Qa^];gM9e^9WT<5MbS3d7K/5OdN<>K].2a=R&g#3RIA+<:D
N/^7I;(YZB=KX8_3L;>IE[B5NfQ2CaK[O9APH4eVJT?W^;[Cg54?P6-@^S64TcHP
8Y-R@&#.0IFH+,-6WR\_:a0gXR.;IRXcEK2J+9&_X36I+(N.HC?cUNCF08:R/T.a
FQ8/GIUX#OSbTf1HC[K0&O=W&\8-//P&dOe[3A\UDU-7dPQaDSFP)N>(d;4X#D03
RV\XAb-[<D(c_3Af=\QaA@_OBN]US?.,99)cO57X)#G\e6L;G)C6bOD9SR3>CKK0
De1:?>5V46d?baDOL?,C:Cee=[S3\:7W:]J>5@dXECHH:E3:-R(OIMf08bdY;X<D
JF8Zg,K8NG&Z(db=<?PRMVTS9H[:PI(0\YZU_0K9P-B^b;WJZDQdFb\[G>GL.[&^
_2SJ;a__WO^BG2Y7U=V>6X[P/3^I_S+6;5_?4/F5<=+<.(IM0CL23NL:RT0&GL<L
[0+LBNGY.bKbEQS]_2&f5b5Z#JSP92NY5+O,S:Z(g88S8M(V_O.D74b/+7Zgg(5?
K)KU1Pdb_I;La&F21Ke9O<77L36W9fAKI4&2IG7C?gN1b+5GFW4/e:O<&cE;aJQD
Q[H(&YGbI/RJ7URGG9I\,N8<_Ef2S6@Z1D05\5(X+M^bC:K9?0D?.-#[.&F5?A&Q
5ccC@848fKg(?MIR0cBKRgEgL;<B&:HL.VY:[/+:U9PRY,aTA^#UW&1O_#_^+B8X
O^@@VH(N_&@6c4^Od\1>-V^^LQG-VVNN7X7c4^OOc0<SQ//?+/Yg3=7P#DT@QD_I
7RNV6eJYf,c-\O/Ud:H)FQE#aIQ6IR@(H9F>]9dKa4a@)N:IR-,1VX_PBT]F^PUT
Q+D\,8XL+f>T&fOL3=V\)ATOE&2)D?T1R[1<BaNTa@2Y26PPVZ7T?B90bHfbe2bd
QET6TG]V.0T62GLO(g/U\)JZ=RGZDV_EF#-H.NGK>d3b,&<DHJcMA^83=R@SaBfB
G:Vd/H>3U-T?-I[YL#fR03?:7]U4)\7;&S2U-]#_)N;QcT;+/(U&M+.Q?1bQ?0O\
WE4AOR,-RWbd_>_De_6S[/\cHZeUGAUP?da@gS;U+NJXTSVZ@_g3ZaW=Q-Cb_/3B
?[@[gUJE]7,0-W4>^A6V7Q?P:Z>8)2D.0OVd34J0N3U2TE3,/:cC(C&&VI3V0b4<
a+6I)P_3JOGd,RIIa>029YG.?NN:,?:+&II(P1KX,JaMFZ:SgfAf8D,-Z:RI/4]?
H(@O^b(@HCgdEL)gc4@V&QTe&GK:L7VXC>;H2#T@J^L8a2bD#K<-If]DZP4,cG?)
bZ0)@gda2T:5&/]4N4I\A<<,CUb+>fbCae[;<)]SK0N:J^d\7@4&Oeb^]\DBb@5O
N^PY\?<AI5/VcJ_>DG-D\d13-B[@3UQAJ_)]A_OZbL(B\gDJ6Z/[IBH,Kg60cTAQ
M6_N:a>RL[fEbBV2;[K/A]g;,,5\f=N)I_CLUW4\FgCEadC(bR;2MLT4=[DH2:0P
9(1f+6?<TIQ9@7H6F.+)K2R?.9cDXW.Y)+b^-Xd^Hf,fH\2]:#>)Ya#@D3MW\ZWC
5_\8^[56Od3Q29aLM>T)=b)WKe7-2WH;[^]O7)+4>&^]#SIU.84a50<M,?9+=?NF
XfF1K>c0d>[XP+WL[QWKA_T<5Y]0XRY+^Ff/bcN]FEG4gW#a,bGIa793D9cOH</V
C,E]d5YN=F0^;4V-67DB;UA[JDILF)K..9f&De(BYHB2XP&gE8#GJZ+O6#_Ea>fV
#ISYOOf4[?W(<K:aC_AC1dQIK?OgLRQfW(fbGD7-IPb_=fASYFD];ZV)0P,GTBe+
(1EQ;?G8/8XW\.-b.DBPD&5[-A(<N80=#W,A+13b+gX>aFI^T];/@F08[;M(L,F;
9Z>RN4I6S_+Q\&ZNOHQC)[P7B.C@22IB@;bK/:8_34WVC6^3>1)ddQ0dAQQW^AB\
CY#fbL/g>AWf+^Z1bU+0g2_,KYM(8P2M\RJ</8c,f#\&a#\SN[:Z1Ic4?)0G[HcB
Q2F?g,U8IZ,EA_AG)KZ1Y5YYaRNF=+?C9cc2cYNLBQ-c<J>,cM2^&E=-+RS+1:g.
@c)WfND=/.H792UKIXI7R(C>(8&4KX;#]\:F>,QA/SYeH(@0U&M5dFbU;EO=SE0;
9C:3(3T_CZ.9XA(#\66;)fZ-^S50bI1BK82J_XdfcH>b0LP,QRJY/0^Xb3B2,5N;
.P),RD<9X;A^09a<\@fb_?>eP/Q@A[_DC(eC);#L/DQOKfIRRGa/NBK?@g?].d]^
1NMLd9C&+M?<.bQV38LT:eSHJ6U@FLTFP^9Y/WD]1_/?d4&Z261L/.]^U2<CKP4d
F]QR+MUD1]ER)>^O2,Vg,N:7(fY.2AU4fDQ\<E=_(=D1T=:KYbH_FXZcF+Q989b?
D(.=\dcGd6=DAV+I+N+I,bCb>8a66\I:fTK)=_UA6^^1Ge[P?9QF-L4U>LHf)[35
<fFKYJ_</S)L.PcEJG_J5<KHaE3PCEPfQ2D@\KUQ\>ZYf3I0A\PTK+NZP\]2f<EH
dVEEPNGE/?5aYXW2Z=UDCCJfgG,.THUGI)<E<2DHIR]dFLJ37LL>Q1:e^gJWdaBg
S;S/>16\:F6MED7L=XA1;-E;L=L0e;J(??5:Gf)./#gPZ[,?AYFLCEF(],O&O^P9
X24BW?IVdL,LXZe^AA.6fXRZ3g=E(g?JJ<b@aU;#VN7&aN^_169b[)(1#f+OJ^_B
\BH+-VaIKV.e=JbN]\&Y14f@aJ&H;IQM+[aEBK;&L=;aHP40EW]3KNGV5Q(PSJ2^
BeJ./+JAM1b,&Vd++T.0AW<;R25W3;6]7_LPEF4>Sb8.@V]2gG:Ob]7^61CAO-0B
1KM0[Z9@g(f3>?DC-?7_DA.[Z76Y(TeAJE0<20USWU7?2\.c1?RA?@bcg5A/W4Q?
K,6fb&3R7/DLeR\H>NYB^?PDPfeT=b#U4@a2QOX4W:Z,1Z4IS09LHR2^0;V++PP_
5,PX6IO80VW.?6-A8:\PZS3:8D[SZ6O,-&f^fG5#.6_La4I@MF8S0<#@FCe5FSXB
?X\OQ.D_@-PQ\AM4d<)a8bba(>KS6FQQ]60@gVDf4AM7a+aQ@_TYFI@4CS.45/g3
0aO8_^,MNGOO:Za<KGTI-5(,5=1.)J94?2VN>J1S)9<:<?A)9XHAe8Z;E:M<JL#P
Za9XSM1bRKJ(#N62-5cS64Cf&8A7a0IUZS?<MGXf@fSX5IS+0AOTfX>;K837W-U.
\f<3]0E?>H=#_@SF;KW98e6V81+fQ?1QY/gQ1^9<B?JDK<3\9;b;]GI7CaT1K01f
8]9Ga#:g;[O3OTX0VMeHdJ->:4?;S^a#K5L-U1H:C+fg6QPJ&S63X3).b+97F>QB
Ac-Q#T;@N+fJeQ=e)L[7@OW/F7Y-@QZ+e8?]H_M;&PZYQMcJff56dLPDWP8Ue6,L
af,FQ49U-1Ud<=a6J,S=MDTD?+D;[]_R,.<3BVT>=<aKOb?;4&V+bXR(.e5]-9-&
Z;@JJf/a0I0EH8C_AEE3MR&ERb-0=./,65Ddc>>DA1F7,/Ud4)5)a8;HNeW@aN2Y
dB64X,=RX[bN.1K0J&;LF@SOT61KQX.Cf9JWD9,0KUDT^-HJ-A[,)&9W6X2L[?_N
T1YS@Kc)R2KcHYSQ]5/\=<E[5f3d60,\N.D/(9b0S4[)S?1H:<I2O0O_BEPRZggZ
;f-_[fHI,SeS\E]\9DKaR9UaEB4<:ff^^&dNDM3.Gd,9O:Z^J/CJ.P1;<&FdV2#4
QOM0<(B3b\>E6@8HSO^]D>WZ+R6J153(+^A(?>8Y/]&F1:Vd3VPVfLaKSDdJ[QIY
ZXG^N<3BAVdIX?NXX&.4JAC_aD+0A11If^AR\ARG\==S\GQLVUH7OU5=ES#RLZd)
ac&f+YU>G.Peb/M#O+IFI50b,EHg)GDBFWGYWFLV7GEaO;a5GR94FH?GJ2cASc)5
&Q=(K030(S30\D(/PWL1H@f8QCC.Z2gWTCeA9b1Tg@]^KcRN2GW>5g+5Ea78V>PN
O\5[L,>.QC7.^U^F=g48K1^:Tb+:_4L?U<TBcAaMeFggZCNOO.;16Wccb4..?AP&
+aEKO0R6#MH+DVC#Yf5>]XZ6HOdg+L:PcBJcM6abNY0#EKDMJ\<UD\cCeYS3(:W@
S(>6eABW4SDY[aS[95Zc[#5S(X-;?Ja].DQOc_92gDVQR?LME;(Bd<-HQ+fJNY(e
A6&.gXK3K9[fLCP<gaCF;\&1,-OaIVg.g9OJ8(g+1gH]_E+\gNN89D3ZS7H4KKb4
0Xg\32AYEb_L7S_F]1JH(U>>PY/)8aBJf9\+0;/5ec6X[U8+\G-1;B>1)U0DV<MN
7]F\N/B@BE1(=-W_4Bf27I(C<VYG#NCB;gHa7gB\EP6MOW.N8GW_12)CL:.3V<J(
SG^Qc1M,F+0cA13aBAV/_\W]M/5c9QW98=BV5_9WYAL7]87]T&^,?eeH2>^W:.ec
?fDBb>\KC4M56\:gA=)[8^3@,J6Md8.X<b/==<@L5RX85#W\QVXOA9AD(2.>(76U
IZg]9HLO+g(J)P>@c)(@<c;X+=P-J&+\Cd?],UP>^=/B0Hd&(T;E9S6I]FOaFPV0
cR7Hf+RB]dd_>D(<RF03;>_6?dNJ6=4;Z@R[W\DNa>;=R&ET5YXg7:QANI7/Y_HM
gR=N?]8^WT<M#3XV23[.=&8B#9#\33.8gJ9>+9N6L+6WUf)&8@\ZP2&D>6RPV;B^
[-=^,-/aU[:9P(A[MaY->+EE=X6JZ5CA:4QY7+FHA+Ha=3_<3c_8520J;[FJ-.T\
Ib#a:+KM8\:eg,QSNKODI(DRb+L=bK^^SL6<IFgd;^W<PYQ7FSN_-;_Q;.\9W((@
E>MV-?+e9XKG^XZ5B5)7OOBeF=#^#/HCI[1d_6F>-ecbfMD5U57]@A(ZN,KD0^>)
e1^-Fg[\<RU]K[37AQL-NC;&58SM)#d63GM_8VL//:d=-8EA9dId\HB1PN.)8Q./
+eI6@=W1#aV/BGEa?Q2+L+8.cK3agQVB[ZVfXIg?((E/KVNVUT0G:N.3(Wbb\TI]
D50&ea=dRS[,@RU:f,CB)?2@edIXT7E&>M0?dB),-d&I])A[e;4>Z1<[9d3VCXO_
YR\Y.eQR(?^_8eV##MRE6TceeDW.TBMF#=U\NG#5O/>T.-fcaWTg^_00NORbYLHN
K@G&7;.J8VA?dLVfJ>a</;<<BHZ8(\E6KR9560XITP/?6e,PX./egP.P?8O],_.4
ZRZR(@:5C0eX5-)[]LKZP=F:G\8:DRI:<e\/CV]Z(RA4]BYd@9<KFYRUU#^R?6M(
>IeXMa2DY#R1=:S+1N).Y>5&;:DcGAbB1Pa<U/ASC5@#C=OY1^7>,-<4,OU?:X)M
@Y8Q?dH1?&1,VH7VbH;5^<fY1INF7=\OUdP7KB>T7\dfXCAdZE:B-(B\e<<fc@.:
6gV5cLP>NUUfRX43_L<B7FCK+&,T>(;=Z]/\O28)QIAWE3KHN<Af0BW#HI<?Gg\@
5,f,&75XaE_)eF/ZX;L>V=8cf>19CcfZEUKB3PAZSdQL&):GG]4J+=X/9GB8NR48
99047cL\bf#:+M^07B+#VI5N6UcNMPXXbP3Jc;f.?2]=@aE=ZT)U6gPd&]F@,M-H
GR4?.)K=08.?I[_UR.(F2;cM+-52e2@^PE=&XGTP4UW-Q1<T<\VC1e)&9G7(2KbY
,cgMe(N9QDa.;CfF0&1L?068A05bXON5QBV\;OKRZ2\f=b&O+,g&Y>5561];;aOV
5I64H5Oe]Qa3L(cc6O\NgOFNY</GH7.(Uf/WeG5IC0(I,?]VeE4SW;-JYgb,DPY&
;^(FUSC82J,56-5O^/=VSXF3@M?)Td-I8b@1dB7^a3GbNFDBWI0[+HYX8b>c3R58
Wd.KCg?)AQ2Pf7,>>V6JPGL5035.0&+JbcHIE:1GcaKc84<#[bUXL[6L2cK?Q.=?
+CH5<3QGDJH0+[4)Vd5&AK]P:Jf(Q(RFN3Gf1RWe;V>dMXg9OB94Ga,(cAO:V1.&
R48;294UbJDQ=9D4O;4:;:[N@-^:JFRMR^YX1Y;@\2CB\aO.MVQPK#HUgV1Ed&?A
NKQ6c:c_D1HXeJZTOI_b_X.BTPAB7,CD;XIgN68W4LaN=8SS:A2aT>1L]L9GW@6F
QadTOUMFQ@B+##D=D)8Q91/e[fEVPI\:9V#&\e9OBMC]Y><OXGB,AeHeB,@^]X()
W]JID<F6:J,T:W5I5B7FHQE6:KYd>YE,T1#\LK.7[OIBdN.:cTVFL\VcMfd5a8-@
.PcPRb@BH=d8Oac,R==098P]Y:f2G5IE.R;R[+W?W5+LR50N,,J^P.cC:#b,f;ED
291O24&HaeW1SYb]N/HRdJ2SIgd[=8WU71bHf)QS0eM:\:AY0=4S8WOB@A50:bGQ
M(2e6YM<a3HBF<g\dG)e]1a229V<63\E-ed[PBgXY&P<IVJII87?RB=)+bR_da4.
eZ]2>V#E/;PZ0EX@>WTee:EU62dg&/,RV5/,G.D7GZEJ_Ig;dOS-6_(gPA@MS6D,
R9TC&Y&_?Q.]+ZI2>9MFe7Da+WZG]Y=Z,9>gBIL+IYFEa^M_-e4@RBPS_Cd.;JI)
/C1)]6.=_Scf=f2)A=G0]JFB)_)4TdU,2QVbgR?1,7(#RDZG)J2SA6-,e(8HI:eQ
09BE^LG]7Pe6JI9>DSM4>&0./22G[GcE:IR&A\_V+SE?,Aee>bALMf.DYI^dOcY6
99,TH,cV3]g41QdIW3O5-:X=22=#K0DQ6P<4G]]QT(ZD>>QP#MOVAe[g(+/e]W&b
]f7F8S/-:OA9HT+WW;&EBCM)cN:?K)cH^R-B_U-)@[X0SKF>XPa(]DB&259<BZO1
=UfMV,.D9\U:_72RJCXd)S/VR9U#,FD5+8ZVa]XIIFNJPZ))Wf;TZ&7NDa(RW-.W
&C]<X.((O5-0(45X9MRJf7+^=E7C=#eH_&([Ea8RLZ\1D]A=H\(G&=C>Z<DEcN?(
ER;:,&5D>NA&>f=QE1fO&W.A#)BfJ++.;O\K6B4#g3d,IIL,IRKE^Q<NM_.WZB4c
8Jb]S<=-1G4)/3=2-.Y<<9405CQ)<B-(<+5P212K_)Q=FV,#V/gdZd#.+MaC((&7
WdP#.&LCKETeb&)M[GZA#:-#J&P,[E5T4@Z^GNLcNEfD4LHdYIJ+@\UBFS\5=T9Y
O>0(\+g]QEfRLRP-)L;:>.O-3<9@R/g10Y=6K4<2<;1L2,&g\]XJ5Z4c.XU3\b<^
BJTE4&/HO\8Rcg-HKR5X;IX@MQAKecE).6H<^3T0(g1OPJ0?NH2HPQb.YG&Q,X5I
#WPgZ=J&#V?G5/&OHGdgQ4Fb4=\<UeC+5UHaRNdSF=S.8#+UPQT-FS(_d:,Oaf0+
5ZW>7QE.H)>R0,<Z9:LVNI#=/&CSf&P:f]Y(?3fS90(H;2C;R^>1_O+<CL,H6Z<>
#-FH3^G:5=\P,aB/H7dOW3VEDSKTZ,P]K&O4;bW.6eDFfM_L&#T<S4eP(=Md@0H^
ZePMEQJZ_XRO#a96b95/PE<6aY&ege1N(#=E=VQ-_NTZ6OQW1JAO^LEOHZH4XLD4
H:4@f.[F,L:81>/VObM(:K16Z<59_g\O[+a074@+7b+Q(9)6WR56:(a;]V?,X2M-
G2CNHDa-/FZa7=W(T#GL>:ZATXY_+D57YWO3O[7?;:KdZFL/OFHcD[dX]I#?[5c.
BB,XF9V(4_UB3;,99;e.443LO]bS(D=6dA,Y-G78@:d4_WKKfEA[\33WT2fb=?Y0
Lb^+];8+)YHD(bSJ:9=KC2dAeVb1?Y6VIdFQ2B-,-EP),E+6_\3b/><NJG#?.:G,
JW4Y4I.17\aKE8>KLPF6:&b>Q84fQ9IIPe,4I=:1E@0N0gL?_P+\?^>N(6SgaF\C
daf-\\Y->9Yb#D+Y-9QR;3<eETY[NO_a3a2+G(FX/^_#MdP3V7B^6C=Q)SQcO9LX
_X-KgSA(M,RQ>7U@bLbUOZ._VPAT(4A+Z&#GADWA[;EebRgQZd/OA4<aPb;[X8,K
dBJJ5N<M=EZ1>O2NY5Je&-H3>\H&S-8gJCHZR<fO4c\e62@ET&]FG#\:;NQXC_OI
EP^J,)E)faMR\QM:1d,dRZ3[4X&b7(K+ORMdR#L]_[S93/&F0[ZZG[,/AJD[bf+;
&8YA^(L1RcIC>;N:QTZ:WVJ:bMS\O7:E?]W]C6QIT\#F2G:g3K@NRa)7MDZQ1=WF
L.e/+H:4(4c/1+JL+0YB??F(UdHL:<4+)EJd.a7ZK5L1e\Kg=]P<G.Pe]+2fcMB,
FGZL@PF8bZM:MC2DFI,dN7G2b&a_Q1PEb=Kbf5,<(_4(^@O)Y[,f\O)N)&#Z/TNI
U>;+XJ,&M+a@H8EZ&H5dG#/NN4AaAgVW<U<I^+>NV0A#9&(4(E^W8^Y5&c1,aT?F
0A/2<a52fH->+,0]Kf(=UA1<35JF87WQbM=[W3L1Eg@@-,C^CFF[>U^ZUe,=Q(Z;
D.1V\L1MSX&1X:,@MbGDeaXRa-YGTV(3J.#6a?&?_OKO.]PN99MOVB;eJJ>/:cca
)PCM0TNY/\GN-N;V3U@GdfHVOGZcM[D3C:EN))SbE2aSQ]>8XM7^U.fNJafV=J3]
SLT(NYW/UUH8V)Q5WTXT>=GObAYSYN2EH^ZEJ,0:E.1aKB1>S1cF1&L+gJf(UHAT
Z^EBgaO@]M=:=;P0be]ATQ]-00a)4c0T<-9VI)G_E#Fa4aQd5<Nc_@gYG(Q/V3I#
W8aR1U>/@QeY4eI&)QeNJbd-ZfN4Z7/)ODR5A4YdXeV>KGK7=9YZ.IK^@P,SU:G^
KFBWO,)/]AB=MfU>.>,41@-ZG\cJQ3H\XRRRWKUT?S63#WXLJ)eDI)g?3L18VaCW
JDV=0A#eBB>?:_,<44N,Sa,>[bZSd##O@Sbf/:,.F?=&G[ILb#EeTf6C?eJ4Gc4N
7CD^3Yf\_SbKb7J[dA@RWC@LF.5\[__=;3C1R&<7_acaK_0<W;X<))(J?#QY5+\X
,()3N-/8@<&J_@cMEX@PGg]0Aa]_=+#B5WHORDGVA:->W:J1gM@-]E<G5PGAQ384
X9BWbdK?7e+/<C\AQ<T;)M9D4J5da5-8#:QW/8\.e;+IT-ER@,OdOMC(IW+&(3+/
^.Sa@9FDd())M9\D1.I?PPaK3@:\)E\(@UW0TX-GFT.]8Rb@JLeZ1V21GPB3)U-B
.Jb@A6#B+6E)?W,,U+-/f5DT1&]\&4=_,X<7[?HP1CRUHLKU2XcW4WOT.;4W=&?4
^3+OeF,1I&8T=(L[F6+@g3WfDQ,JCc>(P2&3]YK2A\XOe(@#/7eY;@T9WD3Q++[V
1gRUL?Gc4J#F8XC2#@YF9&[Y5AIVI?K_DKQ#^V+1>+)\+@,3ZaH2?UR5d_b)XJJF
EFU-cf2gaS=)ZC,T860/NV(F#>f[YLAH=fWOD[E0U];^,4b&4@D:K<dd5.&8;1[N
aIdfb,RU3VcEeHbdT0gfV#]<9C.J6EOYY(86W4SG]I2Y>gWL1QaUPIYbD8/#68UM
]1IE]Y)P26FF[c>&B2LaJ9c76HAQ+VD1L\bP[\eA3<T#1^^^YJX]+0@e=<WR+VN5
#E9MM-^AcL,,&MO<;<Tf3gF2VaN]BL&Wb+YfI-e1TJLcU2\)GP=-6X\<09K))Z=-
[aR2/BJS7D?eg_cf\5R]EB=WYW(/^76D;K0F\/cd13afIg>.\X.d#?[A,\FG8J[&
/TUE=T^R/2(6JDO?;A[XJ0Z1EUdOb/&C4^:6(00WN@3N=d\LBDQaQ)SX\I:MRMd>
,&.2@C][^B?&,7I+c085cJ5-C=dK:<^&=7+6^?](DRKK)e>JHZ6;da9([:c73L..
2>;8?0PW(HKOQAg-]K,>5E5+aZ[-@Wc&93W51^^,?@+QDCbM/=:TaX9&V_^XTTGQ
2f@?M/OX-<I&U-:1R<=M[,UbfU14(3<fVVf2c>P#O_NVLa&-,:#HP8/dO,R<[VgS
-(/.,5]S/5IRH6+GGG)G\9_XVg0;KfNL16g;GAA,XMDa9<]G]BTRG]_7B5SeICJ<
/U<QPCSUG.DHR/YfT9-RA<OJK4V3@V?698(DH;MaLc/<Wa6d-Qe[dcO/I3Z2N1Y9
MO#17;S)[K>@Lg&5)8GR#\^e,HO[a.&G3Q]:IO,#@K.ZFJVQ;#-HeV0)WGMQd[_K
+@;CQ-:HE2^VJ87Xg+]F@NMJ0QS3.3IdXY8#23/9e5C&[PA,?_;cVZDK_79d)4cG
3(-SP/[&=(<.,cOQ=KUfJEIDbS1WRfcKGCeJGY:#&G16O7>X>T50P_/SU6+(;Oc;
.deMf]M[,f#F^gc[)VdC2J,=9(/GIf@-B@J0XgFU,\2OcOFOPdD3d5RR-fV:;^,2
2HOOYgeEQ6][2,:/cO0:TOOX#&Z1>cUDN66@ZPT3Pc\Q24G9OXZ-O=ZLL>)7FDM-
1d4>HLK^.0><:E;?FSf)gHIA8M<2e,>4)LL;P3A+OU^;0+<IT(0T4PISa4B@PVXN
R&^\:9R_+[4+8b>6[/^5)2J23]@D3Kb_@ZBBGFGaKXTE;M29PF&FM):+.a31UE@a
bJC2f4?5V,&bM/E11Q3451&WZ73Ya;-54(_AQ_A#OT<J65Hb?Q=K:JT=9S,Jg1/I
P5(3cECOS[;c?+\XQfe@8P.U[HUHgC##g,:>K7XbD^V7POEBa81DY;D^B1)G_IKD
MK^^H.\eK]:G0##cL2ZXJ<a.-==J9I9H1Ie2af=aIXM11E9.\4)f^e..LLbFEDeI
,N_ZW0Td\<>VfZ^EM0-4/830A2F4I/:gf<>^92[)e3Y@;&3\TSS<4-(@E-3;NHQ6
3I[42?g>9fPW82cU))[1(c5Yd>PRe:EQ5CPJZMA:1^dZ/e59;K@:bdH^5^=GH6CR
?UI@IPC[gR3][<QR3_7U(,+f92Ee3DCFF5b+3V]B_Be728AJ,e2Q9g553,ReR=Ea
[1XVDW@WC/5_OR\,\gB_R?6[7M@N>5;b.)gI0\N1fOMAV/45JbVfFP<dcTEgE)eT
b>I4]3.:a<]M/^bG>02;(W8&Y^cAf-4b3>7J5F.F+-b^Z(WH,5a96,2?RBS0bKU/
<S\3:UO\CJcY.(g6_\8gD@;J-\&8#5W0LLfTV/>1ZR77^<R0eXIWB=2GUc/\^C4:
(O(2#EGO(7RJDLQ,6W3^UL4F&Vc8gD/>>C:1Y[_1AUO<OgdgHcWDeP<^d?3@-bEV
EIA\HX.,JN1AdC\G60bX,<A;=3<W5\J>-I@CT#SV4L3,6P<EA@NSM.Tc+C.]P)\_
7A[^Jb2^.W;\b@74bD^fI\(^Q0H]3(21_UV<&HU.?5EV?f8LS7=[Q479_fK<\Z?]
7XWLM^=6W<3?aR8RSY?9eaVDRJJ<Cd6.(3B/2Ga:6J66ggO:@+F:,/8I-@?cTPdC
0f+I5V.]5QZ=PUGA9](?d^I#eEd#^Vc5c:L7>0DRY+L)>>H9XIgA:X_=)fY8R@9)
Z-#]D-@U5b1],_-NS=C013V2D?Y//KI.Fg;/+TGfb@Q=G=H@4=99JGV(Q>/dRG[d
3^4V#:d)XRDHD.SQ77,F+RC.>::T\4D6503B\_K/5=CTd#I)9=5[S6T,KHQ-U>75
c8_]Z-/\aVgAAHO59KNE?06G<^;VEPId41<gZ-SMKY8P]T?XCAHV(&]/cLE1,<#?
^eYc@]Q>\VW:Va@_0#+4T2,40,)7NEdR47SZ53E2ac?E6DbE[64VfU7adYJcMg)+
c)1=2)=K]D+6/V]GUMV5M5OT-4V8e=^:0a\N+d5\RBVTG&g#;/aSe)-6BN84/EYE
W:UY57IUC=-P\+:E,]2bYPgFSCgfCXeNbb&Z8C9NTOaPfN:g]ND<Qg(1?Qd^I3gD
e[</)E7U,aRGLVE+eSFD)MfMG>65f1UFZL-+W6d?\BbYZQe?8B.=DG>Z\)ZZS]_M
T7Z(Ba7W3P\@&L\aALc1Ab0:)?CKOgJE#eA8DdeB)OS3M>:^a>Z]Y)gOMP(E8Ld4
KA(P)K\LXd,>J2ENKWgN8U/F27Eaa=<W+B04\a3>?5)a=3PALEY:Z0+K;/>^>AN+
DY(G5]PZ(8<F0=YEQ_=RF(b[J-H=O;CTFI1VG\Gf/OSg_@U?aP0QNP2,B5C89:+W
fa8IK1&8JKXA_EO]cd)WP0N#[#K<d1&;=:TW&U14DbNRg1CLT#I]1YE(J73f(]=)
#7gBY9:7H2a2E2D94N3I9+IG/=KCYAB)e1NV_6C-ZMP:?)]I>J\1(1^4f+2IN0b1
TTV=8/M:N<J>:A<=B3#A,GUM7@Gf[Ec9Q--LUWVbGL[OS1dBJ.J^/A+T;5&T<F;e
ZIG;L)T1<3UJJRFJ=08CKf^3VWM=[M7)9@)1PDJd<,GQ+KKe[^9+5/(VN\>Bg:B0
]4Z4YL2@,c7;2RWXLCg\(LI[^.(aJMDQHCf-IA]<IN4(,22#I]eT,8W<<^PGb,Q<
VILX<2(aW>+-1>6&(SS>5]N&3.+Y.)gU]dN^GB[6dPB[-4<R1CBD=):&?gKA[^#U
BW:.EF^8P^1QGW9??9+d4#_bE5L>8_fEdf.8DH&BId-LVJYRAe7\a[F??&06(4=Q
94S+X\G@L<d6:7&F6:)-aSOH@\7.VcR>4O4Z(W@6YI#gKNeBN4U+>D;ZOK1^9Qde
LRGgb:6+<c_[PZR^J@:F(+UBG<1AC9GX)_T43QP?>Qd]fP^[?T5SFbCa_WZ0]8?_
<:IA=67;EKOJ[M,KfMHWK8E?&CUZafB=YR@O&\W\/eZIMT0]D77[.@GJOd=W0VG_
]D.,&/QVc@2AgGW_[FH:@H9AMJKJ;@TVdC03RCR+G_-P(5U=d9<0+fgb_TfDJU(F
OC1V(-Z(TLc]HUK.KGSG@c]04e-4;ICBc)@&M?W#WBAYfbU#5=K9^95c.dYDNQ.[
b=QE=[A/U[\AX4QfG28AR+KO5FR=?e#X(caWW2fEP9c<,X@L/:/9=Faf56VfB8(O
W5PUY1&6U/I\U;1?N@Sg^QMO@Nb:P(=1B9NMc5cI6NSf(dEKEUW>^c4FZ@fY#-cX
6VbR>6fVBLAJVe9Y0D(WB,cgK;194)GDUE1d0\XR,_[cCP,I7^P]M:S[LLL\VcWS
2fS_ZE/Jc\S\[-)JE9<FTRQW\VPJ8URLC7U#cMRP4Z#X_J#:)3K[8)ED8;#Y5V)Z
7\a25GU2XGW73>9CAfd.:UFROXC+IUe\T&6?QbRW0@c.D@@,_WR_E@=9YX-.4E.U
^YTQ.Q/C1)H4[+71[1<O/FVd1N(HdU99&C.T#^0NFZ<M)4L2Gf_&RY;[g]XTDHdb
MJ]7[EWU5=_4OJ3=QKD;23<8G7<_47K?(K+aBTQ.C<0E1_(4IPR@S&E5:R@4Z)b=
eH;\:5OeOF(XJB06e[E[K4;)D8;#19[ea+^/@P_SDUEd/7JEd<T.Z1O(dbFI:)<X
f_ePQ0?#5LGJ8??[M]Od+VPB4LbIf28@c8Ac-Y^P7<USGJ&7D=\_?fYME8NVIQ=/
S4PfE5>Md/9ca#9#U-gTCE1&;@#3N?\9C+7;1a8N6bNS8/RW5&bYeVJB\-0/?O:A
4<0[1W22C?S<MFY^FR?_RC[PC7eG1;HA4cg7DKTK,N2JQ)Qf4,FVAf//dU:F^JH&
C-\H8HBHU<S_M1?P2-Cd_>Qe(0[DM>6OS\=))Gcfa7bQLdFS=4TYg]8aW_&7O)AZ
_f.?Oa)8MLM;<ND^Ib78WXU#+[G1Y0N,0Ye,#KE[R?Q6M]RSAg&^ebM+bJAW(81D
RUcR1[dS=E<-9PbI(5^gPe=4))&fK)::4U;R>&DVV1JPW&^DEfAFY3c>?RR)c[IE
Na1Z(?W\4&0&)cHM+:A(DQ95NOC0gcF\6+HeXA(V2;aPQdJA?c=dPK9W+<HIRM;^
))/6\A]gV#)3S80D\7d+=P6c:&I(f2F2GYHL=)bDVI[/=W5[0C./fW:JH568Me,(
D[Hf,McNASQbV1OC[.#V@7EWX>IQ+de2PRJ@cH7\[YY6(^=dC+LV\#L9e5LSS:A_
@/OM9#4cYLEJYSM:(W_0S+L//#?MbXO)E@Y^&#&,<4W(;J(UJ]dN9#=H;V_RB[A0
D;eVT3)1CGIL^2?Wa)g>MS1&eN1;6aLU,77H?FFgQ-]SB6L7Q;Q\aW^9,T/X3c(+
V3]B@UEG[7_dO\:>\C,#/A4Qd5?7_<MF56LgfC+c<a?&b]\U5YDeZ?8Rc#aAL:e-
g8TP16&6_\BF7[LJUGF1M9_CT#=R@G)<BNTW6I3>D4WZ11H@I\WA:M(X:OgHI1c\
3H\J<7IY<>T.=4RGSdV#O8RWZ>>eH)>=c=S?0P^OMcd1MDBZ\>5d2I@BXdc?LHPY
UB;H_<;93Q@]TbZ<;X&[e495JbFGfb#I5d<B,4aU/=.eEZ(2FN??J58&[2#D2C\?
+[1G>;IZQM\#QT_-?7Rc.4e:DcG:b6:H)K+RFfFfH#9Gg3:eR[K#8J7?agU2UZQb
/XI;]EA)fO5034=K]=1(J+&6EU[C+UO+ZXbM19T.&)(8g+M5@\/(5GA+J58:cQbG
DE@dW[(bT:a@:/2\K\9RLYP:>5b7d3CJFA(@C<;@TJ^dO#9.:\@Q7[b?CY@/.[?>
3:]?PB[Z#g0cY6PIJ81.e7Z0(_[.C&P.dgbNVTaFSKE\/=H8>K?+(;HN,?#+^AK4
4+N<IJ<K40T5,UUITUNfP/[E:R,1b@MO+\HPXZMecW\6_(EL:/HeQg=&VUX82-H6
X9OdaC=T.bSb4]<0Q5V]0C?<-H9^EPc^ac&B9:@;/Yb7@3#41WZ,7)#ZMG@,@b\#
+U48fXaX,>bddd\PBTJO2DE9_^C4:63>K7=3ZeEP&;b/TA2-Y+VRE:g(H#VS/.2,
A(\?.-[+#Z4FS>_30W^G<L\GB;T<@#+(7)B]0eK.]KEN2gaLPW]].aX)Qc+G?U&[
dQF2+;WU_D5VG\0=67OZ;WTeRVL:GCPZNY\,K=Q&LOKN)X,<RHT;?DDZbdKW-Q-3
dW(OC@74:Bb2\GOXVE1_e][\>I25T#ARK0-^5(e+C><\/7RFTYFR^4YG+</]=-,D
\@A_E8;=R[8+Gf&P8:_]GG7Q;LfAS_U=?>D:I-VX&=>@E#4PIG?<4CM(M=,RH_M-
7F8>_f7(J_</^H4E>-TcU/Oa;P;<g(e40cSf,LR-W>&C3EEf8Ua0(735DWcC[ZGN
>SGJ&OGWF]fQ<M?fe-]gNF<-3\L38A,(N:Sd.dO(Y.cgMb?ADICfb)LIcSc\=g#B
e=-F,&deb(]A=MI3=7XPBR5(c?4Y9BgFcgWYJ2)K=X)X_P95T(I]E##dd2014MVS
,@f-g.PBF+c6^6F7Q4B22WfR>DR=69VUU&X\0FaX1N-)[SAA;MK_]_?B)Bc36LO)
AgXgd9WK1<ZFR)P@HfEXgEHWT)6V(+gTB[]QUOC8^e_,b&@#[@Z_UcH\L@dR:1fa
D;4^dU/.L;1]/Y(V0+eB&?WGM[<C?+#C6&aK@b5F,C7R3^324B<(J]6[.HBW8(Hc
aGF5QB=(<Z@>KJ5GMCB.T(f+9J>?.FdX03?WD.+8+LS&L>E_b&<M4@+^\[ObR/9>
MBb4WabIZQB)<[P.F;80XU_/,(bFDC7b/KPB2\J=C-G)?L[e8/5Q9D]E.O945D>9
eL8f_X:R7J3:I,.7R0O:&^L(Dc12=5?0-_0Z#46B->/YQ-H^g6@TNQa/Q@E#3IbC
(6E31DE@ZJ#-G=5fPZ0DJ-aL43LJR=^4[C.-agHEB^H<W0Xd-fcRZ8Z5>=8GS];O
BDTb\bH&c-WgK_2_)7eJ(41Lc=^OaHM[P>M6)L,AgN[fU?PU9PZJf]AHT.W)K_)X
I-Fg,MgFJc:YUTf=2P(ea[#+@OQHJD)X(9M<;g]FaS7B]6\WTQ^N<=gV=_&FggV@
GU;aUS1J:+.Xb)<9I)S24]?N2)AA=C3QfbMTK,)a[aN@.EO+7T^+@/8,Ta?C)=R[
/[.fZ0L58<fcJJ0^@8E+L.AO=BWcJ?YT[c;OPd\S_-8<eCEdO7#HY,Q\U<<DSTOO
/_eg5M0S)0/AMKP70\.M;3RD?@fQ^:(6F41^N4KOIa>N?9N\M7.e>W(BDZKD<&[\
1N7UNLeK61I[Y:aD&DL^ZE70:X;38H@C/bRL)_GH(Xd1EgX)&)H_b0>F<FfCXIc\
7.VY\b^^7YU:FWKK,f+7f/+1T/D:FOXVgJDRQVM3?g:R.RIT>.gZKS#.V/c^=^bH
6:aSK_TP-6U)acLfKg9<KP(4^V@>;gHK,^BKG9=d]&[f]aEc-2,.S67199V45^TE
=1V3KMcb1g#gRZ,@ZMVRTUBSX[)AV_Z[f2Aef3(?H_@U]WJeDga)5-=(/RI@JRCd
QM^V7;<Q<f+<9[W@TGS0SSR4fU\3G><fVU<YT(5#a2-KJ#,(]4W.TSAA^HOPG#e.
c3:&_Ob,#cVKf;(;KIF/ceg?RPU9XZF-8IXgP@\;U4M0S5-[SD0]b0:gN?E>L=[.
ZA2P+8?;U[eUAeW=E9e5<8gMBg>JFaaL=E07AA95f32X66-S(R)GM@WEc20I(ETB
HVQ/LWSUK]7L<CgYLDWJ^NY5.FR5A8eP41SX]W7V[GB0C]]0fd@<Q75Y\RS9UCUK
[&(#M)N[e#gaU+KZ[X[FSf.B=<(I=T\)+,).V3H8&.7RJ>O53]AJL_60+([^/Vf^
>K/->ce3O/AL>45?8b^Hac;,]7H>[I:ADSH3:VI-8R+[L=7]U:61eGb>,@3EX1e(
8\JM:X,-6<;6CQ4BLKc@I[aG@]];G^2:5#F@VCI<ONBF[&HIO:20GT6Yg4Df(<4=
:dB,]&C=5Z+L4<S+Q2RR.HBLFBK.:917?H3GZ,>.[=ZTP51eC_Yb2[9gT0PCMC)2
d1eb#1cO#6H.&M[^<T^)L^[82H/+=<MBA>N_3gU<)8\_L(TEWd__LU:Z)NTK;.[8
eJR97>-f\W>RYVF?GL/7R9WNSa?P_gLX.fG50QWO^.e]-Cc6N)SD&H44,84D5URT
:A..?O79+\3@Y1YDa]V?]fEcI1ZI<5.g_?X6-V=>J@R40KfbNPE9<K.B,G?O;V&V
eC(T<R4Wd0B>,H.28OG,VQ@AZHG+DN#N_(S90ZNQZF5E,_LVJc0>C>F[#,=N.[9+
:cNRY:1)V08?_;99@bf9H3B:E69gMQ>]>[ST5]YP<aT=.+>1g^76/.1;LF(UK47a
fB5aL38RW1^\(ff<\\gX:P42W+,e.71-19F6g300eS9D2R&>;>BORg0OMX#T9Gd-
G8#&9NLY<5FW[WXE=GLW)Yb;/bacC0]X?RM)(:Dg5d-:8=\Y_G,]5I4-_,V\M+a2
ffYA6fL3DQbbTDV?=NdP_P]JXJJIWLO:eZg#Ac\V?W/V\;/]1F-FZGTIN_B=(OdZ
WfSde):NNHFW,]5AdR#^5W]06_=4Vg<EHND>MS0XBUQ9&1TBfDZ1KFbOSMdAgD>P
d6]X0IGBTb&N(+9^D__e>\I7(9],3e81DM9DX?gdB,&.Z6#IL)DReCMO&TM-X.[#
(U9ITUX(_\3#Y5bNI\JF\9DQ7Z\7bPXYe;IYX?MYcW(<QH,=Igc,.e<E\-f9C,Be
NX[VSQXfPJ2./S7FZ[#FUSAV;[8I+&e_@[ZR0<1]5S=Ua.\b_(OIb-76g[LD48WD
bL<9G_LQG<E>7/I>g(^D^dA7C,bZY06dK/>:Q<XA+YC@YLBGDc6^_3Q0]->?UJ[)
U2\M0^H>WSW,a[7V&4SB&bN-Q_bS+,:aX;N\f2AD#6DFZBDKGCRMe:4:-30aHd1[
(I4a<Rg6^XLdKagI3.gLE16X9#SZd-)4@.5TK4YN,H31X[NgBX=2X&<b--T:Z3\[
O?(ADG\2[fN-CNN:.401WXDK;#F^M+[8,:d6MZI.=L=46EH7@2,_c(2=V3eIg]b:
_X-5C::cR0Q6GWN<c\IX@1&B@(VgQe_>JYfL15MQfA]6M(^<4\086HLQ7a+UC)Z6
B4U^KVRT9<:HVWA86;bRa?1D32;]Hd,\ecLeY07)bAa/#;Q_X^ec@B]3J60/2H#3
a=GM7RAZOABEcBEI&5Y+TJNV^QNC&CF5.J<0NeV^INS<cH@TT)PYL^6Y07Y6=fW2
+:OC35F^g(de4@9EG2/ddD[K.PJ^LCf\)OR=AM&Y9?):Ie_RCVUH@J\3c(R72MHL
AU)->&LJ-;+Q7fZLeO.NO/5.<?6SWR1/1<&:^?01-;#6>DcP=O#K\#W>G@Q5(OE^
H/S:XO3b(EO6E?(<./fK3,)/GfDMd_TM].&(W/D0d\--K:Yc6.3ga8L3b,R_ZQ,:
SS&>^0g\DP5S]M_D\#8K=&Z8-IF]_N[U0.@M+/Q:QJH?YHQSg<DFA#6EQJMEe=/@
X/7DTcY/UdPb],N4QfSWgG=;7SHbbK6(.L(L9B:2LR9(>bHb.KCG^<5>b0Y&e^=e
))U/9PbV]8D//Y5I7B>\)Q^e&2f9+PK1-R;3Y/(WT^Y]PcO[@JEgXa@I8[7KHF([
J)#de>gfe^<I,YWX-T&-R][8WffbLJ-6IA2\1Z:8IDcN\G5]&\e7OJ^a#)YNfH>R
42FC0?IBWFBZ9ZN2OJ;QX(+b2HNL?4>X:6/]3K@80,G#g#]>M;gg\KIScSfD48U3
?aJ.EH=aC.-:=]Y#K+V#J6FU;U?8=/[AD&160LaC>c:[:g,]Q6@@>0eIXbe^]C)F
?56gaf//KUZRVF=SJ4?ZQ9eZ0VTF1gW?+V=QC</eY78&B7fcO0;-6&X1GD#-WR_g
MGK9E4J-.b1L\:Hd,^TFHZ2NTREBgC][K6fW1bIR.L?8F))22G7]HFL&Bc2?;TVJ
HQ27P3://DOFPaZafAN:JU]]TV^<1@^-gcW,F/cK?c\[(U-(JfR8)H0@=?cIZNDc
eX1c/EJ</9^YNbO;WdC^CL-c49aJ.d7P9-]Q3VAO<TC3&]AI(,(PT;/FEE-2Xa9B
SW3A@Ze#c7Q1T-0(4Lb9\(4K5a_Tc(1:5SAZTP\KDb^3F#Y<b_/GLFaMM+deA^MB
]>,Zd(M)a1\\YJ[a//ZY_86gbZ4ZP,eJ_C>a7M3IW/dgSW+^A/974f06;J[0#e8@
H0[_XSC8<=#dI(QbfSRM=K_O/(Z6RWdC2_QDA^M:YI_DN4371CL]CT-+c>O7P93C
Re#>R,TQ;bHaO0>(fBNgdC0>M?)TMUaLPceg^.P,SAC@Zb1[Ha[AMO8V2=dZLH63
D&)5PQBD@YP)P+[RMM+e,OBVT:Z)gKI@gSTe#SF97D/Kg6cY#]\D?,]E#NH5BQ;Y
S?[Oc:W#?^Z3=aaMAG5+Z]F9gYTDXI?PA#g]&W&.;XWd8JCLHV4+S1O8GKd(#7DI
I_XcXDMNE/=d+SbA6FFS=f\KWF]C_9SM;=UNgGYX66=>MTLZ^1+5S[dAD9<>&?.c
3gXST0ZHX7A]WBB8<.;UNZ5A/:\a(?DR\eZ/J),Sagc(IS8Q<<eD,dIO6KeU)4fL
XP#<,fT=JK.gbP\#RCPdT:MQ/b?Scag()DUbUGC?;VGH&-MCT@0Z9dY=bE\-7@dE
<7UdbTF&g)0W_B)YS2)b6J7eaZ9,OYCGKN[R1L,]ebe1Y..)X.2PA#Yb4)5?CR;J
3H;D1RWcL#W@A^YGD/6T_^54NUd.CH@PK]H+^I(;,E8H8;YgdJb241,9WG7fKc<.
g+cg(e4]ZH6fD,>&0WR<AD>S],C+AXSJbLR(#DFBf>7U[0:];N?L00X=2IF-7YD#
\g/--Lf)Sa#5c\b/0@HdQGBZ.+N=>ZdV6S)</J@ad+.060VbUL<;Z05B6,fG&QA<
JR.+Xg3QF2=01R@6&3&^g/;>0J-GP2;:Gf9#LbG^5EX5[[>AZ8cA._<#136QP(=M
XUP1Vb6c1[@DIA2d#Cd#I+eGF6\04g(Y^;8>KAW5WTdZZX8&;\[HA3?S(<2GgA-W
bcP1_F9EfXOC-_V+#U)J-XQ6@Q1SV./A3.[M9Pd2?MPZC+gM4#D86O1Aa,AA\EC3
Nc3FgQC[4\-dBe0dZ8)F:aY99N>JX=-,GOPd8=B-/2WINBR[ZY(bC:[aAd_P[ZZH
V1IR<E+8XPGZFGK[PM+4ccHV^_YQRZ_R0WO15S)G0NU?2IX[&:L5;GJG9X.D3GJR
WU;H(L+Y^.>L(D+#5c)QZ^MQ):Y[=42)#_TYMaX_gK;)U>M1ZB0DL-aCE[AP&f0Y
YO@G<6@Cd8G4XF@F9HT6W,fMgS[8(8#5-WI)O^c4TN4aM1=:W(579&K+:UgZ=PN=
8_@aH-e.F1AOWaSKR29GEb2c34H/eKe)[([Z^IJ1BX0P.H1>_.=XS#YEDDeSS&/,
VNR)FQYDg6E3-]0Q:H9AV,:YC5Cc-S5fG2)I-YI9O0P6]41BHZf:S@\;]]?-fU_5
AB9<8B8<\JV=&\V\T4FF17-GUdX.c6LGG0gPcA61#c#BWMYG(7.=+\9g&ZfbV]?^
.M/2PNB_:<URSX]P,9?CK>J2SK#^7.QYFd.6\U3R_:,?\Y1C]]H5A6bG:I85WNR-
G#dF31LZW4D]ggbL14#VA@A<a9/ZC/IfV?12IZ_BCO+(&3b):c9]/R6XJ<Q6M&Q9
K>ZPS=>fORTL5XQE2/NYfY8_DHgSLUe]1]H#+d_.?P&Z+dYR8DRGD8A8Id,Ea-E<
\1BdcSaae5<1LLXd0Vc1]UaH:)[V_Y05/VBf+INe#HNY:/P?eUc1\;X5c#Tb_0;b
_PEbfFM:<T+/FOb.8gN>,B76.aO1P/EV>\bDY]E6bg[=E0:##XY;;ZT?-e5H()\:
RC;0U<.D>5/fNe>.V5-3FFULV<B;G,c#Wb35UKMNVZ2U_K-Q^)#]6d.Vd7\STc+C
L6.+a7^)=+V39^&@4F)^5)OBV-(4a4bg2((JV)g4.]SSFc+);A7).N7=706Ce2@=
(,1#@=Q_aYdc:HAN^c>IG@PLS>\J9N^6R>+ETM>5:gdUZISdgN>BYB/8@_4W+8AN
WLDW@^0-O+9KX_=O_,F9cgaNOb0K0Ua)OHd@4&>;;?9KC2&_84T?J>A(b&2RCC:G
1ESBKdYI#Y/D>6^X,;P/+,C@N<X<6J/P[d2EO<OXS;9HaI7(\_NUMLKIf=a9=E,O
5M#1G0PgR:I^^A,F4/#ReJ2Y,R?O,_O&&O4WJf?@g4M?-A?bfH]I81_Q-GSNWY(Z
4eST8.\L:c_E.Af,5Eb>FK1ZC=PD)fe2?#4d#K3D8&P6a/SD)+]5.@IWdfag[@H0
=@DH-O@4bTT/HZ4EYc&4),d(MN47\C\RcZCeHgDK-5)G&GK4<K\Q_=B.;]TB64MQ
A?@MF\F/T(C\M&3#FW[bTB480b(FW_VVO;(;A#ec9WfQ6BKe#/e],6DSb14#+PAF
0>OY-_]4/L6P:[LRedY]ff&R1;X\/ZB:R0-/7dA.G@4e]TS)J0QAK5<=_a<+P/<V
d]e<F=ZHU7fL)267^T(K;d8+KA_-D7U=+]bW3?75P;@B5bB;IRD#@aIdbGbHYO?-
+bJ2A-JgW9W0c&BI7)1A2_(N9>48aHT6AX48e1Y[[fFCYP<fF,gf;V18Fd(]g.F>
MASDHV>&.3XRf7\:NJTI[0.0JAOG+J;O2LPT<C)=bM)OG9ODH5_4Df2Q-WQNE([(
Q-2Z_6,3,f==3KLWQ_L]cD_47JAH43=5TFL#-b(ET<Yf]5#F7+@=::@W<LS-b.62
VM,T.,/IEb8f[3@3AJPGBJ_Y9J3dcCa=24+aI9PG>@MF(7dfUKN\,IU6Z(6TH5,2
/^K1GdM@P0dNdE(NN@:@:G/Cgc\@XSZ-E+:&g_7>2#[9OG7=b3.;+J<eFMV;=E60
8;C(#6[4Eg6K8=5Z+egW6]HSEF-</1RdG#4W9>eMD0M&,0&][OVOF.Je/VR;D./C
41L-DYY&\VC4Y-OPHY;M9_dg>22K^QI]>&[?H\(gaMC(J)ScfYJ)J&0^H^f(I=IV
b=(:_W]<e74<I7M#/U/I&1@g4BC9]cZb:<.S70+IJ#E28Oa#_2?^[F[MNS3G\/.&
\fWH40;;Q#6?)R7Hd5)?e\9X0Ne?&P=LWc-ZcSK8NGR__I3=/U[@f3/XZ6+PIfFH
KTW)HJHL[I:O;M)Z3cETN]WC9F.FUI:G.NNO1eGLb3Ag\7WDX&;eVE.]Hd^MeDCQ
VZ@6aK,>-.RA&6M9C,,:;_fW^2V)Ibaf3/#6BL.93C)[)/aBWX;2ENP4^OH>B/g@
@@G0X@F,:EbA1a[J[@AF@@3A2/4AgfF._^MD,EUgJBCLRJOgPa14(d?DV#?OZfCB
cJ)CM_BKHD2E@CaeN6P<FWV^HZIW/H88++[0E\QM7\O;R34M66>dY8\]6:)eZQEZ
ccO-dIW;N\^bXR_Hg,Z(]K7BJ2-=aeN1.[F[<d@J=\a+-[9<:SRSK#YbH-NLHbO2
\@cf?VI>&^7]2Ecb9G^dSE.#J7K[RKQ_0Y58O6LHODP7KOaP&Q99Z<D6&4Q+YUc?
SV9<EE5V:Q6R:[8FFL:ED38VG?#:;c=N16cOAc]A,/M?H]VdL3QDUc;<N.[9+[eb
V1]==_8D=6Wa=2#90FQe)H27A=&)9\TDXAS4#8e_,2Ygb/_:N5>CE[d2O=+&HEW1
N(F]J#GI&UN4Y2YW(/aKGG\.<WG\#0TMbVe&]1E/6B5eSY&:6:[UU;2KPPINZ\.7
b&1FMFgF9f7L5/8YdPN5]b9?UQ7b9LZ=BYLM^,fGZSMDfC@3M==G4&fL]eE3-H.=
&P<Y\+_)cJIIEbJ7-aZ>>/6aBb?29fT]P6X:)&J/ceKDfA9&[G8J2S)JV0e/PM4:
VH9+H+GNEW&KRL1^;4TYe^WdQBH/[XcL355H()6g\CJ9==BFXY8Qaa:0\871AVCH
\^IEW)AGK8WPT899F9:3JCI)GE9PGXS#f.,TA5d@Vg(;509P:NX^+fN(3?-fO()M
)Qb9dCW9.O,LQJQ]5+F+eHQ51f@:^W^(AJe7^\8S=0IP68##;/UZ_9]/E;+M<fM]
,EdIC#0YH,Cb7S?KN/UJb:dPZeOC1F[J_2KR[L2+.D[)WA4P2SA\XDLbT/OYQ._I
g\J9S-VG[B(R[CN5H6KZ(]].7KYdWA9;2V>Jf^@19(]Ye+1V9J&R=(0POOZTUVY4
==R)YD37:CSGXE95a//;#,O18=JF1<?cd^7:P;P3_=-+]U?/YG5=M)GB^K9&gW3E
K_F9WFT^LS?#2f.8]<Q8^(HMQCg=@8?_Z5D.GD]+aK,SA[6/cFE=Z6EH7J+]M+(Q
4P/b1N9,7_0:N1b,#+BTA^_K3771M;Z7_V0./A;d]^;?J\RF[gLec@9,]c-1ML0b
2H43AK6b<LR+bOA3MEb0;Y+dL2J,UK>6R?W41>(5aDCIZEHENQSH0f;:OReN)(0A
-M5[FSXb]d0a^^9V(73IY:L>ZN@RU94e>12NX(T=J^74&-[agOgS8OXIO+^/af:e
IKX<d?\[C:Ec5^&\)ba3[^RLe(4[<L8TFB5DOV.7N2WcPYD?-X\CHVL[V5MUBL4R
C4G5b<gKOU6FK1@G]?QH3=O@0OX-5LYVB:HaR2cQOc#/8VeLI<B2a,0?,g^]3U?O
)gU=@CC=gB3<eG],)8W31BWXV61@PM(-a_M\gLbJ6J,FGNUU^\@XQJ@7N:<V&HSR
-=Lf5J170(@+Hb@,da4a20]8T-d5P=WC@H_SIOG1ea)?81_cW1LW7cC&VZTdU<6P
/CIe<c7b5.0R,aU@M1+aec\OB\PHP4EZ6O,ceZ]Tg#)4I.Dd(2=e@fe)N<dJ#9F(
1MP@dFF]OJM\=3HFXIY/;fSEBV_N72&2C#I@3[JbRUQ->fa<EfYQMF@OU-5YEfOL
/:CR.NFcgED:11d9dBC\d3Z@&2RU_C21=3)JceLBLaK:=>1;a##Cd7.=#eGU+_f=
=M_#bZYI8aI:L>L.Q)d\ULH[]N4S@B.P5MVXUW+VLAXC<R(d7B#6Ub+ITg,ZS[cF
MR@W5@MZcOf7#f=-2,/_MDQQV:3H?1&=HegGMCaOdfV.65?YUJWR8&PUDX,)[-0+
(L#JX&IQSaE:g^/a5TcUQT\<cJQM>=E+EFRRA2e^?9,\BTCZL5-b65c/7Z41X@O/
Bb2g8aUIGATRQ2NY(8f@1(Z_;+0Gb=)6I^R;(5R>T8P+5\S)U+fOCG/\P=@G377<
Y<0X&Nb&O1/cQ7I@Q@3&:S>eH[[1@&U:+UTC0RAKEJReUBN+\H/:O70I,F),=faS
#1A+_L0&)1,a1Ra@4X-8)O=5,N1fZOFHHM^Z;e8E#53\)E(e-?Q,b..BA.N8^E66
@dWAf[7>Y1Xa-$
`endprotected


`endif // GUARD_SVT_AXI_PORT_MONITOR_SV
