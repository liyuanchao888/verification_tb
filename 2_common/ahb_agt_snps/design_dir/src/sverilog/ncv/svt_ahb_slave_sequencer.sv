
`ifndef GUARD_SVT_AHB_SLAVE_SEQUENCER_SV
`define GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

//typedef class svt_ahb_slave_agent;
typedef class svt_ahb_slave_transaction;
typedef class svt_ahb_slave_configuration;

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_slave driver class. The #svt_svt_ahb_slave_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_slave_sequencer extends svt_sequencer#(svt_ahb_slave_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  `SVT_XVM(event_pool) event_pool;
  `SVT_XVM(event) apply_data_ready;
  /** @endcond */

  /** Tlm port for peeking the observed response requests. */
  `SVT_XVM(blocking_peek_port)#(svt_ahb_slave_transaction) response_request_port;

  /** @cond PRIVATE */
  `SVT_XVM(blocking_put_imp)#(svt_ahb_slave_transaction,svt_ahb_slave_sequencer) vlog_cmd_put_export;
  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_ahb_slave_configuration cfg;

  svt_ahb_slave_transaction vlog_cmd_xact;
/** @endcond */

  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_slave_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

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
 extern function new (string name = "svt_ahb_slave_sequencer", `SVT_XVM(component) parent = null);

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
  /** @cond PRIVATE */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  /** @endcond */

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * VLOG HDL CMD TLM port's put interface declaration.
   * NOTE:
   * To be added 
   */
  extern  virtual task put(input svt_ahb_slave_transaction t);

endclass: svt_ahb_slave_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1cogzXRNBH1ExgxZJI1iI7u/MUHkicUOx5Xs+Zn5iesEs7RJYXQV8Mr+hJ9WxhMo
TbY8OBkuPDM7cZ49MKHmAfXD947DKuIoKJybdILZUL5K5i8qbQTJYIalTdodTP32
1ya/K9UTpWJNVQdhldzL0dAMnk9odYDwwBNk/J2WZx1d9gTdRKRUgQ==
//pragma protect end_key_block
//pragma protect digest_block
KqS6ExGzo0Rl7+sDv311pKh49V4=
//pragma protect end_digest_block
//pragma protect data_block
4PB00iAnNxIDRYNvoHMI1lyS41+UQcLOg70jf0dRrq8FAzi56gF6jmUJrcwWnuaG
OhDtPtjuCmAqCovsUDKPZsiQRnJZW0juzhZd9BevO2lWVxUBXfBwFJ15CMqeFDQQ
UkYQ2I+5+AqntfiwAKPaELsKNbJh8R5W1XQG9MpgiGDDrYzZ9mZGkjx0bnzcaQzR
/6pyEo9qfbySKLOklKkpQbA7d2IUmkMM2Zx7ULxF0mekSiTGEfUd/OKiOqBTyLHz
c7jIf7HQSM+TBWNmYx6gW/wzX+KYsUDx0Vbc79A+PIQWjSDWWfngoN9h05H5MZaV
Vdw3UbLe69rJWfu1T7N/LhnNYONOb+dPmUbYlUmpDdWVEjLL7GTYRDYZkuM30BHt
F6WwvZTxpgwVb6Pfrodiss7RLCMvJczzfPVW/VHr9YdVpAL30hxe1znCh40Y2jRO
G03p8qPkXHZjQcxFEW1B/HZmz+lUEsGr9kA+L46NDTSs88XmZLq84oDcSB5b4qXl
wz3dfQ4+h5rVvYGn+JGKSd+iqUSyWVPekWoU7P3HlT7+DMHq1efcxzprevOW18NI
ZpHW71nMb5tDkrVlXLvOjbqOxERSIvlOibuYmcX0dXVgEQK5zNxLeslVV+mvHU86
cTATEoSG5Rsi/JONx0+CtX3PAUIK0EoMEOu/WEj6eteAOua2L2LlXe62yIawoZ7Z
8AOnoz/WGUuaTWrw3aUvWhw/3fES4P8bJeKG3FjDZ1EXWmunvpFsvFGn2vJj1vAq
djazTGsWRZty0v2+PqyU7WQfYEoRY8AZRX8F2GdhqPFj625d+c8z94M2O9dphvel
sChcqvfEfXs2lFE4ETdZtLCkMAgG6fX5zmhbqatTCyHO9iz1wQxCf7cSpmGRWN2m
qvcEdJLtir16fyOCuDYrKw==
//pragma protect end_data_block
//pragma protect digest_block
Hllgi5IZCcBdgDbrFZtTAmESs/A=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
9+Xy6BsqSFz4k1jj5HgTLim9AtjP+SbLekK1yw8L+ppP4N9+XeDWFI0rbO8WlpMS
Xh3mChuKIJEuFO3q3jAOjMO1XUPfMY83j/3JurMXSiaWOpMYGcteAv/VrNHIkmGW
N4tPU0vIoknEcydQVND3y9egJ7GOMhNFjCOY6Gu8IZnC/RxFcs23eg==
//pragma protect end_key_block
//pragma protect digest_block
bgCtBHSUD4mX1AOoIiZMFXvZxJw=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
4oDZYMJ/JffJNvZoZY0LHjkOt1c=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AHB_SLAVE_SEQUENCER_SV

