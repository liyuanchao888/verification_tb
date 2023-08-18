
`ifndef GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
`define GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV 

// =============================================================================
/**
 * This class is UVM Snoop Sequencer that provides stimulus for the
 * #svt_axi_slave_driver class. The #svt_axi_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_axi_slave_snoop_sequencer extends svt_sequencer #(svt_axi_ic_snoop_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Tlm port for peeking the observed response requests. */
`ifdef SVT_UVM_TECHNOLOGY
  uvm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_peek_port#(svt_axi_ic_snoop_transaction) snoop_request_port;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  // ****************************************************************************

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Slave configuration */
  local svt_axi_port_configuration cfg;

  /** @endcond */

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils(svt_axi_slave_snoop_sequencer)

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this instance.  Used to construct
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
 extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
 extern function void build();
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

endclass: svt_axi_slave_snoop_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rfPwoIa9imApzrftWr1LfoCdqLM1/BWmGTX7gnE6Tbj4F9QD6PiSsORTpT12ZP7H
eDfg2iQ1hPtIRdgm2J3SR+uFF3mlWwqA3QHrW2DMvzNGWyxwg1btmoY9slljmN7D
H50xso8AklidBENCfte4CPyfvCV8hgNZKaOXHyMxE4P2XPJqzEVFIA==
//pragma protect end_key_block
//pragma protect digest_block
m78WIXthp+UCkFNO5DW3QvM+x2I=
//pragma protect end_digest_block
//pragma protect data_block
abAVeH0SZKuDHOoMxP88fqwp0RNMbJpcIp9slWOk9qi56HNYm5VoPxzxZl7HwkT/
DYjJ+6gwT7alUeJ6qDnWclktmYMgEPksHJC6I+TZ0cSMpoGQgpgtfKVcmBICOTPZ
93xPVoEQUgeHhG6xlmplleSfFOcNuO4RRR/bRJxtqgYfSdia39wfVAkp/QacHKGv
dRUvKtRVU+mnTphOv8QHZsedg5PHt+WjNl4SOycqATbOs88+X/qDFC0LIlqbfMIw
hHnAspSVYISqW8f4eLXaJQwsTMrYWzc1foSmru3UukwTe6CKz1EmhL74DXET+Ymp
I59YQwXsu9QU6Nmbl5TbeKd0EvLMwdCcZX0FAsHMGOGc62qgjISIrIl+zFBgyvTS
32hhCGx1n1dmBnrqQxplAnMfRRTSj2pEOqhQydSzWJN6TkZ+Xq0NEZKj6I3yA460
uqttQldTmAxYQivT73e5RgUh0YPwPT3grWOLPUZ2DJsZJQTEmSlrL496YtkuGyKx
yWcCFKPLSEboXREs08LetsSFgpuK0KvA5MuFAjUvl+0M5cW9OH2BW6kAb74mprEm
PGx3eKh5mV09rhmRFxQVfjR/BnpHFQTryZdsLm3J96YZoXaCUiSJ5O0Vfh1c9qh7
ugNXbPzBkDFJjKkatlV2zAwri3otp5TeWz52gmLVkjvXk3lDciJ664NtEJtYjMFQ
iCTpgcREmBETEVEithO54C7giBoYa1lJd1InSDVghZqq0jmhPMjCpoiFnLx78/Au
7FMY4oOfMQwx0z9eyAf2CjUkCKma7uNEo7wsJDrjqCAOP/tKj0WZ2egMsWNgBNn4
wobhUe0OhmJBEktTE8jKqIsoW2tO5ueh7KrkYOSLTRPD+JRWnFcjFpFFNLvv+mie
VaWZAfRrVU2NfSOy6NIEVy+6aV/KKH54X60I4BC9gRs=
//pragma protect end_data_block
//pragma protect digest_block
e06GWq4tcFLx55g+e+RJjuk0DVQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5RJvyImJLyPwyThhBeSPcpphSXn1Nu7YlUEtqKg2SQg/Av6oKGF1V6lGW61c+3aS
kZHgXUrzKrW/sO+1MsHdrRruBBT5C2BdEFjY6FT3Z2IMidO6Js6O/0rJ4VvR7msw
f5DNzSitPUvUYxnQta0M5xuZE7MtnchS8lM9k+NO+0aFOHitIrR77w==
//pragma protect end_key_block
//pragma protect digest_block
6F6/6FhFfNb0mEu9OvVkC6Xn4hk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
y2ZXpNtM8LWq0W9pZA2FcZ+l4lk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AXI_SLAVE_SNOOP_SEQUENCER_SV
