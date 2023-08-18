
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV

typedef class svt_ahb_system_monitor_callback;
`ifdef SVT_UVM_TECHNOLOGY  
typedef uvm_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_system_monitor,svt_ahb_system_monitor_callback) svt_ahb_system_monitor_callback_pool;
`endif
  
// =============================================================================
/**
 * This class is System Monitor that implements an AHB system_checker
 * component.  The system monitor observes transactions across the ports of a
 * AHB bus and performs checks between the transactions of these ports. It does
 * not perform port level checks which are done by the checkers of each
 * master/slave agent connected to a port.  
 */

class svt_ahb_system_monitor extends svt_monitor;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_system_monitor, svt_ahb_system_monitor_callback)
`endif
  
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  
  /** @cond PRIVATE */
  /**
   * Port through which checker gets transactions initiated from master to bus
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_master_transaction) mstr_to_bus_get_port;

  /**
   * Port through which checker gets transactions initiated from bus to slave 
   */
  `SVT_XVM(blocking_get_port)#(svt_ahb_transaction) bus_to_slave_get_port;
  /** @endcond */


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of AHB system_checker components */
  protected svt_ahb_system_monitor_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_system_configuration cfg_snapshot;
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_system_configuration cfg;

  /** A semaphore that helps to determine if add_to_active is currently blocked */ 
  local semaphore add_to_active_sema = new(1);

  /** Flag for reporting master transactions*/
  local bit received_master_xacts = 1'b0;
  /** Flag for reporting slave transactions*/
  local bit received_slave_xacts  = 1'b0;


  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_system_monitor)
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
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_system_monitor", `SVT_XVM(component) parent = null);
  
  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`else
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads that get transactions from
   * ports and monitors them. 
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

  /**
    * Report phase
    * Reports cache vs memory consistency
    */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void report_phase(uvm_phase phase);
`else
  extern virtual function void report();
`endif                               

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** @cond PRIVATE */
  /** 
   * Method that manages transactions initiated by AHB master.
   */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_master_to_bus(uvm_phase phase);
`else
  extern protected task consume_xact_from_master_to_bus();
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Method that manages transactions initiated by AHB bus to AHB slave.
   */
`ifdef SVT_UVM_TECHNOLOGY   
  /**
   * @param phase Phase reference from the phase that this method is started from
   */
  extern protected task consume_xact_from_bus_to_slave(uvm_phase phase);
`else
  extern protected task consume_xact_from_bus_to_slave();
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_system_monitor_common common);

/** @endcond */
  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------
  /** @cond PRIVATE */

  /** 
    * Called when a new transaction initiated by an AHB master is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_master_transaction_received(svt_ahb_master_transaction xact);

  /** 
    * Called when a new transaction initiated by an AHB bus to an AHB slave is observed on the port 
    * @param xact A reference to the data descriptor object of interest.
    */
  extern virtual protected function void new_slave_transaction_received(svt_ahb_slave_transaction xact);
  
  /**
    * Called after a transaction initiated by an AHB master to AHB bus is received by
    * the system monitor 
    * This method issues the <i>new_master_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_master_transaction_received_cb_exec(svt_ahb_master_transaction xact);

  /**
    * Called after a transaction initiated by an AHB bus to an AHB slave is received by
    * the system monitor 
    * This method issues the <i>new_slave_transaction_received</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    *
    * @param xact A reference to the data descriptor object of interest.
    */  
  extern virtual task new_slave_transaction_received_cb_exec(svt_ahb_slave_transaction xact);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * @param master_id Master port id which got grant.
    */
  extern virtual function void master_got_hgrant(int master_id);

  /** 
    * Called when atleast one of the masters request for bus access.
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual function void master_asserted_hbusreq(int master_id);

  /** 
    * Called when atleast one of the slaves gets selected.
    * @param slave_id Slave port id which got selected.
    */
  extern virtual function void slave_got_selected(int slave_id);  

  /** 
    * Called when atleast one of the masters gets hgrant.
    * This method issues the <i>master_got_hgrant</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which got grant.
    */
  extern virtual task master_got_hgrant_cb_exec(int master_id);

  /** 
    * Called when atleast one of the masters asserts hbusreq.
    * This method issues the <i>master_asserted_hbusreq</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param master_id Master port id which asserts hbusreq.
    */
  extern virtual task master_asserted_hbusreq_cb_exec(int master_id);  

  /** 
    * Called when atleast one of the slaves gets selected.
    * This method issues the <i>slave_got_selected</i> callback using the
    * `uvm_do_callbacks macro. Overriding implementations in extended classes must
    * ensure that the callbacks get executed correctly.
    * 
    * @param slave_id Slave port id which got selected.
    */
  extern virtual task slave_got_selected_cb_exec(int slave_id);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual protected function void pre_check_execute(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** 
    * Called before a check is executed by the system monitor.
    * Currently supported only for data_integrity_check.
    * 
    * This method issues the <i>pre_check_execute</i> callback using the
    * `uvm_do_callbacks macro.
    * 
    * Overriding implementations in extended classes must ensure that the callbacks
    * get executed correctly.
    *
    * @param check A reference to the check that will be executed
    *
    * @param xact A reference to the data descriptor object of interest.
    * 
    * @param execute_check A bit that indicates if the check must be performed.
    */
   extern virtual task pre_check_execute_cb_exec(svt_err_check_stats check,svt_ahb_transaction xact,ref bit execute_check);

  /** @endcond */


endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nwDrjCSBzR8S6D5ohCdCmKKiV41J7birob2ky31pkBt50HQII1ZzDlHcXuhlmJwm
Betlq3gVvF7Or16WM8lUUhnu41kavsJ2utY7ZhtzhwUyWSdq9yzXYuiYoFuQfb/Z
Rg+3M2WbLZj9nrMjZjZMxheQf7znqJtj20JUuGwZaAzArHAQ1SL72g==
//pragma protect end_key_block
//pragma protect digest_block
PnjK8WNWzhUkZyN0GiBfr120HQs=
//pragma protect end_digest_block
//pragma protect data_block
5TarXz/2TauUIOO0cfF40H6wimsz9RMb//m9nAuei7Ad+8G4QADpwX9zkshVcAJl
n6eUXiOWzTONQK3mm30LgwQDHGSP22H+f7HxuM+twvNvVHIk9NIdMV6b80p/p9yM
LPRBR2wwdasnGJX5+gmlgr7aaNmL+54RnDXZlUcSWiDUpA+2vV7Bio7BQE5TBaOa
IZVFY9C6ASytFtHQXIjk40uDEyX8O9EFEHsPfosnCc45cLiNWxOD19m2oYFfOT01
EqY6M0JuNVVKtvvcLCv8ihme4Kp6nGxH75UNdt+6WgigL5tDNId/0g4YwokmZKOZ
SsoaHJwLtffk2vbo6PekFhQBCqBY+e/MSboDDtqe3+dG0HGrtjCecNlQXRZxyfpp
OF+NT/qw+WAbycT3He42n5EZc0rVoj/hgBo3mVcXhNLTdIVaGPFYO4X6m1Bm63cn
3Y4aJdOC0hu80WpimVbSwV2zTjNVTZlSlrKGexcRBvu3SkGUCiGPRo4fdPPnadx9
z+DHP8nq3mmwPX8sVRFr1c3legBTNTyMIC4Tfjxm4h4XFs0xr6ceXQ7vWmmbjB2l
isSOd81gUQASRJ5aPjimQgf4Aeslh3k+ROdTTh+xpGjiPqgtBuc4y/t2HnL1H6qd
3Vs7/N4EV82TvR2na6Nw1N/Og89JoVZcHiNtLpgpCaIQ4fFsF26xx4beW9uS1t38
7NuXOuzgC0YrwQiguSDNEDltO7Vu0AJoZ7f/oNrRZk98r7LjuflcC6530JI4mzdo

//pragma protect end_data_block
//pragma protect digest_block
7fU/qyI4qNEK4wQu4IZ63xXzjQs=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DW9le3zhBkJ1Asi9F+0NzpAPJP7c6W7WXvHkGZbBGJW+TkCoF2uu+1dK0pzGXIaf
GF0uDjLErnRuhfc4pLM4LT+fHClIohBVpSYCeCiZYH0XS49Qpnb6LkF0+PbJ/pF0
90kea0LRhG7hPjoN8FDhC1GYoyYaLC9T2Y7dnLxuaCEVx3HxZAUZXg==
//pragma protect end_key_block
//pragma protect digest_block
vHN5rjX8N3oKZrrBtxjOLrH2vJw=
//pragma protect end_digest_block
//pragma protect data_block
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
o0vr1s5oyYnugG+q3Bq2T2PcekcHod/MbSA3Vqv/4+fPpqxRTl82r+mW3S5ml2ZN
GK+lEjKtRHXE1PlGgx2XMS0EH+pQoO24FcflpiOJKClDOXT7uudA3cKTgMlVoA6J
BGHM0oeE+AekosyhYIdkU8tauSvtzmRpy10p54lAfqV+BROzSyDMHpkSk7asjGCM
KuZZ/jFGmVbyaPPwprUTwOxLYeD4kTWT3JL65cmMCXHhUXGWyNt2fgO+u8quE8hI
W73vSEO7NLOpJDqyXp+pbfgqsPE/9M+VyGxls49fOPlVzQAOvDvJMw2L3FsJdwa5
BnWbnsNvb7LGB3WgFXq53FrkOpez1KFsasVRgaA4sftKgcAPlyfu9vDqJqAAYaeE
KOR4JbYrZ4JHV5n9La20dVkNwbU0jqtKOyfX9clQCT5HKXY11dW/TqaycSFhxjXK
WXpIemaYVcq4cRzFmJ7EdQGqUHmWzACSxlOhxU6/CplUYindk3ACBDS48peXkApr
yG7qBV0nhEYPqNEKj0jmbGJyl6KKV8Gt2dk92EiOTXMG5ULKftJ/4gqSRm7ybzTg
F9C9lvmqI5zha0xWOl4tqJqBnYxg79/+SURJpL5FVcRbQ+Dmfo8bytNPQHwFIOMs
l27PUrk34ZVbQxK3tx6tCm5qx2JC2hw25U1C0V68GsGsH/T+ebERQgLuMONuSO5h
BFpRLEBtgWFP+2sa6zF35g43bbcaUtspdxtJldMHQ6xyLu5VmU56duUEvddsAIOO
0mIfch01W7JWPjJ9MbtiiTnIxODYiYj6SIR8oA2DLq04k45bqHK47P4OWO/tt+k7
uvf5EIfKe4UhvKypvWkqYR4hdTR5mw7TUh0mehxRoaYspb/U/uJ4xzRq81fnjV2r
btK42GTnptLnBjrM1/hbTnKtG11LEQY48EpABfdgKYgRfjZ4b1SDEZABa15g+iZj
BvIMFe5tvSoWffkT09BPxTLSKa9EDw0EeA5eK05C30qGdNhHDl0YMAmX6COoTgqV
2zYqTf4qPJSeUApiwVYOCC/zICHlWfFoTX+McxUKCF2bfW1fyoVDyp8ou5dZi+1e
15UxajfzAkrxNgPuAPC8mg0xvECVkP1v7pvSR4w2LFdimujTWpdxKztFQsqUtLjh
A3GCleljbjboMV5fT2EqAqmy1HEtdNLOCmOnPHmK9eS03XrTDfqKNh3h6gwiE+/8
PPGxY2LQU1KRYxMtp675yCFUtBj2GHc3w7QSIGhOIErEG5benhYapHzYZV/jv6E7
gMZJuuIi0LeWMdHGwmrIKm5wNR8PTS46DB+HkqZU8tTXX4iVlIHibPDjnVGZWkke
WW/IX9XKY+fJKM7AzmmpyBgzCWgwKfHU5Gl4f4Ox1VyyG3jJCuAUYXNGDQ4+c3Qr
aaXxvLgc3fdSiL4bZ9MKC6VWHULZcIguKOOzCGjhNV1XZzvDSxCvRVmVq2IWno9Y
euO/QbIyvt3Myrj8D5xqv7nwXLHp+bOoG67Sj0/CZv5dx2kh4Hd98PwBI83vlxVX
vN/wqaqqj4tpqcQQs4kI71EeHsgTiDJ/tsld7/N62yRDru0Oyv82m+FkyeWHJTvE
K5mUbATjONbWqFRS8V/T8Cs7oNg7jOg3D5iM4tQBCWlAhIVzXwwi4OA4ZYiDlJhJ
2Zom+g1p6sZoKjAvrHid1DmNyzav7Jdi4WlM3K8ddT4QtMuMcimV3d8amiiCTIPM
St7xK8UkH5jA3YlSQ0uiw/7HI/o9XjV55OmYJb7cvv7Galm2s2w1pYGtoLzYyXZe
HMpJKiqGpNDch80k/EKgsGnNTnclNUOUns8tYHLdlmqNTau2+Ann8ERrdXnDIwVt
6c8/haFY9X6GlAped0KYQDpDuFWdjsvb4acl398kDG5rBDlszeFbrzQ55C4ZCwNE
FY2UyzZOZFcmEFb/E1Hldv14FAj6hGTmEcD3tqZVtMWQ8aeM6kB7FahP7jkhZqJ4
MAsOWgAmiyEneeNfEAK0rQ/Re0EeI2NHc/P2zQ5qluI3MkU16GN0NipaqCJI4B58
3HAF/fbMsKuy03tlb65lSXxRr9XFQxPDgc713Rxfis5N4LCCWA8mppGqlp3mKj6f
QaeGiCRHYTtwK+DUnawBvYHl7NIusUqPSsm5R3sP0onEwF7rV32i/wk2cRjqUq+R
YwGkuQkqAGIdb+3attHSEAhp1uBwf4RtN4WJLPJ0X1qsTWbyzsKVVZmaPND1WFsC
isc126Y1tJNV9nds73KpPIWNoU5ttQROcgdcxQxyDtf6njsjxpZeAKFANt13VCws
cmn2rQnIC5YWMU+495yW3rLHy7NQ0J/r2WmsuO098DFzAk3GZFSVPGXdjhjqsUZM
n/9BbTb4HINs6xTOLSC/X+1L3RYUwUDjlgX5FcTVKlaQUJ7Axdt3NOMKYQi7wG85
i3x3Asil1pFl6L2EeTgCVe61caW6FFcCifEc3JIU0vH2UIZFmMhyPHNIoAYLW6ws
diZcid+jQBDj8wi5hMUnQvLFoiByIMReoiHzJxCI9+F/nf2td1Eh+wPhFIYaKzv7
neRsVY1NQKsJLlRIaDzCcgdww/GG7f9Zqpqakw0OG4wsRY1xE4QewkKugrTzt8HX
fp1YITYfvjSp9jdaXq1LfV5UaIQ1bqmIz5WAKxs3b76xNmYZnH9FA6Lw2fz7Pwi7
wY3XSgs+hBpXg2to/cW4Vnc8Hws/I0ypEeDz6gu40Aae3/UYAMjXEu3TrvZesYNQ
JMrbfRO7ZV6yeH2kihh4eD8HBbyx1Zwu7+PDCJeSdIEBRfcf3jjLJGBoG6bNlWa4
T2GcGtpafxqwGxXj3+RoGftuWONz3/vZq1OKPoVJCWPaTD6aVgputf2UQhs8NKsn
ao2eqpjkKo+jalg8p78NWVsLvmqQYCiivnxl8DYHyIQtPKJJtn76nnJ08JUFl3KL
04KD6EoIN2StDT02UTo14aLcShhveOQ80nNt2AjedUAEBN5TZ4xm8N5Y/kJ0XKus
hrP8mU87N+2+eH81wRiOucMnyEZ8kZJjOmX43NYK1fQnEjlFvN44upll8nhoaB+S
hBQoiAbrdmQWCoQdYLtVbFk++dZ4gO4FX3J5wwjeTH86GG4H7SUtb39SQbN2hj3X
ArU9J6GZvEe4wq3+4+RXKEbogSe1oOGB+abcCzip7lvvwE1KALkhwVxrjApoFxFx
rxJ156X40CotB4GUTb3erwQ9EQq/QSlJAozbJI05e4MeYN0LeC3Mu1gVVAusqAU9
ajqTCapfNS8q9gmxyggVlTrlOPwa2YdTpaEubOnQJA2u160BQ9VP9SIrdWNaWn+y
fTY9mDfTBHAz/jj298WEJLuZ0F0U0BXRHdZw5xg4oztx4QpBfTh+EMZSjZ1AfdNh
hBnwHLmnyWsp8vUfaW+ZiPvtODTVcY0CtSUT/GAvohJyM6incByQOHR+JIgX+baS
JNzQI49WGi2FL6kPJd85U4wdFUhxes0/R2G2He/W1EK4c6KUUR4Ulc92gkbNT67l
U5N803SobywwQYIGJTbZ403uphSSgns1rE7E1YAJ3bTQ40qdHFLYG0BnaOW5iYvG
q+DB+QXEbg43mmXFdemoxIYJWn7sc53WPeIMJKvMJ279AxqfLNPEqVTCqNDbP5HB
9zujLORAFXkBSn2755bsFQHnO2Nn0GcRkuErwmB7pA4ZWU+sc3+TO8xM+YdOBvTN
Xd9YmUB6/y9RcrKaPCpuhoDd2n9Mo+iEZa6IRPdq6CQhotGRwJKaD0/MGmFlMmNt
twNIeZSvMwji70Xgbc3wUaoirxOffkIcf0p+pJL44Ykq+oARf+zyPpeEiFuyohBz
JfNSZg+PSWcjoF+Q2JBm+rPvTH23VpvSi4US48B6QQtxBnq0thOokKI0nRw4DDPG
07QF+EY3YBmrrEOSuD8IBTOH9J8wRELk+hRLF9ieDB/eQuglt7WnSuopDjUngaor
xw3m7Q4jt6nnrVLu5/p3kBp7rFmFRaggeask1+vnhw0T1hirF3kBgpRsXndH4oCU
u7FGD2vw7dVO6IU8oUP9IV9cZuHr3Bc0ez9eGo4RyYYLdRNatp07HtgN17eQy1fg
+jyo47lJIRWNwJFfnN6U7x8mc74xagGSx46Fq6w+J05f2jkrPJWjvk9GXcf0g49j
arh2S3F+VAkNkvOihj8+SyI9c3Wl7gdC6pcQchdTKAICY4DgsbJxcbTQd66DmO4X
c+8ZolRFkLL+Bmum9X/6SyX3v10MoRb1yRYtDGIqqRpBvtbW6bEco0aitOJcEdXU
pFKdio2kOZB/0H8iHx6uNWhRc8LX9Lngj0OtX6zIkNHAI8srbY5GYE50VEoDlP/+
Tn9kYIBCJyrHQC8aqXlDSY5J1l6vHHVdONVmnnp+8TEnT+uT628qnT2lzjXwIC/E
hqx0zyr70pFfSWFcGG0/wjxHerZrbnQNGCxMhNNZWLw=
//pragma protect end_data_block
//pragma protect digest_block
U4nEKNbqhMCoEo1j/0ZvooJTNB4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_UVM_SV


