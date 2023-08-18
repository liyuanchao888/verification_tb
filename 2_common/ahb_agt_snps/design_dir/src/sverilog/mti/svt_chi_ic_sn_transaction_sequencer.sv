//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
`define GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV 

typedef class svt_chi_ic_sn_transaction_sequencer;
typedef class svt_chi_ic_sn_transaction_base_sequence;

// =============================================================================
/**
 * Reactive sequencer providing svt_chi_ic_sn_transaction responses
 */
class svt_chi_ic_sn_transaction_sequencer extends svt_sequencer#(svt_chi_ic_sn_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Analysis method for completed transaction.
   * Forwards observed transaction to all running sequences.
   */
  extern virtual function void write(svt_chi_transaction observed);

  /** @cond PRIVATE */

  /**
   * Response request port
   */
  `SVT_XVM(blocking_get_port)#(svt_chi_ic_sn_transaction) response_request_port;

  /** Currently running sequence */
  svt_chi_ic_sn_transaction_base_sequence m_running_seq;

  /** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** @cond PRIVATE */
  /** Configuration object for this transactor. */
  local svt_chi_node_configuration cfg;
  /** @endcond */

  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_chi_ic_sn_transaction_sequencer)
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

endclass: svt_chi_ic_sn_transaction_sequencer

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Fr0vXsVcS7jNtdigioRANinAg8BmKPWEnc6GQDAOa0oUKqA8dg9dRe7axhciGgGx
TDimpqJJ9aCs0PlEPAFgd4huoT1S5yAzkXT9bU4q2jg1qye0RKYNIHAp7aGZ6riE
/1Ksr/HgZdv/ZsichwvkxnbMSsdW2GLUDrKn0Y8XbBc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 410       )
pXB8hCmfBC2DqEM5TGpi6xLetKLCYwK90UsnCqGdPwUYCIsQRsjDC9D8EXShUNM4
Z813qHml1UPh0xAdiB+wR/MC0zxrD7W5dyQ8F9ZV5vXw6QVS5wPUfS9KIWN58FTw
DU8UQhSmFjgFZ4SUEZYWiWg3gd6wUHwO+mkKOjAUaUj0JNe0ba8cuHWEbHHVgFpK
T/jcylH/EKIjmm+60+uenlVCJbXK8FYUxyFOPhcB18sh3rqniJRKzgD0c7h19RAk
dOWBZ5+ln/eAbXqBtNXq94SDM2nZuAg4tVYk2B4HJ6grrqBo9B2Zi9nq4brzU9Dy
Q8ZI6Sxn19uvoaIJkvJAjLRpqpJK5jjHXDUFSvg9niNYO9cbC7OaDIyj3bLMj9RD
iCSume95GIphS1FxsWRtSO/JmCIcELVVVJgPZG+89D/6k2ifrP8r2Vw0bSPcozs5
433XjKFyFmlHRLWJl9+Zvy0WZkesWNuPrIvUhrAkomwvAbJj1kdoABZZAU9/Gk0j
tt6/dQKN7TcuadQ7v1/mDxl+vyZa3gT1MgCod1sPuVs=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q4wp3A7ffONaR3/jR5ukSa2r1SezoPEirC8QnCi9XNIYViczVI5yG3dF38R30qpn
lmOOGfKyG+266jd5WOB5sCS1qQln/kjXPpzqQ/Vn13ryzxgLNEdK7wS0dfWSbLRF
WONXl9t0qGNWzu0oCfAbLtErLkoDjrHQMTAS6CuhyCo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2546      )
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
`pragma protect end_protected

`endif // GUARD_CHI_IC_SN_TRANSACTION_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SduZ1vYb7S6DBJKIkdLU5ib835/fPKl5Q5i/WVH7sTCWkxwLCjCz4jB+ulNZvZUk
wSJsVQN0TvWzUyDyL7gXLekKkMvIdXNi0XgdZZZwK9NgUqd29jbPB+F5pZ8nFoUd
hUxs/0ximv6TjU05Ytt0AxnCTSENPsWCjYUSlEpObWM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2629      )
erEHKFh8gb4e3hOa0kU0pImVdTXqnDKzy+FISsKqS7AfWVaDfaBhGupivYbTsmWG
GRRPRE6Rg43ouoho9kkdc9/4jyayO37s/3YgLLUI0Zti3G3saKAf8/SXBZsd6/3+
`pragma protect end_protected
