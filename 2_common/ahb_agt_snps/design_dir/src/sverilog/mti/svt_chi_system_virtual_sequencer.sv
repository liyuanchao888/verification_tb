//=======================================================================
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
`define GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_chi_system_virtual_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /* CHI RN Virtual sequencer */
  svt_chi_rn_virtual_sequencer rn_virt_seqr[];

  /* CHI SN sequencer */
  svt_chi_sn_virtual_sequencer sn_virt_seqr[];

`ifndef SVT_AMBA_EXCLUDE_AXI_IN_CHI_SYS_ENV
  /* AXI Master sequencer */
  svt_axi_master_sequencer master_seqr[];

  /* AXI Slave sequencer */
  svt_axi_slave_sequencer slave_seqr[];
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_chi_system_configuration cfg;

  /** status object for this sequencer. */
  svt_chi_system_status status_obj;

  // ****************************************************************************
  // Shorthand Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_chi_system_virtual_sequencer)

  extern function new(string name="svt_chi_system_virtual_sequencer", uvm_component parent=null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Pre-sizes the sequencer references
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  /**
   * Returns a reference of the sequencer's configuration object.
   */
  extern virtual function void get_status_obj(ref svt_status status_obj);

endclass: svt_chi_system_virtual_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jSATGbg3VV4vEyzU2/srxn2y1lFhRuNc8AYlu+ICJLVLBMSk1Qj4fFLrSIG4WZYx
hQDKGjQ1AI4lQWTh4Di2Qcvg4603Ute3Wk65f/LAw+HT4zb/FtY/MXF3okS+yxkw
W1TD9MZgli/Fgk/Xj03OfAMQeXTFA6zDj6JkIycQy+I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 374       )
9rcJ3DYa4fsD3skVrLc7yTVHQmkEjuRYsM6HTuv2Ga4L1vcgEgi3W/R5ncKo8qOd
c1F1WC656Ksajsr0iIK+cCAli4ngyS885h7k4kR4nTDfStHtmEjuW9zR3XNLom7R
iIJRE85GB/7ufVFe9/mHLJjXUjBwuUzFBH0F5+mTb1tZOfVMNB/fKs9tRQR/TEyv
BkDGobQRaPv6gqgodyPrSZUwZ4jGEGV2AFEU54ctj+zMVOOIMHLPz9ZPKKFvBJSN
Ln2vZ7XiPjwdTZIit62nqzNvGB+8ASNgvh8kbSwhJLnWK1mFKzZaw9g2ZPddAnb1
u4YDvpcSn/ZQhgKm/YKldPIU6FgstRSO5zy3FXHG6ZE8V2jSgsy9L3x/BJW9CAAF
vaDNW5tVM3hTXZP1rbf38qMu56RgdOSXr2rUov+74+++xy8ldUw2c+gNiDOGrDjx
/dFmpwdbeG/MhrfA/hC8k+tuqCzUN6jEnAUfYoK5mE3cYSyvU0NXDsDKJqvxY9cb
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gHa5BZl6gwvmk3pLzaFDv8NWVAbQmS3yQFBplsNqGAK0Q6pDF1+LxCD7ZQoSOL13
dbFTkPZ5BhBJxHKbnhdHgWnRUjry+0foW3j2ZeFXcpLF1lf2kWcFvg/GBF6fYk2I
qS/kpBgfwTSO8fLVfFsrHaWH7wVI5aBJJnnnzyFnLl4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2011      )
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
1rEVkjQdJBDymm35CxLssA==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_SYSTEM_VIRTUAL_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z2lpGIRFC8pVI9DOjjxX5KIR+Kx25E3LjFH21GJiIzrS3WGNcXpC19bEPw2PGfNH
UfIsnQf8twJPW6Z65TICCbQkiICM34MRACT3WF3w2JFQUW0Sb0aoydUyy3bPA1UH
JmEvkQ7ez6Sd8twxLylH/79guHwfh4//PCyGqhUX53k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2094      )
ZPgeHHhXCydGvfYbuaky2usoLuRj1XO2lrkNBpEN0uKTB26FKG8nVokhIodbYmmR
FNHCNp12LoPaqSqF9Pp0HZvo2cvlethnl9RyriTRIDMXDAoFr/zsj6lVMqHTTigA
`pragma protect end_protected
