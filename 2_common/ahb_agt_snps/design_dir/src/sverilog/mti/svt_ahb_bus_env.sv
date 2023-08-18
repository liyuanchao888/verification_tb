
`ifndef GUARD_SVT_AHB_BUS_ENV_SV
`define GUARD_SVT_AHB_BUS_ENV_SV


// =============================================================================
/** This class is the AHB bus class which contains the Arbiter and decoder
 *  elements of an AHB Bus.
 * 
 * The presence of Bus in the AHB system environment is configured based on the 
 * system configuration provided by the user. 
 * In the build phase, the System ENV builds and configures the bus accordingly.
 */

class svt_ahb_bus_env extends svt_env;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************
  typedef virtual svt_ahb_if svt_ahb_vif;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** AHB System virtual interface */
  svt_ahb_vif vif;

  /* AHB Arbiter components */
  svt_ahb_arbiter arbiter;

  /* AHB Decoder components */
  svt_ahb_decoder decoder;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_ahb_bus_configuration cfg_snapshot;

  /** BUS info */
  svt_ahb_bus_status bus_status;
  
  /** @endcond */


  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this ENV. */
  local svt_ahb_bus_configuration cfg;

  
  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_ahb_bus_env)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new ENV instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_ahb_bus_env", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the sub-agent components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase:
   * Connects the virtual sequencer to the sub-sequencers
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

    // ---------------------------------------------------------------------------
  /**
   * Run Phase:
   * Arbiter, decoder functionality
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif
  
  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the ENV configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
  /** @endcond */

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g8Y6fktGw5uaiaHo/qPiqjpkc3emKQTCU21qILc2qxObA8J+NBd4OsEH+yfOaq0C
9kMjPuS8cE8XRYA+1mCy+sH/LTuRxoId601JCo3GYNpbW6wxsotINipYBur5wiPJ
LfJ7f+3178gr0jMF/smtWGuUEDf67dDEGGUplmSikCg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 355       )
8FDx3CureuMtcJ/PcazEHDl+UTvqxhFaU2ldSlm33kG6CnxxI2t62IFBvME8PEpC
RIiSuYkjQAL8i5FaDfrMhiaeFtK/9YKGiZQdAdZfavl4mmDMcME2OVwLKtxjP0wa
kGnnkigItg2nvVFdckT+JliMrACY+JHF0HPDyFfByOPThkjueI6u5xXjC1DVibFz
BVywckJhcJGfEN0WOQRQnF41urMyVM/YMsFbBU2ImPrl5zNW6UDu8fpGl2M2XyoV
PZ1IPrhzKvmV8hs4bo28q73uWVPQu5F+FIi6GTcj4KtvkryZCc3kt0o2HH1bzSs6
34u6VkpE5M7eXbPa76Y0Pf93V4eZdv+2qSy7jLUAhaO3p/LMpPTb9xTESSo32RGq
NTEMZMS6WOUvWlfwEWHT4LW1sbttmsJ50c09QAVx73DlVOfTAP7gAOYWhqxSwN/O
ga2IFJvBVWRJHtHcoysFxQjMUUN9806aUhZ7llH0vws=
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mZBgRGtT5p+o7bm3g1C8zs2Vuxsr2Kiu+qZpez4mAmdpJYZBfn0GPCC70GWBnwMK
DccrO9BimQERvSc0mlbwmcevO0B2D061rXXMfkknu1v5i2p5u+uQYy0ihcNyZHmt
XYVSbpY6AwV0wyaR4KOosDc2bzc7kk6rCQzVmeDxrVM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7150      )
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
`pragma protect end_protected

`endif // GUARD_SVT_AHB_BUS_ENV_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gr1oDIiH6qlgB8TWgAH/5FCYbKBjF6qv22MpoMlBPpa0HmbxRtz/kyE1eS/IOYtp
4Bsy5al/6o5KY7FcW/3z0Cb0CKptznuUokYu129n1d+rhhxh1BneNDcgB+3JZjYM
40vPzXTTmW6MIqZ0zfoF5rdBPlzTtoUxFiBW5CcG5WQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7233      )
bvnCxxHWpKyh1Ptv3mka5dNX/HRDlKiqWw2BBRQjvcl0XxZ/d/863prIbj6x7lNc
aThcAIgOUAsZfkBogzZWm2wSo7EiQAteR94F1M5KBj22zHZTfYmqf5PcnugMFUZz
`pragma protect end_protected
