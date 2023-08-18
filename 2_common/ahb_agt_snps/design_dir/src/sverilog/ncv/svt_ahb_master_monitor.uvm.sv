
`ifndef GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV
`define GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

typedef class svt_ahb_master_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_master_monitor,svt_ahb_master_monitor_callback) svt_ahb_master_monitor_callback_pool;
`endif

// =============================================================================
class svt_ahb_master_monitor extends svt_monitor#(svt_ahb_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_master_monitor, svt_ahb_master_monitor_callback)
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Checker class which contains the protocol check infrastructure */
  svt_ahb_checker checks;
  //vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EMAZLtiLc4Sa8lydtx2/iAvDhPSTf7EpD2XsJKWq69bCKg32kmMXC9D6nOd7QWQI
0L11j+A+paqhYz8g6FNDwMS9yDp5/fzK0adyfGUSeIRe55nZhhLn5zcDyiRUA8QX
inbgbii3+XVUnK60PHa5N/JfY+AJJLI+dFC29xNj9Su/HnFI3S3+gg==
//pragma protect end_key_block
//pragma protect digest_block
41i96c8KQyrsxvsLjHPlvfBjrN8=
//pragma protect end_digest_block
//pragma protect data_block
f0diJYuWBHBDcuoJFdJqYIKfvMU+QIlcJYJ073XyN+TNxkKHFBNngcqfIeQLwu7m
QfmEc8j+yXohxhtWjgkCfqTR3zmA00sdRqDg7beGLnGEmuuxZ7uVzEKzhcMJN+aq
NrXR2WghMh5GaDxNhFj2b8qGWOcXimI42UTi8H0QNXas7kt+bw+mS+Fsb2iEmF4S
W6avR6Di0Som1od79BKPePzbRLouAV5mUXenMAhch+e1URYcrotoGAbwZtp1GMLU
Bf61eMqJo1nX0tCmZSpbPymqTOlmEu4/wCpfwRPSARAtKhRxOIibLc2d7U5ZwmI1
hNrAix7PO1R2C3kQN5B/7gWU6Cn9+wyOHAeBqHI+QN+GzAzmdEBFokdrQBJAH+CC
U4BVYiJNxqRGG2SbprXtLmYJMsYAPxysdI9m+2O9AyX3eEgZ45B130jZQ/XP1M7O
ksNT+oSIPR9QsDAZfnCIFAsNwvlLXWUf88WOj4axHoCx8rETPqU/8uY3yEEnAq/p
yVuEtiB405AUfALe+pgRQt7DqktVDB2OYS/g8+3Y0vH4lrdZnZuGWGpY/I+pWURB
AGc5BEEZzl4acN44xiuL4ljM/4VuFeIVsr8JABcl+5QxsWgdqohkNUwgsaeCG1fH
6tgG/edf3IQq0QCSB/JU2uCWkbpylDwsOC9hQ7AaUOE=
//pragma protect end_data_block
//pragma protect digest_block
VJ0rXx0RsoAQBnU71NpYlwA/kXY=
//pragma protect end_digest_block
//pragma protect end_protected
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Analysis port publishing observed transactions as PV-annotated
   * TLM 2.0 generic payload transactions.
   **/
  uvm_analysis_port#(uvm_tlm_generic_payload) tlm_generic_payload_observed_port;
`endif
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  /** Monitor Configuration snapshot */
  protected svt_ahb_master_configuration cfg_snapshot = null;


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /**
   * Local variable holds the pointer to the master implementation common to monitor
   * and driver.
   */
  local svt_ahb_master_common  common;

  /** Monitor Configuration */
  local svt_ahb_master_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_master_monitor)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_ahb_master_monitor", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`else
  extern virtual function void build();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase (uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
   * Extract phase
   * Stops performance monitoring
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void extract_phase(uvm_phase phase);
`else
  extern virtual function void extract();
`endif


   //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  /** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_observed_port_put(svt_ahb_master_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void observed_port_cov(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  /**
   * Called before putting a PV-annotated TLM GP transaction to the analysis port 
   *
   * @param xact A reference to the TLM GP descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual protected function void pre_tlm_generic_payload_observed_port_put(uvm_tlm_generic_payload xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a PV-annotated TLM GP transaction about to be placed into the analysis port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void tlm_generic_payload_observed_port_cov(uvm_tlm_generic_payload xact);
`endif

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_started(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void transaction_ended(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master.  
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_started(svt_ahb_master_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void beat_ended(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void sampled_signals_during_wait_cycles(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when htrans changes during hready being low
   * 
   * This method issues the <i>htrans_changed_with_hready_low</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task htrans_changed_with_hready_low_cb_exec(svt_ahb_master_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called when htrans is changed with hready is driven low by the slave.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void htrans_changed_with_hready_low(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_observed_port_put_cb_exec(svt_ahb_master_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task observed_port_cov_cb_exec(svt_ahb_master_transaction xact);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Called before putting a transaction to the analysis port 
   * 
   * This method issues the <i>pre_tlm_generic_payload_observed_port_put</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A <i>ref</i> argument, which if set by the user's callback implementation
   * causes the component to discard the transaction descriptor without further action
   */
  extern virtual task pre_tlm_generic_payload_observed_port_put_cb_exec(uvm_tlm_generic_payload xact,
                                                                        ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction about to be placed into the analysis port.
   * 
   * This method issues the <i>tlm_generic_payload_observed_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task tlm_generic_payload_observed_port_cov_cb_exec(uvm_tlm_generic_payload xact);

`endif

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction starts
   * 
   * This method issues the <i>transaction_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when a transaction ends
   * 
   * This method issues the <i>transaction_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when the address of each beat of a transaction is placed on the bus by 
   * the master. 
   * 
   * This method issues the <i>beat_started</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_started_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when each beat data is accepted by the slave. 
   * 
   * This method issues the <i>beat_ended</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_ahb_master_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Called when wait cycles are getting driven during the transaction 
   * 
   * This method issues the <i>sampled_signals_during_wait_cycles</i> callback using the
   * `uvm_do_callbacks macro. Overriding implementations in extended classes must
   * ensure that the callbacks get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task sampled_signals_during_wait_cycles_cb_exec(svt_ahb_master_transaction xact);

  /** Method to set common */
  extern virtual function void set_common(svt_ahb_master_common common);

  /** 
   * Retruns the report on performance metrics as a string
   * @return A string with the performance report
   */
  extern function string get_performance_report();


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

/** @endcond */

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+N/wyd09nic1B5udkrfKOJUxPyk90kXNZektct5N2BiqjgqBETCNFvwGHkcIBblt
B9OmZIFUTd+t1lqidwpde6Sm4HKluzrBLzgEs4fhjxpAT66qxWRRHELXTy565Tay
lrf5Vo6NedD30KqYvMKmOUefJBKtpV1skFXWIM07SGVmKIm33+ua0g==
//pragma protect end_key_block
//pragma protect digest_block
1NT3vq6NflJZR5UGv88cHUgWCm0=
//pragma protect end_digest_block
//pragma protect data_block
UWkdtLJ95joCoz14IOpzGdgDb7ipq10wQcvmAbLoEm94TehWYRC7qkGThUhUBlQ3
4t4A/ZhgU16F37BXBKzJhUoJFK+ic0vZM8eienK4ylkvnfzaC2Auw4KA7b+5/ivA
VydOmPKiA7+TzIk8MCYhAEoUyo0aSC8PoPHDEr5Vr05V+R59xizjZ5wgu5S+zi+T
IJzgoncppLEldytUoQLeVc4SEpBMfqQjf343wBxgCvKB7yYz6lqxsYQm4d734mfx
kiDO7RLhUI3wqV15p4LfwE4aWut4TOh6cvAJpwfKcN6S8FawsICi6BQ96sm832G2
A9Zhi+ZBC7Tl/l0qkvmeZAjlusSoMm5gbGmjiAkt7Hpl+WRVS3+XNg2wZeykI7oM
os54LPA3Zzu1mxgtUN8kSREJQSJa+gqQy1LI7VCNO558eGJRzqIDTX4o1ES6pDFx
oSl+DKVe+J0suPv/we/vkShpB+2YhFzDHG9A4NfrgnzAtZCjDctFrxGQ2JMa/SMN
yDmfnrL6KzhO5LQv95pTimlXN0VqG7mFG+s6QZluB8NPNQzMkEWUwMicVCoJlhhI

//pragma protect end_data_block
//pragma protect digest_block
UQjx5/Wumm5OMi/SL46QjNCSVwQ=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AV2sgqqZ9LEeEStjo20NjaR1ogIUJlG0o/A7OWsHrnT9UBBFw8Q4BmNy6faJx2FS
jjBvmxiPPLWP3CSq3s7Lh/NIKj35PQs21FZkPIRQtx3UW08eq8iZxpavA8sau3oq
Q438PSwaZ6z2qpDlhNhtSNyMvAa8f4Gi4bdS6UYwWgkm3xkA+XUcIA==
//pragma protect end_key_block
//pragma protect digest_block
MK8IiySODTNGv5cWBeDzdReHwjw=
//pragma protect end_digest_block
//pragma protect data_block
TGOTtp2qBFQmSJU2uvJMQBJ+UC4S0uH64WyAJDqrjPR5BgsZIf1z5zf9VisIhJgb
8v4pz+wlRb0a5/Zgj25NgH74bm7C7JT5gLSknZTXOJvLtfmCPRTlbbwSYWVznJld
hF4KwGfUsrW2WA5giEYLvt/9QlGV00fZl23NZB+UNOCX7uvu4gMXcJvAW1pAFcim
JptERX10P5ohD41mbwx1xP0bI6513ijYawNwDYHZZL8CP0pCf6ESYAidbM2R6d/u
/sXaEpGNHEk7L6cMLrcC6nmNMkhEE4zG8eCEfn5yUV7H2dvl5qwsgITrr11xS/SA
7zkE17rhcz51fLd8kDV4Q9QZX+3vDCqC8tTOXiceuvn3+GXdJXrq6j8YIJzNi2ry
RAsGpc/K0RSJhbEyeiQuwUuKRIKDzaUg7zjlDJAqrddgmChGQeloPblCLrfI9Z3x
BsG2IwUkUdt8qwx7s/FS2377oOJjA23+vOlk1PcYBYTdsONHOV4Mm9TV05sH0KPI
/U0/OrKg9iQVPgj9Ss8ssj/72pAfWT2vwUdlXnvL2T/uvYKAOPoU3qihfZq94lLe
lqtwFh5ocC3WKd7Ywf0CTtz2yz9qnFt7zTSBuB+mPwAEuMvR4tqTEuahQPtw9cWX
OcJ3pACYs2fGJxDhs1PdLPw8yNrJKMccs1bhjzdiLf8EtPEXn+VWD69EpdDTS8fW
Ty4D09GyUTYMfdQmwGgV/0tuDYQ9k8jt3fzboNUDJRFqEErrZsw2H4flksOlg62D
87vkjVNv091hA8QraNUsIoEgW2Ie7Ed0hr7z2Dhx4zAn1QL1cO15gO6PFiQ/rFzE
5SwMUezui8623KzL3pBlq9At++JO37GT9HvNpoYHawQ=
//pragma protect end_data_block
//pragma protect digest_block
aRUV8PHLKn6N08HSLoyfn7wEKuU=
//pragma protect end_digest_block
//pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bFRqG15F23cOIm9+5IdJlIf95r9vlS41OGwg18aSi/Gy+mN21OZ6mKKa7jZJdA7D
EBoH1wsu3yUZto8VmMH7s9HdXo7wXH57X6Eu6pYoMo5YTrIXY6Dt95ui87hU5deZ
sCRy1aIhnD9EEwruSxWasNgz1rLrOnDOoYlJk9Lk4vSVi+xyYaryRA==
//pragma protect end_key_block
//pragma protect digest_block
y4lNrPVIM/Jotv0FmQbO0wSXb5Y=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
hVDdcMBXd0TMD8gBSs7DSQcQqUM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

