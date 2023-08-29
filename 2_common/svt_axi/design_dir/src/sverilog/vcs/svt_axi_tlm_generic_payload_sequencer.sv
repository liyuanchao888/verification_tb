
`ifndef GUARD_SVT_AXI_TLM_GENERIC_PAYLOAD_SEQUENCER_SV
`define GUARD_SVT_AXI_TLM_GENERIC_PAYLOAD_SEQUENCER_SV

typedef class svt_axi_master_agent;
// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_sequencer class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the svt_axi_master_sequencer if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_tlm_generic_payload_sequencer extends svt_sequencer#(uvm_tlm_generic_payload);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */


  // UVM Field Macros
  // ****************************************************************************
  
  `uvm_component_utils(svt_axi_tlm_generic_payload_sequencer)

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

endclass: svt_axi_tlm_generic_payload_sequencer

`protected
[Q0D7:,,GA\),B1562,1\3W&-\5a2:DR0]I.2XKcR;]CA_fXE>g93)BL(TKPT]U>
8]SGF.>ZXfZ3f[=/].;0.<S\QL_5,Ne9@H&(eGZ53NVU+###:>Y80[bQ]d&T6,PB
?T.AUHE9<a-5N-A>XVEF4a?_(>8KP[^M_1<V6WDCE(#7U2.JJ@1DdW[a5Z[-1JIY
CZD[>Z9JcL;N\OB7-G1GGQ6:?0N.a-^(?O,G>\R6fFgKCUQ&::N-8=;#6&7W^e)F
OM6.^R;-[+b[?d=P&<N\+,D[V5c+O-W2)6dN+?_b_34M2@TLRRD7_[g=B/AaWI+L
E)EEQ^^;=DZXUb_K^/R-IH6R>^@dLbTX(W.B\=S7W\TR/ET(Z[Vb9WL_c:0&X7[M
QbU)aHJ3]AY:M>,XJT_TFCa[5\+EI-I&XEQW0T<FTL+@3W5;OQg;2E-99U6&?E)5
Z>P6YCYRFP9>6E(YdR(,EKU+7QDd-2;,>$
`endprotected


`endif 

