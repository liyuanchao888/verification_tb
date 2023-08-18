
`ifndef GUARD_AXI_MASTER_SEQUENCER_SV
`define GUARD_AXI_MASTER_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_axi_master_sequencer;
typedef class svt_axi_master_sequencer_callback;
typedef uvm_callbacks#(svt_axi_master_sequencer,svt_axi_master_sequencer_callback) svt_axi_master_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_axi_master_driver class. The #svt_axi_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_master_sequencer extends svt_sequencer#(`SVT_AXI_MASTER_TRANSACTION_TYPE);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  `SVT_AXI_MASTER_TRANSACTION_TYPE vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
  uvm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(`SVT_AXI_MASTER_TRANSACTION_TYPE,svt_axi_master_sequencer) vlog_cmd_put_export;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_axi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

`ifdef SVT_UVM_TECHNOLOGY
  uvm_event_pool event_pool;
  uvm_event apply_data_ready;
`elsif SVT_OVM_TECHNOLOGY
  ovm_event_pool event_pool;
  ovm_event apply_data_ready;
`endif
  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_axi_port_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  
  `svt_xvm_component_utils(svt_axi_master_sequencer)

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

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   */
  extern  virtual  task put(input `SVT_AXI_MASTER_TRANSACTION_TYPE t);

endclass: svt_axi_master_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PiA8kY1K0H4PTrCMLIKPYPn6scNGd8cSAKMxUIOKhOKF3GxeOeIOyqeAEPsdA5ul
mGwLid3JX2fnWsumP4CHgg+E37wV7agLqRiUNzEnoK3uhZsFGneRv3ufnXH2oYV0
gECumVd00by3SsrDP/E7mEGr/MNzdBI4YF+loM9mTIE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 885       )
ZO33WIEeMGeqT4TeGLsHfsywkorEwHWcT7JzD1H4wEhBgSUIur582BW28LNlwCPZ
K6nRTN77vIDLm9d+SY/puPOy3xWFUiDtkPsMwK1ybXW21h/iiT8ofPNdy7M1bjSb
8tYh+NlRqkcSi7NQxWsvsaaFdSvwbcJ1HtAD4S8U83qHnV60bVWRhmaTMscIzfHz
rkc2bZg9y4r3yb8ouiGlsFjHSCJmQOmP/YLZZvYBAD3qwTf9t0rvXOb2XxTTs8dB
4dnk8zSTN8GqhtbmZoYf/ygXpnbSsoqXb2iNJ+WSox/9PHjpoM3bJFPTY9u7OeXJ
Y0kTDD/HM4Y4elZsG2XpTGujIxIrbkc4/g6y/4pFy+DT8pfaT4IH80ZRMQiB7532
ECQ9GuChHh///y8FCbz2Sk93REikPbmdpVspYH5pyZ1xfIV8/yBRqns6WIdygTd4
y2OxXAJDpB6Kkid/mr72FoY9uCKv3RPzP958hW7/BdvYCNqN/hMKIgLSWewuQD3G
dutfJPPNFBOokxqbwFViysIQHGvdInoA0e7LBqn8xvWnTj4HYLaOLFrs7C/wJknv
di5v7q1bowMvNzGaODqGDf0AurvDb97ytxmvpgMkqw9wtrz4Bl7+SVNUZJhSf0Cv
8BaMjybdB5pt/fDoSQqtybJ0LJsrjOcLX/XzhxZp3Ofgs2h3LDfOssgPvK18fTw2
mwiDJr2AKnucZfRgPYfo1Ml8vJPKFCqizkjsecDJEas2J2nR1lP+3k1/F9rzZECK
pksID80Nj3g3vuIj3+B7QPecXPmPSzVgdzJZTL9SvfxBQxyqHLjC5a/V1YKleTcs
KDotIx61ZXGtcNHPQ0xQmvi0K8BXjRDYa0GGiupD3oS2Mueg1SHpvijIEY5o0H+S
b9uiPfLMeYRM7bVL3xqUDjTfnqHGiBTLMh1g7N2+EKR8xpvVGOw8HtVwDg0gWBo8
aN7P4VYxDpzTjJN9r/D1VrPUvddGW4O8RADohE1KDmEX69RcmT/wVlykm8wfKklH
tP4PICA43hpQZQa9MfHK2WRH2tDIhIyjHYTthKX+Kj//vshliVgniJSip1rsufmA
GaJTyi1AknddqGUJdox8wxwhzfGj1EQD08zboSH43OMSMjuuqgIeyN7usdKJ+no5
tVRjNkT2COZ/TICSbGtoAmog1lbaRE1iupD8RYTbyrs=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VhgqB+95A9HjxdTpJB4/4JL7z06obfMwBg7JPT9aSN2THICcEyhSqsZNzf9hXvVg
jf2FwHnLvEz6Q6nydSSWK5XY4zY+l4u5epqaj/6zpXg7XaNGjuYrHOjKllLI8k+m
DF1hGoZOak7wae3CH8jp9eh8y0+SJHxIs9fonhdE9Ys=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3161      )
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
`pragma protect end_protected

`endif // GUARD_AXI_MASTER_SEQUENCER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dEKVinnvfWfsYcVH5E8Ky/pAU/uZYx1kJ4pnUajHupSmsBF0gQrCXUXrEktL1wNP
pnQIOyJVgqomvPoLd2ib5ioeWFBhMG/OvB+AHb6LHUw1QmR8u1ZGEsDkr35wgbQ4
Bo82FbzxAwFfrFkVAAJ5IerfySqOjksPtFZP1ERh5/o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3244      )
iWDJ3oieQfx+1ZXCIFh9MdTFcpY+9e3c1/7Yw0SznsMi2y04n9cTQZpmvi4gOgCL
9AvcOybXNOei2bgbWOMElBkp11ydrbncEizGt7+jEfEUjvA7itPsrbylaUUfWNii
`pragma protect end_protected
