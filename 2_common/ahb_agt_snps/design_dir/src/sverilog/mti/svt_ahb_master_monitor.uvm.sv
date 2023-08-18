
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JmPIkY0PJjIMJ0PY2b8E5jW9F5ZhE/6XrTZn1gdRnPU/iLQrk7eSc65yANzz+yL9
ELbG9q8mbUAQP1yE3CeBdqQ4nsH0qyZTFetym6VneQFog7U5M0iegA7tT8sCqRfA
nmha41E6PfMCjOpYVC3XonGw69QwJhIeoJgbLD21H0o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 341       )
5Qc/mIa20xby+rC9cFVD0vFeU8ROL16smIUYSX6964bU8F4s6w8GtZ35xJmAD80T
j/FJBC/I6KClsUx8dkFZ6SzpsAtEnfRdMoig3ydPrWhzCyX2mOFvLZIcwy7z1vaw
qpn7b5JwHD/5tv3kxGQZQCFBuRTEOpO1+uEoT2P6jjtWIgnASg23f4SMT5xEPX2i
LkXtQtIBP64gAN85g85UegAodS+Mq/WBLDLoGMADvnucLin448NLLJHZMjoAjsfO
do69zmXEInCxesn2zzNGK8qvUc2KW8DH9lGfbz/K8LOc77gP2EuLylCvg5cpLyYT
32Ju+SISoMciUo2BTXqY2z2YlAJm5I7dFm9lFc62kXL3QqRun3sUj+Y2jHsJJIRG
ZUUGleZ/aFo91qUKruJijTtmu3a/U9KpBgUU6Z49vVSclaOGUvEzR4nYp9qBonge
8tqUICD8SLkGgftmSq5Sig==
`pragma protect end_protected
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
T2NO1oGlLWjRmx9tzmCAoe056cqFXp+ICcCoQFxITivQ+3+xHs5w/5SLskEjoiou
C9CJupOJfIYg2sk6LbLGh1vU/aHWkMISd+W+mIXq7G4Q8eCO58pTdc/Cys/bMBjN
Yww4c9JSC1XZcN2utKpgBmg4HG797SzPVXuLwMn/GUE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 597       )
Uv6YHF926FJ2VCLieS+8cDjTfscZZ2Cyy2pLlCPTyOTnDzjtjI5kbHOraYnMF3cl
XzwLeh2aHkfHMKyX/gM06HDB3LCRZEynWyMRi8M2PsJcczch+txpSnB9K9hfY/04
0CEpUIIxVLk38pe3nAvsfv1G0CR9EoP+y0n9PvtgnEQez6i3IS6XqxB+as1qAvzA
ClSTHqUpBqxTB8mPOsHI7iCkssfJ4Y/rUJwUBxk2zVH1asBfjjT+U1IKzOabuwFK
KWFrwuS8SlsammlgynxV7wtHxywSBEvNKnzUm8Zk+ilM6EbGzBQo/tKXTMsiNQwr
MuAS4jFgHbZbxZYZhgKKXCs94wB6sHwKw5hIlB7bj70=
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D72WicE1DNXaA3bZ35FGOuUzfaACUpJVZRnnRC4S+fAg1dCh1F7H+OZ7TXyxk7xR
5O+E80mPSNrez8dNFYVSh2IanRAPULNqBIWL7ebKTcL56jberew5UIEEOioS2qgt
KG5GSk0gID8NbcGigaoyqdOwQmbNJHNQm0XX1PB625E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1084      )
zJ/91HJWHvmzUJzYpdqe3eb4N1p9Ga217Jy2Lbk+uOpExOeyAhMN7EX9flw/0mJO
F+pXaDbp4TIHoKQCH/F/ZVQRGkYO/PNPixXG9DRY7vLdnuIQVbLbrFgOnwhtjJPJ
ESVE8FeFBaPyYtoNPgWJIjuy07abz2uXmKKbSXFdbBiLu5XVE9ZkaGdDtPK2ept7
TqDhv95v0P6UTXSIjwIzCWHxTlQTEjP7N7+9Sn/ilOOvRyuy5LCw9mLpRWMU7QXg
+uGaAU+THimIVO9BQxZ/5enR0z26Rscwi8gRAKCecqoEfK+TkXlPwAE9jxdCtQjH
6ch2N0bvhWa+UFeZ2LP7De22y63roddgAv10fAzVVWPTVsQKGHdu0eCFsW43eM63
WKmDlZ4vDg8ax2DzPKEJkhzKPXl0xIgpLHOZatJgNGcqELIXiO/zXwn903vFD7YA
ETPGIurXsf3eeOtINV40RZ/iQIzQ1+v9MYZJj+W8Vs0oWZCYoWh9m0+Hb0ZGTEVe
Ox6elUlk+pWsTzOYCyWKXqr1fjdKI0iBqKMeS3ziySbgmz5aaszAzYHf/pLnuFU/
5/HPOonMUUQ/g4r1PFM6At0Oe6Rz95AhulX4Uw3O1pDN1pkMOi6SxZEaNpTC+WxL
hTS8TfjE05qtMnOnr5d5Aw==
`pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SimHRbeU0/xYbFhXzNDlyOXU6Hal4OUs87wQsOX/MGtGNrtdZxrVyC9qhhHFMtSM
4HQ7eOwgdwtKn6UnJnjeRs/d4vrBH+yU9Oscwi5Dd793BOOw2/Dk7yg0c61/3Jq2
aetPYXzi2rHgQzhwZnhVZwNxGO2+IGYEga5Ee8g2Nuo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13177     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CTCswlUT3eRdhpi3hOEzADi8mk35JXHvS6Cp+QzYB4grq4aqft/Cg3uME9KJxGDq
dV1pAziqqzk4bgpj2Gw0zRbeef1LxOV/q7NKvbWAc/j0u3ns1JLpbvx+oo2gyb1L
sZgcHS4FSayNSwJ7tjDe/yXYqDdle++bGS65BLDSwYQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13260     )
1rji/7X/p8IA860TRgsSQoof5lxo67GirCy1cyPq0wPs/QNP5rQ27d1uBzKNqlyP
eQsoSmbDtLcYnE2gw/5sBkYLOrBktVcV4NyAUY/J6DAiiVNmUUpoGTKV72R6ytuM
`pragma protect end_protected
