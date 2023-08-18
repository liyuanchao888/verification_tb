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

`ifndef GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_rn_transaction_sequencer;
typedef class svt_chi_rn_transaction_base_sequence;

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_chi_rn_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_chi_rn_transaction_sequencer,svt_chi_rn_transaction_sequencer_callback) svt_chi_rn_transaction_sequencer_callback_pool;
`endif

// =============================================================================
/**
 * Sequencer providing svt_chi_rn_transaction stimulus.
 */
class svt_chi_rn_transaction_sequencer extends svt_sequencer#(svt_chi_rn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_chi_rn_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  uvm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`else
  uvm_nonblocking_get_port#(svt_chi_rn_transaction) auto_read_get_port;
`ifndef SVT_EXCLUDE_VCAP
  ovm_seq_item_pull_port #(svt_chi_traffic_profile_transaction) traffic_profile_seq_item_port;
`endif
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_rn_transaction_sequencer)
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

endclass: svt_chi_rn_transaction_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HdTwPzYDha832TrjcNVfCcJ8dnDHsr7HV2N15mbk+4bgxPOBgoPXCz0+GkaonUzn
8oXQgIqQmIMoMzZt1dTx0VwE/lHe3j1O3rlJiTktsqz/KYWIdf1gnmb2UuH/QBnv
b4haqFevHubqvhx7lEjBlRODgsYnzBJdn5SXIx6vdZ5xf+J9mNXsDQ==
//pragma protect end_key_block
//pragma protect digest_block
Px8B9LTVPZSgjqmo6otXnIrBRjA=
//pragma protect end_digest_block
//pragma protect data_block
3MKu9X/g6dEzVba9fTaIaouLl2GCjl2t8r7eVbiyrf0rEzKyjWC2jILz7sBHWhYC
Fg25H1DEyU1jmEgGXfGKlWYHrAJmfcZo4viHuz2DqJBNq/vFnbtlPpkY6MsU+d+O
46Yz/JXxIMz5x2eMss6QQ4Kd1svO8xjQoqnyyAtvXDd+j6REoDXKq9xEcLsN+G78
HWE9Ti9VKys0id/l9j3YX1tQMFkmtm4NBZBwcXRpQ2kAbfJgpZG3PrIuLQ3pp//P
7mCwbKmq4DN8xkd32gJfX6J+HbZnmEFoWbnVipb2e2nzJwG1fb71IkbUfS1bp5/A
GSWXdjfq4Vqzx9kA8BuD0Lm7Qn+lhLOmTLSLkoCbvD0PzEtFqGRD031q0WcSwzqK
y8OhvktpLE+8jz8DPEs0q1+j8RH+/Kd6kH0AeJnUdVt73l5j5+ubvqEIvPoMWDcp
4hL8CGt4qJZIlgKUQB9V0/bCsf4l8SDyAJrx0CC/cwc1YpjIWjyZ7AQVTQTikSo6
R4CGqoU/VPyfI/7+++TAQ11J223bzu9W9VIPbcLd9OuLGUECaplpTnhmDG/HirNt
l5mHUlE2l3uU1YeUU2HH1tpOTVRamQUDaPJeQPus2shMAqWMChylOf2FO8HK4CDr
OVsulRzHKbCXwZsOkEniwJyIq3Co0gdoqm8vIeqqKLF7x1nP+R2o2uwMytFRrAb2
XVVwGMwzKPLSKWP+SABJw5d4DmGyCXrcMAZIpEec2huz5ehtyG9j1Fq5o6CLOCVa
zKD7pWfxSgO7vZDpvzPeLvnQyd3FvXiCoc9p5G5hLCLLK/E1kFKJcdLRhf90eEuu
gbddlJmw7SYoV4Zp6F5vcPGGFPZZocKKndaelXH7z37hM8UBJCSQqM/5jb6euU01
yZwBaRzIHMraXXNUwM6P5F9MIdE1iBax+1ynig3jyDUDrqd74g1Ywg+/lmu+88D4
7G/jQl8Sdm4PxfnRW3ZyIMHL3ldrAdRjGbP700fJdGwGq6AVpPK5QHNkJ1OUcGa6
W9yPI2N8+Hugr2VTAu7p1IRNBzj059WN+xvZtyi7RJHkYs1wDZiyxXMshqAo6XMl
S1iJZRujOfi0fp9Jzd5dJvwC7Xfy+Vp+farEK/esLFU=
//pragma protect end_data_block
//pragma protect digest_block
eimvo2GWfjXhHXPEtiiaHsMECdM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
GxOo2LP5IL2AjXncG/Mi8EA1WcjbEnyMnBHJdDsKo64bZiV6tcZvr7o+v7MQoZlR
fvdbjvDeHatJ3rAlor0IJSZGqHQj1rhjIHAsSMtww+zo7YM5a7GcBiwsjVOPZBkz
gIkRSZ/DYqOsB7QeslL+xn+CbXlUgZhaye/fzp+HKT0R4f+AsrAWrQ==
//pragma protect end_key_block
//pragma protect digest_block
JT2aKUdOrZ6cUeqJTNaNCzFPnNc=
//pragma protect end_digest_block
//pragma protect data_block
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
CEpOJYFp+CbT17zXL4E5Xg==
//pragma protect end_data_block
//pragma protect digest_block
orc9tE8in171C8dzWZgNmcsZEbI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_CHI_RN_TRANSACTION_SEQUENCER_SV

