
`ifndef GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
`define GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV

// =============================================================================
/**
 * This class is the UVM System sequencer class.  This is a virtual sequencer
 * which can be used to control all of the master and slave sequencers that are
 * in the system.
 */
class svt_ahb_system_sequencer extends svt_sequencer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /* AHB Master sequencer */
  svt_ahb_master_transaction_sequencer master_sequencer[];

  /* AHB Slave sequencer */
  svt_ahb_slave_sequencer slave_sequencer[];

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  /** Configuration object for this sequencer. */
  local svt_ahb_system_configuration cfg;

  // ****************************************************************************
  // UVM Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_ahb_system_sequencer)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON|`SVT_XVM_REFERENCE);
  `svt_xvm_component_utils_end

  extern function new(string name="svt_ahb_system_sequencer", `SVT_XVM(component) parent=null);

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
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

endclass: svt_ahb_system_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BfSKVddPA8R9HaOGpPEh7+8qMgp7y/fu+DM03jhR8o85ZwTRT+mU+/IDdkVTzI1s
h8/shRhx+WkXNk8ixlrW6OCUbYWdpTnc8ghPCHRnXYBcmkKevs7MxR3m3EP55p2M
knvMjyZ7dTb5aY2nh0Kqx6FC3wrkC2Yc1m1FQHZ2GHg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 428       )
iuacNg5duLSEeMkFqb59Bwu21dR3ipfNcgZoQcPXDy8Jg4o8jt4BAdzARZMLUmtF
F2pNh69KIdYrQcCiSOIWp9UTT93FLGoTPYMQMCFf+mw4BptPVuH8HKFvWaFve89t
jS24GsdH1/J7U6s4Vi1FMeuTIItQIZCEPrTSwMUpO4rTXahftEnemxpWRC3VkSuK
vP9uM3XHJflA0e6FOH3R70E83+niz1XZtwQj99MhNombrXmrmFHXXjnB6w4tgU1V
5UxUc2kjn6ePkSXP81GEtnPmQLzTBCVSms0r3ToMfWZVG/+B6Y04RcMlHfxTrfEU
lY0yefVCr/xHIfAtoJDCOK6a8esn0udqQEMWurLEiHOje+jKCIvpTeLb8REF+qpP
gbYRRM84ZxryrYrGGhOcAChT1l46SRePtw/Wze4I+IupgLlNrjeDhpTJiavO+cje
4hgTF4ImOJUd8NXilWdO+neomxTDjyFnrdELUXgdz05oHAGKQLj2PA9YEm2JMif9
776WU8wjmzWNlRmvwTrejaxHr/rk239q2fH/Y4N5oUmh6txx0BQonEYD8j7MKniK
`pragma protect end_protected

// -----------------------------------------------------------------------------
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NfhDVvJvedA3r4t7KahS2NpwJnYd2J57YoFGD6ggvdnJh5N1wACnnueQzAQ3lRNG
GWXE3AxGX/Ed33CiBj9+KjDgUf9lS8SqAwTyebdYamYwrT00dLFGfPoUCVQhlkiQ
LRfWwgzN9Iw6doV6erOnpZjPw8Ew803jOAg/jlCjTOM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1377      )
c9VPwz5GD7qt637zubgzwPeEJ9IrapV9C/fg2XAvZbyuy6nba+NC2V6EqWJqBWUk
u76R6vqae7gfJK4W+G6LF/G3mMH4hbpznxGdF4FBRl3j/PECubn7UDgs9rrRrlGY
ebXRM3ryR7p16TuEkh66mYVZdId0bqBgKtFwUeHhyfc3bJ7uteP/6RtKsbsxfkqm
LXbxffg5aKNIh4j3iPTo5jJU3GlZrKzGOYBJjlAJ0RBcOqOZEQB7rXxAA2/5Dr2T
1ztOzjR7UoEsM8Eugrac2c4Bf/YVZicgxiqkVt/vtxlb778BwW4cIK8f4Zt+uGHy
vMjKLsBCktuwBbNCLg4k1wIX7D7HetGAKm20JOYlwI8UveOuJInXeDLrsCfAZhTw
VdmRKKpJrniSDyBjJ5s7rCCZE/tQ0Lj+zweDp+z3B26Xo2mH2QCSkldsDGUSDa7g
qMlCOBJ++tJm7jjrMIsFgVN61SQgds1wMTx9xH5+DGSgFn2KT9EtcS2YmwWpzJJV
rwrGA7CnpP7v313D2zNuwmJivDY9JwXIypO32v+kgxT8EjXBgeNY87wUwu1WQqwh
0wuoDZWUW4PdH72RojEX/x4QidRgFoLpcgI6QDsPJVhj7NpwRA9Y6jQVQRgfJwfe
ODFQpQcELcZ0BmbwOaJn6CTeSTzVu6tuE+bWhaqXdHQ0HrMNpxP/jt2ecfLLjJs9
b54y/Z/DFsWhGiM/YVM0Vax7lRxoCeUenyM8SuO9OOMnsk10TbPhCiZTPNqgL/8s
jpa09RJmvXQ4aYnP5TLi7t2tvrlrGcAxVA9O992IUtwMrdMFoISGSV+Ke7qZ7iOy
lPae6gLbfWNEVcZ7tZinJnKauhirzSJM3xeGE7ETdozw7sINXGAbM0ae7IcJstVW
HADFsKXL+hRM3gGMG/GRe45lVBPjdFUFAQlS7Qzc1RkgYN8o3N/03MKLVcshmACa
2WV8iO+IhdtwO1XAqCdArvRByBI7sLoHM0hl99XiMbVwfrwDESvz9cUBy6Dhn0wa
qtlOXXCKBKdM78WbFT4+gS6odlLvLJqctqpvJuLh0iHrJXRGmso+oGteIgwN6tNN
JQ89bavk603JTLMbKNoRem7cWrYKFyb7fNicN5qn21lIJWO2LETfBdtg13AtjotN
zc9u6cSctmNBeVvu0sUiCB/Sj4ooL2nZbJGbuC94c9ZMfc8+rzLFhnjIVpviQgPm
13leOR8vnr6PXSmqdRyl3ltn+o03UQyZ2tsGNL3691Njh5DnllAgEoMfY/U21mZw
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Chx9qgaphvPu24T6QXjHUv3rON51UD8p0YrJORCYbF283dKfq7h/t4tUtIyZfpDV
N7Yy5B7cchyLppng1lfh0x/cR9GGQyoZpF+CKjfKJu7Deu0R/2Wt6lCIdyqhSV47
smrnLpmPlMVjcKo3vE8BZ9CeogtSj200GIFLJIYtwYA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1460      )
OIaRzMuz5ghHLcZ4zWToO0AVXiN+ItdPPdchIbLo8HQoMnvegqxPVSNSul+v1ZAw
uIlaR7oOP8vP0ZQSpvm9N9/prRPy9HZATZhd7u1Afyap1pcuC1qT+exuJHv5XXtk
`pragma protect end_protected
