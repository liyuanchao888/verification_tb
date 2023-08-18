
`ifndef GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
`define GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_snoop_sequencer extends svt_sequencer#(svt_axi_master_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis export that observes snoop response requests */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_master_snoop_transaction)  response_request_port;
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Handle to the master cache */
  svt_axi_cache axi_cache;

  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_snoop_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new sequencer instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
`ifdef SVT_UVM_TECHNOLOGY
 extern function new (string name, uvm_component parent);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name, ovm_component parent);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Checks that configuration is passed in
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase (uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_axi_master_snoop_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pGWxFF0AKXGzt1Lmqqyr1JjAA61iXNCILNABHYhlYVjaHlySnzaTr+IKXMAsslLn
OHiFCwvCx6xcOYWHhplrwa3NUVfnz3p2DpFX+M0QTTBefeSsrwazxdFe1IEegWH3
A0bW6FrhjktR6eB6lGIu7iulKZWs9u1Cg2hV0CX8mH4VYjVB4s4nCg==
//pragma protect end_key_block
//pragma protect digest_block
NjYzP1Pu93l31291WB9OacVOjZ8=
//pragma protect end_digest_block
//pragma protect data_block
y9zOt8YlnjJvPSRIO2UbnbngGhFYNwFio2AaCdpiU3V6JOBYzn7KzeCglomAcL9x
T2Bb6TZhIf44I/pjypzKl8V/Czta0wloHPGyYeqYwebs5RZ8+nxijNOUCD45l6ql
4UAfKT5LrUX/owhTEWaijHFV+4ontcm/g0Ug5W3dFhntoSyirnxEDq85qYzYYUgp
72g2eux1kbllcvciL7dHFb/FrrLMON0+MvCcHJRGG+MajyphJNJalrZOEJ8BNHAI
upuyUCNnxKzOb5qRhsRz6rlIZYthSRB7qRgxZz3ERLIzj3YpMkiTzBszWg0gK0QS
grNEBEkB9TskfZfVeUEsEDc3fb7/eBGo13dnpTQQcoGR3aMgehl/kV1h1zD0tkyn
Z6CzmkDvFcyhmHlcLAFQatxeQ5l0ueUF8TmjReq4eCGTtcH1hbhpuMmKE5Ht69wX
e+E5qLn+plqja64+VBypLAYHWDPclXo9WyZo8VRA9w1NBYRdmT0xE8VLK1mWiNbe
YrOdVuAMvXaNsstsNmislNWR7szxRtOJptPMQkiO5SXqN9tZL7puloByuQHoqEo+
rmyijDiBHxSwE5o1XbT4+lt/CmXYUGTKK1ELUPhsdX4jb4OJ0o+AKnVajO++FMT6
FF2hfZx3pZcmA3OIxTIHg9UUZlEmHZjwPbnhThUcyoZprtgqx49Zu+3d3MbiLYHW
ghYPwUt5Adk8LWLBJ1wE8yUghZrYH7XCalUh0A24N3N/urJ6LNh2e2XDMwXc5yrb
zRNZEF8Sd4Vyh/WMu90D1gYHyJwQKfkIQ7QZGFn061+g1RlfFicakVFvu88vUi9W
1BlUvzyNNsTJSamnPq8BE3Nw1kHP89cf03gglz5SomCbJLGiDyq+qM6/nsw0TG/2
XAL8vTPA4AsCE3PK5w3XOJKD9lig6M+UQlM+z/668jbkKr/IbfHF/jMm3ecf1emf

//pragma protect end_data_block
//pragma protect digest_block
NYrRA66Yob9b996pQWy3oAHYRiU=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
dwVMMv80BDAyobqJOGu5KP/LCV1owAYX72yAkB1eLK0v/YgycG5N3Y4QZlJGocsS
Y0bE78zEqp/eIOqeO1oPEprIzkh3Y6qJo0Xx0RoXQ4XWLyyaRg+WSRu91nS+HTpH
1ImDE1QPAKELRJAbwFnHYxjnSYRbEYW2z8dnRxWHk9tk/oQ1hI9Muw==
//pragma protect end_key_block
//pragma protect digest_block
lMCHaI/XOYk4pdOBVlAj0YyOjOs=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Zio1PoN0RuR++z7S6Js808Zl97w=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AXI_MASTER_SNOOP_SEQUENCER_SV
