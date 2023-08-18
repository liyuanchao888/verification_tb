
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
h3xjwXMZcV3kgoECFwEUDooSJ2CCND2xH9fS36+/X/N1yKdIaQJjChWVoRRJEEr0
zrRcbKVwEkEOSr+vitevEsTH2Uhj2L8r1MFHi5OcVhulKHzSQAbxkexBGS7JmatM
+CCWyDZeA7L4jNPkYLlASm2X7+ftNePPdBneLZ+p9e0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 740       )
ubIkvF+GIKfrwuElpgpIBOf8rWlxvk2NNEA/d1GQpz+hVl5E0AutDMP0hRDi4Sh6
7k8L8QfO6rXl28VjbE5ZNa9HoSEoxHOosBJBKds17w+oraWs7JlhGSecJbECIioX
90ql6s4+09OGFnwNrOu3tigE1CsLkf1ZiYufQg/nN4TJTgBcVS2lVlvALuqU4oau
ysTm9mfQBJMAGP5fSqdWMakfCAGhXko9xncJBVYkxKkoCip+2dA/UfmJtoOWCxIG
gGyW5yyOGimln5RlKfl57nMD/4DNgvyqf1HPuAbO2y+TSH7UXrRW+p00HORMKpNy
rJVAYyUlYE3y6q/cbjPssPOu5PDfthysLLLzugjSa2iZ3xF19gFTr16yAuov9Lh6
5wCIwD0sJzaa+Q2Tlmz5h/jyoPL/tb6opkadqFDHdos0i+gjaoksUKb6MCAQ7Pid
PiZd2Jbzifs3kxlxwWw+FBVrhvYGV5i8VZNDP6ukdvhuW/C9IfxokZ/9ShOykIa8
2HljWPAqlueJ0hVcH0WosgpFQkPQWdNKXMf1yTrFez1g3e3Xg/GQT4IevxZL1O3Q
wnqPSTefuBJ15MxoY4PbOoU273dgtnRRBGxcZz7RqIii6Z0LXnymIyKn1tHo3CTf
WuH7JZp74BP1TE1NlYr0CZ2sKEsKv3ogi9fLmd3WwQnpISTn3dshFR36iNcQh/Jb
9AU/lnO9YizWbiCIVMsq7LtxlN4gOqIT2L518t5cpdMfoimBuTaUUmCE4hFG1BFE
/gQ9pYYCD3ED5DzAmJGQLEzYzN11yrA4KDgKn/oCwIpV7b7gv1BPlowiTYoBjE3F
dPc3C0jzvGu4yxXWo+qiPPvpHB/JVZL4lUzGnrMlU3b7/WyCO0EAtJKRnWVsK1oa
w3a2dgW3D9DHnmFFHSMvt56YWPAPMf1yxdvY+yCu3SkS8aKCMXwedkOvzXbwT+vL
ltUjoo/HKZI9TmSC3xsIxccJcDbGXsXZinzzk1NkxZw=
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
ZNZC12XFFrXgHq5bm0y9EdjW4/dwGD9GyvL0azsBqFaVvDMsnJfGWLY3UXCNCC4K
fq8JklOrv/hnXREs6B7OPBuvufSRzkbehEkmTx7Y8/RtP/aDvXm/ZCSebRJbsryg
Pjb29tIwwjg5rzRQ5pYB5kjdRUTFZKsnXVJ2rNo5oHU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 978       )
4sm+upe3yhlRLa/fuj6kvRa/1RaoJOf9K70quxNPDUW6plmwOGt/oHrQ/32dyReL
+oJr5EOKXqfC+XNnwLuVQASRFrDzAVJKCFLipyS9TwvEQf1TnROijvD1T85if8yn
ReWTKaRU/3d82gafvCaf99FyHOFjTmrgCyOAcHmFcbAs2MTpgjPBQ4qBLLqmAQOx
2FIA6pUp6lXx5gqyhggscPGDCbE9ufM0/LsDNs1TJcESICCOyzlrTF2mzEdFXbhz
0sV4j28HKBkwrcnsqK/E4mup25xpFHA/pZWGUM/Hvej0vDGQLX/Y5v6BmFovWTYC
`pragma protect end_protected

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QitgdZ8erPl2QjVFfYlJNkXCgKuGjHaMJI6+9xGrThcva+T7mSgxbUCo3+pRyIbK
I5Hj0LB5Kly1oRuKBHHlHiDWMlXWESQwT2Q4kh+Mrd/W+t0zT4SSwpKSvDtrjXX8
4kX+Cu2XXhpT8E2CJWw0EXhMW8uJ+PPuO3CQY4zGUHY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1405      )
2L7xBnWj/6mxw3fhmRkG9/3zqZdBLLPOxqULG2vbq2M1JgtX3m3hDxxsPgJo8iF2
LWFJH+dEG9/OQYnqEU0mB1MneefXqyjIAJ9DriBlqYqAFN6qSsKLIT4FiiYbhR4P
U0la//BzEFa8funrsoPXNjpgULDPVZRDpU9vjS2aqY3uWxciSf2Vtx5M7yt5nThB
SPwXjCqxEZPspPyKse6lRpMUN+5MFbFg2vcVP4xLYrcliNnbtOktaGyYLU4Y3GEH
Bxp/hI4v0ap93UnoEzT/WKmm12BIkWWt1rV6/tzM1A9AO7uNjlnfpyjRmk7kVk33
ErIO0K5WlRefGs4h1Z1Vk0ms+nQs2jvAvsBxyU1i/4b1Op5jz7Li4kkBtkYAxrrh
0yKTS8V6IFfMnXMnhMpx94tT/xVBPY0R5WBsfNJx8MZO3OCgd0PEf/q072PkJjo7
g1WEthD0lp4J9NCvJB1oTooCVqSW8cG9+Sii1ba/Q/BfuuSpmHLMMTzvUyqxpu2z
o+UQKtXPae3NP7F9GwE4U5rwdqDHHbj7ZoTZzwGkh5YzNAOn5brRtNSB6QVSU25Y
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LJH2rCLkj7iHM1KtKgJLEhuZzyb2toerqvUE3YVvreS8+q/rns5ZK4H9rSdsKk9T
6GK5yudGkZ1sHt1BeouRkZvcPLG5PwG0CnLG6Sb9UtVTtpi1ikA5Z+xb16vcYTzT
eSfhbCKARlX/ELEHHWqsjG3R+pCpopNUVcwhWp8ZqSA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11123     )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mk1fE7V5DmeHer8ICP6AeQ9tBXzSMTdp/F7KwyscwmdRjNVBNva0CPJgkM1VKqVE
ZetP1Wz//iAh0xouYaLLggV+T3duxPVy/rBWave6WI4rlmg8AHZxisxvTx5FLpYB
RP9D9/ECzLWUzPmn8Ca/YKWJE4gSYpPxLASkm0GBJ7E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11206     )
CaghJ6QgJny9LXbU3QuTx6qsBuZGgH8iY/XHtgGCcDPMv76BiUmNHG4R+Zt4c4yg
4WzqAlBI6HBjIQTEE5ThB1i+RT5/sG7P2GyL9MVAMCsR1/fxxNH451FIm4N+1P4i
`pragma protect end_protected
