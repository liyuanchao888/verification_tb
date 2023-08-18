//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_sn_transaction_sequencer;
typedef class svt_chi_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_sn_transaction responses
 */
class svt_chi_sn_transaction_sequencer extends svt_sequencer#(svt_chi_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Analysis port for completed transactions reported by the monitor */
  `SVT_XVM(analysis_imp) #(svt_chi_transaction, svt_chi_sn_transaction_sequencer) ap;

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rrn0ibMlZIHwfU0Qrlc6W+O2qk9HGatFXn5TVqQ2+SxFIXapmk+kOA4L2RYAMpPb
Z3DkHZsrsojL3Q2JCDQY1OLXT5OZRSeYkuJCjrgOdse04ZjCmjSMIEUhh6j36dqM
osVRe+X+VjWxcQqSNPUcL1gGQYuSV5SXv9rr2PEvEoaONO8CyMRjKA==
//pragma protect end_key_block
//pragma protect digest_block
uVSXLyFYXrOZPt6opImhDFt0NDQ=
//pragma protect end_digest_block
//pragma protect data_block
e/pMxXf7cn/zb4mnn/Di5xaGBGsW+BhnlH68Hf02vnz4IOyRaSTZlmZmGRIwCoer
8HbBLzBnoISBIyuJeTAF9/adckkB17VRzYjGFrssNbB9XCMxQMQRKE7wj7kmnYQS
i8ZdQTOGz66oMlyvxBFhXhkHVSYThRsKqwqmx9hi2MaYe7ICm67ddItyjkSFhzsj
E4TdiftOvLal3xh80NEgjjtlSRBpkLQCpGEvUzWWpx45DloF0PY4vf3R5wufBA75
mQmUaTJCpb5ikA+IuAQ4LYdx6lXXf8tptkt/85eKgEhdLJx9hHt1PuSDbsgR4+c8
OFRFWt37wi+/mOOwh/A+eRuPAAN+y0ctoVDkDoVnM8ILqJYqFVMPMsWv+BnEbYO4
uqGO+9ZGg3qhhu1g51xZWwcFcigcz6KXMyu0rYicemamtjJlO9Za0HNwxMHNU/ud
kOFPGHnrW6CPKnh8ixg0xBUYkVUzwLsIRc0zilpafdDtcEOY+g7Gh82cUYX5CGvZ
ais3gGn+krHMkzIUgIDHulKzFrUDCoFHPKiY6b4de1e9I3U76DD88Jo4/mcXLkW9
CxrMLOla6gsFCmuzqkBUPjSwHyl4+b/hvKaPpsSPZhXRfQTJCDHkK2bTcRX4ui34
1gB0t6GBUvbtTyDiPJsiJlpMbCobfiorqeKMJrhx2jo=
//pragma protect end_data_block
//pragma protect digest_block
9LU8ls+hFtEJXTgY9LcFUsSOlzA=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_sn_transaction_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_UC(ALL_ON)|`SVT_XVM_UC(REFERENCE))
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
 extern function new (string name, `SVT_XVM(component) parent);

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

endclass: svt_chi_sn_transaction_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
vw8eh9UZhHAUecPK0jDLkDOemn9b60OknCHiSW0D9Z7hT6YfhPYrk+0dyg1B3HUd
wYAghRHr8Ytka4ddMGQdsm0G2dIgfFvFsfCLIDcpPoSur3HzniIh1bfXg824uPR1
AC2/B2l4CUKy3GGK/2It+0spIOIIdmGWDdMiFo7lpKplpUBvQmSkqA==
//pragma protect end_key_block
//pragma protect digest_block
2cJcHNeAm1anfRje6i8YWAz5xXM=
//pragma protect end_digest_block
//pragma protect data_block
ILr7vCFfxKgVMDzSxiDKhJTo9r8wmuEeWc2Q6EQWzQjQB8+l30RbHPhd5KjavdaM
TrbnJ0oGT9KrZNsWlppBiQZO8FInvoqUgK9pSZeHcEhjl8zbAjycUAehJQfdjQdE
B60dbbrN+rpdhoEPuW9/zsgrOU4Ln9gE8W6AT8VBzLbpmgq/+/QnwvQEVigR9cvB
shT3y2EFJKJ+eDg9Pm/lEF7mdTEl4MdJLc3jBEa4bw1a+4uAh5+sLhMWPvm4FT56
EaITBs/NgEEcrcMY/iPuCLzOKVtxRxg9EyYaYm9trcP5pcjaLrGbI0LXNTLP98xj
xlgoFriOvlfxhx3powDnHiBwy61R/Sf+Ta9ndNLQRAvwmKoAY2mHjmLXR8G/vEP8
91Wk8nhCshnEbktZR6n6SdkEJKVKFapetOuwifo+d7cpJfzhurKN62JwQHKFbezB
o/aV33y3VjJmU4RlO58VfGgAQFGX9Wb+xCTfySxANBPO6+7DVm07wlqmk2bMuwlw
EMCWLioelaJ1SFcDTHPkTb+14utiwakCmwAd9NysztJhGSwHHbbuhNHw9LQniqb0
3ehU5Ijg43fWKFET+EMZVrroutyUE+MO3VNLtuzH8/Unp4aKpEZRByPKm+TRlFx6
odhRsedT5+BXIo/65Rf6bPhvVnA9xx6rPXpbTQQIlh/U8p44IWkdLvKrkJwvBsb8
+oeqLHXNKUK7BJej2p1EriMjsvt+ilQbl7e1nntIS5YPbv5VWOUyTibTPT5sREaq
KqDP9D4qGh4I7sbFiutlSGW82f4QcDbFTfCzM7Q3geY=
//pragma protect end_data_block
//pragma protect digest_block
NJYzITjy7e1Rx8OT1Qlwkz0qdxc=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KHQI7pEZeQn96SAh91F+VI8/oq+qCNI+MxQ135+dm+/RVhhu9XJ2nXwDPwRmaWms
4xov/bB6/VIwq0BF8Mf1AmtyPoBlGJwn5hfEWBhaJ+RztuSB5Gqab8Byf2m7xiwd
07LP6XQ9TIcbz3R3aFbG+2hTM9oyzdLDPi7lrJX9gKIzUcZ2Reo0VA==
//pragma protect end_key_block
//pragma protect digest_block
wOjuBmKbVveU+TI85zUSV9MdI0Q=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
eMwDoettE3yG3phdZXGYv8afkt4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_SN_TRANSACTION_SEQUENCER_SV

