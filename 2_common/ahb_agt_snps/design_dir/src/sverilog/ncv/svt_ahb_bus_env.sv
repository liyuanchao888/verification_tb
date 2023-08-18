
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XQ/FVPNh7Iwn3pKZQ2GHG5jCb0y8SnVk+chwyB0uhacQ2epXsq8RoR5qdfYd8UZh
4AQo+60YLy+nYUQCMBlgJhwpIeooLxSkjA8TFYlpzEDL44ATq4fqnMIVhHsEe6v8
dXqSI1rhVZ+tcgUpONOdpv8XRIjISj8elLIgg2iDvMqdPnz+RRgVYg==
//pragma protect end_key_block
//pragma protect digest_block
vmihrWCVSZwYzXTxfaA91ZIEzoc=
//pragma protect end_digest_block
//pragma protect data_block
hAmTA6xWIna9D01EU7URd+fi3MrVp/VLO10wdieY8DKJJtMiqtJWGCW5cRA8Q5hq
/ZRk6ljsacOSAV8vOiCNPERR2oPyhuGRYCxZzcAEn9BleFq2BOnS9+LozSjBtNNd
nZB9XpsF/9BoowEAVZFh6A54ip4GmfkL9MwZKRqOfklUwi6BBaR/HkwQj8AJDBFt
69H55rGa3o6zwB+9ZFlOm+gxOcCpPUFgNtwDVmQpTpK9yEjgyKY5JTaqssPT8LEO
SXHK2qnmQEKPL9CoRbFJD7EGTfft5E3jkVE7ub8syWiGFbIRwZGEdvETIJPHPjM4
GOZW2u6Pb79O8u8r1/+OfTUBY8X/q23KfUgnV3V9yPjGgltsvMX5EDF8+vXmk0p1
88YDGZaRWRoNuZ1faNx/jFXG/SurhijfTBHExfy2UugahAKjfVO1X975sn7EYFD8
yifaHgxwCcc2IamWnKa9NzhhxZ9LfPUYwmv6ZxjcXvb6Alysb+XscBXshfeFuXM6
8lzbCxaeDsILv5s8eCfCvY8vwVSvC/ff/4edUdH52TPBgsoo8km4pE1ulkS2BSPi
kMJyMlmY1/Y3fI5eDSnTWyOf5clX0RVw1rmvXQVxbh3eB7hz+xB/8C8A05K474Ca
hweDp+gSKqtBX+TiVUcxJahlaunYTXocvBVl6tr88gQ5RSA8nxugZeRLjUdtKFc6

//pragma protect end_data_block
//pragma protect digest_block
gLpupqPznJ06Rp4YLhQexbjaVbk=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1lduFuAX6OFdD/hENY7Hsk/n5UuTW5pHhXkuQ3VDq5AnH6WHbYap7yrNwu2IRzgl
ZmVSYsR1G84PVtqPC6Rr3d9c9BAFz1vctmrV24XtcUWTTIaU0Vlwv1AIJz5mYibx
JJKbwuApmM7BR+PH7QVk9cf+MAkdJDHW9f/t73s/axqxdDZqx8jgZg==
//pragma protect end_key_block
//pragma protect digest_block
7T28FVB3ZAQJPYeB8XA7Pldbb78=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Mxuejf9QAW4XzNRI8p7lbvFi16U=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_BUS_ENV_SV
