
`ifndef GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV
`define GUARD_SVT_AHB_TLM_GENERIC_PAYLOAD_SEQUENCER_SV

typedef class svt_ahb_master_agent;
// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_transaction_sequencer class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the svt_ahb_master_transaction_sequencer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_tlm_generic_payload_sequencer extends svt_sequencer#(uvm_tlm_generic_payload);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_configuration cfg;
  /** @endcond */


  // UVM Field Macros
  // ****************************************************************************
  `uvm_component_utils_begin(svt_ahb_tlm_generic_payload_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
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

endclass: svt_ahb_tlm_generic_payload_sequencer

`protected
f:>-8UNQP8?]HZbbE51P4N1\.e.eKfea4A9]HX,7;3\7YUbcfGN>+)SILI#R12E[
0Wa(M@ReDJ<8ceaW]5(]]S14-6@)D1eHcf^0,K#AM>]07\c?Z@gWTVIO/V_AR92V
bL[4WR]V#LQ4HXV^TeE7V69OLbF.VOK?/9ATKc49aMMQ<CCNI][T1d,?gLL(;^L(
KI0JX3cI-GK6]fA>VAKA/eAW_gXd;8ZUcP(Qg9?@?e+c&gb&ST2)8_\Vb5CVa279
A,K)MLMC=1WP^RR\:UK]:IV?Z(:0Ndb@:Be@M69R6G0@7LCXf&>(-N>)G?F@N+Wa
OD@?;7.=JP,D,@/VG4US(ZDEWZ\CK)d<6W+S2&9b+0E]XgcXU4T?L#4f1<e&<[c0
T,XY]60+].0dAM>YcLT<<G5]7KfTE)Lf2TN[0/HU7G0)<H7NN?IR//OVMg0VY.\4
WgEKU2H=?M)f030_bL?8R]1)RC+:(=Pf>$
`endprotected


`endif 

