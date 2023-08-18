
`ifndef GUARD_SVT_AHB_SLAVE_UVM_SV
`define GUARD_SVT_AHB_SLAVE_UVM_SV

typedef class svt_ahb_slave;
typedef class svt_ahb_slave_callback;
`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`else
typedef svt_callbacks#(svt_ahb_slave,svt_ahb_slave_callback) svt_ahb_slave_callback_pool;
`endif

// =============================================================================
/**
 * This class is Driver that implements an AHB SLAVE component.
 */

class svt_ahb_slave extends svt_driver #(svt_ahb_slave_transaction);

`ifdef SVT_UVM_TECHNOLOGY
  `uvm_register_cb(svt_ahb_slave, svt_ahb_slave_callback)
  /** @cond PRIVATE */
  uvm_blocking_put_port #(svt_ahb_slave_transaction) vlog_cmd_put_port;
  /** @endcond */
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************


  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** @cond PRIVATE */
  /** Common features of SLAVE components */
  protected svt_ahb_slave_active_common common;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_slave_configuration cfg_snapshot;
  /** @endcond */

  //vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dNHz7HqBeKBfNcWlw/xvgDOLvTbjsNSAQto12zfpvuZf0TeDGxEOaPHT7BcTd2o5
KmsKElIN8mAg8U8kLSPzrw+oAfmzh06xMELVuBoBWT1XLEZqRr5G3Ax3T7Fw3fRO
bIoU29+8JcD4OIWDjqx3qTwoAopRIZtlGWK7aO7jAj8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 740       )
Kf/sti28NkIYluyIpsGBiIrw4Gdk+Xe6SZGb3NCu5ojGr3Gb4Xiaw2mkS5Xn6AQk
wsHG11iujRZxtmXmzAoJsoR7XmrwOplCYDEuNr3PN/p7tCjkx4lHvJbuy2bAPyS+
3RWOOGhEuAT8OTlpGdiJRqZQIa9wr16rGte231QYrCKu/UZ+W58yIZ6OaapBFV+j
AlOjTjV3pHFtUkBHGsvnc8fRQG+qbTFt8wzarA3lWkiXDs0z2wGWtgkO804ws72Q
5BBMbhVadLpZ9iMy5oCXVVWJ7pXjL3w6IiWOz/qiIxunK4LlmwkZPzLkWK5B8IKA
pUUZ3DnS8WzhOb+/HaI79rv9pcOuowO8+Z8DBYa9IzuPkix1Sm2C52D/iBVsKQ03
yy/Avau9tUVrjQi091yJMIVXG2mWNHGBuyaSE9UnpuCkt7rMdo2H6965VZkkgbmr
bEuncu/lHpDIQREY5xwcCr4cV00pg4O9O203AbVUZtwdY2tngp40g8IvvtxBsxEb
36U7P1cQEruGWeYJLzXrN95Ky0TQ49yN5IOHCopuIdIVG3fsrnQpIfY5yyszNhyZ
W0LKhgl1fid0nptn3JCs1YUlsKGl04g0fKVKEYXlzdq88kNO8Cfdck/U55fY21VE
emvOitEW2DkXTAwCh7ULV0ibd1mtTAACTw8W4l0cPcVtrTdxHYjQ93y9ImHzHO7C
lab2n2IS3jvJPgD1oCNPcBhzRqxg9k53tcS5XVNmMEY23nqC0QUpdhZauz3bRnCs
iNh4RNjEhDgbpvYdKIpKLcXeO62tAhg4E6Muc3fXXwnzHy33+eTkabA4+3Z7SWyY
3fl1P6gCrYs+EseJfwQemnLvVoTPYPVD6jOdkNZ6clGk/dQ27mPA7E24rdrpNIA+
aKh6ljyZ+Sgh87fdFSWHfwsrIC59aVhk27s1gsIBn7o5E7LBSNp5oq7A5lV9xZAS
WgX9r+kB05jiodXddo80X9BTlikaMJbpfAI1UKCQVqM=
`pragma protect end_protected
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_slave)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the common class
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * End of Elaboration Phase
   * Disables automatic item recording if the feature is available
   */
  extern virtual function void end_of_elaboration_phase (uvm_phase phase);
`endif
  
  // ---------------------------------------------------------------------------
  /**
   * Run phase
   * Starts persistent threads like consume_from_seq_item_port()
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
  /** 
   * Method which manages seq_item_port. Sequence items are taken
   * from the port and added to an internal queue.
   *
   * @param phase Phase reference from the phase that this method is started from
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern protected task consume_from_seq_item_port(uvm_phase phase);
`else
  extern protected task consume_from_seq_item_port(svt_phase phase);
`endif

  // ---------------------------------------------------------------------------
  /** Method to set common */
  extern function void set_common(svt_ahb_slave_active_common common);

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS Implemented in this class. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual protected function void post_input_port_get(svt_ahb_slave_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   *
   * @param xact A reference to the transaction descriptor object of interest.
   */
  extern virtual protected function void input_port_cov(svt_ahb_slave_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Called after getting a transaction from the input tlm port.
   * 
   * This method issues the <i>post_input_port_get</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   * 
   * @param drop A bit that is set if this transaction is to be dropped.
   */
  extern virtual task post_input_port_get_cb_exec(svt_ahb_slave_transaction xact, ref bit drop);

  // ---------------------------------------------------------------------------
  /** 
   * Callback issued to allow the testbench to collect functional coverage
   * information from a transaction received at the seq_item_port.
   * 
   * This method issues the <i>input_port_cov</i> callback using the
   * `uvm_do_callbacks macro.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the data descriptor object of interest.
   */
  extern virtual task input_port_cov_cb_exec(svt_ahb_slave_transaction xact);

/** @endcond */

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HV1VApBc/2TDXjpFyo7CkpV22jDc0Fk670fakMq5YpJodtKzjdCHf6lE6aET8df/
urJr6tkRMkL4teAbHXyv2vS0I6c7uC+j09ce6BkIh9ZesT/chXiFgtmvqcRzmY9N
/XYog4aHG7KeGL9HZRUcYcDtCZvPZAMq7dg5kwJwZyU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 978       )
bFtZ9fWP5/LN3u6hUBiJDGOxwHLf24bwe4VmqrnwitdgGo0w0yl0x89bKGcL0zfO
w0mmtnFSDFO3Ee3XcRZ4gXA1E9ueViC9cimdItcGSx64L1zqaPycY9bAl3wcyfFn
D80DdRug/riMm9T9IvVIJ5bCl7FDbMJaDnzuhK1Xvaz0g/PJxlmMi0rcctOjeOk2
qS/38MMWxHhZl5A0R0Ap5R1wf3zs8mR3UbcZQqEeE535+OISfQYRpVL7P/YK9NtF
uONDtousx+qaUWcvcOEk8nXJak2W9rf7UREe6rxeQ38oVNHBoQPeuwcylXwGyRpA
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aXU80QeuNHdr9LMqasoPqDOwExcoLxSqzEG3M+E4GNX7OuDVZJUPxsxFAnLkGmKs
iglWi0DJMq7QHD/l827zXz2uriD4Ddt7PSFT4uaYgOCFX2hRAYZ3pDK+f70UEzO0
Vx40shj9yQPfud2sGKtZ/q/kSUbzxRVspfvfjemqaw0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1405      )
I5xoJxKtg183U5CSbNcuUW+auMyAbgk0fs1pHWRQ4dHmvvF26lcrk3w7FAGv9cPg
+ZjOCKtP+PPTUU5dzJizvfb0qa6Io9zHujOUMo17Ijy70ojnpIxlqt+ujFQKY4I1
HVCwipCdw3X+O/IC4GLp0JKB37tFsLe/jilVGe/7frdMGWpCLPvNRlDi5tcv+7KJ
JUYYgw/kT+voZAW+qNmEa7EPxTPiP2SeY+f25ZWkzbv8Ept31YCVQ7ZHzB/hrbmE
be65Oewh2ZZAFv91QyzP2Ya80h0R5i9S0Ej9eysiRfHaw5kuW4zpDUMwmPHnHOOr
L64blJbfDb6zN9ZHfhiN0WsJp5ACQdj9PZo7q9HFym9Ji52iQ6v8u41kJHGIWBjb
DGCGIxP/vJv5LoF1Ujrri1OhmPn9pGE2Y+QVzWRLn4Qggac9FelMRTsFwrvbZyXv
yV58hMZFmK0HhNXUF4yPriN1FbIEzGZWVppE/Lu6/+eE+RQ/Uqxwvhc/NSZnyas0
3fMWmduy2u/NIeFgdU35OfAjNbpqr7CwIy61/Ox8Fgka+H7COKdLDKT+IVKqgNA6
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SA84GEPOcnlIjRczhceI1Dc736MNwVR4HMJRofsJx2Sjasn9GuZXBsq6QRWSCnPk
4odbkYRsoTxnf8RN3z7HKHrUkaVhykFg+pOP/TmB3Mj5kKBSgn53t9zzxmlSDXbk
w9Rvd7HXY3QziV91+Pl01k7w7PHCAKt0NmpiDXBkl1M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11123     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
S5wUgzF3NP9cDigg2CdTJWIpTRykrDUYuB0zkKFFcG0M/WDI2ingHAIeweLfZaZn
1aRwtRQz4Gp7UJSU4C7B7+uqB6WSqWgH0QeLwHr9/tBQkxINVk8i5zYQC/5jaRco
6pzhJh/L54rwDSBflxdHF8cNv15aGTPNHKTAj6EIKzs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11206     )
hwR2l5bJvpxKYZsAQAkJTiQroVfXrRI3U12sHRL6IT4IKaXSB001Sg+idkZBWSJx
Yb73yrvXdQSC89LMII4MJFS/pUEfW0E9dnUyNt8WBfXdtmi7xihR2bh0iHevUTx/
`pragma protect end_protected
