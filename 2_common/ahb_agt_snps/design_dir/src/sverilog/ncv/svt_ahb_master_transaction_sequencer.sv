
`ifndef GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV
`define GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV 

`ifdef SVT_UVM_TECHNOLOGY
typedef class svt_ahb_master_transaction_sequencer;
typedef class svt_ahb_master_transaction_sequencer_callback;
typedef uvm_callbacks#(svt_ahb_master_transaction_sequencer,svt_ahb_master_transaction_sequencer_callback) svt_ahb_master_transaction_sequencer_callback_pool;


/**
  * Master sequencer callback class contains the callback methods called by
  * the master sequencer component.
  * Currently, this class has callbacks issued when a TLM GP transaction is
  * converted to an AHB transaction by the sequence. The user may access these
  * callbacks to see how a TLM GP transaction got converted to AHB
  * transaction(s).
  */

class svt_ahb_master_transaction_sequencer_callback extends svt_uvm_callback;

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
  extern function new(string name = "svt_ahb_master_transaction_sequencer_callback");

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
J/xbVr8QF0lOze/Ravroi6qaTUYMo1r50UjsBxMl2efMJ3bt9txEh+v4ggWmvdOY
AOkQcOW+omZ6TMVPZIPGP81oK7eGXDrb3s3CAEzqjygq/hAb57WG0XpYErOgXXIL
xMjj9dCLVfijhUCd+Sfb6YsdWOPWOzsmxsvLOHD8qw3oE6XaoyLm8w==
//pragma protect end_key_block
//pragma protect digest_block
Co2o4sOYRoosIJYv3OOaMW4C6UM=
//pragma protect end_digest_block
//pragma protect data_block
R0aPdVFmPVTzAOQQp2zRrd38LSDzIjnrE4n7C+JFxpvKtwAmn6XweNVxT4umIkRA
+FaW4G8SjdjHKsmoQkAWVxVco/QKivbEdWK3/uOhI7Oo+R3Rxf0R5GZSrV7EWg4i
D9Ahj1ZJeZcsaIDx3TCDY/lWAS1EF8/Qs7Clb+Pu0Twoq6XwGmm6dMLXNRw3Kry4
fmujYiFfCHLJt6WDtP9MjruXXPV4InKMz7KWtL7U0Z9aKc0ZukSQ2q+nqH9UJPgL
+ywI+WLe5c/U/GUlO/9HbfVINhMjDpVTl5LoLP/PE1OrWTDfVvbrm9zy+VAoqG3v
4MrRoMQ/psiU5z1CZbFXH8Bx6s9lPTFe/J5KnfwGVG5C/ZGlJ1EKZjNMQkm5K5Xp
1s76ULekfI7WQ1zkTc4iy1vYmB2tNumiuCIs+sOXgnrAMcERmE/aA6tJW9PagGt3
KCSK8AiMuTkfEMwUSpowuspQdLRWzt05Hw6QXEBzSD4v949/lzFrW0zhsNAewuOr
YvL55N/AqsRvUx2QnoMqQ2RvtajQtL4owVLMvFpgCKn9oDImtzoJvH4xxxrGd6vU
2lzjGVaRGiS4LbG4498EuTkCZPjaple4kMC29+MDQv1BbnZSeMucRt249vK9L2o3
x/c2NtlvJKBxjNt0U+wDh2bQeNZqJ/VhYOgsRl8i0TLcMzGTEPRpnjPuGCKR6L9K
Ph7bweUrOTX5AZMK/neUn38vx7iJF9lzdmygHeHPr/0KfRkwZcJ3hqn1yG4A869j
wqICvVJC7jcFB03jAcC6LNmLDiC2M3KFLB8tkYDgBtP9A+Hs7t6hea1opTBsn8Z+
ES3dM5o4TAZM2fqNF/TZOMU4Wf6OYInudb3pBATzEzLhKozdb49Xu4YvxZTM+8Fx
E/g/xxdlocktZM74rVFCWUKwYJWubietzYkstS/cWsunSb1XQ4HJsMX4RlGyr74P
qkJFjwWxxMYr2MnVgIwLR5FnWYXy2zUPIsylpXQc1AXlp9Wr+yJT0yOogTAAXD9v
P/x6cr3jiwpMR2ggiXWLo+69iJ7XPDhbIzpDWkGm8gx5kl4xeMVeKv4I7+7Je2FY
f+M2022O60q8yXYPhXkz5EefwzxQS6BV4upX3iFgkauZRvB2EKZ8sXZoH29Y8LLR
OxmuGFnzR7U6iuIn9p0c3U+FbvDHNSG2h9WxxkpyNOqMSpW0QUx3SBOFvz78IbCO
EPPet3nMzxkTCrZDZ3EpOV4bQ5XIQl+3afPohbGfnHnCG8AmyclUCSbMbLGe7b21
PnJU/ZRSDHBe31WR5l483GXf3OLfIyWn48IL5Zn0//JvwNXVLhvraCGJ5K9QWh4v
TDvt5A/e64BJZ+SvozK83rhp4k6HAn00hSNtTkw49r/DT4zjRDwDIo8p49rfh+C7
N27KD1Q/n/BgNbqbLUESWswNklLIAi4+S2bLAf38gF61XrJ0tRjKSmPXHA6X+cN4
XUYepWMnfdFTbcSr/IRyXJsRXL3plC+rKp+lf+A8ot2FscrQZlh0INgm4VuiUCQN
ugDyGX1WtWae64UsbZ7Mbf330xvDgjNEU+L1VdNsi10ENkWJJB7MHkgm7JsLv1lo
vVmsnWlGwzO5pSxId8ESrxeDCtVgAERpwR/KftPWyZTuPMhuoKYRXbB6cu1pyvyC
roBfGKw8j3s2kTOdHWTJWXOg1BNIvXYOJZAF0JZhodpG112fflEtNVCSchuvzdFY
zoyXopfKPfmHlosxrSfEnf0+BGlxnMSuBs++h0cEZyohOiel5pPhh+Gm3vsOVYC5
/NCWh8bgRlchrq+iHhL29g==
//pragma protect end_data_block
//pragma protect digest_block
yAOY7/TUTZzVTGbCo812lx3Nje0=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

`endif

// =============================================================================
/**
 * This class is UVM Sequencer that provides stimulus for the
 * #svt_ahb_master_driver class. The #svt_ahb_master_agent class is responsible
 * for connecting this sequencer to the driver if the agent is configured as
 * UVM_ACTIVE.
 */
class svt_ahb_master_transaction_sequencer extends svt_sequencer#(svt_ahb_master_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  svt_ahb_master_transaction vlog_cmd_xact;

`ifdef SVT_UVM_TECHNOLOGY
  uvm_seq_item_pull_port #(uvm_tlm_generic_payload) tlm_gp_seq_item_port;
  uvm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
  uvm_analysis_port #(uvm_tlm_generic_payload) tlm_gp_rsp_port;

`elsif SVT_OVM_TECHNOLOGY
  ovm_blocking_put_imp #(svt_ahb_master_transaction,svt_ahb_master_transaction_sequencer) vlog_cmd_put_export;
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
  local svt_ahb_master_configuration cfg;
  /** @endcond */

  // UVM Field Macros
  // ****************************************************************************
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `uvm_field_object(cfg, UVM_ALL_ON|UVM_REFERENCE)
  `uvm_component_utils_end
`elsif SVT_OVM_TECHNOLOGY
  `ovm_component_utils_begin(svt_ahb_master_transaction_sequencer)
    `ovm_field_object(cfg, OVM_ALL_ON|OVM_REFERENCE)
  `ovm_component_utils_end
`endif

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
 extern function new (string name = "svt_ahb_master_transaction_sequencer", uvm_component parent = null);
`elsif SVT_OVM_TECHNOLOGY
 extern function new (string name = "svt_ahb_master_transaction_sequencer", ovm_component parent = null);
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
  extern  virtual  task put(input svt_ahb_master_transaction t);

endclass: svt_ahb_master_transaction_sequencer

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YvUX6h60YcKWQvsMgqs8EHA3Y7XYz+OEHJCzRad+kJF2TJJ7TeCXVNPr+kBlgqoU
1ZjtWpnFdllu2lNmyCrMUPw1sSfkqYCTUxcxQFkztNZFhBENoKqDXQHhSewKew7d
Wxf2+HrJXXEF2Yzu9WtEAj/LnjFtGT9LPecyO0UrFB4V99S6bG19Dw==
//pragma protect end_key_block
//pragma protect digest_block
7vfVk02q62e9n8RSRa/jZF31aEg=
//pragma protect end_digest_block
//pragma protect data_block
s4Mir5iS2DJqKLoJqlA4nNRPaT+G3yRamRyB856130piL0UJd1OCclbMxuYegagw
T0Q6GeW92Xv2OWGM7Gb3lSUxiJ4UBq0upa3LS5clEnXaVnJMyKYYSsBTCqBE4H5d
s3B7PXTxgCOQtujikA1u1U9v2KShRigm+A9IhAU5LNIqOKQeJfnp5+EJiC/UknJ6
+L9rRhiCTwQc7fQwpvtrMjKstaA17/hEGahySfMVuQEElI6WvtizqPKEMwA7LFTj
GUeLnenwinH20jgr0wOlkFxedOpswtKA0ZlIj6oSWY7G75Xk72geU4c0C6IN818k
L8mKgiOZszb3CObgSQczq4gtQQGF1P8G+ewVY2uNZOmMbAksocPFKh2GGc48twXS
WFTf2ld/G3k6Gmnp1kQzHkmz+dl64o7l07f0mVS5zaQsLuNWoBTeXuv71og/VDnZ
6lKkew8OU4ISk8BNndHtDcKmVinf2RiOiJfo/rcy6OvsuO++76r57gcIEzD8MtPF
iblb2mGAsRob0gnIJxngmgMKk7sY3TjOzepsmZ/rv3tvHiOfMwZKNVjgtX0Zli/V
91iCSwuZ+DSg5jPfX/jrcMOJ4cB3rgegvJn6ZGwU98JJdBQShOarYTcXTETwgZCq
v+prpLvQz62wkSdhRwXOq+CXlJ8jBNzls/neirVwuY9YuTiQAAbBcY+uZ2p/7DYS
Uwpg9HSXFvu+90UeERjtyHu1QnnqVDWKRedLA6M3qxh/z1R4AgQbnbvN5qe/OuVx
J6vpiPUw/dGJx7fglnC4LdR4wjzv42TKwWI2Wu2lEiwHl9YiLsHK2f/BFM0AaD1v
J/gTjllc27ElcUaGilJwoE3a5S3y8ynscB8wNhdvAM1rJYmDlHq/15LVvPtjAIie
+g8gVATz/sYB7++Qn0asBeFWuGIMYYg2zdwa/b4c1miPe285StcuLzoEE5WKhZal
8TXEk+aZaHBI5sc+k8tbP/yigY9Kzrnv2rujBtFu9Wzb1tuK9DeTwQfSxN1abELA
SGlajt/PsdqrtrPevYzeeMCXj0/QqbgQxM+8hjn5rl1R590DqTea31+engneNRO3
FXExx5eP+nPtDJ0at0UDDvy0DknzyCipgmhSS81xQUXYeHkHkYkYr8oPsq0dXdrl
pGbNTUBJ307YH8iWLccZRlIhRYwhcKPAUWDGq2oAUVyaZiA9YcfvxZNJ97yiHH7o
j2kHd+36lchDv8vHlJWCpyDfo60oSD3uOsgObp4N3Z5W4hGBe2K24FY7RpgAsXF6
KXdosDH4NuXirDHyOW1czIV1LcU4CIMEEidHW8ya1u3l2ipyGnss0MqC1gybub5e
CmmH9sU6k9Bxt9G++Sga8mmm+NJCCY4ujfOrOztK7h9wYymA6DEMWfAdd9NbPh8W
Ul7slB8Zm3GIesdsPZrKXCDGZqMJvfoK+qSYL+QnpCYDcUWv+0Qe2gmqGRl4wru7
Xs6jK7xhXflhN5odIUxlWEtZrBoVQS2mSeaXYkDKs71jP0DHBrc3wMyUn5yrFJvU
oo6c5CrcXbhIyw9GLb67Po0IK8Lj/Dlb+xjYSwZ89prIo3UEAXrYLzb8duw5Dvyj
6t310AMJw9uG4uuLWgDrMU14BOoMNxuZfCa2Yyp5vcLhEeT5E44dXmGEqKW6Giza

//pragma protect end_data_block
//pragma protect digest_block
ipSCGe6RuRAS4ndUB3+4rVLp0Rg=
//pragma protect end_digest_block
//pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F+yVbMuPo5w3M0WiRdee78WQ8Fl+g07ulm9yKSIluif70W97vz0OPTdQbsi0Nnfp
qAnpejPGmWiN8dKYW241ZOe1VhMovaWoUcRRVUAs0UZB01GicBKQ2ynwGpHEmquw
Dc2IXs8bnhD5/9I66hu4FC8GUfg3AYBUJf8Pch3uVb38Ml84OpdKlQ==
//pragma protect end_key_block
//pragma protect digest_block
mu/bVlC5qugunVKT+E/6KNsvy0Y=
//pragma protect end_digest_block
//pragma protect data_block
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
qmQ7kBXiYeK5I43LAEMSvQ==
//pragma protect end_data_block
//pragma protect digest_block
xL+9SuzNY2RHHB47KNJKctLMD6c=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_AHB_MASTER_TRANSACTION_SEQUENCER_SV

