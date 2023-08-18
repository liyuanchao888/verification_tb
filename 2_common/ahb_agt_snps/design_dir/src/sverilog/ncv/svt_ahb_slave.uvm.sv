
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eZ57Ydn180Wydg0ermFtSfs6Izf9FQ2OcfUVz6VQd2niOdRpZ7IFl7Fs38nD1Jlb
1m3BQET8vdPeSPFzsx36W16va1FZTkhSjS3hDi+EKSEoWSBb2Kjh7jpKlh5F67Ck
p1QtxVnVIBIvZwBPOq+B/pZGyrz3s07bUCafpNT4+XmrOEPGETl3dw==
//pragma protect end_key_block
//pragma protect digest_block
aSSXQiQ8UBmllSzVwLDUc/pO1iI=
//pragma protect end_digest_block
//pragma protect data_block
ctpECHh67snwX5ysMf5p326dnXCwbOTKSoXOSCf7cv7kQD7ESwwgUM+T4CISbXO9
7JrYkBFLt2ToPjXN9VxP8jpazVgwx+3WHadpH4deF8Rh5qoZydJ3FxZaS9Kwkpyz
xKxC2FPX6Xz7sHb9sjZxbJeTes63AkmkeBBqCe94Z9YOhszAA9WHMWrv6hgf9sSz
SZrNiHYhMp2GaQjN9Ghn9o7XUP5BMK047JHRKiRAG1GEFerxCLcgmCrJ2F0Ol+um
psiMLMKaIKgUnYlyL8fLjDu8kzUjrozaIBffqdPnmvRNt8b7XwMF2Z7QMmXMtv2U
37SOqBby/ZQDy34tHmjvnL4xSY9g/xxF0TELr22zX5pKpIFT6bUqjs/U6yWXKjet
vN1WScxrf63eWLRd8KboblaTR3yCQoCXA8Vd508Wyav/EhqgoSm8J2TJd8rcBGO3
ubO3fEzZiZg3blACx8cTX5jZy+l2IMMCSh6EtYGZIvQ0LLVfiP4LGBsLvOVYSu7Y
4xK2M9e9PRW66wdeOqzf+g8e98BEsVHdLLdQyQIF2+6FYxywFvVYMIesF0HrD9OR
l1w+hPzjfNdyo2GZKitTQQ/qfQ8Sb7olrNpXwP0iZ10ZT6zRvEZUOdp23Tm3rRhI
ZuD+oYkYXvNS57H1V/QMutdmD8EP70ph5vIqhyfC4v/Xsx8KRstPQQ8O66bdedog
ARKn1e9kEkSksnW8Z8rGU/vDntPlY5PlQ/mMEKiWp+c0x1upnRKlgC2w3x2crlPv
2cs4xqkI5ityIHNIHNzPBt1J6dENWL2PDBP6AO/W0UHN2oH4YfuoUBWxSyMa2utm
S92wj2l/thpmBqpQqxOD6JlA5B2TGvjmCpatJDl/o1nDZGTXYJzkluH3pwYBb5Xp
7u0GFTdGRIXHLGl3FJlHH7AIr2ZJ2pKFioh16bk/pG5VfnWNKVV7nQcelbfJDIHJ
W73XgHT6HYgkgQgxIcjd4BPkXnKnp6jz2dYpUCOPwiFwkte3wKMJA95bNa35Sfyw
ATFvHzmPE4ebeaox1Ho3Zck7p3KFWbo8l4joc4p41PvKUbZncoU85AXW9E4ibJYl
C+36vzWxPHCG9Mfdf1IGE4VddvXOw6wUXB/0wLffMCWQXg+OjNvhk7mvSAvxQOMJ
vZRAtz9m1e+pJvIZVlOM8xd125eI7TjGOJFsSjv33ZkPtoCn+t2dGJOoHWhU/fYZ

//pragma protect end_data_block
//pragma protect digest_block
MexdeJCzSzIZJjlfamxa0V83668=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
L5Gj59A0KRDona1VBYbU6IP6pqyta7opTqBxwTOwWaRoP2wRlvi2HD8spzG4aGYB
vNvnAg3TVDZZVzKXWAwb0PWHvCxlWLlicEiRvOsgKHvl3JglyrkvC+TGAFA+W8Ji
xWQ+fsDurDJbq9P1tQwpSD+S8jBN2WpQBDOQTpdr3WUOoN553Ub+7w==
//pragma protect end_key_block
//pragma protect digest_block
8PQtyt9/q3TpqmW0CEwWD+j98O4=
//pragma protect end_digest_block
//pragma protect data_block
fKXVo4WWkXnR8dcE8civdAqZtGitv27EjWCk7cJztJmmQnaV9Hw1K+47XCN0nE1O
bgcYP1NoJmRL7WxJ/T4X+049JXk/G395WdF0Ldg487iYX8lfsx2P0hj1ZlbQwCJ8
2Ch61qi3ute0i0n0Aabfe4IQMrHUV6romnx46TqhXj7GNzgi0lLjfofB1hKcUqra
hZMgEoK0qRawy80qjZISDxPltPKLnaZE1dHXHwf1zzRRrmbRTy+aR4s4r8xJNvt4
m9W8Y9aqLqgplb7TiY8ZrPVP+WQbyorUp+iUHZ9XTCwoZ4TEFKrsdXCrC43tSHpJ
O0qhZ5dknSKLHooJpfEwLZi1TktU59g5azsUoYJqa0xNwpV60Ib0tlG+1VQXXmTT
o8es4nmtW5l1QACpW8/BoD53wMeWHucDMULMDZ/qICPlSANzpQEqYIBZJiwc8wt6
4xC2XH89NHHQyuNo7uABDGQy2yDmrSAT0f+1lGQBkNYPEfh3ceyHP8uH2anSDkGh
RtJ/fm44RtPWNbZ5S6cYY18eI9s0dggXqGIowmfKUVo=
//pragma protect end_data_block
//pragma protect digest_block
Sg3FBv5VZsWeD9Lzw2Kt/NMfGm0=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
afRxAG1oklb6gIXUvcP1KSrb+VxFaRP9Os5bLleGiAwkvgro1ZRvikFR2FwSxdZ7
Gwc3TxndxTLQQPv7jcwO95SSUxY6vQbAUsi1iE4Y6UUEqFoW5SEfYhfAq2DpjnOz
tURygsOkvFNrZER2fQ9HAyLGY62UEH4B6jT2rJJMKRfKX308v3hp6A==
//pragma protect end_key_block
//pragma protect digest_block
CGfeIGImG5HKBMEipLdvXPrEhp0=
//pragma protect end_digest_block
//pragma protect data_block
MMUqMqs+DB79A4//as97r9k7mvv7R1Y9qEETc0KPoRddkzZ7f220p5SsoCa1XjUy
WcM/rQbgZ/YQnozD1FcJdhfjSDdJKiMtApGd2dFoyEBUyGS/ic6SZ+mdJ61Z5QXs
mm3024ya5QRPidXHpzHHj3GjRtrDbHb9yzBXCmkGDMoz2Wz8cjF0YVFcPNLEd6B5
4VmbGf9TCi+WCmftXxcQz/FyjwfBigR/4c6YxqRRDTZY/xi09y0gcBl8mWu5D9qA
aCyLD5n/2OCSgFKESq3k+Qsx7R/ORrlSUN3tZDUcB+mdmgLNkwWHX6hoc4cNDF6k
nGsAnBLTGPk+QotsHvgYQkAv3wxQN+0KzuGb46DasjKbFS358EnS3t2MxBT+0xIX
8qYGw0qSex7fmT7Trp49N3HzRvv2+e/XLM2aA3COmzJW2koXDqgKSy39S/FOWt3q
cJLwomDK7wqbJMNiqvidmLlQ8JF2CEcrhDK8wSoGGUU3CIuViwiXoXD80y9iSoMV
Jf/oh3IKE8CDYikwi8mo4fcAfxhHvLgNgth9PtGzku6BNvdPXcOarW84BjmZGVC7
uYcrnIj01kjwD1zrGN99vT9LxvuWY+EdHr3OIKlwCe2biimwCCPfsoZdq/UpnfJa
jvTS47gjjP7ySZysSCZAeGeI8pBjwn8Pg6LHpvGLlkHq3WHPybTIC9Bzg0l8ep3p
bFzA77e659GELpqG+r1yFiM/KQFpX4g6YP164GmoMVDwCkNJcM7L7guz7MRlGyWJ
C5SQxVFSe3pksBYxq0mfuA==
//pragma protect end_data_block
//pragma protect digest_block
g5eTiIOk+BnpS+FEjeLAcdJRweE=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ovUv0TGou6gd9yDasmy0l6OslNRpKk+vtggsxEm8KNQarNp2dLagHLWUU+Uu1Lty
DkGQa+KazhkzwGZzmW2IeCdG0eBXjNfN0zabHpQXpY5yHTuvqjdEE73imkwNwhGF
S6A6baAiC4ZX1cmvW3AZ0eZo2WNnaqO54R/cw7e6LXnGwJ0gIJ8LZQ==
//pragma protect end_key_block
//pragma protect digest_block
o/GUGI4U6w3CGOxeiQMBHNSGQiQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
bEQhbyd22c7Z0ZOjTVOoiLv3ldE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_UVM_SV





