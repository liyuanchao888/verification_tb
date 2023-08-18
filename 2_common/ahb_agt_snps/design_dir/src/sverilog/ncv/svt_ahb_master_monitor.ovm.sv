
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
eTqn4/2wV7qcROwlWSw3fdCZvajAcw4nra5jvIZJdx8e9pJG5O1p5/H/aB8wHqU4
zccGQ6F0Kzc7RYJZUrHzTCPJ8rN+2htXHVi5OXuTdRaP/1sIJVY2K4OBNxOedgeL
mPxP/e1g9kMpv/oaOirsUECY5Iluj3RGOLt8/JYI44YjEACU+4Bspw==
//pragma protect end_key_block
//pragma protect digest_block
yUoOXcDFzw5MwiZco7GVJ0FfcTg=
//pragma protect end_digest_block
//pragma protect data_block
gW/D/aik7aDdM9Rf871ACcypvVkfjg7Ny9v7Az9QFrzlGWi9ePp1YpTCS8HjDSxe
xFBnQMTMLclY1zTGngYu2SpGgpzuBAwC097cm3Q65xsG8peKN6hT4eiMjA64Edi5
CsUWyl1VYaX9JopYGwwnCydN4Jk71ei0up8mCveAr2j3LcMZVZUQ6jBuhNZETPSq
PYdJTSIITA1kFSO11gHfUm4CRhZGKJHuBKlVtbiBSWWrLrG22VmIs0ctvjL4fpFa
MNYKxotf0PzlCNXrpnbZP0M71G/NZI1CioURvAM8/XaIlaJ8WULQr8ZLTAmPgMBj
CNIWuaG97L46iV4SBRT6qbCUtslYUIoLjtfrw2yLYVy6hwgPsaMpHPG/2k9P5mK7
KJJQ4gJYD7pwjdgRvq4JaikYT72NBIHBoOZdWr3jTc1uX13hZWeWaBqp09RKruup
IQJWxpVaSZfNV3lKHqvyNnQ27Uhv6ETF7YeljwppILyoVi/u1yDRAUSt3A1+XptL
sOCzzaPrnex7tCJw5ZZ2km44QJNfHXTDgyKF96QgNMKuVkTGEML+T4FkYo0M2zG+
jcbASPeqg9U3Do9FXB03kL9qhb6MFmkBWsj4rKwsziF4mBLJb1Zw4d9HcVT7ZHBu
tT/Ww8XiMs8qCrdhLqQhjECgK9AS7bkv0VWtBhooh8A=
//pragma protect end_data_block
//pragma protect digest_block
IvWlw26kmjsD+SEAa9PWMckPIhw=
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
1rw0Y3zRKAZ1JWOLyTyOeOOzLQdSVfOTsSxbgoe54EXqnbRMjxosUr0ECbFsic/N
3+jyicbTfSROmDd5o5kFBJZa8ZfxkQac/lgIOTizIY0ybgH55el7ytfAKB+sqV92
POwDU/Smw9D4h9I8IgYSeb9rOF/+xcATTJkDVyCJglOohW/a38bHNQ==
//pragma protect end_key_block
//pragma protect digest_block
FtErm5KZeEcWrDAQ08tupYdBtM0=
//pragma protect end_digest_block
//pragma protect data_block
IeQH8ZxZu5Y6ppydg5mZeJx2F0/9ezx+bT7uKX47WeUGEekaHDDClpy2HE0adpOI
oMfnR4YZJ6Uq3HOYwPkUodx3LtapP4BTaGWOAMQz8bScrIUPA1IdtuCzOjEL8eTQ
BDrGQsWfHErYlUZtrncXlux2wDdWKNi57mOxATnqKCiUwhwayscbiMZDLzrYwIpP
RYFS/KdnxlYign4ysebU9Hb3mmDZDjGCSZvwYTo3ITQ+8NgfeecaNpokCyHt/zqc
pDrJdW4wh30BNySGxvTVFJaKFe6KbnaG3hmmuNSy4wuMgEHOaJeU51TskEvobH3c
RL+y2xeKGdR1hCMtVEY5RYFMDsQMdGyoKpGpDEAKtiFaEg611AZg35ZkOT6/Lk8M
N+bwOjd5rsiGPufs9wG1ObA62wrASJocq+thNRVsttUE2jNHyAYmcGT1ST2pAbV9
sWkI6T+rwhahYvalfY5cXgvEB0PbF2P1PHH1uweIMaPvNMNiuuz99+3VNlZkN+ou
V8A69GEE4qRBIcRiqzDS0azXSKrRY5Q0kueJNDRc28M0EPXxc1bV8izuwjB5gck+

//pragma protect end_data_block
//pragma protect digest_block
QqUCAqDkWVRjRcufuZmVhDE48tE=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FDMEKJzSZupgSDwULbh6JMjBLsIJ/4L5/LaNu1d5PbqRy4tlQXuC56+8pvXZlTjA
1vuFx1tVqeducfTphWFEE3/pq6VjmHAAnbBA9f8W057cN5fOdFZV9lf3Efk+Gd7j
3lK215jT1y9aVl2VgPgt3Zjzg2gpr/Zt/FUG9K1F+tF8SHFaIyQpTA==
//pragma protect end_key_block
//pragma protect digest_block
jYxyAVfSWiMVmJBDPl0uoPja4dc=
//pragma protect end_digest_block
//pragma protect data_block
tfS3r03enQVSvpQWq1kPVIGQFWo+5z6VAUH/JmrcXkDyXj2OeL8fQBYFeEr3vXC+
iAnLQRyAUzJSONZaGW23uDs7cYfpuuiLFcXwqxMWgTfDrHT3QqifrZHxAKtql8a5
sQp+sbdWd+MC71PWiOsazQFXI0JZgWIFnRNb1aPb0A9XYvJ4vMRG24/5CFzyB9l0
ZEdqzp/jmv+dwJnyglU23z7UjN9h7TpdlAV9hbT9Xk7vRxDJlulV9EfmOo2mUJvz
CHb2WXYGFinOsj6NwlcGicjgbgb4KDAMqxRyciBentrBoOGeZ/CKcZPMyWoMWFGv
TCCSwNWn1nsFSqBf5nUXfnrsPnnOi1rOb4Ur1KxAegfu4PktrFNPuQOZkJErNGrj
u6ssO1c14N8eOjPXlPlqxPVfOc04A5zu4tVK1yoQGCq/UKA3frB6qtbjt+2UYm7q
7D9Zwb2eRNcGg0ixQ+1iHKtkXzXoKXdt158v7lFpME0JnzuhM/zIK48h90I4uPBq
VaAi77toxPq+7+pUqTXKiKYaJrzuUhXiGVo229H6J97Slq99CNDy9x8NZBJw+mbi
ufQeDxZgbp6I4DTMsLfwPFOAxtEltf1RaF5etjwSeD76wUw8cVaRbDPydK2EY3g2
61elV2AYZ/cy4cNR2dVtMaVtcVdBOULF+hw/G0jb+H3FuU7GW0V8nYoQSUfRcSyG
zIm2ceuON4nVw7Flq3qM+AmEU9dWRtXrTx765wRthR0OxumQYz3hhmAlVn765p04
HQ3RK9rPZYSRQ/r9KIQPDAHUU5f7KUasL+WZjhDuRQKHofLOg1xtcXUgjThAa07Q
gUK3WbGiggYjx+atTUqS/GhG7T4TcGZhuETaCbnMBWM=
//pragma protect end_data_block
//pragma protect digest_block
J4lvnTyYP5TpFJsZyaZMcoeP+Qk=
//pragma protect end_digest_block
//pragma protect end_protected

//----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
i4bjRG+sMSkdJPD5+vO3B7D1BDd0MxrgRcxbN+wPQU4W4nGuxxrnOi5lxfeF3mP+
J0NCqikCcXgTRu6wus/kh6y4aoomPQOXLzcfbOiUdBnie21ZbXC6G/k3JJHNwPlJ
guteSzlxcdlQKXmvP/DpHOnM18UPZZ7/nL4eeGoCvT7Oubw4y933Vg==
//pragma protect end_key_block
//pragma protect digest_block
LB++rw1qJeNiNUElzBfuyn3cit4=
//pragma protect end_digest_block
//pragma protect data_block
+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
//pragma protect end_data_block
//pragma protect digest_block
R7uN7qX1WbxY7rTjuAgZDDSZ/Cw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_MASTER_MONITOR_UVM_SV

